Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794357375;
	b=mGj1G1XUNhCv1lCKpuO0vi6iij5tC9Kih8i8wSpn7qGBTBl917o0/bv/HGAYGYLqqbYS
	 0A+RyD5LX0eNTYCeRLjAZYsOd7RrpCI6k8vPHTYeqt3xZiC6xvtBdzJuu7UeL5L2fKyf7
	 DjhJkpv1xQuIq3MMNfMIuxcQlCNQ7LlAE/9baM2p2GqakMn3+1hFbyPXAbRgTD+VmEkCc
	 gPlZdG03QRdDhScBuAUbtgsM+qOWNaOhZFOFTD6mWwXWMskGpGvQBFTPt25E++JUQw4Fk
	 ipaS7Ndyp/Vm+VxjS/UlBHl/4QsZMbJ4cHR7QETjLgjiH1d26xC+CU6GAOICzfboc/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794357375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VgvghYGjz0cm34g5RNWKJoB5yybU1ndRLt5Jtc/eTEk=;
	b=rWUESoK5fgYNnRvGwnoLSq2jipMJHkfEGH8vR/d6GeLrGwh56rhIOSyTVqeNEDnrVHqe
	 JgPKx8qAnuI9EiJJhHGRN2Mx2mRa3vxCk1gi6Dq9Ky1mbS2m06jw2eXTPeC2aXF3VpMmC
	 w/b4+erXjjH/5oH8QWGUKJ0MHPuvuFGHKK8gnmearfVBoJU5J7fpDvKHKEGUgwMuvxava
	 xOsU7EH11+VxE9ZXJC7QFgJTc7IZwHjs0JuencmI2YAcrTqdQrG2FDC/rNyb0oKlP1V4M
	 pEJFCkaToMN7Bj9xlsyOJlCwUS5EeWqBMut64KklINod2pwgSqTutYJmv19rbcLb7Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjCdNuP7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BAA606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjCdNuP7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD14F1F0089F;
	Wed, 11 Nov 2026 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794357375;
	bh=VgvghYGjz0cm34g5RNWKJoB5yybU1ndRLt5Jtc/eTEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bjCdNuP7vag0ABNwCqCea8rzoAO5Elk2DTK2Bgks0nLAD8/ITNQqZ1nNPTBp7+6q8
	 t+UWoybpKpB9G13JgfXFd/4xoOWtQ2QL7dB7itP2oJzoP17mTNZapnWsq6ARKS2nr5
	 XwQ8peWMnf8/3l7NsjEhgnj54f34kveFsYv07PSo3GvbFOhEhVSx1oKl1J41476y8b
	 AqIYUgLxNNlAmZLfPRzafnKp3xJFP2rZtHOjMcKX79uYGrkQ/3VVrnGPV7uTb0fyFf
	 rUuqWCDo8fTnF/pEhQCb8TSNMgpv7Sr1Si2pSDnzNv1pUsdwbYGU55Q0jDUO7M5tVx
	 LPEJ2cNA7WMJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] power: supply: qcom_battmgr: Notify charger supplies of online changes
Date: Tue, 10 Nov 2026 19:36:13 -0500
Message-ID: <20261111002555.240825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052345-failed-6.12-87fd20da8ca8@kernel.org>
References: <20261107052345-failed-6.12-87fd20da8ca8@kernel.org>
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
[ sashal: Adjusted context to account for the missing battery-percentage calculation after charger-state updates. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/qcom_battmgr.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index d559825538631..3674afb0d49d0 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -998,6 +998,23 @@ static unsigned int qcom_battmgr_sc8280xp_convert_temp(unsigned int temperature)
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
@@ -1067,9 +1084,12 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
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

