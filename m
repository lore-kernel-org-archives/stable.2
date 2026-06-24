Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75731E845;
	Wed, 24 Jun 2026 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283203; cv=none; b=bBQR2+lBt2Bui4/uTulkn0G/d4tX6AbAJcudlyNTcsLu93/36LGa+7U1voE2Hx6+D9Ipw8wsETHxDmdT1mhG08i0bkdWADQKVps0uZKrMhti0LN6xlyT48j6iy5GfuXnRUYN4zWyBgFTc7WNP2hcW10G0DXnc9OjEwzbvgfxX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283203; c=relaxed/simple;
	bh=xTX7me2nqh4h7Ws7VEnBGKQ9aXmCho285a1wRkIigYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XUdtum+EP7zAPdLHtRqhG2zi+fIIrggkr07kC0bG3uIhFplNhvYqppMtaAvJQIbPlpxR+MduJuyuFl9ZRZ9U5UgqHjyg0q5wuNwHAVMFpLuYJnJvCg5mzwuwT4uGq63sH8k1fXhPXspfApGVzpUzkeYkQN1IWr2XOPqIionmR5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAHpc2reztqrv78Ag--.26700S2;
	Wed, 24 Jun 2026 14:39:40 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Wed, 24 Jun 2026 14:38:16 +0800
Subject: [PATCH 6.12.y/6.18.y] ACPI: scan: Use async schedule function in
 acpi_scan_clear_dep_fn()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-acpi-dependency-thing-v1-1-ec0d99e5bf0f@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAFd7O2oC/yXMQQrCMBBG4auUWTuQhFCLVxEX7eS3HRdjSKoop
 Xc36vJbvLdRRVFUOnUbFTy16t0a/KEjWUabwZqaKbjQuz5EHiUrJ2RYgsmb10Vt5smHwUd3jDI
 kam0uuOrr9z1f/q6P6QZZvzPa9w/HX0z7eQAAAA==
X-Change-ID: 20260624-acpi-dependency-thing-b12814074c8d
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Yicong Yang <yang.yicong@picoheart.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.2
X-CM-TRANSID:qwCowAAHpc2reztqrv78Ag--.26700S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4fZF47CFy7CrW7tr1kZrb_yoW7trW8pF
	Wa9a47tr4kJw48Cr1xZw4fZr1SgrWUZ347tr43Jw1F9an8ur9FvFW7tr4UZr98CrWvka17
	ZF4qqay8GFWqvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

From: Yicong Yang <yang.yicong@picoheart.com>

[ Upstream commit 7cf28b3797a81b616bb7eb3e90cf131afc452919 ]

The device object rescan in acpi_scan_clear_dep_fn() is scheduled on a
system workqueue which is not guaranteed to be finished before entering
userspace. This may cause some key devices to be missing when userspace
init task tries to find them. Two issues observed on RISCV platforms:

 - Kernel panic due to userspace init cannot have an opened
   console.

   The console device scanning is queued by acpi_scan_clear_dep_queue()
   and not finished by the time userspace init process running, thus by
   the time userspace init runs, no console is present.

 - Entering rescue shell due to the lack of root devices (PCIe nvme in
   our case).

   Same reason as above, the PCIe host bridge scanning is queued on
   a system workqueue and finished after init process runs.

The reason is because both devices (console, PCIe host bridge) depend on
riscv-aplic irqchip to serve their interrupts (console's wired interrupt
and PCI's INTx interrupts). In order to keep the dependency, these
devices are scanned and created after initializing riscv-aplic. The
riscv-aplic is initialized in device_initcall() and a device scan work
is queued via acpi_scan_clear_dep_queue(), which is close to the time
userspace init process is run. Since system_dfl_wq is used in
acpi_scan_clear_dep_queue() with no synchronization, the issues will
happen if userspace init runs before these devices are ready.

The solution is to wait for the queued work to complete before entering
userspace init. One possible way would be to use a dedicated workqueue
instead of system_dfl_wq, and explicitly flush it somewhere in the
initcall stage before entering userspace. Another way is to use
async_schedule_dev_nocall() for scanning these devices. It's designed
for asynchronous initialization and will work in the same way as before
because it's using a dedicated unbound workqueue as well, but the kernel
init code calls async_synchronize_full() right before entering userspace
init which will wait for the work to complete.

Compared to a dedicated workqueue, the second approach is simpler
because the async schedule framework takes care of all of the details.
The ACPI code only needs to focus on its job. A dedicated workqueue for
this could also be redundant because some platforms don't need
acpi_scan_clear_dep_queue() for their device scanning.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
[ rjw: Subject adjustment, changelog edits ]
Link: https://patch.msgid.link/20260128132848.93638-1-yang.yicong@picoheart.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ Vivian: Adjust system_dfl_wq -> system_unbound_wq in removed lines ]
Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
Hi stable team,

This fixes a problem on 6.12.y and 6.18.y with RISC-V platform with AIA
interrupts and ACPI firmware, where devices that uses interrupt lines on
the APLIC interrupt controller can be probed so late that userspace can
start without crucial devices such as the console.

This avoids some very head-scratching timing-dependent userspace boot
problems.

Please consider applying to 6.12.y (for e.g. Debian Trixie) and 6.18.y
(LTS). Thanks.
---
 drivers/acpi/scan.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 50f60da6cf27..16704c2a730c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt) "ACPI: " fmt
 
+#include <linux/async.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2360,46 +2361,34 @@ static int acpi_dev_get_next_consumer_dev_cb(struct acpi_dep_data *dep, void *da
 	return 0;
 }
 
-struct acpi_scan_clear_dep_work {
-	struct work_struct work;
-	struct acpi_device *adev;
-};
-
-static void acpi_scan_clear_dep_fn(struct work_struct *work)
+static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
-	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
+	struct acpi_device *adev = to_acpi_device(dev);
 
 	acpi_scan_lock_acquire();
-	acpi_bus_attach(cdw->adev, (void *)true);
+	acpi_bus_attach(adev, (void *)true);
 	acpi_scan_lock_release();
 
-	acpi_dev_put(cdw->adev);
-	kfree(cdw);
+	acpi_dev_put(adev);
 }
 
 static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
 {
-	struct acpi_scan_clear_dep_work *cdw;
-
 	if (adev->dep_unmet)
 		return false;
 
-	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
-	if (!cdw)
-		return false;
-
-	cdw->adev = adev;
-	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
 	/*
-	 * Since the work function may block on the lock until the entire
-	 * initial enumeration of devices is complete, put it into the unbound
-	 * workqueue.
+	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
+	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
+	 *   be acquired under acpi_dep_list_lock (held here)
+	 * - the deferred work at boot stage is ensured to be finished
+	 *   before userspace init task by the async_synchronize_full()
+	 *   barrier
+	 *
+	 * Use _nocall variant since it'll return on failure instead of
+	 * run the function synchronously.
 	 */
-	queue_work(system_unbound_wq, &cdw->work);
-
-	return true;
+	return async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev);
 }
 
 static void acpi_scan_delete_dep_data(struct acpi_dep_data *dep)

---
base-commit: 275d294b2b24abcd65452198551cd8a5b8d4f775
change-id: 20260624-acpi-dependency-thing-b12814074c8d

Best regards,
--  
Vivian "dramforever" Wang

