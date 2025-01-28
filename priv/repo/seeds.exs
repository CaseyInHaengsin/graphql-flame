# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     HogwartsApi.Repo.insert!(%HogwartsApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

houses = [:gryffindor, :slytherin, :ravenclaw, :hufflepuff]
t_or_f = [true, false]

professors =
  [
    "Albus Dumbledore",
    "Minerva McGonagall",
    "Severus Snape",
    "Pomona Sprout",
    "Filius Flitwick",
    "Rubeus Hagrid",
    "Sybill Trelawney",
    "Horace Slughorn",
    "Remus Lupin",
    "Rolanda Hooch",
    "Aurora Sinistra",
    "Cuthbert Binns",
    "Septima Vector",
    "Bathsheba Babbling",
    "Charity Burbage",
    "Quirinus Quirrell",
    "Gilderoy Lockhart",
    "Wilhelmina Grubbly-Plank",
    "Firenze",
    "Dolores Umbridge",
    "Horatio Hornblower",
    "Galadriel Stineman",
    "Fulbert the Fearful",
    "Bathsheda Babbling",
    "Albertus Prospero",
    "Sibyll Trelawney",
    "Cassandra Vablatsky",
    "Devlin Whitehorn",
    "Emeric Switch",
    "Gringott",
    "Berty Crocker",
    "Orabella Nuttley",
    "Donaghan Tremlett",
    "Flavius Belby",
    "Gifford Ollerton",
    "Gondoline Oliphant",
    "Gulliver Pokeby",
    "Havelock Sweeting",
    "Ignatia Wildsmith",
    "Karl Jenkins",
    "Kendra Goshawk",
    "Leopoldina Smethwyck",
    "Madam Pince",
    "Margaret Boothby",
    "Mopsus",
    "Mopsus (herbologist)",
    "Musidora Barkwith",
    "Newton Scamander",
    "Oswald Beamish",
    "Ragnok the Pigeon-Toed",
    "Rowena Ravenclaw",
    "Sacharissa Tugwood",
    "Thaddeus Thurkell",
    "Walfred Longbottom",
    "Willy Wagstaff",
    "Zamira Gulch",
    "Zygmunt Budge",
    "Armando Dippet",
    "Herpo the Foul",
    "Newton Scamander",
    "Bathilda Bagshot",
    "Adalbert Waffling",
    "Arsenius Jigger",
    "Donaghan Tremlett",
    "Doris Crockford",
    "Ignatius Prewett",
    "Jocunda Sykes",
    "Norvel Twonk",
    "Fifi LaFolle",
    "Jocunda Sykes",
    "Hector Dagworth-Granger",
    "Ambrosius Flume",
    "Angelus Peel",
    "Archibald Alderton",
    "Archibald Bennett",
    "Arsenius Beaulitron",
    "Arthur Weasley",
    "Aurora Sinistra",
    "Basil Flack",
    "Benjy Fenwick",
    "Bernadette O'Brien",
    "Bertie Higgs",
    "Blagdon Blay",
    "Bowman Wright",
    "Brandon Angel",
    "Cadogan",
    "Cassandra Vablatsky",
    "Celestina Warbeck",
    "Charity Burbage",
    "Circe",
    "Daisy Dodderidge",
    "Damara Dodderidge",
    "Devlin Whitehorn"
  ]
  |> Enum.map(fn name ->
    %HogwartsApi.Beings.Professor{
      name: name,
      house: Enum.random(houses),
      is_animagus: Enum.random(t_or_f),
      is_deatheater: Enum.random(t_or_f)
    }
  end)

