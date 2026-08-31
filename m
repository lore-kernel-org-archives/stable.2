Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB403C09EA
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166262; cv=none; b=sg+Bp3bhbZiVGEOs70CrmIrnCSw/ieLzSI9DVXnugWnhC1fu4eCPowifiKsUYoPEzF0vtsytyakPHjbbIz9TWjohkshEmyLKt8RpL5tCVGnoty9KC/C0LB5WVZVgdJQ9LdI+eSpoP9RbcB3wrw3zUtrMKuMn2knqYRAJdWVqFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166262; c=relaxed/simple;
	bh=ae99JVlXv8KhBJcW3GLb3yVSwMLBNmASVYdzcho21RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FhmopsqWsmJmhi2TOZFCyMdvGJ3ylMOkR4D2EcXVvPVQoth0fgRGoZkdprBpLPPAlO9o5cA3W69M8g175H5HGBhBkZALVSrgwgfzw5tMYKZuxUTJbqiXGJQriRWw0Sb9wcLfzG5yFjzV4JPG71i2QPUUVFvj5ZuqlQEmIFUt88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lvKF+Zzp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvKF+Zzp"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so2524623e87.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 01:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788166259; x=1788771059; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w6f5zaTCHzRQgmPEKk5TD/UO+zjNwknfFQgnjXHiDpE=;
        b=lvKF+Zzp5mthVG5jA5pr/U8mwndGEtjOqIWlZvVooatzqnmUnhZdWD4D/I24j13GF4
         4SUnzfoqaizwGSqbk7PewlypBUmOGzqGsiFqgtt539Z5Hp2MRKAlo2edmKWaJLqYKD9I
         1wfVVz8XFvK4q3YRd/4OuK2eJURiwEOX0HEHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788166259; x=1788771059;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w6f5zaTCHzRQgmPEKk5TD/UO+zjNwknfFQgnjXHiDpE=;
        b=jtwC/khPQFGS75/HmafibyrazOgCeyE1WHmspxU0SxdtVoSZ6uceGdEDK5TLioA5pp
         I1cxCevZRe8V/OouGr06D3XFatcvERgN3rN6kWasrfZy/6UNf+9NIGYUZUSRAkaqCDeB
         gF62HjDmx213UuSzZvczsMbIRnvVGZt/C1danq7QWiYj5vTayVNdQIGJnOIOWq73DOTt
         zOkdk+qjTx3JSoiSDMg3jDydptWYIQVxjMlI4FCyoUUhU9GH59cDK2ZbO1FZ24ZIA5lL
         /txur7N59CYLXbfXwbpwp1UpdmegfsjwO91MHyOYi+cNNOMx6neOeeLw2SPjE2YsFqpB
         SkGw==
X-Forwarded-Encrypted: i=1; AKwUvBxJmEXLbut40RlciLBzsoka6oRGVmf/1Wri8P2+NvORLOdTqzFM/WwyLHuxR4X+8zfy/lqGN6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mnq5XhXwrk9ccvNVXZUXbFGxfAhaVs/2yUIA6nUPyzx544QUOL
	MVTF4ZCJwQeq3S9/PuQXWsHt30HIAbzOcH3WhlUhx89mvLnNtLO2lZxj6WoE+f7ceA==
X-Gm-Gg: AYBFou2JrOhcjwnEhhL5HSx7O1bmLKwqW1yRQ6MzIY7CZin82peDg0q/v460Sm3RLtK
	aoTUNT53NdN6ElgyPEftFogDtMz8DEbtPbMzR6Sw9D8plFzoVdTYW6bs9JC562ekT+Omi1/N6qd
	BsKazl8nHr8y3JiW9stb5TiEFzYYUqK0EZiNF4mnqD1OfIIFjOcjxVgHMCHTFbhfXly+me75qmV
	SBm9OdfoQYn8qNpibYi7Ia9NHo2IvRsYn+zXyfOSSd+hM64e5xPEEHpw0RH4gD2T6yP5jETew0i
	vIrR++QQNLygK55ScaMHFUi96vOaEeISwy8TYtfiu97keeRVrspSmh0g2KEfQkJhnuYDz/M+uaf
	aZk8Cm1h28G68S7C7Ki9Xhn2q9biJPwYoHpQyT/B3PGxqm2dV8lKgLnFgBdpN8awTqW9YLU/gJ3
	s65JJnlSIglsBCjTkVjQEww1FtrnO6w54TpccK1clEX7bXcHoZiddlhzn8hbXE4tfHDWIck2h3F
	gDhFzZeE6h0mOmLegpCFJHmpVucnNj10UKNY2E=
X-Received: by 2002:a05:6512:31d0:b0:5b5:e092:c3ee with SMTP id 2adb3069b0e04-5b5fa595f40mr922875e87.1.1788166258698;
        Mon, 31 Aug 2026 01:50:58 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a1cb7dsm1992003e87.78.2026.08.31.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:50:58 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 31 Aug 2026 08:50:56 +0000
Subject: [PATCH] clk: mediatek: Add missing depend for COMMON_CLK_MT8173
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-common_clk_mt8173-v1-1-2d7241f70379@chromium.org>
X-B4-Tracking: v=1; b=H4sIAG9AlWoC/x3MQQqAIBBA0avErBPUsKSrRETZWEOpoRFBdPek5
 Vv8/0DCSJigLR6IeFGi4DNEWYBZR78gozkbJJc115VgJjgX/GD2bXCnFk3FuEKprJFqUgJyd0S
 0dP/Prn/fD+cuZUBjAAAA
X-Change-ID: 20260831-common_clk_mt8173-05e25fc25b51
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Brian Masney <bmasney@redhat.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, stable@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

PM_GENERIC_DOMAINS_OF depends on OF, by adding a select to it without
adding a depend on OF, the following warning is triggered:

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
  Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
  Selected by [y]:
  - COMMON_CLK_MT8173_MFGTOP [=y] && COMMON_CLK [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && COMMON_CLK_MT8173 [=y] && PM [=y]

This patch explicitly adds a dependency on OF to solve this issue.

Cc: stable@vger.kernel.org
Fixes: ebd0b73d2137 ("clk: mediatek: Add mt8173-mfgtop driver")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index b059d44577f1..ba1ca9c90dbf 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -541,6 +541,7 @@ config COMMON_CLK_MT8173_MFGTOP
 	tristate "Clock and power driver for MediaTek MT8173 mfgtop"
 	depends on COMMON_CLK_MT8173
 	depends on PM
+	depends on OF
 	default COMMON_CLK_MT8173
 	select PM_GENERIC_DOMAINS
 	select PM_GENERIC_DOMAINS_OF

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-common_clk_mt8173-05e25fc25b51

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

