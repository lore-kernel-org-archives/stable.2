Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7B353EDF
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298579; cv=pass; b=NO5acMT5/6l2pp/umheDqtRhQ7iu9riQEk/kP4kvI5mc2ZiBJ8JpIaajEUTRrqhMQYkLfsoT5PktlDvRlSJBWsXdJxWAHmlBsFmYrZa206+R27PVLI0KsbUW+pYVZtUfUW7ufBaeDa27GYyOEEBb+9NhetltYPhI7S15jgA3zMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298579; c=relaxed/simple;
	bh=BhSc2dEq0S1dzIyqWLOPR2lN7BJ934oECopEsXOBiaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WC1Tp1p0Tm2kL0pSSsrpot7KmOxr+NcZfkHcwd3FCLL3w8KWn01KkB35o2OXtXISmdoyr25kzpLQAhI3J5YsasCtVW1ZSRwijqs2d/RM4v9sztbwc8jzqI/2EYNvZ+0Jq9L6KZyT6EFyM0Ivta4qOPLfuf14rBqMIuvEaHbHd6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ZBupoozP; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ZBupoozP"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8520161fdb9so442100b3a.3
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 14:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788298577; cv=none;
        d=google.com; s=arc-20260327;
        b=G280FQK/ijtfxYqbEYjzhvY0LOGCnlxOLhQYsWpb1lO1CQBbutLjW9yNWu9U+Suvds
         9Jtjp7s+NFl+B1CaCnuIsbjQEi+ftl108SRrna09ef5lUL+HbqHAWVmvvPMhoS7fXfUx
         +oJM2TuPm2QPevSM1gu3vhZNKp3FOxv/9JrRneXtRgngPnAaEQk32D7uq4Xqxev5U3a/
         h+kNqrgDZjEoGjro+dtV9PPb851BWjeLXhK9O4iCmCA99ZpefMcHAjoHVb2xMd4ugFBa
         f+Fd+OQxi3yZoOnINMmOlphQgXlvz3xfvqMoZK7lh60p0ZXwbtiuIuRVorSJKL24S++A
         W4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        fh=i8CXwIt+detpLuaneW5UTaKzQfziYmAEQHmV6p3O4tk=;
        b=HjDDQ+dJnd8JTXZ1CLsocZ91BiLd7Ea0c92HpP4WUQaLExsNMfH2dPOfgTgpYr3cZu
         HJjdJo7LzQnHYJ2SCMl7YZgO97lM3MFRD/Mks8MBwws3awS7li7bTWMY4fNIu3UgiJV0
         AVR6OkYX7Nm9LkRsqQsecGJBKGB8v9a6qxn/7HQbNoXVmyfotKPMtBeCjDHj93fkZZ/h
         A24cFcFvDx63QaJZjEfPoEs/3MguRIoKk2ewPlwRfSwsxa06McQ8ZzaJfTJoLPTrPxso
         uDzdasAqk9H1ZUrNGtfOcAF9dJheTrfFfao2FhyAyxHT3NAzweip+uVuycAdRJ3UOPPf
         fIgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788298577; x=1788903377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        b=ZBupoozP6ZYyZcVHTKmN7iqHcMAf1lnQo7t6bwhL/aORzUOjopG5JX7SBAjh88oSft
         CRHvtArQAHuicGJABkIG4E4YsOkrQJPn5r3iKmadtls9cTWAmyJ0y7TsTJZ+73ZJwVca
         tcHuynfgqlLb5TuMcWBF6eUX1YLf49dhQmPr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298577; x=1788903377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w7Y56somwqOBcy1h3s6nwu6zCIUyPXqDJ6IVyLcjmz8=;
        b=sAjy0qa8RSnJUt7vwVRTXimS0l9et8vgMNVQNZ0V7RCraOMBIpzXQpvC/pnbKSVF7m
         LDDajgYD2xEwBEae7hrZj2wkiLrK5a3k85w6Wq3mmfYPQs+ZvXVR7e5lGRFl9seP79HC
         us1/4AtXruawaoVgzNxhw1peEkEkStxisEOF3EDI75Dd3MPFeZYb/kHysfaUsehji0FG
         L3iVuu6BMHmPk6X3KA+k4Fg76Uk4o7FME3KP4Ig2ADWRwCTgAWBb8aUBVqKx55rjo3Ev
         fe0spRijCQEp8dVr/EFvwR9RgKgy7edbqVELiPiWUNb7XTfFa9TaIg9smcWXje1cVNp4
         57tg==
X-Forwarded-Encrypted: i=1; AHgh+RrbFINsCO3WqfsCjb/CHyE3w+Mv0MgGiqpIbjB+xmHEoj1S0e9O2vva5PWIdKu9rFu4mHuIq6k=@vger.kernel.org
X-Gm-Message-State: AFuF++msoD2Wu8xNvnCsuBiUGQbPm7RUtV6PArgkr8TAWHPPLMB/NCK0
	CiPumYbKvVPRmOZRDybHy03Y+Avqec/LUtiUgda2AXIRH4dIRBNarGusNObvmIqZfUHiWE5sESv
	WRnUqJN3zIv+ZJaiKsL62p0YNhF+uZzkz0EdMiT1h
