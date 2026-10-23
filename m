Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792728912;
	b=COntvFhvLt/KAzArAHs2GDl9KBL0M5k+curhcYdGL8o3LfddGWrKuXbwmJOOx6p/IaZL
	 8Ov/bLbDHRgGgZdGPIzzjQoL5cRncTNcVg54TElJyx43HyD7sViKi9SYXKoRujkx9ytrq
	 OHEvOotoS0waDOUNMSQYJumXqoLU0080qfq/NTv01Bwf4bJAiOHFSdcyxxY7veP7RbeEq
	 Y2PEEbq1T5+TfvpDPNDr8ntuxOCj2OKlyXA2auAcitBD2nXMeSqpXLHrIrNcm+SAqa2fR
	 fDQoIAFuoZhKBMIPvzqaLhKKn/pPYZjuHDD6b/bcooLtLOqLgcLrZX7eBCu0w1q2mgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792728912;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aAJMQvWLv6dMUeOuLQoFAGJiJnLdNrhHyRVCdhvYEhI=;
	b=ZkEZHmG607wbKGxc2ZGfGC1d70+81EW1yptbgQXSYgKbn6DzbKt3IoqpOjhZl69W9C83
	 5lCB/4BKfPFdy2OETTsM/2gaI71tlqrtZSPoBGIm2xIHAuheThcJnRia8FwtFtLMeMeeY
	 58WZvjvV/ews76J75mj6AUXAhzDPRc6LpUHPm2RsNzH7/Ghc1nj3Y4J4pprly1Z0jKln2
	 17YyjTpSp4gmE7cqEZd2C0y7yJIjhKH4Zn/HoVNjxyoKIyelgygfEAqBn0kqBTFyvmHrM
	 X6xe5mYRT4SYLKWEuwycLdy7WNHwzRKf1YKjBjYhC10LvceZ9QOOdZ/R4a4foSiriHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k69b1PDf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A88606A31E;
	Fri, 23 Oct 2026 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k69b1PDf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A701F01825;
	Fri, 23 Oct 2026 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792728910;
	bh=aAJMQvWLv6dMUeOuLQoFAGJiJnLdNrhHyRVCdhvYEhI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k69b1PDf4BCRSakt8yAfW2iDBa9ugBSn4aWAL1ZL7UcX8pNgpTYOlg2IdmXG+vOAM
	 wlEQBt46Gvr6Cl0D9Z7G/Udlsne8/aPle2LJ2aPUnyekkW8wmXtvwp/Ijq55ytdx6U
	 xKBGbTf4bxj7QVekL1dPbgY5rjfI/nqzJO7YS+f6qMxor4veFf/lS/IfRjF6Kjz6d5
	 zsjPPVJA3e7MrGYxLvbi1elIkqnyg06YR7r6XTunYebMsBxQbd1prnzlhY/nIjlWSB
	 h0B3tlcfC9W/PGSO1XDfMs93DQEikTFvrjbEz+7t2ltenQPvG5QbBFiEEJIituq4TR
	 Jgce65uhUQrbw==
Subject: Re: [PATCH v7] can: dev: can_fill_info(): don't wake up controller if
 interface is down
From: netdev-bot+sashiko@kernel.org
To: chunyuzhiqiang@yinhe.ht
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 linux-can@vger.kernel.org, mkl@pengutronix.de, kernel@pengutronix.de,
 haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev,
 stable@vger.kernel.org, kuba@kernel.org
Date: Fri, 23 Oct 2026 04:15:09 +0000
Message-ID: <179272890958.3130.8901186354506678802@kernel.org>
In-Reply-To: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>
References: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message calls the issue "a generic logic problem
  that exists on all platforms", but its own root-cause analysis points…
- [Low] The patch carries `Fixes: ec56acfef2af1` (2014) and `Cc:
  stable@vger.kernel.org`, but it is explicitly rebased onto net-next…

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but can_get_size()
  reserves only `sizeof(priv->bitrate_max)` (4 bytes) for…

--

can: dev: can_fill_info(): don't wake up controller if interface is down

When the interface is not running, this patch skips the calls to
do_get_berr_counter() and do_get_auto_tdcv() in the CAN netlink fill path,
and changes can_get_size() to match. As a result, IFLA_CAN_BERR_COUNTER and
IFLA_CAN_TDC_TDCV are no longer reported for down interfaces. The
motivation is a synchronous external abort seen on i.MX8QXP when "ip link
show" is run on a flexcan interface that was never brought up.

> Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> controller if the interface is down. This fixes a generic logic problem
> that exists on all platforms.

[ ... ]

> On i.MX8QXP the
> CAN clocks are gated through the SCU LPCG and the subsystem shares the
> IMX_SC_R_CAN_0 power domain; there is a window where
> pm_runtime_resume_and_get() has returned but the clock has not reached
> the module yet, and the immediate ECR read raises a synchronous
> external abort.

[ ... ]

> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
> Cc: stable@vger.kernel.org

[Severity: Medium]
Is "a generic logic problem that exists on all platforms" an accurate
description of what is going on here?

The flexcan netlink path already takes a runtime PM reference before it
reads ECR:

drivers/net/can/flexcan/flexcan-core.c:flexcan_get_berr_counter() {
    ...
	err = pm_runtime_resume_and_get(priv->dev);
	if (err < 0)
		return err;

	err = __flexcan_get_berr_counter(dev, bec);
    ...
}

flexcan_runtime_resume() only calls flexcan_clks_enable(priv).

Suppose pm_runtime_resume_and_get() really can return before the LPCG clock
reaches the module. That looks like an i.MX8QXP clock or power domain
problem. The SCU LPCG driver already has an erratum workaround on that
enable path, lpcg_e10858_writel() in drivers/clk/imx/clk-lpcg-scu.c.

This patch removes one trigger, a netlink query while the interface is
down. The same enable-then-MMIO sequence seems to remain elsewhere:

ip link set canX up
  flexcan_open()
    pm_runtime_resume_and_get()
    ...
    flexcan_chip_start()

register_flexcandev()
  flexcan_clks_enable()
  flexcan_chip_disable()

If that window exists, would these paths hit the same abort?
flexcan_open() does other work between the resume and the first register
access, so it may not show up there. register_flexcandev(), however,
touches registers right after it enables the clocks.

The v7 notes also say the Fixes: commit ec56acfef2af1 was not buggy. With
Cc: stable, could this lead backporters to think the i.MX8QXP synchronous
external abort has been root-caused and fixed?

Not waking the controller while the interface is down looks reasonable,
and it matches the m_can fix. The concern is only with the root cause and
the Fixes/stable framing.

>  - Rebase onto current net-next/main, including e63281614747
>    ("can: netlink: add initial CAN XL support").

[ ... ]

>  - TDC auto readback gating is based on code inspection; only the
>    berr-counter path was tested on i.MX8QXP hardware.

[Severity: Low]
The Fixes: and Cc: stable tags mark this for backporting to stable.
However, the patch is based on net-next and depends on the CAN XL netlink
support from e63281614747.

The hunks that use priv->xl, CAN_CTRLMODE_XL_TDC_MASK, the dbt_params-based
can_tdc_get_size() and can_data_bittiming_get_size(), and
can_tdc_fill_info(..., IFLA_CAN_XL_TDC) don't look like they will apply to
older stable branches.

The same stable-tagged patch also combines the berr-counter change, which
was tested on hardware, with the do_get_auto_tdcv gating, which came from
code inspection only. Would it help stable reviewers if the TDCV gating
were a separate patch?

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f5..ac30d2849543 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c

[ ... ]

> @@ -825,10 +830,10 @@ static size_t can_get_size(const struct net_device *dev)
>  	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */

[Severity: Low]
This isn't a bug introduced by this patch, but should this be
nla_total_size(sizeof(priv->bitrate_max))?

can_fill_info() emits the attribute with nla_put():

	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
		     sizeof(priv->bitrate_max),
		     &priv->bitrate_max)) ||

That needs nla_total_size(4) = 8 bytes of tailroom. can_get_size() reserves
only 4, so it comes up 4 bytes short for each CAN interface. Every other
attribute in can_get_size() is counted with nla_total_size().

In practice the slack in if_nlmsg_size() and slab rounding probably hide
the shortfall.

>  	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
>  
> -	size += can_data_bittiming_get_size(&priv->fd,
> +	size += can_data_bittiming_get_size(dev, &priv->fd,
>  					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
>  
> -	size += can_data_bittiming_get_size(&priv->xl,
> +	size += can_data_bittiming_get_size(dev, &priv->xl,
>  					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021145115.153107-1-chunyuzhiqiang%40yinhe.ht
