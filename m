Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311927;
	b=0P/r9p8OssKhwrXJI20Uxd7cZSUQyW/HCy2P70BHj8mQsbumpLPMkiGj2MiLv7kctBSV
	 UznufMLv6e0C1dKlpe8WR+pALfk4DfA2ZMovtFYsJMQC+gsuQZZhWtR7GJfLWR3AV3kT7
	 acYz6+GCOfCX9Y9tUgAwVEyiL0izj5kwELLceUSShWkxg9DgCaYV0tAZn6zOJk1eBk264
	 9vXfE8mX4mTKNLf81tjWHPNByUlBhyHhcQiMX4CekJPRQ0/KtnTq3z9QmpWm3LFgMFyRt
	 lNGkW4Z3XeP+jrSCS6Q2OiPnH2U21kmUY6KMw1mwUiUvNArBcYCu4d82x6fdHISacjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vk6yMEhEgD8BzTT00OL3DdtwIuY3HvPNRkUKFmklwHc=;
	b=Bds+NSyaty1OKKZiqgCBEBAsNX5LFrpMTL63zRZP5+qnZfvi2e9Sdo9gWZmzbnkasZYR
	 85nvaSY7nLDyOAlVuMUfIE3gExONFx35XuLg6+j55iDHBNeooDVWXn3BZwKHBBnVs5XDX
	 gak8U9axcz7bfs0V5oFGxDFLe+2z9TXvtSbkWjDgij8Vn8DSmuA37iaUSwpLOimHi1T48
	 Z7/kxHompYHSMeUL3WRnxrM+k5wR0p5quxsDAH1iGnG1PWbeN1F/CdTwQr+LudVeS+J8W
	 7/jwwRBnH8PsLoOb6oladYT0G0ZQb+1JczHRjRS7uZMqHbp1FHH881d3S1UW0nJauPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Da0BvyBa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5A606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Da0BvyBa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D0B1F0089F;
	Tue, 10 Nov 2026 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311927;
	bh=vk6yMEhEgD8BzTT00OL3DdtwIuY3HvPNRkUKFmklwHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Da0BvyBaAvYVSk93aXWWvZZsQi8ZnoBVYjPeMJeeHGDxzyCDnzRFzx27cn7Nc5+jf
	 pu7m/2wlqHlSw1j1pP8NOs88IUjfV398aZDZnv8dikrcN0OLzZbk38oMza4HbDAeL7
	 pzl6gj2kmQc2PmhYgCiirXGHs6J4n+5UCVjmmx9U3KwR+hp1x1lUf1s3YdU4Sz9bi5
	 HUF2gOgzSlBe79mbTMA6ViiUmTZjhZdVyUav3grzgb15y8kiDxHPFw70UcLeb6gijG
	 mpqqG30baKl+NX2Jk9bUCaL6KNtyJyn16v66kJp6qFGiiUqnCaTtpTLtDFhPdWrfH+
	 y24w6YZBV272Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] crypto: omap - convert from tasklet to BH workqueue
Date: Tue, 10 Nov 2026 06:58:44 -0500
Message-ID: <20261110115837.921428-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051710-failed-6.12-5d69ed4cd4f9@kernel.org>
References: <20261107051710-failed-6.12-5d69ed4cd4f9@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <ryotkkr98@gmail.com>

[ Upstream commit 381e8ee368234a51b3a4f231f6f24ff0b09d9f9e ]

tasklet has been marked deprecated and it's planned to be
removed. Make omap crypto drivers to use BH workqueue which
is the new interface for executing in BH context in place
of tasklet.

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: 5d69ed4cd4f9 ("crypto: omap-des - fix crypto engine cleanup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/omap-aes.c  | 15 ++++++++-------
 drivers/crypto/omap-aes.h  |  2 +-
 drivers/crypto/omap-des.c  | 17 +++++++++--------
 drivers/crypto/omap-sham.c | 15 ++++++++-------
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index bad1adacbc84c..df2fc4e1c31d9 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "omap-crypto.h"
 #include "omap-aes.h"
@@ -222,7 +223,7 @@ static void omap_aes_dma_out_callback(void *data)
 	struct omap_aes_dev *dd = data;
 
 	/* dma_lch_out - completed */
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_aes_dma_init(struct omap_aes_dev *dd)
@@ -496,9 +497,9 @@ static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
 		((u32 *)ivbuf)[i] = omap_aes_read(dd, AES_REG_IV(dd, i));
 }
 
-static void omap_aes_done_task(unsigned long data)
+static void omap_aes_done_task(struct work_struct *t)
 {
-	struct omap_aes_dev *dd = (struct omap_aes_dev *)data;
+	struct omap_aes_dev *dd = from_work(dd, t, done_task);
 
 	pr_debug("enter done_task\n");
 
@@ -932,7 +933,7 @@ static irqreturn_t omap_aes_irq(int irq, void *dev_id)
 
 		if (!dd->total)
 			/* All bytes read! */
-			tasklet_schedule(&dd->done_task);
+			queue_work(system_bh_wq, &dd->done_task);
 		else
 			/* Enable DATA_IN interrupt for next block */
 			omap_aes_write(dd, AES_REG_IRQ_ENABLE(dd), 0x2);
@@ -1150,7 +1151,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_aes_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_aes_done_task);
 
 	err = omap_aes_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
