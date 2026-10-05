Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6131F99C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190316; cv=none; b=rb0KWlahvseCVG/TeKQW0JCK99gi2g6bgaMbF9xcGtaJRtaI76PkzWsT4EDqvJCybQxd/uaxP71ncPgg0ruxl5BzA4TcN1W8p+5ZvgkH2c1J/J9ObzwHCGWtDPumVpaSJLrbQX+rTjKWgICI8dSq/uGYWDBdbE2MI8nVtgxNyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190316; c=relaxed/simple;
	bh=hpT78MOpqCHulM6z+cgpLbn6g8IK6XfKnNbmBdpoPlM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HNwRcgSKbToXQc30mEm9RW/kmwbD8sg7WdLo9ZdEpc/Vsu7Q/SBRfkA/FLM45UTBW2eT9lR2YhWLur5KXOinKbmhpgFTMpEfglDwn1Trq0mM7G4+FZJsUNyIq0J3sbPimu06WqigvhyBv38nHn0BzFKZFlC0iAjTkTqsJQvZi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDjMfXZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDjMfXZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51601F000FF;
	Mon,  5 Oct 2026 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190315;
	bh=39NUY55KpXPVZtxtN0GWYPXTAYyfwMCetS4YMHVLi3I=;
	h=Subject:To:Cc:From:Date;
	b=jDjMfXZhyPB3YmFyubf3IdLDYYVQjqbYHbOWCO5uESaFyq7jeAi8OYS3jDawZPC/t
	 EpSTjNlbyEQoF1839C+CILNk1AWzOWCWit0rbBI24yjBo1yePUFiBp4Nya58IsNE4+
	 c+wReuwPtl+XbYwQJwYsdWtEwbNGmfg/7PUrt+Lw=
Subject: FAILED: patch "[PATCH] tty: fix saved termios reset race" failed to apply to 5.15-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,nicoyip.dev@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:51:44 +0200
Message-ID: <2026100544-flannels-eclipse-ffc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8df07fe93573e9e548d6645273e9bcb6eb74059e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100544-flannels-eclipse-ffc7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8df07fe93573e9e548d6645273e9bcb6eb74059e Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 30 Sep 2026 15:18:45 +0200
Subject: [PATCH] tty: fix saved termios reset race

Resetting saved termios state on device registration is needed where a
minor number can be reused for an entirely different device and where
the old settings may prevent the port from even being opened (e.g. when
CLOCAL is not set).

Not all TTY drivers guarantee that the minor number is no longer in use
when registering devices however, something which can lead to a
use-after-free when closing a TTY (and saving its termios) races with
re-registration.

Add a new TTY_DRIVER_RESET_SAVED_TERMIOS flag to request that any saved
termios state is reset on registration and only set it for drivers that
make sure that the minor number is no longer in use.

Fixes: 93857edd9829 ("tty: reset termios state on device registration")
Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Link: https://lore.kernel.org/20260926184154.3017929-1-nicoyip.dev@gmail.com
Cc: stable@kernel.org	# 4.12
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260930131845.1809256-1-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 24b4dab069c3..172cf900eaf0 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -948,7 +948,8 @@ static int gb_tty_init(void)
 	int retval = 0;
 
 	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
-					 TTY_DRIVER_DYNAMIC_DEV);
+					 TTY_DRIVER_DYNAMIC_DEV |
+					 TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(gb_tty_driver)) {
 		pr_err("Can not allocate tty driver\n");
 		retval = PTR_ERR(gb_tty_driver);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1c30faae9ec1..1a6c8a1bc764 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3256,14 +3256,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
 		goto err_put;
 
 	if (!(driver->flags & TTY_DRIVER_DYNAMIC_ALLOC)) {
-		/*
-		 * Free any saved termios data so that the termios state is
-		 * reset when reusing a minor number.
-		 */
-		tp = driver->termios[index];
-		if (tp) {
-			driver->termios[index] = NULL;
-			kfree(tp);
+		if (driver->flags & TTY_DRIVER_RESET_SAVED_TERMIOS) {
+			/*
+			 * Free any saved termios data so that the termios
+			 * state is reset when reusing a minor number.
+			 */
+			tp = driver->termios[index];
+			if (tp) {
+				driver->termios[index] = NULL;
+				kfree(tp);
+			}
 		}
 
 		retval = tty_cdev_add(driver, devt, index, 1);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7bc5329fa3ed..eeb401c0e5e1 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2140,7 +2140,7 @@ static int __init acm_init(void)
 {
 	int retval;
 	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(acm_tty_driver))
 		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 17edc057a311..06e246426361 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1313,7 +1313,8 @@ static int __init usb_serial_init(void)
 	int result;
 
 	usb_serial_tty_driver = tty_alloc_driver(USB_SERIAL_TTY_MINORS,
-			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(usb_serial_tty_driver))
 		return PTR_ERR(usb_serial_tty_driver);
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 1f2896e56e77..62e459c5d3ae 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -73,6 +73,11 @@ struct serial_struct;
  * @TTY_DRIVER_NO_WORKQUEUE:
  *	Do not create workqueue when tty_register_driver(). Whenever set, flip
  *	buffer workqueue can be set by tty_port_link_wq() for every port.
+ *
+ * @TTY_DRIVER_RESET_SAVED_TERMIOS
+ *	Reset any saved termios settings on device registration when reusing a
+ *	minor number. Must only be set by drivers that guarantee that the minor
+ *	number is no longer in use.
  */
 enum tty_driver_flag {
 	TTY_DRIVER_INSTALLED		= BIT(0),
@@ -84,6 +89,7 @@ enum tty_driver_flag {
 	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
 	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
 	TTY_DRIVER_NO_WORKQUEUE		= BIT(8),
+	TTY_DRIVER_RESET_SAVED_TERMIOS	= BIT(9),
 };
 
 enum tty_driver_type {

