Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3E3090CD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973571; cv=none; b=K8UY8NHXOpfchXWoBZmXPKH4cQT6iDZqTDThkN9D2eRhS0W3jzyoIfwAtV5h2mGRnpiDygrAyR8y0p0bWqu/727MckqF+b65iex/Ff8IrsMy9AYpSCQjjyYYiodzThHEO152TaRJIyBuqNrn8bL+5aFo63wO0qB7DVlzUJ4rihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973571; c=relaxed/simple;
	bh=co7w4nb7vt+zg5lNY4c9ezCLT8FWZc+TCbuSuAVEo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXkn3Ha0pebQVVT1IXhQ7PxPxmAL/XDtO4BuP4aOxW04/VoM1bQ5hPLKNoT7Yme9T7fWT25KIrPqgyg3Z7n/nXDrr6qs4qNllYMZsNc4umt1YSnBNODYW6SnHR2y6InNrTzybw/cf91gNJBnlxn168vnPpFD0fu6Ypq/CnFgXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogDTMB+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogDTMB+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AB41F00893;
	Wed,  9 Sep 2026 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973569;
	bh=gjo36B1KCaLz4qYf2OOp6KqNZOf/XX6qQ1mEOCSQYN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ogDTMB+5uUMNc/5caeX5w097zCroeTVHs88Z4lpw3dr5II6zHe0Kg+Z7JXoEvhnnx
	 p5WIykEVtQp7W7potJQLxkXzpEYa3d9Vlbw9EKuPir/QfQd1d64OM4xW9EUHHuJ6rk
	 1552IlxLzLx0Kbr5UK3evNJ54hTACH6gdZITtB9PVbepEfTkptYuQiG0HULBvLG7I3
	 yy8cLP3hMlneNgN+UmlujnemOHLBMCbRzpjGMDSHAj731gc8XWqj0fdUe9M5SwA+qF
	 QWr3b/nz07oZELiNkRCO5iREV+/H7wThxYLGfzhA0tVceShU/dKEFYNRhlzl3HaR1q
	 i6+Pp2fFTkxpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] nvme: use nvme_wait_ready in nvme_shutdown_ctrl
Date: Wed,  9 Sep 2026 13:06:02 -0400
Message-ID: <20260909170604.3185721-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170604.3185721-1-sashal@kernel.org>
References: <2026090346-clang-google-039d@gregkh>
 <20260909170604.3185721-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e6d275de2e4aaebdc97aa022c031a0dcc475efa4 ]

Refactor the code to wait for CSTS state changes so that it can be reused
by nvme_shutdown_ctrl.  This reduces the delay between each iteration
that checks CSTS from 100ms in the shutdown code to the 1 to 2ms range
done during enable, matching the changes from commit 3e98c2443f5c that
were only applied to the enable/disable path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Stable-dep-of: 08660a5c8d49 ("nvme-pci: disable controller on admin queue IRQ setup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 636d3ef5b2d1c..b0cbf8b88d80e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2324,16 +2324,17 @@ static const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
+static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+		u32 timeout, const char *op)
 {
-	unsigned long timeout_jiffies = ((timeout + 1) * HZ / 2) + jiffies;
-	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
+	unsigned long timeout_jiffies = jiffies + timeout * HZ;
+	u32 csts;
 	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
-		if ((csts & NVME_CSTS_RDY) == bit)
+		if ((csts & mask) == val)
 			break;
 
 		usleep_range(1000, 2000);
@@ -2342,7 +2343,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 timeout, bool enabled)
 		if (time_after(jiffies, timeout_jiffies)) {
 			dev_err(ctrl->device,
 				"Device not ready; aborting %s, CSTS=0x%x\n",
-				enabled ? "initialisation" : "reset", csts);
+				op, csts);
 			return -ENODEV;
 		}
 	}
@@ -2369,8 +2370,8 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
-
-	return nvme_wait_ready(ctrl, NVME_CAP_TIMEOUT(ctrl->cap), false);
+	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
+			       (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, "reset");
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
@@ -2453,14 +2454,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
-	return nvme_wait_ready(ctrl, timeout, true);
+	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, NVME_CSTS_RDY,
+			       (timeout + 1) / 2, "initialisation");
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
-	u32 csts;
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
@@ -2469,22 +2469,8 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
-
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
-		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
-			break;
-
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->device,
-				"Device shutdown incomplete; abort shutdown\n");
-			return -ENODEV;
-		}
-	}
-
-	return ret;
+	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK, NVME_CSTS_SHST_CMPLT,
+			       ctrl->shutdown_timeout, "shutdown");
 }
 EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
-- 
2.53.0

