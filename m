Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050098;
	b=epvBn5wOq5MewvlxgE76h348Sa+mQWlvdQb3091GBBN1j9vIZtrcXFE1cy/RwJN8r9UI
	 Bm/ej7G93+Y1b+QFGlabfUb7iAQqKeVY6e+oyokutzFba+9e8r7AuiBzEZRtg/Y6JQ8Hs
	 UJ3CFGr1QVX7fArbpaMZ6HN1y3nlfxmTYnan7We2FU0oVdKwH9sBcfbJDL2RoIEwNNa27
	 0ZxJ4COuw9RVPbog94SSyoS3LrLMI0vmY2i65yCMbnaoFYUmhofs9Jn+fsg7bUrRw5IRY
	 CKfXVTPM7cryWyqTcHBBEY1Vqe3pCIqKU8AsVxVmOg+VPRNXg6j+gmer5d9vjgDcv+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+tEXvv1WE+El0cWzx8oD/kg1VVmzFPR7vZ+cMA2jRdQ=;
	b=fUt06UtlH/LmVA5nECXL2vIlfA7s9JE+sNFiQwc2WNpJR908LSSjm1Q4Rm9+FTXxrupF
	 QqDXsUa62T8DqytSb7YFk1GH5Ek6LQdeDzu+uBhCHvUTLPGa/8K6stIwYiaFPtddj+lzc
	 F2eT9JCSBOplfAI7Hf8tEQbjoWyY3w0lAskIjuBKcKKVY9aQtd+t/5vlp3EqKFq1w1Pk3
	 i4pOySHRyLGyuY22sjpQ/s/7CCDVc1AhTLU6sAW8yF325+mco7AdW5VyXeut+SiWIMnVq
	 laA4I0b1fdLAikNpLHHcxv2yj/eyYqa6p0zEqRUkgppeNr9BpMdm8tGv24XSrdwBSnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGezuZGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB19606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGezuZGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC71F0089F;
	Sat,  7 Nov 2026 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050097;
	bh=+tEXvv1WE+El0cWzx8oD/kg1VVmzFPR7vZ+cMA2jRdQ=;
	h=From:To:Cc:Subject:Date;
	b=JGezuZGCfik5H5W/CKSnIzh5cZaKGEoOWge9MhEv0nSWpAr8v2Xgv1BaBRjIo3ekn
	 2zPynwT6YajY4iZZaoGVAiWITHe8T/j58TxaWJQQu8w0eclPDd7q+nd9Bf4lwEf9Xh
	 uw1UeTsHofdZHN0FfGc7pvToeXxiV5XUTskeTcSxlpnM4K/FJyih98bRaCrw/VHmWX
	 e5AMkxR1CatdgIsXHpmeiWd2kGF0OMS5d5y4ZEYDf0gM6WXgfEYUoseTfT3k+HZXwO
	 WHlWD83fyITsyf6MIMoGpnqgLkq8/rDM2FjdQKnJMxJf00pUnEHSQVgg+VIsO9s38V
	 CkUnEllIL9RFw==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: synchronize the IRQ before disabling clocks on stop" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:55 -0500
Message-ID: <20261107061455-failed-5.10-19fa5407da5e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 19fa5407da5ef3e605cacfcd90f70d8b2c121cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061455-failed-5.10-19fa5407da5e@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 19fa5407da5ef3e605cacfcd90f70d8b2c121cd7 Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:00 +0530
Subject: [PATCH] media: microchip-isc: synchronize the IRQ before disabling
 clocks on stop

isc_stop_streaming() masks the DMA interrupt and then drops the runtime
PM reference, which disables the ISC clocks. microchip_isc_interrupt()
may still be executing on another CPU at that point; it reads ISC_INTSR
over regmap, and touching the unclocked registers triggers an external
abort.

Store the IRQ number at probe and call synchronize_irq() after masking
the interrupt, before dropping the PM reference.

Fixes: 106267444f12 ("[media] atmel-isc: add the Image Sensor Controller code")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/platform/microchip/microchip-isc-base.c    | 3 +++
 drivers/media/platform/microchip/microchip-isc.h         | 1 +
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 ++
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index ca4f3b5f58aa9..debbc38717de1 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -425,6 +425,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
diff --git a/drivers/media/platform/microchip/microchip-isc.h b/drivers/media/platform/microchip/microchip-isc.h
index ad4e98a1dd8fc..f5e322c2e36bc 100644
--- a/drivers/media/platform/microchip/microchip-isc.h
+++ b/drivers/media/platform/microchip/microchip-isc.h
@@ -287,6 +287,7 @@ struct isc_device {
 	u32			dcfg;
 
 	struct device		*dev;
+	int			irq;
 	struct v4l2_device	v4l2_dev;
 	struct video_device	video_dev;
 
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 18e1ec0b94fa6..5bd109e93a8fb 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -448,6 +448,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 07cfe1109ff09..d978ce448a4d2 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -437,6 +437,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {
-- 
2.53.0




