Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86464352010
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472657; cv=pass; b=oS9gL4QPpgQpVIf1LsS8k/kcIFJ38yJq4t1Pyn7vtvGnA3p4IHbo6+YhzUW6cVYsnoH7pVkasWgrPhfFBlyw6DX/5mX/Q5oFJqmzuyJveQ0ddMZg/KPHgl4nVYb/MhdOr4DvgF4ZnQ67BQGzaEDPN4VH++6v1M9y5y8Vmt7c2kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472657; c=relaxed/simple;
	bh=I4nWq7eBUpdMTRGSZ060GlrwRMrwQz0RG+ZbS57rKZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwwF6Z4Pe+mlywrQ/nvpOZT70xrCav9xVwIOr7ohfep4qqIwstqqkThxSUBzsGSovtAizOo3GT/y9q8h07ePewUv7L8Nj1nrjcU8+hvXEOvL4nAAqd1tkQhKZtNXKh/4Ew7yCXJYIkT24pwTIUdh5sLbfZWxNFd4g0nnU7Zp0Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=bR5Pg+Dq; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="bR5Pg+Dq"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8efbafa1bacso3215856d6.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785472655; cv=none;
        d=google.com; s=arc-20260327;
        b=DoXxTNF7ZZliuhIEW6nTppx4qs9VBnb1oaUaJvPA67IGUrtc0eBhWHWLf3gsUOCXn/
         vpJny0zHgP/bRUcIRGbeT7CNkHhnCy7o2CNtKlTKY+ooQQtbEjUn6VV9jJq93NSE/Zcs
         gpKDPeARecBk69UhWR/SV8hiTs7petX2ZX8o+fID622Y3ku46Ldaj5lR9exn4UbCAteU
         TAK5ck2r6lz0sKOetw8RY7Xqm/SyH7O6wo8Kw9Tz8FVr7G8oPX2qzadmdlHmKoQGYz6N
         U0dRKdIydds4SSSKu7GYRUtVAnQv4J18C9JRGIY8pwBrdmi3wwe8X8YiB0DtmD51BmBt
         VZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6DSqnFvzT2RVVlrES9G6C2hZYuVqr6UqDSPdeKaSuY=;
        fh=YuDISm6AZKLXyDCY/RmY8uvI/sOUZ7EsxS6tkLbyOVA=;
        b=nDshk9cGpuh/uMqJdE9dFfdb4QSCCF6wLQjbX7K/yebI+AM+mkdpR9oO+nTv9E7ill
         9xY15Vr3mTASqFOrOk3E5Nt0p71h5/04pQZQj8SyNTl6RF8IVl6JqjFBeYt2xWF44eiY
         noC9niseRaqcQiAX8/BTmhGszzCxpFbWQe2PUypyk0mBQ4BcUheTr0TToCBqWgiSH0dJ
         G7+tM4Fp9iHct7JrxldIOxcAWcN8wFMPdn340w+kqo2TLqMuHfEYsZg4Hd/bpx9aLIBD
         iQIg0fw8RlfIAuOaQQlHsS4dVCajaoZ4RxniEo9s9QkICQewzF9x4iP6tM3d5XDCXVJv
         BAgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1785472655; x=1786077455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M6DSqnFvzT2RVVlrES9G6C2hZYuVqr6UqDSPdeKaSuY=;
        b=bR5Pg+DqT2JqHu7X0LQoX472+9Xe3mVBBKRx64rHARF0wLWZ7ewBsksD76509YqJMV
         1aLzDkkK4yo60lXMNljA8vTJltraasxcgO7lRf1FS9e5yYKDL91Ca/WE2fB/qEUU7voh
         C0Z07JR6cPMBM8rNUtDlVntaHPrGUzP2thDsiR2P269uW/KNrx6XImDeHkwtRiLTMZ/N
         AQLZep3NUhc5XJGi8QwIFruBPmmg7+4jG63r+yNMQUE64oneLJ1mAumlJoDXESPkjwwp
         P0oIflSvlnArnUQKP04rIjdRrwz1vpTPS+5Nlqzm70w+i1iR6I6qK13r80V38rElujT+
         w+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785472655; x=1786077455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M6DSqnFvzT2RVVlrES9G6C2hZYuVqr6UqDSPdeKaSuY=;
        b=VdM6tTlasikaqoaSMtpYExEk71Ps4WgT4UcbwaW70S8ZVnoSU8bEzY56kL/YfU0HHZ
         CNiye7CO/8hR426Rre57bpFyncQVOkxevU/12CFOBjfp+WrvFwM2IO1fwa8fvsm6PkY5
         +mnbkrvaJcNnvOKstOSCkf2FX7JzV3Tg4Znr9f4B6XyM8pO5eIc4+7Q79dgU+inhACB3
         f3rQkTG5iNwedI4PmAtmL6dIubIAyOA6msYmNrXPuo45c6wdMmOxKcKvB93UNDCsjEes
         Kz/bdepq/vziSGiw3D6WBJe7WRECw56JIvY70tCV705dXAoW7RKw+Ib/r+XQOgcRRwaV
         86xg==
