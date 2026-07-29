Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BD39795C
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335989; cv=pass; b=QDyIA/QCz8K5fTQ0QP2b7c46+q7qY0GMH7mwB0odVsUBsrQgQwoWXPXWcAiY+9nBExYbR6FyUKA/Srox0x5hq89t5rwTxD3TJEEBYFu77CMILwH20T5eTXmRHl1V2JZsjm8IoPec+pvbcZeXQ9AAl1t/S1RJ6r5XnnZ9g6Y+1H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335989; c=relaxed/simple;
	bh=cIN/nt4h44AlqFXT+2f3q6mTYeKxvBMsv8hKikFaCh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv52LQWZRq1sL8hqGlxktZd7QLtCluQj0T3rmExV4/EUiMAPlW+Ae1ZnMfedrHOckXCFwGspxIpL3hual/H6W7lK5z6iIX5silZyGkcD1YY4K0SrEyBi5lug1AV8bIGq7AaSy7phKtynbVyr796rX4+2Ho+v5ztT/HB8ACVD6Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyDovkPZ; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyDovkPZ"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so1019224a34.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785335986; cv=none;
        d=google.com; s=arc-20260327;
        b=reMC1ZRTCEIJrJichwObVeNvEZbr1eqVQkEoo9PPV6xEm5U8reaz+70Ip2GRegnBs1
         R0joBhgFTbDTMQxC6sLbxGRfLXBidU3BjxUnOiaDVVuTK5Y9ZG3rnnr1lfuvHSmLd62x
         V20x0SotOGJUMOdI9g5wl8lbUPWjLU2kdavpGof6VntyN/YZc6p9NGn13EImMlLPfOW5
         dGxMu3Mdyfm7+gMpYujm2beV596DFcYg2NWel3CXJdeLO+ZuHoPY3Ksd4E8G2Oc+ZazK
         GAIDow1in+tg/mgcSgBIeYCCPSlHoJcUuIP3ueIMh5fE1nt1dfM1b4pEP80pBTJsyp54
         koaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        fh=rhAhgq8ng+57fVvTHfk7qABAfpJYFtyLWxYTiuzXmdA=;
        b=DoRReWNXJ1Irip8uZMUdzqFki80bBOTdJHdEm9FZ8fszxw9Cvc81Bpj7PsQG5e9OrT
         5LI7fVH0UbOGs3uuZ2xR5jdhfJPxsqwg9Qns2vKY3RF7MZzfKHSQyVr4H/HU+IgJlCFX
         6RQzT4jND8zZk4D/MKlefFJD1TZ9oMx/pQsiv55eHz3zsj4yjjN7RKkeJHx4FCVUjO5p
         TwUXvkgDmfvu0GBrVXp6tXc8ATb3rk4EP+DMOrF2CLm/qGt7pFzzJlG4pw7SSy+MYsU+
         OBAkokXKJBEMHvKSaHwJfVG7T3wIZNCwlEBktHotrHM+Xf4Zg+qD7QoJuAEipSnwl9T/
         wYOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785335986; x=1785940786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        b=KyDovkPZtY1DM8adNsWhuvKeuy34HueE0D5IimLZtqCUEHF79OcDlOZSUqzM/PDh0Y
         DGAGtn6WPAzPfMtU/2M9UQZZtjzqj8aoBpSylmkeTnHAZWv/rTWWakaN6LUeTL0M5TCK
         wHbJ/0ldRqYNf61XvZMXFEUU2CP1nQYyWLDBB5DVwY/9FdOHATo3QfhhAdOGHhkcMiQX
         gNyIBPG+WvEOzqgG3/jYgyP1bu3O/8kyEmcSHFA1sIV2+FPvEYwrKLhChrEs41N9mz1q
         0Q0aqB58ofALzL9TMpIBH+S0HLX88EEBM24AICzTLYyW0XDQDsfe3bkjbnHNNROe7BYw
         dFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335986; x=1785940786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACwil4Mp6DdzMJNs08XWd9fqP5I4E2mCoEaZK3FvK9U=;
        b=OXHdhtLVmffZYi57UkCvWzUEv6aDSp33oH6aF0FeEYQQncQVZ2Izys0u5/6XkD9ltQ
         bXIxkKoLNW7zUHwqoyah+QeUn653XMHTNemzh5H91rIerdu/j3boVWyYyr1wIWg96BQ7
         v8qTbJ1qO5D+t+9SkSVtacBHi9jY8mxxURyqt4I2LGInlJcP1gLXNhBm24XK7XVLiedu
         NsXnk9T8vOyOu29LgY6pcKwd6FrmmG8n3VQQvh8+AfzlJl0UuHCAgInau7sya8lYv6EW
         nX9XfZaPVuvMXg2mV3SzLgPjv/1GHyKZQU6Ri0HggPaJmY/2W8WwgKdMKEsFCLhj20xY
         BzJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyZj4C6XjqBVoDCCAC4bnH99sAxvvdN5JdvPwHrBZAq/66nLSSVqipSFyH0z2KYaOPkaJnRPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9VSU/R6LBjswDCb6OfW1cG/opM8+otdy7bkWmDNHXne0e1tv
	yt4o7pDIZLk8ewDrJuF6oRR970AC+I7DTzsq1FZas3zZqjpVMk0azI3DfF+kJmdlXR542mEk4+S
	BnjBSW7XIjOxYOp7XtdWc6levBMEeJ2E=
