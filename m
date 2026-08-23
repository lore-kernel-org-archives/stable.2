Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B4385535
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481115; cv=none; b=YfviSzGiNyE5lSNZ/AFYz0LTxxUER16PagKiBnm3BmR2JpEB0k+5FUB4tnlrj8fQZclUWgW93+C6IkowwSUe1FPGnRTwZ9A8gfgKMBtjT9luVfj+m84pJUdU2/hGsl1Kwiv3otXI87GeOJ6jsTBigk4oMyj+u0mqCFIUTWIkJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481115; c=relaxed/simple;
	bh=dQUbW3oLnHxWw4n65dJh3z82+rr/im6seKUc5Ma+wIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/ARQcf4+b80sisagJsTS4xjWtAnD34sU49LgebIjB3JfnuZhS1OT7XWxJ18Xu0zHEM+ROkHX8qQYkh+vZUspP+t2EgsvNT4xyKDpNuN2kdncaOkHSQWURoG3pc3XPxcaQHV4T13ads+o5j0Tq3dta84PSPapEN5hBKMSd3qr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LddqOiER; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LddqOiER"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15f020a223so361201466b.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787481111; x=1788085911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFnTFrfpFngdekWeSORF1sopRz6Cq1mU1Ri99WmzuVg=;
        b=LddqOiERg5iPZvU6IGLSJz9hxenlcWcoA3rgHvjDc2oQG+84s64GVnul10Cg8qIooz
         b8+RCWf1SOc9RmvNSO91F3wKsK6t7DBk7dYyI4i64isTPTmuqfMDpCKNxWjrkaUvWxki
         IiLvAS1e9rKXMvh3H7GZ7gooQIRGMXiwicQzxbUUi77l9jpAqX5fDlvAT48rfZTQcgkR
         k289CwZBJrT7gHPjXMKwVqvVwuJ5cm3H3caWJrczY2CUA1sIa6VWbio2tnCwCzJRhJqD
         gQxkuY1pSPG5hlngucfvOohnN+8VU2JELtzNzPh3DRzPi35YAUH8hqyV2wi1KTgGvaOx
         ObZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787481111; x=1788085911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFnTFrfpFngdekWeSORF1sopRz6Cq1mU1Ri99WmzuVg=;
        b=ExuWONe4BYstPjzwZlP6adZak6xOVdt39CF/+OPf4ZvanScMy9l26BS24j5EU5R+mY
         DZZAydpiHfezh8/fKSDvWs12Tp/pewqkNKGnaz702+J3D3vYIXiRdQ5eUY9d5E5oVSxN
         08yW74zJoK95kF7zAA2zxcGEivNyKQrmXeqd4fPkiuLg0IL5rnA5gn6MHsUFlDktQou7
         JNZXCTFnLhG9YoRuOrfnfHxBfVI7ToIkfZsBQDe+/CybADGrIIeP0dEcVuTErKNJiyKo
         qM5ZWrxZDT3ohaqUoHwdCdC0OyAY2ZXTaywGQME9G0stfk2Y7oD6wFWPwMolz+rpw95b
         ABCg==
X-Forwarded-Encrypted: i=1; AHgh+RqCnrH2RzBOcofv5RrHS8miSkyIYqX1LKZ0elgWZ4YLPRlIoGR+I4PZdjlWhVy0ClQxssgdTTw=@vger.kernel.org
X-Gm-Message-State: AFuF++n8w4Jh3iRtTIlNTPG2ua2K2DCYDCjjjFg339Oh8tnd2clEvaVD
	YW1ldliFe9G08VIGe3lI4aLPggQFwSc24OaUkwurwcajsiK5sAxClcjn
X-Gm-Gg: AR+sD13ygbZnUneqhnP++PmtfL2P4t0JMAcootsolHsBJT+Sjp4SQYAzgZkHoNgB+Pg
	5vQ/gcIvFokGhjg2SigM9HbbFJVkVkmGOpAK1mtltV31+EYMau5+E/X7c01F+jlWwUNLZLOC7Sz
	q//zOkAfDmfOSQeoZiG3A6gAZH6XHeqsjYLgB1rrHPpzPEXXRtj4s8AiRlKkxt6WJ67R8K1OdXt
	dDnzlVW+Tu/hBSET+EDoTjQkpe7mf4wQaXZYtkYXbTSrMcGiWAhAKLQYEoaznH5Nxiie9eF0mUG
	4mmBxJoEMdACO+huZ70ra5BEyP5mOJT9Kb/BKQeezipWf2y+KfvdTkDtFEjFcJCqR/XlfcDMIV6
	zmwxOMERJZK8kWPjvnYRwphm2eB07e+SdpEaz62rFbHYbozNBgwzEWPvhMGvonW0iyc73PTmJok
	codA7n/fismI6RsSqbqNYyhITmEkodfs6HOSPosnuIFEt/LIcEY5ibbP2DGG+cZUjUA1lX/OtUy
	MST+mUI9JAEGaQK3Fi/rxkoqtYH4lile5A1CmD0MmCtPZCq81SG8AefD/DmdXFKX6b+uyYz57T+
	0e30/8vFkcfSL8zcjw==
X-Received: by 2002:a17:906:81d8:b0:c16:12ff:dc93 with SMTP id a640c23a62f3a-c246a6ca584mr1761699566b.18.1787481111314;
        Sun, 23 Aug 2026 03:31:51 -0700 (PDT)
Received: from bobo (d163-170.icpnet.pl. [109.173.163.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496734bfcsm730232166b.43.2026.08.23.03.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 03:31:51 -0700 (PDT)
From: Kamil Serwus <kserwus@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Kamil Serwus <kserwus@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan"
Date: Sun, 23 Aug 2026 12:29:59 +0200
Message-ID: <20260823102959.100368-1-kserwus@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5ead2063611ae56809b1b113ac44cef9547c81d7.

It sets HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B, which forces
the legacy LE Set Scan Enable command (0x200c). That was validated on one
dongle, USB 0bda:a728, and it breaks others sharing the chip id: on
0bda:8771 (fw 0xdfc6d922) extended scan works fine, but the firmware
stops answering the legacy scan-disable command:

  Bluetooth: hci0: command 0x200c tx timeout
  Bluetooth: hci0: Unable to disable scanning: -110
  Bluetooth: hci0: Resetting usb device.

btusb then resets the controller, it re-enumerates and every connected
BLE device is dropped, which on a machine with a Bluetooth keyboard and
trackball leaves no input at all. v7.1.x drives the same dongle, with the
same firmware, for hours without a single scan error.

This does put 0bda:a728 back to its pre-v7.2 behaviour, where extended
scan logged repeated -EBUSY messages but the controller stayed usable. A
detection-based fix is under discussion on the list, but the culprit has
already reached 7.1.9 and 6.18.45, so the regression is better undone
first.

Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-bluetooth/20260822141115.58815-1-kserwus@gmail.com/
Signed-off-by: Kamil Serwus <kserwus@gmail.com>
---
 drivers/bluetooth/btrtl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f54d2d2d..03fa9409e 100644
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

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.55.0

