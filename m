Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500135;
	b=fZxqA+stVmZunJAFVl2nYkxUzm51L5tOb7qGOIti8TSjRNnfZ+YunX1dtfb9d5PYHxQz
	 LyQWQUZtly2cHyCe8npqP+WZYS8uwXvXivfmcXa+BiiRgkig+Ro6SBu0y19jRm/Id4j9Q
	 YiaR0ZX+Bb5Miy7OOAf+pFQvB/tpwDA+dID+N21uegbJfHNCqaUA2jxMVE0u3NrjukZRU
	 6P9ubE1del3+VcMucxPPjlu26N/O3je0+oaS0zVarm9SbvNlAk9rLJb+S6PCUEd/88Qfi
	 4lROrJn6QXB2usf3tsg9bLNxhmydNjfjdrQSxoOgEYgaPW+xMnrj46qGMIS4EukeAWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500135;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7OebMRYXMUNnV/GNOINKc0z7/r8pBZDZQCXFWrMOjjY=;
	b=seihj6TsNNalC+6EeIh7eDO+9wtFUIA2hhvX0Zvca1NDyLWlnIp9v9zAKia/BgqoHnjZ
	 D+OKwVwkAPOZniC84P648ckQGdrcZ9CJMH4OkmS9AwOQwb7oQdje5I8uMxWXCHFngNWnx
	 8B09ftV/MMjDr5UhjThC4+pXdfLsr/Oxh/YoKwRMp19E/0fz3dFK4kacn1Jfgxa/SlRYr
	 E66ZZ1pHhmG7BK5l2tWKbN+fpY5YP4rrx5AL0FdpOz+NhXAzrV1QdQO1XurERZPCDNNbX
	 B6+LKIKdSW0/wBcKFUjBb2wOd+5O7AuswYERhgJ7g7l1j0CKoZbDimUx5OmYyd9x4gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=cIYGd5X6;
	arc=none smtp.remote-ip=185.70.43.17
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF1606A337;
	Thu, 12 Nov 2026 16:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53FF1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=cIYGd5X6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794500131; x=1794759331;
	bh=7OebMRYXMUNnV/GNOINKc0z7/r8pBZDZQCXFWrMOjjY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cIYGd5X6tNoHC0REsb3R9HzyI+PKVWBJwOAvl69CbQFm37hBAM3+G4eAeqXR62Czs
	 1+s6WuTv3qyoY1txczGjdRZXm2xg2Ae2QJNk1c5bpgA8PTbuGZytn8SfIaQ9NEW46V
	 Q6aSHAV/MTJoSJu+K/n1Rl/ly60CDlwuwa5PJPxixaRHbi+Kzn+t8LAUmk4f6BtuRe
	 rcAP/65SsSOFxngb+g0vrxWNLjOMYmN+Di41HP/A/cSxltKarXcHf+ZBsKuMo70ILF
	 12oqF8pnvaorhB0L/kc8ynloEpDjYNoLjC4cC1d5m/sqQJC5IKeoHmFwJPncegn02K
	 DBQZYbiKqHn+w==
Date: Thu, 12 Nov 2026 16:15:27 +0000
To: Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ptp: vmclock: keep the device state until the last file is closed
Message-ID: <20261112161514.1647680-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 1d6a9e0292d7416e8db1c5c8c8b1bfa3775a35fe
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

vmclock_remove() now marks the device as removed and wakes every waiter
on the wait queue. A read() or mmap() on a file that is still open fails
with -ENODEV once it sees the mark. On a device that supports
notifications, poll() returns EPOLLHUP | EPOLLERR, including a poll()
that was already waiting; it tests the mark after poll_wait(), so it
cannot miss the wake-up. The wake-up uses wake_up_interruptible_all(),
because no later notification will reach a waiter that the remove-time
wake-up skips, such as a second epoll instance that registered the file
with EPOLLEXCLUSIVE. Without notifications poll() already returns
POLLHUP.

Separately from the report below, the bug was also found by a
Coccinelle script that reports device nodes in devm-allocated memory,
posted at
https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com,
and reproduced in QEMU 10.2.4 with -device vmclock. There is no access
to EC2 hardware with this device, so the fix has only been tested in
QEMU. QEMU's device has no notifications, so the poll() path was tested
with a local change that lets poll() wait without them.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.14493569608271069160=
@gmail.com/
Cc: stable@vger.kernel.org # 7.0+
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
v2:
- vmclock_remove() wakes the wait queue with wake_up_interruptible_all()
  instead of wake_up_interruptible(), so every epoll waiter gets
  EPOLLHUP | EPOLLERR at remove, not only the first EPOLLEXCLUSIVE one.
  Pointed out by Paolo Abeni, from the Sashiko review:
  https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107150344.394652=
9-2-ca@modelmiser.com
  The two notification wake-ups are unchanged.
- The commit message says how the bug was found and tested.
- Cc: stable now carries "# 7.0+" (see below).
- Rebased on net/main 19ec8416a76c; no other change.

v1: https://lore.kernel.org/r/20261107150344.3946529-2-ca@modelmiser.com

Testing, all in QEMU 10.2.4 with -device vmclock, KASAN enabled:
- As in v1: a guest process opens /dev/vmclock0, unbinds the driver
  through /sys/bus/platform/drivers/vmclock/unbind, and reads the open
  file again. Without this patch KASAN reports the slab-use-after-free;
  if the device is bound again before the second read, that read oopses
  on the unmapped page. With the patch the read returns -ENODEV, KASAN
  reports nothing, and the rebound device reads normally.
- New in v2, for the wake-up: three threads each add the same open file
  to their own epoll instance and block in epoll_wait(), then the
  driver is unbound. QEMU's device does not set
  VMCLOCK_FLAG_NOTIFICATION_PRESENT, so for this test only, a local
  change (not part of this patch) made poll() take the waiting path
  without that flag. Before the unbind, the test reads each waiter's
  /proc/self/task/<tid>/wchan and counts the run only if all three are
  asleep in do_epoll_wait. With v1 and EPOLLEXCLUSIVE, one waiter got
  EPOLLHUP | EPOLLERR and the other two slept until their 8 s timeout,
  in each of 4 runs; with v2 all three woke at the unbind, in each of 4
  runs. Without EPOLLEXCLUSIVE all three woke with either version.
  KASAN reported nothing in any of these runs.
- Not tested: EC2 hardware, a real notification, and mmap() after
  unbind.

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
index bb0e14bac9f2..ea94a73ac52e 100644
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
+=09wake_up_interruptible_all(&st->disrupt_wait);
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


