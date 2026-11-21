Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219342;
	b=piIxPLfOJusTrvztTpWSLOWDhd+bygqg8ZkUI84AVqgq1qIuU+LAqkeDOf0UzFsJ0Q6f
	 MKORU5Ft6qWXFHCOR3upAbEHtfr6W3q0f9u4oCUknW0+Z1ql2LzDDid60BcdqfTDaNBAF
	 WoRavN+iOKtYdFiU5hLgJ/0OtRmviNbZnNbr1rEMkT1YCehyUF2TGUG916Yxura3m4AA4
	 8+HOQ6T3zr9j9ut2SjayMvAYqgqcmU5J2V1A1g8Zlfh2PTOE9vY2Rux8Raz/Qgls6LQod
	 g1SP1oOILznOi37swLtdvfW9/NBQrrUjPJ0ZdzNU/GlLlrp5CSBhhJh+K4EsFK2BRSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219342;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=5oT62WpkqvQG1bllCQZAHu6BEqx9AIMOrpuD6eCPtoI=;
	b=SFuk0m/tSBVornvOTDr0b7ma42hXsdntmgxoZMqJkAgzyv4MPXiaxXSMIkdOX+PlzoMZ
	 MUIqL13Vx0DW82L48QXkAWUtn0Y0ySm2vQFCFdptLPf0T3cWV63XGUJ/nmELVCCjStL5I
	 RjmAt6j4ftzQyIG0JvB5RKDBBncQjV3UAW4jX1PKunCZIGDqXR3l6+Wih3LdqVnbNx9jm
	 hmUBSP8sOjSZwNsvsnO2gjpc/IeHScFfn4qrygAaFfbxEgPOxDwPB8TK0sDWkxrAyp0jD
	 1PRNLetKRH9kibTMBYWQnVkzB4bug/FHU2MeLDfhe6fafleHsZZ7zsc9yJbwggpcZ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5GJRzs9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAB606A69B;
	Sat, 21 Nov 2026 00:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5GJRzs9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AD71F000CF;
	Sat, 21 Nov 2026 00:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219341;
	bh=5oT62WpkqvQG1bllCQZAHu6BEqx9AIMOrpuD6eCPtoI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=n5GJRzs9Z485qqcpHhRULwoD0w+4HXDdouFYqJZvFqbNqEtIj/LoieLf/eEa3yf3H
	 IgFe1HRN4ugJ4jQ2Fxoluy9faWOfAEL432IbD7XmvVvrCJTalonTnP16yaHnPltW+Z
	 TKQsRpxOvB/MgkzcbF8OfQommkTl0Mqfl2x3WxXgzjinZLPBhVwBjWhdGdJLFh6a8B
	 qMvHyV0kRA1rW4xKu38/XMpAxjQn4F0yxEWOdmm1euPxzUdY6f0crUEYRU28hhhe9k
	 PiG7uM5vQ3ornX44PSWB7MZ2+uwiPsmSa0wvqoq3AWYrNDUkWmCcDDbq9cQF90rnAr
	 qPFCd3H+10CaA==
Subject: Re: [PATCH net v10 05/10] can: rockchip_canfd: cancel bus-off restart
 before closing the device
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
Date: Sat, 21 Nov 2026 00:02:19 +0000
Message-ID: <179521933978.3131.189047644390163242@kernel.org>
In-Reply-To: <20261119-rockchip-canfd-restart-close-v10-5-df23913aa33a@qq.com>
References: <20261119-rockchip-canfd-restart-close-v10-5-df23913aa33a@qq.com>
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

- [Low] The commit message says late restart work (queued by a bus-off
  IRQ after the early close_candev_cancel_restart_sync() in…

--

can: rockchip_canfd: cancel bus-off restart before closing the device

This patch adds a call to close_candev_cancel_restart_sync() at the start
of rkcanfd_stop(), so that a running bus-off restart is cancelled while
the IRQ, RX offload and controller are still available. Echo cleanup and
the final restart cancellation stay in close_candev().

> A bus-off IRQ can pass the scheduling check before close, then queue
> restart work after the early cancellation. The final cancellation after
> free_irq() drains that late work so it cannot survive close.

[Severity: Low]
Is this explanation complete? Late-queued restart work does not have to
wait for the final cancel. With a short restart_ms it can run anywhere
between the early cancel and close_candev().

That window covers rkcanfd_chip_interrupts_disable(), free_irq(),
can_rx_offload_disable() and rkcanfd_chip_stop_sync(). The final
cancel_delayed_work_sync() in close_candev() can't undo a restart that
has already run there.

In that window, only this check in can_restart() stops the restart:

drivers/net/can/dev/dev.c:can_restart() {
    ...
	if (!netif_running(dev))
		return -ENETDOWN;
    ...
}

Without that check, the work would reach rkcanfd_set_mode():

	case CAN_MODE_START:
		rkcanfd_chip_start(priv);
		rkcanfd_chip_interrupts_enable(priv);
		netif_wake_queue(ndev);

That check, and the "scheduling check" in can_bus_off():

	restart = priv->restart_ms && netif_running(dev);

both come from the earlier patch in this series, "can: dev: check
netif_running() before bus-off recovery".

Neither the commit message nor the Cc: stable tag names that dependency.
The patch only needs "can: dev: add close_candev_cancel_restart_sync()"
to build. So a backport that takes this patch and the helper, but not
the netif_running() patch, would build cleanly and still have the
restart-after-teardown race.

Could the commit message say that late work which runs before the final
cancel is stopped by the netif_running() check in can_restart()? Could
the netif_running() patch also be listed as a stable prerequisite?

> diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
> index 1cae86973da5a..59a79fe057e66 100644
> --- a/drivers/net/can/rockchip/rockchip_canfd-core.c
> +++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
> @@ -758,6 +758,7 @@ static int rkcanfd_stop(struct net_device *ndev)
>  {
>  	struct rkcanfd_priv *priv = netdev_priv(ndev);
>  
> +	close_candev_cancel_restart_sync(ndev);
>  	netif_stop_queue(ndev);
>  
>  	rkcanfd_chip_interrupts_disable(priv);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119-rockchip-canfd-restart-close-v10-0-df23913aa33a%40qq.com
