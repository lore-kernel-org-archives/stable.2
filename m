Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048202;
	b=c6D6UUsHn4R0ARbTTCIA4PHKBo7J2NeR2lW1xnpB1FDNRGAxDfDQzfSTwRsL3uniOxbG
	 jO/9DZfvXL6JUHT3cDSDhMmXSrKlZNOU6xHEIfgGKpDfaxQQRwxYg6sa+T3OOM/z/RHTw
	 OlxN46TBShCDbALA4XVQIIKEHXlNQRhE1Bq+c1l3c5FVK3gE5xw65y9Ls4I76qiW8R5i4
	 Wilx4Cz5ks7z8LOWbWMBI/K61pTXZC6ptcdGZmELuwpwWOY4fcf0x+WS2Vlj2BJvO3gM6
	 2FbfEA/qUNYaH0jU3cKcHuLNToKIuwaGFGz43GSjC4HH9bd9xWYK3oYP0xkw9Nbja6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048202;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2MUTPUTyO/194Q+P8X7NP5LMQvLo9Kz5O0WSlXRC5TE=;
	b=3Zzgt8OSEdC9LTOO3Nf7DJWLnKFyQssJYTiZSa5s8qVKj039OAcAHHXA0K1ExvfmOTJk
	 sGFS325h+SIPvk4dfYkQqa+cspvCk7XWHsVwe/ikIFnkWMnmxuol0JLQfwTrJzocESJnQ
	 3zYiIQuZfXPB0oJ0lXS3US7Sp4CVQf93Qyd6sO7BUDgyExgBnIHCay98SaAguLb3WlJCw
	 S7yZUA8hgLFLzibTvh+4+rHlVgPVs4xv7yq37Lkl21waVq7MWoqsrV8MRvu1NOLZkl5VA
	 OA9/knFd4qN0ULBHj/TLjnpgRZm8zRXcxikm90PpydJcOyRE/x+4ShOjeE++/7496Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7ssXue2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E6606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P7ssXue2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F221F0089F;
	Sat,  7 Nov 2026 10:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048202;
	bh=2MUTPUTyO/194Q+P8X7NP5LMQvLo9Kz5O0WSlXRC5TE=;
	h=From:To:Cc:Subject:Date;
	b=P7ssXue2IOrFD7rsHuoom20JgLovqrP3neMmFb2nzgSmdmv2/bELGfhm36UDewzyU
	 +uup//jdqs5KSRNGWTJjhjtFvjREG8L8rXR74v1+jpLsr7KNnHm/8wVP7QuHSxyfYN
	 8ModQydxWrYzioqCj1X47PuRbRp8k4yJyMFCFavon/yFSnNLAgG3dnxUlJG8TEnZn7
	 1spskYJ3AojXLURERH5kKBHY7TrUtUVpB2QYcYerLZxwUz+82LmnLHais931JSEaTi
	 FjIZV5ASVKd5XsSCRFCC8wP40y/ikAZCfmh6F+4sDofvAb0GUXDZedveZd+jlMy9MX
	 LjyH7X5xeGtHQ==
From: Sasha Levin <sashal@kernel.org>
To: busanna.reddy@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com,
	bod@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: venus: Fix iova allocation from restrict region" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:20 -0500
Message-ID: <20261107054320-failed-6.1-953439251b59@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 953439251b596cee039fbfeaffeb1d88a4b40f43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054320-failed-6.1-953439251b59@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




