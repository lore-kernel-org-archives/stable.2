Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78B516174
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683649; cv=none; b=AUwWC1lYJSpyagzQXumYkqXwJ+etGNPP5/f7wykf5VNYb/SC9fubIkKC2cAisKQkoHUB3jXyd6xlbYpwzYt78vKSvcD6A4p9UOkolcyNWm8D1LSuRpj4CzkM5Ulkm+Wyc+ZsK6LJxqBvm9HNhzY8BwHwKg7YJ1h9Xu8WoobBTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683649; c=relaxed/simple;
	bh=8Fbgncz6pzOgqeRGy/w0qkHD9V+khW4l7qB6o6J/PMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7bUcyZetqRV5wx/OyMsVXMy/YecdE2DwEoKZ8TbZ7IKiRx8nsquLU/Kp9G4id260WlQqPk58gjoybA7uhjq0G7x5qw/nuCBN8sVc5NdwH5jzzBI0uslRqGtNZeLIj91CU7dE51bQwP92zAhavyXEf7rWZ5AIGmpqAy0bbQPK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ2KeIxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ2KeIxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80531F000FF;
	Tue, 29 Sep 2026 12:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683647;
	bh=cYqz1P7p0/Sip9d0ujfeiak6tWFyn1VrBvWQzIwJMxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQ2KeIxhDIvgXZw5PUYHrwaBusaF6KgYQU6AhtrPijifxsOTJGsAD0ecrTdN6tU3f
	 GLEDmiewIrtaXQg/npsECj5nUI9AAgYJmHW2w23PCBOXQFpe+nQqPwXIHmx3xbUbrH
	 KjNcYcTkMKXxG1PVbd4Yxmpv3myC0uRYH06+ETQTYzC+O7JEQIjN6xyI1F72RLAqyf
	 cHcjPenBHrMxWEtqInLgJbspn0WXTQ0M5QCj9fmdu0vdoUxEBcAc4g+yzVPlhUhPJU
	 FjNEn2qTcQQcGCSWiUp/T7yVHLMyat830ipA5a9Sf7MgtPFgngCqkR7iJv3aXe1Qt6
	 gdfSk5ZxMmpRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karol Wachowski <karol.wachowski@linux.intel.com>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] accel/ivpu: Use threaded IRQ for IPC callback processing
Date: Tue, 29 Sep 2026 08:07:24 -0400
Message-ID: <20260929120725.3279868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092954-atlantic-improve-65a1@gregkh>
References: <2026092954-atlantic-improve-65a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Wachowski <karol.wachowski@linux.intel.com>

[ Upstream commit 85c9cc2d25f80534c1623621264018a655869cb2 ]

Dispatching IPC callbacks from system_percpu_wq adds scheduling latency
that is neither bounded nor predictable, which hurts job completion
turnaround. Handle them from a threaded IRQ instead: the hard-IRQ
handler drains the IPC FIFO and wakes the thread, which runs the
callback consumers such as job-done processing.

Job resource teardown can trigger IOMMU unmapping and context teardown,
which is too slow to run from the IRQ thread. Defer it to a dedicated
WQ_UNBOUND | WQ_MEM_RECLAIM workqueue via a per-device lockless list.
UNBOUND keeps the long-running cleanup off the percpu workers and
MEM_RECLAIM guarantees forward progress because the work frees buffer
objects. The runtime PM reference taken at submission is released only
after cleanup completes, otherwise runtime suspend could race the
pending work and deadlock.

