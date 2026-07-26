Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5528231835
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785106466; cv=pass; b=jm5fsVIuQcSjYV/EixGDHN6pKYqaTmYecj0Fd1cJsICXpOz70MfQxz5lfOLeQL8cAB4eTxorfdSAOsqdlbECrJB+g/4/mGDGw0LdrIMqlO2xRa+JFV4oObXiu3ztwOHwPV7M9VStnez2ukz8wc0m2s+/X2E6qtfrWnvlX1XkSbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785106466; c=relaxed/simple;
	bh=INH7cEdaGCjwUK+4yAesdj50e1t5cbdHTGpMEhFfT9k=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrT1eVxJMBRT6ox3Aji+Vv14O3zZLDaWWnNx4Sk8zLa8UU994tTiBzlp0hALX00f0TJygHlwr67DjYYTmkqp9CjxEb0Nq21tANogAZplK6UuWewPpPNvLPDVyM/vx7aZNllsDQ2rsCy90nnqd0LcOMceE3BmfEVFmcFmO+o+Qag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=cgfh9UBu; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="cgfh9UBu"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e85499ffbso170219285a.0
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 15:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785106464; cv=none;
        d=google.com; s=arc-20260327;
        b=cUUv6CfdCHaqlPBlZ+bkX5VeeyzockN6tLPsTa+9iqrXJT1y0bQJGpEjbpqe1dfNsN
         ZZ5/X5AXHvQoiQZJ3pynpII6hcaZRi3InyZ612isx6pNDPGVCLuvcbA6PivcAZLnHcfH
         rAiBOOSMVmoFyWTTw2+4sHawjMWGN3qilow/gmUHyyzqe/FJH+IEqBrDBJg6ykLG0ipR
         Z9Qps2qwOsrkG3Zw24K5CAe2VcePvZMQ/Pc09LcyLasOYl5DIWu+2jBYXU/4kfRFogXr
         1iPBgz37U20We88J2l3jtSq29jD/lnqPNkkG4ysGL+f4HUQPW3hHsWhWCcxGBS2NEsLr
         Tbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=yGmhXoSde90feAqgXfhxNDvC05OmFmrJPIv3G3OJRH8=;
        fh=hBAIZPi1dX0n/ueQR77gRfxopEaI/iI9mrsL7HR5p8M=;
        b=sb7WxJomTm8Auzjw8Erj4APGs2ie0fA597g05m5qBXfgkm1UWMxrBVyEK+d2QJpVz5
         qr/kLxeQC00MncW5Q+0PwjpMBRPUqCYt3002TjcRGGeueXVpxO3ryn9WpUwkNylwW9fh
         L/TebEGBEaNYuEu+pzttGoZm92PTyKOpf6RHFW1FwVGf6WAkaFQLtX+aVt4gCvkgz4wx
         oeullZhCxs0h6EEv09XhschHdj5gIg7pIirLOt63//+0gv4Awm4vMvnQbbnWaEit4Rvv
         yxU1ubz/+Nj71QUmM01ufYtNzvUnDOLbTcpS7WPAO7t1+lotP/LNHR4UYn1D7sNGYvCe
         Xl6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1785106464; x=1785711264; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGmhXoSde90feAqgXfhxNDvC05OmFmrJPIv3G3OJRH8=;
        b=cgfh9UBumAhGpPmjmysjSZFym8NGhtIazbNJstC1tm4O6yXoYFuX9zKziFLw3bN5TZ
         P8lY8VBAV5pmrPEEeuzJ0pepuyeAg14AwbA3mmlWQzwnRhnNzQSdkHi8qMonW4di3sly
         WmNWk/wOBWOvYwccqAdN3yhxOB1KrFRCxhB5s9KHuIiXFi2B4Si19MYVkQhMwdd1h9uP
         XFWyrMZAFt6NsX7QOEkP3Ddfoh8BoehaJFugkyotB+mroEJ8sTKwUVtnD3YmvwzeHAaQ
         dE39QAfgpGFMWQi30JSjyWT01LgYZtFy+uiY/IIfBj7VYmO2TWzBtrJt1q+wcwqn/zY8
         tEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785106464; x=1785711264;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yGmhXoSde90feAqgXfhxNDvC05OmFmrJPIv3G3OJRH8=;
        b=fboQ8174WOVbSgYrd9O8fIFBSix6c8rE2w2ulV/Li6h7hZhnPybpRKn38JbTGk4xSi
         19r4XZXjGpRYbhAW66qp9AgUx8XVqTI+ScQtFVDZrSXqDdhcQKCu+zXvui1I5Mc9H5bA
         MAhQeUmoWA+87vOc4bj1sVOQzAazKFmUvSKNBZI6h8ZwMdIrqzCxRjpDlT8sjyFgSdXI
         Z2gEbwoMlVtzePclV7tnHijwFUPEHANEyY2A0nAXW0oGb66pfhkBYhUjzZCKh0u0I7gH
         MlAMbJnrVV11mouy9ZoylZQzsz6Oc9GO0/4bP3/6j3yp0w92yazijJ98noCKoJ6uYs8j
         pSHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsZof1mr/aVUSQ8W2xl5GMlhHrpg7LPlc6rsuUfH8RoWEd+e7DflF6OhO2yN4w0upWQRODBj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMH7rsXCxWLGTMld7O6bDFGs6f3c11qAA3OVx4f8O5KGkOJgxx
	81xRm2cUjVeRW8uxSSUgCrXTTfu8BTPS9XI9VdBpTFq/3hTZZc9BgwD+HxU8DaHq4m9gEqZW3EJ
	+7gFqM8EF5yRPX748kY1m9dGsbmHwOGSQokfvvYjQXA==
