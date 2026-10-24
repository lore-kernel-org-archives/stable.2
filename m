Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858473;
	b=XIP0VDBEP4PwfS8S+8M6Suu/FBjBRejt9pxMDgvqJBuhLlGnDnJJe5vvtFF3wnqBKgDU
	 sJXWqpnS+5D75NHcaCPJsqlKvjUrq+IxyteChkQ/5p6melNAbi1uSyf9dTeWjjEOQ7PDT
	 jwWBUutyMkPpz/iCYS/7pQhkFPb0Zq7kYWqd8B6tGdxEUaX7wSaSuJeHFoTWwlKWTqKj1
	 Bes5ZFgQUrgjMEkW1wG1d69F+qxKQKRkniTvu2vSyENioAIgAVB2m9v/eT/8HxiI/xBD7
	 51ZZzadUFBZDAZaJRP7BJ+M1BtxyhBUzueiZbyXhU54kxYJHZwiJWS+lSf2JybByt7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/ctuNn51ZAVrAbsD9CN4nLXkl+KbP560Jdgt2YL9zZs=;
	b=xmS5LQ6LFYHm63AIOMttd/I75oJbfVzNJClfe3vww0ZcpE6kkkjfhffquQXlJjXoRryw
	 a2ypZYJbZZU3VCMl1GL2YON3+wLLhS6diHsJf7i5gHhhiZW4C+XLuaIstP2/5aJ4PPIJs
	 GhNIK2xHtfcQGng5kC/UU7wQFJqwQ6qoGZ59h36l611dxQXnWT08jwOkJZtcqnv2MCatn
	 TAbdYk+e1TBZ68Jn51yxSPpCXBcjs5Vmdsakz9CxOIGF6E//mO6B8rzeWFs4P1QEeOyVU
	 UChKs6KmqXcB2U6Iz8jQn57jwRWGYyh1p5J/zhrCPAuDX4IBr0KVC67nbr4zb4CoJZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eIfNij2d;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A96606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A96606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eIfNij2d
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1313455e0c.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858472; x=1793463272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/ctuNn51ZAVrAbsD9CN4nLXkl+KbP560Jdgt2YL9zZs=;
        b=eIfNij2dEdEokmkKS8BnsW6i8LLmxUoyRB6Qt/rY/mcVT2j7xlgwtQrqnjuXZZRgdI
         wNHTebWE1gQ0UTqDDEhKpnc4D/tft9/Y2h14c2dqmZdX6K3XNJnU1bTQ0Yx1y5/Aw7Ia
         hn7hU3jKEqq1IqOTSKeqh6zmmKlBsA3tduKFBSiNt+OdbM+3MIR/L+Cw0TSaT+Ctl2tA
         BcK/9PoLnXt2XsTY4TzlyyGMTjZ8GL7tVsh512bY0sXuuAKJXP0IXGDfRnQgBuJ86SEz
         Jf1TftKy9WrCbYDBLX6Ufhlbwcqjo32Yen6d1UMQwuDoR+389tOb92EFIzYgagd9Vsyf
         yzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858472; x=1793463272;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ctuNn51ZAVrAbsD9CN4nLXkl+KbP560Jdgt2YL9zZs=;
        b=onS4r+T4EFstvM9hs70NcbO+lWDzcgvC7pUZLdzYJhIDsfwB0ayHCvxR+fEtL77vvu
         /eIIJcudGwZ/8fQkxFQjdKm7LtPEw0AUDOh8nDpfOs8AX4AXQOWVZjG0OnBScCIpoj/F
         GjZz/974hC+PrbsD0FDJD7Zj9GfsKWVT9y/UT2iwbFwvJIX1iKthl2Pe2P7kJcVRWh5H
         22WjlQ6ig7AC9uJWEm8yCVCdt6Qe1PWVadSMbH3Fvdqk2ldFJbf+ZW65elJAXh4TlD3o
         crWReIGDWpfoKBvC1q8HCF87+tQL39N9ei7liDgwvbesVmLEWOZuaFiwKGmhxpSHmIiO
         uDkg==
X-Forwarded-Encrypted: i=1; AKwUvBwLReMliVpkPnC2OiTgXo7YFragDOAUrIn647Q0M6/yrplNMF/AR7Ru+4NEYW26xBhgFuouJPc=@vger.kernel.org
X-Gm-Message-State: AFq9FYINlXoq3tr9THr0qjKWTO3uPGtLV02zPi89jn+7qx8fsIwX+Rzs
	QE3E4SshWGMwmxKWpC30PAWgRZzMl0Zzmnizk7CUqPtkm7L28si1N1Fj
