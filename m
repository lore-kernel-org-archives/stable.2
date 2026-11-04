Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810439;
	b=YUPZ9s+G+JfEEh8d9REoNSOuucAjzfCl6pEmcii/K3LnFWDOsbv2gvLVFQwAgX57JGXK
	 Bh+OhHkgKKTb7qM/d/0aBJgj6essyh8dMfyFQdxGmDkXCsB231bXoy+r91waB3iebX5xn
	 5TZ1IJJcnXzkOaAtx96D2Q/BBqM6EovWXMQpDg39vpiHOaYPhy8r3HnZMR+aROd0srs8A
	 5lwYr1GXONcLwDO/DfWweiW7bAUVYIK9gtxCQykwXKSiRLHww1ZHlFnfdR9gK+yvRRQKZ
	 ZZiiLo59H61Vpxuq4VLL9c7i5LeWSPNq3qQxz9pmJtwIV5NiTQjusJnMm0jLIOC+4iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810439;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID;
	bh=jhH1JhvZf62cYFTFXCoTDRK4dg1x0ip0prOKCSKui5Y=;
	b=GnVegrztCSnR5+41HFBBplbeAC5m6hBGUaZbJ2G9UkTn9wiOy1YCu2mX713zDR+XjF5/
	 ol+g8gyAeb47JhhAakW0Cfhya6gjdu9YEkWvm+HNE3Hs5q+N+92Gy5iAn9VU0HViA8X2T
	 T/gxBdidWWPeohARxKwWPGqdLw/jUlcM1k7bgsHwUhhB6M5xhDu1Br2cNta8izXnutsTE
	 qqzCykoXe4+P0as+xrPoDRRUccCgfwpR0Bukcg396EVPF9R+u3c1/8LTFqAHuSms/jqgV
	 mewBlt2tXrbQrh62zuWBnQFAvcar/YlmviyUD1I/c1kTWBqYDKO85RqcLu3zvUY/Jvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GOIucMt6;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFCF606A31B;
	Wed,  4 Nov 2026 16:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFCF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GOIucMt6
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKWQV66KHzMlHW;
	Wed, 04 Nov 2026 17:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793810434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jhH1JhvZf62cYFTFXCoTDRK4dg1x0ip0prOKCSKui5Y=;
	b=GOIucMt6mrIjYtwYtSDYo0btU84g6w2DC1L8ehWSTkXzKZhL7X2B4m+WBcgyDmnMw36Pjm
	zjqCK1OpWsUbirVfx+41qaf/aOD9VGSmYuEtdMSY/+JcgR58ohywmCD8i32ScCECUE1cIW
	rspzOmQBzxc9czchLI/j2OHXbFnRClx+zDuimNNEC1T18lbzpP+ABkMLMWvgNwL0EnGzJe
	xmM5v1xFLudpqL8weNfLbx6sWKn3X4oz0OeN29dIwuLLi5DcXiajFKgFT8RG8+VR9f49YX
	czF5QYG+C0XfMdcVe+BCX6ijYpX5d9FXuNYq+1WcfTtd4WZ0UzpeA6YYtxE1Ww==
From: Daniel Quolke <daniel.quolke@mailbox.org>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] USB: core: Add RESET_RESUME quirk for Keychron Ultra-Link 8K receiver
Date: Wed,  4 Nov 2026 17:40:18 +0100
Message-ID: <20261104164020.69235-1-daniel.quolke@mailbox.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 34wxurkbb6crsr8b4ke419f4t34n7h5o
X-MBO-RS-ID: 9d079c054e61ebde3e0

The Keychron Ultra-Link 8K wireless receiver (3434:d028, firmware 1.06)
disconnects from the bus on its own a few minutes after every system
resume. No error is logged before the disconnect; the mouse freezes
briefly while the receiver re-enumerates.

Resetting the device on resume instead of resuming it normally avoids
this. Booting with usbcore.quirks=3434:d028:b has kept it stable across
suspend/resume cycles.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Quolke <daniel.quolke@mailbox.org>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a4bcbe9c9..3878078cc 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -612,6 +612,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ezcap401 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x32ed, 0x0401), .driver_info = USB_QUIRK_NO_BOS },
 
+	/* Keychron Ultra-Link 8K receiver - disconnects after resume */
+	{ USB_DEVICE(0x3434, 0xd028), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* GameSir G7 SE */
 	{ USB_DEVICE(0x3537, 0x10a0), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
 
-- 
2.56.0

