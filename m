Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795088806;
	b=YWJuWDZZTx1tAJKaQExKRQsMCv0kZG6Z9PvtozGiWHWEHX9S2mSnGT/3k8yWaXifhKmQ
	 s0sn8tJdJky+XqWS6xcH/XGZtn9q0IuLX2YiMtAjm8Z6xYa8Dxa1QIKgWfCwSK7bCROAs
	 8x5YW36meqyPnrbWF6d20o/+3coqNcd+NKXPTQP39JT00jHcYv1Tlu781IaWBlFXWDWtx
	 qAbhRtwHhfentnZncv8ueCypAyyDMf9dlmpBhfMszvU7LKYTXutNJJZBmytxaHbTqaNKB
	 fz6z738lmPhYOrroBlJLaQ2JahctupkmLe9d4serTdNCwVKhm0HWQdw7niojWMRM05A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n3NKvZrmFHDvhIsjI4a9eQW4iq3tg5C0X/EydFEpmyI=;
	b=0ZDpn1+dC3gV+ftEWpaHKua7oEbGmQtHlG/mpctijjj862c0xAhtAjclUeqUEGL3zp4m
	 NiZbvFsSyGJzdeikkSjsYI2t8xnfUBozE5oWyOgm3N1u3u9Hqimc7QCch6BEZx99viQlW
	 XGpgKt9Z52DHnk2P8Gtm+y1unpMuWoGjnmGf75Q+I+Dcr/d3dulO0KxT9X6Mf4gpG9d4x
	 oWMNsduCY03LXECmig2NiYzV2N+c+zKb4ihTYQICR7m5ELPdwVZhlNXBStxutVzAhhpuM
	 Z0HlMgMGLzRpmXQwNJx0LVKXdbvOu9R0Ygpe0yvZWCjnX0mrda+5ZWbVF4u/bsAOYzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y2K722iD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C8B606A324
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 11:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15C8B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=y2K722iD
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1544484a12.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 03:46:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795088805; cv=none;
        d=google.com; s=arc-20260327;
        b=BciuJFzOPBBl/xuSntt+ozSrIDsXXuj72AN4KRWz3ao5/sJZbKO8yxGIW6fMDc3m/k
         7WwbFC5HM8Chb/HZco732CGg61OZjKWBrprl8k+Afn+s4q3sKCpssN5COBzcfB5zE7y4
         QdmCah+X+BIljOskVw6bMuWw2OvKBp4dkr3oGt/UL91LEz1e+EMxFuBiBC+IKGY9W5Wf
         6kw95QZUjIcfiEqzRibKK+QScTCsOlu7Gz4QYWTvRp/o7jS6ie+rTjv+DtjYBb75GboM
         AIGoyPbtwrBeTAUuDUqLeSfJizozTRpzoqTK6H4ro/rLp8gDsOfvsceSIb3dbgKzloGY
         PK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n3NKvZrmFHDvhIsjI4a9eQW4iq3tg5C0X/EydFEpmyI=;
        fh=EEHP8naVrdKWH44ytXix6phBIz62vQ8C8chKTTx1zUM=;
        b=Hy+hwVauoWOdD8Gr1YXNfRwhM3wQMzfc+YrUu7aQ4aPOTCoZwNhD9LGgAWA+msjkVW
         WUutKV9SlHiS4CUSlFX2C/9VVzkm3idu6xlO2grMLqiT2L/l+jezP2lpmcPd7NU7Wh0o
         QFM8Yq9Cga3qpmBBMQkKl2nbhJHxDXXRC3kXr2EHj8n1Q5rWjvcU1yBCT34Ji/FLlW+G
         5vQFYmGSC63/s72k3gJckMfBt0eCyjUbLxyk7At9Cn29lmMRRcmeNr+VB8d53JaQcRPO
         4u4eE4NYOF56EfHqHApPximg18W8Vm+0fDOIsDdJ6wFhzmHFqUNa7yFBQiW0nw0Gdivn
         4x0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795088805; x=1795693605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n3NKvZrmFHDvhIsjI4a9eQW4iq3tg5C0X/EydFEpmyI=;
        b=y2K722iD4TZBAt1+ApF9lkntXDYvDI2UdBkVLdYXYM09H1T1qQZ/L8lgwuVRvL9rfv
         Ly8h0bCiOCHN3KS2Xq1wAfQW0BTfciTxK9j/B5Yc1NMCQUcW4I8ZTipdGq78/tIV5J1S
         LjAq7LHU6F/o1kcfMbyzj0Idft+b7DyiZRRWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088805; x=1795693605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n3NKvZrmFHDvhIsjI4a9eQW4iq3tg5C0X/EydFEpmyI=;
        b=OGqTb62lHxLk3S3Ro5Ep7skEgh6Vwgn8BEwVhlwWhftrPBT4ksEDNTp7J+C6U1WKhf
         uH2W9c1V7XnvS0N0uYKZfv2oQG06m7ucpVKj9rJMQwN59BtJfFq1p6ukkL3IG7UNrEph
         kfWtzCgX4GxjezkVT8/xU5kvuqj6QmknEN60+bDVBI+j8phip+Ob/E5onQfRnK02arN3
         lLWS3j0ImWNL72MaN38g3Ag9fHjAfqdFlW6bPmnmZsxKyXdEEevG30iMGTgfJ/CFx7fd
         HGxl72p1EX2LfXqHKZiTiRuZfqEMcgYcmQupcVQeWQQyrmoHmbVl/a2+tB2bWMkzhcQf
         ZOAg==
