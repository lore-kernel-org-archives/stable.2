Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946318;
	b=x1Jp7TdjT1MyaP1VOEYis2XUtArF67/QWHsCk8ZBuAul9fY1WvG6XgvAFy8X5GlcRJsP
	 sT8inVroDRwDaPX7SgtSDV3XHLQwvGGBzMKlLNh3v84eStHfKEzvQFeTwgtXZeZ53KaAO
	 O2ujdoi2JiYE0jASXGE6AQScUaexTYzvxwUuDh34uMUN8iM8tNdmc3AOqFgkWA9G2l3LN
	 eiCxfbHBaV+doqmOW7fZYUUMWV41NxiDlnigno5V3OPglgs6py1WszB1bHJig9XP7yWky
	 Pf3k16oI8iE0Xt5nSGEiOqAE8Tksv3kk9AxYtDkJ5NaJ4e2sEn+NBiQXRbH9ugb38Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946318;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0Xw7sicO49xx1e53p8DOzr3TxFtSjf8C10oK/0OkufU=;
	b=u4MJ1OW97AOikRw6Zeb5QaEbzWrhHD4ZZHALNJb70fCcRtGElPbmoGgirt5HS5U7TfYT
	 Ilj35G2CDzEtjpT124w0RNSASOjGG+cdjf1CqEc8KZh6kpVf/zxM5F1dZ5ZLdke77LoRC
	 iYesNH6Dtc0bIjxChmo0z5qZnNWzKlWdRZcXd9OnSaVm38iLvkSEhFKDiI1q6+RIq6hG6
	 GuFSrwrVUNiLyvo/mDNUR71GvwNsslSu+H5IaUDL1G8KMcAk4c+6Bg25tNWTtWVdbGl8w
	 dCy/M5pazhQhUbyg7TUwCfpTVmuzS/OwPaY3rFYdc7+Y0woOkSRpJDQCl+K3hkNXa9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leN1kErd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F016606A32A;
	Tue, 17 Nov 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leN1kErd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9E51F000C5;
	Tue, 17 Nov 2026 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946318;
	bh=0Xw7sicO49xx1e53p8DOzr3TxFtSjf8C10oK/0OkufU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=leN1kErd7AFeG7YXpOD96U2cg+fIBtINU274Mx04HZ/geophLs7lCkc8WQ9WrxJUc
	 mODjQO/CCsESD4IxLhuD0SKgg7dWVxKkKkzpzKkXdmbhFpIVmYDoQFgaLkh5EutAr/
	 2J0B3RsuLDlrGOYoWiiEbJ0mw8yik8wpToAaZBR3kRoLh7oTiOeyaBU1TrPEUbivIi
	 bKfAFVTYJ+0vL6ccyZHNOmcRbcKV6qvDzZUQ6mdwZd2Rieg12IivDycdbeZjcPhJPB
	 xRC4j8FCj/FLQhIAuJWH5qmOqQd9JcJxLgI2FrgwFEykKP8QYVMMmCUTPuKBlpLH9i
	 /CA4uPtvuwI9A==
Subject:
 Re: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
From: netdev-bot+sashiko@kernel.org
To: joshwash@google.com
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jordanrhee@google.com, nktgrg@google.com, thostet@google.com,
 willemb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pkaligineedi@google.com
Date: Tue, 17 Nov 2026 20:11:56 +0000
Message-ID: <179494631679.3136.4477194401214815440@kernel.org>
In-Reply-To: <20261113195553.2220562-1-joshwash@google.com>
References: <20261113195553.2220562-1-joshwash@google.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Regression: HW-GRO packets in VLAN-tagged TCP flows are now
  dropped.
