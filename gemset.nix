{
  addressable = {
    dependencies = ["public_suffix"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0viqszpkggqi8hq87pqp0xykhvz60g99nwmkwsb0v45kc2liwxvk";
      type = "gem";
    };
    version = "2.5.2";
  };
  aws-sdk = {
    dependencies = ["aws-sdk-resources"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rkdkj9s2c9gc2qb9w8k4a2rkv1ydz1harx76kjknz6mrhkln0va";
      type = "gem";
    };
    version = "2.11.29";
  };
  aws-sdk-core = {
    dependencies = ["aws-sigv4" "jmespath"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1mpa14wam72yndkjmcrcpggdkxdqp6wfnw4fd38am12vi92jmhpk";
      type = "gem";
    };
    version = "2.11.29";
  };
  aws-sdk-resources = {
    dependencies = ["aws-sdk-core"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12mxy8lnqfjcxh2b2zdn4k9qlyn7gq5dvqz65z0axdxxyd0vv1fw";
      type = "gem";
    };
    version = "2.11.29";
  };
  aws-sigv4 = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0g0qzy2xkmy6cr1qcz0k53fqgja1732h93vnna4fq5mz55lzlvkl";
      type = "gem";
    };
    version = "1.0.2";
  };
  blankslate = {
    source = {
      sha256 = "0jnnq5q5dwy2rbfcl769vd9bk1yn0242f6yjlb9mnqdm9627cdcx";
      type = "gem";
    };
    version = "2.1.2.4";
  };
  classifier-reborn = {
    dependencies = ["fast-stemmer"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04nxmm5b7j7r0ij9pcpdr7xqpig559gfzrw042ycxcfyav2pv6ij";
      type = "gem";
    };
    version = "2.2.0";
  };
  coffee-script = {
    dependencies = ["coffee-script-source" "execjs"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0rc7scyk7mnpfxqv5yy4y5q1hx3i7q3ahplcp4bq2g5r24g2izl2";
      type = "gem";
    };
    version = "2.4.1";
  };
  coffee-script-source = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xfshhlz808f8639wc88wgls1mww35sid8rd55vn0a4yqajf4vh9";
      type = "gem";
    };
    version = "1.11.1";
  };
  colorator = {
    source = {
      sha256 = "09zp15hyd9wlbgf1kmrf4rnry8cpvh1h9fj7afarlqcy4hrfdpvs";
      type = "gem";
    };
    version = "0.1";
  };
  colored = {
    source = {
      sha256 = "0b0x5jmsyi0z69bm6sij1k89z7h0laag3cb4mdn7zkl9qmxb90lx";
      type = "gem";
    };
    version = "1.2";
  };
  configure-s3-website = {
    dependencies = ["aws-sdk" "deep_merge"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1p07bfbl6vg3vr11cky61lk1y7a5vfifjjwrdjxzqnigfd2s0yf4";
      type = "gem";
    };
    version = "2.3.0";
  };
  deep_merge = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "133ickkx01y9x64nd31chcmsg43p9z2w53jjzlvd7czpbb66ik1d";
      type = "gem";
    };
    version = "1.0.1";
  };
  dotenv = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1g6sdv55842a7iv11wawrbfrx8x5k7gl598nl6my55jb2nbynkmw";
      type = "gem";
    };
    version = "1.0.2";
  };
  execjs = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yz55sf2nd3l666ms6xr18sm2aggcvmb8qr3v53lr4rir32y1yp1";
      type = "gem";
    };
    version = "2.7.0";
  };
  faraday = {
    dependencies = ["multipart-post"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1c3x3s8vb5nf7inyfvhdxwa4q3swmnacpxby6pish5fgmhws7zrr";
      type = "gem";
    };
    version = "0.14.0";
  };
  fast-stemmer = {
    source = {
      sha256 = "0688clyk4xxh3kdb18vi089k90mca8ji5fwaknh3da5wrzcrzanh";
      type = "gem";
    };
    version = "1.0.2";
  };
  ffi = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0zw6pbyvmj8wafdc7l5h7w20zkp1vbr2805ql5d941g2b20pk4zr";
      type = "gem";
    };
    version = "1.9.23";
  };
  jekyll = {
    dependencies = ["classifier-reborn" "colorator" "jekyll-coffeescript" "jekyll-gist" "jekyll-paginate" "jekyll-sass-converter" "jekyll-watch" "kramdown" "liquid" "mercenary" "pygments.rb" "redcarpet" "safe_yaml" "toml"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ad3d62yd5rxkvn3xls3xmr2wnk8fiickjy27g098hs842wmw22n";
      type = "gem";
    };
    version = "2.5.3";
  };
  jekyll-coffeescript = {
    dependencies = ["coffee-script" "coffee-script-source"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06qf4j9f6ysjb4bq6gsdaiz2ksmhc5yb484v458ra3s6ybccqvvy";
      type = "gem";
    };
    version = "1.1.1";
  };
  jekyll-gist = {
    dependencies = ["octokit"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03wz9j6yq3552nzf4g71qrdm9pfdgbm68abml9sjjgiaan1n8ns9";
      type = "gem";
    };
    version = "1.5.0";
  };
  jekyll-paginate = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0r7bcs8fq98zldih4787zk5i9w24nz5wa26m84ssja95n3sas2l8";
      type = "gem";
    };
    version = "1.1.0";
  };
  jekyll-sass-converter = {
    dependencies = ["sass"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "008ikh5fk0n6ri54mylcl8jn0mq8p2nfyfqif2q3pp0lwilkcxsk";
      type = "gem";
    };
    version = "1.5.2";
  };
  jekyll-utf8 = {
    source = {
      sha256 = "1a7db3q6wfg7msqq8wlnys452m4sa78ypqay1yn6gg00igbf25g8";
      type = "gem";
    };
    version = "0.0.1";
  };
  jekyll-watch = {
    dependencies = ["listen"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1f0p3jbvp9gafbddkbpk78gb6837d2qdhw97py3svsk3d9vkbcdn";
      type = "gem";
    };
    version = "1.5.1";
  };
  jmespath = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07w8ipjg59qavijq59hl82zs74jf3jsp7vxl9q3a2d0wpv5akz3y";
      type = "gem";
    };
    version = "1.3.1";
  };
  kramdown = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0mkrqpp01rrfn3rx6wwsjizyqmafp0vgg8ja1dvbjs185r5zw3za";
      type = "gem";
    };
    version = "1.16.2";
  };
  liquid = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "03x4sv58bligc6ghqb5w1k5m9bc23vmdq20a7zkvm0r2g7w4hvf4";
      type = "gem";
    };
    version = "2.6.3";
  };
  listen = {
    dependencies = ["rb-fsevent" "rb-inotify" "ruby_dep"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "01v5mrnfqm6sgm8xn2v5swxsn1wlmq7rzh2i48d4jzjsc7qvb6mx";
      type = "gem";
    };
    version = "3.1.5";
  };
  mercenary = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "10la0xw82dh5mqab8bl0dk21zld63cqxb1g16fk8cb39ylc4n21a";
      type = "gem";
    };
    version = "0.3.6";
  };
  multipart-post = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09k0b3cybqilk1gwrwwain95rdypixb2q9w65gd44gfzsd84xi1x";
      type = "gem";
    };
    version = "2.0.0";
  };
  octokit = {
    dependencies = ["sawyer"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1hp77svmpxcwnfajb324i1g2b7jazg23fn4ccjr5y3lww0rnj1dg";
      type = "gem";
    };
    version = "4.8.0";
  };
  org-ruby = {
    dependencies = ["rubypants"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0x69s7aysfiwlcpd9hkvksfyld34d8kxr62adb59vjvh8hxfrjwk";
      type = "gem";
    };
    version = "0.9.12";
  };
  parslet = {
    dependencies = ["blankslate"];
    source = {
      sha256 = "0qp1m8n3m6k6g22nn1ivcfkvccq5jmbkw53vvcjw5xssq179l9z3";
      type = "gem";
    };
    version = "1.5.0";
  };
  posix-spawn = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1pmxmpins57qrbr31bs3bm7gidhaacmrp4md6i962gvpq4gyfcjw";
      type = "gem";
    };
    version = "0.3.13";
  };
  public_suffix = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x5h1dh1i3gwc01jbg01rly2g6a1qwhynb1s8a30ic507z1nh09s";
      type = "gem";
    };
    version = "3.0.2";
  };
  "pygments.rb" = {
    dependencies = ["posix-spawn" "yajl-ruby"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "160i761q2z8kandcikf2r5318glgi3pf6b45wa407wacjvz2966i";
      type = "gem";
    };
    version = "0.6.3";
  };
  rb-fsevent = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1lm1k7wpz69jx7jrc92w3ggczkjyjbfziq5mg62vjnxmzs383xx8";
      type = "gem";
    };
    version = "0.10.3";
  };
  rb-inotify = {
    dependencies = ["ffi"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yfsgw5n7pkpyky6a9wkf1g9jafxb0ja7gz0qw0y14fd2jnzfh71";
      type = "gem";
    };
    version = "0.9.10";
  };
  redcarpet = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0h9qz2hik4s9knpmbwrzb3jcp3vc5vygp9ya8lcpl7f1l9khmcd7";
      type = "gem";
    };
    version = "3.4.0";
  };
  ruby_dep = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1c1bkl97i9mkcvkn1jks346ksnvnnp84cs22gwl0vd7radybrgy5";
      type = "gem";
    };
    version = "1.5.0";
  };
  rubypants = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02f0c84jg30w7z7996gsbidz69jski64p1l2xnaycrpm0y4by0mw";
      type = "gem";
    };
    version = "0.7.0";
  };
  s3_website = {
    dependencies = ["colored" "configure-s3-website" "dotenv" "thor"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1gr19hl6cl1dgbj6s9mw79dagiqzr4a1wfcrd4kv56ls7mg07a1n";
      type = "gem";
    };
    version = "3.4.0";
  };
  safe_yaml = {
    source = {
      sha256 = "1hly915584hyi9q9vgd968x2nsi5yag9jyf5kq60lwzi5scr7094";
      type = "gem";
    };
    version = "1.0.4";
  };
  sass = {
    dependencies = ["sass-listen"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "19wyzp9qsg8hdkkxlsv713w0qmy66qrdp0shj42587ssx4qhrlag";
      type = "gem";
    };
    version = "3.5.6";
  };
  sass-listen = {
    dependencies = ["rb-fsevent" "rb-inotify"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0xw3q46cmahkgyldid5hwyiwacp590zj2vmswlll68ryvmvcp7df";
      type = "gem";
    };
    version = "4.0.0";
  };
  sawyer = {
    dependencies = ["addressable" "faraday"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sv1463r7bqzvx4drqdmd36m7rrv6sf1v3c6vswpnq3k6vdw2dvd";
      type = "gem";
    };
    version = "0.8.1";
  };
  thor = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nmqpyj642sk4g16nkbq6pj856adpv91lp4krwhqkh2iw63aszdl";
      type = "gem";
    };
    version = "0.20.0";
  };
  toml = {
    dependencies = ["parslet"];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1wnvi1g8id1sg6776fvzf98lhfbscchgiy1fp5pvd58a8ds2fq9v";
      type = "gem";
    };
    version = "0.1.2";
  };
  yajl-ruby = {
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nhyqakszr85l0iw342hy55n7k014v2qq26y2xkfvdib256gfvk4";
      type = "gem";
    };
    version = "1.2.3";
  };
}