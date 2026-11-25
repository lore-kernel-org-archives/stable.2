Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595995;
	b=MJuerNzCClbqB8F79U1ffGBixGsAI6QSW5c40RdF8YIkApkPYPJFc/vP39DG56ZSB5iH
	 JCB8AYFPEUa6r32/obIyhnUr1qKWfvmzoYAbJc7ap1atJEcpZOcuHJiOCT7NaEp18/2Lw
	 oJP/LCbjB6uuCs9IYz2WAZJDy+DKhKazlehdV2IFVIG56fWpLmacchWPJqiz4/tBggF32
	 UG9Poxubxmal1LIySAS1BinmGFJLygO/ap8xkTPPGsv0bxHvpzNFHXJLisFDBqHL55vq0
	 qGYxvKRAYaxdxjCf/kUtval+ZMZfWIW5zckg8XUKr4gYxiYZHUNRQqfHCkk6YytGTRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6bUUaXheDwdmvzI4JQQqwaTV6Bs4TvG/JF2I5S2nRTI=;
	b=1jH+dlDIHEKZpGGcuGqEu/iyDd8JNHybNBw4s681NnrwUwcuqclVvTJZwaRP3rBeOOgv
	 uV9BKW7BPEoNsmUdblEPcWb0tYJQmAjW6PMdKa22XajKQ9w1fYNvr55djvA+0usaSeglk
	 IWwijKc1VIxsKWP0R8vBtUsraUS0lsGvPeRqQpRdIqwNgL6M96KLqzJKbMJqBbrQM5lhU
	 TSRvHxSe3hKVFEcqhNKt1hBpwD8YTCTzdzzkBV42q9h96GvuntqPRev6WCBMyjoAT6Cza
	 oh9Q7TXWp2KQm7NbRKYvQDm6BMHKykQavd7jziTdbsekSPwJouTu5Dar+DPHrSADiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR6Le8GW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9F606A31E;
	Wed, 25 Nov 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eR6Le8GW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622581F000C0;
	Wed, 25 Nov 2026 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595995;
	bh=6bUUaXheDwdmvzI4JQQqwaTV6Bs4TvG/JF2I5S2nRTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eR6Le8GW2J+u+/ZmgtvXyDp7xKTvzbMXQAGfdagCxZCD+lw8TpdY25FqP90es2voQ
	 NAyw/azLdpsLbLymCm0NX/1TtnECBwrAET/vziKJJNWpHSNfrYY+wRGMob8lwgWmkX
	 YfN4TuQKO7te2WILf4UUjG35zMydyih4TBwRS32G+qNz6QRgu62qZ0GT7CtCuGbkmy
	 Gm5AFB6CfKOPvwyF2S9A6i2WvHO1F3iQ9XYKxj0emye3s1VRk32VcSWFBtpqpvc1Qo
	 DCEWjwjSWaqsoUgdFqs0wPBa51Js9NSSyFp1bnSp9459KqR8MccTFwnM0USdOf46AH
	 E4i86vmZYonSw==
Subject: Re: [PATCH net] xsk: fill in header offsets for TX checksum offload
From: netdev-bot+sashiko@kernel.org
To: kerneljasonxing@gmail.com
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 25 Nov 2026 08:39:53 +0000
Message-ID: <179559599390.3135.18275141505690596469@kernel.org>
In-Reply-To: <20261124083520.45547-1-kerneljasonxing@gmail.com>
References: <20261124083520.45547-1-kerneljasonxing@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xsk_skb_sw_csum() sets protocol, network_header and
  transport_header but leaves skb->mac_header at the ~0 (0xffff)…
- [Medium] The commit message says ICE (ice_tx_csum) and mana
  (skb->protocol) misbehave on AF_XDP copy-mode checksum requests.
- [Medium] For frames with in-band 802.1Q/802.1AD tags, xsk_skb_sw_csum()
  sets skb->protocol to the innermost ethertype returned by…
- [Low] xsk_skb_sw_csum() adds a rejection that the commit message does
  not mention.
- [Low] The new 'csum_start must not point into the L2 header' rule
  applies in only one configuration: AF_XDP copy mode, without…
- [Low] Before setting skb->protocol to a user-chosen ETH_P_IP/ETH_P_IPV6
  and network_header to nhoff, xsk_skb_sw_csum() only checks…

--

xsk: fill in header offsets for TX checksum offload

This patch makes xsk_skb_sw_csum() parse the Ethernet header and any
in-band VLAN tags of AF_XDP copy-mode frames that request TX checksum
offload. It then sets skb->protocol, the network header and the transport
header. Frames whose csum_start points into the L2 header are rejected
with -EINVAL.

> Drivers like ICE do read network_header/transport_header
> fields which actually point to the wrong place, leading to wrong action.

[ ... ]

> Also, initialize skb->protocol
> because of some drivers (e.g. mana_start_xmit()) using it.

