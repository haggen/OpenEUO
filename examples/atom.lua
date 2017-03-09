----------------------------
-- Bank Account Simulator --
-- Atomic Functions Demo! --
----------------------------

-- THEORY BEHIND THIS SCRIPT:
-- Several clients transfer funds from their
-- local bank accounts into a single global 
-- target account. Problem: Writes can be lost
-- if they don't occur in a serialized fashion.
--
-- Increment operation example:
--   (1) read:  x = balance B
--   (2)
--   (3) write: balance B = x + 1
--
-- If another script updates balance B in (2)
-- then that update will be overwritten by (3).
-- That means money disappears miraculously!

-- INSTRUCTIONS:
-- Open this script 10 times. Start 9 of them
-- right away (they will run as slaves, m=0).
-- Modify m in the config section of the 10th
-- script (1=insecure, 2=secure). Start and
-- see what happens. End balance B should be
-- $1000 (balance A multiplied by nr of scripts)

-- CONFIG SECTION ----------

   a = 100                             -- this script's start balance

   m = 0                               -- run mode:
                                       -- 0 = slave
                                       -- 1 = master, insecure transfers
                                       -- 2 = master, secure   transfers

----------------------------
-- Do not edit below this --
----------------------------

function init()
  math.randomseed(gettime())           --initialize random function
  if m>0 then                          --am i master?
    setatom("b",0)                     --reset target account
    setatom("s",m==2)                  --set secure/insecure
    setatom("g",true)                  --send start signal
  else
    setatom("g",false)                 --reset start signal
    print("waiting on master...")
    repeat
      wait(50)
    until getatom("g")                 --wait for start signal
  end
end

----------------------------

local function sloppywait(t)
  wait(t + math.random(-t/10,t/10))    --wait t milliseconds +/-10%
end

----------------------------

local function lazyget(s)
  local b = getatom(s)                 --waits 10ms before returning
  wait(10)                             --balance B which gives other
  return b                             --scripts the opportunity to
end                                    --cause problems ;-)

----------------------------

function isend(x)                      --insecure send
  local b = lazyget("b")
  setatom("b",b+x)                     --update b insecurely!
  a = a - x                            --wihdraw from local account
end

----------------------------

function ssend(x)                      --secure send
  local b = lazyget("b")
  if cmpsetatom("b",b,b+x) then        --bsuccess = cmpsetatom(sname,expected,new)
    a = a - x                          --only withdraw if write was successful.
  end                                  --(cmpsetatom will not write if balance~=expected)
end

----------------------------

function main()
  repeat
    if a>0 then                        --only send as long as we have money
      if getatom("s") then
        ssend(1)                       --secure
      else
        isend(1)                       --insecure
      end
    end
    print("Balance: A="..a.." B="..getatom("b"))
    sloppywait(190)
 until false
end

----------------------------

init()
main()
