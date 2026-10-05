Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB444CE68A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231351; cv=none; b=jbVTO2dHjW57cc/9tWPEbdkNlv7A+KTSc5Vlps+nGOePyeBsRghrGK+L7ls3DygMtCZ79s4BuUeOmOeQxT/09nfSSq65GDTGlW51VEgO+pyDYBbZAmzx7T8U/eHxawFqa81dYJHfaREWhrl9Yff06eF7rGx3GLfnMKJwMHR7PAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231351; c=relaxed/simple;
	bh=jreJlihI1LDoDEXzXT34D/OpoByeoc72EvJAwXb4cs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxkXrbO9fugIGXTsfZV1AunuXYOYA+eXKLU3PJTCAaaZ37g2hWkJSX1NjfuoP65cNMWHHZC9zE1SIXJF9sJlyeI2q+yhdvLWrkgsj4gzmIWS5IH9JFRWpoTbiCHThvpkWwS3TTv6V9YVXxZtGu+QA2Dqzhn2XRq2gkC1tsCu+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqZE9KbQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqZE9KbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB631F00893;
	Mon,  5 Oct 2026 20:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231349;
	bh=SKfnu51q3muAyl30vNyHGQXoM+ASfY+KxO5loPRrSB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqZE9KbQ4R7T1LpNqG55m9fXU5lrEQ8emvFG6bXqxG0BUwwGUIhxi7qQVjAdYDr1y
	 XXAUnxKNZT4nQhIF1F04JqKrQHHSrI3nuA6RsRjlHFl9mRAWgEGnHK/bl0DJrvJ5mT
	 PiUUx50IhVymFHgllMM9sV9x2jjN6FNpj4bOvNfJCQ85Ebrq/7j0RWEWmxik5p4c+O
	 HLUoj6fSRrTynn4pJDHz55tRpDdItNoIZ+qvYxSRz+ycJ3b4XXnt66HGnL4zHEVR/I
	 LjWeoqQ4MuZpDmAqjl0DExuW8Z7wfJghIOvrxkmZMnVEUr1ooazfAjpp6qK/gqKv9M
	 uY4xcnCYxk7vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tty: fix saved termios reset race
Date: Mon,  5 Oct 2026 16:15:45 -0400
Message-ID: <20261005201516.3124531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100542-sloping-tumble-a7c6@gregkh>
References: <2026100542-sloping-tumble-a7c6@gregkh>
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
[ sashal: Adjusted flag and documentation placement because TTY_DRIVER_NO_WORKQUEUE is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/uart.c  |  3 ++-
 drivers/tty/tty_io.c            | 18 ++++++++++--------
 drivers/usb/class/cdc-acm.c     |  2 +-
 drivers/usb/serial/usb-serial.c |  3 ++-
 include/linux/tty_driver.h      |  6 ++++++
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 10df5c37c83ed..78bf8c4031e93 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -944,7 +944,8 @@ static int gb_tty_init(void)
 	int retval = 0;
 
 	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
-					 TTY_DRIVER_DYNAMIC_DEV);
+					 TTY_DRIVER_DYNAMIC_DEV |
+					 TTY_DRIVER_RESET_SAVED_TERMIOS);
 	if (IS_ERR(gb_tty_driver)) {
 		pr_err("Can not allocate tty driver\n");
 		retval = -ENOMEM;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f74705a37c41f..dd7231d9cab96 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3283,14 +3283,16 @@ struct device *tty_register_device_attr(struct tty_driver *driver,
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
index 188ee9b768eb6..77d0789642394 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -69,6 +69,11 @@ struct serial_struct;
  *	Do not create numbered ``/dev`` nodes. For example, create
  *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
  *	driver for a single tty device is being allocated.
+ *
+ * @TTY_DRIVER_RESET_SAVED_TERMIOS:
+ *	Reset any saved termios settings on device registration when reusing a
+ *	minor number. Must only be set by drivers that guarantee that the minor
+ *	number is no longer in use.
  */
 enum tty_driver_flag {
 	TTY_DRIVER_INSTALLED		= BIT(0),
@@ -79,6 +84,7 @@ enum tty_driver_flag {
 	TTY_DRIVER_HARDWARE_BREAK	= BIT(5),
 	TTY_DRIVER_DYNAMIC_ALLOC	= BIT(6),
 	TTY_DRIVER_UNNUMBERED_NODE	= BIT(7),
+	TTY_DRIVER_RESET_SAVED_TERMIOS	= BIT(9),
 };
 
 enum tty_driver_type {
-- 
2.53.0

