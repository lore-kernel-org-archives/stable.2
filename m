Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC713BB139
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358061; cv=none; b=IaEGsKVvJ8N2A7VaA7OaF9bqAASkBW6oee1L3l74jS2CGmXW1L4u7PFmCf/VUhS29zEcJdWPS6eQrIWw772uRCAXRtD6PwzAz3OGFhDMGGN+YjbMFdAsbpmUDQdHPAn300/QW932Oi154ALVgIhHIzvSIe6M5LsNQb9e4Jn5yYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358061; c=relaxed/simple;
	bh=PkEqfw5BtLdDnZYry2g2/pwCtnDYFA3+IyO/9jzcKEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3Fkdu6mfvmhmh0wyuo/5iJRHtQDt7xy7TrW7xGtWtCZPtCskDZDnN9TkSG9NHnIqHNzXPqs82E8LL4c/2cxFCxfRrTKP3Pm7+hiZKIpGKTQm4kA0IpydsZLMhVYy1bshGyvCUfUbrXRzir66/1tF+1es/DRmz6VNHqXClelsl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXPz7jXa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXPz7jXa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so21419825e9.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786358056; x=1786962856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fLj1mS69X3Y7Lky/wyVZgHB9SawjBhLGJHOJwFF5I10=;
        b=kXPz7jXaFgEp9qvXlHYNehPtlANmvvO1EJ/XTJaA48W/UN/okSlqpnrOWFXUP9i+ew
         cKsbYMa3tZSqnWPVoB9muOTRxU2sR3NFanxTZVtmWWPTHWqLzz0TspUDoAthQPXdYBae
         SYxjCP0UgH0TLdiBosk4ct7LGu2eWE2Ilenk7AghUQ3GdgTOZx+9nOpWC02QAHYKRj0Z
         4qnAGUcF712UjkLOUpo2APB+TKnnYodRD83W5VXRto75glDKGbWo2Zk6C517CEBBiHM8
         fgPisDxeNFn95ZmqqtCbt7Wg1nfUoDCqpazBZ5r5TzhOORFfuasLe1+AZOSDa4+4xWsl
         7hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786358056; x=1786962856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLj1mS69X3Y7Lky/wyVZgHB9SawjBhLGJHOJwFF5I10=;
        b=YypTSWoNIJ0NzI0DFcRSXYSmbKeAp3XXEPpICkODpHehK8ZNpjauMyaYe+1BwCA7c6
         MupgqHir9ewSzeXRQMvwLkRlGemA8GInPgCBEeOVo5kG183QkVBlFvRcKIh0xZY2gl6V
         I8+i20YYVQ2Jy09qJONTDbaBMsuiEoouKt7BqD5q2fFB8DYG2Z1y6mISklH72yaFVHIr
         vZe2fBPL1sJWiUdGvjXLLa2L8s/EPoGMK3OKsgyXTjtNm2LFPWK/dezRlGZMR/2dME8o
         Niblfy9Syjf7BHMIfRuK2mnNc7M910se//G45ans2131H7NHj5PeYK14LqLjhABlaUZ0
         B8Sg==
X-Forwarded-Encrypted: i=1; AHgh+RoM2TDZFT6zy5NM3d60D/S8PYCnFpsDPLUJ9RhEfxlDM95VHiCKUWr2tc12JRCcOVUjR4LuL/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Md5Ry0nnBA4I96VxqvUhs2nGagoCIqQelCSmhhvp9yt4v/lj
	NqWrfnP6+xIA6UMe9RKlRhOoEWFAYj1bHsZv0Td8e4KFCMeUVc+sg20D
X-Gm-Gg: AR+sD1068Y+w/rrvYsAmmF/R1OZ24c2Y+5ZlV3DUnxihRWDBQCL/pFuklNOV2pZsAMq
	2rDd8Lk2RkrxzzAmNOuLGdNTDZrUNI9kRlhLsuhI1+bmG9h4wPTbeVZgR3kzwB9TDDuZi/JUlD8
	o5Ydn22QaoZFKQWc/FeCuuDyF4YxnqEpsXwP7dGqV1udnjNI37wg3PGOZIyEl9kz/xhrXDUw83V
	IF4NbVrQbcqnJ6az3eXiBRvEm37YkJK/1402qxDF8ceXMGir4dYTKF11Vy8Op5NuFVbDCK9CIBo
	v5VoiMciMypJ6fMZcVsKOrBh9QWo1BFeHjdLmO3AEMvV7LpIepKjgMZvZZJLTTd4cQCjQrPZrCU
	HiH4f0ZDYrgAoamuVNwO2mdAOWSKxMdkiX0EAyVrHpX/uAu7Bb9h1BYK7tOOnNGqDXIdAJNaEcq
	CRE7kM6TdDw8mBReZ44ZsbzT1RcgXcrICO5n3hKBKSwWAnjk8mnBGSVQwJtVbdSAl3iX7qV9nXe
	goso2bdaea8CWoyRjlr9yB0QEnqI6REbNo1e3KTtfjofzqOdWA7RSDCEH4hU5g5eVAE0+N8DBFl
	oqhZQ48qOAcJkQ==
X-Received: by 2002:a05:600c:6749:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-499727e65dfmr12164765e9.15.1786358056467;
        Mon, 10 Aug 2026 03:34:16 -0700 (PDT)
Received: from labdl-itc-sw01.tmt.telital.com ([2a01:7d0:4800:7:a04:488a:882a:de93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220727bsm34917350f8f.33.2026.08.10.03.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 03:34:15 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
Date: Mon, 10 Aug 2026 12:34:09 +0200
Message-ID: <20260810103409.133796-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the followin Telit Cinterion FE990D50 composition:

0x0991: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
        tty (diag) + ADPL + adb
T:  Bus=01 Lev=01 Prnt=01 Port=06 Cnt=03 Dev#= 10 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=0991 Rev=06.06
S:  Manufacturer=Telit Cinterion
S:  Product=FE990
S:  SerialNumber=2aa802d2
C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
Changes:
v2: 
- Add stable@vger.kernel.org
v1:
- https://lore.kernel.org/netdev/20260810102840.125473-1-fabio.porcedda@gmail.com/


 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 94cdb61dca83..147beaa61340 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1360,6 +1360,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x0991, 0)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
-- 
2.55.0

