Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DD3939B1;
	Sat, 15 Aug 2026 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786833002; cv=none; b=fvLlJWe4v27t0ZTAiQGn5zjR47iAxHldDu9rxVaZyQB0tThyF1JG+sgPo1Jrr7FY8uctjL4h7R4UIOI4ECMDPmEk/FUVm9i0gNo1nlRXZUHqGC4hPG0euBJbNrmV6K7R1aKM+9eIHB3/CWWSOUKtt6xJdfNCMpdJKeN8lxSJjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786833002; c=relaxed/simple;
	bh=l6bqmyRKuO+KxIEHNwZvfYXzgnVFGQYAXEwgIomHs/w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rTiimeopgyYoNW2/iCXqFFbzDE5mrbKgiLbXv0ufva37DZ191bhhGEksvUzNKh82dLDv/8Xf+eWz1XvGXhlroFEeKrC6Rrq0/22JreRek3HFSyJYEbHstflJuWWtu7+jli2XIR6Vk0cLlCTWjqvy4GKugld4Y9OkudQR6PFcYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zx49jBmV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SgNxZHJC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zx49jBmV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SgNxZHJC"
Date: Sat, 15 Aug 2026 22:29:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786832992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mFVs1cupurs8OgKSTGmN7TgdQGyLqpei4xX0L2YiNUY=;
	b=zx49jBmVFXpicCNUagMg+vLDO8gbD2nqd7MH3xkiDf+H720F09GGkvOGVbGJJOuJ9Gorvp
	DadEwhcQEvPWIskZmcBKWQYa6hU9jn8kzYA91N+nanLIR/Zvk/hXm5PDx4z0DHrd6RalHN
	5dCkXh55ihFopReQvAVAyFxYXOh/7rOzDK9o8eSa+6YxTQbe1G/RcS0PwRBW1fPdR5F3lQ
	0DCGrGeTG9efMfe8+PyM3yTXj2H1D7lR1pTHw2/ytH5hWxchonfklmJWGgk7zDA9WyUFKC
	cNCh+s+onmc8NFDcBe/ZPnjdJ5PIRfWRq9sn+pYTw7rzWf55kgsVsXi1t5uFhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786832992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mFVs1cupurs8OgKSTGmN7TgdQGyLqpei4xX0L2YiNUY=;
	b=SgNxZHJCt2HBA0pCBLYeaj2u9JbuiShYDhq65R1790+4Gjzy4UBQt7dFUkTWIoBIEcSRcy
	u7nvAdeYZaOFxqAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex/pi: Plug private futex exec() race
Cc: Thomas Gleixner <tglx@kernel.org>, Kyle Zeng <kylebot@openai.com>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178683299049.1542179.16641252140402329150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     c5f0bc9fd1cec4a00400cc727fcde03e0fde17cc
Gitweb:        https://git.kernel.org/tip/c5f0bc9fd1cec4a00400cc727fcde03e0fd=
e17cc
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Fri, 07 Aug 2026 17:07:13 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 16 Aug 2026 00:16:31 +02:00

futex/pi: Plug private futex exec() race

The check for private futexes whether the waiter's mm, which is stored in
the futex_key and copied into the pi_state, is the same as the owner's mm
is not sufficient for exec(). exec() has a gap where the mm check fails to
give the correct answer:

  exec()
  ...
    exec_release_mm()
      futex_exec_release()
        tsk::futex::exit_state =3D EXITING;
        cleanup_robust_list();
1)      tsk::futex::exit_state =3D OK;
    ...
    old_mm =3D tsk::mm;
2)  tsk::mm =3D ->mm;

Between #1 and #2 the check for the mm is wrong as that mm is about to be
swapped out and eventually freed.

Plug this gap by:

  1) Setting tsk::futex::exit_state to FUTEX_STATE_DEAD in
     futex_exec_release()

  2) Setting tsk::futex::exit_state to FUTEX_STATE_OK after
     the mm has been switched.

