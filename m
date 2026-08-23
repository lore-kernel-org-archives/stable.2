Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F323CBE86;
	Sun, 23 Aug 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489124; cv=none; b=RAmCQZrS2rsvfzi9r/T+Ka7vjFKJ3SzKieJFHWNpTI6LILsro7bDzxlEuuUbvL4FVJUbjTpGUSSc5DGTD3TR56jnxr2VCmopWke6Dz8reFdiFxsfnbRDKErf/wwTpLCc9o0MXy6uYBQFS7CkY/nLL3NxL826s2FTAH+k3sG4+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489124; c=relaxed/simple;
	bh=PEnTqaEFfgU/VeDLkH2XaKSArviqp8Aj5tcnwGJ7H8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FchBt6gXA+HGfqq47BkswMdXIPCUGHHUDbgSOmQp/kZYVGUiSVNNqsgiacZA2Hwsm9eU77oAoEAHSPNE191PBK1FDO245P30vUNua708ozNW0TvskZN0ppWWfbMJz0nfrKJ45ZoVgQ9jwWViUMspAmIfkID7s9CEPGjvrnDt6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nOKtWkYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nOKtWkYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C55D1F000E9;
	Sun, 23 Aug 2026 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489094;
	bh=FtJTLGOk9m5GgPMjRucqtSeUn34CLXQPZbGCz38aJ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOKtWkYwl1CAauiMvi9x3zKf4gf5HuKtYM1NsAd0DSd0iIwK2M523asqnX3nj9gln
	 oO7NVp3qABydZno98oPUZMeykkkVxqoQKLmXHK/NCpj/Ee+ni9HVt64tdqQtKl9biD
	 aslJvKyQ7zl7lZxrYpEoVIcZHLP4HgPEH7s08+B8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.217
Date: Sun, 23 Aug 2026 14:43:05 +0200
Message-ID: <2026082305-train-cornstalk-6951@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082305-overhead-jubilance-ef6e@gregkh>
References: <2026082305-overhead-jubilance-ef6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index bed62696d40b..4a3360de8431 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 216
+SUBLEVEL = 217
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index ca71b71d801a..934ec5b048da 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -2586,6 +2586,8 @@ timer {
 			     <GIC_PPI 11
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 15
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 		always-on;
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index aa1699c18add..016af78dd3c8 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -26,6 +26,8 @@
 		   | SPR_SR_DCE | SPR_SR_SM)
 #define USER_SR   (SPR_SR_DME | SPR_SR_IME | SPR_SR_ICE \
 		   | SPR_SR_DCE | SPR_SR_IEE | SPR_SR_TEE)
+/* SR bits user space may change via sigreturn, the rest stay kernel owned */
+#define SPR_SR_USER_MASK  (SPR_SR_F | SPR_SR_CY | SPR_SR_OV)
 
 /*
  * User space process size. This is hardcoded into a few places,
diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 1ebcff271096..8163ca3533fc 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -39,6 +39,7 @@ struct rt_sigframe {
 static int restore_sigcontext(struct pt_regs *regs,
 			      struct sigcontext __user *sc)
 {
+	unsigned long old_sr = regs->sr;
 	int err = 0;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -53,8 +54,8 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(&regs->pc, &sc->regs.pc, sizeof(unsigned long));
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
 
-	/* make sure the SM-bit is cleared so user-mode cannot fool us */
-	regs->sr &= ~SPR_SR_SM;
+	/* keep the privileged SR bits kernel owned, restore only user flags */
+	regs->sr = (old_sr & ~SPR_SR_USER_MASK) | (regs->sr & SPR_SR_USER_MASK);
 
 	regs->orig_gpr11 = -1;	/* Avoid syscall restart checks */
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index fea4dfa54e3c..4e40b85d86d4 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -641,7 +641,7 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count > sizeof(kbuf))
+	if (count == 0 || count > sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 3b6800f774c2..3b68932bab5c 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -160,7 +160,7 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs && num_vfs > MAX_VFS_FOR_MAP_PE) {
+	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
 		dev_err(&pdev->dev,
 			"Num VFs %x > %x Configurable VFs\n",
 			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2ec16477eb3e..dcf54246aafa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2439,10 +2439,6 @@ static void rmdir_all_sub(void)
 		if (rdtgrp == &rdtgroup_default)
 			continue;
 
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
 		/*
 		 * Give any CPUs back to the default group. We cannot copy
 		 * cpu_online_mask because a CPU might have executed the
@@ -2451,7 +2447,13 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
-		free_rmid(rdtgrp->mon.rmid);
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		} else {
+			/* Pseudo-locked group's RMID is freed during setup. */
+			free_rmid(rdtgrp->mon.rmid);
+		}
 
 		kernfs_remove(rdtgrp->kn);
 		list_del(&rdtgrp->rdtgroup_list);
diff --git a/crypto/ccm.c b/crypto/ccm.c
index 6b815ece51c6..30c8f10408a3 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -753,7 +753,7 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 
 	inst->alg.ivsize = 8;
 	inst->alg.chunksize = crypto_aead_alg_chunksize(alg);
-	inst->alg.maxauthsize = 16;
+	inst->alg.maxauthsize = crypto_aead_alg_maxauthsize(alg);
 
 	inst->alg.base.cra_ctxsize = sizeof(struct crypto_rfc4309_ctx);
 
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 16e486337ecb..88f73e1b749d 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -49,10 +49,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		bool check_cancel)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	unsigned long stop;
-	long rc;
 	u8 status;
 	bool canceled = false;
+	int ret;
 
 	/* check current status */
 	status = chip->ops->status(chip);
@@ -62,23 +63,32 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 	stop = jiffies + timeout;
 
 	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
+		ret = -ETIME;
+		add_wait_queue(queue, &wait);
 again:
+		if (wait_for_tpm_stat_cond(chip, mask, check_cancel,
+					   &canceled)) {
+			ret = canceled ? -ECANCELED : 0;
+			goto out;
+		}
+
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -ETIME;
-		rc = wait_event_interruptible_timeout(*queue,
-			wait_for_tpm_stat_cond(chip, mask, check_cancel,
-					       &canceled),
-			timeout);
-		if (rc > 0) {
-			if (canceled)
-				return -ECANCELED;
-			return 0;
-		}
-		if (rc == -ERESTARTSYS && freezing(current)) {
-			clear_thread_flag(TIF_SIGPENDING);
-			goto again;
+			goto out;
+
+		if (signal_pending(current)) {
+			if (freezing(current)) {
+				clear_thread_flag(TIF_SIGPENDING);
+				goto again;
+			}
+			goto out;
 		}
+
+		wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
+		goto again;
+out:
+		remove_wait_queue(queue, &wait);
+		return ret;
 	} else {
 		do {
 			usleep_range(priv->timeout_min,
diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index df4ae3377b61..72b3892ed24c 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -55,7 +55,7 @@ static int qce_register_algs(struct qce_device *qce)
 		ret = ops->register_algs(qce);
 		if (ret) {
 			for (j = i - 1; j >= 0; j--)
-				ops->unregister_algs(qce);
+				qce_ops[j]->unregister_algs(qce);
 			return ret;
 		}
 	}
diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index bcce96d4a753..e36d11ff8b96 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -131,7 +131,7 @@ void dma_resv_fini(struct dma_resv *obj)
 EXPORT_SYMBOL(dma_resv_fini);
 
 /**
- * dma_resv_reserve_shared - Reserve space to add shared fences to
+ * dma_resv_reserve_fences - Reserve space to add shared fences to
  * a dma_resv.
  * @obj: reservation object
  * @num_fences: number of fences we want to add
@@ -142,7 +142,7 @@ EXPORT_SYMBOL(dma_resv_fini);
  * RETURNS
  * Zero for success, or -errno
  */
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences)
 {
 	struct dma_resv_list *old, *new;
 	unsigned int i, j, k, max;
@@ -205,7 +205,7 @@ int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences)
 
 	return 0;
 }
-EXPORT_SYMBOL(dma_resv_reserve_shared);
+EXPORT_SYMBOL(dma_resv_reserve_fences);
 
 #ifdef CONFIG_DEBUG_MUTEXES
 /**
@@ -213,7 +213,7 @@ EXPORT_SYMBOL(dma_resv_reserve_shared);
  * @obj: the dma_resv object to reset
  *
  * Reset the number of pre-reserved shared slots to test that drivers do
- * correct slot allocation using dma_resv_reserve_shared(). See also
+ * correct slot allocation using dma_resv_reserve_fences(). See also
  * &dma_resv_list.shared_max.
  */
 void dma_resv_reset_shared_max(struct dma_resv *obj)
@@ -235,7 +235,7 @@ EXPORT_SYMBOL(dma_resv_reset_shared_max);
  * @fence: the shared fence to add
  *
  * Add a fence to a shared slot, obj->lock must be held, and
- * dma_resv_reserve_shared() has been called.
+ * dma_resv_reserve_fences() has been called.
  */
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 {
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2d6d1eab3883..1572d3302240 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -72,14 +72,16 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 					0, ubuf->pagecount << PAGE_SHIFT,
 					GFP_KERNEL);
 	if (ret < 0)
-		goto err;
-	ret = dma_map_sgtable(dev, sg, direction, 0);
+		goto err_alloc;
+
+	ret = dma_map_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret < 0)
-		goto err;
+		goto err_map;
 	return sg;
 
-err:
+err_map:
 	sg_free_table(sg);
+err_alloc:
 	kfree(sg);
 	return ERR_PTR(ret);
 }
@@ -87,7 +89,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 static void put_sg_table(struct device *dev, struct sg_table *sg,
 			 enum dma_data_direction direction)
 {
-	dma_unmap_sgtable(dev, sg, direction, 0);
+	dma_unmap_sgtable(dev, sg, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	sg_free_table(sg);
 	kfree(sg);
 }
@@ -125,21 +127,22 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
 {
 	struct udmabuf *ubuf = buf->priv;
 	struct device *dev = ubuf->device->this_device;
-	int ret = 0;
 
 	if (!ubuf->sg) {
 		ubuf->sg = get_sg_table(dev, buf, direction);
 		if (IS_ERR(ubuf->sg)) {
+			int ret;
+
 			ret = PTR_ERR(ubuf->sg);
 			ubuf->sg = NULL;
+			return ret;
 		} else {
 			ubuf->sg_dir = direction;
 		}
-	} else {
-		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
-	return ret;
+	dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
+	return 0;
 }
 
 static int end_cpu_udmabuf(struct dma_buf *buf,
diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f01b6c4bd315..e0de57e31f45 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,8 +64,8 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
+	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
-	struct dw_edma *dw = chan->chip->dw;
 	struct dw_edma_chunk *chunk;
 
 	chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
@@ -82,11 +82,11 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = dw->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_wr[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
 	} else {
-		chunk->ll_region.paddr = dw->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = dw->ll_region_rd[chan->id].vaddr;
+		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
+		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
 	}
 
 	if (desc->chunk) {
@@ -695,7 +695,7 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
-	pm_runtime_get(chan->chip->dev);
+	pm_runtime_get(chan->dw->chip->dev);
 
 	return 0;
 }
@@ -717,15 +717,15 @@ static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 		cpu_relax();
 	}
 
-	pm_runtime_put(chan->chip->dev);
+	pm_runtime_put(chan->dw->chip->dev);
 }
 
-static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
+static int dw_edma_channel_setup(struct dw_edma *dw, bool write,
 				 u32 wr_alloc, u32 rd_alloc)
 {
+	struct dw_edma_chip *chip = dw->chip;
 	struct dw_edma_region *dt_region;
 	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
 	struct dw_edma_chan *chan;
 	struct dw_edma_irq *irq;
 	struct dma_device *dma;
@@ -758,7 +758,7 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 
 		chan->vc.chan.private = dt_region;
 
-		chan->chip = chip;
+		chan->dw = dw;
 		chan->id = j;
 		chan->dir = write ? EDMA_DIR_WRITE : EDMA_DIR_READ;
 		chan->configured = false;
@@ -766,9 +766,9 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		chan->status = EDMA_ST_IDLE;
 
 		if (write)
-			chan->ll_max = (dw->ll_region_wr[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_wr[j].sz / EDMA_LL_SZ);
 		else
-			chan->ll_max = (dw->ll_region_rd[j].sz / EDMA_LL_SZ);
+			chan->ll_max = (chip->ll_region_rd[j].sz / EDMA_LL_SZ);
 		chan->ll_max -= 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
@@ -798,13 +798,13 @@ static int dw_edma_channel_setup(struct dw_edma_chip *chip, bool write,
 		vchan_init(&chan->vc, dma);
 
 		if (write) {
-			dt_region->paddr = dw->dt_region_wr[j].paddr;
-			dt_region->vaddr = dw->dt_region_wr[j].vaddr;
-			dt_region->sz = dw->dt_region_wr[j].sz;
+			dt_region->paddr = chip->dt_region_wr[j].paddr;
+			dt_region->vaddr = chip->dt_region_wr[j].vaddr;
+			dt_region->sz = chip->dt_region_wr[j].sz;
 		} else {
-			dt_region->paddr = dw->dt_region_rd[j].paddr;
-			dt_region->vaddr = dw->dt_region_rd[j].vaddr;
-			dt_region->sz = dw->dt_region_rd[j].sz;
+			dt_region->paddr = chip->dt_region_rd[j].paddr;
+			dt_region->vaddr = chip->dt_region_rd[j].vaddr;
+			dt_region->sz = chip->dt_region_rd[j].sz;
 		}
 
 		dw_edma_v0_core_device_config(chan);
@@ -858,11 +858,11 @@ static inline void dw_edma_add_irq_mask(u32 *mask, u32 alloc, u16 cnt)
 		(*mask)++;
 }
 
-static int dw_edma_irq_request(struct dw_edma_chip *chip,
+static int dw_edma_irq_request(struct dw_edma *dw,
 			       u32 *wr_alloc, u32 *rd_alloc)
 {
-	struct device *dev = chip->dev;
-	struct dw_edma *dw = chip->dw;
+	struct dw_edma_chip *chip = dw->chip;
+	struct device *dev = dw->chip->dev;
 	u32 wr_mask = 1;
 	u32 rd_mask = 1;
 	int i, err = 0;
@@ -871,12 +871,16 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 	ch_cnt = dw->wr_ch_cnt + dw->rd_ch_cnt;
 
-	if (dw->nr_irqs < 1)
+	if (chip->nr_irqs < 1 || !chip->ops->irq_vector)
 		return -EINVAL;
 
-	if (dw->nr_irqs == 1) {
+	dw->irq = devm_kcalloc(dev, chip->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
+	if (!dw->irq)
+		return -ENOMEM;
+
+	if (chip->nr_irqs == 1) {
 		/* Common IRQ shared among all channels */
-		irq = dw->ops->irq_vector(dev, 0);
+		irq = chip->ops->irq_vector(dev, 0);
 		err = request_irq(irq, dw_edma_interrupt_common,
 				  IRQF_SHARED, dw->name, &dw->irq[0]);
 		if (err) {
@@ -886,9 +890,11 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 
 		if (irq_get_msi_desc(irq))
 			get_cached_msi_msg(irq, &dw->irq[0].msi);
+
+		dw->nr_irqs = 1;
 	} else {
 		/* Distribute IRQs equally among all channels */
-		int tmp = dw->nr_irqs;
+		int tmp = chip->nr_irqs;
 
 		while (tmp && (*wr_alloc + *rd_alloc) < ch_cnt) {
 			dw_edma_dec_irq_alloc(&tmp, wr_alloc, dw->wr_ch_cnt);
@@ -899,7 +905,7 @@ static int dw_edma_irq_request(struct dw_edma_chip *chip,
 		dw_edma_add_irq_mask(&rd_mask, *rd_alloc, dw->rd_ch_cnt);
 
 		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
-			irq = dw->ops->irq_vector(dev, i);
+			irq = chip->ops->irq_vector(dev, i);
 			err = request_irq(irq,
 					  i < *wr_alloc ?
 						dw_edma_interrupt_write :
@@ -933,20 +939,22 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 		return -EINVAL;
 
 	dev = chip->dev;
-	if (!dev)
+	if (!dev || !chip->ops)
 		return -EINVAL;
 
-	dw = chip->dw;
-	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
-		return -EINVAL;
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	dw->chip = chip;
 
 	raw_spin_lock_init(&dw->lock);
 
-	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
+	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
 	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
 
-	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
+	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
 			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
 	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
 
@@ -968,17 +976,17 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	dw_edma_v0_core_off(dw);
 
 	/* Request IRQs */
-	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
+	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
 	if (err)
 		return err;
 
 	/* Setup write channels */
-	err = dw_edma_channel_setup(chip, true, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, true, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
 	/* Setup read channels */
-	err = dw_edma_channel_setup(chip, false, wr_alloc, rd_alloc);
+	err = dw_edma_channel_setup(dw, false, wr_alloc, rd_alloc);
 	if (err)
 		goto err_irq_free;
 
@@ -986,15 +994,15 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 	pm_runtime_enable(dev);
 
 	/* Turn debugfs on */
-	dw_edma_v0_core_debugfs_on(chip);
+	dw_edma_v0_core_debugfs_on(dw);
+
+	chip->dw = dw;
 
 	return 0;
 
 err_irq_free:
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
-
-	dw->nr_irqs = 0;
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	return err;
 }
@@ -1012,7 +1020,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 
 	/* Free irqs */
 	for (i = (dw->nr_irqs - 1); i >= 0; i--)
-		free_irq(dw->ops->irq_vector(dev, i), &dw->irq[i]);
+		free_irq(chip->ops->irq_vector(dev, i), &dw->irq[i]);
 
 	/* Power management */
 	pm_runtime_disable(dev);
@@ -1033,7 +1041,7 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 	}
 
 	/* Turn debugfs off */
-	dw_edma_v0_core_debugfs_off(chip);
+	dw_edma_v0_core_debugfs_off(dw);
 
 	return 0;
 }
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 60316d408c3e..3965153a7748 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -15,20 +15,12 @@
 #include "../virt-dma.h"
 
 #define EDMA_LL_SZ					24
-#define EDMA_MAX_WR_CH					8
-#define EDMA_MAX_RD_CH					8
 
 enum dw_edma_dir {
 	EDMA_DIR_WRITE = 0,
 	EDMA_DIR_READ
 };
 
-enum dw_edma_map_format {
-	EDMA_MF_EDMA_LEGACY = 0x0,
-	EDMA_MF_EDMA_UNROLL = 0x1,
-	EDMA_MF_HDMA_COMPAT = 0x5
-};
-
 enum dw_edma_request {
 	EDMA_REQ_NONE = 0,
 	EDMA_REQ_STOP,
@@ -57,12 +49,6 @@ struct dw_edma_burst {
 	u32				sz;
 };
 
-struct dw_edma_region {
-	phys_addr_t			paddr;
-	void				__iomem *vaddr;
-	size_t				sz;
-};
-
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
@@ -87,7 +73,7 @@ struct dw_edma_desc {
 
 struct dw_edma_chan {
 	struct virt_dma_chan		vc;
-	struct dw_edma_chip		*chip;
+	struct dw_edma			*dw;
 	int				id;
 	enum dw_edma_dir		dir;
 
@@ -109,10 +95,6 @@ struct dw_edma_irq {
 	struct dw_edma			*dw;
 };
 
-struct dw_edma_core_ops {
-	int	(*irq_vector)(struct device *dev, unsigned int nr);
-};
-
 struct dw_edma {
 	char				name[20];
 
@@ -122,21 +104,14 @@ struct dw_edma {
 	struct dma_device		rd_edma;
 	u16				rd_ch_cnt;
 
-	struct dw_edma_region		rg_region;	/* Registers */
-	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
-	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
-	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
-
 	struct dw_edma_irq		*irq;
 	int				nr_irqs;
 
-	enum dw_edma_map_format		mf;
-
 	struct dw_edma_chan		*chan;
-	const struct dw_edma_core_ops	*ops;
 
-	raw_spinlock_t			lock;		/* Only for legacy */
+	raw_spinlock_t			lock;		/* Protect v0 shared registers */
+
+	struct dw_edma_chip             *chip;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry			*debugfs;
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 44f6e09bdb53..2c1c5fa4e9f2 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -148,7 +148,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_pcie_data vsec_data;
 	struct device *dev = &pdev->dev;
 	struct dw_edma_chip *chip;
-	struct dw_edma *dw;
 	int err, nr_irqs;
 	int i, mask;
 
@@ -214,10 +213,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip)
 		return -ENOMEM;
 
-	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
-	if (!dw)
-		return -ENOMEM;
-
 	/* IRQs allocation */
 	nr_irqs = pci_alloc_irq_vectors(pdev, 1, vsec_data.irqs,
 					PCI_IRQ_MSI | PCI_IRQ_MSIX);
@@ -228,29 +223,23 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Data structure initialization */
-	chip->dw = dw;
 	chip->dev = dev;
 	chip->id = pdev->devfn;
-	chip->irq = pdev->irq;
 
-	dw->mf = vsec_data.mf;
-	dw->nr_irqs = nr_irqs;
-	dw->ops = &dw_edma_pcie_core_ops;
-	dw->wr_ch_cnt = vsec_data.wr_ch_cnt;
-	dw->rd_ch_cnt = vsec_data.rd_ch_cnt;
+	chip->mf = vsec_data.mf;
+	chip->nr_irqs = nr_irqs;
+	chip->ops = &dw_edma_pcie_core_ops;
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
-	if (!dw->rg_region.vaddr)
-		return -ENOMEM;
+	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
+	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
 
-	dw->rg_region.vaddr += vsec_data.rg.off;
-	dw->rg_region.paddr = pdev->resource[vsec_data.rg.bar].start;
-	dw->rg_region.paddr += vsec_data.rg.off;
-	dw->rg_region.sz = vsec_data.rg.sz;
+	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
+	if (!chip->rg_region.vaddr)
+		return -ENOMEM;
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_wr[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_wr[i];
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_wr[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_wr[i];
 
@@ -273,9 +262,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
-		struct dw_edma_region *ll_region = &dw->ll_region_rd[i];
-		struct dw_edma_region *dt_region = &dw->dt_region_rd[i];
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
+		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
+		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data.ll_rd[i];
 		struct dw_edma_block *dt_block = &vsec_data.dt_rd[i];
 
@@ -299,45 +288,45 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	}
 
 	/* Debug info */
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
-		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_EDMA_UNROLL)
-		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", dw->mf);
-	else if (dw->mf == EDMA_MF_HDMA_COMPAT)
-		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", dw->mf);
+	if (chip->mf == EDMA_MF_EDMA_LEGACY)
+		pci_dbg(pdev, "Version:\teDMA Port Logic (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_EDMA_UNROLL)
+		pci_dbg(pdev, "Version:\teDMA Unroll (0x%x)\n", chip->mf);
+	else if (chip->mf == EDMA_MF_HDMA_COMPAT)
+		pci_dbg(pdev, "Version:\tHDMA Compatible (0x%x)\n", chip->mf);
 	else
-		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", dw->mf);
+		pci_dbg(pdev, "Version:\tUnknown (0x%x)\n", chip->mf);
 
-	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
+	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
 		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
-		dw->rg_region.vaddr, &dw->rg_region.paddr);
+		chip->rg_region.vaddr);
 
 
-	for (i = 0; i < dw->wr_ch_cnt; i++) {
+	for (i = 0; i < chip->wr_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_wr[i].bar,
-			vsec_data.ll_wr[i].off, dw->ll_region_wr[i].sz,
-			dw->ll_region_wr[i].vaddr, &dw->ll_region_wr[i].paddr);
+			vsec_data.ll_wr[i].off, chip->ll_region_wr[i].sz,
+			chip->ll_region_wr[i].vaddr, &chip->ll_region_wr[i].paddr);
 
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_wr[i].bar,
-			vsec_data.dt_wr[i].off, dw->dt_region_wr[i].sz,
-			dw->dt_region_wr[i].vaddr, &dw->dt_region_wr[i].paddr);
+			vsec_data.dt_wr[i].off, chip->dt_region_wr[i].sz,
+			chip->dt_region_wr[i].vaddr, &chip->dt_region_wr[i].paddr);
 	}
 
-	for (i = 0; i < dw->rd_ch_cnt; i++) {
+	for (i = 0; i < chip->rd_ch_cnt; i++) {
 		pci_dbg(pdev, "L. List:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.ll_rd[i].bar,
-			vsec_data.ll_rd[i].off, dw->ll_region_rd[i].sz,
-			dw->ll_region_rd[i].vaddr, &dw->ll_region_rd[i].paddr);
+			vsec_data.ll_rd[i].off, chip->ll_region_rd[i].sz,
+			chip->ll_region_rd[i].vaddr, &chip->ll_region_rd[i].paddr);
 
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, vsec_data.dt_rd[i].bar,
-			vsec_data.dt_rd[i].off, dw->dt_region_rd[i].sz,
-			dw->dt_region_rd[i].vaddr, &dw->dt_region_rd[i].paddr);
+			vsec_data.dt_rd[i].off, chip->dt_region_rd[i].sz,
+			chip->dt_region_rd[i].vaddr, &chip->dt_region_rd[i].paddr);
 	}
 
-	pci_dbg(pdev, "Nr. IRQs:\t%u\n", dw->nr_irqs);
+	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
 
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
@@ -345,10 +334,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		return -EPERM;
 	}
 
-	dw->irq = devm_kcalloc(dev, nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
-	if (!dw->irq)
-		return -ENOMEM;
-
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 043a4f3115fa..86967d390dfb 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -25,7 +25,7 @@ enum dw_edma_control {
 
 static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 {
-	return dw->rg_region.vaddr;
+	return dw->chip->rg_region.vaddr;
 }
 
 #define SET_32(dw, name, value)				\
@@ -96,7 +96,7 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 static inline struct dw_edma_v0_ch_regs __iomem *
 __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY)
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		return &(__dw_regs(dw)->type.legacy.ch);
 
 	if (dir == EDMA_DIR_WRITE)
@@ -108,7 +108,7 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
 static inline void writel_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u32 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -133,7 +133,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u32 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -169,7 +169,7 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -194,7 +194,7 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 {
 	u64 value;
 
-	if (dw->mf == EDMA_MF_EDMA_LEGACY) {
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
 		unsigned long flags;
 
@@ -256,7 +256,7 @@ u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 
 enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp;
 
 	tmp = FIELD_GET(EDMA_V0_CH_STATUS_MASK,
@@ -272,7 +272,7 @@ enum dma_status dw_edma_v0_core_ch_status(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id)));
@@ -280,7 +280,7 @@ void dw_edma_v0_core_clear_done_int(struct dw_edma_chan *chan)
 
 void dw_edma_v0_core_clear_abort_int(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 
 	SET_RW_32(dw, chan->dir, int_clear,
 		  FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id)));
@@ -357,7 +357,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
+	unsigned long flags;
 	u32 tmp;
 
 	dw_edma_v0_core_write_chunk(chunk);
@@ -365,7 +366,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	if (first) {
 		/* Enable engine */
 		SET_RW_32(dw, chan->dir, engine_en, BIT(0));
-		if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+		if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 			switch (chan->id) {
 			case 0:
 				SET_RW_COMPAT(dw, chan->dir, ch0_pwr_en,
@@ -402,6 +403,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			}
 		}
 		/* Interrupt unmask - done, abort */
+		raw_spin_lock_irqsave(&dw->lock, flags);
+
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
 		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
 		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
@@ -410,6 +413,9 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
 		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
 		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
+
+		raw_spin_unlock_irqrestore(&dw->lock, flags);
+
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
 			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
@@ -434,7 +440,7 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 {
-	struct dw_edma *dw = chan->chip->dw;
+	struct dw_edma *dw = chan->dw;
 	u32 tmp = 0;
 
 	/* MSI done addr - low, high */
@@ -504,12 +510,12 @@ int dw_edma_v0_core_device_config(struct dw_edma_chan *chan)
 }
 
 /* eDMA debugfs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
-	dw_edma_v0_debugfs_on(chip);
+	dw_edma_v0_debugfs_on(dw);
 }
 
-void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_core_debugfs_off(struct dw_edma *dw)
 {
-	dw_edma_v0_debugfs_off(chip);
+	dw_edma_v0_debugfs_off(dw);
 }
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
index 2afa626b8300..75aec6d31b21 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
@@ -22,7 +22,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *chan, enum dw_edma_dir dir)
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
 int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
 /* eDMA debug fs callbacks */
-void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
+void dw_edma_v0_core_debugfs_on(struct dw_edma *dw);
+void dw_edma_v0_core_debugfs_off(struct dw_edma *dw);
 
 #endif /* _DW_EDMA_V0_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
index 4b3bcffd15ef..b765adb96999 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
@@ -54,7 +54,7 @@ struct debugfs_entries {
 static int dw_edma_debugfs_u32_get(void *data, u64 *val)
 {
 	void __iomem *reg = (void __force __iomem *)data;
-	if (dw->mf == EDMA_MF_EDMA_LEGACY &&
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY &&
 	    reg >= (void __iomem *)&regs->type.legacy.ch) {
 		void __iomem *ptr = &regs->type.legacy.ch;
 		u32 viewport_sel = 0;
@@ -173,7 +173,7 @@ static void dw_edma_debugfs_regs_wr(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -242,7 +242,7 @@ static void dw_edma_debugfs_regs_rd(struct dentry *dir)
 	nr_entries = ARRAY_SIZE(debugfs_regs);
 	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dir);
 
-	if (dw->mf == EDMA_MF_HDMA_COMPAT) {
+	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
 		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
 		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
 					   regs_dir);
@@ -282,13 +282,13 @@ static void dw_edma_debugfs_regs(void)
 	dw_edma_debugfs_regs_rd(regs_dir);
 }
 
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_on(struct dw_edma *_dw)
 {
-	dw = chip->dw;
+	dw = _dw;
 	if (!dw)
 		return;
 
-	regs = dw->rg_region.vaddr;
+	regs = dw->chip->rg_region.vaddr;
 	if (!regs)
 		return;
 
@@ -296,16 +296,16 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
 	if (!dw->debugfs)
 		return;
 
-	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->mf);
+	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
 	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
 	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
 
 	dw_edma_debugfs_regs();
 }
 
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+void dw_edma_v0_debugfs_off(struct dw_edma *_dw)
 {
-	dw = chip->dw;
+	dw = _dw;
 	if (!dw)
 		return;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
index d0ff25a9ea5c..3391b86edf5a 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
@@ -12,14 +12,14 @@
 #include <linux/dma/edma.h>
 
 #ifdef CONFIG_DEBUG_FS
-void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
-void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
+void dw_edma_v0_debugfs_on(struct dw_edma *dw);
+void dw_edma_v0_debugfs_off(struct dw_edma *dw);
 #else
-static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
+static inline void dw_edma_v0_debugfs_on(struct dw_edma *dw)
 {
 }
 
-static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
+static inline void dw_edma_v0_debugfs_off(struct dw_edma *dw)
 {
 }
 #endif /* CONFIG_DEBUG_FS */
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7f621e96d3b8..dd4107ffa715 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -720,6 +720,9 @@ afu_ioctl_dma_map(struct dfl_feature_platform_data *pdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(pdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index db32f5b4a46c..f56142defd15 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -348,7 +348,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an input GPIO
 	 */
-	ret = pinctrl_gpio_direction_input(chip->base + pin);
+	ret = pinctrl_gpio_direction_input(chip, pin);
 	if (ret)
 		return ret;
 
@@ -368,7 +368,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an output GPIO
 	 */
-	ret = pinctrl_gpio_direction_output(chip->base + pin);
+	ret = pinctrl_gpio_direction_output(chip, pin);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index d9abe7093efd..e96c75ce84a6 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -266,7 +266,7 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	int ret;
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_input(chip->base + offset);
+		ret = pinctrl_gpio_direction_input(chip, offset);
 		if (ret)
 			return ret;
 	}
@@ -295,7 +295,7 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_output(chip->base + offset);
+		ret = pinctrl_gpio_direction_output(chip, offset);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index df2eefc1554a..6b70b61c0284 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -158,9 +158,9 @@ static int rockchip_gpio_set_direction(struct gpio_chip *chip,
 
 
 	if (input)
-		pinctrl_gpio_direction_input(bank->pin_base + offset);
+		pinctrl_gpio_direction_input(chip, offset);
 	else
-		pinctrl_gpio_direction_output(bank->pin_base + offset);
+		pinctrl_gpio_direction_output(chip, offset);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 	rockchip_gpio_writel_bit(bank, offset, data, bank->gpio_regs->port_ddr);
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ae769a29bf16..742e44beda44 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -174,18 +174,11 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip->base + offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl input direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_direction_output(struct gpio_chip *chip,
@@ -193,19 +186,12 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 				       int value)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
-	int ret;
 
 	tegra_gpio_set(chip, offset, value);
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip->base + offset);
-	if (ret < 0)
-		dev_err(tgi->dev,
-			"Failed to set pinctrl output direction of GPIO %d: %d",
-			 chip->base + offset, ret);
-
-	return ret;
+	return 0;
 }
 
 static int tegra_gpio_get_direction(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index c3014f5f0faa..c700d9db754e 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -117,7 +117,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
@@ -135,7 +135,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static void vf610_gpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f34a5d23a43b..07aa9f8de264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1236,7 +1236,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
 				  AMDGPU_FENCE_OWNER_KFD, false);
 	if (ret)
 		goto wait_pd_fail;
-	ret = dma_resv_reserve_shared(vm->root.bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(vm->root.bo,
@@ -2461,7 +2461,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 	 * Add process eviction fence to bo so they can
 	 * evict each other.
 	 */
-	ret = dma_resv_reserve_shared(gws_bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(gws_bo->tbo.base.resv, 1);
 	if (ret)
 		goto reserve_shared_fail;
 	amdgpu_bo_fence(gws_bo, &process_info->eviction_fence->base, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 13ca51ff8bd0..866d48a18bde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -278,6 +278,25 @@ static const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
 	.vm_ops = &amdgpu_gem_vm_ops,
 };
 
+static bool amdgpu_gem_are_domains_valid(u32 domains)
+{
+	u32 normal = AMDGPU_GEM_DOMAIN_CPU |
+		     AMDGPU_GEM_DOMAIN_GTT |
+		     AMDGPU_GEM_DOMAIN_VRAM;
+	/* Treat all non CPU/GTT/VRAM domains as special domains. */
+	u32 special = AMDGPU_GEM_DOMAIN_MASK & ~normal;
+	u32 normal_mask = domains & normal;
+	u32 special_mask = domains & special;
+
+	if (!special_mask)
+		return true;
+
+	if (normal_mask)
+		return false;
+
+	return !(special_mask & (special_mask - 1));
+}
+
 /*
  * GEM ioctls.
  */
@@ -309,6 +328,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* reject invalid gem domains */
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
+	if (!amdgpu_gem_are_domains_valid(args->in.domains))
+		return -EINVAL;
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a0d18d3417ae..6c541fb35a4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -472,6 +472,15 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (new_mem->mem_type == TTM_PL_TT ||
 	    new_mem->mem_type == AMDGPU_PL_PREEMPT) {
+		if (old_mem && (old_mem->mem_type == TTM_PL_TT ||
+				old_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+			r = ttm_bo_wait_ctx(bo, ctx);
+			if (r)
+				return r;
+
+			amdgpu_ttm_backend_unbind(bo->bdev, bo->ttm);
+		}
+
 		r = amdgpu_ttm_backend_bind(bo->bdev, bo->ttm, new_mem);
 		if (r)
 			return r;
@@ -506,6 +515,14 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 		ttm_bo_assign_mem(bo, new_mem);
 		goto out;
 	}
+	if ((old_mem->mem_type == TTM_PL_TT ||
+	     old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
+	    (new_mem->mem_type == TTM_PL_TT ||
+	     new_mem->mem_type == AMDGPU_PL_PREEMPT)) {
+		ttm_resource_free(bo, &bo->resource);
+		ttm_bo_assign_mem(bo, new_mem);
+		goto out;
+	}
 
 	if (old_mem->mem_type == AMDGPU_PL_GDS ||
 	    old_mem->mem_type == AMDGPU_PL_GWS ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 1935ba1eb659..909ad5dbe67a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -578,8 +578,8 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned min_ctx_size = ~0;
 
-	/* Reject invalid dimensions to prevent division by zero */
-	if (width < 16 || height < 16) {
+	/* Reject invalid dimensions */
+	if (width < 16 || height < 16 || width > 4096 || height > 4096) {
 		dev_WARN_ONCE(adev->dev, 1,
 			      "Invalid UVD decoding dimensions (%dx%d)!\n",
 			      width, height);
@@ -726,6 +726,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		image_size = ALIGN(image_size, 256);
 
 		num_dpb_buffer = (le32_to_cpu(msg[59]) & 0xff) + 2;
+		if (num_dpb_buffer > 17)
+			return -EINVAL;
+
 		min_dpb_size = image_size * num_dpb_buffer;
 		min_ctx_size = ((width + 255) / 16) * ((height + 255) / 16)
 					   * 16 * num_dpb_buffer + 52 * 1024;
@@ -736,7 +739,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		return -EINVAL;
 	}
 
-	if (width > pitch) {
+	if (width > pitch || pitch > 4096) {
 		DRM_ERROR("Invalid UVD decoding target pitch!\n");
 		return -EINVAL;
 	}
@@ -748,7 +751,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	}
 
 	buf_sizes[0x1] = dpb_size;
-	buf_sizes[0x2] = image_size;
+	buf_sizes[0x2] = (pitch * height) * 3 / 2;
 	buf_sizes[0x4] = min_ctx_size;
 	/* store image width to adjust nb memory pstate */
 	adev->uvd.decode_image_width = width;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 77997a7ca534..256f2e5399ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3008,7 +3008,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (r)
 		goto error_free_root;
 
-	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;
 
@@ -3459,7 +3459,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 8fb5df7181e0..96e13896ad1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -871,6 +871,23 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	amdgpu_ring_write(ring, ib->length_dw);
 }
 
+static void vce_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+			u64 seq, unsigned flags)
+{
+	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	amdgpu_ring_write(ring, VCE_CMD_FENCE);
+	amdgpu_ring_write(ring, addr);
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, seq);
+	amdgpu_ring_write(ring, VCE_CMD_TRAP);
+}
+
+static void vce_v3_0_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, VCE_CMD_END);
+}
+
 static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 				   unsigned int vmid, uint64_t pd_addr)
 {
@@ -880,7 +897,6 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
 	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
 static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -950,17 +966,19 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.set_wptr = vce_v3_0_ring_set_wptr,
 	.parse_cs = amdgpu_vce_ring_parse_cs_vm,
 	.emit_frame_size =
-		6 + /* vce_v3_0_emit_vm_flush */
+		5 + /* vce_v3_0_emit_vm_flush */
 		4 + /* vce_v3_0_emit_pipeline_sync */
-		6 + 6, /* amdgpu_vce_ring_emit_fence x2 vm fence */
+		5 + 5 + /* vce_v3_0_ring_emit_fence x2 vm fence */
+		1, /* vce_v3_0_ring_insert_end */
 	.emit_ib_size = 5, /* vce_v3_0_ring_emit_ib */
 	.emit_ib = vce_v3_0_ring_emit_ib,
 	.emit_vm_flush = vce_v3_0_emit_vm_flush,
 	.emit_pipeline_sync = vce_v3_0_emit_pipeline_sync,
-	.emit_fence = amdgpu_vce_ring_emit_fence,
+	.emit_fence = vce_v3_0_ring_emit_fence,
 	.test_ring = amdgpu_vce_ring_test_ring,
 	.test_ib = amdgpu_vce_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vce_v3_0_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vce_ring_begin_use,
 	.end_use = amdgpu_vce_ring_end_use,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d21bebfa884e..ff776944793a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -512,7 +512,7 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
 		goto reserve_bo_failed;
 	}
 
-	r = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve bo\n", r);
 		amdgpu_bo_unreserve(bo);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 23f3cd9f2e8b..d8b0c13fc42a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1804,18 +1804,16 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
+	mutex_lock(&adev->pm.mutex);
 	if (adev->powerplay.pp_funcs->get_gpu_metrics)
 		size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
 
-	if (size <= 0)
-		goto out;
-
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, gpu_metrics, size);
+	if (size > 0) {
+		size = min_t(ssize_t, size, PAGE_SIZE - 1);
+		memcpy(buf, gpu_metrics, size);
+	}
+	mutex_unlock(&adev->pm.mutex);
 
-out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index fff2038e9803..208e5a152ab7 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2594,7 +2594,7 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
 /**
  * drm_mode_get_tile_group - get a reference to an existing tile group
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Use the unique bytes to get a reference to an existing tile group.
  *
@@ -2602,14 +2602,14 @@ EXPORT_SYMBOL(drm_mode_put_tile_group);
  * tile group or NULL if not found.
  */
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8])
+					       const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int id;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
 	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
-		if (!memcmp(tg->group_data, topology, 8)) {
+		if (!memcmp(tg->group_data, topology_id, sizeof(tg->group_data))) {
 			if (!kref_get_unless_zero(&tg->refcount))
 				tg = NULL;
 			mutex_unlock(&dev->mode_config.idr_mutex);
@@ -2624,7 +2624,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
 /**
  * drm_mode_create_tile_group - create a tile group from a displayid description
  * @dev: DRM device
- * @topology: 8-bytes unique per monitor.
+ * @topology_id: 9-byte unique ID per monitor.
  *
  * Create a tile group for the unique monitor, and get a unique
  * identifier for the tile group.
@@ -2633,7 +2633,7 @@ EXPORT_SYMBOL(drm_mode_get_tile_group);
  * new tile group or NULL.
  */
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8])
+						  const char topology_id[9])
 {
 	struct drm_tile_group *tg;
 	int ret;
@@ -2643,7 +2643,7 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 		return NULL;
 
 	kref_init(&tg->refcount);
-	memcpy(tg->group_data, topology, 8);
+	memcpy(tg->group_data, topology_id, sizeof(tg->group_data));
 	tg->dev = dev;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 70be5719e403..2753274d6750 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -779,6 +779,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 {
 	u8 crc4;
 
+	/* curchunk_len must be >= 1 (min 1 CRC byte) and fit in chunk[] */
+	if (!msg->curchunk_len ||
+	    msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
+	    msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg->chunk))
+		return false;
+
 	memcpy(&msg->chunk[msg->curchunk_idx], replybuf, replybuflen);
 	msg->curchunk_idx += replybuflen;
 
@@ -789,6 +795,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
 				       msg->chunk,  msg->curchunk_len, false);
+		/* Guard against accumulated msg[] overflow */
+		if (msg->curlen + msg->curchunk_len - 1 > ARRAY_SIZE(msg->msg))
+			return false;
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
@@ -861,7 +870,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -897,7 +906,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
@@ -913,16 +924,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	repmsg->u.path_resources.port_number = (raw->msg[idx] >> 4) & 0xf;
 	repmsg->u.path_resources.fec_capable = raw->msg[idx] & 0x1;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.full_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.avail_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n", idx, raw->curlen);
@@ -940,12 +948,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 		goto fail_len;
 	repmsg->u.allocate_payload.vcpi = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -959,12 +964,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 
 	repmsg->u.query_payload.port_number = (raw->msg[idx] >> 4) & 0xf;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
index 90488ab8c6d8..f8c0ab3eabf4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
@@ -180,7 +180,7 @@ static int submit_fence_sync(struct etnaviv_gem_submit *submit)
 		struct dma_resv *robj = bo->obj->base.resv;
 
 		if (!(bo->flags & ETNA_SUBMIT_BO_WRITE)) {
-			ret = dma_resv_reserve_shared(robj, 1);
+			ret = dma_resv_reserve_fences(robj, 1);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index ebc2e32aec0b..98d4d977cabe 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -89,6 +89,9 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 		if (!enforce_type0 && !intel_streams_type1_capable(connector))
 			enforce_type0 = true;
 
+		if (drm_WARN_ON(&i915->drm, data->k >= INTEL_NUM_PIPES(i915)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id = intel_conn_to_vcpi(connector);
 		data->k++;
 
@@ -98,7 +101,7 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(&i915->drm, data->k > INTEL_NUM_PIPES(i915) || data->k == 0))
+	if (drm_WARN_ON(&i915->drm, !data->k))
 		return -EINVAL;
 
 	/*
@@ -1642,9 +1645,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(&dev_priv->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(&dev_priv->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index c335b1dbafcf..25abc437b619 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -26,6 +26,10 @@ bool intel_vrr_is_capable(struct drm_connector *connector)
 	 * EDID monitor range also should be atleast 10 for reasonable
 	 * Adaptive Sync or Variable Refresh Rate end user experience.
 	 */
+	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
+	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
+		return false;
+
 	return HAS_VRR(i915) &&
 		drm_dp_sink_can_do_video_without_timing_msa(intel_dp->dpcd) &&
 		info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 0d480867fc0c..86e8f48e352b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -958,7 +958,7 @@ static int eb_validate_vmas(struct i915_execbuffer *eb)
 		}
 
 		if (!(ev->flags & EXEC_OBJECT_WRITE)) {
-			err = dma_resv_reserve_shared(vma->resv, 1);
+			err = dma_resv_reserve_fences(vma->resv, 1);
 			if (err)
 				return err;
 		}
@@ -2160,7 +2160,7 @@ static int eb_parse(struct i915_execbuffer *eb)
 		goto err_trampoline;
 	}
 
-	err = dma_resv_reserve_shared(shadow->resv, 1);
+	err = dma_resv_reserve_fences(shadow->resv, 1);
 	if (err)
 		goto err_trampoline;
 
diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index d9ca42203517..2c329ff29119 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -1278,7 +1278,7 @@ int i915_vma_move_to_active(struct i915_vma *vma,
 		obj->read_domains = 0;
 	} else {
 		if (!(flags & __EXEC_OBJECT_NO_RESERVE)) {
-			err = dma_resv_reserve_shared(vma->resv, 1);
+			err = dma_resv_reserve_fences(vma->resv, 1);
 			if (unlikely(err))
 				return err;
 		}
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 65c4327b6d10..a45970245014 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -263,7 +263,7 @@ static int lima_gem_sync_bo(struct lima_sched_task *task, struct lima_bo *bo,
 	int err = 0;
 
 	if (!write) {
-		err = dma_resv_reserve_shared(lima_bo_resv(bo), 1);
+		err = dma_resv_reserve_fences(lima_bo_resv(bo), 1);
 		if (err)
 			return err;
 	}
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 2ffb2ca88ffe..09ca040c811b 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -349,7 +349,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
 			 * strange place to call it.  OTOH this is a
 			 * convenient can-fail point to hook it in.
 			 */
-			ret = dma_resv_reserve_shared(obj->resv, 1);
+			ret = dma_resv_reserve_fences(obj->resv, 1);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
index af2b71e3058c..19daebaef0aa 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -349,7 +349,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct nouveau_channel *chan, bool e
 	int ret = 0, i;
 
 	if (!exclusive) {
-		ret = dma_resv_reserve_shared(resv, 1);
+		ret = dma_resv_reserve_fences(resv, 1);
 
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b19f2f00b215..0abffbe3c1fa 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -200,7 +200,7 @@ static int qxl_release_validate_bo(struct qxl_bo *bo)
 			return ret;
 	}
 
-	ret = dma_resv_reserve_shared(bo->tbo.base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->tbo.base.resv, 1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 0e14907f2043..57a930cb53f5 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -72,6 +72,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index f2fc8ef99139..c38b4d5d6a14 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -831,7 +831,7 @@ static int radeon_vm_update_ptes(struct radeon_device *rdev,
 		int r;
 
 		radeon_sync_resv(rdev, &ib->sync, pt->tbo.base.resv, true);
-		r = dma_resv_reserve_shared(pt->tbo.base.resv, 1);
+		r = dma_resv_reserve_fences(pt->tbo.base.resv, 1);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 6e35c7951dfb..daafaea41196 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -221,7 +221,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
-	unsigned long offset;
 	struct fb_info *info;
 	struct tegra_bo *bo;
 	size_t size;
@@ -267,9 +266,6 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, helper, sizes);
 
-	offset = info->var.xoffset * bytes_per_pixel +
-		 info->var.yoffset * fb->pitches[0];
-
 	if (bo->pages) {
 		bo->vaddr = vmap(bo->pages, bo->num_pages, VM_MAP,
 				 pgprot_writecombine(PAGE_KERNEL));
@@ -281,9 +277,9 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	}
 
 	drm->mode_config.fb_base = (resource_size_t)bo->iova;
-	info->screen_base = (void __iomem *)bo->vaddr + offset;
+	info->screen_base = (void __iomem *)bo->vaddr;
 	info->screen_size = size;
-	info->fix.smem_start = (unsigned long)(bo->iova + offset);
+	info->fix.smem_start = (unsigned long)(bo->iova);
 	info->fix.smem_len = size;
 
 	return 0;
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 391ed462f7fb..a92c2e8da504 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -767,7 +767,7 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 
 	dma_resv_add_shared_fence(bo->base.resv, fence);
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret)) {
 		dma_fence_put(fence);
 		return ret;
@@ -826,7 +826,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 	bool type_found = false;
 	int i, ret;
 
-	ret = dma_resv_reserve_shared(bo->base.resv, 1);
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index 071c48d672c6..f04db8672882 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -104,7 +104,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 			if (!entry->num_shared)
 				continue;
 
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 			if (!ret)
 				continue;
@@ -121,7 +121,7 @@ int ttm_eu_reserve_buffers(struct ww_acquire_ctx *ticket,
 		}
 
 		if (!ret && entry->num_shared)
-			ret = dma_resv_reserve_shared(bo->base.resv,
+			ret = dma_resv_reserve_fences(bo->base.resv,
 								entry->num_shared);
 
 		if (unlikely(ret != 0)) {
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index a52736cf1f7a..ff77aee38977 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -644,7 +644,7 @@ vc4_lock_bo_reservations(struct drm_device *dev,
 	for (i = 0; i < exec->bo_count; i++) {
 		bo = &exec->bo[i]->base;
 
-		ret = dma_resv_reserve_shared(bo->resv, 1);
+		ret = dma_resv_reserve_fences(bo->resv, 1);
 		if (ret) {
 			vc4_unlock_bo_reservations(dev, exec, acquire_ctx);
 			return ret;
diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
index 539cf4ee5767..eccf778d6950 100644
--- a/drivers/gpu/drm/vgem/vgem_fence.c
+++ b/drivers/gpu/drm/vgem/vgem_fence.c
@@ -161,7 +161,7 @@ int vgem_fence_attach_ioctl(struct drm_device *dev,
 	dma_resv_lock(resv, NULL);
 	if (arg->flags & VGEM_FENCE_WRITE)
 		dma_resv_add_excl_fence(resv, fence);
-	else if ((ret = dma_resv_reserve_shared(resv, 1)) == 0)
+	else if ((ret = dma_resv_reserve_fences(resv, 1)) == 0)
 		dma_resv_add_shared_fence(resv, fence);
 	dma_resv_unlock(resv);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d4e610a44e12..1e7f16864225 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -288,6 +288,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 48d3c9955f0d..ce215f6a812c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -214,6 +214,7 @@ void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 {
+	unsigned int i;
 	int ret;
 
 	if (objs->nents == 1) {
@@ -222,9 +223,36 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
 						&objs->ticket);
 	}
+	if (ret)
+		return ret;
+
+	for (i = 0; i < objs->nents; ++i) {
+		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
+		if (ret) {
+			virtio_gpu_array_unlock_resv(objs);
+			return ret;
+		}
+	}
 	return ret;
 }
 
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents != 1)
+		return -EINVAL;
+
+	dma_resv_lock(objs->objs[0]->resv, NULL);
+
+	ret = dma_resv_reserve_fences(objs->objs[0]->resv, 1);
+	if (ret) {
+		virtio_gpu_array_unlock_resv(objs);
+		return ret;
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 7e8cbcee1722..37cfd8115101 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -147,7 +147,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, objs, vgfb->fence);
 		virtio_gpu_notify(vgdev);
@@ -314,7 +317,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 19a196b48a38..5383632569b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -329,7 +329,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		if (fence && vbuf->objs)
 			virtio_gpu_array_unlock_resv(vbuf->objs);
 		free_vbuf(vgdev, vbuf);
-		return -1;
+		return -ENODEV;
 	}
 
 	if (vgdev->has_indirect)
@@ -393,7 +393,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
-				return -1;
+				return -ENOMEM;
 			}
 
 			elemcnt += sg_ents;
@@ -727,8 +727,9 @@ static int virtio_get_edid_block(void *data, u8 *buf,
 	struct virtio_gpu_resp_edid *resp = data;
 	size_t start = block * EDID_LENGTH;
 
-	if (start + len > le32_to_cpu(resp->size))
-		return -1;
+	if (start + len > le32_to_cpu(resp->size) ||
+	    start + len > sizeof(resp->edid))
+		return -EINVAL;
 	memcpy(buf, resp->edid + start, len);
 	return 0;
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index 17a98db00017..f6bf164c1e8e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -482,6 +482,10 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 	vmw_bo_unreference(&old_buf);
 	res->id = vcotbl->type;
 
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
+	if (unlikely(ret))
+		goto out_wait;
+
 	/* Release the pin acquired in vmw_bo_init */
 	ttm_bo_unpin(bo);
 
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 299dbcd4c829..fc5b29cd918e 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -821,7 +821,16 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
 	}
 
 	if (!time_left && !iproc_i2c->xfer_is_done) {
-		dev_err(iproc_i2c->device, "transaction timed out\n");
+		/*
+		 * The controller may fail to clear START_BUSY after a timeout,
+		 * reset the controller to recover in that case.
+		 */
+		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
+		       BIT(M_CMD_START_BUSY_SHIFT))) {
+			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+			bcm_iproc_i2c_init(iproc_i2c);
+			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+		}
 
 		/* flush both TX/RX FIFOs */
 		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index e9d07323c604..56447ba98e78 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -874,13 +874,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 906cfcd4d6e2..cda7662e35bd 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -832,14 +832,12 @@ static void i2c_imx_slave_init(struct imx_i2c_struct *i2c_imx)
 static int i2c_imx_reg_slave(struct i2c_client *client)
 {
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(client->adapter);
+	unsigned long flags;
 	int ret;
 
 	if (i2c_imx->slave)
 		return -EBUSY;
 
-	i2c_imx->slave = client;
-	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
-
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
@@ -847,6 +845,11 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 		return ret;
 	}
 
+	spin_lock_irqsave(&i2c_imx->slave_lock, flags);
+	i2c_imx->slave = client;
+	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
+	spin_unlock_irqrestore(&i2c_imx->slave_lock, flags);
+
 	i2c_imx_slave_init(i2c_imx);
 
 	return 0;
@@ -979,6 +982,43 @@ static int i2c_imx_dma_write(struct imx_i2c_struct *i2c_imx,
 	return i2c_imx_acked(i2c_imx);
 }
 
+static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
+				struct i2c_msg *msgs, bool atomic,
+				bool use_dma)
+{
+	int result;
+	unsigned int temp = 0;
+
+	/* write slave address */
+	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
+	result = i2c_imx_trx_complete(i2c_imx, atomic);
+	if (result)
+		return result;
+	result = i2c_imx_acked(i2c_imx);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
+
+	/* setup bus to read data */
+	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+	temp &= ~I2CR_MTX;
+
+	/*
+	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
+	 * length is unknown
+	 */
+	if (msgs->len - 1)
+		temp &= ~I2CR_TXAK;
+	if (use_dma)
+		temp |= I2CR_DMAEN;
+
+	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
+
+	return 0;
+}
+
 static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 			struct i2c_msg *msgs, bool is_lastmsg)
 {
@@ -989,6 +1029,11 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	struct imx_i2c_dma *dma = i2c_imx->dma;
 	struct device *dev = &i2c_imx->adapter.dev;
 
+	result = i2c_imx_prepare_read(i2c_imx, msgs, false, true);
+	if (result)
+		return result;
+
+	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
 	dma->chan_using = dma->chan_rx;
 	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
@@ -1099,50 +1144,25 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 	return 0;
 }
 
+static int i2c_imx_atomic_write(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs)
+{
+	return i2c_imx_write(i2c_imx, msgs, true);
+}
+
 static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			bool is_lastmsg, bool atomic)
 {
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
-	int use_dma = i2c_imx->dma && msgs->flags & I2C_M_DMA_SAFE &&
-		msgs->len >= DMA_THRESHOLD && !block_data;
+	int block_err = 0;
 
-	dev_dbg(&i2c_imx->adapter.dev,
-		"<%s> write slave address: addr=0x%x\n",
-		__func__, i2c_8bit_addr_from_msg(msgs));
-
-	/* write slave address */
-	imx_i2c_write_reg(i2c_8bit_addr_from_msg(msgs), i2c_imx, IMX_I2C_I2DR);
-	result = i2c_imx_trx_complete(i2c_imx, atomic);
-	if (result)
-		return result;
-	result = i2c_imx_acked(i2c_imx);
+	result = i2c_imx_prepare_read(i2c_imx, msgs, atomic, false);
 	if (result)
 		return result;
 
-	dev_dbg(&i2c_imx->adapter.dev, "<%s> setup bus\n", __func__);
-
-	/* setup bus to read data */
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-	temp &= ~I2CR_MTX;
-
-	/*
-	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
-	 * length is unknown
-	 */
-	if ((msgs->len - 1) || block_data)
-		temp &= ~I2CR_TXAK;
-	if (use_dma)
-		temp |= I2CR_DMAEN;
-	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
-	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
-
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
-	if (use_dma)
-		return i2c_imx_dma_read(i2c_imx, msgs, is_lastmsg);
-
 	/* read data */
 	for (i = 0; i < msgs->len; i++) {
 		u8 len = 0;
@@ -1157,8 +1177,20 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 		 */
 		if ((!i) && block_data) {
 			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
-			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
-				return -EPROTO;
+			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
+				/*
+				 * SMBus 3.1 6.5.7: support count byte of 0.
+				 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
+				 */
+				if (len > I2C_SMBUS_BLOCK_MAX)
+					block_err = -EPROTO;
+				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+				temp |= I2CR_TXAK;
+				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+				msgs->buf[0] = 0;
+				msgs->len = 2;
+				continue;
+			}
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> read length: 0x%X\n",
 				__func__, len);
@@ -1206,7 +1238,13 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
 			"<%s> read byte: B%d=0x%X\n",
 			__func__, i, msgs->buf[i]);
 	}
-	return 0;
+	return block_err;
+}
+
+static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs,
+			       bool is_lastmsg)
+{
+	return i2c_imx_read(i2c_imx, msgs, is_lastmsg, true);
 }
 
 static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
@@ -1216,6 +1254,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 	int result;
 	bool is_lastmsg = false;
 	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
+	int use_dma = 0;
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx, atomic);
@@ -1268,15 +1307,25 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
 			(temp & I2SR_SRW ? 1 : 0), (temp & I2SR_IIF ? 1 : 0),
 			(temp & I2SR_RXAK ? 1 : 0));
 #endif
+
+		use_dma = i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
+			msgs[i].flags & I2C_M_DMA_SAFE;
 		if (msgs[i].flags & I2C_M_RD) {
-			result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, atomic);
+			int block_data = msgs->flags & I2C_M_RECV_LEN;
+
+			if (atomic)
+				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
+			else if (use_dma && !block_data)
+				result = i2c_imx_dma_read(i2c_imx, &msgs[i], is_lastmsg);
+			else
+				result = i2c_imx_read(i2c_imx, &msgs[i], is_lastmsg, false);
 		} else {
-			if (!atomic &&
-			    i2c_imx->dma && msgs[i].len >= DMA_THRESHOLD &&
-				msgs[i].flags & I2C_M_DMA_SAFE)
+			if (atomic)
+				result = i2c_imx_atomic_write(i2c_imx, &msgs[i]);
+			else if (use_dma)
 				result = i2c_imx_dma_write(i2c_imx, &msgs[i]);
 			else
-				result = i2c_imx_write(i2c_imx, &msgs[i], atomic);
+				result = i2c_imx_write(i2c_imx, &msgs[i], false);
 		}
 		if (result)
 			goto fail0;
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 9f7ba41a947b..b9fd6d3be99f 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -161,6 +161,9 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_X,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_Y,
@@ -176,6 +179,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_WHEEL,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
@@ -187,6 +193,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x02:	/* status report */
+		if (len < 2)
+			break;
+
 		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
 		input_sync(dev);
 
@@ -206,7 +215,7 @@ void iforce_process_packet(struct iforce *iforce,
 			}
 		}
 
-		for (j = 3; j < len; j += 2)
+		for (j = 3; j + sizeof(u16) <= len; j += sizeof(u16))
 			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index cba92bd590a8..927c1378b21a 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -159,6 +159,9 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
+	if (!urb->actual_length)
+		goto exit;
+
 	iforce_process_packet(iforce, iforce_usb->data_in[0],
 			      iforce_usb->data_in + 1, urb->actual_length - 1);
 
diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index a32656064f39..cde33a2ca696 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -366,6 +366,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
 		return err;
 	}
 
+	spi_set_drvdata(spi, pad);
 	pm_runtime_enable(&spi->dev);
 
 	return 0;
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index bc7f16e0ac83..d8b7645e8d4e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1954,6 +1954,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Book Pro 14 (TM2424) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6b1d8f92a9bb..8a8f15b19008 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -964,9 +964,10 @@ static int ims_pcu_handle_firmware_update(struct ims_pcu *pcu,
 	return retval;
 }
 
-static void ims_pcu_process_async_firmware(const struct firmware *fw,
+static void ims_pcu_process_async_firmware(const struct firmware *_fw,
 					   void *context)
 {
+	const struct firmware *fw __free(firmware) = _fw;
 	struct ims_pcu *pcu = context;
 	int error;
 
@@ -987,8 +988,6 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 	ims_pcu_handle_firmware_update(pcu, fw);
 	mutex_unlock(&pcu->cmd_mutex);
 
-	release_firmware(fw);
-
 out:
 	complete(&pcu->async_firmware_done);
 }
diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index c74b99077d16..2ca5ac1836dd 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -197,7 +197,7 @@ static void focaltech_process_rel_packet(struct psmouse *psmouse,
 {
 	struct focaltech_data *priv = psmouse->private;
 	struct focaltech_hw_state *state = &priv->state;
-	int finger1, finger2;
+	unsigned int finger1, finger2;
 
 	state->pressed = packet[0] >> 7;
 	finger1 = ((packet[0] >> 4) & 0x7) - 1;
diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index e903f0fa3d4e..cc70d6c3b7b6 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -104,7 +104,9 @@ struct f54_data {
 
 	enum rmi_f54_report_type report_type;
 	u8 *report_data;
+	size_t max_report_size;
 	int report_size;
+	int report_error;
 
 	bool is_busy;
 	struct mutex status_mutex;
@@ -339,6 +341,12 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		mutex_lock(&f54->data_mutex);
 	}
 
+	if (f54->report_error) {
+		dev_err(&f54->fn->dev, "Error acquiring report: %d\n", f54->report_error);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	ptr = vb2_plane_vaddr(vb, 0);
 	if (!ptr) {
 		dev_err(&f54->fn->dev, "Error acquiring frame ptr\n");
@@ -446,7 +454,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
 static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigned int i)
 {
-	return rmi_f54_set_input(video_drvdata(file), i);
+	struct f54_data *f54 = video_drvdata(file);
+
+	if (vb2_is_busy(&f54->queue))
+		return -EBUSY;
+
+	return rmi_f54_set_input(f54, i);
 }
 
 static int rmi_f54_vidioc_g_input(struct file *file, void *priv,
@@ -547,7 +560,14 @@ static void rmi_f54_work(struct work_struct *work)
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
 				f54->report_type);
 		error = -EINVAL;
-		goto error;     /* retry won't help */
+		goto out;     /* retry won't help */
+	}
+
+	if (report_size > f54->max_report_size) {
+		dev_err(&fn->dev, "Report size %d exceeds buffer size %zu\n",
+			report_size, f54->max_report_size);
+		error = -EINVAL;
+		goto out;
 	}
 
 	/*
@@ -558,7 +578,7 @@ static void rmi_f54_work(struct work_struct *work)
 			 &command);
 	if (error) {
 		dev_err(&fn->dev, "Failed to read back command\n");
-		goto error;
+		goto out;
 	}
 	if (command & F54_GET_REPORT) {
 		if (time_after(jiffies, f54->timeout)) {
@@ -566,7 +586,7 @@ static void rmi_f54_work(struct work_struct *work)
 			error = -ETIMEDOUT;
 		}
 		report_size = 0;
-		goto error;
+		goto out;
 	}
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Get report command completed, reading data\n");
@@ -581,7 +601,7 @@ static void rmi_f54_work(struct work_struct *work)
 					fifo, sizeof(fifo));
 		if (error) {
 			dev_err(&fn->dev, "Failed to set fifo start offset\n");
-			goto abort;
+			goto out;
 		}
 
 		error = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr +
@@ -590,16 +610,17 @@ static void rmi_f54_work(struct work_struct *work)
 		if (error) {
 			dev_err(&fn->dev, "%s: read [%d bytes] returned %d\n",
 				__func__, size, error);
-			goto abort;
+			goto out;
 		}
 	}
 
-abort:
-	f54->report_size = error ? 0 : report_size;
-error:
+out:
 	if (error)
 		report_size = 0;
 
+	f54->report_size = report_size;
+	f54->report_error = error;
+
 	if (report_size == 0 && !error) {
 		queue_delayed_work(f54->workqueue, &f54->work,
 				   msecs_to_jiffies(1));
@@ -680,8 +701,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
 	rx = f54->num_rx_electrodes;
 	tx = f54->num_tx_electrodes;
-	f54->report_data = devm_kzalloc(&fn->dev,
-					array3_size(tx, rx, sizeof(u16)),
+	f54->max_report_size = array3_size(tx, rx, sizeof(u16));
+	f54->report_data = devm_kzalloc(&fn->dev, f54->max_report_size,
 					GFP_KERNEL);
 	if (f54->report_data == NULL)
 		return -ENOMEM;
diff --git a/drivers/input/rmi4/rmi_f55.c b/drivers/input/rmi4/rmi_f55.c
index 488adaca4dd0..a0877d32a914 100644
--- a/drivers/input/rmi4/rmi_f55.c
+++ b/drivers/input/rmi4/rmi_f55.c
@@ -54,10 +54,10 @@ static int rmi_f55_detect(struct rmi_function *fn)
 	f55->num_tx_electrodes = f55->qry[F55_NUM_TX_OFFSET];
 
 	f55->cfg_num_rx_electrodes = f55->num_rx_electrodes;
-	f55->cfg_num_tx_electrodes = f55->num_rx_electrodes;
+	f55->cfg_num_tx_electrodes = f55->num_tx_electrodes;
 
 	drv_data->num_rx_electrodes = f55->cfg_num_rx_electrodes;
-	drv_data->num_tx_electrodes = f55->cfg_num_rx_electrodes;
+	drv_data->num_tx_electrodes = f55->cfg_num_tx_electrodes;
 
 	if (f55->qry[F55_PHYS_CHAR_OFFSET] & F55_CAP_SENSOR_ASSIGN) {
 		int i, total;
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 4222b4ada3c0..8da5181fd007 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -196,7 +196,9 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	struct mms114_data *data = dev_id;
 	struct input_dev *input_dev = data->input_dev;
 	struct mms114_touch touch[MMS114_MAX_TOUCH];
+	struct mms114_touch *t;
 	int packet_size;
+	int event_size;
 	int touch_size;
 	int index;
 	int error;
@@ -212,19 +214,30 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	if (packet_size > sizeof(touch)) {
+		dev_err(&data->client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
-		touch_size = packet_size / MMS136_EVENT_SIZE;
+		event_size = MMS136_EVENT_SIZE;
 	else
-		touch_size = packet_size / MMS114_EVENT_SIZE;
+		event_size = MMS114_EVENT_SIZE;
+
+	touch_size = packet_size / event_size;
 
 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
 			(u8 *)touch);
 	if (error < 0)
 		goto out;
 
-	for (index = 0; index < touch_size; index++)
-		mms114_process_mt(data, touch + index);
+	for (index = 0; index < touch_size; index++) {
+		t = (struct mms114_touch *)((u8 *)touch + index * event_size);
+
+		mms114_process_mt(data, t);
+	}
 
 	input_mt_report_pointer_emulation(data->input_dev, true);
 	input_sync(data->input_dev);
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 12f2562b0141..3ab20b2a54e2 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -725,21 +725,13 @@ static int sur40_probe(struct usb_interface *interface,
 		goto err_free_input;
 	}
 
-	/* register the polled input device */
-	error = input_register_device(input);
-	if (error) {
-		dev_err(&interface->dev,
-			"Unable to register polled input device.");
-		goto err_free_buffer;
-	}
-
 	/* register the video master device */
 	snprintf(sur40->v4l2.name, sizeof(sur40->v4l2.name), "%s", DRIVER_LONG);
 	error = v4l2_device_register(sur40->dev, &sur40->v4l2);
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video master device.");
-		goto err_unreg_v4l2;
+		goto err_free_buffer;
 	}
 
 	/* initialize the lock and subdevice */
@@ -795,6 +787,14 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video subdevice.");
+		goto err_free_ctrl;
+	}
+
+	/* register the polled input device */
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&interface->dev,
+			"Unable to register polled input device.");
 		goto err_unreg_video;
 	}
 
@@ -806,6 +806,8 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_free_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
@@ -823,11 +825,12 @@ static void sur40_disconnect(struct usb_interface *interface)
 {
 	struct sur40_state *sur40 = usb_get_intfdata(interface);
 
+	input_unregister_device(sur40->input);
+
 	v4l2_ctrl_handler_free(&sur40->hdl);
 	video_unregister_device(&sur40->vdev);
 	v4l2_device_unregister(&sur40->v4l2);
 
-	input_unregister_device(sur40->input);
 	kfree(sur40->bulk_in_buffer);
 	kfree(sur40);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d3a11be8d1dd..b4e4f21fe2be 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1284,7 +1284,8 @@ static void __domain_flush_pages(struct protection_domain *domain,
 static void domain_flush_pages(struct protection_domain *domain,
 			       u64 address, size_t size, int pde)
 {
-	if (likely(!amd_iommu_np_cache)) {
+	if (likely(!amd_iommu_np_cache) ||
+		size >= (1ULL<<52)) {
 		__domain_flush_pages(domain, address, size, pde);
 		return;
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index cfc3e82848d3..cebffb0b5a1a 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1474,10 +1474,6 @@ static int dm_integrity_rw_tag(struct dm_integrity_c *ic, unsigned char *tag, se
 			*metadata_offset = 0;
 		}
 
-		if (unlikely(!is_power_of_2(ic->tag_size))) {
-			hash_offset = (hash_offset + to_copy) % ic->tag_size;
-		}
-
 		total_size -= to_copy;
 	} while (unlikely(total_size));
 
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index b24a475a6600..d92eae527830 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -217,14 +217,16 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	char *envp[] = { verity_env, NULL };
 	const char *type_str = "";
 	struct mapped_device *md = dm_table_get_md(v->ti->table);
+	int ce;
 
 	/* Corruption should be visible in device status in all modes */
 	v->hash_failed = 1;
 
-	if (v->corrupted_errs >= DM_VERITY_MAX_CORRUPTED_ERRS)
-		goto out;
-
-	v->corrupted_errs++;
+	ce = atomic_read(&v->corrupted_errs);
+	do {
+		if (ce >= DM_VERITY_MAX_CORRUPTED_ERRS)
+			goto out;
+	} while (!atomic_try_cmpxchg(&v->corrupted_errs, &ce, ce + 1));
 
 	switch (type) {
 	case DM_VERITY_BLOCK_TYPE_DATA:
@@ -240,7 +242,7 @@ static int verity_handle_err(struct dm_verity *v, enum verity_block_type type,
 	DMERR_LIMIT("%s: %s block %llu is corrupted", v->data_dev->name,
 		    type_str, block);
 
-	if (v->corrupted_errs == DM_VERITY_MAX_CORRUPTED_ERRS)
+	if (ce + 1 == DM_VERITY_MAX_CORRUPTED_ERRS)
 		DMERR("%s: reached maximum errors", v->data_dev->name);
 
 	snprintf(verity_env, DM_VERITY_ENV_LENGTH, "%s=%d,%llu",
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index f61c89c79cf5..ad5104daddb5 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -55,7 +55,7 @@ struct dm_verity {
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
 	int hash_failed;	/* set to 1 if hash of any block failed */
 	enum verity_mode mode;	/* mode for handling verification errors */
-	unsigned corrupted_errs;/* Number of errors for corrupted blocks */
+	atomic_t corrupted_errs;/* Number of errors for corrupted blocks */
 
 	struct workqueue_struct *verify_wq;
 
diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 389f61a5b595..d2daf1bed300 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -47,22 +47,6 @@
 
 #define IMX219_DEFAULT_LINK_FREQ	456000000
 
-/* V_TIMING internal */
-#define IMX219_REG_VTS			0x0160
-#define IMX219_VTS_15FPS		0x0dc6
-#define IMX219_VTS_30FPS_1080P		0x06e3
-#define IMX219_VTS_30FPS_BINNED		0x06e3
-#define IMX219_VTS_30FPS_640x480	0x06e3
-#define IMX219_VTS_MAX			0xffff
-
-#define IMX219_VBLANK_MIN		4
-
-/*Frame Length Line*/
-#define IMX219_FLL_MIN			0x08a6
-#define IMX219_FLL_MAX			0xffff
-#define IMX219_FLL_STEP			1
-#define IMX219_FLL_DEFAULT		0x0c98
-
 /* HBLANK control - read only */
 #define IMX219_PPL_DEFAULT		3448
 
@@ -87,6 +71,11 @@
 #define IMX219_DGTL_GAIN_DEFAULT	0x0100
 #define IMX219_DGTL_GAIN_STEP		1
 
+/* V_TIMING internal */
+#define IMX219_REG_FRM_LENGTH_A		0x0160
+#define IMX219_FLL_MAX			0xfffe
+#define IMX219_VBLANK_MIN		32
+
 #define IMX219_REG_ORIENTATION		0x0172
 
 /* Binning  Mode */
@@ -145,7 +134,7 @@ struct imx219_mode {
 	struct v4l2_rect crop;
 
 	/* V-timing */
-	unsigned int vts_def;
+	unsigned int fll_def;
 
 	/* Default register values */
 	struct imx219_reg_list reg_list;
@@ -386,7 +375,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_15FPS,
+		.fll_def = 3526,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_3280x2464_regs),
 			.regs = mode_3280x2464_regs,
@@ -403,7 +392,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1920,
 			.height = 1080
 		},
-		.vts_def = IMX219_VTS_30FPS_1080P,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1920_1080_regs),
 			.regs = mode_1920_1080_regs,
@@ -420,7 +409,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 3280,
 			.height = 2464
 		},
-		.vts_def = IMX219_VTS_30FPS_BINNED,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_1640_1232_regs),
 			.regs = mode_1640_1232_regs,
@@ -437,7 +426,7 @@ static const struct imx219_mode supported_modes[] = {
 			.width = 1280,
 			.height = 960
 		},
-		.vts_def = IMX219_VTS_30FPS_640x480,
+		.fll_def = 1763,
 		.reg_list = {
 			.num_of_regs = ARRAY_SIZE(mode_640_480_regs),
 			.regs = mode_640_480_regs,
@@ -675,7 +664,7 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
 				       imx219->vflip->val << 1);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = imx219_write_reg(imx219, IMX219_REG_VTS,
+		ret = imx219_write_reg(imx219, IMX219_REG_FRM_LENGTH_A,
 				       IMX219_REG_VALUE_16BIT,
 				       imx219->mode->height + ctrl->val);
 		break;
@@ -841,12 +830,12 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 		imx219->mode = mode;
 		/* Update limits and set FPS to default */
 		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
+					 IMX219_FLL_MAX - mode->height, 1,
+					 mode->fll_def - mode->height);
 		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->vts_def - mode->height);
+				   mode->fll_def - mode->height);
 		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->vts_def - 4;
+		exposure_max = mode->fll_def - 4;
 		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 			exposure_max : IMX219_EXPOSURE_DEFAULT;
 		__v4l2_ctrl_modify_range(imx219->exposure,
@@ -1261,15 +1250,15 @@ static int imx219_init_controls(struct imx219 *imx219)
 	/* Initial vblank/hblank/exposure parameters based on current mode */
 	imx219->vblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
-					   IMX219_VTS_MAX - height, 1,
-					   imx219->mode->vts_def - height);
+					   IMX219_FLL_MAX - height, 1,
+					   imx219->mode->fll_def - height);
 	hblank = IMX219_PPL_DEFAULT - imx219->mode->width;
 	imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
 	if (imx219->hblank)
 		imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-	exposure_max = imx219->mode->vts_def - 4;
+	exposure_max = imx219->mode->fll_def - 4;
 	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
 		exposure_max : IMX219_EXPOSURE_DEFAULT;
 	imx219->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 9d9124308f6a..56fe20ba8041 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1724,6 +1724,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
+		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
diff --git a/drivers/media/platform/marvell-ccic/cafe-driver.c b/drivers/media/platform/marvell-ccic/cafe-driver.c
index 9aa374fa8b36..5e6ef67ae7f9 100644
--- a/drivers/media/platform/marvell-ccic/cafe-driver.c
+++ b/drivers/media/platform/marvell-ccic/cafe-driver.c
@@ -610,6 +610,7 @@ static void cafe_pci_remove(struct pci_dev *pdev)
 		return;
 	}
 	cafe_shutdown(cam);
+	pci_disable_device(pdev);
 	kfree(cam);
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..199a64c853bc 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
@@ -65,6 +65,11 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw) {
+		scp_put(scp);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index cd9e78c63791..4ca07fc74cfb 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -705,7 +705,7 @@ __v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_i2c_subdev);
 
-int v4l2_async_register_subdev(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *subdev_notifier;
 	struct v4l2_async_notifier *notifier;
@@ -719,6 +719,8 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	if (!sd->fwnode && sd->dev)
 		sd->fwnode = dev_fwnode(sd->dev);
 
+	sd->owner = module;
+
 	mutex_lock(&list_lock);
 
 	INIT_LIST_HEAD(&sd->async_list);
@@ -769,9 +771,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 
 	mutex_unlock(&list_lock);
 
+	sd->owner = NULL;
+
 	return ret;
 }
-EXPORT_SYMBOL(v4l2_async_register_subdev);
+EXPORT_SYMBOL(__v4l2_async_register_subdev);
 
 void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 {
diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 5d2eaad1fa68..93dbc00bf37a 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1318,7 +1318,7 @@ v4l2_async_notifier_parse_fwnode_sensor(struct device *dev,
 	return 0;
 }
 
-int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *notifier;
 	int ret;
@@ -1340,7 +1340,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 	if (ret < 0)
 		goto out_cleanup;
 
-	ret = v4l2_async_register_subdev(sd);
+	ret = __v4l2_async_register_subdev(sd, module);
 	if (ret < 0)
 		goto out_unregister;
 
@@ -1357,7 +1357,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor);
+EXPORT_SYMBOL_GPL(__v4l2_async_register_subdev_sensor);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 500c906413a7..5211f30d7cc5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1363,7 +1363,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 86367723d155..210521b00b04 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4109,6 +4109,14 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
+static void sdhci_unmap_bounce_buffer(void *data)
+{
+	struct sdhci_host *host = data;
+
+	dma_unmap_single(mmc_dev(host->mmc), host->bounce_addr,
+			 host->bounce_buffer_size, DMA_BIDIRECTIONAL);
+}
+
 static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -4163,6 +4171,14 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	}
 
 	host->bounce_buffer_size = bounce_size;
+	ret = devm_add_action_or_reset(mmc_dev(mmc),
+				       sdhci_unmap_bounce_buffer, host);
+	if (ret) {
+		devm_kfree(mmc_dev(mmc), host->bounce_buffer);
+		host->bounce_buffer = NULL;
+		host->bounce_buffer_size = 0;
+		return;
+	}
 
 	/* Lie about this since we're bouncing */
 	mmc->max_segs = max_blocks;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 76b0bd886b11..92d2e36f5917 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -597,7 +597,7 @@ struct sdhci_host {
 
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
-	unsigned int		tuning_err;	/* Error code for re-tuning */
+	int			tuning_err;	/* Error code for re-tuning */
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 38024cc2d5e0..a3f285d3253f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2116,19 +2116,19 @@ static int vub300_probe(struct usb_interface *interface,
 	command_out_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_out_urb) {
 		retval = -ENOMEM;
-		goto error0;
+		goto err_put_udev;
 	}
 	command_res_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!command_res_urb) {
 		retval = -ENOMEM;
-		goto error1;
+		goto err_free_out_urb;
 	}
 	/* this also allocates memory for our VUB300 mmc host device */
 	mmc = mmc_alloc_host(sizeof(struct vub300_mmc_host), &udev->dev);
 	if (!mmc) {
 		retval = -ENOMEM;
 		dev_err(&udev->dev, "not enough memory for the mmc_host\n");
-		goto error4;
+		goto err_free_res_urb;
 	}
 	/* MMC core transfer sizes tunable parameters */
 	mmc->caps = 0;
@@ -2281,7 +2281,7 @@ static int vub300_probe(struct usb_interface *interface,
 		dev_err(&vub300->udev->dev,
 		    "Could not find two sets of bulk-in/out endpoint pairs\n");
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	retval =
 		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
@@ -2290,14 +2290,14 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->hc_info,
 				sizeof(vub300->hc_info), 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	retval =
 		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
 				SET_ROM_WAIT_STATES,
 				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				firmware_rom_wait_states, 0x0000, NULL, 0, 1000);
 	if (retval < 0)
-		goto error5;
+		goto err_free_host;
 	dev_info(&vub300->udev->dev,
 		 "operating_mode = %s %s %d MHz %s %d byte USB packets\n",
 		 (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
@@ -2312,7 +2312,7 @@ static int vub300_probe(struct usb_interface *interface,
 				0x0000, 0x0000, &vub300->system_port_status,
 				sizeof(vub300->system_port_status), 1000);
 	if (retval < 0) {
-		goto error5;
+		goto err_free_host;
 	} else if (sizeof(vub300->system_port_status) == retval) {
 		vub300->card_present =
 			(0x0001 & vub300->system_port_status.port_flags) ? 1 : 0;
@@ -2320,7 +2320,7 @@ static int vub300_probe(struct usb_interface *interface,
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
 		retval = -EINVAL;
-		goto error5;
+		goto err_free_host;
 	}
 	usb_set_intfdata(interface, vub300);
 	INIT_DELAYED_WORK(&vub300->pollwork, vub300_pollwork_thread);
@@ -2345,23 +2345,29 @@ static int vub300_probe(struct usb_interface *interface,
 			 interface_to_InterfaceNumber(interface));
 	retval = mmc_add_host(mmc);
 	if (retval)
-		goto error6;
+		goto err_stop_io;
 
 	return 0;
-error6:
-	del_timer_sync(&vub300->inactivity_timer);
-error5:
+
+err_stop_io:
+	vub300->interface = NULL;
+	kref_put(&vub300->kref, vub300_delete);
+
+	return retval;
+
+err_free_host:
 	mmc_free_host(mmc);
 	/*
 	 * and hence also frees vub300
 	 * which is contained at the end of struct mmc
 	 */
-error4:
+err_free_res_urb:
 	usb_free_urb(command_res_urb);
-error1:
+err_free_out_urb:
 	usb_free_urb(command_out_urb);
-error0:
+err_put_udev:
 	usb_put_dev(udev);
+
 	return retval;
 }
 
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index f96a165fccc7..ad10f7887dfa 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -610,7 +610,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
+	card = kzalloc_obj(struct memcard);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -628,15 +628,13 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
-				    GFP_KERNEL);
+	card->parts = kzalloc_objs(struct vmupart, card->partitions);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
-				  GFP_KERNEL);
+	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index f29779a76113..2fdc23edd73a 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -52,7 +52,6 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 					uint64_t *len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
@@ -73,13 +72,13 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
 	*len = min_prot_len << (bp - 1);
 
-	if (*len > mtd->size)
-		*len = mtd->size;
+	if (*len > nor->params->size)
+		*len = nor->params->size;
 
 	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
 		*ofs = 0;
 	else
-		*ofs = mtd->size - *len;
+		*ofs = nor->params->size - *len;
 }
 
 /*
@@ -155,7 +154,6 @@ static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs,
  */
 static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -180,7 +178,7 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		can_be_bottom = false;
 
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				  status_old))
 		can_be_top = false;
 
@@ -192,11 +190,11 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
-		lock_len = mtd->size - ofs;
+		lock_len = nor->params->size - ofs;
 	else
 		lock_len = ofs + len;
 
-	if (lock_len == mtd->size) {
+	if (lock_len == nor->params->size) {
 		val = mask;
 	} else {
 		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
@@ -240,7 +238,6 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
  */
 static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -265,7 +262,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 		can_be_top = false;
 
 	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				    status_old))
 		can_be_bottom = false;
 
@@ -275,9 +272,16 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	/* Prefer top, if both are valid */
 	use_top = can_be_top;
 
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
-		lock_len = mtd->size - (ofs + len);
+	/*
+	 * lock_len: length of region that should remain locked.
+	 *
+	 * When can_be_top and can_be_bottom booleans are true, both adjacent
+	 * regions are unlocked, thus the entire flash can be unlocked.
+	 */
+	if (can_be_top && can_be_bottom)
+		lock_len = 0;
+	else if (use_top)
+		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
 
diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index f959215c9d53..1218f9642f33 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -14,11 +14,18 @@ config CAN_EMS_USB
 	  This driver is for the one channel CPC-USB/ARM7 CAN/USB interface
 	  from EMS Dr. Thomas Wuensche (http://www.ems-wuensche.de).
 
-config CAN_ESD_USB2
-	tristate "ESD USB/2 CAN/USB interface"
+config CAN_ESD_USB
+	tristate "esd electronics gmbh CAN/USB interfaces"
 	help
-	  This driver supports the CAN-USB/2 interface
-	  from esd electronic system design gmbh (http://www.esd.eu).
+	  This driver adds supports for several CAN/USB interfaces
+	  from esd electronics gmbh (https://www.esd.eu).
+
+	  The drivers supports the following devices:
+	    - esd CAN-USB/2
+	    - esd CAN-USB/Micro
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called esd_usb.
 
 config CAN_ETAS_ES58X
 	tristate "ETAS ES58X CAN/USB interfaces"
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index 748cf31a0d53..1ea16be5743b 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
 obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
-obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
+obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
 obj-$(CONFIG_CAN_ETAS_ES58X) += etas_es58x/
 obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
new file mode 100644
index 000000000000..253cb2a50a51
--- /dev/null
+++ b/drivers/net/can/usb/esd_usb.c
@@ -0,0 +1,1173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
+ *
+ * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
+ */
+#include <linux/signal.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/usb.h>
+
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/error.h>
+
+MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
+MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro interfaces");
+MODULE_LICENSE("GPL v2");
+
+/* Define these values to match your devices */
+#define USB_ESDGMBH_VENDOR_ID	0x0ab4
+#define USB_CANUSB2_PRODUCT_ID	0x0010
+#define USB_CANUSBM_PRODUCT_ID	0x0011
+
+#define ESD_USB2_CAN_CLOCK	60000000
+#define ESD_USBM_CAN_CLOCK	36000000
+#define ESD_USB2_MAX_NETS	2
+
+/* USB2 commands */
+#define CMD_VERSION		1 /* also used for VERSION_REPLY */
+#define CMD_CAN_RX		2 /* device to host only */
+#define CMD_CAN_TX		3 /* also used for TX_DONE */
+#define CMD_SETBAUD		4 /* also used for SETBAUD_REPLY */
+#define CMD_TS			5 /* also used for TS_REPLY */
+#define CMD_IDADD		6 /* also used for IDADD_REPLY */
+
+/* esd CAN message flags - dlc field */
+#define ESD_RTR			0x10
+
+/* esd CAN message flags - id field */
+#define ESD_EXTID		0x20000000
+#define ESD_EVENT		0x40000000
+#define ESD_IDMASK		0x1fffffff
+
+/* esd CAN event ids used by this driver */
+#define ESD_EV_CAN_ERROR_EXT	2
+
+/* baudrate message flags */
+#define ESD_USB2_UBR		0x80000000
+#define ESD_USB2_LOM		0x40000000
+#define ESD_USB2_NO_BAUDRATE	0x7fffffff
+#define ESD_USB2_TSEG1_MIN	1
+#define ESD_USB2_TSEG1_MAX	16
+#define ESD_USB2_TSEG1_SHIFT	16
+#define ESD_USB2_TSEG2_MIN	1
+#define ESD_USB2_TSEG2_MAX	8
+#define ESD_USB2_TSEG2_SHIFT	20
+#define ESD_USB2_SJW_MAX	4
+#define ESD_USB2_SJW_SHIFT	14
+#define ESD_USBM_SJW_SHIFT	24
+#define ESD_USB2_BRP_MIN	1
+#define ESD_USB2_BRP_MAX	1024
+#define ESD_USB2_BRP_INC	1
+#define ESD_USB2_3_SAMPLES	0x00800000
+
+/* esd IDADD message */
+#define ESD_ID_ENABLE		0x80
+#define ESD_MAX_ID_SEGMENT	64
+
+/* SJA1000 ECC register (emulated by usb2 firmware) */
+#define SJA1000_ECC_SEG		0x1F
+#define SJA1000_ECC_DIR		0x20
+#define SJA1000_ECC_ERR		0x06
+#define SJA1000_ECC_BIT		0x00
+#define SJA1000_ECC_FORM	0x40
+#define SJA1000_ECC_STUFF	0x80
+#define SJA1000_ECC_MASK	0xc0
+
+/* esd bus state event codes */
+#define ESD_BUSSTATE_MASK	0xc0
+#define ESD_BUSSTATE_WARN	0x40
+#define ESD_BUSSTATE_ERRPASSIVE	0x80
+#define ESD_BUSSTATE_BUSOFF	0xc0
+
+#define RX_BUFFER_SIZE		1024
+#define MAX_RX_URBS		4
+#define MAX_TX_URBS		16 /* must be power of 2 */
+
+struct header_msg {
+	u8 len; /* len is always the total message length in 32bit words */
+	u8 cmd;
+	u8 rsvd[2];
+};
+
+struct version_msg {
+	u8 len;
+	u8 cmd;
+	u8 rsvd;
+	u8 flags;
+	__le32 drv_version;
+};
+
+struct version_reply_msg {
+	u8 len;
+	u8 cmd;
+	u8 nets;
+	u8 features;
+	__le32 version;
+	u8 name[16];
+	__le32 rsvd;
+	__le32 ts;
+};
+
+struct rx_msg {
+	u8 len;
+	u8 cmd;
+	u8 net;
+	u8 dlc;
+	__le32 ts;
+	__le32 id; /* upper 3 bits contain flags */
+	u8 data[8];
+};
+
+struct tx_msg {
+	u8 len;
+	u8 cmd;
+	u8 net;
+	u8 dlc;
+	u32 hnd;	/* opaque handle, not used by device */
+	__le32 id; /* upper 3 bits contain flags */
+	u8 data[8];
+};
+
+struct tx_done_msg {
+	u8 len;
+	u8 cmd;
+	u8 net;
+	u8 status;
+	u32 hnd;	/* opaque handle, not used by device */
+	__le32 ts;
+};
+
+struct id_filter_msg {
+	u8 len;
+	u8 cmd;
+	u8 net;
+	u8 option;
+	__le32 mask[ESD_MAX_ID_SEGMENT + 1];
+};
+
+struct set_baudrate_msg {
+	u8 len;
+	u8 cmd;
+	u8 net;
+	u8 rsvd;
+	__le32 baud;
+};
+
+/* Main message type used between library and application */
+struct __attribute__ ((packed)) esd_usb2_msg {
+	union {
+		struct header_msg hdr;
+		struct version_msg version;
+		struct version_reply_msg version_reply;
+		struct rx_msg rx;
+		struct tx_msg tx;
+		struct tx_done_msg txdone;
+		struct set_baudrate_msg setbaud;
+		struct id_filter_msg filter;
+	} msg;
+};
+
+static struct usb_device_id esd_usb2_table[] = {
+	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID)},
+	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSBM_PRODUCT_ID)},
+	{}
+};
+MODULE_DEVICE_TABLE(usb, esd_usb2_table);
+
+struct esd_usb2_net_priv;
+
+struct esd_tx_urb_context {
+	struct esd_usb2_net_priv *priv;
+	u32 echo_index;
+	int len;	/* CAN payload length */
+};
+
+struct esd_usb2 {
+	struct usb_device *udev;
+	struct esd_usb2_net_priv *nets[ESD_USB2_MAX_NETS];
+
+	struct usb_anchor rx_submitted;
+
+	int net_count;
+	u32 version;
+	int rxinitdone;
+	void *rxbuf[MAX_RX_URBS];
+	dma_addr_t rxbuf_dma[MAX_RX_URBS];
+};
+
+struct esd_usb2_net_priv {
+	struct can_priv can; /* must be the first member */
+
+	atomic_t active_tx_jobs;
+	struct usb_anchor tx_submitted;
+	struct esd_tx_urb_context tx_contexts[MAX_TX_URBS];
+
+	struct esd_usb2 *usb2;
+	struct net_device *netdev;
+	int index;
+	u8 old_state;
+	struct can_berr_counter bec;
+};
+
+static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
+			      struct esd_usb2_msg *msg)
+{
+	struct net_device_stats *stats = &priv->netdev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u32 id = le32_to_cpu(msg->msg.rx.id) & ESD_IDMASK;
+
+	if (id == ESD_EV_CAN_ERROR_EXT) {
+		u8 state = msg->msg.rx.data[0];
+		u8 ecc = msg->msg.rx.data[1];
+		u8 rxerr = msg->msg.rx.data[2];
+		u8 txerr = msg->msg.rx.data[3];
+
+		netdev_dbg(priv->netdev,
+			   "CAN_ERR_EV_EXT: dlc=%#02x state=%02x ecc=%02x rec=%02x tec=%02x\n",
+			   msg->msg.rx.dlc, state, ecc, rxerr, txerr);
+
+		skb = alloc_can_err_skb(priv->netdev, &cf);
+		if (skb == NULL) {
+			stats->rx_dropped++;
+			return;
+		}
+
+		if (state != priv->old_state) {
+			priv->old_state = state;
+
+			switch (state & ESD_BUSSTATE_MASK) {
+			case ESD_BUSSTATE_BUSOFF:
+				priv->can.state = CAN_STATE_BUS_OFF;
+				cf->can_id |= CAN_ERR_BUSOFF;
+				priv->can.can_stats.bus_off++;
+				can_bus_off(priv->netdev);
+				break;
+			case ESD_BUSSTATE_WARN:
+				priv->can.state = CAN_STATE_ERROR_WARNING;
+				priv->can.can_stats.error_warning++;
+				break;
+			case ESD_BUSSTATE_ERRPASSIVE:
+				priv->can.state = CAN_STATE_ERROR_PASSIVE;
+				priv->can.can_stats.error_passive++;
+				break;
+			default:
+				priv->can.state = CAN_STATE_ERROR_ACTIVE;
+				txerr = 0;
+				rxerr = 0;
+				break;
+			}
+		} else {
+			priv->can.can_stats.bus_error++;
+			stats->rx_errors++;
+
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+
+			switch (ecc & SJA1000_ECC_MASK) {
+			case SJA1000_ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case SJA1000_ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case SJA1000_ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				break;
+			}
+
+			/* Error occurred during transmission? */
+			if (!(ecc & SJA1000_ECC_DIR))
+				cf->data[2] |= CAN_ERR_PROT_TX;
+
+			/* Bit stream position in CAN frame as the error was detected */
+			cf->data[3] = ecc & SJA1000_ECC_SEG;
+
+			if (priv->can.state == CAN_STATE_ERROR_WARNING ||
+			    priv->can.state == CAN_STATE_ERROR_PASSIVE) {
+				cf->data[1] = (txerr > rxerr) ?
+					CAN_ERR_CRTL_TX_PASSIVE :
+					CAN_ERR_CRTL_RX_PASSIVE;
+			}
+			cf->data[6] = txerr;
+			cf->data[7] = rxerr;
+		}
+
+		priv->bec.txerr = txerr;
+		priv->bec.rxerr = rxerr;
+
+		netif_rx(skb);
+	}
+}
+
+static void esd_usb2_rx_can_msg(struct esd_usb2_net_priv *priv,
+				struct esd_usb2_msg *msg)
+{
+	struct net_device_stats *stats = &priv->netdev->stats;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	int i;
+	u32 id;
+
+	if (!netif_device_present(priv->netdev))
+		return;
+
+	id = le32_to_cpu(msg->msg.rx.id);
+
+	if (id & ESD_EVENT) {
+		esd_usb2_rx_event(priv, msg);
+	} else {
+		skb = alloc_can_skb(priv->netdev, &cf);
+		if (skb == NULL) {
+			stats->rx_dropped++;
+			return;
+		}
+
+		cf->can_id = id & ESD_IDMASK;
+		can_frame_set_cc_len(cf, msg->msg.rx.dlc & ~ESD_RTR,
+				     priv->can.ctrlmode);
+
+		if (id & ESD_EXTID)
+			cf->can_id |= CAN_EFF_FLAG;
+
+		if (msg->msg.rx.dlc & ESD_RTR) {
+			cf->can_id |= CAN_RTR_FLAG;
+		} else {
+			for (i = 0; i < cf->len; i++)
+				cf->data[i] = msg->msg.rx.data[i];
+		}
+
+		stats->rx_packets++;
+		stats->rx_bytes += cf->len;
+		netif_rx(skb);
+	}
+
+	return;
+}
+
+static void esd_usb2_tx_done_msg(struct esd_usb2_net_priv *priv,
+				 struct esd_usb2_msg *msg)
+{
+	struct net_device_stats *stats = &priv->netdev->stats;
+	struct net_device *netdev = priv->netdev;
+	struct esd_tx_urb_context *context;
+
+	if (!netif_device_present(netdev))
+		return;
+
+	context = &priv->tx_contexts[msg->msg.txdone.hnd & (MAX_TX_URBS - 1)];
+
+	if (!msg->msg.txdone.status) {
+		stats->tx_packets++;
+		stats->tx_bytes += context->len;
+		can_get_echo_skb(netdev, context->echo_index, NULL);
+	} else {
+		stats->tx_errors++;
+		can_free_echo_skb(netdev, context->echo_index, NULL);
+	}
+
+	/* Release context */
+	context->echo_index = MAX_TX_URBS;
+	atomic_dec(&priv->active_tx_jobs);
+
+	netif_wake_queue(netdev);
+}
+
+static void esd_usb2_read_bulk_callback(struct urb *urb)
+{
+	struct esd_usb2 *dev = urb->context;
+	int retval;
+	int pos = 0;
+	int i;
+
+	switch (urb->status) {
+	case 0: /* success */
+		break;
+
+	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
+	case -ESHUTDOWN:
+		return;
+
+	default:
+		dev_info(dev->udev->dev.parent,
+			 "Rx URB aborted (%d)\n", urb->status);
+		goto resubmit_urb;
+	}
+
+	while (pos < urb->actual_length) {
+		struct esd_usb2_msg *msg;
+
+		msg = (struct esd_usb2_msg *)(urb->transfer_buffer + pos);
+
+		switch (msg->msg.hdr.cmd) {
+		case CMD_CAN_RX:
+			if (msg->msg.rx.net >= dev->net_count) {
+				dev_err(dev->udev->dev.parent, "format error\n");
+				break;
+			}
+
+			esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
+			break;
+
+		case CMD_CAN_TX:
+			if (msg->msg.txdone.net >= dev->net_count) {
+				dev_err(dev->udev->dev.parent, "format error\n");
+				break;
+			}
+
+			esd_usb2_tx_done_msg(dev->nets[msg->msg.txdone.net],
+					     msg);
+			break;
+		}
+
+		pos += msg->msg.hdr.len << 2;
+
+		if (pos > urb->actual_length) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
+	}
+
+resubmit_urb:
+	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
+			  urb->transfer_buffer, RX_BUFFER_SIZE,
+			  esd_usb2_read_bulk_callback, dev);
+
+	usb_anchor_urb(urb, &dev->rx_submitted);
+
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!retval)
+		return;
+
+	usb_unanchor_urb(urb);
+
+	if (retval == -ENODEV) {
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i])
+				netif_device_detach(dev->nets[i]->netdev);
+		}
+	} else {
+		dev_err(dev->udev->dev.parent,
+			"failed resubmitting read bulk urb: %d\n", retval);
+	}
+
+	return;
+}
+
+/*
+ * callback for bulk IN urb
+ */
+static void esd_usb2_write_bulk_callback(struct urb *urb)
+{
+	struct esd_tx_urb_context *context = urb->context;
+	struct esd_usb2_net_priv *priv;
+	struct net_device *netdev;
+	size_t size = sizeof(struct esd_usb2_msg);
+
+	WARN_ON(!context);
+
+	priv = context->priv;
+	netdev = priv->netdev;
+
+	/* free up our allocated buffer */
+	usb_free_coherent(urb->dev, size,
+			  urb->transfer_buffer, urb->transfer_dma);
+
+	if (!netif_device_present(netdev))
+		return;
+
+	if (urb->status)
+		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
+
+	netif_trans_update(netdev);
+}
+
+static ssize_t firmware_show(struct device *d,
+			     struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(d);
+	struct esd_usb2 *dev = usb_get_intfdata(intf);
+
+	return sprintf(buf, "%d.%d.%d\n",
+		       (dev->version >> 12) & 0xf,
+		       (dev->version >> 8) & 0xf,
+		       dev->version & 0xff);
+}
+static DEVICE_ATTR_RO(firmware);
+
+static ssize_t hardware_show(struct device *d,
+			     struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(d);
+	struct esd_usb2 *dev = usb_get_intfdata(intf);
+
+	return sprintf(buf, "%d.%d.%d\n",
+		       (dev->version >> 28) & 0xf,
+		       (dev->version >> 24) & 0xf,
+		       (dev->version >> 16) & 0xff);
+}
+static DEVICE_ATTR_RO(hardware);
+
+static ssize_t nets_show(struct device *d,
+			 struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(d);
+	struct esd_usb2 *dev = usb_get_intfdata(intf);
+
+	return sprintf(buf, "%d", dev->net_count);
+}
+static DEVICE_ATTR_RO(nets);
+
+static int esd_usb2_send_msg(struct esd_usb2 *dev, struct esd_usb2_msg *msg)
+{
+	int actual_length;
+
+	return usb_bulk_msg(dev->udev,
+			    usb_sndbulkpipe(dev->udev, 2),
+			    msg,
+			    msg->msg.hdr.len << 2,
+			    &actual_length,
+			    1000);
+}
+
+static int esd_usb2_wait_msg(struct esd_usb2 *dev,
+			     struct esd_usb2_msg *msg)
+{
+	int actual_length;
+
+	return usb_bulk_msg(dev->udev,
+			    usb_rcvbulkpipe(dev->udev, 1),
+			    msg,
+			    sizeof(*msg),
+			    &actual_length,
+			    1000);
+}
+
+static int esd_usb2_setup_rx_urbs(struct esd_usb2 *dev)
+{
+	int i, err = 0;
+
+	if (dev->rxinitdone)
+		return 0;
+
+	for (i = 0; i < MAX_RX_URBS; i++) {
+		struct urb *urb = NULL;
+		u8 *buf = NULL;
+		dma_addr_t buf_dma;
+
+		/* create a URB, and a buffer for it */
+		urb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!urb) {
+			err = -ENOMEM;
+			break;
+		}
+
+		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
+					 &buf_dma);
+		if (!buf) {
+			dev_warn(dev->udev->dev.parent,
+				 "No memory left for USB buffer\n");
+			err = -ENOMEM;
+			goto freeurb;
+		}
+
+		urb->transfer_dma = buf_dma;
+
+		usb_fill_bulk_urb(urb, dev->udev,
+				  usb_rcvbulkpipe(dev->udev, 1),
+				  buf, RX_BUFFER_SIZE,
+				  esd_usb2_read_bulk_callback, dev);
+		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+		usb_anchor_urb(urb, &dev->rx_submitted);
+
+		err = usb_submit_urb(urb, GFP_KERNEL);
+		if (err) {
+			usb_unanchor_urb(urb);
+			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
+					  urb->transfer_dma);
+			goto freeurb;
+		}
+
+		dev->rxbuf[i] = buf;
+		dev->rxbuf_dma[i] = buf_dma;
+
+freeurb:
+		/* Drop reference, USB core will take care of freeing it */
+		usb_free_urb(urb);
+		if (err)
+			break;
+	}
+
+	/* Did we submit any URBs */
+	if (i == 0) {
+		dev_err(dev->udev->dev.parent, "couldn't setup read URBs\n");
+		return err;
+	}
+
+	/* Warn if we've couldn't transmit all the URBs */
+	if (i < MAX_RX_URBS) {
+		dev_warn(dev->udev->dev.parent,
+			 "rx performance may be slow\n");
+	}
+
+	dev->rxinitdone = 1;
+	return 0;
+}
+
+/*
+ * Start interface
+ */
+static int esd_usb2_start(struct esd_usb2_net_priv *priv)
+{
+	struct esd_usb2 *dev = priv->usb2;
+	struct net_device *netdev = priv->netdev;
+	struct esd_usb2_msg *msg;
+	int err, i;
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Enable all IDs
+	 * The IDADD message takes up to 64 32 bit bitmasks (2048 bits).
+	 * Each bit represents one 11 bit CAN identifier. A set bit
+	 * enables reception of the corresponding CAN identifier. A cleared
+	 * bit disabled this identifier. An additional bitmask value
+	 * following the CAN 2.0A bits is used to enable reception of
+	 * extended CAN frames. Only the LSB of this final mask is checked
+	 * for the complete 29 bit ID range. The IDADD message also allows
+	 * filter configuration for an ID subset. In this case you can add
+	 * the number of the starting bitmask (0..64) to the filter.option
+	 * field followed by only some bitmasks.
+	 */
+	msg->msg.hdr.cmd = CMD_IDADD;
+	msg->msg.hdr.len = 2 + ESD_MAX_ID_SEGMENT;
+	msg->msg.filter.net = priv->index;
+	msg->msg.filter.option = ESD_ID_ENABLE; /* start with segment 0 */
+	for (i = 0; i < ESD_MAX_ID_SEGMENT; i++)
+		msg->msg.filter.mask[i] = cpu_to_le32(0xffffffff);
+	/* enable 29bit extended IDs */
+	msg->msg.filter.mask[ESD_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
+
+	err = esd_usb2_send_msg(dev, msg);
+	if (err)
+		goto out;
+
+	err = esd_usb2_setup_rx_urbs(dev);
+	if (err)
+		goto out;
+
+	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+
+out:
+	if (err == -ENODEV)
+		netif_device_detach(netdev);
+	if (err)
+		netdev_err(netdev, "couldn't start device: %d\n", err);
+
+	kfree(msg);
+	return err;
+}
+
+static void unlink_all_urbs(struct esd_usb2 *dev)
+{
+	struct esd_usb2_net_priv *priv;
+	int i, j;
+
+	usb_kill_anchored_urbs(&dev->rx_submitted);
+
+	for (i = 0; i < MAX_RX_URBS; ++i)
+		usb_free_coherent(dev->udev, RX_BUFFER_SIZE,
+				  dev->rxbuf[i], dev->rxbuf_dma[i]);
+
+	for (i = 0; i < dev->net_count; i++) {
+		priv = dev->nets[i];
+		if (priv) {
+			usb_kill_anchored_urbs(&priv->tx_submitted);
+			atomic_set(&priv->active_tx_jobs, 0);
+
+			for (j = 0; j < MAX_TX_URBS; j++)
+				priv->tx_contexts[j].echo_index = MAX_TX_URBS;
+		}
+	}
+}
+
+static int esd_usb2_open(struct net_device *netdev)
+{
+	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
+	int err;
+
+	/* common open */
+	err = open_candev(netdev);
+	if (err)
+		return err;
+
+	/* finally start device */
+	err = esd_usb2_start(priv);
+	if (err) {
+		netdev_warn(netdev, "couldn't start device: %d\n", err);
+		close_candev(netdev);
+		return err;
+	}
+
+	netif_start_queue(netdev);
+
+	return 0;
+}
+
+static netdev_tx_t esd_usb2_start_xmit(struct sk_buff *skb,
+				      struct net_device *netdev)
+{
+	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
+	struct esd_usb2 *dev = priv->usb2;
+	struct esd_tx_urb_context *context = NULL;
+	struct net_device_stats *stats = &netdev->stats;
+	struct can_frame *cf = (struct can_frame *)skb->data;
+	struct esd_usb2_msg *msg;
+	struct urb *urb;
+	u8 *buf;
+	int i, err;
+	int ret = NETDEV_TX_OK;
+	size_t size = sizeof(struct esd_usb2_msg);
+
+	if (can_dropped_invalid_skb(netdev, skb))
+		return NETDEV_TX_OK;
+
+	/* create a URB, and a buffer for it, and copy the data to the URB */
+	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	if (!urb) {
+		stats->tx_dropped++;
+		dev_kfree_skb(skb);
+		goto nourbmem;
+	}
+
+	buf = usb_alloc_coherent(dev->udev, size, GFP_ATOMIC,
+				 &urb->transfer_dma);
+	if (!buf) {
+		netdev_err(netdev, "No memory left for USB buffer\n");
+		stats->tx_dropped++;
+		dev_kfree_skb(skb);
+		goto nobufmem;
+	}
+
+	msg = (struct esd_usb2_msg *)buf;
+
+	msg->msg.hdr.len = 3; /* minimal length */
+	msg->msg.hdr.cmd = CMD_CAN_TX;
+	msg->msg.tx.net = priv->index;
+	msg->msg.tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
+	msg->msg.tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
+
+	if (cf->can_id & CAN_RTR_FLAG)
+		msg->msg.tx.dlc |= ESD_RTR;
+
+	if (cf->can_id & CAN_EFF_FLAG)
+		msg->msg.tx.id |= cpu_to_le32(ESD_EXTID);
+
+	for (i = 0; i < cf->len; i++)
+		msg->msg.tx.data[i] = cf->data[i];
+
+	msg->msg.hdr.len += (cf->len + 3) >> 2;
+
+	for (i = 0; i < MAX_TX_URBS; i++) {
+		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
+			context = &priv->tx_contexts[i];
+			break;
+		}
+	}
+
+	/*
+	 * This may never happen.
+	 */
+	if (!context) {
+		netdev_warn(netdev, "couldn't find free context\n");
+		ret = NETDEV_TX_BUSY;
+		goto releasebuf;
+	}
+
+	context->priv = priv;
+	context->echo_index = i;
+	context->len = cf->len;
+
+	/* hnd must not be 0 - MSB is stripped in txdone handling */
+	msg->msg.tx.hnd = 0x80000000 | i; /* returned in TX done message */
+
+	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
+			  msg->msg.hdr.len << 2,
+			  esd_usb2_write_bulk_callback, context);
+
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	usb_anchor_urb(urb, &priv->tx_submitted);
+
+	can_put_echo_skb(skb, netdev, context->echo_index, 0);
+
+	atomic_inc(&priv->active_tx_jobs);
+
+	/* Slow down tx path */
+	if (atomic_read(&priv->active_tx_jobs) >= MAX_TX_URBS)
+		netif_stop_queue(netdev);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err) {
+		can_free_echo_skb(netdev, context->echo_index, NULL);
+
+		atomic_dec(&priv->active_tx_jobs);
+		usb_unanchor_urb(urb);
+
+		stats->tx_dropped++;
+
+		if (err == -ENODEV)
+			netif_device_detach(netdev);
+		else
+			netdev_warn(netdev, "failed tx_urb %d\n", err);
+
+		goto releasebuf;
+	}
+
+	netif_trans_update(netdev);
+
+	/*
+	 * Release our reference to this URB, the USB core will eventually free
+	 * it entirely.
+	 */
+	usb_free_urb(urb);
+
+	return NETDEV_TX_OK;
+
+releasebuf:
+	usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
+
+nobufmem:
+	usb_free_urb(urb);
+
+nourbmem:
+	return ret;
+}
+
+static int esd_usb2_close(struct net_device *netdev)
+{
+	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
+	struct esd_usb2_msg *msg;
+	int i;
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	/* Disable all IDs (see esd_usb2_start()) */
+	msg->msg.hdr.cmd = CMD_IDADD;
+	msg->msg.hdr.len = 2 + ESD_MAX_ID_SEGMENT;
+	msg->msg.filter.net = priv->index;
+	msg->msg.filter.option = ESD_ID_ENABLE; /* start with segment 0 */
+	for (i = 0; i <= ESD_MAX_ID_SEGMENT; i++)
+		msg->msg.filter.mask[i] = 0;
+	if (esd_usb2_send_msg(priv->usb2, msg) < 0)
+		netdev_err(netdev, "sending idadd message failed\n");
+
+	/* set CAN controller to reset mode */
+	msg->msg.hdr.len = 2;
+	msg->msg.hdr.cmd = CMD_SETBAUD;
+	msg->msg.setbaud.net = priv->index;
+	msg->msg.setbaud.rsvd = 0;
+	msg->msg.setbaud.baud = cpu_to_le32(ESD_USB2_NO_BAUDRATE);
+	if (esd_usb2_send_msg(priv->usb2, msg) < 0)
+		netdev_err(netdev, "sending setbaud message failed\n");
+
+	priv->can.state = CAN_STATE_STOPPED;
+
+	netif_stop_queue(netdev);
+
+	close_candev(netdev);
+
+	kfree(msg);
+
+	return 0;
+}
+
+static const struct net_device_ops esd_usb2_netdev_ops = {
+	.ndo_open = esd_usb2_open,
+	.ndo_stop = esd_usb2_close,
+	.ndo_start_xmit = esd_usb2_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
+};
+
+static const struct can_bittiming_const esd_usb2_bittiming_const = {
+	.name = "esd_usb2",
+	.tseg1_min = ESD_USB2_TSEG1_MIN,
+	.tseg1_max = ESD_USB2_TSEG1_MAX,
+	.tseg2_min = ESD_USB2_TSEG2_MIN,
+	.tseg2_max = ESD_USB2_TSEG2_MAX,
+	.sjw_max = ESD_USB2_SJW_MAX,
+	.brp_min = ESD_USB2_BRP_MIN,
+	.brp_max = ESD_USB2_BRP_MAX,
+	.brp_inc = ESD_USB2_BRP_INC,
+};
+
+static int esd_usb2_set_bittiming(struct net_device *netdev)
+{
+	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
+	struct can_bittiming *bt = &priv->can.bittiming;
+	struct esd_usb2_msg *msg;
+	int err;
+	u32 canbtr;
+	int sjw_shift;
+
+	canbtr = ESD_USB2_UBR;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		canbtr |= ESD_USB2_LOM;
+
+	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
+
+	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) ==
+	    USB_CANUSBM_PRODUCT_ID)
+		sjw_shift = ESD_USBM_SJW_SHIFT;
+	else
+		sjw_shift = ESD_USB2_SJW_SHIFT;
+
+	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
+		<< sjw_shift;
+	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
+		   & (ESD_USB2_TSEG1_MAX - 1))
+		<< ESD_USB2_TSEG1_SHIFT;
+	canbtr |= ((bt->phase_seg2 - 1) & (ESD_USB2_TSEG2_MAX - 1))
+		<< ESD_USB2_TSEG2_SHIFT;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		canbtr |= ESD_USB2_3_SAMPLES;
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->msg.hdr.len = 2;
+	msg->msg.hdr.cmd = CMD_SETBAUD;
+	msg->msg.setbaud.net = priv->index;
+	msg->msg.setbaud.rsvd = 0;
+	msg->msg.setbaud.baud = cpu_to_le32(canbtr);
+
+	netdev_info(netdev, "setting BTR=%#x\n", canbtr);
+
+	err = esd_usb2_send_msg(priv->usb2, msg);
+
+	kfree(msg);
+	return err;
+}
+
+static int esd_usb2_get_berr_counter(const struct net_device *netdev,
+				     struct can_berr_counter *bec)
+{
+	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
+
+	bec->txerr = priv->bec.txerr;
+	bec->rxerr = priv->bec.rxerr;
+
+	return 0;
+}
+
+static int esd_usb2_set_mode(struct net_device *netdev, enum can_mode mode)
+{
+	switch (mode) {
+	case CAN_MODE_START:
+		netif_wake_queue(netdev);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
+{
+	struct esd_usb2 *dev = usb_get_intfdata(intf);
+	struct net_device *netdev;
+	struct esd_usb2_net_priv *priv;
+	int err = 0;
+	int i;
+
+	netdev = alloc_candev(sizeof(*priv), MAX_TX_URBS);
+	if (!netdev) {
+		dev_err(&intf->dev, "couldn't alloc candev\n");
+		err = -ENOMEM;
+		goto done;
+	}
+
+	priv = netdev_priv(netdev);
+
+	init_usb_anchor(&priv->tx_submitted);
+	atomic_set(&priv->active_tx_jobs, 0);
+
+	for (i = 0; i < MAX_TX_URBS; i++)
+		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
+
+	priv->usb2 = dev;
+	priv->netdev = netdev;
+	priv->index = index;
+
+	priv->can.state = CAN_STATE_STOPPED;
+	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
+		CAN_CTRLMODE_CC_LEN8_DLC;
+
+	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
+	    USB_CANUSBM_PRODUCT_ID)
+		priv->can.clock.freq = ESD_USBM_CAN_CLOCK;
+	else {
+		priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
+		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
+	}
+
+	priv->can.bittiming_const = &esd_usb2_bittiming_const;
+	priv->can.do_set_bittiming = esd_usb2_set_bittiming;
+	priv->can.do_set_mode = esd_usb2_set_mode;
+	priv->can.do_get_berr_counter = esd_usb2_get_berr_counter;
+
+	netdev->flags |= IFF_ECHO; /* we support local echo */
+
+	netdev->netdev_ops = &esd_usb2_netdev_ops;
+
+	SET_NETDEV_DEV(netdev, &intf->dev);
+	netdev->dev_id = index;
+
+	err = register_candev(netdev);
+	if (err) {
+		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
+		free_candev(netdev);
+		err = -ENOMEM;
+		goto done;
+	}
+
+	dev->nets[index] = priv;
+	netdev_info(netdev, "device %s registered\n", netdev->name);
+
+done:
+	return err;
+}
+
+/*
+ * probe function for new USB2 devices
+ *
+ * check version information and number of available
+ * CAN interfaces
+ */
+static int esd_usb2_probe(struct usb_interface *intf,
+			 const struct usb_device_id *id)
+{
+	struct esd_usb2 *dev;
+	struct esd_usb2_msg *msg;
+	int i, err;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	dev->udev = interface_to_usbdev(intf);
+
+	init_usb_anchor(&dev->rx_submitted);
+
+	usb_set_intfdata(intf, dev);
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg) {
+		err = -ENOMEM;
+		goto free_msg;
+	}
+
+	/* query number of CAN interfaces (nets) */
+	msg->msg.hdr.cmd = CMD_VERSION;
+	msg->msg.hdr.len = 2;
+	msg->msg.version.rsvd = 0;
+	msg->msg.version.flags = 0;
+	msg->msg.version.drv_version = 0;
+
+	err = esd_usb2_send_msg(dev, msg);
+	if (err < 0) {
+		dev_err(&intf->dev, "sending version message failed\n");
+		goto free_msg;
+	}
+
+	err = esd_usb2_wait_msg(dev, msg);
+	if (err < 0) {
+		dev_err(&intf->dev, "no version message answer\n");
+		goto free_msg;
+	}
+
+	dev->net_count = (int)msg->msg.version_reply.nets;
+	dev->version = le32_to_cpu(msg->msg.version_reply.version);
+
+	if (device_create_file(&intf->dev, &dev_attr_firmware))
+		dev_err(&intf->dev,
+			"Couldn't create device file for firmware\n");
+
+	if (device_create_file(&intf->dev, &dev_attr_hardware))
+		dev_err(&intf->dev,
+			"Couldn't create device file for hardware\n");
+
+	if (device_create_file(&intf->dev, &dev_attr_nets))
+		dev_err(&intf->dev,
+			"Couldn't create device file for nets\n");
+
+	/* do per device probing */
+	for (i = 0; i < dev->net_count; i++)
+		esd_usb2_probe_one_net(intf, i);
+
+free_msg:
+	kfree(msg);
+	if (err)
+		kfree(dev);
+done:
+	return err;
+}
+
+/*
+ * called by the usb core when the device is removed from the system
+ */
+static void esd_usb2_disconnect(struct usb_interface *intf)
+{
+	struct esd_usb2 *dev = usb_get_intfdata(intf);
+	struct net_device *netdev;
+	int i;
+
+	device_remove_file(&intf->dev, &dev_attr_firmware);
+	device_remove_file(&intf->dev, &dev_attr_hardware);
+	device_remove_file(&intf->dev, &dev_attr_nets);
+
+	usb_set_intfdata(intf, NULL);
+
+	if (dev) {
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i]) {
+				netdev = dev->nets[i]->netdev;
+				unregister_netdev(netdev);
+			}
+		}
+		unlink_all_urbs(dev);
+		for (i = 0; i < dev->net_count; i++) {
+			if (dev->nets[i])
+				free_candev(dev->nets[i]->netdev);
+		}
+		kfree(dev);
+	}
+}
+
+/* usb specific object needed to register this driver with the usb subsystem */
+static struct usb_driver esd_usb2_driver = {
+	.name = "esd_usb2",
+	.probe = esd_usb2_probe,
+	.disconnect = esd_usb2_disconnect,
+	.id_table = esd_usb2_table,
+};
+
+module_usb_driver(esd_usb2_driver);
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
deleted file mode 100644
index 1430edf88983..000000000000
--- a/drivers/net/can/usb/esd_usb2.c
+++ /dev/null
@@ -1,1170 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CAN driver for esd CAN-USB/2 and CAN-USB/Micro
- *
- * Copyright (C) 2010-2012 Matthias Fuchs <matthias.fuchs@esd.eu>, esd gmbh
- */
-#include <linux/signal.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/usb.h>
-
-#include <linux/can.h>
-#include <linux/can/dev.h>
-#include <linux/can/error.h>
-
-MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd.eu>");
-MODULE_DESCRIPTION("CAN driver for esd CAN-USB/2 and CAN-USB/Micro interfaces");
-MODULE_LICENSE("GPL v2");
-
-/* Define these values to match your devices */
-#define USB_ESDGMBH_VENDOR_ID	0x0ab4
-#define USB_CANUSB2_PRODUCT_ID	0x0010
-#define USB_CANUSBM_PRODUCT_ID	0x0011
-
-#define ESD_USB2_CAN_CLOCK	60000000
-#define ESD_USBM_CAN_CLOCK	36000000
-#define ESD_USB2_MAX_NETS	2
-
-/* USB2 commands */
-#define CMD_VERSION		1 /* also used for VERSION_REPLY */
-#define CMD_CAN_RX		2 /* device to host only */
-#define CMD_CAN_TX		3 /* also used for TX_DONE */
-#define CMD_SETBAUD		4 /* also used for SETBAUD_REPLY */
-#define CMD_TS			5 /* also used for TS_REPLY */
-#define CMD_IDADD		6 /* also used for IDADD_REPLY */
-
-/* esd CAN message flags - dlc field */
-#define ESD_RTR			0x10
-
-/* esd CAN message flags - id field */
-#define ESD_EXTID		0x20000000
-#define ESD_EVENT		0x40000000
-#define ESD_IDMASK		0x1fffffff
-
-/* esd CAN event ids used by this driver */
-#define ESD_EV_CAN_ERROR_EXT	2
-
-/* baudrate message flags */
-#define ESD_USB2_UBR		0x80000000
-#define ESD_USB2_LOM		0x40000000
-#define ESD_USB2_NO_BAUDRATE	0x7fffffff
-#define ESD_USB2_TSEG1_MIN	1
-#define ESD_USB2_TSEG1_MAX	16
-#define ESD_USB2_TSEG1_SHIFT	16
-#define ESD_USB2_TSEG2_MIN	1
-#define ESD_USB2_TSEG2_MAX	8
-#define ESD_USB2_TSEG2_SHIFT	20
-#define ESD_USB2_SJW_MAX	4
-#define ESD_USB2_SJW_SHIFT	14
-#define ESD_USBM_SJW_SHIFT	24
-#define ESD_USB2_BRP_MIN	1
-#define ESD_USB2_BRP_MAX	1024
-#define ESD_USB2_BRP_INC	1
-#define ESD_USB2_3_SAMPLES	0x00800000
-
-/* esd IDADD message */
-#define ESD_ID_ENABLE		0x80
-#define ESD_MAX_ID_SEGMENT	64
-
-/* SJA1000 ECC register (emulated by usb2 firmware) */
-#define SJA1000_ECC_SEG		0x1F
-#define SJA1000_ECC_DIR		0x20
-#define SJA1000_ECC_ERR		0x06
-#define SJA1000_ECC_BIT		0x00
-#define SJA1000_ECC_FORM	0x40
-#define SJA1000_ECC_STUFF	0x80
-#define SJA1000_ECC_MASK	0xc0
-
-/* esd bus state event codes */
-#define ESD_BUSSTATE_MASK	0xc0
-#define ESD_BUSSTATE_WARN	0x40
-#define ESD_BUSSTATE_ERRPASSIVE	0x80
-#define ESD_BUSSTATE_BUSOFF	0xc0
-
-#define RX_BUFFER_SIZE		1024
-#define MAX_RX_URBS		4
-#define MAX_TX_URBS		16 /* must be power of 2 */
-
-struct header_msg {
-	u8 len; /* len is always the total message length in 32bit words */
-	u8 cmd;
-	u8 rsvd[2];
-};
-
-struct version_msg {
-	u8 len;
-	u8 cmd;
-	u8 rsvd;
-	u8 flags;
-	__le32 drv_version;
-};
-
-struct version_reply_msg {
-	u8 len;
-	u8 cmd;
-	u8 nets;
-	u8 features;
-	__le32 version;
-	u8 name[16];
-	__le32 rsvd;
-	__le32 ts;
-};
-
-struct rx_msg {
-	u8 len;
-	u8 cmd;
-	u8 net;
-	u8 dlc;
-	__le32 ts;
-	__le32 id; /* upper 3 bits contain flags */
-	u8 data[8];
-};
-
-struct tx_msg {
-	u8 len;
-	u8 cmd;
-	u8 net;
-	u8 dlc;
-	u32 hnd;	/* opaque handle, not used by device */
-	__le32 id; /* upper 3 bits contain flags */
-	u8 data[8];
-};
-
-struct tx_done_msg {
-	u8 len;
-	u8 cmd;
-	u8 net;
-	u8 status;
-	u32 hnd;	/* opaque handle, not used by device */
-	__le32 ts;
-};
-
-struct id_filter_msg {
-	u8 len;
-	u8 cmd;
-	u8 net;
-	u8 option;
-	__le32 mask[ESD_MAX_ID_SEGMENT + 1];
-};
-
-struct set_baudrate_msg {
-	u8 len;
-	u8 cmd;
-	u8 net;
-	u8 rsvd;
-	__le32 baud;
-};
-
-/* Main message type used between library and application */
-struct __attribute__ ((packed)) esd_usb2_msg {
-	union {
-		struct header_msg hdr;
-		struct version_msg version;
-		struct version_reply_msg version_reply;
-		struct rx_msg rx;
-		struct tx_msg tx;
-		struct tx_done_msg txdone;
-		struct set_baudrate_msg setbaud;
-		struct id_filter_msg filter;
-	} msg;
-};
-
-static struct usb_device_id esd_usb2_table[] = {
-	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSB2_PRODUCT_ID)},
-	{USB_DEVICE(USB_ESDGMBH_VENDOR_ID, USB_CANUSBM_PRODUCT_ID)},
-	{}
-};
-MODULE_DEVICE_TABLE(usb, esd_usb2_table);
-
-struct esd_usb2_net_priv;
-
-struct esd_tx_urb_context {
-	struct esd_usb2_net_priv *priv;
-	u32 echo_index;
-	int len;	/* CAN payload length */
-};
-
-struct esd_usb2 {
-	struct usb_device *udev;
-	struct esd_usb2_net_priv *nets[ESD_USB2_MAX_NETS];
-
-	struct usb_anchor rx_submitted;
-
-	int net_count;
-	u32 version;
-	int rxinitdone;
-	void *rxbuf[MAX_RX_URBS];
-	dma_addr_t rxbuf_dma[MAX_RX_URBS];
-};
-
-struct esd_usb2_net_priv {
-	struct can_priv can; /* must be the first member */
-
-	atomic_t active_tx_jobs;
-	struct usb_anchor tx_submitted;
-	struct esd_tx_urb_context tx_contexts[MAX_TX_URBS];
-
-	struct esd_usb2 *usb2;
-	struct net_device *netdev;
-	int index;
-	u8 old_state;
-	struct can_berr_counter bec;
-};
-
-static void esd_usb2_rx_event(struct esd_usb2_net_priv *priv,
-			      struct esd_usb2_msg *msg)
-{
-	struct net_device_stats *stats = &priv->netdev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
-	u32 id = le32_to_cpu(msg->msg.rx.id) & ESD_IDMASK;
-
-	if (id == ESD_EV_CAN_ERROR_EXT) {
-		u8 state = msg->msg.rx.data[0];
-		u8 ecc = msg->msg.rx.data[1];
-		u8 rxerr = msg->msg.rx.data[2];
-		u8 txerr = msg->msg.rx.data[3];
-
-		netdev_dbg(priv->netdev,
-			   "CAN_ERR_EV_EXT: dlc=%#02x state=%02x ecc=%02x rec=%02x tec=%02x\n",
-			   msg->msg.rx.dlc, state, ecc, rxerr, txerr);
-
-		skb = alloc_can_err_skb(priv->netdev, &cf);
-		if (skb == NULL) {
-			stats->rx_dropped++;
-			return;
-		}
-
-		if (state != priv->old_state) {
-			priv->old_state = state;
-
-			switch (state & ESD_BUSSTATE_MASK) {
-			case ESD_BUSSTATE_BUSOFF:
-				priv->can.state = CAN_STATE_BUS_OFF;
-				cf->can_id |= CAN_ERR_BUSOFF;
-				priv->can.can_stats.bus_off++;
-				can_bus_off(priv->netdev);
-				break;
-			case ESD_BUSSTATE_WARN:
-				priv->can.state = CAN_STATE_ERROR_WARNING;
-				priv->can.can_stats.error_warning++;
-				break;
-			case ESD_BUSSTATE_ERRPASSIVE:
-				priv->can.state = CAN_STATE_ERROR_PASSIVE;
-				priv->can.can_stats.error_passive++;
-				break;
-			default:
-				priv->can.state = CAN_STATE_ERROR_ACTIVE;
-				txerr = 0;
-				rxerr = 0;
-				break;
-			}
-		} else {
-			priv->can.can_stats.bus_error++;
-			stats->rx_errors++;
-
-			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-			switch (ecc & SJA1000_ECC_MASK) {
-			case SJA1000_ECC_BIT:
-				cf->data[2] |= CAN_ERR_PROT_BIT;
-				break;
-			case SJA1000_ECC_FORM:
-				cf->data[2] |= CAN_ERR_PROT_FORM;
-				break;
-			case SJA1000_ECC_STUFF:
-				cf->data[2] |= CAN_ERR_PROT_STUFF;
-				break;
-			default:
-				break;
-			}
-
-			/* Error occurred during transmission? */
-			if (!(ecc & SJA1000_ECC_DIR))
-				cf->data[2] |= CAN_ERR_PROT_TX;
-
-			/* Bit stream position in CAN frame as the error was detected */
-			cf->data[3] = ecc & SJA1000_ECC_SEG;
-
-			if (priv->can.state == CAN_STATE_ERROR_WARNING ||
-			    priv->can.state == CAN_STATE_ERROR_PASSIVE) {
-				cf->data[1] = (txerr > rxerr) ?
-					CAN_ERR_CRTL_TX_PASSIVE :
-					CAN_ERR_CRTL_RX_PASSIVE;
-			}
-			cf->data[6] = txerr;
-			cf->data[7] = rxerr;
-		}
-
-		priv->bec.txerr = txerr;
-		priv->bec.rxerr = rxerr;
-
-		netif_rx(skb);
-	}
-}
-
-static void esd_usb2_rx_can_msg(struct esd_usb2_net_priv *priv,
-				struct esd_usb2_msg *msg)
-{
-	struct net_device_stats *stats = &priv->netdev->stats;
-	struct can_frame *cf;
-	struct sk_buff *skb;
-	int i;
-	u32 id;
-
-	if (!netif_device_present(priv->netdev))
-		return;
-
-	id = le32_to_cpu(msg->msg.rx.id);
-
-	if (id & ESD_EVENT) {
-		esd_usb2_rx_event(priv, msg);
-	} else {
-		skb = alloc_can_skb(priv->netdev, &cf);
-		if (skb == NULL) {
-			stats->rx_dropped++;
-			return;
-		}
-
-		cf->can_id = id & ESD_IDMASK;
-		can_frame_set_cc_len(cf, msg->msg.rx.dlc & ~ESD_RTR,
-				     priv->can.ctrlmode);
-
-		if (id & ESD_EXTID)
-			cf->can_id |= CAN_EFF_FLAG;
-
-		if (msg->msg.rx.dlc & ESD_RTR) {
-			cf->can_id |= CAN_RTR_FLAG;
-		} else {
-			for (i = 0; i < cf->len; i++)
-				cf->data[i] = msg->msg.rx.data[i];
-		}
-
-		stats->rx_packets++;
-		stats->rx_bytes += cf->len;
-		netif_rx(skb);
-	}
-
-	return;
-}
-
-static void esd_usb2_tx_done_msg(struct esd_usb2_net_priv *priv,
-				 struct esd_usb2_msg *msg)
-{
-	struct net_device_stats *stats = &priv->netdev->stats;
-	struct net_device *netdev = priv->netdev;
-	struct esd_tx_urb_context *context;
-
-	if (!netif_device_present(netdev))
-		return;
-
-	context = &priv->tx_contexts[msg->msg.txdone.hnd & (MAX_TX_URBS - 1)];
-
-	if (!msg->msg.txdone.status) {
-		stats->tx_packets++;
-		stats->tx_bytes += context->len;
-		can_get_echo_skb(netdev, context->echo_index, NULL);
-	} else {
-		stats->tx_errors++;
-		can_free_echo_skb(netdev, context->echo_index, NULL);
-	}
-
-	/* Release context */
-	context->echo_index = MAX_TX_URBS;
-	atomic_dec(&priv->active_tx_jobs);
-
-	netif_wake_queue(netdev);
-}
-
-static void esd_usb2_read_bulk_callback(struct urb *urb)
-{
-	struct esd_usb2 *dev = urb->context;
-	int retval;
-	int pos = 0;
-	int i;
-
-	switch (urb->status) {
-	case 0: /* success */
-		break;
-
-	case -ENOENT:
-	case -EPIPE:
-	case -EPROTO:
-	case -ESHUTDOWN:
-		return;
-
-	default:
-		dev_info(dev->udev->dev.parent,
-			 "Rx URB aborted (%d)\n", urb->status);
-		goto resubmit_urb;
-	}
-
-	while (pos < urb->actual_length) {
-		struct esd_usb2_msg *msg;
-
-		msg = (struct esd_usb2_msg *)(urb->transfer_buffer + pos);
-
-		switch (msg->msg.hdr.cmd) {
-		case CMD_CAN_RX:
-			if (msg->msg.rx.net >= dev->net_count) {
-				dev_err(dev->udev->dev.parent, "format error\n");
-				break;
-			}
-
-			esd_usb2_rx_can_msg(dev->nets[msg->msg.rx.net], msg);
-			break;
-
-		case CMD_CAN_TX:
-			if (msg->msg.txdone.net >= dev->net_count) {
-				dev_err(dev->udev->dev.parent, "format error\n");
-				break;
-			}
-
-			esd_usb2_tx_done_msg(dev->nets[msg->msg.txdone.net],
-					     msg);
-			break;
-		}
-
-		pos += msg->msg.hdr.len << 2;
-
-		if (pos > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "format error\n");
-			break;
-		}
-	}
-
-resubmit_urb:
-	usb_fill_bulk_urb(urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-			  urb->transfer_buffer, RX_BUFFER_SIZE,
-			  esd_usb2_read_bulk_callback, dev);
-
-	usb_anchor_urb(urb, &dev->rx_submitted);
-
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (!retval)
-		return;
-
-	usb_unanchor_urb(urb);
-
-	if (retval == -ENODEV) {
-		for (i = 0; i < dev->net_count; i++) {
-			if (dev->nets[i])
-				netif_device_detach(dev->nets[i]->netdev);
-		}
-	} else {
-		dev_err(dev->udev->dev.parent,
-			"failed resubmitting read bulk urb: %d\n", retval);
-	}
-
-	return;
-}
-
-/*
- * callback for bulk IN urb
- */
-static void esd_usb2_write_bulk_callback(struct urb *urb)
-{
-	struct esd_tx_urb_context *context = urb->context;
-	struct esd_usb2_net_priv *priv;
-	struct net_device *netdev;
-	size_t size = sizeof(struct esd_usb2_msg);
-
-	WARN_ON(!context);
-
-	priv = context->priv;
-	netdev = priv->netdev;
-
-	/* free up our allocated buffer */
-	usb_free_coherent(urb->dev, size,
-			  urb->transfer_buffer, urb->transfer_dma);
-
-	if (!netif_device_present(netdev))
-		return;
-
-	if (urb->status)
-		netdev_info(netdev, "Tx URB aborted (%d)\n", urb->status);
-
-	netif_trans_update(netdev);
-}
-
-static ssize_t firmware_show(struct device *d,
-			     struct device_attribute *attr, char *buf)
-{
-	struct usb_interface *intf = to_usb_interface(d);
-	struct esd_usb2 *dev = usb_get_intfdata(intf);
-
-	return sprintf(buf, "%d.%d.%d\n",
-		       (dev->version >> 12) & 0xf,
-		       (dev->version >> 8) & 0xf,
-		       dev->version & 0xff);
-}
-static DEVICE_ATTR_RO(firmware);
-
-static ssize_t hardware_show(struct device *d,
-			     struct device_attribute *attr, char *buf)
-{
-	struct usb_interface *intf = to_usb_interface(d);
-	struct esd_usb2 *dev = usb_get_intfdata(intf);
-
-	return sprintf(buf, "%d.%d.%d\n",
-		       (dev->version >> 28) & 0xf,
-		       (dev->version >> 24) & 0xf,
-		       (dev->version >> 16) & 0xff);
-}
-static DEVICE_ATTR_RO(hardware);
-
-static ssize_t nets_show(struct device *d,
-			 struct device_attribute *attr, char *buf)
-{
-	struct usb_interface *intf = to_usb_interface(d);
-	struct esd_usb2 *dev = usb_get_intfdata(intf);
-
-	return sprintf(buf, "%d", dev->net_count);
-}
-static DEVICE_ATTR_RO(nets);
-
-static int esd_usb2_send_msg(struct esd_usb2 *dev, struct esd_usb2_msg *msg)
-{
-	int actual_length;
-
-	return usb_bulk_msg(dev->udev,
-			    usb_sndbulkpipe(dev->udev, 2),
-			    msg,
-			    msg->msg.hdr.len << 2,
-			    &actual_length,
-			    1000);
-}
-
-static int esd_usb2_wait_msg(struct esd_usb2 *dev,
-			     struct esd_usb2_msg *msg)
-{
-	int actual_length;
-
-	return usb_bulk_msg(dev->udev,
-			    usb_rcvbulkpipe(dev->udev, 1),
-			    msg,
-			    sizeof(*msg),
-			    &actual_length,
-			    1000);
-}
-
-static int esd_usb2_setup_rx_urbs(struct esd_usb2 *dev)
-{
-	int i, err = 0;
-
-	if (dev->rxinitdone)
-		return 0;
-
-	for (i = 0; i < MAX_RX_URBS; i++) {
-		struct urb *urb = NULL;
-		u8 *buf = NULL;
-		dma_addr_t buf_dma;
-
-		/* create a URB, and a buffer for it */
-		urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!urb) {
-			err = -ENOMEM;
-			break;
-		}
-
-		buf = usb_alloc_coherent(dev->udev, RX_BUFFER_SIZE, GFP_KERNEL,
-					 &buf_dma);
-		if (!buf) {
-			dev_warn(dev->udev->dev.parent,
-				 "No memory left for USB buffer\n");
-			err = -ENOMEM;
-			goto freeurb;
-		}
-
-		urb->transfer_dma = buf_dma;
-
-		usb_fill_bulk_urb(urb, dev->udev,
-				  usb_rcvbulkpipe(dev->udev, 1),
-				  buf, RX_BUFFER_SIZE,
-				  esd_usb2_read_bulk_callback, dev);
-		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-		usb_anchor_urb(urb, &dev->rx_submitted);
-
-		err = usb_submit_urb(urb, GFP_KERNEL);
-		if (err) {
-			usb_unanchor_urb(urb);
-			usb_free_coherent(dev->udev, RX_BUFFER_SIZE, buf,
-					  urb->transfer_dma);
-			goto freeurb;
-		}
-
-		dev->rxbuf[i] = buf;
-		dev->rxbuf_dma[i] = buf_dma;
-
-freeurb:
-		/* Drop reference, USB core will take care of freeing it */
-		usb_free_urb(urb);
-		if (err)
-			break;
-	}
-
-	/* Did we submit any URBs */
-	if (i == 0) {
-		dev_err(dev->udev->dev.parent, "couldn't setup read URBs\n");
-		return err;
-	}
-
-	/* Warn if we've couldn't transmit all the URBs */
-	if (i < MAX_RX_URBS) {
-		dev_warn(dev->udev->dev.parent,
-			 "rx performance may be slow\n");
-	}
-
-	dev->rxinitdone = 1;
-	return 0;
-}
-
-/*
- * Start interface
- */
-static int esd_usb2_start(struct esd_usb2_net_priv *priv)
-{
-	struct esd_usb2 *dev = priv->usb2;
-	struct net_device *netdev = priv->netdev;
-	struct esd_usb2_msg *msg;
-	int err, i;
-
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	/*
-	 * Enable all IDs
-	 * The IDADD message takes up to 64 32 bit bitmasks (2048 bits).
-	 * Each bit represents one 11 bit CAN identifier. A set bit
-	 * enables reception of the corresponding CAN identifier. A cleared
-	 * bit disabled this identifier. An additional bitmask value
-	 * following the CAN 2.0A bits is used to enable reception of
-	 * extended CAN frames. Only the LSB of this final mask is checked
-	 * for the complete 29 bit ID range. The IDADD message also allows
-	 * filter configuration for an ID subset. In this case you can add
-	 * the number of the starting bitmask (0..64) to the filter.option
-	 * field followed by only some bitmasks.
-	 */
-	msg->msg.hdr.cmd = CMD_IDADD;
-	msg->msg.hdr.len = 2 + ESD_MAX_ID_SEGMENT;
-	msg->msg.filter.net = priv->index;
-	msg->msg.filter.option = ESD_ID_ENABLE; /* start with segment 0 */
-	for (i = 0; i < ESD_MAX_ID_SEGMENT; i++)
-		msg->msg.filter.mask[i] = cpu_to_le32(0xffffffff);
-	/* enable 29bit extended IDs */
-	msg->msg.filter.mask[ESD_MAX_ID_SEGMENT] = cpu_to_le32(0x00000001);
-
-	err = esd_usb2_send_msg(dev, msg);
-	if (err)
-		goto out;
-
-	err = esd_usb2_setup_rx_urbs(dev);
-	if (err)
-		goto out;
-
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
-
-out:
-	if (err == -ENODEV)
-		netif_device_detach(netdev);
-	if (err)
-		netdev_err(netdev, "couldn't start device: %d\n", err);
-
-	kfree(msg);
-	return err;
-}
-
-static void unlink_all_urbs(struct esd_usb2 *dev)
-{
-	struct esd_usb2_net_priv *priv;
-	int i, j;
-
-	usb_kill_anchored_urbs(&dev->rx_submitted);
-
-	for (i = 0; i < MAX_RX_URBS; ++i)
-		usb_free_coherent(dev->udev, RX_BUFFER_SIZE,
-				  dev->rxbuf[i], dev->rxbuf_dma[i]);
-
-	for (i = 0; i < dev->net_count; i++) {
-		priv = dev->nets[i];
-		if (priv) {
-			usb_kill_anchored_urbs(&priv->tx_submitted);
-			atomic_set(&priv->active_tx_jobs, 0);
-
-			for (j = 0; j < MAX_TX_URBS; j++)
-				priv->tx_contexts[j].echo_index = MAX_TX_URBS;
-		}
-	}
-}
-
-static int esd_usb2_open(struct net_device *netdev)
-{
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-	int err;
-
-	/* common open */
-	err = open_candev(netdev);
-	if (err)
-		return err;
-
-	/* finally start device */
-	err = esd_usb2_start(priv);
-	if (err) {
-		netdev_warn(netdev, "couldn't start device: %d\n", err);
-		close_candev(netdev);
-		return err;
-	}
-
-	netif_start_queue(netdev);
-
-	return 0;
-}
-
-static netdev_tx_t esd_usb2_start_xmit(struct sk_buff *skb,
-				      struct net_device *netdev)
-{
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-	struct esd_usb2 *dev = priv->usb2;
-	struct esd_tx_urb_context *context = NULL;
-	struct net_device_stats *stats = &netdev->stats;
-	struct can_frame *cf = (struct can_frame *)skb->data;
-	struct esd_usb2_msg *msg;
-	struct urb *urb;
-	u8 *buf;
-	int i, err;
-	int ret = NETDEV_TX_OK;
-	size_t size = sizeof(struct esd_usb2_msg);
-
-	if (can_dropped_invalid_skb(netdev, skb))
-		return NETDEV_TX_OK;
-
-	/* create a URB, and a buffer for it, and copy the data to the URB */
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!urb) {
-		stats->tx_dropped++;
-		dev_kfree_skb(skb);
-		goto nourbmem;
-	}
-
-	buf = usb_alloc_coherent(dev->udev, size, GFP_ATOMIC,
-				 &urb->transfer_dma);
-	if (!buf) {
-		netdev_err(netdev, "No memory left for USB buffer\n");
-		stats->tx_dropped++;
-		dev_kfree_skb(skb);
-		goto nobufmem;
-	}
-
-	msg = (struct esd_usb2_msg *)buf;
-
-	msg->msg.hdr.len = 3; /* minimal length */
-	msg->msg.hdr.cmd = CMD_CAN_TX;
-	msg->msg.tx.net = priv->index;
-	msg->msg.tx.dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
-	msg->msg.tx.id = cpu_to_le32(cf->can_id & CAN_ERR_MASK);
-
-	if (cf->can_id & CAN_RTR_FLAG)
-		msg->msg.tx.dlc |= ESD_RTR;
-
-	if (cf->can_id & CAN_EFF_FLAG)
-		msg->msg.tx.id |= cpu_to_le32(ESD_EXTID);
-
-	for (i = 0; i < cf->len; i++)
-		msg->msg.tx.data[i] = cf->data[i];
-
-	msg->msg.hdr.len += (cf->len + 3) >> 2;
-
-	for (i = 0; i < MAX_TX_URBS; i++) {
-		if (priv->tx_contexts[i].echo_index == MAX_TX_URBS) {
-			context = &priv->tx_contexts[i];
-			break;
-		}
-	}
-
-	/*
-	 * This may never happen.
-	 */
-	if (!context) {
-		netdev_warn(netdev, "couldn't find free context\n");
-		ret = NETDEV_TX_BUSY;
-		goto releasebuf;
-	}
-
-	context->priv = priv;
-	context->echo_index = i;
-	context->len = cf->len;
-
-	/* hnd must not be 0 - MSB is stripped in txdone handling */
-	msg->msg.tx.hnd = 0x80000000 | i; /* returned in TX done message */
-
-	usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 2), buf,
-			  msg->msg.hdr.len << 2,
-			  esd_usb2_write_bulk_callback, context);
-
-	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
-
-	usb_anchor_urb(urb, &priv->tx_submitted);
-
-	can_put_echo_skb(skb, netdev, context->echo_index, 0);
-
-	atomic_inc(&priv->active_tx_jobs);
-
-	/* Slow down tx path */
-	if (atomic_read(&priv->active_tx_jobs) >= MAX_TX_URBS)
-		netif_stop_queue(netdev);
-
-	err = usb_submit_urb(urb, GFP_ATOMIC);
-	if (err) {
-		can_free_echo_skb(netdev, context->echo_index, NULL);
-
-		atomic_dec(&priv->active_tx_jobs);
-		usb_unanchor_urb(urb);
-
-		stats->tx_dropped++;
-
-		if (err == -ENODEV)
-			netif_device_detach(netdev);
-		else
-			netdev_warn(netdev, "failed tx_urb %d\n", err);
-
-		goto releasebuf;
-	}
-
-	netif_trans_update(netdev);
-
-	/*
-	 * Release our reference to this URB, the USB core will eventually free
-	 * it entirely.
-	 */
-	usb_free_urb(urb);
-
-	return NETDEV_TX_OK;
-
-releasebuf:
-	usb_free_coherent(dev->udev, size, buf, urb->transfer_dma);
-
-nobufmem:
-	usb_free_urb(urb);
-
-nourbmem:
-	return ret;
-}
-
-static int esd_usb2_close(struct net_device *netdev)
-{
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-	struct esd_usb2_msg *msg;
-	int i;
-
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	/* Disable all IDs (see esd_usb2_start()) */
-	msg->msg.hdr.cmd = CMD_IDADD;
-	msg->msg.hdr.len = 2 + ESD_MAX_ID_SEGMENT;
-	msg->msg.filter.net = priv->index;
-	msg->msg.filter.option = ESD_ID_ENABLE; /* start with segment 0 */
-	for (i = 0; i <= ESD_MAX_ID_SEGMENT; i++)
-		msg->msg.filter.mask[i] = 0;
-	if (esd_usb2_send_msg(priv->usb2, msg) < 0)
-		netdev_err(netdev, "sending idadd message failed\n");
-
-	/* set CAN controller to reset mode */
-	msg->msg.hdr.len = 2;
-	msg->msg.hdr.cmd = CMD_SETBAUD;
-	msg->msg.setbaud.net = priv->index;
-	msg->msg.setbaud.rsvd = 0;
-	msg->msg.setbaud.baud = cpu_to_le32(ESD_USB2_NO_BAUDRATE);
-	if (esd_usb2_send_msg(priv->usb2, msg) < 0)
-		netdev_err(netdev, "sending setbaud message failed\n");
-
-	priv->can.state = CAN_STATE_STOPPED;
-
-	netif_stop_queue(netdev);
-
-	close_candev(netdev);
-
-	kfree(msg);
-
-	return 0;
-}
-
-static const struct net_device_ops esd_usb2_netdev_ops = {
-	.ndo_open = esd_usb2_open,
-	.ndo_stop = esd_usb2_close,
-	.ndo_start_xmit = esd_usb2_start_xmit,
-	.ndo_change_mtu = can_change_mtu,
-};
-
-static const struct can_bittiming_const esd_usb2_bittiming_const = {
-	.name = "esd_usb2",
-	.tseg1_min = ESD_USB2_TSEG1_MIN,
-	.tseg1_max = ESD_USB2_TSEG1_MAX,
-	.tseg2_min = ESD_USB2_TSEG2_MIN,
-	.tseg2_max = ESD_USB2_TSEG2_MAX,
-	.sjw_max = ESD_USB2_SJW_MAX,
-	.brp_min = ESD_USB2_BRP_MIN,
-	.brp_max = ESD_USB2_BRP_MAX,
-	.brp_inc = ESD_USB2_BRP_INC,
-};
-
-static int esd_usb2_set_bittiming(struct net_device *netdev)
-{
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-	struct can_bittiming *bt = &priv->can.bittiming;
-	struct esd_usb2_msg *msg;
-	int err;
-	u32 canbtr;
-	int sjw_shift;
-
-	canbtr = ESD_USB2_UBR;
-	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
-		canbtr |= ESD_USB2_LOM;
-
-	canbtr |= (bt->brp - 1) & (ESD_USB2_BRP_MAX - 1);
-
-	if (le16_to_cpu(priv->usb2->udev->descriptor.idProduct) ==
-	    USB_CANUSBM_PRODUCT_ID)
-		sjw_shift = ESD_USBM_SJW_SHIFT;
-	else
-		sjw_shift = ESD_USB2_SJW_SHIFT;
-
-	canbtr |= ((bt->sjw - 1) & (ESD_USB2_SJW_MAX - 1))
-		<< sjw_shift;
-	canbtr |= ((bt->prop_seg + bt->phase_seg1 - 1)
-		   & (ESD_USB2_TSEG1_MAX - 1))
-		<< ESD_USB2_TSEG1_SHIFT;
-	canbtr |= ((bt->phase_seg2 - 1) & (ESD_USB2_TSEG2_MAX - 1))
-		<< ESD_USB2_TSEG2_SHIFT;
-	if (priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
-		canbtr |= ESD_USB2_3_SAMPLES;
-
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	msg->msg.hdr.len = 2;
-	msg->msg.hdr.cmd = CMD_SETBAUD;
-	msg->msg.setbaud.net = priv->index;
-	msg->msg.setbaud.rsvd = 0;
-	msg->msg.setbaud.baud = cpu_to_le32(canbtr);
-
-	netdev_info(netdev, "setting BTR=%#x\n", canbtr);
-
-	err = esd_usb2_send_msg(priv->usb2, msg);
-
-	kfree(msg);
-	return err;
-}
-
-static int esd_usb2_get_berr_counter(const struct net_device *netdev,
-				     struct can_berr_counter *bec)
-{
-	struct esd_usb2_net_priv *priv = netdev_priv(netdev);
-
-	bec->txerr = priv->bec.txerr;
-	bec->rxerr = priv->bec.rxerr;
-
-	return 0;
-}
-
-static int esd_usb2_set_mode(struct net_device *netdev, enum can_mode mode)
-{
-	switch (mode) {
-	case CAN_MODE_START:
-		netif_wake_queue(netdev);
-		break;
-
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
-{
-	struct esd_usb2 *dev = usb_get_intfdata(intf);
-	struct net_device *netdev;
-	struct esd_usb2_net_priv *priv;
-	int err = 0;
-	int i;
-
-	netdev = alloc_candev(sizeof(*priv), MAX_TX_URBS);
-	if (!netdev) {
-		dev_err(&intf->dev, "couldn't alloc candev\n");
-		err = -ENOMEM;
-		goto done;
-	}
-
-	priv = netdev_priv(netdev);
-
-	init_usb_anchor(&priv->tx_submitted);
-	atomic_set(&priv->active_tx_jobs, 0);
-
-	for (i = 0; i < MAX_TX_URBS; i++)
-		priv->tx_contexts[i].echo_index = MAX_TX_URBS;
-
-	priv->usb2 = dev;
-	priv->netdev = netdev;
-	priv->index = index;
-
-	priv->can.state = CAN_STATE_STOPPED;
-	priv->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_CC_LEN8_DLC;
-
-	if (le16_to_cpu(dev->udev->descriptor.idProduct) ==
-	    USB_CANUSBM_PRODUCT_ID)
-		priv->can.clock.freq = ESD_USBM_CAN_CLOCK;
-	else {
-		priv->can.clock.freq = ESD_USB2_CAN_CLOCK;
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
-	}
-
-	priv->can.bittiming_const = &esd_usb2_bittiming_const;
-	priv->can.do_set_bittiming = esd_usb2_set_bittiming;
-	priv->can.do_set_mode = esd_usb2_set_mode;
-	priv->can.do_get_berr_counter = esd_usb2_get_berr_counter;
-
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
-	netdev->netdev_ops = &esd_usb2_netdev_ops;
-
-	SET_NETDEV_DEV(netdev, &intf->dev);
-	netdev->dev_id = index;
-
-	err = register_candev(netdev);
-	if (err) {
-		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
-		free_candev(netdev);
-		err = -ENOMEM;
-		goto done;
-	}
-
-	dev->nets[index] = priv;
-	netdev_info(netdev, "device %s registered\n", netdev->name);
-
-done:
-	return err;
-}
-
-/*
- * probe function for new USB2 devices
- *
- * check version information and number of available
- * CAN interfaces
- */
-static int esd_usb2_probe(struct usb_interface *intf,
-			 const struct usb_device_id *id)
-{
-	struct esd_usb2 *dev;
-	struct esd_usb2_msg *msg;
-	int i, err;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev) {
-		err = -ENOMEM;
-		goto done;
-	}
-
-	dev->udev = interface_to_usbdev(intf);
-
-	init_usb_anchor(&dev->rx_submitted);
-
-	usb_set_intfdata(intf, dev);
-
-	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		err = -ENOMEM;
-		goto free_msg;
-	}
-
-	/* query number of CAN interfaces (nets) */
-	msg->msg.hdr.cmd = CMD_VERSION;
-	msg->msg.hdr.len = 2;
-	msg->msg.version.rsvd = 0;
-	msg->msg.version.flags = 0;
-	msg->msg.version.drv_version = 0;
-
-	err = esd_usb2_send_msg(dev, msg);
-	if (err < 0) {
-		dev_err(&intf->dev, "sending version message failed\n");
-		goto free_msg;
-	}
-
-	err = esd_usb2_wait_msg(dev, msg);
-	if (err < 0) {
-		dev_err(&intf->dev, "no version message answer\n");
-		goto free_msg;
-	}
-
-	dev->net_count = (int)msg->msg.version_reply.nets;
-	dev->version = le32_to_cpu(msg->msg.version_reply.version);
-
-	if (device_create_file(&intf->dev, &dev_attr_firmware))
-		dev_err(&intf->dev,
-			"Couldn't create device file for firmware\n");
-
-	if (device_create_file(&intf->dev, &dev_attr_hardware))
-		dev_err(&intf->dev,
-			"Couldn't create device file for hardware\n");
-
-	if (device_create_file(&intf->dev, &dev_attr_nets))
-		dev_err(&intf->dev,
-			"Couldn't create device file for nets\n");
-
-	/* do per device probing */
-	for (i = 0; i < dev->net_count; i++)
-		esd_usb2_probe_one_net(intf, i);
-
-free_msg:
-	kfree(msg);
-	if (err)
-		kfree(dev);
-done:
-	return err;
-}
-
-/*
- * called by the usb core when the device is removed from the system
- */
-static void esd_usb2_disconnect(struct usb_interface *intf)
-{
-	struct esd_usb2 *dev = usb_get_intfdata(intf);
-	struct net_device *netdev;
-	int i;
-
-	device_remove_file(&intf->dev, &dev_attr_firmware);
-	device_remove_file(&intf->dev, &dev_attr_hardware);
-	device_remove_file(&intf->dev, &dev_attr_nets);
-
-	usb_set_intfdata(intf, NULL);
-
-	if (dev) {
-		for (i = 0; i < dev->net_count; i++) {
-			if (dev->nets[i]) {
-				netdev = dev->nets[i]->netdev;
-				unregister_netdev(netdev);
-				free_candev(netdev);
-			}
-		}
-		unlink_all_urbs(dev);
-		kfree(dev);
-	}
-}
-
-/* usb specific object needed to register this driver with the usb subsystem */
-static struct usb_driver esd_usb2_driver = {
-	.name = "esd_usb2",
-	.probe = esd_usb2_probe,
-	.disconnect = esd_usb2_disconnect,
-	.id_table = esd_usb2_table,
-};
-
-module_usb_driver(esd_usb2_driver);
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 17bf4cae7b2d..eb4a209ba136 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -333,7 +333,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (hf->echo_id == -1) { /* normal rx */
 		skb = alloc_can_skb(dev->netdev, &cf);
 		if (!skb)
-			return;
+			goto resubmit_urb;
 
 		cf->can_id = le32_to_cpu(hf->can_id);
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4063d4a6f47e..685fb78846c6 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -314,6 +314,31 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 	return !!budget;
 }
 
+void aq_ring_tx_deinit(struct aq_ring_s *self)
+{
+	if (!self)
+		return;
+
+	for (; self->sw_head != self->sw_tail;
+		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+		struct device *ndev = aq_nic_get_dev(self->aq_nic);
+
+		if (buff->is_mapped) {
+			if (buff->is_sop) {
+				dma_unmap_single(ndev, buff->pa, buff->len,
+						 DMA_TO_DEVICE);
+			} else {
+				dma_unmap_page(ndev, buff->pa, buff->len,
+					       DMA_TO_DEVICE);
+			}
+		}
+
+		if (buff->is_eop && buff->skb)
+			dev_kfree_skb_any(buff->skb);
+	}
+}
+
 static void aq_rx_checksum(struct aq_ring_s *self,
 			   struct aq_ring_buff_s *buff,
 			   struct sk_buff *skb)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 93659e58f1ce..3be56a4fc5bb 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -182,6 +182,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *ring);
 void aq_ring_queue_wake(struct aq_ring_s *ring);
 void aq_ring_queue_stop(struct aq_ring_s *ring);
 bool aq_ring_tx_clean(struct aq_ring_s *self);
+void aq_ring_tx_deinit(struct aq_ring_s *self);
 int aq_ring_rx_clean(struct aq_ring_s *self,
 		     struct napi_struct *napi,
 		     int *work_done,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 6ab1f3212d24..2d77554d1b81 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -270,7 +270,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
 
 	for (i = 0U; self->tx_rings > i; ++i) {
 		ring = self->ring[i];
-		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
+		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 97a3def81d18..6d816977ee81 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -477,18 +477,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
 
 	status = ice_vsi_cfg(vsi);
 	if (status)
-		goto err_setup_rx_ring;
+		goto err_cfg_lan;
 
 	status = ice_vsi_start_all_rx_rings(vsi);
 	if (status)
-		goto err_start_rx_ring;
+		goto err_cfg_lan;
 
 	return status;
 
-err_start_rx_ring:
-	ice_vsi_free_rx_rings(vsi);
-err_setup_rx_ring:
+err_cfg_lan:
 	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
+err_setup_rx_ring:
+	ice_vsi_free_rx_rings(vsi);
 err_setup_tx_ring:
 	ice_vsi_free_tx_rings(vsi);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0403391b3680..ebead7f44bc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4948,6 +4948,16 @@ static int __maybe_unused ice_resume(struct device *dev)
 	/* Restart the service task */
 	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
 
+	/* Best-effort wait for the scheduled reset to finish so that the
+	 * device is operational before returning. Without this, userspace
+	 * (e.g. NetworkManager) may try to open the net device while the
+	 * asynchronous reset is still in progress, hitting -EBUSY.
+	 */
+	ret = ice_wait_for_reset(pf, secs_to_jiffies(10));
+	if (ret)
+		dev_err(dev, "Wait for reset timed out (10s) during resume: %d\n",
+			ret);
+
 	return 0;
 }
 #endif /* CONFIG_PM */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f93551ee3cb4..da40c8a3b72b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1587,6 +1587,30 @@ static bool ice_is_vf_disabled(struct ice_vf *vf)
 		test_bit(ICE_VF_STATE_DIS, vf->vf_states));
 }
 
+/**
+ * ice_reset_interrupts - clear all queue interrupt configuration for a VSI
+ * @vsi: the VSI whose interrupt registers should be cleared
+ *
+ * Zero the QINT_RQCTL and QINT_TQCTL registers for all allocated queues
+ * in the VSI. This clears the entire register including MSIX_INDX, ITR_INDX,
+ * CAUSE_ENA and NEXTQ fields, unlike ice_vf_dis_rxq_interrupt() which only
+ * clears the CAUSE_ENA bit.
+ */
+static void ice_reset_interrupts(struct ice_vsi *vsi)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	int i;
+
+	ice_for_each_alloc_rxq(vsi, i)
+		wr32(hw, QINT_RQCTL(vsi->rxq_map[i]), 0);
+
+	ice_for_each_alloc_txq(vsi, i)
+		wr32(hw, QINT_TQCTL(vsi->txq_map[i]), 0);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_reset_vf - Reset a particular VF
  * @vf: pointer to the VF structure
@@ -1630,6 +1654,9 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 
 	ice_dis_vf_qs(vf);
 
+	/* cleanup interrupt registers */
+	ice_reset_interrupts(vsi);
+
 	/* Call Disable LAN Tx queue AQ whether or not queues are
 	 * enabled. This is needed for successful completion of VFR.
 	 */
@@ -3167,6 +3194,24 @@ static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);
 }
 
+/**
+ * ice_vf_dis_rxq_interrupt - disable Rx queue interrupt via QINT_RQCTL
+ * @vsi: VSI of the VF to configure
+ * @q_idx: VF queue index used to determine the queue in the PF's space
+ */
+static void ice_vf_dis_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 pfq = vsi->rxq_map[q_idx];
+	u32 reg;
+
+	reg = rd32(hw, QINT_RQCTL(pfq));
+	reg &= ~QINT_RQCTL_CAUSE_ENA_M;
+	wr32(hw, QINT_RQCTL(pfq), reg);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -3336,6 +3381,8 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
@@ -3356,6 +3403,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 			/* Clear enabled queues flag */
 			clear_bit(vf_q_id, vf->rxq_ena);
 		}
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index d2825170c1e1..f70fbd1d00a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4980,7 +4980,6 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 8c1ed8dd5078..5b070680c8e3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -441,7 +441,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
@@ -2250,7 +2250,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 	__rvu_mbox_up_handler(mwork, TYPE_AFVF);
 }
 
-static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
+static int rvu_get_mbox_regions(struct rvu *rvu, void __iomem **mbox_addr,
 				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -2275,7 +2275,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 				bar4 = rvupf_read64(rvu, RVU_PF_VF_BAR4_ADDR);
 				bar4 += region * MBOX_SIZE;
 			}
-			mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+			mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 			if (!mbox_addr[region])
 				goto error;
 		}
@@ -2298,7 +2298,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 					  RVU_AF_PF_BAR4_ADDR);
 			bar4 += region * MBOX_SIZE;
 		}
-		mbox_addr[region] = (void *)ioremap_wc(bar4, MBOX_SIZE);
+		mbox_addr[region] = ioremap_wc(bar4, MBOX_SIZE);
 		if (!mbox_addr[region])
 			goto error;
 	}
@@ -2306,7 +2306,7 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 
 error:
 	while (region--)
-		iounmap((void __iomem *)mbox_addr[region]);
+		iounmap(mbox_addr[region]);
 	return -ENOMEM;
 }
 
@@ -2316,10 +2316,10 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 			 void (mbox_up_handler)(struct work_struct *))
 {
 	int err = -EINVAL, i, dir, dir_up;
+	void __iomem **mbox_regions;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
 	unsigned long *pf_bmap;
-	void **mbox_regions;
 	const char *name;
 	u64 cfg;
 
@@ -2340,7 +2340,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		}
 	}
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	mbox_regions = kcalloc(num, sizeof(void __iomem *), GFP_KERNEL);
 	if (!mbox_regions) {
 		err = -ENOMEM;
 		goto free_bitmap;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9ce7c78e5127..dbfcf751d0bc 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -693,6 +693,7 @@ int rvu_get_pf(u16 pcifunc);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index 39870e419ccb..0b88dbe871d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -13,7 +13,6 @@
 /* RVU LMTST */
 #define LMT_TBL_OP_READ		0
 #define LMT_TBL_OP_WRITE	1
-#define LMT_MAP_TABLE_SIZE	(128 * 1024)
 #define LMT_MAPTBL_ENTRY_SIZE	16
 #define LMT_MAX_VFS		256
 
@@ -26,10 +25,14 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 {
 	void __iomem *lmt_map_base;
 	u64 tbl_base, cfg;
+	int pfs, vfs;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	cfg  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	vfs = 1 << (cfg & 0xF);
+	pfs = 1 << ((cfg >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, LMT_MAP_TABLE_SIZE);
+	lmt_map_base = ioremap_wc(tbl_base, pfs * vfs * LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		return -ENOMEM;
@@ -80,7 +83,7 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 
 	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
-	pf = rvu_get_pf(pcifunc) & 0x1F;
+	pf = rvu_get_pf(pcifunc) & RVU_PFVF_PF_MASK;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
 	      ((pcifunc & RVU_PFVF_FUNC_MASK) & 0xFF);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TXN_REQ, val);
@@ -175,6 +178,15 @@ int rvu_mbox_handler_lmtst_tbl_setup(struct rvu *rvu,
 	 * pcifunc (will be the one who is calling this mailbox).
 	 */
 	if (req->base_pcifunc) {
+		/* A VF is untrusted and must not redirect its LMTLINE to
+		 * another PF's region, so confine VF callers to their own PF.
+		 */
+		if (is_vf(req->hdr.pcifunc) &&
+		    (!is_pf_func_valid(rvu, req->base_pcifunc) ||
+		     rvu_get_pf(req->hdr.pcifunc) !=
+		     rvu_get_pf(req->base_pcifunc)))
+			return -EPERM;
+
 		/* Calculating the LMT table index equivalent to primary
 		 * pcifunc.
 		 */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a8a97197d6b7..6691f7438fbb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -601,8 +601,7 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 		base = pci_resource_start(pf->pdev, PCI_MBOX_BAR_NUM) +
 		       MBOX_SIZE;
 	else
-		base = readq((void __iomem *)((u64)pf->reg_base +
-					      RVU_PF_VF_BAR4_ADDR));
+		base = readq(pf->reg_base + RVU_PF_VF_BAR4_ADDR);
 
 	hwbase = ioremap_wc(base, MBOX_SIZE * pf->total_vfs);
 	if (!hwbase) {
@@ -988,6 +987,9 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUPFAF Mbox");
@@ -999,10 +1001,7 @@ static int otx2_register_mbox_intr(struct otx2_nic *pf, bool probe_af)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from AF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(pf, RVU_PF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from AF. */
 	otx2_write64(pf, RVU_PF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_af)
@@ -1485,14 +1484,13 @@ static int otx2_init_hw_resources(struct otx2_nic *pf)
 	return err;
 
 err_free_nix_queues:
-	otx2_free_sq_res(pf);
 	otx2_free_cq_res(pf);
 	otx2_ctx_disable(mbox, NIX_AQ_CTYPE_RQ, false);
 err_free_txsch:
 	if (otx2_txschq_stop(pf))
 		dev_err(pf->dev, "%s failed to stop TX schedulers\n", __func__);
 err_free_sq_ptrs:
-	otx2_sq_free_sqbs(pf);
+	otx2_free_sq_res(pf);
 err_free_rq_ptrs:
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 	otx2_ctx_disable(mbox, NPA_AQ_CTYPE_POOL, true);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 689e0853ab9c..5402f625041a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -235,6 +235,9 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 	char *irq_name;
 	int err;
 
+	/* Clear stale mailbox interrupt state before installing the handler. */
+	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+
 	/* Register mailbox interrupt handler */
 	irq_name = &hw->irq_name[RVU_VF_INT_VEC_MBOX * NAME_SIZE];
 	snprintf(irq_name, NAME_SIZE, "RVUVFAF Mbox");
@@ -246,10 +249,7 @@ static int otx2vf_register_mbox_intr(struct otx2_nic *vf, bool probe_pf)
 		return err;
 	}
 
-	/* Enable mailbox interrupt for msgs coming from PF.
-	 * First clear to avoid spurious interrupts, if any.
-	 */
-	otx2_write64(vf, RVU_VF_INT, BIT_ULL(0));
+	/* Enable mailbox interrupt for msgs coming from PF. */
 	otx2_write64(vf, RVU_VF_INT_ENA_W1S, BIT_ULL(0));
 
 	if (!probe_pf)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 85353042a790..6fd3fdab1c28 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3837,6 +3837,88 @@ static int mlxsw_sp_port_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 	return -EBUSY;
 }
 
+static int mlxsw_sp_lag_uppers_bridge_join(struct mlxsw_sp_port *mlxsw_sp_port,
+					   struct net_device *lag_dev,
+					   struct netlink_ext_ack *extack)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+	int done = 0;
+	int err;
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master)) {
+		err = mlxsw_sp_port_bridge_join(mlxsw_sp_port, lag_dev, master,
+						extack);
+		if (err)
+			return err;
+	}
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (master && netif_is_bridge_master(master)) {
+			err = mlxsw_sp_port_bridge_join(mlxsw_sp_port,
+							upper_dev, master,
+							extack);
+			if (err)
+				goto err_port_bridge_join;
+		}
+
+		++done;
+	}
+
+	return 0;
+
+err_port_bridge_join:
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master || !netif_is_bridge_master(master))
+			continue;
+
+		if (!done--)
+			break;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master && netif_is_bridge_master(master))
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+
+	return err;
+}
+
+static void
+mlxsw_sp_lag_uppers_bridge_leave(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	struct net_device *upper_dev;
+	struct net_device *master;
+	struct list_head *iter;
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!is_vlan_dev(upper_dev))
+			continue;
+
+		master = netdev_master_upper_dev_get(upper_dev);
+		if (!master)
+			continue;
+
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, master);
+	}
+
+	master = netdev_master_upper_dev_get(lag_dev);
+	if (master)
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, master);
+}
+
 static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct net_device *lag_dev,
 				  struct netlink_ext_ack *extack)
@@ -3860,7 +3942,13 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
-		return err;
+		goto err_lag_uppers_bridge_join;
+
+	err = mlxsw_sp_lag_uppers_bridge_join(mlxsw_sp_port, lag_dev,
+					      extack);
+	if (err)
+		goto err_lag_uppers_bridge_join;
+
 	err = mlxsw_sp_lag_col_port_add(mlxsw_sp_port, lag_id, port_index);
 	if (err)
 		goto err_col_port_add;
@@ -3890,6 +3978,8 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				     mlxsw_sp_port->local_port);
 	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 err_col_port_add:
+	mlxsw_sp_lag_uppers_bridge_leave(mlxsw_sp_port, lag_dev);
+err_lag_uppers_bridge_join:
 	if (!lag->ref_count)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
 	return err;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6a8ed54f6040..27c93d6b9de4 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1021,6 +1021,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	rxbuf_oob = &rxq->rx_oobs[curr];
 	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
+	if (unlikely(pktlen > rxq->datasize)) {
+		/* Increase it even if mana_rx_skb() isn't called. */
+		rxq->rx_cq.work_done++;
+
+		++ndev->stats.rx_dropped;
+		netdev_warn_once(ndev,
+				 "Dropped oversized RX packet: len=%u, datasize=%u\n",
+				 pktlen, rxq->datasize);
+
+		/* Reuse the RX buffer since rxbuf_oob is unchanged. */
+		goto drop;
+	}
+
 	new_page = alloc_page(GFP_ATOMIC);
 
 	if (new_page) {
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7c2202225475..719465373395 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -809,6 +809,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_common *common,
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
+	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
+	port_id &= 0xFF;
 	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
 	port = am65_common_get_port(common, port_id);
 	ndev = port->ndev;
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 211233612039..5030e23df1ee 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -233,19 +233,27 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 					  &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
-	if (valid_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (valid_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_valid_state_put;
+	}
 
 	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
 					    &enabled_bit);
-	if (IS_ERR(enabled_state))
-		return PTR_ERR(enabled_state);
-	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (IS_ERR(enabled_state)) {
+		ret = PTR_ERR(enabled_state);
+		goto err_valid_state_put;
+	}
+	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_enabled_state_put;
+	}
 
 	smp2p = kzalloc(sizeof(*smp2p), GFP_KERNEL);
-	if (!smp2p)
-		return -ENOMEM;
+	if (!smp2p) {
+		ret = -ENOMEM;
+		goto err_enabled_state_put;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -290,6 +298,10 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -306,6 +318,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_power_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 53d56cc860cd..7900d35096b0 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -756,8 +756,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 		return true;
 	}
 
-	/* Start of packet, validate the frame header */
-	if (frame_count == 0 || frame_count > TBNET_RING_SIZE / 4) {
+	/* Start of packet, validate the frame header. tbnet_poll() puts the
+	 * first frame in the skb linear area and every further frame in a page
+	 * fragment, so a packet may not span more than MAX_SKB_FRAGS + 1 frames
+	 * without overflowing skb_shinfo()->frags[].
+	 */
+	if (frame_count == 0 || frame_count > MAX_SKB_FRAGS + 1) {
 		net->stats.rx_length_errors++;
 		return false;
 	}
diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 88a36a069311..019446ee7d38 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1353,11 +1353,11 @@ static int hss_init_one(struct platform_device *pdev)
 	}
 
 	dev = alloc_hdlcdev(port);
-	port->netdev = alloc_hdlcdev(port);
-	if (!port->netdev) {
+	if (!dev) {
 		err = -ENOMEM;
 		goto err_plat;
 	}
+	port->netdev = dev;
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	hdlc = dev_to_hdlc(dev);
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 5be0c62ec019..feeeb8b76cfa 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1829,7 +1829,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
 		return;
 
 	if (aggr_conn->timer_scheduled) {
-		del_timer(&aggr_conn->timer);
+		timer_delete_sync(&aggr_conn->timer);
 		aggr_conn->timer_scheduled = false;
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
index 16c46845566e..f8024fa215e8 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -914,6 +914,7 @@ int brcmf_sdiod_probe(struct brcmf_sdio_dev *sdiodev)
 		goto out;
 	}
 	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_BROADCOM_43752:
 	case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 		f2_blksz = SDIO_4373_FUNC2_BLOCKSIZE;
 		break;
@@ -989,9 +990,9 @@ static const struct sdio_device_id brcmf_sdmmc_ids[] = {
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4354),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4356),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_4359),
+	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012),
-	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752),
 	BRCMF_SDIO_DEVICE(SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359),
 	{ /* end: all zeroes */ }
 };
@@ -1043,6 +1044,7 @@ static int brcmf_ops_sdio_probe(struct sdio_func *func,
 	bus_if = kzalloc(sizeof(struct brcmf_bus), GFP_KERNEL);
 	if (!bus_if)
 		return -ENOMEM;
+	mutex_init(&bus_if->bus_reset_lock);
 	sdiodev = kzalloc(sizeof(struct brcmf_sdio_dev), GFP_KERNEL);
 	if (!sdiodev) {
 		kfree(bus_if);
@@ -1102,6 +1104,14 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
 		if (func->num != 1)
 			return;
 
+		/* Drain bus_reset before the shared brcmf_sdiod_remove()
+		 * teardown, which the SDIO reset callback also reaches.  The
+		 * data worker can arm bus_reset via brcmf_fw_crashed(); cancel
+		 * it first.
+		 */
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
+
 		/* only proceed with rest of cleanup if func 1 */
 		brcmf_sdiod_remove(sdiodev);
 
@@ -1163,6 +1173,8 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
 	} else {
 		/* power will be cut so remove device, probe again in resume */
 		brcmf_sdiod_intr_unregister(sdiodev);
+		brcmf_sdio_cancel_datawork(sdiodev->bus);
+		brcmf_bus_cancel_reset_work(bus_if);
 		ret = brcmf_sdiod_remove(sdiodev);
 		if (ret)
 			brcmf_err("Failed to remove device on suspend\n");
@@ -1188,6 +1200,8 @@ static int brcmf_ops_sdio_resume(struct device *dev)
 		ret = brcmf_sdiod_probe(sdiodev);
 		if (ret)
 			brcmf_err("Failed to probe device on resume\n");
+		else
+			brcmf_bus_allow_reset_work(bus_if);
 	} else {
 		if (sdiodev->wowl_enabled &&
 		    sdiodev->settings->bus.sdio.oob_irq_supported)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 3f5da3bb6aa5..b606094af2a3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -6,6 +6,7 @@
 #ifndef BRCMFMAC_BUS_H
 #define BRCMFMAC_BUS_H
 
+#include <linux/mutex.h>
 #include "debug.h"
 
 /* IDs of the 6 default common rings of msgbuf protocol */
@@ -149,11 +150,16 @@ struct brcmf_bus {
 	u32 chiprev;
 	bool always_use_fws_queue;
 	bool wowl_supported;
+	bool removing;		/* device removal in progress; quiesce async work */
+	struct mutex bus_reset_lock;
 
 	const struct brcmf_bus_ops *ops;
 	struct brcmf_bus_msgbuf *msgbuf;
 };
 
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if);
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if);
+
 /*
  * callback wrappers
  */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 2ca4fb4b949d..109c13189206 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1171,6 +1171,35 @@ static int brcmf_revinfo_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+/*
+ * Serialize arming from debugfs reset and brcmf_fw_crashed() against
+ * teardown.  The remove path sets ->removing and drains the work while
+ * holding bus_reset_lock, so a racing armer is either drained or skips it.
+ */
+static void brcmf_bus_schedule_reset(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	if (bus_if->drvr && bus_if->drvr->bus_reset.func && !bus_if->removing)
+		schedule_work(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_cancel_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = true;
+	if (bus_if->drvr)
+		cancel_work_sync(&bus_if->drvr->bus_reset);
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
+void brcmf_bus_allow_reset_work(struct brcmf_bus *bus_if)
+{
+	mutex_lock(&bus_if->bus_reset_lock);
+	bus_if->removing = false;
+	mutex_unlock(&bus_if->bus_reset_lock);
+}
+
 static void brcmf_core_bus_reset(struct work_struct *work)
 {
 	struct brcmf_pub *drvr = container_of(work, struct brcmf_pub,
@@ -1191,7 +1220,7 @@ static ssize_t bus_reset_write(struct file *file, const char __user *user_buf,
 	if (value != 1)
 		return -EINVAL;
 
-	schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(drvr->bus_if);
 
 	return count;
 }
@@ -1409,13 +1438,23 @@ void brcmf_dev_coredump(struct device *dev)
 void brcmf_fw_crashed(struct device *dev)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
-	struct brcmf_pub *drvr = bus_if->drvr;
+	struct brcmf_pub *drvr;
+
+	/* May fire before brcmf_attach() wires up drvr, or after removal
+	 * has cleared it; guard the derefs below (and the arming gate in
+	 * brcmf_bus_schedule_reset() already checks drvr/->removing).
+	 */
+	if (!bus_if)
+		return;
+	drvr = bus_if->drvr;
+	if (!drvr)
+		return;
 
 	bphy_err(drvr, "Firmware has halted or crashed\n");
 
 	brcmf_dev_coredump(dev);
 
-	schedule_work(&drvr->bus_reset);
+	brcmf_bus_schedule_reset(bus_if);
 }
 
 void brcmf_detach(struct device *dev)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 6a266c33b535..3e0758d15522 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1901,6 +1901,7 @@ brcmf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 	bus->msgbuf = kzalloc(sizeof(*bus->msgbuf), GFP_KERNEL);
 	if (!bus->msgbuf) {
 		ret = -ENOMEM;
@@ -1972,6 +1973,11 @@ brcmf_pcie_remove(struct pci_dev *pdev)
 	if (devinfo->ci)
 		brcmf_pcie_intr_disable(devinfo);
 
+	if (devinfo->irq_allocated)
+		synchronize_irq(pdev->irq);
+
+	brcmf_bus_cancel_reset_work(bus);
+
 	brcmf_detach(&pdev->dev);
 	brcmf_free(&pdev->dev);
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 696f3aa32adc..8a5258506dfd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4270,8 +4270,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 				   bus->hostintmask, NULL);
 
 		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_BROADCOM_43752:
 		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
-		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
 				  CY_4373_F2_WATERMARK);
 			brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
@@ -4543,6 +4543,12 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
 	return NULL;
 }
 
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus)
+{
+	if (bus)
+		cancel_work_sync(&bus->datawork);
+}
+
 /* Detach and free everything */
 void brcmf_sdio_remove(struct brcmf_sdio *bus)
 {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
index 15d2c02fa3ec..3c68ebf8efaa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h
@@ -373,6 +373,7 @@ int brcmf_sdiod_remove(struct brcmf_sdio_dev *sdiodev);
 struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev);
 void brcmf_sdio_remove(struct brcmf_sdio *bus);
 void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr);
+void brcmf_sdio_cancel_datawork(struct brcmf_sdio *bus);
 
 void brcmf_sdio_wd_timer(struct brcmf_sdio *bus, bool active);
 void brcmf_sdio_wowl_config(struct device *dev, bool enabled);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 8c12aaffe719..29824caa9d4d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1273,6 +1273,7 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 		ret = -ENOMEM;
 		goto fail;
 	}
+	mutex_init(&bus->bus_reset_lock);
 
 	bus->dev = dev;
 	bus_pub->bus = bus;
@@ -1338,6 +1339,8 @@ brcmf_usb_disconnect_cb(struct brcmf_usbdev_info *devinfo)
 		return;
 	brcmf_dbg(USB, "Enter, bus_pub %p\n", devinfo);
 
+	brcmf_bus_cancel_reset_work(devinfo->bus_pub.bus);
+
 	brcmf_detach(devinfo->dev);
 	brcmf_free(devinfo->dev);
 	kfree(devinfo->bus_pub.bus);
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index 71492211904b..b726e7e0b260 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -174,7 +174,7 @@ static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
 	lbtf_free_cmd_buffer(priv);
-	del_timer(&priv->command_timer);
+	timer_delete_sync(&priv->command_timer);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 7904ae5406da..55371769d54f 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -312,7 +312,7 @@ static inline void bcm2835_pinctrl_fsel_set(
 
 static int bcm2835_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int bcm2835_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -348,7 +348,7 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
 		unsigned offset, int value)
 {
 	bcm2835_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int bcm2835_of_gpio_ranges_fallback(struct gpio_chip *gc,
diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index 670ac53a3141..680bb8a8a76b 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -1096,7 +1096,7 @@ static int lochnagar_gpio_direction_out(struct gpio_chip *chip,
 {
 	lochnagar_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int lochnagar_fill_func_groups(struct lochnagar_pin_priv *priv)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 8f4cc52b2a06..ea12ce72bc5f 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/gpio/driver.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/machine.h>
@@ -864,29 +865,31 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
 
 /**
  * pinctrl_gpio_direction_input() - request a GPIO pin to go into input mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
  * as part of their gpio_direction_input() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_input(unsigned gpio)
+int pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction(gpio, true);
+	return pinctrl_gpio_direction(gc->base + offset, true);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
 
 /**
  * pinctrl_gpio_direction_output() - request a GPIO pin to go into output mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
  * as part of their gpio_direction_output() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_output(unsigned gpio)
+int pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction(gpio, false);
+	return pinctrl_gpio_direction(gc->base + offset, false);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 1b993b33d60f..008983d4f82b 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1220,14 +1220,14 @@ static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int chv_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int chv_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				     int value)
 {
 	chv_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip chv_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 385460032962..096bf8d48537 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1000,14 +1000,14 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				       int value)
 {
 	intel_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip intel_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 561fa322b0b4..f0fafee7113d 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -614,7 +614,7 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -622,7 +622,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 {
 	lp_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int lp_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index ad3b67163973..8c18cd3c3e38 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -471,7 +471,7 @@ static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 
 static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 {
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
@@ -479,7 +479,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 {
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index a3f1ff77e064..f8a563cc5d8f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -778,14 +778,14 @@ static const struct pinmux_ops mtk_pmx_ops = {
 static int mtk_gpio_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
 	mtk_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index deade010270a..71ab4a327a6b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -786,7 +786,7 @@ static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	if (gpio >= hw->soc->npins)
 		return -EINVAL;
 
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
@@ -799,7 +799,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index e4a0d16b58cc..3dde6758847d 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -168,7 +168,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm7xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input(offset + chip->base);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret)
 		return ret;
 
@@ -185,7 +185,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	dev_dbg(chip->parent, "gpio_direction_output: offset%d = %x\n", offset,
 		value);
 
-	ret = pinctrl_gpio_direction_output(offset + chip->base);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index 13c193156363..78f4db24d5f9 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -514,14 +514,14 @@ static void as3722_gpio_set(struct gpio_chip *chip, unsigned offset,
 
 static int as3722_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int as3722_gpio_direction_output(struct gpio_chip *chip,
 		unsigned offset, int value)
 {
 	as3722_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int as3722_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 207cbae3a7bf..aba52e858b48 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -112,7 +112,7 @@ static int axp20x_gpio_get_reg(unsigned int offset)
 
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index c973123e6de9..a47559920ba1 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -130,6 +130,8 @@ struct ingenic_pinctrl {
 	struct pinctrl_pin_desc *pdesc;
 
 	const struct ingenic_chip_info *info;
+
+	struct gpio_chip *gc;
 };
 
 struct ingenic_gpio_chip {
@@ -3530,14 +3532,14 @@ static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
 static int ingenic_gpio_direction_input(struct gpio_chip *gc,
 		unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 		unsigned int offset, int value)
 {
 	ingenic_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
@@ -3998,7 +4000,8 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_OUTPUT:
-			ret = pinctrl_gpio_direction_output(pin);
+			ret = pinctrl_gpio_direction_output(jzpc->gc,
+							pin - jzpc->gc->base);
 			if (ret)
 				return ret;
 
@@ -4118,6 +4121,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	if (!jzgc)
 		return -ENOMEM;
 
+	jzpc->gc = &jzgc->gc;
+
 	jzgc->jzpc = jzpc;
 	jzgc->reg_base = bank * jzpc->info->reg_offset;
 
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 9f1b88fa33b4..50f604660f32 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1174,7 +1174,7 @@ static int ocelot_gpio_get_direction(struct gpio_chip *chip,
 static int ocelot_gpio_direction_input(struct gpio_chip *chip,
 				       unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int ocelot_gpio_direction_output(struct gpio_chip *chip,
@@ -1190,7 +1190,7 @@ static int ocelot_gpio_direction_output(struct gpio_chip *chip,
 		regmap_write(info->map, REG(OCELOT_GPIO_OUT_CLR, info, offset),
 			     pin);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip ocelot_gpiolib_chip = {
diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index c6f4229eb106..760b9a0bffce 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -166,14 +166,14 @@ static void rk805_gpio_set(struct gpio_chip *chip,
 static int rk805_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int rk805_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	rk805_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int rk805_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index fa3edb4b898a..58eed241ad28 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -715,7 +715,7 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_direction_input(chip->base + offset);
+	pinctrl_gpio_direction_input(chip, offset);
 
 	return 0;
 }
@@ -726,7 +726,7 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	struct st_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__st_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index ad06f5355d1e..e926d70bb912 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -165,7 +165,7 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 
 static int gpio_pin_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
@@ -173,7 +173,7 @@ static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
 {
 	gpio_pin_set_value(gpiochip_get_data(gc), offset, value);
 
-	return pinctrl_gpio_direction_output(offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index e8afed94fccc..37f32a78d318 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -255,7 +255,7 @@ static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int stm32_gpio_direction_output(struct gpio_chip *chip,
@@ -264,7 +264,7 @@ static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__stm32_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8d670af25b03..8c9dd9fbfe85 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -850,7 +850,7 @@ static const struct pinmux_ops sunxi_pmx_ops = {
 static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -901,7 +901,7 @@ static int sunxi_pinctrl_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
 	sunxi_pinctrl_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int sunxi_pinctrl_gpio_of_xlate(struct gpio_chip *gc,
diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 65b97e240196..3804c132397f 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -528,14 +528,14 @@ static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 
 static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				     int value)
 {
 	wmt_gpio_set_value(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip wmt_gpio_chip = {
diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 4b91e3c9eafa..b7960f047b66 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -101,11 +101,14 @@ static void qcom_minidump_cleanup(struct rproc *rproc)
 	}
 }
 
-static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem)
+static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
+			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
+				void *dest, size_t offset, size_t size))
 {
 	struct minidump_region __iomem *ptr;
 	struct minidump_region region;
 	int seg_cnt, i;
+	int ret = 0;
 	dma_addr_t da;
 	size_t size;
 	char *name;
@@ -123,23 +126,31 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 
 	for (i = 0; i < seg_cnt; i++) {
 		memcpy_fromio(&region, ptr + i, sizeof(region));
-		if (region.valid == MD_REGION_VALID) {
-			name = kstrdup(region.name, GFP_KERNEL);
+		if (le32_to_cpu(region.valid) == MD_REGION_VALID) {
+			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
 			if (!name) {
-				iounmap(ptr);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				break;
 			}
 			da = le64_to_cpu(region.address);
-			size = le32_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
+			size = le64_to_cpu(region.size);
+			ret = rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t,
+								name);
+			if (ret) {
+				kfree(name);
+				break;
+			}
 		}
 	}
 
 	iounmap(ptr);
-	return 0;
+	return ret;
 }
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
 {
 	int ret;
 	struct minidump_subsystem *subsystem;
@@ -169,7 +180,7 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
 		return;
 	}
 
-	ret = qcom_add_minidump_segments(rproc, subsystem);
+	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
 		goto clean_minidump;
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index c35adf730be0..c3cc6194e483 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -33,7 +33,10 @@ struct qcom_rproc_ssr {
 	struct qcom_ssr_subsystem *info;
 };
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+			void (*rproc_dumpfn_t)(struct rproc *rproc,
+				struct rproc_dump_segment *segment, void *dest, size_t offset,
+				size_t size));
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 			   const char *ssr_name);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 776319ab1baf..f8661035803c 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -83,6 +83,24 @@ struct qcom_adsp {
 	struct qcom_sysmon *sysmon;
 };
 
+void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
+		       void *dest, size_t offset, size_t size)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+	int total_offset;
+
+	total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
+	if (total_offset < 0 || total_offset + size > adsp->mem_size) {
+		dev_err(adsp->dev,
+			"invalid copy request for segment %pad with offset %zu and size %zu)\n",
+			&segment->da, offset, size);
+		memset(dest, 0xff, size);
+		return;
+	}
+
+	memcpy_fromio(dest, adsp->mem_region + total_offset, size);
+}
+
 static void adsp_minidump(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = rproc->priv;
@@ -90,7 +108,7 @@ static void adsp_minidump(struct rproc *rproc)
 	if (rproc->dump_conf == RPROC_COREDUMP_DISABLED)
 		return;
 
-	qcom_minidump(rproc, adsp->minidump_id);
+	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
 }
 
 static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8d1b2771c1aa..4da85df9f781 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -371,11 +371,9 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 {
 	struct ccw1 *ccw = cp->guest_cp;
-	int cnt = 0;
-
-	do {
-		cnt++;
+	int cnt;
 
+	for (cnt = 1; cnt <= CCWCHAIN_LEN_MAX; cnt++, ccw++) {
 		/*
 		 * As we don't want to fail direct addressing even if the
 		 * orb specified one of the unsupported formats, we defer
@@ -393,15 +391,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 		 * after the TIC, depending on the results of its operation.
 		 */
 		if (!ccw_is_chain(ccw) && !is_tic_within_range(ccw, iova, cnt))
-			break;
-
-		ccw++;
-	} while (cnt < CCWCHAIN_LEN_MAX + 1);
-
-	if (cnt == CCWCHAIN_LEN_MAX + 1)
-		cnt = -EINVAL;
+			return cnt;
+	}
 
-	return cnt;
+	return -EINVAL;
 }
 
 static int tic_target_chain_exists(struct ccw1 *tic, struct channel_program *cp)
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9531db0660e9..dbde0a2a9e15 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4674,6 +4674,9 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	if (req_len > QETH_BUFSIZE)
 		return -EINVAL;
 
+	if (qinfo.udata_len < sizeof(struct qeth_snmp_ureq_hdr))
+		return -EINVAL;
+
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
 	if (!iob)
 		return -ENOMEM;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 83af6c6a9e21..1a3045811b25 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1415,6 +1415,11 @@ static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 		rc = -EFAULT;
 		goto out;
 	}
+
+	if (qinfo.udata_len < QETH_QARP_ENTRIES_OFFSET) {
+		rc = -EINVAL;
+		goto out;
+	}
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
 		rc = -ENOMEM;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index d7a3304de305..3cf1fccee812 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -8010,6 +8010,7 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 			goto out_free_bsmbx;
 		}
 	}
+	mempool_free(mboxq, phba->mbox_mem_pool);
 
 	/*
 	 * 1 for cmd, 1 for rsp, NVME adds an extra one
@@ -8131,8 +8132,6 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	if (!phba->lpfc_cmd_rsp_buf_pool)
 		goto out_free_sg_dma_buf;
 
-	mempool_free(mboxq, phba->mbox_mem_pool);
-
 	/* Verify OAS is supported */
 	lpfc_sli4_oas_verify(phba);
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 7a3ded66e83e..843dc4728a5a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -250,9 +250,9 @@ static const char *sdebug_version_date = "20200710";
 
 /* Zone types (zbcr05 table 25) */
 enum sdebug_z_type {
-	ZBC_ZONE_TYPE_CNV	= 0x1,
-	ZBC_ZONE_TYPE_SWR	= 0x2,
-	ZBC_ZONE_TYPE_SWP	= 0x3,
+	ZBC_ZTYPE_CNV	= 0x1,
+	ZBC_ZTYPE_SWR	= 0x2,
+	ZBC_ZTYPE_SWP	= 0x3,
 };
 
 /* enumeration names taken from table 26, zbcr05 */
@@ -2682,7 +2682,7 @@ static struct sdeb_zone_state *zbc_zone(struct sdebug_dev_info *devip,
 
 static inline bool zbc_zone_is_conv(struct sdeb_zone_state *zsp)
 {
-	return zsp->z_type == ZBC_ZONE_TYPE_CNV;
+	return zsp->z_type == ZBC_ZTYPE_CNV;
 }
 
 static void zbc_close_zone(struct sdebug_dev_info *devip,
@@ -2781,7 +2781,7 @@ static void zbc_inc_wp(struct sdebug_dev_info *devip,
 	if (zbc_zone_is_conv(zsp))
 		return;
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		zsp->z_wp += num;
 		if (zsp->z_wp >= zend)
 			zbc_set_zone_full(devip, zsp);
@@ -2848,7 +2848,7 @@ static int check_zbc_access_params(struct scsi_cmnd *scp,
 		return 0;
 	}
 
-	if (zsp->z_type == ZBC_ZONE_TYPE_SWR) {
+	if (zsp->z_type == ZBC_ZTYPE_SWR) {
 		/* Writes cannot cross sequential zone boundaries */
 		if (zsp_end != zsp) {
 			mk_sense_buffer(scp, ILLEGAL_REQUEST,
@@ -4341,6 +4341,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	u32 alloc_len, rep_opts, rep_len;
 	bool partial;
 	u64 lba, zs_lba;
+	u64 arr_len;
 	u8 *arr = NULL, *desc;
 	u8 *cmd = scp->cmnd;
 	struct sdeb_zone_state *zsp;
@@ -4364,10 +4365,12 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	}
 
 	max_zones = devip->nr_zones - (zs_lba >> devip->zsize_shift);
-	rep_max_zones = min((alloc_len - 64) >> ilog2(RZONES_DESC_HD),
-			    max_zones);
+	rep_max_zones = (ALIGN((u64)alloc_len, RZONES_DESC_HD) - RZONES_DESC_HD) >>
+			ilog2(RZONES_DESC_HD);
+	rep_max_zones = min_t(unsigned int, rep_max_zones, max_zones);
+	arr_len = (u64)RZONES_DESC_HD * (rep_max_zones + 1);
 
-	arr = kzalloc(alloc_len, GFP_ATOMIC | __GFP_NOWARN);
+	arr = kzalloc(arr_len, GFP_ATOMIC | __GFP_NOWARN);
 	if (!arr) {
 		mk_sense_buffer(scp, ILLEGAL_REQUEST, INSUFF_RES_ASC,
 				INSUFF_RES_ASCQ);
@@ -4934,14 +4937,14 @@ static int sdebug_device_create_zones(struct sdebug_dev_info *devip)
 		zsp->z_start = zstart;
 
 		if (i < devip->nr_conv_zones) {
-			zsp->z_type = ZBC_ZONE_TYPE_CNV;
+			zsp->z_type = ZBC_ZTYPE_CNV;
 			zsp->z_cond = ZBC_NOT_WRITE_POINTER;
 			zsp->z_wp = (sector_t)-1;
 		} else {
 			if (devip->zmodel == BLK_ZONED_HM)
-				zsp->z_type = ZBC_ZONE_TYPE_SWR;
+				zsp->z_type = ZBC_ZTYPE_SWR;
 			else
-				zsp->z_type = ZBC_ZONE_TYPE_SWP;
+				zsp->z_type = ZBC_ZTYPE_SWP;
 			zsp->z_cond = ZC1_EMPTY;
 			zsp->z_wp = zsp->z_start;
 		}
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index b59136c4125b..6e93800d6e76 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -67,6 +67,20 @@ enum {
 	SD_ZERO_WS10_UNMAP,	/* Use WRITE SAME(10) with UNMAP */
 };
 
+/**
+ * struct zoned_disk_info - Specific properties of a ZBC SCSI device.
+ * @nr_zones: number of zones.
+ * @zone_blocks: number of logical blocks per zone.
+ *
+ * This data structure holds the ZBC SCSI device properties that are retrieved
+ * twice: a first time before the gendisk capacity is known and a second time
+ * after the gendisk capacity is known.
+ */
+struct zoned_disk_info {
+	u32		nr_zones;
+	u32		zone_blocks;
+};
+
 struct scsi_disk {
 	struct scsi_driver *driver;	/* always &sd_template */
 	struct scsi_device *device;
@@ -74,10 +88,10 @@ struct scsi_disk {
 	struct gendisk	*disk;
 	struct opal_dev *opal_dev;
 #ifdef CONFIG_BLK_DEV_ZONED
-	u32		nr_zones;
-	u32		rev_nr_zones;
-	u32		zone_blocks;
-	u32		rev_zone_blocks;
+	/* Updated during revalidation before the gendisk capacity is known. */
+	struct zoned_disk_info	early_zone_info;
+	/* Updated during revalidation after the gendisk capacity is known. */
+	struct zoned_disk_info	zone_info;
 	u32		zones_optimal_open;
 	u32		zones_optimal_nonseq;
 	u32		zones_max_open;
@@ -217,7 +231,7 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 #ifdef CONFIG_BLK_DEV_ZONED
 
 void sd_zbc_release_disk(struct scsi_disk *sdkp);
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE]);
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp);
 blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,
 					 unsigned char op, bool all);
@@ -233,8 +247,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 
 static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}
 
-static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
-				    unsigned char *buf)
+static inline int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	return 0;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 00791a42b8d8..90d0f8ddd179 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -20,6 +20,12 @@
 
 #include "sd.h"
 
+/**
+ * sd_zbc_get_zone_wp_offset - Get zone write pointer offset.
+ * @zone: Zone for which to return the write pointer offset.
+ *
+ * Return: offset of the write pointer from the start of the zone.
+ */
 static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 {
 	if (zone->type == ZBC_ZONE_TYPE_CONV)
@@ -44,7 +50,21 @@ static unsigned int sd_zbc_get_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
+/**
+ * sd_zbc_parse_report - Parse a SCSI zone descriptor
+ * @sdkp: SCSI disk pointer.
+ * @buf: SCSI zone descriptor.
+ * @idx: Index of the zone relative to the first zone reported by the current
+ *	sd_zbc_report_zones() call.
+ * @cb: Callback function pointer.
+ * @data: Second argument passed to @cb.
+ *
+ * Return: Value returned by @cb.
+ *
+ * Convert a SCSI zone descriptor into struct blk_zone format. Additionally,
+ * call @cb(blk_zone, @data).
+ */
+static int sd_zbc_parse_report(struct scsi_disk *sdkp, const u8 buf[64],
 			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct scsi_device *sdp = sdkp->device;
@@ -161,7 +181,7 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
 	 * sure that the allocated buffer can always be mapped by limiting the
 	 * number of pages allocated to the HBA max segments limit.
 	 */
-	nr_zones = min(nr_zones, sdkp->nr_zones);
+	nr_zones = min(nr_zones, sdkp->zone_info.nr_zones);
 	bufsize = roundup((nr_zones + 1) * 64, SECTOR_SIZE);
 	bufsize = min_t(size_t, bufsize,
 			queue_max_hw_sectors(q) << SECTOR_SHIFT);
@@ -185,14 +205,25 @@ static void *sd_zbc_alloc_report_buffer(struct scsi_disk *sdkp,
  */
 static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 {
-	return logical_to_sectors(sdkp->device, sdkp->zone_blocks);
+	return logical_to_sectors(sdkp->device, sdkp->zone_info.zone_blocks);
 }
 
+/**
+ * sd_zbc_report_zones - SCSI .report_zones() callback.
+ * @disk: Disk to report zones for.
+ * @sector: Start sector.
+ * @nr_zones: Maximum number of zones to report.
+ * @cb: Callback function called to report zone information.
+ * @data: Second argument passed to @cb.
+ *
+ * Called by the block layer to iterate over zone information. See also the
+ * disk->fops->report_zones() calls in block/blk-zoned.c.
+ */
 int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data)
 {
 	struct scsi_disk *sdkp = scsi_disk(disk);
-	sector_t capacity = logical_to_sectors(sdkp->device, sdkp->capacity);
+	sector_t lba = sectors_to_logical(sdkp->device, sector);
 	unsigned int nr, i;
 	unsigned char *buf;
 	size_t offset, buflen = 0;
@@ -203,7 +234,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 		/* Not a zoned device */
 		return -EOPNOTSUPP;
 
-	if (!capacity)
+	if (!sdkp->capacity)
 		/* Device gone or invalid */
 		return -ENODEV;
 
@@ -211,9 +242,8 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 	if (!buf)
 		return -ENOMEM;
 
-	while (zone_idx < nr_zones && sector < capacity) {
-		ret = sd_zbc_do_report_zones(sdkp, buf, buflen,
-				sectors_to_logical(sdkp->device, sector), true);
+	while (zone_idx < nr_zones && lba < sdkp->capacity) {
+		ret = sd_zbc_do_report_zones(sdkp, buf, buflen, lba, true);
 		if (ret)
 			goto out;
 
@@ -231,7 +261,7 @@ int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += sd_zbc_zone_sectors(sdkp) * i;
+		lba += sdkp->zone_info.zone_blocks * i;
 	}
 
 	ret = zone_idx;
@@ -275,6 +305,10 @@ static int sd_zbc_update_wp_offset_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
+/*
+ * An attempt to append a zone triggered an invalid write pointer error.
+ * Reread the write pointer of the zone(s) in which the append failed.
+ */
 static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 {
 	struct scsi_disk *sdkp;
@@ -285,14 +319,14 @@ static void sd_zbc_update_wp_offset_workfn(struct work_struct *work)
 	sdkp = container_of(work, struct scsi_disk, zone_wp_offset_work);
 
 	spin_lock_irqsave(&sdkp->zones_wp_offset_lock, flags);
-	for (zno = 0; zno < sdkp->nr_zones; zno++) {
+	for (zno = 0; zno < sdkp->zone_info.nr_zones; zno++) {
 		if (sdkp->zones_wp_offset[zno] != SD_ZBC_UPDATING_WP_OFST)
 			continue;
 
 		spin_unlock_irqrestore(&sdkp->zones_wp_offset_lock, flags);
 		ret = sd_zbc_do_report_zones(sdkp, sdkp->zone_wp_update_buf,
 					     SD_BUF_SIZE,
-					     zno * sdkp->zone_blocks, true);
+					     zno * sdkp->zone_info.zone_blocks, true);
 		spin_lock_irqsave(&sdkp->zones_wp_offset_lock, flags);
 		if (!ret)
 			sd_zbc_parse_report(sdkp, sdkp->zone_wp_update_buf + 64,
@@ -359,7 +393,7 @@ blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t *lba,
 		break;
 	default:
 		wp_offset = sectors_to_logical(sdkp->device, wp_offset);
-		if (wp_offset + nr_blocks > sdkp->zone_blocks) {
+		if (wp_offset + nr_blocks > sdkp->zone_info.zone_blocks) {
 			ret = BLK_STS_IOERR;
 			break;
 		}
@@ -490,7 +524,7 @@ static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
 		memset(sdkp->zones_wp_offset, 0,
-		       sdkp->nr_zones * sizeof(unsigned int));
+		       sdkp->zone_info.nr_zones * sizeof(unsigned int));
 		break;
 	default:
 		break;
@@ -559,14 +593,15 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
 		sdkp->zones_optimal_open = get_unaligned_be32(&buf[8]);
 		sdkp->zones_optimal_nonseq = get_unaligned_be32(&buf[12]);
 		sdkp->zones_max_open = 0;
-	} else {
-		/* Host-managed */
-		sdkp->urswrz = buf[4] & 1;
-		sdkp->zones_optimal_open = 0;
-		sdkp->zones_optimal_nonseq = 0;
-		sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+		return 0;
 	}
 
+	/* Host-managed */
+	sdkp->urswrz = buf[4] & 1;
+	sdkp->zones_optimal_open = 0;
+	sdkp->zones_optimal_nonseq = 0;
+	sdkp->zones_max_open = get_unaligned_be32(&buf[16]);
+
 	/*
 	 * Check for unconstrained reads: host-managed devices with
 	 * constrained reads (drives failing read after write pointer)
@@ -586,7 +621,7 @@ static int sd_zbc_check_zoned_characteristics(struct scsi_disk *sdkp,
  * sd_zbc_check_capacity - Check the device capacity
  * @sdkp: Target disk
  * @buf: command buffer
- * @zblocks: zone size in number of blocks
+ * @zblocks: zone size in logical blocks
  *
  * Get the device zone size and check that the device capacity as reported
  * by READ CAPACITY matches the max_lba value (plus one) of the report zones
@@ -640,16 +675,16 @@ static void sd_zbc_print_zones(struct scsi_disk *sdkp)
 	if (!sd_is_zoned(sdkp) || !sdkp->capacity)
 		return;
 
-	if (sdkp->capacity & (sdkp->zone_blocks - 1))
+	if (sdkp->capacity & (sdkp->zone_info.zone_blocks - 1))
 		sd_printk(KERN_NOTICE, sdkp,
 			  "%u zones of %u logical blocks + 1 runt zone\n",
-			  sdkp->nr_zones - 1,
-			  sdkp->zone_blocks);
+			  sdkp->zone_info.nr_zones - 1,
+			  sdkp->zone_info.zone_blocks);
 	else
 		sd_printk(KERN_NOTICE, sdkp,
 			  "%u zones of %u logical blocks\n",
-			  sdkp->nr_zones,
-			  sdkp->zone_blocks);
+			  sdkp->zone_info.nr_zones,
+			  sdkp->zone_info.zone_blocks);
 }
 
 static int sd_zbc_init_disk(struct scsi_disk *sdkp)
@@ -676,10 +711,8 @@ static void sd_zbc_clear_zone_info(struct scsi_disk *sdkp)
 	kfree(sdkp->zone_wp_update_buf);
 	sdkp->zone_wp_update_buf = NULL;
 
-	sdkp->nr_zones = 0;
-	sdkp->rev_nr_zones = 0;
-	sdkp->zone_blocks = 0;
-	sdkp->rev_zone_blocks = 0;
+	sdkp->early_zone_info = (struct zoned_disk_info){ };
+	sdkp->zone_info = (struct zoned_disk_info){ };
 
 	mutex_unlock(&sdkp->rev_mutex);
 }
@@ -697,12 +730,17 @@ static void sd_zbc_revalidate_zones_cb(struct gendisk *disk)
 	swap(sdkp->zones_wp_offset, sdkp->rev_wp_offset);
 }
 
+/*
+ * Call blk_revalidate_disk_zones() if any of the zoned disk properties have
+ * changed that make it necessary to call that function. Called by
+ * sd_revalidate_disk() after the gendisk capacity has been set.
+ */
 int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 {
 	struct gendisk *disk = sdkp->disk;
 	struct request_queue *q = disk->queue;
-	u32 zone_blocks = sdkp->rev_zone_blocks;
-	unsigned int nr_zones = sdkp->rev_nr_zones;
+	u32 zone_blocks = sdkp->early_zone_info.zone_blocks;
+	unsigned int nr_zones = sdkp->early_zone_info.nr_zones;
 	u32 max_append;
 	int ret = 0;
 	unsigned int flags;
@@ -733,14 +771,14 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	 */
 	mutex_lock(&sdkp->rev_mutex);
 
-	if (sdkp->zone_blocks == zone_blocks &&
-	    sdkp->nr_zones == nr_zones &&
+	if (sdkp->zone_info.zone_blocks == zone_blocks &&
+	    sdkp->zone_info.nr_zones == nr_zones &&
 	    disk->queue->nr_zones == nr_zones)
 		goto unlock;
 
 	flags = memalloc_noio_save();
-	sdkp->zone_blocks = zone_blocks;
-	sdkp->nr_zones = nr_zones;
+	sdkp->zone_info.zone_blocks = zone_blocks;
+	sdkp->zone_info.nr_zones = nr_zones;
 	sdkp->rev_wp_offset = kvcalloc(nr_zones, sizeof(u32), GFP_KERNEL);
 	if (!sdkp->rev_wp_offset) {
 		ret = -ENOMEM;
@@ -755,8 +793,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	sdkp->rev_wp_offset = NULL;
 
 	if (ret) {
-		sdkp->zone_blocks = 0;
-		sdkp->nr_zones = 0;
+		sdkp->zone_info = (struct zoned_disk_info){ };
 		sdkp->capacity = 0;
 		goto unlock;
 	}
@@ -775,7 +812,16 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	return ret;
 }
 
-int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
+/**
+ * sd_zbc_read_zones - Read zone information and update the request queue
+ * @sdkp: SCSI disk pointer.
+ * @buf: 512 byte buffer used for storing SCSI command output.
+ *
+ * Read zone information and update the request queue zone characteristics and
+ * also the zoned device information in *sdkp. Called by sd_revalidate_disk()
+ * before the gendisk capacity has been set.
+ */
+int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 {
 	struct gendisk *disk = sdkp->disk;
 	struct request_queue *q = disk->queue;
@@ -833,8 +879,8 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)
 	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
 
-	sdkp->rev_nr_zones = nr_zones;
-	sdkp->rev_zone_blocks = zone_blocks;
+	sdkp->early_zone_info.nr_zones = nr_zones;
+	sdkp->early_zone_info.zone_blocks = zone_blocks;
 
 	return 0;
 
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 1ec8892f875f..dbfaef8ce3bc 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -329,7 +329,7 @@ static void tb_domain_release(struct device *dev)
 
 	tb_ctl_free(tb->ctl);
 	destroy_workqueue(tb->wq);
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 	mutex_destroy(&tb->lock);
 	kfree(tb);
 }
@@ -397,7 +397,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 	tb->nhi = nhi;
 	mutex_init(&tb->lock);
 
-	tb->index = ida_simple_get(&tb_domain_ida, 0, 0, GFP_KERNEL);
+	tb->index = ida_alloc(&tb_domain_ida, GFP_KERNEL);
 	if (tb->index < 0)
 		goto err_free;
 
@@ -421,7 +421,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
 err_destroy_wq:
 	destroy_workqueue(tb->wq);
 err_remove_ida:
-	ida_simple_remove(&tb_domain_ida, tb->index);
+	ida_free(&tb_domain_ida, tb->index);
 err_free:
 	kfree(tb);
 
@@ -874,6 +874,36 @@ int tb_domain_disconnect_all_paths(struct tb *tb)
 	return bus_for_each_dev(&tb_bus_type, NULL, tb, disconnect_xdomain);
 }
 
+struct unregister_context {
+	const struct tb *tb;
+	int n;
+};
+
+static int unregister_unplugged_xdomain(struct device *dev, void *data)
+{
+	struct unregister_context *ctx = data;
+	struct tb_xdomain *xd;
+
+	xd = tb_to_xdomain(dev);
+	if (xd && xd->tb == ctx->tb && xd->is_unplugged) {
+		tb_xdomain_unregister(xd);
+		ctx->n++;
+	}
+	return 0;
+}
+
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb)
+{
+	struct unregister_context ctx;
+
+	ctx.tb = tb_domain_get(tb);
+	ctx.n = 0;
+	bus_for_each_dev(&tb_bus_type, NULL, &ctx, unregister_unplugged_xdomain);
+	tb_domain_put(tb);
+
+	return ctx.n;
+}
+
 int tb_domain_init(void)
 {
 	int ret;
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index ae3cbde7bc3c..f4dce47417b5 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -715,6 +715,7 @@ static void remove_xdomain(struct tb_xdomain *xd)
 
 	sw = tb_to_switch(xd->dev.parent);
 	tb_port_at(xd->route, sw)->xdomain = NULL;
+	xd->is_unplugged = true;
 	tb_xdomain_remove(xd);
 }
 
@@ -1730,6 +1731,8 @@ static void icm_handle_notification(struct work_struct *work)
 
 	kfree(n->pkg);
 	kfree(n);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
@@ -2075,6 +2078,8 @@ static void icm_rescan_work(struct work_struct *work)
 	if (tb->root_switch)
 		icm_free_unplugged_children(tb->root_switch);
 	mutex_unlock(&tb->lock);
+
+	tb_domain_unregister_unplugged_xdomains(tb);
 }
 
 static void icm_complete(struct tb *tb)
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 85efec989ac5..2f68128e89ec 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -458,7 +458,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	if (!nhi->pdev->msix_enabled)
 		return 0;
 
-	ret = ida_simple_get(&nhi->msix_ida, 0, MSIX_MAX_VECS, GFP_KERNEL);
+	ret = ida_alloc_max(&nhi->msix_ida, MSIX_MAX_VECS - 1, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -478,7 +478,7 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
 	return 0;
 
 err_ida_remove:
-	ida_simple_remove(&nhi->msix_ida, ring->vector);
+	ida_free(&nhi->msix_ida, ring->vector);
 
 	return ret;
 }
@@ -489,7 +489,7 @@ static void ring_release_msix(struct tb_ring *ring)
 		return;
 
 	free_irq(ring->irq, ring);
-	ida_simple_remove(&ring->nhi->msix_ida, ring->vector);
+	ida_free(&ring->nhi->msix_ida, ring->vector);
 	ring->vector = 0;
 	ring->irq = 0;
 }
diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 3a5336913cca..b0fce68f5a0e 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -30,7 +30,7 @@ struct tb_nvm *tb_nvm_alloc(struct device *dev)
 	if (!nvm)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&nvm_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvm_ida, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(nvm);
 		return ERR_PTR(ret);
@@ -159,7 +159,7 @@ void tb_nvm_free(struct tb_nvm *nvm)
 		if (nvm->active)
 			nvmem_unregister(nvm->active);
 		vfree(nvm->buf);
-		ida_simple_remove(&nvm_ida, nvm->id);
+		ida_free(&nvm_ida, nvm->id);
 	}
 	kfree(nvm);
 }
diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index d7598df98b7d..dc6fde468722 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -231,11 +231,13 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
  *
  * This function parses the XDomain properties data block into format that
  * can be traversed using the helper functions provided by this module.
- * Upon success returns the parsed directory. In case of error returns
- * %NULL. The resulting &struct tb_property_dir needs to be released by
+ *
+ * The resulting &struct tb_property_dir needs to be released by
  * calling tb_property_free_dir() when not needed anymore.
  *
  * The @block is expected to be root directory.
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 					      size_t block_len)
@@ -258,6 +260,8 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
  *
  * Creates new, empty property directory. If @uuid is %NULL then the
  * directory is assumed to be root directory.
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_create_dir(const uuid_t *uuid)
 {
@@ -501,9 +505,11 @@ static ssize_t __tb_property_format_dir(const struct tb_property_dir *dir,
  * @block_len: Length of the property block
  *
  * This function formats the directory to the packed format that can be
- * then send over the thunderbolt fabric to receiving host. Returns %0 in
- * case of success and negative errno on faulure. Passing %NULL in @block
- * returns number of entries the block takes.
+ * then sent over the thunderbolt fabric to receiving host.
+ *
+ * Passing %NULL in @block returns number of entries the block takes.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
 			       size_t block_len)
@@ -525,9 +531,9 @@ ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
  * tb_property_copy_dir() - Take a deep copy of directory
  * @dir: Directory to copy
  *
- * This function takes a deep copy of @dir and returns back the copy. In
- * case of error returns %NULL. The resulting directory needs to be
- * released by calling tb_property_free_dir().
+ * The resulting directory needs to be released by calling tb_property_free_dir().
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
  */
 struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
 {
@@ -597,6 +603,8 @@ struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
  * @parent: Directory to add the property
  * @key: Key for the property
  * @value: Immediate value to store with the property
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_immediate(struct tb_property_dir *parent, const char *key,
 			      u32 value)
@@ -626,6 +634,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_immediate);
  * @buflen: Number of bytes in the data buffer
  *
  * Function takes a copy of @buf and adds it to the directory.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_data(struct tb_property_dir *parent, const char *key,
 			 const void *buf, size_t buflen)
@@ -662,6 +672,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_data);
  * @text: String to add
  *
  * Function takes a copy of @text and adds it to the directory.
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_text(struct tb_property_dir *parent, const char *key,
 			 const char *text)
@@ -696,6 +708,8 @@ EXPORT_SYMBOL_GPL(tb_property_add_text);
  * @parent: Directory to add the property
  * @key: Key for the property
  * @dir: Directory to add
+ *
+ * Return: %0 on success, negative errno otherwise.
  */
 int tb_property_add_dir(struct tb_property_dir *parent, const char *key,
 			struct tb_property_dir *dir)
@@ -736,8 +750,10 @@ EXPORT_SYMBOL_GPL(tb_property_remove);
  * @key: Key to look for
  * @type: Type of the property
  *
- * Finds and returns property from the given directory. Does not recurse
- * into sub-directories. Returns %NULL if the property was not found.
+ * Finds and returns property from the given directory. Does not
+ * recurse into sub-directories.
+ *
+ * Return: Pointer to &struct tb_property, %NULL if the property was not found.
  */
 struct tb_property *tb_property_find(struct tb_property_dir *dir,
 	const char *key, enum tb_property_type type)
@@ -757,6 +773,8 @@ EXPORT_SYMBOL_GPL(tb_property_find);
  * tb_property_get_next() - Get next property from directory
  * @dir: Directory holding properties
  * @prev: Previous property in the directory (%NULL returns the first)
+ *
+ * Return: Pointer to &struct tb_property, %NULL if property was not found.
  */
 struct tb_property *tb_property_get_next(struct tb_property_dir *dir,
 					 struct tb_property *prev)
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 17e330c97a0f..a0ff2f449ec0 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -806,7 +806,7 @@ static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
 	if (max_hopid < 0 || max_hopid > port_max_hopid)
 		max_hopid = port_max_hopid;
 
-	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
+	return ida_alloc_range(ida, min_hopid, max_hopid, GFP_KERNEL);
 }
 
 /**
@@ -844,7 +844,7 @@ int tb_port_alloc_out_hopid(struct tb_port *port, int min_hopid, int max_hopid)
  */
 void tb_port_release_in_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->in_hopids, hopid);
+	ida_free(&port->in_hopids, hopid);
 }
 
 /**
@@ -854,7 +854,7 @@ void tb_port_release_in_hopid(struct tb_port *port, int hopid)
  */
 void tb_port_release_out_hopid(struct tb_port *port, int hopid)
 {
-	ida_simple_remove(&port->out_hopids, hopid);
+	ida_free(&port->out_hopids, hopid);
 }
 
 static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
@@ -3035,6 +3035,20 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
 				tb_port_warn(port,
 					     "lost during suspend, disconnecting\n");
 				tb_sw_set_unplugged(port->remote->sw);
+			} else if (port->xdomain) {
+				/*
+				 * If the user replaced the XDomain with
+				 * another router, this will succeed in
+				 * which case we must remove the XDomain
+				 * before adding the new router.
+				 */
+				err = tb_cfg_get_upstream_port(sw->tb->ctl,
+							       port->xdomain->route);
+				if (err > 0) {
+					tb_port_warn(port,
+						     "XDomain was disconnected\n");
+					port->xdomain->is_unplugged = true;
+				}
 			}
 		}
 	}
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index abe171769dc7..5b2a74a1bec3 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1310,6 +1310,8 @@ static void tb_handle_hotplug(struct work_struct *work)
 out:
 	mutex_unlock(&tb->lock);
 
+	tb_domain_unregister_unplugged_xdomains(tb);
+
 	pm_runtime_mark_last_busy(&tb->dev);
 	pm_runtime_put_autosuspend(&tb->dev);
 
@@ -1479,6 +1481,24 @@ static void tb_restore_children(struct tb_switch *sw)
 	}
 }
 
+static void tb_free_unplugged_xdomains(struct tb_switch *sw)
+{
+	struct tb_port *port;
+
+	tb_switch_for_each_port(sw, port) {
+		if (tb_is_upstream_port(port))
+			continue;
+		if (port->xdomain && port->xdomain->is_unplugged) {
+			tb_retimer_remove_all(port);
+			tb_xdomain_remove(port->xdomain);
+			tb_port_unconfigure_xdomain(port);
+			port->xdomain = NULL;
+		} else if (port->remote) {
+			tb_free_unplugged_xdomains(port->remote->sw);
+		}
+	}
+}
+
 static int tb_resume_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -1494,6 +1514,7 @@ static int tb_resume_noirq(struct tb *tb)
 	tb_switch_resume(tb->root_switch, false);
 	tb_free_invalid_tunnels(tb);
 	tb_free_unplugged_children(tb->root_switch);
+	tb_free_unplugged_xdomains(tb->root_switch);
 	tb_restore_children(tb->root_switch);
 
 	/*
@@ -1535,28 +1556,6 @@ static int tb_resume_noirq(struct tb *tb)
 	return 0;
 }
 
-static int tb_free_unplugged_xdomains(struct tb_switch *sw)
-{
-	struct tb_port *port;
-	int ret = 0;
-
-	tb_switch_for_each_port(sw, port) {
-		if (tb_is_upstream_port(port))
-			continue;
-		if (port->xdomain && port->xdomain->is_unplugged) {
-			tb_retimer_remove_all(port);
-			tb_xdomain_remove(port->xdomain);
-			tb_port_unconfigure_xdomain(port);
-			port->xdomain = NULL;
-			ret++;
-		} else if (port->remote) {
-			ret += tb_free_unplugged_xdomains(port->remote->sw);
-		}
-	}
-
-	return ret;
-}
-
 static int tb_freeze_noirq(struct tb *tb)
 {
 	struct tb_cm *tcm = tb_priv(tb);
@@ -1576,14 +1575,15 @@ static int tb_thaw_noirq(struct tb *tb)
 static void tb_complete(struct tb *tb)
 {
 	/*
-	 * Release any unplugged XDomains and if there is a case where
+	 * Unregister unplugged XDomains and if there is a case where
 	 * another domain is swapped in place of unplugged XDomain we
 	 * need to run another rescan.
 	 */
-	mutex_lock(&tb->lock);
-	if (tb_free_unplugged_xdomains(tb->root_switch))
+	if (tb_domain_unregister_unplugged_xdomains(tb)) {
+		mutex_lock(&tb->lock);
 		tb_scan_switch(tb->root_switch);
-	mutex_unlock(&tb->lock);
+		mutex_unlock(&tb->lock);
+	}
 }
 
 static int tb_runtime_suspend(struct tb *tb)
@@ -1604,11 +1604,11 @@ static void tb_remove_work(struct work_struct *work)
 	struct tb *tb = tcm_to_tb(tcm);
 
 	mutex_lock(&tb->lock);
-	if (tb->root_switch) {
+	if (tb->root_switch)
 		tb_free_unplugged_children(tb->root_switch);
-		tb_free_unplugged_xdomains(tb->root_switch);
-	}
 	mutex_unlock(&tb->lock);
+
+	tb_free_unplugged_xdomains(tb->root_switch);
 }
 
 static int tb_runtime_resume(struct tb *tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index a739cbf2be1b..bd9021e666c0 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -700,6 +700,7 @@ int tb_domain_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd,
 				       int transmit_path, int transmit_ring,
 				       int receive_path, int receive_ring);
 int tb_domain_disconnect_all_paths(struct tb *tb);
+int tb_domain_unregister_unplugged_xdomains(struct tb *tb);
 
 static inline struct tb *tb_domain_get(struct tb *tb)
 {
@@ -1025,6 +1026,7 @@ struct tb_xdomain *tb_xdomain_alloc(struct tb *tb, struct device *parent,
 				    const uuid_t *remote_uuid);
 void tb_xdomain_add(struct tb_xdomain *xd);
 void tb_xdomain_remove(struct tb_xdomain *xd);
+void tb_xdomain_unregister(struct tb_xdomain *xd);
 struct tb_xdomain *tb_xdomain_find_by_link_depth(struct tb *tb, u8 link,
 						 u8 depth);
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index df5e40c6876c..b31c4e439f27 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -630,9 +630,13 @@ static void tb_xdp_handle_request(struct work_struct *work)
 		 * the xdomain related to this connection as well in
 		 * case there is a change in services it offers.
 		 */
-		if (xd && device_is_registered(&xd->dev)) {
-			queue_delayed_work(tb->wq, &xd->get_properties_work,
-					   msecs_to_jiffies(50));
+		if (xd) {
+			mutex_lock(&xd->lock);
+			if (!xd->removing && device_is_registered(&xd->dev))
+				queue_delayed_work(tb->wq,
+						   &xd->get_properties_work,
+						   msecs_to_jiffies(50));
+			mutex_unlock(&xd->lock);
 		}
 		break;
 
@@ -807,10 +811,10 @@ static void tb_service_release(struct device *dev)
 	struct tb_service *svc = container_of(dev, struct tb_service, dev);
 	struct tb_xdomain *xd = tb_service_parent(svc);
 
-	tb_service_debugfs_remove(svc);
-	ida_simple_remove(&xd->service_ids, svc->id);
+	ida_free(&xd->service_ids, svc->id);
 	kfree(svc->key);
 	kfree(svc);
+	tb_xdomain_put(xd);
 }
 
 struct device_type tb_service_type = {
@@ -821,6 +825,14 @@ struct device_type tb_service_type = {
 };
 EXPORT_SYMBOL_GPL(tb_service_type);
 
+static void __unregister_service(struct device *dev)
+{
+	struct tb_service *svc = tb_to_service(dev);
+
+	tb_service_debugfs_remove(svc);
+	device_unregister(&svc->dev);
+}
+
 static int remove_missing_service(struct device *dev, void *data)
 {
 	struct tb_xdomain *xd = data;
@@ -832,7 +844,7 @@ static int remove_missing_service(struct device *dev, void *data)
 
 	if (!tb_property_find(xd->remote_properties, svc->key,
 			      TB_PROPERTY_TYPE_DIRECTORY))
-		device_unregister(dev);
+		__unregister_service(dev);
 
 	return 0;
 }
@@ -910,7 +922,7 @@ static void enumerate_services(struct tb_xdomain *xd)
 			break;
 		}
 
-		id = ida_simple_get(&xd->service_ids, 0, 0, GFP_KERNEL);
+		id = ida_alloc(&xd->service_ids, GFP_KERNEL);
 		if (id < 0) {
 			kfree(svc->key);
 			kfree(svc);
@@ -919,12 +931,13 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->id = id;
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
-		svc->dev.parent = &xd->dev;
+		svc->dev.parent = get_device(&xd->dev);
 		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
 
 		tb_service_debugfs_init(svc);
 
 		if (device_register(&svc->dev)) {
+			tb_service_debugfs_remove(svc);
 			put_device(&svc->dev);
 			break;
 		}
@@ -1461,41 +1474,60 @@ void tb_xdomain_add(struct tb_xdomain *xd)
 
 static int unregister_service(struct device *dev, void *data)
 {
-	device_unregister(dev);
+	__unregister_service(dev);
 	return 0;
 }
 
 /**
- * tb_xdomain_remove() - Remove XDomain from the bus
+ * tb_xdomain_remove() - Remove XDomain
  * @xd: XDomain to remove
  *
- * This will stop all ongoing configuration work and remove the XDomain
- * along with any services from the bus. When the last reference to @xd
- * is released the object will be released as well.
+ * This will stop all ongoing configuration work. XDomain is not removed
+ * from the bus if it was added. That needs to be done separately by
+ * calling tb_xdomain_unregister().
+ *
+ * Called with @tb->lock held.
  */
 void tb_xdomain_remove(struct tb_xdomain *xd)
 {
-	stop_handshake(xd);
-
-	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
+	mutex_lock(&xd->lock);
+	xd->removing = true;
+	mutex_unlock(&xd->lock);
 
-	/*
-	 * Undo runtime PM here explicitly because it is possible that
-	 * the XDomain was never added to the bus and thus device_del()
-	 * is not called for it (device_del() would handle this otherwise).
-	 */
-	pm_runtime_disable(&xd->dev);
-	pm_runtime_put_noidle(&xd->dev);
-	pm_runtime_set_suspended(&xd->dev);
+	stop_handshake(xd);
 
 	if (!device_is_registered(&xd->dev)) {
+		/*
+		 * Undo runtime PM here explicitly because it is
+		 * possible that the XDomain was never added to the bus
+		 * and thus device_del() is not called for it
+		 * (device_del() would handle this otherwise).
+		 */
+		pm_runtime_disable(&xd->dev);
+		pm_runtime_put_noidle(&xd->dev);
+		pm_runtime_set_suspended(&xd->dev);
 		put_device(&xd->dev);
-	} else {
-		dev_info(&xd->dev, "host disconnected\n");
-		device_unregister(&xd->dev);
 	}
 }
 
+/**
+ * tb_xdomain_unregister() - Unregister XDomain
+ * @xd: XDomain to unregister
+ *
+ * This will unregister the XDomain along with any services from the
+ * bus. When the last reference to @xd is released the object will be
+ * released as well.
+ */
+void tb_xdomain_unregister(struct tb_xdomain *xd)
+{
+	lockdep_assert_not_held(&xd->tb->lock);
+
+	device_for_each_child_reverse(&xd->dev, xd, unregister_service);
+
+	dev_info(&xd->dev, "host disconnected\n");
+	device_unregister(&xd->dev);
+}
+
 /**
  * tb_xdomain_lane_bonding_enable() - Enable lane bonding on XDomain
  * @xd: XDomain connection
@@ -1861,8 +1893,12 @@ static int update_xdomain(struct device *dev, void *data)
 
 	xd = tb_to_xdomain(dev);
 	if (xd) {
-		queue_delayed_work(xd->tb->wq, &xd->properties_changed_work,
-				   msecs_to_jiffies(50));
+		mutex_lock(&xd->lock);
+		if (!xd->removing)
+			queue_delayed_work(xd->tb->wq,
+					   &xd->properties_changed_work,
+					   msecs_to_jiffies(50));
+		mutex_unlock(&xd->lock);
 	}
 
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 9a4c6466ab02..5f67bf4ce0fa 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -339,7 +339,8 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 	return ret;
 }
 
@@ -349,7 +350,8 @@ static void mid8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(mid->line);
 
-	mid->board->exit(mid);
+	if (mid->board->exit)
+		mid->board->exit(mid);
 }
 
 static const struct mid8250_board pnw_board = {
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 714c23f9504f..8e7aa24da232 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1193,7 +1193,7 @@ static int __maybe_unused max310x_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(max310x_pm_ops, max310x_suspend, max310x_resume);
 
 #ifdef CONFIG_GPIOLIB
-static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	unsigned int val;
 	struct max310x_port *s = gpiochip_get_data(chip);
@@ -1204,7 +1204,7 @@ static int max310x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return !!((val >> 4) & (1 << (offset % 4)));
 }
 
-static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void max310x_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1213,7 +1213,18 @@ static void max310x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 			    value ? 1 << (offset % 4) : 0);
 }
 
-static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+static int max310x_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct max310x_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[offset / 4].port;
+	unsigned int val;
+
+	val = max310x_port_read(port, MAX310X_GPIOCFG_REG);
+
+	return val & BIT(offset % 4) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1224,7 +1235,7 @@ static int max310x_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 }
 
 static int max310x_gpio_direction_output(struct gpio_chip *chip,
-					 unsigned offset, int value)
+					 unsigned int offset, int value)
 {
 	struct max310x_port *s = gpiochip_get_data(chip);
 	struct uart_port *port = &s->p[offset / 4].port;
@@ -1414,6 +1425,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
+	s->gpio.get_direction	= max310x_gpio_get_direction;
 	s->gpio.direction_input	= max310x_gpio_direction_input;
 	s->gpio.get		= max310x_gpio_get;
 	s->gpio.direction_output= max310x_gpio_direction_output;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3623d3167950..e1bb025a700d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -237,7 +237,8 @@
 
 /* IOControl register bits (Only 750/760) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
-#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
 
 /* EFCR register bits */
@@ -294,6 +295,7 @@
 /* Misc definitions */
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_REG_SHIFT		2
+#define SC16IS7XX_GPIOS_PER_BANK	4
 
 struct sc16is7xx_devtype {
 	char	name[10];
@@ -307,7 +309,8 @@ struct sc16is7xx_devtype {
 
 struct sc16is7xx_one_config {
 	unsigned int			flags;
-	u8				ier_clear;
+	u8				ier_mask;
+	u8				ier_val;
 };
 
 struct sc16is7xx_one {
@@ -325,7 +328,9 @@ struct sc16is7xx_port {
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
+	unsigned long			gpio_valid_mask;
 #endif
+	u8				mctrl_mask;
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
@@ -341,6 +346,9 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
+static void sc16is7xx_stop_tx(struct uart_port *port);
+
 #define to_sc16is7xx_port(p,e)	((container_of((p), struct sc16is7xx_port, e)))
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
@@ -650,6 +658,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int txlen, to_send, i;
+	unsigned long flags;
 
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -658,8 +667,12 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		spin_lock_irqsave(&port->lock, flags);
+		sc16is7xx_stop_tx(port);
+		spin_unlock_irqrestore(&port->lock, flags);
 		return;
+	}
 
 	/* Get length of data pending in circular buffer */
 	to_send = uart_circ_chars_pending(xmit);
@@ -686,8 +699,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		sc16is7xx_fifo_write(port, to_send);
 	}
 
+	spin_lock_irqsave(&port->lock, flags);
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
+
+	if (uart_circ_empty(xmit))
+		sc16is7xx_stop_tx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -762,6 +780,7 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
@@ -770,6 +789,10 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	mutex_lock(&s->efr_lock);
 	sc16is7xx_handle_tx(port);
 	mutex_unlock(&s->efr_lock);
+
+	spin_lock_irqsave(&port->lock, flags);
+	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -819,7 +842,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 	}
 	if (config.flags & SC16IS7XX_RECONF_IER)
 		sc16is7xx_port_update(&one->port, SC16IS7XX_IER_REG,
-				      config.ier_clear, 0);
+				      config.ier_mask, config.ier_val);
 
 	if (config.flags & SC16IS7XX_RECONF_RS485)
 		sc16is7xx_reconf_rs485(&one->port);
@@ -830,8 +853,24 @@ static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val &= ~bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
 	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_clear |= bit;
+	one->config.ier_mask |= bit;
+	one->config.ier_val |= bit;
 	kthread_queue_work(&s->kworker, &one->reg_work);
 }
 
@@ -1059,8 +1098,8 @@ static int sc16is7xx_startup(struct uart_port *port)
 			      SC16IS7XX_EFCR_TXDISABLE_BIT,
 			      0);
 
-	/* Enable RX, TX interrupts */
-	val = SC16IS7XX_IER_RDI_BIT | SC16IS7XX_IER_THRI_BIT;
+	/* Enable RX interrupt */
+	val = SC16IS7XX_IER_RDI_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
 
 	return 0;
@@ -1165,6 +1204,17 @@ static void sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 			      val ? BIT(offset) : 0);
 }
 
+static int sc16is7xx_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[0].port;
+	unsigned int val;
+
+	val = sc16is7xx_port_read(port, SC16IS7XX_IODIR_REG);
+
+	return val & BIT(offset) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
 					  unsigned offset)
 {
@@ -1202,8 +1252,105 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
+					  unsigned long *valid_mask,
+					  unsigned int ngpios)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+
+	*valid_mask = s->gpio_valid_mask;
+
+	return 0;
+}
+
+static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
+{
+	struct device *dev = s->p[0].port.dev;
+
+	if (!s->devtype->nr_gpio)
+		return 0;
+
+	switch (s->mctrl_mask) {
+	case 0:
+		s->gpio_valid_mask = GENMASK(7, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
+		s->gpio_valid_mask = GENMASK(3, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
+		s->gpio_valid_mask = GENMASK(7, 4);
+		break;
+	default:
+		break;
+	}
+
+	if (s->gpio_valid_mask == 0)
+		return 0;
+
+	s->gpio.owner		 = THIS_MODULE;
+	s->gpio.parent		 = dev;
+	s->gpio.label		 = dev_name(dev);
+	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
+	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+	s->gpio.get		 = sc16is7xx_gpio_get;
+	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+	s->gpio.set		 = sc16is7xx_gpio_set;
+	s->gpio.base		 = -1;
+	s->gpio.ngpio		 = s->devtype->nr_gpio;
+	s->gpio.can_sleep	 = 1;
+
+	return gpiochip_add_data(&s->gpio, s);
+}
 #endif
 
+/*
+ * Configure ports designated to operate as modem control lines.
+ */
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+{
+	int i;
+	int ret;
+	int count;
+	u32 mctrl_port[2];
+	struct device *dev = s->p[0].port.dev;
+
+	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
+	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
+		return 0;
+
+	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
+					     mctrl_port, count);
+	if (ret)
+		return ret;
+
+	s->mctrl_mask = 0;
+
+	for (i = 0; i < count; i++) {
+		/* Use GPIO lines as modem control lines */
+		if (mctrl_port[i] == 0)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
+		else if (mctrl_port[i] == 1)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
+	}
+
+	if (s->mctrl_mask)
+		regmap_update_bits(
+			s->regmap,
+			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
+			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
+
+	return 0;
+}
+
+static const struct serial_rs485 sc16is7xx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
+};
+
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq)
@@ -1293,6 +1440,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
+		s->p[i].port.rs485_supported = &sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
 		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
@@ -1306,6 +1454,7 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
 				     SC16IS7XX_EFCR_RXDISABLE_BIT |
 				     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
 		/* Initialize kthread work structs */
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
@@ -1342,23 +1491,14 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
+	ret = sc16is7xx_setup_mctrl_ports(s);
+	if (ret)
+		goto out_ports;
+
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_thread;
-	}
+	ret = sc16is7xx_setup_gpio_chip(s);
+	if (ret)
+		goto out_ports;
 #endif
 
 	/*
@@ -1381,10 +1521,8 @@ static int sc16is7xx_probe(struct device *dev,
 		return 0;
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
@@ -1407,7 +1545,7 @@ static int sc16is7xx_remove(struct device *dev)
 	int i;
 
 #ifdef CONFIG_GPIOLIB
-	if (s->devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 #endif
 
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index de54b0143894..002cc7a33344 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2047,31 +2047,158 @@ static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
 	return -ENOTSUPP;
 }
 
-struct guas_setup_wq {
-	struct work_struct work;
-	struct f_uas *fu;
-	unsigned int alt;
-};
+static void tcm_cleanup_old_alt(struct f_uas *fu)
+{
+	if (fu->flags & USBG_IS_UAS)
+		uasp_cleanup_old_alt(fu);
+	else if (fu->flags & USBG_IS_BOT)
+		bot_cleanup_old_alt(fu);
+	fu->flags = 0;
+}
+
+static void tcm_delayed_set_alt_done(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
+
+static bool tcm_delayed_set_alt_cancelled(struct f_uas *fu)
+{
+	bool cancelled;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	cancelled = fu->delayed_set_alt_cancel;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	return cancelled;
+}
+
+static bool tcm_complete_delayed_status(struct f_uas *fu)
+{
+	struct usb_composite_dev *cdev = fu->function.config->cdev;
+	struct usb_request *req = cdev->req;
+	unsigned long cdev_flags;
+	bool cancelled;
+	int ret;
+
+	spin_lock_irqsave(&cdev->lock, cdev_flags);
+	spin_lock(&fu->delayed_set_alt_lock);
+	cancelled = fu->delayed_set_alt_cancel;
+	if (!cancelled) {
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+		fu->delayed_set_alt_cancel = false;
+	}
+	spin_unlock(&fu->delayed_set_alt_lock);
+
+	if (cancelled) {
+		spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+		return false;
+	}
+
+	if (cdev->delayed_status == 0) {
+		WARN(cdev, "%s: Unexpected call\n", __func__);
+	} else if (--cdev->delayed_status == 0) {
+		req->length = 0;
+		req->context = cdev;
+		ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		if (ret == 0) {
+			cdev->setup_pending = true;
+		} else {
+			req->status = 0;
+			req->complete(cdev->gadget->ep0, req);
+		}
+	}
+
+	spin_unlock_irqrestore(&cdev->lock, cdev_flags);
+
+	return true;
+}
+
+static bool tcm_cancel_delayed_set_alt(struct f_uas *fu)
+{
+	bool cleanup = false;
+	bool cancel = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	switch (fu->delayed_set_alt_state) {
+	case USBG_DELAYED_SET_ALT_IDLE:
+		cleanup = true;
+		break;
+	case USBG_DELAYED_SET_ALT_QUEUED:
+	case USBG_DELAYED_SET_ALT_RUNNING:
+		fu->delayed_set_alt_cancel = true;
+		cancel = true;
+		break;
+	}
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	if (cancel && cancel_work(&fu->delayed_set_alt)) {
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state == USBG_DELAYED_SET_ALT_QUEUED) {
+			fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+			fu->delayed_set_alt_cancel = false;
+			cleanup = true;
+		}
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+	}
+
+	return cleanup;
+}
+
+static void tcm_cancel_delayed_set_alt_sync(struct f_uas *fu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE)
+		fu->delayed_set_alt_cancel = true;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+	cancel_work_sync(&fu->delayed_set_alt);
+
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
+	fu->delayed_set_alt_cancel = false;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+}
 
 static void tcm_delayed_set_alt(struct work_struct *wq)
 {
-	struct guas_setup_wq *work = container_of(wq, struct guas_setup_wq,
-			work);
-	struct f_uas *fu = work->fu;
-	int alt = work->alt;
+	struct f_uas *fu = container_of(wq, struct f_uas, delayed_set_alt);
+	unsigned long flags;
+	unsigned int alt;
 
-	kfree(work);
+	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_QUEUED) {
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+		return;
+	}
+	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_RUNNING;
+	alt = fu->delayed_alt;
+	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
 
-	if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
+	tcm_cleanup_old_alt(fu);
+
+	if (tcm_delayed_set_alt_cancelled(fu))
+		goto out_done;
 
 	if (alt == USB_G_ALT_INT_BBB)
 		bot_set_alt(fu);
 	else if (alt == USB_G_ALT_INT_UAS)
 		uasp_set_alt(fu);
-	usb_composite_setup_continue(fu->function.config->cdev);
+
+	if (tcm_complete_delayed_status(fu))
+		return;
+
+	tcm_cleanup_old_alt(fu);
+out_done:
+	tcm_delayed_set_alt_done(fu);
 }
 
 static int tcm_get_alt(struct usb_function *f, unsigned intf)
@@ -2097,15 +2224,20 @@ static int tcm_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		return -EOPNOTSUPP;
 
 	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
-		struct guas_setup_wq *work;
+		unsigned long flags;
 
-		work = kmalloc(sizeof(*work), GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
-		INIT_WORK(&work->work, tcm_delayed_set_alt);
-		work->fu = fu;
-		work->alt = alt;
-		schedule_work(&work->work);
+		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
+		if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE) {
+			spin_unlock_irqrestore(&fu->delayed_set_alt_lock,
+					       flags);
+			return -EBUSY;
+		}
+		fu->delayed_alt = alt;
+		fu->delayed_set_alt_cancel = false;
+		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_QUEUED;
+		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
+
+		schedule_work(&fu->delayed_set_alt);
 		return USB_GADGET_DELAYED_STATUS;
 	}
 	return -EOPNOTSUPP;
@@ -2115,11 +2247,8 @@ static void tcm_disable(struct usb_function *f)
 {
 	struct f_uas *fu = to_f_uas(f);
 
-	if (fu->flags & USBG_IS_UAS)
-		uasp_cleanup_old_alt(fu);
-	else if (fu->flags & USBG_IS_BOT)
-		bot_cleanup_old_alt(fu);
-	fu->flags = 0;
+	if (tcm_cancel_delayed_set_alt(fu))
+		tcm_cleanup_old_alt(fu);
 }
 
 static int tcm_setup(struct usb_function *f,
@@ -2267,11 +2396,16 @@ static void tcm_free(struct usb_function *f)
 {
 	struct f_uas *tcm = to_f_uas(f);
 
+	tcm_cancel_delayed_set_alt_sync(tcm);
 	kfree(tcm);
 }
 
 static void tcm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
+	struct f_uas *fu = to_f_uas(f);
+
+	tcm_cancel_delayed_set_alt_sync(fu);
+	tcm_cleanup_old_alt(fu);
 	usb_free_all_descriptors(f);
 }
 
@@ -2304,6 +2438,8 @@ static struct usb_function *tcm_alloc(struct usb_function_instance *fi)
 	fu->function.disable = tcm_disable;
 	fu->function.free_func = tcm_free;
 	fu->tpg = tpg_instances[i].tpg;
+	INIT_WORK(&fu->delayed_set_alt, tcm_delayed_set_alt);
+	spin_lock_init(&fu->delayed_set_alt_lock);
 	mutex_unlock(&tpg_instances_lock);
 
 	return &fu->function;
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index 3cd565794ad7..6c9bdbeed3c8 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -3,6 +3,7 @@
 #define __TARGET_USB_GADGET_H__
 
 #include <linux/kref.h>
+#include <linux/spinlock.h>
 /* #include <linux/usb/uas.h> */
 #include <linux/usb/composite.h>
 #include <linux/usb/uas.h>
@@ -26,6 +27,12 @@ enum {
 
 #define USB_G_DEFAULT_SESSION_TAGS	128
 
+enum {
+	USBG_DELAYED_SET_ALT_IDLE = 0,
+	USBG_DELAYED_SET_ALT_QUEUED,
+	USBG_DELAYED_SET_ALT_RUNNING,
+};
+
 struct tcm_usbg_nexus {
 	struct se_session *tvn_se_sess;
 };
@@ -117,6 +124,12 @@ struct f_uas {
 #define USBG_IS_BOT		(1 << 3)
 #define USBG_BOT_CMD_PEND	(1 << 4)
 
+	struct work_struct	delayed_set_alt;
+	spinlock_t		delayed_set_alt_lock; /* protects delayed_set_alt_* */
+	unsigned int		delayed_alt;
+	unsigned int		delayed_set_alt_state;
+	bool			delayed_set_alt_cancel;
+
 	struct usbg_cdb		cmd;
 	struct usb_ep		*ep_in;
 	struct usb_ep		*ep_out;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 0678c2514197..783319f16076 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -103,19 +103,38 @@ void vduse_domain_clear_map(struct vduse_iova_domain *domain,
 static int vduse_domain_map_bounce_page(struct vduse_iova_domain *domain,
 					 u64 iova, u64 size, u64 paddr)
 {
-	struct vduse_bounce_map *map;
+	struct vduse_bounce_map *map, *head_map;
+	struct page *tmp_page;
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		/*
+		 * When PAGE_SIZE is larger than 4KB, multiple adjacent bounce_maps will
+		 * point to the same memory page of PAGE_SIZE. Since bounce_maps originate
+		 * from IO requests, we may not be able to guarantee that the orig_phys
+		 * values of all IO requests within the same 64KB memory page are contiguous.
+		 * Therefore, we need to store them separately.
+		 *
+		 * Bounce pages are allocated on demand. As a result, it may occur that
+		 * multiple bounce pages corresponding to the same 64KB memory page attempt
+		 * to allocate memory simultaneously, so we use cmpxchg to handle this
+		 * concurrency.
+		 */
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		if (!map->bounce_page) {
-			map->bounce_page = alloc_page(GFP_ATOMIC);
-			if (!map->bounce_page)
-				return -ENOMEM;
+			head_map = &domain->bounce_maps[(iova & PAGE_MASK) >> BOUNCE_MAP_SHIFT];
+			if (!head_map->bounce_page) {
+				tmp_page = alloc_page(GFP_ATOMIC | __GFP_ZERO);
+				if (!tmp_page)
+					return -ENOMEM;
+				if (cmpxchg(&head_map->bounce_page, NULL, tmp_page))
+					__free_page(tmp_page);
+			}
+			map->bounce_page = head_map->bounce_page;
 		}
 		map->orig_phys = paddr;
-		paddr += PAGE_SIZE;
-		iova += PAGE_SIZE;
+		paddr += BOUNCE_MAP_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 	return 0;
 }
@@ -127,12 +146,17 @@ static void vduse_domain_unmap_bounce_page(struct vduse_iova_domain *domain,
 	u64 last = iova + size - 1;
 
 	while (iova <= last) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 		map->orig_phys = INVALID_PHYS_ADDR;
-		iova += PAGE_SIZE;
+		iova += BOUNCE_MAP_SIZE;
 	}
 }
 
+static unsigned int offset_in_bounce_page(dma_addr_t addr)
+{
+	return (addr & ~BOUNCE_MAP_MASK);
+}
+
 static void do_bounce(phys_addr_t orig, void *addr, size_t size,
 		      enum dma_data_direction dir)
 {
@@ -163,7 +187,7 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 				enum dma_data_direction dir)
 {
 	struct vduse_bounce_map *map;
-	unsigned int offset;
+	unsigned int offset, head_offset;
 	void *addr;
 	size_t sz;
 
@@ -171,15 +195,16 @@ static void vduse_domain_bounce(struct vduse_iova_domain *domain,
 		return;
 
 	while (size) {
-		map = &domain->bounce_maps[iova >> PAGE_SHIFT];
-		offset = offset_in_page(iova);
-		sz = min_t(size_t, PAGE_SIZE - offset, size);
+		map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
+		head_offset = offset_in_page(iova);
+		offset = offset_in_bounce_page(iova);
+		sz = min_t(size_t, BOUNCE_MAP_SIZE - offset, size);
 
 		if (WARN_ON(!map->bounce_page ||
 			    map->orig_phys == INVALID_PHYS_ADDR))
 			return;
 
-		addr = page_address(map->bounce_page) + offset;
+		addr = page_address(map->bounce_page) + head_offset;
 		do_bounce(map->orig_phys + offset, addr, sz, dir);
 		size -= sz;
 		iova += sz;
@@ -214,7 +239,7 @@ vduse_domain_get_bounce_page(struct vduse_iova_domain *domain, u64 iova)
 	struct page *page = NULL;
 
 	spin_lock(&domain->iotlb_lock);
-	map = &domain->bounce_maps[iova >> PAGE_SHIFT];
+	map = &domain->bounce_maps[iova >> BOUNCE_MAP_SHIFT];
 	if (!map->bounce_page)
 		goto out;
 
@@ -232,7 +257,7 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = domain->bounce_size >> PAGE_SHIFT;
+	bounce_pfns = domain->bounce_size >> BOUNCE_MAP_SHIFT;
 
 	for (pfn = 0; pfn < bounce_pfns; pfn++) {
 		map = &domain->bounce_maps[pfn];
@@ -242,7 +267,8 @@ vduse_domain_free_bounce_pages(struct vduse_iova_domain *domain)
 		if (!map->bounce_page)
 			continue;
 
-		__free_page(map->bounce_page);
+		if (!((pfn << BOUNCE_MAP_SHIFT) & ~PAGE_MASK))
+			__free_page(map->bounce_page);
 		map->bounce_page = NULL;
 	}
 }
@@ -355,17 +381,15 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 	vduse_domain_free_iova(iovad, dma_addr, size);
 }
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs)
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	unsigned long limit = domain->iova_limit;
 	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
-	void *orig = alloc_pages_exact(size, flag);
 
-	if (!iova || !orig)
-		goto err;
+	if (!iova)
+		return DMA_MAPPING_ERROR;
 
 	spin_lock(&domain->iotlb_lock);
 	if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1,
@@ -376,27 +400,20 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 	}
 	spin_unlock(&domain->iotlb_lock);
 
-	*dma_addr = iova;
+	return iova;
 
-	return orig;
 err:
-	*dma_addr = DMA_MAPPING_ERROR;
-	if (orig)
-		free_pages_exact(orig, size);
-	if (iova)
-		vduse_domain_free_iova(iovad, iova, size);
+	vduse_domain_free_iova(iovad, iova, size);
 
-	return NULL;
+	return DMA_MAPPING_ERROR;
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -408,12 +425,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	map_file = (struct vdpa_map_file *)map->opaque;
 	fput(map_file->file);
 	kfree(map_file);
-	pa = map->addr;
 	vhost_iotlb_map_free(domain->iotlb, map);
 	spin_unlock(&domain->iotlb_lock);
 
 	vduse_domain_free_iova(iovad, dma_addr, size);
-	free_pages_exact(phys_to_virt(pa), size);
 }
 
 static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
@@ -489,7 +504,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	struct vduse_bounce_map *map;
 	unsigned long pfn, bounce_pfns;
 
-	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
+	bounce_pfns = PAGE_ALIGN(bounce_size) >> BOUNCE_MAP_SHIFT;
 	if (iova_limit <= bounce_size)
 		return NULL;
 
@@ -520,7 +535,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
 	domain->file = file;
 	spin_lock_init(&domain->iotlb_lock);
 	init_iova_domain(&domain->stream_iovad,
-			PAGE_SIZE, IOVA_START_PFN);
+			BOUNCE_MAP_SIZE, IOVA_START_PFN);
 	init_iova_domain(&domain->consistent_iovad,
 			PAGE_SIZE, bounce_pfns);
 
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 2722d9b8e21a..e8a196c4c8f8 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -19,6 +19,11 @@
 
 #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 
+#define BOUNCE_MAP_SHIFT	12
+#define BOUNCE_MAP_SIZE	(1 << BOUNCE_MAP_SHIFT)
+#define BOUNCE_MAP_MASK	(~(BOUNCE_MAP_SIZE - 1))
+#define BOUNCE_MAP_ALIGN(addr)	(((addr) + BOUNCE_MAP_SIZE - 1) & ~(BOUNCE_MAP_SIZE - 1))
+
 struct vduse_bounce_map {
 	struct page *bounce_page;
 	u64 orig_phys;
@@ -51,13 +56,11 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 			     dma_addr_t dma_addr, size_t size,
 			     enum dma_data_direction dir, unsigned long attrs);
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag, unsigned long attrs);
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a5fe6e681123..43bab23fae5b 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -795,18 +795,23 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
-	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
-	addr = vduse_domain_alloc_coherent(domain, size,
-				(dma_addr_t *)&iova, flag, attrs);
+
+	addr = alloc_pages_exact(size, flag | __GFP_ZERO);
 	if (!addr)
 		return NULL;
 
-	*dma_addr = (dma_addr_t)iova;
+	*dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
+	if (*dma_addr == DMA_MAPPING_ERROR)
+		goto err;
 
 	return addr;
+
+err:
+	free_pages_exact(addr, size);
+	return NULL;
 }
 
 static void vduse_dev_free_coherent(struct device *dev, size_t size,
@@ -816,7 +821,8 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 	struct vduse_dev *vdev = dev_to_vduse(dev);
 	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static size_t vduse_dev_max_mapping_size(struct device *dev)
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 036e0ffca08a..d2e1e63117b2 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -261,10 +261,10 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		       int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = DIV_ROUND_UP(vc->vc_font.width, 8), c;
-	int y = real_y(ops->p, vc->state.y);
+	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1;
 	char *src;
@@ -283,9 +283,9 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		c = 0;
 	src = vc->vc_font.data + (c * (w * vc->vc_font.height));
 
-	if (ops->cursor_state.image.data != src ||
-	    ops->cursor_reset) {
-	    ops->cursor_state.image.data = src;
+	if (par->cursor_state.image.data != src ||
+	    par->cursor_reset) {
+	    par->cursor_state.image.data = src;
 	    cursor.set |= FB_CUR_SETIMAGE;
 	}
 
@@ -295,46 +295,46 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
 			return;
-		kfree(ops->cursor_data);
-		ops->cursor_data = dst;
+		kfree(par->cursor_data);
+		par->cursor_data = dst;
 		update_attr(dst, src, attribute, vc);
 		src = dst;
 	}
 
-	if (ops->cursor_state.image.fg_color != fg ||
-	    ops->cursor_state.image.bg_color != bg ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.fg_color = fg;
-		ops->cursor_state.image.bg_color = bg;
+	if (par->cursor_state.image.fg_color != fg ||
+	    par->cursor_state.image.bg_color != bg ||
+	    par->cursor_reset) {
+		par->cursor_state.image.fg_color = fg;
+		par->cursor_state.image.bg_color = bg;
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
-	if ((ops->cursor_state.image.dx != (vc->vc_font.width * vc->state.x)) ||
-	    (ops->cursor_state.image.dy != (vc->vc_font.height * y)) ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.dx = vc->vc_font.width * vc->state.x;
-		ops->cursor_state.image.dy = vc->vc_font.height * y;
+	if ((par->cursor_state.image.dx != (vc->vc_font.width * vc->state.x)) ||
+	    (par->cursor_state.image.dy != (vc->vc_font.height * y)) ||
+	    par->cursor_reset) {
+		par->cursor_state.image.dx = vc->vc_font.width * vc->state.x;
+		par->cursor_state.image.dy = vc->vc_font.height * y;
 		cursor.set |= FB_CUR_SETPOS;
 	}
 
-	if (ops->cursor_state.image.height != vc->vc_font.height ||
-	    ops->cursor_state.image.width != vc->vc_font.width ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.height = vc->vc_font.height;
-		ops->cursor_state.image.width = vc->vc_font.width;
+	if (par->cursor_state.image.height != vc->vc_font.height ||
+	    par->cursor_state.image.width != vc->vc_font.width ||
+	    par->cursor_reset) {
+		par->cursor_state.image.height = vc->vc_font.height;
+		par->cursor_state.image.width = vc->vc_font.width;
 		cursor.set |= FB_CUR_SETSIZE;
 	}
 
-	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y ||
-	    ops->cursor_reset) {
-		ops->cursor_state.hot.x = cursor.hot.y = 0;
+	if (par->cursor_state.hot.x || par->cursor_state.hot.y ||
+	    par->cursor_reset) {
+		par->cursor_state.hot.x = cursor.hot.y = 0;
 		cursor.set |= FB_CUR_SETHOT;
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != ops->p->cursor_shape ||
-	    ops->cursor_state.mask == NULL ||
-	    ops->cursor_reset) {
+	    vc->vc_cursor_type != par->p->cursor_shape ||
+	    par->cursor_state.mask == NULL ||
+	    par->cursor_reset) {
 		char *mask = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		int cur_height, size, i = 0;
 		u8 msk = 0xff;
@@ -342,13 +342,13 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		if (!mask)
 			return;
 
-		kfree(ops->cursor_state.mask);
-		ops->cursor_state.mask = mask;
+		kfree(par->cursor_state.mask);
+		par->cursor_state.mask = mask;
 
-		ops->p->cursor_shape = vc->vc_cursor_type;
+		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (CUR_SIZE(ops->p->cursor_shape)) {
+		switch (CUR_SIZE(par->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
@@ -379,26 +379,26 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	switch (mode) {
 	case CM_ERASE:
-		ops->cursor_state.enable = 0;
+		par->cursor_state.enable = 0;
 		break;
 	case CM_DRAW:
 	case CM_MOVE:
 	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
+		par->cursor_state.enable = (use_sw) ? 0 : 1;
 		break;
 	}
 
 	cursor.image.data = src;
-	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-	cursor.image.bg_color = ops->cursor_state.image.bg_color;
-	cursor.image.dx = ops->cursor_state.image.dx;
-	cursor.image.dy = ops->cursor_state.image.dy;
-	cursor.image.height = ops->cursor_state.image.height;
-	cursor.image.width = ops->cursor_state.image.width;
-	cursor.hot.x = ops->cursor_state.hot.x;
-	cursor.hot.y = ops->cursor_state.hot.y;
-	cursor.mask = ops->cursor_state.mask;
-	cursor.enable = ops->cursor_state.enable;
+	cursor.image.fg_color = par->cursor_state.image.fg_color;
+	cursor.image.bg_color = par->cursor_state.image.bg_color;
+	cursor.image.dx = par->cursor_state.image.dx;
+	cursor.image.dy = par->cursor_state.image.dy;
+	cursor.image.height = par->cursor_state.image.height;
+	cursor.image.width = par->cursor_state.image.width;
+	cursor.hot.x = par->cursor_state.hot.x;
+	cursor.hot.y = par->cursor_state.hot.y;
+	cursor.mask = par->cursor_state.mask;
+	cursor.enable = par->cursor_state.enable;
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
@@ -408,31 +408,31 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	if (err)
 		soft_cursor(info, &cursor);
 
-	ops->cursor_reset = 0;
+	par->cursor_reset = 0;
 }
 
 static int bit_update_start(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int err;
 
-	err = fb_pan_display(info, &ops->var);
-	ops->var.xoffset = info->var.xoffset;
-	ops->var.yoffset = info->var.yoffset;
-	ops->var.vmode = info->var.vmode;
+	err = fb_pan_display(info, &par->var);
+	par->var.xoffset = info->var.xoffset;
+	par->var.yoffset = info->var.yoffset;
+	par->var.vmode = info->var.vmode;
 	return err;
 }
 
-void fbcon_set_bitops(struct fbcon_ops *ops)
+void fbcon_set_bitops(struct fbcon_par *par)
 {
-	ops->bmove = bit_bmove;
-	ops->clear = bit_clear;
-	ops->putcs = bit_putcs;
-	ops->clear_margins = bit_clear_margins;
-	ops->cursor = bit_cursor;
-	ops->update_start = bit_update_start;
-	ops->rotate_font = NULL;
-
-	if (ops->rotate)
-		fbcon_set_rotate(ops);
+	par->bmove = bit_bmove;
+	par->clear = bit_clear;
+	par->putcs = bit_putcs;
+	par->clear_margins = bit_clear_margins;
+	par->cursor = bit_cursor;
+	par->update_start = bit_update_start;
+	par->rotate_font = NULL;
+
+	if (par->rotate)
+		fbcon_set_rotate(par);
 }
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 887b52b1f543..1566275fd98c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -186,27 +186,27 @@ static struct device *fbcon_device;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 static inline void fbcon_set_rotation(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
-	    ops->p->con_rotate < 4)
-		ops->rotate = ops->p->con_rotate;
+	    par->p->con_rotate < 4)
+		par->rotate = par->p->con_rotate;
 	else
-		ops->rotate = 0;
+		par->rotate = 0;
 }
 
 static void fbcon_rotate(struct fb_info *info, u32 rotate)
 {
-	struct fbcon_ops *ops= info->fbcon_par;
+	struct fbcon_par *par= info->fbcon_par;
 	struct fb_info *fb_info;
 
-	if (!ops || ops->currcon == -1)
+	if (!par || par->currcon == -1)
 		return;
 
-	fb_info = registered_fb[con2fb_map[ops->currcon]];
+	fb_info = registered_fb[con2fb_map[par->currcon]];
 
 	if (info == fb_info) {
-		struct fbcon_display *p = &fb_display[ops->currcon];
+		struct fbcon_display *p = &fb_display[par->currcon];
 
 		if (rotate < 4)
 			p->con_rotate = rotate;
@@ -219,12 +219,12 @@ static void fbcon_rotate(struct fb_info *info, u32 rotate)
 
 static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct vc_data *vc;
 	struct fbcon_display *p;
 	int i;
 
-	if (!ops || ops->currcon < 0 || rotate > 3)
+	if (!par || par->currcon < 0 || rotate > 3)
 		return;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -242,9 +242,9 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 #else
 static inline void fbcon_set_rotation(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	ops->rotate = FB_ROTATE_UR;
+	par->rotate = FB_ROTATE_UR;
 }
 
 static void fbcon_rotate(struct fb_info *info, u32 rotate)
@@ -260,17 +260,17 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 
 static int fbcon_get_rotate(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	return (ops) ? ops->rotate : 0;
+	return (par) ? par->rotate : 0;
 }
 
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	return (info->state != FBINFO_STATE_RUNNING ||
-		vc->vc_mode != KD_TEXT || ops->graphics);
+		vc->vc_mode != KD_TEXT || par->graphics);
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
@@ -342,7 +342,7 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 
 static void fb_flashcursor(struct work_struct *work)
 {
-	struct fbcon_ops *ops = container_of(work, struct fbcon_ops, cursor_work.work);
+	struct fbcon_par *par = container_of(work, struct fbcon_par, cursor_work.work);
 	struct fb_info *info;
 	struct vc_data *vc = NULL;
 	int c;
@@ -357,10 +357,10 @@ static void fb_flashcursor(struct work_struct *work)
 		return;
 
 	/* protected by console_lock */
-	info = ops->info;
+	info = par->info;
 
-	if (ops->currcon != -1)
-		vc = vc_cons[ops->currcon].d;
+	if (par->currcon != -1)
+		vc = vc_cons[par->currcon].d;
 
 	if (!vc || !con_is_visible(vc) ||
  	    registered_fb[con2fb_map[vc->vc_num]] != info ||
@@ -370,30 +370,30 @@ static void fb_flashcursor(struct work_struct *work)
 	}
 
 	c = scr_readw((u16 *) vc->vc_pos);
-	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
+	mode = (!par->cursor_flash || par->cursor_state.enable) ?
 		CM_ERASE : CM_DRAW;
-	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
+	par->cursor(vc, info, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	console_unlock();
 
-	queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
-			   ops->cur_blink_jiffies);
+	queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
+			   par->cur_blink_jiffies);
 }
 
 static void fbcon_add_cursor_work(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	if (!fbcon_cursor_noblink)
-		queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
-				   ops->cur_blink_jiffies);
+		queue_delayed_work(system_power_efficient_wq, &par->cursor_work,
+				   par->cur_blink_jiffies);
 }
 
 static void fbcon_del_cursor_work(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	cancel_delayed_work_sync(&ops->cursor_work);
+	cancel_delayed_work_sync(&par->cursor_work);
 }
 
 #ifndef MODULE
@@ -547,7 +547,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 			       int cols, int rows, int new_cols, int new_rows)
 {
 	/* Need to make room for the logo */
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int cnt, erase = vc->vc_video_erase_char, step;
 	unsigned short *save = NULL, *r, *q;
 	int logo_height;
@@ -563,7 +563,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 	 */
 	if (fb_get_color_depth(&info->var, &info->fix) == 1)
 		erase &= ~0x400;
-	logo_height = fb_prepare_logo(info, ops->rotate);
+	logo_height = fb_prepare_logo(info, par->rotate);
 	logo_lines = DIV_ROUND_UP(logo_height, vc->vc_font.height);
 	q = (unsigned short *) (vc->vc_origin +
 				vc->vc_size_row * rows);
@@ -636,15 +636,15 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 #ifdef CONFIG_FB_TILEBLITTING
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	ops->p = &fb_display[vc->vc_num];
+	par->p = &fb_display[vc->vc_num];
 
 	if ((info->flags & FBINFO_MISC_TILEBLITTING))
 		fbcon_set_tileops(vc, info);
 	else {
 		fbcon_set_rotation(info);
-		fbcon_set_bitops(ops);
+		fbcon_set_bitops(par);
 	}
 }
 
@@ -661,12 +661,12 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
 #else
 static void set_blitting_type(struct vc_data *vc, struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	info->flags &= ~FBINFO_MISC_TILEBLITTING;
-	ops->p = &fb_display[vc->vc_num];
+	par->p = &fb_display[vc->vc_num];
 	fbcon_set_rotation(info);
-	fbcon_set_bitops(ops);
+	fbcon_set_bitops(par);
 }
 
 static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
@@ -686,7 +686,7 @@ static void fbcon_release(struct fb_info *info)
 
 static int fbcon_open(struct fb_info *info)
 {
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 
 	if (!try_module_get(info->fbops->owner))
 		return -ENODEV;
@@ -697,16 +697,16 @@ static int fbcon_open(struct fb_info *info)
 		return -ENODEV;
 	}
 
-	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-	if (!ops) {
+	par = kzalloc(sizeof(struct fbcon_par), GFP_KERNEL);
+	if (!par) {
 		fbcon_release(info);
 		return -ENOMEM;
 	}
 
-	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
-	ops->info = info;
-	info->fbcon_par = ops;
-	ops->cur_blink_jiffies = HZ / 5;
+	INIT_DELAYED_WORK(&par->cursor_work, fb_flashcursor);
+	par->info = info;
+	info->fbcon_par = par;
+	par->cur_blink_jiffies = HZ / 5;
 
 	return 0;
 }
@@ -730,16 +730,16 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				  struct fb_info *newinfo, int unit,
 				  int oldidx, int found)
 {
-	struct fbcon_ops *ops = oldinfo->fbcon_par;
+	struct fbcon_par *par = oldinfo->fbcon_par;
 	int ret;
 
 	fbcon_release(oldinfo);
 
 	fbcon_del_cursor_work(oldinfo);
-	kfree(ops->cursor_state.mask);
-	kfree(ops->cursor_data);
-	kfree(ops->cursor_src);
-	kfree(ops->fontbuffer);
+	kfree(par->cursor_state.mask);
+	kfree(par->cursor_data);
+	kfree(par->cursor_src);
+	kfree(par->fontbuffer);
 	kfree(oldinfo->fbcon_par);
 	oldinfo->fbcon_par = NULL;
 	/*
@@ -764,12 +764,12 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				int unit, int show_logo)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int ret;
 
-	ops->currcon = fg_console;
+	par->currcon = fg_console;
 
-	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT)) {
+	if (info->fbops->fb_set_par && !(par->flags & FBCON_FLAGS_INIT)) {
 		ret = info->fbops->fb_set_par(info);
 
 		if (ret)
@@ -778,8 +778,8 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 				"error code %d\n", ret);
 	}
 
-	ops->flags |= FBCON_FLAGS_INIT;
-	ops->graphics = 0;
+	par->flags |= FBCON_FLAGS_INIT;
+	par->graphics = 0;
 	fbcon_set_disp(info, &info->var, unit);
 
 	if (show_logo) {
@@ -917,7 +917,7 @@ static const char *fbcon_startup(void)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	const struct font_desc *font = NULL;
 	struct fb_info *info = NULL;
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 	int rows, cols;
 
 	/*
@@ -937,10 +937,10 @@ static const char *fbcon_startup(void)
 	if (fbcon_open(info))
 		return NULL;
 
-	ops = info->fbcon_par;
-	ops->currcon = -1;
-	ops->graphics = 1;
-	ops->cur_rotate = -1;
+	par = info->fbcon_par;
+	par->currcon = -1;
+	par->graphics = 1;
+	par->cur_rotate = -1;
 
 	p->con_rotate = initial_rotation;
 	if (p->con_rotate == -1)
@@ -963,8 +963,8 @@ static const char *fbcon_startup(void)
 		vc->vc_font.charcount = font->charcount;
 	}
 
-	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+	rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
@@ -982,7 +982,7 @@ static const char *fbcon_startup(void)
 static void fbcon_init(struct vc_data *vc, bool init)
 {
 	struct fb_info *info;
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 	struct vc_data **default_mode = vc->vc_display_fg;
 	struct vc_data *svc = *default_mode;
 	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
@@ -1057,8 +1057,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
-	ops = info->fbcon_par;
-	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
+	par = info->fbcon_par;
+	par->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
 	p->con_rotate = initial_rotation;
 	if (p->con_rotate == -1)
@@ -1070,8 +1070,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 
 	cols = vc->vc_cols;
 	rows = vc->vc_rows;
-	new_cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-	new_rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	new_cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+	new_rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 	new_cols /= vc->vc_font.width;
 	new_rows /= vc->vc_font.height;
 
@@ -1084,7 +1084,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	 */
 	if (con_is_visible(vc) && vc->vc_mode == KD_TEXT) {
 		if (info->fbops->fb_set_par &&
-		    !(ops->flags & FBCON_FLAGS_INIT)) {
+		    !(par->flags & FBCON_FLAGS_INIT)) {
 			ret = info->fbops->fb_set_par(info);
 
 			if (ret)
@@ -1093,10 +1093,10 @@ static void fbcon_init(struct vc_data *vc, bool init)
 					"error code %d\n", ret);
 		}
 
-		ops->flags |= FBCON_FLAGS_INIT;
+		par->flags |= FBCON_FLAGS_INIT;
 	}
 
-	ops->graphics = 0;
+	par->graphics = 0;
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
 	if ((info->flags & FBINFO_HWACCEL_COPYAREA) &&
@@ -1120,12 +1120,12 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	if (logo)
 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
 
-	if (ops->rotate_font && ops->rotate_font(info, vc)) {
-		ops->rotate = FB_ROTATE_UR;
+	if (par->rotate_font && par->rotate_font(info, vc)) {
+		par->rotate = FB_ROTATE_UR;
 		set_blitting_type(vc, info);
 	}
 
-	ops->p = &fb_display[fg_console];
+	par->p = &fb_display[fg_console];
 }
 
 static void fbcon_free_font(struct fbcon_display *p)
@@ -1142,7 +1142,7 @@ static void fbcon_deinit(struct vc_data *vc)
 {
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_info *info;
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 	int idx;
 
 	fbcon_free_font(p);
@@ -1157,15 +1157,15 @@ static void fbcon_deinit(struct vc_data *vc)
 	if (!info)
 		goto finished;
 
-	ops = info->fbcon_par;
+	par = info->fbcon_par;
 
-	if (!ops)
+	if (!par)
 		goto finished;
 
 	if (con_is_visible(vc))
 		fbcon_del_cursor_work(info);
 
-	ops->flags &= ~FBCON_FLAGS_INIT;
+	par->flags &= ~FBCON_FLAGS_INIT;
 finished:
 
 	fbcon_free_font(p);
@@ -1212,7 +1212,7 @@ static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 			  unsigned int height, unsigned int width)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int fg, bg;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	u_int y_break;
@@ -1227,7 +1227,7 @@ static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 		vc->vc_top = 0;
 		/*
 		 * If the font dimensions are not an integral of the display
-		 * dimensions then the ops->clear below won't end up clearing
+		 * dimensions then the par->clear below won't end up clearing
 		 * the margins.  Call clear_margins here in case the logo
 		 * bitmap stretched into the margin area.
 		 */
@@ -1241,11 +1241,11 @@ static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 	y_break = p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >= y_break) {
 		u_int b = y_break - sy;
-		ops->clear(vc, info, real_y(p, sy), sx, b, width, fg, bg);
-		ops->clear(vc, info, real_y(p, sy + b), sx, height - b,
+		par->clear(vc, info, real_y(p, sy), sx, b, width, fg, bg);
+		par->clear(vc, info, real_y(p, sy + b), sx, height - b,
 				 width, fg, bg);
 	} else
-		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
+		par->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
 
 static void fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
@@ -1259,10 +1259,10 @@ static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	if (!fbcon_is_inactive(vc, info))
-		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
+		par->putcs(vc, info, s, count, real_y(p, ypos), xpos,
 			   get_color(vc, info, scr_readw(s), 1),
 			   get_color(vc, info, scr_readw(s), 0));
 }
@@ -1278,19 +1278,19 @@ static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	if (!fbcon_is_inactive(vc, info))
-		ops->clear_margins(vc, info, margin_color, bottom_only);
+		par->clear_margins(vc, info, margin_color, bottom_only);
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
+	par->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
 	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
 		return;
@@ -1300,12 +1300,12 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 	else
 		fbcon_add_cursor_work(info);
 
-	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
+	par->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
 
-	if (!ops->cursor)
+	if (!par->cursor)
 		return;
 
-	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
+	par->cursor(vc, info, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 }
 
@@ -1319,9 +1319,8 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	struct fbcon_display *p, *t;
 	struct vc_data **default_mode, *vc;
 	struct vc_data *svc;
-	struct fbcon_ops *ops = info->fbcon_par;
-	int rows, cols;
-	unsigned long ret = 0;
+	struct fbcon_par *par = info->fbcon_par;
+	int rows, cols, ret;
 
 	p = &fb_display[unit];
 
@@ -1352,7 +1351,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	var->yoffset = info->var.yoffset;
 	var->xoffset = info->var.xoffset;
 	fb_set_var(info, var);
-	ops->var = info->var;
+	par->var = info->var;
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (vc->vc_font.charcount == 256) {
@@ -1368,8 +1367,8 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	if (!*vc->vc_uni_pagedir_loc)
 		con_copy_unimap(vc, svc);
 
-	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+	cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+	rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
 	ret = vc_resize(vc, cols, rows);
@@ -1381,16 +1380,16 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll += count;
 	if (p->yscroll >= p->vrows)	/* Deal with wrap */
 		p->yscroll -= p->vrows;
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode |= FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode |= FB_VMODE_YWRAP;
+	par->update_start(info);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1400,16 +1399,16 @@ static __inline__ void ywrap_up(struct vc_data *vc, int count)
 static __inline__ void ywrap_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0)	/* Deal with wrap */
 		p->yscroll += p->vrows;
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode |= FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode |= FB_VMODE_YWRAP;
+	par->update_start(info);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;
@@ -1420,19 +1419,19 @@ static __inline__ void ypan_up(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	p->yscroll += count;
 	if (p->yscroll > p->vrows - vc->vc_rows) {
-		ops->bmove(vc, info, p->vrows - vc->vc_rows,
+		par->bmove(vc, info, p->vrows - vc->vc_rows,
 			    0, 0, 0, vc->vc_rows, vc->vc_cols);
 		p->yscroll -= p->vrows - vc->vc_rows;
 	}
 
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode &= ~FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode &= ~FB_VMODE_YWRAP;
+	par->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
@@ -1443,7 +1442,7 @@ static __inline__ void ypan_up(struct vc_data *vc, int count)
 static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	p->yscroll += count;
@@ -1453,10 +1452,10 @@ static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 		fbcon_redraw_move(vc, p, t + count, vc->vc_rows - count, t);
 	}
 
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode &= ~FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode &= ~FB_VMODE_YWRAP;
+	par->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
@@ -1468,19 +1467,19 @@ static __inline__ void ypan_down(struct vc_data *vc, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct fbcon_display *p = &fb_display[vc->vc_num];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	
 	p->yscroll -= count;
 	if (p->yscroll < 0) {
-		ops->bmove(vc, info, 0, 0, p->vrows - vc->vc_rows,
+		par->bmove(vc, info, 0, 0, p->vrows - vc->vc_rows,
 			    0, vc->vc_rows, vc->vc_cols);
 		p->yscroll += p->vrows - vc->vc_rows;
 	}
 
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode &= ~FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode &= ~FB_VMODE_YWRAP;
+	par->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
@@ -1491,7 +1490,7 @@ static __inline__ void ypan_down(struct vc_data *vc, int count)
 static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	p->yscroll -= count;
@@ -1501,10 +1500,10 @@ static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 		fbcon_redraw_move(vc, p, t, vc->vc_rows - count, t + count);
 	}
 
-	ops->var.xoffset = 0;
-	ops->var.yoffset = p->yscroll * vc->vc_font.height;
-	ops->var.vmode &= ~FB_VMODE_YWRAP;
-	ops->update_start(info);
+	par->var.xoffset = 0;
+	par->var.yoffset = p->yscroll * vc->vc_font.height;
+	par->var.vmode &= ~FB_VMODE_YWRAP;
+	par->update_start(info);
 	fbcon_clear_margins(vc, 1);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
@@ -1553,7 +1552,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 	unsigned short *d = (unsigned short *)
 	    (vc->vc_origin + vc->vc_size_row * line);
 	unsigned short *s = d + offset;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	while (count--) {
 		unsigned short *start = s;
@@ -1566,7 +1565,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 
 			if (c == scr_readw(d)) {
 				if (s > start) {
-					ops->bmove(vc, info, line + ycount, x,
+					par->bmove(vc, info, line + ycount, x,
 						   line, x, 1, s-start);
 					x += s - start + 1;
 					start = s + 1;
@@ -1582,7 +1581,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 			d++;
 		} while (s < le);
 		if (s > start)
-			ops->bmove(vc, info, line + ycount, x, line, x, 1,
+			par->bmove(vc, info, line + ycount, x, line, x, 1,
 				   s-start);
 		console_conditional_schedule();
 		if (ycount > 0)
@@ -1874,7 +1873,7 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy,
 			    int dy, int dx, int height, int width, u_int y_break)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u_int b;
 
 	if (sy < y_break && sy + height > y_break) {
@@ -1908,7 +1907,7 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy,
 		}
 		return;
 	}
-	ops->bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
+	par->bmove(vc, info, real_y(p, sy), sx, real_y(p, dy), dx,
 		   height, width);
 }
 
@@ -1917,14 +1916,14 @@ static void updatescrollmode_accel(struct fbcon_display *p,
 					struct vc_data *vc)
 {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int cap = info->flags;
 	u16 t = 0;
-	int ypan = FBCON_SWAP(ops->rotate, info->fix.ypanstep,
+	int ypan = FBCON_SWAP(par->rotate, info->fix.ypanstep,
 				  info->fix.xpanstep);
-	int ywrap = FBCON_SWAP(ops->rotate, info->fix.ywrapstep, t);
-	int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
-	int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
+	int ywrap = FBCON_SWAP(par->rotate, info->fix.ywrapstep, t);
+	int yres = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
+	int vyres = FBCON_SWAP(par->rotate, info->var.yres_virtual,
 				   info->var.xres_virtual);
 	int good_pan = (cap & FBINFO_HWACCEL_YPAN) &&
 		divides(ypan, vc->vc_font.height) && vyres > yres;
@@ -1958,10 +1957,10 @@ static void updatescrollmode(struct fbcon_display *p,
 					struct fb_info *info,
 					struct vc_data *vc)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int fh = vc->vc_font.height;
-	int yres = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
-	int vyres = FBCON_SWAP(ops->rotate, info->var.yres_virtual,
+	int yres = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
+	int vyres = FBCON_SWAP(par->rotate, info->var.yres_virtual,
 				   info->var.xres_virtual);
 
 	p->vrows = vyres/fh;
@@ -1981,7 +1980,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			unsigned int height, unsigned int user)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
 	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
@@ -2004,11 +2003,11 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			return -EINVAL;
 	}
 
-	virt_w = FBCON_SWAP(ops->rotate, width, height);
-	virt_h = FBCON_SWAP(ops->rotate, height, width);
-	virt_fw = FBCON_SWAP(ops->rotate, vc->vc_font.width,
+	virt_w = FBCON_SWAP(par->rotate, width, height);
+	virt_h = FBCON_SWAP(par->rotate, height, width);
+	virt_fw = FBCON_SWAP(par->rotate, vc->vc_font.width,
 				 vc->vc_font.height);
-	virt_fh = FBCON_SWAP(ops->rotate, vc->vc_font.height,
+	virt_fh = FBCON_SWAP(par->rotate, vc->vc_font.height,
 				 vc->vc_font.width);
 	var.xres = virt_w * virt_fw;
 	var.yres = virt_h * virt_fh;
@@ -2035,7 +2034,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 			fb_set_var(info, &var);
 		}
 		var_to_display(p, &info->var, info);
-		ops->var = info->var;
+		par->var = info->var;
 	}
 	updatescrollmode(p, info, vc);
 	return 0;
@@ -2044,13 +2043,13 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 static bool fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var;
 	int i, ret, prev_console;
 
 	info = registered_fb[con2fb_map[vc->vc_num]];
-	ops = info->fbcon_par;
+	par = info->fbcon_par;
 
 	if (logo_shown >= 0) {
 		struct vc_data *conp2 = vc_cons[logo_shown].d;
@@ -2061,7 +2060,7 @@ static bool fbcon_switch(struct vc_data *vc)
 		logo_shown = FBCON_LOGO_CANSHOW;
 	}
 
-	prev_console = ops->currcon;
+	prev_console = par->currcon;
 	if (prev_console != -1)
 		old_info = registered_fb[con2fb_map[prev_console]];
 	/*
@@ -2074,7 +2073,7 @@ static bool fbcon_switch(struct vc_data *vc)
 	 */
 	for_each_registered_fb(i) {
 		if (registered_fb[i]->fbcon_par) {
-			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
+			struct fbcon_par *o = registered_fb[i]->fbcon_par;
 
 			o->currcon = vc->vc_num;
 		}
@@ -2090,7 +2089,7 @@ static bool fbcon_switch(struct vc_data *vc)
 	info->var.activate = var.activate;
 	var.vmode |= info->var.vmode & ~FB_VMODE_MASK;
 	fb_set_var(info, &var);
-	ops->var = info->var;
+	par->var = info->var;
 
 	if (old_info != NULL && (old_info != info ||
 				 info->flags & FBINFO_MISC_ALWAYS_SETPAR)) {
@@ -2108,16 +2107,16 @@ static bool fbcon_switch(struct vc_data *vc)
 	}
 
 	if (fbcon_is_inactive(vc, info) ||
-	    ops->blank_state != FB_BLANK_UNBLANK)
+	    par->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_work(info);
 	else
 		fbcon_add_cursor_work(info);
 
 	set_blitting_type(vc, info);
-	ops->cursor_reset = 1;
+	par->cursor_reset = 1;
 
-	if (ops->rotate_font && ops->rotate_font(info, vc)) {
-		ops->rotate = FB_ROTATE_UR;
+	if (par->rotate_font && par->rotate_font(info, vc)) {
+		par->rotate = FB_ROTATE_UR;
 		set_blitting_type(vc, info);
 	}
 
@@ -2148,8 +2147,8 @@ static bool fbcon_switch(struct vc_data *vc)
 	scrollback_current = 0;
 
 	if (!fbcon_is_inactive(vc, info)) {
-	    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
-	    ops->update_start(info);
+	    par->var.xoffset = par->var.yoffset = p->yscroll = 0;
+	    par->update_start(info);
 	}
 
 	fbcon_set_palette(vc, color_table); 	
@@ -2159,7 +2158,7 @@ static bool fbcon_switch(struct vc_data *vc)
 
 		logo_shown = fg_console;
 		/* This is protected above by initmem_freed */
-		fb_show_logo(info, ops->rotate);
+		fb_show_logo(info, par->rotate);
 		update_region(vc,
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
@@ -2187,27 +2186,27 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
 	if (mode_switch) {
 		struct fb_var_screeninfo var = info->var;
 
-		ops->graphics = 1;
+		par->graphics = 1;
 
 		if (!blank) {
 			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE |
 				FB_ACTIVATE_KD_TEXT;
 			fb_set_var(info, &var);
-			ops->graphics = 0;
-			ops->var = info->var;
+			par->graphics = 0;
+			par->var = info->var;
 		}
 	}
 
  	if (!fbcon_is_inactive(vc, info)) {
-		if (ops->blank_state != blank) {
-			ops->blank_state = blank;
+		if (par->blank_state != blank) {
+			par->blank_state = blank;
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
-			ops->cursor_flash = (!blank);
+			par->cursor_flash = (!blank);
 
 			if (fb_blank(info, blank))
 				fbcon_generic_blank(vc, info, blank);
@@ -2218,7 +2217,7 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 	}
 
 	if (mode_switch || fbcon_is_inactive(vc, info) ||
-	    ops->blank_state != FB_BLANK_UNBLANK)
+	    par->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_work(info);
 	else
 		fbcon_add_cursor_work(info);
@@ -2229,10 +2228,10 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 static int fbcon_debug_enter(struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	ops->save_graphics = ops->graphics;
-	ops->graphics = 0;
+	par->save_graphics = par->graphics;
+	par->graphics = 0;
 	if (info->fbops->fb_debug_enter)
 		info->fbops->fb_debug_enter(info);
 	fbcon_set_palette(vc, color_table);
@@ -2242,9 +2241,9 @@ static int fbcon_debug_enter(struct vc_data *vc)
 static int fbcon_debug_leave(struct vc_data *vc)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	ops->graphics = ops->save_graphics;
+	par->graphics = par->save_graphics;
 	if (info->fbops->fb_debug_leave)
 		info->fbops->fb_debug_leave(info);
 	return 0;
@@ -2378,7 +2377,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 			     const u8 * data, int userfont)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
@@ -2405,8 +2404,8 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	if (resize) {
 		int cols, rows;
 
-		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 		cols /= w;
 		rows /= h;
 		ret = vc_resize(vc, cols, rows);
@@ -2646,11 +2645,11 @@ static void fbcon_invert_region(struct vc_data *vc, u16 * p, int cnt)
 void fbcon_suspended(struct fb_info *info)
 {
 	struct vc_data *vc = NULL;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	if (!ops || ops->currcon < 0)
+	if (!par || par->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = vc_cons[par->currcon].d;
 
 	/* Clear cursor, restore saved data */
 	fbcon_cursor(vc, CM_ERASE);
@@ -2659,27 +2658,27 @@ void fbcon_suspended(struct fb_info *info)
 void fbcon_resumed(struct fb_info *info)
 {
 	struct vc_data *vc;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	if (!ops || ops->currcon < 0)
+	if (!par || par->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = vc_cons[par->currcon].d;
 
 	update_screen(vc);
 }
 
 static void fbcon_modechanged(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct vc_data *vc;
 	struct fbcon_display *p;
 	int rows, cols;
 
-	if (!ops || ops->currcon < 0)
+	if (!par || par->currcon < 0)
 		return;
-	vc = vc_cons[ops->currcon].d;
+	vc = vc_cons[par->currcon].d;
 	if (vc->vc_mode != KD_TEXT ||
-	    registered_fb[con2fb_map[ops->currcon]] != info)
+	    registered_fb[con2fb_map[par->currcon]] != info)
 		return;
 
 	p = &fb_display[vc->vc_num];
@@ -2687,8 +2686,8 @@ static void fbcon_modechanged(struct fb_info *info)
 
 	if (con_is_visible(vc)) {
 		var_to_display(p, &info->var, info);
-		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 		cols /= vc->vc_font.width;
 		rows /= vc->vc_font.height;
 		vc_resize(vc, cols, rows);
@@ -2697,8 +2696,8 @@ static void fbcon_modechanged(struct fb_info *info)
 		scrollback_current = 0;
 
 		if (!fbcon_is_inactive(vc, info)) {
-		    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
-		    ops->update_start(info);
+		    par->var.xoffset = par->var.yoffset = p->yscroll = 0;
+		    par->update_start(info);
 		}
 
 		fbcon_set_palette(vc, color_table);
@@ -2708,12 +2707,12 @@ static void fbcon_modechanged(struct fb_info *info)
 
 static void fbcon_set_all_vcs(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct vc_data *vc;
 	struct fbcon_display *p;
 	int i, rows, cols, fg = -1;
 
-	if (!ops || ops->currcon < 0)
+	if (!par || par->currcon < 0)
 		return;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -2730,8 +2729,8 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		p = &fb_display[vc->vc_num];
 		set_blitting_type(vc, info);
 		var_to_display(p, &info->var, info);
-		cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
-		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
+		cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
+		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
 		cols /= vc->vc_font.width;
 		rows /= vc->vc_font.height;
 		vc_resize(vc, cols, rows);
@@ -2754,13 +2753,13 @@ EXPORT_SYMBOL(fbcon_update_vcs);
 /* let fbcon check if it supports a new screen resolution */
 int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct vc_data *vc;
 	unsigned int i;
 
 	WARN_CONSOLE_UNLOCKED();
 
-	if (!ops)
+	if (!par)
 		return 0;
 
 	/* prevent setting a screen size which is smaller than font size */
@@ -3022,15 +3021,15 @@ int fbcon_fb_registered(struct fb_info *info)
 
 void fbcon_fb_blanked(struct fb_info *info, int blank)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct vc_data *vc;
 
-	if (!ops || ops->currcon < 0)
+	if (!par || par->currcon < 0)
 		return;
 
-	vc = vc_cons[ops->currcon].d;
+	vc = vc_cons[par->currcon].d;
 	if (vc->vc_mode != KD_TEXT ||
-			registered_fb[con2fb_map[ops->currcon]] != info)
+			registered_fb[con2fb_map[par->currcon]] != info)
 		return;
 
 	if (con_is_visible(vc)) {
@@ -3039,7 +3038,7 @@ void fbcon_fb_blanked(struct fb_info *info, int blank)
 		else
 			do_unblank_screen(0);
 	}
-	ops->blank_state = blank;
+	par->blank_state = blank;
 }
 
 void fbcon_new_modelist(struct fb_info *info)
@@ -3230,7 +3229,7 @@ static ssize_t show_cursor_blink(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info;
-	struct fbcon_ops *ops;
+	struct fbcon_par *par;
 	int idx, blink = -1;
 
 	console_lock();
@@ -3240,12 +3239,12 @@ static ssize_t show_cursor_blink(struct device *device,
 		goto err;
 
 	info = registered_fb[idx];
-	ops = info->fbcon_par;
+	par = info->fbcon_par;
 
-	if (!ops)
+	if (!par)
 		goto err;
 
-	blink = delayed_work_pending(&ops->cursor_work);
+	blink = delayed_work_pending(&par->cursor_work);
 err:
 	console_unlock();
 	return snprintf(buf, PAGE_SIZE, "%d\n", blink);
@@ -3402,11 +3401,11 @@ static void fbcon_exit(void)
 
 		if (mapped) {
 			if (info->fbcon_par) {
-				struct fbcon_ops *ops = info->fbcon_par;
+				struct fbcon_par *par = info->fbcon_par;
 
 				fbcon_del_cursor_work(info);
-				kfree(ops->cursor_src);
-				kfree(ops->cursor_state.mask);
+				kfree(par->cursor_src);
+				kfree(par->cursor_state.mask);
 				kfree(info->fbcon_par);
 				info->fbcon_par = NULL;
 			}
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index a709e5796ef7..1d1f2f40d5fa 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -53,7 +53,7 @@ struct fbcon_display {
     const struct fb_videomode *mode;
 };
 
-struct fbcon_ops {
+struct fbcon_par {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
 	void (*clear)(struct vc_data *vc, struct fb_info *info, int sy,
@@ -188,7 +188,7 @@ static inline u_short fb_scrollmode(struct fbcon_display *fb)
 #ifdef CONFIG_FB_TILEBLITTING
 extern void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info);
 #endif
-extern void fbcon_set_bitops(struct fbcon_ops *ops);
+extern void fbcon_set_bitops(struct fbcon_par *par);
 extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 
 #define FBCON_ATTRIBUTE_UNDERLINE 1
@@ -227,7 +227,7 @@ static inline int get_attribute(struct fb_info *info, u16 c)
         (i == FB_ROTATE_UR || i == FB_ROTATE_UD) ? _r : _v; })
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-extern void fbcon_set_rotate(struct fbcon_ops *ops);
+extern void fbcon_set_rotate(struct fbcon_par *par);
 #else
 #define fbcon_set_rotate(x) do {} while(0)
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 9f4d65478554..83954bb0d2e1 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -63,9 +63,9 @@ static void ccw_update_attr(u8 *dst, u8 *src, int attribute,
 static void ccw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vyres = GETVYRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
 
 	area.sx = sy * vc->vc_font.height;
 	area.sy = vyres - ((sx + width) * vc->vc_font.width);
@@ -80,9 +80,9 @@ static void ccw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width, int fg, int bg)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_fillrect region;
-	u32 vyres = GETVYRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
 
 	region.color = bg;
 	region.dx = sy * vc->vc_font.height;
@@ -99,13 +99,13 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
 				    struct fb_image *image, u8 *buf, u8 *dst)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = (vc->vc_font.height + 7) >> 3;
 	u8 *src;
 
 	while (cnt--) {
-		src = ops->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
+		src = par->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
 
 		if (attr) {
 			ccw_update_attr(buf, src, attr, vc);
@@ -130,7 +130,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u32 width = (vc->vc_font.height + 7)/8;
 	u32 cellsize = width * vc->vc_font.width;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -139,9 +139,9 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vyres = GETVYRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	image.fg_color = fg;
@@ -221,27 +221,27 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		       int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(ops->p, vc->state.y);
+	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
 	char *src;
-	u32 vyres = GETVYRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = ops->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
 
-	if (ops->cursor_state.image.data != src ||
-	    ops->cursor_reset) {
-	    ops->cursor_state.image.data = src;
+	if (par->cursor_state.image.data != src ||
+	    par->cursor_reset) {
+	    par->cursor_state.image.data = src;
 	    cursor.set |= FB_CUR_SETIMAGE;
 	}
 
@@ -251,49 +251,49 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
 		if (!dst)
 			return;
-		kfree(ops->cursor_data);
-		ops->cursor_data = dst;
+		kfree(par->cursor_data);
+		par->cursor_data = dst;
 		ccw_update_attr(dst, src, attribute, vc);
 		src = dst;
 	}
 
-	if (ops->cursor_state.image.fg_color != fg ||
-	    ops->cursor_state.image.bg_color != bg ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.fg_color = fg;
-		ops->cursor_state.image.bg_color = bg;
+	if (par->cursor_state.image.fg_color != fg ||
+	    par->cursor_state.image.bg_color != bg ||
+	    par->cursor_reset) {
+		par->cursor_state.image.fg_color = fg;
+		par->cursor_state.image.bg_color = bg;
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
-	if (ops->cursor_state.image.height != vc->vc_font.width ||
-	    ops->cursor_state.image.width != vc->vc_font.height ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.height = vc->vc_font.width;
-		ops->cursor_state.image.width = vc->vc_font.height;
+	if (par->cursor_state.image.height != vc->vc_font.width ||
+	    par->cursor_state.image.width != vc->vc_font.height ||
+	    par->cursor_reset) {
+		par->cursor_state.image.height = vc->vc_font.width;
+		par->cursor_state.image.width = vc->vc_font.height;
 		cursor.set |= FB_CUR_SETSIZE;
 	}
 
 	dx = y * vc->vc_font.height;
 	dy = vyres - ((vc->state.x + 1) * vc->vc_font.width);
 
-	if (ops->cursor_state.image.dx != dx ||
-	    ops->cursor_state.image.dy != dy ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.dx = dx;
-		ops->cursor_state.image.dy = dy;
+	if (par->cursor_state.image.dx != dx ||
+	    par->cursor_state.image.dy != dy ||
+	    par->cursor_reset) {
+		par->cursor_state.image.dx = dx;
+		par->cursor_state.image.dy = dy;
 		cursor.set |= FB_CUR_SETPOS;
 	}
 
-	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y ||
-	    ops->cursor_reset) {
-		ops->cursor_state.hot.x = cursor.hot.y = 0;
+	if (par->cursor_state.hot.x || par->cursor_state.hot.y ||
+	    par->cursor_reset) {
+		par->cursor_state.hot.x = cursor.hot.y = 0;
 		cursor.set |= FB_CUR_SETHOT;
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != ops->p->cursor_shape ||
-	    ops->cursor_state.mask == NULL ||
-	    ops->cursor_reset) {
+	    vc->vc_cursor_type != par->p->cursor_shape ||
+	    par->cursor_state.mask == NULL ||
+	    par->cursor_reset) {
 		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
 						 GFP_ATOMIC);
 		int cur_height, size, i = 0;
@@ -309,13 +309,13 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			return;
 		}
 
-		kfree(ops->cursor_state.mask);
-		ops->cursor_state.mask = mask;
+		kfree(par->cursor_state.mask);
+		par->cursor_state.mask = mask;
 
-		ops->p->cursor_shape = vc->vc_cursor_type;
+		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (CUR_SIZE(ops->p->cursor_shape)) {
+		switch (CUR_SIZE(par->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
@@ -350,26 +350,26 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	switch (mode) {
 	case CM_ERASE:
-		ops->cursor_state.enable = 0;
+		par->cursor_state.enable = 0;
 		break;
 	case CM_DRAW:
 	case CM_MOVE:
 	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
+		par->cursor_state.enable = (use_sw) ? 0 : 1;
 		break;
 	}
 
 	cursor.image.data = src;
-	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-	cursor.image.bg_color = ops->cursor_state.image.bg_color;
-	cursor.image.dx = ops->cursor_state.image.dx;
-	cursor.image.dy = ops->cursor_state.image.dy;
-	cursor.image.height = ops->cursor_state.image.height;
-	cursor.image.width = ops->cursor_state.image.width;
-	cursor.hot.x = ops->cursor_state.hot.x;
-	cursor.hot.y = ops->cursor_state.hot.y;
-	cursor.mask = ops->cursor_state.mask;
-	cursor.enable = ops->cursor_state.enable;
+	cursor.image.fg_color = par->cursor_state.image.fg_color;
+	cursor.image.bg_color = par->cursor_state.image.bg_color;
+	cursor.image.dx = par->cursor_state.image.dx;
+	cursor.image.dy = par->cursor_state.image.dy;
+	cursor.image.height = par->cursor_state.image.height;
+	cursor.image.width = par->cursor_state.image.width;
+	cursor.hot.x = par->cursor_state.hot.x;
+	cursor.hot.y = par->cursor_state.hot.y;
+	cursor.mask = par->cursor_state.mask;
+	cursor.enable = par->cursor_state.enable;
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
@@ -379,32 +379,32 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	if (err)
 		soft_cursor(info, &cursor);
 
-	ops->cursor_reset = 0;
+	par->cursor_reset = 0;
 }
 
 static int ccw_update_start(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u32 yoffset;
-	u32 vyres = GETVYRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
 	int err;
 
-	yoffset = (vyres - info->var.yres) - ops->var.xoffset;
-	ops->var.xoffset = ops->var.yoffset;
-	ops->var.yoffset = yoffset;
-	err = fb_pan_display(info, &ops->var);
-	ops->var.xoffset = info->var.xoffset;
-	ops->var.yoffset = info->var.yoffset;
-	ops->var.vmode = info->var.vmode;
+	yoffset = (vyres - info->var.yres) - par->var.xoffset;
+	par->var.xoffset = par->var.yoffset;
+	par->var.yoffset = yoffset;
+	err = fb_pan_display(info, &par->var);
+	par->var.xoffset = info->var.xoffset;
+	par->var.yoffset = info->var.yoffset;
+	par->var.vmode = info->var.vmode;
 	return err;
 }
 
-void fbcon_rotate_ccw(struct fbcon_ops *ops)
+void fbcon_rotate_ccw(struct fbcon_par *par)
 {
-	ops->bmove = ccw_bmove;
-	ops->clear = ccw_clear;
-	ops->putcs = ccw_putcs;
-	ops->clear_margins = ccw_clear_margins;
-	ops->cursor = ccw_cursor;
-	ops->update_start = ccw_update_start;
+	par->bmove = ccw_bmove;
+	par->clear = ccw_clear;
+	par->putcs = ccw_putcs;
+	par->clear_margins = ccw_clear_margins;
+	par->cursor = ccw_cursor;
+	par->update_start = ccw_update_start;
 }
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index b18e31886da1..03c96d6c7741 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -48,9 +48,9 @@ static void cw_update_attr(u8 *dst, u8 *src, int attribute,
 static void cw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
 	area.sx = vxres - ((sy + height) * vc->vc_font.height);
 	area.sy = sx * vc->vc_font.width;
@@ -65,9 +65,9 @@ static void cw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width, int fg, int bg)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_fillrect region;
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
 	region.color = bg;
 	region.dx = vxres - ((sy + height) * vc->vc_font.height);
@@ -84,13 +84,13 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
 				    struct fb_image *image, u8 *buf, u8 *dst)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = (vc->vc_font.height + 7) >> 3;
 	u8 *src;
 
 	while (cnt--) {
-		src = ops->fontbuffer + (scr_readw(s++) & charmask)*cellsize;
+		src = par->fontbuffer + (scr_readw(s++) & charmask)*cellsize;
 
 		if (attr) {
 			cw_update_attr(buf, src, attr, vc);
@@ -115,7 +115,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u32 width = (vc->vc_font.height + 7)/8;
 	u32 cellsize = width * vc->vc_font.width;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -124,9 +124,9 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	image.fg_color = fg;
@@ -204,27 +204,27 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		      int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.height + 7) >> 3, c;
-	int y = real_y(ops->p, vc->state.y);
+	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
 	char *src;
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = ops->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.width));
 
-	if (ops->cursor_state.image.data != src ||
-	    ops->cursor_reset) {
-	    ops->cursor_state.image.data = src;
+	if (par->cursor_state.image.data != src ||
+	    par->cursor_reset) {
+	    par->cursor_state.image.data = src;
 	    cursor.set |= FB_CUR_SETIMAGE;
 	}
 
@@ -234,49 +234,49 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
 		if (!dst)
 			return;
-		kfree(ops->cursor_data);
-		ops->cursor_data = dst;
+		kfree(par->cursor_data);
+		par->cursor_data = dst;
 		cw_update_attr(dst, src, attribute, vc);
 		src = dst;
 	}
 
-	if (ops->cursor_state.image.fg_color != fg ||
-	    ops->cursor_state.image.bg_color != bg ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.fg_color = fg;
-		ops->cursor_state.image.bg_color = bg;
+	if (par->cursor_state.image.fg_color != fg ||
+	    par->cursor_state.image.bg_color != bg ||
+	    par->cursor_reset) {
+		par->cursor_state.image.fg_color = fg;
+		par->cursor_state.image.bg_color = bg;
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
-	if (ops->cursor_state.image.height != vc->vc_font.width ||
-	    ops->cursor_state.image.width != vc->vc_font.height ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.height = vc->vc_font.width;
-		ops->cursor_state.image.width = vc->vc_font.height;
+	if (par->cursor_state.image.height != vc->vc_font.width ||
+	    par->cursor_state.image.width != vc->vc_font.height ||
+	    par->cursor_reset) {
+		par->cursor_state.image.height = vc->vc_font.width;
+		par->cursor_state.image.width = vc->vc_font.height;
 		cursor.set |= FB_CUR_SETSIZE;
 	}
 
 	dx = vxres - ((y * vc->vc_font.height) + vc->vc_font.height);
 	dy = vc->state.x * vc->vc_font.width;
 
-	if (ops->cursor_state.image.dx != dx ||
-	    ops->cursor_state.image.dy != dy ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.dx = dx;
-		ops->cursor_state.image.dy = dy;
+	if (par->cursor_state.image.dx != dx ||
+	    par->cursor_state.image.dy != dy ||
+	    par->cursor_reset) {
+		par->cursor_state.image.dx = dx;
+		par->cursor_state.image.dy = dy;
 		cursor.set |= FB_CUR_SETPOS;
 	}
 
-	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y ||
-	    ops->cursor_reset) {
-		ops->cursor_state.hot.x = cursor.hot.y = 0;
+	if (par->cursor_state.hot.x || par->cursor_state.hot.y ||
+	    par->cursor_reset) {
+		par->cursor_state.hot.x = cursor.hot.y = 0;
 		cursor.set |= FB_CUR_SETHOT;
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != ops->p->cursor_shape ||
-	    ops->cursor_state.mask == NULL ||
-	    ops->cursor_reset) {
+	    vc->vc_cursor_type != par->p->cursor_shape ||
+	    par->cursor_state.mask == NULL ||
+	    par->cursor_reset) {
 		char *tmp, *mask = kmalloc_array(w, vc->vc_font.width,
 						 GFP_ATOMIC);
 		int cur_height, size, i = 0;
@@ -292,13 +292,13 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 			return;
 		}
 
-		kfree(ops->cursor_state.mask);
-		ops->cursor_state.mask = mask;
+		kfree(par->cursor_state.mask);
+		par->cursor_state.mask = mask;
 
-		ops->p->cursor_shape = vc->vc_cursor_type;
+		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (CUR_SIZE(ops->p->cursor_shape)) {
+		switch (CUR_SIZE(par->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
@@ -333,26 +333,26 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	switch (mode) {
 	case CM_ERASE:
-		ops->cursor_state.enable = 0;
+		par->cursor_state.enable = 0;
 		break;
 	case CM_DRAW:
 	case CM_MOVE:
 	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
+		par->cursor_state.enable = (use_sw) ? 0 : 1;
 		break;
 	}
 
 	cursor.image.data = src;
-	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-	cursor.image.bg_color = ops->cursor_state.image.bg_color;
-	cursor.image.dx = ops->cursor_state.image.dx;
-	cursor.image.dy = ops->cursor_state.image.dy;
-	cursor.image.height = ops->cursor_state.image.height;
-	cursor.image.width = ops->cursor_state.image.width;
-	cursor.hot.x = ops->cursor_state.hot.x;
-	cursor.hot.y = ops->cursor_state.hot.y;
-	cursor.mask = ops->cursor_state.mask;
-	cursor.enable = ops->cursor_state.enable;
+	cursor.image.fg_color = par->cursor_state.image.fg_color;
+	cursor.image.bg_color = par->cursor_state.image.bg_color;
+	cursor.image.dx = par->cursor_state.image.dx;
+	cursor.image.dy = par->cursor_state.image.dy;
+	cursor.image.height = par->cursor_state.image.height;
+	cursor.image.width = par->cursor_state.image.width;
+	cursor.hot.x = par->cursor_state.hot.x;
+	cursor.hot.y = par->cursor_state.hot.y;
+	cursor.mask = par->cursor_state.mask;
+	cursor.enable = par->cursor_state.enable;
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
@@ -362,32 +362,32 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	if (err)
 		soft_cursor(info, &cursor);
 
-	ops->cursor_reset = 0;
+	par->cursor_reset = 0;
 }
 
 static int cw_update_start(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
-	u32 vxres = GETVXRES(ops->p, info);
+	struct fbcon_par *par = info->fbcon_par;
+	u32 vxres = GETVXRES(par->p, info);
 	u32 xoffset;
 	int err;
 
-	xoffset = vxres - (info->var.xres + ops->var.yoffset);
-	ops->var.yoffset = ops->var.xoffset;
-	ops->var.xoffset = xoffset;
-	err = fb_pan_display(info, &ops->var);
-	ops->var.xoffset = info->var.xoffset;
-	ops->var.yoffset = info->var.yoffset;
-	ops->var.vmode = info->var.vmode;
+	xoffset = vxres - (info->var.xres + par->var.yoffset);
+	par->var.yoffset = par->var.xoffset;
+	par->var.xoffset = xoffset;
+	err = fb_pan_display(info, &par->var);
+	par->var.xoffset = info->var.xoffset;
+	par->var.yoffset = info->var.yoffset;
+	par->var.vmode = info->var.vmode;
 	return err;
 }
 
-void fbcon_rotate_cw(struct fbcon_ops *ops)
+void fbcon_rotate_cw(struct fbcon_par *par)
 {
-	ops->bmove = cw_bmove;
-	ops->clear = cw_clear;
-	ops->putcs = cw_putcs;
-	ops->clear_margins = cw_clear_margins;
-	ops->cursor = cw_cursor;
-	ops->update_start = cw_update_start;
+	par->bmove = cw_bmove;
+	par->clear = cw_clear;
+	par->putcs = cw_putcs;
+	par->clear_margins = cw_clear_margins;
+	par->cursor = cw_cursor;
+	par->update_start = cw_update_start;
 }
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 4a06e71ae443..66b35613368e 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -20,35 +20,35 @@
 
 static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int len, err = 0;
 	int s_cellsize, d_cellsize, i;
 	const u8 *src;
 	u8 *dst;
 
-	if (vc->vc_font.data == ops->fontdata &&
-	    ops->p->con_rotate == ops->cur_rotate)
+	if (vc->vc_font.data == par->fontdata &&
+	    par->p->con_rotate == par->cur_rotate)
 		goto finished;
 
-	src = ops->fontdata = vc->vc_font.data;
-	ops->cur_rotate = ops->p->con_rotate;
+	src = par->fontdata = vc->vc_font.data;
+	par->cur_rotate = par->p->con_rotate;
 	len = vc->vc_font.charcount;
 	s_cellsize = ((vc->vc_font.width + 7)/8) *
 		vc->vc_font.height;
 	d_cellsize = s_cellsize;
 
-	if (ops->rotate == FB_ROTATE_CW ||
-	    ops->rotate == FB_ROTATE_CCW)
+	if (par->rotate == FB_ROTATE_CW ||
+	    par->rotate == FB_ROTATE_CCW)
 		d_cellsize = ((vc->vc_font.height + 7)/8) *
 			vc->vc_font.width;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
 
-	if (ops->fd_size < d_cellsize * len) {
-		kfree(ops->fontbuffer);
-		ops->fontbuffer = NULL;
-		ops->fd_size = 0;
+	if (par->fd_size < d_cellsize * len) {
+		kfree(par->fontbuffer);
+		par->fontbuffer = NULL;
+		par->fd_size = 0;
 
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
@@ -57,14 +57,14 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 			goto finished;
 		}
 
-		ops->fd_size = d_cellsize * len;
-		ops->fontbuffer = dst;
+		par->fd_size = d_cellsize * len;
+		par->fontbuffer = dst;
 	}
 
-	dst = ops->fontbuffer;
-	memset(dst, 0, ops->fd_size);
+	dst = par->fontbuffer;
+	memset(dst, 0, par->fd_size);
 
-	switch (ops->rotate) {
+	switch (par->rotate) {
 	case FB_ROTATE_UD:
 		for (i = len; i--; ) {
 			rotate_ud(src, dst, vc->vc_font.width,
@@ -96,19 +96,19 @@ static int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	return err;
 }
 
-void fbcon_set_rotate(struct fbcon_ops *ops)
+void fbcon_set_rotate(struct fbcon_par *par)
 {
-	ops->rotate_font = fbcon_rotate_font;
+	par->rotate_font = fbcon_rotate_font;
 
-	switch(ops->rotate) {
+	switch(par->rotate) {
 	case FB_ROTATE_CW:
-		fbcon_rotate_cw(ops);
+		fbcon_rotate_cw(par);
 		break;
 	case FB_ROTATE_UD:
-		fbcon_rotate_ud(ops);
+		fbcon_rotate_ud(par);
 		break;
 	case FB_ROTATE_CCW:
-		fbcon_rotate_ccw(ops);
+		fbcon_rotate_ccw(par);
 		break;
 	}
 }
diff --git a/drivers/video/fbdev/core/fbcon_rotate.h b/drivers/video/fbdev/core/fbcon_rotate.h
index 01cbe303b8a2..48305e1a0763 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.h
+++ b/drivers/video/fbdev/core/fbcon_rotate.h
@@ -90,7 +90,7 @@ static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
 	}
 }
 
-extern void fbcon_rotate_cw(struct fbcon_ops *ops);
-extern void fbcon_rotate_ud(struct fbcon_ops *ops);
-extern void fbcon_rotate_ccw(struct fbcon_ops *ops);
+extern void fbcon_rotate_cw(struct fbcon_par *par);
+extern void fbcon_rotate_ud(struct fbcon_par *par);
+extern void fbcon_rotate_ccw(struct fbcon_par *par);
 #endif
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index b6b074cfd9dc..0e4d95ba73d9 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -48,10 +48,10 @@ static void ud_update_attr(u8 *dst, u8 *src, int attribute,
 static void ud_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int dy, int dx, int height, int width)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_copyarea area;
-	u32 vyres = GETVYRES(ops->p, info);
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
 	area.sy = vyres - ((sy + height) * vc->vc_font.height);
 	area.sx = vxres - ((sx + width) * vc->vc_font.width);
@@ -66,10 +66,10 @@ static void ud_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
 		     int sx, int height, int width, int fg, int bg)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_fillrect region;
-	u32 vyres = GETVYRES(ops->p, info);
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
 	region.color = bg;
 	region.dy = vyres - ((sy + height) * vc->vc_font.height);
@@ -86,13 +86,13 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
 				    struct fb_image *image, u8 *buf, u8 *dst)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = vc->vc_font.width >> 3;
 	u8 *src;
 
 	while (cnt--) {
-		src = ops->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
+		src = par->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -119,7 +119,7 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 				      struct fb_image *image, u8 *buf,
 				      u8 *dst)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
@@ -127,7 +127,7 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 	u8 *src;
 
 	while (cnt--) {
-		src = ops->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
+		src = par->fontbuffer + (scr_readw(s--) & charmask)*cellsize;
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -152,7 +152,7 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 		      int fg, int bg)
 {
 	struct fb_image image;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	u32 width = (vc->vc_font.width + 7)/8;
 	u32 cellsize = width * vc->vc_font.height;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -161,10 +161,10 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
 	u8 *dst, *buf = NULL;
-	u32 vyres = GETVYRES(ops->p, info);
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	image.fg_color = fg;
@@ -251,28 +251,28 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		      int fg, int bg)
 {
 	struct fb_cursor cursor;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
-	int y = real_y(ops->p, vc->state.y);
+	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
 	char *src;
-	u32 vyres = GETVYRES(ops->p, info);
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 
-	if (!ops->fontbuffer)
+	if (!par->fontbuffer)
 		return;
 
 	cursor.set = 0;
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = ops->fontbuffer + ((c & charmask) * (w * vc->vc_font.height));
+	src = par->fontbuffer + ((c & charmask) * (w * vc->vc_font.height));
 
-	if (ops->cursor_state.image.data != src ||
-	    ops->cursor_reset) {
-	    ops->cursor_state.image.data = src;
+	if (par->cursor_state.image.data != src ||
+	    par->cursor_reset) {
+	    par->cursor_state.image.data = src;
 	    cursor.set |= FB_CUR_SETIMAGE;
 	}
 
@@ -282,49 +282,49 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
 			return;
-		kfree(ops->cursor_data);
-		ops->cursor_data = dst;
+		kfree(par->cursor_data);
+		par->cursor_data = dst;
 		ud_update_attr(dst, src, attribute, vc);
 		src = dst;
 	}
 
-	if (ops->cursor_state.image.fg_color != fg ||
-	    ops->cursor_state.image.bg_color != bg ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.fg_color = fg;
-		ops->cursor_state.image.bg_color = bg;
+	if (par->cursor_state.image.fg_color != fg ||
+	    par->cursor_state.image.bg_color != bg ||
+	    par->cursor_reset) {
+		par->cursor_state.image.fg_color = fg;
+		par->cursor_state.image.bg_color = bg;
 		cursor.set |= FB_CUR_SETCMAP;
 	}
 
-	if (ops->cursor_state.image.height != vc->vc_font.height ||
-	    ops->cursor_state.image.width != vc->vc_font.width ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.height = vc->vc_font.height;
-		ops->cursor_state.image.width = vc->vc_font.width;
+	if (par->cursor_state.image.height != vc->vc_font.height ||
+	    par->cursor_state.image.width != vc->vc_font.width ||
+	    par->cursor_reset) {
+		par->cursor_state.image.height = vc->vc_font.height;
+		par->cursor_state.image.width = vc->vc_font.width;
 		cursor.set |= FB_CUR_SETSIZE;
 	}
 
 	dy = vyres - ((y * vc->vc_font.height) + vc->vc_font.height);
 	dx = vxres - ((vc->state.x * vc->vc_font.width) + vc->vc_font.width);
 
-	if (ops->cursor_state.image.dx != dx ||
-	    ops->cursor_state.image.dy != dy ||
-	    ops->cursor_reset) {
-		ops->cursor_state.image.dx = dx;
-		ops->cursor_state.image.dy = dy;
+	if (par->cursor_state.image.dx != dx ||
+	    par->cursor_state.image.dy != dy ||
+	    par->cursor_reset) {
+		par->cursor_state.image.dx = dx;
+		par->cursor_state.image.dy = dy;
 		cursor.set |= FB_CUR_SETPOS;
 	}
 
-	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y ||
-	    ops->cursor_reset) {
-		ops->cursor_state.hot.x = cursor.hot.y = 0;
+	if (par->cursor_state.hot.x || par->cursor_state.hot.y ||
+	    par->cursor_reset) {
+		par->cursor_state.hot.x = cursor.hot.y = 0;
 		cursor.set |= FB_CUR_SETHOT;
 	}
 
 	if (cursor.set & FB_CUR_SETSIZE ||
-	    vc->vc_cursor_type != ops->p->cursor_shape ||
-	    ops->cursor_state.mask == NULL ||
-	    ops->cursor_reset) {
+	    vc->vc_cursor_type != par->p->cursor_shape ||
+	    par->cursor_state.mask == NULL ||
+	    par->cursor_reset) {
 		char *mask = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		int cur_height, size, i = 0;
 		u8 msk = 0xff;
@@ -332,13 +332,13 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		if (!mask)
 			return;
 
-		kfree(ops->cursor_state.mask);
-		ops->cursor_state.mask = mask;
+		kfree(par->cursor_state.mask);
+		par->cursor_state.mask = mask;
 
-		ops->p->cursor_shape = vc->vc_cursor_type;
+		par->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (CUR_SIZE(ops->p->cursor_shape)) {
+		switch (CUR_SIZE(par->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
@@ -373,26 +373,26 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	switch (mode) {
 	case CM_ERASE:
-		ops->cursor_state.enable = 0;
+		par->cursor_state.enable = 0;
 		break;
 	case CM_DRAW:
 	case CM_MOVE:
 	default:
-		ops->cursor_state.enable = (use_sw) ? 0 : 1;
+		par->cursor_state.enable = (use_sw) ? 0 : 1;
 		break;
 	}
 
 	cursor.image.data = src;
-	cursor.image.fg_color = ops->cursor_state.image.fg_color;
-	cursor.image.bg_color = ops->cursor_state.image.bg_color;
-	cursor.image.dx = ops->cursor_state.image.dx;
-	cursor.image.dy = ops->cursor_state.image.dy;
-	cursor.image.height = ops->cursor_state.image.height;
-	cursor.image.width = ops->cursor_state.image.width;
-	cursor.hot.x = ops->cursor_state.hot.x;
-	cursor.hot.y = ops->cursor_state.hot.y;
-	cursor.mask = ops->cursor_state.mask;
-	cursor.enable = ops->cursor_state.enable;
+	cursor.image.fg_color = par->cursor_state.image.fg_color;
+	cursor.image.bg_color = par->cursor_state.image.bg_color;
+	cursor.image.dx = par->cursor_state.image.dx;
+	cursor.image.dy = par->cursor_state.image.dy;
+	cursor.image.height = par->cursor_state.image.height;
+	cursor.image.width = par->cursor_state.image.width;
+	cursor.hot.x = par->cursor_state.hot.x;
+	cursor.hot.y = par->cursor_state.hot.y;
+	cursor.mask = par->cursor_state.mask;
+	cursor.enable = par->cursor_state.enable;
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
@@ -402,36 +402,36 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 	if (err)
 		soft_cursor(info, &cursor);
 
-	ops->cursor_reset = 0;
+	par->cursor_reset = 0;
 }
 
 static int ud_update_start(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int xoffset, yoffset;
-	u32 vyres = GETVYRES(ops->p, info);
-	u32 vxres = GETVXRES(ops->p, info);
+	u32 vyres = GETVYRES(par->p, info);
+	u32 vxres = GETVXRES(par->p, info);
 	int err;
 
-	xoffset = vxres - info->var.xres - ops->var.xoffset;
-	yoffset = vyres - info->var.yres - ops->var.yoffset;
+	xoffset = vxres - info->var.xres - par->var.xoffset;
+	yoffset = vyres - info->var.yres - par->var.yoffset;
 	if (yoffset < 0)
 		yoffset += vyres;
-	ops->var.xoffset = xoffset;
-	ops->var.yoffset = yoffset;
-	err = fb_pan_display(info, &ops->var);
-	ops->var.xoffset = info->var.xoffset;
-	ops->var.yoffset = info->var.yoffset;
-	ops->var.vmode = info->var.vmode;
+	par->var.xoffset = xoffset;
+	par->var.yoffset = yoffset;
+	err = fb_pan_display(info, &par->var);
+	par->var.xoffset = info->var.xoffset;
+	par->var.yoffset = info->var.yoffset;
+	par->var.vmode = info->var.vmode;
 	return err;
 }
 
-void fbcon_rotate_ud(struct fbcon_ops *ops)
+void fbcon_rotate_ud(struct fbcon_par *par)
 {
-	ops->bmove = ud_bmove;
-	ops->clear = ud_clear;
-	ops->putcs = ud_putcs;
-	ops->clear_margins = ud_clear_margins;
-	ops->cursor = ud_cursor;
-	ops->update_start = ud_update_start;
+	par->bmove = ud_bmove;
+	par->clear = ud_clear;
+	par->putcs = ud_putcs;
+	par->clear_margins = ud_clear_margins;
+	par->cursor = ud_cursor;
+	par->update_start = ud_update_start;
 }
diff --git a/drivers/video/fbdev/core/softcursor.c b/drivers/video/fbdev/core/softcursor.c
index 29e5b21cf373..900788c05915 100644
--- a/drivers/video/fbdev/core/softcursor.c
+++ b/drivers/video/fbdev/core/softcursor.c
@@ -21,7 +21,7 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
@@ -34,19 +34,19 @@ int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	s_pitch = (cursor->image.width + 7) >> 3;
 	dsize = s_pitch * cursor->image.height;
 
-	if (dsize + sizeof(struct fb_image) != ops->cursor_size) {
-		kfree(ops->cursor_src);
-		ops->cursor_size = dsize + sizeof(struct fb_image);
+	if (dsize + sizeof(struct fb_image) != par->cursor_size) {
+		kfree(par->cursor_src);
+		par->cursor_size = dsize + sizeof(struct fb_image);
 
-		ops->cursor_src = kmalloc(ops->cursor_size, GFP_ATOMIC);
-		if (!ops->cursor_src) {
-			ops->cursor_size = 0;
+		par->cursor_src = kmalloc(par->cursor_size, GFP_ATOMIC);
+		if (!par->cursor_src) {
+			par->cursor_size = 0;
 			return -ENOMEM;
 		}
 	}
 
-	src = ops->cursor_src + sizeof(struct fb_image);
-	image = (struct fb_image *)ops->cursor_src;
+	src = par->cursor_src + sizeof(struct fb_image);
+	image = (struct fb_image *)par->cursor_src;
 	*image = cursor->image;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
 
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index b3aa0c6620c7..f2712256d7a0 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -151,34 +151,34 @@ static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 static int tile_update_start(struct fb_info *info)
 {
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 	int err;
 
-	err = fb_pan_display(info, &ops->var);
-	ops->var.xoffset = info->var.xoffset;
-	ops->var.yoffset = info->var.yoffset;
-	ops->var.vmode = info->var.vmode;
+	err = fb_pan_display(info, &par->var);
+	par->var.xoffset = info->var.xoffset;
+	par->var.yoffset = info->var.yoffset;
+	par->var.vmode = info->var.vmode;
 	return err;
 }
 
 void fbcon_set_tileops(struct vc_data *vc, struct fb_info *info)
 {
 	struct fb_tilemap map;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_par *par = info->fbcon_par;
 
-	ops->bmove = tile_bmove;
-	ops->clear = tile_clear;
-	ops->putcs = tile_putcs;
-	ops->clear_margins = tile_clear_margins;
-	ops->cursor = tile_cursor;
-	ops->update_start = tile_update_start;
+	par->bmove = tile_bmove;
+	par->clear = tile_clear;
+	par->putcs = tile_putcs;
+	par->clear_margins = tile_clear_margins;
+	par->cursor = tile_cursor;
+	par->update_start = tile_update_start;
 
-	if (ops->p) {
+	if (par->p) {
 		map.width = vc->vc_font.width;
 		map.height = vc->vc_font.height;
 		map.depth = 1;
 		map.length = vc->vc_font.charcount;
-		map.data = ops->p->fontdata;
+		map.data = par->p->fontdata;
 		info->tileops->fb_settile(info, &map);
 	}
 }
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ef103ef392ee..2caea3390d6a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -521,10 +521,19 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * In cacheless mode the server is the source of truth for nlink and the
+ * inode is going away immediately, so locally adjusting i_nlink buys
+ * nothing and races with concurrent metadata fetches that may already
+ * have observed the post-unlink value (nlink == 0).
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+
+	if (v9ses->cache != CACHE_LOOSE && v9ses->cache != CACHE_FSCACHE)
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 30379c33ad20..aa9f6365566e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1243,7 +1243,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1332,7 +1332,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 425cfbef4e5e..f4bee6a95bba 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -398,7 +398,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -471,7 +471,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 error:
 	if (interpreter) {
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 	}
 	kfree(interpreter_name);
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a26ae2ca96e8..2bc21f752e16 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -163,8 +163,10 @@ static Node *get_binfmt_handler(struct linux_binprm *bprm)
 static void put_binfmt_handler(Node *e)
 {
 	if (refcount_dec_and_test(&e->users)) {
-		if (e->flags & MISC_FMT_OPEN_FILE)
+		if (e->flags & MISC_FMT_OPEN_FILE) {
+			exe_file_allow_write_access(e->interp_file);
 			filp_close(e->interp_file, NULL);
+		}
 		kfree(e);
 	}
 }
@@ -218,8 +220,14 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
-		if (!IS_ERR(interp_file))
-			deny_write_access(interp_file);
+		if (!IS_ERR(interp_file)) {
+			int err = exe_file_deny_write_access(interp_file);
+
+			if (err) {
+				fput(interp_file);
+				interp_file = ERR_PTR(err);
+			}
+		}
 	} else {
 		interp_file = open_exec(fmt->interpreter);
 	}
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index f4fc8e0b847c..c8373971d1e3 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include "super.h"
+#include "mds_client.h"
 
 static inline void ceph_set_cached_acl(struct inode *inode,
 					int type, struct posix_acl *acl)
@@ -31,6 +32,7 @@ static inline void ceph_set_cached_acl(struct inode *inode,
 
 struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int size;
 	unsigned int retry_cnt = 0;
 	const char *name;
@@ -72,8 +74,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 	} else if (size == -ENODATA || size == 0) {
 		acl = NULL;
 	} else {
-		pr_err_ratelimited("get acl %llx.%llx failed, err=%d\n",
-				   ceph_vinop(inode), size);
+		pr_err_ratelimited_client(cl, "%llx.%llx failed, err=%d\n",
+					  ceph_vinop(inode), size);
 		acl = ERR_PTR(-EIO);
 	}
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7b65d4b5ebe8..618ef368b564 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -196,7 +196,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 objno, objoff;
 	u32 xlen;
@@ -210,7 +210,7 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(req->r_inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_read_subrequest *subreq = req->r_priv;
 	int num_pages;
@@ -243,7 +243,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	struct netfs_read_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct iov_iter iter;
@@ -483,7 +483,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
 	int err;
@@ -625,7 +625,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	int rc = req->r_result;
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	unsigned int len = 0;
 	bool remove_page;
 
@@ -707,7 +707,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino = ceph_vino(inode);
 	pgoff_t index, start_index, end = -1;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
@@ -1144,7 +1144,7 @@ static struct ceph_snap_context *
 ceph_find_incompatible(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (READ_ONCE(fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN) {
@@ -1594,7 +1594,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 {
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct page *page = NULL;
 	u64 len, inline_version;
@@ -1751,7 +1751,7 @@ enum {
 static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				s64 pool, struct ceph_string *pool_ns)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->vfs_inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
 	struct rb_node **p, *parent;
@@ -1944,7 +1944,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 		return 0;
 	}
 
-	if (ceph_test_mount_opt(ceph_inode_to_client(inode),
+	if (ceph_test_mount_opt(ceph_inode_to_fs_client(inode),
 				NOPOOLPERM))
 		return 0;
 
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 9cfadbb86568..d22020f2f0e0 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -138,7 +138,7 @@ static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
 void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_aux_inode aux;
 
 	/* No caching for filesystem */
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 271f5a76af03..bf904dc861a4 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -633,7 +633,7 @@ void ceph_add_cap(struct inode *inode,
 		  unsigned seq, unsigned mseq, u64 realmino, int flags,
 		  struct ceph_cap **new_cap)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
@@ -919,7 +919,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 int __ceph_caps_issued_mask_metric(struct ceph_inode_info *ci, int mask,
 				   int touch)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	int r;
 
 	r = __ceph_caps_issued_mask(ci, mask, touch);
@@ -993,7 +993,7 @@ int __ceph_caps_file_wanted(struct ceph_inode_info *ci)
 	const int WR_SHIFT = ffs(CEPH_FILE_MODE_WR);
 	const int LAZY_SHIFT = ffs(CEPH_FILE_MODE_LAZY);
 	struct ceph_mount_options *opt =
-		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
+		ceph_inode_to_fs_client(&ci->vfs_inode)->mount_options;
 	unsigned long used_cutoff = jiffies - opt->caps_wanted_delay_max * HZ;
 	unsigned long idle_cutoff = jiffies - opt->caps_wanted_delay_min * HZ;
 
@@ -1118,7 +1118,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
 
-	mdsc = ceph_inode_to_client(&ci->vfs_inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(&ci->vfs_inode)->mdsc;
 
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
@@ -1188,7 +1188,7 @@ void ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	WARN_ON_ONCE(ci->i_auth_cap == cap &&
 		     !list_empty(&ci->i_dirty_item) &&
 		     !fsc->blocklisted &&
@@ -1623,7 +1623,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		      struct ceph_mds_session **psession)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
 	bool need_put = false;
 	int mds;
@@ -1688,7 +1688,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			   struct ceph_cap_flush **pcf)
 {
 	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+		ceph_sb_to_fs_client(ci->vfs_inode.i_sb)->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
@@ -1811,7 +1811,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 				struct ceph_mds_session *session, bool wake,
 				u64 *oldest_flush_tid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *cf = NULL;
 	int flushing;
@@ -2143,7 +2143,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
  */
 static int try_flush_caps(struct inode *inode, u64 *ptid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int flushing = 0;
 	u64 flush_tid = 0, oldest_flush_tid = 0;
@@ -2221,7 +2221,7 @@ static int caps_are_flushed(struct inode *inode, u64 flush_tid)
  */
 static int unsafe_request_wait(struct inode *inode)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req1 = NULL, *req2 = NULL;
 	int ret, err = 0;
@@ -2400,7 +2400,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 				       caps_are_flushed(inode, flush_tid));
 	} else {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(inode->i_sb)->mdsc;
+			ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 		spin_lock(&ci->i_ceph_lock);
 		if (__ceph_caps_dirty(ci))
@@ -2649,7 +2649,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			    loff_t endoff, int flags, int *got)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	int ret = 0;
 	int have, implemented;
 	bool snap_rwsem_locked = false;
@@ -2864,7 +2864,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 	struct ceph_file_info *fi = filp->private_data;
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int ret, _got, flags;
 
 	ret = ceph_pool_perm_check(inode, need);
@@ -2910,7 +2910,19 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 					ret = -ERESTARTSYS;
 					break;
 				}
-				wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
+
+				/*
+				 * If a cap update is lost after
+				 * mds_wanted was raised, waiting
+				 * forever will never make progress.
+				 * Retry the renew path periodically
+				 * so we can resend synchronously.
+				 */
+				if (!wait_woken(&wait, TASK_INTERRUPTIBLE,
+						CEPH_GET_CAPS_WAIT_TIMEOUT)) {
+					ret = -ESTALE;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -2942,7 +2954,8 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 				continue;
 			}
 			if (ret == -ESTALE) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
@@ -3593,7 +3606,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *cf, *tmp_cf;
 	LIST_HEAD(to_remove);
 	unsigned seq = le32_to_cpu(m->seq);
@@ -3699,7 +3712,7 @@ void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
 			   bool *wake_ci, bool *wake_mdsc)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	bool ret;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
@@ -3743,7 +3756,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 				     struct ceph_mds_session *session)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	u64 follows = le64_to_cpu(m->snap_follows);
 	struct ceph_cap_snap *capsnap;
 	bool flushed = false;
@@ -3827,7 +3840,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *tsession = NULL;
 	struct ceph_cap *cap, *tcap, *new_cap = NULL;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -4442,7 +4455,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 
 		if (__ceph_caps_dirty(ci)) {
 			struct ceph_mds_client *mdsc =
-				ceph_inode_to_client(inode)->mdsc;
+				ceph_inode_to_fs_client(inode)->mdsc;
 			__cap_delay_requeue_front(mdsc, ci);
 		}
 	}
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f1572609066e..74845a793aa3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -307,7 +307,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i;
 	int err;
@@ -679,7 +679,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 				   struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_mutex */
 
 	/* .snap dir? */
@@ -748,7 +748,7 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	int op;
@@ -1147,7 +1147,7 @@ static int get_caps_for_async_unlink(struct inode *dir, struct dentry *dentry)
  */
 static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -1308,7 +1308,7 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_move_tail(&di->lease_list, &mdsc->dentry_leases);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1355,7 +1355,7 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	__dentry_dir_lease_touch(mdsc, di),
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1369,7 +1369,7 @@ static void __dentry_lease_unlist(struct ceph_dentry_info *di)
 	if (list_empty(&di->lease_list))
 		return;
 
-	mdsc = ceph_sb_to_client(di->dentry->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(di->dentry->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_del_init(&di->lease_list);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1722,7 +1722,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
-	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
@@ -1829,7 +1829,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 static void ceph_d_release(struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 
 	dout("d_release %p\n", dentry);
 
@@ -1898,7 +1898,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 	int left;
 	const int bufsize = 1024;
 
-	if (!ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb), DIRSTAT))
+	if (!ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb), DIRSTAT))
 		return -EISDIR;
 
 	if (!dfi->dir_info) {
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 1d65934c1262..466af8e0cbce 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -122,7 +122,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 
 static struct inode *__lookup_inode(struct super_block *sb, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct inode *inode;
 	struct ceph_vino vino;
 	int err;
@@ -198,7 +198,7 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 					  struct ceph_nfs_snapfh *sfh,
 					  bool want_parent)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	struct ceph_vino vino;
@@ -305,7 +305,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 static struct dentry *__get_parent(struct super_block *sb,
 				   struct dentry *child, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	int mask;
@@ -427,7 +427,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 {
 	struct inode *inode = d_inode(child);
 	struct inode *dir = d_inode(parent);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_request *req = NULL;
 	char *last_name = NULL;
 	unsigned next_offset = 2;
@@ -530,7 +530,7 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return __get_snap_name(parent, name, child);
 
-	mdsc = ceph_inode_to_client(inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
 				       USE_ANY_MDS);
 	if (IS_ERR(req))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ca8d228ee395..7ecb51384497 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -233,7 +233,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 
 	spin_lock_init(&fi->rw_contexts_lock);
 	INIT_LIST_HEAD(&fi->rw_contexts);
-	fi->filp_gen = READ_ONCE(ceph_inode_to_client(inode)->filp_gen);
+	fi->filp_gen = READ_ONCE(ceph_inode_to_fs_client(inode)->filp_gen);
 
 	return 0;
 }
@@ -277,24 +277,27 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
-	int err, flags, wanted;
+	int err, flags, wanted, issued;
 
 	spin_lock(&ci->i_ceph_lock);
 	__ceph_touch_fmode(ci, mdsc, fmode);
 	wanted = __ceph_caps_file_wanted(ci);
+	issued = __ceph_caps_issued(ci, NULL);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
-		int issued = __ceph_caps_issued(ci, NULL);
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
+	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
-		dout("renew caps %p want %s issued %s updating mds_wanted\n",
-		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
+		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
+		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
+		      ceph_cap_string(issued));
 		ceph_check_caps(ci, 0, NULL);
 		return 0;
 	}
@@ -325,7 +328,8 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
-	dout("renew caps %p open result=%d\n", inode, err);
+	doutc(cl, "%p %llx.%llx open result=%d\n", inode, ceph_vinop(inode),
+	      err);
 	return err < 0 ? err : 0;
 }
 
@@ -338,7 +342,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 int ceph_open(struct inode *inode, struct file *file)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *fi = file->private_data;
@@ -687,7 +691,7 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -875,7 +879,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	ssize_t ret;
 	u64 off = iocb->ki_pos;
@@ -1085,7 +1089,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		if (aio_work) {
 			INIT_WORK(&aio_work->work, ceph_aio_retry_work);
 			aio_work->req = req;
-			queue_work(ceph_inode_to_client(inode)->inode_wq,
+			queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 				   &aio_work->work);
 			return;
 		}
@@ -1213,7 +1217,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client_metric *metric = &fsc->mdsc->metric;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
@@ -1423,7 +1427,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
 	struct page **pages;
@@ -1702,7 +1706,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -1895,7 +1899,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	loff_t i_size;
 	loff_t ret;
 
@@ -1988,7 +1992,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 				    loff_t offset, loff_t *length)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_snap_context *snapc;
 	int ret = 0;
@@ -2332,7 +2336,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
-	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
+	struct ceph_fs_client *src_fsc = ceph_inode_to_fs_client(src_inode);
 	loff_t size;
 	ssize_t ret = -EIO, bytes;
 	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
@@ -2340,7 +2344,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	int src_got = 0, dst_got = 0, err, dirty;
 
 	if (src_inode->i_sb != dst_inode->i_sb) {
-		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
+		struct ceph_fs_client *dst_fsc = ceph_inode_to_fs_client(dst_inode);
 
 		if (ceph_fsid_compare(&src_fsc->client->fsid,
 				      &dst_fsc->client->fsid)) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 28281c83cf5f..3adc4adef49a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1272,7 +1272,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct inode *in = NULL;
 	struct ceph_vino tvino, dvino;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	dout("fill_trace %p is_dentry %d is_target %d\n", req,
@@ -1828,7 +1828,7 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 
 void ceph_queue_inode_work(struct inode *inode, int work_bit)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	set_bit(work_bit, &ci->i_work_mask);
 
@@ -1845,7 +1845,7 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
 static void ceph_do_invalidate_pages(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	u32 orig_gen;
 	int check = 0;
 
@@ -2000,7 +2000,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf;
 	int issued;
 	int release = 0, dirtied = 0;
@@ -2215,7 +2215,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -2248,7 +2248,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		      int mask, bool force)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int mode;
@@ -2378,7 +2378,7 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
 
 	if (S_ISDIR(inode->i_mode)) {
-		if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
+		if (ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb),
 					RBYTES))
 			stat->size = ci->i_rbytes;
 		else
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad4..7ba8bb520e84 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -64,7 +64,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
@@ -139,7 +139,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	int err;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -182,7 +182,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
-		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+		&ceph_sb_to_fs_client(inode->i_sb)->client->osdc;
 	struct ceph_object_locator oloc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
 	u32 xlen;
@@ -243,7 +243,7 @@ static long ceph_ioctl_lazyio(struct file *file)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 
 	if ((fi->fmode & CEPH_FILE_MODE_LAZY) == 0) {
 		spin_lock(&ci->i_ceph_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8236980957b6..7c47ce276a99 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
@@ -3158,6 +3159,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
+	unsigned int nofs_flags;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -3307,6 +3309,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
+
+	/* disable fs reclaim while we are using current->journal_info
+	 * for our own purposes, or else shrinkers of other
+	 * filesystems might dereference this pointer as a different
+	 * type
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	current->journal_info = req;
 	err = ceph_fill_trace(mdsc->fsc->sb, req);
 	if (err == 0) {
@@ -3315,6 +3325,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
+	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index cd943842f0a3..4c2741933bf4 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -61,6 +61,8 @@ enum ceph_feature_type {
 struct ceph_fs_client;
 struct ceph_cap;
 
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
+
 /*
  * parsed info about a single inode.  pointers are into the encoded
  * on-wire structures within the mds reply message payload.
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 30387733765d..0e869b70a50c 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -14,7 +14,7 @@
 #include "super.h"
 
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
-	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
+	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m->m_info[i].laggy))
 
 static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool ignore_laggy)
 {
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index d21ff4354332..7dff3967d3af 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -25,6 +25,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	struct ceph_client_metric *m = &mdsc->metric;
 	u64 nr_caps = atomic64_read(&m->total_caps);
 	u32 header_len = sizeof(struct ceph_metric_header);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct timespec64 ts;
 	s64 sum;
@@ -38,8 +39,8 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true);
 	if (!msg) {
-		pr_err("send metrics to mds%d, failed to allocate message\n",
-		       s->s_mds);
+		pr_err_client(cl, "to mds%d, failed to allocate message\n",
+			      s->s_mds);
 		return false;
 	}
 
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index bfa7e146f526..74a1fc919c6b 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -875,7 +875,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 void ceph_change_snap_realm(struct inode *inode, struct ceph_snap_realm *realm)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_snap_realm *oldrealm = ci->i_snap_realm;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 85a283992b44..e520ad25454a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -41,7 +41,7 @@ static LIST_HEAD(ceph_fsc_list);
  */
 static void ceph_put_super(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("put_super\n");
 	ceph_mdsc_close_sessions(fsc->mdsc);
@@ -49,7 +49,7 @@ static void ceph_put_super(struct super_block *s)
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(d_inode(dentry));
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
 	struct ceph_statfs st;
 	int i, err;
@@ -112,7 +112,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int ceph_sync_fs(struct super_block *sb, int wait)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	if (!wait) {
 		dout("sync_fs (non-blocking)\n");
@@ -529,7 +529,7 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
  */
 static int ceph_show_options(struct seq_file *m, struct dentry *root)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(root->d_sb);
 	struct ceph_mount_options *fsopt = fsc->mount_options;
 	size_t pos;
 	int ret;
@@ -848,7 +848,7 @@ static void __ceph_umount_begin(struct ceph_fs_client *fsc)
  */
 static void ceph_umount_begin(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_umount_begin - starting forced umount\n");
 	if (!fsc)
@@ -1006,7 +1006,7 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 	struct ceph_fs_client *new = fc->s_fs_info;
 	struct ceph_mount_options *fsopt = new->mount_options;
 	struct ceph_options *opt = new->client->options;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_compare_super %p\n", sb);
 
@@ -1099,9 +1099,9 @@ static int ceph_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
-	if (ceph_sb_to_client(sb) != fsc) {
+	if (ceph_sb_to_fs_client(sb) != fsc) {
 		destroy_fs_client(fsc);
-		fsc = ceph_sb_to_client(sb);
+		fsc = ceph_sb_to_fs_client(sb);
 		dout("get_sb got existing client %p\n", fsc);
 	} else {
 		dout("get_sb using new client %p\n", fsc);
@@ -1152,7 +1152,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 {
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(fc->root->d_sb);
 
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
@@ -1223,7 +1223,7 @@ static int ceph_init_fs_context(struct fs_context *fc)
 
 static void ceph_kill_sb(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("kill_sb %p\n", s);
 
@@ -1261,7 +1261,7 @@ MODULE_ALIAS_FS("ceph");
 
 int ceph_force_reconnect(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	fsc->mount_state = CEPH_MOUNT_RECOVER;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8c9021d0f837..5e07715b895d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -439,13 +439,13 @@ ceph_inode(const struct inode *inode)
 }
 
 static inline struct ceph_fs_client *
-ceph_inode_to_client(const struct inode *inode)
+ceph_inode_to_fs_client(const struct inode *inode)
 {
 	return (struct ceph_fs_client *)inode->i_sb->s_fs_info;
 }
 
 static inline struct ceph_fs_client *
-ceph_sb_to_client(const struct super_block *sb)
+ceph_sb_to_fs_client(const struct super_block *sb)
 {
 	return (struct ceph_fs_client *)sb->s_fs_info;
 }
@@ -453,7 +453,13 @@ ceph_sb_to_client(const struct super_block *sb)
 static inline struct ceph_mds_client *
 ceph_sb_to_mdsc(const struct super_block *sb)
 {
-	return (struct ceph_mds_client *)ceph_sb_to_client(sb)->mdsc;
+	return (struct ceph_mds_client *)ceph_sb_to_fs_client(sb)->mdsc;
+}
+
+static inline struct ceph_client *
+ceph_inode_to_client(const struct inode *inode)
+{
+	return (struct ceph_client *)ceph_inode_to_fs_client(inode)->client;
 }
 
 static inline struct ceph_vino
@@ -509,7 +515,7 @@ static inline u64 ceph_snap(struct inode *inode)
  */
 static inline u64 ceph_present_ino(struct super_block *sb, u64 ino)
 {
-	if (unlikely(ceph_test_mount_opt(ceph_sb_to_client(sb), INO32)))
+	if (unlikely(ceph_test_mount_opt(ceph_sb_to_fs_client(sb), INO32)))
 		return ceph_ino_to_ino32(ino);
 	return ino;
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 0cec77cb674e..60f6e7693f93 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -57,7 +57,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				    size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
@@ -161,7 +161,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 					 char *val, size_t size)
 {
 	ssize_t ret;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
@@ -313,7 +313,7 @@ static ssize_t ceph_vxattrcb_snap_btime(struct ceph_inode_info *ci, char *val,
 static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph_inode_info *ci,
 					  char *val, size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 
 	return ceph_fmt_xattr(val, size, "%pU", &fsc->client->fsid);
 }
@@ -321,7 +321,7 @@ static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph_inode_info *ci,
 static ssize_t ceph_vxattrcb_client_id(struct ceph_inode_info *ci,
 				       char *val, size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 
 	return ceph_fmt_xattr(val, size, "client%lld",
 			      ceph_client_gid(fsc->client));
@@ -1052,7 +1052,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1122,7 +1122,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 {
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct ceph_buffer *old_blob = NULL;
 	int issued;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 3aaa45375d8b..9727cb925080 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3736,7 +3736,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3803,7 +3803,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kfree(buf);
+	kvfree(buf);
 	return rc;
 }
 
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index cad34dbe8e29..42da1f9e6492 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -465,7 +465,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 		return -EFAULT;
 	policy.version = version;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(file_mnt_user_ns(filp), inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
diff --git a/fs/exec.c b/fs/exec.c
index d3418ca9e5b0..e71342f0408c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,7 +929,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1499,7 +1499,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1790,7 +1790,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c74b27eba94b..90cb8560af1d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -926,7 +926,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
 
-	inc_page_count(fio->sbi, WB_DATA_TYPE(page));
+	inc_page_count(fio->sbi, WB_DATA_TYPE(fio->page));
 
 	*fio->last_block = fio->new_blkaddr;
 	*fio->bio = bio;
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 1947edb0cd28..cc4233c414b6 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -920,7 +920,7 @@ int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
 	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
@@ -1107,7 +1107,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 			unsigned int nvec, int enc)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(iov[0].iov_base);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(iov[0].iov_base);
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc;
 	DECLARE_CRYPTO_WAIT(wait);
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 76afa733351a..b0a47b7923d5 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -305,8 +305,11 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 	return true;
 }
 
-#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
-#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+/* "+2" for BCC field (ByteCount, 2 bytes) */
+#define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
+#define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
+#define SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE	\
+	(sizeof(struct smb2_transform_hdr) + sizeof(struct smb2_hdr))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -321,6 +324,7 @@ int ksmbd_conn_handler_loop(void *p)
 	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
 	struct ksmbd_transport *t = conn->transport;
 	unsigned int pdu_size, max_allowed_pdu_size;
+	__le32 proto;
 	char hdr_buf[4] = {0,};
 	int size;
 
@@ -365,7 +369,7 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
-		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+		if (pdu_size < SMB1_MIN_SUPPORTED_PDU_SIZE)
 			break;
 
 		/* 4 for rfc1002 length field */
@@ -396,11 +400,14 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
-		    SMB2_PROTO_NUMBER) {
-			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
-				break;
-		}
+		proto = *(__le32 *)smb_get_msg(conn->request_buf);
+		if (proto == SMB2_PROTO_NUMBER &&
+		    pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
+			break;
+
+		if (proto == SMB2_TRANSFORM_PROTO_NUM &&
+		    pdu_size < SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE)
+			break;
 
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 66815e56223f..2d675ab5b715 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -176,6 +176,11 @@ void ksmbd_conn_unlock(struct ksmbd_conn *conn);
  * This is a hack. We will move status to a proper place once we land
  * a multi-sessions support.
  */
+static inline bool ksmbd_conn_new(struct ksmbd_conn *conn)
+{
+	return READ_ONCE(conn->status) == KSMBD_SESS_NEW;
+}
+
 static inline bool ksmbd_conn_good(struct ksmbd_conn *conn)
 {
 	return READ_ONCE(conn->status) == KSMBD_SESS_GOOD;
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index a6730fd9d76e..78d73deb5444 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -656,7 +656,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -670,7 +670,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -760,7 +760,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 		goto out;
 	}
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -774,7 +774,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f7eeb79be48a..cd3e475bfb30 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -46,8 +46,8 @@ static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = smb2_get_msg(work->request_buf);
-		*rsp = smb2_get_msg(work->response_buf);
+		*req = smb_get_msg(work->request_buf);
+		*rsp = smb_get_msg(work->response_buf);
 	}
 }
 
@@ -147,7 +147,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = smb2_get_msg(work->response_buf);
+		err_rsp = smb_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
 		int err;
@@ -173,7 +173,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -197,7 +197,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -223,7 +223,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = smb2_get_msg(work->request_buf);
+		rcv_hdr = smb_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -236,7 +236,7 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
 
 	work->iov_idx = 0;
@@ -259,7 +259,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	int err;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = smb_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
@@ -273,7 +273,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = smb2_get_msg(work->response_buf);
+	rsp = smb_get_msg(work->response_buf);
 
 	WARN_ON(ksmbd_conn_good(conn));
 
@@ -448,7 +448,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -499,8 +499,8 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
-	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rsp_hdr = smb_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb_get_msg(work->request_buf);
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
@@ -529,7 +529,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -545,7 +545,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 		    offsetof(struct smb2_query_info_req, OutputBufferLength))
 			return -EINVAL;
 
-		req = smb2_get_msg(work->request_buf);
+		req = smb_get_msg(work->request_buf);
 		if ((req->InfoType == SMB2_O_INFO_FILE &&
 		     (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		      req->FileInfoClass == FILE_ALL_INFORMATION)) ||
@@ -732,10 +732,10 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 	}
 
 	in_work->conn = work->conn;
-	memcpy(smb2_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
+	memcpy(smb_get_msg(in_work->response_buf), ksmbd_resp_buf_next(work),
 	       __SMB2_HEADER_STRUCTURE_SIZE);
 
-	rsp_hdr = smb2_get_msg(in_work->response_buf);
+	rsp_hdr = smb_get_msg(in_work->response_buf);
 	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
 	rsp_hdr->Id.AsyncId = cpu_to_le64(work->async_id);
 	smb2_set_err_rsp(in_work);
@@ -1107,25 +1107,21 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
  * smb2_handle_negotiate() - handler for smb2 negotiate command
  * @work:	smb work containing smb request buffer
  *
+ * The caller holds conn->srv_mutex.
+ *
  * Return:      0
  */
 int smb2_handle_negotiate(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
-	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_negotiate_req *req = smb_get_msg(work->request_buf);
+	struct smb2_negotiate_rsp *rsp = smb_get_msg(work->response_buf);
 	int rc = 0;
 	unsigned int smb2_buf_len, smb2_neg_size, neg_ctxt_len = 0;
 	__le32 status;
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
 	conn->need_neg = false;
-	if (ksmbd_conn_good(conn)) {
-		pr_err("conn->tcp_status is already in CifsGood State\n");
-		work->send_no_response = 1;
-		return rc;
-	}
-
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
 	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
@@ -1495,11 +1491,6 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		return -EPERM;
 	}
 
-	/* Check for previous session */
-	prev_id = le64_to_cpu(req->PreviousSessionId);
-	if (prev_id && prev_id != sess->id)
-		destroy_previous_session(conn, user, prev_id);
-
 	if (sess->state == SMB2_SESSION_VALID) {
 		/*
 		 * Reuse session if anonymous try to connect
@@ -1537,6 +1528,10 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		}
 	}
 
+	prev_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_id && prev_id != sess->id)
+		destroy_previous_session(conn, sess->user, prev_id);
+
 	/*
 	 * If session state is SMB2_SESSION_VALID, We can assume
 	 * that it is reauthentication. And the user/password
@@ -5570,7 +5565,7 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_echo_rsp *rsp = smb_get_msg(work->response_buf);
 
 	if (work->next_smb2_rcv_hdr_off)
 		rsp = ksmbd_resp_buf_next(work);
@@ -5814,6 +5809,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	 */
 
 	loff_t alloc_blks;
+	u64 alloc_size;
 	struct inode *inode;
 	struct kstat stat;
 	int rc;
@@ -5826,7 +5822,19 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	if (rc)
 		return rc;
 
-	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
+	/*
+	 * AllocationSize is fully client-controlled (the caller only
+	 * validates the fixed 8-byte buffer length). Reject values that
+	 * would overflow the "round up to 512-byte blocks" conversion
+	 * below instead of silently wrapping it to a tiny block count,
+	 * which would truncate the file to a size the client never
+	 * asked for.
+	 */
+	alloc_size = le64_to_cpu(file_alloc_info->AllocationSize);
+	if (alloc_size > MAX_LFS_FILESIZE - 511)
+		return -EINVAL;
+
+	alloc_blks = (alloc_size + 511) >> 9;
 	inode = file_inode(fp->filp);
 
 	if (alloc_blks > stat.blocks) {
@@ -6118,8 +6126,8 @@ int smb2_set_info(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
@@ -6348,8 +6356,8 @@ int smb2_read(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -6766,7 +6774,7 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *iter;
 	struct list_head *command_list;
@@ -6783,7 +6791,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list,
 				    async_request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (iter->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -6804,7 +6812,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(iter, command_list, request_entry) {
-			chdr = smb2_get_msg(iter->request_buf);
+			chdr = smb_get_msg(iter->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    iter == work)
@@ -7736,8 +7744,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = smb2_get_msg(work->request_buf);
-		rsp = smb2_get_msg(work->response_buf);
+		req = smb_get_msg(work->request_buf);
+		rsp = smb_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -8405,7 +8413,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *rcv_hdr2 = smb_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8430,7 +8438,7 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8505,7 +8513,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 	struct kvec iov[1];
 	size_t len;
 
-	hdr = smb2_get_msg(work->request_buf);
+	hdr = smb_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
@@ -8641,7 +8649,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 {
 	struct smb2_transform_hdr *tr_hdr = tr_buf + 4;
-	struct smb2_hdr *hdr = smb2_get_msg(old_buf);
+	struct smb2_hdr *hdr = smb_get_msg(old_buf);
 	unsigned int orig_len = get_rfc1002_len(old_buf);
 
 	/* tr_buf must be cleared by the caller */
@@ -8680,7 +8688,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 
 bool smb3_is_transform_hdr(void *buf)
 {
-	struct smb2_transform_hdr *trhdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *trhdr = smb_get_msg(buf);
 
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
@@ -8692,7 +8700,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
-	struct smb2_transform_hdr *tr_hdr = smb2_get_msg(buf);
+	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -8733,7 +8741,7 @@ bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
-	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rsp = smb_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 912bd94257ec..3dafe8cc1bb1 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1704,13 +1704,4 @@ int smb2_ioctl(struct ksmbd_work *work);
 int smb2_oplock_break(struct ksmbd_work *work);
 int smb2_notify(struct ksmbd_work *ksmbd_work);
 
-/*
- * Get the body of the smb2 message excluding the 4 byte rfc1002 headers
- * from request/response buffer.
- */
-static inline void *smb2_get_msg(void *buf)
-{
-	return buf + 4;
-}
-
 #endif	/* _SMB2PDU_H */
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 0438a634f4c2..8a2b4db4a566 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -163,7 +163,7 @@ bool ksmbd_smb_request(struct ksmbd_conn *conn)
 	if (conn->request_buf[0] != 0)
 		return false;
 
-	proto = (__le32 *)smb2_get_msg(conn->request_buf);
+	proto = (__le32 *)smb_get_msg(conn->request_buf);
 	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
 		pr_err_ratelimited("smb2 compression not support yet");
 		return false;
@@ -259,14 +259,14 @@ int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count)
 static int ksmbd_negotiate_smb_dialect(void *buf)
 {
 	int smb_buf_length = get_rfc1002_len(buf);
-	__le32 proto = ((struct smb2_hdr *)smb2_get_msg(buf))->ProtocolId;
+	__le32 proto = ((struct smb2_hdr *)smb_get_msg(buf))->ProtocolId;
 
 	if (proto == SMB2_PROTO_NUMBER) {
 		struct smb2_negotiate_req *req;
 		int smb2_neg_size =
 			offsetof(struct smb2_negotiate_req, Dialects);
 
-		req = (struct smb2_negotiate_req *)smb2_get_msg(buf);
+		req = (struct smb2_negotiate_req *)smb_get_msg(buf);
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
@@ -585,23 +585,46 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
 	struct ksmbd_conn *conn = work->conn;
 	int ret;
 
-	conn->dialect =
-		ksmbd_negotiate_smb_dialect(work->request_buf);
-	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
-
 	if (command == SMB2_NEGOTIATE_HE) {
+		/*
+		 * An SMB2 NEGOTIATE is valid for a new connection, or after an
+		 * SMB1 multi-protocol negotiate has selected SMB2. Do not allow
+		 * a second SMB2 NEGOTIATE to replace connection-wide state
+		 * while a session setup is pending. KSMBD_SESS_NEED_RECONNECT
+		 * is a transient session state and does not restart transport
+		 * negotiation.
+		 */
+		ksmbd_conn_lock(conn);
+		if (!ksmbd_conn_new(conn) &&
+		    !ksmbd_conn_need_negotiate(conn)) {
+			work->send_no_response = 1;
+			ksmbd_conn_set_exiting(conn);
+			ksmbd_conn_unlock(conn);
+			return 0;
+		}
+
+		conn->dialect =
+			ksmbd_negotiate_smb_dialect(work->request_buf);
+		ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 		ret = smb2_handle_negotiate(work);
+		ksmbd_conn_unlock(conn);
 		return ret;
 	}
 
 	if (command == SMB_COM_NEGOTIATE) {
+		ksmbd_conn_lock(conn);
+		conn->dialect =
+			ksmbd_negotiate_smb_dialect(work->request_buf);
+		ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 		if (__smb2_negotiate(conn)) {
 			init_smb3_11_server(conn);
-			init_smb2_neg_rsp(work);
+			ret = init_smb2_neg_rsp(work);
 			ksmbd_debug(SMB, "Upgrade to SMB2 negotiation\n");
-			return 0;
+		} else {
+			ret = smb_handle_negotiate(work);
 		}
-		return smb_handle_negotiate(work);
+		ksmbd_conn_unlock(conn);
+		return ret;
 	}
 
 	pr_err("Unknown SMB negotiation command: %u\n", command);
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index c4978579c541..62b6367dc257 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -512,4 +512,13 @@ static inline void inc_rfc1001_len(void *buf, int count)
 {
 	be32_add_cpu((__be32 *)buf, count);
 }
+
+/*
+ * Get the body of the smb message excluding the 4 byte rfc1002 headers
+ * from request/response buffer.
+ */
+static inline void *smb_get_msg(void *buf)
+{
+	return buf + 4;
+}
 #endif /* __SMB_COMMON_H__ */
diff --git a/fs/namei.c b/fs/namei.c
index 5cc5b3e98462..6dec38e68ce3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2575,6 +2575,49 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 	return d;
 }
 
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @path: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
+{
+	struct filename *filename = getname_kernel(name);
+	struct path parent_path;
+	struct dentry *d;
+	struct qstr last;
+	int type, error;
+
+	error = filename_parentat(AT_FDCWD, filename, 0, &parent_path, &last, &type);
+	if (error) {
+		d = ERR_PTR(error);
+		goto out;
+	}
+	if (unlikely(type != LAST_NORM)) {
+		path_put(&parent_path);
+		d = ERR_PTR(-EINVAL);
+		goto out;
+	}
+
+	d = lookup_one_len_unlocked(last.name, parent_path.dentry, last.len);
+	if (IS_ERR(d)) {
+		path_put(&parent_path);
+		goto out;
+	}
+	*path = parent_path;
+out:
+	putname(filename);
+	return d;
+}
+
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 566dd9083b8f..ab9c75e092c2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -830,7 +830,7 @@ int ntfs_refresh_zone(struct ntfs_sb_info *sbi)
 /*
  * ntfs_update_mftmirr - Update $MFTMirr data.
  */
-int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
+void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 {
 	int err;
 	struct super_block *sb = sbi->sb;
@@ -839,12 +839,12 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 	u32 bytes;
 
 	if (!sb)
-		return -EINVAL;
+		return;
 
 	blocksize = sb->s_blocksize;
 
 	if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
-		return 0;
+		return;
 
 	err = 0;
 	bytes = sbi->mft.recs_mirr << sbi->record_bits;
@@ -855,16 +855,13 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 		struct buffer_head *bh1, *bh2;
 
 		bh1 = sb_bread(sb, block1++);
-		if (!bh1) {
-			err = -EIO;
-			goto out;
-		}
+		if (!bh1)
+			return;
 
 		bh2 = sb_getblk(sb, block2++);
 		if (!bh2) {
 			put_bh(bh1);
-			err = -EIO;
-			goto out;
+			return;
 		}
 
 		if (buffer_locked(bh2))
@@ -884,13 +881,10 @@ int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
 
 		put_bh(bh2);
 		if (err)
-			goto out;
+			return;
 	}
 
 	sbi->flags &= ~NTFS_FLAGS_MFTMIRR;
-
-out:
-	return err;
 }
 
 /*
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 14c1430b27ab..b3f57535fe0b 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1819,10 +1819,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	struct indx_node *n1 = fnd->nodes[level];
 	struct INDEX_HDR *hdr1 = &n1->index->ihdr;
 	struct INDEX_HDR *hdr2;
-	u32 to_copy, used;
+	u32 to_copy, used, used1;
 	CLST new_vbn;
 	__le64 t_vbn, *sub_vbn;
 	u16 sp_size;
+	void *hdr1_saved = NULL;
 
 	/* Try the most easy case. */
 	e = fnd->level - 1 == level ? fnd->de[level] : NULL;
@@ -1855,6 +1856,27 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return -ENOMEM;
 	memcpy(up_e, sp, sp_size);
 
+	used1 = le32_to_cpu(hdr1->used);
+
+	/*
+	 * hdr_find_split does not validate per-entry sizes, so a crafted
+	 * NTFS_DE whose le16 size field is out of range can place sp such
+	 * that (PtrOffset(hdr1, sp) + sp_size) exceeds used1. Without this
+	 * guard the u32 'used = used1 - to_copy - sp_size' underflows and
+	 * the subsequent memmove count becomes a near-4-GiB value,
+	 * triggering an out-of-bounds kernel write.
+	 */
+	if (PtrOffset(hdr1, sp) + sp_size > used1) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
+	if (!hdr1_saved) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (!hdr1->flags) {
 		up_e->flags |= NTFS_IE_HAS_SUBNODES;
 		up_e->size = cpu_to_le16(sp_size + sizeof(u64));
@@ -1887,7 +1909,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_insert_head(hdr2, de_t, to_copy);
 
 	/* Remove all entries (sp including) from hdr1. */
-	used = le32_to_cpu(hdr1->used) - to_copy - sp_size;
+	used = used1 - to_copy - sp_size;
 	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
 	hdr1->used = cpu_to_le32(used);
 
@@ -1917,8 +1939,6 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
-		if (err)
-			goto out;
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.
@@ -1926,12 +1946,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, up_e, ctx,
 					      level - 1, fnd);
-		if (err)
-			goto out;
+	}
+
+	if (err) {
+		/*
+		 * Undo critical operations.
+		 */
+		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		memcpy(hdr1, hdr1_saved, used1);
+		indx_write(indx, ni, n1, 0);
 	}
 
 out:
 	kfree(up_e);
+	kfree(hdr1_saved);
 
 	return err;
 }
@@ -1990,16 +2018,12 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 */
 		err = indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
 					    fnd, undo);
-		if (err)
-			goto out;
 	} else {
 		/*
 		 * Found a leaf buffer, so we'll insert the new entry into it.
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, new_de, ctx,
 					      fnd->level - 1, fnd);
-		if (err)
-			goto out;
 	}
 
 out:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d93cba03a65a..a03dce278221 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -599,7 +599,7 @@ int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
 void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST rno, bool is_mft);
 int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to);
 int ntfs_refresh_zone(struct ntfs_sb_info *sbi);
-int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
+void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
 enum NTFS_DIRTY_FLAGS {
 	NTFS_DIRTY_CLEAR = 0,
 	NTFS_DIRTY_DIRTY = 1,
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 5fc32483afed..4c7ef60dbaac 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -730,7 +730,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct ovl_cu_creds cc;
 	int err;
 
@@ -754,6 +754,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
+		if (!err) {
+			/*
+			 * Record the linked dentry -- not the disconnected
+			 * O_TMPFILE dentry -- so that ->d_revalidate() on
+			 * the upper fs sees the real parent/name.
+			 */
+			newdentry = dget(upper);
+		}
 		dput(upper);
 	}
 	inode_unlock(udir);
@@ -763,9 +771,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), temp);
-
-	return 0;
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out_dput:
 	dput(temp);
diff --git a/fs/super.c b/fs/super.c
index eeb8f745a8bf..b8638feee171 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1006,13 +1006,24 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
+	bool active = false;
+
 	down_write(&sb->s_umount);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
-		emergency_thaw_bdev(sb);
+	if (sb->s_root && sb->s_flags & SB_BORN)
+		active = atomic_inc_not_zero(&sb->s_active);
+	up_write(&sb->s_umount);
+	if (!active)
+		return;
+
+	/* thaw_bdev() acquires s_umount so it must not be held here */
+	emergency_thaw_bdev(sb);
+
+	down_write(&sb->s_umount);
+	if (sb->s_root && sb->s_flags & SB_BORN)
 		thaw_super_locked(sb);
-	} else {
+	else
 		up_write(&sb->s_umount);
-	}
+	deactivate_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 3175e3620a41..e95a6b2ecded 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -805,10 +805,10 @@ xfs_sb_read_verify(
 	 * because _verify_common checks the on-disk values.
 	 */
 	__xfs_sb_from_disk(&sb, dsb, false);
-	error = xfs_validate_sb_common(mp, bp, &sb);
+	error = xfs_validate_sb_read(mp, &sb);
 	if (error)
 		goto out_error;
-	error = xfs_validate_sb_read(mp, &sb);
+	error = xfs_validate_sb_common(mp, bp, &sb);
 
 out_error:
 	if (error == -EFSCORRUPTED || error == -EFSBADCRC)
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index e2ab008fe489..96b9cc3569dd 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -750,7 +750,7 @@ xfs_dq_get_next_id(
 	lock_flags = xfs_ilock_data_map_shared(quotip);
 	error = xfs_iread_extents(NULL, quotip, XFS_DATA_FORK);
 	if (error)
-		return error;
+		goto out_unlock;
 
 	if (xfs_iext_lookup_extent(quotip, &quotip->i_df, start, &cur, &got)) {
 		/* contiguous chunk, bump startoff for the id calculation */
@@ -761,6 +761,7 @@ xfs_dq_get_next_id(
 		error = -ENOENT;
 	}
 
+out_unlock:
 	xfs_iunlock(quotip, lock_flags);
 
 	return error;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 1f43d7c6724a..9551018b7975 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1728,13 +1728,13 @@ struct drm_tile_group {
 	struct kref refcount;
 	struct drm_device *dev;
 	int id;
-	u8 group_data[8];
+	u8 group_data[9];
 };
 
 struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
-						  const char topology[8]);
+						  const char topology_id[9]);
 struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
-					       const char topology[8]);
+					       const char topology_id[9]);
 void drm_mode_put_tile_group(struct drm_device *dev,
 			     struct drm_tile_group *tg);
 
diff --git a/include/drm/drm_displayid.h b/include/drm/drm_displayid.h
index ec64d141f578..51ab3fff1b51 100644
--- a/include/drm/drm_displayid.h
+++ b/include/drm/drm_displayid.h
@@ -75,7 +75,7 @@ struct displayid_tiled_block {
 	u8 topo[3];
 	u8 tile_size[4];
 	u8 tile_pixel_bezel[5];
-	u8 topology_id[8];
+	u8 topology_id[9];
 } __packed;
 
 struct displayid_detailed_timings_1 {
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4c64e054c746..9231e82753c4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -14,7 +14,7 @@
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
 
-#define AUDIT_INO_UNSET ((unsigned long)-1)
+#define AUDIT_INO_UNSET ((u64)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
 
 struct audit_sig_info {
@@ -120,17 +120,17 @@ enum audit_nfcfgop {
 
 extern int is_audit_feature_set(int which);
 
-extern int __init audit_register_class(int class, unsigned *list);
-extern int audit_classify_syscall(int abi, unsigned syscall);
+extern int __init audit_register_class(int class, unsigned int *list);
+extern int audit_classify_syscall(int abi, unsigned int syscall);
 extern int audit_classify_arch(int arch);
 /* only for compat system calls */
-extern unsigned compat_write_class[];
-extern unsigned compat_read_class[];
-extern unsigned compat_dir_class[];
-extern unsigned compat_chattr_class[];
-extern unsigned compat_signal_class[];
+extern unsigned int compat_write_class[];
+extern unsigned int compat_read_class[];
+extern unsigned int compat_dir_class[];
+extern unsigned int compat_chattr_class[];
+extern unsigned int compat_signal_class[];
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+extern int audit_classify_compat_syscall(int abi, unsigned int syscall);
 
 /* audit_names->type values */
 #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 5296fbb8408c..2105a94294ca 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -254,6 +254,9 @@ static inline struct xbc_node * __init xbc_node_get_subkey(struct xbc_node *node
 int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
+/* Render key/value pairs under @root as a flat cmdline string */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
  * @node: An XBC node.
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 479c101546ad..46fc668f2ef1 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -13,6 +13,8 @@
 
 #ifdef CONFIG_BPF_LSM
 
+extern bool bpf_lsm_initialized __ro_after_init;
+
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	RET bpf_lsm_##NAME(__VA_ARGS__);
 #include <linux/lsm_hook_defs.h>
@@ -44,6 +46,8 @@ void bpf_inode_storage_free(struct inode *inode);
 
 #else /* !CONFIG_BPF_LSM */
 
+#define bpf_lsm_initialized false
+
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
 {
 	return false;
diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index d5a5da838caf..11a92a946016 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -19,12 +19,25 @@
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
 		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
+#  define doutc(client, fmt, ...)					\
+	pr_debug("%.*s %12.12s:%-4d : [%pU %llu] " fmt,			\
+		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
+		 kbasename(__FILE__), __LINE__,				\
+		 &client->fsid, client->monc.auth->global_id,		\
+		 ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)	do {				\
 		if (0)						\
 			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
 	} while (0)
+#  define doutc(client, fmt, ...)	do {			\
+		if (0)						\
+			printk(KERN_DEBUG "[%pU %llu] " fmt,	\
+			&client->fsid,				\
+			client->monc.auth->global_id,		\
+			##__VA_ARGS__);				\
+		} while (0)
 # endif
 
 #else
@@ -33,7 +46,32 @@
  * or, just wrap pr_debug
  */
 # define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
+# define doutc(client, fmt, ...)					\
+	pr_debug(" [%pU %llu] %s: " fmt, &client->fsid,			\
+		 client->monc.auth->global_id, __func__, ##__VA_ARGS__)
 
 #endif
 
+#define pr_notice_client(client, fmt, ...)				\
+	pr_notice("[%pU %llu]: " fmt, &client->fsid,			\
+		  client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_info_client(client, fmt, ...)				\
+	pr_info("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_client(client, fmt, ...)				\
+	pr_warn("[%pU %llu]: " fmt, &client->fsid,			\
+		client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_once_client(client, fmt, ...)				\
+	pr_warn_once("[%pU %llu]: " fmt, &client->fsid,			\
+		     client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_client(client, fmt, ...)					\
+	pr_err("[%pU %llu]: " fmt, &client->fsid,			\
+	       client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_warn_ratelimited_client(client, fmt, ...)			\
+	pr_warn_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			    client->monc.auth->global_id, ##__VA_ARGS__)
+#define pr_err_ratelimited_client(client, fmt, ...)			\
+	pr_err_ratelimited("[%pU %llu]: " fmt, &client->fsid,		\
+			   client->monc.auth->global_id, ##__VA_ARGS__)
+
 #endif
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index ef9f94ce2cc3..8a9348c8b91a 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -364,7 +364,7 @@ static inline struct dma_resv_list *dma_resv_shared_list(struct dma_resv *obj)
 
 void dma_resv_init(struct dma_resv *obj);
 void dma_resv_fini(struct dma_resv *obj);
-int dma_resv_reserve_shared(struct dma_resv *obj, unsigned int num_fences);
+int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
 void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence);
 void dma_resv_add_excl_fence(struct dma_resv *obj, struct dma_fence *fence);
 int dma_resv_get_fences(struct dma_resv *obj, struct dma_fence **pfence_excl,
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index cab6e18773da..6f64e90d5c38 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -12,19 +12,63 @@
 #include <linux/device.h>
 #include <linux/dmaengine.h>
 
+#define EDMA_MAX_WR_CH                                  8
+#define EDMA_MAX_RD_CH                                  8
+
 struct dw_edma;
 
+struct dw_edma_region {
+	phys_addr_t	paddr;
+	void __iomem	*vaddr;
+	size_t		sz;
+};
+
+struct dw_edma_core_ops {
+	int (*irq_vector)(struct device *dev, unsigned int nr);
+};
+
+enum dw_edma_map_format {
+	EDMA_MF_EDMA_LEGACY = 0x0,
+	EDMA_MF_EDMA_UNROLL = 0x1,
+	EDMA_MF_HDMA_COMPAT = 0x5
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
  * @id:			 instance ID
- * @irq:		 irq line
- * @dw:			 struct dw_edma that is filed by dw_edma_probe()
+ * @nr_irqs:		 total number of DMA IRQs
+ * @ops			 DMA channel to IRQ number mapping
+ * @wr_ch_cnt		 DMA write channel number
+ * @rd_ch_cnt		 DMA read channel number
+ * @rg_region		 DMA register region
+ * @ll_region_wr	 DMA descriptor link list memory for write channel
+ * @ll_region_rd	 DMA descriptor link list memory for read channel
+ * @dt_region_wr	 DMA data memory for write channel
+ * @dt_region_rd	 DMA data memory for read channel
+ * @mf			 DMA register map format
+ * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
 	struct device		*dev;
 	int			id;
-	int			irq;
+	int			nr_irqs;
+	const struct dw_edma_core_ops   *ops;
+
+	struct dw_edma_region	rg_region;
+
+	u16			wr_ch_cnt;
+	u16			rd_ch_cnt;
+	/* link list address */
+	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
+
+	/* data region */
+	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
+	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
+
+	enum dw_edma_map_format	mf;
+
 	struct dw_edma		*dw;
 };
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 25109192cebe..679da6013dbb 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/gfp.h>
 
 #define FW_ACTION_NOUEVENT 0
@@ -118,4 +119,6 @@ static inline int request_partial_firmware_into_buf
 
 int firmware_request_cache(struct device *device, const char *name);
 
+DEFINE_FREE(firmware, struct firmware *, release_firmware(_T))
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 72a956d243c2..41b3ebe4e8e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -180,6 +180,12 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
 
+/*
+ * fsnotify pre-content events do not exist in this kernel, so a file is never
+ * watched by a pre-content event listener.
+ */
+#define FMODE_FSNOTIFY_HSM(mode)	0
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -2743,6 +2749,11 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 	return mnt_user_ns(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_user_ns(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
@@ -3132,6 +3143,28 @@ static inline void allow_write_access(struct file *file)
 	if (file)
 		atomic_inc(&file_inode(file)->i_writecount);
 }
+
+/*
+ * Do not prevent write to executable file when watched by pre-content events.
+ *
+ * Note that FMODE_FSNOTIFY_HSM mode is set depending on pre-content watches at
+ * the time of file open and remains constant for entire lifetime of the file,
+ * so if pre-content watches are added post execution or removed before the end
+ * of the execution, it will not cause i_writecount reference leak.
+ */
+static inline int exe_file_deny_write_access(struct file *exe_file)
+{
+	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return 0;
+	return deny_write_access(exe_file);
+}
+static inline void exe_file_allow_write_access(struct file *exe_file)
+{
+	if (unlikely(!exe_file || FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return;
+	allow_write_access(exe_file);
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/include/linux/ip.h b/include/linux/ip.h
index 3d9c6750af62..d11c25f5030a 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -35,4 +35,25 @@ static inline unsigned int ip_transport_len(const struct sk_buff *skb)
 {
 	return ntohs(ip_hdr(skb)->tot_len) - skb_network_header_len(skb);
 }
+
+static inline unsigned int iph_totlen(const struct sk_buff *skb, const struct iphdr *iph)
+{
+	u32 len = ntohs(iph->tot_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+	       len : skb->len - skb_network_offset(skb);
+}
+
+static inline unsigned int skb_ip_totlen(const struct sk_buff *skb)
+{
+	return iph_totlen(skb, ip_hdr(skb));
+}
+
+/* IPv4 datagram length is stored into 16bit field (tot_len) */
+#define IP_MAX_MTU	0xFFFFU
+
+static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
+{
+	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 3778e26f7b14..5af5e22e9a2a 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -371,6 +371,19 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ *
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function so it can be used in static initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 59024618554e..9ccfc8fbbe0b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1588,6 +1588,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index a85c9f0bd470..06eb9e1d724c 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -75,7 +75,7 @@
 #define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
 #define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752	0xaae8
+#define SDIO_DEVICE_ID_BROADCOM_43752		0xaae8
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 53c03d9ed34c..35e805c3be82 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -61,6 +61,7 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 019fecd75d0c..143995980a70 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -20,6 +20,7 @@
 struct pinctrl;
 struct pinctrl_state;
 struct device;
+struct gpio_chip;
 
 #ifdef CONFIG_PINCTRL
 
@@ -27,8 +28,10 @@ struct device;
 extern bool pinctrl_gpio_can_use_line(unsigned gpio);
 extern int pinctrl_gpio_request(unsigned gpio);
 extern void pinctrl_gpio_free(unsigned gpio);
-extern int pinctrl_gpio_direction_input(unsigned gpio);
-extern int pinctrl_gpio_direction_output(unsigned gpio);
+extern int pinctrl_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset);
+extern int pinctrl_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset);
 extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
@@ -77,12 +80,14 @@ static inline void pinctrl_gpio_free(unsigned gpio)
 {
 }
 
-static inline int pinctrl_gpio_direction_input(unsigned gpio)
+static inline int pinctrl_gpio_direction_input(struct gpio_chip *gc,
+					       unsigned int offset)
 {
 	return 0;
 }
 
-static inline int pinctrl_gpio_direction_output(unsigned gpio)
+static inline int pinctrl_gpio_direction_output(struct gpio_chip *gc,
+						unsigned int offset)
 {
 	return 0;
 }
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index 124e13cb1469..b44a36d18160 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -188,6 +188,8 @@ void tb_unregister_property_dir(const char *key, struct tb_property_dir *dir);
  * @link_speed: Speed of the link in Gb/s
  * @link_width: Width of the link (1 or 2)
  * @is_unplugged: The XDomain is unplugged
+ * @removing: Set by tb_xdomain_remove() under @lock to prevent
+ *	      concurrent delayed work queueing
  * @needs_uuid: If the XDomain does not have @remote_uuid it will be
  *		queried first
  * @service_ids: Used to generate IDs for the services
@@ -235,6 +237,7 @@ struct tb_xdomain {
 	unsigned int link_speed;
 	unsigned int link_width;
 	bool is_unplugged;
+	bool removing;
 	bool needs_uuid;
 	struct ida service_ids;
 	struct ida in_hopids;
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index fa4901162663..dd0d347be07b 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -283,7 +283,9 @@ void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier);
  *
  * @sd: pointer to &struct v4l2_subdev
  */
-int v4l2_async_register_subdev(struct v4l2_subdev *sd);
+#define v4l2_async_register_subdev(sd) \
+	__v4l2_async_register_subdev(sd, THIS_MODULE)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_register_subdev_sensor - registers a sensor sub-device to the
@@ -304,8 +306,10 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd);
  * An error is returned if the module is no longer loaded on any attempts
  * to register it.
  */
+#define v4l2_async_register_subdev_sensor(sd) \
+	__v4l2_async_register_subdev_sensor(sd, THIS_MODULE)
 int __must_check
-v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd);
+__v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_unregister_subdev - unregisters a sub-device to the asynchronous
diff --git a/include/net/dst.h b/include/net/dst.h
index 76a0afabb3c8..9a23986f1071 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -449,7 +449,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
 /* Output packet to network from transport.  */
 static inline int dst_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->output,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->output),
 				  ip6_output, ip_output,
 				  net, sk, skb);
 }
@@ -459,7 +459,7 @@ INDIRECT_CALLABLE_DECLARE(int ip_local_deliver(struct sk_buff *));
 /* Input packet from network to transport.  */
 static inline int dst_input(struct sk_buff *skb)
 {
-	return INDIRECT_CALL_INET(skb_dst(skb)->input,
+	return INDIRECT_CALL_INET(READ_ONCE(skb_dst(skb)->input),
 				  ip6_input, ip_local_deliver, skb);
 }
 
@@ -566,6 +566,26 @@ static inline struct net_device *skb_dst_dev_rcu(const struct sk_buff *skb)
 	return dst_dev_rcu(skb_dst(skb));
 }
 
+static inline struct net_device *dst_dev(const struct dst_entry *dst)
+{
+	return READ_ONCE(dst->dev);
+}
+
+static inline struct net_device *skb_dst_dev(const struct sk_buff *skb)
+{
+	return dst_dev(skb_dst(skb));
+}
+
+static inline struct net *skb_dst_dev_net(const struct sk_buff *skb)
+{
+	return dev_net(skb_dst_dev(skb));
+}
+
+static inline struct net *skb_dst_dev_net_rcu(const struct sk_buff *skb)
+{
+	return dev_net_rcu(skb_dst_dev(skb));
+}
+
 struct dst_entry *dst_blackhole_check(struct dst_entry *dst, u32 cookie);
 void dst_blackhole_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			       struct sk_buff *skb, u32 mtu, bool confirm_neigh);
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index f89320b6fee3..cd9f071d5658 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -106,7 +106,7 @@ static inline struct sock *__inet6_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet6_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet6_lookup(dev_net_rcu(skb_dst(skb)->dev), hashinfo, skb,
 			      doff, &ipv6_hdr(skb)->saddr, sport,
 			      &ipv6_hdr(skb)->daddr, ntohs(dport),
 			      iif, sdif, refcounted);
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5849f816402d..43317a06c86f 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -356,7 +356,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 	if (sk)
 		return sk;
 
-	return __inet_lookup(dev_net(skb_dst(skb)->dev), hashinfo, skb,
+	return __inet_lookup(skb_dst_dev_net_rcu(skb), hashinfo, skb,
 			     doff, iph->saddr, sport,
 			     iph->daddr, dport, inet_iif(skb), sdif,
 			     refcounted);
diff --git a/include/net/ip.h b/include/net/ip.h
index e1a93c339109..e25a2d5519c5 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -441,7 +441,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net(dst_dev(dst));
 	unsigned int mtu;
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
@@ -457,7 +457,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst->dev->mtu);
+	mtu = READ_ONCE(dst_dev(dst)->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
@@ -473,16 +473,17 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
+	const struct dst_entry *dst = skb_dst(skb);
 	unsigned int mtu;
 
 	if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
 		bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
 
-		return ip_dst_mtu_maybe_forward(skb_dst(skb), forwarding);
+		return ip_dst_mtu_maybe_forward(dst, forwarding);
 	}
 
-	mtu = min(READ_ONCE(skb_dst(skb)->dev->mtu), IP_MAX_MTU);
-	return mtu - lwtunnel_headroom(skb_dst(skb)->lwtstate, mtu);
+	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
 struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7ca06cf6e0f7..0d71e7c4c691 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -296,6 +296,9 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 		      struct ip_tunnel_parm *p, __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap);
+
 extern const struct header_ops ip_tunnel_header_ops;
 __be16 ip_tunnel_parse_protocol(const struct sk_buff *skb);
 
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 7d32968f2b13..2e3ef3980c01 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -33,6 +33,12 @@
 #define IP_VS_HDR_INVERSE	1
 #define IP_VS_HDR_ICMP		2
 
+/* Destination Server Flags */
+#define IP_VS_DEST_F_OVERLOAD	0x0002		/* server is overloaded */
+
+/* Destination Server Config Flags */
+#define IP_VS_DEST_CF_AVAILABLE	0x0001		/* server is available */
+
 /* Generic access of ipvs struct */
 static inline struct netns_ipvs *net_ipvs(struct net* net)
 {
@@ -664,6 +670,7 @@ struct ip_vs_dest {
 	volatile unsigned int	flags;		/* dest status flags */
 	atomic_t		conn_flags;	/* flags to copy to conn */
 	atomic_t		weight;		/* server weight */
+	unsigned long		cflags;		/* config flags */
 	atomic_t		last_weight;	/* server latest weight */
 	__u16			tun_type;	/* tunnel type */
 	__be16			tun_port;	/* tunnel port */
diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 53bd2d02a4f0..09791f5d9b6e 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -138,12 +138,12 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len,
 static inline void lwtunnel_set_redirect(struct dst_entry *dst)
 {
 	if (lwtunnel_output_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_output = dst->output;
-		dst->output = lwtunnel_output;
+		dst->lwtstate->orig_output = READ_ONCE(dst->output);
+		WRITE_ONCE(dst->output, lwtunnel_output);
 	}
 	if (lwtunnel_input_redirect(dst->lwtstate)) {
-		dst->lwtstate->orig_input = dst->input;
-		dst->input = lwtunnel_input;
+		dst->lwtstate->orig_input = READ_ONCE(dst->input);
+		WRITE_ONCE(dst->input, lwtunnel_input);
 	}
 }
 #else
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 9c25e7af2ce8..3e0b16674751 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -16,6 +16,7 @@ struct nf_queue_entry {
 	unsigned int		id;
 	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	struct net_device	*bridge_dev;
 	struct net_device	*physin;
 	struct net_device	*physout;
 #endif
diff --git a/include/net/route.h b/include/net/route.h
index 39be632a9822..61f1cbe5b43d 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -35,9 +35,6 @@
 #include <linux/cache.h>
 #include <linux/security.h>
 
-/* IPv4 datagram length is stored into 16bit field (tot_len) */
-#define IP_MAX_MTU	0xFFFFU
-
 #define RTO_ONLINK	0x01
 
 #define RT_CONN_FLAGS(sk)   (RT_TOS(inet_sk(sk)->tos) | sock_flag(sk, SOCK_LOCALROUTE))
@@ -358,7 +355,7 @@ static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 		const struct net *net;
 
 		rcu_read_lock();
-		net = dev_net_rcu(dst->dev);
+		net = dev_net_rcu(dst_dev(dst));
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
 		rcu_read_unlock();
 	}
diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
index 4102ddcb4e14..9e4a762f31d8 100644
--- a/include/uapi/linux/ip_vs.h
+++ b/include/uapi/linux/ip_vs.h
@@ -28,12 +28,6 @@
 #define IP_VS_SVC_F_SCHED_SH_FALLBACK	IP_VS_SVC_F_SCHED1 /* SH fallback */
 #define IP_VS_SVC_F_SCHED_SH_PORT	IP_VS_SVC_F_SCHED2 /* SH use port */
 
-/*
- *      Destination Server Flags
- */
-#define IP_VS_DEST_F_AVAILABLE	0x0001		/* server is available */
-#define IP_VS_DEST_F_OVERLOAD	0x0002		/* server is overloaded */
-
 /*
  *      IPVS sync daemon states
  */
diff --git a/init/main.c b/init/main.c
index 4e9c76a0e5a4..c86df2005204 100644
--- a/init/main.c
+++ b/init/main.c
@@ -319,45 +319,6 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
-
-#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
-
-static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
-{
-	struct xbc_node *knode, *vnode;
-	char *end = buf + size;
-	const char *val;
-	int ret;
-
-	xbc_node_for_each_key_value(root, knode, val) {
-		ret = xbc_node_compose_key_after(root, knode,
-					xbc_namebuf, XBC_KEYLEN_MAX);
-		if (ret < 0)
-			return ret;
-
-		vnode = xbc_node_get_child(knode);
-		if (!vnode) {
-			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-			continue;
-		}
-		xbc_array_for_each_value(vnode, val) {
-			ret = snprintf(buf, rest(buf, end), "%s=\"%s\" ",
-				       xbc_namebuf, val);
-			if (ret < 0)
-				return ret;
-			buf += ret;
-		}
-	}
-
-	return buf - (end - size);
-}
-#undef rest
-
 /* Make an extra command line under given key word */
 static char * __init xbc_make_cmdline(const char *key)
 {
diff --git a/kernel/audit.c b/kernel/audit.c
index 1339e7731004..df8e02b2801c 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1992,7 +1992,7 @@ static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index b2ef4c0d3ec0..8cfa4482e371 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -74,7 +74,7 @@ struct audit_names {
 	int			name_len;	/* number of chars to log */
 	bool			hidden;		/* don't log this record */
 
-	unsigned long		ino;
+	u64			ino;
 	dev_t			dev;
 	umode_t			mode;
 	kuid_t			uid;
@@ -212,15 +212,15 @@ extern int auditd_test_task(struct task_struct *task);
 #define AUDIT_INODE_BUCKETS	32
 extern struct list_head audit_inode_hash[AUDIT_INODE_BUCKETS];
 
-static inline int audit_hash_ino(u32 ino)
+static inline int audit_hash_ino(u64 ino)
 {
-	return (ino & (AUDIT_INODE_BUCKETS-1));
+	return ((u32)ino & (AUDIT_INODE_BUCKETS-1));
 }
 
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
@@ -245,8 +245,13 @@ extern int audit_del_rule(struct audit_entry *entry);
 extern void audit_free_rule_rcu(struct rcu_head *head);
 extern struct list_head audit_filter_list[];
 
-extern struct audit_entry *audit_dupe_rule(struct audit_krule *old);
+struct audit_watch_ctx {
+	struct inode *dir;
+	struct inode *child;
+};
 
+extern struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+					   struct audit_watch_ctx *ctx);
 extern void audit_log_d_path_exe(struct audit_buffer *ab,
 				 struct mm_struct *mm);
 
@@ -266,17 +271,18 @@ extern int audit_to_watch(struct audit_krule *krule, char *path, int len,
 extern int audit_add_watch(struct audit_krule *krule, struct list_head **list);
 extern void audit_remove_watch_rule(struct audit_krule *krule);
 extern char *audit_watch_path(struct audit_watch *watch);
-extern int audit_watch_compare(struct audit_watch *watch, unsigned long ino,
-			       dev_t dev);
+extern int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev);
 
 extern struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule,
-						    char *pathname, int len);
+						    char *pathname, int len,
+						    struct audit_watch_ctx *ctx);
 extern char *audit_mark_path(struct audit_fsnotify_mark *mark);
 extern void audit_remove_mark(struct audit_fsnotify_mark *audit_mark);
 extern void audit_remove_mark_rule(struct audit_krule *krule);
-extern int audit_mark_compare(struct audit_fsnotify_mark *mark,
-			      unsigned long ino, dev_t dev);
-extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old);
+extern int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino,
+			      dev_t dev);
+extern int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+			  struct audit_watch_ctx *ctx);
 extern int audit_exe_compare(struct task_struct *tsk,
 			     struct audit_fsnotify_mark *mark);
 
@@ -307,13 +313,13 @@ extern struct list_head *audit_killed_trees(void);
 #define audit_watch_path(w) ""
 #define audit_watch_compare(w, i, d) 0
 
-#define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
+#define audit_alloc_mark(k, p, l, c) (ERR_PTR(-EINVAL))
 #define audit_mark_path(m) ""
 #define audit_remove_mark(m) do { } while (0)
 #define audit_remove_mark_rule(k) do { } while (0)
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
-#define audit_dupe_exe(n, o) (-EINVAL)
+#define audit_dupe_exe(n, o, c) (-EINVAL)
 
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..e62066bf0b0a 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -25,7 +25,7 @@
  */
 struct audit_fsnotify_mark {
 	dev_t dev;		/* associated superblock device */
-	unsigned long ino;	/* associated inode number */
+	u64 ino;		/* associated inode number */
 	char *path;		/* insertion path */
 	struct fsnotify_mark mark; /* fsnotify mark on the inode */
 	struct audit_krule *rule;
@@ -57,7 +57,7 @@ char *audit_mark_path(struct audit_fsnotify_mark *mark)
 	return mark->path;
 }
 
-int audit_mark_compare(struct audit_fsnotify_mark *mark, unsigned long ino, dev_t dev)
+int audit_mark_compare(struct audit_fsnotify_mark *mark, u64 ino, dev_t dev)
 {
 	if (mark->ino == AUDIT_INO_UNSET)
 		return 0;
@@ -71,22 +71,30 @@ static void audit_update_mark(struct audit_fsnotify_mark *audit_mark,
 	audit_mark->ino = inode ? inode->i_ino : AUDIT_INO_UNSET;
 }
 
-struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname, int len)
+struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pathname,
+					     int len, struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
-	int ret;
+	struct inode *dir, *child;
+	int ret, allow_dups;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
-	if (IS_ERR(dentry))
-		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	if (!ctx) {
+		dentry = kern_path_parent(pathname, &path);
+		if (IS_ERR(dentry))
+			return ERR_CAST(dentry); /* returning an error */
+		dir = d_inode(path.dentry);
+		child = d_inode(dentry);
+		allow_dups = 0;
+	} else {
+		dir = ctx->dir;
+		child = ctx->child;
+		allow_dups = 1;
+	}
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -97,18 +105,21 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	fsnotify_init_mark(&audit_mark->mark, audit_fsnotify_group);
 	audit_mark->mark.mask = AUDIT_FS_EVENTS;
 	audit_mark->path = pathname;
-	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	audit_update_mark(audit_mark, child);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, dir, allow_dups);
+
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
 		audit_mark = ERR_PTR(ret);
 	}
 out:
-	dput(dentry);
-	path_put(&path);
+	if (!ctx) {
+		dput(dentry);
+		path_put(&path);
+	}
 	return audit_mark;
 }
 
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 18ab4575ae00..2c21b4b1d763 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[];
 };
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 5cf22fe30149..c449c2af1fa0 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -37,7 +37,7 @@ struct audit_watch {
 	refcount_t		count;	/* reference count */
 	dev_t			dev;	/* associated superblock device */
 	char			*path;	/* insertion path */
-	unsigned long		ino;	/* associated inode number */
+	u64			ino;	/* associated inode number */
 	struct audit_parent	*parent; /* associated parent */
 	struct list_head	wlist;	/* entry in parent->watches list */
 	struct list_head	rules;	/* anchor for krule->rlist */
@@ -125,7 +125,7 @@ char *audit_watch_path(struct audit_watch *watch)
 	return watch->path;
 }
 
-int audit_watch_compare(struct audit_watch *watch, unsigned long ino, dev_t dev)
+int audit_watch_compare(struct audit_watch *watch, u64 ino, dev_t dev)
 {
 	return (watch->ino != AUDIT_INO_UNSET) &&
 		(watch->ino == ino) &&
@@ -243,7 +243,8 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       unsigned long ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating,
+			       struct audit_watch_ctx *ctx)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
@@ -279,12 +280,12 @@ static void audit_update_watch(struct audit_parent *parent,
 			list_del(&oentry->rule.rlist);
 			list_del_rcu(&oentry->list);
 
-			nentry = audit_dupe_rule(&oentry->rule);
+			nentry = audit_dupe_rule(&oentry->rule, ctx);
 			if (IS_ERR(nentry)) {
 				list_del(&oentry->rule.list);
 				audit_panic("error updating watch, removing");
 			} else {
-				int h = audit_hash_ino((u32)ino);
+				int h = audit_hash_ino(ino);
 
 				/*
 				 * nentry->rule.watch == oentry->rule.watch so
@@ -346,15 +347,18 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
 /* Get path information necessary for adding watches. */
 static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
-	struct dentry *d = kern_path_locked(watch->path, parent);
+	struct dentry *d;
+
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
+
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
-	inode_unlock(d_backing_inode(parent->dentry));
+
 	dput(d);
 	return 0;
 }
@@ -435,7 +439,7 @@ int audit_add_watch(struct audit_krule *krule, struct list_head **list)
 
 	audit_add_to_parent(krule, parent);
 
-	h = audit_hash_ino((u32)watch->ino);
+	h = audit_hash_ino(watch->ino);
 	*list = &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
@@ -475,10 +479,17 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
 		return 0;
 
-	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0);
-	else if (mask & (FS_DELETE|FS_MOVED_FROM))
-		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1);
+	if (mask & (FS_CREATE|FS_MOVED_TO) && inode) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = inode };
+
+		audit_update_watch(parent, dname, inode->i_sb->s_dev, inode->i_ino, 0,
+				   &ctx);
+	} else if (mask & (FS_DELETE|FS_MOVED_FROM)) {
+		struct audit_watch_ctx ctx = { .dir = dir, .child = NULL };
+
+		audit_update_watch(parent, dname, AUDIT_DEV_UNSET, AUDIT_INO_UNSET, 1,
+				   &ctx);
+	}
 	else if (mask & (FS_DELETE_SELF|FS_UNMOUNT|FS_MOVE_SELF))
 		audit_remove_parent_watches(parent);
 
@@ -501,7 +512,8 @@ static int __init audit_watch_init(void)
 }
 device_initcall(audit_watch_init);
 
-int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
+int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old,
+		   struct audit_watch_ctx *ctx)
 {
 	struct audit_fsnotify_mark *audit_mark;
 	char *pathname;
@@ -510,7 +522,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 	if (!pathname)
 		return -ENOMEM;
 
-	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname));
+	audit_mark = audit_alloc_mark(new, pathname, strlen(pathname), ctx);
 	if (IS_ERR(audit_mark)) {
 		kfree(pathname);
 		return PTR_ERR(audit_mark);
@@ -523,7 +535,7 @@ int audit_dupe_exe(struct audit_krule *new, struct audit_krule *old)
 int audit_exe_compare(struct task_struct *tsk, struct audit_fsnotify_mark *mark)
 {
 	struct file *exe_file;
-	unsigned long ino;
+	u64 ino;
 	dev_t dev;
 
 	/* only do exe filtering if we are recording @current events/records */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index e8874951c194..9257117f8658 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -162,13 +162,13 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
 static __u32 *classes[AUDIT_SYSCALL_CLASSES];
 
-int __init audit_register_class(int class, unsigned *list)
+int __init audit_register_class(int class, unsigned int *list)
 {
 	__u32 *p = kcalloc(AUDIT_BITMASK_SIZE, sizeof(__u32), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	while (*list != ~0U) {
-		unsigned n = *list++;
+		unsigned int n = *list++;
 		if (n >= AUDIT_BITMASK_SIZE * 32 - AUDIT_SYSCALL_CLASSES) {
 			kfree(p);
 			return -EINVAL;
@@ -183,7 +183,7 @@ int __init audit_register_class(int class, unsigned *list)
 	return 0;
 }
 
-int audit_match_class(int class, unsigned syscall)
+int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
 		return 0;
@@ -234,7 +234,7 @@ static int audit_match_signal(struct audit_entry *entry)
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *rule)
 {
-	unsigned listnr;
+	unsigned int listnr;
 	struct audit_entry *entry;
 	int i, err;
 
@@ -582,7 +582,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 				err = PTR_ERR(str);
 				goto exit_free;
 			}
-			audit_mark = audit_alloc_mark(&entry->rule, str, f_val);
+			audit_mark = audit_alloc_mark(&entry->rule, str, f_val, NULL);
 			if (IS_ERR(audit_mark)) {
 				kfree(str);
 				err = PTR_ERR(audit_mark);
@@ -809,7 +809,8 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
  * rule with the new rule in the filterlist, then free the old rule.
  * The rlist element is undefined; list manipulations are handled apart from
  * the initial copy. */
-struct audit_entry *audit_dupe_rule(struct audit_krule *old)
+struct audit_entry *audit_dupe_rule(struct audit_krule *old,
+				    struct audit_watch_ctx *ctx)
 {
 	u32 fcount = old->field_count;
 	struct audit_entry *entry;
@@ -868,7 +869,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 				new->filterkey = fk;
 			break;
 		case AUDIT_EXE:
-			err = audit_dupe_exe(new, old);
+			err = audit_dupe_exe(new, old, ctx);
 			break;
 		}
 		if (err) {
@@ -1401,7 +1402,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	if (!security_audit_rule_known(r))
 		return 0;
 
-	nentry = audit_dupe_rule(r);
+	nentry = audit_dupe_rule(r, NULL);
 	if (entry->rule.exe)
 		audit_remove_mark(entry->rule.exe);
 	if (IS_ERR(nentry)) {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2107b02c56ff..d351e9b71ced 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -159,7 +159,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
-	unsigned n;
+	unsigned int n;
 
 	if (unlikely(!ctx))
 		return 0;
@@ -840,7 +840,7 @@ static void audit_filter_syscall(struct task_struct *tsk,
 static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_names *n,
 				   struct audit_context *ctx) {
-	int h = audit_hash_ino((u32)n->ino);
+	int h = audit_hash_ino(n->ino);
 	struct list_head *list = &audit_inode_hash[h];
 	struct audit_entry *e;
 	enum audit_state state;
@@ -1443,7 +1443,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		audit_log_format(ab, " name=(null)");
 
 	if (n->ino != AUDIT_INO_UNSET)
-		audit_log_format(ab, " inode=%lu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
+		audit_log_format(ab, " inode=%llu dev=%02x:%02x mode=%#ho ouid=%u ogid=%u rdev=%02x:%02x",
 				 n->ino,
 				 MAJOR(n->dev),
 				 MINOR(n->dev),
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 96ceed0e0fb5..ab35f1b66008 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -223,6 +223,16 @@ static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
 
+	/*
+	 * Do not allow allocation of BPF_MAP_TYPE_INODE_STORAGE if the BPF LSM
+	 * was not initialized by the LSM framework at boot. Without proper
+	 * initialization, the BPF inode security blob offset remains unprepared,
+	 * causing bpf_inode() to calculate an invalid memory offset and corrupt
+	 * inode->i_security.
+	 */
+	if (!bpf_lsm_initialized)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	smap = bpf_local_storage_map_alloc(attr);
 	if (IS_ERR(smap))
 		return ERR_CAST(smap);
diff --git a/kernel/fork.c b/kernel/fork.c
index f55be5303dc7..70696b49c104 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -487,8 +487,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -983,6 +983,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_BPF_SYSCALL
+	RCU_INIT_POINTER(tsk->bpf_storage, NULL);
+	tsk->bpf_ctx = NULL;
+#endif
 	return tsk;
 
 free_stack:
@@ -1196,13 +1201,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		 * We expect the caller (i.e., sys_execve) to already denied
 		 * write access, so this is unlikely to fail.
 		 */
-		if (unlikely(deny_write_access(new_exe_file)))
+		if (unlikely(exe_file_deny_write_access(new_exe_file)))
 			return -EACCES;
 		get_file(new_exe_file);
 	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
@@ -1241,7 +1246,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	}
 
 	/* set the new file, lockless */
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1253,7 +1258,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		 * write access while someone might open the file writable.
 		 */
 		mmap_read_lock(mm);
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 		mmap_read_unlock(mm);
 	}
@@ -2252,10 +2257,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
-#ifdef CONFIG_BPF_SYSCALL
-	RCU_INIT_POINTER(p->bpf_storage, NULL);
-	p->bpf_ctx = NULL;
-#endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index d2912e44d61f..845ddeabbcf4 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -66,10 +66,27 @@ void __sched rt_spin_unlock(spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 
 	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
 		rt_mutex_slowunlock(&lock->lock);
+
+	/*
+	 * This must be last to prevent the following UAF:
+	 *
+	 * T1					T2
+	 * spin_lock(&p->lock);			rcu_read_lock();
+	 * invalidate(p);			p = rcu_dereference(ptr);
+	 * rcu_assign_pointer(ptr, NULL);	if (!p) return;
+	 * spin_unlock(&p->lock);		spin_lock(&p->lock);
+	 * kfree_rcu(p);			rcu_read_unlock();
+	 *					....
+	 *					spin_unlock(&p->lock)
+	 *					  rcu_read_unlock(); // Ends grace period
+	 * rcu_do_batch()
+	 *   kfree(p);
+	 *			    UAF ->	  rt_mutex_cmpxchg_release(&p->lock.lock...)
+	 */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_spin_unlock);
 
@@ -232,17 +249,21 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
-	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
 void __sched rt_write_unlock(rwlock_t *rwlock)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
-	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
+
+	/* This must be last. See comment in rt_spin_unlock() */
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(rt_write_unlock);
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index fa88bf6ccce0..a7bac5fe2994 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -972,6 +972,12 @@ void psi_cgroup_free(struct cgroup *cgroup)
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
+	/*
+	 * A psi_schedule_poll_work() call racing the last trigger's
+	 * destruction may have re-armed the timer after psi_trigger_destroy()
+	 * deleted it. Spurious firing while the group is alive is harmless.
+	 */
+	timer_shutdown_sync(&cgroup->psi.poll_timer);
 	free_percpu(cgroup->psi.pcpu);
 	/* All triggers must be removed by now */
 	WARN_ONCE(cgroup->psi.poll_states, "psi: trigger leak\n");
diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index e1cc9386e228..fd7dd09e44e9 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -188,13 +188,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
 	return 0;
 }
 
+static void tgid_stats_add_task(struct taskstats *stats,
+				struct task_struct *tsk, u64 now_ns)
+{
+	u64 delta, utime, stime;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumulate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(stats, tsk);
+	 */
+	delayacct_add_tsk(stats, tsk);
+
+	/* calculate task elapsed time in nsec */
+	delta = now_ns - tsk->start_time;
+	/* Convert to micro seconds */
+	do_div(delta, NSEC_PER_USEC);
+	stats->ac_etime += delta;
+
+	task_cputime(tsk, &utime, &stime);
+	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
+	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
+
+	stats->nvcsw += tsk->nvcsw;
+	stats->nivcsw += tsk->nivcsw;
+}
+
 static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
 	unsigned long flags;
 	int rc = -ESRCH;
-	u64 delta, utime, stime;
-	u64 start_time;
+	u64 now_ns;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -211,32 +237,13 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	tsk = first;
-	start_time = ktime_get_ns();
-	do {
+	now_ns = ktime_get_ns();
+	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
-		/*
-		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
-		 *
-		 *	per-task-foo(stats, tsk);
-		 */
-		delayacct_add_tsk(stats, tsk);
-
-		/* calculate task elapsed time in nsec */
-		delta = start_time - tsk->start_time;
-		/* Convert to micro seconds */
-		do_div(delta, NSEC_PER_USEC);
-		stats->ac_etime += delta;
 
-		task_cputime(tsk, &utime, &stime);
-		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
-		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
-
-		stats->nvcsw += tsk->nvcsw;
-		stats->nivcsw += tsk->nivcsw;
-	} while_each_thread(first, tsk);
+		tgid_stats_add_task(stats, tsk, now_ns);
+	}
 
 	unlock_task_sighand(first, &flags);
 	rc = 0;
@@ -254,18 +261,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	u64 now_ns;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
-	/*
-	 * Each accounting subsystem calls its functions here to
-	 * accumalate its per-task stats for tsk, into the per-tgid structure
-	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
-	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	now_ns = ktime_get_ns();
+	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e86064b14259..0e5d6264735c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1042,6 +1042,12 @@ struct ftrace_ops global_ops = {
 					  FTRACE_OPS_FL_PID,
 };
 
+/*
+ * parser_lock - Protects trace_parser state against concurrent operations.
+ * Held across trace_get_user() and subsequent buffer parsing to prevent races.
+ */
+static DEFINE_MUTEX(parser_lock);
+
 /*
  * Used by the stack unwinder to know about dynamic ftrace trampolines.
  */
@@ -4928,6 +4934,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -4941,6 +4949,7 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 
 	ret = read;
  out:
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
@@ -5675,12 +5684,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		iter = file->private_data;
 
 	parser = &iter->parser;
+	mutex_lock(&parser_lock);
 	if (trace_parser_loaded(parser)) {
 		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
 
 		ftrace_process_regex(iter, parser->buffer,
 				     parser->idx, enable);
 	}
+	mutex_unlock(&parser_lock);
 
 	trace_parser_put(parser);
 
@@ -5998,10 +6009,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -6121,6 +6134,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6134,6 +6148,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 	if (!ret)
 		ret = read;
 
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
@@ -6838,7 +6853,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
@@ -6850,6 +6866,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 
 	INIT_LIST_HEAD(&clear_hash);
 
+	if (start_ptr >= end_ptr)
+		return;
+
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a1c30bca23ac..84f3b0d0bc88 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5415,32 +5415,30 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 {
 	struct ring_buffer_per_cpu *cpu_buffer_a;
 	struct ring_buffer_per_cpu *cpu_buffer_b;
-	int ret = -EINVAL;
+	int ret = -EBUSY;
 
 	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
 	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
-		goto out;
+		return -EINVAL;
 
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
-		goto out;
-
-	ret = -EAGAIN;
+		return -EINVAL;
 
 	if (atomic_read(&buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	/*
 	 * We can't do a synchronize_rcu here because this
@@ -5451,10 +5449,10 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	atomic_inc(&cpu_buffer_a->record_disabled);
 	atomic_inc(&cpu_buffer_b->record_disabled);
 
-	ret = -EBUSY;
-	if (local_read(&cpu_buffer_a->committing))
+	/* Do not swap if either buffer is in the process of writing */
+	if (cpu_buffer_a->current_context)
 		goto out_dec;
-	if (local_read(&cpu_buffer_b->committing))
+	if (cpu_buffer_b->current_context)
 		goto out_dec;
 
 	/*
@@ -5477,7 +5475,6 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 out_dec:
 	atomic_dec(&cpu_buffer_a->record_disabled);
 	atomic_dec(&cpu_buffer_b->record_disabled);
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 9873c6372adc..ac878b861c0b 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -339,6 +339,71 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 		return "";	/* No value key */
 }
 
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/**
+ * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
+ * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
+ * @size: Size of @buf in bytes
+ * @root: Subtree root whose key=value pairs should be rendered
+ *
+ * Walk all key/value pairs under @root and emit them as a space-separated
+ * cmdline string into @buf. Values containing whitespace are quoted with
+ * double quotes. Returns the number of bytes that would be written if @buf
+ * were large enough (matching snprintf semantics), or a negative errno on
+ * failure.
+ */
+int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	const char *val, *q;
+	size_t len = 0;
+	int ret;
+
+	/*
+	 * Track the running written length rather than advancing @buf, so we
+	 * never form "buf + size" or "buf += ret" while @buf is NULL (the
+	 * size-probe call passes buf=NULL, size=0). NULL pointer arithmetic
+	 * is undefined behavior and trips host UBSan / FORTIFY_SOURCE when
+	 * this renderer runs at kernel build time. snprintf(NULL, 0, ...)
+	 * itself is well defined and returns the would-be length.
+	 */
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		if (!vnode) {
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s ", xbc_namebuf);
+			if (ret < 0)
+				return ret;
+			len += ret;
+			continue;
+		}
+		xbc_array_for_each_value(vnode, val) {
+			/*
+			 * For prettier and more readable /proc/cmdline, only
+			 * quote the value when necessary, i.e. when it contains
+			 * whitespace.
+			 */
+			q = strpbrk(val, " \t\r\n") ? "\"" : "";
+			ret = snprintf(buf ? buf + len : NULL, rest(len, size),
+				       "%s=%s%s%s ", xbc_namebuf, q, val, q);
+			if (ret < 0)
+				return ret;
+			len += ret;
+		}
+	}
+
+	return len;
+}
+#undef rest
+
 /* XBC parse and tree build */
 
 static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 77eabad69b4a..fb4e86dc664c 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -3,32 +3,32 @@
 #include <linux/types.h>
 #include <asm/unistd32.h>
 
-unsigned compat_dir_class[] = {
+unsigned int compat_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-unsigned compat_read_class[] = {
+unsigned int compat_read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-unsigned compat_write_class[] = {
+unsigned int compat_write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-unsigned compat_chattr_class[] = {
+unsigned int compat_chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-unsigned compat_signal_class[] = {
+unsigned int compat_signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
 
-int audit_classify_compat_syscall(int abi, unsigned syscall)
+int audit_classify_compat_syscall(int abi, unsigned int syscall)
 {
 	switch (syscall) {
 #ifdef __NR_open
diff --git a/mm/madvise.c b/mm/madvise.c
index ef9382f77624..367220e1fe52 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -544,8 +544,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2d8e9fb4ce0b..bf0bc71510f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1190,7 +1190,7 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 			alloc_percpu(struct per_cpu_nodestat);
 		arch_refresh_nodedata(nid, pgdat);
 	} else {
-		int cpu;
+		int cpu, i;
 		/*
 		 * Reset the nr_zones, order and highest_zoneidx before reuse.
 		 * Note that kswapd will init kswapd_highest_zoneidx properly
@@ -1199,10 +1199,17 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
 		pgdat->nr_zones = 0;
 		pgdat->kswapd_order = 0;
 		pgdat->kswapd_highest_zoneidx = 0;
-		for_each_online_cpu(cpu) {
-			struct per_cpu_nodestat *p;
+		/*
+		 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
+		 * offline nodes) - reconcile this at online. Foreign access to counters
+		 * is safe: the node is not online yet and we hold the hotplug lock.
+		 */
+		for_each_possible_cpu(cpu) {
+			struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
 
-			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				if (p->vm_node_stat_diff[i])
+					node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
 			memset(p, 0, sizeof(*p));
 		}
 	}
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..889d84477a77 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -166,8 +166,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&init_user_ns,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 8ebde6aed6fc..51708eff11ef 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -505,6 +505,14 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 		return -EINVAL;
 
 	mmap_assert_write_locked(walk.mm);
+	/*
+	 * x86, arm64 ptdump allow walks of efi mm's and x86 ptdump allows walks
+	 * of arbitrary mm's.
+	 *
+	 * However, they both must also hold the init_mm lock to account for
+	 * concurrent kernel page table freeing.
+	 */
+	mmap_assert_write_locked(&init_mm);
 
 	return walk_pgd_range(start, end, &walk);
 }
diff --git a/mm/ptdump.c b/mm/ptdump.c
index f07a3d9c2dae..7dd5fc3740e9 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -146,11 +146,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 
 	get_online_mems();
 	mmap_write_lock(mm);
+	/* To stabilise kernel page tables we must hold the init_mm lock too. */
+	if (mm != &init_mm)
+		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
+
 	while (range->start != range->end) {
 		walk_page_range_novma(mm, range->start, range->end,
 				      &ptdump_ops, pgd, st);
 		range++;
 	}
+
+	if (mm != &init_mm)
+		mmap_write_unlock(&init_mm);
 	mmap_write_unlock(mm);
 	put_online_mems();
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7ce4ae5a6ba1..c92d780a77a6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 66136a4c1ce7..a9655678be6f 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name,
+			      sizeof(locker->id.name), bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	/* skip expiration */
+	ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), bad);
 
 	ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
 	if (ret)
 		return ret;
 
-	len = ceph_decode_32(p);
-	*p += len; /* skip description */
+	/* skip description */
+	ceph_decode_skip_string(p, end, bad);
 
 	dout("%s %s%llu cookie %s addr %s\n", __func__,
 	     ENTITY_NAME(locker->id.name), locker->id.cookie,
 	     ceph_pr_addr(&locker->info.addr));
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 static int decode_lockers(void **p, void *end, u8 *type, char **tag,
@@ -299,7 +304,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	if (ret)
 		return ret;
 
-	*num_lockers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_lockers, err_inval);
 	*lockers = kcalloc(*num_lockers, sizeof(**lockers), GFP_NOIO);
 	if (!*lockers)
 		return -ENOMEM;
@@ -310,7 +315,8 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ret = -EINVAL;
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
@@ -320,6 +326,9 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 	*tag = s;
 	return 0;
 
+err_inval:
+	return -EINVAL;
+
 err_free_lockers:
 	ceph_free_lockers(*lockers, *num_lockers);
 	return ret;
diff --git a/net/ceph/decode.c b/net/ceph/decode.c
index bc109a1a4616..2f21af38cd9a 100644
--- a/net/ceph/decode.c
+++ b/net/ceph/decode.c
@@ -87,8 +87,9 @@ ceph_decode_entity_addr(void **p, void *end, struct ceph_entity_addr *addr)
 EXPORT_SYMBOL(ceph_decode_entity_addr);
 
 /*
- * Return addr of desired type (MSGR2 or LEGACY) or error.
- * Make sure there is only one match.
+ * Return addr of desired type (MSGR2 or LEGACY) or error.  In case of
+ * multiple matches, use the first one for compatibility with userspace
+ * messenger.
  *
  * Assume encoding with MSG_ADDR2.
  */
@@ -121,14 +122,13 @@ int ceph_decode_entity_addrvec(void **p, void *end, bool msgr2,
 
 		dout("%s i %d addr %s\n", __func__, i, ceph_pr_addr(&tmp_addr));
 		if (tmp_addr.type == my_type) {
-			if (found) {
-				pr_err("another match of type %d in addrvec\n",
-				       le32_to_cpu(my_type));
-				return -EINVAL;
+			if (!found) {
+				memcpy(addr, &tmp_addr, sizeof(*addr));
+				found = true;
+			} else {
+				dout("%s skipping extra match of type %d in addrvec\n",
+				     __func__, le32_to_cpu(my_type));
 			}
-
-			memcpy(addr, &tmp_addr, sizeof(*addr));
-			found = true;
 		}
 	}
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 905168706d5c..bb8a0b973edc 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1424,7 +1424,7 @@ static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len == 0 && incremental)
 		return NULL;	/* new_pg_temp: [] to remove */
-	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
@@ -1607,7 +1607,7 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 	u32 len, i;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if (len > CEPH_PG_MAX_SIZE)
 		return ERR_PTR(-EINVAL);
 
 	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
@@ -2791,9 +2791,10 @@ static void get_temp_osds(struct ceph_osdmap *osdmap,
 		}
 	}
 
-	/* primary_temp? */
+	/* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
 	pg = lookup_pg_mapping(&osdmap->primary_temp, pgid);
-	if (pg)
+	if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
+						 pg->primary_temp.osd)))
 		temp->primary = pg->primary_temp.osd;
 }
 
diff --git a/net/core/dst.c b/net/core/dst.c
index 6d74b4663085..8707b7ffe421 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -149,9 +149,9 @@ void dst_dev_put(struct dst_entry *dst)
 	dst->obsolete = DST_OBSOLETE_DEAD;
 	if (dst->ops->ifdown)
 		dst->ops->ifdown(dst, dev, true);
-	dst->input = dst_discard;
-	dst->output = dst_discard_out;
-	dst->dev = blackhole_netdev;
+	WRITE_ONCE(dst->input, dst_discard);
+	WRITE_ONCE(dst->output, dst_discard_out);
+	WRITE_ONCE(dst->dev, blackhole_netdev);
 	dev_hold(dst->dev);
 	dev_put(dev);
 }
@@ -272,7 +272,7 @@ unsigned int dst_blackhole_mtu(const struct dst_entry *dst)
 {
 	unsigned int mtu = dst_metric_raw(dst, RTAX_MTU);
 
-	return mtu ? : dst->dev->mtu;
+	return mtu ? : dst_dev(dst)->mtu;
 }
 EXPORT_SYMBOL_GPL(dst_blackhole_mtu);
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 2b7b1de70cf4..219221120c1c 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -284,7 +284,8 @@ struct pktgen_dev {
 	int pkt_overhead;	/* overhead for MPLS, VLANs, IPSEC etc */
 	int nfrags;
 	int removal_mark;	/* non-zero => the device is marked for
-				 * removal by worker thread */
+				 * removal by worker thread
+				 */
 
 	struct page *page;
 	u64 delay;		/* nano-seconds */
@@ -347,10 +348,12 @@ struct pktgen_dev {
 	__u16 udp_dst_max;	/* exclusive, dest UDP port */
 
 	/* DSCP + ECN */
-	__u8 tos;            /* six MSB of (former) IPv4 TOS
-				are for dscp codepoint */
-	__u8 traffic_class;  /* ditto for the (former) Traffic Class in IPv6
-				(see RFC 3260, sec. 4) */
+	__u8 tos;		/* six MSB of (former) IPv4 TOS
+				 * are for dscp codepoint
+				 */
+	__u8 traffic_class;	/* ditto for the (former) Traffic Class in IPv6
+				 * (see RFC 3260, sec. 4)
+				 */
 
 	/* IMIX */
 	unsigned int n_imix_entries;
@@ -390,12 +393,12 @@ struct pktgen_dev {
 
 	__u8 hh[14];
 	/* = {
-	   0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
-
-	   We fill in SRC address later
-	   0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	   0x08, 0x00
-	   };
+	 * 0x00, 0x80, 0xC8, 0x79, 0xB3, 0xCB,
+	 *
+	 * We fill in SRC address later
+	 * 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	 * 0x08, 0x00
+	 * };
 	 */
 	__u16 pad;		/* pad out the hh struct to an even 16 bytes */
 
@@ -458,7 +461,8 @@ struct pktgen_thread {
 	char result[512];
 
 	/* Field for thread to receive "posted" events terminate,
-	   stop ifs etc. */
+	 * stop ifs etc.
+	 */
 
 	u32 control;
 	int cpu;
@@ -2341,7 +2345,7 @@ static inline int f_pick(struct pktgen_dev *pkt_dev)
 #ifdef CONFIG_XFRM
 /* If there was already an IPSEC SA, we keep it as is, else
  * we go look for it ...
-*/
+ */
 #define DUMMY_MARK 0
 static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 {
@@ -2646,7 +2650,8 @@ static int pktgen_output_ipsec(struct sk_buff *skb, struct pktgen_dev *pkt_dev)
 	if (!x)
 		return 0;
 	/* XXX: we dont support tunnel mode for now until
-	 * we resolve the dst issue */
+	 * we resolve the dst issue
+	 */
 	if ((x->props.mode != XFRM_MODE_TRANSPORT) && (pkt_dev->spi == 0))
 		return 0;
 
@@ -3711,7 +3716,8 @@ static int add_dev_to_thread(struct pktgen_thread *t,
 	 * userspace on another CPU than the kthread.  The if_lock()
 	 * is used here to sync with concurrent instances of
 	 * _rem_dev_from_if_list() invoked via kthread, which is also
-	 * updating the if_list */
+	 * updating the if_list
+	 */
 	if_lock(t);
 
 	if (pkt_dev->pg_thread) {
@@ -3881,6 +3887,7 @@ static void _rem_dev_from_if_list(struct pktgen_thread *t,
 	struct pktgen_dev *p;
 
 	if_lock(t);
+	proc_remove(pkt_dev->entry);
 	list_for_each_safe(q, n, &t->if_list) {
 		p = list_entry(q, struct pktgen_dev, list);
 		if (p == pkt_dev)
@@ -3908,10 +3915,8 @@ static int pktgen_remove_device(struct pktgen_thread *t,
 
 	/* Remove proc before if_list entry, because add_device uses
 	 * list to determine if interface already exist, avoid race
-	 * with proc_create_data() */
-	proc_remove(pkt_dev->entry);
-
-	/* And update the thread if_list */
+	 * with proc_create_data()
+	 */
 	_rem_dev_from_if_list(t, pkt_dev);
 
 #ifdef CONFIG_XFRM
diff --git a/net/core/sock.c b/net/core/sock.c
index e5f8916aa85b..672a2d4b705a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2192,7 +2192,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk->sk_route_caps = dst->dev->features | sk->sk_route_forced_caps;
+	sk->sk_route_caps = dst_dev(dst)->features | sk->sk_route_forced_caps;
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
 	sk->sk_route_caps &= ~sk->sk_route_nocaps;
@@ -2201,8 +2201,8 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 			sk->sk_route_caps &= ~NETIF_F_GSO_MASK;
 		} else {
 			sk->sk_route_caps |= NETIF_F_SG | NETIF_F_HW_CSUM;
-			sk->sk_gso_max_size = dst->dev->gso_max_size;
-			max_segs = max_t(u32, dst->dev->gso_max_segs, 1);
+			sk->sk_gso_max_size = dst_dev(dst)->gso_max_size;
+			max_segs = max_t(u32, dst_dev(dst)->gso_max_segs, 1);
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 9c363f44a694..49c94aebac32 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -318,6 +318,7 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 {
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
+	struct net_device *dev;
 	bool rc = true;
 	int vif;
 
@@ -325,10 +326,11 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		goto out;
 
 	/* No rate limit on loopback */
-	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
+	dev = dst_dev(dst);
+	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dst->dev);
+	vif = l3mdev_master_ifindex(dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif, 1);
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
@@ -474,13 +476,13 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
  */
 static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 {
-	struct net_device *route_lookup_dev = NULL;
+	struct net_device *dev = skb->dev;
+	const struct dst_entry *dst;
 
-	if (skb->dev)
-		route_lookup_dev = skb->dev;
-	else if (skb_dst(skb))
-		route_lookup_dev = skb_dst(skb)->dev;
-	return route_lookup_dev;
+	if (dev)
+		return dev;
+	dst = skb_dst(skb);
+	return dst ? dst_dev(dst) : NULL;
 }
 
 static struct rtable *icmp_route_lookup(struct net *net,
@@ -882,7 +884,7 @@ static bool icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = skb_dst_dev_net(skb);
 
 	/*
 	 *	Incomplete header ?
@@ -1023,7 +1025,7 @@ static bool icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net(skb_dst(skb)->dev);
+	net = skb_dst_dev_net(skb);
 	/* should there be an ICMP stat for ignored echos? */
 	if (net->ipv4.sysctl_icmp_echo_ignore_all)
 		return true;
@@ -1200,7 +1202,7 @@ static bool icmp_timestamp(struct sk_buff *skb)
 	return true;
 
 out_err:
-	__ICMP_INC_STATS(dev_net(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(skb_dst_dev_net(skb), ICMP_MIB_INERRORS);
 	return false;
 }
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d25c5ef46e41..f47f3972f981 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -424,7 +424,7 @@ static int igmpv3_sendpack(struct sk_buff *skb)
 
 	pig->csum = ip_compute_csum(igmp_hdr(skb), igmplen);
 
-	return ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
+	return ip_local_out(skb_dst_dev_net(skb), skb->sk, skb);
 }
 
 static int grec_size(struct ip_mc_list *pmc, int type, int gdel, int sdel)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index ec2264adf2a6..23312d028af2 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -475,7 +475,7 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
+	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
 	int vif = l3mdev_master_ifindex_rcu(dev);
 	struct ipq *qp;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5d8f8a5901bc..1d353f3c4403 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -113,7 +113,7 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IP);
 
 	return nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst(skb)->dev,
+		       net, sk, skb, NULL, skb_dst_dev(skb),
 		       dst_output);
 }
 
@@ -195,7 +195,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rtable *rt = (struct rtable *)dst;
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
 	bool is_v6gw = false;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f535b875a02b..3b91b943e9a9 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -1091,3 +1091,38 @@ EXPORT_SYMBOL(ip_tunnel_parse_protocol);
 
 const struct header_ops ip_tunnel_header_ops = { .parse_protocol = ip_tunnel_parse_protocol };
 EXPORT_SYMBOL(ip_tunnel_header_ops);
+
+/* This function returns true when ENCAP attributes are present in the nl msg */
+bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
+				   struct ip_tunnel_encap *encap)
+{
+	bool ret = false;
+
+	memset(encap, 0, sizeof(*encap));
+
+	if (!data)
+		return ret;
+
+	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
+		ret = true;
+		encap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
+		ret = true;
+		encap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
+		ret = true;
+		encap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
+	}
+
+	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
+		ret = true;
+		encap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ip_tunnel_netlink_encap_parms);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 7487ceeda6e9..b1d4d59026cd 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -226,7 +226,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error_icmp;
 	}
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		dst_release(dst);
@@ -256,7 +256,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 xmit:
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 
 	err = dst_output(tunnel->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0)
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3aa78ccbec3e..d22d8e5f4abc 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -448,40 +448,6 @@ static void ipip_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip_netlink_encap_parms(struct nlattr *data[],
-				     struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ipip_newlink(struct net *src_net, struct net_device *dev,
 			struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
@@ -491,7 +457,7 @@ static int ipip_newlink(struct net *src_net, struct net_device *dev,
 	struct ip_tunnel_encap ipencap;
 	__u32 fwmark = 0;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
@@ -512,7 +478,10 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
-	if (ipip_netlink_encap_parms(data, &ipencap)) {
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index aff707988e23..4d8ccc55ccc0 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -19,12 +19,12 @@
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
 int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, unsigned int addr_type)
 {
+	struct net_device *dev = skb_dst_dev(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	struct flowi4 fl4 = {};
 	__be32 saddr = iph->saddr;
 	__u8 flags;
-	struct net_device *dev = skb_dst(skb)->dev;
 	struct flow_keys flkeys;
 	unsigned int hh_len;
 
@@ -74,7 +74,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 #endif
 
 	/* Change in oif may mean change in hh_len. */
-	hh_len = skb_dst(skb)->dev->hard_header_len;
+	hh_len = skb_dst_dev(skb)->hard_header_len;
 	if (skb_headroom(skb) < hh_len &&
 	    pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
 				0, GFP_ATOMIC))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index fd3996dff291..5b277e12f398 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -424,7 +424,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct neighbour *n;
 
 	rcu_read_lock_bh();
@@ -451,7 +451,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	const __be32 *pkey = daddr;
 
 	if (rt->rt_gw_family == AF_INET) {
@@ -1074,7 +1074,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1732,8 +1732,8 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 			new_rt->rt_gw6 = rt->rt_gw6;
 		INIT_LIST_HEAD(&new_rt->rt_uncached);
 
-		new_rt->dst.input = rt->dst.input;
-		new_rt->dst.output = rt->dst.output;
+		new_rt->dst.input = READ_ONCE(rt->dst.input);
+		new_rt->dst.output = READ_ONCE(rt->dst.output);
 		new_rt->dst.error = rt->dst.error;
 		new_rt->dst.lastuse = jiffies;
 		new_rt->dst.lwtstate = lwtstate_get(rt->dst.lwtstate);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index e9b5d6f10c56..1c50867d3e7e 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -559,6 +559,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
 void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	struct sk_buff *skb;
 
@@ -576,7 +577,8 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
 		dst = sk_dst_get(sk);
-		if (!(dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK)))
+		dev = dst ? dst_dev(dst) : NULL;
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
 		dst_release(dst);
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7e4a9090abd7..f7693166c516 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -486,7 +486,7 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	struct request_sock *fastopen;
 	u32 seq, snd_una;
 	int err;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	sk = __inet_lookup_established(net, &tcp_hashinfo, iph->daddr,
 				       th->dest, iph->saddr, ntohs(th->source),
@@ -718,7 +718,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	hash_location = tcp_parse_md5sig_option(th);
@@ -1794,7 +1794,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 	if (th->doff < sizeof(struct tcphdr) / 4)
 		return 0;
 
-	sk = __inet_lookup_established(dev_net(skb->dev), &tcp_hashinfo,
+	sk = __inet_lookup_established(dev_net_rcu(skb->dev), &tcp_hashinfo,
 				       iph->saddr, th->source,
 				       iph->daddr, ntohs(th->dest),
 				       skb->skb_iif, inet_sdif(skb));
@@ -1989,7 +1989,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
 
 int tcp_v4_rcv(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct sk_buff *skb_to_free;
 	int sdif = inet_sdif(skb);
 	int dif = inet_iif(skb);
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index f17635ac7d82..2b7230308ea9 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -166,11 +166,11 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 					  unsigned int hash)
 {
 	struct tcp_metrics_block *tm;
-	struct net *net;
 	bool reclaim = false;
+	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 3cff51ba72bb..0ae67d537499 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -31,7 +31,7 @@ static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, skb->dev, skb_dst(skb)->dev,
+			    net, sk, skb, skb->dev, skb_dst_dev(skb),
 			    __xfrm4_output,
 			    !(IPCB(skb)->flags & IPSKB_REROUTED));
 }
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bb7262f5b448..45e0cec505c2 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2008,39 +2008,6 @@ static void ip6_tnl_netlink_parms(struct nlattr *data[],
 		parms->fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-static bool ip6_tnl_netlink_encap_parms(struct nlattr *data[],
-					struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 			   struct nlattr *tb[], struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
@@ -2053,7 +2020,7 @@ static int ip6_tnl_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip6_tnl_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -2087,10 +2054,13 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-	if (ip6_tnl_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
 
 		if (err < 0)
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 733362dcc653..4b16ddc3d6c7 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1545,40 +1545,6 @@ static void ipip6_netlink_parms(struct nlattr *data[],
 		*fwmark = nla_get_u32(data[IFLA_IPTUN_FWMARK]);
 }
 
-/* This function returns true when ENCAP attributes are present in the nl msg */
-static bool ipip6_netlink_encap_parms(struct nlattr *data[],
-				      struct ip_tunnel_encap *ipencap)
-{
-	bool ret = false;
-
-	memset(ipencap, 0, sizeof(*ipencap));
-
-	if (!data)
-		return ret;
-
-	if (data[IFLA_IPTUN_ENCAP_TYPE]) {
-		ret = true;
-		ipencap->type = nla_get_u16(data[IFLA_IPTUN_ENCAP_TYPE]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_FLAGS]) {
-		ret = true;
-		ipencap->flags = nla_get_u16(data[IFLA_IPTUN_ENCAP_FLAGS]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
-		ret = true;
-		ipencap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
-	}
-
-	if (data[IFLA_IPTUN_ENCAP_DPORT]) {
-		ret = true;
-		ipencap->dport = nla_get_be16(data[IFLA_IPTUN_ENCAP_DPORT]);
-	}
-
-	return ret;
-}
-
 #ifdef CONFIG_IPV6_SIT_6RD
 /* This function returns true when 6RD attributes are present in the nl msg */
 static bool ipip6_netlink_6rd_parms(struct nlattr *data[],
@@ -1630,7 +1596,7 @@ static int ipip6_newlink(struct net *src_net, struct net_device *dev,
 
 	nt = netdev_priv(dev);
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(nt, &ipencap);
 		if (err < 0)
 			return err;
@@ -1685,7 +1651,7 @@ static int ipip6_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (dev == sitn->fb_tunnel_dev)
 		return -EINVAL;
 
-	if (ipip6_netlink_encap_parms(data, &ipencap)) {
+	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		err = ip_tunnel_encap_setup(t, &ipencap);
 		if (err < 0)
 			return err;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e972bbb75418..dea59b123eb7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -382,7 +382,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 {
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct tcphdr *th = (struct tcphdr *)(skb->data+offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct request_sock *fastopen;
 	struct ipv6_pinfo *np;
 	struct tcp_sock *tp;
@@ -897,7 +897,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	struct tcphdr *t1;
 	struct sk_buff *buff;
 	struct flowi6 fl6;
-	struct net *net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	struct net *net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 	struct sock *ctl_sk = net->ipv6.tcp_sk;
 	unsigned int tot_len = sizeof(struct tcphdr);
 	__be32 mrst = 0, *topt;
@@ -1047,7 +1047,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	if (!sk && !ipv6_unicast_destination(skb))
 		return;
 
-	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
 #ifdef CONFIG_TCP_MD5SIG
 	rcu_read_lock();
 	hash_location = tcp_parse_md5sig_option(th);
@@ -1633,7 +1633,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	bool refcounted;
 	struct sock *sk;
 	int ret;
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	if (skb->pkt_type != PACKET_HOST)
 		goto discard_it;
@@ -1871,7 +1871,7 @@ void tcp_v6_early_demux(struct sk_buff *skb)
 		return;
 
 	/* Note : We use inet6_iif() here, not tcp_v6_iif() */
-	sk = __inet6_lookup_established(dev_net(skb->dev), &tcp_hashinfo,
+	sk = __inet6_lookup_established(dev_net_rcu(skb->dev), &tcp_hashinfo,
 					&hdr->saddr, th->source,
 					&hdr->daddr, ntohs(th->dest),
 					inet6_iif(skb), inet6_sdif(skb));
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7d078b15f632..78e83ce15cc1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -183,8 +183,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
 		if (opsize != expected_opsize &&
-		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
+		    opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+			mp_opt->dsn64 = 0;
+			mp_opt->use_map = 0;
+			mp_opt->ack64 = 0;
+			mp_opt->use_ack = 0;
+			mp_opt->data_fin = 0;
 			break;
+		}
 
 		mp_opt->suboptions |= OPTION_MPTCP_DSS;
 		if (mp_opt->use_ack) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 01ecd546e844..87321d545564 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -174,7 +174,6 @@ select_local_address(const struct pm_nl_pernet *pernet,
 	msk_owned_by_me(msk);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 			continue;
@@ -619,7 +618,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
 	rcu_read_lock();
-	__mptcp_flush_join_list(msk);
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
@@ -658,7 +656,6 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
 
 		rcu_read_lock();
-		__mptcp_flush_join_list(msk);
 		list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 			if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
 				continue;
@@ -796,7 +793,6 @@ void mptcp_pm_nl_addr_send_ack_avoid_list(struct mptcp_sock *msk,
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	__mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		if (!__mptcp_subflow_active(subflow))
 			continue;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 26d32af7a43f..522d8740a0f3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -848,47 +848,38 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 	mptcp_data_unlock(sk);
 }
 
-static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
+static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	bool ret = false;
+	struct sock *sk = (struct sock *)msk;
 
-	if (likely(list_empty(&msk->join_list)))
+	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	spin_lock_bh(&msk->join_list_lock);
-	list_for_each_entry(subflow, &msk->join_list, node) {
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
-
-		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
-		if (READ_ONCE(msk->setsockopt_seq) != sseq)
-			ret = true;
-	}
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
-
-	return ret;
-}
-
-void __mptcp_flush_join_list(struct mptcp_sock *msk)
-{
-	if (likely(!mptcp_do_flush_join_list(msk)))
-		return;
+	/* attach to msk socket only after we are sure we will deal with it
+	 * at close time
+	 */
+	if (sk->sk_socket && !ssk->sk_socket)
+		mptcp_sock_graft(ssk, sk->sk_socket);
 
-	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
+	mptcp_sockopt_sync_locked(msk, ssk);
+	return true;
 }
 
-static void mptcp_flush_join_list(struct mptcp_sock *msk)
+static void __mptcp_flush_join_list(struct sock *sk)
 {
-	bool sync_needed = test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags);
-
-	might_sleep();
+	struct mptcp_subflow_context *tmp, *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
-		return;
+	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow = lock_sock_fast(ssk);
 
-	mptcp_sockopt_sync_all(msk);
+		list_move_tail(&subflow->node, &msk->conn_list);
+		if (!__mptcp_finish_join(msk, ssk))
+			mptcp_subflow_reset(ssk);
+		unlock_sock_fast(ssk, slow);
+	}
 }
 
 static bool mptcp_rtx_timer_pending(struct sock *sk)
@@ -1678,7 +1669,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			__mptcp_flush_join_list(msk);
 			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
@@ -2086,7 +2076,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	unsigned int moved = 0;
 	bool ret, done;
 
-	mptcp_flush_join_list(msk);
 	do {
 		struct sock *ssk = mptcp_subflow_recv_lookup(msk);
 		bool slowpath;
@@ -2577,8 +2566,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_flush_join_list(msk);
-
 	mptcp_check_fastclose(msk);
 
 	if (msk->pm.status)
@@ -2617,8 +2604,6 @@ static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	spin_lock_init(&msk->join_list_lock);
-
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
@@ -2781,7 +2766,6 @@ static void mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	mptcp_flush_join_list(msk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2814,12 +2798,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 
 	might_sleep();
 
-	/* be sure to always acquire the join list lock, to sync vs
-	 * mptcp_finish_join().
-	 */
-	spin_lock_bh(&msk->join_list_lock);
-	list_splice_tail_init(&msk->join_list, &msk->conn_list);
-	spin_unlock_bh(&msk->join_list_lock);
+	/* join list will be eventually flushed (with rst) at sock lock release time*/
 	list_splice_init(&msk->conn_list, &conn_list);
 
 	sk_stop_timer(sk, &msk->sk.icsk_retransmit_timer);
@@ -2934,8 +2913,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (sk->sk_wait_pending)
 		return -EBUSY;
 
-	mptcp_do_flush_join_list(msk);
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -3182,6 +3159,8 @@ static void mptcp_release_cb(struct sock *sk)
 			flags |= BIT(MPTCP_PUSH_PENDING);
 		if (test_and_clear_bit(MPTCP_RETRANSMIT, &mptcp_sk(sk)->flags))
 			flags |= BIT(MPTCP_RETRANSMIT);
+		if (test_and_clear_bit(MPTCP_FLUSH_JOIN_LIST, &mptcp_sk(sk)->flags))
+			flags |= BIT(MPTCP_FLUSH_JOIN_LIST);
 		if (!flags)
 			break;
 
@@ -3194,6 +3173,8 @@ static void mptcp_release_cb(struct sock *sk)
 		 */
 
 		spin_unlock_bh(&sk->sk_lock.slock);
+		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
+			__mptcp_flush_join_list(sk);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
@@ -3342,8 +3323,7 @@ bool mptcp_finish_join(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	struct sock *parent = (void *)msk;
-	struct socket *parent_sock;
-	bool ret;
+	bool ret = true;
 
 	pr_debug("msk=%p, subflow=%p\n", msk, subflow);
 
@@ -3356,36 +3336,40 @@ bool mptcp_finish_join(struct sock *ssk)
 	if (!msk->pm.server_side)
 		goto out;
 
-	if (!mptcp_pm_allow_new_subflow(msk)) {
-		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
-		return false;
-	}
+	if (!mptcp_pm_allow_new_subflow(msk))
+		goto err_prohibited;
 
-	/* active connections are already on conn_list, and we can't acquire
-	 * msk lock here.
-	 * use the join list lock as synchronization point and double-check
-	 * msk status to avoid racing with __mptcp_destroy_sock()
+	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
+		goto err_prohibited;
+
+	/* active connections are already on conn_list.
+	 * If we can't acquire msk socket lock here, let the release callback
+	 * handle it
 	 */
-	spin_lock_bh(&msk->join_list_lock);
-	ret = inet_sk_state_load(parent) == TCP_ESTABLISHED;
-	if (ret && !WARN_ON_ONCE(!list_empty(&subflow->node))) {
-		list_add_tail(&subflow->node, &msk->join_list);
+	mptcp_data_lock(parent);
+	if (!sock_owned_by_user(parent)) {
+		ret = __mptcp_finish_join(msk, ssk);
+		if (ret) {
+			sock_hold(ssk);
+			list_add_tail(&subflow->node, &msk->conn_list);
+		}
+	} else {
 		sock_hold(ssk);
+		list_add_tail(&subflow->node, &msk->join_list);
+		set_bit(MPTCP_FLUSH_JOIN_LIST, &msk->flags);
 	}
-	spin_unlock_bh(&msk->join_list_lock);
+	mptcp_data_unlock(parent);
+
 	if (!ret) {
+		mptcp_pm_close_subflow(msk);
+err_prohibited:
 		subflow->reset_reason = MPTCP_RST_EPROHIBIT;
 		return false;
 	}
 
-	/* attach to msk socket only after we are sure he will deal with us
-	 * at close time
-	 */
-	parent_sock = READ_ONCE(parent->sk_socket);
-	if (parent_sock && !ssk->sk_socket)
-		mptcp_sock_graft(ssk, parent_sock);
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
+
 out:
 	mptcp_event(MPTCP_EVENT_SUB_ESTABLISHED, msk, ssk, GFP_ATOMIC);
 	return true;
@@ -3595,7 +3579,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* set ssk->sk_socket of accept()ed flows to mptcp socket.
 		 * This is needed so NOSPACE flag can be set from tcp stack.
 		 */
-		mptcp_flush_join_list(msk);
 		mptcp_for_each_subflow(msk, subflow) {
 			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5492c67ecc9a..4767b5ea29df 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -121,7 +121,7 @@
 #define MPTCP_CLEAN_UNA		7
 #define MPTCP_ERROR_REPORT	8
 #define MPTCP_RETRANSMIT	9
-#define MPTCP_WORK_SYNC_SETSOCKOPT 10
+#define MPTCP_FLUSH_JOIN_LIST	10
 #define MPTCP_CONNECTED		11
 
 static inline bool before64(__u64 seq1, __u64 seq2)
@@ -252,7 +252,6 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
-	spinlock_t	join_list_lock;
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;
@@ -508,15 +507,6 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
 }
 
-static inline void mptcp_add_pending_subflow(struct mptcp_sock *msk,
-					     struct mptcp_subflow_context *subflow)
-{
-	sock_hold(mptcp_subflow_tcp_sock(subflow));
-	spin_lock_bh(&msk->join_list_lock);
-	list_add_tail(&subflow->node, &msk->join_list);
-	spin_unlock_bh(&msk->join_list_lock);
-}
-
 void mptcp_subflow_process_delegated(struct sock *ssk);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
@@ -684,7 +674,6 @@ void __mptcp_data_acked(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
 void mptcp_subflow_eof(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
-void __mptcp_flush_join_list(struct mptcp_sock *msk);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->snd_data_fin_enable) &&
@@ -850,6 +839,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
 
+/* called under PM lock */
+static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
+		WRITE_ONCE(msk->pm.accept_subflow, true);
+}
+
+static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
+{
+	spin_lock_bh(&msk->pm.lock);
+	__mptcp_pm_close_subflow(msk);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
@@ -859,7 +862,7 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 }
 
 void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk);
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)
 {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9e0fd3bffd94..e2605a949656 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -904,27 +904,15 @@ void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
 	}
 }
 
-void mptcp_sockopt_sync_all(struct mptcp_sock *msk)
+void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
 {
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	u32 seq;
-
-	seq = sockopt_seq_reset(sk);
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
+	msk_owned_by_me(msk);
 
-		if (sseq != msk->setsockopt_seq) {
-			__mptcp_sockopt_sync(msk, ssk);
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		} else if (sseq != seq) {
-			WRITE_ONCE(subflow->setsockopt_seq, seq);
-		}
+	if (READ_ONCE(subflow->setsockopt_seq) != msk->setsockopt_seq) {
+		sync_socket_options(msk, ssk);
 
-		cond_resched();
+		subflow->setsockopt_seq = msk->setsockopt_seq;
 	}
-
-	msk->setsockopt_seq = seq;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a5a03601c7f9..2ec22660ba7a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1434,20 +1434,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
 	int local_id = loc->id;
+	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
 	int ifindex;
 	u8 flags;
-	int err;
 
 	if (!mptcp_is_fully_established(sk))
-		return -ENOTCONN;
+		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, &sf);
 	if (err)
-		return err;
+		goto err_out;
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1490,7 +1490,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 
-	mptcp_add_pending_subflow(msk, subflow);
+	sock_hold(ssk);
+	list_add_tail(&subflow->node, &msk->conn_list);
 	mptcp_sockopt_sync(msk, ssk);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
 	if (err && err != -EINPROGRESS)
@@ -1503,14 +1504,18 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	return err;
 
 failed_unlink:
-	spin_lock_bh(&msk->join_list_lock);
 	list_del(&subflow->node);
-	spin_unlock_bh(&msk->join_list_lock);
 	sock_put(mptcp_subflow_tcp_sock(subflow));
 
 failed:
 	subflow->disposable = 1;
 	sock_release(sf);
+
+err_out:
+	/* we account subflows before the creation, and this failures will not
+	 * be caught by sk_state_change()
+	 */
+	mptcp_pm_close_subflow(msk);
 	return err;
 }
 
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 34d5c973c4ee..3115591c9d65 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -679,11 +679,18 @@ __ip_set_get(struct ip_set *set)
 }
 
 static void
-__ip_set_put(struct ip_set *set)
+__ip_set_put_locked(struct ip_set *set)
 {
-	write_lock_bh(&ip_set_ref_lock);
+	lockdep_assert_held(&ip_set_ref_lock);
 	BUG_ON(set->ref == 0);
 	set->ref--;
+}
+
+static void
+__ip_set_put(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	__ip_set_put_locked(set);
 	write_unlock_bh(&ip_set_ref_lock);
 }
 
@@ -856,11 +863,11 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_set_id_t index)
 {
 	struct ip_set *set;
 
-	rcu_read_lock();
-	set = rcu_dereference(inst->ip_set_list)[index];
+	write_lock_bh(&ip_set_ref_lock);
+	set = ip_set(inst, index);
 	if (set)
-		__ip_set_put(set);
-	rcu_read_unlock();
+		__ip_set_put_locked(set);
+	write_unlock_bh(&ip_set_ref_lock);
 }
 
 void
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 7d1ba6ad514f..25cfa8693f1a 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -301,9 +301,12 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	e->set = set;
 	INIT_LIST_HEAD(&e->list);
 	list_set_init_extensions(set, ext, e);
-	if (n)
+	if (n) {
 		list_set_replace(set, e, n);
-	else if (next)
+		return 0;
+	}
+
+	if (next)
 		list_add_tail_rcu(&e->list, &next->list);
 	else if (prev)
 		list_add_rcu(&e->list, &prev->list);
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index b850c254b958..73361a4df43b 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -759,7 +759,7 @@ int ip_vs_check_template(struct ip_vs_conn *ct, struct ip_vs_dest *cdest)
 	 * Checking the dest server status.
 	 */
 	if ((dest == NULL) ||
-	    !(dest->flags & IP_VS_DEST_F_AVAILABLE) ||
+	    !(dest->cflags & IP_VS_DEST_CF_AVAILABLE) ||
 	    expire_quiescent_template(ipvs, dest) ||
 	    (cdest && (dest != cdest))) {
 		IP_VS_DBG_BUF(9, "check_template: dest not available for "
@@ -1402,7 +1402,7 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 				continue;
 
 			dest = cp->dest;
-			if (!dest || (dest->flags & IP_VS_DEST_F_AVAILABLE))
+			if (!dest || (dest->cflags & IP_VS_DEST_CF_AVAILABLE))
 				continue;
 
 			if (atomic_read(&cp->n_control))
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index 99cc39036c4e..aaad3ccb0bb5 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -124,7 +124,7 @@ ip_vs_in_stats(struct ip_vs_conn *cp, struct sk_buff *skb)
 	struct ip_vs_dest *dest = cp->dest;
 	struct netns_ipvs *ipvs = cp->ipvs;
 
-	if (dest && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (dest && (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
@@ -160,7 +160,7 @@ ip_vs_out_stats(struct ip_vs_conn *cp, struct sk_buff *skb)
 	struct ip_vs_dest *dest = cp->dest;
 	struct netns_ipvs *ipvs = cp->ipvs;
 
-	if (dest && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (dest && (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		struct ip_vs_cpu_stats *s;
 		struct ip_vs_service *svc;
 
@@ -2084,7 +2084,7 @@ ip_vs_in(struct netns_ipvs *ipvs, unsigned int hooknum, struct sk_buff *skb, int
 	}
 
 	/* Check the server status */
-	if (cp && cp->dest && !(cp->dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+	if (cp && cp->dest && !(cp->dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 		/* the destination server is not available */
 		if (sysctl_expire_nodest_conn(ipvs)) {
 			bool old_ct = ip_vs_conn_uses_old_conntrack(cp, skb);
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 025512d76db0..2ded17b67819 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -961,7 +961,7 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 	}
 
 	/* set the dest status flags */
-	dest->flags |= IP_VS_DEST_F_AVAILABLE;
+	dest->cflags |= IP_VS_DEST_CF_AVAILABLE;
 
 	if (READ_ONCE(dest->u_threshold) != udest->u_threshold ||
 	    READ_ONCE(dest->l_threshold) != udest->l_threshold) {
@@ -1240,7 +1240,7 @@ static void __ip_vs_unlink_dest(struct ip_vs_service *svc,
 				struct ip_vs_dest *dest,
 				int svcupd)
 {
-	dest->flags &= ~IP_VS_DEST_F_AVAILABLE;
+	dest->cflags &= ~IP_VS_DEST_CF_AVAILABLE;
 
 	/*
 	 *  Remove it from the d-linked destination list.
diff --git a/net/netfilter/ipvs/ip_vs_dh.c b/net/netfilter/ipvs/ip_vs_dh.c
index 5e6ec32aff2b..6d88bb4bf4ae 100644
--- a/net/netfilter/ipvs/ip_vs_dh.c
+++ b/net/netfilter/ipvs/ip_vs_dh.c
@@ -220,8 +220,8 @@ ip_vs_dh_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 
 	s = (struct ip_vs_dh_state *) svc->sched_data;
 	dest = ip_vs_dh_get(svc->af, s, &iph->daddr);
-	if (!dest
-	    || !(dest->flags & IP_VS_DEST_F_AVAILABLE)
+	if (!dest ||
+	    !(dest->cflags & IP_VS_DEST_CF_AVAILABLE)
 	    || atomic_read(&dest->weight) <= 0
 	    || is_overloaded(dest)) {
 		ip_vs_scheduler_err(svc, "no destination available");
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 7ac7473e3804..e2480f33a196 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -503,7 +503,7 @@ ip_vs_lblc_schedule(struct ip_vs_service *svc, const struct sk_buff *skb,
 		 */
 
 		dest = en->dest;
-		if ((dest->flags & IP_VS_DEST_F_AVAILABLE) &&
+		if ((dest->cflags & IP_VS_DEST_CF_AVAILABLE) &&
 		    atomic_read(&dest->weight) > 0 && !is_overloaded(dest, svc))
 			goto out;
 	}
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index 77c323c36a88..7469547c8a44 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -170,8 +170,8 @@ static inline struct ip_vs_dest *ip_vs_dest_set_min(struct ip_vs_dest_set *set)
 		if (least->flags & IP_VS_DEST_F_OVERLOAD)
 			continue;
 
-		if ((atomic_read(&least->weight) > 0)
-		    && (least->flags & IP_VS_DEST_F_AVAILABLE)) {
+		if ((atomic_read(&least->weight) > 0) &&
+		    (least->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 			loh = ip_vs_dest_conn_overhead(least);
 			goto nextstage;
 		}
@@ -187,8 +187,8 @@ static inline struct ip_vs_dest *ip_vs_dest_set_min(struct ip_vs_dest_set *set)
 
 		doh = ip_vs_dest_conn_overhead(dest);
 		if (((__s64)loh * atomic_read(&dest->weight) >
-		     (__s64)doh * atomic_read(&least->weight))
-		    && (dest->flags & IP_VS_DEST_F_AVAILABLE)) {
+		     (__s64)doh * atomic_read(&least->weight)) &&
+		    (dest->cflags & IP_VS_DEST_CF_AVAILABLE)) {
 			least = dest;
 			loh = doh;
 		}
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 0f6147ea9e67..7a9c07fff57a 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -947,10 +947,8 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 			return NF_ACCEPT;
 		saddr = &ct->tuplehash[!dir].tuple.src.u3;
 	} else if (sip_external_media) {
-		struct net_device *dev = skb_dst(skb)->dev;
-		struct net *net = dev_net(dev);
-		struct flowi fl;
 		struct dst_entry *dst = NULL;
+		struct flowi fl;
 
 		memset(&fl, 0, sizeof(fl));
 
@@ -970,7 +968,11 @@ static int set_expected_rtp_rtcp(struct sk_buff *skb, unsigned int protoff,
 		 * through the same interface as the signalling peer.
 		 */
 		if (dst) {
-			bool external_media = (dst->dev == dev);
+			const struct dst_entry *this_dst = skb_dst(skb);
+			bool external_media = false;
+
+			if (this_dst && dst->dev == this_dst->dev)
+				external_media = true;
 
 			dst_release(dst);
 			if (external_media)
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index beb0e84b5f42..5a87504dd99e 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -279,17 +279,18 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 	flow->timeout = nf_flowtable_time_stamp + flow_offload_get_timeout(flow);
 
 	err = rhashtable_insert_fast(&flow_table->rhashtable,
-				     &flow->tuplehash[0].node,
+				     &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
 				     nf_flow_offload_rhash_params);
 	if (err < 0)
 		return err;
 
+	/* GC only iterates original-direction entries; publish original last. */
 	err = rhashtable_insert_fast(&flow_table->rhashtable,
-				     &flow->tuplehash[1].node,
+				     &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].node,
 				     nf_flow_offload_rhash_params);
 	if (err < 0) {
 		rhashtable_remove_fast(&flow_table->rhashtable,
-				       &flow->tuplehash[0].node,
+				       &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
 				       nf_flow_offload_rhash_params);
 		return err;
 	}
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 8695e99976cc..74d85f7a4f55 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -67,6 +67,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 		nf_queue_sock_put(state->sk);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_put(entry->bridge_dev);
 	dev_put(entry->physin);
 	dev_put(entry->physout);
 #endif
@@ -83,6 +84,8 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	const struct sk_buff *skb = entry->skb;
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = NULL;
 	struct nf_bridge_info *nf_bridge;
 
 	nf_bridge = nf_bridge_info_get(skb);
@@ -93,6 +96,16 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 		entry->physin = NULL;
 		entry->physout = NULL;
 	}
+
+	if (entry->state.pf == NFPROTO_BRIDGE &&
+	    dst && (dst->flags & DST_FAKE_RTABLE))
+		dev = dst_dev_rcu(dst);
+
+	/* Must hold a reference on the bridge device: dst_hold() protects
+	 * the dst itself, but the fake rtable is embedded in bridge-private
+	 * storage that netdevice teardown can free independently.
+	 */
+	entry->bridge_dev = dev;
 #endif
 }
 
@@ -109,6 +122,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	dev_hold(state->out);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_hold(entry->bridge_dev);
 	dev_hold(entry->physin);
 	dev_hold(entry->physout);
 #endif
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 910ef881c3b8..27907fa6f157 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -550,7 +550,7 @@ static void nft_flow_rule_offload_abort(struct net *net,
 			break;
 		}
 
-		if (WARN_ON_ONCE(err))
+		if (WARN_ON_ONCE(err && err != -ENOMEM))
 			break;
 	}
 }
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index cb98afc2de5a..4967fc7ddb12 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -943,6 +943,9 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
 
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
+
+	if (entry->bridge_dev && entry->bridge_dev->ifindex == ifindex)
+		return 1;
 #endif
 	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
 		return 1;
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index a965444ce5c5..1825db84c222 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,6 +342,8 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
+static void nft_pipapo_abort(const struct nft_set *set);
+
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -502,9 +504,11 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * pipapo_get() - Get matching element reference given key data
  * @net:	Network namespace
  * @set:	nftables API set representation
+ * @m:		storage containing active/existing elements
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
  * @tstamp:	timestamp to check for expired elements
+ * @gfp:	the type of memory to allocate (see kmalloc).
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -514,27 +518,25 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
+					  const struct nft_pipapo_match *m,
 					  const u8 *data, u8 genmask,
-					  u64 tstamp)
+					  u64 tstamp, gfp_t gfp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
-	struct nft_pipapo *priv = nft_set_priv(set);
 	unsigned long *res_map, *fill_map = NULL;
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i;
 
-	m = priv->clone;
 	if (m->bsize_max == 0)
 		return ret;
 
-	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), gfp);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), gfp);
 	if (!fill_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
@@ -608,8 +610,12 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net), get_jiffies_64());
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m = rcu_dereference(priv->match);
+
+	return pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
+			 nft_genmask_cur(net), get_jiffies_64(),
+			 GFP_ATOMIC);
 }
 
 /**
@@ -1188,6 +1194,40 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	return 0;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+
+	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
+#else
+	return true;
+#endif
+}
+
+static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old);
+
+/**
+ * pipapo_maybe_clone() - Build clone for pending data changes, if not existing
+ * @set:	nftables API set representation
+ *
+ * Return: newly created or existing clone, if any. NULL on allocation failure
+ */
+static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m;
+
+	if (priv->clone)
+		return priv->clone;
+
+	m = rcu_dereference_protected(priv->match,
+				      nft_pipapo_transaction_mutex_held(set));
+	priv->clone = pipapo_clone(m);
+
+	return priv->clone;
+}
+
 /**
  * nft_pipapo_insert() - Validate and insert ranged elements
  * @net:	Network namespace
@@ -1204,21 +1244,24 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 	const u8 *start = (const u8 *)elem->key.val.data, *end;
+	struct nft_pipapo_match *m = pipapo_maybe_clone(set);
 	struct nft_pipapo_elem *e = elem->priv, *dup;
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
 	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
 
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
+		return -ENOMEM;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
 		end = (const u8 *)nft_set_ext_key_end(ext)->data;
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp);
+	dup = pipapo_get(net, set, m, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1240,7 +1283,8 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
+		dup = pipapo_get(net, set, m, end, nft_genmask_next(net), tstamp,
+				 GFP_KERNEL);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1282,8 +1326,10 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		else
 			ret = pipapo_expand(f, start, end, f->groups * f->bb);
 
-		if (ret < 0)
-			return ret;
+		if (ret < 0) {
+			err = ret;
+			goto abort;
+		}
 
 		if (f->bsize > bsize_max)
 			bsize_max = f->bsize;
@@ -1299,7 +1345,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		err = pipapo_realloc_scratch(m, bsize_max);
 		if (err)
-			return err;
+			goto abort;
 
 		m->bsize_max = bsize_max;
 	} else {
@@ -1310,14 +1356,33 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	pipapo_map(m, rulemap, e);
 
+	m->state = NFT_PIPAPO_CLONE_MOD;
 	return 0;
+abort:
+	WARN_ON_ONCE(m->state == NFT_PIPAPO_CLONE_ERR);
+
+	/* Two rollback cases:
+	 * 1) no previous changes.  nft_pipapo_abort is not
+	 * guaranteed to be invoked (there might be no further
+	 * add/delete requests coming after this).
+	 *
+	 * 2) we had previous changes: there are transaction
+	 * records pointing to this set.  Leave the rollback to
+	 * the transaction handling.
+	 */
+	if (m->state == NFT_PIPAPO_CLONE_NEW)
+		nft_pipapo_abort(set); /* releases m */
+	else
+		m->state = NFT_PIPAPO_CLONE_ERR;
+
+	return err;
 }
 
 /**
  * pipapo_clone() - Clone matching data to create new working copy
  * @old:	Existing matching data
  *
- * Return: copy of matching data passed as 'old', error pointer on failure
+ * Return: copy of matching data passed as 'old' or NULL.
  */
 static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 {
@@ -1328,7 +1393,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	new = kmalloc(sizeof(*new) + sizeof(*dst) * old->field_count,
 		      GFP_KERNEL);
 	if (!new)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	new->field_count = old->field_count;
 	new->bsize_max = old->bsize_max;
@@ -1385,6 +1450,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 		dst++;
 	}
 
+	new->state = NFT_PIPAPO_CLONE_NEW;
 	return new;
 
 out_mt:
@@ -1402,7 +1468,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	free_percpu(new->scratch);
 	kfree(new);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 /**
@@ -1747,7 +1813,10 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 static void nft_pipapo_commit(struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *old;
+	struct nft_pipapo_match *old;
+
+	if (!priv->clone)
+		return;
 
 	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
 		pipapo_gc_scan(set, priv->clone);
@@ -1755,51 +1824,29 @@ static void nft_pipapo_commit(struct nft_set *set)
 	if (!priv->dirty)
 		return;
 
-	new_clone = pipapo_clone(priv->clone);
-	if (IS_ERR(new_clone))
-		return;
-
+	old = rcu_replace_pointer(priv->match, priv->clone,
+				  nft_pipapo_transaction_mutex_held(set));
+	priv->clone = NULL;
 	priv->dirty = false;
 
-	old = rcu_access_pointer(priv->match);
-	rcu_assign_pointer(priv->match, priv->clone);
 	if (old)
 		call_rcu(&old->rcu, pipapo_reclaim_match);
 
-	priv->clone = new_clone;
-
 	pipapo_gc_queue(set);
 }
 
-static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	const struct net *net = read_pnet(&set->net);
-
-	return lockdep_is_held(&nft_pernet(net)->commit_mutex);
-#else
-	return true;
-#endif
-}
-
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *m;
 
 	if (!priv->dirty)
 		return;
 
-	m = rcu_dereference_protected(priv->match, nft_pipapo_transaction_mutex_held(set));
-
-	new_clone = pipapo_clone(m);
-	if (IS_ERR(new_clone))
+	if (!priv->clone)
 		return;
-
 	priv->dirty = false;
-
 	pipapo_free_match(priv->clone);
-	priv->clone = new_clone;
+	priv->clone = NULL;
 }
 
 /**
@@ -1823,24 +1870,28 @@ static void nft_pipapo_activate(const struct net *net,
 }
 
 /**
- * pipapo_deactivate() - Check that element is in set, mark as inactive
+ * nft_pipapo_deactivate() - Search for element and make it inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
- * @data:	Input key data
- * @ext:	nftables API extension pointer, used to check for end element
- *
- * This is a convenience function that can be called from both
- * nft_pipapo_deactivate() and nft_pipapo_flush(), as they are in fact the same
- * operation.
+ * @elem:	nftables API element representation containing key data
  *
  * Return: deactivated element if found, NULL otherwise.
  */
-static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
-			       const u8 *data, const struct nft_set_ext *ext)
+static void *nft_pipapo_deactivate(const struct net *net,
+				   const struct nft_set *set,
+				   const struct nft_set_elem *elem)
 {
+	struct nft_pipapo_match *m = pipapo_maybe_clone(set);
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
+	/* removal must occur on priv->clone, if we are low on memory
+	 * we have no choice and must fail the removal request.
+	 */
+	if (!m || m->state == NFT_PIPAPO_CLONE_ERR)
+		return NULL;
+
+	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
+		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
@@ -1850,24 +1901,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 }
 
 /**
- * nft_pipapo_deactivate() - Call pipapo_deactivate() to make element inactive
- * @net:	Network namespace
- * @set:	nftables API set representation
- * @elem:	nftables API element representation containing key data
- *
- * Return: deactivated element if found, NULL otherwise.
- */
-static void *nft_pipapo_deactivate(const struct net *net,
-				   const struct nft_set *set,
-				   const struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-
-	return pipapo_deactivate(net, set, (const u8 *)elem->key.val.data, ext);
-}
-
-/**
- * nft_pipapo_flush() - Call pipapo_deactivate() to make element inactive
+ * nft_pipapo_flush() - make element inactive
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
@@ -1889,8 +1923,9 @@ static bool nft_pipapo_flush(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e = elem;
 
-	return pipapo_deactivate(net, set, (const u8 *)nft_set_ext_key(&e->ext),
-				 &e->ext);
+	nft_set_elem_change_active(net, set, &e->ext);
+
+	return true;
 }
 
 /**
@@ -2077,35 +2112,23 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 }
 
 /**
- * nft_pipapo_walk() - Walk over elements
+ * nft_pipapo_do_walk() - Walk over elements in m
  * @ctx:	nftables API context
  * @set:	nftables API set representation
+ * @m:		matching data pointing to key mapping array
  * @iter:	Iterator
  *
  * As elements are referenced in the mapping array for the last field, directly
  * scan that array: there's no need to follow rule mappings from the first
- * field.
+ * field. @m is protected either by RCU read lock or by transaction mutex.
  */
-static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
-			    struct nft_set_iter *iter)
+static void nft_pipapo_do_walk(const struct nft_ctx *ctx, struct nft_set *set,
+			       const struct nft_pipapo_match *m,
+			       struct nft_set_iter *iter)
 {
-	struct nft_pipapo *priv = nft_set_priv(set);
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i, r;
 
-	WARN_ON_ONCE(iter->type != NFT_ITER_READ &&
-		     iter->type != NFT_ITER_UPDATE);
-
-	rcu_read_lock();
-	if (iter->type == NFT_ITER_READ)
-		m = rcu_dereference(priv->match);
-	else
-		m = priv->clone;
-
-	if (unlikely(!m))
-		goto out;
-
 	for (i = 0, f = m->f; i < m->field_count - 1; i++, f++)
 		;
 
@@ -2125,14 +2148,49 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		iter->err = iter->fn(ctx, set, iter, &elem);
 		if (iter->err < 0)
-			goto out;
+			return;
 
 cont:
 		iter->count++;
 	}
+}
 
-out:
-	rcu_read_unlock();
+/**
+ * nft_pipapo_walk() - Walk over elements
+ * @ctx:	nftables API context
+ * @set:	nftables API set representation
+ * @iter:	Iterator
+ *
+ * Test if destructive action is needed or not, clone active backend if needed
+ * and call the real function to work on the data.
+ */
+static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
+			    struct nft_set_iter *iter)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	const struct nft_pipapo_match *m;
+
+	switch (iter->type) {
+	case NFT_ITER_UPDATE:
+		m = pipapo_maybe_clone(set);
+		if (!m) {
+			iter->err = -ENOMEM;
+			return;
+		}
+
+		nft_pipapo_do_walk(ctx, set, m, iter);
+		break;
+	case NFT_ITER_READ:
+		rcu_read_lock();
+		m = rcu_dereference(priv->match);
+		nft_pipapo_do_walk(ctx, set, m, iter);
+		rcu_read_unlock();
+		break;
+	default:
+		iter->err = -EINVAL;
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 /**
@@ -2234,8 +2292,8 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 	/* Create an initial clone of matching data for next insertion */
 	priv->clone = pipapo_clone(m);
-	if (IS_ERR(priv->clone)) {
-		err = PTR_ERR(priv->clone);
+	if (!priv->clone) {
+		err = -ENOMEM;
 		goto out_free;
 	}
 
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index a99baaeb5d92..949f4cd709b2 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -142,9 +142,16 @@ struct nft_pipapo_scratch {
 	unsigned long map[];
 };
 
+enum nft_pipapo_clone_state {
+	NFT_PIPAPO_CLONE_NEW,
+	NFT_PIPAPO_CLONE_MOD,
+	NFT_PIPAPO_CLONE_ERR,
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
+ * @state:		add/delete state; used from control plane
  * @scratch:		Preallocated per-CPU maps for partial matching results
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
@@ -152,6 +159,7 @@ struct nft_pipapo_scratch {
  */
 struct nft_pipapo_match {
 	int field_count;
+	enum nft_pipapo_clone_state state:8;
 	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 527a181c842c..747ba60afe0a 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -494,13 +494,12 @@ static int ovs_ct_helper(struct sk_buff *skb, u16 proto)
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
  * value if 'skb' is freed.
  */
-static int handle_fragments(struct net *net, struct sw_flow_key *key,
-			    u16 zone, struct sk_buff *skb)
+static int handle_fragments(struct net *net, struct sk_buff *skb,
+			    u16 zone, u8 family, u8 *proto, u16 *mru)
 {
-	struct ovs_skb_cb ovs_cb = *OVS_CB(skb);
 	int err;
 
-	if (key->eth.type == htons(ETH_P_IP)) {
+	if (family == NFPROTO_IPV4) {
 		enum ip_defrag_users user = IP_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
@@ -508,9 +507,9 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 		if (err)
 			return err;
 
-		ovs_cb.mru = IPCB(skb)->frag_max_size;
+		*mru = IPCB(skb)->frag_max_size;
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (family == NFPROTO_IPV6) {
 		enum ip6_defrag_users user = IP6_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IP6CB(skb), 0, sizeof(struct inet6_skb_parm));
@@ -521,22 +520,35 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 			return err;
 		}
 
-		key->ip.proto = ipv6_hdr(skb)->nexthdr;
-		ovs_cb.mru = IP6CB(skb)->frag_max_size;
+		*proto = ipv6_hdr(skb)->nexthdr;
+		*mru = IP6CB(skb)->frag_max_size;
 #endif
 	} else {
 		kfree_skb(skb);
 		return -EPFNOSUPPORT;
 	}
 
+	skb_clear_hash(skb);
+	skb->ignore_df = 1;
+
+	return 0;
+}
+
+static int ovs_ct_handle_fragments(struct net *net, struct sw_flow_key *key,
+				   u16 zone, int family, struct sk_buff *skb)
+{
+	struct ovs_skb_cb ovs_cb = *OVS_CB(skb);
+	int err;
+
+	err = handle_fragments(net, skb, zone, family, &key->ip.proto, &ovs_cb.mru);
+	if (err)
+		return err;
+
 	/* The key extracted from the fragment that completed this datagram
 	 * likely didn't have an L4 header, so regenerate it.
 	 */
 	ovs_flow_key_update_l3l4(skb, key);
-
 	key->ip.frag = OVS_FRAG_TYPE_NONE;
-	skb_clear_hash(skb);
-	skb->ignore_df = 1;
 	*OVS_CB(skb) = ovs_cb;
 
 	return 0;
@@ -1275,7 +1287,7 @@ static int ovs_skb_network_trim(struct sk_buff *skb)
 
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case htons(ETH_P_IPV6):
 		len = sizeof(struct ipv6hdr)
@@ -1311,7 +1323,8 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 		return err;
 
 	if (key->ip.frag != OVS_FRAG_TYPE_NONE) {
-		err = handle_fragments(net, key, info->zone.id, skb);
+		err = ovs_ct_handle_fragments(net, key, info->zone.id,
+					      info->family, skb);
 		if (err)
 			return err;
 	}
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 2c1a0c5e6df1..963be5198c63 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1949,13 +1949,13 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	skb_probe_transport_header(skb);
+
 	/* Move network header to the right position for VLAN tagged packets */
 	if (likely(skb->dev->type == ARPHRD_ETHER) &&
 	    eth_type_vlan(skb->protocol) &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
-
-	skb_probe_transport_header(skb);
 }
 
 /*
@@ -2653,6 +2653,9 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		len = ((to_write > len_max) ? len_max : to_write);
 	}
 
+	if (unlikely(!skb->len))
+		return -EINVAL;
+
 	packet_parse_headers(skb, sock);
 
 	return tp_len;
diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 658b592e58e0..4a1e5d7a0726 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -481,14 +481,27 @@ int rxrpc_kernel_charge_accept(struct socket *sock,
 			       unsigned long user_call_ID, gfp_t gfp,
 			       unsigned int debug_id)
 {
-	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
-	struct rxrpc_backlog *b = rx->backlog;
+	struct rxrpc_backlog *b;
+	struct rxrpc_sock *rx;
+	struct sock *sk;
+	int ret;
+
+	sk = sock->sk;
+	rx = rxrpc_sk(sk);
+
+	lock_sock(sk);
+	if (sk->sk_state != RXRPC_SERVER_LISTENING || !rx->backlog) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
 
-	if (sock->sk->sk_state == RXRPC_CLOSE)
-		return -ESHUTDOWN;
+	b = rx->backlog;
+	ret = rxrpc_service_prealloc_one(rx, b, notify_rx,
+					 user_attach_call, user_call_ID,
+					 gfp, debug_id);
 
-	return rxrpc_service_prealloc_one(rx, b, notify_rx,
-					  user_attach_call, user_call_ID,
-					  gfp, debug_id);
+out:
+	release_sock(sk);
+	return ret;
 }
 EXPORT_SYMBOL(rxrpc_kernel_charge_accept);
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 1639cc2869ef..df31fa7b5064 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -629,7 +629,7 @@ static int tcf_ct_skb_network_trim(struct sk_buff *skb, int family)
 
 	switch (family) {
 	case NFPROTO_IPV4:
-		len = ntohs(ip_hdr(skb)->tot_len);
+		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
 		len = sizeof(struct ipv6hdr)
@@ -696,14 +696,21 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *skb, bool *frag)
 	return 0;
 }
 
+/* On error, tells the caller whether it still owns @skb and must free it
+ * itself.  @skb is ours only when the header checks below reject the packet
+ * before it is handed to the defragmentation engine; once nf_ct_handle_
+ * fragments() has been called the skb is either queued (-EINPROGRESS) or has
+ * already been freed by it.
+ */
 static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
-				   u8 family, u16 zone, bool *defrag)
+				   u8 family, u16 zone, bool *defrag,
+				   bool *skb_is_ours)
 {
 	enum ip_conntrack_info ctinfo;
+	struct tc_skb_cb cb;
 	struct nf_conn *ct;
 	int err = 0;
 	bool frag;
-	u16 mru;
 
 	/* Previously seen (loopback)? Ignore. */
 	ct = nf_ct_get(skb, &ctinfo);
@@ -714,10 +721,14 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 		err = tcf_ct_ipv4_is_fragment(skb, &frag);
 	else
 		err = tcf_ct_ipv6_is_fragment(skb, &frag);
-	if (err || !frag)
+	if (err) {
+		*skb_is_ours = true;
 		return err;
+	}
+	if (!frag)
+		return 0;
 
-	mru = tc_skb_cb(skb)->mru;
+	cb = *tc_skb_cb(skb);
 
 	if (family == NFPROTO_IPV4) {
 		enum ip_defrag_users user = IP_DEFRAG_CONNTRACK_IN + zone;
@@ -731,7 +742,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IPCB(skb)->frag_max_size;
+			cb.mru = IPCB(skb)->frag_max_size;
 		}
 	} else { /* NFPROTO_IPV6 */
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
@@ -744,7 +755,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 
 		if (!err) {
 			*defrag = true;
-			mru = IP6CB(skb)->frag_max_size;
+			cb.mru = IP6CB(skb)->frag_max_size;
 		}
 #else
 		err = -EOPNOTSUPP;
@@ -753,7 +764,7 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 	}
 
 	if (err != -EINPROGRESS)
-		tc_skb_cb(skb)->mru = mru;
+		*tc_skb_cb(skb) = cb;
 	skb_clear_hash(skb);
 	skb->ignore_df = 1;
 	return err;
@@ -961,6 +972,7 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	struct nf_hook_state state;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
+	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
 	struct nf_conn *ct;
@@ -997,9 +1009,18 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 */
 	nh_ofs = skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
-	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
-	if (err)
+	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag,
+				      &skb_is_ours);
+	if (err) {
+		/* The skb is still ours only when the header checks rejected
+		 * it; returning TC_ACT_CONSUMED for such a packet would leak
+		 * it, since no caller frees an skb it was told it no longer
+		 * owns.
+		 */
+		if (skb_is_ours)
+			goto drop;
 		goto out_frag;
+	}
 
 	err = tcf_ct_skb_network_trim(skb, family);
 	if (err)
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c9f7e793a375..c67d95a078f7 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -410,12 +410,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *r, __u32 *rtab)
 }
 
 static struct qdisc_rate_table *qdisc_rtab_list;
+static DEFINE_SPINLOCK(qdisc_rtab_lock);
 
 struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 					struct nlattr *tab,
 					struct netlink_ext_ack *extack)
 {
-	struct qdisc_rate_table *rtab;
+	struct qdisc_rate_table *rtab, *new_rtab;
 
 	if (tab == NULL || r->rate == 0 ||
 	    r->cell_log == 0 || r->cell_log >= 32 ||
@@ -424,15 +425,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 		return NULL;
 	}
 
+	new_rtab = kmalloc(sizeof(*new_rtab), GFP_KERNEL);
+
+	spin_lock(&qdisc_rtab_lock);
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
 		    !memcmp(&rtab->data, nla_data(tab), 1024)) {
 			rtab->refcnt++;
+			spin_unlock(&qdisc_rtab_lock);
+			kfree(new_rtab);
 			return rtab;
 		}
 	}
 
-	rtab = kmalloc(sizeof(*rtab), GFP_KERNEL);
+	rtab = new_rtab;
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
@@ -444,6 +450,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	} else {
 		NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate table");
 	}
+	spin_unlock(&qdisc_rtab_lock);
 	return rtab;
 }
 EXPORT_SYMBOL(qdisc_get_rtab);
@@ -452,18 +459,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
 {
 	struct qdisc_rate_table *rtab, **rtabp;
 
-	if (!tab || --tab->refcnt)
+	if (!tab)
 		return;
 
+	spin_lock(&qdisc_rtab_lock);
+	if (--tab->refcnt) {
+		spin_unlock(&qdisc_rtab_lock);
+		return;
+	}
+
 	for (rtabp = &qdisc_rtab_list;
 	     (rtab = *rtabp) != NULL;
 	     rtabp = &rtab->next) {
 		if (rtab == tab) {
 			*rtabp = rtab->next;
-			kfree(rtab);
-			return;
+			break;
 		}
 	}
+	spin_unlock(&qdisc_rtab_lock);
+	kfree(tab);
 }
 EXPORT_SYMBOL(qdisc_put_rtab);
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d94c9c11ac1e..367ee5737705 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1269,7 +1269,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    iph_check->daddr != iph->daddr)
 				continue;
 
-			seglen = ntohs(iph_check->tot_len) -
+			seglen = iph_totlen(skb, iph_check) -
 				       (4 * iph_check->ihl);
 		} else if (iph_check->version == 6) {
 			ipv6h = (struct ipv6hdr *)iph;
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8e7c0a3034cc..32521be54c6e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -557,12 +557,8 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	if (unlikely(!child))
 		return NULL;
 
-	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
-		if (!skb)
-			return NULL;
-		goto skb_found;
-	}
+	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
+		goto skip_peek_checks;
 
 	skb = child->ops->peek(child);
 	if (!skb)
@@ -589,11 +585,11 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
-	skb = child->ops->dequeue(child);
+skip_peek_checks:
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-skb_found:
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 9987decdead2..b5102cd7b42a 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1386,10 +1386,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	/* Initialize maximum autoclose timeout. */
 	net->sctp.max_autoclose		= INT_MAX / HZ;
 
-	status = sctp_sysctl_net_register(net);
-	if (status)
-		goto err_sysctl_register;
-
 	/* Allocate and initialise sctp mibs.  */
 	status = init_sctp_mibs(net);
 	if (status)
@@ -1423,8 +1419,6 @@ static int __net_init sctp_defaults_init(struct net *net)
 	cleanup_sctp_mibs(net);
 #endif
 err_init_mibs:
-	sctp_sysctl_net_unregister(net);
-err_sysctl_register:
 	return status;
 }
 
@@ -1439,7 +1433,6 @@ static void __net_exit sctp_defaults_exit(struct net *net)
 	net->sctp.proc_net_sctp = NULL;
 #endif
 	cleanup_sctp_mibs(net);
-	sctp_sysctl_net_unregister(net);
 }
 
 static struct pernet_operations sctp_defaults_ops = {
@@ -1453,16 +1446,27 @@ static int __net_init sctp_ctrlsock_init(struct net *net)
 
 	/* Initialize the control inode/socket for handling OOTB packets.  */
 	status = sctp_ctl_sock_init(net);
-	if (status)
+	if (status) {
 		pr_err("Failed to initialize the SCTP control sock\n");
+		return status;
+	}
+
+	status = sctp_sysctl_net_register(net);
+	if (status) {
+		inet_ctl_sock_destroy(net->sctp.ctl_sock);
+		net->sctp.ctl_sock = NULL;
+	}
 
 	return status;
 }
 
 static void __net_exit sctp_ctrlsock_exit(struct net *net)
 {
+	sctp_sysctl_net_unregister(net);
+
 	/* Free the control endpoint.  */
 	inet_ctl_sock_destroy(net->sctp.ctl_sock);
+	net->sctp.ctl_sock = NULL;
 }
 
 static struct pernet_operations sctp_ctrlsock_ops = {
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index f3d09998c24d..2e99de0aeea6 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -617,11 +617,16 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
+	struct ctl_table_header *header = net->sctp.sysctl_header;
 	struct ctl_table *table;
 
-	table = net->sctp.sysctl_header->ctl_table_arg;
-	unregister_net_sysctl_table(net->sctp.sysctl_header);
+	if (!header)
+		return;
+
+	table = header->ctl_table_arg;
+	unregister_net_sysctl_table(header);
 	kfree(table);
+	net->sctp.sysctl_header = NULL;
 }
 
 static struct ctl_table_header *sctp_sysctl_header;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7bbb59e170a6..fe014abcfa4f 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1107,7 +1107,8 @@ smc_v2_determine_accepted_chid(struct smc_clc_msg_accept_confirm_v2 *aclc,
 	int i;
 
 	for (i = 0; i < ini->ism_offered_cnt + 1; i++) {
-		if (ini->ism_chid[i] == ntohs(aclc->chid)) {
+		if (ini->ism_dev[i] &&
+			ini->ism_chid[i] == ntohs(aclc->chid)) {
 			ini->ism_selected = i;
 			return 0;
 		}
diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index 3468c58bbeeb..33b5bcafdec7 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -145,7 +145,12 @@ static const struct pipe_buf_operations smc_pipe_ops = {
 static void smc_rx_spd_release(struct splice_pipe_desc *spd,
 			       unsigned int i)
 {
+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
+	struct sock *sk = &priv->smc->sk;
+
+	kfree(priv);
 	put_page(spd->pages[i]);
+	sock_put(sk);
 }
 
 static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
@@ -165,6 +170,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	partial.len = len;
 	partial.private = (unsigned long)priv;
 
+	get_page(smc->conn.rmb_desc->pages);
+	sock_hold(&smc->sk);
 	spd.nr_pages_max = 1;
 	spd.nr_pages = 1;
 	spd.pages = &smc->conn.rmb_desc->pages;
@@ -173,11 +180,8 @@ static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
 	spd.spd_release = smc_rx_spd_release;
 
 	bytes = splice_to_pipe(pipe, &spd);
-	if (bytes > 0) {
-		sock_hold(&smc->sk);
-		get_page(smc->conn.rmb_desc->pages);
+	if (bytes > 0)
 		atomic_add(bytes, &smc->conn.splice_pending);
-	}
 
 	return bytes;
 }
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index a878ea084dbd..eb03fd0f6dc8 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -333,12 +333,20 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 	int rc;
 
 	for (dstchunk = 0; dstchunk < 2; dstchunk++) {
-		struct ib_sge *sge =
-			wr_rdma_buf->wr_tx_rdma[dstchunk].wr.sg_list;
+		struct ib_rdma_wr *wr = &wr_rdma_buf->wr_tx_rdma[dstchunk];
+		struct ib_sge *sge = wr->wr.sg_list;
+		u64 base_addr = dma_addr;
+
+		if (dst_len < link->qp_attr.cap.max_inline_data) {
+			base_addr = (uintptr_t)conn->sndbuf_desc->cpu_addr;
+			wr->wr.send_flags |= IB_SEND_INLINE;
+		} else {
+			wr->wr.send_flags &= ~IB_SEND_INLINE;
+		}
 
 		num_sges = 0;
 		for (srcchunk = 0; srcchunk < 2; srcchunk++) {
-			sge[srcchunk].addr = dma_addr + src_off;
+			sge[srcchunk].addr = base_addr + src_off;
 			sge[srcchunk].length = src_len;
 			num_sges++;
 
@@ -352,8 +360,7 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 			src_len = dst_len - src_len; /* remainder */
 			src_len_sum += src_len;
 		}
-		rc = smc_tx_rdma_write(conn, dst_off, num_sges,
-				       &wr_rdma_buf->wr_tx_rdma[dstchunk]);
+		rc = smc_tx_rdma_write(conn, dst_off, num_sges, wr);
 		if (rc)
 			return rc;
 		if (dst_len_sum == len)
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 3cf9a81d2586..369c765a80e8 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2458,17 +2458,17 @@ static void tipc_sk_enqueue(struct sk_buff_head *inputq, struct sock *sk,
 			atomic_set(dcnt, 0);
 		lim = rcvbuf_limit(sk, skb) + atomic_read(dcnt);
 		if (likely(!sk_add_backlog(sk, skb, lim))) {
-			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_overlimit1(sk, skb, TIPC_DUMP_SK_BKLGQ,
 						 "bklg & rcvq >90% allocated!");
 			continue;
 		}
 
-		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_ALL, "err_overload!");
+		trace_tipc_sk_dump(sk, skb, TIPC_DUMP_SK_BKLGQ, "err_overload!");
 		/* Overload => reject message back to sender */
 		onode = tipc_own_addr(sock_net(sk));
 		atomic_inc(&sk->sk_drops);
 		if (tipc_msg_reverse(onode, &skb, TIPC_ERR_OVERLOAD)) {
-			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_ALL,
+			trace_tipc_sk_rej_msg(sk, skb, TIPC_DUMP_SK_BKLGQ,
 					      "@sk_enqueue!");
 			__skb_queue_tail(xmitq, skb);
 		}
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index cdc5b4bf5b43..2076f9b5bf3e 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -362,6 +362,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = from_timer(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -397,9 +398,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
 	if (sk_has_allocations(sk)) {
 		/* Defer: outstanding buffers */
-		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = x25_destroy_timer;
-		add_timer(&sk->sk_timer);
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + 10 * HZ);
 	} else {
 		/* drop last reference so sock_put will free */
 		__sock_put(sk);
diff --git a/net/x25/x25_timer.c b/net/x25/x25_timer.c
index 9376365cdcc9..2afa8ecaf509 100644
--- a/net/x25/x25_timer.c
+++ b/net/x25/x25_timer.c
@@ -36,45 +36,45 @@ void x25_init_timers(struct sock *sk)
 
 void x25_start_heartbeat(struct sock *sk)
 {
-	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void x25_stop_heartbeat(struct sock *sk)
 {
-	del_timer(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 void x25_start_t2timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t2);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t2);
 }
 
 void x25_start_t21timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t21);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t21);
 }
 
 void x25_start_t22timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t22);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t22);
 }
 
 void x25_start_t23timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t23);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t23);
 }
 
 void x25_stop_timer(struct sock *sk)
 {
-	del_timer(&x25_sk(sk)->timer);
+	sk_stop_timer(sk, &x25_sk(sk)->timer);
 }
 
 unsigned long x25_display_timer(struct sock *sk)
@@ -108,7 +108,7 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			     sock_flag(sk, SOCK_DEAD))) {
 				bh_unlock_sock(sk);
 				x25_destroy_socket_from_timer(sk);
-				return;
+				goto out;
 			}
 			break;
 
@@ -120,8 +120,14 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			break;
 	}
 restart_heartbeat:
-	x25_start_heartbeat(sk);
+	/* Do not rearm once __x25_destroy_socket() has unlinked the socket:
+	 * it is past its cancel point and owns the teardown from there on.
+	 */
+	if (sk_hashed(sk))
+		x25_start_heartbeat(sk);
 	bh_unlock_sock(sk);
+out:
+	sock_put(sk);
 }
 
 /*
@@ -166,4 +172,5 @@ static void x25_timer_expiry(struct timer_list *t)
 	} else
 		x25_do_timer_expiry(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 8b41f8654832..59247f0bd4e7 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -210,41 +210,21 @@ static int espintcp_sendskmsg_locked(struct sock *sk,
 {
 	struct sk_msg *skmsg = &emsg->skmsg;
 	struct scatterlist *sg;
-	int done = 0;
 	int ret;
 
 	flags |= MSG_SENDPAGE_NOTLAST;
-	sg = &skmsg->sg.data[skmsg->sg.start];
 	do {
-		size_t size = sg->length - emsg->offset;
-		int offset = sg->offset + emsg->offset;
-		struct page *p;
-
-		emsg->offset = 0;
-
+		sg = &skmsg->sg.data[skmsg->sg.start];
 		if (sg_is_last(sg))
 			flags &= ~MSG_SENDPAGE_NOTLAST;
 
-		p = sg_page(sg);
-retry:
-		ret = do_tcp_sendpages(sk, p, offset, size, flags);
-		if (ret < 0) {
-			emsg->offset = offset - sg->offset;
-			skmsg->sg.start += done;
+		ret = do_tcp_sendpages(sk, sg_page(sg), sg->offset,
+				       sg->length, flags);
+		if (ret < 0)
 			return ret;
-		}
-
-		if (ret != size) {
-			offset += ret;
-			size -= ret;
-			goto retry;
-		}
 
-		done++;
-		put_page(p);
-		sk_mem_uncharge(sk, sg->length);
-		sg = sg_next(sg);
-	} while (sg);
+		sk_msg_free_partial(sk, skmsg, ret);
+	} while (skmsg->sg.size);
 
 	memset(emsg, 0, sizeof(*emsg));
 
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index aadb4b29fb66..c3f9e6daca16 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,8 +51,12 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
 #define SOCK_ctx(X) SOCK_INODE(X)->i_security
+static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
+{
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
+}
+
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
 	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
 						  .family = (F)};	  \
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 6df909817993..afa19da69436 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -775,33 +775,15 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	return error;
 }
 
-/**
- * apparmor_sk_alloc_security - allocate and attach the sk_security field
- */
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	SK_CTX(sk) = ctx;
-
-	return 0;
-}
-
 /**
  * apparmor_sk_free_security - free the sk_security field
  */
 static void apparmor_sk_free_security(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	SK_CTX(sk) = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -810,8 +792,8 @@ static void apparmor_sk_free_security(struct sock *sk)
 static void apparmor_sk_clone_security(const struct sock *sk,
 				       struct sock *newsk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
-	struct aa_sk_ctx *new = SK_CTX(newsk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
+	struct aa_sk_ctx *new = aa_sock(newsk);
 
 	if (new->label)
 		aa_put_label(new->label);
@@ -867,7 +849,7 @@ static int apparmor_socket_post_create(struct socket *sock, int family,
 		label = aa_get_current_label();
 
 	if (sock->sk) {
-		struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
+		struct aa_sk_ctx *ctx = aa_sock(sock->sk);
 
 		aa_put_label(ctx->label);
 		ctx->label = aa_get_label(label);
@@ -1066,7 +1048,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
  */
 static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1086,7 +1068,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 static struct aa_label *sk_peer_label(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (ctx->peer)
 		return ctx->peer;
@@ -1170,7 +1152,7 @@ static int apparmor_socket_getpeersec_dgram(struct socket *sock,
  */
 static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!ctx->label)
 		ctx->label = aa_get_current_label();
@@ -1180,7 +1162,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1197,6 +1179,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_label *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1233,7 +1216,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
@@ -1785,7 +1767,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	if (sk == NULL)
 		return NF_ACCEPT;
 
-	ctx = SK_CTX(sk);
+	ctx = aa_sock(sk);
 	if (!apparmor_secmark_check(ctx->label, OP_SENDMSG, AA_MAY_SEND,
 				    skb->secmark, sk))
 		return NF_ACCEPT;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index d2925f431216..f52ddcea0bd0 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -6,6 +6,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/bpf_lsm.h>
 
+bool bpf_lsm_initialized __ro_after_init;
+
 static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
 	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
@@ -18,6 +20,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 static int __init bpf_lsm_init(void)
 {
 	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	bpf_lsm_initialized = true;
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 71f26f92df82..1daea0a94626 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -207,6 +208,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
@@ -343,6 +345,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 
@@ -734,14 +737,14 @@ static int lsm_superblock_alloc(struct super_block *sb)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
+#define call_int_hook(FUNC, ...) ({				\
+	int RC = LSM_RET_DEFAULT(FUNC);				\
 	do {							\
 		struct security_hook_list *P;			\
 								\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
 			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
+			if (RC != LSM_RET_DEFAULT(FUNC))	\
 				break;				\
 		}						\
 	} while (0);						\
@@ -752,35 +755,35 @@ static int lsm_superblock_alloc(struct super_block *sb)
 
 int security_binder_set_context_mgr(const struct cred *mgr)
 {
-	return call_int_hook(binder_set_context_mgr, 0, mgr);
+	return call_int_hook(binder_set_context_mgr, mgr);
 }
 
 int security_binder_transaction(const struct cred *from,
 				const struct cred *to)
 {
-	return call_int_hook(binder_transaction, 0, from, to);
+	return call_int_hook(binder_transaction, from, to);
 }
 
 int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to)
 {
-	return call_int_hook(binder_transfer_binder, 0, from, to);
+	return call_int_hook(binder_transfer_binder, from, to);
 }
 
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, struct file *file)
 {
-	return call_int_hook(binder_transfer_file, 0, from, to, file);
+	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-	return call_int_hook(ptrace_access_check, 0, child, mode);
+	return call_int_hook(ptrace_access_check, child, mode);
 }
 
 int security_ptrace_traceme(struct task_struct *parent)
 {
-	return call_int_hook(ptrace_traceme, 0, parent);
+	return call_int_hook(ptrace_traceme, parent);
 }
 
 int security_capget(struct task_struct *target,
@@ -788,7 +791,7 @@ int security_capget(struct task_struct *target,
 		     kernel_cap_t *inheritable,
 		     kernel_cap_t *permitted)
 {
-	return call_int_hook(capget, 0, target,
+	return call_int_hook(capget, target,
 				effective, inheritable, permitted);
 }
 
@@ -797,7 +800,7 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return call_int_hook(capset, 0, new, old,
+	return call_int_hook(capset, new, old,
 				effective, inheritable, permitted);
 }
 
@@ -806,27 +809,27 @@ int security_capable(const struct cred *cred,
 		     int cap,
 		     unsigned int opts)
 {
-	return call_int_hook(capable, 0, cred, ns, cap, opts);
+	return call_int_hook(capable, cred, ns, cap, opts);
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
-	return call_int_hook(quotactl, 0, cmds, type, id, sb);
+	return call_int_hook(quotactl, cmds, type, id, sb);
 }
 
 int security_quota_on(struct dentry *dentry)
 {
-	return call_int_hook(quota_on, 0, dentry);
+	return call_int_hook(quota_on, dentry);
 }
 
 int security_syslog(int type)
 {
-	return call_int_hook(syslog, 0, type);
+	return call_int_hook(syslog, type);
 }
 
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 {
-	return call_int_hook(settime, 0, ts, tz);
+	return call_int_hook(settime, ts, tz);
 }
 
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
@@ -854,19 +857,19 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 
 int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 {
-	return call_int_hook(bprm_creds_for_exec, 0, bprm);
+	return call_int_hook(bprm_creds_for_exec, bprm);
 }
 
 int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 {
-	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
+	return call_int_hook(bprm_creds_from_file, bprm, file);
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 
-	ret = call_int_hook(bprm_check_security, 0, bprm);
+	ret = call_int_hook(bprm_check_security, bprm);
 	if (ret)
 		return ret;
 	return ima_bprm_check(bprm);
@@ -884,7 +887,7 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
-	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+	return call_int_hook(fs_context_dup, fc, src_fc);
 }
 
 int security_fs_context_parse_param(struct fs_context *fc,
@@ -911,7 +914,7 @@ int security_sb_alloc(struct super_block *sb)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(sb_alloc_security, 0, sb);
+	rc = call_int_hook(sb_alloc_security, sb);
 	if (unlikely(rc))
 		security_sb_free(sb);
 	return rc;
@@ -940,53 +943,53 @@ EXPORT_SYMBOL(security_free_mnt_opts);
 
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
-	return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
+	return call_int_hook(sb_eat_lsm_opts, options, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
 int security_sb_mnt_opts_compat(struct super_block *sb,
 				void *mnt_opts)
 {
-	return call_int_hook(sb_mnt_opts_compat, 0, sb, mnt_opts);
+	return call_int_hook(sb_mnt_opts_compat, sb, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_mnt_opts_compat);
 
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
-	return call_int_hook(sb_remount, 0, sb, mnt_opts);
+	return call_int_hook(sb_remount, sb, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_remount);
 
 int security_sb_kern_mount(struct super_block *sb)
 {
-	return call_int_hook(sb_kern_mount, 0, sb);
+	return call_int_hook(sb_kern_mount, sb);
 }
 
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return call_int_hook(sb_show_options, 0, m, sb);
+	return call_int_hook(sb_show_options, m, sb);
 }
 
 int security_sb_statfs(struct dentry *dentry)
 {
-	return call_int_hook(sb_statfs, 0, dentry);
+	return call_int_hook(sb_statfs, dentry);
 }
 
 int security_sb_mount(const char *dev_name, const struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
-	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
+	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
 }
 
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return call_int_hook(sb_umount, 0, mnt, flags);
+	return call_int_hook(sb_umount, mnt, flags);
 }
 
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path)
 {
-	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
+	return call_int_hook(sb_pivotroot, old_path, new_path);
 }
 
 int security_sb_set_mnt_opts(struct super_block *sb,
@@ -994,9 +997,16 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				mnt_opts ? -EOPNOTSUPP : 0, sb,
-				mnt_opts, kern_flags, set_kern_flags);
+	struct security_hook_list *hp;
+	int rc = mnt_opts ? -EOPNOTSUPP : LSM_RET_DEFAULT(sb_set_mnt_opts);
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_set_mnt_opts, list) {
+		rc = hp->hook.sb_set_mnt_opts(sb, mnt_opts, kern_flags,
+					      set_kern_flags);
+		if (rc != LSM_RET_DEFAULT(sb_set_mnt_opts))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
@@ -1005,7 +1015,7 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
+	return call_int_hook(sb_clone_mnt_opts, oldsb, newsb,
 				kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
@@ -1013,20 +1023,27 @@ EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 int security_add_mnt_opt(const char *option, const char *val, int len,
 			 void **mnt_opts)
 {
-	return call_int_hook(sb_add_mnt_opt, -EINVAL,
-					option, val, len, mnt_opts);
+	struct security_hook_list *hp;
+	int rc = -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.sb_add_mnt_opt, list) {
+		rc = hp->hook.sb_add_mnt_opt(option, val, len, mnt_opts);
+		if (rc != LSM_RET_DEFAULT(sb_add_mnt_opt))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_add_mnt_opt);
 
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
-	return call_int_hook(move_mount, 0, from_path, to_path);
+	return call_int_hook(move_mount, from_path, to_path);
 }
 
 int security_path_notify(const struct path *path, u64 mask,
 				unsigned int obj_type)
 {
-	return call_int_hook(path_notify, 0, path, mask, obj_type);
+	return call_int_hook(path_notify, path, mask, obj_type);
 }
 
 int security_inode_alloc(struct inode *inode)
@@ -1035,7 +1052,7 @@ int security_inode_alloc(struct inode *inode)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(inode_alloc_security, 0, inode);
+	rc = call_int_hook(inode_alloc_security, inode);
 	if (unlikely(rc))
 		security_inode_free(inode);
 	return rc;
@@ -1071,8 +1088,17 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+	int rc = -EOPNOTSUPP;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		rc = hp->hook.dentry_init_security(dentry, mode, name, ctx,
+						   ctxlen);
+		if (rc != LSM_RET_DEFAULT(dentry_init_security))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
@@ -1080,7 +1106,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 				    struct qstr *name,
 				    const struct cred *old, struct cred *new)
 {
-	return call_int_hook(dentry_create_files_as, 0, dentry, mode,
+	return call_int_hook(dentry_create_files_as, dentry, mode,
 				name, old, new);
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
@@ -1091,20 +1117,34 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs) {
+		ret = -EOPNOTSUPP;
+		hlist_for_each_entry(hp, &security_hook_heads.inode_init_security,
+				     list) {
+			ret = hp->hook.inode_init_security(inode, dir, qstr,
+							   NULL, NULL, NULL);
+			if (ret != LSM_RET_DEFAULT(inode_init_security))
+				break;
+		}
+		return ret;
+	}
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
+	ret = -EOPNOTSUPP;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security, list) {
+		ret = hp->hook.inode_init_security(inode, dir, qstr,
+						   &lsm_xattr->name,
+						   &lsm_xattr->value,
+						   &lsm_xattr->value_len);
+		if (ret != LSM_RET_DEFAULT(inode_init_security))
+			break;
+	}
 	if (ret)
 		goto out;
 
@@ -1124,7 +1164,7 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode)
 {
-	return call_int_hook(inode_init_security_anon, 0, inode, name,
+	return call_int_hook(inode_init_security_anon, inode, name,
 			     context_inode);
 }
 
@@ -1132,10 +1172,19 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct security_hook_list *hp;
+	int rc = -EOPNOTSUPP;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir,
-			     qstr, name, value, len);
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_init_security, list) {
+		rc = hp->hook.inode_init_security(inode, dir, qstr, name, value,
+						  len);
+		if (rc != LSM_RET_DEFAULT(inode_init_security))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
@@ -1145,7 +1194,7 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t m
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(path_mknod, dir, dentry, mode, dev);
 }
 EXPORT_SYMBOL(security_path_mknod);
 
@@ -1153,7 +1202,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(path_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
@@ -1161,14 +1210,14 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_rmdir, 0, dir, dentry);
+	return call_int_hook(path_rmdir, dir, dentry);
 }
 
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_unlink, 0, dir, dentry);
+	return call_int_hook(path_unlink, dir, dentry);
 }
 EXPORT_SYMBOL(security_path_unlink);
 
@@ -1177,7 +1226,7 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
-	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(path_symlink, dir, dentry, old_name);
 }
 
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
@@ -1185,7 +1234,7 @@ int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
+	return call_int_hook(path_link, old_dentry, new_dir, new_dentry);
 }
 
 int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
@@ -1197,13 +1246,13 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(path_rename, 0, new_dir, new_dentry,
+		int err = call_int_hook(path_rename, new_dir, new_dentry,
 					old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
+	return call_int_hook(path_rename, old_dir, old_dentry, new_dir,
 				new_dentry);
 }
 EXPORT_SYMBOL(security_path_rename);
@@ -1212,26 +1261,26 @@ int security_path_truncate(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_truncate, 0, path);
+	return call_int_hook(path_truncate, path);
 }
 
 int security_path_chmod(const struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chmod, 0, path, mode);
+	return call_int_hook(path_chmod, path, mode);
 }
 
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(path_chown, 0, path, uid, gid);
+	return call_int_hook(path_chown, path, uid, gid);
 }
 
 int security_path_chroot(const struct path *path)
 {
-	return call_int_hook(path_chroot, 0, path);
+	return call_int_hook(path_chroot, path);
 }
 #endif
 
@@ -1239,7 +1288,7 @@ int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_create, 0, dir, dentry, mode);
+	return call_int_hook(inode_create, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
@@ -1248,14 +1297,14 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
-	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
+	return call_int_hook(inode_link, old_dentry, dir, new_dentry);
 }
 
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_unlink, 0, dir, dentry);
+	return call_int_hook(inode_unlink, dir, dentry);
 }
 
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
@@ -1263,14 +1312,14 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_symlink, 0, dir, dentry, old_name);
+	return call_int_hook(inode_symlink, dir, dentry, old_name);
 }
 
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mkdir, 0, dir, dentry, mode);
+	return call_int_hook(inode_mkdir, dir, dentry, mode);
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
@@ -1278,14 +1327,14 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_rmdir, 0, dir, dentry);
+	return call_int_hook(inode_rmdir, dir, dentry);
 }
 
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return call_int_hook(inode_mknod, 0, dir, dentry, mode, dev);
+	return call_int_hook(inode_mknod, dir, dentry, mode, dev);
 }
 
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -1297,13 +1346,13 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
-		int err = call_int_hook(inode_rename, 0, new_dir, new_dentry,
+		int err = call_int_hook(inode_rename, new_dir, new_dentry,
 						     old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
-	return call_int_hook(inode_rename, 0, old_dir, old_dentry,
+	return call_int_hook(inode_rename, old_dir, old_dentry,
 					   new_dir, new_dentry);
 }
 
@@ -1311,7 +1360,7 @@ int security_inode_readlink(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_readlink, 0, dentry);
+	return call_int_hook(inode_readlink, dentry);
 }
 
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
@@ -1319,14 +1368,14 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_follow_link, 0, dentry, inode, rcu);
+	return call_int_hook(inode_follow_link, dentry, inode, rcu);
 }
 
 int security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_permission, 0, inode, mask);
+	return call_int_hook(inode_permission, inode, mask);
 }
 
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
@@ -1335,7 +1384,7 @@ int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	ret = call_int_hook(inode_setattr, 0, dentry, attr);
+	ret = call_int_hook(inode_setattr, dentry, attr);
 	if (ret)
 		return ret;
 	return evm_inode_setattr(dentry, attr);
@@ -1346,13 +1395,14 @@ int security_inode_getattr(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
 		return 0;
-	return call_int_hook(inode_getattr, 0, path);
+	return call_int_hook(inode_getattr, path);
 }
 
 int security_inode_setxattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1361,8 +1411,13 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, mnt_userns, dentry, name, value,
-			    size, flags);
+	ret = 1;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		ret = hp->hook.inode_setxattr(mnt_userns, dentry, name, value,
+					      size, flags);
+		if (ret != LSM_RET_DEFAULT(inode_setxattr))
+			break;
+	}
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
@@ -1387,19 +1442,20 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_getxattr, 0, dentry, name);
+	return call_int_hook(inode_getxattr, dentry, name);
 }
 
 int security_inode_listxattr(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_listxattr, 0, dentry);
+	return call_int_hook(inode_listxattr, dentry);
 }
 
 int security_inode_removexattr(struct user_namespace *mnt_userns,
 			       struct dentry *dentry, const char *name)
 {
+	struct security_hook_list *hp;
 	int ret;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1408,7 +1464,12 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
+	ret = 1;
+	hlist_for_each_entry(hp, &security_hook_heads.inode_removexattr, list) {
+		ret = hp->hook.inode_removexattr(mnt_userns, dentry, name);
+		if (ret != LSM_RET_DEFAULT(inode_removexattr))
+			break;
+	}
 	if (ret == 1)
 		ret = cap_inode_removexattr(mnt_userns, dentry, name);
 	if (ret)
@@ -1421,13 +1482,13 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return call_int_hook(inode_need_killpriv, 0, dentry);
+	return call_int_hook(inode_need_killpriv, dentry);
 }
 
 int security_inode_killpriv(struct user_namespace *mnt_userns,
 			    struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, mnt_userns, dentry);
+	return call_int_hook(inode_killpriv, mnt_userns, dentry);
 }
 
 int security_inode_getsecurity(struct user_namespace *mnt_userns,
@@ -1473,7 +1534,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return call_int_hook(inode_listsecurity, 0, inode, buffer, buffer_size);
+	return call_int_hook(inode_listsecurity, inode, buffer, buffer_size);
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
@@ -1484,7 +1545,7 @@ void security_inode_getsecid(struct inode *inode, u32 *secid)
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	return call_int_hook(inode_copy_up, 0, src, new);
+	return call_int_hook(inode_copy_up, src, new);
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
@@ -1512,14 +1573,14 @@ EXPORT_SYMBOL(security_inode_copy_up_xattr);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn)
 {
-	return call_int_hook(kernfs_init_security, 0, kn_dir, kn);
+	return call_int_hook(kernfs_init_security, kn_dir, kn);
 }
 
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
 
-	ret = call_int_hook(file_permission, 0, file, mask);
+	ret = call_int_hook(file_permission, file, mask);
 	if (ret)
 		return ret;
 
@@ -1532,7 +1593,7 @@ int security_file_alloc(struct file *file)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(file_alloc_security, 0, file);
+	rc = call_int_hook(file_alloc_security, file);
 	if (unlikely(rc))
 		security_file_free(file);
 	return rc;
@@ -1553,7 +1614,7 @@ void security_file_free(struct file *file)
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_ioctl, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
@@ -1571,7 +1632,7 @@ EXPORT_SYMBOL_GPL(security_file_ioctl);
 int security_file_ioctl_compat(struct file *file, unsigned int cmd,
 			       unsigned long arg)
 {
-	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+	return call_int_hook(file_ioctl_compat, file, cmd, arg);
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
 
@@ -1614,7 +1675,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 	unsigned long prot_adj = mmap_prot(file, prot);
 	int ret;
 
-	ret = call_int_hook(mmap_file, 0, file, prot, prot_adj, flags);
+	ret = call_int_hook(mmap_file, file, prot, prot_adj, flags);
 	if (ret)
 		return ret;
 	return ima_file_mmap(file, prot, prot_adj, flags);
@@ -1622,7 +1683,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
 
 int security_mmap_addr(unsigned long addr)
 {
-	return call_int_hook(mmap_addr, 0, addr);
+	return call_int_hook(mmap_addr, addr);
 }
 
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
@@ -1630,7 +1691,7 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 {
 	int ret;
 
-	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
+	ret = call_int_hook(file_mprotect, vma, reqprot, prot);
 	if (ret)
 		return ret;
 	return ima_file_mprotect(vma, prot);
@@ -1638,12 +1699,12 @@ int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return call_int_hook(file_lock, 0, file, cmd);
+	return call_int_hook(file_lock, file, cmd);
 }
 
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return call_int_hook(file_fcntl, 0, file, cmd, arg);
+	return call_int_hook(file_fcntl, file, cmd, arg);
 }
 
 void security_file_set_fowner(struct file *file)
@@ -1654,19 +1715,19 @@ void security_file_set_fowner(struct file *file)
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
-	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
+	return call_int_hook(file_send_sigiotask, tsk, fown, sig);
 }
 
 int security_file_receive(struct file *file)
 {
-	return call_int_hook(file_receive, 0, file);
+	return call_int_hook(file_receive, file);
 }
 
 int security_file_open(struct file *file)
 {
 	int ret;
 
-	ret = call_int_hook(file_open, 0, file);
+	ret = call_int_hook(file_open, file);
 	if (ret)
 		return ret;
 
@@ -1679,7 +1740,7 @@ int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 
 	if (rc)
 		return rc;
-	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	rc = call_int_hook(task_alloc, task, clone_flags);
 	if (unlikely(rc))
 		security_task_free(task);
 	return rc;
@@ -1700,7 +1761,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	rc = call_int_hook(cred_alloc_blank, cred, gfp);
 	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
@@ -1728,7 +1789,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 	if (rc)
 		return rc;
 
-	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+	rc = call_int_hook(cred_prepare, new, old, gfp);
 	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
@@ -1748,19 +1809,19 @@ EXPORT_SYMBOL(security_cred_getsecid);
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	return call_int_hook(kernel_act_as, new, secid);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return call_int_hook(kernel_create_files_as, 0, new, inode);
+	return call_int_hook(kernel_create_files_as, new, inode);
 }
 
 int security_kernel_module_request(char *kmod_name)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_module_request, 0, kmod_name);
+	ret = call_int_hook(kernel_module_request, kmod_name);
 	if (ret)
 		return ret;
 	return integrity_kernel_module_request(kmod_name);
@@ -1771,7 +1832,7 @@ int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
+	ret = call_int_hook(kernel_read_file, file, id, contents);
 	if (ret)
 		return ret;
 	return ima_read_file(file, id, contents);
@@ -1783,7 +1844,7 @@ int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
+	ret = call_int_hook(kernel_post_read_file, file, buf, size, id);
 	if (ret)
 		return ret;
 	return ima_post_read_file(file, buf, size, id);
@@ -1794,7 +1855,7 @@ int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_load_data, 0, id, contents);
+	ret = call_int_hook(kernel_load_data, id, contents);
 	if (ret)
 		return ret;
 	return ima_load_data(id, contents);
@@ -1807,7 +1868,7 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 {
 	int ret;
 
-	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
+	ret = call_int_hook(kernel_post_load_data, buf, size, id,
 			    description);
 	if (ret)
 		return ret;
@@ -1818,28 +1879,28 @@ EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return call_int_hook(task_fix_setuid, 0, new, old, flags);
+	return call_int_hook(task_fix_setuid, new, old, flags);
 }
 
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
 				 int flags)
 {
-	return call_int_hook(task_fix_setgid, 0, new, old, flags);
+	return call_int_hook(task_fix_setgid, new, old, flags);
 }
 
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return call_int_hook(task_setpgid, 0, p, pgid);
+	return call_int_hook(task_setpgid, p, pgid);
 }
 
 int security_task_getpgid(struct task_struct *p)
 {
-	return call_int_hook(task_getpgid, 0, p);
+	return call_int_hook(task_getpgid, p);
 }
 
 int security_task_getsid(struct task_struct *p)
 {
-	return call_int_hook(task_getsid, 0, p);
+	return call_int_hook(task_getsid, p);
 }
 
 void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
@@ -1858,50 +1919,50 @@ EXPORT_SYMBOL(security_task_getsecid_obj);
 
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return call_int_hook(task_setnice, 0, p, nice);
+	return call_int_hook(task_setnice, p, nice);
 }
 
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return call_int_hook(task_setioprio, 0, p, ioprio);
+	return call_int_hook(task_setioprio, p, ioprio);
 }
 
 int security_task_getioprio(struct task_struct *p)
 {
-	return call_int_hook(task_getioprio, 0, p);
+	return call_int_hook(task_getioprio, p);
 }
 
 int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
 			  unsigned int flags)
 {
-	return call_int_hook(task_prlimit, 0, cred, tcred, flags);
+	return call_int_hook(task_prlimit, cred, tcred, flags);
 }
 
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
-	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
+	return call_int_hook(task_setrlimit, p, resource, new_rlim);
 }
 
 int security_task_setscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_setscheduler, 0, p);
+	return call_int_hook(task_setscheduler, p);
 }
 
 int security_task_getscheduler(struct task_struct *p)
 {
-	return call_int_hook(task_getscheduler, 0, p);
+	return call_int_hook(task_getscheduler, p);
 }
 
 int security_task_movememory(struct task_struct *p)
 {
-	return call_int_hook(task_movememory, 0, p);
+	return call_int_hook(task_movememory, p);
 }
 
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 			int sig, const struct cred *cred)
 {
-	return call_int_hook(task_kill, 0, p, info, sig, cred);
+	return call_int_hook(task_kill, p, info, sig, cred);
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1929,7 +1990,7 @@ void security_task_to_inode(struct task_struct *p, struct inode *inode)
 
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return call_int_hook(ipc_permission, 0, ipcp, flag);
+	return call_int_hook(ipc_permission, ipcp, flag);
 }
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
@@ -1944,7 +2005,7 @@ int security_msg_msg_alloc(struct msg_msg *msg)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_msg_alloc_security, 0, msg);
+	rc = call_int_hook(msg_msg_alloc_security, msg);
 	if (unlikely(rc))
 		security_msg_msg_free(msg);
 	return rc;
@@ -1963,7 +2024,7 @@ int security_msg_queue_alloc(struct kern_ipc_perm *msq)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(msg_queue_alloc_security, 0, msq);
+	rc = call_int_hook(msg_queue_alloc_security, msq);
 	if (unlikely(rc))
 		security_msg_queue_free(msq);
 	return rc;
@@ -1978,24 +2039,24 @@ void security_msg_queue_free(struct kern_ipc_perm *msq)
 
 int security_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
 {
-	return call_int_hook(msg_queue_associate, 0, msq, msqflg);
+	return call_int_hook(msg_queue_associate, msq, msqflg);
 }
 
 int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
 {
-	return call_int_hook(msg_queue_msgctl, 0, msq, cmd);
+	return call_int_hook(msg_queue_msgctl, msq, cmd);
 }
 
 int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
 			       struct msg_msg *msg, int msqflg)
 {
-	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
+	return call_int_hook(msg_queue_msgsnd, msq, msg, msqflg);
 }
 
 int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
-	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
+	return call_int_hook(msg_queue_msgrcv, msq, msg, target, type, mode);
 }
 
 int security_shm_alloc(struct kern_ipc_perm *shp)
@@ -2004,7 +2065,7 @@ int security_shm_alloc(struct kern_ipc_perm *shp)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(shm_alloc_security, 0, shp);
+	rc = call_int_hook(shm_alloc_security, shp);
 	if (unlikely(rc))
 		security_shm_free(shp);
 	return rc;
@@ -2019,17 +2080,17 @@ void security_shm_free(struct kern_ipc_perm *shp)
 
 int security_shm_associate(struct kern_ipc_perm *shp, int shmflg)
 {
-	return call_int_hook(shm_associate, 0, shp, shmflg);
+	return call_int_hook(shm_associate, shp, shmflg);
 }
 
 int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
 {
-	return call_int_hook(shm_shmctl, 0, shp, cmd);
+	return call_int_hook(shm_shmctl, shp, cmd);
 }
 
 int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
 {
-	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
+	return call_int_hook(shm_shmat, shp, shmaddr, shmflg);
 }
 
 int security_sem_alloc(struct kern_ipc_perm *sma)
@@ -2038,7 +2099,7 @@ int security_sem_alloc(struct kern_ipc_perm *sma)
 
 	if (unlikely(rc))
 		return rc;
-	rc = call_int_hook(sem_alloc_security, 0, sma);
+	rc = call_int_hook(sem_alloc_security, sma);
 	if (unlikely(rc))
 		security_sem_free(sma);
 	return rc;
@@ -2053,18 +2114,18 @@ void security_sem_free(struct kern_ipc_perm *sma)
 
 int security_sem_associate(struct kern_ipc_perm *sma, int semflg)
 {
-	return call_int_hook(sem_associate, 0, sma, semflg);
+	return call_int_hook(sem_associate, sma, semflg);
 }
 
 int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
 {
-	return call_int_hook(sem_semctl, 0, sma, cmd);
+	return call_int_hook(sem_semctl, sma, cmd);
 }
 
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
+	return call_int_hook(sem_semop, sma, sops, nsops, alter);
 }
 
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -2103,12 +2164,12 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(netlink_send, 0, sk, skb);
+	return call_int_hook(netlink_send, sk, skb);
 }
 
 int security_ismaclabel(const char *name)
 {
-	return call_int_hook(ismaclabel, 0, name);
+	return call_int_hook(ismaclabel, name);
 }
 EXPORT_SYMBOL(security_ismaclabel);
 
@@ -2134,7 +2195,7 @@ EXPORT_SYMBOL(security_secid_to_secctx);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
 	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	return call_int_hook(secctx_to_secid, secdata, seclen, secid);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
@@ -2152,13 +2213,13 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	return call_int_hook(inode_notifysecctx, inode, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	return call_int_hook(inode_setsecctx, dentry, ctx, ctxlen);
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
@@ -2185,14 +2246,14 @@ int security_post_notification(const struct cred *w_cred,
 			       const struct cred *cred,
 			       struct watch_notification *n)
 {
-	return call_int_hook(post_notification, 0, w_cred, cred, n);
+	return call_int_hook(post_notification, w_cred, cred, n);
 }
 #endif /* CONFIG_WATCH_QUEUE */
 
 #ifdef CONFIG_KEY_NOTIFICATIONS
 int security_watch_key(struct key *key)
 {
-	return call_int_hook(watch_key, 0, key);
+	return call_int_hook(watch_key, key);
 }
 #endif
 
@@ -2200,118 +2261,177 @@ int security_watch_key(struct key *key)
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
-	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
+	return call_int_hook(unix_stream_connect, sock, other, newsk);
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return call_int_hook(unix_may_send, 0, sock, other);
+	return call_int_hook(unix_may_send, sock, other);
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return call_int_hook(socket_create, 0, family, type, protocol, kern);
+	return call_int_hook(socket_create, family, type, protocol, kern);
 }
 
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return call_int_hook(socket_post_create, 0, sock, family, type,
+	return call_int_hook(socket_post_create, sock, family, type,
 						protocol, kern);
 }
 
 int security_socket_socketpair(struct socket *socka, struct socket *sockb)
 {
-	return call_int_hook(socket_socketpair, 0, socka, sockb);
+	return call_int_hook(socket_socketpair, socka, sockb);
 }
 EXPORT_SYMBOL(security_socket_socketpair);
 
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_bind, 0, sock, address, addrlen);
+	return call_int_hook(socket_bind, sock, address, addrlen);
 }
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
+	return call_int_hook(socket_connect, sock, address, addrlen);
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return call_int_hook(socket_listen, 0, sock, backlog);
+	return call_int_hook(socket_listen, sock, backlog);
 }
 
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return call_int_hook(socket_accept, 0, sock, newsock);
+	return call_int_hook(socket_accept, sock, newsock);
 }
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
+	return call_int_hook(socket_sendmsg, sock, msg, size);
 }
 
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return call_int_hook(socket_recvmsg, 0, sock, msg, size, flags);
+	return call_int_hook(socket_recvmsg, sock, msg, size, flags);
 }
 
 int security_socket_getsockname(struct socket *sock)
 {
-	return call_int_hook(socket_getsockname, 0, sock);
+	return call_int_hook(socket_getsockname, sock);
 }
 
 int security_socket_getpeername(struct socket *sock)
 {
-	return call_int_hook(socket_getpeername, 0, sock);
+	return call_int_hook(socket_getpeername, sock);
 }
 
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_getsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_getsockopt, sock, level, optname);
 }
 
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return call_int_hook(socket_setsockopt, 0, sock, level, optname);
+	return call_int_hook(socket_setsockopt, sock, level, optname);
 }
 
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return call_int_hook(socket_shutdown, 0, sock, how);
+	return call_int_hook(socket_shutdown, sock, how);
 }
 
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return call_int_hook(socket_sock_rcv_skb, 0, sk, skb);
+	return call_int_hook(socket_sock_rcv_skb, sk, skb);
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list) {
+		rc = hp->hook.socket_getpeersec_stream(sock, optval, optlen,
+						       len);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_stream))
+			break;
+	}
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb, secid);
+		if (rc != LSM_RET_DEFAULT(socket_getpeersec_dgram))
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
+/**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * security_sk_alloc() - Allocate and initialize a sock's LSM blob
+ * @sk: sock
+ * @family: protocol family
+ * @priority: gfp flags
+ *
+ * Allocate and attach a security structure to the sk->sk_security field, which
+ * is used to copy security attributes between local stream sockets.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
@@ -2342,7 +2462,7 @@ EXPORT_SYMBOL(security_sock_graft);
 int security_inet_conn_request(const struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
-	return call_int_hook(inet_conn_request, 0, sk, skb, req);
+	return call_int_hook(inet_conn_request, sk, skb, req);
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
@@ -2361,7 +2481,7 @@ EXPORT_SYMBOL(security_inet_conn_established);
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return call_int_hook(secmark_relabel_packet, 0, secid);
+	return call_int_hook(secmark_relabel_packet, secid);
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2379,7 +2499,7 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
 
 int security_tun_dev_alloc_security(void **security)
 {
-	return call_int_hook(tun_dev_alloc_security, 0, security);
+	return call_int_hook(tun_dev_alloc_security, security);
 }
 EXPORT_SYMBOL(security_tun_dev_alloc_security);
 
@@ -2391,38 +2511,38 @@ EXPORT_SYMBOL(security_tun_dev_free_security);
 
 int security_tun_dev_create(void)
 {
-	return call_int_hook(tun_dev_create, 0);
+	return call_int_hook(tun_dev_create);
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
 int security_tun_dev_attach_queue(void *security)
 {
-	return call_int_hook(tun_dev_attach_queue, 0, security);
+	return call_int_hook(tun_dev_attach_queue, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach_queue);
 
 int security_tun_dev_attach(struct sock *sk, void *security)
 {
-	return call_int_hook(tun_dev_attach, 0, sk, security);
+	return call_int_hook(tun_dev_attach, sk, security);
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
 int security_tun_dev_open(void *security)
 {
-	return call_int_hook(tun_dev_open, 0, security);
+	return call_int_hook(tun_dev_open, security);
 }
 EXPORT_SYMBOL(security_tun_dev_open);
 
 int security_sctp_assoc_request(struct sctp_endpoint *ep, struct sk_buff *skb)
 {
-	return call_int_hook(sctp_assoc_request, 0, ep, skb);
+	return call_int_hook(sctp_assoc_request, ep, skb);
 }
 EXPORT_SYMBOL(security_sctp_assoc_request);
 
 int security_sctp_bind_connect(struct sock *sk, int optname,
 			       struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(sctp_bind_connect, 0, sk, optname,
+	return call_int_hook(sctp_bind_connect, sk, optname,
 			     address, addrlen);
 }
 EXPORT_SYMBOL(security_sctp_bind_connect);
@@ -2440,19 +2560,19 @@ EXPORT_SYMBOL(security_sctp_sk_clone);
 
 int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
 {
-	return call_int_hook(ib_pkey_access, 0, sec, subnet_prefix, pkey);
+	return call_int_hook(ib_pkey_access, sec, subnet_prefix, pkey);
 }
 EXPORT_SYMBOL(security_ib_pkey_access);
 
 int security_ib_endport_manage_subnet(void *sec, const char *dev_name, u8 port_num)
 {
-	return call_int_hook(ib_endport_manage_subnet, 0, sec, dev_name, port_num);
+	return call_int_hook(ib_endport_manage_subnet, sec, dev_name, port_num);
 }
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
 int security_ib_alloc_security(void **sec)
 {
-	return call_int_hook(ib_alloc_security, 0, sec);
+	return call_int_hook(ib_alloc_security, sec);
 }
 EXPORT_SYMBOL(security_ib_alloc_security);
 
@@ -2469,14 +2589,14 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
 {
-	return call_int_hook(xfrm_policy_alloc_security, 0, ctxp, sec_ctx, gfp);
+	return call_int_hook(xfrm_policy_alloc_security, ctxp, sec_ctx, gfp);
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
+	return call_int_hook(xfrm_policy_clone_security, old_ctx, new_ctxp);
 }
 
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
@@ -2487,25 +2607,25 @@ EXPORT_SYMBOL(security_xfrm_policy_free);
 
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
+	return call_int_hook(xfrm_policy_delete_security, ctx);
 }
 
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return call_int_hook(xfrm_state_alloc, 0, x, sec_ctx);
+	return call_int_hook(xfrm_state_alloc, x, sec_ctx);
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+	return call_int_hook(xfrm_state_alloc_acquire, x, polsec, secid);
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return call_int_hook(xfrm_state_delete_security, 0, x);
+	return call_int_hook(xfrm_state_delete_security, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
@@ -2516,7 +2636,7 @@ void security_xfrm_state_free(struct xfrm_state *x)
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 {
-	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid);
+	return call_int_hook(xfrm_policy_lookup, ctx, fl_secid);
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -2545,12 +2665,12 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+	return call_int_hook(xfrm_decode_session, skb, secid, 1);
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
-	int rc = call_int_hook(xfrm_decode_session, 0, skb, &flic->flowic_secid,
+	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
 				0);
 
 	BUG_ON(rc);
@@ -2564,7 +2684,7 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	return call_int_hook(key_alloc, key, cred, flags);
 }
 
 void security_key_free(struct key *key)
@@ -2575,13 +2695,13 @@ void security_key_free(struct key *key)
 int security_key_permission(key_ref_t key_ref, const struct cred *cred,
 			    enum key_need_perm need_perm)
 {
-	return call_int_hook(key_permission, 0, key_ref, cred, need_perm);
+	return call_int_hook(key_permission, key_ref, cred, need_perm);
 }
 
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
 	*_buffer = NULL;
-	return call_int_hook(key_getsecurity, 0, key, _buffer);
+	return call_int_hook(key_getsecurity, key, _buffer);
 }
 
 #endif	/* CONFIG_KEYS */
@@ -2591,13 +2711,13 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
+	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule,
 			     gfp);
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return call_int_hook(audit_rule_known, 0, krule);
+	return call_int_hook(audit_rule_known, krule);
 }
 
 void security_audit_rule_free(void *lsmrule)
@@ -2607,30 +2727,30 @@ void security_audit_rule_free(void *lsmrule)
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-	return call_int_hook(bpf, 0, cmd, attr, size);
+	return call_int_hook(bpf, cmd, attr, size);
 }
 int security_bpf_map(struct bpf_map *map, fmode_t fmode)
 {
-	return call_int_hook(bpf_map, 0, map, fmode);
+	return call_int_hook(bpf_map, map, fmode);
 }
 int security_bpf_prog(struct bpf_prog *prog)
 {
-	return call_int_hook(bpf_prog, 0, prog);
+	return call_int_hook(bpf_prog, prog);
 }
 int security_bpf_map_alloc(struct bpf_map *map)
 {
-	return call_int_hook(bpf_map_alloc_security, 0, map);
+	return call_int_hook(bpf_map_alloc_security, map);
 }
 int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_int_hook(bpf_prog_alloc_security, aux);
 }
 void security_bpf_map_free(struct bpf_map *map)
 {
@@ -2644,19 +2764,19 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 
 int security_locked_down(enum lockdown_reason what)
 {
-	return call_int_hook(locked_down, 0, what);
+	return call_int_hook(locked_down, what);
 }
 EXPORT_SYMBOL(security_locked_down);
 
 #ifdef CONFIG_PERF_EVENTS
 int security_perf_event_open(struct perf_event_attr *attr, int type)
 {
-	return call_int_hook(perf_event_open, 0, attr, type);
+	return call_int_hook(perf_event_open, attr, type);
 }
 
 int security_perf_event_alloc(struct perf_event *event)
 {
-	return call_int_hook(perf_event_alloc, 0, event);
+	return call_int_hook(perf_event_alloc, event);
 }
 
 void security_perf_event_free(struct perf_event *event)
@@ -2666,11 +2786,11 @@ void security_perf_event_free(struct perf_event *event)
 
 int security_perf_event_read(struct perf_event *event)
 {
-	return call_int_hook(perf_event_read, 0, event);
+	return call_int_hook(perf_event_read, event);
 }
 
 int security_perf_event_write(struct perf_event *event)
 {
-	return call_int_hook(perf_event_write, 0, event);
+	return call_int_hook(perf_event_write, event);
 }
 #endif /* CONFIG_PERF_EVENTS */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1c0f8209f130..fa91dc75cdb5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4677,7 +4677,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -4734,7 +4734,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4750,8 +4750,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4763,10 +4763,9 @@ static int selinux_socket_socketpair(struct socket *socka,
    Need to determine whether we should perform a name_bind
    permission check between the socket and the port number. */
 
-static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+static int __selinux_socket_bind(struct sock *sk, struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4901,14 +4900,18 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	return -EAFNOSUPPORT;
 }
 
+static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+{
+	return __selinux_socket_bind(sock->sk, address, addrlen);
+}
+
 /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
  * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
  */
-static int selinux_socket_connect_helper(struct socket *sock,
+static int selinux_socket_connect_helper(struct sock *sk,
 					 struct sockaddr *address, int addrlen)
 {
-	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -5001,7 +5004,7 @@ static int selinux_socket_connect(struct socket *sock,
 	int err;
 	struct sock *sk = sock->sk;
 
-	err = selinux_socket_connect_helper(sock, address, addrlen);
+	err = selinux_socket_connect_helper(sk, address, addrlen);
 	if (err)
 		return err;
 
@@ -5087,9 +5090,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	int err;
@@ -5121,8 +5124,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -5164,7 +5167,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
@@ -5197,7 +5200,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5271,7 +5274,7 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5331,34 +5334,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5372,7 +5368,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5382,7 +5378,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5397,7 +5393,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = ep->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	u8 peerlbl_active;
@@ -5473,13 +5469,11 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	int len, err = 0, walk_size = 0;
 	void *addr_buf;
 	struct sockaddr *addr;
-	struct socket *sock;
 
 	if (!selinux_policycap_extsockclass())
 		return 0;
 
 	/* Process one or more addresses that may be IPv4 or IPv6 */
-	sock = sk->sk_socket;
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
@@ -5508,14 +5502,14 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 		case SCTP_PRIMARY_ADDR:
 		case SCTP_SET_PEER_PRIMARY_ADDR:
 		case SCTP_SOCKOPT_BINDX_ADD:
-			err = selinux_socket_bind(sock, addr, len);
+			err = __selinux_socket_bind(sk, addr, len);
 			break;
 		/* Connect checks */
 		case SCTP_SOCKOPT_CONNECTX:
 		case SCTP_PARAM_SET_PRIMARY:
 		case SCTP_PARAM_ADD_IP:
 		case SCTP_SENDMSG_CONNECT:
-			err = selinux_socket_connect_helper(sock, addr, len);
+			err = selinux_socket_connect_helper(sk, addr, len);
 			if (err)
 				return err;
 
@@ -5548,8 +5542,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5566,7 +5560,7 @@ static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5587,7 +5581,7 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5604,7 +5598,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5688,7 +5682,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5832,7 +5826,7 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5871,7 +5865,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -5963,7 +5957,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5992,7 +5986,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -6057,7 +6051,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -7085,6 +7079,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2953132408bf..007d1ae7ee27 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -194,4 +194,9 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index abaab7683840..6a94b31b5472 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -67,7 +68,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -100,7 +101,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -235,7 +236,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -273,7 +274,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = ep->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(ep->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -352,7 +353,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -370,8 +371,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -389,7 +390,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -504,7 +505,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -542,7 +543,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -581,7 +582,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 7f7858593bdb..3b87ec820d3c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -718,6 +718,7 @@ static inline void hash_eval(struct hashtab *h, char *hash_name)
 static int policydb_index(struct policydb *p)
 {
 	int i, rc;
+	u32 v;
 
 	if (p->mls_enabled)
 		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
@@ -775,6 +776,24 @@ static int policydb_index(struct policydb *p)
 		if (rc)
 			goto out;
 	}
+
+	/*
+	 * A sparse class value is absorbed by policydb_class_isvalid() and
+	 * its siblings, but no such predicate exists for booleans: every
+	 * user of bool_val_to_struct[] walks it by index and dereferences
+	 * each entry -- cond_evaluate_expr(), the two getters and
+	 * security_set_bools() -- so an unclaimed one has no consumer that
+	 * can tolerate it.
+	 */
+	for (v = 0; v < p->p_bools.nprim; v++) {
+		if (!p->bool_val_to_struct[v]) {
+			pr_err("SELinux:  boolean %u is declared but not defined\n",
+			       v + 1);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;
@@ -1337,6 +1356,18 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			       cladatum->comkey);
 			goto bad;
 		}
+
+		/*
+		 * security_get_permissions() maps the common's permissions
+		 * into an array sized by this class's nprim, so a class must
+		 * declare at least as many as the common it inherits.
+		 */
+		if (cladatum->permissions.nprim <
+		    cladatum->comdatum->permissions.nprim) {
+			pr_err("SELinux:  class %s has fewer permissions than common %s\n",
+			       key, cladatum->comkey);
+			goto bad;
+		}
 	}
 	for (i = 0; i < nel; i++) {
 		rc = perm_read(p, &cladatum->permissions, fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 464d2c714531..2b3e0e305ba9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2200,7 +2200,9 @@ void selinux_policy_cancel(struct selinux_state *state,
 	oldpolicy = rcu_dereference_protected(state->policy,
 					lockdep_is_held(&state->policy_mutex));
 
-	sidtab_cancel_convert(oldpolicy->sidtab);
+	/* a first load has no outgoing policy and converted nothing */
+	if (oldpolicy)
+		sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(load_state->policy);
 	kfree(load_state->convert_data);
 }
diff --git a/security/smack/smack.h b/security/smack/smack.h
index a71b7a1ca24c..99ef9610fd5f 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -364,6 +364,11 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6075c4399967..53ddbe05e0c3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1454,7 +1454,7 @@ static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1841,7 +1841,7 @@ static int smack_file_receive(struct file *file)
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2262,11 +2262,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2280,11 +2276,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2293,7 +2288,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2306,9 +2300,8 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
 * smack_ipv4host_label - check host based restrictions
@@ -2421,7 +2414,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2453,7 +2446,7 @@ static int smack_netlbl_add(struct sock *sk)
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2485,7 +2478,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2558,7 +2551,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2647,7 +2640,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2749,7 +2742,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2797,7 +2790,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2822,8 +2815,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -2886,7 +2879,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3627,9 +3620,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3681,8 +3674,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3719,7 +3712,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -3931,7 +3924,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -3953,7 +3946,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4057,7 +4050,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	int slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4106,7 +4099,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4155,7 +4148,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4175,7 +4168,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4261,7 +4254,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -4759,6 +4752,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
@@ -4870,7 +4864,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index fc7399b45373..2648856c47e9 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -28,8 +28,8 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
@@ -46,8 +46,8 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 9863be6fd43e..50581120f282 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -58,12 +58,23 @@ struct snd_seq_timer *snd_seq_timer_new(void)
 void snd_seq_timer_delete(struct snd_seq_timer **tmr)
 {
 	struct snd_seq_timer *t = *tmr;
-	*tmr = NULL;
+	struct snd_timer_instance *ti;
 
 	if (t == NULL) {
 		pr_debug("ALSA: seq: snd_seq_timer_delete() called with NULL timer\n");
 		return;
 	}
+
+	spin_lock_irq(&t->lock);
+	ti = t->timeri;
+	t->timeri = NULL;
+	spin_unlock_irq(&t->lock);
+	if (ti) {
+		snd_timer_close(ti);
+		snd_timer_instance_free(ti);
+	}
+
+	*tmr = NULL;
 	t->running = 0;
 
 	/* reset time */
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 39610a15bcc9..9b786cec8f1e 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -215,7 +215,7 @@ static int hda_reg_read_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8);
+	verb = (reg & ~0xfffff) | (AC_VERB_GET_PROC_COEF << 8);
 	return snd_hdac_exec_verb(codec, verb, 0, val);
 }
 
@@ -233,7 +233,7 @@ static int hda_reg_write_coef(struct hdac_device *codec, unsigned int reg,
 	err = snd_hdac_exec_verb(codec, verb, 0, NULL);
 	if (err < 0)
 		return err;
-	verb = (reg & ~0xfffff) | (AC_VERB_GET_COEF_INDEX << 8) |
+	verb = (reg & ~0xfffff) | (AC_VERB_SET_PROC_COEF << 8) |
 		(val & 0xffff);
 	return snd_hdac_exec_verb(codec, verb, 0, NULL);
 }
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 82186c4364c9..0aed86820402 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -168,9 +168,6 @@ static void cx_fixup_headset_recog(struct hda_codec *codec)
 {
 	unsigned int mic_present;
 
-	/* fix some headset type recognize fail issue, such as EDIFIER headset */
-	/* set micbias output current comparator threshold from 66% to 55%. */
-	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
 	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias register
 	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
 	 */
diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index b49cb92d7b9e..78a1804bd097 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -46,11 +46,11 @@ static const struct reg_default cs4265_reg_defaults[] = {
 	{ CS4265_DAC_CHA_VOL, 0x00 },
 	{ CS4265_DAC_CHB_VOL, 0x00 },
 	{ CS4265_DAC_CTL2, 0xC0 },
-	{ CS4265_SPDIF_CTL1, 0x00 },
-	{ CS4265_SPDIF_CTL2, 0x00 },
 	{ CS4265_INT_MASK, 0x00 },
 	{ CS4265_STATUS_MODE_MSB, 0x00 },
 	{ CS4265_STATUS_MODE_LSB, 0x00 },
+	{ CS4265_SPDIF_CTL1, 0x00 },
+	{ CS4265_SPDIF_CTL2, 0x00 },
 };
 
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 0f8f08363b53..38231b1bded6 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1852,7 +1852,7 @@ static int wsa_macro_ear_spkr_pa_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wsa->ear_spkr_gain;
+	ucontrol->value.enumerated.item[0] = wsa->ear_spkr_gain;
 
 	return 0;
 }
@@ -1863,7 +1863,7 @@ static int wsa_macro_ear_spkr_pa_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	wsa->ear_spkr_gain =  ucontrol->value.integer.value[0];
+	wsa->ear_spkr_gain =  ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -1877,7 +1877,7 @@ static int wsa_macro_rx_mux_get(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			wsa->rx_port_value[widget->shift];
 	return 0;
 }
@@ -1891,7 +1891,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 bit_input;
 	u32 aif_rst;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 14e77df06b01..03936c85541c 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1143,17 +1143,21 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		goto err_pm_disable;
+	}
 
 	ret = regmap_reinit_cache(afe->regmap, &mt8183_afe_regmap_config);
+	pm_runtime_put_sync(dev);
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
 	if (ret) {
 		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
 		goto err_pm_disable;
 	}
 
-	pm_runtime_put_sync(&pdev->dev);
-	afe_priv->pm_runtime_bypass_reg_ctl = false;
-
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index 31c280339c50..765889f3fae0 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -2178,27 +2178,26 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	struct mtk_base_afe *afe;
 	struct mt8192_afe_private *afe_priv;
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	struct reset_control *rstc;
 	int i, ret, irq_id;
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
 	if (ret)
 		return ret;
 
-	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, afe);
 
-	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv),
 					  GFP_KERNEL);
 	if (!afe->platform_priv)
 		return -ENOMEM;
 	afe_priv = afe->platform_priv;
 
-	afe->dev = &pdev->dev;
-	dev = afe->dev;
+	afe->dev = dev;
 
 	/* init audio related clock */
 	ret = mt8192_init_clock(afe);
@@ -2209,48 +2208,42 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	/* reset controller to reset audio regs before regmap cache */
 	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
-	if (IS_ERR(rstc)) {
-		ret = PTR_ERR(rstc);
-		dev_err(dev, "could not get audiosys reset:%d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
 
 	ret = reset_control_reset(rstc);
-	if (ret) {
-		dev_err(dev, "failed to trigger audio reset:%d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
 
-	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev))
-		goto err_pm_disable;
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	/* regmap init */
 	afe->regmap = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(afe->regmap)) {
-		dev_err(dev, "could not get regmap from parent\n");
-		ret = PTR_ERR(afe->regmap);
-		goto err_pm_disable;
-	}
+	if (IS_ERR(afe->regmap))
+		return dev_err_probe(dev, PTR_ERR(afe->regmap),
+				     "could not get regmap from parent");
+
 	ret = regmap_attach_dev(dev, afe->regmap, &mt8192_afe_regmap_config);
-	if (ret) {
-		dev_warn(dev, "regmap_attach_dev fail, ret %d\n", ret);
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_attach_dev fail\n");
 
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
-	pm_runtime_get_sync(&pdev->dev);
-
-	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
-		dev_err(dev, "regmap_reinit_cache fail, ret %d\n", ret);
-		goto err_pm_disable;
+		afe_priv->pm_runtime_bypass_reg_ctl = false;
+		return dev_err_probe(dev, ret, "failed to resume device\n");
 	}
 
-	pm_runtime_put_sync(&pdev->dev);
+	ret = regmap_reinit_cache(afe->regmap, &mt8192_afe_regmap_config);
+	pm_runtime_put_sync(dev);
 	afe_priv->pm_runtime_bypass_reg_ctl = false;
 
+	if (ret)
+		return dev_err_probe(dev, ret, "regmap_reinit_cache fail\n");
+
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
@@ -2258,10 +2251,8 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->memif_size = MT8192_MEMIF_NUM;
 	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
 				  GFP_KERNEL);
-	if (!afe->memif) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->memif)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->memif_size; i++) {
 		afe->memif[i].data = &memif_data[i];
@@ -2275,47 +2266,35 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->irqs_size = MT8192_IRQ_NUM;
 	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
 				 GFP_KERNEL);
-	if (!afe->irqs) {
-		ret = -ENOMEM;
-		goto err_pm_disable;
-	}
+	if (!afe->irqs)
+		return -ENOMEM;
 
 	for (i = 0; i < afe->irqs_size; i++)
 		afe->irqs[i].irq_data = &irq_data[i];
 
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id < 0) {
-		ret = irq_id;
-		goto err_pm_disable;
-	}
+	if (irq_id < 0)
+		return irq_id;
 
 	ret = devm_request_irq(dev, irq_id, mt8192_afe_irq_handler,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
-	if (ret) {
-		dev_err(dev, "could not request_irq for Afe_ISR_Handle\n");
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
 
 	/* init sub_dais */
 	INIT_LIST_HEAD(&afe->sub_dais);
 
 	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
 		ret = dai_register_cbs[i](afe);
-		if (ret) {
-			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
-				 i, ret);
-			goto err_pm_disable;
-		}
+		if (ret)
+			return dev_err_probe(afe->dev, ret, "dai %d register fail", i);
 	}
 
 	/* init dai_driver and component_driver */
 	ret = mtk_afe_combine_sub_dai(afe);
-	if (ret) {
-		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
-			 ret);
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(afe->dev, ret, "mtk_afe_combine_sub_dai fail\n");
 
 	/* others */
 	afe->mtk_afe_hardware = &mt8192_afe_hardware;
@@ -2329,28 +2308,19 @@ static int mt8192_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->runtime_suspend = mt8192_afe_runtime_suspend;
 
 	/* register platform */
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mt8192_afe_component, NULL, 0);
-	if (ret) {
-		dev_warn(dev, "err_platform\n");
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE component\n");
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
+	ret = devm_snd_soc_register_component(dev,
 					      &mt8192_afe_pcm_component,
 					      afe->dai_drivers,
 					      afe->num_dai_drivers);
-	if (ret) {
-		dev_warn(dev, "err_dai_component\n");
-		goto err_pm_disable;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Couldn't register AFE-PCM component\n");
 
 	return 0;
-
-err_pm_disable:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
 }
 
 static int mt8192_afe_pcm_dev_remove(struct platform_device *pdev)
diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index 5c4158069a5a..dccc056e0e0a 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -281,8 +281,7 @@ static irqreturn_t xlnx_mm2s_irq_handler(int irq, void *arg)
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
 	val = readl(reg);
@@ -300,8 +299,7 @@ static irqreturn_t xlnx_s2mm_irq_handler(int irq, void *arg)
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
 	val = readl(reg);
@@ -637,7 +635,7 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		}
 		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
 				       xlnx_mm2s_irq_handler, 0,
-				       "xlnx_formatter_pcm_mm2s_irq", dev);
+				       "xlnx_formatter_pcm_mm2s_irq", aud_drv_data);
 		if (ret) {
 			dev_err(dev, "xlnx audio mm2s irq request failed\n");
 			goto clk_err;
@@ -664,7 +662,7 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
 				       xlnx_s2mm_irq_handler, 0,
 				       "xlnx_formatter_pcm_s2mm_irq",
-				       dev);
+				       aud_drv_data);
 		if (ret) {
 			dev_err(dev, "xlnx audio s2mm irq request failed\n");
 			goto clk_err;
