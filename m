Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972034D93C
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556767; cv=pass; b=n4KiRUrHNW64az2gg3rI23g7T8E2OkEbphypwjr6WvqpgmaE7SkoYbZA7mGTao0rKXoGwxbUlnZi3fvg9ou9B09XTtqW92SnaVTwpTd/i0JdycBtWYKFmdaDQE6vTN/MbHtjNbUKNna7rvtjTc7iR1ro5/wISCuPWojIlB7/Vos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556767; c=relaxed/simple;
	bh=zIRIJE2AGHcUOE1+Invane5EQjk28+ssl8PL6PvjdRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9QW73llfoK7G1JSHyXcfh0kTXqT3K7++Hcx5ufDF3Dtm6Zi88E/M/oyonZ6Se+D4FdJnE3a5a9drsJ7P9DXeLpEdB1FEGIg441l9KNCBgEqvFnS78nFpkm6exM8GRU0GA0K8jJGERxNf0CD0QBaQzOWwegOS+qqf6r4b1f5VQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DmzzUH5z; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DmzzUH5z"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-853c07a76adso1342481b3a.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 14:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788556765; cv=none;
        d=google.com; s=arc-20260327;
        b=shdzLmXlkgl1pyT3FRO4DdNeBCeATEj3lVDYULJrJfupTmVarn4Gz6ChXOp59s3SU6
         4k1J68EthmO/nb19p1spEOZE0FFmgcRdQ9zBeNvOCOK/t7KLRCafGVxt8fAavJ+sXmTg
         vjQ6pSmuL8KP5+Zp5NCNhbX+9UpD98oK8gwP/nKRkNkiudEnmdMZAOkuAwvdSyYe8ZDN
         5bBzg/4sY5G1Hyq/krJTShwEVG8gWM9YVAfu6+r65RB1xhxkmOTSMkY8HDtbl9+8HFvL
         LwNU+0fhaqslIHIb4w4VHVxLp65VHVaivufIylwyFSqWShKN32tRlWVhUdZyu0vhQCuh
         96/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLRCH+U/8BGHSBOTZJVb7cSifq3coNuuOCxdIL9/vPg=;
        fh=syKL4ljJC3ebyVkkfVI1AMMoyzIu0D3OyHQCWj0nFAU=;
        b=nKsLielp4aL5nVTi61yFaZsqmtqQxuvZQCdvNRQZUpTdWNaPJVqzRi38qRRLeWIt77
         o453iMxZQRn+5c6sKcjFcM9MwNlFkNPg48tZafqX3PzIak4X9/+dIsnAWYyjCuPKtSMD
         Oi2aiG3a/i7QegZFu2b/kJwuw7KR8mHrPsmEDJMHWJjT/iRrxlt7yDpSKBOWqzsPKXIE
         trMB9KYTh+nWi3yeRE8tF9X5gFLoZBdHBP9AQV87v7c+eE2lWU8mnINX2vNwGmuvJwVA
         KrnsVVTqX96Co7teg+vURkiUJuayIXt2LqOJOwlEmRu7t+o2RaXlmAQYKzl4uwi5XfC5
         od2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788556765; x=1789161565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLRCH+U/8BGHSBOTZJVb7cSifq3coNuuOCxdIL9/vPg=;
        b=DmzzUH5zwNjhorqQXC+g1EQccLiSTTwl786gFHxI8nSgngdj/EaDf0ynZp99JVQ7pH
         sOL68UXbfcTyxRyiDc6t1B3O/3KxPF5v7d3CZT5Qnxsl9Azlvh692p48NCqLRONmNHw+
         6h0ew6iMD9RgBb9uWxcGFK5WrNFsoVWTsMBys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556765; x=1789161565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLRCH+U/8BGHSBOTZJVb7cSifq3coNuuOCxdIL9/vPg=;
        b=rV3umN1LsAZxay0tZ6Eohp5G1gZ9MJtyNNLZycRjkDkPC68Ji8/fan6Eg2DBarPmTD
         i4heAJa2nMAZtm+8aI6kRk8LDnbssDJIdcCUTqEsLfCY+dOFU8iecwVtvDISl4rsXBTn
         JGPWjNXojZtTAv4bgB20f4cvqePrYYz+DFlP6OiWDJ1/qBeFKvKmjB3m56ThFIMkHOtg
         OYEJsPDtMI+iVZTFvg2KCgQ/nhRSv1voRDH5z4vffYRSo6YfJNNiEZBmDWKDIYyottWt
         JiHbIfxN6oCi91knZMmxMqWYSh5pOaUk0/R0fRtQHbNjcv6xkja3W74LsCNEniVPMOQf
         EXUA==
