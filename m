Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795068933;
	b=C3D+1uOC76kE0FA3KVUJGTHaqPu6bFHWcreX47CKo6Gal2B/e/h96/NDlAue8Im38daO
	 OSwZWDqnvgxVccnA8OOOB+Jho5xaPRawWkLLjk8ucrcRwthCZlTUCZ03QYGjmmvEzeyb3
	 Mz65PojFUu77rgXdSGvJSYcyEBrQ/VP5fOToLMvFtkBfapLfYpLhbFOBZtQIlGD+tEJOq
	 eSOYX2RvYsCi+HDhjRNRygj3f9peqkmkjZ/TmzC2XDWQArzVIviyMD6Q96agWDn2Q70SH
	 ZfcogRk4qQH8hTOm7q5+GDP0AQMenhEk5n7tbRCi2iBvBeyciK96VLBXtBS4h54aaRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795068933;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R3JG0m7GdfGZgb2/08YY/8/yhRY8uSU5SGTLypBdqfU=;
	b=FDITw001emc3eJ9a9fRZQ0ObGer9GhPaWXmqTOI/9h+YwzOltKSdfoOucaporvMgJm/c
	 w3mdhHGrlL85AjlFufQ2TFfXYzRaKqqioo+WbyBAeVhYdtd0D8x+NMsbVhGidonJrb3sP
	 C+hAMLcfyiZLzc30yTdysT++JWQUy+vXtpCh96BFZwohqOPdYajKUKLndRoBqK92Anl1I
	 E6QK2Dv49wOUfA8VjjwnFxAlVzctkurdh46PoxU/kaUMP9rG36wpE5v68F4ZRb/YlkEov
	 5ie3Wpr1R04h67ZDZvHfcl6uxbuqK2RyZO7HNwA8e0gR0ebZ/OPoMJSSjEQhDqUZk4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=FD7Q8tHy;
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41510606A320
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 06:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41510606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=FD7Q8tHy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1795068929; x=1795328129;
	bh=R3JG0m7GdfGZgb2/08YY/8/yhRY8uSU5SGTLypBdqfU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FD7Q8tHyzpy9DJGEA71ObWikfGNiqiy2dP1uEVWh1BegTcWcb+JU/mu1RPMc6iCqo
	 O6Gq+QPPjmKJxCGAQH5W3hLlmG7X5R36My9wQSm8HyqR5hY8aR4QHKv1d0Mx4pQ7XB
	 PVU651bTrct77KJeNIWpdYpWEvazhbOq4d0FCvVNhBjAL5S8pbI/MjBSfbhX5lxcK2
	 MDXoT1pLS7GyXvsuKPi4KZUYW+nAMzWYiRrDFGUbyxEFHl/gyXbf6EUf7a/zNXFFj9
	 Oq9s10PWpRDgvaE/Hm+Gd8Vw3zxhc8s+yJWWi9yMYazTJqTQgFQyVGrnpm8HcBLL+a
	 ij/ma2U5qCDkA==
Date: Thu, 19 Nov 2026 06:15:26 +0000
To: Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>
From: Chad Aldreda <ca@modelmiser.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v3] ptp: vmclock: keep the device state until the last file is closed
Message-ID: <20261119061517.1142436-2-ca@modelmiser.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 77707bca80c96b18c97343ae274d70d7d9c489d8
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

vmclock_probe() allocates struct vmclock_state with devm_kzalloc_obj()
and maps the shared page with devm_memremap(), so both are released
when the driver is unbound, but an open /dev/vmclockN keeps using them
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
Signed-off-by: Chad Aldreda <ca@modelmiser.com>
---
v3:
- Rebased on net/main e203d8a4751d, after the devm_kmalloc() family
  was converted to devm_kmalloc_obj() (4dd10fbbeb9c). The line this
  patch removes from vmclock_probe() is now devm_kzalloc_obj(dev, *st);
  the commit message says devm_kzalloc_obj() to match. Requested by
  Jakub Kicinski.
- Wrapped two lines that were over 80 columns (a comment in
  vmclock_miscdev_poll() and the container_of() in vmclock_free()).
  No other change.
