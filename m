Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321899;
	b=P/KmfbzXObriEQ/7fsyUndCnfRetorg+Slky49e0wsDspoziTvONqHHr8XvCYVKXrPWz
	 EZwoZg+FsCjvYA47tQnPp993xpQGT/kMfinMyEN+Dlg4cmj/PT7T6zaI3boxT/MI4+73j
	 VBnFFnD25pluE9KWqISzyqI1gUZ0bnAmArfZ9umylDyZO7OWoOMZQqUL1tx1EtXKMKXY/
	 bh7cRxKEh2x8lMXHLSOb5v4INbWA0vZhIYFMNLRjSr5aQl7fHFIPlB+hqqG6utd4lSNlq
	 F6GQKEPySWLnLGKAvMmaD0/DoryRg979o4LgwKIOBUbRuXVbSvn+m6tgS/a3J6lZryg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321899;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=orsRB4SdYsft12+xEJaVNxxib74REtg/MP7hL7g3SzU=;
	b=zJpjCNQnzrajLpUGCgMId6Ldnwof/IpnYohBO8Y4A0IKr0snYCAYZj1FjQx9Z4whYwfs
	 mS9M98qMzXqu+2OzhDKlSfX38LnPpddoml345ia1jPwrC8jlGko8KQjiod0Gf6z056zBV
	 p0+3pIZS+dzC+uci0HDP54GAU/9B6E/RyBk4uz9K0NcuPsohIxuwk7n/HELxDfioOZw3f
	 KyKGvETTFKiC1U7uXg1UW7xHDmw0zL8hs7uCUlUuy7OEmAx1KziyIrmlI2RTNk6shl/QM
	 FEy6k11qmBKrRav/oKkw11H3DXh11bLuRQ2nivWSee2QBQYlch4OAfpu/aMaWP1YK4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	arc=none smtp.remote-ip=79.135.106.116
