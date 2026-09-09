Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62534B662;
	Wed,  9 Sep 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969648; cv=none; b=Imfd44XtpaAQmnQKJX0RHxbhp9+mEJXHe5pB3uDyBN2p4TFIXQPeUTXFvQtvpuBFwc19abn/Ri2jzuhUp7KqYN6TeqIqLG4A5Fxepg0k6oUjYyz5201wRai8TzqIBMCoWYnLBa9HkbuhwLY44xvc0Ro5VibM8PnvMB81zZRP2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969648; c=relaxed/simple;
	bh=cpTPnd7pWK5eEW1OuQb6BToekQ22eL6zv/ZcC/yVIIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJJt86yXLqDzvcRpTKRDAIAGah5u45d1eYFJr/BZ7irD1AnGzZ4DMntm1pUwSCZmFAhLJE1i50Rvfrseou7ZfusPCVUEuPoBfrG32quXFPKoLKRTl0WBWsTPHQL1ZO05pbwI0Sx9yX3eFAaIe883LZ8pUj1edvIfZrqcl50D9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj5pYV1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj5pYV1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AEC1F00A3A;
	Wed,  9 Sep 2026 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969647;
	bh=ACX3+kzBmsgb/CKiD7Qt0I2ijyAxdncUGtmoRTdOhmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aj5pYV1YhQZwR+2lHuH2kvFGKoewZscOFStg+LVtY9yX94srDiBO6P+H1yNt4oWwz
	 b9DA4D4/t6siI1ybjSjQTAQpub80KUzLHctxCKAjciG187X3Kh1u/OlGqGyQRHCnFd
	 iDiOitbF0rQ/KLj8rGPvXoKdwZnDDrqvSsOEXVd7sL9t/RxNFxzzGoDCh9btee2u6C
	 IF4O/HIBf7GG5d7GjcZ18gt9njgk9esU5ROBHUB5XAMsRcjJ9Jf+1u3AVR/nXMuqnV
	 UR8UPq7z0W9c4UCWPcuWQWk3LRzkvzojt2TLVS2sIAp7mSmiB5KWrFGfSm9QbqtHpn
	 e1E7GJ4dqSD6w==
Date: Wed, 9 Sep 2026 18:00:44 +0200
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
Message-ID: <aqGCrJ-eLHmLAwdp@localhost.localdomain>
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

Ah but the script writes *psighand on one hand and the spin_lock on the
other hand does an acquire so of course it works. But that doesn't tell
if that's transferrable through struct pid->task write on one hand and
struct pid->task deref on the other hand plus task->sighand dependencies.

My brain melts enough for today...
