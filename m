Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506422;
	b=pjj2w053VV+Z9J+hErEeF4sc2/oFK1ue6LKqeGA3ndJShA/GW1JZfEtKknnw2jtfoWwk
	 tLVd0Ttn1ECZm9KY91M/YG0wfKQ4Ls1ZiB/maNgUDP4rfOYfDob2/rWjgGtQ2IQRFpKNn
	 YTMIGKHuLdmpg4hZpcLFMWEaWJDkSOGcZpz52QVh9AoB4a1A8XfpSnObd1Rh+bQZ1RVvu
	 hfDzvHA7+SN3hUTmz6fqYGimIdXqXWCg6uko47LDSxgCYuM08oVTHLQGh6AvEyiDqz9dC
	 tAq5EvUtl+pc10ZRu6UEtvQYpI9zVRrg1DV7w2c/4njhpuqpOES14KcxabOaAqx+mUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506422;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4eroQGgz+m2euzG/A/3E8xgmB0anAkIrTfAseLL/Kuw=;
	b=2jse31ubZtYu+3+4Wkyd4HIXJ07MKDG7+0nraQL93kgnk4BCxpmWt4VcZNxg+qXllkSF
	 r1RwLY8gnfjKTEyGE+u7j0CxBqcY2VjZF6BuNMjoRyIZbrbyJuccrKR17ZnAXPCEttgOb
	 QUCt8K848EzlbD7tc3x661fpvB0jEdtKHlk6dXCluIitQ5MZ/SXtm+h+AGsTxiaIgao+C
	 uy6CnymDQXshC/aWl4frB/cMlzQGS5iJy85PsLcVNsladu054j++ECjZ3Lw9KVj0NFvDu
	 wmpKPtOI04HcRMDxSrAdqtodQllxu6eVjGlLYhHx618l3In+fTHfWCF6K1DWlZpFl7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVcRuJYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE79606A332
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVcRuJYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ABA1F000C4;
	Thu, 12 Nov 2026 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794506421;
	bh=4eroQGgz+m2euzG/A/3E8xgmB0anAkIrTfAseLL/Kuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVcRuJYX5qfwpJ3R4nstfW4llh97xGY+7N7AZxEkj1uYlM7kWsgbEQy+7yMhcm4g+
	 fdlm4Hh2DIHywldGG+xeECceIdqgtMGjekhzEzzdHb+ab0Xs8NBAUHVjlk3W5Q5Tn8
	 pqGMpYW9KhumSilHHtGhYOINrTpntg33Tt6akRi+Gcsd0btzbriD3Dl2wqWaQDBAQ1
	 PhyBYoEPw9OnG00M8QUkeyCuEt5hcUVAkD0/0sDgEJE2Dh1b9ixJm8K7GLXvPGTVQt
	 V4+l/u7ZNdRBEwBQCNpz+hruLhQtiEA8+Z4NGZmXwTEbyHCw9V7Wzgo9rnd3ilc8yG
	 50bzim6wWGtuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junjie Cao <junjie.cao@intel.com>,
	Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
Date: Thu, 12 Nov 2026 13:00:19 -0500
Message-ID: <20261112180004.3452475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051132-failed-6.18-df5e35f1663a@kernel.org>
References: <20261107051132-failed-6.18-df5e35f1663a@kernel.org>
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
[ sashal: Adapted the patch to the Bluetooth USB driver's original source filename. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b6773ef24c438..6143414711c5d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -67,7 +67,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
-#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/*
@@ -633,10 +632,6 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-	/* Realtek 8761BU Bluetooth devices */
-	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
-						     BTUSB_BROKEN_EXT_SCAN },
-
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4356,9 +4351,6 @@ static int btusb_probe(struct usb_interface *intf,
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

