Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B387441621
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662096; cv=none; b=hGfKoFZvQQhOpYVKCI1x2bMtqqQPSgAkNWYRSuXxzK4mVgZoJiiPGCVW7/mRym21N++uwx8N5Cmw/WBPsVBd766X5Hg/5TbyEvL7yvz/8FcQOBqtCcZbFMgekRq1EJU4Zo9OIJYMMw/2FG4QZrzT6plKumFFkOfn0KQO5kaBlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662096; c=relaxed/simple;
	bh=F6DQWbvstl8SVmRnZH2tPBXDXQOXt2PnpCbwRJMaR5w=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fcPmIyRDusvtlrR1O/XTvbuSFTK0BbEIVaFAX5KgNjsM7Ij1jtSY6gUOo3iaMw0n0VN82P8378TE2FhWJ8sKFW5CboSUf2r9s9T62En0pkoe7X1RE3Ya4MvqBHqO9ryEAnLW5p4x03PYHIbAsiG530vI5rloUay7+q4ssJ1YdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWcke5zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWcke5zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9CB1F00ACA;
	Tue, 25 Aug 2026 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787662088;
	bh=DNO3c5U5YN+5AtRmbg06bqQrOxPYa27etk2nDmIWTCQ=;
	h=Date:From:To:Cc:Subject:References;
	b=VWcke5znlkZSqtQYXWyWOBYjOcnHMIdukpLtNRdbzWXbnwHUOdvlqEd1/Yf5FNgIE
	 Yyp8yTMOnKbNPS3zUqNWajfr5qDgAjjKEvOza5BtACcQZm1kRbW2JufuGWaWMam1Gt
	 pv+CZBsTvwOEJRfnQrSbayI6Jrf8YoKPp8MgeOKyadKzKCBZYHka2VVj93bhH9rPl7
	 UVLX2yKqErpmiuXXGchuA3eraF8vajV+nW1X25YBvyt8M77q5yyAT/ChB+WQZSklZv
	 QFXm+AJV3wvtGfuWvWxkfnmYZw2E1pF6UVeeqTuXeY8CVZ6LZmBlWT9liRwdeYqaE8
	 Vuy+J47Fx2j1Q==
Date: Tue, 25 Aug 2026 14:48:05 +0200
Message-ID: <20260825091134.625975287@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
 Kyle Zeng <kylebot@openai.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 6.18.y 3/5] futex/pi: Plug private futex exec() race
References: <2026082450-shoplift-anew-8412@gregkh>
 <20260825091033.136528074@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@kernel.org>

commit c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc upstream.

The check for private futexes whether the waiter's mm, which is stored in
the futex_key and copied into the pi_state, is the same as the owner's mm
is not sufficient for exec(). exec() has a gap where the mm check fails to
give the correct answer:

  exec()
  ...
    exec_release_mm()
      futex_exec_release()
        tsk::futex::exit_state = EXITING;
        cleanup_robust_list();
1)      tsk::futex::exit_state = OK;
    ...
    old_mm = tsk::mm;
2)  tsk::mm = ->mm;

Between #1 and #2 the check for the mm is wrong as that mm is about to be
swapped out and eventually freed.

Plug this gap by:

  1) Setting tsk::futex::exit_state to FUTEX_STATE_DEAD in
     futex_exec_release()

  2) Setting tsk::futex::exit_state to FUTEX_STATE_OK after
     the mm has been switched.

>From a futex point of view the task is dead after it finished the robust
list cleanup up to the point where it sets the state to OK again.

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
---
 fs/exec.c             |    8 +++++--
 include/linux/futex.h |    2 +
 kernel/futex/core.c   |   54 ++++++++++++++++++++++++++++++++++----------------
 kernel/futex/pi.c     |   22 ++++++++++++++------
 4 files changed, 61 insertions(+), 25 deletions(-)
