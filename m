Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B846D572;
	Fri, 11 Sep 2026 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129680; cv=none; b=pgxkjNGV/pxuM0DAEJO6C6TbYRsz6c/lCed+CdJ9oW+TzJupKcuWRcBE941KyQZlLo6jywZqmQJEgwM4UxdkU6Kt637FYTAeexyPateCLHs6zDZ3gL+EP0l66ALYcbpStXfrUXxfHTL9Yv3yxKUQs259xcqO/wFKLodEKZFcDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129680; c=relaxed/simple;
	bh=YAeH4+2OThJSZoVdZ7FZbBOGVXoVVqqKnUvxWgcNCCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ahq98d1V/q+a9Em7zpB1WcBccDaMA1FNUh7y2wY8fKTtkUKAHKAOe5a8hZZfkqTnEwcmmrqmQXrAI8yHA+JRBbQPQG9Nz/LKSjawWvIufPP0xSfqc69J7mIeTQlkWPAUZiQqd1yoexB/2Ix2SBQi4BBvj+xBIb9DgC5vVlnLY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/7W0HXr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/7W0HXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097771F000FF;
	Fri, 11 Sep 2026 12:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129679;
	bh=p0323wJzFjCIFHnb8lSwNrTwo0K2ydueJAeo9wmqFKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z/7W0HXr+vjYSORGoTNKE6H5X5NqlkNUMSqgTXh86PKZ1SXGHmpgH/FoMwgH+nLxZ
	 g216+OrCNzIzycg8p9gwZfRq47tIlktU+eLjy5FhdGmhnJwTJiFzW8024JZFz4KJuZ
	 Y1PcLBZwNKUvm9NdWH7o/9FqNVwwKfWuT44W9EjrBPINbDnaLzrjBwhq/lphiSZtdy
	 JPEzlHWuWFdHm18K3SZHkO8z0lFWKQKhL1crjLjRM6Snn+sECvqD3zNQEXXKRZ8h8k
	 1YntPC27yegq5OZgNIjJdRyRuaDzy8OsHBE7zbT80MrWsMimp4myg0bTXvqdAptXiU
	 PNvN5Cyl23y3w==
Date: Fri, 11 Sep 2026 14:27:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, boqun@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqPzzMlPpXMNZ5WC@localhost.localdomain>
References: <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <541b1db8-8649-46a9-9fa1-1b5f93cded7f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <541b1db8-8649-46a9-9fa1-1b5f93cded7f@rowland.harvard.edu>

