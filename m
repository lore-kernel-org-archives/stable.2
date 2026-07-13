Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFA38D40D
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942876; cv=none; b=BBziCglQF+u+1P1wWV/FpEbRs9qrdNMYfky1CNciyTnx+C51jDGrmWFdNo0bLBH260kMzEuDM8kr/qcdFU+NyUOT0yj7ivyG7DziuULtKfp0MJs4mkc8Z//Bt844c2xG5HnAydC0+AhT/JJ+anuKrLCVNAtHDxMeJC3JN+NCvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942876; c=relaxed/simple;
	bh=DF8JWJfNh6M1Sw4cPR6Hjd+QCs0193pYYptH/jXmmFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlXi9FzMmZaGC1IrltnZuQbApINsiHYwEya5OELeB4Nk9NzUITRKc29EaDEN9PiDniZfUr4WQ9aXatsjtk6JYXF3z+oMoexCeKhOGB+1geRPVNPmztPqBR9DqINvOhnhJQyxdc/u+Q5FmOMvoW3tMluNuX+Dgd8TvJNBjtKEkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4PRoorD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4PRoorD"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca0c5799eso30343395ad.0
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942874; x=1784547674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bjup8tkbZReyLVbx7owWNWJpf0WRCU5BarQCoUzbWwU=;
        b=I4PRoorDO4Oia6Gdwk/Kc/D0+f8ToiOYMGTUk6lTcb7FsTAqOMEkCjZlap27qNdGUd
         pTL21PqGoj4S8mZIWr8Z1j+qRCSgi0IJw20qAACd5co6Ay6PT3iCu3vSzCA/Nyo+y2yK
         t8qYUWpKln5W1rLNGUtwUp9L3MttmDPhfPf7phjh8RDCwe0KlKbkQ8qvgL4Pz/Ut+6Rq
         t4NmddTc167tRLSXEW1JVdybAjE3K0iIaJP8A9guPUzD0uE6+KLw3djuIp5n/U5NOEbk
         9Y/0vMyC5FIg96LRDdpr6JSjpbc3kfABhrqBEM/FsuS7ZTFwbC6yoJPhYfeVl1BcfTIv
         TefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942874; x=1784547674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bjup8tkbZReyLVbx7owWNWJpf0WRCU5BarQCoUzbWwU=;
        b=UUADFWTvmdJ7+45jgxcELgHMYKVwaNIfIkr1t2iBeNKeqG3Jn8gOtGH8CTjOdLq6GC
         iGYLFMavXtS6EPzo+8h+cEQ7KGHe5vk6ewKZNOSaEj5h2Ip5umD4BnE0gSn57kBca8ot
         Nw+xz6WXpKuBD7akOa9NeAmuZQnNELukqwlFs0TG/PcFXKQk5dET6y9aUmWiHbmZICUw
         JqogcCTpckd2jbM+Uv4zwJz6lCx5z+SO9hU8kBCvA15fRgRPxDD6pKBc21DkEVm2Zhrg
         nbfG8RsYoajZRRuSz4gJNNh5zBuzAtdj6kwgMX6TgyUrXLiJ50n7uqlkXVEuMwxPiwLx
         v4gw==
X-Gm-Message-State: AOJu0YzY2rnAdGwI3TSZ2BS2QeU+ekHD9PZKTqjksEOQ398hy+zeFErV
	vsWo515NJUAcaaBp4kjL5j3jZHEoomBiqoXO6+R29/WBKo0PHtRuod72
X-Gm-Gg: AfdE7cn6XU9IEWy6/nWTf7llvhyMRhHQ3ckW6yaWXDAgHILH5GdfZDCw5f1CzUI7rP+
	L5DN+rbus47A1r00snBLcD2sq4IF1jXbTNpNOfxFKAN0WhPniRpRZCAgC0iLl3mnQD+bNpqHyeh
	EZtjqQtCRWnrwXblaieypimZmirO0I6uppD8hslc6NQSCKgFQ6u114tQW5tuv0Fuu2XQGin8NRA
	8gEGOcsPYzpoXzdUD6uOgvO7HlN4Fi71iHiNrrCi4MVoWvvnHxOQOR9zyoZYeoEs8TdOA1va9CJ
	9h8bRVHv4KOqdDbdLbNDmU7tYF4xePM+SZM3mJQfVOWdSHDQXdYlpD6OO/KgcL1SDdz1ggYAIOK
	azrYe1B6BGxFIfeH+f3QeX8Tx76GlRQJjUV2bEwv9WM5CykInxwWvvrgTZsoDZQ2MRAvwZHq2lQ
	1lX6AmTg==
X-Received: by 2002:a17:902:ea03:b0:2c0:e2ea:6b0c with SMTP id d9443c01a7336-2ce9ed181f6mr81660085ad.21.1783942873961;
        Mon, 13 Jul 2026 04:41:13 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e33sm95978515ad.74.2026.07.13.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:41:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Johan Hovold <johan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] media: platform: mtk-mdp3: Fix SCP device refcounting
Date: Mon, 13 Jul 2026 19:38:59 +0800
Message-ID: <20260713113859.921358-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mdp_probe() first tries to get the SCP handle with scp_get(). When that
fails, it falls back to looking up the SCP platform device with
__get_pdev_by_id() and then reads its driver data.

The fallback lookup returns the platform device with a reference, just
like scp_get() does. However, the fallback path currently drops that
reference immediately after platform_get_drvdata(). The driver later
still calls scp_put(mdp->scp) unconditionally from the probe error path
and from mdp_video_device_release(), which drops the SCP device
reference again.

Keep the fallback reference until the existing scp_put() call, so that
the fallback path follows the same ownership rules as the scp_get()
path.

Fixes: 8f6f3aa21517 ("media: platform: mtk-mdp3: fix device leaks at probe")
Cc: stable@vger.kernel.org
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Add Cc stable.
  - Add Reviewed-by tag from Johan Hovold.
  - No code changes.

 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 8f4da4cf55d2..121b1006ffdc 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -294,7 +294,6 @@ static int mdp_probe(struct platform_device *pdev)
 			goto err_destroy_clock_wq;
 		}
 		mdp->scp = platform_get_drvdata(mm_pdev);
-		put_device(&mm_pdev->dev);
 	}
 
 	mdp->rproc_handle = scp_get_rproc(mdp->scp);
-- 
2.43.0

