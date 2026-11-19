Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066704;
	b=lqfTHTu8/NdQj6KZLCMcGFXa5zcnrhAS8fizvfwyfP05njjyCZo2EQcJjmGj1CZXZO3K
	 qsHye+jTvF0IsKRGtVIwOjLQmX1AD0BztMpZWGyZG9IuL2bcjV7dKJFpiJnmP++Plh7hY
	 ECFiSdRmp0Ms6L0XXykTMalx2fE8ZESqUd3RdtLqVyoCKYCyHeoA+/AwJxhRtz/JWzxg9
	 pob+j07VFk+MBJb/HoodLXlqNbjf2JdZoo7oc0Uc2KeS+7EYfiY10VPeyI3ZDh4ds99TO
	 1cgqzwEDL0CkJcWJWa010LMRpRqixr9hLXhNrqfmeD7svZoXoDvN8cO/yF7oyU6NvWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066704;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R25rAJ2/bRQZbcpu1wkz5IDIm8PQU+pT8fh7Bl5TT58=;
	b=1RiKUj6dVmEwgoCEUfL6QXoCFcZ6t2Q2sfoSah/mA4XPnbVh6Nw/l/nXmhgsqWnP7hjm
	 7erc+JCG6wR/+ReTYabmI74U/lz8AY5zxSo5S/AAiNgtGllmTKcWYSQ2zc1KpdMBfum/h
	 OZobDT7W8SXdsBYQeaq4UBoOEUh1EJb5SfvNkdD53IwBBbVGP8PNybnXNLHsjs+9pE/mL
	 wRBeG8UnZS9YP7HzHmU/S0U87fVySFmfjNY5tF2tto0lfRDJHRgJGhF1jBe9PMDE9mo7S
	 lqR3vlkthbiHfNW52ajtg9NUBU+y/GGrnrRauNcyduYyQzF7PGs7V4zwJGRZz+lUsvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i4W2g/bn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54695606A32A;
	Thu, 19 Nov 2026 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i4W2g/bn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5606E1F000C5;
	Thu, 19 Nov 2026 05:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795066704;
	bh=R25rAJ2/bRQZbcpu1wkz5IDIm8PQU+pT8fh7Bl5TT58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i4W2g/bnjee/9TFtciHpyCgJ6WzfN3ADmdGr+DEjTUOdCKVANvuducRiqTgfRGH8n
	 Xbb6BnmbLv/tVcDh8VnIYC4xzlHZEFt2Umrq8zu5iPdHq7FipLqy9tkEFGN53H+2Tw
	 7HlR0RzBebzKPdqofjlL2fQy3e91zxMW+KhXK2o2hDLTbtZqDzBs+8AGcl+ubuMPNk
	 YgyatkydpG8g/Zn9rzvRVVhj559x+KtoxoaU5VGl7QaNBu14eNiSAxGz25TO/X7W7v
	 Ayd9rQCWyeg38KRUDYLUlH5rZCiW20TA9zDukwFAZ2lrlsNS+yyBMEyvjFu6/bVOaw
	 5N769JnXrzfkw==
Subject: Re: [PATCH net 1/2] net: keep txq->trans_start on repeated
 netif_tx_stop_queue()
From: netdev-bot+sashiko@kernel.org
To: cmcburney@telcobridges.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 willemb@google.com, toke@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 05:38:22 +0000
Message-ID: <179506670286.3136.15475785780493881467@kernel.org>
In-Reply-To: <20261116143716.367451-2-cmcburney@telcobridges.com>
References: <20261116143716.367451-2-cmcburney@telcobridges.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes netif_tx_stop_queue() skip the trans_start
  write when `test_bit(__QUEUE_STATE_DRV_XOFF)` reads the bit as set,…
- [Low] The new comment in netif_tx_stop_queue()
  (include/linux/netdevice.h) says trans_start is written "only ... on…

--

net: keep txq->trans_start on repeated netif_tx_stop_queue()