>From a futex point of view the task is dead after it finished the robust
list cleanup up to the point where it sets the state to OK again.

Fixes: 80367ad01d93 ("futex: Add basic infrastructure for local task local ha=
sh")
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
---
 fs/exec.c             |  7 +++--
 include/linux/futex.h |  2 ++-
 kernel/futex/core.c   | 54 ++++++++++++++++++++++++++++--------------
 kernel/futex/pi.c     | 22 ++++++++++++-----
 4 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c7b8f2d..d01523d 100644
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
 	tsk =3D current;
 	old_mm =3D current->mm;
+	/* Clean up futexes and release the mm */
 	exec_mm_release(tsk, old_mm);
=20
 	ret =3D down_write_killable(&tsk->signal->exec_update_lock);
@@ -902,9 +904,10 @@ static int exec_mmap(struct linux_binprm *bprm)
 		BUG_ON(active_mm !=3D old_mm);
 		/* Defer teardown to setup_new_exec(), outside the exec locks. */
 		bprm->old_mm =3D old_mm;
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop_lazy_tlb(active_mm);
+	futex_exec_done(tsk);
 	return 0;
 }
=20
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 51f4ccd..51d5faa 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -73,6 +73,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+void futex_exec_done(struct task_struct *tsk);
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -91,6 +92,7 @@ static inline void futex_init_task(struct task_struct *tsk)=
 { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *tim=
eout,
 			    u32 __user *uaddr2, u32 val2, u32 val3)
 {
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 0ea2c1a..3c1562d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1524,11 +1524,11 @@ static void futex_cleanup_begin(struct task_struct *t=
sk)
 	raw_spin_unlock_irq(&tsk->pi_lock);
 }
=20
-static void futex_cleanup_end(struct task_struct *tsk, int state)
+static void futex_cleanup_end(struct task_struct *tsk)
 	__releases(&tsk->futex.exit_mutex)
 {
 	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
-		tsk->futex.state =3D state;
+		tsk->futex.state =3D FUTEX_STATE_DEAD;
=20
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
@@ -1537,29 +1537,49 @@ static void futex_cleanup_end(struct task_struct *tsk=
, int state)
 	mutex_unlock(&tsk->futex.exit_mutex);
 }
=20
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
=20
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
+	tsk->futex.state =3D FUTEX_STATE_OK;
 }
=20
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 2731e55..88788e5 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -200,15 +200,25 @@ void put_pi_state(struct futex_pi_state *pi_state)
  *
  * - FUTEX_STATE_OK when the task is alive and waiters can be attached
  *
- * - FUTEX_STATE_EXITING when the task cleans up the robust list and pi
+ * - FUTEX_STATE_EXITING when the task cleans up the robust list and PI
  *   state. Concurrent waiters cannot attach anymore and have to wait until =
the
- *   cleanup is finished to re-evaluate the potential changes of robust list=
 and
- *   pi state cleanups.
+ *   cleanup is finished to re-evaluate the potential changes caused by the
+ *   robust list and PI state cleanups.
  *
- * - FUTEX_STATE_DEAD when the task has cleaned up the robust list and
- *   is about to fully exit.
+ * - FUTEX_STATE_DEAD when the task has cleaned up the robust list. This sta=
te
+ *   is set independent of exit() or exec(). In the exit() case the task is
+ *   gone. In the exec() case this ensures that nothing can attach to the ta=
sk
+ *   after cleaning up the robust list and PI state before it has switched to
+ *   the new mm. From a futex point of view the task is dead until it sets t=
he
+ *   state to FUTEX_STATE_OK again after switching to the new mm.
  *
- * exec() switches back to FUTEX_STATE_OK after the cleanup.
+ * The valid state transitions for exit():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD
+ *
+ * The valid state transitions for exec():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD -> FUTEX_STAT=
E_OK
  *
  * The state has two related locks:
  *
