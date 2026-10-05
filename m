Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97F3AFAF8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235915; cv=none; b=DbI7tUnhwE/4jz+0d6q6A0NACq+eIHiWXei3tinSQt+DMuSOqmU9v1Gswof1t156osskiZb6aVR7VnvMftnbCZ3jw6Rmc8t4YAE2opnreR1zYdspTXikeS9CEbJVF2oczgrsKTJUHQNTU705DlwUVegKVlkclPUIy/Mhc/zw16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235915; c=relaxed/simple;
	bh=8/2RexDo/+yOPJpokSCLTsZDM+PyZJaMRwJaaa5gErM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxAUm8xmfKrnSzJVeCjsqZpXXlFkh02mhUacdWwzps0rLvaxG8rm6EhWJB+90U/RSR9snz+acgWx6Vg3bK4ACCYojD9esL57d6i6FkNFh0/1YALlAaYAcZKveq0wTCb9CJM03ShWJKJHEXd+OoGSEYTJC+XyRHYx4MYdwqVkbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy8Q8DoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy8Q8DoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147231F0089B;
	Mon,  5 Oct 2026 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235913;
	bh=8fN3nCzRFIh5sRSHcLjwAJDSL/Emi0ANhEh1Pweeahw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wy8Q8DoG/GT4/R+WfxRYFOP3FlqcwwYsYCGzR6qYeJBEbhm1h3oW5+2aMaGgYbI1H
	 dRkUhI8aYktQI/ddfDUz/lBTDQEZos4ITZG4wTRM1GSTdF1G3zAmDk2AAUolibxUhv
	 Ha/gn8AHH1nmd8SqnCZ0O/8BO6fHk4tE+IpQ+pDNDFKaZXgPOJi2SxHUKzn2b+x1zw
	 JKb1yJb5Zzw3g6TJ1KKMR5w01vFAiwDyEIlxOvAmWMLSiVfuzCp7HNxsqPPjfIwb9F
	 EE+dT0UewtuCdjU0suYEs3dZIuAEHO+8dzfIaz/yQpcQCpLMFrGeUS5Qnm8I+NiG7L
	 etP1qyWtCpVgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tty: fix saved termios reset race
Date: Mon,  5 Oct 2026 17:31:49 -0400
Message-ID: <20261005213111.3389424-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100544-flannels-eclipse-ffc7@gregkh>
References: <2026100544-flannels-eclipse-ffc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 8df07fe93573e9e548d6645273e9bcb6eb74059e ]

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
[ sashal: Adapted the new flag to hexadecimal macro definitions and Greybus’s existing post-allocation flags assignment. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/uart.c  |  3 ++-
 drivers/tty/tty_io.c            | 18 ++++++++++--------
 drivers/usb/class/cdc-acm.c     |  2 +-
 drivers/usb/serial/usb-serial.c |  3 ++-
 include/linux/tty_driver.h      |  5 +++++
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index dc4ed0ff1ae27..51fab4f3ea1ae 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -960,7 +960,8 @@ static int gb_tty_init(void)
 	gb_tty_driver->minor_start = 0;
 	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			       TTY_DRIVER_RESET_SAVED_TERMIOS;
 	gb_tty_driver->init_termios = tty_std_termios;
 	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
 		CREAD | HUPCL | CLOCAL;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d63ab274ff4a2..6a0f8c3884977 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3294,14 +3294,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
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
index dc40b7ea40d4c..2d6817242d350 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2084,7 +2084,7 @@ static int __init acm_init(void)
 {
 	int retval;
 	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(acm_tty_driver))
 		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 1a94abe09433c..97a031033e946 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1325,7 +1325,8 @@ static int __init usb_serial_init(void)
 	int result;
 
 	usb_serial_tty_driver = tty_alloc_driver(USB_SERIAL_TTY_MINORS,
-			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(usb_serial_tty_driver))
 		return PTR_ERR(usb_serial_tty_driver);
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index c20431d8def8f..aa0564b34fd79 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -395,6 +395,10 @@ static inline void tty_set_operations(struct tty_driver *driver,
  *	other words create /dev/ttyprintk and not /dev/ttyprintk0.
  *	Applicable only when a driver for a single tty device is
  *	being allocated.
+ *
+ * TTY_DRIVER_RESET_SAVED_TERMIOS -- reset any saved termios settings on
+ *	device registration when reusing a minor number. Must only be set by
+ *	drivers that guarantee that the minor number is no longer in use.
  */
 #define TTY_DRIVER_INSTALLED		0x0001
 #define TTY_DRIVER_RESET_TERMIOS	0x0002
@@ -404,6 +408,7 @@ static inline void tty_set_operations(struct tty_driver *driver,
 #define TTY_DRIVER_HARDWARE_BREAK	0x0020
 #define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
 #define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+#define TTY_DRIVER_RESET_SAVED_TERMIOS	0x0200
 
 /* tty driver types */
 #define TTY_DRIVER_TYPE_SYSTEM		0x0001
-- 
2.53.0

