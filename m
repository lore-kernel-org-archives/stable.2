Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8E352034;
	Wed,  9 Sep 2026 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929826; cv=none; b=lJQ90hZTWZ4F91z3/r1QP4vvlUu5opP0Y1GCBDywvLZlh9XGoVHYdMTrh4H3JTLdFQpLF/3Au6b1c9X5B6f25MyO6GfPdbq2Gkfo3Vehxwa2N4ub42CXmHo2UbzJrhgAS4cNVUjh+0PD1Zx0H4+UJHmrrLJqRk8ioA54vlMdzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929826; c=relaxed/simple;
	bh=tMBEbq3nxe4nO1M0xsqpx6WR0zRku7JRWH15O/ybHN4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUwqijnIACKK2n9KiWVLdLpkcIQj4cIe20dQ/KEDogj44pDe+VFbEimyOI2U/7aYNcPE1zlBYDdZIehaKSRwEH+NSrHn1zPw1P2Obr+Pi0VH2Jpq55709qSJdv5wlSOwm0RYxbPHBs349QKiVVtb/Nro2UJyjojyEg0yE79Vdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUaAYFC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUaAYFC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDCD1F00A3A;
	Wed,  9 Sep 2026 04:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788929823;
	bh=R7Ov8iuVdfDMZnkHJ71WczwfnTH/fvSUB1E9xX1KPQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZUaAYFC0DjvAjy943b0zwm59bjFv5lqI28I5fqNtnDCbAFNl9SbR26g6vUHz3yduy
	 vVtyyHEXTCbjpIErM2+4L+oFmDkV5A03iMMHcASWlCk2XGV09tnDo5pJ4BWR5LecqX
	 kPLsdWOuiRC3uelBuWN7rW6nZpxVf9vru9g42gTFHXfAveVmseQUueM/3Vq+FnCRw5
	 YsjGpaHLa42dpM1NL+k/bdpH5SUiBKNMKAHNz086Vy5Neb2DBuPrU5wN/HMD0oCVfF
	 p8BXWGTBuHx2rmVzZKlE3/iSYJKX1hUD4eqpuEJ4wq0slRRdOFd5d9nFviqR8GAxcK
	 6aAvTDGyunYCQ==
Subject:
 Re: [PATCH net v4] ip_tunnel: reserve FOU/GUE headroom before encapsulation
From: netdev-bot+sashiko@kernel.org
To: nicoyip.dev@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, lucien.xin@gmail.com, u9012063@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 09 Sep 2026 04:57:02 +0000
Message-ID: <178892982217.219967.9823652987530749000@kernel.org>
In-Reply-To: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
References: <20260904165544.1362052-1-nicoyip.dev@gmail.com>
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

Critical: 0 · High: 0 (2) · Medium: 2 (2) · Low: 0 (2)

- [Medium] Incomplete fix: the patch establishes the invariant "reserve
  ip_encap_hlen() bytes before ip_tunnel_encap() pushes the FOU/GUE+UDP…
- [Medium] Undisclosed on-the-wire behaviour change: moving
  ip_tunnel_encap() from before the route lookup to after it…

Pre-existing issues:
- [High] The IPv4 fix leaves the identical headroom-underflow race
  reachable in the IPv6 tunnel transmit path.
- [High] Peer call-site inconsistency with a concrete functional
  consequence: after this patch ip_tunnel_xmit() calls ip_tunnel_encap()…
- [Medium] Residual race not covered by the fix, in the GRE header build
  the commit message's timeline explicitly names.
- [Medium] Same bug class in a sibling caller: net/ipv6/sit.c
  ipip6_tunnel_xmit() sizes its headroom from a racy read of…
- [Low] Reported concern (refuted for the ICMP/-E2BIG decision): the
  concern states that `pkt_size = skb->len + encap_hlen - tunnel_hlen`…
- [Low] `ipencap = data_race(tunnel->encap)` (net/ipv4/ip_tunnel.c:772)
  only suppresses the KCSAN report; it does not make the 8-byte four-…

--

ip_tunnel: reserve FOU/GUE headroom before encapsulation

This moves ip_tunnel_encap() in ip_tunnel_xmit() to run after the route
lookup, PMTU handling and skb_cow_head(), snapshots tunnel->encap into a
local copy used for both ip_encap_hlen() and ip_tunnel_encap(), and adds
an encap_hlen argument to tnl_update_pmtu() so the inner packet size is
still computed as skb->len + encap_hlen - tunnel_hlen.

