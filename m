Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049087;
	b=HjlvG3JhoN9VWuXlN9envlGmKkTVpfKbjDX1AzUwVQZBYoWCKOJGHbSIYrRj5oMpAAN3
	 UPIrpIAAy4GR2HDPcglUd5AxqYYWjk2qUXu67xTGCBluFb5ttiNe22uatqiOrkcndv5aj
	 SfSUyBbSCZiux0h/aQJhSgUEXXrkM54E+eY2pIxrW5t5VM9n86byeS78Sc2VsuJWgvDuh
	 8S1GCWtXy1QEwUw866pe3/fo0H8BrK618EPy7+rrIxnljfFXdAJvhBifB7uM0p/strb5M
	 U9yGi8I8T33mi34H39DU0yLtei+gGqYEpDXkv5N1JHTlL2vFvUuPIv7BNit4TfjIUgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BPm6BcRTo6amscd6+t+Q+ht+6hdmmcymsDcVcnn3Wzc=;
	b=3J9o/WO/lTjKOS0art20Q92sJwZ6ofvaNk7Te+8JT5HcA9VPWIeGwXxXKu63pBJAaIK9
	 cQ1ksnfuYvcol4BaugSRiHSUBXfQHABhpu4Uo9sq7Y768kpjDETg2bXGaEv/zgpONQ3MP
	 +mxe2PwDF+fpeK6ZnITExR/tH7RhXQZhkOyzTKN1ylztz6AgU3oYi4a3C4CqB5S/uoWvd
	 DmXHuiehJBZH4Mw81VHH+hY5LlpT1XBoZG5qskx13X1inkUdNW0+9esB9BUmQ2HaNbSgQ
	 Fr2/4FJLg5oUMpz1tjLr1wIETlvwqKgPU1cSAqJNDssgHTsgrCge4Zw4wOxnyXGP5Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEvDYTMv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEvDYTMv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28551F0089F;
	Sat,  7 Nov 2026 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049087;
	bh=BPm6BcRTo6amscd6+t+Q+ht+6hdmmcymsDcVcnn3Wzc=;
	h=From:To:Cc:Subject:Date;
	b=JEvDYTMvj+Wp3LNVhH8xGiJ0ZotuCG65eg804MGeDmyMcd6AOMiWyEuWV/Zuo7czn
	 gDKMO2Y/5xTrcQkVIG7Snxmlm9I6Z1Z/Zi9mLQj+YMFog1uReP67vPj/6uHZV9m4QE
	 gI4GYrWORXHGmKpKqb10Qa7KNzKnI/6smZ/jClZX1TknoKOqZz69Lpbxfhhii0Sgkw
	 KRZI0nykm41zqz1SST0pEuu5rcnXQZOomidyKFSiyd+aau/LIpy+yw7eHvAAUjKDWc
	 k6IrP8JfsfJWldudTbpWZJeBzqms9PTEjMyCOXuLIC5EuCYwhBCt72ydaj/U0a2pPa
	 LW/3D5DCGT2TQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: synchronize the IRQ before disabling clocks on stop" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:05 -0500
Message-ID: <20261107055805-failed-5.15-19fa5407da5e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 19fa5407da5ef3e605cacfcd90f70d8b2c121cd7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055805-failed-5.15-19fa5407da5e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




