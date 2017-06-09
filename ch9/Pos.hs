-- ビープ音がなる
beep :: IO ()
beep = putStr " \BEL"

-- 画面をクリアする
cls :: IO()
cls = putStr " \ESC[2J"

-- ghc -e sample1 Pos.hs
sample1 :: IO()
sample1 = do
  beep
  cls

type Pos = (Int, Int)

goto :: Pos -> IO()
goto (x,y) =
  putStr("\ESC[" ++ show y ++ ":" ++ show x ++ "H")

-- ghc -e sample2 Pos.hs
sample2 = do
  cls
  goto(0,10)

writreat :: Pos -> String -> IO()
writreat p xs = do
  goto p
  putStr xs

seqn :: [IO a] -> IO()
seqn [] = return ()
seqn (a:as) = do
  a
  seqn as

sample3 :: IO()
sample3 = do
  cls
  writreat (10,10) "hogehoge"

--
-- -- リスト内包表記
-- putStr xs = seqn[putChar x | x <- xs]
