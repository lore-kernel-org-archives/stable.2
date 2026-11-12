Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522734;
	b=C8Nk8g077p9jc2t4oPZFHPVoPGkXY179sMpKPxxwlVX0WcLNZf55OQ47Hnrq2l20HOLa
	 mALxqxJxBGdZWYuWV7+kTc/DXb3rfnKvTZUZ0E74BP2FbEgxAN3cgvGzh3GuMw4ggyHpK
	 ZQ2DDmeEVN9L/eh4xkaAjZL9GW0RdRMaFQPbOY0zuO48gbonisFeljc4xV81QCcjcJWm5
	 qvJBwDKRZM3X/LAvn+IrG7Fggvjpu/lmW2ofyKYGWWYvP0UU5r4/hBjp20/lQsbFKwZTU
	 vyHRLiLR9FsbVa50otuDjLQO57XsgyZKxVYff2FcwACGf3AFZkRl6SGKYu4DU8AEUkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522734;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=48VJYDAuIt0iLg0S1Cc71k3C6Jpv8GbdLJgMXR02WJE=;
	b=mSTTIz8F+eYvt0/ncPQhw5oeHYf7GZQhgOKMK9diyRE3RbhTQpNWvz5dq6vepq26/dAB
	 HH7SRDfQA+4MNJrhbFDsl2MgGr6IcKbcLjDpLn08BBA6x1UEMIZpkhHXkxmnimKJsG6H1
	 2zKJptfIw8HEmwgs2YoB+AR2IxTaV/hlsG04wzf/+fi2S7rR+WPK3u/FFnmbkNz0wnoDY
	 +HEL1dkKJWn6V9cWiFVbudiA2Lkj6s3aEkwirB39amaGWsw6ZOze7LRZosaOkpJTIuW7e
	 eaLZg7byZQp8wtDZUsM2QXhVzZO4ovwCgiTN2TSPtrRoBSpBLKoRVYLALl0ZSl1FgUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK1SZ2ty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BC60A262A;
	Thu, 12 Nov 2026 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WK1SZ2ty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B8B1F000C9;
	Thu, 12 Nov 2026 22:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522734;
	bh=48VJYDAuIt0iLg0S1Cc71k3C6Jpv8GbdLJgMXR02WJE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WK1SZ2tyrMYhJF/bZa4tEgn7hNxQSuUHNriOZekpe0FEf805H9H30EWWPUzGdG7ZS
	 f7dFNPDMTUlTK6k6D75/z7hCezGI6bgRaNl6oSBghVHoMYD7rdlST0RoxoBQxJG+e0
	 RSnR8GmZyArpwpmvQ/eKbVkZLDmX3l1txiaQ+H2uNYyFZcRXI21LbkxrxWrRKZniHF
	 07g5RCfvQp+KYJlx7oF45NucDumEpUZCq2rWM3gJk5i8HbbQpnT2wmVSK7Qznn0mdB
	 /GIlK/W6mEITS/+PzTCZjOosbMjnuKZcnyDNwEu/fvNL38lZxAYFOodbg7rdU4emV/
	 SR2CImU1I8o2g==
Subject: Re: [PATCH net v9 06/10] can: rockchip_canfd: cancel bus-off restart
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
Date: Thu, 12 Nov 2026 22:32:12 +0000
Message-ID: <179452273299.488853.8253978964891645481@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-6-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-6-6643f3825ba3@qq.com>
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

- [Low] The patch has a missing stable dependency annotation.

--

can: rockchip_canfd: cancel bus-off restart before closing the device

The patch adds a call to close_candev_cancel_restart_sync() at the start
of rkcanfd_stop(). Today restart_work is only cancelled in close_candev(),
which runs after the IRQ has been freed and the controller stopped. The
earlier cancel is meant to stop a concurrent bus-off restart from turning
the controller back on after IRQ teardown.

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

[Severity: Low]
This patch has Fixes: ff60bfbaf67f and Cc: stable@vger.kernel.org. Will it
build when backported on its own?

The close_candev_cancel_restart_sync() helper is only added to
include/linux/can/dev.h by the earlier commit "can: dev: add
close_candev_cancel_restart_sync()". That commit has no Fixes: tag and no
Cc: stable tag:

static inline void close_candev_cancel_restart_sync(struct net_device *dev)
{
	struct can_priv *priv = netdev_priv(dev);

	cancel_delayed_work_sync(&priv->restart_work);
}

The early cancel also appears to depend on the earlier commit "can: dev:
check netif_running() before bus-off recovery". That commit adds these
checks in drivers/net/can/dev/dev.c:

can_bus_off():
	restart = priv->restart_ms && netif_running(dev);

can_restart():
	if (!netif_running(dev))
		return -ENETDOWN;

Without those checks, a bus-off IRQ can still arrive after the new early
cancel but before free_irq(). In that case can_bus_off() would requeue
restart_work.

can_restart() would then call do_set_mode(CAN_MODE_START) unconditionally:

can_restart_work()
  can_restart()
    priv->do_set_mode(dev, CAN_MODE_START)
      rkcanfd_set_mode()
        rkcanfd_chip_start()

That turns the controller and its interrupts back on and schedules
timestamp work after free_irq() and rkcanfd_chip_stop_sync(). This is the
same failure the commit message describes. The cancel_delayed_work_sync()
in close_candev() runs after rkcanfd_chip_stop_sync(), so it comes too late
to prevent it.

In mainline both prerequisites come earlier in the series, so the in-tree
fix is complete. Other patches in this series say what their backports need
(for example, the "Backports must include ..." notes in "can:
rockchip_canfd: retry the outstanding TX buffer" and "can: rockchip_canfd:
serialize TX state and command writes").

Could this patch carry a similar note, or Stable-dep-of annotations, for
both of these dependencies?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
