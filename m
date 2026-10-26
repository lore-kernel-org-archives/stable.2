Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020234;
	b=DGMg/aLN+5D6plOMSeNVmFGW0noIDazstXGvkPDedk36ESgIccKl6doJKoDudEDEBJ79
	 WvLHWZzrNS0F8cEeUGhNIyztRLWUUbdtJBK+Uu9ueuxldlspMOgPuGlz73VLmQ3gcgkSY
	 9URr21vH2IWCZ/TvbxxDOlVd0H9X+p9GYnlvHdjuMwhcq8MpM2rD1NTxoDIV5kZuWNtE+
	 u/QH5pZ9Dij+h3GS9WaVq+SXhFtc6vW2O0b0sf744r/+Oaw+vKbeV/Kwnriowd8Oak6GT
	 YJs1/dRFiTk7hnc3uvo+ysrwvDTL6GttE3WxP+nffgB2nR7X3hPLp3GlBca8vHX4Tag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020234;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ceXZqyDZbjSJNKIpKzybX3IbNeKvCvLhqg+uOKbhDaA=;
	b=UqJEUd8fmJoCN35z9oPBzHy/KvdfU8LAp+trnbenfiAgg7rAgQpkImQ8zWPn/6Fmz0Ds
	 mAe7nhD9c48Gs5ShkR/U7NT5m7vunhwgJXm9XOWi0azB3coxZk83KYNnObl9emttHrJB4
	 Ux4EqtKSfkD1ERZX/aMRh0071HgkcdG3XHRUgCLh0lRQ1QyMfoMRjeaC+3Zu6wPUedToD
	 WBBPWEmouTGsjmadzObkrY7kRGK80kUo34IEdbMZQNsWugxrV4EMUOkPqL9BvjDl+sC48
	 9htiF27Af5b75DTiuek6RuOaxgaxOl+ZwXbR6C+n7CkPRv/pYb6n+apw+fGeuDUrotg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbtJouF2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B14606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbtJouF2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAC51F031E0
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 13:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020233;
	bh=ceXZqyDZbjSJNKIpKzybX3IbNeKvCvLhqg+uOKbhDaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IbtJouF23KmF/ujU9ayRLX0fmwvOp9zhCA7pPTY6lkxh4PF1lw+oWj3R2CCQrv4Lm
	 6VMH+n4OBeqdONyO5UGF2ax6CYmIJqG+C37PGqXWKY9qvlCjS5gCzSd2MYlww/Ln1P
	 4DXa039eRpUqH0B5RghAP4S/2dJXbU0VsOJBW46dGXxC2kgdSucBQu3x1DcqMCEV/F
	 qMTU8sJckTJosE7y0M7hPKUhbzkgCWEi6NnDGJKGtZXQRjdrBwYVtOJDrgatWCWMg5
	 eJ2hq6Q20Xtk6rjD0/qtIj/dQCJyE13TtKpkrGWoG67cInfSq5E/g6Sk9rq5OEtO1D
	 DH6TXBWfHOa2g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-48e9476e26aso1009309fac.3
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 06:10:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTXnQzdMesUPhbyOzuTqvMwCk5ifETnP4ugkfaNDpPQNL2jLKxz6q16mjukIYTETq/TzU7WA0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKECkYprcf2CLOiXe6FeakBpRazFgd3RQCR2HUV+O8+YD5Or7T+
	/eUySexne9EdzL9rnEpFc4qrPf1jpZ2KuQKxFBBSU/MBuNGXqPv29kXiz15bIJ+75NqSeJ8BcBw
	wDLG6pFnnd9uRuJ+w0uPVdRKs5psZRug=
X-Received: by 2002:a05:6871:c8e7:b0:455:d4ba:1dc6 with SMTP id
 586e51a60fabf-4a83f1d4ef2mr4799602fac.5.1793020232147; Mon, 26 Oct 2026
 06:10:32 -0700 (PDT)
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
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
In-Reply-To: <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 14:10:20 +0100
X-Gmail-Original-Message-ID: <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
X-Gm-Features: AclHuK8qH1aV31d0h4LssF8wxy74YlebQMH4xMO3XjkohC_WOp_VXKRU4T1umRQ
Message-ID: <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 11:32, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > The issue:
> > > When the configured inner protocol is ETH_P_TEB, act_mpls POP can lea=
ve
> > > the inner Ethernet header in a page fragment after skb_mpls_pop(), ei=
ther
> > > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ETH.=
  A
> > > following eth_type_trans() can then BUG in __skb_pull().
> > >
> > > The Fix:
> > > After the pop, pull the inner Ethernet header into the linear area on=
ly
> > > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
> > > fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
> > > header and must not be required to carry one.  The pull is a no-op wh=
en
> > > the header is already linear.
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth action mpls pop protoco=
l teb
> > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-li=
near
> > >   eth / mpls / inner-eth frame.
> > > - The inner header is in page frags; a following eth_type_trans() can=
 BUG