[Severity: Medium]
Could this description be made more accurate? Before this patch, could
ICE or mana ever get a CHECKSUM_PARTIAL skb from this path?

xsk never set skb->protocol, so it stayed 0. On the
__dev_direct_xmit()->validate_xmit_skb()->netif_skb_features() path,
harmonize_features() then cleared the checksum features on any device
without NETIF_F_HW_CSUM:

net/core/dev.c:harmonize_features() {
    ...
	if (skb->ip_summed != CHECKSUM_NONE &&
	    !can_checksum_protocol(features, type)) {
		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
	}
    ...
}

skb_csum_hwoffload_help() then fell back to skb_checksum_help(), which
computed the checksum correctly in software.

By default ICE only advertises NETIF_F_IP_CSUM, NETIF_F_IPV6_CSUM and
NETIF_F_SCTP_CRC (see ice_set_netdev_features()). On E830 with HW_CSUM
enabled, ice_features_check() still removed the checksum features,
because skb_network_offset() was negative with network_header at 0.

mana only advertises NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM in
mana_probe_port(), so it also always got a software checksum.

So for these devices, doesn't the patch actually turn on hardware TX
checksum offload in AF_XDP copy mode, where the checksum used to be done
in software? The commit message doesn't say this, and the patch is
tagged for stable.

About the transport header: validate_xmit_skb() already sets it from
csum_start before ndo_start_xmit() runs:

net/core/dev.c:validate_xmit_skb() {
    ...
			else
				skb_set_transport_header(skb,
							 skb_checksum_start_offset(skb));
			if (skb_csum_hwoffload_help(skb, features))
    ...
}

So by driver xmit time, only network_header and protocol were wrong. The
new transport header setter still helps ndo_features_check callbacks
such as ice_features_check(), because they run before this point.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index ab2e4fa87a4f0..d599fe161857f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c

[ ... ]

> @@ -1026,10 +1028,37 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  
>  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
>  {
> -	if (unlikely(pool->tx_sw_csum &&
> -		     skb->ip_summed == CHECKSUM_PARTIAL))
> +	struct ethhdr eth_buf, *eth;
> +	int nhoff = ETH_HLEN;
> +	__be16 proto;
> +
> +	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL))
> +		return 0;
> +
> +	if (unlikely(pool->tx_sw_csum))
>  		return skb_checksum_help(skb);
>  
> +	if (unlikely(skb->dev->type != ARPHRD_ETHER))
> +		return 0;
> +
> +	eth = skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> +	if (unlikely(!eth))
> +		return -EINVAL;
> +
> +	proto = eth->h_proto;
> +	if (eth_type_vlan(proto)) {
> +		proto = __vlan_get_protocol(skb, proto, &nhoff);
> +		if (unlikely(!proto))
> +			return -EINVAL;

[Severity: Low]
Is this rejection intended for deeply nested tags? __vlan_get_protocol()
also returns 0 when the VLAN_MAX_DEPTH parse limit is hit, i.e. with 8
or more 802.1Q/802.1AD tags:

net/core/skbuff.c:__vlan_get_protocol_offset() {
	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
    ...
		if (unlikely(!vh || !--parse_depth))
			return (struct vlan_type_depth) { 0 };
    ...
}

When that happens, __xsk_generic_xmit() calls xsk_drop_skb() and the TX
batch fails with EINVAL. This happens even when csum_start is well past
the L2 header. Before the patch these frames were sent, and got a
correct software checksum on non-HW_CSUM devices.

The commit message only talks about rejecting frames whose csum_start
points into the L2 header. Should this case be mentioned too?

Short frames and truncated VLAN headers are rejected too, but there
csum_start does have to point into the L2 header, so the described rule
covers them.

> +	}
> +
> +	if (unlikely(skb_checksum_start_offset(skb) < nhoff))
> +		return -EINVAL;

[Severity: Low]
This check only runs in one configuration: copy mode, without
XDP_UMEM_TX_SW_CSUM, on an ARPHRD_ETHER device.

The same XDP_TXMD_FLAGS_CHECKSUM request is still accepted in these
cases:

  - with tx_sw_csum, because skb_checksum_help() runs first
  - on non-Ethernet devices, because of the early return above
  - in zero-copy mode, where csum_start goes to the driver's
    tmo_request_checksum without any check

Documentation/networking/xsk-tx-metadata.rst just describes csum_start
as the byte offset where checksumming should start. It gives no lower
bound relative to L2 and no error behaviour.

How is user space supposed to know whether such a descriptor will be
sent or fail with EINVAL? Since this change is going to stable, should
the uAPI documentation describe the new constraint?

> +
> +	skb->protocol = proto;

[Severity: Medium]
For frames with in-band VLAN tags, this sets skb->protocol to the
innermost ethertype (e.g. ETH_P_IP), not the outer 802.1Q/802.1AD type.
Doesn't that hide the tags from the core's VLAN-aware feature masking?

