Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331C3E1205;
	Tue, 13 Oct 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882771; cv=none; b=GajuMDFpmLmC6h2wbYAOuvs4B7QKhkfOhE/F6QmB5GdQYnIYPPDb/rS1cvgd1P4pxln4zlispOmoSQ4C89KKYaKcGEblFBCWfTQva442ZQG737ChPBkdI/zg/kf0hXzDCvhI1WuicJXHRfIWh7bOYHA7MSqWuKecFni9/UxXFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882771; c=relaxed/simple;
	bh=GoghcLBlmWcq6TvRGJ/XV3c6/1X3aULBP2Vxhzb7/hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrVOkxvVMe6LKiJgmWcrpDA/ruwBJ5F6RShkI4reO0QkMuYGERRYtg9aR5Al6k57yW7f2zYy2Nmg6aATqGS+/628U8+E9EC4TrUPrMLndhrqtAyg49MtCOg2AbQdXd0Ff8oSQ/Ou4gUCzlxolal04Sqn5xhf1ZajMx5YRrJRZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmhfov4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmhfov4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564D71F008A2;
	Tue, 13 Oct 2026 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882769;
	bh=Lg5+j8OiRmfxmPptR4YedHHSn2uGBBh/nuJ5DoX74Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tmhfov4LEexIXfvuHepH+LT+yyf0pzbsy7UKmRZ3ocCm67kqZTuYy7BTb87ExUvQ2
	 wKtnNgVNRkSzxAmQTER3jat/EXvA4/RQ7CQRTW6XPUzhWN+e57i6kLjTdJ8WABHuJJ
	 sjwZ2+nE06SJZi6fMOZzIQY2COQxJH1c8gvzQjCre7pCAoCANKxJGvqjzhWv322p1Q
	 hEpZpt1uq58mp4FLMGgs4dZUgDerZyOdEnM7MtSUF9QFwsAmBg2un6mHRvlKdhnA0y
	 sFticPduUiNoxxE7mOc2x+ifeAFt1K6J2b/FQcIFpixsDxypRG64spSfzo4mVjBYW1
	 dUoNcTyMgAGJw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.18 3/4] HID: steam: Refactor registration
Date: Tue, 13 Oct 2026 09:11:34 +0000
Message-ID: <20261013091138.526840-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091138.526840-1-lee@kernel.org>
References: <20261013091138.526840-1-lee@kernel.org>
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
[Lee: Omit coalesce_rumble_work cancellation as 1d4549fd1115 ("HID:
      steam: Coalesce rumble packets") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 80 +++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index b0af056484e2..e2b7df274eb3 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -333,6 +333,7 @@ struct steam_device {
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	bool registered;
 	char serial_no[STEAM_SERIAL_LEN + 1];
 	struct power_supply_desc battery_desc;
 	struct power_supply __rcu *battery;
@@ -1088,9 +1089,6 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	unsigned long client_opened;
-	unsigned long flags;
-	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -1098,66 +1096,62 @@ static int steam_register(struct steam_device *steam)
 	 * another client send a get_connection_status command, for example.
 	 * The battery and serial number are set just once per device.
 	 */
-	if (!steam->serial_no[0]) {
-		/*
-		 * Unlikely, but getting the serial could fail, and it is not so
-		 * important, so make up a serial number and go on.
-		 */
-		if (steam_get_serial(steam) < 0)
-			strscpy(steam->serial_no, "XXXXXXXXXX",
-					sizeof(steam->serial_no));
+	if (steam->registered)
+		return 0;
 
-		ret = steam_get_attributes(steam);
-		if (ret < 0)
-			hid_err(steam->hdev,
-				"%s:steam_get_attributes failed with error %d\n",
-				__func__, ret);
+	/*
+	 * Unlikely, but getting the serial could fail, and it is not so
+	 * important, so make up a serial number and go on.
+	 */
+	if (steam_get_serial(steam) < 0 || !steam->serial_no[0])
+		strscpy(steam->serial_no, "XXXXXXXXXX",
+				sizeof(steam->serial_no));
 
-		hid_info(steam->hdev, "Steam Controller '%s' connected",
-				steam->serial_no);
+	ret = steam_get_attributes(steam);
+	if (ret < 0)
+		hid_err(steam->hdev,
+			"%s:steam_get_attributes failed with error %d\n",
+			__func__, ret);
 
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
+	steam_set_lizard_mode(steam, lizard_mode);
+	ret = steam_input_register(steam);
+	if (ret != 0)
+		goto steam_register_input_fail;
+	ret = steam_sensors_register(steam);
+	if (ret != 0)
+		goto steam_register_sensors_fail;
 
-	if (!client_opened) {
-		steam_set_lizard_mode(steam, lizard_mode);
-		ret = steam_input_register(steam);
-		if (ret != 0)
-			goto steam_register_input_fail;
-		ret = steam_sensors_register(steam);
-		if (ret != 0)
-			goto steam_register_sensors_fail;
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
 
 steam_register_sensors_fail:
 	steam_input_unregister(steam);
 steam_register_input_fail:
+	steam_battery_unregister(steam);
+	cancel_work_sync(&steam->rumble_work);
+	cancel_delayed_work_sync(&steam->mode_switch);
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
 	steam_sensors_unregister(steam);
 	steam_input_unregister(steam);
-- 
2.56.0.385.gd3acb90ef8-goog

