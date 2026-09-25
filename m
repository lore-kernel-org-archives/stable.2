Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEE38DC57;
	Fri, 25 Sep 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364111; cv=none; b=GvoIF2FpXHor0e4Rstr9a5/5weuvcoTqchuHdd/gdKZA44joEpO/pb7GLLRy4shxsP67iavThNN/pBpQQQLFCiY5/wpm2fZPNGk5b7gyUfZEZs+ffa7eKW6xqCuixV3UD/uIXEuhiXDMbJzCGvTeDpeEQ7cJHMWOQn3LzhiXURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364111; c=relaxed/simple;
	bh=RZYt9tYVrh5QH4PuGFx6f7lGWsmbno3pw+s6VE8zrgU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ouh2wFDIHfm4yTaxWTrx34rSKAV+mVCt489iY7cUuuhnO428JMMols/qECWRSctXF66m/ra2dBln0ajJ6584XV5DudRBMIJuhRl0TNTD23R1iRU9vKijzXf6nhjrdCkgkEFXvv4eXjNmZfKUu2hZMzhtpf2NF1fru86z8m1+Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD7Kud9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD7Kud9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6A01F00893;
	Fri, 25 Sep 2026 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364109;
	bh=xjUHYtaexOjua91/becooqNz1ihfwstGU7oM1IvldSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZD7Kud9UVDUk7H4mCXztndEaZft1VZ8+fzVyM+mjIXEiuSz4Hnwek0omDBzMT+m/d
	 oFBsInaAJ6fx+1G45dphqSMYT0oSZFOh1kQ6s+/3GI/CtPpP2DUxNVewZ/+uqZiLQd
	 tCNdSPjCitD4LeGXH50MPuEoBgbCx7ZwnQhzdxaIsl8kyRjzCxgu3LrrGfAE/7OmTO
	 JMSGT1/jruaEYD6szUx13ydqeaGD1viqBvbH+PgRVWPtdGsY+QJcl7oi+6r3fZWl2J
	 9O94cRXFT9RNLoaOh928LeRhHHE0mpnJ/1ibfUte56/s9UHH0grWhj7kEYTxBBx2BI
	 e6uMYswKnb+kQ==
Subject: Re: [PATCH net] net: extend IPv6 exthdr detection of tunneled packets
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, xietangxin@yeah.net, willemb@google.com,
 stable@vger.kernel.org
Date: Fri, 25 Sep 2026 19:21:48 +0000
Message-ID: <179036410829.2160803.1955366625960078958@kernel.org>
In-Reply-To: <20260924192128.1197118-1-willemdebruijn.kernel@gmail.com>
References: <20260924192128.1197118-1-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Regression for non-encapsulated IPv6 CHECKSUM_PARTIAL skbs in
  skb_csum_hwoffload_help(), plus a matching gap in…

--

net: extend IPv6 exthdr detection of tunneled packets

This patch replaces skb_gso_has_extension_hdr() with
skb_has_ipv6_extension_hdr(). The new helper runs ipv6_ext_hdr() on the
outer IPv6 nexthdr. For encapsulated skbs that have an inner network
header, it also runs it on the inner IPv6 nexthdr. skb_csum_hwoffload_help()
now uses the same helper instead of its open coded skb_network_header_len()
test.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index f660fccfc0dbc..992b78308c13f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3818,20 +3818,29 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
>  
> -static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
> -{
> -	if (!skb->encapsulation)
> -		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
> -			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> -			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
> -			skb_transport_header_was_set(skb) &&
> -			skb_network_header_len(skb) != sizeof(struct ipv6hdr));

[ ... ]

