Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501F391E7C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232788; cv=none; b=jysZBfkTTKk69Z5ZY8zfcj7SQK2YG4KxbZqFHPKf2GyLt7n1FlmflGpUuyr5Wt+34yB6zxer7V4+oWbZIHO3OAMBJfTFGi00m6Ze6I4MZQy3g7d6qhR3OOrWK7elkAf1OWN+uZVDZdgYYbwRBm2gEfig5SXxJOX+B9sD3ypPZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232788; c=relaxed/simple;
	bh=GlpoabRe+Jrlx60LAymRP/VyrHLhmDOc1K6lOnRWb2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXcW+DH0wDP/2BW20kFI3OchctPSla7f4rhAkSHbx4RRa3dYwY+hazT+Te3V/4B3MuHSsdEUchruqWbIwOxQXeVmRPeXIEiSpuykgnEM0O+Doj3GzZg16tFurgv+pPhw/mVF6sMQfLGjQmYqjJ8YozG70BEW8wD7WL8H3uHmW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAHaiGTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAHaiGTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A61F000FF;
	Mon,  5 Oct 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232787;
	bh=bKCiFmbT9c79UFhaF16sTuYG/kH/9EJEz5v8T+fevc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAHaiGTo0bXIpKr7LdIgmqJTrcfnycAiYNKN3oa5gHUv6ICZeWPh2lJXaO/CjlsP1
	 2jIreNvt89ZWf2LohUZseVkrI1SF3BOA75A83mCTo4hS35uWkSsmDHEzBzuyFG734h
	 33aBDiCYE5AF7TaHh86idMh5dmJ97JSd8CiXi/4Y2ke6dKD3fU+ie6Y0MyBJjIogXr
	 kMp3JcgN/c2qRs0fDz5/kfDbb9JMd4q97y7jFnhU/lnGJJcgy3vPdzMvJhVdEamElp
	 WdZgPK7g30Y6IDyuzujmZOmJDi4M8SzRL86NeneeyeDLzbxXvo9Pkf4SzD5mEX6s0C
	 asHlKY5Kw6yTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: abort break signalling on hangup
Date: Mon,  5 Oct 2026 16:39:42 -0400
Message-ID: <20261005203857.3274323-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100529-shorthand-eatery-44e1@gregkh>
References: <2026100529-shorthand-eatery-44e1@gregkh>
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
[ sashal: Adjusted hangup context to use the existing tty->ctrl_lock instead of tty->ctrl.lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 36 +++++++++++++++++++++++++++---------
 include/linux/tty.h  |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f0d36f992616f..7bcca38a64509 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -624,6 +624,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 
 	tty_ldisc_hangup(tty, cons_filp != NULL);
 
+	wake_up_interruptible(&tty->break_wait);
+
 	spin_lock_irq(&tty->ctrl_lock);
 	clear_bit(TTY_THROTTLED, &tty->flags);
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -2453,6 +2455,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  *	send_break	-	performed time break
  *	@tty: device to break on
  *	@duration: timeout in mS
+ *	@file: file object
  *
  *	Perform a timed break on hardware that lacks its own driver level
  *	timed break functionality.
@@ -2462,8 +2465,9 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  *
  */
 
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
+	long timeout;
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
@@ -2477,13 +2481,26 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
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
 	}
+
+	timeout = msecs_to_jiffies(duration);
+	timeout = wait_event_interruptible_timeout(tty->break_wait,
+						   tty_hung_up_p(file),
+						   timeout);
+	/* return early on hangup only */
+	if (timeout > 0) {
+		retval = -EIO;
+		goto out_unlock;
+	}
+
+	retval = tty->ops->break_ctl(tty, 0);
+out_unlock:
 	tty_write_unlock(tty);
 
 	if (signal_pending(current))
@@ -2710,10 +2727,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -3093,6 +3110,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
+	init_waitqueue_head(&tty->break_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl_lock);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e51d75f5165b5..12a841779552d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -303,6 +303,7 @@ struct tty_struct {
 	struct fasync_struct *fasync;
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
+	wait_queue_head_t break_wait;
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-- 
2.53.0

