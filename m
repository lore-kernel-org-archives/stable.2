Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4103D1A9A;
	Thu,  4 Jun 2026 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555148; cv=none; b=PvDGgbnNlUIYx9/ADuVmf/HNKfK7l7cbSsBUCgcde4wqDejxWSMzsjdpOILAY68K3ANNRrFotO12/pWqjOECkWjnh8Rh99LVfPRbeCfQo3qoJHvoLRd2wf5wg3jJNsGmMtNZDV8OMdGti3TH/wzs0/jIckVF/OCXIzLYNsEzj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555148; c=relaxed/simple;
	bh=iWYLb+jVZMsFPoBRU/cZPtm+NLhB9eO6Z5NJ+oly4SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fc6wYv8mXpkFAw/eEE1mLySK1/7OKKp/GvKiYgUr7rDy1dB/ALK/5qVWsDToPs5Q9mp0s4rm5khMKqsmx6d6OKCKpaWDJzTrDUftZ0l90ZOFCsJgMvN8kYY+8wQVXqADihR+uLYbMYD0pAR40C/pRKTPAPd8D9jxecjzaL0nxsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URAVR1n0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URAVR1n0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ABE1F0089C;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555146;
	bh=TAekpMO3Kp6EnSvtFnl+boRFm6phDluCxfDXcPqRAVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=URAVR1n0jcv90Usm2ksd5MhI6S2u+eCAZPDGiHOlTZlleb6g9qZ2qc67MUNgY9EUb
	 K44ZZH3ML+BU99vv/RBNP0osdEiSaaL56ko8HLd9nLwRyj43Vvsji7wyTVyv7c+iWx
	 JOb16TPnMSfg8w8yl0P1qEVnoq2U+esPHOeK8wxU9nLlggkhntSaKpfDGvS0d9gWeo
	 86IV218W+K+4aZSyE3Z8xVq5gjxtJXXQpsc2YY10cM0Oe3NPIKtLOmVT73tmW89/ND
	 /L1gvMPDUJdwaOAWGeW7YZBQ6EUh9BoUrOcen2TOoitrOH9Jyey0csT6eRhQsJWM0l
	 7KR5mSN/hYAlQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtAn-2w8u;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4 1/5] Bluetooth: btusb: fix use-after-free on registration failure
Date: Thu,  4 Jun 2026 08:37:36 +0200
Message-ID: <20260604063740.2595260-2-johan@kernel.org>
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

