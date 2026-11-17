Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958360;
	b=uT39qBCXzpsvat9z/mjGANZHR6o+i59R9PbKsvMJXHRXvj8mqrUR70z6/M7IqRe+o4RI
	 dhRVbVKn6SzClYlAXQl4pyOsfQN/VKrWZLuiSmoFTJ6hQyMHJjKVqJSl5FuGR/i/FDgOH
	 J2RF+F1GGEeg3yb+GmbmqeHcgtcg8QQxcr7jILIYY/NbiMZWjef7jevrGqPhJFP3nSUCn
	 K+PC9ZDvNextCa8yNCW71cwofMR64bbW3d69miCpnNXUy8Bcf6ZqVyaKxWwbRdEkPMrNk
	 cQdZE9+GHNDUXrNamtl0XHfAh/gvJj6Ef1lnGyuWP57Kk0jwu4PHgEXZIQEaOBTZMTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958360;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WiVbIaTi7dNlw1LohPd/8u8xB8/i9d/jmzm4Z28McPg=;
	b=Um91oQnqTSRGnj/wkj9z+G9/QuwSmQ+9f9VDMXPUIHH3G+lK17ledkfiaVzP/z8s972U
	 ZKtW3HZXRkRF+lUvUM9cTdyXBv1DOmPncUJdUw2JZTZHzkL18d3vzliAMqr9XXUKXPWRS
	 QNVHEAwyUinE7n4JzmD3p8Qm5emseslHy0E+1EuoodUihWLxMuwUMF8wAlLwX+o9ixx17
	 iV0cbw8sSoSug6L4UgeZQKWv2dgTx9YQJqm71k+wW7/Rusjl+SDZ3Kh4FnEl/2p9yjPRX
	 7lNlf03UqoW6pq1FNpLH96xvZaPjuv64pC4LiXPZZ/Y75sRlnlipno2hkQm3trRIWLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7imiGXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9C606A32A;
	Tue, 17 Nov 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7imiGXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2971F000C4;
	Tue, 17 Nov 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794958360;
	bh=WiVbIaTi7dNlw1LohPd/8u8xB8/i9d/jmzm4Z28McPg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X7imiGXE04bl+5J2D1ZvA2f8N3woFr8c2H2fMrDINAdSEPFAlk49xrc+PA8eKxsZ1
	 pkK/8K4UKFWZDBQgqwlycK7M4Zf9n6AZEQrC83ja7qu0TSlHdysxDtYu0RLQIu1dB6
	 lClCZey5y50Y4KcMKU2uHo7dKvFMXxQg8fomqAXPeGR9aoDH7EaC1Q504/PjhukKSW
	 zlHw9QGvshfMeuz8+iGq0zE8i9wxHYt9cSqaad1omXEjfBDEHJBBbZxmPdRw2IWw3v
	 yiHZKr2m1FKbL7UhytmZ4YM8RhIXDlFZaQvxxmwr9urj3ESKRY4bFE8UazXVN8MVY3
	 7TbIsNFuP4fMg==
Subject:
 Re: [PATCH net v2] gve: fix checksum state and gso_segs of HW-GRO packets
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, nktgrg@google.com, thostet@google.com,
 willemb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pkaligineedi@google.com
Date: Tue, 17 Nov 2026 23:32:39 +0000
Message-ID: <179495835918.3136.2006086240050992361@kernel.org>
In-Reply-To: <20261116224308.986555-1-joshwash@google.com>
References: <20261116224308.986555-1-joshwash@google.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] gve_rx_complete_rsc()
  (drivers/net/ethernet/google/gve/gve_rx_dqo.c) works out where the TCP…

--

gve: fix checksum state and gso_segs of HW-GRO packets

This patch makes gve_rx_complete_rsc() set the network and transport
headers on HW-GRO packets. For device-verified packets it also seeds
th->check with the TCP pseudo-header checksum and calls tcp_gro_complete(),
so forwarded HW-GRO skbs can be resegmented correctly. IPv4 and IPv6 are
now told apart by EtherType, and gso_segs is computed from the TCP payload
length.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00ab..b4dbfb1ba39b0 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c

