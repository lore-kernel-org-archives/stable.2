Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B71340286
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977559; cv=none; b=nmBMpYFRD1SqjT8b/iKwSHRniv4374JpLMduRBAlk094VZIODpTxVq76Odg5eig4y9J/gh15tq4e+vtZhnN7GqsGz7/JEEHZLhWQgNP/cvV+0w8tbUnaDx7m1KN1HUcb86HCbJIflCKppaonNPMth0CQBx15yVdLb/5KyToweXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977559; c=relaxed/simple;
	bh=q/AHiGnthyvgtBmxM4TEoqz0xx9NYBEy6hWeKAAXYe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y8Tw76ol/t9Pz9mj2Qf7pCKV8+kcUPeQRDH0ApeeZN4A6bKx+sk4Zlt6PJz5R/MdtkFRSTCHIGdsh+hotLEwnxI1I/SEtGL4kYUOuim0CRLdWchqmnSaPDeDsDuAk21s4ujo6K+/WRRQPFIllTIeIpN9d9J3v5jX6MD/1ig3wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbpIjY4n; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbpIjY4n"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so1649966a12.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785977557; x=1786582357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yocKpwMyl2wyny5WKpsymuH/pw2YCbX/sr/ky/wNobA=;
        b=wbpIjY4nDWc4jRTG9KAjdwqnRyqCar6mNpr7SXe5N7el9tpmw3dRNlCrqNsBrCvPUi
         PmL4R3VZGPnBJeaVsAXVYhIGX/NUth1JRd81FsICtQ/fA/UIVBI7v+a9+8wVSpwocstu
         E61ERrY24HsggBJp0DT/s1y6b/Y3AAe2eU6SGHr9CWRWPkwE5id5gXoQDTwTanXuqpUP
         IuD2QWhCUVj9mBWFeLfyXWd/BuZ7VzwPhdAf24m4ASL5mUk8p8UXjqWJlIsPWf7TajD4
         9W+tEPXIUmHVI5WrXcJNwmSrB6vOyQBfloUGw+bIoq1PKr5lUsggcf1r0Lb+8l4s4qhG
         bSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785977557; x=1786582357;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yocKpwMyl2wyny5WKpsymuH/pw2YCbX/sr/ky/wNobA=;
        b=HDDSTxmDeQl2nYQbZEjrkhY/64o2LsE/Gsmye41av96Psg4V2/1fyNHLEeUVSoo0A3
         /nmiTbGhzCb70fMc5h1Wpj/w7dlfyT/wCpvxBHu1vXL20PuhPZqb0AkP3oqe7/Fvj6KC
         WJOkaE8FfLG9U4L6L+IlQIY39mUG+pd6+F5VUoDGs26LhwY5Hq5VWBCxLYNIbsdfnhgU
         PGEs6awUMIjE+g5v+ViNjv5fpKCIYlV0HhwlhVgwbC8I/p7ER22QdAjRJBu99cWS50h7
         G7MHnccGxNof1R/7fMTqm2o+/bDd8Y0BIqlFJd9SB1323+mjez//PPiU/8oVLOpIlNu2
         UaAg==
X-Gm-Message-State: AOJu0Yy9HZJq2lSzyRnTs+5Ia/3V7tAWeQpIHUy/t4EOXrYJEliOy61c
	dO1OwoTGPneAdR3UKe3fHT//cYQZM1ebgxB8pWI06ZaQdSv//CfxhxXpz7xCVg4WwNeOidokOXW
	1rJVor5ymArXOm60pzqHqzCjEKhNoTzM1XnWdLu1ubnIGROiMLYOGQs4ROrbFo4zliWTJdX97Eo
	dcoqo3y/KxkEAQ94feZcPfKEUyPadJgls=
X-Received: from pges1.prod.google.com ([2002:a63:a301:0:b0:c9a:eb48:4a8])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1e:b0:3b4:7e2d:a3c2
 with SMTP id adf61e73a8af0-3cb85ec567bmr10484830637.18.1785977556415; Wed, 05
 Aug 2026 17:52:36 -0700 (PDT)
Date: Thu,  6 Aug 2026 00:52:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260806005214.179730-1-tkjos@google.com>
Subject: [PATCH 6.1.y] Bluetooth: L2CAP: Fix UAF in channel timeout by holding
 conn ref
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marco Elver <elver@google.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Marco Elver <elver@google.com>

[ Upstream commit b66774b48dd98f07254951f74ea6f513efe7ff8b ]

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
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| The buggy address belongs to the object at ffff8881298d9400
|  which belongs to the cache kmalloc-512 of size 512
| The buggy address is located 336 bytes inside of
|  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)

Fix it by having chan->conn hold a reference to l2cap_conn (via
l2cap_conn_get) when the channel is added to the connection, and
releasing it in the channel destructor. This ensures the l2cap_conn
remains alive as long as the channel exists.

A new FLAG_DEL channel flag is introduced to indicate that the channel
has been deleted from its connection. l2cap_chan_del() atomically sets
this flag using test_and_set_bit() instead of setting chan->conn to
NULL. All asynchronous workers (l2cap_chan_timeout, l2cap_ack_timeout,
l2cap_monitor_timeout, l2cap_retrans_timeout) and l2cap_chan_send()
check FLAG_DEL to determine whether the channel has been torn down,
rather than testing chan->conn for NULL.

Fixes: 8c8e620467a7 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
Cc: <stable@vger.kernel.org>
Cc: Siwei Zhang <oss@fourdim.xyz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Change-Id: Ie9862976d25c3e6d386689cd198ebe5ab4cc5509
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 33 ++++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 97ad02840530e32d3860323377103a31d53c8f0b..ba230c3cf43155e06135cac86a8a92a601680afa 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -743,6 +743,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_DEL,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1da637f81db34ca6567dc2c2fda1d10b1d3b6877..1b3f3dfb3a5ee82254d29c92cdff90e79994c645 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -415,7 +415,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_put(chan);
 		return;
 	}
@@ -426,6 +426,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -438,10 +441,11 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -494,6 +498,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn)
+		l2cap_conn_put(chan->conn);
+
 	kfree(chan);
 }
 
@@ -625,7 +632,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -680,30 +687,26 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
-	struct l2cap_conn *conn = chan->conn;
-
 	__clear_chan_timer(chan);
 
-	BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
+	BT_DBG("chan %p, err %d, state %s", chan, err,
 	       state_to_string(chan->state));
 
 	chan->ops->teardown(chan, err);
 
-	if (conn) {
+	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
 		/* Delete from channel list */
 		list_del(&chan->list);
 
 		l2cap_chan_put(chan);
 
-		chan->conn = NULL;
-
 		/* Reference was only held for non-fixed channels or
 		 * fixed channels that explicitly requested it using the
 		 * FLAG_HOLD_HCI_CONN flag.
 		 */
 		if (chan->chan_type != L2CAP_CHAN_FIXED ||
 		    test_bit(FLAG_HOLD_HCI_CONN, &chan->flags))
-			hci_conn_drop(conn->hcon);
+			hci_conn_drop(chan->conn->hcon);
 	}
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
@@ -1930,7 +1933,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -1951,7 +1954,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2566,7 +2569,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	int err;
 	struct sk_buff_head seg_queue;
 
-	if (!chan->conn)
+	if (test_bit(FLAG_DEL, &chan->flags))
 		return -ENOTCONN;
 
 	/* Connectionless channel */
@@ -3167,12 +3170,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
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
2.55.0.629.g250fe7f194-goog