Because cleanup is now asynchronous, userspace that rapidly recycles
file descriptors or command queues can momentarily observe stale
per-context resources and fail with -EMFILE or -EBUSY. Flush the
cleanup work once and retry before giving up.

Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260611055201.948726-1-karol.wachowski@linux.intel.com
Stable-dep-of: 72b782097e53 ("accel/ivpu: Use separate flag for job timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 28 ++++++++++++++---
 drivers/accel/ivpu/ivpu_drv.h |  5 ++-
 drivers/accel/ivpu/ivpu_hw.c  |  4 +++
 drivers/accel/ivpu/ivpu_ipc.c |  8 ++---
 drivers/accel/ivpu/ivpu_ipc.h |  2 +-
 drivers/accel/ivpu/ivpu_job.c | 59 +++++++++++++++++++++++++++++++----
 drivers/accel/ivpu/ivpu_job.h |  7 ++++-
 7 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 35e506074d5f1..6b34c52b1fba8 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -307,6 +307,11 @@ static int ivpu_open(struct drm_device *dev, struct drm_file *file)
 		return -ENODEV;
 
 	limits = ivpu_user_limits_get(vdev);
+	if (IS_ERR(limits) && PTR_ERR(limits) == -EMFILE) {
+		/* Context limit may be held by jobs pending deferred cleanup */
+		flush_work(&vdev->job_destroy_work);
+		limits = ivpu_user_limits_get(vdev);
+	}
 	if (IS_ERR(limits)) {
 		ret = PTR_ERR(limits);
 		goto err_dev_exit;
@@ -510,9 +515,9 @@ void ivpu_prepare_for_reset(struct ivpu_device *vdev)
 {
 	ivpu_hw_irq_disable(vdev);
 	disable_irq(vdev->irq);
-	flush_work(&vdev->irq_ipc_work);
 	flush_work(&vdev->irq_dct_work);
 	flush_work(&vdev->context_abort_work);
+	flush_work(&vdev->job_destroy_work);
 	ivpu_ipc_disable(vdev);
 	ivpu_mmu_disable(vdev);
 }
@@ -584,6 +589,11 @@ static const struct drm_driver driver = {
 	.major = 1,
 };
 
+static void ivpu_destroy_workqueue(void *wq)
+{
+	destroy_workqueue(wq);
+}
+
 static int ivpu_irq_init(struct ivpu_device *vdev)
 {
 	struct pci_dev *pdev = to_pci_dev(vdev->drm.dev);
@@ -595,16 +605,26 @@ static int ivpu_irq_init(struct ivpu_device *vdev)
 		return ret;
 	}
 
-	INIT_WORK(&vdev->irq_ipc_work, ivpu_ipc_irq_work_fn);
 	INIT_WORK(&vdev->irq_dct_work, ivpu_pm_irq_dct_work_fn);
 	INIT_WORK(&vdev->context_abort_work, ivpu_context_abort_work_fn);
+	init_llist_head(&vdev->job_destroy_list);
+	INIT_WORK(&vdev->job_destroy_work, ivpu_job_destroy_work_fn);
+
+	vdev->job_destroy_wq = alloc_workqueue("ivpu_job_destroy", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
+	if (!vdev->job_destroy_wq)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(vdev->drm.dev, ivpu_destroy_workqueue, vdev->job_destroy_wq);
+	if (ret)
+		return ret;
 
 	ivpu_irq_handlers_init(vdev);
 
 	vdev->irq = pci_irq_vector(pdev, 0);
 
-	ret = devm_request_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
-			       IRQF_NO_AUTOEN, DRIVER_NAME, vdev);
+	ret = devm_request_threaded_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
+					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN | IRQF_ONESHOT,
+					DRIVER_NAME, vdev);
 	if (ret)
 		ivpu_err(vdev, "Failed to request an IRQ %d\n", ret);
 
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 9eefbbb7ba118..86d7c9966cacb 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -13,6 +13,7 @@
 #include <drm/drm_print.h>
 
 #include <linux/hashtable.h>
+#include <linux/llist.h>
 #include <linux/pci.h>
 #include <linux/xarray.h>
 #include <uapi/drm/ivpu_accel.h>
@@ -157,9 +158,11 @@ struct ivpu_device {
 	struct xa_limit db_limit;
 	u32 db_next;
 
-	struct work_struct irq_ipc_work;
 	struct work_struct irq_dct_work;
 	struct work_struct context_abort_work;
+	struct llist_head job_destroy_list;
+	struct work_struct job_destroy_work;
+	struct workqueue_struct *job_destroy_wq;
 
 	struct mutex bo_list_lock; /* Protects bo_list */
 	struct list_head bo_list;
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index d4a9bcda4100f..647dc045c231a 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -399,6 +399,10 @@ irqreturn_t ivpu_hw_irq_handler(int irq, void *ptr)
 		return IRQ_NONE;
 
 	pm_runtime_mark_last_busy(vdev->drm.dev);
+
+	if (ip_handled)
+		return IRQ_WAKE_THREAD;
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 8f69fb133e2e9..459e740873abb 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -463,13 +463,11 @@ void ivpu_ipc_irq_handler(struct ivpu_device *vdev)
 			ivpu_ipc_rx_mark_free(vdev, ipc_hdr, jsm_msg);
 		}
 	}
