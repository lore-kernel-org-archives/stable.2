Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC1442FA2
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391512; cv=none; b=VlK2vndWzgZr/b8xgBijnLFwRSBJ3uoXmOE4P7ZL1zDRnRmk+3a2q+VfYUXvIhHdJk+HvqwF/jZ8BtnBohFg5HXG5zmrum5gxiL/5uUq4KGDq6kdkJPpcBdXbxFX+KxMiRioEqkkBIUtEiH3PomOY1+2wFwoJe8dcvVOuaTI3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391512; c=relaxed/simple;
	bh=9X5v9x2qJ++s4m6kYWwDxpYQ7VMPOvKpuQHVJvm9+Dg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=czjmZzh4jQbu1d2/XBMuXVi73WjJ4mcKfRht5r/U7sT/zsIBTwj6HQv8K09SNrqQdZ4LWoRx6k9anOIe9DpUFLRl3v7bbU5+cAhN7/yhtt1XltK8IKQHo21bwnquAPdwSTiJPGC5371scUJIY/QlzCQB6z7T27q4Vup4I9WEbmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEZZfmlk; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tkjos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEZZfmlk"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso20806b3a.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786391509; x=1786996309; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Sfabr1PQjZ1G5t8c1POa3mmhjMQsDODMyz/F+thDNs=;
        b=MEZZfmlkLoLfFSxVLnC9O+0iWXcMfOnnxDhmKJZTyPAy/Rixc9iXi7lVuS2dJvgrmO
         M7di692k2XOVj3iwU5Yhy3FXzUvg1CToHS9G8rkXYpOm9CA8n0tl/OYext9dD3w8WXDV
         QhpAR0tiRI4OvAsDesKDzCtp38zRcviY/XCryefeak/RFGrEjj1zBO+MFWsNytcOHKm2
         h/2MYzlMTvyyPM0aYPaepHkXMLybGtriWJZUP7Cexy4elx1O3bz2djbGodCBJ6Yshmcq
         bdCTJzzozgXH1oTjOdd94a05BEx84l3hoQNGLXKNAjcWXfNnLpcBLPq9KlF4B1AUQnJc
         sXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391509; x=1786996309;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Sfabr1PQjZ1G5t8c1POa3mmhjMQsDODMyz/F+thDNs=;
        b=fuiN2QBMuUIJwqNOsjtzJRDLMfZ3IIHXoBNAluInCIQmWKeEezRnk8hQI5vDChW3o/
         BkNCtYTgnd45S7RNECam8Rf13QPlYFIf9nA2xL/S7bIMxuX0I/oQFYZmfhQZ24V+FzIV
         VrsJvkwZpizwibOdeqC0BCl/618MQuU0Eb1405BwvHO+RA+FSNsdciZ1No/dOsIfO9Uq
         6NfXAzYMTF5W0xu98NFfY/c+eA/xffek/rvWN1iNIkGBsaHY10uk+Jv5FkCbWa6emtrP
         hh3YBbuVnpOw+GkeqrRLnOk9WOKCxi5wkl5P8oK4k951ynAD4keu2jqP8rqRK+yjT+41
         /v8w==
X-Gm-Message-State: AOJu0YzBsvBTNE5Wkw3IQKz5dFySHM5dVXfUyqrShcYO1BWZLrcLBHKj
	iDZuTKUl5OrfxpkUDI2oZ1mFJ8wbJs2kiyrQhvU26BWXXUlSYAQh+RDFHKnp+SWxM3rKNLb85q1
	0l77KrJzspHGsGoRrXGTMVwgSofKezS9CUBGKvlL99J9bc+l4HbV6r1ddUCUOcgTNPTivjEq3eL
	cEDSfc8+4S7myCICNv+6tPhrSleD0ebKE=
X-Received: from pgaf24.prod.google.com ([2002:a63:3818:0:b0:cbe:a5e8:c0dc])
 (user=tkjos job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4519:b0:847:968d:b101
 with SMTP id d2e1a72fcca58-84f2e03916amr54078618b3a.21.1786391509230; Mon, 10
 Aug 2026 12:51:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:51:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810195147.4121080-1-tkjos@google.com>
Subject: [PATCH v2 1/2 5.10.y, 5.15.y] Bluetooth: L2CAP: Fix UAF in channel
 timeout by holding conn ref
From: Todd Kjos <tkjos@google.com>
To: stable@vger.kernel.org
Cc: kernel-team@android.com, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Marco Elver <elver@google.com>, 
	Sasha Levin <sashal@kernel.org>, Todd Kjos <tkjos@google.com>
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
Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2:
- Reinstated NULL check on "conn"
- Added followon patch to the series

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 36 +++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6e48bd56f4c3b78e459d184140a9a3648391755a..7a8322a40554361b2e5361e7a83c624fa844f3fd 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -776,6 +776,7 @@ enum {
 	FLAG_ECRED_CONN_REQ_SENT,
 	FLAG_PENDING_SECURITY,
 	FLAG_HOLD_HCI_CONN,
+	FLAG_DEL,
 };
 
 /* Lock nesting levels for L2CAP channels. We need these because lockdep
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ed2388e31c6c7fe9236dfa23376bf977541bf9fc..12ac9726381a0b927fb9df380b8015c9a28b0a84 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -435,7 +435,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn) {
+	if (!conn || test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_put(chan);
 		return;
 	}
@@ -446,6 +446,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (test_bit(FLAG_DEL, &chan->flags))
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -458,10 +461,11 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->chan_lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -511,6 +515,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn)
+		l2cap_conn_put(chan->conn);
+
 	kfree(chan);
 }
 
@@ -593,7 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
-	chan->conn = conn;
+	chan->conn = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -648,31 +655,28 @@ void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
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
-		struct amp_mgr *mgr = conn->hcon->amp_mgr;
+	if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
+		struct amp_mgr *mgr = chan->conn->hcon->amp_mgr;
+
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
 
 		if (mgr && mgr->bredr_chan == chan)
 			mgr->bredr_chan = NULL;
@@ -2036,7 +2040,7 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2057,7 +2061,7 @@ static void l2cap_retrans_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
-	if (!chan->conn) {
+	if (test_bit(FLAG_DEL, &chan->flags)) {
 		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
@@ -2682,7 +2686,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	int err;
 	struct sk_buff_head seg_queue;
 
-	if (!chan->conn)
+	if (test_bit(FLAG_DEL, &chan->flags))
 		return -ENOTCONN;
 
 	/* Connectionless channel */
@@ -3272,12 +3276,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
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
2.55.0.679.g6767b8d81c-goog

