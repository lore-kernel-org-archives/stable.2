Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798C49893A;
	Wed,  9 Sep 2026 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947734; cv=none; b=moeCjr8/dDhqEHAjWIOXD2rJZGpzLz581N0CWkIyuyE1YzD1JR+CMC9epE8IB+1yxHR878xVqYMjBV8LPhIdZ70Xi95Tbt1aHNsXB/NxJoXZs35dcU1yDqqbUOuP1651xRjmRYZUGdsbYoOYb/q28nRGH/+cPJpb1S/julXxgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947734; c=relaxed/simple;
	bh=bmb7F/KmHSolAVosZ3/3evD9wdGrdLkhhTytnse9zzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWCKRcLD9rmWKAgc22I20aUkDfKBkbA5WqVE9XAq6u8gv71YUBySgSqh93TShdO3lQEH79xgMXxlua7WlctyDYgJ1cTeYmB4QkESmkChnOTO+TcAKD/wVo18tz2/Cm+cqKUPzvOTc+dPpk4WK0z8+63/BX8wyLJnMCrTQBXET94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EESciEDl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EESciEDl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r5XQn9SuvKZL4DTuoGdXOdgvz47Ewuz3TXXvq+vUgwo=; b=EESciEDlQ+xy8dwFvNTaXVYvjH
	r/fYBv2OR8M3Fc/UYGG6H8n/TyMsO1jBQEf5eL15O/v6X5dgYRxUx/AcfdqlXbApM/wiEDdFD14XY
	8c/s17Ts7fPtA79hc+zmeCeEmV46ohXVAdjJmxfIbU2lZDcG2M6Jr3XupaGqslzi8cwh8fg16DJDz
	LUxMU4nMSsIwsUIoQEA3OoP2L4NMSZiAHGJCKj3hCY+dOMPHRjpexqCoPr7XOyeJYrh54ra4n2HAz
	iRl62mwuk0DK5GNH87SFSlD/ZYXJUJhrIimRmmBTwi8S1cJcoG8kU5HXi3SZ+izbiAjTllOLb8SK2
	jsscZ/Og==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4F1U-00000003gfr-0SNO;
	Wed, 09 Sep 2026 09:55:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 02DC23005AF; Wed, 09 Sep 2026 11:55:19 +0200 (CEST)
Date: Wed, 9 Sep 2026 11:55:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260909095518.GL776954@noisy.programming.kicks-ass.net>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecf223n4.ffs@fw13>

On Wed, Sep 09, 2026 at 11:08:31AM +0200, Thomas Gleixner wrote:
> On Wed, Sep 09 2026 at 10:04, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 12:15:21PM +0200, Frederic Weisbecker wrote:
> > Let me try and have a go :-)
> >
> >
> > do_exit()				de_thread() 			posix_timer_fn()
> >   exit_signal()				  LOCK siglock 			  posix_timer_send_sigqueue()
> >     LOCK siglock			  UNLOCK siglock 		    t = posix_timer_get_target()
> >     tsk->flags |= PF_EXITING; 						    LOCK siglock
> >     UNLOCK siglock			  if (!thread_group_leader) 	      if (!list_empty(sigqueue))
> >     					    LOCK tasklist_lock
> >     flush_sigqueue_list();		    if (leader->exit_state)
> > 					      break;
> >   ...                                       transfer_pid()
> > 					    UNLOCK tasklist_lock
> >   exit_notify()
> >     LOCK tasklist_lock
> >     tsk->exit_state = EXIT_ZOMBIE;
> >     UNLOCK tasklist_lock
> >
> >
> >
> > Then there is indeed nothing that makes sure posix_timer_fn() sees
> > sigqueue updates done by do_exit(), because those are ordered by
> > tasklist_lock, but posix_timer_fn() doesn't care about that.
> 
> That's irrelevant because in the above scenario posix_timer_fn() 't'
> points to the exiting old leader (on the left) because the PID store has
> not happened yet and it therefore observes PF_EXITING on it so it won't
> touch the sigqueue. Note, that setting and checking PF_EXITING is
> serialized by sighand lock, so this is fine.

There is nothing that constraints the 3rd column from happening before,
it could happen after transfer_pid().

> > The easy solution would probably be to do transfer_pid() while holding
> > siglock?
> 
> That'd be only relevant for the situation Frederic is concerned about,
> i.e. the case where the third party observes the TID swap.

That is the case I was aiming at.

