Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956831;
	b=WUQlRzWbwJidUwGWyPI5jnifj8EhLLxYpcj54wudhxYo5bGNo/aKYUb7c+nJ+fexhBYO
	 j7Zoxw/PqXAn/azlyfPCS8O6X7BESehD29TiS+wEe/QdrrWM4fptAghLpbaQ31YqvGO/u
	 MOtXzGOiV4Uwbg9JwirV/KayEOUhZaYZytgMGPFzzUaHmKkRe69S/3Q2ftMJo5RZqZi8n
	 xRD9vLQN9g3sOVD78vgtbwJNC9PXeYFXTby29uGepIom4YFwdiE70L4wd1assI9L5WREx
	 hyILBRW77CAzZ4uHIatKJzoIwW3tUWroKYJnMWCayp/TzlCJKvJu9DGyYRZuNTXhnag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ggqU2z0JBuwwyOOBFpelvoLoHdUUbWw3FkHf6dtYia8=;
	b=0G/lODXGMwGF+A82zxwQgEoizzjpZoEQR5qgXZZvT3bBkQQaQpCxsqybQue3JZNOgD2z
	 bbO/JP9TdDtYMzj77qt526lHIi/Kl4jsgyeJ5xlMa3I4gHlZ5KdLQLdlMwOcDKH+bao+r
	 KLhl9mtru+2o/braJD96lRV4GuiZYLGVwRrGYCDgYnvm1jPMFzu44hugs2qXgHEHRXmJ2
	 G9seCWZu2IhuS4kRXzPuTsYN3A+d0t1DOoB3b9cg/0v/BOs3l5d2YJ5b3ZdJznKmeCi8x
	 KJwu7zfHjyHTw9cu8RCjirsqxFHp1lrfshDGYY37kPSrfPA6S4Ftg2Kpr8VWGNinYiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9sEdFZx;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADB606A335
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 09:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBADB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9sEdFZx
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso717357eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956830; x=1794561630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ggqU2z0JBuwwyOOBFpelvoLoHdUUbWw3FkHf6dtYia8=;
        b=d9sEdFZxl/F57JPnGEkODh45bf2mF+RYjB6EC9cR505zxJxmd1sisNxiS9eewFjf8g
         EnYac85LVJf2eSpER58mQmykeYcYFzWyn57Wq4TB3DqwYlpK7xsvN3BQNC4Z+IgiEMvV
         a3MqpJVn8KZRDuC8tMkrSOJcaPO53uurv9/XilACN0duQL788w4S5d3avOTu+d+CbASR
         3XMAzWTERKQSo1SzBKgtNlwJTzjzegTXoxJ7p3Xu7jFJ41Dz3xPIBGEZWK2DC/X6fpIn
         SJBqeTZpQOsh1ZgdbJEMLDzVx0wETPLZR0okAcZVxENgoYE+gX9c27W5kh+EJ3wsP3Hy
         8gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956830; x=1794561630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ggqU2z0JBuwwyOOBFpelvoLoHdUUbWw3FkHf6dtYia8=;
        b=fLVuxznxeTTzrU1dOMQq03davazQemhGHDyluk2vaxz/mJsBzVUZQONgwwiG61Y7nK
         X8ADcuOF8Fpm8y6ZqGJrv57ZHkuOy4P7PT/rrvSgxwcLaQd+OtrFNYgEwANT5z/pH3LU
         xmLy5/EE/tVdmEvid/GBzucr7nNgUxMmkNptKun22OGcCCdxyy3hRb/uS6Oa3JTdrQRo
         rPjnaIbEKTgN9sTjNuIpYWacK0tyfSVbuXpv7WRRAzblzQV7kjfakcR7kU0TrDb/Nnyx
         Sr16cwYKyngHA269vgz4EvkipV9hoWGlJQlPredObBhQLSbt8SCssrrj5ieXXX8ekJ9v
         ndBA==
