Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980237C926
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609685; cv=none; b=sA8kCbJXq6eGSPfV5kmAyGXU1jfPNkq+oJ2uFf60LNh+VacIdHDPteSHA4pUp6OE9rgZXotc7/xjlVgBePJxtOeCGFB85JsU3y21rbUYP60TvK0Een5lYznM0JbUKPbbnP2TfOOCb0HB8/js2CGthRU0w5cW7XAoqemj4eQKoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609685; c=relaxed/simple;
	bh=0nkF49bQetw+FJ/bbgw/nkySD284409l/tJNIDgeWoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwGmJ4G7G8DU64Wk2kumEx8lRoIYOz4Lw5IK3LaHm27RyIAz6XG2S+ZpT4WbsD81cm0A222/XIe6zn960Lm4STU9YLtK9Is6Ek0TB4hrJ473uEk++13PLlTOE+ybMmevEOkKMy+NXZF4ubhW2Hfh8qZy3xqAszkYQI6QSV3t2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNwzk0E3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNwzk0E3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECAA1F0089A;
	Thu, 17 Sep 2026 01:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609684;
	bh=o4vPUwXEY7nkpZaVUxHadZV6Bj7AeY6zTXKwWmYjc14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNwzk0E3eiLfjslCzBBA1yIvwRDf1OVOSFHqxZytk0Ker+xbm5rrjLn5jqPovR+NY
	 yk8jVdOG+f2P8iOfmTDvmgHMvah1X5AVYrGQOXifKpqW+Rh2kFGPYl24uGMDaYxsm9
	 +KH3LD5FPAM/h25AWZLjfsUpOnpLlhWm2MlULtg15okJ++FvGztmQ3koqZ1J9YS2eu
	 qjKKPJlbAudwokDah0UCOJlIqx5NKNhNRlwdCZxOTwWwILHOjP8sZvxW+IEVdB7cpr
	 Qu+X2BknpSk6NSL1sWUMfryHve4R8faTvklxOfEHxfz1QB7or+/YIukN/e7MqqMCYl
	 racApLxI4QZ1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arie Miller <renari@arimil.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/4] hwmon: (asus_rog_ryujin) Synchronize HID command and report handling
Date: Wed, 16 Sep 2026 21:47:59 -0400
Message-ID: <20260917014759.3688961-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917014759.3688961-1-sashal@kernel.org>
References: <2026091625-precut-stinger-57d0@gregkh>
 <20260917014759.3688961-1-sashal@kernel.org>
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

