Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07A3385B6
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035623; cv=none; b=Ed4elM2/J/7ZX/qK7gazDC/XhxJFWwuFzsbwLm06GDRVSOuDQIUzOdN0rf+xLExht33FLUnQYqn1uxjm3k/UmNn2U9wJXGwHTeqYPrCxcrfHhaQW3QpVBKNrLPn2v7Zl4yHHZucXg9ZNv5t4fAzEqWSIT1olBNqmoFwMUMqnCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035623; c=relaxed/simple;
	bh=pr41+XhKfkDr0aJR2EiLAkqw4KahcpNLo2dSJCLeQCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJnNAq5U6OxYrJNLqXb6yFsb1+fyNU7chd4fnK+Nx2WBYRLLg4YK5LntieVA3pio6lU4lGaTH6s5np6WZrCR49ZShMLwvuvbTvpAaCzEdeOP6lDOcZEfHAWOrf9eyY1ms1BdPryOxCotnTSDEicwbq2D0nY/JffR7v0lgA7rofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6dqQxyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6dqQxyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE851F00A3E;
	Tue, 14 Jul 2026 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035621;
	bh=TkWqYKd0v2pNfCKLX08w7iyJ7Mi2bQiUJwaAvmxPzuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6dqQxyHPG5qjYjpY/W1vCAofJ17UbxKCXVAafRk8HOVTezDSCadZYxLMdp/sG4QU
	 w77k43SCYEjpni4vKeWfMfNcZGMqOenS0TNPD6Dv+Blz1DJlyhK6OsjrNvVqAOxxXK
	 EVW3LNf6D6SV+lM4rMiPIYoDLg+plxZuM7oUvK5JFoLLEZdABw4DJAKuktWm9OF8vZ
	 rGhzqRGHZhJSDQo2Te5NJZlAuzS+GZcIMTwt1ULsjHLROlWumm15GfJC/dDaLuvp2w
	 pdwzVSIsI/DMcb8naVUzKVBgHCoKSCVBQPc621Fm9RzZ3ACow1GgHJxBl3nAu3MUQW
	 XyRSw0fL5Psag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] Bluetooth: btusb: fix use-after-free on registration failure
Date: Tue, 14 Jul 2026 09:26:55 -0400
Message-ID: <20260714132657.2663805-3-sashal@kernel.org>
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
Stable-dep-of: 3d93e1bb0fb8 ("Bluetooth: btusb: fix wakeup source leak on probe failure")
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

