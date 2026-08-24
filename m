Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD23911DF;
	Mon, 24 Aug 2026 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549571; cv=none; b=NE6Fsdi3DSudC94RjBOB32KbygArdSOBHlLAGxhrBDxHiiVJMzHIwH3xBn95kalTz3hviTrcDPEdpoLgYIBRjkfDn/fFL882j2GDBTk66GmXVYo1ZFRmk0SlFfl7+wVP8pO5p8zUO1/6mfcj3bNoZYRtm8mVE0CGOjYd4cjrITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549571; c=relaxed/simple;
	bh=9/DXQtHwhTHLTnJ8cmF+7DiBZjnxH/ksRQYyyob9yqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTA2A4SXr3QMmMi+lpq1EYEtxy07px4OEosm0KHj3Vy/6OuFbs6jTZ2gg2tLeUCl+pckbnk7N4JcKAvvHvTa039vPxDSfgBcBPJlEcKpCtVVUqQYgWAR42PZ13JASygiicOTe155+8O/OB2vHGBvLQ5HtzjU7c5hYgNCkHCxtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XWL5AEGz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XWL5AEGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549561; x=1819085561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/DXQtHwhTHLTnJ8cmF+7DiBZjnxH/ksRQYyyob9yqU=;
  b=XWL5AEGze8hGQz/s8mEE91oYUBvB+vg5TlwdHaBZFfUNftMftU0pQfCl
   H9QMzxIeKFv35vGGwyffov0HaDegO3In8dp0YHRVKozSBtBF7xhTtNX+t
   F72d0KvQbwTTjEoHpmdxoTFOIU4UJzinT9LIleIqByue/2L4uZIIa+FOO
   qqIGbq5hOukbOvYVhDa9IL4glvHVNvDO+MPTK9vJLJnleR/AyNB/Pb3Of
   HbtvGncHKoYDPWmTiTdqwpetMuIGIGkj5EYlRgp7lxUUdbm64Zp8/j/EY
   5g9fqwCx7tDKeu2vo3XefnnxHA9IrBJVBRg8HV1TzKnNIzl40EFUmk71t
   A==;
X-CSE-ConnectionGUID: nkmp0jnhTFe+xh2D9jiW3w==
X-CSE-MsgGUID: CWEBQZgtROu3+DItGpOFQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91862769"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91862769"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:32:32 -0700
X-CSE-ConnectionGUID: Y1gLesBxS/S+Ol8fthurIQ==
X-CSE-MsgGUID: Wso0R4UxTjKD1UMOE6dH4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="271108216"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:32:30 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexej Sidorenko <alexej@sidorenko.cz>,
	regressions@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
Date: Mon, 24 Aug 2026 13:32:27 +0800
Message-ID: <20260824053227.317496-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B
device to cure repeated 0x2042 failures on an 0bda:a728 dongle. The
brokenness is per-dongle, not per-chip: on a TP-Link UB500 (2357:0604,
RTL8761BU, fw 0xdfc6d922) extended scan works, and the legacy scan
path the quirk forces is what is broken -- LE Set Scan Enable (0x200c)
times out with -110 about 30 s after firmware load, btusb resets the
device, and the adapter re-enumerates in an endless loop (382 firmware
reloads in one boot). 7.1.8, which predates the stable backport, runs
clean on this unit; 7.1.9 loops.

Move the quirk from btrtl's chip-wide switch to a btusb device-table
flag on the USB id the original fix was verified against. Other 8761B
dongles return to their earlier long-standing behaviour.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2521504
Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
#regzbot introduced: 5ead2063611a
#regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=2521504

 drivers/bluetooth/btrtl.c | 13 -------------
 drivers/bluetooth/btusb.c |  8 ++++++++
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f54d2d2d13a..03fa9409e3ee 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1343,19 +1343,6 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	if (!btrtl_dev->ic_info)
 		return;
 
-	switch (btrtl_dev->project_id) {
-	case CHIP_ID_8761B:
-		/* RTL8761B/BU reports HCI version 5.1 but does not support
-		 * the LE Extended Scan commands (Opcode 0x2042), causing
-		 * repeated -EBUSY failures when BlueZ attempts extended
-		 * scanning while a connection is active.
-		 */
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
-		break;
-	default:
-		break;
-	}
-
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8703B:
 		/* 8723CS reports two pages for local ext features,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2bae85b0016c..84614e60d142 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -67,6 +67,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
+#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -619,6 +620,10 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Realtek 8761BU Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
+						     BTUSB_BROKEN_EXT_SCAN },
+
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4403,6 +4408,9 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INVALID_LE_STATES)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
 
+	if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
+		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
+
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);
-- 
2.43.0

