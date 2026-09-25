Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D97446050;
	Fri, 25 Sep 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319185; cv=none; b=eoCVCWJonAW12o+/tj3e8KfENmyic+uXog7MmJZ3weUVVB7R94R8vCONWrsRQzyjPfDUAWsF4/d0VQ3r8MlqDssGy1uIbbbbsVA99/RzGyQk/dwmfMAfeFe9pmxo1Bjn4kLAvyze0cCGgbY+HCnTgPvcyQvyLFuDm65fXIGk1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319185; c=relaxed/simple;
	bh=l+M1aIdf1qltxhmc7G99LZM8V7dMLV7Om0FaJDX6uJs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVt0M0DoruwS4P/MnhswrYwPDkCAfxbb0lord3z4ioT1qsVh6wn2SSqjXC/GMzZ78MEIabYPfRCnUBrpMfnHEMtyhTutZyJ2oab4GZ/adrp0bo+zmsL+94/d8MLxqnOrHAy6I7VlnrwUmvqdoEYEXlqmh4F4/P3le3VtN3CUsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acjnpDMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acjnpDMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656251F00899;
	Fri, 25 Sep 2026 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319180;
	bh=SGo08a24VJM3OkiZ0uXNfdZsD8lXrdn5O/SyzaLlmyM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=acjnpDMM5ADyHMHQMnXAFoBrVo0/WWN+SODHiqoPRmbvFvemK54dYcvWI6zVkDDBk
	 2n9lRzGF+fL8HDcUf5gycsDRj3Qk/+OPCNKx1hgxU4t5c90QXjRynoPDP+SRGNMntO
	 JuAU8aAqEZlcj2CMXPjwCAHzV2iascBmGHCQPihsk6Z64+wTNpjj4yFOEslsMKlm2L
	 c74Qq3Eo06QtCbDJAIaERP5Px6n92QbM3ex10k8nHYjBWfbi7/aIB4EZ0+rTigdG77
	 G39eWCGgY0uznhWsLsEm1kjovWfQtgXPaTPE8rIpkUNZtPURQ1AgHOXYgeagG3OMQg
	 hRbWEcblCg07g==
Subject: Re: [PATCH net v3 2/5] ip_gre: validate netlink attributes before
 changing the tunnel
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 u9012063@gmail.com, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 06:52:59 +0000
Message-ID: <179031917994.2160803.8147129617218457739@kernel.org>
In-Reply-To: <20260923035217.179102-3-edumazet@google.com>
References: <20260923035217.179102-3-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 3 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ipgre_changelink() and erspan_changelink() still apply the new
  encapsulation to the live tunnel before ip_tunnel_changelink(), and…
- [Low] The commit message misstates how the COLLECT_METADATA changelink
  bug works.
