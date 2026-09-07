Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826983B14D1;
	Mon,  7 Sep 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788812118; cv=none; b=IBtDI4JR0a+xjmPcQbrqFI3UZEg5sVdga5cjhIuk8OiXITnD8ceGihjL9rh481wqMPnhWO4t0hVf9BNv833xoOm2n9PHa5v0X1ncQmWPSH04ZFiO5pz549gwlvP8zJDlhkH9iFN+dR94gi6Sg8aTxnp0NNm4LF4j2k2cZd7Ezxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788812118; c=relaxed/simple;
	bh=zvCrV5OW3Ij4RNFWmI9bMKD+1/mIRvO5n8/sA7pCzVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdZZMGsSAzx1ivbfEP4T37O66CsiVynb39PNruLleUgWpfsRYZnCpX4Mqlt6p4DAZMLswbURdcz0YodfgzME2/N58C+S7bAf7fLfLx6wNWO7zzFgy8a+RjCWkmofUOcQ8Q3/qWsIzcYimeflrZF0Z1SwIeggpIAb+HjI2I8oGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0N7zsqe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0N7zsqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A848B1F00A3A;
	Mon,  7 Sep 2026 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788812117;
	bh=XKmOrRGwVI6oRygbDD+Nz06kpJ89aQIlbxw5wMUhI4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R0N7zsqeYlOgN4l3GiIhWcWwm9MaDKreUjYiIBDHN/w7PkaTI3U5ve8mMNNl69ar5
	 +aQtlwijdM7tr+0UsOpEDewv0JDmGUwTojgOofYx7pQiGZqyGb8Cnp+6RE5pZHQsRQ
	 U32W6Viw4zeIJk9SpdkOMQmqwucORhCvaVu0sN4DCeImlseHdC3H224Eo4XGmqF5N7
	 eH76yVOSVD9zPce5+n3ncPlzwgbSV4NWAR1XJzU/Ziwb25WT7C8TTdhINSfGvz0EuJ
	 p/refrB5fQAmfnIGasQ6igWX3zLXtcFRuFWt8xiszYEMUwqBF9he4kaQH3TO2THBjU
	 eiOMFzIpp1FcQ==
Date: Mon, 7 Sep 2026 22:15:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <ap8bUiYYwQT1nVg5@pavilion.home>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik4h2icz.ffs@fw13>

Le Mon, Sep 07, 2026 at 05:26:04PM +0200, Thomas Gleixner a écrit :
> On Mon, Sep 07 2026 at 14:31, Frederic Weisbecker wrote:
> > Le Sat, Sep 05, 2026 at 08:59:01PM +0200, Thomas Gleixner a écrit :
> >> -out:
> >> -	spin_unlock_irq(&tsk->sighand->siglock);
> >> +	flush_sigqueue_list(&sigq_list);
> >
> > It probably doesn't matter in practice, I don't know feel free to ignore,
> > but FWIW it looks like it's still vulnerable to the theoretical far fetched
> > race I described. The head is moved under the lock but individual nodes are
> > deleted without the lock.
> >
> > CPU 0                                CPU 1                   CPU 2
> > -----                                -----                   -----
> >
> > exit_signals()
> >    spin_lock(sighand)
> >    tsk->flags |= PF_EXITING;
> >    list_splice_init(&queue->list, head);
> >    spin_unlock(sighand)
> >
> >    list_for_each_safe(head, node)
> >       list_del_init(node)
> >          node->next = node // A
> >          node->prev = node // B
> > ...
> >                                      de_thread()
> >                                         // acquired tsk->flags
> >                                         // and signal flushed
> >                                         // through tasklist_lock
> >                                         transfer_pid() // C
> >                                                            
> >                                                            posix_timer_fn()
> >                                                               posixtimer_send_sigqueue()
> >                                                                  // OBSERVES C
> >                                                                  t = posixtimer_get_target(tmr)
> >                                                                  lock_task_sighand()
> >                                                                     // OBSERVES A
> >                                                                     if (!list_empty(q))
> >                                                                        // BUT NOT B
> >                                                                        list_add_tail(q) // D
> >
> > Then who knows which write wins, B or D?
> 
> For a moment you almost convinced me, but that's not possible:
> 
>     de_thread()
>         ....
> 
> 	if (!thread_leader()) {
>             wait_until(old_leader->exit_state);
> 
>             transfer_pid();
> 
> old_leader sets the exit_state in exit_notify():
> 
>     do_exit()
>       exit_signals()
>         lock(sighand)
>           old_leader->flags |= PF_EXITING;
>           head = remove_signals()
>         unlock(sighand)
>         flush_list(head)
>      ...
>      exit_notify()
>        old_leader->exit_state = EXIT_XXX;
> 
> From a program order POV the flush is completed _before_ the new leader
> can observe old_leader->exit_state and swap TIDS. exit_notify() and the
> wait in de_thread() are serialized via tasklist_lock.

Yes on that side all is program order. But the ordering is not mirrored on
the other side (at this stage of the patchset).

> 
> The signal is either dropped before transfer_pid() is observable due to
> PF_EXITING on the old leader or queued on the new leader and then
> discarded in posixtimer_exit() -> flush_itimer_signals().
> 
> The only valid question is whether it is guaranteed that on a weakly
> ordered system the stores in flush_sigqueue_list() are visible _before_
> transfer_pid() is visible to the third party.
> 
> It's not obvious of course and might deserve a comment.
> 
>       exit_signals()
>         lock(sighand)
>           old_leader->flags |= PF_EXITING;
>           head = remove_signals()
> #1      // RELEASE: PF_EXITING must become visible
>         unlock(sighand)
>         flush_list(head)
> 
>      ...
>      posixtimer_exit()
>        posix_cpu_timers_exit_task()
>         lock(sighand)
>         ...
> #2      // RELEASE: The stores in flush_list() must become visible
>         //          They might be already in case of preemption
>         //	    or due a RELEASE operation in seccomp_filter_release()
>         unlock(sighand)

That second step only appears at the end of the patchset, right? Otherwise
it's done on release_task(), which is after transfer_pid().

> 
>     ...
>     exit_notify()
>       lock(task_list_lock)
>       exit_state = EXIT_ZOMBIE;
> #3    // RELEASE: exit_state must become visible
>       unlock(task_list_lock)
> 
> So the new leader cannot proceed before #3 which means it can't swap
> TIDs before that point. That requires task_list_lock so there is no way
> that the TID swap can trickle before the lock is held and exit_state
> being non-zero.
> 
> Though the important part is that the third party on CPU3 has to acquire
> sighand lock in posixtimer_send_sigqueue(), which is an ACQUIRE
> operation. That means _all_ accesses to tsk::flags and to the sigqueue
> must happen _after_ the lock is acquired.
> 
> If it acquires it after #1 and before the TID swap it must observe
> PF_EXITING and return immediately. So a concurrent modification of
> timer::sigqueue in flush_list() or not-yet visible stores are
> irrelevant.
> 
> If it acquires it after #2 it must observe the full writes to the
> sigqueue. So after that point it does not longer matter whether the PID
> resolves to T1 or T2.
> 
> No?

At the end of the patchset yes. But it doesn't look that way in this
very patch which is to be backported alone.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
