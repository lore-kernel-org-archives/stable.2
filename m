Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B6A3AA1B5;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497450; cv=none; b=NuIfk8ZQBsm9Z0CT7iXGqJG4tYVDuXkttV7rkIdTd6n7loKYxoSHU1HILuwS/o+W8kBNoBQQyExhDLsF1JtKiYazd7XafKbLNKHRM4OehFyswtT5EuCaAxplSSynMDbfEkShYDGJRPzf4p6GdIvwO6C71DII8Swzx2Hwz4qGyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497450; c=relaxed/simple;
	bh=zcn1dK/29EDlDuUjELmkDL4xNInnWxDqRDZS9QfhRPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRt2jmc35k7xtvTdb3I2lFsby9qaYd8eUDbCUXDVa36FZasejXpZhQ/DrBqpglbZ6ZBQEGDqkt8HAcR/Zt3p1128byVGN2KHkBSxpbCtLrgwJCid6WHUw9qPFZSUOve7d+dHGgK5ITA9eINErzXF5LlQvLiYtX/uGrLhxWqu8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpbhsxjB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpbhsxjB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F591F00893;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=fqO4LZkLQ5FT3GK1shuzVv/gvIRfqdWBmfuDHOglRjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fpbhsxjBaAq7gaOcNGbE7pCZ+Sa52LF2PKsVNqv99+RTrxWKjQ/UveS+G41+2Vped
	 HbKF71khqgYCbLJXN4dbnVWMx7Um8XAXJhRSqIefy6VCi6GzqiBnIErKkvok7sNuYW
	 hJmJLjR0aAFWObLOGA+oIyP8FtVdIUFeLxb2qKVc63tJTGkxsdXuldpkaxsqNNIIDS
	 hz7ie65Z2mro96ZVoPFXzoI88/nuXV7LCG5K6RuSVHb83qxZVOZ1m74a69aGoVGMuT
	 j2hn4uolKjeGiggVAi8EqFHPbHRz7AzgIWvYOxhwhbdWC4WfWySJ3x8w+8SofESB10
	 2yAONO6eX6L9g==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYB1-373j;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v3 RESEND 2/5] Bluetooth: btusb: fix use-after-free on marvell probe failure
Date: Wed,  3 Jun 2026 16:36:40 +0200
Message-ID: <20260603143643.2514595-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603143643.2514595-1-johan@kernel.org>
References: <20260603143643.2514595-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to stop any TX URBs submitted during Marvell OOB wakeup
configuration on later probe failures to avoid use-after-free in the
completion callback.

This issue was reported by Sashiko while reviewing a fix for a wakeup
source leak in the btusb probe errors paths.

Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
Fixes: a4ccc9e33d2f ("Bluetooth: btusb: Configure Marvell to use one of the pins for oob wakeup")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c8015cee240f..d0a83a1ffdf2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4218,7 +4218,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
 		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 
 		/* Transport specific configuration */
 		hdev->send = btusb_send_frame_intel;
@@ -4381,7 +4381,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 		}
 	}
 
@@ -4389,7 +4389,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4425,6 +4425,8 @@ static int btusb_probe(struct usb_interface *intf,
 		usb_set_intfdata(data->isoc, NULL);
 		usb_driver_release_interface(&btusb_driver, data->isoc);
 	}
+err_kill_tx_urbs:
+	usb_kill_anchored_urbs(&data->tx_anchor);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.53.0

