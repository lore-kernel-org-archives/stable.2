Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181158;
	b=tYEVTOTlFFsBvpP6UCJTp/rsuadDidfANVL/ctUxY2BSa1BZk1JoNu+Zv6JhKO5Tw6o9
	 FOfNfLYpJs+KHgGA/6+oK1C9ag2pwtnhLG8pEAzElMlcD37UxDejfII6X/cOmE4PkA1AB
	 q//SCO1Q5dRryBSxXWy5UEOr1c44KyQP0xcDqNTItWewJpyxhNyinkWce19tRiWWadECH
	 /5X5UR+Ld4zpkcrqNGJ9F74Qu9T38k2gYQpH+b1tGDEIPo9biUb8FtuOcb/yNgz4nWMGO
	 8TQI5grsfAnf2p42IYQgM6DdZTThhh6TVaPefa8gV08LvLruJQ71rzZlAzjiCyQDTiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181158;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ir3LIg5xY40r450i57J61cS++CiSUUAMG8r460r1ElE=;
	b=sybEab7SCZq2U4iAYQztdEbpFIkx4Xu1dqjsAfBF/jVRxnGF6/+7zeDVUmhLAy4Rb+Os
	 IMgG57mEIWj8UHSGwzPGAYu2Hy/7V4gEymt9qyjvOxYxjsQchtJcsOt/AD5iCGSOi4GPN
	 Tc045S6PsU25vtu6S42AMuEEA1ex8vhQFoUiYbOgC6L3Kj/TBspPDETEwPKk+sCK/ibOG
	 nMPTKgQPLqO+Jth3vdSVwhHKXMxNC4cFoH8/BeywtY9C6P1SO+RNxJ+Ne41ZsCNF576IS
	 qjcuk/JJDbnY/rm0jY8H/WgcMJKLgVh24JuFmxZ+mvDJNJM0GJM53ai4QbFnYqr7YgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b="TT5C/KAx";
	arc=none smtp.remote-ip=109.224.244.117