X-Forwarded-Encrypted: i=1; AKwUvBz8VSE0B+CuJQhD/AR5iTDnNdiAFetm+pfLI9mEY+dAEsIEL3sOnhFrnpYqG8Qs3dQE0B5aZvg=@vger.kernel.org
X-Gm-Message-State: AFuF++nUjMzQIX27ghZvtkAnnZUKA+ZZd1TD6/P9SGEeSyLs6bv45ft3
	AF3rBKCBhGJ/fJbUDLNSJKNSyOhDI8JL6pZU4Xm3Wt+K3Q5P9bdby6oHy613jqAd9ahURW+2IcE
	d7wo7oWbJylGteSH1Q5MIzFmrYt+QDYaPeCjhNP9NrqDXKPhi6zjt12K5
X-Gm-Gg: AYBFou2acFxyspHxy8HsM9lvJ/GsUUkAZmhYgsJjuxiwjhEAxscbw18sDiHAepgxbr8
	IaWrMYrk3loY4CK5AJ752YT7E+p+XzHsxEbVFxsx37TfS5KEQEcPSKVRE8SwtOY8Z0UYcGCy+M2
	qJnXJKCXPPXgFuPNMOJDz4k5ORUxx7EZIvUcO9GvU6eLha78IL/pj5Mmaq+vv8mezqTU1JTIyFd
	qA3Si4x27CzhKf+N+2blHNOXPA7Cj0lBqbsvlQPwo17HwK3knsgwNadW2xCp8PI6jrKC2/T2zry
	ggK/PxFrur7E4qUS58sChg6hyK5JL1Y66inou/guDh+PVv84g1oPqtPE5O/C3+hfEKGHWlk8w4I
	t6M2MSZVjJTHuBSTRIi4wfXc=
X-Received: by 2002:a05:6a00:3007:b0:846:4d4c:23f8 with SMTP id
 d2e1a72fcca58-861662d4c34mr12212323b3a.1.1788556764562; Fri, 04 Sep 2026
 14:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com.8> <178851496878.4131868.2069895170229482350@kernel.org>
In-Reply-To: <178851496878.4131868.2069895170229482350@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 4 Sep 2026 17:19:12 -0400
X-Gm-Features: AcwNN1X4rPq8Wr5crkVB_76iRnNWdS3etBNl9qA_K2l3cZKDPDzbSYA8CDd1o-E
Message-ID: <CAM0EoMke5h0wdNaTGQxTSALrFPPGNeMLad1p8arTakfPHa+NsA@mail.gmail.com>
Subject: Re: [PATCH net v3 7/9] net/sched: drr: clamp quantum in change class
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	victor@mojatatu.com, vega@nebusec.ai, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, toke@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 5:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [High] net/sched/sch_drr.c:85 and :87 (drr_change_class) silently
>   rewrite an administrator-supplied TCA_DRR_QUANTUM instead of honouring=
=E2=80=A6


Valid as a "description". My view is the patch is fine.
The rewrite-vs-reject choice is the series' deliberate uAPI - the
whole point is that a too-small quantum is crazy as illustrated by the
series so it  is never installed...
I am not sure if sashiko is looking at the net tree which has commit
8f735d64382d but qdisc_pkt_len cap which is clamp-style already, and
Eric accepted v3 on this basis.
The asymmetry is discoverable by re-read (dump echoes the stored value).
Summary: If the series is resent, we will state the rewrite behaviour
in the changelog.

> - [Medium] Commit message premise and reproduction recipe do not match
>   the tree the patch applies to, and an undeclared stable-backport=E2=80=
=A6
>

Very valid, if i understood correctly. I think you mean: backporting
on trees matching Fixes: 13d2a1d2b032 there is no QDISC_PKT_LEN_MAX
cap, so things will go crazy there...

I would say It's worth mentioning 8f735d64382d as a backport
prerequisite not sure if that's in the commit, although i am not
familiar enough with the backport rules to make that call.
+Cc stable@vger.kernel.org


cheers,
jamal

