Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40F4AB3CE
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574911; cv=none; b=dP8sBgGsLKmy8v0JopgJDry7CWJeKd3y3d5cV/viwvakYeH0+A44qbRDHBQBqUrlw+C2Eh1Go/gg+SS0kh/STekdEpqmuND1y+/eVYz3qabL0DYapPII1WLaSPSVch4NPHRh3aV+l3NV9wa1IHowGxkNYVdTC94BQe/OjoaYSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574911; c=relaxed/simple;
	bh=UHo/msMlA7ggpGTu/JO3ZbiMfn0KO+i1/HU7F4c1fpk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JwQD6d1QhioSgPtZZ5AlowJvb7e7Rnb8pGd4hxSE8mlHYY2/4/D1ph5/U5s0p+hDxFWVIfDmMOCFBrQlbgJ0qBu23URv+uUTlrfjLwk5SRfUu3r9fv9OC2t1eR6z83su7MSYvoOJXE/J9tiiSOnImpKOAK0UMlPX6dGMyqo/Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B7GuVGbL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B7GuVGbL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B033E1F00899;
	Wed, 16 Sep 2026 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574907;
	bh=zcP3DTEQyCiVoPrzdjta+JxONIDCR6WTmOxtow/iXqI=;
	h=Subject:To:Cc:From:Date;
	b=B7GuVGbLyWNCeOcEUdxeMrcmE42v9ejBMuU+WPeHe5dWGNL++eYa+PENBluumwYcE
	 FoSQ6tJrFIquHrTX2e4qFjCURrteZ0XbLfQsvgwcjbDwxJ4FBH++VJzqTEJrN9GFRW
	 dh3cE0ObdqsrECOK0ReWrI/FOwiUvXuvK+967Ha4=
Subject: FAILED: patch "[PATCH] hwmon: (asus_rog_ryujin) Synchronize HID command and report" failed to apply to 7.2-stable tree
To: renari@arimil.com,linux@roeck-us.net,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:56:24 +0100
Message-ID: <2026091624-stir-village-a511@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 06d48355bf41028c1321acda6a4391cd70098be8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091624-stir-village-a511@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 06d48355bf41028c1321acda6a4391cd70098be8 Mon Sep 17 00:00:00 2001
From: Arie Miller <renari@arimil.com>
Date: Thu, 3 Sep 2026 22:21:29 -0400
Subject: [PATCH] hwmon: (asus_rog_ryujin) Synchronize HID command and report
 handling

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

diff --git a/drivers/hwmon/asus_rog_ryujin.c b/drivers/hwmon/asus_rog_ryujin.c
index f4d99c510369..e297557ca346 100644
--- a/drivers/hwmon/asus_rog_ryujin.c
+++ b/drivers/hwmon/asus_rog_ryujin.c
@@ -184,6 +184,7 @@ static int rog_ryujin_write_expanded(struct rog_ryujin_data *priv, const u8 *cmd
 static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, int cmd_length,
 				  struct completion *status_completion)
 {
+	unsigned long flags;
 	int ret;
 
 	/*
@@ -191,9 +192,9 @@ static int rog_ryujin_execute_cmd(struct rog_ryujin_data *priv, const u8 *cmd, i
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
@@ -421,15 +422,18 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
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
@@ -443,7 +447,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->cooler_status_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_SPEED_CMD_RESPONSE) {
 		if (size <= RYUJIN_CONTROLLER_SPEED_3 + 1)
-			return 0;
+			goto unlock;
 
 		/* Received speeds of four fans attached to the controller */
 		priv->speed_input[2] = get_unaligned_le16(data + RYUJIN_CONTROLLER_SPEED_1);
@@ -455,7 +459,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->controller_status_received);
 	} else if (data[1] == RYUJIN_GET_COOLER_DUTY_CMD_RESPONSE) {
 		if (size <= RYUJIN_INTERNAL_FAN_DUTY)
-			return 0;
+			goto unlock;
 
 		/* Received report for pump and internal fan duties (in %) */
 		if (data[RYUJIN_PUMP_DUTY] == 0 && data[RYUJIN_INTERNAL_FAN_DUTY] == 0) {
@@ -474,7 +478,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 				 * We're expecting a report, so parse it.
 				 */
 				goto read_cooler_duty;
-			return 0;
+			goto unlock;
 		}
 read_cooler_duty:
 		priv->duty_input[0] = rog_ryujin_percent_to_pwm(data[RYUJIN_PUMP_DUTY]);
@@ -484,7 +488,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->cooler_duty_received);
 	} else if (data[1] == RYUJIN_GET_CONTROLLER_DUTY_CMD_RESPONSE) {
 		if (size <= RYUJIN_CONTROLLER_DUTY)
-			return 0;
+			goto unlock;
 
 		/* Received report for controller duty for fans (in PWM) */
 		if (data[RYUJIN_CONTROLLER_DUTY] == 0) {
@@ -503,7 +507,7 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 				 * We're expecting a report, so parse it.
 				 */
 				goto read_controller_duty;
-			return 0;
+			goto unlock;
 		}
 read_controller_duty:
 		priv->duty_input[2] = data[RYUJIN_CONTROLLER_DUTY];
@@ -512,6 +516,8 @@ static int rog_ryujin_raw_event(struct hid_device *hdev, struct hid_report *repo
 			complete_all(&priv->controller_duty_received);
 	}
 
+unlock:
+	spin_unlock_irqrestore(&priv->status_report_request_lock, flags);
 	return 0;
 }
 

