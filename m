Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099F4AF9F4;
	Wed,  9 Sep 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968919; cv=none; b=qpLyT36PSYOi4DyQdMJ5ZQisPbtmIH03wVotya8zqn23dRolknTxPe7iOl4RzxR5G+hz+XXCmH9KEQCTOwP/Tu1y1l/G7w+Fhj+oZO0/eGniZkpbi9Sw0ibP1mH+yNv2GVmIdEuT35mNq43D1cbpZ8Qq0u9raOkGOjG1BVwCkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968919; c=relaxed/simple;
	bh=lgJCbHm4QiwFfRhXTwLGnXcQZo2K5lbh4+WfJYx8zdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4UreRWhTWWeDLlqA2ezR6LqAlHJGme5XL5qmJ58utGE2C2/9Xj9IGL3hXtRipoXsJB0JIqVXOsGsV1m6NJkswpbxM5U8n+ku66tUNi0PMEdn7MQKbQ00vNNQvwVOjxB7hiJFMLHbnrgYTp8P/eUGYN4r0w1rE06tq2UCT7tpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2hCBecP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2hCBecP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DC51F00A3A;
	Wed,  9 Sep 2026 15:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788968918;
	bh=KNSkH/R0CEsWRpTlgeQwvvRnutEz8z0+kQLhOJLpilE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L2hCBecPBIIFVSp7331/v3vpOl7dhoOkOZ7I20QDqA8WHr5qEk9WA/Nj+oS78eLq3
	 TrRnEaCBzylZ+dbdoO0Go0QGzUbanPN1OKHaYACnEXAoWEOBq6GX6Sz7/eSVIlKPCw
	 Ls76rcqwZfBmEs9J3up1pXkTz4yo+f8ORJF6gBkZl7PLvsSt5WfI4Up/OTY3xHdLNx
	 4p/VduBkXnnF0FK3g+msndQf5hP/VxLi/xnCzTR4p6cS4xoFoq0YqT4LgvXCDiSc/S
	 U0528848pyOkec/cmNUBl41rXd+STnN35+laUkPiR9bFvtfqZRw2r/vDMSLACMBwg8
	 qkA724UGmVPKw==
Date: Wed, 9 Sep 2026 17:48:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, stern@rowland.harvard.edu,
	boqun@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqF_0k0Rm20FZ5vB@localhost.localdomain>
References: <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
 <87ecf223n4.ffs@fw13>
 <20260909095518.GL776954@noisy.programming.kicks-ass.net>
 <aqFNV4k6DcbyxYCe@localhost.localdomain>
 <20260909124555.GM776954@noisy.programming.kicks-ass.net>
 <20260909125132.GR788244@noisy.programming.kicks-ass.net>
 <87y0dazgfz.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y0dazgfz.ffs@fw13>

Le Wed, Sep 09, 2026 at 03:45:36PM +0200, Thomas Gleixner a écrit :
> On Wed, Sep 09 2026 at 14:51, Peter Zijlstra wrote:
> > On Wed, Sep 09, 2026 at 02:45:55PM +0200, Peter Zijlstra wrote:
> >> On Wed, Sep 09, 2026 at 02:13:11PM +0200, Frederic Weisbecker wrote:
> >> > P2(int *next, int *prev, int *pid, spinlock_t *sighand)
> >> > {
> >> > 	int r0;
> >> > 	int r1;
> >> > 	// get target
> >> > 	r0 = READ_ONCE(*pid);
> >> > 	spin_lock(sighand);
> >
> > There is no dependency between r0 and sighand. While I think there is in
> > posixtimer_send_sigqueue(). Does making it smp_load_acquire() help?
> 
> sighand is r0->sighand->siglock and obviously not known before r0 is
> read. So yes there is a data dependency in reality :)

So unfortunately litmus tests don't support structures. So instead
of transfering the pid, I fake the data dependency by transfering the
sighand directly and then yes it works. I don't know what is the name
of the pattern behind that.

This is not a control dependency as there is no LOAD-cond-store. If
someone can shed some light on this?

C MP+farfetched

{}

P0(int *next, int *prev, int *exit_state, spinlock_t *tasklist_lock)
{
	// list_del_init()
	WRITE_ONCE(*next, 1);
	WRITE_ONCE(*prev, 1);
	// exit_notify()
	spin_lock(tasklist_lock);
	WRITE_ONCE(*exit_state, 1);
	spin_unlock(tasklist_lock);
}

P1(int *exit_state, spinlock_t *tasklist_lock, spinlock_t *sighand, spinlock_t **psighand)
{
	int r0;

	// de_thread()
	spin_lock(tasklist_lock);
	r0 = READ_ONCE(*exit_state);
	if (r0 == 1) {
		// exchange_tids()
		WRITE_ONCE(*psighand, sighand);
	}
	spin_unlock(tasklist_lock);
}

P2(int *next, int *prev, int *pid, spinlock_t *sighand, spinlock_t **psighand)
{
	spinlock_t *r0;
	int r1;

	// get target
	r0 = READ_ONCE(*psighand);
	spin_lock(r0);
	// queue signal
	r1 = READ_ONCE(*next);
	if (r1 == 1) {
		WRITE_ONCE(*prev, 2);
	}
	spin_unlock(r0);
}

exists (prev=1 /\ 2:r0=sighand) (* Bad outcome. *)
---
herd7 -conf linux-kernel.cfg ~/farfetched.litmus 
Test MP+farfetched Allowed
States 3
2:r0=0; [prev]=1;
2:r0=0; [prev]=2;
2:r0=sighand; [prev]=2;
No
Witnesses
Positive: 0 Negative: 7
Condition exists ([prev]=1 /\ 2:r0=sighand)
Observation MP+farfetched Never 0 7
