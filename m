Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3B54CF7D;
	Wed,  9 Sep 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958302; cv=none; b=mzGW+3Q3xZUASOEU9Lf/oMtZJzujZ16NX25lwE1hH8EETGeJiPOZdWJb/4tfwemp0HfI+W2iJriUjcqOmCc/Ojgyt1I+M+B3TYJU3AnfXezVBociywl1vLAcAZsWUuUQhsA+Cn9wHR1fTHvN/CxuBMYB9H07mEgIOstd7+t40H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958302; c=relaxed/simple;
	bh=CHOwUTuLU9dYXLzl8B9ejeZKp39G3sNwKHan6EqRP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OobgJNVzfUTcm54ymD+0krU6kBZoLf8eoLKHzg8TKJfKQtu4eN0yooFqVKzpUR/aLgxptWVeJyveC7/Y4tDP4n/Y+2SnxPojdqtDReYapU79wyxR90/GEkpKqKJMJva+W2/MzGuT3fwnFrTAqbctVA32Ml8J1t8NwNyO3D6GZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rYWnme0B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYWnme0B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mq137E/3icYTvBbUxpFvEmd0A5s/IR/Eke1OJBWVN8w=; b=rYWnme0BMotsfiebauujysdoqO
	pJ5+Y23GgW10q6PCK82nIALbCAO+YsQhj4ezgVibIEJ7heNhberTNugfcFM7xVARoT38tgFx/jU9T
	2SZfH71/8lzmeRpls/IURdrJGAvelRXBNKiU98+3DSL10CHgJZ2MQE7Xkwtn/w8EiHyC05e/zVWcL
	92CUWeEjY9rDNQSrcjLxNMAyKNs8V2K6+lT6QFxusSc05Hzl+n8+jWfHDVcvU37i9Bggds6XfIEqE
	YLQHjkFxTj5VWNRWQLVlW+5NvjP90sUhGign6p5cRjbkOwf9w5ueut4lja2nAO5VlvU2iV5Q2jTcM
	6BfWQrJg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Hm1-00000005Rvo-3Ug1;
	Wed, 09 Sep 2026 12:51:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C4751300A9A; Wed, 09 Sep 2026 14:51:32 +0200 (CEST)
Date: Wed, 9 Sep 2026 14:51:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>, stern@rowland.harvard.edu,
	boqun@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <20260909125132.GR788244@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909124555.GM776954@noisy.programming.kicks-ass.net>

On Wed, Sep 09, 2026 at 02:45:55PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:

> > Because the following doesn't verify that:
> > ---
> > C MP+farfetched
> > 
> > {}
> > 
> > P0(int *next, int *prev, int *exit_state, spinlock_t *tasklist_lock)
> > {
> > 	// list_del_init()
> > 	WRITE_ONCE(*next, 1);
> > 	WRITE_ONCE(*prev, 1);
> > 	// exit_notify()
> > 	spin_lock(tasklist_lock);
> > 	WRITE_ONCE(*exit_state, 1);
> > 	spin_unlock(tasklist_lock);
> > }
> > 
> > P1(int *exit_state, int *pid, spinlock_t *tasklist_lock)
> > {
> > 	int r0;
> > 
> > 	// de_thread()
> > 	spin_lock(tasklist_lock);
> > 	r0 = READ_ONCE(*exit_state);
> > 	if (r0 == 1) {
> > 		// exchange_tids()
> > 		WRITE_ONCE(*pid, 1);
> > 	}
> > 	spin_unlock(tasklist_lock);
> > }
> > 
> > P2(int *next, int *prev, int *pid, spinlock_t *sighand)
> > {
> > 	int r0;
> > 	int r1;
> > 	// get target
> > 	r0 = READ_ONCE(*pid);
> > 	spin_lock(sighand);

There is no dependency between r0 and sighand. While I think there is in
posixtimer_send_sigqueue(). Does making it smp_load_acquire() help?

> > 	// queue signal
> > 	r1 = READ_ONCE(*next);
> > 	if (r1 == 0)
> > 		WRITE_ONCE(*prev, 2);
> > 	spin_unlock(sighand);
> > }
> > 
> > exists (prev=1 /\ 2:r0=1) (* Bad outcome. *)
