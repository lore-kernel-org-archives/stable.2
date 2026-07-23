Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2144963A4;
	Thu, 23 Jul 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811204; cv=none; b=lAPyrq6neEodmNiIJRAC226C2NfnPW5ELglrU6iTWCDi16zthu8E876dCv86LmjkuPkxglmyGua0SmP56lgYcdJaFY3xBJyY4mr1/HVe6nTxz4Spb9LaxgM8RMY0QK5rWMfXJdeN4GNGDpm9ExDepUJgzUa9HRbakV+gHayfqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811204; c=relaxed/simple;
	bh=DEg/uj+li6nxzxLWwo0dFdUGTZ9wV2cx4oGDXXTLt0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/8VQ2Iye8YY96alS/i9E9vf1RqSTCve+I3i0X47zb2Kp17ai4ZU2FDnsAc/REXOy8AeL9BQ5+Rqc1siJeXpbiYH9vho0SLdgZ1iiu//hsAMA+IZFcR9ojroK4H4IkVUvTs+CuhFpyddtUBEx79TxgGb9rZFonSM1KaQZQwylaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49A31F00A3A;
	Thu, 23 Jul 2026 12:53:19 +0000 (UTC)
Date: Thu, 23 Jul 2026 14:53:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Keno Fischer <keno@juliahub.com>, Ingo Molnar <mingo@redhat.com>, 
	"Peter Zijlstra <peterz@infradead.org>, Darren Hart" <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Yang Tao <yang.tao172@zte.com.cn>, 
	Yi Wang <wang.yi59@zte.com.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, 
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] futex: Prevent robust futex exit race more
Message-ID: <20260723-obgleich-kippt-gegeben-c84192e6d6bb@brauner>
References: <CABV8kRwvex1VvQ0eGwUQmJL_vA7AP2h64VpHqtXvfOXMvvJQZA@mail.gmail.com>
 <87bjc0led9.ffs@fw13>
 <CABV8kRwDhwa_OoQ9zx4sv3tDATZc0Yy-mYGObRXw59DO0cDfLw@mail.gmail.com>
 <87v7a7jeav.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7a7jeav.ffs@fw13>

On Wed, Jul 22, 2026 at 04:21:12PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 12:50, Keno Fischer wrote:
> > On Tue, 21 Jul 2026 14:24:34 +0200, Thomas Gleixner <tglx@kernel.org> wrote:
> >> On Mon, Jul 20 2026 at 23:26, Keno Fischer wrote:
> >>> Fix this by augmenting the robust list exit processing to also
> >>> perform the extra wakeup if the futex word is owned by another
> >>> thread but FUTEX_WAITERS is *NOT* set.
> >>
> >> While your change "fixes" this particular problem, it leaves the related
> >> UAF problem unsolved.
> >>
> >> The more complete solution is:
> >>
> >>    https://lore.kernel.org/all/20260602084648.462672743@kernel.org/
> >>
> >> which is upstream now. Specifically the combined unlock/wake part
> >>
> >>    https://lore.kernel.org/all/20260602090535.670514505@kernel.org/
> >>
> >> ensures that your scenario can't happen and provides at the same time
> >> one part of the solution for the UAF exit race.
> >
> > Yes, I'm aware of that patch series.
> > However, this is not quite the same race.
> > As the updated comment indicates, the combined unlock/wake prevents one
> > of the three race scenarios that causes problems.
> > However, if a *woken up* task dies before it can re-acquire the futex,
> > the kernel must still pass the baton down the line to the next task.
> > The existing code handled this case for the scenario where there was no
> > interfering third task (the second scenario in the original comment).
> > However, the possibility that a third task could perform an uncontested
> > acquire in the meantime was not accounted for.
> 
> Which means that the handling of the FUTEX_WAITER bit for robust non-PI
> futexes in the unlock path is inconsistent, which means the
> unconditional store 0 is the real problem.
> 
> We should rather fix that than hacking around it in the exit handling
> code.
> 
> Let me think about it some more.
> 
> >>> This issues was discovered as part of a larger attempt to resolve the
> >>> long-standing issue that robust futexes are not safely usable across
> >>> pid namespaces.
> >>
> >> What's the actual problem with that?
> >
> > I was planning to write it up with that patch series, but here's
> > the abbreviated version: Embedded databases (e.g. LMBD) use
> > shared-memory robust mutexes (glibc pthread_mutex in the LMDB case)
> > to coordinate access to the database file among users. However, if
> > those users are in different pid namespaces, the mutex silently fails
> > to provide mutual exclusion, causing corruption and hangs (bad for a
> > database).
> 
> Unsurprisingly a robust futex depends on unique PIDs, which are not
> obviously not guaranteed accross multiple PID namespaces.

Fwiw, I added unique inode numbers for the lifetime of the system to
pidfds some time ago. The inode number is allocated for every struct pid
and available via pid->ino. A pidfd can be stat()ed to retrieve it. Just
mentioning it in case this may be useful.
