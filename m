Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449142;
	b=zIgFj8xXTGBPamPmjC7a9Sbw+YNE26k49PbKAI+zOWG6s1gWQZZtmzIx+GlNv6oUlm1O
	 J1cNn08GeyaiURwPoiqc9sazLOLWzIOns5TjtwnCBfgqujgq588KF1bIpZkodRt7d/7Ho
	 tlI8J8d7LCJF5hurP7tZyvu7mhYugUKlnY/Sh3X33kKPt0sj7n8HsmodD3zfPKvLT/6YV
	 3Oo3nZif2tSKl1BoFktzBS2HgAESKj18LavMTNW8F3mlaxseeXA6m6W8NuFfwJLmMbo+b
	 cKFYo3BI6vTl4mspOzdINMUVVjBvnn+ZcM8uetHPL8ZC/2DoLlW9TMqGCYa4wfxb0Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IpSm7gOHg0rNx/0QtKvP1UgAt2DgutkaebtGQXjDEnI=;
	b=yIMnF0LdK0xSpZEP4/Ba4I5seJpEJD//GmODthVVbRJ+BOyXeGPOXqoYwPi0bRWA4ofy
	 2Mx57YAwLVgeaaSrSDW3DakJIxpDFOlHwxl3xuRW2G8OjIaiGUnGcyM6C7/PZpktz7F3P
	 xY6PoB9lBJwQY+fRyTSYIsjURS3108DDpYTFBMy53Jfy4DAHzFhsYvSvdMQiHz1ui1lHF
	 payhlhRrjjRdCeF1Bnl3Bgiz2mWVDE65WC4ugD/2R9avYUCjRrYWPOukQ9dff2ng13Iwe
	 Swi07WVKxSiksZIhAa5n+yz9HKxrxUSWRqYvWozpn2QfpDyZyNrAQj4eCn3kQMWzDdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjSARLuD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35A9606A335;
	Mon, 23 Nov 2026 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjSARLuD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631EC1F000E0;
	Mon, 23 Nov 2026 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449141;
	bh=IpSm7gOHg0rNx/0QtKvP1UgAt2DgutkaebtGQXjDEnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MjSARLuDpOWnssQ7Q4QsoT0v/JfKvzLept0SQMDEeUesN51NPfwcE4XdLWvVfLMQ/
	 V9nXN1xk2i5HoJJqV5ou7jnYIfCgbEJ4znoTYjdb0JMDuAR3iq+F+75RB3fMDpafUW
	 zjQ2zx5aX/C5i+uC2L4UICJgDhZWBGqfYQ/EjA2uy+6+sVWCY7e/UjXQ8d9azKlFCO
	 jcQiYXW6AxTkSI3NRyU+AcYIQzB3OJrSP0pNRt6SoxRgA3henQ6btdl4JglFDXvRMI
	 8lCeCv0vZ+uCP8Wgt0kGi1gokWqAvg6RZJzTOeLDpVt6hPG5PKlBCbDj+tM2p1yqUI
	 h0Li7KbiIZGgA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] HID: roccat: pyra: Resolve USB device from parent in actual_profile
Date: Mon, 23 Nov 2026 15:50:49 +0000
Message-ID: <20261123155138.2907049-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123155138.2907049-1-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pyra_sysfs_show_actual_profile() is a sysfs attribute callback on the
roccat pyra class device, whose parent is the HID device and
grandparent is the USB interface.  While it resolves pyra via
dev->parent->parent, it passes dev directly to to_usb_interface(),
casting the HID device to a USB device and passing the corrupted
pointer into roccat_common2_receive() and usb_control_msg().

Walk up to dev->parent->parent first, matching
pyra_sysfs_show_firmware_version().

Fixes: be34380ef818 ("HID: roccat: cleanup of pyra module")
Closes: https://sashiko.dev/#/bug/linux-070d5d7b-29ab-4451-90bf-175ada0a81e9
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/hid-roccat-pyra.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 44c2b416f2db..b3dde2998850 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -290,11 +290,14 @@ static DEVICE_ATTR(actual_cpi, 0440, pyra_sysfs_show_actual_cpi, NULL);
 static ssize_t pyra_sysfs_show_actual_profile(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct pyra_device *pyra =
-			hid_get_drvdata(dev_get_drvdata(dev->parent->parent));
-	struct usb_device *usb_dev = interface_to_usbdev(to_usb_interface(dev));
+	struct pyra_device *pyra;
+	struct usb_device *usb_dev;
 	struct pyra_settings settings;
 
+	dev = dev->parent->parent;
+	pyra = hid_get_drvdata(dev_get_drvdata(dev));
+	usb_dev = interface_to_usbdev(to_usb_interface(dev));
+
 	mutex_lock(&pyra->pyra_lock);
 	roccat_common2_receive(usb_dev, PYRA_COMMAND_SETTINGS,
 			&settings, PYRA_SIZE_SETTINGS);
-- 
2.56.1.750.gf70dc682cf-goog

