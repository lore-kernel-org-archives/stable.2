Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550143C108C
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153506; cv=pass; b=sifGb9dmXjr0ozVffYfd4cZYk2UwSBjkZw69ZX1AD0gZzt3kKG8YVHw+UjsVLcdqIZgxAwL5/eQhJ4N9UvdHIIxJyrC+f3Eot5jT72CSWR7EOXTyIF+656U/kAY0Oo7Qn4G10CrgDKRYSoaBuVymIUVhMcIP+dD7EaRVEAp8GPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153506; c=relaxed/simple;
	bh=7qTkxLZAaVYswa5fRWmyn/0TG6JBUySn4trfKwwFTEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COZBYVRJZ421f4dqBPLd4/+bJxyx/bACMhCOuOb8yrOG2nFFs87UFaCu8Xr8KTOjY3bmUgGBafUp7yiiGaDHJTtwDSzcUyCR07HVDubQ1c7z+yQn6lQ33SGlyBz71WTYnMG2t90/m3sG6f9XczrjO7k8SBax6ZDg6NqDJ0JAmJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fLNDhLOH; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fLNDhLOH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1278429b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787153505; cv=none;
        d=google.com; s=arc-20260327;
        b=ikKDdi/xm9G/LK4OheGazKf4XwYsvEAO8bHkks3yGzBaEIgkHsHku+CqlyzxTUKLQj
         yryxfGCjj8hP9PCt5mQjC6Ym77iR29afxDRAM8bVvIBF681gS6E338rj9B8c0TIwdamS
         LDaMk8CBnVKBpXTBDGTkZxrYbdNTqb5dSxBZRHirnyGdkjOX/Z5UruZ4mkykOjPyv5Ia
         Mu8yf+Drhq91x0oWVcJLE0ARoMUu+N8Skx61CfFxxuMFk1a1U+NXDD6HrasUf4bv4eaK
         sgoES6eJ7A7O4jekwEo9qKBLYkuWwI3digu4wgbXfZpBJwgNPDj987VlAh2Lk5nOXDT+
         vCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08wNOA68TAaoTV8eso++gFA6aDwbeSGwMVtZP2K86Zc=;
        fh=bFGJ7M0PDtwG/2b3Pku2ghUQSTrAtj8FwhTkisiFh1M=;
        b=D0oqjInzye3o/uSbrC+115G9xDIdt6WuAkZouYkgiqW8gOzCc2MoOxj2Pmow2OVRCL
         ZLKyEY4uSzpY7a81plkokcpFLe+Yjfo73GCbU4b22dWVY/ZpXDvgnluq6WZ6oONFzzpo
         u12Cu2B1Xhv/n462xM3paXQ4QNfYgsBbBdpElmGBKwkq6UvQrJj2YAJ2jDumitp3STSE
         5++rM0NW0p7jZCu+AHxRNMm0ZXIjD6nYjE45kSIOcnhdizK2XBQoX2ir3OT0pBJGEIcl
         V4e5Ip7Qks48HAjO/LoFOzoqw1pxu2gB7c610rkSBvMn+8fTuZz/HPBsQjO8pDqnnTPh
         i5Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787153505; x=1787758305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08wNOA68TAaoTV8eso++gFA6aDwbeSGwMVtZP2K86Zc=;
        b=fLNDhLOH1dPnwY141w34BTMT9GIEa7x/1UomsY96nI7ZHA6/DxotafHSGWFN/HzSkI
         xui2dTqdFgS0pAoOe5GWUMnM5MidHMI4Zf2QUs5Kh53dlonBU27R4XsmouUAdWjXxRhU
         PEmNlZRk64pRkMOpjZ0KJso8iXo2kQGul0zeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153505; x=1787758305;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08wNOA68TAaoTV8eso++gFA6aDwbeSGwMVtZP2K86Zc=;
        b=NjiBoA2qFRAyvyd5949QzN6GlUW2cclxwh5xkpD+MOeyTlgbFBYW0Qoykdhx7aG1vz
         MkXCSJ/062mD61omLMOFLwYY03aROA+BRlaQEcDdrvDWbn4DQsjdCZ3PEEWYL7auxVi2
         7gseH1q+ndlqcD+ueHcP+wPSWt4/3GeiSuBqYrDzRjH9050iV2WbCfnbUe0TXqOQAti1
         fB0guuPxqb6VfjhZeZkcyLtt4YRaJ4KCMQRWfli8YBY29rbzFbVvjfdF491M7VddmE3l
         w6E3xcXD4p561fvoWSP9osizgFf/uEdFNO0QhAXJ7lGA8KSU9F71wVxjFwds/S//7eEc
         wdKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpz8/aFyArsTTFGOyjbyQfMNV3qnsTH9rSRwgz8uwTX1ThIxm+Y1elQVquVisSB9pyVbkTqBK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiOk1Gsg68ZkqdKTX06HUXH/5/5kgIr79zRZy2NXps78f+95Ju
	4mwhQai7oK3Jc4nejrKLsx5bvVtzplooVPmKUErEUM2WGyvU0H6tYx0LbOjqhePoEfBvMBtR8TY
	nhQInqIbZrDzimnb71F0MMSmJKYZkkH/9UgzN0F9C
