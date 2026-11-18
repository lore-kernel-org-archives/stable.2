Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794976431;
	b=H6q9Xug8deNYEJgwN5Y1Pon+4+SXT+NKsEdguPmD81s6JJLZF+lJWyeO5l35eYEUiSlJ
	 rZ7SRRNUFtsD+qXaJ5gKwUwx4MyUY/fKNnzZidzuqwI+bP/wNZy8QkF8gqVkzl01TYnvu
	 bRdZ/DrOAAqf1W37vTsVYC7MZpgYcaQjIx0gJTncz+OAZZIYNxZJGYFU3JLWjghUE4INb
	 9vw7lUZpyT1LjiV+nCQFFshyAAh0s58+kdWmjjgLeJlNQ0S92yWaYeeJnAW93bRBkjIp3
	 yeina+sKmZosjADuY5uzFD4gH4TRWg/lvQljWXiGHMJdtVfuVqFL2vkDw2V7XS0Yx7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794976431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MUs8CjwaGuk4iVeRZDmUQDbYR0xgE9bvqwlZImODLwc=;
	b=nycqzWyiwAIKSwM6vAY4ig/FNQVwCSLoPdstZSfPBhEce38Q/V2c/uPXqxecKabrnT9k
	 U/MxEBENBotjMwawYQHEBwKhMviQm7ldY88WQ69pXexWcZAUiiowvnuye68O8XUau0LL0
	 TbHVmzQiL75cmVtZW9Ie7TGlG17/gW6IHmFiL6lT0il6Ak5+0tgk2B4ki+2CXnGE/dx2i
	 T75FMXUj0aoC3/ssGrTr7H6pdtDCgixchWRoxlFcOebKDPnjvSk+DT56M2t2HbXvwFvc7
	 qyOQPjTcmmZtVBGjwH8nWQ0u6ksmUU4ujfZJ44Zf+zkFGibBZ02FA2BUt4QVDIHQ3hA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lOomIVn5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C7606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2C7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lOomIVn5
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c50933bdf4bso115751566b.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 20:33:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794976429; cv=none;
        d=google.com; s=arc-20260327;
        b=a5C82aywwcgVuvu18nDQRQ3E7jbxH13BiLH2g+uvEzxQ8icp0fco/LJGDpOL/IBZlv
         AThxbY1tpzygImgu1Cd9JC0EPTYs8LKg4DzFH+Fm44EHJCgMKC3vqzXO3hj9K1McSyT7
         OKO7oPZTXO806/lmDWH8VqS1yTlZozeOV9wbaFSws4HVpSBP1RymJyzj5yl/b/OOEWzi
         KOCtlU6/NznpQDL8nwvEF94Dc9ARauaNwW+AlHNpA/9fveXzTYj/jZb8a7G3qlh3Tl5P
         /hp/YxpXrISwmpAKX69Bs10FWhIhECvdodEXaDBSqCTNOYod+8Q9C+55SQlsDB/Nm9U7
         b9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUs8CjwaGuk4iVeRZDmUQDbYR0xgE9bvqwlZImODLwc=;
        fh=dsZW+S+lK9+ax8z8AfDrkyxoJw0/GXP5DQh0eSSczWw=;
        b=KO5cyMCDo7ITybGLr81NIEyyxzeaAXmqvueYBJrDWCCvLsEGZ/x2dAH42xLeO9iz3F
         RTm57mwSX4jbxIOl/tayvrX3HAvtQnU8wQQ3MrGIGQUZ4TaHqiS3GvEEZDPeSuRbgm9Y
         AVvLiibcowr9Q2gs0cMY93oPp960yY8PmdbwZ37Ted0A7wePvlvopQbuFBtMlnKAxMQR
         HeHlRHwSNZhjJ2rm78vVyzNVCxY+ZAbr7gJoDnUpzkY2Xt6oJH76DhmtfbsBcBoKXG8r
         OGbSCnntCMLxuDmB5WIn4nhIf27QAISCTQ+FvEPyWgnchMtQmtMzscveSiAYA/TOAgz9
         vpkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794976429; x=1795581229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUs8CjwaGuk4iVeRZDmUQDbYR0xgE9bvqwlZImODLwc=;
        b=lOomIVn5Q9QOElBLYfAz1d71UntWM2MAvpo3ZN+IVP2h5OmfJqOq97xn2Apf9syGeu
         wrSmemvxWEJGy9NwSytqyVj3Cr3cdJO09aBfahxKZxvGhmuAS4KLg3n0HlovQ/BlYS1i
         iT0aa9k4J/B6NR3Kyrz52lf1d9KX+t2/S3NoTKKKQBmadM9Cf4hH2on9vBRrv5MNXUrk
         9BB8eSZMp8O8Yn6Lu++pXgnw+/gaiIlai24FRnZX2wf3Xchuc7gmD1FYMt1CI0atKzkh
         SSPHJvtdUDTD1Ijq1UD3O1n3oPbpWpyVH87UucfZrADRm9Ff3j/ZITQRXA5XyxBNtj5Z
         ZT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794976429; x=1795581229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUs8CjwaGuk4iVeRZDmUQDbYR0xgE9bvqwlZImODLwc=;
        b=2iHP8WH2CR6Blgd6FSBz/WesPOvp+UBC3LzL4idTOOR2cUjJrisNH2KPlAG+PjLPkH
         qymSAClWfiEbm2pZtLoALd3phzeisUY8wcKxRlNAzRHJ4eFV7/yAQgkUJRa7OLAH9w/B
         RZES8I4IwWZA+3H+kx7Dws3+lWAVveimo2j4S9/skSfTP6l0rMyJjWEfM3ljiZGqEkjf
         kNgcggSKiwErL1KW1u6iGiQI8awGdwCXQ8m2+UNLpx6u37MItMt3A8K9Wed6Ig2HbvZv
         KOT/7PRjGRt7Q8jSTC/aTVi8tm9f9CTg0ys+00GeyxRI6CIq9o+b/PXuvnDZ1FcbAuLH
         MEPw==
