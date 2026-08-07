Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573935C1B0;
	Fri,  7 Aug 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134932; cv=none; b=Xnj79DOXPgenbgulu/bwgtxbEaNXZgyEx0MvgmknGJ97QS822bIBI+EzZaFqZCbOw8geyo/UxGz1Hk9BAl1O/62OoZxFX4CGzEDhE/odDF/6bphhwtKP4Qz0E4Itf0mbGTO5laSAt7mz8iUwjRr4Q7juugRo7Qa3ossUUKgELag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134932; c=relaxed/simple;
	bh=K56dGIEeeS1vA/I6x23zVPGlrnpVvs1XoZE1jm1pg4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5NhhAxxBIhn2RrDEh/jcFK/t/jqEjueYQ6R+JgfS4LNnVYYoNjuAQ4Lz81WIT/pu1uX768JC8sGwSpJtYS84sLtJU44aavy+DUATmbo0wXO/zxm0GFiQ+ICbWj3KqGxvoB/SdAxPIc3jfiocZBf0H7h5LGjn2vtMvO8MAliVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFfplFOa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFfplFOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786134930; x=1817670930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K56dGIEeeS1vA/I6x23zVPGlrnpVvs1XoZE1jm1pg4w=;
  b=DFfplFOapbZZWMPP7ZauIombtDy9jkUkEYMKgSsRwaFmv8NCVFfPFidt
   T7Hj2uSHiBDT73EU3gtuK4ZPQcR1E4p8T2Lcdz7dV6xee/HMY+JN3/PJx
   MU6qCDZ4kD3apufudbVvJWiWoz451cm5M7wDrOfnc1+8+aPUJa2P6HNcK
   o3Ctuj5FWxILH6fWN1mnfRpwLV8sNDiamokM53aE1XyWgCSmEx0/DFhpt
   a4iBtHs9WDqQV6Cnza/Ql0Pb4eKfac5yc6kAuud+8c2nDO3EPtAFT2Uvq
   /cUYTiaZfl4HfzNoSXoyKNO9n0oiHYWpKlEAgWHzAxLa+yArNybgFongr
   w==;
X-CSE-ConnectionGUID: iwbbxkt8R8WaE8djCuQLnw==
X-CSE-MsgGUID: 4vDQ6IBAR3KfwuqNUM8iZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="98262929"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="98262929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 13:35:30 -0700
X-CSE-ConnectionGUID: 7Fn4H/g/QsObOwtSynLAdg==
X-CSE-MsgGUID: LUR0ykomSCuwDY8JtmnScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="292381369"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Aug 2026 13:35:28 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsRHp-00000000JCH-2G82;
	Fri, 07 Aug 2026 20:35:25 +0000
Date: Sat, 8 Aug 2026 04:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: mfd: of_syscon_register: fix reset_control
 reference leak on success   path
Message-ID: <202608080440.vtPTMqD3-lkp@intel.com>
References: <20260626151125.50780-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626151125.50780-1-vulab@iscas.ac.cn>