X-Gm-Gg: AR+sD13Oz0XI0/JiiwqYm8OPFlMM8FNAalBcAIPyuTpnu/naSzsRdvUvBHCzdOp+LtM
	306wWXGf2GYBGfRS+qa2He9vOTepmZ9XLfQgvAywfpnrnWIo60yycJNh2S4dgUiivjjCgnMM3YU
	1ddB0nkZHotjx9yOMoEC1r7xIyWDtLixWr2Id4n9viCea/jwnqwe5LzQ/VshPdBx2AiNShtrBSZ
	00iCMU7Ty337UESiBnN/lgLQ23UexpoVL9X2F1t8Afocy73+VOShL5qrkI2m+Ytw/qTP8mBNozu
	uwz2rQhJJe6YLnMmPyY9bR7V0VePv7xZmm9G8OwhSR7oKUw=
X-Received: by 2002:a05:6a00:a387:b0:84a:60a4:2651 with SMTP id
 d2e1a72fcca58-851d38498eamr9154939b3a.6.1787153504431; Wed, 19 Aug 2026
 08:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com> <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
In-Reply-To: <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 11:31:33 -0400
X-Gm-Features: AcwNN1V1mKrKnZScjYVnpUf1wGwXObVJ511wEezy6L6Rk2jGCX5s0dCRWidiULQ
Message-ID: <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 5:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 10:43=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > Several qdiscs derive their per-flow quantum or backlog from psched=
_mtu()
> > > > or accumulate qdisc_pkt_len() into a u32/int counter without an ove=
rflow
> > > > or zero clamp, which can drive the dequeue/credit-refill loop into =
a soft
> > > > lockup or a NULL deref.
> > > >
> > > > vega@nebusec.ai provided reports and PoCs which illustrated the fol=
lowing:
> > > >
> > > > - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no o=
verflow
> > > >   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
> > > >   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
> > > >   unbounded up to INT_MAX in fq_change().
> > > > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into=
 a u32
> > > >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so=
 a few
> > > >   packets wrap the counter to 0, and fq_codel_drop() then picks an =
empty
> > > >   flow and derefs NULL. fq_codel_init() also sets quantum =3D
> > > >   psched_mtu() with no clamp, so a huge MTU makes the deficit loop =
spin.
> > > > - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no c=
lamp and
> > > >   fq_pie_change() accepts any u32 quantum; same deficit-loop spin a=
s
> > > >   fq_codel on a huge-MTU dummy device.
> > > > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflo=
w check;
> > > >   a huge MTU makes weight * quantum overflow the signed deficit, an=
d
> > > >   hhf_dequeue() loops forever.
> > > > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a h=
uge MTU
> > > >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles=
 between
