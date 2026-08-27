Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE4328B5E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872160; cv=pass; b=ueoPCyzA8v+7583E1GT11q8LfBt9NEtAzadVmt+zujmpOsW6/IDo9rfhnEd05+uiCXfiQlkgAsk6DMhygAmxS/bwBObBpuYQszRLwko37yuqB52rDGqcC6xmfWqfUjPPxfpvIMlpT2czxMIBVniwa1pFuwSXkkYHy2e+uAMvY3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872160; c=relaxed/simple;
	bh=/x5J5q4yjJYwyd+sa4fScN3EuJbPa6wJ/abKxVUCDsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9fiN08CiQGOrGbtxJbd8Qd+kufSNAK7dVqTuvPnDlOzt4+YnGiDRlZ3WA40D9rdbT2W5unSnixvXrmuLeXCSJXnGQZjYdI2W9HS+O8jn1Q+uzzudbce+YjGchvL7zDqfr2avE0jPcgMjGhQJjfgkQ0nPVkMTIaR+TCn6aDXLf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bnjTp/sg; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bnjTp/sg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso329303b3a.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787872158; cv=none;
        d=google.com; s=arc-20260327;
        b=QPZngMyyKH62/l2tAIxL4VJjtT/TX4hF3yJniJ6fRHmcP1Qfslct9VDZn6xYTXfDUC
         savJY66iWtGCCcskRfVL21ZL0xsGA9GBx2V38P3ZpQ6OPHfFPFHqryRNn2qy1Iipd0IU
         IUnMeHEXAXiw7IYMWf9D4R65KVxQ1WlxrunLbuxIetqTVOQIsDfPZTcCazOGaPoO4+8N
         yhGvrauTuUFgydgcsJELuhPn/RqiJOolwwHjAhY5doFR4qRIRh+JPUUTW804pm35chTv
         20CxgWS4x/BWKNwMXHjyTV2RGsSmZakTSrYOpdCC/RBk76vS+dWgfFm05aGY0EfMGfZq
         Q6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tod0y6MgEoGaSXNvm2KOHEnvF1ljfX4bUWCj/hc1m7s=;
        fh=iC2FIFox+y6+H0TKwBMp07GcebrjaDmSZguxYfx9NyQ=;
        b=dc0m8h1/Rgy8IEoWcnGxvRoNuQKpYb/9OK8k1xz1WMPu8vSQI5Lvs5A01ByudE2nGN
         Ut9f9PwUfaYeU9RMiqfl4kEvcbMbByDYhR+n2hZWBp+NcTnQmMsGcI7DN91Ujjz3/Syk
         HkODpOLFF0szT3BdbW6mKlEAoYLvIFKZBNPv33md+naGopBZmuMcTLqV+uGB4bq3uL2A
         PwI9mZ2vZ0JAi9IUYqCPAhTn9+ARB2otjLZc8e8Zfr+ded8Y5EkFbRlZgPCrjHkQaJQ4
         /61neXEDysPJ+VcBG0/avlHTcO0GNdCz9elCzKkoGJCpSuUEoQhafzowL3Qo22AMxGdd
         X4HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787872158; x=1788476958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tod0y6MgEoGaSXNvm2KOHEnvF1ljfX4bUWCj/hc1m7s=;
        b=bnjTp/sgYVpEAQfv77k+FLKOuQDLVWixdqXVbV59SUPaEN/JdKI6u5AFv64Qi9eDAA
         IU1MCWKF2x3Q4ujqGFogpaPXz0VFGVIloWOUSsefqNV6nYo2ZhIWZgzwiOiT/S5vtvaf
         aM8Od5F/R0+pt8knTEWmE6w0HnF8/bsV5iXC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872158; x=1788476958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tod0y6MgEoGaSXNvm2KOHEnvF1ljfX4bUWCj/hc1m7s=;
        b=eT2e/MCOL5m1tOrBnpbTumg1vf9sXf17smkSSJecVZSXBk4OhgXteziGJE4Pacr550
         HcymyxDLJ6u/qXB6KJKDoJ/vzFIqebus54NVYJRnye5h8JSPJYdUuhU4crqUA//02hoq
         RTB6fZEtxfnP/3VY8nUUpAlsoOfZfwprRMgbRVkQIt/MLH8ZvMHxJPvxSUZEAbisM79p
         yLJ7e62qTAO7apupYOwq+gblW/y0I88Hi35hx5ULM+hqg7ZVmKwyIFEfXKncQbYWN/oG
         NLYqu93gXJliH4TuBzv6PaRZ8y0wLFAPnBRz746axrB4L+cgsZ0n43Fq5AydVl0wXqsx
         W7pQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/EFBw0gFmvbRaeNfnMjbOKmhsoiBEbljZGBToMY5LPynNahopVoBEdFj1b/7d5shuz1x/s+E=@vger.kernel.org
