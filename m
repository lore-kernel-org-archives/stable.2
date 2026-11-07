Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794084608;
	b=i4ObmcgGZ0s1fs3IkyV1qyqm9CyXgPTx1Wzgv8+Q5ORz0EfihbbqzW3+fNnmfWl1nCSH
	 GpE7qAloVWoVqEUWMidsYxtVHX87tO0HKwkb8ORDZUtOKExC3MG1zm8tjr8i7YnhbSEa2
	 rjQLc3U5VblL16TdiGgfOTmVT557LZy/V3OzFC9xDbXvFVOc6055fPP9DryZWrIuCJcgP
	 3cVA3lqyT8rFYeBSmFPwGQkBpTMw5oXj9RSkiNlnu0FWMXJHqJprHzaZ9zjXyTcDrnUus
	 yTcvO4AtW4vJ3gbca2/svlVeqGDmjMN7KwawwbBdIoLyvXrM4GzyGs4hLTX3pj6dZ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084608;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ogu3WYl26VzYnLKTpBw3sq7j0lnDtjUsntu6D8wGtpY=;
	b=nKWYIHZMxD9/6QsCyfDHg4X9lXRrKrdrX12+s1kg7zvStskhluBBc53gOBYw3aVzXbfi
	 wmz4s/GD40msBcco6gtC5DrCSDRQ98hwyGwZfs2GssXgPYjblaXY4xhLxxZ4b4BoR1qXK
	 FT6w+VvsvGezzUIB+lDGZAxQK/mbr4LLtHinbrj/YTCjILgvxXxN0GPJ+atziSuV2nK3+
	 wuScPDBOei5Ya0et2CjqeHX7wa+SnY11HeUJx8Yt7VhBB6acTJ/CJiM71wSG8C54psimc
	 WPRX74Ark/LJpDCeEgjrgPFGXHVJ3TeuYu8vhkFP/+6iwqvL7W73evtm7eqa8zvphXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	arc=none smtp.remote-ip=109.224.244.21
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49D606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 20:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF49D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794084603; x=1794343803;
	bh=ogu3WYl26VzYnLKTpBw3sq7j0lnDtjUsntu6D8wGtpY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=I6Rca7cqtH06AZZhUiywwWgrBwZ6IGtSDHaudMuvC6036TChEUJ91VBVrxuTO5qC6
	 /qlJ/66HqFuNVWDKsEKB/zaF51qLgUlbibcHeCneQEdKBOvAl0Zu1m6He4Z2J+DlEv
	 fXDzBmRcdrS8RDINE/zcgi3ruelPTruwxGEfwO4n0d+QmVZs4pz5gw+tkFxoSTDZco
	 yLJMwb679wNwkPCWmxlyjPCCjAfeBYQ6UhFqEz4kpggb9V8alQcj3ZvSrkfp2L2Gy2
	 eZPfSDc6Txinnv/RuQnNC6+K9C1mdJ5wTWpEXYDVBWmO3ISlpW9p1ci45OPf18Blhh
	 WX3wZcwLSorAw==
Date: Sat, 07 Nov 2026 20:49:58 +0000
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Hans de Goede <hansg@kernel.org>, =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From: Chad Aldreda <ca@modelmiser.com>
Cc: platform-driver-x86@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-smo8800: keep the state until the last file is closed
Message-ID: <20261107204950.88952-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 0531ab98a8600ea4e4b0ace56693e6f3eec95f87
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

struct smo8800_device is allocated with devm_kzalloc(), so it is freed
when the driver is unbound, but a /dev/freefall file opened before the
unbind still reaches it through file->private_data. release() then
clears misc_opened in freed memory, and a read() blocked in
wait_event_interruptible() is not woken by remove(). It sleeps on a wait
queue inside the freed structure until a signal arrives, and then uses
it. Unbinding the driver needs root. With KASAN, closing the file after
an unbind gives a slab-use-after-free in smo8800_misc_release(), and a
blocked reader interrupted after the unbind gives further reports in
smo8800_misc_read() and prepare_to_wait_event().

Allocate the structure with kzalloc() and give it a kref. open() takes a
reference and release() drops it. The device's own reference is dropped
by a devm action, which runs after smo8800_remove() on unbind and when
probe fails. misc_open() calls ->open with misc_mtx held and
misc_deregister() takes misc_mtx, so the device reference is held
whenever ->open runs. Once the misc device is deregistered, by remove()
or by the probe error path, a removed flag is set and the wait queue
woken. A read() blocked at that point returns -ENODEV unless an event
arrived first, and a later read() returns -ENODEV.

