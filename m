Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171239;
	b=J/wArRFwtXPqvsYMDC8sWMmcBnUlml3s9vNNQe5QhJ7kqf2d0eZuqQqwSJTCFFYwTOsQ
	 qy3s62KluW50bh00p8wkoTa6f88Gjy0noygXayyawoITdQTs+isvRK9DedmjzqEXQ1QPH
	 6jIM9N2Q6kWonV1qH6Eykzm10a5VJkq+sVAspjFoeDRP4qrJxmlrLwUxpynhsgUxtZ2Em
	 FmkySW/BF00zhJ5t7aGFAAuTXs27iVya11bpbBbUnR2Bzw8L85E34R5Ubp82WSV3VSB2m
	 TpugU8ZjP/mveYno6MbVktTpiAh071y00nS/CLKgzVBsSE2gqLBIc+P8obo4O0PXy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=el1LyCfnrClGpym+h6i1skzP/uh1fnaEtmw/z/26iV4=;
	b=DY634jJgX7BQMYWPAsKH8tTcS3oaD6VwdSQFk2UEViDa3bXROC0uYnqqX1F7+m8/UCmH
	 wFk7lo3sU/5wv70Nm4U68tc+p8BgX2RlVIoDTq4U2YWb28IxjO+IIRuGQqv0+jY30/wUh
	 ioPRxIo40CUrsyH1Iez0x7OsldE3cbFkSxeKF3Rkdjy3xbPJuXV79Bs1O0pyxgf/CIqgm
	 M6yshgH+l+D7E/QjXWU07DtehKUzscqlu/LGbz4NoUYguW4OMgdCB3qMmDksD3gfxeJtu
	 WsJiSB3JCZODpnPE7buIVFWyThSZtM3JoVUO1FGPR0Lb1XMxnYFTeLfpfoZ486E3FNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHsjyxG7;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF070606A339
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF070606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHsjyxG7
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so6111245e9.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171237; x=1795776037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=el1LyCfnrClGpym+h6i1skzP/uh1fnaEtmw/z/26iV4=;
        b=rHsjyxG7oaD4wWpiGPVmip0n9lwJylvWs2W4M19ixmByUJbyM4+Vi5quLZg0cLIiMm
         pYYP+BPfnGZOBhdnQXyyhMuEn+jxhb96M9/jWEd3lrzkUWWyWIP0d32nZq5YKc4vPu5O
         RAddcl067G8DS02bC3kLVrMkr2jd04twLuo9z0lH8OqwN/qSuzhyQliCSwD7VPO0ML84
         utRF92KBiYhKyapwHP4e4ncov2voP6a91U0CF1K3K82dS+MSbcaj2nVyQ0zubTeefuT5
         HNxzCYU0ZXSfDWlUh8S0gAALoKcc45KLf//D2QUR2zVbtKFHbryyYqIhrtBsV8AvaJIG
         w7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171237; x=1795776037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=el1LyCfnrClGpym+h6i1skzP/uh1fnaEtmw/z/26iV4=;
        b=b2MIRY+wLTIwYRFsWH7lc7WwEZVEoD0BIT9X0M2A620Fk4V1HdynKd7VRwFbgkhFrZ
         gefngQGszwSsbe8vGHztiUCG2ZI/T24QfjYjAlBAqt1vu5Ci7DaSnmZGLkjA8QgBbihM
         2acEIDrpJ0oXbbgru7FOLLrlvL+etsmmc5/4deBAQ64iCHkoXOCCKSK/4F7wA+08OozH
         ldM34drn8oiYRhuREC3nOgjwxJsT2lML+C1dRxb6q5wG17HW90532s0Q8LQvw0cxkYM4
         Mti1f7nMqAv79mrntqVBRk/KqVZuEA31OPG/7GoQLnP9sBTjoXjGOXunfy9uD7j/0uqA
         jAVw==
X-Forwarded-Encrypted: i=1; AL+hErEq6I9qcCxndjZoTZqUbO0hVpt3zmFsaCFgRKv5N+0h6xyNSqiuYlzei+rxlYWkyrvBsWSHpRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qAptNwVYgHXK8wWX5zXKOpM/IluQkqDFxFOZKjC2hLlZ0zplP
	ES9XEdi2XsVNlIapmCSodrv3pVe2vXFFgIEwEmzW582HPT5f7orTfFw6
