Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864654EEA5;
	Wed,  9 Sep 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956000; cv=none; b=uhsCq+umAoWJ2Zh6w/cEei5kUmVcq+NQy/XQ9TYzdaqNWOvE3EAGpPqPd+QHDR17k9WJiPDo3nMga4U/ytiN81eGKakJ6hNKpT1Gjw3B4ImW0cEwzRTWTJlizEypyyiaZSNrC5GUlEwYXwDz4gAV4AyooH6MjIOALhZKXMm/OiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956000; c=relaxed/simple;
	bh=nlRgJomXfHpAVbYKroH6LjYo9IjZ77ZyiMYCtnnpDG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/C7aEBuycXXe2tmZNTLMkf/zUZAnTnBuDrOUeH7nKxQsMX7jVM5yhTR2uLjgVvFTOIwF8DUzf+yrPrMRLKRDEiegRk48GFrTeJ4/ben/QhI0ArxrSgZrYprx9AIvLjZY8DmS+zl+dIXhw9wKszOMMtl+psEnPE4U+MITVArjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu6r4Hdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu6r4Hdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20951F00A3A;
	Wed,  9 Sep 2026 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955994;
	bh=DA6PfbLnlJANArEu06inY89Mrm2FdtKrjjM7FCGSyn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pu6r4HdiNiBuj4BNAI/9WPHDVnT4CJNFSso0lIDCiNBBlY4fgwCdaSzfO9184iy/P
	 MSb2ZERYJpEpztUWwCUXtOhx/gH2U9lktdsbL0diKIlzUhILyyz2+wZPh5v4jsu8tv
	 m0HyTswgWupmcHR4v/Pg2J8QuwDXTiJT3vhfwJSDcjNc36l4KWtybAQF0pki/nAeU2
	 gB2427Y3qcQcEwmk0ZO6Za+eAaOiFaXure1YkX69xptTB2S9kpSzrtbyj2bxSIl14/
	 eCeG9uOGHKItjA4kSpL7JQ193rGca84M71ObuvzyRcnqfXNSfau9YlhyCSZSao+ZQA
	 B/qabtRLTTKNg==
Date: Wed, 9 Sep 2026 14:13:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqFNV4k6DcbyxYCe@localhost.localdomain>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909095518.GL776954@noisy.programming.kicks-ass.net>

