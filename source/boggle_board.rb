class BoggleBoard
  attr_accessor :board

  DICE = [ 'AAEEGN', 'ELRTTY', 'AOOTTW', 'ABBJOO',
           'EHRTVW', 'CIMOTU', 'DISTTY', 'EIOSST',
           'DELRVY', 'ACHOPS', 'HIMNQU', 'EEINSU',
           'EEGHNW', 'AFFKPS', 'HLNNRZ', 'DEILRX' ].map(&:chars)

  def initialize
    @board = Array.new(4) {Array.new(4, '-')}
  end

  def shake!
    self.board = DICE.shuffle.map{ |die| roll(die) }.each_slice(4).to_a
  end

  def roll(die)
    result = die.sample
  end

  def to_s
    board_str = ''
    board.each do |row|
      row.each do |char|
        board_str << pad_char(char)
      end
      board_str << "\n"
    end
    board_str + "\n"
  end

  def pad_char(char)
    str = ''
    str << char
    str << 'u' if char == 'Q'
    str.ljust(3)
  end

  def include?(word)
    word = word.upcase.gsub(/QU/, 'Q')
    chars = word.chars
    board.each_index do |row|
      board.each_index do |col|
        return true if check?(chars, board, row, col)
      end
    end
    false
  end

  def check?(chars, board, row, col)
    return false unless within_bounds?(row, col)
    return false unless chars.first == board[row][col]
    board = board.transpose.transpose # hacky deep cloning
    remain = chars[1..-1]
    if remain.empty?
      true
    else
      board[row][col] = '-'
      check_in_all_directions?(remain, board, row, col)
    end
  end

  def check_in_all_directions?(remain, board, row, col)
      check?(remain, board, row    , col + 1) || # right
      check?(remain, board, row    , col - 1) || # left
      check?(remain, board, row + 1, col    ) || # up
      check?(remain, board, row - 1, col    ) || # down
      check?(remain, board, row - 1, col - 1) || # down right
      check?(remain, board, row - 1, col + 1) || # down left
      check?(remain, board, row + 1, col - 1) || # up right
      check?(remain, board, row + 1, col + 1)    # up left
  end

  def within_bounds?(row, col)
    row.between?(0,3) && col.between?(0,3)
  end
end

# TESTS
# require_relative 'boggle_board_tests'

boggle = BoggleBoard.new
boggle.shake!
puts boggle

