function [obj] = exp(obj)
  eT = obj.m_series;
  eT{1} = exp(obj.m_series{1});
  for j=1:obj.m_ord-1
    eT{j+1} = timesdv(obj.m_series{j+1}, eT{1});
    for i=1:j-1
      eT{j+1} = plusddes(eT{j+1}, timesdv(timesdd(eT{i+1}, obj.m_series{j-i+1}), (j-i)./j));
    end
  end
  obj.m_series = eT;
end
