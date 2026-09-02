Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0BA1C84BB
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307744; cv=pass; b=rJFw6d5axez7jZhh4BPoFm2uN0aP7qrqN1hO4m1kPRzbV9R31ecC2n4V9B3QLreXsAAmTEndLICCYCa8fMgBaCvueyPOQpEaF3mrKpL6WRgLY7jft5iugsH8fjmOAzmnZtXhAZUihuMh1uFG08NWblCvq8z8BjB1BY7TopU1Nd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307744; c=relaxed/simple;
	bh=uY7//sJtZ+PGgPIkLZj9Kz3z0P5hmZSPqQxFQwRLHIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTU8ThMv+9Yas9f2kUWkHS8/aNv4LQhT+NZPTK01NcQONuFtLA71M8GglYsKBq8hOwWcIFsyDFVAnA55U4Nm7oVTNhpq2liMbcZ5QpctDTFeoXza4a6w1z6FOceRIkBolZUiWM/BH6kPh6VWIgdjJaFnqpeP7St9YZtKJHnx/k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGF5gSWO; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGF5gSWO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0006ea8eso5416531cf.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 17:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788307738; cv=none;
        d=google.com; s=arc-20260327;
        b=fc1znlkJn9sOL9xSJLnLYpnL4LlPUlGcK0djtxQmMhCh84Q0XxxHz1twf5GK8TgLpC
         d1FDEW/cxQj9T8MLUMpEpjMpwYlUcxIru7m9lf2twm/r8Yczcwa1AOBwrYWTFY3fgoSH
         Pfh54M9VKsbjRwun4Y19w2t26tPXqkFDlPv3q6rFPbZbx6uOxOgX2oUUNqndoCChRzAh
         FlzWUGmpj4kHzRsYdxb7lUN6qS81fEbxcTEC6sojy10qWKOqM6qnih5Hd10UxFxk3btw
         t4N24ulWrm1TgCEvD4GVRx7jRAJh+/ZzLOT6jz6YSI3fXGRBiN72GvEvUWjl1aM6szio
         +HYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        fh=+HrFZkydhp3TMHrxTH+wLOPM2KvPzK5dNrmlIDQ20MM=;
        b=nA3P2OhSQH2JPyQK/trh0KZo8KgxrHU3UG1PIqfQJ0qyr/v/mxEDNS2yiyOKZih/yY
         UmdodnCMTCn/7Ioq9+r2gEdBa41bVNWCWW1CXI61h2RNY6b6jLFyIpNaDpS0OmKUOzTY
         El/qvbW2iSPI5cYUqKTb3zUuPZT1DQTMmhwi5qBWldRg5m4UUR4alrr9x9Knzq1hYgj8
         9nJYTA6bAuquH5OlKv60yuqmb0mPg6t1t8ClzJKHzYmLXe4ETy+2xzz/WYi0ZAyrxVnj
         sJYJGCYWBd9U5fBKQ8VDJ7bYgBvH7kWkrfNlYbGwmn6Z+lAgh/R6ZujK2aLXb2sKWUeq
         yrxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788307738; x=1788912538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        b=CGF5gSWO5UuoniwIMUrRaNvFuybTSTxOIlVLPRqSER0W4KnoZ3v1ddm6n8Hn+0fnq6
         DGDe6d21nnMqFZp8TbJFad9sSlrr1uy1v6egNWBBEPwZtAAF0Cy6Ha1FWxyRM8Nd2JZn
         A/431htUGCiFydda6h83OM5CKIz3Q2yJw9Gxut58YPK0JWVktwz05XJGJB22dZHNF/Sf
         DpykqTAwK0/B96xBSqKONsrKBQCCPhqF7NHVuM0C1Cyhe6KHAx9bRamfqQ6KYDsHlp9H
         RmC+Oq2iFRPnPND125Hoq4TYY36IrOCxPpEZN4WMtncfGX67WmK9TCApgU+id09hQGRn
         h82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788307738; x=1788912538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0INvQqOok/puWqJ7KAeQOiGwxZaQB+pUi3HoF1OBgBg=;
        b=UE/T0KeI25EkrTf5XEk9MhxqvUzbtCAAScTYst3OLQyyo4XO/FAKzQ+P/12PSSmIHZ
         +8C33wvULLZC3B7Fvvr0jaU4GS0nNpifvITTmhj9F9rdpB8uOTb9Y9PESy50yXP7yD4R
         i1MiE/YFFgjDatHahXqNpIifPG2zbNAC5tVUcRPAKcnbL6Z3sLc396vVchNROMrNZNUw
         Uo3S5YSE6gRqX5hQlwCMrtcaVDf4q0rMtBMe7TfDxBorIOJEkfvqCAanpXQ6kERSJQs2
         CTwFeYa4VmT9Dklt6It+u19uP4J5o+qcBb3zjVUOdTBfdM3jgncIEvRs+0oCQD6nIh7t
         PhtA==
