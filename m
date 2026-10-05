Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5AA1632DD
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238651; cv=none; b=rpEwZr+t/DCoEABxfjHpnlh2FJ1ei1hCGehUaE1E5DE8jhsI0HAtRfk26lc47G9vRi2QGVNhQcl8I8InGO3MS7twJPkX91VNN9ozp1TArkedQ8hfWfnoJbHFJENh+yCXy2OgaRhBfg4vex9hOUr6ja/XmNKmcRqMT0watfhj6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238651; c=relaxed/simple;
	bh=B9q4AfPvV/YcVPVXbl1keYW+nrlXLI5m3gk+2re92EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/9E9Z2vbzT5U8cDvVFBABHvUrEeb2EQF2TZjGSDiZd8XcVZ4qPqUm8dOr0mF89SRhpeFRMOXO8v45LTeuXiGduSUiygvifd5CqnPf+7vu8gwMLJ8Vpn0P6oSh/jmfzbvbdDTKubGo7lr0UB+LY6RVJIaV1rJ6ZtQph2B5UNKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlQprDaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlQprDaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E81F000FF;
	Mon,  5 Oct 2026 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238649;
	bh=YHWLQA60Dm5C3gZZsOKv5rgY3Fm1VFmktFdeSMFcqqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UlQprDaNDDjmKr8W4lzjRGRWU/pKcUc1JKs5Nuo6PAVdzX4RQOvYz63un2OXxcAj5
	 umB9peB4PO5VTKGNCExyOswSenifP2yjOfkCCoarZYyU1QjPOQqPJEtywiCuuIKd6h
	 Jx7Fr1DhmLcKfn49BVBvma1OhR0/dnIN+sfRxrOQbCWEFUznmVqfItGoSD5r3+zpNA
	 1J7J4V7CaB2B1qxlmiwUv8jDYZgrlG1g4O8FmcVLi9S23rgRNfKF1WnRtDoCCBkwKh
	 TZYmr6KYanqwFbaOVO4arSSivWD+7Behe8jkv6S8seN/bvrgCIRpQ9lEetP1OBtiCc
	 dZFIpW78Xwdbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tty: fix saved termios reset race
Date: Mon,  5 Oct 2026 18:17:25 -0400
Message-ID: <20261005221635.3407833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100545-equivocal-violin-1936@gregkh>
References: <2026100545-equivocal-violin-1936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ sashal: Adapted the new flag to existing driver->flags assignments and hexadecimal #define conventions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/uart.c  |  3 ++-
 drivers/tty/tty_io.c            | 18 ++++++++++--------
 drivers/usb/class/cdc-acm.c     |  3 ++-
 drivers/usb/serial/usb-serial.c |  3 ++-
 include/linux/tty_driver.h      |  5 +++++
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 5cdc5dff9f55b..2a88314058a86 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -974,7 +974,8 @@ static int gb_tty_init(void)
 	gb_tty_driver->minor_start = 0;
 	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
-	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			      TTY_DRIVER_RESET_SAVED_TERMIOS;
 	gb_tty_driver->init_termios = tty_std_termios;
 	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
 		CREAD | HUPCL | CLOCAL;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f0d36f992616f..d6322a1493861 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3244,14 +3244,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
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
index 6b60b4dd508ca..b49b25d055a5a 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2094,7 +2094,8 @@ static int __init acm_init(void)
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
 	acm_tty_driver->subtype = SERIAL_TYPE_NORMAL,
-	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
+	acm_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			       TTY_DRIVER_RESET_SAVED_TERMIOS;
 	acm_tty_driver->init_termios = tty_std_termios;
 	acm_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD |
 								HUPCL | CLOCAL;
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 98797c2b96ca2..38980e851667a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1232,7 +1232,8 @@ static int __init usb_serial_init(void)
 	usb_serial_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	usb_serial_tty_driver->subtype = SERIAL_TYPE_NORMAL;
 	usb_serial_tty_driver->flags = TTY_DRIVER_REAL_RAW |
-						TTY_DRIVER_DYNAMIC_DEV;
+				      TTY_DRIVER_DYNAMIC_DEV |
+				      TTY_DRIVER_RESET_SAVED_TERMIOS;
 	usb_serial_tty_driver->init_termios = tty_std_termios;
 	usb_serial_tty_driver->init_termios.c_cflag = B9600 | CS8 | CREAD
 							| HUPCL | CLOCAL;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 2f719b471d524..dd76a4139fbcd 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -403,6 +403,10 @@ static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
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
@@ -412,6 +416,7 @@ static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
 #define TTY_DRIVER_HARDWARE_BREAK	0x0020
 #define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
 #define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+#define TTY_DRIVER_RESET_SAVED_TERMIOS	0x0200
 
 /* tty driver types */
 #define TTY_DRIVER_TYPE_SYSTEM		0x0001
-- 
2.53.0

