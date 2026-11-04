Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825211;
	b=AXo4qF4C3qMArjtP51EIlj9ft6G4TPxUQ5LgefmR7G06ijeRq6Nz7/eMnXg1e2r0LyF5
	 +SAPfJ6/knVzqsvL46pmg09pwIZbRi9KyEjtQVueGPkoctGCz3dOgg/fKXChUJo92qgUF
	 F9bv+EVmq9LG4mH8S9iLSvM9z3ys/4QhBEInPxHkO+mv/czzMGP5eWOVSHZW3zr91ZuAt
	 8LRjEnqvZ4Y66QKWzLznpO+wv87qvaCT++RC9DMO8vExbRKpgL6+jv7cWjWsLunt6Cljq
	 GYwF+Pz3Zcy04DCPSyyE6KNFaZO2pe1M2i6H3P2EI1ymr5W50dugDu48f57/ustJS6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825211;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=jprIiT+sh8cBrL1Brn07csemCaTfTZPjoSZJmioozBs=;
	b=EVK4ix1Em8HEKjqknkHYVo1+Aikxf9eAhxbrwu/IwVCWWtwSjlym0ATLKUPQDqeQfQiB
	 tkc2KmgINy3acZsHPJj3DjYMKfm0wIYlCMczSi/j5FcrDxoOCZPv84AoW0+3TxhBq8T2w
	 6zpN0G+ft2LxIrG4ayhRPlwF+f/0tVRfT4uL398vNjPJHqO9QC1p3flEa1nOa4iENB4CS
	 P32qk4muV7RlJtKIuCDC7CTAzspMmHd2uUEv879LvFztrZ1uwNd0ORH+9PFh3MnczE/+B
	 J6depNUXMntFb+3f5FQ7MlogEe1C/iswCqZI3KfXhHQVOi048WrCO9LkmXsmDct6HIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvnzcN5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2D60960A0;
	Wed,  4 Nov 2026 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvnzcN5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6181F0093A;
	Wed,  4 Nov 2026 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825211;
	bh=jprIiT+sh8cBrL1Brn07csemCaTfTZPjoSZJmioozBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XvnzcN5CCGPTHmjiB3RlahfgbEFOq4h0RYu0tDxW6w8oEL6QqzkSycdDrVzHlDf+E
	 EMtfSgigTLu5B8xu+DpMmLf8xVaUSs/ruD6sxtlqsUxSWsasMnnxrDocJvPBvDMhCB
	 1pSxSFEBZ7Q5F+JE6SZMwThZKsxEfcuvP42Sh/uHo7wGchA+AJOlzqQA6uwhUpyN9t
	 I1QfnuwaQ3midx8tbKfxDvL3qrare8/KEACTY4thspJ6EAGmxolx5aNdzE7YhdV20P
	 BvAOJ6/fxGqfBInNxAbwtSdEli6zb2RYjyI0OBo0viZAnF0UJ9pRhVQTop/3Yx8KHq
	 JvAMXBn55SmuQ==
Subject: Re: [PATCH net 13/15] can: dev: can_fill_info(): don't wake up
 controller if interface is down
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, liucj1228@outlook.com,
 s.grosjean@peak-system.fr, stable@vger.kernel.org
Date: Wed, 04 Nov 2026 20:46:50 +0000
Message-ID: <179382521036.488856.13184139645230625670@kernel.org>
In-Reply-To: <20261103204305.3211144-14-mkl@pengutronix.de>
References: <20261103204305.3211144-14-mkl@pengutronix.de>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes this as removing one trigger of a
  flexcan abort on i.MX8QXP.

--

can: dev: can_fill_info(): don't wake up controller if interface is down

This patch changes can_fill_info() and can_get_size() to skip
IFLA_CAN_BERR_COUNTER when the interface is not running. As a result,
do_get_berr_counter() is never called on a down interface. The goal is
to avoid a synchronous external abort in flexcan_get_berr_counter() on
i.MX8QXP when "ip link show" runs on an interface that was never brought
up.

Link: https://patch.msgid.link/20261027065012.191348-1-chunyuzhiqiang@yinhe.ht

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..b958c04d53db6 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c

[ ... ]

> @@ -1006,7 +1006,7 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
>  	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
>  	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
>  
> -	    (priv->do_get_berr_counter &&
> +	    (priv->do_get_berr_counter && netif_running(dev) &&
>  	     !priv->do_get_berr_counter(dev, &bec) &&
>  	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||

[Severity: Medium]
Is this meant to change the output for every CAN driver, and not only
flexcan?

can_fill_info() is the only core caller of priv->do_get_berr_counter.
With this check, no driver that sets the callback will report
IFLA_CAN_BERR_COUNTER on a down interface. can_get_size() gets the same
change.

Several drivers turn on their hardware inside the callback so that this
query works while the interface is down:

drivers/net/can/sun4i_can.c:sun4ican_get_berr_counter() {
    ...
	err = clk_prepare_enable(priv->clk);
    ...
}

drivers/net/can/c_can/c_can_main.c:c_can_get_berr_counter() {
    ...
	c_can_pm_runtime_get_sync(priv);
	err = __c_can_get_berr_counter(dev, bec);
	c_can_pm_runtime_put_sync(priv);
    ...
}

Other drivers do the same thing:

  bxcan_get_berr_counter() calls clk_prepare_enable()
  xcan_get_berr_counter() and ctucan_get_berr_counter() call
  pm_runtime_get_sync()
  rcar_can_get_berr_counter(), rkcanfd_get_berr_counter() and
  flexcan_get_berr_counter() call pm_runtime_resume_and_get()

The commit in the Fixes: tag, ec56acfef2af1, states this intent
directly: "flexcan_get_berr_counter() may be called from userspace even
if the interface is down ... This patch switches on the clocks".

After this change, the wake-up code in those drivers only runs when the
device is already active, so it no longer does anything useful. Should
that code be removed? Or would it be better to put the check in the
flexcan driver instead?

The commit message cites m_can as the precedent. Commit 91a55c72a821
fixed m_can inside the driver:

drivers/net/can/m_can/m_can.c:m_can_get_berr_counter() {
    ...
	/* Avoid waking up the controller if the interface is down */
	if (!(dev->flags & IFF_UP))
		return 0;
    ...
}

That version still sends the attribute, with zeroed counters. With this
patch, m_can sends no attribute at all for a down interface. Is that
change intended?

Because of the flexcan Fixes: tag and Cc: stable, this would be
backported to every stable tree since v3.16. After that, "ip -details
link show" would stop printing berr-counter for down interfaces on all
drivers, including ones where the query always worked.

The commit message does say that the attribute is no longer reported.
Could it also say that this applies to all CAN drivers, and that it
replaces the per-driver support for down interfaces?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103204305.3211144-2-mkl%40pengutronix.de
