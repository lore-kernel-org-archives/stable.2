Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E1443304
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114126; cv=none; b=g6pCJLOmao1KN+lsv9642VLdDD98CHOi3zQESjIStfUu6GkZOlNj7rNJz3xitGRl7oK7qsWH/DypyWG0K8c01r2/rn2ODKYnHpe9aaj15jyRCC/XS8JHC5bluDLQ32jvELm27Vu5/Gf5eUL2cE73m0mbdyjSstzesFi+N80AVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114126; c=relaxed/simple;
	bh=xO4Dfol/1IIfUZjrWqp3HFG8l38SjB0zuUI3TJLGT58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgbWfj16xDZx2pXl2Ysl3iWpzeg3Ybnyo3834ZrxDQmCLqNodhRDRYvhgILOWaEuRzfix/i1BoFgXgL3mk18bfn+AG+fzi6cZI+RjNv0X8UWPqm9Od5xpjaS/xQ0DadFCLJPWSd+JELerP/YQ/QxCtwFksYa++TEAWl+J9mvdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6bJAYIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6bJAYIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8338F1F000E9;
	Wed, 15 Jul 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114125;
	bh=0TqV/pVJduxcE5vz52r1TMUffCEBhPFFVxbyWIxUEiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E6bJAYIpk7LPqxZ6t3tmnrdZ4jPpzpZ5QUiJZr28krGCiGW0vvj+PRf0STgn4n7fu
	 uNZ9cJE5MiumIIEaOwcUzwfz8/6H4gSn2J+8xVyyS/Lms9hE0U3I1XiN3Fv1ld9CjL
	 7udtzE490VUw43+QltphMI3fqmt8fxt9zKoLYTccWxhQNG2AB/Hhx2JydboM8BPkQ6
	 o3ojY/L7GFQ9x8ffYU7oiWCg7A7yYn7gSBy7/OiQh3sC39qtx/8qIFU3hGhCB/c4Og
	 v5T0VaGSLtpx17+tMuh8CK3+KqcmKjGGUqWqPzqZwZr17VOJh+O0w7uNmArFs7B0mi
	 NL+5ejamh1InA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] crypto: qat - fix VF2PF work teardown race in adf_disable_sriov()
Date: Wed, 15 Jul 2026 07:15:23 -0400
Message-ID: <20260715111523.644545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071353-appraiser-nemeses-9188@gregkh>
References: <2026071353-appraiser-nemeses-9188@gregkh>
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
 .../crypto/qat/qat_common/adf_common_drv.h    |  4 ++
 drivers/crypto/qat/qat_common/adf_isr.c       | 18 +++++++++
 drivers/crypto/qat/qat_common/adf_pf2vf_msg.c | 22 +++++++++++
 drivers/crypto/qat/qat_common/adf_sriov.c     | 38 +++++++++++++++----
 5 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 961a8b3650c732..aba7c8aa39e8a3 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -191,6 +191,8 @@ struct adf_accel_dev {
 	struct adf_accel_pci accel_pci_dev;
 	union {
 		struct {
+			/* prevents VF2PF handling from racing with VF state teardown */
+			bool vf2pf_disabled;
 			/* vf_info is non-zero when SR-IOV is init'ed */
 			struct adf_accel_vf_info *vf_info;
 		} pf;
diff --git a/drivers/crypto/qat/qat_common/adf_common_drv.h b/drivers/crypto/qat/qat_common/adf_common_drv.h
index e84b1ca844032a..5cca89dca4a43c 100644
--- a/drivers/crypto/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/qat/qat_common/adf_common_drv.h
@@ -125,6 +125,7 @@ void qat_asym_algs_unregister(void);
 
 int adf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_isr_resource_free(struct adf_accel_dev *accel_dev);
+void adf_isr_sync_ae_cluster(struct adf_accel_dev *accel_dev);
 int adf_vf_isr_resource_alloc(struct adf_accel_dev *accel_dev);
 void adf_vf_isr_resource_free(struct adf_accel_dev *accel_dev);
 
@@ -189,6 +190,9 @@ void adf_disable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 				  u32 vf_mask);
 void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 				 u32 vf_mask);
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
+				     u32 num_vfs);
+void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_enable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 void adf_disable_pf2vf_interrupts(struct adf_accel_dev *accel_dev);
 
diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
index de2f137e44ef89..5d6d7fcd901bab 100644
--- a/drivers/crypto/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/qat/qat_common/adf_isr.c
@@ -117,6 +117,24 @@ static irqreturn_t adf_msix_isr_ae(int irq, void *dev_ptr)
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
index 74afafc84c7164..c8908848b777b3 100644
--- a/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
+++ b/drivers/crypto/qat/qat_common/adf_pf2vf_msg.c
@@ -40,6 +40,9 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 	void __iomem *pmisc_addr = pmisc->virt_addr;
 	u32 reg;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		return;
