Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048084;
	b=zGTeFGESrCBVobUZwyEdfWz3P4HD9CSCj8Go733VU7cR2e4yeBhFrtElfJWImDrq0vUF
	 e/r6REnqlcSCBz8jdeDPqzCCajIl8pfVouQ+udzmLguKFTUGYiLnMGrygqsmoripjCb4+
	 r/cm2STyJFG4JVGSLzW1L6N0F7N9a63Cf68rShT+zHC/BELiNqt/GrdPU8Lrj7HlEcAkC
	 Ky3//uOakJDMSdVvKIgk+TrX2F3PEgen/kGB4uhcYDUvpvwQwZdr8CB/iR/Bz/AatwRE6
	 Ah3c75d1FTU8+mYiCdwvow4x53ZzVCIOp2+pDpwgk178to62IV9RuuXXWI/rrWSrdGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048084;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nB2UJT/KZSIv9r73ED7mZispBAM7Oo5TSmJE1rtF8pM=;
	b=Z46e1vLvl7UGLtRUyf9mdaBtAYZ/BFTXdy9yt+/q50cAgJl33Vewgv0B1ZpVYAC+bIqV
	 SVGSKFA4nSBvC8udqavMhkH2ZtHgV+UuFi4H85PewUGs/VVRGaeF5SXFn6Zmw05P71hqv
	 BaC2i+aX+Cx0/nJUv4aFgwDSk/cWheGHv/mqCudKDPltLFjXd80z6m0CQaz30CjJJOWQi
	 RtnErT4wtwgdJkJKO/sMmGSBO2puOOxk4/3dlWPHkIM5MdNkRyiKM0OWBdaogCBmGCXRL
	 mc1Uo5onWqbtnvLVaFeUXkBW26GfrhInFjyZM1OwawpEuxiDHL4hf4Fx2znBO5W3riw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViNW+cEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED57606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViNW+cEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B681F0089F;
	Sat,  7 Nov 2026 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048084;
	bh=nB2UJT/KZSIv9r73ED7mZispBAM7Oo5TSmJE1rtF8pM=;
	h=From:To:Cc:Subject:Date;
	b=ViNW+cEbMxUl/j02OczLCdJ9zjT4E/fvFzsSogdpf9uYJvaRUU3OpSmyKbGewz1+M
	 H5D7y/94IiN2/7tj91NpVqFQ+0qvb7S1FIEGuxubxWM6tqyiMOcFFXmAo+3x6DVoph
	 0RAFEmeOMH6chpoHEPpdwGTUQNdSE583Azbn4BWFmaVdNT6Oqe75oZCIw2f95FeCx/
	 3f28x8RtFiUc8TUQxj/zLpotXKbsN8iV0dVo87ECKHrHDX6f7eLnXZqqBRkdnSm0Ka
	 Nnjl9uQ+SzGmQQ22TdzhJuXY3B4g0uKmiGAbSpPwJ+CcBzEuOunzAu43Aj+mG/Tjo2
	 jS5lkF+JSOJ6w==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix awb_mutex and lock lifecycle" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:22 -0500
Message-ID: <20261107054122-failed-6.1-5540b48c0702@kernel.org>
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
git cherry-pick -x 5540b48c0702f6a1389db3d473d7fd0db930422a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054122-failed-6.1-5540b48c0702@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5540b48c0702f6a1389db3d473d7fd0db930422a Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:21:58 +0530
Subject: [PATCH] media: microchip-isc: fix awb_mutex and lock lifecycle

isc->lock and awb_mutex were initialised in isc_async_complete() and
destroyed in isc_async_unbind(), tying their lifetime to the subdev
bind/unbind cycle instead of the device:

 - isc_async_unbind() destroyed awb_mutex before cancel_work_sync(),
   which takes it;
 - a failed .complete() left them initialised, and isc->lock was
   destroyed only on the .complete() error path, so the normal unbind
   path leaked it;
 - a rebind runs .complete() again and reinitialises a live mutex.

Initialise both with devm_mutex_init() at probe so they live for the
whole device lifetime and are freed at remove, and drop the init and
destroy from the .complete()/.unbind() callbacks.

isc_async_complete_err then only returned ret, so drop the label and
return directly at each error site.

Fixes: 314c96e5203d ("media: atmel: atmel-isc-base: use mutex to lock awb workq from streaming")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../media/platform/microchip/microchip-isc-base.c | 15 ++++-----------
 .../platform/microchip/microchip-sama5d2-isc.c    |  9 +++++++++
 .../platform/microchip/microchip-sama7g5-isc.c    |  9 +++++++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index a7cdc743fda71..eebbcb28a7eed 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1703,7 +1703,6 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct isc_device *isc = container_of(notifier->v4l2_dev,
 					      struct isc_device, v4l2_dev);
-	mutex_destroy(&isc->awb_mutex);
 	cancel_work_sync(&isc->awb_work);
 	video_unregister_device(&isc->video_dev);
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
@@ -1767,8 +1766,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	isc->current_subdev = container_of(notifier,
 					   struct isc_subdev_entity, notifier);
-	mutex_init(&isc->lock);
-	mutex_init(&isc->awb_mutex);
 
 	init_completion(&isc->comp);
 
@@ -1787,7 +1784,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	ret = vb2_queue_init(q);
 	if (ret < 0) {
 		dev_err(isc->dev, "vb2_queue_init() failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	/* Init video dma queues */
@@ -1798,13 +1795,13 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	ret = isc_set_default_fmt(isc);
 	if (ret) {
 		dev_err(isc->dev, "Could not set default format\n");
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	ret = isc_ctrl_init(isc);
 	if (ret) {
 		dev_err(isc->dev, "Init isc ctrols failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	/* Register video device */
@@ -1824,7 +1821,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret < 0) {
 		dev_err(isc->dev, "video_register_device failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	ret = isc_scaler_link(isc);
@@ -1839,10 +1836,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 isc_async_complete_unregister_device:
 	video_unregister_device(vdev);
-
-isc_async_complete_err:
-	mutex_destroy(&isc->awb_mutex);
-	mutex_destroy(&isc->lock);
 	return ret;
 }
 
diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 66d3d7891991e..25d241b4c66a8 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
@@ -417,6 +418,14 @@ static int microchip_isc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
+	ret = devm_mutex_init(dev, &isc->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &isc->awb_mutex);
+	if (ret)
+		return ret;
+
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 7383341ec51d6..28d975002476f 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
@@ -406,6 +407,14 @@ static int microchip_xisc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, isc);
 	isc->dev = dev;
 
+	ret = devm_mutex_init(dev, &isc->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &isc->awb_mutex);
+	if (ret)
+		return ret;
+
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
-- 
2.53.0




