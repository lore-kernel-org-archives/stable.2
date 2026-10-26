Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010725;
	b=U69FwXaaWm4wBoetL87YmMMLZ0C3jqOjH7JhzNToapRpPID463dIBTADwY4bEGS2YwSe
	 RjPIbUupRCfGBKgL6dXNmusnAjap4ZblegP5eJiCgsbMxxGQq3EAk2Zn6BPDhDNbYvHf0
	 LhchXtszhDVi+mB0y+Io5g2A1aI4SbxcHJGSvgnGysRB0LGzzNSEt2cTOfcXRLxgVMXf8
	 RM+c443SBSLd+6vZuK2F3FeJTT0H1CR6FpEFrEIZjLR979gWgd749g/eCYNaB+MZO5OZj
	 vvoKdZmrvvPqwz6dMLw+UsJifKixnpVQW+WTluydI9eDBJz/Y5Ahqhvuqiz/HWhKFAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
	b=qXb6ytKdGi5S67roGYAY1WU8KVnZh0YpR57IwuZdCDq5Arbi+sIs3dvM30IAxcEFMxwa
	 llGGjWYfoOlHA+AfNDAM7dSNXXTfdn+leY2Tzm95BhTacwt1ZebAkQ2bX9TNOedHain9s
	 kWXKLQXfB6ZMOcJXeV5uf5bQ4DVfz6F5W6ViNYN3JHxHRYTzb/HUXFP11N7OcfeB9K0kV
	 f2Qn8A/VrvfKETUFR6jhG31Cg7tCzXytp8ZVl8O0HpNv5lhbk2QLRYJYSz7rGp1cga7O+
	 U+kVWFgRlwacpV15yM0xd0asCdyUuyBWhIklFJeyeEAWcAlzxL6n5OIrhjD+Ts3QK0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=H7Gfj7eT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11C606A320
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 10:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C11C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=H7Gfj7eT
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc502d509c0so761205a12.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 03:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010724; cv=none;
        d=google.com; s=arc-20260327;
        b=qVUhueaBAIpZfyEoQbIQHSZQAw0MjzeY3vyLL++I/9B0fbpdmLTFvz0c8GZWr8QP3G
         xPj1yOXZbP0R759QdU/4AJqdaxf4EXBxFXtrklZTbXNfLHvoJQtKwRFGSHMHjiN1zGMt
         k8bSqTSHaoHGrn8qTLX6FYAWmqlK4C7hrujjp/ksnGU0IQmmom6FP5ouSGdwKrFXczAo
         RHwzRcj5cKROVnMBBy1aSbnn5kRvr/MIqYEmYK2D50k2DfjXZVUHsBpzYT6SDPRumPyD
         x1uuOw+glTW8XbHSYdSzVRor+34lJvCRmgT/B9S7mbvYXHS7vD16oy8e/j1OL8SxqZzX
         PWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        fh=2CAOGa39Q+KZqhRdAMlIoktCAPbHpCAZdnClCtBcBto=;
        b=rZ2DoXY3Ci1/LZz3/ldEvL+FFG+DnbjI+tz4VEbi4vt2NsZGYfMvoCvB4lHl+ogJ9m
         YKDZOb9Xy81F/DkUVzG3mza30mvjgLGHjjr7fSFjF8J5nbOBKVEcYh1yjB56xqAkiXCG
         rKonHE4udnnnFkUNa88BhCnwPq+bBaUm00ug+BdPT6HoDkmpgIbUI6+DoPNd9aDLdmvH
         u1i25U6whSoLgz8wIcqcLFa819/QW99e2B1xJK94Prxb5Bc7iXdQovlbZT+Ae8xvn9fs
         474NQkSarjvmdg0M9IN/U/9kZ72aYISi47qngcN0bzbHT79BXwdPFjzBmd/icMULC9Dd
         GsQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793010724; x=1793615524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        b=H7Gfj7eTuhByc7aUg+GCjYfRMu8fFjWC/14n/SesDTH4yD28GvwqzBxHrCVlBSgT5z
         /T5mZnJ4gfDjFipblEdlAVU8pZamVerjmEIET2rM6Ux/aB0/M6gEwDSLw/Puyeonx08j
         I5qyDPVUMWKdTttVLVbdePuxM4zaRryuOzea0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010724; x=1793615524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        b=FFAbDAVUHqG1Qev9W0DcLGIZAJKx645VAIlXvCuzD0B/hgk5170h6XFqXvWRUyeNb2
         QgLGT4kM23PBNjt49IiBnmI38bbI2nwNIRmx0gxGWCbHaytDYz0G2e+ys5hh1pAcJ0WF
         1WHvC+Aes5W3tVY0pmn6oN4rJkX0410zpybF2jgUpwHN3whMzN0K6qmhseL9H1/mAiza
         GfGXDSfX5YMqhCJpwzeus1tkagxfFnKSq0Gmuy7uOYC1L7JBOFlnOHywjenlkjaGywmp
         TdQ9K++ujBZh5oPOerVLAT2vHc/gAp79ni0ChCrdFCfjU5pj3P6LdhbnX/PdPgZ8o5Uc
         oBrw==
