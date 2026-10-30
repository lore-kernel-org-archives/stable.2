Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357489;
	b=Njtq/+QOsjbgFI6+E84hc0GG1MXtoP8JP6HbdaPGq8BRsFUaxFdWV/RB7edWDzObumjV
	 KJKLZtJYpk8Vytntsyk+Rp3EaW4fOP9GY880Nu8TXl0d40HTK3xSO3c5/LNz6aU0Kszis
	 2KRPFt15KCh0FqqvdTnxV123I3wV6H+VFuykcLCcxVKdmZekgzu61nmJ7OuE8BhuymICl
	 Xnvwk10FqsOQp0gTvB99LXmLQoZNQRh6Fcwzswpk6mE9l6e0V7xc+yuc8sDoORHzqpEiP
	 6Um3x4IO2ZTSeo78MBCxuGV9k7YTQuVgiIkE6wCgIbSDij/kdt4gaDgwEkDZjS9+SYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jkfuOKxXS+BlqNqolHs8RWJ+BPSZy5raixNz8ZoqJJU=;
	b=VC3YqUA/gnGktjLZwS6yqEiXc5rkXC0K/zxhgPuFwv8KFLuvlI33DyPJELdKltQ+foEd
	 NfURFbVk0xnKOoEGTU65/Je2pqwxmQ3rsrVfnYSPgaYxlHW8miqqQtrudjsMuQ1pztmZO
	 DTAgIG/ixCWaDWIoj5AFu4dobu1UWhTMvtVlZXKEARa3S3SyUiCFGAyi7G5Ga8q5gpGyu
	 +yTUpCNydb5dgL9bmI/zFAPUCxyyd65kYBiJyeu9l658rgp1BHZmqwM1sOSWACAgh+ZqC
	 9wnZjLB1BiTbiZv9h5IQ483Ed5Hqky4eDhW6KCC01ZKVeENHvpT6VlMfX9gu4KmUrhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNeup1EP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAA606A337;
	Fri, 30 Oct 2026 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XNeup1EP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E41F000C1;
	Fri, 30 Oct 2026 10:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357488;
	bh=jkfuOKxXS+BlqNqolHs8RWJ+BPSZy5raixNz8ZoqJJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNeup1EPnFn6Wo4XuRDs3Y9KCR3BdgdTDuA1QiACwm9qOTkXt1VNjiUpLZZC8UBrD
	 KJ0TAqcIyzK0j5iOQNDaJLvNhkyNSkMsc82WA2XVkTOXG/vH4xv/NeqWQYWwpswxwI
	 +oxiz24wjXhOGfYBGX3An+nd+WvslBLCHLR+fdV4iPN3PKT2vzEgxhflKudfFQu7qx
	 S8djJFsv/xBGlCXuK4xSsYpPQV/2RLCbhgG1zb1iqAVCmdrQS10CuCtZJsa6SSmlv0
	 j2ZttSrXvIuTVBDMCvichBboYBrQJHUOaM52nQQ/PPz2A2CTHtAhUirh0FbAYwEkLz
	 MgnJrFh1E54Nw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/21] soundwire: qcom: Serialise ctrl->intr_mask updates
Date: Fri, 30 Oct 2026 10:46:49 +0000
Message-ID: <20261030104840.3361217-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qcom_swrm_irq_handler(), swrm_runtime_suspend(), and
swrm_runtime_resume() concurrently read, modify, and write
ctrl->intr_mask and program the interrupt enable registers without
synchronisation.  Overlapping read-modify-write updates can clobber
interrupt mask bits and leave the hardware interrupt mask out of sync.

Add ctrl->intr_lock to serialise accesses to ctrl->intr_mask and its
associated interrupt mask register updates.

Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
Closes: https://sashiko.dev/#/bug/linux-ea523727-6467-42aa-850f-8f838e4b84a8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/qcom.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 555045b32a25..cfa3466ff8e1 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -202,6 +202,8 @@ struct qcom_swrm_ctrl {
 	struct completion enumeration;
 	/* Port alloc/free lock */
 	struct mutex port_lock;
+	/* Interrupt mask and broadcast completion lock */
+	struct mutex intr_lock;
 	struct clk *hclk;
 	int irq;
 	u32 ee;
@@ -784,7 +786,9 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 
 	ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
 		       &intr_sts);
+	mutex_lock(&ctrl->intr_lock);
 	intr_sts_masked = intr_sts & ctrl->intr_mask;
