Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797639;
	b=JtO/nxJ1xvZdigjq3cwwRTxHUeDUq6ETEYFIKj2rSicSkhimuyWyFDed88PrIYY8xUF0
	 l7bktcxygLKXeozZN/Fk9u+zbSdKZPgZ1Bj29UzdnCB84tTXItjf9vtsd5xKZs63XleMN
	 lWFmt3Bqxr9wl97745o43LfxDb8op49DZJJR3Qfek3qUMys2OV324Sb3kxTN5TcgPLcY8
	 Nh4WV76yGK6IbZRSSbUm7eTNnMYmHTJm8BTUa1XM4Ol6fdxDHEqWEyfCks8DzE5ofWrcE
	 zLWjwA2Ix8c0ytQaZ1UtEvQvVHjKzS9mGJhst2EU4xbxlSk0xfyrTD77fZyeYR27MNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TVFvA1dgSL+XD2JMzZVnBxKBpaFEsJ9tuGw9vzqbiyc=;
	b=sYDtMKWZ31Q7ylO3oe9pLzjWUiWzBorCFhmpCfeTQE+AoKZxbXryphbWgn+qEWkPHPEA
	 9YJDHzi3sETDQLxGPlMbHxICKqLLDHF/9qkHuJBfznCGSyvJNpRmmz9TTYm9ahpSTR8M1
	 fAXlTz45OP58T4f2w2k+BFj0RMzhhwDJpOv+OBW22o++kX5YKG0b2/M//jlnM12vr7CdF
	 07X4i48vl9Ggn+/GS56g6QSfsKJWw29fdmBi2thjKxT7FrHwm3GagoHK9qPcgKb10p0sK
	 fSvjowuVVzYvQeHak2SSF4keddGfV1vAhisEAQ7zGIsUzc6s7HQ4hLtO1Lp5BPW1CDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ObYa/8P2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76D606A688;
	Fri, 27 Nov 2026 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ObYa/8P2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830A71F00919;
	Fri, 27 Nov 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795797639;
	bh=TVFvA1dgSL+XD2JMzZVnBxKBpaFEsJ9tuGw9vzqbiyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ObYa/8P2f5oLD15V3N0ExvIZ0m0P1nSoywvPSAn62G5VKx9xnOIa44UNeqzC18m+5
	 22uw6irg5FU13bOCWiqv1nSy9CW1Aq5vXa0zX7C/X5J8ZKCvnKYdVre3+XarSmI0XB
	 Hjou5pychNvD4w8x73CB3uy9Po+H8KZeOc9HbfylEZXkbF4mltGnz1pBSqx+9iPAEb
	 eTs+hb33NyKn1P3a1INRRECPXxU7Uh7UVxW0wZSEnaFvc07BG1e1uCBlXgW2u01VZg
	 5qev5HC22cdtu0+iclWEcUYxEQubgKNry+9kKFSm0mR3QBVpwFI0bBgpF0Fh+lHTAV
	 MzjGAh0JXWvVA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>, willemb@google.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Jason Xing
 <kerneljasonxing@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] xsk: fill in header offsets for TX checksum
 offload
In-Reply-To: <20261127105347.72997-3-kerneljasonxing@gmail.com>
References: <20261127105347.72997-1-kerneljasonxing@gmail.com>
 <20261127105347.72997-3-kerneljasonxing@gmail.com>
Date: Fri, 27 Nov 2026 17:40:36 +0100
Message-ID: <87y0aefcsb.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing <kerneljasonxing@gmail.com> writes:

