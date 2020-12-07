# Αρχιτεκτονική Υπολογιστών

## *Εργασία #2*

**<u>Εισηγητής</u>:** 	

Παπαευσταθίου Ιωάννης

**<u>Ονόματα</u>:** 	   

Χάιδω Πορλού		

Δημήτριος Παππάς

**<u>ΑΕΜ</u>:**				      

9372						

8391

**<u>Ομάδα:</u>**			

13Α

------

### **ΒΗΜΑ 1**

##### <u>ΕΡΩΤΗΜΑ 1</u>

Ανοίγοντας το αρχείο config.ini που δημιουργήσαμε με την εκτέλεση των benchmark, παρατηρούμε ότι οι τιμές των βασικών παραμέτρων για τον επεξεργαστή όσον αφορά το υποσύστημα μνήμης είναι οι εξής:

- L1 data cache

  > [system.cpu.dcache]
  >
  > assoc=**2**
  >
  > size=**65536**

- L1 instruction cache

  > [system.cpu.icache]
  >
  > assoc=**2**
  >
  > size=**32768**

- L2 cache

  > [system.l2]
  >
  > assoc=**8**
  >
  > size=**2097152**

- Cache line 

  > [system]
  >
  > cache_line_size=**64**



<u>**ΕΡΩΤΗΜΑ** **2**</u>

Τα αποτελέσματα που καταγράψαμε από τα διαφορετικά benchmarks, παρουσιάζονται στον παρακάτω πίνακα:

|           | Χρόνος Εκτέλεσης |   CPI    | L1 dcache miss rates | L1 icache miss rates | L2 cache miss rates |
| :-------: | :--------------: | :------: | :------------------: | :------------------: | :-----------------: |
| 401.bzip2 |     0.160703     | 1.607035 |       0.014133       |       0.000076       |      0.294739       |
|  429.mcf  |     0.109233     | 1.092334 |       0.002038       |       0.000037       |      0.727788       |
| 458.sjeng |     0.705453     | 7.054533 |       0.121829       |       0.000020       |      0.999979       |
|  470.lbm  |     0.262248     | 2.622476 |       0.060971       |       0.000098       |      0.999927       |

Από τον τύπο:

> CPU time = Instruction count * Cycles per Instruction * Clock cycle time

επαληθεύουμε ότι το CPI είναι δεκαπλάσιο από τον χρόνο εκτέλεσης, διότι Instruction count = 100000000 και Clock cycle time = 1 nsec, αφού η συχνότητα λειτουργίας είναι 1GHz. 

Παρατηρούμε ότι τα miss rates στην L1 icache είναι πολύ χαμηλά, καθώς και ότι στα δύο μεγάλα benchmarks τα miss rates της L2 είναι σημαντικά υψηλά.

[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-5_2.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc268a58d81537118458)

[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-1_20.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc194721e01056591372)[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-2_7.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc1c61a2db28463699)

[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-3_7.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc1f7ed0fb367581945)[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-4_4.png)](