Received: from mail-244117.protonmail.ch (mail-244117.protonmail.ch [109.224.244.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D277606A320;
	Sun,  8 Nov 2026 23:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D277606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=TT5C/KAx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794181152; x=1794440352;
	bh=Ir3LIg5xY40r450i57J61cS++CiSUUAMG8r460r1ElE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TT5C/KAxygt1mMOtcOxLUZAKJGyE5SRFga6WAtgwLwp7O7UP+rE2kFgQZaWeD50R8
	 bU9ujX+baU+wU7tc3F5S9N8sSmejStBI2/e9CPq4RTNGbKUTklHx1qGI83znRQdefM
	 UUEYTTGihenrwIVX0Guc+9vaY/Fp+EoB45E7xO9JBAQFV2//iDxzVIslQK0Vr/5AOr
	 cO30syyhCeL/kqGtD5ZH9arOnrEZPxf+kzcQBeVJ2K8amrMZ9xEYke1U5nFpEoXDUQ
	 gtcHczAf4NgKA/p4XtWn++44A2Kl90VZKO4uHTXlSDcBL5GIj8QSnJ4Pd0KYh6KJFp
	 fn6a6W9d4wMNA==
Date: Sun, 08 Nov 2026 23:39:06 +0000
To: "Rafael J . Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: pfr_telemetry: keep the state until the last file is closed
Message-ID: <20261108233900.4043941-3-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 318ef2ea009b2e267e14cbe7369708688f707be8
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

struct pfrt_log_device is allocated with devm_kzalloc() and embeds the
miscdevice, so it is freed when the driver unbinds. A file that is open
on the node outlives the unbind and nothing holds a reference for it:
the next ioctl() or mmap() on that file uses freed memory. Unbinding the
driver needs root.

Allocate the structure with kzalloc() and reference count it: open()
takes a reference, under misc_mtx, which misc_deregister() also takes,
release() drops it, and a devm action drops the driver's own. The
structure also holds a reference on the parent device it uses. A call to
ioctl() or mmap() that starts after remove() returns fails with -ENODEV;
one already running finishes against state that is still valid.

The problem was found with a Coccinelle script that reports device nodes
in devm memory [1]. The fix, the reproducer and this message were
written with an AI assistant (Claude) and checked by hand. The bug was
reproduced and the fix tested in QEMU with KASAN, using an SSDT whose
_DSM stands in for the firmware: ioctl() and mmap() worked before an
unbind and, on a file held open across it, failed with -ENODEV. A call
racing with the unbind was not tested, nor was hardware with this
firmware interface.

Link: https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com =
[1]
Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry d=
river")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
The Coccinelle script reports a devm_k*() allocation when it, or an
address inside it, is passed to misc_register() or a similar
registration function in the same function, or when the allocated struct
embeds such an object. It reports this driver for the misc_register() of
&pfrt_log_dev->miscdev.

Reproduced in QEMU 10.2.4 (q35, KASAN, booted with kasan_multi_shot). An
SSDT adds a device with _HID INTC1081 and a _DSM that returns valid
packages, and memmap=3D reserves memory for the log buffer. A process
opens /dev/acpi_pfr_telemetry0, uses SET_INFO, GET_INFO, GET_DATA_INFO
and mmap(), and unbinds the driver through sysfs with the file open.
Repeating those calls gives, without this patch, 15 KASAN reports in
pfrt_log_ioctl(), set_pfrt_log_level() and get_pfrt_log_data_info().

With it there are none. All the calls succeed before the unbind and
return -ENODEV after it, a mapping made before the unbind was still
readable after it, and the same sequence behaves the same after a bind.
Unbinding with the file already closed, or never opened, gives no
reports either.

No lock is added. A call that passed the removed check can run during
the unbind, against state and a parent device that are still valid; the
driver has never serialized calls from different files. Mappings of
the firmware log buffer outlive the unbind, as they did before.

kzalloc() rather than kzalloc_obj(), which first appears in v7.0, for
the stable trees.

 drivers/acpi/pfr_telemetry.c | 55 +++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 2387376832a1..5ab8baabcc60 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -15,10 +15,12 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
@@ -62,6 +64,8 @@ struct pfrt_log_device {
 =09struct pfrt_log_info info;
 =09struct device *parent_dev;
 =09struct miscdevice miscdev;
+=09struct kref kref;
+=09bool removed;
 };
=20
 /* pfrt_guid is the parameter for _DSM method */
@@ -247,6 +251,9 @@ static long pfrt_log_ioctl(struct file *file, unsigned =
int cmd, unsigned long ar
 =09void __user *p;
 =09int ret =3D 0;
=20
+=09if (READ_ONCE(pfrt_log_dev->removed))
+=09=09return -ENODEV;
+
 =09p =3D (void __user *)arg;
=20
 =09switch (cmd) {
@@ -303,14 +310,17 @@ pfrt_log_mmap(struct file *file, struct vm_area_struc=
t *vma)
 =09phys_addr_t base_addr;
 =09int ret;
=20
+=09pfrt_log_dev =3D to_pfrt_log_dev(file);
+
+=09if (READ_ONCE(pfrt_log_dev->removed))
+=09=09return -ENODEV;
+
 =09if (vma->vm_flags & VM_WRITE)
 =09=09return -EROFS;
=20
 =09/* changing from read to write with mprotect is not allowed */
 =09vm_flags_clear(vma, VM_MAYWRITE);
=20
-=09pfrt_log_dev =3D to_pfrt_log_dev(file);
-
 =09ret =3D get_pfrt_log_data_info(&info, pfrt_log_dev);
 =09if (ret)
 =09=09return ret;
@@ -337,8 +347,39 @@ pfrt_log_mmap(struct file *file, struct vm_area_struct=
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
@@ -349,6 +390,7 @@ static void acpi_pfrt_log_remove(struct platform_device=
 *pdev)
 =09struct pfrt_log_device *pfrt_log_dev =3D platform_get_drvdata(pdev);
=20
 =09misc_deregister(&pfrt_log_dev->miscdev);
+=09WRITE_ONCE(pfrt_log_dev->removed, true);
 }
=20
 static void pfrt_log_put_idx(void *data)
@@ -373,10 +415,16 @@ static int acpi_pfrt_log_probe(struct platform_device=
 *pdev)
 =09=09return -ENODEV;
 =09}
=20
-=09pfrt_log_dev =3D devm_kzalloc(&pdev->dev, sizeof(*pfrt_log_dev), GFP_KE=
RNEL);
+=09pfrt_log_dev =3D kzalloc(sizeof(*pfrt_log_dev), GFP_KERNEL);
 =09if (!pfrt_log_dev)
 =09=09return -ENOMEM;
=20
+=09kref_init(&pfrt_log_dev->kref);
+=09pfrt_log_dev->parent_dev =3D get_device(&pdev->dev);
+=09ret =3D devm_add_action_or_reset(&pdev->dev, pfrt_log_put, pfrt_log_dev=
);
+=09if (ret)
+=09=09return ret;
+
 =09ret =3D ida_alloc(&pfrt_log_ida, GFP_KERNEL);
 =09if (ret < 0)
 =09=09return ret;
@@ -387,7 +435,6 @@ static int acpi_pfrt_log_probe(struct platform_device *=
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


