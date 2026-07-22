Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FD33F385;
	Wed, 22 Jul 2026 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730077; cv=none; b=XYQXWTjb7otVrsTBFAAYnHICanrsgqGRNPaK9HGBRItN5HOWiNInkJJBFP0FpP3rQI03Dkc5mgtwwdj7SQOm5CMQfROv3N8kl+ayWHG59aWXEqb1i4X1tTTT5ooe9Y3QFzp6Lzt3JBoJPPtOsjZ9geDuthNLwUey+GhEFzAbKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730077; c=relaxed/simple;
	bh=TBD5GS73HvKcRw4ejp9S3VBYu7j42YDqAUnp8yZx1YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AEMyCg0KxA9Qjtf+t8X2GstnLVqtAKPguL4EzKYoNQorsfWl9QponDrLibmc6IKJ8lqKKy18iBLYu/EF9ffmtbgPKZAaiJxB6Bb9d1b9l1cCLLX51PpSdP9rVn6KN6nXtZFaoaGopLeYWEew+I4I8qV7FxyFHV3ge4VkldPLUls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7WH51yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7WH51yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72C71F000E9;
	Wed, 22 Jul 2026 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730075;
	bh=V25MI5Dit3f0J3X5CuwyndUl8/inbVjKAwXIS3THFBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=E7WH51yiO3h3oGIV0KfZRipmjerdu7ZsCdyNaKQZhi7/cA4NIINBwoUu2lETpHdZh
	 mPqZj2DHy2jBw584gcdwQ/SsBiSmvOXIbvOGyOkAtLe1QVnZ0/qSZ1Vcnx+WjBV2hq
	 WWutGypcDFRBn4URBjKn4scHZCQnFJQPJfB2uVm5kcPyuH4LETbpE8XAQWOR78+OWO
	 35pyq16ly2ASZWYbwHPGkjplIu0qWCsYob9t/jLLumO0Dc87KdgtLRFMAiYU3Xtdpx
	 CSV6rgQ2UGSxXOUUM1k8O+3dj5WiVIYjfoxy2jbkZIThwOZ6xuAzDG4DiEnOlV9TqZ
	 /rZ5XBLS4JGpA==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>
Cc: Ingo Molnar <mingo@redhat.com>, "Peter Zijlstra <peterz@infradead.org>,
 Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Florian Weimer
 <fweimer@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
Date: Wed, 22 Jul 2026 16:21:12 +0200
Message-ID: <87v7a7jeav.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 21 2026 at 12:50, Keno Fischer wrote:
> On Tue, 21 Jul 2026 14:24:34 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
>> On Mon, Jul 20 2026 at 23:26, Keno Fischer wrote:
>>> Fix this by augmenting the robust list exit processing to also
>>> perform the extra wakeup if the futex word is owned by another
>>> thread but FUTEX_WAITERS is *NOT* set.
>>
>> While your change "fixes" this particular problem, it leaves the related
>> UAF problem unsolved.
>>
>> The more complete solution is:
>>
>>    https://lore.kernel.org/all/20260602084648.462672743@kernel.org/
>>
>> which is upstream now. Specifically the combined unlock/wake part
>>
>>    https://lore.kernel.org/all/20260602090535.670514505@kernel.org/
>>
>> ensures that your scenario can't happen and provides at the same time
>> one part of the solution for the UAF exit race.
>
> Yes, I'm aware of that patch series.
> However, this is not quite the same race.
> As the updated comment indicates, the combined unlock/wake prevents one
> of the three race scenarios that causes problems.
> However, if a *woken up* task dies before it can re-acquire the futex,
> the kernel must still pass the baton down the line to the next task.
> The existing code handled this case for the scenario where there was no
> interfering third task (the second scenario in the original comment).
> However, the possibility that a third task could perform an uncontested
> acquire in the meantime was not accounted for.

Which means that the handling of the FUTEX_WAITER bit for robust non-PI
futexes in the unlock path is inconsistent, which means the
unconditional store 0 is the real problem.

We should rather fix that than hacking around it in the exit handling
code.

Let me think about it some more.

>>> This issues was discovered as part of a larger attempt to resolve the
>>> long-standing issue that robust futexes are not safely usable across
>>> pid namespaces.
>>
>> What's the actual problem with that?
>
> I was planning to write it up with that patch series, but here's
> the abbreviated version: Embedded databases (e.g. LMBD) use
> shared-memory robust mutexes (glibc pthread_mutex in the LMDB case)
> to coordinate access to the database file among users. However, if
> those users are in different pid namespaces, the mutex silently fails
> to provide mutual exclusion, causing corruption and hangs (bad for a
> database).

Unsurprisingly a robust futex depends on unique PIDs, which are not
obviously not guaranteed accross multiple PID namespaces.

TBH, I'm not really keen to see the hacks required to make this "work"
and thereby violating all isolation rules which come with namespaces.

Thanks,

        tglx


