Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8B47CC63
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489910; cv=none; b=fSJ7bmpsEhRG7/y26P/hvNg5an9fMpQFdiAhPwYcW2OqfC6h1Un3GCFuO1ScPR8+ZocsQdG9S+DMQ7Zabx7bLx3wIoTK9+3r7+0nHAVb5AvOQzwYcSFzO959SvSLHlSQt5FQ2eoyZZBdcL1+7mSc7MpFqxJ0OJCBlbnuLdDC9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489910; c=relaxed/simple;
	bh=OBqzlD9jfV/N6cxv35diWNJEsY2b1p853Lmf3bTfNK0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZRM6MGSj/ezR9P8edX8TVQOEki5iHxw7075n1YFyxo/YmzFUzpCcZJCiTy1fePjvWaaCxFt+yQ7RRiquRtQLuo9GQn2Nyj0c87myEPqzJXEJquZVUjoWPFxv8hw2xi0LuqZa5Xsc4IIr1NbuCtc71YzDkmU0OuDHhn1CEI6My78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqZJtwXA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqZJtwXA"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490ae016853so18438205e9.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780489908; x=1781094708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X6divYi1rxsu/Q6KgNUKm4DM1iqc6TwjvJ7uBYHIwk4=;
        b=bqZJtwXAk3s3eGtCr5M4Aqzt+y0urRRqifm+GQlHHlc9LNqXA0MHW+hGiUqtqb4AO5
         HVtiSHTZmhVtiuSY1sSqJyUSDN8Jwm4UN7XgG0yFgtDshxmFkcQbfVeAuVMAeiMSoffW
         HLhCbNovcuGTJ8n7fyDXyRv/QYlHV4M+YydcPaUQUUbyhy3KCd2QpaftFWj1VadxtETN
         qqt16XjLEp+Gw/5l4NhIK0IXYt//Q1mfhNe3ObiWwNgBrjn+A/egbM8mT5nHzfzDoURW
         lYSWHD5oNj21YwmCninRBzIPwZ8gE6L+VQ9LfSsLNLLluuVAnIJIaEJL7jXAoUumrc99
         nxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489908; x=1781094708;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6divYi1rxsu/Q6KgNUKm4DM1iqc6TwjvJ7uBYHIwk4=;
        b=c4AK/5r5/ZAPvOWwINE7qVjBG6OFjzu2/KrlpLcKox9GIF1GfD8oYTvoX5jWlZgy6W
         aUvqGP39OgnyhUMs14VYC65tyb8fmZ97+i82ryoG1R4Ih7FKvAAOCnyLwe+DvahHdGEQ
         uJsBkkTkRKhfwHLBJjVirSzpzcyHIERwFn8XmtcBBE4empCubUYrjpmLRZyv5uQAwkxj
         oC3iqO7rSUUrXLV47CMLcBu4ULZDIj602u9vYE5w+XpSF3k5ZTmwq3oCL9O1BkgvSoV5
         kvjDGswyvs+FUQ2GNQ4OLR2sym3+Ar/wOoxTTMeSlOzkGZNNN/rzrFGLaLP2k9FJPKja
         9xKw==
X-Forwarded-Encrypted: i=1; AFNElJ9dA6eqFx1rlrI9WDwnKZ/nR4zGHz8N5l2gnZ2bl7AOj0eSxCA5ZAffM97cKysTUIvg1Hjskn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywiO/YZJQpm5fAplRfJi92+3Gu6xNrxwsbk+3vXNiVWWpon0rK
	5ndi0h0bPvkHdykgUbAhQsH4XUe7avRvdfbFsjnlu2Ts2nIMIcMN9vmkb3GBzEhgDHi0YZP65ft
	7PA==
X-Received: from wmbje15.prod.google.com ([2002:a05:600c:1f8f:b0:488:81f0:1a27])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b86:b0:490:b58b:a8cb
 with SMTP id 5b1f17b1804b1-490b60f87a7mr55948125e9.26.1780489907530; Wed, 03
 Jun 2026 05:31:47 -0700 (PDT)
