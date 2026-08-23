Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D593CAA3F;
	Sun, 23 Aug 2026 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787489247; cv=none; b=HZXTzL9+6q4S/lLcICZnuCngC/w4/yyusKSYlpV9q3BxYg5xhb9G8eM4pwvQOdZ2btVcT9tN2j6IZ8lWglgpoQF4iYrNMDrwed1/JE7OyX2KazcEykzGvBAr46gkbWqHMtM/wcWaqoFVgfTmynZmZPMfkX05WpvsKrbgvVuBkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787489247; c=relaxed/simple;
	bh=jeKOej17hT4lcGaX5qIXgu42aV7PptNnwAW30UW3w2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUGrAgQkfnNSAJvKuYwkCdtYNrXHEz384T+rk9P4HTqxAuJ29PvCcjMc7Sjk2N8mOTHzFXCaA6dD7xXShYvxpsDgq4ICwt5Dce+64TTxdRZsYZ7x5Hi17/9Zqhm+NP9pPzzZXG/ab9anijwT8zHWX+UkMjKTjCZb1hcIZIHoduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gi6obrxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gi6obrxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA111F00A3D;
	Sun, 23 Aug 2026 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787489225;
	bh=m8wwvJs4PlIrszccBCwJZQfuKKZgs+0uVkNVDoxCKVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gi6obrxN+kHaHBjcUgPz2IDFzVglw3mHldlXd7wJ8yuimhTtWP4PFfdAISb6cVImg
	 6lIhrxiWr8zWuX2Xby82UObHGJfb/EkNKSPsVpLrzHOD9ILKwX7Wf+EMmYE8t2JxWq
	 sRQh2jzeOg6i7f6Tgo2F8CWqKSvDIK3dmYcdSZhE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.1.10
