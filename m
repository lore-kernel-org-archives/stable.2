Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0D379C58;
	Fri, 21 Aug 2026 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787327175; cv=none; b=qibOl4pXHpycmBQox/JrqrDegzb5Ay0Zgo8zh9axzhv1GER4WUu6Ju3Zu2YsZKLhcYAqhzUzjxm98nZAEw+Nc3q7+Hg600RqbLzHVliBeozipVgv3znQosgBDysUotC9TnFR3LBfnpT0k6OW6wYJ7CJ3mFuupuKotAnKzIy89zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787327175; c=relaxed/simple;
	bh=rboFOSf6ARrwANdNbB1X3pSoLSyQ6jmKppHjr2yjOB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeZdD08+a4Eg1nnGCyDp8yPXrTEUadg//wAoT5ksBNLxLO1HReAH7tpSJPuul/GD6A9uN0+hBNP+kyEAX4fvWeP4+28mXuZhKvIzYHq/a5fPQwVMQnXykDdzOHxLwvACOsZQ4J0VBdqjyIbRStHM+5WFPBSCI7rLCqYUaqCntpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Puumhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Puumhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57851F00A3F;
	Fri, 21 Aug 2026 15:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787327172;
	bh=VKus00+91sYe0XoPOP+SuXFjgEF7I8m+MnZCdlkHChI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2PuumhcJ+NwkWruWS5Yb+UUM2w5l7JCuNTX5HThrDO2Tp7pWUETzm56qLq3Nz4At
	 Fh+qrIn64rNsHLoV7zWp0yejRZQ0EHf2KgGpAWtds2TjR8mNhrzhMqI43ajedM87gv
	 Mvu78HVA3U0qktAy/WXl+kMxeiFQcsC+ClVo18J6gQyDNDWZLFr1GAWsvscqeX5udg
	 x73OFHs6UG0wOVmDKTDnKIDDjpznZhRwmENx6L4n/V4OIgkeTJcoPzV+u/h1hpMPP1
	 +B8iRfBQ1UI/+sMqUIFYqnnzZ6bgRRKdTPIKpMgbs9SlexphbZ9fBLOdtPuTSdSO9u
	 s2UfwQpKfmlQw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wxRRa-00000000Uva-29Es;
	Fri, 21 Aug 2026 17:46:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] USB: serial: fix driver deregistration order
Date: Fri, 21 Aug 2026 17:45:45 +0200
Message-ID: <20260821154546.118809-4-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821154546.118809-1-johan@kernel.org>
References: <20260821154546.118809-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/usb/serial/bus.c        |  4 ++++
 drivers/usb/serial/usb-serial.c | 21 ++++++++++++++++++---
 include/linux/usb/serial.h      |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/bus.c b/drivers/usb/serial/bus.c
index 295c61afa44c..ea1fe5d1e449 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -169,3 +169,7 @@ void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 	free_dynids(driver);
 }
 
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver)
+{
+	driver_remove_file(&driver->driver, &driver_attr_new_id);
+}
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index a4fbc849c0fa..11a0ed6d6546 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1469,7 +1469,7 @@ int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers
 {
 	int rc;
 	struct usb_driver *udriver;
-	struct usb_serial_driver * const *sd;
+	struct usb_serial_driver * const *sd, * const *s;
 
 	/*
 	 * udriver must be registered before any of the serial drivers,
@@ -1522,9 +1522,11 @@ int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers
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
@@ -1542,10 +1544,23 @@ EXPORT_SYMBOL_GPL(__usb_serial_register_drivers);
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
index 534e6650e2aa..ab0a32a90629 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -381,6 +381,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 
 int usb_serial_bus_register(struct usb_serial_driver *device);
 void usb_serial_bus_deregister(struct usb_serial_driver *device);
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver);
 
 extern const struct bus_type usb_serial_bus_type;
 extern struct tty_driver *usb_serial_tty_driver;
-- 
2.54.0

