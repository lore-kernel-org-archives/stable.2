Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751765;
	b=nMIU95NiTlLd1U4U5RBrueMEomFqEogMtYAuMJ1bybIAlHvkA7QDtwoxbmfrEHL5+LwT
	 qLAJtaS1dlkkleDatFVOf7WD5ijFX5F0UpC7ciqrAgrG1qCgi1ojfqZglO8sUtRK+Ixbt
	 rTwikc2EshFMX0gO/EaJE6FQL1ey4Jxz6XyFawHyL+GZg3rKz+v65QFh6TEjFMCgnemfD
	 J2IXhMxfjJu3pJmA/hXPJh6C/lt0YDnqxPU40hf76PzZPwc3W2w6308DaTKhkFOHWDvwz
	 CsONmaqMCzq+lSWPuVVEZRTctW1bfNN3jWIf4uentRMLgUFSKxoUugFl9kmbmYXCEbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751765;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ecV1Mn61d4C7zbWXxRrySVT5Vwg0HwNlFGUl3ZjUNAI=;
	b=i5y+pRbZtG6/FQI6EqN9u0q9oL/ZvQMQX1L7SVxeb5Uy73Q6jLoVU4wg8heIAarcFFmm
	 4exgSKaJUzfXZw06HpqR5x+PILUoGzixnK4Ie4EsiX8JXbUURVOXfc4XpcjyTSYJVIKF0
	 WyFmPfIn+6uGhSRBPo4SbThxpfc0BWfCqo1uq/DvWoirC/qAITXYVfxwJoR42N62O6RV4
	 BDfcZ+L9vAShuDvdNGlGwmcZkevOSM1S8+S9umgkXrVAdnAjikVIO5lZvq8RuxXD6LfhE
	 Lv2e+B7hv/roaA1Dj0L1CWw4POZZiMP7KHGZ1rej3CAIMgTHQO3WiqYdnHct+3Gq9Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtbyiyGc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D23606A31C;
	Fri, 27 Nov 2026 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtbyiyGc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9551F00893;
	Fri, 27 Nov 2026 03:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795751764;
	bh=ecV1Mn61d4C7zbWXxRrySVT5Vwg0HwNlFGUl3ZjUNAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XtbyiyGcsAelw8bsNqIBiXSTLCzw4/yWjsJkSTfRKPf2JqsO4o8qAjOqIaHjdo0cN
	 RAqQnAnz6yuuZsfiw0xZDzVfM1qVmLf3s4GDi3bdou7whaNXL8pqzY6018FYQ1L85k
	 RoMgUNbKt0N2Qo/Gc0XiVh6Fewtq5lVp/KquB/myo04fQfD6O1BhD/rUI6VaN5bSVR
	 KuSwQXBhKerT0hSvOtDGiR+LfP40Q6OxK6spm0sJpRDm+NfLQ0gv5AAdIllpF0E+29
	 c/56kA+JrU930/zsftYIvfFYal8DtKepXa9GoPKo0JrPXdD9k0japov3IheVDwowW4
	 7WlMal4iBdkBw==
Subject:
 Re: [PATCH net v4] net: fix stale header length after erspan version change
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 yanhaishuang@cmss.chinamobile.com, horms@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Fri, 27 Nov 2026 03:56:03 +0000
Message-ID: <179575176385.3135.13634272345163080513@kernel.org>
In-Reply-To: <20261126031224.430850-1-bsdhenrymartin@gmail.com>
References: <20261126031224.430850-1-bsdhenrymartin@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A failed erspan_changelink() now leaves the tunnel with a header
  length for the new version but o_flags from the old configuration.
- [High] erspan_calc_hlen() sets tun_hlen=8 for every ERSPAN v1/v2
  tunnel, which assumes a GRE sequence word is always emitted.
- [High] erspan_changelink() updates the fields the transmit path depends
  on as separate plain stores, holding only RTNL, while erspan_xmit()…
- [Medium] The commit message says the patch mirrors the IPv6 side, but
  the IPv4 and IPv6 changelinks now behave differently when a request is…
- [Low] The new `dev->needed_headroom += hlen;` in erspan_changelink() is
  a plain, unannotated read-modify-write of dev->needed_headroom.

--

net: fix stale header length after erspan version change

This commit moves the ERSPAN header length calculation out of
erspan_tunnel_init() into a new erspan_calc_hlen() helper. The helper is
then called from erspan_changelink() right after erspan_netlink_parms(),
before its error is checked. needed_headroom and mtu are adjusted by the
difference.