X-Gm-Message-State: AFuF++kCQYtlmX/thmgA7BSwJR3fg5INGzn7qpWnoT9eZNgKF1o1T2/Z
	My4DO5Q/QhVsT+iif3HY91Rd6Ui3eaVTjDVBzS8Hi65RnRlOzy30Nu/a7+ZZ3F4T5FqKI13Rfx+
	lCo77L/thsluTtPL6/L3X3k4Uh2rhMo9B+YPYMumO
X-Gm-Gg: AR+sD13KGOEHivpE65lMXP8MyVFjd7xoQ0srh8eJsMyK22tBVjYQYBePYAXM2RrVDWX
	dZgrqjF74Rv/8zWN57E7mPw5UrkNiTBUXUCAfQmeoU+YsP23og2vCU3t1s1Ad7bus5hvUU4xGpo
	/GqKFbETB6ycGDsLO3uaXjihIWHDLAoGigJOoUnT7npjPGv3kyeOLFT8NC943n0V8biT7U05XRz
	N47mW7LgluWBCvO49+ibb8aFBMV+tdaq1aiDQxhwk+MEbv/EjKNqhKJDY5sigIyd7wH8hlmbxI0
	i0/TdPaBn4OhRq15l8KDBy6U/s3kzfcG81rvRyEglRy3Yse1JyRCzPJsSncBlss32+vrCxdiSuj
	woXtqyLZ9E4kfevHijXcj5cdorqIx
X-Received: by 2002:a05:6a00:2316:b0:848:48d0:934 with SMTP id
 d2e1a72fcca58-854c91098c7mr12010465b3a.18.1787872157457; Thu, 27 Aug 2026
 16:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826074056.7873-1-jhs@mojatatu.com> <20260827193424.4017151-1-kuba@kernel.org>
In-Reply-To: <20260827193424.4017151-1-kuba@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 27 Aug 2026 19:09:05 -0400
X-Gm-Features: AcwNN1VsZ0c0oAtDgseEyaPa-JTF9aPR6J2SQzPgoc6T-0JHeDvnjlJ7IKKiAWk
Message-ID: <CAM0EoMnWf3PkJdfxukW1ri+A-h5SD=XKgVxA=8ttGcrojUBD8A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: clamp quantum and psched_mtu in change
 paths and missed siblings
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, victor@mojatatu.com, 
	vtahiliani@nitk.edu.in, toke@redhat.com, chia-yu.chang@nokia-bell-labs.com, 
	subramanian.vijay@gmail.com, vega@nebusec.ai, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.


Thanks for forwarding - I hadnt looked yet. Some of the findings are
valid and expose patterns. I'll send a v2 with:

- ETS: move the 256 floor into ets_quantum_parse() so explicit quanta
are covered, not just the fallback path. Add upper bound (1<<20).
- DRR: add upper bound clamp_t(u32, quantum, 256, 1<<20) matching sfq.
- sch_fq: add 256 floor in fq_change() for TCA_FQ_QUANTUM and in
fq_init() for tiny-MTU devices.
- hhf: clamp hhf_init() to [256, 1<<20] matching the siblings.
- Add Fixes: dcc68b4d8084 for ETS.

The Medium finding (STAB size_log=3D30 =E2=86=92 2^31) is addressed by the
merged qdisc_pkt_len cap (8f735d64382d) =E2=80=94 together with the 256 flo=
or
they bound the loop; neither alone is sufficient.

The rest are opinionated, so i will ignore them. There is nothing to
followup for net-next..

cheers,
jamal

> ---
> net/sched: clamp quantum and psched_mtu in change paths and missed siblin=
gs
>
> This follow-Thanks for forwarding the Sashiko review. The findings are va=
lid and
expose same-pattern gaps. I'll send a v2 folding them in:

- ETS: move the 256 floor into ets_quantum_parse() so explicit quanta
  are covered, not just the fallback path. Add upper bound (1<<20).
- DRR: add upper bound clamp_t(u32, quantum, 256, 1<<20) matching sfq.
- sch_fq: add 256 floor in fq_change() for TCA_FQ_QUANTUM and in
  fq_init() for tiny-MTU devices.
- hhf: clamp hhf_init() to [256, 1<<20] matching the siblings.
- Add Fixes: dcc68b4d8084 for ETS.

