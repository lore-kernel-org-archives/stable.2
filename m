Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A948E0F3;
	Wed,  9 Sep 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945116; cv=none; b=Me0xcntJdqI0HNiLsE/4Q3N/zVy1gSwhM8kX/KVwrRuq5W/ShzPV1/scXRkyL9HXsfzXzgeRo3tK2j/liT7NGBDe2cxITFLLyNmgkpYFnREv2X00NdsucR5HMaLwWCYb0SuLujSdQVts5VDCfjrPX6YifXk+HtoSTTC9LgJAcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945116; c=relaxed/simple;
	bh=2I+Y0zzKhy8YfPYes+vOutoqBlkyvO7+McRXjZysZR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEq/AY/rwk4v6VAsC3dyVMys13/b8ATWKurjLhfC32QHCxhE80XWHCTpbRYznD6tf7fW98BiJ1zyd8iDXTmsKed9H4kJ6xfMu+OnOkdP9EIbLflC99e55+oW+y3SJKbgLB2zMGYNuy69ZR+aOW6lhFnbWHCGJWIGGkjOx/fG0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFn3+lmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFn3+lmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B571F00A3A;
	Wed,  9 Sep 2026 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945114;
	bh=wVKkDc8i7Ib4HdK2HxHrZ9/5xivRsmDDypQUvypNWu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OFn3+lmxMC4HNnQoouomAXj24DHxsHaOGOnLUpOiTgu8UwtF24WlmR20qprq0OhW9
	 n2/5ANnqWfS2b2RfYf7M5rWRnKkgwUBLoMBoVLpSb+tzBD2wmDAF35tDrSzIST7RnA
	 BDf9Xyk/cXGhV+YRZ1bw8NQr6gf60Bmtd+6lJwSkI/LFKPlj/GJCcWmTq2+4otpy9G
	 Z1bgivHAF1whCt3uidWEhvJXyWLFLIwyFwq6j+090retoir1ZsYUioswQz9v7FYWMH
	 RpcgkE39Eok8aDWr3BMIYP2BMUUDTUe0O3ryGK/QD0EFJxhiUTtzYJjNcHcnmfWwEX
	 0rDZE23b9SFkg==
Date: Wed, 9 Sep 2026 11:11:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqEi15q-nn8ChsMt@pavilion.home>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <20260909080407.GR4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909080407.GR4121339@noisy.programming.kicks-ass.net>

Le Wed, Sep 09, 2026 at 10:04:07AM +0200, Peter Zijlstra a écrit :
> On Tue, Sep 08, 2026 at 12:15:21PM +0200, Frederic Weisbecker wrote:
> 
> > Yes this side is well ordered but what about the other side.
> > Ok let's simplify the picture:
> > 
> > Old leader                           Exec'ing New leader     CPU 2
> > -----                                -----                   -----
> > 
> > WRITE q->next = q
> > WRITE q->prev = q
> > 
> > ACQUIRE tasklist
> > RELEASE tasklist
> >                                      ACQUIRE tasklist
> >                                      RELEASE tasklist
> > 
> >                                      WRITE pid
> >                                                              READ pid
> > 							     // smp_mb()
> >                                                              if q->next == q
> >                                                                  WRITE q->prev
> > 
> > Isn't there a missing pairing full barrier in CPU 2 ?
> 
> 
> Let me try and have a go :-)
> 
> 
> do_exit()				de_thread() 			posix_timer_fn()
>   exit_signal()				  LOCK siglock 			  posix_timer_send_sigqueue()
>     LOCK siglock			  UNLOCK siglock 		    t = posix_timer_get_target()
>     tsk->flags |= PF_EXITING; 						    LOCK siglock
>     UNLOCK siglock			  if (!thread_group_leader) 	      if (!list_empty(sigqueue))
>     					    LOCK tasklist_lock
>     flush_sigqueue_list();		    if (leader->exit_state)
> 					      break;
>   ...                                       transfer_pid()
> 					    UNLOCK tasklist_lock
>   exit_notify()
>     LOCK tasklist_lock
>     tsk->exit_state = EXIT_ZOMBIE;
>     UNLOCK tasklist_lock
> 
> 
> 
> Then there is indeed nothing that makes sure posix_timer_fn() sees
> sigqueue updates done by do_exit(), because those are ordered by
> tasklist_lock, but posix_timer_fn() doesn't care about that.
> 
> The easy solution would probably be to do transfer_pid() while holding
> siglock?

That should work, especially with a big fat comment, and the tasklist_lock ->
sighand lock dependency already exists.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs
