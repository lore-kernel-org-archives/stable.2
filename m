Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3F519DFE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683649; cv=none; b=DCXzwMmwYU6Zw/mRdWCOce9vAIoiDWMKvlecDnWx9B/mMZkLzVCgtywVSh4+b7a3gpC+ctDsnaJK038rsn0jplnAjtF97zAQWiRGObeJU7oJ5Kp9UvxHrc5QBjbvZ5uxX3cTPp18tBhCDAmYX0VckhW1biB+hNjhiUPSZmQbHjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683649; c=relaxed/simple;
	bh=IOXuHLiasvBRDHcS6M3S9CNoUsXVm6kGOg0/JvbGGcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsVc5N7f5oI1RkrgRlKkjWHCmp75SFixIzLSr/px3IVdA0d2PpXEpTMi0HzHxTt+98eYZhSp5nQ1cJlggDC/toD+GL6XEQElhNJc4/kgckvZ/XrM+V+v4wXDqRQ/iQQ4wCi/ESR3DtncgYB3cjch+COLpwrHM5ItSc1CkJEBPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMXSW0Sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMXSW0Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862AC1F00893;
	Tue, 29 Sep 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790683648;
	bh=lehOGeQ90/BRCLsoKvYM+yveMWjrs/5DJjokPJeypfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EMXSW0SmtbA9zI5y7RHqVV0u5sAEOaYvvqbJrXkWn8giGO3sFLxevYxXDfuzwIllY
	 /G4S5j16HHvT0itYbqiw15JzYF6vrHNjKM20QhJROjXfL6mhXQXRc90p4JTzg9nOKj
	 RsA79N7h0cCKWe8XE7yU2vphAGOXgaAQfu8xgv9AvqfpTPNZXp63ny3LbjOCIEzu4B
	 sRNKecpXaHpc6EhpdUdKaW+q5UwHtaJNNDCYo7EI+IZbJdEKp2jvcFbBie4YCzfJyj
	 yzIcuosBr2hybHsL18cEKMahCyjawltPSaRDPK7CzpH6OQXG3injSmaZau8Qg1IhDx
	 Ig0znCLGmuLeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Pawlak <jakub.pawlak@intel.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] accel/ivpu: Use separate flag for job timeout
Date: Tue, 29 Sep 2026 08:07:25 -0400
Message-ID: <20260929120725.3279868-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929120725.3279868-1-sashal@kernel.org>
References: <2026092954-atlantic-improve-65a1@gregkh>
 <20260929120725.3279868-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Pawlak <jakub.pawlak@intel.com>

[ Upstream commit 72b782097e534ab48152dd25aaba40dda5f25f9e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 3 ++-
 drivers/accel/ivpu/ivpu_drv.h | 2 +-
 drivers/accel/ivpu/ivpu_job.c | 7 +++----
 drivers/accel/ivpu/ivpu_mmu.c | 1 -
 drivers/accel/ivpu/ivpu_pm.c  | 1 +
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 6b34c52b1fba8..5f90e224335fe 100644
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
index 86d7c9966cacb..6f40129264789 100644
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
index ebb2c865b09a0..4689b8ab519d7 100644
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
index 41efd8985fa67..b2025274f91de 100644
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
index c1ce8329790e0..de0becbfdffb2 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -229,6 +229,7 @@ static void ivpu_job_timeout_work(struct work_struct *work)
 
 	ivpu_jsm_state_dump(vdev);
 	ivpu_dev_coredump(vdev);
+	atomic_set(&vdev->job_timeout_detected, 1);
 	queue_work(system_percpu_wq, &vdev->context_abort_work);
 }
 
-- 
2.53.0