Link: https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com/

A few questions on the changelog first.

>   CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
>   install GUE encapsulation
>                                   reserve the old needed_headroom
>   publish larger GRE flags
>   update tunnel->tun_hlen
>                                   push the larger GRE header
>                                   push the GUE and UDP headers
>   update dev->needed_headroom

[Severity: Medium]
This isn't a bug introduced by this patch, but since the table names
"publish larger GRE flags" and "update tunnel->tun_hlen" as steps of the
race, is the GRE header build itself still exposed after this change?

ipgre_xmit() snapshots the flags, but __gre_xmit() then does a separate,
later read of tunnel->tun_hlen:

net/ipv4/ip_gre.c:__gre_xmit() {
	...
	gre_build_header(skb, tunnel->tun_hlen,
			 flags, proto, tunnel->parms.o_key,
			 test_bit(IP_TUNNEL_SEQ_BIT, flags) ?
			 htonl(atomic_fetch_inc(&tunnel->o_seqno)) : 0);
	...
}

ipgre_changelink() stores the new parms.o_flags and only afterwards calls
ipgre_link_update(), which sets tunnel->tun_hlen, so hdr_len and flags can
come from different generations.

With new flags and an old tun_hlen of 4, gre_build_header() computes
ptr = greh + hdr_len - 4 == greh and writes the sequence number over
greh->flags/protocol, and the key/checksum words land before greh.

With old flags (none set) and a new tun_hlen of 16, 16 bytes are pushed but
the SEQ/KEY/CSUM branch is skipped, so 12 bytes of uninitialised headroom
go on the wire.

Neither case can underflow skb->head (the reservation always leaves at
least 20 bytes after the GRE push), so this is not the skb_under_panic()
the patch targets. Would deriving tun_hlen from the flags snapshot with
gre_calc_hlen() close it the same way the encap snapshot does here?

> The IPv6 analogue of this headroom reservation is still work in
> progress.

[Severity: High]
This is a pre-existing issue and the changelog says as much, but for the
record on what remains reachable: ip6_tnl_xmit() sizes the reservation from
one early read of t->encap_hlen:

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
	unsigned int max_headroom = psh_hlen;
	...
	if (skb_cow_head(skb, max_headroom))
		goto tx_err_dst_release;
	...
	err = ip6_tnl_encap(skb, t, &proto, fl6);
}

ip6gre_changelink_common()/ip6_tnl_changelink() -> ip6_tnl_encap_setup()
can replace TUNNEL_ENCAP_NONE with GUE plus REMCSUM between the length read
and the encap build, and the transmit path takes no lock.

Reserved is 40 + encap_old + LL_RESERVED_SPACE(tdev); pushed after the cow
is encap_new + 40. With encap_old = 0, encap_new = 20 (udphdr 8 + guehdr 4
+ GUE_LEN_PRIV 4 + GUE_PLEN_REMCSUM 4) and LL_RESERVED_SPACE(tdev) = 16 for
an Ethernet underlay, that is a 4 byte deficit, so the skb_push() inside
__gue_build_header()/fou_build_udp() hits skb_under_panic() and BUG().

__gre6_xmit() has the same shape: it reserves a possibly stale
dev->needed_headroom before reading the current GRE parameters. Is the
IPv6 follow-up expected in the same series, given this one is tagged for
stable?

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..a8c846aab30c6 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -512,14 +512,15 @@ EXPORT_SYMBOL_GPL(ip_tunnel_encap_setup);
>  static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
>  			    struct rtable *rt, __be16 df,
>  			    const struct iphdr *inner_iph,
> -			    int tunnel_hlen, __be32 dst, bool md)
> +			    int tunnel_hlen, __be32 dst, bool md,
> +			    int encap_hlen)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  	int pkt_size;
>  	int mtu;
>  
>  	tunnel_hlen = md ? tunnel_hlen : tunnel->hlen;
> -	pkt_size = skb->len - tunnel_hlen;
> +	pkt_size = skb->len + encap_hlen - tunnel_hlen;

[Severity: Low]
This is a pre-existing property rather than something the patch breaks, but
it is worth noting for anyone reading the new formula: encap_hlen is a
snapshot while tunnel->hlen here is a plain read, and the GRE bytes already
on the skb came from yet another read of tunnel->tun_hlen in __gre_xmit().

