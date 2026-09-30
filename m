Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC4522F17;
	Wed, 30 Sep 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804630; cv=none; b=FDLNLfZawU1VmnP8PEdymOjMgmU1nntqBsNJl/jqlpoeOJVxc/M6D8bLVaTdGviLiGqo+Te/313EJaUkFHzkqG6J/cLuXNA6IDYJ+5qdra+Fsi1O9XQJmBKqv85cjJrgeSy38c0BLsMxvnKEaU8xfj6clCf+e8GICQnn9J7Vk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804630; c=relaxed/simple;
	bh=wPyhWcrM0uuOBjAQDrcDVwA0qDOFM59sMf05oEBZi/Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQEqkH/oQ7eefuPb9SwYtRMbCuTHEnJdY/fKV+AgIwACsnrWcldv6aydI2AXi5UEj3mE3x8KWYCS9pDAt3agkMHlQAAbItCSdLbN8FFmqA8HVpWrjTfaRnqu/CoNH4WzyJWqgkoCYYbPRFdarLtrZJDX/xO0Hioq/hMJYyG06H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP0a9pAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP0a9pAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34EE1F000FF;
	Wed, 30 Sep 2026 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804628;
	bh=Lfh3oRoEkMv5tTvUrjMf1DhZrS8JjM0GkDJ+tT37dFA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AP0a9pAMTaqM1UhaL+ysCyXXjR7f0TtX5/5PDeX61zDShdZQgN6B4HbB8URIbhvCB
	 iwBDMR0RQi7V+EarDFOhyfZdEvrI1/OIO+VRB3OKvs/us8zln45qgyosrPdwtVWf+S
	 Ez7XdFVFl1slSRIyOVHhBACP5jQ3qv0sUarZBFEub8C1RDywzS2opSU1UBVEsbNmht
	 4tXiVOsAbBGdiuMykCYUaGfBSsOsN9yRu36JOef8jPQ9UVxcrnAWDo8x/2PXigUB2w
	 VAKps1YyZctAGoDU69ihPqmIa1wqL+j154iDGiKTojSW4LwOnlwzGf2VcJYGFElP1J
	 cDYyjZGmZaHaA==
Subject: Re: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in
 queue_process
From: netdev-bot+sashiko@kernel.org
To: kmehltretter@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
Date: Wed, 30 Sep 2026 21:43:47 +0000
Message-ID: <179080462753.434549.2732454412343201890@kernel.org>
In-Reply-To: <20260928064239.32456-3-kmehltretter@gmail.com>
References: <20260928064239.32456-3-kmehltretter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On PREEMPT_RT the patch does not fix the bug it claims to fix.
- [High] net: severe latency in netpoll queue_process on lock contention

--

netpoll: avoid blocking on the transmit lock in queue_process

This patch replaces HARD_TX_LOCK() with HARD_TX_TRYLOCK() in
queue_process() to avoid a sleeping function called from invalid context
splat on PREEMPT_RT. If the transmit lock is contended, the skb is put back
at the head of the deferred queue and the work is rescheduled after
HZ / 10.

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index e0cfcb05468e..a3c94f0b3f76 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
>  			skb_set_queue_mapping(skb, q_index);
>  		}
>  		txq = netdev_get_tx_queue(dev, q_index);
> -		HARD_TX_LOCK(dev, txq, smp_processor_id());
> +		if (!HARD_TX_TRYLOCK(dev, txq)) {
> +			netpoll_txq_queue_head(npinfo, skb);
> +			local_irq_restore(flags);
> +
> +			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
> +			return;
> +		}
>  		if (netif_xmit_frozen_or_stopped(txq) ||
>  		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {

[Severity: High]
Is HZ / 10 the right backoff for a failed trylock?

The existing HZ/10 retry further down covers a frozen or stopped queue,
or a driver returning NETDEV_TX_BUSY. That usually means the ring is
full and will take some time to drain.

A failed HARD_TX_TRYLOCK() here means something much smaller: another
CPU is inside ndo_start_xmit() on the same txq. That lock is normally
held for only a few microseconds.

With this change, every time queue_process() races with regular
traffic on that queue, the deferred skb waits 100ms. So does everything
queued behind it in npinfo->txq.

__netpoll_send_skb() only transmits directly when npinfo->txq is empty.
That means new netconsole messages keep being appended to the deferred
queue for the whole backoff as well.

On a busy interface this can cut netconsole down to a handful of
packets per second per queue. The deferred queue keeps growing and
console output falls further and further behind. Anything still sitting
in npinfo->txq when the machine hangs is never sent, and those are
exactly the messages netconsole users care about most.

This also changes behaviour on !PREEMPT_RT kernels. There,
HARD_TX_LOCK() was not a problem and simply waited out the short
critical section.

Could the retry on trylock failure be much shorter, for example a delay
of 0 or 1 jiffy? Alternatively, would it be better to avoid the trylock
altogether by not running this path with hard IRQs disabled, so the
normal tx lock can be taken?

[Severity: High]
Does this fully fix the PREEMPT_RT splat described in the commit message?

The earlier local_irq_save(flags) in queue_process() is unchanged. That
means hard IRQs are still disabled when the driver's ndo_start_xmit() runs
after a successful trylock:

queue_process()
  local_irq_save(flags);
  HARD_TX_TRYLOCK(dev, txq)
  netpoll_start_xmit()
    netdev_start_xmit()
      ndo_start_xmit()

Several non-lltx drivers take a spinlock_t in their xmit path. On
PREEMPT_RT a spinlock_t is an rtmutex. For example:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_xmit() {
    ...
	spin_lock(&ring->lock);
    ...
}

rtl8139_start_xmit() takes spin_lock_irqsave(&tp->lock, flags), and
macb_start_xmit() takes spin_lock_irqsave(&queue->tx_ptr_lock, flags).
HARD_TX_TRYLOCK() takes no core lock for lltx drivers, and those drivers do
their own spinlock_t locking, so they have the same problem.

On PREEMPT_RT, rt_spin_lock()->__rt_spin_lock() calls
rtlock_might_resched(), and __might_resched() prints "BUG: sleeping
function called from invalid context" whenever irqs_disabled() is true.
Won't the same splat still fire, just one frame deeper?

  rt_spin_lock
  bcmgenet_xmit
  netpoll_start_xmit
  queue_process

If the driver lock is contended, for example by threaded NAPI TX reclaim on
RT, rtlock_slowlock() can actually block while hard IRQs are disabled.

The trylock only seems to silence the txq lock case, because
__rt_spin_trylock() skips rtlock_might_resched(). The sibling path
__netpoll_send_skb() already uses HARD_TX_TRYLOCK() under local_irq_save(),
and it still runs driver xmit and netpoll_poll_dev() with IRQs disabled.

Documentation/networking/netdevices.rst says ndo_start_xmit "will be called
with interrupts disabled by netconsole". On RT, that conflicts with drivers
that use a plain spinlock_t in xmit.

queue_process() runs from a workqueue in process context. Would it be
better to stop disabling hard IRQs here instead of changing the lock
primitive? For example, it could use local_bh_disable() plus the normal tx
lock, as the regular xmit path does.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928064239.32456-1-kmehltretter%40gmail.com
