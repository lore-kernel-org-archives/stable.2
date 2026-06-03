Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDE4028F1
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530233; cv=none; b=ogcaAG+w3AkGWcDLrauYJN0WGP8qv3gRRFTl2P3+q6wdvc1ZlZv5ZQjtMERk26x4NbDAp2+RiXu2+vMGAIcRegq6DvKIZGokJJfSxeZb/npms0qmAtSKXMU0roS1OlycIhwJu1q2LGYCzfo6JRbtAJPmOA6L1D/vmwEcJoZI1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530233; c=relaxed/simple;
	bh=4FRgeUKxAtViRu/Vti7zSZ6k+8I0GC+nOnaMnBCJk1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXcDpJgaG+o1e1ZuHZgcRm3he0y2lsdb8ldxED+fohESwQdUsmjsVSBLrqFd6CLMx1x+NC7UO0q1THrrHKxKBcAiXWicxu5gIbS90WFTh/yPKfMitDDuOolpIzxNteUbfyLAeNuEp9MzGWOfTMi69kTCH8nU2+pOoQmKAqnUxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvQWoTHF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvQWoTHF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39677245e15so409601fa.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530230; x=1781135030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOMKVjpdQuMQW/mDvL7MkB3wiks8i0bLiAPsA9AAen8=;
        b=EvQWoTHFCc/jtd5KSsrN5T5O6J3sx9rGPWVR8SERtKsaqH+r+h4ldlrFdfEKYT5qw6
         Qj6aiHSsaflp5DsZd6hihTBrjAKjcgLQc+g81QYqvedaWAck1smnIOCPqQVuH4BWNpem
         Fx2HwvbGwHqaqH7dlaQmp1ZSUbjUBGmVtN+sYx9Dk3KmP+kZTqcjfHcBZnRgL1ZFzqDq
         CNilK6VSnCjwF+Fih9H9AZZRAtAxNjstU+MolkkElixEXQhfwFuJeEiGNjMDFQ3/bsHa
         7nIaIi09yjeoQMlFJupx69Gt5PBp7NK4ifrbxqsuYAHJlAK3b38RZqBu4diLIl+MqIC2
         75wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530230; x=1781135030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOMKVjpdQuMQW/mDvL7MkB3wiks8i0bLiAPsA9AAen8=;
        b=o+U4uWnlZJJ+LBVZ2mUqy12NGgvs00//oN6iMSfSYCCy3bxjYdudz77xkSxz4Rj+C9
         zSgMuA1ZbJdlbfWw6LmDMMq6NFMXWiUzQFvljGULGXCIckjk6vM/2B8/y4Bd8IL4vUDA
         KdexGACBNTcxMIF/wnuVasZPe3aeeEInmvClu6AyVoPopuItBODXTUqE86nBz17Y1c6P
         WhnxGO8w9OORxU+i7Yfm7wuseYGq9buqKXgmtLd3hXbYa7/jKbPpHarhYuLUHNrQ3Pfd
         j+VYD7ysa11Dsy7gkCkwVbpgYDBh7+3naUdVlcc4f1XLpi1RHIUQfOXc9+sc6ecUBDQo
         TcKg==
X-Gm-Message-State: AOJu0Yz4B07AXCdFXnK0pWVdatOe3cdQhCq8H+VGRKiOsIQe/A+a6aKA
	cLLOe2SsIntMN+/WCAPG63EGAVid4dhzK452kWA0i/j0SRE/4I7cQ2+SnBJ2CkOgO44=
