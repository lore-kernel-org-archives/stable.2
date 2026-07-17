Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D739281B
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298195; cv=none; b=SOoFlLYoqGsQhofZ/0ZSXeLvu8TGBwlVTBksDMgifJKaKxgIrgYpnV/cO+mD1jrNwGZhfOX+ZpWUwjQ4zhN56+ueowdNNGSJaDrANKRO3U4/I1WEx2jI5u3/PVF0CONsLpRkMIkYeUwv5BBB6nLUekAZugDuxLNlN74ajyZ3f6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298195; c=relaxed/simple;
	bh=bziCo3nheerqdJYtVz1QZRf4Akh6+8EoMp8Y1Krrho8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRC5sP8ltiggx62QQGC8yqJNXVT0A56/gfeDSr8qIonFFmVNl8bArVH+2s4sgEbDdORwRiWvZ6FX3xb/NW+qM1tBk0sT2Jk/ky5eEWJ09eQMOPdJFw1TyIJ9okCxbA/uRBKZVD/RCbEY+GR8Y2KSc6rUBY1IMcENST8laAnx9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjuuxHDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjuuxHDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D62B1F000E9;
	Fri, 17 Jul 2026 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298193;
	bh=5FPNIw+YduWB74n8gvud7fNVDKKAyMUA2Ss4PTChS1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjuuxHDlRDfIRhYfxqLZal0grbQnv8eYW6hlyAqkb3CzTBKYoUMUQw/LkybDSX678
	 C5Xp6gAmCvJvrxn8RnI5bywDti4TYUNdDswP9i4U761q8Kqud1DzwKhqFVlaG23mog
	 8HEhN3uhwvZGSk06SYlfq3oRHbmAXyp2xEMC/burri5L2723SdxefHxvjoyC8QMGJs
	 y3T1R/CcEr8ieMRcSO+TG9YR/BxWmzqRNKcNffd1fa3pvXfHXdwt7YBR4gcew1GQva
	 4Vr82I5mCcvb29MP4/xRl2Iy1wfRNA4EkXSHwwinnCtBtJftVMwLgVQEIrR9NDKjKA
	 ysVT2DZfcmjgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angela Czubak <aczubak@google.com>,
	Jonathan Denose <jdenose@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] HID: add haptics page defines
Date: Fri, 17 Jul 2026 10:23:09 -0400
Message-ID: <20260717142310.1824932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071418-scariness-mantis-da0b@gregkh>
References: <2026071418-scariness-mantis-da0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angela Czubak <aczubak@google.com>

[ Upstream commit 5e0ae59159e3a07391a35865bb79ff335473fa79 ]

Introduce haptic usages as defined in HID Usage Tables specification.
Add HID units for newton and gram.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Stable-dep-of: 8813b0612275 ("HID: multitouch: fix out-of-bounds bit access on mt_io_flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hid.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index c57fc6a918c030..54b794c26f6e58 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -153,6 +153,7 @@ struct hid_item {
 #define HID_UP_TELEPHONY	0x000b0000
 #define HID_UP_CONSUMER		0x000c0000
 #define HID_UP_DIGITIZER	0x000d0000
+#define HID_UP_HAPTIC		0x000e0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
 #define HID_UP_HPVENDOR         0xff7f0000
@@ -311,6 +312,28 @@ struct hid_item {
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
 #define HID_DG_LATENCYMODE	0x000d0060
 
+#define HID_HP_SIMPLECONTROLLER	0x000e0001
+#define HID_HP_WAVEFORMLIST	0x000e0010
+#define HID_HP_DURATIONLIST	0x000e0011
+#define HID_HP_AUTOTRIGGER	0x000e0020
+#define HID_HP_MANUALTRIGGER	0x000e0021
+#define HID_HP_AUTOTRIGGERASSOCIATEDCONTROL 0x000e0022
+#define HID_HP_INTENSITY	0x000e0023
+#define HID_HP_REPEATCOUNT	0x000e0024
+#define HID_HP_RETRIGGERPERIOD	0x000e0025
+#define HID_HP_WAVEFORMVENDORPAGE	0x000e0026
+#define HID_HP_WAVEFORMVENDORID	0x000e0027
+#define HID_HP_WAVEFORMCUTOFFTIME	0x000e0028
+#define HID_HP_WAVEFORMNONE	0x000e1001
+#define HID_HP_WAVEFORMSTOP	0x000e1002
+#define HID_HP_WAVEFORMCLICK	0x000e1003
+#define HID_HP_WAVEFORMBUZZCONTINUOUS	0x000e1004
+#define HID_HP_WAVEFORMRUMBLECONTINUOUS	0x000e1005
+#define HID_HP_WAVEFORMPRESS	0x000e1006
+#define HID_HP_WAVEFORMRELEASE	0x000e1007
+#define HID_HP_VENDORWAVEFORMMIN	0x000e2001
+#define HID_HP_VENDORWAVEFORMMAX	0x000e2fff
+
 #define HID_BAT_ABSOLUTESTATEOFCHARGE	0x00850065
 #define HID_BAT_CHARGING		0x00850044
 
@@ -391,6 +414,12 @@ struct hid_item {
 #define HID_REPORT_PROTOCOL	1
 #define HID_BOOT_PROTOCOL	0
 
+/*
+ * HID units
+ */
+#define HID_UNIT_GRAM		0x0101
+#define HID_UNIT_NEWTON		0xe111
+
 /*
  * This is the global environment of the parser. This information is
  * persistent for main-items. The global environment can be saved and
-- 
2.53.0

