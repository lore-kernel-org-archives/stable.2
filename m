Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794803542;
	b=hPK20Ea4+cqQFRucUeRLbTx1qohcyhkxC2pTxM47V/ASRhUHDF2g/D0lG1eIlZKbCytA
	 ovC5fHQjXOPpA6yGpImRJWLla2JWFpwKR5DWi7YDxnD1sNoZOT4KRAyIuwC8ggo8q7sq9
	 uER4vqtrDnFojdjuOM7abpqT4fQMbvWB2ZuZ6YzAQDH7m9MmyjYaXiYEBh7IVh5MNvO6i
	 vR1IQDmKHROSOoK8s9FmKIlESZ1IvPHi2mx9iATzChuGNeWLKlsbsKPTMVtp4noou7GKw
	 /U7zYpPeaiUdLIrGhklrBvw0TNvl2AHdfGCe/Jcl2Mq+3kmFDcS/HBZVxPOXrP9g/Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jPAnlcr6CpCK+FsvHg0au7x34Ypbda/xjzLYTLYSZv8=;
	b=3Pm2psxtL6KAVD1p917ze884I2hYcMkGw/7TkHf20o/iSqDsLWnQNe0EKKYfEA/llno5
	 d0rejsE2xdl7n35gW7ASrZDH79seXQF2Rnf1Lig01w0NmGK836O3h3OE6LW7sUzzk5P5t
	 AwMtHazGPcpb8C8HkYLDjXttJARIsFHwUeUoGjv4B/bvil5vbwYO6I1b4mql3tj9bida5
	 zKiLoUviInu3TP2rAM4ebzYj6fwtU/L4EYt+86JXu2vwYEXYnxvfIaMkzct67MnFHrMs6
	 +BRj8C3Q31wc4lKezLCpHyF28KOUdINRmPCXtcFZXHJtFdfUaTMsNegk7HJ4g+nHo/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jilgco8s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799E606A321
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 04:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4799E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jilgco8s
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c50e26763a4so36495166b.1
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 20:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794803539; cv=none;
        d=google.com; s=arc-20260327;
        b=lXbAGmoz9ZM7b4DBrofatzwVQG0nU9UHGOXCKrI395UslYXtr62BZcbxv9vPw1Nr0s
         ix8NcaNVQ/qNvE9q+2od2qcl/mQROc4NCGPZTNvOnFL+8vE8p+uRrIjkLg+6A6XQSoqo
         0O6GLDza1Gp7CLYVNPOOAX+aFVhC1pXFtdHkgXmyLqf9TfYAeazlwgvUoxHb3fkHT3jS
         9f3mNTipR/umJ1cKh22eF2p/KNh5VxjNWs5RGDxIx5jQFN3Uojz1SbMwnAbCajuQKUS1
         D/JXcxXSUowyKOF303pptxC8Ejlv02aZwd15RbbqGbDQTfvkJ2Raf/0JIuy0i8Bz61Dk
         oK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPAnlcr6CpCK+FsvHg0au7x34Ypbda/xjzLYTLYSZv8=;
        fh=I+r2T55Ahr/Q38ei261k6D8z+D1J7ikoyOk4AZq2YrA=;
        b=ZEfxWAyaG3dPv80kyugjCc4tpNIWwyJaFwtoMVfQmAjwkS1pKxfGOJcmYa0dLkdBcm
         zPWNapz6+jlLbbpGyocIyfVZ8l26Fc2rbrlZtNMm5yx21efdRcsoxOPoxYXbiEceSMVO
         X8o+qyzRTryNWJbgkJFX+NJ5MmEGaH6+0GhLOXs731B9SzRl4LEGMLQJJtm11i2YGqJJ
         nBe7drzc1YAWxkgs78nhMPRvjldSq01jKkZkv1pCeX1tZhCOhrg7Dx4UjQyBz+MNfXDK
         /QzYN3r9lSQq1ibYZZiSSrBtMjtOtk1lSqGUV/Ryj0TAcTv05sBqQzK3heLtDkkpHOM1
         Hizw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794803539; x=1795408339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPAnlcr6CpCK+FsvHg0au7x34Ypbda/xjzLYTLYSZv8=;
        b=Jilgco8s/bAElM+zKLQc4b0FZvTZcFFI/nie6pOFlRgdDu2r4AQmaTQbsy37S2SL+J
         Cw9akzJj1mZYvPDeqZxznUxgl7ndfSvD/8FImzdUr5moGr2mL1+N+7OC9FSLN24Jr6u1
         xFVlvQ1ROPKDoEEP/y/kr4v9UDJk2Hep4P7y5OAucSu+BnGXj40huQRiroUvdB54Frwi
         /gqMDBtOSweVTxad04YvGExVXMj8cNlJY+vC66wyxWPtVithiexHbuZF4M5z+uFUY4xf
         M2TQN71mXdh9RuIBydmMlpl158NnE+EYRyucATjgIm2KT8cVUa1C3kWQj9X488oVls6a
         K2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803539; x=1795408339;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPAnlcr6CpCK+FsvHg0au7x34Ypbda/xjzLYTLYSZv8=;
        b=wL1cezuXGZJMEdUccIO+KKOoFfcgo/BqlYVbtYXZZkOdzElv8r7aG5bIeZk5mf0o63
         JIiT0W565an04HCTkBU1AC8yGxiUoezgPEk2CuSQFFM2zyHaEryBP+edc5AF2TQVGTp0
         jkFSSDf1wD4BlMjj3DbXvXaAPgCEF+ijrsL6LU9kqHzQlzedr3AJOCyZ0N9Nyf0pNGHu
         nd3qTPPblXcWzh4BInHrx5h2kVAbLD17DkUFCKH+e78keg3MKwqjByi88QZEja44B6rd
         syoReRmU8/jjenLFf5vw546WphQicEb1jI5NxXF1jZLFh+LxoQ4DMhk5fn3zutmOuwoN
         yYPQ==
