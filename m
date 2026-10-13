Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876B530DFF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904707; cv=none; b=C3m18V9+HLKgGZtJNaBItCSjuP8wqRzlDpgEwELq1VNj24vGGkBSu7mIK4BvQecBD7Zg5EgFtkgwf1+Y1vjq+BMPoiwAq9/Skz5nLnuqLJOXivrm4IjgSDvohPBU4ZoEnTqtkjsUHTLyMDAmkLhgHZYo2nUpOda/oq6p+64CkDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904707; c=relaxed/simple;
	bh=bP+OI5XWAwChiCcP9BrkzwzZMVjZOHDOY48stjGhON8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnmA/TIk2GagjDMA0H8YGdECyiCx41CvZ/gj+5ufWmuWXGAtOwsWh+9xdWvbIL0ozIwJ5lN4rpBgDXFqgx8wtAzuBfsayLBlrOPvNVM7h9/6NMmdCk7+FKvtORYAKxKeqNi4J7su43h/lqLokxW3mIU6xPKc1cjQmutR4Rq64sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/aUIjfb; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/aUIjfb"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-881269371acso2512435b3a.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904705; x=1792509505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AUYTFLfF8KyYjB9jrAOG5HypNcpJe9ONDAWrxzRVXzY=;
        b=X/aUIjfbc7FShqq/ZU0IrOcb2d+D2N4b9WROGw8/uLR5udERWs4dtLFJ1j/v5KZSWT
         fEGVINsEngAeVPO9rt5aZg08w5osfFCEGdAecnIKieT55+DT5ypL+rxj07ExPLXswMLs
         F2/kDt2pz4LBZKIgyfxQb41uMj1puTOYx2G6oSqZhs5wlYiwEXokWJRYnN+2ElLoLakm
         gCUK/WvDAPfOG/SRLiFTpVwmic90FouEaeSOqQNQ77aFRChZ7WrGxQjl2ESlQtraLPso
         C4ctozFgnZRubSVWWcMFY2wiDicSdM90sZuOLew4bc/Y/50mefSA0UZLAMqjyX7mPZX8
         1XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904705; x=1792509505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AUYTFLfF8KyYjB9jrAOG5HypNcpJe9ONDAWrxzRVXzY=;
        b=TObcNzh4W87FrwwLzAAB1pVWVHOlKEvSZi+6yh/EFwvyZXORtlvuECyAsC9I6eqEcm
         jGvZ598fLmnvcwMSXzg9PNrJNWZ0eFtq1d6wk/MWL8f/JcsOF4ZRC/R/X9bkj3LBGgeG
         9K1mtdaHmT7tiAZEfRDDyVlxaYvQk0VenoMFjjgO6WXaFKVww1BSrZZ3NGiMBjDjNuul
         uNw1lJWCn3oE4pJtybxsNUjA5AYampPUyxSeGQB9CnciabhxeLF0W0YXaTjlh1fujD3b
         0KfGYwY7D7X4ZTYhUtz4QBGh6jzA1PzhBPRUR8bePS3I1ncZ3Jjt8IN3WUemmZbWz6gg
         dSqA==
X-Forwarded-Encrypted: i=1; AKwUvBw4JeO9lqlnvw49+QLUOMR3rCCX8mkWxpKCQZ2VPHeIGs06pk1MtxeX2JGPXyP/ls3j6kTk3+M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoH27xgOoI324kn1GgrYRuteQHjr8kmz3xHQyk8RKueBwAbTFJ
	3+HDmvky41wBe72PtxsLXjPIUiViyKYXVvCe4RPg9zIFCvQ4L64QOEX4
X-Gm-Gg: AYBFou0+4tm+nMguIuvMUL86X4wmX6X1SHEPOWOJnoMyTIte8B47YLWnJllc3Kd/F9l
	2zqTQQ8qeq4irwrpXQ2DDPc8t5epEM58W7AX485qZ3X6jE5f+TYL8xBB6T3H8vtF6PCdNbI3JEz
	TPsvh73v1Vpl57bNwrUmdgL8tvIxtU9amh/kfOsZYW9nEP8cDwjuhJ/BJIG0Y+YDGLP1BYujvuQ
	qw0ODoFonu0daP17/+lKDxKEkyds/D8N9jaOCbk1Lou66tVfBXUAGyz1LDF/Ds17hwZS6lGqRl5
	SuZjMpERUZiZltW/EV/y2oo1h0OqpbsvLWGII0o6PG33lCjsOWbteKIsXYBzx3hztFUM4D1eAhO
	AZnSqJ7tJg3xThmDymTa04B5ce183EfscOlGHjJSTU4HQkvaM9R7WPbDhbkGUulDEm6d1JY22AJ
	AnJOjSV/oA+haZnZU+2CqeNgolsvHGN+kgEGnnpFmTqs4P+asV3BpShj5qpI+7LQudxno+c6lsu
	qPLk3f/6qzg75zoa0pAsYkp6bOm
X-Received: by 2002:a05:6372:a80b:b0:3de:ab1e:a63e with SMTP id adf61e73a8af0-3e165032ef1mr7892032637.39.1791904704905;
        Tue, 13 Oct 2026 08:18:24 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:24 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH v2 05/35] clk: mediatek: mt8173: Fix memory leak on module removal
Date: Wed, 14 Oct 2026 00:17:04 +0900
Message-ID: <20261013151734.3177690-6-akkun11.open@gmail.com>
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
Changes in v2:
- Capitalize the first letter of the commit message: "fix" -> "Fix"
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
index fa2d1d557e04..9b8c35897789 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -128,6 +128,8 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_clk_hw;
 
+	platform_set_drvdata(pdev, infra_clk_data);
+
 	return 0;
 
 unregister_clk_hw:
-- 
2.56.0