Hi WenTao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on lee-mfd/for-mfd-fixes lee-leds/for-leds-next linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/fix-mfd-of_syscon_register-fix-reset_control-reference-leak-on-success-path/20260807-005058
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20260626151125.50780-1-vulab%40iscas.ac.cn
patch subject: [PATCH] fix: mfd: of_syscon_register: fix reset_control reference leak on success   path
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260808/202608080440.vtPTMqD3-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260808/202608080440.vtPTMqD3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608080440.vtPTMqD3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/syscon.c:125:6: warning: variable 'reset' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     125 |         if (check_res) {
         |             ^~~~~~~~~
   drivers/mfd/syscon.c:151:18: note: uninitialized use occurs here
     151 |         syscon->reset = reset;
         |                         ^~~~~
   drivers/mfd/syscon.c:125:2: note: remove the 'if' if its condition is always true
     125 |         if (check_res) {
         |         ^~~~~~~~~~~~~~
   drivers/mfd/syscon.c:49:29: note: initialize the variable 'reset' to silence this warning
      49 |         struct reset_control *reset;
         |                                    ^
         |                                     = NULL
   1 warning generated.


vim +125 drivers/mfd/syscon.c

87d687301f3807 Dong Aisheng        2012-09-05   39  
7d1e3bd94828ad Jeremy Kerr         2023-01-05   40  static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
87d687301f3807 Dong Aisheng        2012-09-05   41  {
a00406b71c5f08 Fabrice Gasnier     2018-12-12   42  	struct clk *clk;
bdb0066df96e74 Pankaj Dubey        2014-09-30   43  	struct regmap *regmap;
bdb0066df96e74 Pankaj Dubey        2014-09-30   44  	void __iomem *base;
db2fb60cd35d2d Damien Riegel       2015-11-30   45  	u32 reg_io_width;
bdb0066df96e74 Pankaj Dubey        2014-09-30   46  	int ret;
bdb0066df96e74 Pankaj Dubey        2014-09-30   47  	struct regmap_config syscon_config = syscon_regmap_config;
ca668f0edfae65 Philipp Zabel       2016-01-29   48  	struct resource res;
7d1e3bd94828ad Jeremy Kerr         2023-01-05   49  	struct reset_control *reset;
ba09916efb29f8 Eder Zulian         2025-02-12   50  	resource_size_t res_size;
bdb0066df96e74 Pankaj Dubey        2014-09-30   51  
805f7aaf7fee14 Rob Herring (Arm    2024-12-17   52) 	WARN_ON(!mutex_is_locked(&syscon_list_lock));
805f7aaf7fee14 Rob Herring (Arm    2024-12-17   53) 
bf4afc53b77aea Linus Torvalds      2026-02-21   54  	struct syscon *syscon __free(kfree) = kzalloc_obj(*syscon);
bdb0066df96e74 Pankaj Dubey        2014-09-30   55  	if (!syscon)
bdb0066df96e74 Pankaj Dubey        2014-09-30   56  		return ERR_PTR(-ENOMEM);
bdb0066df96e74 Pankaj Dubey        2014-09-30   57  
82f898f47112bc Krzysztof Kozlowski 2024-07-07   58  	if (of_address_to_resource(np, 0, &res))
82f898f47112bc Krzysztof Kozlowski 2024-07-07   59  		return ERR_PTR(-ENOMEM);
ca668f0edfae65 Philipp Zabel       2016-01-29   60  
452d07413954ef Hector Martin       2021-08-23   61  	base = of_iomap(np, 0);
82f898f47112bc Krzysztof Kozlowski 2024-07-07   62  	if (!base)
82f898f47112bc Krzysztof Kozlowski 2024-07-07   63  		return ERR_PTR(-ENOMEM);
bdb0066df96e74 Pankaj Dubey        2014-09-30   64  
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   65  	/* Parse the device's DT node for an endianness specification */
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   66  	if (of_property_read_bool(np, "big-endian"))
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   67  		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   68  	else if (of_property_read_bool(np, "little-endian"))
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   69  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   70  	else if (of_property_read_bool(np, "native-endian"))
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   71  		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
ca4582c286aa44 Jason A. Donenfeld  2022-10-08   72  
db2fb60cd35d2d Damien Riegel       2015-11-30   73  	/*
db2fb60cd35d2d Damien Riegel       2015-11-30   74  	 * search for reg-io-width property in DT. If it is not provided,
db2fb60cd35d2d Damien Riegel       2015-11-30   75  	 * default to 4 bytes. regmap_init_mmio will return an error if values
db2fb60cd35d2d Damien Riegel       2015-11-30   76  	 * are invalid so there is no need to check them here.
db2fb60cd35d2d Damien Riegel       2015-11-30   77  	 */
db2fb60cd35d2d Damien Riegel       2015-11-30   78  	ret = of_property_read_u32(np, "reg-io-width", &reg_io_width);
db2fb60cd35d2d Damien Riegel       2015-11-30   79  	if (ret)
db2fb60cd35d2d Damien Riegel       2015-11-30   80  		reg_io_width = 4;
db2fb60cd35d2d Damien Riegel       2015-11-30   81  
3bafc09e779710 Baolin Wang         2017-12-25   82  	ret = of_hwspin_lock_get_id(np, 0);
3bafc09e779710 Baolin Wang         2017-12-25   83  	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0)) {
3bafc09e779710 Baolin Wang         2017-12-25   84  		syscon_config.use_hwlock = true;
3bafc09e779710 Baolin Wang         2017-12-25   85  		syscon_config.hwlock_id = ret;
3bafc09e779710 Baolin Wang         2017-12-25   86  		syscon_config.hwlock_mode = HWLOCK_IRQSTATE;
3bafc09e779710 Baolin Wang         2017-12-25   87  	} else if (ret < 0) {
3bafc09e779710 Baolin Wang         2017-12-25   88  		switch (ret) {
3bafc09e779710 Baolin Wang         2017-12-25   89  		case -ENOENT:
3bafc09e779710 Baolin Wang         2017-12-25   90  			/* Ignore missing hwlock, it's optional. */
3bafc09e779710 Baolin Wang         2017-12-25   91  			break;
3bafc09e779710 Baolin Wang         2017-12-25   92  		default:
3bafc09e779710 Baolin Wang         2017-12-25   93  			pr_err("Failed to retrieve valid hwlock: %d\n", ret);
df561f6688fef7 Gustavo A. R. Silva 2020-08-23   94  			fallthrough;
3bafc09e779710 Baolin Wang         2017-12-25   95  		case -EPROBE_DEFER:
3bafc09e779710 Baolin Wang         2017-12-25   96  			goto err_regmap;
3bafc09e779710 Baolin Wang         2017-12-25   97  		}
3bafc09e779710 Baolin Wang         2017-12-25   98  	}
3bafc09e779710 Baolin Wang         2017-12-25   99  
ba09916efb29f8 Eder Zulian         2025-02-12  100  	res_size = resource_size(&res);
ba09916efb29f8 Eder Zulian         2025-02-12  101  	if (res_size < reg_io_width) {
ba09916efb29f8 Eder Zulian         2025-02-12  102  		ret = -EFAULT;
ba09916efb29f8 Eder Zulian         2025-02-12  103  		goto err_regmap;
ba09916efb29f8 Eder Zulian         2025-02-12  104  	}
ba09916efb29f8 Eder Zulian         2025-02-12  105  
7ff7d5ffb7259f Andy Shevchenko     2022-05-31  106  	syscon_config.name = kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
41673c66b3d0c0 Kunwu Chan          2023-12-04  107  	if (!syscon_config.name) {
41673c66b3d0c0 Kunwu Chan          2023-12-04  108  		ret = -ENOMEM;
41673c66b3d0c0 Kunwu Chan          2023-12-04  109  		goto err_regmap;
41673c66b3d0c0 Kunwu Chan          2023-12-04  110  	}
db2fb60cd35d2d Damien Riegel       2015-11-30  111  	syscon_config.reg_stride = reg_io_width;
db2fb60cd35d2d Damien Riegel       2015-11-30  112  	syscon_config.val_bits = reg_io_width * 8;
ba09916efb29f8 Eder Zulian         2025-02-12  113  	syscon_config.max_register = res_size - reg_io_width;
2e63d6fa113d36 Nishanth Menon      2024-09-03  114  	if (!syscon_config.max_register)
2e63d6fa113d36 Nishanth Menon      2024-09-03  115  		syscon_config.max_register_is_0 = true;
db2fb60cd35d2d Damien Riegel       2015-11-30  116  
bdb0066df96e74 Pankaj Dubey        2014-09-30  117  	regmap = regmap_init_mmio(NULL, base, &syscon_config);
56a1188159cb2b Limeng              2021-04-07  118  	kfree(syscon_config.name);
bdb0066df96e74 Pankaj Dubey        2014-09-30  119  	if (IS_ERR(regmap)) {
bdb0066df96e74 Pankaj Dubey        2014-09-30  120  		pr_err("regmap init failed\n");
bdb0066df96e74 Pankaj Dubey        2014-09-30  121  		ret = PTR_ERR(regmap);
bdb0066df96e74 Pankaj Dubey        2014-09-30  122  		goto err_regmap;
bdb0066df96e74 Pankaj Dubey        2014-09-30  123  	}
bdb0066df96e74 Pankaj Dubey        2014-09-30  124  
7d1e3bd94828ad Jeremy Kerr         2023-01-05 @125  	if (check_res) {
a00406b71c5f08 Fabrice Gasnier     2018-12-12  126  		clk = of_clk_get(np, 0);
a00406b71c5f08 Fabrice Gasnier     2018-12-12  127  		if (IS_ERR(clk)) {
a00406b71c5f08 Fabrice Gasnier     2018-12-12  128  			ret = PTR_ERR(clk);
a00406b71c5f08 Fabrice Gasnier     2018-12-12  129  			/* clock is optional */
a00406b71c5f08 Fabrice Gasnier     2018-12-12  130  			if (ret != -ENOENT)
a00406b71c5f08 Fabrice Gasnier     2018-12-12  131  				goto err_clk;
a00406b71c5f08 Fabrice Gasnier     2018-12-12  132  		} else {
a00406b71c5f08 Fabrice Gasnier     2018-12-12  133  			ret = regmap_mmio_attach_clk(regmap, clk);
a00406b71c5f08 Fabrice Gasnier     2018-12-12  134  			if (ret)
7d1e3bd94828ad Jeremy Kerr         2023-01-05  135  				goto err_attach_clk;
a00406b71c5f08 Fabrice Gasnier     2018-12-12  136  		}
7d1e3bd94828ad Jeremy Kerr         2023-01-05  137  
7d1e3bd94828ad Jeremy Kerr         2023-01-05  138  		reset = of_reset_control_get_optional_exclusive(np, NULL);
7d1e3bd94828ad Jeremy Kerr         2023-01-05  139  		if (IS_ERR(reset)) {
7d1e3bd94828ad Jeremy Kerr         2023-01-05  140  			ret = PTR_ERR(reset);
7d1e3bd94828ad Jeremy Kerr         2023-01-05  141  			goto err_attach_clk;
7d1e3bd94828ad Jeremy Kerr         2023-01-05  142  		}
7d1e3bd94828ad Jeremy Kerr         2023-01-05  143  
7d1e3bd94828ad Jeremy Kerr         2023-01-05  144  		ret = reset_control_deassert(reset);
7d1e3bd94828ad Jeremy Kerr         2023-01-05  145  		if (ret)
7d1e3bd94828ad Jeremy Kerr         2023-01-05  146  			goto err_reset;
39233b7c611248 Paul Cercueil       2019-07-24  147  	}
a00406b71c5f08 Fabrice Gasnier     2018-12-12  148  
bdb0066df96e74 Pankaj Dubey        2014-09-30  149  	syscon->regmap = regmap;
bdb0066df96e74 Pankaj Dubey        2014-09-30  150  	syscon->np = np;
daad85a71f976e WenTao Liang        2026-06-26  151  	syscon->reset = reset;
bdb0066df96e74 Pankaj Dubey        2014-09-30  152  
bdb0066df96e74 Pankaj Dubey        2014-09-30  153  	list_add_tail(&syscon->list, &syscon_list);
87d687301f3807 Dong Aisheng        2012-09-05  154  
82f898f47112bc Krzysztof Kozlowski 2024-07-07  155  	return_ptr(syscon);
bdb0066df96e74 Pankaj Dubey        2014-09-30  156  
7d1e3bd94828ad Jeremy Kerr         2023-01-05  157  err_reset:
7d1e3bd94828ad Jeremy Kerr         2023-01-05  158  	reset_control_put(reset);
7d1e3bd94828ad Jeremy Kerr         2023-01-05  159  err_attach_clk:
a00406b71c5f08 Fabrice Gasnier     2018-12-12  160  	if (!IS_ERR(clk))
a00406b71c5f08 Fabrice Gasnier     2018-12-12  161  		clk_put(clk);
a00406b71c5f08 Fabrice Gasnier     2018-12-12  162  err_clk:
a00406b71c5f08 Fabrice Gasnier     2018-12-12  163  	regmap_exit(regmap);
bdb0066df96e74 Pankaj Dubey        2014-09-30  164  err_regmap:
bdb0066df96e74 Pankaj Dubey        2014-09-30  165  	iounmap(base);
bdb0066df96e74 Pankaj Dubey        2014-09-30  166  	return ERR_PTR(ret);
87d687301f3807 Dong Aisheng        2012-09-05  167  }
87d687301f3807 Dong Aisheng        2012-09-05  168  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
