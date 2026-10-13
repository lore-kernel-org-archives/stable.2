Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223950278E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904736; cv=none; b=agEbAMYu20517o3UBquylMaM4xOvbBO8MPG8CVjk0sBtg/nZ5Vok7uNA94Tl4zeClMIZ3rBuSFiF3LE7lYpDayKa85LNdImhKYuCYlBn3u9NxE8a2D9jL0HDw7pLsGBRpdJrn25Q4NvgXR+OfJlhnjX85i4Ec/965+gpIAwOkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904736; c=relaxed/simple;
	bh=6K3SkrEl0hDRYM2P4BpCm5A7jEZueESKwGIgsNB1OBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwiIW1SKul04wGfd6lSCnqUvVnLRSS33XqOsUu6/gZvBJwQQb95ou5FUAv/G2YSzQl1BA02QZYydcNDcqEuFUnHPK55+8LHNaEsR7s2mYZ5NMkOttTZ3mVblEdQw3Z2g6xdxe6tOEM/FCBnYV4dWd+1/wTpu5gffDVG0/Y/+fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBi04kmp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBi04kmp"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so1207151a12.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904734; x=1792509534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DldAa+NtWBY2ZHtMa/QGhrtb5Vlsja4TWpwxlEVTD6A=;
        b=lBi04kmpiz2uyX164nXI7S4P7uehh3nkysRF4KFuZjtv/r0Qs1xaWP2X/OprlUg7bT
         oX6sLE2EXFdjUP+a5W+N4dtZNmOJM7sg0/Xf4oQHlyDAYKY5MZUAlr9CScGgYwb1cXD4
         laP6wTVfJx+fuRw+c1LKlHRGM1kQl3vfjciPLDFlN2MVUJ0fwRRbKdD5+K7VFodYI0pO
         Fk/bQc9x2nmvYuc8Ze3UPeknE9pTbH1KgDefw3T+hUznFV+2ZF0kY/Pm0ZB9WoPGqp6K
         akhrWpqeqBfEr92ZeS72uDXriCBFSnS1kRAD11YxqYsloYWjSBcKNM8Q4jW1tqOQSVpJ
         e0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904734; x=1792509534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DldAa+NtWBY2ZHtMa/QGhrtb5Vlsja4TWpwxlEVTD6A=;
        b=GIOK6tQdeNGYq87w5/evhyPM3AYlWuF3bHjwd87Upgb98UlF7sD4oP+Cx6+w9u3WY8
         TmoZSnwiU2VhgjyFq79mgqS9BxMw3QPzHtfHIMRE286fsmE/D8SGZ6ihHTJ/8odJ7I6P
         38/4a4/tP+H9iPFL8oLWrXVxtF2jnZHlUJxzQUH7q8VN8PusTzofCga/VoaD9E4IXJQj
         D7BJ0SdIll0tRsPWRDQEbMy5IfTJLeUUozbOJFq4fRJLJ8uEBg08XEoaKGD1dogSyxRA
         wygut+tpTmy8TgXiaTtm5tiUyV7NpYc3+LwTKGfpw3BF3b8JeaE4ogknwkOCsur/8nv/
         SGpg==
X-Forwarded-Encrypted: i=1; AKwUvBzBa69Iu9qWorqIbqBbcRCB9avWtTOAAzOkhc1fRJtb7XyjVaGWdmslv4mTr3byu6H3kq2sUnE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqLUXMYi+5V3ayO0cghSULu/qj9OLD3mE5fmryWWMcgwcaCcDW
	2322WKMZKswMxZaAyjRE5YtOQCPjbBamgKU0a/mdbA5TdPTROsOqnDJl
X-Gm-Gg: AYBFou2AgS0tdujVDIS0l18rr7oEdN42aHpd5goe1980fXQEcaymnXkPIXxvDmY+fp2
	DkPrWuNI2QvQkN2GJgZ/rtFCybGr0qvBahZ+r+LzpvJSCwa8s1JZG4moUx+7IT3FkG5Dr1HKc5B
	KnTvKNxRkY3xdWY0VzH7HFFU+laR6s00WSzBBbvqBR3/+AqKFX36kOFSpRyrlw9qLRrMztoWuZz
	5qVTlf676auGArl9ZHWDI9m8Kswt7Cds3gaM/4k/iBNMLN0OUJiantQrDXL/MNpwlsiyshkgARp
	HDEfGRjYm99LCKv7tX3yIzt6TiOGKqMsBBgcCaiK2FNAJNIQlRYW8FXkmvduHo+De9GR8XTWQZA
	LhlqoR03igZbatqaTA9VD7NuYIJdLejQc0KtSK7azN04exrZlN0rYvbCa9TMOLq1+zE3OMs+Poa
	HEINoBSoAh0LvHV7FOIMuXvVrvV+vIkGefls314mO4qsaOa+DyDgQiaXy9NiiwHuMwyptntQCfj
	5rS5i67U9ZlEH1pkBDWsndwQbt9
X-Received: by 2002:a17:90b:2d86:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3ab3a60d1eamr9892006a91.20.1791904734175;
        Tue, 13 Oct 2026 08:18:54 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:53 -0700 (PDT)
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
Subject: [PATCH v2 10/35] clk: mediatek: Fix memory leak in mtk_clk_register_gate()
Date: Wed, 14 Oct 2026 00:17:09 +0900
Message-ID: <20261013151734.3177690-11-akkun11.open@gmail.com>
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

When a gate uses the hardware voter ops but the hardware voter
regmap is missing (e.g. the "mediatek,hardware-voter" phandle is
absent from the device tree), mtk_clk_register_gate() returns an
error without freeing the mtk_clk_gate structure allocated earlier.

Free cg on this error path.

Fixes: e504d3bdb3d0 ("clk: mediatek: clk-gate: Add ops for gates with HW voter")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
Newly introduced in v2.
---
 drivers/clk/mediatek/clk-gate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index bd2fcd489a3f..0b1389993751 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -221,10 +221,12 @@ static struct clk_hw *mtk_clk_register_gate(struct device *dev,
 	init.parent_names = gate->parent_name ? &gate->parent_name : NULL;
 	init.num_parents = gate->parent_name ? 1 : 0;
 	init.ops = gate->ops;
-	if (mtk_cg_uses_hwv(init.ops) && !regmap_hwv)
+	if (mtk_cg_uses_hwv(init.ops) && !regmap_hwv) {
+		kfree(cg);
 		return dev_err_ptr_probe(
 			dev, -ENXIO,
 			"regmap not found for hardware voter clocks\n");
+	}
 
 	cg->regmap = regmap;
 	cg->regmap_hwv = regmap_hwv;
-- 
2.56.0