Date: Sun, 23 Aug 2026 14:45:14 +0200
Message-ID: <2026082314-fiddling-scorecard-1fac@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082314-entomb-singing-a2be@gregkh>
References: <2026082314-entomb-singing-a2be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index d7cca59812d8..0e4156b1d188 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 849694f751d9..a5cdaa0ac69b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -3163,6 +3163,8 @@ timer {
 			     <GIC_PPI 11
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 15
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 		always-on;
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index c9a7e602d8a4..83f46fd6b97c 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -548,6 +548,10 @@ config CACHE_COPYBACK
 endchoice
 endif # HAVE_CACHE_CB
 
+config NR_CPUS
+	int
+	default "1"
+
 # Coldfire cores that do not have a data cache configured can do coherent DMA.
 config COLDFIRE_COHERENT_DMA
 	bool
diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index 808019c3b7ac..9bd3e513c89b 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -39,6 +39,8 @@
 #include <asm/processor.h>
 
 .section .data
+/* The MMU requires a page aligned page directory. */
+.align 12
 .global swapper_pg_dir
 swapper_pg_dir:
 	.space	PAGE_SIZE
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index 3ff893a67c13..ae43fe79b2b5 100644
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
index f70a13ee0593..2be5af3b9832 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -74,6 +74,7 @@ static long save_fp_state(struct sigcontext __user *sc)
 static int restore_sigcontext(struct pt_regs *regs,
 			      struct sigcontext __user *sc)
 {
+	unsigned long old_sr = regs->sr;
 	int err = 0;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -89,8 +90,8 @@ static int restore_sigcontext(struct pt_regs *regs,
 	err |= __copy_from_user(&regs->sr, &sc->regs.sr, sizeof(unsigned long));
 	err |= restore_fp_state(sc);
 
-	/* make sure the SM-bit is cleared so user-mode cannot fool us */
-	regs->sr &= ~SPR_SR_SM;
+	/* keep the privileged SR bits kernel owned, restore only user flags */
+	regs->sr = (old_sr & ~SPR_SR_USER_MASK) | (regs->sr & SPR_SR_USER_MASK);
 
 	regs->orig_gpr11 = -1;	/* Avoid syscall restart checks */
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 8821c378bfff..141bc270623e 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -697,7 +697,7 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count > sizeof(kbuf))
+	if (count == 0 || count > sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
diff --git a/arch/powerpc/platforms/pseries/papr-phy-attest.c b/arch/powerpc/platforms/pseries/papr-phy-attest.c
index 20a0e1581302..350ba26e5962 100644
--- a/arch/powerpc/platforms/pseries/papr-phy-attest.c
+++ b/arch/powerpc/platforms/pseries/papr-phy-attest.c
@@ -230,10 +230,17 @@ static long papr_phy_attest_create_handle(struct papr_phy_attest_io_block __user
 		return -ENOMEM;
 
 	if (copy_from_user(&params->cmd, ulc,
-			sizeof(struct papr_phy_attest_io_block)))
+			sizeof(struct papr_phy_attest_io_block))) {
+		kfree(params);
 		return -EFAULT;
+	}
 
 	params->cmd_len = be32_to_cpu(params->cmd.length);
+	if (params->cmd_len == 0 || params->cmd_len > sizeof(params->cmd)) {
+		kfree(params);
+		return -EINVAL;
+	}
+
 	seq = (struct papr_rtas_sequence) {
 		.begin = phy_attest_sequence_begin,
 		.end = phy_attest_sequence_end,
@@ -246,6 +253,9 @@ static long papr_phy_attest_create_handle(struct papr_phy_attest_io_block __user
 			&papr_phy_attest_handle_ops,
 			"[papr-physical-attestation]");
 
+	if (fd < 0)
+		kfree(params);
+
 	return fd;
 }
 
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 84e4ffe957a8..d11a64a086c1 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -132,7 +132,7 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 
 	/* First integer stores max config */
 	max_config_vfs = of_read_number(&max_vfs[0], 1);
-	if (max_config_vfs < num_vfs && num_vfs > MAX_VFS_FOR_MAP_PE) {
+	if (max_config_vfs < num_vfs || num_vfs > MAX_VFS_FOR_MAP_PE) {
 		dev_err(&pdev->dev,
 			"Num VFs %x > %x Configurable VFs\n",
 			num_vfs, (num_vfs > MAX_VFS_FOR_MAP_PE) ?
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index b430edfb83f4..be8b68514417 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -12,6 +12,7 @@
 #include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/text-patching.h>
+#include <asm/insn.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 void ftrace_arch_code_modify_prepare(void)
@@ -63,7 +64,9 @@ static int __ftrace_modify_call(unsigned long source, unsigned long target, bool
 		if (copy_from_kernel_nofault(replaced, (void *)source, 2 * MCOUNT_INSN_SIZE))
 			return -EFAULT;
 
-		if (replaced[0] != call[0]) {
+		/* Bypass the check if the auipc insn is a kprobe breakpoint */
+		if (replaced[0] != call[0] &&
+		    !(riscv_insn_is_ebreak(replaced[0]) || riscv_insn_is_c_ebreak(replaced[0]))) {
 			pr_err("%p: expected (%08x) but got (%08x)\n",
 			       (void *)source, call[0], replaced[0]);
 			return -EINVAL;
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
index 557d661364ac..369d4aa5bace 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -436,4 +436,10 @@ static int __init check_unaligned_access_all_cpus(void)
 	return 0;
 }
 
-late_initcall(check_unaligned_access_all_cpus);
+/*
+ * Run after clocksource_done_booting() so measure_cycles() uses a stable
+ * clocksource, but before rootfs_initcall() enables usermode helpers. Those
+ * helpers can reach hwprobe and populate the vDSO cache, so async hwprobe
+ * probes must be registered first.
+ */
+fs_initcall_sync(check_unaligned_access_all_cpus);
diff --git a/arch/riscv/lib/strnlen.S b/arch/riscv/lib/strnlen.S
index 53afa7b5b314..a8911605c248 100644
--- a/arch/riscv/lib/strnlen.S
+++ b/arch/riscv/lib/strnlen.S
@@ -83,8 +83,13 @@ strnlen_zbb:
 	sub	t3, t3, t2
 	slli	t2, t2, 3
 
-	/* Aligned boundary. */
+	/*
+	 * Aligned boundary.  Use the address of the last valid byte
+	 * (s + count - 1) to avoid loading a word past the count
+	 * boundary in the loop below.  count == 0 is handled above.
+	 */
 	add	t4, a0, a1
+	addi	t4, t4, -1
 	andi	t4, t4, -SZREG
 
 	/* Get the first word.  */
@@ -120,6 +125,9 @@ strnlen_zbb:
 
 	bgtu	t3, a0, 2f
 
+	/* All remaining bytes are in the first word, no loop needed. */
+	bgeu	t0, t4, 2f
+
 	/* Prepare for the word comparison loop. */
 	addi	t2, t0, SZREG
 	li	t3, -1
diff --git a/block/genhd.c b/block/genhd.c
index 0da6cdf3d5fb..cb8184c14a4b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1281,14 +1281,18 @@ static void disk_release(struct device *dev)
 	/*
 	 * To undo the all initialization from blk_mq_init_allocated_queue in
 	 * case of a probe failure where add_disk is never called we have to
-	 * call blk_mq_exit_queue here. We can't do this for the more common
-	 * teardown case (yet) as the tagset can be gone by the time the disk
-	 * is released once it was added.
+	 * call blk_mq_exit_queue here, after stopping the timer and work items
+	 * that I/O issued before add_disk may have left pending.  We can't do
+	 * this for the more common teardown case (yet) as the tagset can be
+	 * gone by the time the disk is released once it was added.
 	 */
 	if (queue_is_mq(disk->queue) &&
 	    test_bit(GD_OWNS_QUEUE, &disk->state) &&
-	    !test_bit(GD_ADDED, &disk->state))
+	    !test_bit(GD_ADDED, &disk->state)) {
+		blk_sync_queue(disk->queue);
+		blk_mq_cancel_work_sync(disk->queue);
 		blk_mq_exit_queue(disk->queue);
+	}
 
 	blkcg_exit_disk(disk);
 
diff --git a/crypto/ccm.c b/crypto/ccm.c
index 2ae929ffdef8..916441e4f2b8 100644
--- a/crypto/ccm.c
+++ b/crypto/ccm.c
@@ -747,7 +747,7 @@ static int crypto_rfc4309_create(struct crypto_template *tmpl,
 
 	inst->alg.ivsize = 8;
 	inst->alg.chunksize = crypto_aead_alg_chunksize(alg);
-	inst->alg.maxauthsize = 16;
+	inst->alg.maxauthsize = crypto_aead_alg_maxauthsize(alg);
 
 	inst->alg.base.cra_ctxsize = sizeof(struct crypto_rfc4309_ctx);
 
diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index a417b7d9ffac..1ac084afd946 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -963,6 +963,16 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	found = false;
 	down_write(&xdna->notifier_lock);
 	list_for_each_entry(mapp, &abo->mem.umap_list, node) {
+		/*
+		 * Skip entries that have already been unmapped.
+		 *
+		 * If userspace unmaps the address and later submits I/O using
+		 * it, the IOMMU will reject the access and report a fault.
+		 * Ignore such entries here.
+		 */
+		if (mapp->unmapped)
+			continue;
+
 		if (mapp->invalid && kref_get_unless_zero(&mapp->refcnt)) {
 			found = true;
 			break;
@@ -970,6 +980,12 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	}
 
 	if (!found) {
+		/*
+		 * This also covers the case where all mappings have been
+		 * removed. There are no invalid mappings left to process.
+		 * Any subsequent I/O using the unmapped address will be
+		 * rejected by the IOMMU.
+		 */
 		abo->mem.map_invalid = false;
 		up_write(&xdna->notifier_lock);
 		return 0;
diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 2585933d4946..b0312f57c980 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -56,10 +56,10 @@ static int regmap_sdw_mbq_poll_busy(struct sdw_slave *slave, unsigned int reg,
 	reg = SDW_SDCA_CTL(SDW_SDCA_CTL_FUNC(reg), 0,
 			   SDCA_CTL_ENTITY_0_FUNCTION_STATUS, 0);
 
-	if (ctx->readable_reg(dev, reg)) {
+	if (!ctx->readable_reg || ctx->readable_reg(dev, reg)) {
 		ret = read_poll_timeout(sdw_read_no_pm, val,
 					val < 0 || !(val & SDCA_CTL_ENTITY_0_FUNCTION_BUSY),
-					ctx->cfg.timeout_us, ctx->cfg.retry_us,
+					ctx->cfg.retry_us, ctx->cfg.timeout_us,
 					false, slave, reg);
 		if (val < 0)
 			return val;
diff --git a/drivers/clk/qcom/dispcc-eliza.c b/drivers/clk/qcom/dispcc-eliza.c
index 479f26e0dde2..e31c24125274 100644
--- a/drivers/clk/qcom/dispcc-eliza.c
+++ b/drivers/clk/qcom/dispcc-eliza.c
@@ -757,7 +757,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 		.parent_data = disp_cc_parent_data_11,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_11),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_shared_no_init_park_ops,
 	},
 };
 
diff --git a/drivers/clk/spacemit/ccu-k3.c b/drivers/clk/spacemit/ccu-k3.c
index 1a53b14739fe..4ab820a05b88 100644
--- a/drivers/clk/spacemit/ccu-k3.c
+++ b/drivers/clk/spacemit/ccu-k3.c
@@ -777,7 +777,7 @@ static const struct clk_parent_data sdh2_parents[] = {
 CCU_MUX_DIV_GATE_FC_DEFINE(sdh2_clk, sdh2_parents, APMU_SDH2_CLK_RES_CTRL, 8, 3,
 			   BIT(11), 5, 3, BIT(4), 0);
 
-CCU_GATE_DEFINE(usb2_bus_clk, CCU_PARENT_HW(axi_clk), APMU_USB_CLK_RES_CTRL, BIT(0), 0);
+CCU_GATE_DEFINE(usb2_bus_clk, CCU_PARENT_HW(axi_clk), APMU_USB_CLK_RES_CTRL, BIT(1), 0);
 CCU_GATE_DEFINE(usb3_porta_bus_clk, CCU_PARENT_HW(axi_clk), APMU_USB_CLK_RES_CTRL, BIT(4), 0);
 CCU_GATE_DEFINE(usb3_portb_bus_clk, CCU_PARENT_HW(axi_clk), APMU_USB_CLK_RES_CTRL, BIT(8), 0);
 CCU_GATE_DEFINE(usb3_portc_bus_clk, CCU_PARENT_HW(axi_clk), APMU_USB_CLK_RES_CTRL, BIT(12), 0);
@@ -1021,7 +1021,7 @@ CCU_MUX_DIV_GATE_DEFINE(isim_vclk_out3, isim_vclk_parents, APMU_SNR_ISIM_VCLK_CT
 /* APMU clocks end */
 
 /* DCIU clocks start */
-CCU_GATE_DEFINE(hdma_clk, CCU_PARENT_HW(axi_clk), DCIU_DMASYS_CLK_EN, BIT(0), 0);
+CCU_GATE_DEFINE(hdma_clk, CCU_PARENT_HW(axi_clk), DCIU_DMASYS_CLK_EN, BIT(0), CLK_IS_CRITICAL);
 CCU_GATE_DEFINE(dma350_clk, CCU_PARENT_HW(axi_clk), DCIU_DMASYS_SDMA_CLK_EN, BIT(0), 0);
 CCU_GATE_DEFINE(c2_tcm_pipe_clk, CCU_PARENT_HW(axi_clk), DCIU_C2_TCM_PIPE_CLK, BIT(0), 0);
 CCU_GATE_DEFINE(c3_tcm_pipe_clk, CCU_PARENT_HW(axi_clk), DCIU_C3_TCM_PIPE_CLK, BIT(0), 0);
diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b966f3365b7d..7f005d1fca40 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -59,7 +59,7 @@ static int devm_qce_register_algs(struct qce_device *qce)
 		ret = ops->register_algs(qce);
 		if (ret) {
 			for (j = i - 1; j >= 0; j--)
-				ops->unregister_algs(qce);
+				qce_ops[j]->unregister_algs(qce);
 			return ret;
 		}
 	}
diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
index a0713aa21250..f59adb2a5651 100644
--- a/drivers/crypto/starfive/jh7110-aes.c
+++ b/drivers/crypto/starfive/jh7110-aes.c
@@ -677,7 +677,7 @@ static int starfive_aes_aead_do_one_req(struct crypto_engine *engine, void *areq
 
 	if (cryp->total_in)
 		sg_zero_buffer(rctx->in_sg, sg_nents(rctx->in_sg),
-			       sg_dma_len(rctx->in_sg) - cryp->total_in,
+			       rctx->in_sg->length - cryp->total_in,
 			       cryp->total_in);
 
 	ctx->rctx = rctx;
diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 9094c03e991f..0fd1d7035899 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -45,7 +45,6 @@ struct tegra_aes_reqctx {
 
 struct tegra_aead_ctx {
 	struct tegra_se *se;
-	unsigned int authsize;
 	u32 alg;
 	u32 key_id;
 	u32 keylen;
@@ -1290,7 +1289,7 @@ static int tegra_gcm_do_one_req(struct crypto_engine *engine, void *areq)
 	if (rctx->encrypt)
 		rctx->cryptlen = req->cryptlen;
 	else
-		rctx->cryptlen = req->cryptlen - ctx->authsize;
+		rctx->cryptlen = req->cryptlen - rctx->authsize;
 
 	memcpy(rctx->iv, req->iv, GCM_AES_IV_SIZE);
 	rctx->iv[3] = (1 << 24);
@@ -1394,8 +1393,6 @@ static int tegra_aead_cra_init(struct crypto_aead *tfm)
 
 static int tegra_ccm_setauthsize(struct crypto_aead *tfm,  unsigned int authsize)
 {
-	struct tegra_aead_ctx *ctx = crypto_aead_ctx(tfm);
-
 	switch (authsize) {
 	case 4:
 	case 6:
@@ -1404,28 +1401,15 @@ static int tegra_ccm_setauthsize(struct crypto_aead *tfm,  unsigned int authsize
 	case 12:
 	case 14:
 	case 16:
-		break;
+		return 0;
 	default:
 		return -EINVAL;
 	}
-
-	ctx->authsize = authsize;
-
-	return 0;
 }
 
 static int tegra_gcm_setauthsize(struct crypto_aead *tfm,  unsigned int authsize)
 {
-	struct tegra_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	int ret;
-
-	ret = crypto_gcm_check_authsize(authsize);
-	if (ret)
-		return ret;
-
-	ctx->authsize = authsize;
-
-	return 0;
+	return crypto_gcm_check_authsize(authsize);
 }
 
 static void tegra_aead_cra_exit(struct crypto_aead *tfm)
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 8153d62c58f0..e947227e01ac 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -540,11 +540,13 @@ static void ar_context_link_page(struct ar_context *ctx, unsigned int index)
 
 static void ar_context_release(struct ar_context *ctx)
 {
-	struct device *dev = ctx->ohci->card.device;
+	struct device *dev;
 
 	if (!ctx->buffer)
 		return;
 
+	dev = ctx->ohci->card.device;
+
 	for (int i = 0; i < AR_BUFFERS; ++i) {
 		dma_addr_t dma_addr = ctx->dma_addrs[i];
 		if (dma_addr)
diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
index 6576e5dcb0ee..391188c0f2c2 100644
--- a/drivers/gpio/gpio-ml-ioh.c
+++ b/drivers/gpio/gpio-ml-ioh.c
@@ -73,7 +73,7 @@ struct ioh_gpio_reg_data {
  * @gpio_use_sel:		Save GPIO_USE_SEL1~4 register for PM
  * @ch:				Indicate GPIO channel
  * @irq_base:		Save base of IRQ number for interrupt
- * @spinlock:		Used for register access protection
+ * @spinlock:		Shared register access lock
  */
 struct ioh_gpio {
 	void __iomem *base;
@@ -84,7 +84,12 @@ struct ioh_gpio {
 	u32 gpio_use_sel;
 	int ch;
 	int irq_base;
-	spinlock_t spinlock;
+	raw_spinlock_t *spinlock;
+};
+
+struct ioh_gpio_device {
+	raw_spinlock_t spinlock;
+	struct ioh_gpio chip[8];
 };
 
 static const int num_ports[] = {6, 12, 16, 16, 15, 16, 16, 12};
@@ -95,7 +100,7 @@ static int ioh_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct ioh_gpio *chip =	gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 	reg_val = ioread32(&chip->reg->regs[chip->ch].po);
 	if (val)
 		reg_val |= BIT(nr);
@@ -103,7 +108,7 @@ static int ioh_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 		reg_val &= ~BIT(nr);
 
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 
 	return 0;
 }
@@ -123,7 +128,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 	u32 reg_val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm);
 	pm &= BIT(num_ports[chip->ch]) - 1;
 	pm |= BIT(nr);
@@ -136,7 +141,7 @@ static int ioh_gpio_direction_output(struct gpio_chip *gpio, unsigned nr,
 		reg_val &= ~BIT(nr);
 	iowrite32(reg_val, &chip->reg->regs[chip->ch].po);
 
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 
 	return 0;
 }
@@ -147,12 +152,12 @@ static int ioh_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)
 	u32 pm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 	pm = ioread32(&chip->reg->regs[chip->ch].pm);
 	pm &= BIT(num_ports[chip->ch]) - 1;
 	pm &= ~BIT(nr);
 	iowrite32(pm, &chip->reg->regs[chip->ch].pm);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 
 	return 0;
 }
@@ -256,7 +261,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	dev_dbg(chip->dev, "%s:irq=%d type=%d ch=%d pos=%d type=%d\n",
 		__func__, irq, type, ch, im_pos, type);
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -296,7 +301,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned int type)
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	iowrite32(ien | BIT(ch), &chip->reg->regs[chip->ch].ien);
 end:
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 
 	return 0;
 }
@@ -326,11 +331,11 @@ static void ioh_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien &= ~BIT(d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 }
 
 static void ioh_irq_enable(struct irq_data *d)
@@ -340,11 +345,11 @@ static void ioh_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	u32 ien;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(chip->spinlock, flags);
 	ien = ioread32(&chip->reg->regs[chip->ch].ien);
 	ien |= BIT(d->irq - chip->irq_base);
 	iowrite32(ien, &chip->reg->regs[chip->ch].ien);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_unlock_irqrestore(chip->spinlock, flags);
 }
 
 static irqreturn_t ioh_gpio_handler(int irq, void *dev_id)
@@ -407,8 +412,8 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 	int ret;
 	int i, j;
 	struct ioh_gpio *chip;
+	struct ioh_gpio_device *priv;
 	void __iomem *base;
-	void *chip_save;
 	int irq_base;
 
 	ret = pcim_enable_device(pdev);
@@ -429,18 +434,18 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 	}
 
-	chip_save = devm_kcalloc(dev, 8, sizeof(*chip), GFP_KERNEL);
-	if (chip_save == NULL) {
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
-	}
 
-	chip = chip_save;
+	raw_spin_lock_init(&priv->spinlock);
+	chip = priv->chip;
 	for (i = 0; i < 8; i++, chip++) {
 		chip->dev = dev;
 		chip->base = base;
 		chip->reg = chip->base;
 		chip->ch = i;
-		spin_lock_init(&chip->spinlock);
+		chip->spinlock = &priv->spinlock;
 		ioh_gpio_setup(chip, num_ports[i]);
 		ret = devm_gpiochip_add_data(dev, &chip->gpio, chip);
 		if (ret) {
@@ -449,7 +454,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		}
 	}
 
-	chip = chip_save;
+	chip = priv->chip;
 	for (j = 0; j < 8; j++, chip++) {
 		irq_base = devm_irq_alloc_descs(dev, -1, IOH_IRQ_BASE,
 						num_ports[j], NUMA_NO_NODE);
@@ -466,7 +471,7 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 			return ret;
 	}
 
-	chip = chip_save;
+	chip = priv->chip;
 	ret = devm_request_irq(dev, pdev->irq, ioh_gpio_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, chip);
 	if (ret != 0) {
@@ -474,33 +479,33 @@ static int ioh_gpio_probe(struct pci_dev *pdev,
 		return ret;
 	}
 
-	pci_set_drvdata(pdev, chip);
+	pci_set_drvdata(pdev, priv);
 
 	return 0;
 }
 
 static int ioh_gpio_suspend(struct device *dev)
 {
-	struct ioh_gpio *chip = dev_get_drvdata(dev);
+	struct ioh_gpio_device *priv = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
-	ioh_gpio_save_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&priv->spinlock, flags);
+	ioh_gpio_save_reg_conf(priv->chip);
+	raw_spin_unlock_irqrestore(&priv->spinlock, flags);
 
 	return 0;
 }
 
 static int ioh_gpio_resume(struct device *dev)
 {
-	struct ioh_gpio *chip = dev_get_drvdata(dev);
+	struct ioh_gpio_device *priv = dev_get_drvdata(dev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->spinlock, flags);
-	iowrite32(0x01, &chip->reg->srst);
-	iowrite32(0x00, &chip->reg->srst);
-	ioh_gpio_restore_reg_conf(chip);
-	spin_unlock_irqrestore(&chip->spinlock, flags);
+	raw_spin_lock_irqsave(&priv->spinlock, flags);
+	iowrite32(0x01, &priv->chip->reg->srst);
+	iowrite32(0x00, &priv->chip->reg->srst);
+	ioh_gpio_restore_reg_conf(priv->chip);
+	raw_spin_unlock_irqrestore(&priv->spinlock, flags);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-sloppy-logic-analyzer.c b/drivers/gpio/gpio-sloppy-logic-analyzer.c
index 0f4a6228a748..3b6825b0f2f9 100644
--- a/drivers/gpio/gpio-sloppy-logic-analyzer.c
+++ b/drivers/gpio/gpio-sloppy-logic-analyzer.c
@@ -301,7 +301,7 @@ static int gpio_la_poll_probe(struct platform_device *pdev)
 	debugfs_create_ulong("delay_ns_acquisition", 0400, priv->debug_dir, &priv->acq_delay);
 	debugfs_create_file_unsafe("buf_size", 0600, priv->debug_dir, priv, &fops_buf_size);
 	debugfs_create_file_unsafe("capture", 0200, priv->debug_dir, priv, &fops_capture);
-	debugfs_create_file_unsafe("trigger", 0200, priv->debug_dir, priv, &fops_trigger);
+	debugfs_create_file("trigger", 0200, priv->debug_dir, priv, &fops_trigger);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f5be133c5c3f..c865f2b3a994 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5408,7 +5408,8 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 		flags = READ_ONCE(desc->flags);
 		is_irq = test_bit(GPIOD_FLAG_USED_AS_IRQ, &flags);
 		if (is_irq || test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
-			gpiod_get_direction(desc);
+			if (gc->get_direction)
+				gpiod_get_direction(desc);
 			is_out = test_bit(GPIOD_FLAG_IS_OUT, &flags);
 			value = gpio_chip_get_value(gc, desc);
 			active_low = test_bit(GPIOD_FLAG_ACTIVE_LOW, &flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 12e45340a2d1..9d82bd30003a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -42,6 +42,26 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_hmm.h"
 
+/*
+ * Maximum IB length (dwords) for rings whose emit_ib packet format
+ * documents a 20-bit size field.
+ */
+#define AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW	0xFFFFF
+#define AMDGPU_MM_IB_PACKET_SIZE_MAX_DW	0x7FFFF0
+
+static u32 amdgpu_cs_ib_packet_size_max_dw(enum amdgpu_ring_type type)
+{
+	switch (type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+	case AMDGPU_RING_TYPE_SDMA:
+	case AMDGPU_RING_TYPE_VPE:
+		return AMDGPU_GFX_SDMA_IB_PACKET_SIZE_MAX_DW;
+	default:
+		return AMDGPU_MM_IB_PACKET_SIZE_MAX_DW;
+	}
+}
+
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 				 struct amdgpu_device *adev,
 				 struct drm_file *filp,
@@ -233,6 +253,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
 
+			/* Only a single user fence is allowed to simplify handling. */
+			if (p->uf_bo)
+				goto free_partial_kdata;
+
 			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
 						      &uf_offset);
 			if (ret)
@@ -350,7 +374,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 
 	job = p->jobs[r];
 	ring = amdgpu_job_ring(job);
-	ib = &job->ibs[job->num_ibs++];
 
 	/* submissions to kernel queues are disabled */
 	if (ring->no_user_submission)
@@ -379,6 +402,12 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			return -EINVAL;
 	}
 
+	if (chunk_ib->ib_bytes / 4 >
+	    amdgpu_cs_ib_packet_size_max_dw(ring->funcs->type))
+		return -EINVAL;
+
+	ib = &job->ibs[job->num_ibs++];
+
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
 		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 6b5384e5fd71..dba7fca57427 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -513,7 +513,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	if (job && job->pasid)
 		size += sizeof(struct amdgpu_coredump_ib_info) * job->num_ibs;
 
-	coredump = kzalloc(size, GFP_NOWAIT);
+	coredump = kvzalloc(size, GFP_NOWAIT);
 	if (!coredump)
 		return;
 
@@ -556,8 +556,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 		total_ring_size += ring->ring_size;
 		ring_count++;
 	}
-	coredump->rings_dw = kzalloc(total_ring_size, GFP_NOWAIT);
-	coredump->rings = kcalloc(ring_count, sizeof(struct amdgpu_coredump_ring), GFP_NOWAIT);
+	if (ring_count) {
+		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
+		coredump->rings = kvcalloc(ring_count,
+					   sizeof(struct amdgpu_coredump_ring),
+					   GFP_NOWAIT);
+	}
 	if (coredump->rings && coredump->rings_dw) {
 		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
 			ring = adev->rings[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 22e88644402e..a8041c45a971 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1365,6 +1365,31 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
 #endif
 }
 
+/*
+ * Some dGPUs expose their display endpoint below an internal PCIe switch.
+ * Use the switch upstream port to query the host-facing link.
+ */
+static struct pci_dev *amdgpu_device_get_aspm_pdev(struct amdgpu_device *adev)
+{
+	struct pci_dev *swds, *swus;
+
+	swds = pci_upstream_bridge(adev->pdev);
+	if (!swds ||
+	    (swds->vendor != PCI_VENDOR_ID_ATI &&
+	     swds->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swds) != PCI_EXP_TYPE_DOWNSTREAM)
+		return adev->pdev;
+
+	swus = pci_upstream_bridge(swds);
+	if (!swus ||
+	    (swus->vendor != PCI_VENDOR_ID_ATI &&
+	     swus->vendor != PCI_VENDOR_ID_AMD) ||
+	    pci_pcie_type(swus) != PCI_EXP_TYPE_UPSTREAM)
+		return adev->pdev;
+
+	return swus;
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1377,6 +1402,9 @@ static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device *adev)
  */
 bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 {
+	struct pci_dev *aspm_pdev, *parent;
+	bool enabled;
+
 	switch (amdgpu_aspm) {
 	case -1:
 		break;
@@ -1391,7 +1419,27 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev)
 		return false;
 	if (amdgpu_device_aspm_support_quirk(adev))
 		return false;
-	return pcie_aspm_enabled(adev->pdev);
+
+	/*
+	 * pcie_aspm_enabled() checks the link between its argument and
+	 * the immediate upstream bridge. Use SWUS for dGPUs with an
+	 * internal switch so that this is the host-facing link.
+	 */
+	aspm_pdev = amdgpu_device_get_aspm_pdev(adev);
+	parent = pci_upstream_bridge(aspm_pdev);
+	if (!parent) {
+		dev_dbg(adev->dev, "ASPM: no upstream PCIe link for %s\n",
+			pci_name(aspm_pdev));
+		return false;
+	}
+
+	enabled = pcie_aspm_enabled(aspm_pdev);
+	/* Report the exact link used for the automatic ASPM decision. */
+	dev_dbg(adev->dev, "ASPM: link %s <-> %s is %s\n",
+		pci_name(parent), pci_name(aspm_pdev),
+		enabled ? "enabled" : "disabled");
+
+	return enabled;
 }
 
 /* if we get transitioned to only one device, take VGA back */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 80efeca0ab73..a5d0bd2c70bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -310,6 +310,19 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 			goto out;
 		}
 	} else {
+		if (adev->discovery.offset) {
+			u32 signature;
+
+			/* If VRAM holds a valid discovery signature at the default
+			 * discovery offset, use it as-is.
+			 */
+			amdgpu_device_vram_access(adev, adev->discovery.offset,
+						  &signature, sizeof(signature),
+						  false);
+			if (le32_to_cpu(signature) == BINARY_SIGNATURE)
+				goto out;
+		}
+
 		tmr_size = RREG32(mmDRIVER_SCRATCH_2);
 		if (tmr_size) {
 			/* It's preferred to transition to PSP mailbox reg interface
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index c08f01936675..802bfae018fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -397,6 +397,25 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
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
@@ -421,6 +440,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	/* reject invalid gem domains */
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
+	if (!amdgpu_gem_are_domains_valid(args->in.domains))
+		return -EINVAL;
 
 	if (!amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
 		DRM_NOTE_ONCE("Cannot allocate secure buffer since TMZ is disabled\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c064f8a1e5f3..ef528db32ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2260,8 +2260,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!adev->mman.initialized)
 		return;
 
@@ -2284,13 +2282,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		if (adev->mman.aper_base_kaddr)
-			iounmap(adev->mman.aper_base_kaddr);
+	if (adev->mman.aper_base_kaddr) {
+		iounmap(adev->mman.aper_base_kaddr);
 		adev->mman.aper_base_kaddr = NULL;
-
-		drm_dev_exit(idx);
 	}
 
 	if (!adev->gmc.is_app_apu)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 73421f8021fb..631c4417b875 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -700,7 +700,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
+		/* Serialize the map against an in-progress GPU reset (MES is
+		 * unresponsive during recovery), matching amdgpu_userq_cleanup().
+		 */
+		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
+		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			mutex_unlock(&uq_mgr->userq_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 47a256e1acf6..31a75fe426c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -646,17 +646,15 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int height = msg[7];
 	unsigned int dpb_size = msg[9];
 	unsigned int pitch = msg[28];
-	unsigned int level = msg[57];
 
 	unsigned int width_in_mb = width / 16;
 	unsigned int height_in_mb = ALIGN(height / 16, 2);
-	unsigned int fs_in_mb = width_in_mb * height_in_mb;
 
 	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned int min_ctx_size = ~0;
 
-	/* Reject invalid dimensions to prevent division by zero */
-	if (width < 16 || height < 16) {
+	/* Reject invalid dimensions */
+	if (width < 16 || height < 16 || width > 4096 || height > 4096) {
 		dev_WARN_ONCE(adev->dev, 1,
 			      "Invalid UVD decoding dimensions (%dx%d)!\n",
 			      width, height);
@@ -669,35 +667,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 
 	switch (stream_type) {
 	case 0: /* H264 */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
+		num_dpb_buffer = ((msg[61] >> 16) & 0xff) + 1;
 		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
+			return -EINVAL;
 
 		/* reference picture buffer */
 		min_dpb_size = image_size * num_dpb_buffer;
@@ -747,35 +719,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		break;
 
 	case 7: /* H264 Perf */
-		switch (level) {
-		case 30:
-			num_dpb_buffer = 8100 / fs_in_mb;
-			break;
-		case 31:
-			num_dpb_buffer = 18000 / fs_in_mb;
-			break;
-		case 32:
-			num_dpb_buffer = 20480 / fs_in_mb;
-			break;
-		case 41:
-			num_dpb_buffer = 32768 / fs_in_mb;
-			break;
-		case 42:
-			num_dpb_buffer = 34816 / fs_in_mb;
-			break;
-		case 50:
-			num_dpb_buffer = 110400 / fs_in_mb;
-			break;
-		case 51:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		default:
-			num_dpb_buffer = 184320 / fs_in_mb;
-			break;
-		}
-		num_dpb_buffer++;
+		num_dpb_buffer = ((msg[61] >> 16) & 0xff) + 1;
 		if (num_dpb_buffer > 17)
-			num_dpb_buffer = 17;
+			return -EINVAL;
 
 		/* reference picture buffer */
 		min_dpb_size = image_size * num_dpb_buffer;
@@ -803,6 +749,9 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		image_size = ALIGN(image_size, 256);
 
 		num_dpb_buffer = (le32_to_cpu(msg[59]) & 0xff) + 2;
+		if (num_dpb_buffer > 17)
+			return -EINVAL;
+
 		min_dpb_size = image_size * num_dpb_buffer;
 		min_ctx_size = ((width + 255) / 16) * ((height + 255) / 16)
 					   * 16 * num_dpb_buffer + 52 * 1024;
@@ -813,7 +762,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 		return -EINVAL;
 	}
 
-	if (width > pitch) {
+	if (width > pitch || pitch > 4096) {
 		DRM_ERROR("Invalid UVD decoding target pitch!\n");
 		return -EINVAL;
 	}
@@ -825,7 +774,7 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	}
 
 	buf_sizes[0x1] = dpb_size;
-	buf_sizes[0x2] = image_size;
+	buf_sizes[0x2] = (pitch * height) * 3 / 2;
 	buf_sizes[0x4] = min_ctx_size;
 	/* store image width to adjust nb memory pstate */
 	adev->uvd.decode_image_width = width;
@@ -972,15 +921,16 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 				  ctx->buf_sizes[cmd]);
 			return -EINVAL;
 		}
+	} else if (cmd == 0x204 || cmd == 0x206) {
+		unsigned int min_size = ctx->buf_sizes[cmd == 0x204 ? 5 : 4];
 
-	} else if (cmd == 0x206) {
-		if ((end - start) < ctx->buf_sizes[4]) {
+		if ((end - start) < min_size) {
 			DRM_ERROR("buffer (%d) to small (%d / %d)!\n", cmd,
 					  (unsigned int)(end - start),
-					  ctx->buf_sizes[4]);
+					  min_size);
 			return -EINVAL;
 		}
-	} else if ((cmd != 0x100) && (cmd != 0x204)) {
+	} else if ((cmd != 0x100)) {
 		DRM_ERROR("invalid UVD command %X!\n", cmd);
 		return -EINVAL;
 	}
@@ -1110,11 +1060,12 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser,
 {
 	struct amdgpu_uvd_cs_ctx ctx = {};
 	unsigned int buf_sizes[] = {
-		[0x00000000]	=	2048,
+		[0x00000000]	=	3556,
 		[0x00000001]	=	0xFFFFFFFF,
 		[0x00000002]	=	0xFFFFFFFF,
 		[0x00000003]	=	2048,
 		[0x00000004]	=	0xFFFFFFFF,
+		[0x00000005]	=	992,
 	};
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7ed027b28889..97c5151bada3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -810,6 +810,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
@@ -821,7 +822,7 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return;
 
 	amdgpu_ring_ib_begin(ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d66b6b4f3cb2..dea7400df534 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1823,6 +1823,11 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	gfx_v12_0_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override = 0;
 
+	/* Set whether texture coordinate truncation is conformant. */
+	tmp = RREG32_SOC15(GC, 0, regTA_CNTL2);
+	adev->gfx.config.ta_cntl2_truncate_coord_mode =
+		REG_GET_FIELD(tmp, TA_CNTL2, TRUNCATE_COORD_MODE);
+
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 7ea7b9c30bca..beadab66e686 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -254,9 +254,24 @@ static bool gmc_v12_1_get_vmid_pasid_mapping_info(struct amdgpu_device *adev,
  * by the amdgpu vm/hsa code.
  */
 
+/**
+ * gmc_v12_1_use_invalidate_semaphore - judge whether to use semaphore
+ *
+ * @adev: amdgpu_device pointer
+ * @vmhub: vmhub type
+ *
+ */
+static bool gmc_v12_1_use_invalidate_semaphore(struct amdgpu_device *adev,
+				       uint32_t vmhub)
+{
+	return ((!AMDGPU_IS_GFXHUB(vmhub)) &&
+		(!amdgpu_sriov_vf(adev)));
+}
+
 static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 				   unsigned int vmhub, uint32_t flush_type)
 {
+	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	u32 tmp;
@@ -270,6 +285,19 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_lock(&adev->gmc.invalidate_lock);
 
+	if (use_semaphore) {
+		for (i = 0; i < adev->usec_timeout; i++) {
+			/* a read return value of 1 means semaphore acuqire */
+			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, hub_ip);
+			if (tmp & 0x1)
+				break;
+			udelay(1);
+		}
+
+		if (i >= adev->usec_timeout)
+			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
+	}
+
 	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
 
 	/* Wait for ACK with a delay.*/
@@ -283,6 +311,9 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 		udelay(1);
 	}
 
+	if (use_semaphore)
+		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, hub_ip);
+
 	/* Issue additional private vm invalidation to MMHUB */
 	if (!AMDGPU_IS_GFXHUB(vmhub) &&
 	    (hub->vm_l2_bank_select_reserved_cid2) &&
@@ -383,7 +414,7 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 		if (all_hub) {
 			/* invalidate mm_hub */
-			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
+			if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
 				input.hub_id = AMDGPU_MMHUB0(0);
 				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
 			}
@@ -418,10 +449,17 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
+	bool use_semaphore = gmc_v12_1_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->vm_hub];
 	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned eng = ring->vm_inv_eng;
 
+	if (use_semaphore)
+		/* a read return value of 1 means semaphore acuqire */
+		amdgpu_ring_emit_reg_wait(ring,
+					  hub->vm_inv_eng0_sem +
+					  hub->eng_distance * eng, 0x1, 0x1);
+
 	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
 			      (hub->ctx_addr_distance * vmid),
 			      lower_32_bits(pd_addr));
@@ -436,6 +474,14 @@ static uint64_t gmc_v12_1_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    hub->eng_distance * eng,
 					    req, 1 << vmid);
 
+	if (use_semaphore)
+		/*
+		 * add semaphore release after invalidation,
+		 * write with 0 means semaphore release
+		 */
+		amdgpu_ring_emit_wreg(ring, hub->vm_inv_eng0_sem +
+				      hub->eng_distance * eng, 0);
+
 	return pd_addr;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a43582b9c876..3f61d5367d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -772,15 +772,28 @@ static int jpeg_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v4_0_5_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v4_0_5_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + static power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v4_0_5_stop(adev);
+	if (!r)
+		r = jpeg_v4_0_5_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 72a4b2d0676f..c696a0dea32c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -648,15 +648,28 @@ static int jpeg_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v5_0_0_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v5_0_0_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + ONO1 power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v5_0_0_stop(adev);
+	if (!r)
+		r = jpeg_v5_0_0_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index e7546816baba..e325ca7dc583 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -631,15 +631,28 @@ static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
 {
+	struct amdgpu_device *adev = ring->adev;
+	u32 pg_flags = adev->pg_flags;
 	int r;
 
 	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-	r = jpeg_v5_3_0_stop(ring->adev);
-	if (r)
-		return r;
-	r = jpeg_v5_3_0_start(ring->adev);
+
+	/*
+	 * The DPG stop path only clears the JPEG_PG_MODE bit and never resets a
+	 * hung JRBC, so the post-reset ring test times out and the driver falls
+	 * back to a full MODE1 reset. Temporarily force the static power-gating
+	 * path so the stop/start sequence actually power-cycles the JPEG block
+	 * (JMI soft reset + static power off/on), matching the working jpeg_v4_0
+	 * reset.
+	 */
+	adev->pg_flags &= ~AMD_PG_SUPPORT_JPEG_DPG;
+	r = jpeg_v5_3_0_stop(adev);
+	if (!r)
+		r = jpeg_v5_3_0_start(adev);
+	adev->pg_flags = pg_flags;
 	if (r)
 		return r;
+
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index b6f832c53860..5c19557872b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -375,7 +375,6 @@ static u32 nbif_v6_3_1_get_rom_offset(struct amdgpu_device *adev)
 static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
-	u16 devctl2;
 
 	def = RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
 	data = 0x35EB;
@@ -389,15 +388,8 @@ static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
-
-	if (adev->pdev->ltr_path == (devctl2 & PCI_EXP_DEVCTL2_LTR_EN))
-		return;
-
-	if (adev->pdev->ltr_path)
-		pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
-	else
-		pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_LTR_EN);
+	pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2,
+				 PCI_EXP_DEVCTL2_LTR_EN);
 }
 #endif
 
@@ -405,7 +397,7 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 {
 #ifdef CONFIG_PCIEASPM
 	uint32_t def, data;
-	u16 devctl2, ltr;
+	u16 ltr;
 
 	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
 	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
@@ -435,11 +427,8 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
 
-	pcie_capability_read_word(adev->pdev, PCI_EXP_DEVCTL2, &devctl2);
-	data = def = devctl2;
-	data &= ~PCI_EXP_DEVCTL2_LTR_EN;
-	if (def != data)
-		pcie_capability_set_word(adev->pdev, PCI_EXP_DEVCTL2, (u16)data);
+	pcie_capability_clear_word(adev->pdev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_LTR_EN);
 
 	ltr = pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_LTR);
 
@@ -447,15 +436,13 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 		pci_write_config_dword(adev->pdev, ltr + PCI_LTR_MAX_SNOOP_LAT, 0x10011001);
 	}
 
-#if 0
-	/* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or someone else ? */
-	def = data = RREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2);
-	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
-		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
-	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL2);
+	data |= PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
 	if (def != data)
-		WREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2, data);
-#endif
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL2, data);
+
 	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL4);
 	data |= PCIE_LC_CNTL4__LC_L1_POWERDOWN_MASK;
 	if (def != data)
@@ -466,7 +453,12 @@ static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(PCIE, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL, data);
 
-	nbif_v6_3_1_program_ltr(adev);
+	/*
+	 * Do not enable endpoint LTR unless the Root Complex and every
+	 * upstream switch support it.
+	 */
+	if (adev->pdev->ltr_path)
+		nbif_v6_3_1_program_ltr(adev);
 
 	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
 	data |= 0x5DE0 << RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index c69f7d82060f..a3eae7d4b57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -875,6 +875,23 @@ static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
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
@@ -884,7 +901,6 @@ static void vce_v3_0_emit_vm_flush(struct amdgpu_ring *ring,
 
 	amdgpu_ring_write(ring, VCE_CMD_FLUSH_TLB);
 	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, VCE_CMD_END);
 }
 
 static void vce_v3_0_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -953,17 +969,19 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.set_wptr = vce_v3_0_ring_set_wptr,
 	.patch_cs_in_place = amdgpu_vce_ring_parse_cs_vm,
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
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a1087c13f241..8b39c0707cf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1404,6 +1404,15 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	sub_type_hdr = (struct crat_subtype_generic *)(crat_table+1);
 	while ((char *)sub_type_hdr + sizeof(struct crat_subtype_generic) <
 			((char *)crat_image) + image_len) {
+		/* Validate subtype fits within remaining image */
+		if ((char *)sub_type_hdr + sub_type_hdr->length >
+		    (char *)crat_image + image_len) {
+			pr_warn("CRAT subtype length %u exceeds image bounds\n",
+				sub_type_hdr->length);
+			ret = -EINVAL;
+			break;
+		}
+
 		if (sub_type_hdr->flags & CRAT_SUBTYPE_FLAGS_ENABLED) {
 			ret = kfd_parse_subtype(sub_type_hdr, device_list);
 			if (ret)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6f9d4bea3379..a2b6470d381c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2079,6 +2079,11 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_data.flags.unify_link_enc_assignment = true;
 		init_data.flags.usb4_bw_alloc_support = true;
 	}
+
+	/* DCN201 audio desyncs using DP SS */
+	if (adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2)
+		init_data.flags.ignore_dpref_ss = true;
+
 	retrieve_dmi_info(&adev->dm);
 	if (adev->dm.edp0_on_dp1_quirk)
 		init_data.flags.support_edp0_on_dp1 = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 9d5782b4958c..a2315460b759 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -287,7 +287,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable) {
+	if (enable && acrtc_state->stream) {
 		struct dc *dc = adev->dm.dc;
 		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7333f5905330..1ccb2028d657 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -57,7 +57,8 @@ enum dc_color_space_type {
 	COLOR_SPACE_RGB_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR601_TYPE,
 	COLOR_SPACE_YCBCR709_TYPE,
-	COLOR_SPACE_YCBCR2020_TYPE,
+	COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
+	COLOR_SPACE_YCBCR2020_FULL_TYPE,
 	COLOR_SPACE_YCBCR601_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR709_LIMITED_TYPE,
 	COLOR_SPACE_YCBCR709_BLACK_TYPE,
@@ -109,9 +110,15 @@ static const struct out_csc_color_matrix_type output_csc_matrix[] = {
 		{ 0xE00, 0xF349, 0xFEB7, 0x1000,
 		  0x6CE, 0x16E3, 0x24F,  0x200,
 		  0xFCCB, 0xF535, 0xE00, 0x1000} },
-	{ COLOR_SPACE_YCBCR2020_TYPE,
+	/* Corrected. Not included in the TODO above. */
+	{ COLOR_SPACE_YCBCR2020_LIMITED_TYPE,
+		{ 0x0E04, 0xF31D, 0xFEDF, 0x1004,
+		  0x0733, 0x1294, 0x01A0, 0x0201,
+		  0xFC16, 0xF5E6, 0x0E04, 0x1004} },
+	/* Corrected. Not included in the TODO above. */
+	{ COLOR_SPACE_YCBCR2020_FULL_TYPE,
 		{ 0x1000, 0xF149, 0xFEB7, 0x1004,
-		  0x0868, 0x15B2, 0x01E6, 0x201,
+		  0x0868, 0x15B2, 0x01E6, 0,
 		  0xFB88, 0xF478, 0x1000, 0x1004} },
 	{ COLOR_SPACE_YCBCR709_BLACK_TYPE,
 		{ 0x0000, 0x0000, 0x0000, 0x1000,
@@ -178,14 +185,14 @@ static bool is_ycbcr709_type(
 	return ret;
 }
 
-static bool is_ycbcr2020_type(
-	enum dc_color_space color_space)
+static bool is_ycbcr2020_limited_type(enum dc_color_space color_space)
 {
-	bool ret = false;
+	return color_space == COLOR_SPACE_2020_YCBCR_LIMITED;
+}
 
-	if (color_space == COLOR_SPACE_2020_YCBCR_LIMITED || color_space == COLOR_SPACE_2020_YCBCR_FULL)
-		ret = true;
-	return ret;
+static bool is_ycbcr2020_full_type(enum dc_color_space color_space)
+{
+	return color_space == COLOR_SPACE_2020_YCBCR_FULL;
 }
 
 static bool is_ycbcr709_limited_type(
@@ -214,8 +221,10 @@ static enum dc_color_space_type get_color_space_type(enum dc_color_space color_s
 		type = COLOR_SPACE_YCBCR601_LIMITED_TYPE;
 	else if (is_ycbcr709_limited_type(color_space))
 		type = COLOR_SPACE_YCBCR709_LIMITED_TYPE;
-	else if (is_ycbcr2020_type(color_space))
-		type = COLOR_SPACE_YCBCR2020_TYPE;
+	else if (is_ycbcr2020_limited_type(color_space))
+		type = COLOR_SPACE_YCBCR2020_LIMITED_TYPE;
+	else if (is_ycbcr2020_full_type(color_space))
+		type = COLOR_SPACE_YCBCR2020_FULL_TYPE;
 	else if (color_space == COLOR_SPACE_YCBCR709)
 		type = COLOR_SPACE_YCBCR709_BLACK_TYPE;
 	else if (color_space == COLOR_SPACE_YCBCR709_BLACK)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 0d312b40bcfa..0b5bc04613b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -115,10 +115,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 static bool setup_scaling_configuration(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
index 1ed018aaa4bb..f5f8cd2d47a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
@@ -93,10 +93,11 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
 	{ 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
 { COLOR_SPACE_2020_RGB_LIMITEDRANGE,
 	{ 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
-{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
-	0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
+/* COLOR_SPACE_2020_YCBCR_* values corrected. Not included in the TODO above. */
+{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x0E04, 0xF31D, 0xFEDF, 0x1004, 0x0733,
+	0x1294, 0x01A0, 0x201, 0xFC16, 0xF5E6, 0x0E04, 0x1004} },
 { COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
-	0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
+	0x01E6, 0, 0xFB88, 0xF478, 0x1000, 0x1004} }
 };
 
 enum csc_color_mode {
diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 8d21b785bead..467cdce57dd3 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -160,6 +160,9 @@ static void drm_log_draw_kmsg_record(struct drm_log_scanout *scanout,
 {
 	u32 prefix_len = 0;
 
+	if (!len)
+		return;
+
 	if (len > TS_PREFIX_LEN && s[0] == '[' && s[6] == '.' && s[TS_PREFIX_LEN] == ']')
 		prefix_len = TS_PREFIX_LEN + 1;
 
@@ -215,6 +218,12 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
 	scanout->scaled_font_w = scanout->font->width * scale;
 	scanout->rows = height / scanout->scaled_font_h;
 	scanout->columns = width / scanout->scaled_font_w;
+	if (!scanout->rows || !scanout->columns) {
+		drm_client_buffer_delete(scanout->buffer);
+		scanout->buffer = NULL;
+		mode_set->fb = NULL;
+		return -EINVAL;
+	}
 	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
 	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
 	return 0;
@@ -419,6 +428,9 @@ void drm_log_register(struct drm_device *dev)
 {
 	struct drm_log *new;
 
+	if (!scale)
+		scale = 1;
+
 	new = kzalloc_obj(*new);
 	if (!new)
 		goto err_warn;
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 9f3b696aceeb..44117be8836b 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1096,7 +1096,8 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+	BUILD_BUG_ON(sizeof(*frame) > sizeof(infoframe->data));
+	memcpy(&infoframe->data, frame, sizeof(*frame));
 	infoframe->set = true;
 
 	ret = write_infoframe(connector, &funcs->audio, "Audio", infoframe);
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..ddea1efcc313 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -577,9 +577,13 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
 #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
 	} else if (order == PMD_ORDER) {
 		unsigned long paddr = pfn << PAGE_SHIFT;
+		struct vm_area_struct *vma = vmf->vma;
+		unsigned long start = ALIGN_DOWN(vmf->address, PMD_SIZE);
+		unsigned long end = start + PMD_SIZE;
+		bool in_range = vma->vm_start <= start && end <= vma->vm_end;
 		bool aligned = (vmf->address & ~PMD_MASK) == (paddr & ~PMD_MASK);
 
-		if (aligned &&
+		if (aligned && in_range &&
 		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
 			vm_fault_t ret;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 5aa71fcdcfab..36ac8c1322da 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -511,6 +511,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 	u32 delta;
 	struct mtk_phy_timing *timing = &dsi->phy_timing;
 	struct videomode *vm = &dsi->vm;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (dsi->format == MIPI_DSI_FMT_RGB565)
 		dsi_tmp_buf_bpp = 2;
@@ -544,7 +545,7 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
 					     horizontal_backporch_byte /
 					     horizontal_front_back_byte;
 	} else {
-		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
+		drm_warn(drm, "HFP + HBP less than d-phy, FPS will under 60Hz\n");
 	}
 
 	if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
@@ -624,12 +625,13 @@ static s32 mtk_dsi_wait_for_irq_done(struct mtk_dsi *dsi, u32 irq_flag,
 {
 	s32 ret = 0;
 	unsigned long jiffies = msecs_to_jiffies(timeout);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = wait_event_interruptible_timeout(dsi->irq_wait_queue,
 					       dsi->irq_data & irq_flag,
 					       jiffies);
 	if (ret == 0) {
-		DRM_WARN("Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
+		drm_warn(drm, "Wait DSI IRQ(0x%08x) Timeout\n", irq_flag);
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -664,9 +666,10 @@ static s32 mtk_dsi_switch_to_cmd_mode(struct mtk_dsi *dsi, u8 irq_flag, u32 t)
 {
 	mtk_dsi_irq_data_clear(dsi, irq_flag);
 	mtk_dsi_set_cmd_mode(dsi);
+	struct drm_device *drm = dsi->bridge.dev;
 
 	if (!mtk_dsi_wait_for_irq_done(dsi, irq_flag, t)) {
-		DRM_ERROR("failed to switch cmd mode\n");
+		drm_err(drm, "failed to switch cmd mode\n");
 		return -ETIME;
 	} else {
 		return 0;
@@ -740,8 +743,6 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-	mtk_dsi_lane_ready(dsi);
-	mtk_dsi_clk_hs_mode(dsi, 1);
 
 	return 0;
 err_disable_engine_clk:
@@ -849,11 +850,15 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					     struct drm_atomic_state *state)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	struct drm_device *drm = bridge->dev;
 	int ret;
 
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
-		DRM_ERROR("failed to power on dsi\n");
+		drm_err(drm, "failed to power on dsi\n");
+
+	mtk_dsi_lane_ready(dsi);
+	mtk_dsi_clk_hs_mode(dsi, 1);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -916,7 +921,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 	ret = drm_simple_encoder_init(drm, &dsi->encoder,
 				      DRM_MODE_ENCODER_DSI);
 	if (ret) {
-		DRM_ERROR("Failed to encoder init to drm\n");
+		drm_err(drm, "Failed to encoder init to drm\n");
 		return ret;
 	}
 
@@ -932,7 +937,7 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 
 	dsi->connector = drm_bridge_connector_init(drm, &dsi->encoder);
 	if (IS_ERR(dsi->connector)) {
-		DRM_ERROR("Unable to create bridge connector\n");
+		drm_err(drm, "Unable to create bridge connector\n");
 		ret = PTR_ERR(dsi->connector);
 		goto err_cleanup_encoder;
 	}
@@ -985,6 +990,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
 	struct device *dev = host->dev;
+	struct drm_device *drm = dsi->bridge.dev;
 	int ret;
 
 	dsi->lanes = device->lanes;
@@ -1006,7 +1012,7 @@ static int mtk_dsi_host_attach(struct mipi_dsi_host *host,
 
 	ret = component_add(host->dev, &mtk_dsi_component_ops);
 	if (ret) {
-		DRM_ERROR("failed to add dsi_host component: %d\n", ret);
+		drm_err(drm, "failed to add dsi_host component: %d\n", ret);
 		drm_bridge_remove(&dsi->bridge);
 		return ret;
 	}
@@ -1028,11 +1034,12 @@ static void mtk_dsi_wait_for_idle(struct mtk_dsi *dsi)
 {
 	int ret;
 	u32 val;
+	struct drm_device *drm = dsi->bridge.dev;
 
 	ret = readl_poll_timeout(dsi->regs + DSI_INTSTA, val, !(val & DSI_BUSY),
 				 4, 2000000);
 	if (ret) {
-		DRM_WARN("polling dsi wait not busy timeout!\n");
+		drm_warn(drm, "polling dsi wait not busy timeout!\n");
 
 		mtk_dsi_enable(dsi);
 		mtk_dsi_reset_engine(dsi);
@@ -1120,6 +1127,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 				     const struct mipi_dsi_msg *msg)
 {
 	struct mtk_dsi *dsi = host_to_dsi(host);
+	struct drm_device *drm = dsi->bridge.dev;
 	ssize_t recv_cnt;
 	u8 read_data[16];
 	void *src_addr;
@@ -1150,7 +1158,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	}
 
 	if (!msg->rx_buf) {
-		DRM_ERROR("dsi receive buffer size may be NULL\n");
+		drm_err(drm, "dsi receive buffer size may be NULL\n");
 		ret = -EINVAL;
 		goto restore_dsi_mode;
 	}
@@ -1174,7 +1182,7 @@ static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (recv_cnt)
 		memcpy(msg->rx_buf, src_addr, recv_cnt);
 
-	DRM_INFO("dsi get %zd byte data from the panel address(0x%x)\n",
+	drm_info(drm, "dsi get %zd byte data from the panel address(0x%x)\n",
 		 recv_cnt, *((u8 *)(msg->tx_buf)));
 
 restore_dsi_mode:
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index cbd4d4c86fb0..13b575539ae3 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -600,6 +600,9 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		return -EINVAL;
 	}
 
+	if (!section_size)
+		return 0;
+
 	name_len = iter->size - iter->offset;
 
 	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 02a40e4750c7..299865569252 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -360,6 +360,13 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
 
+	if (down_read_trylock(&rdev->exclusive_lock)) {
+		radeon_fence_activity(rdev, ring);
+		up_read(&rdev->exclusive_lock);
+
+		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
+			return true;
+	}
 	return false;
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dc43fd790a9c..4a99c09f4164 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
 	if (radeon_is_px(dev)) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	radeon_acpi_fini(rdev);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 7ae1d9ac0574..57039cf42ea7 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -6,6 +6,7 @@
 #ifndef _XE_BO_H_
 #define _XE_BO_H_
 
+#include <drm/drm_prime.h>
 #include <drm/ttm/ttm_tt.h>
 
 #include "xe_bo_types.h"
@@ -548,6 +549,19 @@ void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
 
 struct sg_table *xe_bo_sg(struct xe_bo *bo);
 
+/**
+ * xe_bo_sg_is_contiguous() - Check if a BO's DMA address space is contiguous.
+ * @bo: the BO to check (must have a valid sg table, i.e. !xe_bo_is_vram())
+ * @len: required contiguous length in bytes
+ *
+ * Returns true if the first @len bytes of the BO are mapped to a contiguous
+ * DMA address range.
+ */
+static inline bool xe_bo_sg_is_contiguous(struct xe_bo *bo, size_t len)
+{
+	return drm_prime_get_contiguous_size(xe_bo_sg(bo)) >= len;
+}
+
 /*
  * xe_sg_segment_size() - Provides upper limit for sg segment size.
  * @dev: device pointer
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 5fd7b6c460b8..b4410fa8233a 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1043,7 +1043,11 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
-	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	err = devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
+	if (err)
+		goto err_unregister_display;
+
+	return 0;
 
 err_unregister_display:
 	xe_display_unregister(xe);
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 5760251cb685..833e8f385265 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -63,10 +63,14 @@ ads_to_map(struct xe_guc_ads *ads)
 
 /*
  * The Additional Data Struct (ADS) has pointers for different buffers used by
- * the GuC. One single gem object contains the ADS struct itself (guc_ads) and
- * all the extra buffers indirectly linked via the ADS struct's entries.
+ * the GuC. One gem object (ads->bo) contains the ADS struct itself (guc_ads)
+ * and most of the extra buffers linked via the ADS struct's entries.  The UM
+ * fault queues (PAGE_FAULT, PAGE_FAULT_RESPONSE, ACCESS_COUNTER rings) are
+ * kept in a separate BO (ads->um_queue_bo) so that the full memset of ads->bo
+ * performed on every GT reset does not discard fault descriptors already
+ * written into the rings by the GPU.
  *
- * Layout of the ADS blob allocated for the GuC:
+ * Layout of the ADS blob (ads->bo):
  *
  *      +---------------------------------------+ <== base
  *      | guc_ads                               |
@@ -98,10 +102,6 @@ ads_to_map(struct xe_guc_ads *ads)
  *      +---------------------------------------+
  *      | padding                               |
  *      +---------------------------------------+ <== 4K aligned
- *      | UM queues                             |
- *      +---------------------------------------+
- *      | padding                               |
- *      +---------------------------------------+ <== 4K aligned
  *      | private data                          |
  *      +---------------------------------------+
  *      | padding                               |
@@ -155,16 +155,6 @@ static size_t guc_ads_capture_size(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(ads->capture_size);
 }
 
-static size_t guc_ads_um_queues_size(struct xe_guc_ads *ads)
-{
-	struct xe_device *xe = ads_to_xe(ads);
-
-	if (!xe->info.has_usm)
-		return 0;
-
-	return GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX;
-}
-
 static size_t guc_ads_private_data_size(struct xe_guc_ads *ads)
 {
 	return PAGE_ALIGN(ads_to_guc(ads)->fw.private_data_size);
@@ -205,22 +195,12 @@ static size_t guc_ads_capture_offset(struct xe_guc_ads *ads)
 	return PAGE_ALIGN(offset);
 }
 
-static size_t guc_ads_um_queues_offset(struct xe_guc_ads *ads)
-{
-	u32 offset;
-
-	offset = guc_ads_capture_offset(ads) +
-		 guc_ads_capture_size(ads);
-
-	return PAGE_ALIGN(offset);
-}
-
 static size_t guc_ads_private_data_offset(struct xe_guc_ads *ads)
 {
 	size_t offset;
 
-	offset = guc_ads_um_queues_offset(ads) +
-		guc_ads_um_queues_size(ads);
+	offset = guc_ads_capture_offset(ads) +
+		guc_ads_capture_size(ads);
 
 	return PAGE_ALIGN(offset);
 }
@@ -406,6 +386,49 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 
 	ads->bo = bo;
 
+	if (xe->info.has_usm) {
+		/*
+		 * Allocate a separate BO for the HW fault ring (UM queues).
+		 *
+		 * Round the size up to the next power of two so that on iGPU
+		 * (system memory, no IOMMU) the TTM pool issues a single
+		 * alloc_pages(order=N) call, maximising the chance of getting
+		 * a physically contiguous block.  GuC requires contiguous DPA.
+		 */
+		size_t um_size = IS_DGFX(xe) ?
+				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
+				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+						    GUC_UM_HW_QUEUE_MAX);
+
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
+			       XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
+		if (IS_ERR(bo))
+			return PTR_ERR(bo);
+
+		/*
+		 * On pre-Xe3p platforms, GAM (not GuC) accesses the UM queue
+		 * ring via base_dpa, which must be a contiguous DMA address
+		 * range.  Verify that the allocated pages are contiguous in
+		 * DMA address space.
+		 */
+		if (!xe_bo_is_vram(bo) &&
+		    !xe_guc_using_main_gamctrl_queues(ads_to_guc(ads)) &&
+		    unlikely(!xe_bo_sg_is_contiguous(bo,
+						     GUC_UM_QUEUE_SIZE *
+						     GUC_UM_HW_QUEUE_MAX))) {
+			drm_err(&xe->drm,
+				"UM fault queue memory is not contiguous in DMA address space; GAM requires contiguous DPA\n");
+			return -ENOMEM;
+		}
+
+		ads->um_queue_bo = bo;
+	}
+
 	return 0;
 }
 ALLOW_ERROR_INJECTION(xe_guc_ads_init, ERRNO); /* See xe_pci_probe() */
@@ -819,7 +842,7 @@ static void guc_mmio_reg_state_init(struct xe_guc_ads *ads)
 
 static void guc_um_init_params(struct xe_guc_ads *ads)
 {
-	u32 um_queue_offset = guc_ads_um_queues_offset(ads);
+	struct xe_bo *um_bo = ads->um_queue_bo;
 	struct xe_guc *guc = ads_to_guc(ads);
 	struct xe_device *xe = ads_to_xe(ads);
 	u64 base_dpa;
@@ -829,8 +852,14 @@ static void guc_um_init_params(struct xe_guc_ads *ads)
 
 	with_dpa = !xe_guc_using_main_gamctrl_queues(guc);
 
-	base_ggtt = xe_bo_ggtt_addr(ads->bo) + um_queue_offset;
-	base_dpa = xe_bo_main_addr(ads->bo, PAGE_SIZE) + um_queue_offset;
+	if (um_bo) {
+		/* All USM platforms: UM queues in dedicated um_queue_bo */
+		base_ggtt = xe_bo_ggtt_addr(um_bo);
+		base_dpa = xe_bo_main_addr(um_bo, PAGE_SIZE);
+	} else {
+		/* Platform does not support USM: no UM queues, nothing to do */
+		return;
+	}
 
 	for (i = 0; i < GUC_UM_HW_QUEUE_MAX; ++i) {
 		/*
diff --git a/drivers/gpu/drm/xe/xe_guc_ads_types.h b/drivers/gpu/drm/xe/xe_guc_ads_types.h
index 48a8e092023f..845c1fbd93a4 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_ads_types.h
@@ -16,6 +16,11 @@ struct xe_bo;
 struct xe_guc_ads {
 	/** @bo: Xe BO for GuC ads blob */
 	struct xe_bo *bo;
+	/**
+	 * @um_queue_bo: Dedicated BO for the HW fault ring (UM queues).
+	 * NULL if the platform does not support USM.
+	 */
+	struct xe_bo *um_queue_bo;
 	/** @golden_lrc_size: golden LRC size */
 	size_t golden_lrc_size;
 	/** @regset_size: size of register set passed to GuC for save/restore */
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index bb8c4e793492..e3d080d23b8b 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -890,10 +890,28 @@ void xe_guc_pc_init_early(struct xe_guc_pc *pc)
 	pc_init_fused_rp_values(pc);
 }
 
+static bool pc_needs_min_freq_change(struct xe_guc_pc *pc)
+{
+	struct xe_device *xe = pc_to_xe(pc);
+	struct xe_gt *gt = pc_to_gt(pc);
+
+	if (XE_DEVICE_WA(xe, 14022085890))
+		return true;
+
+	if (xe_gt_is_media_type(gt))
+		return false;
+
+	if (xe->info.platform == XE_BATTLEMAGE ||
+	    xe->info.platform == XE_CRESCENTISLAND)
+		return true;
+
+	return false;
+}
+
 static int pc_adjust_freq_bounds(struct xe_guc_pc *pc)
 {
-	struct xe_tile *tile = gt_to_tile(pc_to_gt(pc));
 	int ret;
+	u32 min_freq;
 
 	lockdep_assert_held(&pc->freq_lock);
 
@@ -916,11 +934,28 @@ static int pc_adjust_freq_bounds(struct xe_guc_pc *pc)
 	 * Same thing happens for Server platforms where min is listed as
 	 * RPMax
 	 */
-	if (pc_get_min_freq(pc) > pc->rp0_freq)
+	min_freq = pc_get_min_freq(pc);
+	if (min_freq > pc->rp0_freq) {
 		ret = pc_set_min_freq(pc, pc->rp0_freq);
+		if (ret)
+			goto out;
 
-	if (XE_DEVICE_WA(tile_to_xe(tile), 14022085890))
-		ret = pc_set_min_freq(pc, max(BMG_MIN_FREQ, pc_get_min_freq(pc)));
+		min_freq = pc->rp0_freq;
+	}
+
+	/*
+	 * Setting GT RP min frequency to 1.2GHz by default for
+	 * GT0(Graphics) Tile of BMG and CRI.
+	 *
+	 * While BMG G21 WA will apply min frequency for
+	 * both GT0(Graphics) and GT1(Media) Tile.
+	 *
+	 * This is an active frequency, so if the device is idle
+	 * we aren't expecting high power output across board
+	 *
+	 */
+	if (pc_needs_min_freq_change(pc) && min_freq < BMG_MIN_FREQ)
+		ret = pc_set_min_freq(pc, BMG_MIN_FREQ);
 
 out:
 	return ret;
diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 4af9f0d7c6f3..9520dfbfde1c 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1820,6 +1820,13 @@ void xe_lrc_write_ring(struct xe_lrc *lrc, const void *data, size_t size)
 
 		__xe_lrc_write_ring(lrc, ring, &noop, sizeof(noop));
 	}
+
+	/*
+	 * The ring and the LRC context image are both WC, so the ring tail
+	 * update which publishes these writes can become visible to the device
+	 * first. Ensure the ring contents are visible before returning.
+	 */
+	xe_device_wmb(xe);
 }
 
 u64 xe_lrc_descriptor(struct xe_lrc *lrc)
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 5111c6519c6d..cd23a020be20 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1568,6 +1568,10 @@ static long xe_oa_config_locked(struct xe_oa_stream *stream, u64 arg)
 		config = xchg(&stream->oa_config, config);
 		drm_dbg(&stream->oa->xe->drm, "changed to oa config uuid=%s\n",
 			stream->oa_config->uuid);
+	} else {
+		while (param.num_syncs--)
+			xe_sync_entry_cleanup(&param.syncs[param.num_syncs]);
+		kfree(param.syncs);
 	}
 
 err_config_put:
@@ -2691,9 +2695,7 @@ static int xe_oa_init_gt(struct xe_gt *gt)
 
 	__xe_oa_init_oa_units(gt);
 
-	drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
-
-	return 0;
+	return drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->oa.gt_lock);
 }
 
 static void xe_oa_print_gt_oa_units(struct xe_gt *gt)
@@ -2833,7 +2835,10 @@ int xe_oa_init(struct xe_device *xe)
 	oa->xe = xe;
 	oa->oa_formats = oa_formats;
 
-	drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
+	ret = drmm_mutex_init(&oa->xe->drm, &oa->metrics_lock);
+	if (ret)
+		goto exit;
+
 	idr_init_base(&oa->metrics_idr, 1);
 
 	ret = xe_oa_init_oa_units(oa);
diff --git a/drivers/gpu/drm/xe/xe_pxp.c b/drivers/gpu/drm/xe/xe_pxp.c
index 7244090b0782..30a581b1e7fc 100644
--- a/drivers/gpu/drm/xe/xe_pxp.c
+++ b/drivers/gpu/drm/xe/xe_pxp.c
@@ -8,6 +8,8 @@
 #include <drm/drm_managed.h>
 #include <uapi/drm/xe_drm.h>
 
+#include <linux/device.h>
+
 #include "xe_bo.h"
 #include "xe_bo_types.h"
 #include "xe_device_types.h"
@@ -162,16 +164,9 @@ static void mark_termination_in_progress(struct xe_pxp *pxp)
 	pxp->status = XE_PXP_TERMINATION_IN_PROGRESS;
 }
 
-static void pxp_terminate(struct xe_pxp *pxp)
+static bool pxp_prep_for_termination(struct xe_pxp *pxp)
 {
-	int ret = 0;
-	struct xe_device *xe = pxp->xe;
-
-	if (!wait_for_completion_timeout(&pxp->activation,
-					 msecs_to_jiffies(PXP_ACTIVATION_TIMEOUT_MS)))
-		drm_err(&xe->drm, "failed to wait for PXP start before termination\n");
-
-	mutex_lock(&pxp->mutex);
+	lockdep_assert_held(&pxp->mutex);
 
 	if (pxp->status == XE_PXP_ACTIVE)
 		pxp->key_instance++;
@@ -180,10 +175,8 @@ static void pxp_terminate(struct xe_pxp *pxp)
 	 * we'll mark the status as needing termination on resume, so no need to
 	 * emit a termination now.
 	 */
-	if (pxp->status == XE_PXP_SUSPENDED) {
-		mutex_unlock(&pxp->mutex);
-		return;
-	}
+	if (pxp->status == XE_PXP_SUSPENDED)
+		return false;
 
 	/*
 	 * If we have a termination already in progress, we need to wait for
@@ -193,15 +186,44 @@ static void pxp_terminate(struct xe_pxp *pxp)
 	 */
 	if (pxp->status == XE_PXP_TERMINATION_IN_PROGRESS) {
 		pxp->status = XE_PXP_NEEDS_ADDITIONAL_TERMINATION;
-		mutex_unlock(&pxp->mutex);
-		return;
+		return false;
 	}
 
 	mark_termination_in_progress(pxp);
 
-	mutex_unlock(&pxp->mutex);
+	return true;
+}
+
+static void pxp_terminate(struct xe_pxp *pxp, bool hw_only)
+{
+	struct xe_device *xe = pxp->xe;
+	int ret = 0;
 
-	pxp_invalidate_queues(pxp);
+	if (!wait_for_completion_timeout(&pxp->activation,
+					 msecs_to_jiffies(PXP_ACTIVATION_TIMEOUT_MS)))
+		drm_err(&xe->drm, "failed to wait for PXP start before termination\n");
+
+	if (!hw_only) {
+		bool prep_ok;
+
+		mutex_lock(&pxp->mutex);
+
+		prep_ok = pxp_prep_for_termination(pxp);
+
+		mutex_unlock(&pxp->mutex);
+
+		if (!prep_ok)
+			return;
+
+		pxp_invalidate_queues(pxp);
+	} else {
+		/*
+		 * The caller of the HW-only termination should have already
+		 * called pxp_prep_for_termination and marked the termination as
+		 * in progress.
+		 */
+		xe_assert(xe, !completion_done(&pxp->termination));
+	}
 
 	ret = pxp_terminate_hw(pxp);
 	if (ret) {
@@ -247,33 +269,46 @@ static void pxp_terminate_complete(struct xe_pxp *pxp)
 	mutex_unlock(&pxp->mutex);
 }
 
-static void pxp_irq_work(struct work_struct *work)
+static void pxp_events_work(struct work_struct *work)
 {
-	struct xe_pxp *pxp = container_of(work, typeof(*pxp), irq.work);
+	struct xe_pxp *pxp = container_of(work, typeof(*pxp), events.work);
 	struct xe_device *xe = pxp->xe;
+	bool hw_only = false;
 	u32 events = 0;
 
-	spin_lock_irq(&xe->irq.lock);
-	events = pxp->irq.events;
-	pxp->irq.events = 0;
-	spin_unlock_irq(&xe->irq.lock);
+	events = atomic_xchg(&pxp->events.pending, 0);
 
 	if (!events)
 		return;
 
 	/*
-	 * If we're processing a termination irq while suspending then don't
-	 * bother, we're going to re-init everything on resume anyway.
+	 * If the termination request comes from an irq while we're suspending,
+	 * then we can defer it to the resume path instead of waking the device
+	 * up.
+	 * In the case of the termination on resume the pm reference is taken
+	 * in xe_pxp_pm_resume() and released here.
+	 * Note that we do not expect both events to be set at the same time,
+	 * but if it does happen due to a spurious interrupt we want to behave
+	 * as if the only request we got was the one from the resume path; this
+	 * is because the termination prep has already been done in
+	 * xe_pxp_pm_resume() and it is impossible for any PXP operations to
+	 * occur between the prep and the termination completion, so there is no
+	 * need for a new SW prep.
 	 */
-	if ((events & PXP_TERMINATION_REQUEST) && !xe_pm_runtime_get_if_active(xe))
+	if (events & PXP_TERMINATION_REQUEST_ON_RESUME) {
+		events &= ~PXP_TERMINATION_REQUEST_IRQ;
+		hw_only = true;
+	}
+
+	if ((events & PXP_TERMINATION_REQUEST_IRQ) && !xe_pm_runtime_get_if_active(xe))
 		return;
 
 	if (events & PXP_TERMINATION_REQUEST) {
-		events &= ~PXP_TERMINATION_COMPLETE;
-		pxp_terminate(pxp);
+		events &= ~PXP_TERMINATION_COMPLETE_IRQ;
+		pxp_terminate(pxp, hw_only);
 	}
 
-	if (events & PXP_TERMINATION_COMPLETE)
+	if (events & PXP_TERMINATION_COMPLETE_IRQ)
 		pxp_terminate_complete(pxp);
 
 	if (events & PXP_TERMINATION_REQUEST)
@@ -294,20 +329,18 @@ void xe_pxp_irq_handler(struct xe_device *xe, u16 iir)
 		return;
 	}
 
-	lockdep_assert_held(&xe->irq.lock);
-
 	if (unlikely(!iir))
 		return;
 
 	if (iir & (KCR_PXP_STATE_TERMINATED_INTERRUPT |
 		   KCR_APP_TERMINATED_PER_FW_REQ_INTERRUPT))
-		pxp->irq.events |= PXP_TERMINATION_REQUEST;
+		atomic_or(PXP_TERMINATION_REQUEST_IRQ, &pxp->events.pending);
 
 	if (iir & KCR_PXP_STATE_RESET_COMPLETE_INTERRUPT)
-		pxp->irq.events |= PXP_TERMINATION_COMPLETE;
+		atomic_or(PXP_TERMINATION_COMPLETE_IRQ, &pxp->events.pending);
 
-	if (pxp->irq.events)
-		queue_work(pxp->irq.wq, &pxp->irq.work);
+	if (atomic_read(&pxp->events.pending))
+		queue_work(pxp->events.wq, &pxp->events.work);
 }
 
 static int kcr_pxp_set_status(const struct xe_pxp *pxp, bool enable)
@@ -338,7 +371,7 @@ static void pxp_fini(void *arg)
 {
 	struct xe_pxp *pxp = arg;
 
-	destroy_workqueue(pxp->irq.wq);
+	destroy_workqueue(pxp->events.wq);
 	xe_pxp_destroy_execution_resources(pxp);
 
 	/* no need to explicitly disable KCR since we're going to do an FLR */
@@ -400,7 +433,7 @@ int xe_pxp_init(struct xe_device *xe)
 
 	INIT_LIST_HEAD(&pxp->queues.list);
 	spin_lock_init(&pxp->queues.lock);
-	INIT_WORK(&pxp->irq.work, pxp_irq_work);
+	INIT_WORK(&pxp->events.work, pxp_events_work);
 	pxp->xe = xe;
 	pxp->gt = gt;
 
@@ -419,8 +452,8 @@ int xe_pxp_init(struct xe_device *xe)
 
 	mutex_init(&pxp->mutex);
 
-	pxp->irq.wq = alloc_ordered_workqueue("pxp-wq", 0);
-	if (!pxp->irq.wq) {
+	pxp->events.wq = alloc_ordered_workqueue("pxp-wq", 0);
+	if (!pxp->events.wq) {
 		err = -ENOMEM;
 		goto out_free;
 	}
@@ -440,7 +473,7 @@ int xe_pxp_init(struct xe_device *xe)
 out_kcr_disable:
 	kcr_pxp_disable(pxp);
 out_wq:
-	destroy_workqueue(pxp->irq.wq);
+	destroy_workqueue(pxp->events.wq);
 out_free:
 	drmm_kfree(&xe->drm, pxp);
 out:
@@ -883,6 +916,7 @@ int xe_pxp_pm_suspend(struct xe_pxp *pxp)
 		fallthrough;
 	case XE_PXP_ACTIVE:
 		pxp->key_instance++;
+		pxp->needs_termination_on_resume = true;
 		needs_queue_inval = true;
 		break;
 	}
@@ -918,6 +952,7 @@ int xe_pxp_pm_suspend(struct xe_pxp *pxp)
  */
 void xe_pxp_pm_resume(struct xe_pxp *pxp)
 {
+	bool has_pm = false;
 	int err;
 
 	if (!xe_pxp_is_enabled(pxp))
@@ -925,14 +960,57 @@ void xe_pxp_pm_resume(struct xe_pxp *pxp)
 
 	err = kcr_pxp_enable(pxp);
 
+	/*
+	 * We want to avoid the device runtime suspending before we're done with
+	 * the termination queued below, so we need a runtime PM reference; we
+	 * can't call the rpm functions from within the PXP lock, so we take the
+	 * ref here. Note that we don't want the rpm resume code to actually run
+	 * here as that would call back into this function, but as long as we
+	 * don't enable DPM_FLAG_SMART_SUSPEND (which we currently do not) we're
+	 * guaranteed to not be runtime suspended at this point, so we can
+	 * safely use the get_noresume variant.
+	 */
+	if (pxp->needs_termination_on_resume) {
+		has_pm = true;
+
+		xe_assert(pxp->xe, !dev_pm_smart_suspend(pxp->xe->drm.dev));
+		xe_pm_runtime_get_noresume(pxp->xe);
+	}
+
 	mutex_lock(&pxp->mutex);
 
 	xe_assert(pxp->xe, pxp->status == XE_PXP_SUSPENDED);
 
-	if (err)
+	if (err) {
 		pxp->status = XE_PXP_ERROR;
-	else
+	} else {
 		pxp->status = XE_PXP_NEEDS_TERMINATION;
 
+		if (pxp->needs_termination_on_resume) {
+			pxp->needs_termination_on_resume = false;
+
+			/*
+			 * We can't call pxp_terminate_hw directly from here
+			 * because we're not allowed to do allocations within
+			 * the rpm resume call, so we defer the termination to
+			 * the worker that we use for the termination irqs.
+			 * However, we do not want any PXP ops to go through
+			 * between the suspend completing and the worker
+			 * starting, so we need to do the termination prep
+			 * immediately, which will mark the termination as in
+			 * progress and stall PXP ops.
+			 */
+			if (pxp_prep_for_termination(pxp)) {
+				has_pm = false; /* move PM ref ownership to worker */
+
+				atomic_or(PXP_TERMINATION_REQUEST_ON_RESUME, &pxp->events.pending);
+				queue_work(pxp->events.wq, &pxp->events.work);
+			}
+		}
+	}
+
 	mutex_unlock(&pxp->mutex);
+
+	if (has_pm)
+		xe_pm_runtime_put(pxp->xe);
 }
diff --git a/drivers/gpu/drm/xe/xe_pxp_types.h b/drivers/gpu/drm/xe/xe_pxp_types.h
index 53e9d48d10fb..f24e0ed456e6 100644
--- a/drivers/gpu/drm/xe/xe_pxp_types.h
+++ b/drivers/gpu/drm/xe/xe_pxp_types.h
@@ -85,17 +85,20 @@ struct xe_pxp {
 	/** @gsc_res: kernel-owned objects for PXP submissions to the GSCCS */
 	struct xe_pxp_gsc_client_resources gsc_res;
 
-	/** @irq: wrapper for the worker and queue used for PXP irq support */
+	/** @events: wrapper for the worker and queue used for PXP event handling */
 	struct {
-		/** @irq.work: worker that manages irq events. */
+		/** @events.work: worker that manages termination events. */
 		struct work_struct work;
-		/** @irq.wq: workqueue on which to queue the irq work. */
+		/** @events.wq: workqueue on which to queue the work. */
 		struct workqueue_struct *wq;
-		/** @irq.events: pending events, protected with xe->irq.lock. */
-		u32 events;
-#define PXP_TERMINATION_REQUEST  BIT(0)
-#define PXP_TERMINATION_COMPLETE BIT(1)
-	} irq;
+		/** @events.pending: pending events */
+		atomic_t pending;
+#define PXP_TERMINATION_REQUEST_IRQ		BIT(0)
+#define PXP_TERMINATION_REQUEST_ON_RESUME	BIT(1)
+#define PXP_TERMINATION_REQUEST	(PXP_TERMINATION_REQUEST_IRQ | \
+				 PXP_TERMINATION_REQUEST_ON_RESUME)
+#define PXP_TERMINATION_COMPLETE_IRQ		BIT(2)
+	} events;
 
 	/** @mutex: protects the pxp status and the queue list */
 	struct mutex mutex;
@@ -130,6 +133,14 @@ struct xe_pxp {
 	 * suspend cycles.
 	 */
 	u32 last_suspend_key_instance;
+	/**
+	 * @needs_termination_on_resume: indicates if PXP termination is needed
+	 * on resume. This is set if PXP was active when we suspend and it is
+	 * cleared when we queue the termination on resume. Since the suspend
+	 * and resume calls cannot execute at the same time, this variable does
+	 * not need to be protected by the PXP lock.
+	 */
+	bool needs_termination_on_resume;
 };
 
 #endif /* __XE_PXP_TYPES_H__ */
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index effa76bfd8f9..01fee14054fb 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -155,6 +155,9 @@ void iforce_process_packet(struct iforce *iforce,
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_X,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_Y,
@@ -170,6 +173,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x03:	/* wheel position data */
+		if (len < 7)
+			break;
+
 		input_report_abs(dev, ABS_WHEEL,
 				 (__s16) get_unaligned_le16(data));
 		input_report_abs(dev, ABS_GAS,   255 - data[2]);
@@ -181,6 +187,9 @@ void iforce_process_packet(struct iforce *iforce,
 		break;
 
 	case 0x02:	/* status report */
+		if (len < 2)
+			break;
+
 		input_report_key(dev, BTN_DEAD, data[0] & 0x02);
 		input_sync(dev);
 
@@ -200,7 +209,7 @@ void iforce_process_packet(struct iforce *iforce,
 			}
 		}
 
-		for (j = 3; j < len; j += 2)
+		for (j = 3; j + sizeof(u16) <= len; j += sizeof(u16))
 			mark_core_as_ready(iforce, get_unaligned_le16(data + j));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 0482eaaecf39..f04370e4191e 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -158,6 +158,9 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
+	if (!urb->actual_length)
+		goto exit;
+
 	iforce_process_packet(iforce, iforce_usb->data_in[0],
 			      iforce_usb->data_in + 1, urb->actual_length - 1);
 
diff --git a/drivers/input/joystick/psxpad-spi.c b/drivers/input/joystick/psxpad-spi.c
index f902a56d011f..aac77a2cfe46 100644
--- a/drivers/input/joystick/psxpad-spi.c
+++ b/drivers/input/joystick/psxpad-spi.c
@@ -373,6 +373,7 @@ static int psxpad_spi_probe(struct spi_device *spi)
 		return err;
 	}
 
+	spi_set_drvdata(spi, pad);
 	pm_runtime_enable(&spi->dev);
 
 	return 0;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..2da0b7f1722a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -394,6 +394,7 @@ static const struct xpad_device {
 	{ 0x3285, 0x0646, "Nacon Pro Compact", 0, XTYPE_XBOXONE },
 	{ 0x3285, 0x0662, "Nacon Revolution5 Pro", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
+	{ 0x3507, 0x000b, "ZENAIM LEVERLESS", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
@@ -557,6 +558,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x31e3),		/* Wooting Keyboards */
 	XPAD_XBOX360_VENDOR(0x3285),		/* Nacon GC-100 */
 	XPAD_XBOXONE_VENDOR(0x3285),		/* Nacon Evol-X */
+	XPAD_XBOX360_VENDOR(0x3507),		/* ZENAIM Controllers */
 	XPAD_XBOX360_VENDOR(0x3537),		/* GameSir Controllers */
 	XPAD_XBOXONE_VENDOR(0x3537),		/* GameSir Controllers */
 	XPAD_XBOX360_VENDOR(0x3651),		/* CRKD Controllers */
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 8cb4dc6fb165..4c82e988260e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1916,6 +1916,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
@@ -1923,6 +1930,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* HONOR MagicBook Pro 14 2026 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
@@ -1932,9 +1947,10 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
+		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 996d6c38cca4..7ef4534fea2f 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -139,10 +139,10 @@ static struct cs40l50_effect *cs40l50_find_effect(int id, struct list_head *effe
 static int cs40l50_effect_bank_set(struct cs40l50_work *work_data,
 				   struct cs40l50_effect *effect)
 {
-	s16 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
+	u32 bank_type = work_data->custom_data[0] & CS40L50_CUSTOM_DATA_MASK;
 
 	if (bank_type >= CS40L50_WVFRM_BANK_NUM) {
-		dev_err(work_data->vib->dev, "Invalid bank (%d)\n", bank_type);
+		dev_err(work_data->vib->dev, "Invalid bank (%u)\n", bank_type);
 		return -EINVAL;
 	}
 
@@ -326,6 +326,12 @@ static int cs40l50_add(struct input_dev *dev, struct ff_effect *effect,
 		return -EINVAL;
 	}
 
+	if (periodic->custom_len < CS40L50_OWT_CUSTOM_DATA_SIZE) {
+		dev_err(vib->dev, "Invalid custom data length (%u)\n",
+			periodic->custom_len);
+		return -EINVAL;
+	}
+
 	work_data.custom_data = memdup_array_user(effect->u.periodic.custom_data,
 						  effect->u.periodic.custom_len,
 						  sizeof(s16));
diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index f5770a3af2f1..5fc3c629590a 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -423,7 +423,7 @@ static void byd_disconnect(struct psmouse *psmouse)
 	struct byd_data *priv = psmouse->private;
 
 	if (priv) {
-		timer_delete(&priv->timer);
+		timer_shutdown_sync(&priv->timer);
 		kfree(psmouse->private);
 		psmouse->private = NULL;
 	}
diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 43f9939b7c63..d3ad4af5aa09 100644
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
index 61909e1a39e2..6c6cdec7da9e 100644
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
@@ -444,7 +452,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
 
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
@@ -545,7 +558,14 @@ static void rmi_f54_work(struct work_struct *work)
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
@@ -556,7 +576,7 @@ static void rmi_f54_work(struct work_struct *work)
 			 &command);
 	if (error) {
 		dev_err(&fn->dev, "Failed to read back command\n");
-		goto error;
+		goto out;
 	}
 	if (command & F54_GET_REPORT) {
 		if (time_after(jiffies, f54->timeout)) {
@@ -564,7 +584,7 @@ static void rmi_f54_work(struct work_struct *work)
 			error = -ETIMEDOUT;
 		}
 		report_size = 0;
-		goto error;
+		goto out;
 	}
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Get report command completed, reading data\n");
@@ -579,7 +599,7 @@ static void rmi_f54_work(struct work_struct *work)
 					fifo, sizeof(fifo));
 		if (error) {
 			dev_err(&fn->dev, "Failed to set fifo start offset\n");
-			goto abort;
+			goto out;
 		}
 
 		error = rmi_read_block(fn->rmi_dev, fn->fd.data_base_addr +
@@ -588,16 +608,17 @@ static void rmi_f54_work(struct work_struct *work)
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
@@ -678,8 +699,8 @@ static int rmi_f54_probe(struct rmi_function *fn)
 
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
diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/touchscreen/hynitron_cstxxx.c
index 1d8ca90dcda6..af66d91848b3 100644
--- a/drivers/input/touchscreen/hynitron_cstxxx.c
+++ b/drivers/input/touchscreen/hynitron_cstxxx.c
@@ -313,6 +313,12 @@ static void cst3xx_touch_report(struct i2c_client *client)
 		return;
 
 	touch_cnt = buf[5] & CST3XX_TOUCH_COUNT_MASK;
+	if (touch_cnt > ts_data->chip->max_touch_num) {
+		dev_err(&client->dev, "cst3xx invalid touch count (%d vs %d max)\n",
+			touch_cnt, ts_data->chip->max_touch_num);
+		return;
+	}
+
 	/*
 	 * Check the check bit of the last touch slot. The check bit is
 	 * always present after touch point 1 for valid data, and then
@@ -335,9 +341,10 @@ static void cst3xx_touch_report(struct i2c_client *client)
 		finger_id = (buf[idx] >> 4) & 0x0f;
 
 		/* Sanity check we don't have more fingers than we expect */
-		if (ts_data->chip->max_touch_num < finger_id) {
-			dev_err(&client->dev, "cst3xx touch read failure\n");
-			break;
+		if (finger_id >= ts_data->chip->max_touch_num) {
+			dev_err(&client->dev,
+				"cst3xx invalid finger id %d\n", finger_id);
+			return;
 		}
 
 		/* sw value of 0 means no touch, 0x03 means touch */
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index fe63d53d56db..e9089b0c3e2f 100644
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
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 3b4928f5b9b2..8f4df250a77a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2610,6 +2610,8 @@ static void atmci_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), host);
 
+	cancel_work_sync(&host->bh_work);
+
 	clk_disable_unprepare(host->mck);
 
 	pm_runtime_disable(dev);
diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index f553e92fd9e5..118eccbaf8cd 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -641,8 +641,8 @@ static void ls2k0500_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
 		return;
 
 	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
-		data = sg_virt(&sg[i]);
-		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+		data = sg_virt(sg);
+		for (j = 0; j < (sg_dma_len(sg) / 4); j++)
 			if (cmd->opcode == SD_SWITCH)
 				data[j] = bitrev8x4(data[j]);
 			else
@@ -758,8 +758,8 @@ static void ls2k2000_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
 		return;
 
 	for_each_sg(cmd->data->sg, sg, cmd->data->sg_len, i) {
-		data = sg_virt(&sg[i]);
-		for (j = 0; j < (sg_dma_len(&sg[i]) / 4); j++)
+		data = sg_virt(sg);
+		for (j = 0; j < (sg_dma_len(sg) / 4); j++)
 			data[j] = bitrev8x4(data[j]);
 	}
 }
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58c881f2725b..3356ac5a1fa0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1357,7 +1357,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
 		if (req->cmd->flags & MMC_RSP_BUSY) {
-			timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
+			timeout = (u64)req->cmd->busy_timeout * NSEC_PER_MSEC;
 
 			/*
 			 * Set an arbitrary 100ms data timeout for commands with
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e3bf901b10aa..efb4c7742fe2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4187,6 +4187,14 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
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
@@ -4247,6 +4255,14 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
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
 
 out:
 	/* Lie about this since we're bouncing */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b6a571d866fa..f0fd81409a86 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -659,7 +659,7 @@ struct sdhci_host {
 
 	unsigned int		tuning_count;	/* Timer count for re-tuning */
 	unsigned int		tuning_mode;	/* Re-tuning mode supported by host */
-	unsigned int		tuning_err;	/* Error code for re-tuning */
+	int			tuning_err;	/* Error code for re-tuning */
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1cd6e88d4e81..89ad7c1bd124 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11785,10 +11785,21 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 {
 	struct bnxt_irq *irq;
 	u16 tag;
-	int err;
 
 	irq = container_of(notify, struct bnxt_irq, affinity_notify);
 
+#ifdef CONFIG_RFS_ACCEL
+	if (irq->bp->dev->rx_cpu_rmap && irq->ring_nr < irq->bp->rx_nr_rings) {
+		int err;
+
+		err = cpu_rmap_update(irq->bp->dev->rx_cpu_rmap, irq->ring_nr,
+				      mask);
+		if (err)
+			netdev_warn(irq->bp->dev,
+				    "aRFS rmap update failed: %d\n", err);
+	}
+#endif
+
 	if (!irq->bp->tph_mode)
 		return;
 
@@ -11798,20 +11809,11 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 		return;
 
 	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
-				cpumask_first(irq->cpu_mask), &tag))
+				cpumask_first(mask), &tag))
 		return;
 
-	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
-		return;
-
-	netdev_lock(irq->bp->dev);
-	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
-		if (err)
-			netdev_err(irq->bp->dev,
-				   "RX queue restart failed: err=%d\n", err);
-	}
-	netdev_unlock(irq->bp->dev);
+	WRITE_ONCE(irq->new_tag, tag);
+	bnxt_queue_sp_work(irq->bp, BNXT_TPH_UPDATE_SP_EVENT);
 }
 
 static void bnxt_irq_affinity_release(struct kref *ref)
@@ -11862,10 +11864,6 @@ static void bnxt_free_irq(struct bnxt *bp)
 	struct bnxt_irq *irq;
 	int i;
 
-#ifdef CONFIG_RFS_ACCEL
-	free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
-	bp->dev->rx_cpu_rmap = NULL;
-#endif
 	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
@@ -11874,27 +11872,35 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 		irq = &bp->irq_tbl[map_idx];
 		if (irq->requested) {
+			bnxt_release_irq_notifier(irq);
+
 			if (irq->have_cpumask) {
 				irq_update_affinity_hint(irq->vector, NULL);
 				free_cpumask_var(irq->cpu_mask);
 				irq->have_cpumask = 0;
 			}
 
-			bnxt_release_irq_notifier(irq);
-
 			free_irq(irq->vector, bp->bnapi[i]);
 		}
 
 		irq->requested = 0;
+		irq->tag = 0;
+		irq->new_tag = 0;
 	}
 
 	/* Disable TPH support */
 	pcie_disable_tph(bp->pdev);
 	bp->tph_mode = 0;
+
+#ifdef CONFIG_RFS_ACCEL
+	free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
+	bp->dev->rx_cpu_rmap = NULL;
+#endif
 }
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
+	const int numa_node = dev_to_node(&bp->pdev->dev);
 	struct cpu_rmap *rmap = NULL;
 	int i, j, rc = 0;
 	unsigned long flags = 0;
@@ -11917,6 +11923,8 @@ static int bnxt_request_irq(struct bnxt *bp)
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
+		unsigned int cpu_num;
+		u16 tag;
 
 		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
 		    rmap && bp->bnapi[i]->rx_ring) {
@@ -11935,32 +11943,31 @@ static int bnxt_request_irq(struct bnxt *bp)
 		netif_napi_set_irq_locked(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
-		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
-			int numa_node = dev_to_node(&bp->pdev->dev);
-			u16 tag;
-
-			irq->have_cpumask = 1;
-			irq->msix_nr = map_idx;
-			irq->ring_nr = i;
-			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-					irq->cpu_mask);
-			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
-				netdev_warn(bp->dev,
-					    "Update affinity hint failed, IRQ = %d\n",
-					    irq->vector);
-				break;
-			}
+		if (!zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL))
+			continue;
 
-			bnxt_register_irq_notifier(bp, irq);
+		irq->have_cpumask = 1;
+		irq->msix_nr = map_idx;
+		irq->ring_nr = i;
+		cpu_num = cpumask_local_spread(i, numa_node);
+		cpumask_set_cpu(cpu_num, irq->cpu_mask);
+
+		/* Init ST table entry if we can get the mapping */
+		if (!pcie_tph_get_cpu_st(bp->pdev, TPH_MEM_TYPE_VM,
+					 cpu_num, &tag)) {
+			pcie_tph_set_st_entry(bp->pdev, irq->msix_nr, tag);
+			irq->tag = tag;
+			irq->new_tag = tag;
+		}
 
-			/* Init ST table entry */
-			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
-						cpumask_first(irq->cpu_mask),
-						&tag))
-				continue;
+		bnxt_register_irq_notifier(bp, irq);
 
-			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
+		rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
+		if (rc) {
+			netdev_warn(bp->dev,
+				    "Update affinity hint failed, IRQ = %d\n",
+				    irq->vector);
+			break;
 		}
 	}
 	return rc;
@@ -14468,6 +14475,43 @@ static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
 	rtnl_unlock();
 }
 
+static void bnxt_tph_update(struct bnxt *bp)
+{
+	struct net_device *dev = bp->dev;
+	int i;
+
+	bnxt_lock_sp(bp);
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
+		goto unlock;
+
+	for (i = 0; i < bp->rx_nr_rings; i++) {
+		struct bnxt_irq *irq;
+		int map_idx, err;
+		u16 tag;
+
+		map_idx = bnxt_cp_num_to_irq_num(bp, i);
+		irq = &bp->irq_tbl[map_idx];
+		tag = READ_ONCE(irq->new_tag);
+		if (irq->tag == tag)
+			continue;
+
+		if (pcie_tph_set_st_entry(bp->pdev, irq->msix_nr, tag))
+			continue;
+
+		err = netdev_rx_queue_restart(dev, irq->ring_nr);
+		if (err) {
+			netdev_err(dev, "RX queue restart failed: err=%d\n",
+				   err);
+			continue;
+		}
+
+		irq->tag = tag;
+	}
+
+unlock:
+	bnxt_unlock_sp(bp);
+}
+
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
@@ -14900,6 +14944,9 @@ static void bnxt_sp_task(struct work_struct *work)
 			bnxt_devlink_health_fw_report(bp);
 	}
 
+	if (test_and_clear_bit(BNXT_TPH_UPDATE_SP_EVENT, &bp->sp_event))
+		bnxt_tph_update(bp);
+
 	smp_mb__before_atomic();
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 }
@@ -16854,7 +16901,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 {
 	int rc;
 
-	netdev_ops_assert_locked(bp->dev);
+	netdev_assert_locked_ops_compat(bp->dev);
 	bnxt_hwrm_func_qcaps(bp);
 
 	if (netif_running(bp->dev))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 8e04cc934c32..de48ef59b8de 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1268,6 +1268,8 @@ struct bnxt_irq {
 	struct bnxt	*bp;
 	int		msix_nr;
 	int		ring_nr;
+	u16		tag;
+	u16		new_tag;
 	struct irq_affinity_notify affinity_notify;
 };
 
@@ -2644,6 +2646,7 @@ struct bnxt {
 #define BNXT_RING_COAL_NOW_SP_EVENT	17
 #define BNXT_FW_RESET_NOTIFY_SP_EVENT	18
 #define BNXT_FW_EXCEPTION_SP_EVENT	19
+#define BNXT_TPH_UPDATE_SP_EVENT	20
 #define BNXT_LINK_CFG_CHANGE_SP_EVENT	21
 #define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
 #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index 06b1cf4a5efc..1d6c59f4ead3 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -26,6 +26,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
 	return 0;
 }
 
+static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
 static int gve_ptp_gettimex64(struct ptp_clock_info *info,
 			      struct timespec64 *ts,
 			      struct ptp_system_timestamp *sts)
@@ -60,6 +65,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
 static const struct ptp_clock_info gve_ptp_caps = {
 	.owner          = THIS_MODULE,
 	.name		= "gve clock",
+	.adjfine	= gve_ptp_adjfine,
 	.gettimex64	= gve_ptp_gettimex64,
 	.settime64	= gve_ptp_settime64,
 	.do_aux_work	= gve_ptp_do_aux_work,
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8271f731a91f..0ece2f6fdffb 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -886,6 +886,11 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_hsplit_unsplit_pkt += unsplit;
 		rx->rx_hsplit_bytes += hdr_len;
 		u64_stats_update_end(&rx->statss);
+
+		if (!buf_len) {
+			gve_free_buffer(rx, buf_state);
+			return 0;
+		}
 	} else if (!rx->ctx.skb_head && rx->dqo.page_pool &&
 		   netmem_is_net_iov(buf_state->page_info.netmem)) {
 		/* when header split is disabled, the header went to the packet
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7ac75fc8cdcf..601196064b08 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1312,6 +1312,8 @@ static int am65_cpsw_nuss_rx_packets(struct am65_cpsw_rx_flow *flow,
 	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
 	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
+	/* Port ID is contained in the lower 8-bits of the 16-bit Source Tag */
+	port_id &= 0xFF;
 	dev_dbg(dev, "%s rx port_id:%d\n", __func__, port_id);
 	port = am65_common_get_port(common, port_id);
 	ndev = port->ndev;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index d8e3827a8b1f..899c768d97d4 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -180,8 +180,10 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	/* mask interrupt */
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
-	else
+	else if (wx->pdev->msix_enabled)
 		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
+	else
+		wx_intr_enable(wx, BIT(0));
 }
 
 /**
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4e..92d3d340281f 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -146,6 +146,8 @@ static int ipvlan_init(struct net_device *dev)
 	dev->lltx = true;
 	netif_inherit_tso_max(dev, phy_dev);
 	dev->hard_header_len = phy_dev->hard_header_len;
+	dev->needed_headroom = phy_dev->needed_headroom;
+	dev->needed_tailroom = phy_dev->needed_tailroom;
 
 	netdev_lockdep_set_classes(dev);
 
@@ -773,6 +775,8 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
 			netif_inherit_tso_max(ipvlan->dev, dev);
+			ipvlan->dev->needed_headroom = dev->needed_headroom;
+			ipvlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(ipvlan->dev);
 		}
 		break;
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836b..ff2f4bb651b7 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -950,6 +950,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->lltx		= true;
 	netif_inherit_tso_max(dev, lowerdev);
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
@@ -1824,6 +1826,8 @@ static int macvlan_device_event(struct notifier_block *unused,
 	case NETDEV_FEAT_CHANGE:
 		list_for_each_entry(vlan, &port->vlans, list) {
 			netif_inherit_tso_max(vlan->dev, dev);
+			vlan->dev->needed_headroom = dev->needed_headroom;
+			vlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(vlan->dev);
 		}
 		break;
diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
index 90580e32052f..7e545428900a 100644
--- a/drivers/net/ovpn/crypto.c
+++ b/drivers/net/ovpn/crypto.c
@@ -18,20 +18,12 @@
 #include "crypto_aead.h"
 #include "crypto.h"
 
-static void ovpn_ks_destroy_rcu(struct rcu_head *head)
-{
-	struct ovpn_crypto_key_slot *ks;
-
-	ks = container_of(head, struct ovpn_crypto_key_slot, rcu);
-	ovpn_aead_crypto_key_slot_destroy(ks);
-}
-
 void ovpn_crypto_key_slot_release(struct kref *kref)
 {
 	struct ovpn_crypto_key_slot *ks;
 
 	ks = container_of(kref, struct ovpn_crypto_key_slot, refcount);
-	call_rcu(&ks->rcu, ovpn_ks_destroy_rcu);
+	queue_rcu_work(ovpn_wq, &ks->free_work);
 }
 
 /* can only be invoked when all peer references have been dropped (i.e. RCU
@@ -58,15 +50,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
 bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
 {
 	struct ovpn_crypto_key_slot *ks = NULL;
+	struct ovpn_crypto_key_slot *tmp;
+	int slot = 0;
 
 	spin_lock_bh(&cs->lock);
-	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[0], NULL,
-					 lockdep_is_held(&cs->lock));
-	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
-		ks = rcu_replace_pointer(cs->slots[1], NULL,
-					 lockdep_is_held(&cs->lock));
+	tmp = rcu_access_pointer(cs->slots[slot]);
+	if (!tmp || tmp->key_id != key_id) {
+		slot = 1;
+		tmp = rcu_access_pointer(cs->slots[slot]);
 	}
+
+	if (tmp && tmp->key_id == key_id)
+		ks = rcu_replace_pointer(cs->slots[slot], NULL,
+					 lockdep_is_held(&cs->lock));
 	spin_unlock_bh(&cs->lock);
 
 	if (ks)
diff --git a/drivers/net/ovpn/crypto.h b/drivers/net/ovpn/crypto.h
index 0e284fec3a75..e3feb16d5498 100644
--- a/drivers/net/ovpn/crypto.h
+++ b/drivers/net/ovpn/crypto.h
@@ -10,6 +10,8 @@
 #ifndef _NET_OVPN_OVPNCRYPTO_H_
 #define _NET_OVPN_OVPNCRYPTO_H_
 
+#include <linux/workqueue.h>
+
 #include "pktid.h"
 #include "proto.h"
 
@@ -45,8 +47,8 @@ struct ovpn_crypto_key_slot {
 
 	struct ovpn_pktid_recv pid_recv ____cacheline_aligned_in_smp;
 	struct ovpn_pktid_xmit pid_xmit ____cacheline_aligned_in_smp;
+	struct rcu_work free_work;
 	struct kref refcount;
-	struct rcu_head rcu;
 };
 
 struct ovpn_crypto_state {
diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
index 8f07c418622b..74eaf6fac2f5 100644
--- a/drivers/net/ovpn/crypto_aead.c
+++ b/drivers/net/ovpn/crypto_aead.c
@@ -9,6 +9,7 @@
 
 #include <crypto/aead.h>
 #include <linux/skbuff.h>
+#include <linux/workqueue.h>
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
@@ -380,13 +381,19 @@ static struct crypto_aead *ovpn_aead_init(const char *title,
 	return ERR_PTR(ret);
 }
 
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks)
+static void ovpn_aead_crypto_key_slot_free(struct ovpn_crypto_key_slot *ks)
 {
-	if (!ks)
-		return;
-
 	crypto_free_aead(ks->encrypt);
 	crypto_free_aead(ks->decrypt);
+}
+
+static void ovpn_aead_crypto_key_slot_free_work(struct work_struct *work)
+{
+	struct ovpn_crypto_key_slot *ks;
+
+	ks = container_of(to_rcu_work(work), struct ovpn_crypto_key_slot,
+			  free_work);
+	ovpn_aead_crypto_key_slot_free(ks);
 	kfree(ks);
 }
 
@@ -420,6 +427,7 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 
 	ks->encrypt = NULL;
 	ks->decrypt = NULL;
+	INIT_RCU_WORK(&ks->free_work, ovpn_aead_crypto_key_slot_free_work);
 	kref_init(&ks->refcount);
 	ks->key_id = kc->key_id;
 
@@ -453,7 +461,8 @@ ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
 	return ks;
 
 destroy_ks:
-	ovpn_aead_crypto_key_slot_destroy(ks);
+	ovpn_aead_crypto_key_slot_free(ks);
+	kfree(ks);
 	return ERR_PTR(ret);
 }
 
diff --git a/drivers/net/ovpn/crypto_aead.h b/drivers/net/ovpn/crypto_aead.h
index 65a2ff307898..fae3b585a43b 100644
--- a/drivers/net/ovpn/crypto_aead.h
+++ b/drivers/net/ovpn/crypto_aead.h
@@ -22,7 +22,6 @@ int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
 
 struct ovpn_crypto_key_slot *
 ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc);
-void ovpn_aead_crypto_key_slot_destroy(struct ovpn_crypto_key_slot *ks);
 
 enum ovpn_cipher_alg ovpn_aead_crypto_alg(struct ovpn_crypto_key_slot *ks);
 
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 9a66d693039a..9526f8096da6 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -204,10 +204,10 @@ void ovpn_decrypt_post(void *data, int ret)
 		ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 	kfree_skb(skb);
 drop_nocount:
-	if (likely(peer))
-		ovpn_peer_put(peer);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 /* RX path entry point: decrypt packet and forward it to the device */
@@ -302,11 +302,11 @@ void ovpn_encrypt_post(void *data, int ret)
 err:
 	if (unlikely(skb))
 		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
-	if (likely(peer))
-		ovpn_peer_put(peer);
+	kfree_skb(skb);
 	if (likely(ks))
 		ovpn_crypto_key_slot_put(ks);
-	kfree_skb(skb);
+	if (likely(peer))
+		ovpn_peer_put(peer);
 }
 
 static bool ovpn_encrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 168cfe9b59a9..0708249e9607 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/inetdevice.h>
+#include <linux/workqueue.h>
 #include <net/gro_cells.h>
 #include <net/ip.h>
 #include <net/rtnetlink.h>
@@ -26,6 +27,9 @@
 #include "tcp.h"
 #include "udp.h"
 
+/* module-owned workqueue on which all ovpn-specific work is queued */
+struct workqueue_struct *ovpn_wq;
+
 static void ovpn_priv_free(struct net_device *net)
 {
 	struct ovpn_priv *ovpn = netdev_priv(net);
@@ -264,10 +268,16 @@ static int __init ovpn_init(void)
 
 	ovpn_tcp_init();
 
+	ovpn_wq = alloc_workqueue("ovpn", WQ_PERCPU, 0);
+	if (!ovpn_wq) {
+		pr_err("ovpn: cannot allocate workqueue\n");
+		return -ENOMEM;
+	}
+
 	err = rtnl_link_register(&ovpn_link_ops);
 	if (err) {
 		pr_err("ovpn: can't register rtnl link ops: %d\n", err);
-		return err;
+		goto destroy_wq;
 	}
 
 	err = ovpn_nl_register();
@@ -280,6 +290,9 @@ static int __init ovpn_init(void)
 
 unreg_rtnl:
 	rtnl_link_unregister(&ovpn_link_ops);
+destroy_wq:
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
 	return err;
 }
 
@@ -288,7 +301,11 @@ static __exit void ovpn_cleanup(void)
 	ovpn_nl_unregister();
 	rtnl_link_unregister(&ovpn_link_ops);
 
+	flush_workqueue(ovpn_wq);
 	rcu_barrier();
+
+	destroy_workqueue(ovpn_wq);
+	ovpn_wq = NULL;
 }
 
 module_init(ovpn_init);
diff --git a/drivers/net/ovpn/ovpnpriv.h b/drivers/net/ovpn/ovpnpriv.h
index 5898f6adada7..84499140e4bd 100644
--- a/drivers/net/ovpn/ovpnpriv.h
+++ b/drivers/net/ovpn/ovpnpriv.h
@@ -15,6 +15,10 @@
 #include <uapi/linux/if_link.h>
 #include <uapi/linux/ovpn.h>
 
+struct workqueue_struct;
+
+extern struct workqueue_struct *ovpn_wq;
+
 /**
  * struct ovpn_peer_collection - container of peers for MultiPeer mode
  * @by_id: table of peers index by ID
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index b0519f9840d8..c95656ca7c35 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -62,7 +62,7 @@ void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
 	/* now that interval and timeout have been changed, kick
 	 * off the worker so that the next delay can be recomputed
 	 */
-	mod_delayed_work(system_percpu_wq, &peer->ovpn->keepalive_work, 0);
+	mod_delayed_work(ovpn_wq, &peer->ovpn->keepalive_work, 0);
 }
 
 /**
@@ -1371,7 +1371,7 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 			   peer->id);
 		if (WARN_ON(!ovpn_peer_hold(peer)))
 			return 0;
-		if (!schedule_work(&peer->keepalive_work))
+		if (!queue_work(ovpn_wq, &peer->keepalive_work))
 			ovpn_peer_put(peer);
 	}
 
@@ -1463,8 +1463,8 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
 		netdev_dbg(ovpn->dev,
 			   "scheduling keepalive work: now=%llu next_run=%llu delta=%llu\n",
 			   next_run, now, next_run - now);
-		schedule_delayed_work(&ovpn->keepalive_work,
-				      (next_run - now) * HZ);
+		queue_delayed_work(ovpn_wq, &ovpn->keepalive_work,
+				   (next_run - now) * HZ);
 	}
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 0af14055c39a..8fe8a8e750a4 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,7 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	if (!schedule_work(&peer->tcp.defer_del_work))
+	if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
 		ovpn_peer_put(peer);
 	ovpn_dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
@@ -284,13 +284,12 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			 * stream therefore we abort the connection
 			 */
 			ovpn_peer_hold(peer);
-			if (!schedule_work(&peer->tcp.defer_del_work))
+			if (!queue_work(ovpn_wq, &peer->tcp.defer_del_work))
 				ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-			 * which would lead to more invocations of
-			 * schedule_work()
+			 * which would lead to more invocations of queue_work()
 			 */
 			return;
 		}
@@ -487,7 +486,7 @@ static void ovpn_tcp_write_space(struct sock *sk)
 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
 	if (likely(sock && sock->peer)) {
-		schedule_work(&sock->tcp_tx_work);
+		queue_work(ovpn_wq, &sock->tcp_tx_work);
 		sock->peer->tcp.sk_cb.sk_write_space(sk);
 	}
 	rcu_read_unlock();
diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 01bbddeb4a30..cfd81990d367 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1338,7 +1338,7 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	if (devnum == MDIO_MMD_VEND2)
 		ret = rtlgen_write_vend2(phydev, regnum, val);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
-		ret = rtlgen_write_vend2(phydev, regnum, RTL_MDIO_AN_EEE_ADV);
+		ret = rtlgen_write_vend2(phydev, RTL_MDIO_AN_EEE_ADV, val);
 	else
 		ret = -EOPNOTSUPP;
 
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 5d2d34d24ce8..9b5af08cdd47 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1091,12 +1091,13 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 		}
 	}
 
