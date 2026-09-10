Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2613538A73B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054005; cv=none; b=mGfWq5KqrPD/p3DPQGbgwxrSLkuf+cGMtyFet0VPHFlYOMohEAV9ahRXyyS1+kVyh7L1hlhdTHF//n+CWR1KNnwQYwnfcGe0os7iL1qsf6e4NzOfP+voPuzWcQCcNtnagpBfRoZ8mJY5odmm652TOhIHrOtgCbaGLDlxbf37lKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054005; c=relaxed/simple;
	bh=ZO2yvDepDB5xzJbShcoDrCcUNzgfujqH7PRPIfeteTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOLdTf/v9YoiUMPe0JSkThVsCXmvL3jR76byftZ2b63qvcBfYrN7hmJKcoVIcdST0Mt0xyK8RB9O2FX8C9Y7lZypNf0Gl+k3EVROkssqyum3hK5BjsHu3qboljZXS4WSrn+IYViZJrpE+B1lmaDa+21laictlWpgR7Tlc/Tc3Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=i5b59XKn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="i5b59XKn"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90e970f710cso75905046d6.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1789054003; x=1789658803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbXQIuo0NcIuxxmA533Eh1W7sX2mi8fyfrtvA9Iq3dc=;
        b=i5b59XKnqtA8P6Pd2S7vU5C8YRVGG5RDn8/sQ3GVkL1v6VsAWlG7YrWa1X5UP+UsN5
         zKVihZvvEN9Fr8Tkv/ksEeZk2h+e3X/IpoWu2FITJ7+Rbp+fR/2dAXk3y4Fm4012MV7m
         PtgovVrv6MZq1X1BVvwIY0/4Y0rWElKqbEcmZJlzUy0mdNj3O2T+dXd70mdkBgKIxg4c
         +ozf6Me4+CxZ/41gpg7vld6gNXHMOo2Ga9H+kym0CyzbU0aZUfWJin0G2fq+7WKvh2eB
         IAt0pKnUxR2cE8OVYk4DNsrFuPgyAYlUPmdXOMQO5zu3Ss0LZOVGR7ChUXA1lr12FLbq
         P/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054003; x=1789658803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbXQIuo0NcIuxxmA533Eh1W7sX2mi8fyfrtvA9Iq3dc=;
        b=Ksj+GUZcbdam7ZCWqMj23aczoK5Soc9BiOIUTd8GhqPjyhXxTT03f3qyQc5CREo7wZ
         Z/6aj5gt132FiNe4GAxFzDp5voa4l8h7rvHA2QZwWRUADmFRYzeufKae7/Si2op7fCSU
         M02J/k+p7rCY1eqmFwlkr1CLfShcfkpyqVTVt5EgPdLQXWMfjjzBrI23V6TYaCLYT94c
         mSUGldrNPv03nKoPdCYf3flfIEs+tA8eUezC6HpATjwoV/s4Pz/EPzA8Ik5yiZ5fWEni
         gF3AXh18Os/UIOzaIzXe8pJqsFBnpdA5JPi/cYEbKat5IOI8A8WTMRIfSDgpWUtKPGl3
         fVwQ==
X-Forwarded-Encrypted: i=1; AKwUvBycoLs1Lm81PIogXXZVMrA7goIZVehoFsYj3qjnKEdCnPF34u0OPBEGs6heY9sVsslt2qa8seU=@vger.kernel.org
X-Gm-Message-State: AFuF++n2ipO+7yDjQanL+sj1x+AlhQX5zRENn9wXI/6ipZWoJx3exQNh
	jiA7w1mxW6xl9wM7DF/xcIOu70kfziXUFtebDoXuePb74w+X1nbhGY7sajgtWUpdIQ==