X-Forwarded-Encrypted: i=1; AHgh+RoQKVMbX3s+YmTI55ljEGxiht/YxBxFDo8ds7hkDhTg2GE6zUyvd4sb4yoS34aIldYcvFMcmdk=@vger.kernel.org
X-Gm-Message-State: AFuF++loTyB9diOEOjiQZX1xG1eBMyje0rY/2ZrsY/03MsbfN2sZj+Bi
	lsdFey1QC20YJyP/XDPWYV4kBjdQwe8j1rtQ9C8ZKI4iXtXLcn1a7JQxmsIyI+F0IM1D+KC9Go1
	YuscAmYisI8TXqb8orbRdTSknAMNEcOcPCroGvsix
X-Gm-Gg: AR+sD12HP8WfJoIhv9RLnjrOM39YUmrKQesdJsnFW62ogYHr51K8dn4NrS99p8BfUnk
	4MqLL2UGQNik1g3BTGX+Oi4yEEDiibwqAH+x1X14EbHYAHNXo02ksW9iWTvJcfohHRU4dPDvTt1
	TDrjFjMcrqDH1K5X4e4egX/7ZXG28K2Y58xfEIhZKGRBHw8bc5NgWqmyYhnymK79khoPz2267B+
	Dl/fhLoPMmGik58+T+PHH+YUH1ThNfpNm56pMYy1evgNbdKOzsQteofCypys5J0tiFxYTLwzjo5
	Z7z2oF2R8jIqWr8dAcqts72Vi5lOfA/0WlLA5Yq0g54tEdtFmieGunMXxb1kXwjdDRbRpobUc8q
	DyDyvTsphhU+8mYEo5KyBbjLsKnepnVQjxBWpqI8GxOVpiFTcFbHiYDoNcg==
X-Received: by 2002:a05:622a:392:b0:530:18a:9358 with SMTP id
 d75a77b69052e-53036cc8da2mr9039681cf.26.1788307732357; Tue, 01 Sep 2026
 17:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
In-Reply-To: <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 02:08:40 +0200
X-Gm-Features: AcwNN1UUBe9iXZAqtGBWEmxc9KX33sNRlslLynVKaDAeXwN0HhCbP7KKBTpIbj4
Message-ID: <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:52=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> > TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
> > [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> > restoring the small-quantum deficit spin that the init clamp prevents.
> >
> > Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> > parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> > fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
> >
> > Conditions to recreate the bug:
> >   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> >   unshare -Urn suffices).
> >
> >   tc qdisc add dev dummy0 root fq
> >   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log=
 15 cell_log 0
> >
> > Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and=
 initial quantum")
> > Reported-by: Vega <vega@nebusec.ai>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c | 14 +++++---------
> >  1 file changed, 5 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 6144b5686f13..35f940b2205d 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> >  }
> >
> >  static const struct netlink_range_validation iq_range =3D {
> > -       .max =3D INT_MAX,
> > +       .max =3D 1 << 20,
> >  };
> >
> >  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> > @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct =
nlattr *opt,
> >                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
> >
> >         if (tb[TCA_FQ_QUANTUM]) {
> > -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> > +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUAN=
TUM]),
> > +                                    256, 1 << 20);
> >
> > -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> > -                       WRITE_ONCE(q->quantum, quantum);
> > -               } else {
> > -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
> > -                       err =3D -EINVAL;
> > -               }
> > +               WRITE_ONCE(q->quantum, quantum);
> >         }
> >
> >         if (tb[TCA_FQ_INITIAL_QUANTUM])
> > @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
> >         sch->limit              =3D 10000;
> >         q->flow_plimit          =3D 100;
> >         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20)=
;
> >         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> >         q->flow_max_rate        =3D ~0UL;
> > --
> > 2.43.0
> >
>
> If we consider dev->mtu admissible values, which are in [0, INT_MAX],
> we have to guard against u32 overflows
> for 2*mtu and 10*mtu expressions.
>
> Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
> and initial quantum") missed this?
>
> Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
> and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)

Wait, I missed the
mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);

Not clear why we have so many clamp_t(), this is quite confusing.

We could instead:

mtu =3D psched_mtu(qdisc_dev(sch));
q->quantum =3D clamp_t(u64, 2ULL * mtu, 256, 1ULL << 20);
q->initial_quantum =3D min_t(u64, 10ULL * mtu, 1ULL << 20);