X-Gm-Gg: Acq92OGVY8WgK7JaGmpf2en1JqupghojKbwpkSRn8FzshB4leAILff9NmFR23L/WRpW
	2u3LEWZLq047cpoK0WdzOHTlt0LxMBiqOt3tM3mFcE8FlN3RoI/biLF5glytZ4DKoTPE3pRBWtu
	bjv7ETi7UlWpOQGgFoTRBGQ9/b3HhpOFZOXzZkxFHbZWjen6avWO8pxUqmsGMPnCUApm0bUWHxa
	6HH9hGomjbfH4m5uLxGrFzPRuyGChCKgRSnn+anOdcyixKKVNkTe9yXZi/2s2U6klJOkJQkEXXE
	ftJTS7mhqlgU/jABXikM81a0WucpDectNqD+8w/36ZfHaG9Y4gI8GUFXrRHTRSBOMRlvCxi49bY
	UcjqSgkP0irwIYeMt2q4M5QuuIdHCMTUdeU/ATMB10D4OxRmHpIFF7zpQzBZUJCOklnOmKW/Z6/
	5CcwkT5co8JJQh5sMNActDF9HGdhkQPn/lM8nhjFubUYAf5+VqInxAUktDyGV9JMf7GqBJpPT5W
	8TlIeA=
X-Received: by 2002:a05:651c:547:b0:393:c6b5:993b with SMTP id 38308e7fff4ca-396af5172a2mr16825171fa.24.1780530229785;
        Wed, 03 Jun 2026 16:43:49 -0700 (PDT)
