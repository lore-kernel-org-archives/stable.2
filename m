Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3E353A61
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295668; cv=pass; b=QCX+mqJdW5Z0mZayT6k/8ENiJQ7X+ylUWIGPtf8s/V4rvNuviVbYhzNphh/Jz5wTk79Bw41HtVx8j12lQzYMl0ZjK9N7lEec7LrxoypsYnyuNu/xCDXXAhkEPFGWFmYUkGH65mXXPcTZ5lHab1y5Siu4g/ju3nglzuCHqHAvXPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295668; c=relaxed/simple;
	bh=90LY6em8mxd7T98jUzeconjVDsBxDyoaeIzD3QrmZeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjlPxdt3/G1DoTr1jNxjby5mMqBpeIuLw5p9q+JcaAP91b/Iqtx0DSKkd95qAA4eT3XhNToIovGKhrLOBHaUVVrnBt1Z5V8MyRZdimjsEg4oU+PngeTL/MW1UKCLnBNs01yHf7cUe39ujCCCjDFbj5Kq11V8ZMDn1aSgv0RyvrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=PTIauC02; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="PTIauC02"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-86265451beeso1461157b3a.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789295666; cv=none;
        d=google.com; s=arc-20260327;
        b=g5rrcj65jDEZBYGskYO3FqIbvXol5ZTr/VhodVxD7iZtLkVW7oXlVEX2Cm5DBn5bSe
         QZ1GIIkGMoIxDMlt16u7R++pUvlDLVWemH0V58QrG72w+P4etiasrCrPVB2lMCwMTQ9S
         ANOmVzqTSoH3x8a9T3OuIxINuFva0FDbitBK3CwjbU/Rz4HB5Gb4zpzXUkwvNut7M84u
         tpmTt8pGOp37CeK1LZr8uJNaIQ/Kn1g5LNm/OEcwAHVdyJdEyZt7Z7E3pTJfHoDHZqrO
         UaOzZqhDvEIiJbTUYllYpD80C/bJVjfosVhCUY9EuvOe5yLCK2mQYdrqWdcg9VMlJiJv
         7EiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        fh=usogCF8O/4nFl79yg0YD9c8LgSyadjhm92ipV9pEyYs=;
        b=PkZ0gJ9NovtEkKZ+35Zyzq4PcA9toGNsjLY9Ri+cv4QSYg/n7qC3hLkjx5aJ1NHdP2
         lpm9t7v+AiSPi4lDx2kzUK3rZ2tQLiqbxMURQZfx4NgXkg7PEY3D5/zCkU5jVxWbEEDq
         lOPsjQuZ1obWwCgYoJ1aC8BSiVPgRU5EDyuEL1Iryt1OGzDJyNHlh2NZQaa/4j4ZQxEh
         Hri9LfK5M5kxFOh1asWAVV873BM1FgN4EypMPL7oYUbw289i4NZEdgD30bgW9a1/sgDZ
         CRrgGEfKr2rfzBoiMI/G9cIlF2snPTNHgguigW1zlNnGOAEhsVXrWq3anJnuwGp01aDX
         ZzBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789295666; x=1789900466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        b=PTIauC02R/nYTdyFnYOs1fwy3LchQ0MIE8VVlc+TkimK+bPTS/3NNeTo7bUOSQULy3
         /aJwC+fSetNtuiLYRCmwbGUK8HKE9XucZJpV5FRCZ/9QxnUIIXk8C8exkt806SpSKNLi
         sEQG55TVzJEZZJoxsOmcmejI7shGS10kK4S7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295666; x=1789900466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Kogo9lOizyymDQysvCSGPXKqMsf4PJ3Y0DuGpJRFAk=;
        b=ojnJqGiRkF25xS+DuEuNPzFz9RxHXlOMbSI3vsrNE7B4fpnYgJuDSFJW5VPfGKeZj2
         ECCPieQdAGbTUpXtXwbodmWMv8g4FP3eFI1ZzBmb1ToBioftFfq8iI+w9oPdgNPFhCfx
         o0iOA/ZyhL1T7Q/mG6TKM2NoMShcmH556fM8laLsZhQDSM9KUGWhdD1G3ZjnFi4TofaB
         l2SolYDpapr/+SQNMRsM11tilQk8udcmAaDpw8wodqEKMkdd2MQx7aE3kRbQO28fuybC
         W7XHMB4D5/+5L5EXxgFKNajac1m/zQYvttxL9AgmVFxR+hjz3uXTgJ2yWGFhPStxRwnp
         Aaqg==
