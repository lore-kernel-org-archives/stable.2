Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90241A92F
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296824; cv=none; b=UBiT4vVrBDhAa+8I1+MSUlEXtoLawIldXvEWhtRJB+hVqz4X25ci/dU6BRUr3/cSyk+wzrybTrqSlqmEf+lPMS3jGKqMWfyT9NwJFisqntIKeu5Ow8pxt3cNqh6K0Nx63vN8ZIRz+J5TsCgb2vWM8V+aUkmntNBhYBHfu2m50lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296824; c=relaxed/simple;
	bh=bBAAnGP8iKlnC6UhMMq8nE5EECV3N1s1tsqgT/69dD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4obfhCWjTQ+jPAqXhUjojds6QH7uHmKVfX5+70FC5B4J19IpMaZs8E8oBbQT/5EHJmivus1wdk1qOCoWa8XrDkyZtfMN13WxGc9PFpfJaDFipFqQwc2AnFPZCp1EzglC3RommWU1LsddozG/7Vaslw5QN9ptXZTKzzDbhZocjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWetECL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWetECL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC601F000E9;
	Fri, 17 Jul 2026 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296823;
	bh=7moq/zUiNNcNUWhnxftVS9pgY2PZUkLf0W8rrK+93Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nWetECL5Qmxs/QHmkk6zbHj2RVTppHfJXKP/g654uL8EQTWz4HuNhM11fDFNlSBIf
	 beLbxGdvLTc9/FO5642GtwSNwx2PRkwXT3BUepS7QOHCMh1NceeC4wTs8p3S4gg3Rf
	 DbA06j4ge1gB1hd/aj5LukieeLy3GocN0sieVEsfEAeTzUK/Y328I/3lA22Lsm8+VU
	 CZghA9gzMpWPfsdDWTz32T8Ia6faDXzH1eVmyl9jrhGE+7UiA1he5sfFX6GlYEyg6d
	 zMbj3zdyUbdmRKkn4edsXH8a/HpgqrLQ3ha8QubQniVTtkN+ynKMhn2uU4IEbcJDFR
	 AfEzxwogw3KEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angela Czubak <aczubak@google.com>,
	Jonathan Denose <jdenose@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: add haptics page defines
Date: Fri, 17 Jul 2026 10:00:20 -0400
Message-ID: <20260717140021.1717288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071417-rarity-paralyze-9329@gregkh>
References: <2026071417-rarity-paralyze-9329@gregkh>
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
index 7d05b1edacd80c..e2734b9d3ee056 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -154,6 +154,7 @@ struct hid_item {
 #define HID_UP_TELEPHONY	0x000b0000
 #define HID_UP_CONSUMER		0x000c0000
 #define HID_UP_DIGITIZER	0x000d0000
+#define HID_UP_HAPTIC		0x000e0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
 #define HID_UP_CAMERA		0x00900000
@@ -314,6 +315,28 @@ struct hid_item {
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
 
@@ -419,6 +442,12 @@ struct hid_item {
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

