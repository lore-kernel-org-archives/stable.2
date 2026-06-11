Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403530BF66
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202397; cv=pass; b=H0W2YhPc6vR0NkHjBs8u4CdTJO8Ws2swQfFeDgLirOg/mwW8s7TzKxhNp+BDqlDM3nuVbWJD41YoC9aCxk6eJOIwtsu6+tykBhJTRiwGHii4ahqzCZ5AL+Jl28Og9xvZduWNtp+hrVv9ojnna5LTlVNK8DfWmpaOk3CPxWQALac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202397; c=relaxed/simple;
	bh=itDhPXr2ym6uljZNFH7ztIm2NNS8EYC6wS0LUwCLuIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLH0BSTs2/3IHOPxm12zUxt1sGXm7HKZNGahOmmDdaM5fXsAomUSoqQEbvBHjfmfnkcSLfDzQ3H/EzjLnwHCn9VRGmHkQuYPYqNO7kWcnBDdxx/APPAwcANt6uOpRgG1WMFqcIfmX18o9YQEUQgSmWskUcRd0gDoLz4MgIekfG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtfNN5vE; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtfNN5vE"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51765531803so89221cf.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 11:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781202392; cv=none;
        d=google.com; s=arc-20240605;
        b=Ml26UfOK627Y3nwBvB24TozTJLpKSWJUC4n1Ju2SmAVMSgYvi97kQBkLdtm6wHDXjb
         9WpsagERT1YS4tH0H5e9QCl3b+fILi67pl0xC7pG4xBPWrjHQ1pm0vgL2GgVthL75OPW
         kznO7IhP8AJ3ogXb6OD1OeDmUTbF6C4m0jSG03XHrl2QoXHsJYPbS0/ilWlkktcv/CMd
         d3lThEuJWyY409R1I0ZWjB1o2FCA8PnPWWH4DGeBjUTMXwv7U7kce8ZaqdY3eAF1iIdt
         fEYljFr0kmccdb5ykA/XSdBZ7uZIoAsG8IYp43YNvTnHnP5JgTOuhrpufS90dQnJOvex
         yE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        fh=JOWjdt8JhJo4H7gUCeoYX2kjLw/H2MvKsOQ6iGHTkyc=;
        b=DkZmM+dyAUS3AaEu7cwnSAP4CO3yb5NNR7YIukQmIx9Ygcgcklmw7Xn2HUjmp2OhuD
         Ur1zzf3SFEFXKylw4T9xkquEdjDBZ0qJ6fQa/muYd8ZBTLiIUP3CiSPfwi5yXVIzQK/Q
         bXRKTnJ1I2yFhZsrrw0aVZKxkykaMyQH934F0zwBuToEsUZ7THL9TETviLxvEO7ehU1L
         26C7LFGClPtFoW59VOz4q4maAhtAltiEbwaNRKFuY2lcCrdB3ItcJOJf+N8e/KItTxQ/
         hYM8AIQ3RzvMXwMPsxM3KnwUoATRG5oi1PhE+MmGi8pTxiMid31tDVDsGIsi8LQiOgP0
         cl2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781202392; x=1781807192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        b=CtfNN5vEAglz/8F5pdX68J+4E9uhHfYYmwGU1B68Eu9gVtKL6Y0oktf5KbBNyq2XTP
         tjbyCvLWvsx3apKKKDjs4bGRz9Ze5bepSWprMJoa/zDg5FHI9B8FcIw9aXCfaGvopZEr
         Qq9F3PzPI2uBvVia9D+uZXQvmqALavDO1QTte9X3VAJ8u6x46HwE/UrNBTXQGOazrNSx
         Vwmtimj5BTZjJcdc26JLPUfpDWhU/en+kW5xFQIx9LcHNnVqy8ff0n+zg2Nw1ctlsjCx
         dvy4Ab7Lj1W4yrA7EZmvAdiUJ0v2dp53FiNWm9/z5+kFlwYhMkcJf83KpvAbR3sbOf3B
         +19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202392; x=1781807192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjO+U1+VNdBV2gUvNtl1hA8qIVDLyU6x+S8pv+zOymo=;
        b=LuPKcKVbKQZJiSeEdrxbzHH0ncNyuaAF7+Ek4z+pRepLNaVQkPhYZ3e6RQikvfSwZG
         3sA5Rb4XDuD/zNnT5qDfMApaSJ76sjkdyYKYhyutKbCI+B/bPdzZEUbPjKs45Zsc+0h2
         O/yk1+uS5oA/lpnqMwfmsY4KHf0OZynMLn9QXz+o0BBE6Nx1+CBBx6xcc00Ie/6PG1yH
         7ZwioLRTi1n4fQJ7Xd18sXe8s5KM94RyTktY1/A++JOQWPjGJR7uVBNS4sUJ5pXdZHm8
         FK1X31LqJCH/G3TnUSJvLfKB3nDPkBJBAdkYzXDlDscgGA/N+1wFGd0R+L6s5oWwPHmj
         p0tg==