+	skb_probe_transport_header(skb);
+
 	/* Move network header to the right position for VLAN tagged packets */
 	if (eth_type_vlan(skb->protocol) &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 
-	skb_probe_transport_header(skb);
 	dev_queue_xmit(skb);
 	rcu_read_unlock();
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f80f6584a6ff..6ab84c837a33 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -967,7 +967,7 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	struct veth_rq *rq =
 		container_of(napi, struct veth_rq, xdp_napi);
 	struct veth_priv *priv = netdev_priv(rq->dev);
-	int queue_idx = rq->xdp_rxq.queue_index;
+	int queue_idx = rq - priv->rq;
 	struct netdev_queue *peer_txq;
 	struct veth_stats stats = {};
 	struct net_device *peer_dev;
diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
index 3693423459c9..e390f902a444 100644
--- a/drivers/pmdomain/arm/scmi_perf_domain.c
+++ b/drivers/pmdomain/arm/scmi_perf_domain.c
@@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
 		return 0;
 
 	if (!state)
-		return -EINVAL;
+		return 0;
 
 	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
 	if (ret)
diff --git a/drivers/pmdomain/mediatek/mt8183-pm-domains.h b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
index 3742782a2702..5e33b8628e85 100644
--- a/drivers/pmdomain/mediatek/mt8183-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8183-pm-domains.h
@@ -47,7 +47,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
-		.caps = MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8183_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
@@ -57,7 +57,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
-		.caps = MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_DOMAIN_SUPPLY | MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8183_POWER_DOMAIN_MFG_CORE0] = {
 		.name = "mfg_core0",
@@ -67,6 +67,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8183_POWER_DOMAIN_MFG_CORE1] = {
 		.name = "mfg_core1",
@@ -76,6 +77,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 	},
 	[MT8183_POWER_DOMAIN_MFG_2D] = {
 		.name = "mfg_2d",
@@ -85,6 +87,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8183_TOP_AXI_PROT_EN_1_MFG,
diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 3ce6fb74dd53..c7937ff1b836 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -657,7 +657,7 @@ static int mtk_mfg_attach_dev(struct generic_pm_domain *pd, struct device *dev)
 	struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
 	struct dev_pm_opp_data *so = mfg->stack_opps;
 	struct dev_pm_opp_data *go = mfg->gpu_opps;
-	struct dev_pm_opp_data *prev_o;
+	struct dev_pm_opp_data *prev_o = NULL;
 	struct dev_pm_opp_data *o;
 	int i, ret;
 
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f0a6339affd7..6089c8cf5bbc 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -486,16 +486,8 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 	if (ret < 0)
 		return ret;
 
-	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
-		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
-
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
-
-	/* Wait for RTFF HW to sync buck isolation state if this is PCIe PHY RTFF */
-	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
-		udelay(5);
-
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
 	/*
@@ -1058,12 +1050,15 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	node = of_find_node_with_property(np, "mediatek,infracfg");
 	if (node) {
 		regmap[0] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg");
-		of_node_put(node);
 		num_regmaps++;
-		if (IS_ERR(regmap[0]))
-			return dev_err_probe(dev, PTR_ERR(regmap[0]),
+		if (IS_ERR(regmap[0])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[0]),
 					     "%pOF: failed to get infracfg regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[0] = NULL;
 	}
@@ -1072,17 +1067,22 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 	node = of_find_node_with_property(np, "mediatek,smi");
 	if (node) {
 		smi_np = of_parse_phandle(node, "mediatek,smi", 0);
-		of_node_put(node);
-		if (!smi_np)
+		if (!smi_np) {
+			of_node_put(node);
 			return -ENODEV;
+		}
 
 		regmap[1] = device_node_to_regmap(smi_np);
 		num_regmaps++;
 		of_node_put(smi_np);
-		if (IS_ERR(regmap[1]))
-			return dev_err_probe(dev, PTR_ERR(regmap[1]),
+		if (IS_ERR(regmap[1])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[1]),
 					     "%pOF: failed to get SMI regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[1] = NULL;
 	}
diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index ba0cf4694435..fc57f768c92e 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -235,9 +235,13 @@ static struct rpmhpd *eliza_rpmhpds[] = {
 	[RPMHPD_GFX] = &gfx,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MMCX] = &mmcx,
+	[RPMHPD_MMCX_AO] = &mmcx_ao,
 	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_NSP] = &nsp,
 };
 
diff --git a/drivers/regulator/fp9931.c b/drivers/regulator/fp9931.c
index 002b41f53eff..ff743a8b0dfe 100644
--- a/drivers/regulator/fp9931.c
+++ b/drivers/regulator/fp9931.c
@@ -37,48 +37,18 @@ struct fp9931_data {
 };
 
 static const unsigned int VPOSNEG_table[] = {
-	7040000,
-	7040000,
-	7040000,
-	7040000,
-	7040000,
-	7040000,
-	7260000,
-	7490000,
-	7710000,
-	7930000,
-	8150000,
-	8380000,
-	8600000,
-	8820000,
-	9040000,
-	9270000,
-	9490000,
-	9710000,
-	9940000,
-	10160000,
-	10380000,
-	10600000,
-	10830000,
-	11050000,
-	11270000,
-	11490000,
-	11720000,
-	11940000,
-	12160000,
-	12380000,
-	12610000,
-	12830000,
-	13050000,
-	13280000,
-	13500000,
-	13720000,
-	13940000,
-	14170000,
-	14390000,
-	14610000,
-	14830000,
-	15060000,
+	7040000,  7040000,  7040000,  7040000,  7040000,            /* 00h-04h */
+	7260000,  7490000,  7710000,  7930000,  8150000,  8380000,  /* 05h-0Ah */
+	8600000,  8820000,  9040000,  9270000,  9490000,  9710000,  /* 0Bh-10h */
+	9940000,  10160000, 10380000, 10600000, 10830000, 11050000, /* 11h-16h */
+	11270000, 11490000, 11720000, 11940000, 12160000, 12380000, /* 17h-1Ch */
+	12610000, 12830000, 13050000, 13280000, 13500000, 13720000, /* 1Dh-22h */
+	13940000, 14170000, 14390000, 14610000, 14830000, 15060000, /* 23h-28h */
+	/* 29h-3Fh: clamped to 15.06V per datasheet */
+	15060000, 15060000, 15060000, 15060000, 15060000, 15060000,
+	15060000, 15060000, 15060000, 15060000, 15060000, 15060000,
+	15060000, 15060000, 15060000, 15060000, 15060000, 15060000,
+	15060000, 15060000, 15060000, 15060000, 15060000,
 };
 
 static const struct hwmon_channel_info *fp9931_info[] = {
diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 420d89ba7f83..4aff0b58fa5d 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/nospec.h>
 
 #include "vfio_ccw_private.h"
 
@@ -24,11 +25,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_to_user(buf, (void *)region + pos, count))
 		ret = -EFAULT;
 	else
 		ret = count;
