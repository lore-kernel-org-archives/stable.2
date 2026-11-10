Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312285;
	b=rNOMGYoQFGM27gv4llvk+cMdVMD8LB8YiWyZwMuCoXw8EZucC0yyZQXAdvp33wwcz1iD
	 6w3czMFwVOfATpQIgiSwmof5aBVWzqEwFBCncTQty3Bg/5QDDPOFyL8zyrKhNRj3pBGp0
	 sjxE5SH1tIrhVOekULg2MaAdspz5UNRF2zxzKSQvd+t89gwzPfomasUw73/9hy8lLOVlh
	 y8EtAu07D5qyhSIP7k6QEp9Lnm6FyggBEdykL49zWWoYpbWKwyaku6W4nNZh6l0eHpGYd
	 4ralHHaOY2f00Bc2zwNlCQDzz8kQBdvEhnMlhJj/aSJpHm8E7m1rOqPp1UT1rxj+WgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WVHXz+Von5zYy+bZ4K2Yu9G1gfTaKeOahd1y8MWzxRk=;
	b=BmbX2mMdQFTZdijkG6AmL56Xt4rv9MeNo+l5bjsI2EOZ/0uw17fwsWlG7yFeXIPpKe0w
	 duOrW8e/WthodSOX85kwdQJmukRCsSSbMAI2VP5YiNdcDssz8eHS5iz8VNj0yrC0ZfvRr
	 6XveOs9j310hHjGGyUcyu/AKIeTM0ejNaO9ha5vW4oVBpwtOvWbuBsTHXHBHH+DC3MeaU
	 tnJmxHsJFR/aWV2LGRCtjoNYJhHUzYOQdkC/IbXLqkN/xRaMKw+9AyPuZm7p1BtnpmuTn
	 yagSaHMsA3OB4NpVw1PeDtPg56Y0krXOVXufvPQFwcoWz6gB+qxVGC78iyFmAFbLhvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIVaVm6Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4E606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIVaVm6Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AED1F008A2;
	Tue, 10 Nov 2026 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312284;
	bh=WVHXz+Von5zYy+bZ4K2Yu9G1gfTaKeOahd1y8MWzxRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIVaVm6ZGgMKHRmtURhLduVqARtaxdSjj0JnSrZckpgs3l6eXkT7yVzpp2dyQF4t6
	 Vdrbo5RgNREyJHjLSTgDqLcfML4WrdzZ/mIeZqcYDaqCzQgpGCzZwow2VenJrrgvxB
	 PXiJGtq2oiLLnz3zADE1azj0VNiIh/RmtKvZbH8i/39B7CsZbnkRZJuTVodfLfy46W
	 5xuqWEwBijLSpSF9IJVLevJ2jRwdAM2dQQOnsxtDwtp+pq2pJ7ycSucm0H87XWnZIS
	 j2yeup45KUNjh8AONRHxcicUUuzPG3YbLTzT/cc7QjkbWwMz1HOgsGJovRWmgQKi6L
	 8uOpcKASeewVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] crypto: omap - convert from tasklet to BH workqueue
Date: Tue, 10 Nov 2026 07:04:41 -0500
Message-ID: <20261110120434.957099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052926-failed-6.6-5d69ed4cd4f9@kernel.org>
References: <20261107052926-failed-6.6-5d69ed4cd4f9@kernel.org>
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
index ed83023dd77a8..bfeed72773984 100644
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
@@ -1280,7 +1281,7 @@ static int omap_aes_remove(struct platform_device *pdev)
 
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
index c5e7064be9c55..375d756efbfba 100644
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
@@ -1092,7 +1093,7 @@ static int omap_des_remove(struct platform_device *pdev)
 
 	omap_des_unregister_algs(dd->pdata);
 
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
 
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index a6b4a0b3ace30..17b61e1770bd6 100644
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
@@ -1716,9 +1717,9 @@ static struct ahash_engine_alg algs_sha384_sha512[] = {
 },
 };
 
-static void omap_sham_done_task(unsigned long data)
+static void omap_sham_done_task(struct work_struct *t)
 {
-	struct omap_sham_dev *dd = (struct omap_sham_dev *)data;
+	struct omap_sham_dev *dd = from_work(dd, t, done_task);
 	int err = 0;
 
 	dev_dbg(dd->dev, "%s: flags=%lx\n", __func__, dd->flags);
@@ -1752,7 +1753,7 @@ static void omap_sham_done_task(unsigned long data)
 static irqreturn_t omap_sham_irq_common(struct omap_sham_dev *dd)
 {
 	set_bit(FLAGS_OUTPUT_READY, &dd->flags);
-	tasklet_schedule(&dd->done_task);
+	queue_work(system_bh_wq, &dd->done_task);
 
 	return IRQ_HANDLED;
 }
@@ -2075,7 +2076,7 @@ static int omap_sham_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dd);
 
 	INIT_LIST_HEAD(&dd->list);
-	tasklet_init(&dd->done_task, omap_sham_done_task, (unsigned long)dd);
+	INIT_WORK(&dd->done_task, omap_sham_done_task);
 	crypto_init_queue(&dd->queue, OMAP_SHAM_QUEUE_LENGTH);
 
 	err = (dev->of_node) ? omap_sham_get_res_of(dd, dev, &res) :
@@ -2216,7 +2217,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.53.0

