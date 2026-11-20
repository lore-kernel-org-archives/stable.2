Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171243;
	b=JmoYyNtcewLtWpylCO6ZBxKGuNbHmtnxRP5iHz3uZV4XjcASviJPnvyHxf7Qe2KBhFD0
	 4kgZtkncPLF1h+VVzXdqe3+dS5bOjeYSwwnpk2lMWJS+aZVl+dGYC0oygZ8ex3MDh/WG9
	 H8RgALWlspUIyaGsekQNzKR8gE4tzgXXPO9XNNjqRNJoKw3l7jQn8ZLVsFKPECpCWW99b
	 aKZFHc7PJQbS/z3O+lj6mPpeYSJJ7rN/4CzphjK8GOiXf92ZTROX+r6/rP8RmzUykq8oM
	 u4VOylsQVtPC7ptCv4s0NBil8GnhIchpcVzmPEjmvYie1PoLySqwVmLEjQECvZSC5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=b/qJoLFhb7whNR1fmKsxBm/CKb6ds1LT3YrumeDpyEA=;
	b=JABWILebsM3eCzHRUTANE6IlG3W2QJ54GnVHUvWm1KQDwtNQpSrilVJfY1oPFoa2YRnX
	 IQJJ4Gww7ZPK88+RrjilrIj7/m6GzqIFyiyGnIVuMvtn6kcLAIBD5jRZOPnuSfb17oRk8
	 yHHAAS4Ro6VTKscgT8zWYy1u0A7kb3Sj9Z7lUXq1t8zx2VClRoZhmLsJ+ou7KmhS/X3SI
	 uAP8QmzoyJsC0zw9r3Skarc/6lc5pXTOqJ+a6fKQkk89ACtOlbqiFfe0nUfY3YTVP7Uho
	 WS3Hynm6GBHIicSqQxxTqYlOVB0y0Qt6etumUcnnx18q7UEWiLwjg6VAXlk+/IoS9ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKgUim0r;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1660A261D
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9B1660A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZKgUim0r
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso6429985e9.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171241; x=1795776041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b/qJoLFhb7whNR1fmKsxBm/CKb6ds1LT3YrumeDpyEA=;
        b=ZKgUim0rUZuHfYVFIJQdTBiAgXhJzoCrWHB93DvsBZdBGKDfBfGl3kpelBjiXan22S
         CBrUIDAZc9B2LwKIhcuuyQHbnAeCquZ/xN/8hHRdtO94QpeOaWxAe4fiAzUuapfR8RRK
         aFSyiUoW/FzDJkXf7LO05NkuhS2dlKA67Y+y6jhy3UauBn3vFshCukALpJnJa++fHj3Z
         oE29efZczgW5k5ECINREzUo/Fkk1X9S0dcMVGz5VGsYzJ4Yfd9HkkFjxf9G6JkFy0bey
         wRREtDymPWNlUNOCyKP/7p7chf7QCo7AgBFv6OpE8MmiFblDWFiQa2orWUqDbb8Qg3Uy
         +ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171241; x=1795776041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b/qJoLFhb7whNR1fmKsxBm/CKb6ds1LT3YrumeDpyEA=;
        b=bO7H6Lb9FMi1/3srcZFd6bDqw+ElYe5Lgc4Ip8NQ7AZlcD7B1ZnPOJRDlgTnjo3QQV
         eZJNJfmXOQoas2d93UgJTjv0IH42BzE/6EhH/72AClg2IDi3c2sc1G2F326rVEgN2xni
         YJtXLLye0Vduc5JWlUJg3HzEGY1hqhqYRNuBiS0ckQS97+ZwZBT743XNUKTUq3R88zJj
         lKcxfyVhhaLNgKjpvokHqFlOvZT/9KVID+rHs3OQxKvhmC7NeATfgDuuYg/WGnKPgChO
         MAn0/bbM3ds6yRxorcpJeLBGIpUNnrCal8btD/Lk+o+HGx5cnYHpzzvF4dVOc7FYGnNB
         80sg==
X-Forwarded-Encrypted: i=1; AL+hErGi9TX0BIOtT5IZRKrStnI14XHeBIqYIyc6P9O8Lcd65bWCsjIidb43VFyloMmjfgsWfR+eqUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z81KgnR1+GxzbtTCZoaMJQzHFJDfYzZKzuAQcrq3ERsrzVecF9r
	5bAgf09BuBnQKHNiLh2fpuWDY+Ah1x8sown1aI1dPL4cyDjJLszJ6GtB
