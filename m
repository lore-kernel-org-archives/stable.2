Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16596476CF1;
	Tue, 13 Oct 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912904; cv=none; b=I2SX+JiG2a7RBnhlnO7hmqOvB7VLwGZXFhHFis57oQ786LU+RjCn15ES6JW3UfAuRWY2jNutL5n0Oxso9yuOk1aICDXLwFtBngsRkw3wP57OkCbkk/UdQABVP8d1+JGk4/ynPV0vzehX/6iSOO44y++/c70SmY74mNcFDjGm9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912904; c=relaxed/simple;
	bh=y/X75DFMsJzsDjB9Jbo2Kj0HLFl1a/CrkiotRQ657Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tM+4oKOz1kSbIYpNqZTeZ+0HVqhM6QKW+3hL4TYPJUW6q95yFT+GSDAgCsGM3df+s7cd0r+U2eW1XznumDlpUSd9LKSlG4H3YX3pZTdnLsogmuLdoYD4xCk8K2nIu9C83F4BT2cU38JuWDnaR0I+2V+m3w0BQ9RMHrmrDRfkitc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQv3YNpe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQv3YNpe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B51A3C2BCF4;
	Tue, 13 Oct 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791912903;
	bh=y/X75DFMsJzsDjB9Jbo2Kj0HLFl1a/CrkiotRQ657Is=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PQv3YNpetWGez1mdIFKP/h4mEuOFFLZ085b/JFXhreEmlZIW3gTbvGsi8YavEQXpN
	 +cxBA1aFJDGAzp3RDdWtinpFkcxXl07qW9Xb85ZfTCQ5F7vw0aStJnjoOqsnqF+wJC
	 hw2EFqSTnL9xrcVHTDQ9cnVvwED4Tdx0G/AQHdkw2M25TMHNA/ec+Hgcbe3y7RauW0
	 0ngQrkMZW1YyZvhix2pzGiH3j7F+iwf0OAtTA2nPyP7U5fSVGbo9QCw4PMR5TQd1oU
	 Y6vVRGnY0NwlHZKBN8y1w4crN1P8pe0MJEEW0v4bR1MsCCKjxqAbXup3jWBnDnL12v
	 6RMtThNOwIwoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEAACC6B12;
	Tue, 13 Oct 2026 17:35:03 +0000 (UTC)
From: Brandon Williams via B4 Relay <devnull+turbine.bmw.gmail.com@kernel.org>
Date: Tue, 13 Oct 2026 13:34:51 -0400
Subject: [PATCH] power: supply: qcom_battmgr: Notify charger supplies of
 online changes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-upstream-battmgr-charger-online-v1-1-731973e133a0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQqDMBCF4avIrDtgYpHaq5QuknSMU2qUmSiCe
 HfTdvnB4387KAmTwr3aQWhl5SkVmEsFYXApEvKrGGxtW1ObBpdZs5Ab0bucxyhYZhJJcEofToS
 hs7YxvnfXWwelMgv1vP0eHs+/dfFvCvmbheM4ARFO3mKDAAAA
X-Change-ID: 20261013-upstream-battmgr-charger-online-c92231bfa489
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Brandon Williams <turbine.bmw@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791912902; l=3326;
 i=turbine.bmw@gmail.com; s=20261013; h=from:subject:message-id;
 bh=2nahTR5uEsrzwi6gEYo9VL4sGI7ylJdvvKlUHbSEfWM=;
 b=LM56MtNNV6v+m7qf2P94pum++gKuqCP+2iZYUeT0ZwrYUbcRp4vk1/EeN/2uHg1OKY7eQ8nj4
 kevYfc+h5ziAyRr/Ifq8E3uREv8SLLuU13AvHBQeYaI/pV8TaeJpTEG
X-Developer-Key: i=turbine.bmw@gmail.com; a=ed25519;
 pk=Bpa28klX84MV14dvc8stQXHQtbFQK0xDK15qggaz3JA=
X-Endpoint-Received: by B4 Relay for turbine.bmw@gmail.com/20261013 with
 auth_id=1171
X-Original-From: Brandon Williams <turbine.bmw@gmail.com>
Reply-To: turbine.bmw@gmail.com

From: Brandon Williams <turbine.bmw@gmail.com>

On SC8280XP and X1E80100 the AC, USB and wireless supplies take their
online state from the charging source in the battery status response.
The firmware sends no notification for those supplies when the charging
source changes, and the driver only announces the battery, so userspace
never learns that the charger was plugged in or out. UPower keeps the
state it read at startup: a laptop booted on the charger never goes on
battery.

Call power_supply_changed() for a supply whose online state changes when
a status response is parsed. A supply that is not registered yet, when
the battery is read during probe, reports its state when it registers.

Tested on a Microsoft Surface Pro 11 (X1E80100): after restarting UPower
on the charger, unplugging now sets OnBattery, and plugging in clears it.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index a7237ba09be1..4ca340981922 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1255,6 +1255,23 @@ static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
 	return DIV_ROUND_CLOSEST(temperature, 10);
 }
 
+/*
+ * The charger supplies' online state comes from the battery status response,
+ * and the firmware sends no notification of its own when it changes, so
+ * announce the change here. A supply that is not registered yet announces its
+ * state when it is.
+ */
+static void qcom_battmgr_sc8280xp_set_online(struct power_supply *psy,
+					     bool *online, bool value)
+{
+	if (*online == value)
+		return;
+
+	*online = value;
+	if (psy)
+		power_supply_changed(psy);
+}
+
 static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 					   const struct qcom_battmgr_message *resp,
 					   size_t len)
@@ -1324,9 +1341,12 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 		battmgr->status.temperature = qcom_battmgr_sc8280xp_convert_temp(le32_to_cpu(resp->status.temperature));
 
 		source = le32_to_cpu(resp->status.charging_source);
-		battmgr->ac.online = source == BATTMGR_CHARGING_SOURCE_AC;
-		battmgr->usb.online = source == BATTMGR_CHARGING_SOURCE_USB;
-		battmgr->wireless.online = source == BATTMGR_CHARGING_SOURCE_WIRELESS;
+		qcom_battmgr_sc8280xp_set_online(battmgr->ac_psy, &battmgr->ac.online,
+						 source == BATTMGR_CHARGING_SOURCE_AC);
+		qcom_battmgr_sc8280xp_set_online(battmgr->usb_psy, &battmgr->usb.online,
+						 source == BATTMGR_CHARGING_SOURCE_USB);
+		qcom_battmgr_sc8280xp_set_online(battmgr->wls_psy, &battmgr->wireless.online,
+						 source == BATTMGR_CHARGING_SOURCE_WIRELESS);
 		if (battmgr->info.last_full_capacity != 0) {
 			/*
 			 * 100 * battmgr->status.capacity can overflow a 32bit

---
base-commit: 4eb2586bd40db27d77cc5b724ca9386ed0c71d53
change-id: 20261013-upstream-battmgr-charger-online-c92231bfa489

Best regards,
--  
Brandon Williams <turbine.bmw@gmail.com>