+
 	/* Enable VF2PF Messaging Ints - VFs 1 through 16 per vf_mask[15:0] */
 	if (vf_mask & 0xFFFF) {
 		reg = ADF_CSR_RD(pmisc_addr, ADF_DH895XCC_ERRMSK3);
@@ -55,6 +58,19 @@ void adf_enable_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
 	}
 }
 
+void adf_enable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev,
+				     u32 num_vfs)
+{
+	u32 vf_mask;
+
+	vf_mask = BIT_ULL(num_vfs) - 1;
+	if (!vf_mask)
+		return;
+
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, false);
+	adf_enable_vf2pf_interrupts(accel_dev, vf_mask);
+}
+
 void adf_disable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 {
 	struct adf_hw_device_data *hw_data = accel_dev->hw_device;
@@ -78,6 +94,12 @@ void adf_disable_vf2pf_interrupts(struct adf_accel_dev *accel_dev, u32 vf_mask)
 	}
 }
 
+void adf_disable_all_vf2pf_interrupts(struct adf_accel_dev *accel_dev)
+{
+	WRITE_ONCE(accel_dev->pf.vf2pf_disabled, true);
+	adf_disable_vf2pf_interrupts(accel_dev, GENMASK(31, 0));
+}
+
 static int __adf_iov_putmsg(struct adf_accel_dev *accel_dev, u32 msg, u8 vf_nr)
 {
 	struct adf_accel_pci *pci_info = &accel_dev->accel_pci_dev;
diff --git a/drivers/crypto/qat/qat_common/adf_sriov.c b/drivers/crypto/qat/qat_common/adf_sriov.c
index 963b2bea78f295..bd310747cc6b2a 100644
--- a/drivers/crypto/qat/qat_common/adf_sriov.c
+++ b/drivers/crypto/qat/qat_common/adf_sriov.c
@@ -44,16 +44,27 @@ static void adf_iov_send_resp(struct work_struct *work)
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
 
 static void adf_vf2pf_bh_handler(void *data)
 {
 	struct adf_accel_vf_info *vf_info = (struct adf_accel_vf_info *)data;
+	struct adf_accel_dev *accel_dev = vf_info->accel_dev;
 	struct adf_pf2vf_resp *pf2vf_resp;
 
+	if (READ_ONCE(accel_dev->pf.vf2pf_disabled))
+		return;
+
 	pf2vf_resp = kzalloc(sizeof(*pf2vf_resp), GFP_ATOMIC);
 	if (!pf2vf_resp)
 		return;
@@ -63,6 +74,12 @@ static void adf_vf2pf_bh_handler(void *data)
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
@@ -105,7 +122,7 @@ static int adf_enable_sriov(struct adf_accel_dev *accel_dev)
 	}
 
 	/* Enable VF to PF interrupts for all VFs */
-	adf_enable_vf2pf_interrupts(accel_dev, GENMASK_ULL(totalvfs - 1, 0));
+	adf_enable_all_vf2pf_interrupts(accel_dev, totalvfs);
 
 	/*
 	 * Due to the hardware design, when SR-IOV and the ring arbiter
@@ -142,8 +159,16 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 
 	pci_disable_sriov(accel_to_pci_dev(accel_dev));
 
-	/* Disable VF to PF interrupts */
-	adf_disable_vf2pf_interrupts(accel_dev, 0xFFFFFFFF);
+	/* Block VF2PF work and disable VF to PF interrupts */
+	adf_disable_all_vf2pf_interrupts(accel_dev);
+	adf_isr_sync_ae_cluster(accel_dev);
+
+	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++) {
+		tasklet_disable(&vf->vf2pf_bh_tasklet);
+		tasklet_kill(&vf->vf2pf_bh_tasklet);
+	}
+
+	adf_flush_pf2vf_resp_wq();
 
 	/* Clear Valid bits in ME Thread to PCIe Function Mapping Group A */
 	for (i = 0; i < ME2FUNCTION_MAP_A_NUM_REGS; i++) {
@@ -159,11 +184,8 @@ void adf_disable_sriov(struct adf_accel_dev *accel_dev)
 		WRITE_CSR_ME2FUNCTION_MAP_B(pmisc_addr, i, reg);
 	}
 
-	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++) {
-		tasklet_disable(&vf->vf2pf_bh_tasklet);
-		tasklet_kill(&vf->vf2pf_bh_tasklet);
+	for (i = 0, vf = accel_dev->pf.vf_info; i < totalvfs; i++, vf++)
 		mutex_destroy(&vf->pf2vf_lock);
-	}
 
 	kfree(accel_dev->pf.vf_info);
 	accel_dev->pf.vf_info = NULL;
-- 
2.53.0

