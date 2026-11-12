Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522733;
	b=FjU2GnRBD1cKxlgCoNfMTridKRE07D5CEwHZtF5zdUT/Y1/zqR7uJQl590esuqzfBwtT
	 GYah1rwMl2BxViR+KaVEboa9vC1kVQSPiL/61YmrrJwDP4h7wdrfoD9tEC3IqPSK1yfsL
	 6M0q0QmOsLaf7GztYT14gX2/pPgwRSKLMUhpfxZfjtafRRgHX7wbIxnmCWx7kXDN9H4Xg
	 1jvLQ7ijPgHT5U6l4eKA2a9YJof5lIw6Dmx1rOypa4rL7SL2SEFaMZll4bHtw9YCVHy5E
	 u1/ymS2uNUr/Lh30OfEGyhGecrkO7iI/vyE9iiUmHnZGHQDFIbT553+bLJdVVoaClyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522733;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OH+0WymoBgcUXGycaB4LMqft3m6k34R9ciQ53jyzM9o=;
	b=E9a2QQCiD7QncGAlS9NwzXgU+1OaSpzEexb26OgyUQ/mblAfR6KAEydBeWgYrogf6GVu
	 BfezyiI1e8wwnlWhRq5IJnlXzhg0XtUtk9rPSH2aWmDTQiXt2/8031+6PU/6NMrx8coaz
	 uJnrhi/L3miuDDOE2/QCi0ZWBTpcQl20+C57aglSJIVscwrMOJYzyNR/JtyXRre+S0l4Z
	 s7ndWVq2GVLeCu9DQdF1SbpUnCiV6tgerKUx5AgTByY+Ueab7pRHCG+qHS7QYn/V7OCts
	 PdFsucJpaB3RHEHjxsYPYp9nLwRDW/kxP19x+BR2KGQoZqglmbiSh9+56jT+aOsBmaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MzC3q/kC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69060A260F;
	Thu, 12 Nov 2026 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzC3q/kC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C3F1F000CD;
	Thu, 12 Nov 2026 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794522732;
	bh=OH+0WymoBgcUXGycaB4LMqft3m6k34R9ciQ53jyzM9o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MzC3q/kClS6U+kXLRaoowhQjOzZ63Z0TSjrBiLo+2gXsCGgsZg/DvhPVGPzQN0ab3
	 Wm8lXXAOcEv3RbykuHY8mMukhtoSIq2GT1ZcL7yOWJ1WvxiWo/VuhBIiCwjb6cgOTc
	 RlNbBw4eAT2IwrqW5kkDKAbkwbCOuym1fZqAmnnJ7rFlxDMKytJnZgk0y8wY1wwv4t
	 r3ougT1O1IWbiWG6vYwfqF/fEj18XVAETxLyvyznpH8x9OXfritCFEvi9HY7qoTeuw
	 EKqTf1fXoBgEb0PPlG3UC6QC6KCysBDHpr8PEhr4u5ueCUpgcxoUk9PEh/oejeQSNt
	 313pXofxZFk9g==
Subject:
 Re: [PATCH net v9 05/10] can: dev: add close_candev_cancel_restart_sync()
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
Date: Thu, 12 Nov 2026 22:32:11 +0000
Message-ID: <179452273127.488853.12768732215259424178@kernel.org>
In-Reply-To: <20261111-rockchip-canfd-restart-close-v9-5-6643f3825ba3@qq.com>
References: <20261111-rockchip-canfd-restart-close-v9-5-6643f3825ba3@qq.com>
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

- [Low] The patch adds close_candev_cancel_restart_sync() as a static
  inline in include/linux/can/dev.h and moves close_candev() onto it.

--

can: dev: add close_candev_cancel_restart_sync()

This commit adds a static inline helper, close_candev_cancel_restart_sync(),
to include/linux/can/dev.h. The helper synchronously cancels the CAN core
bus-off restart work, and close_candev() now calls it. Drivers can then
wait for recovery to finish before they tear down IRQ and hardware
resources, and echo skb cleanup stays in close_candev().

> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
> index 346faddee02eb..2a286f906394b 100644
> --- a/include/linux/can/dev.h
> +++ b/include/linux/can/dev.h

[ ... ]

> @@ -115,6 +116,22 @@ struct can_priv *safe_candev_priv(struct net_device *dev);
>  
>  int open_candev(struct net_device *dev);
>  void close_candev(struct net_device *dev);
> +
> +/**
> + * close_candev_cancel_restart_sync() - cancel bus-off restart synchronously
> + * @dev: CAN network device
> + *
> + * Call before tearing down resources used by the restart callback.
> + * The driver must quiesce restart work producers before calling
> + * close_candev() for the final cleanup.
> + */
> +static inline void close_candev_cancel_restart_sync(struct net_device *dev)
> +{
> +	struct can_priv *priv = netdev_priv(dev);
> +
> +	cancel_delayed_work_sync(&priv->restart_work);
> +}

[Severity: Low]
This isn't a runtime bug, but should this patch carry a stable tag? The
alternative would be for the following Rockchip fix to list it as a
prerequisite.

The next patch in the series, "can: rockchip_canfd: cancel bus-off restart
before closing the device", has Fixes: ff60bfbaf67f and
Cc: stable@vger.kernel.org. It calls the new helper at the start of
rkcanfd_stop() in drivers/net/can/rockchip/rockchip_canfd-core.c:

    close_candev_cancel_restart_sync(ndev);

This commit has no Cc: stable tag, and the Rockchip fix does not name it
as a dependency.

If stable picks up only the tagged Rockchip fix, would the backport fail
to build? close_candev_cancel_restart_sync() would be undefined there.

Documentation/process/stable-kernel-rules.rst gives this form for
prerequisites:

    Cc: <stable@vger.kernel.org> # x.y.z: <sha>: <subject>

Other patches in the series already state their backport dependencies.
The earlier core patch "can: dev: check netif_running() before bus-off
recovery" is also tagged for stable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-rockchip-canfd-restart-close-v9-0-6643f3825ba3%40qq.com
