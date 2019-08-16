module Serialization

import Bytes.Decode as Decode exposing (Decoder, andThen)

{- unknownTag cannot be implemented due to missing error handler in Bytes.Decode
type DecodeError
  = UnknownTag String Int {- Word8 -}
-}

type SeqOp = Cons | Snoc | Concat

type Int64 = Int Int

type VarInt
  = Debug.Todo ""

type Hash
  = Debug.Todo ""

type Causal
  = Debug.Todo ""



{-
unknownTag cannot be implemented due to no error handling in Bytes.Decode
-}


seqOpDecoder : Decoder SeqOp
seqOpDecoder = Decode.unsignedInt8 andThen
  (\n -> case n of
    0 -> Decoder Cons
    1 -> Decoder Snoc
    2 -> Decoder Concat)

unsignedInt64 : Int64
unsignedInt64 = Decode.map2
  (\a b -> Int64 a b)
  (Decode.unSignedInt32)
  (Decode.unSignedInt32)

booleanDecoder : Decoder Bool
booleanDecoder = Decoder Decode.unsignedInt8 andThen
  (\n -> case n of
    0 -> Decoder False
    1 -> Decoder True
    _ -> Debug.todo "" -- no unknownTag error handling available
  )

intDecoder : Decoder Int64
intDecoder = Decoder unsignedInt64


floatDecoder : Decoder Float
floatDecoder = Decode.Float64

textDecoder : Decoder Text
textDecoder = Debug.Todo ""

varIntDecoder : Decoder VarInt 
varIntDecoder = Decoder VarInt

hashDecoder : Decoder Hash

causalDecoder : 