+
+out_unlock:
 	mutex_unlock(&private->io_mutex);
 	return ret;
 }
@@ -48,6 +58,12 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
 	if (!mutex_trylock(&private->io_mutex))
 		return -EAGAIN;
 
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 	if (copy_from_user((void *)region + pos, buf, count)) {
 		ret = -EFAULT;
diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 38c176cf6295..7708eb4d6de0 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <linux/vfio.h>
 #include "vfio_ccw_private.h"
 
@@ -26,6 +27,13 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
+
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
 	if (cio_update_schib(sch)) {
@@ -85,19 +93,30 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
 
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
+	mutex_lock(&private->io_mutex);
+	if (i >= private->num_regions) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	i = array_index_nospec(i, private->num_regions);
+	region = private->region[i].data;
+
+	spin_lock_irqsave(&private->crw_lock, flags);
 	crw = list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
 
 	if (crw)
 		list_del(&crw->next);
 
-	mutex_lock(&private->io_mutex);
-	region = private->region[i].data;
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
@@ -108,14 +127,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	region->crw = 0;
-
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
 
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 7561aa7d3e01..58722c4baa25 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source, unsigned long len)
 }
 
 #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
+#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u32))
 
 /*
  * Helpers to operate ccwchain.
@@ -332,6 +333,7 @@ static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 		goto out_err;
 
 	list_add_tail(&chain->next, &cp->ccwchain_list);
+	cp->ccwchain_count++;
 
 	return chain;
 
@@ -376,11 +378,9 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
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
 		 * We want to keep counting if the current CCW has the
 		 * command-chaining flag enabled, or if it is a TIC CCW
@@ -390,15 +390,10 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
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
@@ -441,6 +436,10 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
 	if (len < 0)
 		return len;
 
+	/* Limit number of chains in a single channel program */
+	if (cp->ccwchain_count >= CCWCHAIN_COUNT_MAX)
+		return -EINVAL;
+
 	/* Need alloc a new chain for this one. */
 	chain = ccwchain_alloc(cp, len);
 	if (!chain)
