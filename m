Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A581F91E3
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079895; cv=none; b=Nk8LJB/RenJ7EXMpaO8QVjU9wmco/RYxdLmy3FgUk1v5EupMxV1EDUf06V3EQ1/dya1u6YIGBmidfzDEG714CU7d5K/n2MCcCMaFgPRfmAD0q429BTyFMWqA2ueZ/hPSCPjJhItcOrVEqKkhwpgKAXbWY2nRZLiqFmhlmazTg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079895; c=relaxed/simple;
	bh=SWt2X1DGCJzAIa/CTdS0MH7oV7EwnCVO57QQ71qYkXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cvIsf6p7oJs29ToZo33qikEDdVp2ci44JtO0Z5iLIq7ZvLPu+uUTWCH0W6VJSPvoLQr772sN3ltCyjbJyq/R/RCokLi0lH2Q7wbsJFSNYh2C9PeUPmOCU0doQ2mhQBhFNHMZjcPCPOHlqhcjUpGF1uQ1Q6oXFqFrC+Rn27qon1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDpNHDoV; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDpNHDoV"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa6so33409885a.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789079893; x=1789684693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw0J18o8NMgLkUQr/yomujhpoAzqRd78S+D2/pgaPdk=;
        b=VDpNHDoVhUrSsfqmVRdXCj9UD0ePzf+7+bqodP9PyaokGXpHIuFuUUKQJImI4Tk5D4
         fxZB0DuBx8d12XhDMo/QurqT7zW3hX/JjPJrufCXyuydkFSnP0yC6N/6mn08hoLoSDNu
         BU2R/XNUaZCvdjoOHDG8HS4fz4tUErwdKnfWQ26KNsJaKzTQK08htB1WIBMyo9FSbbh+
         u15IqCBEFn0LBcnGn89X9+YWTVeVCWuL0xljcbwgtOMpxlisRCsOLiQW0e7ZiAj8nV30
         FLZsVa/N2C5uPatcuk6V6mNQHKh9fogL+5nkZrd9GfHgyoIgWDq9SP+WrlG4F0Jlwd5e
         GnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789079893; x=1789684693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw0J18o8NMgLkUQr/yomujhpoAzqRd78S+D2/pgaPdk=;
        b=D3Gfp2euxKlNHau9Nvm4QzRAhUJwyxQdFHBdWDr3cgdBBDutTWM0diT6YZlwuXhKVK
         G9+nOiceFaJWbCGkbY0XWbSZ4fF6Q5bxnHYaUU8iMXzATuYXwlbIOsv95wJ1v6Z9fcFO
         /D1PHOUIjOE1gBwuCTog5zxVpj8xSvACcQYpV1uBMnoS0KJlwMSex/MOtBXtZjVph3X8
         BvscFI1fQji6bFWAy6Keb50s7tH+MVrHhJO/VCFVEULrfgEd0Vby005MtRvxFUT7OyPe
         0UXkaaSRQfb5Em//93iCH3rDVH0bevIvj/bNnbJ4DkJ0AJTCbUH9Xq94JU/RPpQGhn4T
         APfw==
X-Forwarded-Encrypted: i=1; AKwUvByewvZugDqSaArKmo5HRg3psBlETJ3r6/Zvf+X9nqjOHl4zDKz+J7fRTZdWYjXNNSbMH9pXqDM=@vger.kernel.org
X-Gm-Message-State: AFuF++ltITNUb4Tu2dVnVU2uo+c+FKiUu6i/0zMG6ht3iMbLJzec8nYn
	3dWGp3OYStxF1VhGybX+m2nc3wj/ivdAEA6TpQOTdRBlJ5xh1xOV69c=
X-Gm-Gg: AYBFou1YOqho1gPa632ebXku8ASP13eOorjJQl74EVyWcGv4ZnTzjSCqp93ydT1pyVX
	1H2C1bieeY6JlPt3kYJMxdex21u/RDimXZtU8vX8Ligkp/zFsV/HmF23t4BxXlYC6M10cICUM8o
	FrCEmMZaPXoAqIdEcWY/C5IrdtbW04HuKvLo8Vv1V42eXq0sDXjeIyBO+fzJj+PTs1WxMs6yS+u
	Wa0hSiEGH4O1P5Wepr8xG8w7P9N8jCWUQZPPoBCqxoVpB6+b5/UYTfGXrbi/8sJSWqHuEZJgcYx
	OiM97eKXYnTKRtIdV5/2AgNINE+T7qbjVQGP08xgxgdrBAsNgM51bTD5Ko+pPybiV7vbrIyivOQ
	N54EomEH1G5FZDT43VxCK6wB+TydmjvoDsPpkQhhAE1+cdaVCscZOP17nzch4Msx5Yq0RTlQtlw
	xyLatkjHlOzpWOqJkzrcUYgnf6vte2tuk481wt1FVHV3Xz1Ao86HEwXzYqs2osOuwkVqD+uyD92
	h/7NHJhL+0DJINFicGCW1qjM6DCdetFQ0kndmuYrmYwawTGm4xpzQz1QbI2/lmscYUQRwpRNs7P
	wQq38QVgQDxaxpO8hWfKcanCLi3HZKIPyg==
X-Received: by 2002:a05:620a:28c4:b0:939:518d:7f6e with SMTP id af79cd13be357-939ea137501mr198587685a.22.1789079893180;
        Thu, 10 Sep 2026 15:38:13 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e803dc90sm90487685a.17.2026.09.10.15.38.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 15:38:12 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/panel: simple: Clean up resources on DSI attach failure
Date: Thu, 10 Sep 2026 18:38:03 -0400
Message-ID: <20260910223803.8552-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If mipi_dsi_attach() fails after panel_simple_probe() succeeds, only the
panel registration is undone, leaving runtime PM enabled and an optional
DDC adapter reference unreleased.

Call panel_simple_remove() to unwind the common probe resources as well.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 210fcd9d9cf1 ("drm/panel: Add support for Panasonic VVX10F004B0")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..767068de6816 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -6552,11 +6552,8 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->lanes = desc->lanes;
 
 	err = mipi_dsi_attach(dsi);
-	if (err) {
-		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
-
-		drm_panel_remove(&panel->base);
-	}
+	if (err)
+		panel_simple_remove(&dsi->dev);
 
 	return err;
 }
-- 
2.50.1
