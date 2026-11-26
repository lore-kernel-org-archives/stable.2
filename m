Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795690927;
	b=dsvN7xPIU5LVqlmQ4znKT646WBhY8ftyyO1+S7Eix59GfJsiYZRQSIiFytpRZQvDQixl
	 gvtnAyAxCYlg42QL6QdSDcoDUkqpRMc9I7pCvG+E78WGcQDqpl28ifthWjCPApRIpHOMU
	 WTeM85VoI83BTHS0bFr/9G7SByETY83GhQosBpgRJAdoHJW4qgMtl7b6ptqj3CN3a8pH8
	 AvaBmxkQO4G434g29yiiy999ul4JEFfY5n65pdoQFwjp5EXRnalrC35ANBNZnvVdvLJC4
	 Fx6VWsu6ADgRE0pV3SDTFCUsSYXAE6IKhRYYnGlVChPibBuD7X0Zh3xQUJL92s0ZA3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690927;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o3qX6nwpicEW2fl1FvvlS5HfR0XjRdgEkcwqkTjatNg=;
	b=i5zsqwNcRem6F1g2Yl/kJjz+UzFAjxNMskrX+2IkFyjfjLEVpD8HRRSyiAv4oTbrD8L8
	 O7PdQ5EhAeOS1UxMk8qBfc+e7MZfPjIqQrwrWVi5Ge67ny06+hczUUAdQ8DOf6/N4N9mp
	 ih61YQP6k9k7/u9SRGS80NFL5jPZUpIUeIFikBaGmJ9jlGyp/+VGLBjdPDoYezitqnR4U
	 Wy1cxWKvECW5dO+MZuxubTmelsNecS3LtKrpFTaCuQecCxtIgD3wZ+pE1wluHqpuAT9oj
	 jcqxJLqzY8RmGwCmaA+aXjnwajScEsnq6PTjxZc7n8WdBNMsv7cYkgseezb7F623G2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kU2BKQTM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0FB606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 11:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kU2BKQTM
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c14f3dab09so3491796e87.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:02:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795690925; cv=none;
        d=google.com; s=arc-20260327;
        b=O1/dV3wXkhO9UZLXtMqP0TGTi3Evkf4H+R/Aa+DhKQlt/1qwRLzN+wqIkIzuijG+6o
         t8+ANzXVU3s+D35sGIn2qClKVlE/YvTExkS+vMU9S3t3apF0CSJonOQ6f+Sn21GkHIcb
         aJIc0xBpFKcE6JLU5TXMMcwhvNUpQSzgmthGjs9O00jy4TqJFBMZkjItBzPuq3v9OdFJ
         BV5Y9RZmFw/1sPamISE7t0fVzmmBtNnfOP6F3JpsDziJKK1Y17j/jz2K2sIKGkr7mGf7
         +FKGt/aZcUKeZylzl67r54lQK/p/arb2+1e1q0N3Exz1ztdQuFbCXC0xzmU+mvXbYP/4
         TiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3qX6nwpicEW2fl1FvvlS5HfR0XjRdgEkcwqkTjatNg=;
        fh=LKahqFXBEHMLASrvQDQl0Y1KomCH/2jXLBe1yJqZPwk=;
        b=dBLaPbBKyxkqM7QJJUaHy1b0H5QXbE2cFAPivaT6Q1KrbBZUB/Wvm12t2DEQXHhT8k
         cgzy1nEmr1TNRKpsL49RyDCTSENGsCvAc2GuqK7DqZSi8ntjgb0iL9Ql7IU47X62y/et
         vBnNoNeCJuYYCws1vlhehk6hESoB25nTWcZq3lorQ4TdlC0XyQgbvsHThQvHn7MxQcBO
         NKJJg5ChfwNWXt3DP3kpUq7E4H8AehNzsiMQEnkbYzMeMQ7XWZd1Ea58E+6+KL8ZNxLZ
         XE+XB+ys89dUO8s2XbCCoet5gtre410M7Owg1KHjVhrHGynm5VUZvm30XEmSAzEetMos
         L43w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795690925; x=1796295725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o3qX6nwpicEW2fl1FvvlS5HfR0XjRdgEkcwqkTjatNg=;
        b=kU2BKQTMXXv3BRkWSjgJApdVGGMzJ30Wpt7Wt44ffvSXP1QNShOd5bntN0WKZi/Rv3
         x3QIlQS8Cpgd0c2QzOTkIcWEjKNHRpquJlbxD2/OIFo44iWIDsxQF+9wkp/8GTQVauyY
         eTX2+BF0515Mc5XZ/xKtVkuThiVTUrhcSUPOOeCYzZgJeadUDdCmy27I2lGMI9pRpr8r
         ynxXv2grpUtWzlIMfDidSjNfyrX8GLSWgqTun2vkQ+nS0gxxyp8OOxr8xuEPlWrWpAwQ
         Zd1oevWhPgZNYumQZQ2g+SAdPKK6EVyEin2n7j2KtUP+Nq5CtxmAcg1XqDxw071J71Wl
         Iy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690925; x=1796295725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3qX6nwpicEW2fl1FvvlS5HfR0XjRdgEkcwqkTjatNg=;
        b=EtntV8OnhFEL4FjcQQpfhQeFYoferHGaQ+H+/LY40vqIBsgjzTX9jI4fT6MbR2FSi/
         DResviIgrErquS8PuNMi2qfsDsG8NcxgukZZdXgZYL/UlwYzX1oAEbz1b3eF+f80LBdO
         +SA9rFDN/C1fRzeMghk29J2lq0feTdygW7qJZBYIHXBTFZrMPCCsydgnyXL21xEhW3+m
         eMrpvWeiUEpHtcmBJFHF0UQmVW7hGWrWnoIqYsLmvSqYtC8IkTc7G0NR/SJAM2uV/v24
         +fdZkbWoqxmP+bRjlXEit0dT8Jmpv5xs7BxQ8LZ+hmvrOLlYrQfRRPztObeqzjjUz8Pl
         FhNQ==