The problem was found with a Coccinelle script that reports device nodes
in devm memory [1]. The fix, the reproducer and this message were
written with an AI assistant (Claude) and checked by hand. The fix was
tested in QEMU, with KASAN enabled, using a test-only module that
registers an "smo8800" platform device with a simulated interrupt, not
on Dell hardware.

Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com =
[1]
Fixes: 4738d8aabe89 ("platform: x86: dell-smo8800: Dell Latitude freefall d=
river (ACPI SMO8800/SMO8810)")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
The Coccinelle script reports a devm_k*() allocation when it, or an
address inside it, is passed to misc_register(), cdev_add(),
cdev_device_add(), video_register_device() or v4l2_device_register()
in the same function, or when the allocated struct embeds one of those
objects. It reports dell-smo8800 for the misc_register() of
&smo8800->miscdev.

Reproduced in QEMU 10.2.4 (q35, KASAN, booted with kasan_multi_shot). A
test-only module registers a platform device named "smo8800" with an
interrupt from an irq_sim domain, so the driver binds without the ACPI
device, and a module parameter raises the interrupt. A process opens
/dev/freefall and the driver is unbound through sysfs. Without this
patch:

  close after the unbind:                  1 KASAN report (release)
  read() blocked across the unbind:        not woken; after a signal,
                                           7 reports (read, wait queue,
                                           release)
  unbind, bind, then close the old file:   1 report
  close before the unbind (control):       0

With it there are none: the blocked read() returns -ENODEV when the
driver is unbound, a bind after the unbind works, and an interrupt
still wakes a reader with a count. Not tested on Dell hardware.

An interrupt that arrives while remove() runs, between the reader's
count check and its removed check, is dropped and the read returns
-ENODEV. remove() frees the IRQ before setting removed, so no event can
be lost after that.

kzalloc() rather than kzalloc_obj(), which first appears in v7.0: the
patch then applies as is from v6.14. On v6.6 to v6.13 only the include
hunk needs adjusting (those trees have no dell-smo8800-ids.h); v5.15 and
v6.1 need a manual backport (remove() returns int there), and before
v5.15 the driver was an ACPI driver.

 drivers/platform/x86/dell/dell-smo8800.c | 35 ++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x8=
6/dell/dell-smo8800.c
index 8872f9b57fce..8880bf39f895 100644
--- a/drivers/platform/x86/dell/dell-smo8800.c
+++ b/drivers/platform/x86/dell/dell-smo8800.c
@@ -13,9 +13,11 @@
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include "dell-smo8800-ids.h"
=20
@@ -26,8 +28,22 @@ struct smo8800_device {
 =09unsigned long misc_opened;   /* whether the device is open */
 =09wait_queue_head_t misc_wait; /* Wait queue for the misc dev */
 =09struct device *dev;          /* acpi device */
+=09struct kref kref;            /* device + open file */
+=09bool removed;                /* the device has been removed */
 };
=20
+static void smo8800_free(struct kref *kref)
+{
+=09kfree(container_of(kref, struct smo8800_device, kref));
+}
+
+static void smo8800_put(void *data)
+{
+=09struct smo8800_device *smo8800 =3D data;
+
+=09kref_put(&smo8800->kref, smo8800_free);
+}
+
 static irqreturn_t smo8800_interrupt_quick(int irq, void *data)
 {
 =09struct smo8800_device *smo8800 =3D data;
@@ -60,11 +76,15 @@ static ssize_t smo8800_misc_read(struct file *file, cha=
r __user *buf,
=20
 =09atomic_set(&smo8800->counter, 0);
 =09retval =3D wait_event_interruptible(smo8800->misc_wait,
-=09=09=09=09(data =3D atomic_xchg(&smo8800->counter, 0)));
+=09=09=09=09(data =3D atomic_xchg(&smo8800->counter, 0)) ||
+=09=09=09=09READ_ONCE(smo8800->removed));
=20
 =09if (retval)
 =09=09return retval;
=20
+=09if (!data)
+=09=09return -ENODEV;
+
 =09retval =3D 1;
=20
 =09byte_data =3D min_t(u32, data, 255);
@@ -84,6 +104,7 @@ static int smo8800_misc_open(struct inode *inode, struct=
 file *file)
 =09=09return -EBUSY; /* already open */
=20
 =09atomic_set(&smo8800->counter, 0);
+=09kref_get(&smo8800->kref);
 =09return 0;
 }
=20
@@ -93,6 +114,7 @@ static int smo8800_misc_release(struct inode *inode, str=
uct file *file)
 =09=09=09=09=09 struct smo8800_device, miscdev);
=20
 =09clear_bit(0, &smo8800->misc_opened); /* release the device */
+=09smo8800_put(smo8800);
 =09return 0;
 }
=20
@@ -108,11 +130,16 @@ static int smo8800_probe(struct platform_device *devi=
ce)
 =09int err;
 =09struct smo8800_device *smo8800;
=20
-=09smo8800 =3D devm_kzalloc(&device->dev, sizeof(*smo8800), GFP_KERNEL);
+=09/* An open file can outlive the device, so it holds a reference. */
+=09smo8800 =3D kzalloc(sizeof(*smo8800), GFP_KERNEL);
 =09if (!smo8800) {
 =09=09dev_err(&device->dev, "failed to allocate device data\n");
 =09=09return -ENOMEM;
 =09}
+=09kref_init(&smo8800->kref);
+=09err =3D devm_add_action_or_reset(&device->dev, smo8800_put, smo8800);
+=09if (err)
+=09=09return err;
=20
 =09smo8800->dev =3D &device->dev;
 =09smo8800->miscdev.minor =3D MISC_DYNAMIC_MINOR;
@@ -151,6 +178,8 @@ static int smo8800_probe(struct platform_device *device=
)
=20
 error:
 =09misc_deregister(&smo8800->miscdev);
+=09WRITE_ONCE(smo8800->removed, true);
+=09wake_up_interruptible(&smo8800->misc_wait);
 =09return err;
 }
=20
@@ -160,6 +189,8 @@ static void smo8800_remove(struct platform_device *devi=
ce)
=20
 =09free_irq(smo8800->irq, smo8800);
 =09misc_deregister(&smo8800->miscdev);
+=09WRITE_ONCE(smo8800->removed, true);
+=09wake_up_interruptible(&smo8800->misc_wait);
 =09dev_dbg(&device->dev, "device /dev/freefall unregistered\n");
 }
=20
--=20
2.43.0