X-Gm-Gg: AYBFou1cQPyEu6jLnpEPTtvnWd66fons8siRkDTUsbpfhH95v4PeXR03t6VK+0z7foP
	LICz2MK3N6zMUkSL2IlPPsLvLMuYMpVBU5MQRyF2xaf9dZmFaKGS/44zXT8oc5Ae70lYkelT+kQ
	bRdfcJpJqh5okuzzTSf2YZL7poERdm09IlZn+G8b2yMQ7T4bYdT+hOebio8ThF0SoiS2sF8EYkb
	ONP2KCKYXYzN+peQ8sIH0pYPKLdqGbrIx9VZnY8ylKScaPl0XN3P72gSwtPR2Rl9qAIks7RnNOr
	rqEYf9u0XHXsuRKUWBOlaVCG8kKijFKTCmr0kXHPca6ovBf1ezqnlqDuMXaCBK3osNQk3/YFBie
	0Wcozs5n/C9luLW3mKvoTK9MZETRuOQiymXVSt4AjPcvcQqe5uACIKozLfn1zfjvbT9U55iJMzz
	Qw/9QSeCQfy73qzVrpbJEohaLjYfEqG7y6KlAAZqsjXh8+3VA0g3A/m0Hm2z5lgEf/6OWf4ZJVd
	VbJoeWe+QbzLajZlZiDjFOPfWEmW835rgRpTIWcYoAlLK4WIUO9euFfUppDGvMfsr8KiniqJOn8
	ctHBQkFQrGc0zAdaTjuxAIjxdVYcXPTAWQRCClgBch5CqQ5VdSRHRtw2ob3kwuFa75Py/WtVJ/W
	jU8MynNfXVcKWN2XHyP9+pLgFEPsGYxbOvTXtPKxvnkxbap5qUn4=
X-Received: by 2002:a05:600c:848d:b0:4bb:6b6b:fbaa with SMTP id 5b1f17b1804b1-4bb8880fd0amr55521205e9.16.1795171237076;
        Fri, 20 Nov 2026 02:40:37 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:40:36 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:28 +0100
Subject: [PATCH 2/7] drm/etnaviv: Register the cooling device last and
 unregister it first
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-2-445fc6eacddf@igalia.com>
References: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
In-Reply-To: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

From: Christian Gmeiner <cgmeiner@igalia.com>

etnaviv_gpu_bind(..) registers the cooling device before the workqueue,
the scheduler and the clocks are set up, and etnaviv_gpu_unbind(..)
unregisters it after they are gone. So a cooling request can come in
while the GPU is not set up yet or already torn down.

With CONFIG_PM the GPU is runtime suspended at these points and the
request only stores the new state. Without CONFIG_PM
pm_runtime_suspended(..) always returns false and the request accesses
a GPU whose clocks are off.

Register the cooling device as the last step of bind and unregister it
as the first step of unbind. A following patch makes cooling requests
wait for the queued jobs and needs this order too.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 42 ++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 2a15ae6135f5..2a56bdf2510a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1808,19 +1808,9 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	struct etnaviv_gpu *gpu = dev_get_drvdata(dev);
 	int ret;
 
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
-								  dev_name(dev),
-								  gpu, &cooling_ops);
-		if (IS_ERR(gpu->cooling))
-			return PTR_ERR(gpu->cooling);
-	}
-
 	gpu->wq = alloc_ordered_workqueue(dev_name(dev), 0);
-	if (!gpu->wq) {
-		ret = -ENOMEM;
-		goto out_thermal;
-	}
+	if (!gpu->wq)
+		return -ENOMEM;
 
 	ret = etnaviv_sched_init(gpu);
 	if (ret)
@@ -1840,20 +1830,32 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	INIT_WORK(&gpu->sync_point_work, sync_point_worker);
 	init_waitqueue_head(&gpu->fence_event);
 
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
+								  dev_name(dev),
+								  gpu, &cooling_ops);
+		if (IS_ERR(gpu->cooling)) {
+			ret = PTR_ERR(gpu->cooling);
+			gpu->cooling = NULL;
+			goto out_clk;
+		}
+	}
+
 	priv->gpu[priv->num_gpus++] = gpu;
 
 	return 0;
 
+out_clk:
+	gpu->drm = NULL;
+	if (!IS_ENABLED(CONFIG_PM))
+		etnaviv_gpu_clk_disable(gpu);
+
 out_sched:
 	etnaviv_sched_fini(gpu);
 
 out_workqueue:
 	destroy_workqueue(gpu->wq);
 
-out_thermal:
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
-		thermal_cooling_device_unregister(gpu->cooling);
-
 	return ret;
 }
 
@@ -1864,6 +1866,10 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 
 	DBG("%s", dev_name(gpu->dev));
 
+	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
+		thermal_cooling_device_unregister(gpu->cooling);
+	gpu->cooling = NULL;
+
 	destroy_workqueue(gpu->wq);
 
 	etnaviv_sched_fini(gpu);
@@ -1887,10 +1893,6 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 
 	gpu->drm = NULL;
 	xa_destroy(&gpu->user_fences);
-
-	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL))
-		thermal_cooling_device_unregister(gpu->cooling);
-	gpu->cooling = NULL;
 }
 
 static const struct component_ops gpu_ops = {

-- 
2.56.0

