Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456732571A9;
	Sat, 15 Aug 2026 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786759530; cv=none; b=jfOJwbz/ILF4gxZccoEaboPxMsy9auUHNLTH/xBFzEs/DXHmcc3LQ2IiPMrUPOQP1YqJqPXHa2l3H/xvcBOPtp+BMDxnUZhK1Jen6JdjV/yb2NgFmpxP1vXLHuHRGdzF7O0npRd6v4lw1Tr0+rthShXj2np92zldydRQvKJS4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786759530; c=relaxed/simple;
	bh=kLmJB92xFKW+OhFvVXJXuOrb0RhwX9dprJzz7vdNb0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw52YJjrk+xmE8In6HizqzXc/2B4Mz6p4UOS9OJzSS5D6E8nrvr+O04PZozlwLQbW409W/3G46sj8qKcPiMLjTpKFUWElSIA+axyWooTG7mrWde6JHyvDB37P9dvU4ioM4K/3iq+wRbY6T2F+kdW6hjkfLRuAyh3n2v9m48OTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmx2FEQX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmx2FEQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786759527; x=1818295527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLmJB92xFKW+OhFvVXJXuOrb0RhwX9dprJzz7vdNb0g=;
  b=gmx2FEQXGaXAaiR/w3D1V0bJ0nKiPIeM7ffx1W2VbB1J1nIR+7Hfwqzx
   9i2mgI8FeDHB8ozUzUWmplFbg5rfQu1kdsjZHAQ9t2u/vsZ93/Vh7uLFF
   vt25MK7JSuLYqqSgy8w9g6gs8NLd15NIoFjvStb6oLbCnwdIjAiO+wpXM
   dQAeEidPS93O8NYORo4/Qwwf16bVQZBtapshoddG34tgYfHgj2rqMhrcC
   LQPxEjEvprrGvoV9cPkNt3+03hESTk4ROGMsWpVZPqZ7Gevrz2+7L3dEf
   d5jOGGnEj/kjpqDVKXib+kx2B+ZkcM99cMOjwmQF+hPrK/NRCl++KRdia
   g==;
X-CSE-ConnectionGUID: 44Y4OdxeRJKaYS8ktB6K3g==
X-CSE-MsgGUID: tgLupp2+SPCFtXVags5mlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87215829"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87215829"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 19:05:26 -0700
X-CSE-ConnectionGUID: iBVYgiMpQhCvp8uP5GPK6A==
X-CSE-MsgGUID: c0s07dDGR26sJN5hXDkU4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="294297479"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2026 19:05:24 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wv3lx-00000000apK-2BR0;
	Sat, 15 Aug 2026 02:05:21 +0000
Date: Sat, 15 Aug 2026 10:05:11 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, ntb@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit
 failure
Message-ID: <202608150920.Q3iV5WrW-lkp@intel.com>
References: <20260628083301.9781-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628083301.9781-1-vulab@iscas.ac.cn>

Hi WenTao,

kernel test robot noticed the following build errors:

[auto build test ERROR on jonmason-ntb/ntb-next]
[also build test ERROR on linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/ntb-fix-tx-descriptor-leak-on-dmaengine_submit-failure/20260815-061001
base:   https://github.com/jonmason/ntb ntb-next
patch link:    https://lore.kernel.org/r/20260628083301.9781-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit failure
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260815/202608150920.Q3iV5WrW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608150920.Q3iV5WrW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608150920.Q3iV5WrW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ntb/ntb_transport.c: In function 'ntb_async_rx_submit':
>> drivers/ntb/ntb_transport.c:1577:9: error: implicit declaration of function 'dmaengine_desc_put'; did you mean 'dmaengine_desc_free'? [-Wimplicit-function-declaration]
    1577 |         dmaengine_desc_put(txd);
         |         ^~~~~~~~~~~~~~~~~~
         |         dmaengine_desc_free


vim +1577 drivers/ntb/ntb_transport.c

  1515	
  1516	static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
  1517	{
  1518		struct dma_async_tx_descriptor *txd;
  1519		struct ntb_transport_qp *qp = entry->qp;
  1520		struct dma_chan *chan = qp->rx_dma_chan;
  1521		struct dma_device *device;
  1522		size_t pay_off, buff_off, len;
  1523		struct dmaengine_unmap_data *unmap;
  1524		dma_cookie_t cookie;
  1525		void *buf = entry->buf;
  1526	
  1527		len = entry->len;
  1528		device = chan->device;
  1529		pay_off = (size_t)offset & ~PAGE_MASK;
  1530		buff_off = (size_t)buf & ~PAGE_MASK;
  1531	
  1532		if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
  1533			goto err;
  1534	
  1535		unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
  1536		if (!unmap)
  1537			goto err;
  1538	
  1539		unmap->len = len;
  1540		unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(offset),
  1541					      len, DMA_TO_DEVICE, 0);
  1542		if (dma_mapping_error(device->dev, unmap->addr[0]))
  1543			goto err_get_unmap;
  1544	
  1545		unmap->to_cnt = 1;
  1546	
  1547		unmap->addr[1] = dma_map_phys(device->dev, virt_to_phys(buf),
  1548					      len, DMA_FROM_DEVICE, 0);
  1549		if (dma_mapping_error(device->dev, unmap->addr[1]))
  1550			goto err_get_unmap;
  1551	
  1552		unmap->from_cnt = 1;
  1553	
  1554		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
  1555						     unmap->addr[0], len,
  1556						     DMA_PREP_INTERRUPT);
  1557		if (!txd)
  1558			goto err_get_unmap;
  1559	
  1560		txd->callback_result = ntb_rx_copy_callback;
  1561		txd->callback_param = entry;
  1562		dma_set_unmap(txd, unmap);
  1563	
  1564		cookie = dmaengine_submit(txd);
  1565		if (dma_submit_error(cookie))
  1566			goto err_set_unmap;
  1567	
  1568		dmaengine_unmap_put(unmap);
  1569	
  1570		qp->last_cookie = cookie;
  1571	
  1572		qp->rx_async++;
  1573	
  1574		return 0;
  1575	
  1576	err_set_unmap:
> 1577		dmaengine_desc_put(txd);
  1578	err_get_unmap:
  1579		dmaengine_unmap_put(unmap);
  1580	err:
  1581		return -ENXIO;
  1582	}
  1583	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
