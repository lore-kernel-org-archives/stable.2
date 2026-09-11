Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137F3D5221;
	Fri, 11 Sep 2026 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120688; cv=none; b=rH2altirsxPCrYFpCqJRVfYpzHatu6jxVoic/Q+8G5plIt8w8K1CsJmksnGnPmhWQN2j/1TrDnLoDZ9nYTtbUTqQPVW56ck39OTZTChuevA4Fdc+Ww255OA7P6XyIAsJA1ryBbP0Fxsgi5MXLK8bEOSqPD9zHj+OiL7/fgv2FH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120688; c=relaxed/simple;
	bh=tllo9xBxMoil/gLsAAYeyJZvRBPmPIS9I00OSFFJ0mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eONc/obfKDTsNZ2J08iGsHQMvorEhv/UtTQhwuE0vlFGgrk+EJPzqQez2r8L7p5W3OqgqJIR4pKOCCl0w1p4xPl/7GFp3AW11RVCcATsJmsJNFHbMn7zo8ucpnpJnLjia21Q20AD1XzH5ll/xytkZfj6e8+oeiONUHRzDnxCDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVojjTjy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVojjTjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50461F00898;
	Fri, 11 Sep 2026 09:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789120687;
	bh=ICN+DLNlsm9TjZGbyqToqmJ4GlVBBB0e46kSjSyTCE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bVojjTjy+0mzyG0NUGwjaMhtyghSdJJ6cpG0+tbnQdck8DyhfKU7suJKP9HxsR64q
	 HkPrp8IYpyBU7RuaxRpoFrntC4kpdpDA6RbQ/+b6LeuMlWRW8aG0uvO+7lR1cQmWXy
	 axYqJKDVgSCJ8T0PICWfiOIvi4prN/G7C8SMf3ymk0uwP6r6mS2N2EIgadRiN4ztQS
	 w40ZClRGmu9KLtPbMLmX+7tyHrlC2Q4qPQBWeBWMAT16m4E9jFdWc60Zi4OtRQ+Wj/
	 BaRtdHZJoTZ1meEYetu98S9BDGpZfl44JK0p+bzGRL0F4qaEMmUNtrIZwx4y8nyjKT
	 lX+BgIMtOoZdQ==
Date: Fri, 11 Sep 2026 11:58:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aqPQrGWqKfX_5MMj@localhost.localdomain>
References: <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <20260910132843.GS776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910132843.GS776954@noisy.programming.kicks-ass.net>

Le Thu, Sep 10, 2026 at 03:28:43PM +0200, Peter Zijlstra a écrit :
> On Thu, Sep 10, 2026 at 03:21:54PM +0200, Frederic Weisbecker wrote:
> 
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
> > 
> > Would it also work if spin_lock() was just a LOAD-ACQUIRE?
> 
> Yes, see below.
> 
> > Does it mean that data dependency implies sufficient ordering such that
> > a LOAD-ACQUIRE to a data that depends on B provides the same guarantees as
> > a LOAD-ACQUIRE to B?
> 
> The way data dependencies work in this case is a LOAD->LOAD ordering.
> The LOAD-ACQUIRE that is part of LOCK must happen after the initial
> load. And then the later load is constrained by the ACQUIRE.
> 
> So LOAD(B) must resolve in order to do LOAD_ACQUIRE(B->lock.value).

Ok I must confess that's not a pattern I'm used to and therefore it's
still a bit counter-intuitive to me. I hope we can document that somehow
somewhere.

Thanks a lot for the explanation!

-- 
Frederic Weisbecker
SUSE Labs
