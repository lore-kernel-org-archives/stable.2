Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC842DA4D;
	Fri, 25 Sep 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319187; cv=none; b=jqPX3e7G8sXneRkXFAAnuqG7l2RBnWRyDrgbwhMsg1J8xW3gYEF2KU1rzEO6W4dsKpbY744+KFBjrEegR3LgifdRDt1Pp3AYoIubWDtRpCAKmMZg00CyJtxrm2xFssdy+R4cJIida7vDZCogtFGgkfcyrnOKIGS+T4vpxh7Ykvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319187; c=relaxed/simple;
	bh=S28qaEKBBgwsqPq99AxpJIWEf/29CGV6SexYoTNyrIc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eUerc6na4K92A6+vBsd+uGoIxzS5Vdf+dQlF5ZYPYS7Hjy0A4h3WyLZUnBYlpjnUE0PELtHYcqp9NBTSAZVhtuTcM1SHaYXQqG7iRZCEBbI5/8YR0H6flKEsbtaGrQCDbyMzxFPxydHTPOJQyHr9jeQo3FpJJ0X0QlQYlvnYkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqsI093C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqsI093C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2691F0089B;
	Fri, 25 Sep 2026 06:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790319183;
	bh=ZgEsDQ0AQIMoFzXa+NVXb80/XR9A2SVuIMRHtfzsqg4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AqsI093CzlTfQCcFQLYAeYZxMT0AIplgAXzLCWvPt7TIiOfQtKc4BiLxIQSQcEAEc
	 hejjbN5sLxUmMdp43DrDtjfX0RRMSd7UXvBj0yQ178ZIuTsRi3OE68+EfuWKwqD9Ha
	 Y/HkQfx/O0qa/gPOOmMIWrzPVG2JwmSsG1Penlesw+hCDO1JnykQf3/6XMuvp2b0on
	 yj6FAyf0KPWwe8f0+a23rivCDSBPuxpjemCBElG97K7mfkQNOQhSkZrSkCOPI3DJRk
	 /g8Ez7JKMqTNGPMLdtEl4yboR6PYanScCJvkSAeGVtOnRh+OukwVN7FbzVy0ULcuVj
	 CjI7oMXVZiA1A==
Subject:
 Re: [PATCH net v3 4/5] ip_gre: recompute erspan header lengths after a change
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 u9012063@gmail.com, stable@vger.kernel.org
Date: Fri, 25 Sep 2026 06:53:02 +0000
Message-ID: <179031918219.2160803.6960367885486755444@kernel.org>
In-Reply-To: <20260923035217.179102-5-edumazet@google.com>
References: <20260923035217.179102-5-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "There is no memory safety issue", but
  the bug being fixed also sends 4 uninitialized bytes of skb headroom…
