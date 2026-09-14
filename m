Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173AB41167E
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375403; cv=none; b=B7H/rkxJibpLyY9fkHngICDiscoSiDywL8cxmg119H+/PVCom4x0rL2pNv8j7nw6OuJRiYGZe7X49NMd5HDB9KcbUDu1iefqOCypQGvWC3lBfrtmZRHCU9U+1D5IIrnUnOhhQSQdhaisaJWHBIZbVcz9hvzgkZvQxDan0UHLQF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375403; c=relaxed/simple;
	bh=tQphYbHekLys1TFMOQVTL+DNvLk1JrFMzVHnMEbffew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLbVQGHiwbp1QXMKmeeEQN9wDIVIV/HEilqV26JvdpY4DfCnq4OpFt3vMjhrYNDto4W2781Z1YoYbau/99AkCCRK64TSjEbtVnKEuR0mIwQSxt8rPM1HQM6+LLkqksbfkTRJGRRIGH5daQkSKg17aCayYcGZNLkosuybgzk4MNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgCUHd/1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgCUHd/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789375396; x=1820911396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQphYbHekLys1TFMOQVTL+DNvLk1JrFMzVHnMEbffew=;
  b=LgCUHd/1wVzqyeGWHE5etbThdn6Ik/vI4wolL2Z4ResO/LBwLT6peTON
   1b6CBZmw5z2V+rqU359SazpfKdL9dGO9j5/2LT7ig/1HbnSDZA1sIV30L
   eLJ96TdNfX8JX1+BnGepAjF04giQDSNgjLDCrdlp9sGguGRj+qzZwAd2B
   OCR0Nh99rUsFGtGPN0ul9MHASJ24HeNW3r4Th3Xr/TMmVooP6/5Otn6AT
   8NZKhL1eHaAX8p6gswjl2xt7Fez4WSkOt3ERisXqFZ1hUOyTFijN+2tgg
   GOwTs2h+Fx4WbKcfckiHWfPwoxWfRwfkWG4wtEPMJAVcGjo7pey3yBg0W
   Q==;
X-CSE-ConnectionGUID: cWikSlcTTRG3WEsF866d9g==
X-CSE-MsgGUID: ubkp1OWuRhWDawlm6xgj2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100319589"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100319589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:43:13 -0700
X-CSE-ConnectionGUID: 9oXiJyIzTv6FTXmBKPJ0iQ==
X-CSE-MsgGUID: XvNFQwTiQWy4f1VE7aGrEQ==
X-ExtLoop1: 1
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:43:10 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	lizhi.hou@amd.com,
	andrzej.kacprowski@linux.intel.com,
	dawid.osuchowski@linux.intel.com,
	Jakub Pawlak <jakub.pawlak@intel.com>,
	stable@vger.kernel.org,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Use separate flag for job timeout
Date: Mon, 14 Sep 2026 10:43:01 +0200
Message-ID: <20260914084301.894028-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Pawlak <jakub.pawlak@intel.com>

Use separate flag to mark a job timeout as a reason
of starting context_abort_work. This allows to distinguish
engine reset reason and clearly adjust reset procedure flow.

The flag is cleared in ivpu_prepare_for_reset(), which every
recovery and suspend path already funnels through, so that the
state is clean after recovery.

Cc: <stable@vger.kernel.org> # v7.1+
Fixes: ade00a6c903f ("accel/ivpu: Perform engine reset instead of device recovery on TDR")
Signed-off-by: Jakub Pawlak <jakub.pawlak@intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
Changes in v2:
 - add Cc: tag
 - link to v1: https://lore.kernel.org/dri-devel/20260914082800.892044-1-karol.wachowski@linux.intel.com/T/#u
---
 drivers/accel/ivpu/ivpu_drv.c | 3 ++-
 drivers/accel/ivpu/ivpu_drv.h | 2 +-
 drivers/accel/ivpu/ivpu_job.c | 7 +++----
 drivers/accel/ivpu/ivpu_mmu.c | 1 -
 drivers/accel/ivpu/ivpu_pm.c  | 1 +
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 4c73dc8b3aaf..d7faabe0f676 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -539,6 +539,7 @@ void ivpu_prepare_for_reset(struct ivpu_device *vdev)
 {
 	ivpu_hw_irq_disable(vdev);
 	disable_irq(vdev->irq);
+	atomic_set(&vdev->job_timeout_detected, 0);
 	flush_work(&vdev->irq_dct_work);
 	flush_work(&vdev->context_abort_work);
 	flush_work(&vdev->job_destroy_work);
@@ -734,7 +735,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
 	atomic64_set(&vdev->unique_id_counter, 0);
 	atomic_set(&vdev->job_timeout_counter, 0);
-	atomic_set(&vdev->faults_detected, 0);
+	atomic_set(&vdev->job_timeout_detected, 0);
 	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 3b26a64ed04f..8762b8969d96 100644
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
index 51d573ac4da8..245512bab523 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -626,7 +626,6 @@ bool ivpu_job_handle_engine_error(struct ivpu_device *vdev, u32 job_id, u32 job_
 		 * status and ensure both are handled in the same way
 		 */
 		job->file_priv->has_mmu_faults = true;
-		atomic_set(&vdev->faults_detected, 1);
 		queue_work(system_percpu_wq, &vdev->context_abort_work);
 		return true;
 	}
@@ -1271,10 +1270,10 @@ static int reset_engine_and_mark_faulty_contexts(struct ivpu_device *vdev)
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
index 1908375ff128..c846499d96ce 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -960,7 +960,6 @@ void ivpu_mmu_irq_evtq_handler(struct ivpu_device *vdev)
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
 
-- 
2.43.0

