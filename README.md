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

[image.png](https://postimg.cc/DmdYgRkR)

[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-1_20.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc194721e01056591372)[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-2_7.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc1c61a2db28463699)

[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-3_7.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc1f7ed0fb367581945)[![image](https://www.linkpicture.com/q/Webp.net-resizeimage-4_4.png)](https://www.linkpicture.com/view.php?img=LPic5fcbc227139941150175523)

<u>**ΕΡΩΤΗΜΑ** **3**</u>

Τρέχοντας ξανά τα benchmarks που αναφέρθηκαν παραπάνω προσθέτοντας την παράμετρο **--cpu-clock=2GHz**, παρατηρήσαμε διαφορές όσον αφορά το ρολόι στο αρχείο stats.txt. 

Από τον τύπο:

> frequency = sim_freq / clock

εξάγουμε το συμπέρασμα ότι η συχνότητα που αντιστοιχεί στο **system.clk_domain.clock** (1000-->1000) παραμένει σταθερή στο 1GHz και στις δύο εκτελέσεις. Αντίθετα, η συχνότητα που αντιστοιχεί στο **system.cpu_clk_domain.clock** (1000-->500), γίνεται 2GHz, όταν εισάγουμε το flag --cpu-clock=2GHz.

Κάνουμε την υπόθεση ότι στην πρώτη περίπτωση στο σύστημα χρησιμοποιείται μόνο μία CPU, η οποία και χρονίζεται στο 1GHz. Στην δεύτερη περίπτωση, η CPU συνεχίζει να χρονίζεται στο 1GHz, αλλά προστίθεται ακόμη μία, το οποίο μας οδηγεί στο αποτέλεσμα των 2GHz (το οποίο αναμέναμε με την αλλαγή του flag). Αν αλλάζαμε το flag σε --cpu-clock=3GHz, εικάζουμε πως θα προστεθεί ακόμα μία -χρονισμένη στο 1GHz- CPU στο cluster.

Παρατηρώντας τους χρόνους εκτέλεσης των benchmarks, βλέπουμε πως δεν υπάρχει τέλειο scaling. Δεν φαίνεται, δηλαδή, ο χρόνος να μειώνεται στο μισό όταν διπλασιάζουμε τη συχνότητα. Το παραπάνω μπορεί να οφείλεται στο προαναφερθέν cluster των CPUs, το οποίο συνηθίζεται να έχει private L1 caches και shared L2 caches, κάτι το οποίο μπορεί να έχει ως αποτέλεσμα την καθυστέρηση εκτέλεσης του προγράμματος. Επιπροσθέτως, όταν αυξάνουμε σημαντικά την ταχύτητα του επεξεργαστή είναι πιθανό να μην μειώνεται γραμμικά ο χρόνος περάτωσης του προγράμματος, διότι η CPU καταλήγει να είναι πολύ γρηγορότερη από τα υπόλοιπα στοιχεία του συστήματος, συνεπώς πρέπει σε κάποια σημεία να "περιμένει".

------

### **ΒΗΜΑ 2**

<u>**ΕΡΩΤΗΜΑ** **1**</u>

Παρουσιάζουμε στον παρακάτω πίνακα τα αποτελέσματα των δοκιμών μας για να βρούμε το minimum CPI για κάθε benchmark:

|           | L1 dcache - L1 icache | L2 cache | L1i - L1d - L2 Associativity | Cache Line Size |   CPI    |
| :-------: | :-------------------: | :------: | :--------------------------: | :-------------: | :------: |
| 401.bzip2 |     128kB - 128kB     |  4096kB  |          8 - 8 - 16          |      128B       | 1.600745 |
|  429.mcf  |     64kB - 128kB      |  4096kB  |          8 - 8 - 16          |      128B       | 1.084049 |
| 458.sjeng |      32kB - 64kB      |  512Kb   |          1 - 1 - 2           |      128B       | 6.809691 |
|  470.lbm  |     128kB - 128kB     |  4096kB  |          2 - 2 - 4           |      128B       | 2.576960 |

Στα παραπάνω αποτελέσματα καταλήξαμε μελετώντας τις μετρήσεις του ερωτήματος 2 και χρησιμοποιώντας από το κάθε benchmark την πιο αποδοτική επιλογή παραμέτρων, καθώς και ανατρέχοντας στο βήμα 1.

<u>**ΕΡΩΤΗΜΑ** **2**</u>

Παρακάτω ακολουθούν γραφήματα που δείχνουν την επίδραση κάθε παράγοντα στην απόδοση κάθε benchmark:

**Benchmark 1: 401.bzip2**

[![image](https://www.linkpicture.com/q/bzip-l1.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbce82ec7e59829001)

[![image](https://www.linkpicture.com/q/bzip-l2.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbce82ec7e59829001)

[![image](https://www.linkpicture.com/q/bzip-assoc.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbce82ec7e59829001)

[![image](https://www.linkpicture.com/q/bzip-cache-line.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbce82ec7e59829001)

**Benchmark 2: 429.mcf**

[![image](https://www.linkpicture.com/q/mcf-l1.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbe3648838900739147)

[![image](https://www.linkpicture.com/q/mcf-l2.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbe3648838900739147)

[![image](https://www.linkpicture.com/q/mcf-assoc.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbe3648838900739147)

[![image](https://www.linkpicture.com/q/mcf-cache-line.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbe3648838900739147)

**Benchmark 3: 458.sjeng**

[![image](https://www.linkpicture.com/q/sjeng-l1.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf030e53d1593226884)

[![image](https://www.linkpicture.com/q/sjeng-l2.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf030e53d1593226884)

[![image](https://www.linkpicture.com/q/sjeng-assoc.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf030e53d1593226884)

[![image](https://www.linkpicture.com/q/Picture1_45.png)](https://www.linkpicture.com/view.php?img=LPic5fcd150d9927b1827035289)

**Benchmark 4: 470.lbm**

[![image](https://www.linkpicture.com/q/libm-l1.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf7a6d3cf172841470)

[![image](https://www.linkpicture.com/q/libm-l2.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf7a6d3cf172841470)

[![image](https://www.linkpicture.com/q/libm-assoc.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf7a6d3cf172841470)

[![image](https://www.linkpicture.com/q/libm-cache-line.png)](https://www.linkpicture.com/view.php?img=LPic5fcbbf7a6d3cf172841470)

------

### **ΒΗΜΑ 3**

Χρησιμοποιώντας την βιβλιογραφία, τα αποτελέσματα από το βήμα 2, καθώς και τις γνώσεις μας από τις διαλέξεις του μαθήματος, καταλήξαμε στην τελική μορφή μιας συνάρτησης κέρδους, η ανάλυση της οποίας παρατίθεται παρακάτω.

<u>ΣΥΝΑΡΤΗΣΗ ΚΟΣΤΟΥΣ</u>

> f (L1, L2, a, cl) = 0,5 x L1 + 0,15 x L2 + 0,3 x a + 0,05 x cl 

> CPI = (cpi_l1 + cpi_l2 + cpi_a + cpi_cl) / 4 

Θεωρήσαμε πως κάθε κομμάτι της CPU συμμετέχει με ένα διαφορετικό ποσοστό στο συνολικό κόστος. Θέσαμε λοιπόν το ποσοστό του κόστους που αναλογεί στην L1 cache στο 50%, στην L2 cache στο 15%, στο associativity στο 30% και στο cache line size στο 5%. Το άθροισμα των βαρών, επομένως, αντιστοιχεί στη μονάδα.

Οι τιμές L1, L2, a και cl παίρνουν τις τιμές [1,2,3], [1,2,4,8], [1,2,4,8] και [1,2,4] αντίστοιχα, και αποτελούν την αυθαίρετη μονάδα κόστους που επιλέξαμε.  

[![image](https://www.linkpicture.com/q/Screenshot_1_201.png)](https://www.linkpicture.com/view.php?img=LPic5fcd1913d35d4642075323)

Από τη βιβλιογραφία γνωρίζουμε πως μεγαλύτερο μέγεθος cache αντιστοιχεί σε σημαντικότερο κόστος. Επιπροσθέτως, μεγαλύτερο associativity επίσης αντιστοιχεί σε μεγαλύτερο κόστος, καθώς με την αύξηση του αυξάνεται η πολυπλοκότητα και χρειάζεται μεγαλύτερος αριθμός λογικών πυλών. Από τις πληροφορίες που συγκεντρώσαμε, θεωρήσαμε ότι αύξηση του μεγέθους του cache line οδηγεί και αυτή σε αύξηση κόστους.

Όπως φαίνεται παραπάνω, ο διπλασιασμός οποιασδήποτε παραμέτρου οδηγεί και στο διπλασιασμό της αντίστοιχης μεταβλητής. Κάναμε αυτή την επιλογή ώστε να φαίνεται καθαρά η αύξηση του κόστους σε κάθε περίπτωση. 

Υποσημείωση: Από τη μετάβαση των L1d=64kB & L1i=128kB σε L1d=128kB & L1i=128kB η τιμή της μεταβλητής δεν διπλασιάζεται αλλά πολλαπλασιάζεται με 1.5, δηλαδή παίρνει την τιμή 3, διότι διπλασιάζεται μόνο η dcache ενώ η icache παραμένει σταθερή.                                                       

Όσον αφορά το CPI, αποφασίσαμε να θεωρήσουμε μία σχετικά αυθαίρετη τιμή του, χρησιμοποιώντας τον μέσο όρο τεσσάρων περιπτώσεων κάθε φορά, από τα προϋπολογισμένα CPI του βήματος 2. Με αυτό τον τρόπο βρίσκουμε μία τιμή CPI για καθέναν από τους 144 διαφορετικούς συνδυασμούς L1, L2, associativity, cache line size, η οποία αντιστοιχεί σε μία τιμή κόστους f.

Ο υπολογισμός του κόστους f και του αντίστοιχου CPI υλοποιήθηκε μέσω του κώδικα MATLAB που συνοδεύει την αναφορά. Το αποτέλεσμα αυτού μας δίνει έναν πίνακα, η κάθε σειρά του οποίου περιλαμβάνει μία τιμή κόστους f, ένα CPI, και τιμές μέσω των οποίων βρίσκουμε τις παραμέτρους κάθε περίπτωσης (αρχείο excel "COST RESULTS"). 

Κάνοντας sort τον πίνακα με τις τιμές του κόστους σε αύξουσα σειρά, βλέπουμε πως η ελάχιστη και μέγιστη τιμή είναι 1 και 5.3. Θεωρούμε ως threshold κόστους την τιμή 3.3 (λίγο μεγαλύτερη του μέσου 3.15) και στη συνέχεια βρίσκουμε το μικρότερο cpi από τα εναπομείναντα. Οι τιμές των παραμέτρων που αντιστοιχούν στο cpi αυτό (μπλε χρώμα) είναι αυτές που βελτιστοποιούν την απόδοση του συστήματος σε σχέση με το κόστος. Με κίτρινο χρώμα φαίνεται το καλύτερο (αυθαίρετο) cpi, το οποίο αντιστοιχεί στις παραμέτρους που ήδη βρήκαμε στο βήμα 2. 

Πιο συγκεκριμένα για κάθε benchmark, παρουσιάζουμε την περίπτωση που επιλέξαμε με άξονα κόστος αλλά και απόδοση, καθώς και την περίπτωση με βέλτιστο cpi ανεξαρτήτως κόστους. Συγκρίνουμε επίσης το πραγματικό cpi εκτέλεσης του αντίστοιχου benchmark και στις δύο περιπτώσεις.

**Benchmark 1: 401.bzip2**

Επιλέξαμε το κόστος να είναι **3.2** που αντιστοιχεί σε cpi **1.77028925**, και παραμέτρους:

- L1d = 128kB 
  L1i = 128kB

- L2 = 4096kB

- L1 assoc = 1
  L2 assoc = 2

- cache line = 128

  [![image](https://www.linkpicture.com/q/Screenshot_6_74.png)](https://www.linkpicture.com/view.php?img=LPic5fcd2c94550ea292126733)

Στην πραγματική εκτέλεση, χρησιμοποιώντας τις παραπάνω παραμέτρους, το cpi είναι **1.625068**, τιμή σημαντικά συγκρίσιμη με την βέλτιστη περίπτωση (**1.600745**), αλλά με πολύ μικρότερο κόστος.

**Benchmark 2: 429.mcf**

Επιλέξαμε το κόστος να είναι **3** που αντιστοιχεί σε cpi **1.14213275**, και παραμέτρους:

- L1d = 64kB 
  L1i = 128kB

- L2 = 2048kB

- L1 assoc = 4
  L2 assoc = 8

- cache line = 128

  [![image](https://www.linkpicture.com/q/Screenshot_3_88.png)](https://www.linkpicture.com/view.php?img=LPic5fcd292d75af1906695887)

Στην πραγματική εκτέλεση, χρησιμοποιώντας τις παραπάνω παραμέτρους, το cpi είναι **1.085023**, τιμή σημαντικά συγκρίσιμη με την βέλτιστη περίπτωση (**1.084049**), αλλά με πολύ μικρότερο κόστος. 

**Benchmark 3: 458.sjeng**

Επιλέξαμε το κόστος να είναι **1.15** που αντιστοιχεί σε cpi **6.810651**, και παραμέτρους:

- L1d = 32kB 
  L1i = 64kB

- L2 = 512kB

- L1 assoc = 1
  L2 assoc = 2

- cache line = 128

  [![image](https://www.linkpicture.com/q/Screenshot_4_72.png)](https://www.linkpicture.com/view.php?img=LPic5fcd292d75af1906695887)

Στην πραγματική εκτέλεση, χρησιμοποιώντας τις παραπάνω παραμέτρους, το cpi είναι **6.809691**, τιμή ίδια με την βέλτιστη περίπτωση (**6.809691**).  

**Benchmark 4: 470.lbm**

Επιλέξαμε το κόστος να είναι **2.9** που αντιστοιχεί σε cpi **3.28737425**, και παραμέτρους:

- L1d = 128kB 
  L1i = 128kB

- L2 = 2048kB

- L1 assoc = 2
  L2 assoc = 4

- cache line = 128

  [![image](https://www.linkpicture.com/q/Screenshot_5_51.png)](https://www.linkpicture.com/view.php?img=LPic5fcd292d75af1906695887)

Στην πραγματική εκτέλεση, χρησιμοποιώντας τις παραπάνω παραμέτρους, το cpi είναι **2.581555**, τιμή σημαντικά συγκρίσιμη με την βέλτιστη περίπτωση (**2.576960**), αλλά με αρκετά μικρότερο κόστος.

#### ΚΡΙΤΙΚΗ

Από την παραπάνω εργασία μάθαμε να τρέχουμε benchmarks σε Linux περιβάλλον. Συμπεράναμε ότι δεν επωφελούνται όλα τα benchmarks από τις ίδιες παραμέτρους. Άλλα χρειάζονται μεγάλες chace μνήμες και υψηλό associativity, ενώ άλλα πετυχαίνουν καλύτερο CPI με μικρή cache και direct mapped. Επίσης, πειραματιστήκαμε με διαφορετικό cpu clock και παρατηρήσαμε ότι με αύξηση της συχνότητας, παίρνουμε καλύτερη απόδοση χρόνου, όμως αυτή η αλλαγή στο ρολόι δεν συνεπάγεται τέλειο scaling. Επιπλέον, μπήκαμε στην διαδικασία να δημιουργήσουμε μία δική μας συνάρτηση κόστους και να ερευνήσουμε ποιες παράμετροι επηρεάζουν σε σημαντικότερο βαθμό το CPI, αλλά και τι περικοπές πρέπει να κάνουμε για να διατηρήσουμε μία ισορροπία μεταξύ κόστους και απόδοσης.

Αυτό που μας δυσκόλεψε ήταν η εκτέλεση του benchmark 456.hmmer, το οποίο δεν έτρεξε ούτε σε ubuntu 18 ούτε σε 20 με διαφορετικό σφάλμα στο καθένα, ακόμη και ύστερα από συνεννόηση με τον βοηθό.

Θεωρούμε πως η εργασία ήταν αρκετά χρονοβόρα και από τη στιγμή που καταλάβαμε πως να δουλέψουμε με το πρώτο benchmark, τα υπόλοιπα ήταν επαναλαμβανόμενα. Πιστεύουμε πως θα μπορούσε να επιτευχθεί ο ίδιος μαθησιακός στόχος με τρία benchmarks αντί για πέντε, τα οποία έχουν διαφορές στον τρόπο που επιδρούν οι παράμετροι chace, associativity και  cache line.

------

#### FOLDER STRUCTURE

```
.
├── MATLAB scripts		#MATLAB scripts for best cpi/cost calcutation	
│   ├── cost_bzip2.m
|   ├── cost_libm.m
|   ├── cost_mcf.m
│   └── cost_sjeng.m
├── spec_results_1GHz		#stat files for step 1			
│   ├── specs_bzip2
|   ├── specs_libm
|   ├── specs_mcf
│   └── specs_sjeng
├── spec_results_2GHz		#stat files for step 1
│   ├── specs_bzip2
|   ├── specs_libm
|   ├── specs_mcf
│   └── specs_sjeng
├── spec_results_bestCPI		#stat files for best case scenario
│   ├── specs_bzip2
|   ├── specs_libm
|   ├── specs_mcf
│   └── specs_sjeng
├── spec_results_cost_CPI		#stat files for best cpi/cost case
│   ├── specs_bzip2
|   ├── specs_libm
|   ├── specs_mcf
│   └── specs_sjeng
├── COST RESULTS.xlsx		#matrices with all cost/cpi combinations (made with MATLAB)	 
├── CPI RESULTS.xlsx		#cpi results for step 2 diagrams               
└── README.md                    
```