@@ -1245,7 +1246,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 
 	omap_aes_dma_cleanup(dd);
 err_irq:
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 err_pm_disable:
 	pm_runtime_disable(dev);
 err_res:
@@ -1280,7 +1281,7 @@ static void omap_aes_remove(struct platform_device *pdev)
 
 	crypto_engine_exit(dd->engine);
 
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	omap_aes_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
 
diff --git a/drivers/crypto/omap-aes.h b/drivers/crypto/omap-aes.h
index 0f35c91647648..d999d94e2314d 100644
--- a/drivers/crypto/omap-aes.h
+++ b/drivers/crypto/omap-aes.h
@@ -161,7 +161,7 @@ struct omap_aes_dev {
 	unsigned long		flags;
 	int			err;
 
-	struct tasklet_struct	done_task;
+	struct work_struct	done_task;
 	struct aead_queue	aead_queue;
 	spinlock_t		lock;
 
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index d2c016eafd46b..096df577fe127 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -33,6 +33,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "omap-crypto.h"
 
@@ -133,7 +134,7 @@ struct omap_des_dev {
 	unsigned long		flags;
 	int			err;
 
-	struct tasklet_struct	done_task;
+	struct work_struct	done_task;
 
 	struct skcipher_request	*req;
 	struct crypto_engine		*engine;
@@ -328,7 +329,7 @@ static void omap_des_dma_out_callback(void *data)
 	struct omap_des_dev *dd = data;
 
 	/* dma_lch_out - completed */
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_des_dma_init(struct omap_des_dev *dd)
@@ -584,9 +585,9 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 	       omap_des_crypt_dma_start(dd);
 }
 
-static void omap_des_done_task(unsigned long data)
+static void omap_des_done_task(struct work_struct *t)
 {
-	struct omap_des_dev *dd = (struct omap_des_dev *)data;
+	struct omap_des_dev *dd = from_work(dd, t, done_task);
 	int i;
 
 	pr_debug("enter done_task\n");
@@ -899,7 +900,7 @@ static irqreturn_t omap_des_irq(int irq, void *dev_id)
 
 		if (!dd->total)
 			/* All bytes read! */
-			tasklet_schedule(&dd->done_task);
+			queue_work(system_bh_wq, &dd->done_task);
 		else
 			/* Enable DATA_IN interrupt for next block */
 			omap_des_write(dd, DES_REG_IRQ_ENABLE(dd), 0x2);
@@ -1009,7 +1010,7 @@ static int omap_des_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_des_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_des_done_task);
 
 	err = omap_des_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
@@ -1072,7 +1073,7 @@ static int omap_des_probe(struct platform_device *pdev)
 
 	omap_des_dma_cleanup(dd);
 err_irq:
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 err_get:
 	pm_runtime_disable(dev);
 err_res:
@@ -1092,7 +1093,7 @@ static void omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
 }
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 5bcd9ab0f72ad..d17654c0410f6 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -37,6 +37,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #define MD5_DIGEST_SIZE			16
 
@@ -217,7 +218,7 @@ struct omap_sham_dev {
 	int			irq;
 	int			err;
 	struct dma_chan		*dma_lch;
-	struct tasklet_struct	done_task;
+	struct work_struct	done_task;
 	u8			polling_mode;
 	u8			xmit_buf[BUFLEN] OMAP_ALIGNED;
 
@@ -561,7 +562,7 @@ static void omap_sham_dma_callback(void *param)
 	struct omap_sham_dev *dd = param;
 
 	set_bit(FLAGS_DMA_READY, &dd->flags);
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_sham_xmit_dma(struct omap_sham_dev *dd, size_t length,
@@ -1704,9 +1705,9 @@ static struct ahash_engine_alg algs_sha384_sha512[] = {
 },
 };
 
-static void omap_sham_done_task(unsigned long data)
+static void omap_sham_done_task(struct work_struct *t)
 {
-	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
+	struct omap_sham_dev *dd = from_work(dd, t, done_task);
 	int err = 0;
 
 	dev_dbg(dd->dev, "%s: flags=%lx\n", __func__, dd->flags);
@@ -1740,7 +1741,7 @@ static void omap_sham_done_task(unsigned long data)
 static irqreturn_t omap_sham_irq_common(struct omap_sham_dev *dd)
 {
 	set_bit(FLAGS_OUTPUT_READY, &dd->flags);
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 
 	return IRQ_HANDLED;
 }
@@ -2063,7 +2064,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dd);
 
 	INIT_LIST_HEAD(&dd->list);
-	tasklet_init(&dd->done_task, omap_sham_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_sham_done_task);
 	crypto_init_queue(&dd->queue, OMAP_SHAM_QUEUE_LENGTH);
 
 	err = (dev->of_node) ? omap_sham_get_res_of(dd, dev, &res) :
@@ -2204,7 +2205,7 @@ static void omap_sham_remove(struct platform_device *pdev)
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.53.0