> Because with that visible 't' in posix_timer_send_sigqueue() won't be
> old_leader, which has PF_EXITING set, it will be new_leader which has it
> not set.

Same as above, there is nothing constraining the 3rd column from sliding
up or down. If it manages to see the new_leader, I don't see why it
would see the sigqueue flush.

> So Frederic is concerned that posix_timer_send_sigqueue() can observe
> the PID store but not observe the sigqueue stores.
> 
> I argue that's not possible:
> 
> A:  sigqueue stores
> 
> B:   AQUIRE tasklist
> 
> C:   exit_state store
> 
> D:   RELEASE tasklist
>      // sigqueue and exit_state stores become globally visible
>  ------------------------------------------------------------------------
> 
> E                               ACQUIRE tasklist
>  ------------------------------------------------------------------------
> F                                if (exit_state)
> 				   swap_pid()
> G                                     STORE_PID
> 
> 				// The PID store can become visible in the
> 				// system right here so F can observe them before
> 				// RELEASE tasklist

The STORE_PID is not a STORE_RELEASE.

> H                                                             READ PID

And this READ is not LOAD_AQUIRE; although the LOCK siglock is probably
sufficient here. The READ MUST happen before LOCK siglock by means of
data dependency, and then the LOCK will constrain later loads.

> 							      ....
> I                                		              ACQUIRE siglock
> 
> After #A the sigqueue stores are maybe visible
> 
> After #C the exit_state store is maybe visible
> 
> After #D both #A and #C are guaranteed to be visible to _ALL_ agents in
> the system and cannot become magically become invisible after that
> point.

No, that is not in fact how Power (or ARM) works AFAICT. Memory ordering
is not global. It is entirely possible some CPUs see a store while
others do not.

The only guarantee here is that IF you acquire tasklist_lock (you
observe the store that unlocked it), you will also observe preceding
stores.  But since the posix_timer_fn() column does not in fact observe
or care about tasklist_lock, there is no ordering.

> The new leader cannot swap PIDs before acquiring task list lock and
> before it observed exit_state != 0 under it. That's fully serialized
> against the old leader as both hold task list lock for their operations.
> 
> #F creates a control dependency, so if the new leader acquires task list
>    lock before the old it will observe 0, drop the lock and wait. No PID
>    store obviously.

A control dependency only ensure *that* CPU will complete the exit_state
load before the store, it is a local LOAD->STORE ordering.

> #G can be come visible immediately but is only guaranteed to be visible
>    globally at the RELEASE of tasklist lock.

Nope, not at all. Can be randomly visible to random sets of CPUs.

> #H can only observe the PID store after the store actually happened in
>    #G. So it either reads the original PID or the swapped PID.

Sure. But that has no bearing on if it sees the sigqueue stores at A.

> #I is not really relevant for this. It's only relevant for PF_EXITING
>    and other stuff which is directly protected by it. And it does not
>    matter whether it locks the old or the new sighand.
> 
> Now let's look at the full chain and what can possibly be visible or not
> and when:
> 
> #A can trickle into the tasklist held section, but not after #D.

Yup.

> #C cannot be reordered against #B and #D

Agreed.

> #A is therefore guaranteed to be globally visible _before_ new leader
>    observes exit_state != 0 in #F under task list lock

Nope, A is therefore visible if you acquire tasklist_lock, specifically,
when you observe the store from D. And only if that matching LOAD is a
LOAD-ACQUIRE, such that subsequent loads are forced to be later.

> #G cannot be reordered against #F and obviously not against #E either.

Indeed.

>    It can become visible at any point after the store, but as argued
>    above that visibility can't be reordered before #A (sigqueue stores)
>    became visible.

Let G' be the unnamed RELEASE after G.

Now, I have deleted and rewritten this tail end at least twice now. And
I *think* I'm agreeing with you. Let me explain:

It all hinges on D-E and H-I.

D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
RELEASE+ACQUIRE. Specifically, we have:

  RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
  UNLOCK+LOCK:     RCtso, the hand-over is store-ordering

So while earlier I was arguing with RCpc in mind, in which case D-E
completely goes away and we can consider B-G' to be one big critical
section from the PoV of a third CPU (our posix_timer_fn() one). In this
case we can push A down and G up and have them cross.

*However*, since these are locks, we actually have D-E be UNLOCK+LOCK,
which is RCtso and that *does* impose store order, so A stores must
happen before G stores

Combine with H-I, which has a data dependency from the LOAD to the LOCK
and thereby constraints later LOADs, those sigqueue loads that come
after I must in fact observe the A stores.


