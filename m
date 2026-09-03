Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611414B1B4C
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444345; cv=none; b=f5gGb6Vr9PQ6GLWGHfZWD9U6Zx3jCW1vKmtjmbrj64/bLe5JguVUqv1aQrA6Y5W4zYvM5C4GtfBYap28smFljI/50DKwobMXLSgCORw3upsMhmXYGTnQf/OW/VOdKDL70PhnvBmbdICrdUp1gt+ZkKunIn6rNEJOgpzlyYnIgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444345; c=relaxed/simple;
	bh=syCq3GDaYwJnxRC3xQqms1YrBvQCeMqNBVTLEh9Y0IY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FE/T8a+0d42bxmDSAh/UbZ6fEq9nIOE9d5Icuk1SIO8w31npVU/d7nkVvKsKshwP4UXtuzOS2nO0ZF6O2fgAiHkIauaY3RmC45dmDLIxTVoyHZHxAqkH7bWl4ONQV8iM7mrQB5JdP7bxBWUktfblC7TfEgvRIP1X9+PPwv0adzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gVSKI94o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gVSKI94o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0DC1F00ADB;
	Thu,  3 Sep 2026 14:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444337;
	bh=jCl8q9s2wtYEkysfjmrwsmXKDTQKT0NxM5gowgiCuLQ=;
	h=Subject:To:Cc:From:Date;
	b=gVSKI94o8AVhmLn2IqFUUViLujuj3vwTxX2cNR9JodmXqDE8CTaqWJs74Ho85PARh
	 MmxeWnp3jH/F/MTqylIPSQiWd27vacVP5omg0Y3FRrbr4BnruR+N+IyoO02YnTf9Si
	 xNi/lV7yfpZv7XpX+pleZJ+Pa324S+gfl8qNiahs=
Subject: FAILED: patch "[PATCH] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks" failed to apply to 6.12-stable tree
To: terry.bowman@amd.com,dave.jiang@intel.com,jonathan.cameron@oss.qualcomm.com,sashiko@linuxfoundation.org,tony.luck@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:43:35 +0200
Message-ID: <2026090335-waking-roundworm-32ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6625ca499c3131ef63be3215f8f942d7a097ea3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090335-waking-roundworm-32ca@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6625ca499c3131ef63be3215f8f942d7a097ea3a Mon Sep 17 00:00:00 2001
From: Terry Bowman <terry.bowman@amd.com>
Date: Mon, 3 Aug 2026 17:17:59 -0500
Subject: [PATCH] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

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

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..ca7a138c1ff2 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -749,7 +749,7 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
-static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
@@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
 
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
 	if (!cxl_cper_prot_err_work)
 		return;
@@ -780,10 +780,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 
 int cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	if (WARN_ONCE(cxl_cper_prot_err_work,
+		      "CPER-CXL kfifo consumer already registered\n"))
+		return -EINVAL;
 	cxl_cper_prot_err_work = work;
 	return 0;
 }
@@ -791,11 +792,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
 
 int cxl_cper_unregister_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
+		if (WARN_ONCE(cxl_cper_prot_err_work != work,
+			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_prot_err_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_prot_err_fifo);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
@@ -811,7 +819,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
@@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
 		return;
@@ -849,10 +857,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
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
@@ -860,11 +869,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
 
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
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 99fb00949c2f..bc74d4848132 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -137,7 +137,6 @@ int cxl_ras_init(void)
 void cxl_ras_exit(void)
 {
 	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..7c6faee7f85e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
-	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 