professors = [
  %HogwartsApi.Beings.Professor{
    name: "Severus Snape",
    house: :slytherin,
    is_animagus: false,
    is_deatheater: true
  },
  %HogwartsApi.Beings.Professor{
    name: "Minerva McGonagall",
    house: :gryffindor,
    is_animagus: false,
    is_deatheater: true
  },
  %HogwartsApi.Beings.Professor{
    name: "Filius Flitwick",
    house: :ravenclaw,
    is_animagus: false,
    is_deatheater: true
  },
  %HogwartsApi.Beings.Professor{
    name: "Pomona Sprout",
    house: :hufflepuff,
    is_animagus: false,
    is_deatheater: true
  },
  %HogwartsApi.Beings.Professor{
    name: "Albus Dumbledore",
    house: :gryffindor,
    is_animagus: true,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Rubeus Hagrid",
    house: :gryffindor,
    is_animagus: false,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Gilderoy Lockhart",
    house: :ravenclaw,
    is_animagus: false,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Remus Lupin",
    house: :gryffindor,
    is_animagus: true,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Sybill Trelawney",
    house: :ravenclaw,
    is_animagus: false,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Dolores Umbridge",
    house: :slytherin,
    is_animagus: false,
    is_deatheater: true
  },
  %HogwartsApi.Beings.Professor{
    name: "Horace Slughorn",
    house: :slytherin,
    is_animagus: false,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Alastor Moody",
    house: :gryffindor,
    is_animagus: true,
    is_deatheater: false
  },
  %HogwartsApi.Beings.Professor{
    name: "Voldermort",
    house: :slytherin,
    is_animagus: false,
    is_deatheater: true
  }
]

students =
  [
    "Harry Potter",
    "Hermione Granger",
    "Ron Weasley",
    "Draco Malfoy",
    "Luna Lovegood",
    "Neville Longbottom",
    "Ginny Weasley",
    "Fred Weasley",
    "George Weasley",
    "Cho Chang",
    "Cedric Diggory",
    "Padma Patil",
    "Parvati Patil",
    "Seamus Finnigan",
    "Dean Thomas",
    "Nymphadora Tonks",
    "Remus Lupin",
    "Sirius Black",
    "Lily Evans",
    "James Potter",
    "Albus Dumbledore",
    "Minerva McGonagall",
    "Rubeus Hagrid",
    "Severus Snape",
    "Draco Malfoy",
    "Vincent Crabbe",
    "Gregory Goyle",
    "Pansy Parkinson",
    "Millicent Bulstrode",
    "Blaise Zabini",
    "Daphne Greengrass",
    "Theodore Nott",
    "Marcus Flint",
    "Adrian Pucey",
    "Terence Higgs",
    "Roger Davies",
    "Cho Chang",
    "Marietta Edgecombe",
    "Terry Boot",
    "Michael Corner",
    "Anthony Goldstein",
    "Ernie Macmillan",
    "Justin Finch-Fletchley",
    "Hannah Abbott",
    "Susan Bones",
    "Zacharias Smith",
    "Lavender Brown",
    "Parvati Patil",
    "Padma Patil",
    "Alicia Spinnet",
    "Katie Bell",
    "Angelina Johnson",
    "Oliver Wood",
    "Cedric Diggory",
    "Fleur Delacour",
    "Viktor Krum",
    "Harry Potter",
    "Hermione Granger",
    "Ron Weasley",
    "Ginny Weasley",
    "Fred Weasley",
    "George Weasley",
    "Neville Longbottom",
    "Luna Lovegood",
    "Dean Thomas",
    "Seamus Finnigan",
    "Cho Chang",
    "Cedric Diggory",
    "Draco Malfoy",
    "Vincent Crabbe",
    "Gregory Goyle",
    "Pansy Parkinson",
    "Millicent Bulstrode",
    "Blaise Zabini",
    "Daphne Greengrass",
    "Theodore Nott",
    "Marcus Flint",
    "Adrian Pucey",
    "Terence Higgs",
    "Roger Davies",
    "Marietta Edgecombe",
    "Terry Boot",
    "Michael Corner",
    "Anthony Goldstein",
    "Ernie Macmillan",
    "Justin Finch-Fletchley",
    "Hannah Abbott",
    "Susan Bones",
    "Zacharias Smith",
    "Lavender Brown",
    "Parvati Patil",
    "Padma Patil",
    "Alicia Spinnet",
    "Katie Bell",
    "Angelina Johnson",
    "Oliver Wood",
    "Fleur Delacour",
    "Viktor Krum"
  ]
  |> Enum.map(fn name ->
    %HogwartsApi.Beings.Student{
      name: name,
      house: Enum.random(houses)
    }
  end)

