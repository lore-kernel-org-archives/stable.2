Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198757;
	b=TiRBqvrYKRUzYcexuen1e/RGd3FeQhEPzuX4g320vsGPHc37kYMo3/ajJGK+VSu2bFEY
	 WMOkexHTPnM2fYiLH88bNGedwRFA9XUpKy921Ost/2lxrkC5U2YAdqSSdTkRG3stbbOsq
	 7jEtCtBaUUeGW56DyDnljf9sv0WKTolKLorZZZzt2UHySy6/+ZfHWQOuv+kYxlYFnztav
	 d0QAn1tJLwkIG1CNPF78wJTeZhuwhwP3hhuWlSIEgMICMV8E2R+2fuj/NAvzFadR3dcTM
	 EG3LhG+GaTZB9aEw1gf2MfiNOsrZS2rLMxv1KzLN0zTRzTZkYTsYORqCsvblAFCLmTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
	b=DzZx90k7VKbiWZ51YnLqr+EntmS3xvasj1F+d59++XEU0LtI4/DBiFLIVAcWREUJ6f+d
	 BkHkjxhqN6KUdp37w4y7KPqcYizUz6I+te+zE/PFhA5MihxJ0eCPIfduo+d5B//KZ++xx
	 Ua8DcFrIxsv5SR6t+B7mAtxxM6iY6mqbI9EFlSWlU39TzXZczM8XU/DWJlnPGwZeACYku
	 dulB0A54tjBqbgckI2sbtFqhbXn7s3LGQhmEj+K5/aSiXzBoFNhohMgTv6HCvF4Lee/VP
	 u/SuVsXiI5wFZT0KGWZ03qnpK8Z6HiSs+WhyA6O7rp3vK8vyJN9yUOCrLDNAwHR/kcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jidg5fuu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B23606B45A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3B23606B45A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jidg5fuu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f03eeda984so6613795ad.2
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795198756; cv=none;
        d=google.com; s=arc-20260327;
        b=l5ITRuM6tKmcB5YyQm8psdOSpYd6jEmKXTjPlfMNOuFqvw16y3fJRjfYvWbWC/ruF9
         bvF5JMn/rexyApap+QEuTO2kxmS9jKuD/FO1vIXFBgLpx7Pxy3gsxeaP7S3NHIdwHt90
         vkkOtjDwtwx9zmPeEtorIp04z1RMWYBNpD3bgN4+NtsKgTEvc64iDV8yf7J9WbFEP7lJ
         qHv4zN+Lt21KQX7LAgP/nHMQYR5SB3NyPY+axT1oeRZ6XBG++3EsKMgWGQh9X2KJJ3RV
         lpEXbGVtjq4SSJuX58E9GSDWKECvm1AyPnZF2i4jhO8WM+SY94Yav0CC99tMIrxy3ekI
         MMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        fh=GSOFc+K2/q2SjYtqgPX9bdQ4pQ4aw4Knh+JElPAo1J8=;
        b=QYQaCjZQJZc08qx/9W/mQlkSkT0NxDLa8vTgeMtsUUuUQ6jAza7WddNQJ31DasLIDO
         CyhxUoDNp7iKbeTtsfcAP1vcbolKmS+T6fy5v9ysSDMfJcFz6Yp1mS+WRhCfo1vY2L8M
         zVtTiHaZYiPGVTWRbSZhCRWTBWCkG7O9lwjRFfyEYz5MngYQVasgwaSmTFYkD18RUWJa
         QFSFjmBSiLa3hPT24ktV+6WULl2iEBKV5Eutb2ZtU8JeJbwl+1yFcq02oJGiXnu4OljK
         cwL3srmgRq94cE+qTMoGrP9Hz8f9dQQN0MGf1TrcNUEZm7meO8SticlEz/az0zDBAYHZ
         5uCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198756; x=1795803556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        b=Jidg5fuunw4EYR2XPW0aGeaUC/aLy/87pXylqQM2qNsBnWLsRXuxtBxCVflPQnktTn
         hj4sEnsZUI5tPg6rNDC/LBV+MypkICLLZqDupAQ3ZSGb+bJJCn3RxaD2iuXg7DzgLe9B
         es+HuyxxEGbCyQTnPvstiytEHyGjLNHAhXoDUWt5/0Wwn/F1Md0JV8r7mbO3CSKJ7FS+
         8ZOI6B4L3hKyoZrcQqna1wQURNlHm9y8MRmksd7fLps1GOYBOPj88DJ1KqVPWVhYfsas
         q6Nb5hvR5BJrUrtAI1YdqxqKmW935zgajTuHH3+R7rqNHISifYXPc1xMci6MiSZus51i
         NR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198756; x=1795803556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FUYcrD2ChNOm77umqGfBpxNsoS7ZAGf06/dNNITF3g=;
        b=Wz1+e/apfEn2Eg8GlGUXdfLKTOGG39l8uzNhByWtVuwFhpNix5GBtYlrCnkgKEMn3D
         /dp8foXyLdXYXpZwjuFv3UfXu6X9WsnGfVbMHz6E9968cCaknXln6Rp0VFPX4GXh5Zcl
         wM9iGsQq9Y0WI7S4UhRpLOYE+8g6sSjbzNEX1ZlMG/h9g4JVkuiS2sUDRTrCdBj5YB3W
         l2Us+IX/IH2N4OqwMZQEX79NinqnSIG95K9UC7PpCxrSUN+Orrb+Kf5PbnBZHd1Och2v
         ZY5ok2Or/UaV7PgxeX8BbJnbDo3Br0ESYVy5jQspVtctjnqHY0v30HKJpvnJxAH1RPBD
         qTdw==
