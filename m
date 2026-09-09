Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5032A3D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973572; cv=none; b=cJT6AjPrRH1su4Ppj3S7VCNhrCCu3xyivH8rTkRh2uhk0mMTu0M41P1hPmyB4X+oOzUovGW3cGpFILHUW69b8+qZO4m7px+rv4tekmWAs7n0Z9ggBInmcmeG9ZNsmgLaI6JVGH144bkqb3hyOQwmQRblc6rzuyzy+kGr0umWBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973572; c=relaxed/simple;
	bh=hdYLiRfUCi4SnOVy2YYpoy4uw04VHFcRvb0j1HUSyRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INV0CPF8Az1Sca6QWQ+gW6WCfEU69WkTOGyVyYbjJg4PwvT8Ap1+lByxDdAF0uQenqVJB+igD/dlf78SuEYQRzy8P/i1YGsAmeLtVRssaUcsgYbcVuxCQpSV3lHcewtntEjlQp7PDP4oX3/05VsA/kmtmEesiQrC+QNQjFWxlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSV+ctXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSV+ctXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60901F000FF;
	Wed,  9 Sep 2026 17:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973570;
	bh=UZ5m5q6R5X0cNSnSEqvWOEJAz0GwOCscUUj6vATKvGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gSV+ctXHPzcVhXsOEXqzylq7QazGh3knrdl27jKtdWrR8JdMyHV+vGC+B+Qz95M6l
	 AWM5ZuKCKaaeHJ5d/0kqNZ2QM2+kPlTEMgslDmWjqFOwJv+TERh52LM2Vd6QJgLDfN
	 O+FtMhDiyOvN6xtIG62jGFReDtynU6tNxQQqFHof3P44tgTQf450dl2spqLnvGCtER
	 DmTJbUT72HXgnAYd2bLcOv2q83ZTUhMhtex+CC5llinfZGGY7JzsDLWhS5gQjMd9FY
	 WhpsJfLg68f6c6V6CvpIKK2THz49u0lQi5VEcDAZsxsOCCKAU+S1WLXxpU0oJCLhyU
	 9Syu8FHSq1kxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hector Martin <marcan@marcan.st>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
Date: Wed,  9 Sep 2026 13:06:03 -0400
Message-ID: <20260909170604.3185721-4-sashal@kernel.org>
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

[ Upstream commit 285b6e9b571714270fa503d0e32f244d15b9f85f ]

Many of the callers decide which one to use based on a bool argument and
there is at least some code to be shared, so merge these two.  Also
move a comment specific to a single callsite to that callsite.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hector Martin <marcan@marcan.st>

For this stable backport, retain nvme_stop_admin_queue() in the RDMA and
TCP teardown paths: this tree does not have the upstream
nvme_quiesce_admin_queue() API rename. Convert the shutdown/disable calls
in place, preserving the stable tree's admin queue quiescing and teardown
order. No new functions are introduced.

The merged nvme_disable_ctrl(ctrl, shutdown) interface is required by
08660a5c8d497f43191635d97efd31cd35051f15 ("nvme-pci: disable controller on
admin queue IRQ setup failure"), whose failure-path call passes false.

Stable-dep-of: 08660a5c8d49 ("nvme-pci: disable controller on admin queue IRQ setup failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/apple.c  |  5 +----
 drivers/nvme/host/core.c   | 33 ++++++++++-----------------------
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    | 15 +++++++++------
 drivers/nvme/host/rdma.c   |  5 +----
 drivers/nvme/host/tcp.c    |  5 +----
 drivers/nvme/target/loop.c |  2 +-
 8 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c0c23b851e4e7..99b5eca744f87 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -829,10 +829,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 			apple_nvme_remove_cq(anv);
 		}
 
-		if (shutdown)
-			nvme_shutdown_ctrl(&anv->ctrl);
-		else
-			nvme_disable_ctrl(&anv->ctrl);
+		nvme_disable_ctrl(&anv->ctrl, shutdown);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b0cbf8b88d80e..162d1530798e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2351,23 +2351,25 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-/*
- * If the device has been passed off to us in an enabled state, just clear
- * the enabled bit.  The spec says we should set the 'shutdown notification
- * bits', but doing so may cause the device to complete commands to the
- * admin queue ... and we don't know what memory that might be pointing at!
- */
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
+	if (shutdown)
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+	else
+		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
 
+	if (shutdown) {
+		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+				       NVME_CSTS_SHST_CMPLT,
+				       ctrl->shutdown_timeout, "shutdown");
+	}
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
@@ -2459,21 +2461,6 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
-int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
-{
-	int ret;
-
-	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
-
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
-	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK, NVME_CSTS_SHST_CMPLT,
-			       ctrl->shutdown_timeout, "shutdown");
-}
-EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
-
 static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
 	__le64 ts;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b88601ce73f9a..6c39a4b9c8943 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2500,7 +2500,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * Other transports, which don't have link-level contexts bound
 	 * to sqe's, would try to gracefully shutdown the controller by
 	 * writing the registers for shutdown and polling (call
-	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
+	 * nvme_disable_ctrl()). Given a bunch of i/o was potentially
 	 * just aborted and we will wait on those contexts, and given
 	 * there was no indication of how live the controlelr is on the
 	 * link, don't send more io to create more contexts for the
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8c97777ba629c..075e45e99f51c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -745,9 +745,8 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
-int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d67043aa1fff..c347256a0f618 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1539,11 +1539,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
 
-	if (shutdown)
-		nvme_shutdown_ctrl(&dev->ctrl);
-	else
-		nvme_disable_ctrl(&dev->ctrl);
-
+	nvme_disable_ctrl(&dev->ctrl, shutdown);
 	nvme_poll_irqdisable(nvmeq);
 }
 
@@ -1865,7 +1861,14 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
 		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
 
-	result = nvme_disable_ctrl(&dev->ctrl);
+	/*
+	 * If the device has been passed off to us in an enabled state, just
+	 * clear the enabled bit.  The spec says we should set the 'shutdown
+	 * notification bits', but doing so may cause the device to complete
+	 * commands to the admin queue ... and we don't know what memory that
+	 * might be pointing at!
+	 */
+	result = nvme_disable_ctrl(&dev->ctrl, false);
 	if (result < 0)
 		return result;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 47fbf561c01e6..d69f18a60a8cb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2213,10 +2213,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	nvme_stop_admin_queue(&ctrl->ctrl);
-	if (shutdown)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
-	else
-		nvme_disable_ctrl(&ctrl->ctrl);
+	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 441cacad4498b..42330d4de7bcd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2228,10 +2228,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	nvme_stop_admin_queue(ctrl);
-	if (shutdown)
-		nvme_shutdown_ctrl(ctrl);
-	else
-		nvme_disable_ctrl(ctrl);
+	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index c864e902e91e2..d3955eff163a8 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -401,7 +401,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 
 	nvme_stop_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_shutdown_ctrl(&ctrl->ctrl);
+		nvme_disable_ctrl(&ctrl->ctrl, true);
 
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.53.0

