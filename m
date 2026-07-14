Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9233C192
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035624; cv=none; b=PoeWwkH2R9K429ZA4iXXr/Xqm/a2UulIP0FlkWZ2kx2nvaVKldek2DHBq6oFZCBKKrWjAFVBWYgFSnPPKeM6dqgCNTNx2A7LSKYpzNhvrGOw6TNnNJTlHvJ/UsxYh+NN6i9l99SQrl0qd2szRvwfa9WpdvXK4SmaALePDVO+mFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035624; c=relaxed/simple;
	bh=JaD2l+rFXk8RZaM3dLQbr/1bPy3njcFpaK28H6PNT1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPEGbAUU6WuEX1U5qInUaYH79D2KuqK2qC1Rsq748gM+iHuXaVLqKTRJDzDzDRunnnP9qJttTKmri37zoJ5Ev6gs1M/Txv9z15cKjxrqv5Y4LoHjCYlhmvUkLvBJyFn0KlONDSapfKgbOQogrbz2XBg5/ifBxxvZAZM/S3HtY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj28ZcDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj28ZcDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85BD1F000E9;
	Tue, 14 Jul 2026 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035623;
	bh=zUYYVZ8PwrijQQu+C/fD5Axpz/29XABq9FM9/cGx2CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oj28ZcDt1ylHQmp4tpZARPMmPLvLujY3Zftj9T2uDu5b2EM2fPHfs+NgDXg3lSToc
	 3Je0muddyY5Hl0wjRz29LW03IWZK1XBbOcsVpOIT5BWJV/GojCgViOsoBYY9GikTEA
	 j29maQimbHQ+sK4FjbGyUcx89GXSvt34D0QUB5Gj74Kax4n231M6i4UHE9ayCiUhXx
	 +D+qo0CwegWTrLnNeMoOEaGovSUUWafWcfXRWts3CDyGIoYZ3KN0g0u9fb84MztFGl
	 zVPzOoliZC2IpSMn3g6OXEzowwL2WJRDXOgq9yEAAzs97Z9G2tAhhZQeZuOqjiPdYw
	 tbiIeY6nqzaZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] Bluetooth: btusb: fix wakeup source leak on probe failure
Date: Tue, 14 Jul 2026 09:26:57 -0400
Message-ID: <20260714132657.2663805-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714132657.2663805-1-sashal@kernel.org>
References: <2026071341-glamorous-shower-90f7@gregkh>
 <20260714132657.2663805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 3d93e1bb0fb881fe3ef961d1120556658e9cac4d ]

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6d32e48418da78..cb349276522e23 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3501,6 +3501,11 @@ static int marvell_config_oob_wake(struct hci_dev *hdev)
 
 	return 0;
 }
+#else
+static inline int marvell_config_oob_wake(struct hci_dev *hdev)
+{
+	return 0;
+}
 #endif
 
 static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
@@ -4011,6 +4016,11 @@ static int btusb_config_oob_wake(struct hci_dev *hdev)
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
@@ -4164,7 +4174,6 @@ static int btusb_probe(struct usb_interface *intf,
 	hdev->notify = btusb_notify;
 	hdev->prevent_wake = btusb_prevent_wake;
 
-#ifdef CONFIG_PM
 	err = btusb_config_oob_wake(hdev);
 	if (err)
 		goto out_free_dev;
@@ -4173,9 +4182,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
-#endif
+
 	if (id->driver_info & BTUSB_CW6622)
 		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
 
@@ -4393,6 +4402,9 @@ static int btusb_probe(struct usb_interface *intf,
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

