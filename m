Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795762625;
	b=qaU7s6w8ahZn/psFdUoZaW2rq/L3EZqeR1UweKidXeDaBeyeA8fSa3WYTUqhTB3kBtCT
	 7jZsdlpVqGtRagdKSHJCg/ZIedNYhpPZfi+JH15htE3KdTk0ER9M3QdcGsZR7FxCEre9m
	 M2vGVhRjWP+mexcQX8/ucoI+EmawbS047E0UAZx1XNDUG1J8lL0DtSxAiZFDRzyd+sh1d
	 5M0a5GrlLXmAxVQuR7X9XOsmW5hRljrRB1hdFhtVwWAsCQIuu40uJHzqe2W2NgI2S1kq5
	 Cmf2f8dnBJPqGPcufNjl5WWmxIs/fNO/LyxzG3H+Uk0NYkAvVrHKcIzDFCeyv+o97bQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=xtP74/91kssCH0Qff0HXkuEOoBFjw5vBR+dpj+fyRmg=;
	b=TCUSbAP/zljAtPIEZtAirK/E30+gA+oWI9sThU0XEvxLIQHMenrL2jN3tZV+PqIW4+Z2
	 lfDd2XS2XCrPKXcmbsmWlXqE1JTGbHtMP6zZ1VzdL2vcg0z6R7h8KkgZpmbsQxjyounz0
	 CtNAOznTfvTZmHPIgy+u4xUZjZp8S3c/hLnwDo4JZoNdnC2+Q2Y4GKjUo/nqtKFsGHLjj
	 VoaAXcGLc8YneFrplX1RfAq59xN2YRrY6uRrdurdE3ejisZpk5C/Xm+ru2AhWdPqX6pB3
	 8RvAdCG/gnAcGt8LAOezLeFQCnKkS08qNW1cs4NQytvDOXcMGCB2dYC1BKCNuG19HMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=As7hWfBp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B137606A334
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B137606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=As7hWfBp
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4f4095a7aso67350377b3.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 22:57:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795762624; cv=none;
        d=google.com; s=arc-20260327;
        b=Mko82QHaCym7Ttk4+cgsS5lFBO6ya8g3oGz19YJHfxuxlPgNIkWIVhyYVqqpXRmWZ/
         025xhhSwjOmrc+ezuyLpxdXxzlgBz0XUlVhZcsIddvfrjr6Efb652l3CLz49x1qjeXJ5
         GMr7lC6H68cJ2FYhDGRbyAxzpSw1d/GQtFsi6RfxLAvVYoqmx4juAACNE2kv4RorgzpC
         4xWC6R4yXgjbSZWnyhMZOkGIzsPTy6g7rDsYrQGzJWBLE7cjLsWsZDrEAskdJ4yRmB+k
         AeIKPS9dmgXY4aAWwcvABNajdp/yAZq4m5CmPduVHaXFlyP6mIeM3hAU9gHWPD75FC1R
         zjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=xtP74/91kssCH0Qff0HXkuEOoBFjw5vBR+dpj+fyRmg=;
        fh=jQFHF6sZb7lePkUMHOV2HGjT1sGUBL5aHicLHIgGdX0=;
        b=OwccUqrFMVXkI7llWdPWECKDaoyY0+OHGHukmUfTfKM2aKAJHxLOKJ9LOXvqPgCUF0
         3gscooOuG6uyDI15F9M1pYgP/85ZbJ6XcB9fPzf+EAukLj9dTJ+rPNh3u0uoy3wJ1EFv
         OkV+xz3O9HVSdbJgH7RNdwjcXa7pCrKBji/HMZzH68biyM52Q9dEFaHBik4+HLBGEEEh
         emwhGkXP6AQ9QAiUpyAVz+cRc0NAsHvpmlqBWAxMxUA0mYXpZpvjP5hG0+W0+H42IB66
         t1F1t1fZxN2JanTuz5sEN85ZUtLtMnxoIPqibjdFxsXumwFSk9osJgH9eEvymU2KTCtK
         mFBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795762624; x=1796367424; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xtP74/91kssCH0Qff0HXkuEOoBFjw5vBR+dpj+fyRmg=;
        b=As7hWfBpQsZfqp5tFNochpVJmdJJmcOkohP82M+4BMWJabf3g+XOrmmWzGb+eoEjqg
         ptNLgbdzNRH+uZ3n/6ClH2WanP4zRz0eeG0Oft7pYWw+6tn0j3Lj1CDKQqey/43OeCOE
         tWXWypStJSUpajRjFoUwUgZ1DnkAjBmLZPfpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795762624; x=1796367424;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xtP74/91kssCH0Qff0HXkuEOoBFjw5vBR+dpj+fyRmg=;
        b=BtIWXme8RRk6cv5Wok6U9GYSnDdkxFmf8E3/QF54HqtjwcpsIglXJwLu5AaeOgoGLu
         LbE/OVOcSUHPl8fxvRiVB3t7ONJSxQAYK+fJjQpvExMGHvCeCOu1+KbW3SY+j4xHVTZs
         IYVlB61DAyrak4kdXh9LRJYUOSFoRR85EGy+Q9VCp5LX9EK8cz2rt2Q5FRfWH/iImwu4
         ItBXeaS0bMt7xo6rt3lUSvjJnOPPT4SPqa1/v9h49sqNB11a8UYLdxO6Ee7wFIHeraQg
         Pffoj/fu1XBSLKLQjUd49tVuFUq5UBzXDJI+XinGfTVQ+tdhMaWvidraaBlPITy6ieXU
         dtzA==