X-Gm-Gg: AR+sD1378fpX+5KdJz7sVNeVb8ptS2gBcOUgBr5ai23NEfO6ud/JKU9+LQqETuK3Wdr
	VvkpGqDma5sUk104KRMmgxPxoVlFx149t3Enf4LIktFrjMcxV3n8/gOhYEZ95u6s93iT9RZlFMN
	HoxsVn/q20KIEcTOFh1BQJO86XWpDk7lPHdUdOqX2or2WzJh9tkcz9HgDlu5tQAqAX6yUHgQl6o
	MZo1ZpLsgyuK/Kw6Qky1eft6O1p/eYiaJqtv/dK18vNb+EyTQoHcOam8hp5EPSQaOHaa4gU+ywB
	saEhTAbJx2LHoyVg0dHe6l0HMCSfHrg1T1Ug+r6ui4Nr2mBpTv4/JJHMC19gSoKfUMlCi0uhWaU
	K8qDHq3Ph2vRPWNB7h4gIF4LyxDAW
X-Received: by 2002:a05:6a00:398a:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-85ed398a7c1mr796851b3a.13.1788298577057; Tue, 01 Sep 2026
 14:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829081229.81708-1-jhs@mojatatu.com> <20260829081229.81708-9-jhs@mojatatu.com>
 <20260830110317.3357a4ea@kernel.org> <CAM0EoMk6t2FB_3ewLHrh8rqnaj_ecO2L2w7BA0xRUXGJSoqJeA@mail.gmail.com>
In-Reply-To: <CAM0EoMk6t2FB_3ewLHrh8rqnaj_ecO2L2w7BA0xRUXGJSoqJeA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 1 Sep 2026 17:36:04 -0400
X-Gm-Features: AcwNN1UdCDS7xhrP4FPNJOCPZrFUIeoV8IqdAGHm31OPul5mAuiSmzrrqCFB1MA
Message-ID: <CAM0EoMkwAc0Ver1p68an+Mji-QqCPxubxa4f-wgnAxQK0x6_+w@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] net/sched: ets: clamp quantum in parse and
 fallback paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, vega@nebusec.ai, stable@vger.kernel.org, 
	toke@redhat.com, chia-yu.chang@nokia-bell-labs.com, 
	subramanian.vijay@gmail.com, petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 2:59=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Aug 30, 2026 at 2:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Sat, 29 Aug 2026 04:12:29 -0400 Jamal Hadi Salim wrote:
> > > ets_qdisc_change() falls back to psched_mtu() with no floor for bands
> > > without an explicit quantum. With a crafted size table qdisc_pkt_len
> > > reaches ~2 GiB, so a zero psched_mtu on a headerless device makes the
> > > deficit-refill loop spin under the qdisc lock.
> > >
> > > Move the floor into ets_quantum_parse() so explicitly configured quan=
ta
> > > are also clamped to [256, 1<<20], not just the fallback path.
> > >
> > > Conditions to recreate the bug:
> > >   CONFIG_NET_SCH_ETS=3Dy. Requires CAP_NET_ADMIN (namespace-local via
> > >   unshare -Urn suffices).
> > >
> > >   tc qdisc add dev dummy0 root ets bands 3 strict 2 quanta 1 1
> > >
> > > Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> > > Reported-by: vega@nebusec.ai
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  net/sched/sch_ets.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > > index 25fcf4079fec..6cc902a03838 100644
> > > --- a/net/sched/sch_ets.c
> > > +++ b/net/sched/sch_ets.c
> > > @@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, co=
nst struct nlattr *attr,
> > >                            unsigned int *quantum,
> > >                            struct netlink_ext_ack *extack)
> > >  {
> > > -     *quantum =3D nla_get_u32(attr);
> > > -     if (!*quantum) {
> > > -             NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
> > > -             return -EINVAL;
> > > -     }
> > > +     *quantum =3D clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
> > >       return 0;
> > >  }
> > >
> > > @@ -632,11 +628,13 @@ static int ets_qdisc_change(struct Qdisc *sch, =
struct nlattr *opt,
> > >                       return err;
> > >       }
> > >       /* If there are more bands than strict + quanta provided, the r=
emaining
> > > -      * ones are ETS with quantum of MTU. Initialize the missing val=
ues here.
> > > +      * ones are ETS with quantum of max(MTU, 256). Initialize the m=
issing
> > > +      * values here.
> > >        */
> > >       for (i =3D nstrict; i < nbands; i++) {
> > >               if (!quanta[i])
> > > -                     quanta[i] =3D psched_mtu(qdisc_dev(sch));
> > > +                     quanta[i] =3D clamp_t(u32, (u32)psched_mtu(qdis=
c_dev(sch)),
> > > +                                         256, 1 << 20);
> > >       }
> > >
> > >       /* Before commit, make sure we can allocate all new qdiscs */
> >
> > Does this run afoul of one of the tdc cases?
> >
> > # not ok 39 41f5 - ETS offload where the sum of quanta wraps u32
> > # Could not match regex pattern. Verify command output:
> > # qdisc ets 8004: root refcnt 5 offloaded bands 3 quanta 1048576 256 25=
6 priomap 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
> >
> > https://github.com/p4tc-dev/tc-executor/blob/storage-dbg/artifacts/7999=
38/1-tdc-sh/stdout
>
> Yikes. I will resend with this fixed.

I was waiting for nipa sashiko to say something but nothing happened.
Gemini nipa had nothing meaningful to say - So i will send v3 with
just the tdc test fixed.

cheers,
jamal
> cheers.
> jamal