X-Gm-Gg: AYBFou3iGX/vzTXY1UjfgPUaBtno1QoCt5oBVjdJOl3NPn+U5fCp2e/SaZ5DNqhWT3M
	cGGYjApJtstCerLYWOcUo0oArhWz0Qup9tJujR/lTKJnfW04VYmv2EW8KSCIMMGMsWZjq0AyD2W
	NXgF9JpxombR/zFXMycpULQy8wJ9acHdzPIAXs5L3ThIuzKLQBxz9HFJjSe3YIxDtkh4qNd2S3Q
	qdMHBXjssUMoNZhVDXEIOv8sD2kuHgCnHqY8/AbzvUdh6VssbxSAI1+F5OofqyRrsRIcYYrDJ76
	r7Mr0c3+vbZl0FAH1nH1hBA9G1lpa4uo4wr7xARv3tjc5LjdTy3mpjQ4y3E7ze8XKSiCxbqw9FU
	ASZuBQlNFLOy/cPEx1HSZWcLK0P1SdOBJyShrqhi3W7eAVrsvLu4c64Hw9GLx3pbi5fL3WqqLYb
	3flTm2eIg3jSCMg5LEWXSaa9vKIcpR1UHKLIfCIchN9IQuMTNt1A90SIX1cfb7z8+qIJi3araJt
	VvcxtPMo50FAMVYMoeTYKiL9XKOjGjLHMHRcENI+FOxnPRIl/erolaMamTjkT54oz4Vs5xRlraG
	4socHsH0aSoyP9NOquTcQhJOwxLx3gBzxD4FUaO9QdPFIyAT3RrMsfzenNVxEbyAAjl5gzoUPt7
	e/o4IQgLYa8wM6J+qXew=
X-Received: by 2002:a05:6122:4d04:b0:5c9:c60e:5cf5 with SMTP id 71dfb90a1353d-5ec233264edmr617453e0c.19.1792858471785;
        Sat, 24 Oct 2026 09:14:31 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec23427e92sm2582638e0c.9.2026.10.24.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:14:30 -0700 (PDT)
Date: Sat, 24 Oct 2026 12:14:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Jiri Pirko <jiri@resnulli.us>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Vega <vega@nebusec.ai>, 
 John Hurley <john.hurley@netronome.com>, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.eb29d53899f1@gmail.com>
In-Reply-To: <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
 <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
 <willemdebruijn.kernel.30ca6285209f7@gmail.com>
 <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim wrote:
> On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >
> > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jamal Hadi Salim wrote:
> > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jamal Hadi Salim wrote:
> > > > > > The issue:
> > > > > > act_mpls POP can leave the inner Ethernet header in a page fr=
agment after
> > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or =
chained after
> > > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG =
in
> > > > > > __skb_pull().
> > > > > >
> > > > > > The Fix:
> > > > > > After the pop, if the original MAC header is shorter than ETH=
_HLEN, pull
> > > > > > the inner Ethernet header into the linear area and drop only =
when
> > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does noth=
ing when the
> > > > > > skb was not MPLS, so no separate state is needed.
> > > > > >
> > > > > > Conditions to recreate the bug:
> > > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop=

> > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and =
a non-linear
> > > > > >   eth / mpls / inner-eth frame.
> > > > > > - The inner header is in page frags; a following eth_type_tra=
ns() can BUG
> > > > > >   in __skb_pull().
> > > > > >
> > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actio=
ns to TC")
> > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c=
54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6=
ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.c=
om>
> > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > ---
> > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > --- a/net/sched/act_mpls.c
> > > > > > +++ b/net/sched/act_mpls.c
> > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct s=
k_buff *skb,
> > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > > >                                skb->dev && skb->dev->type =3D=
=3D ARPHRD_ETHER))
> > > > > >                       goto drop;
> > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, E=
TH_HLEN))
> > > > > > +                     goto drop;
> > > > >
> > > > > Is this first condition needed?
> > > > >
> > > >
> > > > That was me conjecturing from Eric saying in v1 "...the check can=
 only
> > > > matter when the original MAC header is short.."
> > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > >
> > > > > More importantly, can it hide a bug?
> > > > >
> > > >
> > > > What kind of bug?
> > >
> > > Two kinds. One, if original mac_len is larger, gets popped and the
> > > resultant packet is still too short for ETH_HLEN afterwards.
> > >
> > > But this can probably not happen, as skb_mpls_pop only pops one MPL=
S
> > > tag.
> > >
> > > What this patch tries to ensure is that the subsequent Ethernet
> > > header is linear.
> > >
> > > The second potential bug is this assumption that after the MPLS tag=

> > > lies an Ethernet header. Is that a valid assumption? Or could we dr=
op
> > > a valid packet with smaller header.
> > >
> >
> > tbh, I was thinking more about skb frags earlier.
> > You are right only ETH_P_TEB promises an inner Ethernet header; for
> > other inner protocols the pull is wrong, so I=E2=80=99ll check for
> > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the=

> > current fix - good you responded before i sent out.
> >
> > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
> >
> >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(sk=
b, ETH_HLEN))
> >                 goto drop;
> >
> > Note: skb_eth_pop() only removes the outer ethernet header but does
> > not change skb->protocol
> >
> =

> I am going to send it without this 1/6 change - it just doesn't feel
> like good taste. I will add a comment in the changes to say i
> considered it but decided not to. I also spent time eyeballing the
> code, i dont think there's a potential way to craft a packet that will
> hit the perceived issue. In any case the 24 hour embargo lifts in a
> few hours so i am not posting yet.
> =

> cheers,
> jamal
> =

> > thoughts?

I'm actually a little confused why the tc layer has to anticipate the
needs of downstream code and pull headers here.

That directly lead to this guessing of what may be the next header,
such as Ethernet. Which may often be correct, but not always.

All protocol parsing code itself should already be robust and call
pskb_may_pull where it is needed. Sounds like there are some targets
post TC where that is not true *and* we think there are too many to
update those targets directly, rather than this transformation logic
that exposes them to unpulled packets?=
