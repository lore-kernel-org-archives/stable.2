Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312855;
	b=abk11MfiVGzjcJHbCv13Q0tA3cCtCB07LaKRxkT+XCQ+7pSrBGm4SMOTCLL+pmZ2G1aX
	 e8h+2kCKvbWrrffhskhzEc8HeabeslA1C9EGXeJOHHX42X1CRqwVssOsMe+6HUtiRaQt8
	 UD1XI9MGTMO4UHQkc/ZymY+/J8z6HeCt68Asznijp/ZznLp/Ao14aECP8dGA1hA7naurl
	 86ezxBJbK/depzaaMEzEq5YbHaG2XYAwPV5IrGd0FSTNNb45RLfTfwDsgqElY80cQNWi4
	 mddp9zH/BMjyCXRHj1lEfTywpqC9qB5xsmL1i0QN4q8dvklc/l2oUYNvhCY4ldUxoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+ZB/fntpbfMHTWwSYh1PmErs7Sv491fhGDeqJSMSBuw=;
	b=cmJUcOSKktOMv7vx4l66a74TJcU5/Dm5yrUlO8pqpzuWhm+oNaYawXxCmxUceWmJmLC4
	 XzxVBbzxj2T+aSwhrOE5iJ3LFmNQ3KFlRG4LOtk8Fh+v7aRSmU6M3/P5uHFFqb42j3Eq6
	 dmassfdy0Bo8/k2ByUCAzudBip3xvSLzjI1dv+1YSzrYUGtqjRK09yVayn4w3ghbTK1yO
	 +ZJXGhWI9S91Nx7XlI701C2E8P1WLoZWpyubdkrjvTwnF2YqfqPHXcN5FTTz7BXxQgenk
	 SzseDbdRpfdUGXq21rDhUC5UcfBGkzSIM+JtAg4bwgorgZV+dzQLt9HLDQP4t+3QgUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xb2qorfF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C871606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xb2qorfF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD51F008A3;
	Tue, 10 Nov 2026 12:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312855;
	bh=+ZB/fntpbfMHTWwSYh1PmErs7Sv491fhGDeqJSMSBuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xb2qorfFrJoCo6dNFfw4T+RP5YniznZ78wGefHUVOwHGBLL9dAKVCao42kIJIdLou
	 ytx4R7X1q4AiZMiCQ3E4gTvLoNpZwcQ5w05cqLynC38++GmlhLrPAItLEQXM1FB1c4
	 xeIDxo2uDXiXUEOXTbvYCtbxydakiyw82DtbNrtzPvnxX9YetYKss9Yrt9aqvARWeV
	 k1P4c/MjTkkCoYG/fC1D7PeaPlvVLW+9GVjGwPwDTIdj5oArQj4zGgEl4ru4UWyl3s
	 ZNA30XWH7+PN5XoMeoK8uqAIwB9+/w07nChE4Q0OxoFUdGOtna1ryE8NxxmHxoGf5E
	 wF3uufv0nM6/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] crypto: omap - convert from tasklet to BH workqueue
Date: Tue, 10 Nov 2026 07:14:09 -0500
Message-ID: <20261110121355.981467-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121355.981467-1-sashal@kernel.org>
References: <20261107054209-failed-6.1-5d69ed4cd4f9@kernel.org>
 <20261110121355.981467-1-sashal@kernel.org>
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
index ea13312181058..42178f2b75f3c 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -34,6 +34,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "omap-crypto.h"
 #include "omap-aes.h"
@@ -223,7 +224,7 @@ static void omap_aes_dma_out_callback(void *data)
 	struct omap_aes_dev *dd = data;
 
 	/* dma_lch_out - completed */
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_aes_dma_init(struct omap_aes_dev *dd)
@@ -497,9 +498,9 @@ static void omap_aes_copy_ivout(struct omap_aes_dev *dd, u8 *ivbuf)
 		((u32 *)ivbuf)[i] = omap_aes_read(dd, AES_REG_IV(dd, i));
 }
 
-static void omap_aes_done_task(unsigned long data)
+static void omap_aes_done_task(struct work_struct *t)
 {
-	struct omap_aes_dev *dd = (struct omap_aes_dev *)data;
+	struct omap_aes_dev *dd = from_work(dd, t, done_task);
 
 	pr_debug("enter done_task\n");
 
@@ -933,7 +934,7 @@ static irqreturn_t omap_aes_irq(int irq, void *dev_id)
 
 		if (!dd->total)
 			/* All bytes read! */
-			tasklet_schedule(&dd->done_task);
+			queue_work(system_bh_wq, &dd->done_task);
 		else
 			/* Enable DATA_IN interrupt for next block */
 			omap_aes_write(dd, AES_REG_IRQ_ENABLE(dd), 0x2);
@@ -1151,7 +1152,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_aes_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_aes_done_task);
 
 	err = omap_aes_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
