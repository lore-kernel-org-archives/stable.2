Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F31A6813
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085749; cv=none; b=jWCSbJ9UowCg17Z6r780XdjOxtvLj4Ool2d20IgG8hREZGOChlixkKklDK6oxmu7WmOoYiE46sUW8addm9Cl9y7AeH6hRbi/Gxa4NtF2L6MQdvQxMThOr78V+kbfMdiA8bNp74XxxL41+w46bawcvHb/wiYPosWhju4j0YINM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085749; c=relaxed/simple;
	bh=jdt/GtTKEJ7h97+R6YqyDj3vM2sHWp2AmT9OGkFarnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNArKSgZ8weOs+JtZtc61ZYScUc4d8Wj+kcdHdePzzP0XzPX5f89JATvwoC3unhIpp0XPJPQPN2t5SXsNdnjuEuTM95AIIRrn6HqPABx3RmqBg4YH3jes/divg9WXyFpmDPrBF4Z/iYoV7g/gSkibfoBNNvRiFvR7N1fra6vF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkovho1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkovho1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F51F00898;
	Fri, 11 Sep 2026 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085746;
	bh=5esdNVL+1vkuWQW5al3wizyZEahwQL/VCV+8hDLe3TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bkovho1b6CJ7ZmgsY1MfJGh/U5rw+s3/T7czLj3t7/DrBeXSdh7NxSqpMwTwgag6H
	 MktU+U9k+Krgklpv+huz10Gw4NIdO7atuXOR4+IM8o555doJHNXiXexgM8FeXpth3s
	 7BwC78twAA0uhOAQTuACCsifie/AumDWQF1Ih0eLUhpsCspM+PSoSLkH3I+iZAI7FY
	 brvTCL/Wz18san/CESdkR462kCyEfJoMaCLirV5bsbzhRut6sA8y1KzQ3yGoro/bmW
	 zczqateTaOA9vopPjRK8st5sl3r1jZZxTtRzbKlMR182yeL4IhNH28zZt7h+YNe6bG
	 Z5uBH0ghPCYgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] nvme: refactor the atomic write unit detection
Date: Thu, 10 Sep 2026 20:15:41 -0400
Message-ID: <20260911001543.3303783-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911001543.3303783-1-sashal@kernel.org>
References: <2026090951-hardhead-splashing-d9e8@gregkh>
 <20260911001543.3303783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b2e607fecac15e07f50269c080e2e71b5049dfa2 ]

Move all the code out of nvme_update_disk_info into the helper, and
rename the helper to have a somewhat less clumsy name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>

Stable adaptation for 6.12:
- Keep the existing atomic write helper refactor, but omit
  BLK_FEAT_ATOMIC_WRITES: this tree enables atomic writes through the
  hardware limits and does not define that feature flag.
- Call the existing discard setup helper from nvme_update_disk_info()
  after setting logical_block_size. Save the disk-info validity result
  and defer clearing capacity until after atomic-size validation. This
  preserves the result while leaving the zoned update insertion point
  clear for 3838e80fcfb32e62baffb63c6dc0a60153665a4d.
- Adapt the preceding dependency's atomic-size error path to the
  single-argument blk_mq_unfreeze_queue() API and cancel the pending
  limits update before unfreezing, releasing limits_lock on rejection.

No additional functions are introduced.

Stable-dep-of: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 84 ++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3f2586086f6ec..deffad78d1dcf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1995,20 +1995,50 @@ static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
 }
 
 
-static void nvme_update_atomic_write_disk_info(struct nvme_ns *ns,
-			struct nvme_id_ns *id, struct queue_limits *lim,
-			u32 bs, u32 atomic_bs)
+static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
+		struct nvme_id_ns *id, struct queue_limits *lim, u32 bs)
 {
-	unsigned int boundary = 0;
+	u32 atomic_bs, boundary = 0;
 
-	if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf) {
-		if (le16_to_cpu(id->nabspf))
+	/*
+	 * We do not support an offset for the atomic boundaries.
+	 */
+	if (id->nabo)
+		return bs;
+
+	if ((id->nsfeat & NVME_NS_FEAT_ATOMICS) && id->nawupf) {
+		/*
+		 * Use the per-namespace atomic write unit when available.
+		 */
+		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
+		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+	} else {
+		/*
+		 * Use the controller wide atomic write unit.  This sucks
+		 * because the limit is defined in terms of logical blocks while
+		 * namespaces can have different formats, and because there is
+		 * no clear language in the specification prohibiting different
+		 * values for different controllers in the subsystem.
+		 */
+		atomic_bs = (1 + ns->ctrl->awupf) * bs;
+	}
+
+	if (!ns->ctrl->subsys->atomic_bs) {
+		ns->ctrl->subsys->atomic_bs = atomic_bs;
+	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
+		dev_err_ratelimited(ns->ctrl->device,
+			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+			ns->disk ? ns->disk->disk_name : "?",
+			ns->ctrl->subsys->atomic_bs,
+			atomic_bs);
 	}
+
 	lim->atomic_write_hw_max = atomic_bs;
 	lim->atomic_write_hw_boundary = boundary;
 	lim->atomic_write_hw_unit_min = bs;
 	lim->atomic_write_hw_unit_max = rounddown_pow_of_two(atomic_bs);
+	return atomic_bs;
 }
 
 static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
@@ -2046,34 +2076,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		valid = false;
 	}
 
-	atomic_bs = phys_bs = bs;
-	if (id->nabo == 0) {
-		/*
-		 * Bit 1 indicates whether NAWUPF is defined for this namespace
-		 * and whether it should be used instead of AWUPF. If NAWUPF ==
-		 * 0 then AWUPF must be used instead.
-		 */
-		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
-			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
-		else
-			atomic_bs = (1 + ns->ctrl->awupf) * bs;
-
-		/*
-		 * Set subsystem atomic bs.
-		 */
-		if (ns->ctrl->subsys->atomic_bs) {
-			if (atomic_bs != ns->ctrl->subsys->atomic_bs) {
-				dev_err_ratelimited(ns->ctrl->device,
-					"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
-					ns->disk ? ns->disk->disk_name : "?",
-					ns->ctrl->subsys->atomic_bs,
-					atomic_bs);
-			}
-		} else
-			ns->ctrl->subsys->atomic_bs = atomic_bs;
-
-		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
-	}
+	phys_bs = bs;
+	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
 		/* NPWG = Namespace Preferred Write Granularity */
@@ -2097,6 +2101,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
 		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
+	nvme_config_discard(ns, lim);
 	return valid;
 }
 
@@ -2171,6 +2176,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	struct nvme_id_ns *id;
 	sector_t capacity;
 	unsigned lbaf;
+	bool valid;
 	int ret;
 
 	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
@@ -2207,20 +2213,22 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
-	if (!nvme_update_disk_info(ns, id, &lim))
-		capacity = 0;
+	valid = nvme_update_disk_info(ns, id, &lim);
 
 	/*
 	 * Validate the max atomic write size fits within the subsystem's
 	 * atomic write capabilities.
 	 */
 	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
-		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		queue_limits_cancel_update(ns->disk->queue);
+		blk_mq_unfreeze_queue(ns->disk->queue);
 		ret = -ENXIO;
 		goto out;
 	}
 
-	nvme_config_discard(ns, &lim);
+	if (!valid)
+		capacity = 0;
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
-- 
2.53.0

