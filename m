Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E881DD525;
	Fri, 31 Jul 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513947; cv=none; b=n96oQTKxZsFb+rt1vLqyFsILCya8UtgkG6Evu731WCP7OJhg8tWZRK6rbGemN1U2bF4BZvEBCJKcTB2tZkJuUCv1JMs1hvk4fr/ixpP3jzpaO+qtCdxMOsT7LwdFouDnffoYqoUqh0rCz7tKyfwaCMvIiQr1ava0cd7Jj8cSbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513947; c=relaxed/simple;
	bh=naXJXS7uN32CNLJ9wsP1PkpiJusOantk2MeT55xQWBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q300b05TnDvLKfr7Y/uRHyevKioulqwaKgaPFdZQBf63RiQ8tilEDYsjR5YWa6NyVXtZ5S6Uqdikl6wCzrgFJnPZqs9dA7uKXdrX3ikfFTaoeklJvq+lYUNuVOLe8omsn9AiKIiGhJUmyWxQCn1a8cobUjHJYLuDT/WQwk39UbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXN3ROPX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXN3ROPX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC81F00AC4;
	Fri, 31 Jul 2026 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513945;
	bh=uWzObRYK1gaVyHIwwgmPIqkv4UA3iOo8uVNAjdMo2jg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AXN3ROPXsg1lOQSG4QIXKjvtNRuwmaGVrzTk7j3nLrcUfFhuMazbR4pU9r0HV08XF
	 VEnGW6x5y+T5A12EWGoiqMr9xX3jMxJofW2aIuoAmJtO08irlZwII1+WRqoltwDiff
	 WcEnb2dpOpOOzKm8HnkkxFTF0clcsIccUhGpQUTNVFnFY9AInMMyrjDQLfyxPn6DxG
	 sMc+nJyWsGYwaozlzrbSxq8IWLZ/ftyRj17CkCCEalED0CQI71BMGpPxLqazMXN+r7
	 8a9Tvdcdp9SFVj7Dg09N9sfZbDgjLaklRATvrGPf+pqgGRODBbAa+4b+XtH/9LFvFc
	 B2EuhzwOgupPQ==
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
In-Reply-To: <87a4r7fnl8.ffs@fw13>
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
 <87a4r7fnl8.ffs@fw13>
Date: Fri, 31 Jul 2026 18:05:42 +0200
Message-ID: <877bmbf8kp.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 31 2026 at 12:41, Thomas Gleixner wrote:
> On Fri, Jul 31 2026 at 00:36, Keno Fischer wrote:
>>> +               /*
>>> +                * This should never happen because evaluate_waiters() would
>>> +                * have detected a PI futex mixup already.
>>> +                */
>>> +               if (WARN_ON_ONCE(nr_woken < 0))
>>> +                       return nr_woken;
>>
>> I missed this before, but the same issue makes this WARN reachable. If there's
>> a bunch of bitset-mismatched waiters at the start of the queue, then the check
>> will early out and the PI mixup will not be discovered until the second walk.
>
> Yes, but that has been the case forever and it's done opportunisticly to
> avoid full hash bucket walks wherever possible.

Duh. I misread what you said, but yes with the changes I did now it
should all be fine.

I'll post the lot later.
