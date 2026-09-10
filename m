Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E462339AD2A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067741; cv=none; b=LTsKiq6d5ri7Mz7agJhbeZD+2bLqnt2q3eLhM5ZAEVyU0prsLyFQmyLuLkpK7Ui9pfyiB6azXkL0bZN2x3gru7jMAvkBbZ1lULlpXxUwpCbJHlV2T8Lj3MT6LfDgWrsFWykL8m7s4sfvAbQxju7YVFia95oWnTIQArO/CgIWyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067741; c=relaxed/simple;
	bh=6G3FspFKnEVyN/bzTMcQHO9DwXQ7Xfvs+J6UG4RICXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSEYwt5FFA7TEBBpH3Xb1bp8+0mkWsdZpjtaaJYq2Hc+T4CLHxqed2oOgdHG+lCWttuf+AiYVAIMP3CC32FeYcNiOITfcCIqwyQyA81JfAxcvFs8Sxg96TuN2fOnSFx/fP2PeEAU+7KAGmNfb1mY0LAKEBTMITVle2q+tEfEPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENtidFWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENtidFWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FDB1F000FF;
	Thu, 10 Sep 2026 19:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067738;
	bh=UobQCY8mjMy8QNtPlPJaZeBSy9bRybG0h8fSVaZxQVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENtidFWxpaStzvgsm8PkZxppNOkah8wfWavUOb26O3mH7unttvSMuRflXMJ8F049n
	 joxmAcKavFBY4iSXrN4njUo2oskuGyOQgiP38F/lB6rdIlBE8DSoGMbnsOd8N5lCkw
	 2hfKpHXVhRZ4COibzPoIZt0AdfXtaw87whIHpODKInvt1/4/ItZSRyF7DnjQ+gDvXv
	 QrMNd1lgqV4zrwI8rYXxDarZPD+wFhgW0GnyQGuh4HYBTeD00lVU3rm1jtFLHCT67L
	 BapyxtC3knefA4UlZDCU372AtVIaNfNCQc0IhrjBThIptP1mOv1ct97Rk9aK37z0rL
	 Di4jDnoWkmtnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nvme: fold nvme_config_discard() into nvme_update_disk_info()
Date: Thu, 10 Sep 2026 15:15:35 -0400
Message-ID: <20260910191536.1489155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090951-pusher-problem-219d@gregkh>
References: <2026090951-pusher-problem-219d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caleb Sander Mateos <csander@purestorage.com>

[ Upstream commit 9110b85244f142ca4bcaea27be408c778d3c48d0 ]

The choice of what queue limits are set in nvme_update_disk_info() vs.
nvme_config_discard() seems a bit arbitrary. A subsequent commit will
compute the discard_granularity limit using struct nvme_id_ns, which is
only passed to nvme_update_disk_info() currently. So move the logic in
nvme_config_discard() to nvme_update_disk_info(). Replace several
instances of ns->ctrl in nvme_update_disk_info() with the ctrl variable
brought from nvme_config_discard().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Stable-dep-of: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7199fc97f189..18685653f9b45 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1882,26 +1882,6 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	return true;
 }
 
-static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
-{
-	struct nvme_ctrl *ctrl = ns->ctrl;
-
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
-		lim->max_hw_discard_sectors =
-			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
-	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		lim->max_hw_discard_sectors = UINT_MAX;
-	else
-		lim->max_hw_discard_sectors = 0;
-
-	lim->discard_granularity = lim->logical_block_size;
-
-	if (ctrl->dmrl)
-		lim->max_discard_segments = ctrl->dmrl;
-	else
-		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
-}
-
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -2084,6 +2064,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		struct queue_limits *lim)
 {
 	struct nvme_ns_head *head = ns->head;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
@@ -2118,11 +2099,26 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	lim->physical_block_size = min(phys_bs, atomic_bs);
 	lim->io_min = phys_bs;
 	lim->io_opt = io_opt;
-	if ((ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
-	    (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM))
+	if ((ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES) &&
+	    (ctrl->oncs & NVME_CTRL_ONCS_DSM))
 		lim->max_write_zeroes_sectors = UINT_MAX;
 	else
-		lim->max_write_zeroes_sectors = ns->ctrl->max_zeroes_sectors;
+		lim->max_write_zeroes_sectors = ctrl->max_zeroes_sectors;
+
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		lim->max_hw_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		lim->max_hw_discard_sectors = UINT_MAX;
+	else
+		lim->max_hw_discard_sectors = 0;
+
+	lim->discard_granularity = lim->logical_block_size;
+
+	if (ctrl->dmrl)
+		lim->max_discard_segments = ctrl->dmrl;
+	else
+		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
 	return valid;
 }
 
@@ -2387,7 +2383,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 
-	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
-- 
2.53.0

