Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073049;
	b=IhvdHYQpkBvjZXeql+PQFNZtTz1tyebjl1o0oFPNvio3dcG5Mfz0Zoc11jTE8YXv8Goj
	 nan+5I6OhFRxd0R918ux+KGDHe84pHagrA4gQ106U0Tl8qy4ydtl3QyasGZsh4O7361oh
	 7r2ul3/d37trCcUKGlYRVhykOb6M0C0Bh+Aai/FV5PSEPt4Lr8nVqiq/zHIy3/Rc19Gc3
	 Pr6rvwTe63SKPucn9kFgZOZrp6MKi47Ri8AMQmGvTIt6gQo87USICxbe89cFO+h3vzA+k
	 YHarfV9EGX9D0Mz945HE5UX78XfXZTZtRwVW5r7BDdi/SJFbsKaoUDk54+WCYipCdNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073049;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Rspamd-Server:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=jA1Z4duQiQzeKq317JC2yso+OfINr1SzmCCDBHpydj0=;
	b=DdDtheX/GOGkyNgDkw+6f+tgq0/Pkzwfn1X6xOxuGuqp+SAAdHLDCt3EwFxU/X2/BQ3m
	 T0HVEk5d+e+858+phptwuvpMQoKG0rGwtWagElaf4LdXL3pZmsb6+kRi+6W623eoVD4El
	 FuwTmzLNdvMdbFGgcGkcJXMc6NZsXTjHZI3kB4Wk9oxVAkRf24biyGSydtr6lhwK5YE2L
	 ziMwBZQmEgiYUv5XpQghOwZ/wFx6NQkNUwvXYZfnpWsPe2dgkzh648u8Mjic2tSd2958J
	 G7wsd+45sw+0Hh/zPA/XeGtyssbagNG9uPOZB+iWtV3tSv3Pc8s8Kj7wMDwtnpsPD/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QHJOEINu;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B2606A32E;
	Sat,  7 Nov 2026 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2B2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=QHJOEINu
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 86C801C3AE5;
	Sat,  7 Nov 2026 17:37:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 535692002C;
	Sat,  7 Nov 2026 17:36:58 +0000 (UTC)
Date: Sat, 7 Nov 2026 12:36:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org, will@kernel.org,
 boqun@kernel.org, longman@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, dvhart@infradead.org, dave@stgolabs.net,
 andrealmeid@igalia.com, shuah@kernel.org, juri.lelli@redhat.com,
 linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/5] locking/rtmutex: Stop spinning on the owner when
 the waiter is woken
Message-ID: <20261107123642.149677cf@fedora>
In-Reply-To: <c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
	<20261106235931.1478800-2-mathieu.desnoyers@efficios.com>
	<20261107002927.3cbad7ff@fedora>
	<20261107104329.GA2668564@noisy.programming.kicks-ass.net>
	<c77635b1-9c24-459a-b75c-82cbfb67185f@efficios.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 535692002C
X-Rspamd-Server: rspamout08
X-Stat-Signature: m44kupjn78amr5iba158yzo71aerdhcm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195nEAbX1ye5HLf4TYsMhI2TyWK0f81IaE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=jA1Z4duQiQzeKq317JC2yso+OfINr1SzmCCDBHpydj0=; b=QHJOEINuZLikmXVnkZT2L1ruJL/sFiyj1a7fbmNisUYPM3FED5UQaDWWBORf0uFWwrdV+MSQvl3GNH3g8/YiS2DTRupvspu8y8ro5C+eGzlCZIyVNXhDeXc44nGtcTwk00tHGTLiRum5o/wuaeGIUUQHOStCmkvQsjjCbVzmWuA=
X-HE-Tag: 1794073018-50227
X-HE-Meta: U2FsdGVkX1/xkZuEMEbBCRfnErlHYkRLRDuQ4GKd9JI66MgGk/9EtQjOr/4EcRkcQOmN7p7qTwDBZxQqLm4BRwFmhmB9b4FT7qkkG/sM2/a/lPmoftsEN/kGVVCJbP+oMtphFphXzojKGJXDoLj7973AVD34omJ6wjmlwbP7MNKbExqBzs0oifpfMCDA5FVYn1bwahkR2vCtgteuYTycxiab2tDqi1C3jnBKVa3FWckqqUst1nKjCoFXLjeCFbuaIcALKm2/gOo7lB6qmJiGE5+o5wL3iio+Gr9V6QpxtRAQCR0nLXBc00qzgheVeJuVnuguVSM304hz/NPMKas+Vb2qsxx5UeuMKzPJ0tQ0jO7+eAxCRaeVpEa1zm7Nq6bRRB8MX3GIgUJ0MPL1PjHCTqzV34xxNRpvXpf+I1wuKcH8PTU1dokdby+pxg9PhWaszNLnhPaeC4uIiIqTG7UIUQ==

