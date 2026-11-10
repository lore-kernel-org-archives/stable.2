Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325607;
	b=Dx3yTkT/QBM9iBea5OL2BW5dxER+KbGACX5HywrdHuWchAIjDI9uF1s7LbkSxjCAHtUV
	 sZPhO7u3/HD7bXL6sxtZOedx2fmmwhGvFxyQpQANEQWlz4ZAKn9gj83LRnJ3Y2oEMqJJg
	 fN+cy2ecPO3RduQFQN+QfmXyGhOFBLHYlBz/0dWfCDMxI7qKF5g9q/+FRFxxeriGs1gqJ
	 TS+pX5YiT5bxzcBkg5HsnKeYI5Vkb96rHqTU1OicwJ35Y4D6T9YnJh1MOqzEmi8B8pJA5
	 ls0t8MAeaq+XIX2vbDNN5Enj5g3b7EISqli4h/W3up1zZg63dbiPZKiPsGjJWlTS2XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325607;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PmoTeMGcRydL+CuXDseRwo7IraY8l21M96KHRwenzQ0=;
	b=ZSQCaQCXOifb9gdFg7VLgj7fPNy6cygHN8+FHDIyAd2MNkdD9zs7WAKlxi4Iu+Tb02Tm
	 P/CoTuapNv25YzXlTk/ALmQjDPpSulDCEQbBA8BMortDkyAnA4zf1CZGZ88msaIvoFlah
	 1GOheR/3tE9jbKhScF9cDqB0uaJt3zydNEjglnSylm4PV9EXQaGD7yABEib1fmqLZXuGx
	 LWZz9lgq6fTadZWmdLPteEzTHBJvpA18MvjyYeHawUy68AwPJyBtVD0ZqSvH3sjaU8nLK
	 BeDEQG9A3c0DbtskWcdYYwOghkVNkSwd5lElD+ch7S2+LzMCPjhc8zGijp0RakJ3I0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Y+qHeUWe;
	arc=none smtp.remote-ip=109.224.244.20
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD42606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Y+qHeUWe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794325603; x=1794584803;
	bh=PmoTeMGcRydL+CuXDseRwo7IraY8l21M96KHRwenzQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y+qHeUWeYfMY1AxPBBUYwMMymff1xpBs/ddOqmk/zQPphspY8UAajXARGPTbTQOV6
	 CjlmfVlG0BGnbqxlmpwAsQSe8EH2j7tRmdn2wH5imkArfuXwRIJJ9+iIf9zrkmxOoa
	 qBtwFZlD5OXlCMNowQKAFUO2i19lGzY0/5yT657id7bipST+5Zsp8A+ek5ujYAit9g
	 /WD9FQ6z8gkBRhmwx6S19DpfUVzsIVQN639hFRWldNzseumGkX7M288l0jZmM2XF3L
	 Qa1NLk2OwdP6k1BvyIrRsjz/It7vjxtR610cWKMj455QDJo5gvrifN6SZqzTVnRQgb
	 5Yq01vwOGNt1A==
Date: Tue, 10 Nov 2026 15:46:37 +0000
To: "Rafael J . Wysocki" <rafael@kernel.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: pfr_update: wait for running calls in remove()
Message-ID: <20261110154630.1550730-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: b8b3eb53ed414af11f22044608f58fd7a00f7cc3
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

Commit dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last
file is closed") makes ioctl() and write() fail with -ENODEV once
remove() has run, but a call that started before remove() keeps running
after it returns. Such a call can evaluate _DSM while device_del()
unbinds the parent's ACPI companion, and after an unbind and bind it
acts on the firmware behind the new instance's back. Its message says
such a call "finishes against state that is still valid"; that was
wrong.

Run the firmware calls of ioctl() and write() under a new mutex, and set
the removed flag under it in remove(), so that remove() waits for calls
already running. The mutex also serializes rev_id and the use of the
shared communication buffer, which concurrent calls on different files
could interleave. User memory is copied outside the lock, so a page
fault that does not complete cannot hold up remove(): write() now copies
the capsule into a kernel buffer first, and a fault there returns
-EFAULT rather than -EINVAL. It queries the buffer again once it holds
the lock, since SET_REV may have run in between. An unbind during a
capsule stage or activation waits for it to finish, rather than
returning with the update still in progress.

The race was pointed out by Sashiko's review of the matching
pfr_telemetry patch [1]. The fix and this message were written with an
AI assistant (Claude) and checked by hand, and tested in QEMU with
KASAN and lockdep, using an SSDT whose _DSM stands in for the firmware.
Hardware with this firmware interface was not tested.

