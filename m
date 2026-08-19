Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FD3264F6
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151527; cv=pass; b=qcdHaLI5Yb2OoJjMqqL6i7nbnmTcZQ/GIuLLezzS41h9JkoNluNGEWzWiBKgW3np+SL8YYD179isHsRHmEOL5wA/fEFz6EsKuIzvkGaqZCxa9GdQo4tmH92fEFlTBfX+iCslcELDLDEAm5tYMTnBLMGzw79nwkI29Rr2m+e8Vjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151527; c=relaxed/simple;
	bh=NwSTQygdPz1tgY6C0nJJo5fEEmWw2/QVhLE7k9HCDUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSeXvarxSbJ5rTNkquZ3kbVRs8LP7nREZBLGwRdeEcvS//xOofL4jdAIHARObH45MkdZFlJtjIEzIYBHALfcOk+upzTnWz+dMGp8T6qdBOAE0Nbo/gYi2xotaca+hzqFvocCQo5RnvhX1jV3VrG4VnxdBAnwJB7CI+Qia3L25DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=W6a+A73E; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="W6a+A73E"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso740658a12.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151520; cv=none;
        d=google.com; s=arc-20260327;
        b=naYnuRNLZMNUOd6rON8n2FgRJu4bpk1gh50QlRpNHs8nUOA97R3kQ5lGjDiOx7+Crc
         mBDdToewNnSa2IOG7u/F+gPP4WkwMl2DcBpF8OFk9B3q6rtjFXEohlubJmmn1QyXEuV7
         H8lmK1QfwiLNpraE/YaBmKZS0skD7J8Cz5JtNyf64UW9qq9+1skhKiGpp/F8z8Kmx6kH
         tgrVL1CmLFGL816r5xDYYw1zYi5oXnfTAcTNlydE3EAL1Zr5bhkNLiEacKZ3ehVf0S+X
         Nfnz2deylh+wbZrJPpRa7+njZ2gdR9B6+usw1y001xX7fjMZXQCu81k5kG8S0Zv4O5Wh
         y+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        fh=oXuKq/pPNvjkwOoKE0rt4SIycYxGAE0rU78JF97Y/lg=;
        b=Ma1kGWMbcOXgGU9qqcXeukXY1cbWfL73NrY/X3oZxH53/BTet/v03Q566V2whOSDXR
         d3zGT0o1pYoFu02aGXuid5w4mQcc+frQduhjwMjyNNsaPrPNh3ESEAuOpL1lZj+utByU
         l1T9pIJ1YK4F7vwLRxTyFRZpSe9+zZRkAIUcd6/EHnusjZnpGvleR6XqPGJ8u67mS/oX
         p7AcVkLRXgQPnoBpveaaJPn8cLqiJsPD5ID21fXNJfSlhdsXdV/nXl2gCrAdVB6Hu+T/
         dFFqJHrf1E5va59IXUMdVqCpbq22pvFvN80fzDDIySxwnsf1FUaRpHgw0KQ3sU3GHi/9
         j4Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787151520; x=1787756320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        b=W6a+A73EpLl5nbKsEHEhRAWZzr4OPLC1ByALc4V9mEi44AYYl5oqbKwKYum5QzU5YQ
         xSkGX04J0dJcAbNJMxsKzxr/tQR4wDyumJJnoR4HAzxciboNMmAo2XV/XILehioPF6o5
         I9vFXZBbelh6xSu0OKuXzw2nnCrEYr053PLv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151520; x=1787756320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=34/hS36bGgNkv8IoYOmdyqI8EyEJGsQbwzaIsXNW56Y=;
        b=O7yCgCHW7HlwcwKYz+sW+ADw8ZLMq9n8CPa4qInH5kw8+bUx5O0fVTLpaIYm5BmODF
         uwWTgyeMI/YruFxf5zPDQKsOljLGuFE1vYtbpAX2VaNPzBM8aUXba1+cjblw4Pbcjl1y
         wzg2khL5x0lczw1yn8jx9Ts7qLou+c0Ffh6EazKuqxiBHnYsuf48SDtZzJx+oIOZ5Lm7
         ++88kgNHqGnxwYn/dYXx2CU+2jQm+UxBXLGoMkSRFIspVRLHVHAjqvBGvaLKSEwnDSkH
         Mnx4IPbgiS6HnnR/jnOtpgqluOzF2+oSBOaNd4k0xZljOAnm23x1dCwUMvLIaTbs30Sp
         WIbQ==
