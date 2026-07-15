Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973164AA4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085366; cv=none; b=rFpKsMIz4OTVDUbd2OLtcSgkgXYnMeZIIpNWccwXGva0cFXa9/Nm4W8xow+vRsVd68uRoYLI5aXbMPX3GYliWQB5CPeUhGEZsX/cSOCevfhT1XR7tk8UF7Jt8ZLZyVsDbbGm1hJgECWHmwQaNpCNqPwmuWEeo1aI76lBYPQeku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085366; c=relaxed/simple;
	bh=WFLXNwcFTGivNKiTVVlIq3iksLBJLQsGIm/AnIN4OLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN+hDS6qJ4zx7FGAd6zYQYkQBhXedb+Ggy+p2D7QkABrbxFj6UWJpJ3VObV28cczak7okHEjeLBJeg071bXfSKP8sYe/wr9en98I+uN3cPJNVvEf+zfe1sBnOWHpLPQyh2jlYeaR0Db8SwNsqFQnDOtsZ2wTxzzH8bnCtWeU3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhQS72g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhQS72g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973291F000E9;
	Wed, 15 Jul 2026 03:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085364;
	bh=BcQJTjTOqmhtBprIj5o6ebd6NxBRAY7DTmFzETFIhQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IhQS72g8bswJWhA18YIfjl/eXf9c+gsE+RYyapcNhJJ8v8XGWehguuoCpoKOy4NcG
	 +5HrzcIQMsegCyIoripTvqIjVexNMhXxViCQksb5skXFM3U7RaUlYxNTnFW2Y35Uvw
	 zEN69lKG9ss+4gueGBDITbBto2UL5jjLn0nlj6KmLPndmP1jAX8qu8ChKpIpkKPTTu
	 46V9DUZX5OlhMPmf33J3yo85pjA1lIVzRbEKg77GWy+x5HTaYqjzuwXDOKgrD2EwGz
	 44NBl/IFG8GdvhA4+T/fWg1+xi1+3HR1T63YDKG/xwJLUGeYor19NEhuujEpNCPioz
	 oGxKs6ZG/AYBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
Date: Tue, 14 Jul 2026 23:16:01 -0400
Message-ID: <20260715031602.247772-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-squealer-repent-dc31@gregkh>
References: <2026071352-squealer-repent-dc31@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 277281c10c63791067d24d421f7c43a15faa9096 ]

The VF2PF interrupt handler queues PF-side response work that stores a
raw pointer to per-VF state (struct adf_accel_vf_info). Currently,
adf_disable_sriov() destroys per-VF mutexes and frees vf_info without
stopping new VF2PF work or waiting for in-flight workers to complete. A
concurrently scheduled or already queued worker can then dereference
freed memory.

This manifests as a use-after-free when KASAN is enabled:

  BUG: KASAN: null-ptr-deref in mutex_lock+0x76/0xe0
  Write of size 8 at addr 0000000000000260 by task kworker/24:2/...
  Workqueue: qat_pf2vf_resp_wq adf_iov_send_resp [intel_qat]
  Call Trace:
    kasan_report+0x119/0x140
    mutex_lock+0x76/0xe0
    adf_gen4_pfvf_send+0xd4/0x1f0 [intel_qat]
    adf_recv_and_handle_vf2pf_msg+0x290/0x360 [intel_qat]
    adf_iov_send_resp+0x8c/0xe0 [intel_qat]
    process_one_work+0x6ac/0xfd0
    worker_thread+0x4dd/0xd30
    kthread+0x326/0x410
    ret_from_fork+0x33b/0x670

Add a PF-local flag, vf2pf_disabled, that gates work queueing, worker
processing, and interrupt re-enabling during teardown. Set this flag
atomically with the hardware interrupt mask inside
adf_disable_all_vf2pf_interrupts(). After masking, synchronize the AE
cluster MSI-X interrupt and flush the PF response workqueue before
tearing down per-VF locks and state so all in-flight work completes
before vf_info is destroyed.

Introduce adf_enable_all_vf2pf_interrupts() to clear the flag and
unmask all VF2PF interrupts under the same lock when SR-IOV is
re-enabled. This ensures the software flag and hardware state transition
atomically on both the enable and disable paths.

