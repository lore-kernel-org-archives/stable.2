Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87B4C227E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574898; cv=none; b=BYmsNyXIY8vZFBZ0v/2jfL5cTY52fFGBcm3fiZP9692x7YyG6z4frfMBVxKNDuQjxzVb1bNEMh5+whS2NcbWjeoT9coq2jZ7fnMDDBRQ9FEyH+b6A84ho7KB4AvtyZgqIcl48gn1l0bVnP4s1xwtCiEc9HRwvDatRXTb7xV4WhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574898; c=relaxed/simple;
	bh=Cj5qseGLroUQN4D95ih5KZjwb9d3GrqTbz7LFKzBHS0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YX2X0AQJ4CN5h2Rkjvcj5rn11g3FHY9K7YnS9V1LoyDM5YO6W8GzTweh/uvWIHgULSNiSpbzIb/gtC6SjLxjLzWtjp+WBseYD7NY2EI8TMSWdCaEWUdTmnQPb4+ngQuusvLnuKi3Ul1c8ymGNiefW/azwEokLk8ByHJQzezNFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVR9ZnMO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVR9ZnMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620221F00893;
	Wed, 16 Sep 2026 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574894;
	bh=gEK06Ncs/QSyWkmFJ650RuMZ2JHqkmuZMePsKCu9IPU=;
	h=Subject:To:Cc:From:Date;
	b=XVR9ZnMOt91D1Rq2zGfQA/ohXijGcUjxz/kKYXl0t4iyFDsghzu1CJD8trp0dUfza
	 lVzWSW1n03wJzwE0BrQ+9d3vPv2uDt9rKQqqEoovoxe6Wv3GYNoMDH6Gex21JAkQux
	 57n3mPxLEwmz63oEMN+j9/joKhP4LUQ6xBGQZAlI=
Subject: FAILED: patch "[PATCH] perf: RISC-V: store available counter mask as bitmap" failed to apply to 6.1-stable tree
To: liuxixin@kylinos.cn,pjw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:51:20 +0100
Message-ID: <2026091620-unmoral-superjet-8878@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6809da6e9c08ccc9a09cb0a48c61471679274aaa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091620-unmoral-superjet-8878@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6809da6e9c08ccc9a09cb0a48c61471679274aaa Mon Sep 17 00:00:00 2001
From: Xixin Liu <liuxixin@kylinos.cn>
Date: Tue, 18 Aug 2026 17:10:00 +0800
Subject: [PATCH] perf: RISC-V: store available counter mask as bitmap

The available-counter mask was a single unsigned long, but iteration
uses RISCV_MAX_COUNTERS, which is 64. On RV32 that reads past the object.
Filling with an unsigned-long bit at index 32 and above is also wrong.

Use DECLARE_BITMAP and set_bit/bitmap helpers. Walk each bitmap word
into CFG_MATCH when checking events, when allocating an index, and when
stopping all counters. Set the counter base to i times BITS_PER_LONG.
Share the CFG_MATCH ecall through a small helper so the 32-bit argument
split is not duplicated. On qemu-system-riscv32 the probe bitmap has bits
above XLEN set, so the first word alone is not enough.

Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI PMU extension")
Assisted-by: DeepSeek:deepseek-v3
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
Link: https://patch.msgid.link/prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn
Cc: stable@kernel.org
[pjw@kernel.org: updated to apply; fixed checkpatch.pl issues]
Signed-off-by: Paul Walmsley <pjw@kernel.org>

diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 4d6461d6a74f..1b8e4789cb3c 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -110,8 +110,9 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 {
 	pr_info("Legacy PMU implementation is available\n");
 
-	pmu->cmask = BIT(RISCV_PMU_LEGACY_CYCLE) |
-		BIT(RISCV_PMU_LEGACY_INSTRET);
+	bitmap_zero(pmu->cmask, RISCV_MAX_COUNTERS);
+	set_bit(RISCV_PMU_LEGACY_CYCLE, pmu->cmask);
+	set_bit(RISCV_PMU_LEGACY_INSTRET, pmu->cmask);
 	pmu->ctr_start = pmu_legacy_ctr_start;
 	pmu->ctr_stop = NULL;
 	pmu->event_map = pmu_legacy_event_map;
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 8ea5ae617347..2c50a6ba2a80 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -97,7 +97,7 @@ static unsigned int riscv_pmu_irq_mask;
 static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
-static unsigned long cmask;
+static DECLARE_BITMAP(cmask, RISCV_MAX_COUNTERS);
 
 static int pmu_event_find_cache(u64 config);
 struct sbi_pmu_event_data {
@@ -359,16 +359,38 @@ static int pmu_sbi_check_event_info(void)
 	return result;
 }
 
+static struct sbiret pmu_sbi_ctr_cfg_match(unsigned long cbase,
+					   unsigned long ctr_mask,
+					   unsigned long cflags,
+					   unsigned long event_idx,
+					   u64 config)
+{
+#if defined(CONFIG_32BIT)
+	return sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
+			 ctr_mask, cflags, event_idx, config, config >> 32);
+#else
+	return sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
+			 ctr_mask, cflags, event_idx, config, 0);
+#endif
+}
+
 static void pmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 {
-	struct sbiret ret;
+	struct sbiret ret = { .error = SBI_ERR_NOT_SUPPORTED };
+	int i;
 
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH,
-			0, cmask, 0, edata->event_idx, 0, 0);
-	if (!ret.error) {
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
-	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		if (!cmask[i])
+			continue;
+		ret = pmu_sbi_ctr_cfg_match(i * BITS_PER_LONG, cmask[i], 0,
+					    edata->event_idx, 0);
+		if (!ret.error) {
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+				  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+			return;
+		}
+	}
+	if (ret.error == SBI_ERR_NOT_SUPPORTED) {
 		/* This event cannot be monitored by any counter */
 		edata->event_idx = -ENOENT;
 	}
