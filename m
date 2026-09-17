Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0937A834
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609683; cv=none; b=kLt85mRznPlCVtCyIPaOYg+u9LdB6tSqI+O8u2v9LFdnYO44fqhFhwZF1vTHJ4ayEr57gnrARnSZCBQj/TqRln6DhwA/5hyVNDTU7BiFC/HXt3T4NaYVVe0whKd7W66nar4TjcoZYk5VKcZSKx2oVjUwHbeNFe0mPZ3MG7zvqDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609683; c=relaxed/simple;
	bh=euL9U3hK630ffblXycOvDxnht029gf0DErthokS8e34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jkw+UChpQTWe/qwo74MCB9DPhyMu8jAl3WOG+hNPMel0Cf8Wkk7OdutxegTop5/r1KT5/R4Q809rYG4NHZOfW62jcAUYhRI8k8fKuXfRwKCZ4/wUE97OtdIB0qTRHvXf7R2Vh3jDPhhgeXg/2HLChGpQuDoDeALC6iex7e/n8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHVBMq03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHVBMq03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DEE1F000FF;
	Thu, 17 Sep 2026 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609681;
	bh=R8KEpWaGsEnRPN57OUcDwjVxFdxfSfvWrAfrty1SIds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHVBMq03px1ljUcCzZsyi4ne3WWyw8v56vwRa+kq2kqGrxlTqx6H+Ic6Rn5lawyNJ
	 R5oyZfReELxJ0xbWw2y1PCkMsMzhIDFJJVgk9M60gRzdLhtKfH0P+pS8vdFl5W7Dkh
	 IFBskyEPCuwyK2e0CjmAeCxtFBCBdEFVGAaX2wqUZuP6qkEQgkDOWKVX4QOeVtJ/BK
	 1Zm639iqNpaAkOKWJcAyzYR8aTUAGxERVhc8vUAhMBfvJ3PQFdamWDkHZ5Zecj1iUd
	 Di4E9ajNpmXXPioYEMjdjRyMatAlWzsPCa0dnsvt+T3oWn9bviwY5m81jelcDcJseP
	 g2SM4hlsleYtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] hwmon: (asus_rog_ryujin) Rely on subsystem locking
Date: Wed, 16 Sep 2026 21:47:56 -0400
Message-ID: <20260917014759.3688961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091625-precut-stinger-57d0@gregkh>
References: <2026091625-precut-stinger-57d0@gregkh>
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

