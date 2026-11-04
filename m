Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836011;
	b=zRvHo6X7xA4ZvDCvREc6FdV0u+nhbOUsRrVbjN+/G/lVPE79DoxHyIDS/d7m7D/GkKiA
	 +ULe+KBcI8rj2UxL2/0e5+6kTUXOpU1m2Gjb+xDWR+pY8oQFUffW318uxLdDxRnu/Qt93
	 +rA/8+UK/QMzTL1fw2hEM1aJZPEzHw7at0TH10/HCofBnLI2mlo+zHfuYWrKFbNOX+VHV
	 Evl2jYiq74cnaWwMn2zTry+ac5krmnC/bZTmyjrhTpBHqLyKiB9XrTO/msIu3+dbPX+vr
	 yKhd9EI2iFvyaSSgHuxO2yZ0rQ8u98TwTUMxsQF2IUSiXieWTulskphfnua1EQ3qR4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=59z3hyIrDVF05gcn5ObtBN19eD0iiIezfodWuj5Z1Cw=;
	b=qbjRq237LVTWgt0CcqbfwjTgTO8O7hgeGfbY4JTU3PHnTWPXKfaPHKLTXn3UMPBhPRgf
	 HGAQT3IyoEMC4oSt/1XY4ty4tf9PsCekTDRWcyVmPY5tfWi7Q3RcFXnAxC4RB/rkS1Ufp
	 dmaOnj5t+LUbd9Cwo989BFUYYMT9ZKK59wbcaH+5irwiEj+x5NfAwM3k4Y84LA9b1uvkD
	 MD7aVruvbqJ+1jsVLZlcGoEiPFY5tOYxGPFouV8wfdJIG7A/u7gTSPz/4LP5JxscCRjOB
	 xqLhbtds9F8xleeoTq4TCvvnTkmV5BxlBI8DlQLnW6QCqK1UeoCeNFQsdnBrRp3t38w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjnR0HmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F433606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjnR0HmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5710C1F000C1;
	Wed,  4 Nov 2026 23:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836002;
	bh=59z3hyIrDVF05gcn5ObtBN19eD0iiIezfodWuj5Z1Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gjnR0HmTsw2jvOHBGSJ/nbxYW43qLYExLYNVnH/4T3X6q8SjT1ymxIY01eFMjPocv
	 S65Cdjjlb/TTRMQQA/knN7TuUS6xwrbgdgDsv2eRz3E0hsaIbBcPhEOrwC8hD2pbId
	 3YkkDQGAG2W3BvUNonv8Nbl6J5Z6Cmw9AMkQRUGcCfMJUqfl6BHE94nQo+D+QodJZz
	 XoKZW9FIDrMeP+yPsPiOoAxUYS49//hjnzwi7L+bsGMut2JW0XsSuUI9fRpJzIOPyg
	 u2eoYJN+4m6p833H4wP/bTSJJugiP7jjA3ZuPjVb9KlE16J0AKHwcYXshxE4v/2ad1
	 rN5VYt+7zC9kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Patel <ripatel@wii.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
Date: Wed,  4 Nov 2026 18:46:41 -0500
Message-ID: <20261104234540.889354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110452-king-quizzical-51bf@gregkh>
References: <2026110452-king-quizzical-51bf@gregkh>
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
[ sashal: Replaced kthread_stop_put() with separate kthread_stop() and put_task_struct() calls. ]
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
index ce0433446a8ed..87f8ed44ca870 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/wait_bit.h>
 
 #include "internals.h"
 
@@ -1224,17 +1225,14 @@ static void wake_threads_waitq(struct irq_desc *desc)
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
 
@@ -1251,6 +1249,14 @@ static void irq_thread_dtor(struct callback_head *unused)
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
@@ -1307,6 +1313,7 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
+	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
@@ -1331,6 +1338,7 @@ static int irq_thread(void *data)
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel_func(current, irq_thread_dtor);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	return 0;
 }
 
@@ -1867,6 +1875,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
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
@@ -1971,12 +1986,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
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