@@ -488,10 +510,10 @@ int riscv_pmu_get_hpm_info(u32 *hw_ctr_width, u32 *num_hw_ctr)
 	union sbi_pmu_ctr_info *info;
 	u32 hpm_width = 0, hpm_count = 0;
 
-	if (!cmask)
+	if (bitmap_empty(cmask, RISCV_MAX_COUNTERS))
 		return -EINVAL;
 
-	for_each_set_bit(i, &cmask, RISCV_MAX_COUNTERS) {
+	for_each_set_bit(i, cmask, RISCV_MAX_COUNTERS) {
 		info = &pmu_ctr_list[i];
 		if (!info)
 			continue;
@@ -540,8 +562,8 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(rvpmu->hw_events);
 	struct sbiret ret;
-	int idx;
-	uint64_t cbase = 0, cmask = rvpmu->cmask;
+	int idx, i;
+	u64 cbase = 0, cmask = 0;
 	unsigned long cflags = 0;
 
 	cflags = pmu_sbi_get_filter_flags(event);
@@ -562,14 +584,21 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	}
 
 	/* retrieve the available counter index */
-#if defined(CONFIG_32BIT)
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			cmask, cflags, hwc->event_base, hwc->config,
-			hwc->config >> 32);
-#else
-	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_CFG_MATCH, cbase,
-			cmask, cflags, hwc->event_base, hwc->config, 0);
-#endif
+	if (cmask) {
+		ret = pmu_sbi_ctr_cfg_match(cbase, cmask, cflags, hwc->event_base,
+					    hwc->config);
+	} else {
+		ret.error = SBI_ERR_NOT_SUPPORTED;
+		for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+			if (!rvpmu->cmask[i])
+				continue;
+			cbase = i * BITS_PER_LONG;
+			ret = pmu_sbi_ctr_cfg_match(cbase, rvpmu->cmask[i], cflags,
+						    hwc->event_base, hwc->config);
+			if (!ret.error)
+				break;
+		}
+	}
 	if (ret.error) {
 		pr_debug("Not able to find a counter for event %lx config %llx\n",
 			hwc->event_base, hwc->config);
@@ -577,7 +606,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	}
 
 	idx = ret.value;
-	if (!test_bit(idx, &rvpmu->cmask) || !pmu_ctr_list[idx].value)
+	if (!test_bit(idx, rvpmu->cmask) || !pmu_ctr_list[idx].value)
 		return -ENOENT;
 
 	/* Additional sanity check for the counter id */
@@ -881,7 +910,7 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
 			/* The logical counter ids are not expected to be contiguous */
 			continue;
 
-		*mask |= BIT(i);
+		set_bit(i, mask);
 
 		cinfo.value = ret.value;
 		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
@@ -898,12 +927,19 @@ static int pmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
 
 static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 {
+	int i;
+
 	/*
 	 * No need to check the error because we are disabling all the counters
 	 * which may include counters that are not enabled yet.
 	 */
-	sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
-		  0, pmu->cmask, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
+		if (!pmu->cmask[i])
+			continue;
+		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP,
+			  i * BITS_PER_LONG, pmu->cmask[i],
+			  SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
+	}
 }
 
 static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
@@ -1451,7 +1487,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	}
 
 	/* cache all the information about counters now */
-	if (pmu_sbi_get_ctrinfo(num_counters, &cmask))
+	if (pmu_sbi_get_ctrinfo(num_counters, cmask))
 		goto out_free;
 
 	ret = pmu_sbi_setup_irqs(pmu, pdev);
@@ -1464,7 +1500,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 
 	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->pmu.parent = &pdev->dev;
-	pmu->cmask = cmask;
+	bitmap_copy(pmu->cmask, cmask, RISCV_MAX_COUNTERS);
 	pmu->ctr_start = pmu_sbi_ctr_start;
 	pmu->ctr_stop = pmu_sbi_ctr_stop;
 	pmu->event_map = pmu_sbi_event_map;
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index f82a28040594..ecaa40370830 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -55,7 +55,7 @@ struct riscv_pmu {
 
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 
-	unsigned long	cmask;
+	DECLARE_BITMAP(cmask, RISCV_MAX_COUNTERS);
 	u64		(*ctr_read)(struct perf_event *event);
 	int		(*ctr_get_idx)(struct perf_event *event);
 	int		(*ctr_get_width)(int idx);

