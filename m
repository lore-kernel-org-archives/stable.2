Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357106;
	b=EfleHosDTX553ExTj8dT6pkcrQyF4S75hAjU/wT8XAjORRILsMEc1EoSKk2c3Oof9bBR
	 KIPo1aHqIUDGzERQwAv4n2kLKq4YDhTDrHZwQBXH75lmgUPbBYvU4QpS3RRcOMc59cEm1
	 AYOUTghIk8BpIHnIrqdFjppl5DlHoPFRduhwc3gbnotKbIR7+oSmH6NbOFvQJKOEoCf8D
	 D/gKXKEn4HLH5Z1mC98jXgWetZRBnchwHTblZv5x8B3maBxxrFSxEu0bZOYY0D13FAKIB
	 i1pC9GVtxSaQrdOvIb0cRob3mEAawyxxo3fcOof+YPSVQsqd9m6SXqaU9jnJ9CHhXMA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357106;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=QfR63dAS50Wd6nGl5AP2HBCrJcRmWus8ZXKjXzdfhta1A3QukGCBAXYf2SGPktWva/74
	 HkNeLzVmJYyPknIDjH/7ZOiun44Um9amRIpJSknT95fNj06hmFzaQW0u1WI5753ckn003
	 fvlUpHp8dt5V+N5ZLCH4y+dlgmtKYA7MkGx9+xi4SfEHE3BcsBaf9PUz6a67a/sIhLsoF
	 1Nd/Cv70FGOopDHUD0urzA2w8cTalPjHqi4LE9SNZAOjeXVIMIAuCdN25M5I/l1qnymWM
	 XK0Ors9HQsW1hKSX1LD0wV2QCX4XbwxyDRs6QrdoYlye2r5+4nOq3yo1iEFWV4nI/NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ9SFY4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B2606A31E;
	Fri, 30 Oct 2026 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJ9SFY4W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357105;
	b=Mmlw9XBcFRcc9kI6D8QglMCuiljStLBRIlMk7CNqCgONMGOygANpSK9d9jexQxKR8cN2
	 MpdR2papkJMPbPnAQtXcBcgYJ/4CRwBUR7Wrn3XTMW/ObOrstW6G2v267R0QnyN7xpaTG
	 EPdXYv9CwmIO8g9/Mlgl4gZoXDRln+8neEecLOK2M9NeKZmcEIQpI5pJEjZxYUhLGY0/3
	 IH9vgHUlxHkTZ+bcYTFLlAkKMhh/rst+EtFxCRiFbGEVIHiAky5t5jWIOsX/7HjhH9d1c
	 uldyXmkBeIu5rMlYH86EwrN1fOZmV+Ec5AmfPsxYGOIrlmMcC7uxsflWcjZKg9QGoFA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357105;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	b=cLaztePD2B9I3hRDdrKYe8tHq0P8Vwt0DLo0iubyivaPghjSX3Ut1Qfm1DkM7TSU5m9i
	 YPasFiJ7lhoniGEqA97f/n5gCt36DDy+ZomTaLS5UHS5e0OaZSIl/KBoJGsmsFZeuERG1
	 oAa46n5o91A0OzTXTyTt5nkPJ8V8AWQ9w+duo5zHnpCx+xIQkAvJPux8tFNDcn36t6AKl
	 WB+sGzXKS3QaeuymWGv6MPkO4NHOb77eVepAk94L23uF847Ql4F76TkaWjd8gCu4zMhrR
	 OSMBtgLiUbUQd0ty9IsUN12aBX+5KzqPSWx209HoCDFmk7+3tZvyq7UWu0gSJDLk9WQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EB8A41F00A02;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357105;
	bh=PchrU+Va3DZaNKNckQ858GV5JoQCVK375UKKXHl3JXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WJ9SFY4Ws0cNbct84zCWUvnvYWUO5V0V5troANnmnxc8JoNUkdhrMnb1mmMj3I6l7
	 yNeCa4QBiew/zmLQBkHSJFJj/iKDH0+QbN9fQnbQ0tTvQR0jX8COGegyIonFRLAZff
	 3enbF0fsQrG3wrNwtDqMnLCM1VVh/nZqGu70yJxvIcTaU78I9K0fzi1IMh8Sjo9/gp
	 Usl/hfK+hthZaiTG44oj1Od3rAmBjreYIS31XAjI+pIQsgKOZNHfZyG/ciZZxoB/eE
	 HXDAuvNB2igRZ3wlPlErxu3ny2G24JstTX84SzL5W7Wuk4FhXhh/sfkKLsdclyE/ny
	 sY3Vc4SAfNEJA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 594A143721;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:44:50 +0100
Subject: [PATCH v7 01/13] can: peak_usb: fix missing CAN_ERR_FLAG when
 reporting error counters
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-canfd_check_channel_idx-v7-1-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=1235;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=yJYGMmDCA5H1YtV9p82vQMvFYiAXoP2GMFxyPs3vVf0=;
 b=MzAmo/yDJoTojbULI/Ih0m3T5EoAiZl4qpYhBRskLJ4xnpRpnysSl5pzPkBDjkD6FyHMmzIY9
 fWVOPkMeJYsA0xC0YCDgaOXqEn4WUTLpsPP5SKHHjSQHCLlsNyh7Cgc
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

From: Stefan Günther <stefangun@pm.me>

When the device reports error counters, the driver incorrectly uses an
assignment (=) instead of a bitwise OR (|=) for CAN_ERR_CNT. This wipes
out the CAN_ERR_FLAG and CAN_ERR_CRTL flags, causing the error frame to
be sent to userspace as a regular CAN frame with ID 0x200.

Fix this by using a bitwise OR to preserve the flags.

Signed-off-by: Stefan Günther <stefangun@pm.me>
Cc: stable@vger.kernel.org
Fixes: 3e5c291c7942 ("can: add CAN_ERR_CNT flag to notify availability of error counter")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..785224e00c4e 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -526,7 +526,7 @@ static int pcan_usb_decode_error(struct pcan_usb_msg_context *mc, u8 n,
 			/* Supply TX/RX error counters in case of
 			 * controller error.
 			 */
-			cf->can_id = CAN_ERR_CNT;
+			cf->can_id |= CAN_ERR_CNT;
 			cf->data[6] = mc->pdev->bec.txerr;
 			cf->data[7] = mc->pdev->bec.rxerr;
 		}

-- 
2.53.0