X-Forwarded-Encrypted: i=1; AL+hErHngtf5Wl5gCx6zyt7SJT3XvQxLXakWMqec6TQ+9QBxswF0E7pSIURQFLFicMPQN+8Yckn71Lc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8duQSNNOTAi7cnAoqeaU28eWQTveXfAG4M8rLHBwPz+uoYwGeg
	S56O3ovWK9bf4jYEdXY0VOh+av9kzwIY3e58xmQAVPJfBdAe9mrnyXkbU3AIWx9B8Vn3Y9pNI3A
	fxK5ak6k+J/vqs+Ruw4o6OrPsGn+rk6w=
X-Gm-Gg: AZFdTZcYZFCYY0ECpNfqiLhzHXNdK/8LgpcbJLkngPAAP/dUo8GPZGoiPVjZEdd5HLO
	QIuxRZXiF16NUWF/k8p6Gdf+xAPQAAMaNvK/dAQfYg/m7skxIElgOQOSfmZsAgQ0CxsDX8ZTTD/
	sC6nRln2OrdgetJxgrugYxDytLoVA+uYoUc2byr2IFUz3k8GEgH6ehYaJ6rTQj0uvvZO23GZE9X
	mnw/Nf6Gxmhi04V5lKC/3gbMZABiwoRgHb5zvY5aG5NkgOazYmzOwyGkuj8PRzIthLn1FwKUpwl
	QNWaD4VvoifUU5Qp13diZOQiKYxjeS+GnzZ3m1/3Vuc9/0nSe9W01Xcg+Rirkrn+MxVy6MrFm68
	rtI1qUnD77nj1k8mRhjPpi8dxfM8AxtEarjsaMu3i7xTgMq5wBS8wYuf2FMvNHLLeHABNR5Tir5
	8z0kZWtn5z2nSV9mjYI+9aELAm9migZF0dUENC+48qDRrdZNaBhM8n4pdAY96VF07pxMfGN/wG