Received: from c0624c666cc5.devsec.astralinux.ru ([93.188.205.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d5034sm12286331fa.29.2026.06.03.16.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:43:47 -0700 (PDT)
From: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vladislav Nikolaev <vlad102nikolaev@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	David Herrmann <dh.herrmann@googlemail.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	David Rheinsberg <david@readahead.eu>,
	Johan Hedberg <johan.hedberg@intel.com>,
	lvc-project@linuxtesting.org,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Thu,  4 Jun 2026 02:43:39 +0300
Message-ID: <20260603234343.445-1-vlad102nikolaev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

commit 1d6123102e9fbedc8d25bf4731da6d513173e49e upstream.

syzbot reported use-after-free in vhci_flush() without repro. [0]

From the splat, a thread close()d a vhci file descriptor while
its device was being used by iotcl() on another thread.

Once the last fd refcnt is released, vhci_release() calls
hci_unregister_dev(), hci_free_dev(), and kfree() for struct
vhci_data, which is set to hci_dev->dev->driver_data.

The problem is that there is no synchronisation after unlinking
hdev from hci_dev_list in hci_unregister_dev().  There might be
another thread still accessing the hdev which was fetched before
the unlink operation.

We can use SRCU for such synchronisation.

Let's run hci_dev_reset() under SRCU and wait for its completion
in hci_unregister_dev().

Another option would be to restore hci_dev->destruct(), which was
removed in commit 587ae086f6e4 ("Bluetooth: Remove unused
hci-destruct cb").  However, this would not be a good solution, as
we should not run hci_unregister_dev() while there are in-flight
ioctl() requests, which could lead to another data-race KCSAN splat.

Note that other drivers seem to have the same problem, for exmaple,
virtbt_remove().

[0]:
BUG: KASAN: slab-use-after-free in skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
BUG: KASAN: slab-use-after-free in skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
Read of size 8 at addr ffff88807cb8d858 by task syz.1.219/6718

CPU: 1 UID: 0 PID: 6718 Comm: syz.1.219 Not tainted 6.16.0-rc1-syzkaller-00196-g08207f42d3ff #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xd2/0x2b0 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 skb_queue_empty_lockless include/linux/skbuff.h:1891 [inline]
 skb_queue_purge_reason+0x99/0x360 net/core/skbuff.c:3937
 skb_queue_purge include/linux/skbuff.h:3368 [inline]
 vhci_flush+0x44/0x50 drivers/bluetooth/hci_vhci.c:69
 hci_dev_do_reset net/bluetooth/hci_core.c:552 [inline]
 hci_dev_reset+0x420/0x5c0 net/bluetooth/hci_core.c:592
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcf5b98e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf5c7b9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcf5bbb6160 RCX: 00007fcf5b98e929
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000009
RBP: 00007fcf5ba10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fcf5bbb6160 R15: 00007ffd6353d528
 </TASK>

Allocated by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4359
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 vhci_open+0x57/0x360 drivers/bluetooth/hci_vhci.c:635
 misc_open+0x2bc/0x330 drivers/char/misc.c:161
 chrdev_open+0x4c9/0x5e0 fs/char_dev.c:414
 do_dentry_open+0xdf0/0x1970 fs/open.c:964
 vfs_open+0x3b/0x340 fs/open.c:1094
 do_open fs/namei.c:3887 [inline]
 path_openat+0x2ee5/0x3830 fs/namei.c:4046
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1463
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2381 [inline]
 slab_free mm/slub.c:4643 [inline]
 kfree+0x18e/0x440 mm/slub.c:4842
 vhci_release+0xbc/0xd0 drivers/bluetooth/hci_vhci.c:671
 __fput+0x44c/0xa70 fs/file_table.c:465
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x6ad/0x22e0 kernel/exit.c:955
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1104
 __do_sys_exit_group kernel/exit.c:1115 [inline]
 __se_sys_exit_group kernel/exit.c:1113 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1113
 x64_sys_call+0x21ba/0x21c0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807cb8d800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 88 bytes inside of
 freed 1024-byte region [ffff88807cb8d800, ffff88807cb8dc00)

Fixes: bf18c7118cf8 ("Bluetooth: vhci: Free driver_data on file release")
Reported-by: syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f62d64848fc4c7c30cd6
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Vladislav Nikolaev <vlad102nikolaev@gmail.com>
---
Backport fix for CVE-2025-38250
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 34 ++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe62943a35dd..bc4e2856f235 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -28,6 +28,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sock.h>
@@ -285,6 +286,7 @@ struct amp_assoc {
 
 struct hci_dev {
 	struct list_head list;
+	struct srcu_struct srcu;
 	struct mutex	lock;
 
 	const char	*name;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9787a4c55113..a718e38f3da3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1040,7 +1040,7 @@ static int hci_linkpol_req(struct hci_request *req, unsigned long opt)
 
 /* Get HCI device by index.
  * Device is held on return. */
-struct hci_dev *hci_dev_get(int index)
+static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -1053,6 +1053,8 @@ struct hci_dev *hci_dev_get(int index)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
+			if (srcu_index)
+				*srcu_index = srcu_read_lock(&d->srcu);
 			break;
 		}
 	}
@@ -1060,6 +1062,22 @@ struct hci_dev *hci_dev_get(int index)
 	return hdev;
 }
 
+struct hci_dev *hci_dev_get(int index)
+{
+	return __hci_dev_get(index, NULL);
+}
+
+static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+{
+	return __hci_dev_get(index, srcu_index);
+}
+
+static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+{
+	srcu_read_unlock(&hdev->srcu, srcu_index);
+	hci_dev_put(hdev);
+}
+
 /* ---- Inquiry support ---- */
 
 bool hci_discovery_active(struct hci_dev *hdev)
@@ -1906,9 +1924,9 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 int hci_dev_reset(__u16 dev)
 {
 	struct hci_dev *hdev;
-	int err;
+	int err, srcu_index;
 
-	hdev = hci_dev_get(dev);
+	hdev = hci_dev_get_srcu(dev, &srcu_index);
 	if (!hdev)
 		return -ENODEV;
 
@@ -1930,7 +1948,7 @@ int hci_dev_reset(__u16 dev)
 	err = hci_dev_do_reset(hdev);
 
 done:
-	hci_dev_put(hdev);
+	hci_dev_put_srcu(hdev, srcu_index);
 	return err;
 }
 
@@ -3596,6 +3614,11 @@ struct hci_dev *hci_alloc_dev(void)
 	if (!hdev)
 		return NULL;
 
+	if (init_srcu_struct(&hdev->srcu)) {
+		kfree(hdev);
+		return NULL;
+	}
+
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
@@ -3839,6 +3862,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	synchronize_srcu(&hdev->srcu);
+	cleanup_srcu_struct(&hdev->srcu);
+
 	cancel_work_sync(&hdev->rx_work);
 	cancel_work_sync(&hdev->cmd_work);
 	cancel_work_sync(&hdev->tx_work);
-- 
2.47.3
