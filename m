Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187637;
	b=0xGfddvWVnbF4/3I8SBXeREnWnKU5ZaRxhlPs7EcMd2xXnMIQCkMelQwG/IuJig7X2nh
	 cQ2IH/zEcIKzw87efdV7Go9NGq2/iRHyMmMZw3XLrez7Lm26gtb7dlbNqUdYqGW6uvw7c
	 1oL1UK11qYBEcnZJRHhqIsCYscykCgjTKjVWImVHNI+TmA5h5JsPElsSd2CHfZIa2BWhY
	 s2G/+UUYnugfHISOwjtuRgi+B5tsv5jeI2lKg8liE6Ol+OpbgHNbDAdiQ9RX5SgoE+cc7
	 1S592S/GU9F2D3CtW67WZikzNu+ALurK5OuP8C6f3qJ2XTvUEayZblqfSThXNG18rZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187637;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=obR2UEdD7Tns0Z10i+23V+1SlPg/ENB2qI48XfeG2/k=;
	b=gi53dftBqAuwjlzzduDf6/Glq1AlqFLIEn9Jx2r3jH1+br6rBI/Ofi3z0Secgx99hNYU
	 2iRZnp25Juqnn/Y2CAdkkfeSNl5Zn/L9WzlyPgYl5VuYwWNNnTdQTMAVqB0+NaVQicVYh
	 4DskdFTCa1OlCDcGQ6X9uP7iNz/RHJyU0eVqn2puUve+ATTDOQQEsv5xIbwkWFYkD2Fvq
	 J2mVT2XxobfuPiMOWTFP/oj6fKC3/qQYBQ0hh6bYCN0xPy1cwzkTYCH0wya1ywugkzoe4
	 kE8nmawJ8lprE/eSA3Uii8yU/jaoX9co98XjxBXvNX5nFKdu1HkTQr+AOAvJDefDN0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezr0klfN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC845606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezr0klfN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B751F031E1
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187636;
	bh=obR2UEdD7Tns0Z10i+23V+1SlPg/ENB2qI48XfeG2/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ezr0klfNxF7Ey0XZOvc/mzvkQZTo8mbVM9GBw1OHHOFyL2e70AIJTb1T6vgvOtVTa
	 GxQT+GsALQQnX5/tfT1DVyUZErOP0YGFdvnLDVCXPpkvo8VFAwkDwACxtHgMF6PCQ2
	 0j3ws7DbySoBOQjnHXodMtEJ0svIkuvaxO5KBUjmArZO5+W4qaWEO9W42EnA5utcQL
	 YJugRcZ+2ed1hBls5s+ieT9dQu6Wqsd6WiRAnlWcmPaZ4SxtOwvx5Ftyzx57Jf1r3O
	 RbXQ4hCYL2HuWud5IcdSYaFUaXAhtqpbND0lgMHH9JGMGsheW/OyiiNVOSf8gPrAMd
	 nPslxBQGs9FoQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-704597ef1d8so392859eaf.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPIVWPxQX44vZBMDJrM5YGa75/d7eZ6sTzus32VJ7xzbhGa5/yQNCC/GMZ+WWX4xm374Nx+Vs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjDegmhJX2beJ8H2jXxvTwSZjSxiPDhpnZ4IxrCWWJtCigcgzE
	u5B/qMcnbrUiSBfCawMoJa9hz5jjG9Pq1FcrRlmn32v/fOGyRZQ6lT56LKcSmfcg4+XG2fkbZgz
	Y5YnhNiRZhj9KGXNU8b1MDLuF9wzCs/E=
X-Received: by 2002:a05:6820:151a:b0:70b:9806:c916 with SMTP id
 006d021491bc7-713eeb541c3mr1075160eaf.51.1793187635194; Wed, 28 Oct 2026
 04:40:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
 <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
In-Reply-To: <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 28 Oct 2026 12:40:23 +0100
X-Gmail-Original-Message-ID: <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
X-Gm-Features: AclHuK_CEP5bgRzGigT6P04fyHtIPSbz6OTbsbeDJkrmOaj61eVvdu3lBePlTmM
Message-ID: <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: bot+bpf-ci@kernel.org
Cc: jhs@mojatatu.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, victor@mojatatu.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 28 oct. 2026 =C3=A0 11:19, <bot+bpf-ci@kernel.org> a =C3=A9crit :
>
> > bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
>
> TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() ma=
y
> wrongly drop valid packets on tc egress and netkit, where mac_len is ofte=
n 0;
> a regression that would reach stable.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index b7ac145b68b1..95a8a728a71d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
>
> [ ... ]
>
> > @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_bu=
ff *skb, struct net_device *dev,
> >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device=
 *dev,
