Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219346;
	b=rg7MOCl+tX1rJ1At8qxZ1zRi8DmA6fikCbTOIyDQgwwo+0CN/ylvuPPJiDoxWm0P/PJj
	 hbXxIWG0SsjYKrpAnkNp6EwdY3yt2IwwZ4pUiWyql9IWL00T1am54f9XNMZNuoXrC/Xlt
	 AolbMLfe+aLJ32Vk0NbiAHzkdXt36FbhroX9+8tcMg5L7CfQeBxLKhQKoDXhXSuRukzvS
	 117DFiAgwXfQGJK2Q9MrwSM6pHGAtqraoTxxh/q1j0tZT0Tl0m/reSpS2FMGWX64374c5
	 //ebVEjZaTVRhMJ1al9I1oE8u61uq0mf/n9XcvOl988aUsJQd5Up3Dh3VrouNEbW0zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219346;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QEZuHXIGv+qhQmLefVhIrnPz9p6YMMCvIoePdmT/2OA=;
	b=nIOTTegPClXOeaN5g71q9b+/vIAmS8+HL34irwCuZKDGbb1dzVjcVHgUDivU8fTmlQcl
	 jBAaTBXbH7Rw5Xh/sMHNHNWKJx+H6eP6rKSHYQYB4OWMzyPihA6V4SP664UeVqAqUE0Gd
	 mjUQSwTrhRoiAOFruQBmdf8OHvPDT01Y59lHK4tdsna+6BE2EiMoTd77TlMhwwEHkRcK7
	 /2sXkZOmjqMmuXUOBWypeLIGEC1k1gUHzTnZf+1PrdkJX93n+DBzVsyOEia+GkU+PkYkD
	 a9swkMl67PTYAw/NAm5DVW4pbvchvCWKOY3e4B7NAW+emQwIRCG/HWz6D8I8VqcWouA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBIJmc+l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456060A261C;
	Sat, 21 Nov 2026 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WBIJmc+l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9711F000C4;
	Sat, 21 Nov 2026 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219345;
	bh=QEZuHXIGv+qhQmLefVhIrnPz9p6YMMCvIoePdmT/2OA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WBIJmc+l4AHuHmL9IIEPGVqDixwav72Xbtqi2pCygzAVe4zrGEENbj5kNrhK7GLew
	 IMGE+Vv9C4pwqUkqQs6EoOqYW9P5Bvbhz7I4XBTR47jHA25kgZPbmdHPuHO5mCGh06
	 8fO83Y6GPxVZCETCwwmCoqOv47uYREX+6twdlH1Cd+OTDnVLCarHJow2ydRXytBzxm
	 Kq46NrfWI9guUzM+5UMBtyaF4S7HkRq11t+udH3UOnXS7zUQvQsP3gfJjUT7cHDkJL
	 9STYxjRecBETQMxT2iMaW2BWbuo6TENfu0cD/B6wDdnnIAfc7UAj9Nj9V7m99ZrUAY
	 qUpj0NmBD6YQg==
Subject: Re: [PATCH net v10 08/10] can: rockchip_canfd: retry the outstanding
 TX buffer
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
Date: Sat, 21 Nov 2026 00:02:23 +0000
Message-ID: <179521934391.3131.16575184154447420964@kernel.org>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-8-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-8-df23913aa33a@qq.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When the matching standard frame is processed after the
  original EFF frame has already completed, the erratum 6 retry puts a…
- [Low] rkcanfd_get_effective_tx_free()
  (drivers/net/can/rockchip/rockchip_canfd-tx.c) now returns 0 whenever…
- [Low] rkcanfd_tx_retry_work() (drivers/net/can/rockchip/rockchip_canfd-
  tx.c) re-arms itself every jiffy, with no limit and no timeout, for as…

--

can: rockchip_canfd: retry the outstanding TX buffer

