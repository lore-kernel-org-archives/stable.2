Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE45253340;
	Tue, 21 Jul 2026 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636678; cv=none; b=Uwyb6bUBLR9DKoSxKYFjTUbZ0QOjsC7fTUnid5YkcvcL2LiFlKvZUL7fpOrXOu+/0kCQfY+Rjk3r0O0xq6CdMhoWnLDaRdZnva4xxCuTb/Wxq4QE3NKrm6SlgI+gbDGwNIDOEMrzrGaycRvDwwckSbpjHUECChHB6zO+OtqiT14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636678; c=relaxed/simple;
	bh=pvpeZDgLiDWQ0heyvFlN58zBcq68S0p2QQ7hxAgLMUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mo8lLRR5eTJnHxgMUjg55q0z2MmO++VhYhL2A5U0EJnOgOwYqizKfRlEXGQdOseZPzNDdWjHiI6ea5dwAGfOKZCNZklwVcdLqwVLKKp1gQ3f2sdeCfokvDP6zmzkBKXAUaoRE67e0KawIaakMWUFuQfHIvQQgOTSyBoeOnym1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6DU2k5r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6DU2k5r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087C1F000E9;
	Tue, 21 Jul 2026 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636677;
	bh=pG+5WN9Jez0zYsxeyIi8/ea2ndoBE14szbb0nglK664=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=C6DU2k5r/GV14DaF4ofiYhUTe81746IQgcWN4RIladbUfRhPQmIkEpE/YJwXr0IFI
	 WaQaPZZk1f1pNcMGM/PuHrt7TdHeddi1Ul2uh2pqD1mbWAK2Jbj74fSUz8UbFExjV+
	 +kCIZKfwc0BzZOnXp/pmKOre4oMWWUIBMo3rfMcApby4Y2EnWlKrAyt/wsIStgdaks
	 xyzlQDAVWOJl2TH/azlhHQ6TOeaYf9Grnuy856dZpp1F8FnxmoerIGb7XWDo0BAd53
	 HYe/08FmDMaIugquRAd1u2Ya81fFksLzHHpLORoZOk+s9DifaNjCHenKmr+ckz8xTf
	 F+fEevDdWC43Q==
From: Thomas Gleixner <tglx@kernel.org>
To: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Yang Tao
 <yang.tao172@zte.com.cn>,
 Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
In-Reply-To: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
Date: Tue, 21 Jul 2026 14:24:34 +0200
Message-ID: <87bjc0led9.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 20 2026 at 23:26, Keno Fischer wrote:
> If a third task re-acquired the futex through the uncontended fast
> path in the meantime, the notification is lost: Robust exit processing
> sees that it is owned by another task and does nothing, while the new
> owner sees no FUTEX_WAITERS when it unlocks and wakes nobody.
> The remaining waiters sleep forever behind a free futex:
>
>   A owns the futex, B and C sleep in FUTEX_WAIT
>                                         uval == A | FUTEX_WAITERS
>   A robust unlock: store 0, FUTEX_WAKE(1) wakes B
>                                         uval == 0
>   D fast path acquire: cmpxchg(0 -> D)
>                                         uval == D, no FUTEX_WAITERS
>   B killed before acting on the wakeup
>   B exit walk, pending op: owner D != B -> no action
>   D unlock: no FUTEX_WAITERS -> no wake
>                                         C sleeps forever
>
> Fix this by augmenting the robust list exit processing to also
> perform the extra wakeup if the futex word is owned by another
> thread but FUTEX_WAITERS is *NOT* set.

While your change "fixes" this particular problem, it leaves the related
UAF problem unsolved.

The more complete solution is:

   https://lore.kernel.org/all/20260602084648.462672743@kernel.org/

which is upstream now. Specifically the combined unlock/wake part

   https://lore.kernel.org/all/20260602090535.670514505@kernel.org/

ensures that your scenario can't happen and provides at the same time
one part of the solution for the UAF exit race.

> This issues was discovered as part of a larger attempt to resolve the
> long-standing issue that robust futexes are not safely usable across
> pid namespaces.

What's the actual problem with that?

Thanks,

        tglx