X-Forwarded-Encrypted: i=1; AKwUvBzk6G6mwQJ6cVnZ0zgiDtBUXu2mFNTmrxFRUYFIaBWGEsOXNpFDuczBYTEQ6PxCiSRLx/049Og=@vger.kernel.org
X-Gm-Message-State: AFuF++ksuopURIYHRtY9xNkSus3wI6NeOM9Z0ZBOMPuFw87+JLzCRoNx
	QoO1bmvA9t5jUnETpEQRafofu9QyjpFR1HA35WFUPWAy+EYvpRYK1uNfyhovTf4opGwic5IgAVf
	o3ji2L53x4z0Uk9Otk3MXin2d7aGfWH9JMgB2446w
X-Gm-Gg: AYBFou2Zgs5SOyz576ccdDoFDbrHoNxgXm1Bwmw14JdFg1ucaP1APQZIlSb3bZsRB5q
	9CHUKvZcN4NRSUuKG6YEkhJPuvL0HZsDRnzM/rRNT2SNFx9M53EvM+NskiTXQSBxUor0seN09x5
	BWvcjbt+sf3XGQn6HJHjFLUAoGelfGNM9LEnnn05btaVaJLGv/5iyWrNtfwLt5Op42UWNWrI0Yo
	vYJnqOcsJgjZQP14bmeEAEjM5OvnCY7LXkzSEZSWR5GIsLEUxn3QoaaGy2fYHz84vnxANyY5xGm
	GFQDrmbt8nQEAN09ntRxMjXkFcbAl47PeT8Y8UwteOf7/Jqgx2XuHHDx+1aUqSZgIv+04g4Omhc
	kZwk4jAJPFQjW3rz1pLcPnVGUT/S4l1VfhA==
X-Received: by 2002:a05:6a00:4c8b:b0:857:727c:a1f6 with SMTP id
 d2e1a72fcca58-86b3170e7c1mr21035206b3a.24.1789295666372; Sun, 13 Sep 2026
 03:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-B855.v1.20260911153152@mojatatu.com> <178924538361.3125.3706649335976216385@kernel.org>
In-Reply-To: <178924538361.3125.3706649335976216385@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 13 Sep 2026 06:34:15 -0400
X-Gm-Features: AcwNN1UveGyXAGuMha_8k13f3akcEPJa49LaNvbOPV8S_M52ewBaXYsyzNBRaao
Message-ID: <CAM0EoMkMCM92WBrt7v+2Ov2xSGGAqen-YTZj4irJzNcArrQjDA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vtlam@google.com, stable@vger.kernel.org, victor@mojatatu.com, 
	hybris@mojatatu.ai, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 4:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> - [Medium] net/sched/sch_hhf.c: the new `[TCA_HHF_HH_FLOWS_LIMIT] =3D
>   NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT)` policy entry (line 530) is=
=E2=80=A6
>

These findings by sashiko-nipa are accurate but as in the previous
codel thread they concern changelog and selftest-robustness nits.
IOW, there is _no code defect_. The -ERANGE behavior change on add
path and the changelog overstatement are worth a one-line fix if/when
the thread is re-rev'd, but IMO are not a revision blocker


cheers,
jamal

