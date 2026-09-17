Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ADC37C924
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609869; cv=none; b=E1IpP2uvCagIUv+979K9GxMoC/3sNG5/leyyDtuLqMaxoDGC5YzOF5md/BlCmHrMudwpR6GCvCawt+ZC+f5u3HYtVH8SBlz3Kc0wFT13irMv6y/gegF+fa4hZAk+d47QiWG65fkKyVR8NmovzjpdsT5baR7yHCklGkebevS9/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609869; c=relaxed/simple;
	bh=gDgW7ToPm4SURDmCrZ0YvXI+VVFYecgqPi05csIMCWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNa8LOUmJnbx9b+cmbqgZr5h9i1lA+/XFygfl8G9QaSnVzEtsBfnvYObGuOUW2YJ7ZWZ9kKPUt+6G41GXLLDynIYk/HIHEDG/lI30N+oFuGMAKNujO05JO3OrM+jEVqOBltBBDq0SJ/Xs99rKB04qtOJKsp7dCHvyGbCor1a8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxZMxLVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxZMxLVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FBE1F00899;
	Thu, 17 Sep 2026 01:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609868;
	bh=7mJczzme1VPuusuasrjV5eS+pQcLg2feKK9SXHRjLeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxZMxLVBNni+4CDB+SUboMtl3gAYkCgDSVYKi/s4NC4eekZ2dmlmmSbS3bLuLJXHg
	 ayNDMEh535Ot2R6DY9IEbqJXMxAMN29OT1V9IZW5PEp73bw7eNhpfL2nuymBHj9y2p
	 3/wYOggLz9mlmj65FB5PQnYp6UzGMXMBALZAkp6HJe07omFzohEr0s4gGkctEQ0L2v
	 Mnvfo5m5gZQXdSBzW1URTqGCGB9qJ0ljlDi4ETOVNRduXlFDxAwqExRRuM1fD1MBH5
	 nmx9Ug42P//ObIxG+7eVDxMuMsDCD3yXZQ3RhPf/Jio1Kf/hhURoPU3TAmkVg0Atp8
	 kdJKxo17iUUdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arie Miller <renari@arimil.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] hwmon: (asus_rog_ryujin) Validate HID report lengths
Date: Wed, 16 Sep 2026 21:51:05 -0400
Message-ID: <20260917015105.3705183-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917015105.3705183-1-sashal@kernel.org>
References: <2026091604-activism-jackpot-afcf@gregkh>
 <20260917015105.3705183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arie Miller <renari@arimil.com>

[ Upstream commit 8042312e73c50de82634ce63eae7cf219464b481 ]

rog_ryujin_raw_event() parses response headers and payload fields without
first checking that they are present in the received report. A short report
can therefore make the driver consume uninitialized bytes from the HID
transport buffer and expose them as sensor values through sysfs.

Validate the response header and the fields used by each response type
before parsing them.

Fixes: ed3e03790c5c ("hwmon: Add driver for ASUS ROG RYUJIN II 360 AIO cooler")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hwmon/20260812104617.858D01F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol sparse
Signed-off-by: Arie Miller <renari@arimil.com>
Link: https://patch.msgid.link/20260904022129.97896-2-renari@arimil.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus_rog_ryujin.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index 80563ce38519d..593950802b39d 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -411,10 +411,15 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 {
 	struct rog_ryujin_data *priv = hid_get_drvdata(hdev);
 
-	if (data[0] != RYUJIN_CMD_PREFIX)
+	if (size < 2 || data[0] != RYUJIN_CMD_PREFIX)
 		return 0;
 
 	if (data[1] == RYUJIN_GET_COOLER_STATUS_CMD_RESPONSE) {
+		if (size <= priv->info->temp_offset + 1 ||
+		    size <= priv->info->pump_speed_offset + 1 ||
+		    size <= priv->info->fan_speed_offset + 1)
+			return 0;
+
 		/* Received coolant temp and speeds of pump and internal fan */
 		priv->temp_input[0] = data[priv->info->temp_offset] * 1000 +
 			data[priv->info->temp_offset + 1] * 100;
@@ -426,6 +431,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->cooler_status_received))
 			complete_all(&priv->cooler_status_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_SPEED_CMD_RESPONSE) {
+		if (size <= RYUJIN_CONTROLLER_SPEED_3 + 1)
+			return 0;
+
 		/* Received speeds of four fans attached to the controller */
 		priv->speed_input[2] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_1);
 		priv->speed_input[3] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_2);
@@ -435,6 +443,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->controller_status_received))
 			complete_all(&priv->controller_status_received);
 	} else if (data[1] == RYUJIN_GET_COOLER_DUTY_CMD_RESPONSE) {
+		if (size <= RYUJIN_INTERNAL_FAN_DUTY)
+			return 0;
+
 		/* Received report for pump and internal fan duties (in %) */
 		if (data[RYUJIN_PUMP_DUTY] == 0 && data[RYUJIN_INTERNAL_FAN_DUTY] == 0) {
 			/*
@@ -461,6 +472,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->cooler_duty_received))
 			complete_all(&priv->cooler_duty_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_DUTY_CMD_RESPONSE) {
+		if (size <= RYUJIN_CONTROLLER_DUTY)
+			return 0;
+
 		/* Received report for controller duty for fans (in PWM) */
 		if (data[RYUJIN_CONTROLLER_DUTY] == 0) {
 			/*
-- 
2.53.0

