Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC617429CFB
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298890; cv=none; b=TjISnhlMuGrX6i1/smevJTOkBg0jNmZpx7YmRjjS4pjxuOBgK4aLPiAciKAV/2VoOD3wlBU79+M2MMVfYKxH/NWaqvocB+x0LT+1xKE0k9/fW/Ig8+2PY/pOSdPVVm4Knqr3//rpXL50NgsrM6zFSyxy+7XDFuqcMB+/G56SRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298890; c=relaxed/simple;
	bh=broZ1KOwi48qL1a+alKu/Cgv3Z8qnT6cPmOTTfk52ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7ran9Mks7Ia17yR7EGYWRd3/NxYAHA106tP4ulB2uT64erorACly1nS9KJ9Lr+XxnPdFmnTMYuBZMHjRyyjlVHwr4D+R3BLcmdm2wnwfbV2gUA+9bNx1xaEQ3ygylydUretCNT4LXh2Xbw6HarTDrrLdJmyXPlBNNhFGA9sLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZhxMYVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZhxMYVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90421F000E9;
	Fri, 17 Jul 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298889;
	bh=T8WuHnRPWv8EY1Auq9euWMrNocXiu4p1vVVP1RCguZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZhxMYVyiKEJRJGIzGzXjagIJo6/jIPhKYOG0+cb0uoyafcYBrY+9exajUaYNMyi8
	 8M9yv3Ky1kSQ+bHSraxuEwoUmULqBLXn4xf2+LK3DNHTOqhDfCNMWiC/Haf5Pj7TiW
	 XCTPsyE0135pPW+ump3WjZoh9oNRafw2TnfOWpYOhzpa6atD1+eI8u3ItzwihYHXIo
	 0sfLBQizHzuZ4M9wN8WQf6662+RkjU2IosdVbuQB6dq77ZcqzEFaxupi7vI/0yy//q
	 l0gCHfcl7lrRm2rdduG+a/N+RApiEzDxPHQR84Bb1qM9qbclBcptzlMTXl2l+DvP0v
	 Zt81h7ki1FFoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angela Czubak <aczubak@google.com>,
	Jonathan Denose <jdenose@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] HID: add haptics page defines
Date: Fri, 17 Jul 2026 10:34:46 -0400
Message-ID: <20260717143447.1877787-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071419-skinny-privatize-967b@gregkh>
References: <2026071419-skinny-privatize-967b@gregkh>
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
index c92c5e2ae24f3b..a321d4c293a94d 100644
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
@@ -301,6 +302,28 @@ struct hid_item {
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
 
 #define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
@@ -388,6 +411,12 @@ struct hid_item {
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

