Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063839;
	b=ng9QGZzXDglfhVWXuRHSudstGyFvShyLqmlbtOG/V3r/o3RqFvxxVyGhqluXhhQxyjhi
	 OB4DSZF0cdn1HWpFf/uWfYrXYl4l/M3JWD9QfDr3Yj4EJE6hUCtNxTtwdM5jE4NL5BISI
	 d1Ff4VNbHp9glF0v26pU1O8mNmTzF5kNj5zUvTA3Q16Khj4yoVM5qyB77yN4VWTRlhGA+
	 rv9PdHfzH4WFTN+yqJyeA28pHzYxX2mXpIex2rTV1cmmjh1anBYBv2xsqDYnSlshy6I16
	 MZgyBDdYEv0fr++tLz3U34rOZW/scLab2sdKsjluhU8UL5EsiGBj1h26NeHSzP3yKqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063839;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=S7wjg0WD4LA1dm1m1FvlqHYTflLz0l5QlrziM212jzA=;
	b=a2Ebr7CTFg/JD1a3rzIj5nTSkMMRxkPALCbLDGIRkNjWjEblTA5x/zAmcTUb2+b56MUK
	 VCjd1v+ec0nzrWeF+L6wcaWzu9yv9Wy+P6eFAuUPcoxxS24JPaNTzAkg7zcxpn0lVk/ob
	 Sz74N7Se+lJ7pqWcNdcsv/wve2s3In9cbbfwsaeOsANl3Pd4Y1NkqjmCyAhPIH4yA8X2Y
	 LwF0bfEciSypkcd7tXpeeKH2Q9pTrt7Zh8aq39qoPKb5B7ruwpVzyF28eaHWZ8Nvlig/Y
	 Q/unKkTcSgv55HLfW8+BF3fi/y07xjd5lACFOGc/CaZE7bjQSocMZw2bi2nQupiCPKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Q3ZCxG0T;
	arc=none smtp.remote-ip=185.70.43.98
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3060A6F45;
	Sat,  7 Nov 2026 15:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C3060A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=Q3ZCxG0T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794063835; x=1794323035;
	bh=S7wjg0WD4LA1dm1m1FvlqHYTflLz0l5QlrziM212jzA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Q3ZCxG0TmbWSeIVKzXXvjC3axOUm4lvoXneIvsoW34yC5fz3gPZe8nOFn2cuJt7Oy
	 Oh8RlCYNY84hpthJcbICEQy6oJXF+/tmHbHRwocVMkfb6FR+189RMCoqVnlzE46oNo
	 /5e3IvaokkkLlPo2g4+bDcqZ63kumEHqEBRlbeLGrIlOpuPsZtqEIBLXRrjk19hNCN
	 7ZGEJdjXF9nevF593xJOJL4vPpTxN5MOsGOXDBxdUba0VMK3OQK2f9KC2qyQeX1OJc
	 vKy/dYkVsSWrcRt6rdg3Ok9L3ZrG3EdVhsDiW0vN2dQgrBbA1woOFZ8hTqwt5thhEP
	 +Ze2ptPSiP2Rw==
Date: Sat, 07 Nov 2026 15:03:51 +0000
To: Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] ptp: vmclock: keep the device state until the last file is closed
Message-ID: <20261107150344.3946529-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: cc0699730300967d53e34b59b74e26bbcd1297c3
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

vmclock_probe() allocates struct vmclock_state with devm_kzalloc() and
maps the shared page with devm_memremap(), so both are released when
the driver is unbound, but an open /dev/vmclockN keeps using them
through its file state. After an unbind, read() runs on the freed
struct and reads through the released mapping, and a poll() in
progress sleeps on a wait queue in the freed struct. KASAN reports a
slab-use-after-free in vmclock_miscdev_read(). In testing, the same
read() faulted on the unmapped page once the device had been bound
again.

Allocate the state with kzalloc_obj() and map the page with memremap(),
and release both on the last reference: open() takes a reference and
release() drops it, and a devm action drops the device's own reference
after vmclock_remove() has called misc_deregister(). misc_open() calls
open() with misc_mtx held, and misc_deregister() takes misc_mtx, so
open() always runs while the device's reference is held.

vmclock_remove() now marks the device as removed and wakes the wait
queue. A read() or mmap() on a file that is still open fails with
-ENODEV once it sees the mark. On a device that supports notifications,
poll() returns EPOLLHUP | EPOLLERR, including a poll() that was already
waiting; it tests the mark after poll_wait(), so it cannot miss the
wake-up. Without notifications poll() already returns POLLHUP.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.14493569608271069160=
@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
Reproduced in QEMU 10.2.4 with -device vmclock. A guest process opens
/dev/vmclock0, unbinds the driver through
/sys/bus/platform/drivers/vmclock/unbind, and reads the open file
again. Without this patch KASAN reports the slab-use-after-free; if the
device is bound again before the second read, that read oopses on the
unmapped page. With the patch the read returns -ENODEV, KASAN reports
nothing, and the rebound device reads normally. Not tested on EC2.
QEMU's device does not set VMCLOCK_FLAG_NOTIFICATION_PRESENT, so the
poll() change was not exercised, and mmap() after unbind was not tested.

This applies to v7.0 and later, where the per-file state was added.
Earlier kernels have the same bug through the devm-allocated state and
need a separate backport.

Lorenzo Stoakes' "ptp: vmclock: convert mmap hook to mmap_prepare"
(2026-11-05) changes vmclock_miscdev_mmap(). If it lands first I can
rebase.