+	mutex_unlock(&ctrl->intr_lock);
 
 	do {
 		for (i = 0; i < SWRM_INTERRUPT_MAX; i++) {
@@ -820,10 +824,12 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 				dev_err_ratelimited(ctrl->dev,
 						"%s: SWR bus clsh detected\n",
 						__func__);
+				mutex_lock(&ctrl->intr_lock);
 				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
 				ctrl->reg_write(ctrl,
 						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 						ctrl->intr_mask);
+				mutex_unlock(&ctrl->intr_lock);
 				break;
 			case SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW:
 				ctrl->reg_read(ctrl,
@@ -863,20 +869,24 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 				dev_err_ratelimited(ctrl->dev,
 						"%s: SWR Port collision detected\n",
 						__func__);
+				mutex_lock(&ctrl->intr_lock);
 				ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION;
 				ctrl->reg_write(ctrl,
 						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 						ctrl->intr_mask);
+				mutex_unlock(&ctrl->intr_lock);
 				break;
 			case SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH:
 				dev_err_ratelimited(ctrl->dev,
 					"%s: SWR read enable valid mismatch\n",
 					__func__);
+				mutex_lock(&ctrl->intr_lock);
 				ctrl->intr_mask &=
 					~SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH;
 				ctrl->reg_write(ctrl,
 						ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 						ctrl->intr_mask);
+				mutex_unlock(&ctrl->intr_lock);
 				break;
 			case SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED:
 				complete(&ctrl->broadcast);
@@ -910,7 +920,9 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
 				intr_sts);
 		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_STATUS],
 			       &intr_sts);
+		mutex_lock(&ctrl->intr_lock);
 		intr_sts_masked = intr_sts & ctrl->intr_mask;
+		mutex_unlock(&ctrl->intr_lock);
 	} while (intr_sts_masked);
 
 	clk_disable_unprepare(ctrl->hclk);
@@ -952,11 +964,13 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	/* Enable Auto enumeration */
 	ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 1);
 
+	mutex_lock(&ctrl->intr_lock);
 	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
 	/* Mask soundwire interrupts */
 	if (ctrl->version < SWRM_VERSION_2_0_0)
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
-				SWRM_INTERRUPT_STATUS_RMSK);
+				ctrl->intr_mask);
+	mutex_unlock(&ctrl->intr_lock);
 
 	/* Configure No pings */
 	ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR, &val);
@@ -997,8 +1011,10 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 			0xFFFFFFFF);
 
 	/* enable CPU IRQs for the selected EE window */
+	mutex_lock(&ctrl->intr_lock);
 	ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
-			SWRM_INTERRUPT_STATUS_RMSK);
+			ctrl->intr_mask);
+	mutex_unlock(&ctrl->intr_lock);
 
 	/* Set IRQ to PULSE */
 	ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
@@ -1689,6 +1705,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->dev = dev;
 	dev_set_drvdata(&pdev->dev, ctrl);
 	mutex_init(&ctrl->port_lock);
+	mutex_init(&ctrl->intr_lock);
 	init_completion(&ctrl->broadcast);
 	init_completion(&ctrl->enumeration);
 
@@ -1854,6 +1871,7 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CLEAR],
 			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
 
+		mutex_lock(&ctrl->intr_lock);
 		ctrl->intr_mask |= SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
 		if (ctrl->version < SWRM_VERSION_2_0_0)
 			ctrl->reg_write(ctrl,
@@ -1861,6 +1879,7 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 					ctrl->intr_mask);
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 				ctrl->intr_mask);
+		mutex_unlock(&ctrl->intr_lock);
 
 		usleep_range(100, 105);
 		if (!swrm_wait_for_frame_gen_enabled(ctrl))
@@ -1882,6 +1901,7 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 	swrm_wait_for_wr_fifo_done(ctrl);
 	if (!ctrl->clock_stop_not_supported) {
 		/* Mask bus clash interrupt */
+		mutex_lock(&ctrl->intr_lock);
 		ctrl->intr_mask &= ~SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET;
 		if (ctrl->version < SWRM_VERSION_2_0_0)
 			ctrl->reg_write(ctrl,
@@ -1889,6 +1909,7 @@ static int __maybe_unused swrm_runtime_suspend(struct device *dev)
 					ctrl->intr_mask);
 		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
 				ctrl->intr_mask);
+		mutex_unlock(&ctrl->intr_lock);
 		/* Prepare slaves for clock stop */
 		ret = sdw_bus_prep_clk_stop(&ctrl->bus);
 		if (ret < 0 && ret != -ENODATA) {
-- 
2.56.0.317.g454f8302e1-goog

