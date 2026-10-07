Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFA34D4C9;
	Wed,  7 Oct 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415000; cv=none; b=erC/iKpefHAPaf91gzNQgCaD66Yarmka1owmxHwh0GyKI3nAVd3oTKUeTwv6BICWvDk2mYGXQThOrDqbpxvebTDOfWav0mg0JXRSc2qlShiPP38hs/C1zuLgdYTsjcubLh/n6W5DHisPVJU0QrBj351z3warWTnwRn6YI6X0vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415000; c=relaxed/simple;
	bh=HozEuype6Ihp7BTzIEH9D1TmFagl4g3FSCQyEtPwKrA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CsHgSz31NjZ7w2OAJwL5bOrOsZn8WMaDtabgQdcF/6g/QpsTkOQYVjImakqNOKo+y+JhwXOv1Xxv1R1c3J+TX5zav39iI4xaUxC4Wo3FqzGKfhfcCd9gug5QOEynDHWF4OmXRV1+Ew11tewFtM+1wCmH8VEPcBQaLPdt92OZwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh2Q1En7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh2Q1En7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92BF1F000FF;
	Wed,  7 Oct 2026 23:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791414998;
	bh=yd6GR6wTnkFvutmZM7EGDvQNlbblYQ1gfqKpLj1SFBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sh2Q1En7LSEN5xUiECtxCz+7OPdnctGT0GIdwKRQAtctC5G7T6txg1cVRCuOMzFvh
	 Xnodm12X6RnhujjWRCyFOJabeeLKqspOwrVi9p8PdkYesYHdy6edXwkEJhXdFt7PvW
	 9VcAp2AArfpARyYDw2mV4K1j26xKbmeQIh3Id8XR+J+iYIfT4eImJaelPVE5InFwCU
	 LlfrVHnR8OLVa34vgNtMrYW4Jf/1vpm7ugL6DP0V7NO3OjpMiA3Myosuf7lDIAMibk
	 GoJ5eyvXSQzVc55GBHNQZnY8KqDaHR7qRgyuIh7tYw7PNeHjWSd358lFvoCFkb7x58
	 r13VAnpgNGP9Q==
Subject: Re: [PATCH net v5] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, fw@strlen.de, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, mazin@getstate.dev, matthias.may@westermo.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 07 Oct 2026 23:16:37 +0000
Message-ID: <179141499719.434549.15788178109134377075@kernel.org>
In-Reply-To: <20261005231414.932997-1-littlesmilingcloud@gmail.com>
References: <20261005231414.932997-1-littlesmilingcloud@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ip6erspan_tunnel_xmit() still lets short frames through,
  including short frames with a VLAN skb->protocol, and…
- [High] ip6gre_tunnel_xmit() still checks one thing and parses another
  in the header_ops branch the patch keeps.

Pre-existing issues:
- [High] ip6_tnl_xmit() recomputes `payload_protocol = skb_protocol(skb,
  true)` (net/ipv6/ip6_tunnel.c:1119) after __gre6_xmit() or…

--

ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()

