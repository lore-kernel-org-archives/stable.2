Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB9F48C8C1;
	Thu, 10 Sep 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046522; cv=none; b=CJqWQuGuGGdSbJ2OVCCXZ7+g30rBWmwks2k43zX0eSLXL9I/Y+Hlg9xTXjmVKip41vt/A/plJVGIWDVwwTs25GWnDooPLOPEbYyEN5UU5YGlV171+YHEF1N0ONIaVMVs3flt1dsrfZE4AmAktXW9Po+pFHf84/Vf3+pj9VJ7T8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046522; c=relaxed/simple;
	bh=aUI8rMwfBHr5u0Y29KLv8bncjijf+J8Ifvm/ilVYFa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQoKzsSV4cJs69dvUjwR0REXM0Wbn1kAieQN2GGAiFA0e2cNaZRTD4G2AyAgqFF8cjI8c8f1AIOOMba8WDuKiFU/HlTcPZr6GRudArN7f3B16/5UHAbjcInoYfc98M1DdkvJt1RGErC6WpPCNK+B1cEbHLFqczhMSoZ0t0uDrJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G802fH7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G802fH7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C41F00893;
	Thu, 10 Sep 2026 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046516;
	bh=rnYfa+N9PX+9bZxCtAHjFNkfKZFEHoRtvGv8uyNBwkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G802fH7KG4gSIuqmJBJArkiHA+NjZjr2/twJ5t1M0MkahEZXS6sTJDWnyE/yzPtJR
	 EjPb4BbYZ26mtoCVylPPFLrcJ1AaLTmXPGGjNuvRz8m0XjC/4nQl4kI5WttiIJMVML
	 4M+hLY29XZIOORDmEX/O6TJbG3VCOwrlMtyHD07gk4YTZpC8GJKDrXUYDS9khtop/t
	 oytwuiPsevvguH6LWlVqmlZprrhub0wJ1dhtLDm8EwpsLjy3jGISSW0Y/9As5x6fPy
	 LfLvehubsuaswL3YyNfDJc60Aiq/D8dzDdkUEHNj0VWk7nO6qkrwpXqHoaoJz/83GF
	 1JIuVFmWDOKZw==
Date: Thu, 10 Sep 2026 15:21:54 +0200
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
Message-ID: <aqKu8nJqPsmKOo1d@localhost.localdomain>
References: <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>

Le Wed, Sep 09, 2026 at 05:11:27PM -0400, Alan Stern a écrit :
> On Wed, Sep 09, 2026 at 10:49:30PM +0200, Thomas Gleixner wrote:
> > On Wed, Sep 09 2026 at 15:28, Alan Stern wrote:
> > > On Wed, Sep 09, 2026 at 04:45:15PM +0200, Frederic Weisbecker wrote:
> > > I can't tell what you're trying to do here.  The UNLOCK-LOCK ordering 
> > > in P0 means that P1 sees A=1 before it sees B=1.  But nothing in this 
> > > litmus test forces P1 to execute READ_ONCE(*b) before READ_ONCE(*A).  If 
> > > the reads are executed in the opposite order, you can see how P1 might 
> > > get r0=1 and r1=0.
> > 
> > The problem we are debating is:
> > 
> >     C = VAL1
> > 
> >     CPU0                    CPU1		CPU2
> >     
> >     STORE(A0, 0)
> >     STORE(A1, 0)
> > 
> >     LOCK(TLOCK)
> >     STORE(B, 1) // 0 -> 1
> >     UNLOCK(TLOCK)
> > 
> >                            LOCK(TLOCK)
> >                            b = LOAD(B)
> >                            if (b)
> >                               STORE(C, VAL0)
> > 
> >                                                 c = LOAD(C)
> >                                                 LOCK(c->lock)
> >                                                   a0 = LOAD(A0)
> >                                                   if (!a0)
> >                                                      STORE(A0, X1)
> >                                                      STORE(A1, X2)
> > 
> > The question is whether CPU2 can observe C == VAL0 and A0 == NULL before
> > A1 has completed.
> > 
> > My and Peter's argument is that the sequence
> > 
> >    UNLOCK(TLOCK) on CPU0   -> LOCK(TLOCK) on CPU1
> > 
> > implies RCtso and therefore the stores to A0 and A1 on CPU0 must be
> > before the store to C on CPU1.
> > 
> > Now because the LOAD(C) on CPU2 depends on that STORE(C) the
> > LOCK(c->lock) ensures that LOAD(A0) can't be reordered and because of
> > that STORE(A1, 0) has completed before that.
> > 
> > CPU2 LOAD(C) observing VAL0 has a data dependency on the STORE(C, VAL0)
> > on CPU1, which as argued above can only happen after the UNLOCK/LOCK
> > sequence CPU1 observes the STORE(B).
> > 
> > Subsequently LOCK(c->lock) has a data dependency on LOAD(C) and the LOCK
> > operation prevents that LOAD(A0) can be reordered before LOCK(c->lock).
> > 
> > So despite the fact that c->lock != TLOCK the UNLOCK(TLOCK)/LOCK(TLOCK)
> > sequence, which implies RCtso, the following takes care of it:
> > 
> >     1) the data dependency between the STORE(C, VAL0) on CPU1 and the
> >        c = LOAD(C) on CPU2 observing VAL0
> >    
> >     2) the data dependency of LOCK(c->lock) on #1
> > 
> >     3) due to LOCK() in #2 LOAD(A0) cannot observe the STORE(A0, 0) on
> >        CPU0 without the STORE(A1, 0) on CPU0 has completed.
> > 
> > If #3 can happen then that would obviously cause undebuggable data
> > corruption.
> > 
> > I hope this is understandable enough despite my brain having melted
> > several times by now while writing it up.
> 
> I see.  Yes, your analysis is right.  And Frederic's latest LKML litmus 
> test confirms the result.

