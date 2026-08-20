Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4954C1A3160;
	Thu, 20 Aug 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237744; cv=none; b=q2Z34fHAez+Vdy5gq6+WsG+Hj9h15XhOZOm7LJ70vFkU7jO/N+gNSoZhDcX7c1lDkcLSjouC2JhuWOF5sKygqeg07fEyVOxAeZcnARhyX1Hpco5fWOWqSsIUtVb4xSloEIl+iCi0Kf+iP6SgBp/kvd+nFP6AktwpwSWF8Ezny9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237744; c=relaxed/simple;
	bh=SgFhHEDn+hyXiVIyNKDqOR5VodipRAz5cYCbN2CAwLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1aTMzscRckVFunNBzjlOW1l/bLkY8hSFBx3Wv5qWmJPVVoEMmHEuDRvcpFhNX9eJZmbZ6T0XbR0WW40Buz0gerlqtJS6gGDOZpoBFkdi3ooI2enKKghoyoN0eh/dXP5X3q8Uoo1gxkDYkaTrjer9I7IZvwYKYlGq7s2sX00uoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXE2E1FV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXE2E1FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DE91F000E9;
	Thu, 20 Aug 2026 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237743;
	bh=gpiz1AFuKOVRZzJUeStRF55Fo8fO48SSIgGLq/fRdGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXE2E1FVTwxjxYgrUUztEM3wpRe3ZH5ZDOMLcp4csAiy4uAeWBmXgBgTSt4Wc20sA
	 IMWYNFDTDay71Kf4Dj3LnWFEFHXNr0NBTBm7tVANw0AIimdPx9aGakwQinvPxoBr+1
	 3Kc/rNEJIP0K2EbkFaaITlW67tMoFzfhMor/vk4gCmtp4+Muqpf7vA8C7O2bFT+g7Y
	 XjORFphBvkI8MyRe0dqSRuWtaVfbSu2y3is5M7s+nFzQD1u0/gt9E+9imWW71wg9LU
	 giiTHnCYHlNRZ7gjrUQdq7O2W16Sj07EDT6vF5uvY4LXXFLAbnDyC1exxOSqtEUbjj
	 oBaJwBHO7QYyQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wx4BA-00000001p33-4B2h;
	Thu, 20 Aug 2026 16:55:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] USB: serial: fix driver deregistration order
Date: Thu, 20 Aug 2026 16:54:02 +0200
Message-ID: <20260820145402.434447-3-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820145402.434447-1-johan@kernel.org>
References: <20260820145402.434447-1-johan@kernel.org>
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

Note that the order does not matter currently in the registration error
path as the USB driver is not bound until after the USB serial drivers
have been registered.

Fixes: 765e0ba62613 ("usb-serial: new API for driver registration")
Cc: stable@vger.kernel.org	# 3.4
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb-serial.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index a4fbc849c0fa..08a9b6f8cf7d 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1522,9 +1522,9 @@ int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers
 	return 0;
 
 err_deregister_drivers:
+	usb_deregister(udriver);
 	while (sd-- > serial_drivers)
 		usb_serial_deregister(*sd);
-	usb_deregister(udriver);
 err_free_driver:
 	kfree(udriver);
 	return rc;
@@ -1543,9 +1543,15 @@ void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_driver
 {
 	struct usb_driver *udriver = (*serial_drivers)->usb_driver;
 
+	/*
+	 * The USB driver must be deregistered before the USB serial drivers
+	 * so that I/O is stopped before unbinding the ports.
+	 */
+	usb_deregister(udriver);
+
 	for (; *serial_drivers; ++serial_drivers)
 		usb_serial_deregister(*serial_drivers);
-	usb_deregister(udriver);
+
 	kfree(udriver);
 }
 EXPORT_SYMBOL_GPL(usb_serial_deregister_drivers);
-- 
2.54.0

