Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792777830;
	b=eZi4HbizmQMJR+2alAciHrkYj8U2skwKtMDDel9lvM75dLsWGtVeaq3LlZHDapOdvywA
	 8NaQnz54KMIL7/jsxWLJ1YEhheMbRoRreU6bFihg1P6SsN86lsMZDPcrKUO/iks8icLEU
	 fRiDuf2lrj9+l33HB20e11IMcEL2ts2it12/rAG3W6+djMCJxkswk8nOXC6Iq8Ku9d0mF
	 CDmLXnCnK/E04b0wC9Bk810ry9/zBHKCDJvlmClMNO5k/zTZhgZTv1QwOXrBPfazwf+W8
	 JgRfe2XS6gnCmVa2FUC6L9V4qj0wd0INRJQg4AyiuxdXqohWWkPiLBxWKU7G9JnfXtQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
	b=0Aiaro8tzVNu0RjrU60R9rUQcuHesqhT1fq/0UEiI3yQ40R+TjtX73C3HjoDCnntfOWc
	 7xrrplK701XuGC512qQdmJGSbn1KUEuXUAmzD6HePr469GivcozFs/IvT5Ughko2iSuU5
	 YkM7P1uILyFmz7KXeRxh+MSSasNcyB8cJJofgM81OBluAPOa4ajfrEY9IwwVjm1GJuK0Y
	 fa+tLLIPDQQudjnckA7i+1t76P1tUKNgh5FspQyD/6Ky9n+/fnenq6FqDIerdm/y/+EDY
	 2FVT7rjFpHJq02GIvtvYStfYo2tobD3z7iDzbidTfHIVCr/RktNnHvk7eob/hn9Sr5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kIidCFxN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA81C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=kIidCFxN
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070755c8cso584117b3a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792777829; cv=none;
        d=google.com; s=arc-20260327;
        b=A9uCTOU/IKdcIZIOIIizDSEwvY26z+YmLUE2el1hDbbex5owBnHtwUpUAvMkOtnJAT
         tOLYGUBIUnD++DgX3B6M506+oHSyGpACFRgsnv50fDVqJihNhguX0Gs0b5KD4Mhw8KoX
         dvVKu2JbSFhWYH2H3UFeiUsXf+rD9c9vSdM79F48jFZKFKJ33gvp1CRtq8NzrpzXb/ur
         LjE03c022oNQDIDJurgUBj661aKNByIKIA/q756czvXjsjVUN6I/2UnKWlqTtoreHvN7
         gv1H3GGnUBji0+lzKnR52IkyZvdFfx08St6Een+XyS0fcBNR+qZEkpQL40+E0KF+oEPE
         +pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        fh=ZzCX/nNAeU8/R/XwsCc/GDuRfz9y/iyssND7g2e+qd0=;
        b=itYrJzIU6Nx7bOg1eddpqHmXMvJRpy24h2CoywnuTvuV32qq4DYlU2IM+euOqtZqzh
         vX/BwxL/sldcI3dwJG6/YngTff+xlOeIEwGzucT4MDerTsNv9boQagzHk7wQcN3E4pCI
         /j46Sr/MLQbtmnL60bbq1TGR2FtwBdnSkfjTal2PLGov3u2BjtkWLtH6feq/xTUvBEvG
         dQels5HOsi3+3nrNl6svhi75PW7ZuXIwml2M0btrSTdCgbONIXt2O5H+jnTvI4AhNFrD
         kSJ1iSImTzt7686A6QVL3fa5EhaxT3rDYexBccOi3pCFpRUUin4nUojT6cMx1oVP19hc
         lO5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792777829; x=1793382629; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        b=kIidCFxNjG5wNwDTUl7Dlz3h4oDosCg38JfDfuFTtQAm/Na7/ADzXuYWGVnm5ek2TE
         VfPIf3pfTzjtorBrRVd+JhrDvdver9mnGOpvvrdG39arX7SCdY6FHwP5RBcR3yOYn+dh
         mYzqW/5S4ErTX4U3efu0Yp8W0cfauCHrP9dHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777829; x=1793382629;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfTMKpM4Fi2gQW/7ivR+dxPSeSUZuVAfUibL9pBsSQg=;
        b=hlmdIh3/RuabvyCGexWgMjFkR7E7fv62URfAB3JGMpIpkSvSv0YPzGy1hoDH7yiDvS
         F9NeFsZi2oo+N0NA5sOtc/WniWDwxGy0PvjOT4A2OaXfYyR3e46gbDiSF3SbB7t1UJ4J
         f3jeTKgsPpPUudzCcaaYo6TjvDukAdDjaH+tapYSSi5LYfYp885teEWZfl3Cc13dChRS
         8PDDVpurBKTvpKi/wcaBmta+CRQoq7xOKP8xHjSQQlG4wFE2kE/ToswzBiXHp6Gkb0vB
         irsSKCwrlkKB+hyTnzTg4OqTv/3HLWHC1pgYSCMeQjgJtonQ0BqyD4ncK0nORrgyU1FN
         59pg==