Le Wed, Sep 09, 2026 at 11:55:18AM +0200, Peter Zijlstra a écrit :
> On Wed, Sep 09, 2026 at 11:08:31AM +0200, Thomas Gleixner wrote:
> > On Wed, Sep 09 2026 at 10:04, Peter Zijlstra wrote:
> > > On Tue, Sep 08, 2026 at 12:15:21PM +0200, Frederic Weisbecker wrote:
> > > Let me try and have a go :-)
> > >
> > >
> > > do_exit()				de_thread() 			posix_timer_fn()
> > >   exit_signal()				  LOCK siglock 			  posix_timer_send_sigqueue()
> > >     LOCK siglock			  UNLOCK siglock 		    t = posix_timer_get_target()
> > >     tsk->flags |= PF_EXITING; 						    LOCK siglock
> > >     UNLOCK siglock			  if (!thread_group_leader) 	      if (!list_empty(sigqueue))
> > >     					    LOCK tasklist_lock
> > >     flush_sigqueue_list();		    if (leader->exit_state)
> > > 					      break;
> > >   ...                                       transfer_pid()
> > > 					    UNLOCK tasklist_lock
> > >   exit_notify()
> > >     LOCK tasklist_lock
> > >     tsk->exit_state = EXIT_ZOMBIE;
> > >     UNLOCK tasklist_lock
> > >
> > >
> > >
> > > Then there is indeed nothing that makes sure posix_timer_fn() sees
> > > sigqueue updates done by do_exit(), because those are ordered by
> > > tasklist_lock, but posix_timer_fn() doesn't care about that.
> > 
> > That's irrelevant because in the above scenario posix_timer_fn() 't'
> > points to the exiting old leader (on the left) because the PID store has
> > not happened yet and it therefore observes PF_EXITING on it so it won't
> > touch the sigqueue. Note, that setting and checking PF_EXITING is
> > serialized by sighand lock, so this is fine.
> 
> There is nothing that constraints the 3rd column from happening before,
> it could happen after transfer_pid().
> 
> > > The easy solution would probably be to do transfer_pid() while holding
> > > siglock?
> > 
> > That'd be only relevant for the situation Frederic is concerned about,
> > i.e. the case where the third party observes the TID swap.
> 
> That is the case I was aiming at.
> 
> > Because with that visible 't' in posix_timer_send_sigqueue() won't be
> > old_leader, which has PF_EXITING set, it will be new_leader which has it
> > not set.
> 
> Same as above, there is nothing constraining the 3rd column from sliding
> up or down. If it manages to see the new_leader, I don't see why it
> would see the sigqueue flush.
> 
> > So Frederic is concerned that posix_timer_send_sigqueue() can observe
> > the PID store but not observe the sigqueue stores.
> > 
> > I argue that's not possible:
> > 
> > A:  sigqueue stores
> > 
> > B:   AQUIRE tasklist
> > 
> > C:   exit_state store
> > 
> > D:   RELEASE tasklist
> >      // sigqueue and exit_state stores become globally visible
> >  ------------------------------------------------------------------------
> > 
> > E                               ACQUIRE tasklist
> >  ------------------------------------------------------------------------
> > F                                if (exit_state)
> > 				   swap_pid()
> > G                                     STORE_PID
> > 
> > 				// The PID store can become visible in the
> > 				// system right here so F can observe them before
> > 				// RELEASE tasklist
> 
> The STORE_PID is not a STORE_RELEASE.
> 
> > H                                                             READ PID
> 
> And this READ is not LOAD_AQUIRE; although the LOCK siglock is probably
> sufficient here. The READ MUST happen before LOCK siglock by means of
> data dependency, and then the LOCK will constrain later loads.
> 
> > 							      ....
> > I                                		              ACQUIRE siglock
> > 
> > After #A the sigqueue stores are maybe visible
> > 
> > After #C the exit_state store is maybe visible
> > 
> > After #D both #A and #C are guaranteed to be visible to _ALL_ agents in
> > the system and cannot become magically become invisible after that
> > point.
> 
> No, that is not in fact how Power (or ARM) works AFAICT. Memory ordering
> is not global. It is entirely possible some CPUs see a store while
> others do not.
> 
> The only guarantee here is that IF you acquire tasklist_lock (you
> observe the store that unlocked it), you will also observe preceding
> stores.  But since the posix_timer_fn() column does not in fact observe
> or care about tasklist_lock, there is no ordering.
> 
> > The new leader cannot swap PIDs before acquiring task list lock and
> > before it observed exit_state != 0 under it. That's fully serialized
> > against the old leader as both hold task list lock for their operations.
> > 
> > #F creates a control dependency, so if the new leader acquires task list
> >    lock before the old it will observe 0, drop the lock and wait. No PID
> >    store obviously.
> 
> A control dependency only ensure *that* CPU will complete the exit_state
> load before the store, it is a local LOAD->STORE ordering.
> 
> > #G can be come visible immediately but is only guaranteed to be visible
> >    globally at the RELEASE of tasklist lock.
> 
> Nope, not at all. Can be randomly visible to random sets of CPUs.
> 
> > #H can only observe the PID store after the store actually happened in
> >    #G. So it either reads the original PID or the swapped PID.
> 
> Sure. But that has no bearing on if it sees the sigqueue stores at A.
> 
> > #I is not really relevant for this. It's only relevant for PF_EXITING
> >    and other stuff which is directly protected by it. And it does not
> >    matter whether it locks the old or the new sighand.
> > 
> > Now let's look at the full chain and what can possibly be visible or not
> > and when:
> > 
> > #A can trickle into the tasklist held section, but not after #D.
> 
> Yup.
> 
> > #C cannot be reordered against #B and #D
> 
> Agreed.
> 
> > #A is therefore guaranteed to be globally visible _before_ new leader
> >    observes exit_state != 0 in #F under task list lock
> 
> Nope, A is therefore visible if you acquire tasklist_lock, specifically,
> when you observe the store from D. And only if that matching LOAD is a
> LOAD-ACQUIRE, such that subsequent loads are forced to be later.
> 
> > #G cannot be reordered against #F and obviously not against #E either.
> 
> Indeed.
> 
> >    It can become visible at any point after the store, but as argued
> >    above that visibility can't be reordered before #A (sigqueue stores)
> >    became visible.
> 
> Let G' be the unnamed RELEASE after G.
> 
> Now, I have deleted and rewritten this tail end at least twice now. And
> I *think* I'm agreeing with you. Let me explain:
> 
> It all hinges on D-E and H-I.
> 
> D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
> RELEASE+ACQUIRE. Specifically, we have:
> 
>   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
>   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering
> 
> So while earlier I was arguing with RCpc in mind, in which case D-E
> completely goes away and we can consider B-G' to be one big critical
> section from the PoV of a third CPU (our posix_timer_fn() one). In this
> case we can push A down and G up and have them cross.
> 
> *However*, since these are locks, we actually have D-E be UNLOCK+LOCK,
> which is RCtso and that *does* impose store order, so A stores must
> happen before G stores
> 
> Combine with H-I, which has a data dependency from the LOAD to the LOCK
> and thereby constraints later LOADs, those sigqueue loads that come
> after I must in fact observe the A stores.

