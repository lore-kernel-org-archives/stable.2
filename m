Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B633FC5A5;
	Tue, 13 Oct 2026 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882775; cv=none; b=ZFPcM39BM7xjEaEGTbpWwL95eJvcI7MZw+A9gxEE3aN7Me1OL+U3KE5fZ2Y6AJrzdfeToUcjA+1eACuFPSfEQCFTVDzkPbhtRk0R9+w1LWUkSDDDiq7gHpj+pdg4kquotjd2kVDfJNllFXUECkREboptTKMATKPzCBYgBKfHnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882775; c=relaxed/simple;
	bh=pEELcu5WPEBiJaqUFbSqJV5tJr6zg67btXKw58Sd4Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNeqzEpA2A9cjquCPABDh9ethYOu/z7oy/DXGCmzfPnJLdPhe4/rHp11JZRGH0bSzmH+NLToYEL7U0Lzy5Y8jTl87F4YaRCty7lh2RCjCTyXvUSqITfAbicRG1WOeMHHS90l/ZHX+/ShmVoO+Qr/SDOuK5Sz8HZ0UH06Gnu2fLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqQjle9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqQjle9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656611F00893;
	Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882773;
	bh=H27h6M59OKEdOT07ALRw2IzX+RY9xM2mzc23QbNAlxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqQjle9ZlS4fsqJ8YeoQkYqC/H/hOlpJmQOmOhj/U7WJA5lbrywrcZ80uzeugpmtq
	 gyAv6QkxGXmplYK7QM8qoXO1Qda/R9aHwNEXKEv2l/zB8wub8zGmjO/h51jx9M0K9y
	 PXL9csRaKgUziovogziMU1gAg1rJe0BNQR+CqHwMxd8LEItChOUz5b/Qlo9pOxcud+
	 DMu0xyhIMQgd+20rKpfutsFfB6+Vr6Kl0Z5ovzmvOAu+2epy2oMHwqWRpHNau9J5n8
	 1aAAx8sQEVGKpi001dwBDGVQOUT8QCfF+JGvXH28KwY7AIF8CLUOxEazityPD8cmvb
	 y9gJ2S6/STpgw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [STABLE v6.6 4/5] HID: steam: Refactor registration
Date: Tue, 13 Oct 2026 09:11:53 +0000
Message-ID: <20261013091156.528734-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013091156.528734-1-lee@kernel.org>
References: <20261013091156.528734-1-lee@kernel.org>
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
[Lee: Omit steam_get_attributes() and coalesce_rumble_work cancellation
      as a0fbd9437d7d and 1d4549fd1115 are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-steam.c | 70 +++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index df176a722061..06c2fcd134ce 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -300,6 +300,7 @@ struct steam_device {
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	bool registered;
 	char serial_no[STEAM_SERIAL_LEN + 1];
 	struct power_supply_desc battery_desc;
 	struct power_supply __rcu *battery;
@@ -953,9 +954,6 @@ static void steam_battery_unregister(struct steam_device *steam)
 static int steam_register(struct steam_device *steam)
 {
 	int ret;
-	unsigned long client_opened;
-	unsigned long flags;
-	bool do_add;
 
 	/*
 	 * This function can be called several times in a row with the
@@ -963,60 +961,56 @@ static int steam_register(struct steam_device *steam)
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
 
-		hid_info(steam->hdev, "Steam Controller '%s' connected",
-				steam->serial_no);
+	/*
+	 * Unlikely, but getting the serial could fail, and it is not so
+	 * important, so make up a serial number and go on.
+	 */
+	if (steam_get_serial(steam) < 0 || !steam->serial_no[0])
+		strscpy(steam->serial_no, "XXXXXXXXXX",
+				sizeof(steam->serial_no));
 
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

