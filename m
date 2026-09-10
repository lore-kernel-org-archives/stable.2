Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77C472772;
	Thu, 10 Sep 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046933; cv=none; b=Wges3tgecEBAQA8UcajQwww03g6y4U+KMHJVEb9cgy05VTiEf09KpaKzbjuzAL1I9PEf4Do6NOe5qF+P+PdH22OiOf7AZibQzRm5hDxCbX0o3mtJbdyPsFZ0uOXrQa5meBLBaUjhctkgfktm73SX74CfZMx2oahxv//psCXNuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046933; c=relaxed/simple;
	bh=lWzLSzZHZjjl5Rd03l6mA1HRmQISS3LYk6f4XdUtCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk1NejnOg6NZrSojtgGqC4xe5ilYh4NQk4TBCHFVnW6zxZJgSDquZfw+AHHME3OdYWmIIXmi0P79H6NWzoZlQBIAQ8TlRS2mywFNilyl1/BxTt85T79wsD7aouEEl8PlqvmaJ5jQsP6+ZZJUdfZ1Zmvi0ocNgB98phtLQkbRvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pxCdE/HY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxCdE/HY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=swdcK8vOkwhsl2MmsSoCPD9tJ8Axm4XN7ZjPe7pZqEA=; b=pxCdE/HYU3YGAw/3a48cfXJ29F
	/XupHHzC8mTjcJCVWK+hEqr3nGWjCp/nzkEVCru9oYERiUYevuYJfsOJLDm2lC8Lud4zPse8gSkrX
	xcbxO3uXRedRk8qOsGbL48krZCUpfyLXm4Nk8xgSq94E5x9rOhi3BNIsE4hj2hgAQVr7sQZ6F3Lym
	5UZNsBjR+KcTeoAiNxV42B4Js7ZzOnuLLfFFEq2imjxGHRs7Vrq8YBrKmfqadmZKiEIU6rwsAxnLx
	ZUj5M/a7/J7XsgYRDm1MYtnEZI6WyZ9JNIwtImZoG0TqD1HohMD8UPLx8ys8QuDEWlxqUNPKZoz2T
	UUrrMBsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x4epY-00000002X0V-2VX9;
	Thu, 10 Sep 2026 13:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A18D300400; Thu, 10 Sep 2026 15:28:43 +0200 (CEST)
Date: Thu, 10 Sep 2026 15:28:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@kernel.org>, boqun@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260910132843.GS776954@noisy.programming.kicks-ass.net>
References: <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqKu8nJqPsmKOo1d@localhost.localdomain>

On Thu, Sep 10, 2026 at 03:21:54PM +0200, Frederic Weisbecker wrote:

> So I understand this one. Now unfortunately litmus doesn't support
> structures, but let's suppose it could. I'm taking the previous script
> and introduce a small change in P1:
> 
> 	C MP+polocks
> 
> 	{}
> 
> 	P0(int *A, int *B, spinlock_t *mylock)
> 	{
> 		spin_lock(mylock);
> 		WRITE_ONCE(*A, 1);
> 		spin_unlock(mylock);
> 		spin_lock(mylock);
> 		WRITE_ONCE(*B, 1);
> 		spin_unlock(mylock);
> 	}
> 
> 	P1(int *A, int *B)
> 	{
> 		int r0;
> 		int r1
> 
> 		r0 = READ_ONCE(*B);
> 		spin_lock(r0->somelock)
> 		r1 = READ_ONCE(*A);
> 		spin_unlock(r0->somelock)
> 	}
> 
> 	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> 
> 
> So instead of doing a LOAD-ACQUIRE on B, I do a plain READ but I also
> do a spin_lock right after on a data that depends on that READ. I can't
> run that on litmus but this is the same (simplified) pattern as what we
> had in this discussion and therefore I assume that it also works (ie: the
> bad outcome shouldn't happen), is that right?
> 
> Would it also work if spin_lock() was just a LOAD-ACQUIRE?

Yes, see below.

> Does it mean that data dependency implies sufficient ordering such that
> a LOAD-ACQUIRE to a data that depends on B provides the same guarantees as
> a LOAD-ACQUIRE to B?

The way data dependencies work in this case is a LOAD->LOAD ordering.
The LOAD-ACQUIRE that is part of LOCK must happen after the initial
load. And then the later load is constrained by the ACQUIRE.

So LOAD(B) must resolve in order to do LOAD_ACQUIRE(B->lock.value).


