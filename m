Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049258;
	b=AsuWMVJ3Wkp21P1okLRj4g1NC1SBVhvfv7PVR+qSozc93v5ofGVIVKO8sOQe1Slam0Do
	 bdUgXkFyt41OUQN7EErNcBUiq2ScMRzDsehYd8m8J62R6xVFecPkx/Vaulm0B/488ihME
	 tUMgDdiidLHFAT9i2sjH949ksuCLSiN6V54XU9llJMofP7mecFH1WYpfLAys6ftVgDv4W
	 UlPJEX8WHvSBddDLrMcIix7Fk8Vtj/LgJXZ6VSvwuGyPWFxTFryaX+UXvVn+OVVnFIWOX
	 QnPG6hqfcER9hsPDzxsyZ7TwGg/d80UpnwZzuD24alN4b+imJgJNnLC6Idni6LK1u6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049258;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Eo2WwYRD+kM68hS5YPsaeelgyOnk9FHYXVttRCYrBeA=;
	b=yzpieU9Y++EwTtf1VDduAhr2YAlDQZdTAm/QNI8vtYyPPzYDya+f80JIs1IlVgMRwWxr
	 gn0iUpzEwOU3ssL+EwWtmZAnjJi9CCnrTxIwchUiJD3R/aHr2sF2eGuKRdkRHN1J8BR05
	 90Ojb9ivMB58UVT+eab+EqNYGJs4pNuSjmA5Njc3l9TglcG0AMujSPpOiJKvSyAyzI3Yb
	 fFNDPiisv+AGm4VuShlz9KDU73YXcRMW4b0tmmp5OtxHkWbZ3Mred4fW/IFbZLmzOWeqg
	 mFr4lED9NbWmyRZSqrUA4r3ucJu1PNLZbY8p88EG+Yrp/bhmb+LcoS9MPhAi0UbhTtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBJqa9EZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F65606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBJqa9EZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C4C1F0089F;
	Sat,  7 Nov 2026 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049258;
	bh=Eo2WwYRD+kM68hS5YPsaeelgyOnk9FHYXVttRCYrBeA=;
	h=From:To:Cc:Subject:Date;
	b=YBJqa9EZ31U27flZtEdKxOn/bGARssVa73iDmv7yONYuECWCc5a8TzbD1Ru53ODDm
	 tSaK1swH03SXsNzMofTuXD1apPPnzdC342YgOFqNtN23V4/oTduUbeknizZ7OCXOlc
	 0GZsOXd2r+46D6VWCgEZmwAJPChBzWWbrVvjOmmJf6Qs98Wjm7y5Gq267BqOeOEF0D
	 oMLT2MwGT9nvgs0IMlw3r1hlOofqijprVO6/Dmw1nlyYOx9Bhyuk5W4B7JCTP5wEgm
	 OUwMBPwKLWOA0kZmx1e5kREyBH4nhFiZAvJ1MdB2O83o/Gf3YDTIcPVngHK+Rora2f
	 /0VC9XXHkpn5g==
From: Sasha Levin <sashal@kernel.org>
To: busanna.reddy@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: venus: Fix iova allocation from restrict region" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:56 -0500
Message-ID: <20261107060056-failed-5.15-953439251b59@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 953439251b596cee039fbfeaffeb1d88a4b40f43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060056-failed-5.15-953439251b59@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 953439251b596cee039fbfeaffeb1d88a4b40f43 Mon Sep 17 00:00:00 2001
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 20:43:23 +0530
Subject: [PATCH] media: venus: Fix iova allocation from restrict region

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
cannot address the low 600MB of IOVA space, while the pixel stream can
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+

A single "iommus" property on the video-codec node puts every stream
in one IOMMU domain sharing one IOVA space, so nothing stops a
non-pixel buffer from landing below 600MB. Once an allocation lands
below that boundary the hardware faults, which shows up as unhandled
SMMU page faults and spontaneous reboots.
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Fix this by reserving the 0-600MB range, below the boundary the
non-pixel stream cannot address, using dma_iova_try_alloc() so the
IOMMU-DMA core never hands that range out to a real DMA mapping. This
reserves only IOVA space, it does not allocate any physical memory.

Since sub-nodes for non-pixel, pixel, and secure streams do not exist
yet and only a single device is available, the restriction is applied
to both non-pixel and pixel stream IDs.

