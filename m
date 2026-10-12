Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6038735D;
	Mon, 12 Oct 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791768447; cv=none; b=g95Py22Pa5dLjw6fZd6MADatZOukAotsHFvrGlavTKp3wI+8jVD3sYPsID0cFsb+5jfqXU/5wUaIMOPgaWdrXWmG2dvReP4tFZaAiaDHGlDcxIxmGqEfFf5dmjNaN2IMpMi0NkJtl7GEAtENh3tKaNmdqyoHFZS9OT56I9tjhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791768447; c=relaxed/simple;
	bh=Z4YbKlMYfwjeCSuNzqsvvMhdovAKYj8NiZstvX0GOtc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z2Knk7K/Bu6Sjz2eCfQDPmQcCH2jZN1yItV6z51p5D2vkTMlaR6TZ6UdJmBiIoQKtxqKWbfzjWtaU9PtBCephp/78vmejYgKfU4iECtJx3KOn7H5sYyjQdu9rxPcdboA/T0xTQyPkHHbC38K3JFGbbZbstY2UznuqjitfP2xMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrsxjV8Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrsxjV8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B41F0089B;
	Mon, 12 Oct 2026 01:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791768446;
	bh=VMCIw3R1Suzemsm2WOv45XkZoDR3phWGGRoHPSwTczA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NrsxjV8YWqZxwVWNHhzzsDoASrDAQIWFpgQ7ZRSM47lAK+J23jHgsUr6i1K7O4ZGi
	 DDOfs51gwBL38aEM7NTOAKuV9Wbx9dAR+p1f7up7aiyg4VFktXr8O1zMmXzLbZi0zc
	 QY5/Hf3wdQyObEOlTmEAk9sccnO07XmzMN9RON8wnIjSDXZxz8kqpVnRNlbhyvNRBF
	 uBzbEBAKV0hn1uWOmCz0ylY15ZI2O8mUkLRv4FfEJnlsjmYriiHav99+hfcslR3RVX
	 NZ2nQhojwTslxyFPDt1AbqbGjtF0xu8YmJqgC+V8iVChya24octqnCsqSEPsaeXykx
	 zR7Mp+UvbHVsw==
Subject: Re: [PATCH net v6] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
From: netdev-bot+sashiko@kernel.org
To: littlesmilingcloud@gmail.com
Cc: netdev@vger.kernel.org, edumazet@kernel.org, fw@strlen.de, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, mazin@getstate.dev, matthias.may@westermo.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 12 Oct 2026 01:27:24 +0000
Message-ID: <179176844482.434549.5708346025808067831@kernel.org>
In-Reply-To: <20261008012554.202925-1-littlesmilingcloud@gmail.com>
References: <20261008012554.202925-1-littlesmilingcloud@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Regression: in ip6gre_tunnel_xmit() (ip6gretap branch) and
  ip6erspan_tunnel_xmit(), skb_vlan_inet_prepare() now always calls…

Pre-existing issues:
- [Medium] ip6_tnl_xmit() calls skb_protocol(skb, true) again (line 1119)
  after the GRE header (and, for ip6erspan, the ERSPAN header) has been…

--

ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()

This patch changes ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit() to
use skb_vlan_inet_prepare() instead of pskb_inet_may_pull(). The length
check then matches the VLAN-aware skb_protocol() parsing that comes after
it. For Ethernet devices it first clears skb->mac_len, and it keeps
pskb_inet_may_pull() for ip6gre devices that use ip6gre_header_ops.

Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index 04f7c70b7320e..06dd53c5a9e25 100644
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

[Severity: Medium]

Can this move the network header onto the VLAN TCI? This would happen for
skbs that already carry an in-band tag while skb->protocol holds the inner
protocol.

skb_vlan_inet_prepare() works out maclen from skb->protocol alone, and then
always sets the network header:

