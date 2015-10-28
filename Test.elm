import Graphics.Element exposing (show)


type Relation = Friend | FriendOfFriend String | Stranger

peter = { name = "Peter", relation = Friend }

type alias Contact = 
  { name : String
  , relation : Relation
  }

lucy = Contact "Lucy" Friend  -- type constructor
anna = Contact "Anna" (FriendOfFriend "Peter")
bob = { anna | name <- "Bob" }  -- syntax changing in 0.16.0 !
eric = Contact "Eric" Stranger

greeting contact =
  let prefix = 
      case contact.relation of
        Stranger -> "Hello "
        _ -> "Hi "

      append =
        case .relation contact of  -- `(.name)` to access field of record
          Friend -> " my friend"
          FriendOfFriend name -> " friend of " ++ name
          Stranger -> ""

  in prefix ++ contact.name ++ append

main = show <| List.map greeting [peter, anna, lucy, bob, eric]
  

