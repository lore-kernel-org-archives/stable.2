Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA4382292;
	Wed, 10 Jun 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122278; cv=pass; b=GIZPePBCrwyielvY2CUhRDNgcVDlwT10x+9jAsT8Foco/WB7y9GbCeu4MFMu3Nc5G8pWF/oRwbTnGpqERWCkvgjNrD0j4Yk63raRHb6ShCFFHifGzfDHF0M/CeHJEq/Qy3fLCKG7Nd9i+N6cXQwpdEi8nZ99C7JSJcFPPivoZ2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122278; c=relaxed/simple;
	bh=CnJRORpwe9bY2tAjSGoxGW1TZYkZBaH4MTTNeoFYnEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5euY9wWAFAmQx5BrXF8dCUuEkvX9vM/WPDf5kKy3aoof5tL+ZDxNDXTp/5uIOwCtuudgHnTUs3Y7lqlNnMTBIX1vqSyEfRGloIR3U0d6evLrCHNZw4XT8peISDVKiCliyOG5/mGytM2KZlj+F+v5xwNA/uyK257EVOj5+NH0go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Tu6ZiuYG; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Tu6ZiuYG"
ARC-Seal: i=1; a=rsa-sha256; t=1781122261; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lqLQqvALbomG1AhrJE2s8EtYHp+OlE7HKmCL7RSqxE5eg3nw20aaPkZCB42S24tZ3qNQ4YCiun4f/YPuls2sBd9X+WDQ2eUJocFntjKI7D+AYaqR8JcEOPglKyMfSha4MIUGmsKzzNmqnDVh3j14kRnksReCTHFiFXYkh1XEmZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781122261; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Z6qFnH6HqEphwj5C0HlaAZdh3GQRfD5xfYg2+bcN2k=; 
	b=IfQmxYuc/SKYLUQu4Qy0XGWAKX4fIr8rDci3mz6BF/nEq8G15+ZF9GlYGv8kI46lwMuYjJ/FlkodCkSL/WOU9p9UBppGeJORoZVWT2Hr37iufqGNx6vPz9DJPUZlgglUiLqhi7lsGGYUbJJIM9+ePTXaFwfvGePr58sXV5L0dQs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781122261;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=4Z6qFnH6HqEphwj5C0HlaAZdh3GQRfD5xfYg2+bcN2k=;
	b=Tu6ZiuYGTPmwYK024OqUMNiXkRXAFKQe5qV8Ahd0fy7PyDO8DTYkiJ4Udq+6oUob
	ymrLI1q7vs+eqPfqY3jK8gUNfooWnsGCjNIBglWHM2WAy2eU1QWWoyhUX10RHuGjgan
	P4ABHFJoPlpx7S7/sHKefdRbpRCB5vgh4A0hF0VJzhvNmEfIturel98uIb5dClE96sF
	tSny3toIrxGdQEXxCWqjo+OtUXkGqGr+/kF6ZJ4bRK6jh+KkXSnEyRdffwRQyQVp2E7
	EmERo9G8wX3Gn+m2QU/bxqA8it7xy7YE0KY9OQYbPRZ98B3OkX3ufRhU2TYNxzELObV
	5KZyH9OM8w==
Received: by mx.zohomail.com with SMTPS id 17811222584778.060013424005888;
	Wed, 10 Jun 2026 13:10:58 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 11 Jun 2026 04:10:44 +0800
Subject: [PATCH v3 1/3] ACPI: battery: Merge consecutive battery
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-acpi-battery-notification-v3-1-f9390382c5a4@rong.moe>
References: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe>
In-Reply-To: <20260611-b4-acpi-battery-notification-v3-0-f9390382c5a4@rong.moe>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?Jeffrey_W=C3=A4lti?= <jeffrey@waelti.dev>, 
 Rick <rickk1166@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.16-dev-d5d98
X-ZohoMailClient: External

It's a very common pattern to emit consecutive battery notifications,
for example:

    Method (_Qxx, 0, NotSerialized)
    {
        Notify (BAT0, 0x80) // Status Change
        Notify (BAT0, 0x81) // Information Change
    }

In this case, the current code path will update battery state twice
within a short period, which is not optimal, as the same data are
fetched twice. Moreover, both notifications are likely to call
power_supply_changed(), causing power_supply_uevent() to read all
battery properties in order to assemble uevents. Even worse, after the
first uevent reaches userspace, some userspace processes start to read
all battery properties in order to refresh their internal states, which
competes with the second notification's handling and uevent assembling.

This generates significant pressure on _STA, _BST and _BIX/_BIF methods.
Not only that, power_supply_ext properties may also rely on some other
ACPI methods, so both uevent assembling and userspace processes call
them. It becomes a nightmare when all these methods share the same ACPI
mutex protecting EC accesses and hence vulnerable to lock starvation.
This is exactly the case of some Lenovo devices, where the mentioned EC
query pattern eventually leads to a catastrophic situation that a bunch
of ACPI methods (including but not limited to the mentioned ones) fail
to acquire the same mutex due to timeout. These devices don't handle
mutex acquisition failure gracefully and return garbage data, causing
even more chaos.

Improve battery notification handling by merging consecutive battery
notifications within 10ms using a delayed work, so that they only
refresh and/or update battery state once. ACPI netlink event and
notifier call chain are still triggered multiple times in order not to
break other components. Finally, call power_supply_changed() once and
lead to a single uevent instead of a bunch, preventing userspace
programs from causing too much pressure on power supply properties and
underlying ACPI methods.

