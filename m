Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794051889;
	b=fVYv4nRdjMXnuJHki0XXbfB/s+zQVpGBwFWKUn+cS5zkoW/ebRrJMuriTvPU46C32jw6
	 HRMgtSUnmcV18M7Sz6X3gOAPkPyMz2gLXq/JfqzFsfacXe3hFMAgdYz6RWowKpClb/9sm
	 4Adlv/4niqsIfL1kKtPtCaxvZuT60sQ0I6IE/J3kWQb0McoIA8cVyp/gTUIUyg4p3vnga
	 LznelnpgQqkFZcBoiepYZZNh72Ud7YN/Uf3XibB1CgCIsOl3my9CsO7adDZHVo53ubg6W
	 qrzWLXwhmxB6q9TqDCsYCUVbBXuyTL0ACtBnZ67Lu3yjO5EDc4qUpbVBanKPwLRIzwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794051889;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Zf+BVk2Z86Q58X6FcAUkm/qDaltz/E03jFDJwzdCkU4=;
	b=s215vITXjHSc+CsU91ysrr33b2DxvyspHDan6+RTHZ8DiMhJ2SPm5doidnoBoEj3buRB
	 opqRido2ei4WLSdYITINFjxkueqdm35Ox3l54TWDncBpvLHCwGCVksxzLuIbGuhbnL9T8
	 5NfEwhhULV6w3ymNRNz1YJhhvlk6pF8zArVzro9lqhP5tuGyP5QgAe4m2gYTmjLgDuxhD
	 ilVkshTJ0wNGXSqaAcb8WJnYG0meUmORwSBsNjseuE9xN0pZ/2qbHkFFkM0H6OqDIRjcX
	 etREhhxWMwINdcS5ZDg1SENRr01+OMLPet6aF0SJ9xmzlm5ASn4wrvgzLWr6k9v+8Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=F46ERj2m;
	arc=none smtp.remote-ip=109.224.244.22
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90141606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90141606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=F46ERj2m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794051885; x=1794311085;
	bh=Zf+BVk2Z86Q58X6FcAUkm/qDaltz/E03jFDJwzdCkU4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=F46ERj2mDoAudpaThUpr3/9ooOJr+3Oa9iAny2JcMPSpBwm4JtPvLZZo0neLGl9uV
	 vJT+PDcOO5EXi1OsxuPJJaSeKBFFRtCjcTseXyxcuQqVt/wuot7jx4VdWeM2caq+CG
	 TVmj60gWlrhFcsAAqmZ4MvRT3qENWSwhZiyZDOuizFHmPWrqL0Rfrtx6Ke7nQiD9zm
	 2mDrDijoEYjGDFogu7mGhU2Ce8pbd0R6NjfeMF4Yvv1g1WTDMlY74PR4sOC/siOxab
	 md6jQsT3LzklUG2yEhCA5m3nIwEHsTt3kjVTzA6pa9wZqV6Cb/ouFay/Aoo24aVLJ4
	 D9bK+WbmqKVwQ==
Date: Sat, 07 Nov 2026 11:44:39 +0000
To: Alexander Graf <graf@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
From: Chad Aldreda <ca@modelmiser.com>
Cc: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, Yuho Choi <oss.patchbox@gmail.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: nsm: keep the device state until the last file is closed
Message-ID: <20261107114433.3789830-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 626f0bb3e64df8ebbf38e6769bb159440913e4bf
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

nsm_device_probe() allocates struct nsm with devm_kzalloc(), so it is
freed when the device is removed, but an open /dev/nsm keeps using it
through file->private_data. When the virtio device is removed while the
file is open, for example by a hot-unplug, the next NSM_IOCTL_RAW runs
on the freed struct nsm and queues buffers on the virtqueue that
remove() deleted. KASAN reports a slab-use-after-free in
virtqueue_add_outbuf(), called from nsm_sendrecv_msg_locked().

Allocate struct nsm with kzalloc() and free it on the last reference:
open() takes a reference and release() drops it, and remove() drops the
device's own reference after misc_deregister(). misc_open() calls
open() with misc_mtx held, and misc_deregister() takes misc_mtx before
remove() drops that reference, so open() always runs while the device's
reference is held.

remove() now marks the device as removed and deletes the virtqueue with
nsm->lock held, so a later NSM_IOCTL_RAW fails with -ENODEV once its
argument struct has been copied in. To take the lock, remove() waits for
an ioctl already in progress, which before this patch could still be
using the virtqueue while it was deleted. That wait has no fixed bound
while the ioctl copies to or from user memory. If the device was
surprise-removed while handling the request, it lasts up to
NSM_DEFAULT_TIMEOUT_MSECS (two minutes), after the existing wait in
hwrng_unregister().

