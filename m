Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20B470453
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058002; cv=pass; b=OwJDYBi5ELS6fYVDKY1tiVR9SzI6YLyQBVz+IE6pMIYoNNtBrs0uMKQkEbJ1TrsCvMrCoygTcLRdbmQtsAIgkg2xAxE2o+MaImCqdfNAnBsc6tqU1iFsa6YzFWbSS3wx83opOJmCBWZs1vgHeznfxk/3Sujh9EB3Rj+t7vcGR18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058002; c=relaxed/simple;
	bh=CTlWdCdWn0sdpo/QtnGGY51FR9pVY4JrG0dJ4EyaUA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2tukndDcxd0mIjFYI+AO2VD6ReJVwgj+cSHXv0V2o8Se8g1IWlMMQyFWBEX7hx/GWmhDzaH4yLWKwkKKkJcv95HTr+AGY4LEOocYXt8tWKZ6EW4yuhWo5VsfwXi40fsJDp/MzIDZVIvyaHKwzy6sTo9b4wX6CsRxCBwoiBS1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3RcnGLe; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3RcnGLe"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-930c0f9c1b1so255253685a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 06:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787057999; cv=none;
        d=google.com; s=arc-20260327;
        b=LOwkJhfjjc242u6abykPkEaIGD9Nebnq3ORcUc8ETAsLJSVniV3z8RHdF3ZIdxs1ak
         LKguwcT9XBOFgoKJ9zi/ghTHZO1CsvOgb7IoBx16BuAITFh4VlHDmSNwy55FyMODfM9B
         7h2IR90uJQzbFfPOv/rTq0apDwFLLyhMEJVUfJaL4azYxcA34b9WayjJHvp7mtxlNo3s
         CreAlQ0ygwHygiSsNGZwhN67Z2FClNMCfUBYJn8Fta3D5aBqVvtf9S9ru7mpyH5ZThjA
         kqlezxY7ndZ8WQ2/YFnQT1ZSwXo4/uWk0fTPBHk/VzRebOcqKMxJ56oYD19W5ezCk8W0
         R4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        fh=IUK8CXZyfEIfxh3a/Fiie2VJmoDUd2t2p1ZByVYK7+4=;
        b=chQ4vlXnJ9Pw5KBPInSCNjoWsyNyk1M/byKVIiKGRQcbhAiWjg1jcRqzjgH5/EFT5K
         Te2OYBAHdIAdSXcn5PVkrHPip3/6RWy/eK2UhdL8ZvNoOkJtF7uu3yoxrxxU30BCvYdL
         CvMP+9iIJfUeQO7jgekqtI9S9dW3+dnL/jqjDABUx4zS3ZEoG+oRlB5W8qK9hQN4XZ0p
         rkVUCakTy5jfxzpGz26iqoAQ5arbwZ3LU6eLmqX6SYw1JWEYgo0uVFmJUD6fJfA/bfNE
         TIuXIuD/Yxl0Ox0yMO0/3MxiGYyp4igWKf5pmuBlQvjuN/XRNMrAHQyGXjlA1TF8ED4U
         Efmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787057999; x=1787662799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        b=D3RcnGLeaTt9Q3kSIjGpAGGtU8/Q6TkAiwsAQqK+8lxxITB4mfvgTrNuH2A0D/5Cxr
         BctmRcqC9BWY17e8QoZxCFXAD0DWMruGiF43YN9dtzJUo6hewkDrSZzzHNOSAXnANali
         NKNletHEcZowP8SRj4l52Zd+NN3XCvvXxOTWpXttJrAYL146Fg9P3An3vH2Y4IPbF0RX
         rO78YqiPHQSdMSJR3zNPNS/z3vWvKWAOyG9ErVhaZNwX0C3N7aF2p4X6DEKiMYkZKZJC
         2lrjJnuJ6M96SIW3mwGanbGS3UJEyL1+uDv6BA820pTnhctBjNMQgJBkwiTtz7aiQN/I
         pWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057999; x=1787662799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMd+bnmydsOIHi3uaU9hdbvisNbeakjBwFW5PF7YVUc=;
        b=smCmAS5b8gZV44DVfCKGldc+aQwIejaMQUf1HNvT5MgwiMT9antoUJktINCtlDA09O
         culsL9lD/wAXjWkJxJPkQvnO7Oa5ltRQ1/81QDV4sPTV7zs9ZJ3wWyj16GydEV7G9B7F
         1sKKhxAc0ghvrGQQmkIQ33JWUQ8y0+/PSoyY/KN770BXD8v7pcrhIQE9+jujEiw0Rgdq
         shlou9W6TFjwIz5CLAvkdd/5GuEjxa3LvCeM7WjYJZUbg+SMpFECNkT1fN9Jua92GkK9
         RhHgNZ5xavL9HhjhumeBfiSCpR7aB4lGqgcyx2d5oPdP5s2kUJEasCcDnS9YrzLFsUu9
         dL/A==