[ ... ]

> @@ -1049,10 +1061,50 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
>  		skb_frag_off_add(frag, hdr_len);
>  		skb->data_len -= hdr_len;
>  		skb->tail += hdr_len;
> +		/* napi_gro_frags() pulls the Ethernet header later. */
> +		nhoff = ETH_HLEN;
> +	}
> +
> +	/* The header lengths come from the packet, so make sure the headers are
> +	 * in the linear part before reading them and writing th->check.
> +	 */
> +	if (unlikely(skb_headlen(skb) < nhoff + sizeof(struct iphdr)))
> +		return -EINVAL;
> +
> +	skb_set_network_header(skb, nhoff);
> +	proto = nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->protocol;
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		gso_type = SKB_GSO_TCPV4;
> +		thoff = nhoff + ip_hdrlen(skb);
> +		break;
> +	case htons(ETH_P_IPV6):
> +		gso_type = SKB_GSO_TCPV6;
> +		thoff = nhoff + sizeof(struct ipv6hdr);

[Severity: Medium]
Is it safe to assume the TCP header comes right after the fixed IPv6
header here?

Nothing checks ipv6_hdr(skb)->nexthdr == IPPROTO_TCP or desc->ipv6_ex_add.
The IPv4 case above also uses ip_hdrlen() without checking
ip_hdr(skb)->protocol == IPPROTO_TCP. The only sign that L4 is TCP is the
ptype.l4_type check at the top of gve_rx_complete_rsc().

The descriptor suggests the device does parse IPv6 extension headers:

gve_desc_dqo.h:
	/* Set when IPv6 packet contains a destination options header or routing
	 * header.
	 */
	u8 ipv6_ex_add: 1;

gve_rx_skb_csum() only holds back CHECKSUM_UNNECESSARY when that bit is
set:

	} else if (ptype.l3_type == GVE_L3_TYPE_IPV6) {
		/* Checksum should be skipped if this flag is set. */
		if (unlikely(desc->ipv6_ex_add))
			return;
	}

So an IPv6/TCP packet with a hop-by-hop header and a device-verified
checksum would still be CHECKSUM_UNNECESSARY when it gets here.

Suppose the device coalesces such a packet, or a tunnelled packet whose
ptype reports the inner L4 as TCP. Then thoff would point into the
extension or tunnel header, and tcp_hdrlen() would read doff from the
wrong bytes.

gve_rx_fixup_gro_checksum() would then write the pseudo-header seed at
that offset:

	th->check = ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
				  &ipv6_hdr(skb)->daddr, 0);

tcp_gro_complete() would also set csum_start, csum_offset and
CHECKSUM_PARTIAL at that offset.

Wouldn't a forwarded packet then leave through TSO/GSO with a bad
checksum? That is the same blackholing this patch sets out to fix.

The destination-options and routing cases are CHECKSUM_NONE, but they
still hit the wrong doff. That could drop a valid packet with -EINVAL or
give it a wrong gso_segs. It could also take the new early return:

	payload = skb->len - thoff - tcp_hdrlen(skb);
	if (payload <= rsc_seg_len)
		return 0;

and deliver a multi-segment coalesced packet without gso_size.

Before this patch the RSC path never read or wrote the TCP header, so
this assumption is new. The changelog gives the VLAN guarantee ("The
device does not coalesce VLAN tagged frames"), but says nothing about
IPv6 extension headers or encapsulation.

For comparison, bnx2x_set_gro_params() documents the matching hardware
guarantee ("TPA aggregation won't have either IP options or TCP options
other than timestamp or IPv6 extension headers"). The mlx5 SHAMPO path
checks ipv6->nexthdr == IPPROTO_TCP.

Could the device guarantee be documented in the changelog and in a
comment? Alternatively, could this check ip_hdr(skb)->protocol and
ipv6_hdr(skb)->nexthdr against IPPROTO_TCP (and ihl >= 5), and skip the
GSO and checksum fixup otherwise?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116224308.986555-1-joshwash%40google.com
