Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793022730;
	b=yqEuwq2tWcvlLHoOpW2XaP8OAYe+WGlP2SoglFIL/YaOrmgTNVvtZn3FbtW2zL1dLDsq
	 KBTxeO5yT8YH2cEQtBw7BT1f00VxKov92GNV0I3yZ2S8tjej1hnr/Ob2yEWMDmGhfDDqC
	 7l7fJA6Xznl5SXPFcnX6384ZR+B6eBojowVihs5LQCEjkgPOfJ16gQwim74vGNnzFR4/i
	 DSZxeAc+fuPPjadWinXjp5XX1+3Cv0JtzqQdtVz+oI0WF9tYCdkkm1hBTj7ad08PHtHjj
	 GGrbkfLacohaWmpRum+MIt245SA8CQellJmFXVHDgPJwf+7ERZlqE6leq+zrFWCWoBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
	b=K/aunQMsq3vWN7NG2JN2ObpLdOGrvQpoiuN3eQjBMGBNwOuLebVXVhP/SiIfsLiOmXUP
	 /ZYDsmT7EpPrDX0rMxt5tLFukY82aM1fsl6U4FSO/ULJqCin3NqRgM300DfOzyvwx6+8h
	 xjwAOASjfuUqNihmZEWP/liucm+3gvV0xVz0WHi10XXcBWXlt5ctZqdGpsis+6y5fx6XQ
	 sHtSxavyjnwkjA35EqAQJrUVyijyhuHeSrdaJOy9j3pfEojJ359EyK5h7ROpWpai/wC6X
	 4v4ySCvOQDYp4qD1ETzHNZQW0iR3NKeZzUj0mEXXDLUq7q39N4h8qOINHLt5zcru+xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LmasV0ui;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B740606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B740606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LmasV0ui
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06c60065fso2286300b3a.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793022729; cv=none;
        d=google.com; s=arc-20260327;
        b=ktTBVQvFQyGnOFLTxywxklRDq1GYHvRQPkRtbrR7Kmib913270JY8OTIvgq+qEBzpF
         L158hA9PouE+2s/fbt0Fv2YGjHXTjRoFth8BEp5ViHQGgjSk81UvVJNdnTJFrKDnQV6H
         /Mpyqw1eZvfEFyuwUu2KGFpBokZJ790iqVcDC3Jg2MNHXWYOl5BzFVDsELuBu/2pKS09
         Zu9s1hTbrKk7lv/QWynNs27KSa7cDjzoWRAsklQVFMO3xnwDnB7PdpvLi83oh7JKWOJF
         SP44Wy5/RYMg4P555OzU/ltrETjK3Ui2lMaSNmLGBD1OiMwTpkAh3822R9DElsMQA+j7
         LyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        fh=w8Qef7Ba9/u3OPWfYkjdZ3t0pPUCXH2T1Oyb43kYxsI=;
        b=fD/eAeZfsNtqA94zpQP2WULwbPSxuI8VZYtFQB7WFuIZUt4NjWQOzYClId3Ert7Z9l
         uED9NwEXFimYl8pH3NVYBOic+pKAjzKjiM1ifV9o1kg3W2TMPYpQfLlm/q3ZMZ/CudO9
         OPW4IsP53po4qmwIeTjfg1seeovFwoTkYKS+3ncx9vZdCL9iW9kCOiC6hqv76TTDlhYx
         9AdW2hw2b27tOHrhB2U8WNBPcKrTpwFMSaPVTqmCRq8Pl6r7dOf8CBev4HV2/4Onv2RT
         GXoelyTCUJX2pHYufks9Vi3aogds92qSByxEHqhWyNYpihkpinyTFAsUZp9d7Y58veMh
         8/9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793022729; x=1793627529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        b=LmasV0ui4kdQsfAyJ7lngYkIeiIKCVIQZRHTef/4KtkDUUK8cK3XNNz7ZUXFSQSjSu
         SvOyGQVA86IbsZI7uA0poZkBflknJDz79Cdib5MdHqvOS+nDHG9NGhb0C9qVIeE46jcP
         YpVyTtbR0apIaduU3f/dJPPpy0NqMHHji8Ml4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022729; x=1793627529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6T6ojp3/wsAICF0em3SzbeRWFZ8SwOtmg8SQkRWdpE=;
        b=s+hyYvCu/RhH500+LbLZ0fhI2RimTZDR03XsbaGu4VMaZ+ZqCCtbr+jId4Hg2pIuNU
         0eItcjpC1PTuCU6NIbVKGtAvHjvS7S/IhiiwQ1GNaV3wJnMA9xPuCcZonNwKMMs0sDBu
         9A3+ViWilTyrdSjt3gkr0nhFyT3HzbFhfCmJlgaFbMD91NARr//utV5lTB4NybrIFLdQ
         /5Ij3N2dhHVyOF5wlRvyZAqUh5km0IK4YAJlmkge52KbSc4qhI5UMfd3WP/+3v9/K1V3
         IPZmNqymvv3gIlqpWc5p32lViugVT1IQUkD5r138Na+A2BzUDiYrenqJ55C/s00S34UP
         T8Qg==
