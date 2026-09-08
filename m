Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE921DDFE
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788831508; cv=none; b=HXgV3JRN49gSa3tSE7sbptpvvsbQzF5N3VgxMIEilsozOflkLIToSNk4EjVWJTYnwdkokOOCp4JdWkPpJLIewaHfw4Zwq/z1I3giUO7Rqm24S73NBwqpem4u7lDbMqLTm9JlxpyS1AI46r1Re8Yp86WohxzLrt170CKHD8hWfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788831508; c=relaxed/simple;
	bh=nmo2iWkqfQYTUsdp57Fup2dfU4Kr2VKjoaTsSQHZ6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikKMtFcoeWa1t84NyWa8faQljBocRbuQmM/BVHJe7w24xJqS+BxuEiTmYNcTgEhueD2ddZr8IJDssmEw16yUsvSt1AyT/ptJMYV5m3AsTPkUJNbeDlID+GwLnqUUs0QY5mzDb6GLcbz8xyh7cuaTN/j59j2v9azUDdpmbG9ZDrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrL0p2Ho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrL0p2Ho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E21F00A3D;
	Tue,  8 Sep 2026 01:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788831506;
	bh=J2fPfUHKFJ7OTAi4o6uKA5/JAqTw6cPq+ZLcwHN+GdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrL0p2HoRSKRtYLd/jKe6lvvkNdz4VFkQa3/FAJZ3L4oInpzAOxb+7C7WjV0I3hvi
	 TCBurH8tOFFmcrAqw3sglih15rhh5FDU6CZsOunlh01FQUxOnU9qox4bACduGn8O/L
	 bbEHeangZzYhZE+H7G8MKYPJqGhKf+sFEr75P/aKUn1VZ3iuKMGyyck7uvNXXDXizs
	 CsippD0O/D1B8+E4KjuC0aqJgsiSktAxaQljwWbmj8AP4EulGnefqJlc9OAss3FXHA
	 VhjGQ1FIAmeHEd5MuMFlHwyv87Rr28YsWdwzS/xjZ7sBNZr7QGvQ95WEhDrjUnUBGT
	 uE542FOLqpg2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rong Zhang <i@rong.moe>,
	Rick <rickk1166@gmail.com>,
	Avraham Hollander <anhollander516@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] ACPI: battery: Protect all properties with a separated mutex
Date: Mon,  7 Sep 2026 21:38:23 -0400
Message-ID: <20260908013823.1787474-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908013823.1787474-1-sashal@kernel.org>
References: <2026090357-tweet-veal-37b7@gregkh>
 <20260908013823.1787474-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Zhang <i@rong.moe>

[ Upstream commit 9e409f1dff7841634e4b101111d6427f979c0aac ]

The acpi_battery_get_property() callback calls acpi_battery_get_state()
without any lock held. On some devices, it happens that the property
cache has expired before a uevent reaches userspace, triggering
simultaneous attempts to evaluate _BST. See [1] for an analysis to sysrq
stacktraces on one of the these devices.

In a few cases, including when the AML is sleeping or acquiring a mutex,
ACPICA drops the namespace and interpreter locks and allows the
evaluation of _BST to start while another task is still evaluating it.
This could somehow confuse the interpreter and lead to chaos in AML
mutexes on some devices, see [2] for an example.

Not holding the lock is also prone to race conditions, for example:

                CPU0                | 	         CPU1
acpi_battery_get_property()         |
  acpi_battery_get_state()          |
    [update_time expired]           |
    extract_package()               | acpi_battery_get_property()
    battery->update_time = jiffies  |   acpi_battery_get_state()
    kfree()                         |     [up to date]
                                    |   [read capacity_now]
    [fix capacity_now due to quirk] |

where CPU1 gets raw capacity_now before CPU0 fixes it to a meaningful
value.

The existing mutex update_lock is not applicapable for
acpi_battery_get_property(), as some code path could call or wait for
acpi_battery_get_property() while holding update_lock.

Therefore, introduce a mutex called property_lock to protect all
accesses to battery properties, so that acpi_battery_get_property() can
take the advantage of the mutex and synchronize itself. With the mutex,
acpi_battery_get_state() are synchronized in all code paths calling it,
and its cache mechanism can always clamp the frequency of _BST
evaluations according to cache_time.