@@ -455,9 +454,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
 	/* Loop for tics on this new chain. */
 	ret = ccwchain_loop_tic(chain, cp);
 
-	if (ret)
-		ccwchain_free(chain);
-
 	return ret;
 }
 
@@ -486,6 +482,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
+static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
+{
+	struct ccwchain *chain, *temp;
+	int ret;
+
+	ret = ccwchain_handle_ccw(cda, cp);
+
+	if (ret) {
+		/* Cleanup if an error occurred */
+		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
+			ccwchain_free(chain);
+		}
+	}
+
+	return ret;
+}
+
 static int ccwchain_fetch_tic(struct ccw1 *ccw,
 			      struct channel_program *cp)
 {
@@ -511,7 +524,8 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	dma64_t *idaws;
 	dma32_t *idaws_f1;
-	int idal_len = idaw_nr * sizeof(*idaws);
+	u64 first_idaw;
+	int idal_len = idaw_nr * get_idaw_size(cp);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
 	int i, ret;
@@ -527,6 +541,18 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, struct channel_program *cp, int
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		idaws_f1 = (dma32_t *)idaws;
+		if (cp->orb.cmd.c64)
+			first_idaw = dma64_to_u64(idaws[0]);
+		else
+			first_idaw = dma32_to_u32(idaws_f1[0]);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw != cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -568,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 	struct vfio_device *vdev =
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	u64 iova;
-	int size = cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
+	int size = get_idaw_size(cp);
 	int ret;
 	int bytes = 1;
 
@@ -592,6 +618,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 		iova = dma32_to_u32(ccw->cda);
 	}
 
+	/* Save the read address for later */
+	cp->guest_iova = iova;
+
 	/* Format-1 IDAWs operate on 2K each */
 	if (!cp->orb.cmd.c64)
 		return idal_2k_nr_words((void *)iova, bytes);
@@ -731,11 +760,12 @@ int cp_init(struct channel_program *cp, union orb *orb)
 			vdev->dev,
 			"Prefetching channel program even though prefetch not specified in ORB");
 
+	cp->ccwchain_count = 0;
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
 
 	/* Build a ccwchain for the first CCW segment */
-	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
+	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
 
 	if (!ret)
 		cp->initialized = true;
@@ -947,17 +977,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
 {
+	struct vfio_ccw_private *private =
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
 
 	if (!cp->initialized)
 		return false;
 
+	mutex_lock(&private->io_mutex);
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length))
+			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
 
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index fc31eb699807..9af98ff12d67 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -23,11 +23,19 @@
  */
 #define CCWCHAIN_LEN_MAX	256
 
+/*
+ * Maximum number of chains
+ */
+#define CCWCHAIN_COUNT_MAX	16
+
 /**
  * struct channel_program - manage information for channel program
  * @ccwchain_list: list head of ccwchains
  * @orb: orb for the currently processed ssch request
  * @initialized: whether this instance is actually initialized
+ * @guest_cp: copy of guest channel program
+ * @ccwchain_count: number of channel program segments (linked by TIC)
+ * @guest_iova: first data address of a guest channel program
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -38,6 +46,8 @@ struct channel_program {
 	union orb orb;
 	bool initialized;
 	struct ccw1 *guest_cp;
+	unsigned int ccwchain_count;
+	u64 guest_iova;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 1a095085bc72..ab6b518cc353 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -91,6 +91,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
@@ -98,9 +99,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished = true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
 
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -110,6 +109,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger);
@@ -118,11 +118,25 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
 
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+}
+
+void vfio_ccw_notoper_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, notoper_work);
+
+	mutex_lock(&private->io_mutex);
+	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 }
 
 /*
@@ -275,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -292,7 +307,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 4d7988ea47ef..5fd94e9d5c61 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -170,8 +170,8 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 
-	/* This is usually handled during CLOSE event */
-	cp_free(&private->cp);
+	/* This routine could be called from IRQ context, so defer */
+	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
 
 /*
@@ -410,7 +410,11 @@ static void fsm_close(struct vfio_ccw_private *private,
 
 	private->state = VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(&sch->lock);
+
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
+
 	return;
 
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 45ec722d25ea..5ce91285c7d5 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -54,6 +54,8 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
 
 	private->cp.guest_cp = kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -130,11 +132,28 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	struct vfio_ccw_private *private =
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 *
+	 * notoper_work should have nothing to do here, because only
+	 * open devices could have channel_program resources in use
+	 * and those would be released during close. Nevertheless,
+	 * call flush here as well to be certain anything that was
+	 * allocated is freed.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
+
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
@@ -202,6 +221,19 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 *
+	 * notoper_work needs to be given a chance to run if it
+	 * is queued, so any memory associated with the channel
+	 * program can be returned.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
 
@@ -243,6 +275,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device *vdev,
 		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->read(private, buf, count,
 							ppos);
 	}
@@ -295,6 +328,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device *vdev,
 		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
 	default:
 		index -= VFIO_CCW_NUM_REGIONS;
+		index = array_index_nospec(index, private->num_regions);
 		return private->region[index].ops->write(private, buf, count,
 							 ppos);
 	}
@@ -338,11 +372,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struct vfio_device *vdev,
 		    VFIO_CCW_NUM_REGIONS + private->num_regions)
 			return -EINVAL;
 
-		info->index = array_index_nospec(info->index,
-						 VFIO_CCW_NUM_REGIONS +
-						 private->num_regions);
-
 		i = info->index - VFIO_CCW_NUM_REGIONS;
+		i = array_index_nospec(i, private->num_regions);
 
 		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
 		info->size = private->region[i].size;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 0501d4bbcdbd..3bd0171d38d0 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -88,7 +88,8 @@ struct vfio_ccw_parent {
  * @state: internal state of the device
  * @completion: synchronization helper of the I/O completion
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @schib_region: MMIO region for SCHIB information
@@ -97,11 +98,14 @@ struct vfio_ccw_parent {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
  * @io_work: work for deferral process of I/O handling
  * @crw_work: work for deferral process of CRW handling
+ * @notoper_work: work for deferred processing in not-operational state
  */
 struct vfio_ccw_private {
 	struct vfio_device vdev;
@@ -118,6 +122,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
@@ -125,11 +131,13 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*req_trigger;
 	struct work_struct	io_work;
 	struct work_struct	crw_work;
+	struct work_struct	notoper_work;
 } __aligned(8);
 
 int vfio_ccw_sch_quiesce(struct subchannel *sch);
 void vfio_ccw_sch_io_todo(struct work_struct *work);
 void vfio_ccw_crw_todo(struct work_struct *work);
+void vfio_ccw_notoper_todo(struct work_struct *work);
 
 extern struct mdev_driver vfio_ccw_mdev_driver;
 
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 86d2ee78c9f4..d4ce6352b5b2 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/align.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 
@@ -267,6 +268,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
  * block, reply CPRB and reply param block and fill in values
  * for the common fields. Returns 0 on success or errno value
  * on failure.
+ * It is guaranteed that request and a possible param block
+ * are aligned to a 4 byte boundary. Furthermore if a param
+ * block is used, the memory allocated for this is rounded up to
+ * the next multiple of 4 bytes.
  */
 static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u8 **p_cprb_mem,
@@ -275,7 +280,8 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 				  u32 xflags)
 {
 	u8 *cprbmem = NULL;
-	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
+	size_t cprbplusparamblen =
+		ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
 	size_t len = 2 * cprbplusparamblen;
 	struct CPRBX *preqcblk, *prepcblk;
 
@@ -302,10 +308,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
 	memcpy(preqcblk->func_id, "T2", 2);
 	preqcblk->rpl_msgbl = cprbplusparamblen;
 	if (paramblen) {
-		preqcblk->req_parmb =
-			((u8 __user *)preqcblk) + sizeof(struct CPRBX);
-		preqcblk->rpl_parmb =
-			((u8 __user *)prepcblk) + sizeof(struct CPRBX);
+		preqcblk->req_parmb = ((u8 __user *)preqcblk) +
+			ALIGN(sizeof(struct CPRBX), 4);
+		preqcblk->rpl_parmb = ((u8 __user *)prepcblk) +
+			ALIGN(sizeof(struct CPRBX), 4);
 	}
 
 	*p_cprb_mem = cprbmem;
@@ -323,8 +329,10 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
  */
 static void free_cprbmem(void *mem, size_t paramblen, bool scrub, u32 xflags)
 {
+	size_t cprblen = ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
+
 	if (mem && scrub)
-		memzero_explicit(mem, 2 * (sizeof(struct CPRBX) + paramblen));
+		memzero_explicit(mem, 2 * cprblen);
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
 		mempool_free(mem, cprb_mempool);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 3dda9589f2b9..2d900ffc5068 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/align.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 #include <crypto/aes.h>
@@ -355,21 +356,24 @@ EXPORT_SYMBOL(ep11_check_aes_key);
 
 /*
  * Allocate and prepare ep11 cprb plus additional payload.
+ * It is guaranteed that the memory is aligned to a 4 byte boundary.
+ * Furthermore the memory allocation is rounded up to the next
+ * multiple of 4 bytes (with taking the payload_len into account).
  */
 static void *alloc_cprbmem(size_t payload_len, u32 xflags)
 {
-	size_t len = sizeof(struct ep11_cprb) + payload_len;
+	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
 	struct ep11_cprb *cprb = NULL;
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
-		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
+		if (memlen <= CPRB_MEMPOOL_ITEM_SIZE)
 			cprb = mempool_alloc_preallocated(cprb_mempool);
 	} else {
-		cprb = kmalloc(len, GFP_KERNEL);
+		cprb = kmalloc(memlen, GFP_KERNEL);
 	}
 	if (!cprb)
 		return NULL;
-	memset(cprb, 0, len);
+	memset(cprb, 0, memlen);
 
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
@@ -385,8 +389,10 @@ static void *alloc_cprbmem(size_t payload_len, u32 xflags)
  */
 static void free_cprbmem(void *mem, size_t payload_len, bool scrub, u32 xflags)
 {
+	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
+
 	if (mem && scrub)
-		memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);
+		memzero_explicit(mem, memlen);
 
 	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
 		mempool_free(mem, cprb_mempool);
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 40f72cdf284d..3df1d676de5d 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/atomic.h>
 #include <linux/uaccess.h>
+#include <linux/unaligned.h>
 
 #include "ap_bus.h"
 #include "zcrypt_api.h"
@@ -34,6 +35,9 @@
 #define CEXXC_RESPONSE_TYPE_XCRB 1
 #define CEXXC_RESPONSE_TYPE_EP11 2
 
+/* smallest possible EP11 payload size */
+#define MIN_EP11_PAYLOAD_SIZE 5
+
 MODULE_AUTHOR("IBM Corporation");
 MODULE_DESCRIPTION("Cryptographic Coprocessor (message type 6), " \
 		   "Copyright IBM Corp. 2001, 2023");
@@ -342,49 +346,39 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 		};
 	} __packed * msg = ap_msg->msg;
 
-	int rcblen = CEIL4(xcrb->request_control_blk_length);
-	int req_sumlen, resp_sumlen;
-	char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
-	char *function_code;
-
-	if (CEIL4(xcrb->request_control_blk_length) <
-			xcrb->request_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
+	size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
+	char *function_code, *req_data;
 
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) +
-		CEIL4(xcrb->request_control_blk_length) +
-		xcrb->request_data_length;
+	/* request length and overflow checks */
+	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
+		return -EINVAL;
+	req_cblen = CEIL4((size_t)xcrb->request_control_blk_length);
+	if (req_cblen > U32_MAX)
+		return -EINVAL;
+	req_sumlen = req_cblen + xcrb->request_data_length;
+	if (req_sumlen > U32_MAX)
+		return -EINVAL;
+	ap_msg->len = sizeof(struct type6_hdr) + req_sumlen;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
-
-	/*
-	 * Overflow check
-	 * sum must be greater (or equal) than the largest operand
-	 */
-	req_sumlen = CEIL4(xcrb->request_control_blk_length) +
-			xcrb->request_data_length;
-	if ((CEIL4(xcrb->request_control_blk_length) <=
-	     xcrb->request_data_length) ?
+	if (req_cblen <= xcrb->request_data_length ?
 	    req_sumlen < xcrb->request_data_length :
-	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
+	    req_sumlen < req_cblen) {
 		return -EINVAL;
 	}
 
-	if (CEIL4(xcrb->reply_control_blk_length) <
-			xcrb->reply_control_blk_length)
-		return -EINVAL; /* overflow after alignment*/
-
-	/*
-	 * Overflow check
-	 * sum must be greater (or equal) than the largest operand
-	 */
-	resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
-			xcrb->reply_data_length;
-	if ((CEIL4(xcrb->reply_control_blk_length) <=
-	     xcrb->reply_data_length) ?
-	    resp_sumlen < xcrb->reply_data_length :
-	    resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
+	/* reply length and overflow checks */
+	if (xcrb->reply_control_blk_length < sizeof(struct CPRBX))
+		return -EINVAL;
+	rep_cblen = CEIL4((size_t)xcrb->reply_control_blk_length);
+	if (rep_cblen > U32_MAX)
+		return -EINVAL;
+	rep_sumlen = rep_cblen + xcrb->reply_data_length;
+	if (rep_sumlen > U32_MAX)
+		return -EINVAL;
+	if (rep_cblen <= xcrb->reply_data_length ?
+	    rep_sumlen < xcrb->reply_data_length :
+	    rep_sumlen < rep_cblen) {
 		return -EINVAL;
 	}
 
@@ -393,7 +387,7 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	memcpy(msg->hdr.agent_id, &xcrb->agent_ID, sizeof(xcrb->agent_ID));
 	msg->hdr.tocardlen1 = xcrb->request_control_blk_length;
 	if (xcrb->request_data_length) {
-		msg->hdr.offset2 = msg->hdr.offset1 + rcblen;
+		msg->hdr.offset2 = msg->hdr.offset1 + req_cblen;
 		msg->hdr.tocardlen2 = xcrb->request_data_length;
 	}
 	msg->hdr.fromcardlen1 = xcrb->reply_control_blk_length;
@@ -404,8 +398,12 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 			     xcrb->request_control_blk_addr,
 			     xcrb->request_control_blk_length))
 		return -EFAULT;
-	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
-	    xcrb->request_control_blk_length)
+	/* pad tail with 0 up to req_cblen */
+	if (xcrb->request_control_blk_length < req_cblen)
+		memset(msg->userdata + xcrb->request_control_blk_length,
+		       0, req_cblen - xcrb->request_control_blk_length);
+	/* copy subfunction code into AP msg type 6 function code field */
+	if (msg->cprbx.cprb_len > req_cblen - sizeof(msg->hdr.function_code))
 		return -EINVAL;
 	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
 	memcpy(msg->hdr.function_code, function_code,
@@ -437,20 +435,70 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
 	}
 
 	/* copy data block */
-	if (xcrb->request_data_length &&
-	    z_copy_from_user(userspace, req_data, xcrb->request_data_address,
-			     xcrb->request_data_length))
-		return -EFAULT;
+	if (xcrb->request_data_length) {
+		req_data = ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
+		if (z_copy_from_user(userspace, req_data,
+				     xcrb->request_data_address,
+				     xcrb->request_data_length))
+			return -EFAULT;
+	}
 
 	return 0;
 }
 
+/*
+ * Simple asn1 int reader/decoder helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts int length values of 1, 2 or 4.
+ */
+static inline int asn1_int_decode(const u8 *buf, size_t intlen, u32 *u)
+{
+	switch (intlen) {
+	case 1:
+		*u = (u32)(*buf);
+		return 1;
+	case 2:
+		*u = (u32)get_unaligned_be16(buf);
+		return 2;
+	case 4:
+		*u = (u32)get_unaligned_be32(buf);
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Simple asn1 length parse helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts length encoded within the length octet
+ * or for long form 1, 2 or 4 octet length bytes.
+ */
+static inline int asn1_length_decode(const u8 *buf, size_t buflen, u32 *u)
+{
+	int i;
+
+	if (buflen < 1)
+		return -EINVAL;
+
+	if (*buf < 128) {
+		*u = (u32)(*buf & 0x7F);
+		return 1;
+	}
+
+	i = *buf & 0x7F;
+	if (--buflen < i)
+		return -EINVAL;
+	i = asn1_int_decode(++buf, i, u);
+
+	return i < 0 ? i : i + 1;
+}
+
 static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap_msg,
 					   struct ep11_urb *xcrb,
 					   unsigned int *fcode,
 					   unsigned int *domain)
 {
-	unsigned int lfmt;
 	static struct type6_hdr static_type6_ep11_hdr = {
 		.type		=  0x06,
 		.rqid		= {0x00, 0x01},
@@ -462,34 +510,32 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 	struct {
 		struct type6_hdr hdr;
 		union {
-			struct {
-				struct ep11_cprb cprbx;
-				unsigned char pld_tag;    /* fixed value 0x30 */
-				unsigned char pld_lenfmt; /* length format */
-			} __packed;
+			struct ep11_cprb cprbx;
 			DECLARE_FLEX_ARRAY(u8, userdata);
 		};
 	} __packed * msg = ap_msg->msg;
 
-	struct pld_hdr {
-		unsigned char	func_tag;	/* fixed value 0x4 */
-		unsigned char	func_len;	/* fixed value 0x4 */
-		unsigned int	func_val;	/* function ID	   */
-		unsigned char	dom_tag;	/* fixed value 0x4 */
-		unsigned char	dom_len;	/* fixed value 0x4 */
-		unsigned int	dom_val;	/* domain id	   */
-	} __packed * payload_hdr = NULL;
+	size_t req_len, rep_len, pld_len;
+	unsigned char *pld;
+	int offs = 0, i;
+	unsigned int u;
 
-	if (CEIL4(xcrb->req_len) < xcrb->req_len)
-		return -EINVAL; /* overflow after alignment*/
-
-	/* length checks */
-	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
+	/* request length and overflow checks */
+	if (xcrb->req_len < sizeof(struct ep11_cprb) + MIN_EP11_PAYLOAD_SIZE)
+		return -EINVAL;
+	req_len = CEIL4(xcrb->req_len);
+	if (req_len < xcrb->req_len || req_len > U32_MAX)
+		return -EINVAL;
+	ap_msg->len = sizeof(struct type6_hdr) + req_len;
 	if (ap_msg->len > ap_msg->bufsize)
 		return -EINVAL;
 
-	if (CEIL4(xcrb->resp_len) < xcrb->resp_len)
-		return -EINVAL; /* overflow after alignment*/
+	/* reply length and overflow checks */
+	if (xcrb->resp_len < sizeof(struct ep11_cprb))
+		return -EINVAL;
+	rep_len = CEIL4(xcrb->resp_len);
+	if (rep_len < xcrb->resp_len || rep_len > U32_MAX)
+		return -EINVAL;
 
 	/* prepare type6 header */
 	msg->hdr = static_type6_ep11_hdr;
@@ -498,26 +544,55 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
 
 	/* Import CPRB data from the ioctl input parameter */
 	if (z_copy_from_user(userspace, msg->userdata,
-			     (char __force __user *)xcrb->req, xcrb->req_len)) {
+			     (char __force __user *)xcrb->req, xcrb->req_len))
 		return -EFAULT;
-	}
+	/* pad tail with 0 up to req_len */
+	if (xcrb->req_len < req_len)
+		memset(msg->userdata + xcrb->req_len, 0,
+		       req_len - xcrb->req_len);
+
+	pld = msg->userdata + sizeof(struct ep11_cprb);
+	pld_len = msg->cprbx.payload_len;
+	if (pld_len != xcrb->req_len - sizeof(struct ep11_cprb))
+		return -EINVAL;
+	/*
+	 * At this point pld_len is always >= MIN_EP11_PAYLOAD_SIZE
+	 * and the smallest supported asn1 payload is:
+	 *   payload tag (1 octet)
+	 *   payload length (1-5 octets)
+	 *   function tag (1 octet)
+	 *   function length (1-5 octets)
+	 *   function value (1-4 octets)
+	 */
 
-	if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
-		switch (msg->pld_lenfmt & 0x03) {
-		case 1:
-			lfmt = 2;
-			break;
-		case 2:
-			lfmt = 3;
-			break;
-		default:
-			return -EINVAL;
-		}
-	} else {
-		lfmt = 1; /* length format #1 */
-	}
-	payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
-	*fcode = payload_hdr->func_val & 0xFFFF;
+	/* payload tag */
+	if (pld[offs++] != 0x30)
+		return -EINVAL;
+	/* payload length field */
+	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	if (offs >= pld_len || u > pld_len - offs)
+		return -EINVAL;
+	/* function tag */
+	if (pld[offs++] != 0x04)
+		return -EINVAL;
+	/* function length */
+	if (offs >= pld_len)
+		return -EINVAL;
+	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	if (offs >= pld_len || u > pld_len - offs)
+		return -EINVAL;
+	/* function value */
+	i = asn1_int_decode(pld + offs, u, &u);
+	if (i < 0)
+		return -EINVAL;
+	offs += i;
+	*fcode = 0xFFFF & u;
 
 	/* enable special processing based on the cprbs flags special bit */
 	if (msg->cprbx.flags & 0x20)
@@ -1159,6 +1234,28 @@ int prep_ep11_ap_msg(bool userspace, struct ep11_urb *xcrb,
 					       func_code, domain);
 }
 
