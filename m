Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D411C5D59;
	Sat,  8 Aug 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786223216; cv=none; b=rJ6VSKHb1nq8J9YLqHGNB/mMFXDkLcE5WFuiciu/ApRompLu8tQmBp4w6NiLXbAlgWVhZsk+eb8XjRI79g4A9xdtpuAU++wTdI67izNxUBPIyShcK8Y6kRjs+Vn1y80YbOz+RWlxxIjALcUSrLEq3xd37C7CWmQmLrUMR/a+w1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786223216; c=relaxed/simple;
	bh=OMM+S3OHPCR7Z+UOUf7fjBeKF7slD0BC7jQ4egU5bPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0qShVMUPzxO5ywjjCPIGGZu/j5vEqzY9CnSl4PxXErZGtDmsDQE2HqJlfh+8qdCLs/g1rsZ06aB3nJuARqbJUe5DC+U9aD/tZ3VPHK5rOA1DvyhkoVliUMbP4wgtbSbRnWTJN+zbc1UGEd3a/3PU6iGPcqqjWdcjJl9i4vTiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fex3161F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fex3161F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786223213; x=1817759213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OMM+S3OHPCR7Z+UOUf7fjBeKF7slD0BC7jQ4egU5bPw=;
  b=Fex3161FH52Y5ao7MrrcUy41vesDSr2CelXwiUeRYWlitJk4u738ETYt
   zvZrf8JvxDJP2NVZEbYK1nJ6LiTow3ZELyfLyjOKXaxq7kZAhJfUThZVK
   FHFo8uOs9aXqEcm18T+m8z5AAYmx6YCf4dUE2sSOc1ZxgOwqHkZmboz2u
   PN/18QSlOXZi7IMzgKxXigDK8NlZWJyAjbDFoW/WoiIb16QbTnn1Feg6e
   Re8aPTl5h4wTWtYHkOQPtjiq0yTyPcVhDnvwt1VIAbtATiHH4W9GxVp59
   gPXDEDGOaLyTsdsFQ+/xK41d/hQ0O30ST7kWAkgJMIflb6E0ZlXg5rpuF
   A==;
X-CSE-ConnectionGUID: jibHBhe1SMuUYQvtjQJxsg==
X-CSE-MsgGUID: 531YzQwaTMmk0o6oJNCchg==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97445341"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="97445341"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 14:06:53 -0700
X-CSE-ConnectionGUID: 3aMzCevsSYyqDQEVfZN9Nw==
X-CSE-MsgGUID: al7TM1AMRaGcA7pHMQsLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="263308042"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2026 14:06:50 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsoFk-00000000Km1-0bcy;
	Sat, 08 Aug 2026 21:06:48 +0000
Date: Sun, 9 Aug 2026 05:05:53 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] btmrvl: Fix hdev dangling pointer and error code in
 register_hdev
Message-ID: <202608090403.IZoIz1yQ-lkp@intel.com>
References: <20260625160607.81615-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625160607.81615-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master linus/master v7.2-rc6 next-20260807]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/btmrvl-Fix-hdev-dangling-pointer-and-error-code-in-register_hdev/20260808-022129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20260625160607.81615-1-vulab%40iscas.ac.cn
patch subject: [PATCH] btmrvl: Fix hdev dangling pointer and error code in register_hdev
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260809/202608090403.IZoIz1yQ-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 12df34b8469b8095359de8c249cb1b2753fadeea)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260809/202608090403.IZoIz1yQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608090403.IZoIz1yQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btmrvl_main.c:685:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     685 |         if (!hdev) {
         |             ^~~~~
   drivers/bluetooth/btmrvl_main.c:726:9: note: uninitialized use occurs here
     726 |         return ret;
         |                ^~~
   drivers/bluetooth/btmrvl_main.c:685:2: note: remove the 'if' if its condition is always false
     685 |         if (!hdev) {
         |         ^~~~~~~~~~~~
     686 |                 BT_ERR("Can not allocate HCI device");
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     687 |                 goto err_hdev;
         |                 ~~~~~~~~~~~~~~
     688 |         }
         |         ~
   drivers/bluetooth/btmrvl_main.c:682:9: note: initialize the variable 'ret' to silence this warning
     682 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +685 drivers/bluetooth/btmrvl_main.c

132ff4e5fa8dfb Bing Zhao              2009-06-02  677  
64061607eab7cb Bing Zhao              2010-03-03  678  int btmrvl_register_hdev(struct btmrvl_private *priv)
132ff4e5fa8dfb Bing Zhao              2009-06-02  679  {
132ff4e5fa8dfb Bing Zhao              2009-06-02  680  	struct hci_dev *hdev = NULL;
70a7808b50b119 Abhishek Pandit-Subedi 2020-06-10  681  	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
132ff4e5fa8dfb Bing Zhao              2009-06-02  682  	int ret;
132ff4e5fa8dfb Bing Zhao              2009-06-02  683  
132ff4e5fa8dfb Bing Zhao              2009-06-02  684  	hdev = hci_alloc_dev();
132ff4e5fa8dfb Bing Zhao              2009-06-02 @685  	if (!hdev) {
132ff4e5fa8dfb Bing Zhao              2009-06-02  686  		BT_ERR("Can not allocate HCI device");
132ff4e5fa8dfb Bing Zhao              2009-06-02  687  		goto err_hdev;
132ff4e5fa8dfb Bing Zhao              2009-06-02  688  	}
132ff4e5fa8dfb Bing Zhao              2009-06-02  689  
132ff4e5fa8dfb Bing Zhao              2009-06-02  690  	priv->btmrvl_dev.hcidev = hdev;
155961e8001719 David Rheinsberg       2012-02-09  691  	hci_set_drvdata(hdev, priv);
132ff4e5fa8dfb Bing Zhao              2009-06-02  692  
c13854cef47510 Marcel Holtmann        2010-02-08  693  	hdev->bus   = HCI_SDIO;
132ff4e5fa8dfb Bing Zhao              2009-06-02  694  	hdev->open  = btmrvl_open;
132ff4e5fa8dfb Bing Zhao              2009-06-02  695  	hdev->close = btmrvl_close;
132ff4e5fa8dfb Bing Zhao              2009-06-02  696  	hdev->flush = btmrvl_flush;
132ff4e5fa8dfb Bing Zhao              2009-06-02  697  	hdev->send  = btmrvl_send_frame;
4b245722cabc6e Amitkumar Karwar       2013-10-01  698  	hdev->setup = btmrvl_setup;
27b869f59d5d98 Amitkumar Karwar       2014-07-18  699  	hdev->set_bdaddr = btmrvl_set_bdaddr;
4539ca67fe8ede Luiz Augusto von Dentz 2021-10-01  700  	hdev->wakeup = btmrvl_wakeup;
70a7808b50b119 Abhishek Pandit-Subedi 2020-06-10  701  	SET_HCIDEV_DEV(hdev, &card->func->dev);
64061607eab7cb Bing Zhao              2010-03-03  702  
132ff4e5fa8dfb Bing Zhao              2009-06-02  703  	ret = hci_register_dev(hdev);
132ff4e5fa8dfb Bing Zhao              2009-06-02  704  	if (ret < 0) {
132ff4e5fa8dfb Bing Zhao              2009-06-02  705  		BT_ERR("Can not register HCI device");
b10393b3962ee8 Wentao Liang           2026-06-26  706  		goto err_hci_register_dev_free;
132ff4e5fa8dfb Bing Zhao              2009-06-02  707  	}
132ff4e5fa8dfb Bing Zhao              2009-06-02  708  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