Not changed here: in vmclock_probe(), !st->miscdev.minor is never true,
because an unregistered dynamic miscdevice keeps MISC_DYNAMIC_MINOR, so
a device with neither interface still binds. That is a separate fix.

 drivers/ptp/ptp_vmclock.c | 62 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index bb0e14bac9f2..3584a20f681d 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -51,6 +52,8 @@ struct vmclock_state {
 =09enum clocksource_ids cs_id, sys_cs_id;
 =09int index;
 =09char *name;
+=09struct kref kref;
+=09bool removed;
 };
=20
 #define VMCLOCK_MAX_WAIT ms_to_ktime(100)
@@ -369,6 +372,9 @@ static int vmclock_miscdev_mmap(struct file *fp, struct=
 vm_area_struct *vma)
 =09struct vmclock_file_state *fst =3D fp->private_data;
 =09struct vmclock_state *st =3D fst->st;
=20
+=09if (READ_ONCE(st->removed))
+=09=09return -ENODEV;
+
 =09if ((vma->vm_flags & (VM_READ|VM_WRITE)) !=3D VM_READ)
 =09=09return -EROFS;
=20
@@ -398,6 +404,9 @@ static ssize_t vmclock_miscdev_read(struct file *fp, ch=
ar __user *buf,
 =09uint32_t seq, old_seq;
 =09size_t max_count;
=20
+=09if (READ_ONCE(st->removed))
+=09=09return -ENODEV;
+
 =09if (*ppos >=3D PAGE_SIZE)
 =09=09return 0;
=20
@@ -450,6 +459,10 @@ static __poll_t vmclock_miscdev_poll(struct file *fp, =
poll_table *wait)
=20
 =09poll_wait(fp, &st->disrupt_wait, wait);
=20
+=09/* After poll_wait(), so the wake-up in vmclock_remove() is not missed =
*/
+=09if (READ_ONCE(st->removed))
+=09=09return EPOLLHUP | EPOLLERR;
+
 =09seq =3D le32_to_cpu(st->clk->seq_count);
 =09if (atomic_read(&fst->seq) !=3D seq)
 =09=09return POLLIN | POLLRDNORM;
@@ -466,6 +479,12 @@ static int vmclock_miscdev_open(struct inode *inode, s=
truct file *fp)
 =09if (!fst)
 =09=09return -ENOMEM;
=20
+=09/*
+=09 * misc_open() calls this with misc_mtx held, and vmclock_remove()
+=09 * calls misc_deregister(), which takes misc_mtx, before the device's
+=09 * own reference is dropped.
+=09 */
+=09kref_get(&st->kref);
 =09fst->st =3D st;
 =09atomic_set(&fst->seq, 0);
=20
@@ -474,9 +493,21 @@ static int vmclock_miscdev_open(struct inode *inode, s=
truct file *fp)
 =09return 0;
 }
=20
+static void vmclock_free(struct kref *kref)
+{
+=09struct vmclock_state *st =3D container_of(kref, struct vmclock_state, k=
ref);
+
+=09if (st->clk)
+=09=09memunmap(st->clk);
+=09kfree(st);
+}
+
 static int vmclock_miscdev_release(struct inode *inode, struct file *fp)
 {
-=09kfree(fp->private_data);
+=09struct vmclock_file_state *fst =3D fp->private_data;
+
+=09kref_put(&fst->st->kref, vmclock_free);
+=09kfree(fst);
 =09return 0;
 }
=20
@@ -649,9 +680,20 @@ static void vmclock_remove(void *data)
 =09if (st->miscdev.minor !=3D MISC_DYNAMIC_MINOR)
 =09=09misc_deregister(&st->miscdev);
=20
+=09/* Files still open now fail, and a poll() in progress returns */
+=09WRITE_ONCE(st->removed, true);
+=09wake_up_interruptible(&st->disrupt_wait);
+
 =09dev->driver_data =3D NULL;
 }
=20
+static void vmclock_put(void *data)
+{
+=09struct vmclock_state *st =3D data;
+
+=09kref_put(&st->kref, vmclock_free);
+}
+
 static void vmclock_put_idx(void *data)
 {
 =09struct vmclock_state *st =3D data;
@@ -665,9 +707,15 @@ static int vmclock_probe(struct platform_device *pdev)
 =09struct vmclock_state *st;
 =09int ret;
=20
-=09st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+=09/* Open files can outlive the device, so st is not devm memory */
+=09st =3D kzalloc_obj(*st);
 =09if (!st)
 =09=09return -ENOMEM;
+=09kref_init(&st->kref);
+
+=09ret =3D devm_add_action_or_reset(dev, vmclock_put, st);
+=09if (ret)
+=09=09return ret;
=20
 #if IS_ENABLED(CONFIG_ACPI)
 =09if (has_acpi_companion(dev))
@@ -686,13 +734,11 @@ static int vmclock_probe(struct platform_device *pdev=
)
 =09=09=09 resource_size(&st->res));
 =09=09return -EINVAL;
 =09}
-=09st->clk =3D devm_memremap(dev, st->res.start, resource_size(&st->res),
-=09=09=09=09MEMREMAP_WB | MEMREMAP_DEC);
-=09if (IS_ERR(st->clk)) {
-=09=09ret =3D PTR_ERR(st->clk);
+=09st->clk =3D memremap(st->res.start, resource_size(&st->res),
+=09=09=09   MEMREMAP_WB | MEMREMAP_DEC);
+=09if (!st->clk) {
 =09=09dev_info(dev, "failed to map shared memory\n");
-=09=09st->clk =3D NULL;
-=09=09return ret;
+=09=09return -ENXIO;
 =09}
=20
 =09if (le32_to_cpu(st->clk->magic) !=3D VMCLOCK_MAGIC ||
--=20
2.43.0