> > >   in __skb_pull().
> > >
> > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC=
")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88=
e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4=
zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd=
2ae@gmail.com/
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > >
> >
> > For the series
> >
> > pw-bot: cr
> >
> > Eric, you are reading this? See the discussion with Willem.
> >
>
> And to be clear, I am suggesting we fix both the producers and consumers.

I don't think we need to touch loopback / eth_type_trans() directly
(that's the per-driver cost I pushed back on for tun). There is a single
natural choke point: the egress fall-through in sch_handle_egress(),
right before the skb goes back to the driver's ndo_start_xmit(). A
device advertises how much link-layer header it needs via
dev->min_header_len, and that is exactly the amount eth_type_trans()
will pull. One check there covers act_vlan, act_mpls with any inner
protocol, act_ife, pedit, and BPF, now and in the future:

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869118059e92b53e00ed873dfc7485ffc3..ffc8c4c0dfa35fc6eee12bec799=
809b0e2476270
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4757,6 +4757,16 @@ sch_handle_egress(struct sk_buff *skb, int
*ret, struct net_device *dev)
        }
        bpf_net_ctx_clear(bpf_net_ctx);

+       /* Egress actions and programs can pop or shrink the link-layer
+        * header. Drivers expect dev->min_header_len bytes in the linear
+        * area (e.g. eth_type_trans() in loopback_xmit()).
+        */
+       if (unlikely(!pskb_may_pull(skb, dev->min_header_len))) {
+               kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_SMALL);
+               *ret =3D NET_XMIT_DROP;
+               return NULL;
+       }
+
        return skb;
 }
 #else

It is cheap: only runs when an egress tc/tcx program is attached, it is
an inline compare, and pskb_may_pull() is a no-op when the header is
already linear. For non-Ethernet devices min_header_len is 0 so nothing
changes. It is the same dev->min_header_len gate your act_mirred patch
already uses, just at the other exit point.

I applied *only* this hunk on top of net (none of patches 1, 2) and ran
your three reproducers on lo egress under PANIC_ON_OOPS=3Dy:

  1) vlan pop_eth + bpf skb_adjust_room(-1, BPF_ADJ_ROOM_MAC)
  2) vlan pop_eth + mpls pop protocol ip
  3) vlan pop_eth alone, non-linear inner eth (AF_PACKET+PACKET_VNET_HDR)

Unpatched: all three BUG in eth_type_trans() via loopback_xmit().
With the hunk above: all three are dropped cleanly, no BUG.

So for v4 I'd suggest:
  - drop patches 1 and 2 (the egress check subsumes them, and the
    ETH_P_TEB taste question goes away);
  - keep patch 3 (act_mirred) - that's the redirect boundary, a
    different exit;
  - keep patch 4 (act_ife) - it fixes the egress frame, not just the
    crash;
  - keep patches 5 and 6 (OVS) as-is - OVS actions can't run arbitrary
    BPF, those producer fixes are correct and already reviewed, and they
    can go in independently.

One gap this does not cover: the BPF redirect path
(__bpf_redirect_common() in net/core/filter.c) only checks
mac_header < network_header, so a 1-byte "mac header" still reaches
eth_type_trans() via __dev_forward_skb2()/loopback_xmit(). I haven't
reproduced it yet but it looks like the same bug and the same
dev->min_header_len guard would close it. Can look into that separately.

Thanks,

>
>
> cheers,
> jamal
>
> >
> > > ---
> > > v2 -> v3:
> > >   - drop the pre-pop mac_len gate.  The pull is a no-op when the head=
er
> > >     is already linear, so the gate only avoided a cheap call (Willem =
de
> > >     Bruijn).
> > >   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS=
,
> > >     etc.; those inner protocols have no Ethernet header and must not =
be
> > >     required to carry one (Willem de Bruijn).
> > > ---
> > >  net/sched/act_mpls.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > index 4ea8b2e08c3a..35a6d27f76a4 100644
> > > --- a/net/sched/act_mpls.c
> > > +++ b/net/sched/act_mpls.c
> > > @@ -79,6 +79,9 @@
> > >                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > >                                  skb->dev && skb->dev->type =3D=3D AR=
PHRD_ETHER))
> > >                         goto drop;
> > > +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> > > +                   !pskb_may_pull(skb, ETH_HLEN))
> > > +                       goto drop;
> > >                 break;
> > >         case TCA_MPLS_ACT_PUSH:
> > >                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb=
_protocol(skb, true)));
> > > --
> > > 2.43.0
