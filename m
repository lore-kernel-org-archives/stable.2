Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CD4A262D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211266; cv=none; b=jz1RZW1YW5BCinbtffX9fOvL0+xnY39ZOwSrqRXCFPgBsE+0cqGZt6QI7q4owkoDTt1+Mb6FIjDW+TAscU3cAnakoXBxRZkikISbxsiRBX42PkXjPHIEK/jxEHIASa3F3dbjP4ofZ69jAElLqU00sOUPJHiJqIVnMdjyp5TqHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211266; c=relaxed/simple;
	bh=3Cs7oj2YPurUOo347Ny2tiMYl5zu9Xp5UCWQ4f/652M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TNKmKMUMsTbG81qO8Cd6+CawxJyydqRhc9HhBl6VLDbh03d2UMzipFnWYL0Fh4aZ6Vv67gXCe5B0e7w7ylk/rbdGzTxZVB6uzc13xPLmjocnmBvRddO3EUeIz38mmB7lI7U6kKAPh3mxCo8dWqjoncA2a5XSNFmfGitjyjbHzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qfkFanMC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qfkFanMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BCD1F000FF;
	Mon,  5 Oct 2026 14:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211257;
	bh=1kjXB1H3Ajx/PFFipBjSmjy8qeotD3euFjnqOAbTDlc=;
	h=Subject:To:Cc:From:Date;
	b=qfkFanMCPw16taa563xgGCeTnGkkJnuTGB5wxcDbGS6aF00dko/WhK5OoklBtuWv6
	 MycuYyovM394FCJ9QhpMB972cQCppVtv2YUwbGS6lX5nDtwKzJkla5W0sjOHxAHoKD
	 MHkgSjRg5DyNf+5DHbuFvpqaSsWsNSQIWK4QXKYc=
Subject: FAILED: patch "[PATCH] USB: serial: fix driver deregistration order" failed to apply to 5.15-stable tree
To: johan@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:40:54 +0200
Message-ID: <2026100554-headlamp-saffron-1e8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 646e5b28b4fdbc1b828a2398d6ced2c1dd308a46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100554-headlamp-saffron-1e8c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 646e5b28b4fdbc1b828a2398d6ced2c1dd308a46 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 21 Aug 2026 17:45:45 +0200
Subject: [PATCH] USB: serial: fix driver deregistration order

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

