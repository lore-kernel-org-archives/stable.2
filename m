Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61121434404;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=MNdeOqyq1ZFjxkTjMrYMWVYsTqmj9SXIZRzfDbv0PfiQ+X7btrh4DnSZyilbdUxE5Eqo/SW5UQs43s0Ri9DARWwOTKBBPsa9VmIYOSbnAd1ESpr60HqOM3Da/55QQPC/O26l06u8L68OhECgXF4FXtXNKmxiSUqcRy89C0WQ5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=ANh+hAN+mJ2qTvzYOi2dLKnglttlmygNN/T5MmXnEmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h79g8c6ZbySwbJC00J8legbmIkVk+b2wSLF/niEW5E8EeFqSaFgea9buC3VDHO8/CrM8yNh6aEFRBwN2ERtuHTdW/Zs0xHfIx+a3y7fQmt9lb2u29fe2BpqOSW4WdSyx4J0MvSGGBZRVwAhcTz8Lzre8COF4xafsORp9gf7bxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/1XdPqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/1XdPqY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 266B3C2BCFA;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=ANh+hAN+mJ2qTvzYOi2dLKnglttlmygNN/T5MmXnEmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F/1XdPqYRD5ACV/pCeRqXWvsT67KQW5DV2B6zSWN43r1j1ATRP7bVASBco5aRibNj
	 ApKohOVX+LhnNHS9DkY0MQOWGpfVMy7D6Feg3jlNQ6qWkQ8TVKqALOka49HBETCxCs
	 5es/ygr3hXqYKPEGwfZqNPaTXmdjnIpXOZvHzBtgseXsrmMuMf0FP79ev1gz9JzCJP
	 FrloXz7ykS7fd6HFy1PGueK/EtDlsgoA3wKezV4OZuf3+rnNS8BvQ4mO8MZ4YFCHx0
	 1LTiShYBbEibPW3qjlqkLriz4cH7e76IOh8G98zVsgEdxZjLz9REETMUrPi2AsdF4i
	 69TmMQSVPtTEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5AC5CFE7;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:30:00 +0200
Subject: [PATCH 3/5] power: supply: qcom_smbx: fix float voltage selector
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-smbx-fixes-v1-3-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=1518;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=6UyH258rSK3oQF7Z0c6NQwggo0QjJynT2bHO0YhRjAg=;
 b=lJ18uawkS2hZQVHV+VPTSVZbIOHjQW9p0C5FG1X18Rfu6Kz4vlvguWFi21xzWprrhT+KbtskK
 DF4MeGyozd9DEztOOMAr0M+DswB+K/ZBNk4ZS7EeGu6uZ6AltY7ecIO
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Robin Snyders <robin@snyders.xyz>

FLOAT_VOLTAGE_CFG encodes 3,487,500 uV as selector zero and advances in
7,500 uV steps. The current calculation adds one to that selector, so it
programs the requested float voltage one step too high.

Remove the extra offset and name the hardware encoding constants.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 drivers/power/supply/qcom_smbx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 0e50d81aefc2a..e236b95c0ebf3 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -352,6 +352,8 @@
 
 /* pmi8998 registers represent current in increments of 1/40th of an amp */
 #define CURRENT_SCALE_FACTOR				25000
+#define SMB2_FLOAT_VOLTAGE_MIN_UV			3487500
+#define SMB2_FLOAT_VOLTAGE_STEP_UV			7500
 /* clang-format on */
 
 enum charger_status {
@@ -993,7 +995,8 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, rc,
 				     "Failed to init status change work\n");
 
-	rc = (chip->batt_info->voltage_max_design_uv - 3487500) / 7500 + 1;
+	rc = (chip->batt_info->voltage_max_design_uv -
+	      SMB2_FLOAT_VOLTAGE_MIN_UV) / SMB2_FLOAT_VOLTAGE_STEP_UV;
 	rc = regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
 				FLOAT_VOLTAGE_SETTING_MASK, rc);
 	if (rc < 0)

-- 
2.54.0


