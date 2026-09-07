Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784145041C;
	Mon,  7 Sep 2026 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774715; cv=none; b=M+YbEo4b/iNnueLpSc+6WUqC2vHJ+4Ix738RggMHNY21V5iJxX4+RtUGy6Enwv4wyB1DJphruq6mjG93ID0L3TjivJVwdp/l3+suCZS19o4W+O6GM2HcapiMZB4VMknN1aD6QqanOT49dwvtt/z1mb52vyQTrDYgk6N2aAQD4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774715; c=relaxed/simple;
	bh=eq5BwWiyHB30dDI1F4cffK8njPC5VBf2pkAM6IIBxz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKP6Sm2Wl1JttMs6NvdD1DHkB1H8YvkYDuuFfT0prV7LddJYLtMIlpFQMZVH8iaLrOOXBRyjdpQxesxjd/gqDuhnFdpyBcNvUNakuZutfb+B2YatwoM/4+6dvfkATYjc3/+1bMBnAF98E2SSgLu2wG3BX4jo4X4lTZym1mkzMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaEnn1/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaEnn1/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00BE1F00A3A;
	Mon,  7 Sep 2026 09:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788774705;
	bh=VFweDQmpO9/uaET+6g5EHgUcto2UGa8pbMFyGmTkkfI=;
	h=From:To:Cc:Subject:Date;
	b=kaEnn1/Ko6oWquK9wsPqH61ikUDEpeoxEoHyL4boSJKnQeG0NLsORHW8ggU6GWXOZ
	 uIS/hK7GT9hNRD5zJ8epeURzkM4L2S1UwPCQtekiyrcVF56iVSFF3M2MULuMSRFRTl
	 Ww4Oxvzlf+jwgBWWzdToBSoFNiRLob5CNfIKkN33l/gijxQ+EuDBAkVvTVmb5aC0zd
	 Usw4f5Dz5SvmlSYFtS8KR3ljS12akFtwpJikwDpTTHzp3Bnp1m1+HFIohO91oOUPED
	 dSqzlNZjsl/KzCQKzqp2i3SH+JO/e+ldvgJhWYCkEj3LMyh6c5LnLVRp53f2yZfV6f
	 Ih0T4xmyB46bg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3W0s-00000000Xzi-1YPJ;
	Mon, 07 Sep 2026 11:51:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.de>
Subject: [PATCH v2] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Date: Mon,  7 Sep 2026 11:51:30 +0200
Message-ID: <20260907095130.130636-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the wakeup condition after adding the task to the waitqueue and
updating the task state to avoid missing a racing modem status update or
disconnect.

Store the old icount on entry and do not update it in the completion
handler to avoid missing events or reporting spurious ones (due to modem
status changes before TIOCMIWAIT was called).

Fixes: 5a6a62bdb925 ("cdc-acm: add TIOCMIWAIT")
Cc: stable@vger.kernel.org	# 3.14
Cc: Oliver Neukum <oneukum@suse.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - store old icount on entry only


 drivers/usb/class/cdc-acm.c | 36 +++++++++++++++++++-----------------
 drivers/usb/class/cdc-acm.h |  1 -
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7bc5329fa3ed..21417b4c5154 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -331,7 +331,6 @@ static void acm_process_notification(struct acm *acm, unsigned char *buf)
 
 		spin_lock_irqsave(&acm->read_lock, flags);
 		acm->ctrlin = newctrl;
-		acm->oldcount = acm->iocount;
 
 		if (difference & USB_CDC_SERIAL_STATE_DSR)
 			acm->iocount.dsr++;
@@ -1027,11 +1026,16 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 	DECLARE_WAITQUEUE(wait, current);
 	struct async_icount old, new;
 
-	do {
+	spin_lock_irq(&acm->read_lock);
+	old = acm->iocount;
+	spin_unlock_irq(&acm->read_lock);
+
+	add_wait_queue(&acm->wioctl, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&acm->read_lock);
-		old = acm->oldcount;
 		new = acm->iocount;
-		acm->oldcount = new;
 		spin_unlock_irq(&acm->read_lock);
 
 		if ((arg & TIOCM_DSR) &&
@@ -1044,22 +1048,20 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
 			old.rng != new.rng)
 			break;
 
-		add_wait_queue(&acm->wioctl, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		remove_wait_queue(&acm->wioctl, &wait);
 		if (acm->disconnected) {
-			if (arg & TIOCM_CD)
-				break;
-			else
-				rv = -ENODEV;
-		} else {
-			if (signal_pending(current))
-				rv = -ERESTARTSYS;
+			rv = -ENODEV;
+			break;
 		}
-	} while (!rv);
 
-	
+		schedule();
+
+		if (signal_pending(current)) {
+			rv = -ERESTARTSYS;
+			break;
+		}
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&acm->wioctl, &wait);
 
 	return rv;
 }
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 01f448a783c0..d245e60eb9f5 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -90,7 +90,6 @@ struct acm {
 	unsigned int ctrlin;				/* input control lines (DCD, DSR, RI, break, overruns) */
 	unsigned int ctrlout;				/* output control lines (DTR, RTS) */
 	struct async_icount iocount;			/* counters for control line changes */
-	struct async_icount oldcount;			/* for comparison of counter */
 	wait_queue_head_t wioctl;			/* for ioctl */
 	unsigned int writesize;				/* max packet size for the output bulk endpoint */
 	unsigned int readsize,ctrlsize;			/* buffer sizes for freeing */
-- 
2.55.0