include/linux/if_vlan.h:skb_vlan_tagged() {
	if (!skb_vlan_tag_present(skb) &&
	    likely(!eth_type_vlan(skb->protocol)))
		return false;
    ...
}

With the inner protocol here, __netif_skb_features() never intersects
dev->vlan_features. vlan_features_check()->skb_vlan_tagged_multi() also
returns false right away. QinQ frames therefore skip the mask that
limits checksum offload to NETIF_F_HW_CSUM devices.

That mask is used by dflt_features_check() and by drivers like r8169
(rtl8169_features_check() ends with return vlan_features_check(skb,
features)), stmmac, bnxt, bnx2x and mlx4/mlx5.

Before the patch, skb->protocol was 0, so IP_CSUM-only devices got a
software checksum for these frames. Now they get CHECKSUM_PARTIAL
single- and multi-tagged frames that the core normally keeps away from
their hardware. Could that put wrong checksums on the wire?

AF_PACKET does this differently in packet_parse_headers(). It keeps the
outer h_proto in skb->protocol, resets the mac header, and only moves
network_header past the tags:

net/packet/af_packet.c:packet_parse_headers() {
	skb_reset_mac_header(skb);

	if (!skb->protocol && sock->type == SOCK_RAW)
		skb->protocol = dev_parse_header_protocol(skb);
    ...
	if (likely(skb->dev->type == ARPHRD_ETHER) &&
	    eth_type_vlan(skb->protocol) &&
	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
		skb_set_network_header(skb, depth);
}

Would setting skb->protocol = eth->h_proto and resetting the mac header
fit better? skb_vlan_tagged_multi() reads skb_vlan_eth_hdr(), which
depends on skb_mac_header().

> +	skb_set_network_header(skb, nhoff);

[Severity: Low]
Should there be a check that an L3 header of type proto fits between
nhoff and csum_start?

The only layout check above is csum_start >= nhoff, and
xsk_skb_metadata() only requires csum_start + csum_offset + 2 <=
desc->len.

Take a 22-byte frame on ICE with h_proto 0x0800, csum_start 14 and
csum_offset 6:

  - ice_features_check() sees network offset 14 and an L3 length of 0,
    and lets the frame through.
  - skb_csum_hwoffload_help() accepts csum_offset 6, which equals
    offsetof(struct udphdr, check).
  - ice_tx_csum() then reads l4_proto = ip.v4->protocol at frame offset
    23. That is past skb->tail, in tailroom that sock_alloc_send_skb()
    does not zero.

That uninitialized byte then picks the L4 type and length written into
the TX descriptor, with an IP length of 0. Before the patch, such frames
got a software checksum.

Would a minimal check help here? For example, require csum_start - nhoff
to be at least sizeof(struct iphdr) or sizeof(struct ipv6hdr), and leave
protocol unset otherwise. That would keep these frames on the old
software checksum path.

> +	skb_set_transport_header(skb, skb_checksum_start_offset(skb));

[Severity: High]
Should the mac header be set here too? skb->mac_header still holds the
~0 sentinel from __finalize_skb_around(), and mac_len is 0. Neither the
xsk TX path nor __dev_direct_xmit() calls skb_reset_mac_header().

With the correct network offset, ice_features_check() now lets these
skbs through for hardware offload. On E830 with NETIF_F_HW_CSUM (GCS)
enabled, ice_tx_csum() computes:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_csum() {
    ...
		/* Set GCS */
		u16 csum_start = (skb->csum_start - skb->mac_header) / 2;
    ...
}

It then writes this value through FIELD_PREP(ICE_TX_GCS_DESC_START_M,
...), where ICE_TX_GCS_DESC_START_M is GENMASK(7, 0).

For example, take headroom 64 and an IPv4/UDP frame with csum_start 34.
That gives skb->csum_start = 98:

  - (98 - 65535) / 2 = -32718, which is 0x8032 as a u16 and 0x32 after
    the mask.
  - The NIC is then told the checksum starts 100 bytes into the frame
    instead of 34.

Wouldn't that put a corrupted frame on the wire? Before the patch,
ice_features_check() stripped the checksum features and the stack
computed a correct software checksum. That makes this a regression on
the driver the commit message says it fixes.

There is also a related issue that predates this patch.
ice_xmit_frame_ring() reads the mac header for every xsk copy-mode skb
whose priority is not TC_PRIO_CONTROL:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_xmit_frame_ring() {
    ...
	eth = (struct ethhdr *)skb_mac_header(skb);
    ...
}

With mac_header unset, eth->h_proto is read from skb->head + 0xffff +
12. Resetting the mac header only for CHECKSUM_PARTIAL skbs would not
fully fix that.

Would it help to call skb_reset_mac_header(skb) and set skb->mac_len =
nhoff next to the new header setters? That may be needed for every xsk
generic TX skb on Ethernet devices, not only CHECKSUM_PARTIAL ones.

> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124083520.45547-1-kerneljasonxing%40gmail.com
