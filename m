Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A227E3A0E97
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153459; cv=pass; b=N+UuAWLmebQ8Ht+SrBTGfSlzkC5JJ2FtF1JFJFjUW6PP2gmq7QgIjAl8OGJ60ZRWwwq4iDca1spgFXM25SJQ5JM0v1I4yuomlLU6oZ3VXvR9DYmnxmaL3IUx+dOkmTCF35ieArsa0+SSJsSEUV30sanYDCwS4sE03hI/qN3V5ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153459; c=relaxed/simple;
	bh=AsxeJXe7AG3EGXokEu00mEkjMQDxpxVbNdVtS1j1bec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMBIHHvrSwBPNKPmkiPcgDfRzD+JpYnG9pSGQY4lFazfs/v8QCBenmc36jmAMt9EulLQ6RtOqjSlNf0Gc+7DoZ6kltQoxb3TA9OaeKjtd3OJsxTRJ5IbEGsYXDSBBjMV1FwVGLBJTkADr+QncB8cRduDYIxFIiKWV3LtM05yJIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=qLpjTrsA; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="qLpjTrsA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a2dcede83so1435658b3a.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787153456; cv=none;
        d=google.com; s=arc-20260327;
        b=lt1IpzMvPpf3QisRZWVlY2PBNFb80pCTjQ6z+cwivYfkoobqM/fQlBtAv6y9qA6gGJ
         zVRgfIoSvwkQXmzvhANr2EYDVJtZ3n/fAf4Mi9DbxWpYdkAM1VHAlMJ7KRx5u7hirA59
         gqr1fX1z8F0PnHMN1IgOngf8A/jWFD5esdb/By0FLfUCMD8LiTlwmPV+v7ERy6cfu6nz
         jGjlnJ42wqB4ETenLNaldTn6bx63QqPIt6COQhk6MYcv6O+aPuSDbw0nKb5L5dDJWBBR
         4UqVUC2eEoIGG/SmQlsds/HRXq5YstkVXwlySZh+w+NctHjkZn5u7eTeyAZTJX8MIx80
         p4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGG5sZDbz/pMhpQNy7eCICRgxAJaB2imxiqmELSVOJw=;
        fh=ZrXIl3AtUgypXItRfo/p9VHjOOhwYlw5FFYE+MIUM+Y=;
        b=FM8tNukAkTEctU4wgxDP1IWgMFhswVubKEvlPrFehSI+zmmQ57k7sd4qDfCfJ8p0QW
         M9ZRU2XAdAo332Njtnv1kRdIJxu+/xtdRPpwc9QTGxGecJtOYmFAjsqQEJV2o+wHOLKs
         Hig4+NmiqtZ6ut07kqixIV1vycvrfySI1eu6SWcZuKb94cZOwjSeL5kf2Y7vKCJ2A0lx
         L+fhoJ3rcSLWEekyX0xTirH3zx74WddM6Xxg8DCRln2vzZrOvnZYegvNDt9/9BXlkB2k
         NVj9yp0WLBTHDjZHxx5/bVX5Nje2K/dWWQepJ4L4boNJJPST6yZodZSYHyYLBc0p5Dgt
         Ed/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787153456; x=1787758256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGG5sZDbz/pMhpQNy7eCICRgxAJaB2imxiqmELSVOJw=;
        b=qLpjTrsAdmXxiAoFmzBldIgkayhzEpM3QVtCB87DOaHe7F2+zwKwf1YHsHOeHQTaXW
         qWkEZkHEFJ7JiJU/DQFQfxAPmWDNfhCGz6GE36aVE5wCE2bkVee/PzcJuyyRfFphaWaX
         HMsUEU1ecriiuRk8PWihaSvMMBUOsG0CKIAPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153456; x=1787758256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGG5sZDbz/pMhpQNy7eCICRgxAJaB2imxiqmELSVOJw=;
        b=DYZTUg8i38zUGYQb5W8C9fWOxsrSl8d8L4oHAMCc0Xej0k+Jp6OYenNoDSvUb9sTXN
         vhYy/vTrbtHN6J2uy2W9cCAW4zkKKyaUXWb+j9aetYGtZ7YF9ujg2td5TFNa4YBhW8TO
         9kwxnjPZ/lZ6habpdy18X8+L2YwiUXr4heKKLoDaRu+x7/8Ywtn2jdaqboBevD442VQP
         asdDEW16q/RUYBexufXqAGv3e70b0NOie5LFxEVwZDiEsk6EIsgsgmJEA46ZRbCqCsKO
         FKfrhQTSw0yik8r/xXvEkxmoJHcwuPAB5mIb8W8aDfBla1ORInyxK23rzN4ceflTjntD
         ENvw==
X-Forwarded-Encrypted: i=1; AHgh+RpLMf+KWEx7e07kw7jaLQyIn77H3eek0Lz7+52rpSNpP8T5PIRFTwWlh2VE8qtMAccXxDMvPXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMj6UHkpgqkDN5LnvyoMIr/IVS+XK+RcHikzkFaddXS3agGgA/
	spIzexWL3tllQ+BnDFqdFDHkDqOWwTgOZrgJ8zJChTEI1q1TNsfT9W1iLnlwh4pMnlbNNNY7tRh
	fHToD38SlYq8Lmv5peHp4lYn3jQsYzmCU+dPsid2e
