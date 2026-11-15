Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745127;
	b=mk4/NHAll4XW4ibVQAO8dyMaPKs+EvnkRxNUwcDQCgDUNB2W4uk4bcWfP6pwOrOwPkQE
	 bw//kpcRIoRWd7PtMijjnCN65yCRunEcalPD7dSFLB0FUCsHL7mh5Q2BtPaIaK5SS/5BP
	 UXnCeoGvyEtaXvP6gF7FD9P9awUHcw3VW1xULIczQawZU5ociTS30NMeJLR1aE8zH24TP
	 VkZlx0dqsUBdo3YOx58CmJ1K8DGW8xXewGkjD6Ry4GsdVqm5C2LLxNvuVEFtDxcT9O8tZ
	 +CK3SlAyLDw4qV+ObcqsVTBw4E2xHnBBZgMonM0AWmz6gyPu3XVQJnEB1SjQmrlfp5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745127;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=f/kL4XOMsZ9Q2OoJp1n7JQq062LRbdy4py7z1SqZZRE=;
	b=XGoRSQZwyEn2rkFXbediuXxye7K5VzTKhmawomlUdK2tVDuBfqZwm2qkGHJUBQNBSPvU
	 haHL+f8RPn4I49iUf5QcNy/tuZyrCzB38pv79l599O4wJFuMzV7vUHjKF/RTygW2kfDR8
	 aplZR+vOFQkefaQ7vd+vz0MntpW1VCFuLsPQiQWP3ZmE6C4I/J0cYxNX+zpLhyWqHgS8Z
	 Khp5gQoV7TZLF7ixi+rLMQXhwboKlJ8nciai0oBnYGbrdmqHFH4WoyZ4VopfTIhhtsHPG
	 671iqtdseLp8HkUdHZTWzk8uM+evFns3MQHXAo035aNdjxmjWSt/uzPNgrF6p+fUMaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwsEEZRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA7606A31D;
	Sun, 15 Nov 2026 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwsEEZRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615031F000C4;
	Sun, 15 Nov 2026 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745127;
	bh=f/kL4XOMsZ9Q2OoJp1n7JQq062LRbdy4py7z1SqZZRE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lwsEEZRq2dLzC1q8knVOYYlT3cxdy6vS3O2GUoZ0XiKX0MwhbbedfMtX/5CFpcHYK
	 noRkiYaS0G6Oy5v9iNHoaoJER30PS2igFSnkDxPZLEwOsCn1C7S5iG6UHRST2c3Jm3
	 Wv7Ac9khDssihy0ihWKJ/rFfvL7enQr1CNXHupzYb/diqdI9B8S3azkVpmcwy42riR
	 sXF6oWCs8efhyY+6UT6oON6yjc1oeE8m4EqMJcI1kgY3FUF+q/wA50JthseYqa1tuS
	 Zw47stTdXF7WdPSipelQw20oePlFusAcOikJDvyKjujScIePoNuWQLgnWkd3/Dopdw
	 rxM9KhrLbHuGg==
Subject: Re: [PATCH net v2] net: validate IPv4 checksum start in
 skb_csum_hwoffload_help()
From: netdev-bot+sashiko@kernel.org
To: zeil@nebius.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 NB-CoreTeam@nebius.com, mst@redhat.com, davem@davemloft.net,
 willemb@google.com, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org
Date: Sun, 15 Nov 2026 12:18:45 +0000
Message-ID: <179474512587.2199510.5717585858244093678@kernel.org>
In-Reply-To: <20261111120448.49979-1-zeil@nebius.com>
References: <20261111120448.49979-1-zeil@nebius.com>
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

- [High] The new check in skb_csum_hwoffload_help()
  (net/core/dev.c:4136-4153) decides whether a packet is IPv4, and where…
- [Medium] When skb->protocol is 802.1Q/802.1AD, the new check finds the
  IPv4 header with __vlan_get_protocol() (net/core/dev.c:4139).

--

net: validate IPv4 checksum start in skb_csum_hwoffload_help()

This patch adds a check at the sw_checksum label of
skb_csum_hwoffload_help(). It rejects IPv4 packets whose csum_start falls
inside the IPv4 header, and returns -EINVAL so callers drop them. The IPv4
header is found at the depth returned by __vlan_get_protocol(), ihl < 5 is
rejected, and the check is skipped when the network offset is negative.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 3c58db732761a..095b1fd38b8b2 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -4130,6 +4133,26 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  	}
>  
>  sw_checksum:
> +	offset = skb_network_offset(skb);
> +	protocol = skb->protocol;
> +	if (eth_type_vlan(protocol))
> +		protocol = __vlan_get_protocol(skb, protocol, &offset);

[Severity: Medium]
Can skb->mac_len be relied on at this point? __vlan_get_protocol() starts
parsing at skb->mac_len - VLAN_HLEN:

net/core/skbuff.c:__vlan_get_protocol_offset() {
	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
    ...
}

Nothing on the transmit path keeps mac_len current. In
validate_xmit_vlan()->__vlan_hwaccel_push_inside(), the tag is pushed and
protocol is set to 0x8100, but mac_len is left unchanged.
__dev_queue_xmit() only resets mac_header. __skb_gso_segment() calls
skb_reset_mac_len() before doing the same kind of parse; this code does
not.

