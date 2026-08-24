Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A209403B11
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568750; cv=none; b=p6egpTaIxUZ5Z3hhVhAXM3vyH8ZECI5AHLbkkSqdB2x3FZiOh7rNp0th5LR0YDC4XDaaiJFk1qPuFRWn507+ap/ZugQGLBlM9cct1d3r5zB2/NlVrxTRORHPqt2o41Mn/ChTxfJBnAe2xpg9LaU8DtlF1mWiiNPzwUk4GTpH4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568750; c=relaxed/simple;
	bh=qojfnAXIBENpNsOudf4wtrZm2BBhdfSgWrgam+kbYZQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GRHScbBxPt7OqAyM9bW8/h8M/fZujqoGERuLYUDvzd2SWX/gc38PfaSDWrlM7IJLhlYx2K0bES1LlT8IopNiCJINHFnxt7xWrrgyfQ74sYOQwuISwIai2DqHO0/fiDoxpPW0PeWDuqYUIOoKeWJtGoYdZDf1Bth3AVxQUySxuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JN6iVM0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JN6iVM0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C011F000E9;
	Mon, 24 Aug 2026 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787568748;
	bh=ZeynihzyYapVQZJJ6wT6wtZW9jFFnohwUp2wOtAiM4o=;
	h=Subject:To:Cc:From:Date;
	b=JN6iVM0tAWruQ7Nn6Kq3lz/shiDB3/ZX3p9NNq6D5hSxHIxTDz4OTo6ts0IevKx0h
	 Rick7ur7940G9nBVdvkiTPobByMl0SJWR3tx41RLzjUnjYhAOyRQsu12I3ziOwZhSA
	 6QebHD1oaJFdRNNUzpsMdOcKnzGxsRSCl0yLdlhM=
Subject: FAILED: patch "[PATCH] futex/pi: Plug private futex exec() race" failed to apply to 7.1-stable tree
To: tglx@kernel.org,kylebot@openai.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Aug 2026 12:52:16 +0200
Message-ID: <2026082416-unopened-rectify-cdc8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082416-unopened-rectify-cdc8@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@kernel.org>
Date: Fri, 7 Aug 2026 17:07:13 +0200
Subject: [PATCH] futex/pi: Plug private futex exec() race

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

From a futex point of view the task is dead after it finished the robust
list cleanup up to the point where it sets the state to OK again.

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local hash")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org

diff --git a/fs/exec.c b/fs/exec.c
index c7b8f2d6366c..d01523d0d8b4 100644
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
@@ -854,6 +855,7 @@ static int exec_mmap(struct linux_binprm *bprm)
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
+	/* Clean up futexes and release the mm */
 	exec_mm_release(tsk, old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
@@ -902,9 +904,10 @@ static int exec_mmap(struct linux_binprm *bprm)
 		BUG_ON(active_mm != old_mm);
 		/* Defer teardown to setup_new_exec(), outside the exec locks. */
 		bprm->old_mm = old_mm;
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop_lazy_tlb(active_mm);
+	futex_exec_done(tsk);
 	return 0;
 }
 
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 51f4ccdc9092..51d5faa1266f 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -73,6 +73,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+void futex_exec_done(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -91,6 +92,7 @@ static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 			    u32 __user *uaddr2, u32 val2, u32 val3)
 {
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0ea2c1a89f6c..3c1562df0370 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1524,11 +1524,11 @@ static void futex_cleanup_begin(struct task_struct *tsk)
 	raw_spin_unlock_irq(&tsk->pi_lock);
 }
 
-static void futex_cleanup_end(struct task_struct *tsk, int state)
+static void futex_cleanup_end(struct task_struct *tsk)
 	__releases(&tsk->futex.exit_mutex)
 {
 	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
-		tsk->futex.state = state;
+		tsk->futex.state = FUTEX_STATE_DEAD;
 
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
@@ -1537,29 +1537,49 @@ static void futex_cleanup_end(struct task_struct *tsk, int state)
 	mutex_unlock(&tsk->futex.exit_mutex);
 }
 
-void futex_exec_release(struct task_struct *tsk)
-{
-	/*
-	 * The state handling is done for consistency, but in the case of
-	 * exec() there is no way to prevent further damage as the PID stays
-	 * the same. But for the unlikely and arguably buggy case that a
-	 * futex is held on exec(), this provides at least as much state
-	 * consistency protection which is possible.
-	 */
-	futex_cleanup_begin(tsk);
-	futex_cleanup(tsk);
-	/*
-	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
-	 * exec a new binary.
-	 */
-	futex_cleanup_end(tsk, FUTEX_STATE_OK);
-}
-
 void futex_exit_release(struct task_struct *tsk)
 {
 	futex_cleanup_begin(tsk);
 	futex_cleanup(tsk);
-	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
+	futex_cleanup_end(tsk);
+}
+
+void futex_exec_release(struct task_struct *tsk)
+{
+	/*
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
+	 */
+	futex_exit_release(tsk);
+}
+
+/*
+ * exec() has switched to the new mm. Futex operations are safe again.
+ */
+void futex_exec_done(struct task_struct *tsk)
+{
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
+	tsk->futex.state = FUTEX_STATE_OK;
 }
 
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 2731e55f99e5..88788e584ec8 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -200,15 +200,25 @@ void put_pi_state(struct futex_pi_state *pi_state)
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

