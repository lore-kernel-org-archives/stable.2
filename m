Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A92313E36
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152745; cv=pass; b=rSHiW+j5bRwqFoSX2WkE17Pm0gx5r9ZJrFjNYj6R11kbV/Ah4je1KIJqrLC4eDXYw2a7MYoxDRcGr910I8eSQBVQ+JiQW3oeY84/uQO/UiP16FssTuD6InxpOkDs+NIhDHRp3x2A0UTZFToOGll3IISeivnd3pRzBEyze6PWzNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152745; c=relaxed/simple;
	bh=blVezLDhljCWNms4wfl8toeqxZquOtNbO8dPQ06Uf1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiWmUpVB5Gvg2zgWfNdyLow+kfv9YAhFz0pSOEtMhpVVrBI/RMo4snPrDR8wxZQEOuFUyRUy612tPLiDKJyOfQ2v3Z8UZcFv3tJSoae1kDocy/ooKAdV576P+GLjrcn/bPVmLuuxPWHEjZR6tbCD74yV4qGdV0GUpcIrDiD/3Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2BhBBfe; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2BhBBfe"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-934944f2d22so82267685a.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152742; cv=none;
        d=google.com; s=arc-20260327;
        b=q/hZ6mkxqoTLTPp8K1y5vff5iYv6DdRrdYyIKvqH/xzIk5sX4q9by3vSH0upVWEDGu
         05LggHxLsz9X8X5kM3A2gbE3YPvZrlu5Ea1ZkLVWqRs1lYixPmkfaXuPOfZrH4COchWH
         zJRLIHxmfO9g5iapCNPstH3HJyeS+UY+j/khCpoQHZfu5u3BZiQWN3VKiNI+Ja0SyKRw
         rVfm6MU+OGHo4FAZcYapxPVlHRtPttYjJV8J0Ha0w1dXfhyHhPN2JL2SHQwXD3IghgME
         ReD08Z1YXQMp4W+SnAEmy6oMuIu3wqdB+Ei8Qz40TQpLRP9tdmVeOYd+mZAzJ7YmJXcT
         6vsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        fh=3wJHMoZ8VbNkfAV7tvqLOCk/s6Uq0uRhQ9mJ8t74H9c=;
        b=jM1DQUXz8UmhOQywTOM3dapTI37CZaRpxx7QjfNxvsLPTyOeasG/tWQURcuiIxTLHp
         9+IoA4xudJ7lVEAxNVveUAKspHKD334rm1ErCW7hh+WKsqpxiIlbyIGJvXx0/GCKkBaK
         S+CYrnoOBPcwNQp3Z+B6vIqvXdczbdHXg2HnGSdKD5RuOQ3UdZbHhqcGNybTQhScXVCp
         FO+vCxG61geKiOgthAYhBIDLYJSwZHPQiRGD1l+C3RwF5yi0mdJ535f8Hpn8JKplwBN3
         f4cWX5DC2bHkoOmOiDl/O9LLbV4sbSVLT+AK1Wh2NwQgtNgYC9i/US511zAaR/42nFke
         T+og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787152742; x=1787757542; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        b=S2BhBBfenfnAGT3tMrAjMQsTCwv+cn5p8vqCiRVYaZ5jOD4D3BbZ/vH7uqTQ/MLIAb
         KTa4f9QV8wlxR9RtF6xFKM9CzzEOfF3sUB0IHrrhIBuCYOqshkQHUo5XfWCBpv0e+gYZ
         ObrNmzqzm2Sfv/+sdxZd/YsHXKLtcdMwSMYNTeRhDxo6ERLIq2r+7a40a3VpLlevjIwI
         LqecXVjrDmCI5EmaezfzXCgGSeNdEd2vURUfrzmNIrSS7ZK6mRnP3mPcYV6a/NtshRSe
         fGpMGaBk53LEHw+k3wcBGLVDvRgNbLabfgYf0vUUDZSz49GSd6B1e4m6Dz/MfAyRKJRG
         tmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152742; x=1787757542;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e1JG4TbQnJ1Xq2vyrMBNTrgR2MT7cry5/cYpveTwKgw=;
        b=AowNm3iiTcu5wDLNO+M1BHacSBPbm9nLSibebdFbRQmqWPBkxmPLni+tuumfl+0aVh
         WmDrlv5ZgvXTfv2IKlaReBaxPOJfKz3D9aYNMootxwcVoqXDy1CSYG+7p84apdjUjtRR
         Jq3FcFU/zhCFUeXnNw7PCYzBmsg8Naw4E5b1QbWA8GYO2lqK1tfsChzOrCx/UxoeBcc5
         RgQf9j904XblNCpRZDmYlFYnWSnoLtPFy4ErSz7iK8wM+zlMFG5EOXj8/WfOdGjd8QGP
         kvZZ+VC6t1sk+CFPgNCYAXCqHxCZzJF73nWhI4P8E51HvhMCr8NK9hlntTvie7Xfy54f
         Lzmw==
