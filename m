Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF2147F9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085749; cv=none; b=pQcMSOGB8Z49QF9gzqgkHrHZ95ayRpS53bEBvLxZDiox+R6yIWEP2H4wCnRNQCt075foWuBrflp2Z8eNzRk+J64CmIn3rOwxv/33cJX6FbaeAwzn5E9A8WfEX1NLewtsEK/Lq0v8fS7+VnF7aL3ZZmOvkXz0dJPgetsSbJMSORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085749; c=relaxed/simple;
	bh=gWbCnPpdmOH3PM6MoDK1sBw391PQQAALi2KjgJ3+Lc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp5R9PgQ6UExcd7S1sWBYbO/M/ouNHjTdHUCcAzVAtqb/g1qk8l7MXzyrOLFGnJutK8sJRXWf9Im9UIVIQ0R9CeObKapMXlAWXjXeQXXuI502O6EBjGoWhcSM7RtSBU8WDCgKj/n0Sa1QX05n+NuY6Qbhaz8f0QY2+xWCwcQD4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKkb/5S/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKkb/5S/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E2B1F00893;
	Fri, 11 Sep 2026 00:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085747;
	bh=zLbiioKSOc4lPFqgHJmvmiP83I7uX6fMT7tPxRMbWf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKkb/5S/XOpYYjQISnkstnmo26navEEd1j09IrOTig11VeafXI3aYBK4bDBPqog/0
	 JQ6hFjy8BF4LTB3bbVbjFMsqzfG6mC+FKrvb6twPKsIFjSpsCQZzwuU9ecVFsKi/Mp
	 2hwXIp6T8D+4VAH/mGaPSYsRMihYrIIGor70yhsOtdf8a7cBtzo1v1EToUM/fShohs
	 3PehtIWPKPIt8jQUebyeIAPBckKykc4U+pU5Gb9NbwCxjHhmMneEf26MZQCwb9coWu
	 EGZeNRv1HzX8wNe1aQH0LhDvhPU/3n6PAN2Itt3KgQHPFg5jnbzk/7h0sG4ea8Z8gy
	 eWLom9nXE+xvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] nvme: fix atomic write size validation
Date: Thu, 10 Sep 2026 20:15:42 -0400
Message-ID: <20260911001543.3303783-3-sashal@kernel.org>
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

[ Upstream commit f46d273449ba65afd53f3dd8fe0182c9df877e08 ]

Don't mix the namespace and controller values, and validate the
per-controller limit when probing the controller.  This avoid spurious
failures for controllers with namespaces that have different namespaces
with different logical block sizes, or report the per-namespace values
only for some namespaces.

It also fixes a missing queue_limits_cancel_update in an error path by
removing that error path.

Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>

Stable adaptation for 6.12:
- Remove the atomic-size rejection together with its locally adapted
  queue_limits_cancel_update() and one-argument queue unfreeze calls.
  Validation now happens during controller identification, as upstream.
- Keep nvme_config_discard() in nvme_update_disk_info(), where the
  preceding dependency moved it. Do not restore a duplicate call here.
- Preserve the saved disk-info validity result and capacity handling,
  leaving the zoned update insertion point available for target
  3838e80fcfb32e62baffb63c6dc0a60153665a4d.

No additional functions are introduced.

Stable-dep-of: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 34 +++++++++++-----------------------
 drivers/nvme/host/nvme.h |  3 +--
 2 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index deffad78d1dcf..3e36b814fbe6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2021,17 +2021,7 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		 * no clear language in the specification prohibiting different
 		 * values for different controllers in the subsystem.
 		 */
-		atomic_bs = (1 + ns->ctrl->awupf) * bs;
-	}
-
-	if (!ns->ctrl->subsys->atomic_bs) {
-		ns->ctrl->subsys->atomic_bs = atomic_bs;
-	} else if (ns->ctrl->subsys->atomic_bs != atomic_bs) {
-		dev_err_ratelimited(ns->ctrl->device,
-			"%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
-			ns->disk ? ns->disk->disk_name : "?",
-			ns->ctrl->subsys->atomic_bs,
-			atomic_bs);
+		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;
@@ -2215,17 +2205,6 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_set_chunk_sectors(ns, id, &lim);
 	valid = nvme_update_disk_info(ns, id, &lim);
 
-	/*
-	 * Validate the max atomic write size fits within the subsystem's
-	 * atomic write capabilities.
-	 */
-	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
-		queue_limits_cancel_update(ns->disk->queue);
-		blk_mq_unfreeze_queue(ns->disk->queue);
-		ret = -ENXIO;
-		goto out;
-	}
-
 	if (!valid)
 		capacity = 0;
 
@@ -3039,6 +3018,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
+	subsys->awupf = le16_to_cpu(id->awupf);
 
 	/* Versions prior to 1.4 don't necessarily report a valid type */
 	if (id->cntrltype == NVME_CTRL_DISC ||
@@ -3368,6 +3348,15 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		if (ret)
 			goto out_free;
 	}
+
+	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
+		dev_err_ratelimited(ctrl->device,
+			"inconsistent AWUPF, controller not added (%u/%u).\n",
+			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	memcpy(ctrl->subsys->firmware_rev, id->fr,
 	       sizeof(ctrl->subsys->firmware_rev));
 
@@ -3463,7 +3452,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8b4c0e17bb4e7..5985cdd4c02d6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,7 +410,6 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
-	u16 awupf; /* 0's based value. */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -443,11 +442,11 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
+	u16			awupf; /* 0's based value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
-	u32			atomic_bs;
 };
 
 /*
-- 
2.53.0

