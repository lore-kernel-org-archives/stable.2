Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522727;
	b=rg0MiC8JIqPyAeE8QdM/Zf2hsd24lvP2K53DPQ/Ljh2WJu6YBGNJddV8YV7uw/lTCMW2
	 cVb9QbmaMeBBDyBL2jkY5u/IxGSCYNmXjYuMQ0DNdMXw0IAGp0BUsokn8Atgg/HOyM+Kn
	 URnSOGOJpdPd8u9UDk1zViwganrQ448XRLHoo7mm+VPqa5fuaFU9q2tHWpbm1xaXv6g2f
	 lEP92VqSY/KUcX2kg0OTASbBxWfeQ0iH90KT+DKQQcoElj4Hrm3AAEinAq9/cr3rO8kvT
	 TLsjqGzCDscBsrKKyJCqS9B1VO9PZrzOH+//4Jf9Y94K4gKakWD/bxKG67hRjonV/3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522727;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FnKwjWoPH+aBZ+Vqr2z+nXlMKyFxL9fotAh/0RuRiL8=;
	b=uX+4lVgyusYDGtf9LT+YtyWZdyw+h3cgNn8WEWpTYpXISYzpYXsA+oxoe9TskuNCsV+O
	 8qMW7srxk85gAL+BP3qzSfWRqS/el14m1yFK2gwXi83x5pyGwhOc9GPcklNsGkPkth/fe
	 rU9opYml14V/9ourzrvbiIsGw3MpuFOXlJSQuBi7S8KwepK+MSNtpBxeJWq5CYBOZCB7n
	 wrCwNfOmHOWbQR3FxZW81mJ4WlwUQP0O1ytP4pPUnWc//AAY/61sdKUOiPthJrhygrU+Y
	 MTJb6YpGCfPVm/12Lox/hELUgimnL1GoedyBbgUHgHi9yHOkboqAzP75QAzCanJvpXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ku09BI/e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E6606A887;
	Thu, 12 Nov 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ku09BI/e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBB21F000C5;
	Thu, 12 Nov 2026 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522727;
	bh=FnKwjWoPH+aBZ+Vqr2z+nXlMKyFxL9fotAh/0RuRiL8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ku09BI/eyf5/4gS0ojO5Fg6F7AfCgiDpTOgR9wpaDZfwcZbV7Wg5OEDk0af+tAutO
	 Ui7w7ozndnXJ0fgWidzs46IT67MyD57dmujEKGGhqzclAcvxd3iRXPV+ABdBBa/Dgp
	 CRd2qfic1QHiVB9seLYQpFACMFAmZRhHBjuLWf3JIU8fIvXCDiR/HUnrURtfUHAVaK
	 M8IY9O1gXEVaQoTDPFduEGPATl+gp6y1s+mtu8r+Kyi5vmPVLL1BHCn81yxF42emUQ
	 iqAjcNR7iUX2Nfn9yNrJfAj0sdPRYUAGSMsOyw/2VUj6c4ZOp+Blo3vRKGeSKePFYy
	 3SHEQbNlwMq8A==
Subject: Re: [PATCH net v9 02/10] can: rockchip_canfd: serialize TX state and
 command writes
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, kernel@pengutronix.de, mailhol@kernel.org,
 heiko@sntech.de, socketcan@hartkopp.net, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 wg@grandegger.com, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 22:32:06 +0000
Message-ID: <179452272605.488853.7766222371781076513@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-2-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-2-6643f3825ba3@qq.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message carries Cc: stable and makes the backport
  depend on three other fixes, but only describes them loosely and never…

--

can: rockchip_canfd: serialize TX state and command writes

This patch adds a tx_lock spinlock to struct rkcanfd_priv. The lock
serializes rkcanfd_start_xmit() against RX-side echo completion and the
erratum 12 retry path. It covers the TX free-space checks, echo handling,
head/tail updates, BQL accounting and the MODE/CMD/MODE command sequence.
The retained original skb is now released after the lock is dropped.

> Release the original skb retained by the preceding echo-failure fix after
> unlocking and restoring IRQs, so its socket destructor cannot run under
> tx_lock. Backports need that retained-reference handling and the CAN skb
> ownership fix, or equivalent handling.

[Severity: Low]
This isn't a bug, but since the patch carries Cc: stable and depends on
other fixes for backports, could those fixes be named by subject (and by
hash where the hash is stable)?

The "preceding echo-failure fix" looks like the previous patch in this
series:

  can: rockchip_canfd: prevent TX stall on echo skb failure

The "CAN skb ownership fix" looks like:

  b4ebcbbf66ba ("can: dev: can_put_echo_skb(): free skb on invalid echo index")

The skb_get() passed to can_put_echo_skb() in rkcanfd_start_xmit(),
together with the dev_consume_skb_any() / dev_kfree_skb_any() calls after
the unlock, only balances if can_put_echo_skb() also frees the passed
reference on the -EINVAL path. That makes b4ebcbbf66ba a hard
prerequisite for any backport.

> This lock covers running TX, completion and retry. Synchronization with
> bus-off and controller reinitialization is provided by the later
> lifecycle fix.

Which patch is "the later lifecycle fix"? It appears to be "can:
rockchip_canfd: serialize TX with bus-off and restart" later in this
series.

At this commit, rkcanfd_chip_fifo_setup(), reached via
rkcanfd_set_mode(CAN_MODE_START) -> rkcanfd_chip_start(), still resets
the TX ring and BQL state without tx_lock:

drivers/net/can/rockchip/rockchip_canfd-core.c:rkcanfd_chip_fifo_setup() {
    ...
	WRITE_ONCE(priv->tx_head, 0);
	WRITE_ONCE(priv->tx_tail, 0);
	netdev_reset_queue(priv->ndev);
}

The chip stop / can_bus_off() handling in rkcanfd_handle_state_error_int()
also runs outside the lock.

Could the follow-up be named explicitly, so a stable backport of this
patch also picks up the change that closes that window?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