Link: https://sashiko.dev/#/patchset/20261108233900.4043941-3-ca%40modelmis=
er.com [1]
Fixes: dacb7cef6f32 ("ACPI: pfr_update: keep the state until the last file =
is closed")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
This goes on top of commit dacb7cef6f32 in linux-pm, which Rafael
applied for 7.5. The matching pfr_telemetry change is in v2 of that
patch:
https://lore.kernel.org/r/20261110144436.1529000-2-ca@modelmiser.com

As in pfr_telemetry, user memory is copied outside the lock. For
write() that means a kernel copy of the capsule, of up to the firmware
buffer size, so a slow or stalled user fault no longer holds the lock.

Tested as for the pfr_telemetry v2 patch, with the SSDT device _HID
INTC1080. QUERY_CAP, SET_REV, write() of a minimal capsule and STAGE
work before a sysfs unbind and fail with -ENODEV after it on a file
held open, the same holds after a bind, and there are no KASAN or
lockdep reports. With a test-only msleep(2000) before the QUERY_CAP
firmware call and the driver unbound 0.5 s into the call, the unbind
returned at once without this patch and the firmware call completed
1.5 s after remove() returned; with it the unbind returned 2.0 s in,
after the call completed. ACTIVATE and STAGE_ACTIVATE were not run,
and neither was removal of the device itself.

The code, changelog and reproducers were written with an AI assistant
(Claude Opus 5.5), and the assistant ran the tests above. I ran the
final version myself and got the same results.

 drivers/acpi/pfr_update.c | 86 ++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 797956d9defb..73cde535b34b 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -19,11 +19,11 @@
 #include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/uio.h>
 #include <linux/uuid.h>
=20
 #include <uapi/linux/pfrut.h>
@@ -85,6 +85,12 @@ struct pfru_device {
 =09struct device *parent_dev;
 =09struct miscdevice miscdev;
 =09struct kref kref;
+=09/*
+=09 * Serializes the firmware calls, rev_id and the communication buffer
+=09 * of the file operations, and remove(), which sets removed under it
+=09 * and so waits for calls already running.
+=09 */
+=09struct mutex lock;
 =09bool removed;
 };
=20
@@ -424,6 +430,15 @@ static int start_update(int action, struct pfru_device=
 *pfru_dev)
 =09return ret;
 }
=20
+static int pfru_start_update(int action, struct pfru_device *pfru_dev)
+{
+=09guard(mutex)(&pfru_dev->lock);
+=09if (pfru_dev->removed)
+=09=09return -ENODEV;
+
+=09return start_update(action, pfru_dev);
+}
+
 static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long =
