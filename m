Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E79547040
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324644; cv=none; b=gbgrV/qGGY6VOVgilej92ePJqezL9Gj04ifsdtiCimAvWuoJ3rgYdNolIZyucde3D23+XXWUJrFQsdkBQHFwrbk10+T1c9o9KAcguB+SuSdLXo4gv3h3vQfXgOU/Z7nODzKzT0NVCzI64L3BfiR6wzLUGKhNKtxBBk4OuAzk2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324644; c=relaxed/simple;
	bh=IwhjVsn48hYtfv+G2RiyGap4pLTsVbRrLsJLZIRz6oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5ca5nNH3Ai5qWuPOT9Tc0nSc5X+Ea6oaNldFiJqnyhwkBdA81/VTEcVPDN3qgVxL9Dvt2nQCSPBHCBMy1Rd3xzI+YqFbjRqnI97a1cdPwU8xNu4CGxSctd7Pz4Cy47f7pxhOPIf5VBDxNVjvKty+JO+eoLIYifLjY1hv8psZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMrYfqqO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMrYfqqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121891F0089C;
	Tue,  6 Oct 2026 22:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791324642;
	bh=g2l1dCWMPVBsiZ9HDYBug0yj3CyfsXZVicwFkIMcmI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMrYfqqOo4gywdIQwMynzDiiz7MW2dIqXcgfBMAv+AIX6a18zaB9z8b5amCUZlZ/l
	 cGHCynNYxI6L/G5Rkt2FRWTHgCOfr2woRWX9MIIheCmVZVna0nEK2K1CaT91njtntk
	 hIgLT+gyZgCRuXWX42TTUjoeGUFHZWzKc2olirgDonYBNNmgnvRoPbIyno1TXBy++e
	 qh8u5FawNuOpQe7oeIiPObyAuyyxuaZCvSRauorHgzG2N8JX2cyoAyiRq27rGK/EQV
	 ZbypWAe1xPkXz6MmLYui+kS9td8YNvwJ1sN86CDOanz6KYG6MN21wjOSabMM8Ys2Xi
	 eu4qZJkMd9cuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] USB: serial: fix driver deregistration order
Date: Tue,  6 Oct 2026 18:10:37 -0400
Message-ID: <20261006221026.1103392-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006221026.1103392-1-sashal@kernel.org>
References: <2026100554-punctual-reviving-6cb6@gregkh>
 <20261006221026.1103392-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 646e5b28b4fdbc1b828a2398d6ced2c1dd308a46 ]

USB serial driver modules register one driver for the USB bus and one or
more drivers for the ports on the USB serial bus.

When unloading a driver module, the USB driver must be deregistered
before the USB serial bus drivers so that I/O is stopped before
unbinding the ports to avoid use-after-free in completion handlers
accessing port data.

Note that the "new_id" attributes must first be removed to prevent new
ids from being added and triggering a probe of the USB driver after it
has been deregistered.

Fixes: 765e0ba62613 ("usb-serial: new API for driver registration")
Cc: stable@vger.kernel.org	# 3.4
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/bus.c        |  4 ++++
 drivers/usb/serial/usb-serial.c | 21 ++++++++++++++++++---
 include/linux/usb/serial.h      |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index bbb981041c10e..de6d9f9ecd3a5 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -188,3 +188,7 @@ void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 	free_dynids(driver);
 }
 
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver)
+{
+	driver_remove_file(&driver->driver, &driver_attr_new_id);
+}
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index d762de57710f9..6a0dbda7e18b6 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1366,7 +1366,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 {
 	int rc;
 	struct usb_driver *udriver;
-	struct usb_serial_driver * const *sd;
+	struct usb_serial_driver * const *sd, * const *s;
 
 	/*
 	 * udriver must be registered before any of the serial drivers,
@@ -1418,9 +1418,11 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 	return 0;
 
 err_deregister_drivers:
+	for (s = serial_drivers; s < sd; ++s)
+		usb_serial_bus_remove_new_id(*s);
+	usb_deregister(udriver);
 	while (sd-- > serial_drivers)
 		usb_serial_deregister(*sd);
-	usb_deregister(udriver);
 err_free_driver:
 	kfree(udriver);
 	return rc;
@@ -1438,10 +1440,23 @@ EXPORT_SYMBOL_GPL(usb_serial_register_drivers);
 void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_drivers[])
 {
 	struct usb_driver *udriver = (*serial_drivers)->usb_driver;
+	struct usb_serial_driver * const *sd;
+
+	/*
+	 * udriver must be deregistered before the serial drivers so that
+	 * I/O is stopped before unbinding the ports.
+	 *
+	 * Remove the new_id attributes to prevent ids from being added and
+	 * triggering a probe of udriver after it has been deregistered.
+	 */
+	for (sd = serial_drivers; *sd; ++sd)
+		usb_serial_bus_remove_new_id(*sd);
+
+	usb_deregister(udriver);
 
 	for (; *serial_drivers; ++serial_drivers)
 		usb_serial_deregister(*serial_drivers);
-	usb_deregister(udriver);
+
 	kfree(udriver);
 }
 EXPORT_SYMBOL_GPL(usb_serial_deregister_drivers);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 8e67eff9039fa..d98521605f8d6 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -378,6 +378,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 
 int usb_serial_bus_register(struct usb_serial_driver *device);
 void usb_serial_bus_deregister(struct usb_serial_driver *device);
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver);
 
 extern struct bus_type usb_serial_bus_type;
 extern struct tty_driver *usb_serial_tty_driver;
-- 
2.53.0

