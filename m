Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD44BF947;
	Wed, 16 Sep 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585709; cv=none; b=iirsv26eEmu8vydMaWaS0GlVleI5fflT81UaL5HRui2kgm5VNmDPmdvLJYDT7CkeWSMt9rY/PC9KxQC9JBiLDAN6Ps7VtEw6gI8pqA+OHFDErX2PLk91OqSMH6b3r7oXj4sQ6evFMsmPB7cPLRBIrk3dmAZElf6dRcqPAjMo7IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585709; c=relaxed/simple;
	bh=ggdrD2+64rbkN0/PbRVpNh223xHooPMBOSfhrhR20ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZaIFtdFE32auHgt4wl4qH3uaTFcC3i8ljKS5MwWmJqrLE04az4Ly6ySuKqbx1Q7KtPkG9rtGjWVwuhynSR2DhV49GUIJX8SQqTCZSL0HBwYwCvpQ1FipXwf8XIS4OExW+pkjYMsG4eoWATLb0Bif7x4XJOUgVLUz8+ri2L0cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHN5adG3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHN5adG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789585690; x=1821121690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ggdrD2+64rbkN0/PbRVpNh223xHooPMBOSfhrhR20ac=;
  b=YHN5adG3QzBYYnd2Zz6Kc7CzMtkaF54qQJrR+RosomLVLP3uPk4ClvTC
   uoHwkTQg1VnJGe2qsjorA0Qx1BX+a4Ih7S2sQWTLWIDTl57NgcRdrMEM2
   8fWGe3Cd7wxJe2O+Tzlo/2Vyu3Y0WRrgvyMA20IXx4OjdSNsUX/B+JUrX
   8wCLOz84KcW/J9Iv2LZ0GPT36a2afQV5VG0REVSwwOhB/UtcAfmllZ60L
   J00uzW6qiHnto8+IuBLQYqj5b4jP87LqkBXbOpZcRN8dmJsfXHr0JHFH2
   deS5psJ0SJAKqNX1UWMnSyRRA4EpR08B+bakROMvwHRE1ogj9x6D1W2O3
   A==;
X-CSE-ConnectionGUID: 9SRAm8b9RDO4WHo9pj/zjg==
X-CSE-MsgGUID: CJ1FVVB2SvyMkrL4IHZfDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100636762"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100636762"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 12:08:05 -0700
X-CSE-ConnectionGUID: 92h/GqYsS+6HunwQ8Ki3Ng==
X-CSE-MsgGUID: OyHAcUuyT7Cl3f5c/lrp7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270795430"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2026 12:08:03 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x6uzA-000000006c9-0m3c;
	Wed, 16 Sep 2026 19:08:00 +0000
Date: Thu, 17 Sep 2026 03:07:47 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Grosjean <s.grosjean@peak-system.fr>,
	Kees Cook <kees@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] can: peak_pci: fix PCIeC cleanup on probe failure
Message-ID: <202609170334.HGvXQS1L-lkp@intel.com>
References: <20260915173157.2510375-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260917/202609170334.HGvXQS1L-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260917/202609170334.HGvXQS1L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609170334.HGvXQS1L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/sja1000/peak_pci.c:702:2: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     702 |         pci_set_drvdata(pdev, chan->prev_dev);
         |         ^
   drivers/net/can/sja1000/peak_pci.c:700:1: note: previous statement is here
     700 | if (!chan->prev_dev && chan->pciec_card)
         | ^
   1 warning generated.


vim +/if +702 drivers/net/can/sja1000/peak_pci.c

