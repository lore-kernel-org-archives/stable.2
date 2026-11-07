Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045885;
	b=P9os/LtyGDLj8qyYEZXNxL7FM9eDGVrSpeokGiV44yM7grP1OrTRaUfkJ+A+SWxz8L9D
	 UYRG3uTOKZWXG7TnNXljXC8OPuvLTjgfoOX/asChJkcgSq2SDjPvZEb4IZxyUgQYLgqzH
	 RQUphh46jMxgtKCGVgFWADUtQ2/BtU2Tfz1YzJrm8+sG5byWKCkaxJSJpuFIS//r8GYbm
	 4tnJRHgCF4oi0MRcRHZVZj6YT777C8uCmbXjjJIGhaNukbhkuW2NhhvqhdV617Tkzdtsr
	 T8AxjKOSL/uzof6wee9i4rU/oWl65pj23lZn7D55M4+pHoWXEE51qaXUbU2emTp0DrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045885;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qMqAGM6q3ako4mk/ewW8M/s4et4zyRj9hx45kg6p9GQ=;
	b=MEzyqcg5wLfliW1GpaJf4xYzQhNzdXaWd6uqB7YzRtF8YVt+r0LlZUpPb6YxORs+Wppc
	 rafmMobnnxHs4jXusxnin+ksjgPgri4/XGNMcZzXAEl0a7WxnOzitMK6Ukrq3CiBJbn9q
	 sFj0a4kaXHgZeQko0omW00PpBCjvwLK3P7lodCjpuB5tAR9OvnmrLhbt6UemZK6ZfNQ/U
	 P+2hEXh9KwUbs7WFyFMkm707x8RaMKis1JBPmlXaHNiEE7D01mDxcV4KX2uxwYROFGvOR
	 3YYNeXq29WFueny/5ST5HH5zn8HY3dsFaxVHKgvyQiZiXTNE/JshY7JsawnI4bV7uqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5j5j6iK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE289606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5j5j6iK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54ABE1F0089F;
	Sat,  7 Nov 2026 10:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045884;
	bh=qMqAGM6q3ako4mk/ewW8M/s4et4zyRj9hx45kg6p9GQ=;
	h=From:To:Cc:Subject:Date;
	b=l5j5j6iKp7a8A2fvdQmzJJNuWZLvoENLjzJ05fKOMg5WoaCz4HQPaNuDhQPcbNf8h
	 RmSAkhni+XKpHydDHf5grJEWGo4at52JNNzZfQKMqXgmq6YVC2v6wpPkRn2mg8XwOp
	 Cf877irJg2T83TEo1APWK9JioGAKsx4A1+5yfts/CmYjsCg4WxomnQMYNwX78M1Zf2
	 CpXZohyDgeQGoy2CeREwvVlmf22pOwXCM2bkfcoMl7qoxEo5m4xE0hOWRf5MeRbjBW
	 IqVzH9PKhgbxl0v2mfxHbqO+5q1uk4QpOUmELC/pIcSmFAPWOzveCdofQeVnfRrx41
	 wxlkefzjGUKmA==
From: Sasha Levin <sashal@kernel.org>
To: junjie.cao@intel.com,
	andrew.tsvetinskiy@gmail.com,
	luiz.von.dentz@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:43 -0500
Message-ID: <20261107050443-failed-7.3-df5e35f1663a@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x df5e35f1663abc2702cf9f9e7eba024129ac5df1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050443-failed-7.3-df5e35f1663a@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From df5e35f1663abc2702cf9f9e7eba024129ac5df1 Mon Sep 17 00:00:00 2001
From: Junjie Cao <junjie.cao@intel.com>
Date: Sun, 20 Sep 2026 10:02:27 +0800
Subject: [PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728

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
---
 drivers/bluetooth/btusb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index cccdfb0461fee..3518f92ebbd3d 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -70,7 +70,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
-#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 #define BTUSB_QUALCOMM			BIT(30)
 
 static const struct usb_device_id btusb_table[] = {
@@ -650,10 +649,6 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-	/* Realtek 8761BU Bluetooth devices */
-	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
-						     BTUSB_BROKEN_EXT_SCAN },
-
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4754,9 +4749,6 @@ static int btusb_probe(struct usb_interface *intf,
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




