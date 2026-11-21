Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219343;
	b=PLQvxyHv8/mUQFjD3Auhst/w0P3R+Xg/ENaqVpUYy87Bdg+qoObZIWEY3biw4xT6imwQ
	 n1/NqsRxbHg1Fc2pQuOpvPB+YCmDz+QIRP630gOPW+iEvHTk8+9H6pagyVCDBQwNvsNaW
	 AXYa2CMkTb6nc+LDTUj7Y2RAUZML+4a88L3PeIuAUPVP3Ellm7G1sXzWIHxBar1Fa0TH/
	 JA3JAQY80wbVLKxZluoh1h9b4A9ViLtaABzqOlgLRRMUQWyWKQ+NBU3j8v7W3+iyifk0X
	 qLbr9W0kACkUAThjBjzhWe8SwBQycM3NnRIXoLhT4HgdIDUvgE3fyZ31vLDeHVYwUQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219343;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0y+Rk4QZ5e2oU+BGAt7OZ0CEJL8UV9kLFYC2q1exmHc=;
	b=YJ+xG9faq5Z5q10oIy2ome++Sh3nSqdsd1mynooZg+LI0pZjWyGrW+TALMdUkoUHBD0f
	 MGGQodB2SfY8BjIptjKi53txflgHCe/Uf3jYLz+YhBejM3pzRLSe1WPTwYjB5LjirOmBO
	 fB3nPNyPlQ/m0pswS+luf6F6G/Vpb2RcMSVrY2A87+k3BVE0+ZFXFk9e80gNOF9KOE0J0
	 VukEh68MBw6GAkSRc5UMQyu2+ycaOC/18szvzjdIc8RrlWQeIqsfmWfdeZTua7xp1SiIs
	 0V0qro5m+LHAyOGL5OSJrHhUqc2vPtvQHnC6UDios0VREG06qZr1sfVqcfnyOkdtHUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKnihBNY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE3606A69E;
	Sat, 21 Nov 2026 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AKnihBNY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228B11F000C6;
	Sat, 21 Nov 2026 00:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219343;
	bh=0y+Rk4QZ5e2oU+BGAt7OZ0CEJL8UV9kLFYC2q1exmHc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AKnihBNYdu9yh7d470oL2RjLqPx/DHRyy+z955BkgmlOBVb7JYUtqNZeG2ZXlO30m
	 TDnS6Qv+3Dw/OKZw0uFT237BQjql17DRC4Nf3uPmouzdXNQpjk5ZiwYUTd+dUMJ+Q8
	 6zWfuOumf2VMvUppu8ZKAsnxrhjxtC0jYG8dcGwDcvgGEoUAoDpIQfRtMJVb6PVOnR
	 ZDsU1+6B/ne44sQNVPOHLfmGSgmlhz8LgqYXycIsqA7nF+jYmk0MkhCIoj8DE+ceuu
	 f3AswRHZ9cK3ENEe9oSn/VeGZIUFLpBLpZWRqoP1gyecVfzrz4ya+tLURYDRJ3pN9s
	 9wujozKqWS6Jw==
Subject: Re: [PATCH net v10 07/10] can: rockchip_canfd: serialize TX with
 bus-off and restart
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
Date: Sat, 21 Nov 2026 00:02:21 +0000
Message-ID: <179521934168.3131.3588718854244956629@kernel.org>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-7-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-7-df23913aa33a@qq.com>
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

- [Low] In struct rkcanfd_priv
  (drivers/net/can/rockchip/rockchip_canfd.h), the patch replaces the…

Pre-existing issues:
- [Low] At this commit, priv->tc is read with no lock from the hardirq
  handler, via rkcanfd_skb_set_timestamp() -> timecounter_cyc2time(), on…

--

can: rockchip_canfd: serialize TX with bus-off and restart

This patch uses tx_lock and a new tx_enabled flag to drain TX and RX-side
echo users before CAN_STATE_BUS_OFF is published, and it drops consumed RX
FIFO entries while TX is disabled. Before reinitializing the controller,
restart masks device interrupts, suspends the shared IRQ handler through
irq_suspended and synchronize_irq(), and drains the timestamp work.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> index 72774cd2f94b7..ad582afbbd682 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
> @@ -37,6 +37,11 @@ static void rkcanfd_timestamp_work(struct work_struct *work)
>  	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
>  }
>  
> +void rkcanfd_timestamp_work_init(struct rkcanfd_priv *priv)
> +{
> +	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
> +}
> +

