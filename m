Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDC43713C
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664118; cv=none; b=cGo0DL6AMDDaTJVFTUxNfqhkSmyMDiomlSkJm476IJ7xnvTWjFaiP9qvJ1eMW9R+JnoiID1/vouL0Xxfr2XQJuI2XhCxQC9wtELEl1egtDasCVN3/xxQXc9yyDmYyULlAYX92XYw78oQOySeU3mcDJLcYobwEsIj/WJnFh8a95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664118; c=relaxed/simple;
	bh=VcG4qacWy9it67LpBkFqFGVrFb5ew6eMZQkeLSE2eKo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SgRNr4kZVhqT1YbxHBLwLTb1u0cDcZO0yi7j54WsDgPyfeOIEkU+i89MsDsIzAzfLDQXlbWuYlXSuQ//nyeGLuOoUTBQov0ICodInNNiWDHU85q4ijM3eejQygMcsfRexjLdesVEDsVwiUJiornypG0A6LilxG0cr+Qfh4eDsXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wn9foHRo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wn9foHRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876131F000FF;
	Tue, 29 Sep 2026 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664117;
	bh=pnFAjoc5neQsqZHNYtnG5EwMg1iiMP672e3c+Pu6YZc=;
	h=Subject:To:Cc:From:Date;
	b=wn9foHRoSvVcePj5LfCAYQ4481Cr4oiB5/YflI/OpRkgn8I/XGhV38LnHU4MgU1Y2
	 ezF5mqE0WFkEN10rUAY0Q1DoiNZIMXZ3h7p4dE7Mk03FxJWOioUNU9+Z1nRYraiBuC
	 wsSWxa5M0exIqvHyo4F+2FqG0QXSZLH7Nt57NkIs=
Subject: FAILED: patch "[PATCH] accel/ivpu: Use separate flag for job timeout" failed to apply to 7.2-stable tree
To: jakub.pawlak@intel.com,dawid.osuchowski@linux.intel.com,karol.wachowski@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:41:54 +0200
Message-ID: <2026092954-atlantic-improve-65a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 72b782097e534ab48152dd25aaba40dda5f25f9e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092954-atlantic-improve-65a1@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72b782097e534ab48152dd25aaba40dda5f25f9e Mon Sep 17 00:00:00 2001
From: Jakub Pawlak <jakub.pawlak@intel.com>
Date: Mon, 14 Sep 2026 10:43:01 +0200
Subject: [PATCH] accel/ivpu: Use separate flag for job timeout

Use separate flag to mark a job timeout as a reason
of starting context_abort_work. This allows to distinguish
engine reset reason and clearly adjust reset procedure flow.

The flag is cleared in ivpu_prepare_for_reset(), which every
recovery and suspend path already funnels through, so that the
state is clean after recovery.

Cc: stable@vger.kernel.org # v7.1+
Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260914084301.894028-1-karol.wachowski@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 95120957f42a..8c1c87e69f91 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -515,6 +515,7 @@ void ivpu_prepare_for_reset(struct ivpu_device *vdev)
 {
 	ivpu_hw_irq_disable(vdev);
 	disable_irq(vdev->irq);
+	atomic_set(&vdev->job_timeout_detected, 0);
 	flush_work(&vdev->irq_dct_work);
 	flush_work(&vdev->context_abort_work);
 	flush_work(&vdev->job_destroy_work);
@@ -710,7 +711,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
 	atomic64_set(&vdev->unique_id_counter, 0);
 	atomic_set(&vdev->job_timeout_counter, 0);
-	atomic_set(&vdev->faults_detected, 0);
+	atomic_set(&vdev->job_timeout_detected, 0);
 	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 86d7c9966cac..6f4012926478 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -171,7 +171,7 @@ struct ivpu_device {
 	struct xarray submitted_jobs_xa;
 	struct ivpu_ipc_consumer job_done_consumer;
 	atomic_t job_timeout_counter;
-	atomic_t faults_detected;
+	atomic_t job_timeout_detected;
 
 	atomic64_t unique_id_counter;
 
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index ebb2c865b09a..4689b8ab519d 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -621,7 +621,6 @@ bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_
 		 * status and ensure both are handled in the same way
 		 */
 		job->file_priv->has_mmu_faults = true;
-		atomic_set(&vdev->faults_detected, 1);
 		queue_work(system_percpu_wq, &vdev->context_abort_work);
 		return true;
 	}
@@ -1175,10 +1174,10 @@ static int reset_engine_and_mark_faulty_contexts(struct ivpu_device *vdev)
 		return ret;
 
 	/*
-	 * If faults are detected, ignore guilty contexts from engine reset as NPU may not be stuck
-	 * and could return currently running good context and faulty contexts are already marked
+	 * If job timeout is detected, read guilty context from engine reset, for other reasons
+	 * faulty context is already known
 	 */
-	if (atomic_cmpxchg(&vdev->faults_detected, 1, 0) == 1)
+	if (atomic_cmpxchg(&vdev->job_timeout_detected, 1, 0) == 0)
 		return 0;
 
 	num_impacted_contexts = resp.payload.engine_reset_done.num_impacted_contexts;
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 41efd8985fa6..b2025274f91d 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -964,7 +964,6 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
 		file_priv = xa_load(&vdev->context_xa, ssid);
 		if (file_priv) {
 			if (!READ_ONCE(file_priv->has_mmu_faults)) {
-				atomic_set(&vdev->faults_detected, 1);
 				ivpu_mmu_dump_event(vdev, event);
 				WRITE_ONCE(file_priv->has_mmu_faults, true);
 			}
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index c1ce8329790e..de0becbfdffb 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -229,6 +229,7 @@ static void ivpu_job_timeout_work(struct work_struct *work)
 
 	ivpu_jsm_state_dump(vdev);
 	ivpu_dev_coredump(vdev);
+	atomic_set(&vdev->job_timeout_detected, 1);
 	queue_work(system_percpu_wq, &vdev->context_abort_work);
 }
 

