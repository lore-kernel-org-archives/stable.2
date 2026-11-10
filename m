Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313362;
	b=vKAojijRReZPymXVRPlJVgNaunsawNNYh+EPb1NZ+zBwzzM5MqRQ3flJ6xYoSBdM6m7f
	 HFc5OC9XXha31CcODPf6tBKbmSQGZcWNgQt/GcSJ/QLRnI7xaK90Kdc9UoiNry5hTx1y0
	 sucPcavTzpj6MCHNz5sGYasOwvfQ4YZL2eaF6W0TGaswf1wLAKLDU9+zJRrLG9QwErqcn
	 9Dpnob32UHkwCECbqQGPS5NuJUZd6zTnHJwyBXSlGOZhNDnh3gCBpf5IebEQwuOwbuCzJ
	 3xs2Srg9VaVMpIj+v8dSmBNdSYqLPOes+leme/y1VkAnLewf/dDX2YFZUIf3IbDq0+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aBQzUcD2VZuOSXm3K3imhaEACYkpOOOs1PKzhIP6nzI=;
	b=Hxx5fSYMEp8Mn4mqh5Jjq8DL9xr11qwipnarxEYxKOxp5CVpz7yoGGU+2pQ30D8Zunw8
	 F3SlLip9Jtv0rgBC5bDecKsZCuEsVZmGq9ZB0PysJm8CrB8sx9CRBXNlYQU+bqx0rxl60
	 bRsdduRKeSlDKr82/yCbIhrqPO1ql3wiUPND9vA+dNr3qNIfaaM5ypAFR2mgu34xaYCLO
	 /tt8XHkr9s8DsRGACgWqK/N7PdI7qKmDWLdbZz///uEgwBwDiyk11+oVC2ubx2cg4Pqqa
	 0ag9crEaO9Cjha1FZ1sO33+EsHbvqpi5GvQVncH0la0Uy2C9HjgDaU+vR4uxNfWbb+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaealy1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF22606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kaealy1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13421F008A5;
	Tue, 10 Nov 2026 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313361;
	bh=aBQzUcD2VZuOSXm3K3imhaEACYkpOOOs1PKzhIP6nzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kaealy1O7FFWXyT1LS5q1sbHsRD7gxNxjH6NBAWJxusCa1nxWZAMgBZmtuXWIR0XV
	 BilIdFYYSBviWdoJm/FCiB0LV8gdi5ZCDHhzEDsJr7QRufmJ/spuoPVDKt00mmYCaK
	 dEbKOQhhnm8f7AxaWTLhbvSE0xKPQbIlsm6YiOWqBNv++mRwGfKvZIuNZa7uJVZIPz
	 +7b8I+heDu+ZQ6LdNZq56BFipkpNdkXdriaNDeHsir6fwiqRGV22NVuiII2CUb0W/8
	 2xZsEfyw6SMgA8Q4jcKmd2fsae/pjXZRLqz4HBOKQ4h/1V4v5IS33ixcNih6aRMrR4
	 hn2fmmnNZ6Cag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] crypto: omap - convert from tasklet to BH workqueue
Date: Tue, 10 Nov 2026 07:22:35 -0500
Message-ID: <20261110122229.1112116-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122229.1112116-1-sashal@kernel.org>
References: <20261107055909-failed-5.15-5d69ed4cd4f9@kernel.org>
 <20261110122229.1112116-1-sashal@kernel.org>
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
index 19f18743435f3..0596da18bad31 100644
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
@@ -1285,7 +1286,7 @@ static int omap_aes_remove(struct platform_device *pdev)
 
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
index b6ce47e282261..84e3e69a406fd 100644
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
@@ -1097,7 +1098,7 @@ static int omap_des_remove(struct platform_device *pdev)
 			crypto_engine_unregister_skcipher(
 					&dd->pdata->algs_info[i].algs_list[j]);
 
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	omap_des_dma_cleanup(dd);
 	pm_runtime_disable(dd->dev);
 	dd = NULL;
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index 471b4424ee0cc..cfa448732fc04 100644
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
@@ -2218,7 +2219,7 @@ static int omap_sham_remove(struct platform_device *pdev)
 					&dd->pdata->algs_info[i].algs_list[j]);
 			dd->pdata->algs_info[i].registered--;
 		}
-	tasklet_kill(&dd->done_task);
+	cancel_work_sync(&dd->done_task);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.53.0

