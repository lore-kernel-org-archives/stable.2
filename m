Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747448EBC2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331995; cv=none; b=krshq+duATFjN8TYErqjQkJhFTQQqHnKq2yawL1SieSxgBEiWirvw/K+GewJaH2e1oO1zLFrxW3ggVUR/7fMiJRLtVxp4tRGk+fP416DB/Qr7Z3tTRYh8GxBUPVwjsUtJXBJYC8GoiyIBJ9lAr0gmZ1VhzsYHeMsZMjM8RSDJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331995; c=relaxed/simple;
	bh=EL6TIRiENrnIsHFHwBtOSzodwacDdqNw6UKJXY1rRqs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tSDfL/TV8uNUYSNkSfuB/VDsV1mdDu/j/Z7O0mv2vDYIWsqFzLkwf/Euhg44IamaIYreQQvRmmNBVLPD+Uy/UBTjHbg4f+t8kDZJtXhje+6/c2m03RXWStseN6GmtIZRAhib4gEEzBGvkv/htpcWrVwEZX5FEVQtkhD128q3RDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XB2PYZps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XB2PYZps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6681F000E9;
	Wed, 29 Jul 2026 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785331990;
	bh=j7P+s32qglwI6/Hu7fFV20d9/0qOwlkYHKdXI3bn6G4=;
	h=Subject:To:Cc:From:Date;
	b=XB2PYZpsLYmSVqNjqtCaLfgHgTDssCzgtQ23BOdB+3tW+4Gt3ZC8A/nEQ1n7fmJfX
	 2rILIilsxPkvffaKbqT5lHuIuQXw2WHnSnxZ6esuHXavlbBzt6ffFFuzlKSQKBgnc6
	 5AWLw7haf26MAALubukeiIPWC4sdeVHG7uML7kHU=
Subject: FAILED: patch "[PATCH] ublk: wait on ublk_dev_ready() instead of ub->completion" failed to apply to 6.18-stable tree
To: tom.leiming@gmail.com,axboe@kernel.dk,gsalisbury@apnic.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:32:57 +0200
Message-ID: <2026072957-overdue-curing-588b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 432a9b2780c0a01caf547bd1fc2fcf28aeb8d173
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072957-overdue-curing-588b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 432a9b2780c0a01caf547bd1fc2fcf28aeb8d173 Mon Sep 17 00:00:00 2001
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 19 Jul 2026 08:45:40 -0500
Subject: [PATCH] ublk: wait on ublk_dev_ready() instead of ub->completion

ub->completion is only re-armed by a successful START_USER_RECOVERY. If
the ublk server sends END_USER_RECOVERY without one - e.g. its START
failed with -EBUSY and the error was ignored - the wait is satisfied by
the stale completion of the previous recovery cycle, and the device is
marked LIVE and the requeue list kicked while the FETCH stream is still
running and ubq->canceling is still set. The kick redispatches a
previously requeued request, __ublk_queue_rq_common() sees ->canceling
and parks it again via __ublk_abort_rq(), and after the last FETCH
clears ->canceling nothing ever kicks the requeue list again: the
request is stranded there while holding its tag. If it is the flush
machinery's flush_rq, every subsequent fsync piles up in uninterruptible
sleep and teardown hangs on tag draining. This matches a report of a
lost PREFLUSH with ext4 on top of ublk after daemon crash recovery.