I didn't know about all those UNLOCK+LOCK properties. Well,
I know that UNLOCK+LOCK on the same lock, or on different locks
but the same CPU, equals smp_mb() except on powerpc. Which is why
we have smp_mb__after_unlock_lock(). But what you describe is quite
different.

Is this something that we should expect litmus to modelize?

Because the following doesn't verify that:
---
C MP+farfetched

{}

P0(int *next, int *prev, int *exit_state, spinlock_t *tasklist_lock)
{
	// list_del_init()
	WRITE_ONCE(*next, 1);
	WRITE_ONCE(*prev, 1);
	// exit_notify()
	spin_lock(tasklist_lock);
	WRITE_ONCE(*exit_state, 1);
	spin_unlock(tasklist_lock);
}

P1(int *exit_state, int *pid, spinlock_t *tasklist_lock)
{
	int r0;

	// de_thread()
	spin_lock(tasklist_lock);
	r0 = READ_ONCE(*exit_state);
	if (r0 == 1) {
		// exchange_tids()
		WRITE_ONCE(*pid, 1);
	}
	spin_unlock(tasklist_lock);
}

P2(int *next, int *prev, int *pid, spinlock_t *sighand)
{
	int r0;
	int r1;
	// get target
	r0 = READ_ONCE(*pid);
	spin_lock(sighand);
	// queue signal
	r1 = READ_ONCE(*next);
	if (r1 == 0)
		WRITE_ONCE(*prev, 2);
	spin_unlock(sighand);
}

exists (prev=1 /\ 2:r0=1) (* Bad outcome. *)
---
herd7 -conf linux-kernel.cfg ~/farfetched.litmus 
Test MP+farfetched Allowed
States 4
2:r0=0; [prev]=1;
2:r0=0; [prev]=2;
2:r0=1; [prev]=1;
2:r0=1; [prev]=2;
Ok
Witnesses
Positive: 2 Negative: 7
Condition exists ([prev]=1 /\ 2:r0=1)
Observation MP+farfetched Sometimes 2 7
Time MP+farfetched 0.02
Hash=a44733c870613a81ae096a93babe215