This commit makes the erratum 6 retransmission use tx_tail instead of
tx_head, so the outstanding buffer is the one retried. It also adds a
tx_retry_pending guard that blocks new submissions until both TX request
bits clear, polled by a delayed worker, and disables retries on bus-off,
restart and close.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> index 7e3f478422e0e..745029c23645e 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
> @@ -39,6 +39,10 @@ unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
>  {
>  	lockdep_assert_held(&priv->tx_lock);
>  
> +	/* The original echo can precede completion of a retry. */
> +	if (!priv->tx_retry_enabled || priv->tx_retry_pending)
> +		return 0;
> +

[Severity: Low]

This isn't a bug, but the comment only explains the tx_retry_pending part
of the condition.

The !priv->tx_retry_enabled term sets TX capacity to zero on every model.
That includes rkcanfd_devtype_data_rk3568v3, which has no
RKCANFD_QUIRK_RK3568_ERRATUM_6 and never reaches rkcanfd_xmit_retry().

On those models tx_retry_enabled is a second lifecycle flag that copies
tx_enabled. It is set at the end of rkcanfd_chip_start() rather than in
rkcanfd_chip_start_finish().

The current callers keep both flags in sync, so nothing stalls today.
Could the comment also cover this coupling with tx_enabled?

>  	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_6 &&
>  	    rkcanfd_tx_tail_is_eff(priv))
>  		return 0;
> @@ -46,6 +50,68 @@ unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv)
>  	return rkcanfd_get_tx_free(priv);
>  }
>  
> +static void rkcanfd_tx_retry_work(struct work_struct *work)
> +{
> +	struct rkcanfd_priv *priv = container_of(to_delayed_work(work),
> +						 struct rkcanfd_priv, tx_retry_work);
> +	const u32 tx_req = RKCANFD_REG_CMD_TX0_REQ | RKCANFD_REG_CMD_TX1_REQ;
> +	unsigned long flags;
> +	u32 reg_cmd;
> +
> +	spin_lock_irqsave(&priv->tx_lock, flags);
> +	if (!priv->tx_retry_enabled || !priv->tx_retry_pending)
> +		goto out_unlock;
> +
> +	reg_cmd = rkcanfd_read(priv, RKCANFD_REG_CMD);
> +
> +	if (reg_cmd & tx_req) {
> +		schedule_delayed_work(&priv->tx_retry_work, 1);
> +		goto out_unlock;
> +	}

[Severity: Low]

Is there a limit on how many times this re-arms?

rkcanfd_chip_start() enables RKCANFD_REG_MODE_AUTO_RETX_MODE. If the
retried frame never gets an ACK (for example the bus is unplugged or the
only other node goes silent), the controller keeps retransmitting and
TX_REQ stays set.

Under the ISO 11898-1 fault confinement exception, an error-passive
transmitter that sees only ACK errors does not increase TEC. Bus-off is
never reached, so rkcanfd_tx_disable()->rkcanfd_tx_retry_stop() never
runs.

Wouldn't this worker then take tx_lock and read RKCANFD_REG_CMD once per
jiffy until the interface is closed or restarted? An un-ACKed frame also
stalled TX before this patch, but the per-jiffy polling with no limit is
new.

In the spurious match case the stuck request is the untracked duplicate.
The queue then stays stopped even though tx_pending is 0.

> +
> +	priv->tx_retry_pending = false;
> +
> +	if (rkcanfd_get_effective_tx_free(priv) >= RKCANFD_TX_START_THRESHOLD)
> +		netif_wake_queue(priv->ndev);

[Severity: Medium]

Is it safe to release the guard as soon as both TX_REQ bits read clear?

rkcanfd_xmit_retry() starts a second hardware transmission of the frame at
tx_tail, but it creates no echo_skb slot or pending count for it. Clear
TX_REQ bits only mean the hardware finished sending. The RXSTX
self-reception of the retried copy may still be in the RX FIFO.

Take the ordering the commit message describes, where the original request
has already completed when the matching standard frame is processed:

1. Standard frame S matches pending EFF frame B at tx_tail.
   rkcanfd_rxstx_filter() calls rkcanfd_xmit_retry(), and B is sent again.

2. B's original echo, still in the RX FIFO, matches echo_skb[tx_tail].
   tx_tail advances and tx_pending becomes 0.

3. The retry finishes. This worker sees TX_REQ clear,
   rkcanfd_get_effective_tx_free() returns 2, and the queue is woken.

When the echo of the retry is processed with nothing pending,
rkcanfd_handle_rx_int_one() skips the filter:

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_handle_rx_int_one() {
    ...
	if (rkcanfd_get_tx_pending(priv))
		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
    ...
}

Wouldn't the duplicate B then reach local sockets as ordinary RX? The
commit message lists this as an observed symptom, but it seems to remain
for this ordering.

Now suppose the IRQ thread is delayed, as in the PREEMPT_RT scenario from
the commit message, and a successor C has been queued at tx_tail. The
retry echo is then compared against echo_skb[tx_tail] = C in
rkcanfd_rxstx_filter():

		rkcanfd_handle_tx_done_one(priv, ts, &frame_len);

		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
					      rkcanfd_get_effective_tx_free(priv),
					      RKCANFD_TX_START_THRESHOLD);

Periodic CAN traffic often repeats the same ID, flags, length and payload.
If C matches B in all of these, can C's echo and BQL completion fire while
C is still pending in hardware?

The queue would then be woken. The next submission could rewrite the
shared TX registers while C's request is still outstanding, which is the
hazard this guard was added to prevent. C's real echo would later show up
as spurious RX, or be matched against the wrong slot.

The closing paragraph of the commit message only mentions the second copy
on the bus:

  "but the driver can still filter out a matching standard frame from
  another node and send a second complete copy of the original extended
  frame."

Should the echo of the retry be accounted for? If not, could the commit
message also mention the local phantom RX and the misattributed
completion?

> +
> +out_unlock:
> +	spin_unlock_irqrestore(&priv->tx_lock, flags);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a%40qq.com
