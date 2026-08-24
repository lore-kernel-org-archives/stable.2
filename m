Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33793E4C72
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575064; cv=pass; b=H0sDe+AqFHDBdvACBMFvRsdr6srIQGpI/vJ47Y3mxzSKaw0huxKhjwCkP8gc9QH9DjDTpEmWBryd3ntul/5P/992nRl4dW3m3oECPRjf/I/+6JIy1DLDAYpegZKRjlIr2qXZRKVIgS4M0MwHMpafQEnEDnlGpL4uusHCAG8N8W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575064; c=relaxed/simple;
	bh=AFPMXYM952CeZn+6Ksl36QVco5ORZ9O5pGTpwuoCQ8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj8/O44npIvK9KXs08kR3/BgzK6eBsXm2YKhZKY47civPoczd85pRGhX81MZ3MfORFih8wiTntY43+GWWIQS0QcTGeCIC8qB3SOvn6ePfPWf3ZNsHjQfMhvwByFy/0/nRUIW1/3sGGzPc67OuOvt8eofVk+CksE8pZUioIJt1/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=q490xa/o; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="q490xa/o"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e27035206so1041549b3a.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575062; cv=none;
        d=google.com; s=arc-20260327;
        b=QdaT9i4uou5U1D9VYFI2EI4BxToocrLBVJJ/iIaROA2qX72L82j9UvokZJUcoSmPf0
         lJC0FBpXGRzQ31qaouyt5i9xSXARQTx83SLwP9elMviAOts8+unQFk5iVbIUuT4cak+w
         fgwnTMs7v4jsRG8M6PCmlvVTDe81EpFCyuikNGxCwuGG3SJbniOQn+6DVZmvkMytxjl/
         jZOD3UW1Hbv9jPd63lRXcp5lEHfprcI2yrKXTGbGsiNryCm4+2tXtxWhrzoV1xbqQh3d
         uVlSEw+uFU9tZoVahvWkeeWWQWtdSIY34C1VmFx/I3JGPiHvsI2+RhYGyTExpQNjHU0c
         t51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        fh=SdwXVGSB8NWOrV+LznqoN6KV45LfSJiq0U6K5vCfo6I=;
        b=g9SJ0KKGOuArrAAkSwdAsXIr6ygg50NkpkzrAj7bZtRbeZeUhxBzwkyf+qfLtoyNmn
         l0cOKIrXRyqcSzwRtcYCsCi9prIsKH6zPhydBrCJ2TodrRxbrL8HrdTakkGvNS9MGPqx
         8wnYPIwU3ZKhPrYLBQXc1qik2rZZ+3Wwsjb9n1tar2OBRcAyG2+UMOT7ecY1+0EMn+Y2
         EySsuc6btgNRF9yteoK8aI8KuiEbsr3V/74oW+M3voxk0cH4oOsztCmKsuQ0QdTsxFEu
         WPkxQ3ve6WCbcOhAXDmVANFS+vev9BtFfitBcfpcuk16w/ADWZhgBxV3pccWGbZeXsaJ
         sPMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787575062; x=1788179862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        b=q490xa/o3ZB7pnEmNVEGqKuLPnH61YtL/mi5ngA5404lHPWNdT74hWYiLtiFqeqT4l
         QQL4+FWB2Xw+Y3QUpXTNHdTxUcsvP5sycWcDa6cbnNef1u5kHZxRfNxuiwS2en7bchqN
         Z+y2i8bMWC/xY8VluHvdwJ9Of0WuLpehpX9wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575062; x=1788179862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+zQW6HBQa1lN1ja3xskW7ThxwtJGSF8B4qtZOtAofw=;
        b=mxGApn6wSZkq2PF/9C12LNOfyrCFa016v4Aozn/JYtd6qUdW/7mVY5/7JBtNbFLptS
         Wo3KSwYdaPM3Xp8IvuiLDIhAp//7ztIPEfKvueMeVU8CZ+xtOYK7AUaxz69gIEU3dmzi
         DhFNat+v4PWWakMyE3WiNVC7erU2bszHZTyB2m1lGNkuwBD6t273FlJ4EaG2YJ6DwFjD
         /087PymoKr9kFEvyjIg9+SFLaYppGGHwzdXnEJ2RjmMLLVrEISKkNQImJ5EEjlZbWQsj
         QXyL0C//KBctPEliF7gTlz0aaDWO3DsP8jV7SVjVsG8leDmRhJJLWypLihIiM+o+b7p1
         ClaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6OsnnBUuM5d3hOPzQqHBdYFbpkv+UPSy1p9Aa0zL6dbE76wyu+eqjoP83AZwRR0GDt4oTymc=@vger.kernel.org
