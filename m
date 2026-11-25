Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598136;
	b=cBkxIqsKYV0VchnmNgXHgfmJ89djfubZEu12PAA6kyi3AL0x1vfNK+gbpXr9Ig96miFU
	 tn/KhVV3EJ59qDtihS8KaCwzpxjyz06j6saoVMpFJF/CeCLENBw9ahEdRHtuAkhFD+GV0
	 G9A+Noba1lLu+4Eez1fg+XK/YX+klEXJXs+e72FYrrSZfAqwtq8XrQR0pZ42RSrjSQsYS
	 ekasuyLmGHoz5UUm+mSpRSfky1QtvLQ0JN4bbtMipt2Z4RiVosBP2eL8NMo8Q1CexsySx
	 oVwmtexgHX45ToV6ngHtxTXaXOycsrHQaOqSPPUWCL7ou4PtcbucT+ArgGPysc+TTJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598136;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YNu7gK1BJKuLSEdjnyDJSrGx8nAlTfgymyAg2Zi+FS0=;
	b=kHs0QHWM9RMyq+tuAC+Mqm6PgBbmBHavGNSINtWYWiI8RiRGoceeS/ExKOcHaKdDciar
	 L6liHN33kqiC6ItOdgO0FekpTVL6P0f5ThDPG5bEJfOkLYrwdogsfOW9FrQi9dDp8ZTNa
	 xNJ2MrDA06IA9c1/qWI7+TCXVReNcTA7TiKvC/z1UgDqnp1oAYmgdYi9vV9tO04Z2lYUI
	 qgtjrI1s2Ni85aF/y/KCokV7YCW5ATEiyX044qoSr9lRnNFwvM91K9ugikiawMZOK+ElY
	 O1AH5NDzlemSHHFqnJBSkgxYHz272jphE3XLp9tjjRkhV9UtuyvnycvPokUXqoy/THA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=soOxamd3;
	arc=none smtp.remote-ip=115.124.28.52
Received: from out28-52.mail.aliyun.com (out28-52.mail.aliyun.com [115.124.28.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9966606A336;
	Wed, 25 Nov 2026 09:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9966606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=soOxamd3
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795598121; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YNu7gK1BJKuLSEdjnyDJSrGx8nAlTfgymyAg2Zi+FS0=;
	b=soOxamd35RPnrPl63rIyC8r0XCsDfSnLGvjj5+KDUG3SSRvxBDarDNFfWBfzRl015TdF6EgqtiSeC2VhS1JbagTPmCfKi3N1m+2fguL/SgH7wJdoIaTIHuVi6HZOvy3F+2OrzDfd7XwVFIIy3ii+PDA3QclpuzAxOhF2fFFtBBM=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0368796-0.0826037-0.880517;FP=2827124052255786457|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065158064;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.k9lV60-_1795598121;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k9lV60-_1795598121 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 17:15:21 +0800
From: Zhu GuangLei <zhugl3@xiaopeng.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH v2] misc/pvpanic: share the shutdown handler across devices
Date: Wed, 25 Nov 2026 17:15:20 +0800
Message-ID: <20261125091520.173803-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125080635.112699-1-zhugl3@xiaopeng.com>
References: <20261125080635.112699-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each pvpanic device registers its own power-off handler at
SYS_OFF_PRIO_LOW. register_sys_off_handler() accepts only one handler
per non-default priority, so when a second pvpanic device is probed the
registration fails with -EBUSY and the driver logs "Could not register
sys_off_handler". The handler that did get registered notifies every
device on the list, but it is owned by the first device. Once that
device is unbound, or its shutdown event is masked through sysfs, the
handler is unregistered and the remaining device stops reporting
shutdowns even though its events mask still has PVPANIC_SHUTDOWN set.

Register a single handler for the driver and keep it as long as at
least one device has the shutdown event enabled. Serialize updates of
the events mask and of the handler registration with a mutex, and also
update the mask under the list spinlock, which is the only lock taken
by the panic and power-off paths.

The shutdown event only reaches pvpanic when no higher priority
power-off handler, such as the ACPI one, turns the machine off first.
Tested on a v6.18 based guest booted with acpi=off under QEMU 8.2.2
(TCG) with two pvpanic-pci devices created with events=7: after
unbinding the first device, or masking its shutdown event through
sysfs, and powering off, QEMU did not receive the shutdown byte (0x4)
without this change and does receive it with it.
Masking the shutdown event on a single device still suppresses the
write.

OpenAI Codex was used to write the code change and the QEMU test
scripts, and to run the tests. GitHub Copilot was used to review the
change, to rewrite this changelog and to prepare v2.

Fixes: 7b51b1373321 ("misc/pvpanic: add support for normal shutdowns")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu GuangLei <zhugl3@xiaopeng.com>
---

Notes:
    Changes in v2:
    - Update the events mask under pvpanic_lock instead of using
      READ_ONCE()/WRITE_ONCE(), and read it under the mutex in events_show()
    - Use guard()/scoped_guard() for the locks (Greg)
    - Also test masking the shutdown event of the first device via sysfs
    
    v1: https://lore.kernel.org/all/20261125080635.112699-1-zhugl3@xiaopeng.com/

 drivers/misc/pvpanic/pvpanic.c | 55 ++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 3d43045bf..150c38f80 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -7,6 +7,7 @@
  *  Copyright (C) 2021 Oracle.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp_types.h>
@@ -16,6 +17,7 @@
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
@@ -35,12 +37,14 @@ struct pvpanic_instance {
 	void __iomem *base;
 	unsigned int capability;
 	unsigned int events;
-	struct sys_off_handler *sys_off;
 	struct list_head list;
 };
 
 static struct list_head pvpanic_list;
 static spinlock_t pvpanic_lock;
+static DEFINE_MUTEX(pvpanic_sys_off_lock);
+static struct sys_off_handler *pvpanic_sys_off_handler;
+static unsigned int pvpanic_sys_off_users;
 
 static void
 pvpanic_send_event(unsigned int event)
@@ -86,29 +90,35 @@ static int pvpanic_sys_off(struct sys_off_data *data)
 	return NOTIFY_DONE;
 }
 
