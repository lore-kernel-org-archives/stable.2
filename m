Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A9388E66;
	Wed, 24 Jun 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291567; cv=none; b=GNsp1eDHePfXyC/H6i6vFR+90mZgnSJczyFvLwCZ9ial4a12ptfsAy8hyp5LCvFLPvxyRz8Vc0Smu/NjPAG6s8YrQXmuCj3GqzedJ5jmNeNhN1NnU9LVbKDICQXCbTTC/0eMBAirfWltCT7pNFRYO77g+F9q5NlZlodAm09DrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291567; c=relaxed/simple;
	bh=fC6w5B2nTnKPRsothCtVZ+qn5I3g0FjCgVdQ7JVzBlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCIEauxWao6IQ1nRuormU04jaqOOVbIPym9T/vJ/HYrUkb4Hdpwz1KLA7cKcEUPfaiigv3picLHo4ETyp7LKiZbxgZ+0ykfDecceVQTcQh7lqyKvP6B2orFNSfsabcF7Q17FrP5JBM7muhhhAOfzvNCSWgmMFR6aU3qgH3FVXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=erdZEh2o; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="erdZEh2o"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 439346cd7;
	Wed, 24 Jun 2026 16:59:19 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: mripard@kernel.org
Cc: paulk@sys-base.io,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: cedrus: fix memory leak in cedrus_init_ctrls()
Date: Wed, 24 Jun 2026 16:59:20 +0800
Message-Id: <20260624085920.578446-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ef8daf33f03a2kunmb50e020236f68
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHRpLVkhOTx1LGR8fTkIaTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=erdZEh2o+CuenN77cKHcsJJ1qdCHhHw85+ajbj6voIkvWHuPMI/l8WEyNmbHW+2oU/Z3oJcbTNeRdMPI3imx4Pw8pDeGvZO2CNXVCkcWIGktPUH/jyjplOoWdLREfWyp6j98Qb0ccJd6yNNEqA2w3CWrJYZaezLpnyzUFClFKb0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=nQ64irTn5cB91B6G4LunXFGhvflcWlZllUKpo3Q4WA0=;
	h=date:mime-version:subject:message-id:from;

In cedrus_init_ctrls(), the V4L2 control handler is initialized before
allocating memory for ctx->ctrls. If this allocation fails, the function
returns -ENOMEM without freeing the previously allocated handler
resources, leading to a memory leak.

Fix this by calling v4l2_ctrl_handler_free() on the ctx->ctrls allocation
failure path.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1.1.

An x86_64 allyesconfig build showed no new warnings. As we do not have an
Allwinner SoC or board with a Cedrus VPU available to test with, no
runtime testing was able to be performed.

Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index bbd186b8035b..96acd52e380c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -285,8 +285,10 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 	ctrl_size = sizeof(ctrl) * CEDRUS_CONTROLS_COUNT + 1;
 
 	ctx->ctrls = kzalloc(ctrl_size, GFP_KERNEL);
-	if (!ctx->ctrls)
+	if (!ctx->ctrls) {
+		v4l2_ctrl_handler_free(hdl);
 		return -ENOMEM;
+	}
 
 	j = 0;
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
-- 
2.34.1