Fixes: af2c3834c8ca ("[media] media: venus: adding core part and helper functions")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
[bod: took iova_state description from iris and applied to venus in core.h]
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
---
 drivers/media/platform/qcom/venus/core.c | 66 ++++++++++++++++++++++--
 drivers/media/platform/qcom/venus/core.h |  6 +++
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 243e342b0ae75..2a0ab553c4519 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -377,6 +377,57 @@ static int venus_add_dynamic_nodes(struct venus_core *core)
 static void venus_remove_dynamic_nodes(struct venus_core *core) {}
 #endif
 
+static void venus_unreserve_iova_region(struct device *dev, struct dma_iova_state *state)
+{
+	unsigned int i;
+
+	for (i = 0; dma_iova_size(&state[i]); i++)
+		dma_iova_free(dev, &state[i]);
+}
+
+static int venus_reserve_iova_region(struct device *dev, struct dma_iova_state **iova_state,
+				     unsigned long start, unsigned long size)
+{
+	unsigned long dma_limit = dev->bus_dma_limit;
+	unsigned long end, rem, chunk;
+	struct dma_iova_state *state;
+	unsigned int count = 0;
+	int ret = -ENOMEM;
+
+	state = devm_kcalloc(dev, BITS_PER_TYPE(dma_addr_t) + 1, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return ret;
+
+	end = start + size;
+	rem = end - max(start, PAGE_SIZE);
+	dev->bus_dma_limit = end - 1;
+
+	while (rem) {
+		chunk = min(end & -end, (u64)1 << (fls64(rem) - 1));
+
+		if (!dma_iova_try_alloc(dev, &state[count], 0, chunk))
+			goto err_free_iova;
+
+		if (state[count].addr != end - chunk || state[count].__size != chunk)
+			goto err_free_iova;
+
+		rem -= chunk;
+		end -= chunk;
+		count++;
+	}
+
+	*iova_state = state;
+	dev->bus_dma_limit = dma_limit;
+
+	return 0;
+
+err_free_iova:
+	venus_unreserve_iova_region(dev, state);
+	dev->bus_dma_limit = dma_limit;
+
+	return ret;
+}
+
 static int venus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -421,10 +472,15 @@ static int venus_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	ret = venus_reserve_iova_region(dev, &core->iova_state, VENUS_NP_RESERVE_IOVA_START,
+					VENUS_NP_RESERVE_IOVA_SIZE);
 	if (ret)
 		goto err_core_put;
 
+	ret = dma_set_mask_and_coherent(dev, core->res->dma_mask);
+	if (ret)
+		goto err_unresv_iova_region;
+
 	dma_set_max_seg_size(dev, UINT_MAX);
 
 	INIT_LIST_HEAD(&core->instances);
@@ -434,13 +490,13 @@ static int venus_probe(struct platform_device *pdev)
 
 	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
-		goto err_core_put;
+		goto err_unresv_iova_region;
 
 	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
 					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 					"venus", core);
 	if (ret)
-		goto err_core_put;
+		goto err_unresv_iova_region;
 
 	venus_assign_register_offsets(core);
 
@@ -525,6 +581,8 @@ static int venus_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&core->v4l2_dev);
 err_hfi_destroy:
 	hfi_destroy(core);
+err_unresv_iova_region:
+	venus_unreserve_iova_region(dev, core->iova_state);
 err_core_put:
 	if (core->pm_ops->core_put)
 		core->pm_ops->core_put(core);
@@ -562,6 +620,8 @@ static void venus_remove(struct platform_device *pdev)
 
 	hfi_destroy(core);
 
+	venus_unreserve_iova_region(dev, core->iova_state);
+
 	mutex_destroy(&core->pm_lock);
 	mutex_destroy(&core->lock);
 	venus_dbgfs_deinit(core);
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 46705a6667762..93fa77f05834c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -8,6 +8,7 @@
 #define __VENUS_CORE_H_
 
 #include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/v4l2-ctrls.h>
@@ -30,6 +31,9 @@
 
 #define VENUS_MAX_FPS			240
 
+#define VENUS_NP_RESERVE_IOVA_START	0x0
+#define VENUS_NP_RESERVE_IOVA_SIZE	0x25800000
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
@@ -189,6 +193,7 @@ struct venus_format {
  * @dump_core:	a flag indicating that a core dump is required
  * @ocs:	OF changeset pointer
  * @hwmode_dev:	a flag indicating that HW_CTRL_TRIGGER is used in clock driver
+ * @iova_state: a pointer to an array of dma_iova_state entries reserved for restricted IOVA region
  */
 struct venus_core {
 	void __iomem *base;
@@ -250,6 +255,7 @@ struct venus_core {
 	unsigned long dump_core;
 	struct of_changeset *ocs;
 	bool hwmode_dev;
+	struct dma_iova_state *iova_state;
 };
 
 struct vdec_controls {
-- 
2.53.0




