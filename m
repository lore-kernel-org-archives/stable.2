Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794224662;
	b=nBQ7RvUOO+R9LC0T8cyDesS3w6V3tgTNpwOkvJiUUxXMJzsCe4pGkttzOhhNx14OlyFm
	 HfppSRiT2xhjHNsfjSAdANtEr9iLscIlP1U8NQdEwqfAZTSUOj48iF06rFGswq05m/nQp
	 TXtZ4WZQDo2wHwsREVthbaPmGhWeKcgRt3GHgkBq8EhSDtDIDlZbnYD36gmgWR/xy7Jpq
	 IZajeo8liKBrmdSr7Iw/E/vaUfaj+AyAE7GgX4D4qL/83nhB0SZozQA8jiByTYoQDyuJG
	 DbCuosgRU/SU2fZX70SAaQ/O5AB9PxDt1K/n3wFQK5gmBus/s+p10fqVNvyj+nhDPwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
	b=vYf2DIE57xnkWfQhANc50v5/cpLoBE6tToOvmxSM36pxA4czEWPbcS3pVlHg4TK4ao9L
	 ONKUgRk1yrDm90p5/eDj+o4ThI3cuBNpgwXitayg5JaYDGTVXJquXR8rfuDtRZONfZYru
	 0jjEYGQLgpbp2+wEF2KNFUEh9eqKpZ6sPZ2rRo+zs/OOzAR/inYos5QfX6RGLIV965Rmh
	 M/S5hkcyfyT+ufEJeNgLyJE92e/nQvCaz8xxLCV/EnkA2exTtYFfqxDmr9ouF7avkvulq
	 sMaab1zzp74Z7Km2qmIv5/L7Wa5iOkIu7EUend606ZxeUKwg6k30zaaDqK5E99SHr7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZQe0wgkh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459D606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 11:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E459D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ZQe0wgkh
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b31448caccso4376587b3.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 03:44:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794224661; cv=none;
        d=google.com; s=arc-20260327;
        b=LfPQH9BO6ShUmNoY3eXucIpsQDPy/HQqYRKw/PHF2AmJZj5rXPaDrTcvxvMik2W4U/
         zgpWH+KRelK0iVt5Wl7OU73Cyw0OtU8s9R4fri74pFHHtBgk5SSCNlH5fYdh2kKefSLg
         rlnWdNhwTx+q1a6XCXi+249ELrNYSmA9JVCPlyeXZFSRo48HS7yJRVX0PteYAcnFDq+J
         NSY0CPke0mAA1zzxiATF44VvYmHOwkX+bxlkHae5VkFJsweRJHwqGqhCOFvrvBNLfAbv
         byFhA3QD4YOgcK2hMG21DpUvX1rlrOIOVcoIJpaFKw8Ts7YxDKv9zHbXY6pYTel2+Kh9
         l2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        fh=BOOX+QEbcwWdXeFdSB+z8pAfl2sMi1AWhWzgvdSliag=;
        b=qbXDXiLLlUEewoVfnIGS++G+GcVXnvwM3A529YWr0lGTEsXWVZE97M6pSzczcQACbT
         ihRu7bEXqp/VQ/HpnGOf//LNtQ3S/5cxGtWcxeDRVqfQ5P54azyIaWhzPHENuRqFbBSs
         yDU87hPMLp/nmuk33CaIO+QkVqCgqtlukDnLBgO/Z8vYFHM1MFFVzJZsypSQjeEnTrVY
         A4jXRaI/7OSDDSpK1s0wKZw/vZZdbh0NDUgW+wXpF1HR5i7qhssocREeTX9OrcSlJq4F
         0BylfnE7mHQ0mQ9LbDcuSKmqsRH0MtiIaES6jP4Ex8ngipEGL7wyHqh+sHr2b6MeqVee
         lmbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794224661; x=1794829461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        b=ZQe0wgkh8TKbL38Yd857vJAYjnRpvdOqiSILvwF9KMhtnugEymoI3Pq2wBpyH3gY6w
         4ymdkZXFMAxEql/8BappkuDkki9YnXxESGCXp0UrSmvwDvEAZ3dyalYLR1JYy3uGEFOa
         B+x811mT/wl5RrnDencOUkObB42bB9GoyCAvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794224661; x=1794829461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tudkjez28RMXxzBWfLg4pArawZDNqT2bA2wVkoHQwkA=;
        b=SWAKlzL0KEWKIG9tAgnddKhd/0AlhlRjHjLfcYBrvTjW6c+4igA0WQVWkML6fxozkY
         BKgw0w4jgxy9jgOF9ug0PsLdfBIPw67zUv1T6Kc+SxRNpiLGFwm2UVtDtIOtxppXmnNm
         vVVr+/9A3RKG5pnDJGfb2Oaexjjn2UCibjJEUTlZmt5zyPzbSKD0Cs9Kbj7OJhuuIbWJ
         4TmwiLExJPSzCAbVBDx7wotrwqHSNk+ALiOVBUwYjtQex4WarkCkUPDXAOcQyDfslkVs
         moRN+XohK2l6t4T0rI3SY7CBMp0mS1/RRJWQBFUnIMnsYTgPhVL26HWWDhpQwjG85J4O
         +AqQ==