X-Forwarded-Encrypted: i=1; AL+hErFr5ZUQB+pACjKJiQqlRKWblI9gtJzBHBjT9/rBZfa4Oo53sHwLYAkPXqRf9lMS8iqUI1Y+STM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LVBJnpCSdiVEdwAJd1U+j3oRNZqxDZbmyfmuFWHiMQZQs6i8z
	4ZdKmdW8yFuiB/Yb41JxBhWLpikNNUtceUV0E8pPRWvBY4DWF+z2RZ5OnaYcSTu3/SAKPrhNIpv
	ilOGKY4Gcvouf9j2ANRdOzHfH9nlKFWOZAVFa+k5b
X-Gm-Gg: AYBFou22U/FjaEBl6Ndk7WilAK4D3GwX0CVjIeRPEC4w/fUKjSYAis+6bY9rReuDWhd
	pT+qC3oaSKUkfLvAX7RwJj76ZTWbOX9xW02MQnfZUWYJVdhtfBfUrRTtkeeqevp6cMS9g2dduqJ
	kyQHryfuzWair2vg4F0wfi+hCpSx4vA68y38X3/TNbpLakWte0VdHBd0cbtr62SjeHKlb5HpszG
	aTdIJSSR0fuHZKVQv/PRQvgnU9H5MUKgMNXlVrtQRmnpobB04ev52N7b0yPCupq25a0aCm4wqQ8
	uk+mHlbSmbUCuR7NfsoiqHExpIzx34zOfD5Vp1A11zrLu2hfOxF+n7VXzXYXhE/bKP06wW22ZfH
	upzBfIf21FpBWIbPm6N1wLXWdZUlNPCgbHN1x1qJIwaHLTRq0JlWY5lMVxFgLGCjHurSVkg==
X-Received: by 2002:a17:906:c154:b0:c43:bf29:1517 with SMTP id
 a640c23a62f3a-c50962edf20mr708573666b.12.1794803539044; Sun, 15 Nov 2026
 20:32:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113195553.2220562-1-joshwash@google.com> <CAL4WiioeNVQwPnZjJLh-Tcev8f-pm5z2dRrJ0k8ZStg5bWt9uA@mail.gmail.com>
