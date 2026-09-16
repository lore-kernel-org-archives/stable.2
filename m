Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614F4B0E28;
	Wed, 16 Sep 2026 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579866; cv=none; b=i+kxRCyiRR1H17/2D+j1dqJm9cQnS2cEV4Cpevow81NHdTylf6X4aqkyWdP5QtcDupJcf6pCi15ZSHqS0gsrW/A/l1tyKUZMVp/t3iV2C1zWzlr0D+0vHBxlvn5HQ4UBjjNHmFjVixBPxsstbBG8RHAXgkxnhUlxRlmSb9bhEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579866; c=relaxed/simple;
	bh=EjOUyqsPDp9k1q72lmmp1lAdtJLfgNHbNqFIjT2AuAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX9/zMxlj7vcfIrudgm9p+MnL8xOt2G+1ssYlsH2VD5h2tPmb633iRCJDpnriQfRFq6nRCj4qeSrWt3h7CWkR4xkdS25xby5BI+gOfBuOLrJJow9K3tsIsH+3497EKkGxtLImKlyFtLLcYHs/LQaVm7t0ZOtA2b0qxPLfMQ0gHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZD0Ps30; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZD0Ps30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789579862; x=1821115862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EjOUyqsPDp9k1q72lmmp1lAdtJLfgNHbNqFIjT2AuAA=;
  b=fZD0Ps30WOQSKSg0nm5U6U0Ht5Y27IngrE8NtuyR61WeoGaujc1BdydX
   OmGbcc2NdeA45+MXYDSP3LEYlpMNMJJXSEjs9OwT7+3b41B3Y8H1SVkAM
   UtElpe/Vutx/u7jvP23ajgB2PqgyX7pU4N7LTZwzUimZ/bPLfc3rHp1Q/
   4cFlZfBuOn5QM01c6rU+QngIcRgxd483n3AcRA7qQAZqO4PrQCSC6dS7z
   tMA0mnC4SsSRCqBrpjkyJMaS+hqcDFy4NCpQzj91+VsJZiEGoiYigkQqK
   Wu1nfv30H49Pgmqa5SEypuQVMA2rF4XhN5bXIpgdAZH0lNreQ13TT2Ljl
   w==;
X-CSE-ConnectionGUID: RQEGywHIQrWqHlFiK8U52Q==
X-CSE-MsgGUID: GwDfnmKsT3uNbKcBkVRcWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100627602"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100627602"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 10:30:57 -0700
X-CSE-ConnectionGUID: vY53uml+S7ioL/Maxt+dAA==
X-CSE-MsgGUID: C2AAq2zwQ2eET4pk8YtL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277142363"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Sep 2026 10:30:54 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6tT9-000000006TN-4BlF;
	Wed, 16 Sep 2026 17:30:52 +0000
Date: Thu, 17 Sep 2026 01:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Grosjean <s.grosjean@peak-system.fr>,
	Kees Cook <kees@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] can: peak_pci: fix PCIeC cleanup on probe failure
Message-ID: <202609170102.yZBQuFMY-lkp@intel.com>
References: <20260915173157.2510375-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915173157.2510375-1-lgs201920130244@gmail.com>