X-Forwarded-Encrypted: i=1; AKwUvBwIwJRU4kTto7WFcGT8teGFHcif8+aIUxFYZ9miP9eAlf+DRzVAnbN5x1Va8mfCWhJYRtmOzLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+KxxGSQCbeDrS9d5gdYpgt68F6X7pi6fl1dnZTmpISAT/C5je
	z656iNmgSZ3tRscZY6jLjhRJQ8FH1Q4wGjMF82k2gFkHT1Y7/bNA1O9A99VuJb0SEIPb9AlrAyB
	ScdekfSs2TdfxfBUPiPhQwStTHCF3r5hfrgWX5ry5
X-Gm-Gg: AYBFou2RTH+yds7ngsTGVaDdqNxXYdFkyOCBcHPRKO5VV028TSsRSKkIjS/xFToZZYG
	Rxbv2n55YRjtypEFw94yJ7sQvPzi1VIGO/q8L1YEMq6HS8MjbIc5KX8UVgaGLWH7kYSJsK3SnkU
	S8K96hZCi4lYx1wRDXS7LLusmDZEca1BVPwTi/u3rNEoZU3PdzOX7g7U7ysqFPUZG5D1nJ/lBLh
	Fb0q58IY0SChqQ09kuviokn91JQMgcFMGtHRe+cvuYVd4R6MoRcVIpi9/7wjWnqFCG4+k8lvOC2
	iLZXA5jsHF73dy6iBQLUgmukMZ8cLL4erzle809vIF+OQLnM47tz/m1gFFq6ZI05HKnwayo07oX
	2ky2Vsj9a5tLgdJsQ2ARNsYBGJxy9uivhswMS/yf4Xo7Yd/E5OsSbpXaNnUy5NKtX8qj6lNj4wl
	igTb+C/4gXFNz05Ek=
X-Received: by 2002:a05:6a00:bd84:b0:89e:f2d2:1eab with SMTP id
 d2e1a72fcca58-8a36705e339mr4645576b3a.42.1793022728453; Mon, 26 Oct 2026
 06:52:08 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com> <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
In-Reply-To: <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 09:51:57 -0400
X-Gm-Features: AclHuK8n1axwQJs9pUQmc7ZR7nx5nXsGpa0-gnNDyqUwkiNvR-9TOtZu2D9QiwE
Message-ID: <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le lun. 26 oct. 2026 =C3=A0 11:32, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
> > > >
> > > > The issue:
> > > > When the configured inner protocol is ETH_P_TEB, act_mpls POP can l=
eave
> > > > the inner Ethernet header in a page fragment after skb_mpls_pop(), =
either
> > > > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ET=
H.  A
> > > > following eth_type_trans() can then BUG in __skb_pull().
> > > >
> > > > The Fix:
> > > > After the pop, pull the inner Ethernet header into the linear area =
only
> > > > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pul=
l
> > > > fails.  Other inner protocols (IP, MPLS, ...) have no inner Etherne=
t
> > > > header and must not be required to carry one.  The pull is a no-op =
when
> > > > the header is already linear.
> > > >
> > > > Conditions to recreate the bug:
> > > > - egress tc filter on lo: action vlan pop_eth action mpls pop proto=
col teb
> > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-=
linear
> > > >   eth / mpls / inner-eth frame.
> > > > - The inner header is in page frags; a following eth_type_trans() c=
an BUG
> > > >   in __skb_pull().
> > > >
> > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to =
TC")
> > > > Reported-by: Vega <vega@nebusec.ai>
> > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e=
88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xi=
S4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3=
bd2ae@gmail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > >
> > >
> > > For the series
> > >
> > > pw-bot: cr
> > >
> > > Eric, you are reading this? See the discussion with Willem.
> > >
> >
> > And to be clear, I am suggesting we fix both the producers and consumer=
s.
>
> I don't think we need to touch loopback / eth_type_trans() directly
> (that's the per-driver cost I pushed back on for tun). There is a single
> natural choke point: the egress fall-through in sch_handle_egress(),
> right before the skb goes back to the driver's ndo_start_xmit(). A
> device advertises how much link-layer header it needs via
> dev->min_header_len, and that is exactly the amount eth_type_trans()
> will pull. One check there covers act_vlan, act_mpls with any inner
> protocol, act_ife, pedit, and BPF, now and in the future:
>

You are resolving part of it with this choke point but: the primary
concern is that ebpf can make changes that will still cause crashes at
the consumer.
Point is not whether you guard against bpf_skb_adjust_room() but more
the boundary coverage i.e not correctness of the check. You are
suggesting to (iiuc) to fix the other stuff inside ebpf? Here are some
sample holes (there are probably others):

1) bpf_skb_adjust_room() then bpf_redirect() - note: bpf_redirect()
returns TC_ACT_REDIRECT; sch_handle_egress() returns at the redirect
case before the check
2) bpf_skb_adjust_room() then bpf_clone_redirect(); The clone is sent
immediately inside the helper and escapes; the original skb may then
return TC_ACT_OK and be checked
3) you are handlin egress only - ingress still vulnerable

