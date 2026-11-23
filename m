Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426660;
	b=U7i9ZVl8KxuVosnrTuA/hzavWFvIy2a+sMut3m6wijiUYKdfEmOZlP1SqpOd8N3olqJj
	 vriUByehuQkWTHih+irVUtPddQCSzPUIQm1+7WMPj3ZAirECvvz6+tsSpYYuyIndzhgUu
	 frj6gzqRyADlIpT05j36nZFnUBOiGmGPPBwKO226F3cHBmQwcamyPDPSG+xGqRVbkZkMw
	 y3UDnLAzx6I8AQmuv0nYFsfZ29Dhl7dQIWJeUfpKx5Qi9TkPYADHKOmxxgpjVbgUhuvsl
	 N0DPdF38vrPZKO0HNQtsoe6tRsSKq0otnPFPwvJsHdyP8tjurNKmSV4doBxcIT8/StA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426660;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=cKnbPGNeyXzWcMUB6hAx0YiHYJg4/2SvsAVSYahaqG0=;
	b=z94Qes++mAHXkVBKfG5Ar8BBIe4XgnyaRe63q0xrUP3/ChHgBpvnAZipLi2rjENv5h6g
	 jedEc7Ng44TDpsZBncsbX9s08lQpSy/u+ZPS+zs+CztKOkAsdQt6aqRRHAB7qx1wmi9ka
	 TPzUZbUs5ExZ6nrk7s3GPBW92Ds3ClE/HagJAk68e5L2v+3EaHHRhEvjzL6xhkGIRb488
	 Ppw36YqOXIVFmA0fkgg/IU+J/ZeJplJQgaonApOeF/2XrmrIrTx/EZqWDMTLBITDNb2I5
	 pezxVcind47daIw1Z0hlU7R9HOEiVGWlOMMY0WgIIbdPmYcpN51Ci+vBBINUqkl0Spw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=z6FYEL6J;
	arc=none smtp.remote-ip=45.157.188.9
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825D60A5BC9
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E825D60A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=z6FYEL6J
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jY17Z2GRmzGwP;
	Mon, 23 Nov 2026 10:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1795426650;
	bh=cKnbPGNeyXzWcMUB6hAx0YiHYJg4/2SvsAVSYahaqG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z6FYEL6JBhfbd3llYg5iP+T9ak/FPEWvQ5CtRc2pvy/OgYxGxuGmeeBy4jk1vdCdi
	 SyQibwfVf+xdR8tfx9UJ5hgBwA3M5M+Fejx0dJssbIvvENlgNau9I8cy2WlmkIEKLb
	 /SEyaAGFMJ91LebMRSTtELbTEStqeNZaxk+KlRUw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4jY17T6x3Bz1WM;
	Mon, 23 Nov 2026 10:37:25 +0100 (CET)
Date: Mon, 23 Nov 2026 10:37:22 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Cen Zhang <blbllhy@gmail.com>, James Morris <jmorris@namei.org>, 
	Lee Seong Hyeon <ihopenre@gmail.com>, Marco Elver <elver@google.com>, NeilBrown <neil@brown.name>, 
	Nickolai Zeldovich <nickolai@csail.mit.edu>, Paul Moore <paul@paul-moore.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Yihan Ding <dingyihan@uniontech.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] landlock: Do not hold exec_update_lock across the TSYNC
 wait
Message-ID: <20261123.RailieV3ePah@digikod.net>
References: <20261120151554.2651743-1-mic@digikod.net>
 <20261121.bd9ab1ba5f9f@gnoack.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261121.bd9ab1ba5f9f@gnoack.org>
X-Infomaniak-Routing: alpha