Cc: stable@vger.kernel.org
Fixes: ed8ccaef52fa ("crypto: qat - Add support for SRIOV")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/qat/qat_common/adf_accel_devices.h |  2 ++
 .../crypto/qat/qat_common/adf_common_drv.h    |  4 +++
 drivers/crypto/qat/qat_common/adf_isr.c       | 18 +++++++++++++
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 27 +++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_sriov.c     | 27 ++++++++++++++++---
 5 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 3bb67b22edd6e1..ca26ffabc388d8 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -248,6 +248,8 @@ struct adf_accel_dev {
 		struct {
 			/* protects VF2PF interrupts access */
 			spinlock_t vf2pf_ints_lock;
+			/* prevents VF2PF handling from racing with VF state teardown */
+			bool vf2pf_disabled;
 			/* vf_info is non-zero when SR-IOV is init'ed */
 			struct adf_accel_vf_info *vf_info;
 		} pf;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index d91b8e6dcd08a5..dc69edd0d1b065 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -120,6 +120,7 @@ void qat_asym_algs_unregister(void);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
@@ -189,6 +190,9 @@ void adf_disable_vf2pf_interrupts_irq(struct adf_accel_dev *accel_dev,
 				      u32 vf_mask);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 				 u32 vf_mask);
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
+				     u32 num_vfs);
+void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_enable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info);
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index c678d5c531aa9d..d5d15ed1a081a0 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -135,6 +135,24 @@ static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
 	return IRQ_NONE;
 }
 
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev)
+{
+	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
+	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
+	struct msix_entry *msixe = pci_dev_info->msix_entries.entries;
+	u32 num_entries = pci_dev_info->msix_entries.num_entries;
+	u32 irq_idx;
+
+	if (!test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status) || !msixe)
+		return;
+
+	irq_idx = num_entries > 1 ? hw_data->num_banks : 0;
+	if (irq_idx >= num_entries)
+		return;
+
+	synchronize_irq(msixe[irq_idx].vector);
+}
+
 static int adf_request_irqs(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
diff --git a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
index 7ec81989beb03f..ab2d0c3ad0acf3 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -40,6 +40,23 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	if (!READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		__adf_enable_vf2pf_interrupts(accel_dev, vf_mask);
+	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
+}
+
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
+				     u32 num_vfs)
+{
+	unsigned long flags;
+	u32 vf_mask;
+
+	vf_mask = BIT_ULL(num_vfs) - 1;
+	if (!vf_mask)
+		return;
+
+	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, false);
 	__adf_enable_vf2pf_interrupts(accel_dev, vf_mask);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
@@ -84,6 +101,16 @@ void adf_disable_vf2pf_interrupts_irq(struct adf_accel_dev *accel_dev, u32 vf_ma
 	spin_unlock(&accel_dev->pf.vf2pf_ints_lock);
 }
 
+void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, true);
+	__adf_disable_vf2pf_interrupts(accel_dev, GENMASK(31, 0));
+	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
+}
+
 static int __adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
 {
 	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index 90ec057f9183d7..6647c0fa5cd1e6 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -19,15 +19,26 @@ static void adf_iov_send_resp(struct work_struct *work)
 {
 	struct adf_pf2vf_resp *pf2vf_resp =
 		container_of(work, struct adf_pf2vf_resp, pf2vf_resp_work);
+	struct adf_accel_vf_info *vf_info = pf2vf_resp->vf_info;
+	struct adf_accel_dev *accel_dev = vf_info->accel_dev;
 
-	adf_vf2pf_req_hndl(pf2vf_resp->vf_info);
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		goto out;
+
+	adf_vf2pf_req_hndl(vf_info);
+
+out:
 	kfree(pf2vf_resp);
 }
 
 void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
 {
+	struct adf_accel_dev *accel_dev = vf_info->accel_dev;
 	struct adf_pf2vf_resp *pf2vf_resp;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		return;
+
 	pf2vf_resp = kzalloc(sizeof(*pf2vf_resp), GFP_ATOMIC);
 	if (!pf2vf_resp)
 		return;
@@ -37,6 +48,12 @@ void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
 	queue_work(pf2vf_resp_wq, &pf2vf_resp->pf2vf_resp_work);
 }
 
+static void adf_flush_pf2vf_resp_wq(void)
+{
+	if (pf2vf_resp_wq)
+		flush_workqueue(pf2vf_resp_wq);
+}
+
 static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 {
 	struct pci_dev *pdev = accel_to_pci_dev(accel_dev);
@@ -63,7 +80,7 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 
 	/* Enable VF to PF interrupts for all VFs */
 	if (hw_data->get_pf2vf_offset)
-		adf_enable_vf2pf_interrupts(accel_dev, BIT_ULL(totalvfs) - 1);
+		adf_enable_all_vf2pf_interrupts(accel_dev, totalvfs);
 
 	/*
 	 * Due to the hardware design, when SR-IOV and the ring arbiter
@@ -97,9 +114,11 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 
 	pci_disable_sriov(accel_to_pci_dev(accel_dev));
 
-	/* Disable VF to PF interrupts */
+	/* Block VF2PF work and disable VF to PF interrupts */
 	if (hw_data->get_pf2vf_offset)
-		adf_disable_vf2pf_interrupts(accel_dev, GENMASK(31, 0));
+		adf_disable_all_vf2pf_interrupts(accel_dev);
+	adf_isr_sync_ae_cluster(accel_dev);
+	adf_flush_pf2vf_resp_wq();
 
 	/* Clear Valid bits in AE Thread to PCIe Function Mapping */
 	if (hw_data->configure_iov_threads)
-- 
2.53.0

