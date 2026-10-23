Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792778987;
	b=vOb1FAKC5mPE977ZONEpRGunzYfJsMK4V53iv/MuUbBs2ewzoAi3T/jP8XzYQAodQBd+
	 iFSrevYfh8xp2lMQu2DazGWEPTzvGUxjt5opWKNLJqWQLIDkfGZ80y3i86wq/EtG+yzWW
	 b7yaLGjBuNNM3hLoBbQFPze1NBec+5Ne+v/qZVRUswQ184d3dotMiCNOa/lmFuTK8bAQ3
	 nvRqR9JyNzPJn3cRmqbJfcBwaa1Bh5pv90uV0a7h/VPXA6ahtCjxtFMz6hWVx+Hf1ea6z
	 2Jm4JGKxu46GRA0Mxs2ZN+VEtyU/kFQ4/oZDYKrMi5ozo+Z7iqLvZNCmaYonJtjL5fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
	b=BzKW8Cpa4m/F45sJv/9nRdPY44qyBnT6s198B569/am3gtjhlAeP8Cg5BTdaV14LXP42
	 NMFv9xDJSXCUR4mS16rtscheaQKX1ybBut24YQyxQ5Fc9p3EjP4Vv6Wym1R2ElQSV74+L
	 PMJHCz6328LxWJoMOnEipuqYLIZThPkBVvhpILwTfr8lCR5tPeX7jjJLIcqmzmvXWkcJ6
	 NJTc4U8tpBE/SsssvSF1P/7JEmRGMpMlZmZvClBz46GOKH93Hpvcn3BPBz84a+vw5jLbI
	 arc/divJ3ilRDIlV31M4E8/D2Hqmtlm8o/fywWcHhV/84jDDXyvzzWgxk4xWMVBaTqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tZOD+mWP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ABA606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06ABA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=tZOD+mWP
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a31c892a1fso224704b3a.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778986; cv=none;
        d=google.com; s=arc-20260327;
        b=e8MHdPxJtrLDekYKCCJi8mMswYAnhn9ZUI60DnRcyteTV10QyeMeU3ypV+CsUznN2N
         MPLth/0a2hopoiX3orFS7++KDJKwcyAdY1X9AL2H1GEJ+pYDa/AMkQAONnlYBiiH86J4
         dvQXN8p23ePhbf3jZcVBN5mzNHnkJpDVk+34sovMVNFhQz5U6wNE03i1bg7+YYM1+6/u
         4pgEUO+kAOv+/hjGLXNsRJbgxEayUBAQ8CEDgO7QvYwsplQrnjXSFO5GimsgjCUKighY
         PVElaXJvz6VmTCuc92pgQbYmDy+eCaXYViXcEUsDQ8QQ3tN8+8orUEtjdHmuRh1O+k3v
         ZNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        fh=X1uLEyA2ikG1Fu2JmTvShI/wGcaba7j+9aHQ9g+lrOo=;
        b=Wj0Ie0nTEjv1xRUGC77WcRvhEPHkAGp5W1wXs1Lqpb1cHXriTqjssC4okctcJODvu7
         rc513Tk7JCwkyvRmwc9JX7QRcfLz6eUa/+B1DNFcjb8GQMx/uByAvPrVLcREYyAIR9Di
         /HJA3kTGLCjMCdpBAPew/DVj22CDWcHVw4SXm24kAuzMMIOugRJzveErYL29iA0mKppd
         Bi0b25/TALeJWTAykM+Xy6GOVBCyqOUA8kPQokcsKg3SCAtAZX/P1CmUprOf4pDc25Vn
         NAEU5LSzGGooan3gMMACyQQnxz+KIPuhm7sD0A86bJyY32FEEqvo3V4gRE0/nZmVPWU8
         tFPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792778986; x=1793383786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        b=tZOD+mWP6IHNBHgc87LVL3lXwgEPXc3rr7H5srdZ+OG/y3OMMebAxdNe8j4hO/gkmg
         NRZkhY8yT3UBtypXBKaXsj82zL0qIebAHXBBUTR1VwZwvovz6u8V0M7CkaKi8nm/8khN
         4X3gpHu0AoPBSQCsf43ig5pueV2EeFJD7AME0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778986; x=1793383786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufQQeasNhgcUlqoxNttXKmDaZXvBewhwENZeB+swFLg=;
        b=FA/W6gWu6F7yZi6fDPgZgU7tSRjBSC7GA73DYGJTX8nyjLJp0zrNWSovBKm0MlIHBf
         TR1QLJGrC4kF2Z0SG/N0QmtvPE2fjQIRiIH6nguvJKhZh36TOGfBGwA4n+KPTVx4niT6
         y6sarnV6OkXGRK7ItiwBXDcNS7F4kPxilrw5jYPwGazaTcGv00dIZYVgpvteSphTy7vR
         WtGkdH1HSAXHGbNE270aZdFwGFL/J7OIiFvabVOTYtFyMkNCWx/dujzcJboP6j+0C2e4
         qUy1FFHlVSWmY0r4trm5TOsg9IdD0kTBLYTfSkw0BlbP2KsDVxLZb/JQcqn4kphRxewc
         vB7A==
