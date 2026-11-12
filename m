Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522726;
	b=pepPYLDiQTORkQiiDN5PyuO55bCSxtEYwOp08ZIDG8Wy4ZtatL4lump8ErCXDif9zS6c
	 sAk+nIga5oKu6LiHiC0X9Z+C5v+a08ZDFILgjVJjYf323b8ZWjqxIWqW9733ydLdSc8pb
	 9KEhKhhZPdhiKY5PPHYAfEQLo0s04NYd1AAXnHcQvee8L7YclXtXqeqjlLFU3STcb9QfM
	 +vrHn225ohRC40O7QX8b8H7iDae6LdUH5Q6F4ThGagSoaFsK1NF77JQco6yGerC7cEWzr
	 gs63qVNUnpz4PB4xhIHT01nOE9qskhfCf15Tg5qv4/Pf3VsfLAfy2Y0ccTTVtjxeOsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522726;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7Dww7rLEK29Z8yiJXV5V5KMhrywlVHiQMndBRuw4E/0=;
	b=U6kvSDm9saedIENkHWGZD/hP3iE5srjWVzVH/ra/WO50kSLetl9lWj6FvZ3L1Qk4dmXH
	 h5w/P/yc6eYS2hW1Cl2OjFtuekZM2hNba7/iX3OF9KdkGfMq2skxxdPObm7v8NvePmcgr
	 2Uog5JpRaUPEnLTai+qAkehTOf4Tw+cC8CjYdadsQwxhrFWmgWauU6ABlJ1EEI7IYSY1S
	 AGcFDIK3sDvxAZewMIUzZkbu9FCN0Bwpqfzsd57ZSiW7us+QoWK6AMlkcOuydazcraetA
	 l0BKFI6tXXCX+uJNsuLRb2HR4vOPGqL04CGH2YyB6cmpWLcIHTZ1nM9FJibU+gAJ2Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qu4iskwl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB70606A31C;
	Thu, 12 Nov 2026 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qu4iskwl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53AD1F000C4;
	Thu, 12 Nov 2026 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522725;
	bh=7Dww7rLEK29Z8yiJXV5V5KMhrywlVHiQMndBRuw4E/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qu4iskwlFTCn0sPnAuYguLRUDzos0rP2oiB2AV6297+eONMYTmxzBG9ldyx/ZiwMH
	 4BY6Bbuc8BzogjDhd1FpX2D22Bq66YV3QjstHiZVSsAEAvwBb+IGvdpRR74rHU+oa8
	 KBMUbqeMZcw0Oi/dEada+JA93TRZo6z9Ru+aC1yc8NlYXImB561/9XVKiugV9zc3U4
	 JSoYaEkEnSBNr67EPpqg/LjteW0gzZHlx1WD/ZvUv+5UWCga6NW18cNLWNCGd823qe
	 Aj3DX1K027sMoeGt+7Dnkhqg/2zyOjFh7nkH3/Ab2FVepFBESbMmCI2HNXYfJ1ZTfV
	 /qZN/Ot3wccGg==
Subject: Re: [PATCH net v9 01/10] can: rockchip_canfd: prevent TX stall on
 echo skb failure
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
Date: Thu, 12 Nov 2026 22:32:04 +0000
Message-ID: <179452272422.488853.17004807498883326670@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-1-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-1-6643f3825ba3@qq.com>
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

- [Low] The commit message understates how bad the bug is.

--

can: rockchip_canfd: prevent TX stall on echo skb failure

This commit moves can_put_echo_skb() in rkcanfd_start_xmit() so it runs
before the hardware TX buffer is written. If no echo skb was installed, the
frame is dropped and tx_head and the BQL bytes are left unchanged. It also
passes an extra skb reference to can_put_echo_skb() and releases the
original skb once submission finishes or fails.

> rkcanfd_start_xmit() advances tx_head and requests transmission even when
> can_put_echo_skb() fails. Completion matches self-received frames against
> the echo ring, so an entry without an echo skb cannot be completed and
> can leave the TX queue stopped.

[Severity: Low]
The code change looks right to me. Does this description cover the whole
impact, though? It looks like RX stops as well as TX.

can_create_echo_skb() uses skb_clone(GFP_ATOMIC), so can_put_echo_skb() can
fail with -ENOMEM under memory pressure. Before this patch, the empty slot
still became tx_tail, so rkcanfd_get_tx_pending() stayed non-zero.

After that, every received frame goes through rkcanfd_rxstx_filter():

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_rxstx_filter() {
    ...
	skb = priv->can.echo_skb[tx_tail];
	if (!skb) {
		netdev_err(priv->ndev, ...);

		return -ENOMSG;
	}
    ...
}

By this point rkcanfd_handle_rx_int_one() has already pulled the frame out
of the FIFO with rkcanfd_read_rep(). It then returns before
alloc_can_skb() and can_rx_offload_queue_timestamp() are called:

drivers/net/can/rockchip/rockchip_canfd-rx.c:rkcanfd_handle_rx_int_one() {
    ...
	if (rkcanfd_get_tx_pending(priv)) {
		bool tx_done = false;

		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
		if (err)
			return err;
    ...
}

rkcanfd_handle_rx_int() then leaves its FIFO loop on that error. tx_tail
never advances, so the same thing happens on every later RX interrupt, with
a netdev_err() each time. Frames from other nodes on the bus are lost as
well until the interface is restarted.

Could the commit message say that both RX and TX stop? That would help
stable backporters judge how urgent this fix is.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
