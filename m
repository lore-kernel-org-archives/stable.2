Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADB3A9DB3;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497451; cv=none; b=H3s7Z97Z6MwQWKBs3SgHfQamCIj7m5pR/uWQ+EZUzvyfJgU8gyCqpP23dK2lzUgNS9BoAlBdG7NQP5GbXubts+QXbxuTysxgQ1hsS+ZDMmzSoYNxcYOg30d93zjNXL6JcfU6uZsnYxoiDl5vj26yedn18EQljLQPWemiHnNfm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497451; c=relaxed/simple;
	bh=iWYLb+jVZMsFPoBRU/cZPtm+NLhB9eO6Z5NJ+oly4SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=depJ0+67jZASIYTg+f6Vg9qIPkoZZJfhxGK2tI90Qtja7pGk5GsdgGbJMox24R/5XccrDBZmYxvmftPQiA0JyIADYCnJwMwFe6AVLODNuHLE6AoTLoyTuHPP1dndslVT4KITBfMPdHVSJoahP5rTzCywqgfihwXP60Q5n0W8JW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH/8hFFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH/8hFFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBEA1F0089B;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=TAekpMO3Kp6EnSvtFnl+boRFm6phDluCxfDXcPqRAVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HH/8hFFF40ciaFYxmGLXpK10JT/7y45i0d8Qp2Fso/xu0BJ4XCVscs8RjMdqmkiDS
	 mk6o30llgyEe/iv91pg7sx3bmsOYTv0gBKEAsYeiO5yOxJYvmjMmwOj/zPn30sw3BB
	 bAw9CVaN22C6kiPd3ptacN1/5D9GOI9XI0q1gzftHeduJ5FYQD3ACOwEeQE0lypjwh
	 QR1TaOlRXI4h0LARVnC6KVs/5h3KuKIkFmnmXvp6f4LE87RhvHK8JWRS+/1F2/jY/h
	 5IHRyGitOogddW/toS1uVM5LImd98hdYPP55FSAjS0rVVqvboivS/AKIShJbojOCZj
	 Rg6i1fxlPrJnQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYAy-34eq;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 RESEND 1/5] Bluetooth: btusb: fix use-after-free on registration failure
Date: Wed,  3 Jun 2026 16:36:39 +0200
Message-ID: <20260603143643.2514595-2-johan@kernel.org>
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

Make sure to release the sibling interfaces in case controller
registration fails to avoid use-after-free and double-free when they are
eventually disconnected.

This issue was reported by Sashiko while reviewing a fix for a wakeup
source leak in the btusb probe errors paths.

Link: https://sashiko.dev/#/patchset/20260402092704.2346710-1-johan%40kernel.org
Fixes: 9bfa35fe422c ("[Bluetooth] Add SCO support to btusb driver")
Fixes: 9d08f50401ac ("Bluetooth: btusb: Add support for Broadcom LM_DIAG interface")
Cc: stable@vger.kernel.org	# 2.6.27
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 830fefb342c6..c8015cee240f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4407,7 +4407,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto err_release_siblings;
 
 	usb_set_intfdata(intf, data);
 
@@ -4416,6 +4416,15 @@ static int btusb_probe(struct usb_interface *intf,
 
 	return 0;
 
+err_release_siblings:
+	if (data->diag) {
+		usb_set_intfdata(data->diag, NULL);
+		usb_driver_release_interface(&btusb_driver, data->diag);
+	}
+	if (data->isoc) {
+		usb_set_intfdata(data->isoc, NULL);
+		usb_driver_release_interface(&btusb_driver, data->isoc);
+	}
 out_free_dev:
 	if (data->reset_gpio)
 		gpiod_put(data->reset_gpio);
-- 
2.53.0

