Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669295;
	b=pNXHaaZDGr+WSAbCpedfxu1uKk2TFwEbgYEAL0CKaKBNdd21N9CYtsyBSd2lMjdHm1u4
	 yDlWyU19ofiQMK6DCNAtOksIhmL4ZNOk12TdejEjGV0q6C3CVtTIrPIeIfzlFaekiuDOK
	 bug5Xwzmuuqt0yNInEhXMEcYCtAjkGLvSzAE+vJJUCp4KTGl6y9rEDKjIyH9/sLrjFW+E
	 1gX5YVEZli68ZowiwQXTCeOk1BJiaQ6QvSoCMt8kw/7BPux0lHqUNEVQOg0L6mPb4YCKL
	 zBmnvZDhIfcYc/xVrhDxNMZ+kjJLCcRngkHA3Jmex/2yqGTVRgk14h0nSRNxjhK/RDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669295;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2Os4f9WdWDGemUXCp5xc3FrN8m+AVPs5CTPpzaiqx+M=;
	b=L/tkR4g2CE6okEMuJ5XXslz0YmLPvs8pg5mPA6pmtP80IKjatBvwyH8Uc0ok+YuOjYM5
	 XHickeVGSE+EfFxzrOxV05kMDJvS5amArJvFI5GlAyiAUXBwgSQqabHO+XLiBa6btbsDF
	 tihoNoi2mBHAeCUy8T8NPxfvY8madVsEJ2mctZOzYxO1AaFGLuKFtKZFkl2oEGgnWWSlK
	 3fY/qaLtfP/pK14l9DxZJDpGsejtHMtjuhW79rigzS2B5hyh1khJLl+UbKo3zW8Kkn8Qf
	 Xf7XN4Ifaly6s/d8mEzqEfFv2wa8WkljLrI6s9LvtRLik4KOMVv1hI6P75bjue5umzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsCMcgsj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B298606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsCMcgsj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3061F000C8
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794669295;
	bh=2Os4f9WdWDGemUXCp5xc3FrN8m+AVPs5CTPpzaiqx+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EsCMcgsjMzThraV9dXyFbtNqnP0PCn7OajYJxmuc64cO+zhmGWYjmKDNrIi9MAp09
	 Ztzl8hGh8yPFP5OYPvJyw9dNsobgkaqHFQ2LvJIlQhK/SZ8VJ3JbYX86iG+V/A5VM7
	 azECCNOlTiMsDgL+NM1I4dKEqlvMin9W9/QHiqxh5mrqUOxs7UDb9D3dAnk5AzUw76
	 qUrWOalIdfRMQUlEX0G1IMM3wYLDHilFbehl/6ymjuTM51DZ90jZe5niCeNG0IuRjh
	 305uKx2LNtiLAn97scbiKFZ6h3giz6zXcEylBNep8oVY3wptX2c6lHLc25C5FgDHQA
	 yRq5CgXLfaAzA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-483d290f398so1790130fac.2
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:14:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHM/vGU5gCIAfu1LVO3ertLEjILf22fStkXnFREnIosh1kiwu1TpNoPieKxewkItKyw2DptfQo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8f2ZklLnFx+weX5A16dyyNlTjstA4NJ8HktqYLJ6NGTVMnzdcB
	c2+IVOW+yBp93X8HC4Tf26BXUn9FgqF0vPcZg4QrbBG3E2wMQAO9ScXWdiFZrwYmoZXbnXDq6J0
	eKd/sz+EwRd2eZN3qCM4EKiPI3p8O1No=
X-Received: by 2002:a05:6870:c087:b0:485:d31b:7761 with SMTP id
 586e51a60fabf-4afdf4316e8mr5067496fac.31.1794669294220; Sat, 14 Nov 2026
 07:14:54 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113195553.2220562-1-joshwash@google.com>