On Sat, Nov 21, 2026 at 10:46:49PM +0100, Günther Noack wrote:
> On Fri, Nov 20, 2026 at 04:15:52PM +0100, Mickaël Salaün wrote:
> > landlock_restrict_sibling_threads() write-locks
> > current->signal->exec_update_lock to serialize TSYNC callers, and holds
> > it until every sibling thread has run its task_work.  This wait is
> > unbounded: TWA_SIGNAL does not wake a TASK_KILLABLE sleeper, so a
> > sibling blocked as a vfork() parent runs it only once its child execs or
> > exits.
> > 
> > Meanwhile, readers of this lock block, mostly in D state:
> > /proc/<pid>/stat, mm_access(), pidfd_getfd(), kcmp(), perf_event_open(),
> > etc.  An unprivileged process can thus stall tools run by other users,
> > including root, such as ps and top.
> > 
> > Only a per-process "TSYNC in progress" marker is needed.  Use an unused
> > signal_struct.flags bit, protected by sighand->siglock, which is held
> > only to set or clear the marker.  A second caller still restarts the
> > syscall, and a cleanup class releases the marker on every return.
> > 
> > Like de_thread(), treat a group exit or an ongoing exec as a held
> > marker: a group exit may overwrite the flags, and both kill the other
> > threads, which the restart lets the caller handle.
> > 
> > Add KUnit tests for taking a free marker and for rejecting a held one.
> > A concurrent TSYNC caller cannot be started deterministically from user
> > space, but a KUnit thread has no sibling and can hold the marker itself.
> > 
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Günther Noack <gnoack@google.com>
> > Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Yihan Ding <dingyihan@uniontech.com>
> > Cc: stable@vger.kernel.org
> > Reported-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > Suggested-by: Lee Seong Hyeon <ihopenre@gmail.com>
> > Fixes: ff88df67dbf7 ("landlock: Serialize TSYNC thread restriction")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> > 
> > Changes since the initial report from Lee Seong Hyeon:
> > - Rewrite the fix, storing the marker in an unused signal_struct.flags
> >   bit protected by sighand->siglock instead of adding a signal_struct
> >   field.
> > - Treat group exit and ongoing exec as a held marker, because group exit
> >   may overwrite the flags.
> > - Release the marker with a cleanup class.
> 
> It's not clear to me why the cleanup class and the fix are bundled in
> one commit here.  (I do find the cleanup class useful, but shouldn't a
> bugfix commit be as minimal as possible so that it is easy for people
> to apply to their downstream kernels?)

I included the cleanup class because we needed to change the up_write()
call anyway, so it's a good opportunity to use an automatic cleanup
mechanism instead of replacing it with an explicit lock + flag change.

I also moved the initial check before the initialization because it
makes more sense there and it was a good opportunity to do it now (I
updated the comment as well).

This extra cleanup doesn't have any impact on backporting.

