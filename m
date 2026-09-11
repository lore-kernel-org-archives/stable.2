Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322F1C8604
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085748; cv=none; b=aOyAG+TBQzy6E23npYiJJ8ZrpXsVSsDGnb9KKY0ED6Wk7hFACuwm6GUzsrsUfP5U+qZAKcxY3sO17H3WEdlRf0ve5WHzxwZ5OykAnFNEHEk/qEeh8d4Hf8nn7JkKpCVy2Pjn83upz1zGYEFRDTLRAMs3H/1tYWO0xKsu5bk0ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085748; c=relaxed/simple;
	bh=mk2kKLlAt4o8xFJVGTW7CcTVgbsvbCJclvTv3In4O74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvlM58JxOlTdWVP9mhH9Mm0rXGFO4oftV0mPqrelFBu+zlu8R9zAGbVOY/rxH46vfRX1r3Zug8pDSSup5Tk/6HvGsqaMyySdGgLLs/GdsK0h9J2IdpAuPvWysYH8CTVtgC8DJ1w4ApWe9Y/SgeCHhNbwW4KZX0YjGmEgmqP5xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwT4CPJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwT4CPJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7501F000FF;
	Fri, 11 Sep 2026 00:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085745;
	bh=N7AFXVwd/gSw6Zbd9P5k7ccZ80/5fjYv16tcrcq22pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwT4CPJbhR2NLCn0ll8P/WcpzyY6VSZa/EVC0bTIldlRsPXFVUeY/AYc2RET3R6R8
	 VkQbUiXUi5kbNUJfFFLC+S88KnD8vqGJkx52b0yoAQNj42LHsRKcsTL7oM3Jpiu0fs
	 9BY+iKf5GWJlb00YYlyv3Jyk9e+dXxV0mneg9g75iKZYxeeoEZDNeH5Zz5pfZIazOa
	 7/MgxapHRo5j/HJmhdxCI6MyForwkSJRqwdY7msyspLLkxCiUAdzTkCvaIsmCHg9+K
	 +sJm6LBofhGJpdAobSeK4lWm99qyV1lfXDVKxgINPWXwkf9T9ZMcLj4uSYQv5qcDzn
	 Mk5NDY5kHmIMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] nvme: all namespaces in a subsystem must adhere to a common atomic write size
Date: Thu, 10 Sep 2026 20:15:40 -0400
Message-ID: <20260911001543.3303783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090951-hardhead-splashing-d9e8@gregkh>
References: <2026090951-hardhead-splashing-d9e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Adamson <alan.adamson@oracle.com>

[ Upstream commit 8695f060a02953b33ac6240895dcb9c7ce16c91c ]

The first namespace configured in a subsystem sets the subsystem's
atomic write size based on its AWUPF or NAWUPF. Subsequent namespaces
must have an atomic write size (per their AWUPF or NAWUPF) less than or
equal to the subsystem's atomic write size, or their probing will be
rejected.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
[hch: fold in review comments from John Garry]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Stable-dep-of: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 30 +++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b13427d0a8a4..3f2586086f6ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2056,7 +2056,21 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ns->ctrl->awupf) * bs;
+
+		/*
+		 * Set subsystem atomic bs.
+		 */
+		if (ns->ctrl->subsys->atomic_bs) {
+			if (atomic_bs != ns->ctrl->subsys->atomic_bs) {
+				dev_err_ratelimited(ns->ctrl->device,
+					"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+					ns->disk ? ns->disk->disk_name : "?",
+					ns->ctrl->subsys->atomic_bs,
+					atomic_bs);
+			}
+		} else
+			ns->ctrl->subsys->atomic_bs = atomic_bs;
 
 		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
 	}
@@ -2195,6 +2209,17 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
+
+	/*
+	 * Validate the max atomic write size fits within the subsystem's
+	 * atomic write capabilities.
+	 */
+	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		ret = -ENXIO;
+		goto out;
+	}
+
 	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
@@ -3021,7 +3046,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
-	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = &nvme_subsys_class;
@@ -3431,7 +3455,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
-
+	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dcdce7d12e441..8b4c0e17bb4e7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,7 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+	u16 awupf; /* 0's based value. */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -442,11 +443,11 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
+	u32			atomic_bs;
 };
 
 /*
-- 
2.53.0

