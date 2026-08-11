Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C8434E28;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491013; cv=none; b=n+l+WiHu37IIpCARxl80XR53Me16LE1TYCMy5PdCedWD7ZAuH55NfkoADJh5Zf4Q8Zho54trEz1ZR4SyEo7G44xrgFpzBxX5P8qz63AlEfNMuBM2dasjU/mD/1abvBw4ytCQpZFmlgYZru6lblRZGQZQ+w35zZvZFbvlM0qyEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491013; c=relaxed/simple;
	bh=nDCQMrqqLhcGA5ze3CZMmKpJQMapDcbbk4gIUPfJxKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwAM3vU1J7TD+VTLxCnlmFIQqDEeITtPjyJVj56tlwG2NjYFQcyvL3u0Ne28guIbSis2RysTb1dkiVBinciXUD88flv4hPLlNIn8jHyZfE/Do0RHUt92NMoeutEDyasxmvGz/e9HWVbTtbF1UCz7rnFlDnhJ40AbRx3Y/ImENCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUDOqmqu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUDOqmqu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AB90C2BCF4;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786491013;
	bh=nDCQMrqqLhcGA5ze3CZMmKpJQMapDcbbk4gIUPfJxKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rUDOqmquAS037bEakwCTDU8lGDMnYaalHTc3QgHhnAiYMg8qwKRndGL0VSg3k4351
	 7yOIOicA9dEk1ni9Ll/ZtBvnPATaEtsYeLdk5DqEse9ymqlAT9QZF90dca5/KAAcg1
	 HKY7Gl3+ayZ1P4/3kbebOWAqeqo0WrDsfD2BpQhjrqB5tltKdHqzJWCZ31NiZFHEz2
	 zvP7TYYTGj8L2aIB6wOMJUuuJ/vs7qyvnY0YgdyNpliG74Mz516BBJMg2H6Uoi1Dmj
	 kXgdkwHmqY0UZPTk/MXLte1amgCeadgOKr+9gfBQvoz/y98BGzvSK5eiUKZf6Lcp8r
	 KTdnFbWQb4LZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C8C5AC67;
	Tue, 11 Aug 2026 23:30:13 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Date: Wed, 12 Aug 2026 01:29:59 +0200
Subject: [PATCH 2/5] power: supply: qcom_smbx: test battery health status
 bits
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-qcom-smbx-fixes-v1-2-eb48246be599@snyders.xyz>
References: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
In-Reply-To: <20260812-qcom-smbx-fixes-v1-0-eb48246be599@snyders.xyz>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Robin Snyders <robin@snyders.xyz>, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786491008; l=1862;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=pib+eZmrfk0+6cRSQ4e+JEOtgsEfLbNvhWGtFGr9m90=;
 b=w/5tI2HuuIkwX3Q6/U4R7y/mIW6GutHQBKyGhxnzi4Tfe6EaJuJoXxpbFLvQec1QcQsPCAqEG
 g8z1kmplFtpAmAxvgRKv4b5ZXUMH90WQp/O3vDA3qvyiuHtoST8zalH
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

From: Robin Snyders <robin@snyders.xyz>

BATTERY_CHARGER_STATUS_2 contains independent status and fault bits.
Switching on the complete register only recognizes a fault when it is the
sole asserted bit, and can report a healthy battery when another status
bit is set at the same time.

Test the relevant fault bits in priority order, matching the Qualcomm
downstream driver handling.

Fixes: 8648aeb5d7b7 ("power: supply: add Qualcomm PMI8998 SMB2 Charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
 drivers/power/supply/qcom_smbx.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index e6f2328f295c7..0e50d81aefc2a 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -632,26 +632,20 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
 		return rc;
 	}
 
-	switch (stat) {
-	case CHARGER_ERROR_STATUS_BAT_OV_BIT:
+	if (stat & CHARGER_ERROR_STATUS_BAT_OV_BIT)
 		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-		return 0;
-	case BAT_TEMP_STATUS_TOO_COLD_BIT:
+	else if (stat & BAT_TEMP_STATUS_TOO_COLD_BIT)
 		*val = POWER_SUPPLY_HEALTH_COLD;
-		return 0;
-	case BAT_TEMP_STATUS_TOO_HOT_BIT:
+	else if (stat & BAT_TEMP_STATUS_TOO_HOT_BIT)
 		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
-		return 0;
-	case BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
+	else if (stat & BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT)
 		*val = POWER_SUPPLY_HEALTH_COOL;
-		return 0;
-	case BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
+	else if (stat & BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT)
 		*val = POWER_SUPPLY_HEALTH_WARM;
-		return 0;
-	default:
+	else
 		*val = POWER_SUPPLY_HEALTH_GOOD;
-		return 0;
-	}
+
+	return 0;
 }
 
 static int smb_get_property(struct power_supply *psy,

-- 
2.54.0


