Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E041F5C4
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152552; cv=pass; b=FprhlhhmJAvJnWuWxwRh333k56571TI7WrSNIvvRxhMtxbDB8lsebquh7P/4ADUmKokkeO0KOouQX0mPZRHRvVRhMCfzUHkq13D93L5TKPrk0scOzGaEN8kdcHQn1x3NTZeXAzriG9eyh3w/VVQ4VA448JWMA2ghCVye23h0EnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152552; c=relaxed/simple;
	bh=459KEqF2l7j0bEcBM0KmDs2lcrDu+oIduz2otY4oqsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9w4sddWdZ5+mz5oeGtd0uNG708tM6GPr1vUjWeBlh50qB85/TfVvTpCe7vMR9McQY0bQ3KqIQRUx/BZBez4exzvRUCBKCNDpEZMbMmqD583mosy+XhHwxh7n51R46Q0F/cICo48dsV/gEZy4RbW0eyF2sAGcVMCrtBq0HcnshY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TbtHTeAN; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TbtHTeAN"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c05dcdf49so11209831cf.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787152547; cv=none;
        d=google.com; s=arc-20260327;
        b=eZTMmpPu694/VlcEzWGKEZVZFgjw0Ksb9LFpdK/SOJQJP5sVytPiJTg4yQMhVTUmOn
         dxY8HpKPaOX1f5jYKPlO8UahIVzRLxhFPwopvzHt7jQQ7nfFypQMLcE3ndJBe928yPlO
         eH7ciJ5m2RGtqEZN5UgSoS16y5ON5xd2L/0ANDBoxEnXDeoOHvmCv8jdDWNI6FVr7WVY
         mNmx5rfsSQop4ghqKGnurnZCgYyLw3rQrQqQ85w4h/dV2p0X1B2RQYwWKUgeIQyEVBhc
         9ZuHK5BrKIsW7wQP0bDJPrA8Xx7umKBp8/7gM/5dUaa6kYku0APkzKOz9+V/ZGhCwAI1
         lUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        fh=croGKxNujaZq2D8OEpkBY45/g80YqfU5w/dfcj96A2A=;
        b=KJyXp12y/6UtXJ/CYR1+YGrJi/speyV77do7RAGxkGiBfMziKHKtQnzFOMvgexNqVF
         GY8YrlgJuSQ4ntboLPiaD9fW6Q1xrluFa9KKmjeuMkW5p+kPnu5CmKmAb02zhz4n+C/u
         g0SrLRcS/lyl1raDPC9bzoA9uI74gRXRP9btwb7d8TjusfYd6cMujipYU/dWnS4fPDav
         PEwTqo8k4T+Tg3g2Yxy8mUuTKPNimrip+QQPUepQJ1nlPE9FdmkWhCL+XVUk1WKLavqE
         7jXb8seR3JJtOpgW8TkGXAdJNploxWtyUmigQgF5iXr34LAG65KD8CJw3d//daQ8CzK8
         XooQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787152547; x=1787757347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        b=TbtHTeAN1jgP48UZ46vlkV2dmvtaEEsMFT5Z9b6TYAl9qFO56j2M6Jy0pKaA80YHJI
         O+aNo3wUe0hJp9DyZBgd7mNecmLU7r2s2O5eVDeKk5SkN5O0XRj+xykclF9QZ0pJ1qQ6
         Cyju6W3cWQfIRGtzwgj8H6yl9DvE8ByoNQQXSFzcEB0bsUsG7wTjo7wk5D4M7zMZrh3Z
         22/1Fn5LKFnt6S9LEJnxQEuv6hstqWt2OiX9wIjzGVHtZIy603U0RatUzgzr+JLLxolb
         VmN/pYikQ8kmK6bGBTYCgYJBS0yOTsnwxdV7H7CHtw9h6A4LZ2dYQATdVPjEU0wEKxqJ
         DLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152547; x=1787757347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7N8CbCmVonj0Y0cToVjeMsRxbld7SNQmDP31faW8N18=;
        b=D3KrsBjBQyAH60yCnCxT4v5X74u4cMKWdmFnsQwNo32SnCsJhWQEPuH8tT+mHqQUzl
         +jFb6UwyHUSnMF9EeGmB8isXa33naFvHgY53NK3Yek6jGdb0ds0Z1WJPTSPGXemWJJLD
         oGOiSqo0cREEIx9xkHHPQMyBKUOVyrekgXMbQrcqpRdRZociOXQR3EMX1UxnbeYPLAxR
         FLuSYkd2qr9mj1WPUwzntVy7bRfuAnsfxYkc5yAJ3V0k29f5g439/CM4/XE18byxYy5s
         D3NsdECU+wLOpBmftJYoL+6/uuCSRkXCcfF491XEfKjisJX9LC+xNDIVfe5glVpBZxxW
         IvhA==
