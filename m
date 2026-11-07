Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050111;
	b=UgxTzdPCq3xAeVNClPTUig57YGh8TsXKhUucC0UcvsiTU8Me/QIo9M13onJqHmXFt9oR
	 8TwEtD3vy6SqZ70ckVApXeGyd258+I19wpO0Sw/1f2MKqwL2TQYp7Wu2awqsg5Umk0Vsi
	 PlA7dOEz9GpQC7LZIVCbEJ3RiWpp3HXly8ST7FNd4PzQKpYCr8Hq3Otah1lta8kCPWVCa
	 HJUBUC2mDH4/zr7j2wdn2WIDuFQTIWBCxnKdyq+OsPEoUnpWpfDdFJFaHxm65iakzWUEu
	 oe/JzUHlgrKRF7jvDHRF1Qgz/i+fsZYF5IcRZC2Ac2dVOIKruczTzVIlUHqDg8Y9tgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050111;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G22o/ALH1SnPSVcNRw68FxgB1RUOO9X/2bVXUZ62t/E=;
	b=FuTTOS+kHh3akFrRPHNfzhQnFsGrdVtjWEzLu8oppKWr6LjfZr+EFlV1l/4/kXygsWUn
	 rHjuMvGMSy0uTIa8NdHaXD6z7KtPvuOz7ujLJul58SM2ERjRNiNqlG+P8GNAw+gz+hAWF
	 fd1eUhCLeuKKrL1bIr9bJkwQxk86tkgD9bYwpbJp5zaaSMVA0NvJyY9xhpNf47Linjp2R
	 lCN1xDUHxpEo65Uk8pXLB0ZFKzBqzGJorbekZVP6PiuPgcher+JN9DIPBNzqnDFAayQXc
	 uanY+OaQvnEkK0M+38UNEn57812nXg5WdslDHm48ZSQOijfHqq2sk1rNMvBxN2h647A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbfD8ouV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7335606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbfD8ouV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204221F0089F;
	Sat,  7 Nov 2026 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050110;
	bh=G22o/ALH1SnPSVcNRw68FxgB1RUOO9X/2bVXUZ62t/E=;
	h=From:To:Cc:Subject:Date;
	b=lbfD8ouVQnFpaZQFNoxAAPCUiKo1za2J+WQfuX1vSy3ftaPUPYsvfoWkz4Ob1uhuV
	 5rC4KGQ23DYuyvZ609A2etQEs0bErtm2K676VHhnKNoOoI1QDTV/vY0Pj21A0I/g8I
	 Uycfws/R+lO+9Wmei/bzmhsit3zTYJ1lnYgbc0inz1YgiXySgzkrjgh+hit0Fs7wt+
	 kofB2REonuD8IiIA+FFITO16JR7gO/gAOHU5ah/BkpTeKOQ1eRjzL/9eX543WQzP3g
	 vyKbfo1r/cuzJwHe9pgasBIqVZBI4a+01JqDMCGsPWqO1alv6FVdFg+82VIYASlXlS
	 8B8Zu/VGR8PUg==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: disable histogram and flush AWB work on teardown" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:08 -0500
Message-ID: <20261107061508-failed-5.10-00d87c379915@kernel.org>
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
git cherry-pick -x 00d87c379915a3689b2488bd37f490875d79e20f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061508-failed-5.10-00d87c379915@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 00d87c379915a3689b2488bd37f490875d79e20f Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:01 +0530
Subject: [PATCH] media: microchip-isc: disable histogram and flush AWB work on
 teardown

isc_stop_streaming() and the isc_start_streaming() error path dropped the
runtime PM reference with the histogram still enabled. A HISDONE firing
just before the stop, or a failed isc_update_profile() on the start path,
can queue isc_awb_work(), which reads the histogram registers before
taking its own PM reference and faults on the unclocked device.

Disable the histogram, synchronize the IRQ and flush the work before the
device is left unclocked. isc_configure() is the one enabling the
histogram and then calling isc_update_profile(), so do the cleanup in its
own failure path; isc_stop_streaming() does the same on teardown.
synchronize_irq() must come before cancel_work_sync(), so an in-flight
handler cannot re-queue awb_work after it is cancelled.

Fixes: 93d4a26c3dab ("[media] atmel-isc: add the isc pipeline function")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/microchip/microchip-isc-base.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index debbc38717de1..0f486dd5bd82c 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -289,6 +289,7 @@ static int isc_configure(struct isc_device *isc)
 	struct regmap *regmap = isc->regmap;
 	u32 pfe_cfg0, dcfg, mask, pipeline;
 	struct isc_subdev_entity *subdev = isc->current_subdev;
+	int ret;
 
 	pfe_cfg0 = isc->config.sd_format->pfe_cfg0_bps;
 	pipeline = isc->config.bits_pipeline;
@@ -321,7 +322,15 @@ static int isc_configure(struct isc_device *isc)
 		isc_set_histogram(isc, false);
 
 	/* Update profile */
-	return isc_update_profile(isc);
+	ret = isc_update_profile(isc);
+	if (ret) {
+		/* flush the histogram work before the clocks are gated */
+		isc_set_histogram(isc, false);
+		synchronize_irq(isc->irq);
+		cancel_work_sync(&isc->awb_work);
+	}
+
+	return ret;
 }
 
 static int isc_prepare_streaming(struct vb2_queue *vq)
@@ -425,9 +434,13 @@ static void isc_stop_streaming(struct vb2_queue *vq)
 	/* Disable DMA interrupt */
 	regmap_write(isc->regmap, ISC_INTDIS, ISC_INT_DDONE);
 
+	isc_set_histogram(isc, false);
+
 	/* let a running IRQ handler finish before the clock is disabled */
 	synchronize_irq(isc->irq);
 
+	cancel_work_sync(&isc->awb_work);
+
 	pm_runtime_put_sync(isc->dev);
 
 	/* Disable stream on the sub device */
-- 
2.53.0




