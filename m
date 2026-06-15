Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA3400E0D
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536197; cv=none; b=RUojpFBwC/xZNfpWC0UtPmb3L6RKpEUnkl16c4cO94OOtZiVnwbEjxSfTCeMNsfv4lrEZKd/a6K6w5H686hYkB06ogX3mBEG6mA9rzQ09YxOeIYkDs4M4xs3dxUEIS6ivFsmK8hx00tOyg5RGOaXtgAdMnQW/VtXR/x+53aH/88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536197; c=relaxed/simple;
	bh=I1aHIggciL+96mvzHXJprXMWMGaZAV5N+Cv9vZJwvJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwG3vhMdczDCFQ07slmOJraknigjbq1MfIVJ1o3VxIhGDw6XJ/BoWQEyLqPf6MAePSgcf1byu/vFsLaOSyUp/PGZ8oeRWXK3W4p4fsRrerioMhFeDR97+YeD9yxGfIbpuuhpgaYgAy6cbq5/ZYYB21rXjveO32AOUOgsAS8C2xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=FHWLj8ih; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="FHWLj8ih"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa68cf9123so3453165e87.0
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1781536194; x=1782140994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIrF5pxuCjnAJoxb4czrrpSavkn7esm67b6oFTzhZxA=;
        b=FHWLj8ihporR9Czq90CI+DaF/arISq7/jThMw1lorsmMW4m4CYpM5d7rNMZ8msjmmQ
         gdqOJaU2vpU+44ZKGAq6TSEqTddMaV5pnhOjlZjsP/fRn/qa7b9oXX9/nhnI9ZCM98zL
         Lgl7bryR33aArrp6D5NAAM3/MjRFzhK4AA5suPBFnzTAQcYPzPd2cfJ//BCEnyzmnJZs
         Mitun6PJn7IwcIX4CvLaLolWLtGwY65gYWXwR4mgZWXPdeTvN2E6EBqX5uYmM5Rwn9dd
         iprfP/tnqySIxE7Tj4GHrY8640Bq7hcVnHSiSQQQy9qCzNpPOZTJVIO0TPyAlVVIpXRb
         vM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536194; x=1782140994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIrF5pxuCjnAJoxb4czrrpSavkn7esm67b6oFTzhZxA=;
        b=HLV3d4D27R8KHrIPQZ3NnRCnQJZBGDCDSSWqHJ4ZA77zkF9jHKpdVLfdu0WhVm3uOz
         LDhk5GEBFcWDW0HW8vZobCwnXEXRI0vGoXZuYwWRuGevwNnEaUgUkdO8BjXPOERW85CD
         +uusst3QYwxkO3kaJeeD3vpBE3Vmdnl/kRccDQOFX+/Lx/bwAhrAAYZcTfUGVK3j+3Bn
         nRS8KF9Bxk+cvzZcDT8alcChOYgchsP4In5gXsJTNGDgVIf8gwuo0nqO2ie0/o2XpUw2
         /RiqO6+r8k6oY5sggqsaO8dM+WFAos3+hnfTEaQV9bT7wfj6U5lfI54sgoWzVmzRoYCK
         pLlg==
X-Forwarded-Encrypted: i=1; AFNElJ+zo6VIgtFB231xG4FOl8pjvnN+LCsEXlf+5SLjLgax2nPmSFLO+zn9qyMHOt6Q8M/MQuq3aYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEyxKhzNJliFXkhJUumZCwopzTl8ElNYlxkHdNcZuHOe3o+O2b
	uUnzt8KfaaGRHqOaodreLgHS/JiTYuqzWoju6l1Undd4SP0TKJnpWd+NNQc5J+hYPd01
X-Gm-Gg: Acq92OFvqma/quR/VZ/gFYhua+JKafsRxgPDtR4NxrPzgQqf3Qc3/2TpyqpxB56Z634
	nMORYXyYWsRZrM2emKCqYMgdoWOIEGHzEYPQh4mSVvx2Ds669+TAu11C8+PsAa7zzpgaEjLW+I4
	KEVsdgxdHx2W3PJoMy8eN+s/an8CwBWhlVCZjfTjftxKNM+BQKn6lNFL2kT49GsbSV0hhgaVXd0
	tK+4sLHCBeMy128guoJOz5njGJC8VJcs0ysF1ZxJVUbnHR6RY2cjI7mTL/0GRgeJm/h8MhmXSbD
	Jm24SP+DQNGQx0MD9UuM3ynZWHx8CWBiF8aHyqoY1+lJj/mq0Cn0OqdGiM4WAxG9IE6k/OK4Uzb
	MOOGmkWgoD08lg9OAnQ8oLQttUkM9tUr+hdxGudFmald5PQJudoIb9HEDASCKVHuuxw+zpgmQeD
	8AFchWd+BFml0=
X-Received: by 2002:ac2:5693:0:b0:5aa:656f:d4f0 with SMTP id 2adb3069b0e04-5ad2db83f52mr4145533e87.41.1781536193202;
        Mon, 15 Jun 2026 08:09:53 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e170386sm2869601e87.30.2026.06.15.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:09:52 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Page <sam@bynar.io>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Fix UAF of hci_conn_params in add_device_complete
