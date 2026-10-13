Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C753162A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904719; cv=none; b=tRqKajOiwSSCBYZW2Lia9l8oEHLTzc+oy036cNaGjboEGcc2FiXdkat2hWWCHjFWs//9OGKelXvq8tnOsR+s6fdaT9r2H3yR3V+CFjWsVWQD7zrsycjXicOoRIIPj8A718D7+D8QPIZEIGYSe88hU4tVXE04tDThr9RoGDjvsSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904719; c=relaxed/simple;
	bh=0Rg3trTDVXkz0wUUwVq33AVQV/Ql8DJF3Zmohm/+o8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkkEPDeCajYmTFei8VtDcY8KvohMLAFCJrMVGMvuQY90mXYL6xms7QkfBBDQCGXNmZ8eVBICSW5ohJML0hJy2qvsnD0oNMtlq434LfSdeUj0Lpi7O3OR/E9cFUCF1yNgogVUbmB3eSOksnkxDqQO2/lbuVySTjM52t+LHxuOnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSFQ0auY; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSFQ0auY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab8309dcbaso2247685a91.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904716; x=1792509516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSK+e0uR+hrpe/b9QMXoajdIs6DQrymWCkZkpBSheng=;
        b=CSFQ0auYDP+y2PP7RGugfVQFbHFY7/BZr1DfkyU1Oqud1oLaaRkogFhpBqBFDN3QL4
         v0hk8qyiYtGW51+1DUFzfrMFQZ+4+2rSZJxpusVh+++Au3XWF8PUfnuumsXnvImp4n4T
         nuaqf70OPFeT7q265wXXrWq1OfZls9L1l4E8jCmYHHETY/oUeHZGAnf2DFL1ffcJaNE3
         RY1YG66ykVlZsXs4FdweujEH/FOrMxejFyFg0jdTOcgfivKWlkOZ4s9a7F4I1uqhI5EP
         iuBOw4kpWu6Su+cPcUx5CeFZMzUlzBCOeUv7qZbcNlEXwBkqHTl8evN7cJpdYjKJqgdL
         KSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904716; x=1792509516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSK+e0uR+hrpe/b9QMXoajdIs6DQrymWCkZkpBSheng=;
        b=etGWfWp0jFQPN6N9XgAcD7du/7xKyXnLbsO1Dh/UhryK6s+q86+UIUlZmY/QK9N0eq
         YqgPCh4fRlM/3kJWjG/1tngT5npEVxKTMC3O24eVHBm4L5kDzq3cbJ0xdiWTttPzpfjV
         j1cg4vSBXv3JjlLxams5GTKB5MuuVyG7DXz7oGFohrm9xpctyYoIBwlXQwRoQzRyWH4m
         EeYHLgQWPLEZ39vfX00VV6uSlHt8nKsGgKEuTvs280yCavDLZL3xRZzFFdTyn3H8C1H+
         tMliI1N5FgCstgst2us2AB+N7P+Dr9x5mFyk57aFdf/3Wk0wnBmsG2wZHbZKiMZZTRcI
         hyEw==
X-Forwarded-Encrypted: i=1; AKwUvBypmi3FKnzdNqcysg5J5QgyYSJ1oHL3JekJCCVeRVhslFNpRQAOfTR2Ev7V+qWe533irTSbnGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKuoPsDZaEvp1bWmu0XsaTB/vLFWYy61QcgRV2Kves1MuzmZ/HD
	K3BZlFjdKGEYkrTYFV1uh1VprZpEiIV1I0JUHGzo0vYfD9ksGPa+jb4T
X-Gm-Gg: AYBFou2eRu0a1ccll/qevv5D1hJ/gcLiyuNUvg/QwjRZvC1HGqZGC14iJbuTpFLAekC
	8aL/M74wXrI5u2npnm9gndH33VYxfUFfw2lUq+Bbm7C+tw8/r/Pu8WzesAA6uOWo6xhZW50J+6Q
	ps7HHuwBSYvK9JwKIdaFUn+ediy8G7EMIXhgxTZPk4Hx5ovoetrE51zF1FROAuQPbIS5aX5GH3P
	lLD3o9V4K6fD/8wcHwyVg2wH16j+H+BTUdMMbW6HfFj6u/7rP1SRwl/CM5Mi44DytlQ6BNRmuFg
	atwz8OcSERw+Pr+YonFJ5uPGNXPkOiBuj8bCpKCtPQSt4BVyTymOHnR8w14bp9AMTzrfu2qFxsk
	NJyK1NI/2IKYAk/X8RHQkxqU8WCC/FdphYOXADnhrZzCmjQ8GHBc2Mg2Yc3xyfyKRDF5NXtUPV4
	WXpiFkzAXxRtPmxMCq3Dncd+r40ctAnDa5ILf/t+I0o5eRRfeWeFyNiw99XwG9LEz7OmuwB7kYA
	2BEq14oF0IBQygGOtbV+LKw+lYQqubNDf4wjfU=
X-Received: by 2002:a17:90b:4fd2:b0:3a0:b800:50a4 with SMTP id 98e67ed59e1d1-3ab36956d82mr9294604a91.3.1791904716462;
        Tue, 13 Oct 2026 08:18:36 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:35 -0700 (PDT)
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
Subject: [PATCH v2 07/35] clk: mediatek: mt6735: Add missing MODULE_DEVICE_TABLE()
Date: Wed, 14 Oct 2026 00:17:06 +0900
Message-ID: <20261013151734.3177690-8-akkun11.open@gmail.com>
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

Add MODULE_DEVICE_TABLE() to the MT6735 clock drivers (imgsys, mfgcfg)
to export the Device Tree matching tables. This is required so that the
clock drivers can be automatically loaded when built as modules.

Fixes: 0bd9b1211f74 ("clk: mediatek: Add drivers for MT6735 syscon clock and reset controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
Changes in v2:
- Removed wrong mentions of vdecsys, vencsys from the commit message.
---
 drivers/clk/mediatek/clk-mt6735-imgsys.c | 1 +
 drivers/clk/mediatek/clk-mt6735-mfgcfg.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6735-imgsys.c b/drivers/clk/mediatek/clk-mt6735-imgsys.c
index c564f8f72432..813241d526cf 100644
--- a/drivers/clk/mediatek/clk-mt6735-imgsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-imgsys.c
@@ -41,6 +41,7 @@ static const struct of_device_id of_match_mt6735_imgsys[] = {
 	{ .compatible = "mediatek,mt6735-imgsys", .data = &imgsys_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_imgsys);
 
 static struct platform_driver clk_mt6735_imgsys = {
 	.probe = mtk_clk_simple_probe,
diff --git a/drivers/clk/mediatek/clk-mt6735-mfgcfg.c b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
index 1f5aedddf209..8a18ee244a4d 100644
--- a/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt6735-mfgcfg.c
@@ -45,6 +45,7 @@ static const struct of_device_id of_match_mt6735_mfgcfg[] = {
 	{ .compatible = "mediatek,mt6735-mfgcfg", .data = &mfgcfg_clks },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_mt6735_mfgcfg);
 
 static struct platform_driver clk_mt6735_mfgcfg = {
 	.probe = mtk_clk_simple_probe,
-- 
2.56.0

