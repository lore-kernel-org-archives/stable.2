Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2D384CEE
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788306746; cv=pass; b=rMYznDthr+qCh1albiVNV4ZmOzegPgcXli/tM9ivUT3Rd5dGWm/h7Ls3DZ/2jApltgfzq8rddnkA4cZ6DUcIwL3TZGNmbiVQb61y+mpnnsFL3JI0zh/8OPhSe9AwS297n7qSabf90/i6YZz99UmWQbPGoQ+Exmeq2FhfdPw+vb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788306746; c=relaxed/simple;
	bh=iivTn96FfbbEjJViX0Fkcm09I9MH/O28qfnyMTTliJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5WQEiytSxDjLTHHde/FrBVyHU/Ihet/+a5g7YSZJrmIMJ/XfJeXQzS8wPBtTS/7J5W5kNGSJeIsEm2bLEVReVBMuuE1RoSQ1x9LnlFuQ8wm0aQMHZ3FKEUb47pvKsdA9pbB3cZzYcM4asQ6LhGJKAsK3YpJCtZ9MR+6+bIhMd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n50fftXl; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n50fftXl"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-52f9e79ed93so4107861cf.1
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 16:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788306744; cv=none;
        d=google.com; s=arc-20260327;
        b=GnQuQgMzFn6Rqcry3Mi07dKDI/CRrhYKHCFweorQ9ano3Y8Rjd7qhoVzFc4NYsMCt1
         D+DWXahYiyc/NX6MQoJkyWLmix+IaXpErpjP5lPVe250DVSdt7ZE7SbInV3nVqVElubT
         sCfdCnkL8utgDBcUmzlQMx2+06M3EepkzgMsK/y8tS+GqgRfpR6xrwXw7UGz8Dh1RCTB
         l9FqS1mXwholUc4mr5hAWmgcEyZzSxbbVnFPkfDWYUtJbl9pH0frsYTMeX/jnA1rEqoI
         suTxbbu3JOc0XfQlEn+cEWvVxBmZkT+9N0YRxMNkG4oeRzGrjskS0KDd5ni1QMhLO3vl
         2XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        fh=RIzs91FcV9J8gKxCjolZUBrKp2kMVbc2L4c92arXiEQ=;
        b=Ji3AEO6At8Ay4kLdQQPGGHUZpv/djZGUqmpJGWUW3qtAAE8kvuQpdLj/4bfZ9pxEl7
         BQ07KO44iGiLJU5vfwbj0Bg804nIJeGvZgT7a/+wcHlyPUU6Qe3VSc9O91lx32RuxpGe
         4lxyr3RN2nwGWbJWd71bWEanm/Fmf1Vh746dWwoQsZlJGc+nXkBr9dwtYtcOrS0bziXc
         Ao0yyQutnVt6e1l1xFmW1BieTXw0Bs4ZUVViy4HB4qZZlW7X6BklfQyo43AVax4yekZ0
         Zg2MNwJLSFYixrTcrgoOYLKor8MjArfNm7FFvkA65+FiiZX5etq60MzRE7YHW9woFOg3
         QixA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788306744; x=1788911544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        b=n50fftXlgSjrKPpXQ96AEiE7vDlJ5HjQjwWDdUrTb6KOV1AXxkM/CdNZTDX3xHWJfh
         oPrUw+oWA8bT7lfIRV87suaERqya7qKxVDp6mE/1tCbx2fVIInq40IJQ3HZWguhmC5/5
         O3MGZQzXv2BONjARRhXipzdaVvRuTiQfyvwBTuZ+8cGmUIPcfgrFq3x2Th8bB0qSbDzW
         rgiPtwA5CT2ixCknmhx2ogpkdQtEgXaw3UVlGPhNbWwZRoGsd1C4WimIiLTUGYZW/2k6
         S94QAP/C8JnP4Lpm67yIOt/iQywgq8Kxz42j3xAmkhYfb9MJXgM7Oa844GOvUsQtenbX
         GVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788306744; x=1788911544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAmf+84NQ+fiRf4U7rYOBYJBpTtMh7vDbPwWgr4LIuQ=;
        b=We6FuTamsDxoLY6zf34iJXhpX69b68kvcUiG2PSOQwTPXEioWQ7Xq2LulV07k5Z3OR
         G2EclBlcM2Gg8ML4wPwHaGX+xXzeKbNF8hejYIwQ6uflKDPH9El0A8MzyHvYF2WIPqF9
         FvHNYMKDdVCV1iUtLpeDzLi+1z6AuQm7z+ycNF0qOmPEfmGA+fkkG1eTtm7VFaDO83YU
         1S2RU4yYY0usHvEu8RiWEI9Q33qRqXsFkzDz2tG6X8T1DcSa2IkGx6snotHrRoMjXDYD
         7KzRmPwqcVF7TzLQrTAZMkX1J8hwt3o2Jfq+wntN4UG9fPhYtx6dMRrLPrQ1tSqK+Ywz
         tk/w==
