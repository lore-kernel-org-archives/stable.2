Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549116;
	b=p836NGZAswx/xbBATFx8Q8kVoJs+8567W8ZbP4t5NfqhsOsTFRPFqQxpqCMNOiHEHyD9
	 BahEduRmisp3jqNokVafQOMfeQ3s3NyfRETV93wJ/PzJSl86em4onIlj5LzK8aeyrc62J
	 jpV6srZeKXxLV+X3XVpYcN1cB4hYcVhf7rrvHvj7jarS1Bj8IO2a4AQj0GRsM31LYE8Ao
	 N7urEilTTuTtRltG8vp6Z0sCoUGVzsbv3oPYbXfcHJNqTjJ3ZjK5YT7G+AfCUXQqZuppL
	 v/hj2aEUFGOz2qYcai3NnRwyC/YxHBkjTu+SNZlvPTHqBYejHUUhU7Ac2KT6V4KVp4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549116;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nIMwh/EZ5KBGfXndC+0JmUW1NvrySoPw8ZiRjJBqJec=;
	b=byN/aOjM55uF4JQYmdoxMR5QnSud68l8yunLYpD3iow+4OuYbRJb5D39vgGWjrvlgd6r
	 02JcI/jYACFGjMbkcXPbZKArkX1T2Qkqzy0zvBdYOSjE8Vp1GK1Xq27xkkXDQfnOvJ1Yr
	 3iiwG4TIF32vMdhj0XJMrWQ3V29Ky6jQ59tKs5zh1OrAaenquvpgQfvl1zsYzmsTxNnzU
	 JtUCRETT1TSGF/0egVvWKV3IjRCKqcx7HYhDD1UGspCw2RubwXaGMxFQACxQjz7kx7NzI
	 /pCius8R/JTpi3Pr5RmalNltDcFhKycV0pUGKtqRJcatXgKtCosfofutGtvybMpKhAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXYpuTqh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6D606A31E;
	Tue, 24 Nov 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXYpuTqh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5DE1F000CF;
	Tue, 24 Nov 2026 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795549115;
	bh=nIMwh/EZ5KBGfXndC+0JmUW1NvrySoPw8ZiRjJBqJec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZXYpuTqhBYTkz2wb/VlF0ju2SHfd0LxXzU5cnaZnXa++mk+htMLkr28DmuezixwlG
	 ExZZ9hWGdAx4NVxRN01p260RSOnt6qgiQ/pt4OcJjpSAko6toLC3TXVzTrRh8ILsAd
	 58MvXL9NKd3aOp1rWjv+KBs4sRzT9iVCStnkWPdXbMYGCTKfBy8I/Q54RjkcC+YW4j
	 UnDjYYXr4XQtq+ihQoBnFM74QYaVOyl5wWMQ3GFjd5jidLFUSn3iBPsZGE1fragRpX
	 ZWHOe2t+HMvremb/ogaKqk7YxuBoJrtIwPBE8swh3vZGfvoWjjMZ4f1PQNDSHQPhO5
	 Gj1F5ZcWVaXxg==
Subject:
 Re: [PATCH net v4] net: preserve skb header offsets during headroom changes
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 19:38:34 +0000
Message-ID: <179554911437.3135.8676992672560141664@kernel.org>
In-Reply-To: <20261120192330.48965-1-kylebot@openai.com>
References: <20261120192330.48965-1-kylebot@openai.com>
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

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [High] net: skb_headers_offset_update() corrupts unset transport and
  inner_network sentinels
- [High] net: u16 transport_header wrap after skb_mpls_pop() and
  mpls_forward()
- [Medium] skb_header_offsets_fit() (net/core/skbuff.c:2133-2153) is
  meant to ensure that skb_headers_offset_update() cannot wrap any…

--

net: preserve skb header offsets during headroom changes