students = [
  %HogwartsApi.Beings.Student{
    name: "Harry Potter",
    house: :gryffindor
  },
  %HogwartsApi.Beings.Student{
    name: "Ron Weasley",
    house: :gryffindor
  },
  %HogwartsApi.Beings.Student{
    name: "Hermione Granger",
    house: :gryffindor
  },
  %HogwartsApi.Beings.Student{
    name: "Draco Malfoy",
    house: :slytherin
  },
  %HogwartsApi.Beings.Student{
    name: "Luna Lovegood",
    house: :ravenclaw
  },
  %HogwartsApi.Beings.Student{
    name: "Cedric Diggory",
    house: :hufflepuff
  },
  %HogwartsApi.Beings.Student{
    name: "Cho Chang",
    house: :ravenclaw
  },
  %HogwartsApi.Beings.Student{
    name: "Neville Longbottom",
    house: :gryffindor
  },
  %HogwartsApi.Beings.Student{
    name: "Ginny Weasley",
    house: :gryffindor
  }
]

rooms = [
  %HogwartsApi.Scheduling.Room{
    number: "321",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "322",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "323",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "324",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "325",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "326",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  },
  %HogwartsApi.Scheduling.Room{
    number: "327",
    static: true,
    cursed: false,
    haunted: false,
    hexed: false,
    secret_passage: true
  }
]

courses =
  [
    "Advanced Potion Making with Professor Prankenstein",
    "Annoying Hexes and Nuisances 101",
    "Apparition for Clumsy Witches and Wizards",
    "Astral Projection: Traveling Beyond Your Imagination",
    "Broomstick Ballet: Mastering Airborne Dance Moves",
    "Care of Dragons: Tips for Fireproofing Your Eyebrows",
    "Charms and Chocolates: Creating Sweet Spells",
    "Comic Spellcasting: From Puns to Practical Jokes",
    "Defence Against the Dark Tickles",
    "Divination: Predicting the Weather with Frog Croaks",
    "Eccentric Enchantments: Unleashing Your Inner Quirkiness",
    "Enchanted Cooking: Turning Pumpkin Pies into Dancing Puddings",
    "Feline Familiars: Communicating with Catty Companions",
    "Flying on a Whim: Unpredictable Maneuvers for Expert Fliers",
    "Giggle Potions and Hilarity Elixirs",
    "History of Prank Wars: Legendary Mischief-Makers",
    "Hogwarts Haiku: Mastering the Art of Magical Poetry",
    "Invisible Ink and Mischievous Messages",
    "Laughing Charms: Spreading Joy One Giggle at a Time",
    "Magical Creatures Comedy Club",
    "Marauder's Map Mastery: Tracking Trouble and Telling Tales",
    "Metamorphosis Mayhem: Transforming into Inanimate Objects",
    "Mischievous Music: Enchanting Pranks with Musical Instruments",
    "Nargle Hunting: Detecting Hidden Mistletoe Mischief",
    "Ornithology of Owls: Understanding Hoots and Head-turns",
    "Peeves' Poltergeist Academy: How to Cause Chaos",
    "Pig Latin Potions: Turning Spells into Snorts and Grunts",
    "Pixie Taming: The Art of Wrestling Tiny Troublemakers",
    "Practical Jinxes and Jokes",
    "Quibbler Crafting: Creating Outlandish Headlines",
    "Quidditch Quirks: Unconventional Moves for Unpredictable Matches",
    "Secrets of Silly Spells",
    "Shenanigans in the Forbidden Forest: Camouflaging with Centaurs",
    "Singing with Gnomes: Harmonizing with the Garden Dwellers",
    "Slapstick Transfiguration: Turning Noses into Honking Horns",
    "Snack Charms: Conjuring Endless Supplies of Chocolate Frogs",
    "Spells for Scatterbrains: Magic Even Forgetful Witches Can Master",
    "Swamp Dancing: Grooving with Gillyweed",
    "The Art of Whoopee Cushion Transfiguration",
    "The Fluffy Chronicles: Adventures with Three-Headed Dogs",
    "The Great Troll Escape: Surviving a Sing-Along with Mountain Trolls",
    "The Madcap Mixologist: Brew Your Own Laughing Potions",
    "Tickling Hex Techniques and Ticklish Targets",
    "Transfiguration Pranks: Turning Professors into Portraits",
    "Unicorn Riding for the Uncoordinated",
    "Wand Whittling: Crafting Personalized Prank Wands",
    "Wicked Wart Charms: Fashionably Ferocious Facial Transformations",
    "Witch Weekly: Gossip, Fashion, and Scandalous Spells"
  ]
  |> Enum.map(fn name ->
    %HogwartsApi.Scheduling.Course{
      name: name
    }
  end)

