Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6747F3DA
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468436; cv=none; b=XIRfo+aYWqBq3l70ytXbM4H8LrzPJNcvtYmxEuxADB7zJbBiLEwentsTCwy1nFFxGhb8qknKyP7Rb77b50ZMO/W27gxvSFSRXfoySz7bvTL4ftOotcUSLc7uvxysZLT2wRswTvysRKsq6HHk6zJdlQe2cmIwEcrYfbUNJ8axQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468436; c=relaxed/simple;
	bh=24iyB0qQIhRBRLcksSKKzm9eIHZVgNfeEOfit53HP7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDzSMd2n6h9/6Szj/a3Cm2IsADX9b3l/R41fEQSqLmpEfY9AkMBd8ziLmP0gWjnzdlMzk+ULNGdircflBLaAsQOjfwcV+6235F8WLclpp7C9vRcdlhW6eIYInF9mQbuJpGX0dzbHHtSqvmOdKdCY85VoX2SrRxZWZrUMMRLFua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0hxpsZO; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0hxpsZO"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa65080so18532766b.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789468432; x=1790073232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA9NWFMPC9pCLE/rtR1qK/Zvon8swdWRLmKM7jQZ0lo=;
        b=U0hxpsZOV2ZwRr8HuCE/aCrFM/LucWFFC6+C12Ye+qwO8JjW9GfiSc8BgMy+aAWQio
         DcB7dehQ6+si7t9BFzEzgW99jtBOtzZ7MYeA/5xDjxCEPe/bmYO2tFVuUEW3B0w4rOxS
         Bm8eSt1VPJPeV2wHzohX8z5ywXAcFDl/DAGhxx+KnNyQMEOTiIYDCjbye8NQStjQMW6h
         C7GW/xO9ZVxdIGc8W4xRwIARxbLe5RNYJlEXymRVvrxLogS20hnauwXGdzLl0jISPJav
         7MAZbXSIZj5QfDQjIlgJVA9s2Cx/p/mEh/jyB1M/ELEVhgOMOGg4Kyf3/Ndd1/zExlHr
         YcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468432; x=1790073232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vA9NWFMPC9pCLE/rtR1qK/Zvon8swdWRLmKM7jQZ0lo=;
        b=A+OZ5CjryeH7P+ZfxFUtfPDLt5MeEdeVxnC6YNOOz2z/P5hD5w727F9hg9Z/gsHtjs
         zzM9lfNCWMK83zAXX9p+YBxr+lGuFrNKBRa0A+Dx/oT6u0qmLTIlOTaH5xoBKSH6Dl7j
         PaYAtha4gzw/qnSq0tCk0CXXcjBx342hQcbznU9V79m9hTCx2Tng/17EFnua6LwmswZw
         YGR+7RL/5Hw6swi7+p731pR5JUmk0PYX9sdH6gIMw5Ql47UuzO4GUj0Fsjb7Bn9wEpmC
         MPPV9ZIP3A6J7t7PrI80yEkquNbahR9y0Yy/xnB/LRPucSEwYl0LkfYMyVu1xpLcUJcz
         M62g==
X-Forwarded-Encrypted: i=1; AKwUvBxf7rUUK/ZCvBfocMCKOtzgrkIApKkb9nbGi9z4xTpV1kJHHYGfJipBPzz29iqWNg7Wl/Y65KE=@vger.kernel.org
X-Gm-Message-State: AFuF++mVZp+uI59hQN4Wchjjf7Op9SI/UBgIzdiwCw1bTCq+HFEYPSwo
	7MI7wK5cOHvKpeHg7yB79cv879tedgxsk7dT98ed58YZxHvxexM8v4MF
X-Gm-Gg: AYBFou0MKmfaV6M8k18wmFFzFmLfmrVP6bWkGnaOiZWqGSimKwa2Z4n2qWYmER/mADg
	n4athyN9Zf4gZi0cBupBSJ2ZUMWf5yKKfoBcYupFZxAm4wIduwfXJ2p4dMW2rFUWiN89N8ppYOi
	M7uY2HeeYHYbw+YiMioE1hZpi7qJhmTevbvWYTz4ZxkRs4Iwke2wbPyrRhCEBct2kG3rVOaLxkB
	+N36r08iQpDbHtOWWSEovpaF2Cvsi+rR8UwMCZTWFbTbKyAoCJ9WuKWmlEwg2ftw1BhaNVUrHmM
	JcB1xrockHt+YQ3D/7x4LxQ0B8zcSFt8rLo5I/hGoED42aFcrZtnrjeTC0iBh9ASSJ5O1EqV4TJ
	pKRL1J08am1y72mfqvMOQTbXFsqmNmbrw2l6ZarA/QJ53i8gdO15BeuQunasOr6hzYXLQcNZ5Sg
	zxAYuqgE8JcqZ5zmfu2b/MN15OolTy2t+pTBC4owsAgcyub+Ur1i1EPIIdjyPwPWwuqVYS/ocRN
	xTY7IAvuxNorSnq6th9nvc0kx0phfQBnPxP+tLauX+Y+dUmklTFAsP9MN9UrF3AGgKWIbkJA2wR
	qN+KD7eSVUSQuLYNyH7Yy4zqYK9U/pBbKwDcQyyqzaOEivqeksOl3A1H6pLgSKb8z3RL9NZCVKz
	cLyBrPfUlmVHYAQodmWf0GloFuI0VGz8LRDRKS0T4xK/AvUdxm4Q/HXJ2sP+6Xs2SGuJ2p2EU2V
	hLPCReqfXXgSC0/CgYvukXqp/+wrwGDr6vXBFDZ+uMw4tSHzLpg9WGTOK8IncgNLpd0smjN83S9
	y8yXoJ2mrPJ1mKa
X-Received: by 2002:a17:906:7307:b0:c29:5a76:72be with SMTP id a640c23a62f3a-c29d78fed36mr38938066b.24.1789468431681;
        Tue, 15 Sep 2026 03:33:51 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (219.40.147.34.bc.googleusercontent.com. [34.147.40.219])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4e8a1sm566041866b.6.2026.09.15.03.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:33:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] clk: imx: scu: add missing pm_runtime_dont_use_autosuspend() call
Date: Tue, 15 Sep 2026 10:33:45 +0000
Message-ID: <20260915103345.1334-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915103345.1334-1-joshua.crofts1@gmail.com>
References: <20260915103345.1334-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

imx_clk_scu_probe() disables PM runtime on failure, but doesn't call the
pm_runtime_dont_use_autosuspend() function, causing potential resource
leaks.

Add the missing function calls.

Found using Coccinelle.

Fixes: 18a50f82cd2f ("clk: imx: scu: Do not enable runtime PM for CPU clks")
Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/clk/imx/clk-scu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 44220e9c5c2a..18f73e679331 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -525,6 +525,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 		if (ret) {
 			pm_genpd_remove_device(dev);
 			pm_runtime_disable(dev);
+			pm_runtime_dont_use_autosuspend(dev);
 			return ret;
 		}
 	}
@@ -533,6 +534,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 			   clk->rsrc, clk->clk_type);
 	if (IS_ERR(hw)) {
 		pm_runtime_disable(dev);
+		pm_runtime_dont_use_autosuspend(dev);
 		return PTR_ERR(hw);
 	}
 
-- 
2.47.3