X-Received: by 2002:a05:6512:2c8a:b0:5c1:5be1:2ecf with SMTP id
 2adb3069b0e04-5c1bc814182mr6139415e87.51.1795690924381; Thu, 26 Nov 2026
 03:02:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124083520.45547-1-kerneljasonxing@gmail.com> <179559599390.3135.18275141505690596469@kernel.org>
In-Reply-To: <179559599390.3135.18275141505690596469@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Nov 2026 19:01:26 +0800
X-Gm-Features: Aa3M54q9M1KxrcgztkclcDrO-at-kTSB-Pt_13lBw6qxag-Mp8jUQDjzV68UwyM
Message-ID: <CAL+tcoDMr4abaXMONP_gegib7tShRQrsFVoJ+EW9gV0=Af5G-w@mail.gmail.com>
Subject: Re: [PATCH net] xsk: fill in header offsets for TX checksum offload
To: netdev-bot+sashiko@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 4:39=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 3
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] xsk_skb_sw_csum() sets protocol, network_header and
>   transport_header but leaves skb->mac_header at the ~0 (0xffff)=E2=80=A6
> - [Medium] The commit message says ICE (ice_tx_csum) and mana
>   (skb->protocol) misbehave on AF_XDP copy-mode checksum requests.
> - [Medium] For frames with in-band 802.1Q/802.1AD tags, xsk_skb_sw_csum()
>   sets skb->protocol to the innermost ethertype returned by=E2=80=A6
> - [Low] xsk_skb_sw_csum() adds a rejection that the commit message does
>   not mention.
> - [Low] The new 'csum_start must not point into the L2 header' rule
>   applies in only one configuration: AF_XDP copy mode, without=E2=80=A6
> - [Low] Before setting skb->protocol to a user-chosen ETH_P_IP/ETH_P_IPV6
>   and network_header to nhoff, xsk_skb_sw_csum() only checks=E2=80=A6
>
> --
>
> xsk: fill in header offsets for TX checksum offload
>
> This patch makes xsk_skb_sw_csum() parse the Ethernet header and any
> in-band VLAN tags of AF_XDP copy-mode frames that request TX checksum
> offload. It then sets skb->protocol, the network header and the transport
> header. Frames whose csum_start points into the L2 header are rejected
> with -EINVAL.
>
> > Drivers like ICE do read network_header/transport_header
> > fields which actually point to the wrong place, leading to wrong action=
.
>
> [ ... ]
>
> > Also, initialize skb->protocol
> > because of some drivers (e.g. mana_start_xmit()) using it.
>
> [Severity: Medium]
> Could this description be made more accurate? Before this patch, could
> ICE or mana ever get a CHECKSUM_PARTIAL skb from this path?

I'd remove or revise this. As you pointed out, initializing this field
changes the previous behavior in harmonize_features().

