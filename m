Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525852;
	b=VzcQdIAsO7M+Os8rqNU2P/wt5H+oxKsrVEhXPKZr8bL9vCi5jdNZoQLxJr+DJzP815Qx
	 9tTnHN+Kecjd/KPCJF2nImtwF6t9EP2iJ74ASTulkimzmz5RTyfSqSjSoWTCW9gJfWCpc
	 Jw/YPfWqXaE/LDXM5a6RFxI3zab9sUzAPVzg+DuEJicRJdwSf5OITrLKqFd+DcjGMGnw9
	 1tNxQwPI61S4071SB2Tu/gKLyD4Y5TM6fsttSJz1AGLMwEkHD9SsAxEdxG95f1ry9Me7X
	 K3vEUFHIC5XEEqPN+OJxCLVFZH5OAakpL18v2qz1V/w39TTEhbxpoN+a7COTmFK89Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525852;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VblNmDy1pTq5RL0MSahF61gU6VHrFjsp5tATY9PSzZ4=;
	b=Ab9y7AqO9FMSGPyKLHTDrwubHDqzIYrJQuK21hZL74A5ymwjsHqcTfFnMLFGwS85eJFU
	 Kq8EVOwmRoImc0Ra99slqGk2HGcXV4vW4d8rwJFHCXajnJGniB5pi4rTZ1OTXq92V2y7c
	 p2eRcNVdNGdCwRBEhZloti6TXLP2e7GI8j4/0sFtp1bWNWtFGcsdJMEzDhnRGI9xZsAau
	 c8YZQbEWwZffYsyXwCCoKGM4MFY430eY7PgADvLXP00H6vHydmXycYhB4JLe2Ll3NMd2a
	 ZJijjkCxd2U1BRWOeBmVh213kdxP0T2pYc0Urem3aXi8Sf4QOgSihLCmdWZ2n2euEIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFPFkzX0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF0606A31E;
	Tue, 24 Nov 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFPFkzX0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41A1F000C0;
	Tue, 24 Nov 2026 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525852;
	bh=VblNmDy1pTq5RL0MSahF61gU6VHrFjsp5tATY9PSzZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kFPFkzX0zBC0EG2IUEQ6KIxVYvyJDMh/KtDPrendHdplukYPNKta4Dis9yFvpVxEq
	 UFhoyMMybPe7I07yeI21fnBsDAYzlnqHdkjIgk/neJmMFuPcSajURMiiPVIc6/TU2s
	 VOFc6fxajtddQtnnZq/rzGY+gYBjseSBxSk/DDKDmNGv0HfdQV9uVNy3/XArOKkmfp
	 hEdQuttVnLWjIlMw42ldD/31godteRLvPBE2MlArgZxZoX50Y71/3lQUJPQSstHUH8
	 gUNyKClZU6C6khubdrNKQgYdi7nm7AAf5BTZImdw4N7UTRvEBf7A6xHo8ZWrtIzJp2
	 RUyvIssk7E4/g==
Subject: Re: [PATCH net v2] ip_gre: fix stale header length after erspan
 version change
From: netdev-bot+sashiko@kernel.org
To: bsdhenrymartin@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 yanhaishuang@cmss.chinamobile.com, horms@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 13:10:50 +0000
Message-ID: <179552585089.3135.2845947180568348975@kernel.org>
In-Reply-To: <20261123123529.3183627-1-bsdhenrymartin@gmail.com>
References: <20261123123529.3183627-1-bsdhenrymartin@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: every error return in erspan_changelink()
  (net/ipv4/ip_gre.c) skips the new erspan_calc_hlen() call, but two…
- [High] In erspan_changelink() (net/ipv4/ip_gre.c), the new delta
  adjustment is wrong whenever the same request changes IFLA_GRE_LINK or…
- [Medium] erspan_changelink() still updates the ERSPAN version and the
  GRE header length as separate, unsynchronized stores, while the TX…