This commit adds skb_header_offsets_fit(), which makes pskb_expand_head()
and skb_copy_expand() reject growth that would wrap the 16-bit skb header
offsets. It also adds headroom bounds to skb_mpls_pop(), mpls_forward()
and mpls_xmit(). This stops MPLS processing from producing a negative
skb_network_offset(), which leads to an out of bounds write in
eth_header().

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1ac1e327ac4c6..bc836adafecd9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2130,6 +2130,28 @@ struct sk_buff *skb_clone(struct sk_buff *skb, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(skb_clone);
>  
> +static bool skb_header_offsets_fit(const struct sk_buff *skb,
> +				   unsigned int nhead)
> +{
> +	if (!nhead)
> +		return true;
> +	if (nhead > U16_MAX - skb->network_header)
> +		return false;
> +	if (skb_transport_header_was_set(skb) &&
> +	    nhead >= U16_MAX - skb->transport_header)
> +		return false;
> +	if (skb_mac_header_was_set(skb) &&
> +	    nhead >= U16_MAX - skb->mac_header)
> +		return false;
> +	if (skb->ip_summed == CHECKSUM_PARTIAL &&
> +	    nhead > U16_MAX - skb->csum_start)
> +		return false;
> +	if (skb_inner_network_header_was_set(skb) &&
> +	    nhead > U16_MAX - skb->inner_network_header)
> +		return false;
> +	return true;
> +}

[Severity: High]
The was_set() checks here assume that an unset transport_header or
inner_network_header keeps its sentinel value across relocation.
skb_headers_offset_update() only does that for mac_header:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
	skb->transport_header += off;
	skb->network_header   += off;
	if (skb_mac_header_was_set(skb))
		skb->mac_header += off;
	skb->inner_transport_header += off;
	skb->inner_network_header += off;
	skb->inner_mac_header += off;
}

Can this turn unset headers into set ones and then make later
expansions fail?

With a positive off, an unset transport_header (~0U from
__finalize_skb_around() or skb_unset_transport_header()) becomes
off - 1. An unset inner_network_header (0) becomes off. After that,
skb_transport_header_was_set() and skb_inner_network_header_was_set()
both return true, for offsets that point into the headroom in front
of skb->data. The commit message says a set transport header must
not be relocated onto its unset value, but the opposite direction
is not handled.

With a negative off, the 0 sentinel becomes 65536 + off and the ~0U
sentinel becomes 65535 + off. Both then look set and sit near
U16_MAX. A negative off happens in skb_copy_expand() when
newheadroom < oldheadroom. It can also happen in skb_segment(),
skb_segment_list() and skb_pp_cow_data().

Any later pskb_expand_head() on that skb with nhead >= -off then
fails skb_header_offsets_fit() and returns -EINVAL. The same
expansion succeeded before this patch. Callers such as
skb_cow_head() on tunnel or driver TX paths would therefore start
dropping ordinary non-encapsulated packets after segmentation or a
shrinking copy.

Should skb_headers_offset_update() leave unset transport and inner
headers alone, as it already does for mac_header? Or should
skb_header_offsets_fit() stop relying on the was_set() helpers for
these fields?

[Severity: Medium]

skb_headers_offset_update() moves more inner offsets than this function
checks:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
	skb->inner_transport_header += off;
	skb->inner_network_header += off;
	skb->inner_mac_header += off;
}

Can inner_transport_header or inner_mac_header still wrap after this check
passes?

In an encapsulated skb, inner_transport_header is normally
inner_network_header plus the inner L3 header length. If
inner_network_header + nhead lands at or just below U16_MAX, the check
above passes, but inner_transport_header wraps to a small value near the
start of the new head.

Earlier processing can also leave stale inner_mac_header or
inner_transport_header values that are larger than inner_network_header.
For example, mpls_xmit() resets only the inner network header.

Inner GSO segmentation, skb_inner_transport_offset() and driver encap
offload paths would then use a wrapped offset. A complete trigger hasn't
been traced, but should inner_transport_header and inner_mac_header be
bounded here as well?

[ ... ]

> diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
> index 1a1a0eb5b787f..5123394234cc5 100644
> --- a/net/mpls/mpls_iptunnel.c
> +++ b/net/mpls/mpls_iptunnel.c
> @@ -59,6 +59,9 @@ static int mpls_xmit(struct sk_buff *skb)
>  	    !dst->lwtstate || skb_warn_if_lro(skb))
>  		goto drop;
>  
> +	if (unlikely(skb_headroom(skb) > U16_MAX))
> +		goto drop;
> +

[Severity: High]

This check implies that skbs already reach mpls_xmit() with more than
U16_MAX of headroom and a wrapped network_header. In that case the wrap
happened before any expansion.

Is the same wrap, and the eth_header() write that follows, still reachable
without MPLS and without pskb_expand_head()?

netkit accepts any u16 headroom (the policy is a plain NLA_U16):

drivers/net/netkit.c:netkit_new_link() {
    ...
		if (data[IFLA_NETKIT_HEADROOM])
			headroom = nla_get_u16(data[IFLA_NETKIT_HEADROOM]);
    ...
		dev->needed_headroom = headroom;
}

netkit_set_headroom() does the same through ndo_set_rx_headroom.

