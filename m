Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188416;
	b=ae9grB9ZKXCYdSeXlTA9VsAnqcj5eHBnITeulBG6MuFQRrVsC2QFFGfXiqGX4l2MC9vZ
	 gRjiWcIrcfiOso5l0iZy3WfZZ6slI4AxhFOLOf2SHX+2Jz4YCe/UnJG919ct3E7fDJ2Ro
	 K39xPMvBi/OU09Us/04ZmkYqpVrZzoSK0eVa5v+77q93oQ3bk1u9NzuSTIfU84AJoNeg6
	 2hTkGsyun4b9Ec8DlTaUGmqw8pqtzj2fWEN1YtOLQhdqJ7AiICO2tRLfk2jkzgrpmFXdd
	 UX5J5mhp6DZemYVZ7x5PKJFZthqhAkHqa+uGf/kJa1jEfoK1yUyYJ1jTdaFVV4yvfng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
	b=MoPmXzl7XuTiyfxl2yQAB7ULF5iH/oFkodtAHRbd8WC+u8BleuUgEJxqg7zjQyBUko1b
	 oiTNYL0x/vaH+H4v+uY6UU8BDH3LGx46Xv0f/9cmcEQxBQ+HB3wRLP8Zz6qUfhTqZRWcf
	 K7kUlU7R0Tp1P1Y74KGTf5Af8cIjAAcFxb9PHKddckVeVto7LwWPWaoFbr6cZT/2qoE5K
	 OruFKZY1N6FI/CQdxxhAFS8x5BrmxuPa3WdBEkXatG7NFKmTdQ9KsbSMzXCgCpf5NqLKZ
	 LpBHfsqUCaf2PGgc7+iQBp3rmeHQWmdgW9VM+VdN6rReDLcSxGEey2Rn/Crwd1Lx4Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F74606A31C
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so639867a12.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 04:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188415; cv=none;
        d=google.com; s=arc-20260327;
        b=PPHGJzNBqXnNCQbULU6FRCPzOahs9dQ2gOsZVvrphnTe6f3tjm+HvEvQTuWJEV9wIf
         0VVFUiy7eeNbvvMGPNhIiHv0/ioXaLiIkfVm6+Bic1D7FMKzAptnz4dRX/p9Z/BfIsF2
         ffrYYpbvSYPdryL0lLSRoIJQ/+0Z4CpTbHWfHFLqyOWnx112GBeyDIJyWJRL5Ki4R4VO
         2NAv5gPlETX6AXBa4CElrwSCk61Q3GCMm5ZywDn+D/6Xq/J6KEojvN0rWfkc6PqInXRB
         lo/v1/9RhdmMRgCsRY6mFqkk7QO/PPrjJRizF89cIoVGHgiCd9ZYTn0zCaQ7n/Fy0xsX
         er9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        fh=BhzuGuCfbZMejyLCWPr1p3D8rG6yp5PiRNsxdRthgZw=;
        b=DljRO0SCiJkMUlfALkfJVe8oLdbtPb1druKHJL4V0f5lqCP4lLT4p4M36AgLr5cWvf
         dDsxkAPN5Hb5Y9MekrHbQuXaWJqLqlT2rC1RIo0O0zDW1W+0ayKghMCAw0TvsmwqEckW
         FCx5hmyalITy6IeThHu38V+qkKr9E7CO6KM06EiquS3v+1K3bZGkdU+jS3tFiviTEsn3
         3OsI2l1YJ0A1v9VSltnB+d9vJJPYM38BC2e6WEAPkxAIwPzE5aCsDMNfb44WaO0F9u6l
         2TTeQeRZK6wsJSH6+ihPJ92MuCjlOW3bSFc99x8PwFrYZF38aP9LXrKBU/2JJXAbTZYS
         6zJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188415; x=1793793215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=WUVYd0kEFrDYGXYAbPFdn+FZT0g4tovRk5OV3qLEhnQMP4yhV6yXzlJfn7ZIM0in39
         uFhhYE+n4MK5SPak2DLasq4/ZRPvpv7tIBqUr1zxvixb9Lx8AisSUHghr/Uh3kVeYoDS
         1fygngZNYVuxVlLs+c5VEO2d3PfmV/8Ftw/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188415; x=1793793215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=rvblvIcz6qp9FvSewxPJ1RQsLlYXHVtGg/WmOwCQUxwIaobLgD+N133S1u5dNsdM01
         5ukBsLDsqEurS9fmr2Wr9kBzPmiEQ8fsw88+xVsYyg6kBMZpXldAEsSXHdQ0b76VrHJH
         ua8RgpS6WhpW5VkAExuJY/mERmTb6S8XXuCo1EEsk4k+VI8764Y/wIMhXS0kI5+KcgGf
         v7Sf/ukaGUGFAK2MnAZj9S8GMrR7rfZLLbn4GNkPIJyZqz3ZNLDJj957jmHa14CGAdVg
         lOI/9+rfHAG7dWbEkiS2gk4qtsQ6/FmzmoQJkFBelF0j/WuLgFlTshwkRDyX5ZzYQ0BS
         8ZIA==
