Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EF23EA8B
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191485; cv=none; b=Cjn2QCpXOZqa4sjIIVmrgO69IpmdvXP2dcaEJyHKi+atJgRqlqvj25dbmqdnVHLaqL7Kimbrucq5fxyY4rWtVyVTsdjhLsmwQFYYEP7VmFCwQBUvnYWT2T5ypwHCPRL5PESpbZoV9kZCmsd6ZPkiEc+SzQGGKaFsu2FSQ6bIqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191485; c=relaxed/simple;
	bh=a+TJaX4ER1FWwzfB7ZX9Vno1hut2/r6rvF0x/WRAjvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1YV5R8VNgBJoFK4Kxl0K6W4g4M+Zi4IcuS5GasAOFd86NAB1Xj2QXvF8V+nV1pwvFj5KcgnuhWmEasrIEetqUf6oy7FOewoP58hcqkeAAyhYv0MMvSz1Tb508CgG5azN7kajYkzb7tWuLQvR0yjhBwNK7JBP8shJGVq8XWlW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n10ojE88; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n10ojE88"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c998fd549a8so279390a12.2
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786191484; x=1786796284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zCtw9XLhyYld5CLOFuXhhaanDpjQ78I0gCn1Zksv45A=;
        b=n10ojE88kEoSadyNvpJ4d0IoHzQYgwQDaV6Ob9wXVxo3sOOFEIE3xgGCKRTiugkhfG
         SMKPHLcg1IZhiVbuy36c8zuBsTbXfyUO2nltCYiPsp4MfiMtZgrCasAviNAXl9l/HvrK
         7a41YhIX9I3SZ9SA1pmmPzcixDk/8mJxtxF05ofhVxUjeVPMDZ1T9RhFpWSpfgDsR//v
         skYmP6fAZ4q3sZe1M53xaqR2iHBE8+0xonsym3j658jrr2C9+cfwgQLPSyATBNi0PrMe
         gHx19vBC8PjFpEt3RMctYMpb5Fz2dUVix+IChrHwbZ1iqb+ynyfgrh/C6JKAdddwxc12
         eFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786191484; x=1786796284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zCtw9XLhyYld5CLOFuXhhaanDpjQ78I0gCn1Zksv45A=;
        b=QgPs02uZWvP20b7HReC6n15fXuDNmbDS3pV3j7uqC3dMlrDJo7k3QG5tUkQyGzvltz
         nVG2DWhcR5LE1k2tWVRdhX7pVVtzzGhzr5SbmPM05qYGQ7mlqy6OVgUS50RCRvdsxXJh
         BvhBReNWd86KSKijiVqr/FJt8X8Pnj4+khIAG+Oe48pU44zu8yMQkid9C8hhPfSgnKBa
         znBcrZV0ajG/hxafvivWhlKnL0BJmrBZtMy1pQNLAhNzs2GfckaHrnx623UwXu4dScTv
         xbTsS2SskZz5eskx8DoU0T8BokxJH/7SEERPckWsFVFoo5GS8jDJ3sxhq1GnWlmOYsdW
         POmg==
X-Forwarded-Encrypted: i=1; AHgh+RorPXkTwHEvIxc5gb+LHCbf0Q1TR66W+MSrmvfBV66P6wI4cipgt4JT9PHas+wbKiEWkl7oi1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8biFTnKUetoejtSk4SvxR3o/J0RhZ53EQmXy6EK4jV8/jdVZ
	8JXdX7G7w7p5pl4ropgaZYt6IOZ3teMTpTt8Jgcc8Hdw4UU2Xi2AThom
X-Gm-Gg: AR+sD13ewtzQYcrVkhcIKroRxHEgEJlZ2pD85uEERTGrkvR1Sc0NEUhY3osCOeobAkq
	9qe0j/HErN1WX7UY+f/aQuEQi8T7YdWEwiKf2UMj0JN0uOTJ2mz8hXLoLyFUXdJkKGWpCHNwGOA
	p/CiBCrczwmKeHpodbnBQ8K4h6BqJdQp/iSAKxWsUjuFQFjgMw2Lxwk+MPYYmEcYtMDqEGF53cw
	SY5E9NR9r13UfitfPtm0Nb6GYydE8QdDf6V8z7wd9RtCPpja2lfIehE+D4HKamSTKJB1Tf3BCVZ
	vKx4rxz+EUEHqi6+jga853TCZebsoPLecncv6TvJ/+uU8+260xVNEG/hudrRuSz2XnAkdDpfb86
	BAB4EQcg1zptME8FeOiyt9Dio378y3OwID4hCDFu2klVlAhqaSsFtmvCw+DpZheHpEggSq3VmTX
	4u3clmp5PQMw7TNamDGbtc8EdB3Z0oWS8e5cZBxkBgmra2CP6K0birvqtULkxLmeG+XAmI
X-Received: by 2002:a05:6a20:914b:b0:3c3:bbe6:95b1 with SMTP id adf61e73a8af0-3cb85eef9d6mr29740341637.24.1786191483645;
        Sat, 08 Aug 2026 05:18:03 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f1b04e9sm1781742a12.12.2026.08.08.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:18:03 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Joonyoung Shim <jy0922.shim@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe failure
Date: Sat,  8 Aug 2026 20:17:52 +0800
Message-ID: <20260808121752.2819486-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

g2d_probe() calls pm_runtime_use_autosuspend(), but its failure path
does not call the matching pm_runtime_dont_use_autosuspend() before
disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the probe
failure path before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: d7f1642c90ab ("drm/exynos: add G2D driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index e92a4d872c41..98a5679258e2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1523,6 +1523,7 @@ static int g2d_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_clk:
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 err_destroy_workqueue:
 	destroy_workqueue(g2d->g2d_workq);
-- 
2.43.0