Alan, let me ask you something, because I'm the only one here puzzled by
this data dependency.

The following scenario works (the bad outcome never happens) because
UNLOCK+LOCK pairs with smp_load_acquire():

	C MP+polocks

	{}

	P0(int *A, int *B, spinlock_t *mylock)
	{
		spin_lock(mylock);
		WRITE_ONCE(*A, 1);
		spin_unlock(mylock);
		spin_lock(mylock);
		WRITE_ONCE(*B, 1);
		spin_unlock(mylock);
	}

	P1(int *A, int *B)
	{
		int r0;
		int r1;

		r0 = smp_load_acquire(B);
		r1 = READ_ONCE(*A);
	}

	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)


So I understand this one. Now unfortunately litmus doesn't support
structures, but let's suppose it could. I'm taking the previous script
and introduce a small change in P1:

	C MP+polocks

	{}

	P0(int *A, int *B, spinlock_t *mylock)
	{
		spin_lock(mylock);
		WRITE_ONCE(*A, 1);
		spin_unlock(mylock);
		spin_lock(mylock);
		WRITE_ONCE(*B, 1);
		spin_unlock(mylock);
	}

	P1(int *A, int *B)
	{
		int r0;
		int r1

		r0 = READ_ONCE(*B);
		spin_lock(r0->somelock)
		r1 = READ_ONCE(*A);
		spin_unlock(r0->somelock)
	}

	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)


So instead of doing a LOAD-ACQUIRE on B, I do a plain READ but I also
do a spin_lock right after on a data that depends on that READ. I can't
run that on litmus but this is the same (simplified) pattern as what we
had in this discussion and therefore I assume that it also works (ie: the
bad outcome shouldn't happen), is that right?

Would it also work if spin_lock() was just a LOAD-ACQUIRE?

Does it mean that data dependency implies sufficient ordering such that
a LOAD-ACQUIRE to a data that depends on B provides the same guarantees as
a LOAD-ACQUIRE to B?

The reason I'm asking that is because, unlike control dependency, data
dependency and its guarantees are not well documented. It is defined in
tools/memory-model/Documentation/explanation.txt but not really described
in Documentation/memory-barriers.txt. There is a mention in a scenario within
the section "MULTICOPY ATOMICITY" just to show that it's not as strong as
a full memory barrier.

So if data dependency can provide the guarantee above in my second script
but it's not as strong as a full barrier, this suggests that data dependencies
have their own specific properties that should probably be documentated.

Thanks.
