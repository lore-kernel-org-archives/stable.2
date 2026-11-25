Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795604186;
	b=awrfi/1DjnJCbeugut9NDu5UaHdqZ2q8ni+yHkvjfIrKpWUNNLY+a03LvXV7uGX80FDQ
	 XhxPzMRpIpjyQhwiTqMQbvJWfA7r+5Tei7oeJJeou/fJjDbmnA21yS81Aop5Nk+UMAECO
	 U5+XQSKpv8hz8O1XrYfH9VPPnR8mgxnr6a+Ky1D894CR2BhVXluYQvB/VS9q44ClVRUx6
	 4a/NsByT3WL1JWMdzp1sZFQPFIJBphslCxtHIumrVREpISrClqmuMnlsJu4tv36VdPx8/
	 EGHYDIneaJU34o9DbwxnXL0puW2v73xmRQYZH7e0BzcEaCdftzQlsOjn2SnqOOHsz7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJOKwoI4nZDDgERDFtfVbeF2wwjtESDm04yE6n76iXo=;
	b=4wWkGNboOSnakbiOJYYaQPl8hCEd3qMM9QFn2cXJL/mIYGl4FGq3dJNdUNN2B81AXU8s
	 VgOf9fGOW/4Z10wNsWMi0gBi24U411zu/F7OqrmrrFjbQXScMKJFcRNs/ctyikOp6VfUb
	 u7/CrEMQWN+YINfQuBkbzAMKqRCVNbfJIZwNSUl5lOA/E3s86EodRTQEk+H9W+DJQk5XZ
	 M+rPVUe/Unv5BtIa2e1o5CHSAtOC8OtxuJ5LgbqH5AvsfOf5Cki8aPj8nQnAfw0lz1R8T
	 At/ioqZxyR7OjjM65TIdM2JTUBAkQNpXDGAfE0noY9RJI5AGoC2IvhvnmB7n/8AStuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uG5AoejD;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2F606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uG5AoejD
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49412eb1474so3626529f8f.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795604185; x=1796208985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FJOKwoI4nZDDgERDFtfVbeF2wwjtESDm04yE6n76iXo=;
        b=uG5AoejDVEKJJavEqPbereLnAU8Ll13LSLVcUCL8eUYTpcVslYfWhSmEKwt3SBWjpb
         VUej4R5ove27BFmFWqgQEZgW/kNzN+bjCGHdXUE6tlC3w1o/eV4p90WX8hWQ7/io+dGL
         jGL5Hxye9Fr95U//0dvbKmKG3R3BhilpHedV9TYyzzK/SLE5Jzw1GJ48+/fvs5P+NO7D
         ygpvvQqTVAqqYwj06Vm97w0l+mh9kFaniPhDAltvmCyfpSaxzMMCeeRBgu8KDy5YBCBB
         lz35EdmvGAKf+duNIkwMxGLr3fa9S3bdVs0MDReCCjIPJ5iM7R3Ww5vdAOX+H6Y6YMst
         1dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795604185; x=1796208985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJOKwoI4nZDDgERDFtfVbeF2wwjtESDm04yE6n76iXo=;
        b=yaQQ2uNsbvh6YWHFjsUvPgBOZGa7G92UmnqxZa4iL4PrlW8J37ePMzIlh/u+D+Sy6S
         5WmmJeB6POAPPfotVc+EBQqghQAqjjs2pQiaG5TzWT7fbNsVrOK9q2DDnVgxwkDhqk/E
         EVIP3NSGpgvJvwfV9fvr69HRqlnHyjv8IEzb9dSxrBwb/HE+wDxuoypEdNsn8vRa3ZY8
         pOiUOQ2kJ3QQ7faapcEYA6C+wZCx2XRAwYERH5tPj8zNDDNIJPoDKAhCht9y6E+H8KrT
         V0yt4QHzkjyHLcyF2qhF+yfsse6ZIPPM59k8ucU6UJoQXxxb/ETHHx6H2iVv7zl1Ookq
         i42g==
X-Forwarded-Encrypted: i=1; AL+hErECfETxsE5woZdIJmbmVIBKvUcVr+GfMO4lR90jkTg9bJDsPz6DBD4ipIcYWZjUGRNO0Ofu3rQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tvtSvyE2DIoz3f3Ij+Rdfhsddx3xEH5ztH7+h3oIR71GpE3+j
	0a6GwKN/8qqOB+JMl+bGRz0nR1M4E9hM0w1skG1A4JsxPosIpDYos8w6