The Medium finding (STAB size_log=3D30 =E2=86=92 2^31) is addressed by the
merged qdisc_pkt_len cap (8f735d64382d) =E2=80=94 together with the 256 flo=
or
they bound the loop; neither alone is sufficient.

cheers,
jamal
up to 709f34f7c28d adds a 256 byte floor to the quantum written
> by the change() paths of fq_pie, hhf, sfq and drr, floors the psched_mtu(=
)
> fallback in drr and ets, narrows the sch_fq TCA_FQ_INITIAL_QUANTUM policy
> range to 1<<20, and clamps psched_mtu() to [1, 1<<20] in sch_dualpi2 and
> sch_pie. The stated goal is to stop a small quantum combined with a
> STAB-inflated qdisc_pkt_len from spinning the deficit-refill loops under =
the
> qdisc lock.
>
> A few questions on the changelog first.
>
> >     8. sch_ets: ets_qdisc_change() falls back to psched_mtu() with no f=
loor
> >        for bands without an explicit quantum.  Add max(256U, ...) on th=
e
> >        fallback path (vega@nebusec.ai independent bug)
>
> [Severity: Low]
>
> The ETS item is described as fixing a real denial-of-service condition, b=
ut
> none of the seven Fixes: tags names an ETS commit. git blame on the
> psched_mtu() fallback in ets_qdisc_change() at the baseline points at
> dcc68b4d8084 ("net: sch_ets: Add a new Qdisc"), which is not in the tag
> list. Should the following be added so stable tooling can map the ETS par=
t?
>
>   Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
>
> >     1. fq_pie_change() accepts quantum=3D1 (NLA policy fq_pie_q_range.m=
in=3D1).
> >        Add max(256U, ...) matching fq_codel_change()
> >        (Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7)
> [ ... ]
> >     5. sch_dualpi2: dualpi2_calculate_c_protection() and get_memory_lim=
it()
> >        call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mt=
u()
> >        overflow in the signed multiply for c_protection_init, and 2 *
> >        psched_mtu() wraps in get_memory_limit(). Clamp to [1, 1<<20] at
> >        all three call sites. (Sashiko nipa main-6-4)
>
> [Severity: Low]
>
> This patch bundles eight independent fixes over seven qdiscs with seven
> Fixes: tags and Cc: stable, covering different bug classes: deficit-spin
> quantum floors, the signed multiply overflow in dualpi2 c_protection_init=
,
> the bytemode divide in pie_drop_early(), and a netlink policy narrowing.
> The tags span very different stable ranges (320d031ad6e4 for dualpi2 is
> recent, 13d2a1d2b032 for drr is from 2008). Can this be split so each bug
> can be backported or reverted on its own?
>
> The changelog also carries what look like internal review-tool
> identifiers - "Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7",
> "Sashiko nipa main-6-4", "Sashiko gemini", "Internal review noticing same
> pattern". Are those meant to stay in the upstream commit message?
>
> > diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> > index 91b1ef824afaf..0ffdab27bae42 100644
> > --- a/net/sched/sch_drr.c
> > +++ b/net/sched/sch_drr.c
> > @@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 cl=
assid, u32 parentid,
> >                       NL_SET_ERR_MSG(extack, "Specified DRR quantum can=
not be zero");
> >                       return -EINVAL;
> >               }
> > +             quantum =3D max(256U, quantum);
> >       } else
> > -             quantum =3D psched_mtu(qdisc_dev(sch));
> > +             quantum =3D max(256U, (u32)psched_mtu(qdisc_dev(sch)));
>
> [Severity: High]
>
> Only the low side is bounded here. drr_change_class() still accepts any
> non-zero u32, and cl->quantum and cl->deficit are both u32. What happens
> with a quantum near U32_MAX?
>
>   tc class add ... drr quantum 4294967293
>
> net/sched/sch_drr.c:drr_dequeue() {
>         ...
>         WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
>         list_move_tail(&cl->alist, &q->active);
>         ...
> }
>
> With quantum =3D 0xfffffffd that refill wraps modulo 2^32 and is the same=
 as
