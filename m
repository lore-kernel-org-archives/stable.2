Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33D352C54;
	Mon,  3 Aug 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785739667; cv=none; b=l5TuOoCk3wn354m/U8vGjHqChRdfGA+PGpiicT7W99WrlJofOp85PIHOVk4UCOVqgaEvawzWMH/FAfJquSfgLLfhKUe1vbl7Llwslhq6cUoEDHB3T80OOth4O9nhJjAkhrYfBUui0AJHqVZgoMei3cel2otdQusQMIYTc/liSXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785739667; c=relaxed/simple;
	bh=ZlPxhPsLA1vUia2Y8tO3Cnyk1YXdWLIHaDJvdDZF8LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZJUspK+T44H5/ZIyhMo7j/2j2ISCAYJ3Ygup1+29A5kL3g/JBfVPl2FNtV4BOFjsNzf/GRtbwyWfeRl4YLv4Kh2lEe9mFK2BQXFWjzPnGZsntfaargp+SD07EzrgJH36/dsX+hr9ovPPNiVYFBCSm6lM1t4cA8Jc7MuGjNncYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com; spf=pass smtp.mailfrom=sz-huijia.com; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sz-huijia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sz-huijia.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9203386|0.1519993;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.393476-0.000866224-0.605657;FP=8646379598522245346|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=hj117@sz-huijia.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.icKD0h._1785739652;
Received: from HJ117-PC.hjz.lan(mailfrom:hj117@sz-huijia.com fp:SMTPD_---.icKD0h._1785739652 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 03 Aug 2026 14:47:32 +0800
From: Dongxu Su <hj117@sz-huijia.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3] Input: xpad - add Voyetra Turtle Beach PC Rematch Gamepad
Date: Mon, 03 Aug 2026 14:47:31 +0800
Message-ID: <178573965180.24908.11825133918986345820@sz-huijia.com>
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
  - 0x6014: XInput wireless 2.4G (XTYPE_XBOX360)
  - 0x6015: GIP wired (XTYPE_XBOXONE)
  - 0x6016: GIP wireless 2.4G (XTYPE_XBOXONE)

The 2.4G wireless dongle operates as a transparent bridge presenting
itself as a standard wired XInput device (Protocol 1), not using the
proprietary Microsoft multi-controller receiver format, so
XTYPE_XBOX360 is used instead of XTYPE_XBOX360W.

Signed-off-by: Dongxu Su <hj117@sz-huijia.com>

---

Changes in v3:
- Fix XTYPE_XBOX360W -> XTYPE_XBOX360 for PID 0x6014 (wireless dongle
  uses Protocol 1, not multi-controller receiver format)
- Reorder xpad_device[] entries: place 0x60xx PIDs before 0x70xx PIDs
  to comply with the array's VID/PID sorting requirement
- Add changelog (was missing in v2)

Changes in v2:
- Fix base64-encoded email body that corrupted the patch (v1)
- Fix file path from xpad.c to drivers/input/joystick/xpad.c (v1)
---
 drivers/input/joystick/xpad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f36..32720e9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -265,6 +265,10 @@ static const struct xpad_device {
 	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x1038, 0x1430, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
 	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
+	{ 0x10f5, 0x6013, "PC Rematch Gamepad", 0, XTYPE_XBOX360 },
+	{ 0x10f5, 0x6014, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOX360 },
+	{ 0x10f5, 0x6015, "PC Rematch Gamepad", 0, XTYPE_XBOXONE },
+	{ 0x10f5, 0x6016, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
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


