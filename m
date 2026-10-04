Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE263328FC
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088655; cv=none; b=quT+XismNMOyfAliqjYwaw4aApbDuTI85E5PQW9N4YfPmmOion/3xZ7m5XD73mpEFmiKNr/TyZDLhTmewK9HTXCM+ovymRonbj6ylDPjxbFTzs4dqv/Bjn4FInuKE3pI08whS9Qi0Z9n6zdCNqAYcRrM3L+P5Ik8a79f5owQdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088655; c=relaxed/simple;
	bh=y5MWv1hH6XNIhEimYcmLK1JF49F0Ht6bbn+rO0Eehvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fze+LPuMMUYgEaLC95Bk608sn11nPbazg085ybKOWI5QLevujMWM8NYkCW6XjtmaVEpYdXJ9yZ8VTv002r6ByK+DJZpkSWATaiDBl11n+SSX+UUPhoLxuGmAzl2Q95OYUUndMvNaPmnviGhyM4wxUaVdipJ4U3SQUOcbdd+PRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwDQaeEH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwDQaeEH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5338f65913dso9912781cf.2
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791088651; x=1791693451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpE22LeFXokQmJjuzufi6upumdakctZxmE2Fi+Aqg9M=;
        b=cwDQaeEHfwRqx3+WB09X00YHCJaU3k2NHsbH/yTkJUZDIRB2Zq+xgSk6cfxZwj5AE8
         8AfcEPwwi4+/Z27r7tR1VSfMuGwwEsGudqQIyhInPbwJ05kK2MVqkccXwmvbGjXmIbJ5
         nQ988rhelmTIYNIDNp+ZYUtMgP4TCDBafAjfurVZi7q5CPlVbwyz2y8uEzvpBXxtpbYb
         gi6vY303ASg/5qedQZOY06a3P/AUNmJOz0Op0JWZeMwt+Xq/QPofFkUwHKGa6JPF1rnR
         dRzXSQNkwQUG5dRxUQXiPB64mVEoJtfDD7zndDb2ThDnR5qBhQJREBpKRjMzmqE1GNye
         FhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791088651; x=1791693451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpE22LeFXokQmJjuzufi6upumdakctZxmE2Fi+Aqg9M=;
        b=FsdMyySCZXJjgWEkZpJdTGiHbLNCnyqTKiDWH7WvB2rbSWmMHxvEiAR4oNL1yRWYOA
         O9TBfq7xbbcpIUUKmo58jjUYAQ4fZIidKVSAHNZZCt8dniYB8ME68YJOjcPwqibkyNVV
         4BI28eKkWv8yJcodjTi06bRcgzwFAGf7AXgmfcjKOD6elX4kA7bUBVY4jDY6XxPIbUnP
         tplAGNo5eCj833ynPrXZjfgLHlVmJGaqLNeDF0I0eou5GCvjjGOl4qvHKuLSk4M+rJ6p
         4phh7otffoIh9KvKYBepN865WNeL2ASkg0r/heAzF8rcYmZGoAz5BO4lm3jDtPAahYRr
         vEew==
X-Forwarded-Encrypted: i=1; AKwUvBz1dtwU/ossxfkH8ZQ9MldwpzXafhd/ZSnbQ2BJoE1w7qTrZH6vAQ6aTqDc08J8JBuii9YM/T8=@vger.kernel.org
X-Gm-Message-State: AFuF++lJnm4oZx5Tgk2wdeB5tI0CfiWsPWdyr01C9M5cybOMaf4dI0nR
	E4TlPuoLQHDnyPvKIfIItfDGiReTakOjBiBfBS9mvs4u+5Y217vbQAM=
X-Gm-Gg: AYBFou2ubpUY/+tvfXUIhAMV5oS4KBp5BFwmkFBSxZyJzMTbQ0ykfyhDiHO285E7a/V
	bvaECqJMjI6ev/9YZ7MnsYVFcxmnMjgbdLft/qFNzPh9bnabb8/ldkcSLXtsQUDl/v0pBgk2JJA
	jZ/S9w+xUxNQaJaBkWBCyuVB45m9SVa5bG81xvtbtln6TvYV06dAeSLFN9bCuikKyEz7FOPG6lb
	81ASTwH0LX+XOVu1cOByv0DwzzvbRGdYrnBu/0FvCzr61KtwY+mAGL04IdI5eSuHHadT7HOJT6M
	k5N7m14WNE+/dKWtNDq9hPdHA3nwnF8oRI8RHHPqmXRAzQ0uYq9tf/8FLYmjMZxNX5hVd9gO9J3
	ncQhPa5DDhHMYp68/6UxRmVP47U71gaf43lpmYhhMDrFa9oZtq3O3jLX1Wa/tdcv87kmCdwulnh
	/ry/T2B3J+sOk5pMsCAhfHa1jhnjupuFczcKg97OqU0q1BMLjMceZBEA8uCDhx8ykquKHZxVbNQ
	M2aTk9X0PHYyra4Oj5G+dHkGzOO9zx1mBQSWTUmhPi3M6+EBNE1q6RnrfLZoX5AwuoH+dZnY0LM
	FHjuIhuw/8MGxC/59GRc9ZEgMCrBb4didKZ0Gss=
X-Received: by 2002:a05:622a:411:b0:533:8c7e:c6ec with SMTP id d75a77b69052e-53511e814afmr69716011cf.36.1791088651268;
        Sat, 03 Oct 2026 21:37:31 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398d32e19sm64829641cf.27.2026.10.03.21.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:37:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Samuel Kayode <samkay014@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] power: supply: pf1550: drain IRQ work before unregistering supplies
Date: Sun,  4 Oct 2026 00:37:28 -0400
Message-ID: <20261004043728.1140015-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VBUS work calls power_supply_changed(), but its managed
cancellation is registered before the supplies. Cleanup can therefore
unregister a supply while IRQ-triggered work is still pending.

Commit 838767f50747 ("power: supply: pf1550: Fix use-after-free in
power_supply_changed()") moved IRQ requests after supply registration,
but left work cancellation before the supplies. That change protects
the direct IRQ callbacks, while this fix drains the work they queue.

Register the three work items after both supplies and before the IRQs.
Cleanup then frees the IRQ producers, drains the work, and unregisters
the supplies.

The teardown ordering issue was found by static analysis.

Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/power/supply/pf1550-charger.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 2ead1df60e65..e3d4e9817f91 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -566,6 +566,22 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chg);
 
+	psy_cfg.drv_data = chg;
+
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &pf1550_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
+				     "failed: power supply register\n");
+
+	chg->battery = devm_power_supply_register(&pdev->dev,
+						  &pf1550_battery_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->battery))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
+				     "failed: power supply register\n");
+
 	ret = devm_delayed_work_autocancel(chg->dev, &chg->vbus_sense_work,
 					   pf1550_chg_vbus_work);
 	if (ret)
@@ -584,22 +600,6 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(chg->dev, ret,
 				     "failed to add battery sense work\n");
 
-	psy_cfg.drv_data = chg;
-
-	chg->charger = devm_power_supply_register(&pdev->dev,
-						  &pf1550_charger_desc,
-						  &psy_cfg);
-	if (IS_ERR(chg->charger))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
-				     "failed: power supply register\n");
-
-	chg->battery = devm_power_supply_register(&pdev->dev,
-						  &pf1550_battery_desc,
-						  &psy_cfg);
-	if (IS_ERR(chg->battery))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
-				     "failed: power supply register\n");
-
 	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0)
