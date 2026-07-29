Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCE3AF64B
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353487; cv=pass; b=njqQRzwhT4vhFa0v+VABfQQRTO6VvZF3XaFuQPT9CpM6O8Cxct+t6342I4Z58xNQpSnvXC8cq/NqUnXjjkn9WIJ5R/8+NxNTJUOeopOW7wUsJNENCO1a/6faNk26XgzGB0EqcCTns2iT0QAfL3BpiP8Y1pnuR01bs8tit2fPDzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353487; c=relaxed/simple;
	bh=AW+2NReGvoch2mVxj+60oV42GoQXvVY/28NZ+o3sxTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acLOL8LHbbgYgAOW3EGJhDkXC6TwdiXtuYBYvoQw7wQOC0e2n8M5+QH49KJ99okVDTaC8q1Qz2kiy5nn9c1VGbsbXdOnDn363RBmYlSanS4EBQ60DtNK+uDIILJ5LqgSGoX8jrcMQf4mqJdVs3HxivDZdcwQ2qTKpa/w/tG5HGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsCuZjvw; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsCuZjvw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e04df8c46so1596568b3a.2
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785353481; cv=none;
        d=google.com; s=arc-20260327;
        b=M9AM1lL9OxaVyEY5eVCaaOQr+37lQ6K6LQjovDqVygYQusCjkLHAMlqYeMlJhFx6uK
         3MNqoj+kHWf70bZGlSaxteJtu9dCgfQikgcG4s2D6E5CCmOLm7AimlK/r6uVJNKDlZhY
         E6/dwFDTyg4GGv9WPyU616Z+fNrKJHJiIFHilCI6+L8naOsrGueCB1lHKw7+n5o7SIQD
         4jl1Jm3AQWpV1RFk24DpJWBJuF+yhMi1vLxHlgdMrq0oJsSDbvg0zaC7Q4LPn4irN5d/
         UeWHZ9nT+5j+aCYmX2pUCJAOMZjDDKkPntB5GoGHpA+wegyk9Ny+mFeMBvKTwSNUHUxb
         Af8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        fh=IHJ8Jfko/QSEeAZtKj0P+D/dfGw0jN6v4RGtLyish4k=;
        b=o8jotVFSbiUZcrb0pMnAJZymfFwIGBePqgY0sw/mdpS3nwCBogsh4ldPVXk24WhZZC
         0tyUETTegJUIaPCBcfEn1YpWJ06ncW+kULaqvfbeCWhnBJDZPAllMf7cAtogusbtjSlu
         Vf8rZWWX8V3hjTPpMOXhklPIN4pkmvyYOyhrUbrdJX8y78224F9bs/Rvc8pvcLkYBn8p
         GUf8iBdlLT7I+UnTqXp2YmSdq5MHuuf9b9eTiH8JUOSiJjrUsQu7hUXY0PJqHzrufjal
         l6q6TlQc/Fu+eAp0gCnnaqigqliCpKkxDXXD5RuhDYJFcredP5JCxKvO0teibttJx7IT
         LynQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353481; x=1785958281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=OsCuZjvwu53Bt5xqrwiBNeckfkSjiWJzvvxKY6fbPq4G9COH7Ao7fQV0AZfz58z/1k
         GIZ0BpmtujRkYBugLG2dR+6rnEbekKdfRwMITuWdJ8AovWlwsl79XJXZ5Y0ApsTWtZgQ
         Nwq1xEj6eWtYpteKMtKivHRPP0cXIzm+bijLcsOZNaHcXMIqDgkiRng3pDo4lNxhPxdC
         F/nexB2rV7cfx0Z3y8j/Z5yx+8U2YR1MBMfuizTq7qRQsbLhZ/rsbm+u8zL8A2nNqO3r
         d5HSRi2bbkmlizmKOvTi+lj8k8U+pyQNgWfRLduHxsxFKU8VZvg9B1GSRrPNyI1u8+jq
         3zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353481; x=1785958281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=lxZbMnXPDoUwm6wfnQbGGfQTpHK4pdRN17yIlWCVustINnl4HZVjKK3QsNnkjhjuPy
         7ItrC49+a3qoUlLncs7ZB1QE+x00PbO7TEWLeSX+25nq7JTxBePeXat1S4C4PacTbgMV
         zV0h0RjmrG/svRX3dtNIdYOJARYMS4aE8fUewPC4u6zzTZf5JYs0XZCP39yVusQsbldH
         pbSUiJgxzhQwY7ZIYFeLlhV5Zw1kx2MZ3zxiLbYnmgRnHxwad2kyFs1sd/Yuq3KruoyI
         s3k415icpC9iyWMDCEvRaI5s8lEFXGU3WmK2c3mp7fvfo05FHTt0OvzHf5ElTPy4n7JL
         SlZw==