On Sat, 7 Nov 2026 07:29:54 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >>
> >> The above is very verbose. Are you starting to use AI? ;-)  
> 
> I definitely am, as stated in the cover letter. :-)

I skipped that part of the cover letter. The first patch touches my
code (it has my commit as fixes) so I just jumped straight to that one.

> 
> > 
> > He definitely is. I can't read the above, its word soup. Part of using
> > AI is making sure the Changelog is actually readable. This is not.  
> 
> Feedback on the commit message wording is welcome, I'll try to improve
> things for next iterations. Is the following easier to parse ? I fed
> Peter's and my own criticism to Claude and got it to rewrite the entire
> thing (and keep those learnings for next time):
> 
> locking/rtmutex: Stop spinning on the owner when the waiter is woken
> 
> The top waiter of an rt_mutex sets its sleep state. Then it spins in
> rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
> the waiter back to TASK_RUNNING. The spin loop does not check for this.
> So a timeout or a signal is only handled when the owner blocks, or when
> the waiter has to reschedule:
> 
>    CPU 0 (waiter)                            CPU 1 (owner)
> 
>                                              pthread_mutex_lock()
>                                                takes the PI futex
>                                              spins in userspace
>    pthread_mutex_timedlock(1ms)
>      futex_lock_pi()
>        rt_mutex_wait_proxy_lock()
>          set_current_state(TASK_INTERRUPTIBLE)
>          rt_mutex_slowlock_block()
>            rtmutex_spin_on_owner()
>              <timeout> hrtimer_wakeup()
>                wake_up_process(waiter)
>                  __state = TASK_RUNNING
>              owner_on_cpu(owner): true
>              need_resched(): false
>              keeps spinning                  still spins in userspace
> 
> The owner of a PI futex is a user task. It can run for a long time.
> With an owner spinning in userspace, a 1ms pthread_mutex_timedlock()
> returns up to 1.4s late. A signal to the waiter is delayed in the same
> way.
> 
> With PREEMPT_RT, a ww_mutex wound is missed too. Two contexts take two
> ww_mutexes in opposite order, on two CPUs. They spin on each other for
> up to a second.
> 
> Fix this by also stopping the spin when the waiter is TASK_RUNNING. The
> slowpath then handles the timeout, the signal or the wound, as it does
> after schedule().
> 
> rtlock waiters are not affected. Only the lock handoff wakes them from
> TASK_RTLOCK_WAIT.
> 
> With this patch, the 1ms timed lock returns after about 1ms. The
> ww_mutex ABBA resolves in microseconds. PI mutex throughput is
> unchanged. The futex and ww_mutex selftests added later in this series
> cover both cases.

Still way too verbose for the fix. It makes it sound more complicated
than it is.

  locking/rtmutex: Stop spinning on the owner when the waiter is woken  

  The top waiter of an rt_mutex sets its sleep state. Then it spins in
  rtmutex_spin_on_owner() as long as the owner is running. A wakeup sets
  the waiter back to TASK_RUNNING. The spin loop does not check for this.
  So a timeout or a signal is only handled when the owner blocks, or when
  the waiter has to reschedule.

  The rtmutex_spin_on_owner() is just an optimization with the idea that
  if the owner is still running on a CPU, it will likely release it soon.
  If the owner gets preempted or schedules out on its own, the spinning
  will stop and the waiter will sleep. This came from PREEMPT_RT adaptive
  spinning for rt_spin_locks that allowed them to behave more like normal
  spin locks and speed up PREEMPT_RT performance.

  The problem is that when this was implemented for futex and normal
  mutexes it did not account for timeouts or other mechanisms where
  the owner releasing the lock wasn't the only way for the spinning
  task to exit the mutex acquire. The spinning currently does not
  account for anything else but the lock being released or the owner
  sleeping.

  Luckily, when the spinning task needs to exit the mutex lock code, it's
  state is set to TASK_RUNNING. By having the spin check the spinning
  task's state to see if it switches to running, it can exit the spin
  appropriately.

How about something like the above?

-- Steve


> 
> Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 

