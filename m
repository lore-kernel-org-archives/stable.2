Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5E125AA;
	Thu,  6 Aug 2026 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983535; cv=none; b=niGzjNxbt/82L3OpTRLpkS15fyukKXgjDrQ6MOeNTih6phhH2BFukBSlBFT8MR472a4JnFy8wEJNdbtuTFjEK5VfV7SfTZ+ZCFs/B5HgdSpmwTp4gAhIyaTFBZtMA+o2y9csvleYHYZY+zo/MEyD9spAfm2WJSjOnYpwblMN71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983535; c=relaxed/simple;
	bh=TsYc7cwpjOopvgez9AL09vcOfIwg9inQssuLz6FI+z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITNA8CpPQu9gPHyyZD5U48wZnUQ2h7Lrs+q7pdJvXfRzRCEhvR91BkSedvAU5zAgupTJmNlynKOjIxmCJC7HWZ22UV+Fnnb+4CevVoXgJL7b8sqdLPF3UK8OyqT7GXCdnVRjDbH6dHpAxZjnYvxpNg+gWHczAl3JhV7n/rQV3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xv4Hq5XR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xv4Hq5XR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785983534; x=1817519534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TsYc7cwpjOopvgez9AL09vcOfIwg9inQssuLz6FI+z8=;
  b=Xv4Hq5XRunmuC3Rd9TH7oGQKd93thzc/UHjqpougfPjMvA8ntFSB4xG/
   2dUCSoLBKU908VLxoDKC7+KfCTPVaELiFU4rz4u4k2PgrHv+Ru3r+Cjef
   HP4OH+oqxEhCPk0bs6tMyo+Dw5liOBq3C0F7+TXo5xEHgnGyTEtkrMhQm
   MH1vipV+PuSjShHYdXkjDASQP58tpUAvpjc72qrql0tLVgt7lm2uKmnef
   3lalOlOif/JzvARbVBzNKILCUnnwMk379VJzq/IG5azl2uIQbSfb9rZM/
   aANn8J/18YBSsNPveNlSQilOR7cioeGLbV/bgGIxlXoPQYbtqjKteNS8j
   w==;
X-CSE-ConnectionGUID: WXy0R4a0QAGbtztNgM8VcA==
X-CSE-MsgGUID: vlrGFBfvQJ2S4QXRIhqtoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="98080987"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="98080987"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:32:14 -0700
X-CSE-ConnectionGUID: fywgfRtxRNKiE06hbj9Ibg==
X-CSE-MsgGUID: 4ESvDbWbQlW1kLb0OmI/og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="262587032"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Aug 2026 19:32:12 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wrntw-00000000Dyz-2Ryh;
	Thu, 06 Aug 2026 02:32:08 +0000
Date: Thu, 6 Aug 2026 10:31:44 +0800
From: kernel test robot <lkp@intel.com>
To: WenTao Liang <vulab@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-ntb@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, WenTao Liang <vulab@iscas.ac.cn>
Subject: Re: [PATCH] fix: ntb: perf_copy_chunk: fix tx descriptor and unmap
 kref leak on   dmaengine_submit failure
Message-ID: <202608061007.81Ieq7bt-lkp@intel.com>
References: <20260626153917.53128-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626153917.53128-1-vulab@iscas.ac.cn>

Hi WenTao,

kernel test robot noticed the following build errors:

[auto build test ERROR on jonmason-ntb/ntb-next]
[also build test ERROR on linus/master v7.2-rc6 next-20260805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WenTao-Liang/fix-ntb-perf_copy_chunk-fix-tx-descriptor-and-unmap-kref-leak-on-dmaengine_submit-failure/20260806-074331
base:   https://github.com/jonmason/ntb ntb-next
patch link:    https://lore.kernel.org/r/20260626153917.53128-1-vulab%40iscas.ac.cn
patch subject: [PATCH] fix: ntb: perf_copy_chunk: fix tx descriptor and unmap kref leak on   dmaengine_submit failure
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260806/202608061007.81Ieq7bt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061007.81Ieq7bt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061007.81Ieq7bt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ntb/test/ntb_perf.c: In function 'perf_copy_chunk':
>> drivers/ntb/test/ntb_perf.c:854:9: error: implicit declaration of function 'dmaengine_desc_put'; did you mean 'dmaengine_desc_free'? [-Wimplicit-function-declaration]
     854 |         dmaengine_desc_put(tx);
         |         ^~~~~~~~~~~~~~~~~~
         |         dmaengine_desc_free


vim +854 drivers/ntb/test/ntb_perf.c

   784	
   785	static int perf_copy_chunk(struct perf_thread *pthr,
   786				   void __iomem *dst, void *src, size_t len)
   787	{
   788		struct dma_async_tx_descriptor *tx;
   789		struct dmaengine_unmap_data *unmap;
   790		struct device *dma_dev;
   791		int try = 0, ret = 0;
   792		struct perf_peer *peer = pthr->perf->test_peer;
   793		void __iomem *vbase;
   794		void __iomem *dst_vaddr;
   795		dma_addr_t dst_dma_addr;
   796	
   797		if (!use_dma) {
   798			memcpy_toio(dst, src, len);
   799			goto ret_check_tsync;
   800		}
   801	
   802		dma_dev = pthr->dma_chan->device->dev;
   803	
   804		if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
   805					 offset_in_page(dst), len))
   806			return -EIO;
   807	
   808		vbase = peer->outbuf;
   809		dst_vaddr = dst;
   810		dst_dma_addr = peer->dma_dst_addr + (dst_vaddr - vbase);
   811	
   812		unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
   813		if (!unmap)
   814			return -ENOMEM;
   815	
   816		unmap->len = len;
   817		unmap->addr[0] = dma_map_page(dma_dev, virt_to_page(src),
   818			offset_in_page(src), len, DMA_TO_DEVICE);
   819		if (dma_mapping_error(dma_dev, unmap->addr[0])) {
   820			ret = -EIO;
   821			goto err_free_resource;
   822		}
   823		unmap->to_cnt = 1;
   824	
   825		do {
   826			tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, dst_dma_addr,
   827				unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
   828			if (!tx)
   829				msleep(DMA_MDELAY);
   830		} while (!tx && (try++ < DMA_TRIES));
   831	
   832		if (!tx) {
   833			ret = -EIO;
   834			goto err_free_resource;
   835		}
   836	
   837		tx->callback = perf_dma_copy_callback;
   838		tx->callback_param = pthr;
   839		dma_set_unmap(tx, unmap);
   840	
   841		ret = dma_submit_error(dmaengine_submit(tx));
   842		if (ret)
   843			goto err_free_resource;
   844	
   845		dmaengine_unmap_put(unmap);
   846	
   847		atomic_inc(&pthr->dma_sync);
   848		dma_async_issue_pending(pthr->dma_chan);
   849	
   850	ret_check_tsync:
   851		return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
   852	
   853	err_free_resource:
 > 854		dmaengine_desc_put(tx);
   855		dmaengine_unmap_put(unmap);
   856	
   857		return ret;
   858	}
   859	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