The helper function acpi_battery_handle_discharging() for quirky devices
has to be inlined due to the change, as the mutex must be unlocked
before calling the expensive power_supply_is_system_supplied() helper
function.

Fixes: 86bfd21a0baf ("ACPI: battery: Drop redundant locking")
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065#c85 [1]
Reported-by: Avraham Hollander <anhollander516@gmail.com>
Tested-by: Avraham Hollander <anhollander516@gmail.com>
Closes: https://lore.kernel.org/linux-acpi/CAP1mzZReJCn6df5DwEPu-JCQUyr=Pu1cg5xKCMttWZkHCQtVmQ@mail.gmail.com [2]
Signed-off-by: Rong Zhang <i@rong.moe>
Cc: All applicable <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260809-b4-acpi-battery-notification-v5-1-788d54fa2e35@rong.moe
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/battery.c | 147 ++++++++++++++++++++++++++++-------------
 1 file changed, 101 insertions(+), 46 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 605c47efdf06b..f8fa0d9a1f4c7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -97,6 +98,9 @@ struct acpi_battery {
 	struct device *phys_dev;
 	struct notifier_block pm_nb;
 	struct list_head list;
+	unsigned long flags;
+
+	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
 	int revision;
 	int rate_now;
@@ -123,7 +127,6 @@ struct acpi_battery {
 	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
-	unsigned long flags;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -180,20 +183,6 @@ static bool acpi_battery_is_degraded(struct acpi_battery *battery)
 		battery->full_charge_capacity < battery->design_capacity;
 }
 
-static int acpi_battery_handle_discharging(struct acpi_battery *battery)
-{
-	/*
-	 * Some devices wrongly report discharging if the battery's charge level
-	 * was above the device's start charging threshold atm the AC adapter
-	 * was plugged in and the device thus did not start a new charge cycle.
-	 */
-	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
-	    battery->rate_now == 0)
-		return POWER_SUPPLY_STATUS_NOT_CHARGING;
-
-	return POWER_SUPPLY_STATUS_DISCHARGING;
-}
-
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -201,15 +190,41 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	int full_capacity = ACPI_BATTERY_VALUE_UNKNOWN, ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
-	if (acpi_battery_present(battery)) {
-		/* run battery update only if it is present */
-		acpi_battery_get_state(battery);
-	} else if (psp != POWER_SUPPLY_PROP_PRESENT)
-		return -ENODEV;
+	/* run battery update only if it is present */
+	if (!acpi_battery_present(battery)) {
+		switch (psp) {
+		case POWER_SUPPLY_PROP_PRESENT:
+			val->intval = 0;
+			return 0;
+		default:
+			return -ENODEV;
+		}
+	}
+
+	mutex_lock(&battery->property_lock);
+
+	acpi_battery_get_state(battery);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
+		/*
+		 * Some devices wrongly report discharging if the battery's charge level
+		 * was above the device's start charging threshold atm the AC adapter
+		 * was plugged in and the device thus did not start a new charge cycle.
+		 */
 		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
-			val->intval = acpi_battery_handle_discharging(battery);
+			if (battery->rate_now != 0) {
+				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			} else if (battery_ac_is_broken) {
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			} else {
+				mutex_unlock(&battery->property_lock);
+
+				val->intval = power_supply_is_system_supplied()
+					? POWER_SUPPLY_STATUS_NOT_CHARGING
+					: POWER_SUPPLY_STATUS_DISCHARGING;
+				return 0;
+			}
 		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			/* Validate the status by checking the current. */
 			if (battery->rate_now != ACPI_BATTERY_VALUE_UNKNOWN &&
@@ -311,6 +326,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	default:
 		ret = -EINVAL;
 	}
+
+	mutex_unlock(&battery->property_lock);
 	return ret;
 }
 
@@ -533,6 +550,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int use_bix;
 	int result = -ENODEV;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -572,6 +591,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -625,6 +646,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery) ||
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
@@ -642,6 +665,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	/* See if alarms are supported, and if so, set default */
 	if (!acpi_has_method(battery->device->handle, "_BTP")) {
 		clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
@@ -659,6 +684,8 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
 
+	guard(mutex)(&battery->property_lock);
+
 	return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
 }
 