X-Forwarded-Encrypted: i=1; AKwUvBx7Tx8+tiPQVnj8OIyiEUPZaSbSaNyv435kmRegh3Ln71XqU6+dpMITNsabZC9Gk2J3UurF2Q4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLi0z3fjHU7YM0cS1l5bpQVxph+d/IArYrS1Bp1JAdtG0NMBY3Y
	f0UZSi7a3nswVrv0cuukwjQLwXlj1HUHZkxSu+mCKSbB/hJWZJdz0xNHZDPmvDBMBU3NBVQWPUz
	4Zm/NLVrRsK2K/QJECwreRVls+2mH08xOPHzwcWV2
X-Gm-Gg: AYBFou16kBG+Bwu990lf4LWVx3kCu0OjA65eNa4Y0qkXw6E0xaZUwt/4ARzre281VYq
	AWIVaIjmaJWgOEh2Bejd3m7g1wR2U2+22vFmrcNEdz9/4b/qjChM3UOB4hHSm3aJMas8IEiwXq5
	nqOdR/DRCYIVq6hQ+tbeGXDh0ZawTsvBA2eG5x8oGxFe0h7osjbJG/5B75zIZQ08oxUVzXXJ+Pe
	T4aIchTHTSrr98/6dcnd4mxlJ9dMqxskEEMJ+FU3knuWAK1kWhcvoCDdowVMdzYu+82lZ7HY/3e
	SXBSjxY+QzQb1k464avlM0mchwFKwcbWb35ZbVRa2I2br1saa7JjW3AQB0jZeAGyYWY2cvf3/QL
	21no+AlroXCIaTGeKpjUecsA4y3+/gIC09mtovtAvRgywQPiun9FKdutczb/3UkscVBqzHa3KwS
	v0hnFgIjYJNynOWdB1
X-Received: by 2002:a05:6a21:6111:b0:3e2:86b6:9bf4 with SMTP id
 adf61e73a8af0-3e7bfa64eabmr4670051637.14.1793010723749; Mon, 26 Oct 2026
 03:32:03 -0700 (PDT)
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
In-Reply-To: <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 06:31:52 -0400
X-Gm-Features: AclHuK_YrqRHix7Mh3Yx3ZLSjmRZLvRAdRI9H3tduLWZxKVLN31oQ0yauHEq9G8
Message-ID: <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > The issue:
> > When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
> > the inner Ethernet header in a page fragment after skb_mpls_pop(), eith=
er
> > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ETH.  =
A
> > following eth_type_trans() can then BUG in __skb_pull().
> >
> > The Fix:
> > After the pop, pull the inner Ethernet header into the linear area only
> > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
> > fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
> > header and must not be required to carry one.  The pull is a no-op when
> > the header is already linear.
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth action mpls pop protocol =
teb
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
> > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2a=
e@gmail.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
>
> For the series
>
> pw-bot: cr
>
> Eric, you are reading this? See the discussion with Willem.
>

And to be clear, I am suggesting we fix both the producers and consumers.
Basically, as established, producers alone cannot protect against the
eBPF  privileged bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC, ...) or
bpf_xdp_adjust_head() which can re-shrink the head after any producer
fix.
And then we dont have to do this ETH_P_TEB check here.

so i am officially withdrawing this until we reach some consensus.


cheers,
jamal

>
> > ---
> > v2 -> v3:
> >   - drop the pre-pop mac_len gate.  The pull is a no-op when the header
> >     is already linear, so the gate only avoided a cheap call (Willem de
> >     Bruijn).
> >   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
> >     etc.; those inner protocols have no Ethernet header and must not be
> >     required to carry one (Willem de Bruijn).
> > ---
> >  net/sched/act_mpls.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index 4ea8b2e08c3a..35a6d27f76a4 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -79,6 +79,9 @@
> >                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> >                                  skb->dev && skb->dev->type =3D=3D ARPH=
RD_ETHER))
> >                         goto drop;
> > +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> > +                   !pskb_may_pull(skb, ETH_HLEN))
> > +                       goto drop;
> >                 break;
> >         case TCA_MPLS_ACT_PUSH:
> >                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_p=
rotocol(skb, true)));
> > --
> > 2.43.0
