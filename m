Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792918568;
	b=wCVA0YfcSDUINtpyjMzaIAKOEKYrsnU8pzbbBfnUvFTmmeIQ+J8PwBQQxdOohS7jV2mc
	 C0NE9j0E09PZOyZZhgeXxT9/nhoPeHj5bQJPETHyX0fqqVZh5ohhd5tWtCDIoO2nvp57R
	 wI1+Fu2w0I7tEcOtoErF7rortw/aX+NGsDKuSkB5nqU5mr1Gc7J+gIBdjJecW2AHqEe0P
	 z2lszZ+vsB3lAWavxqbh34pELTfyfJFxOWGrRsmAQjkUyAyqwXYz7bnLgxf+AMZ5N7Fc0
	 Bd0Cjv0vBhk4yE4Qb53cfCJ80gVHud9B9a5LjDU6FLVkAROFw0x3GWYrb4pJBBCin4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
	b=Ypdrwdeasz+7OBGL2tAgm3cLl/z+Eps/oaDQI10mz9AeUkFIkJ8ayPBY+8FMBWlqQSjW
	 V0QHYqnaNDADjgujwXYWk9HnU1Vb4tSDK5USZ7KdFV4/T1hKkdRfpGCysP6HY6xjd/cEq
	 rg4xurkFZL+ssCtBfMPzqru6Ltw7Elu/e9xo1Tb60G2Vc/szEexG+c4ikJhFeT5CMKeKR
	 8mL7pqjFESIV+H1S3icE0rBjlREYFpAKRC237kA9XmI5BzhJ0NV/06z2Xg+kUfG6M8WrH
	 edLgJAl/dNMAQwToOi9LWyHjxTpFfE+j4gZz+hxyU0/l4a0eJWzKT9j8hqIs0IbExTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mi05lP3G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0C606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D0C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mi05lP3G
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so1150752a12.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 01:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792918567; cv=none;
        d=google.com; s=arc-20260327;
        b=rVvsrEoQ6v1/133LSlIYxmvpbLRUWtJmz12UHybDGKLRxoazS4Jb/mYC21R35nkwdr
         tcvA5GC/rGfw1K81WyxqQ+8DCinZLNrlht+m8qVONsspjxYosuKmT0MZB4tz1U+K2/ap
         iRMGFFpmsJ9gCSrb9hHc7Bef9yaaAPNzNrIFg4ZyFzuT5uYYXLo9dAfh+knrN9yI4ItD
         1sUu2Rtx+tuuDA7sOpj9sPRwia1RjuKKYqpDgB98973oia2BfjgC7vn0mJJKT4kuiB8O
         6JScq4nRc0FlST3kdBJxDVILsDfNjiZworyePRutxHWg5ApY4qhcvwqzioWM07KaBGmC
         pQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        fh=7nMeXjaakYS3g+apMbSBVREb8S0rFNT6fXXUpzkDfmg=;
        b=Zp4TV7GdIPSv2IEUvWyRVF6KBGpIiVlejZMIFdvK9wg9l6qgU8uG00MaTwxnaGW72n
         1C9Fc1L/qC++bPp7nIH5GKQca/Ao3QaJYHi/FHpCXpmE6daGagmAg8q8qN0QNvuISyfs
         wggy7RhNPkurrWoZ82QOr1jEyABE1VdeLJYTBE/035DwM++F9mi316ITYn4xmuocHMGE
         cKXVnNwnLMjlLFBH7ht0/NDET/CtlgmRIuA88xuMwGK70ENIpqcJ8pCcxosD7e+/mb1J
         tbxvuOcLhVZ77wBl+w4BIwqvISjPRqXCOYkcwmKlLNRCjeCHAPg1zPbrsi9n0OuS+WMo
         eYWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792918567; x=1793523367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        b=mi05lP3GpYLdTOXHFSZx440AR9EZif9K/sR71vpfrZw10gO003EZpj7eZM8pCSuEMI
         CdEvSp55VnFp0RdnW1Eg60KgDqkRdse3OjAlE4f6yTRy8XS2grhxxmqqj+/FOxHJyy1k
         RiqFqc2/k9qOfnk18SGgMoyDle5frgqKr2O9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918567; x=1793523367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAWo+wtNpZOYjs7XLX4+xbKqtyKgnfAjF4Rv0X11cZw=;
        b=COFNjoMdrXlWW0SnGOcdk4YhzjSTNJ25drptAYzETjV2HuJShfM960XF91xwii68IN
         tp1HPbEsEjZbwsZrWRzWpWOgC3P0qdmoIZSZbRxv7nygCX2qVZsf7m1nE3FbT419jBrn
         2H1PINSOxjIZn7uuQgARlgY0Ng+QOfdTyC3j6O8EYk+HGkU51/Gwkd9AdiMzmdvtC4p4
         dpjgNfI2tzDzUkKYFvEgSyPRlJyqqrXn3aWGS4hOdw2uzPfT7cdIUjyjVgO99beIhFbN
         aSq/hyBQU/wxt5GQnzIgaZeNSBN8uVpaakkELd/pE5MZOCsxVcsqAERi0e0fS0K41l35
         c/dQ==
