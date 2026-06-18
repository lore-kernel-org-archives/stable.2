Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E23370EC;
	Thu, 18 Jun 2026 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764833; cv=none; b=j3fNKePMD8UUuqdIr21U/C1mCYWzu8TMjvDS/902Ba8n+naq537DjONaHyQ39xKKDExu268300jwOLtWjyuKIpP8wHf4v8Cv/EZ5iP671k3qiWWl4l1UTpYTW7YtJXp/MpmvxRvfyPROQpl0/0OantxO3b2stlQ+8kmCKvaptbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764833; c=relaxed/simple;
	bh=BumMsBSMG1s9RkeZoB5IVq+5GgZbpDM82QYWrngLh0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHkOEVGPCqgt19kJQ599+WxZVDc+odhKvM6xfIHJSNNHmTStypJjp2GbQoOIOhtrTXBig2DHs2FNfnDUG3WeFwCPQUtN/JAi7HX++tti0KZiNfgLN13Zli84z5ZVgAW061ot3bIvre+oA70i4Bvp2c7s1R25t5KRJDuudMMSTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRMD+n+T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRMD+n+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781764832; x=1813300832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BumMsBSMG1s9RkeZoB5IVq+5GgZbpDM82QYWrngLh0g=;
  b=cRMD+n+TCBUEYZGcTEXskT9XwGj7BzP/QGvzIfSBJDw2JXwD8w/UZz5V
   QsyNlqaGc2FLSySliPVk1riCoRUJK9FrYq30otMHCI81Em5eTzD9MfXvN
   KilhV3751rR0aug9+aSaKSDQDF4IAcv7WL/0pYhxsmTB1aIaS5X1J6MpY
   Cu/5Om3LM9rtaA/1d/9jJx570tN0R31WANv8NV+3rxob3HLPkQ4KGHb7f
   pbvheLKkBqkgAOxsahR63TuLrEG5SUbZuiKm7JyOrqlyCokqEmNwUkeAA
   X4KhVKv97X5cr3by+kIJQNnk9fgx1Fk7mfV8YvCD6wxyJaXl8lQJzrW7f
   g==;
X-CSE-ConnectionGUID: dM3Uw8fZSpyfQyhq7Ght1A==
X-CSE-MsgGUID: nXTOOMkoQNCKJMH7yjPclw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86504824"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="86504824"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:40:32 -0700
X-CSE-ConnectionGUID: MB7qguYtRgqQyZ9s2rpayA==
X-CSE-MsgGUID: ZleeRUKyTEOdeByrUeHoZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248371127"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:40:28 -0700
Date: Thu, 18 Jun 2026 09:40:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-gpio@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: sch: use raw_spinlock_t in the irq startup path
Message-ID: <ajOS2UR9pw_pUBxr@ashevche-desk.local>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>
 <20260618062839.4o1ewdEn@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618062839.4o1ewdEn@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 08:28:39AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-17 23:40:34 [+0800], Runyu Xiao wrote:
> > sch_irq_unmask() enables the GPIO IRQ and then updates the controller
> > state through sch_irq_mask_unmask(), which takes sch->lock with
> > spin_lock_irqsave().  The callback can be reached from irq_startup()
> > while setting up a requested IRQ.  That path is not sleepable, but on
> > PREEMPT_RT a regular spinlock_t becomes a sleeping lock.
> …
> > Fixes: 7a81638485c1 ("gpio: sch: Add edge event support")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

There is already a v2.

-- 
With Best Regards,
Andy Shevchenko


