Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911723B6C11
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410573; cv=none; b=oGug3whr3tAEN4L3EOFBX3NbyAn/x8rS17pey1n44gc+LNhKrnxZMyOESs39qxzbgfU6+RaiZXzMwd2M9aKbClCVX0Vtqi3AV8STc8SpI9UMInX3yXAMh99H9rRtik3MW6tE+LxMgY5H3M1/sr4KRoK4yX6sklyO0k4Y2OntOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410573; c=relaxed/simple;
	bh=m12Mb+TIX47mD3Oz57lS4dblNLbaem2kqTJU65hzxOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oG67dm307teEZs1pfaiTT2uTNMin2iKcpV0guQh+l8GcOzqipAwnEz2l9Sp5JbvSRuIm96z7OJ0WEx1YnjyDkr5t8I5VXSJawEirtMko1XNaal4J308KPe36wHup+YwajPGhrMGAk3eSOS6gMgWMUfNuxvYUdA8xv7f0ecUCgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8lTUkU/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8lTUkU/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso3998845a91.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410572; x=1784015372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6aDPvskXT897p+or3xpt2a/W5VjcXH3b9UnC1ZCrck=;
        b=f8lTUkU/gnu+k1gWYp5/HLgim0fzhgNpmB+GtNrobD2h7+Vy+6+/hg4mo9V/QzztBG
         zCp3KqAd6sirL+bevssjv2pG+VByci/i/9hoxjq4LT+dKLaXQ2LQ9NGDifrAGDybwHTg
         wqqF/x2t29zpRn62602gowWeU3B/tgR8H4ZsXoFpC29n+pWsAsAdr5a3a4ItR+211GSn
         O7N4FXFAg1pdNJR3lH2OGw4wJ5dn8wvH420BL2NRHZFo4RPcYh+rBmceZZxNdSoBkfO1
         VnZcgng+voE44jggI3xccjNam3hqDfso6ghtssuLPO+TDzLFOXZNBSe29r2RrhVQA0+0
         tTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410572; x=1784015372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6aDPvskXT897p+or3xpt2a/W5VjcXH3b9UnC1ZCrck=;
        b=H7j4uI41bCj1JkboBydc5eRNnQos6yzKXQ9dDS4FTB0v+U/HR2cAWSAEUe2Oh9Ft4O
         ZJHL/M/t3U2gUMKFrWYt6loKfn91U0cNpgANclwZZ+K/XCGQHQh6rb7WmvIwLEEaL/KX
         KbF5dTxHa5Wext8DlyuhzB3Pt2uvwGzUwgNrK+s7FdZOqNxZ9DRDDumiYXe09Q6d1hV1
         WGWCdDW3Ew1BdGwnRgx/j4cmPi6rSNRm0kFqge6PYWWZQ48g2yfFR+1eRRbpcXuqti3o
         33Clw2jYhNADrj9GShORXve4GwFo8WBST+OqGME724PNRyEeGRjGAvbDNYkKLfJKu/GF
         Rnhg==
X-Forwarded-Encrypted: i=1; AHgh+RqxvmsUhlm6Rofl92OadA6BbqdGTo6nHa3dCJjs7DlfH/DIO9eneQhN2HnJO7BB9M28/ybFyco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxARRbjA2luOnnaIiMsUvp06HMFYgdImxqbrlFP2aKNVHTQtZ
	Jat8Poi+udVeNfyJO6JpJ0DHELzeNrYDwGPVOAN9Gg2CWoFEYtvnNb7v
X-Gm-Gg: AfdE7cnBBQkyDm62EHiSuq32d2Y+tTC+dJWzm9OT+aC8jV2pG9P+/9w0AQL+GqG2oQe
	Nnv2vpVXV+iAZv7T7cJuYlTERA+WvkTEbpg27SEgrmUBIRmnFvTDR3+3JGf5zDpeIJvLYxHvDdu
	gxw4LbOW6b2gpMU/lqZUVjeqINfkJEjzI2NU23CVpVsXxi/rfHscvLtlzLCMHWvQzTz9OLDW/ck
	7cZQV4f1lgDJ95M2h7Hc3gGZM7Hy87sXExl6gslcON/Lul0vhUXC+cgijWYWtB8kq4w4WAYsyjB
	oGhe+J6i82NYpnnefC6riV0pwzm5orT+Nxm4wFv1ZZR+izHpVxCjc/m4KBTXNmRH86qyUPjxQVg
	xvHQeeznP26DHL1qroSHU9M21lJBMkwUk1jt6DKhgr1DxU2PdLltnE7Gb1Ewn+78uzfItysZTVo
	64Vxd/YN4CD02k9kfUi9njxv1QCqi0ZBgI2+7pb4lOzDjzRYSC4mdHUGI=
X-Received: by 2002:a17:90b:4f45:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-387570c4074mr3687519a91.18.1783410571866;
        Tue, 07 Jul 2026 00:49:31 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:31 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	stable@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH v2 5/6] clk: mediatek: mt8173: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:34 +0900
Message-ID: <20260707074839.240676-6-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707074839.240676-1-akkun11.open@gmail.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk-mt8173-apmixedsys.c and clk-mt8173-infracfg.c do not call
platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index d7d416172ab3..65dc4489a09c 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -179,6 +179,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_ref2usb;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_ref2usb:
diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index fa2d1d557e04..8b69009e1965 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -128,6 +128,8 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_clk_hw;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_clk_hw:
-- 
2.54.0

