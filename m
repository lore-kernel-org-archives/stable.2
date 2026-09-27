Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA596339365;
	Sun, 27 Sep 2026 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790524453; cv=none; b=N/acuQu3m0VmRCd31lhK4K52bBH+AG89h5KqY/r0DBqaHjjkJxvfhw+oqluLVFkUhuRrannF806Z/g0a6yDalBHS0ujG3ng/ZpYqzWqxWV3UDHkaGQWFk5WsFIbaL1V9BPi+oo1ZcTVkfBaaBJCGzMYYTa960APFGOp6MvKjjXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790524453; c=relaxed/simple;
	bh=EudmtXiuy94lgut4rZXvxzNyCSSFnysF5xYcuiUtnkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jZgeYlpU2ec4JlacEPyhzWjphjwgRB4h8r9SJZ0FY5+k5DHoxCMLjuYWIMam7pyHaIj3D46HRFKxzfJ1/n7t+MblzuPe+E2/BxdE7hWrKRlTr5QMZlWObyloSOZg+AaBw0WpoVzzOJiZ/zFNHQto8wdENCHCrNBn897bkQSkmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p06+WqhP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p06+WqhP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67315C2BCB3;
	Sun, 27 Sep 2026 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790524453;
	bh=EudmtXiuy94lgut4rZXvxzNyCSSFnysF5xYcuiUtnkE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=p06+WqhPr89RnLj1m5VnRAf0FpDXF0U2Bd37TkBJGPeyndBv2YQSgCuxVraLEjzZ9
	 RW57Zgp9ymKmPM6K6MqfVHUM9Voy/DvcEWg39bL2TJm8lBbNUE5k5csQsxjqFNZcR/
	 4LKxqQXm9gbkOigxHLyQa1Pc0ca+/mnHDEycDwnL58fKcreEKswPqNlAHG/KcTLMbM
	 8asxHiPNwSVvNouOjL99Ijn6TMSDGJELCr/vZzS/bmzkVZzCLYKoIQ5TXh0iyMq+vP
	 tbmkWsjSLO5YGBwPO4myQL8MiDxZ05Y+uhIJzqA+KFEOc/9ntvTwrZ6y3a9NxsI48F
	 30xiL1gXekl+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C10C9830E;
	Sun, 27 Sep 2026 15:54:13 +0000 (UTC)
From: Ali via B4 Relay <devnull+aliresool567.gmail.com@kernel.org>
Date: Sun, 27 Sep 2026 18:54:01 +0300
Subject: [PATCH] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for
 GameSir G7 SE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-master-v1-1-96ff85291b25@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubaaiTWvIhfGwVFGO0gt7264/
 NX/+wIwekKGKgng8SSm1UVkaQLd1LoRBfXRoKQqpVFaLC3v6IU2xurC5rnEEmK8eRzo+o7q5jc
 fdsZuf9dw3w/KLEKzagAAAA==
X-Change-ID: 20260927-master-799b75b330e6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ali <aliresool567@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790524451; l=2586;
 i=aliresool567@gmail.com; s=20260927; h=from:subject:message-id;
 bh=FeFiKgZTUo9MnK6Okaqk4RcBEvF7GaYA8aXucYh/6SM=;
 b=VNtAduVk2LRlJGNV6nQCF/dxCdQjn9UlSx637pBBZ2Z0RDLc2CXCmlTPSWmAjNFBUc17C78b0
 2316GCmxa+SBmZGfEBmjaeC0pb1XFJh1awY4YJQkKwY4SPHA9Bb/4uT
X-Developer-Key: i=aliresool567@gmail.com; a=ed25519;
 pk=s/zyZoG6z3JyJokqs9ZIcSAb8PgriZ1QW+mgffBV90w=
X-Endpoint-Received: by B4 Relay for aliresool567@gmail.com/20260927 with
 auth_id=1071
X-Original-From: Ali <aliresool567@gmail.com>
Reply-To: aliresool567@gmail.com

From: Ali <aliresool567@gmail.com>

The GameSir G7 SE wired controller first enumerates as 3537:10a0 and
then re-enumerates in a mode it picks from how the host enumerated it.

When the configuration descriptor is fetched the Linux way, 9 bytes
followed by the full 80, the controller disconnects about 1 ms after
its string descriptors have been read, before SET_CONFIGURATION, and
comes back as 3537:1082, a generic HID gamepad without force feedback.

When the configuration descriptor is fetched in one 255-byte request,
as Windows does, it comes back as 3537:1010 in Xbox One (GIP) mode,
which xpad already supports, including rumble.

Skipping the device qualifier requests (USB_QUIRK_DEVICE_QUALIFIER)
makes no difference; the configuration descriptor request size alone
decides the mode. Add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for the 10a0
identity, as is already done for the ShanWan Wireless Gamepad.

Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5-5
Signed-off-by: Ali <aliresool567@gmail.com>
---
Tested on 7.2.7 (x86_64, xHCI) by setting usbcore.quirks=3537:10a0:r at
runtime. With it, the controller settles as 3537:1010 on every plug-in,
is bound by xpad as "GameSir G7 SE", and rumble works through xpad's
force feedback. Without it, it settles as 3537:1082 every time. The
patch itself is against v7.3-rc5.

usbmon of the 3537:10a0 enumeration without the quirk: GET_DESCRIPTOR
(CONFIGURATION) with wLength 9, then 80, then string descriptors 0, 2,
1 and 3. The port reports a disconnect about 1 ms after the serial
number string, and the SET_CONFIGURATION that follows fails with
-EPROTO. With the quirk, the only difference is a single wLength 255
configuration request, after which the device re-enumerates as
3537:1010.
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index b5b577f..a4bcbe9 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -612,6 +612,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ezcap401 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x32ed, 0x0401), .driver_info = USB_QUIRK_NO_BOS },
 
+	/* GameSir G7 SE */
+	{ USB_DEVICE(0x3537, 0x10a0), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
+
 	/* DELL USB GEN2 */
 	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
 

---
base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
change-id: 20260927-master-799b75b330e6

Best regards,
--  
Ali <aliresool567@gmail.com>


