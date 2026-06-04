Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48405F9C0;
	Thu,  4 Jun 2026 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558957; cv=none; b=tpz67xQzwGLERK/F+hFRmhyPNraG8BeNwywliNpP2LlY1CUIRrRdEmfomCUuLlG4fKm5TwED80da3Qcx0g5EJObKHDua+/vOP/zTpvR11Nz/fG4Gbjzuc3qwaLwVQWRyWx+w/eqwARKRq5T3TWF1TeM/9aH2VhERcxa+WwcukrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558957; c=relaxed/simple;
	bh=w5oaby0SPI5qC9TlQ2yiuX5RUisIf1q+2ZdyvYG5Idc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mqe8dd+eVXXSwjll8Hcn8CDJxUOX+yS1NtlAO1959ARLnZTpdehtshfpbS+IkVh6lAQvC8j8MUFWK58N36lmUri1o2RmAc+pYOobI3K1SDcfyE7p5kEpOyoKUKuFxqqMviyweFe78YzRMQCX6ZGlqWjMS/StUl1ZEkAHqS1qcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=i8dlY3g1; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="i8dlY3g1"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 410b6c866;
	Thu, 4 Jun 2026 15:37:15 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] media: renesas: vsp1: fix CLU/LUT entity leaks upon pool allocation failure
Date: Thu,  4 Jun 2026 15:36:54 +0800
Message-Id: <20260604073654.1365717-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e9190a0da03a2kunme5b26b902e207
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTh5IVh0YSx9PGUMdGUNOH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=i8dlY3g13MQUIcyyVPK3Gm9ioJlLU2k6lH1XnzTdGrTmAk85MiR2nPFK7bOeTb7OqJCKB98CUgpErksh4O07dlzCBEzXWZ3MRbGZjUFKLzv1SqlXfI6onPdIyyRXXdqiQZCVqS0RTp9z882TkL/KwaGzrIW9F4QYqdvsGDJDF74=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=dVP7aGhm5Y6ETPyy+1U9AX4lsoQ7z8C/PeEiQ5iVth0=;
	h=date:mime-version:subject:message-id:from;

In vsp1_clu_create() and vsp1_lut_create(), VSP1 entities are initialized
prior to allocating the body pools. If vsp1_dl_body_pool_create() fails,
both functions return -ENOMEM directly. This skips the necessary cleanup
for the already initialized entities, leading to resource leaks.

Fix this by introducing a common error label to consolidate the error
handling. Route the pool allocation failures to this label to ensure
vsp1_entity_destroy() is properly invoked.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that both bugs are still present
in v7.1-rc6.

An x86_64 allyesconfig build of vsp1_clu.o and vsp1_lut.o showed no new
warnings. As we do not have access to a Renesas R-Car system with a
VSP1 instance to test with, and no available emulated platform exposes
one, no runtime testing was able to be performed.

Fixes: 5d7936b8e27d ("media: vsp1: Convert display lists to use new body pool")
Cc: stable@vger.kernel.org

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/media/platform/renesas/vsp1/vsp1_clu.c | 13 +++++++++----
 drivers/media/platform/renesas/vsp1/vsp1_lut.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_clu.c b/drivers/media/platform/renesas/vsp1/vsp1_clu.c
index 04c466c4da81..46b90c7b955a 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_clu.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_clu.c
@@ -236,8 +236,10 @@ struct vsp1_clu *vsp1_clu_create(struct vsp1_device *vsp1)
 	 */
 	clu->pool = vsp1_dl_body_pool_create(clu->entity.vsp1, 3, CLU_SIZE + 1,
 					     0);
-	if (!clu->pool)
-		return ERR_PTR(-ENOMEM);
+	if (!clu->pool) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	/* Initialize the control handler. */
 	v4l2_ctrl_handler_init(&clu->ctrls, 2);
@@ -249,11 +251,14 @@ struct vsp1_clu *vsp1_clu_create(struct vsp1_device *vsp1)
 	if (clu->ctrls.error) {
 		dev_err(vsp1->dev, "clu: failed to initialize controls\n");
 		ret = clu->ctrls.error;
-		vsp1_entity_destroy(&clu->entity);
-		return ERR_PTR(ret);
+		goto error;
 	}
 
 	v4l2_ctrl_handler_setup(&clu->ctrls);
 
 	return clu;
+
+error:
+	vsp1_entity_destroy(&clu->entity);
+	return ERR_PTR(ret);
 }
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_lut.c b/drivers/media/platform/renesas/vsp1/vsp1_lut.c
index 94bdedcc5c92..d508bcbc7a6e 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_lut.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_lut.c
@@ -195,8 +195,10 @@ struct vsp1_lut *vsp1_lut_create(struct vsp1_device *vsp1)
 	 * both the queued and pending dl entries.
 	 */
 	lut->pool = vsp1_dl_body_pool_create(vsp1, 3, LUT_SIZE, 0);
-	if (!lut->pool)
-		return ERR_PTR(-ENOMEM);
+	if (!lut->pool) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	/* Initialize the control handler. */
 	v4l2_ctrl_handler_init(&lut->ctrls, 1);
@@ -207,11 +209,14 @@ struct vsp1_lut *vsp1_lut_create(struct vsp1_device *vsp1)
 	if (lut->ctrls.error) {
 		dev_err(vsp1->dev, "lut: failed to initialize controls\n");
 		ret = lut->ctrls.error;
-		vsp1_entity_destroy(&lut->entity);
-		return ERR_PTR(ret);
+		goto error;
 	}
 
 	v4l2_ctrl_handler_setup(&lut->ctrls);
 
 	return lut;
+
+error:
+	vsp1_entity_destroy(&lut->entity);
+	return ERR_PTR(ret);
 }
-- 
2.34.1

