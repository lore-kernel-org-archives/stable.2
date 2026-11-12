Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505846;
	b=cUZCGGTAoBccfKIbGHe9j2ACRcgkIi9t6n1IzwcPtOEPEnNTkRLKDGFWBd6nGNUjO7ti
	 w5mt5HlIhBns+yF+gfVqTrctL+UHT6BslqvxLCmtET9HWYiq5JoiI+tCLmgTWqKc4eMeB
	 Hrraq6SiJhoCdgchOVxDEXIwAFwgq9oczM10plDVwdSE71TLdF1zcgIn14b0+jDfOjPx3
	 mA6Oow9SwnjgksJ3tuEh7S05MDaF6j5KnLSJPnWW+Q/61DVnlzMy0KTeI62tERAr8Fe1R
	 OjiZnNkBFis2lGk3EgUovia4J+2vnO87cKlpoivdgYw1Pf8+wPbXLnwZhhom02rE8cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qUfgXo+3LOrVhE32daf+lEe1rPh9EMVXsgYxgsH6zcM=;
	b=cvRJ6i6Y8zjLJIuS0LUFvopfeO8vawXu7dW7RtXPZheQECRRddziXxlayyxJQkcBz9VK
	 jTv/pnquVRwbgGAn1w34VFhGb+ekqfj1pJD8ODsJzYJgH6JnyJjG9ib2SWslEPkuqv/EW
	 WpUfLLvDfFrmFQZeD37nCvqfaj7t8WG7PZzFTvPRIUic2qh/xV4dMSlbykM2tnEOjD63s
	 8XZOuBU2lRGTl6VpK86NpOz+BA3HIXvlH7ouYLepyxOHsMMTpRs1d0pKPi9ck7J2cx/Lu
	 n7nd963Pfi85j1EUf1xVDtj7VYJB5v5B8O9XqxPoQJw0ehKr91m/xAwXT98rV/lf8WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEjv66HE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EED606A327
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEjv66HE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675A11F000C4;
	Thu, 12 Nov 2026 17:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505846;
	bh=qUfgXo+3LOrVhE32daf+lEe1rPh9EMVXsgYxgsH6zcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEjv66HEjE3f9JAaC1VywO+eO0YyhGVw5qWl15e8aGVPbbgm3JxGX8uVhqUEaagde
	 xihjox98ZyRw3cJHxgAGbluRQlTbul28W3cT/Wx/Sb+RM/mof5WrEjLjZowXqjSnYY
	 FLV/wKJbViiG/2W2muJQB7alR8z9uT0AZ0fdzYYijTE2GscJJhRLDr31sN8GL+fSk2
	 gdA9cpDIqp1IrmfJ7t5Dktbwo3S2rPTlIhk2kkCS0ZEMANXYNUC87Bla3QhnSJ6Rir
	 LsWtxSPn0r3+6sY+8n72OXCgpM6l3Jx7i0MvDuxu2SBr3j/Heb/dgjOINrV+9k8sHV
	 kR9zyK5nqs/Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junjie Cao <junjie.cao@intel.com>,
	Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/3] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
Date: Thu, 12 Nov 2026 12:50:42 -0500
Message-ID: <20261112175017.3338563-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112175017.3338563-1-sashal@kernel.org>
References: <20261107050443-failed-7.3-df5e35f1663a@kernel.org>
 <20261112175017.3338563-1-sashal@kernel.org>
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

From: Junjie Cao <junjie.cao@intel.com>

[ Upstream commit df5e35f1663abc2702cf9f9e7eba024129ac5df1 ]

Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN on every RTL8761B, and
commit ca0583c24661 ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN
quirk to 0bda:a728") kept it on 0bda:a728 on the assumption that the
USB id separates dongles with broken extended scan from those with a
broken legacy scan path. It does not. An 0bda:a728 unit (RTL8761BUV,
fw 0xdfc6d922) on 6.18.51 fails the same way the UB500 and 0bda:8771
did: LE Set Scan Enable (0x200c) times out with -110 and btusb resets
the device. With the flag removed from the table entry, scanning works
on that unit.

Two dongles with the same USB id need opposite settings, so the device
table cannot key the quirk either. The costs are not symmetric. Without
the quirk, the unit it was written for gets -EBUSY on LE Set Extended
Scan Enable (0x2042) while a connection is up. With it, 0x200c times
out and btusb resets the device on three reported units, two of them in
a re-enumeration loop.

Remove the flag and the table entry. 0bda:a728 matches the generic
Realtek entry again and runs without the quirk, as before v7.2.

Reported-by: Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>
Closes: https://lore.kernel.org/all/CAE4bxw+ofDFVx0aTHqCrzns9oP1CRQDm_wzeyHPeMBYOhSpcuA@mail.gmail.com/
Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Fixes: ca0583c24661 ("Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ sashal: Adjusted context to account for the missing BTUSB_QUALCOMM definition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 2c85f221ed6b8..67b7271c9eb9d 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -68,7 +68,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
-#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/*
@@ -636,10 +635,6 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-	/* Realtek 8761BU Bluetooth devices */
-	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
-						     BTUSB_BROKEN_EXT_SCAN },
-
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4495,9 +4490,6 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INVALID_LE_STATES)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
 
-	if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
-
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
-- 
2.53.0

