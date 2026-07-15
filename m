Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61C286D5E
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079931; cv=none; b=iBediKAqQf2xZFQNa8l0c5GBcZTWYZQmH2BJgSXox0hIRBN52hTVMbPf8znqZ40jiPDNJaMqK2S1oaxPAdGQ/7RiiqCDHSffRUF2Owa8+EYAPPrmq8CYzHTchQQTA2vimCRNhOZzIvzNd2msUlzHnwvDChKFnp92zoPgl048Gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079931; c=relaxed/simple;
	bh=LFmD4F8cgrZXTHJD1FgCXAe3ltZ3o8vljjB8N6lps0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiaBbVkrPKhBaOxrbX8AEEKxLFqRZMnfjC1J8Rc/co89pAbvpYHe/1HC5CTz8fhvAztpauFbKOV+yMhpDCrxZ1i3+fHj34cpxq0V+VWx305diQrTLJEl7JGdp72W7wLbGfxo4nAARZFLDuG9nz4DvueYmOkNg8B/OnWEjRE9qQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEQR6nYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEQR6nYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5127F1F000E9;
	Wed, 15 Jul 2026 01:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079929;
	bh=efFsl2ZCjbfiaOhsteM+kvHDOosQZtcCgdYV9zUsaWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEQR6nYvoFSN+b8bcVw/pwctrhZkIPq9vM26mj3aUgTtT2Z1CKkmgu3LepVzd4U0I
	 nay6tqnpJaRglAuh47ArR0nSS2x/Gx/k4IMKnYLQX1F3VjeMEVlxhxJOO/z92kqPoB
	 UDlqHyhMLZKZhLnSDR/uxk7Io4saxAqwpE96eqbpw1r8Zsh974J4+ABF3H1zROXa5A
	 xqHXnp/402mh+k8R45XjoP0aK1x8gnlDSk6+YOjjVng9+Q8ShghC1G9NsSJyJdw4Yc
	 23SIYdMvYE5/2WIejRepQhzf7U+Np35zTvawRBF1VOwAaM43+vokdleVUMIgon3870
	 nwNtQBcsUudfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
Date: Tue, 14 Jul 2026 21:45:27 -0400
Message-ID: <20260715014527.4133831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071351-gently-customary-f284@gregkh>
References: <2026071351-gently-customary-f284@gregkh>
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
 .../intel/qat/qat_common/adf_accel_devices.h  |  2 +
 .../intel/qat/qat_common/adf_common_drv.h     |  2 +
 drivers/crypto/intel/qat/qat_common/adf_isr.c | 39 +++++++++++++++++++
 .../crypto/intel/qat/qat_common/adf_sriov.c   | 20 +++++++++-
 4 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
index 79d5a1535eda34..658337b6aad606 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_accel_devices.h
@@ -314,6 +314,8 @@ struct adf_accel_dev {
 		struct {
 			/* protects VF2PF interrupts access */
 			spinlock_t vf2pf_ints_lock;
+			/* prevents VF2PF handling from racing with VF state teardown */
+			bool vf2pf_disabled;
 			/* vf_info is non-zero when SR-IOV is init'ed */
 			struct adf_accel_vf_info *vf_info;
 		} pf;
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index d9255b307c4b2a..2cf21f59a21c95 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -123,6 +123,7 @@ void qat_comp_alg_callback(void *resp);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
@@ -195,6 +196,7 @@ void adf_misc_wq_flush(void);
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask);
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 num_vfs);
 void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_pf2vf_msg(struct adf_accel_dev *accel_dev);
 bool adf_recv_and_handle_vf2pf_msg(struct adf_accel_dev *accel_dev, u32 vf_nr);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
index ce7c9ef6346b39..0d34f346a38129 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
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
diff --git a/drivers/crypto/intel/qat/qat_common/adf_sriov.c b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
index f44025bb6f995d..202c08c9d9f0d4 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_sriov.c
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

