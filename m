Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CB449B03;
	Mon, 19 Oct 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401268; cv=none; b=p9ZWv5Sj8shUM/6V/YFV5rtnBKobQb0ZGWpzMEJeiSawpm8Lkg5jCWn6fIfm4qavP24iuc8+3twk2E8kffvPTuCSJkd/oyfmJaiXu+e2RLavABei2/js/D2vYhp/m/aWw2mK5UtSynJLZbpgEfvLeYCz6zmXl/YOOiW6iXEnbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401268; c=relaxed/simple;
	bh=HRGSTrSHynsnviEvjQhxfjGp1xTpWu9kyo4EYhM7j90=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pg/DenaWvXmea3daqw0hlUrRDf5Cn/yEAaaZvyEKdWpQTVE+7lxLcxDts/4OhQAVRf62ZucUqM7O2Pmp2Df/lVgqk1I7eNofa3hBPXrqmIxeLLV5WhBodqiujwysK0bCkUlDO+3zvX3u64P8ObGJNVsrqwNiUnrPaE9FmMStty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=03IMRUB7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="03IMRUB7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03E62A156C;
	Mon, 19 Oct 2026 11:14:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792401260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pzIwvYb1Rl23bi9IM3dG+sVjVhKxVQM8NmA2U+OTXRc=;
	b=03IMRUB7B0cD7klA6LkxUMMs+XOzgQNn40FwnV2HZLR4m2MQTiXmUTRBxxXOm63rXYih5n
	YG3PjeOZJMKcoyritYVSa/P0MY3p9qv4r8Izj3Fvnc5epYJ3CZNXaH+oZ9qh/ZTW7JMlT7
	LStofidkSU0akOlVVfc/8bOXOa3jEeUBpRbu9UYSv/cvjV8zx0AljXZkEwgiGY/KP3mlZJ
	c/avOmYEgRQ0oPr/XyJBoBG0JTr7fDCW3pfDQ7Q2S483tohZwdpyorze8v+BnpyZgwdFLs
	8ddQNMrVRYxskKoV7ew7WUcoksOrw28PDOfvzK+IOj9EJQKN6KTyJo0vtBGsLw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH v3 0/2] serial: amba-pl011: fix RS485 state on enable and
 reconfiguration
Date: Mon, 19 Oct 2026 11:14:11 +0200
Message-Id: <20261019-devel-nbuchwitz-pl011-rs485-reconfig-stall-v3-0-072a9c82ea5e@tipi-net.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52Oyw7CIBBFf8WwdgwgLcaV/2FcUBjsmIY2gPhK/
 91WN7rU5UluzrkPljASJrZdPFjEQon6MMF6uWC2NeGIQG5iJrmsBRc1OCzYQWjOtr1QvsPQcSE
 gJrWpIKLtg6cjpGy6DrzyqNbaWmuQTcIhoqfrK7Y/vDmdmxPaPBfmRUsp9/H2elPEvPsrXARw8
 Fw75YwWqsFdpoEgYF45ZHO6yE+5/kkuJ3ntVaWNQKyk/paP4/gEygQB21UBAAA=
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

Tested on a Raspberry Pi CM4 (PL011 on BCM2711) and a CM5 (PL011 on
RP1, behind PCIe on BCM2712).

---
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

 drivers/tty/serial/amba-pl011.c | 73 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)
---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261016-devel-nbuchwitz-pl011-rs485-reconfig-stall-f4fe437cccae

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

