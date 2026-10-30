Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357109;
	b=XSLwuSJPB6ebnhHh9J33cPixtlHTlxgJiT7fHiolLOpmdXSJgwVB6WiDmXtZGoF+NJSD
	 P7eaOk8/BEYC+aC3KTZZOhzMqCJIbjN+Yj6DCvxqr83Hz4nxl/+aRWZA1kJeDtTaLrpTA
	 mDUHY+POn6mRAF3jUljhVRlksWrVkZYcM7VDLs8uSvIlYW0RoTLy7k5f377xxMJKLidcr
	 ayiiwHYb1mU0j9SAx358X5wp/L9/ysZrPvHQZtAO3y8sY63SLUqBZzku0wqjfm5cem5iw
	 idtZpleGN3D2yTxvF/oLinOsRgKsU61/K7OXu9SXGrXvjQzSBtrcZ4giJ4hWTo5hGDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357109;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gr6QOC8sNonb/ht+xESLhxvN6YAWLyQ7HMkcsgpicyQ=;
	b=LPhlZ+HojcVeHa5uJPCo22d0anzSNsGfpA3AYlSSuT0aPpYwZgcqevWvjmkgT+7cVh+z
	 vvLWDgFlc1PLZA3Rnovqb8UaGReZQMWwjZUcfRptRr/dbzlu2k00AOzWhNz/BPUPYRdSM
	 J8KarQvPAYM00AU+wgJGPNdjqUSMaTjrL4Ng5cgCDGFXJRlC35jIxmAiSyYr8/4s3qTOq
	 lsVkrBl0hbr6babrCaH/4J5oFEAz0TxgV/AHj9AOhc386Nxi6TStFVFOIVfj5q/fkYhB9
	 Ft1D6IAwg03wn1H0v44Rjf4mVqnrI2ogsJX8KD8ll54aaGctRXdw1RxryjGxm933n+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6916LCR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E87606A325;
	Fri, 30 Oct 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6916LCR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357108;
	b=y49D7i72bf64U0Cv3WguUHG3JaXytGYWbIo6R6c0B24NxbNgxr2Y1JcbNkRZTVhYytw2
	 qadwCO5WJ7eAsMP/nRuNy1c+ArHwHVWiACofgkfaJplrIJTnVS45GawyKPPhiOvRdRAAr
	 MZAvAT07g+rUVXPb8oIhE+76anrxRETN4DFaHx5wPkTlfArvs1Sh25OoZ3pkWTriobIOh
	 J3OgKbMB8ZrhLDnmkbolb4viGdXGY5chqsW2ehsqiL5Gyb+gJm62hrP32/EUcHqegrskN
	 jzqolpbZN+nMUcwNNyq/DvgVFy4ap5bBHm5tDidskG5ybR7BYCh5AOvzCj/81/fTqig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357108;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Gr6QOC8sNonb/ht+xESLhxvN6YAWLyQ7HMkcsgpicyQ=;
	b=mpKbGcrxC6UMoZ6hycxb/P8UQrhMfSkCWk2o6L0lA1UW3NvwPf4Ezja/+6QdK93V7KFo
	 sfQ010eeEmuZzr8C6agPc1cYSNwlFP2Px+dfyHj6m0eXBGBpnhcFAf/UDsftl0ZtO97O3
	 GmOAcpyMGi5703Ff966iM1bN9kaPdiN7lQ34ixI0d56ffERBAnI+mL1HS040Rouk/7Lvp
	 p6tZLQtCK/45xuOyNPJcGtNfkVV3ZTvPM2rJ42U8+HmC6Kg888zY6aik/m8jTCyFm45wR
	 AK6NRT9mh4ZgcyMennQ6JWGiILOS7vlcUgtCmCkAEkUh/uDoGPO+O1VUT6DullPCggw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9ABB81F00A22;
	Fri, 30 Oct 2026 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357108;
	bh=Gr6QOC8sNonb/ht+xESLhxvN6YAWLyQ7HMkcsgpicyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=d6916LCRVRnstqFRvD9KIFnDVY84/bJpIF17N8KfAzjQs6SRYAhBbSHG9PpWNjUJF
	 3phdrDxRQ0lt7kYJDOGrqhqbaBs/jwHviw2X8znBWxEzKwBMWV27iqJ/9K+VU4cEdR
	 LGl/e+JCrPrsT55sppD5ubIIwACm6fcmO6FzTDl2SjLqQKW032+JYoHBcVBNukqoLt
	 UjZfwmipHxhswUO1ayN54tE6u3O1ILMRQltWZ958MK2mOn1UJ3LfO7dobteNE1pC+W
	 fP3mVawsakZopf58lg7LKEtOGd0GrF3RNEUNxYfCB1u1q5S1dYWj5g78LN/qeLGuDI
	 LETXQeNpcO4aQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DAE9343766;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:45:02 +0100
Subject: [PATCH v7 13/13] can: peak_usb: don't return an uninitialized
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
Message-Id: <20261030-canfd_check_channel_idx-v7-13-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=1579;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=gHVAO2Rl66MDHIFKZekUswXTDlPvT8hxwdLn53Zzt4c=;
 b=NNqnUZystlhfPL6Jr1BDCoKDnTAzXsrwI9WXjxu/UuR9My1LGKD380NKmsBilyS5q4JoEEW8Y
 KGFNX+Gqd5NBBUI/zPULZdZWCHVj7b1FITjQOocoVq3JkKShmXaVbIS
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
index 626593251e5d..4f255f2a33fe 100644
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


