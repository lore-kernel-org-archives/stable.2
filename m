Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794497137;
	b=ASnwWmDZKeAAdzhQjmlmknZWsnKGgAb+xzdVfUiKIAYlZP9hJRt5Vdb2RSfaT11ptJlK
	 vsurqvjIjyxkBW3WOMnLnTV2x8TY5y66UylmUsyFZR+JSMPR4ysM8sv4Ls6RXpRPvin4v
	 ykG+du3vvDurNsQs6hwJjoQyJILOcqajNWMwfISXi2Zy44hh7GPg1Syc/HlMXEkOCeTMY
	 OpABMkV5xfQ/Zq9foN8vtR1gxn0wwqC8gbDyauoMDUr8HvuinBzd1XNrwJ7jesw1dB+RN
	 5I9D+HcDf0bKDH12RW1Cr712I0qpGq0igKXdirgR7lsDNPTgn8tsC7uGYs8RR78gfZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794497137;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxUusV0kxIEPkUTlkXJ9JrwRF0G1sxRdLTr9R3f/yFo=;
	b=tkpLxoqS8NRN6BLVFqIhJ4GQi67qjtwGW6Z/ZH8FcgBJr+spIlOqFinATxrZCh3qznEZ
	 eTpSsbjfXC9Ajm1f2LJguXG8xoIT3KtW8efMC2t3SeYkCp0LYWIfBOhKgh+bC8cBGWglI
	 lpcHmz70zHt6R+5zatdutOJdfbzRxYEzX0VLyMuJgrifoXroSh476ubcVbmJmt1nEz2L3
	 VlXjv5UVsOoUOBwtwVO4j7QK0BmI24B4/OrSYLgeTlLdmf/1REpJtOv7EvGCxFRtZE8js
	 MZ4TzSG43TjVLkApz4DCkIRU9VCtL5FKDi02VkKNG1/d+q8TKB3FZD8waMKcVvbAQeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=daanbouwman.nl;
	spf=pass smtp.mailfrom=daanbouwman.nl;
	dkim=pass header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=Ow7w92ga;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CJbjg1KA;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E42606A339
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E42606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=Ow7w92ga;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CJbjg1KA
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B4E41400060
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:25:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 10:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daanbouwman.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1794497135; x=1794583535; bh=OxUusV0kxI
	EPkUTlkXJ9JrwRF0G1sxRdLTr9R3f/yFo=; b=Ow7w92gawUnE7FyqxNasB0cg9a
	5qz7NejX0ijBnpfPsGmDbarw2ErIoq0/pNClm4WMsenLwwdn2XjrabGZY5jXHx7l
	fo6xmNskLtxyWE68O29JUlrDKI92HsYt4D59tTAsy7Q6dSgS9EQGiBtO1p2Xdko8
	ycAHfGmTLem8Oj0QJUDWtZKNl5s7o6sG/ijfxR/5apRztqC/ipbmnuJrbI18GAxX
	eqgKqgeWHEcossOqOiB9gqST5D+63TuTWYTH7q18WRfIBV6FsXnkVKGyLR0KUCmi
	7ESnmiSA7AlQcSZRhoOTgW/ba/QYI/nn6qakZdz0TIAWf/ikCZ+9tD70Pcyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794497135; x=1794583535; bh=OxUusV0kxIEPkUTlkXJ9JrwRF0G1sxRdLTr
	9R3f/yFo=; b=CJbjg1KAQPbJ2Z4FO5NPaEqx87zFRMqR97Sera5Aw9bAMRLMID3
	xa/FZK7NNteqlfz3hD7AQYoCwouyWcRzJHvqJqHz1mXsRCw+VNySUBPdX0NS+D2l
	EmgfJTqUU8iAwkSpszyKstuaHwsZ7/RNBaPwuKi+ZvulDu1arHMDcQS1e+MKyuTH
	Z54p/WyeN8cVKqUEbPm26DlLHWoDJqeNCAaxdbtyu42kb9NQP4BzzdXpqEoJJGCd
	uVnbTngdYodeTbASFeDrTeL0SJru+489UxKu8mGWUU1H3ASlJsN6TpD1yhFniS6j
	ZTSfcz/OilLwNLXkdTjPNgQPSC6rvinAQWg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=daanbouwman.nl a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794497135; d=daanbouwman.nl;
	mf=PGRhYW5AZGFhbmJvdXdtYW4ubmw+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hmjnWqqyM8sI5dCgcRJlq3AKETy4kkgnO/2IPVIXt7MG+Mi
	EhbzGcS7yoscuPAXsymafBej9LsnXkIUJqo3M8XkVwr9zphbuacDFUISBhZqNMKz
	b4cN5Oh5b0LSs2UGuFOn4D1lt2Iqtr+m3t7CiccRhjZGtLCPzDKNHM+t2vrnNTLL
	bwU3YJq7BqJFR79BL9gvwiI3kHujiTrQ1vkPufPnMWQE0L8w9gktihL4ejaNrBsF
	jYq+MKJZ9riiDCsWSEBetuo+cK1tjSeEpWiOieIt3P8BxoCZHNizH47VGmJlBZQC
	KKLeU7vaxnV4fzMQEUs7WTRb9f4yQHtmHVJQmfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:dM4JR5TwGCN+oN4b5/XHsK6jee3EK7CnlSX52D+2uOc=:c07zY8anuh8g65MOjUyinIH3uPh7GfiWUgtFYb2C6YM=;