- [Low] The new code in erspan_changelink() (net/ipv4/ip_gre.c:1540) does
  a plain read-modify-write, `dev->needed_headroom += hlen`, while…

--

ip_gre: fix stale header length after erspan version change

This patch moves the ERSPAN header length calculation out of
erspan_tunnel_init() into a new helper, erspan_calc_hlen(). The helper is
now also called from erspan_changelink(), so switching versions on an
existing tunnel updates tun_hlen and hlen. The difference between the old
and new hlen is then added to needed_headroom and, unless IFLA_MTU was
given, to the MTU.

Link: https://lore.kernel.org/netdev/20261123062752.27920-1-yanhaishuang@cmss.chinamobile.com/

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 5485586fa0e62..2a1d6ff16dfe1 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c

[ ... ]

> @@ -1509,6 +1517,8 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		return -EOPNOTSUPP;
>  	}
>  
> +	hlen = t->hlen;
> +
>  	err = ipgre_newlink_encap_setup(dev, data);
>  	if (err)
>  		return err;

[Severity: High]
What state are t->hlen and t->erspan_ver left in if one of the later
error returns in erspan_changelink() is taken?

By this point ipgre_newlink_encap_setup()->ip_tunnel_encap_setup() has
already rewritten t->hlen, and the new value leaves out the erspan header:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
    ...
	WRITE_ONCE(t->encap_hlen, hlen);
	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);
    ...
}

erspan_netlink_parms() also writes the live version before it validates
the version, index, dir and hwid:

	if (data[IFLA_GRE_ERSPAN_VER]) {
		t->erspan_ver = nla_get_u8(data[IFLA_GRE_ERSPAN_VER]);

		if (t->erspan_ver > 2)
			return -EINVAL;
	}

Both of the remaining error returns skip the new erspan_calc_hlen() call:

	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
	if (err < 0)
		return err;

	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
	if (err < 0)
		return err;

ip_tunnel_changelink() can return -EEXIST when ip_tunnel_find() matches
another tunnel. It can also return -EINVAL on the fallback device, or
-ENODEV.

Take a v1 tunnel that is given erspan_ver 0 with local/remote/key values
that collide with another erspan tunnel. ip_tunnel_changelink() returns
-EEXIST, and the tunnel is left with erspan_ver == 0 and tun_hlen == 8.
erspan_xmit() then clears SEQ and KEY, and
__gre_xmit()->gre_build_header() pushes 8 bytes but writes only 4.

Doesn't that leave the leak of uninitialized headroom described in the
commit message still reachable?

The reverse case looks similar. A v0 tunnel given erspan_ver 1 with an
out-of-range IFLA_GRE_ERSPAN_INDEX ends up with erspan_ver == 1 and
tun_hlen == 4.

The next successful changelink is affected as well. After a failed call,
t->hlen lacks erspan_hdr_len() while needed_headroom and mtu are
unchanged. The next call samples that value as its baseline, and
erspan_calc_hlen() adds erspan_hdr_len() back. The delta is then +12 (v1)
or +16 (v2) even when nothing changed.

Can repeated failed/successful pairs walk the MTU down to 68 and keep
growing needed_headroom? That is the drift the v1 -> v2 notes describe as
fixed.

The commit message says this mirrors the IPv6 side.
ip6erspan_changelink() only applies the version, via
ip6erspan_set_version(data, &p), after ip6gre_changelink_common() has
succeeded. Would it work to stage version/index/dir/hwid in locals and
commit them only after ip_tunnel_changelink() succeeds? Recomputing hlen
on every error path might also work.

[ ... ]

> @@ -1524,6 +1534,14 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
>  
> +	erspan_calc_hlen(dev);

[Severity: Medium]
Can the lockless transmit path see the new erspan_ver together with the
old tun_hlen?

erspan_tunnel_init() sets dev->lltx, so erspan_xmit() runs without RTNL
or any tunnel lock. erspan_netlink_parms() stores t->erspan_ver early.
tun_hlen only changes here, after ip_tunnel_changelink() has taken
tunnels_lock, rehashed the tunnel and run the netdev_state_change()
notifiers.

