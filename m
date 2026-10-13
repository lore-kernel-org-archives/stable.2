Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DD49B5DE;
	Tue, 13 Oct 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882783; cv=none; b=mTynzSuBhXhE3+n0rNBmGbQPbLyyTt8NL2wDKtigFUui1FKbVJoQ20xRmcNZMFjWdVLY1W7Vi6WeSUOv885WMs0XX0yQQySurBPOQwSYqA0dRIw844TeAbVE4ZnGEsPySMNUkSH7ZPwQLhZ20Cw4YmrOzA9is9+kLJ9+5nWYL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882783; c=relaxed/simple;
	bh=z6q0v/OIIm/FDJSjI8IZcJWCk9bfTlqkTyJbXPmjdL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vnul7B8whPeI3oOA3zJ8OAkljW+FaJmanHwyIsn8mkkLFenuwJ86RhjoMtki3fOwzIiqMPcaxy/jLX0wnv6XKz0nbqo7eVNjqi4mdqJtxXI+Jt711U3gMrjK0PXz5gq1U49lwVxeEhl4OiLikIYm5PVNg7573+ZHBI9ysQ305qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7n3liwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7n3liwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF76D1F00899;
	Tue, 13 Oct 2026 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882780;
	bh=TfvmEslww1H80E7freFkkZiQjXEIa5eJx0R0ZZIgCsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7n3liwp5/8TIKEdRtU3NndCaneyEWeRXDAC9zJ4jmAkAu0rWzBHx6TQkhVxALXA7
	 LK+QQZvmZlzEkkUUwBWANo1JlpU8UNFYMvw7DsoiSGL3WmZpAS3C/StBiSbXkZKf2M
	 8FcvY3Khpn28HlWIdCSOomw/sApLBUclpleFAnzJrmL1fxawJA2py9fhW9Z/r+mEzU
	 sb9kkjiMsRgyMirr7jmDDkcovvolsADfQlSGvFmTUYB3ZPtq+DQ68QMXFvRSedHdsy
	 2G4q4JiWyXjED+pUCQh8B4KMWbnHS+AT/gY7WXkS1KOnjMhbdd8A4RlX5tdInUWqKM
	 Sni3LingCJNYw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Vicki Pfau <vi@endrift.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v5.15-v5.10 5/6] HID: steam: Refactor registration
Date: Tue, 13 Oct 2026 09:12:12 +0000
Message-ID: <20261013091215.529531-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091215.529531-1-lee@kernel.org>
References: <20261013091215.529531-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vicki Pfau <vi@endrift.com>

[ Upstream commit 6f9b740c31ba7e061b2ebb330d9a3d63f1358f29 ]

This refactors and simplifies the registration/unregistration flow. Since
we now only perform registration when the client isn't opened anymore, the
logic for handling that can be removed, and the rest of the function
streamlined.

We also remove the previous assumption that we have a serial number to show
we're registered, replacing it with a single purpose boolean.

In a previous refactor the code for unregistering a battery if later
registration steps failed was accidentally left out. As a result, a
lingering power_supply object could get left over after the steam object
was torn down. This is also fixed here.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
[Lee: Omit sensors, steam_get_attributes(), rumble_work,
      coalesce_rumble_work and mode_switch changes as e133dc99fc07,
      a0fbd9437d7d and 1d4549fd1115 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 70 ++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 628e4ef72b81..544d45f3fc6b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -119,6 +119,7 @@ struct steam_device {
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	bool registered;
 	char serial_no[STEAM_SERIAL_LEN + 1];
 	struct power_supply_desc battery_desc;
 	struct power_supply __rcu *battery;
@@ -511,9 +512,6 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	unsigned long client_opened;
-	unsigned long flags;
-	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -521,59 +519,53 @@ static int steam_register(struct steam_device *steam)
 	 * another client send a get_connection_status command, for example.
 	 * The battery and serial number are set just once per device.
 	 */
-	if (!steam->serial_no[0]) {
-		/*
-		 * Unlikely, but getting the serial could fail, and it is not so
-		 * important, so make up a serial number and go on.
-		 */
-		mutex_lock(&steam->mutex);
-		if (steam_get_serial(steam) < 0)
-			strlcpy(steam->serial_no, "XXXXXXXXXX",
-					sizeof(steam->serial_no));
-		mutex_unlock(&steam->mutex);
+	if (steam->registered)
+		return 0;
 
-		hid_info(steam->hdev, "Steam Controller '%s' connected",
-				steam->serial_no);
+	/*
+	 * Unlikely, but getting the serial could fail, and it is not so
+	 * important, so make up a serial number and go on.
+	 */
+	mutex_lock(&steam->mutex);
+	if (steam_get_serial(steam) < 0 || !steam->serial_no[0])
+		strlcpy(steam->serial_no, "XXXXXXXXXX",
+				sizeof(steam->serial_no));
+	mutex_unlock(&steam->mutex);
 
-		/* ignore battery errors, we can live without it */
-		if (steam->quirks & STEAM_QUIRK_WIRELESS)
-			steam_battery_register(steam);
+	hid_info(steam->hdev, "Steam Controller '%s' connected",
+			steam->serial_no);
 
-		do_add = true;
-	}
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
 
-	spin_lock_irqsave(&steam->lock, flags);
-	client_opened = steam->client_opened;
-	spin_unlock_irqrestore(&steam->lock, flags);
+	mutex_lock(&steam->mutex);
+	steam_set_lizard_mode(steam, lizard_mode);
+	mutex_unlock(&steam->mutex);
+	ret = steam_input_register(steam);
+	if (ret != 0)
+		goto steam_register_input_fail;
 
-	if (!client_opened) {
-		mutex_lock(&steam->mutex);
-		steam_set_lizard_mode(steam, lizard_mode);
-		mutex_unlock(&steam->mutex);
-		ret = steam_input_register(steam);
-		if (ret != 0)
-			goto steam_register_input_fail;
-	}
-
-	if (do_add) {
-		mutex_lock(&steam_devices_lock);
-		if (list_empty(&steam->list))
-			list_add(&steam->list, &steam_devices);
-		mutex_unlock(&steam_devices_lock);
-	}
+	steam->registered = true;
+	mutex_lock(&steam_devices_lock);
+	if (list_empty(&steam->list))
+		list_add(&steam->list, &steam_devices);
+	mutex_unlock(&steam_devices_lock);
 	return 0;
 
 steam_register_input_fail:
+	steam_battery_unregister(steam);
 	return ret;
 }
 
 static void steam_unregister(struct steam_device *steam)
 {
-	if (!steam->serial_no[0])
+	if (!steam->registered)
 		return;
 
 	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
 			steam->serial_no);
+	steam->registered = false;
 	steam_battery_unregister(steam);
 	steam_input_unregister(steam);
 	mutex_lock(&steam_devices_lock);
-- 
2.56.0.385.gd3acb90ef8-goog

