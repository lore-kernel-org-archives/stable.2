Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840067;
	b=vIzSsUM8pkpSOi6vzCEMdmwooaB9VZBdwCYtAmFStFBUidlg00DWZIgyrSsh7jnN5bB+
	 /BxqywpeK66B/b2z3W5cOozHo+oWcizrOWYZrAceN56/lkbaMbUUtMPSfM6GFNYgXC4LS
	 Sz7q6HIhNhiuNPz+crz8/ayZSPvfRSdtR88vhwcPDlB7rx/M6QDh+85VuG3Djo3nDNkRA
	 iV2OT9TOluwnLY82zx8npqV41cGRLBPTvaghNij4Ae6GxG9UF28xqlAABgOXZCDsG2bS9
	 312rztDh7LbQ8Juz/VWufFSMAQa42SX1tLQrCNRIyD/P6QAY4gHghN3dXFZSseqIBhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840067;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jxtFLxycrXqdqb4It2TVHczAL3LOoDH9peGLfOsz91g=;
	b=KVb3FgekP6v4DTOFQ09aH+51iswyIXHgYoL/0AD+cOI6+9ivNsWf8t7vNITqjF2GYPQF
	 1ritnNdNLuOe/zGagh7qwTm4DKJwM1hgzBgYG2sH2Hkm9uO0GvtuP8rcNJUZvoiC7HNHC
	 m8meEPswPaINhzhsWv9Iz3tRYthD03zLXnuO4jmvaVQnSpOzOuYNBhyrUEAC34s5oAXcT
	 9v2+yCE4LKN/KYSF8IoRhcUgwwnztXeOj0ifSE837Tb5iQC4GizNJKQwpVMmn0I8mx/Nt
	 9gXiPKs135nU6tq7iLVlLkzBvZb9S9GLtBfHrDVnWnZd7uIDXG7n0HVk+m7xPPCQtpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aO0onwG/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6369606A338
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aO0onwG/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6D31F000C1;
	Thu,  5 Nov 2026 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840059;
	bh=jxtFLxycrXqdqb4It2TVHczAL3LOoDH9peGLfOsz91g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aO0onwG/peN3OwZuaYa+OCoWPI30s3n+se8Ap/Adosk8Ni8hrRaz9q1r5lFw+OdDQ
	 SY62USXAFF2aQ55wKf9vqPmg0k13oSTDYVVjHe2529XNci32gHbvx9cJGyXvyRKWJM
	 4GPr8GDAkS5GHcZxaYBylI9HdTuelV9kzl9OF1/dKQIuRVafTfdoRVlqjX2lt8Fseb
	 QlqDsCaoSRDtzyBt3s/vi+VCAf02QyU0eoKhTI9lsYpEiT2gqJGtxDt3YiuGU0D29q
	 XYLwsqohb2miruEkGi5ysUs6yADt2yUKLwli6Wr7I0e6zKGV+98b9/d6wQqtgfKYWD
	 fTOgnAAZxIV6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Patel <ripatel@wii.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
Date: Wed,  4 Nov 2026 19:54:17 -0500
Message-ID: <20261105005353.978441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110453-reactive-cytoplasm-f801@gregkh>
References: <2026110453-reactive-cytoplasm-f801@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Patel <ripatel@wii.dev>

[ Upstream commit d04adff6860587e843948b0c31174f8ae11b8dfe ]

When an interrupt thread exits abnormally via do_exit() (e.g. the interrupt
handler oopses) without returning from irq_thread(), a concurrent call to
free_irq() could free the irqaction before the irq_thread_dtor() exit task
work runs.

  irq thread (oopsed)                 free_irq()
  -------------------                 ----------
  do_exit()
    exit_mm()
      complete_vfork_done()  -------> kthread_stop() returns
    exit_files() ...                  kfree(action)
    exit_task_work()
      irq_thread_dtor()
        action->...                   <- use-after-free

Track the pending exit work with the IRQTF_EXIT_WORK thread flag, and have
__free_irq() wait for the bit to clear before kfree().

irq_thread_dtor() only runs on irq_thread abnormal exit. If that dtor also
faults, free_irq() will hang indefinitely, but double IRQ thread faults
require a reboot anyways.

[ tglx: Add missing include ]

Fixes: ed3e694d78cc ("move exit_task_work() past exit_files() et.al.")
Signed-off-by: Richard Patel <ripatel@wii.dev>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261009145842.1616117-2-ripatel@wii.dev
[ sashal: replaced kthread_stop_put() with separate kthread_stop() and put_task_struct() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index da1f282d5a1d1..e9531706a91ae 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -30,6 +30,7 @@ extern struct irqaction chained_action;
  * IRQTF_AFFINITY  - irq thread is requested to adjust affinity
  * IRQTF_FORCED_THREAD  - irq action is force threaded
  * IRQTF_READY     - signals that irq thread is ready
+ * IRQTF_EXIT_WORK - irq thread exit task_work is pending
  */
 enum {
 	IRQTF_RUNTHREAD,
@@ -37,6 +38,7 @@ enum {
 	IRQTF_AFFINITY,
 	IRQTF_FORCED_THREAD,
 	IRQTF_READY,
+	IRQTF_EXIT_WORK,
 };
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4998e8a561564..bcd5780b2f513 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/wait_bit.h>
 
 #include "internals.h"
 
@@ -1225,17 +1226,14 @@ static void wake_threads_waitq(struct irq_desc *desc)
 		wake_up(&desc->wait_for_threads);
 }
 
-static void irq_thread_dtor(struct callback_head *unused)
+static void __irq_thread_dtor(struct irqaction *action)
 {
 	struct task_struct *tsk = current;
 	struct irq_desc *desc;
-	struct irqaction *action;
 
 	if (WARN_ON_ONCE(!(current->flags & PF_EXITING)))
 		return;
 
-	action = kthread_data(tsk);
-
 	pr_err("exiting task \"%s\" (%d) is an active IRQ thread (irq %d)\n",
 	       tsk->comm, tsk->pid, action->irq);
 
@@ -1252,6 +1250,14 @@ static void irq_thread_dtor(struct callback_head *unused)
 	irq_finalize_oneshot(desc, action);
 }
 
+static void irq_thread_dtor(struct callback_head *unused)
+{
+	struct irqaction *action = kthread_data(current);
+
+	__irq_thread_dtor(action);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
+}
+
 static void irq_wake_secondary(struct irq_desc *desc, struct irqaction *action)
 {
 	struct irqaction *secondary = action->secondary;
@@ -1308,6 +1314,7 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
+	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
@@ -1332,6 +1339,7 @@ static int irq_thread(void *data)
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel_func(current, irq_thread_dtor);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	return 0;
 }
 
@@ -1863,6 +1871,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	return ret;
 }
 
+static void irq_stop_thread(struct irqaction *action)
+{
+	kthread_stop(action->thread);
+	put_task_struct(action->thread);
+	wait_on_bit(&action->thread_flags, IRQTF_EXIT_WORK, TASK_UNINTERRUPTIBLE);
+}
+
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1967,12 +1982,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * the same bit to a newly requested action.
 	 */
 	if (action->thread) {
-		kthread_stop(action->thread);
-		put_task_struct(action->thread);
-		if (action->secondary && action->secondary->thread) {
-			kthread_stop(action->secondary->thread);
-			put_task_struct(action->secondary->thread);
-		}
+		irq_stop_thread(action);
+		if (action->secondary && action->secondary->thread)
+			irq_stop_thread(action->secondary);
 	}
 
 	/* Last action releases resources */
-- 
2.53.0

