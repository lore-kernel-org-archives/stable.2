Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AF13777E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083535; cv=none; b=AONP5svz/VuND0+kT8uhCozBB29zsGEsv0HnvVYDOGuBAyF3X8pSeWLkJSAvqrd/rwhpLmOYCP3SszIv9B29bohk/e8YX2v71WOjVinaUq9ZfgkiOT8/paxJgy9TWEttUCuCEmgFpSl1FfdYP6Q28GToKhW7ny3qdIJOiR7zisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083535; c=relaxed/simple;
	bh=3ZWi2NYZD6rvbgAe9yIFduuQ5BtM3fcnMMU5rnt1xLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndLUXZFVaXn3zWqDQZZpYLHKD6AGuAQ+oI2RUh8uvB8/VcG901SiMmOaO4cdirTe8/ExrKgfAF3GkYkH8E//6JWibf/+7p8e6uHDZ7j0Jk0uB+C0VCie9GRAexpyfvedObl39xf+z4Kx2/+RnKVBgkJU4HjNCaOLJTy9KR2rrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MivJbHvW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MivJbHvW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58451F000E9;
	Wed, 15 Jul 2026 02:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083533;
	bh=ARzv/h052Rr6o0+QTEOGey7FBXeKArg9LngcJjeh9pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MivJbHvWGNlYqMDog58WP4q6GxKFIGeQo1ivrJ3Le/ZnoHwN9JzyAQX3OsnQViElT
	 Hy4D21Cbj4QbfZYipYdfOxXVO0hU67s8vn79aa9ST2mtR17BAI4mx6akPh1avU5HSe
	 fq6cDudUnHVqbV93+zLdpDg7gnbSvDftZzCdofipCG/qCP0V3wz6XE/q/DvIg+SNif
	 xWuhmbw63yA6V+iEt2kRVu3/d6CxcE3ReejxuAKcadEHqhU7pMP3ABx+XfxQRHDIJY
	 sVS9dm/pogk9SSI/GQV89joorFG9OXYz3q9KPdAi+rzCayOTBtmyOVrIYC+742rvrT
	 vrUh3pg0p5LxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
Date: Tue, 14 Jul 2026 22:45:30 -0400
Message-ID: <20260715024530.105076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071352-unshaved-deniable-6318@gregkh>
References: <2026071352-unshaved-deniable-6318@gregkh>
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
 .../crypto/qat/qat_common/adf_accel_devices.h |  2 +
 .../crypto/qat/qat_common/adf_common_drv.h    |  2 +
 drivers/crypto/qat/qat_common/adf_isr.c       | 39 +++++++++++++++++++
 drivers/crypto/qat/qat_common/adf_sriov.c     | 20 +++++++++-
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 7993d0f82dea65..c9274e70311abb 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -284,6 +284,8 @@ struct adf_accel_dev {
 		struct {
 			/* protects VF2PF interrupts access */
 			spinlock_t vf2pf_ints_lock;
+			/* prevents VF2PF handling from racing with VF state teardown */
+			bool vf2pf_disabled;
 			/* vf_info is non-zero when SR-IOV is init'ed */
 			struct adf_accel_vf_info *vf_info;
 		} pf;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index 0db01a6086e3ff..98b5a072345b24 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -124,6 +124,7 @@ void qat_asym_algs_unregister(void);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
@@ -196,6 +197,7 @@ void adf_misc_wq_flush(void);
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask);
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 num_vfs);
 void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr);
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index e41ae70d69edb1..430fa11da1ee00 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -62,6 +62,23 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	if (!READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		GET_PFVF_OPS(accel_dev)->enable_vf2pf_interrupts(pmisc_addr, vf_mask);
+	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
+}
+
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 num_vfs)
+{
+	void __iomem *pmisc_addr = adf_get_pmisc_base(accel_dev);
+	unsigned long flags;
+	u32 vf_mask;
+
+	vf_mask = BIT_ULL(num_vfs) - 1;
+	if (!vf_mask)
+		return;
+
+	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, false);
 	GET_PFVF_OPS(accel_dev)->enable_vf2pf_interrupts(pmisc_addr, vf_mask);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
@@ -72,6 +89,7 @@ void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&accel_dev->pf.vf2pf_ints_lock, flags);
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, true);
 	GET_PFVF_OPS(accel_dev)->disable_all_vf2pf_interrupts(pmisc_addr);
 	spin_unlock_irqrestore(&accel_dev->pf.vf2pf_ints_lock, flags);
 }
@@ -151,6 +169,27 @@ static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
 	return IRQ_NONE;
 }
 
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev)
+{
+	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
+	struct adf_hw_device_data *hw_data = GET_HW_DATA(accel_dev);
+	u32 num_entries = pci_dev_info->msix_entries.num_entries;
+	struct adf_irq *irqs = pci_dev_info->msix_entries.irqs;
+	u32 irq_idx;
+	int irq;
+
+	if (!test_bit(ADF_STATUS_IRQ_ALLOCATED, &accel_dev->status) || !irqs)
+		return;
+
+	irq_idx = num_entries > 1 ? hw_data->num_banks : 0;
+	if (irq_idx >= num_entries || !irqs[irq_idx].enabled)
+		return;
+
+	irq = pci_irq_vector(pci_dev_info->pci_dev, hw_data->num_banks);
+	if (irq > 0)
+		synchronize_irq(irq);
+}
+
 static void adf_free_irqs(struct adf_accel_dev *accel_dev)
 {
 	struct adf_accel_pci *pci_dev_info = &accel_dev->accel_pci_dev;
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index b2db1d70d71fbd..b2acfbd9b74186 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -26,18 +26,26 @@ static void adf_iov_send_resp(struct work_struct *work)
 	u32 vf_nr = vf_info->vf_nr;
 	bool ret;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		goto out;
+
 	ret = adf_recv_and_handle_vf2pf_msg(accel_dev, vf_nr);
 	if (ret)
 		/* re-enable interrupt on PF from this VF */
 		adf_enable_vf2pf_interrupts(accel_dev, 1 << vf_nr);
 
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
@@ -47,6 +55,12 @@ void adf_schedule_vf2pf_handler(struct adf_accel_vf_info *vf_info)
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
@@ -73,7 +87,7 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 		hw_data->configure_iov_threads(accel_dev, true);
 
 	/* Enable VF to PF interrupts for all VFs */
-	adf_enable_vf2pf_interrupts(accel_dev, BIT_ULL(totalvfs) - 1);
+	adf_enable_all_vf2pf_interrupts(accel_dev, totalvfs);
 
 	/*
 	 * Due to the hardware design, when SR-IOV and the ring arbiter
@@ -105,8 +119,10 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 	adf_pf2vf_notify_restarting(accel_dev);
 	pci_disable_sriov(accel_to_pci_dev(accel_dev));
 
-	/* Disable VF to PF interrupts */
+	/* Block VF2PF work and disable VF to PF interrupts */
 	adf_disable_all_vf2pf_interrupts(accel_dev);
+	adf_isr_sync_ae_cluster(accel_dev);
+	adf_flush_pf2vf_resp_wq();
 
 	/* Clear Valid bits in AE Thread to PCIe Function Mapping */
 	if (hw_data->configure_iov_threads)
-- 
2.53.0