> +static bool __skb_has_ipv6_ext_hdr(const struct sk_buff *skb, int nhoff)
> +{
> +	const struct ipv6hdr *ip6h;
> +	struct ipv6hdr _ip6h;
> +
> +	ip6h = skb_header_pointer(skb, nhoff, sizeof(_ip6h), &_ip6h);
> +	return ip6h && ip6h->version == 6 && ipv6_ext_hdr(ip6h->nexthdr);
> +}
> +
> +static bool skb_has_ipv6_extension_hdr(const struct sk_buff *skb)
> +{
> +	if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
> +	    __skb_has_ipv6_ext_hdr(skb, skb_network_offset(skb)))
> +		return true;
> +
> +	/* Tunnels without an inner network header, such as SCTP-in-UDP or
> +	 * PSP, have no inner IP header and thus no inner extension header.
> +	 */
> +	if (skb->encapsulation && skb_inner_network_header_was_set(skb) &&
> +	    __skb_has_ipv6_ext_hdr(skb, skb_inner_network_offset(skb)))
> +		return true;
> +
> +	return false;
>  }

[ ... ]

> @@ -3988,8 +3997,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  		return 0;
>  
>  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> -		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
> -		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
> +		if (skb_has_ipv6_extension_hdr(skb))
>  			goto sw_checksum;

[Severity: High]
Does this weaken the check for non-encapsulated IPv6 CHECKSUM_PARTIAL
skbs?

When !skb->encapsulation, validate_xmit_skb() sets the transport header to
csum_start just before it calls skb_csum_hwoffload_help():

net/core/dev.c:validate_xmit_skb() {
    ...
		if (skb->ip_summed == CHECKSUM_PARTIAL) {
			if (skb->encapsulation)
				skb_set_inner_transport_header(skb,
							       skb_checksum_start_offset(skb));
			else
				skb_set_transport_header(skb,
							 skb_checksum_start_offset(skb));
			if (skb_csum_hwoffload_help(skb, features))
				goto out_kfree_skb;
    ...
}

That means the removed skb_network_header_len() test checked that
csum_start sits right after the 40 byte IPv6 header.

The new helper only checks whether the outer nexthdr is one of the six
values listed in ipv6_ext_hdr(). It skips the inner check because
encapsulation is 0.

Take IPv6|UDP|VXLAN|Eth|IP|TCP, or IPv6|IPv6|TCP (nexthdr 41), with
csum_start at the inner TCP header and csum_offset 16. Would that packet
now reach the csum_offset switch and return 0?

Such skbs can come from untrusted input. __virtio_net_hdr_to_skb() is
used by tap, vhost-net and AF_PACKET with PACKET_VNET_HDR. It accepts
VIRTIO_NET_HDR_F_NEEDS_CSUM with any csum_start via
skb_partial_csum_set(). It does not look at nexthdr and does not set
skb->encapsulation.

One case: a guest sends IPv6 VXLAN traffic with a CHECKSUM_PARTIAL inner
TCP header (LCO). The host bridges it to a device that has
NETIF_F_IPV6_CSUM but not NETIF_F_HW_CSUM.

On a device that parses headers itself, such as bnxt, bnxt_exthdr_check()
accepts an outer nexthdr of UDP for non-encapsulated skbs. The hardware
would then fill in the outer UDP checksum and leave the inner TCP checksum
holding only the pseudo-header seed. Before this patch, the kernel
computed these checksums in software.

The skbuff.h description of NETIF_F_IPV6_CSUM covers only "unencapsulated
packets of the form IPv6|TCP or IPv6|UDP where the Next Header field in
the IPv6 header is either TCP or UDP."

gso_features_check() has the same gap. For non-encapsulated skbs, the old
branch removed NETIF_F_TSO6 and NETIF_F_GSO_UDP_L4 whenever the transport
header was not at nh + 40. The new code removes them only when the outer
nexthdr is an extension header.

The commit message talks about removing false positives, but it doesn't
mention this relaxation for non-encapsulated skbs.

Could the offset test stay for the !skb->encapsulation case? For example:

	skb_checksum_start_offset(skb) - skb_network_offset(skb) != sizeof(struct ipv6hdr)

Or could the check require nexthdr to be IPPROTO_TCP or IPPROTO_UDP,
instead of testing ipv6_ext_hdr()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924192128.1197118-1-willemdebruijn.kernel%40gmail.com