-
-	queue_work(system_percpu_wq, &vdev->irq_ipc_work);
 }
 
-void ivpu_ipc_irq_work_fn(struct work_struct *work)
+irqreturn_t ivpu_ipc_irq_thread_handler(int irq, void *ptr)
 {
-	struct ivpu_device *vdev = container_of(work, struct ivpu_device, irq_ipc_work);
+	struct ivpu_device *vdev = ptr;
 	struct ivpu_ipc_info *ipc = vdev->ipc;
 	struct ivpu_ipc_rx_msg *rx_msg, *r;
 	struct list_head cb_msg_list;
@@ -484,6 +482,8 @@ void ivpu_ipc_irq_work_fn(struct work_struct *work)
 		rx_msg->callback(vdev, rx_msg->ipc_hdr, rx_msg->jsm_msg);
 		ivpu_ipc_rx_msg_del(vdev, rx_msg);
 	}
+
+	return IRQ_HANDLED;
 }
 
 int ivpu_ipc_init(struct ivpu_device *vdev)
diff --git a/drivers/accel/ivpu/ivpu_ipc.h b/drivers/accel/ivpu/ivpu_ipc.h
index b524a1985b9de..1c9cf67f1e5bd 100644
--- a/drivers/accel/ivpu/ivpu_ipc.h
+++ b/drivers/accel/ivpu/ivpu_ipc.h
@@ -90,7 +90,7 @@ void ivpu_ipc_disable(struct ivpu_device *vdev);
 void ivpu_ipc_reset(struct ivpu_device *vdev);
 
 void ivpu_ipc_irq_handler(struct ivpu_device *vdev);
-void ivpu_ipc_irq_work_fn(struct work_struct *work);
+irqreturn_t ivpu_ipc_irq_thread_handler(int irq, void *ptr);
 
 void ivpu_ipc_consumer_add(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
 			   u32 channel, ivpu_ipc_rx_callback_t callback);
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index b24f31a8b5672..ebb2c865b09a0 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -535,6 +535,20 @@ static void ivpu_job_destroy(struct ivpu_job *job)
 	kfree(job);
 }
 
+void ivpu_job_destroy_work_fn(struct work_struct *work)
+{
+	struct ivpu_device *vdev = container_of(work, struct ivpu_device, job_destroy_work);
+	struct ivpu_job *job, *tmp;
+	struct llist_node *list;
+
+	list = llist_del_all(&vdev->job_destroy_list);
+
+	llist_for_each_entry_safe(job, tmp, list, destroy_node) {
+		ivpu_job_destroy(job);
+		ivpu_rpm_put(vdev);
+	}
+}
+
 static struct ivpu_job *
 ivpu_job_create(struct ivpu_file_priv *file_priv, u32 engine_idx, u32 bo_count)
 {
@@ -619,7 +633,7 @@ bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_
 	return false;
 }
 
-static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
+static struct ivpu_job *ivpu_job_signal(struct ivpu_device *vdev, u32 job_id, u32 job_status)
 {
 	struct ivpu_job *job;
 
@@ -627,7 +641,7 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 
 	job = xa_load(&vdev->submitted_jobs_xa, job_id);
 	if (!job)
-		return -ENOENT;
+		return NULL;
 
 	ivpu_job_remove_from_submitted_jobs(vdev, job_id);
 
@@ -646,14 +660,37 @@ static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32
 		 job->job_id, job->file_priv->ctx.id, job->cmdq_id, job->engine_idx,
 		 job->job_status);
 
-	ivpu_job_destroy(job);
 	ivpu_stop_job_timeout_detection(vdev);
 
