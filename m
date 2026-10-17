Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DA29D294;
	Sat, 17 Oct 2026 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198845; cv=none; b=b+EHjg9/zZ0rkDh1iuLd1Pbsch1FTxt71yWJQQpkzsogIiSaWHNbH/Q4km/Xwf3oKHEMc+KWdtkRFy2/zy2t1j50zlJETuIcs/YDYWzwfG1qkOQsqhZbRMeyrlLDJ+rtR1xCdX9uFV5RLgPv0L0BSzePF0DnJMfwfolIvwVA9aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198845; c=relaxed/simple;
	bh=ROs70fPk78/OMk+cOQBB5V1U4GDgBC+RH04bt8ghzis=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2tgXuJm9kb3TLaJAO0EYUdFlDTdtCQMamU4WHoJb0/Nkg/6eEa0N5UbyOkm6ZsOWyMpsChm3byyrH/9rcj+yoqB9U0+EKj7h9WQB0jSuOuR4JgViJyvamY4tHvvQuKr0cbG3tHRFQsVJZshUMCQN8x8CR12c1b32+cbMXq04s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E12KcGjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E12KcGjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651501F000C5;
	Sat, 17 Oct 2026 01:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198844;
	bh=WLKAVyMVSmQOjN6SHuX6n9xWSw2+Rtn3bZHkHCgeQho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E12KcGjtaayPBL4g8g1vaqI+AYz5jzQd2vvaGZfmQO9jAH7CMQmjOnIolCfAkHqKP
	 gAcLN6YgxgpzwDmt6ICy7g1Ip1Q3Bzfx7n81wgeurXwnrsiQgBW3W4y+qv2S5BNmTp
	 O21bWfMBEzENvmA3HvTomx3tlNWexxx7vCFy+dB58txADDbUj8o6XBXxif9lSa0eGQ
	 g/hG2iBs4IQvp3HfSbB+nUUjk5+tyYi4ff1lMSVkDzA+mxahYZPz892midFdmEAJpo
	 72GNwCnfuvuUN4yPnmdR9iX3dW4RA++3kxDea/DLzZ4SWNjfXNKoLGSMiOrESkyJMq
	 eIwQCdpvd9sVQ==
Subject:
 Re: [PATCH net v5 2/6] can: dev: add close_candev_cancel_restart_sync()
From: netdev-bot+sashiko@kernel.org
To: 1579567540@qq.com
Cc: mkl@pengutronix.de, mailhol@kernel.org, heiko@sntech.de,
 davem@davemloft.net, wg@grandegger.com, socketcan@hartkopp.net,
 kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, stable@vger.kernel.org, kuba@kernel.org
Date: Sat, 17 Oct 2026 01:00:43 +0000
Message-ID: <179219884300.1406898.17794218418731765550@kernel.org>
In-Reply-To: <20261015-rockchip-canfd-restart-close-v5-2-ae77327037c9@qq.com>
References: <20261015-rockchip-canfd-restart-close-v5-2-ae77327037c9@qq.com>
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

- [Low] Concern: close_candev_cancel_restart_sync() is added to
  include/linux/can/dev.h, but the only call site is a no-op refactor in…
- [Low] Concern: the commit has 'Cc: stable@vger.kernel.org' but no
  Fixes: tag and no '# prerequisite for ...' note, while being a no-op…

--

can: dev: add close_candev_cancel_restart_sync()

This adds an inline helper, close_candev_cancel_restart_sync(), to
include/linux/can/dev.h. It only cancels the bus-off restart work, so
drivers can cancel it before tearing down IRQ and hardware resources.
close_candev() now uses the helper and keeps its existing order: cancel
the restart work, then flush the echo skbs.

> Use the helper in close_candev(), preserving its existing cancellation
> and echo cleanup order.
>
> Cc: stable@vger.kernel.org

[Severity: Low]
This isn't a bug, but could the commit message say why this is going to
stable?

On its own, the patch is a no-op refactor of close_candev() plus a new
helper. It has no Fixes: tag and no "# prerequisite for ..." annotation.

The only new user seems to be the next patch in the series, "can:
rockchip_canfd: cancel bus-off restart before closing the device". That
patch has its own Fixes: ff60bfbaf67f and Cc: stable.

Would it help backporters to mark this patch as a prerequisite for that
fix? If the rockchip fix were picked without it, the build would fail
rather than the code misbehaving, so this only affects commit metadata.

> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 6d0710d6f571d..a277d12332f15 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h

[ ... ]

> @@ -115,6 +116,17 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
>  
>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
> +
> +/* Cancel bus-off restart before tearing down resources used by the restart
> + * callback. The driver must still call close_candev() for the final cleanup.
> + */
> +static inline void close_candev_cancel_restart_sync(struct net_device *dev)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	cancel_delayed_work_sync(&priv->restart_work);
> +}

[Severity: Low]
In this patch, the only caller of close_candev_cancel_restart_sync() is
close_candev() in drivers/net/can/dev/dev.c, and that conversion keeps
the old behaviour. As a result, no driver's ndo_stop gets the early
cancellation that the commit message describes.

Is the helper meant to be used only by later patches?

This looks resolved later in the series. In "can: rockchip_canfd: cancel
bus-off restart before closing the device", rkcanfd_stop() calls the
helper first:

	close_candev_cancel_restart_sync(ndev);
	rkcanfd_tx_disable(priv);

	rkcanfd_chip_interrupts_disable(priv);
	free_irq(ndev->irq, priv);

It then calls close_candev() after the IRQ teardown.

Could the commit message mention that user, so the helper doesn't look
unused when this patch is reviewed alone?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-rockchip-canfd-restart-close-v5-0-ae77327037c9%40qq.com
