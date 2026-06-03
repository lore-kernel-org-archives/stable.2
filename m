Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689483A8FF6;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497450; cv=none; b=sw3Wbr8AAYCzlLO3TZ+JhCbdK/ySVwmdt3uFmQxgEVqsXEO4oHH64uJQlU2HLEljAHL9tJm2/oa8HV4djJ3PTV6N5hcatoU679cl6TqWWXYggpFO+eacSzO2BUt+Y12BHkqGxuBWD4xdqmC081vRNUFv5uQzeoZcvnyXinzFQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497450; c=relaxed/simple;
	bh=h3jJ/nP5pLr7CBwRObS7zzhELWONPHjzqZR0+am6cdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzoXcUxxE3s0IN9HHnFKD3W1VTix2xu1clUoyDzJBh2bU3PwmJKobvPjAdI9Ni56MsKpJbN6+JKESiTzJfqit02KL4nH0xmSBY7n7vN0JkTYhihw6KjiDZ5iXGZIaVnmoVEIbRZgr4dm2siPOB/TWMZT2qHROQS95oRFb9Mog0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPBQW5U6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPBQW5U6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EDF1F00899;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=YhkoW0rRlfHoFhzX5mfolI/l6SS5hCwW3qRrR7GxDsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bPBQW5U6C9YC9R1JF9ZIVIIBCvvGeuyNSpEDimbvlkrYB4+GPhYAPP7ZI9zzjFuHN
	 bhfcKKxtttKTYXnbSu0QkYS3stuyYFSywYdxZwmhTT4L/rihq0yUtjkE8NgSbSTsF0
	 /tgYG8E8hTsI6/FjOQckUJ4zbNi7Tmg2Snkxk9DFlO5oCqD6KhID2ligSsV/i+RJ7F
	 NeqeN2SODslxFFIahtfI58Tb+l9mNeR3wwAVijbps2Mylc4M0to1vZLRMt3lmAxr9x
	 08fPR0UH0gXREVtBRrjvbCqhXbQixhNgmkQMxLXmypHw+2QndEc5xeBgYnqMhsRqub
	 yeD8DMq0mSlqQ==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYB4-39Qt;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH v3 RESEND 3/5] Bluetooth: btusb: fix wakeup source leak on probe failure
Date: Wed,  3 Jun 2026 16:36:41 +0200
Message-ID: <20260603143643.2514595-4-johan@kernel.org>
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

Make sure to disable wakeup on probe failure to avoid leaking the wakeup
source.

Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
Cc: stable@vger.kernel.org	# 4.11
Cc: Rajat Jain <rajatja@google.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d0a83a1ffdf2..622df2fff497 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4181,7 +4181,7 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL && data->oob_wake_irq) {
 		err = marvell_config_oob_wake(hdev);
 		if (err)
-			goto out_free_dev;
+			goto err_disable_wakeup;
 	}
 #endif
 	if (id->driver_info & BTUSB_CW6622)
@@ -4427,6 +4427,9 @@ static int btusb_probe(struct usb_interface *intf,
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