X-Forwarded-Encrypted: i=1; AHgh+RoScHI/716MRfDymQz4D/nFgbrUbgI889exgkWLcGGUjHKFwtVjRtTzs/0cIDRCnVlZxBoMUS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0y6XhVcYHOgBTGzKumnLGWmy3aPsozrI8M6hnA94o8CAe2t2
	ytqhue9WRYYDCPwyDDD75uV2zSqgP7aOtQF8m2y1oKt8jBzlkxLRfaoITFu5I/2/ng2okZ+yMAY
	6DqZbmPeQQSKKEayC3e8xbAFRTZrMAf84/iQiCvp9
X-Gm-Gg: AR+sD108blVuIU/YBNCDOnE4f3vVPGhKzp/Gw6yDFhsRark9TR7t4wrW/DEB1XDknpZ
	fqUWKR0bzo+U/WXapKNgVMAfuaMnlQkhnkPhfS9jnsi55GZ83A8DLoJFfLjT5b6K+dAcNKargOQ
	174dj2aA6WZOJn6MMXaclvDnHgId9MgQxUay6up/9QuhG5FzyI+liyp50aT8loh04IWcIR4p5pJ
	Rm19aLaaYYckH3Wkfwizi+xOMvwhljHq3owwINg01rqBUajUWE3mpGm3W9nM7nd73lx/LPy9PJj
	hhRq9FBYdpNgjjnMTWyT5jy/DWHZAh4BhVC0TxrmjVvrFOTY3ls04dhnqE2CqDlvpLMI50ZSDUF
	zZtJVLDPhHD6nJek2wqoFVQf0LEai0MqUtxF0P/TzdO8y+S6yILYtESdb5lyW4k6QRPG2yO2gms
	OCH4mMmfZdiwNkvVQ=
X-Received: by 2002:a05:620a:4728:b0:92e:59b0:df08 with SMTP id
 af79cd13be357-9371e20514amr485376685a.3.1787152741566; Wed, 19 Aug 2026
 08:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
In-Reply-To: <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 17:18:50 +0200
X-Gm-Features: AcwNN1X_gQ0jxbOVJSn2Ozs-cOZKCS2PtKqLSjl_wllIAfNV5SK2LsezXLUfmII
Message-ID: <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:03=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 10:43=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 4:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > Several qdiscs derive their per-flow quantum or backlog from psched_m=
tu()
> > > or accumulate qdisc_pkt_len() into a u32/int counter without an overf=
low
> > > or zero clamp, which can drive the dequeue/credit-refill loop into a =
soft
> > > lockup or a NULL deref.
> > >
> > > vega@nebusec.ai provided reports and PoCs which illustrated the follo=
wing:
> > >
> > > - sch_fq: fq_init() computes quantum =3D 2 * psched_mtu() with no ove=
rflow
> > >   check; a huge MTU wraps it into the sign bit, and fq_dequeue()'s
> > >   credit-refill loop spins forever. TCA_FQ_INITIAL_QUANTUM is also
> > >   unbounded up to INT_MAX in fq_change().
> > > - sch_fq_codel: fq_codel_enqueue() accumulates qdisc_pkt_len() into a=
 u32
> > >   per-flow backlog; a crafted TCA_STAB inflates pkt_len to 1 GiB so a=
 few
> > >   packets wrap the counter to 0, and fq_codel_drop() then picks an em=
pty
> > >   flow and derefs NULL. fq_codel_init() also sets quantum =3D
> > >   psched_mtu() with no clamp, so a huge MTU makes the deficit loop sp=
in.
> > > - sch_fq_pie: fq_pie_init() sets quantum =3D psched_mtu() with no cla=
mp and
> > >   fq_pie_change() accepts any u32 quantum; same deficit-loop spin as
> > >   fq_codel on a huge-MTU dummy device.
> > > - sch_hhf: hhf_init() sets quantum =3D psched_mtu() with no overflow =
check;
> > >   a huge MTU makes weight * quantum overflow the signed deficit, and
> > >   hhf_dequeue() loops forever.
> > > - sch_sfq: sfq_init() sets quantum =3D psched_mtu() (unsigned); a hug=
e MTU
> > >   makes allot =3D INT_MIN, and INT_MIN + INT_MIN is UB that toggles b=
etween
> > >   INT_MIN and 0 forever.
> > >
> > > Clamp the quantum to a sane range at init/change time so the dequeue =
loops
> > > terminate and the drop path never selects an empty flow. The clamps l=
ive in
> > > the init/change paths, not the per-packet fast path, so no hot-path c=
ost is
> > > added for a configuration issue.
> > >
> > > Conditions to recreate the bug: a device whose MTU (plus hard_header_=
len)
> > > is large enough that 2 * psched_mtu() or psched_mtu() wraps into the =
sign
> > > bit (e.g. a dummy device with max_mtu =3D=3D 0 accepting a huge MTU),=
 or a