X-Forwarded-Encrypted: i=1; AKwUvBwICh/vnuZ5v1bcqrPkVD2VTFxrAsK7mpfndCbXyYRkBBCTTmZvvDQTgQt47lwwBpodYuwdGDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm56I2+1S1x4SLnQcaZ7NA32qX5xyDwcgDwG143adUFwLSCTuF
	ARGpVoQvU0Fcs7ZZFBPr+Egc6JI5J/3bPNRkQ8OILe7LZ1qn6ffm1HBCziqfFwp4QgHrH+LxJG8
	FO4MqU8HsduINmrHvj6qUjKcr7fr+8tKHHIWGk34A
X-Gm-Gg: AYBFou1QZOJ6+R0HjV6RQkO2b/8788fO5ZUIAQd234whVEbeDaybF4tLKIbekUVjyd+
	oh+dsyRi6wzujg7uQ9fFvQqBSbOffra8uZTsD8YdxPDd2evVk/owWVJKqt/2o4GoJB327H50sJ9
	ctd4nFLIXdsStHi8D7cVEfWS+bqhgI9DtFgUEf5FdT2kL0iCGOUpJzGCemBnhX5Xv7zwyE/+3sQ
	b0mpvpWeym30md463PZpGeCa8qTdfiUTKDxw2g8RXczfH/N2Vk6fKB5HLuqrSQmswA/03+ygzQs
	KgEpNBxF+orNFtB4Ap8WeK4vN8bhFVbD784TtUGm+a8Jb2CUvpKdKp0NfWMrmnWe6RzRiU4cpeD
	xfv/yMFfhrn9+t+nrQO/7/PGqWrgFel/okHUxXLRjEM7ctXNYr4NkEhfg1qrgHOD2siZduQgPmr
	GwoKufzgi9/mF4p+Ovb6XO31HC8gE9mR+AB99B
X-Received: by 2002:a05:6a20:3c8e:b0:3e2:3ce:4ebd with SMTP id
 adf61e73a8af0-3e7cd58c8ffmr3635755637.49.1792918566745; Sun, 25 Oct 2026
 01:56:06 -0700 (PDT)
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
 <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
 <willemdebruijn.kernel.30ca6285209f7@gmail.com> <CAM0EoMm=t2FMLaGNkC_z_a_D5o4=dwVnHS=Bb23NWdmeJVCVuw@mail.gmail.com>
 <CAM0EoM=9GxDCHzpJF_bqcoh+7KZY6E=ZmOiMp7kfVK3bHZDppw@mail.gmail.com> <willemdebruijn.kernel.eb29d53899f1@gmail.com>
In-Reply-To: <willemdebruijn.kernel.eb29d53899f1@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 25 Oct 2026 04:55:54 -0400
X-Gm-Features: AclHuK99nqdl0ku1cQx0dq1jsmNpklmHQLpCQExJVZpP5q9dm1lvzAJpxrv8jM0
Message-ID: <CAM0EoMnQWjN24gBye1kZdcJUJgXDPDy-=dM+NQ6dqCny7O851g@mail.gmail.com>
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

