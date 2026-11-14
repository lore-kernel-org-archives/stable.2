Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674980;
	b=ByzmZT12KcTrqSX7DEPYOU0TvO2bNIPS3y8KJVMQRx83qAyubQ7h9Gq+YTB20sxyqUVO
	 0FoFc50ctqWP69lyOLTD39yqLE0/pcsYDBz2AbXHaB3BvH5vYSMdZ6KwHK2X7GQO7XAzV
	 XsiAeYU7Wqlf4xMm7v3+Xk21NQQ0zt3Jsv7fW5caZWgMC6qUh8sy9i4plcJr0u+vlAJc4
	 MmbjZngaTzA5pSTtqkKfhewKCb9nzowuRU78TNmFmUXb0WzKld2kn2l/BBgo7vIW1vaVm
	 8M4L6Rs5gbCD/9jO5OyHNe/4+Qqdbu3dIjNZmP7IkGrF0JivyWItAlEhG6wfPbewElw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4MfgnZUAxYtPMdkCLogJEqW5pilJx/+POXbl7hayrsw=;
	b=xksljc8TLPYZedHBPbOJrO4EMp6urW1gi48sqgEf33CJiFn+Q0Aush3SviYhT+plfwX8
	 8qrhw/zm1KZ/JX5+4tEJZX5vKMTAewO0OPApKrFBQ3mjHLnlM02TNUvKTTmskuGIN2+P0
	 ckraZywRxTwTQqSRukSEZLFohWIIF4ZKWvggX/r8vdR0g4bcXkTir0oslldlaJiO5xvDw
	 8qjwBt5X2uS8YnVWhScd9Uhtmio9janZ+sDHbi2lcps4QxI5I2PKlSZTCrbm4o3ga9gVa
	 4OtM9dwTzZLwDlUWAzKQiB5sHSdgq122d28g6ZRwrw1XbPlZmgM/USll+SOQJmXKleQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TdxsQxDx;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C50606A8A9
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C50606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TdxsQxDx
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-49a92144733so770586f8f.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674978; x=1795279778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4MfgnZUAxYtPMdkCLogJEqW5pilJx/+POXbl7hayrsw=;
        b=TdxsQxDxZc0T9Cps6oqeJyMpBITPAEyoh+qpULe++WfWK+v6XZXF45CGxiluV9d3CE
         MVbEGey/x66s7G07TrCz9wReJwNoKcKgGqY7Sl3QUCKg1c8N3FAe66sBJ1rQzKBsNL3g
         Gxsye2duxBnaElcU9Py721YBQQrG1X8a7JH23KREZ1bOARkGNJ7ATX6K3f050R2/YIiC
         /E4L9/iHY7Z6o7RCNWg/RO2vq0t5LAxplcFAtvraVMUfchP8gK03JOxIc1fDBX1UvtoL
         jshd6CJm+X5WZiI9oEj3N8JpRm/VvnT7kvJdcHkIvi03KWLgkyzSbi70GVEqwiregruT
         MchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674978; x=1795279778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4MfgnZUAxYtPMdkCLogJEqW5pilJx/+POXbl7hayrsw=;
        b=D5oDedAAJerDfy9jt4hcFc4RXCGYMfy7+EpVCLbO8QDZb4xcW3uNvxOzT7hIgu5boM
         MiH0ek4/PuTlPs+RPobtp8bY9EJyN4UkRxIrPs0BbL5LpVVwm4QsaZNaHfmBVJHua1My
         5x3FF+5tI3hElDhvxvzOiMaGKdI6yMjQZmsS5v7DnyqzqtZ6c5KdPoO7M7Yy52PObdW6
         Ixb7pwqR2upBfUJoPsVl8E+QfMFVTh8ZueG8Ulsz7ZYBUAG1kqBYH0K64HiWPbAK+mns
         OlgoTKlyWywybgL/j5Cj3gdtkWCE5MKwhwv8C3HVw3p4LahwF2AkRZBsDxHKZYkITqG5
         v4eg==
X-Forwarded-Encrypted: i=1; AL+hErHC36wiY2heKl05+rWOTEmBs22ZEOUbI1yU76oGMLhdKWc+QzW0jbru5kwDhwkC6BXPMkjvpiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oDBBVHwNO++otXJwh/Wi6yELBF9LwOirtoopXamv5vsIdxYMw
	Y2n7na043c1+7vWQcC0+5eO57BQc6NTiD7/cLa6E1e4k3KBfu8xU1+Xu
X-Gm-Gg: AYBFou1yyMmRZ3NSKNlnV/Dw7bQYZeo893twzvH/kMq6chbHjmYMgQjpyPIZB3i3PQE
	XhSuy6JFgCb6XitBXmxO7cecOId/HJh96R8UWlGl3Y4cAHQg8TBreryNbO4F1BK3o3pY6d6lHv2
	bYJ1ifEGZC5xNpsu35sDgQcCmEn/Tge2SufmtfNkLfp5V9YdgrUjfE5Zkb8EjzJkGxiEb6BVaGU
	TZZ8WSCV5oLeg5J3i++X0578ditjaRXfRSMvrTN9fHjtVWIdazSKW28nCMtQNoJ3qX4hSRIJhvo
	jiLuXJQW7EDkn5G13+pB3Et2OzW20EZ0qwBvZLro/bwSRx+uaLIBWiX13em7WSbxqh11EZ4Iyw1
	Dj9fdvcRihKJNn4PNIFRRYacDB9707bLsa5TNr4onPbyOOG2f9Lbag4Sy6RE+lPrYX4hc7yH6Vv
	zzVs/MV+rNKvdNXY1byq1Jr5WiflcXZSDmup3QND/1t1YD398owdiqxayXW1M4UQDCrAC/FJByS
	8CDH+94FI17xAqSwNzxgBF/cwLV9/ZFa4e2YAfPJkM3gqUqvXYx3p5BQuMN91ImyY21LBFN5bJ3
	HykezrZAacBN6YFDz7cWmV9bdOWktVOG/hLW4Hd2NwDwP4mMQL4lbI1WSp0Ik90XhTd1wUf8oxj
	jBj8Jjqj+MWSszQ==
X-Received: by 2002:a05:6000:4918:b0:493:2eb8:e7fb with SMTP id ffacd0b85a97d-49c72ab0a38mr12067465f8f.41.1794674977448;
        Sat, 14 Nov 2026 08:49:37 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60d9fff8sm12107798f8f.52.2026.11.14.08.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:49:37 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Nayden Kanchev <nayden.kanchev@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mali-c55: Serialise the ISP enable in the params and stats paths
Date: Sat, 14 Nov 2026 16:49:33 +0000
Message-ID: <20261114164933.2657337-1-devnexen@gmail.com>
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

Take capture_lock in the params and stats paths too.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-params.c | 4 ++++
 drivers/media/platform/arm/mali-c55/mali-c55-stats.c  | 4 ++++
 2 files changed, 8 insertions(+)

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