X-Forwarded-Encrypted: i=1; AL+hErEv+VG7u0CqyaKj+uJ5bs6FLqQRRXn2AON229sYdj6tUt9ie52mezydOkoPzLgsIdkJg5TxJzA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gHqrWOSdrioJAUKeckDy6TkwVOilXXWmIFG8XrlrxZsnj74HF
	vMvFumdk6jcUYEqE6QqaqEBBxQw98IrGHc1uHtJIPZRjcrA7/Uo6aX7+gzfr31gu0nG6W7Q4UNX
	b9BqrwJZZiNVh+mBShL/9WTjWDAumi/wDvTcVPz3C
X-Gm-Gg: AYBFou2tZjwetvJp/N+hPjjwJEgbzFAkQDOYjPhcaVJInNUuSypQixTjdGF5Ow+kl/a
	aMnRx6tEV/zR3ni4hUUdFfv54pb1I7/BQcUSW5O8rGpS8EcthkvHOkb6mu8LGj74EfmV2w3Rm01
	U9HTBMPvJaVPijKbL5gj/ZI/MFoFhsXzAHrblsI1ks9zLJkxr+pY4tcmH5byaugIDdLH5uQEcBa
	aKSi8dujFMMkq9XdrZgLosbRodG46WAirLbaA1Ocw7F21q556mlrmuk+atnu24jkTfQYEo3W73f
	+leyW0nf6YRPbZwiJFh3UcsM+D2GGpaOsIAp2MF5MiY4N7U56UC6r00wBDtRbFJILHSbyzVBH+9
	Agr4VQ3oJLeUft12kHaqt98UqrIgBzpcbnhHMhwJSsaft3bX151zqSOtGKFpLVDh1BZRJ
X-Received: by 2002:a17:907:84a:b0:c40:9b35:ad91 with SMTP id
 a640c23a62f3a-c510e2b7e2amr97065266b.13.1794976428544; Tue, 17 Nov 2026
 20:33:48 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116224308.986555-1-joshwash@google.com> <179495835918.3136.2006086240050992361@kernel.org>
In-Reply-To: <179495835918.3136.2006086240050992361@kernel.org>
From: Ankit Garg <nktgrg@google.com>
Date: Tue, 17 Nov 2026 20:33:36 -0800
X-Gm-Features: AclHuK_uCg09n60i_OGP551CiYLXSQ0RQo7AahklWQYhEoJUhCMiIcbOK6k_ukQ
Message-ID: <CAJcM6BGpwRPm6bhRWp6BWLsaTzwYd__x=tyQqpAcbOKsBCxekQ@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: fix checksum state and gso_segs of HW-GRO packets
To: netdev-bot+sashiko@kernel.org
Cc: joshwash@google.com, netdev@vger.kernel.org, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, thostet@google.com, 
	willemb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	pkaligineedi@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:32=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] gve_rx_complete_rsc()
