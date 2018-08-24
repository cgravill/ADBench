% Generated by ADiMat 0.6.0-4867
% © 2001-2008 Andre Vehreschild <vehreschild@sc.rwth-aachen.de>
% © 2009-2013 Johannes Willkomm <johannes.willkomm@sc.tu-darmstadt.de>
% RWTH Aachen University, 52056 Aachen, Germany
% TU Darmstadt, 64289 Darmstadt, Germany
% Visit us on the web at http://www.adimat.de/
% Report bugs to adimat-users@lists.sc.informatik.tu-darmstadt.de
%
%                             DISCLAIMER
% 
% ADiMat was prepared as part of an employment at the Institute for Scientific Computing,
% RWTH Aachen University, Germany and at the Institute for Scientific Computing,
% TU Darmstadt, Germany and is provided AS IS. 
% NEITHER THE AUTHOR(S), THE GOVERNMENT OF THE FEDERAL REPUBLIC OF GERMANY
% NOR ANY AGENCY THEREOF, NOR THE RWTH AACHEN UNIVERSITY, NOT THE TU DARMSTADT,
% INCLUDING ANY OF THEIR EMPLOYEES OR OFFICERS, MAKES ANY WARRANTY, EXPRESS OR IMPLIED,
% OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY FOR THE ACCURACY, COMPLETENESS,
% OR USEFULNESS OF ANY INFORMATION OR PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE
% WOULD NOT INFRINGE PRIVATELY OWNED RIGHTS.
%
% Flags: FORWARDMODE,  NOOPEROPTIM,
%   NOLOCALCSE,  NOGLOBALCSE,  NOPRESCALARFOLDING,
%   NOPOSTSCALARFOLDING,  NOCONSTFOLDMULT0,  FUNCMODE,
%   NOTMPCLEAR,  DUMP_XML,  PARSE_ONLY,
%   UNBOUND_ERROR
%
% Parameters:
%  - dependents=r
%  - independents=p
%  - inputEncoding=ISO-8859-1
%  - output-mode: plain
%  - output-file: ad_out/d_adimat_norm2_i2.m
%  - output-file-prefix: 
%  - output-directory: ad_out
% Generated by ADiMat 0.6.0-4867
% © 2001-2008 Andre Vehreschild <vehreschild@sc.rwth-aachen.de>
% © 2009-2013 Johannes Willkomm <johannes.willkomm@sc.tu-darmstadt.de>
% RWTH Aachen University, 52056 Aachen, Germany
% TU Darmstadt, 64289 Darmstadt, Germany
% Visit us on the web at http://www.adimat.de/
% Report bugs to adimat-users@lists.sc.informatik.tu-darmstadt.de
%
%                             DISCLAIMER
% 
% ADiMat was prepared as part of an employment at the Institute for Scientific Computing,
% RWTH Aachen University, Germany and at the Institute for Scientific Computing,
% TU Darmstadt, Germany and is provided AS IS. 
% NEITHER THE AUTHOR(S), THE GOVERNMENT OF THE FEDERAL REPUBLIC OF GERMANY
% NOR ANY AGENCY THEREOF, NOR THE RWTH AACHEN UNIVERSITY, NOT THE TU DARMSTADT,
% INCLUDING ANY OF THEIR EMPLOYEES OR OFFICERS, MAKES ANY WARRANTY, EXPRESS OR IMPLIED,
% OR ASSUMES ANY LEGAL LIABILITY OR RESPONSIBILITY FOR THE ACCURACY, COMPLETENESS,
% OR USEFULNESS OF ANY INFORMATION OR PROCESS DISCLOSED, OR REPRESENTS THAT ITS USE
% WOULD NOT INFRINGE PRIVATELY OWNED RIGHTS.
%
% Flags: FORWARDMODE,  NOOPEROPTIM,
%   NOLOCALCSE,  NOGLOBALCSE,  NOPRESCALARFOLDING,
%   NOPOSTSCALARFOLDING,  NOCONSTFOLDMULT0,  FUNCMODE,
%   NOTMPCLEAR,  DUMP_XML,  PARSE_ONLY,
%   UNBOUND_ERROR
%
% Parameters:
%  - dependents=r
%  - independents=p
%  - inputEncoding=ISO-8859-1
%  - output-mode: plain
%  - output-file: ad_out/d_adimat_norm2_i2.m
%  - output-file-prefix: 
%  - output-directory: ad_out
%
% Functions in this file: d_adimat_norm2
%

function [d_r r] = d_adimat_norm2(x, d_p, p)
% r = norm(x, p);
   r = [];
   d_r = d_zeros(r);
   tmpda3 = [];
   tmpda2 = [];
   tmpda1 = [];
   answer = [];
   a = [];
   tmpca3 = [];
   d_tmpca3 = d_zeros(tmpca3);
   tmpca2 = [];
   d_tmpca2 = d_zeros(tmpca2);
   tmpca1 = [];
   d_tmpca1 = d_zeros(tmpca1);
   sa2 = [];
   s = [];
   if ischar(p)
      if strcmp(lower(p), 'fro')
         tmpda3 = conj(x(:));
         tmpda2 = x(:) .* tmpda3;
         tmpda1 = sum(tmpda2);
         r = sqrt(tmpda1);
         d_r = d_zeros(r);
      else
         error('Only "fro" is a valid string for p-norm computation currently.');
      end
   else
      if isvector(x)
         if isinf(p)
            if p > 0
               tmpda1 = abs(x);
               r = max(tmpda1);
               d_r = d_zeros(r);
            else
               tmpda1 = abs(x);
               r = min(tmpda1);
               d_r = d_zeros(r);
            end
         else
            if isreal(x) && mod(p, 2)==0
               answer = admGetPref('pnormEven_p_useAbs');
               if strcmp(answer, 'yes')
                  a = abs(x);
               else
                  a = x;
               end
            else
               a = abs(x);
            end
            d_tmpca3 = adimat_opdiff_div_left(1, d_p, p);
            tmpca3 = 1 / p;
            d_tmpca2 = adimat_opdiff_epow_left(a, d_p, p);
            tmpca2 = a .^ p;
            d_tmpca1 = adimat_diff_sum1(d_tmpca2, tmpca2);
            tmpca1 = sum(tmpca2);
            d_r = adimat_opdiff_epow(d_tmpca1, tmpca1, d_tmpca3, tmpca3);
            r = tmpca1 .^ tmpca3;
         end
      elseif ismatrix(x)
         if isinf(p)
            a = abs(x);
            sa2 = sum(a, 2);
            r = max(sa2);
            d_r = d_zeros(r);
         elseif p == 2
            if issparse(x)
               x = full(x);
            end
            if isreal(x)
               s = svd(x);
            else
               [s] = adimat_svd(x);
            end
            r = max(s);
            d_r = d_zeros(r);
         elseif p == 1
            a = abs(x);
            sa2 = sum(a, 1);
            r = max(sa2);
            d_r = d_zeros(r);
         else
            error('Derivatives of matrix-p-norm not implemented yet.');
         end
      else
         error('Value is neither a matrix nor a vector!');
      end
   end
end
% $Id: adimat_norm2.m 4281 2014-05-21 09:23:04Z willkomm $