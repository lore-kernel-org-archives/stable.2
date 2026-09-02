Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5648BD46
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352815; cv=pass; b=jfFEiEm1B54W/+WFXCvfLtkPNZD4cnEMpaE/rafytJPpCKdQosUnqQIjj9ecyhw9+Qpj4D08XJFT/g+TwiUzcZER+SkFJ9UK2g8PB1X5JIAo6O7lCHMSDULLmmuW5BBsw3GQpdN6AHItvBZ3JpOd1cGOvSWT0Yxys1wx3xDnHCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352815; c=relaxed/simple;
	bh=1yrXK+KMTWtQDhDpfeqZ4eO3AXkph/2cmD38nAMwoU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdJxleddgC/iVJlxgr8xHwbkn6tx/gtqCzAycWQo0sZXTN/fktMTMPVnddtJuRz+naPvoI0CqIUggpC+xySH3KQtfp6CIFRzDzY+H19984hRI01EoagPMy3S67zN9w9Wk0YhqTABB5w7Jb0h9VvTuQS7+Z40iYj2yXq6/cKYxPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cs+0sVWu; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cs+0sVWu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so992165b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788352812; cv=none;
        d=google.com; s=arc-20260327;
        b=NIS+ZdVnXDoFAE84Poy/pTgBvO2owN8QzlUbof1TwOCIE71BjlBBtaJCXqqjk4odkX
         KjIdWnluzE/P+Vl69m1PU43FVjP5EyworsF4qQARXVnhA+Bs3ym0zQhJ6BIt+Gynnppy
         D9C1/1NsHKjKdv71FoH803vU0oQoreOo2bB/9n+6E2udDRAD7kdM72WGZlGslDmEtsOQ
         05S/BEgIxtzCPbR8x5jRMLrNfatIWEEogveIKJv8yRMJTHYpNFFvJh92KHEEmTyNkzZf
         rOgoZVxORpVKCU/D5zWDCKg5Gfcq0D9nc7TXba1aUwV5cTi0o+s5vDKaqmXYKO071X7H
         N0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        fh=Z7AvuPjKAlwT/mXUAzQzc0yxXaq4J4/BmZIrkAc1vso=;
        b=P2VAMxfbt8eZaSlDGWhyC7sH1RYVa7QmJVC/sjA2mAJ8dRLRCyQ9HlyBW2MzTmySb6
         8LukdhR1MA+jUxhRZNgjtQ9EQd+wTy66ErfJNgHn7nfUPnmFsy/ojEWUdaLFaJQCa7bc
         HQAZ48OCnhEhFRuIFS8XuEhGuxdxt8W2csq/U7PyWWwEeG6kPIUKugWVhwFF/FFPlZCf
         LF5MWen0VQZemKCLh8h1AEFBE+Wu9vevr6jJevM4G2sZXXCzU/brzJgykjNhWriokco5
         KiT/WNhVKM+FFmB//VhwDvg2z7XRjN5uL+1dOCUOiNtDUIGmTDuw6XTuQNpTdVXMViI9
         qNoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788352812; x=1788957612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        b=cs+0sVWuyCQ3AkqiJgAYqhaPN/UZkojc91n0XAOjF3cl0unyUTI6k5b7bB6DE4T4MJ
         3HyuNiTLzs1FE0U1u84Zea2X63I7zy2GnAM3h7PnHAMlprsnWZZf/zOZbSBte3agJIOL
         jIhsTH4Gvc+mETNNQ3Kny79uwYeWeM5vLQUmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352812; x=1788957612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Zx6veAObXdFzANUukTcCSazF8XGDEBs7YmzsK30HGo=;
        b=N88KGzWM3+Lylh1H5odZTsfYz6wnaG2fuzul1PKMq8PBrjmfNICftoSe6X6FLrF2nb
         Y8gB3+X1fEiCpUL4JBQLO9XMb9tylBlPY0FCRmxWrd0BcS+yFwWvOPyGOJOmL3pcXbsT
         d7fonbAFw5u7TM+SDeVapTTeQ9WQpfmUy2/1OSIhEvVW9UquUzZr/OXfLAg7zPnn7m1S
         lvF9aCapANpAcu/6lRdeUFEP/hfR5V292kchdHJeHDheCcKPzRoC6yeincD23v2pmwXd
         Q6rUz54S6dx8XoHUe68Nkjpc8lRpU+XEXvjlTAD8opbMWY80MY+hbssCFZomlSKXghLT
         fUAw==
X-Forwarded-Encrypted: i=1; AKwUvByrH+fwNXcI/u5F19EBYXl1/H5JAATUvryrW5G2eagzzCUEanjMYKemmoA6CNbX1ANywSwtAzk=@vger.kernel.org
X-Gm-Message-State: AFuF++k0g2WILHYX+UUOtckZl3DXWkGEKrxkUSgPUHXRZSro8KZAjK6E
	zBwsA0LipMkMj02Rj3EYEntjyc6v/PNr/oSWLMvzmnwxjLY2UkhdYt9T6tP/NxhXF8sA1/e0RSV
	Zy+pVdAHRt1wMydVDVcIJZGS1OKUKSdXViUci197r