> > > >   INT_MIN and 0 forever.
> > > >
> > > > Clamp the quantum to a sane range at init/change time so the dequeu=
e loops
> > > > terminate and the drop path never selects an empty flow. The clamps=
 live in
> > > > the init/change paths, not the per-packet fast path, so no hot-path=
 cost is
> > > > added for a configuration issue.
> > > >
> > > > Conditions to recreate the bug: a device whose MTU (plus hard_heade=
r_len)
> > > > is large enough that 2 * psched_mtu() or psched_mtu() wraps into th=
e sign
> > > > bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU=
), or a
> > > > crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> > > > CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc =
and MTU.
> > > >
> > > > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > > > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet schedul=
er")
> > > > Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdis=
c")
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: vega@nebusec.ai
> > > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > > v1 to v2
> > > > Changes based on feedback from Eric and Sashikos[1][2] on V1.
> > > >
> > > > 1. Drop the fast-path changes in fq_dequeue() (Eric)
> > > >
> > > > 2. Clamp to a range, not just a lower bound (Eric). Uses
> > > >    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, no=
t 256).
> > > >    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t(=
) left
> > > >    bit 31 set, so a 0x80000000 quantum survived and still spun.
> > > >    Upper bound is 1M, not Eric's suggested 16M. fq_change() already=
 caps
> > > >    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsiste=
nt.
> > > >
> > > > 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was u=
nbounded
> > > >    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_Q=
UANTUM.
> > > >
> > > > 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-=
6-sol-1-6)
> > > >
> > > > 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini=
):
> > > >
> > > > 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-=
5-6-sol-2-14)
> > > >
> > > > [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojata=
tu.com
> > > > [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202608181011=
30.16203-1-jhs@mojatatu.com
> > > > ---
> > > >  net/sched/sch_fq.c       | 17 ++++++++++++-----
> > > >  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
> > > >  net/sched/sch_fq_pie.c   |  9 ++++++---
> > > >  net/sched/sch_hhf.c      | 12 ++++++++++++
> > > >  net/sched/sch_sfq.c      |  8 ++++++++
> > > >  5 files changed, 52 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > > index 7cae082a9847..f7c92df085e7 100644
> > > > --- a/net/sched/sch_fq.c
> > > > +++ b/net/sched/sch_fq.c
> > > > @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, stru=
ct nlattr *opt,
> > > >                 }
> > > >         }
> > > >
> > > > -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> > > > -               WRITE_ONCE(q->initial_quantum,
> > > > -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]))=
;
> > > > +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> > > > +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITI=
AL_QUANTUM]);
> > > > +
> > > > +               if (initial_quantum > 0 && initial_quantum <=3D (1 =
<< 20)) {
> > > > +                       WRITE_ONCE(q->initial_quantum, initial_quan=
tum);
> > > > +               } else {
> > > > +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial=
 quantum");
> > > > +                       err =3D -EINVAL;
> > > > +               }
> > > > +       }
> > > >
> > > >         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
> > > >                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n"=
,
> > > > @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct =
nlattr *opt,
> > > >
> > >
> > > You should probably split these into separate patches to ease code re=
view.
> > >
> >
> > I didnt follow - are you asking to split the sch_fq into two patches?
>
> No, you send a big patch:
>
>  net/sched/sch_fq.c       | 17 ++++++++++++-----
>  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
>  net/sched/sch_fq_pie.c   |  9 ++++++---
>  net/sched/sch_hhf.c      | 12 ++++++++++++
>  net/sched/sch_sfq.c      |  8 ++++++++
>  5 files changed, 52 insertions(+), 10 deletions(-)
>
> And today I had time to review the FQ part that we care about a lot ;)

Ok. So one patch per file?

cheers,
jamal
