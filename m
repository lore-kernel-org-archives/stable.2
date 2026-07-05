Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7F41E98E3;
	Sun,  5 Jul 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244536; cv=none; b=ewJ0+a4HV8vbATBkyJcuOd4e4mU3imPoZfoZXvZuhivZf2smP0cSIhEZja0XmQn8Lf4hOnTAMWZlM7c2j24JGitOdtbcX+FFOZa6g4bRj8FafWRKoqfNwQgrZYvvy6qFZDf+9r/Tjv/5yAwMlk5L114rl0Ga/CsrTsekDOhtLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244536; c=relaxed/simple;
	bh=ZBGK1DUZy1JnnsW4LV/3u7jU7jxCqAietPgRiP77l8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGzXn765x5kmjdw87ECqq5739uMrg+0V0RGswVq889StQReEnT0ZdrD9F4KFotS9RFDqfVm4g4AwpY5mhzHKbpuCgkrbdEayAPhmoOMHAhtb0SJA3p6AVIHHR9Zjr/QF90Rir4VBZptJ9zpQ5GuSFvQAB18iggpBT47xqrUP11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b=XBC9oJKx; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=cito@online.de header.b="XBC9oJKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1783244532; x=1783849332; i=cito@online.de;
	bh=YBT/Bgk6g7JRsFKZZBwuRTOgJDih51Z6UFhSee9f0vg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XBC9oJKxX+gmSnfr6drlEO9nv4Kp2UxdmBC+mYIfscL9mlmddge1vFUeNlVTniaK
	 5WdOJdztVCtyvx+irEpwj4tP8hLEJw2LoTEdh0zu7RzRblqW7AdVFpCrGBCj76i+0
	 aNbnU6cvc36NEKawQjXgyHvYjPPmZnAtpfJvOrlU6tKDkiUWy+vBtVR/sON6odAW1
	 quVNNWf73kJhPItC7tthfdyLeWq7wQp4dFxCEk/P/2qZivomhuGEIhX9dUF6rx4mj
	 kV3PrsCc3YL+cYUecInHe6SC0nAjA15eRxNxy9CPOm+JbcxehjrJAKKJzGXmgPqAQ
	 ZUG4M2VvHBdpwMVpAA==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mzz6s-1x356q47SI-00tkFp; Sun, 05
 Jul 2026 11:29:07 +0200
From: cito@online.de
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Christoph Zwerschke <cito@online.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU
Date: Sun,  5 Jul 2026 11:28:57 +0200
Message-ID: <20260705092857.27050-3-cito@online.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704231312.340274-1-cito@online.de>
References: <20260704231312.340274-1-cito@online.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JKClyuqNH2xEAz6rPmFdUZP4w4kAT3brWbo5jy02GsfuU/3byK5
 O0AYnwBxvAk+UDToHKhVBx+rj15TLk1oRow8nKwktYL2PSSDqZ/BipH728C9ZQW4363iBi8
 WlH0crH/n7k0V8fkG8o5CfPpKjt93kLzh6OI+ETJ4+ykiu/03z63+qP8vAzXzjfCugtFLN0
 6eWNAHAGtSxiY8ibwOp+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nU9UYqDc4gI=;5o2csYQn4vn/wSJBGAg/FYI0IH9
 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
 pLIFhNww==

From: Christoph Zwerschke <cito@online.de>

Add the vendor/product ID (0x0b05, 0x1d70) to the usb_device_id table for
the Realtek RTL8761CU-based ASUS USB-BT600 adapter. It binds via the
generic Bluetooth class today, so BTUSB_REALTEK is never set and the
rtl8761cu firmware is not loaded, leaving the controller non-functional.
With the entry the driver loads rtl_bt/rtl8761cu_fw.bin (already shipped b=
y
linux-firmware) and the adapter works (tested: A2DP and ASHA).

Similar to commit bc597f0cc44f
("Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV").

Device info from /sys/kernel/debug/usb/devices:

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
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c15c7ab5bd2e..9726a007d25a 100644
=2D-- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -859,6 +859,8 @@ static const struct usb_device_id quirks_table[] =3D {
 	/* Additional Realtek 8761CU Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info =3D BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0b05, 0x1d70), .driver_info =3D BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
=20
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info =3D BTUSB_REALTEK },
=2D-=20
2.55.0