X-Forwarded-Encrypted: i=1; AHgh+Rrt5RLjrLyhBs1jv4py270crX5nR+8fYlGfQrf4ddt36VoKR0js8+jMt0zqkxKN6M2qn6Ix2sM=@vger.kernel.org
X-Gm-Message-State: AFuF++mN/TjaL5UFJUbp/IgwDXJ7yy38HAtivwpcVaPZo5j8ZjRjq6m/
	s1iFu5cp5L1AA8n13f2aGq/lUmMWn3eYJJf7+pPmOA3siFMkgrSO7srwpx/iCtoqR2Xj9U9i900
	5XpRiiMvIpVlbCkAPewCywdLpsDLjqleGXKmoHNU4
X-Gm-Gg: AR+sD11gqWx/YUBWPkXm4PSfw9kS7mp0Z/gPuF8ZppHvGi/a1npCsFIYq8sjlXKDtSj
	COLCF6YjjpG9sI1tVsxVzo9icfP3n1HhABRsmMHZ2gsymIOlEqEc8HTIV2NDXfAndGrLnM6bn03
	fTbFZ4DzXY2d8mJJHPfNbVN24RxYVY6woz4d3ao0/x9heHj43osGhFz2pVJouVkzTHHJjrLqoXh
	5RoGsPZZ8gv6lBLjK4W5pSveq1jSqLPwGCL287yJlzs23yZq8u/W1l4jIgu2eo7H7DCLYZmSUtj
	f6DGyiA2ckskb3ylB6c8qMzhDXIM5j3ibax6Z5J36iO4kXXqAFwJbW384i4xTDSDT2jD+WwA8kz
	XSzG695loFlx5LmOz4zfSZcalVBehOzsGf0ef/NoYH7HhNk8rdo+D5qzxtQ==
X-Received: by 2002:a05:622a:2443:b0:530:3542:c8ad with SMTP id
 d75a77b69052e-53036d271e0mr9187581cf.36.1788306743315; Tue, 01 Sep 2026
 16:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
In-Reply-To: <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 01:52:11 +0200
X-Gm-Features: AcwNN1VpocPgjLbdeztjV8K8wARcLU0eMSx0w00rUl7qFiBL4oi3faAyjqbm9UU
Message-ID: <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com>
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

On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
> [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> restoring the small-quantum deficit spin that the init clamp prevents.
>
> Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
>
> Conditions to recreate the bug:
>   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
>   unshare -Urn suffices).
>
>   tc qdisc add dev dummy0 root fq
>   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log 1=
5 cell_log 0
>
> Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and i=
nitial quantum")
> Reported-by: Vega <vega@nebusec.ai>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 6144b5686f13..35f940b2205d 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
>  }
>
>  static const struct netlink_range_validation iq_range =3D {
> -       .max =3D INT_MAX,
> +       .max =3D 1 << 20,
>  };
>
>  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct nl=
attr *opt,
>                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
>
>         if (tb[TCA_FQ_QUANTUM]) {
> -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUANTU=
M]),
> +                                    256, 1 << 20);
>
> -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> -                       WRITE_ONCE(q->quantum, quantum);
> -               } else {
> -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
> -                       err =3D -EINVAL;
> -               }
> +               WRITE_ONCE(q->quantum, quantum);
>         }
>
>         if (tb[TCA_FQ_INITIAL_QUANTUM])
> @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr=
 *opt,
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
>         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 20);
>         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>         q->flow_refill_delay    =3D msecs_to_jiffies(40);
>         q->flow_max_rate        =3D ~0UL;
> --
> 2.43.0
>

If we consider dev->mtu admissible values, which are in [0, INT_MAX],
we have to guard against u32 overflows
for 2*mtu and 10*mtu expressions.

Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
and initial quantum") missed this?

Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)