Date: Wed,  3 Jun 2026 14:27:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260603123111.2334409-1-elver@google.com>
Subject: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

l2cap_chan_timeout() accesses chan->conn without holding a reference to
the connection object. If l2cap_conn_del() races and tears down the
connection while the timer is waiting for locks, it can result in a
use-after-free when the timer wakes up and attempts to acquire
conn->lock:

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
|  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
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

Fix it by holding a reference to the connection when the channel timer
is scheduled, and releasing it when the timer is either canceled or
executes to completion.

Since l2cap_chan_del() nullifies chan->conn to disassociate the channel
during teardown, the timer handler might read NULL from chan->conn even
if it held a reference. To address this, introduce a `timer_conn` field
to `struct l2cap_chan` to store the connection pointer associated with
the active timer. The timer handler uses this field to acquire locks and
release the connection reference, and skips channel closing operations
if chan->conn has already been nullified by teardown.

Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
Cc: <stable@vger.kernel.org>
Cc: Siwei Zhang <oss@fourdim.xyz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>
---
 include/net/bluetooth/l2cap.h | 18 ++++++++++++++++--
 net/bluetooth/l2cap_core.c    | 26 +++++++++++++++-----------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..83719777512e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -514,6 +514,7 @@ struct l2cap_seq_list {
 
 struct l2cap_chan {
 	struct l2cap_conn	*conn;
+	struct l2cap_conn	*timer_conn; /* for chan_timer */
 	struct kref	kref;
 	atomic_t	nesting;
 
@@ -835,6 +836,9 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
 	mutex_unlock(&chan->lock);
 }
 
+struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
+void l2cap_conn_put(struct l2cap_conn *conn);
+
 static inline void l2cap_set_timer(struct l2cap_chan *chan,
 				   struct delayed_work *work, long timeout)
 {
@@ -843,8 +847,13 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
 
 	/* If delayed work cancelled do not hold(chan)
 	   since it is already done with previous set_timer */
-	if (!cancel_delayed_work(work))
+	if (!cancel_delayed_work(work)) {
 		l2cap_chan_hold(chan);
+		if (work == &chan->chan_timer && chan->conn) {
+			l2cap_conn_get(chan->conn);
+			chan->timer_conn = chan->conn;
+		}
+	}
 
 	schedule_delayed_work(work, timeout);
 }
@@ -857,8 +866,13 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 	/* put(chan) if delayed work cancelled otherwise it
 	   is done in delayed work function */
 	ret = cancel_delayed_work(work);
-	if (ret)
+	if (ret) {
+		if (work == &chan->chan_timer && chan->timer_conn) {
+			l2cap_conn_put(chan->timer_conn);
+			chan->timer_conn = NULL;
+		}
 		l2cap_chan_put(chan);
+	}
 
 	return ret;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..491b03bf6903 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -406,7 +406,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 					       chan_timer.work);
-	struct l2cap_conn *conn = chan->conn;
+	struct l2cap_conn *conn = chan->timer_conn;
 	int reason;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
@@ -421,23 +421,27 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 * this work. No need to call l2cap_chan_hold(chan) here again.
 	 */
 	l2cap_chan_lock(chan);
+	chan->timer_conn = NULL;
+
+	if (chan->conn) {
+		if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
+			reason = ECONNREFUSED;
+		else if (chan->state == BT_CONNECT &&
+			 chan->sec_level != BT_SECURITY_SDP)
+			reason = ECONNREFUSED;
+		else
+			reason = ETIMEDOUT;
 
-	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
-		reason = ECONNREFUSED;
-	else if (chan->state == BT_CONNECT &&
-		 chan->sec_level != BT_SECURITY_SDP)
-		reason = ECONNREFUSED;
-	else
-		reason = ETIMEDOUT;
-
-	l2cap_chan_close(chan, reason);
+		l2cap_chan_close(chan, reason);
 
-	chan->ops->close(chan);
+		chan->ops->close(chan);
+	}
 
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 
 	mutex_unlock(&conn->lock);
+	l2cap_conn_put(conn);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
-- 
2.54.0.1013.g208068f2d8-goog

