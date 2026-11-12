Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470937;
	b=PhYbN6o7wx9uxJswiBl5NlfeQfr1FLNd+2+lg1Hp5Ta7uDL9DpFXowF6x117nNnUa+Zm
	 KYPJ6nECgOfXtIhVlphC94ZXOjbmk7cC5kq/s5zUB/R4pv5pCc9xpEJkOdH+W2KYRbRRT
	 mTv/L1EalnyyGI+Hso32fsLnQMve3j92IspePAGPgIjG9a4tRQNZUT/tQuW6/2iis44Pa
	 9C5gLcbmkyI+fvc/9E/IUUwRI0zsVr2eNXTEI+tgoihvhRVLEdcJkWH5K7QdnKzthuUYs
	 c9QRgdDRfwYk5q6LGFWGtsXA3oqvOC8QopirhKuH+vVcTW5MHgy1Vi+irs2i/VmMyZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470937;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=2D/R2JIZn/JRiah3LTYqJs4s2g3DU6Acga5I0IFKcSY=;
	b=qD5wGNGW/r5AIjLSidzpUICJjppacnOemwdK1mdZmcARVt64x96Zo1cnDqyehETwJS4G
	 FI4iNXJYtdQzB0Q4V7jBNoel3PaAekiXezuLQkoYr9PgxGwJUk7w9pBjybdeMgNXdG2/l
	 KhTYwdf8z3MiNNVVj8V/Pv7g68XrU/NOWDkbsgilndA/V/wn56PPQQXHFojf7ixfUtDBL
	 1WoyldIl4BBAW+/wbnPufTdx8XZah5Kbct4X92HZsG4MhiaZM00bMNbz0qph8M0nvDog+
	 cl5ryEfm+kZxD9gsNkfy1JKCWb3iNDPDO7RmeRLmeW9KMhr4qhRw71l9mjS/5t0mP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=S78ut2O9;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B22606A331;
	Thu, 12 Nov 2026 08:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37B22606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=S78ut2O9
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3082EA0179;
	Thu, 12 Nov 2026 09:08:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794470935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2D/R2JIZn/JRiah3LTYqJs4s2g3DU6Acga5I0IFKcSY=;
	b=S78ut2O9PxDj2pxOJgN3vqR/S/mBDvUBmVv8DxcMNk8/AZrHrPmFwo/efJQqwnlMe4den7
	Ik2FkkRa1gnufOEmooWKkTrHmtkzi/q2ovaBtsmrVNONpOIpyU+KYtYZ2/oz59lVVxAaCQ
	g3v4rcdl1zMBS9Qrz5XTD76LsFkXKRIzBwW5XsLQtwFFsSLO09WZv096H+5F2FG5PH4Q97
	i4Q0FBjZsFTdaLHBS8012gFw/lMeEZ+QA5J7lir6GtF9rf9SAU3mVcg9/OTEfmhWZx59yT
	QwnZXWXEgGkPQgMyeQQIBEBagi39TPhqNcuY4CnkeszFwhvBedctnVrIK4WTIg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH RESEND v4 0/2] serial: amba-pl011: fix RS485 state on
 enable and reconfiguration
Date: Thu, 12 Nov 2026 09:08:50 +0100
Message-Id: <20261112-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-b5c58ff3a376@tipi-net.de>
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
Content-Transfer-Encoding: 7bit
To: Russell King <linux@armlinux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Lino Sanfilippo <LinoSanfilippo@gmx.de>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

More RS485 fixes for pl011, on top of the ones already in tty-next.
Together they are the groundwork for a series I plan to send next
cycle, which refactors the RS485 code for better performance and
reliability.

Both patches fix changing the RS485 settings while data is going out.
Patch 1 keeps the transceiver from driving the bus after the data is
out when RS485 is enabled mid-transmission. Patch 2 keeps a
reconfiguration from stalling the port.

Tested on a Raspberry Pi CM4 (PL011 on BCM2711) and a CM5 (PL011 on
RP1, behind PCIe on BCM2712).

Deliberately left for follow-ups:
- pl011_rs485_config() sees the old settings, which are only stored
  after it returns. Will be fixed in the RS485 rework.
- A TX flush during DMA leaves the bus driven. Will be fixed by a
  separate patch sent alongside.

---
Changes in v4:
- Patch 1: detect a running transmission from PIO or DMA activity, not
  from queued data (sashiko)
- Link to v3: https://patch.msgid.link/20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de

Changes in v3:
- Patch 1: adopt an active break when resuming (sashiko)
- Link to v2: https://patch.msgid.link/20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de

Changes in v2:
- Patch 1: only resume on an open port (sashiko)
- Patch 1: handle stopped output and pause DMA first
- Link to v1: https://patch.msgid.link/20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-v1-0-f07d4da714be@tipi-net.de

To: Russell King <linux@armlinux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

---
Nicolai Buchwitz (2):
      serial: amba-pl011: finish a transmission still running when RS485 is enabled
      serial: amba-pl011: keep RS485 transmission running on reconfiguration

 drivers/tty/serial/amba-pl011.c | 64 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae

Best regards,
--
Nicolai Buchwitz <nb@tipi-net.de>
-- 
Nicolai Buchwitz <nb@tipi-net.de>