X-Gm-Message-State: AFuF++mpLKLSqZKSK0Ff00+mqGWmsd0DVEQnaeyLAlXMWd1euW/oqHhr
	poJngKbuoX6Lika7IHdCbfXxCf6tqSMoNW7votJvk3tjbIkQUsr8y9AFRMGA2Gb050s7p4Et58S
	wLyk45j5qcjyP/4uL7973wTOMD/Y+tzK5psinr4GW
X-Gm-Gg: AR+sD12hlCh0WLKf7nwdMk90UNpZUKO3QYtfttOfOFMtC0io7dhSnqfJqjpSFsdSanK
	WTDZEv9KSN6PvTaHkGYD28geM1gNWff24UjbAXhHQItVnEjaDuVY4Xe3Sc42UVFRVwv2/M5+EzK
	0PCbAK/CqpGgcgPes+/afRW9gQCdX3+sgiB2LOFmyzyeaA4kg+yp2BV3E+uCQRJm8KVe6bwRMMF
	kCCc6i/6JPoz4Ei4gWqhFE2GkZ8OlcNefEN1Fl0uHzGgQjA3jYRHiqs8d9mqk4bZUIvuE+s8uVj
	vXUSJLM870HcAfi5BMXkagAhsh/+zRAvcA85aSX1/w==
X-Received: by 2002:a05:6a00:139d:b0:852:38ff:b4b6 with SMTP id
 d2e1a72fcca58-85239000a70mr1261001b3a.17.1787575062221; Mon, 24 Aug 2026
 05:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095742.68511-1-jhs@mojatatu.com> <20260822134401.6545e4eb@kernel.org>
 <CAM0EoMnLnc2dtzRyaJs+V6Niq=39OQ=p-XC7M+FMTQ0ctSvmyw@mail.gmail.com> <20260822160234.7115ccdc@kernel.org>
In-Reply-To: <20260822160234.7115ccdc@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 24 Aug 2026 08:37:30 -0400
X-Gm-Features: AcwNN1WFd__tN3SEBdmdHGbGryvUOqmS9T3vj_hnC4iwPbQb1gXTPHuTvm9wapk
Message-ID: <CAM0EoMm0orPkSuMLrpGMNkUATjmBPCvqWmKMEPQoYuYAEvCAQg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: pfifo_fast: cap ring size and account
 to memcg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 7:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 22 Aug 2026 18:14:49 -0400 Jamal Hadi Salim wrote:
> > > On Thu, 20 Aug 2026 05:57:41 -0400 Jamal Hadi Salim wrote:
> > > > +     if (qlen > 65535) {
> > > > +             pr_warn_ratelimited("pfifo_fast: capping ring size %u=
 to 65535 for dev %s\n",
> > > > +                                 qlen, qdisc_dev(qdisc)->name);
> > > > +             qlen =3D 65535;
> > > > +     }
> > >
> > > Why not a hard cap?
> >
> > sorry, where to put the hard cap and what would it be?
> > Or maybe you misspoke and intended to say "why put a hardcap"?
> >
> > Or maybe in this case probably safer to just reject the change if > har=
d cap?
>
> The latter, I'm asking why not:
>
> if (qlen > 64k)
>         return -EINVAL;
>
> To be clear I didn't dig into the code, just read the commit msg, so
> maybe you have a reason. But the "normal behavior" for out of range
> params should be to return an error rather than silently clamp() into
> the allowed range?

No real concreate reason other than the thought that it's a device
param as opposed to a pfifo one.

I am going to send a v2. Will switch to similar to what virtio does:

  if (qlen > S16) {
      //extack here
      return -E2BIG;
  }

The followup as identified by sashikos is on tun/tap - i have a rough
patch, untested but there are others ahead of that i need to send out
first.

cheers,
jamal
