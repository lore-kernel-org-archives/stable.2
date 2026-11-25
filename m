Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594003;
	b=fDHScXSD4wqEGYngOrMRevc3d5m3pCb6jiAbmtTFJWKMi1HnrQaSgd+cDjst4ptbtLCz
	 tMVrpBVf3fLp8aNaGFojhKqFpkzcoWMPSYJ5nFxrgFnIBz3BZ/VwJe7/RPMLSxG11mdwI
	 yF3LBGzAFBRuK9bXWB8uv6i51wTGXdRiwwtVrBULLzziJD6krEa1wujFlrzQx5qwEjIne
	 GCi/aBG8ar1NRVnLGGJohNoJKz+y5sDWaxFgbesA2W/nG1T68xGIDQQ9T6H32Ffkxcgxm
	 53/b3BuozkgRR9exZXYdCTtyYPk90YnukL5uZLUmDU5Z6tVSY/eDzYnseBK861qSN2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594003;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M8XCrFSHUIgYWUoAO1XKorle5rekNJC2RkxqBaaweHQ=;
	b=rkQTPrEGAyB+XKIHQHipq1Q+j/l5USCi/0E/IjyiSCNLU3E0W9fR8eaE1nZMsfk3LPGP
	 NHIdpGK9dMiBZUcLapot7qVfEZAx5KM81mMKIYgYEZ0fWmBbS4Ss91l95wtlAkLt72teu
	 fDoGAGwTIE5rjTtVGJzusBgrm98xyH+SdcD6m0r9k9Bt9gy87pBqRCNxlgd9hj8+HP0ZM
	 JKNlcra2EL95xjaSwVymz9NWtCB8v0uQz9Y/gX0qT6kg/Hf2wQFXlOm02yC0IRcKq8anS
	 8p6cf2F3CGvNDt2BWyMg7j6XFyGqdjF6loFUa3XiN1WnmKi7JCHFHjcUi4ZVDrV+Egg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=gUfHis60;
	arc=none smtp.remote-ip=115.124.28.197
Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51323606A321;
	Wed, 25 Nov 2026 08:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51323606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=gUfHis60
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1795593996; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M8XCrFSHUIgYWUoAO1XKorle5rekNJC2RkxqBaaweHQ=;
	b=gUfHis60C3+O/B40185hi+72VcG8++A/lna5SMCFShKKQQhoTBzGkZhyGo0/gktiziTzxcTEE2FAnwg53UwMfbEjNKCEdup6cweJ0Es0CrIusmRMZ6nXfX3YMNEqKaNrvBnOUqG4HbKXrGYC4Lj/GyVtImgwc7ouBcEsW8Hs0aE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0195112-0.0299786-0.95051;FP=12050426819878012378|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=zhugl3@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.k9lhNRn_1795593995;
Received: from DESKTOP-UL5U09E.xiaopeng.local(mailfrom:zhugl3@xiaopeng.com fp:SMTPD_---.k9lhNRn_1795593995 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 16:06:35 +0800
From: Zhu GuangLei <zhugl3@xiaopeng.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	liuwb@xiaopeng.com,
	stable@vger.kernel.org
Subject: [PATCH] misc/pvpanic: share the shutdown handler across devices
Date: Wed, 25 Nov 2026 16:06:35 +0800
Message-ID: <20261125080635.112699-1-zhugl3@xiaopeng.com>
X-Mailer: git-send-email 2.43.0
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
the events mask and of the handler registration with a mutex. The
panic and power-off paths still take only the list spinlock, so access
the events mask with READ_ONCE()/WRITE_ONCE().

The shutdown event only reaches pvpanic when no higher priority
power-off handler, such as the ACPI one, turns the machine off first.
Tested on a v6.18 based guest booted with acpi=off under QEMU 8.2.2
(TCG) with two pvpanic-pci devices created with events=7: after
unbinding the first device and powering off, QEMU did not receive the
shutdown byte (0x4) without this change and does receive it with it.
Masking the shutdown event on a single device still suppresses the
write.

OpenAI Codex was used to write the code change and the QEMU test
scripts, and to run the tests. GitHub Copilot was used to review the
change and to rewrite this changelog.

Fixes: 7b51b1373321 ("misc/pvpanic: add support for normal shutdowns")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu GuangLei <zhugl3@xiaopeng.com>
---
 drivers/misc/pvpanic/pvpanic.c | 56 ++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 3d43045bf..ed7a01d45 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -16,6 +16,7 @@
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
@@ -35,12 +36,14 @@ struct pvpanic_instance {
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
@@ -51,7 +54,7 @@ pvpanic_send_event(unsigned int event)
 		return;
 
 	list_for_each_entry(pi_cur, &pvpanic_list, list) {
-		if (event & pi_cur->capability & pi_cur->events)
+		if (event & pi_cur->capability & READ_ONCE(pi_cur->events))
 			iowrite8(event, pi_cur->base);
 	}
 	spin_unlock(&pvpanic_lock);
@@ -86,30 +89,34 @@ static int pvpanic_sys_off(struct sys_off_data *data)
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
-
-	if (!pi->sys_off) {
-		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_LOW,
+	mutex_lock(&pvpanic_sys_off_lock);
+	if ((pi->events ^ events) & PVPANIC_SHUTDOWN) {
+		if (events & PVPANIC_SHUTDOWN)
+			pvpanic_sys_off_users++;
+		else
+			pvpanic_sys_off_users--;
+	}
+	WRITE_ONCE(pi->events, events);
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
+	mutex_unlock(&pvpanic_sys_off_lock);
 }
 
 static void pvpanic_remove(void *param)
@@ -126,7 +133,7 @@ static void pvpanic_remove(void *param)
 	}
 	spin_unlock(&pvpanic_lock);
 
-	unregister_sys_off_handler(pi->sys_off);
+	pvpanic_set_events(NULL, pi, 0);
 }
 
 static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -141,7 +148,7 @@ static ssize_t events_show(struct device *dev, struct device_attribute *attr, ch
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
-	return sysfs_emit(buf, "%x\n", pi->events);
+	return sysfs_emit(buf, "%x\n", READ_ONCE(pi->events));
 }
 
 static ssize_t events_store(struct device *dev, struct device_attribute *attr,
@@ -158,8 +165,7 @@ static ssize_t events_store(struct device *dev, struct device_attribute *attr,
 	if ((tmp & pi->capability) != tmp)
 		return -EINVAL;
 
-	pi->events = tmp;
-	pvpanic_synchronize_sys_off_handler(dev, pi);
+	pvpanic_set_events(dev, pi, tmp);
 
 	return count;
 }
@@ -197,10 +203,8 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 
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