courses = [
  %HogwartsApi.Scheduling.Course{
    name: "Potions"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Transfiguration"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Charms"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Defense Against the Dark Arts"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Herbology"
  },
  %HogwartsApi.Scheduling.Course{
    name: "History of Magic"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Astronomy"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Flying"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Muggle Studies"
  },
  %HogwartsApi.Scheduling.Course{
    name: "Divination"
  }
]

authors = [
  "Adalbert Waffling",
  "Bathilda Bagshot",
  "Beatrix Bloxam",
  "Bertha Jorkins",
  "Gilderoy Lockhart",
  "Glanmore Peakes",
  "Hector Dagworth-Granger",
  "Miranda Goshawk",
  "Newt Scamander",
  "Phyllida Spore",
  "Quentin Trimble",
  "Rowena Ravenclaw",
  "Berty Crocker",
  "Orabella Nuttley",
  "Donaghan Tremlett",
  "Flavius Belby",
  "Fulbert the Fearful",
  "Hermione Granger",
  "Jocunda Sykes",
  "Kennilworthy Whisp",
  "Laverne de Montmorency",
  "Merlin",
  "Ptolemy",
  "Sacharissa Tugwood",
  "Wendelin the Weird",
  "Zygmunt Budge",
  "Bathsheda Babbling",
  "Albertus Prospero",
  "Sibyll Trelawney",
  "Cassandra Vablatsky",
  "Devlin Whitehorn",
  "Emeric Switch",
  "Gringott",
  "Helga Hufflepuff",
  "Norvel Twonk",
  "Uric the Oddball",
  "Wilhelmina Grubbly-Plank",
  "Alberic Grunnion",
  "Albus Dumbledore",
  "Arkie Alderton",
  "Artemisia Lufkin",
  "Arkie Philpott",
  "Balfour Blane",
  "Cantankerus Nott",
  "Celestina Warbeck",
  "Cliodna",
  "Daisy Dodderidge",
  "Donisilda Dodderidge",
  "Felix Summerbee",
  "Fifi LaFolle",
  "Fulbert the Fearful",
  "Gifford Ollerton",
  "Glanmore Peakes",
  "Gondoline Oliphant",
  "Gulliver Pokeby",
  "Havelock Sweeting",
  "Ignatia Wildsmith",
  "Jocunda Sykes",
  "Karl Jenkins",
  "Kendra Goshawk",
  "Leopoldina Smethwyck",
  "Madam Pince",
  "Margaret Boothby",
  "Mopsus",
  "Mopsus (herbologist)",
  "Musidora Barkwith",
  "Newton Scamander",
  "Oswald Beamish",
  "Ragnok the Pigeon-Toed",
  "Rolanda Hooch",
  "Rowena Ravenclaw",
  "Sacharissa Tugwood",
  "Thaddeus Thurkell",
  "Walfred Longbottom",
  "Willy Wagstaff",
  "Zamira Gulch",
  "Zygmunt Budge",
  "Armando Dippet",
  "Herpo the Foul",
  "Newton Scamander",
  "Bathilda Bagshot",
  "Adalbert Waffling",
  "Arsenius Jigger",
  "Donaghan Tremlett",
  "Doris Crockford",
  "Ignatius Prewett",
  "Jocunda Sykes",
  "Norvel Twonk",
  "Fifi LaFolle",
  "Jocunda Sykes",
  "Hector Dagworth-Granger"
]

