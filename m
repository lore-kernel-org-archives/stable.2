Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980888;
	b=wWPXOa6HljC8el+sANsRHuE4SOD+HrYdOUuMi16aKPR/ZJEs5lCbBYw+cBIrhT8kb+cg
	 DRcmO4SqWuE//VlMlyoMLAgwb5DuJrLRwHqBq68yhWD+QRIyKsGk0EYAlL1TJ0jNJz6UP
	 SHAYnT4jx91pwHJyHhkr/ckp0WRsCv/1cSiieDjjmHGmveOOgZz1gAP3VnWXRb2+HNWFZ
	 CRVCJEhsOF1CTFHrTCMtLo6mNugniE6c3EFMiIMlv8ulB+UmTbAiA8rDt77NmhPVp8Kuv
	 PBFxlsFkgoyPejtj3ME1MVWOWWIpjQ0l/NFgGcHhgKvRBO4L4xEj0TFy6oTad0ES1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
	b=rk6Zne+Vbl/P8nTcGSO8ahS2HEnxBpy2JKKErE4y8uj0rwLNK4nsPjFVPCy0iGfiTQld
	 yE7FUUL1qfN2eSQPxeHh10QClyx+UHUqiMPhA6zaOPnfRoUVphz0AUldS/3UfICGCtdu+
	 EhnqGbf3VT+q5V/SOUwhWeF9VHZHNN5XvpwPXi4Vm8EsJMeT3Uk/Saqhj7DlZ67OxB61R
	 wZBqAvp2ZS5ADhLYmSg7U+0Rm+/pPloXp3qB9gWmuReseBSZk/mF0TD8SiPRplAT3XrCx
	 5gPfvvk8SFaahtO2UPLWRggP+v3e/3hF3Swd6tTS6NcvU3ExedqJDleQMQV18FhZTEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JNYeCE/M";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D58606A32D
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D58606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNYeCE/M
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b1a705b88aso538965b3a.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980887; x=1794585687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
        b=JNYeCE/Mxw8oxc53cwlDWJ8UWIHSWiegfRoY9rC99+LORNBuj3X4QhcO5CeIwu48Cs
         evXEjuSzZDMu74Y7n8Z086sfdrOKXCg5g15EumVHbPxFeTdIBDIIXhXp1c5vhs1z+3I6
         ntc2rSc/6GKLOX7IrjD2bhstX3lVtbsHihsIAQIIZHCZEk4T+7qyH0axLZnuNmUoolG9
         AV22BUo5isZUbdgBLgGRH9TNyOse5tIa38uEyy/JA6CuGfCzBouJr0owSTdPGbioUVef
         q0HYDL5WD7VfHcFkmYKoBMeTWAzLFLgimWcKquPCCuI9E0SJgFx5TJGnyFtcxQZz8xT+
         RHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980887; x=1794585687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=stncjCpIcaZGwyCzQ3Mf39ygwW1cfGfLhkLPVcA4MfQ=;
        b=T1yTg6LYBCNTijBqkbXg935sxpqDbLhBwQL+p5s8ouBPMWitchzXSq0kwcaHB4GiX8
         jXz9rzBsRMLf2a0nEr3uJsPQgovKB5zlRGp52uXXurPGV3hhPhzrGAp6IOeBZYoAqH0h
         MGAEgt/hd2EokzIXpbGPoFP7e9hbpoa6mkv/NiPzgwtO5NkGYvJp3qmioJBno05I/g8d
         wEiW1bvCwLocbQfEfZ8BDRVPycq27l6CSVT5oRxPIZXsmXfM4rYfayZQYbodhFReyKhq
         w98wQ5HlmCDNjqsrOJXe8Lti+lF5XX2ThqNVLTyyPHqrkpHPe/Lc8bz+/Gx4NMVKdj+G
         iyIw==
X-Forwarded-Encrypted: i=1; AKwUvBygvY0XRLmNaN5xCAMFV7docm2pSvThcNxzfnjmmfWUlqJ2IBh4cyXPILp4xx0m/siC7b0zAfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ffJvthHrufwIYXZ+Gpk2Z2YNhpiTQRBsjY7rC/TLtg8Z3I8PT
	e1Uq8D3H0zO0o8l8IWhppJv+psQ0r8eIm/dhJMvSgEwbdQuXziY0+BNP