# Find 3-Letter Words
three_letter_words = %w(aah aal aas aba abo abs aby ace act add ado ads adz aff aft aga age ago ags aha
                        ahi ahs aid ail aim ain air ais ait ala alb ale all alp als alt ama ami amp amu
                        ana and ane ani ant any ape apo app apt arb arc are arf ark arm ars art ash ask
                        asp ass ate att auk ava ave avo awa awe awl awn axe aye ays azo baa bad bag bah
                        bal bam ban bap bar bas bat bay bed bee beg bel ben bes bet bey bib bid big bin
                        bio bis bit biz boa bob bod bog boo bop bos bot bow box boy bra bro brr bub bud
                        bug bum bun bur bus but buy bye bys cab cad cam can cap car cat caw cay cee cel
                        cep chi cig cis cob cod cog col con coo cop cor cos cot cow cox coy coz cru cry
                        cub cud cue cum cup cur cut cwm dab dad dag dah dak dal dam dan dap daw day deb
                        dee def del den dev dew dex dey dib did die dif dig dim din dip dis dit doc doe
                        dog dol dom don dor dos dot dow dry dub dud due dug duh dui dun duo dup dye ear
                        eat eau ebb ecu edh eds eek eel eff efs eft egg ego eke eld elf elk ell elm els
                        eme ems emu end eng ens eon era ere erg ern err ers ess eta eth eve ewe eye fab
                        fad fag fan far fas fat fax fay fed fee feh fem fen fer fes fet feu few fey fez
                        fib fid fie fig fil fin fir fit fix fiz flu fly fob foe fog foh fon fop for fou
                        fox foy fro fry fub fud fug fun fur gab gad gae gag gal gam gan gap gar gas gat
                        gay ged gee gel gem gen get gey ghi gib gid gie gig gin gip git gnu goa gob god
                        goo gor gos got gox goy gul gum gun gut guv guy gym gyp had hae hag hah haj ham
                        hao hap has hat haw hay heh hem hen hep her hes het hew hex hey hic hid hie him
                        hin hip his hit hmm hob hod hoe hog hon hop hot how hoy hub hue hug huh hum hun
                        hup hut hyp ice ich ick icy ids iff ifs igg ilk ill imp ink inn ins ion ire irk
                        ism its ivy jab jag jam jar jaw jay jee jet jeu jew jib jig jin job joe jog jot
                        jow joy jug jun jus jut kab kae kaf kas kat kay kea kef keg ken kep kex key khi
                        kid kif kin kip kir kis kit koa kob koi kop kor kos kue kye lab lac lad lag lam
                        lap lar las lat lav law lax lay lea led lee leg lei lek let leu lev lex ley lez
                        lib lid lie lin lip lis lit lob log loo lop lot low lox lug lum luv lux lye mac
                        mad mae mag man map mar mas mat maw max may med meg mel mem men met mew mho mib
                        mic mid mig mil mim mir mis mix moa mob moc mod mog mol mom mon moo mop mor mos
                        mot mow mud mug mum mun mus mut myc nab nae nag nah nam nan nap naw nay neb nee
                        neg net new nib nil nim nip nit nix nob nod nog noh nom noo nor nos not now nth
                        nub nun nus nut oaf oak oar oat oba obe obi oca oda odd ode ods oes off oft ohm
                        oho ohs oil oka oke old ole oms one ono ons ooh oot ope ops opt ora orb orc ore
                        ors ort ose oud our out ova owe owl own oxo oxy pac pad pah pal pam pan pap par
                        pas pat paw pax pay pea pec ped pee peg peh pen pep per pes pet pew phi pht pia
                        pic pie pig pin pip pis pit piu pix ply pod poh poi pol pom pop pot pow pox pro
                        pry psi pst pub pud pug pul pun pup pur pus put pya pye pyx qat qis qua rad rag
                        rah rai raj ram ran rap ras rat raw rax ray reb rec red ree ref reg rei rem rep
                        res ret rev rex rho ria rib rid rif rig rim rin rip rob roc rod roe rom rot row
                        rub rue rug rum run rut rya rye sab sac sad sae sag sal sap sat sau saw sax say
                        sea sec see seg sei sel sen ser set sew sex sha she shh shy sib sic sim sin sip
                        sir sis sit six ska ski sky sly sob sod sol som son sop sos sot sou sow sox soy
                        spa spy sri sty sub sue suk sum sun sup suq syn tab tad tae tag taj tam tan tao
                        tap tar tas tat tau tav taw tax tea ted tee teg tel ten tet tew the tho thy tic
                        tie til tin tip tis tit tod toe tog tom ton too top tor tot tow toy try tsk tub
                        tug tui tun tup tut tux twa two tye udo ugh uke ulu umm ump uns upo ups urb urd
                        urn urp use uta ute uts vac van var vas vat vau vav vaw vee veg vet vex via vid
                        vie vig vim vis voe vow vox vug vum wab wad wae wag wan wap war was wat waw wax
                        way web wed wee wen wet wha who why wig win wis wit wiz woe wog wok won woo wop
                        wos wot wow wry wud wye wyn xis yag yah yak yam yap yar yaw yay yea yeh yen yep
                        yes yet yew yid yin yip yob yod yok yom yon you yow yuk yum yup zag zap zas zax
                        zed zee zek zep zig zin zip zit zoa zoo zuz zzz)

puts "Three Letter Words:"
found = three_letter_words.select do |word|
  boggle.include?(word)
end
found.each_slice(6) {|slice| puts " #{slice.map(&:downcase).join(' ')}"}
puts

# Find Words Containing 'Qu'
puts "Words Containing 'Qu':"
words_with_qu = %w(acquit aqua aquae aquas barque basque bisque bosque caique calque casque cheque cinque
                   cirque claque clique cliquy cloque coquet equal equid equip equips equity exequy faquir
                   fique fiques liquid manque maqui maquis marque masque mosque opaque pique piqued piques
                   piquet plaque pulque qua quack quacks quacky quad quads quaff quaffs quag quagga quaggy
                   quags quahog quai quaich quaigh quail quais quake quaked quaker quakes quaky quale qualm
                   qualms qualmy quango quant quare quark quarks quarry quart quartz quash quasi quass
                   quate quaver quay quays qubit qubits qubyte quean queasy queazy queen queer quell quells
                   quench quern query quest queue queued quey queys quezal quiche quick quicks quid quids
                   quiet quiff quiffs quill quills quilt quin quince quinic quinin quinol quins quinsy quint
                   quip quippu quippy quips quipu quipus quire quirk quirks quirky quirt quit quitch quite
                   quits quiver quiz quod quods quohog quoin quoit quokka quoll quolls quorum quota quote
                   quoth quotha qursh qurush roque sacque squab squabs squad squama squark squat squawk
                   squeak squeg squib squibs squid squirm squush toque tuque ubique usque yanqui)
found = words_with_qu.select do |word|
  boggle.include?(word)
end
found.sort.each_slice(4) {|slice| puts " #{slice.map(&:downcase).join(' ')}"}