@@ -1246,7 +1247,7 @@ static int omap_aes_probe(struct platform_device *pdev)
 
 	omap_aes_dma_cleanup(dd);
 err_irq:
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 err_pm_disable:
 	pm_runtime_disable(dev);
 err_res:
@@ -1281,7 +1282,7 @@ static int omap_aes_remove(struct platform_device *pdev)
 
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
index 61288e4c05a33..63785adde7a06 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #include "omap-crypto.h"
 
@@ -135,7 +136,7 @@ struct omap_des_dev {
 	unsigned long		flags;
 	int			err;
 
-	struct tasklet_struct	done_task;
+	struct work_struct	done_task;
 
 	struct skcipher_request	*req;
 	struct crypto_engine		*engine;
@@ -330,7 +331,7 @@ static void omap_des_dma_out_callback(void *data)
 	struct omap_des_dev *dd = data;
 
 	/* dma_lch_out - completed */
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_des_dma_init(struct omap_des_dev *dd)
@@ -586,9 +587,9 @@ static int omap_des_crypt_req(struct crypto_engine *engine,
 	       omap_des_crypt_dma_start(dd);
 }
 
-static void omap_des_done_task(unsigned long data)
+static void omap_des_done_task(struct work_struct *t)
 {
-	struct omap_des_dev *dd = (struct omap_des_dev *)data;
+	struct omap_des_dev *dd = from_work(dd, t, done_task);
 	int i;
 
 	pr_debug("enter done_task\n");
@@ -901,7 +902,7 @@ static irqreturn_t omap_des_irq(int irq, void *dev_id)
 
 		if (!dd->total)
 			/* All bytes read! */
-			tasklet_schedule(&dd->done_task);
+			queue_work(system_bh_wq, &dd->done_task);
 		else
 			/* Enable DATA_IN interrupt for next block */
 			omap_des_write(dd, DES_REG_IRQ_ENABLE(dd), 0x2);
@@ -1003,7 +1004,7 @@ static int omap_des_probe(struct platform_device *pdev)
 		 (reg & dd->pdata->major_mask) >> dd->pdata->major_shift,
 		 (reg & dd->pdata->minor_mask) >> dd->pdata->minor_shift);
 
-	tasklet_init(&dd->done_task, omap_des_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_des_done_task);
 
 	err = omap_des_dma_init(dd);
 	if (err == -EPROBE_DEFER) {
@@ -1070,7 +1071,7 @@ static int omap_des_probe(struct platform_device *pdev)
 
 	omap_des_dma_cleanup(dd);
 err_irq:
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 err_get:
 	pm_runtime_disable(dev);
 err_res:
@@ -1094,7 +1095,7 @@ static int omap_des_remove(struct platform_device *pdev)
 			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
 
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 4b79d54fd6712..225368f10442c 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -38,6 +38,7 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/workqueue.h>
 
 #define MD5_DIGEST_SIZE			16
 
@@ -218,7 +219,7 @@ struct omap_sham_dev {
 	int			irq;
 	int			err;
 	struct dma_chan		*dma_lch;
-	struct tasklet_struct	done_task;
+	struct work_struct	done_task;
 	u8			polling_mode;
 	u8			xmit_buf[BUFLEN] OMAP_ALIGNED;
 
@@ -562,7 +563,7 @@ static void omap_sham_dma_callback(void *param)
 	struct omap_sham_dev *dd = param;
 
 	set_bit(FLAGS_DMA_READY, &dd->flags);
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 }
 
 static int omap_sham_xmit_dma(struct omap_sham_dev *dd, size_t length,
@@ -1717,9 +1718,9 @@ static struct ahash_engine_alg algs_sha384_sha512[] = {
 },
 };
 
-static void omap_sham_done_task(unsigned long data)
+static void omap_sham_done_task(struct work_struct *t)
 {
-	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
+	struct omap_sham_dev *dd = from_work(dd, t, done_task);
 	int err = 0;
 
 	dev_dbg(dd->dev, "%s: flags=%lx\n", __func__, dd->flags);
@@ -1753,7 +1754,7 @@ static void omap_sham_done_task(unsigned long data)
 static irqreturn_t omap_sham_irq_common(struct omap_sham_dev *dd)
 {
 	set_bit(FLAGS_OUTPUT_READY, &dd->flags);
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 
 	return IRQ_HANDLED;
 }
@@ -2076,7 +2077,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dd);
 
 	INIT_LIST_HEAD(&dd->list);
-	tasklet_init(&dd->done_task, omap_sham_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_sham_done_task);
 	crypto_init_queue(&dd->queue, OMAP_SHAM_QUEUE_LENGTH);
 
 	err = (dev->of_node) ? omap_sham_get_res_of(dd, dev, &res) :
@@ -2217,7 +2218,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.53.0