With this patch, netif_tx_stop_queue() writes txq->trans_start only when
__QUEUE_STATE_DRV_XOFF is not already set. e1000, e1000e, igb and igc stop
the queue again on every periodic hang check. Since commit 95ecba62e2fd,
each of those calls moved trans_start forward, so dev_watchdog() never
fired.

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 435be7880d7e5..6a488245db1ea 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3805,8 +3805,15 @@ static inline void netif_tx_wake_all_queues(struct net_device *dev)
>  
>  static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_queue)
>  {
> -	/* Paired with READ_ONCE() from dev_watchdog() */
> -	WRITE_ONCE(dev_queue->trans_start, jiffies);
> +	/* Only write trans_start on the initial state transition
> +	 * (when the DRV_XOFF bit changes from 0 to 1).
> +	 * This prevents recursive driver watchdog polls from continuously
> +	 * resetting the timeout timeline and blinding dev_watchdog().

[Severity: Low]
Is this comment accurate? The code below it calls test_bit() and then a
separate set_bit() after smp_mb__before_atomic(). Because of that, DRV_XOFF
can really go from 0 to 1 at set_bit() without any trans_start write.

That happens if netif_tx_wake_queue() clears the bit between the two:

net/core/dev.c:netif_tx_wake_queue() {
	if (test_and_clear_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state)) {
	...
}

In that case set_bit() in netif_tx_stop_queue() makes the 0 to 1
transition, but the WRITE_ONCE() was already skipped.

The changelog describes this race. The comment, though, says the timestamp
follows every 0 to 1 transition. Readers of dev_watchdog() and
netif_xmit_timeout_ms() could take that at face value. Could the comment
mention the race?

Also, the repeated hang check stops are periodic, not recursive. Would
"repeated" be a better word than "recursive" here?

> +	 *
> +	 * Paired with READ_ONCE() from dev_watchdog()
> +	 */
> +	if (!test_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state))
> +		WRITE_ONCE(dev_queue->trans_start, jiffies);

[Severity: Medium]
Can this leave a newly stopped queue with a stale trans_start, and lead to
a spurious "NETDEV WATCHDOG" timeout?

Take a queue that has been DRV_XOFF since T0:

CPU A                                  CPU B
netif_tx_stop_queue()
  test_bit(DRV_XOFF) == true
  (trans_start write skipped)
                                       netif_tx_wake_queue()
                                         test_and_clear_bit(DRV_XOFF)
  smp_mb__before_atomic()
  set_bit(DRV_XOFF)

The queue is now held by a new stop, but trans_start is still T0.

If nothing is transmitted between the wake and the re-stop,
txq_trans_cond_update() does not run. dev_watchdog() then sees
netif_xmit_stopped() and checks:

net/sched/sch_generic.c:dev_watchdog() {
	...
	trans_start = READ_ONCE(txq->trans_start);
	...
	if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {
	...
}

This can call ndo_tx_timeout() and reset the adapter, even though the
current stop is much shorter than watchdog_timeo.

T0 can be quite old. netif_device_detach() stops all queues at suspend
time, and netif_device_attach() wakes them without refreshing trans_start:

net/core/dev.c:netif_device_attach() {
	if (!test_and_set_bit(__LINK_STATE_PRESENT, &dev->state) &&
	    netif_running(dev)) {
		netif_tx_wake_all_queues(dev);
		netdev_watchdog_up(dev);
	}
}

Suppose a stop of an already stopped queue races with this wake, for
example from a driver hang check. The queue stays stopped with a timestamp
from before the suspend, just as the watchdog is armed.

The window has no fixed limit either. Drivers call
netif_tx_stop_all_queues() from preemptible process context (ndo_stop,
reset, ring reconfiguration) without the tx lock. Preemption or an
interrupt between test_bit() and set_bit() can make the window longer.

dev_activate() does not have this problem, because transition_one_qdisc()
writes trans_start for each tx queue.

The changelog says:

    A timeout is then reported only if both stops together last longer than
    watchdog_timeo.

Does that hold only when the wake and the re-stop come back to back?
Otherwise, the interval that dev_watchdog() measures also includes the time
the queue was running.

Before this patch, every stop wrote jiffies before set_bit(), so a queue
seen as stopped always had a current timestamp. The KUnit test patch later
in the series does not change netif_tx_stop_queue(), so the window is still
there at the end of the series.

Would any of these work instead: rewriting trans_start when an atomic RMW
on DRV_XOFF shows the bit was actually clear, keeping a separate "stopped
since" timestamp, or refreshing trans_start in the wake path?

>  
>  	/* This barrier is paired with smp_mb() from dev_watchdog() */
>  	smp_mb__before_atomic();

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116143716.367451-1-cmcburney%40telcobridges.com