On Sat, Oct 24, 2026 at 12:14=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > On Fri, Oct 23, 2026 at 7:46=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > . On Fri, Oct 23, 2026 at 6:50=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jamal Hadi Salim wrote:
> > > > > On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jamal Hadi Salim wrote:
> > > > > > > The issue:
> > > > > > > act_mpls POP can leave the inner Ethernet header in a page fr=
agment after
> > > > > > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or =
chained after
> > > > > > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG =
in
> > > > > > > __skb_pull().
> > > > > > >
> > > > > > > The Fix:
> > > > > > > After the pop, if the original MAC header is shorter than ETH=
_HLEN, pull
> > > > > > > the inner Ethernet header into the linear area and drop only =
when
> > > > > > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does noth=
ing when the
> > > > > > > skb was not MPLS, so no separate state is needed.
> > > > > > >
> > > > > > > Conditions to recreate the bug:
> > > > > > > - egress tc filter on lo: action vlan pop_eth action mpls pop
> > > > > > >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > > > > > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and =
a non-linear
> > > > > > >   eth / mpls / inner-eth frame.
> > > > > > > - The inner header is in page frags; a following eth_type_tra=
ns() can BUG
> > > > > > >   in __skb_pull().
> > > > > > >
> > > > > > > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actio=
ns to TC")
> > > > > > > Reported-by: Vega <vega@nebusec.ai>
> > > > > > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c=
54fb7e88e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > > > > > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6=
ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com/
> > > > > > > Cc: stable@vger.kernel.org
> > > > > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > > > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.c=
om>
> > > > > > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > > > > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > > > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > > > > ---
> > > > > > >  net/sched/act_mpls.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > > > > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > > > > > --- a/net/sched/act_mpls.c
> > > > > > > +++ b/net/sched/act_mpls.c
> > > > > > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct s=
k_buff *skb,
> > > > > > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > > > > > >                                skb->dev && skb->dev->type =3D=
=3D ARPHRD_ETHER))
> > > > > > >                       goto drop;
> > > > > > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, E=
TH_HLEN))
> > > > > > > +                     goto drop;
> > > > > >
> > > > > > Is this first condition needed?
> > > > > >
> > > > >
> > > > > That was me conjecturing from Eric saying in v1 "...the check can=
 only
> > > > > matter when the original MAC header is short.."
> > > > > Since i have to send a v3 (Thanks Eric;->) I will remove it
> > > > >
> > > > > > More importantly, can it hide a bug?
> > > > > >
> > > > >
> > > > > What kind of bug?
> > > >
> > > > Two kinds. One, if original mac_len is larger, gets popped and the
> > > > resultant packet is still too short for ETH_HLEN afterwards.
> > > >
> > > > But this can probably not happen, as skb_mpls_pop only pops one MPL=
S
> > > > tag.
> > > >
> > > > What this patch tries to ensure is that the subsequent Ethernet
> > > > header is linear.
> > > >
> > > > The second potential bug is this assumption that after the MPLS tag
> > > > lies an Ethernet header. Is that a valid assumption? Or could we dr=
op
> > > > a valid packet with smaller header.
> > > >
> > >
> > > tbh, I was thinking more about skb frags earlier.
> > > You are right only ETH_P_TEB promises an inner Ethernet header; for
> > > other inner protocols the pull is wrong, so I=E2=80=99ll check for
> > > p->tcfm_proto =3D=3D htons(ETH_P_TEB). I didnt have this check in the
> > > current fix - good you responded before i sent out.
> > >
> > > 1/6 (act_vlan POP_ETH) has a similar unconditional
> > > pskb_may_pull(ETH_HLEN). A brute approach is also to check for TEB:
> > >
> > >       if (skb->protocol =3D=3D htons(ETH_P_TEB) &&  !pskb_may_pull(sk=
b, ETH_HLEN))
> > >                 goto drop;
> > >
> > > Note: skb_eth_pop() only removes the outer ethernet header but does
> > > not change skb->protocol
> > >
> >
> > I am going to send it without this 1/6 change - it just doesn't feel
> > like good taste. I will add a comment in the changes to say i
> > considered it but decided not to. I also spent time eyeballing the
> > code, i dont think there's a potential way to craft a packet that will
> > hit the perceived issue. In any case the 24 hour embargo lifts in a
> > few hours so i am not posting yet.
> >
> > cheers,
> > jamal
> >
> > > thoughts?
>
> I'm actually a little confused why the tc layer has to anticipate the
> needs of downstream code and pull headers here.
>
> That directly lead to this guessing of what may be the next header,
> such as Ethernet. Which may often be correct, but not always.
>
> All protocol parsing code itself should already be robust and call
> pskb_may_pull where it is needed. Sounds like there are some targets
> post TC where that is not true *and* we think there are too many to
> update those targets directly, rather than this transformation logic
> that exposes them to unpulled packets?

Not "too many updates" rather the main motivation here (which i kinda
empathize with) is pushback from Eric that you have to "fix at the
producer" to avoid performance degradation at the "consumer". i.e
rather fix the vlan action than have loopback vet as in the original
patch  (and you just witnessed him stand up and push back on tun for
that same reason ;->).
IOW, we are anticipating so that eth type transfer doesnt bug out
(_for ethernet headers_) when invoked at the downstream consumer
(loopback etc). Essentially it is a game of whack-a-mole until the
next bug or malicious use shows up.
Generally, policing intoxicated drivers from getting on the autobahn
isn't the best philosophy; it's better to complement that with a
"driver beware, you may encounter drunks" warning but that would slow
down the fast car on the autobahn ;->

cheers,
jamal
