Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC530DEDC
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035616; cv=none; b=jcxfESZ1rwCHPevywYHTzVRUIoBVrGCF3/SR0KsOhrRsaGBuly9IrGCsxX6XhMGBpUrjsoBCz4r5PFKrmnzRUcebe/fxrS/sKUea4S2ZC8V/LjwnemlmSDAIgr1+Ezbukr/qZqA7Z3YgKf/yVlwLIJJmrAA6+Xq7UttNCUy616k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035616; c=relaxed/simple;
	bh=yPycsxrUsJpt3cifcLDogQufHZuMkAvU13dO9046lvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2U23/JVVclJskp+2SNmF66eckU1OWmfZ9sd97xFZTz3rm9z21sc/cT34qp8y9kGn7C05YX4Xe/aGMvXqwGnt//P8Gej3Nm+eg0Mf0k2Dqv+xsF2DordpWXteeOFA1S2BqGCLKe+5yJdRYUe6zhnlWVkxH5ylK6s4YMJEdViyqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4jWxZUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4jWxZUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63B31F000E9;
	Tue, 14 Jul 2026 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035615;
	bh=9AeC2l9rdi22wfrqdqIr4SRij2ysDEINrED4PD8fwUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4jWxZUKgMBxMHc3/R/lW9i6jOdT8Am230aBI/sH5Yu+FP4jF0YfChgw6k6SLGSr8
	 AxfsEy0bDUH9W1EpLkOpCgmKmZfw8i8/IOVypwNYZNPm1uGmDahXAbw45C/s+4p40q
	 T9j2fvoIkCT8dIFxpyOiG2HxjeUGsR0DGC4LBOfp7MD3tIFmMMOLdpW7472R1YzVyM
	 dkrHdl7ps5Gh6D55jt5iZFn4buESUmVVdbi8zo58CucNMg6d+UBtF4b4hdcT8sBR2O
	 5R6tVGkrsOdfgziP+gT1nJXMQQtxKbIqqA2ru/BHDidDuJJQf8sFtevMY8FIH8UvLh
	 am9dwKl3ie0lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] Bluetooth: btusb: fix use-after-free on marvell probe failure
Date: Tue, 14 Jul 2026 09:26:50 -0400
Message-ID: <20260714132650.2663656-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714132650.2663656-1-sashal@kernel.org>
References: <2026071309-contempt-purposely-3c5c@gregkh>
 <20260714132650.2663656-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c5b600a3c05b1a7a110d558df935a8fc8a471c79 ]

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 620dc80992b727..6d32e48418da78 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4352,7 +4352,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_set_interface(data->udev, 0, 0);
 		if (err < 0) {
 			BT_ERR("failed to set interface 0, alt 0 %d", err);
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 		}
 	}
 
@@ -4360,7 +4360,7 @@ static int btusb_probe(struct usb_interface *intf,
 		err = usb_driver_claim_interface(&btusb_driver,
 						 data->isoc, data);
 		if (err < 0)
-			goto out_free_dev;
+			goto err_kill_tx_urbs;
 	}
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
@@ -4391,6 +4391,8 @@ static int btusb_probe(struct usb_interface *intf,
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