arg)
 {
 =09struct pfru_update_cap_info cap_hdr =3D {};
@@ -432,12 +447,14 @@ static long pfru_ioctl(struct file *file, unsigned in=
t cmd, unsigned long arg)
 =09u32 rev;
 =09int ret;
=20
-=09if (READ_ONCE(pfru_dev->removed))
-=09=09return -ENODEV;
-
 =09switch (cmd) {
 =09case PFRU_IOC_QUERY_CAP:
-=09=09ret =3D query_capability(&cap_hdr, pfru_dev);
+=09=09scoped_guard(mutex, &pfru_dev->lock) {
+=09=09=09if (pfru_dev->removed)
+=09=09=09=09return -ENODEV;
+
+=09=09=09ret =3D query_capability(&cap_hdr, pfru_dev);
+=09=09}
 =09=09if (ret)
 =09=09=09return ret;
=20
@@ -453,18 +470,23 @@ static long pfru_ioctl(struct file *file, unsigned in=
t cmd, unsigned long arg)
 =09=09if (!pfru_valid_revid(rev))
 =09=09=09return -EINVAL;
=20
-=09=09pfru_dev->rev_id =3D rev;
+=09=09scoped_guard(mutex, &pfru_dev->lock) {
+=09=09=09if (pfru_dev->removed)
+=09=09=09=09return -ENODEV;
+
+=09=09=09pfru_dev->rev_id =3D rev;
+=09=09}
=20
 =09=09return 0;
=20
 =09case PFRU_IOC_STAGE:
-=09=09return start_update(START_STAGE, pfru_dev);
+=09=09return pfru_start_update(START_STAGE, pfru_dev);
=20
 =09case PFRU_IOC_ACTIVATE:
-=09=09return start_update(START_ACTIVATE, pfru_dev);
+=09=09return pfru_start_update(START_ACTIVATE, pfru_dev);
=20
 =09case PFRU_IOC_STAGE_ACTIVATE:
-=09=09return start_update(START_STAGE_ACTIVATE, pfru_dev);
+=09=09return pfru_start_update(START_STAGE_ACTIVATE, pfru_dev);
=20
 =09default:
 =09=09return -ENOTTY;
@@ -478,14 +500,33 @@ static ssize_t pfru_write(struct file *file, const ch=
ar __user *buf,
 =09struct pfru_update_cap_info cap;
 =09struct pfru_com_buf_info buf_info;
 =09phys_addr_t phy_addr;
-=09struct iov_iter iter;
-=09struct iovec iov;
 =09char *buf_ptr;
 =09int ret;
=20
-=09if (READ_ONCE(pfru_dev->removed))
+=09scoped_guard(mutex, &pfru_dev->lock) {
+=09=09if (pfru_dev->removed)
+=09=09=09return -ENODEV;
+
+=09=09ret =3D query_buffer(&buf_info, pfru_dev);
+=09}
+=09if (ret)
+=09=09return ret;
+
+=09if (len > buf_info.buf_size) {
+=09=09dev_dbg(pfru_dev->parent_dev, "Capsule image size too large\n");
+=09=09return -EINVAL;
+=09}
+
+=09/* Copy from the user outside the lock, which remove() waits for */
+=09void *data __free(kvfree) =3D vmemdup_user(buf, len);
+=09if (IS_ERR(data))
+=09=09return PTR_ERR(data);
+
+=09guard(mutex)(&pfru_dev->lock);
+=09if (pfru_dev->removed)
 =09=09return -ENODEV;
=20
+=09/* Query again: SET_REV may have run while the lock was dropped */
 =09ret =3D query_buffer(&buf_info, pfru_dev);
 =09if (ret)
 =09=09return ret;
@@ -495,10 +536,6 @@ static ssize_t pfru_write(struct file *file, const cha=
r __user *buf,
 =09=09return -EINVAL;
 =09}
=20
-=09iov.iov_base =3D (void __user *)buf;
-=09iov.iov_len =3D len;
-=09iov_iter_init(&iter, ITER_SOURCE, &iov, 1, len);
-
 =09/* map the communication buffer */
 =09phy_addr =3D (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo)=
;
 =09buf_ptr =3D memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
@@ -507,22 +544,13 @@ static ssize_t pfru_write(struct file *file, const ch=
ar __user *buf,
 =09=09return -ENOMEM;
 =09}
=20
-=09if (!copy_from_iter_full(buf_ptr, len, &iter)) {
-=09=09dev_dbg(pfru_dev->parent_dev,
-=09=09=09"Failed to copy the data from the user space buffer\n");
-=09=09ret =3D -EINVAL;
-=09=09goto unmap;
-=09}
+=09memcpy(buf_ptr, data, len);
=20
 =09/* check if the capsule header has a valid version number */
 =09ret =3D query_capability(&cap, pfru_dev);
-=09if (ret)
-=09=09goto unmap;
-
-=09if (!applicable_image(buf_ptr, &cap, pfru_dev))
+=09if (!ret && !applicable_image(buf_ptr, &cap, pfru_dev))
 =09=09ret =3D -EINVAL;
=20
-unmap:
 =09memunmap(buf_ptr);
=20
 =09return ret ?: len;
@@ -571,7 +599,8 @@ static void acpi_pfru_remove(struct platform_device *pd=
ev)
 =09struct pfru_device *pfru_dev =3D platform_get_drvdata(pdev);
=20
 =09misc_deregister(&pfru_dev->miscdev);
-=09WRITE_ONCE(pfru_dev->removed, true);
+=09scoped_guard(mutex, &pfru_dev->lock)
+=09=09pfru_dev->removed =3D true;
 }
=20
 static void pfru_put_idx(void *data)
@@ -601,6 +630,7 @@ static int acpi_pfru_probe(struct platform_device *pdev=
)
 =09=09return -ENOMEM;
=20
 =09kref_init(&pfru_dev->kref);
+=09mutex_init(&pfru_dev->lock);
 =09pfru_dev->parent_dev =3D get_device(&pdev->dev);
 =09ret =3D devm_add_action_or_reset(&pdev->dev, pfru_put, pfru_dev);
 =09if (ret)
--=20
2.43.0