books =
  [
    "A Beginner's Guide to Transfiguration",
    "Advanced Potion-Making",
    "Ancient Runes Made Easy",
    "Astronomy: A Comprehensive Guide",
    "Basic Hexes for the Busy and Vexed",
    "Beginner's Guide to Magical Creatures",
    "Charms and Enchantments for Everyday Use",
    "Defensive Magical Theory",
    "Dragon Species of Great Britain and Ireland",
    "Fantastic Beasts and Where to Find Them",
    "Gadding with Ghouls",
    "Gilderoy Lockhart's Guide to Household Pests",
    "Hogwarts: A History",
    "Magical Drafts and Potions",
    "Moste Potente Potions",
    "One Thousand Magical Herbs and Fungi",
    "Quidditch Through the Ages",
    "The Dark Forces: A Guide to Self-Protection",
    "The Monster Book of Monsters",
    "The Tales of Beedle the Bard",
    "Transfiguration Today",
    "Unfogging the Future",
    "Wanderings with Werewolves",
    "A Guide to Advanced Arithmancy",
    "Alchemy: From Basics to Mastery",
    "Apparition: A Step-by-Step Guide",
    "Arithmancy for Beginners",
    "Curses and Counter-Curses",
    "Dark Arts Defense: Basics for Beginners",
    "Enchanting Elixirs and Potions",
    "Famous Wizarding Duels",
    "Ghosts of Hogwarts: History and Hauntings",
    "History of Magic: A Comprehensive Study",
    "Intermediate Transfiguration",
    "Magical Theory",
    "My Life as a Squib",
    "Notable Incantations and Spells",
    "Potions in Practice",
    "Practical Defensive Magic and Its Uses",
    "The Essential Book of Charms and Spells",
    "The Rise and Fall of the Dark Arts",
    "The Standard Book of Spells (Grade 1)",
    "The Standard Book of Spells (Grade 2)",
    "The Standard Book of Spells (Grade 3)",
    "The Standard Book of Spells (Grade 4)",
    "The Standard Book of Spells (Grade 5)",
    "The Standard Book of Spells (Grade 6)",
    "The Standard Book of Spells (Grade 7)",
    "Transfiguration for the Advanced Student",
    "Unbreakable Vows and Their Consequences",
    "A Comprehensive Guide to Magical Plants",
    "Advanced Charms and Enchantments",
    "Advanced Transfiguration",
    "Animagus: A Complete Guide",
    "Apparition: Beyond the Basics",
    "Astrology and Divination",
    "Beyond the Veil: Death and the Afterlife",
    "Cauldrons: A History and Practical Guide",
    "Dark Creatures: A Guide to Defense",
    "Dragon Taming: From Egg to Adult",
    "Encyclopedia of Wizarding History",
    "Famous Wizarding Schools Around the World",
    "Ghosts: The Invisible Residents",
    "Healing Herbs and Their Uses",
    "Herbology: Beyond Mandrakes",
    "Intermediate Potions",
    "Magical Architecture and Enchanting Structures",
    "Magical Hieroglyphs and Logograms",
    "Magical Symbols and Their Meanings",
    "Magical Transportation: Portkeys and Beyond",
    "Necromancy: Exploring the Dark Arts",
    "Occlumency: Shielding the Mind"
  ]
  |> Enum.map(fn title ->
    %HogwartsApi.Scheduling.Book{
      title: title,
      author: Enum.random(authors)
    }
  end)

