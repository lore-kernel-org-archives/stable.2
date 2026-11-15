Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701859;
	b=TCvRTOJu9LsdRGMcI+KToQZeYZmJ/x0EP/HsR0FkHTbdNUQzrJLJiARgVsKip38qAFwd
	 3YKukzlvhkMpiKzOu2rCi9ID8I/wuJVe23q5Clz2HBbQu1SrkhzEvietlHdN5OLmIw9HG
	 aoW9N60RuiFtRww0mbavSYR3KQy9OKE8FwTyQXy1EmzGYXjO8ckMcMCsdd4TlXhSFto7k
	 zLjSVWqOvD7yy6s/C1z9/fJXPKLziBH9cw3LDcd/bu5evHnfX3BoK8hTd+/t3A93SqaiE
	 4FCN4pOso0rIlaU92epQ8ypK6DLPUu8wB6K02GGfjgQg7mG+hkibaLJ5zck1UQybx9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701859;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cPHfgVRbTXSIyS09BtGyAOJjL7U98A/heN5ufhZ98sw=;
	b=NQwgXIKiEHvLMO5/ueq0LVSP1knRS/UeDMBlj5EE/Zh5Xcqk+zmpCYTw3hvBiXGY2db+
	 DoYPhXfQV/o0HJb8Bjdjbrww2ULXSOWGCPDzzjjttVKATbPmG/urQ0ZFowQwqxTtA0p0K
	 /LZSfbzP0Ev/4aaEnVxEJaAdgEtN1DZFG9xsVv3OwhtsspfqMLaSFXQvvY/rIasuPLsU8
	 phkv1TI4XJQbZrzoZmNZS892QzM3qhPLSsi5ZNYZ5lRJg0jQtWIpbi/vO7DIzcVgo0rjg
	 uyTPxuxcUAPbDn/UzQ3vLlrbKtmlocL1/MUlgrn7nd5DxU+Ai6x+T9wwTDmgobP1Chw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfi2vrD9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A9606A323;
	Sun, 15 Nov 2026 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfi2vrD9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E7A1F000C4;
	Sun, 15 Nov 2026 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701859;
	bh=cPHfgVRbTXSIyS09BtGyAOJjL7U98A/heN5ufhZ98sw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gfi2vrD9i2UYqF1SKKqh0K99NwXjNMB3ECILkZsvnsAuYv5ILsOYPVv1HZbx7mlBw
	 lT25ksmiw1a3ErvglCh2weS6sx54JMBKFUR91X/JEUAU45H8U3g+3nb2XBHtpzL3Pq
	 11gOR6MuVxI9tSVAXdE8DhHCB1CHzp7o0vV+3sH9Gs4ucY+9ARHir+ASlGs+42eL+a
	 VkW9gRnGoAngNHZ/JR4G57LI04fa4PSZoQwuwosL/JRQHD9Asfpt/skc8KdMUqJNX3
	 7eNiU3H8zq/NOZ7nIaxPQQtyslPue9YUPeCLgONQ3HNctV6xtb7YyULdbN4YOZSdel
	 i8QH6I8H/IR6w==
Subject:
 Re: [PATCH net v3] net: preserve skb header offsets during headroom changes
From: netdev-bot+sashiko@kernel.org
To: kylebot@openai.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Sun, 15 Nov 2026 00:17:38 +0000
Message-ID: <179470185834.2199510.9040920740659295930@kernel.org>
In-Reply-To: <20261113235019.74384-1-kylebot@openai.com>
References: <20261113235019.74384-1-kylebot@openai.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] skb_header_offsets_fit() checks only some of the head-relative
  offsets that skb_headers_offset_update() moves.
- [Medium] mpls: mpls_forward() checks skb_headroom() after reading
  wrapped mpls_hdr()

--

net: preserve skb header offsets during headroom changes

This patch adds skb_header_offsets_fit() so that pskb_expand_head() and
skb_copy_expand() reject headroom growth that would wrap the 16-bit skb
header offsets. It also adds headroom bounds checks to skb_mpls_pop(),
mpls_forward() and mpls_xmit(), so a large-headroom device such as netkit
can no longer push network_header past U16_MAX on those paths.

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

[Severity: Medium]
Should inner_transport_header and inner_mac_header be checked here too?

skb_headers_offset_update() moves all three inner offsets unconditionally:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
	skb->inner_transport_header += off;
	skb->inner_network_header += off;
	skb->inner_mac_header += off;
}

On an encapsulated skb, inner_transport_header usually sits past
inner_network_header by the inner L3 header length (20 bytes for IPv4, 40
or more for IPv6). An nhead between U16_MAX - inner_transport_header and
U16_MAX - inner_network_header passes this check. inner_transport_header
then still wraps to a small value behind skb->data.