During a v1 -> v0 change:

CPU0 (changelink)                CPU1 (erspan_xmit)
erspan_netlink_parms()
  t->erspan_ver = 0
                                 reads erspan_ver == 0
                                 clears SEQ and KEY
                                 __gre_xmit()
                                   gre_build_header(skb, tun_hlen == 8, ...)
ip_tunnel_changelink()
erspan_calc_hlen()
  tun_hlen = 4

Would packets sent in that window still get 8 bytes pushed and only 4
written?

Reordering the stores in changelink does not seem to close this, because
the transmit path reads erspan_ver and tun_hlen separately. Would the
transmit path need to derive the GRE length from a single
READ_ONCE(tunnel->erspan_ver) snapshot? These plain write/lockless read
pairs are also unannotated data races.

A similar window already exists for plain GRE in
ipgre_changelink()/ipgre_link_update(), where o_flags is copied before
tun_hlen is updated.

> +	hlen = t->hlen - hlen;
> +	if (hlen) {
> +		dev->needed_headroom += hlen;

[Severity: Low]
This is a plain read-modify-write of dev->needed_headroom with only RTNL
held. The transmit path updates the same field locklessly through
ip_tunnel_xmit()->ip_tunnel_adj_headroom():

	if (headroom > READ_ONCE(dev->needed_headroom))
		WRITE_ONCE(dev->needed_headroom, headroom);

Could a concurrent transmit overwrite the adjustment made here, or could
this store overwrite a transmit-side increase? It is also an unannotated
data race, unlike the WRITE_ONCE(dev->mtu, ...) just below.

ipgre_link_update() and ip_tunnel_bind_dev() already use plain writes for
this field, so this follows existing practice in the file.

> +		if (!tb[IFLA_MTU])
> +			WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - hlen, 68));
> +	}

[Severity: High]
Is this delta still correct when the same request also changes
IFLA_GRE_LINK or IFLA_GRE_FWMARK?

In that case ip_tunnel_changelink()->ip_tunnel_update() calls
ip_tunnel_bind_dev(). That function sets needed_headroom and mtu from
tunnel->hlen as absolute values, not relative ones:

net/ipv4/ip_tunnel.c:ip_tunnel_update() {
    ...
		mtu = ip_tunnel_bind_dev(dev);
		if (set_mtu)
			WRITE_ONCE(dev->mtu, mtu);
    ...
}

At that point t->hlen still holds the in-between value left by
ip_tunnel_encap_setup(): tun_hlen_old + encap_hlen_new, without
erspan_hdr_len(). The delta here is computed against the hlen sampled
before encap setup, but it is added to values that bind_dev already
recomputed from the in-between hlen.

Take v1 -> v0 plus a link change, with no encap, on an ARPHRD_ETHER
device:

  sampled hlen = 20, in-between hlen = 8
  bind_dev: needed_headroom = 28 + LL, mtu = tdev_mtu - 42
  delta = 4 - 20 = -16
  result:   needed_headroom = 12 + LL, mtu = tdev_mtu - 26
  expected: needed_headroom = 24 + LL, mtu = tdev_mtu - 38

That leaves the MTU 12 bytes too large.

The result can also go negative. Consider a v2 tunnel with GUE encap,
switched to v0 with encap type none and moved to an underlay with zero
headroom. bind_dev sets needed_headroom to 28, then the delta of
-(20 + encap_hlen) is applied. Does that wrap the u16 needed_headroom?
Because this is an open-coded +=, it also skips the 512-byte cap in
ip_tunnel_limit_headroom().

The IPv6 counterpart recomputes headroom and MTU from the final hlen
rather than applying a delta. Would computing hlen before
ip_tunnel_changelink(), or recomputing these values the same way, avoid
mixing the two baselines?

>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123123529.3183627-1-bsdhenrymartin%40gmail.com