X-Forwarded-Encrypted: i=1; AKwUvBx/NBM2ttJhOaGI/dmAGhlQX2Q0js1a9vSXdgnIR45ymLm0eLuXu8DbDH0Ct6RIMkh/r9TEaZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2Hf2zQSBGwgYxY/6FnsXHOHxFHx6g/1nlAR7caNzQWtpqfrXi
	E5P0agXs3lIWu22i71IaSb/4UOtgBxLOl7hgtAD2ZXTwuPmX8OTveSCnTa8T/gs9kIeQknJHYaN
	Hh+AhD6EAmzIBAbZG9XgHKjbkZET7jx8Nm2DxwJ6+
X-Gm-Gg: AYBFou2+b5d2i4Pq3UIkirOg8wOsHaVk57YYNMjFm247v9t+KjiaFNb8uDsu5bneRf/
	yQgHUveOvqTISe0190p/HjI90R7rzYd5VvbWBjh9lqSkNu+yLAxMA1wwDoKzKciNRwcdAeGowLV
	CFbrkjZu8tRNrNQN/AcSNbVpbpSfs3aPIvC3yiWKW1XjxDiQvsnt2bdBcXHDugiqdFzMLeLeOB+
	iO+7pARrxFCzpEEhMUtzkOWyHyPTHA9qRp1Cqu0TmOMV11e1UH+WTQE3QOKzWt5kdoseGaKti4/
	H93oik9YKf+k2BlB6dlMc1MwCwzHdgGITo0kWVwJATxIzQYlwejfrIMYK3CPIxBEJxjt2rzj6Dz
	z9yjbipUA5WwfoYPD7XzWMJUnJmiLZ+Pse/pQPHTQiQ85vB/w8wkumWVtcLPPxRj5KqLoIq2mUh
	ufBB3+fpYU+ZeYLQg=
X-Received: by 2002:a05:6a21:39a:b0:3e2:8f64:e4ff with SMTP id
 adf61e73a8af0-3e9023c11b2mr1864941637.31.1793188414925; Wed, 28 Oct 2026
 04:53:34 -0700 (PDT)
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
 <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
In-Reply-To: <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:53:22 -0400
X-Gm-Features: AclHuK-GhnK-qd0xLjJB1wtnuCO2c4dWn9lENZM0luOK9ZkwfIjPDiJ_LxTY9Ho
Message-ID: <CAM0EoM=ETuLerW3nd85zuEjwqydrd_9E4r0TbDekYyUZnEBSpw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Eric Dumazet <edumazet@kernel.org>
Cc: bot+bpf-ci@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
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

