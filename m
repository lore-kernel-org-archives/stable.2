Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679279;
	b=Rh7LadLorpsUsyD9cwmUCPLPbhdxQwKX2S9vykow0FUL3so45K9u6hheRVPHzoPXign0
	 E6jPkV/0Yx2ZniFaPXJvthHDyAStDSYUIjDfzQdk4UpCRwN+VWUJm2neCix5FMWPjh5HQ
	 FxbWZbdMdXVTiFHV5u8dgr+pa2Rxa3ADPdIDjjJZXQrYXrvS/1rLfQuQUeMbhVTaSc3rY
	 +u9M7F22XCMDN3aAazS2dfAWLIT3sOFIYmw9X+p8yx8a6E7x3tpG6eYl8WWAuWbYdtsnF
	 GF74xZpgt+2lQMBHwXgenqAnL5tOEgvtwKZx83+DVSRxxOwjAU6LHXpTplxvsrHNM6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679279;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hhyonYdQeinpgDkYCHpni5wKDao1lsWxSu5Y543oFiM=;
	b=BXPPUwY0TmxnECxsITRPe+KKRiHO+F/GK/0RkKO/wwigLw1+RJcGDLhOihQnp/0w41dY
	 GIZLFdf29+78SKwMmOSLt6iLJH7gtH1uN9Crp7ZCJGRryvXe8kr3bUxkIoTM4Y3c29C6p
	 KzEH80WsuGVmdTWBUBZxB/3hmaJ5DA3Ps++4rFNw8SDLIJ9jA5JmMUMqsL7AMumyTK1oQ
	 8idWH/fj3Z36xJLQHaedYz6AnOJLkgehMeeSJREjk9BXROsON2q577v4c+/e8y2cNPeva
	 GT4OcbYIKgn3cOUD8/hXwMLLAdUMU3EGjeU8U2u2jijUFLqcL8Z0oMBtWaWVrZWEoFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGVkRSq+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328E606A338;
	Thu, 22 Oct 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CGVkRSq+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679278;
	b=i+/GB8l0x5MmLW1cO67R7toMX2exduprNPKf71Kgq7Cdj5X21sKG2goFHGcmX3HvPq/g
	 Wtz+LtXE9QP+/TD5672ddIPhkAsrsYCsjH+M4Pw3z+QMlBsrX+Mu5mbMD/FntEPhnjhR7
	 VQrvyP6RklFGu1z5n+S8aJV3pFfe2717YXls78cwcbMA5O/QZIB13be15Ov91RfETA7eI
	 CPUNrbvaKVcC2P4WEDffNIxqzKjFq4Mgn8c1I757f64fQwmfIWC4M57hmPt5Hs+zgF8es
	 uO5CaUVEdQmOBsF7sQ2wRpR94viVKz7XGzaAlWpWw5+aQ0ZRyR7HGDvk5zbc4my6YMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679278;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hhyonYdQeinpgDkYCHpni5wKDao1lsWxSu5Y543oFiM=;
	b=OA0OM6yeabDJZWcPwB0ghFgLuxHpF82G1viWhMuVehNLHZsoKXs8hu+LyY51WchugCqm
	 2cTlILpKWCWSgzjPBRCT/03aWAx081A4KPf013VimxXHuHwXSjmqg3pyiGFwXSBA1nQ0N
	 vatqPHILG4v+z8sK21EjBjhyRRomvp6y6V3KGwItO5TqeaGIbmM6OwT3sv/HYfuo5AGjT
	 mfCrwdqhkooHL1p4EvxThLRGgdlmXxLdwIQLY+MkQMm61oMQHgrJYTQvf6tUp+77Dd+F5
	 p/jIr2shpdSJQx6B9lyt3cts4SXRhza2aAcCYnjn4BGR9Zr04ZZYkf7RuZ/3s4TuT2w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DCDEF1F000C3;
	Thu, 22 Oct 2026 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679278;
	bh=hhyonYdQeinpgDkYCHpni5wKDao1lsWxSu5Y543oFiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CGVkRSq+289yQNchECz/RCuF51ApGBuUe4BF1ueG45N3shoIN3+51y8q0AlK4IZY5
	 QKVSdj9ARUr8GTyuu6Ynac42dL4qksUNuM/lEoqz2T+G+RBCGb/kHM3kR7omXQ4XE6
	 qebrq4e5pxp5rUps2zuFokWKWQbqHgn7L3eBs7SWWSjA1nUPZDAj5fYuUjyrIS3HOK
	 yQx3gWeonBtlqsUUGMws+uU3AckfCp28cZ35QkrL/wBjpXz0ekMN+O+jZ6/viKJqAD
	 o7nKXtKgeG2VHGgABP2O178A+LjY/3Ij4svZ4qTnEDgagzSZR0pTZQW2sZrnkh1P+O
	 /CfZUwcGeabtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F002D435E3;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:58 +0200
Subject: [PATCH v6 13/13] can: peak_usb: don't return an uninitialized
 PCAN-USB CAN channel ID
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261022-canfd_check_channel_idx-v6-13-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=1579;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=2N+4v87ZEKpWSle6jAUvJXEinlLkhV2BTPDa7+Y0JWo=;
 b=qOPP71xdWtivSpvbsNqC1hA5xyOnU8Ttiv5FdhlPNDsXcyJ17vpFYBj9fZ7YYunqzU4oS+WD4
 Jgi0vS4Jn7WAn35nXycWRWwce4XRpKDSWB5qxNiRASPsN03W84D/ZuF
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

pcan_usb_get_can_channel_id() takes the CAN channel ID of a PCAN-USB
from the args[] array, which pcan_usb_wait_rsp() fills with the response
of the device. However, args[] is not initialized, and
pcan_usb_wait_rsp() returns success without touching it once the device
is no longer connected.

peak_usb_disconnect() clears PCAN_USB_STATE_CONNECTED before it
unregisters the netdevs. An ETHTOOL_GEEPROM request handled in this
window makes peak_usb_get_eeprom() copy an uninitialized stack byte to
userspace, and cache it in dev->can_channel_id.

Initialize args[], so that a null ID is returned in that case.

Found by Sashiko AI review.

Fixes: 36d007c6fc79 ("can: peak_usb: add ethtool interface to user-configurable CAN channel identifier")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 04019a9b868e..4d8f23f2fa2f 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -386,7 +386,7 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
  */
 static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_id)
 {
-	u8 args[PCAN_USB_CMD_ARGS_LEN];
+	u8 args[PCAN_USB_CMD_ARGS_LEN] = {};
 	int err;
 
 	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);

-- 
2.53.0