On the df branch the skew cancels, because the same tunnel_hlen is
subtracted from dst_mtu():

	mtu = dst_mtu(&rt->dst) - (sizeof(struct iphdr) + tunnel_hlen);

so mtu < pkt_size reduces to
sizeof(struct iphdr) + gre_len_on_skb + encap_snapshot + inner > dst_mtu,
which is correct whichever generation tunnel->hlen came from.

Only the df == 0 branch, where mtu comes from dst_mtu(skb_dst)/dev->mtu,
keeps a residual skew of up to the GRE/encap delta during a reconfiguration
window, and that skew existed before this patch too. Is that reading
correct, or is there a case where the new term makes the df == 0 branch
worse?

> @@ -629,7 +630,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  	if (test_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, key->tun_flags))
>  		df = htons(IP_DF);
>  	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, tunnel_hlen,
> -			    key->u.ipv4.dst, true)) {
> +			    key->u.ipv4.dst, true, 0)) {
>  		ip_rt_put(rt);
>  		goto tx_error;
>  	}

[Severity: Medium]
The changelog says of this function:

  "ip_md_tunnel_xmit() is left unchanged. It takes FOU/GUE parameters
   from the skb metadata dst, not from the device configuration, so it
   is not exposed to this race."

The race is indeed different here, but does the invariant the patch
establishes ("reserve ip_encap_hlen() bytes before ip_tunnel_encap()
pushes") still hold on this path?

ip_md_tunnel_xmit() pushes the encap first:

	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
		goto tx_error;

and grows the headroom only later, without an encap term:

	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
	if (skb_cow_head(skb, headroom)) {
		...
	}
	ip_tunnel_adj_headroom(dev, headroom);

So the UDP/GUE push has no reservation from this function, and the
dev->needed_headroom advertised by ip_tunnel_adj_headroom() under-reports
the metadata encap size for subsequent packets.

The metadata encap is live: bpf_skb_set_fou_encap() sets
info->encap.type = TUNNEL_ENCAP_FOU/GUE together with sport/dport and
TUNNEL_ENCAP_FLAG_CSUM.

The ipip collect_md path looks like the thinnest case, since it does no
skb_cow_head() at all before the call:

net/ipv4/ipip.c:ipip_tunnel_xmit() {
	...
	if (tunnel->collect_md)
		ip_md_tunnel_xmit(skb, dev, ipproto, 0);
	...
}

For GRE collect_md, ip_tunnel_bind_dev() currently leaves slack
(needed_headroom is at least 56 versus at most 16 bytes of GRE plus 12
bytes of BPF-settable GUE), so no deterministic crash could be
constructed; for ipip there is no pre-push cow, but no caller delivering
an skb with under 12 bytes of headroom was identified either. Would it be
worth either restructuring this function the same way, or noting in the
changelog that its headroom accounting is also missing ip_encap_hlen()?

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but the
patch fixes the same ordering on the ip_tunnel_xmit() side, so it may
belong in the series: ip_md_tunnel_xmit() still calls ip_tunnel_encap()
before dst_cache_get_ip4()/ip_route_output_key(), so fl4.saddr is
unresolved when the outer UDP checksum is built.

net/ipv4/fou_core.c:fou_build_udp() {
	...
	udp_set_csum(!(e->flags & TUNNEL_ENCAP_FLAG_CSUM), skb,
		     fl4->saddr, fl4->daddr, skb->len);
	...
}

On this path fl4.saddr == key->u.ipv4.src, and bpf_skb_set_tunnel_key()
leaves that at 0 unless the program sets local_ipv4, while defaulting the
checksum on:

net/core/filter.c:bpf_skb_set_tunnel_key() {
	...
	__assign_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags,
		     !(flags & BPF_F_ZERO_CSUM_TX));
	...
}

bpf_skb_set_fou_encap() turns that into TUNNEL_ENCAP_FLAG_CSUM. The
pseudo-header then uses saddr = 0 while iptunnel_xmit() writes the
route-selected fl4.saddr into the outer IP header, so does every such
packet leave with a UDP checksum the receiver rejects in
udp4_csum_init()/udp_rcv()?