ub->completion is an edge-triggered latch used as a proxy for the level
condition "every queue has fetched all I/O commands", which can regress
(F_BATCH's UNPREP, daemon death) and whose re-arm can be skipped. Drop
it and wait on the real condition instead: the new helper
ublk_wait_dev_ready_and_lock() waits on ublk_dev_ready() via
wait_var_event_interruptible(), woken from ublk_mark_io_ready(), then
re-checks it under ub->mutex, waiting again on regression, and returns
with the mutex held and readiness guaranteed.

Readiness becomes true in the same ub->mutex critical section that
clears the last queue's ->canceling, so END_USER_RECOVERY marks the
device LIVE and kicks the requeue list strictly after ->canceling
clears. The wait stays interruptible, so a server whose daemon died can
still be signalled out. For ublk_ctrl_start_dev() this replaces the
fail-fast -EINVAL on an F_BATCH ready->UNPREP regression with waiting
until the device is ready again.

Reported-by: George Salisbury <gsalisbury@apnic.net>
Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
Link: https://patch.msgid.link/20260719134540.120269-1-tom.leiming@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c2c11f2a01e7..4ca6ec738c93 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/major.h>
 #include <linux/wait.h>
+#include <linux/wait_bit.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/swap.h>
@@ -26,7 +27,6 @@
 #include <linux/compat.h>
 #include <linux/mutex.h>
 #include <linux/writeback.h>
-#include <linux/completion.h>
 #include <linux/highmem.h>
 #include <linux/sysfs.h>
 #include <linux/miscdevice.h>
@@ -327,7 +327,6 @@ struct ublk_device {
 
 	struct ublk_params	params;
 
-	struct completion	completion;
 	u32			nr_queue_ready;
 	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
@@ -3054,12 +3053,12 @@ static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id,
 	if (ublk_dev_ready(ub)) {
 		/*
 		 * All queues ready - clear device-level canceling flag
-		 * and complete the recovery/initialization.
+		 * and wake ublk_dev_ready() waiters.
 		 */
 		mutex_lock(&ub->cancel_mutex);
 		ub->canceling = false;
 		mutex_unlock(&ub->cancel_mutex);
-		complete_all(&ub->completion);
+		wake_up_var(&ub->nr_queue_ready);
 	}
 }
 
@@ -4273,7 +4272,6 @@ static int ublk_init_queues(struct ublk_device *ub)
 			goto fail;
 	}
 
-	init_completion(&ub->completion);
 	return 0;
 
  fail:
@@ -4417,6 +4415,26 @@ static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 	return ub->ublksrv_tgid == ublksrv_pid;
 }
 
+/*
+ * Wait until all queues have fetched their I/O commands, and return with
+ * ub->mutex held and readiness guaranteed: then every queue's ->canceling
+ * is cleared. Ready may regress between wakeup and mutex_lock() (F_BATCH
+ * UNPREP, daemon death), so re-check it under the mutex and wait again.
+ */
+static int ublk_wait_dev_ready_and_lock(struct ublk_device *ub)
+{
+	while (true) {
+		if (wait_var_event_interruptible(&ub->nr_queue_ready,
+						 ublk_dev_ready(ub)))
+			return -EINTR;
+
+		mutex_lock(&ub->mutex);
+		if (ublk_dev_ready(ub))
+			return 0;
+		mutex_unlock(&ub->mutex);
+	}
+}
+
 static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		const struct ublksrv_ctrl_cmd *header)
 {
@@ -4499,15 +4517,10 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 		};
 	}
 
-	if (wait_for_completion_interruptible(&ub->completion) != 0)
+	if (ublk_wait_dev_ready_and_lock(ub))
 		return -EINTR;
 
-	if (!ublk_validate_user_pid(ub, ublksrv_pid))
-		return -EINVAL;
-
-	mutex_lock(&ub->mutex);
-	/* device may become not ready in case of F_BATCH */
-	if (!ublk_dev_ready(ub)) {
+	if (!ublk_validate_user_pid(ub, ublksrv_pid)) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
@@ -5071,7 +5084,6 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub)
 		goto out_unlock;
 	}
 	pr_devel("%s: start recovery for dev id %d\n", __func__, ub->ub_number);
-	init_completion(&ub->completion);
 	ret = 0;
  out_unlock:
 	mutex_unlock(&ub->mutex);
@@ -5087,16 +5099,17 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: Waiting for all FETCH_REQs, dev id %d...\n", __func__,
 		 header->dev_id);
 
-	if (wait_for_completion_interruptible(&ub->completion))
+	if (ublk_wait_dev_ready_and_lock(ub))
 		return -EINTR;
 
 	pr_devel("%s: All FETCH_REQs received, dev id %d\n", __func__,
 		 header->dev_id);
 
-	if (!ublk_validate_user_pid(ub, ublksrv_pid))
-		return -EINVAL;
+	if (!ublk_validate_user_pid(ub, ublksrv_pid)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
-	mutex_lock(&ub->mutex);
 	if (ublk_nosrv_should_stop_dev(ub))
 		goto out_unlock;
 