X-Gm-Gg: AR+sD12vvveZ6h7CuiLGKKG/jF8HZTGWxny87F64C5jJGxoN/aoor0fvGcScZRpzzPy
	U8Rn2TCSK5I3/xAQg09q3Rl7aZ95i+r0qift69hn+BqlXI4lOWu1DbLborzt0aKpY6nLWMZAap4
	Z7dwfh3k7dTCpd4RcAQ3Inoz5aQBImEtT9Yvz6j/OKQdTgKl/G8fggqaQKtvhdPh46BA0lfO18h
	mVsYsrnVxBEfS6hpN/RCFnQ563gaEF0X/FpT87NMu8TytTPVNPAImEJhGAEOLg9dM0n+cRzfDb2
	bVniGPu0WxW4B9it0mjYFLGeeK4T0Xe2s3W0zTNafA7ZZw==
X-Received: by 2002:a05:6a00:4309:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-851d38313f0mr9788438b3a.1.1787153455194; Wed, 19 Aug 2026
 08:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com> <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
 <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com> <CANn89iJSR0kaRWtg+tkC2dfaOnCsG0TEcS=wS6oPOFuY5f0hjA@mail.gmail.com>
In-Reply-To: <CANn89iJSR0kaRWtg+tkC2dfaOnCsG0TEcS=wS6oPOFuY5f0hjA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 11:30:44 -0400
X-Gm-Features: AcwNN1XfHpR_W8n6IWSvk9TX31Je14P24nZwSQVhEES-Fn4PkiWX3hY1Y6D4DtU
Message-ID: <CAM0EoMmhjJyBZArFUdVBzzw6Ko6C9thDgOL-VMU1jDTAhS_qYA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 11:15=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 4:58=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, Aug 19, 2026 at 10:52=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > qdisc_get_stab() accepts a user-supplied size table, and
> > > > __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> > > > overhead, the size-table data (u16), and size_log (up to
> > > > STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len=
()
> > > > to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> > > > DRR and ETS replenish one quantum per loop iteration; with a tiny
> > > > quantum (1) they spin billions of times under the qdisc lock,
> > > > producing a soft lockup / RCU stall.
> > > >
> > > > Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> > > > amplification cannot drive deficit schedulers into an unbounded loo=
p.
> > > > A legitimate size table (e.g. qfq's overhead 999999999, which is
> > > > handled by dropping) is still accepted.
> > > >
> > > > Conditions to recreate the bug:
> > > > - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_E=
TS=3Dy).
> > > > - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
> > > >   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[32=
768]).
> > > > - Add a class with a tiny quantum of 1 and send one small packet; t=
he
> > > >   deficit loop spins billions of times under the qdisc lock and tri=
ps
> > > >   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> > > > - Reachable as root or from an unprivileged user in a fresh user+ne=
t
> > > >   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: vega@nebusec.ai
> > > > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > ---
> > > > v1 -> v2
> > > >
> > > > 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, =
caught by
> > > >    running the whole tdc.sh instead of affected qdiscs reported rep=
orted by
> > > >    poc. That test legitimately uses stab overhead 999999999 qfq and=
 expects
> > > >    the qdisc to be accepted (exit 0) with packets dropped.
> > > >
> > > > 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280=
) in
> > > >    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
> > > >
> > > > 3. Given existence of tdc 5993 we dont need the tdc test created ea=
rlier
> > > >    since the essence of that test is covered in tdc 5993.
> > > >
> > > > [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojat=
atu.com
> > > > [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101=
735.16655-1-jhs@mojatatu.com
> > > > ---
> > > >  net/sched/sch_api.c | 7 +++++--
> > > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > > index 65b35528d125..ad4f117ff55a 100644
> > > > --- a/net/sched/sch_api.c
> > > > +++ b/net/sched/sch_api.c
> > > > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff =
*skb,
> > > >
> > > >         pkt_len <<=3D stab->szopts.size_log;
> > > >  out:
> > > > -       if (unlikely(pkt_len < 1))
> > > > -               pkt_len =3D 1;
> > > > +       /* A size table can inflate qdisc_pkt_len() beyond any real=
 packet
> > > > +        * (via overhead, the data table, or size_log); cap it so d=
eficit
> > > > +        * schedulers such as DRR/ETS terminate their refill loops.
> > > > +        */
> > > > +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
> > >
> > > Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a funct=
ion which
> > > does not take care of GSO packets.
> >
> > well... there are many many references to gso under net/sched. What
> > dont you like about this specific things?
>
> I just mentioned that __qdisc_calculate_pkt_len() never was updated to
> deal with GSO packets.
>
> It assumes packets with a single set of headers.
>

I see. I was looking for something reasonable. The problem is maximum
real skb->len is UINT_MAX and with stab amplification it can get a
small packet into a GB.
Would you prefer a new #define in pkt_sched.h to put an upper bound
(QDISC_PKT_LEN_MAX)?
Something else?

cheers,
jamal


> This is fine, I am sure nobody uses this stuff anymore.