> --
>
> net/sched: hhf: cap hh_flows_limit at change time
>
> The patch bounds TCA_HHF_HH_FLOWS_LIMIT with NLA_POLICY_MAX() at
> 2*HH_FLOWS_CNT, passes extack down to the nested parse so the rejected
> value is reported, and moves the hh_flows_limit default in hhf_init()
> ahead of the hhf_change() call so a user-supplied value at add time is no
> longer overwritten.
>
> Closes: https://sashiko.dev/#/patchset/20260822195509.112717-1-jhs@mojata=
tu.com
>
> > diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> > index fc72f825fbd92..5dec1ed969adf 100644
> > --- a/net/sched/sch_hhf.c
> > +++ b/net/sched/sch_hhf.c
> > @@ -527,7 +527,7 @@ static void hhf_destroy(struct Qdisc *sch)
> >  static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] =3D {
> >       [TCA_HHF_BACKLOG_LIMIT]  =3D { .type =3D NLA_U32 },
> >       [TCA_HHF_QUANTUM]        =3D { .type =3D NLA_U32 },
> > -     [TCA_HHF_HH_FLOWS_LIMIT] =3D { .type =3D NLA_U32 },
> > +     [TCA_HHF_HH_FLOWS_LIMIT] =3D NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS=
_CNT),
>
> [Severity: Medium]
> Does this policy entry also change the behaviour of the qdisc creation
> path?  The subject says "cap hh_flows_limit at change time", but hhf_init=
()
> calls hhf_change(), so the same policy is applied on add.
>
> validate_nla() dispatches the max check from the pt->validation_type
> switch, independently of the validation level:
>
> lib/nlattr.c:validate_nla() {
>         ...
>         case NLA_VALIDATE_MAX:
>                 err =3D nla_validate_int_range(pt, nla, extack, validate)=
;
>                 if (err)
>                         return err;
>         ...
> }
>
> so even the NL_VALIDATE_LIBERAL level used by
> nla_parse_nested_deprecated() returns -ERANGE, and hhf_init() propagates
> it:
>
>         if (opt) {
>                 int err =3D hhf_change(sch, opt, extack);
>
>                 if (err)
>                         return err;
>         }
>
> At baseline, tc qdisc add dev X root hhf hh_limit 4294967295 returned
> success, because hhf_init() unconditionally reassigned the safe default
> after hhf_change():
>
>         if (!q->hh_flows) {
>                 ...
>                 /* Cap max active HHs at twice len of hh_flows table. */
>                 q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
>
> With this change the same command fails with -ERANGE and no qdisc is
> installed.  Is that intended for a Cc: stable patch, and should it be
> mentioned in the changelog?
>
> The commit message says:
>
>     Configs relying on hh_limit above the default were relying
>     on unbounded, unsafe behaviour and are not supported going forward.
>
> Is that accurate for the add path?  A setup doing tc qdisc add ... hh_lim=
it
> <value above 2048> was running with hh_flows_limit clobbered to 2048, so =
it
> was not exposed to the unbounded allocation behaviour described earlier i=
n
> the changelog; only tc qdisc change could reach that state.
>
> The sibling knob in the same function is clamped rather than rejected, fr=
om
> the referenced eb56a495f59b:
>
>         if (tb[TCA_HHF_QUANTUM])
>                 new_quantum =3D max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]=
));
>
> Would a min() on hh_flows_limit in hhf_change() give the same memory boun=
d
> without turning previously-successful add commands into failures?  If
> rejection is preferred, could the changelog state that the add path now
> returns -ERANGE for values above 2*HH_FLOWS_CNT?
>
> > @@ -546,7 +546,7 @@ static int hhf_change(struct Qdisc *sch, struct nla=
ttr *opt,
> >       u32 new_hhf_non_hh_weight =3D q->hhf_non_hh_weight;
> >
> >       err =3D nla_parse_nested_deprecated(tb, TCA_HHF_MAX, opt, hhf_pol=
icy,
> > -                                       NULL);
> > +                                       extack);
> >       if (err < 0)
> >               return err;
> >
> > @@ -624,6 +624,9 @@ static int hhf_init(struct Qdisc *sch, struct nlatt=
r *opt,
> >       q->hhf_evict_timeout =3D HZ;      /* 1  sec */
> >       q->hhf_non_hh_weight =3D 2;
> >
> > +     /* Cap max active HHs at twice len of hh_flows table. */
> > +     q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
> > +
> >       if (opt) {
> >               int err =3D hhf_change(sch, opt, extack);
> >
> > @@ -639,8 +642,6 @@ static int hhf_init(struct Qdisc *sch, struct nlatt=
r *opt,
> >               for (i =3D 0; i < HH_FLOWS_CNT; i++)
> >                       INIT_LIST_HEAD(&q->hh_flows[i]);
> >
> > -             /* Cap max active HHs at twice len of hh_flows table. */
> > -             q->hh_flows_limit =3D 2 * HH_FLOWS_CNT;
> >               q->hh_flows_overlimit =3D 0;
> >               q->hh_flows_total_cnt =3D 0;
> >               q->hh_flows_current_cnt =3D 0;
>
> Moving the default ahead of hhf_change() is what makes the add-time value
> effective for the first time, so this hunk and the policy hunk together
> produce the new add-path failure described above.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/QDISC-B855.v1.20260911153152%40mojatatu.com
