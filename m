Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794293286;
	b=QBTdX4eoPyrEQiLezX1sEeVaQc2xIyOK6XbYgmZ8pUTXcFJPbZMIX9Ox5JNQq5nhhJh4
	 vI2m/F9OdYNMRFtEMFP4b8Z29NzRj87qY8puOM7xt1N7Kq5MNDPzFo0bguDztm2Zmf8uu
	 pIsgArMFRib4i2fjv29wGowtaGlmF3EhCYjoTb3yCEgjnCSUFgcyWyzIEbgNeGL0WffSe
	 H6vcb1rlUT0B+nUSDiwfQMozTH+Z3h3HfRqz1PHPrfui6e0VyA4D5YLu0ll5I2sCNQQ84
	 L4RPgCb2d1imNr7Oe73/6or48xQLfdejCHtVyOdanh/pKU5piLJsRszkbKHFPue6Iiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293286;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XEP5cPOB/ypvajaTC1SW3ym7omircdzLkGXym068fSM=;
	b=Q+kRQtVvJor/2qJNSmra0j/Gmwirq69nmtS0FK7oiHqQuqUyINELiub4TdAiik14P2D0
	 LM73Pp5U8VOyY3XC1t2n0qfa1+wvRMsu1yB9jCT7TlZKqkRRFuDq5/PwvUr5v6RtJvZ1q
	 2t5ptwBMypKidDx5kRNrUjtsZMEz0G14AOXlaThEyuGwYzK/nyocNcX8zcyYSLrQqIYMr
	 k8sa+JhWP/cji7aMeTeRPaufyllYk49DedP/ycl2g/rDXGiLi6E+Da4aUQBmcnvnFS4K7
	 3BcESaTY7I4pVC7mZfSM4Gj/y8J69tSLh/NrgWHvhp7ybG4BVFGIdO78Yeev0AaZeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfbyhKva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FD606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfbyhKva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039431F0089F;
	Tue, 10 Nov 2026 06:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794293285;
	bh=XEP5cPOB/ypvajaTC1SW3ym7omircdzLkGXym068fSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AfbyhKvax9Wqk2SxUO7fHyFyxXtjcuhdNKseoeeYCsI+LZsE4MdpZW309N9rA1vxX
	 JoR5QlovhjGyEUDM5cNq0yLrHGk8eNMWSkn05FEfVeAgMcnvYI8OgK0kvjJZ2g6l+x
	 CvKMNpwdRVLz4WvKaAve4gp42hzs2jcG5eG9P3Uauq7SUYf4XzRDnLbHS0v4cCzI/d
	 Zu+6G2r0zYZX82qBoHokUy7RcVUe/vFrU9SmKRv83siez7OHFEklqarKYw2NU63zZ4
	 ZQvF4aR5hkqcs2EkCMSzqmHDaq5yYc/ZNI2I060Jw2yxkVjRvhqqm3Prec5zIGWHLL
	 FhF7d7U5zvZxQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: microchip-isc: synchronize the IRQ before disabling clocks on stop
Date: Tue, 10 Nov 2026 01:48:03 -0500
Message-ID: <20261110064745.457723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061455-failed-5.10-19fa5407da5e@kernel.org>
References: <20261107061455-failed-5.10-19fa5407da5e@kernel.org>
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
[ sashal: adapted Microchip ISC changes to the older Atmel driver layout lacking SAMA7G5 support ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c    | 3 +++
 drivers/media/platform/atmel/atmel-isc.h         | 1 +
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index fe3ec8d0eaee3..134bb240aca2c 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -870,6 +870,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 24b784b893d62..7c4956cf5a4af 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -194,6 +194,7 @@ struct isc_device {
 	struct isc_clk		isc_clks[2];
 
 	struct device		*dev;
+	int			irq;
 	struct v4l2_device	v4l2_dev;
 	struct video_device	video_dev;
 
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index a3304f49e4997..9a63c447aa325 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -163,6 +163,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       ATMEL_ISC_NAME, isc);
 	if (ret < 0) {
-- 
2.53.0