One way to reach this is __skb_cow() from ip_forward() with a
large-headroom egress device such as netkit. inner_mac_header isn't
checked either, and it has no unset sentinel.

Could the wrapped inner offsets then confuse tunnel GSO and header length
users such as skb_inner_transport_offset(), inner_tcp_hdrlen() and driver
TSO setup?

> +
>  void skb_headers_offset_update(struct sk_buff *skb, int off)
>  {
>  	/* Only adjust this if it actually is csum_start rather than csum */

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

[Severity: Medium]
This check runs after mpls_forward() has already read the label.

By the time mpls_forward() is called, __netif_receive_skb_core() has
done skb_reset_network_header(). Suppose the skb arrived with headroom
above U16_MAX, for example looped back from a netkit peer with a large
needed_headroom after eth_type_trans() pulled ETH_HLEN. Then
network_header is already truncated and no longer points at skb->data.

mpls_hdr() is just skb_network_header(). So before the new check is
reached:

mpls_forward()
    hdr = mpls_hdr(skb);
    dec = mpls_entry_decode(hdr);
    rt = mpls_route_input_rcu(net, dec.label);
    ...
    nh = mpls_select_multipath(rt, skb);

This decodes a label from stale headroom bytes near skb->head.
mpls_select_multipath() -> mpls_multipath_hash() then walks up to
MAX_MP_SELECT_LABELS entries plus an inner IPv4/IPv6 header from the
same wrapped pointer.

The earlier pskb_may_pull(skb, sizeof(*hdr)) only guarantees bytes at
skb->data, not at the wrapped network header. The route lookup and the
multipath hash are computed on garbage. A lookup miss is also counted
as rx_noroute rather than rx_errors.

v3 moved the mpls_xmit() check ahead of ip_hdr()/ipv6_hdr() for exactly
this reason. Shouldn't the mpls_forward() check also go before the
first mpls_hdr() access, for example right after pskb_may_pull()?
skb_headroom() doesn't change between there and the pop. The same
U16_MAX - sizeof(*hdr) bound would then reject both the offset that
wrapped on receive and the one skb_reset_network_header() would
produce after skb_pull().

[Severity: High]
This check covers the MPLS LWT path. Can the same network_header wrap and
out-of-bounds eth_header() write still happen with no MPLS involved and
without going through pskb_expand_head()?

netkit accepts any u16 headroom and stores it in needed_headroom:

drivers/net/netkit.c:netkit_new_link() {
    ...
		if (data[IFLA_NETKIT_HEADROOM])
			headroom = nla_get_u16(data[IFLA_NETKIT_HEADROOM]);
    ...
	if (headroom)
		dev->needed_headroom = headroom;
    ...
}

netkit_set_headroom() does the same. netkit uses ether_setup(), so
hard_header_len is 14. With a headroom of about 65506 or more,
LL_RESERVED_SPACE(dev) becomes ((14 + 65535) & ~15) + 16 = 65552, which is
above U16_MAX.

A UDP socket or an unprivileged ping socket sending over a route to that
device then goes through:

__ip_append_data()
    hh_len = LL_RESERVED_SPACE(rt->dst.dev);
    skb_reserve(skb, hh_len + exthdrlen);
    skb_reset_network_header(skb);

skb_reset_network_header() only has a DEBUG_NET_WARN_ON_ONCE(), so
network_header is silently truncated to 16 and transport_header to 36.

ip_finish_output2() only expands the head when headroom is short:

	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
		skb = skb_expand_head(skb, hh_len);

Here headroom is already >= hh_len, so neither pskb_expand_head() nor the
new skb_header_offsets_fit() check runs.

neigh_resolve_output() or neigh_connected_output() then does:

	__skb_pull(skb, skb_network_offset(skb));

The offset is -65536, which is 0xFFFF0000 as an unsigned value. skb->data
moves forward by about 4 GiB, and dev_hard_header()->eth_header()->
skb_push() writes 14 bytes there. skb_under_panic() doesn't fire because
data is still above head.

This is the failure the commit message describes. Creating the netkit
device only needs CAP_NET_ADMIN, which an unprivileged user namespace
provides.

Would it be better to fix the root cause, for example by capping the
netkit headroom so LL_RESERVED_SPACE() always fits in the 16-bit offsets,
rather than adding checks to individual consumers like mpls_xmit()?

>  	skb_forward_csum(skb);
>  
>  	tun_encap_info = mpls_lwtunnel_encap(dst->lwtstate);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113235019.74384-1-kylebot%40openai.com