X-Gm-Message-State: APuU4Z/sp7v3p/d3WSWITIHaOCuePgsYgKyHLyo/JwmhX6kzMr9+K0Dy
	gBVp1G/eOS1b82uwHhAfdq40AJAMdj0396YU546kWjw5jARKDr7BLusywhd2dfp7s+Sz5AHlxCS
	RBHbXpEIcPNCzxp6985uCxRbhkm7j5e4=
X-Gm-Gg: AZFdTZfM8mHstH4Y3E1WMPSrootxjMG64Bp/Q+HWj6E3SrzNlozJQCboIpS3tBQjMaI
	04cdEDjtNjEoLXT/UDCXZ0l2Xtp3eTy1nPARkMsAomEmDyJm2YCMDXv45zpYZFnZAx3isgc3nR7
	R5Us0BiIwqn9fY35d46UeGKV1cIeGkaPoVjNQF6/vJd8JDtJUPkIzMzGs7cq9b/3OJqME/2mdjL
	Fm7DBEmk/RWCTgbE5nRjRf0UT/N4kO/53jLI5ZMY/NBs9mBia0s+m27axlZw9rdOwQ62uOOeUJI
	+XulOp4TW7LTgasxQB3l1PF9nMvV/sD//HondbTHwV8k7sTOGke+fqfhFmsJn0lAkkkvyfZHbWd
	296kxiavwogDGLuNTLIzLHTLaeCoOo+TMAcgxsFB2dF5QRTOVkk8Y2ZLEZmRcR854UCvx
X-Received: by 2002:a17:903:4b07:b0:2ef:de9a:e59 with SMTP id
 d9443c01a7336-2f03f1a1767mr37410195ad.23.1795198755912; Fri, 20 Nov 2026
 10:19:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJuRqcD2=42CTQk2PSHofSmt+=H=qKT-x-ZXD76TwVshaepBAw@mail.gmail.com>
 <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
From: Florent Carli <fcarli@gmail.com>
Date: Fri, 20 Nov 2026 19:19:04 +0100
X-Gm-Features: AclHuK_LqX6_8yrX27ovYiu2OgdiE-yTgZNYyoT5miAuxF8i1_t91IXeVajxW-w
Message-ID: <CAJuRqcCc-p3OYAp1Sz=qFPRLPgig=Vnnmemz-NsdER35sQHdiQ@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead
 of SCHED_FIFO on an idle CPU (fixed in 6.19)
To: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-rt-users@vger.kernel.org, 
	Gabriele Monaco <gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Juri,