In-Reply-To: <20261113195553.2220562-1-joshwash@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 14 Nov 2026 16:14:42 +0100
X-Gmail-Original-Message-ID: <CAL4WiioeNVQwPnZjJLh-Tcev8f-pm5z2dRrJ0k8ZStg5bWt9uA@mail.gmail.com>
X-Gm-Features: AclHuK-1gN5WyFopKS6Ic6W_qMT25iT5u41cEHbc6BqYNpQg0DlCIbZIgmKDK70
Message-ID: <CAL4WiioeNVQwPnZjJLh-Tcev8f-pm5z2dRrJ0k8ZStg5bWt9uA@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 13 nov. 2026 =C3=A0 20:56, Joshua Washington <joshwash@google.com> =
a =C3=A9crit :
>
> From: Ankit Garg <nktgrg@google.com>
>
> With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet into
> a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
> CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
> tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it does
> not seed th->check with the TCP pseudo-header checksum or set
> CHECKSUM_PARTIAL.
>
> The GRO stack completes a HW-GRO skb itself only if it holds the skb for
> merging (since commit 5eddb24901ee ("gro: add support of (hw)gro packets
> to gro stack")). Otherwise the skb is delivered as is, e.g. with rx-gro
> off or for a packet that is flushed immediately (e.g. with PSH set). If
> such an skb is forwarded out of a TSO-capable device, netif_needs_gso()
> accepts it as CHECKSUM_UNNECESSARY and the device segments it with a
> bogus checksum seed, so every segment is dropped by the receiver. This
> blackholes forwarded TCP traffic on VMs acting as routers or NAT
> gateways and was observed on VMs in real use.
>
> Fix it in a manner consistent with other drivers with HW-GRO: set the
> network and transport headers and, for packets whose checksum the device
> verified, seed th->check with the pseudo-header checksum and call
> tcp_gro_complete(), passing gso_segs through NAPI_GRO_CB(skb)->count.
> skb->data points at the Ethernet header on the napi_gro_frags() path and
> at the IP header on the header-split and copybreak paths, so account for
> that when setting the network header. Since the header layout now
> matters, tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do,
> rather than by the packet type.
>
> Also compute gso_segs from the TCP payload length. It was computed from
> skb->data_len, which is 0 for a packet that rx_copybreak copied whole
> into the linear part, leaving such packets with gso_segs 0 and a
> non-zero gso_size.
>
> Fixes: e637c244b954 ("gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LR=
O")
> Cc: stable@vger.kernel.org
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Ankit Garg <nktgrg@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 69 +++++++++++++++-----
>  1 file changed, 53 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00a..58696d26c698 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -13,6 +13,7 @@
>  #include <linux/ipv6.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
> +#include <net/gro.h>
>  #include <net/ip6_checksum.h>
>  #include <net/ipv6.h>
>  #include <net/tcp.h>
> @@ -1000,13 +1001,34 @@ static int gve_rx_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>         return -ENOMEM;
>  }
>
> +/* Prepare a HW-GRO packet the way tcp4/6_gro_complete() prepare a SW-GR=
O
> + * packet, so that it can be resegmented by GSO or TSO if it is forwarde=
d:
> + * seed th->check with the TCP pseudo-header checksum and set CHECKSUM_P=
ARTIAL.
> + */
> +static void gve_rx_fixup_gro_checksum(struct sk_buff *skb)
> +{
> +       int len =3D skb->len - skb_transport_offset(skb);
> +       struct tcphdr *th =3D tcp_hdr(skb);
> +
> +       if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
> +               th->check =3D ~tcp_v4_check(len, ip_hdr(skb)->saddr,
> +                                         ip_hdr(skb)->daddr, 0);
> +       else
> +               th->check =3D ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
> +                                         &ipv6_hdr(skb)->daddr, 0);
> +
> +       NAPI_GRO_CB(skb)->count =3D skb_shinfo(skb)->gso_segs;
> +       tcp_gro_complete(skb);
> +}
> +
>  static int gve_rx_complete_rsc(struct sk_buff *skb,
>                                const struct gve_rx_compl_desc_dqo *desc,
>                                struct gve_ptype ptype)
>  {
>         struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> -       int rsc_segments, rsc_seg_len, hdr_len;
> +       int rsc_seg_len, hdr_len, nhoff, thoff;
>         skb_frag_t *frag;
> +       __be16 proto;
>         void *va;
>
>         /* HW-GRO only coalesces TCP. */
> @@ -1017,20 +1039,11 @@ static int gve_rx_complete_rsc(struct sk_buff *sk=
b,
>         if (!rsc_seg_len)
>                 return 0;
>
> -       switch (ptype.l3_type) {
> -       case GVE_L3_TYPE_IPV4:
> -               shinfo->gso_type =3D SKB_GSO_TCPV4;
> -               break;
> -       case GVE_L3_TYPE_IPV6:
> -               shinfo->gso_type =3D SKB_GSO_TCPV6;
> -               break;
> -       default:
> -               return -EINVAL;

Before this patch the L3 type came from ptype.l3_type, now it comes from
the EtherType. A VLAN tagged frame (gve does not strip tags) would have
been accepted before, and is now dropped and accounted in
rx_desc_err_dropped_pkt. nhoff =3D ETH_HLEN has the same assumption.

Can the device coalesce VLAN tagged frames ?

If not, please say so in the changelog. Otherwise this needs to be
handled, like idpf_rx_rsc() does with eth_type_vlan().

> -       }
> -
>         if (skb_headlen(skb)) {
> -               /* With header-split, payload is in the non-linear part *=
/
> -               rsc_segments =3D DIV_ROUND_UP(skb->data_len, rsc_seg_len)=
;
> +               /* With header-split or copybreak, eth_type_trans() has a=
lready
> +                * pulled the Ethernet header.
> +                */
> +               nhoff =3D 0;
>         } else {
>                 /* HW-GRO packets are guaranteed to have complete TCP/IP
>                  * headers in frag[0] when header-split is not enabled.
> @@ -1039,7 +1052,6 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
>                 va =3D skb_frag_address(frag);
>                 hdr_len =3D
>                         eth_get_headlen(skb->dev, va, skb_frag_size(frag)=
);
> -               rsc_segments =3D DIV_ROUND_UP(skb->len - hdr_len, rsc_seg=
_len);
>                 skb_copy_to_linear_data(skb, va, hdr_len);
>                 skb_frag_size_sub(frag, hdr_len);
>                 /* Verify we didn't empty the fragment completely as that=
 could
> @@ -1049,10 +1061,35 @@ static int gve_rx_complete_rsc(struct sk_buff *sk=
b,
>                 skb_frag_off_add(frag, hdr_len);
>                 skb->data_len -=3D hdr_len;
>                 skb->tail +=3D hdr_len;
> +               /* napi_gro_frags() pulls the Ethernet header later. */
> +               nhoff =3D ETH_HLEN;
>         }
> +
> +       skb_set_network_header(skb, nhoff);
> +       proto =3D nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->pr=
otocol;
> +       switch (proto) {
> +       case htons(ETH_P_IP):
> +               shinfo->gso_type =3D SKB_GSO_TCPV4;
> +               thoff =3D nhoff + ip_hdrlen(skb);
> +               break;
> +       case htons(ETH_P_IPV6):
> +               shinfo->gso_type =3D SKB_GSO_TCPV6;
> +               thoff =3D nhoff + sizeof(struct ipv6hdr);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +       skb_set_transport_header(skb, thoff);
> +
>         shinfo->gso_size =3D rsc_seg_len;
> -       shinfo->gso_segs =3D rsc_segments;
> +       shinfo->gso_segs =3D DIV_ROUND_UP(skb->len - thoff - tcp_hdrlen(s=
kb),
> +                                       rsc_seg_len);
> +
> +       if (!IS_ENABLED(CONFIG_INET) ||
> +           unlikely(skb->ip_summed !=3D CHECKSUM_UNNECESSARY))
> +               return 0;
>
> +       gve_rx_fixup_gro_checksum(skb);

thoff is derived from iph->ihl, and tcp_hdrlen() from th->doff, both read
from the packet, and nothing checks that the TCP header is actually in
the linear part before we read th->doff and write th->check.

On the copybreak path the head was allocated by napi_alloc_skb(buf_len),
so a short frame with desc->rsc set and a large ihl ends up reading and
writing past the copied data. Same thing on the napi_get_frags() path if
eth_get_headlen() returned less than the full headers.

The old code was trusting the device as well, but it was not writing
into the headers.

I think we want something like this, before using tcp_hdr(skb):

        if (unlikely(thoff + sizeof(struct tcphdr) > skb_headlen(skb)))
                return -EINVAL;

        if (unlikely(skb->len < thoff + tcp_hdrlen(skb)))
                return -EINVAL;

(skb_headlen() is hdr_len on the napi_get_frags() path at this point,
so one check covers both cases.)

This also makes sure gso_segs can not be computed from a negative length.

Thanks.
