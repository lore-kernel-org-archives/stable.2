Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04367437130
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562679; cv=none; b=UTBTx5uBuO4SmdSZatZ40Uy/f6sAQa3AGh2CgrUS6UTw0Rqz5tbInAtTiF1733XJY27GY6DiCOtXO3CRywmkNFyKS54CfkEBtgD6TNGYnfQESKph9+mpVNmnLlZWqSL5l8Mrbcbnc8c7UYVT4r9DkEdmbYXyZuJh4nAQwznEDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562679; c=relaxed/simple;
	bh=vipJAVOk39vSaAAui89EOnItUqpCLFly0x0tTJSepCw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=osxojL/mzxOra4H2T+0DUMkWmLvC/fCoDeNUtMEpnTHvCcIlD5G3PprXxckxppbID+m363caYoEfl1SshL4rmLy0oGkUfJFVu9gZKxM3iR62ITYyJEREler0cX1T3jqYZlUIQCqhh9kd+wGlTcRGzKM5TAdDY7rFG2IS3y7kZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HmoldhyI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HmoldhyI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AFC1F000E9;
	Mon, 20 Jul 2026 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562677;
	bh=cbpV4i2/SBVw4fGjGcUaKevd5hm7KsApe4eVcKwGvx4=;
	h=Subject:To:Cc:From:Date;
	b=HmoldhyIOYlBQPfgf7tlUtggdKQ9jZwsrPyiMwoSk3UyOKjjH5PwD3Oa5qhTSN38k
	 jLcW2+v6p5GAfyWjQandVnqfdnadb5Qzp5oB4skwvWXtBNraa0cV2O5HW80Fo1Ce7v
	 eHaAjvkwXT3J0mA+wX11NP72nKB9WsJ0+7JC9Z1k=
Subject: FAILED: patch "[PATCH] tracing/user_events: Fix use-after-free in" failed to apply to 6.6-stable tree
To: michael.bommarito@gmail.com,beaub@linux.microsoft.com,rostedt@goodmis.org,xiaowu.417@qq.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:45:54 +0200
Message-ID: <2026072054-anywhere-moodiness-9087@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 50fd6dd755c6e48a38af2fa4621167eea56829c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072054-anywhere-moodiness-9087@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50fd6dd755c6e48a38af2fa4621167eea56829c2 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 7 Jul 2026 12:59:11 -0400
Subject: [PATCH] tracing/user_events: Fix use-after-free in
 user_event_mm_dup()

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
@@ -396,15 +399,37 @@ static struct user_event_group *user_event_group_create(void)
 	return NULL;
 };
 
-static void user_event_enabler_destroy(struct user_event_enabler *enabler,
-				       bool locked)
+static void delayed_user_event_enabler_put(struct work_struct *work)
+{
+	struct user_event_enabler *enabler = container_of(to_rcu_work(work),
+			struct user_event_enabler, put_rwork);
+
+	/* No longer tracking the event via the enabler */
+	user_event_put(enabler->event, false);
+
+	/* Run from queue_rcu_work(), the RCU grace period has elapsed */
+	kfree(enabler);
+}
+
+static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 {
 	list_del_rcu(&enabler->mm_enablers_link);
 
-	/* No longer tracking the event via the enabler */
-	user_event_put(enabler->event, locked);
-
-	kfree(enabler);
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
 }
 
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
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