X-Gm-Gg: AR+sD12VZNG8mjP+yq1f2Yj0GO1yqIX8FTbywcP0FGZeNlLntA9tf9jIcAmho9QHcDv
	gBTrf4uc8Z01oEp7/CeLWwbh1OiNiFunRn9MTKsB0DBzjAlIaVgxGOUUeIAKHT/hP1ml758tjml
	bDv5358YQ6PDUZHAv07BX+nrUHCL0AkX60AVLewam31a79OfWP0Gc2CTHlKOKad7K7iYr2XWJvp
	pHyRxfu9omVMxQMisbSwIKF/Ds6RwYafph3zBf1gJ/S3tJIkeUD7wBvDKFC1YDonhcTQkjnE4dV
	fsUYoaIBZKR/VAHUdg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:620a:471e:b0:92b:855f:e91b with SMTP id
 af79cd13be357-932df6aca72mr675260785a.26.1785106463777; Sun, 26 Jul 2026
 15:54:23 -0700 (PDT)
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Jul 2026 15:54:22 -0700
Received: from 960782262270 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 26 Jul 2026 15:54:22 -0700
In-Reply-To: <87zezdiiyg.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
    <87bjc0led9.ffs@fw13>    <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
    <87v7a7jeav.ffs@fw13>    <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
    <87zezdiiyg.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Sun, 26 Jul 2026 15:54:22 -0700
X-Gm-Features: AUfX_mx_IaCTsMQHYhejNBmZReJLtMTG7W9zcKgou_HEaACiBvcFIj4q9d_306o
Message-ID: <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Jul 2026 22:39:35 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
> Something like the compiled but completely untested below.

Two issues noted below. With those fixed, passed my local test cases.
However, I re-ran the full TLA+ analysis over this protocol and it doesn't
fully resolve the lost-wakeup issue (both your and my revised patch).
In particular, if we drop the hb lock for a pagefault,
the waiter(s) we collected could have died and run exit
processing before we perform the store (so exit handling wouldn't
have performed the extra wakeup). In that case, waiters behind are stranded.
I think the simplest fix would be to separate the count and waiter
collection and only ->wake the waiters *AFTER* the release store has
run successfully.

> +static int collect_waiters(struct futex_hash_bucket *hb, struct futex_wake_q_head *fwake_q,
> +			   union futex_key *key, unsigned int nr_wake, u32 bitset)
> +{
> +	struct futex_q *this, *next;
> +	unsigned int matches = 0;

`matches` cannot be local here - either needs to go into futex_wake_q_head or
needs to set `waiters_left` in `continue` path an the robust nr_wake path.

> +/*
> + * Wake up waiters matching bitset queued on this futex (uaddr).
> + */
> +int futex_wake(u32 __user *uaddr, unsigned int flags, void __user *pop, int nr_wake, u32 bitset)
> +{
> +	bool robust_unlock = !!(flags & FUTEX_ROBUST_UNLOCK);

FLAGS_ROBUST_UNLOCK

> +	if (!bitset || nr_wake < 0)
> +		return -EINVAL;

Noting that this changes userspace ABI for `nr_wake < 0` (e.g. for userspace
accidentally passing UINT_MAX rather than INT_MAX), although the current
behavior is of course surprising and in a quick audit, I didn't see any public
userspace code that gets this wrong, so worth trying probably. It's certainly
better behavior.
