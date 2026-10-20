Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506830;
	b=HPiGcGOwUFcckhjvExcVTHqi/klFoQtgV3utgw8zWxR90QohDm62lA+GVgAA9NZTFPj9
	 f00xqqYt9MAySmAS6XM61z0GsdNIsbP/AmfvH7SS1gATnWdlCjfSxf074rxwDo293FamX
	 PdvSFDLJR4Ct7mrDfTizjtvwwalb6q4fJP3SsfEH9WBzXmMVgQDlq4N8GUre5x9t8gnwS
	 EbfTbLm4iNwsXdNUtAIR5wmgyI73jBJ1JD3xZUCNuaekDQOU9vJ27thbQtRxbbjRUgJpX
	 /sRU/eUza47vMptZtqzLF4e1MoRGGofmr8Ik9syixYEmyvGLXxM1gwm5ZTzQCeuulBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506830;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=x7Sl42yeepISEq0WkYmBoaeazxIEV8OKcTuneJ7Mktg=;
	b=jq4MpIIpT1NcSV4OsFL62Oq4CKKCinNuCvoEXW2WnP4doPxMB2KY3g9jak1jd9ibu532
	 WCWnClKuv/SFuoOtJkaa+teEaCgM8JlprEed2fJBCSUuylCwl07IwsGbBHn8yv9neM+4G
	 LHSOTBxFZADEK1CerLeCMKIw+7ctb0wI0rN9Jl30Gx08VG2p9HWJTeI7TsrIR8sh00+tG
	 4UkcKISvinb+vp7d7TTJfsm0Q2CmbgrrmdCydSllmBxX03kp1rVXb20Xs02rRqZUloPJj
	 iD9xRULkVdvzaHikoQLHBR1WsQQMWiK0ClvPpBdJx3jDubJeeboK3SzJzvqVps8F6QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=q3UNx2RS;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1769606A326;
	Tue, 20 Oct 2026 14:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1769606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=q3UNx2RS
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E293FA1579;
	Tue, 20 Oct 2026 16:33:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792506826; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=x7Sl42yeepISEq0WkYmBoaeazxIEV8OKcTuneJ7Mktg=;
	b=q3UNx2RSDKB5JVCHsQm1Bxs5dD8ZQDrMyNO7WzdPsgRN/SXHForTIZ0DwBmpikGet04ywl
	eehd+JVPgK7jyb78fPPNWY5fv9rk2oft9PkpzIT+tuFVOjrKdMg0dbldWzBx7T+iwjHAg/
	boFs3rcj++NQGTVQK0S/hFntTWIZvO9cfqx8j11ol5WUMYRLZkfWZLkVNL0FIAVFwGr4wJ
	pjr3a/LIu//CaGO0WfDyIh8pHA2w4QQGGC4Ves/9/HAe3Q3b8DbQ1N+wKan2NmI/z8dhkx
	FFZYMMIitu4mR5rxOahsb9gchoeJmXeOgm74Scm64F80njwIbX3XkVcFqtc0oA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 0/4] usb: usbtmc: fix undersized high-speed bulk packets on
 xHCI
Date: Tue, 20 Oct 2026 16:33:37 +0200
Message-Id: <20261020-fix-usbtmc-short-packets-v1-0-903f4d029193@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW5gdxWFXiW6WKeTjpHKzhqB+
 O5tdfnBOf9OhqQwOlc7JbzUdJkL/KkiGeM8gPVWTMGF1rvg+K5v3qzPT2Ebl5R5jfJANvbSINR
 1ROM6Kvc1oWx/6cv1b9v6CZK/PTqODxCrGBB8AAAA
X-Change-ID: 20261020-fix-usbtmc-short-packets-1c4e233ae407
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steve Bayless <steve_bayless@keysight.com>, 
 Guido Kiener <guido@kiener-muenchen.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The Siglent SDM4065A-SC, Rigol DP800 and Rigol DS1000Z (and probably
others) advertise 64-byte bulk endpoints at high speed. USB 2.0 only
allows 512, which xHCI correctly implements. Unfortunately this breaks
usbtmc on these devices. Reads stop after the first packet, and longer
writes also fail or hang the OUT endpoint until a USB reset:

  usb 1-1.3: config 1 interface 0 altsetting 0 bulk endpoint 0x81 has invalid maxpacket 64
  usbtmc 1-1.3:1.0: Device sent too small first packet: 8 < 12
  usbtmc 1-1.3:1.0: Unable to send data, error -110

We ran into this in our factory once we switched some test PCs from
dwc2 based hardware to xHCI based ones. dwc2 uses the advertised 64
bytes, so the devices worked fine before.

This series adds a quirk table to usbtmc and moves one packet per URB
for the devices in it. The DP800 also wants a ZLP after a write that
ends on a packet boundary. Only read() and write() change, the ioctls
behave as before. More devices can go into the table as they turn up.

The Rigols still have one issue I can't work around. They split replies
over 500 bytes into several transfers, and a follow-on transfer that
ends exactly on a packet boundary never arrives. Raw libusb shows the
same, so I guess it's another firmware bug. Should be fine for most use
cases though.

Tested on a Raspberry Pi CM4S (BCM2711 xHCI) and a CM5 (RP1 xHCI).

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (4):
      usb: usbtmc: handle undersized high-speed bulk IN packets
      usb: usbtmc: handle undersized high-speed bulk OUT packets
      usb: usbtmc: add Rigol DP800 and DS1000Z to the packet I/O quirk table
      usb: usbtmc: send a ZLP after a full last packet in packet I/O mode

 drivers/usb/class/usbtmc.c | 87 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 11 deletions(-)
---
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20261020-fix-usbtmc-short-packets-1c4e233ae407

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

