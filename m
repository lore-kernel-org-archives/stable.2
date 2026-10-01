Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F04A0EF0;
	Thu,  1 Oct 2026 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841479; cv=none; b=Oq8gYhQ1m1ItEG7keF+/4jRYW/UEdTDSV1RzzxbbxIbMp6DEkfw6hslAaOHlBbTitcUVjRUyhN67hQ7BnimdkRv+Z4eiA2Atif/VyAqdGJJWw3X9Fwbmf5gJLiqurK4WL3Q+x8kyvwUCu+Bidf73jsy3NnZn++PAu63L8PuoKLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841479; c=relaxed/simple;
	bh=ly+BWC52sF/OYFXfYj6BaYppy1ieR0G9wlserb6IaFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMpCi774NVL8fKQIN3kgGu8Tijtt+Pq7FGTIZdrrlNts2U46Af+HWmZJtgFFN46KIB1UChZSvSpxL7V5aE59ZWRYUZuFl6ym/3wqoCBOiLGgi7jarRIHfRkrUId+vqhS/jvYYiXcMFIyJ2fpeg8mZltHUKdUbvB2EG6X6RcMkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2XN6vES; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIWTvi4k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2XN6vES";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIWTvi4k"
Date: Thu, 1 Oct 2026 09:57:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790841476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6T3x2RxWtqqk+wcudz6NNG13H0Pe7ygwHg54hjQ92w=;
	b=a2XN6vEStkiFi4QOi2f58GVZzy5OQFXqqk7Ju2BKHLVRY2zZHPoryFCiT2qC/UMIjSahtI
	1AZ2vscsoD9mRcAaXOBlO+PZOnq+861nS3Jk9nQ0/TcGn2xdVtW+qFDR2uqu7aRcvsYdX8
	DWEsRikHHEZ+nzdqtMJaYQ3tWulAFjJzwrhZH2S8lNC0cvUmNXvZGvxlTJwUwKypOTWZNf
	5rJHxIu7LYme0UGvq2cni+sfzkQ/FpuTv9j1e4jqx7YH2zPJcnNtyqCfVik72AjHd0sRLT
	ZXg3oOg3HnKCho6rnZGsUfqmwCMbIMI8PBGw8fLja4uw0sRuQK3zfPS4BDuZNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790841476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M6T3x2RxWtqqk+wcudz6NNG13H0Pe7ygwHg54hjQ92w=;
	b=fIWTvi4kPkbBnrdPPo1dRokyr6OevCik1PKF0bbmV08CTQ5B5bFH2eyO9zqbURz5QiDFaE
	u2jhQdhydAKjVPCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
Message-ID: <20261001075755.3MilPS2C@linutronix.de>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930185417.61865-1-kmehltretter@gmail.com>

On 2026-09-30 20:54:17 [+0200], Karl Mehltretter wrote:
> With the default fcmode=0, netpoll calls ndo_start_xmit() with hard
> interrupts disabled and reaches brcmf_sdio_bus_txdata() directly. The
> function takes txq_lock with spin_lock_bh(), and the queue helper takes
> the embedded sk_buff_head lock. These locks may sleep on PREEMPT_RT.
> On non-RT, spin_unlock_bh() can run pending networking softirqs before
> netpoll releases the transmit lock, causing a recursive transmit
> deadlock.
> 
> Use spin_trylock() for IRQ-disabled calls and enqueue with the unlocked
> skb helper while holding txq_lock. On PREEMPT_RT, reject hard IRQ and NMI
> callers, where rt-spinlocks cannot be acquired. If the lock is busy or
> the queue is full, return through the existing drop path. Do not evict an
> older packet from this context. Suppress the queue-full printk because
> netconsole can recursively enter this path.
> 
> The flow-control callback takes another spinlock, so defer it when an
> IRQ-disabled enqueue reaches TXHI. The data worker rechecks the bus state
> and queue length under txq_lock before stopping the queue. Existing TXLOW
> handling wakes the queue after it drains.
> 
> This fixes the direct SDIO transmit path used by fcmode=0. Modes 1 and 2
> take the FWS lock first and need a separate change.

Is this the only affected driver?
Do you have maybe a backtrace?

> Fixes: ac3d9dd034e5 ("netpoll: make ndo_poll_controller() optional")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sebastian
