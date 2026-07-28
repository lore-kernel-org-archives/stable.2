Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85D370AC2;
	Tue, 28 Jul 2026 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274176; cv=none; b=KjftkPsysc0LiUeDlM7Egtp9M9T6XdV42Y43k+uNTGnNQ7HNJZh9NZzqIU3tm7Ilum328gdtnpqrwfpSkDv1AHUoQwpla6LzqpF32wmFg/rl9rieu49+ibdScjw8RG5cmlHfVNfaFeS8QDqmAh9blJx5JPEhTnzwG8dmU8dPRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274176; c=relaxed/simple;
	bh=CXA8inj0GxqAD1MGJVIW7bx4ifNsrpcAuc54JBaetuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JEfn+LEsKWmghsy24tX73aSzDNQmsXsoUYw2T7xohnaTJg7jJFcCmPlftc+T0sQz+wIxEfcwhlUWjbuMOU6cqR0rMeBaAnRFSQ2y/SksbJKqo2UPaZZfmUSL41FJjpR2hPuNItfjvEmLwSbthbCwDiyIg9nn2qrZ+h1A0/MBJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuc/9NIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuc/9NIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8391F000E9;
	Tue, 28 Jul 2026 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785274175;
	bh=uUCVWIcuHfvmoFpYy7qJfcNSK65Nn1BPbtNKfMwPaXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kuc/9NIKdXqHc4mulOni3rlg7XcU0fPIQZhUe6OzXStSpqYheqWyO/OMi3y36BOos
	 D5EGFzOdwpb6GCHTwMuv8wEKwViiin9IpqKSS3OMuAWUiihlVwttR+iMufQbYr6f40
	 HrMuycJTjDPmkvfmgl5M4VeyLj+DZiN4uW/PUR6HN35nNF0m873CUfablbPbhTfd5M
	 7nerbBDFHNj2mbdJoSTR7j81M9cOjj3oMlBZ6I1E+IbG2k75tgmm8IIcsl6J43EOo9
	 IgVSYRQIRdV2XFNHyhc6J8xbZcKsI3ZfupLy1xgQ+CvK+l2ZHxXsooAUGh/wL+TMFn
	 P5BbXo5LKAy/g==
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
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <87o6fqhpcw.ffs@fw13>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
 <CABV8kRz5c4opGVA3CPdALWxjUH_DkLf_tBLdefajsSevfHFYpQ@mail.gmail.com>
 <87zezdiiyg.ffs@fw13>
 <CABV8kRz1nLxUDAgCSKHB2oqME74M6PyxB-t+u1it=6eYo5cFAQ@mail.gmail.com>
 <87ldawinki.ffs@fw13>
 <CABV8kRw92-0sx6Mi=z5pzCA9gEE9nnBbTjwKHzEr35DpSk6keg@mail.gmail.com>
 <87o6fqhpcw.ffs@fw13>
Date: Tue, 28 Jul 2026 23:29:31 +0200
Message-ID: <87ldauhkg4.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28 2026 at 21:43, Thomas Gleixner wrote:
> On Mon, Jul 27 2026 at 13:23, Keno Fischer wrote:
>
>> On Mon, Jul 27, 2026 at 9:12=E2=80=AFAM Thomas Gleixner <tglx@kernel.org=
> wrote:
>>> Reworked version below.
>>
>> Patch looks good and passes all my local tests! Thanks!
>
> Let me write a change log then ...

While doing so I thought about your initial fix some more.

I still hate it because it papers over the underlying problem, but on
the other hand it'll take quite some time until the robust unlock
changes will be adopted by libraries and backport wise this is innocuous
enough. So I'm going to apply it under protest :)

Rusty Russel said in 2002: "Futexes are really cursed." See
kernel/futex/core.c::31

Maybe I should remove that comment to put that to an end :)

Thanks,

        tglx