Thanks a lot for checking.

> It would also help if you could rerun your numbers (latency and the
> starvation check) on current 6.18.y (64)

Done, with v6.18.64 built with the Debian 6.18 rt config (PREEMPT_RT,
PREEMPT_DYNAMIC, default preempt=3Dfull), in the same KVM guest as
before, 30 s runs, 3 ms spin:

                         max FIFO latency, late wake-ups (> 500 us)
                         sleep 1.00 s    sleep 1.02 s    sleep 1.04 s
  6.18.64                3010 us, 15     2998 us, 15     3012 us, 14
  6.18.64 + 4 commits      23 us, 0        13 us, 0        12 us, 0

Starvation check (SCHED_OTHER task on the CPU of a SCHED_FIFO 50 busy
loop, 4.5 s window): 4.7% of the CPU on both, 0% with the fair_server
runtime at 0. So 6.18.64 is affected as much as 6.18.15 was, and the
four commits fix it there.

Stable team: please pick the following for 6.18.y, in this order. They
cherry-pick cleanly on v6.18.64:

  e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
  f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
  1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
  ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

> - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.

They apply, but they don't build as is: both use rq->donor, which
6.12 doesn't have, so my backport uses rq->curr there. I'll send the
6.12.y series in reply to this thread, rebased on v6.12.118.

> Just keep in mind that it removes starvation protection for all fair
> tasks on those CPUs (kworkers included).

Noted, thanks. We only use it until we run a kernel with the fix.

Thanks,
Florent

On Fri, Nov 20, 2026 at 6:10=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hello,
>
> On 20/11/26 16:09, Florent Carli wrote:
>
> ...
>
> > On 6.12.y and 6.18.y, I see it run SCHED_OTHER tasks ahead of RT tasks
> > on a CPU where nothing starves.
>
> ...
>
> > The fix went into 6.19:
> >
> >   e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
> >   f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
> >   1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
> >   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable task=
s")
> >
> > None of them carries a stable tag, and only 1e0a2ba7afb1 applies
> > cleanly to 6.12.y or 6.18.y.
>
> Thanks for the detailed report and the reproducer, much appreciated.
>
> I had a look and I agree with your analysis. Comparing v6.19 with the
> current stable heads (6.12.118 and 6.18.64), these four are the only
> dl_server changes not yet in either branch. The other dl_server fixes
> from that period (including 115135422562 "Fix 'stuck' dl_server" and
> the two "revised wakeup rule" follow-ups) are already in stable.
>
> On applying them: with git am (no -3) I get exactly what you report,
> on both 6.18.15 and 6.18.64: only 1e0a2ba7afb1 applies on its own. The
> rejects are context only, though (upstream refactors around the
> sched_class callbacks that stable doesn't carry), and a 3-way merge
> takes care of them. With git cherry-pick, applying them in order:
>
>  - 6.18.y: all four apply cleanly, and the result matches upstream.
>
>  - 6.12.y: e636ffb9e31b and f5a538c07df2 apply cleanly.
>    ca1e8eede4fc only has a context conflict in dl_server_start() and
>    1e0a2ba7afb1 needs a adaptation.
>
> So I'm in favor of taking these for 6.18.y and 6.12.y. 6.18.y should
> go first, so that 6.12.y never carries the fix without the newer
> stable branch also having it.
>
> For 6.18.y, since the commits cherry-pick cleanly, it might be enough
> to ask the stable team to pick them by SHA.
>
> For 6.12.y, could you then send your backport, rebased on the current
> head? Please Cc Peter and Gabriele on both requests, since they authored
> the commits and myself.
>
> It would also help if you could rerun your numbers (latency and the
> starvation check) on current 6.18.y (64), as 6.18.15 is quite a bit
> older and a few dl_server fixes went in since. I tried to reproduce on a
> local VM, but I think my system was too noisy to see what you reported.
>
> Until then, setting fair_server runtime to 0 on the isolated CPUs is
> a reasonable workaround. Just keep in mind that it removes starvation
> protection for all fair tasks on those CPUs (kworkers included).
>
> Thanks,
> Juri
>