-	ivpu_rpm_put(vdev);
-
 	if (!xa_empty(&vdev->submitted_jobs_xa))
 		ivpu_start_job_timeout_detection(vdev);
 
+	return job;
+}
+
+static int ivpu_job_signal_and_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
+{
+	struct ivpu_job *job = ivpu_job_signal(vdev, job_id, job_status);
+
+	if (!job)
+		return -ENOENT;
+
+	ivpu_job_destroy(job);
+	ivpu_rpm_put(vdev);
+
+	return 0;
+}
+
+static int ivpu_job_signal_and_defer_destroy(struct ivpu_device *vdev, u32 job_id, u32 job_status)
+{
+	struct ivpu_job *job = ivpu_job_signal(vdev, job_id, job_status);
+
+	if (!job)
+		return -ENOENT;
+
+	llist_add(&job->destroy_node, &vdev->job_destroy_list);
+	queue_work(vdev->job_destroy_wq, &vdev->job_destroy_work);
+
 	return 0;
 }
 
@@ -689,6 +726,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
 	struct ivpu_file_priv *file_priv = job->file_priv;
 	struct ivpu_device *vdev = job->vdev;
 	struct ivpu_cmdq *cmdq;
+	bool flushed = false;
 	bool is_first_job;
 	int ret;
 
@@ -696,6 +734,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
 	if (ret < 0)
 		return ret;
 
+retry:
 	mutex_lock(&vdev->submitted_jobs_lock);
 	mutex_lock(&file_priv->lock);
 
@@ -709,6 +748,14 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
 	}
 
 	ret = ivpu_cmdq_register(file_priv, cmdq);
+	if (ret == -EBUSY && !flushed) {
+		/* Doorbell may be held by jobs pending deferred cleanup */
+		mutex_unlock(&file_priv->lock);
+		mutex_unlock(&vdev->submitted_jobs_lock);
+		flush_work(&vdev->job_destroy_work);
+		flushed = true;
+		goto retry;
+	}
 	if (ret) {
 		ivpu_err(vdev, "Failed to register command queue: %d\n", ret);
 		goto err_unlock;
@@ -1101,7 +1148,7 @@ ivpu_job_done_callback(struct ivpu_device *vdev, struct ivpu_ipc_hdr *ipc_hdr,
 	mutex_lock(&vdev->submitted_jobs_lock);
 	if (!ivpu_job_handle_engine_error(vdev, payload->job_id, payload->job_status))
 		/* No engine error, complete the job normally */
-		ivpu_job_signal_and_destroy(vdev, payload->job_id, payload->job_status);
+		ivpu_job_signal_and_defer_destroy(vdev, payload->job_id, payload->job_status);
 	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index 3ab61e6a5616c..d8dbce82447a1 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -6,8 +6,10 @@
 #ifndef __IVPU_JOB_H__
 #define __IVPU_JOB_H__
 
-#include <linux/kref.h>
 #include <linux/idr.h>
+#include <linux/kref.h>
+#include <linux/llist.h>
+#include <linux/workqueue.h>
 
 #include "ivpu_gem.h"
 
@@ -47,6 +49,7 @@ struct ivpu_cmdq {
  * @vdev:                Pointer to the VPU device
  * @file_priv:           The client context that submitted this job
  * @done_fence:          Fence signaled when job completes
+ * @destroy_node:        List node for deferred resource cleanup after job completion
  * @cmd_buf_vpu_addr:    VPU address of the command buffer for this job
  * @cmdq_id:             Command queue ID used for submission
  * @job_id:              Unique job ID for tracking and status reporting
@@ -61,6 +64,7 @@ struct ivpu_job {
 	struct ivpu_device *vdev;
 	struct ivpu_file_priv *file_priv;
 	struct dma_fence *done_fence;
+	struct llist_node destroy_node;
 	u64 cmd_buf_vpu_addr;
 	u32 cmdq_id;
 	u32 job_id;
@@ -87,6 +91,7 @@ void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
 void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
 bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_status);
 void ivpu_context_abort_work_fn(struct work_struct *work);
+void ivpu_job_destroy_work_fn(struct work_struct *work);
 
 void ivpu_jobs_abort_all(struct ivpu_device *vdev);
 
-- 
2.53.0