X-Forwarded-Encrypted: i=1; AHgh+RrH57lyFncavEzAm70UDwdxqM+pbgYEZSVwglLBL30eaQ5BzaxZtV1BADCwBVWf+U9D9oimNX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx53FZL8z9HQZc2160iql5iQgqQA12pnSHj+tVLgA2rKQRWI+2v
	4RPDsRaFykptdvvKdcq/zrWvhoO4ByGhrakUgUjDXWUb/gkKZ6eiEVzvTwCFrrkq4+gmjeb8Ved
	MvhXFuT5EvASTvEMZO/LL0rEji3BnqM/EjbzpIf+z
X-Gm-Gg: AR+sD133kLipu56Cl5HVFK0h30K4DuKUCv+rPEnp+RU8JW3pJGrAi4g2YXM1BLkSMyM
	rQe9pZRMM4npzoscfvKoFvdyzsR8XvrMBYr+6anKTpDKLuXKfxwwNjHEudMAJG9erbZHK0wrUFA
	aOz5B+UNCSn3/cOLP30IPCvXl+fKVN/OF7MHff6JJ7Fz5jOl7aTbzQtPeentxiOmCngCMTYR3Xv
	E6p4dKVTmSAlomKNtutfcyIF2OYBkL6/VatAgpIZo5K/zyIwVRMUMwmkQ66zUd1EK6l4MKWTfax
	rmNYycQo0NSl6JAFIREgSSPRVawwG2zzSJ+pgxzol5KPuQyZD+PocJd4gUQMiZbQtHjwjrDiNlC
	JEUbKKaLuJQkmZxk8P8MGTpxltgW9AftIADkEpp556BjL2NPukNTEfpH5oufJLoVZ6XwUJY1IuW
	8//RarpDX5EDKo+2I=
X-Received: by 2002:a05:620a:3186:b0:915:9fba:8794 with SMTP id
 af79cd13be357-93704adcd2amr715177785a.6.1787057998665; Tue, 18 Aug 2026
 05:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101130.16203-1-jhs@mojatatu.com> <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
In-Reply-To: <CANn89iKGuPE0qEp-ucnWfvr+Vo_Ynv7zxuTDaxtTWr3d_YiYLA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Aug 2026 14:59:47 +0200
X-Gm-Features: AcwNN1VwsHCaP5nGD4dlBiEKOtnuzH8ayp4kATRtISfCWRsny2WTsEy-k6N2g3E
Message-ID: <CANn89i+edjh3JMZKTwG-gVtvMv_ya-wVUfK-yuKahRcoUoYDdQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 2:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 18, 2026 at 12:11=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > Several qdiscs derive their per-flow quantum or backlog from psched_mtu=
()
> > or accumulate qdisc_pkt_len() into a u32/int counter without an overflo=
w
> > or zero clamp, which can drive the dequeue/credit-refill loop into a so=
ft
> > lockup or a NULL deref.
> > vega@nebusec.ai provided reports and PoCs which illustrated the followi=
ng:
> >
> > - sch_fq: fq_dequeue() credit-refill loop with a small quantum spins ~1=
B
> >   iterations under the qdisc lock (soft lockup); fq_init() computes
> >   quantum =3D 2 * psched_mtu() with no overflow check.
> > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a u=
32
> >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a f=
ew
> >   packets wrap the counter to 0, and fq_codel_drop() then picks an empt=
y
> >   flow and derefs NULL.
> > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow ch=
eck;
> >   a huge MTU makes it 0x80000000, and hhf_dequeue()'s deficit +=3D weig=
ht *
> >   quantum loops forever.
> > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a huge =
MTU
> >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles bet=
ween
> >   INT_MIN and 0 forever.
> >
> > Clamp the quantum to a sane minimum and promote the backlog/credit sums=
 to
> > avoid the wrap, so the dequeue loops terminate and the drop path never
> > selects an empty flow.
> >
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c       |  9 ++++++---
> >  net/sched/sch_fq_codel.c | 14 +++++++++++++-
> >  net/sched/sch_hhf.c      | 12 +++++++++++
> >  net/sched/sch_sfq.c      |  7 +++++++
> >  4 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 7cae082a9847..66e9c6e530d8 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -750,7 +750,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sc=
h)
> >         f =3D head->first;
> >         retry =3D 0;
> >         if (f->credit <=3D 0) {
> > -               f->credit +=3D q->quantum;
> > +               if (f->credit + (int)q->quantum > 0)
> > +                       f->credit +=3D q->quantum;
> > +               else
> > +                       f->credit =3D q->quantum;
>
> Lets not add cost in FQ fast path just because of a configuration issue?
>
> >                 head->first =3D f->next;
> >                 fq_flow_add_tail(q, f, OLD_FLOW);
> >                 goto begin;
> > @@ -1226,8 +1229,8 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >
> >         sch->limit              =3D 10000;
> >         q->flow_plimit          =3D 100;
> > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > +       q->quantum              =3D max_t(u32, 2 * psched_mtu(qdisc_dev=
(sch)), 256);
> > +       q->initial_quantum      =3D max_t(u32, 10 * psched_mtu(qdisc_de=
v(sch)), 256);
>
> We instead can make sure quantum and initial_quantum are in an acceptable=
 range.
>
> [256, 16M] would probably make sense.

Actually, we use 1M in TCA_FQ_QUANTUM in fq_change()

We also need to change fq_change() because TCA_FQ_INITIAL_QUANTUM can be se=
t up
to INT_MAX.
