Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8337F739
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323665; cv=none; b=fMH1QsDKdI4zZTbxlOA3BNjrWiWRqjI1WfYRcV8h4SYlhiaamhFxtMg2xduLujTwRWa4C5V3jAIRe4N3/bNLDhOync4z4FxkjRVY5LOj/JZAwl4nm46Dhsmc3174bOv+YSw2PxfXsvpAYoDXGFxejJMdptb1eeTRx82fi/WzLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323665; c=relaxed/simple;
	bh=TxbeUjCa9al91JPIkSLvKCRBKdh1KnM7BPOrgdkqfyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXZmSBfW9PODM/TKAmksbW/xJFgbgMZLgtO+7NhVaIqwt7FN2Lx5E+/Ta2ZR6zkJkvQfoRYfm9papQ+RCwJl6vuoZkGwPP6DDpJlrX9mnB22w0vltaG9qVP5KfB+4yoKZye9AZZol0ADghc+ukJ3lKtQ14rSzIvLLOCV3odLpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtrpyeq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtrpyeq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7C1F0089B;
	Tue,  6 Oct 2026 21:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323664;
	bh=HYCU6Ki3vWVxaMDrQTLJIlbrOBSzCEEDyW0qSYSHL6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vtrpyeq/PjA1aGpaKzFnCed4huzEQbF8oZmor+xpGQMaMTowABzVyPVrVf+oy9h92
	 7Oh5KOv1S3A+z6ptfjWwrgmMZ3If0SA0jMdpIHr7jFvcSK+pQHCkd3uAxe2p8BQ2ei
	 n1ZT6n0oFwk/gYquj4Ws4TBDKsAXtXiV0Du7HUw87Jz4Gn1l4jp7VKeCZHfh0vSJ2+
	 fCvaSh5oADXzhc3WLDxYwuTkHzh1VCqgnNYG2218ZxHfH1CqZF0DPwDMDFNIvqJfQk
	 mWY9pmYDUEyguj/JyoBpYpkIs9kXfYhbLDU0Ayf2Bcm4t3X/pe5+gDZNrCS7wKTYr2
	 ojruII4s30YKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] USB: serial: clean up core error labels
Date: Tue,  6 Oct 2026 17:54:19 -0400
Message-ID: <20261006215410.1049394-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100554-headlamp-saffron-1e8c@gregkh>
References: <2026100554-headlamp-saffron-1e8c@gregkh>
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
index 1a94abe09433c..0e80df03df216 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -225,17 +225,17 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
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
 
@@ -247,11 +247,11 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
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
@@ -1333,7 +1333,7 @@ static int __init usb_serial_init(void)
 	result = bus_register(&usb_serial_bus_type);
 	if (result) {
 		pr_err("%s - registering bus driver failed\n", __func__);
-		goto exit_bus;
+		goto err_put_driver;
 	}
 
 	usb_serial_tty_driver->driver_name = "usbserial";
@@ -1351,25 +1351,23 @@ static int __init usb_serial_init(void)
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
 	tty_driver_kref_put(usb_serial_tty_driver);
 	return result;
@@ -1514,13 +1512,13 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
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
@@ -1528,11 +1526,11 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
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

