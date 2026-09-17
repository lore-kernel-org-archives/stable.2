Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25937F8A7
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610181; cv=none; b=K63y7ppzbVTlhVjUASQgeEmZIgfORT8pvtJO3KiespqorT3VPhfKduM3emFv9MkDq72EHySZYh9mkipq/ok0ifMp+v3y918zkOaE3zGwl4abWpH7voajE92/oFulbTAdp0q76KLAtk0hOeZXpVf6zfM+yyUw7NGzazw23/DO3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610181; c=relaxed/simple;
	bh=euL9U3hK630ffblXycOvDxnht029gf0DErthokS8e34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDTTCL/mwaISO0KzUR4C7mBpUbrZBCV5cI5R3c1v5qyQTU6jJr0xFYA/aZe/KIpeVEmIPAiNNmy8NrmidL/Urdq7szgRr9pn90+xDH9zGqwhwdFRGR1nY8JjOcCkATKTofwbv2U8Wl08g5GuwqgUoLzJ77h3T7GWiQX4k9kxYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR9v1FR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR9v1FR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE951F000FF;
	Thu, 17 Sep 2026 01:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610179;
	bh=R8KEpWaGsEnRPN57OUcDwjVxFdxfSfvWrAfrty1SIds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NR9v1FR+/OiqkKySjB79rV2o9/6MsttEIaobyw+UNd0hyKRbcnL3tOu3UptJPfQ/G
	 nOkp10FUSMvligo0fhJwogeNG7+Eyjoz9jPgFJxhP31rAaidde+kVMnDcPjPWVUAk9
	 CYGRNBJRXSTe8x5YXHEdVZLb+0QP3y8xw8egs4A5CamoujpyDflU0JTMxpwOh+K2P2
	 mkqzSIzMVLoBh7d2ULXUs1Z5Tw9U/6ec+T0b+eXCxCtvjx1sY/WzLraJGCxQYQy7tA
	 PpNohxPm54lYNGSOUgrxbdHJsXt9bU/Bw2sFOjxtRDOHwPMUdPfXTd/Asu9N61LMNZ
	 3wlNcNo1/vDWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] hwmon: (asus_rog_ryujin) Rely on subsystem locking
Date: Wed, 16 Sep 2026 21:56:15 -0400
Message-ID: <20260917015618.3719452-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091626-rug-outlet-4509@gregkh>
References: <2026091626-rug-outlet-4509@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit b4306c0c8e24f9e031185fb87de45391bc8c7fe9 ]