This patch replaces pskb_inet_may_pull() with skb_vlan_inet_prepare()
in ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit(). The goal is that
the length check matches the VLAN-aware protocol parsing done later.
skb->mac_len is cleared for Ethernet devices first, and the old check
is kept for ip6gre devices that use ip6gre_header_ops.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index e61cb10b50dc9..8b286bfd2c4cc 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -883,8 +883,23 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
>  	__be16 payload_protocol;
>  	int ret;
>  
> -	if (!pskb_inet_may_pull(skb))
> -		goto tx_err;
> +	if (dev->type != ARPHRD_ETHER && dev->header_ops) {
> +		/* ip6gre_header() has pushed a pseudo header in front of
> +		 * the packet, so skb->data is not where the packet starts.
> +		 */
> +		if (!pskb_inet_may_pull(skb))
> +			goto tx_err;

[Severity: High]
The commit message says "This fixes the check and the skb_protocol()
dispatch in ip6gre_tunnel_xmit()". Can this branch still read an inner
header that was never pulled?

ip6gre_tunnel_init() sets header_ops only when no remote is configured:

	if (ipv6_addr_any(&tunnel->parms.raddr))
		dev->header_ops = &ip6gre_header_ops;

Nothing clears it when changelink later sets a remote. After that,
ip6_tnl_xmit_ctl() passes.

When skb->protocol is ETH_P_8021Q, pskb_inet_may_pull() takes the
default case with nhlen = 0. So nothing is pulled past the network
offset. The shared dispatch below then does:

	payload_protocol = skb_protocol(skb, true);

That walk starts at skb->data + ETH_HLEN, which is inside the
user-supplied pseudo IPv6 header pushed by ip6gre_header(). It can
return ETH_P_IPV6 or ETH_P_IP.

The selected handlers then read the inner header without any further
length check:

  - ip6gre_xmit_ipv6() reads ipv6h->saddr
  - ip6_tnl_parse_tlv_enc_lim() reads nexthdr
  - prepare_ip6gre_xmit_ipv6() reads tclass and flowlabel
  - ip6gre_xmit_ipv4() reads the dsfield
  - ip6_tnl_xmit() reads the ttl or hop_limit when it is inherited

With PACKET_TX_RING, tpacket_fill_skb() copies only hard_header_len
into the linear area and puts the rest in page frags. Would these reads
then come from uninitialized tailroom, with some of the bits copied
into the outer IPv6 header on the wire?

The commit message lists this branch as a follow-up. Should the "This
fixes the check and the skb_protocol() dispatch" sentence be narrowed
to say this case is not covered yet?

> +	} else {
> +		/* skb_vlan_inet_prepare() and the skb_protocol() dispatch
> +		 * below walk the VLAN tags from skb->mac_len - VLAN_HLEN, or
> +		 * from ETH_HLEN if it is 0; a forwarded skb still has the
> +		 * mac_len of the device it was received on.
> +		 */
> +		if (dev->type == ARPHRD_ETHER)
> +			skb->mac_len = 0;
> +		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
> +			goto tx_err;

[Severity: High]
This is a pre-existing issue, and the commit message lists
ip6_tnl_xmit() as a follow-up. Even so, can a short tagged frame whose
real inner type is not IP still cause an uninitialized read after this
check?

Take an 18-byte tagged ARP frame on a keyed ip6gretap device (or on
ip6erspan). skb_vlan_inet_prepare() succeeds with maclen = 18 and
nhlen = 0, and it leaves the network header at the end of the data.

After __gre6_xmit() (or ip6erspan_tunnel_xmit()) pushes the GRE header
(and the ERSPAN header), ip6_tnl_xmit() parses the protocol again:

	payload_protocol = skb_protocol(skb, true);

skb->mac_len is now 0, so this walk starts at ETH_HLEN from the GRE
header. The encapsulated protocol is then read from one of these
places:

  - inner bytes 8-9 (the source MAC) on keyed ip6gretap
  - inner bytes 0-1 (the destination MAC) on ip6erspan v1

The sender controls both.

With ttl inherit, ip6_tnl_xmit() then does:

		if (payload_protocol == htons(ETH_P_IP))
			hop_limit = ip_hdr(skb)->ttl;
		else if (payload_protocol == htons(ETH_P_IPV6))
			hop_limit = ipv6_hdr(skb)->hop_limit;

That reads 7 or 8 bytes past the skb tail. Can that uninitialized byte
go out on the wire as the outer hop limit?

The commit message describes this case as inheritance that "is still
taken from the wrong offset". Would it be more accurate to say it can
also read past the end of the packet?

>  
>  	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>  		goto tx_err;
> @@ -934,7 +949,13 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
>  	__u32 mtu;
>  	int nhoff;
>  
> -	if (!pskb_inet_may_pull(skb))
> +	/* skb_vlan_inet_prepare() below walks the VLAN tags from
> +	 * skb->mac_len - VLAN_HLEN, or from ETH_HLEN if it is 0, to check
> +	 * the length; a forwarded skb still has the mac_len of the device
> +	 * it was received on.
> +	 */
> +	skb->mac_len = 0;
> +	if (skb_vlan_inet_prepare(skb, false))
>  		goto tx_err;

[Severity: High]
Does this check still let short frames reach erspan_build_header() and
erspan_build_header_v2()?

If skb->protocol is a VLAN type but the tag is truncated,
__vlan_get_protocol() fails inside skb_vlan_inet_prepare(). type
becomes 0 and maclen stays at ETH_HLEN, so only 14 bytes have to be
present:

	if (eth_type_vlan(type))
		type = __vlan_get_protocol(skb, type, &maclen);
	...
	reason = pskb_may_pull_reason(skb, maclen + nhlen);

A non-IP frame likewise only needs maclen bytes, which is ETH_HLEN, or
ETH_HLEN plus the tags.

Both ERSPAN builders always read the first two bytes at the network
header:

	tos = is_ipv4 ? ip_hdr(skb)->tos :
			(ipv6_hdr(skb)->priority << 4) +
			(ipv6_hdr(skb)->flow_lbl[0] >> 4);

When the in-frame h_proto is 0x8100, they also read the TCI at
skb->data + 14:

	if (eth->h_proto == htons(ETH_P_8021Q)) {
		qp = (struct qtag_prefix *)(skb->data + 2 * ETH_ALEN);
		vlan_tci = ntohs(qp->tci);

These frames would pass the new check and then cause reads up to 2
bytes past skb->len:

  - a 14 or 15 byte frame sent through AF_PACKET with
    sll_protocol = ETH_P_8021Q
  - a 14 or 15 byte non-IP frame
  - an 18 or 19 byte tagged non-IP frame

Can this put uninitialized tailroom into ershdr->cos, and into the
ERSPAN VLAN field when the in-frame ethertype is 0x8100?

The commit message says the short ip6erspan frame is now dropped. This
looks like the same over-read, just a few bytes higher.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005231414.932997-1-littlesmilingcloud%40gmail.com
