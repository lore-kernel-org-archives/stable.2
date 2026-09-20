Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD836282F34;
	Sun, 20 Sep 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789869759; cv=none; b=AcNxL1QM+bQSnncy8ncUphgjb+CUOJ9oaWXIgan+7yJkrJb5FHVpSOlM05JcbS5Ld1pcrbkScQl4ZwQqd1Hb0HTS2OiWYf6atZQqb0hBlqAPIUq+UWW3eyXRWMvWpeKVq6DLFJSexw0hmlv8Sd4qPSfP27ywbC8iz4Jq50kNsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789869759; c=relaxed/simple;
	bh=K1MtACSQtXprS7sAMZfuF/mgu8+OafBDwPZ8SzYQAbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmLIqYfZ19qAa+A04R2dqRm71t6LLuEdAkyDzkN3zAKj79kqTwdlRb02OQZ1MIkXIJuU9fli5K+ozU8B6nvK1R1Mx/ULPrtQc6jb6gZVxlifVo6LKKp87gmkdftaJSKDsSklhGVhj/sal6d0U3ZdtgGLlSbB3jVqq8sQbnqWWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1vR1Ge/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1vR1Ge/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789869758; x=1821405758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K1MtACSQtXprS7sAMZfuF/mgu8+OafBDwPZ8SzYQAbs=;
  b=Q1vR1Ge/Ozpkz1AVF4P2PBHi+OpiM8gdTxnUvSbxiWcORXkAejazosXb
   m8TnEov8TIddFiwwoRYjJhsl9A3F0xBoh3pXgV3hZaf/RITCO3mDq5xCM
   cVAQYW2psFBb7KsFjcsUWho2JUdp87MXZnRzdVV0XTcHdJHb5YdVDcXPA
   zekcsamlaQfkT1fPi7ikJXrVDapEQjo6LrkeI/6Ny5InhOFLWjqW3cQZe
   lnwmnzM6fv8GI76e3q+c8RGY8IO5E53zl7kC3C3cFdTos9tEGlYYt9mMQ
   JDElC4e48T14m6wYPD1CB6RnlWue7Vjn4n1dkD9fN5KSTCAwn7egGjBxD
   A==;
X-CSE-ConnectionGUID: f68PcDc4QSSgEThcD+6V1w==
X-CSE-MsgGUID: zsUlJmpMTXWM6u+DJmKQBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="94207550"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="94207550"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:02:37 -0700
X-CSE-ConnectionGUID: hWL6eNUoSoWDx6Wx9MqIvA==
X-CSE-MsgGUID: etYkF2Y3THWTnOr5fpensA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="271262872"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:02:34 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: Andy Tsvetinskiy <andrew.tsvetinskiy@gmail.com>,
	Kamil Serwus <kserwus@gmail.com>,
	Alexej Sidorenko <alexej@sidorenko.cz>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: drop BROKEN_EXT_SCAN quirk for 0bda:a728
Date: Sun, 20 Sep 2026 10:02:27 +0800
Message-ID: <20260920020227.709800-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Based on bluetooth-next. bluetooth.git and stable still have btusb.c,
where the first hunk has different context (no BTUSB_QUALCOMM line);
a btusb.c version is available if wanted for 7.3.

Build-tested only (allmodconfig, W=1). Andy tested dropping the flag
with the a728 entry kept; this also drops the entry, so the device
falls to the generic 0bda entry. Andy, could you test this version?

 drivers/bluetooth/btusb_main.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index be47ac894b6cc..f410f130aaad3 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -70,7 +70,6 @@ static struct usb_driver btusb_driver;
 #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
-#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
 #define BTUSB_QUALCOMM			BIT(30)
 
 static const struct usb_device_id btusb_table[] = {
@@ -648,10 +647,6 @@ static const struct usb_device_id quirks_table[] = {
 	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
-	/* Realtek 8761BU Bluetooth devices */
-	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
-						     BTUSB_BROKEN_EXT_SCAN },
-
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
@@ -4749,9 +4744,6 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_INVALID_LE_STATES)
 		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
 
-	if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
-		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
-
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);

base-commit: 019debf20bfd648b40ba10377ee0168db5eb241e
-- 
2.43.0