- [Low] The patch adds a new check to ipgre_newlink_encap_setup() that
  the commit message does not mention: `if (t->collect_md &&…
- [Low] The patch moves ipgre_commit_parms() after
  ip_tunnel_changelink().

Pre-existing issues:
- [Medium] When erspan_changelink() succeeds, ipgre_commit_parms() writes
  the new t->erspan_ver, but tunnel->tun_hlen and tunnel->hlen are not…
- [Low] ipgre_commit_parms() writes t->erspan_ver, t->index, t->hwid,
  t->dir and t->ignore_df as separate plain stores under RTNL only.

--

ip_gre: validate netlink attributes before changing the tunnel

This commit stages the GRE and ERSPAN netlink attributes in a new local
struct ip_gre_parm. It commits them to the tunnel only after
ip_tunnel_changelink() succeeds. It also rejects enabling
IFLA_GRE_COLLECT_METADATA on an existing tunnel during changelink, and
moves encap setup after parameter validation in the changelink handlers.

> 1. ipgre_netlink_parms() sets t->collect_md = true and changes dev->type
>    from ARPHRD_IPGRE to ARPHRD_NONE before validating IFLA_GRE_IGNORE_DF
>    or running ip_tunnel_changelink(). Moreover, unlike ipip_changelink()
>    and ip6_tnl_changelink(), it accepts IFLA_GRE_COLLECT_METADATA during
>    changelink even though ip_tunnel_changelink() never registers the
>    tunnel as itn->collect_md_tun; a subsequent ip_tunnel_del() then
>    clears itn->collect_md_tun and blackholes the netns metadata tunnel.

[Severity: Low]
Is the "never registers" part accurate for the success path?

Before this patch, ipgre_netlink_parms() set t->collect_md = true before
ip_tunnel_changelink() ran. On success, ip_tunnel_changelink() calls
ip_tunnel_update(), which calls ip_tunnel_del() and then
ip_tunnel_add():

net/ipv4/ip_tunnel.c:ip_tunnel_add() {
    ...
	if (t->collect_md)
		rcu_assign_pointer(itn->collect_md_tun, t);
    ...
}

net/ipv4/ip_tunnel.c:ip_tunnel_del() {
	if (t->collect_md)
		rcu_assign_pointer(itn->collect_md_tun, NULL);
    ...
}

So a successful changelink evicts any existing metadata tunnel in the
netns and registers this tunnel in its place. Deleting either device
afterwards clears the slot.

The tunnel only ends up with collect_md set but unregistered on the
failure paths. These are the IFLA_GRE_IGNORE_DF -EINVAL, an encap setup
error, or ip_tunnel_changelink() failing before it reaches
ip_tunnel_update().

The fix itself looks correct. Since this is Cc: stable, could the
description also cover the success-path takeover of itn->collect_md_tun?

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 82309efd417e0..df4d2f1f1d60c 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1183,15 +1183,41 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
>  	return 0;
>  }
>  
> +struct ip_gre_parm {
> +	__u32	fwmark;
> +	u32	index;
> +	u16	hwid;
> +	u8	erspan_ver;
> +	u8	dir;
> +	bool	ignore_df;
> +};
> +
> +static void ipgre_commit_parms(struct ip_tunnel *t,
> +			       const struct ip_gre_parm *gparms)
> +{
> +	t->ignore_df = gparms->ignore_df;
> +	t->erspan_ver = gparms->erspan_ver;
> +	t->index = gparms->index;
> +	t->hwid = gparms->hwid;
> +	t->dir = gparms->dir;
> +}

[Severity: Low]
This isn't a bug introduced by this patch, but these are plain stores
made under RTNL only. The i_flags/o_flags copies follow as separate
steps. erspan_xmit() and __gre_xmit() read the same fields without
synchronization.

Can a transmit that races with changelink build a packet that mixes a
new erspan_ver with the old index or hwid, or with the old tun_hlen?

The old code had the same unsynchronized writes in
erspan_netlink_parms(), and this patch doesn't widen the window. At
worst, headers could be malformed for a short time during
reconfiguration, and KCSAN could report the plain concurrent accesses.

[ ... ]

> @@ -1401,7 +1431,12 @@ ipgre_newlink_encap_setup(struct net_device *dev, struct nlattr *data[])
>  
>  	if (ipgre_netlink_encap_parms(data, &ipencap)) {
>  		struct ip_tunnel *t = netdev_priv(dev);
> -		int err = ip_tunnel_encap_setup(t, &ipencap);
> +		int err;
> +
> +		if (t->collect_md && ipencap.type != TUNNEL_ENCAP_NONE)
> +			return -EINVAL;

[Severity: Low]
The commit message doesn't mention this check. Is it meant as a
separate behavior change?

In ipgre_newlink() and erspan_newlink(), ipgre_newlink_encap_setup()
runs before ipgre_netlink_parms() sets t->collect_md, so the check can't
fire when the device is created. For creation, ipgre_tunnel_validate()
already rejects COLLECT_METADATA combined with a non-NONE ENCAP_TYPE in
the same request.

The check only takes effect in ipgre_changelink() and
erspan_changelink(). There, ipgre_netlink_parms() now runs first and
t->collect_md is live device state.

Consider a changelink on an existing external GRE/GRETAP/ERSPAN device
that sets IFLA_GRE_ENCAP_TYPE to FOU or GUE and omits
IFLA_GRE_COLLECT_METADATA. That request used to be accepted and now
fails with -EINVAL.

The restriction may well be right, since ip_md_tunnel_xmit() uses
tun_info->encap and not t->encap. Could the commit message describe
this userspace-visible change and explain why it is needed, given the
stable tag?

> +
> +		err = ip_tunnel_encap_setup(t, &ipencap);
>  
>  		if (err < 0)
>  			return err;

[ ... ]

> @@ -1458,24 +1495,25 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  {
>  	struct ip_tunnel *t = netdev_priv(dev);
>  	struct ip_tunnel_parm_kern p;
> -	__u32 fwmark = t->fwmark;
> +	struct ip_gre_parm gparms;
>  	int err;
>  
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
>  		return -EPERM;
>  
> -	err = ipgre_newlink_encap_setup(dev, data);
> -	if (err)
> +	err = ipgre_netlink_parms(dev, data, tb, &p, &gparms, false);
> +	if (err < 0)
>  		return err;
>  
> -	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
> -	if (err < 0)
> +	err = ipgre_newlink_encap_setup(dev, data);
> +	if (err)
>  		return err;
>  
> -	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
> +	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
>  	if (err < 0)
>  		return err;

[Severity: Medium]
ipgre_newlink_encap_setup() still applies the new encapsulation to the
live tunnel before ip_tunnel_changelink(), and that call can still fail.
Does this error return leave the device with the new encap and the old
parameters?

ipgre_newlink_encap_setup()->ip_tunnel_encap_setup() writes straight to
the tunnel:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
    ...
	t->encap.type = ipencap->type;
	t->encap.sport = ipencap->sport;
	t->encap.dport = ipencap->dport;
	t->encap.flags = ipencap->flags;

	t->encap_hlen = hlen;
	t->hlen = t->encap_hlen + t->tun_hlen;
    ...
}

After that, ip_tunnel_changelink() can still fail, for example here:

net/ipv4/ip_tunnel.c:ip_tunnel_changelink() {
    ...
	if (dev == itn->fb_tunnel_dev)
		return -EINVAL;

	t = ip_tunnel_find(itn, p, dev->type);

	if (t) {
		if (t->dev != dev)
			return -EEXIST;
    ...
}

It can also return -EINVAL on an IFF_POINTOPOINT/IFF_BROADCAST
mismatch.

Take "ip link set gre0 type gre encap fou encap-dport N" on the fallback
device, or pointing gre2 at gre1's remote while also adding "encap fou".
Both return an error, but the device now sends FOU/GUE-encapsulated
traffic with its old parms, fwmark, flags and gparms. This patch also
doesn't refresh the MTU or needed_headroom on this error path.

The commit message says the attributes are committed "only after
ip_tunnel_changelink() has succeeded", but the encap is still committed
before that point. erspan_changelink() uses the same ordering.

Later patches in the series ("ip_gre: compute tunnel lengths absolutely
instead of by delta" and "ip_gre: recompute erspan header lengths after
a change") only refresh the lengths on the error path. The partially
applied encap is therefore still there at the end of the series.

Could the encap be staged too, and applied only after
ip_tunnel_changelink() succeeds?

>  
> +	ipgre_commit_parms(t, &gparms);
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);

[Severity: Low]
ip_tunnel_changelink()->ip_tunnel_update() ends with
netdev_state_change(dev). That runs the NETDEV_CHANGE notifiers and
sends an RTM_NEWLINK built by ipgre_fill_info() or erspan_fill_info().

With ipgre_commit_parms() now after that call, does the notification
report the old t->ignore_df? For ERSPAN, does it also report the old
erspan_ver, index, dir and hwid?

Before this patch, those fields were written ahead of
ip_tunnel_changelink(), so the first notification had the new values.
rtnl_changelink() sets DO_SETLINK_NOTIFY, so do_setlink() sends a
second, correct notification afterwards. Listeners still see one
transient RTM_NEWLINK with stale values. The ordering is unchanged at
the end of the series.

> @@ -1490,24 +1528,25 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],

[ ... ]

> -	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
> +	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
>  	if (err < 0)
>  		return err;
>  
> +	ipgre_commit_parms(t, &gparms);
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);

[Severity: Medium]
This is a pre-existing issue, but when erspan_changelink() succeeds with
a different IFLA_GRE_ERSPAN_VER, ipgre_commit_parms() updates
t->erspan_ver and does not recompute tunnel->tun_hlen or tunnel->hlen.
In this patch those are derived from erspan_ver only in
erspan_tunnel_init():

net/ipv4/ip_gre.c:erspan_tunnel_init() {
    ...
	if (tunnel->erspan_ver == 0)
		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
	else
		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
    ...
}

__gre_xmit() builds the GRE header from tunnel->tun_hlen. Can a v0 to
v1/v2 change then produce malformed headers, with the sequence number
overwriting the flags/protocol, plus the wrong MTU and headroom?

The old code also changed erspan_ver without recomputing these lengths.
A later patch in the series, "ip_gre: recompute erspan header lengths
after a change", fixes this by calling erspan_link_update() from
erspan_changelink().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923035217.179102-1-edumazet%40google.com