Link: https://lore.kernel.org/netdev/20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com/
Link: https://lore.kernel.org/netdev/20261124014646.7954-1-yanhaishuang@cmss.chinamobile.com/

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 5485586fa0e62..16f52b9e77b35 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1351,7 +1351,7 @@ static const struct net_device_ops gre_tap_netdev_ops = {
>  	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
>  };
>  
> -static int erspan_tunnel_init(struct net_device *dev)
> +static void erspan_calc_hlen(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  
> @@ -1360,9 +1360,16 @@ static int erspan_tunnel_init(struct net_device *dev)
>  	else
>  		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */

[Severity: High]

tun_hlen is now picked from erspan_ver alone on every changelink. That
assumes a GRE sequence word is always emitted for v1/v2. Does the
non-collect_md transmit path guarantee that?

erspan_xmit() copies tunnel->parms.o_flags and clears KEY for v1/v2. It
never sets IP_TUNNEL_SEQ_BIT. gre_build_header() pushes tun_hlen bytes,
but it only fills the trailing word when SEQ (or KEY/CSUM) is set.

erspan_validate() only checks the OR of the two flag attributes:

net/ipv4/ip_gre.c:erspan_validate() {
    ...
	if (data[IFLA_GRE_OFLAGS])
		flags |= nla_get_be16(data[IFLA_GRE_OFLAGS]);
	if (data[IFLA_GRE_IFLAGS])
		flags |= nla_get_be16(data[IFLA_GRE_IFLAGS]);
	if (!data[IFLA_GRE_COLLECT_METADATA] &&
	    flags != (GRE_SEQ | GRE_KEY))
		return -EINVAL;
    ...
}

So a v0 tunnel changed to v1 with IFLAGS=SEQ|KEY and no OFLAGS is
accepted. ipgre_netlink_parms() memsets parms, so p.o_flags has no SEQ,
and erspan_changelink() commits it at the end.

With this patch, that device gets tun_hlen == 8 and o_flags without SEQ:

erspan_xmit()
  __gre_xmit()
    gre_build_header(skb, tunnel->tun_hlen /* 8 */, flags /* no SEQ/KEY */, ...)

Would bytes 4..7 of every GRE header then go to the peer as unwritten
skb headroom? That is the leak the commit message describes. A v1/v2
device created the same way through newlink has the same gap.

erspan_fb_xmit() and ip6erspan_tunnel_xmit() both force SEQ before an
8-byte gre_build_header():

	__set_bit(IP_TUNNEL_SEQ_BIT, flags);
	gre_build_header(skb, 8, flags, proto, 0,
			 htonl(atomic_fetch_inc(&t->o_seqno)));

Should erspan_xmit() also set IP_TUNNEL_SEQ_BIT for v1/v2? Or should
tun_hlen be derived from the flags that are actually emitted?

>  
> -	tunnel->parms.iph.protocol = IPPROTO_GRE;
>  	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
>  		       erspan_hdr_len(tunnel->erspan_ver);
> +}

[ ... ]

> @@ -1509,11 +1517,28 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		return -EOPNOTSUPP;
>  	}
>  
> +	hlen = t->hlen;
> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;
>  
>  	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
> +
> +	/*
> +	 * ipgre_newlink_encap_setup() reset t->hlen without the ERSPAN part.
> +	 * Restore it before ip_tunnel_changelink() (and its
> +	 * ip_tunnel_bind_dev()) consumes it, and even when the parms above
> +	 * failed, so a failed changelink leaves no stale value for the next
> +	 * one to sample.
> +	 */
> +	erspan_calc_hlen(dev);

[Severity: High]

Can a failed changelink now leave the new version's tun_hlen paired with
the old o_flags?

erspan_netlink_parms() writes t->erspan_ver into the live tunnel before
its own checks run:

net/ipv4/ip_gre.c:erspan_netlink_parms() {
    ...
	if (data[IFLA_GRE_ERSPAN_VER]) {
		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);

		if (t->erspan_ver > 2)
			return -EINVAL;
	}

	if (t->erspan_ver == 1) {
		if (data[IFLA_GRE_ERSPAN_INDEX]) {
			t->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
			if (t->index & ~INDEX_MASK)
				return -EINVAL;
		}
    ...
}

erspan_calc_hlen() then runs before err is checked.
ip_tunnel_changelink() can also fail after it, with -EEXIST, -EINVAL or
-ENODEV. Every one of these returns skips the o_flags commit at the end
of erspan_changelink():

	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);

A v0 device can have o_flags without SEQ, because erspan_validate()
returns 0 early for version 0. Take a changelink on such a device with
ERSPAN_VER=1, IFLAGS=OFLAGS=SEQ|KEY and ERSPAN_INDEX=0x100000:

erspan_netlink_parms()
  t->erspan_ver = 1, returns -EINVAL
erspan_calc_hlen()
  tun_hlen = 8, hlen = 20
needed_headroom and mtu adjusted
return -EINVAL
  t->parms.o_flags still 0

erspan_xmit() then takes the v1 branch with flags copied from o_flags
(0). __gre_xmit() calls gre_build_header() with tun_hlen == 8 and no
SEQ/KEY/CSUM. gre_build_header() pushes 8 bytes but only writes
greh->flags and greh->protocol.

Would bytes 4..7 of every GRE header then reach the peer as
uninitialized skb headroom? Before this patch, the same failure path
left tun_hlen at 4.