Attribute access is now serialized in the hardware monitoring core,
so locking in the driver code is no longer necessary. Drop it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: 06d48355bf41 ("hwmon: (asus_rog_ryujin) Synchronize HID command and report handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/asus_rog_ryujin.c | 48 +++++++--------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index e5e93a20723c4..10a1f5aca988d 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -81,10 +81,6 @@ static const char *const rog_ryujin_speed_label[] = {
 struct rog_ryujin_data {
 	struct hid_device *hdev;
 	struct device *hwmon_dev;
-	/* For locking access to buffer */
-	struct mutex buffer_lock;
-	/* For queueing multiple readers */
-	struct mutex status_report_request_mutex;
 	/* For reinitializing the completions below */
 	spinlock_t status_report_request_lock;
 	struct completion cooler_status_received;
@@ -153,18 +149,10 @@ static umode_t rog_ryujin_is_visible(const void *data,
 /* Writes the command to the device with the rest of the report filled with zeroes */
 static int rog_ryujin_write_expanded(struct rog_ryujin_data *priv, const u8 *cmd, int cmd_length)
 {
-	int ret;
-
-	mutex_lock(&priv->buffer_lock);
-
 	memcpy_and_pad(priv->buffer, MAX_REPORT_LENGTH, cmd, cmd_length, 0x00);
-	ret = hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
-
-	mutex_unlock(&priv->buffer_lock);
-	return ret;
+	return hid_hw_output_report(priv->hdev, priv->buffer, MAX_REPORT_LENGTH);
 }
 
-/* Assumes priv->status_report_request_mutex is locked */
 static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, int cmd_length,
 				  struct completion *status_completion)
 {
@@ -196,14 +184,11 @@ static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, i
 
 static int rog_ryujin_get_status(struct rog_ryujin_data *priv)
 {
-	int ret = mutex_lock_interruptible(&priv->status_report_request_mutex);
-
-	if (ret < 0)
-		return ret;
+	int ret;
 
 	if (!time_after(jiffies, priv->updated + msecs_to_jiffies(STATUS_VALIDITY))) {
 		/* Data is up to date */
-		goto unlock_and_return;
+		return 0;
 	}
 
 	/* Retrieve cooler status */
@@ -211,36 +196,30 @@ static int rog_ryujin_get_status(struct rog_ryujin_data *priv)
 	    rog_ryujin_execute_cmd(priv, get_cooler_status_cmd, GET_CMD_LENGTH,
 				   &priv->cooler_status_received);
 	if (ret < 0)
-		goto unlock_and_return;
+		return ret;
 
 	/* Retrieve controller status (speeds) */
 	ret =
 	    rog_ryujin_execute_cmd(priv, get_controller_speed_cmd, GET_CMD_LENGTH,
 				   &priv->controller_status_received);
 	if (ret < 0)
-		goto unlock_and_return;
+		return ret;
 
 	/* Retrieve cooler duty */
 	ret =
 	    rog_ryujin_execute_cmd(priv, get_cooler_duty_cmd, GET_CMD_LENGTH,
 				   &priv->cooler_duty_received);
 	if (ret < 0)
-		goto unlock_and_return;
+		return ret;
 
 	/* Retrieve controller duty */
 	ret =
 	    rog_ryujin_execute_cmd(priv, get_controller_duty_cmd, GET_CMD_LENGTH,
 				   &priv->controller_duty_received);
-	if (ret < 0)
-		goto unlock_and_return;
-
-	priv->updated = jiffies;
-
-unlock_and_return:
-	mutex_unlock(&priv->status_report_request_mutex);
 	if (ret < 0)
 		return ret;
 
+	priv->updated = jiffies;
 	return 0;
 }
 
@@ -303,14 +282,11 @@ static int rog_ryujin_write_fixed_duty(struct rog_ryujin_data *priv, int channel
 		 * Retrieve cooler duty since both pump and internal fan are set
 		 * together, then write back with one of them modified.
 		 */
-		ret = mutex_lock_interruptible(&priv->status_report_request_mutex);
-		if (ret < 0)
-			return ret;
 		ret =
 		    rog_ryujin_execute_cmd(priv, get_cooler_duty_cmd, GET_CMD_LENGTH,
 					   &priv->cooler_duty_received);
 		if (ret < 0)
-			goto unlock_and_return;
+			return ret;
 
 		memcpy(set_cmd, set_cooler_duty_cmd, SET_CMD_LENGTH);
 
@@ -329,11 +305,7 @@ static int rog_ryujin_write_fixed_duty(struct rog_ryujin_data *priv, int channel
 			set_cmd[RYUJIN_SET_COOLER_FAN_DUTY_OFFSET] = val;
 		}
 
-		ret = rog_ryujin_execute_cmd(priv, set_cmd, SET_CMD_LENGTH, &priv->cooler_duty_set);
-unlock_and_return:
-		mutex_unlock(&priv->status_report_request_mutex);
-		if (ret < 0)
-			return ret;
+		return rog_ryujin_execute_cmd(priv, set_cmd, SET_CMD_LENGTH, &priv->cooler_duty_set);
 	} else {
 		/*
 		 * Controller fan duty (channel == 2). No need to retrieve current
@@ -538,8 +510,6 @@ static int rog_ryujin_probe(struct hid_device *hdev, const struct hid_device_id
 		goto fail_and_close;
 	}
 
-	mutex_init(&priv->status_report_request_mutex);
-	mutex_init(&priv->buffer_lock);
 	spin_lock_init(&priv->status_report_request_lock);
 	init_completion(&priv->cooler_status_received);
 	init_completion(&priv->controller_status_received);
-- 
2.53.0