Tested-by: Jeffrey Wälti <jeffrey@waelti.dev>
Cc: stable@vger.kernel.org
Reported-by: Rick <rickk1166@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Address Sashiko's concerns:
  - Return from acpi_battery_notification_worker() early when the fifo
    is empty
  - Use pr_err_ratelimited() for potential event storms
  - Add missing `\n' in a printk message
  - https://sashiko.dev/#/patchset/20260527-b4-acpi-battery-notification-v1-0-2303bed8ec0b%40rong.moe
- Minimalize the critical section of acpi_battery_notify()
---
 drivers/acpi/battery.c | 80 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b82dd67d98c9..5f476c074c68 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -21,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/unaligned.h>
 
@@ -43,6 +45,9 @@
 
 #define MAX_STRING_LENGTH	64
 
+#define MAX_QUEUED_EVENTS	16
+#define NOTIF_MERGING_MS	10
+
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_AUTHOR("Alexey Starikovskiy <astarikovskiy@suse.de>");
 MODULE_DESCRIPTION("ACPI Battery Driver");
@@ -95,6 +100,8 @@ struct acpi_battery {
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
 	struct device *phys_dev;
+	struct kfifo acpi_notif_fifo;
+	struct delayed_work acpi_notif_dwork;
 	struct notifier_block pm_nb;
 	struct list_head list;
 	unsigned long update_time;
@@ -1059,14 +1066,24 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_battery_notification_worker(struct work_struct *work)
 {
-	struct acpi_battery *battery = data;
+	struct acpi_battery *battery = container_of(work, struct acpi_battery,
+						    acpi_notif_dwork.work);
 	struct acpi_device *device = battery->device;
+	u32 events[MAX_QUEUED_EVENTS];
 	struct power_supply *old;
+	unsigned int count, i;
 
 	guard(mutex)(&battery->update_lock);
 
+	count = kfifo_out(&battery->acpi_notif_fifo, events, sizeof(events));
+	count /= sizeof(events[0]);
+	if (!count)
+		return;
+
+	pr_debug("merged %u battery notifications within %dms\n", count, NOTIF_MERGING_MS);
+
 	old = battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1076,19 +1093,50 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	 */
 	if (battery_notification_delay_ms > 0)
 		msleep(battery_notification_delay_ms);
-	if (event == ACPI_BATTERY_NOTIFY_INFO)
-		acpi_battery_refresh(battery);
+
+	for (i = 0; i < count; i++) {
+		if (events[i] == ACPI_BATTERY_NOTIFY_INFO) {
+			acpi_battery_refresh(battery);
+			break;
+		}
+	}
+
 	acpi_battery_update(battery, false);
-	acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
-					dev_name(&device->dev), event,
-					acpi_battery_present(battery));
-	acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
-				 event, acpi_battery_present(battery));
+
+	for (i = 0; i < count; i++) {
+		acpi_bus_generate_netlink_event(ACPI_BATTERY_CLASS,
+						dev_name(&device->dev), events[i],
+						acpi_battery_present(battery));
+		acpi_notifier_call_chain(ACPI_BATTERY_CLASS, acpi_device_bid(device),
+					 events[i], acpi_battery_present(battery));
+	}
+
 	/* acpi_battery_update could remove power_supply object */
 	if (old && battery->bat)
 		power_supply_changed(battery->bat);
 }
 
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_battery *battery = data;
+	bool queued = false;
+
+	scoped_guard(mutex, &battery->update_lock) {
+		if (kfifo_avail(&battery->acpi_notif_fifo) >= sizeof(event)) {
+			kfifo_in(&battery->acpi_notif_fifo, &event, sizeof(event));
+			queued = true;
+		}
+	}
+
+	if (queued) {
+		schedule_delayed_work(&battery->acpi_notif_dwork,
+				      msecs_to_jiffies(NOTIF_MERGING_MS));
+	} else {
+		pr_err_ratelimited("too many battery notifications within %dms\n",
+				   NOTIF_MERGING_MS);
+	}
+}
+
 static int battery_notify(struct notifier_block *nb,
 			  unsigned long mode, void *_unused)
 {
@@ -1256,13 +1304,22 @@ static int acpi_battery_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, true);
 
+	result = kfifo_alloc(&battery->acpi_notif_fifo,
+			     MAX_QUEUED_EVENTS * sizeof(u32), GFP_KERNEL);
+	if (result)
+		goto fail_pm;
+
+	INIT_DELAYED_WORK(&battery->acpi_notif_dwork, acpi_battery_notification_worker);
+
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
 						 acpi_battery_notify, battery);
 	if (result)
-		goto fail_pm;
+		goto fail_kfifo;
 
 	return 0;
 
+fail_kfifo:
+	kfifo_free(&battery->acpi_notif_fifo);
 fail_pm:
 	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
@@ -1279,6 +1336,9 @@ static void acpi_battery_remove(struct platform_device *pdev)
 	acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY,
 				       acpi_battery_notify);
 
+	cancel_delayed_work_sync(&battery->acpi_notif_dwork);
+	kfifo_free(&battery->acpi_notif_fifo);
+
 	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
 

-- 
2.53.0

