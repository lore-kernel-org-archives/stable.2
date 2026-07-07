Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11B349CD1;
	Tue,  7 Jul 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467687; cv=none; b=RCIGk+YmuPmZE1YT41wsSvqp4LCrdd8aezw/hkxdH7fTpW9kKz5uv/eY4pcjkfbetdW6RqxXr8R5EFnm5tWO5/kprJhH96DJjsymCA7SwoO/q2K/FTZM/rkoizpvhpb/g6bG/GzTRoYyfw6LvGsYpIJuCwZbszeBxLinpOHf0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467687; c=relaxed/simple;
	bh=i7ewHuxzPkA9KoYX7/PxaB7lMMRloxdH1dHoMAPbIaM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PhoX7+iRppDbC4pJp326vUsoRX9mEnMKyRhGbFQ75vA9yM0cfMiBVnYq3nFy0cd/ck2gXDbtVC3Sbyj2ktjU55plnsSNyQ6uN5yD3zt3ICBCYLwQGucvDpPC8LCRzK6Sm6aZ20XPheql+iHwpKFbJXfk1KUZ4ve6nyr+Ny5YCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRXKYv9y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRXKYv9y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED711F00A3A;
	Tue,  7 Jul 2026 23:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783467685;
	bh=GDdmt2xyO1Z29g9+aEQM+ouN+QmqVB/Ldi7iq44JXu8=;
	h=Date:From:To:Cc:Subject:References;
	b=FRXKYv9ypeo5O68Un9yvd6hK7X84fuJS2hSD5hox+67BYqAxUUC5o3kXon33PZ9Io
	 XQM3Z83iCBZUbpD6btj4XmSUXV3xOiijEwGLc7Yr+VduLThaYISFx5I0/K+XkgaciA
	 4bsVc+uMg47NhNvNTRdNMi8eU8jldQUgWwpCHgKsjKnZNxQBFqP6vhrW7kAE8ViBSS
	 ISplrELDIfduOwSZ5pteKz6SDHooQcrb4VF8H4eUq1gRQz1RIAI7amVnnowlyFwlz7
	 tFKfJR4xFfXqGMUwwZVfcDlFM2qlvam2OBEy2iq8VEEfg7MOuzZf1Boup6KHgxhnGn
	 xJ7tWXmNGbejA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1whFPt-00000000xpd-2Jo5;
	Tue, 07 Jul 2026 19:41:29 -0400
Message-ID: <20260707234129.394585410@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 19:34:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 XIAO WU <xiaowu.417@qq.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Michael Bommarito <michael.bommarito@gmail.com>
Subject: [for-linus][PATCH 1/2] tracing/user_events: Fix use-after-free in user_event_mm_dup()
References: <20260707233421.684046879@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Michael Bommarito <michael.bommarito@gmail.com>

user_event_mm_dup() walks the parent mm's enabler list locklessly under
rcu_read_lock() during fork() (from copy_process()); it does not take
event_mutex:

	rcu_read_lock();
	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link)
		enabler->event = user_event_get(orig->event);

user_event_enabler_destroy() removes an enabler from that list with
list_del_rcu() and then, without waiting for a grace period, drops the
enabler's user_event reference with user_event_put() and frees the enabler
with kfree(). A reader that loaded the enabler before the list_del_rcu()
can still be walking it, which leads to two use-after-frees:

 - kfree(enabler) frees the enabler while that reader dereferences
   enabler->event.

 - user_event_put() may drop the last reference to the user_event, which
   is then freed (via delayed_destroy_user_event() on a work queue), while
   the same reader does user_event_get(orig->event) on it.

Both are reachable by an unprivileged task that can open user_events_data:
one multithreaded process that registers an enabler and then concurrently
unregisters it and calls fork() triggers the race. KASAN reports a
slab-use-after-free in user_event_mm_dup() during clone(), with a
"refcount_t: addition on 0" warning when the user_event is freed.

The enabler use-after-free was found first; the user_event one was reported
by XIAO WU, and the earlier enabler-only fix did not address it.

Defer both the user_event_put() and the kfree(enabler) to a work item
queued with queue_rcu_work(), so they run only after an RCU grace period,
once all readers walking the enabler list have finished. The put must run
in process context because user_event_put() takes event_mutex on the last
reference, so a work queue is used rather than call_rcu(). The now-unlocked
put lets the locked argument of user_event_enabler_destroy() be removed;
all callers are updated.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260707165912.2560537-2-michael.bommarito@gmail.com
Reported-by: XIAO WU <xiaowu.417@qq.com>
Closes: https://lore.kernel.org/all/tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com/
Suggested-by: Beau Belgrave <beaub@linux.microsoft.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 39 ++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38..8c82ecb735f4 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,9 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+
+	/* Defer the event put and enabler free past an RCU grace period. */
+	struct rcu_work		put_rwork;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -396,17 +399,39 @@ static struct user_event_group *user_event_group_create(void)
 	return NULL;
 };
 
-static void user_event_enabler_destroy(struct user_event_enabler *enabler,
-				       bool locked)
+static void delayed_user_event_enabler_put(struct work_struct *work)
 {
-	list_del_rcu(&enabler->mm_enablers_link);
+	struct user_event_enabler *enabler = container_of(to_rcu_work(work),
+			struct user_event_enabler, put_rwork);
 
 	/* No longer tracking the event via the enabler */
-	user_event_put(enabler->event, locked);
+	user_event_put(enabler->event, false);
 
+	/* Run from queue_rcu_work(), the RCU grace period has elapsed */
 	kfree(enabler);
 }
 
+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
+{
+	list_del_rcu(&enabler->mm_enablers_link);
+
+	/*
+	 * The enabler is removed from an RCU-traversed list
+	 * (user_event_mm_dup() walks mm->enablers under rcu_read_lock() only),
+	 * and readers there dereference enabler->event and take a new ref on
+	 * it. Both the put of that event reference and the free of the enabler
+	 * therefore have to wait for a grace period so no reader can be looking
+	 * at the enabler or racing the last put of its event.
+	 *
+	 * The put itself must not run in RCU context: when it drops the last
+	 * reference user_event_put() takes event_mutex, which cannot be taken
+	 * from a softirq/RCU callback. Defer both to a work item scheduled
+	 * after a grace period via queue_rcu_work().
+	 */
+	INIT_RCU_WORK(&enabler->put_rwork, delayed_user_event_enabler_put);
+	queue_rcu_work(system_percpu_wq, &enabler->put_rwork);
+}
+
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
 				  int attempt)
 {
@@ -464,7 +489,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
 
 	/* User asked for enabler to be removed during fault */
 	if (test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))) {
-		user_event_enabler_destroy(enabler, true);
+		user_event_enabler_destroy(enabler);
 		goto out;
 	}
 
@@ -764,7 +789,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 	struct user_event_enabler *enabler, *next;
 
 	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
-		user_event_enabler_destroy(enabler, false);
+		user_event_enabler_destroy(enabler);
 
 	mmdrop(mm->mm);
 	kfree(mm);
@@ -2645,7 +2670,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
-				user_event_enabler_destroy(enabler, true);
+				user_event_enabler_destroy(enabler);
 
 			/* Removed at least one */
 			ret = 0;
-- 
2.53.0


