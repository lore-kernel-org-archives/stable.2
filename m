Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25D518126
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904690; cv=none; b=TOLMErFqEbn39gpHrIuDB3/FgcJ6AjBwTJVMviJkM+eq2xZuhtKUysXwkDpIndmpTednfWmy4KlY+0Z4JpiY6DyswhAOnL5rNwokBLyfs8RBniY1PiRZJ5llgi2j4YsmQVxS+SIYSe1yQZsZi28g3Z0l0yzh5i6tweNYayW9iGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904690; c=relaxed/simple;
	bh=7DlZB5ohOTDO++JHQmyJzQds496TZQWC7PQGSX9QedY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMuQE3It08/etmOEYyiq6MEe21zaNnu8bF7CUl4bDnqBbRJVQipRvka+e42bYQc6EmvBI/BBsfQ8sKFtb3iLNEHjxuBVi06d4VXNPK1dLPraWx+Q8YNcs8F/v6VOhTTNxya0pEygGkt9qqZWiEQQi0NCnRDLXTIQXk2GW6QUaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqu4As53; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqu4As53"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88c72646f03so1503483b3a.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904688; x=1792509488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fz/KT7FZQnrnf1XyyeQ/9bz8jLknhmPBerRCaK0Q4Go=;
        b=Lqu4As533xtTXG1S0StY3Xmfst4JOGSsHBnuGi1dBmsDogMp3e2wOy71DwopTnVb5A
         xPZZjfceBMx4CaB+73lGmUwWFQnlYM8vpGpesWQwXxkU+Ar06LrRqqP7ZnzRr0dOJZZ9
         aGxjqugupBARKpTzhx15noVfw6YR+/ZTBx6uru4vCi7ttMUVBxP7kndQjPcxbaUZJYd6
         RyqmkuDOre6DWiRHIFe3tkOAs0ZOusfVlX61JFrz7O2LOD/vFf70RNNOTSIy9Ym8+/fR
         RMYqbPe4ilWNHPYMyUpl6mFoV8o4Bjnl/YGAOz/JsGM8uCADAFEQXbsu6RsTAgR8SH+k
         x51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904688; x=1792509488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fz/KT7FZQnrnf1XyyeQ/9bz8jLknhmPBerRCaK0Q4Go=;
        b=tQf20+fPw6uE5tfrS4iyXt8CCjbs1IQ8DJLR8rgXkpgxtyiU1vfKAEzFrvMA9Hxl9D
         pmy17S+ap4Vbr11W4+qf9F+LryAg28+xszyC5oCEyoy/ZvIjx+NZaZ2NWXVsElMYMlsO
         c7BCYLsRCu6hvDGOsIr+HuOIAI3r6DZwLjfRCpD1qx6fso4L5k009MRmDdluCLjTZmKr
         B/yhmQPSdPN2Ltn6bJSKYCxLtNRpPMbCfP5sjcEVY42Ytu66UnfAp4s0fQJ8s3eImDwR
         aQ8CTJ+EixvePckXCqhHJ6dL7mNWM2NZQrKMnmNWgZd9pJAvWlrYGqOlE6i5CnvjAGyM
         3BoA==
X-Forwarded-Encrypted: i=1; AKwUvBy3kFPPeiTai5F0+xHOG6jJZICDgIW6ImNgG7Ug9Pxo+sgNbb17ShNbJJLNHRiiRa0nWtw1Tj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoBVe2ygTAxKZjsg/XThrkszavJGI4phg2EtKtxO4JWhnD8dzY
	E+A9s/nWpc+CoM0xJciMdbQ880P0gDmMViBuJ5LYE8OVZLY7sCViLmYH
X-Gm-Gg: AYBFou01eW6Klm/rvh3PzABWr8+ZeZBx/RrMNQjNa4DncWw1YCKhWRuGsoTnh7hZvfU
	ys76qO42YkVYLfIr5UnCGXNbrxZHUzg0LIJm1pZq3Lp1AwqzxvZl2UjDsa9e205/rIHDdUkiRd0
	DtbLPVpUN1rpiYdXp/aCim+xLZjPIoJKH62yB2Kfa0vOAWC3vg0fcbMZOfLONyn6G0MAW7xcqv1
	iyoBVpwPZwtafpkjKpCIAJssO3HR2NP9zhsR3lc0Mk0vC+CwHfilydJZyRSkeUNoI0pSbllqJ6s
	a9zwAsNO2pb/+btjKo3OqAo55tpucSS6lNq5BW4hD3YcIzqVlKsNYu+vnHFXbLSeplKvY9HZZgs
	t0UpXG/dpAlXFhjh25D64PR5RFjEc9dHrMzwGWg3vzdCI2QUBLeqMB7KVlY385v6EiyYCmVtX1Z
	ncWkGDu+Gz+2LJ+9hKLpjnEUHAAzqW9IPJcLj8XV4zCFX/RVE6ZwPUCwV0+KbG/IviIVCLADSVP
	ISJuHn3s6kkSmUMWq8Qf9iUrVzy
X-Received: by 2002:a05:6a21:4eac:b0:3dd:a195:fa21 with SMTP id adf61e73a8af0-3e16bf54ae3mr10356368637.70.1791904687938;
        Tue, 13 Oct 2026 08:18:07 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:07 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Miles Chen <miles.chen@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	stable@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2 02/35] clk: mediatek: mt6795: Fix memory leak on module removal
Date: Wed, 14 Oct 2026 00:17:01 +0900
Message-ID: <20261013151734.3177690-3-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013151734.3177690-1-akkun11.open@gmail.com>
References: <20261013151734.3177690-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk-mt6795-apmixedsys.c, clk-mt6795-infracfg.c and clk-mt6795-pericfg.c
do not call platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL, which leads to
calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 0d363282bb0c ("clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
Changes in v2:
- Capitalize the first letter of the commit message: "fix" -> "Fix"
---
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 123d5d7fea85..239a3f5e1760 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -175,6 +175,8 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Performing initial setup for MD1\n");
 	clk_mt6795_apmixed_setup_md1(base);
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_ref2usb:
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index e4559569f5b0..914bb069aa85 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -116,6 +116,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index d48240eb2a67..27d0ef7d7b2f 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -125,6 +125,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_composites;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_composites:
-- 
2.56.0

