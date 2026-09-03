Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5298E30E838;
	Thu,  3 Sep 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453466; cv=none; b=Pl/NMd1mDGQjbBC2Ti/jv8jpcabNgJROnad/uvfpPS8IuWQs/uimUdyDBCc3wqH8colaaSkl+2i0z8J1YHq3Y9Plk84LYgLAT9qQ+MLX/QvBGINVQl9TYoknHr2i57BZNi74fAGZtjZwLTD5I5jLJYJ53Zj6w24dFV/xR80bhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453466; c=relaxed/simple;
	bh=dpp4tH0Hq1c1kejney2bDWQ/wwx1epNPn2CCinLRPIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlByiBuRpH6+cvfwy4rdjLG1S2pDMiwHXhB9ZwzhAjk9AMbIm3vCAt6JlaSS7X4OEU61eCDnTgTqGibwr8Qt6H/vKmJw4y/c6PnFDUNNv3v6yhDQ+oiv8p1r9vt+oJ4cgYNU1+r0MusBPm/MQGTvsmNN5+tMJLL2f047zVflevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahFvNbIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahFvNbIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3796A1F000E9;
	Thu,  3 Sep 2026 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453465;
	bh=KY6qn66VB3ItGKX2EZsett3CtYykeUsgVqWuPa1ODag=;
	h=From:To:Cc:Subject:Date;
	b=ahFvNbIQmYSqa+kF0HWxVlux0Uw5Q5MTsI3y5gIC/QsuFHWysRcWSr0RuuA4c3lTy
	 ZJae/rcnzU5AvoY7S1KPS60y8U6MYtwKR+yK23dSnGLGVR4HlOYKhG7j3E3dldtME2
	 a65Juu6DnzvyUyJbneGK8xaYYgy+hdFguqzqT8MzmyZRUNeo4TwnaRz0EQkgavM0H0
	 qI/MyQ+NYiN0Pt6yQ63Lx71vhOnvrgeWponjP3+03rBM1VFVMRwFKLdeyd6vEX/BxH
	 pyBqUX1PbHjf1IVDGSvBub/aNsbCkZDNpdUCWeT3R6Hd/1vaa4yXGrbQdPFTNMJmRY
	 +rn2IV791FAAg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x2ARb-00000006I2E-0GdU;
	Thu, 03 Sep 2026 18:37:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] tty: abort break signalling on hangup
Date: Thu,  3 Sep 2026 18:37:36 +0200
Message-ID: <20260903163736.1499280-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The break ioctls can race with hangup and end up calling into a tty
driver for a device that is already gone or powered down.

Drivers must handle this race, but TCSBRK and TCSBRKP should still be
aborted to avoid calling back into the driver after a user-controlled
timeout (possibly even after the tty has been reopened).

Note that drivers should disable any break state on shutdown so just
return on hangup (calling break_ctl() again is racy and will most likely
fail for drivers handling the race).

Fixes: f34d7a5b7010 ("tty: The big operations rework")
Cc: stable@vger.kernel.org      # 2.6.26
Signed-off-by: Johan Hovold <johan@kernel.org>
---

This is related to the USB serial and serial core fixes I just posted:

	https://lore.kernel.org/r/20260903163146.1498497-1-johan@kernel.org/
	https://lore.kernel.org/r/20260903163439.1499055-1-johan@kernel.org

Will take a closer look at the other TTY drivers in the coming days.

Johan


 drivers/tty/tty_io.c | 36 +++++++++++++++++++++++++++---------
 include/linux/tty.h  |  1 +
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 48569035da56..1c30faae9ec1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -620,6 +620,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 
 	tty_ldisc_hangup(tty, cons_filp != NULL);
 
+	wake_up_interruptible(&tty->break_wait);
+
 	spin_lock_irq(&tty->ctrl.lock);
 	clear_bit(TTY_THROTTLED, &tty->flags);
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -2431,6 +2433,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * send_break - performed time break
  * @tty: device to break on
  * @duration: timeout in mS
+ * @file: file object
  *
  * Perform a timed break on hardware that lacks its own driver level timed
  * break functionality.
@@ -2438,8 +2441,9 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Locking:
  *	@tty->atomic_write_lock serializes
  */
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
+	long timeout;
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
@@ -2453,13 +2457,26 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
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
@@ -2727,10 +2744,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -3090,6 +3107,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
+	init_waitqueue_head(&tty->break_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl.lock);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0a46e4054dec..ad4e4a835f90 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -230,6 +230,7 @@ struct tty_struct {
 	struct fasync_struct *fasync;
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
+	wait_queue_head_t break_wait;
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-- 
2.55.0