X-Gm-Gg: AYBFou2DHtZ5aJzgXAetGvigzUOmyu5h7qrje9Ueta28QiQKDfRlT2hH4GNTDbATuuf
	Zf1GGKl7uZVKDN9BZnqsEE0mkOf80yIKASiSu5OZtpcazxxrNDFTzW4xzBZBlVADP5QPA1OTV0C
	s6v3ZD1SayXxe/mz9R4pH5N44S+RHBA0rngbHrVCR0NdfyYm1MHm18uGnzXzvRIMbgT5XdHO7tU
	gzcj8i6axFJR4uDEftTf/sz/OZaYiNjMWLOw3BDj6PiegCuAtB+KmBG4RBn6uMHnHODg6UtPD83
	h97urfdFx4fO9MwyHAlPZvVqBVA/MLwdw6ph/cTPcp7RpJJvIVEc4mFhjElq/p6KRLtmLF/UYcP
	c+JbGIvlTVyqoTDNXUSgGrImcjOfnu27eJ2EC07fASTLphlqpjhAIAzvrsAzqf7wHUZ/bPE+xBs
	om2tvulkUFbleDx2QdXOX+COiCG9LBaSNs/rG+UKdKbV+Hc1vZQSJk+MGfI8HzpVtClOaacYQbG
	a/agWgSfWn5UPAkh/Jg+RILVfW0qvzsS5vIzs/8nAgLThoqRMIsJ0QIj4PpVLZ3dQdt+5HCK92D
	RdTtLuSf44YBLjcdTf8UMwdU2Mw0Yn/kfTbV8LJT8kabvGe2Ks5bJDP0FnTQzlN9XQRVHp2IDQd
	TfbUhEUyQnPJKf8/SlwZCM2xw34m3Hof2ws7H0paxiEIQrOn8ahM=
X-Received: by 2002:a05:600c:5303:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4bb88785d2fmr58497555e9.0.1795171240966;
        Fri, 20 Nov 2026 02:40:40 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:40:40 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:30 +0100
Subject: [PATCH 4/7] drm/etnaviv: Don't change the clock of a suspended GPU
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
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-4-445fc6eacddf@igalia.com>
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

pm_runtime_suspended(..) only looks at the runtime PM status and takes
no reference. It returns false while a suspend or resume is in flight,
and nothing stops a suspend from starting right after the check. So the
cooling device can write the clock while the GPU turns its clocks off.

Check gpu->state under gpu->lock instead. The state is RESET or higher
only after the runtime resume or the init reset has programmed the
clock. A GPU that is suspended or not reset yet only stores the new
scale, and the next resume or the init reset applies it.

Take gpu->lock in every place that sets the state below RESET:
etnaviv_gpu_rpm_suspend(..), etnaviv_gpu_unbind(..) and the failure
path of etnaviv_gpu_init(..). etnaviv_gpu_init(..) also keeps
the lock from its state change until the init reset is done. Otherwise
a cooling request during the reset is not applied until the next
resume.

Fixes: bcdfb5e56dc5 ("drm/etnaviv: add etnaviv cooling device")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 0a28e21feb8b..c819f5fc4418 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -886,9 +886,12 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	    (gpu->identity.minor_features10 & chipMinorFeatures10_SECURITY_AHB))
 		gpu->sec_mode = ETNA_SEC_KERNEL;
 
+	/* the cooling device may change the clock from here on */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
-
 	ret = etnaviv_hw_reset(gpu);
+	mutex_unlock(&gpu->lock);
+
 	if (ret) {
 		dev_err(gpu->dev, "GPU reset failed\n");
 		goto fail;
@@ -952,7 +955,9 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 
 fail:
 	/* the GPU is not used, a resume must not set it up */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+	mutex_unlock(&gpu->lock);
 	pm_runtime_mark_last_busy(gpu->dev);
 pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
@@ -1792,7 +1797,8 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 	}
 
 	gpu->freq_scale = state;
-	if (!pm_runtime_suspended(gpu->dev))
+	/* a suspended or not yet reset GPU picks up freq_scale later */
+	if (gpu->state >= ETNA_GPU_STATE_RESET)
 		etnaviv_gpu_update_clock(gpu);
 	mutex_unlock(&gpu->lock);
 
@@ -1888,7 +1894,9 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 	}
 
 	/* the GPU is not initialized any more, a resume must not set it up */
+	mutex_lock(&gpu->lock);
 	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+	mutex_unlock(&gpu->lock);
 
 	if (gpu->mmu_context)
 		etnaviv_iommu_context_put(gpu->mmu_context);
@@ -2031,8 +2039,10 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 
 	etnaviv_gpu_hw_suspend(gpu);
 
+	mutex_lock(&gpu->lock);
 	if (gpu->state != ETNA_GPU_STATE_UNKNOWN)
 		gpu->state = ETNA_GPU_STATE_IDENTIFIED;
+	mutex_unlock(&gpu->lock);
 
 	return etnaviv_gpu_clk_disable(gpu);
 }

-- 
2.56.0