38034518c086fc Wolfgang Grandegger  2011-09-12  550  
1dd06ae8db716e Greg Kroah-Hartman   2012-12-06  551  static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
38034518c086fc Wolfgang Grandegger  2011-09-12  552  {
38034518c086fc Wolfgang Grandegger  2011-09-12  553  	struct sja1000_priv *priv;
38034518c086fc Wolfgang Grandegger  2011-09-12  554  	struct peak_pci_chan *chan;
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  555  	struct net_device *dev, *prev_dev;
38034518c086fc Wolfgang Grandegger  2011-09-12  556  	void __iomem *cfg_base, *reg_base;
38034518c086fc Wolfgang Grandegger  2011-09-12  557  	u16 sub_sys_id, icr;
38034518c086fc Wolfgang Grandegger  2011-09-12  558  	int i, err, channels;
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  559  	char fw_str[14] = "";
38034518c086fc Wolfgang Grandegger  2011-09-12  560  
38034518c086fc Wolfgang Grandegger  2011-09-12  561  	err = pci_enable_device(pdev);
38034518c086fc Wolfgang Grandegger  2011-09-12  562  	if (err)
38034518c086fc Wolfgang Grandegger  2011-09-12  563  		return err;
38034518c086fc Wolfgang Grandegger  2011-09-12  564  
38034518c086fc Wolfgang Grandegger  2011-09-12  565  	err = pci_request_regions(pdev, DRV_NAME);
38034518c086fc Wolfgang Grandegger  2011-09-12  566  	if (err)
38034518c086fc Wolfgang Grandegger  2011-09-12  567  		goto failure_disable_pci;
38034518c086fc Wolfgang Grandegger  2011-09-12  568  
38034518c086fc Wolfgang Grandegger  2011-09-12  569  	err = pci_read_config_word(pdev, 0x2e, &sub_sys_id);
38034518c086fc Wolfgang Grandegger  2011-09-12  570  	if (err)
38034518c086fc Wolfgang Grandegger  2011-09-12  571  		goto failure_release_regions;
38034518c086fc Wolfgang Grandegger  2011-09-12  572  
38034518c086fc Wolfgang Grandegger  2011-09-12  573  	dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
38034518c086fc Wolfgang Grandegger  2011-09-12  574  		pdev->vendor, pdev->device, sub_sys_id);
38034518c086fc Wolfgang Grandegger  2011-09-12  575  
38034518c086fc Wolfgang Grandegger  2011-09-12  576  	err = pci_write_config_word(pdev, 0x44, 0);
38034518c086fc Wolfgang Grandegger  2011-09-12  577  	if (err)
38034518c086fc Wolfgang Grandegger  2011-09-12  578  		goto failure_release_regions;
38034518c086fc Wolfgang Grandegger  2011-09-12  579  
38034518c086fc Wolfgang Grandegger  2011-09-12  580  	if (sub_sys_id >= 12)
38034518c086fc Wolfgang Grandegger  2011-09-12  581  		channels = 4;
38034518c086fc Wolfgang Grandegger  2011-09-12  582  	else if (sub_sys_id >= 10)
38034518c086fc Wolfgang Grandegger  2011-09-12  583  		channels = 3;
38034518c086fc Wolfgang Grandegger  2011-09-12  584  	else if (sub_sys_id >= 4)
38034518c086fc Wolfgang Grandegger  2011-09-12  585  		channels = 2;
38034518c086fc Wolfgang Grandegger  2011-09-12  586  	else
38034518c086fc Wolfgang Grandegger  2011-09-12  587  		channels = 1;
38034518c086fc Wolfgang Grandegger  2011-09-12  588  
38034518c086fc Wolfgang Grandegger  2011-09-12  589  	cfg_base = pci_iomap(pdev, 0, PEAK_PCI_CFG_SIZE);
38034518c086fc Wolfgang Grandegger  2011-09-12  590  	if (!cfg_base) {
38034518c086fc Wolfgang Grandegger  2011-09-12  591  		dev_err(&pdev->dev, "failed to map PCI resource #0\n");
4a4bfdcd295728 Peter Senna Tschudin 2012-10-03  592  		err = -ENOMEM;
38034518c086fc Wolfgang Grandegger  2011-09-12  593  		goto failure_release_regions;
38034518c086fc Wolfgang Grandegger  2011-09-12  594  	}
38034518c086fc Wolfgang Grandegger  2011-09-12  595  
38034518c086fc Wolfgang Grandegger  2011-09-12  596  	reg_base = pci_iomap(pdev, 1, PEAK_PCI_CHAN_SIZE * channels);
38034518c086fc Wolfgang Grandegger  2011-09-12  597  	if (!reg_base) {
38034518c086fc Wolfgang Grandegger  2011-09-12  598  		dev_err(&pdev->dev, "failed to map PCI resource #1\n");
4a4bfdcd295728 Peter Senna Tschudin 2012-10-03  599  		err = -ENOMEM;
38034518c086fc Wolfgang Grandegger  2011-09-12  600  		goto failure_unmap_cfg_base;
38034518c086fc Wolfgang Grandegger  2011-09-12  601  	}
38034518c086fc Wolfgang Grandegger  2011-09-12  602  
38034518c086fc Wolfgang Grandegger  2011-09-12  603  	/* Set GPIO control register */
38034518c086fc Wolfgang Grandegger  2011-09-12  604  	writew(0x0005, cfg_base + PITA_GPIOICR + 2);
38034518c086fc Wolfgang Grandegger  2011-09-12  605  	/* Enable all channels of this card */
38034518c086fc Wolfgang Grandegger  2011-09-12  606  	writeb(0x00, cfg_base + PITA_GPIOICR);
38034518c086fc Wolfgang Grandegger  2011-09-12  607  	/* Toggle reset */
38034518c086fc Wolfgang Grandegger  2011-09-12  608  	writeb(0x05, cfg_base + PITA_MISC + 3);
276b7361bb1be3 Jia-Ju Bai           2018-04-11  609  	usleep_range(5000, 6000);
38034518c086fc Wolfgang Grandegger  2011-09-12  610  	/* Leave parport mux mode */
38034518c086fc Wolfgang Grandegger  2011-09-12  611  	writeb(0x04, cfg_base + PITA_MISC + 3);
38034518c086fc Wolfgang Grandegger  2011-09-12  612  
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  613  	/* FPGA equipped card if not 0 */
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  614  	if (readl(cfg_base + PEAK_VER_REG1)) {
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  615  		/* FPGA card: display version of the running firmware */
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  616  		u32 fw_ver = readl(cfg_base + PEAK_VER_REG2);
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  617  
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  618  		snprintf(fw_str, sizeof(fw_str), " FW v%u.%u.%u",
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  619  			 (fw_ver >> 12) & 0xf,
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  620  			 (fw_ver >> 8) & 0xf,
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  621  			 (fw_ver >> 4) & 0xf);
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  622  	}
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  623  
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  624  	/* Display commercial name (and, eventually, FW version) of the card */
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  625  	dev_info(&pdev->dev, "%ux CAN %s%s\n",
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  626  		 channels, (const char *)ent->driver_data, fw_str);
805ff68c8e7f4d Stéphane Grosjean    2021-06-07  627  
38034518c086fc Wolfgang Grandegger  2011-09-12  628  	icr = readw(cfg_base + PITA_ICR + 2);
38034518c086fc Wolfgang Grandegger  2011-09-12  629  
38034518c086fc Wolfgang Grandegger  2011-09-12  630  	for (i = 0; i < channels; i++) {
38034518c086fc Wolfgang Grandegger  2011-09-12  631  		dev = alloc_sja1000dev(sizeof(struct peak_pci_chan));
38034518c086fc Wolfgang Grandegger  2011-09-12  632  		if (!dev) {
38034518c086fc Wolfgang Grandegger  2011-09-12  633  			err = -ENOMEM;
38034518c086fc Wolfgang Grandegger  2011-09-12  634  			goto failure_remove_channels;
38034518c086fc Wolfgang Grandegger  2011-09-12  635  		}
38034518c086fc Wolfgang Grandegger  2011-09-12  636  
38034518c086fc Wolfgang Grandegger  2011-09-12  637  		priv = netdev_priv(dev);
38034518c086fc Wolfgang Grandegger  2011-09-12  638  		chan = priv->priv;
38034518c086fc Wolfgang Grandegger  2011-09-12  639  
38034518c086fc Wolfgang Grandegger  2011-09-12  640  		chan->cfg_base = cfg_base;
38034518c086fc Wolfgang Grandegger  2011-09-12  641  		priv->reg_base = reg_base + i * PEAK_PCI_CHAN_SIZE;
38034518c086fc Wolfgang Grandegger  2011-09-12  642  
38034518c086fc Wolfgang Grandegger  2011-09-12  643  		priv->read_reg = peak_pci_read_reg;
38034518c086fc Wolfgang Grandegger  2011-09-12  644  		priv->write_reg = peak_pci_write_reg;
38034518c086fc Wolfgang Grandegger  2011-09-12  645  		priv->post_irq = peak_pci_post_irq;
38034518c086fc Wolfgang Grandegger  2011-09-12  646  
38034518c086fc Wolfgang Grandegger  2011-09-12  647  		priv->can.clock.freq = PEAK_PCI_CAN_CLOCK;
38034518c086fc Wolfgang Grandegger  2011-09-12  648  		priv->ocr = PEAK_PCI_OCR;
38034518c086fc Wolfgang Grandegger  2011-09-12  649  		priv->cdr = PEAK_PCI_CDR;
38034518c086fc Wolfgang Grandegger  2011-09-12  650  		/* Neither a slave nor a single device distributes the clock */
38034518c086fc Wolfgang Grandegger  2011-09-12  651  		if (channels == 1 || i > 0)
38034518c086fc Wolfgang Grandegger  2011-09-12  652  			priv->cdr |= CDR_CLK_OFF;
38034518c086fc Wolfgang Grandegger  2011-09-12  653  
38034518c086fc Wolfgang Grandegger  2011-09-12  654  		/* Setup interrupt handling */
38034518c086fc Wolfgang Grandegger  2011-09-12  655  		priv->irq_flags = IRQF_SHARED;
38034518c086fc Wolfgang Grandegger  2011-09-12  656  		dev->irq = pdev->irq;
38034518c086fc Wolfgang Grandegger  2011-09-12  657  
38034518c086fc Wolfgang Grandegger  2011-09-12  658  		chan->icr_mask = peak_pci_icr_masks[i];
38034518c086fc Wolfgang Grandegger  2011-09-12  659  		icr |= chan->icr_mask;
38034518c086fc Wolfgang Grandegger  2011-09-12  660  
38034518c086fc Wolfgang Grandegger  2011-09-12  661  		SET_NETDEV_DEV(dev, &pdev->dev);
3e66d0138c05d9 Christopher R. Baker 2014-03-08  662  		dev->dev_id = i;
38034518c086fc Wolfgang Grandegger  2011-09-12  663  
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  664  		/* Create chain of SJA1000 devices */
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  665  		chan->prev_dev = pci_get_drvdata(pdev);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  666  		pci_set_drvdata(pdev, dev);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  667  
9b69aff9fd1a66 Marc Kleine-Budde    2021-06-11  668  		/* PCAN-ExpressCard needs some additional i2c init.
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  669  		 * This must be done *before* register_sja1000dev() but
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  670  		 * *after* devices linkage
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  671  		 */
4be0015c955a9a Oliver Hartkopp      2014-09-16  672  		if (pdev->device == PEAK_PCIEC_DEVICE_ID ||
4be0015c955a9a Oliver Hartkopp      2014-09-16  673  		    pdev->device == PEAK_PCIEC34_DEVICE_ID) {
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  674  			err = peak_pciec_probe(pdev, dev);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  675  			if (err) {
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  676  				dev_err(&pdev->dev,
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  677  					"failed to probe device (err %d)\n",
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  678  					err);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  679  				goto failure_free_dev;
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  680  			}
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  681  		}
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  682  
38034518c086fc Wolfgang Grandegger  2011-09-12  683  		err = register_sja1000dev(dev);
38034518c086fc Wolfgang Grandegger  2011-09-12  684  		if (err) {
38034518c086fc Wolfgang Grandegger  2011-09-12  685  			dev_err(&pdev->dev, "failed to register device\n");
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  686  			goto failure_free_dev;
38034518c086fc Wolfgang Grandegger  2011-09-12  687  		}
38034518c086fc Wolfgang Grandegger  2011-09-12  688  
38034518c086fc Wolfgang Grandegger  2011-09-12  689  		dev_info(&pdev->dev,
38034518c086fc Wolfgang Grandegger  2011-09-12  690  			 "%s at reg_base=0x%p cfg_base=0x%p irq=%d\n",
38034518c086fc Wolfgang Grandegger  2011-09-12  691  			 dev->name, priv->reg_base, chan->cfg_base, dev->irq);
38034518c086fc Wolfgang Grandegger  2011-09-12  692  	}
38034518c086fc Wolfgang Grandegger  2011-09-12  693  
38034518c086fc Wolfgang Grandegger  2011-09-12  694  	/* Enable interrupts */
38034518c086fc Wolfgang Grandegger  2011-09-12  695  	writew(icr, cfg_base + PITA_ICR + 2);
38034518c086fc Wolfgang Grandegger  2011-09-12  696  
38034518c086fc Wolfgang Grandegger  2011-09-12  697  	return 0;
38034518c086fc Wolfgang Grandegger  2011-09-12  698  
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  699  failure_free_dev:
d0c5c584fb3542 Guangshuo Li         2026-09-16  700  if (!chan->prev_dev && chan->pciec_card)
d0c5c584fb3542 Guangshuo Li         2026-09-16  701  	peak_pciec_remove(chan->pciec_card);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02 @702  	pci_set_drvdata(pdev, chan->prev_dev);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  703  	free_sja1000dev(dev);
e6d9c80b7ca150 Stéphane Grosjean    2012-03-02  704  
38034518c086fc Wolfgang Grandegger  2011-09-12  705  failure_remove_channels:
38034518c086fc Wolfgang Grandegger  2011-09-12  706  	/* Disable interrupts */
38034518c086fc Wolfgang Grandegger  2011-09-12  707  	writew(0x0, cfg_base + PITA_ICR + 2);
38034518c086fc Wolfgang Grandegger  2011-09-12  708  
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  709  	for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
38034518c086fc Wolfgang Grandegger  2011-09-12  710  		priv = netdev_priv(dev);
38034518c086fc Wolfgang Grandegger  2011-09-12  711  		chan = priv->priv;
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  712  		prev_dev = chan->prev_dev;
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  713  
d0c5c584fb3542 Guangshuo Li         2026-09-16  714  		/* do that only for first channel */
d0c5c584fb3542 Guangshuo Li         2026-09-16  715  		if (!prev_dev && chan->pciec_card)
d0c5c584fb3542 Guangshuo Li         2026-09-16  716  			peak_pciec_remove(chan->pciec_card);
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  717  		unregister_sja1000dev(dev);
0b5a958cf4df3a Stéphane Grosjean    2014-05-20  718  		free_sja1000dev(dev);
38034518c086fc Wolfgang Grandegger  2011-09-12  719  	}
38034518c086fc Wolfgang Grandegger  2011-09-12  720  
38034518c086fc Wolfgang Grandegger  2011-09-12  721  	pci_iounmap(pdev, reg_base);
38034518c086fc Wolfgang Grandegger  2011-09-12  722  
38034518c086fc Wolfgang Grandegger  2011-09-12  723  failure_unmap_cfg_base:
38034518c086fc Wolfgang Grandegger  2011-09-12  724  	pci_iounmap(pdev, cfg_base);
38034518c086fc Wolfgang Grandegger  2011-09-12  725  
38034518c086fc Wolfgang Grandegger  2011-09-12  726  failure_release_regions:
38034518c086fc Wolfgang Grandegger  2011-09-12  727  	pci_release_regions(pdev);
38034518c086fc Wolfgang Grandegger  2011-09-12  728  
38034518c086fc Wolfgang Grandegger  2011-09-12  729  failure_disable_pci:
38034518c086fc Wolfgang Grandegger  2011-09-12  730  	pci_disable_device(pdev);
38034518c086fc Wolfgang Grandegger  2011-09-12  731  
5c2cb02edf79ad Stéphane Grosjean    2017-11-23  732  	/* pci_xxx_config_word() return positive PCIBIOS_xxx error codes while
5c2cb02edf79ad Stéphane Grosjean    2017-11-23  733  	 * the probe() function must return a negative errno in case of failure
9b69aff9fd1a66 Marc Kleine-Budde    2021-06-11  734  	 * (err is unchanged if negative)
9b69aff9fd1a66 Marc Kleine-Budde    2021-06-11  735  	 */
5c2cb02edf79ad Stéphane Grosjean    2017-11-23  736  	return pcibios_err_to_errno(err);
38034518c086fc Wolfgang Grandegger  2011-09-12  737  }
38034518c086fc Wolfgang Grandegger  2011-09-12  738  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
