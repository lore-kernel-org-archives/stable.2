Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313855;
	b=WMXsuf0jGIleU0+yh/gphsMJ6re0IRKamD4CLwwgY4ZRTQg48K0tDlFFuJPhye45R1q4
	 hR/55aIWYWUuXvTyZ3tmdZMxz7YriIihx2uogwdmS1iz32TX6RK+au8WTuhWpm2eLkV42
	 EPmw/R11/DpPL46mzdAhoCSTe3wYOgArbsQbDsWwC/XHe4YekfiPaI397S+ZyXKUvXgJK
	 k2UXKwJH302SQZaUOv5Uav0o4pG+9B1vJ9okOlEI4TA21ezxzBV8CBGKeCJf0s2jn+9xu
	 I6cXMNb94bONq9LowORYuPKSyD6es6kg/tQXY6rYSOSBnhmJaWbAxzc4yFqqTRjzO1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313855;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fO9BO0wbmDeL50UnCAUhyfaB7huGMM7FTR+c+p07gCM=;
	b=3y6iM9BCZ6Lh9nWVUadjxnVSm9OnI5d1J1rrLOwGBuOVtVxDcVtWDvvt9isX8YMPRaT2
	 sOUseBGEnoqeS+2df1v+3hqrVRytMDPA08gzSfAXFGq4+XWoL42AJBwMnRKsOQIBneJEz
	 6F8eaUf7W9+6lpIRZw/+MNwKZ5nASItWO2k886gx3nXqJQPVYtfjOvAno+Hook94bwmfm
	 VNW/dHjYW+hjJZZHz1PXK2fGIUx5C+qP9s2evWyknZEq004IdYaBCqivwodsvimzkToHg
	 DfaPyPF8XnR4EEaTNbI+W5AUcEoSYs6wn1+zLSJOY3+8lN9F3Fjkaot+5XWD3wrh1NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWBLMHG3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F75606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWBLMHG3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E51F008A2;
	Tue, 10 Nov 2026 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313855;
	bh=fO9BO0wbmDeL50UnCAUhyfaB7huGMM7FTR+c+p07gCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YWBLMHG3VyPyA56Gj4zuWnmdt2r0ftsvH7RkV83AVLabnRMuI0kbPIck9BMnLyUEU
	 Z6lm98cgOdXE2uAhYO8fYuyHb6VYlGXTbwyjAUIngGdMVhnl/NRIfXl4vMwSeekBIr
	 xPM3ota/L0mZeKvxjfyeTGr/l/TrWOwBIL3gUXzi5QfhJy3Cgbq1eurk2rrZ+sajaJ
	 YIS89TMBXl2+N8hX37BPwI4k72Uda/jbwUW/6d2HZqTmKwkRjw3hr9ojG6oh3JOChj
	 Ru9IAsReM6PMN8mHFvXQBoVVoGTAFT68PaHeM1V0nO8FcNGkfVDpjWvkj2K/8uzVcG
	 xcWJWzToXjHiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ali Resool Tuama <aliresool567@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE
Date: Tue, 10 Nov 2026 07:30:51 -0500
Message-ID: <20261110123027.1222319-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110123027.1222319-1-sashal@kernel.org>
References: <20261107052058-failed-6.12-40224df29729@kernel.org>
 <20261110123027.1222319-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ali Resool Tuama <aliresool567@gmail.com>

[ Upstream commit 40224df29729618ecd88c5c0077e71b1e82c7a3a ]

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

Cc: stable <stable@kernel.org>
Assisted-by: claude-opus-5-5
Signed-off-by: Ali Resool Tuama <aliresool567@gmail.com>
Link: https://patch.msgid.link/20261002-master-v2-1-24b05d8792b5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 23d5c30332ffb..ee439a2ddf316 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -607,6 +607,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ezcap401 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x32ed, 0x0401), .driver_info = USB_QUIRK_NO_BOS },
 
+	/* GameSir G7 SE */
+	{ USB_DEVICE(0x3537, 0x10a0), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
+
 	/* DELL USB GEN2 */
 	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
 
-- 
2.53.0

