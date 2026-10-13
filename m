Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F48514775
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904724; cv=none; b=dhVGVMT7XQSZ1PiTxEORFX+DjD4wrubLcdVE9RsYC3LVcqG67Rk3uXvOd2/PYnmrphXSHFtEn+WzuLhnP43N54Npg2COSJXSuo9mL5JDuip7og2lrNbdfdgZ58vaN3yxiEM/JQ4elfngpegMuj6bUgmITgQCdk09u/QHYuVmqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904724; c=relaxed/simple;
	bh=CgYKKy5YlcFezMlDDmRgiWdoBgMJBSqoavgoqfha2dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSRdmDQapC8Ys+hIRZIgy5auDKtxgzN4ol9i5v/66t9x2YJYriChTZX8fu9XUZ0y6+w0djbWxobDYVvtsJytdhWLjTY3S3cfyA/7feiZ9eiej6IDrcFy1DzKsloztm7C/3TZeWj+vqJr01XveJa4TVg8FCRWpDRCwiE7KJ//9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAK5j5uW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAK5j5uW"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so1368324a12.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904723; x=1792509523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtzOa1NC8kzjOt9xbG2RWY9BgPG84LDft99j4Hfp8TU=;
        b=sAK5j5uW7BaSgNe6WoDGRhLkxChbAJphm/a3S72C8lPi14ChkPQLgrbw9Zt5HWe4yQ
         pjhIxU75I3tQWs7YBVKp75PqEuKR7GFSK/mZWJrUyq8JdJrD7+LxrWw0mYYctffawo7D
         9mb3JC0kx+2TtK8qRIWlFQFWepyc1vAG5/06KtIyeDPRP6pe3gsQFFdLqwKdg3wUzgX8
         XJoxicpyCtRD00JTcHvojduNVg5233Rx06uZQ1/Ss5+KOAne/Dqbc/mtFZ1rLbfeJQjv
         jxtQKVi+Ci3WfikbHVAX/teubpu/hqXdTGcbT8VQ8FFeu5DWP/wtZenEKrtFMHeGYvRl
         Wwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904723; x=1792509523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mtzOa1NC8kzjOt9xbG2RWY9BgPG84LDft99j4Hfp8TU=;
        b=SRLbQZxdRzkjHL/a75Pp+Wv6lFQviCcmVDv5U8ojGNiwGHwv+My26fJXshfgeGmE8U
         y2X6+RWoQNzn4UxWGmESv1wP3uxszoA0ICP8hc0JFJBZlQmAOVSf2rK/W8rRjV+Mpt0S
         BRSeANTt/W1EZpd9cdbyugkdE3mdDutrNxW/9aaa8y11u/s2uyNOI821IO3d0YJUa30x
         bbqAQMeNyCqUyU94hgZtf2xcPpolae2Io6NWcIyQLIeRpBWUSVFtSDdv8rdnFatiMbqE
         bUUPaRfgDhLwoQxuIE4sXbtV9c6BT93xYk4HZ7SsLDWfg+85S/GMg87tRQeCemQ8u5mw
         bKmg==
X-Forwarded-Encrypted: i=1; AKwUvBzKAW+u6obLqB/GVPlNmvrQ6lHBdebM/rUhOIaluDQSR7nCgLfOeRHEfPsLjjKclpLk83Jei4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr84TMxZ8bQDd7NeOqW6I4AkoklmQzQUkXS1CK6wAcXr9XIkvf
	lnWYGwRJ3F/mbeIGfqbYsZoEQEq6WsEY5CtJW80cX7Ep6DgZuKLN4BHzvAQxiA==
X-Gm-Gg: AYBFou1A8BOjxXoxVDsKDxqn+BVeg4ySZDk15iW0MIltTP0+2xLSOUQOUp2pxMSqh0W
	pjnj/R/CiUmcTJL7y3acXya8e/k7kmBWH7H/sQbhy71Y9uQXpANKj4UxZEzDMMKKbjHz4qg1JMZ
	8+Ie120HA8mAutf4Tg4X+lt5woqbX/85HgFMtwf/4SWxcYcIRCQhoOhIcBwi/u9s3yM29WrMQy1
	LlIg7K7i+kcmtSBzabdzBcuv6UCHoE8J9T3FrH/wA7kul+85wPOzdpx2gN2tT/IIqQ6O3bsSguu
	vIN3d3EYSm3lG68/ZyivJzww8zuzAHj/uolOPfhq1G4XCC8zgwH9rd0N538yzIG54GF2Hz560MY
	nhciadDyhwIHltEvWYKoH9rG4/qCBAnd2b9ZRuEb08PI0kc+oXYR28ONFmLMwZiHlLf0uBABM7P
	xzIWifbeFGPQazZCqsVd0RvkCdUR1uyplEPwzJRmPQB+88mS28Dkg6IWAqdu6+HpgBRXZ38qF3Y
	I8v/neUYECI6A7NSO7bCNyhRZjs
X-Received: by 2002:a05:6a21:4eac:b0:3dd:a00a:7ac8 with SMTP id adf61e73a8af0-3e16bebfd96mr10253819637.53.1791904723172;
        Tue, 13 Oct 2026 08:18:43 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:41 -0700 (PDT)
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
Subject: [PATCH v2 08/35] clk: mediatek: mt7988-apmixed: Add missing MODULE_DEVICE_TABLE()
Date: Wed, 14 Oct 2026 00:17:07 +0900
Message-ID: <20261013151734.3177690-9-akkun11.open@gmail.com>
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

Add MODULE_DEVICE_TABLE() to the MT7988 apmixedsys clock driver to
export the Device Tree matching tables.
This is required so that the clock drivers can be automatically loaded
when built as modules.

Fixes: 4b4719437d85 ("clk: mediatek: add drivers for MT7988 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
No changes in v2.
---
 drivers/clk/mediatek/clk-mt7988-apmixed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7988-apmixed.c b/drivers/clk/mediatek/clk-mt7988-apmixed.c
index 416a4b88d100..24f4e7b87a31 100644
--- a/drivers/clk/mediatek/clk-mt7988-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7988-apmixed.c
@@ -75,6 +75,7 @@ static const struct of_device_id of_match_clk_mt7988_apmixed[] = {
 	{ .compatible = "mediatek,mt7988-apmixedsys" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, of_match_clk_mt7988_apmixed);
 
 static int clk_mt7988_apmixed_probe(struct platform_device *pdev)
 {
-- 
2.56.0

