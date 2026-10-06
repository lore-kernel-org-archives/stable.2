Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602337F739
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323667; cv=none; b=VMjvtwDl/OA6KZy77+mmAdCcEQxNd+bgMSZf/0UbQKQCdYqJRiD0RPQAPIZXERp4TO7rdj4VLlM2I3EHvcFqm0QocV62PkfwCbjDCE1hezcRJVZidJ2AV1MnphkYvcz89z/ZN7BxbJfUOxiUGbTMayNepINNwKp1EZehenwOFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323667; c=relaxed/simple;
	bh=HMiB1rNxM/BzNBhFMns6seQSxGJVghwsxnIKw50aeRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koaXPQQoxq1ND1cZXAL0DFoB7PwLcyExq3E0BQWQnqrVZzeFNJL9hhfdg3We4jRXirb3FYQ8qBw+SV85y42SB5DXwEKLRYDn/gMyt3uPEzCYLgtqXuJNEex9TarQnDkgoB294eC2pxlFV+bv0orJW54FKjCZrrx9MoQzDp+s52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3hnjqc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3hnjqc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D01F0089C;
	Tue,  6 Oct 2026 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323666;
	bh=vmMx2IQVPwL1kmtR/ZbLHNk1uD+wQpWvq1E+GTs05oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3hnjqc9B1OTESveoIcHz873H0Jipcx9wXU90YKW6WWPGqmU8nG+oIxMeFXJs5w5E
	 jrICENpJXTl3ZeaB8Xy+JiYPLnG66tTI9W6p3ko45TJY95jzTjvOG3fOG1dcgiyrAE
	 uUgQOXsazGks6u2T+9I8JM8sfzklX9cl8Wwpy/ig9MSa+bImrkXLtyZldt9DYR+SC6
	 GaevGW6pFadvRppauQ/b6o60DidNzaxpnT3uvgdogIr6OehWI6gTNf6kpUxX8q6wBg
	 nSnV+jO119S0Z7s2LjCmfmmUIIKq5fBr1yeJr6mBzKTbXKWP4iSzbO85RokXUlPxDw
	 EgZQCKkOozgeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] USB: serial: fix driver deregistration order
Date: Tue,  6 Oct 2026 17:54:20 -0400
Message-ID: <20261006215410.1049394-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006215410.1049394-1-sashal@kernel.org>
References: <2026100554-headlamp-saffron-1e8c@gregkh>
 <20261006215410.1049394-1-sashal@kernel.org>
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
index fb87e39f8c16e..545849f8e41e1 100644
--- a/drivers/usb/serial/bus.c
+++ b/drivers/usb/serial/bus.c
@@ -171,3 +171,7 @@ void usb_serial_bus_deregister(struct usb_serial_driver *driver)
 	free_dynids(driver);
 }
 
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver)
+{
+	driver_remove_file(&driver->driver, &driver_attr_new_id);
+}
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index 0e80df03df216..9aafc7ed7c545 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1475,7 +1475,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 {
 	int rc;
 	struct usb_driver *udriver;
-	struct usb_serial_driver * const *sd;
+	struct usb_serial_driver * const *sd, * const *s;
 
 	/*
 	 * udriver must be registered before any of the serial drivers,
@@ -1527,9 +1527,11 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
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
@@ -1547,10 +1549,23 @@ EXPORT_SYMBOL_GPL(usb_serial_register_drivers);
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
index 16ea5a4cc586c..72b183bf34f72 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -382,6 +382,7 @@ void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
 
 int usb_serial_bus_register(struct usb_serial_driver *device);
 void usb_serial_bus_deregister(struct usb_serial_driver *device);
+void usb_serial_bus_remove_new_id(struct usb_serial_driver *driver);
 
 extern struct bus_type usb_serial_bus_type;
 extern struct tty_driver *usb_serial_tty_driver;
-- 
2.53.0

