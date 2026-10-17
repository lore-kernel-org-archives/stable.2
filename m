Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D141A6820;
	Sat, 17 Oct 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792217900; cv=none; b=B7nCvYsJgvZ/pl/pmwHCF20CvXsx/sP/N60MeRJZx3bhYI8oJXO8gkZv+iV8yVK9xVpcoJPet/Eyh5Jjk6V5b1osTK0MBaOiPsfV98KIQjA3NR+wGOgxbb9k6kl1/yac8/4k5MNTR6c9Vy4o3OpmMqt8fivMQFZMVBLVO9CKWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792217900; c=relaxed/simple;
	bh=CV001doalBk9XRdJKCRj1eF81PB+s4X8Fo+XRcRna7o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AGXzUmO0DJt+Z7SCalIhrRukmAMR1WEA54mtW4xKSkpVZH37sRJDQc+u2S2fiMHUD2a/CDI/QgUijpx7IJtTe9Gn0ILl2pSRA+ESrNeRfFE5uqXU2YKUB56vsKlxiDunnIsEEhDKSQJETn36cy2N7+YoJp4MA1cQh7ZUr1WFvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YlrzLTNQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YlrzLTNQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F7B1A1568;
	Sat, 17 Oct 2026 08:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792217892; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=froW5F7JDl45NeFm5c3ECuluX30eD/snpIdc+ZMTehw=;
	b=YlrzLTNQgRgAXPwb3aMDAMoSbztWCMlu3cL0tBqo3L+2ywquKmylmLMZyy0oE7ZLfIu3Sg
	B/TqLo6FPIrmyTyvPi4OMO4vh0ISIXSKBAAxkZGuxikVTDS+WP0pllIVjKpu2OZkt7q03h
	+2fyletXCR8NecQh6vAb1KNZZK2OZj50PD+zgOazkWG6q37+iX5jm/yuBPcHhC9SnDAuX8
	gegQfco6Pvn9NToWl3kE91kXppdjFozXwAQJs+NZBCtKpGy2v8wemFzwTNx11WAjglnMT5
	1tXK90xlcUcONPolIujAr629KlagXW68u8KcZOJBpylENRtJ8JM2KusfyKlJBQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH v2 0/2] serial: amba-pl011: fix RS485 state on enable and
 reconfiguration
Date: Sat, 17 Oct 2026 08:18:02 +0200
Message-Id: <20261017-devel-nbuchwitz-pl011-rs485-reconfig-stall-v2-0-6f457a1ee527@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OSw6DIBRFt2IY9zVgqTYddR+NA4SHvoagAaQf4
 96rdgcdnuTknjuziIEwsmsxs4CZIg1+hfJQMN0r3yGQWZmVvKwEFxUYzOjAt5Pun5Q+MDouBIQ
 oL2cIqAdvqYOYlHNgpUV5qrXWCtk6OAa09Npj9+bHcWofqNNW2IyeYhrCe3+Txeb9Fc4COFheG
 2lULWSLt0Qjgcd0NMiaZVm+y2vP1vgAAAA=
X-Change-ID: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae
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

---
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

 drivers/tty/serial/amba-pl011.c | 66 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

