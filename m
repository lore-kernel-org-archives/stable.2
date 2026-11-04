Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832864;
	b=5kHqz9M7j0u21ewUqOzzQw41uzfiRwe1PFBtD45Ea2SOERkEfQ3n8JHWQGq7WFHHuhL0
	 B8A4wwxcVxexMM9n/xe8QjSAgF3374E5Oolpc08+nLgFnxST7Xvm9/kMsiqSae3GZ0Vik
	 euGKhNxEZVlphkjP8TVjNKHnUKpajIC5CLnIfTNh3RtI/JN+jI232ePGqMg1xJWt2udHu
	 6klQ7dPnanrw66T8ueUOYr7Z7lYMlp9L8hKpYHPEEXDn2BsyGjhillIQyDRRRen8IpkOH
	 1s8netxZAqIATt0Obsw74v1e8faxgly2uduuBTOtUXwgHyVwon2AJrUoTkIOqg8U3tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=74FcWjy0ZHL5YPzci5eZPYO959+1gWbym1W+k8aITh0=;
	b=bNymFw8G7oquFujwTY8GN8/8RaiuAenEU39aQSCdnHjDvhK3STnlIZk/8lbLqst6QLqT
	 FDMMVq3WKRSgryG9Xtpm2hIrmAfLb0mFzkzb37+1CMUiD+j2AQtUxm4OPL2Ls8gTG95wE
	 liC+WfkdUw3YIcRHxMLWyeeDEPRloMRHXPMhnrSf6S7JFX10S0UI6qMJm40PDl49mQTUL
	 HlPlUe3igmXbeJib+oC/ONdZs9xi8ZkLLSz5Ktgi+8Lw4J/WxM3R9bh9rdttjbv9TF7Qz
	 V9PnZr5AkliMbulwag3n8STVULKxqZ8l0+BvajXnywAutXCVH97KzJSFi0dFkMqZE4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aDJw6LN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD55606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aDJw6LN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B7B1F000C1;
	Wed,  4 Nov 2026 22:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832856;
	bh=74FcWjy0ZHL5YPzci5eZPYO959+1gWbym1W+k8aITh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aDJw6LN/DwGKEMXCofyABC4qee9nxcTYSr2Kf2MTOxB/VLZRqy8ZFOBuzR+jxYxPu
	 dEUipqYsXwZWlShvlOjfVB62ahl9pvf+cKlkjB4eo9gd75VTNFdW2ikchoJADaJSCt
	 S0NR8JWtK0uM6pi/xS7XjB5Ecklxs74BUpzPjlpTjhpLDZzWsSN4QPq8Uv3DC0BXwv
	 pnq7ka2b7rpJAltz2cWpF4HjMeNBxw+A/WV9fmXqE346WFkyMwJjComSxnbTV2BUu/
	 jKWPQpNcLv1/0shATkrgWpOptlkValfeMUBSgllwjkKxCPN+PU0HeTuAaZlp6q7oFH
	 ADXTfu1eXOAbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Richard Patel <ripatel@wii.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] genirq: Defer kfree(irqaction) until irq_thread_dtor() finishes
Date: Wed,  4 Nov 2026 17:54:14 -0500
Message-ID: <20261104225336.845493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110452-liability-uncooked-f75f@gregkh>
References: <2026110452-liability-uncooked-f75f@gregkh>
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
[ sashal: Replaced unavailable kthread_stop_put() with kthread_stop() followed by put_task_struct(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 35e85323940c3..7f1b7c1534d18 100644
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
index a5843563d0154..8827e7cb7166e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/wait_bit.h>
 
 #include "internals.h"
 
@@ -1216,17 +1217,14 @@ static void wake_threads_waitq(struct irq_desc *desc)
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
 
@@ -1243,6 +1241,14 @@ static void irq_thread_dtor(struct callback_head *unused)
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
@@ -1301,6 +1307,7 @@ static int irq_thread(void *data)
 	else
 		handler_fn = irq_thread_fn;
 
+	set_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
 
@@ -1325,6 +1332,7 @@ static int irq_thread(void *data)
 	 * oneshot mask bit can be set.
 	 */
 	task_work_cancel_func(current, irq_thread_dtor);
+	clear_and_wake_up_bit(IRQTF_EXIT_WORK, &action->thread_flags);
 	return 0;
 }
 
@@ -1859,6 +1867,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
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
@@ -1963,12 +1978,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
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

