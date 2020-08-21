function print_r ( t )
  local print_r_cache={}
  local function sub_print_r(t,indent)
    if (print_r_cache[tostring(t)]) then
      print(indent.."*"..tostring(t))
    else
      print_r_cache[tostring(t)]=true
      if (type(t)=="table") then
        for pos,val in pairs(t) do
          if (type(val)=="table") then
            print(indent.."["..pos.."] => "..tostring(t).." {")
            sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
            print(indent..string.rep(" ",string.len(pos)+6).."}")
          elseif (type(val)=="string") then
            print(indent.."["..pos..'] => "'..val..'"')
          else
            print(indent.."["..pos.."] => "..tostring(val))
          end
        end
      else
        print(indent..tostring(t))
      end
    end
  end
  if (type(t)=="table") then
    print(tostring(t).." {")
    sub_print_r(t,"  ")
    print("}")
  else
    sub_print_r(t,"  ")
  end
  print()
end



-- k模式
--local a = {1, 4, name = "cq"}
--setmetatable(a, {__mode = "k"})
--local key = {}
--a[key] = "key1"
--key = {}
--a[key] = "key2"
--
--
--print("before GC")
--for k, v in pairs(a) do
--    print(k, "\t", v)
--end
--
--collectgarbage()
--print("\nafter GC")
--
--for k, v in pairs(a) do
--    print(k, "\t", v)
--end

-- 简单v模式
test = {}
setmetatable(test, {__mode='v'})
local a = {22}
local b = {33}
test[1] = a
test[2] = b

a = nil
collectgarbage()

print_r(test)


--v模式
--local results = {}
--
--setmetatable(results, {__mode='v'})
--
--function mem_loadstring(s)
--
--    local res = results[s]
--
--    if res == nil then
--        res=assert(loadstring(s))
--        results[s]=res
--    end
--
--    return res
--end 
--
--local a = mem_loadstring("print 'hello'")
--local b = mem_loadstring("print 'world'")
--
--a = nil
--
--collectgarbage()
--
--for k,v in pairs(results) do
--    print(k, '\t', v)
--end



