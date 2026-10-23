Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792783354;
	b=pfGFi6bmGiUexsMtXby46mkrUU/KvwLXZlWHmHopxbZuzIprTQayJx8Syd2a5nBYR61T
	 FBpfvkvmgoJjJnL54NOqtmJgGchtGdZr1HoH2ITQhNGOnd/aDAeSpQwTSq7gaCD8GtnsB
	 nHuw+7w76h8smXV1e6vxE2oTfE3GgPTuqDNIV5pOQJ5KZ/C/7OctkYrYQ41jnoLq8KJ1r
	 eIL7oiapxYZLpAMLa8rpdlk4vjYwzm3AuQXbvupA80UHqvQcMgHSHlIFLkdpHOodmcime
	 jB72HPtuCQjKH1RlDJVMUZE1/vMKT7upGKHOd/ND8bJfWWfEdqsKkVUUivslZIAUt3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
	b=uAetBqi8P04WKknNOKfYtu/hhWhK55o0VIy3hUm6mWzV/2oPU09lCRMff8ELIJOUZzRd
	 /0NjGQ5XqSqeVtoGjdARwEQDIuKCb0hQEVsBqWZ+zXHrIIXJTsOEA40VG6gFJNTus5taU
	 qEBoNC+j8ghBm4Q3s1DmH9msXcKCpyWT823x2gmsdLnnPZNuiMb6BXUbEl4WoFNOeqRTq
	 30iD1Y9NEKwfTuscXnA16bpmZeymjxnyCC7H6Pptz3OOHHprNplcoZTtP/AoD3ymMWCcl
	 VYnF9BirGHvgvlU6vK7zJ33jdL4JhMqhvKVAw8MHgfMyLrf/0Uu4gtJFJiCJfc0bAiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mXOcn8Pc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9D606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 19:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F9D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mXOcn8Pc
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab98332238so751995a91.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792783352; cv=none;
        d=google.com; s=arc-20260327;
        b=DkVll7HZjP1rvIQI4yNUybYa3uKodPP5YedkFsONWwbNo0QUMfLxbXOwdHVaD4YPCd
         117rJkNwWLKaXgXA/yyLA5564wb3BVn03tdG9GwwWHXGbMeXAB3PGmwrIoy4xa3AspxP
         FgbyFu8P8DrewxK0ocmc9P0wm3uOqkTU8AVYN8KZkkP23Ne+t+94mAtsoaJA9Ui0cE5e
         Bp9StNeaStzoe0SE9Zcs09g20O+IwlMj75UEsj1jUcnB0NQ4J0qtBxWMgVkKwdFM8l/3
         1tiY+M4vAp4NIMyqmTo/LFqWcHqhkFz3jJV9QD27l9v4xZB22BZWu4EtAzwP81z+5mAt
         kICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        fh=MCBqJHciXmed5KbIf49VNszV6HFiz/4tDW/3eWRTm8Y=;
        b=IMmkWX+N+gdujqLc/1UyAtycJgfpqrbulBLQiC0T7Ullmd6VjxT3LwaIdQ33AK5kGk
         MKrgT1BVmy+wB0OAcimYaFOd208e1bvq6Xm0CgF46RCH9Dxzm23RnmLqNPFrdT6ns7pk
         zrFvrEN3gzzkc0HTugt+QFeDCbuv26STi+JQFDGufcwoNLYbpwcuuLvORC30DcQzd83T
         Sc3yDG3K5SFzulQ3Cmu56Nwy27Wiixt9yI8L/LWZAHOlz1rbKxhIpAccfJAZFu4m+QuE
         KZldEIsq33aCgQQJ4VbXYxcbXgz8qlycoqceAd8I4JKslAalzJFtPBjgb9u5+NI5eAyO
         d27A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792783352; x=1793388152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        b=mXOcn8Pcb5uXlfmJsTKeuMl6zVtJrLNg+yXErmU+Mfdd9Yo3GSVnT2KqQhtgkghH1M
         sPmlFRvCAR0gaJH+MScklDupQTIKtAJ7H8geMgWimAcTd3M5k7mWfV8bFf4lzoHzk1Aa
         vLkUZFbX2UZIk7kBATiPu7OCoAG5kp3uCGQlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792783352; x=1793388152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n83Q/EC159YY2+F7TzK9PhoxsQP1/a2Hm2Z45l/eogM=;
        b=HUe/DuXWyYKGrEDOLcNCzdEdjxIjdsdJzM9h7YTwDJDKMZaoPq+pG/hlS+2ZXwRwvP
         MYO6BR6BuQBLQgXB5RwqmcPkgWOf/usOekABSyNseKdVQbk4mEb6ejvXrbdKZcZG+O5P
         NGEdVrsm5basQ6S3h0Z/XHMEp1NCYxwLilCPtx7PjWIKV9Q2FcF6slJJp8Rq9LWlTSeq
         2Tj8AUovsr/Zk+ot62LNebi54hTO8wyVtR2BZZZbe3LvNQKdY4Le9uQ4irJtMhH4Dvkc
         WC5Iy3oW6d4CfE2GHt4j3rJkhP3AHXRNQrYkmrsPkX9IA2a4GqAeC3ZSoPX3Am62lHK2
         QgDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdLXOlYZ4f/CSUhDIHIPuXoIHANgMDPgqj3TnEVlDBIfKvnYdIUsDZvuVH24oJOM7z7SidFBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIICzIwtvMcRoAFiCvSJ3h8wnRQVkPOCK1xWkV9DObkuY3dMm8Q
	HpA4XhHHLP2CUXTL8gGoteULcDp/e5fTm0TRZ2ZLtzkJPBg4aeu/fMZELJTs8XPu1hrC96ARaGf
	TGQdtyq6nPJGIvEgR8IAhkAtv5Ou2KGMlICJzGNt4
