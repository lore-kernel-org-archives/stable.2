Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF31FCFEF;
	Sat,  4 Jul 2026 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783207602; cv=none; b=c0LLL3foiwQ6/kcEjFu6sfVNawhRhurMVmLFud3kxf8CPmbEvYbcGJgNBYTiE5hL4yGMM69/bP3MDxDnsd53J95i8qkdCFT/1R2h7lgZ5TLKJhnUVGCAr1sEI+aSFqSFuKOZ4loR55FS3X2HmzFSWB3yU/JMug6EPkVFM87vZxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783207602; c=relaxed/simple;
	bh=dqyi4H1QfCO6t8BWj0SOFpFGmhIaThrFFKY8UI98xPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbDfd9Xt8wp07h7Cy+3sSdOzy2kUqoGHe6wHsf3Pp198AN0kjZk4Y0+4eY76R3kgzdPhVR/HFwCbwHmxSkSYmQmakkj5QHueiTT02u/E2asqkJhwiuSEo3asqaT4IYf/VKv/Onj1aqe9OdDQJdW4XVic42JPzvW5v/hWD9UY8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=k6wk/0la; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b="k6wk/0la"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1783207598; x=1783812398; i=cito@online.de;
	bh=OLdp1pFl3tlNvABCHolZBLr1yi0shAiF0uvlw0cd7xg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k6wk/0laweDcuwtTOFW0cNtW9P3Xxa3Rzk9O76rzpHZI0yisQH7xcKWeK9gDFIWK
	 BYaKp/HeyIWwY8ZHGQzgggv0g4ocxWcV5Db01uhv8i1tIKv5YIy0Rj0NLsE/++qDC
	 4d8f6ilA9+kmh5NIgi5WSDVUK3PXapTDdv/eUcEUbu5k1jlYiukJ1eLJsK/88cWJH
	 Ri18TpI99KTz16RmOyzqpJ9G/rrBrdzWiTx4J3mhTIlCIA1amw1L8wmuHBTHFpwAl
	 JuIzo14efiV/MJpzkQJIgqGnxMGxTC5B2pCE1RyU621znDEfjhHu40TiRNnVz3jtP
	 pmd9ySRqqIGCBR26IA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MCsHm-1wozFp1b2O-001ozK; Sun, 05
 Jul 2026 01:13:29 +0200
From: cito@online.de
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Christoph Zwerschke <cito@online.de>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add ASUS USB-BT540 and USB-BT600 for Realtek 8761CU
Date: Sun,  5 Jul 2026 01:13:12 +0200
Message-ID: <20260704231312.340274-1-cito@online.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zycdu/o18sqmVRZkp/YCpzKX2kW3FCPjOkw8Q2UZzTEwY53o9Ld
 4UG9OhcDrcjLWtNmxMPnCGYxp67/PAlGpGboXwmpIAcfMbt9/sIvU8fApwKwDZ8+/K9CB+u
 Ci9vvsL52Fwcx3Pm1RzMhkfW/pfNIH603vuZ6RlMNTG0a8KKK9rRkedbecR9l9BeThR/Qi1
 sBKDyhFM83Fbkw7MGHIqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xFKsDnL1uJg=;nFwGVITr2I5FszI7OkMjZAfp4t1
 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
 Uq28XrSQ==

From: Christoph Zwerschke <cito@online.de>

Add the vendor/product IDs (0x0b05, 0x1bef) and (0x0b05, 0x1d70) to the
usb_device_id table for the Realtek RTL8761CU-based ASUS USB-BT540 and
USB-BT600 adapters. Both bind via the generic Bluetooth class today, so
BTUSB_REALTEK is never set and the rtl8761cu firmware is not loaded,
leaving the controller non-functional. With the entries the driver loads
rtl_bt/rtl8761cu_fw.bin (already shipped by linux-firmware) and the
adapters work (tested: A2DP and ASHA).

Similar to commit bc597f0cc44f
("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV").

Both adapters share the same descriptor layout and differ only in
idProduct, hence a single patch adding both entries.

Device info from /sys/kernel/debug/usb/devices:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 22 Spd=3D12   M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0b05 ProdID=3D1bef Rev=3D 2.00
S:  Manufacturer=3DRealtek
S:  Product=3DBluetooth Controller
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D 23 Spd=3D12   M=
xCh=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0b05 ProdID=3D1d70 Rev=3D 2.00
S:  Manufacturer=3DRealtek
S:  Product=3DBluetooth Controller
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms

Cc: stable@vger.kernel.org
Signed-off-by: Christoph Zwerschke <cito@online.de>
=2D--
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9b0b1dcc1d1..9726a007d25a 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -856,6 +856,12 @@ static const struct usb_device_id quirks_table[] =3D =
{
 	{ USB_DEVICE(0x37ad, 0x0600), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
=20
+	/* Additional Realtek 8761CU Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0b05, 0x1d70), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.55.0