X-Forwarded-Encrypted: i=1; AHgh+RorMInp93hOG8Cyr73aLIO0dfSKtzRSpp+ZCZ5Vd179nHLRkrteLyNBpKXpNyreZ3nNBuISE9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri0EIYtaoJhyqcV3UBeC9jok5YwkfMWrafh/yhEBB+srWCe1d
	ho74sBAYklHNwXAaIKTUacpyA1nDOrjtQMlOO+2dMUGVxcepH1Lp8Q+CjFoWCLV+7uKCqBnEWWE
	qTROEfbs6hi+PvgT0ZYJ0/Y47iCnO/TRQkV1doswYSA==
X-Gm-Gg: AR+sD12y5bmomS91NWrSkRbhfdFDAWLWHKFg2eYOYdQ6T7R/WixbyiOcFWFXOSV4lJr
	R2wetoqjf8AYpcqtd6g8R1EExegmY5jvrD6NkYLQGJs6rvRXJ9j8rhaVovoapimqGGFCAoGrUpf
	l0vtdRdoAhoLzHEa7ud4omGKymfKQ1FttJKfJkGHTx3fFq+EySaTvGcOe4MXX+UdAFBlvXOKZtw
	bR12Q35HotRUeY3ZE2QUbXAIC4nRfQ6Re+HeMpLSYR8rvf9BYIf6YUH4UlE04h98QVBKj3t44zT
	7zd6zel6zNZH9df2wuKJHsQgghtKViOgwN8Y205b/ErcwtUeOG0pkWwrXQ4/oufwjXHI8FnDqgZ
	o
X-Received: by 2002:ad4:5cab:0:b0:8f2:1d56:3e8c with SMTP id
 6a1803df08f44-908421dac2bmr9515036d6.29.1785472655477; Thu, 30 Jul 2026
 21:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13> <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13> <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13> <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13> <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13> <87fr10faqi.ffs@fw13> <87cxw4f7jh.ffs@fw13>
In-Reply-To: <87cxw4f7jh.ffs@fw13>
From: Keno Fischer <keno@juliahub.com>
Date: Fri, 31 Jul 2026 00:36:58 -0400
X-Gm-Features: AUfX_mwcVojPkqfcqzoLwiEoaqJS0dDTKBc7oGLGdN9fI1Qf4NWHAUXIRZxFxqk
Message-ID: <CABV8kRws040xRZqsLdDJNaHs-3Ax063uQnqTR-1mMMmkaCq3ow@mail.gmail.com>
Subject: Re: [PATCH] futex: Make FUTEX_WAITERS state consistent for robust
 futex unlock
To: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Yang Tao <yang.tao172@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Florian Weimer <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the detailed changelog - I think it lays everything out very nic=
ely.
The optimization added in this revision isn't quite sound as written, but s=
hould
be easy to fix - see below. Just a few minor nits on the changelog language
otherwise.

On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Thomas Gleixner <tglx@kernel.org> w=
rote:
> Keno reported another subtle futex exit race, which is neither handled by
> commit 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes") n=
or
> by the recent efforts around commit 3ca9595d9fb6 ("futex: Add support for
> unlocking robust futexes").

Duplicate shas - ca16d5bee598 ("futex: Prevent robust futex exit
race") for the first one?

> Amend that proceedure so it does the following steps:

typo

>    4) Try to unlock the user space lock value either with 0 or
>       FUTEX_WAITERS according to the result of #3

I think it would be good to note here (or in robust-futex-ABI.rst)
that this is a change to the non-PI futex protocol ABI so that userspace
can appropriately coordinate the ABI versioning when adopting
FUTEX_ROBUST_UNLOCK.

> As #3 and #6 seem to be redundant operations they are not because as
> explained above the elegible waiters cannot be collected into the wake
> queue before the to be set state of the FUTEX_WAITERS bit has been
> established.

typo 'elegible' -> 'eligible'; same in the paragraph below this

> +               /*
> +                * Waiters are counted independent of the bitset match. S=
top the
> +                * list walk when the total number of waiters becomes lar=
ger
> +                * than the number of to be woken up tasks. In that case =
it does
> +                * not matter how many wakees have been found. There will=
 be
> +                * waiters queued after the wake up no matter what.
> +                */
> +               if (++waiters > nr_wake)
> +                       return 1;

On bitset mismatch, this will early-out before caching the wakee below, los=
ing
the wake.

> +               /*
> +                * This should never happen because evaluate_waiters() wo=
uld
> +                * have detected a PI futex mixup already.
> +                */
> +               if (WARN_ON_ONCE(nr_woken < 0))
> +                       return nr_woken;

I missed this before, but the same issue makes this WARN reachable. If ther=
e's
a bunch of bitset-mismatched waiters at the start of the queue, then the ch=
eck
will early out and the PI mixup will not be discovered until the second wal=
k.

Thanks for pushing this through!
Keno
