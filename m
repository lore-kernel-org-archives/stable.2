Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F8351C11;
	Wed, 30 Sep 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759992; cv=none; b=VbK/ZxdqgsmsCvxfl85K/03sddpLopppAIbPVDEe+b7/7EJO7phON5bUQuAV2WZf+hrRcl8I4JUgTYx/xaeReqyrn55GKWxiB4+NMCXqUkbH3CeOw5Ebow18aXoeT7gsYEK8jW6Jfz2cfdfNWmNyHHwqNLJpN2le36cQGw+Wb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759992; c=relaxed/simple;
	bh=ycAeeO2+O1u2/hRBiqcbFNxDPPw+N8Wmja8P3VugHxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxA1iG+S996SIX4S2p/8AA+YGdocc0RcS3Q7vYSr5i2qTv8myC3mgUB77hV69/hT0en5ZQ535cUfLwyvDVI68CwMQZJglzrHQp3GaBR6oOemMEx4kdAloPCDSSUxv+2uwjmr9k4jnxQ9qEQ4lPm+lPWWqxY0CZLoGTrV6uwv7Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXs7FicP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXs7FicP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867601F000FF;
	Wed, 30 Sep 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759990;
	bh=EpZN4TiwJzawni07VrYz4UienjYO7F9KCDL/tcZI+Oc=;
	h=From:To:Cc:Subject:Date;
	b=EXs7FicPBhxtPr3DAvKdVi8FH/4A5/bvuGhH40S8d3QI2vbwmsyiGxj83PYK5DU3Q
	 GGYo6JF22IoeuADdHrCVP8VBMWkpdTIzHKrhHX1U9hvIHdavIjsUtE9t68xs+NwAVy
	 lq0mlu/9E4D1lYU4tVxt9PlkAv6oVm+79pDxZ2gbi7wTR9rx45BntwvfuYUpQLVX3c
	 p6RRQzFtAXgE10oV8dguFrZum/L4EfYEqfgbNk7yIhT5/7A6OhdYOMfxFxmfOQBD0y
	 eIa0YOqODKKWYTmddhgmB/0hFqcRFvuAxgNXcelRk1Uq2xjfalXgZXnVm2x9fjCOgI
	 5XLa0ddhbbYHQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xBqTc-00000007CLj-0RxD;
	Wed, 30 Sep 2026 11:19:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: David Lin <dtwlin@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tty: fix saved termios reset race
Date: Wed, 30 Sep 2026 11:19:38 +0200
Message-ID: <20260930091938.1715754-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Cc: stable@vger.kernel.org	# 4.12
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/greybus/uart.c  |  3 ++-
 drivers/tty/tty_io.c            | 18 ++++++++++--------
 drivers/usb/class/cdc-acm.c     |  2 +-
 drivers/usb/serial/usb-serial.c |  3 ++-
 include/linux/tty_driver.h      |  6 ++++++
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index f2810b5ec824..d7df65088ef7 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -962,7 +962,8 @@ static int gb_tty_init(void)
 	int retval = 0;
 
 	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
-					 TTY_DRIVER_DYNAMIC_DEV);
+					 TTY_DRIVER_DYNAMIC_DEV |
+					 TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(gb_tty_driver)) {
 		pr_err("Can not allocate tty driver\n");
 		retval = PTR_ERR(gb_tty_driver);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1c30faae9ec1..c9da7b25e3fb 100644
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
+		if (driver->flags && TTY_DRIVER_RESET_SAVED_TERMIOS) {
+			/*
+			 * Free any saved termios data so that the termios state is
+			 * reset when reusing a minor number.
+			 */
+			tp = driver->termios[index];
+			if (tp) {
+				driver->termios[index] = NULL;
+				kfree(tp);
+			}
 		}
 
 		retval = tty_cdev_add(driver, devt, index, 1);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 7edda9019d54..bf6ef1ecf2c5 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2150,7 +2150,7 @@ static int __init acm_init(void)
 {
 	int retval;
 	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(acm_tty_driver))
 		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f3c594f1a806..4a19621f08ba 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1372,7 +1372,8 @@ static int __init usb_serial_init(void)
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
-- 
2.55.0