X-ME-Sender: <xms:b9r1ahtpgAtb97TN6i64EaokK-Wm8JZZGetto-Zcg00a5Awd-qPeYQ>
    <xme:b9r1alYhLyKKagK9y-PYUyS7xkwau5g9HO0lQtFxF7MfZuwDjGhbeY1ZWHay7Kq6F
    cNYB-R2DR-uVYDqN1flhBokL8u59pCksiD-Hzq971oU7WCcEcYDT9g>
X-ME-Received: <xmr:b9r1ajzsVEO-JW1f4ooRJUfpmN2VN1562BJeyjnqFeljAJKWc8YTeOALFg-uOR9La38tKudIP9g5DokLy2A>
X-ME-Proxy-Cause: dmFkZTFHexHi45wj/oZspy+CZQF2pB4nZvnJvxqOtKMoY9ys9kyD+9oqLgL3XFFxTuyKFb
    t/rBBLZPT0hTW7F5dS5+BOfN2ylM6Oy3D/qcX3hNkN90Qm5BNilwPL7iW7iaAmoGU9zzMF
    UJ8ddHpua4mQpdkU4YQh7fe3n9x7mVnaH2UvL5BOCvf1RQ2Ttj4A5p0ZzJwwyx4+Fkt8vN
    uVtudbNiZ2NsEPbPd5qRTP8rLDlDY03Tz/ovfJfyDNdO1zVNpUAIF6ycBA7oI5mGde2ly8
    OlFne1TdRx7UAU7gjlAnUCM25nI/qExGuKBI7wI9krNo6bifWobmNyI+xaPlTlPN5tUvIZ
    6pxQcWprWApG8JS9hwNb3P6vdDzoT3vaRqTtt0C3Qm6TKIo80PC3EhXv6UK9QGbt002QDy
    Rtk3d6e+VwAsIllTlUu7qiBrjtThX+KaaHBqCUrTrWkpgoPPYRsl3f78t58QJ8whJGUPHw
    n2FJPQYx+RhkNS6sexDoiEHf/RsO9xlXdhsrXlEqgW3+IphbXtX+XQU9hT3ipvFvGjb8ew
    GAIyo4lfJr9HUQtMmjEfceJBCQzrNPEYJKkIdGVtYbMnWnVHfnW+ED+bjgvjPrvd2pahCa
    p7yvJQ16jYxz6VmqpOGJs2v7/SSpUJ1ASXwS+N51/bqj7ZYiM/9iKu6qHawA
X-ME-Proxy: <xmx:b9r1atiBhMXhJ26EaspQfJZb2VllweEZCwFDAV5wFN8U5PXPf57sUA>
    <xmx:b9r1avk0dxRiUyhEYmBrlbF_eicqB7oe3wGocITIRWfxG7Mbwr0dag>
    <xmx:b9r1ajiylCITzedlKfvKhrE3-gO6HQHqte5KDXWzjf0jNqXk03yMEg>
    <xmx:b9r1aj0Gw3Q1QZwX6gpak4Oq0hrT1-5Ynh5vXjiyAIoaMNytLY5pmA>
    <xmx:b9r1aj3VMR-FZwts2UVRzwOfDYjxb3OVwvhd-BFc2vOD_u9_l5boItqr>
Feedback-ID: i83ce4876:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:25:34 -0500 (EST)
From: Daan Bouwman <daan@daanbouwman.nl>
To: linux-bluetooth@vger.kernel.org
Cc: Daan Bouwman <daan@daanbouwman.nl>,
	stable@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
Date: Thu, 12 Nov 2026 16:24:26 +0100
Message-ID: <20261112152426.10335-1-daan@daanbouwman.nl>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Microsoft Surface Laptop 3 (AMD edition) uses a Qualcomm Atheros
QCA6174 Bluetooth USB controller with USB ID 0cf3:e303. Without the
BTUSB_QCA_ROME quirk, btusb binds to it as a generic controller and
never loads the QCA rampatch and NVM firmware, leaving the controller in
unpatched ROM mode where BLE connections fail with "unexpected event for
opcode 0x2005" errors.

With the quirk applied, the controller is set up correctly:

  Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000302.bin
  Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, firmware rome 0x302 build 0x111
  Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin

Add 0cf3:e303 with BTUSB_QCA_ROME | BTUSB_WIDEBAND_SPEECH.

T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0cf3 ProdID=e303 Rev=00.01
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Cc: stable@vger.kernel.org
Signed-off-by: Daan Bouwman <daan@daanbouwman.nl>
---

Notes:
    The commit message was drafted with Claude (claude-opus-5-5); I reviewed
    the change and tested it on my Surface Laptop 3 (AMD).
    
    Tested on v7.2.15 with this same ID entry applied to btusb, after a cold
    boot with my out-of-tree workaround disabled:
     - stock btusb: no rampatch/NVM loaded, HCI version 7, BLE mouse fails
       with "unexpected event for opcode 0x2005"
     - patched btusb: rampatch and NVM 0x302 loaded, HCI version 8, BLE mouse
       connects and reconnects, no 0x2005 errors

 drivers/bluetooth/btusb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca..f44b44382 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -288,6 +288,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe301), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0cf3, 0xe303), .driver_info = BTUSB_QCA_ROME |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cf3, 0xe500), .driver_info = BTUSB_QCA_ROME |
-- 
2.56.1

