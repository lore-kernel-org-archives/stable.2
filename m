Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358669;
	b=ZVvbjv3n/wcec0erc6PJpNfuG2fFLpVVD2XzVzg7B1N1HRcB9eeL0E7e2a9+w7/Vvwbs
	 PJB0rc9K4hKXphlpGv6/l/MLW7Yu0bsUjBQcKd63GL72HQ+UZwVqOHApdjfKSvokB51Le
	 TqkFpe7pLPS/jTrjhgYpPfZTc9qFOJO8cwcULxgFRdor9vWOuCACKi6gVVwWpPji+Mfia
	 vU78LlnevE+kJE3L4Mdb5QeO7yHtQHJYl7QW3UHTFT9dmlHV78GZTieZaVtthBy4gFOXd
	 89fhuPsCyfYGsLgyY9DXjPS2b5ZsZSm4n4MXNqvbi4DJso+NO6bNOblsg3v0mtRZBHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QJYN9VljECk8SN9KD1oY6wevswLMDtbX54MloZlQnb0=;
	b=Wm331RFrCFG0XsmPcXPy6hdL5IO2Z0B7VZgIwcBbiOIJ1Exz5lIxcIY+BLb5coTNKrO2
	 mEGAZ6fBhbdpzlbv3C59ziG0nNIG+MfR/QjP1ffJqbKSXEnIGAXPrkn6Soa+3a+STmt2m
	 IBp2lroqYKonc+ErNyZawsOPIAqgCfofLoJTAbQhup8SC17BojJ5c32wk8GvZvaY6/FNo
	 2T7Anu8BMBXvjsNhnEX0fLfHsGtLzdsYvJ5vSgeTYenHDuOdSHdVHOu2mJ4xN2Ulyq4WE
	 erE5ICn8tEAwtGLk2s4D2HRjclmn/mBTJXhrXwwI9WkizNU53I6/QpzrGu5N0i2mnIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akEEZxm8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF681606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akEEZxm8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1291F0089F;
	Wed, 11 Nov 2026 00:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358669;
	bh=QJYN9VljECk8SN9KD1oY6wevswLMDtbX54MloZlQnb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=akEEZxm8+0JaTK8HmSlXo2u9gaBlSLN06AK/X6smnWbSf7w19/M44+5+3VQy+VeLZ
	 yZ54/tq0/sQfLH9TOE5MBOlwEM5zxRfOYpoBz4bnrroLkhPxI/t4ee5QBah6EdXIFB
	 l1cinA3i/TDUZsrHDAgT1pr3zwVi/HDntqE4DAOn8JfZWekVWEc0QVr0FVqTRr2T8v
	 ICHpFIOzy6ob0pgD/sARkHkqGggvYs3ZUh9woVA4cm3f4pPFX6FQzIFaegsYVxkZ96
	 KPPWvVbgAUqR3U7o89yhLX2/cMkLX26aKHfbKIq9iNSCErwT12mbu0Gn7O9JPvydX7
	 3j+sYiRGk4bDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] power: supply: qcom_battmgr: Notify charger supplies of online changes
Date: Tue, 10 Nov 2026 19:57:47 -0500
Message-ID: <20261111004736.294060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053622-failed-6.6-87fd20da8ca8@kernel.org>
References: <20261107053622-failed-6.6-87fd20da8ca8@kernel.org>
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

From: Brandon Williams <turbine.bmw@gmail.com>

[ Upstream commit 87fd20da8ca8bacdaa9bff5860167f208077dc51 ]

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
Link: https://patch.msgid.link/20261013-upstream-battmgr-charger-online-v1-1-731973e133a0@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
[ sashal: adjusted callback context because the last_full_capacity block is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 7b51f827c34cd..65140d4985af1 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -995,6 +995,23 @@ static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
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
@@ -1062,9 +1079,12 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
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
 		break;
 	case BATTMGR_BAT_DISCHARGE_TIME:
 		battmgr->status.discharge_time = le32_to_cpu(resp->time);
-- 
2.53.0

