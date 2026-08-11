Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB942FCBE;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=HZMeyKgN6JJ/jTaFXFiBeEsYT1MWp+xCbH23e5RCigfWij94kj/6oAx2/ISun8hJMmaBfVB6a0iNaoEvz8YuVvAva+if5M/x96qJt0Fw3HXVm8lU1nVrtsYfdckPH0r7RkWMZqOTO2K3+PQjmgzgk06OF+4ZTXfFJY5LjFqawaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=uZnKZPiVXeue8Uu4WPapV7YwNyoxKtW2ADUWeKCeC8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urSe7DVGF9C+EWowSsw6/mz6Yau5AfOwD5w7mIkjPfRlgiaJIdpYumXkoOzm228l2bnpXJscrFM+OO6nw9OhYMWAiaAE8J8bEsO7L00b4wNm31Z87N4KN8usKQdiRt69NRPnWpEpi5DwENZLeWDAGMXUim9vXUIQ9OFZ6X348qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzcbl6l3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzcbl6l3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DCA3C2BCF7;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=uZnKZPiVXeue8Uu4WPapV7YwNyoxKtW2ADUWeKCeC8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gzcbl6l3QZOkUZXSKFspErSMzPz6hv/6FUwme2/Y/oedtj+1FSFrcKHFtNE5O4P28
	 GPwiN4y8qkhJk2k0iEeLn84zF8PjhrhsRNkJVFS5IFoJMK2auuIClVHg85Jp7nsKE3
	 gn8AaTE2FXbxH5X7iQnsxX6gjySLrV312lKjn4Hc8XrOFh/zV/OmKwwhYHJ3IWnd1A
	 urmDOYlYHxQXebhTVthb3ydH40Rd2kPHhZRiXF1zHH6z996aWlLfsxGaSSIkNKus/I
	 QdkKX/uOb2/0a4kIN0ZV0jiKuC+O+dye2MRl/xG7xUw3057dO5I6GRXP2C/+Ekvf0C
	 L8GDhdNlf9MIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C24C5CFC1;
	Tue, 11 Aug 2026 23:30:12 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:29:58 +0200
Subject: [PATCH 1/5] power: supply: qcom_smbx: include base when petting
 watchdog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-smbx-fixes-v1-1-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=1126;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=5e8CybsOw3LrBX999BFZbrVFBttifaKFh6Gt0NuubDo=;
 b=oy6lqXOFMCMsSLOoU2y5/zWcOFG7Eqq0F/839bPpaDZeEeHdu0Mh8siyH2921BWi2qQZhYRPd
 0rzXWQ08o0XASpYThe57fLhE/5UNhM7qjytNiybyiWizOmCjyqIOV5I
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Robin Snyders <robin@snyders.xyz>

BARK_BITE_WDOG_PET is an offset from the charger peripheral base, but
the watchdog bark handler writes it as an absolute SPMI address. This can
write another PMIC peripheral and leave the charger watchdog unserviced.

Add the charger base, as all other qcom_smbx register accesses do.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 drivers/power/supply/qcom_smbx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 67fdb43353388..e6f2328f295c7 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -764,7 +764,7 @@ static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
 
 	power_supply_changed(chip->chg_psy);
 
-	rc = regmap_write(chip->regmap, BARK_BITE_WDOG_PET,
+	rc = regmap_write(chip->regmap, chip->base + BARK_BITE_WDOG_PET,
 			  BARK_BITE_WDOG_PET_BIT);
 	if (rc < 0)
 		dev_err(chip->dev, "Couldn't pet the dog rc=%d\n", rc);

-- 
2.54.0