X-Forwarded-Encrypted: i=1; AFNElJ8vllB69kCcU9VzK7GNQeFJzYVFKhC+5Oko1BDlM2xIuoVQxSisMz1sdkUaRgb6TeIb50Ia9O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VXTq9udAMvLg41GxeFPi0761QOh1jfCY+RaCQUm7fRX/6kyp
	Px9bcLrtH52CUFLXlsnzm3H3ruF1ql8NiD8uIMqrE8P42DPWg30Uc2qkjWHT4iWN7ulpv/7gbEX
	NrSLRJwPe6zDBo8rlhEMOkV81w4oKHby9cNUnUsA1
X-Gm-Gg: Acq92OFz2hookDzqBovAULEzaH1p1kpGGh7oqNv/XamWJzFVzxMV6JaPCC52dZONOlK
	FzyI8r1R+zEliiN7WyNzL+ruMoC34fdLJ7shSiK7jVAtGDYc9QdKIiG2UENuUz2tbUpbbq93U+z
	pI8/B4YtXA0qYY0q50V3NFZUEqSVBEJ8QxdaE9DeV1jUDaXC/RfGv+SCsWYRzPLlg6MMjQPT49U
	wAh2u4MCL5uylvh7/IqVR/dQe6WtodeBPVLXefOa00PYqRDENtVgByeN5LWl3raVAq7UlSlKk2T
	pszfzk9W1BDSnVsE0JchKXxS1B9H0qf85O4V9g==
X-Received: by 2002:a05:622a:130e:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-517fb08448bmr937311cf.16.1781202391118; Thu, 11 Jun 2026
 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611002437.1671401-1-digonzal@google.com> <b601d0d4-d472-450d-a966-e18c9642a433@intel.com>
In-Reply-To: <b601d0d4-d472-450d-a966-e18c9642a433@intel.com>
From: Danny Gonzalez <digonzal@google.com>
Date: Thu, 11 Jun 2026 11:26:18 -0700
X-Gm-Features: AVVi8CeVv_8rnqLZqyyC2rJzhiRpf4iydHkPcuGojuZUr1GdzQIsaDm1AuaaoYo
Message-ID: <CAH1CuA-zQveU_pzopVMnDM11Kbz8wTzMP=SvSDBEq8Tk3RaebQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: decrease statistics refresh interval
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:57=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Danny Gonzalez <digonzal@google.com>
> Date: Thu, 11 Jun 2026 00:24:37 +0000
>
> > The default 10s statistics refresh interval is too slow for real-time
> > monitoring and causes network selftests (e.g., uso.py) to fail when
> > verifying traffic immediately after transmission.
> >
> > A 10s delay also causes aliasing in telemetry tools polling at shorter
> > intervals (e.g., 5s), leading to inaccurate rate calculations on
> > high-throughput NICs.
> >
> > Decrease the refresh interval to 250ms to ensure fresh stats and fix
> > test failures.
>
> Have you tried a bit more conservate value like 1s? Wouldn't it be
> enough for tests to pass?
>
> 250 ms is also okay, just curious.

Yes, 1s also allows the tests to pass.

We have a preference for 250 ms since High-Freq Telemetry (1s poll)
1s driver refresh rate causes aliasing:

# sar -n DEV 1 | grep eth1
10:52:15         eth1    390.00    339.00     51.92     55.54
0.00      0.00      0.00      0.00
10:52:16         eth1    409.00    360.00     54.72     58.64
0.00      0.00      0.00      0.00
10:52:17         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00

Thanks,
Danny


>
> >
> > Tested: drivers/net/hw:uso.py now passes
> > Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> > Signed-off-by: Danny Gonzalez <digonzal@google.com>
>
> Thanks,
> Olek