>   (drivers/net/ethernet/google/gve/gve_rx_dqo.c) works out where the TCP=
=E2=80=A6
>
> --
>
> gve: fix checksum state and gso_segs of HW-GRO packets
>
> This patch makes gve_rx_complete_rsc() set the network and transport
> headers on HW-GRO packets. For device-verified packets it also seeds
> th->check with the TCP pseudo-header checksum and calls tcp_gro_complete(=
),
> so forwarded HW-GRO skbs can be resegmented correctly. IPv4 and IPv6 are
> now told apart by EtherType, and gso_segs is computed from the TCP payloa=
d
> length.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_rx_dqo.c
> > index 82ed5e48b00ab..b4dbfb1ba39b0 100644
> > --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
>
> [ ... ]
>
> > @@ -1049,10 +1061,50 @@ static int gve_rx_complete_rsc(struct sk_buff *=
skb,
> >               skb_frag_off_add(frag, hdr_len);
> >               skb->data_len -=3D hdr_len;
> >               skb->tail +=3D hdr_len;
> > +             /* napi_gro_frags() pulls the Ethernet header later. */
> > +             nhoff =3D ETH_HLEN;
> > +     }
> > +
> > +     /* The header lengths come from the packet, so make sure the head=
ers are
> > +      * in the linear part before reading them and writing th->check.
> > +      */
> > +     if (unlikely(skb_headlen(skb) < nhoff + sizeof(struct iphdr)))
> > +             return -EINVAL;
> > +
> > +     skb_set_network_header(skb, nhoff);
> > +     proto =3D nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->pr=
otocol;
> > +     switch (proto) {
> > +     case htons(ETH_P_IP):
> > +             gso_type =3D SKB_GSO_TCPV4;
> > +             thoff =3D nhoff + ip_hdrlen(skb);
> > +             break;
> > +     case htons(ETH_P_IPV6):
> > +             gso_type =3D SKB_GSO_TCPV6;
> > +             thoff =3D nhoff + sizeof(struct ipv6hdr);
>
> [Severity: Medium]
> Is it safe to assume the TCP header comes right after the fixed IPv6
> header here?
>
> Nothing checks ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_TCP or desc->ipv6_ex=
_add.
> The IPv4 case above also uses ip_hdrlen() without checking
> ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP. The only sign that L4 is TCP is=
 the
> ptype.l4_type check at the top of gve_rx_complete_rsc().
>
> The descriptor suggests the device does parse IPv6 extension headers:
>
> gve_desc_dqo.h:
>         /* Set when IPv6 packet contains a destination options header or =
routing
>          * header.
>          */
>         u8 ipv6_ex_add: 1;
>
> gve_rx_skb_csum() only holds back CHECKSUM_UNNECESSARY when that bit is
> set:
>
>         } else if (ptype.l3_type =3D=3D GVE_L3_TYPE_IPV6) {
>                 /* Checksum should be skipped if this flag is set. */
>                 if (unlikely(desc->ipv6_ex_add))
>                         return;
>         }
>
> So an IPv6/TCP packet with a hop-by-hop header and a device-verified
> checksum would still be CHECKSUM_UNNECESSARY when it gets here.
>
> Suppose the device coalesces such a packet, or a tunnelled packet whose
> ptype reports the inner L4 as TCP. Then thoff would point into the
> extension or tunnel header, and tcp_hdrlen() would read doff from the
> wrong bytes.
>
> gve_rx_fixup_gro_checksum() would then write the pseudo-header seed at
> that offset:
>
>         th->check =3D ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
>                                   &ipv6_hdr(skb)->daddr, 0);
>
> tcp_gro_complete() would also set csum_start, csum_offset and
> CHECKSUM_PARTIAL at that offset.
>
> Wouldn't a forwarded packet then leave through TSO/GSO with a bad
> checksum? That is the same blackholing this patch sets out to fix.
>
> The destination-options and routing cases are CHECKSUM_NONE, but they
> still hit the wrong doff. That could drop a valid packet with -EINVAL or
> give it a wrong gso_segs. It could also take the new early return:
>
>         payload =3D skb->len - thoff - tcp_hdrlen(skb);
>         if (payload <=3D rsc_seg_len)
>                 return 0;
>
> and deliver a multi-segment coalesced packet without gso_size.
>
> Before this patch the RSC path never read or wrote the TCP header, so
> this assumption is new. The changelog gives the VLAN guarantee ("The
> device does not coalesce VLAN tagged frames"), but says nothing about
> IPv6 extension headers or encapsulation.
>
> For comparison, bnx2x_set_gro_params() documents the matching hardware
> guarantee ("TPA aggregation won't have either IP options or TCP options
> other than timestamp or IPv6 extension headers"). The mlx5 SHAMPO path
> checks ipv6->nexthdr =3D=3D IPPROTO_TCP.
>
> Could the device guarantee be documented in the changelog and in a
> comment? Alternatively, could this check ip_hdr(skb)->protocol and
> ipv6_hdr(skb)->nexthdr against IPPROTO_TCP (and ihl >=3D 5), and skip the
> GSO and checksum fixup otherwise?
>
GVE device doesn't coalesce IPv6 packets with extension headers. I
will send a v3 documenting that guarantee in changelog.
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261116224308.986555-1-joshwash%40google.com
pw-bot: cr