X-Gm-Gg: AZFdTZdSZMOz8yC0wQTQGPipRNdISvSQe7RAFZSJ4NCafUiV3FKKU5cv0hRD0O2rSvp
	q3Buzi5tqp15LgUuwK4O4CwvpP7Dcu34aqbozpDU8pZRrmhkTd//eCfevhDATTzd79WdW+EgtGV
	ujfpAXleBKlCedy/ZVs8PgShlyo8q9sOuSOQqz9yX27gVhv+kCehooZ9DgA6V82HFfwyJBE3GIt
	UX2uWcOh/TKf8CWBFoaxnADKuP5KMif0a7mskBscRP0zuoG8dv0Xc6ItuuwEkNOBxrQLxecBxUp
	38XqZf1FTwZ7LC/mmI/GKqVNCn6qF3lukQN3jghwMKHTovF8wk2QozCdJelPaTPLfMg8Ab3i1HJ
	/2QdWkfc900oweuyzV2P8cYYM4fRCKCt0dhODMUhsKRSCi60TMK6BEGC9YFAkFpiOZ7POLVr/JR
	avQ1UjHfJUiMjSAOjy/W2m+8zEiPxO42e7mOdkKR73TB/t0N3hzTfywvu3YuVheDHtf4VWfhoWY
	yz56rv/LiVhKmIep5ZzsW6kx8doigtudzLXeZXLiLucn97Sye0MHBBmy6/KmkeE+xKNeRu6SX0x
	n6HVh4gi3GVqzdgvcRNXy0VTi9/YHLJesbvnUXezIRw/4REHWn2q8bIzEazFRM4EAb06hUT3YHq
	mjiJqHB3bNTn2pw==
X-Received: by 2002:a5d:6f13:0:b0:491:3fdd:af42 with SMTP id ffacd0b85a97d-4abb5cc19b5mr30289182f8f.37.1795604184433;
        Wed, 25 Nov 2026 02:56:24 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm33988993f8f.58.2026.11.25.02.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:56:24 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: dan.scally@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	nayden.kanchev@arm.com
Cc: mchehab@kernel.org,
	hverkuil+cisco@kernel.org,
	linusw@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: mali-c55: Serialise the ISP enable in the params and stats paths
Date: Wed, 25 Nov 2026 10:56:06 +0000
Message-ID: <20261125105621.239518-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Only the capture devices hold isp->capture_lock around the
mali_c55_pipeline_ready() check and the ISP enable or disable. When the
last two queues to start are on different video devices, both can see
a ready pipeline and both enable the ISP. The second call fails with
-EALREADY and its queue's start_streaming_called flag is cleared, so
the ISP is never disabled again and every later start fails.

Take capture_lock in the params and stats paths too, and assert that it
is held in mali_c55_pipeline_ready().

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
v2:
- Add lockdep_assert_held() in mali_c55_pipeline_ready() (Jacopo)
- Collect Linus's Reviewed-by
 drivers/media/platform/arm/mali-c55/mali-c55-core.c   | 3 +++
 drivers/media/platform/arm/mali-c55/mali-c55-params.c | 4 ++++
 drivers/media/platform/arm/mali-c55/mali-c55-stats.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index 241a625f7284..bf80935c20d2 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/ioport.h>
+#include <linux/lockdep.h>
 #include <linux/of.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
@@ -510,6 +511,8 @@ bool mali_c55_pipeline_ready(struct mali_c55 *mali_c55)
 	struct mali_c55_params *params = &mali_c55->params;
 	struct mali_c55_stats *stats = &mali_c55->stats;
 
+	lockdep_assert_held(&mali_c55->isp.capture_lock);
+
 	/* Only wait for queues connected through enabled media links. */
 	return (!media_pad_remote_pad_first(&fr->pad) ||
 		vb2_start_streaming_called(&fr->queue)) &&
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
index 16e895e3488e..6515c78c1bb2 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -762,6 +762,8 @@ static int mali_c55_params_start_streaming(struct vb2_queue *q,
 	struct mali_c55 *mali_c55 = params->mali_c55;
 	int ret;
 
+	guard(mutex)(&mali_c55->isp.capture_lock);
+
 	ret = pm_runtime_resume_and_get(mali_c55->dev);
 	if (ret)
 		goto err_return_buffers;
@@ -796,6 +798,8 @@ static void mali_c55_params_stop_streaming(struct vb2_queue *q)
 	struct mali_c55 *mali_c55 = params->mali_c55;
 	struct mali_c55_isp *isp = &mali_c55->isp;
 
+	guard(mutex)(&isp->capture_lock);
+
 	if (mali_c55_pipeline_ready(mali_c55)) {
 		if (v4l2_subdev_is_streaming(&isp->sd))
 			v4l2_subdev_disable_streams(&isp->sd,
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
index a9c28b090b2a..cbd2a2f77da3 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-stats.c
@@ -146,6 +146,8 @@ static int mali_c55_stats_start_streaming(struct vb2_queue *q,
 	struct mali_c55 *mali_c55 = stats->mali_c55;
 	int ret;
 
+	guard(mutex)(&mali_c55->isp.capture_lock);
+
 	ret = pm_runtime_resume_and_get(mali_c55->dev);
 	if (ret)
 		goto err_return_buffers;
@@ -180,6 +182,8 @@ static void mali_c55_stats_stop_streaming(struct vb2_queue *q)
 	struct mali_c55 *mali_c55 = stats->mali_c55;
 	struct mali_c55_isp *isp = &mali_c55->isp;
 
+	guard(mutex)(&isp->capture_lock);
+
 	if (mali_c55_pipeline_ready(mali_c55)) {
 		if (v4l2_subdev_is_streaming(&isp->sd))
 			v4l2_subdev_disable_streams(&isp->sd,
-- 
2.55.0