Nothing else appears to fill key.u.ipv4.src on this path: the only caller
of dev_fill_metadata_dst(), which would set it via
gre_fill_metadata_dst(), is openvswitch's output_userspace().

> @@ -765,7 +768,10 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  			    tunnel->net, READ_ONCE(tunnel->parms.link),
>  			    tunnel->fwmark, skb_get_hash(skb), 0);
>  
> -	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
> +	/* Snapshot encap; ipgre_changelink() can update it concurrently. */
> +	ipencap = data_race(tunnel->encap);

[Severity: Low]
This is a pre-existing exposure rather than a new one, but the comment plus
data_race() could be read as asserting the snapshot is coherent. Does
data_race() do anything beyond silencing KCSAN for this 8 byte, four field
copy?

The writer publishes the fields separately, starting with a memset:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
	memset(&t->encap, 0, sizeof(t->encap));
	...
}

so a snapshot can observe type == TUNNEL_ENCAP_GUE with dport == 0, or
with flags == 0 (no CSUM/REMCSUM the peer expects), or a fully zeroed copy
in which case type == TUNNEL_ENCAP_NONE and the packet goes out with no
encapsulation.

For headroom safety the patch is clearly an improvement, since
ip_encap_hlen() and ip_tunnel_encap() now consume the same local copy
instead of reading tunnel->encap twice. Would publishing the encap
configuration through RCU or a seqcount be the more robust follow-up?

> +	encap_hlen = ip_encap_hlen(&ipencap);
> +	if (encap_hlen < 0)
>  		goto tx_error;
>  
>  	if (connected && md) {

[ ... ]

> @@ -845,6 +852,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>  
>  	ip_tunnel_adj_headroom(dev, max_headroom);
>  
> +	if (ip_tunnel_encap(skb, &ipencap, &protocol, &fl4) < 0) {
> +		ip_rt_put(rt);
> +		goto tx_error;
> +	}
> +

[Severity: Medium]
Does moving the call to this point also change what goes on the wire?
ip_tunnel_init_flow() sets fl4.saddr = tnl_params->saddr, which is 0 for a
tunnel created without a local address, and fl4.saddr is only resolved
during the route lookup:

net/ipv4/fib_semantics.c:fib_select_path() {
	if (fl4->flowi4_oif)
		goto check_saddr;
	...
}

Before this change fou_build_udp() ran right after
ip_tunnel_init_flow(), so udp_set_csum() built the pseudo-header with
saddr == 0 while iptunnel_xmit() later wrote the route-selected saddr into
the outer IP header. After the change the pseudo-header uses the real
source address.

For a tunnel such as:

	ip link add gre1 type gre remote R encap gue encap-csum

with no local address, the emitted outer UDP checksum therefore differs
before and after. That looks like a fix rather than a regression, but the
changelog is framed purely as a headroom fix and carries Fixes: and
Cc: stable. Could the reorder and its checksum effect be described there,
so backporters and bisecting users are not surprised?

[Severity: Medium]
This isn't a bug introduced by this patch and is outside its stated scope,
but net/ipv6/sit.c has the same reserve-then-push inversion and is not
mentioned as WIP.

ipip6_tunnel_xmit() sizes the reservation from a racy read of
tunnel->hlen:

net/ipv6/sit.c:ipip6_tunnel_xmit() {
	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
	...
	max_headroom = LL_RESERVED_SPACE(tdev) + t_hlen;

	if (skb_headroom(skb) < max_headroom || skb_shared(skb) ||
	...
	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
	...
}

and iptunnel_xmit() then pushes another 20 bytes of IP header.
ipip6_changelink() -> ip_tunnel_encap_setup() publishes t->encap before
t->encap_hlen and t->hlen, so a concurrent transmit can reserve
LL_RESERVED_SPACE + old_hlen + 20 and then push up to 20 bytes of GUE/UDP
with REMCSUM plus 20 bytes of IP. With encap_old = 0, encap_new = 20 and
LL_RESERVED_SPACE(tdev) = 16 that is a 4 byte deficit and skb_under_panic().

No deterministic trigger could be built, since LL_RESERVED_SPACE rounding
and SKB_DATA_ALIGN slack in skb_realloc_headroom() usually leave spare
bytes, so this is only structurally reachable. Should sit get the same
snapshot-then-reserve treatment?

>  	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
>  		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
>  	return;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904165544.1362052-1-nicoyip.dev%40gmail.com