-static void pvpanic_synchronize_sys_off_handler(struct device *dev, struct pvpanic_instance *pi)
+static void pvpanic_set_events(struct device *dev, struct pvpanic_instance *pi,
+			       unsigned int events)
 {
-	/* The kernel core has logic to fall back to system halt if no
-	 * sys_off_handler is registered.
-	 * When the pvpanic sys_off_handler is disabled via sysfs the kernel
-	 * should use that fallback logic, so the handler needs to be unregistered.
-	 */
-
 	struct sys_off_handler *sys_off;
 
-	if (!(pi->events & PVPANIC_SHUTDOWN) == !pi->sys_off)
-		return;
+	guard(mutex)(&pvpanic_sys_off_lock);
 
-	if (!pi->sys_off) {
-		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_LOW,
+	if ((pi->events ^ events) & PVPANIC_SHUTDOWN) {
+		if (events & PVPANIC_SHUTDOWN)
+			pvpanic_sys_off_users++;
+		else
+			pvpanic_sys_off_users--;
+	}
+
+	scoped_guard(spinlock, &pvpanic_lock)
+		pi->events = events;
+
+	if (!pvpanic_sys_off_users) {
+		/* Allow the kernel to fall back to halt if no handler remains. */
+		unregister_sys_off_handler(pvpanic_sys_off_handler);
+		pvpanic_sys_off_handler = NULL;
+	} else if (dev && !pvpanic_sys_off_handler) {
+		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+						   SYS_OFF_PRIO_LOW,
 						   pvpanic_sys_off, NULL);
 		if (IS_ERR(sys_off))
 			dev_warn(dev, "Could not register sys_off_handler: %pe\n", sys_off);
 		else
-			pi->sys_off = sys_off;
-	} else {
-		unregister_sys_off_handler(pi->sys_off);
-		pi->sys_off = NULL;
+			pvpanic_sys_off_handler = sys_off;
 	}
 }
 
@@ -126,7 +136,7 @@ static void pvpanic_remove(void *param)
 	}
 	spin_unlock(&pvpanic_lock);
 
-	unregister_sys_off_handler(pi->sys_off);
+	pvpanic_set_events(NULL, pi, 0);
 }
 
 static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -141,6 +151,8 @@ static ssize_t events_show(struct device *dev, struct device_attribute *attr, ch
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
+	guard(mutex)(&pvpanic_sys_off_lock);
+
 	return sysfs_emit(buf, "%x\n", pi->events);
 }
 
@@ -158,8 +170,7 @@ static ssize_t events_store(struct device *dev, struct device_attribute *attr,
 	if ((tmp & pi->capability) != tmp)
 		return -EINVAL;
 
-	pi->events = tmp;
-	pvpanic_synchronize_sys_off_handler(dev, pi);
+	pvpanic_set_events(dev, pi, tmp);
 
 	return count;
 }
@@ -197,10 +208,8 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 
 	/* initlize capability by RDPT */
 	pi->capability &= ioread8(base);
-	pi->events = pi->capability;
-
-	pi->sys_off = NULL;
-	pvpanic_synchronize_sys_off_handler(dev, pi);
+	pi->events = 0;
+	pvpanic_set_events(dev, pi, pi->capability);
 
 	spin_lock(&pvpanic_lock);
 	list_add(&pi->list, &pvpanic_list);

base-commit: 917fcbf033154a6c8d83cfa6c88f012b71eb37b2
-- 
2.43.0

