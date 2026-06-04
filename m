Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E21A6831;
	Thu,  4 Jun 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555148; cv=none; b=HTvHlQtp3bUTJ5OARZYV4fnpjCBDBLrv+iOgVLLBARHCHY8ytsqvSmJGiPzJjxwT9m/FFEMT5YMrib8HBRRnhFjayvEBp8zt3qw2ZT4L6BY5M983Uq2/OJVzQfskw/fFnVFGWdDKK5oo3Xr5uJEEnGlZSpk+iaRkoe1Y1hofVfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555148; c=relaxed/simple;
	bh=zcn1dK/29EDlDuUjELmkDL4xNInnWxDqRDZS9QfhRPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlCSSdomCW+Eh7VVybby4FvXbEkR53mYiBu7b3x+fi1t8Ki+76znMY38qwOPIoerLcJl6kwS9ahvLaxkTleQjH968M0CjGAjdJvx+Qjz9Ij3Exq4cm7hFTfoduoVZlmAqE6cHlSwGmmRmG7tQ+dwbvbtFwTevTJRkaoOK8nRE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHgM9mfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHgM9mfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A151F00893;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555145;
	bh=fqO4LZkLQ5FT3GK1shuzVv/gvIRfqdWBmfuDHOglRjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHgM9mfhC6Xz9yniMgGtgal04HmSN8XioXwkSO0xVMd2QlEAUQrLS5yaiDDrLvfQv
	 eh0drYms6OxuJA0xfO/9CZdAIF5gan1Ys9rtH3UyKOZsiB3abNnl+FzBBUc/JbUXuT
	 iVz+EfVpMrGlvp07l07eF4FBBw2Mu1StdS55yzO2hcB2T/yeT/zGjzDnjWS9qv+E8U
	 g3zVh/7cLiJPE/M0SiesHuustXqI+doCYnVQ+UGM/i6jg6D2djALixBJNBJQHSVuaL
	 Q9sLMtrtVLEU78DTHGdfGofSAFWJBMjmdLyhMzjLDbVpyoJ5JI8UaZc+BCQEA6qYPE
	 Gy8Pm2eehWOrA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtAr-2yfU;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v4 2/5] Bluetooth: btusb: fix use-after-free on marvell probe failure
Date: Thu,  4 Jun 2026 08:37:37 +0200
Message-ID: <20260604063740.2595260-3-johan@kernel.org>
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

