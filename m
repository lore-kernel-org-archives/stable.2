Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A983DA7E4
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190302; cv=none; b=feMsA80Bh8h7KROGc8FWjdCwr5WvB4DPZ8dOBSX6BoFgS72FsA2chuVzblZUt7Pg0owsg/+tN2V1R8c2wZ3N3DfQ34pY8sw24Z2pwScqeBuRcIWhY8REccZKVZuKH4f5NUWlQESc/HAiCGk/+83cVY1w0HqLPaPkZxdaexBTujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190302; c=relaxed/simple;
	bh=8DyNMgGnk4RPZe7nhBMaEEtL3CP0pD+Udi7hlCDl04A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fwgQrdoRgcdbQTps5p9RKssnHKDpPzsVdCtMl1PKoU0uVMpMVNUweLDymWDRvd4lQ3EmwJUMPEgPicYVJk/PiLsvB0YQgGv/JtPoC5pghPWOaioMDtlt9wVmfI0NUz07CRoGw0kGyuEKMyHSb0nT+VB3cuDD6+mK/3in2mPURO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDmnpTSl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDmnpTSl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360AC1F000FF;
	Mon,  5 Oct 2026 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190300;
	bh=MEJjyaOhdEOd3rJzz+JwtNaCRBjKrdCvm+JRYdEaYeg=;
	h=Subject:To:Cc:From:Date;
	b=eDmnpTSlmWMafCvgmgTJKYZ0BCEBFlAXNEKEE5sOZ9wjdYTQhS8dKAJcp46EuQ1kO
	 sshyamUvROIXprTF2EDwzUz2O+WqzCCH/5H1O1FhCg14uuA66d1ifNq10Rsa+Ni1NO
	 OmvX64lZYz5tuEI29s6ProTPpSfB5NkdbWuJjBX8=
Subject: FAILED: patch "[PATCH] tty: abort break signalling on hangup" failed to apply to 5.10-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:51:29 +0200
Message-ID: <2026100529-shorthand-eatery-44e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 845a2737e0f5ffe5ca8d38de556012b0c9472cdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100529-shorthand-eatery-44e1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 845a2737e0f5ffe5ca8d38de556012b0c9472cdd Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 3 Sep 2026 18:37:36 +0200
Subject: [PATCH] tty: abort break signalling on hangup

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

