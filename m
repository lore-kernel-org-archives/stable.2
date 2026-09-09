Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652154A7F8;
	Wed,  9 Sep 2026 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957969; cv=none; b=rNedLmh6SlywkFlzahNadW7r3lAQtdBaKqIwTK7p380Gl9dIDZ2bkOU9cP2cUxmbWlZmAU03R+IEi+wodAfahLVLHm9hC5vtuA/k0IHLpVXGJMZxlaLusp4v4vm1+ilp/WERGh04nvT2XL3yR4VeAuurh3r95PTLx+lIeatyM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957969; c=relaxed/simple;
	bh=yeHeu3vX+th5CG7zE0HnD4HIfm5dRkNzk/L1A3C9ei0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK4LbM8eUnuMM83aKHYIIWU2g3c2WdS8MK/9f9nGsZHw7X3YLraOwKJPV4SQnqp4IZ6i3uExRQnwgBg4jxg0Gw+3Bv1x1BkqMyEH6QO4dpmnLJCPQ5LmbB5BqeqK8mMkhB8sYgbKlUjFlRSheLVwU1It2q/zsdcH0/XX/CpT63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JlGTqBc6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JlGTqBc6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ac6Kn9tOYJthH1rzMzLwnzCL3ztkyvx6FPq2VrharLY=; b=JlGTqBc6Kbp2yE8jZrQBRnYwTn
	O/OndqpK5sznzVkdgdR2V14w8mtP2euHGAfGjNRmPRgVugKfs5U/EbMUk9TuHJrLL81YZNcdGD4gG
	5sFLby7qg5bWm1oil2VDavb0oPQ7ibgTvgtWkz/apn8ylihJZw9HIfrIZnCTtd43F/fEi4dwbuxq8
	y4Anr93R+sZ3bHlX6oPnSZYEpAwj5V4yLLGq07hCR5FEQi3MPB4QoWltQ7M0VuF5bL8smPqFuyaMU
	9LCUhMWe7BxI6xItqIbAlvmsU0a5+TikBz5pzSACXH1CXONf9cPfxzYyn9sBVTZh3G65QLzhpkk6I
	g+TlMGrA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4Hga-00000001BUD-2pe6;
	Wed, 09 Sep 2026 12:45:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E66D300A9A; Wed, 09 Sep 2026 14:45:55 +0200 (CEST)
Date: Wed, 9 Sep 2026 14:45:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>, stern@rowland.harvard.edu,
	boqun@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260909124555.GM776954@noisy.programming.kicks-ass.net>
References: <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqFNV4k6DcbyxYCe@localhost.localdomain>

On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:

> > > I argue that's not possible:
> > > 
> > > A:   sigqueue stores
> > > 
> > > B:   AQUIRE tasklist
> > > 
> > > C:   exit_state store
> > > 
> > > D:   RELEASE tasklist
> > > 
> > > E                               ACQUIRE tasklist

> > > F                               if (exit_state)
> > > 				    	swap_pid()
> > > G                                   STORE_PID
> > > 
> > > 				      RELEASE tasklist
> > > 
> > > H                                                       READ PID
> > > 							      ....
> > > I                                		              ACQUIRE siglock

> > Let G' be the unnamed RELEASE after G.
> > 
> > Now, I have deleted and rewritten this tail end at least twice now. And
> > I *think* I'm agreeing with you. Let me explain:
> > 
> > It all hinges on D-E and H-I.
> > 
> > D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
> > RELEASE+ACQUIRE. Specifically, we have:
> > 
> >   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
> >   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering
> > 
> > So while earlier I was arguing with RCpc in mind, in which case D-E
> > completely goes away and we can consider B-G' to be one big critical
> > section from the PoV of a third CPU (our posix_timer_fn() one). In this
> > case we can push A down and G up and have them cross.
> > 
> > *However*, since these are locks, we actually have D-E be UNLOCK+LOCK,
> > which is RCtso and that *does* impose store order, so A stores must
> > happen before G stores
> > 
> > Combine with H-I, which has a data dependency from the LOAD to the LOCK
> > and thereby constraints later LOADs, those sigqueue loads that come
> > after I must in fact observe the A stores.
> 
> I didn't know about all those UNLOCK+LOCK properties. Well,
> I know that UNLOCK+LOCK on the same lock, or on different locks
> but the same CPU, equals smp_mb() except on powerpc. Which is why
> we have smp_mb__after_unlock_lock(). But what you describe is quite
> different.
> 
> Is this something that we should expect litmus to modelize?

IIRC these commits:

6e89e831a901 ("tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire")
ddfe12944e84 ("tools/memory-model: Provide extra ordering for unlock+lock pair on the same CPU")

Were supposed to handle:

	CPU0		CPU1

	UNLOCK(A)
			LOCK(A)

and

	CPU0

	UNLOCK(A)
	LOCK(B)

respectively. I'm forever confused by the actual CAT stuff, nor am I
particularly adept at these litmus things. Boqun, Alan?

> Because the following doesn't verify that:
> ---
> C MP+farfetched
> 
> {}
> 
> P0(int *next, int *prev, int *exit_state, spinlock_t *tasklist_lock)
> {
> 	// list_del_init()
> 	WRITE_ONCE(*next, 1);
> 	WRITE_ONCE(*prev, 1);
> 	// exit_notify()
> 	spin_lock(tasklist_lock);
> 	WRITE_ONCE(*exit_state, 1);
> 	spin_unlock(tasklist_lock);
> }
> 
> P1(int *exit_state, int *pid, spinlock_t *tasklist_lock)
> {
> 	int r0;
> 
> 	// de_thread()
> 	spin_lock(tasklist_lock);
> 	r0 = READ_ONCE(*exit_state);
> 	if (r0 == 1) {
> 		// exchange_tids()
> 		WRITE_ONCE(*pid, 1);
> 	}
> 	spin_unlock(tasklist_lock);
> }
> 
> P2(int *next, int *prev, int *pid, spinlock_t *sighand)
> {
> 	int r0;
> 	int r1;
> 	// get target
> 	r0 = READ_ONCE(*pid);
> 	spin_lock(sighand);
> 	// queue signal
> 	r1 = READ_ONCE(*next);
> 	if (r1 == 0)
> 		WRITE_ONCE(*prev, 2);
> 	spin_unlock(sighand);
> }
> 
> exists (prev=1 /\ 2:r0=1) (* Bad outcome. *)
> ---
> herd7 -conf linux-kernel.cfg ~/farfetched.litmus 
> Test MP+farfetched Allowed
> States 4
> 2:r0=0; [prev]=1;
> 2:r0=0; [prev]=2;
> 2:r0=1; [prev]=1;
> 2:r0=1; [prev]=2;
> Ok
> Witnesses
> Positive: 2 Negative: 7
> Condition exists ([prev]=1 /\ 2:r0=1)
> Observation MP+farfetched Sometimes 2 7
> Time MP+farfetched 0.02
> Hash=a44733c870613a81ae096a93babe215
