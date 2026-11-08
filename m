Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175710;
	b=f0J7V5PdkKRkxQkUMYFZUwZvXhnBJKQOmhKakt9U9pvdCw//+ifp4jsNa++afu8bzgGw
	 ts+ISaQoFz87qDuB0SYTfjyqjJXeASIBK2k9YCv8OIeeDHZaFMMoXaon5pAm27sO//Izs
	 KTjWiAyko4uR6YF8FRGkECt2dkbt6itgJdzcitvNJnTh12pJH4JSqODOAmyPCYTMjjo8F
	 M0fAEhlZLGZqdRi359K6Edl8FSAGSRrthc7W0FRS2sxdesI2GS60h3Pn8z5nHOBbePbLy
	 2gmPLMV3kI7/+t1pzPDmUt/lKtKI7cgtx9VOHwvXM4S524gcbjSPyn3r5/UXqqM9SnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175710;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iTZBGe8G+lD7PKpVW+guhg/OgKRa7+G7PTCcyuD4K7k=;
	b=OEM3bsz08cKAUZfYK1rIEDMLD3AJE/S+P3Qiy+F4k+VTuPuCH8Wfpt1gm7n1fRXvIIpn
	 MaBgE64K2fmWv8KGjQA5u8msnt2gvihNppUsa8iGMhS39FiN5bgyONKw3qQbCeWKdFLFj
	 hYzYzC+kDwQ9G+kqf25xMXE1mgR+nBrkkeR6NdKYLS49HYf/BmsNg9pBqUrHEg3s35ezn
	 9lwwDmwTwvEeoUEU1j4Jealm74BD6n1mUKk3OUmYWXhcu2yj1yozfpy6+GxPrxqlNltFL
	 8aw0IGfaVs13jsxtD5sai4wWI+oBGFhGZ5rhSfiCXCNXGZ+bfRm7nTBjnIp7y+oitCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6wBI8kG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E401D606D810;
	Sun,  8 Nov 2026 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6wBI8kG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232631F0089F;
	Sun,  8 Nov 2026 22:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794175709;
	bh=iTZBGe8G+lD7PKpVW+guhg/OgKRa7+G7PTCcyuD4K7k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k6wBI8kG/XcVE9XlmLOiJLBUSHxx63al9ouLQqMT4/MLNoGLvJMg2uo5hYZyTCBW3
	 KRaczsKwaEM56lUjexcJ/baDZ6AwffSWv3u8B47OzhvvQpJfW9XMwWKD5rPVxRb26i
	 Od8LBrxblSQBUiCNhJNxwySeq+jbnZzDe0oBzyMOG03UKc34lCLJ7topGqUcrfNuES
	 UCX8rgvRUExXI8CeeXxDFcPsALA+ScjKnF3BQa9OJdqxdV6vLMvRsHiGdZZnbd5mxp
	 SCil7Lgecui+P3tqkqRgLP12SMe1LPmUBPv2rlkpsDnvJPBIc2WNl0A4FC7l2OLNQY
	 W17tKvpCOKQcA==
Subject:
 Re: [PATCH net v8 3/4] net: hsr: segment GSO before per-frame forwarding
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
Date: Sun, 08 Nov 2026 22:08:27 +0000
Message-ID: <179417570768.994134.12148285775525774237@kernel.org>
In-Reply-To: <20261107220544.20-4-xiexinet@gmail.com>
References: <20261107220544.20-4-xiexinet@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Setups with HSR offload now lose GSO on TX, and the commit
  message does not mention it.
- [Medium] hsr_forward_input() protects software segmentation only with
  skb_share_check(), which handles skb_shared() (users > 1) by cloning.
- [Low] hsr_forward_input() now drops every GSO skb whose effective
  protocol is ETH_P_HSR or ETH_P_PRP (net/hsr/hsr_forward.c:916-917),…

--

net: hsr: segment GSO before per-frame forwarding

This patch adds hsr_forward_input() as the single forwarding entry point
for master TX and slave RX. It segments GSO skbs in software before the
per-frame HSR/PRP tagging and sequence numbering, and drops aggregates
with inner HSR/PRP, unreadable frags or trailing data. It also removes
NETIF_F_GSO_MASK from the master's hw_features.

> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index fc512204600cd..2521a72280aca 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c

[ ... ]

> @@ -686,7 +684,7 @@ void hsr_dev_setup(struct net_device *dev)
>  	dev->needs_free_netdev = true;
>  
>  	dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HIGHDMA |
> -			   NETIF_F_GSO_MASK | NETIF_F_HW_CSUM |
> +			   NETIF_F_HW_CSUM |
>  			   NETIF_F_HW_VLAN_CTAG_TX |
>  			   NETIF_F_HW_VLAN_CTAG_FILTER;

[Severity: Medium]
Does removing NETIF_F_GSO_MASK here cause a TX performance regression on
lowers with HSR tag insertion offload, such as xrs700x or icssg?

Before this patch the master kept TSO even when the lowers had none. The
master port is in hsr->ports, so hsr_features_recompute() folds in the
master's own features:

net/hsr/hsr_device.c:hsr_features_recompute() {
    ...
	features &= ~NETIF_F_ONE_FOR_ALL;
	hsr_for_each_port_rtnl(hsr, port)
		features = netdev_increment_features(features,
						     port->dev->features,
						     mask);
    ...
}

On NETIF_F_HW_HSR_TAG_INS lowers, the aggregate was passed on unchanged:

net/hsr/hsr_forward.c:hsr_create_tagged_frame() {
    ...
	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
		return skb_clone(frame->skb_std, GFP_ATOMIC);
	}
    ...
}

