Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53D201025;
	Mon, 24 Aug 2026 03:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787541270; cv=none; b=eWpGu2bCN/ukLwzlhjazq9pxNarpSCh4GtRx1EedQmMqzkAwoXt5cu60phUJTWq6r6VsscBGccc7OoJIo+j3mc4jOSY3OJlwgLLortrSOpJoA1eAj6dj5bG988G/dSH++9hXg+Y4bCZAQ7rypDCTeA7zay9W3q4pHZH79NbbGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787541270; c=relaxed/simple;
	bh=Sc/jdSqO/i/4q1jM+6c4F9ERo3EyJ8CTu4K/UXataaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/XkWiADePKnyrOYRduN7Al1+k0RUbqE3bJgmXcX6HCd4VCdSTUuCkX/o10vOfgCzJ6IZyihSHyt/W0wAZmnQ9Al91+wB+cYMeAb+Xlqj72gTBi/VkMoSG89vI04dkGMHdCCa/vEv5dCboDplj0nO8RkUrAxD/qTU8nweM/X4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fu7pQ5hI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fu7pQ5hI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787541268; x=1819077268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sc/jdSqO/i/4q1jM+6c4F9ERo3EyJ8CTu4K/UXataaI=;
  b=fu7pQ5hIgmXwbkg+rxALYqf/eG162NOu7H9nuE4aMxX4gc4s8XM/wJPm
   ceU8tNiTfHKhIVnupau14lAroCGfTDbR1+UK9WH6ofhE4o2zQbQBVHRh0
   xHcJ4eoiYZNqN8WQKpTP/EZlu6EZBAjiAe2+7v3TZJ5NX3W0K04WMVGxY
   jP99im4qRruUYtCZkd8Iq1RPLPlgWbB3B8NUfx0+h7p8G1nTlvali0kXQ
   bk3nm2LAW0VpSnhnSoSN/JmjU9dM7by9Nmv4TOn+Cs3uHrWpqsP3D2Tgh
   gDmgzTzd22taB47zqaR4IqjqEjhGF0PPmq8Z6yMC4ejFFQFbPCKialbFH
   Q==;
X-CSE-ConnectionGUID: 9jkd+CP6SRibMDHfG3DI9w==
X-CSE-MsgGUID: zRMWIEFHRWyoq6noLblNzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="105362209"
X-IronPort-AV: E=Sophos;i="6.25,239,1779174000"; 
   d="scan'208";a="105362209"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 20:14:27 -0700
X-CSE-ConnectionGUID: OH47iMqCQLmm5XIrCt6JWg==
X-CSE-MsgGUID: 8HhQ3z9pSYCNHQ21vdhCfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,239,1779174000"; 
   d="scan'208";a="290401001"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 20:14:26 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Carvalho <marcocarvalho.web@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: quirks: add ALWAYS_POLL quirk for SDINNOVATION gaming keyboard
Date: Mon, 24 Aug 2026 11:14:19 +0800
Message-ID: <20260824031419.316315-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDINNOVATION gaming keyboard (USB ID 36ae:feab) stops reporting
input events after its RGB lighting mode is switched about twice.
Disabling USB autosuspend and unbinding the other HID interfaces make
no difference; the issue does not occur on Windows.

HID_QUIRK_ALWAYS_POLL alone resolves it, verified on 7.1.8 via
usbhid.quirks=0x36ae:0xfeab:0x400.

Reported-by: Marco Carvalho <marcocarvalho.web@gmail.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2514627
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 341bf587863b..10f3a69b82db 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1295,6 +1295,9 @@
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_UNIVERSAL_KBD	0xa006
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_MULTI_HOGP_KBD	0xa064
 
+#define USB_VENDOR_ID_SDINNOVATION		0x36ae
+#define USB_DEVICE_ID_SDINNOVATION_GAMING_KBD	0xfeab
+
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD2	0x0027
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 8a0b51d47040..c8c6b29fc04d 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -186,6 +186,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_PRO), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X65), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SDINNOVATION, USB_DEVICE_ID_SDINNOVATION_GAMING_KBD), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
-- 
2.43.0