> 
> –Günther
> 
> > - Clarify that not all readers wait in D state: perf_event_open() waits
> >   interruptibly.
> > - Add KUnit tests.
> > - Credit Lee Seong Hyeon with Reported-by and Suggested-by instead of
> >   authorship, because the implementation was rewritten.
> > 
> > Christian, Oleg, and Tejun, this patch reserves a signal_struct.flags
> > bit for Landlock and relies on group-exit paths overwriting these flags
> > under siglock.  Please check that this use of signal-core state is
> > acceptable.
> > 
> > Lee, this rewrites the patch you sent with your report, so it credits
> > you with Reported-by and Suggested-by.  Please tell me if you prefer a
> > different credit.
> > ---
> >  include/linux/sched/signal.h |   1 +
> >  security/landlock/tsync.c    | 134 +++++++++++++++++++++++++++++++----
> >  2 files changed, 122 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> > index 0adb51ab1542..f68bbaa3527a 100644
> > --- a/include/linux/sched/signal.h
> > +++ b/include/linux/sched/signal.h
> > @@ -262,6 +262,7 @@ struct signal_struct {
> >  #define SIGNAL_STOP_STOPPED	0x00000001 /* job control stop in effect */
> >  #define SIGNAL_STOP_CONTINUED	0x00000002 /* SIGCONT since WCONTINUED reap */
> >  #define SIGNAL_GROUP_EXIT	0x00000004 /* group exit in progress */
> > +#define SIGNAL_LANDLOCK_TSYNC	0x00000008 /* Landlock TSYNC in progress */
> >  /*
> >   * Pending notifications to parent.
> >   */
> > diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> > index cfa73a2a67ca..a6fa9ce0ac78 100644
> > --- a/security/landlock/tsync.c
> > +++ b/security/landlock/tsync.c
> > @@ -5,6 +5,7 @@
> >   * Copyright © 2025 Google LLC
> >   */
> >  
> > +#include <kunit/test.h>
> >  #include <linux/atomic.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/completion.h>
> > @@ -479,6 +480,46 @@ static void cancel_tsync_works(const struct tsync_works *works,
> >  	}
> >  }
> >  
> > +/*
> > + * try_set_current_tsync_marker - mark the current thread group as under TSYNC
> > + *
> > + * Returns false if another TSYNC operation, group exit, or exec is in progress.
> > + */
> > +static bool try_set_current_tsync_marker(void)
> > +{
> > +	struct signal_struct *const signal = current->signal;
> > +
> > +	guard(spinlock_irq)(&current->sighand->siglock);
> > +
> > +	/*
> > +	 * Group-exit paths may replace all signal flags, including an active
> > +	 * marker.  Treat SIGNAL_GROUP_EXIT as a held marker to prevent another
> > +	 * TSYNC operation from starting during group teardown.
> > +	 *
> > +	 * Like de_thread(), also treat an ongoing exec as a group action in
> > +	 * progress.  de_thread() sets group_exec_task in the same siglock
> > +	 * critical section that sends SIGKILL to all other threads, including
> > +	 * current.  Instead of queuing task_work for exiting threads,
> > +	 * restart_syscall() lets current handle its pending SIGKILL.
> > +	 */
> > +	if ((signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_LANDLOCK_TSYNC)) ||
> > +	    signal->group_exec_task)
> > +		return false;
> > +
> > +	signal->flags |= SIGNAL_LANDLOCK_TSYNC;
> > +	return true;
> > +}
> > +
> > +static void clear_current_tsync_marker(void)
> > +{
> > +	guard(spinlock_irq)(&current->sighand->siglock);
> > +
> > +	current->signal->flags &= ~SIGNAL_LANDLOCK_TSYNC;
> > +}
> > +
> > +DEFINE_CLASS(current_tsync_marker, bool, if (_T) clear_current_tsync_marker(),
> > +	     try_set_current_tsync_marker(), void)
> > +
> >  /*
> >   * restrict_sibling_threads - enables a Landlock policy for all sibling threads
> >   */
> > @@ -492,6 +533,19 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	size_t newly_discovered_threads;
> >  	bool found_more_threads;
> >  
> > +	/*
> > +	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> > +	 * multiple threads call landlock_restrict_self() simultaneously.  If
> > +	 * another operation got there first, gracefully yield by restarting the
> > +	 * syscall.  This allows the current thread to process pending
> > +	 * task_works before retrying.
> > +	 *
> > +	 * sighand->siglock protects only the marker, not the wait below.
> > +	 */
> > +	CLASS(current_tsync_marker, marker)();
> > +	if (!marker)
> > +		return restart_syscall();
> > +
> >  	atomic_set(&shared_ctx.preparation_error, 0);
> >  	init_completion(&shared_ctx.all_prepared);
> >  	init_completion(&shared_ctx.ready_to_commit);
> > @@ -503,16 +557,6 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		(restrict_flags & LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS) ||
> >  		task_no_new_privs(current);
> >  
> > -	/*
> > -	 * Serialize concurrent TSYNC operations to prevent deadlocks when
> > -	 * multiple threads call landlock_restrict_self() simultaneously.
> > -	 * If the lock is already held, we gracefully yield by restarting the
> > -	 * syscall. This allows the current thread to process pending
> > -	 * task_works before retrying.
> > -	 */
> > -	if (!down_write_trylock(&current->signal->exec_update_lock))
> > -		return restart_syscall();
> > -
> >  	/*
> >  	 * We schedule a pseudo-signal task_work for each of the calling task's
> >  	 * sibling threads.  In the task work, each thread:
> > @@ -536,8 +580,9 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  	 * 5) signals that it's done altogether (barrier synchronization
> >  	 *    "all_finished")
> >  	 *
> > -	 * Unlike seccomp, which modifies sibling tasks directly, we do not
> > -	 * need to acquire the cred_guard_mutex and sighand->siglock:
> > +	 * Unlike seccomp, which modifies sibling tasks directly, we do not need
> > +	 * to hold the cred_guard_mutex or sighand->siglock around the thread
> > +	 * walk:
> >  	 *
> >  	 * - As in our case, all threads are themselves exchanging their own
> >  	 *   struct cred through the credentials API, no locks are needed for
> > @@ -634,6 +679,69 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
> >  		wait_for_completion(&shared_ctx.all_finished);
> >  
> >  	tsync_works_release(&works);
> > -	up_write(&current->signal->exec_update_lock);
> >  	return atomic_read(&shared_ctx.preparation_error);
> >  }
> > +
> > +#ifdef CONFIG_SECURITY_LANDLOCK_KUNIT_TEST
> > +
> > +static bool is_current_tsync_marker_set(void)
> > +{
> > +	return current->signal->flags & SIGNAL_LANDLOCK_TSYNC;
> > +}
> > +
> > +static void test_tsync_marker_free(struct kunit *const test)
> > +{
> > +	const struct cred *const cred = current_cred();
> > +
> > +	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
> > +	KUNIT_ASSERT_FALSE(test, is_current_tsync_marker_set());
> > +
> > +	KUNIT_EXPECT_TRUE(test, try_set_current_tsync_marker());
> > +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> > +	clear_current_tsync_marker();
> > +	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
> > +
> > +	/* Takes and releases the marker. */
> > +	KUNIT_EXPECT_EQ(test, 0,
> > +			landlock_restrict_sibling_threads(cred, cred, 0));
> > +	KUNIT_EXPECT_FALSE(test, is_current_tsync_marker_set());
> > +}
> > +
> > +static void test_tsync_marker_held(struct kunit *const test)
> > +{
> > +	const struct cred *const cred = current_cred();
> > +
> > +	KUNIT_ASSERT_TRUE(test, thread_group_empty(current));
> > +	KUNIT_ASSERT_TRUE(test, try_set_current_tsync_marker());
> > +
> > +	KUNIT_EXPECT_FALSE(test, try_set_current_tsync_marker());
> > +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> > +
> > +	/* Restarts without releasing the marker held by another caller. */
> > +	KUNIT_EXPECT_EQ(test, -ERESTARTNOINTR,
> > +			landlock_restrict_sibling_threads(cred, cred, 0));
> > +	KUNIT_EXPECT_TRUE(test, is_current_tsync_marker_set());
> > +
> > +	/* Clears TIF_SIGPENDING set by restart_syscall(). */
> > +	scoped_guard(spinlock_irq, &current->sighand->siglock)
> > +		recalc_sigpending();
> > +
> > +	clear_current_tsync_marker();
> > +}
> > +
> > +static struct kunit_case test_cases[] = {
> > +	/* clang-format off */
> > +	KUNIT_CASE(test_tsync_marker_free),
> > +	KUNIT_CASE(test_tsync_marker_held),
> > +	{}
> > +	/* clang-format on */
> > +};
> > +
> > +static struct kunit_suite test_suite = {
> > +	.name = "landlock_tsync",
> > +	.test_cases = test_cases,
> > +};
> > +
> > +kunit_test_suite(test_suite);
> > +
> > +#endif /* CONFIG_SECURITY_LANDLOCK_KUNIT_TEST */
> > 
> > base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> > -- 
> > 2.56.0
> > 
> 
