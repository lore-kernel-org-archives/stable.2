Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5693BAD95;
	Thu, 30 Jul 2026 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394744; cv=none; b=kHXoKhnd3MjY9rASSVvoLqap4ghdevJG9Uh6P3RYOptxPuyEJJVggd9nLkNHbs4+E+aWRTbrScARd1t+GyGFK/jgZSAhuICwkCiDH/zmIc5g1a7UCd3Qe3lxiQUcu/QZJ2YBVEMMnlTr2Rr/GPB3BCrUAzMit3MX6GOlbAZsaTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394744; c=relaxed/simple;
	bh=ARnbvmkPtYwGYXko7zrgfTAHXnZ+Czv5T0I2+9ZTc5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UQ0gqJeW3WlzlUPaV90IgVl4R/hW4EMcFZr5jdJm+BSwMYgksgCdJq/GhCMbeJAz2CK5smPRMWyz56Vz0kTAgm24nm+h5APOhn/r5Z4iQmzBn3Y2UJh4uthZkgx6iUNdmZQitzNGSBvy7ngFBTNrhhFZWjHGTJrMy5XaDSlqMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czdVRUvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czdVRUvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEE91F000E9;
	Thu, 30 Jul 2026 06:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785394727;
	bh=sQDumq0f7G6HZ+H2nVrSkM6iitVz7qK0gMcpsApEMOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=czdVRUvbGm8tYKXb63oNhVybPY4kRUMGCKczRwZU0lcamYpDKKpmvZ57ZebhmNZ6h
	 JET1h+v4bnNeS1Rj5kihx8nACeX3m705hXQ3qwRVpCMmPmG0coZiWn8s6QkP9fbDQk
	 e1AKH0o1G9gwAS8TB4mks/HoQ/+yDPrFNzyd37plWvm/KmsNcW+du/0Q3MQ2DWDddv
	 Lom9tsSkJ3n+xCTD3HNgO4wksvntaWeyU0yiVsqxFcyqnve3NbtnEWLY42P1ORRHeY
	 V3y1eXt7RLHe/Yd8i+dzYiRsJVj7+dKqXASsupi/JmYAM3UawuzCNmtgA39xHxXdOX
	 1vNoUp8Wco25Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRy2tQ50sBD-EGbKg-TANbVyE2m29eciCAomGGeZ2FeL3Q@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87ik5yhisv.ffs@fw13>
 <CABV8kRwf=WA-O_+NtEx2N38wO4qLJA7YBfDh1Ds88Et9hxjqXA@mail.gmail.com>
 <871pclhpqy.ffs@fw13>
 <CABV8kRy2tQ50sBD-EGbKg-TANbVyE2m29eciCAomGGeZ2FeL3Q@mail.gmail.com>
Date: Thu, 30 Jul 2026 08:58:44 +0200
Message-ID: <87tsphezff.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29 2026 at 10:47, Keno Fischer wrote:
> On Wed, 29 Jul 2026 15:47:17 +0200, Thomas Gleixner <tglx@kernel.org> wro=
te:
>> On Tue, Jul 28 2026 at 18:13, Keno Fischer wrote:
>>
>>> On Tue, Jul 28, 2026 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@kernel.or=
g> wrote:
>>>> Seems your mail client mangled the patch. See:
>>>
>>> Yeah, sorry about that, I've fixed that since. Gmail is a huge pain her=
e.
>>
>> Can you please resend then?
>>
> Of course - resent below. Sorry again for the hassle.

It's slightly less mangled than the original one, which replaced tabs
with spaces in some places, but still fails to apply out of the box.

> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -982,8 +982,11 @@ static int handle_futex_death(u32 __user *uaddr,
> struct task_struct *curr,

Forced line break. Still causes:

Applying: futex: Prevent robust futex exit race more
error: corrupt patch at line 10

>  		return -1;
>
>  	/*
> -	 * Special case for regular (non PI) futexes. The unlock path in
> -	 * user space has two race scenarios:
> +	 * Special case for regular (non PI) futexes. Ordinarily, we do
> +	 * not perform any processing here unless the current thread was
> +	 * the owner of the futex (by the TID check below).
> +	 *
> +	 * However, the unlock path has three race scenarios:
>  	 *
>  	 * 1. The unlock path releases the user space futex value and
>  	 *    before it can execute the futex() syscall to wake up
> @@ -992,42 +995,70 @@ static int handle_futex_death(u32 __user *uaddr,
> struct task_struct *curr,

Ditto

>  	 * 2. A woken up waiter is killed before it can acquire the
>  	 *    futex in user space.
>  	 *
>  	 */
>  	owner =3D uval & FUTEX_TID_MASK;
>

This empty line got the leading space, which is prepended by diff,
stripped off. Some tools tolerate that, some not.

> -	if (pending_op && !pi && !owner) {
> -		futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
> -			   FUTEX_BITSET_MATCH_ANY);
> +	if (owner !=3D task_pid_vnr(curr)) {
> +		if (pending_op && !pi &&
> +		    (!owner || !(uval & FUTEX_WAITERS)))
> +			futex_wake(uaddr, FLAGS_SIZE_32 | FLAGS_SHARED, NULL, 1,
> +				   FUTEX_BITSET_MATCH_ANY);
>  		return 0;
>  	}
>

Same here.

> -	if (owner !=3D task_pid_vnr(curr))
> -		return 0;
> -
>  	/*
>  	 * Ok, this dying thread is truly holding a futex
>  	 * of interest. Set the OWNER_DIED bit atomically

Please send the patch to yourself, save the mail and try to apply
it with git am.


