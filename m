Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611E2BFC8F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830479; cv=none; b=eO0eNbKWdHFa2biSjZUOA7qT7Zh1uN4Gd0raHHzU0jCTVsLkUU3u4TfzCsOZayEgeqvqWgRk1rIdF17mqn5zMR6f4sttQiRO3uMFHflGo1Iz6TbdyB7v8H95FEsUcUZCyjJPX1F1voKqYtecRyPo6aoZy8Za4UNHncISFxVuyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830479; c=relaxed/simple;
	bh=ef+LQOUiovXh16TT0A7UIVYSHwBR9kiSg0MxQ8T4O7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8ZmFouYiIjCk/1pvecOJye9STL1m9tD0/bwvBs+dGVYFIEptSJ5sDgkzFp6NVjbTOe227vpItboprodi+tTrwZUMWH8fc+fIKc0I6VKWL3hrSrEifnL6QmrYoIEdyoyBIJx9k1CJ82U2p/9c2PjyHn1fu+dYGvEgumzsTi1BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjWsssKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjWsssKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D61F00A3F;
	Tue,  8 Sep 2026 01:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830472;
	bh=KVxKtqSDkEvY/7Fosaeh4s0cAkB+X8kSVCmCUUlWcA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjWsssKMbb7TF7phkQv6w0gmZEitOWROTMz30sLvnYHNzbM5dYQ883PZbCoj57QOv
	 qb57iwpHKN90KhofAVYQAq/igWJCWRL8ZDXg6JCvfwuFdftRo22n6PrEhcEGsPfa0G
	 dPyyt2CKBXMWcHNp3BxlQTS7QYChME3y/HxNQc3TWoD7sbH22wAsvp0o4FC4pjdt0i
	 KkoWEMBr0J9fjFgkb/klrs5KYgOwNsND/MwbvdrKnb6+tlSDmUheRU8pw0AgoOB+S2
	 fzF5blUSHdyMgmnKmhf1jFzLUsil938ejb3CjikO5Y9UZrTvBxiCg7IrLyA53ZCytj
	 KdeEU+oLo+KmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Terry Bowman <terry.bowman@amd.com>,
	Sashiko <sashiko@linuxfoundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
Date: Mon,  7 Sep 2026 21:21:07 -0400
Message-ID: <20260908012108.1757370-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908012108.1757370-1-sashal@kernel.org>
References: <2026090335-waking-roundworm-32ca@gregkh>
 <20260908012108.1757370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit 6625ca499c3131ef63be3215f8f942d7a097ea3a ]

The CXL CPER work registration and unregistration helpers acquire
cxl_cper_work_lock and cxl_cper_prot_err_work_lock with a spinlock
guard(), which leaves local interrupts enabled. The corresponding post
paths (cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard
IRQ context (they are called from the GHES error notification path) and
acquire the same locks with an irqsave guard().

If a CPU is holding one of these locks via a spinlock guard() when a GHES
interrupt arrives on the same CPU, the IRQ handler spins on the held lock
waiting for it to release, while the lock holder is preempted by the IRQ.
The result is a deadlock.

Convert both locks from spinlock_t to raw_spinlock_t and use guard() at
all call sites. On PREEMPT_RT kernels spinlock_t is backed by rt_mutex and
sleeping from hard IRQ context is not permitted; raw_spinlock_t is safe in
both contexts.

Add WARN_ONCE to both register functions to surface double-registration
bugs at runtime.

Restructure both unregister functions to clear the global work pointer
under the lock before calling cancel_work_sync(), closing the window
where a CPER interrupt could schedule work on a pointer about to be
freed. Add kfifo_reset() after cancel_work_sync() so stale entries
are not replayed on next module load.

Both kfifos are single-consumer: only one work_struct is registered at
a time, enforced by the WARN_ONCE guard in the register functions.
kfifo_reset() is safe outside the lock because cancel_work_sync() has
already quiesced the consumer, and no new consumer can register until
the current module exit completes and a fresh module init runs.

Remove the redundant cancel_work_sync() call from cxl_ras_exit() and
cxl_pci_driver_exit(). The CPER unregister functions now quiesce
the work internally.

Reported-by: Sashiko <sashiko@linuxfoundation.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Cc: stable@vger.kernel.org
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://patch.msgid.link/20260803221810.3685703-4-terry.bowman@amd.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[ omitted protocol-error changes because the corresponding consumer infrastructure is absent in 6.12 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 24 ++++++++++++++++--------
 drivers/cxl/pci.c        |  1 -
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 25163eb9b8053..e1cbc35919cbf 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -710,7 +710,7 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
@@ -730,7 +730,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
 		return;
@@ -748,10 +748,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 int cxl_cper_register_work(struct work_struct *work)
 {
-	if (cxl_cper_work)
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
+	if (WARN_ONCE(cxl_cper_work,
+		      "CXL CPER kfifo consumer already registered\n"))
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
 	cxl_cper_work = work;
 	return 0;
 }
@@ -759,11 +760,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, CXL);
 
 int cxl_cper_unregister_work(struct work_struct *work)
 {
-	if (cxl_cper_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
+		if (WARN_ONCE(cxl_cper_work != work,
+			      "CXL CPER kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_fifo);
 
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, CXL);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 09a2bc817d645..4c307ee6cd28e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1087,7 +1087,6 @@ static int __init cxl_pci_driver_init(void)
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
-	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 
-- 
2.53.0