> deficit -=3D 3, so with a STAB-inflated qdisc_pkt_len of 0x40000000 the l=
oop
> needs roughly 3.6e8 passes before deficit wraps past zero, all with the
> qdisc root lock held. ets_qdisc_dequeue() uses the identical u32 arithmet=
ic
> and ets_quantum_parse() rejects only zero.
>
> Should drr and ets also reject quantum > 1<<20, the way sfq_change() now
> does in this same patch?
>
> > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > index 25fcf4079fece..f23c8dc68f8cb 100644
> > --- a/net/sched/sch_ets.c
> > +++ b/net/sched/sch_ets.c
> > @@ -636,7 +636,7 @@ static int ets_qdisc_change(struct Qdisc *sch, stru=
ct nlattr *opt,
> >        */
> >       for (i =3D nstrict; i < nbands; i++) {
> >               if (!quanta[i])
> > -                     quanta[i] =3D psched_mtu(qdisc_dev(sch));
> > +                     quanta[i] =3D max(256U, (u32)psched_mtu(qdisc_dev=
(sch)));
>
> [Severity: High]
>
> This assignment is guarded by !quanta[i], so it only applies to bands tha=
t
> carry no explicit quantum. Every explicit value still goes through
> ets_quantum_parse(), which rejects zero only:
>
> net/sched/sch_ets.c:ets_quantum_parse() {
>         *quantum =3D nla_get_u32(attr);
>         if (!*quantum) {
>                 NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
>                 return -EINVAL;
>         }
>         return 0;
> }
>
> So does the reproducer in the changelog still work for ETS?
>
>   tc qdisc add dev dummy0 root ets bands 2 quanta 1 1
>
> ets_class_change() has the same gap, it writes the parsed value straight
> through with WRITE_ONCE(cl->quantum, quantum), and then
> ets_qdisc_dequeue() refills one byte per pass:
>
> net/sched/sch_ets.c:ets_qdisc_dequeue() {
>         ...
>         cl->deficit +=3D READ_ONCE(cl->quantum);
>         list_move_tail(&cl->alist, &q->active);
>         ...
> }
>
> Would putting the floor in ets_quantum_parse() cover the explicit path as
> well? If so, test 41f5 in
> tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json expects
> "quanta 4294967294 1 1" to be accepted and dumped unchanged, so it would
> need updating.
>
> [Severity: Low]
>
> The comment just above this loop still says the fallback is the MTU:
>
>         /* If there are more bands than strict + quanta provided, the rem=
aining
>          * ones are ETS with quantum of MTU. Initialize the missing value=
s here.
>          */
>
> On a headerless or tiny-MTU device, which is the case this hunk exists fo=
r,
> the band now gets 256 rather than the MTU. Could the comment be updated t=
o
> say max(MTU, 256)?
>
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 6144b5686f13f..ab8e7c6ae2039 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> >  }
> >
> >  static const struct netlink_range_validation iq_range =3D {
> > -     .max =3D INT_MAX,
> > +     .max =3D 1 << 20,
> >  };
>
> [Severity: High]
>
> This narrows TCA_FQ_INITIAL_QUANTUM, which seeds the credit of a new flow=
.
> The refill amount in the dequeue loop comes from q->quantum instead, and
> fq_change() still accepts 1:
>
> net/sched/sch_fq.c:fq_change() {
>         ...
>         if (tb[TCA_FQ_QUANTUM]) {
>                 u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
>
>                 if (quantum > 0 && quantum <=3D (1 << 20)) {
>                         WRITE_ONCE(q->quantum, quantum);
>         ...
> }
>
> net/sched/sch_fq.c:fq_dequeue() {
>         ...
>         if (f->credit <=3D 0) {
>                 f->credit +=3D q->quantum;
>                 head->first =3D f->next;
>                 fq_flow_add_tail(q, f, OLD_FLOW);
>                 goto begin;
>         }
>         ...
> }
>
> The lead paragraph says "The change() paths with the same pattern, same
> writer of q->quantum, same privilege level ... were not clamped", and
> sch_fq is the qdisc of the primary Fixes: commit. With
>
>   tc qdisc replace dev dummy0 root fq quantum 1 stab data 32767 \
>     size_log 16 cell_log 0
>
> does fq_dequeue() still need ~2^31 passes of f->credit +=3D 1 after
> f->credit -=3D plen? Should sch_fq get the same 256 floor as its siblings=
?
>
> > diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> > index 96acab6a8da03..bb8e8952f5553 100644
> > --- a/net/sched/sch_hhf.c
> > +++ b/net/sched/sch_hhf.c
> > @@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nla=
ttr *opt,
> >               return err;
> >
> >       if (tb[TCA_HHF_QUANTUM])
> > -             new_quantum =3D nla_get_u32(tb[TCA_HHF_QUANTUM]);
> > +             new_quantum =3D max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]=
));
>
> [Severity: High]
>
> The floor is applied only when the attribute is present, so a small quant=
um
> coming from hhf_init() survives:
>
> net/sched/sch_hhf.c:hhf_init() {
>         ...
>         q->quantum =3D psched_mtu(qdisc_dev(sch));
>         ...
>         if ((int)q->quantum <=3D 0 ||
>             (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
>                 q->quantum =3D 256;
>         ...
> }
>
> Values in 1..255 pass untouched here, unlike sfq_init() and fq_pie_init()
> which use clamp_t(u32, psched_mtu(...), 256, 1 << 20). With
> ip link set dummy0 mtu 0 psched_mtu is 14, and on a veth with mtu 68 it i=
s
> 82.
>
> The changelog states "The init paths of fq_pie, sfq, and hhf delegate to
> their _change() when opt is present, so the floor covers tc qdisc add ...
> quantum 1 as well as change". Is that true for
> tc qdisc add dev dummy0 root hhf with no options, where hhf_change() is
> never called? And for tc qdisc change ... hhf non_hh_weight 1, where
> new_quantum defaults to the unfloored q->quantum and is re-committed by
> WRITE_ONCE(q->quantum, new_quantum)?
>
> With q->quantum =3D 14 and a STAB-inflated qdisc_pkt_len, does hhf_dequeu=
e()
> still need ~7.7e7 passes of bucket->deficit +=3D weight * q->quantum? Wou=
ld
> clamping in hhf_init() to [256, 1<<20] like the siblings be more robust?
> The member comment also still reads
>
>         u32                quantum;        /* psched_mtu(qdisc_dev(sch));=
 */
>
> which no longer describes either writer.
>
> > diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> > index 187d3ed578f26..8bbcfc9e85d94 100644
> > --- a/net/sched/sch_sfq.c
> > +++ b/net/sched/sch_sfq.c
> > @@ -660,6 +660,11 @@ static int sfq_change(struct Qdisc *sch, struct nl=
attr *opt,
> >               return -EINVAL;
> >       }
> >
> > +     if (ctl->quantum > 1 << 20) {
> > +             NL_SET_ERR_MSG_MOD(extack, "quantum too large");
> > +             return -EINVAL;
> > +     }
> > +
>
> [Severity: Low]
>
> With this reject in place, is the documented field contract still
> reachable?
>
> net/sched/sch_sfq.c:sfq_sched_data {
>         ...
>         unsigned int    quantum;        /* Allotment per round: MUST BE >=
=3D MTU */
>         ...
> }
>
> sfq_init() already caps the default with
> clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20), and after this
> change userspace can no longer raise quantum to the MTU on a device whose
> psched_mtu exceeds 1 MiB (dummy clears max_mtu and accepts an MTU of
> 2147483634, as noted in 709f34f7c28d). Could the comment be updated to
> state the enforced 256..1<<20 range?
>
> Also, tc_sfq_qopt configurations with quantum > 1 MiB that used to be
> accepted now return -EINVAL, while the peer attributes
> (TCA_FQ_PIE_QUANTUM, TCA_HHF_QUANTUM) clamp instead of rejecting. Was
> rejecting rather than clamping intended for sfq here?
>
> > @@ -688,7 +693,7 @@ static int sfq_change(struct Qdisc *sch, struct nla=
ttr *opt,
> >
> >       /* update and validate configuration */
> >       if (ctl->quantum)
> > -             quantum =3D ctl->quantum;
> > +             quantum =3D max(256U, ctl->quantum);
>
> [Severity: Medium]
>
> Does a constant floor bound the spin, or only divide it by a constant? Th=
e
> numerator stays user-controlled:
>
> net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
>         ...
>         pkt_len <<=3D stab->szopts.size_log;
> out:
>         if (unlikely(pkt_len < 1))
>                 pkt_len =3D 1;
>         ...
> }
>
> STAB_SIZE_LOG_MAX is 30 and qdisc_get_stab() only checks size_log and
> cell_log against it, so qdisc_pkt_len still reaches ~2^31. With quantum
> exactly at the new floor:
>
> net/sched/sch_sfq.c:sfq_dequeue() {
>         ...
>         if (slot->allot <=3D 0) {
>                 q->tail =3D slot;
>                 WRITE_ONCE(slot->allot, slot->allot + q->quantum);
>                 goto next_slot;
>         }
>         ...
> }
>
> that is still ~8.4e6 iterations per dequeued packet with the qdisc root
> lock held and BH disabled, and fq_pie_dequeue(), hhf_dequeue(),
> drr_dequeue() and ets_qdisc_dequeue() have the same shape. Would bounding
> the STAB-derived pkt_len, or rounding the deficit up to cover the packet =
in
> one step instead of looping, remove the class rather than attenuate it?
