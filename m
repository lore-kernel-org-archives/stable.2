Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3F125A0
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788827967; cv=none; b=uk0kE/Oi2fCRK8So/Hl4GKe4khTPoKk+h2bK8Z3AB+rqayjihDyeGID1/jMP/MlsQU5gOHxo+o9Fc+tejedFEKW2RCh2zdirpFIFpRqfbkUEX70ww1FnZhiRYI15R4wBoHXEUZa8j+xqN2NxwX5JYAT0BoSLYK3m0ENTdkVvcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788827967; c=relaxed/simple;
	bh=m7eoMjbJ2aDxhc/yzMJlXPKvp3Gq3UQrnwSqxM2VmKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vz5SYmeVmXQzN/a5LIgkJaafSxfaAK6Q9WFQ0tLy5BdPV+RVa3ht5Q0fO1uAJM/mpNwV12iuKdLWD3oFFTrxEORxLl8oiA+iD4tXO8NVHHt0wfbxNLjdF47kSesmWhuVuixYR2edfEMNqBHioeqV9s8QV3O+pLWdwc6ZlsZ7LsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXUmnx5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXUmnx5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C11F00A3F;
	Tue,  8 Sep 2026 00:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788827966;
	bh=SIdZQdaACGGbTGHEgIMbxEylHCyrdvS6N7Mbdoy/8Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NXUmnx5lVpWCkYQrcpTjr/Oy9+I9f9v2LdNARHrqZvI1vH58yR8tV0Ec4lYK9EaWX
	 lTVEv/+VwallWEr5tqEifVSd6/GqRfn7tMTDtVV1jIFOvrf75YWmAA5zI3Ncb12l1Y
	 Q83LNyJpEPD11JqQL+GzqIuUc1zgG/HC+DQZyb5xhojsLkfUHb0F9XBUvatiqBjk6o
	 olCVtRU35/qPc5DCj6Q6BfmJvAoupDKYsc2j5qBM1ByBcuLnfE6YLP2kaICeJlWzvY
	 1oSKHfJotP0nm6F1Sj8TlcL7sFwVcfP0AxHfzE5Uiryp7mxHvWuPsQqqUcVGicTjbL
	 nRByJ97i8tokg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] HID: sony: use guard() and scoped_guard()
Date: Mon,  7 Sep 2026 20:39:20 -0400
Message-ID: <20260908003921.1609143-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908003921.1609143-1-sashal@kernel.org>
References: <2026090345-sizably-halves-2b7f@gregkh>
 <20260908003921.1609143-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rosalie Wanders <rosalie@mailbox.org>

[ Upstream commit da4f817ad273bca9aefd8636d347a8c101069111 ]

This replaces the spin_lock_irqsave() and spin_unlock_irqrestore() calls
with the RAII guard() and scoped_guard().

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: 7c65699a3a31 ("HID: sony: clean up device list on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 50 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 182dcd7705862..251ca31d25571 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -497,14 +497,12 @@ static void sony_set_leds(struct sony_sc *sc);
 static inline void sony_schedule_work(struct sony_sc *sc,
 				      enum sony_worker which)
 {
-	unsigned long flags;
-
 	switch (which) {
 	case SONY_WORKER_STATE:
-		spin_lock_irqsave(&sc->lock, flags);
-		if (!sc->defer_initialization && sc->state_worker_initialized)
-			schedule_work(&sc->state_worker);
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			if (!sc->defer_initialization && sc->state_worker_initialized)
+				schedule_work(&sc->state_worker);
+		}
 		break;
 	}
 }
@@ -706,7 +704,6 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 {
 	static const u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
-	unsigned long flags;
 	int offset;
 	u8 cable_state, battery_capacity, battery_charging;
 
@@ -729,11 +726,13 @@ static void sixaxis_parse_report(struct sony_sc *sc, u8 *rd, int size)
 		cable_state = 0;
 	}
 
-	spin_lock_irqsave(&sc->lock, flags);
-	sc->cable_state = cable_state;
-	sc->battery_capacity = battery_capacity;
-	sc->battery_charging = battery_charging;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	{
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			sc->cable_state = cable_state;
+			sc->battery_capacity = battery_capacity;
+			sc->battery_charging = battery_charging;
+		}
+	}
 
 	if (sc->quirks & SIXAXIS_CONTROLLER) {
 		int val;
@@ -1532,15 +1531,14 @@ static int sony_battery_get_property(struct power_supply *psy,
 				     union power_supply_propval *val)
 {
 	struct sony_sc *sc = power_supply_get_drvdata(psy);
-	unsigned long flags;
 	int ret = 0;
 	u8 battery_charging, battery_capacity, cable_state;
 
-	spin_lock_irqsave(&sc->lock, flags);
-	battery_charging = sc->battery_charging;
-	battery_capacity = sc->battery_capacity;
-	cable_state = sc->cable_state;
-	spin_unlock_irqrestore(&sc->lock, flags);
+	scoped_guard(spinlock_irqsave, &sc->lock) {
+		battery_charging = sc->battery_charging;
+		battery_capacity = sc->battery_capacity;
+		cable_state = sc->cable_state;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -1628,10 +1626,9 @@ static inline int sony_compare_connection_type(struct sony_sc *sc0,
 static int sony_check_add_dev_list(struct sony_sc *sc)
 {
 	struct sony_sc *entry;
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&sony_dev_list_lock, flags);
+	guard(spinlock_irqsave)(&sony_dev_list_lock);
 
 	list_for_each_entry(entry, &sony_device_list, list_node) {
 		ret = memcmp(sc->mac_address, entry->mac_address,
@@ -1645,15 +1642,14 @@ static int sony_check_add_dev_list(struct sony_sc *sc)
 				"controller with MAC address %pMR already connected\n",
 				sc->mac_address);
 			}
-			goto unlock;
+			goto out;
 		}
 	}
 
 	ret = 0;
 	list_add(&(sc->list_node), &sony_device_list);
 
-unlock:
-	spin_unlock_irqrestore(&sony_dev_list_lock, flags);
+out:
 	return ret;
 }
 
@@ -1791,12 +1787,10 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
-	unsigned long flags;
-
 	if (sc->state_worker_initialized) {
-		spin_lock_irqsave(&sc->lock, flags);
-		sc->state_worker_initialized = 0;
-		spin_unlock_irqrestore(&sc->lock, flags);
+		scoped_guard(spinlock_irqsave, &sc->lock) {
+			sc->state_worker_initialized = 0;
+		}
 		cancel_work_sync(&sc->state_worker);
 	}
 }
-- 
2.53.0

