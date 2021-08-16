Program FindK; // Заголовок можно не писать :)
// Пояснения к решению задачи - по условию:
// 1) элементы массивов целые, т.к. надо найти число нулевых элементов массива
// строго нулевые могут быть только для целочисленных элементов
// 2) случайные числа находятся на интервале (-10;10), т.е. -10 < случ. число <10
// см. запись числовых промежутков https://ds04.infourok.ru/uploads/ex/0ab8/0012a857-ca037230/img2.jpg
// 3) Формирование массивов А и В надо очуществить "с помощью датчика случайных чисел"
// Возможны два варианта - поэлементное заполнение с помощью функции random и 
// заполнение массива разом спомощью специальной функции ArrRandomInteger. 
// Но так как не указан явно какие массивы, делаю статические, для них только - random 
// 4) Функция random(MinRnd,MaxRnd) будет давать числа, включающие концы интервала, проверено
// при генерации последовательности из 35 чисел, поэтому запускаем генератор с параметрами
// random(MinRnd+1,MaxRnd-1)

Const
 NA=15;// 35
 NB=20;
 MinRnd=-10;
 MaxRnd= 10;
Type
 TA=Array[1..NA] of integer;
 TB=Array[1..NB] of integer;
Var 
 A: TA;
 B: TB;
 NZA,NZB:integer; // число нулей в массивах А и В

// массивы передаем по ссылке, меняем внутри процедуры, возращаем изменения 
Procedure Make_A_B_array(Var A: TA; Var B: TB); 
 begin
   randomize; // инициализируем генератор случайных чисел 
   For var i:=1 to NA do
     A[i]:=random(MinRnd+1,MaxRnd-1);
   randomize; // инициализируем генератор случайных чисел 
   For var i:=1 to NB do
     B[i]:=random(MinRnd+1,MaxRnd-1);
 end;

// массивы передаем по значению, нам не нужно ничего из процедуры, хотя и занимаем стек таким образом
Procedure Output_A_B_array(A: TA; B: TB); 
 begin
   // простой способ вывода массива
   Writeln('--- Array A ---');
   For var i:=1 to NA do
    Writeln(i:2,'  ',A[i]); // Вывод номера элемента и самого элемента
   // более сложный способ вывода
   Writeln('--- Array B ---');
   For var i:=1 to NB do
    WritelnFormat('{0:d2} {1}', i, B[i]);     
 end;

// массивы никак явно не передаем, используем как глобальные переменные, 
// а массивы разлчию по чилу элементов
Function FindKi(N:integer):integer;
 Var NN:integer; // Счетчик нулей
 begin
  NN:=0; // Можно и необнулять, про умолчанию итак 0
  If N=NA
   then 
    begin //-- 1  
     For var i:=1 to NA do
      if A[i]=0 then Inc(NN)
    end  //-- 1  
   else   
    begin //-- 2  
     For var i:=1 to NB do
      if B[i]=0 then Inc(NN);
    end;  //-- 2
// -- Примечание приходится  ставить begin и end вокруг цикла for, 
// -- т.к. без них компилятор выдает ошибочные ответы
  FindKi:=NN;
 end;

begin //-- Начало программы
 Make_A_B_array(A, B);
 Output_A_B_array(A, B);
 NZA:=FindKi(NA);
 NZB:=FindKi(NB);
 Writeln(NZA);
 Writeln(NZB);
 Writeln('Число нулей в массивах А и В  = ',NZA+NZB);
 readln;
end.