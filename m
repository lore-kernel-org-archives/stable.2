Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048217;
	b=eUMmA2ZCKKBw4gkJN6CK+tacNMfJz9D2DO7Egx1Tig1Nd/7+7EzpUOBL0iDO7Wn353wl
	 R5Q+EvfMyQIlI3ktbCFZCG5iGhnX2Bc8fU/VxyOsfcKEL7Jj8j79Z4DlizVwSFYoe9PBV
	 Fv2VDKQK5ubIfAG9Ab/tQSNz9pbcIfzqjPNz9G6pcLog71O6R6abARSXofkdUlXB2hbNq
	 m2PmP0oPAqD3lL4woapXvddzXGhf9SjIOGCl68ueZGC+rYZHI4Ol2IjzOtpsfkMorcBtW
	 Yl7BU15Jm8Wn0g5DPtz8RTbiVyArlgkHunjbbN+tv8DBWqhHxS4ccRsA0s9UvJtGwXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048217;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=00YgSuh+6jx0afSBDldxTfJk1blWDnLXe0VtLaUOxXk=;
	b=tGTE0tuDU1QULm1ovuXFImvl35dIHMOxYQfjFRgcCVd1mLEhf5vHfEOHXkakrymRQWJf
	 SgvLyJAjnP9rTdXGNKzIeEMQIxNzFDo4Pj3kElq+GKi8PV9dV2mMbf6RYIEt4INddbMG6
	 oV79KtVDrNxZWiGIVoNIn/MOa1LXqiEjFlv7p5Z+nPZ4FTQ0PZ/PJYZ6CdlDvjLaJuxaF
	 RmjME8znKVAMlrRdMHNUDS536FqGErMuPj1iIQnrauEdSbFGKv4rXH4qvvC3SRicHaRNO
	 Sqx3BMkzK42Uz4/OI7gXzeGP2yGPFLDAFUDjyAwDUOvtPRA3okKk3Zf88/7Qjk1saeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WQ4vEdpT;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90950606A330;
	Sat,  7 Nov 2026 10:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90950606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=WQ4vEdpT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=00YgSuh+6jx0afSBDldxTfJk1blWDnLXe0VtLaUOxXk=; b=WQ4vEdpTpZXUFp0gPkIKkOjiXH
	VhxJd/x7V53CLfavcaj/BKuDXIlOYi4f5cqfDTgde17E0rGlk40dJjy/zZ2pcBrbtT+Up9sZ9JM2D
	U9j5jfgF87PiMz53RVu5GqY+VT0IS7bYVriiRRcWwYxAZLAkclp2nnyuoSV3YuteoBMiY8v5eLu8G
	SpKd3Av0YjIYGyW1yZgo45Did2Hjp5V1RhD1PC/AupJNJKjFFlUtsN0orQ0gqDpLd3opKLbZbyWgi
	IKH+AOlK2V80w4EKi+NEpSit9SP1vhwEfi7Blwv+LdrOMbP3ko14dF0jh9zqrB5/Ztt1mD/LHOdKQ
	cJl17gUA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPdtS-0000000Gido-3xDF;
	Sat, 07 Nov 2026 10:43:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8FE4300339; Sat, 07 Nov 2026 11:43:29 +0100 (CET)
Date: Sat, 7 Nov 2026 11:43:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, tglx@kernel.org,
	mingo@redhat.com, linux-kernel@vger.kernel.org, will@kernel.org,
	boqun@kernel.org, longman@redhat.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, dvhart@infradead.org, dave@stgolabs.net,
	andrealmeid@igalia.com, shuah@kernel.org, juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when the
 waiter is woken
Message-ID: <20261107104329.GA2668564@noisy.programming.kicks-ass.net>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
 <20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
 <20261107002927.3cbad7ff@fedora>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107002927.3cbad7ff@fedora>

On Sat, Nov 07, 2026 at 12:29:27AM -0500, Steven Rostedt wrote:
> On Fri,  6 Nov 2026 18:59:27 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > The top waiter of an rt_mutex spins while the owner runs,
> > rtmutex_spin_on_owner(), and does not stop when it is woken: its timeout
> > and a signal find it running, set it TASK_RUNNING, and the spin goes on
> > until the owner leaves its CPU or the waiter's own CPU has to
> > reschedule. A PI futex owner is a user task that may run as long as it
> > likes. On v7.4-rc1, in 8-CPU VMs, behind an owner spinning in userspace,
> > a 1ms pthread_mutex_timedlock() returns ETIMEDOUT 126ms to 631ms late on
> > average, 1.4s at most, a SIGUSR1 is handled up to 1.9s late, and a
> > waiter killed with SIGKILL is reaped 0.5s late on average. With
> > PREEMPT_RT the wound of a ww_mutex is missed the same way: two contexts
> > in an ABBA on two CPUs at SCHED_FIFO spin on each other, and the older
> > one gets its second lock after 96ms on average, 0.95s at most.
> > 
> 
> The above is very verbose. Are you starting to use AI? ;-)

He definitely is. I can't read the above, its word soup. Part of using
AI is making sure the Changelog is actually readable. This is not.
