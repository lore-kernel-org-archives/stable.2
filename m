Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BB547040
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324642; cv=none; b=UtZgIodAZr5Mg61Rg9f0gdGmgxG70j81ay8uzkoaWze5Osr2t+/L+e95ZZ2nPPEUkXwQQPmXfhFJuZqgMaY7Dwd8XSMGpl5DWmqg1/HLd8IasK0xYk09+lAKt4aWu+qLPd07MrCDzZZUPttX8P6FHbQQ2XncMsP0o2QWTqxANTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324642; c=relaxed/simple;
	bh=ZHIhqMFQv0vE6DZRXaiSMWP/Bc4H2TH55WJggbcwJz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4i9hY8qdkr7wEDchtswp+zkELOIrnEkR1cr2XAuyR0t6qHK6I6UNF0Xrz2jzJEIIWnhWl6x/Q9rjalqSWq5BYJdwfLLwqZNcqsU53rAm+54o503vLZ5JzVLMhkjrqGG1QobBVelPqE5T3rkEyZqirRz+qnw6sVwCqcmRgWCZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCp6mur9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCp6mur9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757EB1F0089B;
	Tue,  6 Oct 2026 22:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324640;
	bh=2m5EiI/ZjTkzvYfohys4z74+SdG8NE6TkU7YdtKadEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DCp6mur9qSnVbHqA55J10brd9b9af1h7Q6YEC0EnkMitvN3gepGTlOfhiHD2PnC/4
	 vMr/dHFyeQb+vhfVCzGzapFipv+BfFoABvssKpiOWKK5tk1HNQQX0erVuw+CfnN5Vk
	 kRnC8qEH8T8xVTZHfs2mc9axopeoci6gXZX7pL/HtXkn49iZWkuzqlqKD1d+MhaICl
	 52lsvXoZAbWlZ3mKRd9WVLJyNSAISWi+iWIS/qVnBGGLpqOhf+ZLcHWe7Tt0X+2VOl
	 sgMdgdZvmzXYozs11xnPVCigkBYfRjZiOrpijrQXRhw7pi0P0OSqZZNm9Qmoa/xH0w
	 834roDBO+Kyxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] USB: serial: clean up core error labels
Date: Tue,  6 Oct 2026 18:10:36 -0400
Message-ID: <20261006221026.1103392-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100554-punctual-reviving-6cb6@gregkh>
References: <2026100554-punctual-reviving-6cb6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 96a83c95c3da5ba55ea2cf6ce87de10fc03417a9 ]

Clean up the core error labels by consistently naming them after what
they do rather than after from where they are jumped to.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Stable-dep-of: 646e5b28b4fd ("USB: serial: fix driver deregistration order")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 98797c2b96ca2..d762de57710f9 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -187,17 +187,17 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	serial = port->serial;
 	if (!try_module_get(serial->type->driver.owner))
-		goto error_module_get;
+		goto err_put_serial;
 
 	retval = usb_autopm_get_interface(serial->interface);
 	if (retval)
-		goto error_get_interface;
+		goto err_put_module;
 
 	init_termios = (driver->termios[idx] == NULL);
 
 	retval = tty_standard_install(driver, tty);
 	if (retval)
-		goto error_init_termios;
+		goto err_put_autopm;
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -209,11 +209,11 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
+err_put_autopm:
 	usb_autopm_put_interface(serial->interface);
- error_get_interface:
+err_put_module:
 	module_put(serial->type->driver.owner);
- error_module_get:
+err_put_serial:
 	usb_serial_put(serial);
 	mutex_unlock(&serial->disc_mutex);
 	return retval;
@@ -1222,7 +1222,7 @@ static int __init usb_serial_init(void)
 	result = bus_register(&usb_serial_bus_type);
 	if (result) {
 		pr_err("%s - registering bus driver failed\n", __func__);
-		goto exit_bus;
+		goto err_put_driver;
 	}
 
 	usb_serial_tty_driver->driver_name = "usbserial";
@@ -1242,25 +1242,23 @@ static int __init usb_serial_init(void)
 	result = tty_register_driver(usb_serial_tty_driver);
 	if (result) {
 		pr_err("%s - tty_register_driver failed\n", __func__);
-		goto exit_reg_driver;
+		goto err_unregister_bus;
 	}
 
 	/* register the generic driver, if we should */
 	result = usb_serial_generic_register();
 	if (result < 0) {
 		pr_err("%s - registering generic driver failed\n", __func__);
-		goto exit_generic;
+		goto err_unregister_driver;
 	}
 
 	return result;
 
-exit_generic:
+err_unregister_driver:
 	tty_unregister_driver(usb_serial_tty_driver);
-
-exit_reg_driver:
+err_unregister_bus:
 	bus_unregister(&usb_serial_bus_type);
-
-exit_bus:
+err_put_driver:
 	pr_err("%s - returning with error %d\n", __func__, result);
 	put_tty_driver(usb_serial_tty_driver);
 	return result;
@@ -1405,13 +1403,13 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
 	rc = usb_register(udriver);
 	if (rc)
-		goto failed_usb_register;
+		goto err_free_driver;
 
 	for (sd = serial_drivers; *sd; ++sd) {
 		(*sd)->usb_driver = udriver;
 		rc = usb_serial_register(*sd);
 		if (rc)
-			goto failed;
+			goto err_deregister_drivers;
 	}
 
 	/* Now set udriver's id_table and look for matches */
@@ -1419,11 +1417,11 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 	rc = driver_attach(&udriver->drvwrap.driver);
 	return 0;
 
- failed:
+err_deregister_drivers:
 	while (sd-- > serial_drivers)
 		usb_serial_deregister(*sd);
 	usb_deregister(udriver);
-failed_usb_register:
+err_free_driver:
 	kfree(udriver);
 	return rc;
 }
-- 
2.53.0

