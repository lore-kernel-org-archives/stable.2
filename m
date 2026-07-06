Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEEC37C93C;
	Mon,  6 Jul 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350268; cv=none; b=ItQUrnnU+Ov/aQ08zWmvINaFSRV+z05FxK2E06Fciy8WPeqsJKVHXjT4M5+MBG4LKRcZCjFCZbtrcKy6URkcb+qx4TM1eQfgzxLf7rDM4wrgkauzoDiuRx/LZVoOxQNtSEL/0X5uFH9AatRQhfmC0G+XCL0rTQbNt9NoU0Hnme8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350268; c=relaxed/simple;
	bh=owEWpGSXcs6lwNMZKNUKIE+uhW1e3WdbBPjtlGXJ2bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVomlAPDdlg6dVmiApu9fjWyZFF5Jd6nUoIDoivegzUasAmveKpPOYNkMLn8nc771fXcgGZeSqKtk1HRuytmJf2EGBK7t1A8mAdP7OBJpikOBXHD7JZcehgOYTvru7VjVWGxfwFrYXXXXTS2UJAC6jcmoVR19gWhc/pjSlKwm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhrMiT2P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIzjfy3t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhrMiT2P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIzjfy3t"
Date: Mon, 6 Jul 2026 17:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783350263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4njRJkRCW35+KyLFk1zAgC1OeVYPM6ryxzAWbeONMc=;
	b=rhrMiT2PmX9/0Oe9XdAkb+mhGvw5jTQ/1XIpHOFK3jzTRgbEmlHSm7FdHaiaBqTVrHNnaN
	G5V37zDmAANuKcxH+ihraLoZrn14iNJZ+b6cDqau5mDQ9i7lnuroM0u/K59sts6gPtHOq8
	56mTAw8ADyWE4rn2C/jyGK9OqQmy3TC6PQh7Mvv/l6MbACMhtCaufmYsOlFUkhOv+lQVOU
	uhSDy5AleTGjRTHr5rMoL51+B2Ze271JFeEPnmGiNWiYNLgRbDcg5HiiH2hv+mNM9h9K+l
	kV6CRMKe4tWwKQEI4GqQTmqyuBEshm8s82fs3jAdZKRNzmCF1Kc5R+6USm2mCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783350263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4njRJkRCW35+KyLFk1zAgC1OeVYPM6ryxzAWbeONMc=;
	b=pIzjfy3twjMvHZA3jYwSADJCqrxEkARhAMmXHlMFg5VUTFk9dX1maw1076msHlHe76tkzU
	NkUex8lhFcRbOBCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: christian.taedcke@weidmueller.com
Cc: christian.taedcke-oss@weidmueller.com,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>, Simon Horman <horms@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <20260706150422.-wYiCBuE@linutronix.de>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>

On 2026-07-06 16:02:14 [+0200], Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> gem_shuffle_tx_one_ring() rotates the software TX ring so that the
> tail sits at index 0 and resets queue->tx_tail to 0, but it never
> reprograms the hardware transmit buffer queue pointer (TBQP). Other
> paths that reset tx_tail to the ring base (macb_init_buffers() and
> macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
> path does not, leaving TBQP pointing at a stale descriptor.
> 
> gem_shuffle_tx_rings() runs on every link-up from
> macb_mac_link_up(). After a few link up/down flaps that leave
> un-completed descriptors in the ring, the stale TBQP keeps pointing at
> a descriptor whose used bit is set. When TX is re-enabled on link-up,
> the GEM reads that used descriptor and raises TXUBR. macb_interrupt()
> schedules the TX NAPI, macb_tx_poll() makes no progress (work_done ==
> 0) and macb_tx_restart() re-issues TSTART, which makes the controller
> read the same used descriptor again and re-assert TXUBR. As the MAC
> interrupt is level-triggered, it never deasserts and one CPU is pegged
> at 100% in the threaded handler, eventually triggering "sched: RT
> throttling activated" and a dead network interface.

But this should also happen with !RT at which point the interrupt runs
at 100% CPU and the softirq has hardly an chance to make progress, no?

> Fix it by reprogramming TBQP to the ring base on every path of
> gem_shuffle_tx_one_ring() that resets tx_tail to 0, mirroring
> macb_tx_error_task(). The early return for an already-aligned tail is
> left untouched as TBQP is already consistent there. This is safe
> because the shuffle runs from macb_mac_link_up() while TE is still
> disabled, so the transmitter is halted.
> 
> Fixes: 881a0263d502 ("net: macb: Shuffle the tx ring before enabling tx")

This is v7.0-rc4. So that RT tree of yours has some backports or did you
run into this while trying to reproduce it upstream?

> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index fd282a1700fb..b11cb8f068b7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>  	if (!count) {
>  		queue->tx_head = 0;
>  		queue->tx_tail = 0;
> -		goto unlock;
> +		goto reset_hw_ptr;

This update is even needed for count == 0 case? I kind of do understand
that you need to updated if you shuffled the descriptors around.

>  	}
>  
>  	shift = tail % ring_size;
> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
>  	/* Make descriptor updates visible to hardware */
>  	wmb();
>  
> +reset_hw_ptr:
> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
> +	 * to write directly here as TX is still disabled (called from
> +	 * macb_mac_link_up() before TE is set).
> +	 */
> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }
> 

Sebastian