> net/sched: drr: clamp quantum in change class
>
> This adds a clamp_t(u32, quantum, 256, 1 << 20) in drr_change_class(),
> applied both to an explicitly supplied TCA_DRR_QUANTUM and to the
> psched_mtu() fallback, so that the deficit-refill loop in drr_dequeue()
> cannot iterate on a very small quantum.  The existing rejection of an
> explicit quantum of zero is kept.
>
> Two questions below, one about the changelog and one about the new
> clamping behaviour.
>
> > drr_change_class() rejects explicit quantum=3D=3D0 but falls back to
> > psched_mtu() with no floor. With a crafted size table qdisc_pkt_len
> > reaches ~2 GiB, so quantum=3D1 (or a zero psched_mtu on a headerless
> > device) makes the deficit-refill loop spin under the qdisc lock.
>
> [Severity: Medium]
>
> Is the "~2 GiB" figure still accurate for this tree?  The baseline
> already ends __qdisc_calculate_pkt_len() in net/sched/sch_api.c with:
>
>         /* A size table can inflate qdisc_pkt_len() beyond any real packe=
t
>          * (via overhead, the data table, or size_log); cap it so deficit
>          * schedulers such as DRR/ETS terminate their refill loops.
>          */
>         pkt_len =3D clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
>         qdisc_skb_cb(skb)->pkt_len =3D pkt_len;
>
> with QDISC_PKT_LEN_MAX defined as (1 << 20) in include/net/pkt_sched.h.
>
> Since drr_dequeue() advances the deficit by one quantum per round:
>
>         WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
>
> wouldn't the worst case with quantum=3D1 be around 1M rounds rather than
> ~2^31?  The loop bound seems tied to that packet-length cap, not to a
> 2 GiB length.
>
> Related to that, the recipe given:
>
> >   tc qdisc add dev dummy0 root drr
> >   tc class add dev dummy0 parent 1: classid 1:1 drr quantum 1
>
> installs no size table and sends no traffic, so it does not appear to
> exercise the refill loop at all.  Could the reproducer be extended to
> include the size table and a transmit step?
>
> There is also a backport angle.  With the new floor at 256 the effective
> iteration bound (~4096 rounds) comes from QDISC_PKT_LEN_MAX rather than
> from this change.  Trees matching "Fixes: 13d2a1d2b032" have no such cap,
> so this hunk on its own still allows roughly 8.4M refill iterations per
> dequeue there.  Should the QDISC_PKT_LEN_MAX commit be named as a
> backport prerequisite?
>
> > diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> > index 91b1ef824afaf..8621d057edd9f 100644
> > --- a/net/sched/sch_drr.c
> > +++ b/net/sched/sch_drr.c
> > @@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 cl=
assid, u32 parentid,
> >                       NL_SET_ERR_MSG(extack, "Specified DRR quantum can=
not be zero");
> >                       return -EINVAL;
> >               }
> > +             quantum =3D clamp_t(u32, quantum, 256, 1 << 20);
>
> [Severity: High]
>
> Should an out-of-range quantum be rewritten rather than rejected here?
> Only the exact value 0 returns -EINVAL; every other value now falls
> through this clamp and is committed, either via the existing-class path
> in drr_change_class():
>
>                 if (tb[TCA_DRR_QUANTUM])
>                         WRITE_ONCE(cl->quantum, quantum);
>
> or via cl->quantum =3D quantum on the create path.  Netlink then returns
> success for a configuration that was not applied.
>
> Does this create a set/get asymmetry?  drr_dump_class() reports the
> stored value:
>
>         if (nla_put_u32(skb, TCA_DRR_QUANTUM, READ_ONCE(cl->quantum)))
>
> so "tc class add ... drr quantum 1" succeeds and reads back 256.
>
> Does this also change service ratios silently?  drr_dequeue() refills by
> cl->quantum each round, so relative shares are the ratio of class
> quanta.  A 10:100 weighting would become 256:256, and 4 MiB:1 MiB would
> become 1 MiB:1 MiB, on any later "tc class change ... quantum <n>"
> against a class that worked before.
>
> The declared policy still advertises the whole u32 range:
>
>         [TCA_DRR_QUANTUM]       =3D { .type =3D NLA_U32 },
>
> The sibling implementation of the same bounded-quantum idea rejects
> instead of mutating, in net/sched/sch_qfq.c:
>
>         static const struct netlink_range_validation lmax_range =3D {
>                 .min =3D QFQ_MIN_LMAX,
>                 .max =3D QFQ_MAX_LMAX,
>         };
>
>         static const struct nla_policy qfq_policy[TCA_QFQ_MAX + 1] =3D {
>                 [TCA_QFQ_WEIGHT] =3D NLA_POLICY_RANGE(NLA_U32, 1, QFQ_MAX=
_WEIGHT),
>                 [TCA_QFQ_LMAX] =3D NLA_POLICY_FULL_RANGE(NLA_U32, &lmax_r=
ange),
>         };
>
> and the sfq patch in this same series rejects the identical upper bound
> in sfq_change():
>
>         if (ctl->quantum > 1 << 20) {
>                 NL_SET_ERR_MSG_MOD(extack, "quantum too large");
>                 return -EINVAL;
>         }
>
> Would a declared NLA_POLICY_FULL_RANGE (or an explicit -EINVAL plus
> extack) be preferable, which would also subsume the zero check?
>
> One more on the upper bound: a quantum larger than qdisc_pkt_len() cannot
> add refill rounds, so the 1 << 20 maximum does not seem related to the
> loop described in the changelog.  Is the narrowing of the accepted range
> intentional, and if so should it be spelled out in the commit message?
> The message currently reads:
>
> > Add clamp_t(u32, quantum, 256, 1<<20) after the zero reject and on the
> > fallback path. The explicit-zero reject is preserved.
>
> which reads as a hardening change with no behaviour change, and does not
> mention that previously accepted values are now altered.  That seems
> worth stating given the Fixes: tag implies a stable backport.
>
> >       } else
> > -             quantum =3D psched_mtu(qdisc_dev(sch));
> > +             quantum =3D clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)),=
 256, 1 << 20);
> >
> >       if (cl !=3D NULL) {
> >               if (tca[TCA_RATE]) {
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-0CFC.v3.20260901204856%40mojatatu.com