>
> xsk never set skb->protocol, so it stayed 0. On the
> __dev_direct_xmit()->validate_xmit_skb()->netif_skb_features() path,
> harmonize_features() then cleared the checksum features on any device
> without NETIF_F_HW_CSUM:
>
> net/core/dev.c:harmonize_features() {
>     ...
>         if (skb->ip_summed !=3D CHECKSUM_NONE &&
>             !can_checksum_protocol(features, type)) {
>                 features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>         }
>     ...
> }
>
> skb_csum_hwoffload_help() then fell back to skb_checksum_help(), which
> computed the checksum correctly in software.
>
> By default ICE only advertises NETIF_F_IP_CSUM, NETIF_F_IPV6_CSUM and
> NETIF_F_SCTP_CRC (see ice_set_netdev_features()). On E830 with HW_CSUM
> enabled, ice_features_check() still removed the checksum features,
> because skb_network_offset() was negative with network_header at 0.
>
> mana only advertises NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM in
> mana_probe_port(), so it also always got a software checksum.
>
> So for these devices, doesn't the patch actually turn on hardware TX
> checksum offload in AF_XDP copy mode, where the checksum used to be done
> in software? The commit message doesn't say this, and the patch is
> tagged for stable.
>
> About the transport header: validate_xmit_skb() already sets it from
> csum_start before ndo_start_xmit() runs:
>
> net/core/dev.c:validate_xmit_skb() {
>     ...
>                         else
>                                 skb_set_transport_header(skb,
>                                                          skb_checksum_sta=
rt_offset(skb));
>                         if (skb_csum_hwoffload_help(skb, features))
>     ...
> }
>
> So by driver xmit time, only network_header and protocol were wrong. The
> new transport header setter still helps ndo_features_check callbacks
> such as ice_features_check(), because they run before this point.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index ab2e4fa87a4f0..d599fe161857f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -1026,10 +1028,37 @@ static int xsk_skb_metadata(struct sk_buff *skb=
, void *buffer,
> >
> >  static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *=
pool)
> >  {
> > -     if (unlikely(pool->tx_sw_csum &&
> > -                  skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> > +     struct ethhdr eth_buf, *eth;
> > +     int nhoff =3D ETH_HLEN;
> > +     __be16 proto;
> > +
> > +     if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL))
> > +             return 0;
> > +
> > +     if (unlikely(pool->tx_sw_csum))
> >               return skb_checksum_help(skb);
> >
> > +     if (unlikely(skb->dev->type !=3D ARPHRD_ETHER))
> > +             return 0;
> > +
> > +     eth =3D skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
> > +     if (unlikely(!eth))
> > +             return -EINVAL;
> > +
> > +     proto =3D eth->h_proto;
> > +     if (eth_type_vlan(proto)) {
> > +             proto =3D __vlan_get_protocol(skb, proto, &nhoff);
> > +             if (unlikely(!proto))
> > +                     return -EINVAL;
>
> [Severity: Low]
> Is this rejection intended for deeply nested tags? __vlan_get_protocol()
> also returns 0 when the VLAN_MAX_DEPTH parse limit is hit, i.e. with 8
> or more 802.1Q/802.1AD tags:
>
> net/core/skbuff.c:__vlan_get_protocol_offset() {
>         unsigned int vlan_depth =3D skb->mac_len, parse_depth =3D VLAN_MA=
X_DEPTH;
>     ...
>                 if (unlikely(!vh || !--parse_depth))
>                         return (struct vlan_type_depth) { 0 };
>     ...
> }
>
> When that happens, __xsk_generic_xmit() calls xsk_drop_skb() and the TX
> batch fails with EINVAL. This happens even when csum_start is well past
> the L2 header. Before the patch these frames were sent, and got a
> correct software checksum on non-HW_CSUM devices.
>
> The commit message only talks about rejecting frames whose csum_start
> points into the L2 header. Should this case be mentioned too?
>
> Short frames and truncated VLAN headers are rejected too, but there
> csum_start does have to point into the L2 header, so the described rule
> covers them.

It makes sense. I would add the following code to keep the previous
behavior (falling back to software computation):
---diff---
  eth =3D skb_header_pointer(skb, 0, sizeof(*eth), &eth_buf);
  if (unlikely(!eth))
- return -EINVAL;
+ return skb_checksum_help(skb);

  proto =3D eth->h_proto;
  if (eth_type_vlan(proto)) {
  proto =3D __vlan_get_protocol(skb, proto, &nhoff);
  if (unlikely(!proto))
- return -EINVAL;
+ return skb_checksum_help(skb);
  }

>
> > +     }
> > +
> > +     if (unlikely(skb_checksum_start_offset(skb) < nhoff))
> > +             return -EINVAL;
>
> [Severity: Low]
> This check only runs in one configuration: copy mode, without
> XDP_UMEM_TX_SW_CSUM, on an ARPHRD_ETHER device.
>
> The same XDP_TXMD_FLAGS_CHECKSUM request is still accepted in these
> cases:
>
>   - with tx_sw_csum, because skb_checksum_help() runs first
>   - on non-Ethernet devices, because of the early return above
>   - in zero-copy mode, where csum_start goes to the driver's
>     tmo_request_checksum without any check
>
> Documentation/networking/xsk-tx-metadata.rst just describes csum_start
> as the byte offset where checksumming should start. It gives no lower
> bound relative to L2 and no error behaviour.
>
> How is user space supposed to know whether such a descriptor will be
> sent or fail with EINVAL? Since this change is going to stable, should
> the uAPI documentation describe the new constraint?

The same here. I would use this with a new variable (l3_min):
- if (unlikely(skb_checksum_start_offset(skb) < nhoff))
- return -EINVAL;
+ if (unlikely(skb_checksum_start_offset(skb) < nhoff + l3_min))
+ return skb_checksum_help(skb);

>
> > +
> > +     skb->protocol =3D proto;
>
> [Severity: Medium]
> For frames with in-band VLAN tags, this sets skb->protocol to the
> innermost ethertype (e.g. ETH_P_IP), not the outer 802.1Q/802.1AD type.
> Doesn't that hide the tags from the core's VLAN-aware feature masking?
>
> include/linux/if_vlan.h:skb_vlan_tagged() {
>         if (!skb_vlan_tag_present(skb) &&
>             likely(!eth_type_vlan(skb->protocol)))
>                 return false;
>     ...
> }
>
> With the inner protocol here, __netif_skb_features() never intersects
> dev->vlan_features. vlan_features_check()->skb_vlan_tagged_multi() also
> returns false right away. QinQ frames therefore skip the mask that
> limits checksum offload to NETIF_F_HW_CSUM devices.
>
> That mask is used by dflt_features_check() and by drivers like r8169
> (rtl8169_features_check() ends with return vlan_features_check(skb,
> features)), stmmac, bnxt, bnx2x and mlx4/mlx5.
>
> Before the patch, skb->protocol was 0, so IP_CSUM-only devices got a
> software checksum for these frames. Now they get CHECKSUM_PARTIAL
> single- and multi-tagged frames that the core normally keeps away from
> their hardware. Could that put wrong checksums on the wire?
>
> AF_PACKET does this differently in packet_parse_headers(). It keeps the
> outer h_proto in skb->protocol, resets the mac header, and only moves
> network_header past the tags:
>
> net/packet/af_packet.c:packet_parse_headers() {
>         skb_reset_mac_header(skb);
>
>         if (!skb->protocol && sock->type =3D=3D SOCK_RAW)
>                 skb->protocol =3D dev_parse_header_protocol(skb);
>     ...
>         if (likely(skb->dev->type =3D=3D ARPHRD_ETHER) &&
>             eth_type_vlan(skb->protocol) &&
>             vlan_get_protocol_and_depth(skb, skb->protocol, &depth) !=3D =
0)
>                 skb_set_network_header(skb, depth);
> }
>
> Would setting skb->protocol =3D eth->h_proto and resetting the mac header
> fit better? skb_vlan_tagged_multi() reads skb_vlan_eth_hdr(), which
> depends on skb_mac_header().
>
> > +     skb_set_network_header(skb, nhoff);

I need some time to rethink about this...

>
> [Severity: Low]
> Should there be a check that an L3 header of type proto fits between
> nhoff and csum_start?
>
> The only layout check above is csum_start >=3D nhoff, and
> xsk_skb_metadata() only requires csum_start + csum_offset + 2 <=3D
> desc->len.
>
> Take a 22-byte frame on ICE with h_proto 0x0800, csum_start 14 and
> csum_offset 6:
>
>   - ice_features_check() sees network offset 14 and an L3 length of 0,
>     and lets the frame through.
>   - skb_csum_hwoffload_help() accepts csum_offset 6, which equals
>     offsetof(struct udphdr, check).
>   - ice_tx_csum() then reads l4_proto =3D ip.v4->protocol at frame offset
>     23. That is past skb->tail, in tailroom that sock_alloc_send_skb()
>     does not zero.
>
> That uninitialized byte then picks the L4 type and length written into
> the TX descriptor, with an IP length of 0. Before the patch, such frames
> got a software checksum.
>
> Would a minimal check help here? For example, require csum_start - nhoff
> to be at least sizeof(struct iphdr) or sizeof(struct ipv6hdr), and leave
> protocol unset otherwise. That would keep these frames on the old
> software checksum path.

I'll double check that. Probably like this:
+ switch (proto) {
+ case htons(ETH_P_IP):
+ l3_min =3D sizeof(struct iphdr);
+ break;
+ case htons(ETH_P_IPV6):
+ l3_min =3D sizeof(struct ipv6hdr);
+ break;
+ default:
+ return skb_checksum_help(skb);
+ }

>
> > +     skb_set_transport_header(skb, skb_checksum_start_offset(skb));
>
> [Severity: High]
> Should the mac header be set here too? skb->mac_header still holds the
> ~0 sentinel from __finalize_skb_around(), and mac_len is 0. Neither the
> xsk TX path nor __dev_direct_xmit() calls skb_reset_mac_header().
>
> With the correct network offset, ice_features_check() now lets these
> skbs through for hardware offload. On E830 with NETIF_F_HW_CSUM (GCS)
> enabled, ice_tx_csum() computes:
>
> drivers/net/ethernet/intel/ice/ice_txrx.c:ice_tx_csum() {
>     ...
>                 /* Set GCS */
>                 u16 csum_start =3D (skb->csum_start - skb->mac_header) / =
2;
>     ...
> }

To solve this, there are a few options:
1. reset the header in xsk, which was actually rejected by Eric[1]. I
think it makes sense that we should fix it in a more general layer
(__dev_direct_xmit()) to cover xsk/af packet/other types of
situations.
2. avoid using mac_header on ICE side.

At least for now, I think we need both of them in the next iteration.

[1]: https://lore.kernel.org/all/CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122=
Gf+kxya3w@mail.gmail.com/

>
> It then writes this value through FIELD_PREP(ICE_TX_GCS_DESC_START_M,
> ...), where ICE_TX_GCS_DESC_START_M is GENMASK(7, 0).
>
> For example, take headroom 64 and an IPv4/UDP frame with csum_start 34.
> That gives skb->csum_start =3D 98:
>
>   - (98 - 65535) / 2 =3D -32718, which is 0x8032 as a u16 and 0x32 after
>     the mask.
>   - The NIC is then told the checksum starts 100 bytes into the frame
>     instead of 34.
>
> Wouldn't that put a corrupted frame on the wire? Before the patch,
> ice_features_check() stripped the checksum features and the stack
> computed a correct software checksum. That makes this a regression on
> the driver the commit message says it fixes.
>
> There is also a related issue that predates this patch.
> ice_xmit_frame_ring() reads the mac header for every xsk copy-mode skb
> whose priority is not TC_PRIO_CONTROL:
>
> drivers/net/ethernet/intel/ice/ice_txrx.c:ice_xmit_frame_ring() {
>     ...
>         eth =3D (struct ethhdr *)skb_mac_header(skb);
>     ...
> }
>
> With mac_header unset, eth->h_proto is read from skb->head + 0xffff +
> 12. Resetting the mac header only for CHECKSUM_PARTIAL skbs would not
> fully fix that.
>
> Would it help to call skb_reset_mac_header(skb) and set skb->mac_len =3D
> nhoff next to the new header setters? That may be needed for every xsk
> generic TX skb on Ethernet devices, not only CHECKSUM_PARTIAL ones.

Not really. See the comments above.

Thanks,
Jason