X-Forwarded-Encrypted: i=1; AL+hErECNyaOscusXV0Iz4hIOgQ6NmCf66/gTMy4V3gGwNlFndjFeNl/jipuB7TIwKVZcNFhWPp/HM4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9snuYgGggzdtQHDNGiqFtLbF+wf9EviVHdSTk5Abur+SjHYREj
	adfTSJ4albrDm6sLZgCwAFEVIA4fGCvjbNi98roxmtDVVHHNvyfIpreCGVoGFl8o7kTBUxDXgQS
	bKpNuCTFwCWwAbHaiQ+fw+6Byfiw2mscnRvl/J3beh5ET3uZ+LXs=
X-Gm-Gg: AYBFou1NE7+B+Ln5aA9fx0KNxLl6gdF7ZZfIeUnrUsQi94dXIbxuGiR2I9utqdcKAR/
	7+en1uE6Qocvw8JXdrbE9pIkGJVVH1UwHlVB33vzwK9LjuVchRZFpP7qFWr4cu+K5N/kTl4f9+u
	zZA1TfbHoRisfslv0VivcPZvTFaxvIW2QGNci7cWR6qx75kir+b67x7ah6EbxMt/uw6hPd8tGyE
	uCqZGQmUS3l3bW+b1RoSNbirHeWMOhtJstv6hKbKB+3VYbZLFXHnzgFNXrEHCzfTU2J/klkig5N
	TO0ocoOn4dtxxbqif7nWo1AfEY6HD/UjTuhuRY1xDRdA7F6OKYET4ZpmHt1qHBztxdoM96vSeaT
	TkfGGu4Sr7aD84+PI+YmPMtg7eDQE2YxnTc79fa4s8JMtbDVweQ9+w4sToScWQquJ4KVp310mhh
	K+eN9g3QuC9GedIPE=
X-Received: by 2002:a05:6a21:a8d:b0:3eb:292d:6667 with SMTP id
 adf61e73a8af0-3fe8a70ccbamr6504022637.45.1795088805334; Thu, 19 Nov 2026
 03:46:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v5.r0.20261116052927-1@mojatatu.com> <179508471843.3136.7272721682226577890@kernel.org>
In-Reply-To: <179508471843.3136.7272721682226577890@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 19 Nov 2026 06:46:34 -0500
X-Gm-Features: AclHuK_PySmCHoLheqoX5I-yhkl7sxxQIvgxTN4EizCqKQ_gZio1vjuLcbHanCo
Message-ID: <CAM0EoMmHD-kxZZDyiV8ezTFzJ4D5ZSG16fimgyCq6Vq=wVcf+w@mail.gmail.com>
Subject: Re: [PATCH net v5 1/3] net/sched: sch_teql: unshare the header before
 writing and fix retry strip
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 5:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] This patch changes how teql_master_xmit()
>   (net/sched/sch_teql.c) retries when an skb has a dst attached and=E2=80=
=A6
>

yes, this is legit. I will send a v6.

pw-bot: cr

