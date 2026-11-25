Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624589;
	b=PQPq8BP1OMTjwIPpjpzA6mdPvuCostTNE0T3hKRyVHbj5mWsnnUGy/Z/rrYzY9v3R//U
	 VT9M/rWWFFzEIQ1BsaLiYyTrkI+ujS4RpW9jiF2wSiLi3wpOz1A8sWkXhBrEDJRtm+IP0
	 R3X/YgLrgZRRJ18hdgLRKJD9fhZxFlm8lPFVjopS69z5D4jAXYlDEUPEqGa4sI4t8E8Qy
	 aMmzEmzrNUeyZ+NOEdHabJDPrb3YcoOQgXze0/ZxKquHdv1twQcuvtJjH3xN0mgKWJi/R
	 7d5olHV8M+leWTaUfIOWwvvConrzRdrVdI/eJoDFkECDTjP5bLsUTLb7jeXVdiyhupQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
	b=BCj6zNIkxmOp+w2kNyR/2s4QqyilsJ+JP9w7INkMdvOEm37tsbfteEoOJ0RiPJuJbzt6
	 eiSbvM0mje03tAZfYCF1Mm4b252Joi7UQqdeOEHSPeiNE6x2EQEliBFE7/9NQ88v0mjC0
	 2jB7A+GMlzl66mvR6iSXCsCpy/1i8uRZG1g/XWKg7eUn03RvRu7ehQnC16c5dYiRbK2op
	 e453vEGA7KmWc1mLNYso0V+OIbZCzofZLw/7/Axtv4j/pMQb4a1W9rRDvb9P+JkfESCbb
	 8eJmXju4gQMcPvbfaByPLwcG0B6CjWQ4Kc4t4ChSEKreBa1fENsKt102RQjXNCphyYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JZMk1Tkt;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAE606A33E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCAE606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JZMk1Tkt
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b8815693e2so6907471a12.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795624585; x=1796229385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
        b=JZMk1TktYoJpssBTzRVVtlCaMOz8vCHGVMie8FuMb5srubK1z9XNxEhQvwi2as7r9U
         InJKBIASjPIpxEBIhWXeH051PzRYyLAhdBsJQQnNNnuZp78WLPt+6VNuZ6qqfz0uZlWw
         hLHpQlWH/N1MsupqnkCmXfC7hEt8+zamtHGx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795624585; x=1796229385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FD+pJUDv6zW82nWry+CbP4QIs08JghbicqZZNK2kgn4=;
        b=qYuETKhPUFepbe4MXiEEyuG7cQX3/cd7UQ31nEsEJqVhMYd8n8QXcDnjzTr03ywhLd
         OsRUuvmC/XdE7/jafFrdS6xdXXEi7alI/LGwb/jvcIbUIRMBrmXaY5azKOWUKx7wGD4y
         6VaML4+Xk4rR+JkAwa7qUegWJ0BIq+qtHH/qc6Ym5G61lk3nt5XmY9MMwqifHW4fIknO
         SAW4y8UZY5KmC2B/R1HH+lhkLYVQFLbZFfu7RxmKmhV4FQQA0blbhsv8zj5VPBDVXIxY
         TLat5i8fwQ7Q0guv5nVc4xkFr2nHxRnsZSDW/zyAiYQdMnigG+mP9PTJGhI1sz1bzZ4p
         dtvg==
X-Forwarded-Encrypted: i=1; AL+hErGENhX2Cd/ZS26sfEfKYtsau1FVYD7gJ5oK4c4Q43P6re+2qlaeMo6xZucEUHjndc+pbi3TRTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SGGd7H9f4BMzRVn92waZKwTocdoPqCtwA+iLpuxcxlxi8H5Wv
	BPIQ/Fx7YtP/mpWR9hufL7GyzJgA3fdMdiHNXAKLlUn7n8Gj0MnBAt0Wlf/D1srcKz1ol/kc7dD
	rg0t2hnrxJA==
