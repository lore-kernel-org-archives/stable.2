Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683710;
	b=GdgrY/E6xPXe6hk/9Hwh4q8wKjBOllDQdIWfMMKiVMYL7H313Rqpq2Jn4xMED6qV0Zfm
	 qp7txtx1+WvkTPCMA995fJS6R78NP58RqsBTFM7fI33crXLaQs2TikIFwxjWAXyiC5RYa
	 iVxHtHu3KI8cSCU57oyDSTDIlzYdlZKwX3NnrzzIkqFXUFg7gqbaEf+zCwJ2WKj4xDaK0
	 CgD1Y2mg93aY7njUtxr6Cr7NrFZCdk1rdnwInujZOhAO8JOmAY4ygfHSZC2ypyjdwQ76Z
	 zNuZb7Gx46LW51UDBJdkg1jbRe4V6n1EwIQ7xhkspHWLV6azCGZg7X2umQpMzkUtQPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683710;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ah7GUvCLZEvICFaMYFAuUj8n9oHNdcQAXWQFAiFlim8=;
	b=mYJr2LPOwRmgvBz5YjncR2wojzmSRh5jwZXSrvPFFHoWtw4VMSPTjmJYV9tlpK/KAfDX
	 S8EsmW4/qW2tOsH23wTV+TiamUf0tNEzVPRLLr00kmyg89loaUhOTD9UDiSyPZgPmiO3t
	 C66+p2EqOchH/YKYOTaDt1JFabevGQSPij/cyiqj19xQtkUmAULG0jUiFw2VYReCRpe8o
	 RT/kN+inyetX0O55Ct/e7ePe7211YNgKkXCIqkM7ybHFFK3cxJJ4UtlhYetVLyQMEcKBK
	 t1synKCJJtk9d+fGVp1Oo/30R3zqZuHIBilyXRnS8YGfA8LRhRPRC0LVnOSmIF05NHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOdaxdMF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38261606A323;
	Thu, 26 Nov 2026 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WOdaxdMF
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683709;
	b=gu8roR8Q7O9RWeNnptkGG+2/ZIEvROO4m4M7oa4bW3mE4s0Pd0kGHGM0JOmDbEjJN/MJ
	 NEaCsPyJn8L6Kdarr8GQlDOZfdmD+bEPrVPQ9vrEHCv6S5jw1KVHo+9VqxdmTYkZbFqHj
	 HDRkSexdvDmyqiOP0uO+j3JkMicfYCbZnEVOUnIHJoASx1G/TCr/8OgLe49l/XLkbL2av
	 exckbNpCad0Tqdnbl6F5AoVlE+LbKs3IG0Gotnlb8MesJPQJvwueAcH0dfcQc9Z0HkiFL
	 IUcjmkpDrmP4rHvG81moA93Dof8GxZ1uwP3xgWFLXaf8hnhTzdqxp7+sxmex2qN0gZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683709;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ah7GUvCLZEvICFaMYFAuUj8n9oHNdcQAXWQFAiFlim8=;
	b=G++h+cBte0+9lfD8TpC7j3ygrCT5kJUa74NYyYY/NlJqRL8WkWK4Iw7Ed1Q356soEKRn
	 Mgdu+6557ns5XNUvSD1n4pRia6HKaXFsdYgQPpJSp2GPS9pj0R57DUUew3Sn6kXpOUccn
	 la4R6lU36mhmOCJSqb8Tq3yTii3FIFmW534T4Gzp/5mV298HY7HsIJwEkOy9zZf4wlYpZ
	 umf5qo2paS3td7d3lhxGsUyKyrzt2Rljxly2h13GswE0S7kmjHp8AWS3qkf01bBvj97ub
	 uTR2Dk+V1K4sP9F8vRfzBppco5cburQ4xuHsGa76okMdxt9FcF8lrHY2Feeu5frhSBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 400271F000D2;
	Thu, 26 Nov 2026 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683709;
	bh=ah7GUvCLZEvICFaMYFAuUj8n9oHNdcQAXWQFAiFlim8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WOdaxdMF7WZ0YW8k9bAIGag8Ox4tPN/ikVlNiD2qUTe8gKE8J+nNjdzOgvn78a2iO
	 LQU46wuy/v6tTHkVENUz8cghAU2MZoFfAsKeZ2USfDevxtTdwwCjZjQsA8j082vgn6
	 VvXrEN5Cpz5Y8OSRETHmHxN1qx470/gabvpe2RG9McLJM5+xFBX/ViOyicmnkpe0ZM
	 ALPTjjY2lt+oZCKwIGQsiComeHCjhZ4CZxxKO0ug4tTTlHhPdddvBs64BHRh0r+PyF
	 rCg3mKMGljqoKusSI2IQkAJ9frF+Nq8I/P6OtJEvh/+vQr3fyrYWpDyyUec/4irCpO
	 WRY7TCfwKUqCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 22F8C4D33A;
	Thu, 26 Nov 2026 09:01:21 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:12 +0100
Subject: [PATCH v9 11/14] can: peak_usb: don't return an uninitialized
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
Message-Id: <20261126-canfd_check_channel_idx-v9-11-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=1561;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=7B0vo9diFeiQEBLv9AiKbJVJlPqFLZBQsRQcMQ4PkzQ=;
 b=qoAEH4Ry4cBHX1KCTE3uZ5mEToYppW4Ve5O3b5J6VAY0jXFquNBcQPfeG5a5q4LDUeKqIn7Us
 NBMM1XtNhweChYfVO1Tm/rDUZgPmXFbfZk4d1WGPYoBG3GzV4GtMAMB
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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index ff1921779065..83cf6fe7d258 100644
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


