Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EA51B18F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904700; cv=none; b=o6rUItTr2SrvONpR6QtOAcqo9CJpDgN1H8axwbgC3PtAI1EH+Vi2G9L8z5zFSuivSgSpT5CJxz2PU7lNoOcUHkVyUVLI3q+kxWEJ3QviZG+ciEjzdrrTg1Kkn5Z4GTbuRadMb8iH75xn5yr6AfTdjSfF9W85PiueFQJNlBhz+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904700; c=relaxed/simple;
	bh=4+GfQyXsSLAaCGQTxF4OfH8XhOmFeLya9+t5OyxeHWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLQa1AlT77Y5Yd7UnSaCEraIcFA0gfvzrClDi6CfwLDJoTlh+f1sAFZYoFXjaVeVBV4/9DmeMOx9aiibTdRCQZVMcydas3ZI5V21kh5wDE557FVOmUEt8X+BChFXekW/pZmvd97yAfP31BoaC3WxFqwhsDwR7zBM0/S2BTca1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF0/aQG7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF0/aQG7"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1063890a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904699; x=1792509499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onVmbrIGz8Z0hScXq6eH5zvGAlPqsRkr0+Mi5GF04W4=;
        b=TF0/aQG7or7ApNOLSN8JGOO9ytFTTPOMHEPZ8DfMTkU9xGakJGExf8voW4IIDV3NxF
         LijKC70D+PK14kY16AEG5I8zPtU9jehHWX3VPRx5d6Un2YRT79LQ7s56ArVmiuoUedmK
         00GS/xNG0YxdkuXE4AQEy4qenSl0CsAc5U9apOQ6wAhxjU2qXQ5WLD4rgcDsA2Wak2IH
         fYrVvEAkp4TYTRNE6uYXTfPKHP/tVQ5IuJOVrd4l7wyaKG25fuSxgz2ZHYzdNw0UTizw
         afbrDU7wz/g4oPCKlWGUg6zH9LqYBvNL0wQ9rDIk/aKOOtQgr2m7zFF2PQpLEiOgE9XV
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904699; x=1792509499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onVmbrIGz8Z0hScXq6eH5zvGAlPqsRkr0+Mi5GF04W4=;
        b=joEGrvpL/n951yiZ9BE4UGR3LlfWpivgtt0qTL+6674kHiO2d96+55LNPO31cPgkyH
         lWU7ed/bGtvkXFBfsRsXfWPwemRwc9rfDFfd8fFF8Ja5/0qhGyNg0tFVONaOoMklVPIa
         iRiW+vWBge7Ciu3MsKIylOzq+EZDeyjAYOjXEJSd16I4esyil3gwTbcE4K6Ql44QPFnv
         wZixUUBGiTixIsBPco/7d+OEkoBm1fV5fvempyQGyk3GfAy+jrF8/hm5H0MZK+6bZsKs
         UEXMnKBgk8+/UEf73R7ZneVIF29k0E0Cnd/k9h0uSXy+jnpeAYnwj50Mwd7nwAB7csIV
         iUug==
X-Forwarded-Encrypted: i=1; AKwUvBzQXOpwE6cCKhYw2XQkytegd/fLaMvbBhD6PK8DvGUvoQo7kB+FRudWWwFqvp9V6/3m9bDWpCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1LpE9EFvmE3sDztEc1ynFuDDJY0PYhta/zipLnI1xadgPMfpl
	9f2pFLZxhFVepExqwaDD9yxydxDDtlyk3k1o4cG9I95S7VJDxj+xsz5m
X-Gm-Gg: AYBFou13vMZy+QfpGwx9+0lB4m6PhNrDVv8Iriv5DN+4qTMKf8iJQxuNbTTOyM2Qrqp
	oPIlu4hpigPElT1nbIJOff9/pPqLTa4TVyPNQOufd6abAcW3C08UrHZZjJ7szDg871m+UUEpvyw
	ZA3yW8pOX/o61dSYHfvfT+TiaWj2B1crA6Ma3R96XxMu5grZ6hO6XW8alLGw9dHbWPjSO0i/jjR
	nyfv39CvINp+VDQUKWrpMPs8FTByBCSPoHcL38HqEwoCdd/TfWGqQuysKdRfE0bzgdyMxpsqXQO
	GJpCdt89SQoNu3QuPr9n6d2Z5B+5GELac6u69frQKOhTSV39AKpnJ+JazdbpKPCpP+9yTHikW31
	qexkQ819DlR0s2/s64coa74swAfhjkT6JBgy/klc8RjXznGARHrpGH2s2/oslggwi7lb/F2g9Rj
	hEn1aJViPT7nX5hqjcy68T/k1sQ/eUpZq8YRdMixO91Lh4TzXUMk2XTSNlu6VJIz6osbuCJo8Bo
	mPA3V9ougS2zCOCs8jLsj4StWsj
X-Received: by 2002:a05:6a20:9c98:b0:3e1:c04b:59cc with SMTP id adf61e73a8af0-3e1c04b92fdmr2161022637.70.1791904698979;
        Tue, 13 Oct 2026 08:18:18 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:18 -0700 (PDT)
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
Subject: [PATCH v2 04/35] clk: mediatek: mt8135: Fix memory leak on module removal
Date: Wed, 14 Oct 2026 00:17:03 +0900
Message-ID: <20261013151734.3177690-5-akkun11.open@gmail.com>
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

clk_mt8135_apmixed_probe() in clk-mt8135-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8135_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
Changes in v2:
- Capitalize the first letter of the commit message: "fix" -> "Fix"
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index 19e4ee489ec3..e3b7dc13b458 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -66,6 +66,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_plls;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.56.0

