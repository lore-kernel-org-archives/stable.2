Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C172E370D45;
	Thu, 18 Jun 2026 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764919; cv=none; b=Wp+pq7BobzGSS/u3FWpTSjnZi3z6FXeMwM+0dSDtwZsI7gyfV0reR4VzhnPT00wZnZSLFvLSxbA1glqIy/nK/PttIxdYYhT/FdVM2dVvESPwas09vfL4ecSRit5jdeurDngPmv2iI6m4+CCuYlmTBuKx/evN3wSiRow1i2vIZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764919; c=relaxed/simple;
	bh=lSsjKccp0ITIjYiN0WTMFkwAMTj8W2DyDIzfocqv2g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJ8FrF2exwcCtIiHEnUhPnpgRBL8gtD4GDaQUMn4nrtrzY3ZcKmW/2NJaLKkbMZ439as6d00i6YWM7vx87hunrt+kuDYTL0y5PRWPCO7B+WpFarbuhVN0SI/nfuyt/IHzlAzgN55tretdDv8IAIu8+6o8B5P0pZaNLLCwXzu/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQOEOGPr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQOEOGPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781764917; x=1813300917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lSsjKccp0ITIjYiN0WTMFkwAMTj8W2DyDIzfocqv2g4=;
  b=PQOEOGPrbuLtLphozZx+XrC5D0NUmNaBnhN4XEW1B3eNRvmhM2QYcgIZ
   3hZ51xaFXg1GVhQ9Q5JcYlumCm4LDASN+PSRPQ8xVy5LIzXP+qJ8QGOpe
   w2sfBGPkPpzvo7PWBR/+y/fTN8cI5xAyiVpUhI/eCAiEdlNMXZBpE3FnM
   jlVOEIizqnTNpeIGKwOsJ/vD0lrrihw0KfyjDkWPw8gggFxGhjfd1xvW5
   XluBPXp2uYELwrlHA4C5Fh4VHohASPVsqO4dWUxl2jr0FbU0y1S4+MTiS
   x3ntGKiqmZq16gmMr6m3aFazrIRelXb8gNOPRPFQlwQB9S7iPnxS27ahy
   Q==;
X-CSE-ConnectionGUID: c2eTg7CrR8KOtiESos+6wA==
X-CSE-MsgGUID: Zte37BeqQ92DGqF7eKmRtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82787474"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82787474"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:41:56 -0700
X-CSE-ConnectionGUID: JhEk7TCVQ/GVc0lVgZueGA==
X-CSE-MsgGUID: NZSjF6MDSJGiA315TB5EQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="271975710"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.10])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:41:52 -0700
Date: Thu, 18 Jun 2026 09:41:50 +0300
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
Message-ID: <ajOTLrrUCBxsy5jf@ashevche-desk.local>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-2-runyu.xiao@seu.edu.cn>
 <20260618062839.4o1ewdEn@linutronix.de>
 <ajOS2UR9pw_pUBxr@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajOS2UR9pw_pUBxr@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 09:40:31AM +0300, Andy Shevchenko wrote:
> On Thu, Jun 18, 2026 at 08:28:39AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-06-17 23:40:34 [+0800], Runyu Xiao wrote:
> > > sch_irq_unmask() enables the GPIO IRQ and then updates the controller
> > > state through sch_irq_mask_unmask(), which takes sch->lock with
> > > spin_lock_irqsave().  The callback can be reached from irq_startup()
> > > while setting up a requested IRQ.  That path is not sleepable, but on
> > > PREEMPT_RT a regular spinlock_t becomes a sleeping lock.
…
> > > Fixes: 7a81638485c1 ("gpio: sch: Add edge event support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> > 
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> There is already a v2.

Or not... I might have been confused with other patch that got two versions
in a row.

-- 
With Best Regards,
Andy Shevchenko


