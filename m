Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBF2BEC23
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035615; cv=none; b=IyG34kaW0WE9VX3ZFpLP0+0hvt+VZs4jLXzjSinNl5INFR13ZCEXQdkMaeXDtwYa3VXzuHCtEMUrt28Uzi5wsYtIgn1yHZhTlXC+hNf8Ppc+W+D6L9xLwQ6tI3ynvM3QMjfFuSXih72wwFOhQa3QuDpt5X4092+sqRN6xWU0AYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035615; c=relaxed/simple;
	bh=PdiQavlmqwGUfra83cfuOhDVTyEkJYfELEI8fmdafTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8dj1+salZuz3jIbTYDGHsXgDV1ej4HXbwKM/69Hm1g1YlHpK3qJJ1H36Wr10FpQ7zewPU1kX3L0GX7E+HL8lum5zB5T1w6cTJPR4hNYdfv9D/KU2IFV1tBaWB3WGQb6RFEUghV41KXCvhIl0GcIxdjQXIJhD6Nud4ZSa1wgTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyF0GQXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyF0GQXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E51F00A3F;
	Tue, 14 Jul 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035614;
	bh=NcWl39nyMnYwGn5Bb5yiWqMKcPHuLw/Wn51vhwyaB4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hyF0GQXpsYHozgUxfHCqCt8K6nWybFsbF1BdqoXaoHkogiMN123GMfZv1cK30uSVQ
	 RIOghIF+ynTAuSNPsvrARSfVHJpE2ewfUIeroJTqBhpkSbzRcIValZmguYuAaWhOqB
	 noxasgAObmWy+k77n7i9qwvs+TeqYS7cNp6ZkedSPQcAIcU3mOenLVlaAO/3QOrScx
	 x9Jdd0RL5mjdyQQRczmb4oK4WeSWOZVOqy/54d8nht/cNbARtxn1BL80fFBgkuFkZj
	 yX7dOTRLYZdmhw0fOVNz17RJFupEO0xLQ9Tw+R9YehCvcR+Y86oOwNzCjPOzVAPdkV
	 kcYWpj59JJbDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] Bluetooth: btusb: fix use-after-free on registration failure
Date: Tue, 14 Jul 2026 09:26:49 -0400
Message-ID: <20260714132650.2663656-3-sashal@kernel.org>
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

[ Upstream commit eedc6867ebad73edbfaf9a0a65fbef7115cc4753 ]

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: c5b600a3c05b ("Bluetooth: btusb: fix use-after-free on marvell probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5b5ede26acea83..620dc80992b727 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4376,12 +4376,21 @@ static int btusb_probe(struct usb_interface *intf,
 
 	err = hci_register_dev(hdev);
 	if (err < 0)
-		goto out_free_dev;
+		goto err_release_siblings;
 
 	usb_set_intfdata(intf, data);
 
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

