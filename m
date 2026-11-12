Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496982;
	b=woXmgnZDRBOCP7o13LP16Fj7o2FqowrhGQonJGgXlXS+f0r0m8ewKSFri9su5LrRQw0/
	 TGD2RJQ71wUni43tBupK+bDCqi2TQKo28v5q2eYdCjr1EPeYudJOQgR38itkT542KjTRz
	 j0acy+HC7AFtGI3sKiGeYebuyxlHup7t/SPRf5mSavLEIN9RAhT4m3dPGA5DfBLTMHkvY
	 Fx70Ur3Uo0UUGwI4kPoFc9KMpkrcu9S1my9bHvlXDahGjQmggieTgMja3B8cEZxcuk2VD
	 IC8GQq0k4lwYjmfp2QQ1W7DILH9yWNjkwIrLgq5Qtt1GU5Qh1WLeQYPo6MQJ8/3cwzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496982;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxUusV0kxIEPkUTlkXJ9JrwRF0G1sxRdLTr9R3f/yFo=;
	b=MP4Os+lwAlQ56tVk/aGSNHxTzTYkjQ5maY43VGtHf7+FIIkfb40iUw9bByzL/fFWqyPR
	 VMUv51FZyFgMKQ0KX+MDeVzYCSyFF2VO/Lpn0fpaW7LBLmuaASgBxJgZbdK6aZ+2Bf8aG
	 xB87LbVb9hw2PV5aulHljYE1hIM4Ufd08lK3qm/A8L0vk0B1EEtkpNUy2OMXrQuFJD9L/
	 iE1Rlz8vD9z53x6p6cYRh9rB/M/tzOEoWQtqcJnDhf7FKmNKeb/jCFi5AwlcMnnHkw6WI
	 /PYkABTW0dd0j6xF1J2IZf4OMUBHczvABpbTDkCqmRS0dTpZEGuyC92B3WMgQH/eGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=daanbouwman.nl;
	spf=pass smtp.mailfrom=daanbouwman.nl;
	dkim=pass header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=i6h4XkC5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=deiPRmHA;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006060A3827
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D006060A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daanbouwman.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=daanbouwman.nl header.i=@daanbouwman.nl header.a=rsa-sha256 header.s=fm1 header.b=i6h4XkC5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=deiPRmHA
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3547140005A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:22:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 10:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daanbouwman.nl;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1794496979; x=1794583379; bh=OxUusV0kxI
	EPkUTlkXJ9JrwRF0G1sxRdLTr9R3f/yFo=; b=i6h4XkC5048k4nTY01QK5fAs5L
	5qo7paI8pPNsD/7SnwU8z4pGLAUsv0RQKw/joh8oe/91JcCU1QUJvIceIottVcMa
	onv0oxfqg472AVSTidbukWWy5XF92wFwlqs4YxkkKwYJURjKbzFIDXgf6UDWRuCG
	qzX/kNc8rVpQcPpId/8cbSj9J8FGm9RkQ+i9DXuWTdSheKzuWB6+/nQKSdI2DDou
	gSQ1n7Rskrha1Ljef7I2U0CUvriisUFZ3oyZ5+qG2Mrhx02mY7dsPfOm9+H+1oMx
	oSRbM0xsnQ9DvQxUfOmpUZ7KxOizs0RsiSbuLhek36q0v7XF9BMaAonb4vFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794496979; x=1794583379; bh=OxUusV0kxIEPkUTlkXJ9JrwRF0G1sxRdLTr
	9R3f/yFo=; b=deiPRmHAWa7ohBP1wxbrRJr+KAS0yClgsTeKt+08dB4LcHjy3mi
	+jkgYpvx2pU74inAPM3l+6rxqSp5a2xZMIkMrzYvjFVZ5870htIiPXE2N4Lp+/29
	9K7iKCR7oQep4bKghrxLgiJ8oN0j09pDqVQhL69LJHILwX9To00Oz4iCCek3CWqp
	rMlMtwuCRW2jkKHKTsGjc5vC8XXRzQqnNo513qnz7gHareLJzzIpgnv8ed9wMaLO
	abJFA7mkQTbrha3bCZ0gh9vuYJUKQ9RQQt5Rdqi3DXc06vdsb5JlezOajMIkyo4m
	BPkOlwPUoGmT42vrQX5nx6N1xRgFfDxxz/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=daanbouwman.nl a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794496979; d=daanbouwman.nl;
	mf=PGRhYW5AZGFhbmJvdXdtYW4ubmw+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KkDdIk2xxtpYTe8nPNxoJRX1PVEvr7a0htLUFzSD1puBOI5
	hc0rBISmFVJgkUKt65kF5Pyna0aQU22uq6HYLVYGHMB5DM2rvJHxrrTklx4Xh3GG
	DyLQixtdfm5x0dr8D2ezlletMzzlnvuOqKmQhAuyp0iIWdKdGnB0yu3wkL2v4US6
	xnErkmgk+LYTRkTcFxzi0WD53dNuAO+xT002xR5I6vXkrfvLrM+rypUvWlTOfy8c
	YYOfUwGjtYKLUcSNv3KPYpAkXwQkw3L083BvioexW4ILnmHhcimZ1gjnGuT9jXmQ
	6kaLC3MOuznXMDN7m1xaNaq4ZM1iMTwLTQr4BDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:1SITWTvMZYYmgGUY0H/VyIFTLLIW+g8EYsau3qOY2hQ=:c07zY8anuh8g65MOjUyinIH3uPh7GfiWUgtFYb2C6YM=;
