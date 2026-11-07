Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048541;
	b=Sulv9wxQkvn1FyzPyBjoqadEhClQuMGGs2sKK6jPjDluiJxXyLm25k+8VxYbGHI4GaEn
	 6z4x/wVouzqBK3U5sCKOowWajhiM4J0fRMBXRYla/HEBKLwv6hpE2f9bS1YhflwqLFHpF
	 67VOx1Kdla577TRcN5hmNhIHVz81YuZvSLnvE3pGFpEFlbcYK5yUsSrSjGzg+xs++iI7b
	 jme8q1kc/XRsjBm4X8rfUm6Ce9MY13lTu3BDH+YE7JsQCgD1ZWvQInuvU+sHy4vpxlUja
	 Hgj9yfBsoZjdXxXBf+x2LkSsjtHKCGsIH1uFoE3LDld+S+XBd1XdLoB28UMZC71U+pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048541;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vVDfexxDZXHd51WOaOF9V2WHTvtRaYuvpzMjrOEy3W4=;
	b=SL08iyJSxqiTmX84koBvZMuZf6apSgCvcObvdvJ8gcRsgohg3SmQ5SmlUptfNiZggYLd
	 3ll899IzsSRPMUu7E3mBWT0+yXtZL+g/O1Q//TrmB/VJU+CphqpsJLGpfwhgsnNLTAt3K
	 AeA8LkkSG5rN4hEJrFaMazPX3kwziIb2wMjbRV5SrXhejhMo1d1zifAk7+QDlDmM5vGEI
	 nRhDqpzyXRLqktcEmMG+ANuQU8OhydZZbb9UDQWp09pPfHgCxx+VNOxNA2Y0brgqzHkZR
	 OvEhKupEnGzNnw7dM7zdZ4Hb7w/RDoDtpJsI/Fafy7ZE/b0FeK0DVYMkA4vHGsAxyAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kerSkEGi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kerSkEGi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737261F0089F;
	Sat,  7 Nov 2026 10:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048540;
	bh=vVDfexxDZXHd51WOaOF9V2WHTvtRaYuvpzMjrOEy3W4=;
	h=From:To:Cc:Subject:Date;
	b=kerSkEGimwXWjnBIh2GO2cmS5WmG52iy/igLbcECfFZr6raOKVe4XBc5+J5G+Jbmc
	 49bwurF5LadvcX+QdOmkTLmpsqs9+3vHg4BOSeos4A5kHA4E4QjMUX0cqvDGUhgU+Y
	 ZPPpvsxVsvhEcuTeMHxPr6rBdL5/jU7vkbmJpDb/0v2DLavuB+MiVYOFbvs6oj6IyX
	 iJQrrbbKiJ8mSLir3xnS9O3QzLHNfuBC66R6fxlAAsrBS8uKPGIvDuzlOKBq0D+tSI
	 WD5acxnfZ5WUJ75W8FWosMfixzrWQp4fYz9fieRD4QoQeudh0NfbY31D+p3BngT37V
	 ybxh2qEbc7qCQ==
From: Sasha Levin <sashal@kernel.org>
To: nbn@sj.dk,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE (StarTech AV53C1)" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:59 -0500
Message-ID: <20261107054859-failed-6.1-1430308fc9d4@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1430308fc9d47a801a305700cd444b1a0051d14a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054859-failed-6.1-1430308fc9d4@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1430308fc9d47a801a305700cd444b1a0051d14a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nikolaj=20Klitlund=20B=C3=B8rty?= <nbn@sj.dk>
Date: Sat, 5 Sep 2026 14:05:12 +0200
Subject: [PATCH] Bluetooth: btusb: Add device ID for Realtek RTL8761BUE
 (StarTech AV53C1)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the USB ID 0x14b0:0x047a for the StarTech AV53C1-USB-BLUETOOTH
adapter, a Realtek RTL8761BUE based Bluetooth 5.3 dongle.

Without this entry btusb treats the device as a generic Bluetooth
adapter and never loads the Realtek firmware, leaving the controller on
its ROM firmware. In that state it advertises and scans actively, but
never reports advertisements during passive scanning. LE connections
initiated by the kernel wait for a passive-scan report before issuing
LE Create Connection, so connecting and pairing from BlueZ time out
without any error from the controller.

The same product is also sold with the ID 0x2c0a:0x8761, which is
already supported.

lsusb -v output for the device:

Bus 001 Device 010: ID 14b0:047a StarTech.com Ltd. Bluetooth Radio
Device Descriptor:
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  idVendor           0x14b0 StarTech.com Ltd.
  idProduct          0x047a
  bcdDevice            2.00
  iManufacturer           1 Realtek
  iProduct                2 Bluetooth Radio
  iSerial                 3 00E04C239987
  bNumInterfaces          2
    Interface Descriptor:
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth

Cc: stable@vger.kernel.org
Signed-off-by: Nikolaj Klitlund Børty <nbn@sj.dk>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2c69a81c96317..a7488f6e8d8ad 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -884,6 +884,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x37ad, 0x0600), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x14b0, 0x047a), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Additional Realtek 8761CU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info = BTUSB_REALTEK |
-- 
2.53.0