and xdp totally bypasses sch_handle_egress() [think
bpf_xdp_adjust_head() then XDP_PASS or XDP redirect to veth

I havent looked closely at the OVS ones you said to drop but hand wave
review seems they can be bypassed (likely i am missing something), so
we cant drop those.

summary?
The concern =E2=80=9Cproducers alone cannot protect=E2=80=9D remains valid =
unless you
convince other wise ;-> Your turn...

cheers,
jamal

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1a09e7869118059e92b53e00ed873dfc7485ffc3..ffc8c4c0dfa35fc6eee12bec7=
99809b0e2476270
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4757,6 +4757,16 @@ sch_handle_egress(struct sk_buff *skb, int
> *ret, struct net_device *dev)
>         }
>         bpf_net_ctx_clear(bpf_net_ctx);
>
> +       /* Egress actions and programs can pop or shrink the link-layer
> +        * header. Drivers expect dev->min_header_len bytes in the linear
> +        * area (e.g. eth_type_trans() in loopback_xmit()).
> +        */
> +       if (unlikely(!pskb_may_pull(skb, dev->min_header_len))) {
> +               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
> +               *ret =3D NET_XMIT_DROP;
> +               return NULL;
> +       }
> +
>         return skb;
>  }
>  #else
>
> It is cheap: only runs when an egress tc/tcx program is attached, it is
> an inline compare, and pskb_may_pull() is a no-op when the header is
> already linear. For non-Ethernet devices min_header_len is 0 so nothing
> changes. It is the same dev->min_header_len gate your act_mirred patch
> already uses, just at the other exit point.
>
> I applied *only* this hunk on top of net (none of patches 1, 2) and ran
> your three reproducers on lo egress under PANIC_ON_OOPS=3Dy:
>
>   1) vlan pop_eth + bpf skb_adjust_room(-1, BPF_ADJ_ROOM_MAC)
>   2) vlan pop_eth + mpls pop protocol ip
>   3) vlan pop_eth alone, non-linear inner eth (AF_PACKET+PACKET_VNET_HDR)
>
> Unpatched: all three BUG in eth_type_trans() via loopback_xmit().
> With the hunk above: all three are dropped cleanly, no BUG.
>
> So for v4 I'd suggest:
>   - drop patches 1 and 2 (the egress check subsumes them, and the
>     ETH_P_TEB taste question goes away);
>   - keep patch 3 (act_mirred) - that's the redirect boundary, a
>     different exit;
>   - keep patch 4 (act_ife) - it fixes the egress frame, not just the
>     crash;
>   - keep patches 5 and 6 (OVS) as-is - OVS actions can't run arbitrary
>     BPF, those producer fixes are correct and already reviewed, and they
>     can go in independently.
>
> One gap this does not cover: the BPF redirect path
> (__bpf_redirect_common() in net/core/filter.c) only checks
> mac_header < network_header, so a 1-byte "mac header" still reaches
> eth_type_trans() via __dev_forward_skb2()/loopback_xmit(). I haven't
> reproduced it yet but it looks like the same bug and the same
> dev->min_header_len guard would close it. Can look into that separately.
>
> Thanks,
>
> >
> >
> > cheers,
> > jamal
> >
> > >
> > > > ---
> > > > v2 -> v3:
> > > >   - drop the pre-pop mac_len gate.  The pull is a no-op when the he=
ader
> > > >     is already linear, so the gate only avoided a cheap call (Wille=
m de
> > > >     Bruijn).
> > > >   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MP=
LS,
> > > >     etc.; those inner protocols have no Ethernet header and must no=
t be
> > > >     required to carry one (Willem de Bruijn).
> > > > ---
> > > >  net/sched/act_mpls.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > index 4ea8b2e08c3a..35a6d27f76a4 100644
> > > > --- a/net/sched/act_mpls.c
> > > > +++ b/net/sched/act_mpls.c
> > > > @@ -79,6 +79,9 @@
> > > >                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > >                                  skb->dev && skb->dev->type =3D=3D =
ARPHRD_ETHER))
> > > >                         goto drop;
> > > > +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> > > > +                   !pskb_may_pull(skb, ETH_HLEN))
> > > > +                       goto drop;
> > > >                 break;
> > > >         case TCA_MPLS_ACT_PUSH:
> > > >                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(s=
kb_protocol(skb, true)));
> > > > --
> > > > 2.43.0