> >                               struct bpf_nh_params *nh)
> >  {
> > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > +     struct ethhdr *ethh;
> >
> >       if (unlikely(skb->mac_header >=3D skb->network_header))
> >               goto out;
> > +     if (unlikely(skb->mac_len < ETH_HLEN ||
> > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > +             goto out;
>
> Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egress
> and netkit?
>


The bot is right, sorry Jamal, I missed this when looking at your
first version.

skb->mac_len is only set on the receive path. On tc egress (and netkit),
it is usually 0 for locally generated packets, so this would drop all
bpf_redirect_neigh() traffic from egress programs.

In both cases skb->data is at the MAC header when __bpf_redirect_neigh()
runs (sch_handle_ingress() pushes skb->mac_len before skb_do_redirect()),
so you can use skb_network_offset() instead:

if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
     !pskb_may_pull(skb, ETH_HLEN)))
        goto out;

This still rejects the 1-byte header from bpf_skb_change_head(skb, 1, 0),
and also covers the existing mac_header >=3D network_header test.


> skb->mac_len is only set on the receive path, where
> __netif_receive_skb_core() calls skb_reset_mac_len().  The transmit path
> only calls skb_reset_mac_header() in __dev_queue_xmit(), and nothing in
> ip_finish_output2(), neigh_output(), eth_header(), sch_handle_egress(),
> tcx_run(), cls_bpf_classify() (egress branch), netkit_xmit() or
> netkit_prep_forward() writes mac_len.
>
> A packet built by a local socket starts with mac_len =3D=3D 0, because
> skbuff_clear() zeroes everything before 'tail', and skb_clone() (used by =
TCP
> transmit) copies that 0.
>
> For example, with tc egress and a locally generated IPv4/IPv6 packet:
>
> ip_finish_output2()
>   neigh_output()
>     dev_queue_xmit()
>       __dev_queue_xmit()          <- skb_reset_mac_header() only
>         sch_handle_egress()
>           tc_run() / tcx_run()
>             prog returns bpf_redirect_neigh() =3D TC_ACT_REDIRECT
>               skb_do_redirect()
>                 __bpf_redirect_neigh()
>
> Here mac_header < network_header passes, because an Ethernet header was
> pushed, but mac_len =3D=3D 0 < ETH_HLEN, so the skb goes to 'out', gets
> kfree_skb() and -ENOTSUPP is returned.
>
> The same happens with netkit:
>
> netkit_xmit()
>   netkit_run()
>     NETKIT_REDIRECT
>       skb_do_redirect()
>         __bpf_redirect_neigh()
>
> with mac_len still 0.  Netkit programs are BPF_PROG_TYPE_SCHED_CLS, and
> tc_cls_act_func_proto() allows BPF_FUNC_redirect_neigh.  Forwarded traffi=
c
> that arrived on a layer 3 device (mac_len 0 on receive) and leaves throug=
h
> an Ethernet device's tc egress would be dropped as well.
>
> Before this patch these paths worked, since the Ethernet header is linear
> (dev_hard_header() pushes it into the head) and skb_pull(skb, ETH_HLEN) w=
as
> fine.  bpf_out_neigh_v4/v6() calling sock_confirm_neigh(skb, neigh) also
> suggests the helper is meant to handle locally generated skbs.
>
> Elsewhere the kernel already treats mac_len as unreliable at egress.
> act_mirred uses:
>
>     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
>
> and act_mpls uses skb_network_offset(skb) when not at ingress.
>
> The bpf_redirect_neigh selftests (test_tc_neigh, test_tc_neigh_fib,
> test_tc_dtime) all attach at tc ingress, where mac_len is valid, so they
> would not catch this.
>
> Would testing the real MAC header length work instead, for example
> skb_mac_header_len(skb) < ETH_HLEN (network_header - mac_header), or
> skb_network_offset(skb) < ETH_HLEN with skb->data at the MAC header here?
>
> That would still reject the 1-byte header from the commit message (pop_et=
h
> followed by bpf_skb_change_head(skb, 1, 0)) without dropping egress and
> netkit traffic.  Since the patch carries Cc: stable, this regression woul=
d
> also reach stable kernels.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/406663=
97744