X-Forwarded-Encrypted: i=1; AL+hErHemO2aDVrVm7XMXPUdz7M10raZfZ7mexyhuG5DFhd2QnXqbE/hriZZGqMb711OTlA/OkligdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XayXJKSkUmvlEefjf9gE1+xWQGFcvizseglX53MauzYGpvqIu
	g8brRGMMKgzzHRZixxw+3dv89UZEN69O6Pnl/pRLmpJMi6LPyX59kbDjTOXEwAnIFlpmDK/MF5H
	i7fHPUeWf36rmUrSVY6XP4cAXuug/SL70qt/Z8L89
X-Gm-Gg: AYBFou3sn5Qfd0as7a+E+nALwy0gF5kcXK1x2KlNnN4Da3imfypJayFvy3Mm9DAEUOO
	eaHJCLWEK5SrbACdJrd6hW2jC94adCYCiRtL3hAJ+Oh+LDLOw+Y9Wd7y4EvJDQpll7MFM3sxirZ
	qKJb2L/eQ9uLslTk6RO4rzkzfsTK9Uj8ctUMUptcDmcXH/V4JqnaUiMyHapHaBKPU/xIcqFcWZr
	scchhFeSu16J739HA8cpl2pLeE+SqCFX8rSnhVhUGPrgjNZ3nugHzObD7bQgWX1lxNGvYWcFZiD
	oCPmQ4hrGEIWab4TmisrL/KqKKmcbp+Fb3Yc02V43f9J7tQQgqKXKkddemN2yNdvvUt9xyNb82P
	unsKsg/4+G3DHRpNXdnEzcez86DhbpjZl3CQM5AbNCwf3Gbsv3F/k1eTGyn0uwrmpy+1Zu2uIO/
	DFyuiB4NERArOBwLA=
X-Received: by 2002:a05:690e:191c:b0:67c:295d:5836 with SMTP id
 956f58d0204a3-67c3d96bfd4mr2294772d50.17.1794224660803; Mon, 09 Nov 2026
 03:44:20 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com> <179406458348.994134.6942745655171316289@kernel.org>
