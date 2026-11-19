Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795066705;
	b=eMUtahrUKd36x7K/nYzg/sU5T1lw27c5XxEzZvOj+KT/1vxdJ1Prj9UO5z99pZj+Zlpn
	 Sv+00Q9bM25hKdcwdhAs/fngercDeDjw53Gq5SjNWqUbSABq4RH3akpVU78HSL17lC3k+
	 38mMh9Zz588os2nio//ZQ0Fi3ln6YEkyk9J4pX51+4tK4VKtZGzqNrrxGhh8J0y3Oi9OF
	 jqFeIBaBGyNpfdeLQQzCuYM4DYsg0np+xbxKyBWU1Aj+T71r4Wsi92fryL4rnrak2zyUA
	 uug96KPpWapzrN5XUrpaEJX/0IquqdwAeS4wY8hA47BdyA+0o4N/OpcAc9UxwVfuqTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066705;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I6OBaNpH54Z8ktG2Qr+KnHkPf9hCrWPCQPiLHt0LY5E=;
	b=fp1YE0oOdqq6W3jRaXPg2udVk5BrttcUoi3TH8clQTiI+t3NNhi2Y0/vfw/5HlT9V0Pq
	 +BcL9TLoWgEWaQ2qr4Lx2zbVydBGipVObEMpdXSiGsHdo6zymTugrZnRI/tL1MTJVspB0
	 BSW0+fHUMm/mhaKQncFytu4GZlAy9lHw4VlC/9iH0WmaoYsnrIW6sO8jwy59hzJP17vhe
	 06ird9yh84hHwkBogX8WqqwW77ZeQ6+GLzAVFpt+51BfCEA13jO441F77WkWSEdRRfkRE
	 NP8jcc++JVV2GL4dQIgp81sNaGGFGQh019WcbRGkqdGxQnB1zEkWJ8ARJrDSFW/JDjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZo3LM+H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4691B606A6DC;
	Thu, 19 Nov 2026 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AZo3LM+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8956F1F000C4;
	Thu, 19 Nov 2026 05:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795066705;
	bh=I6OBaNpH54Z8ktG2Qr+KnHkPf9hCrWPCQPiLHt0LY5E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AZo3LM+HEufsnoEHwNocu1sUXZgqT5K95t2o5S05PlUJoiQWxERuf7H4IRhXyoEhz
	 kr40LnZdMwkeUO4jlC6eC2D0UIDklFSmb7Y/bDqnW+B6s80i0vvxOQ+f4BZ1YxKO2A
	 wrEUt1d/4R6dvJRoXaQ1c97IYK2HcJXOzj/fILTSSaS/u7LlGT37X3vEVJnxIPASg0
	 TA8FbRSNYjnGELvvaw0NUOe5oCavGM5wVXB5+nZmADgKNTQRcDdHDj0WYu55lLAkri
	 PH24v5MJLijur/Qqw4aOaKJJXfDk129H7sTMEdFEcU8L066VwIWa6c8+hxw01if3Ho
	 lcUXbNWlDsK3A==
Subject: Re: [PATCH net 2/2] net: net_test: add tests for
 netif_tx_stop_queue() trans_start
From: netdev-bot+sashiko@kernel.org
To: cmcburney@telcobridges.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 willemb@google.com, toke@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 19 Nov 2026 05:38:24 +0000
Message-ID: <179506670414.3136.7943679597590478564@kernel.org>
In-Reply-To: <20261116143716.367451-3-cmcburney@telcobridges.com>
References: <20261116143716.367451-3-cmcburney@telcobridges.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patchset changes netif_tx_stop_queue()
  (include/linux/netdevice.h:3814-3821) so that it decides whether to…

--

net: net_test: add tests for netif_tx_stop_queue() trans_start

This adds four KUnit cases to net/core/net_test.c. They check how
netif_tx_stop_queue() updates txq->trans_start on a running queue, a
queue already stopped by the driver, a restarted queue and a queue
stopped only by BQL. They cover the previous patch, which skips the
trans_start write when __QUEUE_STATE_DRV_XOFF is already set.

> diff --git a/net/core/net_test.c b/net/core/net_test.c
> index 2b5080c226636..c69d34d0e2306 100644
> --- a/net/core/net_test.c
> +++ b/net/core/net_test.c

[ ... ]

> +/* A stop on a queue that is already stopped keeps the first stop time, so
> + * repeated stops from a driver hang check do not postpone dev_watchdog()
> + */
> +static void txq_stop_keeps_stamp_stopped_queue(struct kunit *test)
> +{
> +	struct netdev_queue *txq = txq_test_alloc(test);
> +	unsigned long old, stamp;
> +
> +	netif_tx_stop_queue(txq);
> +	old = jiffies - TXQ_TEST_OLD_DELTA;
> +	WRITE_ONCE(txq->trans_start, old);
> +	netif_tx_stop_queue(txq);
> +	stamp = READ_ONCE(txq->trans_start);

[Severity: Medium]
This test treats the check-then-set behaviour added to
netif_tx_stop_queue() by the previous patch as the intended contract.
Is that behaviour safe when netif_tx_wake_queue() runs at the same time?

include/linux/netdevice.h:netif_tx_stop_queue() {
	if (!test_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state))
		WRITE_ONCE(dev_queue->trans_start, jiffies);

	/* This barrier is paired with smp_mb() from dev_watchdog() */
	smp_mb__before_atomic();

	/* Must be an atomic op see netif_txq_try_stop() */
	set_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state);
}

The test_bit() and the set_bit() do not happen as one atomic step.
Suppose TX completion clears the bit locklessly between them. The
set_bit() is then a real 0->1 transition, but trans_start still holds
the stamp from the earlier stop:

CPU1 (queue stopped, trans_start == T0)  CPU2
netif_tx_stop_queue()
  test_bit(DRV_XOFF) == 1
  (trans_start not written)
                                         netif_tx_wake_queue()
                                           test_and_clear_bit(DRV_XOFF)
                                         (queue idle, no
                                          txq_trans_update())
  set_bit(DRV_XOFF)

After that, dev_watchdog() sees a stopped queue with trans_start == T0:

	trans_start = READ_ONCE(txq->trans_start);

	if (time_after(jiffies, trans_start + dev->watchdog_timeo)) {

Can this report a NETDEV WATCHDOG timeout and call ndo_tx_timeout()
right after the queue was stopped again? Before the previous patch, the
stamp was always written before set_bit(). So a stop could never leave
the queue stopped with an old stamp.

The previous commit says "A timeout is then reported only if both stops
together last longer than watchdog_timeo". Does that still hold when
the caller can be preempted?

For example, e1000_print_hw_hang() runs from the print_hang_task work
item. It can call netif_stop_queue() on a queue that is already
stopped:

drivers/net/ethernet/intel/e1000e/netdev.c:e1000_print_hw_hang() {
	...
	/* Real hang detected */
	netif_stop_queue(netdev);
	...
}

If it is preempted after test_bit(), the queue can be woken and then
sit idle for any length of time. That running time also counts
against watchdog_timeo.

These tests all run on a single thread, so they can't catch this
window.

> +
> +	KUNIT_EXPECT_TRUE(test, netif_tx_queue_stopped(txq));
> +	KUNIT_EXPECT_EQ_MSG(test, stamp, old,
> +			    "second stop moved trans_start forward by %lu jiffies",
> +			    stamp - old);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116143716.367451-1-cmcburney%40telcobridges.com
