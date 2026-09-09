Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577D41837D;
	Wed,  9 Sep 2026 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986982; cv=none; b=n0ZUeBCvZwi9guw0G55WBXEHZvMT2DNsHkpGV2KX+B96e6vnQxIFDc1cLaejNrnIacMlYmrKgY1oZULBsNV9e8n/vVpOfs9DgxKxdyU/CB5CHQOF3oLtZ7Qh2h0agydt3xac172xpWMEU935iHG6enUkIq7MPg07wPSouRazQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986982; c=relaxed/simple;
	bh=U57OQUdkUGArdwNJ0k/bYFSBQsg1AiieBzvmzEUyDR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y4t/SZx9G9iIfVgxg2gYv/QABloNCDKqvnvDuzkN/DpuiQ1O1jiwYa0uvsXQDvBLGSNj64b2l7D+qdbMgo4Hs+GrjczODIN8sQZAqNni96UGUCtZeJ1GQNsmgNJoatHtsk6SNIYW2NldRLzoNb4OzhnL2EYtppQNYMPVl/hSH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjtxE/PQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjtxE/PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721A71F000FF;
	Wed,  9 Sep 2026 20:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986973;
	bh=8kaW3wKuA8yvgnzdzf2uYnKbZxBRyR+DSzfKiGfGYyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BjtxE/PQ/3XDynMg78VuAdSYEKUw4XFNTs9S2kA3OQxbNn6fckJ8z4SoDhOgYiHTF
	 4mPozrylPNzhYHn3nEVO9lnPSkftad3wjSjmYYATh1UFYHFuog2mfd064XHEcRz+0C
	 BrvxF5FPRWEPCMyweD1RCTRPmnR3dAf/S47JqX43LHwVFJExuhjhC20yLIaByspcJv
	 2Bu93Lu53PZ1MEF42ZlSJ1VC5BwkjYZ4uJNy5YYds/EaGrbWJr6M9h7GaGMr3kQX/V
	 ImjX4cnZhsFOds/xEa9ewI6Jt2JqL2d0tWJX0QratYLpodDlqkVUrIAem1LqA20e48
	 tw7TyotGXF0bg==
From: Thomas Gleixner <tglx@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, boqun@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, "Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, "Eric W. Biederman"
 <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
In-Reply-To: <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
References: <87ik4h2icz.ffs@fw13> <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13> <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
Date: Wed, 09 Sep 2026 22:49:30 +0200
Message-ID: <87pkymywth.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 09 2026 at 15:28, Alan Stern wrote:
> On Wed, Sep 09, 2026 at 04:45:15PM +0200, Frederic Weisbecker wrote:
> I can't tell what you're trying to do here.  The UNLOCK-LOCK ordering 
> in P0 means that P1 sees A=1 before it sees B=1.  But nothing in this 
> litmus test forces P1 to execute READ_ONCE(*b) before READ_ONCE(*A).  If 
> the reads are executed in the opposite order, you can see how P1 might 
> get r0=1 and r1=0.

The problem we are debating is:

    C = VAL1

    CPU0                    CPU1		CPU2
    
    STORE(A0, 0)
    STORE(A1, 0)

    LOCK(TLOCK)
    STORE(B, 1) // 0 -> 1
    UNLOCK(TLOCK)

                           LOCK(TLOCK)
                           b = LOAD(B)
                           if (b)
                              STORE(C, VAL0)

                                                c = LOAD(C)
                                                LOCK(c->lock)
                                                  a0 = LOAD(A0)
                                                  if (!a0)
                                                     STORE(A0, X1)
                                                     STORE(A1, X2)

The question is whether CPU2 can observe C == VAL0 and A0 == NULL before
A1 has completed.

My and Peter's argument is that the sequence

   UNLOCK(TLOCK) on CPU0   -> LOCK(TLOCK) on CPU1

implies RCtso and therefore the stores to A0 and A1 on CPU0 must be
before the store to C on CPU1.

Now because the LOAD(C) on CPU2 depends on that STORE(C) the
LOCK(c->lock) ensures that LOAD(A0) can't be reordered and because of
that STORE(A1, 0) has completed before that.

CPU2 LOAD(C) observing VAL0 has a data dependency on the STORE(C, VAL0)
on CPU1, which as argued above can only happen after the UNLOCK/LOCK
sequence CPU1 observes the STORE(B).

Subsequently LOCK(c->lock) has a data dependency on LOAD(C) and the LOCK
operation prevents that LOAD(A0) can be reordered before LOCK(c->lock).

So despite the fact that c->lock != TLOCK the UNLOCK(TLOCK)/LOCK(TLOCK)
sequence, which implies RCtso, the following takes care of it:

    1) the data dependency between the STORE(C, VAL0) on CPU1 and the
       c = LOAD(C) on CPU2 observing VAL0
   
    2) the data dependency of LOCK(c->lock) on #1

    3) due to LOCK() in #2 LOAD(A0) cannot observe the STORE(A0, 0) on
       CPU0 without the STORE(A1, 0) on CPU0 has completed.

If #3 can happen then that would obviously cause undebuggable data
corruption.

I hope this is understandable enough despite my brain having melted
several times by now while writing it up.

Thanks,

        tglx