X-Gm-Gg: AZFdTZcDJWGr63TpRGnilwTEOZKoGLH1aIY1Ds8M2ZM4uSRw1gNawFlGz25qttj48tf
	+CU/0ZxA5x0fAKz+S0W7YJUI/Mqp5zLQUvPwftvBucn5xE8g6EN3WfSGerN9N2bGcVLQTavWzE6
	Pp1k5RrsOz79LJzdui7BeCeBIwUU1JcDzoWFpgRWxp05grF+8MAjC6QhnIbTFWDVHUavpoIisl+
	+AOS34pf+29oJ/IaJVA0wrDiU12J8ayqmkCtoo59b00S1Oph+UrBqQa3xcaouib2mIrf7l4nZp0
	rpktvXan5sDj0NhtDKkSvU1HxBVXVEE+jLy7nVytMQQHZE9nm776GYIoIdGj/ik4H+OiuS/Cvy4
	UtNa1r8c19X9KSEKuLzo83C4UZegRbOnHZIvb1ZRvBLGXoS7DVGKyQm/cuo1pPTrMHKJpqHd/x5
	doMJS/+qRD9+0lgU1k8TNiUBK+1WkoMbWonq0YPqNVTaDK93+Ndj9dpbiTPu53n0pege7EVk9Jq
	cjnyILu1GX5wMeN53HM9bDMH+yKe5wKaI42dn/g0ruBJw+ZNBMFqyiZJKRmiGpRtViFt6inBdH1
	LIUcI2+ilU36UQMS4eYByYwzq54cBQuX9g1yM2TTx7jnTVCVG20sFJLAeKiAlxemdEinNoeXBBv
	UzAk=
X-Received: by 2002:a05:6402:3222:b0:6b2:2339:370d with SMTP id 4fb4d7f45d1cf-6ba37ec485cmr15644902a12.39.1795624585125;
        Wed, 25 Nov 2026 08:36:25 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba37109b55sm8233734a12.32.2026.11.25.08.36.23
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:36:24 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c5126505cb3so778823866b.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:36:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGixEGjqaAwHwf/esOs4Jd4xZmVPUn3GR/PK/j0ydgXS/z5EqG/07WP12lCgIKGlRE7Z2a4E9A=@vger.kernel.org
X-Received: by 2002:a17:906:4fc8:b0:c51:ab6:1c73 with SMTP id
 a640c23a62f3a-c513aaff9c8mr1629652066b.23.1795624583581; Wed, 25 Nov 2026
 08:36:23 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-b4-sched-wait-intr-head-v2-0-4a764b64e8ce@columbia.edu>
 <20261122-b4-sched-wait-intr-head-v2-1-4a764b64e8ce@columbia.edu>
 <CAHk-=wj_eqNh+gNhCQh3exrL5Pmo5hbZBcL0W-4Ah_Nw0Kegzw@mail.gmail.com>
 <awWSwmvaTwBxfU-r@redhat.com> <CAHk-=wj3GCXZohdFWWPAOkC_LHno4X0oQW+0sQFJzRMvjpODUg@mail.gmail.com>
 <CAHk-=wgYc9vFEmyV0Ch_e49j6GOhUCMQMnMV4f1FLLvumZOmRw@mail.gmail.com>
 <CAHk-=wjbK0xyhwvWP1uNiYR6i-X9MpCn8bnm_akxq0MsrYOL+w@mail.gmail.com> <awbJz9stwx_JzZFX@redhat.com>
In-Reply-To: <awbJz9stwx_JzZFX@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Nov 2026 08:36:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
X-Gm-Features: Aa3M54pPxr2VuJXWXHMKSQADyObX9AHM2KfGDGpOXz7rBKMCW5_j8OTDdxQ-wbE
Message-ID: <CAHk-=winCVsBKy0mGZK3mazNoTO73MrnmFHXNBw0UNK30Di7Fg@mail.gmail.com>
Subject: Re: [PATCH 2/7] sched/wait: add WQ_FLAG_POLL_EXCLUSIVE for user space waiters
To: Oleg Nesterov <oleg@redhat.com>
Cc: mt4022@columbia.edu, Jens Axboe <axboe@kernel.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Michal Nazarewicz <mina86@mina86.com>, Wen Yang <wen.yang@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 03:43, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/24, Linus Torvalds wrote:
> >
> > +             if (flags & WQ_FLAG_POLL_EXCLUSIVE)
> > +                     poll_woken = nr_exclusive > 0;
> > +             else if ((flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
> >                       break;
>
> I obviously like this change, but note that wake_up_all*() helpers
> use nr_exclusive == 0, so
>
>                 poll_woken = nr_exclusive > 0;
>
> doesn't look correct.

No, I think it is correct. I agree that this logic is a bit messy, but
the intent was to keep the patch minimal and the code as close to the
old code as possible.

The logic in the new code is that WQ_FLAG_POLL_EXCLUSIVE should only
wakes up one of the entries that have it, *except* if it's a wake-all.

For wake_all, the poll_woken is never triggered.

And notice that "nr_exclusive goes negative" is exactly the *same* as
"nr_exclusive was originally zero".

So maybe it's a bit subtle, but "nr_exclusive" has never really had
"zero is wake-all". The logic has always actually been "zero or
negative is wake-all".

Only positive values (that then go *down* to zero) stop the walk.

The poll_woken logic is just an extension of that rule.

But maybe I'm missing something. That's always possible.

            Linus
