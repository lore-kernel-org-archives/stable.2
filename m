Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178C2EB5A6;
	Sat, 10 Oct 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791663597; cv=none; b=pvLemkzT9sn5f31Hu8BXcmLeZLuhnE0BKmRQGzEK7mFjJrgsS8Vt+xNwbiABIInlVf2NQXfrjbiO/5Jszf0C8djWQbJmgiVCiYf+IDGvh2y22evvBsVSnj8E5sPpSMIOTgD8hVsI1jFaAGAohw5ZxxblvWqvHekwj9E2h2KWocg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791663597; c=relaxed/simple;
	bh=7XSXNGUel4gBLywYKxEWYma73/CfzHyMow6wLNKvRzo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z6By8WYqc41eq9cWZy4rQjjcwHqrTQcfgql3ofqejT23iz+gEDVqrzuMsrxfx6TxphJcBhjwhucGWipNa2fVL5cHa24t9t1X4jBdayx4u+Mwl0hpGrGiFhrlgEyOiLc2nDxdCxPOrO2lXnOXwnMcNIaPpwmyS0d9fpaUFDVfV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDRXk7Zf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDRXk7Zf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DB81F000FF;
	Sat, 10 Oct 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791663595;
	bh=gSqyHzqVLh6H3eHx5dwm5uOnxVfuLcQn/cTriI1PRO0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KDRXk7Zf1VOsdpohEb0nGXV2P3KVOwEPaQiRXCWqYyNKZSqt9pPtZcmQkyCNwZP4i
	 jLjD2FL9JFMEGq4FwJ9msjdUFjPUugkj8FpmvE+33UuygpS7b3/MxsYGZTEZnsqrEt
	 fI38LlrItq1ZOCIv5XpQYU/0WeUn6M+qGpAH28kbWJTj3SrF/tCoq5f+FBOjx/t0Yt
	 Aatq33YST6wVJzOXnn0cmhfL+IHnh+o10mD0OVOYaJ8j/X0Pr+2GbT2+ByPGH5OKpr
	 M/EAu9INxpQBqxorJ3YQgkEni8A4K1Yd34pO5diFmCdNCxbuVTUpUl4GodwXKtgB44
	 F0re1/ibhNdow==
Subject: Re: [PATCH net v7 1/4] net: hsr: keep GRO disabled on HSR/PRP ports
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com
Date: Sat, 10 Oct 2026 20:19:53 +0000
Message-ID: <179166359381.434549.275581842542112020@kernel.org>
In-Reply-To: <20261009201324.17-2-xiexinet@gmail.com>
References: <20261009201324.17-2-xiexinet@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new HSR filter in __netdev_update_features()
  (net/core/dev.c) removes NETIF_F_GRO from dev->features but leaves it…
- [Low] (Baseline: not confirmed as a remaining bug.) The GRO policy only
  clears NETIF_F_GRO on the device directly enslaved to HSR/PRP.

--

net: hsr: keep GRO disabled on HSR/PRP ports

This patch adds a hsr_port role bit to struct net_device. While the bit
is set, __netdev_update_features() filters NETIF_F_GRO and configurable
NETIF_F_GRO_HW out of the computed features and leaves wanted_features
alone. HSR sets the role before it registers the RX handler and rejects
the port if software GRO stays on. On failure or detach it clears the
role and recomputes features.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 18dc88990510a..0c53b59af439a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11111,6 +11111,16 @@ int __netdev_update_features(struct net_device *dev)
>  
>  	features = netdev_get_wanted_features(dev);
>  
> +	/* A direct HSR/PRP port needs per-frame metadata: filter
> +	 * software GRO and configurable GRO_HW requests before the
> +	 * driver fix runs, keeping the existing driver and core
> +	 * feature coupling.
> +	 */
> +	if (dev->hsr_port) {
> +		features &= ~NETIF_F_GRO;
> +		features &= ~(dev->hw_features & NETIF_F_GRO_HW);
> +	}

[Severity: Critical]
Can this leave veth's NAPI state out of sync? After this filter runs,
NETIF_F_GRO is clear in dev->features but still set in
dev->wanted_features. veth depends on those two agreeing.

veth_set_features() adds or deletes NAPI when the effective GRO bit
changes:

drivers/net/veth.c:veth_set_features() {
    ...
	if (!(changed & NETIF_F_GRO) || !(dev->flags & IFF_UP) || priv->_xdp_prog)
		return 0;
    ...
	} else {
		...
		veth_napi_del(dev);
	}
}

veth_open() and veth_close() (and the xdp enable/disable paths) decide
whether NAPI exists from wanted_features instead:

drivers/net/veth.c:veth_gro_requested() {
	return !!(dev->wanted_features & NETIF_F_GRO);
}

drivers/net/veth.c:veth_close() {
    ...
	else if (veth_gro_requested(dev))
		veth_napi_del(dev);
}

Take veth0 that is up with gro on and gets added as an HSR slave. This
call chain deletes the NAPIs:

hsr_portdev_role_set()->netdev_change_features()->veth_set_features()

A later "ip link set veth0 down" or "ip link del veth0" then reaches
veth_close(). veth_gro_requested() is still true, so veth_napi_del() runs
a second time.

Wouldn't napi_disable_locked() then spin forever while holding RTNL and
the instance lock? The first disable left NAPIF_STATE_SCHED and
NAPIF_STATE_NPSVC set.

The reverse order looks like a problem as well. Suppose veth0 has gro on
while it is down, gets attached, and is then brought up. veth_open()
enables NAPI because of wanted_features. On detach,
hsr_portdev_role_clear() restores NETIF_F_GRO in features, and
veth_set_features() calls veth_napi_enable() again.

Would that hit the WARN_ON for an already listed NAPI in
netif_napi_add(), overwrite and leak the existing page_pool and
ptr_ring, and then hit BUG_ON(!test_bit(NAPI_STATE_SCHED, &val)) in
napi_enable_locked()?

Both sequences only need CAP_NET_ADMIN in a network namespace, and the
HSR selftests use veth slaves. No later patch in the series touches veth
or this filter.

[ ... ]

> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index a546f70f9cc8b..1afcacac6b3c8 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c

[ ... ]

> @@ -169,6 +197,19 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
>  	if (res)
>  		goto fail_upper_dev_link;
>  
> +	/* Enable the member role and recompute before the RX handler
> +	 * is published: software GRO must be off before frames can
> +	 * arrive.  A still-active software GRO rejects the port, a
> +	 * remaining GRO_HW alone does not.
> +	 */
> +	hsr_portdev_role_set(dev);
> +	if (dev->features & NETIF_F_GRO) {

[Severity: Low]
Does this check cover stacked members such as bond, team, macvlan or
ipvlan, which hsr_check_dev_ok() accepts? For those devices GRO runs on
the lower physical device. NETIF_F_UPPER_DISABLES is only NETIF_F_LRO,
so nothing pushes GRO-off down to the lower device.

GRO-merged skbs can then still reach hsr_handle_frame() when
bond_handle_frame() or macvlan_handle_frame() returns
RX_HANDLER_ANOTHER, and this check still passes. For stacked members,
the comment's statement that "software GRO must be off before frames can
arrive" does not hold.

The commit message already says GSO skbs may still arrive. The later
commit "net: hsr: segment GSO before per-frame forwarding" adds
hsr_forward_input(), which segments any skb_is_gso() input before
per-frame processing. By the end of the series the merged frames are
therefore handled.

Could the comment say that only direct members are covered?

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "software GRO still on after feature update, cannot join");
> +		res = -EBUSY;
> +		goto fail_role_policy;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009201324.17-1-xiexinet%40gmail.com