# books = [
#   %HogwartsApi.Scheduling.Book{
#     title: "Baby's First Elixir - the non-alcoholic version",
#     author: "Jose Valim"
#   },
#   %HogwartsApi.Scheduling.Book{
#     title: "Killer Spells to send peeps to hell",
#     author: "Voldermort"
#   },
#   %HogwartsApi.Scheduling.Book{
#     title: "How to be a good guy",
#     author: "Severus Snape"
#   },
#   %HogwartsApi.Scheduling.Book{
#     title: "How to be a bad guy",
#     author: "Voldermort"
#   }
# ]

professors = Enum.map(professors, &HogwartsApi.Repo.insert!(&1))
students = Enum.map(students, &HogwartsApi.Repo.insert!(&1))
# professors = Enum.map(professors, &HogwartsApi.Repo.insert!(&1))
courses = Enum.map(courses, &HogwartsApi.Repo.insert!(&1))
books = Enum.map(books, &HogwartsApi.Repo.insert!(&1))
rooms = Enum.map(rooms, &HogwartsApi.Repo.insert!(&1))

Enum.map(courses, fn course ->
  b = Enum.random(books)
  HogwartsApi.Repo.insert(%HogwartsApi.Scheduling.CourseBook{course: course, book: b})
end)

semesters = [
  "Fall Semester",
  "Spring Semester",
  "Summer Semester",
  "Winter Semester",
  "Autumn Semester",
  "Spring/Summer Semester",
  "Fall/Winter Semester",
  "Spring/Fall Semester",
  "Summer/Fall Semester",
  "Winter/Spring Semester",
  "Summer/Winter Semester",
  "Fall/Spring Semester",
  "Winter/Fall Semester",
  "Spring/Winter Semester",
  "Year-long Semester"
]

years = [
  "2023",
  "2024"
]

start_times = [
  "8:00 AM",
  "9:30 AM",
  "10:45 AM",
  "12:00 PM",
  "1:15 PM",
  "2:30 PM",
  "3:45 PM",
  "5:00 PM",
  "6:15 PM",
  "7:30 PM",
  "8:45 PM",
  "10:00 PM",
  "11:15 PM",
  "12:30 AM",
  "1:45 AM"
]

sections_test =
  Stream.repeatedly(fn ->
    %HogwartsApi.Scheduling.Section{
      time: Enum.random(start_times),
      semester: "#{Enum.random(semesters)} #{Enum.random(years)}",
      course: courses |> Enum.random(),
      professor: professors |> Enum.random(),
      room: rooms |> Enum.random()
    }
  end)
  |> Enum.take(400)

section1 = %HogwartsApi.Scheduling.Section{
  time: "9:00am",
  semester: "Fall 2023",
  course: courses |> Enum.random(),
  professor: professors |> Enum.random(),
  room: rooms |> Enum.random()
}

section2 = %HogwartsApi.Scheduling.Section{
  time: "10:00am",
  semester: "Fall 2023",
  course: courses |> Enum.random(),
  professor: professors |> Enum.random(),
  room: rooms |> Enum.random()
}

section3 = %HogwartsApi.Scheduling.Section{
  time: "11:00am",
  semester: "Fall 2023",
  course: courses |> Enum.random(),
  professor: professors |> Enum.random(),
  room: rooms |> Enum.random()
}

section4 = %HogwartsApi.Scheduling.Section{
  time: "12:00pm",
  semester: "Fall 2023",
  course: courses |> Enum.random(),
  professor: professors |> Enum.random(),
  room: rooms |> Enum.random()
}

sections = Enum.map(sections_test, &HogwartsApi.Repo.insert!(&1))

Enum.map(sections, fn section ->
  random_students = Enum.take(students, 10)

  Enum.map(random_students, fn student ->
    HogwartsApi.Repo.insert(%HogwartsApi.Scheduling.StudentSection{
      section: section,
      student: student
    })
  end)
end)
