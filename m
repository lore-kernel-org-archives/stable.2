Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357547;
	b=PsiJ4NPq3DQK9e1eODfBqheYcY5v/Vj1+XwJF0WfIHbmfstgwpXVkkvh7N5kKHD2Fzgp
	 ClO3CI1JXqsOn901AgbpZBYN0hlrtLMEaRixMzjRZV9ZJta3OMgp8Rqet6FLy1Wf6lq26
	 LobuevMWAv+teyuVWTz0h6uHVSTd7E+HZt6ozeiD+z7OG2Nrqskbr1tw+QJeT66ujqomt
	 RLKSEpNPbKAFMgd9KRcyPLE/S9ZBObpUwvK9ATlT1xN0kqYyHJUL9UnXsF076D8TDqJso
	 YuYYBdEn2qTfkrzWFwQH4NE9rzHYQgz8z2zZWeEIrGjrtHtRws3FoU7OIN4UNing/OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gmGnnW2R06cvwkr5wUCfO3clTMmGy5/WqCnUR/F4Akw=;
	b=fgeLVzxfWkRzXAlGJ8w3GLMVqUr+aEpx7MXkE1gjxQRYROQnuloXhDIds6PUBDF5heQC
	 RC4m3R9Z7C9G0MjU/Q/nofSbw5AfgYvVavP/xBR/TqEWMZQHhk3e+PqAtyCyOpk7X+JuA
	 NmrbNYB1H23mG11gdWvxWN0I4WLxms2zvj81B6mWmM38FkJxQ3wBxEwKXfA01sllLdWkG
	 ngOIlsJRxcxpkrXvkbYMyIJj2O3x4l0qO8zngLuV4qkqbNEgHfz55zmzcMAAdC7OVMuA8
	 jPmITsqkkktDFPzDrDvxVjm7JoBt2jDuXxhnaRISHkR2RI+n8YdADzEU3FVpOviTqsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnjB38e5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC960A2616;
	Fri, 30 Oct 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DnjB38e5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4EC1F000C1;
	Fri, 30 Oct 2026 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357546;
	bh=gmGnnW2R06cvwkr5wUCfO3clTMmGy5/WqCnUR/F4Akw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DnjB38e51W2hEsEG9GfsfXx6Jpy1edHmYWhlfhZ0fgBhHKSpuzHRUd+d85+nim92m
	 dEX2HtQPf0j2w5Uv52uGxAEhS0PPs6xD5z/JfAz+DzgUsbRwSMLbh9rAcTSPBXcqwc
	 YCecO23TKHG1mgL0iHtOkQKt9re206APc9EglhlXRTbq1xtBYv+kFOVXiBJnk4G34h
	 SrKAKOlPY7K7ix/H/4YjnpAB7ssJY1ygNGyejjhS4AlM0HmMBVm1GlxtHWbd0FDRuB
	 EGPc8DZcPpki/5ISkjywPm/BbJNXKlAzGjM6Hp8g8Hm81s+RQFJYm3i1dkXN6mKSRC
	 /M7MXnxgY5NMA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mastan Katragadda <Mastan.Katragadda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 19/21] soundwire: amd: Cancel pending work before suspending manager
Date: Fri, 30 Oct 2026 10:46:58 +0000
Message-ID: <20261030104840.3361217-20-lee@kernel.org>
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

amd_suspend_runtime() stops the SoundWire bus clock and transitions the
controller into D3 without cancelling amd_sdw_irq_thread and
amd_sdw_work, and amd_suspend() only cancels amd_sdw_work without first
cancelling amd_sdw_irq_thread.  Queued work executing concurrently with
suspend can access MMIO registers after the controller is clock-stopped
or powered down.

Mask manager interrupts, synchronise the parent PCI IRQ, and cancel both
amd_sdw_irq_thread and amd_sdw_work before stopping the bus clock and in
amd_deinit_sdw_manager(), unmask wake interrupts only after clock stop
completes, and avoid non-wake register accesses in amd_sdw_irq_thread()
while the clock is stopped.

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Closes: https://sashiko.dev/#/bug/linux-3b774ace-00cf-41e6-82eb-85cd43f5e1d6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 40 ++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index f39f4f04db7e..ba8e6d42c467 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -148,9 +148,24 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
+static void amd_sdw_quiesce_work(struct amd_sdw_manager *amd_manager)
+{
+	struct device *parent = amd_manager->dev->parent;
+
+	disable_work_sync(&amd_manager->amd_sdw_work);
+	writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+	writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
+	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+	if (parent && dev_is_pci(parent))
+		synchronize_irq(to_pci_dev(parent)->irq);
+	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+	enable_work(&amd_manager->amd_sdw_work);
+}
+
 static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	amd_disable_sdw_interrupts(amd_manager);
+	amd_sdw_quiesce_work(amd_manager);
 	return amd_disable_sdw_manager(amd_manager);
 }
 
@@ -1049,6 +1064,14 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 	u32 status_change_8to11;
 	u32 status_change_0to7;
 
+	if (amd_manager->clk_stopped) {
+		status_change_8to11 = readl(amd_manager->mmio +
+					    ACP_SW_STATE_CHANGE_STATUS_8TO11);
+		if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
+			amd_sdw_process_wake_event(amd_manager);
+		return;
+	}
+
 	status_change_8to11 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
 	status_change_0to7 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
 	if (!status_change_0to7 && !status_change_8to11)
@@ -1341,24 +1364,24 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, false);
 			if (ret)
 				return ret;
 		}
+		amd_sdw_quiesce_work(amd_manager);
+		amd_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, false);
 			if (ret)
 				return ret;
 		}
+		amd_sdw_quiesce_work(amd_manager);
+		amd_sdw_wake_enable(amd_manager, false);
 		/*
 		 * As per hardware programming sequence on AMD platforms,
 		 * clock stop should be invoked first before powering-off
@@ -1391,25 +1414,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_sdw_wake_enable(amd_manager, true);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, true);
 			if (ret)
 				return ret;
 		}
+		amd_sdw_quiesce_work(amd_manager);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
+		if (amd_manager->clk_stopped)
+			amd_sdw_wake_enable(amd_manager, true);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_sdw_wake_enable(amd_manager, true);
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
 			ret = amd_sdw_host_wake_enable(amd_manager, true);
 			if (ret)
 				return ret;
 		}
+		amd_sdw_quiesce_work(amd_manager);
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
+		if (amd_manager->clk_stopped)
+			amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_deinit_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
@@ -1452,6 +1479,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			if (ret)
 				return ret;
 		}
+		amd_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
 		writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
 		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
-- 
2.56.0.317.g454f8302e1-goog

