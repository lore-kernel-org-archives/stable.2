Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296781;
	b=w1zs0byYMYa6mNWEXvqSP4xCa7ARSYwEB8kOEso541svwPMVxMKGEJ72LKzbvU3qsjvP
	 xzz6C0ipyW88Vau56a5KWy0Sbqmu9UG7ueFl/TGX9KfKlnVVPpzqOSIqA8r36FBveiIfp
	 kZ32sb6vaWUIxuWkLexs3RvAyK+0NarEz9tSxR9Dn+13tjL9iZUbQGzqDFCemmNzadhUG
	 0XRffuTqQ/wpg1fnAovSZ6xc72FEtLuuhsc8aRfRH9+WdgfhJwwR9WFMVC8LZ4+SJjXyS
	 YPmkf+8BvMhzEuwNCHsTd9Gc1dlVska6yYzQHfIx5eRJu7k5HFxsevl9tyf+VaIMgMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296781;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=g+rzLsEDtoHChRb3W0ywuz4TUSwIklWRQMltFUo1B7g=;
	b=vsJ3yYN1mrRiY0ROmZ44vy9vSb0OHjp04retylnZ6DgUf96tKGcK/cX90i6jAyfg70DR
	 9EHvPQdVvLukDqgOxsnIOpZKOvVoPF3CJSq8pDEu8QmvlsfhPN/SYAS0Kf7Om+KEMKYds
	 EBLRm22jvjKwaEPd8jJtrYPck6GrKFxwLW47NO4upa/29Y2ConaOzdPbjSYgM65yBnMH0
	 yuQ2+vJ0GCoN3U2WC9QDgbf1rEqqZvN+4/j5s0iwwZ+U9cBrEBvDig2qr71LWK/p5FrrA
	 zmsCqDsqDBN9TrYu50hSuVAL8Am+ife3Z39ZGosQaJL55tr9PN/sXUlaEeaGdgRPWug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jbjk7jBs;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECC606A33D;
	Tue, 10 Nov 2026 07:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96ECC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jbjk7jBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794296781; x=1825832781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nFoWB/WLRdL9em8tNSimN1sn8Ih9yTU1vSklb3AvshY=;
  b=jbjk7jBsZhoc72J3Y5Hfz9TFEqhM0oHAIbSlkfoJ64FWrh2BXMG3xhrJ
   OfAF4sVVes7d4JPmt396YqBXSGPulyjebjazs9eHINYApOPIYz3JTT42K
   1Hp3RmHbZ9zCM0mP3qbEl6ySRImkxE5QRoNqo8pHoBpPxdl8CItaIFjWF
   e8EYPEl5tniFqCnqi6/TaxQDioOnLhfFweeyo//zQAbbAuJQPSjidoU5o
   7vdxd9WiK5521dMTYnGCNVUIks2rOPSiENjKnwNKxifpEorvTeH7NYra0
   VwJKRKQWoTCrVoykgZy10hlqP+lzpm7nHdfxnNCc90bM2nA79lMIZeikV
   A==;
X-CSE-ConnectionGUID: 7d9IbReBSCaOI8ABAnfAAQ==
X-CSE-MsgGUID: krMm9I2JTgq9UUMHhLyN3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2912056"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2912056"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:46:20 -0800
X-CSE-ConnectionGUID: hM/EFHwBQ/C1fSHcwXoazg==
X-CSE-MsgGUID: rDlZ8xkqRGiDW+AkcbzicQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7900404"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 23:46:17 -0800
Date: Tue, 10 Nov 2026 09:46:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: dw-axi-dmac: preserve pending pause
 requests
Message-ID: <avLLx7pNSiFLbxE-@ashevche-desk.local>
References: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-0-64adc48df793@gmail.com>
 <20261109-submit-dw-axi-dma-stop-pause-v1-v2-3-64adc48df793@gmail.com>
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
In-Reply-To: <20261109-submit-dw-axi-dma-stop-pause-v1-v2-3-64adc48df793@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 08:06:02PM -0700, James Hilliard wrote:
> dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
> can set that status after the last poll, including during the final
> delay, and the unconditional clear then discards an acknowledgment the
> caller never observed. Another channel's interrupt can also consume the
> status because the shared IRQ handler clears every channel's status
> before taking its lock.
> 
> Leave SUSPENDED to the pause and resume paths. Track the suspend request
> separately from its acknowledgment so a timeout can be followed by either
> a pause retry or a resume. Wait for acknowledgment before clearing the
> hardware request, since hardware ignores an earlier clear. If that wait
> also times out, return -EAGAIN with the request still pending. Use the
> atomic polling helper so an acknowledgment during the final delay is
> observed.
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

...

> +/* Called with vc.lock held. A timed-out request can still be acknowledged. */

We have context checkers, please use __must_hold() or alike annotations.

> +static int axi_chan_wait_for_suspend(struct axi_dma_chan *chan)
> +{
> +	bool suspended;
> +	int ret;
> +
> +	if (chan->is_paused)
> +		return 0;
> +
> +	ret = readx_poll_timeout_atomic(axi_chan_is_suspended, chan, suspended, suspended,
> +				       2, 40);

Again, fix indentation, reformat and split logically.

	ret = readx_poll_timeout_atomic(axi_chan_is_suspended, chan,
					suspended, suspended, 2, 40);

(note no leading spaces in the second line, only tabs fit).

> +	if (ret)
> +		return -EAGAIN;
> +
> +	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +	chan->is_paused = true;
> +	return 0;
> +}

...

> -	do  {
> -		if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED)
> -			break;
> -
> -		udelay(2);
> -	} while (--timeout);
> -
> -	axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> -
> -	chan->is_paused = true;
> -
> +wait:
> +	ret = axi_chan_wait_for_suspend(chan);

You may split the conversion to readx_poll_timeout() into a separate patch.

...

> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -52,7 +52,9 @@ struct axi_dma_chan {
>  	enum dma_transfer_direction	direction;
>  	bool				cyclic;
>  	/* these other elements are all protected by vc.lock */
> +	bool				pause_requested;
>  	bool				is_paused;
> +	bool				cyclic_restart;

Probably making them bitfields will be a good idea to save some memory:

	bool				pause_requested:1;
	bool				is_paused:1;
	bool				cyclic_restart:1;

>  };

Just run `pahole` before and after (won't probably show you the gain,
but before might show better position for "cyclic" member, which can
be amended later).

-- 
With Best Regards,
Andy Shevchenko


