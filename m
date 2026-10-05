Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DB53955D1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232768; cv=none; b=CiV6+gXgxX40WkZQImBMZpr+9skkHA2o9IubgFn2XXgYWI1E2eFvLr3BhgpYt2ADj8DgOmLvB+EQxDoQPQ6ecrXj3aQu0QGIb5dowdNlwDk1hcfh8A7BL4pD/6TT3r97oYR06O/9ZtYh2nmAX5MAlo6uFKG0+0C9c9ftlV9d7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232768; c=relaxed/simple;
	bh=Vl493LrcI63P/ciJMkcNP6mg3kYwhVnI9kgOmNT8RvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NH9PPIxbjuZ0kGNcA/aDFcjUkJUnCZ+EBxVtbRfL8T57mUpzhLg6sCJ/s5vpXBY6TYxYFXFLwxKbxY4hAPwVAks2N+CXnhz0xiDtxMVmZwBgbvcNocGcAeh2LogJg1FgVzx/wrxm/jlt7Uvm1w/glNu/+MLtgeuOV1auZ/Si8yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhleZfi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhleZfi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96761F000FF;
	Mon,  5 Oct 2026 20:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232766;
	bh=mfxplbjH6nmB5/o8pT33wQov0acFLEu5NGc+iEFQnCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JhleZfi6xYlSkj0F7rftlkd6O+wEIrhnZS6DYtD4SSn3/7kHN+Hp9KOuQoARTkM+c
	 oajWEV/K8fBL3muETT2MdjUfMRAVpufEZls4ZSnnUe4Oix8zi/kZDywtxGSAGb4Txy
	 x3u9rxYP0n3fIDar7VJwDAaH3GpjrNMZbu8FwekYWnazSkK1bMUF9+QmUdDbdUPDaa
	 QcCpWwnQsl6xgimivY4Csex6i+DzrtmrtmREAT747T1x6cEX3W0beniFA28FGcOtc0
	 eslggEmqr4n0JZvJwbjrchfcuEyJg5Vo5WoNaikt9eOdpv69dnSEo9RCP05WJsmOlG
	 WKwNZePoa4Pdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tty: fix saved termios reset race
Date: Mon,  5 Oct 2026 16:39:21 -0400
Message-ID: <20261005203856.3273181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100542-guru-duress-274d@gregkh>
References: <2026100542-guru-duress-274d@gregkh>
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
[ sashal: adapted the new flag to Greybus’s separate flags assignment and existing macro-based TTY flag definitions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/uart.c  |  3 ++-
 drivers/tty/tty_io.c            | 18 ++++++++++--------
 drivers/usb/class/cdc-acm.c     |  2 +-
 drivers/usb/serial/usb-serial.c |  3 ++-
 include/linux/tty_driver.h      |  6 ++++++
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 413a4f296d899..025b4cda74b9f 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -954,7 +954,8 @@ static int gb_tty_init(void)
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
index 76f10e8d16857..07e1e901dea59 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3297,14 +3297,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
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
index 080a7dc79ecdc..b980cb08d675b 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -2145,7 +2145,7 @@ static int __init acm_init(void)
 {
 	int retval;
 	acm_tty_driver = tty_alloc_driver(ACM_TTY_MINORS, TTY_DRIVER_REAL_RAW |
-			TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(acm_tty_driver))
 		return PTR_ERR(acm_tty_driver);
 	acm_tty_driver->driver_name = "acm",
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 45c27b18fb459..3cccddaabb51a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1375,7 +1375,8 @@ static int __init usb_serial_init(void)
 	int result;
 
 	usb_serial_tty_driver = tty_alloc_driver(USB_SERIAL_TTY_MINORS,
-			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+			TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV |
+			TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(usb_serial_tty_driver))
 		return PTR_ERR(usb_serial_tty_driver);
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index dd4b31ce6d5d4..2173011004cda 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -541,6 +541,11 @@ static inline void tty_set_operations(struct tty_driver *driver,
  *	Do not create numbered ``/dev`` nodes. For example, create
  *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
  *	driver for a single tty device is being allocated.
+ *
+ * TTY_DRIVER_RESET_SAVED_TERMIOS
+ *	Reset any saved termios settings on device registration when reusing a
+ *	minor number. Must only be set by drivers that guarantee that the minor
+ *	number is no longer in use.
  */
 #define TTY_DRIVER_INSTALLED		0x0001
 #define TTY_DRIVER_RESET_TERMIOS	0x0002
@@ -550,6 +555,7 @@ static inline void tty_set_operations(struct tty_driver *driver,
 #define TTY_DRIVER_HARDWARE_BREAK	0x0020
 #define TTY_DRIVER_DYNAMIC_ALLOC	0x0040
 #define TTY_DRIVER_UNNUMBERED_NODE	0x0080
+#define TTY_DRIVER_RESET_SAVED_TERMIOS	0x0200
 
 /* tty driver types */
 #define TTY_DRIVER_TYPE_SYSTEM		0x0001
-- 
2.53.0

