import Parsing
import Data.List.Split

beep :: IO ()
beep = putStr "\BEL"

cls :: IO ()
cls = putStr "\ESC[2J"

type Pos = (Int, Int)

goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

writeat :: Pos -> String -> IO ()
writeat p xs = do goto p
                  putStr xs

box :: [String]
box = ["+---------------+",
       "|               |",
       "+---+---+---+---+",
       "| q | c | d | = |",
       "+---+---+---+---+",
       "| 1 | 2 | 3 | + |",
       "+---+---+---+---+",
       "| 4 | 5 | 6 | - |",
       "+---+---+---+---+",
       "| 7 | 8 | 9 | * |",
       "+---+---+---+---+",
       "| 0 | ( | ) | / |",
       "+---+---+---+---+"]

buttons :: [Char]
buttons = standard ++ extra
         where
           standard = "qcd=123+456-879*0()/"
           extra = "QCD \ESC\BS\DEL\n"

showbox :: IO ()
showbox = sequence_ [writeat (1, y) xs | (y, xs) <- zip [1..13] box]

display :: String -> IO ()
display xs = do
  writeat (3, 2) "             "
  writeat (3, 2) (reverse (take 13 (reverse xs)))

calc :: String -> IO ()
calc xs = do
  display xs
  c <- getChar
  if elem c buttons then
    process c xs
  else
    do beep
       calc xs

process :: Char -> String -> IO ()
process c xs
 | elem c "qQ\ESC"    = quit
 | elem c "dD\BS\DEL" = delete xs
 | elem c "=\n"       = eval xs
 | elem c "cC"        = clear
 | otherwise          = press c xs

quit :: IO ()
quit = goto (1, 14)

delete :: String -> IO ()
delete "" = calc ""
delete xs = calc (init xs)

eval :: String -> IO ()
eval xs = case parse expr xs of
   [(n, "")] -> calc (show n)
   [(_, out)] -> do
                   let init = head (splitOn out xs)
                   calc init

clear :: IO ()
clear = calc ""

press :: Char -> String -> IO ()
press c xs = calc (xs ++ [c])

run :: IO ()
run = do
  cls
  showbox
  clear
