Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3331618B;
	Fri, 11 Sep 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122134; cv=none; b=fQBVTGJHgxUt0lWVIGltJNhS0byUX8CugwKf0Bsds49rtZjPIpHdo2TKkgqDuL6vHCEVWq2NEABedHCDdb/DGNAGr8nZlzNgtUNPuVnY8L4ChlQFdrUq3GFPH/O8zFBVlobTCwevclCA/hAFjvuQPCHkfQn5/AoW/3BD125PeeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122134; c=relaxed/simple;
	bh=gggW4fqvNn5LUiR2HueghSpaVrKnYBdBAMuALnaslig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ls4F8lqSJ62vAXK4D49NNXkC8NiGM4/y5G4lGxQ2Kow1WH4maaTg6a0lWMLKAGXUdcfyPpy/povh5Mt3HxCUVIYXSDYttsKSfYVceCPaCafeHS2sMD242hS99tYZqSgCSoLU50xA9hx4HIw0E2DeaMS5djtvAyrPSAUyGL6hYC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e2mO8klN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e2mO8klN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=a4s9x3U3bR8KANQuLnz4euSZpgFDoCaaS8HqfMnlmso=; b=e2mO8klNko7zwu9lZ6HA75URJ4
	xxxXwoXo7M8R/GYHZkFsM8pvBfGWK7jD6/CTnuDsV8t5o960r6jEfKOL/jEbDbq/enkxgwrQxwTBZ
	HjvJeMJ1srwscRr5eiaKKz4XRdgjySL1N2o9s53Gx8SiuGryULEKURQGihi8UD8lA4PqaSErezhsB
	1nrBw9ym1Uz4EL1pXzJwV0lUtmC93wlJxgw3YdMhxQT/geyYDmDZzdP2BgkHSDhKGszMOvs9fSIiM
	a8kp9BEzr34JyKjgdxuXHqXHossrBAxe9xWRrAACNk71qqRLaJeHL4RhG4Vli5tMcSlCL1e2nmwkh
	InUT4nig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4yOS-0000000AviN-2UjR;
	Fri, 11 Sep 2026 10:22:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7F76F300400; Fri, 11 Sep 2026 12:22:03 +0200 (CEST)
Date: Fri, 11 Sep 2026 12:22:03 +0200
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
Message-ID: <20260911102203.GF1837346@noisy.programming.kicks-ass.net>
References: <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <aqFw--VfXWz-yZt8@localhost.localdomain>
 <d633542b-2a2f-4adb-82c1-ea650466f63a@rowland.harvard.edu>
 <87pkymywth.ffs@fw13>
 <adea7b13-51cc-4603-acbe-9e6d5baa5247@rowland.harvard.edu>
 <aqKu8nJqPsmKOo1d@localhost.localdomain>
 <20260910132843.GS776954@noisy.programming.kicks-ass.net>
 <aqPQrGWqKfX_5MMj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqPQrGWqKfX_5MMj@localhost.localdomain>

On Fri, Sep 11, 2026 at 11:58:04AM +0200, Frederic Weisbecker wrote:
> Le Thu, Sep 10, 2026 at 03:28:43PM +0200, Peter Zijlstra a écrit :

> > The way data dependencies work in this case is a LOAD->LOAD ordering.
> > The LOAD-ACQUIRE that is part of LOCK must happen after the initial
> > load. And then the later load is constrained by the ACQUIRE.
> > 
> > So LOAD(B) must resolve in order to do LOAD_ACQUIRE(B->lock.value).
> 
> Ok I must confess that's not a pattern I'm used to and therefore it's
> still a bit counter-intuitive to me. I hope we can document that somehow
> somewhere.

One way of looking at it is the computation for the address of
&B->lock.value.

A	void *r = LOAD(B);			 // B
B	r += offsetof(typeof(*B), lock);	 // &B->lock
	spin_lock(r)
C	  r += offsetof(typeof(B->lock), value); // &B->lock.value
	  for (;;)
D	    v = LOAD_ACQUIRE(r);
	    if (!v && !cmpxchg_relaxed(r, 0, 1))
	      break;
	    cpu_relax();

Note how the LOAD_ACQUIRE() at D depends on the computation of C, and B,
which in turn depend on the load of A.

If A does not complete, B,C cannot compute the address for the load of
D. Therefore A must come before D.
