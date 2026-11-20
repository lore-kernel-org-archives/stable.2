Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171237;
	b=zvV6+78FZ6jzGKoxqV7WrY8OtqlH53WaiTO3euHZbB0reH+yA4X/WARcQDyNgpSVqEDn
	 6COVhF26Du9BUO1iQ3HLTqst71W5SPSQS2TstcaFCjs7okDt5yTQgiU1l4mIAsMNFrPxM
	 o06Fv0Mcx2shZJZtwfxX4QXycmldK9nzTPk+N6it/Xg77qgng7Fzk9MRBOztzIvudE1sW
	 A0PosrbeC+4sXyQgEZ0QuXSS07Y/0NdlTmwUMpk0SiQIc90hLuNCOk5pckhcew6PHHH6U
	 MYcXFHSPE4N8kYO7Z3R2erfv4rhc2hE/wka9kINa5NKDpvKgpOgiZsuYvv5CMvYNxFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wWjEO3N90Ag9CCKCLSbaqSxSbDsFMtzLcLHXCqLa5hY=;
	b=h073+wOJ4LvItSQCnPyJ616RIy/GgJA/OUYJgt4mC8yAZjege960+QFDpff6JU2U3PPv
	 Cknjh5s0DK/3x1/6Cg29Rib3w63luGEoy+MG5zXzbarJ8nE/uVJnYn+qVuUglI7OrV1JW
	 b9jB0YLOKRmOrKbfhLm1oJLIv+0NJ0Bz59KkY8pLsVpr5sdsIxZ0NrpyTrWDjTZYkLlRW
	 EJ2NavlQ/YwGQUXYnSA/qaA+DRhm7rHBpKsCUseIw72R7pTwJfKikiotAysc+QlM8XKom
	 L6gmzIKr08VkpLR0BuWCEEdVJy7KemDBqozPG7+Nt5XJX8T6PTjPnyVC/IcbtUB8LtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLLqvFjT;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA3606A330
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95EA3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLLqvFjT
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so338813f8f.3
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795171236; x=1795776036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWjEO3N90Ag9CCKCLSbaqSxSbDsFMtzLcLHXCqLa5hY=;
        b=VLLqvFjTEGLEuGf1KgYPthxjvOGPS++cPjWxcgiEdKC5A4yVI7SB7vmmXlXIT//lV4
         yrMvsSv3U3aPEA98N6fxjniuOunmcApDd3r4F9FMOsu5gDiapE7ZVhO6/cj8Pfdf1CjU
         M2NrcI9Z8heP4VVbmAE1QUbhaMoH6XKTYeInnozH3ntXMPESwxEXbyzkYQ/0/WxPrH1E
         0b2Q546I+MPggwmQA/UsiW7Ye0DPHtR+4uBVANWIRfWYitcqFaK+5Ch2AlSEZDrMoFy/
         kfDQ9Lk86mqe5lsF2ZjspAcS7BR0W5/QF573ABAMynFjwFM8O/4mOoR8YiZI/FC9flWp
         NChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795171236; x=1795776036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWjEO3N90Ag9CCKCLSbaqSxSbDsFMtzLcLHXCqLa5hY=;
        b=C6aw1KyUUCBKnahm0q1V+kfYrqU6rPN9YX6F/F/G5TOQcXO+rF1W1lg99I3yePH/b+
         AnALOGKhBjfvXN3fUmavh6iFBSEftYSb4pNXcXaZdRYwVPY/B4EJPbI6jmhPY2ty5RSn
         kLDNeUj1mZEmvUWPDAoEkJ2xyACVxtEw7oEHZa4IXDzWBzq+l3Z3VwQRJqERWAnJdnB9
         2+f6gIc/vQNQxDxyTxBU7Yv6PccyJ+Cxxri6WfLHuAvT3PfZrjRjvppiU4NJXlO4jfCD
         D/MFvyVW7s32K2vd9fmFktUx1nCaE4FaPPotiSAJmH5syELr/xgu790nstCVc/6K72oX
         Fovw==
X-Forwarded-Encrypted: i=1; AL+hErHiuMTG84MzW4Q7ph3iY4eZ2rCGEtKIW7hjKZNZQavaJgp3wcIHHH8BdxCoonoU3e3nDjzdZvg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+j29Syp8D5hhSpg6vDkuUj0ZeGVHgiSchfxzJLM7xTj2FExj9S
	J3kpa5yvdJZaJ5NDt3KwSPwro1SZnvl4zSc4PPQKvH7LUHYnaISxPcAO
