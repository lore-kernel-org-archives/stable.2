Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3E37882A;
	Fri, 16 Oct 2026 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126953; cv=none; b=FMiGvhOX7hUhXWVZQsqKyxnlxuT47gQiJ1sKSrA0XQkgwzb8sze6miNo34I+UJ4PN3YIAYYpbV5IDMvwy/3/3E8LbT/uD0KniNzCPFvwuhmoUYgV9xs/aECxeFM/ALIGUDqk2sM5gIJo1GsggvCkOZhnpxudThMyCQfF6sX/cxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126953; c=relaxed/simple;
	bh=EdBHtYoT3bskqL+4TVYpHdPCzx/P/dNUD/KdVfgSxSw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiAdFIsq+b643Nx4DXMlVZZ8+pt43k4aFW5gHqceCZOzTCrXwQKLV3mH1nVc3NXNoJ94nlXgWiySsnCc7aP/dlLpyxgd3830WY1EsXNpumLweN1APtwNDnpDnJ/CXxXgIrUcGEIZENbmri2ICtOB+jesWPE2BDJZKpgfWcBYW+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hs9aKHWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hs9aKHWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0B31F000C5;
	Fri, 16 Oct 2026 05:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792126951;
	bh=AXD0X55j0+mLl3LvU7mmvkCjUiu2iUcNrhBRLq1hV9w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hs9aKHWJl9ZFzcWdWXF6c1vUHP+Ra6GdmNAvXusfejGPyrmTns56dekKAGl8XVD/V
	 IlSyOl8RPNx7S71A9Oj98523FEfAvRYyAau7C7oxRpa8WGzYUowCW8UHW/mbsWxKth
	 pWOrr7jsuwdDDLz7yc9mgMEvNLNkJGj+qk4ggDbSMEsTXeSrQKdcaWDnr+lFLhBGeb
	 +xNeTyhRHhso4V4dqk9LMZtE+9LYIUYAaMz+3STCM0+j/Oc9opaUibeYylZwSJRyke
	 60g/CIjikOWOql/iTDvNtU0M9lOupFZTkxR5Yt0Xh4kj4hTPEipiMXF9VJrb25igCr
	 kpeTO/r3GEaXw==
Subject: Re: [PATCH net v3 5/5] can: rockchip_canfd: serialize TX with bus-off
 and restart
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 05:02:30 +0000
Message-ID: <179212695059.1406898.2819339363166493325@kernel.org>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v3-5-f0eb41090242@qq.com>
References: <20261014-rockchip-canfd-restart-close-v3-5-f0eb41090242@qq.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new tx_enabled gate in rkcanfd_handle_rx_int_one()
  (drivers/net/can/rockchip/rockchip_canfd-rx.c) changes how self-…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but CAN XL frames
  are accepted on this non-XL controller and are then parsed as CAN/CAN…

--

can: rockchip_canfd: serialize TX with bus-off and restart

This patch adds a private tx_lock and a tx_enabled flag to the
rockchip_canfd driver. The lock is held across the whole ndo_start_xmit()
submission, and the gate is closed before bus-off is published or the
controller is reset. The same gate covers TX completion and the erratum 6
retry on the RX side, and open/restart now enable TX, IRQ handling,
interrupts and the queue in a single critical section.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
> index 24e87daa1df0..9b357bb8fc70 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c

[ ... ]

> @@ -237,15 +240,18 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
>  		return 0;
>  	}
>  
> -	if (rkcanfd_get_tx_pending(priv)) {
> -		bool tx_done = false;
> -
> +	/* Do not consume echo SKBs, retry TX or wake the queue after bus-off
> +	 * has handed ownership of the echo ring to the CAN restart path.
> +	 */
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	err = 0;
> +	if (priv->tx_enabled && rkcanfd_get_tx_pending(priv))
>  		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
> -		if (err)
> -			return err;
> -		if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
> -			return 0;
> -	}
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +	if (err)
> +		return err;
> +	if (tx_done && !(priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK))
> +		return 0;

[Severity: Medium]
What happens to self-received copies of our own TX frames while
tx_enabled is false?

rkcanfd_chip_start() always sets RKCANFD_REG_MODE_RXSTX_MODE, so the
controller loops every transmitted frame back into the RX FIFO. With the
gate closed, rkcanfd_rxstx_filter() is skipped and tx_done stays false. The
copy then takes the normal RX path:

    if (priv->bec.rxerr)
        priv->bec.rxerr = min(CAN_ERROR_PASSIVE_THRESHOLD,
                              priv->bec.rxerr) - 1;
    ...
    err = can_rx_offload_queue_timestamp(&priv->offload, skb, header->ts);