@@ -674,6 +701,8 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&battery->property_lock);
+
 	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
@@ -858,12 +887,17 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		.no_wakeup_source = true,
 	};
 	bool full_cap_broken = false;
+	int power_unit;
 
-	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
-	    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
-		full_cap_broken = true;
+	scoped_guard(mutex, &battery->property_lock) {
+		power_unit = battery->power_unit;
 
-	if (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
+		if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
+		    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
+			full_cap_broken = true;
+	}
+
+	if (power_unit == ACPI_BATTERY_POWER_UNIT_MA) {
 		if (full_cap_broken) {
 			battery->bat_desc.properties =
 			    charge_battery_full_cap_broken_props;
@@ -917,6 +951,9 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 static void find_battery(const struct dmi_header *dm, void *private)
 {
 	struct acpi_battery *battery = (struct acpi_battery *)private;
+
+	lockdep_assert_held(&battery->property_lock);
+
 	/* Note: the hardcoded offsets below have been extracted from
 	 * the source code of dmidecode.
 	 */
@@ -948,6 +985,8 @@ static void find_battery(const struct dmi_header *dm, void *private)
  */
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return;
 
@@ -1000,30 +1039,38 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 {
 	int result = acpi_battery_get_status(battery);
+	bool wakeup;
 
 	if (result)
 		return result;
 
 	if (!acpi_battery_present(battery)) {
 		sysfs_remove_battery(battery);
-		battery->update_time = 0;
+		scoped_guard(mutex, &battery->property_lock)
+			battery->update_time = 0;
 		return 0;
 	}
 
 	if (resume)
 		return 0;
 
-	if (!battery->update_time) {
-		result = acpi_battery_get_info(battery);
+	scoped_guard(mutex, &battery->property_lock) {
+		if (!battery->update_time) {
+			result = acpi_battery_get_info(battery);
+			if (result)
+				return result;
+			acpi_battery_init_alarm(battery);
+		}
+
+		result = acpi_battery_get_state(battery);
 		if (result)
 			return result;
-		acpi_battery_init_alarm(battery);
-	}
+		acpi_battery_quirks(battery);
 
-	result = acpi_battery_get_state(battery);
-	if (result)
-		return result;
-	acpi_battery_quirks(battery);
+		wakeup = ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
+			  (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
+			   (battery->capacity_now <= battery->alarm)));
+	}
 
 	if (!battery->bat) {
 		result = sysfs_add_battery(battery);
@@ -1035,9 +1082,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 * Wakeup the system if battery is critical low
 	 * or lower than the alarm level
 	 */
-	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
-	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-	     (battery->capacity_now <= battery->alarm)))
+	if (wakeup)
 		acpi_pm_wakeup_event(battery->phys_dev);
 
 	return result;
@@ -1050,12 +1095,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 	if (!battery->bat)
 		return;
 
-	power_unit = battery->power_unit;
+	scoped_guard(mutex, &battery->property_lock) {
+		power_unit = battery->power_unit;
 
-	acpi_battery_get_info(battery);
+		acpi_battery_get_info(battery);
 
-	if (power_unit == battery->power_unit)
-		return;
+		if (power_unit == battery->power_unit)
+			return;
+	}
 
 	/* The battery has changed its reporting units. */
 	sysfs_remove_battery(battery);
@@ -1110,17 +1157,21 @@ static int battery_notify(struct notifier_block *nb,
 		} else {
 			int result;
 
-			result = acpi_battery_get_info(battery);
-			if (result)
-				return result;
+			scoped_guard(mutex, &battery->property_lock) {
+				result = acpi_battery_get_info(battery);
+				if (result)
+					return result;
+			}
 
 			result = sysfs_add_battery(battery);
 			if (result)
 				return result;
 		}
 
-		acpi_battery_init_alarm(battery);
-		acpi_battery_get_state(battery);
+		scoped_guard(mutex, &battery->property_lock) {
+			acpi_battery_init_alarm(battery);
+			acpi_battery_get_state(battery);
+		}
 	}
 
 	return 0;
@@ -1262,6 +1313,10 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	result = devm_mutex_init(&pdev->dev, &battery->property_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 
-- 
2.53.0

