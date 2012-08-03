" Evan's personalized color scheme
" Maintainer: Evan Morikawa
" Last Change: 2011 August 8
"
" Balanced theme to look good on dark backgrounds while providing strong
" colors for key elements and weak, but balanced colors for more common
" elements
"
" COLOR SCHEME:
" red   - #B35E4D at 20% #402E2B
" green - #558C57 at 20% #2b372e
" blue  - #669991 at 20% #2f3a38
" tan   - #D9BF8C at 20% #474138
" camel - #CF984F at 20% #463a2d
"
" The functions in this theme that convert hex color codes to the nearest
" terminal color were developed by Henry So, Jr. 

set background=dark
if version > 580
  " no guarantees for version 5.8 and below, but this makes it stop
  " complaining
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif
let g:colors_name="evan"

if &t_Co == 88 || &t_Co == 256
  " functions {{{
  " returns an approximate grey index for the given grey level
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " returns the palette index for the given grey index
  fun <SID>grey_color(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " returns an approximate color index for the given color level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " returns the actual color level for the given color index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " returns the palette index for the given R/G/B color indices
  fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " returns the palette index to approximate the given R/G/B color levels
  fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " there are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " use the grey
        return <SID>grey_color(l:gx)
      else
        " use the color
        return <SID>rgb_color(l:x, l:y, l:z)
      endif
    else
      " only one possibility
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  endfun

  " returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return <SID>color(l:r, l:g, l:b)
  endfun

  " sets the highlighting for the given group
  fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
      exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
    if a:bg != ""
      exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
  endfun

  " syntax highlighting groups
  call <SID>X("Normal",          "D9C7A8", "", "")

  call <SID>X("Pmenu",           "A39069", "333333", "")
  call <SID>X("PmenuSel",        "D9C7A8", "555555", "bold")

  call <SID>X("Statement",       "669991", "", "bold")
  call <SID>X("Type",            "669991", "", "")
  call <SID>X("PreProc",         "669991", "", "")
  call <SID>X("htmlTag",         "669991", "", "")
  call <SID>X("htmlEndTag",      "669991", "", "")
  call <SID>X("pythonBuiltin",   "669991", "", "")

  call <SID>X("Identifier",      "558C57", "", "")
  call <SID>X("Special",         "558C57", "", "")
  call <SID>X("htmlArg",         "558C57", "", "")

  call <SID>X("Function",        "B35E4D", "", "")
  call <SID>X("coffeeObjAssign", "B35E4D", "", "")
  call <SID>X("coffeeConstant",  "B35E4D", "", "")
  call <SID>X("djangoTagBlock",  "B35E4D", "", "")
  call <SID>X("djangoStatement", "B35E4D", "", "")

  call <SID>X("Comment",         "666666", "", "")

  call <SID>X("String",          "D9BF8C", "", "")
  call <SID>X("Number",          "D9BF8C", "", "")
  call <SID>X("Constant",        "D9BF8C", "", "")

  call <SID>X("Folded",          "888888", "333333", "")

  call <SID>X("Error",           "B35E4D", "", "")
  call <SID>X("Todo",            "000000", "B3893F", "")

  call <SID>X("Visual",          "", "3b3b3b", "")

  call <SID>X("Search",          "222222", "D9BF8C", "bold")

  call <SID>X("ColorColumn",     "222222", "", "")
  call <SID>X("cSpaceError",     "444444", "", "")
  call <SID>X("NonText",         "444444", "", "")
  call <SID>X("SpecialKey",      "333333", "", "")
  call <SID>X("VertSplit",       "444444", "", "")
  call <SID>X("LineNr",          "444444", "", "")
  call <SID>X("StatusLineNC",    "444444", "", "")
  call <SID>X("StatusLine",      "666666", "", "")

  call <SID>X("LineTooLong",      "", "333333", "")


  " delete functions {{{
  delf <SID>X
  delf <SID>rgb
  delf <SID>color
  delf <SID>rgb_color
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_color
  delf <SID>grey_level
  delf <SID>grey_number
  " }}}
endif

" Set colors for GUI Version
hi Normal   guifg=#D9C7A8 guibg=#222222

hi Pmenu    guifg=#A39069 guibg=#333333
hi PmenuSel guifg=#D9C7A8 guibg=#555555 gui=bold

hi Statement     guifg=#669991
hi Type          guifg=#669991
hi PreProc       guifg=#669991
hi htmlTag       guifg=#669991
hi htmlEndTag    guifg=#669991
hi pythonBuiltin guifg=#669991

hi Identifier guifg=#558C57
hi Special    guifg=#558C57
hi htmlArg    guifg=#558C57

hi Function        guifg=#B35E4D
hi coffeeObjAssign guifg=#B35E4D
hi coffeeObject    guifg=#B35E4D
hi coffeeConstant  guifg=#B35E4D
hi djangoTagBlock  guifg=#B35E4D
hi djangoStatement guifg=#B35E4D

hi Comment  guifg=#666666

hi String   guifg=#D9BF8C
hi Number   guifg=#D9BF8C
hi Constant guifg=#D9BF8C

hi Folded   guifg=#888888 guibg=#333333

hi Error    guifg=#222222 guibg=#B35E4D
hi Todo     guifg=#000000 guibg=#B3893F

hi Visual   guibg=#3b3b3b

hi Search   guifg=#222222 guibg=#CF984F

hi ColorColumn  guifg=#222222
hi cSpaceError  guifg=#444444
hi NonText      guifg=#444444
hi SpecialKey   guifg=#333333
hi VertSplit    guifg=#444444
hi LineNr       guifg=#444444
hi StatusLineNC guifg=#444444
hi StatusLine   guifg=#666666

hi LineTooLong  guibg=#333333

hi Title        guifg=#D9C865 gui=bold
hi markdownH1   guifg=#D9C865 guibg=#3d381b gui=bold
hi markdownH2   guifg=#D9C865 gui=bold
hi markdownH3   guifg=#D9C866
hi markdownH4   guifg=#D9C865

hi DiffAdd      guibg=#2f3d2f
hi DiffChange   guibg=#342c36
hi DiffText     guibg=#56415c
hi DiffDelete   guifg=#723b30 guibg=#46312d

" hi DiffAdd      guibg=#2b372e
" hi DiffChange   guibg=#2f3a38
" hi DiffText     guibg=#463a2d
" hi DiffDelete   guibg=#402E2B