X-Gm-Gg: AYBFou1jHYVyKM+nEjPq6AM56Ey4gy8McrcyBiD/8nbo8rHxG0KHjR//SxeHw7s0AlB
	Cz1RZPRSMGzH+Dx2PwF03NDaQyEraJCkM49jDtJL8QI5hAvjZgR7u6Skz3Y80Svq18qqMmjPSWA
	M5IY2/3ZNhFSCEpRmLeE/agrij+9btiufkdbjWjpnx4v45KpcooOnJTcrF0EXHcWwPK6rn144yU
	PPGzR/BlDC8IiLbxFYEF7oiWMveTq9YE9jIaOKt+96eaXMmdUGg07JHI2EbDbT5iMuastU5R11U
	5nG+qCONsO0vzlwy1E4rIXt1QiLlAQ1u4d5jU/hgCbKFANUxEyJ1109R2Mla62CCZBXlamXYq/s
	LnvYUDH0lka2EzyAuZiTjdRmPWkMz53EL+atATiyto/rINFOJqIVVHpeYvul1oTbLdIHwxBRX8f
	DfBbRJ3++iRa+3/aweKpblaaGbzf74G/G9+6EMRALvP6NvSipJgA8Gyt4QIJB1kC9OhBt60Td+0
	lm2kvcrOPdnf58N66bhAPeIZLwvxaWCADLgfemdyf/WU5N/VNAYLW7y2i0QJVaE4oOboQ3ORngk
	iQrr7zjDuKKCK7/T91FmWC/l2fXqTBj9usk/6QGcy0QzAVS7
X-Received: by 2002:a05:6a21:599:b0:3eb:aa33:e586 with SMTP id adf61e73a8af0-3ebb29c72f3mr3246747637.32.1793980887506;
        Fri, 06 Nov 2026 08:01:27 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:26 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] power: supply: mt6360_charger: drain chrdet_work before the power supply is freed
Date: Sat,  7 Nov 2026 01:00:57 +0900
Message-ID: <20261106160057.2754689-4-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106160057.2754689-1-hj351016@gmail.com>
References: <20261106160057.2754689-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

mt6360_charger_probe() registers the chrdet_work cancellation via
devm_work_autocancel() *before* devm_power_supply_register(), so devres
(which unwinds in reverse) frees the power supply device first and only
then cancels the work:

	devm_work_autocancel(..., &mci->chrdet_work, ...);   /* registered 1st */
	...
	mci->psy = devm_power_supply_register(...);          /* registered 2nd */
	...
	schedule_work(&mci->chrdet_work);

The work handler mt6360_chrdet_work() runs mt6360_handle_chrdet_ext_evt(),
which calls power_supply_changed(mci->psy). chrdet_work is scheduled at
the end of probe, so on an unbind that races that work, devres tears down
in reverse order: devm_power_supply_register()'s release frees the power
supply device before the devm_work_autocancel action drains chrdet_work,
and the work then dereferences the freed mci->psy -> use-after-free.

Register the work cancellation after devm_power_supply_register() (and
after the other devm resources), so reverse-order devres cleanup drains
chrdet_work while mci->psy is still valid. chrdet_work is only scheduled
later in probe, so moving the devm_work_autocancel() (which also
initialises the work) down is safe.

Found by code review; not runtime-reproduced (requires MT6360 PMIC
hardware and a charger-detect event racing device unbind).

[USER: add a Fixes: tag. SHA not verifiable in this graft-at-7.3 worktree.
 Blame the devm_work_autocancel() introduction in mt6360_charger.c on a
 full-history tree and confirm the 12-char SHA + subject before send.]
Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/power/supply/mt6360_charger.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index b4d4623..e382db4 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -790,9 +790,6 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	mci->vinovp = 6500000;
 	mutex_init(&mci->chgdet_lock);
 	platform_set_drvdata(pdev, mci);
-	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
 
 	ret = device_property_read_u32(&pdev->dev, "richtek,vinovp-microvolt", &mci->vinovp);
 	if (ret)
@@ -828,6 +825,16 @@ static int mt6360_charger_probe(struct platform_device *pdev)
 	if (IS_ERR(mci->otg_rdev))
 		return PTR_ERR(mci->otg_rdev);
 
+	/*
+	 * Register the work cancellation only after the power supply is
+	 * registered.  devres unwinds in reverse, so this guarantees the
+	 * work (which calls power_supply_changed(mci->psy)) is drained
+	 * before the power supply device is freed on unbind.
+	 */
+	ret = devm_work_autocancel(&pdev->dev, &mci->chrdet_work, mt6360_chrdet_work);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to set delayed work\n");
+
 	schedule_work(&mci->chrdet_work);
 
 	return 0;
-- 
2.43.0

