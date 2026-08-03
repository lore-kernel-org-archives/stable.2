Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA6253B73;
	Mon,  3 Aug 2026 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721750; cv=none; b=bT5w6DkAcHoK9OohXWZY5VH+s6owTeCmkZy4DnQeGFtF87Sve/4BFKKvCbFVdu6kPwfI3jgIMNlgqseezoIK4kKktSCrdeg4wj1Oqzia/Z1/xZx5ITSqbkB3KjCKl/7Fna5l/MVRBcGipbvDf01Dz147Z4WxvKo6PaTstoceFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721750; c=relaxed/simple;
	bh=xa4op5BFmvSOxtl0jKDqKP4zfEGxCBIeWhBj379mP+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fnQgLweQ7wU4jY5djIf+Y0Xx0lOC5kG1asZt1m0c8L4HAtaXLqYDdBovXzSIpfvrLeTGcHQ66EwVd5ZY/r+3VaR+ZsT+i3QC79X51Q7+Bezc5CmB9QI9nXkxkpw/NGd+0+I16fUZixlWw9L+GYsNdkobzsbFr5/EeM7VM0lYTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com; spf=pass smtp.mailfrom=sz-huijia.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sz-huijia.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9120722|0.1672187;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.447767-0.000931567-0.551302;FP=18445791274796245223|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=hj117@sz-huijia.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.icAV0-d_1785721742;
Received: from HJ117-PC.hjz.lan(mailfrom:hj117@sz-huijia.com fp:SMTPD_---.icAV0-d_1785721742 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 03 Aug 2026 09:49:02 +0800
From: Dongxu Su <hj117@sz-huijia.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v2] Input: xpad - add Voyetra Turtle Beach PC Rematch Gamepad
Date: Mon, 03 Aug 2026 09:49:01 +0800
Message-ID: <178572174191.26980.4407731925140715976@sz-huijia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Add support for the Voyetra Turtle Beach PC Rematch Gamepad,
a triple-mode (wired, 2.4G wireless, Bluetooth) PC game controller.

The VID 0x10F5 is already in the XPAD_XBOXONE_VENDOR whitelist
(covering the GIP mode PIDs 0x6015 and 0x6016), but XInput support
was missing.

Add XPAD_XBOX360_VENDOR(0x10F5) to xpad_table to enable XInput mode
(both wired and wireless), and add xpad_device entries for all four
PIDs to give them human-readable names:
  - 0x6013: XInput wired (XTYPE_XBOX360)
  - 0x6014: XInput wireless 2.4G (XTYPE_XBOX360W)
  - 0x6015: GIP wired (XTYPE_XBOXONE)
  - 0x6016: GIP wireless 2.4G (XTYPE_XBOXONE)

Signed-off-by: Dongxu Su <hj117@sz-huijia.com>
---
 drivers/input/joystick/xpad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f36..7f593fc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -267,6 +267,10 @@ static const struct xpad_device {
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x10f5, 0x6013, "PC Rematch Gamepad", 0, XTYPE_XBOX360 },
+	{ 0x10f5, 0x6014, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOX360W },
+	{ 0x10f5, 0x6015, "PC Rematch Gamepad", 0, XTYPE_XBOXONE },
+	{ 0x10f5, 0x6016, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x11c9, 0x55f0, "Nacon GC-100XF", 0, XTYPE_XBOX360 },
 	{ 0x11ff, 0x0511, "PXN V900", 0, XTYPE_XBOX360 },
@@ -522,6 +526,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries controllers */
 	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
+	XPAD_XBOX360_VENDOR(0x10f5),		/* Turtle Beach Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */
-- 
2.47.1.windows.1


