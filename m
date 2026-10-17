Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9B47F3B3;
	Sat, 17 Oct 2026 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240531; cv=none; b=FJLLEzVrQQkGvOhJi9B5L9W2jn9MOXwZNiMLfWa+yDH1BIjJLRWPky6GqP64hoOmD/BzNMoPnV1On+SJo5IWCLqRMioHz3GIHFIEjo14xSctsXYAgLhWkPXUgwIqgq7MczTHxs+JiWzywdGQhQL0YU7qYyDDHYsfjO1ZpnGCrbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240531; c=relaxed/simple;
	bh=cjJBeEPLcHDbkV6JGaku1tIYNvbzL+wVO5bYC27orOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADwfoF8MKvDcfNJ/BBpjb5XQV9ySe4c6n+c+8SZntT8ffFnsCoIz27d8RO7C2Smn3arfa95ubDFXyYsvZYRTOs/PaoiQ3hYNKFUWZoLkKy6yK1ORNLNAEjzJKKwwC4B3zfzfN0hLF6eXvfRqANHqffdk5Q7wlvZSSx/6yz7zkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPxZjyje; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPxZjyje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762DA1F000C4;
	Sat, 17 Oct 2026 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792240530;
	bh=s677F6iPgsAsYLk4eGhZ4qm0Q7QUokydL0p0lzRJj/s=;
	h=From:To:Cc:Subject:Date;
	b=ZPxZjyjefAAhlAqmweSpRL/vrY5NIa8lYKTNoYOEzv4TjIXAWz/L63HhuegJ/Eq+c
	 zce+YRywvMGxReGu37SL9AAy5LdzIgCXVyW+VpY9ljPOMvKsvn9yoyHawwhmy1KsSP
	 XczzuzLfJ4FyXmkL2wOBouGjI3hDs4eZgfA7UPSX1D60cuQvb48Kt88Jt5kke8GIjg
	 KCJV07mGSo7QoNIgAWUFW9y2jBs7CpQ0CysKGscOHDTO4mk4k9H3Uff6MtRyJoW9Zz
	 Gj4pBjAJH0NembSKxmgg7jEOY46Ym4NZCerkVWIqVve9/Sr7dwp2jUADilutW+hYxR
	 Nl+mB+zDYlkNA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xI3dI-00000007VNL-1NHg;
	Sat, 17 Oct 2026 14:35:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: usb_wwan: handle urb allocation failure
Date: Sat, 17 Oct 2026 14:35:15 +0200
Message-ID: <20261017123515.1788872-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to bail out from probe if URB allocation fails to avoid ever
dereferencing a NULL-pointer in usb_wwan_write() or on resume of an open
port.

Note that URB allocation is not expected to fail unless doing fault
injection.

The usb_wwan_write() issue was flagged by Sashiko.

Fixes: 58cfe9113e48 ("[PATCH] USB: add Option Card driver")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 6beb4062bda3..92362565796d 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -343,8 +343,7 @@ int usb_wwan_open(struct tty_struct *tty, struct usb_serial_port *port)
 	/* Start reading from the IN endpoint */
 	for (i = 0; i < N_IN_URB; i++) {
 		urb = portdata->in_urbs[i];
-		if (!urb)
-			continue;
+
 		err = usb_submit_urb(urb, GFP_KERNEL);
 		if (err) {
 			dev_err(&port->dev,
@@ -465,6 +464,9 @@ int usb_wwan_port_probe(struct usb_serial_port *port)
 						USB_DIR_IN, port,
 						buffer, IN_BUFLEN,
 						usb_wwan_indat_callback);
+		if (!urb)
+			goto bail_out_error;
+
 		portdata->in_urbs[i] = urb;
 	}
 
@@ -478,6 +480,9 @@ int usb_wwan_port_probe(struct usb_serial_port *port)
 						USB_DIR_OUT, port,
 						buffer, OUT_BUFLEN,
 						usb_wwan_outdat_callback);
+		if (!urb)
+			goto bail_out_error2;
+
 		portdata->out_urbs[i] = urb;
 	}
 
-- 
2.55.0

