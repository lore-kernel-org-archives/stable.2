Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429ED3DA7D0;
	Thu,  6 Aug 2026 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007041; cv=none; b=obJlN3Zlu96T4lb4AowT5Pi+LyECTREabtzk+XCBHw1lCKIXdRrjHlCgNL9vwrVe9soXMFeUxHAbuBtBjr58vnN/Am23WEsvHMWgbiQ+d63wMI4qa6VG0BcmEzr30KuGwY/2HbynSKPNFecU5F0tSPOAllTmbK81SwRtibyo1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007041; c=relaxed/simple;
	bh=hRmHae7K5L1NrBLBQLNmjHXkdJmOg7U/rq8oaZxB6Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyvAfvy4Gelaevks16V8I+TeCWrGUj56NL7jlRBj2dlCj9yHGXyTe4zMYMbJ/5kvBtS8ygc7pRrBaJXRivfAvpBaPkeJTYXynbhbZbVql8/t5Ye5nzygG3uIU21B9EjhYhYWafrUBYOy6TfJdiqw3seE+vLIZ4MCl0KBnSq9mvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayR3aEw/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayR3aEw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786007039; x=1817543039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hRmHae7K5L1NrBLBQLNmjHXkdJmOg7U/rq8oaZxB6Lk=;
  b=ayR3aEw/23FNi/9tZ3wcnpGkA3FCTLhBOk+1Prr6pHeH/Vh3BXPVrex8
   DH0p1T2ujScx2a//kJaI6v/JT1M/K31NEkAIwuKIQsiqHaLq1AuJtw4lj
   fGGtL3tR/ZhetTuejNckoffCw9X9oricEs3S3Ppr0zXLmirenRjMbxdcj
   QawCUhjHdmxzJBaKvIwTExVFLmZo02Dg+PYdc6GDlIcTCcSPDTx/khZUM
   vc58XHqol+JWf7SjP3w4yuqlnpm3UL5LHoMXWMG9G5y1gyTg/yudN6I74
   RmLMHZMnQid6/ZTofRX1r6A3Y/B/rBnacVUfZ6tMO7hP8yZdjVNpeN8BK
   w==;
X-CSE-ConnectionGUID: DEgiDhqES0qYvDy5rCstrg==
X-CSE-MsgGUID: TZ2Q0LU4Q0eAHpzlRkjcyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86469041"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86469041"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 02:03:58 -0700
X-CSE-ConnectionGUID: uMiWEOHhTya1/RcbwGrAlQ==
X-CSE-MsgGUID: R9sb5GQ+Quagee3hReXYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="265525326"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2026 02:03:56 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wru13-00000000EgD-3ack;
	Thu, 06 Aug 2026 09:03:53 +0000
Date: Thu, 6 Aug 2026 17:03:13 +0800
From: kernel test robot <lkp@intel.com>
To: Jiazi Liu <jiazi.liu1984@gmail.com>, Thinh.Nguyen@synopsys.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jiazi Liu <liujiazi@amazon.com>
Subject: Re: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event
 buffer count
Message-ID: <202608061759.sIcC6h4C-lkp@intel.com>
References: <20260727094015.5101-1-liujiazi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727094015.5101-1-liujiazi@amazon.com>

Hi Jiazi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v7.2-rc6 next-20260805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiazi-Liu/usb-dwc3-gadget-fix-IRQ-storm-on-invalid-event-buffer-count/20260806-005046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20260727094015.5101-1-liujiazi%40amazon.com
patch subject: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event buffer count
config: i386-randconfig-r132-20260806 (https://download.01.org/0day-ci/archive/20260806/202608061759.sIcC6h4C-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260806/202608061759.sIcC6h4C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608061759.sIcC6h4C-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/dwc3/gadget.c:4681:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct dwc3 *dwc @@     got void [noderef] __iomem *regs @@
   drivers/usb/dwc3/gadget.c:4681:32: sparse:     expected struct dwc3 *dwc
   drivers/usb/dwc3/gadget.c:4681:32: sparse:     got void [noderef] __iomem *regs

vim +4681 drivers/usb/dwc3/gadget.c

  4636	
  4637	static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
  4638	{
  4639		struct dwc3 *dwc = evt->dwc;
  4640		u32 amount;
  4641		u32 count;
  4642	
  4643		if (pm_runtime_suspended(dwc->dev)) {
  4644			dwc->pending_events = true;
  4645			/*
  4646			 * Trigger runtime resume. The get() function will be balanced
  4647			 * after processing the pending events in dwc3_process_pending
  4648			 * events().
  4649			 */
  4650			pm_runtime_get(dwc->dev);
  4651			disable_irq_nosync(dwc->irq_gadget);
  4652			return IRQ_HANDLED;
  4653		}
  4654	
  4655		/*
  4656		 * With PCIe legacy interrupt, test shows that top-half irq handler can
  4657		 * be called again after HW interrupt deassertion. Check if bottom-half
  4658		 * irq event handler completes before caching new event to prevent
  4659		 * losing events.
  4660		 */
  4661		if (evt->flags & DWC3_EVENT_PENDING)
  4662			return IRQ_HANDLED;
  4663	
  4664		count = dwc3_readl(dwc, DWC3_GEVNTCOUNT(0));
  4665		count &= DWC3_GEVNTCOUNT_MASK;
  4666		if (!count)
  4667			return IRQ_NONE;
  4668	
  4669		if (count > evt->length) {
  4670			dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
  4671				count, evt->length);
  4672			/*
  4673			 * The DWC3 interrupt is level-triggered. Returning IRQ_NONE
  4674			 * without clearing the IRQ source leaves the line asserted,
  4675			 * causing a tight IRQ storm that triggers spurious.c:184 BUG.
  4676			 * Write the bogus count back to GEVNTCOUNT to clear the source,
  4677			 * consistent with the stale event clearing in
  4678			 * dwc3_event_buffers_setup(), then schedule a soft disconnect
  4679			 * to recover the controller state.
  4680			 */
> 4681			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
  4682			schedule_work(&dwc->softcon_work);
  4683			return IRQ_HANDLED;
  4684		}
  4685	
  4686		evt->count = count;
  4687		evt->flags |= DWC3_EVENT_PENDING;
  4688	
  4689		/* Mask interrupt */
  4690		dwc3_writel(dwc, DWC3_GEVNTSIZ(0),
  4691			    DWC3_GEVNTSIZ_INTMASK | DWC3_GEVNTSIZ_SIZE(evt->length));
  4692	
  4693		amount = min(count, evt->length - evt->lpos);
  4694		memcpy(evt->cache + evt->lpos, evt->buf + evt->lpos, amount);
  4695	
  4696		if (amount < count)
  4697			memcpy(evt->cache, evt->buf, count - amount);
  4698	
  4699		dwc3_writel(dwc, DWC3_GEVNTCOUNT(0), count);
  4700	
  4701		return IRQ_WAKE_THREAD;
  4702	}
  4703	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
