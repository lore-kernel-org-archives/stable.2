Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498793;
	b=SxLr2ePPL9hLuGn6VfR2dqcqJDHYW+thVcpW5cWCsSI5wWg208VCP8Cgq212nL8K+1MX
	 e9o2w4qxIAwhMsV8IvPLzCUabFOF1g0VLRxq10cvduTdL/fZf7drouB/BlHLTgp7wNj6/
	 W0vp3XouaBmnZfK3sQeyxUfFAyIMqRn8GdnZgwAk4UNIQZjRuB+c8dfGHkwZenpF74Vqw
	 w/wzQhgIfFKtEbqN4m132Q+13PAsW09X7BVN6/yxP4+5FmSJZh6/aUxeMYV98J/lm+aV/
	 A9PxGUnc2Lu07i8yMz86P0/gsJ6Cs6Y4JV18smfV3HJ0wvfz/bhGTzQRS4UFFmsdR0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498793;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=w++BIwO8/dqIECWxot5APF2rPiM3X4c4QcBs8w7bbqI=;
	b=uyZK8QpOBsm+gQP9vRb0kEcPrCKDbbQrysXlsVNSdclAFk3B6VhW2XsdZSQCd3VvxX1Q
	 tpZ86NIIazYi3cjy1K5c4lALZaCPlO/shA/3bt4l11DwdKSTzhjhe6hi59/zaQISdhuJV
	 3qvZXNZHuPy42lm0f28TyaDJmf5AJuYJJiInYGDaEd/5bzh+nPvoWE8d7DmWXw8dcFPKX
	 cQrcsJ0SW3oBvjakBxt6a2JTtAnZMQ7uotQ8C0y8J3StXyPoZ3F41H/TgmtF+F8Mb6KLZ
	 PYxoGb/DU33G90yN1S7xXurtfnLQIgwTtQ33jREQgaLF8QEIj8FQIc0HBynvnRWr9LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mmMu5bwt;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6406606A32E;
	Thu, 12 Nov 2026 15:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6406606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mmMu5bwt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794498793; x=1826034793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fgPUuaO5nA28Uy/H8XfCWdqtp8L+lwJnhVFRPPWuBwk=;
  b=mmMu5bwtHXM7NNRtkzYBLy16JZWQLnVyhLQwhirIMvkPGNqSaCJmrvd9
   2g2kkAYxtBzZbyXukniCCOraWszoVoTR9eS6wRBoLGu6zTIrvD2CuJknc
   K5VPx9iZ3iRXK1A2pFjCQDxIPeH3x3vNIx2A6ignvdKJ0Cr6PWdCIYEdd
   rdh8C2Hyu502pdKB0kkPxXFD3KkFGaTPeqsVpQIIYEkJZOB6aT2TdiW7W
   LmIEq/ydUha+76VnPTxOyfNcLoZP3ewtVkczaPrZNLFN/1cVh9EFkmTnz
   W1mmJ+6m7c/bvlCZU9nMPi+saEPFBtzpftCM9MFaWXm9MjtF9XdquMJ1j
   A==;
X-CSE-ConnectionGUID: ntMYyZtuR1O2eYJ/DcDRGA==
X-CSE-MsgGUID: xetW163qTxGTxiUyTgTvOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3168377"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3168377"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:53:12 -0800
X-CSE-ConnectionGUID: IHEYInatR12nSGukt9WkSg==
X-CSE-MsgGUID: qB3eyMisR2CgjnHwbvca2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8787916"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:53:07 -0800
Date: Thu, 12 Nov 2026 17:53:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dmaengine: dw-axi-dmac: preserve pending pause
 requests
Message-ID: <avXg3ye7ys6BmvvJ@ashevche-desk.local>
References: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-0-3ebc24b243db@gmail.com>
 <20261112-submit-dw-axi-dma-stop-pause-v1-v4-5-3ebc24b243db@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-submit-dw-axi-dma-stop-pause-v1-v4-5-3ebc24b243db@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 12, 2026 at 01:22:54AM -0700, James Hilliard wrote:
> dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
> can set that status after the last poll, and the unconditional clear then
> discards an acknowledgment the caller never observed. Another channel's
> interrupt can also consume the status because the shared IRQ handler
> clears every channel's status before taking its lock.
> 
> Leave SUSPENDED to the pause and resume paths. Track the suspend request
> separately from its acknowledgment so a timeout can be followed by either
> a pause retry or a resume. Wait for acknowledgment before clearing the
> hardware request, since hardware ignores an earlier clear. If that wait
> also times out, return -EAGAIN with the request still pending.
> 
> A completed transfer is also quiescent, but its completion handler may
> still need to advance a cyclic descriptor. Defer that restart while a
> pause is pending, and resume it without reprogramming the first LLI.
> Track the active descriptor until its completion handler runs so that
> resume and issue_pending cannot restart a completed cyclic segment or
> reissue a completed noncyclic descriptor while its IRQ is pending.
> Start queued work after the active descriptor is retired, respecting the
> pause request.
> 
> Clear stale suspension status at the start of a new descriptor rather
> than at each cyclic restart. Reset the software state after successful
> termination and when allocating a channel for a new client.
> 
> Store the lock-protected pause flags as bitfields in existing padding.

...

> +static bool axi_chan_is_suspended(struct axi_dma_chan *chan)
> +{
> +	if (!axi_chan_is_hw_enable(chan)) {
> +		/* A completed transfer cannot acknowledge a new suspend request. */
> +		axi_chan_disable(chan);
> +		return true;
> +	}
> +
> +	return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;

You can invert the conditional to be positive. This will also make code a bit
neater I think.

	if (axi_chan_is_hw_enable(chan))
		return axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED;

	/* A completed transfer cannot acknowledge a new suspend request. */
	axi_chan_disable(chan);
	return true;

> +}

...

> static int dma_chan_resume(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	unsigned long flags;
> +	int ret = 0;

Better in terms of maintenance is to make an assignment closer to its user.

>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  
> -	if (chan->is_paused)
> -		axi_chan_resume(chan);

	ret = 0;

> +	if (!chan->pause_requested)
> +		goto out;
> +
> +	/* Hardware ignores resume until the suspend request is acknowledged. */
> +	ret = axi_chan_wait_for_suspend(chan);
> +	if (ret)
> +		goto out;
> +
> +	axi_chan_resume(chan);
> +	if (chan->cyclic_restart) {
> +		chan->cyclic_restart = false;
> +		axi_chan_enable(chan);
> +	} else {
> +		axi_chan_start_first_queued(chan);
> +	}
>  
> +out:
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>  
> -	return 0;
> +	return ret;
>  }

...

> struct axi_dma_chan {
>  	void __iomem			*chan_regs;
>  	u8				id;
>  	u8				hw_handshake_num;

+ blank line?

> +	/* Protected by vc.lock. */
> +	bool				pause_requested:1;
> +	bool				is_paused:1;
> +	bool				cyclic_restart:1;
> +
>  	atomic_t			descs_allocated;
>  
>  	struct dma_pool			*desc_pool;

>  	struct axi_dma_desc		*desc;
>  	struct dma_slave_config		config;
>  	enum dma_transfer_direction	direction;
> -	/* these other elements are all protected by vc.lock */
> -	bool				is_paused;
>  };

-- 
With Best Regards,
Andy Shevchenko


