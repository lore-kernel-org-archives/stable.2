Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD8481FD0;
	Thu, 10 Sep 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042852; cv=none; b=gGSFHlcDfNiSFk2yd7BaFhHQJaxzdK2MqKiJq9pE7DeMyE2+Ir52aLgB9BAtsHwwGAkKCo5VElMNdqKBUG/q9j9KhrcvusnxYXmHvCj5nTn8VOGcRCWSgvpXm/tSUnm6y5WrMUIp7CwUl/T61vSHkf9gPiuuSKPrTzn2CCg4a0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042852; c=relaxed/simple;
	bh=HTV7lEhku+ZVQP7S8qQuo8EkzkJ106Gt5+o3geSLmvQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/O1rJVsGL/J1GkGWE7CTvQKD6uHcuKXW80xi3n8IunYLGnoWhu+jVTgoijXkbUrF+i9rqIhamUNI44hz6PkzEvNO0g1cWWVr7RrKCcg2KYQQ1jT9fDUF/c7gGm1j/x1ox5ZEyZAlG9A8uTUOOxnH40fJcz0xbFNKmd4PVwKaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzna9YCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzna9YCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77EE1F000FF;
	Thu, 10 Sep 2026 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042850;
	bh=hQbuUOkfsrpnLf2md3WFaaGJC423ZhvVGk6gCVGQWeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kzna9YCzbHrIp/nEdDoCDe71FUy5s/TfPq9w0FlTlwLc07By4GwvD8mC54nfCG10a
	 UGifaeXWmLaooDiGcVq9+XgCU4FzFh6LogV/okR2QTWkfyWLFvM3XCVKgiBnhyxKgC
	 0kJxZo/CHwr1hT3HcRShkFNt636tnni77RbaNqgeH6n4JuBs9SEJ70ZyNKEc1BrSrn
	 C5NtW5G7iio5W7k+8tgSDyyclkNeCfZu7CB5e0LKx43ms6FYl0nwXXWHVzDIOFkB9L
	 bTbZWXsCC/qj0rebr4vmZPtw46BhAQW01ezxbNagmuaMMnNt++vJU9VmLuelr39l+0
	 MGMRDF/UjEEvA==
Subject: Re: [PATCH net] macsec: require CAP_NET_ADMIN in the device netns for
 changelink
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 12:20:49 +0000
Message-ID: <178904284935.219967.10266742419018601309@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB000190AAD82CD30EFBC57B4DC8B42=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB000190AAD82CD30EFBC57B4DC8B42=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The new gate in macsec_changelink()
  (drivers/net/macsec.c:3963) keys on the mere presence of…
- [Low] Commit-message inaccuracy plus check placement asymmetry: the
  message asserts that changelink is "the sole way to turn the real…

--

macsec: require CAP_NET_ADMIN in the device netns for changelink

This adds a capability check to macsec_changelink() so that a request which
would reach the driver of macsec->real_dev is refused unless the caller has
CAP_NET_ADMIN in dev_net(macsec->real_dev). The gate fires when
IFLA_MACSEC_OFFLOAD is present or when the device is already offloaded.

Two questions below, one about the commit message and one about the
condition itself.

>From the commit message:

>     Scope: this closes the changelink vector only, which is the sole way to
>     turn the real device's MACsec offload on or off, and the only way to push
>     changed SecY parameters to it.

[Severity: Low]
Is "the sole way to turn the real device's MACsec offload on or off"
accurate?  macsec_update_offload() has a second caller,
macsec_upd_offload() for MACSEC_CMD_UPD_OFFLOAD, and it reaches the same
driver callbacks on real_dev:

drivers/net/macsec.c:macsec_update_offload() {
	...
	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
					    : macsec_offload(ops->mdo_add_secy, &ctx);
	...
}

That path is not an unprivileged bypass, since the op carries

	{
		.cmd = MACSEC_CMD_UPD_OFFLOAD,
		...
		.flags = GENL_ADMIN_PERM,
	},

and genl_family_rcv_msg_permissions() resolves GENL_ADMIN_PERM through
netlink_capable() against &init_user_ns, so the namespace-local
administrator this patch is about cannot invoke it.

Still, would it be clearer to say changelink is the only unprivileged path
rather than the sole path?  And would placing the check inside
macsec_update_offload() make the two callers agree, instead of gating only
the rtnl one?

> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 6f9f3aceffaad..0f351e839f144 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c

[ ... ]

> @@ -3959,6 +3960,13 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (!data)
>  		return 0;
>  
> +	if ((data[IFLA_MACSEC_OFFLOAD] || macsec_is_offloaded(macsec)) &&
> +	    !rtnl_dev_link_net_capable(dev, dev_net(macsec->real_dev))) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Changing a MACsec device whose real device is in another network namespace requires CAP_NET_ADMIN in that namespace");
> +		return -EPERM;
> +	}
> +

[Severity: Medium]
Does this reject a request that touches nothing on real_dev?  The first
term keys on the presence of IFLA_MACSEC_OFFLOAD, not on whether the
requested value differs from macsec->offload.

For a non-offloaded macsec device whose real_dev is in another netns, a
request carrying IFLA_MACSEC_OFFLOAD = MACSEC_OFFLOAD_OFF now returns
-EPERM, yet neither of the two boundary-crossing blocks would have run:

drivers/net/macsec.c:macsec_changelink() {
	...
	if (data[IFLA_MACSEC_OFFLOAD]) {
		offload = nla_get_u8(data[IFLA_MACSEC_OFFLOAD]);
		if (macsec->offload != offload) {		/* false */
			macsec_offload_state_change = true;
			ret = macsec_update_offload(dev, offload, extack);
	...
	/* If h/w offloading is available, propagate to the device */
	if (!macsec_offload_state_change && macsec_is_offloaded(macsec)) {	/* false */
	...
}

So "ip link set macsec0 type macsec offload off encrypt off" from inside
the container, or any tool that re-states the current offload mode
alongside local attributes, succeeded before and fails now.

The commit message gives this as the reason for the narrower condition:

>     An unconditional gate also denies the third case, which is a needless
>     uAPI change; hence the narrower condition.

Does the narrower condition still deny that same class of purely local
request?  Would comparing nla_get_u8(data[IFLA_MACSEC_OFFLOAD]) against
macsec->offload, so the gate fires only on an actual transition, keep that
case working?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB000190AAD82CD30EFBC57B4DC8B42%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
