Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288314;
	b=XZCwQjJRBn1vcqApDmLbZQvXw2IR+vPNkG03saXSttI2Rq5tANQThsP338TIibrp3GEl
	 1xX6yxqV18CoguHa5weNhAgraBv5VTZEQYCw/BNDYvrPjz3fv5G1Qdv4tfUmFjFYH+oRZ
	 HTd+ui9RC2gnonDx1LB5PdsMMMqolFBKbxruF6QbfiBnrWq6ToM4+CaPxf8WhjMI7ZpVW
	 HUErLK8PNqb5a8EmRk1BfvKtDUxn/1SJd8m+yBc5thQgDvL6F+3IjRAxkAyP8utIJgUqR
	 Kqw+TKQwaH5+qzsoB4KtQu4xbJG96I65rVTg30S9/PGSSB7pjd1FE+dZcbNieg7/Jvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=glIKqPh2ZmGsID2Q6xqplCfDwcHNEoaEaNPhMemU0Ec=;
	b=KXa4eg5I4BRBOmDnklsTLgTn9JJw/DHqD6aO1ypAHi5an90ayjrCjLiK32kAm+dviD6J
	 Q0JylXymuXDyxIUFUO27lDvtgRzxY0hyTsFy28kwYB+5kE8gslDkWB2Po4JHbROT/dT1t
	 J7NZa88F+P5dkVOlT7ccwjXAWdzFwBjzSAWE7+PUDGCF6ZAJcb3Bz3qQQ3LoPQfqQ8zIu
	 Ct6hCbICs76j6QrRflRuW3MRgY7lW9vngS66K/2Rc8flRHNnbBjesplwxAE+okK6LRqNz
	 f75odmuO2dq082CBocH75ChuUC0UyxANNIz1Fu3ck+fDTFJPWDSSYTh6tIQsS9UExRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuhYaCYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuhYaCYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A93B1F0089F;
	Tue, 10 Nov 2026 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288313;
	bh=glIKqPh2ZmGsID2Q6xqplCfDwcHNEoaEaNPhMemU0Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kuhYaCYZuB8+FsX8FJGhNvt+9r+QXigpnxLiBkfWC8TctrBocjzI89qkYZwK6HnGZ
	 wawAmsht/3zw579AIJQDeelwMcM99n4esIPczj9B808WLmYpVC9tVxWUWaWobMGURQ
	 FJ8tvvIPfSkTTOPAM30tVuhIUZebVhVNKipNvt0m97qkZH2sa5+8MJOTiMdt+o4tHa
	 26bcr8SAFzI1N8GZqFd7/Z9y/gypK02GD92AY5tFVjG4MjXLDN0GsJ48znzfZehIrF
	 M3YNvZeVdtme38MAVUQgGLE3kzVeCPpMLo22ot02zhAajqXpkAPqEGy9Y8HJUy7A9G
	 BnCYCrTA8lb7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: microchip-isc: synchronize the IRQ before disabling clocks on stop
Date: Tue, 10 Nov 2026 00:25:10 -0500
Message-ID: <20261110052454.389809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055805-failed-5.15-19fa5407da5e@kernel.org>
References: <20261107055805-failed-5.15-19fa5407da5e@kernel.org>
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
[ sashal: adapted context to the older Atmel ISC driver naming ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c    | 3 +++
 drivers/media/platform/atmel/atmel-isc.h         | 1 +
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 ++
 drivers/media/platform/atmel/atmel-sama7g5-isc.c | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index eeaf91d80acd7..4d0164db30b4a 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -708,6 +708,9 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	/* let a running IRQ handler finish before the clock is disabled */
+	synchronize_irq(isc->irq);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 2bfcb135ef13b..f958da504dad3 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -257,6 +257,7 @@ struct isc_device {
 	u32			dcfg;
 
 	struct device		*dev;
+	int			irq;
 	struct v4l2_device	v4l2_dev;
 	struct video_device	video_dev;
 
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index cf96d40828ab5..5faa1c775f7c6 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -415,6 +415,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       "atmel-sama5d2-isc", isc);
 	if (ret < 0) {
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 3183ab2345c8b..7f0f635479bf1 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -408,6 +408,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	isc->irq = irq;
+
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       "microchip-sama7g5-xisc", isc);
 	if (ret < 0) {
-- 
2.53.0

