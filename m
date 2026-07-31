Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF33E7BA1;
	Fri, 31 Jul 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494499; cv=none; b=IHt4rYIqpSEfMblGGybrX/haG3WFKKv4Ao3k0mSR+hYckuj2knMNTD4BkP04Mm0kL3qfhW8CEO2Ao4i3nGTHdKGtfP609M/Vayi5iRgm5v1o2dC+72bt+1Vp8yfxayfifAVTtfQrKFuw7U0QjMiywVs+3JNMZB7uZ/TDopgCalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494499; c=relaxed/simple;
	bh=zsNFOY3tJ8GWXNhT+mm89FexbjM5tnV6CgqSrTCGlfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpelngFHq6tPf1fYzzl+k0iUXM6yLVWIOnP4HqBf7CpJO3nWJ6IFyg9JqjMn64/0MKeDlGc6QfrrZCzGVYYEn/c+mCxTdD16eWPTBmpOyelLaIzoYQB05PGveTUbx9Q09Wu9m6LWxsm2EKDZZpDvmA1zkCw2gqchpFZaxo/XjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrUAKWqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrUAKWqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FBF1F000E9;
	Fri, 31 Jul 2026 10:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785494486;
	bh=a9M//7gbFIAdaLtXr4DFIITb6NHWUMUEvsMySSe7NZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JrUAKWqWBDx1S3CgHQ9T/VaYwVYa86C1e6T1eiwqZQE6oWVJyS4cTRfr3qkKByJt9
	 lhjm82hhIoq1n1jB+ByD0lwbs/Q5D7tJwP5D3IXf49KTfttZ4TQPrPzIYtNnKhhbSk
	 uM4kfHyFICTaU9tA21r/DX+qWQLY/tkJOi8h74MX6C2yjm4ys4qlgh9+7HbaPy64FS
	 +r8tNc7td0QUX6xIxMyPsLZyVK7hk36TkurIcwTm2hOvD1JMYopqQ1vacwX9szC+ZX
	 onGSS6sGU+ErfUetkpX1Dw4CHMs7SP9M2gZ179rkr+sBIIxa6DL/Zg8k9W8O3SiUxn
	 fUgxnAWEsjeXg==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] futex: Make FUTEX_WAITERS state consistent for robust
 futex unlock
In-Reply-To: <CABV8kRws040xRZqsLdDJNaHs-3Ax063uQnqTR-1mMMmkaCq3ow@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
 <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13> <87fr10faqi.ffs@fw13> <87cxw4f7jh.ffs@fw13>
 <CABV8kRws040xRZqsLdDJNaHs-3Ax063uQnqTR-1mMMmkaCq3ow@mail.gmail.com>
Date: Fri, 31 Jul 2026 12:41:23 +0200
Message-ID: <87a4r7fnl8.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31 2026 at 00:36, Keno Fischer wrote:
> Thanks for the detailed changelog - I think it lays everything out very n=
icely.
> The optimization added in this revision isn't quite sound as written, but=
 should
> be easy to fix - see below. Just a few minor nits on the changelog langua=
ge
> otherwise.
>
> On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Thomas Gleixner <tglx@kernel.org>=
 wrote:
>> Keno reported another subtle futex exit race, which is neither handled by
>> commit 3ca9595d9fb6 ("futex: Add support for unlocking robust futexes") =
nor
>> by the recent efforts around commit 3ca9595d9fb6 ("futex: Add support for
>> unlocking robust futexes").
>
> Duplicate shas - ca16d5bee598 ("futex: Prevent robust futex exit
> race") for the first one?

Wanted to referrence ca16d5bee598 ("futex: Prevent robust futex exit
race") obviously.

>> Amend that proceedure so it does the following steps:
>
> typo
>
>>    4) Try to unlock the user space lock value either with 0 or
>>       FUTEX_WAITERS according to the result of #3
>
> I think it would be good to note here (or in robust-futex-ABI.rst)
> that this is a change to the non-PI futex protocol ABI so that userspace
> can appropriately coordinate the ABI versioning when adopting
> FUTEX_ROBUST_UNLOCK.

Makes sense

>> As #3 and #6 seem to be redundant operations they are not because as
>> explained above the elegible waiters cannot be collected into the wake
>> queue before the to be set state of the FUTEX_WAITERS bit has been
>> established.
>
> typo 'elegible' -> 'eligible'; same in the paragraph below this
>
>> +               /*
>> +                * Waiters are counted independent of the bitset match. =
Stop the
>> +                * list walk when the total number of waiters becomes la=
rger
>> +                * than the number of to be woken up tasks. In that case=
 it does
>> +                * not matter how many wakees have been found. There wil=
l be
>> +                * waiters queued after the wake up no matter what.
>> +                */
>> +               if (++waiters > nr_wake)
>> +                       return 1;
>
> On bitset mismatch, this will early-out before caching the wakee below, l=
osing
> the wake.

Duh. Heat induced brain fart.

>> +               /*
>> +                * This should never happen because evaluate_waiters() w=
ould
>> +                * have detected a PI futex mixup already.
>> +                */
>> +               if (WARN_ON_ONCE(nr_woken < 0))
>> +                       return nr_woken;
>
> I missed this before, but the same issue makes this WARN reachable. If th=
ere's
> a bunch of bitset-mismatched waiters at the start of the queue, then the =
check
> will early out and the PI mixup will not be discovered until the second w=
alk.

Yes, but that has been the case forever and it's done opportunisticly to
avoid full hash bucket walks wherever possible.

Thanks,

        tglx