X-Forwarded-Encrypted: i=1; AKwUvBylRdCo4X9DmN7a1UsiOsI3bRf4p00M53KpZbJDSUTaA0gumiNBu4qyvcRvB+zcb/xRMZ9XBko=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaOheyk+CzTeLD9jS0EecebE1pL1+LuUOymDfrIcAxc9OL4YA1
	h9rmb9YorRG63v3QzbH1jN7BJHZZMHT43CwtqUXnFsEipyHYjuk8a8Loh75a2aXcdUnUgY8/RX4
	IHwGRPaCOBgztoc7xPR9n777yy0LSsX+lVsRtbV+S
X-Gm-Gg: AYBFou1JapGmnNUZ+7BM/x8Y+PT1XhK9Ez8eI5ltmc1umhoRXV2UIKOtPDWFoVDlhee
	oL5m09/sBh+aUfndDx0wSbeIU7DeNje8oFYbiW4vHLKD0ZmyViD4kiUnaZ/Gg2rqlslkLYlykjF
	WpF3cwx1UKsHdRXg9ZEtqksp+N++1tnjm8MB8KBuln9mlj7ib1GNmJar5ppkj+wwgxaNkndwvJG
	hOXrV+cuqqwFLxmbfMuwVlNsTZ7mbaXjCSpcdJe6BzK7D+Dckt63+Hp5FSA9tBITRtqeu7VrHKQ
	FH8cmnifcQEhJ6w8+Bppt4GLVdfKH+Ra7mqQefJ/8wTJeoihGJm8iG0fkpx3oE66ucmgNnRdsgf
	11vu8GKUuPDY39fn/X8UT5+nr+lzFRzdp/zVrKjI33Mj9kTiA+EW+55W7jpNELxbL7R9MtsVkax
	7JXJLFSbYC8/A2hks=
X-Received: by 2002:a05:6a20:cc8e:b0:3e2:490d:5127 with SMTP id
 adf61e73a8af0-3e359a408e7mr2657796637.2.1792777829063; Fri, 23 Oct 2026
 10:50:29 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-Y0BY.v1.r0.20261015184107-2@mojatatu.com>
 <179248763469.3135.1739559328868319628@kernel.org> <20261023162821.GN708417@horms.kernel.org>
In-Reply-To: <20261023162821.GN708417@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 23 Oct 2026 13:50:17 -0400
X-Gm-Features: AclHuK-lPnqSWlBjm9YE8wHoMCILoIyS3_3o2j-_BfCIQutA2hTRfAEI60jMb08
Message-ID: <CAM0EoM=TTf=ugCtHv_Sv3Uj0trcUgNYcoSGn+kg_pHymLU-oLg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net/sched: sch_teql: fix use-after-free on lower
 qdisc drop
To: Simon Horman <horms@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, owen@verialabs.com, 
	jiri@resnulli.us, victor@mojatatu.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 12:28=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Oct 20, 2026 at 09:13:54AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] In teql_master_xmit() (net/sched/sch_teql.c), the patch
> >   replaces `=3D=3D NETDEV_TX_OK` with `dev_xmit_complete(rc)`.
>
> Hi Jamal,
>
> Maybe things have moved on for some reason.
> But this concern does seem to warrant a response.
>

Yikes, My new perfect "dont miss anything" script failed and didnt
alert me ;-> Thanks for catching this. I will resend, one of those
comments is legit - so i will send a v2.

