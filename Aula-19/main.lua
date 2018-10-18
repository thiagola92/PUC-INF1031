local  function  hanoi  ( origem ,  destino ,  auxiliar ,  quantos )
  if  quantos  <=  1  then
    print  ( string . format (" mova  de  %d  para  %d" ,
    origem ,  destino ))
  else
    hanoi(origem, auxiliar, destino, quantos-1)
    print  ( string . format (" mova  de  %d  para  %d" ,
    origem ,  destino ))
    hanoi(auxiliar, destino, origem, quantos-1)
  end
end

hanoi (1 ,3 ,2 ,3)