X-Forwarded-Encrypted: i=1; AHgh+RroiTt5QmVUXror6DyuI9/NOQiOnlAkdIUgj0neg2njFes/2oWXoRy9wlCQ8lXRtQ4mcLZX9TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ps9wdANTWH6Zz0kv7C2GZzqm4f2wHQWHw/pV8a7hJ/T2fI+R
	pbMknZi8jDjijsjaBmemurDukqizN6Gi9jWi70R2WqLuBGah6NqSEODhxlHNzWqN445serSUd+0
	9J1IGcAzVQrirZRpzxk83MUyvstLT5ES4Hhbkzmq+
X-Gm-Gg: AR+sD10sWMegJSfUl8e6e8tySnvXuR/4ajo82eFjS48OpSwrkl+4NmfwkfC9r11w+84
	dM101l4PcEVyj/QyUEYq0f0Nk8q0F4o7LC74lNfBEEHbEoiKhap7t8hT0d5vKAT1H9vxPOiXmmY
	tZGMbDejDWS8Sc9Fezyxt3/U8mi9sB3sejdb/7Oz9NzbxLwpclsFuS+Uh4FUJgW7Boph6vb/r5t
	HqYCRHR3ogOOB1mDGku2yFU4VzfNA7PZp1pKgHRmlASXTlDZnHS7/EVDZPZiYZUPr5CSjEiJrgR
	kxlH9dV49JtAHtPN93juo1h2uzf6Mlvf6IGFki+IH/6F4A==
X-Received: by 2002:a05:6a00:f8d:b0:846:8b22:4933 with SMTP id
 d2e1a72fcca58-851d3a69eb7mr8869557b3a.17.1787151520239; Wed, 19 Aug 2026
 07:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com> <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
In-Reply-To: <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Aug 2026 10:58:28 -0400
X-Gm-Features: AcwNN1XQW6l3kg8etJVD8u8e6M6J67YSYFmD43PINaeXh4NmX0JNWYrO4HorUC0
Message-ID: <CAM0EoMkUXGW0WNV4Y3rLUyJUDxFcmd7knYoF3ynHQWjUXHRTQQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 10:52=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > qdisc_get_stab() accepts a user-supplied size table, and
> > __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> > overhead, the size-table data (u16), and size_log (up to
> > STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> > to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> > DRR and ETS replenish one quantum per loop iteration; with a tiny
> > quantum (1) they spin billions of times under the qdisc lock,
> > producing a soft lockup / RCU stall.
> >
> > Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> > amplification cannot drive deficit schedulers into an unbounded loop.
> > A legitimate size table (e.g. qfq's overhead 999999999, which is
> > handled by dropping) is still accepted.
> >
> > Conditions to recreate the bug:
> > - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=
=3Dy).
> > - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
> >   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[32768]=
).
> > - Add a class with a tiny quantum of 1 and send one small packet; the
> >   deficit loop spins billions of times under the qdisc lock and trips
> >   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> > - Reachable as root or from an unprivileged user in a fresh user+net
> >   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> > v1 -> v2
> >
> > 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caug=
ht by
> >    running the whole tdc.sh instead of affected qdiscs reported reporte=
d by
> >    poc. That test legitimately uses stab overhead 999999999 qfq and exp=
ects
> >    the qdisc to be accepted (exit 0) with packets dropped.
> >
> > 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
> >    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
> >
> > 3. Given existence of tdc 5993 we dont need the tdc test created earlie=
r
> >    since the essence of that test is covered in tdc 5993.
> >
> > [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.=
com
> > [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.=
16655-1-jhs@mojatatu.com
> > ---
> >  net/sched/sch_api.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index 65b35528d125..ad4f117ff55a 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb=
,
> >
> >         pkt_len <<=3D stab->szopts.size_log;
> >  out:
> > -       if (unlikely(pkt_len < 1))
> > -               pkt_len =3D 1;
> > +       /* A size table can inflate qdisc_pkt_len() beyond any real pac=
ket
> > +        * (via overhead, the data table, or size_log); cap it so defic=
it
> > +        * schedulers such as DRR/ETS terminate their refill loops.
> > +        */
> > +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);
>
> Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a function =
which
> does not take care of GSO packets.

well... there are many many references to gso under net/sched. What
dont you like about this specific things?

cheers,
jamal
