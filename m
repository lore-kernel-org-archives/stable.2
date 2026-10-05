Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31B44E0201
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231402; cv=none; b=QdlcyGLVKjcEaKchBWYwwLjFA+Df2xUg1ZSicH1LXwXcVGHuEpZulWWo+LDordoS8PPVCB8hb+ea8wkmRT2smWafZsKEvg0Y+2scwYC04NbpOG4wJbbOsuxxDZ7pWRI5R5xkDUZ1+nFlRWVMbivE0pT/kXb5YBJzVxwELt+q0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231402; c=relaxed/simple;
	bh=dC7SxuZKh17BNT2uOpuctHpedjBDGmGXuzMUN6RuMzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlaIfT0k3TJt2aDGzedecSaY+NcrRANbFy7MjPcTnGZykdX0aTYqnOKCbTw0z+sQ+Dk0n271zVGrgRY6MFCp//nYH7FxHTpJ9ssDK9Cuzxb3k5uCLEft8kx9Vpob+i9cp211Vui8c99mYsBJUF7qTsy/M/mQmnUZeaMkQsjYYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2J7ky/W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2J7ky/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590F71F00898;
	Mon,  5 Oct 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231400;
	bh=sQBdCc5ZNebt6sdsjeOd4kIKgzKRTtpPHLOTsQjIVpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P2J7ky/Wrjxpnp3aM5Kx2cDGFtRiy7gML6igNNIvRBGPvQib8WF+PzHRIJAmeiwAV
	 8mX49YBV6dN5Wmuvb85SByWo6Gp62osSUJKEwU0wrr3DnaIO3D4vYXGZzYbZfdKaoA
	 Ud3RJbiazeDBmTFVuM6474kEJxPoOvwBt7v3URgQn8EQiwPF635x119fVy4TcY+YVM
	 S42rt2RNg0USLF/gp6ic+eI+eGpUziPViPJoAkv5FNWaLNzuyz2/hvBjOqTtWgp+zb
	 iQESOiksPa9GXTQ0994rkPEOCrv8P/5uQYw4rLyNjxWxbhdtS8/Pc/NCjs7yZGyTQj
	 2/efq+V11fWDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] tty: abort break signalling on hangup
Date: Mon,  5 Oct 2026 16:16:35 -0400
Message-ID: <20261005201512.3067187-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005201512.3067187-1-sashal@kernel.org>
References: <2026100529-visitor-zoning-adb2@gregkh>
 <20261005201512.3067187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 845a2737e0f5ffe5ca8d38de556012b0c9472cdd ]

The break ioctls can race with hangup and end up calling into a tty
driver for a device that is already gone or powered down.

Drivers must handle this race, but TCSBRK and TCSBRKP should still be
aborted to avoid calling back into the driver after a user-controlled
timeout (possibly even after the tty has been reopened).

Note that drivers should disable any break state on shutdown so just
return on hangup (calling break_ctl() again is racy and will most likely
fail for drivers handling the race).

Fixes: f34d7a5b7010 ("tty: The big operations rework")
Cc: stable <stable@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260903163736.1499280-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 36 +++++++++++++++++++++++++++---------
 include/linux/tty.h  |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c92416df20d6e..d672b17aaff98 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -636,6 +636,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 
 	tty_ldisc_hangup(tty, cons_filp != NULL);
 
+	wake_up_interruptible(&tty->break_wait);
+
 	spin_lock_irq(&tty->ctrl.lock);
 	clear_bit(TTY_THROTTLED, &tty->flags);
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -2459,6 +2461,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * send_break	-	performed time break
  * @tty: device to break on
  * @duration: timeout in mS
+ * @file: file object
  *
  * Perform a timed break on hardware that lacks its own driver level timed
  * break functionality.
@@ -2466,8 +2469,9 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Locking:
  *	@tty->atomic_write_lock serializes
  */
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
+	long timeout;
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
@@ -2481,13 +2485,26 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		return -EINTR;
 
 	retval = tty->ops->break_ctl(tty, -1);
-	if (!retval) {
-		msleep_interruptible(duration);
-		retval = tty->ops->break_ctl(tty, 0);
-	} else if (retval == -EOPNOTSUPP) {
-		/* some drivers can tell only dynamically */
-		retval = 0;
+	if (retval) {
+		if (retval == -EOPNOTSUPP) {
+			/* some drivers can tell only dynamically */
+			retval = 0;
+		}
+		goto out_unlock;
+	}
+
+	timeout = msecs_to_jiffies(duration);
+	timeout = wait_event_interruptible_timeout(tty->break_wait,
+						   tty_hung_up_p(file),
+						   timeout);
+	/* return early on hangup only */
+	if (timeout > 0) {
+		retval = -EIO;
+		goto out_unlock;
 	}
+
+	retval = tty->ops->break_ctl(tty, 0);
+out_unlock:
 	tty_write_unlock(tty);
 
 	if (signal_pending(current))
@@ -2740,10 +2757,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 * This is used by the tcdrain() termios function.
 		 */
 		if (!arg)
-			return send_break(tty, 250);
+			return send_break(file, tty, 250);
 		return 0;
 	case TCSBRKP:	/* support for POSIX tcsendbreak() */
-		return send_break(tty, arg ? arg*100 : 250);
+		return send_break(file, tty, arg ? arg * 100 : 250);
 
 	case TIOCMGET:
 		return tty_tiocmget(tty, p);
@@ -3112,6 +3129,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
+	init_waitqueue_head(&tty->break_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl.lock);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 168e57e40bbb8..9501a8640baa8 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -188,6 +188,7 @@ struct tty_struct {
 	struct fasync_struct *fasync;
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
+	wait_queue_head_t break_wait;
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-- 
2.53.0