Hi Guangshuo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on linus/master v7.3-rc3 next-20260914]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/can-peak_pci-fix-PCIeC-cleanup-on-probe-failure/20260916-013157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20260915173157.2510375-1-lgs201920130244%40gmail.com
patch subject: [PATCH] can: peak_pci: fix PCIeC cleanup on probe failure
config: sparc64-randconfig-1000-20260916 (https://download.01.org/0day-ci/archive/20260917/202609170102.yZBQuFMY-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609170102.yZBQuFMY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609170102.yZBQuFMY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/sja1000/peak_pci.c: In function 'peak_pci_probe':
>> drivers/net/can/sja1000/peak_pci.c:700:1: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    if (!chan->prev_dev && chan->pciec_card)
    ^~
   drivers/net/can/sja1000/peak_pci.c:702:2: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     pci_set_drvdata(pdev, chan->prev_dev);
     ^~~~~~~~~~~~~~~


vim +/if +700 drivers/net/can/sja1000/peak_pci.c

   550	
   551	static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
   552	{
   553		struct sja1000_priv *priv;
   554		struct peak_pci_chan *chan;
   555		struct net_device *dev, *prev_dev;
   556		void __iomem *cfg_base, *reg_base;
   557		u16 sub_sys_id, icr;
   558		int i, err, channels;
   559		char fw_str[14] = "";
   560	
   561		err = pci_enable_device(pdev);
   562		if (err)
   563			return err;
   564	
   565		err = pci_request_regions(pdev, DRV_NAME);
   566		if (err)
   567			goto failure_disable_pci;
   568	
   569		err = pci_read_config_word(pdev, 0x2e, &sub_sys_id);
   570		if (err)
   571			goto failure_release_regions;
   572	
   573		dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
   574			pdev->vendor, pdev->device, sub_sys_id);
   575	
   576		err = pci_write_config_word(pdev, 0x44, 0);
   577		if (err)
   578			goto failure_release_regions;
   579	
   580		if (sub_sys_id >= 12)
   581			channels = 4;
   582		else if (sub_sys_id >= 10)
   583			channels = 3;
   584		else if (sub_sys_id >= 4)
   585			channels = 2;
   586		else
   587			channels = 1;
   588	
   589		cfg_base = pci_iomap(pdev, 0, PEAK_PCI_CFG_SIZE);
   590		if (!cfg_base) {
   591			dev_err(&pdev->dev, "failed to map PCI resource #0\n");
   592			err = -ENOMEM;
   593			goto failure_release_regions;
   594		}
   595	
   596		reg_base = pci_iomap(pdev, 1, PEAK_PCI_CHAN_SIZE * channels);
   597		if (!reg_base) {
   598			dev_err(&pdev->dev, "failed to map PCI resource #1\n");
   599			err = -ENOMEM;
   600			goto failure_unmap_cfg_base;
   601		}
   602	
   603		/* Set GPIO control register */
   604		writew(0x0005, cfg_base + PITA_GPIOICR + 2);
   605		/* Enable all channels of this card */
   606		writeb(0x00, cfg_base + PITA_GPIOICR);
   607		/* Toggle reset */
   608		writeb(0x05, cfg_base + PITA_MISC + 3);
   609		usleep_range(5000, 6000);
   610		/* Leave parport mux mode */
   611		writeb(0x04, cfg_base + PITA_MISC + 3);
   612	
   613		/* FPGA equipped card if not 0 */
   614		if (readl(cfg_base + PEAK_VER_REG1)) {
   615			/* FPGA card: display version of the running firmware */
   616			u32 fw_ver = readl(cfg_base + PEAK_VER_REG2);
   617	
   618			snprintf(fw_str, sizeof(fw_str), " FW v%u.%u.%u",
   619				 (fw_ver >> 12) & 0xf,
   620				 (fw_ver >> 8) & 0xf,
   621				 (fw_ver >> 4) & 0xf);
   622		}
   623	
   624		/* Display commercial name (and, eventually, FW version) of the card */
   625		dev_info(&pdev->dev, "%ux CAN %s%s\n",
   626			 channels, (const char *)ent->driver_data, fw_str);
   627	
   628		icr = readw(cfg_base + PITA_ICR + 2);
   629	
   630		for (i = 0; i < channels; i++) {
   631			dev = alloc_sja1000dev(sizeof(struct peak_pci_chan));
   632			if (!dev) {
   633				err = -ENOMEM;
   634				goto failure_remove_channels;
   635			}
   636	
   637			priv = netdev_priv(dev);
   638			chan = priv->priv;
   639	
   640			chan->cfg_base = cfg_base;
   641			priv->reg_base = reg_base + i * PEAK_PCI_CHAN_SIZE;
   642	
   643			priv->read_reg = peak_pci_read_reg;
   644			priv->write_reg = peak_pci_write_reg;
   645			priv->post_irq = peak_pci_post_irq;
   646	
   647			priv->can.clock.freq = PEAK_PCI_CAN_CLOCK;
   648			priv->ocr = PEAK_PCI_OCR;
   649			priv->cdr = PEAK_PCI_CDR;
   650			/* Neither a slave nor a single device distributes the clock */
   651			if (channels == 1 || i > 0)
   652				priv->cdr |= CDR_CLK_OFF;
   653	
   654			/* Setup interrupt handling */
   655			priv->irq_flags = IRQF_SHARED;
   656			dev->irq = pdev->irq;
   657	
   658			chan->icr_mask = peak_pci_icr_masks[i];
   659			icr |= chan->icr_mask;
   660	
   661			SET_NETDEV_DEV(dev, &pdev->dev);
   662			dev->dev_id = i;
   663	
   664			/* Create chain of SJA1000 devices */
   665			chan->prev_dev = pci_get_drvdata(pdev);
   666			pci_set_drvdata(pdev, dev);
   667	
   668			/* PCAN-ExpressCard needs some additional i2c init.
   669			 * This must be done *before* register_sja1000dev() but
   670			 * *after* devices linkage
   671			 */
   672			if (pdev->device == PEAK_PCIEC_DEVICE_ID ||
   673			    pdev->device == PEAK_PCIEC34_DEVICE_ID) {
   674				err = peak_pciec_probe(pdev, dev);
   675				if (err) {
   676					dev_err(&pdev->dev,
   677						"failed to probe device (err %d)\n",
   678						err);
   679					goto failure_free_dev;
   680				}
   681			}
   682	
   683			err = register_sja1000dev(dev);
   684			if (err) {
   685				dev_err(&pdev->dev, "failed to register device\n");
   686				goto failure_free_dev;
   687			}
   688	
   689			dev_info(&pdev->dev,
   690				 "%s at reg_base=0x%p cfg_base=0x%p irq=%d\n",
   691				 dev->name, priv->reg_base, chan->cfg_base, dev->irq);
   692		}
   693	
   694		/* Enable interrupts */
   695		writew(icr, cfg_base + PITA_ICR + 2);
   696	
   697		return 0;
   698	
   699	failure_free_dev:
 > 700	if (!chan->prev_dev && chan->pciec_card)
   701		peak_pciec_remove(chan->pciec_card);
   702		pci_set_drvdata(pdev, chan->prev_dev);
   703		free_sja1000dev(dev);
   704	
   705	failure_remove_channels:
   706		/* Disable interrupts */
   707		writew(0x0, cfg_base + PITA_ICR + 2);
   708	
   709		for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
   710			priv = netdev_priv(dev);
   711			chan = priv->priv;
   712			prev_dev = chan->prev_dev;
   713	
   714			/* do that only for first channel */
   715			if (!prev_dev && chan->pciec_card)
   716				peak_pciec_remove(chan->pciec_card);
   717			unregister_sja1000dev(dev);
   718			free_sja1000dev(dev);
   719		}
   720	
   721		pci_iounmap(pdev, reg_base);
   722	
   723	failure_unmap_cfg_base:
   724		pci_iounmap(pdev, cfg_base);
   725	
   726	failure_release_regions:
   727		pci_release_regions(pdev);
   728	
   729	failure_disable_pci:
   730		pci_disable_device(pdev);
   731	
   732		/* pci_xxx_config_word() return positive PCIBIOS_xxx error codes while
   733		 * the probe() function must return a negative errno in case of failure
   734		 * (err is unchanged if negative)
   735		 */
   736		return pcibios_err_to_errno(err);
   737	}
   738	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