X-Gm-Gg: AYBFou1JqcWkD9LN4uKoiMAWCCU4zeJ5UxFp9b5jW5JpSuz5ZclcSH9kyBjIN+L5u3Q
	uSuP+cghkS7kwKlV9DzcWUuJOUwSPNcSSqbMMZulu7LAe/9X2pvAt46CHCpe40MyoNSTM6n7J2r
	tMqFBGsY23lYLmdLDuqFzsh5Ad4WPGljgWqesPGevXxtWSxOH9rebxPxiAYZRlb7kxlQiMH9T0H
	ks/071Gsu5fBIubnyorPicic/3sTPhzT/itH8HwW0pghZGubYK7roEOsbDHnTDjFrzdxkgPr933
	Hzu1H/lCft2jiPrpL/hxYfxpKYzzvu/rrkfopGoGnZJoZM1x3UbKqBqPHfPrXZ5k86rvLEEGl9H
	8PDudC/ffA+S0A8XAE06UR+UZpsxRRtkVuQnbAWG/ccM5HX6kPakd9nvvh89aMwsmPcZl+nS+RU
	3uSIQDxXLIuyO6TmtvF4W8ABI9mEB/sO5JNZ/PBhlDpcctr3J+ov18V0lnG8isUdBj60kiGd7gw
	clXxBjFkfNz4a/etvXcJ1Bk/ti4TB/prfxGpj6KSupiXdYnUQQPUSudZm64GA675u4hhnY0Frr+
	o//gKDdD06Ypkau4MaP1UqpM/ELdVfgDI2uFUhXUst9ALiD22HaIOwT4OpCUdGr3v7s+Vq5VKgo
	MtBMA1NmnMpfmXMos0eqgPtF6YVUKIiqpAr0Pxqdu2fbxWBig4Sw=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr62257765e9.27.1795171235703;
        Fri, 20 Nov 2026 02:40:35 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at. [80.108.121.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:40:35 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Fri, 20 Nov 2026 11:40:27 +0100
Subject: [PATCH 1/7] drm/etnaviv: Don't set up a GPU on resume that is not
 initialized
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
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-1-445fc6eacddf@igalia.com>
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

etnaviv_gpu_init(..) can fail, for example for a VG core with FE2.0,
which is ignored on purpose. The device stays bound and is runtime
suspended and resumed later.

etnaviv_gpu_rpm_suspend(..) sets the state to identified without
looking at the old state. So the next resume programs the clock and
runs etnaviv_gpu_hw_init(..) on a GPU that is not initialized. An
unbound GPU keeps the identified state as well, so the next bind sets
it up before it is reset.

Go back to the unknown state when etnaviv_gpu_init(..) fails and in
etnaviv_gpu_unbind(..), and keep it in etnaviv_gpu_rpm_suspend(..).

Seen on an i.MX6Q with its ignored GC355, and with its GC320 on every
bind after the first.

Fixes: 647d817d8071 ("drm/etnaviv: better track GPU state")
Cc: stable@vger.kernel.org # 6.6+
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 6a4aab75ebba..2a15ae6135f5 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -951,6 +951,8 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
 	return 0;
 
 fail:
+	/* the GPU is not used, a resume must not set it up */
+	gpu->state = ETNA_GPU_STATE_UNKNOWN;
 	pm_runtime_mark_last_busy(gpu->dev);
 pm_put:
 	pm_runtime_put_autosuspend(gpu->dev);
@@ -1874,6 +1876,9 @@ static void etnaviv_gpu_unbind(struct device *dev, struct device *master,
 		etnaviv_gpu_clk_disable(gpu);
 	}
 
+	/* the GPU is not initialized any more, a resume must not set it up */
+	gpu->state = ETNA_GPU_STATE_UNKNOWN;
+
 	if (gpu->mmu_context)
 		etnaviv_iommu_context_put(gpu->mmu_context);
 
@@ -2019,7 +2024,8 @@ static int etnaviv_gpu_rpm_suspend(struct device *dev)
 
 	etnaviv_gpu_hw_suspend(gpu);
 
-	gpu->state = ETNA_GPU_STATE_IDENTIFIED;
+	if (gpu->state != ETNA_GPU_STATE_UNKNOWN)
+		gpu->state = ETNA_GPU_STATE_IDENTIFIED;
 
 	return etnaviv_gpu_clk_disable(gpu);
 }

-- 
2.56.0