GRE devices that use ipgre_header_ops (NBMA GRE with no remote, or
multicast GRE) are one source of a stale mac_len. __ipgre_rcv() calls
skb_pop_mac_header(), which leaves mac_header at the outer IPv4 header.
dev_gro_receive() or __netif_receive_skb_core() then set mac_len to 20
plus the GRE header length (24 or 32).

Suppose such a CHECKSUM_PARTIAL packet (e.g. from a local veth or virtio
sender) is forwarded out a VLAN subinterface. The real device has no TX
VLAN insertion and ends up at sw_checksum. One way to get there is a real
device with only NETIF_F_IPV6_CSUM: vlan_dev_fix_features() promotes the
VLAN device to HW_CSUM, and harmonize_features() strips IPv4 checksum on
the real device. The egress frame then looks like this:

  MAC 0-11, TPID 12-13, TCI 14-15, 0x0800 16-17, IPv4 18-37, TCP 38-

With mac_len=24, the parser reads a vlan_hdr at offset 20, so the
encapsulated protocol comes from the IPv4 ID field. When the ID is 0x0800,
protocol becomes ETH_P_IP at offset 24. ihl then comes from the low nibble
of the frag_off high byte, which is 0 with DF or no flags, so the packet
gets -EINVAL.

With mac_len=32, the parser reads saddr[0..1]. Any source in 8.0.0.0/16
gives ETH_P_IP at offset 32, and every such packet is dropped.

Before this patch, these forwarded packets were checksummed in software
and sent. Would calling skb_reset_mac_len() first, as __skb_gso_segment()
does, avoid this?

> +
> +	/* Use the parsed VLAN depth: network_header may point at an inner
> +	 * tag. If the network offset is negative, network_header refers
> +	 * to bytes preceding the current packet data and cannot be used
> +	 * to locate the IPv4 header being validated.
> +	 */
> +	if (offset >= 0 && protocol == htons(ETH_P_IP)) {
> +		const struct iphdr *iph;
> +
> +		if (!pskb_may_pull(skb, offset + sizeof(*iph)))
> +			return -EINVAL;
> +		iph = (const struct iphdr *)(skb->data + offset);
> +		if (iph->ihl < 5 ||
> +		    skb_checksum_start_offset(skb) < offset + iph->ihl * 4)
> +			return -EINVAL;

[Severity: High]
Can the sender steer this check both ways? For AF_PACKET, and for tun
IFF_TUN with packet info, the sender sets both skb->protocol and
network_header. Nothing compares them with the frame bytes:

net/packet/af_packet.c:packet_snd() {
    ...
	if (proto != htons(ETH_P_ALL))
		skb->protocol = proto;
    ...
}

net/packet/af_packet.c:packet_parse_headers() {
    ...
	if (!skb->protocol && sock->type == SOCK_RAW)
		skb->protocol = dev_parse_header_protocol(skb);
    ...
}

drivers/net/tun.c:tun_get_user() {
    ...
	skb->protocol = pi.proto;
    ...
}

packet_parse_headers() reads the real ethertype only when skb->protocol
is 0. Its VLAN network_header fixup runs only when skb->protocol is
already a VLAN type. For non-GSO NEEDS_CSUM, __virtio_net_hdr_to_skb()
checks csum_start and csum_offset only against headlen.

The first problem is new drops. Take a SOCK_RAW packet socket bound to
ETH_P_IP with PACKET_VNET_HDR. It sends an 802.1Q-tagged IPv4/TCP frame
(csum_start=38, csum_offset=16) on a device without checksum offload.
eth_type_vlan(ETH_P_IP) is false, so offset stays at 14. ihl is then read
from the low nibble of the TCI high byte (VID bits 11..8):

  VID < 0x500:  ihl < 5, rejected
  VID >= 0x700: 38 < 14 + ihl * 4, rejected

An IPv6 frame labelled ETH_P_IP is rejected the same way, because ihl
becomes the traffic class nibble.

Before this patch, skb_checksum_help() checksummed these frames correctly.
Now validate_xmit_skb() drops them on -EINVAL. Is that intended?

The second problem is a bypass. A PACKET_VNET_HDR sender puts a real IPv4
header in the frame (ethertype 0x0800). It sets sll_protocol to
ETH_P_IPV6, or to a non-IP value such as ETH_P_802_3, and points
csum_start inside the IPv4 header (e.g. 24). protocol == htons(ETH_P_IP)
is false, so the check is skipped. skb_checksum_help() still writes the
folded checksum into the IPv4 header.

That looks like the case the commit message says is now covered for
AF_PACKET with PACKET_VNET_HDR.

In the mislabelled VLAN case, the sender also chooses the TCI bits that
ihl is read from. VID 0x5xx gives ihl=5, so any csum_start >= 34 passes.
That includes 34..37, which are inside the real IPv4 header at 18..37.

The commit message also says:

  "network_header still points at the inner VLAN tag, and ihl would be
  read from the TCI."

That avoidance only holds when skb->protocol matches the frame.

Could the IPv4 header be located from data the sender doesn't control
instead of skb->protocol? For example, use the frame's own ethertype on
Ethernet devices plus an iph->version == 4 check.

> +	}
>  	return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111120448.49979-1-zeil%40nebius.com