- [Medium] On an existing erspan_ver 0 tunnel, every changelink that
  carries IFLA_INFO_DATA but omits IFLA_GRE_ERSPAN_VER (and…
- [Medium] In a Cc: stable fix, the patch rejects non-zero
  IFLA_GRE_IFLAGS/IFLA_GRE_OFLAGS for erspan_ver 0 and for…
- [Medium] This patch makes tunnel->tun_hlen/hlen change at runtime on a
  live erspan device (erspan_changelink() -> erspan_link_update() ->…
- [Low] erspan_xmit() now always sets IP_TUNNEL_SEQ_BIT for erspan_ver !=
  0 (line 750), whatever t->parms.o_flags holds.

--

ip_gre: recompute erspan header lengths after a change

This patch moves the ERSPAN tun_hlen/hlen computation into
erspan_set_hlen(). A new erspan_link_update() calls it at the end of
erspan_changelink() to refresh the header lengths, headroom and MTU.

It also rejects GRE flags for erspan_ver 0 and collect_md. In
erspan_xmit(), IP_TUNNEL_SEQ_BIT is now derived from erspan_ver.

> There is no memory safety issue: dev->needed_headroom is at least
> tunnel->hlen + sizeof(struct iphdr), and erspan_xmit() pushes at most
> 12 + 8 bytes before ip_tunnel_xmit() takes over and cows again.

[Severity: Medium]
Is this statement complete? The bug being fixed also appears to send 4
uninitialized bytes of skb headroom in ERSPAN packets.

In gre_build_header(), the word at greh + hdr_len - 4 is only written
when the SEQ, KEY or CSUM bit is set:

include/net/gre.h:gre_build_header() {
	skb_push(skb, hdr_len);
	...
	if (ip_tunnel_flags_intersect(flags, cond)) {
		__be32 *ptr = (__be32 *)(((u8 *)greh) + hdr_len - 4);
	...
}

Before this patch, there were two ways to reach hdr_len == 8 with none
of those bits set:

- After a v1/v2 -> v0 changelink, tun_hlen stayed at 8, but
  erspan_xmit() cleared the SEQ and KEY bits for v0.

- erspan_validate() only checks that IFLAGS | OFLAGS == GRE_SEQ | GRE_KEY.
  That means OFLAGS=KEY with IFLAGS=SEQ|KEY is accepted, and o_flags
  then lacks SEQ. erspan_xmit() clears KEY, and __gre_xmit() pushes
  8 bytes without writing any optional field.

This patch closes the first path through erspan_link_update(). It closes
the second through the new __assign_bit(IP_TUNNEL_SEQ_BIT, ...), but the
changelog only says that change makes SEQ match erspan_ver.

Since this is Cc: stable, could the changelog say that GRE header bytes
4..7 used to go out on the wire uninitialized?

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 27b3b4c584b1e..7385d66a94bf4 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -733,7 +733,6 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  	/* Push ERSPAN header */
>  	if (tunnel->erspan_ver == 0) {
>  		proto = htons(ETH_P_ERSPAN);
> -		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
>  	} else if (tunnel->erspan_ver == 1) {
>  		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
>  				    tunnel->index,
> @@ -748,6 +747,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
>  		goto free_skb;
>  	}
>  
> +	__assign_bit(IP_TUNNEL_SEQ_BIT, flags, tunnel->erspan_ver != 0);

[Severity: Low]
Now that the SEQ bit is forced here for erspan_ver != 0 whatever
t->parms.o_flags holds, does the reported configuration still match what
goes out on the wire?

erspan_validate() only checks the union of IFLAGS and OFLAGS. So a v1/v2
device can be created or changed with IFLAGS=SEQ|KEY and OFLAGS=KEY
(or 0). p.o_flags is stored as is, and ipgre_fill_info() only adds the
KEY bit:

net/ipv4/ip_gre.c:ipgre_fill_info() {
	...
	if (t->erspan_ver != 0 && !t->collect_md)
		__set_bit(IP_TUNNEL_KEY_BIT, o_flags);
	...
}

The dumped IFLA_GRE_OFLAGS would then show output sequencing as off.
Yet every transmitted packet carries the GRE S bit and a sequence number.

>  	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
>  	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
>  	return NETDEV_TX_OK;
> @@ -1169,17 +1169,18 @@ static int erspan_validate(struct nlattr *tb[], struct nlattr *data[],
>  	if (ret)
>  		return ret;
>  
> -	if (data[IFLA_GRE_ERSPAN_VER] &&
> -	    nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
> -		return 0;
> -
> -	/* ERSPAN type II/III should only have GRE sequence and key flag */
>  	if (data[IFLA_GRE_OFLAGS])
>  		flags |= nla_get_be16(data[IFLA_GRE_OFLAGS]);
>  	if (data[IFLA_GRE_IFLAGS])
>  		flags |= nla_get_be16(data[IFLA_GRE_IFLAGS]);
> -	if (!data[IFLA_GRE_COLLECT_METADATA] &&
> -	    flags != (GRE_SEQ | GRE_KEY))
> +
> +	if ((data[IFLA_GRE_ERSPAN_VER] &&
> +	     nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0) ||
> +	    data[IFLA_GRE_COLLECT_METADATA])
> +		return flags ? -EINVAL : 0;

[Severity: Medium]
This now rejects non-zero IFLA_GRE_IFLAGS/IFLA_GRE_OFLAGS for
erspan_ver 0 and for IFLA_GRE_COLLECT_METADATA, on both newlink and
changelink. Both cases used to be accepted: ver 0 returned early, and
collect_md skipped the flags check. Is this user-visible change intended
for a stable backport? The changelog lists the new rejection but doesn't
say why it is needed.

For collect_md, erspan_fb_xmit() never reads parms.o_flags. What does
rejecting the flags there protect against?

A v1/v2 device's own dump also no longer seems replayable with a
different version. ipgre_fill_info() reports SEQ|KEY for v1/v2 (KEY is
forced, as shown above). A request with IFLA_GRE_ERSPAN_VER=0 plus those
flags now fails with -EINVAL.

If a client resends the existing flags and has no way to clear SEQ, can
a v1/v2 -> v0 changelink still be done, or does the device have to be
recreated? I haven't checked iproute2's exact behaviour here.

> +
> +	/* ERSPAN type II/III should only have GRE sequence and key flag */
> +	if (flags != (GRE_SEQ | GRE_KEY))
>  		return -EINVAL;
>  
>  	/* ERSPAN Session ID only has 10-bit. Since we reuse
> @@ -1317,7 +1318,11 @@ static int erspan_netlink_parms(struct net_device *dev,
>  			return -EINVAL;
>  	}
>  
> -	if (gparms->erspan_ver == 1) {
> +	if (gparms->erspan_ver == 0) {
> +		if (!ip_tunnel_flags_empty(parms->i_flags) ||
> +		    !ip_tunnel_flags_empty(parms->o_flags))
> +			return -EINVAL;

[Severity: Medium]
Can a changelink on an existing erspan_ver 0 device still succeed if it
doesn't resend IFLA_GRE_ERSPAN_VER?

erspan_validate() has no view of the device state. Without
IFLA_GRE_ERSPAN_VER (and without IFLA_GRE_COLLECT_METADATA), it skips
the new early return and requires:

	if (flags != (GRE_SEQ | GRE_KEY))
		return -EINVAL;

A request with no flags attributes has flags == 0, so it fails there too.

erspan_netlink_parms() then inherits gparms->erspan_ver from
t->erspan_ver (0). This new branch rejects any non-empty i_flags or
o_flags, which is exactly what erspan_validate() just required.

So on a v0 device, no request that carries IFLA_INFO_DATA without
IFLA_GRE_ERSPAN_VER seems able to pass both checks. Before this patch,
the same request with SEQ|KEY was accepted. Is that intended?

> +	} else if (gparms->erspan_ver == 1) {
>  		if (data[IFLA_GRE_ERSPAN_INDEX]) {
>  			gparms->index = nla_get_u32(data[IFLA_GRE_ERSPAN_INDEX]);
>  			if (gparms->index & ~INDEX_MASK)

[ ... ]

> @@ -1575,15 +1607,30 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	if (err)
>  		return err;
>  
> +	link_changed = t->parms.link != p.link || t->fwmark != gparms.fwmark;
> +
>  	err = ip_tunnel_changelink(dev, tb, &p, gparms.fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;
> +
> +	if (link_changed)
> +		old_hlen = t->hlen;
>  
>  	ipgre_commit_parms(t, &gparms);
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
>  
> -	return 0;
> +link_update:
> +	/* ipgre_newlink_encap_setup() has published a new encapsulation
> +	 * without the ERSPAN header length even if ip_tunnel_changelink()
> +	 * failed, so the lengths must be refreshed on that error path too.
> +	 *
> +	 * As in ipgre_changelink(), IFLA_MTU must not hold the MTU back if we
> +	 * return an error, because do_setlink() will not apply it then.
> +	 */
> +	erspan_link_update(dev, err || !tb[IFLA_MTU], old_hlen);

[Severity: Medium]
Now that tun_hlen and hlen change at runtime on a live device, what
orders these updates against erspan_xmit()?

erspan_changelink() does plain stores in this order:

- t->erspan_ver, in ipgre_commit_parms()
- t->parms.o_flags
- tun_hlen and hlen, in erspan_set_hlen()
- dev->needed_headroom, in ip_tunnel_bind_dev()

There is no netif_tx_disable(), no synchronize_net() and no
READ_ONCE()/WRITE_ONCE().

erspan_xmit() runs without RTNL and reads these values one after
another:

erspan_xmit()
    skb_cow_head(skb, dev->needed_headroom)
    ip_tunnel_flags_copy(flags, tunnel->parms.o_flags)
    tunnel->erspan_ver       (if/else chain, ERSPAN header)
    tunnel->erspan_ver       (new __assign_bit())
    __gre_xmit()
        gre_build_header(skb, tunnel->tun_hlen, ...)

Each read can see a different generation of the configuration:

- 0 -> 2: SEQ is set from the new version while tun_hlen is still 4. The
  sequence number then overwrites greh->flags and greh->protocol, which
  is the corruption this patch fixes, now as a transient window.

- 2 -> 0: SEQ is cleared while tun_hlen is still 8. 8 bytes are pushed
  but only 4 are written, so 4 bytes of stale headroom go on the wire.

- The ERSPAN header and the SEQ bit can come from different versions.

- The skb may have been cowed for the old, smaller needed_headroom while
  up to 20 + 8 bytes get pushed. With an underlay whose hard_header_len
  + needed_headroom is below 4, could skb_push() reach
  skb_under_panic()? That seems to need very little headroom slack, but
  it would contradict the "no memory safety issue" statement.

Would it close this window to take one READ_ONCE() snapshot of
erspan_ver in erspan_xmit(), derive both the GRE length and the SEQ bit
from it, and cow for the size actually pushed? A similar o_flags vs
tun_hlen race seems to exist already for plain GRE in
ipgre_link_update().

> +
> +	return err;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923035217.179102-1-edumazet%40google.com
