Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04145D5E2;
	Fri, 11 Sep 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130213; cv=none; b=eBMJwl8nlPS9nJGyj5Ai+gvWOlq8PbiHIWu4iGOOVJ0WglW55mWgrL9wP3iTxhhtvFbxo6C7k+HmqnkfqVi3EgliH56P8mEjCBzvTYWrOisbVc3LscULDTV7/B2lbV+g4AvebZZDxDa3//AR9bLn6VOlXDIY4a2bZs75D/Bq7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130213; c=relaxed/simple;
	bh=FhBkT//EUdzPaASf+PqutgztqZi2/DS+0RfOAOPIBvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgdnRfRZOwLJecBfY0hSf86HnFiHF67Mep+rNiCkX/J5NbUYb+pRPnlOpofsvqyMe0sc3ewQ9gHsSHHqF/Ai5norPfFy2xsJ23fyC4mihKqnknbxHdDWIGc/hRVNuXV0+/Y1GsAKCWt5bn1j+muQR/dK67GaB93igkhvxSXuCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N73/B4VV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N73/B4VV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E361F00893;
	Fri, 11 Sep 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130211;
	bh=Mr1j0ob9bIGW9c61QbiPaPhgoVmDwLbk+CaqfDR9Tx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N73/B4VVIRtJYYE8HOzeneTnZkqf8jW3uWgvtdv3nUgALSeTcrraecEFKL5Vj5eqd
	 /vdyafMB0/YxjpFz2SQl9Pzew1WEjiC31xDdsgK63zKGAMM5EhnUId0hDtztAlXKQR
	 K6GI12+j6zd185S7q7XQj2VRdHkAKxbgffE3+G/6ohtng0NaZ4Q0ECFgcHB7kunyh7
	 gxjmraKCeuzvizNhjvFGGqlz6T6oKlOQ1n8IrAeVzoxXVubFX2zzZLwlJol4xS6GB5
	 ID/W1Fp384e5SseJ93bWoNGVJw1LmRrWTPBNVpyaUyTHJHiOyLezUJP5ibuez91XHo
	 lfXiOFMpgePGA==
Date: Fri, 11 Sep 2026 14:36:48 +0200
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
Message-ID: <aqP14AyyQhlXBZcC@localhost.localdomain>
References: <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <20260910132843.GS776954@noisy.programming.kicks-ass.net>
 <aqPQrGWqKfX_5MMj@localhost.localdomain>
 <20260911102203.GF1837346@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911102203.GF1837346@noisy.programming.kicks-ass.net>

Le Fri, Sep 11, 2026 at 12:22:03PM +0200, Peter Zijlstra a écrit :
> On Fri, Sep 11, 2026 at 11:58:04AM +0200, Frederic Weisbecker wrote:
> > Le Thu, Sep 10, 2026 at 03:28:43PM +0200, Peter Zijlstra a écrit :
> 
> > > The way data dependencies work in this case is a LOAD->LOAD ordering.
> > > The LOAD-ACQUIRE that is part of LOCK must happen after the initial
> > > load. And then the later load is constrained by the ACQUIRE.
> > > 
> > > So LOAD(B) must resolve in order to do LOAD_ACQUIRE(B->lock.value).
> > 
> > Ok I must confess that's not a pattern I'm used to and therefore it's
> > still a bit counter-intuitive to me. I hope we can document that somehow
> > somewhere.
> 
> One way of looking at it is the computation for the address of
> &B->lock.value.
> 
> A	void *r = LOAD(B);			 // B
> B	r += offsetof(typeof(*B), lock);	 // &B->lock
> 	spin_lock(r)
> C	  r += offsetof(typeof(B->lock), value); // &B->lock.value
> 	  for (;;)
> D	    v = LOAD_ACQUIRE(r);
> 	    if (!v && !cmpxchg_relaxed(r, 0, 1))
> 	      break;
> 	    cpu_relax();
> 
> Note how the LOAD_ACQUIRE() at D depends on the computation of C, and B,
> which in turn depend on the load of A.
> 
> If A does not complete, B,C cannot compute the address for the load of
> D. Therefore A must come before D.

Right, it's just that acquire is often described as ordering access after
a single memory target (matching release before that same single memory target).
But I'm discovering that this property also applies to a memory target that
depends on an actual target, so to speak :o)

Anyway yes, I get the idea now, thanks for the patient explanations!
