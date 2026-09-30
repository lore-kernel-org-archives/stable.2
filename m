Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942E522EEB;
	Wed, 30 Sep 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804629; cv=none; b=riRnBEfq1/r29vHrFzMi7VBjbPjghVmceiiAZOVT93QJGmvvwnfmfdBKmPQbFaRToTiGPx9FkdEm6IKK5GUReUrQK7j7Hs4omJa0Bc7sR8UuCjSfR7Is2LoKrZy+8EyoqQtA4qpFMP8sfWMovqgVuTkoN7aabmIzSkNGIkBCFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804629; c=relaxed/simple;
	bh=LcPOw36suuF+LxeNDiUp1b0eBkMSmoFooFyJMxCh9F4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DWfnUMdg1NZI2cnXweJeLcq24w5zHKGHIOZUYTwTxm6otSaFDLMW+M62p2etp6kr4qlPzcxFXGnc5WdD+RUqWg+Oa7pe7Eoo1jMhyUTqIPZBTpZRny+pHQQr1BHDwKs32JrANgoy0X42LYptkXmN1u1A1ikoyzIJUcv/kQwT6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2sTokHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2sTokHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828D1F00898;
	Wed, 30 Sep 2026 21:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804627;
	bh=YftQHoQAyYBcPvla/2ZMouwzid1zAPrZIMxlv7Wz66o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V2sTokHFckaW4oHyDb8RBF0Cpp9b2fP0ExQbkGZWWTcd7THxFl9I+zVCVDem7/YUj
	 89TPuly4jzqd+UMGgxCO8ndZgyJ0wJB79PDUx38/eQEI0qmqZC6uv+bh6QFKqPLxvq
	 sWuS5GrEDKLiO6yL63Z+HkzBNTladmm7IHAGDaAZu2pplxAwNy666uzPTLEnuvInOS
	 zQyiOrYG1ZJ/DaG9SuSwTVJFJIaIuuxvshdlBcgB1Dqw48v4ChkRlZag5UylEXsQzt
	 iSaSTt96tD5ihPUP0LS4CIsdL4Lqd/YjB6KXoa6SOh/WcR+fYxGC8uNVptoQgdTjzg
	 I8cMG8/udVwsw==
Subject:
 Re: [PATCH net 1/2] netpoll: use a raw lock for the deferred transmit queue
From: netdev-bot+sashiko@kernel.org
To: kmehltretter@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 21:43:46 +0000
Message-ID: <179080462613.434549.13889756869054930420@kernel.org>
In-Reply-To: <20260928064239.32456-2-kmehltretter@gmail.com>
References: <20260928064239.32456-2-kmehltretter@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit, queue_process() in net/core/netpoll.c still calls
  HARD_TX_LOCK(dev, txq, smp_processor_id()) (line 169) right after…
- [Low] The patch adds a raw_spin_lock_irqsave(&npinfo->txq_lock) to
  every netpoll send, through netpoll_txq_empty()…

--

netpoll: use a raw lock for the deferred transmit queue

This patch adds a raw spinlock, txq_lock, to struct netpoll_info. All
accesses to npinfo->txq now go through small helpers that take this lock
and use the unlocked sk_buff_head operations, so the queue can be touched
with hard IRQs disabled on PREEMPT_RT. On cleanup, the queue is spliced
to a private list before its skbs are freed.

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index fe1e0cda5d6b..e0cfcb05468e 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -79,6 +79,68 @@ static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
>  	return status;
>  }
>  
> +/*
> + * Transmit paths can access txq with hard IRQs disabled. Use a raw lock
> + * because the skb queue lock may sleep on PREEMPT_RT.
> + */
> +static bool netpoll_txq_empty(struct netpoll_info *npinfo)
> +{
> +	unsigned long flags;
> +	bool empty;
> +
> +	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
> +	empty = skb_queue_empty(&npinfo->txq);
> +	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
> +
> +	return empty;
> +}

[Severity: Low]
Is this lock needed here? Before the patch, __netpoll_send_skb() checked
the queue without a lock:

    if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {

and the direct transmit fast path took no txq lock at all. With this
patch, every netpoll send takes txq_lock.

The empty check and the later netpoll_txq_queue_tail() are separate
critical sections, so the result of the check is only advisory in either
case. The writers (__skb_insert() and __skb_unlink()) already use
WRITE_ONCE().

Would skb_queue_empty_lockless() be enough here?

The new lock acquisition can also hang netconsole's atomic panic path.
Netconsole's write_atomic (CON_NBCON_ATOMIC_UNSAFE) is only called from
nbcon_atomic_flush_unsafe() at the end of vpanic(). That final flush
could spin forever on txq_lock in two cases:

  - the panic runs on a CPU that an NMI interrupted while it held
    txq_lock in netpoll_txq_dequeue(), netpoll_txq_queue_head() or
    netpoll_txq_queue_tail()

  - another CPU was NMI-stopped inside one of those critical sections,
    for example by crash_smp_send_stop() on x86 with
    crash_kexec_post_notifiers set and no kdump image loaded

In either case the panic log would not make it out over netconsole.

This does not block the panic_timeout reboot. In vpanic(),
emergency_restart() runs before nbcon_atomic_flush_unsafe(), so the hang
can only happen with panic_timeout == 0. The same atomic path already
takes other locks that are not NMI-safe: slab locks from
alloc_skb(GFP_ATOMIC), skb_dequeue() on nt->skb_pool, and driver locks
through netpoll_poll_dev().

[ ... ]

> @@ -107,7 +169,7 @@ static void queue_process(struct work_struct *work)
>  		HARD_TX_LOCK(dev, txq, smp_processor_id());
>  		if (netif_xmit_frozen_or_stopped(txq) ||
>  		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
> -			skb_queue_head(&npinfo->txq, skb);
> +			netpoll_txq_queue_head(npinfo, skb);
>  			HARD_TX_UNLOCK(dev, txq);
>  			local_irq_restore(flags);

[Severity: Low]
The commit message says:

    The delayed transmit worker has the same problem when it requeues a busy
    skb with skb_queue_head() after disabling interrupts.

Does the worker actually reach this requeue on PREEMPT_RT? queue_process()
calls local_irq_save() and then HARD_TX_LOCK() before the requeue. For
devices without lltx, that becomes:

queue_process()
  local_irq_save(flags)
  HARD_TX_LOCK(dev, txq, smp_processor_id())
    __netif_tx_lock()
      spin_lock(&txq->_xmit_lock)

On PREEMPT_RT this spin_lock() is rt_spin_lock() with IRQs disabled. So
the worker would seem to splat on the tx lock before it gets to
netpoll_txq_queue_head().

The next commit in the series, "netpoll: avoid blocking on the transmit
lock in queue_process", replaces HARD_TX_LOCK() with HARD_TX_TRYLOCK()
and requeues on failure. The final state of the series is fine, and this
patch is no worse than the baseline.

Could the commit message say that the worker hits HARD_TX_LOCK() first,
and that the follow-up patch fixes that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928064239.32456-1-kmehltretter%40gmail.com
