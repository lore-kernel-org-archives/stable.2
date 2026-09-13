Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8323817E
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305544; cv=none; b=fCUcugSBrIeqDZbll3j5cuRo+Awkr8iPG0GKWYNQUrNmFGr3WidqJ75YEbdkFGCQDbpznsUNk8k4VpLrZrL3Oya2nKN6lpEWB1A1gUoQ4+GfQ92sTOASrGegVLDG516Rr0+dul+5KL//ljQwLNsE3oWaSDydKHuTqynReAHz09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305544; c=relaxed/simple;
	bh=MNEB3uM9fk17gH3lCK0TQ0HdXUzZavXN7I2Fq7ejFto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKfORKH4+kTf7ewDYG/hOrOMtn+bmkqKEKR0+H5AAZPAaZ0Ihc7ZDRQwl2vd/vJs16H/kyvul71pKQVBgfhYGpXuCb6IibbR1+CwryjBf5NcmIEOhtKxpYedOXU1tGkG7Ds/GGXIBxqIjmExzGIBsRQiWQHpHnBeBOItGgUZFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDhwE2Dw; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDhwE2Dw"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so1260599a91.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789305541; x=1789910341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzrAlMcZ8zBRfbQWU5o3RvRaRsPXz8ZJNVxN53VL4HY=;
        b=TDhwE2Dw/ai1Crpx2VWu1BelXZ4CKT1kqlcorok3bs7xwYdIM/uwT6wiR8NIsaOsYX
         kSw6pEYIv1YU3kdoOnMuUXf+Ppx07DrFXsRlAkt4wIkh44TJle94rG68P1ZOFZXLYTNg
         +emi43Emd31AfBRQskLy46fyZr/UkVsloPqebPgVqAONXpWxNsvikupaH6tAnHXW4/0b
         CNVP61h3hq/WFQMZQrMpKjkWyhGJRDHisWwdu6h6ND5sGA7sMj7o52ravNHoGQnJwmKw
         GC8QZKYPBxUmBLoyRARt2mnJl1QZ0k9/2l5xqonAdHTYfyFcG+DlAHI+XJ5Sfs8pxxdy
         we+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789305541; x=1789910341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BzrAlMcZ8zBRfbQWU5o3RvRaRsPXz8ZJNVxN53VL4HY=;
        b=Z+bWHBXQPuMZaSIoVdqBFisT+hnua40GiyT91jXW+ThUjfOe3N6XU9wtqsEAG63TxE
         MhqBOCiNhWMi3ks+0Q55JdmrKMbQa0T+M+cQXGLQYfMTtVGGCwHeE2Zbm2NTgysw8lBI
         CxG16b0eHKKs+gfQFn2cErE7LU75vD+Cx73FpWjBaFk3rTSqO8MyY+gAe6fBQYF5USjJ
         K8vFDvPJQ+dy/j8XG5AKPJjODqQc46a2Kz8qD1iVO6nYUmLmB0evhfztjQgpCLdix8wv
         EdKw8BfM19GS2/ZFf8ldcnuR/54WhW+6lxsuJ6qz3jQTSddzx1nPIjjAeAb27PtDvgNd
         pdWQ==
X-Forwarded-Encrypted: i=1; AKwUvByTntk6txms1XYNj70PAIhwp/tnTkppaFAzwstcgwgg9CxmtoyBlkic/zHm8VEuIuRlSHrvelo=@vger.kernel.org
X-Gm-Message-State: AFuF++k10L+Ynx1iHzZscSPO+5ocR2p2o4aaUpJ5t8Ze84LO1XUV999A
	SBaLLfAJs2kLVH0kf7yFXWZGdbxabuyQZ26Z7MXxMB5vZjsWvPKldc2O
X-Gm-Gg: AYBFou1sEJVMc71EF0D19xxPtqE3J1ikZpDtZjR7Ts4Er9qwKiibwIu1bPnVXV8/DTO
	V0azG1qh9nIOOa6+MUNIIKFmO8UUnGVPNdgnXfDZGJLYg/xUKr3yDwK1BRXEbHYYMZaKmaksh9M
	iY+jTdofCd5qVEMKjcaGQe3vGYpA/pLF5iIP3xKUHnB5WDbiK7uqpk8JDmy0+ciGT8IR7WA6ger
	BV7EDwMGzhftkTxT0ktb9GQjxNclWkDuk1jF4IUYLbUBjKqChYoQ1iN8qY0o8dpqTurVn0rsfss
	xbuR9grzYngwszuaT6+0x1B9tD6bsX39IQEMWwBI5xyBzTk3rikU9R51GLVPc6koPNJGWnkbwWG
	2fERqfQwk+CfSw2Z3tI6oln23cKxTU52OsiglknmG3fuot3BsBe4meLOcAcAGQ8+sj0hNaNmcpN
	pkNEbzO/Xw52TvgLlnpkypRh+To0uxc53IOU+ForcNHuzXWe9w2r6cqj9B3ZhvZl624g==
X-Received: by 2002:a17:90a:d64e:b0:395:4de4:92be with SMTP id 98e67ed59e1d1-39d9c1db130mr26350180a91.13.1789305540739;
        Sun, 13 Sep 2026 06:19:00 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95095946sm15749780a91.5.2026.09.13.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 06:19:00 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: novatek-nt35950: fix potential use-after-free on attach failure
Date: Sun, 13 Sep 2026 21:18:49 +0800
Message-ID: <20260913131849.1561742-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nt35950_probe() registers the panel before attaching it to the DSI
hosts. If mipi_dsi_attach() fails, the probe error path returns without
removing the panel from the DRM panel registry.

The panel is allocated with devm_drm_panel_alloc(), so its storage is
released after probe returns an error. Leaving the panel registered
therefore leaves the global panel list pointing at freed memory, which
can result in a potential use-after-free when the stale entry is later
accessed.

There is an additional cleanup issue for dual-DSI panels. If attaching
DSI0 succeeds but attaching DSI1 fails, the error path unregisters the
secondary DSI device without detaching the already attached DSI0.

The failure sequence is:

  drm_panel_add()
        |
        v
  attach DSI0
        |
        | success
        v
  attach DSI1
        |
        | failure
        v
  probe cleanup
        |
        +-- DSI0 remains attached
        |
        +-- panel remains registered
        |
        v
  probe returns error
        |
        v
  devm panel storage is released
        |
        v
  panel registry contains a dangling pointer

Detach any DSI hosts that were successfully attached before the
failure and remove the panel from the DRM panel registry before
returning the probe error.

This issue was found by manual code inspection.

Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 94aa6489d99f..8edd0aa363ce 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -514,12 +514,19 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 
 		ret = mipi_dsi_attach(nt->dsi[i]);
 		if (ret < 0) {
-			/* If we fail to attach to either host, we're done */
+			dev_err_probe(dev, ret,
+				      "Cannot attach to DSI%d host.\n", i);
+
+			/* Detach from all previously attached DSI hosts */
+			while (i--)
+				mipi_dsi_detach(nt->dsi[i]);
+
 			if (num_dsis == 2)
 				mipi_dsi_device_unregister(nt->dsi[1]);
 
-			return dev_err_probe(dev, ret,
-					     "Cannot attach to DSI%d host.\n", i);
+			drm_panel_remove(&nt->panel);
+
+			return ret;
 		}
 	}
 
-- 
2.43.0

