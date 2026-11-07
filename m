Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048086;
	b=yLUnkUWYOFmXBoVRnn639/csB8oNEaanYK90RPftXKIcEJJn5RKXCmwHJAGF/9gjxvEd
	 Lt/sU0xyVedCXMIf+6hsFiE+XRQbXm9hCG5QewS9U5YZ2O01BrDJwdAv9c4jaL5OOd0dP
	 ThhIGYmT693AtEZUiYBPfQfOBzRNguYTIpXOKYhQuOPeYGnXVZaY8wYNL81K+2MFkOhLT
	 vpjkLOCVHAzCKCPt9vQ4/c8U4uGb2YSpPVf8QEkok11zmD4HPTH7JhzqO1ivQHVzYQXV6
	 0g60q0nrmxpql+PJNM2f8kevDB9wJpCAfNJd9wCjnozfAr2lrbaxxHXBllgnEiUOLsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qg96wW43tu+XVP0XecPAWI2W0u14Gp2r6ygEaU9xyio=;
	b=XxTLFQWFp/n2MTXQtoFhaDmxu8SB8Dm0V+KrHgIvCsFdCLJ9ItEzoKpbXuCIlrzzuOfS
	 Pa5cgnepiEg904dbdJgpzA/ZEpHIHX2xl1HG8Nam6vAH8CXkEq4xR2q+6LrGdvnUnpIt7
	 UWH4c0qjqkl+Hi6wYF/K9aK2SBeh2qKQfG4S2DWnMh6crPyJvlEztjUFmNoff6VXPOYPM
	 Z6ZDw34Snzjmp4HFK9Ny0kSX78fmTKAEZQ9AMFirh2KufCiAIF1tOlgZukHKdDAszinKw
	 j5gxTFD29lkdzN01Pt+7fXVs/ngAM29tkZ7TNaMhGWvbf6ZnuGobHJaJZ9X6beq3lDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbJdKvBs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A4606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbJdKvBs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84EB1F0089F;
	Sat,  7 Nov 2026 10:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048086;
	bh=qg96wW43tu+XVP0XecPAWI2W0u14Gp2r6ygEaU9xyio=;
	h=From:To:Cc:Subject:Date;
	b=dbJdKvBs6FLBQ2sKmcoXVMyY7ssupA1bq7HBLxPpfy8L3o1YfOWwSBd3dUKY+109W
	 IkljiYHxAFyE0S9TACOxJ4EbWvu8WaBk8ZZyIli62tQDAHMHpMRSqWcnNxTTCQGlnA
	 cPcsrMfQPJF6qw1eWQv2apZHU9V61Y+dAtI4NGriRGE9gIWaqACWXSlWifboP+cc1L
	 Eze3uaXdxTCVeByP1qL1fFTTESXHqKq53IUQqdFldNAHuvRTBXAH7TRstxWEnyAhCm
	 F9SFuxd/oxXluwDIm3620sr8+qb6kZl9bPUE3iUxkcpMMKNhnZzJ8H6LVYRq5Z/r06
	 I1Uj2+5fxCSVQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: synchronize the IRQ before disabling clocks on stop" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:24 -0500
Message-ID: <20261107054124-failed-6.1-19fa5407da5e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 19fa5407da5ef3e605cacfcd90f70d8b2c121cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054124-failed-6.1-19fa5407da5e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




