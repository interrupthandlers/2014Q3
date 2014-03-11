classdef MeggitDecoderImpl < handle
   properties (Hidden)
      decodeIteration = 0;
   end
   properties (SetAccess = private)
      g; % generator poly
      n; % codeword length
      k; % message length
      r; % received vector
      s; % syndrome vector register
      buffer; %buffer
      correctedErrors = 0;
      S; % all syndrome vectors corresponding to error patterns with 1 as highest bit
   end   
   methods(Access = public)
      function MD = MeggitDecoderImpl(g, n, k)
        MD.g = g;
        MD.n = n;
        MD.k = k;
        MD.createSyndromeVectors()
      end
      function setReceived(MD, r)
        MD.r = r;
        MD.reset()              
      end
      function reset(MD)
        MD.s = zeros(1, (MD.n-MD.k-1) + 1);
        MD.buffer = MD.r;
        MD.correctedErrors = 0;
        MD.decodeIteration = 0;
        
        for i = 0:n-1,
            gate = MD.s(end); %store msb for feedback calc
            MD.s = circshift(MD.s,[0 1]); %shift syndrom 1 right
            MD.s(1) = MD.r(MD.n-i); %shift bit from r to s

            %calc and apply feedback
            feedback = gate * MD.g;
            feedback(end) = []; %remove msb
            MD.s = mod(MD.s + feedback, 2); %add feedback to syndrom
        end
      end
      function decodeSingleStep(MD)
      end
      function decodeFullStep(MD)
      end
      function getStatus(MD)        
        if s == zeros(1, (n-k-1) + 1) %if syndrome vector is all zeroes
            %decoded correct
        else
            %uncorrectable
        end
      end
   end % methods (public)
   methods(Access = private)
      function createSyndromeVectors(MD)
        dmin = gfweight(MD.g);
        t = floor((dmin-1)/2);
        
        %calc error patterns
        if t == 1
            E = zeros(1, n);
            E(end) = 1;
        else
            error('Number of error bits not supported.')
        end
        
        H = cyclgen(n,g,'system');

        MD.S = E*H'; %calc all syndrome vectors
      end
   end % methods (private)
end % classdef