X-Forwarded-Encrypted: i=1; AKwUvBxNWET0kf805x5/eLn6EionFOpzpsKt7cqqTpeQBL58Jt0dRHzSR6Ac0uUXdtqgIhay+GuWeiQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWSnIRAF6KPxvu/pA752qVMtZP1/8vwkG6Ep6nr1Sk/jI//UUA
	ejJ9LReJ6KB1VuyMu1l5EG53QmRJBi+ELrsyR00qprDMpsJFJhUQws1AEvQiUsxzbUU06uXZUXA
	2Bkh5dHfzfA5Tu0eoRmfZojeejVXNIkW7vxegPcC0
X-Gm-Gg: AYBFou2ab2/z3PElgoItNcEP/6kUruvz3agie/jw+4x8copKXGS/AZKd3ELHnCB8B6b
	3aR3unaWHkNPgy6X9cEfgOsW+iBRIPysgmXYWASG0czf7Bt31WZ9xHQElSwp8erMFyJM+OOLtec
	fJLZqHscHTR1lgMPcr5UCxOeHNT3WWIlk8t5xgsvGYNKuhU+UxidkN40DH/pj9WXTtb6KCtaJ4X
	wx5VvIGzzOCEjEwJPfR1Jdoae4LQXOZwGCiFURjAllFgdRNdgcRyE7a4bpHb7h+ho35awxLTSdA
	KBoRFCVZJE6mm4c49QFZoZOHr7F45uwIgAO8NEwE7kHCebArKC2HsRuAd0Ku36Od2LlyQmWLINz
	Tbm+r+inpKk4Rf0ZWTiVImtCu9VoIHg8tdsxEHuZFd5wJK5AGvHQ6xGFil51d06CLasUb8OnQ76
	QEItR6fdET+2eL5bA=
X-Received: by 2002:a05:6a00:2d91:b0:89e:f8e9:205e with SMTP id
 d2e1a72fcca58-8a369072e1bmr56680b3a.40.1792778986330; Fri, 23 Oct 2026
 11:09:46 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com> <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
In-Reply-To: <willemdebruijn.kernel.26d1ddb3bd2ae@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 14:09:35 -0400
X-Gm-Features: AclHuK8HN_xi05mcVg0MDRYHrOglk-5vDJvBmXSDY9jfeHaTyXNLXPV37NRYe9A
Message-ID: <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Martin Varghese <martin.varghese@nokia.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > act_mpls POP can leave the inner Ethernet header in a page fragment aft=
er
> > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained af=
ter
> > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > __skb_pull().
> >
> > The Fix:
> > After the pop, if the original MAC header is shorter than ETH_HLEN, pul=
l
> > the inner Ethernet header into the linear area and drop only when
> > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when t=
he
> > skb was not MPLS, so no separate state is needed.
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth action mpls pop
> >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-line=
ar
> >   eth / mpls / inner-eth frame.
> > - The inner header is in page frags; a following eth_type_trans() can B=
UG
> >   in __skb_pull().
> >
> > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com/
> > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zP=
rGKrbB9wZknpqf1-w@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/act_mpls.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index 4ea8b2e08c3a..5363bca892fb 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *sk=
b,
> >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> >                                skb->dev && skb->dev->type =3D=3D ARPHRD=
_ETHER))
> >                       goto drop;
> > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
> > +                     goto drop;
>
> Is this first condition needed?
>

That was me conjecturing from Eric saying in v1 "...the check can only
matter when the original MAC header is short.."
Since i have to send a v3 (Thanks Eric;->) I will remove it

> More importantly, can it hide a bug?
>

What kind of bug?

cheers,
jamal

> Simply running pskb_may_pull is cheap if no pull is needed.
> >               break;
> >       case TCA_MPLS_ACT_PUSH:
> >               new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_pro=
tocol(skb, true)));
> > --
> > 2.43.0
> >
> >
>
>