- Dropped the Assisted-by: tag, which Documentation/process no longer
  describes (1e035297ffda); the tool use is described at the end of
  these notes instead.

v2: https://lore.kernel.org/r/20261112161514.1647680-2-ca@modelmiser.com
- vmclock_remove() wakes the wait queue with wake_up_interruptible_all()
  instead of wake_up_interruptible(), so every epoll waiter gets
  EPOLLHUP | EPOLLERR at remove, not only the first EPOLLEXCLUSIVE one.
  Pointed out by Paolo Abeni, from the Sashiko review.
- The commit message says how the bug was found and tested.
- Cc: stable carries "# 7.0+" (see below).

v1: https://lore.kernel.org/r/20261107150344.3946529-2-ca@modelmiser.com

Testing, all in QEMU 10.2.4 with -device vmclock, KASAN enabled, rerun
on v3 as posted:
- A guest process opens /dev/vmclock0, unbinds the driver through
  /sys/bus/platform/drivers/vmclock/unbind, and reads the open file
  again. On net/main without this patch KASAN reports the
  slab-use-after-free in vmclock_miscdev_read(), and if the device is
  bound again first, the read oopses on the unmapped page. With the
  patch the read returns -ENODEV, KASAN reports nothing, and the
  rebound device reads normally.
- The wake-up test from v2: three threads each add the same open file
  to their own epoll instance with EPOLLEXCLUSIVE and block in
  epoll_wait(), then the driver is unbound. QEMU's device does not set
  VMCLOCK_FLAG_NOTIFICATION_PRESENT, so for this test only, a local
  change (not part of this patch) made poll() take the waiting path
  without that flag. A run counts only if all three waiters are asleep
  in do_epoll_wait before the unbind. All three woke at the unbind in
  each of 4 runs, and KASAN reported nothing; without EPOLLEXCLUSIVE
  they woke as well. As a control, v1 with the same local change (on
  v1's base, the kernel used as v2's control) was run alongside: one
  waiter woke and two slept until their timeout, as in v2's control
  runs.
- Not tested: EC2 hardware, a real notification, and mmap() after
  unbind. There are no selftests for this driver.

This is for v7.0 and later, where the per-file state was added. Before
v7.4-rc2 the line this patch removes is still devm_kzalloc(dev,
sizeof(*st), GFP_KERNEL), so the stable trees need that context line
adjusted. Earlier kernels have the same bug through the devm-allocated
state and need a separate backport.

Lorenzo Stoakes' "ptp: vmclock: convert mmap hook to mmap_prepare"
(2026-11-05, part of an mm series) also changes vmclock_miscdev_mmap()
and is not in net/main. If the two meet I can send a resolution or
rebase as needed.

Not changed here: in vmclock_probe(), !st->miscdev.minor is never true,
because an unregistered dynamic miscdevice keeps MISC_DYNAMIC_MINOR, so
a device with neither interface still binds. That is a separate fix.

The code, changelog and reproducers were written with an AI assistant
(Claude Opus 5.5), and the assistant ran the tests above. I ran the
final version myself and got the same results.

 drivers/ptp/ptp_vmclock.c | 63 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 7f25fe6c2ce2..3e32a9030661 100644
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
+=09/* After poll_wait(), so vmclock_remove()'s wake-up is not missed */
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
@@ -474,9 +493,22 @@ static int vmclock_miscdev_open(struct inode *inode, s=
truct file *fp)
 =09return 0;
 }
=20
+static void vmclock_free(struct kref *kref)
+{
+=09struct vmclock_state *st =3D
+=09=09container_of(kref, struct vmclock_state, kref);
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
@@ -649,9 +681,20 @@ static void vmclock_remove(void *data)
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
@@ -665,9 +708,15 @@ static int vmclock_probe(struct platform_device *pdev)
 =09struct vmclock_state *st;
 =09int ret;
=20
-=09st =3D devm_kzalloc_obj(dev, *st);
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
@@ -686,13 +735,11 @@ static int vmclock_probe(struct platform_device *pdev=
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