prp_create_tagged_frame() does the same. The lower's validate_xmit_skb()
then segmented the aggregate, and the hardware tagged and numbered each
wire frame. So GSO already worked correctly on these setups.

The mask is now removed whatever the lowers support. The core therefore
segments every local super-packet before hsr_dev_xmit(). Each MSS-sized
frame then goes through these steps on its own: seqnr_lock,
fill_frame_info(), the node list lookup, hsr_register_frame_in(), a
clone per port and dev_queue_xmit().

RX is affected too. Plain aggregates that used to be delivered correctly
are now segmented in hsr_forward_input() with features = 0. That means
linear copies and software checksums. One example is a PRP SAN aggregate
arriving from a veth on LAN A/B. Plain TAG_RM aggregates would be
affected as well. In-tree offload drivers should stop producing those
once the GRO patch in this series is applied.

This patch carries a Fixes: tag, so it will be picked up for stable.
Should the commit message mention the cost for offload setups?

Could the feature removal and the segmentation apply only when software
tagging is actually needed?

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 44f6d9c83180a..c9cd5d9208795 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -794,3 +797,154 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)

[ ... ]

> +void hsr_forward_input(struct sk_buff *skb, struct hsr_port *port)
> +{

[ ... ]

> +	if (!skb_frags_readable(skb))
> +		goto drop;
> +	proto = hsr_gso_effective_proto(skb, &l3off);
> +	if (!proto)
> +		goto drop;
> +	if (proto == htons(ETH_P_HSR) || proto == htons(ETH_P_PRP))
> +		goto drop;

[Severity: Low]
Will this also drop locally destined traffic from unpatched HSR senders?

An unpatched HSR master advertises TSO, and hsr_create_tagged_frame()
pushes one HSR tag onto the whole aggregate. A virtio/tap lower with
HW_CSUM and TSO carries that skb to the peer unchanged, as a
VIRTIO_NET_HDR_GSO_TCPV4 packet.

Before this patch, a receiver with a tap/virtio HSR slave stripped the
tag in create_stripped_skb_hsr(). That uses __pskb_copy(), which keeps
the GSO metadata, and the result went to the master for local delivery.
So local TCP worked.

With this patch, hsr_gso_effective_proto() returns ETH_P_HSR and the skb
is dropped before local delivery. TCP from an unpatched HSR guest to a
patched host would then degrade to RTO-driven single-MSS
retransmissions.

The commit message covers the PRP case:

  "Older PRP senders can append one RCT to a whole GSO skb. Such
  aggregates, including locally destined ones, are now dropped instead
  of being delivered."

Should it also mention the HSR case? It only happens with mixed kernel
versions over tap/virtio. veth cannot trigger it, because both ends run
the same kernel.

> +	if (hsr_gso_trailing_data(skb, proto, l3off))
> +		goto drop;
> +
> +	/* Segmentation writes skb->cb and header metadata: work on a
> +	 * private skb if the input is still shared with a packet socket.
> +	 */
> +	skb = skb_share_check(skb, GFP_ATOMIC);
> +	if (!skb) {
> +		hsr_gso_drop_stat(port);
> +		return;
> +	}
> +
> +	/* features = 0 requests full software segmentation into single
> +	 * wire frames; tx_path is true only for locally generated
> +	 * traffic on the master.
> +	 */
> +	segs = __skb_gso_segment(skb, 0, port->type == HSR_PT_MASTER, 0);

[Severity: Medium]
Is skb_share_check() enough to protect the packet data here? It only
handles skb_shared() (users > 1). A cloned skb (users == 1,
cloned == 1) still shares its data with another holder. So does the
clone that skb_share_check() creates itself.

On RX ports tx_path is false, so __skb_gso_segment() calls
skb_cow_head() only for CHECKSUM_NONE:

net/core/gso.c:skb_needs_check() {
	if (tx_path)
		return skb->ip_summed != CHECKSUM_PARTIAL &&
		       skb->ip_summed != CHECKSUM_UNNECESSARY;

	return skb->ip_summed == CHECKSUM_NONE;
}

The GSO handlers then write checksum fields into the head's linear data.
udp4_ufo_fragment() does this for every SKB_GSO_UDP input:

net/ipv4/udp_offload.c:udp4_ufo_fragment() {
    ...
	uh->check = 0;
	csum = skb_checksum(skb, 0, skb->len, 0);
	uh->check = udp_v4_check(skb->len, iph->saddr, iph->daddr, csum);
    ...
}

tcp4_gso_segment() also rewrites th->check whenever ip_summed is not
CHECKSUM_PARTIAL.

An RX skb reaching hsr_handle_frame() can be cloned. Two ways this
happens:

  - packet_rcv() on a non-mmap AF_PACKET socket bound to the port
  - a tc ingress mirred mirror

A guest or tap user can inject UFO frames through
virtio_net_hdr_to_skb(), either on the interlink or on a PRP LAN as a
SAN.

In that case, could the other clone holder see the rewritten UDP
checksum bytes? It could also race with them if it segments or
checksums the same data at the same time.

The comment above says segmentation writes skb->cb and header metadata,
but it writes packet bytes as well. Before this patch, software HSR
worked on __pskb_copy() copies with private heads, so this write appears
to be new.

Would calling skb_cow_head(skb, 0) or skb_unshare() before
__skb_gso_segment() on the RX path close this? For reference,
openvswitch's RX path uses the same skb_share_check() plus
tx_path = false pattern.

> +	if (IS_ERR_OR_NULL(segs))
> +		goto drop;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107220544.20-1-xiexinet%40gmail.com