+/*
+ * Simple asn1 int writer/encoder helper function
+ * Returns number of bytes processed or < 0 on failure
+ * Only accepts int length values of 1, 2 or 4.
+ */
+static inline int asn1_int_encode(u8 *buf, size_t intlen, u32 u)
+{
+	switch (intlen) {
+	case 1:
+		*buf = (u8)u;
+		return 1;
+	case 2:
+		put_unaligned_be16((u16)u, buf);
+		return 2;
+	case 4:
+		put_unaligned_be32((u32)u, buf);
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * The request distributor calls this function if it picked the CEX4P
  * device to handle a send_ep11_cprb request.
@@ -1171,51 +1268,94 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 					   struct ap_message *ap_msg)
 {
 	int rc;
-	unsigned int lfmt;
 	struct ap_response_type *resp_type = &ap_msg->response;
 	struct {
 		struct type6_hdr hdr;
 		struct ep11_cprb cprbx;
-		unsigned char	pld_tag;	/* fixed value 0x30 */
-		unsigned char	pld_lenfmt;	/* payload length format */
 	} __packed * msg = ap_msg->msg;
-	struct pld_hdr {
-		unsigned char	func_tag;	/* fixed value 0x4 */
-		unsigned char	func_len;	/* fixed value 0x4 */
-		unsigned int	func_val;	/* function ID	   */
-		unsigned char	dom_tag;	/* fixed value 0x4 */
-		unsigned char	dom_len;	/* fixed value 0x4 */
-		unsigned int	dom_val;	/* domain id	   */
-	} __packed * payload_hdr = NULL;
 
 	/*
 	 * The target domain field within the cprb body/payload block will be
 	 * replaced by the usage domain for non-management commands only.
 	 * Therefore we check the first bit of the 'flags' parameter for
 	 * management command indication.
-	 *   0 - non management command
-	 *   1 - management command
 	 */
-	if (!((msg->cprbx.flags & 0x80) == 0x80)) {
-		msg->cprbx.target_id = (unsigned int)
-					AP_QID_QUEUE(zq->queue->qid);
-
-		if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
-			switch (msg->pld_lenfmt & 0x03) {
-			case 1:
-				lfmt = 2;
-				break;
-			case 2:
-				lfmt = 3;
-				break;
-			default:
+	if (!(msg->cprbx.flags & 0x80)) {
+		int i, offs = 0;
+		size_t pld_len;
+		u8 *pld;
+		u32 u;
+
+		/* update target field in ep11_cprb */
+		msg->cprbx.target_id = (u32)AP_QID_QUEUE(zq->queue->qid);
+
+		/* ptr and length to payload */
+		pld = ap_msg->msg +
+			sizeof(struct type6_hdr) + sizeof(struct ep11_cprb);
+		pld_len = msg->cprbx.payload_len;
+		if (pld_len < MIN_EP11_PAYLOAD_SIZE)
+			return -EINVAL;
+
+		/*
+		 * Parse the asn1 payload, at least we have
+		 *   pld tag (1 octet)
+		 *   payload length (1-5 octets)
+		 *   function tag (1 octet)
+		 *   function length (1-5 octets)
+		 *   function value (1-4 octets)
+		 *   ----- optional fields -----
+		 *   domain tag (1 octet)
+		 *   domain length (1-5 octets)
+		 *   domain value (1-4 octets)
+		 *   ... maybe much more data ...
+		 */
+
+		/* payload tag */
+		if (pld[offs++] != 0x30)
+			return -EINVAL;
+		/* payload length field */
+		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+		if (i < 0)
+			return -EINVAL;
+		offs += i;
+		if (offs >= pld_len || u > pld_len - offs)
+			return -EINVAL;
+		/* function tag */
+		if (pld[offs++] != 0x04)
+			return -EINVAL;
+		/* function length */
+		if (offs >= pld_len)
+			return -EINVAL;
+		i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+		if (i < 0)
+			return -EINVAL;
+		offs += i;
+		if (u > pld_len - offs)
+			return -EINVAL;
+		/* skip over the function value */
+		offs += u;
+		/* is there some payload left which could hold a domain value ? */
+		if (offs < pld_len && pld_len - offs >= 3) {
+			/* domain tag */
+			if (pld[offs++] != 0x04)
 				return -EINVAL;
-			}
-		} else {
-			lfmt = 1; /* length format #1 */
+			/* domain length */
+			i = asn1_length_decode(pld + offs, pld_len - offs, &u);
+			if (i < 0)
+				return -EINVAL;
+			offs += i;
+			if (offs >= pld_len || u > pld_len - offs)
+				return -EINVAL;
+			/*
+			 * pld[offs] is now at the start of the domain value
+			 * with the value sprawled in u octets.
+			 */
+			i = asn1_int_encode(pld + offs, u,
+					    AP_QID_QUEUE(zq->queue->qid));
+			if (i < 0)
+				return -EINVAL;
+			offs += i;
 		}
-		payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
-		payload_hdr->dom_val = AP_QID_QUEUE(zq->queue->qid);
 	}
 
 	/*
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4973ce3936e6..c3e7e49a792e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4710,6 +4710,9 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	if (req_len > QETH_BUFSIZE)
 		return -EINVAL;
 
+	if (qinfo.udata_len < sizeof(struct qeth_snmp_ureq_hdr))
+		return -EINVAL;
+
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
 	if (!iob)
 		return -ENOMEM;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1542bfc9f561..f1ac9950dcb4 100644
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
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 453a2232452d..74b70801269b 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2362,6 +2362,7 @@ static void scsi_unjam_host(struct Scsi_Host *shost)
 int scsi_error_handler(void *data)
 {
 	struct Scsi_Host *shost = data;
+	bool eh_noresume;
 
 	/*
 	 * We use TASK_INTERRUPTIBLE so that the thread is not
@@ -2403,7 +2404,8 @@ int scsi_error_handler(void *data)
 		 * what we need to do to get it up and online again (if we can).
 		 * If we fail, we end up taking the thing offline.
 		 */
-		if (!shost->eh_noresume && scsi_autopm_get_host(shost) != 0) {
+		eh_noresume = READ_ONCE(shost->eh_noresume);
+		if (!eh_noresume && scsi_autopm_get_host(shost) != 0) {
 			SCSI_LOG_ERROR_RECOVERY(1,
 				shost_printk(KERN_ERR, shost,
 					     "scsi_eh_%d: unable to autoresume\n",
@@ -2427,7 +2429,7 @@ int scsi_error_handler(void *data)
 		 * which are still online.
 		 */
 		scsi_restart_operations(shost);
-		if (!shost->eh_noresume)
+		if (!eh_noresume)
 			scsi_autopm_put_host(shost);
 	}
 	__set_current_state(TASK_RUNNING);
diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index fa4c68049eca..2256dfec5407 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -358,6 +358,8 @@ static int virtio_spi_probe(struct virtio_device *vdev)
 	if (ret)
 		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue cleanup\n");
 
+	virtio_device_ready(vdev);
+
 	/* Use devm version to register controller */
 	ret = devm_spi_register_controller(&vdev->dev, ctrl);
 	if (ret)
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index b4372fa268d0..633715b98625 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -698,6 +698,9 @@ static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
 	int rc;
 
 	mem_attr = kzalloc_objs(*mem_attr, ma_count);
+	if (!mem_attr)
+		return -ENOMEM;
+
 	for (n = 0; n < ma_count; n++) {
 		mem_attr[n].receiver = mem_attrs[n] & U16_MAX;
 		mem_attr[n].attrs = mem_attrs[n] >> 16;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index d6444b3c2ef1..4abeb77c3a0f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9985,7 +9985,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	 * we are functional while we are here, skip host resume in error
 	 * handling context.
 	 */
-	hba->host->eh_noresume = 1;
+	WRITE_ONCE(hba->host->eh_noresume, 1);
 
 	/*
 	 * Current function would be generally called from the power management
@@ -10007,7 +10007,7 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	}
 
 	scsi_device_put(sdp);
-	hba->host->eh_noresume = 0;
+	WRITE_ONCE(hba->host->eh_noresume, 0);
 	return ret;
 }
 
diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev/core/fb_io_fops.c
index 6ab60fcd0050..0798e88799eb 100644
--- a/drivers/video/fbdev/core/fb_io_fops.c
+++ b/drivers/video/fbdev/core/fb_io_fops.c
@@ -61,6 +61,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user *buf, size_t count, loff_t
 		buf += c;
 		cnt += c;
 		count -= c;
+
+		/*
+		 * If there was a partial copy, the user buffer is faulty.
+		 * Break out to avoid over-advancing the src pointer and
+		 * reading out of bounds in the next iteration.
+		 */
+		if (trailing)
+			break;
 	}
 
 	kfree(buffer);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0929deb95218..0ea182314b89 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -246,8 +246,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		ret = fb_mode_is_equal(&mode1, &mode2);
 		if (!ret) {
 			ret = fbcon_mode_deleted(info, &mode1);
-			if (!ret)
+			if (!ret) {
+				if (info->mode && fb_mode_is_equal(info->mode, &mode1))
+					info->mode = NULL;
 				fb_delete_videomode(&mode1, &info->modelist);
+			}
 		}
 
 		return ret ? -EINVAL : 0;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index fe8bd33e64ab..fa12e5da9bbd 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -30,12 +30,15 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	return 0;
 }
 
-static int mode_string(char *buf, unsigned int offset,
+static int mode_string(char *buf, size_t size, unsigned int offset,
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
 	char v = 'p';
 
+	if (offset >= size)
+		return 0;
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
@@ -48,7 +51,7 @@ static int mode_string(char *buf, unsigned int offset,
 	if (mode->vmode & FB_VMODE_DOUBLE)
 		v = 'd';
 
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	return scnprintf(&buf[offset], size - offset, "%c:%dx%d%c-%d\n",
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
@@ -67,7 +70,7 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i = mode_string(mstr, 0, mode);
+		i = mode_string(mstr, sizeof(mstr), 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
 
 			var = fb_info->var;
@@ -89,7 +92,7 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 	if (!fb_info->mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -139,7 +142,9 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	i = 0;
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i += mode_string(buf, i, mode);
+		i += mode_string(buf, PAGE_SIZE, i, mode);
+		if (i >= PAGE_SIZE - 1)
+			break;
 	}
 	return i;
 }
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 68435a4d6fa9..289277cb8a06 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3091,7 +3091,19 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
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
+					ret = -EUCLEAN;
+					break;
+				}
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
@@ -3125,7 +3137,8 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 				continue;
 			}
 			if (ret == -EUCLEAN) {
-				/* session was killed, try renew caps */
+				/* session was killed or a waited cap
+				 * request needs a retry */
 				ret = ceph_renew_caps(inode, flags);
 				if (ret == 0)
 					continue;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..47c7d4a5ffed 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -314,7 +314,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 }
 
 /*
- * try renew caps after session gets killed.
+ * Retry cap acquisition after a stale session or a lost cap update.
  */
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
@@ -322,14 +322,15 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	struct ceph_client *cl = mdsc->fsc->client;
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
 		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..fd1902831787 100644
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
@@ -3903,6 +3904,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
+	unsigned int nofs_flags;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -4046,6 +4048,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
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
@@ -4054,6 +4064,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			err = ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
+	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4e6c87f8414c..ba9e04afa200 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -77,6 +77,7 @@ struct ceph_fs_client;
 struct ceph_cap;
 
 #define MDS_AUTH_UID_ANY -1
+#define CEPH_GET_CAPS_WAIT_TIMEOUT (5 * HZ)
 
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d8e46eb7e5eb..450a4dc9662e 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -15,7 +15,7 @@
 #include "super.h"
 
 #define CEPH_MDS_IS_READY(i, ignore_laggy) \
-	(m->m_info[i].state > 0 && ignore_laggy ? true : !m->m_info[i].laggy)
+	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m->m_info[i].laggy))
 
 static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool ignore_laggy)
 {
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 8ca1767dafb6..2dfc313588d2 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -134,7 +134,8 @@ config EROFS_FS_ZIP_LZMA
 config EROFS_FS_ZIP_LZMA_DEFAULT_MAX_STREAMS
 	int "EROFS LZMA default maximum decompression streams"
 	depends on EROFS_FS_ZIP_LZMA
-	range 1 NR_CPUS
+	range 1 NR_CPUS if SMP
+	range 1 1 if !SMP
 	default 16
 	help
 	  By default EROFS allocates one LZMA decompression stream per CPU.
diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 541e33f33167..7fb28c8afef8 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -959,6 +959,16 @@ xmi_can_exchange_reflink_flags(
 {
 	struct xfs_mount		*mp = req->ip1->i_mount;
 
+	/*
+	 * The INO1_WRITTEN optimization can skip exchanging hole and
+	 * unwritten mappings, which means we cannot guarantee that all
+	 * shared extents actually moved to the other file.  Clearing the
+	 * reflink flag of an inode that still holds shared extents breaks
+	 * the CoW write path, so refuse to exchange the flags in that case.
+	 */
+	if (req->flags & XFS_EXCHMAPS_INO1_WRITTEN)
+		return false;
+
 	if (hweight32(reflink_state) != 1)
 		return false;
 	if (req->startoff1 != 0 || req->startoff2 != 0)
diff --git a/fs/xfs/libxfs/xfs_rtrefcount_btree.c b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
index c1518267eb17..8219b634fff2 100644
--- a/fs/xfs/libxfs/xfs_rtrefcount_btree.c
+++ b/fs/xfs/libxfs/xfs_rtrefcount_btree.c
@@ -201,7 +201,7 @@ xfs_rtrefcountbt_verify(
 	if (fa)
 		return fa;
 	level = be16_to_cpu(block->bb_level);
-	if (level > mp->m_rtrefc_maxlevels)
+	if (level >= mp->m_rtrefc_maxlevels)
 		return __this_address;
 
 	return xfs_btree_fsblock_verify(bp, mp->m_rtrefc_mxr[level != 0]);
@@ -651,7 +651,7 @@ xfs_iformat_rtrefcount(
 	numrecs = be16_to_cpu(dfp->bb_numrecs);
 	level = be16_to_cpu(dfp->bb_level);
 
-	if (level > mp->m_rtrefc_maxlevels ||
+	if (level >= mp->m_rtrefc_maxlevels ||
 	    xfs_rtrefcount_droot_space_calc(level, numrecs) > dsize) {
 		xfs_inode_mark_sick(ip, XFS_SICK_INO_CORE);
 		return -EFSCORRUPTED;
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 47322adb7690..75f2a021ee6d 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1118,10 +1118,10 @@ xfs_sb_read_verify(
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
diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 9ed053b5f061..62ed5eaf08fb 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -266,7 +266,7 @@ xchk_superblock(
 			xchk_block_set_corrupt(sc, bp);
 
 		if (sb->sb_gquotino != cpu_to_be64(0))
-			xchk_block_set_preen(sc, bp);
+			xchk_block_set_corrupt(sc, bp);
 	} else {
 		if (sb->sb_uquotino != cpu_to_be64(mp->m_sb.sb_uquotino))
 			xchk_block_set_preen(sc, bp);
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index ae9ed5f280d0..c2acd7748269 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -979,6 +979,13 @@ xrep_agi_calc_from_btrees(
 	return error;
 }
 
+/*
+ * Magic value that means "not unlinked" because xfarrays don't support storing
+ * totally zeroed elements.  There can't be a cluster that starts in daddr 0 so
+ * there can't be an inode #1 either.
+ */
+#define LINKED_AGINO	(0x1)
+
 /*
  * Record a forwards unlinked chain pointer from agino -> next_agino in our
  * staging information.
@@ -1034,31 +1041,40 @@ xrep_iunlink_next(
  * the chain or if we should stop walking the chain due to corruption; or a
  * per-AG inode number.
  */
-STATIC xfs_agino_t
+STATIC int
 xrep_iunlink_reload_next(
 	struct xrep_agi		*ragi,
 	xfs_agino_t		prev_agino,
-	xfs_agino_t		agino)
+	xfs_agino_t		agino,
+	xfs_agino_t		*next_agino)
 {
 	struct xfs_scrub	*sc = ragi->sc;
 	struct xfs_inode	*ip;
-	xfs_agino_t		ret = NULLAGINO;
 	int			error;
 
+	*next_agino = NULLAGINO;
+
 	error = xchk_iget(ragi->sc, xfs_agino_to_ino(sc->sa.pag, agino), &ip);
 	if (error)
-		return ret;
+		return 0;
 
 	trace_xrep_iunlink_reload_next(ip, prev_agino);
 
 	/* If this is a linked inode, stop processing the chain. */
 	if (VFS_I(ip)->i_nlink != 0) {
-		xrep_iunlink_store_next(ragi, agino, NULLAGINO);
+		error = xrep_iunlink_store_next(ragi, agino, NULLAGINO);
+		if (error)
+			return error;
+
+		error = xrep_iunlink_store_prev(ragi, agino, LINKED_AGINO);
+		if (error)
+			return error;
+
 		goto rele;
 	}
 
 	ip->i_prev_unlinked = prev_agino;
-	ret = ip->i_next_unlinked;
+	*next_agino = ip->i_next_unlinked;
 
 	/*
 	 * Drop the inode reference that we just took.  We hold the AGI, so
@@ -1067,7 +1083,7 @@ xrep_iunlink_reload_next(
 	 */
 rele:
 	xchk_irele(sc, ip);
-	return ret;
+	return 0;
 }
 
 /*
@@ -1081,7 +1097,7 @@ xrep_iunlink_walk_ondisk_bucket(
 	unsigned int		bucket)
 {
 	struct xfs_scrub	*sc = ragi->sc;
-	struct xfs_agi		*agi = sc->sa.agi_bp->b_addr;
+	struct xfs_agi		*agi = ragi->agi_bp->b_addr;
 	xfs_agino_t		prev_agino = NULLAGINO;
 	xfs_agino_t		next_agino;
 	int			error = 0;
@@ -1100,9 +1116,12 @@ xrep_iunlink_walk_ondisk_bucket(
 			break;
 
 		next_agino = xrep_iunlink_next(sc, agino);
-		if (!next_agino)
-			next_agino = xrep_iunlink_reload_next(ragi, prev_agino,
-					agino);
+		if (!next_agino) {
+			error = xrep_iunlink_reload_next(ragi, prev_agino,
+					agino, &next_agino);
+			if (error)
+				break;
+		}
 
 		prev_agino = agino;
 	}
@@ -1302,7 +1321,7 @@ xrep_iunlink_mark_ondisk_rec(
  * iunlink_bmp.   We haven't checked the inobt yet, so we don't error out if
  * the btree is corrupt.
  */
-STATIC void
+STATIC int
 xrep_iunlink_mark_ondisk(
 	struct xrep_agi		*ragi)
 {
@@ -1314,6 +1333,14 @@ xrep_iunlink_mark_ondisk(
 	cur = xfs_inobt_init_cursor(sc->sa.pag, sc->tp, agi_bp);
 	error = xfs_btree_query_all(cur, xrep_iunlink_mark_ondisk_rec, ragi);
 	xfs_btree_del_cursor(cur, error);
+
+	/*
+	 * Don't proceed if we couldn't set a bit in the bitmap.  All other
+	 * errors we ignore because we haven't actually checked the inobt yet.
+	 */
+	if (error == -ENOMEM)
+		return -ENOMEM;
+	return 0;
 }
 
 /*
@@ -1326,15 +1353,32 @@ xrep_iunlink_resolve_bucket(
 	struct xrep_agi		*ragi,
 	unsigned int		bucket)
 {
+	struct xagino_bitmap	seen;
 	struct xfs_scrub	*sc = ragi->sc;
 	struct xfs_inode	*ip;
 	xfs_agino_t		prev_agino = NULLAGINO;
 	xfs_agino_t		next_agino = ragi->iunlink_heads[bucket];
 	int			error = 0;
 
+	xagino_bitmap_init(&seen);
+
 	while (next_agino != NULLAGINO) {
+		unsigned int len = 1;
+
 		if (xchk_should_terminate(ragi->sc, &error))
-			return error;
+			goto out_bitmap;
+
+		/* Inode already seen?  We're stuck in a loop */
+		if (xagino_bitmap_test(&seen, next_agino, &len)) {
+			trace_xrep_iunlink_resolve_infinite_loop(sc->sa.pag,
+					bucket, prev_agino, next_agino);
+			next_agino = NULLAGINO;
+			break;
+		}
+
+		error = xagino_bitmap_set(&seen, next_agino, 1);
+		if (error)
+			goto out_bitmap;
 
 		/* Find the next inode in the chain. */
 		ip = xfs_iunlink_lookup(sc->sa.pag, next_agino);
@@ -1347,6 +1391,35 @@ xrep_iunlink_resolve_bucket(
 			break;
 		}
 
+		if (VFS_I(ip)->i_nlink != 0) {
+			/*
+			 * Inode is linked somewhere!  Blow out both unlinked
+			 * list pointers, advance the list, and pretend we
+			 * didn't see this inode.  Clear it from iunlink_bmp
+			 * because it's linked.
+			 */
+			trace_xrep_iunlink_resolve_allocated(sc->sa.pag,
+					bucket, prev_agino, next_agino);
+
+			error = xrep_iunlink_store_next(ragi, next_agino,
+					NULLAGINO);
+			if (error)
+				goto out_bitmap;
+
+			error = xrep_iunlink_store_prev(ragi, next_agino,
+					LINKED_AGINO);
+			if (error)
+				goto out_bitmap;
+
+			error = xagino_bitmap_clear(&ragi->iunlink_bmp,
+					next_agino, 1);
+			if (error)
+				goto out_bitmap;
+
+			next_agino = ip->i_next_unlinked;
+			continue;
+		}
+
 		if (next_agino % XFS_AGI_UNLINKED_BUCKETS != bucket) {
 			/*
 			 * Inode is in the wrong bucket.  Advance the list,
@@ -1382,20 +1455,20 @@ xrep_iunlink_resolve_bucket(
 		 */
 		error = xagino_bitmap_clear(&ragi->iunlink_bmp, next_agino, 1);
 		if (error)
-			return error;
+			goto out_bitmap;
 
 		/* Remember the previous inode's next pointer. */
 		if (prev_agino != NULLAGINO) {
 			error = xrep_iunlink_store_next(ragi, prev_agino,
 					next_agino);
 			if (error)
-				return error;
+				goto out_bitmap;
 		}
 
 		/* Remember this inode's previous pointer. */
 		error = xrep_iunlink_store_prev(ragi, next_agino, prev_agino);
 		if (error)
-			return error;
+			goto out_bitmap;
 
 		/* Advance the list and remember this inode. */
 		prev_agino = next_agino;
@@ -1406,10 +1479,12 @@ xrep_iunlink_resolve_bucket(
 	if (prev_agino != NULLAGINO) {
 		error = xrep_iunlink_store_next(ragi, prev_agino, next_agino);
 		if (error)
-			return error;
+			goto out_bitmap;
 	}
 
-	return 0;
+out_bitmap:
+	xagino_bitmap_destroy(&seen);
+	return error;
 }
 
 /* Reinsert this unlinked inode into the head of the staged bucket list. */
@@ -1434,6 +1509,10 @@ xrep_iunlink_add_to_bucket(
 	if (error)
 		return error;
 
+	error = xrep_iunlink_store_prev(ragi, agino, NULLAGINO);
+	if (error)
+		return error;
+
 	/* Remember the head inode's previous pointer. */
 	if (current_head != NULLAGINO) {
 		error = xrep_iunlink_store_prev(ragi, current_head, agino);
@@ -1501,7 +1580,9 @@ xrep_iunlink_rebuild_buckets(
 	 * If there are ondisk inodes that are unlinked and are not been loaded
 	 * into cache, record them in iunlink_bmp.
 	 */
-	xrep_iunlink_mark_ondisk(ragi);
+	error = xrep_iunlink_mark_ondisk(ragi);
+	if (error)
+		return error;
 
 	/*
 	 * Walk each iunlink bucket to (re)construct as much of the incore list
@@ -1523,6 +1604,24 @@ xrep_iunlink_rebuild_buckets(
 			xrep_iunlink_add_lost_inodes, ragi);
 }
 
+static inline void
+set_inode_prev_unlinked(
+	struct xfs_inode	*ip,
+	xfs_agino_t		prev_agino)
+{
+	/*
+	 * Magic value that means "not unlinked" because xfarrays don't support
+	 * storing totally zeroed elements.
+	 */
+	if (prev_agino == LINKED_AGINO)
+		prev_agino = 0;
+
+	if (ip->i_prev_unlinked != prev_agino) {
+		trace_xrep_iunlink_relink_prev(ip, prev_agino);
+		ip->i_prev_unlinked = prev_agino;
+	}
+}
+
 /* Update i_next_iunlinked for the inode @agino. */
 STATIC int
 xrep_iunlink_relink_next(
@@ -1556,8 +1655,7 @@ xrep_iunlink_relink_next(
 		if (error)
 			goto out_rele;
 
-		trace_xrep_iunlink_relink_prev(ip, prev_agino);
-		ip->i_prev_unlinked = prev_agino;
+		set_inode_prev_unlinked(ip, prev_agino);
 	}
 
 	/* Update the forward pointer. */
@@ -1612,7 +1710,7 @@ xrep_iunlink_relink_prev(
 		want_rele = true;
 
 		/* Set the forward pointer since this just came off disk. */
-		error = xfarray_load(ragi->iunlink_prev, agino, &next_agino);
+		error = xfarray_load(ragi->iunlink_next, agino, &next_agino);
 		if (error)
 			goto out_rele;
 
@@ -1624,11 +1722,7 @@ xrep_iunlink_relink_prev(
 		ip->i_next_unlinked = next_agino;
 	}
 
-	/* Update the backward pointer. */
-	if (ip->i_prev_unlinked != prev_agino) {
-		trace_xrep_iunlink_relink_prev(ip, prev_agino);
-		ip->i_prev_unlinked = prev_agino;
-	}
+	set_inode_prev_unlinked(ip, prev_agino);
 
 out_rele:
 	/*
@@ -1658,6 +1752,8 @@ xrep_iunlink_commit(
 		if (error)
 			return error;
 	}
+	if (error < 0)
+		return error;
 
 	/* Fix all the back links */
 	idx = XFARRAY_CURSOR_INIT;
@@ -1666,6 +1762,8 @@ xrep_iunlink_commit(
 		if (error)
 			return error;
 	}
+	if (error < 0)
+		return error;
 
 	/* Copy the staged iunlink buckets to the new AGI. */
 	for (i = 0; i < XFS_AGI_UNLINKED_BUCKETS; i++) {
diff --git a/fs/xfs/scrub/alloc.c b/fs/xfs/scrub/alloc.c
index 48edaa2cb1e0..c666be69f164 100644
--- a/fs/xfs/scrub/alloc.c
+++ b/fs/xfs/scrub/alloc.c
@@ -136,7 +136,7 @@ xchk_allocbt_rec(
 	const union xfs_btree_rec	*rec)
 {
 	struct xfs_alloc_rec_incore	irec;
-	struct xchk_alloc	*ca = bs->private;
+	struct xchk_alloc		*ca = bs->private;
 
 	xfs_alloc_btrec_to_irec(rec, &irec);
 	if (xfs_alloc_check_irec(to_perag(bs->cur->bc_group), &irec) != NULL) {
@@ -144,7 +144,8 @@ xchk_allocbt_rec(
 		return 0;
 	}
 
-	xchk_allocbt_mergeable(bs, ca, &irec);
+	if (bs->sc->sm->sm_type == XFS_SCRUB_TYPE_BNOBT)
+		xchk_allocbt_mergeable(bs, ca, &irec);
 	xchk_allocbt_xref(bs->sc, &irec);
 
 	return 0;
diff --git a/fs/xfs/scrub/attr_repair.c b/fs/xfs/scrub/attr_repair.c
index 7d00a1ce0bac..9683333f2ea5 100644
--- a/fs/xfs/scrub/attr_repair.c
+++ b/fs/xfs/scrub/attr_repair.c
@@ -1427,7 +1427,8 @@ xrep_xattr_rebuild_tree(
 	 * If we didn't find any attributes to salvage, repair the file by
 	 * zapping its attr fork.
 	 */
-	if (rx->attrs_found == 0) {
+	if (rx->attrs_found == 0 &&
+	    (!xfs_has_parent(sc->mp) || xfarray_length(rx->pptr_recs) == 0)) {
 		xfs_trans_ijoin(sc->tp, sc->ip, 0);
 		error = xrep_xattr_reset_fork(sc);
 		if (error)
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index d40534bf9ef9..35e51709a58a 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -1170,6 +1170,11 @@ xchk_bmap_attr(
 	}
 
 	error = xchk_bmap(sc, XFS_ATTR_FORK);
+	/* A repaired, empty attr fork no longer has mappings to check. */
+	if (error == -ENOENT && (sc->flags & XREP_ALREADY_FIXED)) {
+		xchk_mark_healthy_if_clean(sc, XFS_SICK_INO_BMBTA_ZAPPED);
+		return 0;
+	}
 	if (error)
 		return error;
 
diff --git a/fs/xfs/scrub/dirtree_repair.c b/fs/xfs/scrub/dirtree_repair.c
index bcfbbf5efc6c..f1bb1a4e2f8f 100644
--- a/fs/xfs/scrub/dirtree_repair.c
+++ b/fs/xfs/scrub/dirtree_repair.c
@@ -349,6 +349,8 @@ xrep_dirtree_unlink_iolock(
 
 	ASSERT(sc->ilock_flags & XFS_IOLOCK_EXCL);
 
+	if (sc->ip == dp)
+		return 0;
 	if (xfs_ilock_nowait(dp, XFS_IOLOCK_EXCL))
 		return 0;
 
@@ -400,8 +402,18 @@ xrep_dirtree_unlink(
 	 * directory code can handle a reservationless update.
 	 */
 	resblks = xfs_remove_space_res(mp, step->name_len);
-	error = xfs_trans_alloc_dir(dp, &M_RES(mp)->tr_remove, sc->ip,
-			&resblks, &sc->tp, &dontcare);
+	if (sc->ip == dp) {
+again:
+		error = xfs_trans_alloc_inode(dp, &M_RES(mp)->tr_remove,
+				resblks, 0, false, &sc->tp);
+		if ((error == -ENOSPC || error == -EDQUOT) && resblks > 0) {
+			resblks = 0;
+			goto again;
+		}
+	} else {
+		error = xfs_trans_alloc_dir(dp, &M_RES(mp)->tr_remove, sc->ip,
+				&resblks, &sc->tp, &dontcare);
+	}
 	if (error)
 		goto out_iolock;
 
@@ -489,9 +501,11 @@ xrep_dirtree_unlink(
 	xchk_trans_cancel(sc);
 out_ilock:
 	xfs_iunlock(sc->ip, XFS_ILOCK_EXCL);
-	xfs_iunlock(dp, XFS_ILOCK_EXCL);
+	if (dp != sc->ip)
+		xfs_iunlock(dp, XFS_ILOCK_EXCL);
 out_iolock:
-	xfs_iunlock(dp, XFS_IOLOCK_EXCL);
+	if (dp != sc->ip)
+		xfs_iunlock(dp, XFS_IOLOCK_EXCL);
 	return error;
 }
 
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 2ac66163263b..4213b8240248 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -1956,7 +1956,7 @@ xrep_inode_cowextsize(
 	/* Fix misaligned CoW extent size hints on a directory. */
 	if ((sc->ip->i_diflags & XFS_DIFLAG_RTINHERIT) &&
 	    (sc->ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE) &&
-	    sc->ip->i_extsize % sc->mp->m_sb.sb_rextsize > 0) {
+	    xfs_extlen_to_rtxmod(sc->mp, sc->ip->i_cowextsize) > 0) {
 		sc->ip->i_cowextsize = 0;
 		sc->ip->i_diflags2 &= ~XFS_DIFLAG2_COWEXTSIZE;
 	}
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 1e0effdb65a6..80b28b30d762 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -382,6 +382,12 @@ xchk_nlinks_ilock_dir(
 {
 	uint			lock_mode = XFS_ILOCK_SHARED;
 
+	/*
+	 * Take the IOLOCK so that other threads cannot start a directory
+	 * update while we're scanning.
+	 */
+	xfs_ilock(ip, XFS_IOLOCK_SHARED);
+
 	/*
 	 * We're going to scan the directory entries, so we must be ready to
 	 * pull the data fork mappings into memory if they aren't already.
@@ -397,13 +403,8 @@ xchk_nlinks_ilock_dir(
 	    xfs_need_iread_extents(&ip->i_af))
 		lock_mode = XFS_ILOCK_EXCL;
 
-	/*
-	 * Take the IOLOCK so that other threads cannot start a directory
-	 * update while we're scanning.
-	 */
-	lock_mode |= XFS_IOLOCK_SHARED;
 	xfs_ilock(ip, lock_mode);
-	return lock_mode;
+	return lock_mode | XFS_IOLOCK_SHARED;
 }
 
 /* Walk a directory to bump the observed link counts of the children. */
diff --git a/fs/xfs/scrub/nlinks_repair.c b/fs/xfs/scrub/nlinks_repair.c
index 9049215c6eae..ccc80ee1a3a2 100644
--- a/fs/xfs/scrub/nlinks_repair.c
+++ b/fs/xfs/scrub/nlinks_repair.c
@@ -232,9 +232,14 @@ xrep_nlinks_repair_inode(
 	 * unlinked list, put it on the unlinked list.
 	 */
 	if (total_links == 0 && !xfs_inode_on_unlinked_list(ip)) {
+		if (actual_nlink)
+			clear_nlink(VFS_I(ip));
 		error = xfs_iunlink(sc->tp, ip);
-		if (error)
+		if (error) {
+			if (actual_nlink)
+				set_nlink(VFS_I(ip), actual_nlink);
 			goto out_trans;
+		}
 		dirty = true;
 	}
 
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 931604fa1294..8e321b24181c 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -486,7 +486,7 @@ xchk_parent_scan_attr(
 			valuelen, &parent_ino, NULL);
 	if (error) {
 		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, 0);
-		return error;
+		return -ECANCELED;
 	}
 
 	/* No self-referential parent pointers. */
diff --git a/fs/xfs/scrub/rtbitmap_repair.c b/fs/xfs/scrub/rtbitmap_repair.c
index f4ca86a2ea1b..7b12c4bcfa3a 100644
--- a/fs/xfs/scrub/rtbitmap_repair.c
+++ b/fs/xfs/scrub/rtbitmap_repair.c
@@ -36,6 +36,24 @@
 
 /* rt bitmap content repairs */
 
+/*
+ * Reserve enough blocks to write out a completely new bitmap file, plus twice
+ * as many blocks as we would need if we can only allocate one block per data
+ * fork mapping.  This should cover the preallocation of the temporary file and
+ * exchanging the extent mappings.
+ *
+ * We cannot use xfs_exchmaps_estimate because we have not yet constructed the
+ * replacement bitmap and therefore do not know how many extents it will use.
+ * By the time we do, we will have a dirty transaction (which we cannot drop
+ * because we cannot drop the rtbitmap ILOCK) and cannot ask for more
+ * reservation.
+ */
+static inline unsigned long long
+xrep_rtbitmap_calc_blocks(struct xfs_mount *mp, unsigned long long blocks)
+{
+	return blocks + (xfs_bmbt_calc_size(mp, blocks) * 2);
+}
+
 /* Set up to repair the realtime bitmap for this group. */
 int
 xrep_setup_rtbitmap(
@@ -56,20 +74,7 @@ xrep_setup_rtbitmap(
 	if (error)
 		return error;
 
-	/*
-	 * Reserve enough blocks to write out a completely new bitmap file,
-	 * plus twice as many blocks as we would need if we can only allocate
-	 * one block per data fork mapping.  This should cover the
-	 * preallocation of the temporary file and exchanging the extent
-	 * mappings.
-	 *
-	 * We cannot use xfs_exchmaps_estimate because we have not yet
-	 * constructed the replacement bitmap and therefore do not know how
-	 * many extents it will use.  By the time we do, we will have a dirty
-	 * transaction (which we cannot drop because we cannot drop the
-	 * rtbitmap ILOCK) and cannot ask for more reservation.
-	 */
-	blocks += xfs_bmbt_calc_size(mp, blocks) * 2;
+	blocks = xrep_rtbitmap_calc_blocks(mp, mp->m_sb.sb_rbmblocks);
 	if (blocks > UINT_MAX)
 		return -EOPNOTSUPP;
 
@@ -512,7 +517,7 @@ xrep_rtbitmap(
 	struct xchk_rtbitmap	*rtb = sc->buf;
 	struct xfs_mount	*mp = sc->mp;
 	struct xfs_group	*xg = rtg_group(sc->sr.rtg);
-	unsigned long long	blocks = 0;
+	unsigned long long	blocks;
 	unsigned int		busy_gen;
 	int			error;
 
@@ -532,15 +537,20 @@ xrep_rtbitmap(
 	 * figure out if we need to adjust the block reservation in the
 	 * transaction.
 	 */
-	blocks = xfs_bmbt_calc_size(mp, rtb->rbmblocks);
+	blocks = xrep_rtbitmap_calc_blocks(mp, rtb->rbmblocks);
 	if (blocks > UINT_MAX)
 		return -EOPNOTSUPP;
 	if (blocks > rtb->resblks) {
-		error = xfs_trans_reserve_more(sc->tp, blocks, 0);
+		uint64_t	delta = blocks - rtb->resblks;
+
+		if (delta > UINT_MAX)
+			return -EOPNOTSUPP;
+
+		error = xfs_trans_reserve_more(sc->tp, delta, 0);
 		if (error)
 			return error;
 
-		rtb->resblks += blocks;
+		rtb->resblks += delta;
 	}
 
 	/* Fix inode core and forks. */
diff --git a/fs/xfs/scrub/tempfile.c b/fs/xfs/scrub/tempfile.c
index 8d754df72aa5..2392220ba1f3 100644
--- a/fs/xfs/scrub/tempfile.c
+++ b/fs/xfs/scrub/tempfile.c
@@ -174,6 +174,7 @@ xrep_tempfile_create(
 		xfs_iunlock(sc->tempip, XFS_ILOCK_EXCL);
 		xfs_finish_inode_setup(sc->tempip);
 		xchk_irele(sc, sc->tempip);
+		sc->tempip = NULL;
 	}
 out_release_dquots:
 	xfs_qm_dqrele(udqp);
diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index fab3ce323e4c..90a7c8cad9b9 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -3579,10 +3579,12 @@ DEFINE_EVENT(xrep_iunlink_resolve_class, name, \
 	TP_PROTO(const struct xfs_perag *pag, unsigned int bucket, \
 		 xfs_agino_t prev_agino, xfs_agino_t next_agino), \
 	TP_ARGS(pag, bucket, prev_agino, next_agino))
+DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_infinite_loop);
 DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_uncached);
 DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_wronglist);
 DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_nolist);
 DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_ok);
+DEFINE_REPAIR_IUNLINK_RESOLVE_EVENT(xrep_iunlink_resolve_allocated);
 
 TRACE_EVENT(xrep_iunlink_relink_next,
 	TP_PROTO(struct xfs_inode *ip, xfs_agino_t next_agino),
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 02b95b89d1b5..240deb3f7827 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -461,7 +461,7 @@ xlog_recover_validate_buf_type(
  * given buffer.  The bitmap in the buf log format structure indicates
  * where to place the logged data.
  */
-STATIC void
+STATIC int
 xlog_recover_do_reg_buffer(
 	struct xfs_mount		*mp,
 	struct xlog_recover_item	*item,
@@ -489,8 +489,24 @@ xlog_recover_do_reg_buffer(
 		ASSERT(nbits > 0);
 		ASSERT(item->ri_buf[i].iov_base != NULL);
 		ASSERT(item->ri_buf[i].iov_len % XFS_BLF_CHUNK == 0);
-		ASSERT(BBTOB(bp->b_length) >=
-		       ((uint)bit << XFS_BLF_SHIFT) + (nbits << XFS_BLF_SHIFT));
+		/*
+		 * The bitmap is only trustworthy to the extent that it
+		 * describes a region that actually fits inside the buffer we
+		 * read in based on the (attacker-controlled) blf_len.  Do not
+		 * rely on an ASSERT() for this -- it compiles away entirely on
+		 * non-DEBUG kernels, which is exactly where this matters, so
+		 * validate it for real and abort recovery of this buffer rather
+		 * than copying past the end of it.
+		 */
+		if (XFS_IS_CORRUPT(mp, BBTOB(bp->b_length) <
+				((uint)bit << XFS_BLF_SHIFT) +
+				(nbits << XFS_BLF_SHIFT))) {
+			xfs_alert(mp,
+	"Bad buffer log item dirty bitmap (bit %d, nbits %d) for %d-byte buffer at daddr 0x%llx.",
+				bit, nbits, BBTOB(bp->b_length),
+				xfs_buf_daddr(bp));
+			return -EFSCORRUPTED;
+		}
 
 		/*
 		 * The dirty regions logged in the buffer, even though
@@ -544,6 +560,7 @@ xlog_recover_do_reg_buffer(
 	ASSERT(i == item->ri_total);
 
 	xlog_recover_validate_buf_type(mp, bp, buf_f, current_lsn);
+	return 0;
 }
 
 /*
@@ -552,10 +569,10 @@ xlog_recover_do_reg_buffer(
  * (ie. USR or GRP), then just toss this buffer away; don't recover it.
  * Else, treat it as a regular buffer and do recovery.
  *
- * Return false if the buffer was tossed and true if we recovered the buffer to
- * indicate to the caller if the buffer needs writing.
+ * Return 0 if the buffer was not recovered (tossed), 1 if it was recovered and
+ * needs writing, or a negative errno if recovery of the buffer failed.
  */
-STATIC bool
+STATIC int
 xlog_recover_do_dquot_buffer(
 	struct xfs_mount		*mp,
 	struct xlog			*log,
@@ -564,6 +581,7 @@ xlog_recover_do_dquot_buffer(
 	struct xfs_buf_log_format	*buf_f)
 {
 	uint			type;
+	int			error;
 
 	trace_xfs_log_recover_buf_dquot_buf(log, buf_f);
 
@@ -571,7 +589,7 @@ xlog_recover_do_dquot_buffer(
 	 * Filesystems are required to send in quota flags at mount time.
 	 */
 	if (!mp->m_qflags)
-		return false;
+		return 0;
 
 	type = 0;
 	if (buf_f->blf_flags & XFS_BLF_UDQUOT_BUF)
@@ -584,10 +602,12 @@ xlog_recover_do_dquot_buffer(
 	 * This type of quotas was turned off, so ignore this buffer
 	 */
 	if (log->l_quotaoffs_flag & type)
-		return false;
+		return 0;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
-	return true;
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, NULLCOMMITLSN);
+	if (error)
+		return error;
+	return 1;
 }
 
 /*
@@ -724,7 +744,9 @@ xlog_recover_do_primary_sb_buffer(
 	xfs_rgnumber_t			orig_rgcount = mp->m_sb.sb_rgcount;
 	int				error;
 
-	xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+	error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+	if (error)
+		return error;
 
 	if (orig_agcount == 0) {
 		xfs_alert(mp, "Trying to grow file system without AGs");
@@ -1081,11 +1103,11 @@ xlog_recover_buf_commit_pass2(
 			goto out_release;
 	} else if (buf_f->blf_flags &
 		  (XFS_BLF_UDQUOT_BUF|XFS_BLF_PDQUOT_BUF|XFS_BLF_GDQUOT_BUF)) {
-		bool	dirty;
-
-		dirty = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
-		if (!dirty)
+		error = xlog_recover_do_dquot_buffer(mp, log, item, bp, buf_f);
+		if (error <= 0)
 			goto out_release;
+		/* write dirty buffer */
+		error = 0;
 	} else if ((xfs_blft_from_flags(buf_f) & XFS_BLFT_SB_BUF) &&
 			xfs_buf_daddr(bp) == 0) {
 		error = xlog_recover_do_primary_sb_buffer(mp, item, bp, buf_f,
@@ -1105,7 +1127,10 @@ xlog_recover_buf_commit_pass2(
 			xfs_buf_relse(rtsb_bp);
 		}
 	} else {
-		xlog_recover_do_reg_buffer(mp, item, bp, buf_f, current_lsn);
+		error = xlog_recover_do_reg_buffer(mp, item, bp, buf_f,
+						   current_lsn);
+		if (error)
+			goto out_release;
 	}
 
 	/*
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index c311f61d9554..b4f6c594808c 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -778,7 +778,7 @@ xfs_dq_get_next_id(
 	lock_flags = xfs_ilock_data_map_shared(quotip);
 	error = xfs_iread_extents(NULL, quotip, XFS_DATA_FORK);
 	if (error)
-		return error;
+		goto out_unlock;
 
 	if (xfs_iext_lookup_extent(quotip, &quotip->i_df, start, &cur, &got)) {
 		/* contiguous chunk, bump startoff for the id calculation */
@@ -789,6 +789,7 @@ xfs_dq_get_next_id(
 		error = -ENOENT;
 	}
 
+out_unlock:
 	xfs_iunlock(quotip, lock_flags);
 
 	return error;
diff --git a/fs/xfs/xfs_dquot_item_recover.c b/fs/xfs/xfs_dquot_item_recover.c
index fe419b28de22..63bc9ab7d947 100644
--- a/fs/xfs/xfs_dquot_item_recover.c
+++ b/fs/xfs/xfs_dquot_item_recover.c
@@ -173,7 +173,7 @@ xlog_recover_dquot_commit_pass2(
 
 out_release:
 	xfs_buf_relse(bp);
-	return 0;
+	return error;
 }
 
 const struct xlog_recover_item_ops xlog_dquot_item_ops = {
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 7a3f97686989..84efe5a8fb11 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -737,7 +737,7 @@ xfs_rtginode_ensure(
 	xfs_trans_cancel(tp);
 
 	if (error != -ENOENT)
-		return 0;
+		return error;
 	return xfs_rtginode_create(rtg, type, true);
 }
 
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index ed9da6e41a2a..31ce349ed42c 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -233,6 +233,7 @@ static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
 static __always_inline bool rseq_grant_slice_extension(unsigned long ti_work, unsigned long mask)
 {
 	if (unlikely(__rseq_grant_slice_extension(ti_work & mask))) {
+		guard(irq)();
 		hrtimer_rearm_deferred_tif(ti_work);
 		return true;
 	}
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577..73dc3183e279 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -7,6 +7,8 @@
 
 #include <linux/clockchips.h>
 #include <linux/irqflags.h>
+#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/percpu.h>
 #include <linux/context_tracking_state.h>
 #include <linux/cpumask.h>
diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index 7f7fa4484492..b3ac38e6cdd7 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -2046,7 +2046,7 @@ static inline bool ip_vs_conn_use_hash2(struct ip_vs_conn *cp)
 	       !(cp->flags & IP_VS_CONN_F_TEMPLATE);
 }
 
-void ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
+bool ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		    struct ip_vs_conn *cp, int dir, unsigned int toff,
 		    bool has_ports, struct ip_vs_iphdr *ciph);
 
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 3d3aef80beac..8e84d29b0bfb 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -64,7 +64,7 @@ static inline void netdev_unlock_full_to_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
-static inline void netdev_ops_assert_locked(const struct net_device *dev)
+static inline void netdev_assert_locked_ops_compat(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
 		lockdep_assert_held(&dev->lock);
@@ -73,11 +73,11 @@ static inline void netdev_ops_assert_locked(const struct net_device *dev)
 }
 
 static inline void
-netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
+netdev_assert_locked_ops_compat_or_invisible(const struct net_device *dev)
 {
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING)
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 }
 
 static inline void netdev_lock_ops_compat(struct net_device *dev)
diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index 6f2cd562b1de..74b3790e2a3d 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -22,6 +22,7 @@ struct sctp_endpoint;
 struct sctp_association;
 struct sctp_authkey;
 struct sctp_hmacalgo;
+struct sctp_cookie;
 
 /* Defines an HMAC algorithm supported by SCTP chunk authentication */
 struct sctp_hmac {
@@ -72,6 +73,8 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 				struct sctp_association *asoc,
 				gfp_t gfp);
+bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
+				    const struct sctp_cookie *cookie);
 const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
 const struct sctp_hmac *
 sctp_auth_asoc_get_hmac(const struct sctp_association *asoc);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index f6b286fa59f2..98b0ccf0813e 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -664,6 +664,9 @@ struct Scsi_Host {
 	/* Asynchronous scan in progress */
 	bool async_scan __guarded_by(&scan_mutex);
 
+	/* Don't resume host in EH */
+	bool eh_noresume;
+
 	unsigned active_mode:2;
 
 	/*
@@ -682,9 +685,6 @@ struct Scsi_Host {
 	/* Task mgmt function in progress */
 	unsigned tmf_in_progress:1;
 
-	/* Don't resume host in EH */
-	unsigned eh_noresume:1;
-
 	/* The controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3b4c43203210..1a23ae67c3cc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13942,7 +13942,7 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_fd;
 		}
 		group_leader = fd_file(group)->private_data;
-		if (group_leader->state <= PERF_EVENT_STATE_REVOKED) {
+		if (group_leader->state <= PERF_EVENT_STATE_EXIT) {
 			err = -ENODEV;
 			goto err_fd;
 		}
@@ -14073,6 +14073,12 @@ SYSCALL_DEFINE5(perf_event_open,
 		if (group_leader->ctx != ctx)
 			goto err_locked;
 
+		/* Recheck under ctx::mutex to serialize against remove-on-exec. */
+		if (group_leader->state <= PERF_EVENT_STATE_EXIT) {
+			err = -ENODEV;
+			goto err_locked;
+		}
+
 		/*
 		 * Only a group leader can be exclusive or pinned
 		 */
diff --git a/kernel/pid.c b/kernel/pid.c
index f55189a3d07d..d01d0dd7114b 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -324,8 +324,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	 * error path may try to wakeup the possibly freed ns->child_reaper.
 	 */
 	retval = -ENOMEM;
-	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
-		goto out_free;
+	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid)
+		if (unlikely(!(upid->ns->pid_allocated & PIDNS_ADDING)))
+			goto out_free;
+
 	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ce360a306f2e..2303b5815875 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2627,7 +2627,8 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	guard(preempt_notrace)();
+	entry = __ftrace_lookup_ip(rcu_dereference_sched(direct_functions), ip);
 	if (!entry)
 		return 0;
 
@@ -6488,6 +6489,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	struct ftrace_hash *new_direct_functions;
 	struct ftrace_hash *new_filter_hash = NULL;
 	struct ftrace_hash *old_filter_hash;
+	struct ftrace_hash *direct_hash;
 	struct ftrace_func_entry *entry;
 	struct ftrace_func_entry *del;
 	unsigned long size;
@@ -6499,11 +6501,13 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
-	if (direct_functions == EMPTY_HASH)
-		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
 
+	direct_hash = rcu_dereference_protected(direct_functions, lockdep_is_held(&direct_mutex));
+	if (direct_hash == EMPTY_HASH)
+		goto out_unlock;
+
 	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 
 	if (!hash_count(old_filter_hash))
@@ -6513,7 +6517,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (int i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			del = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!del || del->direct != entry->direct)
 				goto out_unlock;
 		}
@@ -6524,7 +6528,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	if (!new_filter_hash)
 		goto out_unlock;
 
-	new_direct_functions = hash_sub(direct_functions, hash);
+	new_direct_functions = hash_sub(direct_hash, hash);
 	if (!new_direct_functions)
 		goto out_unlock;
 
@@ -6551,7 +6555,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		/* free the new_direct_functions */
 		old_direct_functions = new_direct_functions;
 	} else {
-		old_direct_functions = direct_functions;
+		old_direct_functions = direct_hash;
 		rcu_assign_pointer(direct_functions, new_direct_functions);
 	}
 
@@ -6590,6 +6594,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 		.func		= ftrace_stub,
 		.flags		= FTRACE_OPS_FL_STUB,
 	};
+	struct ftrace_hash *direct_hash;
 	struct ftrace_hash *orig_hash;
 	unsigned long size, i;
 	int err = -EINVAL;
@@ -6600,8 +6605,6 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
-	if (direct_functions == EMPTY_HASH)
-		return -EINVAL;
 
 	/*
 	 * We can be called from within ops_func callback with direct_mutex
@@ -6609,6 +6612,12 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	 */
 	if (do_direct_lock)
 		mutex_lock(&direct_mutex);
+	else
+		lockdep_assert_held_once(&direct_mutex);
+
+	direct_hash = rcu_dereference_protected(direct_functions, lockdep_is_held(&direct_mutex));
+	if (direct_hash == EMPTY_HASH)
+		goto unlock;
 
 	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 	if (!orig_hash)
@@ -6640,7 +6649,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			tmp = __ftrace_lookup_ip(direct_functions, entry->ip);
+			tmp = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!tmp)
 				continue;
 			tmp->direct = entry->direct;
@@ -8273,7 +8282,8 @@ static void add_to_clear_hash_list(struct list_head *clear_list,
 void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 {
 	unsigned long start = (unsigned long)(start_ptr);
-	unsigned long end = (unsigned long)(end_ptr);
+	/* end is inclusive and end_ptr is exclusive */
+	unsigned long end = (unsigned long)(end_ptr) - 1;
 	struct ftrace_page **last_pg = &ftrace_pages_start;
 	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
@@ -8283,6 +8293,9 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct ftrace_init_func *func, *func_next;
 	LIST_HEAD(clear_hash);
 
+	if (start_ptr >= end_ptr)
+		return;
+
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 208cb3558f8c..bd3168ca4ae2 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1159,7 +1159,7 @@ static void rhashtable_free_one(struct rhashtable *ht, struct rhash_head *obj,
 	list = container_of(obj, struct rhlist_head, rhead);
 	do {
 		obj = &list->rhead;
-		list = rht_dereference(list->next, ht);
+		list = rcu_dereference_raw(list->next);
 		free_fn(rht_obj(ht, obj), arg);
 	} while (list);
 }
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 377336982f7d..2c8fefc1a721 100644
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
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..28d76c2f6b3e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5044,6 +5044,9 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+
+bad:
+	return -EINVAL;
 }
 
 /*
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a4b0dd8672ec..d6282f0bcff8 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2809,9 +2809,10 @@ static void get_temp_osds(struct ceph_osdmap *osdmap,
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
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 58ec448e8357..9f83a3c1315a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1593,7 +1593,7 @@ EXPORT_SYMBOL(netdev_features_change);
 
 void netif_state_change(struct net_device *dev)
 {
-	netdev_ops_assert_locked_or_invisible(dev);
+	netdev_assert_locked_ops_compat_or_invisible(dev);
 
 	if (dev->flags & IFF_UP) {
 		struct netdev_notifier_change_info change_info = {
@@ -1693,7 +1693,7 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	set_bit(__LINK_STATE_START, &dev->state);
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
@@ -1770,7 +1770,7 @@ static void __dev_close_many(struct list_head *head)
 		 *	event.
 		 */
 
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
@@ -3198,7 +3198,7 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
 						  txq);
@@ -3247,7 +3247,7 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
 						  rxq);
@@ -7313,7 +7313,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	netdev_ops_assert_locked_or_invisible(dev);
+	netdev_assert_locked_ops_compat_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
@@ -9608,7 +9608,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9667,7 +9667,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9735,7 +9735,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	/*
 	 *	Set the flags on our device.
@@ -9883,7 +9883,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 {
 	int err, orig_mtu;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (new_mtu == dev->mtu)
 		return 0;
@@ -10317,7 +10317,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
@@ -10769,7 +10769,7 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
 {
 	int i;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	for (i = dev->real_num_rx_queues - 1; i >= 0; i--)
 		if (dev->_rx[i].mp_params.mp_priv)
@@ -10997,7 +10997,7 @@ int __netdev_update_features(struct net_device *dev)
 	int err = -1;
 
 	ASSERT_RTNL();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	features = netdev_get_wanted_features(dev);
 
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d73fcb0c6785..6b493af8dc8b 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1260,7 +1260,7 @@ static void netif_rx_mode_run(struct net_device *dev)
 	int err;
 
 	might_sleep();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	__hw_addr_init(&uc_snap);
 	__hw_addr_init(&mc_snap);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index ff2c1d4538ef..9c35aac8b2e9 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -277,7 +277,7 @@ static bool linkwatch_clean_dev(struct net_device *dev)
 
 void __linkwatch_sync_dev(struct net_device *dev)
 {
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (linkwatch_clean_dev(dev)) {
 		linkwatch_do_dev(dev);
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 9e9fb25314b9..14fd8fcdcd56 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -24,7 +24,7 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_CHANGE:
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 73fb28087a93..f5558b12877c 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,7 +40,7 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked(dev);
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 7d45f9a884e5..8d5ee7987530 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -98,7 +98,7 @@ int ethnl_ops_begin(struct net_device *dev)
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (!netif_device_present(dev) ||
 	    dev->reg_state >= NETREG_UNREGISTERING) {
@@ -1003,7 +1003,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 		       ops->req_info_size - sizeof(*req_info));
 	}
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, &info);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e2c022f02c64..d774f049b5bf 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1039,9 +1039,9 @@ static void tcp_event_data_recv(struct sock *sk, struct sk_buff *skb)
 			/* The fastest case is the first. */
 			icsk->icsk_ack.ato = (icsk->icsk_ack.ato >> 1) + TCP_ATO_MIN / 2;
 		} else if (m < icsk->icsk_ack.ato) {
-			icsk->icsk_ack.ato = (icsk->icsk_ack.ato >> 1) + m;
-			if (icsk->icsk_ack.ato > icsk->icsk_rto)
-				icsk->icsk_ack.ato = icsk->icsk_rto;
+			icsk->icsk_ack.ato = min3((icsk->icsk_ack.ato >> 1) + (u32)m,
+						  icsk->icsk_rto,
+						  (u32)TCP_DELACK_MAX);
 		} else if (m > icsk->icsk_rto) {
 			/* Too long gap. Apparently sender failed to
 			 * restart window, so that we send ACKs quickly.
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 322db13333c7..c94270d99ce4 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -334,7 +334,9 @@ void tcp_delack_timer_handler(struct sock *sk)
 	if (inet_csk_ack_scheduled(sk)) {
 		if (!inet_csk_in_pingpong_mode(sk)) {
 			/* Delayed ACK missed: inflate ATO. */
-			icsk->icsk_ack.ato = min_t(u32, icsk->icsk_ack.ato << 1, icsk->icsk_rto);
+			icsk->icsk_ack.ato = min3((u32)icsk->icsk_ack.ato << 1,
+						  icsk->icsk_rto,
+						  (u32)TCP_DELACK_MAX);
 		} else {
 			/* Delayed ACK missed: leave pingpong mode and
 			 * deflate ATO.
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index defa4277e783..ba4f80fd3db8 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -380,7 +380,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 
 	ASSERT_RTNL();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (dev->mtu < IPV6_MIN_MTU && dev != blackhole_netdev)
 		return ERR_PTR(-EINVAL);
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index b26986fda9d6..c12d5e1ee550 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -306,6 +306,10 @@ static int l2tp_dfs_seq_release(struct inode *inode, struct file *file)
 
 	seq = file->private_data;
 	pd = seq->private;
+	if (pd->session)
+		l2tp_session_put(pd->session);
+	if (pd->tunnel)
+		l2tp_tunnel_put(pd->tunnel);
 	if (pd->net)
 		put_net_track(pd->net, &pd->ns_tracker);
 	kfree(pd);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index e0b1915be1a6..353f8ecf754d 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1603,7 +1603,53 @@ static const struct seq_operations pppol2tp_seq_ops = {
 	.stop		= pppol2tp_seq_stop,
 	.show		= pppol2tp_seq_show,
 };
-#endif /* CONFIG_PROC_FS */
+
+static int pppol2tp_proc_open(struct inode *inode, struct file *file)
+{
+	struct net *net = pde_data(inode);
+	struct pppol2tp_seq_data *pd;
+
+	net = maybe_get_net(net);
+	if (!net)
+		return -ENXIO;
+
+	pd = __seq_open_private(file, &pppol2tp_seq_ops, sizeof(*pd));
+	if (!pd) {
+		put_net(net);
+		return -ENOMEM;
+	}
+
+#ifdef CONFIG_NET_NS
+	pd->p.net = net;
+	netns_tracker_alloc(net, &pd->p.ns_tracker, GFP_KERNEL);
+#endif
+	return 0;
+}
+
+static int pppol2tp_proc_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct pppol2tp_seq_data *pd = seq->private;
+
+	if (pd->session)
+		l2tp_session_put(pd->session);
+	if (pd->tunnel)
+		l2tp_tunnel_put(pd->tunnel);
+
+#ifdef CONFIG_NET_NS
+	put_net_track(pd->p.net, &pd->p.ns_tracker);
+#else
+	put_net(&init_net);
+#endif
+	return seq_release_private(inode, file);
+}
+
+static const struct proc_ops pppol2tp_proc_ops = {
+	.proc_open	= pppol2tp_proc_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= pppol2tp_proc_release,
+};
 
 /*****************************************************************************
  * Network namespace
@@ -1614,8 +1660,8 @@ static __net_init int pppol2tp_init_net(struct net *net)
 	struct proc_dir_entry *pde;
 	int err = 0;
 
-	pde = proc_create_net("pppol2tp", 0444, net->proc_net,
-			      &pppol2tp_seq_ops, sizeof(struct pppol2tp_seq_data));
+	pde = proc_create_data("pppol2tp", 0444, net->proc_net,
+			       &pppol2tp_proc_ops, net);
 	if (!pde) {
 		err = -ENOMEM;
 		goto out;
@@ -1630,9 +1676,13 @@ static __net_exit void pppol2tp_exit_net(struct net *net)
 	remove_proc_entry("pppol2tp", net->proc_net);
 }
 
+#endif /* CONFIG_PROC_FS */
+
 static struct pernet_operations pppol2tp_net_ops = {
+#ifdef CONFIG_PROC_FS
 	.init = pppol2tp_init_net,
 	.exit = pppol2tp_exit_net,
+#endif
 };
 
 /*****************************************************************************
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 082c46c0f50e..f717750906ff 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -24,12 +24,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	sk = subflow->conn;
 	tp = tcp_sk(ssk);
 
-	subflow->is_mptfo = 1;
-
+	/* A valid TFO cookie does not guarantee SYN data. */
 	skb = skb_peek(&ssk->sk_receive_queue);
-	if (WARN_ON_ONCE(!skb))
+	if (!skb)
 		return;
 
+	subflow->is_mptfo = 1;
+
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 336bcc419066..6c8b214e7659 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -50,6 +50,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			}
 		}
 
+		/* Only the MPC + ACK can be used with a RM_ADDR */
+		if (subopt == OPTION_MPTCP_MPC_ACK) {
+			if ((mp_opt->suboptions & ~OPTION_MPTCP_RM_ADDR) != 0)
+				break;
+		} else if (mp_opt->suboptions != 0) {
+			break;
+		}
+
 		/* Cfr RFC 8684 Section 3.3.0:
 		 * If a checksum is present but its use had
 		 * not been negotiated in the MP_CAPABLE handshake, the receiver MUST
@@ -122,6 +130,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_JOIN:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize == TCPOLEN_MPTCP_MPJ_SYN) {
 			mp_opt->suboptions |= OPTION_MPTCP_MPJ_SYN;
 			mp_opt->backup = *ptr++ & MPTCPOPT_BACKUP;
@@ -153,6 +166,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_DSS:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO |
+					    OPTION_MPTCP_FASTCLOSE |
+					    OPTION_MPTCP_FAIL)) != 0)
+			break;
+
 		pr_debug("DSS\n");
 		ptr++;
 
@@ -188,8 +209,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
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
@@ -234,6 +261,12 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_ADD_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RM_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		mp_opt->echo = (*ptr++) & MPTCP_ADDR_ECHO;
 		if (!mp_opt->echo) {
 			if (opsize == TCPOLEN_MPTCP_ADD_ADDR ||
@@ -293,6 +326,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RM_ADDR:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_MPC_ACK |
+					    OPTIONS_MPTCP_MPJ |
+					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_PRIO)) != 0)
+			break;
+
 		if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
 		    opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MAX)
 			break;
@@ -307,6 +348,13 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_PRIO:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_MPJ |
+					    OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_ADD_ADDR |
+					    OPTION_MPTCP_RM_ADDR)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_PRIO)
 			break;
 
@@ -316,6 +364,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FASTCLOSE:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FASTCLOSE)
 			break;
 
@@ -327,6 +380,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_RST:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTION_MPTCP_FAIL |
+					    OPTION_MPTCP_FASTCLOSE)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_RST)
 			break;
 
@@ -342,6 +400,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		break;
 
 	case MPTCPOPT_MP_FAIL:
+		/* Can be used with a restricted number of other options */
+		if ((mp_opt->suboptions & ~(OPTIONS_MPTCP_DSS |
+					    OPTION_MPTCP_RST)) != 0)
+			break;
+
 		if (opsize != TCPOLEN_MPTCP_FAIL)
 			break;
 
@@ -1419,7 +1482,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 	 *  RM   |  C   |  C   |  C   |  P   |------|------|------|------|
 	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
 	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
-	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  FC   |  X   |  X   |  P   |  X   |  X   |  X   |  X   |------|
 	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
 	 * ------|------|------|------|------|------|------|------|------|
 	 *
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 470501470fe5..c5f95c251fbf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -345,6 +345,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
+	bool retransmit;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -377,14 +378,15 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		entry->retrans_times++;
 	}
 
-	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
+	retransmit = entry->retrans_times < ADD_ADDR_RETRANS_MAX;
+	if (retransmit)
 		timeout <<= entry->retrans_times;
 	else
 		timeout = 0;
 
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry->retrans_times == ADD_ADDR_RETRANS_MAX)
+	if (!retransmit)
 		mptcp_pm_subflow_established(msk);
 
 out:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..7c8180d8d5ef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -149,6 +149,12 @@ struct sock *__mptcp_nmpc_sk(struct mptcp_sock *msk)
 
 static void mptcp_drop(struct sock *sk, struct sk_buff *skb)
 {
+	/* The skb forward memory was already transferred to sk by
+	 * mptcp_borrow_fwdmem(), even before setting the destructor.
+	 */
+	if (!skb->destructor)
+		sk_mem_reclaim(sk);
+
 	sk_drops_skbadd(sk, skb);
 	__kfree_skb(skb);
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b93b878478d2..352d5771de0b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -37,6 +37,7 @@
 				 OPTION_MPTCP_MPC_ACK)
 #define OPTIONS_MPTCP_MPJ	(OPTION_MPTCP_MPJ_SYN | OPTION_MPTCP_MPJ_SYNACK | \
 				 OPTION_MPTCP_MPJ_ACK)
+#define OPTIONS_MPTCP_DSS	(OPTION_MPTCP_DSS | OPTION_MPTCP_CSUMREQD)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
diff --git a/net/netfilter/ipset/ip_set_bitmap_gen.h b/net/netfilter/ipset/ip_set_bitmap_gen.h
index 226fdf17b683..d6a7e6604542 100644
--- a/net/netfilter/ipset/ip_set_bitmap_gen.h
+++ b/net/netfilter/ipset/ip_set_bitmap_gen.h
@@ -77,7 +77,7 @@ mtype_flush(struct ip_set *set)
 		mtype_ext_cleanup(set);
 	bitmap_zero(map->members, map->elements);
 	set->elements = 0;
-	atomic64_set(&set->ext_size, 0);
+	DEBUG_NET_WARN_ON_ONCE(atomic64_read(&set->ext_size) > 0);
 }
 
 /* Calculate the actual memory size of the set data */
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 822a53a7f502..5624036daf8c 100644
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
 
@@ -854,11 +861,11 @@ __ip_set_put_byindex(struct ip_set_net *inst, ip_set_id_t index)
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
index ca3ef9479e83..f070088742d6 100644
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
@@ -420,8 +423,7 @@ list_set_flush(struct ip_set *set)
 
 	list_for_each_entry_safe(e, n, &map->members, list)
 		list_set_del(set, e);
-	set->elements = 0;
-	atomic64_set(&set->ext_size, 0);
+	DEBUG_NET_WARN_ON_ONCE(set->elements > 0);
 }
 
 static void
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index a46e7acdd8e1..eb806813292a 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -923,7 +923,7 @@ static int ip_vs_route_me_harder(struct netns_ipvs *ipvs, int af,
  * Packet has been made sufficiently writable in caller
  * - inout: 1=in->out, 0=out->in
  */
-void ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
+bool ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
 		    struct ip_vs_conn *cp, int inout, unsigned int toff,
 		    bool has_ports, struct ip_vs_iphdr *ciph)
 {
@@ -931,6 +931,11 @@ void ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	struct icmphdr *icmph	 = (struct icmphdr *)(skb->data + toff);
 	struct iphdr *cih	 = (struct iphdr *)(icmph + 1);
 
+	/* Before now we may used ihl from skb frag, revalidate it after
+	 * copying it into skb head to prevent out-of-bounds access
+	 */
+	if (cih->ihl * 4 != ciph->len - ciph->off)
+		return false;
 	if (inout) {
 		iph->saddr = cp->vaddr.ip;
 		ip_send_check(iph);
@@ -964,6 +969,7 @@ void ip_vs_nat_icmp(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	else
 		IP_VS_DBG_PKT(11, AF_INET, pp, skb, ciph->off,
 			      "Forwarding altered incoming ICMP");
+	return true;
 }
 
 #ifdef CONFIG_IP_VS_IPV6
@@ -1055,7 +1061,8 @@ static int handle_response_icmp(int af, struct sk_buff *skb,
 		ip_vs_nat_icmp_v6(skb, pp, cp, 1, toff, has_ports, ciph);
 	else
 #endif
-		ip_vs_nat_icmp(skb, pp, cp, 1, toff, has_ports, ciph);
+		if (!ip_vs_nat_icmp(skb, pp, cp, 1, toff, has_ports, ciph))
+			goto out;
 
 	if (ip_vs_route_me_harder(cp->ipvs, af, skb, hooknum))
 		goto out;
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index fc7403186394..04450a48f01a 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1580,7 +1580,8 @@ ip_vs_icmp_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	if (skb_cow(skb, rt->dst.dev->hard_header_len))
 		goto tx_error;
 
-	ip_vs_nat_icmp(skb, pp, cp, 0, toff, has_ports, ciph);
+	if (!ip_vs_nat_icmp(skb, pp, cp, 0, toff, has_ports, ciph))
+		goto tx_error;
 
 	/* Another hack: avoid icmp_send in ip_fragment */
 	skb->ignore_df = 1;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index b66e65439341..8b1165f2b5a4 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -332,17 +332,18 @@ int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
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
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 9101b1703b52..35db19c0cf94 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -558,7 +558,7 @@ static void nft_flow_rule_offload_abort(struct net *net,
 			break;
 		}
 
-		if (WARN_ON_ONCE(err))
+		if (WARN_ON_ONCE(err && err != -ENOMEM))
 			break;
 	}
 }
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 435756877aba..1168bd6b09cd 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1943,13 +1943,13 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
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
@@ -2660,6 +2660,9 @@ static int tpacket_fill_skb(struct packet_sock *po, struct sk_buff *skb,
 		len = ((to_write > len_max) ? len_max : to_write);
 	}
 
+	if (unlikely(!skb->len))
+		return -EINVAL;
+
 	packet_parse_headers(skb, sock);
 
 	return tp_len;
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index b4a7e1c63cb8..0e131b247589 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -41,11 +41,9 @@ int tcf_dev_queue_xmit(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb))
 }
 EXPORT_SYMBOL_GPL(tcf_dev_queue_xmit);
 
-static void tcf_action_goto_chain_exec(const struct tc_action *a,
+static void tcf_action_goto_chain_exec(const struct tcf_chain *chain,
 				       struct tcf_result *res)
 {
-	const struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
-
 	res->goto_tp = rcu_dereference_bh(chain->filter_chain);
 }
 
@@ -1170,12 +1168,14 @@ int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 					return TC_ACT_OK;
 			}
 		} else if (TC_ACT_EXT_CMP(ret, TC_ACT_GOTO_CHAIN)) {
-			if (unlikely(!rcu_access_pointer(a->goto_chain))) {
+			struct tcf_chain *chain = rcu_dereference_bh(a->goto_chain);
+
+			if (unlikely(!chain)) {
 				tcf_set_drop_reason(skb,
 						    SKB_DROP_REASON_TC_CHAIN_NOTFOUND);
 				return TC_ACT_SHOT;
 			}
-			tcf_action_goto_chain_exec(a, res);
+			tcf_action_goto_chain_exec(chain, res);
 		}
 
 		if (ret != TC_ACT_PIPE)
diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
index 001d8c4ebfed..6d19155becc8 100644
--- a/net/sched/cls_bpf.c
+++ b/net/sched/cls_bpf.c
@@ -374,7 +374,8 @@ static int cls_bpf_prog_from_ops(struct nlattr **tb, struct cls_bpf_prog *prog)
 }
 
 static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
-				 u32 gen_flags, const struct tcf_proto *tp)
+				 u32 gen_flags, const struct tcf_proto *tp,
+				 struct netlink_ext_ack *extack)
 {
 	struct bpf_prog *fp;
 	char *name = NULL;
@@ -388,6 +389,19 @@ static int cls_bpf_prog_from_efd(struct nlattr **tb, struct cls_bpf_prog *prog,
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
+	if (bpf_prog_is_dev_bound(fp->aux)) {
+		struct tcf_block *block = tp->chain->block;
+		struct net_device *dev;
+
+		dev = block->q ? qdisc_dev(block->q) : NULL;
+		if (!dev || !bpf_offload_dev_match(fp, dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "Program is bound to a different device");
+			bpf_prog_put(fp);
+			return -EINVAL;
+		}
+	}
+
 	if (tb[TCA_BPF_NAME]) {
 		name = nla_memdup(tb[TCA_BPF_NAME], GFP_KERNEL);
 		if (!name) {
@@ -492,7 +506,7 @@ static int cls_bpf_change(struct net *net, struct sk_buff *in_skb,
 	prog->gen_flags = gen_flags;
 
 	ret = is_bpf ? cls_bpf_prog_from_ops(tb, prog) :
-		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp);
+		cls_bpf_prog_from_efd(tb, prog, gen_flags, tp, extack);
 	if (ret < 0)
 		goto errout_idr;
 
diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index ac98b1c2144a..c297d7dbcf91 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1346,6 +1346,9 @@ static void u32_bind_class(void *fh, u32 classid, unsigned long cl, void *q,
 {
 	struct tc_u_knode *n = fh;
 
+	if (TC_U32_KEY(n->handle) == 0)
+		return;
+
 	tc_cls_bind_class(classid, cl, q, &n->res, base);
 }
 
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index c901d373af80..cc4229ee116d 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -377,6 +377,81 @@ int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 	return -ENOMEM;
 }
 
+static bool sctp_auth_chunk_id_forbidden(__u8 chunk_id)
+{
+	switch (chunk_id) {
+	case SCTP_CID_INIT:
+	case SCTP_CID_INIT_ACK:
+	case SCTP_CID_SHUTDOWN_COMPLETE:
+	case SCTP_CID_AUTH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Verify AUTH parameters copied from a state cookie before they are restored
+ * into an association.  When cookie authentication is disabled these fields
+ * are peer-controlled, so they must satisfy the same constraints as locally
+ * generated AUTH parameters.
+ */
+bool sctp_auth_verify_cookie_params(const struct sctp_endpoint *ep,
+				    const struct sctp_cookie *cookie)
+{
+	const struct sctp_paramhdr *random;
+	const struct sctp_hmac_algo_param *hmacs;
+	const struct sctp_chunks_param *chunks;
+	u16 hmacs_len, chunks_len;
+	u16 n_hmacs, n_chunks, i;
+	bool has_sha1 = false;
+
+	if (sctp_sk(ep->base.sk)->cookie_auth_enable || !ep->auth_enable)
+		return true;
+
+	random = (const struct sctp_paramhdr *)cookie->auth_random;
+	if (random->type != SCTP_PARAM_RANDOM ||
+	    ntohs(random->length) != sizeof(*random) + SCTP_AUTH_RANDOM_LENGTH)
+		return false;
+
+	hmacs = (const struct sctp_hmac_algo_param *)cookie->auth_hmacs;
+	hmacs_len = ntohs(hmacs->param_hdr.length);
+	if (hmacs->param_hdr.type != SCTP_PARAM_HMAC_ALGO ||
+	    hmacs_len < sizeof(struct sctp_paramhdr) +
+			sizeof(hmacs->hmac_ids[0]) ||
+	    hmacs_len > sizeof(cookie->auth_hmacs) ||
+	    (hmacs_len - sizeof(struct sctp_paramhdr)) %
+			sizeof(hmacs->hmac_ids[0]))
+		return false;
+
+	n_hmacs = (hmacs_len - sizeof(struct sctp_paramhdr)) /
+		  sizeof(hmacs->hmac_ids[0]);
+	for (i = 0; i < n_hmacs; i++) {
+		u16 hmac_id = ntohs(hmacs->hmac_ids[i]);
+
+		if (!sctp_hmac_supported(hmac_id))
+			return false;
+		if (hmac_id == SCTP_AUTH_HMAC_ID_SHA1)
+			has_sha1 = true;
+	}
+	if (!has_sha1)
+		return false;
+
+	chunks = (const struct sctp_chunks_param *)cookie->auth_chunks;
+	chunks_len = ntohs(chunks->param_hdr.length);
+	if (chunks->param_hdr.type != SCTP_PARAM_CHUNKS ||
+	    chunks_len < sizeof(struct sctp_paramhdr) ||
+	    chunks_len > sizeof(cookie->auth_chunks))
+		return false;
+
+	n_chunks = chunks_len - sizeof(struct sctp_paramhdr);
+	for (i = 0; i < n_chunks; i++) {
+		if (sctp_auth_chunk_id_forbidden(chunks->chunks[i]))
+			return false;
+	}
+
+	return true;
+}
+
 
 /* Public interface to create the association shared key.
  * See code above for the algorithm.
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index e25612e9d082..236e25abc7a4 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1852,6 +1852,9 @@ struct sctp_association *sctp_unpack_cookie(
 	/* Set up our peer's port number.  */
 	retval->peer.port = ntohs(chunk->sctp_hdr->source);
 
+	if (!sctp_auth_verify_cookie_params(ep, bear_cookie))
+		goto malformed;
+
 	/* Populate the association from the cookie.  */
 	memcpy(&retval->c, bear_cookie, sizeof(*bear_cookie));
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e9aea371331b..ca0f657121a3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2319,6 +2319,11 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err < 0)
 		return err;
 
+	/* If crypto failed the connection is broken */
+	err = ctx->async_wait.err;
+	if (err)
+		goto splice_read_end;
+
 	if (!skb_queue_empty(&ctx->rx_list)) {
 		skb = __skb_dequeue(&ctx->rx_list);
 	} else {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0783555e2526..9fcaaf55cba5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -186,6 +186,7 @@ static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	if (!vertex->out_degree) {
 		edge->predecessor->vertex = NULL;
 		list_move_tail(&vertex->entry, &fpl->vertices);
+		list_del(&vertex->scc_entry);
 	}
 }
 
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index f72042260777..78c14f106395 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -244,7 +244,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
-	netdev_ops_assert_locked(netdev);
+	netdev_assert_locked_ops_compat(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 738fd47f33e6..e4fa4be4823f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -721,6 +721,7 @@ static inline void symtab_hash_eval(struct symtab *s)
 static int policydb_index(struct policydb *p)
 {
 	int i, rc;
+	u32 v;
 
 	if (p->mls_enabled)
 		pr_debug(
@@ -772,6 +773,24 @@ static int policydb_index(struct policydb *p)
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
@@ -1148,6 +1167,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	rc = symtab_insert(s, key, perdatum);
 	if (rc)
 		goto bad;
+	/* indexes an nprim-sized array in security_get_permissions() */
+	if (perdatum->value > s->nprim)
+		goto bad;
 
 	return 0;
 bad:
@@ -1363,6 +1385,18 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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
index 143021c5e326..a0ccf73a65dd 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2220,7 +2220,9 @@ void selinux_policy_cancel(struct selinux_load_state *load_state)
 	oldpolicy = rcu_dereference_protected(state->policy,
 					lockdep_is_held(&state->policy_mutex));
 
-	sidtab_cancel_convert(oldpolicy->sidtab);
+	/* a first load has no outgoing policy and converted nothing */
+	if (oldpolicy)
+		sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(load_state->policy);
 	kfree(load_state->convert_data);
 }
@@ -3301,6 +3303,7 @@ int security_get_classes(struct selinux_policy *policy,
 			 char ***classes, u32 *nclasses)
 {
 	struct policydb *policydb;
+	u32 i;
 	int rc;
 
 	policydb = &policy->policydb;
@@ -3313,16 +3316,29 @@ int security_get_classes(struct selinux_policy *policy,
 
 	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
 			 *classes);
-	if (rc) {
-		u32 i;
+	if (rc)
+		goto err;
 
-		for (i = 0; i < *nclasses; i++)
-			kfree((*classes)[i]);
-		kfree(*classes);
+	/*
+	 * The class symtab may be sparse, which policydb_class_isvalid() exists
+	 * to absorb; the callback fills this array by value, so an unclaimed
+	 * one leaves a NULL that sel_make_classes() hands to sel_make_dir().
+	 */
+	for (i = 0; i < *nclasses; i++) {
+		if (!(*classes)[i]) {
+			rc = -EINVAL;
+			goto err;
+		}
 	}
 
 out:
 	return rc;
+
+err:
+	for (i = 0; i < *nclasses; i++)
+		kfree((*classes)[i]);
+	kfree(*classes);
+	return rc;
 }
 
 static int get_permissions_callback(void *k, void *d, void *args)
diff --git a/sound/hda/codecs/realtek/alc662.c b/sound/hda/codecs/realtek/alc662.c
index 2cf3664a35ff..a640292c4f10 100644
--- a/sound/hda/codecs/realtek/alc662.c
+++ b/sound/hda/codecs/realtek/alc662.c
@@ -852,6 +852,7 @@ static const struct hda_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b35, 0x1234, "CZC ET26", ALC662_FIXUP_CZC_ET26),
 	SND_PCI_QUIRK(0x1b35, 0x2206, "CZC P10T", ALC662_FIXUP_CZC_P10T),
 	SND_PCI_QUIRK(0x1c6c, 0x1239, "Compaq N14JP6-V2", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x1e63, 0x6d9a, "F+ FLAPTOP r", ALC897_FIXUP_HP_HSMIC_VERB),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index 1702f26049d3..b0fa80705be7 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -25,9 +25,9 @@ static const struct reg_default cs35l41_reg[] = {
 	{ CS35L41_GPIO_PAD_CONTROL,		0x00000000 },
 	{ CS35L41_GLOBAL_CLK_CTRL,		0x00000003 },
 	{ CS35L41_TST_FS_MON0,			0x00020016 },
+	{ CS35L41_BSTCVRT_PEAK_CUR,		0x0000004A },
 	{ CS35L41_BSTCVRT_COEFF,		0x00002424 },
 	{ CS35L41_BSTCVRT_SLOPE_LBST,		0x00007500 },
-	{ CS35L41_BSTCVRT_PEAK_CUR,		0x0000004A },
 	{ CS35L41_SP_ENABLES,			0x00000000 },
 	{ CS35L41_SP_RATE_CTRL,			0x00000028 },
 	{ CS35L41_SP_FORMAT,			0x18180200 },
diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index d2ecc7b3f619..764dbaa35042 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -66,22 +66,6 @@ static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_ASPTX3_INPUT,			0x00000020 },
 	{ CS35L45_ASPTX4_INPUT,			0x00000028 },
 	{ CS35L45_ASPTX5_INPUT,			0x00000048 },
-	{ CS35L45_DSP1_RX1_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX2_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX3_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX4_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX5_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX6_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX7_RATE,		0x00000001 },
-	{ CS35L45_DSP1_RX8_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX1_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX2_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX3_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX4_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX5_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX6_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX7_RATE,		0x00000001 },
-	{ CS35L45_DSP1_TX8_RATE,		0x00000001 },
 	{ CS35L45_DSP1RX1_INPUT,		0x00000008 },
 	{ CS35L45_DSP1RX2_INPUT,		0x00000009 },
 	{ CS35L45_DSP1RX3_INPUT,		0x00000018 },
@@ -114,6 +98,22 @@ static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_GPIO1_CTRL1,			0x81000001 },
 	{ CS35L45_GPIO2_CTRL1,			0x81000001 },
 	{ CS35L45_GPIO3_CTRL1,			0x81000001 },
+	{ CS35L45_DSP1_RX1_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX2_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX3_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX4_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX5_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX6_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX7_RATE,		0x00000001 },
+	{ CS35L45_DSP1_RX8_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX1_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX2_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX3_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX4_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX5_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX6_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX7_RATE,		0x00000001 },
+	{ CS35L45_DSP1_TX8_RATE,		0x00000001 },
 };
 
 static bool cs35l45_readable_reg(struct device *dev, unsigned int reg)
diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 3f759c13d6d1..0bb1aa0c6cd0 100644
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
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index f7d168f557dd..0cbf50647ff5 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1075,7 +1075,7 @@ static int tx_macro_dec_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = tx->dec_mode[path];
+	ucontrol->value.enumerated.item[0] = tx->dec_mode[path];
 
 	return 0;
 }
@@ -1084,7 +1084,7 @@ static int tx_macro_dec_mode_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 5ad0448af649..af521e0988db 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2064,7 +2064,7 @@ static int wsa_macro_ear_spkr_pa_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wsa->ear_spkr_gain;
+	ucontrol->value.enumerated.item[0] = wsa->ear_spkr_gain;
 
 	return 0;
 }
@@ -2075,7 +2075,7 @@ static int wsa_macro_ear_spkr_pa_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	wsa->ear_spkr_gain =  ucontrol->value.integer.value[0];
+	wsa->ear_spkr_gain =  ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
@@ -2088,7 +2088,7 @@ static int wsa_macro_rx_mux_get(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] =
+	ucontrol->value.enumerated.item[0] =
 			wsa->rx_port_value[widget->shift];
 	return 0;
 }
@@ -2101,7 +2101,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 				snd_soc_dapm_to_component(widget->dapm);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_update *update = NULL;
-	u32 rx_port_value = ucontrol->value.integer.value[0];
+	u32 rx_port_value = ucontrol->value.enumerated.item[0];
 	u32 bit_input;
 	u32 aif_rst;
 	unsigned int dai_id;
diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 1c36c910f47a..74c4275ef29c 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -472,10 +472,15 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct tas2562_data *tas2562 = snd_soc_component_get_drvdata(component);
-	int ret;
+	int ret, index;
 	u32 reg_val;
 
-	reg_val = float_vol_db_lookup[ucontrol->value.integer.value[0]/2];
+	index = ucontrol->value.integer.value[0] / 2;
+	if (index < 0 || index >= ARRAY_SIZE(float_vol_db_lookup))
+		return -EINVAL;
+
+	reg_val = float_vol_db_lookup[index];
+
 	/*
 	 * The device applies the 32-bit coefficient to the playback path on
 	 * the write to DVC_CFG4 (the LSB, book 0 page 2 reg 0x0F), so the
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 775c3767bf3a..2ad7bb90cf54 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -1542,8 +1542,8 @@ static ssize_t acoustic_ctl_write(struct file *file,
 	if (src[0] > max_pkg_len && src[0] != count) {
 		dev_err(priv->dev, "pkg(%u), max(%u), count(%u) mismatch.\n",
 			src[0], max_pkg_len, (unsigned int)count);
-		ret = 0;
-		goto exit;
+		kfree(src);
+		return 0;
 	}
 
 	switch (src[1]) {
@@ -1557,14 +1557,14 @@ static ssize_t acoustic_ctl_write(struct file *file,
 		break;
 	default:
 		dev_err(priv->dev, "%s Wrong code %02x.\n", __func__, src[1]);
-		ret = 0;
-		goto exit;
+		kfree(src);
+		return 0;
 	}
 
 	if (len < 1) {
 		dev_err(priv->dev, "pkg fmt invalid %02x.\n", len);
-		ret = 0;
-		goto exit;
+		kfree(src);
+		return 0;
 	}
 
 	for (j = 0; j < priv->ndev; j++)
@@ -1574,8 +1574,8 @@ static ssize_t acoustic_ctl_write(struct file *file,
 		}
 	if (j >= priv->ndev) {
 		dev_err(priv->dev, "no such device 0x%02x.\n", src[2]);
-		ret = 0;
-		goto exit;
+		kfree(src);
+		return 0;
 	}
 
 	reg = TASDEVICE_REG(src[3], src[4], src[5]);
@@ -1606,7 +1606,7 @@ static ssize_t acoustic_ctl_write(struct file *file,
 		dev_err(priv->dev, "i2c communication error.\n");
 	else
 		ret = count;
-exit:
+
 	kfree(src);
 	return ret;
 }
diff --git a/sound/soc/intel/common/sof-function-topology-lib.c b/sound/soc/intel/common/sof-function-topology-lib.c
index 0daa7d83808b..a100351c101d 100644
--- a/sound/soc/intel/common/sof-function-topology-lib.c
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -30,7 +30,12 @@ enum tplg_device_id {
 int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_mach *mach,
 			   const char *prefix, const char ***tplg_files, bool best_effort)
 {
-	struct snd_soc_acpi_mach_params mach_params = mach->mach_params;
+	struct snd_soc_acpi_mach *card_mach = dev_get_platdata(card->dev);
+	/*
+	 * Use the acpi mach from the machine driver because the machine driver
+	 * may change the dmic_num based on the machine driver quirk.
+	 */
+	struct snd_soc_acpi_mach_params mach_params = card_mach->mach_params;
 	struct snd_soc_dai_link *dai_link;
 	const struct firmware *fw;
 	char platform[SOF_INTEL_PLATFORM_NAME_MAX];
diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index fc3ead77e5ea..5929ecf6642e 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -528,7 +528,19 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	ret = sof_ipc4_set_multi_pipeline_state(sdev, SOF_IPC4_PIPE_PAUSED, trigger_list);
 	if (ret < 0) {
 		spcm_err(spcm, substream->stream, "failed to pause all pipelines\n");
-		goto free;
+		/*
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
+		 * and we are going to see errors printed, but the state of the
+		 * widgets will be correct for the next boot.
+		 */
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
+			goto free;
+
+		ret = 0;
 	}
 
 	/* update PAUSED state for all pipelines just triggered */
@@ -560,14 +572,15 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 			 "failed to set final state %d for all pipelines\n",
 			 state);
 		/*
-		 * workaround: if the firmware is crashed while setting the
-		 * pipelines to reset state we must ignore the error code and
-		 * reset it to 0.
-		 * Since the firmware is crashed we will not send IPC messages
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
 		 * and we are going to see errors printed, but the state of the
 		 * widgets will be correct for the next boot.
 		 */
-		if (sdev->fw_state != SOF_FW_CRASHED || state != SOF_IPC4_PIPE_RESET)
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
 			goto free;
 
 		ret = 0;
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 76812d8fb567..64e65cd2d08c 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3151,6 +3151,15 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 		ipc_size = ipc4_copier->ipc_config_size;
 		ipc_data = ipc4_copier->ipc_config_data;
 
+		/*
+		 * Refresh copier_data in ipc_config_data for host copiers.
+		 * The node_id may have been updated by host_config after
+		 * ipc_prepare, e.g. when host stream tags change after a
+		 * suspend/resume cycle.
+		 */
+		if (swidget->id != snd_soc_dapm_buffer)
+			memcpy(ipc_data, &ipc4_copier->data, sizeof(ipc4_copier->data));
+
 		msg = &ipc4_copier->msg;
 		break;
 	}
@@ -3159,6 +3168,9 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct snd_sof_dai *dai = swidget->private;
 		struct sof_ipc4_copier *ipc4_copier = dai->private;
+		struct sof_ipc4_copier_data *copier_data;
+		u32 gtw_cfg_config_length;
+		u32 tlv_size;
 
 		pipeline = pipe_widget->private;
 		if (pipeline->use_chain_dma)
@@ -3167,6 +3179,27 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 		ipc_size = ipc4_copier->ipc_config_size;
 		ipc_data = ipc4_copier->ipc_config_data;
 
+		/*
+		 * Refresh copier_data and dma_config_tlv in ipc_config_data.
+		 * These may have been updated after ipc_prepare, e.g. when
+		 * link DMA stream tags change after a suspend/resume cycle.
+		 *
+		 * copier_data->gtw_cfg.config_length does not include the
+		 * TLV size (it was restored after sof_ipc4_prepare_copier_module),
+		 * so temporarily inflate it to match the ipc_config_data layout.
+		 */
+		copier_data = &ipc4_copier->data;
+		gtw_cfg_config_length = copier_data->gtw_cfg.config_length * 4;
+		tlv_size = ipc_size - sizeof(*copier_data) - gtw_cfg_config_length;
+
+		copier_data->gtw_cfg.config_length += tlv_size / 4;
+		memcpy(ipc_data, copier_data, sizeof(*copier_data));
+		copier_data->gtw_cfg.config_length = gtw_cfg_config_length / 4;
+
+		if (tlv_size)
+			memcpy(ipc_data + sizeof(*copier_data) + gtw_cfg_config_length,
+			       &ipc4_copier->dma_config_tlv, tlv_size);
+
 		msg = &ipc4_copier->msg;
 		break;
 	}
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index acf56607bc9c..24614e506019 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -146,7 +146,6 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
 	struct snd_sof_pipeline *spipe = swidget->spipe;
-	bool use_count_decremented = false;
 	int ret;
 	int i;
 
@@ -225,9 +224,10 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 	return 0;
 
 widget_free:
-	/* widget use_count will be decremented by sof_widget_free() */
+	/* widget use_count and core_put handled by sof_widget_free() */
 	sof_widget_free_unlocked(sdev, swidget);
-	use_count_decremented = true;
+	return ret;
+
 pipe_widget_free:
 	if (swidget->id != snd_soc_dapm_scheduler) {
 		sof_widget_free_unlocked(sdev, swidget->spipe->pipe_widget);
@@ -242,8 +242,7 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 		}
 	}
 use_count_dec:
-	if (!use_count_decremented)
-		swidget->use_count--;
+	swidget->use_count--;
 
 	return ret;
 }
diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index 8f7a76758535..f15336197ed3 100644
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
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 354866a80605..0c702a4d51df 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2356,6 +2356,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1038, 0x1294, /* SteelSeries Arctis Pro Wireless */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+	DEVICE_FLG(0x1038, 0x2232, /* SteelSeries Arctis Nova 5 */
+		   QUIRK_FLAG_MIXER_GET_CUR_BROKEN),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x12d1, 0x3a07, /* HUAWEI USB-C HEADSET */
diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
index f2048c244526..19430bd5864c 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -12,9 +12,32 @@ echo 0 > events/enable
 echo > dynamic_events
 
 REALBIN=`readlink -f /bin/sh`
-ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
 
-echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
+# Get the entry point virtual address from ELF header
+ENTRY=`readelf -hW ${REALBIN} | grep "Entry point" | awk '{print $NF}'`
+
+# Convert virtual address to file offset: find the LOAD segment containing
+# the entry point, then compute file_offset = e_entry - p_vaddr + p_offset.
+# For PIE binaries this is a no-op (vaddr == file offset), but for non-PIE
+# executables the virtual address is much larger than the file size and
+# must be converted, otherwise uprobe_register() rejects it with -EINVAL.
+ENTRY_DEC=$(printf '%d' "$ENTRY")
+OFFSET=$ENTRY
+while IFS= read -r line; do
+    set -- $line
+    [ "$1" = "LOAD" ] || continue
+    VA_DEC=$(printf '%d' "$3")
+    OFF_DEC=$(printf '%d' "$2")
+    FSZ_DEC=$(printf '%d' "$5")
+    if [ "$ENTRY_DEC" -ge "$VA_DEC" ] && [ "$ENTRY_DEC" -lt "$((VA_DEC + FSZ_DEC))" ]; then
+        OFFSET=$(printf '0x%x' "$((ENTRY_DEC - VA_DEC + OFF_DEC))")
+        break
+    fi
+done << EOF
+$(readelf -lW ${REALBIN} | grep LOAD)
+EOF
+
+echo "p:myevent ${REALBIN}:${OFFSET}" >> uprobe_events
 
 grep -q myevent uprobe_events
 test -d events/uprobes/myevent
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4b3f71e66609..352772153ebb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -566,7 +566,7 @@ check_transfer()
 		mv "$tmpfile" "$out"
 		tmpfile=""
 	fi
-	cmp -l "$in" "$out" | while read -r i a b; do
+	while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			fail_test "$what does not match (in, out):"
@@ -577,7 +577,7 @@ check_transfer()
 		else
 			print_info "$what has inverted byte at ${i}"
 		fi
-	done
+	done < <(cmp -l "$in" "$out")
 
 	return 0
 }