include/net/ip_tunnels.h:skb_vlan_inet_prepare() {
    ...
	if (eth_type_vlan(type))
		type = __vlan_get_protocol(skb, type, &maclen);
    ...
	skb_set_network_header(skb, maclen);
}

vlan_do_receive() creates such skbs on a VLAN device with reorder_hdr off
that is not a bridge or macvlan port:

net/8021q/vlan_core.c:vlan_do_receive() {
    ...
		skb = *skbp = vlan_insert_inner_tag(skb, skb->vlan_proto,
						    skb->vlan_tci, skb->mac_len);
    ...
		skb_reset_mac_len(skb);
}

That leaves skb->protocol as ETH_P_IP or ETH_P_IPV6, with the tag at
offset 12 and the network header at offset 18 (mac_len is 18). Say tc
mirred on that VLAN device's ingress sends the skb to ip6gretap or
ip6erspan. tcf_mirred_to_dev() pushes mac_len, so the frame reaches the
tunnel with the tag still in-band.

With pskb_inet_may_pull() the network header stayed at 18. Here
eth_type_vlan(ETH_P_IP) is false, so maclen stays ETH_HLEN and the network
header moves to 14, which is the TCI.

Would everything after the check then read the inner header 4 bytes off?
For example:

  - prepare_ip6gre_xmit_ipv4() with IP6_TNL_F_USE_ORIG_TCLASS takes the
    dsfield from the low byte of the TCI.

  - In ip6erspan_tunnel_xmit(), ip_hdr(skb)->tot_len reads the
    encapsulated EtherType (0x0800). ipv6_hdr(skb)->payload_len reads the
    0x6xxx version word. Either way truncate (the ERSPAN T bit) is set
    for nearly every mirrored frame.

  - prepare_ip6gre_xmit_ipv6() does the raddr loop check and
    ip6_tnl_parse_tlv_enc_lim() on shifted bytes, so a flow label byte
    acts as nexthdr. That can cause drops or bogus ICMPV6_PARAMPROB
    replies.

  - ICMP errors sent on -EMSGSIZE, and the inherited hop limit in
    ip6_tnl_xmit(), are taken from the shifted header.

All of these reads stay inside the pulled area.

> +	}
>  
>  	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
>  		goto tx_err;
> @@ -933,7 +948,13 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
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

[Severity: Medium]

This is a pre-existing issue that the patch did not introduce, and the
commit message already lists it as a follow-up. Still, clearing mac_len
here changes where the second VLAN walk in ip6_tnl_xmit() lands.

ip6_tnl_xmit() runs after the GRE header has been pushed (for ip6erspan,
the ERSPAN header too):

net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
    ...
	payload_protocol = skb_protocol(skb, true);
    ...
	if (hop_limit == 0) {
		if (payload_protocol == htons(ETH_P_IP))
			hop_limit = ip_hdr(skb)->ttl;
		else if (payload_protocol == htons(ETH_P_IPV6))
			hop_limit = ipv6_hdr(skb)->hop_limit;
    ...
}

Now that mac_len is 0, the walk starts ETH_HLEN past the GRE header. For
keyed ip6gretap and for ip6erspan, that is on MAC or ERSPAN bytes the
sender controls.

Suppose those bytes read as ETH_P_IP or ETH_P_IPV6 and hop limit
inheritance is on. Then ttl or hop_limit is read at the network header
that skb_vlan_inet_prepare() set. For a short tagged frame with a non-IP
inner type, only maclen bytes were pulled.

Could this read a byte past skb->tail and put it in the outer IPv6 hop
limit? A locally generated short frame, for example from veth or
AF_PACKET, could hit this.

In the other cases the real inner TTL and traffic class are just not
inherited. For unkeyed ip6gretap, the second walk now lands on the real
inner protocol.

> +	if (skb_vlan_inet_prepare(skb, false))
>  		goto tx_err;
>  
>  	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008012554.202925-1-littlesmilingcloud%40gmail.com
