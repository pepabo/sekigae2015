let s:seed = localtime()
 
function! s:rand()
  let s:seed = s:seed * 214013 + 2531011
  return (s:seed < 0 ? s:seed - 0x80000000 : s:seed) / 0x10000 % 0x8000
endfunction

function! s:sekigae(file) abort
  let a = readfile(a:file)
  let l = len(a)
  for i in range(l)
     let j = s:rand() % l
     let [a[j], a[i]] = [a[i], a[j]]
  endfor
  for i in range(l)
    echon a[i]
    if i % 3 < 2
      echon " "
    else
      echo ""
    endif
  endfor
endfunction

command! -nargs=1 -complete=file Sekigae call s:sekigae(<q-args>)
