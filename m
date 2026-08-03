Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389730C151
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766685; cv=none; b=rQT2Q9SMjJ3IoAWlguc4dneXIwDxROruYORB7Q8/4XX3sQtbFk+g4P+0jjQ+0GPbZDedbK41HdYFc3NyO1vsytC8Z30mZKTQ254xut0P+l7oViwrX/5+Yu8+uNkwP+hq38bHA1jFDg8x12s+lDwtdaLpv/FNk4TXq9p8bbswO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766685; c=relaxed/simple;
	bh=7h3J0KJRIBj4TZbgkPIpnUg4BNLSixuEuLBm1vCS7vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3zkibeNENOD2p6Rh4s75mF5vu6Wc1nV4uPkGiRrErOq3Ggem5FPNLWckxIDP+M/WqnfhB5j46kH9gEafVZwg7ojySRr47NhPrPvwD3XhUvZ23MRJXSmzNCZtZLAuuiZZoUfEw54+iRhFnDc2XCFWDbiGd2U/CffioUbFdlf+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agPAT+9t; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agPAT+9t"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2285698a91.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766683; x=1786371483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWFicEK01U6Ib303mAzU47Nrzec6N90vhxPL4yip0pg=;
        b=agPAT+9tuwf4Jn1YfhRPz0IaKYkRrpLW6lMB4HultJlcY9CMMpRoS60fiEmy52qjNp
         RIgf5Q+ZaPq4NfuWzTB5HPp70KfpBf32yfhIoq6G5j06D2inq/mrzVrET+MA30nTPtoH
         6yArbHkcGUsLadjlheyauyBM9LAjLpFltAU5NeISXPB85IfuPl2jvq4fj+f1kP9DuGFX
         H/KcaWICtna1ySz/pPf7L2O5mp3Zl80maHp+HC9i0fZIe4PYx0j5/wMOYPpLpg3iK5qs
         7OxxoAMILq0IUdZcWGBVxd92yg3n9hJDIQ37Bzxkyjp8eleogP0u9ZRK5QCCVaRbBoGx
         BMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766683; x=1786371483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWFicEK01U6Ib303mAzU47Nrzec6N90vhxPL4yip0pg=;
        b=GD8GknKTeAmcHJ4g01z61UD2QuS7PV1ini2S+pWkHNJW1jn0L0leNVyu0ArZDnM98K
         lg5Qr31ud2opPIevClKX6tXJORR8KoAAjkxfZkqhAN7GfMXCcxeXsqiE+J68v04MpsPX
         LjvJ9J9fM9wqXhZSdevMKoDlPwBvUH9+lIpZLNVlsaMjQls3UF8llwuNkWNJ/kKPKkvj
         hfB35UNedvQ9tkzDkf2frQTd4gFiMRpU9/h0LYNKif6NyoHKqiDhnECEZGMP5re62bU2
         gzlKogOweCnfTZMBQIh42GBv+YMSWleDjn5HmM5aXkx5fLorODwR+LzOUJT7vDRq4EK7
         Z8pA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9wNfLBf5Fx2KhxQXfIk6+DdMyK94rMfqcBJRxcAat6tYwPfeUfYJY0rwNgubXpy9oEetIQPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlKh0B2YsutrA3F+F6M6qlu3fxJY6jdkF8QH+PV9HQjMwcUKQ
	kZ64pWE9NTHA1PD4pu4WKl9CCg18sPYzLAH5wu3FpFBouxvO+UbXpvl7
X-Gm-Gg: AR+sD11I4xkDE7lhsYPuezWYiItHY/kZZ2RvpXPER1EE4Jv0OypkUqrQRXJk//A5EZu
	NqURLWgFiaCVG0cVBTClbrWca9R/1SLyKfRSgBkPQ72stehRnKBiZXBj+XmNRYaeesfHniJNlir
	2/WYPWdV5kpW3k/OP5qyxQ2yWauzEaOGtVBS/knteztSuAXiSV6J6jeGEOMS6fhEt+fs9Ejc2D0
	uWhlgcdy3gxSJhj+D+iCN6zESpkhMW/CWyM0d/jwOuJ+kFhQpRSSWTzxdNho5dTOI3n6M4NzXKV
	eJCflxHWGvNQLOCf6utKc2qj+Ogu9WS/apQP1+6IlN5ujr/fF2zUSRjHlAostz5iWcg1RAuIbM0
	pxVbdMTubwN8+ZGYGFDOG5hzFGqC7Ibp8jbz/d4VvcQO17QsfqgyiP+mVuyOd9PGbsoVq76HPo0
	EEqvQfaHUlaQ7JLx9X9ePcVntkdNBnRvK0ZvZLS7ShPgKTpyO2i5wvZ9pvIZ87QXloX2oOfWIH2
	zyHQ+tWi90X8jXILmmB
X-Received: by 2002:a17:90a:d445:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-38fbc53109fmr9002290a91.21.1785766683087;
        Mon, 03 Aug 2026 07:18:03 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:02 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 08/32] clk: mediatek: mt7988-apmixed: Add missing MODULE_DEVICE_TABLE()
Date: Mon,  3 Aug 2026 23:16:35 +0900
Message-ID: <20260803141659.559129-9-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
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
2.55.0