> > > crafted TCA_STAB that inflates qdisc_pkt_len to ~1 GiB. Requires
> > > CAP_NET_ADMIN in a user namespace (Level 2) to configure the qdisc an=
d MTU.
> > >
> > > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > > Fixes: 4b549a2ef4be ("fq_codel: Fair Queue Codel AQM")
> > > Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler=
")
> > > Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc"=
)
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > > v1 to v2
> > > Changes based on feedback from Eric and Sashikos[1][2] on V1.
> > >
> > > 1. Drop the fast-path changes in fq_dequeue() (Eric)
> > >
> > > 2. Clamp to a range, not just a lower bound (Eric). Uses
> > >    clamp_t(u32, ..., 1, 1 << 20) (upper bound 1M; lower bound 1, not =
256).
> > >    Sashiko (gemini, nipa gpt-5-6-sol-1-5) pointed out the v1 max_t() =
left
> > >    bit 31 set, so a 0x80000000 quantum survived and still spun.
> > >    Upper bound is 1M, not Eric's suggested 16M. fq_change() already c=
aps
> > >    TCA_FQ_QUANTUM at 1M; using 16M in fq_init() would be inconsistent=
.
> > >
> > > 3. Clamp TCA_FQ_INITIAL_QUANTUM in fq_change() too (Eric). It was unb=
ounded
> > >    up to INT_MAX; v2 clamps it to > 0 && <=3D 1M, matching TCA_FQ_QUA=
NTUM.
> > >
> > > 4. Fold fq_codel_init() quantum clamp (Sashiko gemini + nipa gpt-5-6-=
sol-1-6)
> > >
> > > 5. Fold fq_pie_init()/fq_pie_change() quantum clamp (Sashiko gemini):
> > >
> > > 6. Reword the hhf/sfq comments (Sashiko nipa gpt-5-6-sol-2-15, gpt-5-=
6-sol-2-14)
> > >
> > > [1]https://sashiko.dev/#/patchset/20260818101130.16203-1-jhs@mojatatu=
.com
> > > [2]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130=
.16203-1-jhs@mojatatu.com
> > > ---
> > >  net/sched/sch_fq.c       | 17 ++++++++++++-----
> > >  net/sched/sch_fq_codel.c | 16 ++++++++++++++--
> > >  net/sched/sch_fq_pie.c   |  9 ++++++---
> > >  net/sched/sch_hhf.c      | 12 ++++++++++++
> > >  net/sched/sch_sfq.c      |  8 ++++++++
> > >  5 files changed, 52 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 7cae082a9847..f7c92df085e7 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -1112,9 +1112,16 @@ static int fq_change(struct Qdisc *sch, struct=
 nlattr *opt,
> > >                 }
> > >         }
> > >
> > > -       if (tb[TCA_FQ_INITIAL_QUANTUM])
> > > -               WRITE_ONCE(q->initial_quantum,
> > > -                          nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
> > > +       if (tb[TCA_FQ_INITIAL_QUANTUM]) {
> > > +               u32 initial_quantum =3D nla_get_u32(tb[TCA_FQ_INITIAL=
_QUANTUM]);
> > > +
> > > +               if (initial_quantum > 0 && initial_quantum <=3D (1 <<=
 20)) {
> > > +                       WRITE_ONCE(q->initial_quantum, initial_quantu=
m);
> > > +               } else {
> > > +                       NL_SET_ERR_MSG_MOD(extack, "invalid initial q=
uantum");
> > > +                       err =3D -EINVAL;
> > > +               }
> > > +       }
> > >
> > >         if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
> > >                 pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
> > > @@ -1226,8 +1233,8 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> > >
> >
> > You should probably split these into separate patches to ease code revi=
ew.
> >
>
> I didnt follow - are you asking to split the sch_fq into two patches?

No, you send a big patch:

 net/sched/sch_fq.c       | 17 ++++++++++++-----
 net/sched/sch_fq_codel.c | 16 ++++++++++++++--
 net/sched/sch_fq_pie.c   |  9 ++++++---
 net/sched/sch_hhf.c      | 12 ++++++++++++
 net/sched/sch_sfq.c      |  8 ++++++++
 5 files changed, 52 insertions(+), 10 deletions(-)

And today I had time to review the FQ part that we care about a lot ;)