- [Medium] For IPv6, gve_rx_complete_rsc() assumes TCP always starts
  right after the fixed 40-byte header: `thoff = nhoff + sizeof(struct…

--

gve: fix checksum state and gso_segs of HW-GRO packets

The patch makes gve_rx_complete_rsc() set the network and transport
headers for HW-GRO packets. For packets the device verified, it also seeds
th->check with the pseudo-header checksum and calls tcp_gro_complete() so
the skb becomes CHECKSUM_PARTIAL. It also tells IPv4 from IPv6 by the
EtherType instead of the device packet type, and computes gso_segs from
the TCP payload length.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00ab..58696d26c6986 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c

[ ... ]

> @@ -1017,20 +1039,11 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
>  	if (!rsc_seg_len)
>  		return 0;
>  
> -	switch (ptype.l3_type) {
> -	case GVE_L3_TYPE_IPV4:
> -		shinfo->gso_type = SKB_GSO_TCPV4;
> -		break;
> -	case GVE_L3_TYPE_IPV6:
> -		shinfo->gso_type = SKB_GSO_TCPV6;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -

[ ... ]

> @@ -1049,10 +1061,35 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
>  		skb_frag_off_add(frag, hdr_len);
>  		skb->data_len -= hdr_len;
>  		skb->tail += hdr_len;
> +		/* napi_gro_frags() pulls the Ethernet header later. */
> +		nhoff = ETH_HLEN;
>  	}
> +
> +	skb_set_network_header(skb, nhoff);
> +	proto = nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->protocol;
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		shinfo->gso_type = SKB_GSO_TCPV4;
> +		thoff = nhoff + ip_hdrlen(skb);
> +		break;
> +	case htons(ETH_P_IPV6):
> +		shinfo->gso_type = SKB_GSO_TCPV6;
> +		thoff = nhoff + sizeof(struct ipv6hdr);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

[Severity: High]
Could this cause HW-GRO packets from VLAN-tagged TCP flows to be dropped?

gve sets no NETIF_F_HW_VLAN_* features, and struct
gve_rx_compl_desc_dqo has no VLAN tag field. A tagged frame therefore
arrives here with h_proto (or the skb->protocol set by eth_type_trans())
equal to ETH_P_8021Q or ETH_P_8021AD. That value hits the default case and
returns -EINVAL. The error then ends up as a silent drop:

gve_rx_poll_dqo()
  gve_rx_complete_skb()
    gve_rx_complete_rsc()
      return -EINVAL;
  gve_rx_free_skb(napi, rx);
  rx->rx_desc_err_dropped_pkt++;

Before this patch, gso_type came from ptype.l3_type, which does not depend
on the L2 layout. These packets then went on to napi_gro_frags() or
napi_gro_receive() and were delivered.

The fixed nhoff of 0 or ETH_HLEN also assumes there is no tag. Adding the
VLAN EtherTypes to this switch alone would leave the network and transport
headers pointing at the tag instead of the IP and TCP headers.

The commit message says:

  "tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do"

Both of those drivers strip VLAN tags in hardware. For example, qede sets
NETIF_F_HW_VLAN_CTAG_RX. Also, on an unknown protocol qede_gro_receive()
only logs an error and still delivers the skb.

Would it be better to keep using ptype.l3_type here? Or, for an
unrecognized EtherType, deliver the skb without the fixup instead of
returning -EINVAL? The patch is also tagged for stable, and the commit
message does not mention this behavior change.

> +	skb_set_transport_header(skb, thoff);
> +
>  	shinfo->gso_size = rsc_seg_len;
> -	shinfo->gso_segs = rsc_segments;
> +	shinfo->gso_segs = DIV_ROUND_UP(skb->len - thoff - tcp_hdrlen(skb),
> +					rsc_seg_len);
> +
> +	if (!IS_ENABLED(CONFIG_INET) ||
> +	    unlikely(skb->ip_summed != CHECKSUM_UNNECESSARY))
> +		return 0;
>  
> +	gve_rx_fixup_gro_checksum(skb);

[Severity: Medium]
For IPv6, is it safe to assume TCP always starts right after the fixed
40-byte header?

	case htons(ETH_P_IPV6):
		shinfo->gso_type = SKB_GSO_TCPV6;
		thoff = nhoff + sizeof(struct ipv6hdr);

Nothing checks that ipv6_hdr(skb)->nexthdr == IPPROTO_TCP, and
desc->ipv6_ex_add is not checked here.

gve_rx_skb_csum() withholds CHECKSUM_UNNECESSARY only when ipv6_ex_add is
set:

	} else if (ptype.l3_type == GVE_L3_TYPE_IPV6) {
		/* Checksum should be skipped if this flag is set. */
		if (unlikely(desc->ipv6_ex_add))
			return;
	}

According to gve_desc_dqo.h, that bit only covers Destination Options and
Routing headers. Suppose the device coalesces a TCP flow that carries, for
example, a Hop-by-Hop header. The transport header would then land on the
extension header, and tcp_hdrlen() would read a bogus doff, so gso_segs
would be wrong.

gve_rx_fixup_gro_checksum() would then write the pseudo-header seed at
thoff + 16. With an 8-byte Hop-by-Hop header, that offset is the upper
half of the real ack_seq:

	th->check = ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
				  &ipv6_hdr(skb)->daddr, 0);

tcp_gro_complete() would also set csum_start and csum_offset from the same
wrong offset.

When ipv6_ex_add is set, the checksum write is skipped. The transport
header and gso_segs are still set from the assumed offset, though. Before
this patch, the RSC path did not read or write the TCP header.

The driver doesn't show whether the device's RSC engine ever coalesces
IPv6 packets with extension headers. qede and bnx2x make the same
fixed-offset assumption. If the device can do this, should the code check
nexthdr, or skip the fixup when nexthdr is not IPPROTO_TCP?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113195553.2220562-1-joshwash%40google.com
