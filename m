Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285441;
	b=j/ytDr1pRf4XCep6xeXvGDH+Ub7ZEBj+rfBZKp+C8TRb8NBeTrSHXAYJSIQ1YFmc08GP
	 RIH/KLz9ilsqQFVjKOzNGRMVoXWuImQnJkE37EJHgBGwdspOxMdjnXJIeWDkWbcKbB+6I
	 mnlX0uco/shZPMW6myCtflFE3SbcrdPppLAsV6MXWYskVRUUkOZ/uT8HVvHcj6tCxMAzK
	 PUsrT9JChyXZnQeIX8h0foxBIvMDBa0KoEZU1LEKk9jVuaXcjtPrYQhNVal+03OYP24D+
	 LJcKC53RWCocctdGKi+i4NCeU4BM2mP3aA6SacdwaglhTRxu+mBr/rpqhuUnxyFZBSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285441;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Chv+eLn4gEETO/7ROGEtaL7hwyIl396jyh8nkt40Z3E=;
	b=IoLJO8ykxncojKladHbAaqnLzc16+9J1k1iE6nVdN33ucJrWOqKbOeqTnxPuC4Dz35pf
	 YHzOERzo/A62Nc7jWOVRfKp1acble5zFkGCWAjye7OOK6JI3vTqu3ZCX0rNgaS30WlQpO
	 YXeyQ5cMg429ivBHf7YEpA9HvBXaJwBJf8NhHKdk+haU4mx8jAWjzxWpUZPYRDMd396OG
	 QpzylMo++x+sNjRYnVeBp5nLKPMvny1ri9BL4mUippTuVga3cRc8aFKLUjk1UAZNu9Lg2
	 dVwwtiiY75fKTmmrJEYDvsiVluigIwAZ7k9Qmhpo/umwTmtx/2nhAsih1gqc1eWbnpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwOqF9tc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30328606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwOqF9tc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731C1F0089F;
	Tue, 10 Nov 2026 04:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285441;
	bh=Chv+eLn4gEETO/7ROGEtaL7hwyIl396jyh8nkt40Z3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwOqF9tcdkNQTsEqGsEMJLgQmNSVAGahGwRW/VxR4FD3oRCYm0+SJezzN0v9DJBpj
	 gjvmlSOIjZG7kIT2CyD1GvNGJUchY3dXXKGH/n2m8nIkZtcq+/V6fGOMTI9RxR+wP7
	 6o1gnJDlO5jibPhFqXXyCYqGWqAt7SN9B0gJ+kHzzOHqlDpY5bDzZSDou5RqzTOD7n
	 X8HeX7EagxIcIsGRg24lNRZnaXuk0yFfVg6uyLr1615gO1neWFMGmhUdbhQcHLJ3QF
	 GPx7cwmFNzWHCiTkvmGuGAdQ6O1uYrSNgLvjC/tsFlDcxyabkRbYEE8UwXDvS9f/2b
	 7P9ksxqCBLcWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: microchip-isc: synchronize the IRQ before disabling clocks on stop
Date: Mon,  9 Nov 2026 23:37:18 -0500
Message-ID: <20261110043702.334033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054124-failed-6.1-19fa5407da5e@kernel.org>
References: <20261107054124-failed-6.1-19fa5407da5e@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit 19fa5407da5ef3e605cacfcd90f70d8b2c121cd7 ]

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
[ sashal: adjusted context for existing Atmel driver names, including isc_interrupt ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c    | 3 +++
 drivers/media/platform/atmel/atmel-isc.h         | 1 +
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 9e91e4d948a24..36864f0b36c04 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -422,6 +422,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index ff60ba020cb99..7d2e7825cfb00 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -269,6 +269,7 @@ struct isc_device {
 	u32			dcfg;
 
 	struct device		*dev;
+	int			irq;
 	struct v4l2_device	v4l2_dev;
 	struct video_device	video_dev;
 
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index ea3e8b86a7f31..5dec061a6e733 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -421,6 +421,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       "atmel-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 4bc2f5c7f2f7d..e3513e0617ed6 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -410,6 +410,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {
-- 
2.53.0