Le Thu, Sep 10, 2026 at 11:26:38AM -0400, Alan Stern a écrit :
> On Thu, Sep 10, 2026 at 03:21:54PM +0200, Frederic Weisbecker wrote:
> > Alan, let me ask you something, because I'm the only one here puzzled by
> > this data dependency.
> > 
> > The following scenario works (the bad outcome never happens) because
> > UNLOCK+LOCK pairs with smp_load_acquire():
> > 
> > 	C MP+polocks
> > 
> > 	{}
> > 
> > 	P0(int *A, int *B, spinlock_t *mylock)
> > 	{
> > 		spin_lock(mylock);
> > 		WRITE_ONCE(*A, 1);
> > 		spin_unlock(mylock);
> > 		spin_lock(mylock);
> > 		WRITE_ONCE(*B, 1);
> > 		spin_unlock(mylock);
> > 	}
> > 
> > 	P1(int *A, int *B)
> > 	{
> > 		int r0;
> > 		int r1;
> > 
> > 		r0 = smp_load_acquire(B);
> > 		r1 = READ_ONCE(*A);
> > 	}
> > 
> > 	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> > 
> > 
> > So I understand this one. Now unfortunately litmus doesn't support
> > structures, but let's suppose it could. I'm taking the previous script
> > and introduce a small change in P1:
> > 
> > 	C MP+polocks
> > 
> > 	{}
> > 
> > 	P0(int *A, int *B, spinlock_t *mylock)
> > 	{
> > 		spin_lock(mylock);
> > 		WRITE_ONCE(*A, 1);
> > 		spin_unlock(mylock);
> > 		spin_lock(mylock);
> > 		WRITE_ONCE(*B, 1);
> > 		spin_unlock(mylock);
> > 	}
> > 
> > 	P1(int *A, int *B)
> > 	{
> > 		int r0;
> > 		int r1
> > 
> > 		r0 = READ_ONCE(*B);
> > 		spin_lock(r0->somelock)
> > 		r1 = READ_ONCE(*A);
> > 		spin_unlock(r0->somelock)
> > 	}
> > 
> > 	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> > 
> > 
> > So instead of doing a LOAD-ACQUIRE on B, I do a plain READ but I also
> > do a spin_lock right after on a data that depends on that READ. I can't
> > run that on litmus but this is the same (simplified) pattern as what we
> > had in this discussion and therefore I assume that it also works (ie: the
> > bad outcome shouldn't happen), is that right?
> 
> Yes.
> 
> > Would it also work if spin_lock() was just a LOAD-ACQUIRE?
> 
> Yes.
> 
> > Does it mean that data dependency implies sufficient ordering such that
> > a LOAD-ACQUIRE to a data that depends on B provides the same guarantees as
> > a LOAD-ACQUIRE to B?
> 
> Indeed it does, with the obvious exception that a load-acquire of B 
> also provides ordering to any statements in between it and the load of 
> the data depending on B.  That is:
> 
> 	r0 = smp_load_acquire(B);
> 	X;
> 	r1 = READ_ONCE(r0->A);
> 
> orders the load from B before everything that follows, including X, 
> whereas:
> 
> 	r0 = READ_ONCE(B);
> 	X;
> 	r1 = smp_load_acquire(r0->A);
> 
> orders the load from B before the load from r0->A and everything 
> following it, but not before X.

Ok that matches my understanding.

> 
> > The reason I'm asking that is because, unlike control dependency, data
> > dependency and its guarantees are not well documented. It is defined in
> > tools/memory-model/Documentation/explanation.txt but not really described
> > in Documentation/memory-barriers.txt. There is a mention in a scenario within
> > the section "MULTICOPY ATOMICITY" just to show that it's not as strong as
> > a full memory barrier.
> > 
> > So if data dependency can provide the guarantee above in my second script
> > but it's not as strong as a full barrier, this suggests that data dependencies
> > have their own specific properties that should probably be documentated.
> 
> Perhaps so.  Can you suggest a place in explanations.txt that could be 
> improved?

So in explanations.txt, the different kinds of dependencies are defined
without diving much into properties.

Properties of ordering enforcement tools are typically described in
Documentation/memory-barriers.txt. Control dependencies has its own
section and I suspect there is enough to say about data dependencies
to deserve its own section there.

What I would love to see documented for example is our case: acquire semantics,
which are described to apply one-way from a single memory target, are also
transferrable to other memory targets when there is a data dependency
involved between them.

> Here's how I think about ordering guarantees in general.  Not in terms 
> of pairing of memory barriers, since (as you pointed out) dependencies 
> aren't memory barriers, and also since ordering cycles can involve more 
> than two CPUs (so triples or higher, not just pairs).
> 
> Instead there's a hierarchy of ordering classes.  The lowest level only 
> orders events on a single CPU; it includes dependencies, smp_rmb(), and 
> load-acquires.
> 
> The next level orders cross-CPU events (i.e., writes), but only in a way 
> that affects two CPUs at a time.  It includes things like smp_wmb() and 
> store-releases, and it guarantees that if CPU 1 writes A first and B 
> second, then CPU 2 will observe the store to A before it observes the 
> store to B.  Likewise for CPU 3, CPU 4, etc., but there is no guarantee 
> about the order in which differing CPUs will observe the stores.
> 
> The highest level orders events in a way that involves all CPUs.  It 
> includes things like smp_mb() and synchronize_rcu(), and it says that if 
> CPU 1 writes A first and B second, then _every_ CPU will observe the 
> store to A before _any_ CPU (including CPU 1!) observes the store to B.
> 
> This is a little imprecise, and there are varying details within the 
> levels, but the overall idea is basically right.

Interesting way of seeing it and I *think* I understand :-)

> 
> At any rate, the point you're raising is that dependencies and 
> load-acquires both sit at the lowest level of this hierarchy, so they 
> provide pretty much the same ordering guarantees.
> 
> Alan Stern

Got it.

Thanks a lot for taking the time to explain me all that!

-- 
Frederic Weisbecker
SUSE Labs
