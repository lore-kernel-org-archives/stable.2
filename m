Received: from mail.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C227473;
	Mon, 24 Aug 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.108.111.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565998; cv=none; b=RcWA9kKPENewGye/8nzykd0XRu79KF6CkAxfjplmNGfLjWEJsnI71EDy/ut7f0qvGEZM4lnyPqLzg/6lQ3KuNZBGP9NrF1KhHHQEEdtlHEoaOxhT8SjhOAlJLi9R9OzkCqCtCSPIrzFg8gO052UGtR/TcLRwC8fOegOljCdmhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565998; c=relaxed/simple;
	bh=H7n0QcARCOOzNO25zmSpYXoaFi9dJd0XMChOCtt24X0=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=mBaeaDcZmOTP+ov6vYy0EaRnzWuwjeawnde+tmJuxykyoA7QJCoJHESB9B6C8G+eImL6z99LWCrW+TdUc+Qic6t/zm6nRIe6RsC6MOQyN/r/qy7BK4vZcJx3jylHbQQORUraFXRmSKjot5o08LE1OLP8oTFEhNMaRYUpYqp+4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru; spf=pass smtp.mailfrom=amicon.ru; dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b=ncvexP7r; arc=none smtp.client-ip=77.108.111.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.b="ncvexP7r"
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1787565983; h=from:subject:to:date:message-id;
	bh=H7n0QcARCOOzNO25zmSpYXoaFi9dJd0XMChOCtt24X0=;
	b=ncvexP7rtJPdNR0DaX9JSn/EhPFi4xaWOJVzM5yaGQl1qR2LuM8n4gbrPlmNOUpWCLBwUrlbrs9
	EuMsngMGzQAZrolV0TVgjYrkq11u8ji8CTEgfR/rmrKBqkTu/HL7pZIaIO0IWfYfmt7JbZM8xoZQb
	Aygxh4Cymx18VPWyijH8UGNagBO01ycdlDW7HMZqOuZtQACS0n40GpJqYTTIDMk5G6DTkgg1ecwDy
	AUQQpS0A7konIFmKq+JbeTHdLh8MXa6YLbTNsgtDI/0n1EmGcytwkyhi78xm2dq8i10eXgXitS5SZ
	JIoA72CbvpVVS5NRI+IMs2nUQ4xvmd0otUNw==