X-Gm-Gg: AYBFou3yMwtWSEl8cR80UzW12vddm5P8dYVb534ljHgNWnh7mo8LkGTWkNlf8OHOO7j
	sXl7X3ZK9kFcIdTCFLLy0VE0iwKDhaEB3Y3CXxfRm81RCt1cnvvotpMeaEuMIfkqk9DCP9MjpIP
	qLwDJKLYP0k0UMTeul78aHO3EyQEEGZSZ9Kl5JUpkww3R0M4AE61PVfauWshpM17d/3VNyvQ3ue
	qgocHOycLZ9/dnwPIzxJuPLOB6TY8wEeQArsYan6sklNFvl44mSVjg2LR+wqBJM43akYropOrlc
	p9USJ35G39w5G/h0bP6kCDhUXmOety9wcWsAio/vbf+Q4WMJ52wVR7b96zBOWIMYx1cWqFZ6KkF
	HYXSWQz7xfJsTWFeLZdeSnppd1vkgFAtLFPRbVjZMYIUZnj9pQf9K6v7xp/NPdU2qohPKFSoANm
	JEnr+OgraJbf9f7MQ=
X-Received: by 2002:a17:90b:518d:b0:3a4:e735:b39d with SMTP id
 98e67ed59e1d1-3adeb122d3bmr172533a91.64.1792783352551; Fri, 23 Oct 2026
 12:22:32 -0700 (PDT)
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
In-Reply-To: <CAM0EoMmwNCHVNW0=Z_JWX_ZcT5Y1po1GRVScddOsevEvL8D-6w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 15:22:21 -0400
X-Gm-Features: AclHuK_SSRm_avQLF9vquj0NeUZRfG1s170MkX5bZ8MJjhrYnJHkyeTCVdYVAmU
Message-ID: <CAM0EoMk8-wZ_aMoa91PttzWBB2_FwUpmQjrGJpa6ZjhpPqEKsg@mail.gmail.com>
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

On Fri, Oct 23, 2026 at 2:09=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Oct 23, 2026 at 12:09=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jamal Hadi Salim wrote:
> > > The issue:
> > > act_mpls POP can leave the inner Ethernet header in a page fragment a=
fter
> > > skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained =
after
> > > act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> > > __skb_pull().
> > >
> > > The Fix:
> > > After the pop, if the original MAC header is shorter than ETH_HLEN, p=
ull
> > > the inner Ethernet header into the linear area and drop only when
> > > pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when=
 the
> > > skb was not MPLS, so no separate state is needed.
> > >
> > > Conditions to recreate the bug:
> > > - egress tc filter on lo: action vlan pop_eth action mpls pop
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
> > > Cc: stable@vger.kernel.org
> > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/act_mpls.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > > index 4ea8b2e08c3a..5363bca892fb 100644
> > > --- a/net/sched/act_mpls.c
> > > +++ b/net/sched/act_mpls.c
> > > @@ -79,6 +79,8 @@ TC_INDIRECT_SCOPE int tcf_mpls_act(struct sk_buff *=
skb,
> > >               if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> > >                                skb->dev && skb->dev->type =3D=3D ARPH=
RD_ETHER))
> > >                       goto drop;
> > > +             if (mac_len < ETH_HLEN && !pskb_may_pull(skb, ETH_HLEN)=
)
> > > +                     goto drop;
> >
> > Is this first condition needed?
> >
>
> That was me conjecturing from Eric saying in v1 "...the check can only
> matter when the original MAC header is short.."
> Since i have to send a v3 (Thanks Eric;->) I will remove it
>
> > More importantly, can it hide a bug?
> >
>
> What kind of bug?

Lol - never mind, stoopid question.

cheers,
jamal