X-ME-Sender: <xms:09n1aj03ELFkNCyj0lmqsynLLYaHIX1RdF7qP-uIStJFVDhEcQAN-w>
    <xme:09n1aoHyV6ClFjrq3BXN_YSxmvfNi26xTF2xolUpo5R9Q4AP0TWlGEm3ia2FEPyM8
    bbMQ99giiymigdzpbKaNLoiQ_HtgSrxlP7WZhA6Dm0rhObyIPJZxFeK>
X-ME-Received: <xmr:09n1ahgdh-q34NDLZ5KS45Mbnq51Q02R_6ViwSfw5a1tv_PvMyz-Fn8bj8-6y5FjGxcn_7JlU_3b0A81Zt8>
X-ME-Proxy-Cause: dmFkZTFQicci2EoC1yymtm75+5PpcTExPHdvuWcYqijBrTi9OjoDz8VZDp0arknqhtb7YA
    kM2DoB+GKCAm/oKVhTPuq9INtVWiBQG9H6+s1OchriCxdKnPLzVn2347hBvMudHSHKtyd/
    AABKCkiMQ8JAtEZ/4bIesc0CFO5lEeuoxSHCi+w9KzBjon6ZHURpOwTkZtfjNgqhVbhT80
    rfsWDjFaAQ9fl8V2rgy/PBNlgniLFQsgv/+QrA+mdqH6xjpfeaqfzaorWk4hmzauUEcMmR
    mDENH/LJmrOMrTJOn6DvRyqgR+DBDSwLiaDyUcqk5gfJ1pQhRFpsxFhhWoDzNwPsBJrTD8
    dUYG9IKTmGDzZzv+ZBmu3ysTWFvZiFw9gQQstFp31hzI/Icd82I6y+lzFK8wwHgN5CbmOC
    uRuW7rNoEhXpbWDAGR2wpWA2JIg5+oI7Ce0GOktFSoJjiztas7R6hGH24YfcTVCqdg1oR5
    f1ASmtSK/1RsDN9nDUu4h84yb5wySkM+dCK70ChbEBWlAKS/i/2Buq2MG8Eg6vJZG5eaPT
    aAroYwOoA501FxaRKRIrqXbJZfh9w8wjpgR4qaP6xCCcBdFkehN3lX9zYm/441s6R63qpF
    RXbYxK06FOQ3y1JXxW7lJBUsmC9pwRjWElyV1ORjzCCW4H3hOmnsEvC7sxZA
X-ME-Proxy: <xmx:09n1aj88pQn1yXk7yXddjX4HMi5HWfdd7VZUEkBwLcpeRU65Kbdr9A>
    <xmx:09n1aoq-VaU3ZmFjIkKt-JIwhRAksN1luv3sR1XR1uDfsFDQP2LRPQ>
    <xmx:09n1ai8Igl9B1G6CnrRhI1X1-sTtv1LHD8pU4USImLI1MMhrThHRfA>
    <xmx:09n1asVooKYycDEWhupxclL4WZ4K4SPDlaD8ud6PEjRUGQNk9fohzQ>
    <xmx:09n1avOnSmkuokfUKGORwpZg5NEW8Jsd-6XQHuqxW-EdUcwXXgB2aJoI>
Feedback-ID: i83ce4876:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:22:58 -0500 (EST)
From: Daan Bouwman <daan@daanbouwman.nl>
To: daan@daanbouwman.nl
Cc: stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add QCA Rome support for Surface Laptop 3 AMD (0cf3:e303)
Date: Thu, 12 Nov 2026 16:22:41 +0100
Message-ID: <20261112152241.9570-1-daan@daanbouwman.nl>
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

