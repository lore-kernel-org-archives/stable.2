Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2557C735;
	Wed,  9 Sep 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965120; cv=none; b=pC6Us5y4cf+Pb/2shNlZbotpU8lfADwi8coxLEe2TXyTSAv8aXEtaNVNoOSppLN7YNV9JIMW+/VLbRRQOUEoDH6Dq0TMXaX+MTOy9vQbP61jchE6cfv0ltaLzGblZHCacuWueybRPaZtIRHOy6KVJcGzMd3GxJBJvUdJdiqxQUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965120; c=relaxed/simple;
	bh=Ypon59CrcL/GClEUgoItVwKRy5h97oyDAyIzwKQTKL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FARKpujQ2YLThZ0wRtJRA8RpMdXtWJJvY25DTDwN2593sKZKbmYiuwXyjKTo7Dk9637n7nTPlVnwIOB9WcfSJs9LjvmlTT/TNr4789sBGYrzJ73ry8eLihwkOEZkHKSBl/PVy3qnPrk0oClZ2CSSbZMPE5pOh6BSJoFf2bxZEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xhxx0khW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xhxx0khW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AC91F00A3A;
	Wed,  9 Sep 2026 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965119;
	bh=K58cKHulWym61Yate6t1pTnTXRuBWGGv6yostO13qNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xhxx0khW2G/5/4vxzFifVxHhB1Hj4/gJYWj9vH7PrAXbsF+QcjQEQFAH3W56oAvks
	 lqXDwUoQLaUur3E2tolLS49mfx+b4Ze9yl+QcE2iE6tNyafSE1MmimNmOnbH4iHt22
	 GgB1BEZ0QSxF3Um43IZKLjYOP+ljAj6AhBy2muVtNsqtgjRmj227JPG9fiVwV/8j/2
	 YCBDrmVUjfAGL7zfOEmaojeuER2qxydaEdPEC4Ryl79Ez1o4FF1U567vSCgnkTKRG4
	 XJ6kAJFdjD02KG4GJqMWNLaNBWrmKpq6XB4Mz9mnfCWxvS7o1jLLrg5In2OL84xomV
	 rgiDsoDXb0k9A==
Date: Wed, 9 Sep 2026 16:45:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: stern@rowland.harvard.edu, boqun@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqFw--VfXWz-yZt8@localhost.localdomain>
References: <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909124555.GM776954@noisy.programming.kicks-ass.net>

Le Wed, Sep 09, 2026 at 02:45:55PM +0200, Peter Zijlstra a écrit :
> On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:
> 
> > > > I argue that's not possible:
> > > > 
> > > > A:   sigqueue stores
> > > > 
> > > > B:   AQUIRE tasklist
> > > > 
> > > > C:   exit_state store
> > > > 
> > > > D:   RELEASE tasklist
> > > > 
> > > > E                               ACQUIRE tasklist
> 
> > > > F                               if (exit_state)
> > > > 				    	swap_pid()
> > > > G                                   STORE_PID
> > > > 
> > > > 				      RELEASE tasklist
> > > > 
> > > > H                                                       READ PID
> > > > 							      ....
> > > > I                                		              ACQUIRE siglock
> 
> > > Let G' be the unnamed RELEASE after G.
> > > 
> > > Now, I have deleted and rewritten this tail end at least twice now. And
> > > I *think* I'm agreeing with you. Let me explain:
> > > 
> > > It all hinges on D-E and H-I.
> > > 
> > > D-E is a UNLOCK+LOCK hand-over, which is not quite the same as
> > > RELEASE+ACQUIRE. Specifically, we have:
> > > 
> > >   RELEASE+ACQUIRE: RCpc,  only the CPUs involved agree on the ordering
> > >   UNLOCK+LOCK:     RCtso, the hand-over is store-ordering
> > > 
> > > So while earlier I was arguing with RCpc in mind, in which case D-E
> > > completely goes away and we can consider B-G' to be one big critical
> > > section from the PoV of a third CPU (our posix_timer_fn() one). In this
> > > case we can push A down and G up and have them cross.
> > > 
> > > *However*, since these are locks, we actually have D-E be UNLOCK+LOCK,
> > > which is RCtso and that *does* impose store order, so A stores must
> > > happen before G stores
> > > 
> > > Combine with H-I, which has a data dependency from the LOAD to the LOCK
> > > and thereby constraints later LOADs, those sigqueue loads that come
> > > after I must in fact observe the A stores.
> > 
> > I didn't know about all those UNLOCK+LOCK properties. Well,
> > I know that UNLOCK+LOCK on the same lock, or on different locks
> > but the same CPU, equals smp_mb() except on powerpc. Which is why
> > we have smp_mb__after_unlock_lock(). But what you describe is quite
> > different.
> > 
> > Is this something that we should expect litmus to modelize?
> 
> IIRC these commits:
> 
> 6e89e831a901 ("tools/memory-model: Add extra ordering for locks and remove it for ordinary release/acquire")
> ddfe12944e84 ("tools/memory-model: Provide extra ordering for unlock+lock pair
> on the same CPU")

I didn't know that UNLOCK+LOCK can pair with smp_load_acquire(). Good to know.

But unlock+lock doesn't pair with unlock+lock on different CPU.

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

P1(int *A, int *B, spinlock_t *otherlock)
{
	int r0;
	int r1;

	r0 = READ_ONCE(*B);
	spin_lock(otherlock);
	r1 = READ_ONCE(*A);
	spin_unlock(otherlock);
}

exists (1:r0=1 /\ 1:r1=0) (* Bad outcome happens *)

But yeah there is no data dependency involved. Let me answer to
that to tglx.

-- 
Frederic Weisbecker
SUSE Labs
