Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6D3C5DD4;
	Mon,  7 Sep 2026 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774828; cv=none; b=ZVRLglpaaJ63iLp4guZloNxvxW9uRw2wp0orsTcafim3amu7B8SMU2KOx+YLfbXSiyAJ54TveWWTmM3QAsy7h5Ihy3z8JKyudJeAOuV4llDkDEOA5OANCbTXKeyGgmpudBIAWpxz+xU6flQrxWEw7Ag/hTxgevDKAg8DZTwcEtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774828; c=relaxed/simple;
	bh=UxNHWxv1lAarQTLq2idNJ5bq3LxFHRqO1kuxGq1Hocs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDh7bB9BavU5C0WMesgVrzDHEkxHi0gat8LaZabAEw9OkucDHdfg5tG4Er/TZhxF0TuQEric2tMSydMVDfjQIW61TWC/wPjXjAbc/xBo7Iq5Xz4OKtU4rqkuzTnfmgCnVJDNsr4ZTtHBr5lp5xyeSkZ47FCy7By7KmhaR/cDL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z56s0K8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z56s0K8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCAB1F00A3A;
	Mon,  7 Sep 2026 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788774826;
	bh=q/COAdYlU0pd0l5RbIN0tn1G/83IKZjnvQXUajavTxg=;
	h=From:To:Cc:Subject:Date;
	b=Z56s0K8ZoMBUmqgpQEmLfzcwD26KsOTmwWjY45aBofAofQxKmNszGVWBfOH4vn2Mc
	 H6tGIDCy43fIGxbWYEnz8Gg4g1uNr0YA8DcbU+95/jmsLnY4OW/2zYOypDG9KS6GqL
	 GajdYL8TYmP+KF3U4R7i6+qLT7Cf5kFpqPWSfo9KwfKov80gkR+MDS/gB2kt4QZJM3
	 ikeZTWaQKmPdliryOyeOJvHPIaDw5YzTe8/lhRWiCbCm9mJUSN6QO14NT3AA3J/LRr
	 ASNHBL6W1T6dIOgj4gsR4DmLukRlXV+ftLCq/oo4H/yvMejG3SwLXJA0ugDPlMwMjW
	 pev+xpoSeYkJQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3W2q-00000000Y1s-2sh6;
	Mon, 07 Sep 2026 11:53:44 +0200
From: Johan Hovold <johan@kernel.org>
To: David Lin <dtwlin@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] staging: greybus: uart: fix racy TIOCMIWAIT implementation
Date: Mon,  7 Sep 2026 11:53:05 +0200
Message-ID: <20260907095305.130762-1-johan@kernel.org>
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

Fixes: e68453ed28c5 ("greybus: uart-gb: now builds, more framework added")
Cc: stable@vger.kernel.org	# 4.9
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2
 - store old icount on entry only


 drivers/staging/greybus/uart.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 24b4dab069c3..d47f00751e7a 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -53,7 +53,6 @@ struct gb_tty {
 	spinlock_t read_lock;
 	spinlock_t write_lock;
 	struct async_icount iocount;
-	struct async_icount oldcount;
 	wait_queue_head_t wioctl;
 	struct mutex mutex;
 	u8 ctrlin;	/* input control lines */
@@ -643,11 +642,16 @@ static int wait_serial_change(struct gb_tty *gb_tty, unsigned long arg)
 	if (!(arg & (TIOCM_DSR | TIOCM_RI | TIOCM_CD)))
 		return -EINVAL;
 
-	do {
+	spin_lock_irq(&gb_tty->read_lock);
+	old = gb_tty->iocount;
+	spin_unlock_irq(&gb_tty->read_lock);
+
+	add_wait_queue(&gb_tty->wioctl, &wait);
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&gb_tty->read_lock);
-		old = gb_tty->oldcount;
 		new = gb_tty->iocount;
-		gb_tty->oldcount = new;
 		spin_unlock_irq(&gb_tty->read_lock);
 
 		if ((arg & TIOCM_DSR) && (old.dsr != new.dsr))
@@ -657,18 +661,20 @@ static int wait_serial_change(struct gb_tty *gb_tty, unsigned long arg)
 		if ((arg & TIOCM_RI) && (old.rng != new.rng))
 			break;
 
-		add_wait_queue(&gb_tty->wioctl, &wait);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
-		remove_wait_queue(&gb_tty->wioctl, &wait);
 		if (gb_tty->disconnected) {
-			if (arg & TIOCM_CD)
-				break;
 			retval = -ENODEV;
-		} else if (signal_pending(current)) {
+			break;
+		}
+
+		schedule();
+
+		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
+			break;
 		}
-	} while (!retval);
+	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&gb_tty->wioctl, &wait);
 
 	return retval;
 }
-- 
2.55.0

