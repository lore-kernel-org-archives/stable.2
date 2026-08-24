Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255738551D;
	Mon, 24 Aug 2026 18:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596848; cv=none; b=COe9bwZkckEgfb60o6f1ryMuYnyiANO7tr5PjQik/W2KIeODkp/01YHsJTFn8/SiMDSGtjflMrc12YOKvaSiLar/G+sHAV1kRyXUFVhSnxYTc2enxpgSejQuI4gzNQfl094+TcFO0e5cPNDExoe9l2lQIaOGBG4pXaQ/cDrpjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596848; c=relaxed/simple;
	bh=q9WT3hu5bzjlDEBkL7RUULCODLweOPpa3QkodIBsD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbpyus3kiyKvUVHLKaCotsg+pqNJlJxGg2UsVSdsKl6K73MF5s0K+fb/WR2tUIoC96SRutgr1t9VoNcyXyoZVAW2eWHcbbKsSPU1UfGWWwERx/R8yQ3SKmLjbUwSpHTLOC7Jh19IvpVLSLf2pZimW7G0y7+gUhJwtM50H9CBdhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 80FE2104724;
	Mon, 24 Aug 2026 18:40:33 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Staudt <max@enpas.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 RESEND] Input: joydev: Don't expose DualSense motion sensors as jsX
Date: Tue, 25 Aug 2026 03:40:09 +0900
Message-ID: <20260824184019.432703-1-max@enpas.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this, DualSense (PS5) gamepads are allocated a second jsX
device for their gyroscope/accelerometer, confusing programs such as
/lib/udev/js-set-enum-leds which look at jsX device numbers to
determine the player number. Ideally, we should have only one jsX
device per gamepad.

This follows the schema started by:
  commit 20ac95d52a28 ("Input: joydev - blacklist ds3/ds4/udraw motion sensors")

Fixes: 402987c5d98a ("HID: playstation: add DualSense accelerometer and gyroscope support.")
Cc: stable@vger.kernel.org
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/input/joydev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 32459fd8a7c1..f49dd10782f0 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -753,6 +753,8 @@ static void joydev_cleanup(struct joydev *joydev)
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER		0x05c4
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2		0x09cc
 #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE	0x0ba0
+#define USB_DEVICE_ID_SONY_PS5_CONTROLLER		0x0ce6
+#define USB_DEVICE_ID_SONY_PS5_CONTROLLER_2		0x0df2
 
 #define USB_VENDOR_ID_THQ			0x20d6
 #define USB_DEVICE_ID_THQ_PS3_UDRAW			0xcb17
@@ -793,6 +795,8 @@ static const struct input_device_id joydev_blacklist[] = {
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
 	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
+	ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2),
 	ACCEL_DEV(USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW),
 	ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_PROCON),
 	ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_CHRGGRIP),
-- 
2.47.3

