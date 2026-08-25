Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C43D33B966
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787672119; cv=none; b=aFGWAmjZ6newZp8jt1mPSlIeRXod3DYReH6froh0fLmVU6OAs+XREW7Qv1hdCSDqeLihi3UOksECBSVx/ESQ6ZUTq70rpRGNt/MBycIL37S6zZcNGmayCFS01ZmEG/wFH74Eb6QYVaBkYldOBR+ckMLIDz/xxGcjWQV34o0LrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787672119; c=relaxed/simple;
	bh=A9f1oiohD6eJdjOYQPsWd31pem8l/GX+9Vbjngy4EmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pyk+tNjyHTt0YM3iieblf4P60G9K2kmEYqN9ZqbDnliufeKWr5AxTpTBWdpkkTPXAeMEIf/EulQMTUaHfytOW/OBLUc7Ksd1bZOrlNJGfQdedsf5iMQeot89RjWnl1JVO8bpaI5tE1MkRcTlhNNGTDuKDRojAcg+pEKIkn3HY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5hvsf7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5hvsf7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1F01F000E9;
	Tue, 25 Aug 2026 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787672118;
	bh=BR7ggH5eylBQ9Pzoul9geaPSZFpnF9jE/tPJ1nvagc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5hvsf7LrfVZ2O9D/YgM7zOkK8O/fAik66YJkevhPblxjP9WQiF3rSH/nEn6OaIhS
	 KzZcphNBXBxBfiK8RxBfX+kzQCXhB+fv2hRRDbgLC5I+3V8wB/eoMkcCV1s9+SaAZ/
	 TOb8gPLT0BP1ni2s6AAp09ueBI6JSR3dhoqNEagA/XuG78ryk24xnUhtk2HVv3B6/z
	 wVjeo/cS7jGGd9sPpGaAUEiE8TdzjczPWsMvkis5rfCkEKN3gRhimiz1b19nH9FOWs
	 5Ero9scCKMktK+3P0p5idzqQEUYB0EUtwBOexwFA576EzzOl9yWfa83WaY8qw/R7oQ
	 GZS6rniYXHEag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] futex/pi: Plug private futex exec() race
Date: Tue, 25 Aug 2026 11:35:16 -0400
Message-ID: <20260825153516.4069495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082417-mule-shrunk-c989@gregkh>
References: <2026082417-mule-shrunk-c989@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@kernel.org>

[ Upstream commit c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc ]

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
[ Dropped the comment-only kernel/futex/pi.c hunk and kept 6.18's lockless `futex_state` store, adapting `fs/exec.c` to the inline `old_mm` teardown. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c             |  7 ++++--
 include/linux/futex.h |  2 ++
 kernel/futex/core.c   | 54 +++++++++++++++++++++++++++++--------------
 3 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6eb1c8da2c7db..1af621c8a6039 100644
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
@@ -851,6 +852,7 @@ static int exec_mmap(struct mm_struct *mm)
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
+	/* Clean up futexes and release the mm */
 	exec_mm_release(tsk, old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
@@ -899,9 +901,10 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop_lazy_tlb(active_mm);
+	futex_exec_done(tsk);
 	return 0;
 }
 
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f049805..e93f2be22779f 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+void futex_exec_done(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -98,6 +99,7 @@ static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index fde558fd2bd60..539b816610673 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1505,13 +1505,13 @@ static void futex_cleanup_begin(struct task_struct *tsk)
 	raw_spin_unlock_irq(&tsk->pi_lock);
 }
 
-static void futex_cleanup_end(struct task_struct *tsk, int state)
+static void futex_cleanup_end(struct task_struct *tsk)
 {
 	/*
 	 * Lockless store. The only side effect is that an observer might
 	 * take another loop until it becomes visible.
 	 */
-	tsk->futex_state = state;
+	tsk->futex_state = FUTEX_STATE_DEAD;
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
 	 * FUTEX_STATE_EXITING to reevaluate the state.
@@ -1519,29 +1519,49 @@ static void futex_cleanup_end(struct task_struct *tsk, int state)
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
-- 
2.53.0