The commit message says "a failed changelink must not leave the reset
value for the next call to sample". It doesn't mention that a failed
request now changes tun_hlen, needed_headroom and mtu.

Could the ERSPAN attributes be validated before any tunnel state is
written? Alternatively, erspan_ver/index/dir/hwid and the hlen values
could be saved and restored on every error return.

> +	hlen = t->hlen - hlen;
> +	if (hlen) {
> +		dev->needed_headroom += hlen;

[Severity: Low]

This is a plain read-modify-write of dev->needed_headroom, while the mtu
store next to it uses WRITE_ONCE(). Can it race with the datapath?

ip_tunnel_xmit() updates the same field locklessly:

include/net/ip_tunnels.h:ip_tunnel_adj_headroom() {
	headroom = ip_tunnel_limit_headroom(headroom);

	if (headroom > READ_ONCE(dev->needed_headroom))
		WRITE_ONCE(dev->needed_headroom, headroom);
}

Say changelink loads H0, xmit raises the value to H1, and changelink
then stores H0 + hlen. The datapath raise is lost. With a negative hlen,
the field can also drop below a value the datapath just set.

In practice this means extra skb reallocations and a KCSAN report.
ipgre_link_update() has the same unannotated pattern.

Would this work better here:

	WRITE_ONCE(dev->needed_headroom, READ_ONCE(dev->needed_headroom) + hlen)

ideally clamped with ip_tunnel_limit_headroom() as ip_tunnel_bind_dev()
does?

> +		if (!tb[IFLA_MTU])
> +			WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - hlen, 68));
> +	}
>  	if (err < 0)
>  		return err;

[Severity: Medium]

The commit message says this mirrors ip6erspan_tnl_change(). Does the
IPv4 failure path actually behave like the IPv6 one?

ip6erspan_changelink() parses into a local struct __ip6_tnl_parm. It
only applies the version and header length on success:

net/ipv6/ip6_gre.c:ip6erspan_changelink() {
    ...
	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
	if (IS_ERR(t)) {
		err = PTR_ERR(t);
		goto unlock;
	}

	ip6erspan_set_version(data, &p);
	...
	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
    ...
}

Here, needed_headroom and mtu are adjusted before err is checked, based
on whatever erspan_netlink_parms() already wrote into the live tunnel.
IFLA_GRE_ERSPAN_VER also has no range policy in ipgre_policy:

	[IFLA_GRE_ERSPAN_VER]	= { .type = NLA_U8 },

For example, take a changelink on a v1 device with ERSPAN_VER=3 and
SEQ|KEY flags. It sets t->erspan_ver to 3 and returns -EINVAL.

erspan_calc_hlen() then calls erspan_hdr_len(3), which returns the v2
size. needed_headroom grows and mtu shrinks by 4 before -EINVAL is
returned. From then on, erspan_xmit() drops every packet because
erspan_ver is 3.

A v1->v2 change with an invalid hwid likewise switches the version,
header length, headroom and mtu while reporting failure.

Doesn't this contradict the new comment's claim that "a failed
changelink leaves no stale value"?

Would it match the IPv6 behavior better to parse the ERSPAN attributes
into locals, and to commit them (plus the hlen/mtu/headroom update) only
on success? NLA_POLICY_MAX(NLA_U8, 2) for IFLA_GRE_ERSPAN_VER might also
help.

[Severity: High]

Is anything ordering these updates against the transmit path?

erspan_tunnel_init() sets dev->lltx, so erspan_xmit() runs without a
lock, while erspan_changelink() holds only RTNL. The fields are updated
as separate plain stores, in this order:

erspan_netlink_parms()
  t->erspan_ver = ...
erspan_calc_hlen()
  t->tun_hlen = ..., t->hlen = ...
ip_tunnel_changelink()
  ip_tunnel_update()
    netdev_state_change()
ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags)

erspan_xmit() reads tunnel->erspan_ver to pick the header and clear SEQ,
then reads o_flags. __gre_xmit() reads tunnel->tun_hlen separately for
gre_build_header().

On a v1->v0 change, xmit can see erspan_ver == 0 (SEQ and KEY cleared)
together with the old tun_hlen == 8. Four bytes of uninitialized
headroom then go out.

On a v0->v1 change where the old o_flags lack SEQ, xmit sees
erspan_ver == 1 and tun_hlen == 8 with the old o_flags for the whole
ip_tunnel_changelink() window. Every packet sent in that window has the
same 4-byte leak.

The opposite interleaving (new erspan_ver, old tun_hlen == 4, o_flags
with SEQ) writes the sequence number over the GRE base header.

The caller controls both the version toggling and the traffic. Doesn't
that turn the permanent leak into a repeatable race rather than remove
it?

Could erspan_xmit() compute the GRE header length locally from a single
READ_ONCE() of erspan_ver, and force SEQ for v1/v2? Or could version
changes be refused while the device is up?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126031224.430850-1-bsdhenrymartin%40gmail.com
