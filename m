Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732912BDC13
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297585; cv=none; b=j6AW0nG6r+MvdY4P40lySJcghcAMCi48Kp8G4x8aiHC3GbltYtkz1tztZTHZR2k9dLrBaY0kIG4oHM0kV+bYbWwzSzMQBpB3T7sD9yIbQw6pZEz9tb8b+a5bnlSudDlq9uMQkdm+jzKkTHmZGlpSD+RUJ1JXQYeyPjrM6HEciN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297585; c=relaxed/simple;
	bh=ZAXwFStmZbNqJy9oR7TQ0Y9dv/p7gO2dQuRUv73EMHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4nheopBVk4zg0CrmhRfuM3WDxll6kt26slHR+yN4uKCA2QSm2BrVKN8pT09/0i7VzsN9aVHdqi4rmx9AYyI21POD9yzgQirVJYYoeP67Fb5NWWDK8EhIjcpNN0ITlqILA8KIVKNN4QCg8sJaeEcNmos7Q2rtU6byHmW0Z5AlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lpnya0r5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lpnya0r5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703FC1F000E9;
	Fri, 17 Jul 2026 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784297584;
	bh=QZ9+MPzUjB95e9fSzX7rfBD0UZdSFDBGI5OQkz/6LHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lpnya0r5EwXsDET7q5V1ETOKAJF7QAv479nyIwApc6AMOZX9OS3QOTHS5yFiwWKnP
	 OdUwMoifefeR575rSeZ9LBjSXEP7owW5aP8UvLurs6L7AYkjailBaaRP1tmv/Hv9Ko
	 pEHEl0w/Drj8Xlj0g5VVVaGwK1TXQ182TP0kfQk/+sF4DiHhdYBslQvnTROmmEE4QI
	 nhTOfK1i2SxvlmYm8Dms1griz8j5SlXZ6/D9v+zu6HaNNcjnO3U8e7ljJ9H8ho4WJ6
	 Pot+YeGKxypI+IV5i9dLlA484o6pXCqyDKHi/Ns/qdQJYWiCcySamBLiVd4fg6CjPI
	 F5n3QPs0i5SzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Angela Czubak <aczubak@google.com>,
	Jonathan Denose <jdenose@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] HID: add haptics page defines
Date: Fri, 17 Jul 2026 10:13:00 -0400
Message-ID: <20260717141302.1738251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071417-praising-reconvene-e068@gregkh>
References: <2026071417-praising-reconvene-e068@gregkh>
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
index a9857fdfc327e0..f560ae891d7e37 100644
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

