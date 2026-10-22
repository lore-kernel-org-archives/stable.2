Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691847;
	b=lbF1K+a1Tl788b/VNP9EBALxa/RMLg2cFhirMzClvDDJISFe6RHMh5AKgHpOSiqX31CI
	 UlYuDP8ziHBrTYKh14eOgNt09kvtGmeP64uGpV/3DF1M+t0MqvCdIH52sYUqmvW3IRSxq
	 PZLnAsE8r0+tVAV+HATvw2tm5e0DdkKp+EsNGBO2YRHQ8CvYvcAbO8CPAziKD1DaVqPXr
	 wsFWdH3SWjt+GG4eqqNULzWoYfXlqYkxuZmtKR31BilUWB6aeET9y+lo47mwoGZ5gj900
	 iHtGz/XiWB7e5MPoBvhxvG1pCWCQ5S4PYWa9ydcV8UNfOaNLSfoBtBtPEL0tx35sw+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691847;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kezdcC+FSW+yMTp2Da1WjecVlmYgqS8wNI64QyxYIRY=;
	b=La/m53itgeMf+UZN7tI9MUakMKcJkIKfDBNXvv4l8a1hPHWyOZOxNxPT0DYWvsaaPHnY
	 bY2PUQnH1evhrrvHjEvqtLNaDQYAmo8sGX+doa/hXNwk3gTd+tlXgaVwBmsdSuPExbP9Z
	 IZHGkjzGhjKpXUnv5UIBijkO5VqyEzy24SRP/sBM8qVTyHmIRs8XpeOx08oHbNs2b2Wkw
	 gUDhh4zM0UfwYeEvuLgsrxzYsLxPvpaVbdM6+EwOIR0tT3VH+M2hpRQQaiKzNczGt0jci
	 zfdiD3pyEZRbvdYQMUlBq67cP6Ocg8jJByz6P0e6XwUy7/r3GKHmEbl+L5NQuSYIDdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWlmzYsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322A606A32C
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HWlmzYsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B261F01829
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691845;
	bh=kezdcC+FSW+yMTp2Da1WjecVlmYgqS8wNI64QyxYIRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HWlmzYsXxtxFtXk59tbpJnlVi3Eo1x2LZYpEPB5xOjM44lj0VIPkxNqY3mfAtC1Tg
	 JqOisUCzOtZjx6jXvt+i6UPUyvl5/1PpDGRC6cjN3xya5ldpydkEXENdJKNohA6Ul/
	 UMj5x/8eqAOSget0AqX81RuSYWwwcWDu9JqMhKM6v90IWTxydHppNNnP+R+XZwn13K
	 Zq0nlBzVaaNkZfAKDcLCmQHmq71F4UxKDT1xzdPhul4cFpNT3ZTTjSKaTmlOUTRM+l
	 XIu7aYU08FZMJD1RAxXyF8Gu3XISUDcAW75SdNLbaPINRZYtR9JxC8hhAHFlYvFRr3
	 pQjlIxXBhxuNA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab53a99771so19352591fa.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 10:57:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxKjSVYGla1q0SQNJLMB/2uZz5AeHaxU+7iI7LdTq1uMvbUe5Sb21B3Z5S+fLQJ/vViXSmcXDg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuQSvVX6J3oNFaGnEvesGjRyjbbJtK+XwIvlucVOnobDF5FEJL
	HabkUvU/1PF7QW3VxLw347Th3yNlptobW9X+R4q+zzaXjzzHP158zmNXp9zERY7M6IMknFxroKC
	9ABVJZrcF2t6Ix8ldbaDeRIFQr61ICW8=
X-Received: by 2002:a05:651c:c019:20b0:3ac:433c:6ac6 with SMTP id
 38308e7fff4ca-3ac440a79cdmr13633081fa.3.1792691844526; Thu, 22 Oct 2026
 10:57:24 -0700 (PDT)
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
 <willemdebruijn.kernel.38722ee638a21@gmail.com> <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
In-Reply-To: <CAM0EoMnJhXQPxfU65oLYvpc-a6MhZSKi-D664fTMLah_6p7G2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:57:11 +0200
X-Gmail-Original-Message-ID: <CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com>
X-Gm-Features: AclHuK_nqha3vOjEUCmurV-VfrxxzUbueW59pQsZ8XZJ_XYH3Bsub5nUKrzWM3M
Message-ID: <CAL4WiipJLzZ9ywOPaFHZ+wePTOuO+6+aaRCVXMHz+xmmQm2hcA@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net/sched: act_vlan: reject short linear Ethernet
 headers after POP_ETH
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Guillaume Nault <gnault@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, Ren Wei <n05ec@lzu.edu.cn>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowangio@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 18:01, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Thu, Oct 22, 2026 at 11:21=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > act_vlan POP_ETH can leave a linear area shorter than ETH_HLEN; a
> > > subsequent eth_type_trans() may then BUG in __skb_pull() when the fra=
me
> > > is redirected to an Ethernet device.
> > >
> > > The Fix:
> > > Drop the packet at the producer boundary when skb_headlen() is shorte=
r
> > > than ETH_HLEN after skb_eth_pop().
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth.
> > > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-li=
near
> > >   eth / inner-eth frame.
> > > - The pop leaves skb_headlen(skb) < ETH_HLEN; a following
> > >   eth_type_trans() can BUG in __skb_pull().
> > >
> > > Fixes: 19fbcb36a39e ("net/sched: act_vlan: Add {POP,PUSH}_ETH actions=
")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88=
e3b.1782548651.git.bronzed_45_vested@icloud.com/
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/act_vlan.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > > index 6a375fdc63dd..ddf03b08bfe8 100644
> > > --- a/net/sched/act_vlan.c
> > > +++ b/net/sched/act_vlan.c
> > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *=
skb,
> > >               err =3D skb_eth_pop(skb);
> > >               if (err)
> > >                       goto drop;
> > > +             if (unlikely(skb_headlen(skb) < ETH_HLEN))
> > > +                     goto drop;
> >
> > Could it try to pull the header and only drop if the packet is too shor=
t?
> >
>
> What would be the benefit?

Not dropping legitimate packets :)

skb_eth_pop() only guarantees the 14 bytes it removes were in the
linear part. Nothing guarantees anything after them, and many skbs
have exactly ETH_HLEN bytes in their linear part.

For instance, drivers using napi_gro_frags() (mlx4, sfc, gve, be2net,
cxgb4, ionic, ...) when GRO is disabled, or for protocols without a GRO
handler: napi_frags_skb() only pulls the Ethernet header.

After POP_ETH, skb_headlen(skb) is 0 for these packets.
They work today (for example POP_ETH then redirect to bareudp),
and this patch would silently drop them.

        err =3D skb_eth_pop(skb);
        if (err)
                goto drop;
        if (!pskb_may_pull(skb, ETH_HLEN))
                goto drop;

fixes the crash, and only drops packets shorter than ETH_HLEN after the
pop, which are not valid L3 packets anyway.

> Note: the OVS patches pull because they must restore
> MAC_PROTO_ETHERNET and already return an action error, i see a good
> reason there.

The same reasoning applies here: the producer makes the packet
valid for the consumer, it should not punish valid packets.

Thanks.


> > >       case TCA_VLAN_ACT_PUSH_ETH:
> > >               err =3D skb_eth_push(skb, p->tcfv_push_dst, p->tcfv_pus=
h_src);
> > > --
> > > 2.43.0
> > >
> >
> >