I do find sashiko-nipa sometimes misses showing up on the list, so i
have a script that politely polls the site. Polling the site is more
reliable.
It is still strange - sometimes the embargo is lifted in 7 days but i
just saw something with the embargo lifted after 2 days. Is there a
human who decides this and intervenes?

The script has a bug which i just fixed: it took reviews[0] which for
nipa was for patch-1 which was empty review (meaning "No issue found")
and decide that patch-2  was also "No issues found."
At one point i think that approach worked. Note: The site didn't hide
it; the script just selected the wrong array element. Fixed by
matching patch_id/message_id.

cheers,
jamal

> >
> > --
> >
> > net/sched: sch_teql: fix use-after-free on lower qdisc drop
> >
> > This patch changes the check on the slave's netdev_start_xmit() return
> > value in teql_master_xmit(). It now uses dev_xmit_complete() instead of
> > comparing against NETDEV_TX_OK, so a slave that consumes the skb and
> > returns NET_XMIT_DROP is no longer treated as still owning it. This fix=
es
> > a use-after-free when a VLAN slave's lower qdisc drops the packet.
> >
> > > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > > index c7dcec25ef420..b3efd5c281988 100644
> > > --- a/net/sched/sch_teql.c
> > > +++ b/net/sched/sch_teql.c
> > > @@ -350,8 +350,8 @@ static netdev_tx_t teql_master_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> > >
> > >                             skb->dev =3D slave;
> > >                             if (!netif_xmit_frozen_or_stopped(slave_t=
xq) &&
> > > -                               netdev_start_xmit(skb, slave, slave_t=
xq, false) =3D=3D
> > > -                               NETDEV_TX_OK) {
> > > +                               dev_xmit_complete(netdev_start_xmit(s=
kb, slave,
> > > +                                                                   s=
lave_txq, false))) {
> >
> > [Severity: Medium]
> > This closes the use-after-free. Does the same condition now also count
> > dropped packets as successful transmits on teql0?
> >
> > dev_xmit_complete() returns true for any rc < NET_XMIT_MASK. That cover=
s
> > NET_XMIT_DROP and negative errno values as well as NETDEV_TX_OK. All of
> > these now take the success block in teql_master_xmit():
> >
> >     netif_wake_queue(dev);
> >     master->tx_packets++;
> >     master->tx_bytes +=3D length;
> >     rcu_read_unlock();
> >     return NETDEV_TX_OK;
> >
> > They also advance master->slaves to the next slave.
> >
> > teql_master_stats64() copies these counters directly into struct
> > rtnl_link_stats64. There, tx_packets is defined as "Number of packets
> > successfully transmitted".
> >
> > With the reproducer from the commit message (a VLAN slave on a dummy
> > device with a pfifo limit 0 root), every packet the lower qdisc drops
> > would appear as a good transmit in ip -s link show teql0. tx_dropped an=
d
> > tx_errors would stay at zero.
> >
> > The VLAN slave counts the same rc as a drop in vlan_dev_hard_start_xmit=
():
> >
> >     if (likely(ret =3D=3D NET_XMIT_SUCCESS || ret =3D=3D NET_XMIT_CN)) =
{
> >         ...
> >         u64_stats_inc(&stats->tx_packets);
> >         ...
> >     } else {
> >         this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
> >     }
> >
> > Could the rc be saved once? dev_xmit_complete(rc) would then decide onl=
y
> > whether the skb is still owned, which keeps the use-after-free fix. In
> > that case, tx_packets and tx_bytes would only grow for NETDEV_TX_OK and
> > NET_XMIT_CN. The other consumed codes would go to tx_dropped (or
> > tx_errors), without touching the skb.
> >
> > The commit message describes this only as a use-after-free fix. Could i=
t
> > also mention that teql0's counters behave differently now?
> >
> > >                                     __netif_tx_unlock(slave_txq);
> > >                                     raw_spin_lock_irqsave(&master->sl=
aves_lock, flags);
> > >                                     if (rcu_dereference_protected(mas=
ter->slaves,
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/QDISC-Y0BY.v1.r0.20261015184107%40mojatatu.com