X-Gm-Gg: AYBFou3NJbsTj4QI+fcUu+FMx3gtIHUv3qGtWlijmLVLPjNwaMQbgLGJBWEwdbMEmjf
	V2TJvax2WjRky7idC8foZHEmweA5QX371mNGGosKsoedkK57BWp8jn6+BQgrU7Yjvf9aSLtKKon
	4gmvuBR5WaMEdCeG5Ml2eTib2VBMdTQoaqc6gTz9Erlm0wwCuY2GWMeRgZfGMGVttKJqOsHMl++
	DlBJgp9reVdYDFPFQUnRWbk1EKYCGMvt2ArdNM99cSRc+1QY7Rziw/jj+AGEByGJPFwZ4EjRmSV
	vzSnIwFFPe7ao0oWEf2Uv9RBwhcL0MmF++QPQVBEcj+loxPcgu2o1NCbcHiQ1tv4acmgpGWsFNX
	pNvMBv4hPtEnKpJ+tqGufn2QUgq7eznEJ5Nvi3Hn9YDtqscuGTExTAOm6Ww2+XnnKD13OxD2C5n
	1CekZCGVp2mslT+ylcpuXN3ecZlkWl7d8Qsh9IgGperAtOC0M5ArIf/ghTj+jL/CU0iWRdO3Ml
X-Received: by 2002:a05:6214:230f:b0:8fd:d5a7:f970 with SMTP id 6a1803df08f44-9103efef7b2mr506271296d6.11.1789054002587;
        Thu, 10 Sep 2026 08:26:42 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040646d59sm171288396d6.8.2026.09.10.08.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:26:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:26:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <541b1db8-8649-46a9-9fa1-1b5f93cded7f@rowland.harvard.edu>
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
> Alan, let me ask you something, because I'm the only one here puzzled by
> this data dependency.
> 
> The following scenario works (the bad outcome never happens) because
> UNLOCK+LOCK pairs with smp_load_acquire():
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
> 		int r1;
> 
> 		r0 = smp_load_acquire(B);
> 		r1 = READ_ONCE(*A);
> 	}
> 
> 	exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
> 
> 
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

Yes.

> Would it also work if spin_lock() was just a LOAD-ACQUIRE?

Yes.

> Does it mean that data dependency implies sufficient ordering such that
> a LOAD-ACQUIRE to a data that depends on B provides the same guarantees as
> a LOAD-ACQUIRE to B?

Indeed it does, with the obvious exception that a load-acquire of B 
also provides ordering to any statements in between it and the load of 
the data depending on B.  That is:

	r0 = smp_load_acquire(B);
	X;
	r1 = READ_ONCE(r0->A);

orders the load from B before everything that follows, including X, 
whereas:

	r0 = READ_ONCE(B);
	X;
	r1 = smp_load_acquire(r0->A);

orders the load from B before the load from r0->A and everything 
following it, but not before X.

> The reason I'm asking that is because, unlike control dependency, data
> dependency and its guarantees are not well documented. It is defined in
> tools/memory-model/Documentation/explanation.txt but not really described
> in Documentation/memory-barriers.txt. There is a mention in a scenario within
> the section "MULTICOPY ATOMICITY" just to show that it's not as strong as
> a full memory barrier.
> 
> So if data dependency can provide the guarantee above in my second script
> but it's not as strong as a full barrier, this suggests that data dependencies
> have their own specific properties that should probably be documentated.

Perhaps so.  Can you suggest a place in explanations.txt that could be 
improved?

Here's how I think about ordering guarantees in general.  Not in terms 
of pairing of memory barriers, since (as you pointed out) dependencies 
aren't memory barriers, and also since ordering cycles can involve more 
than two CPUs (so triples or higher, not just pairs).

Instead there's a hierarchy of ordering classes.  The lowest level only 
orders events on a single CPU; it includes dependencies, smp_rmb(), and 
load-acquires.

The next level orders cross-CPU events (i.e., writes), but only in a way 
that affects two CPUs at a time.  It includes things like smp_wmb() and 
store-releases, and it guarantees that if CPU 1 writes A first and B 
second, then CPU 2 will observe the store to A before it observes the 
store to B.  Likewise for CPU 3, CPU 4, etc., but there is no guarantee 
about the order in which differing CPUs will observe the stores.

The highest level orders events in a way that involves all CPUs.  It 
includes things like smp_mb() and synchronize_rcu(), and it says that if 
CPU 1 writes A first and B second, then _every_ CPU will observe the 
store to A before _any_ CPU (including CPU 1!) observes the store to B.

This is a little imprecise, and there are varying details within the 
levels, but the overall idea is basically right.

At any rate, the point you're raising is that dependencies and 
load-acquires both sit at the lowest level of this hierarchy, so they 
provide pretty much the same ordering guarantees.

Alan Stern