Received: from mail-106116.protonmail.ch (mail-106116.protonmail.ch [79.135.106.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86F60A3809
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B86F60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794321889; x=1794581089;
	bh=orsRB4SdYsft12+xEJaVNxxib74REtg/MP7hL7g3SzU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ZvFeDLjbEw4pWqeTCCYw72q2Nq3p5CRYVyRNTsxDDSjxe514susOPkA8YnvDt5k2L
	 Wem14nR1P1CYjCsDe3E7ad4RNCvn8dbZSeWkjrrbbNfXUyFYp5AegomdTMvKDM3OAu
	 nBAs7/wq8hHTJ6oxCq0ybBxx/ZEFB3eb/yJkdPN0YQBFfglhFaq3q0JPBityoKzBSK
	 Mrwo7WJeRLvIGyzkNjENLHj8QYPaV/Lx+MO1tGZS86UH8VbtEp8YunfuVhhZ+l5hhO
	 jAlEr9FsAHSqwk9k7HClY2euVFp8Hx63WTJNxDBQMx4Mt5vZumWhjCWNN2HVVz+b2M
	 mLhzVPeQJ9KtA==
Date: Tue, 10 Nov 2026 14:44:44 +0000
To: "Rafael J . Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: pfr_telemetry: keep the state until the last file is closed
Message-ID: <20261110144436.1529000-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: e366b8deae3080dff1d1831b66b09e3c25ff56cd
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

struct pfrt_log_device is allocated with devm_kzalloc_obj() and embeds
the miscdevice, so it is freed when the driver unbinds. A file that is
open on the node outlives the unbind and nothing holds a reference for
it: the next ioctl() or mmap() on that file uses freed memory.
Unbinding the driver needs root.

Allocate the structure with kzalloc_obj() and reference count it:
open() takes a reference, under misc_mtx, which misc_deregister() also
takes, release() drops it, and a devm action drops the driver's own.
The structure also holds a reference on the parent device it uses.

Also make remove() wait for calls already running. The firmware calls
in ioctl() and mmap() run under a mutex, and remove() sets a flag under
it that makes any later call that would reach the firmware fail with
-ENODEV. Without that, a call that started before remove() can
evaluate _DSM after remove() has returned, while device_del() unbinds
the parent's ACPI companion. The mutex also serializes the updates to
the log settings, which concurrent ioctl() calls could interleave.
ioctl() copies to and from user memory outside the lock, because mmap()
is called with mmap_lock held.

The problem was found with a Coccinelle script that reports device
nodes in devm memory [1]. The fix, the reproducers and this message
were written with an AI assistant (Claude) and checked by hand. The bug
was reproduced and the fix tested in QEMU with KASAN and lockdep, using
an SSDT whose _DSM stands in for the firmware. Hardware with this
firmware interface was not tested.

Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com =
[1]
Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry d=
river")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
Changes in v2:
- remove() now waits for calls already running, under a new mutex, which
  also serializes the log settings. Sashiko's review of v1, which Rafael
  asked me to address, showed that a call that passed the removed check
  can evaluate _DSM after remove() returns, while device_del() unbinds
  the ACPI companion. The v1 notes said such a call finishes against
  state that is still valid; that was wrong.
- kzalloc_obj(), on top of the devm_kzalloc_obj() conversion in
  linux-pm.
v1: https://lore.kernel.org/r/20261108233900.4043941-3-ca@modelmiser.com

Tested in QEMU 10.2.4 (q35, KASAN with kasan_multi_shot, lockdep) with
the SSDT from v1, which adds a device with _HID INTC1081 and a _DSM that
returns valid packages. With a file held open across a sysfs unbind,
SET_INFO, GET_INFO, GET_DATA_INFO and mmap() all work before the unbind
and fail with -ENODEV after it, a mapping made before the unbind stays
readable, the same holds after a bind, and there are no KASAN or lockdep
reports.

For the race, a test-only msleep(2000) was put before the SET_INFO
firmware call and the driver unbound 0.5 s into the call. With v1 the
unbind returned at once and the firmware call completed 1.5 s after
remove() returned. With v2 the unbind returned 2.0 s in, after the call
completed. The test used a sysfs unbind, which keeps the ACPI companion
bound; removal of the device itself was not tested.

A test variant that calls copy_to_user() inside the lock makes lockdep
report a cycle between the new lock, taken in pfrt_log_mmap(), and
mmap_lock, which is why the user copies stay outside it.

Mainline and stable still allocate with devm_kzalloc(), so a backport
needs kzalloc(sizeof(*pfrt_log_dev), GFP_KERNEL) in that hunk.

The same race exists in pfr_update; a matching patch on top of the one
you applied will follow once that is in your tree.

The code, changelog and reproducers were written with an AI assistant
(Claude Opus 5.5), and the assistant ran the tests above. I ran the
final version myself and got the same results.

 drivers/acpi/pfr_telemetry.c | 102 +++++++++++++++++++++++++++++------
 1 file changed, 86 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 458cb99ae216..53d5e25497e9 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -15,10 +15,13 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
@@ -62,6 +65,14 @@ struct pfrt_log_device {
 =09struct pfrt_log_info info;
 =09struct device *parent_dev;
 =09struct miscdevice miscdev;
+=09struct kref kref;
+=09/*
+=09 * Serializes the firmware calls and info of the file operations, and
+=09 * remove(), which sets removed under it and so waits for calls
+=09 * already running.
+=09 */
+=09struct mutex lock;
+=09bool removed;
 };
=20
 /* pfrt_guid is the parameter for _DSM method */
@@ -254,33 +265,49 @@ static long pfrt_log_ioctl(struct file *file, unsigne=
d int cmd, unsigned long ar
 =09=09if (copy_from_user(&info, p, sizeof(info)))
 =09=09=09return -EFAULT;
=20
-=09=09if (valid_log_revid(info.log_revid))
-=09=09=09pfrt_log_dev->info.log_revid =3D info.log_revid;
+=09=09scoped_guard(mutex, &pfrt_log_dev->lock) {
+=09=09=09if (pfrt_log_dev->removed)
+=09=09=09=09return -ENODEV;
=20
-=09=09if (valid_log_level(info.log_level)) {
-=09=09=09ret =3D set_pfrt_log_level(info.log_level, pfrt_log_dev);
-=09=09=09if (ret < 0)
-=09=09=09=09return ret;
+=09=09=09if (valid_log_revid(info.log_revid))
+=09=09=09=09pfrt_log_dev->info.log_revid =3D info.log_revid;
=20
-=09=09=09pfrt_log_dev->info.log_level =3D info.log_level;
-=09=09}
+=09=09=09if (valid_log_level(info.log_level)) {
+=09=09=09=09ret =3D set_pfrt_log_level(info.log_level, pfrt_log_dev);
+=09=09=09=09if (ret < 0)
+=09=09=09=09=09return ret;
+
+=09=09=09=09pfrt_log_dev->info.log_level =3D info.log_level;
+=09=09=09}
=20
-=09=09if (valid_log_type(info.log_type))
-=09=09=09pfrt_log_dev->info.log_type =3D info.log_type;
+=09=09=09if (valid_log_type(info.log_type))
+=09=09=09=09pfrt_log_dev->info.log_type =3D info.log_type;
+=09=09}
=20
 =09=09return 0;
=20
 =09case PFRT_LOG_IOC_GET_INFO:
-=09=09info.log_level =3D get_pfrt_log_level(pfrt_log_dev);
-=09=09info.log_type =3D pfrt_log_dev->info.log_type;
-=09=09info.log_revid =3D pfrt_log_dev->info.log_revid;
+=09=09scoped_guard(mutex, &pfrt_log_dev->lock) {
+=09=09=09if (pfrt_log_dev->removed)
+=09=09=09=09return -ENODEV;
+
+=09=09=09info.log_level =3D get_pfrt_log_level(pfrt_log_dev);
+=09=09=09info.log_type =3D pfrt_log_dev->info.log_type;
+=09=09=09info.log_revid =3D pfrt_log_dev->info.log_revid;
+=09=09}
+
 =09=09if (copy_to_user(p, &info, sizeof(info)))
 =09=09=09return -EFAULT;
=20
 =09=09return 0;
=20
 =09case PFRT_LOG_IOC_GET_DATA_INFO:
-=09=09ret =3D get_pfrt_log_data_info(&data_info, pfrt_log_dev);
+=09=09scoped_guard(mutex, &pfrt_log_dev->lock) {
+=09=09=09if (pfrt_log_dev->removed)
+=09=09=09=09return -ENODEV;
+
+=09=09=09ret =3D get_pfrt_log_data_info(&data_info, pfrt_log_dev);
+=09=09}
 =09=09if (ret)
 =09=09=09return ret;
=20
@@ -311,6 +338,10 @@ pfrt_log_mmap(struct file *file, struct vm_area_struct=
 *vma)
=20
 =09pfrt_log_dev =3D to_pfrt_log_dev(file);
=20
+=09guard(mutex)(&pfrt_log_dev->lock);
+=09if (pfrt_log_dev->removed)
+=09=09return -ENODEV;
+
 =09ret =3D get_pfrt_log_data_info(&info, pfrt_log_dev);
 =09if (ret)
 =09=09return ret;
@@ -337,8 +368,39 @@ pfrt_log_mmap(struct file *file, struct vm_area_struct=
 *vma)
 =09return 0;
 }
=20
+static void pfrt_log_free(struct kref *kref)
+{
+=09struct pfrt_log_device *pfrt_log_dev =3D
+=09=09container_of(kref, struct pfrt_log_device, kref);
+
+=09put_device(pfrt_log_dev->parent_dev);
+=09kfree(pfrt_log_dev);
+}
+
+static void pfrt_log_put(void *data)
+{
+=09struct pfrt_log_device *pfrt_log_dev =3D data;
+
+=09kref_put(&pfrt_log_dev->kref, pfrt_log_free);
+}
+
+/* misc_open() holds misc_mtx here, and misc_deregister() takes it. */
+static int pfrt_log_open(struct inode *inode, struct file *file)
+{
+=09kref_get(&to_pfrt_log_dev(file)->kref);
+=09return 0;
+}
+
+static int pfrt_log_release(struct inode *inode, struct file *file)
+{
+=09pfrt_log_put(to_pfrt_log_dev(file));
+=09return 0;
+}
+
 static const struct file_operations acpi_pfrt_log_fops =3D {
 =09.owner=09=09=3D THIS_MODULE,
+=09.open=09=09=3D pfrt_log_open,
+=09.release=09=3D pfrt_log_release,
 =09.mmap=09=09=3D pfrt_log_mmap,
 =09.unlocked_ioctl =3D pfrt_log_ioctl,
 =09.llseek=09=09=3D noop_llseek,
@@ -349,6 +411,8 @@ static void acpi_pfrt_log_remove(struct platform_device=
 *pdev)
 =09struct pfrt_log_device *pfrt_log_dev =3D platform_get_drvdata(pdev);
=20
 =09misc_deregister(&pfrt_log_dev->miscdev);
+=09scoped_guard(mutex, &pfrt_log_dev->lock)
+=09=09pfrt_log_dev->removed =3D true;
 }
=20
 static void pfrt_log_put_idx(void *data)
@@ -373,10 +437,17 @@ static int acpi_pfrt_log_probe(struct platform_device=
 *pdev)
 =09=09return -ENODEV;
 =09}
=20
-=09pfrt_log_dev =3D devm_kzalloc_obj(&pdev->dev, *pfrt_log_dev);
+=09pfrt_log_dev =3D kzalloc_obj(*pfrt_log_dev);
 =09if (!pfrt_log_dev)
 =09=09return -ENOMEM;
=20
+=09kref_init(&pfrt_log_dev->kref);
+=09mutex_init(&pfrt_log_dev->lock);
+=09pfrt_log_dev->parent_dev =3D get_device(&pdev->dev);
+=09ret =3D devm_add_action_or_reset(&pdev->dev, pfrt_log_put, pfrt_log_dev=
);
+=09if (ret)
+=09=09return ret;
+
 =09ret =3D ida_alloc(&pfrt_log_ida, GFP_KERNEL);
 =09if (ret < 0)
 =09=09return ret;
@@ -387,7 +458,6 @@ static int acpi_pfrt_log_probe(struct platform_device *=
pdev)
 =09=09return ret;
=20
 =09pfrt_log_dev->info.log_revid =3D PFRT_DEFAULT_REV_ID;
-=09pfrt_log_dev->parent_dev =3D &pdev->dev;
=20
 =09pfrt_log_dev->miscdev.minor =3D MISC_DYNAMIC_MINOR;
 =09pfrt_log_dev->miscdev.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
--=20
2.43.0


