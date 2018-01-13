
_Revolutionize the world with blockchains, blockchains, blockchains one block at a time!_

# blockchain-lite library - Build Your Own Blockchains with Crypto Hashes

github: [openblockchains/blockchain.lite.rb](https://github.com/openblockchains/blockchain.lite.rb),
rubygems: [blockchain-lite](https://rubygems.org/gems/blockchain-lite),
rdoc: [blockchain-lite](http://rubydoc.info/gems/blockchain-lite)  ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7gv042/day_1_ruby_advent_calendar_2017_blockchainlite/)


## What's a Blockchain?

> A blockchain is a distributed database with
> a list (that is, chain) of records (that is, blocks)
> linked and secured by digital fingerprints
> (that is, crypto hashes).

See the [Awesome Blockchains](https://github.com/openblockchains/awesome-blockchains) page for more.


## Let's Get Started.

Build your own blockchain one block at a time. Example:

``` ruby
require 'blockchain-lite'

b0 = Block.first( 'Genesis' )
b1 = Block.next( b0, 'Transaction Data...' )
b2 = Block.next( b1, 'Transaction Data......' )
b3 = Block.next( b2, 'More Transaction Data...' )

blockchain = [b0, b1, b2, b3]

pp blockchain
```

will pretty print (pp) something like:

```
[#<Block:0x1eed2a0
  @index         = 0,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Genesis",
  @previous_hash = "0",
  @hash          ="edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
 #<Block:0x1eec9a0
  @index         = 1,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Transaction Data...",
  @hash          = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743",
  @previous_hash = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
 #<Block:0x1eec838
  @index         = 2,
  @timestamp     = 2017-09-15 20:52:38,
  @data          = "Transaction Data......",
  @hash          = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4",
  @previous_hash = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743">,
 #<Block:0x1eec6d0
  @index         = 3,
  @timestamp     = 2017-09-15 20:52:38
  @data          = "More Transaction Data...",
  @hash          = "5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d",
  @previous_hash = "be50017ee4bbcb33844b3dc2b7c4e476d46569b5df5762d14ceba9355f0a85f4">]
```


### Blocks

Supported block types / classes for now include basic and proof-of-work.


#### Basic

``` ruby
class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @data          = data
    @previous_hash = previous_hash
    @hash          = calc_hash
  end

  def calc_hash
    sha = Digest::SHA256.new
    sha.update( @index.to_s + @timestamp.to_s + @data + @previous_hash )
    sha.hexdigest
  end
  ...
end
```


Comments from the [reddit ruby posting](https://www.reddit.com/r/ruby/comments/70c30f/build_your_own_blockchain_in_20_lines_of_ruby/):

> Wait, so a blockchain is just a linked list?
>
>> No. A linked list is only required to have a reference to the previous element, a block must
>> have an identifier depending on the previous block's identifier, meaning that you cannot
>> replace a block without recomputing every single block that comes after.
>> In this implementation that happens as the previous digest is input in the calc_hash method.



#### Proof-of-Work

``` ruby
class Block

  attr_reader :index
  attr_reader :timestamp
  attr_reader :data
  attr_reader :previous_hash
  attr_reader :nonce        ## proof of work if hash starts with leading zeros (00)
  attr_reader :hash

  def initialize(index, data, previous_hash)
    @index         = index
    @timestamp     = Time.now.utc    ## note: use coordinated universal time (utc)
    @data          = data
    @previous_hash = previous_hash
    @nonce, @hash  = compute_hash_with_proof_of_work
  end
  ...
end
```

Let's add a proof of work to the blockchain.
In the classic blockchain you have to compute a block hash that starts with leading zeros (`00`). The more leading zeros the harder (more difficult) to compute. Let's keep it easy to compute with two leading zeros (`00`), that is, 16^2 = 256 possibilites (^1,2). Three leading zeros (`000`) would be 16^3 = 4_096 possibilites and four zeros (`0000`) would be 16^4 = 65_536 and so on.

(^1): 16 possibilties because it's a hex or hexadecimal or base 16 number, that is, `0` `1` `2` `3` `4` `6` `7` `8` `9` `a` (10) `b` (11) `c` (12) `d` (13) `e` (14) `f` (15).

(^2): A random secure hash algorithm needs on average 256 tries (might be lets say 305 tries, for example, because it's NOT a perfect statistic distribution of possibilities).

Example:

```ruby
def compute_hash_with_proof_of_work( difficulty="00" )
  nonce = 0
  loop do
    hash = calc_hash_with_nonce( nonce )
    if hash.start_with?( difficulty )  
      return [nonce,hash]     ## bingo! proof of work if hash starts with leading zeros (00)
    else
      nonce += 1              ## keep trying (and trying and trying)
    end
  end
end

def calc_hash_with_nonce( nonce=0 )
  sha = Digest::SHA256.new
  sha.update( nonce.to_s + @index.to_s + @timestamp.to_s + @data + @previous_hash )
  sha.hexdigest
end
```

Let's rerun the sample with the proof of work machinery added.
Now the sample will pretty print (pp) something like:

```
[#<Block:0x1e204f0
  @index         = 0,
  @timestamp     = 1637-09-20 20:13:38,
  @data          = "Genesis",
  @previous_hash = "0",
  @nonce         = 242,
  @hash          = "00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf">,
 #<Block:0x1e56e20
  @index         = 1,
  @timestamp     = 1637-09-20 20:23:38,
  @data          = "Transaction Data...",
  @previous_hash = "00b8e77e27378f9aa0afbcea3a2882bb62f6663771dee053364beb1887e18bcf",
  @nonce         = 46,
  @hash          = "00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af">,
 #<Block:0x1e2bd58
  @index         = 2,
  @timestamp     = 1637-09-20 20:33:38,
  @data          = "Transaction Data......",
  @previous_hash = "00aae8d2e9387e13c71b33f8cd205d336ac250d2828011f5970062912985a9af",
  @nonce         = 350,
  @hash          = "00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190">,
 #<Block:0x1fa8338
  @index         = 3,
  @timestamp     = 1637-09-20 20:43:38,
  @data          = "More Transaction Data...",
  @previous_hash = "00ea45e0f4683c3bec4364f349ee2b6816be0c9fd95cfd5ffcc6ed572c62f190",
  @nonce         = 59,
  @hash          = "00436f0fca677652963e904ce4c624606a255946b921132d5b1f70f7d86c4ab8">]
```

See the difference? All hashes now start with leading zeros (`00`) and the nonce is the random "lucky number"
that makes it happen. That's the magic behind the proof of work.


### Transactions

Let's put the transactions from the (hyper) ledger book
from [Tulips on the Blockchain!](https://github.com/openblockchains/tulips)
on the blockchain:


| From                | To           | What                      | Qty |
|---------------------|--------------|---------------------------|----:|
| Dutchgrown (†)      | Vincent      | Tulip Bloemendaal Sunset  |  10 |
| Keukenhof (†)       | Anne         | Tulip Semper Augustus     |   7 |
|                     |              |                           |     |
| Flowers (†)         | Ruben        | Tulip Admiral van Eijck   |   5 |
| Vicent              | Anne         | Tulip Bloemendaal Sunset  |   3 |
| Anne                | Julia        | Tulip Semper Augustus     |   1 |
| Julia               | Luuk         | Tulip Semper Augustus     |   1 |
|                     |              |                           |     |
| Bloom & Blossom (†) | Daisy        | Tulip Admiral of Admirals |   8 |
| Vincent             | Max          | Tulip Bloemendaal Sunset  |   2 |
| Anne                | Martijn      | Tulip Semper Augustus     |   2 |
| Ruben               | Julia        | Tulip Admiral van Eijck   |   2 |
|                     |              |                           |     |
| Teleflora (†)       | Max          | Tulip Red Impression      |  11 |
| Anne                | Naomi        | Tulip Bloemendaal Sunset  |   1 |
| Daisy               | Vincent      | Tulip Admiral of Admirals |   3 |
| Julia               | Mina         | Tulip Admiral van Eijck   |   1 |

(†): Grower Transaction - New Tulips on the Market!


```ruby
b0 = Block.first(
        { from: "Dutchgrown", to: "Vincent", what: "Tulip Bloemendaal Sunset", qty: 10 },
        { from: "Keukenhof",  to: "Anne",    what: "Tulip Semper Augustus",    qty: 7  } )

b1 = Block.next( b0,
        { from: "Flowers", to: "Ruben", what: "Tulip Admiral van Eijck",  qty: 5 },
        { from: "Vicent",  to: "Anne",  what: "Tulip Bloemendaal Sunset", qty: 3 },
        { from: "Anne",    to: "Julia", what: "Tulip Semper Augustus",    qty: 1 },
        { from: "Julia",   to: "Luuk",  what: "Tulip Semper Augustus",    qty: 1 } )

b2 = Block.next( b1,
        { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
        { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
        { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
        { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )
...
```

resulting in:

```
[#<Block:0x2da3da0
  @index              = 0,
  @timestamp          = 1637-09-24 11:40:15,
  @previous_hash      = "0",
  @hash               = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @transactions_count = 2,
  @transactions       =
   [{:from=>"Dutchgrown", :to=>"Vincent", :what=>"Tulip Bloemendaal Sunset", :qty=>10},
    {:from=>"Keukenhof",  :to=>"Anne",    :what=>"Tulip Semper Augustus",    :qty=>7}]>,
 #<Block:0x2da2ff0
  @index              = 1,
  @timestamp          = 1637-09-24 11:50:15,
  @previous_hash      = "32bd169baebba0b70491b748329ab631c85175be15e1672f924ca174f628cb66",
  @hash               = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Flowers", :to=>"Ruben", :what=>"Tulip Admiral van Eijck",  :qty=>5},
    {:from=>"Vicent",  :to=>"Anne",  :what=>"Tulip Bloemendaal Sunset", :qty=>3},
    {:from=>"Anne",    :to=>"Julia", :what=>"Tulip Semper Augustus",    :qty=>1},
    {:from=>"Julia",   :to=>"Luuk",  :what=>"Tulip Semper Augustus",    :qty=>1}]>,
 #<Block:0x2da2720
  @index              = 2,
  @timestamp          = 1637-09-24 12:00:15,
  @previous_hash      = "57b519a8903e45348ac8a739c788815e2bd90423663957f87e276307f77f1028",
  @hash               = "ec7dd5ea86ab966d4d4db182abb7aa93c7e5f63857476e6301e7e38cebf36568",
  @transactions_count = 4,
  @transactions       =
   [{:from=>"Bloom & Blossom", :to=>"Daisy",   :what=>"Tulip Admiral of Admirals", :qty=>8},
    {:from=>"Vincent",         :to=>"Max",     :what=>"Tulip Bloemendaal Sunset",  :qty=>2},
    {:from=>"Anne",            :to=>"Martijn", :what=>"Tulip Semper Augustus",     :qty=>2},
    {:from=>"Ruben",           :to=>"Julia",   :what=>"Tulip Admiral van Eijck",   :qty=>2}]>,
 ...
```

That's it. Now revolutionize the world with blockchains one block at a time.
