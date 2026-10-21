Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583135;
	b=Ih3r3uMXXSG5NKggx9xka1NLDeU96ITotNmAJ8J77EHbxV8eVDbe/nn3HdoFwIResiwN
	 Q048KszvnCfEIB/OBO8kczpKlsys05pl1Z8iPtgo7U6Mxns/33mjjjnvSTiZWl0VPYHpz
	 2wcnSKPHITc0AWuLuWiv5oxQQsDB24CWF2N/SSdCVceVzemXPK9V5/Ogr+mekOKM6GHW/
	 VZ8yZonXq7rKM220M5ID7R7HlTS27vyQ25AOVmUXw0iZBrWe+OAJ10a8sBNISERBivHJT
	 qh2QCjB+FL9L7EGeKdMPGbx5J0wuccX+SFHZJLNu1Jj4MWBxVnwFmiwtxNLl7FGSTew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583135;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=yRt4u9j182T5q3P0b2GaXBS03uQ3Jfu70UBYjUTMCCw=;
	b=VaLr0BrtPPdDCbUWPDZmpIfU5gZUspOYeNbuxXjAUWMga6D8nxlM3nnGFYS4FYxTPtr3
	 BOrfOkInckz2pz9zkrX8MVIjYobZ3mYm+FBcIWyMwub8SqlPoYVjV5zyifYDZAOucf+3H
	 CaPmsLcuEBckVgBB3FPUyJQYWT8yffkcVIs1lovcvzHPyncBaYqxZ1Ua+MDPTVDt3X2P/
	 rhh6VVoT7jql+IggB7CNbdD9xg5NWLKVj3Bes35HAwVZSeqx8kqeSX/OqWymLJTizfyBB
	 1mOk5JdgcTOW0EbMNDUwhailG6Q5zytPMJV2K1M5PAd7JnMg6IeHexSw3lpPhhpZM+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=CukU3TLY;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30F606A320;
	Wed, 21 Oct 2026 11:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D30F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=CukU3TLY
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98F94A1624;
	Wed, 21 Oct 2026 13:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792583130; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=yRt4u9j182T5q3P0b2GaXBS03uQ3Jfu70UBYjUTMCCw=;
	b=CukU3TLYO9HWcZFecSkWeW7dUh67urBkzlkz3f+ySXu8GaorxZNwk1FeJ5dCS3lfimpCKh
	ATbSAR0CrN5uS/1Y++z47MIMpxaMJyDLiW8+fVh6lvCRs9kjd+XqryMyBniQiexerYBpi3
	GqsRPinUL+j5LfFrU6qP4E68yv3HkiKx8wUbQLoNFvrCgpYJyWljB6QrNXtb/USK4g3sBY
	+cK1lPcDTMqFkr1c0GYhDGLIgTusRpYEMBydUC5u/1PMT+QbMv98rQt8x5eaGO8/zpsgyu
	ltDTxbwNVHYqJONun2a3n3h1zjliHdR/zZCuXajTL0ks1i46RLwsK1ZWWs3paw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH v4 0/2] serial: amba-pl011: fix RS485 state on enable and
 reconfiguration
Date: Wed, 21 Oct 2026 13:45:21 +0200
Message-Id: <20261021-devel-nbuchwitz-pl011-rs485-reconfig-stall-v4-0-ed10e219159a@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53OwW7DIBAE0F+JOHcrwNgkPfU/ohwwLPFWFraAk
 LSR/704uUTpKT2ONHozV5YwEib2sbmyiIUSTaEG9bZhdjDhiECuZia57AQXHTgsOELoT3Y4U/6
 BeeRCQExq20JEOwVPR0jZjCN45VE12lprkFVwjujpchvbH+45nfovtHldWBsDpTzF79ubItbev
 4aLAA6ea6ec0UL1+JlpJgiY3x2ydbrIR1y/hMuKd1612gjEVuq/ePOI717Cm4pzLc3ObiWa9un
 5siy/3knwGrIBAAA=
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

