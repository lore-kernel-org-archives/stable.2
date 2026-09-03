Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048F4B1499
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444345; cv=none; b=Ye8CngpczlHlpx5wUuwV8+j7LPIVW5pXjF3vigNMmQEtOkPpMXCjSSp0LIFqPjp+OjcQ5TjlXTzZtLBNTNpufB0Uoe3HLcTDHAswnhpF+UdCtWZZrZTVaq05GbPV7LWrY8fZvUFBvlMLdjcp8N7hA7G7TyiWdpc3wmEhh1UCzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444345; c=relaxed/simple;
	bh=Gi/JowNR/39SU9huNIGWLS/GIvlAV2SUwBSEiWACC6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iBsfeRVY9A8RoRwWtdFHnwWHYrA0MTkcu3YQQF+/rE479HGOgUpY2q8NDT1acgWgXYZlX9gMJhsqYtNUsEEhEoIzPn8vePGnYlEKuXEPo4nrggCLhdJ54zrZy/CECx+L7cRRES5D2asD1mVwWZsbnAU/uOZOk7PtWqbAzcu78LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2vWAvro; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2vWAvro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A7A1F000E9;
	Thu,  3 Sep 2026 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444340;
	bh=Mhpj5gaBBurpzxjqaxZSfHnG1rorbdKL2cnZqu3eQEw=;
	h=Subject:To:Cc:From:Date;
	b=X2vWAvroB/+dn4W4XSAVRY4z+53g6or9lTlv5/9S7/NZBdsh13bTlOl/qJouSU41v
	 kPAwnNSYCk5JxrQ3lzpJrfxA2/SFopHd+CYKExtJ/dHMG+sPbwtJ8CCCInZWvbtjOk
	 IgYOENgWWXqRtZEivdy9sMv+QNmdmtXdWsErSEpk=
Subject: FAILED: patch "[PATCH] ACPI: battery: Protect all properties with a separated mutex" failed to apply to 7.2-stable tree
To: i@rong.moe,anhollander516@gmail.com,rafael.j.wysocki@intel.com,rickk1166@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:43:57 +0200
Message-ID: <2026090357-tweet-veal-37b7@gregkh>
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
git cherry-pick -x 9e409f1dff7841634e4b101111d6427f979c0aac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090357-tweet-veal-37b7@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e409f1dff7841634e4b101111d6427f979c0aac Mon Sep 17 00:00:00 2001
From: Rong Zhang <i@rong.moe>
Date: Sun, 9 Aug 2026 07:43:55 +0800
Subject: [PATCH] ACPI: battery: Protect all properties with a separated mutex

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

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 0084f308b790..670853ec3a4d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -105,6 +106,9 @@ struct acpi_battery {
 	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
+	unsigned long flags;
+
+	struct mutex property_lock; /* Protects properties below. */
 	unsigned long update_time;
 	int revision;
 	int rate_now;
@@ -131,7 +135,6 @@ struct acpi_battery {
 	char oem_info[MAX_STRING_LENGTH];
 	int state;
 	int power_unit;
-	unsigned long flags;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -189,20 +192,6 @@ static bool acpi_battery_is_degraded(struct acpi_battery *battery)
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
@@ -210,15 +199,41 @@ static int acpi_battery_get_property(struct power_supply *psy,
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
 			/* Check the rate and capacity to validate the status. */
 			if (!acpi_battery_is_full(battery) ||
@@ -321,6 +336,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	default:
 		ret = -EINVAL;
 	}
+
+	mutex_unlock(&battery->property_lock);
 	return ret;
 }
 
@@ -556,6 +573,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 	int use_bix;
 	int result = -ENODEV;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -595,6 +614,8 @@ static int acpi_battery_get_state(struct acpi_battery *battery)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery))
 		return 0;
 
@@ -648,6 +669,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 {
 	acpi_status status = 0;
 
+	lockdep_assert_held(&battery->property_lock);
+
 	if (!acpi_battery_present(battery) ||
 	    !test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags))
 		return -ENODEV;
@@ -665,6 +688,8 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 
 static int acpi_battery_init_alarm(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	/* See if alarms are supported, and if so, set default */
 	if (!acpi_has_method(battery->device->handle, "_BTP")) {
 		clear_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags);
@@ -682,6 +707,8 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
 
+	guard(mutex)(&battery->property_lock);
+
 	return sysfs_emit(buf, "%d\n", battery->alarm * 1000);
 }
 
@@ -697,6 +724,8 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&battery->property_lock);
+
 	battery->alarm = x / 1000;
 	if (acpi_battery_present(battery))
 		acpi_battery_set_alarm(battery);
@@ -881,12 +910,17 @@ static int sysfs_add_battery(struct acpi_battery *battery)
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
@@ -940,6 +974,9 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 static void find_battery(const struct dmi_header *dm, void *private)
 {
 	struct acpi_battery *battery = (struct acpi_battery *)private;
+
+	lockdep_assert_held(&battery->property_lock);
+
 	/* Note: the hardcoded offsets below have been extracted from
 	 * the source code of dmidecode.
 	 */
@@ -971,6 +1008,8 @@ static void find_battery(const struct dmi_header *dm, void *private)
  */
 static void acpi_battery_quirks(struct acpi_battery *battery)
 {
+	lockdep_assert_held(&battery->property_lock);
+
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags))
 		return;
 
@@ -1023,30 +1062,38 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
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
@@ -1058,9 +1105,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	 * Wakeup the system if battery is critical low
 	 * or lower than the alarm level
 	 */
-	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
-	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
-	     (battery->capacity_now <= battery->alarm)))
+	if (wakeup)
 		acpi_pm_wakeup_event(battery->phys_dev);
 
 	return result;
@@ -1073,12 +1118,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
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
@@ -1170,17 +1217,21 @@ static int battery_notify(struct notifier_block *nb,
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
@@ -1345,6 +1396,10 @@ static int acpi_battery_probe(struct platform_device *pdev)
 	if (result)
 		return result;
 
+	result = devm_mutex_init(&pdev->dev, &battery->property_lock);
+	if (result)
+		return result;
+
 	if (acpi_has_method(battery->device->handle, "_BIX"))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
 

