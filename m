Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE23C5DB8;
	Thu,  4 Jun 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555148; cv=none; b=u0Ir+HeF/ik1fiN0Sub+jKjj3SX2hm8UYvf+Oof57BoNjsiHK8J0pb584qePqgRfuBKIoJItdyNn1JsAUBngUJDJYEXMvlgdxLkwbpTZzVXUcAVDE72lltYEkJ9SeDzXa8cNJItWRj3lSrmyYXEwxDQmqjYOVvQ+E4245PYcfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555148; c=relaxed/simple;
	bh=g9iLgxOtg40w0aGSmMw3jPa87HlqU0Ya5cAoV4qeXEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIKA0RXY746TS3u0vQpAQGEzqvFPOnXpKj1a9p7cJQs7X4GQvUaxbLehqVzM5nQZ33yk9yKtrOHlK4/7oWp1FPrVKk7l6FFIfGA6MuCr7Jk9DWxeMGqbl4/z5WLbg3wQImxG69ZOp5v1JBFDoul16VkYhAreL8LkS5nGmdFmPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbplGQwX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbplGQwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA40E1F0089A;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555146;
	bh=KfkvNEfA6NZ0RTUJEBMdldhtWmqtT8xIv9nUpJq9HF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dbplGQwX5Ngpnt7TwlX8iV0Sb10I8A3O00fP2PiSBu1BMYUcllhzdtquzhDcBFh7C
	 fzML5QU8AH4qhvXHuz1HlhDRarSep/V+hEwXCAGl2h7o0ILOrYaQ6OX86qrCVtl8gU
	 4J2RcnhajMMmFJkdaPc0u1xf7dEF9YCrMkgxm4bBdu3TTnNWE017fn3R0xAUAvKYR3
	 ZP9udjMT7K8ZB/BMSmkXiN5vUJD+J8EZ8Zv337XEEV2CCK8yZgu/qF4uZ01dpUC2tV
	 5Bcm0s6QStKYDMiQMI2TfetgCL7HAWR9eCeA72dzrB10yoWNtpens39zb9kjGJqrT/
	 yheVhvxAAlG/g==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtAu-31FB;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v4 3/5] Bluetooth: btusb: fix wakeup source leak on probe failure
Date: Thu,  4 Jun 2026 08:37:38 +0200
Message-ID: <20260604063740.2595260-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604063740.2595260-1-johan@kernel.org>
References: <20260604063740.2595260-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d0a83a1ffdf2..3e8c90486e4c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2994,6 +2994,11 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	return 0;
 }
+#else
+static inline int marvell_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
@@ -3836,6 +3841,11 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
 	bt_dev_info(hdev, "OOB Wake-on-BT configured at IRQ %u", irq);
 	return 0;
 }
+#else
+static inline int btusb_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static void btusb_check_needs_reset_resume(struct usb_interface *intf)
@@ -4172,7 +4182,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->wakeup  = btusb_wakeup;
 	hdev->hci_drv = &btusb_hci_drv;
 
-#ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
 		goto out_free_dev;
@@ -4181,9 +4190,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
-#endif
+
 	if (id->driver_info & BTUSB_CW6622)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_STORED_LINK_KEY);
 
@@ -4427,6 +4436,9 @@ static int btusb_probe(struct usb_interface *intf,
 	}
 err_kill_tx_urbs:
 	usb_kill_anchored_urbs(&data->tx_anchor);
+err_disable_wakeup:
+	if (data->oob_wake_irq)
+		device_init_wakeup(&data->udev->dev, false);
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.53.0

