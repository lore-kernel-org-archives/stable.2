Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E203EDE61
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496208; cv=none; b=aqql8TTGUhSQJR6R/0Kq++FC2WiNF+eZZBbXW0za8cZWE36/Uwq5YUvFZI1JQA/m6E0JIkL4SWF+7Eu67x8fNxs7ugO1w6RUAn1N/e8KIn4iG6dvUQvvJTO7TfTRsSsIEG5PpM/PAKAjfd61XJcS6ACPpxrSZK5aIQi3OETQ/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496208; c=relaxed/simple;
	bh=kloYd8hj9ymhhOcVIAL9ZCV91W2yj2qJjk9x0q35lBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6hVjYZskF22gumRaOiy92snHoEwSi9gtzfLQJXzO7AD8rmHcz9cNy9FP58zGiRFFVBrVqGZbJDQrscl+JNJTKIJmfNKUl9RJh9K98VN1YVdbwy8vnz3AYnyIiFzvf4AuBJ1TCPJPyU5JISIe0xSUxMjbnjX3MzTIb6dIgUQe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+WcdiPv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+WcdiPv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ca7605ce4bso673935ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496199; x=1784100999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M+Z591dKHRQIbm/9qQxgkj49e7bXoy6gVEbYhl8bF6k=;
        b=S+WcdiPvAta9FaEgJihIg0HHvlUJ4sUjohEihFcl6ShfYxc8ekd3eUMsQO2Z/TaKqB
         8MuO5kVT7YMNnCNdcReC1d8HJQ5oOEs1ekVeSWsBkQ/FzLsjPP2CafkcWxII3trPtOQp
         /3sIs1bxg7OPQxL3T9lXYWldr5vgnR+Vvgfy+MgQ9xQdgkb86OykKUVtCrC52PnP79YK
         w1/1+PmFUojM3AxUKHJLzqqieVMtGW8xXmZnyLYQK/hHnag34xz00A+49186Tv+atqpq
         zngviA1tQd/TAI8JJUfrjz71YmKzuyPM/YHAm0i4qpctDBQ165H1f+8cgnUO8TKjKDSi
         pEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496199; x=1784100999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+Z591dKHRQIbm/9qQxgkj49e7bXoy6gVEbYhl8bF6k=;
        b=AjO/7Cz7UTu2Eyyr+yWgW4+lg8NGb8V71s9LQP/WbKrTHqTnkXClUv8H0qrBuTpbEV
         hC1gaOIf4TLHft7nz4TieQjoif0HHjnrzhVcWGJiLyCQjLcXZxD82ppST4Iweo0Nv8Ay
         D/yOOTevjPe/CQ4XGB08XA23KLMMLuiKDKwFyz/liitV/qKh5lzWMiGY2ibhL+STEJ4z
         xgF9YAw9P+uNjmNNslbD5tFG2IEpPxz6aJOQ2v5QYPVn+6MEWUt83vUZxjnM8HzE8YGW
         RCRgwoTLZwm6yh0SRg55n8e29WKmtHGWNzDwgCR9DC0rStVo4ImMMRX8fc/13P/l4F8m
         0g6w==
X-Forwarded-Encrypted: i=1; AHgh+RpmT0g30JDxTBvGRzThd89UteKDWmAy3h0hlROhyvbLgAaaCIW2fkLTBHxfDN5t1XZdRQ+3rZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9Sztv4l5nftnwfnccOYnLqP1mosYDuTqja2RZdPNEgGsZTtB
	9jGnmGUfw3OUoXNAV69UdebAIySmyOrdHGVKzhoSx8AyAUr4DEEp1U8S
X-Gm-Gg: AfdE7cl27F7REu2izknFohMa5ZdkqgMuPCebqUUxTTupeQEjHOVX9PD3ikNKcdUYe1l
	HTv+gzO7IgyNfVGTXd41xC4/evTaPuogjFpzAWIIeBL6/i68yR8zNmookoN3W9fdwE9U+cAmxGA
	N3CqelIrafyaund9xKGKe78uCBk8QHg12vc3mjVdx4U/FFPSbejc85bVh0LHLV7dIVKXmn4X3a8
	hajWLAXVEwLVr9iZckVqHmYOpP1mAxsZENJszRSlvUnHLjeZ9hYV09wxvSfdzrYb7NL7TsMn7Gd
	H2sdAxAKYFEca31jAFV05BloYjBCU2LxIyYDXK7O9fohkxWPDcOx2e03FQjcGa0qnDH627Ixm3v
	6hV6ghMNW2siWOya7D+IiGCwa/uPZWQBF9eVHKQ08MXb8ek5oDawhRo2tzsmvK3HKFDfE3ZuHRQ
	JXCovC2H5kprNY42CEVg==
X-Received: by 2002:a17:90b:3d87:b0:37d:f70f:fbf8 with SMTP id 98e67ed59e1d1-3893d33d854mr1202661a91.0.1783496198724;
        Wed, 08 Jul 2026 00:36:38 -0700 (PDT)
