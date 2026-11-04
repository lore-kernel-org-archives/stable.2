Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801769;
	b=m3XoRLbQ23hYHT0cYrWn7FyjzOJEiVKSQq1ZYHJbyxQe58o8VJPS5f3ZhglnnJJI//mh
	 jg6c0whksVKhks4jkvZX0Lovg379QqFBuNYEKT5qulyeLoZzp7O/Tm+1RkCJ/zn8KWpEs
	 skBxEXyk7MkEwr8yFi+FnDGyjx6SokDlphop9mmHMyfx9Gh/6OHIBYBKCt7ht82jAPXTC
	 l8N/NYwU8MWIIq7XJbWm0hr1FMYKaE+1hFWJsb8vf6P5bK9opjpq7VQ6Y6Vf3ZSPcwa2O
	 jFnzDzISbka55M67Xg0urvcOpcZi71N+Z9/8Q+u3H8ibfaNDKGXfCCnyniYiHtYP/SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801769;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Fn7JvIBkevh5+OL9t0pwI1m6sS6qIqSZsaHbyJrbqAs=;
	b=TNbkJbzLyuvQaYCmLDZmQ1odvOs29F54jcQQiHLWwD2YzWE4GWvoYmtszq3gal0MofYO
	 uj3j+lk7nUVbpqUflvZpShZdpioCq7fGLz5XQ4oo3Tk07ZLkDjRKcINteZSVeHRefrGDf
	 44PLd0qaNkRlbBqBQizw8TMhLD3BTXqaUOz26nd5o+yBEoEbqxbjDQWnQN+DOIFI+8bWi
	 FWgZnD/iRWBrNnpCyOOGCt+mY7LY1iavtU+2+AEF5Y6l0IKsLslJL/ojFk2ODSDkSA+yE
	 l3TFCqL0hT6UwVwFstnMyhTNJg/jieDQ9LmMzzl529zK7Sz+/ktehtmWXdqCpIo9dGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ipYfsnRT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEF606EE8D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ipYfsnRT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BE61F00919;
	Wed,  4 Nov 2026 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801763;
	bh=Fn7JvIBkevh5+OL9t0pwI1m6sS6qIqSZsaHbyJrbqAs=;
	h=Subject:To:Cc:From:Date;
	b=ipYfsnRTqxiSTJ7RpNxTVL2rd1NXEsO2Bl4pYaBM0MXXi5fvuI2m6y2E5JW2jmD1W
	 5QSDJAdMe5bCwRPOwq3SheW9dQIXXn+07zy+pBXBvcm4jIZBXCeTxgtoHqqTLLfzet
	 czrzmmVEQcT0IHPQUisAp1r8t6y353ev3NOSxJh8=
Subject: FAILED: patch "[PATCH] genirq: Defer kfree(irqaction) until irq_thread_dtor()" failed to apply to 5.10-stable tree
To: ripatel@wii.dev,tglx@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:15:53 +0100
Message-ID: <2026110453-reactive-cytoplasm-f801@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d04adff6860587e843948b0c31174f8ae11b8dfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110453-reactive-cytoplasm-f801@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d04adff6860587e843948b0c31174f8ae11b8dfe Mon Sep 17 00:00:00 2001
From: Richard Patel <ripatel@wii.dev>
Date: Fri, 9 Oct 2026 14:58:41 +0000
Subject: [PATCH] genirq: Defer kfree(irqaction) until irq_thread_dtor()
 finishes

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

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd45404..2c30e7537987 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -36,6 +36,7 @@ extern struct irqaction chained_action;
  * IRQTF_AFFINITY  - irq thread is requested to adjust affinity
  * IRQTF_FORCED_THREAD  - irq action is force threaded
  * IRQTF_READY     - signals that irq thread is ready
+ * IRQTF_EXIT_WORK - irq thread exit task_work is pending
  */
 enum {
 	IRQTF_RUNTHREAD,
@@ -43,6 +44,7 @@ enum {
 	IRQTF_AFFINITY,
 	IRQTF_FORCED_THREAD,
 	IRQTF_READY,
+	IRQTF_EXIT_WORK,
 };
 
 /*
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 57eff26fa646..87a2476ea259 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/wait_bit.h>
 
 #include "internals.h"
 
@@ -1176,17 +1177,14 @@ void wake_threads_waitq(struct irq_desc *desc)
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
 
@@ -1203,6 +1201,14 @@ static void irq_thread_dtor(struct callback_head *unused)
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
@@ -1263,6 +1269,7 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
+	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
@@ -1283,6 +1290,7 @@ static int irq_thread(void *data)
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel_func(current, irq_thread_dtor);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	return 0;
 }
 
@@ -1853,6 +1861,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	return ret;
 }
 
+static void irq_stop_thread(struct irqaction *action)
+{
+	kthread_stop_put(action->thread);
+	wait_on_bit(&action->thread_flags, IRQTF_EXIT_WORK, TASK_UNINTERRUPTIBLE);
+}
+
 /*
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
@@ -1958,9 +1972,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * the same bit to a newly requested action.
 	 */
 	if (action->thread) {
-		kthread_stop_put(action->thread);
+		irq_stop_thread(action);
 		if (action->secondary && action->secondary->thread)
-			kthread_stop_put(action->secondary->thread);
+			irq_stop_thread(action->secondary);
 	}
 
 	/* Last action releases resources */

