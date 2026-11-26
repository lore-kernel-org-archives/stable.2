Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683692;
	b=XQrryKnZDPAej7fIAi4uINGkpeIN0qaqC+v80nULMtiItnFSygiUdgh5TybQzZNX7dn9
	 eIAfKipq0yRqW0SA7y/YaWuYX0dKtOBihC1wEtlTzR6que4qAd1liID299d87u/wft9Aa
	 qPQ5mTfSXpuxrXiFQIbrjOPmxZ50HPYvqqgqr0As9rfz4RABvUCvUDpac/txjplw14pBY
	 3alyBKT/4V+FnLr5ubOv/jnI/Gw8Rj32b/L07iJx1+Y5MLpjR38yLOfg9p5qbCOXD1zDA
	 vY5YWXMQVsN09y+IVxPEs2x05Moqup5YK+GnTdxntOSXjpk9Brn2BshOZiEuE8C8GAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683692;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	b=PhDdp2/yPzfc472b4o8gUqot7POCflFSDC5YK8Rp6REcU9t7dhBT3zG60EylLBl1m3GM
	 cf5MzCIA9l12PzMTpJnEeIS48H2D/mL8qGGTdV/zlWZIf/4lRnigYVUFKQf32Hox5bOX0
	 rfHqU04+c+N4tcSjw+pkBKx9Fix4OV/A/yWvCCNAlqnB7IWotIcDdax9PUq7VTJw38GtE
	 N978ZUCZGJaVulrasUEcNPH9hx2aeMDRvbMAMy7Iy86NEWwJXFYIWE9/+kRCod/3ox8x1
	 Tpgj0gGAD9gS2uc5ygrK86ROXAkikdu7UelKKpIIvAqvuKGta4+kqqWGkPpnKpIriPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1PepgUd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB216606A32C;
	Thu, 26 Nov 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1PepgUd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683691;
	b=2Pkw2PUPjouRZtnyz48+5qo07krZyG573fXj14QyEE+d8ZdjIo5Txh4H2Ob7kt0sxnsa
	 nhDPMszjcm/CWn64vc3deRW8SucDb9WkRrwpKjaHEfHDkh+SL3nbxNlpb5wnH7CWWOFF6
	 7nxxJDzsHMLezaJdFAJ63rFfEc7//NjEbKJsd9P/7cmxsM1nbZjvo32InqwU3xYUJoGSm
	 UnMrCejhMHI6zcw7Zk/SD33lYkrTgpf9rMMJW6OIBhTJjbjsvqW413SkJwxhh8KshAid1
	 bnJ7Tte4aX3STHnd1SbePSL0apGyYkLJvCUyMiCUheid3i6LLDn9m2qH1X3hsJJfTMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683691;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	b=X7xg6ezJRRlWNQ7uozP1/IzbB9jQ9G7fnYWs9CMe+ZTQG9P5mq+CosPMZVRObJO3wmTb
	 bDGeGX/UpLMKJw5HxBvs+/MqUiVrga+CH9/hyYSGWNVyiEsYV65GYtBKYA0ZMQZxRBqev
	 WzQ31JZABkPjNH3q9iuqMFTA19OSOgj2U17CCM+81o1sX2uo5dwBTasPG8XCQIOxDaaIu
	 d4t4vYQbZivHATQhjnq6ghkCNJKHSomSqN4Byi9vOu5DCl5pdds7UdQY/xarCrYmxsuD6
	 FM8+E9Nm4z696WrXNasbAayZdSjwE7s8RvqItcaB8FVLK6iwtRxT4k4+sXNG9BngBJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5344C1F000C0;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683691;
	bh=JghuYMkJ+RKrCa+a4BdjNWaUX25zwciItep+KwOBI7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N1PepgUd6rBc5Zfrdbljdq0Pfv65guu7oB5dp6gNKZgXTCWGglHhLkEW9xE93ZFix
	 DSg6uk2chbKGNcUARZWpWBTVlcMw6Ht+okMGJ5+Zghh4uB+rVPHIr5SJJTjxbR4QKz
	 zVra96bXpP2ZUhNj74xlnFCfcxuQynHsUocKbAZiz1h/I5VzpWJXy4iAmab3sMZMIB
	 6xB7Juw/DNXZJb/38+JtktPjHaApqxGuMFls10y/3VO6xrdoP26ucQg/hBq5GcHnD+
	 9Oh/T+5vSlPhNr7wDXAtqFPBISS8aeyl/43uY1p3vbztoDtt91N0x3MQadV7zUEG8K
	 niX6mfZOAwHFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6A9F4D309;
	Thu, 26 Nov 2026 09:01:19 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:02 +0100
Subject: [PATCH v9 01/14] can: peak_usb: fix missing CAN_ERR_FLAG when
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
Message-Id: <20261126-canfd_check_channel_idx-v9-1-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, 
 =?utf-8?q?Stefan_G=C3=BCnther?= <stefangun@pm.me>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=1298;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=j5PVoCog9b3ym+t4Mbx6Cbdrz8WWMcNp50N4an/gOT4=;
 b=FtT8fkkd0ZAx3UecjGlnMOd3uRm7S2OGR5z36WveYYNX9RUQKBEeR2+BY9yV7O7fgufDO50pe
 qmGJr2ysTFQBgP5TCUKynwdxJ+ims3ilD/Rcc0smcgOFfimQzJwKQcP
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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
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


