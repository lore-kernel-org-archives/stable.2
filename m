Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494B376464
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669442; cv=none; b=rUlBwqpLRe1+b8WiZ10By3wHrq7tQ4gq9SHThRK3GRy+d0fBJG9Dy1PJKCALV9Df7GpCwa3OKC76pP9jB3qTBYbPWMPSQcZPBtBIqJuDxmFOj1s/TCyHfLlknfLteET56HNCFEEZdJ5zCL30paROUJSZMTKXE37S2kQj0p7i59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669442; c=relaxed/simple;
	bh=NVQ3ftDkkd2lOcck1YHebu3riubdMJ4xjIVpubwELv8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oNUJSGVWXRbsCabMEvLJ/bO2mnHOq31XdcMCcR5sNUIF/NmPWOHy2c+dZKKvy7zPkFhNTOM6FipMfHvc1b+u22kxtW7K7PmOoFggpvfpD6Dxzu2UnIJxMdFegRNE5/3j0JoyhZS5UtbZr1dYXbdsFcpZkNnHjbLKgkuclTBm/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v8USobHC; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8USobHC"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso17234965e9.2
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780669437; x=1781274237; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FRDWOfecK8ux/l9ItKCppD9VSQtTNi4U9dxBF07WZc=;
        b=v8USobHCI0ln5OJvaeum/o35a+9a0KeVuIVmqn6B8s7K0FEgvAXKIcjBmSxR4+St6W
         LqkX3+Zv6//P+Je5G80xi5gcUUkoSRNGk8a+8/6+PnIFoNXUZGfVsPkLrICjqgB+ZKBq
         iv7KLxlxdr124I1X56VMSnevVTGxkEG18Ue717hpwtrJn9H2LF4wDuR8P1gsjJSgLHgK
         XzP6hJ22urNXJ3dMS48VBkc7k+bJeiL2sCEeNt96V9pxI6/oOM5ic27GZt6L0/QS5GqS
         vC18e0b/QNhnUjKq9Z4TvYibj86t+MbFFFyIUNwl38B+WUobUGiyx3tx4bR1Rrev83Xl
         tXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780669437; x=1781274237;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FRDWOfecK8ux/l9ItKCppD9VSQtTNi4U9dxBF07WZc=;
        b=AQfyYv5B41vHFVgONzZYw/wGZ4rzgCHEOn7IHYT8lHQSCdKzculnkKOhOwk9PLYlt/
         mW5GKJxsaVS2yTKrDkG6AZtDcnzhKFSpHTE4s7OpyAtsElZqB2ykAtpbV2P+aF/BesLz
         OuY3Vpw8IdfmK8UT0w6AlMNIjDBbv/IzB8DKBWBu7BvPCwlM7s/ssfMEiFljqKrLwpgo
         0zEDVGVp2TN/NBKmeOXXbj8yi7qf1Q1EQcL4T9AG1CToiHC1ErWy8EKo0TWjzKUXV8Ow
         +1lPyd1BVkXauwWsTv1TdelRvBPPuf0uFyb2hv75tnTs/2INl3FIKBV6294x5/0n1dLx
         pFbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WR0vhVROjCA71gm20OR6gv6QZROmdAvVq91fARvbUT3GBHi/83/DrqHivzNuI0RCF8QzGCnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTW/9dHB1XmK3DSZZctOzfWdHfPxFLdAq2cEmAGQKrsjycbapa
	0K2MWdf+rUNQTl0UaXLYxxnqOCN4kEO8vBhNH7my0rIHDHC35AkusvhQSyWUEbc/CAzYiuNC0oA
	K0A==
X-Received: from wrbdu15.prod.google.com ([2002:a05:6000:d4f:b0:45e:f31a:842f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e83:b0:490:af90:f9c2
 with SMTP id 5b1f17b1804b1-490c25b224dmr62007695e9.12.1780669436943; Fri, 05
 Jun 2026 07:23:56 -0700 (PDT)
Date: Fri,  5 Jun 2026 16:23:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605142351.2306664-1-elver@google.com>
Subject: [PATCH v2] Bluetooth: L2CAP: Fix UAF in channel timeout by holding
 conn ref
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
the connection is torn down while the timer is running or pending,
chan->conn can be freed, leading to a use-after-free when the timer
worker attempts to lock conn->lock:

| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
| Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
|
| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
| Workqueue: events l2cap_chan_timeout
| Call Trace:
|  <TASK>
|  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
|  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
|  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
|  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|  </TASK>
|
| Allocated by task 320:
|  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
|  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|
| Freed by task 322:
|  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
|  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
|  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
|  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
|  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
|  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
|  __fput+0x369/0x890 fs/file_table.c:510
|  task_work_run+0x160/0x1d0 kernel/task_work.c:233
|  get_signal+0xf5b/0x1120 kernel/signal.c:2810
|  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
|  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
|  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
|  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
e]
|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
[inline]
|  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| Last potentially related work creation:
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
|  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
|  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
|  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
|  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
|  __fput+0x369/0x890 fs/file_table.c:510
|  task_work_run+0x160/0x1d0 kernel/task_work.c:233
|  get_signal+0xf5b/0x1120 kernel/signal.c:2810
|  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
|  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
|  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
|  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
e]
|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
[inline]
|  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| Last potentially related work creation:
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|
| The buggy address belongs to the object at ffff8881298d9400
|  which belongs to the cache kmalloc-512 of size 512
| The buggy address is located 336 bytes inside of
|  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)

Fix it by having struct l2cap_chan hold a reference to l2cap_conn
(conn_ref) when the channel is added to the connection, and releasing it
in the channel destructor. This ensures the connection remains alive as
long as the channel exists. While conn and conn_ref point to the same
object, conn being NULL indicates it being torn down, while conn_ref's
only purpose is to associate its lifetime with the parent channel.

Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
Cc: <stable@vger.kernel.org>
Cc: Siwei Zhang <oss@fourdim.xyz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Fix UAF in channel timeout by holding conn ref.

v1: https://lore.kernel.org/r/20260603123111.2334409-1-elver@google.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..de3673149deb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -514,6 +514,7 @@ struct l2cap_seq_list {
 
 struct l2cap_chan {
 	struct l2cap_conn	*conn;
+	struct l2cap_conn	*conn_ref;
 	struct kref	kref;
 	atomic_t	nesting;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..7f331a31b723 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -422,6 +422,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (!chan->conn)
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -434,10 +437,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
-
 	mutex_unlock(&conn->lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -490,6 +493,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn_ref)
+		l2cap_conn_put(chan->conn_ref);
+
 	kfree(chan);
 }
 
@@ -594,6 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = conn;
+	chan->conn_ref = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -3160,12 +3167,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
+	if (!chan->conn)
+		goto unlock;
+
 	frames_to_ack = __seq_offset(chan, chan->buffer_seq,
 				     chan->last_acked_seq);
 
 	if (frames_to_ack)
 		l2cap_send_rr_or_rnr(chan, 0);
 
+unlock:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
-- 
2.54.0.1032.g2f8565e1d1-goog

