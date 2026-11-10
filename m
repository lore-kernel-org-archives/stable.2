Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280167;
	b=CknyLM2K8j+ykBpefFrWUpVsExBKnQfUlr9HOHYmyFb7f8e/7/isiuiMSIRT/3YqdPI1
	 OUY9Kwxlik0BqTpS14M2A5KD40LRPvvB0aHkILSn4+7BoE/Tn3OzJfNouo0ADjtrtlrUp
	 iurfWXQLc+TisLuhZcSDNAcOOGQrKYY8vPlHRhOqzPYWwI0W+8+4azTKCitc6tXV33loj
	 gCWOPzOAtFeALl+DNd3cyJmoKcgKz9vJfwFs6qboFl/G+sKMxnqVah9Eh68DGp8SDOhla
	 0OBtC9BQmHEMbV+bwFm/5pqaqkgVHcmhAJDeGI0tgW3JPl31tft4hN9ZeM10F6ERWsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280167;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sUE9pcvxpL4tqaQuDlpvJHAuMWMG1o2IFRUUg5+UyGc=;
	b=ejSI58zPc0X8jvGgQhOccVoVDBL7ckwaBe+vqURBHK2FcSilYdsXHQ4kKytq75Fv97yD
	 v3N0EsMrA+EsbJrkmgulsnS8O1ZkUaRkQlW0+sTDH5iLx/eme6YtpaBBNPRYBv2RxsHge
	 yUgX6NJoJKFHTaq5aNbBKN5Q/Dd744kbJY1bV9toULm/eSfm0wKbD8VpfbTlmZHCXb5ky
	 gZzm4Z27cA4WnnPavgj4mXrLDep3OzTj5ZGjngI8HZ9C9CBTSrw2VFCadLMFvgsZGW2b1
	 gKbP1q52Pg1l94q8zUmgxdSpjgrtrXqtOobqfH5sCvihjfqQvQbF8T018e6enjYneOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HcMzdNdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HcMzdNdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CFE1F0089F;
	Tue, 10 Nov 2026 03:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280166;
	bh=sUE9pcvxpL4tqaQuDlpvJHAuMWMG1o2IFRUUg5+UyGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HcMzdNdcfU5h9El0TEVk82c7oYiziELSbRm3lsypeog8TQbJ5pYsdoh+gw9Rh4//T
	 afBsplQP7S1DGBM0n0Xzh1zga1DttfVcQjsz39zufnoqkrMtmoX6UiQL7gPglSB4Li
	 IMcdbrlfyTpGboorge39/2dwWM7b6orJ4jnzV9fe+dcFPKCmD1sJzh1vossgL9M3P/
	 q+xKQ9SkuMVPB+VNKVfPlr5N0xjPX12v0+AwN0xkAQUfstomdZkjAlPrtjc66/Mt2U
	 A/qUE7al6FoIzVm0TT6mMO5iT7AkgJAOQ4i5myfRVOoDmkc/C5F57KP6wqxxazOYbJ
	 YBPGgtdLdmUKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] media: microchip-isc: fix awb_mutex and lock lifecycle
Date: Mon,  9 Nov 2026 22:09:24 -0500
Message-ID: <20261110030903.41751-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054122-failed-6.1-5540b48c0702@kernel.org>
References: <20261107054122-failed-6.1-5540b48c0702@kernel.org>
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

[ Upstream commit 5540b48c0702f6a1389db3d473d7fd0db930422a ]

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
[ sashal: Changed the additional isc_formats_init() failure path to return directly after removal of the obsolete mutex cleanup label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c  | 18 +++++-------------
 .../media/platform/atmel/atmel-sama5d2-isc.c   |  9 +++++++++
 .../media/platform/atmel/atmel-sama7g5-isc.c   |  9 +++++++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 9e91e4d948a24..a2e5030f0d597 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1754,7 +1754,6 @@ static void isc_async_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct isc_device *isc = container_of(notifier->v4l2_dev,
 					      struct isc_device, v4l2_dev);
-	mutex_destroy(&isc->awb_mutex);
 	cancel_work_sync(&isc->awb_work);
 	video_unregister_device(&isc->video_dev);
 	v4l2_ctrl_handler_free(&isc->ctrls.handler);
@@ -1863,8 +1862,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 
 	isc->current_subdev = container_of(notifier,
 					   struct isc_subdev_entity, notifier);
-	mutex_init(&isc->lock);
-	mutex_init(&isc->awb_mutex);
 
 	init_completion(&isc->comp);
 
@@ -1884,7 +1881,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	if (ret < 0) {
 		v4l2_err(&isc->v4l2_dev,
 			 "vb2_queue_init() failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	/* Init video dma queues */
@@ -1896,19 +1893,19 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	if (ret < 0) {
 		v4l2_err(&isc->v4l2_dev,
 			 "Init format failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	ret = isc_set_default_fmt(isc);
 	if (ret) {
 		v4l2_err(&isc->v4l2_dev, "Could not set default format\n");
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	ret = isc_ctrl_init(isc);
 	if (ret) {
 		v4l2_err(&isc->v4l2_dev, "Init isc ctrols failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	/* Register video device */
@@ -1928,15 +1925,10 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	if (ret < 0) {
 		v4l2_err(&isc->v4l2_dev,
 			 "video_register_device failed: %d\n", ret);
-		goto isc_async_complete_err;
+		return ret;
 	}
 
 	return 0;
-
-isc_async_complete_err:
-	mutex_destroy(&isc->awb_mutex);
-	mutex_destroy(&isc->lock);
-	return ret;
 }
 
 const struct v4l2_async_notifier_operations isc_async_ops = {
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index ea3e8b86a7f31..629bb9ada4698 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -30,6 +30,7 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
@@ -405,6 +406,14 @@ static int atmel_isc_probe(struct platform_device *pdev)
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
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(io_base))
diff --git a/drivers/media/platform/atmel/atmel-sama7g5-isc.c b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
index 4bc2f5c7f2f7d..2da0f7282d015 100644
--- a/drivers/media/platform/atmel/atmel-sama7g5-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama7g5-isc.c
@@ -33,6 +33,7 @@
 #include <linux/interrupt.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
@@ -394,6 +395,14 @@ static int microchip_xisc_probe(struct platform_device *pdev)
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
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(io_base))
-- 
2.53.0