X-Forwarded-Encrypted: i=1; AHgh+Rp5/yfc0M5+Tc4u0WgUOYFM4NlDw1WuPnWPzPAEFX/KFI/MLMTDpRonW/QtSfm/WFzszusJZkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywvp+v+1Tia9vZOCKNEBxOEBfuCMgBj1i2eMZQr5V6uJeTJvAi
	KC+AjR+7tRwcADdgYU4cLvjJkRjoAQIxptvevBUUMcE7oUWnFrRIk03xUPF3tHXcT8Jsi3xk45c
	ddqYQuKmXGXZqlvOEYb5B+RwEHMOf6uY=
X-Gm-Gg: AR+sD12Hg7KdXI48pD4OOnYH6wLabDNI5Y/gwylguCAu35spscuMK9USLwoBnGou4a/
	/dgG/y76lEjVHUFOjAJDzL4BRi528GoG5y3sZunxwbWL5k3OIT+V1BRBr0f8hibvL6JGC8+Ao7K
	mXrlXG3+vqPP2yfc7T5okRKMXVqgqLoZpoH9m8T3nHVD9p8GlceyD4LdZ0jTxuePrVPWzvVgpAI
	3AUBamVi/3uD5YCzwtkfVTfnDUBq8vadpf5s3e93rVch3kG6ANnHsxY2YHMiEBIm7Pq3tSxBa9X
	yqn44uxjQ6AhnOHFdFNAKJ8n/KLQ2JwXmSnD3qImsIEjhN6u4uqyB/saWXeVzNpHvugmfu6PMW7
	MhTeAWEPPCCIzycDZRb8yBjAOSJc4v1tal4Jh
X-Received: by 2002:a05:6a00:2d28:b0:847:8250:2b2b with SMTP id
 d2e1a72fcca58-84eba209c22mr58219b3a.52.1785353480816; Wed, 29 Jul 2026
 12:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-uprobe-v1-1-61896b87c867@debian.org> <amokG13tEnA7VVVf@redhat.com>
In-Reply-To: <amokG13tEnA7VVVf@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jul 2026 12:31:08 -0700
X-Gm-Features: AUfX_mwlnvUi1r-ku73ZCSAcs_YOxNgVJkyNNO_0D-3nnjYBTZf7rGtYqZPK430
Message-ID: <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:02=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/29, Breno Leitao wrote:
> >
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *=
hprobe, bool get)
> >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_=
STABLE : HPROBE_GONE)) {
> >                       /* We won the race, we are the ones to unlock SRC=
U */
> >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu=
_idx);
> > -                     return get ? get_uprobe(uprobe) : uprobe;
> > +                     return get && uprobe ? get_uprobe(uprobe) : uprob=
e;
>
> Well, looks "obviously correct". At least the current code is obviously
> wrong, it even checks uprobe !=3D NULL 3 lines above.
>
> Andrii ?
>

Yes, indeed, I'm more surprised this didn't come up much earlier
(probably it's rare enough to have uretprobe with refcnt at zero
during fork). The fix looks good, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