X-Gm-Message-State: APuU4Z/ad2BiKy3vVIny13YmTvmtIDc+4V+p4ktM9ztbBcsg2Fipi7iP
	WRAiiVkHQE2n/5i+MflOryCfaZDhEe3F+xdaZisfbl04HEgg5ufZ335ijIyQ66CQ+eTr62+rjHP
	/sSzRYM7OCUve79TSJPYca6Ro46FwExSeByNNTGIANc6vsyvqQNx6wiiE/A==
X-Gm-Gg: AZFdTZeduaRvnUDurLLEiBKQL1KSr5obvrJcetjp0k1v1XmQwj0bZoehvduvEddCuT+
	Vg/nYYFs8Q1JOt16BLf9RYbw/BSBFCOlYZ+1MsAzV6QmJ2Ibr0bk66NpY2ry0kdYK5DCPODOhbl
	DnRdzvNt48Cy2OAtw2nRkD45SNpi30QJIa9VPoKbb4et8u9J1yl2GBJNO5qpmeNhKpqTQBJKBvL
	2LbCNqhQ26herLnqtcoBYxI0DHwm/EXnUk+x6a6pdw3bcMRLNky36mL60Ncq7YRMui+/hCWc5+k
	KFTw5t3RTA4Icd3yb0pN1gJnSk6iNkapTxru+3LRSNbb+Myju6pQjoGPK5sQpu1Oqp3PAnGo5a5
	19CmWeJ1IWTCenHnUU1IHquu/VLH7hHIvz9MZqtoOUCsT2Mz3zriT2uLeidpPfQCm3B8qfSEK1B
	Y6qzdOS8uA6uFVZYDuyoFZNYoW8hz1MkrjEAeItPOqzbXW9xJZrVfXzcKqCU4ULOl6FnW096C2b
	LgCCib30c53VhzDAinOvJ/GAfnRNbsFN8Ja
X-Received: by 2002:a05:690e:450f:10b0:67c:1dca:80d with SMTP id
 956f58d0204a3-67df445ed83mr7805240d50.69.1795762624118; Thu, 26 Nov 2026
 22:57:04 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 22:57:03 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112605-alias-passion-6781@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 22:57:03 -0800
X-Gm-Features: Aa3M54rSGaUSu2OHIwJL_2sgdmjpVHJpxrDM4HPMSwXHzj_4cvsrUs665rIZ2iU
Message-ID: <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 12:59:23PM +0000, Greg KH wrote:
> Same with these, please provide backports that you have properly tested
> and signed-off-by on.

Will do, thanks. The netfilter one is out now as a tested backport with
my Signed-off-by:

5.15.y netfilter, a81047154e7c:
https://lore.kernel.org/stable/20261127-so5-nf-515-v1-1-ce02c323f842@certik.com/

I rechecked it against v5.15.226 the same way (SHA reference, patch-id,
subject, and later reverts in mainline), and it isn't in yet.

The other two:

- dmi-sysfs 18e126e97c96 for 5.10.y: dropped. Getting it right on 5.10
  needed new lifetime handling that mainline doesn't have, which is too
  much for a stable backport.
- arm64 ptrace pair 88b839ce497c + 5306f124f317: on hold. 5306f124f317
  was only queued for the newer trees this week, so I'll send 5.10.y
  and 5.15.y once 6.1.y and newer have it in a release.

Best,
Dickson


On Thu, 26 Nov 2026 13:59:23 +0100, Greg KH <greg@kroah.com> wrote:
> On Thu, Nov 26, 2026 at 02:41:22AM -0800, Dickson Wu wrote:
> > Hi Greg and Sasha,
> >
> > Could you please queue these upstream commits for the trees below?
> > They're security fixes that newer stable branches already have or have
> > queued, and each one cherry-picks cleanly onto the current branch tip.
> >
> > 5.10.y:
> > - 18e126e97c96 ("firmware: dmi-sysfs: Fix null-ptr-deref in
> >   dmi_sysfs_register_handle")
> >   CVE-2023-53250. 5.10.y has the commit it fixes as 985706bd3bbe, and
> >   5.15.y already took this one.
> > - 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
> >   syscall entry")
> > - 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
> >   group-stop")
> >   CVE-2026-90347. 5.10.y took e057b9477232 and then reverted it
> >   (ba8b9a906d80), same as the newer branches, but it never got the
> >   replacement fix that 6.1.y and newer have. The second commit fixes a
> >   warning the first one adds and is queued for 6.1.y, 6.6.y, 6.12.y,
> >   6.18.y and 7.3.y.
> >
> > 5.15.y:
> > - a81047154e7c ("netfilter: flowtable_offload: fix using __this_cpu_add
> >   in preemptible")
> >   CVE-2022-48976. 5.15.y has the counter change it fixes as
> >   5345d78ae64d. 6.1.y and newer have it from v6.1.
> > - 88b839ce497c ("arm64: ptrace: Keep 'orig_x0' in-sync with x0 on
> >   syscall entry")
> > - 5306f124f317 ("arm64: ptrace: don't warn on missing siginfo in a
> >   group-stop")
> >   CVE-2026-90347. Same situation as 5.10.y: e057b9477232 was taken and
> >   reverted (7ec6eebb438b), and the replacement is missing.
> >
> > Testing, on v5.10.275 and v5.15.226: cherry-picked onto the branch
> > tip, W=1 build of the touched objects before and after with no new
> > warnings. The dmi-sysfs and netfilter picks were built and booted with
> > x86_64 defconfig plus the relevant options under QEMU/KVM. The arm64
> > pair was built with an aarch64 cross compiler and booted with seccomp
> > enabled under qemu-system-aarch64. I didn't run targeted runtime tests
> > for these paths.
> >
> > The list and the test runs were prepared with AI coding tools (OpenAI
> > Codex agents, with review by Claude).
>
> Same with these, please provide backports that you have properly tested
> and signed-off-by on.
>
> thanks,
>
> greg k-h
