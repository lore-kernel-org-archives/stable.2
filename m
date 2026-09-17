Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244D37F8C7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610184; cv=none; b=O2lvja4kS7cKrmfzSFsKnbSSZzE1WQ9wCQJ/8xDxfTaWCNRSV0KAaztaTKynPnQGexC93yj4UvawCBTdd7+lF/HQ1dQ2KHJC7R317ch1IdxtOQwmTbhuTw7hGbCxHUXSsB29WYWfrOWjvGv/Ocrd1kXqErLByH63/OaW4exnUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610184; c=relaxed/simple;
	bh=0nkF49bQetw+FJ/bbgw/nkySD284409l/tJNIDgeWoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8j6KYoljywKdcmCrCL/1zA79tq/jy6+tl4a1PpFN8KJ1KDcwF8h9XVWp0tUopdx3DbWhyXP1Nzi0Vj6jjUur26ha34nkvk1CF71Ok8eVFDCXNgGFLaZZO76K+w4GppeBR3yBYEDDO+iIEEeXhLjesM+g0L2JnmicrzRIZpwz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDFZoF0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDFZoF0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70FF1F0089A;
	Thu, 17 Sep 2026 01:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610182;
	bh=o4vPUwXEY7nkpZaVUxHadZV6Bj7AeY6zTXKwWmYjc14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDFZoF0yhb5hLw7LCGYvRT/aVv1bE8cjVZiWrP1RIS0bNo7FvZFyF8Ms2ymod2h+J
	 5VJiYKIXS6PJETU5GSduilMA5YJiGBZaurb+TZ+IW/O7Q68hV5R45oMluc2Ux06QLN
	 V2d/XZgOy4KVtGswzTP0v/9FP8YMoShu9+Jkd5vKRDHoAI3ZMv1Dk6oLlxMcBZLapm
	 raosNQOrNQIdJR+kQ1dbCy/y3/XUefBmtqWZbdpawgPO+21KDWMa+T0LaU1m2L2XAr
	 M5XBscXokQlUpDGIthtOYsIhxqLRiOmqbCS8kLtTQ3Zjs3YA1y8fH258m8q4PRXonx
	 P9LUl+9nQ63Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arie Miller <renari@arimil.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] hwmon: (asus_rog_ryujin) Synchronize HID command and report handling
Date: Wed, 16 Sep 2026 21:56:18 -0400
Message-ID: <20260917015618.3719452-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917015618.3719452-1-sashal@kernel.org>
References: <2026091626-rug-outlet-4509@gregkh>
 <20260917015618.3719452-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arie Miller <renari@arimil.com>

[ Upstream commit 06d48355bf41028c1321acda6a4391cd70098be8 ]

rog_ryujin_execute_cmd() holds status_report_request_lock while
reinitializing a completion, intending to exclude raw-event handling.
However, rog_ryujin_raw_event() does not acquire the lock when it updates
the completion. A response can therefore race with reinit_completion() and
be lost, leaving the command to time out.

Hold the lock while parsing reports and updating their completions. Use the
irqsave variants in both paths because raw-event handling may run in
interrupt context.

Fixes: ed3e03790c5c ("hwmon: Add driver for ASUS ROG RYUJIN II 360 AIO cooler")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hwmon/20260812104617.858D01F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol sparse
Signed-off-by: Arie Miller <renari@arimil.com>
Link: https://patch.msgid.link/20260904022129.97896-3-renari@arimil.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus_rog_ryujin.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index 593950802b39d..f352036f0e52e 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -173,6 +173,7 @@ static int rog_ryujin_write_expanded(struct rog_ryujin_data *priv, const u8 *cmd
 static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, int cmd_length,
 				  struct completion *status_completion)
 {
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -180,9 +181,9 @@ static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, i
 	 * completion. Reinit is done because hidraw could have triggered
 	 * the raw event parsing and marked the passed in completion as done.
 	 */
-	spin_lock_bh(&priv->status_report_request_lock);
+	spin_lock_irqsave(&priv->status_report_request_lock, flags);
 	reinit_completion(status_completion);
-	spin_unlock_bh(&priv->status_report_request_lock);
+	spin_unlock_irqrestore(&priv->status_report_request_lock, flags);
 
 	/* Send command for getting data */
 	ret = rog_ryujin_write_expanded(priv, cmd, cmd_length);
@@ -410,15 +411,18 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 				int size)
 {
 	struct rog_ryujin_data *priv = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	if (size < 2 || data[0] != RYUJIN_CMD_PREFIX)
 		return 0;
 
+	spin_lock_irqsave(&priv->status_report_request_lock, flags);
+
 	if (data[1] == RYUJIN_GET_COOLER_STATUS_CMD_RESPONSE) {
 		if (size <= priv->info->temp_offset + 1 ||
 		    size <= priv->info->pump_speed_offset + 1 ||
 		    size <= priv->info->fan_speed_offset + 1)
-			return 0;
+			goto unlock;
 
 		/* Received coolant temp and speeds of pump and internal fan */
 		priv->temp_input[0] = data[priv->info->temp_offset] * 1000 +
@@ -432,7 +436,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->cooler_status_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_SPEED_CMD_RESPONSE) {
 		if (size <= RYUJIN_CONTROLLER_SPEED_3 + 1)
-			return 0;
+			goto unlock;
 
 		/* Received speeds of four fans attached to the controller */
 		priv->speed_input[2] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_1);
@@ -444,7 +448,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->controller_status_received);
 	} else if (data[1] == RYUJIN_GET_COOLER_DUTY_CMD_RESPONSE) {
 		if (size <= RYUJIN_INTERNAL_FAN_DUTY)
-			return 0;
+			goto unlock;
 
 		/* Received report for pump and internal fan duties (in %) */
 		if (data[RYUJIN_PUMP_DUTY] == 0 && data[RYUJIN_INTERNAL_FAN_DUTY] == 0) {
@@ -463,7 +467,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 				 * We're expecting a report, so parse it.
 				 */
 				goto read_cooler_duty;
-			return 0;
+			goto unlock;
 		}
 read_cooler_duty:
 		priv->duty_input[0] = rog_ryujin_percent_to_pwm(data[RYUJIN_PUMP_DUTY]);
@@ -473,7 +477,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->cooler_duty_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_DUTY_CMD_RESPONSE) {
 		if (size <= RYUJIN_CONTROLLER_DUTY)
-			return 0;
+			goto unlock;
 
 		/* Received report for controller duty for fans (in PWM) */
 		if (data[RYUJIN_CONTROLLER_DUTY] == 0) {
@@ -492,7 +496,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 				 * We're expecting a report, so parse it.
 				 */
 				goto read_controller_duty;
-			return 0;
+			goto unlock;
 		}
 read_controller_duty:
 		priv->duty_input[2] = data[RYUJIN_CONTROLLER_DUTY];
@@ -501,6 +505,8 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->controller_duty_received);
 	}
 
+unlock:
+	spin_unlock_irqrestore(&priv->status_report_request_lock, flags);
 	return 0;
 }
 
-- 
2.53.0