ether_setup() sets hard_header_len to 14. With needed_headroom set to
65535, LL_RESERVED_SPACE(dev) is ((14 + 65535) & ~15) + 16 = 65552.

For a plain UDP/IPv4 send routed over that device:

__ip_append_data()
    hh_len = LL_RESERVED_SPACE(rt->dst.dev);   /* 65552 */
    skb_reserve(skb, hh_len + exthdrlen);
    skb_reset_network_header(skb);             /* stores 16 */

The only thing that catches the truncation is the DEBUG_NET_WARN_ON_ONCE()
in skb_reset_network_header().

ip_finish_output2() then does:

	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
		skb = skb_expand_head(skb, hh_len);

Headroom (65552) is not less than hh_len (65552), so neither
pskb_expand_head() nor the new skb_header_offsets_fit() check runs.

The first packet then goes to neigh_resolve_output() (and later ones to
neigh_connected_output()):

			__skb_pull(skb, skb_network_offset(skb));

Here skb_network_offset() is -65536, which becomes an unsigned pull of
0xFFFF0000. skb->data moves about 4GB forward. Next,
dev_hard_header()->eth_header()->skb_push() writes 14 bytes at that
address, and the driver then reads skb->len bytes from the same place.

Creating a netkit link only needs CAP_NET_ADMIN in the netns. That makes
this look reachable from an unprivileged user namespace with an ordinary
UDP send.

skb_header_offsets_fit() also doesn't bound the resulting headroom
(headroom + nhead). A later skb_reset_*_header() could therefore still
wrap after an expansion that succeeds.

Would it be better to cap the headroom where it comes from? For example,
netkit's needed_headroom could be clamped, or LL_RESERVED_SPACE() kept
within 16-bit offsets, instead of adding checks to individual consumers.

>  	skb_forward_csum(skb);
>  
>  	tun_encap_info = mpls_lwtunnel_encap(dst->lwtstate);

[ ... ]

> @@ -6804,11 +6834,16 @@ EXPORT_SYMBOL_GPL(skb_mpls_push);
>  int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
>  		 bool ethernet)
>  {
> +	unsigned int headroom = skb_headroom(skb);
>  	int err;
>  
>  	if (unlikely(!eth_p_mpls(skb->protocol)))
>  		return 0;
>  
> +	if (unlikely(headroom >= U16_MAX - MPLS_HLEN ||
> +		     (unsigned int)mac_len > U16_MAX - MPLS_HLEN - headroom))
> +		return -EINVAL;
> +
>  	err = skb_ensure_writable(skb, mac_len + MPLS_HLEN);
>  	if (unlikely(err))
>  		return err;

[Severity: High]
Does bounding the post-pop network_header at U16_MAX leave enough
room for the inner L3 header?

After skb_mpls_pop(), the new network_header is
headroom + MPLS_HLEN + mac_len. The check above lets that value
reach U16_MAX.

The new check in mpls_forward() allows the same. It also runs before
skb_cow(skb, hh_len + new_header_size). In the penultimate hop
popping case, skb_cow() can grow the headroom further.
pskb_expand_head() then keeps network_header within U16_MAX only
through skb_header_offsets_fit(). At that point transport_header is
either unset or equal to the outer network_header set by
__netif_receive_skb_core(), so it does not limit the growth much.

The decapsulated packet can then be received as IPv4. For example,
tcf_mpls_act() can pop on ingress, or mpls_forward() can send the
packet to a netkit or veth peer. ip_rcv_core() then does:

	iph = ip_hdr(skb);
	skb->transport_header = skb->network_header + iph->ihl*4;

If network_header + iph->ihl * 4 exceeds U16_MAX, the u16
transport_header wraps to a small offset. If it equals U16_MAX,
transport_header lands on the unset value. ip6_rcv_core() has the
same problem with sizeof(struct ipv6hdr).

ip_local_deliver_finish() then does:

	__skb_pull(skb, skb_network_header_len(skb));

skb_network_header_len() returns transport_header - network_header
as a u32, so the pull length becomes about 0xFFFF0014. On a linear
skb, skb->len wraps to a value that still passes the skb->data_len
check in __skb_pull(). skb->data then moves about 4GB past
skb->head before ip_protocol_deliver_rcu() reads the transport
header.

Setting up the large-headroom device and the MPLS route or pop
action needs CAP_NET_ADMIN in a netns.

Should these checks reserve room for the largest inner network
header? Or would capping the headroom at its source, as suggested
for mpls_xmit(), avoid choosing a margin in each MPLS consumer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120192330.48965-1-kylebot%40openai.com
