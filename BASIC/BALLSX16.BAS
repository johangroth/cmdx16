
 Ά$2 : � 80X60 4BPP 9 �"NUMBER OF BALLS (1-255)?" A � N N( � N�1�20 ]2 � N�255�20 g< �"�"; �F � BX(255):� BY(255):� BC(255) �K � DX(255):� DY(255) �P �B�0�N:� SET INITIAL POSITION �Z BX(B)��(�(1)�80) �d BY(B)��(�(1)�60) 	i BC(B)��(�(1)�14)�1 	j DX(B)��(�(1)�2) ,	l DY(B)��(�(1)�2) :	m � DY(B)=1 B	n � B _	x � FILL SCREEN WITH BALLS k	� �Y�0�59 w	� �X�0�79 �	� Q�Y�256�X�2 �	� ΄0,Q,81 �	� ΄0,Q�1,0 �	� �X,Y �	� �B�1�N �	� � MOVE BALLS AROUND �	� ΄0,BY(B)�256�BX(B)�2�1,0  
� � DX(B)�0��1010 
� � DX(B)�1��1040 (
� DY(B)�0��1070 <
� DY(B)�1��1100 ^
΄0,BY(B)�256�BX(B)�2�1,BC(B) e
"�B n
,�200 ~
�� MOVE LEFT �
�� BX(B)�0�DX(B)�1:� �
�BX(B)�BX(B)�1:� �
� MOVE RIGHT �
� BX(B)�79�BX(B)�78:DX(B)�0:� �
BX(B)�BX(B)�1:� �
$� MOVE UP .� BY(B)�0�DY(B)�1:� +8BY(B)�BY(B)�1:� ;B� MOVE DOWN \L�BY(B)�59�BY(B)�58:DY(B)�0:� pVBY(B)�BY(B)�1:�   