Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D83793D0;
	Sat, 17 Oct 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198847; cv=none; b=rDkActvzfEQfbV9iCHA9rOrwbZJ/pqhVx1IY1mvCKZdnvRWBXKhKigR9zFn83MMk12KCWc86xN9TBajl6DazDkDfX1umdSWi3D52yT28T6tVXaqiRIx/7OhPQMYX9Gkv1husrxA6P2zhQXM1M7ZbFcQFhAk3dJKkfdsjoAQgY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198847; c=relaxed/simple;
	bh=1pTJR/NPztZbKjTlHhU4kn7kpr5kW3+cwbwJPBk56S4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2024ohCExNc+it4qxQrdxV7AQrTCOuOEP5NMAtX5TqsYCq1d+JprFH8KrWQi7pCNsNe6btgCl4A7BnDNcIEv+CUOIxxeCCWJVz71ASX4TEKysizCliYtTeX0HVcIhD+O7uncAAemsOARJwXiQ/JgE0ZTlnpvD6RXAkhVy+JMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sggz42U+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sggz42U+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77801F000C4;
	Sat, 17 Oct 2026 01:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198845;
	bh=S4QWG8iL9mfl/dhfo2RsR4M7cwNDRqdBeBp9keTXYPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sggz42U+vvkvhddKw1jnhpFRzpbHV5ovSzaKRxOPwG2B3o/+mk3l5Z+PxKbE0Dp2E
	 UTkXifp811PubD9ZlmQ2OgS3SDUPhjHfZwJrD5Ed5qrW5kKPW51wI4E3jaRCBZ9rCR
	 HTjpFfEKFKpFxMRMkssI4+uCEegoibs3qUC0BPw5VBxt3iHHxzUlnD/k2JnlzlG6vc
	 vVzw+cwyDaUSa+wRhcWzVL5ukGoGNO8LveVrkb5na3T6NBxyneFr6Juf1l0+L4FbEb
	 AAsjkq0qpQYXbpruOze+Vu2z7+dGUsf4a50t3ZBz+d2S4eyABJG+ps21XVYxRbgIlV
	 LVX1roSf9+66w==
Subject: Re: [PATCH net v5 5/6] can: rockchip_canfd: serialize TX with bus-off
 and restart
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 17 Oct 2026 01:00:44 +0000
Message-ID: <179219884425.1406898.18319979032484933416@kernel.org>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-5-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-5-ae77327037c9@qq.com>
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

- [Low] This patch takes spin_lock_irqsave(&priv->tx_lock, flags) near
  the top of rkcanfd_start_xmit()…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rkcanfd_start_xmit() does not handle a can_put_echo_skb() failure.

--

can: rockchip_canfd: serialize TX with bus-off and restart

This adds a private tx_lock and tx_enabled flag. They serialize
rkcanfd_start_xmit() and the RX-side echo completion and retry against
bus-off handling and CAN restart. TX is disabled before CAN_STATE_BUS_OFF
is published, and carrier, TX, IRQs and the queue are re-enabled together
under the lock after the controller has been reinitialized.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> index 12200dcfd3389..f49ed6d2266d9 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -69,12 +69,19 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)

[ ... ]

>  	if (can_dev_dropped_skb(ndev, skb))
>  		return NETDEV_TX_OK;
>  
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	if (unlikely(!priv->tx_enabled)) {
> +		netif_stop_queue(ndev);
> +		goto out_busy;
> +	}
> +

[Severity: Low]
This lock stays held with hard IRQs disabled until the end of
rkcanfd_start_xmit(). The locked region includes the echo skb handling:

drivers/net/can/rockchip/rockchip_canfd-tx.c:rkcanfd_start_xmit() {
    ...
	frame_len = can_skb_get_frame_len(skb);
	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
	if (!err)
		netdev_sent_queue(priv->ndev, frame_len);
    ...
}

can_put_echo_skb()->can_create_echo_skb() clones the skb and then calls
consume_skb() on the original. If the clone fails, it calls kfree_skb()
instead. can_put_echo_skb() also calls kfree_skb() in three cases: IFF_ECHO
is clear, the protocol check fails, or the echo slot is still occupied.

Freeing the original skb runs the socket destructor (sock_wfree()). If this
is the last TX skb of a closed socket, that can continue into __sk_free().

The comment above dev_kfree_skb_irq() in include/linux/netdevice.h says
kfree_skb() and consume_skb() must not be called with hardware interrupts
disabled. Before this patch, ndo_start_xmit() ran with only BH disabled.

Nothing seems to fail visibly today. skb_release_head_state() only warns
on in_hardirq(), not on irqs_disabled(), and peak_canfd uses a similar
pattern. Even so, should the clone and the free of the original skb happen
outside tx_lock, with only the echo slot pointer and tx_head published
under the lock?

[ ... ]

> @@ -137,7 +144,14 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  				  RKCANFD_TX_STOP_THRESHOLD,
>  				  RKCANFD_TX_START_THRESHOLD);
>  
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +
>  	return NETDEV_TX_OK;

[Severity: Medium]
This is a pre-existing issue that this patch did not introduce. What
happens when can_put_echo_skb() fails earlier in this function?

If the GFP_ATOMIC clone in can_create_echo_skb() fails, can_put_echo_skb()
frees the original skb and returns -ENOMEM. That leaves
priv->can.echo_skb[tx_head] set to NULL. In that case rkcanfd_start_xmit()
only skips netdev_sent_queue():

	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
	if (!err)
		netdev_sent_queue(priv->ndev, frame_len);

	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);

	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);

When the self-received frame comes back, rkcanfd_handle_rx_int_one() sees
tx_pending != 0 and calls rkcanfd_rxstx_filter(). That function then hits
the NULL slot:

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_rxstx_filter() {
    ...
	skb = priv->can.echo_skb[tx_tail];
	if (!skb) {
		netdev_err(priv->ndev, ...);

		return -ENOMSG;
	}
    ...
}

tx_tail never advances, because the only normal advance happens after a
successful echo match. rkcanfd_handle_rx_int() also stops draining the
FIFO when it gets the error.

After that, does every RX IRQ consume and drop one FIFO entry with another
-ENOMSG? TX would then stall once the ring is full, until a bus-off
restart or an interface down/up reinitializes the controller.

This patch keeps the same error propagation in rkcanfd_handle_rx_int_one().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9%40qq.com
