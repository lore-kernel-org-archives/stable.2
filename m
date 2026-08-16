Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB5EEB3;
	Sun, 16 Aug 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786849307; cv=none; b=WGvrvI+jf3fZxsRb2pTIbpFr18IL0P2y1vzE/tuWNwtoOcEylpuLekoM+1fgebFsE1MnDQbrwoIRKija4NMUyOW9uz/ezLbGWPZzKmkOyqJrFSrbwRSNcuXVreDKkg6xYZjYf4LODPIwQ5evr6MHBRbpVZ0psRDnBdHUAFOk7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786849307; c=relaxed/simple;
	bh=yp7K/kfA27jeeIoNQBpdzCIYIozk4pkmL/+R5q6sKyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hecZ8J8/etRDdGkKctjylhON5GvVBJoDIXMjokgQsvvvvzkY9crvVNkj0ATUuumeGpWZHnlFaH25i1fNV09Sxdvn6v1nB/ePgLPJc2Yt1zGJ1jMUyIkweYQRiV3qcW6iuO2ZE9TpUy29bs0us/Dgj+0YnhabaDqdqAAQxuEsxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWW9Zyhx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWW9Zyhx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786849304; x=1818385304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yp7K/kfA27jeeIoNQBpdzCIYIozk4pkmL/+R5q6sKyI=;
  b=aWW9Zyhx/mzETf6lajs1FCL7PmO0Ty/UMVxIHPf/TfrLzxu3+LC2E2u6
   myDIZ8k2TEmgiaOaRaK/3Ir1Pz6v2WzRlDU4jFIk495038JkWhBwZ7w+V
   Gc5CARyGhikAHxgxCFLVKZitoTbhwmkGP3Dik3pwV3tO42F1Z1JQZ8Y2E
   81Q8nZNs1XEFIkDB6HLN97LlGMRhvS3mCVGddxFWUKV5bwnWQ4E131xc/
   RFnhX9VIOswtysqZgH+0hyD8NcCjuC7UuU62jQZFqz33hKDrAejLx6gJX
   aSD8ZY10dI8olHoZOGW0qyJzYpOEhKBuHDBitcYuc762sRXY7XYVir2YA
   w==;
X-CSE-ConnectionGUID: nu7f7jn5S36udiit9WSAog==
X-CSE-MsgGUID: cA5kUhfsSAyTOK+lKGBJEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="98031744"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="98031744"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 20:01:43 -0700
X-CSE-ConnectionGUID: PFAW3R9FQ9y0VVsmUMJBvg==
X-CSE-MsgGUID: LYFm/FfYS/SdEmaOmuEw8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="262806706"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Aug 2026 20:01:41 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvR7y-00000000ci6-112D;
	Sun, 16 Aug 2026 03:01:38 +0000
Date: Sun, 16 Aug 2026 11:01:02 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, ntb@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit
 failure
Message-ID: <202608161033.NUWmez14-lkp@intel.com>
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
[also build test ERROR on linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/ntb-fix-tx-descriptor-leak-on-dmaengine_submit-failure/20260815-061001
base:   https://github.com/jonmason/ntb ntb-next
patch link:    https://lore.kernel.org/r/20260628083301.9781-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2] ntb: fix tx descriptor leak on dmaengine_submit failure
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260816/202608161033.NUWmez14-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 844a18e753e822736c9805ab779144b647a2c186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608161033.NUWmez14-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608161033.NUWmez14-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ntb/ntb_transport.c:1577:2: error: call to undeclared function 'dmaengine_desc_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1577 |         dmaengine_desc_put(txd);
         |         ^
   drivers/ntb/ntb_transport.c:1577:2: note: did you mean 'dmaengine_desc_free'?
   include/linux/dmaengine.h:1607:19: note: 'dmaengine_desc_free' declared here
    1607 | static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
         |                   ^
   drivers/ntb/ntb_transport.c:1901:2: error: call to undeclared function 'dmaengine_desc_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1901 |         dmaengine_desc_put(txd);
         |         ^
   2 errors generated.


vim +/dmaengine_desc_put +1577 drivers/ntb/ntb_transport.c

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
