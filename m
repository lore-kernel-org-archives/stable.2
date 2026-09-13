Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114C3E49CA
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295196; cv=none; b=Xxx1UqfknhATCl21S0TyqpIcCjQswhYNg6xyamcFDR74aE9oBl/2BOWFVuGn+0j2g/pfZP+2/OItn/yRx9JErMwPUtCmTIg4lkVlJfXmCwmmKqgL4zEHgrsz6no7nFcd2UCYGTfls8Cm5uHJJMEm8tej9hBAShkcFJINxrNsTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295196; c=relaxed/simple;
	bh=dodaNv2L2esAPPf9gI7/H+1Xw77ZgMMMPPmKP2CNrp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlXw3/6RQFt/IxNEQy2otX+Jsh3CFlqcTDW+hak6hhaRZTPQl0G2jmW54rztQC9gCw1jg3k7CQ3UsYRruVB58SSiOorGC+WEyjSzGeLKgC5O/RLvJ5z3TEzrU90cz7Ho9FRXUddSQD4TWZsyfUfPLHnEu1iXcMLjwgZTLeydp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=da271MP/; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da271MP/"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e211a3so797202b3a.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789295183; x=1789899983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5H60KqbS+ROq5wCtUl6A8wMpEemlazNnMi16ohCbfuQ=;
        b=da271MP/gfo19mG0YrVVJqz91eGx3N0UmVzp5csg8evZDXSeh53ViJFzOLi3Sa5d6k
         LrSp+1dK3ZKXJDEBzred51rkXkUYPm8487Cx+yXbRvaVNV1aR04EalavxfTYJtcX0V+4
         ZxnHDwHz36We7DwbA/BafRq6Q95GtTdAoMnjQTWa/+o+d3TS2b3by4mH2jKeAlCNfGoS
         3bRxSTPG6iyExFlUFfVT8tY6kIW1LLDcl4PNwWDSzA5cKAKfOzJ9s7DpyRToYIKk+Je+
         eKgYz+XohgcFng32ZAS3QKgqcq0pTG4Wc2hYArL1vqfUbLoJDPlVPh/Ghcj4TrgSJ6VL
         dBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789295183; x=1789899983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5H60KqbS+ROq5wCtUl6A8wMpEemlazNnMi16ohCbfuQ=;
        b=HRXcPsIP6Hx5iK6yyOaze6EcSTbW5KhPmGHpQ/VBhk5KD+hjOkVpNYK8+/VqjkAKQO
         Egi2B3Xo3aVOcWJ2KTDnnhaKM2xW95DST1Pz/VlsI5dDYHn8NOFXHhL/Q5jNu/9FBEqC
         5zS8bMJMHGPCAgWW6PnbWbJ6oaKwJ07ratvQXbbRS81mnPbbq6Mkd0V7LMlMMYpIRo0N
         opCQb3/ehFZJ/+R0S0iTEiBko69DcntEYXieKQY+sUnknwNbtqwJSIOe3Su7mx59uC4y
         Iea7YnYO8aMjxxTWEWDM66oqI1/aX1KRDZ7dViZdvPoHfNA6yQaJkiEadKMeJDsmFsyy
         fVsA==
X-Forwarded-Encrypted: i=1; AKwUvBxK1181PsQXYThljPD5B3lF6xg1snNW0VJkeV8fdQczosPLM5YyHEGX0EFHQqUYsZKIuF6Y0Go=@vger.kernel.org
X-Gm-Message-State: AFuF++nKnYEz9btwkpubwWYmVIt9JlFDKMweNxeS21AmInniZ2n29iKj
	JZAwWOHjD3FJy1Ma6ftPKxDFlfTfJucQVYCIOHFCZfsJ3Wq/kll/pWoC
X-Gm-Gg: AYBFou0sRHT8YaOcfmInPG3JJKaHiO1hrSPaz+I3/RkJyiW4CEwMtvHAgJ0jkq0nuzb
	EHScUnG+WSrEm1iI6kVjVVh4PKAqnb7ZhLEZMz64VXHu48jH4R/Kobe3RFIDknLvA31QEFS+9HT
	S+MRbpYIqdmBDB7vNFCY0OpIpYJYVI8Jn351v3WezVCTgMHv+KniybkXDHeB/fk7p1ZjfPoFtIi
	ZZ4JNVzpdAO1u/zbTmKaEia4g0V7/cjlMpKUlkKwtypBtbSHdVhY428tTp3T/G2Qrvp5YnevqT6
	J+VTlM70gbpf7+28xAxKkb3s+Csgylr8PCDfODSTnfipwcHJOY08xHKHz83ijBKIAYDhSe7KjYk
	IkZnrBXMXNMhXVi1Gkyj82GH1YmfFzkZSDD7aDwSbm5uRhoHROIl1iS9MKyi1iyBLkeBnXI4he+
	O3Ug7sq/kgDcb4K+uNWDUgjIhnzlq5b147nGS69Q3oDsOSFKaL9/Rbgw==
X-Received: by 2002:a05:6a00:3d01:b0:85c:2d83:bbf1 with SMTP id d2e1a72fcca58-86ccb44e113mr10352414b3a.20.1789295178771;
        Sun, 13 Sep 2026 03:26:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29cbb760sm3126567b3a.46.2026.09.13.03.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 03:26:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Linus Walleij <linusw@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panel: ilitek-ili9881c: fix panel cleanup on attach failure
Date: Sun, 13 Sep 2026 18:26:08 +0800
Message-ID: <20260913102608.1526916-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ili9881c_dsi_probe() registers the panel with drm_panel_add() before
attaching the DSI device. If mipi_dsi_attach() fails, probe returns the
error without removing the panel registration.

Since the remove callback is not called after a failed probe, the
panel remains registered and keeps an additional reference after the
devm-managed allocation is released, leaking the panel registration
and its reference.

Use devm_drm_panel_add() so that the panel registration is
automatically removed both on probe failure and on driver teardown.
Remove the now redundant drm_panel_remove() from the remove callback.

This issue was found by manual code inspection.

Fixes: 26aec25593c2 ("drm/panel: Add Ilitek ILI9881c panel driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index c3d5ab67121d..1a52f92e2963 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2594,7 +2594,9 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return dev_err_probe(&dsi->dev, ret, "Failed to add panel\n")
 
 	dsi->mode_flags = ctx->desc->mode_flags;
 	dsi->format = MIPI_DSI_FMT_RGB888;
@@ -2605,10 +2607,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
 	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
 }
 
 static const struct ili9881c_desc lhr050h41_desc = {
-- 
2.43.0