X-Forwarded-Encrypted: i=1; AKwUvBwswnnIvgKf4xBsY0p8NuNs6a0JaiVlhBZo3h6yX1JRqL2+w86cyjzV9oV0feQHI4eG5v4NvE4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+2mfSuB2jF6Wt225zbjxebzfIwOmG6OITEuhsz3OcPv9e6qC3W
	gc2Cwq25b4RafYGy0sb+/5cqO4sLdyjhnNK3STBf53s6li3IB3H/Myo=
X-Gm-Gg: AYBFou1f2xFzcc1Jc9UUyDFfjsH0cYCSm2AY7S6ckCDIw0/PB1A8hncblrwxxnuUXEl
	HrNNEjjOeKFppbPqTLDt3JYNkbVV65IzTF3CeXPDnrYqB1jrx0dY2qxe+VzWkc+mML8ab9OOnNr
	V3UlOy2yUORMYnSTQYsOr8tNcRQjm3av3l9nvO1ISqKvs2AVqp0Qcf/m5OlALI8uMiLO9ATk79/
	rJgBet0UlWVngyPvlrgrJeBWHK1caFmxDCrd8JO8aso2Yc2xGgizZuMwlhitcqA2xoYZom97hny
	M8dUqgVo5IjhyZGoqq/wIG6QYeL1gmgD9pwYFi5FIPY+4ZqlaYX5Bdq0Kn3NidgOPMTVsKwb1Ch
	Qoeks3LYbtZFfqqbSX9ahU8h+uuydOYk78EAmoaKwjMtp/m8Kwu9zxnP/ATOvfAGVwSapzMFyV/
	eRpJJvvhqNuKHVG27+puoPg7WATiQik/2my94uu4mziss321BJHB98FRJ9gcOBzdjJqc3Osdr5H
	8FLcTGLBRvXBONz/I1PvNqSpUlmG7Xn/cPCpbZXZViO27UGajP9FeUPOuro2CGDSvImBB1KF0kD
	TnR2RA1+cDSDDcSPAEqPBvpLFd/QhDjCxvsxpS8rqC57Ke86zdLtD8kG
X-Received: by 2002:a05:701b:4507:20b0:1b0:f0f5:e38f with SMTP id a92af1059eb24-1b25d346c12mr2313612c88.34.1793956829858;
        Fri, 06 Nov 2026 01:20:29 -0800 (PST)
Received: from localhost.localdomain ([155.69.103.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a610fsm3783796c88.11.2026.11.06.01.20.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 01:20:29 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: Keep the mutex node reference across deferred binds
Date: Fri,  6 Nov 2026 17:20:23 +0800
Message-ID: <confirmed-20261105-38-2e09963f1b23@gmail.com>
X-Mailer: git-send-email 2.50.1
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

mtk_drm_probe() acquires private->mutex_node and releases that reference
on probe failure or in mtk_drm_remove(). The component bind callback does
not acquire another reference, so it must not put the node when the mutex
platform device is not available.

If this bind failure propagates through component_master_add_with_match(),
the probe error path puts the same reference again. A bind attempted after
probe has returned can also leave the stored node without its reference
for a later bind or remove.

Remove the bind-time put and leave the node reference with its probe/remove
owner.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Cc: stable@vger.kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
AI assistance was used for analysis and patch preparation.

Based on next-20261104 (8b7179210b22).
Compile-tested: arm64, GCC 14.2.0, W=1, drivers/gpu/drm/mediatek/mtk_drm_drv.o;
baseline and patched objects built with no warnings.
Static source review; no hardware, boot, or KASAN test was performed.

 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index dc8e3e917dd771b950167d04c1ab87c14dbabf72..64c912ba95899128bfb1a41765579d9d70979a27 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -630,7 +630,6 @@ static int mtk_drm_bind(struct device *dev)
 	if (!pdev) {
 		dev_err(dev, "Waiting for disp-mutex device %pOF\n",
 			private->mutex_node);
-		of_node_put(private->mutex_node);
 		return -EPROBE_DEFER;
 	}

base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