cheers,
jamal
> --
>
> net/sched: sch_teql: unshare the header before writing and fix retry stri=
p
>
> This patch calls skb_cow_head() in __teql_resolve() before the slave
> neighbour can write or queue the skb, so a cloned header is not
> corrupted. It also changes the retry path in teql_master_xmit(). The
> retry now pulls back only the bytes the current slave pushed, instead of
> pulling to the network header, so AF_PACKET frames without a dst keep
> their own link header.
>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v4.r=
0.20261111094338-1%40mojatatu.com
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
>
> > diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> > index dc21cd9704a25..626dc001ec231 100644
> > --- a/net/sched/sch_teql.c
> > +++ b/net/sched/sch_teql.c
>
> [ ... ]
>
> >       if (neigh_event_send(n, skb_res) =3D=3D 0) {
> > +             int off =3D skb_network_offset(skb);
> >               char haddr[MAX_ADDR_LEN];
> >
> >               neigh_ha_snapshot(haddr, n, dev);
> >               if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, fal=
se)),
> >                                   haddr, NULL, skb->len) < 0)
> >                       err =3D -EINVAL;
> > +             /* The bytes prepended above skb->data, pulled back on re=
try. */
> > +             *hlen =3D skb_network_offset(skb) - off;
> >       } else {
> >               err =3D (skb_res =3D=3D NULL) ? -EAGAIN : 1;
> >       }
>
> [ ... ]
>
> > @@ -408,8 +421,10 @@ static netdev_tx_t teql_master_xmit(struct sk_buff=
 *skb, struct net_device *dev)
> >                       nores =3D 1;
> >                       break;
> >               }
> > +             /* Pull back only the header this slave added. */
> > +             if (hlen > 0)
> > +                     __skb_pull(skb, hlen);
> >               skb->dev =3D dev;
> > -             __skb_pull(skb, skb_network_offset(skb));
> >       } while ((q =3D rcu_dereference(NEXT_SLAVE(q))) !=3D start);
>
> [Severity: Medium]
> What happens on retry when the skb has a dst and already carries
> link-layer bytes in front of its network header?
>
> The old retry reset skb->data to the network header. That matches what
> neigh_resolve_output() and neigh_connected_output() do before building
> a header:
>
> net/core/neighbour.c:neigh_resolve_output() {
>     ...
>                 do {
>                         __skb_pull(skb, skb_network_offset(skb));
>                         seq =3D read_seqbegin(&neigh->ha_lock);
>                         err =3D dev_hard_header(skb, dev, ntohs(skb->prot=
ocol),
>                                               neigh->ha, NULL, skb->len);
>     ...
> }
>
> __teql_resolve() pushes the slave header at skb->data without pulling
> to the network header first, and hlen only counts that push. So with
> the new retry, any L2 bytes already present when teql_master_xmit() was
> entered stay in place across every retry.
>
> One path that still delivers such an skb, even with the rest of the
> series applied, is nft fwd ... neigh on a netdev egress chain.
> nft_fwd_validate() allows NF_NETDEV_EGRESS, and nft_fwd_neigh_eval()
> neither pulls to the network header nor drops the dst:
>
> net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
>     ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>     ...
> }
>
> teql0 has no header_ops, so arp_constructor() installs
> neigh_direct_output() for it:
>
> nft_fwd_neigh_eval()
>   neigh_xmit()
>     neigh_direct_output()
>       dev_queue_xmit(teql0)
>         teql_master_xmit()
>           __teql_resolve()
>
> The skb arrives with eth0's header in front of the IP header (network
> offset 14) and eth0's route dst still attached. Because dst->dev !=3D
> slave, __teql_resolve() looks up the slave's neighbour. From there:
>
> If the slave neighbour is resolved, dev_hard_header() pushes 14 bytes
> and hlen =3D 14. If the trylock then fails or the slave returns
> NETDEV_TX_BUSY, the retry pulls only 14 bytes. The next slave sends
> slave header + eth0 header + IP, while the old code pulled 28 bytes
> and sent a single header.
>
> If the slave neighbour is unresolved (-EAGAIN, nores), hlen =3D 0 and
> nothing is pulled. The next slave in the same pass gets the double
> header, while the old code pulled the stale 14 bytes.
>
> At this commit alone there is a second trigger: an arp_queue skb
> drained back into teql0 after neigh_resolve_output() wrote an eth0
> header. Here skb->dev =3D slave is only set inside case 0, so the parked
> skb still has skb->dev pointing at teql0.
>
> That second trigger is closed later in the series. "net/sched: sch_teql:
> keep skb->dev consistent on the arp-queue path" sets skb->dev =3D slave
> before teql_resolve(). "net: neighbour: reinject a parked skb through a
> headerless output device" only reverts skb->dev to a headerless
> n1->dev, whose output is neigh_direct_output(), so no header is written
> in that case. The nft fwd path above is not affected by either change.
>
> The AF_PACKET case in the commit message only seems to need the
> dst =3D=3D NULL early return in teql_resolve(), where hlen is always 0.
> Would it work to keep pulling to the network header for skbs with a
> dst? Another option would be to pull to the network header in
> __teql_resolve() before dev_hard_header(), as neigh_resolve_output()
> does.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v5.r0.20261116052927%40mojatatu.com