In-Reply-To: <CAL4WiioeNVQwPnZjJLh-Tcev8f-pm5z2dRrJ0k8ZStg5bWt9uA@mail.gmail.com>
From: Ankit Garg <nktgrg@google.com>
Date: Sun, 15 Nov 2026 20:32:06 -0800
X-Gm-Features: AclHuK9aY1QAAgI1pFJNQc68FGtJ4cJf5gOx3SIRFJuRdq_RK76275eI76NC1Jg
Message-ID: <CAJcM6BFEq-JGqtDJnn4C7Tbo9fySE8CUN4wbvyhvZAn0K6tYKw@mail.gmail.com>
Subject: Re: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
To: Eric Dumazet <edumazet@kernel.org>
Cc: Joshua Washington <joshwash@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Tim Hostetler <thostet@google.com>, 
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 7:14=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le ven. 13 nov. 2026 =C3=A0 20:56, Joshua Washington <joshwash@google.com=
> a =C3=A9crit :
> >
> > From: Ankit Garg <nktgrg@google.com>
> >
> > With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet int=
o
> > a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
> > CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
> > tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it doe=
s
> > not seed th->check with the TCP pseudo-header checksum or set
> > CHECKSUM_PARTIAL.
> >
> > The GRO stack completes a HW-GRO skb itself only if it holds the skb fo=
r
> > merging (since commit 5eddb24901ee ("gro: add support of (hw)gro packet=
s
> > to gro stack")). Otherwise the skb is delivered as is, e.g. with rx-gro
> > off or for a packet that is flushed immediately (e.g. with PSH set). If
> > such an skb is forwarded out of a TSO-capable device, netif_needs_gso()
> > accepts it as CHECKSUM_UNNECESSARY and the device segments it with a
> > bogus checksum seed, so every segment is dropped by the receiver. This
> > blackholes forwarded TCP traffic on VMs acting as routers or NAT
> > gateways and was observed on VMs in real use.
> >
> > Fix it in a manner consistent with other drivers with HW-GRO: set the
> > network and transport headers and, for packets whose checksum the devic=
e
> > verified, seed th->check with the pseudo-header checksum and call
> > tcp_gro_complete(), passing gso_segs through NAPI_GRO_CB(skb)->count.
> > skb->data points at the Ethernet header on the napi_gro_frags() path an=
d
> > at the IP header on the header-split and copybreak paths, so account fo=
r
> > that when setting the network header. Since the header layout now
> > matters, tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do,
> > rather than by the packet type.
> >
> > Also compute gso_segs from the TCP payload length. It was computed from
> > skb->data_len, which is 0 for a packet that rx_copybreak copied whole
> > into the linear part, leaving such packets with gso_segs 0 and a
> > non-zero gso_size.
> >
> > Fixes: e637c244b954 ("gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_=
LRO")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Joshua Washington <joshwash@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > Signed-off-by: Ankit Garg <nktgrg@google.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 69 +++++++++++++++-----
> >  1 file changed, 53 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 82ed5e48b00a..58696d26c698 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/ipv6.h>
> >  #include <linux/skbuff.h>
> >  #include <linux/slab.h>
> > +#include <net/gro.h>
> >  #include <net/ip6_checksum.h>
> >  #include <net/ipv6.h>
> >  #include <net/tcp.h>
> > @@ -1000,13 +1001,34 @@ static int gve_rx_dqo(struct napi_struct *napi,=
 struct gve_rx_ring *rx,
> >         return -ENOMEM;
> >  }
> >
> > +/* Prepare a HW-GRO packet the way tcp4/6_gro_complete() prepare a SW-=
GRO
> > + * packet, so that it can be resegmented by GSO or TSO if it is forwar=
ded:
> > + * seed th->check with the TCP pseudo-header checksum and set CHECKSUM=
_PARTIAL.
> > + */
> > +static void gve_rx_fixup_gro_checksum(struct sk_buff *skb)
> > +{
> > +       int len =3D skb->len - skb_transport_offset(skb);
> > +       struct tcphdr *th =3D tcp_hdr(skb);
> > +
> > +       if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
> > +               th->check =3D ~tcp_v4_check(len, ip_hdr(skb)->saddr,
> > +                                         ip_hdr(skb)->daddr, 0);
> > +       else
> > +               th->check =3D ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
> > +                                         &ipv6_hdr(skb)->daddr, 0);
> > +
> > +       NAPI_GRO_CB(skb)->count =3D skb_shinfo(skb)->gso_segs;
> > +       tcp_gro_complete(skb);
> > +}
> > +
> >  static int gve_rx_complete_rsc(struct sk_buff *skb,
> >                                const struct gve_rx_compl_desc_dqo *desc=
,
> >                                struct gve_ptype ptype)
> >  {
> >         struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> > -       int rsc_segments, rsc_seg_len, hdr_len;
> > +       int rsc_seg_len, hdr_len, nhoff, thoff;
> >         skb_frag_t *frag;
> > +       __be16 proto;
> >         void *va;
> >
> >         /* HW-GRO only coalesces TCP. */
> > @@ -1017,20 +1039,11 @@ static int gve_rx_complete_rsc(struct sk_buff *=
skb,
> >         if (!rsc_seg_len)
> >                 return 0;
> >
> > -       switch (ptype.l3_type) {
> > -       case GVE_L3_TYPE_IPV4:
> > -               shinfo->gso_type =3D SKB_GSO_TCPV4;
> > -               break;
> > -       case GVE_L3_TYPE_IPV6:
> > -               shinfo->gso_type =3D SKB_GSO_TCPV6;
> > -               break;
> > -       default:
> > -               return -EINVAL;
>
> Before this patch the L3 type came from ptype.l3_type, now it comes from
> the EtherType. A VLAN tagged frame (gve does not strip tags) would have
> been accepted before, and is now dropped and accounted in
> rx_desc_err_dropped_pkt. nhoff =3D ETH_HLEN has the same assumption.
>
> Can the device coalesce VLAN tagged frames ?
>
> If not, please say so in the changelog. Otherwise this needs to be
> handled, like idpf_rx_rsc() does with eth_type_vlan().
>
GVE device does not coalesce VLAN tagged frames, so they are never
completed with desc->rsc set. I will explicitly mention that in v2.
> > -       }
> > -
> >         if (skb_headlen(skb)) {
> > -               /* With header-split, payload is in the non-linear part=
 */
> > -               rsc_segments =3D DIV_ROUND_UP(skb->data_len, rsc_seg_le=
n);
> > +               /* With header-split or copybreak, eth_type_trans() has=
 already
> > +                * pulled the Ethernet header.
> > +                */
> > +               nhoff =3D 0;
> >         } else {
> >                 /* HW-GRO packets are guaranteed to have complete TCP/I=
P
> >                  * headers in frag[0] when header-split is not enabled.
> > @@ -1039,7 +1052,6 @@ static int gve_rx_complete_rsc(struct sk_buff *sk=
b,
> >                 va =3D skb_frag_address(frag);
> >                 hdr_len =3D
> >                         eth_get_headlen(skb->dev, va, skb_frag_size(fra=
g));
> > -               rsc_segments =3D DIV_ROUND_UP(skb->len - hdr_len, rsc_s=
eg_len);
> >                 skb_copy_to_linear_data(skb, va, hdr_len);
> >                 skb_frag_size_sub(frag, hdr_len);
> >                 /* Verify we didn't empty the fragment completely as th=
at could
> > @@ -1049,10 +1061,35 @@ static int gve_rx_complete_rsc(struct sk_buff *=
skb,
> >                 skb_frag_off_add(frag, hdr_len);
> >                 skb->data_len -=3D hdr_len;
> >                 skb->tail +=3D hdr_len;
> > +               /* napi_gro_frags() pulls the Ethernet header later. */
> > +               nhoff =3D ETH_HLEN;
> >         }
> > +
> > +       skb_set_network_header(skb, nhoff);
> > +       proto =3D nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->=
protocol;
> > +       switch (proto) {
> > +       case htons(ETH_P_IP):
> > +               shinfo->gso_type =3D SKB_GSO_TCPV4;
> > +               thoff =3D nhoff + ip_hdrlen(skb);
> > +               break;
> > +       case htons(ETH_P_IPV6):
> > +               shinfo->gso_type =3D SKB_GSO_TCPV6;
> > +               thoff =3D nhoff + sizeof(struct ipv6hdr);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +       skb_set_transport_header(skb, thoff);
> > +
> >         shinfo->gso_size =3D rsc_seg_len;
> > -       shinfo->gso_segs =3D rsc_segments;
> > +       shinfo->gso_segs =3D DIV_ROUND_UP(skb->len - thoff - tcp_hdrlen=
(skb),
> > +                                       rsc_seg_len);
> > +
> > +       if (!IS_ENABLED(CONFIG_INET) ||
> > +           unlikely(skb->ip_summed !=3D CHECKSUM_UNNECESSARY))
> > +               return 0;
> >
> > +       gve_rx_fixup_gro_checksum(skb);
>
> thoff is derived from iph->ihl, and tcp_hdrlen() from th->doff, both read
> from the packet, and nothing checks that the TCP header is actually in
> the linear part before we read th->doff and write th->check.
>
> On the copybreak path the head was allocated by napi_alloc_skb(buf_len),
> so a short frame with desc->rsc set and a large ihl ends up reading and
> writing past the copied data. Same thing on the napi_get_frags() path if
> eth_get_headlen() returned less than the full headers.
>
> The old code was trusting the device as well, but it was not writing
> into the headers.
>
> I think we want something like this, before using tcp_hdr(skb):
>
>         if (unlikely(thoff + sizeof(struct tcphdr) > skb_headlen(skb)))
>                 return -EINVAL;
>
>         if (unlikely(skb->len < thoff + tcp_hdrlen(skb)))
>                 return -EINVAL;
>
> (skb_headlen() is hdr_len on the napi_get_frags() path at this point,
> so one check covers both cases.)
>
> This also makes sure gso_segs can not be computed from a negative length.
>
> Thanks.
Agreed, I'll add these in v2.

Thanks for the review!