Date: Mon, 15 Jun 2026 16:09:22 +0100
Message-ID: <20260615150922.1737274-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_device_complete() runs from the hci_cmd_sync_work kworker, which
holds only hci_req_sync_lock and *not* hci_dev_lock.  It calls
hci_conn_params_lookup() and then dereferences the returned object
(params->flags) without taking hci_dev_lock:

	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
					le_addr_type(cp->addr.type));
	...
	device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
			     cp->addr.type, hdev->conn_flags,
			     params ? params->flags : 0);

hci_conn_params_lookup() walks hdev->le_conn_params and is documented to
require hdev->lock.  A concurrent MGMT_OP_REMOVE_DEVICE
(remove_device()), which does run under hci_dev_lock, can call
hci_conn_params_free() to list_del() and kfree() the very object the
lookup returned, so the subsequent params->flags read touches freed
memory [0].

Hold hci_dev_lock() across the hci_conn_params_lookup() and the read of
params->flags (and the matching event emission) so the lookup result
cannot be freed by a concurrent remove_device() before it is used,
honouring the locking contract of hci_conn_params_lookup().

[0]: (trailing page/memory-state dump trimmed)
BUG: KASAN: slab-use-after-free in add_device_complete+0x358/0x3d8 net/bluetooth/mgmt.c:7671
Read of size 1 at addr ffff000017ab26c1 by task kworker/u9:8/388

CPU: 1 UID: 0 PID: 388 Comm: kworker/u9:8 Not tainted 7.0.11 #20 PREEMPT
Hardware name: linux,dummy-virt (DT)
Workqueue: hci0 hci_cmd_sync_work
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xb4/0xd4 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x118/0x5d8 mm/kasan/report.c:482
 kasan_report+0xb0/0xf4 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 add_device_complete+0x358/0x3d8 net/bluetooth/mgmt.c:7671
 hci_cmd_sync_work+0x14c/0x240 net/bluetooth/hci_sync.c:334
 process_one_work+0x628/0xd38 kernel/workqueue.c:3289
 process_scheduled_works kernel/workqueue.c:3372 [inline]
 worker_thread+0x7a8/0xac0 kernel/workqueue.c:3453
 kthread+0x39c/0x444 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 3401:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x54 mm/kasan/generic.c:570
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0xd4/0xd8 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x1b0/0x458 mm/slub.c:5385
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 hci_conn_params_add+0x10c/0x4b0 net/bluetooth/hci_core.c:2279
 hci_conn_params_set net/bluetooth/mgmt.c:5162 [inline]
 add_device+0x5b4/0xa54 net/bluetooth/mgmt.c:7755
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1721 [inline]
 hci_sock_sendmsg+0x10b4/0x1dd0 net/bluetooth/hci_sock.c:1841
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe0/0x128 net/socket.c:742
 sock_write_iter+0x250/0x390 net/socket.c:1195
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x66c/0xab0 fs/read_write.c:688
 ksys_write+0x1fc/0x24c fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __arm64_sys_write+0x70/0xa4 fs/read_write.c:748
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151
 el0_svc+0x38/0xac arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Freed by task 3740:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 kasan_save_track+0x20/0x3c mm/kasan/common.c:78
 kasan_save_free_info+0x4c/0x74 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x88/0xb8 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2685 [inline]
 slab_free mm/slub.c:6170 [inline]
 kfree+0x14c/0x458 mm/slub.c:6488
 hci_conn_params_free+0x288/0x484 net/bluetooth/hci_core.c:2312
 remove_device+0x4b0/0x968 net/bluetooth/mgmt.c:7919
 hci_mgmt_cmd net/bluetooth/hci_sock.c:1721 [inline]
 hci_sock_sendmsg+0x10b4/0x1dd0 net/bluetooth/hci_sock.c:1841
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0xe0/0x128 net/socket.c:742
 sock_write_iter+0x250/0x390 net/socket.c:1195
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x66c/0xab0 fs/read_write.c:688
 ksys_write+0x1fc/0x24c fs/read_write.c:740
 __do_sys_write fs/read_write.c:751 [inline]
 __se_sys_write fs/read_write.c:748 [inline]
 __arm64_sys_write+0x70/0xa4 fs/read_write.c:748
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x84/0x2a8 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xe4/0x294 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x44/0x5c arch/arm64/kernel/syscall.c:151
 el0_svc+0x38/0xac arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Fixes: 1e2e3044c1bc ("Bluetooth: MGMT: Fix MGMT_OP_ADD_DEVICE invalid device flags")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d23ca1dd0893..dc55763f9e58 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7658,6 +7658,8 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 	if (!err) {
 		struct hci_conn_params *params;
 
+		hci_dev_lock(hdev);
+
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						le_addr_type(cp->addr.type));
 
@@ -7666,6 +7668,7 @@ static void add_device_complete(struct hci_dev *hdev, void *data, int err)
 		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
 				     cp->addr.type, hdev->conn_flags,
 				     params ? params->flags : 0);
+		hci_dev_unlock(hdev);
 	}
 
 	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,

base-commit: f70f7f2512c6b9113dc78f6a25361166afd1412e
-- 
2.54.0

