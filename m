Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D74C6529
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574907; cv=none; b=g8QxfjJLeQsvHSQfE3NxAg7yA8I50ntanusPUDC+RXY1sIw3bqHPLLf+MMFXWWeE1fBSDK7icSVHJPCja0eZ1B9S9X38vjn6Sz32JAJ05bBtqzuy/mjJh15Xt1MZt61d6b2wuxUQo5jIB19ezxWyso0eD/Pv64PKMMhCpspzSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574907; c=relaxed/simple;
	bh=3qZ+nM0TC/I4e1FpZYxVp/zomYXKjGOJPYvbDQL4pds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sWKtiJfNW+O8bLun9F+icet/HDfi++DRlRlTwMYfdAKfszgLlTYdrqSA68kJLHR1uo+AUtQ3CVXjRw1owMtuK7JShMxL53Ri5/R60KNi/eLk+iVGOyiDei4FZVWXJafHak2F3hCT9R7UTwxNP5LbwGx/dDwoY1pPCc1ahMdY714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCtwYc6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCtwYc6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B581F00893;
	Wed, 16 Sep 2026 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574901;
	bh=gJ8B/o/XXPrzYfn2DvZT0UPrFFlqdwMkU1PMMxHe0L8=;
	h=Subject:To:Cc:From:Date;
	b=OCtwYc6aAiB9JmxQ4zsv1pCo8M+/+1gaicN4qPL8QPbx6da8UjXWKFk7stdX3NIVj
	 1+Ae54mq3IhQKEA95pGO2V8VLgc3UKrl8gFuKn4K9xOCrmXokG/dVYLwXk7EUtEYTC
	 KJqVY6vFzbo2YUO8VUj1vdmcfMd//OuOfPZsUcB0=
Subject: FAILED: patch "[PATCH] hwmon: (asus_rog_ryujin) Validate HID report lengths" failed to apply to 6.18-stable tree
To: renari@arimil.com,linux@roeck-us.net,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:56:03 +0100
Message-ID: <2026091603-malformed-wildland-0f94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8042312e73c50de82634ce63eae7cf219464b481
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091603-malformed-wildland-0f94@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8042312e73c50de82634ce63eae7cf219464b481 Mon Sep 17 00:00:00 2001
From: Arie Miller <renari@arimil.com>
Date: Thu, 3 Sep 2026 22:21:28 -0400
Subject: [PATCH] hwmon: (asus_rog_ryujin) Validate HID report lengths

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

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index 702edb831394..f4d99c510369 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -422,10 +422,15 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
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
@@ -437,6 +442,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->cooler_status_received))
 			complete_all(&priv->cooler_status_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_SPEED_CMD_RESPONSE) {
+		if (size <= RYUJIN_CONTROLLER_SPEED_3 + 1)
+			return 0;
+
 		/* Received speeds of four fans attached to the controller */
 		priv->speed_input[2] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_1);
 		priv->speed_input[3] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_2);
@@ -446,6 +454,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->controller_status_received))
 			complete_all(&priv->controller_status_received);
 	} else if (data[1] == RYUJIN_GET_COOLER_DUTY_CMD_RESPONSE) {
+		if (size <= RYUJIN_INTERNAL_FAN_DUTY)
+			return 0;
+
 		/* Received report for pump and internal fan duties (in %) */
 		if (data[RYUJIN_PUMP_DUTY] == 0 && data[RYUJIN_INTERNAL_FAN_DUTY] == 0) {
 			/*
@@ -472,6 +483,9 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 		if (!completion_done(&priv->cooler_duty_received))
 			complete_all(&priv->cooler_duty_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_DUTY_CMD_RESPONSE) {
+		if (size <= RYUJIN_CONTROLLER_DUTY)
+			return 0;
+
 		/* Received report for controller duty for fans (in PWM) */
 		if (data[RYUJIN_CONTROLLER_DUTY] == 0) {
 			/*