[Severity: Low]
This isn't a bug introduced by this patch, but can priv->tc be updated
here while the IRQ handler is reading it?

rkcanfd_timestamp_work() updates the timecounter without taking a lock:

rkcanfd_timestamp_work() {
	priv = container_of(delayed_work, struct rkcanfd_priv, timestamp);
	timecounter_read(&priv->tc);

	schedule_delayed_work(&priv->timestamp, priv->work_delay_jiffies);
}

The hardirq handler reads the same timecounter, also without a lock. It
does this on the RX, TX-done and error-skb paths through
rkcanfd_skb_set_timestamp():

	ns = timecounter_cyc2time(&priv->tc, timestamp);

timecounter_read() writes cycle_last, frac and nsec as separate stores.
Suppose the worker runs on one CPU while the CAN IRQ converts a timestamp
on another. Can the conversion then combine a new cycle_last with an old
nsec and produce a wrong hardware timestamp?

Separately, the bus-off path in rkcanfd_chip_stop() only does a non-sync
cancel:

	rkcanfd_timestamp_stop(priv);
	__rkcanfd_chip_stop(priv, state);

Here rkcanfd_timestamp_stop() is cancel_delayed_work(). If the worker is
already running, it can re-arm itself and keep reading the counter while
the controller is in reset.

This patch adds rkcanfd_timestamp_stop_sync() only on the restart path.
That covers timecounter_init(), but not these two cases.

Both appear to be fixed later in this series:

  "can: rockchip_canfd: serialize timecounter timestamp conversion" holds
  timestamp_lock around timecounter_cyc2time(), timecounter_read() and
  timecounter_init().

  "can: rockchip_canfd: prevent timestamp work from rearming after
  bus-off" uses disable_delayed_work() and a timestamp_active flag.

> diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
> index 077dd57d42de9..8fdb59025bfaf 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd.h
> +++ b/drivers/net/can/rockchip/rockchip_canfd.h
> @@ -475,7 +475,7 @@ struct rkcanfd_priv {
>  	struct can_rx_offload offload;
>  	struct net_device *ndev;
>  
> -	/* Protect running TX/RX echo state, queue updates and TX commands. */
> +	/* Serialize TX submission/completion with bus-off and restart. */
>  	spinlock_t tx_lock;

[ ... ]

> @@ -485,6 +485,9 @@ struct rkcanfd_priv {
>  	u32 reg_int_mask_default;
>  	struct rkcanfd_devtype_data devtype_data;
>  
> +	bool tx_enabled;
> +	bool irq_suspended;
> +

[Severity: Low]
This isn't a bug, but the new tx_lock comment covers less than the lock
actually protects.

tx_lock still serializes TX command writes. rkcanfd_start_xmit_write_cmd()
asserts it because rkcanfd_start_xmit() and the RX-side
rkcanfd_xmit_retry() share the erratum-12 MODE/CMD/MODE sequence:

rkcanfd_start_xmit_write_cmd() {
	lockdep_assert_held(&priv->tx_lock);

	if (priv->devtype_data.quirks & RKCANFD_QUIRK_RK3568_ERRATUM_12)
		rkcanfd_write(priv, RKCANFD_REG_MODE, priv->reg_mode_default |
	...
}

The lock also still covers the echo ring and the queue/BQL updates in
rkcanfd_tx_tail_is_eff(), rkcanfd_get_effective_tx_free(),
rkcanfd_rxstx_filter() and rkcanfd_handle_tx_done_one().

Could the comment keep listing the TX command and echo ring duties?

Also, nothing says how the two new fields are synchronized. tx_enabled is
only accessed under tx_lock. irq_suspended takes no lock and relies on the
WRITE_ONCE()/smp_store_release() and smp_load_acquire() pairing plus
synchronize_irq().

Would a short note on each field help? At the end of the series the
tx_lock comment is still narrow, and the later tx_retry_enabled and
tx_retry_pending fields have no comment either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a%40qq.com
