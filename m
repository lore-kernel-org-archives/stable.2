Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901B52E07F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904685; cv=none; b=cNYcS8ULxvMUM+k2mlqGUAT+6Ntj3Y4B1OW2Nj6PC9m3Yw5Plf23hElf/e4bhbJQRJvxTo9y/3cHZhJ9vu9A8nactqxeiYpK9D0nKsSrW3UIyJTot2Z+OcAEdvGiTpf9fDCqInR77HX3MbmcvbhCs051qBTkX9AXdOKCzZnnMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904685; c=relaxed/simple;
	bh=vx2/wzvjNukbpfMa2SjGZEHeNaHuzGGqIzZhcaRZMVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+sVAtNSmK8QxEvbq9Buvk6axVk0QihHc7PUKPjmkxDp6Y31c029wg8NXSNhQDZFyXOatRMqY8bP6fwfpmk7EEM1nGMN4ZsIF2ald47gNY/GMPaOMyuJqKyGCvvBxAKqhP8jVVdLzLSPo1QeuyIW9HNnzcwbw9X3yAFaaKTge5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKLjbv7Q; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKLjbv7Q"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso1086891a12.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904683; x=1792509483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5fVc8UeH+5da/hVDNrPa5heU1KsL+eYQi/ZKHAgy494=;
        b=PKLjbv7Q3ufmDycslshJneS5AUJ9SpChnrlgWb8jPOZGWEL/WeFsqbHwklLwJn7Iv1
         iOOWkyrChXiaBbAdRHlT9ntJ1rmJcaKIzUAeLUft/9g7Xu/bJEroiZDie5u4LiZJJ99X
         OeK2e5HPo5a8y2l3lSLV0GKmxJzBBlzVtSqOwnWQIiSZksEvw5T3FZU6bdVq6GZK3mW+
         oANYYvFLfvYD6evvbE+yaOM6oeLDYMRbeza2RRokraUYuHHgNo6+OIwix0qofa+p0nIf
         /WIMrZDOGXqNLBisFn5j5Uaog/oDLDM8Ek3e9oI8vd4XIkkPkBxme6rn5x66HRlSWo7X
         vkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904683; x=1792509483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5fVc8UeH+5da/hVDNrPa5heU1KsL+eYQi/ZKHAgy494=;
        b=ENjpfhm67rYVJPvl3AW6ADxEcMSTz2owlREHj4eu8oepORw0H7Sjpgfz9r+37xxi0y
         gPAu35v9wqcVn5C8ZvOJ13rY6fIt6+ayOVu9n+TsMJc9LMVqvv3n6oTlBUWdrr0EfWDB
         czUdLkK2+shl9PU3MZDSp476Vi0bVonKq9mL9OQlFQ2jSmuf5+rVSF+IT9pQR+xpewQU
         3jHobfHpdV2A+UUR6v/DUBk9OzQUCm81tDrFV+3P+IGM561mtj7VG2i3wlUmzSVk++Ca
         71bsImBun6HVM2P7zUNfVc+XDt+SJzonWMJYTAwETviz6zpgSDy7rm/yhDZtnQmB+yF9
         eTiA==
X-Forwarded-Encrypted: i=1; AKwUvBxmAFx9O7smOUxSSAXn368g8wpYcSZoQNgKMLGv2UB9uMYeyU1zqK7+TxjLBU+SWvkYvZTHdGo=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4HaNbbSoczgM/NFbZBHJ707osv1uHSUg4xVcrG/xDF054+eBY
	yOAz72hzjAwl68cb1EgwU5r8ZBGqW48nMdvC9hMvpCnf4vUqWi5VD7bQ
X-Gm-Gg: AYBFou0PSanSq1Ad1Lk8Vj4teZU6AF/0kzao5lIW+ffCcepv6wD8TkPTuQYWqRjuOpv
	4usUzJBZ15MeYfgTWP6WlS6C3Ri6z72cfWshwdOu/nODE+B3+xervc6ae2flAM5e3WBUzJ27Xd3
	HEpHVepoqkLs4Btg9T+1wSMzDnAPLCbrQGadyL0/J2WEwRrvk50LoO7Q7P0RGfeB2QCRSW2poqe
	32zdheF0t/izhAGL1iC2GAtrQltdt2nHHsYstEi0pMQYzIHMqOoApBBAM0fpF40yzF/kWio79vF
	o6x9TVayNjPvSA/sFl0H7T2fjRRJEva8HDRg8LnauYsImYsa/83wcDrQN6JsD3vRPE9kGLv9x5A
	IolgIEWEbKo0Mp7YjcbMNBMKMIi1o4ISImMzijMp6H43S6nLKH6tfuWRuQ3+PqD8xHJ9zXpDejy
	CmrtaqZwxaky0Ygi1DtgVapcMo2ukmvml6vcjc+JoppCFzZK+nQRXsnBPd7bv5wLpN2YmXKybFZ
	TAc7qbLosrRCrS1dkxR36ukWooVxfKPTbR4jpw=
X-Received: by 2002:a05:6a20:a10c:b0:3de:79fe:13f with SMTP id adf61e73a8af0-3e16bf27deemr11023823637.38.1791904682967;
        Tue, 13 Oct 2026 08:18:02 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:02 -0700 (PDT)
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
Subject: [PATCH v2 01/35] clk: mediatek: mt2712: Fix memory leak on module removal
Date: Wed, 14 Oct 2026 00:17:00 +0900
Message-ID: <20261013151734.3177690-2-akkun11.open@gmail.com>
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

clk_mt2712_apmixed_probe() in clk-mt2712-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt2712_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL, which leads to
calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: c6368ce86435 ("clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module build")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
Changes in v2:
- Capitalize the first letter of the commit message: "fix" -> "Fix"
---
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 54b18e9f83f8..087cf574bcdc 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -129,6 +129,8 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 		goto unregister_plls;
 	}
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.56.0