Received: from localhost.localdomain (192.168.0.250) by mail.amicon.lan
 (192.168.0.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 24 Aug
 2026 13:06:12 +0300
From: Aleksandr Khromov <haa@amicon.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <rrv@amicon.ru>, <haa@amicon.ru>
Subject: [PATCH net v2] slip: fix use-after-free in sl_sync()
Date: Mon, 24 Aug 2026 13:05:47 +0300
Message-ID: <20260824100547.164773-1-haa@amicon.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: mail.amicon.lan (192.168.0.59) To mail.amicon.lan
 (192.168.0.59)

slip_devs[] stores bare net_device pointers and takes no reference on
them.  sl_sync() and sl_alloc() walk that table from slip_open() under
rtnl_lock(), while an entry is dropped by sl_free_netdev(), which
sl_setup() installs as dev->priv_destructor.

priv_destructor is called from netdev_run_todo(), which deliberately
runs with the RTNL semaphore released so that it can sleep while waiting
for the device refcount to drop:

	/* Snapshot list, allow later requests */
	list_replace_init(&net_todo_list, &list);

	__rtnl_unlock();
	...
		if (dev->priv_destructor)
			dev->priv_destructor(dev);	/* slip_devs[i] = NULL */
		if (dev->needs_free_netdev)
			free_netdev(dev);
		...
		/* Free network device */
		kobject_put(&dev->dev.kobj);

So rtnl_lock() does not serialise slip_open() against the teardown at
all.  sl_sync() can load slip_devs[i] while the entry is still published
and dereference it after netdev_run_todo() has run the destructor and
released the device:

  CPU0 (slip_open)                 CPU1 (slip_close)
                                   unregister_netdev()
                                     rtnl_unlock()
                                       netdev_run_todo()
                                         __rtnl_unlock()
  rtnl_lock()
  sl_sync()
    dev = slip_devs[i]
                                         priv_destructor(dev)
                                           slip_devs[i] = NULL
                                         kobject_put(&dev->dev.kobj)
                                           /* dev is freed */
    sl = netdev_priv(dev)
    if (sl->tty || sl->leased)     /* use-after-free */

  BUG: KASAN: use-after-free in sl_sync drivers/net/slip/slip.c:730 [inline]
  BUG: KASAN: use-after-free in slip_open+0xef4/0x1210 drivers/net/slip/slip.c:806
  Read of size 1 at addr ffff8880712dac71 by task syz-executor.2/6506

  CPU: 2 PID: 6506 Comm: syz-executor.2 Not tainted 6.1.134-syzkaller-00260-g0c8fc3469765 #0
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
  Call Trace:
   sl_sync drivers/net/slip/slip.c:730 [inline]
   slip_open+0xef4/0x1210 drivers/net/slip/slip.c:806
   tty_ldisc_open+0xa2/0x120 drivers/tty/tty_ldisc.c:433
   tty_set_ldisc+0x324/0x720 drivers/tty/tty_ldisc.c:564
   tiocsetd drivers/tty/tty_io.c:2428 [inline]
   tty_ioctl+0x5f0/0x1530 drivers/tty/tty_io.c:2712

  Allocated by task 6502:
   alloc_netdev_mqs+0x98/0xfe0 net/core/dev.c:10719
   sl_alloc drivers/net/slip/slip.c:756 [inline]
   slip_open+0x36d/0x1210 drivers/net/slip/slip.c:817
   tty_ldisc_open+0xa2/0x120 drivers/tty/tty_ldisc.c:433
   tty_set_ldisc+0x324/0x720 drivers/tty/tty_ldisc.c:564

  Freed by task 6497:
   device_release+0xa2/0x240 drivers/base/core.c:2507
   kobject_put+0x179/0x280 lib/kobject.c:729
   netdev_run_todo+0x6c8/0xef0 net/core/dev.c:10509
   slip_close+0x166/0x1c0 drivers/net/slip/slip.c:906
   tty_ldisc_close+0x113/0x1a0 drivers/tty/tty_ldisc.c:456
   tty_ldisc_kill+0x94/0x160 drivers/tty/tty_ldisc.c:614
   tty_ldisc_release+0xe3/0x2b0 drivers/tty/tty_ldisc.c:782
   tty_release+0xbcc/0xe70 drivers/tty/tty_io.c:1860

Commit e58c19124189 ("slip: Fix use-after-free Read in slip_open") fixed
a different source of stale entries - a device left in slip_devs[] after
slip_open() freed it on the registration error path - and does not
address this race, which is why the report survives it.

Drop the entry from ndo_uninit instead.  unregister_netdevice() calls
ndo_uninit under RTNL, before the device is queued to netdev_run_todo(),
so an entry that sl_sync() can still see while holding RTNL belongs to a
device that cannot be freed until RTNL is dropped.  sl_free_netdev()
stays only for the slip_open() error path, where register_netdevice()
may have failed before ndo_init and ndo_uninit is then not called
either.  Both running for the same device is harmless: they run under
the same RTNL section, so the slot cannot have been reused in between.

This also removes the second symptom of the missing exclusion: a
destructor running after sl_alloc() had already handed the slot out to
another channel used to clear a live entry, so sl_sync() stopped at that
NULL, sl_alloc() returned the same index again, and
register_netdevice() failed with -EEXIST because slN was still there.

Reproduced on x86_64 with several threads looping over
open("/dev/ptmx") + ioctl(TIOCSETD, N_SLIP) + close().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 5342b77c4123 ("slip: Clean up create and destroy")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
---
v2:
  - drop the slip_devs[] entry from ndo_uninit, under RTNL, instead of
    adding a dedicated mutex (Jakub Kicinski)
  - commit message updated accordingly
v1: https://lore.kernel.org/netdev/20260817070952.1155579-1-haa@amicon.ru/
---
 drivers/net/slip/slip.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index faae711cf793..85b2438e8923 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -628,9 +628,15 @@ static void sl_uninit(struct net_device *dev)
 	struct slip *sl = netdev_priv(dev);
 
 	sl_free_bufs(sl);
+	/* Drop the slip_devs[] entry here rather than from the destructor:
+	 * ndo_uninit runs under RTNL, so it cannot race sl_sync().
+	 */
+	slip_devs[dev->base_addr] = NULL;
 }
 
-/* Hook the destructor so we can free slip devices at the right point in time */
+/* Only for the slip_open() error path: register_netdevice() can fail before
+ * ndo_init, and then ndo_uninit is not called either.
+ */
 static void sl_free_netdev(struct net_device *dev)
 {
 	int i = dev->base_addr;
@@ -657,7 +663,6 @@ static void sl_setup(struct net_device *dev)
 {
 	dev->netdev_ops		= &sl_netdev_ops;
 	dev->needs_free_netdev	= true;
-	dev->priv_destructor	= sl_free_netdev;
 
 	dev->hard_header_len	= 0;
 	dev->addr_len		= 0;
@@ -908,7 +913,7 @@ static void slip_close(struct tty_struct *tty)
 #endif
 	/* Flush network side */
 	unregister_netdev(sl->dev);
-	/* This will complete via sl_free_netdev */
+	/* sl_uninit() has dropped the slip_devs[] entry by now */
 }
 
 static void slip_hangup(struct tty_struct *tty)
-- 
2.48.1

