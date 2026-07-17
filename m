Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53207282F29
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311896; cv=none; b=EiyhTM/W8RxqaOGXxtpn9kySa0iDjABeRSuaUPT8DATm7ONcG1r7qsf4OfnRg0KKj9i7XXpjFyl5GGnoSmrJOeV+XLwztPzPV99XwskvGOAozP5QKnGLoq5aNg4nDc/N/1cWxHI43vvrCz2MD9Z4/pIbkMHfeXgnwLxYkhB4Qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311896; c=relaxed/simple;
	bh=jD+0GesKCDgClUsHZwWUp1CPCX15kOm4g+SwQuQ6HxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmAE8jSXej3EIhg3psOH4WxeKGyOwBEWtxY7TS4JBNN8WutQf+P7vb7X15BfOowt+NrDhJgIDDuHiPlnNfxFcKItfPmOHVG4k1h5zXrg4MpcZjx6tcpwj4AHoYy2NJ/dMyoE7RLynHVZGWgg22FFufuleuQOH/aouC8fK+Lm0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGAOiYqA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGAOiYqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD11F000E9;
	Fri, 17 Jul 2026 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311895;
	bh=Rb148nkCpT3TVE7AIceKk9SFFm6I4cs1f+NIZI/SI0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGAOiYqALpkpiLcyQiHuEBcQVqxfHGDRX+Tke6ZWaLB3u5j9DQq9TT9NrytHmt+Yl
	 Wbg7gDrVlq+MPyLLZmnfEWNr7+7nzOZwpn8EsmMRfJ0DHfVl77JHJZGvUdp9GOFIHr
	 jyEIT7Yy+YpLYoYmQsIBkkP9vIHNswnx3nmzMN+HTEmpq1US+wb4AZpyRGIwtel1pW
	 KVO5ONJ59VhbaI7xFNXcMLWCzkSgZ6yrrvFiw4GjhcGETwryAVoFUf1c2Jozob3kyA
	 9fJ2sEBMfUb7fw6zNaVaWt0XWiEzXW7KLpxfoSjVEwO5sBzdHuawqqP1DTI1mFWHqA
	 +GO64RXle4aYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angela Czubak <aczubak@google.com>,
	Jonathan Denose <jdenose@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] HID: add haptics page defines
Date: Fri, 17 Jul 2026 14:11:32 -0400
Message-ID: <20260717181133.2086215-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071419-refined-abrasion-5918@gregkh>
References: <2026071419-refined-abrasion-5918@gregkh>
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
index aaae2fecd4ae6e..8a105caf6bcb2d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -152,6 +152,7 @@ struct hid_item {
 #define HID_UP_TELEPHONY	0x000b0000
 #define HID_UP_CONSUMER		0x000c0000
 #define HID_UP_DIGITIZER	0x000d0000
+#define HID_UP_HAPTIC		0x000e0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_HPVENDOR2        0xff010000
@@ -299,6 +300,28 @@ struct hid_item {
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
 #define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
 /*
  * HID report types --- Ouch! HID spec says 1 2 3!
@@ -384,6 +407,12 @@ struct hid_item {
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