In-Reply-To: <179406458348.994134.6942745655171316289@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 9 Nov 2026 06:44:09 -0500
X-Gm-Features: AclHuK8mvVB_TGgtxN6qXQS6xYcYAMbCidFBmEaOpBy02Kh9E4kbueKy3al45cY
Message-ID: <CAM0EoMnprPstSvZEj+FKtK_kM6JB-jkrhYRwSd_mmN3WAMFQFQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] net/sched: sch_teql: keep skb->dev consistent
 on the arp-queue path
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:16=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new gate in neigh_update_process_arp_queue()
>   (net/core/neighbour.c), `if (!n1->dev->header_ops) skb->dev =3D=E2=80=
=A6
> - [Low] The comment added in neigh_update_process_arp_queue()
>   (net/core/neighbour.c), '/* headerless outputs (teql, shaper) transmit=
=E2=80=A6
>

I think i missed responding to this one. Sashiko-nipa responses are
very erratic. For some threads (not mine) a review shows up 2-3 days
later. For mine the average time seems to be 7 days and sometimes a vN
review appears a few days later after a vN+1.

Summary: I will not be spinning anything for this series since there
are no new code change requirements. I have addressed the
neigh_update_process_arp_queue() issue as a separate (producer) issue
in the past; it's a separate net-next focusing on producers. The
comment (Low) i would have rectified if there was something meaningful
to make me respin.

cheers,
jamal

> --
>
> net/sched: sch_teql: keep skb->dev consistent on the arp-queue path
>
> The commit sets skb->dev to the teql slave before teql_resolve(). This
> means an skb parked on the slave's arp_queue no longer points at a master
> that teql_exit() can free on module unload. It also changes
> neigh_update_process_arp_queue() to set skb->dev to the top-level
> neighbour's device when that device has no header_ops, so the skb goes
> back through teql_master_xmit().
>
> Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@moja=
tatu.com/
> Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel=
.org/
> Link: https://lore.kernel.org/netdev/20261031165925.780930-1-horms@kernel=
.org/
> Link: https://lore.kernel.org/netdev/179363700308.3131.117781795382902514=
34@kernel.org/
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..541cf699abae4 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless outputs (teql, shaper) transmit on skb->dev=
 */
>
> [Severity: Low]
> This isn't a bug, but the shaper driver is no longer in the tree. There
> is no entry for it in drivers/net/Makefile, and the older comment block
> just above also names it.
>
> Would it be clearer to name in-tree devices this gate is meant for, such
> as teql and eql?
>
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
> > +             READ_ONCE(n1->output)(n1, skb);
>
> [Severity: Medium]
> This gate is in generic neighbour code, and it doesn't check whether
> sch_teql parked the skb. n1 comes from the skb's retained dst via
> dst_neigh_lookup_skb().
>
> Can it fire for any skb parked on an arp_queue whose original route uses
> a device with NULL header_ops? Examples include ppp, geneve in L3 mode,
> vxlan when header_ops is NULL, rmnet, qmi_wwan, mhi_net, ipa, iosm,
> mhi_wwan_mbim, eql and teql.
>
> Two producers park skbs on another device's neighbour while keeping the
> original dst.
>
> The first is nft_fwd_neigh_eval(), which nft_fwd_validate() allows on
> NF_NETDEV_EGRESS:
>
>         ip_decrease_ttl(iph);
>         ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
>
> The second is bpf_redirect_neigh() with an explicit nexthop.
> __bpf_redirect_neigh_v4() replaces the dst only when nh =3D=3D NULL:
>
>         if (!nh) {
>         ...
>                 skb_dst_drop(skb);
>                 skb_dst_set(skb, &rt->dst);
>         }
>
> bpf_out_neigh_v4() then sets skb->dev to the target and calls
> neigh_output() with the old dst still attached.
>
> When the target device X's neighbour resolves, the drain takes this path
> (Y is the original route device):
>
> neigh_update_process_arp_queue()
>   dst_neigh_lookup_skb()  -> Y's neighbour (Y has no header_ops)
>   skb->dev =3D Y
>   neigh_direct_output()
>     dev_queue_xmit() on Y
>
> Does this run Y's egress hooks a second time? In __dev_queue_xmit(),
> nf_hook_egress() runs before nf_skip_egress(skb, true) is set, so the
> nft egress chain runs again. sch_handle_egress() and tc BPF also run
> again.
>
> For nft fwd, this would decrement TTL/hop_limit twice. A packet that
> reaches Y's egress with TTL 2 would then be dropped.
>
> Counters, quotas and limits would also be applied twice. A tc BPF program
> that encapsulates could encapsulate twice. If the second pass gives a
> different verdict, the packet would leave through Y and not through the
> device it was forwarded to.
>
> Before this patch these skbs went out X without a link header, which was
> also wrong. Running Y's egress hooks a second time is new, though.
>
> The commit message acknowledges this:
>
>   "Those forwards supply their own device and nexthop and do not consult
>   the retained dst, so dropping it at those two sites is where that is
>   fixed; that is a separate change to the producers, not part of this
>   series."
>
> The patch is tagged Cc: stable. Would stable trees get the new behaviour
> without the producer-side fix?
>
> Should the dst drop in nft_fwd_neigh_eval() and in the bpf_redirect_neigh=
()
> explicit nexthop path go in the same series as this change?
>
> >               if (n2)
> >                       neigh_release(n2);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-6HS9.v3.r0.20261103062649%40mojatatu.com