X-Gm-Gg: AR+sD12/FSlGvAjHWaAhWh730b9M4cbbMW+y4/vLqhrzCZdfdKRZ8yzQghlHzQtkxIo
	JWojTUIn4To2nTWAdb0gsuHNSEi54uBawSk7d0drqpYroXWmnvD7Ouz+ozRjmioTdiYueF84b8i
	K9DkaPaDIydPS/2+orkr6lQnw+F7fWwCxc4Td6ihXldt1izbnByksOhcBDRO4RLaM988aUbYz5l
	xkxYi0JPKDaz7lkGKE+Izf66IOJk8UPglOj1TWlekX2AZVr4/QIR+ANlHkb7YRnm2HzH0Zpci+o
	ykDL+4VzVVs4iz7u60JNPLSSmtEyNSdYXkeW8hNIzz+3/cU=
X-Received: by 2002:a05:6830:2696:b0:7e9:b673:cbef with SMTP id
 46e09a7af769-7efff25f6bdmr3854282a34.17.1785335986490; Wed, 29 Jul 2026
 07:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727105059.75716-1-spasswolf@web.de> <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
 <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
In-Reply-To: <1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 29 Jul 2026 19:39:34 +0500
X-Gm-Features: AUfX_mwXyEa-LkEfVk4HaieHl5UbmaG7Jg2hW7wYSg6MeyPwuqLhhMt1G3fmyMg
Message-ID: <CABXGCsONHe2ST-==Gso2748i7W_POPiUAF2MrrmTuqoQr7z3gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	"# = v7 . 1" <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, 
	Rafal Ostrowski <rafal.ostrowski@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:36=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> I did try a different approach, using DC_RUN_WITH_PREEMPTION_ENABLED furt=
her
> upward in the calltrace (This would have the slight benefit of more code
> running with preemption enabled). This does not work because dml21_utils.=
c is compiled
> as a _LINUX_FPU_COMPILATION_UNIT, so DC_RUN_WITH_PREEMPTION_ENABLED does =
nothing.

Confirmed, and the chain is worth spelling out because it is not obvious
from the call site:

  Makefile:1127:      CC_FLAGS_FPU +=3D -D_LINUX_FPU_COMPILATION_UNIT
  dc/dml2_0/Makefile: applies $(CC_FLAGS_FPU) to every object under
                      dc/dml2_0/ ("Add FPU flags to all dml2 files by
                      default")

so both files you tried are built with -D_LINUX_FPU_COMPILATION_UNIT,
and in that branch of dc_fpu.h the macro is:

  #define DC_RUN_WITH_PREEMPTION_ENABLED(code) code

What I think is the real problem here: in the same branch DC_FP_START()
and DC_FP_END() are defined as BUILD_BUG(), so misusing those inside an
FPU compilation unit fails the build.  DC_RUN_WITH_PREEMPTION_ENABLED()
silently degrades to a plain call instead.  It compiles cleanly, looks
correct on review, and does nothing - which is exactly the trap you just
walked into.  Making it BUILD_BUG() as well would turn that into a
compile error.  I can send that as a separate patch if AMD agrees it is
the right direction.

This also explains the asymmetry with 183182235f6d: dc/resource/dcn32/
does not get the FPU flags, so the call-site wrap there expands to the
real thing, while the equivalent wrap in the dml21 path would have been
a no-op.  Another reason to guard the allocation in the callee, as your
patch does.

--=20
Thanks,
Mikhail