X-Gm-Gg: AYBFou0rqHmC/+Q+Hs8MFa0C0EA86p9aA+p+bIqDGXq4FubcXEQ1NfUW0R+PmjKyuI3
	+4/P1P0jM6BKmh0eWXM73VZd5yoxi7nBI46xvgHT5zJYC9TXTsEJD1chYVTZneIEqT+koKIfn5Y
	aL80JnZghQRJTZ71rHOV35GBnhXVedcUaroTWsSB8/NiQ63O5BDWLq5jDx+UT3oxIb1iKMl4jwn
	cPjEKroByVqPnwjpHBUk8gXmw+a7dOLrA9E+KBzu9qk3vN4ECBTn4RHMn0OMhkmi1loqOI10vCf
	rsww0Hc6U/h5q6l7V+/DSNdN7+r0oRV3pF/VbV0Y0Oq0JfZCrupBFfdCxKQ/5KNhOszTPrDxULs
	DRRdFt9JsMrFoOIrnL+qGljIr9OwzaenDoSUlXg==
X-Received: by 2002:a05:6a00:2183:b0:857:727c:a1f5 with SMTP id
 d2e1a72fcca58-85ed4640011mr6311509b3a.23.1788352812452; Wed, 02 Sep 2026
 05:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-0CFC.v3.20260901204856@mojatatu.com> <QDISC-0CFC.v3.20260901204856@mojatatu.com.2>
 <CANn89iJCBTSGwKK02xw0XdZRsP=2VGmJny27cdi0bnpz4aBwHg@mail.gmail.com> <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
In-Reply-To: <CANn89iL+o5mdPOvRUy_vSiHxj3Kc9Wzr3HV_dGf2tsKJJNwniA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 2 Sep 2026 08:40:00 -0400
X-Gm-Features: AcwNN1VEEvRrI0fCJStQeTRB4HwPfEl6ZGPqrGO-f0KV6-7LSGTQUkw3B_YuXmk
Message-ID: <CAM0EoMnENJAY7pP9dP6pbbWnW44Ug-Ow3C=sf87pfOTwxjMdaQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/9] net/sched: fq: clamp quantum and
 initial_quantum in change path
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, Vega <vega@nebusec.ai>, 
	stable@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Vijay Subramanian <subramanian.vijay@gmail.com>, Petr Machata <petrm@nvidia.com>, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Wed, Sep 2, 2026 at 1:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Tue, Sep 1, 2026 at 11:39=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
> > > TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps =
to
> > > [1, 1<<20]. A user can override the init clamp via tc qdisc change,
> > > restoring the small-quantum deficit spin that the init clamp prevents=
.
> > >
> > > Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
> > > parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
> > > fq_init() quantum to [256, 1<<20] for tiny-MTU devices.
> > >
> > > Conditions to recreate the bug:
> > >   CONFIG_NET_SCH_FQ=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> > >   unshare -Urn suffices).
> > >
> > >   tc qdisc add dev dummy0 root fq
> > >   tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_l=
og 15 cell_log 0
> > >
> > > Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum a=
nd initial quantum")
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > >  net/sched/sch_fq.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > > index 6144b5686f13..35f940b2205d 100644
> > > --- a/net/sched/sch_fq.c
> > > +++ b/net/sched/sch_fq.c
> > > @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
> > >  }
> > >
> > >  static const struct netlink_range_validation iq_range =3D {
> > > -       .max =3D INT_MAX,
> > > +       .max =3D 1 << 20,
> > >  };
> > >
> > >  static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] =3D {
> > > @@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struc=
t nlattr *opt,
> > >                            nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
> > >
> > >         if (tb[TCA_FQ_QUANTUM]) {
> > > -               u32 quantum =3D nla_get_u32(tb[TCA_FQ_QUANTUM]);
> > > +               u32 quantum =3D clamp_t(u32, nla_get_u32(tb[TCA_FQ_QU=
ANTUM]),
> > > +                                    256, 1 << 20);
> > >
> > > -               if (quantum > 0 && quantum <=3D (1 << 20)) {
> > > -                       WRITE_ONCE(q->quantum, quantum);
> > > -               } else {
> > > -                       NL_SET_ERR_MSG_MOD(extack, "invalid quantum")=
;
> > > -                       err =3D -EINVAL;
> > > -               }
> > > +               WRITE_ONCE(q->quantum, quantum);
> > >         }
> > >
> > >         if (tb[TCA_FQ_INITIAL_QUANTUM])
> > > @@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> > >         sch->limit              =3D 10000;
> > >         q->flow_plimit          =3D 100;
> > >         mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > > -       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > > +       q->quantum              =3D clamp_t(u32, 2 * mtu, 256, 1 << 2=
0);
> > >         q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> > >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> > >         q->flow_max_rate        =3D ~0UL;
> > > --
> > > 2.43.0
> > >
> >
> > If we consider dev->mtu admissible values, which are in [0, INT_MAX],
> > we have to guard against u32 overflows
> > for 2*mtu and 10*mtu expressions.
> >
> > Commit 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum
> > and initial quantum") missed this?
> >
> > Please use for q->quantum:  clamp_t(u64, 2ULL * mtu, 1ULL << 20)
> > and for q->initial_quantum: clamp_t(u64, 10ULL * mtu, 1ULL << 20)
>
> Wait, I missed the
> mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
>
> Not clear why we have so many clamp_t(), this is quite confusing.
>
> We could instead:
>
> mtu =3D psched_mtu(qdisc_dev(sch));
> q->quantum =3D clamp_t(u64, 2ULL * mtu, 256, 1ULL << 20);
> q->initial_quantum =3D min_t(u64, 10ULL * mtu, 1ULL << 20);

Trying to understand your concern: Are you arguing for
stylistic/readability improvement or robustness?
The only place i can see where the multiplies you describe could
happen is what the 709f34f7c28d patch closed. i.e this part:

-       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
-       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));

IIRC, you are suggesting restoring the original logic (x2 and x10) and
i am likely missing why that is a must do? Does it break anything?

cheers,
jamal