On Wed, Oct 28, 2026 at 7:40=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mer. 28 oct. 2026 =C3=A0 11:19, <bot+bpf-ci@kernel.org> a =C3=A9crit :
> >
> > > bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
> >
> > TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() =
may
> > wrongly drop valid packets on tc egress and netkit, where mac_len is of=
ten 0;
> > a regression that would reach stable.
> >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index b7ac145b68b1..95a8a728a71d 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> >
> > [ ... ]
> >
> > > @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_=
buff *skb, struct net_device *dev,
> > >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_devi=
ce *dev,
> > >                               struct bpf_nh_params *nh)
> > >  {
> > > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > > +     struct ethhdr *ethh;
> > >
> > >       if (unlikely(skb->mac_header >=3D skb->network_header))
> > >               goto out;
> > > +     if (unlikely(skb->mac_len < ETH_HLEN ||
> > > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > > +             goto out;
> >
> > Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egre=
ss
> > and netkit?
> >
>
>
> The bot is right, sorry Jamal, I missed this when looking at your
> first version.
>

agreed - i will send a v2. I will also test egress/netkit path.
That was fast! (in 7 days on the sashiko nipa i dont remember the
context given the number of fixes)

cheers,
jamal

> skb->mac_len is only set on the receive path. On tc egress (and netkit),
> it is usually 0 for locally generated packets, so this would drop all
> bpf_redirect_neigh() traffic from egress programs.
>
> In both cases skb->data is at the MAC header when __bpf_redirect_neigh()
> runs (sch_handle_ingress() pushes skb->mac_len before skb_do_redirect()),
> so you can use skb_network_offset() instead:
>
> if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
>      !pskb_may_pull(skb, ETH_HLEN)))
>         goto out;
>
> This still rejects the 1-byte header from bpf_skb_change_head(skb, 1, 0),
> and also covers the existing mac_header >=3D network_header test.
>
>
> > skb->mac_len is only set on the receive path, where
> > __netif_receive_skb_core() calls skb_reset_mac_len().  The transmit pat=
h
> > only calls skb_reset_mac_header() in __dev_queue_xmit(), and nothing in
> > ip_finish_output2(), neigh_output(), eth_header(), sch_handle_egress(),
> > tcx_run(), cls_bpf_classify() (egress branch), netkit_xmit() or
> > netkit_prep_forward() writes mac_len.
> >
> > A packet built by a local socket starts with mac_len =3D=3D 0, because
> > skbuff_clear() zeroes everything before 'tail', and skb_clone() (used b=
y TCP
> > transmit) copies that 0.
> >
> > For example, with tc egress and a locally generated IPv4/IPv6 packet:
> >
> > ip_finish_output2()
> >   neigh_output()
> >     dev_queue_xmit()
> >       __dev_queue_xmit()          <- skb_reset_mac_header() only
> >         sch_handle_egress()
> >           tc_run() / tcx_run()
> >             prog returns bpf_redirect_neigh() =3D TC_ACT_REDIRECT
> >               skb_do_redirect()
> >                 __bpf_redirect_neigh()
> >
> > Here mac_header < network_header passes, because an Ethernet header was
> > pushed, but mac_len =3D=3D 0 < ETH_HLEN, so the skb goes to 'out', gets
> > kfree_skb() and -ENOTSUPP is returned.
> >
> > The same happens with netkit:
> >
> > netkit_xmit()
> >   netkit_run()
> >     NETKIT_REDIRECT
> >       skb_do_redirect()
> >         __bpf_redirect_neigh()
> >
> > with mac_len still 0.  Netkit programs are BPF_PROG_TYPE_SCHED_CLS, and
> > tc_cls_act_func_proto() allows BPF_FUNC_redirect_neigh.  Forwarded traf=
fic
> > that arrived on a layer 3 device (mac_len 0 on receive) and leaves thro=
ugh
> > an Ethernet device's tc egress would be dropped as well.
> >
> > Before this patch these paths worked, since the Ethernet header is line=
ar
> > (dev_hard_header() pushes it into the head) and skb_pull(skb, ETH_HLEN)=
 was
> > fine.  bpf_out_neigh_v4/v6() calling sock_confirm_neigh(skb, neigh) als=
o
> > suggests the helper is meant to handle locally generated skbs.
> >
> > Elsewhere the kernel already treats mac_len as unreliable at egress.
> > act_mirred uses:
> >
> >     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
> >
> > and act_mpls uses skb_network_offset(skb) when not at ingress.
> >
> > The bpf_redirect_neigh selftests (test_tc_neigh, test_tc_neigh_fib,
> > test_tc_dtime) all attach at tc ingress, where mac_len is valid, so the=
y
> > would not catch this.
> >
> > Would testing the real MAC header length work instead, for example
> > skb_mac_header_len(skb) < ETH_HLEN (network_header - mac_header), or
> > skb_network_offset(skb) < ETH_HLEN with skb->data at the MAC header her=
e?
> >
> > That would still reject the 1-byte header from the commit message (pop_=
eth
> > followed by bpf_skb_change_head(skb, 1, 0)) without dropping egress and
> > netkit traffic.  Since the patch carries Cc: stable, this regression wo=
uld
> > also reach stable kernels.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/4066=
6397744
