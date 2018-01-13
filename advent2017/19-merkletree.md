
merkletree library - Build Your Own Crypto Hash Trees; Grow Your Own Money on Trees


github: [openblockchains/merkletree.rb](https://github.com/openblockchains/merkletree.rb),
rubygems: [merkletree](https://rubygems.org/gems/merkletree),
rdoc: [merkletree](http://rubydoc.info/gems/merkletree) ++
more: [comments on reddit, please!](https://www.reddit.com/r/ruby/comments/7ktud7/day_19_ruby_advent_calendar_2017_merkletree_build/)


## What's a Merkle Tree?

> A Merkle tree or hash tree is a tree in which every leaf node is labelled with
> the hash of a data block and every non-leaf node is labelled with the
> cryptographic hash of the labels of its child nodes.
> Hash trees allow efficient and secure verification of the
> contents of large data structures. [...]
>
> The concept of hash trees is named after Ralph Merkle
> who patented it in 1979.
>
> -- [Wikipedia](https://en.wikipedia.org/wiki/Merkle_tree)


## Usage


Pass along all (leaf / data block) hashes as strings or packaged in an array.
Example:

``` ruby
merkle = MerkleTree.new(
  'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
  'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
  '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' )

# -or-

merkle = MerkleTree.new( [
  'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
  'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
  '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' ])


puts merkle.root.value
# => '25fd59b79d70bbdf043d66a7b0fc01409d11b990e943bb46b840fbbddd5ab895'

pp merkle    ## pp (pretty print)
```

resulting in:

```
@root = #<MerkleTree::Node:0x46b55e0
   @left = #<MerkleTree::Node:0x46b6060
     @left = #<MerkleTree::Node:0x46b6870
       @left  = nil,
       @right = nil,
       @value = "eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743">,
     @right = #<MerkleTree::Node:0x46b6810
       @left  = nil,
       @right = nil,
       @value = "edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b">,
     @value = "c9de03ced4db3c63835807016b1efedb647c694d2db8b9a8579cbf0c5dcb5ab0">,
   @right= #<MerkleTree::Node:0x46b5ca0
     @left= #<MerkleTree::Node:0x46b6798
       @left  = nil,
       @right = nil,
       @value = "5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d">,
     @right = #<MerkleTree::Node:0x46b6798
       @left  = nil,
       @right = nil,
       @value = "5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d">,
     @value = "50963aa3b2047e0d58bb850fc12e5a324cf01061af55889389be72d3849e1d03">,
   @value="25fd59b79d70bbdf043d66a7b0fc01409d11b990e943bb46b840fbbddd5ab895">>
```


Use `MerkleTree.compute_root` for computing the root (crypto) hash without building a
tree. Example:

``` ruby
merkle_root_value = MerkleTree.compute_root(
  'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
  'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
  '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' )

# -or-

merkle_root_value = MerkleTree.compute_root( [
  'eb8ecbf6d5870763ae246e37539d82e37052cb32f88bb8c59971f9978e437743',
  'edbd4e11e69bc399a9ccd8faaea44fb27410fe8e3023bb9462450a0a9c4caa1b',
  '5ee2981606328abfe0c3b1171440f0df746c1e1f8b3b56c351727f7da7ae5d8d' ])


puts merkle_root_value
# => '25fd59b79d70bbdf043d66a7b0fc01409d11b990e943bb46b840fbbddd5ab895'
```


### Transactions

Use `MerkleTree.for` or `MerkleTree.compute_root_for` for passing along transactions.
Will use `to_s` on every transaction and use the resulting "serialized" string
to (auto-) calculate the (crypto) hash.

Let's put the transactions from the (hyper) ledger book from [Tulips on the Blockchain!](https://github.com/openblockchains/tulips)
on the ~~blockchain~~ merkle tree:


| From                | To           | What                      | Qty |
|---------------------|--------------|---------------------------|----:|
| Bloom & Blossom (†) | Daisy        | Tulip Admiral of Admirals |   8 |
| Vincent             | Max          | Tulip Bloemendaal Sunset  |   2 |
| Anne                | Martijn      | Tulip Semper Augustus     |   2 |
| Ruben               | Julia        | Tulip Admiral van Eijck   |   2 |

(†): Grower Transaction - New Tulips on the Market!

``` ruby
merkle = MerkleTree.for(
  { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
  { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
  { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
  { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )

puts merkle.root.value
# => '703f44630117ef9b4ac20cb149ed8a0f06e4c3ed2a791e11e16a2fe7a7d0de3d'

# -or-

merkle_root_value = MerkleTree.compute_root_for(
  { from: "Bloom & Blossom", to: "Daisy",   what: "Tulip Admiral of Admirals", qty: 8 },
  { from: "Vincent",         to: "Max",     what: "Tulip Bloemendaal Sunset",  qty: 2 },
  { from: "Anne",            to: "Martijn", what: "Tulip Semper Augustus",     qty: 2 },
  { from: "Ruben",           to: "Julia",   what: "Tulip Admiral van Eijck",   qty: 2 } )

puts merkle_root_value
# => '703f44630117ef9b4ac20cb149ed8a0f06e4c3ed2a791e11e16a2fe7a7d0de3d'
```
