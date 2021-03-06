classdef MeggittDecoderImpl < handle
   properties (Hidden)
      synMod = 0;
   end
   properties (SetAccess = private)
      g; % generator poly
      n; % codeword length
      k; % message length
      r; % received vector
      s; % syndrome vector register
      buffer; %buffer
      correctedErrors = 0;
      decodeIteration = 0;
      S; % all syndrome vectors corresponding to error patterns with 1 as highest bit
   end   
   methods(Access = public)
      function MD = MeggittDecoderImpl(g, n, k) %constructor
        %Example generator g = 1 + X^4 + X^6 + X^7 + X^8 =      1 0 0 0 1 0 1 1 1] 
        %Example code lenngth n =                               15
        %Example message length k =                             7
        %Example statement:                                     MD = MeggittDecoderImpl(g,n,k)
        %Example output:
        %                MD = 
        %
        %          MeggittDecoderImpl with properties:
        %
        %                          g: [1 0 0 0 1 0 1 1 1]
        %                          n: 15
        %                          k: 7
        %                          r: []
        %                          s: []
        %                     buffer: []
        %            correctedErrors: 0
        %            decodeIteration: 0
        %                          S: [15x8 double]

        MD.g = g;
        MD.n = n;
        MD.k = k;
        MD.createSyndromeVectors()
      end
      function setReceived(MD, r)
        %Example received vector r = [1 1 0 1 1 1 0 1 0 0 0 1 1 0 0]
        %Example statement: MD.setReceived(r)
        %Example output:
        %                MD = 
        %
        %          MeggittDecoderImpl with properties:
        %
        %                          g: [1 0 0 0 1 0 1 1 1]
        %                          n: 15
        %                          k: 7
        %                          r: [1 1 0 1 1 1 0 1 0 0 0 1 1 0 0]
        %                          s: [0 0 1 1 1 0 0 1]
        %                     buffer: [1 1 0 1 1 1 0 1 0 0 0 1 1 0 0]
        %            correctedErrors: 0
        %            decodeIteration: 0
        %                          S: [15x8 double]
        
        MD.r = r;
        MD.calcSyndrome()              
      end
      function decodeSingleStep(MD)
          %Performs one iteration of the decoding
        if MD.IsInited() == 0
            error('Received vector is uninitialized.')
        end
          
        if MD.IsDecodingComplete()
            disp('Decoding is complete.')
            return
        end
        
        %check if the syndrome vector corresponds to an error pattern with 1 as highest bit
        if ismember(MD.s, MD.S, 'rows') %if S contains a vector equal to s
            MD.buffer(end) = mod(MD.buffer(end) + 1, 2); %correct the buffer
            MD.synMod = 1; %syndrome modification
            MD.correctedErrors = MD.correctedErrors + 1;
        else
            MD.synMod = 0;
        end
          
        gate = MD.s(end); %store msb for feedback calc
        MD.s = circshift(MD.s,[0 1]); %shift syndrom 1 right
        MD.s(1) = 0; %reset lsb to counter circshift() wrapping around
        MD.buffer = circshift(MD.buffer,[0 1]); %shift syndrom 1 right    

        %calc and apply feedback
        feedback = gate * MD.g;
        feedback(end) = []; %remove msb
        MD.s = mod(MD.s + feedback, 2); %add feedback to syndrom
        MD.s(1) = mod(MD.s(1) + MD.synMod, 2); %apply syndrome modification

        MD.decodeIteration = MD.decodeIteration + 1;
      end
      function decodeFullStep(MD)
          if MD.IsInited() == 0
              error('Received vector is uninitialized.')
          end
          
          while MD.IsDecodingComplete() == 0
              MD.decodeSingleStep();
          end
          disp('Decoding is complete.')
      end
      function [tag, desc] = getStatus(MD)        
        if MD.IsInited() == 0
            tag = 0;
            desc = 'Decoder unitialized.';
        elseif MD.IsDecodingComplete() == 0
            tag = 1;
            desc = 'Decoding...';          
        elseif MD.WasDecodingSuccesful() == 1
            %decoded correct, maybe with errors
            tag = 2;
            desc = 'Decoded correctly.';
        else
            %uncorrectable
            tag = 3;
            desc = 'Uncorrectable.';
        end
      end
      function errorVector = getErrorVector(MD)
        if MD.IsDecodingComplete() == 1 && MD.WasDecodingSuccesful() == 1
            errorVector = mod(MD.r + MD.buffer,2);
        else
            error('Decoding is not done and/or unsuccesful.')
        end
      end
      function isComplete = IsDecodingComplete(MD)
          isComplete = MD.decodeIteration >= MD.n;
      end
      function wasSuccesful = WasDecodingSuccesful(MD)
          wasSuccesful = isequal(MD.s, zeros(1, (MD.n-MD.k-1) + 1)); %if syndrome vector is all zeroes
      end
      function isInited = IsInited(MD)
          isInited = isempty(MD.r) == 0;
      end
   end % methods (public)
   methods(Access = private)
      function createSyndromeVectors(MD) 
        dmin = gfweight(MD.g);
        t = floor((dmin-1)/2);
        
        %create one bit error pattern
        E = zeros(1, MD.n);
        E(end) = 1;
      
        if t > 1
            %create 2 bit error patterns with highest bit in error
            E = eye(MD.n);
            E(:,MD.n) = 1;
        elseif t > 2
            error('Number of error bits not supported.') %2 bits needs to be supported.
        end
        
        H = cyclgen(MD.n,MD.g,'system');

        MD.S = mod(E*H',2); %calc all syndrome vectors
      end
      function calcSyndrome(MD)
        MD.s = zeros(1, (MD.n-MD.k-1) + 1);
        MD.buffer = MD.r;
        MD.correctedErrors = 0;
        MD.decodeIteration = 0;
        
        for i = 0:MD.n-1,
            gate = MD.s(end); %store msb for feedback calc
            MD.s = circshift(MD.s,[0 1]); %shift syndrom 1 right
            MD.s(1) = MD.r(MD.n-i); %shift bit from r to s

            %calc and apply feedback
            feedback = gate * MD.g;
            feedback(end) = []; %remove msb
            MD.s = mod(MD.s + feedback, 2); %add feedback to syndrom
        end
      end
   end % methods (private)
end % classdef