The stack then sees it as a frame from another node. It also reaches
sockets that have recv_own_msgs disabled. Its echo SKB is never completed,
and can_flush_echo_skb() in close_candev() drops it later, even though the
frame did go out on the bus.

rkcanfd_stop() now closes the gate before it masks interrupts and frees
the IRQ:

    close_candev_cancel_restart_sync(ndev);
    rkcanfd_tx_disable(priv);

    rkcanfd_chip_interrupts_disable(priv);
    free_irq(ndev->irq, priv);
    can_rx_offload_disable(&priv->offload);
    rkcanfd_chip_stop_sync(priv, CAN_STATE_STOPPED);

The controller stays in WORK_MODE with RXSTX until rkcanfd_chip_stop_sync()
runs. Frames already in the hardware TX FIFO can still go out and loop back
in that window.

rkcanfd_irq() only checks irq_suspended and the software mask, and
irq_suspended is still false here. A handler already looping in
rkcanfd_handle_rx_int() on another CPU could therefore pass these copies
upstream.

Before this patch, rkcanfd_stop() only called netif_stop_queue(). The
filter still matched these frames and completed them as TX.

There seems to be a similar but narrower window after bus-off. It runs from
rkcanfd_tx_disable() in rkcanfd_handle_state_error_int() until set_mode()
sets irq_suspended.

Two comments also look out of date now. The erratum 6 comment in
rockchip_canfd.h says:

    * Work around this issue by activating self reception (RXSTX). If we
    * have pending TX CAN frames, check all RX'ed CAN frames in
    * rkcanfd_rxstx_filter().

The comment in rkcanfd_get_berr_counter_corrected() says RXSTX does not
affect the RX error counters:

    * Luckily the controller doesn't decrement the RX CAN bus
    * error counter in hardware for self received TX'ed CAN
    * frames (RKCANFD_REG_MODE_RXSTX_MODE), so RXSTX doesn't
    * interfere with proper RX CAN bus error counters.

The commit message only says that RX will not "consume echo SKBs" after
bus-off. It does not mention that these frames are now delivered as RX
traffic from another node.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> index 12200dcfd338..f49ed6d2266d 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -69,12 +69,19 @@ netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	u32 reg_frameinfo, reg_id, reg_cmd;
>  	unsigned int tx_head, frame_len;
>  	const struct canfd_frame *cfd;
> +	unsigned long flags;
>  	int err;
>  	u8 i;
>  
>  	if (can_dev_dropped_skb(ndev, skb))
>  		return NETDEV_TX_OK;
>  
> +	spin_lock_irqsave(&priv->tx_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but can a CAN XL frame get
here and loop forever with tx_lock held and IRQs disabled?

can_dev_dropped_skb() does not reject CAN XL skbs on a device without XL
support. can_dropped_invalid_skb() accepts ETH_P_CANXL whenever
can_is_canxl_skb() passes. That check only tests the length and the
CANXL_XLF bit:

    return cxl->flags & CANXL_XLF;

AF_PACKET can therefore send a 13-byte ETH_P_CANXL frame with len=1 and
flags=0xff, and it reaches rkcanfd_start_xmit().

rkcanfd_start_xmit() casts skb->data to struct canfd_frame. cfd->len then
reads the XL flags byte, which is at least 128 for any accepted XL frame
and 255 in this example. can_is_canfd_skb() is false, so the classic path
runs with a u8 index:

    for (i = 0; i < cfd->len; i += 4)
        rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
                      *(u32 *)(cfd->data + i));

For cfd->len from 128 to 252, this reads past the skb data. It also writes
controller registers well beyond the TXDATA range. For 253 to 255, i wraps
from 252 to 0 and the loop never ends.

Without this patch the endless loop was a soft lockup. With the new
spin_lock_irqsave() held across it, it becomes a hard lockup on the xmit
CPU. rkcanfd_irq() on other CPUs would also spin on tx_lock in
rkcanfd_handle_rx_int_one().

Triggering this needs CAP_NET_RAW in the network namespace of the CAN
device.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014-rockchip-canfd-restart-close-v3-0-f0eb41090242%40qq.com