Fixes: b9873755a6c8 ("misc: Add Nitro Secure Module driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
Reproduced in QEMU 10.2.4 with a virtio-nsm-pci device on a PCIe root
port. A guest process opens /dev/nsm, the device is removed with
device_del from the QEMU monitor, and the process then issues
NSM_IOCTL_RAW. Without this patch KASAN reports the use-after-free of
the virtqueue; with it the ioctl returns -ENODEV and KASAN reports
nothing. Not tested on Nitro hardware. (QEMU needs module-id=3D set on
the device, or it aborts when the device is unplugged.)

Yuho Choi's pending "misc: nsm: reset device before deleting the
virtqueue on removal" (2026-10-16) changes the same function. The
reproducer also hits the WARN_ON_ONCE() in virtio_dev_remove() that
patch fixes, the check commented "Driver should have reset device". The
two patches are independent. If that one is applied first I can rebase
on it; the reset would then go inside the locked section, before
del_vqs().

kzalloc() is used rather than kzalloc_obj() so that the fix applies to
stable kernels before v7.0.

Not done here: waking a request that waits on a broken virtqueue, so a
surprise removal does not wait out the full timeout, and copying user
buffers outside nsm->lock.

 drivers/misc/nsm.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index b6d3fa79a5e8..08c0997fb308 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/hw_random.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -55,6 +56,8 @@ struct nsm {
 =09struct miscdevice     misc;
 =09struct hwrng          hwrng;
 =09struct work_struct    misc_init;
+=09struct kref           kref;
+=09bool                  removed;=09/* protected by lock */
 =09struct nsm_msg        msg;
 };
=20
@@ -372,6 +375,12 @@ static long nsm_dev_ioctl(struct file *file, unsigned =
int cmd,
=20
 =09mutex_lock(&nsm->lock);
=20
+=09/* The device may have been removed while the file was open */
+=09if (nsm->removed) {
+=09=09r =3D -ENODEV;
+=09=09goto out;
+=09}
+
 =09/* Convert kernel argument struct to device request */
 =09r =3D fill_req_raw(nsm, &nsm->msg.req, &raw);
 =09if (r)
@@ -413,8 +422,31 @@ static int nsm_device_init_vq(struct virtio_device *vd=
ev)
 =09return 0;
 }
=20
+static void nsm_free(struct kref *kref)
+{
+=09kfree(container_of(kref, struct nsm, kref));
+}
+
+/*
+ * misc_open() calls this under misc_mtx, which misc_deregister() also tak=
es,
+ * so the device's own reference is still held here.
+ */
+static int nsm_dev_open(struct inode *inode, struct file *file)
+{
+=09kref_get(&file_to_nsm(file)->kref);
+=09return 0;
+}
+
+static int nsm_dev_release(struct inode *inode, struct file *file)
+{
+=09kref_put(&file_to_nsm(file)->kref, nsm_free);
+=09return 0;
+}
+
 static const struct file_operations nsm_dev_fops =3D {
 =09.owner =3D THIS_MODULE,
+=09.open =3D nsm_dev_open,
+=09.release =3D nsm_dev_release,
 =09.unlocked_ioctl =3D nsm_dev_ioctl,
 =09.compat_ioctl =3D compat_ptr_ioctl,
 };
@@ -426,10 +458,12 @@ static int nsm_device_probe(struct virtio_device *vde=
v)
 =09struct nsm *nsm;
 =09int rc;
=20
-=09nsm =3D devm_kzalloc(&vdev->dev, sizeof(*nsm), GFP_KERNEL);
+=09nsm =3D kzalloc(sizeof(*nsm), GFP_KERNEL);
 =09if (!nsm)
 =09=09return -ENOMEM;
=20
+=09kref_init(&nsm->kref);
+
 =09vdev->priv =3D nsm;
 =09nsm->vdev =3D vdev;
=20
@@ -478,6 +512,7 @@ static int nsm_device_probe(struct virtio_device *vdev)
 =09virtio_reset_device(vdev);
 =09vdev->config->del_vqs(vdev);
 err_init_vq:
+=09kfree(nsm);
 =09return rc;
 }
=20
@@ -488,8 +523,14 @@ static void nsm_device_remove(struct virtio_device *vd=
ev)
=20
 =09hwrng_unregister(&nsm->hwrng);
=20
+=09/* Wait for an ioctl in progress, and fail later ones */
+=09mutex_lock(&nsm->lock);
+=09nsm->removed =3D true;
 =09vdev->config->del_vqs(vdev);
+=09mutex_unlock(&nsm->lock);
+
 =09misc_deregister(&nsm->misc);
+=09kref_put(&nsm->kref, nsm_free);
 }
=20
 /* NSM device configuration structure */

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
--=20
2.43.0


