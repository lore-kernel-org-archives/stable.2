Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691552;
	b=CG93XE0XoIHfYjPWwJU7AYC1nVNML0I1nF6hdUfRqcx1Y5Ld/hAm2CvUfBNbk/pJ+I8r
	 zwn+bgi/MYoKVjOLuGejDG2SBmcqbtcio2v9b/7cZ7oXg4WZwM6oK78zJns1QaQI5DK8P
	 5P8zn4V+mTJ3gFYPIGZ01sk46a9rlL0RwTUZZzZRgY5xCvG0r4kjw+j+nPefdd+2Xuy9/
	 jrZrJVbcJ/t0BBTEgcijFAwdqiHRCuBuT5WaGTO6RQZqSTpPH7i95eageErfNwMKNVpRV
	 jNZyBLC9Tq7UUK56k9zCd61MX+82xIsVl/WTuJ6eay2gQuHOzorgzddU0KU5APbRfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691552;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sVf47aEsd+XkYlW1t6M73q5BRuGgvCqtUM6WXvYFTSA=;
	b=z9WOmObHnCFWt9AD0oOf1GJJtahAt+i6pQvTos67yKYuIuIir+wHC+OQgjs/VnMhzxyG
	 ix/M5fZxozeR8de4i4OUXkl4RemiUd9pFXwme7YizXlOmcihH0a8Ujd/KN0zpqoYZv0t7
	 BGqcTKJuRcESj6ikTLmQDd5BUfugNamVxX9vflnZ/PzbrocYGH8fKWqyCa+6BofhX3kvk
	 brTKK4UxwuH7oIYj6MRjodz/YrbmHbiah0ZsFxilIdpMiqlUK8pAnbb1FBJdi+4SzJch3
	 gzPN2b6vfehWt2NXX+tG1r8MvcokqjnI91eTkG5/7S2mhnGU/U8yq06E0nhUHE3RojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT3YR+nh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B2606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT3YR+nh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22531F031E6
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691551;
	bh=sVf47aEsd+XkYlW1t6M73q5BRuGgvCqtUM6WXvYFTSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bT3YR+nh7EgwWufP7iOtZ7C2DcZbDKhWlSvAM253FgDLenF4BRs37VOu/Q6RDMs6t
	 eRIzO2IdzT8OwWzwbATCt0InnIyFhSfYOgcaUN0JExoYl7SBUHcynH56J4y8vmnIjf
	 JJMCWobry35HDzz15PjowDd0yGcbCFxeRMPPVrEdk/IsYfu4+L6oIWWsVKfxjbnIE1
	 75mx162WzUELP+eM2sT+YBDw0KlHFjx2uWsBYQ84JxRBhSacpJ1MeNnd+s8K0MoxnI
	 VGTb01BVde+lP3XZAitfl50/pxDWlHDCTVWoiTNfruuQDWMsAqfiAsiFcwgUWwcEbF
	 Z7bvDdHgkjLbw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bcc6094d7fso1628572e87.2
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 10:52:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwPxJD82Xs95XyHFeRqCB68ax0+4d8veMsojsXzTtBPlaJV2QPLYQT2bXDNTslue+/LXuaLahc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/tik/H/hFhPP1G91KkRaYA9TO900tuuM2OgJnqP6Fns3OXbzd
	jwu3W5tr5Nw6YbZiwzo0sMFdaCIsIzbEWe/fHuin3QVoLK3WEO0ZdinokyBEV41+M2vifH2Eb3V
	8gONW+iQkGJdqIqdW2Fodjctl01myFek=
X-Received: by 2002:a05:6512:2392:b0:5be:5184:8c23 with SMTP id
 2adb3069b0e04-5bfa1c5b7bdmr2526996e87.3.1792691550457; Thu, 22 Oct 2026
 10:52:30 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
In-Reply-To: <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:52:16 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com>
X-Gm-Features: AclHuK-HAodO7ZT4F82zTy6LKJNz-xrSusqBzXNSUa99LviiCuG6cFZ6fapMU2M
Message-ID: <CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrGKrbB9wZknpqf1-w@mail.gmail.com>
Subject: Re: [PATCH net 2/5] net/sched: act_mpls: reject short linear Ethernet
 headers after pop
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 11:22, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> act_mpls POP can leave fewer than ETH_HLEN linear bytes after
> skb_mpls_pop(), either standalone on an Ethernet device or chained after
> act_vlan POP_ETH.  A subsequent eth_type_trans() can then BUG in
> __skb_pull().
>
> The Fix:
> After the pop, when the skb started as MPLS, drop it if the linear head
> is shorter than ETH_HLEN.  Non-MPLS pops and pushes are unaffected.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action mpls pop (standalone), or
>   action vlan pop_eth action mpls pop (chained).
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
>   eth_type_trans() can BUG in __skb_pull().

skb_mpls_pop() calls skb_ensure_writable(skb, mac_len + MPLS_HLEN),
then memmove()s the mac header and pulls MPLS_HLEN.
So after the pop we still have at least mac_len bytes in the linear part.

If mac_len >=3D ETH_HLEN, the new check can never trigger.
It only matters when mac_len < ETH_HLEN, ie after POP_ETH
or on an L3 device.

Do you have a standalone repro? If yes, which path ends up with
mac_len < ETH_HLEN on an Ethernet device?


>
> Fixes: 040b5cfbcefa ("Fixed updating of ethertype in function skb_mpls_po=
p")

This commit only added the @ethernet parameter to fix the ethertype update.
The pop leaving a short linear part dates back to act_mpls introduction:

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")

> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.=
1782548651.git.bronzed_45_vested@icloud.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_mpls.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 4ea8b2e08c3a..4d375033400b 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -57,6 +57,7 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb,
>         struct tcf_mpls *m =3D to_mpls(a);
>         struct tcf_mpls_params *p;
>         __be32 new_lse;
> +       bool was_mpls;
>         int mac_len;
>
>         tcf_lastuse_update(&m->tcf_tm);
> @@ -76,9 +77,12 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *skb=
,
>
>         switch (p->tcfm_action) {
>         case TCA_MPLS_ACT_POP:
> +               was_mpls =3D eth_p_mpls(skb->protocol);
>                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
>                                  skb->dev && skb->dev->type =3D=3D ARPHRD=
_ETHER))
>                         goto drop;
> +               if (was_mpls && unlikely(skb_headlen(skb) < ETH_HLEN))
> +                       goto drop;

Same remark as Willem's on patch 1: please pull instead of dropping.

skb_mpls_pop() only guarantees the popped label was in the linear part.
On an L3 device (mac_len =3D=3D 0) with a label stack, the next label and
the following headers can legitimately sit in a frag.
These packets work today, and this patch would silently drop them.

Something like:

        if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN))
                goto drop;

This would also remove the need for @was_mpls: if the packet
was not MPLS, skb_mpls_pop() did not change anything, and pulling
only drops packets shorter than ETH_HLEN.

Thanks.

>                 break;
>         case TCA_MPLS_ACT_PUSH:
>                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_pro=
tocol(skb, true)));
> --
> 2.43.0
>