X-Forwarded-Encrypted: i=1; AHgh+RqJQLNYadSSS7f8oa2tVTu5zLsh+y3lD9n0oogmxowi5JyzYRfrxbap/EZrK/4fxKfxjF7goLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSP1QcycHJdi5FLiVtg2M/pFlZpzTIkxHFItzdI/nA/u25dMF
	AEOtCi0+5DNYOJA76vj24OF1kPLAAFb9faLlCvtWiAvT72S1UAVfTe2TilvtoX2KF48YVkbnclf
	65RCwLfU8pBMNS6bZnP1RaOCQ3UrM/+ptmSS7z32+
X-Gm-Gg: AR+sD11xoLxqD2TsYE47psaxWMBSqAvu1VHln87eicD+rk4sOAMqMKtbKH2UWHey5ZE
	Fa5aIuhQTOMu8YZaDprWxXriVUQ3KqSzON5FsoNPJP7o6dF+Cf5rPljelkpXDoeaIGLWowwqDq9
	WusvQBgiXagu/zf1cwNYyAvyaU5BKQNOJ8i2o8Mk9DvEE5COcxWNJIvtoaF9pCqeCSIR0gVdu3/
	/2ZLt2HrGTDBOMKZKONiF3vX/2OAD9o8W7nOGE5tboRc6oB8adY8IPAp2ux7VNp9cjcVSkC1YZJ
	qQTkTakRb8DCfKW4qlUYlwZYrdfdjNiN7UFD5i96uO6hvHYB3n2D9E0WnZnsbrrpTyi97kgV87u
	lH/GM2RG5w/0OFsGfjU1+pMDOJSghwD2WkxHgn42zrfNK+gZNJFWCkR075EClA4ZETjT31TyahP
	AA4cjdFZCqHrUuwBdROV0NfvDqFOUQqXw=
X-Received: by 2002:ac8:5a8f:0:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-52dd57ac078mr45190801cf.13.1787152545797; Wed, 19 Aug 2026
 08:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com> <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
 <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 17:15:33 +0200
X-Gm-Features: AcwNN1XA1mkL2GBkrHiZcLtt-FVG_mEYcasRRO-QpOxG4ex4lu5i4fvUlZsq8wc
Message-ID: <CANn89iJSR0kaRWtg+tkC2dfaOnCsG0TEcS=wS6oPOFuY5f0hjA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 10:52=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > qdisc_get_stab() accepts a user-supplied size table, and
> > > __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> > > overhead, the size-table data (u16), and size_log (up to
> > > STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> > > to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> > > DRR and ETS replenish one quantum per loop iteration; with a tiny
> > > quantum (1) they spin billions of times under the qdisc lock,
> > > producing a soft lockup / RCU stall.
> > >
> > > Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> > > amplification cannot drive deficit schedulers into an unbounded loop.
> > > A legitimate size table (e.g. qfq's overhead 999999999, which is
> > > handled by dropping) is still accepted.
> > >
> > > Conditions to recreate the bug:
> > > - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=
=3Dy).
> > > - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
> > >   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[3276=
8]).
> > > - Add a class with a tiny quantum of 1 and send one small packet; the
> > >   deficit loop spins billions of times under the qdisc lock and trips
> > >   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> > > - Reachable as root or from an unprivileged user in a fresh user+net
> > >   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Reported-by: vega@nebusec.ai
> > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > ---
> > > v1 -> v2
> > >
> > > 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, ca=
ught by
> > >    running the whole tdc.sh instead of affected qdiscs reported repor=
ted by
> > >    poc. That test legitimately uses stab overhead 999999999 qfq and e=
xpects
> > >    the qdisc to be accepted (exit 0) with packets dropped.
> > >
> > > 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) =
in
> > >    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
> > >
> > > 3. Given existence of tdc 5993 we dont need the tdc test created earl=
ier
> > >    since the essence of that test is covered in tdc 5993.
> > >
> > > [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatat=
u.com
> > > [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026081810173=
5.16655-1-jhs@mojatatu.com
> > > ---
> > >  net/sched/sch_api.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > index 65b35528d125..ad4f117ff55a 100644
> > > --- a/net/sched/sch_api.c
> > > +++ b/net/sched/sch_api.c
> > > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *s=
kb,
> > >
> > >         pkt_len <<=3D stab->szopts.size_log;
> > >  out:
> > > -       if (unlikely(pkt_len < 1))
> > > -               pkt_len =3D 1;
> > > +       /* A size table can inflate qdisc_pkt_len() beyond any real p=
acket
> > > +        * (via overhead, the data table, or size_log); cap it so def=
icit
> > > +        * schedulers such as DRR/ETS terminate their refill loops.
> > > +        */
> > > +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
> >
> > Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a functio=
n which
> > does not take care of GSO packets.
>
> well... there are many many references to gso under net/sched. What
> dont you like about this specific things?

I just mentioned that __qdisc_calculate_pkt_len() never was updated to
deal with GSO packets.

It assumes packets with a single set of headers.

This is fine, I am sure nobody uses this stuff anymore.