---
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
+#include <linux/futex.h>
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -851,6 +852,7 @@ static int exec_mmap(struct mm_struct *m
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
+	/* Clean up futexes and release the mm */
 	exec_mm_release(tsk, old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
@@ -899,9 +901,11 @@ static int exec_mmap(struct mm_struct *m
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop_lazy_tlb(active_mm);
+
+	futex_exec_done(tsk);
 	return 0;
 }
 
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,7 @@ static inline void futex_init_task(struc
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+void futex_exec_done(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -98,6 +99,7 @@ static inline void futex_init_task(struc
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1496,10 +1496,10 @@ static void futex_cleanup_begin(struct t
 	raw_spin_unlock_irq(&tsk->pi_lock);
 }
 
-static void futex_cleanup_end(struct task_struct *tsk, int state)
+static void futex_cleanup_end(struct task_struct *tsk)
 {
 	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
-		tsk->futex_state = state;
+		tsk->futex_state = FUTEX_STATE_DEAD;
 
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
@@ -1508,29 +1508,49 @@ static void futex_cleanup_end(struct tas
 	mutex_unlock(&tsk->futex_exit_mutex);
 }
 
-void futex_exec_release(struct task_struct *tsk)
+void futex_exit_release(struct task_struct *tsk)
 {
-	/*
-	 * The state handling is done for consistency, but in the case of
-	 * exec() there is no way to prevent further damage as the PID stays
-	 * the same. But for the unlikely and arguably buggy case that a
-	 * futex is held on exec(), this provides at least as much state
-	 * consistency protection which is possible.
-	 */
 	futex_cleanup_begin(tsk);
 	futex_cleanup(tsk);
+	futex_cleanup_end(tsk);
+}
+
+void futex_exec_release(struct task_struct *tsk)
+{
 	/*
-	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
-	 * exec a new binary.
+	 * exec() makes it interesting for futexes because the TID of the task
+	 * stays the same, but from a futex perspective the task has to be
+	 * treated like an exiting task. This is especially important for the
+	 * sanity check for private futexes in attach_to_pi_owner() which
+	 * compares the owner's mm with the waiter's mm.
+	 *
+	 * That check would give the wrong answer if futex_cleanup_end() would
+	 * set the state to FUTEX_STATE_OK as long as the task still has the old
+	 * mm.
+	 *
+	 * After the task has switched to the new mm it sets it to
+	 * FUTEX_STATE_OK again in futex_exec_done().
 	 */
-	futex_cleanup_end(tsk, FUTEX_STATE_OK);
+	futex_exit_release(tsk);
 }
 
-void futex_exit_release(struct task_struct *tsk)
+/*
+ * exec() has switched to the new mm. Futex operations are safe again.
+ */
+void futex_exec_done(struct task_struct *tsk)
 {
-	futex_cleanup_begin(tsk);
-	futex_cleanup(tsk);
-	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
+	/*
+	 * This store does not have to take tsk::futex::exit_mutex because the
+	 * phase where waiters block on it during state FUTEX_STATE_EXITING has
+	 * been finished when futex_cleanup_end() set the state to
+	 * FUTEX_STATE_DEAD.
+	 *
+	 * This transitions back from FUTEX_STATE_DEAD to FUTEX_STATE_OK. The
+	 * ordering guarantee required here is that the previous store to
+	 * tsk::mm in the calling code cannot be reordered against this store.
+	 */
+	guard(raw_spinlock_irq)(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_OK;
 }
 
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -200,15 +200,25 @@ void put_pi_state(struct futex_pi_state
  *
  * - FUTEX_STATE_OK when the task is alive and waiters can be attached
  *
- * - FUTEX_STATE_EXITING when the task cleans up the robust list and pi
+ * - FUTEX_STATE_EXITING when the task cleans up the robust list and PI
  *   state. Concurrent waiters cannot attach anymore and have to wait until the
- *   cleanup is finished to re-evaluate the potential changes of robust list and
- *   pi state cleanups.
+ *   cleanup is finished to re-evaluate the potential changes caused by the
+ *   robust list and PI state cleanups.
  *
- * - FUTEX_STATE_DEAD when the task has cleaned up the robust list and
- *   is about to fully exit.
+ * - FUTEX_STATE_DEAD when the task has cleaned up the robust list. This state
+ *   is set independent of exit() or exec(). In the exit() case the task is
+ *   gone. In the exec() case this ensures that nothing can attach to the task
+ *   after cleaning up the robust list and PI state before it has switched to
+ *   the new mm. From a futex point of view the task is dead until it sets the
+ *   state to FUTEX_STATE_OK again after switching to the new mm.
  *
- * exec() switches back to FUTEX_STATE_OK after the cleanup.
+ * The valid state transitions for exit():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD
+ *
+ * The valid state transitions for exec():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD -> FUTEX_STATE_OK
  *
  * The state has two related locks:
  *