Received: from kali ([122.162.146.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm25193670eec.29.2026.07.08.00.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:36:38 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] gpib: fix use-after-free between iboffline() detach and in-flight I/O
Date: Wed,  8 Jul 2026 03:36:18 -0400
Message-ID: <20260708073618.147714-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <akKZBpW135YW2Def@egonzo>
References: <akKZBpW135YW2Def@egonzo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iboffline() calls board->interface->detach(), which frees
board->private_data, with no guarantee that a read/write/command
ioctl already in progress on that board has finished touching it.

v1 of this fix took board->big_gpib_mutex around the detach() call.
That was wrong on two counts, both pointed out by Dave Penkler:

 1. iboffline() is reached from ibioctl() via the IBONL ioctl, which
    is dispatched while big_gpib_mutex is already held. Taking it
    again inside iboffline() self-deadlocks.

 2. IBRD/IBWRT/IBCMD explicitly drop big_gpib_mutex before calling
    into board->interface, because those calls can block for the
    duration of board->usec_timeout. So even without the deadlock,
    the mutex was never actually held during the in-flight callback
    it was meant to exclude.

Fix this by tracking in-flight callbacks directly instead of
overloading big_gpib_mutex. Add board->io_active, an atomic counter
incremented around the body of read_ioctl(), write_ioctl(), and
command_ioctl() (which is where board->interface is dereferenced,
via ibrd()/ibwrt()/ibcmd()), and board->io_drain_wait, a waitqueue
woken when the counter reaches zero.

iboffline() waits uninterruptibly on io_drain_wait before calling
detach(). big_gpib_mutex is already held at that point (via IBONL),
which blocks any *new* I/O ioctl from starting, so the wait only
drains whatever was already in flight; it does not need a timeout,
and adding one would just let detach() free private_data out from
under a callback that is still running.

gpib_unregister_driver() also calls iboffline(), but unlike the
IBONL path it holds no lock at all, so a fresh ioctl could still
race the detach()/board->interface=NULL sequence there. Take
big_gpib_mutex around that call site to close the same window.

The KASAN reproducer from v1 (kprobe on a driver read callback,
concurrent kfree from a detach kthread) demonstrates the class of
bug this closes: a blocking read callback dereferencing freed
private_data. It is reproduced against board->io_active rather than
the mutex in this version; behavior against the harness is
unchanged, since the harness only exercises the missing exclusion
between detach() and an in-flight read, not the specific mechanism
used to provide it.

Fixes: e6ab504633e4 ("staging: gpib: Destage gpib")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/gpib/common/gpib_os.c     | 21 +++++++++++++++++++++
 drivers/gpib/common/iblib.c       | 27 ++++++++++++++++-----------
 drivers/gpib/include/gpib_types.h |  9 +++++++++
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/gpib/common/gpib_os.c b/drivers/gpib/common/gpib_os.c
index 5909274dd..86921856f 100644
--- a/drivers/gpib/common/gpib_os.c
+++ b/drivers/gpib/common/gpib_os.c
@@ -912,6 +912,7 @@ static int read_ioctl(struct gpib_file_private *file_priv, struct gpib_board *bo
 	mutex_unlock(&file_priv->descriptors_mutex);
 
 	atomic_set(&desc->io_in_progress, 1);
+	atomic_inc(&board->io_active);
 
 	/* Read buffer loads till we fill the user supplied buffer */
 	while (remain > 0 && end_flag == 0) {
@@ -944,6 +945,8 @@ static int read_ioctl(struct gpib_file_private *file_priv, struct gpib_board *bo
 		retval = copy_to_user((void __user *)arg, &read_cmd, sizeof(read_cmd));
 
 	atomic_set(&desc->io_in_progress, 0);
+	atomic_dec(&board->io_active);
+	wake_up(&board->io_drain_wait);
 	atomic_dec(&desc->descriptor_busy);
 
 	wake_up_interruptible(&board->wait);
@@ -1003,6 +1006,7 @@ static int command_ioctl(struct gpib_file_private *file_priv,
 	 */
 
 	atomic_set(&desc->io_in_progress, 1);
+	atomic_inc(&board->io_active);
 
 	do {
 		fault = copy_from_user(board->buffer, userbuf, (board->buffer_length < remain) ?
@@ -1038,6 +1042,8 @@ static int command_ioctl(struct gpib_file_private *file_priv,
 	 */
 	if (!no_clear_io_in_prog || fault)
 		atomic_set(&desc->io_in_progress, 0);
+	atomic_dec(&board->io_active);
+	wake_up(&board->io_drain_wait);
 	atomic_dec(&desc->descriptor_busy);
 
 	wake_up_interruptible(&board->wait);
@@ -1085,6 +1091,7 @@ static int write_ioctl(struct gpib_file_private *file_priv, struct gpib_board *b
 	mutex_unlock(&file_priv->descriptors_mutex);
 
 	atomic_set(&desc->io_in_progress, 1);
+	atomic_inc(&board->io_active);
 
 	/* Write buffer loads till we empty the user supplied buffer */
 	while (remain > 0) {
@@ -1118,6 +1125,8 @@ static int write_ioctl(struct gpib_file_private *file_priv, struct gpib_board *b
 		fault = copy_to_user((void __user *)arg, &write_cmd, sizeof(write_cmd));
 
 	atomic_set(&desc->io_in_progress, 0);
+	atomic_dec(&board->io_active);
+	wake_up(&board->io_drain_wait);
 	atomic_dec(&desc->descriptor_busy);
 
 	wake_up_interruptible(&board->wait);
@@ -2115,8 +2124,18 @@ void gpib_unregister_driver(struct gpib_interface *interface)
 			if (board->use_count > 0)
 				pr_warn("gpib: Warning: deregistered interface %s in use\n",
 					interface->name);
+			/*
+			 * Unlike the IBONL ioctl path, nothing else holds
+			 * big_gpib_mutex here, so a fresh ioctl could race
+			 * this teardown and dispatch into board->interface
+			 * right as it becomes NULL below. Hold the mutex
+			 * across iboffline() and clearing board->interface
+			 * so ibioctl() cannot enter until this is done.
+			 */
+			mutex_lock(&board->big_gpib_mutex);
 			iboffline(board);
 			board->interface = NULL;
+			mutex_unlock(&board->big_gpib_mutex);
 		}
 	}
 	for (list_ptr = registered_drivers.next; list_ptr != &registered_drivers;) {
@@ -2149,6 +2168,8 @@ void init_gpib_board(struct gpib_board *board)
 	init_waitqueue_head(&board->wait);
 	mutex_init(&board->user_mutex);
 	mutex_init(&board->big_gpib_mutex);
+	atomic_set(&board->io_active, 0);
+	init_waitqueue_head(&board->io_drain_wait);
 	board->locking_pid = 0;
 	spin_lock_init(&board->locking_pid_spinlock);
 	spin_lock_init(&board->spinlock);
diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
index 07a30d520..0de6ca50c 100644
--- a/drivers/gpib/common/iblib.c
+++ b/drivers/gpib/common/iblib.c
@@ -257,22 +257,27 @@ int iboffline(struct gpib_board *board)
 	}
 
 	/*
-	 * Acquire big_gpib_mutex before calling detach() to prevent a
-	 * use-after-free race. I/O callbacks (read/write/command) hold
-	 * big_gpib_mutex while caching board->private_data on their stack.
-	 * Without this lock, iboffline() can kfree(board->private_data)
-	 * inside detach() while an I/O callback is still running and holds
-	 * a stale pointer to the freed memory.
+	 * iboffline() is always called with board->big_gpib_mutex already
+	 * held (via the IBONL ioctl), so it cannot take that mutex itself.
+	 * That mutex is also dropped by IBRD/IBWRT/IBCMD before they call
+	 * into board->interface, since those calls can block for a long
+	 * time, so it never actually excludes an in-flight read/write/
+	 * command callback in the first place.
 	 *
-	 * Affected board drivers: cb7210, ines_gpib, tnt4882 (all delegate
-	 * to nec7210_read/pio_read which blocks in wait_event_interruptible
-	 * for up to board->usec_timeout microseconds while holding priv).
+	 * board->io_active counts callbacks currently executing inside
+	 * board->interface. Wait here, uninterruptibly and without a
+	 * timeout, for it to reach zero before calling detach(). Since
+	 * big_gpib_mutex is held, no *new* I/O ioctl can start while we
+	 * wait, so this only drains whatever was already in flight.
+	 * Returning early would let detach() free board->private_data
+	 * while that in-flight callback is still dereferencing it, which
+	 * is the use-after-free this is closing.
 	 */
-	mutex_lock(&board->big_gpib_mutex);
+	wait_event(board->io_drain_wait, atomic_read(&board->io_active) == 0);
+
 	board->interface->detach(board);
 	gpib_deallocate_board(board);
 	board->online = 0;
-	mutex_unlock(&board->big_gpib_mutex);
 	dev_dbg(board->gpib_dev, "board offline\n");
 
 	return 0;
diff --git a/drivers/gpib/include/gpib_types.h b/drivers/gpib/include/gpib_types.h
index 28b73157f..1c1f29c12 100644
--- a/drivers/gpib/include/gpib_types.h
+++ b/drivers/gpib/include/gpib_types.h
@@ -288,6 +288,15 @@ struct gpib_board {
 	 * store additional variables for this board
 	 */
 	void *private_data;
+	/*
+	 * Counts read/write/command callbacks currently executing in
+	 * board->interface. iboffline() waits for this to reach zero
+	 * before calling detach(), so its teardown of private_data
+	 * cannot race an in-flight callback still dereferencing it.
+	 */
+	atomic_t io_active;
+	/* Woken when io_active reaches zero, so iboffline() can wait for drain. */
+	wait_queue_head_t io_drain_wait;
 	/* Number of open file descriptors using this board */
 	unsigned int use_count;
 	/* list of open devices connected to this board */
-- 
2.53.0

