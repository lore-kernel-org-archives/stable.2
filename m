Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DF374A1B;
	Wed, 10 Jun 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119367; cv=pass; b=oiJ6T/+T6IfVHgQSshSRLwgBhDf1wu3Z9HsDPkeknkLp+iPbeEP7BYlTkh3sZGqiJvByVXKr8UmOHeOqFZbWGz+Cn6YEUMNYpHaX77Nqa44haZBjaQvbMXrTamOsFgRH4Cj26J26ry6LmiI0GhJCIAOYKOQ1VLMxxv7fKGY64B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119367; c=relaxed/simple;
	bh=CnJRORpwe9bY2tAjSGoxGW1TZYkZBaH4MTTNeoFYnEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Us3c56St1R94Uq/mpXEbHfgQ5td5QDnMMNHp/mhnbs2aPzyH8sfDD4/xFaiLUhAwhuG9OpqrIhtpt1wzacFRTN7BU9wZjQhqX4lfxRptSXMNiou497UDzV3c0CB2sT3HQz2Kghzrb5zAWSk57fB+xpvN+/cClsojEwbK5/NVCuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=QyFy/Q8R; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="QyFy/Q8R"
ARC-Seal: i=1; a=rsa-sha256; t=1781119351; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UuyhLDdZKq5ae+CYDVNuLO/7mHr4PeJxrgtOu/8F3l0Mzp3w9tdT9d45q9FQ4qW/SISGKOUYtd9alHgnAm+maNGT2G1hlkQOf8Xcw0z5ezt76VSj1hbOC+tvpduga+X5hGrsun8q05xEWetnxoaToHgrylrkyasYFfuqOVSXU+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781119351; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Z6qFnH6HqEphwj5C0HlaAZdh3GQRfD5xfYg2+bcN2k=; 
	b=SZ6GsEs4yrxBvpjJ9orBWmRF48Hk6GeRaRJ982fsnpHltG2dlW5MbB8dEcplwzx5m9zrzCL1+ZKhmmkN9AojQC4lZn77WhWRf59DS2NlEDO0DzLkn2dSptUxhTbFj3gXfFi2xDGMKZT3jTY2i/SKnL6gXHAEpS3sZwCSjI86wBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781119351;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=4Z6qFnH6HqEphwj5C0HlaAZdh3GQRfD5xfYg2+bcN2k=;
	b=QyFy/Q8RO9W+pOlDsNBJFpEak/tiYNFn4HcQ6ktYhr0gSnlulZrR/2np42+UxCR4
	59IueJrPQumZBBTpZ3/9U2TCJQuTSKj3MU/D9LFwTnjIh9AmD/CqmS3XzyK2Gjx4ICH
	W6b8JgFtG1fME4KPescVzCDu3L35J88E3mPNrv/90SXznbRKSs4YiKHmuZnDEXrFhXa
	u9az6wzXeFicUA4Q7kWWtFEMov4wZaCxokj39ozi4Zg0vOX8iHh73A7Z88RNOtWOAwi
	SaYvp57Cs2y6q0hJVds+5XkZgwqVGl8Zo5OxwmP8/1OP2qeqzv78PAHIOMXxn3ICZ+r
	asS8QK0+MA==
Received: by mx.zohomail.com with SMTPS id 1781119350307645.0208205132593;
	Wed, 10 Jun 2026 12:22:30 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Date: Thu, 11 Jun 2026 03:22:17 +0800
Subject: [PATCH v2 1/3] ACPI: battery: Merge consecutive battery
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-acpi-battery-notification-v2-1-4e8ed651a151@rong.moe>
References: <20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
In-Reply-To: <20260611-b4-acpi-battery-notification-v2-0-4e8ed651a151@rong.moe>
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