> An XDP_TXMD_FLAGS_CHECKSUM request is turned into an skb carrying
> CHECKSUM_PARTIAL by xsk_skb_metadata() where csum_start/csum_offset/
> ip_summed are set.
>
> However skb->protocol stays 0, the offload never actually reaches
> the hardware and checksum ends up being computed in software every time
> (please see skb_checksum_help() in xsk path):
> 1. harmonize_features() strips the checksum features on devices.
> 2. ice_features_check() rejects the frame on NETIF_F_HW_CSUM capable ice.
>
> The frame layout comes from user space, and request.csum_start is
> already the offset of the L4 header from the start of the frame, so the
> transport header is known exactly.
>
> Only the L2 length has to be found, by parsing the Ethernet header and,
> when present, the VLAN tag stack. skb_header_pointer() is used for that,
> so it works for frames whose data is not in the linear part of the skb.
>
> skb->protocol is set to the outer ethertype, as the rest of the stack does
> for in-band VLAN tags, so skb_vlan_tagged() and vlan_features_check()
> keep seeing the tags. can_checksum_protocol() and the drivers get the L3
> type through vlan_get_protocol(). The mac header is anchored by
> __dev_direct_xmit() in the previous patch.
>
> A frame whose L2 header cannot be parsed, whose L3 type is not IPv4 or
> IPv6, or whose csum_start does not leave room for an L3 header cannot be
> described to the hardware, so it keeps being checksummed in software
> exactly as before.
>
> The patch is based on Maciej suggestion: 1) do not rely on mac header that
> probe in AF_PACKET uses, 2) use skb_header_pointer and walk vlan tags to
> inspect the accurate location of each field that existing drivers
> possibly use.
>
> [1]: https://lore.kernel.org/all/arKm5gCaERk6MaGA@boxer/
>
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload suppo=
rt")
> Cc: stable@vger.kernel.org
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  net/xdp/xsk.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 52d538160e0a..8f566996a6dd 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -11,8 +11,12 @@
>=20=20
>  #define pr_fmt(fmt) "AF_XDP: %s: " fmt, __func__
>=20=20
> +#include <linux/if_arp.h>
> +#include <linux/if_vlan.h>
>  #include <linux/if_xdp.h>
>  #include <linux/init.h>
> +#include <linux/ip.h>
> +#include <linux/ipv6.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
> @@ -1027,9 +1031,48 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
>=20=20
>  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *po=
ol)

nit: Name! Now this helper has a second job; parse the Ethernet/VLAN
headers and set up the skb for hardware offload, even though the
application didn't ask to force software.

>  {
> -	if (unlikely(pool->tx_sw_csum &&
> -		     skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> +	struct ethhdr eth_buf, *eth;
> +	int nhoff =3D ETH_HLEN;
> +	unsigned int l3_min;
> +	__be16 proto;
> +
> +	if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL))
> +		return 0;
> +
> +	if (unlikely(pool->tx_sw_csum))
> +		return skb_checksum_help(skb);
> +
> +	if (unlikely(skb->dev->type !=3D ARPHRD_ETHER))
> +		return 0;
> +
> +	eth =3D skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> +	if (unlikely(!eth))
> +		return skb_checksum_help(skb);
> +
> +	proto =3D eth->h_proto;
> +	if (eth_type_vlan(proto)) {
> +		proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> +		if (unlikely(!proto))
> +			return skb_checksum_help(skb);
> +	}
> +
> +	switch (proto) {
> +	case htons(ETH_P_IP):
> +		l3_min =3D sizeof(struct iphdr);
> +		break;
> +	case htons(ETH_P_IPV6):
> +		l3_min =3D sizeof(struct ipv6hdr);
> +		break;
> +	default:
>  		return skb_checksum_help(skb);
> +	}
> +
> +	if (unlikely(skb_checksum_start_offset(skb) < nhoff + l3_min))
> +		return skb_checksum_help(skb);
> +

Forcing software csum when parsing fails seems wrong. Can we return 0
and leave the skb unchanged instead?

Take Ethernet/MPLS/IPv4/UDP with one MPLS label. UDP starts at byte 38
and its checksum field is at byte 44. The parser stops at MPLS, but with
TX checksum offload enabled, virtio can still pass csum_start=3D38 and
csum_offset=3D6 to the backend.

skb_checksum_help() can sum bytes in fragments, but it requires the
checksum start and the result field to be in the linear head. Virtio
sets IFF_TX_SKB_NO_LINEAR, so AF_XDP puts all packet bytes in fragments.
The helper returns -EINVAL and AF_XDP drops the packet.

Returning 0 leaves CHECKSUM_PARTIAL and both offsets intact, so the
normal TX path can handle the request as before. The old
XDP_UMEM_TX_SW_CSUM should case is ok!


Bj=C3=B6rn
