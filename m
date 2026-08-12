Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829B2C21C5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 05:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513761; cv=none; b=fYfR2dbpKe+dz2IkMh43a2scdEm8N/RqC7MlP31h5JSWpHkjFyxMgjDIVgVbZWc09SQjm/xKfRfoC3vSELe9GDAcNKDxv8K46yTTHpGFwBt/eM95WNQXFLZcggO4HLWJzB4MaEgE6isNkjKJNWqjEndgx01p0FI7Jb6obHXrz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513761; c=relaxed/simple;
	bh=Rk3SJ+6I1pG7JyhWaBjV13YDNTCGyEH+MHwqLBNszuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NTNAFO23nOPUjSPwmhYY9cMD3z6hRlmHQOMtk/UP0a7SQsg26r9PlusNHjkppfRu6t9ewKneKkLOZFoJ2VMFCOx+uxrdwILK1+wmxCIxnU5yRibzXKvgENBKz5K3s6Lq3ST4QmF0EnZ0gDKhoDnK0pp5BZEAQZxR96VW3tCc3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHG7v44a; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHG7v44a"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49978908b35so4022065e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786513757; x=1787118557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZ1AxCPoNmmZ1LrnEeHkK+kSt/8EKPxv2MfaZqo0GaU=;
        b=SHG7v44axkhoKa4A92tKXyOtbmkswqy61d6WwTCsr6BaQCoAN14P7H5dZMAfOEX/j/
         93guZ5Fs6USMvZhYIS6nZA/x7tahzFZUgDmWGQ7srkZ0frue3ttAczGU5upHgGwZKojA
         LGQOe9ujlmcN+uuwbuw76tBIuN5JuBVCwCl4rm9hOcvLyfJnUzqsCgu2rAOzgJz0bNSi
         JShb2McCZsn1o8Kgtl9RMoSp3fjYNON/kwyzvOAGj0p29nO4/TV4jDnR5EHHZzNJ1MuK
         dKPITaaImpPQYq9ynijjrdhI4Vh6Rz4GlMn+y3YweI356la+0E3aci2VrAREEeyH0BIm
         IS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513757; x=1787118557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZ1AxCPoNmmZ1LrnEeHkK+kSt/8EKPxv2MfaZqo0GaU=;
        b=n4ZkllmmiGO/UIGMewo9yTwPVCgxtFQ5btQMP2kSzZbEXQG4q5HkhLQL3cFPJrqfwy
         HItxw0ZFgTPsb4Jh0bW958rQqqrlgpDIEjxhtxuBwpiyruM3cowuTr6vwX+cS+T1V+Qs
         fXfweDslOAHPoip/xKRXFgk+1ZQRZNBWhxnC76nINruGNi27eoEIJ2XwKTHPV6flnL47
         RzZX3d45PPJQzoEJwEc9GjJ2IO6dEEAWDT0KThlaixcnChrLJsqgPfOrUI+KUnyEg2pZ
         irM+uu3Id3LMCfzxr3CjV+gTGuOfl/8f8ILEaiMRiWIpcZ5mqf8Cg0m9XSRW0Dil0J6K
         EX0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq891tLvnmCXyHbs6/fEu/6X7r9+GnxPIu4Y6wgHqokv80VX3q7CCoNOiLnMC9cUTpe0vxTN9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKbOF9QD4nxGmFHFXwCu2wspmnr/tJwOzbcOI8mcjuhR2dZJW
	/fsglcR1zIK8ObYwuZA4UgBbApj85CBR3SG/ICPSa3ei8MjLRdo7tqk6
X-Gm-Gg: AR+sD113iUxHdB9DEEvZvO6a1Kv+OftIP9XnV7/ozD2Q2rkIl01C5/A2nATAt3VQufj
	YLROO6v/676LDkSBBZbUMGfkJ2SPMq9QvmZs9kykqP5XdaultSJNmx52+AkXS5k8XoJ6Jnr6TX+
	kMGkc31b0OJrA9ZPDAamHWlrjV357t11PJe4dLL2vw7ASUmdgtXprkhjXz3mJwn/iQ6dFPzi6W6
	CnfFcLQ+6l3yDeUngXvWHsvzHmj2xEZ0LwT71La5ITf6Lgn0tDfxvrGG76FGNm/4gE4XZqE6KSr
	k9G6k6uly6SxYL/vPyXAY1gKRlgXe7wq9FR0jhgg53TXvQU/vFgeOntH2FGjqcGRwTYd1Nbh9sy
	NEicYN3YP1AY5Ij0vdHj14o2a9Z5I6rLrMXmiI8bWcj9lNWo8bdszb+8ndlZPcCWzZK0FrBlsqc
	f2ptixTLY5DNf1uAocRTdm2aYHyRkRKpi1SgDONrHyA1oA0U7cPC2XqAk9skpT3u6G0NQ0R3BLO
	bxs+HTH8+p+eqnaUoScPsONUySyfnM8J1G7b9tsBRmdfD+5IuzvyDPtW5kdD6coyBd8Yql9QG3a
	nrw=
X-Received: by 2002:a05:600c:4314:b0:499:521d:bff1 with SMTP id 5b1f17b1804b1-4997c0e6fbdmr19442725e9.2.1786513756678;
        Tue, 11 Aug 2026 22:49:16 -0700 (PDT)
Received: from labdl-itc-sw01.tmt.telital.com ([2a01:7d0:4800:7:a04:488a:882a:de93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c998f27sm17483405e9.15.2026.08.11.22.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 22:49:15 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
X-Google-Original-From: Fabio Porcedda <Fabio.Porcedda@telit.com>
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
	stable@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v3] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
Date: Wed, 12 Aug 2026 07:49:11 +0200
Message-ID: <20260812054911.447887-1-Fabio.Porcedda@telit.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Porcedda <fabio.porcedda@gmail.com>

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
Reviewed-by: Breno Leitao <leitao@debian.org>
---
 Changes:
v3:
- Fix the comment about the composition
- Add reviewed-by tag Breno Leitao 
v2:
- https://lore.kernel.org/netdev/20260810103409.133796-1-fabio.porcedda@gmail.com/
- Add stable@vger.kernel.org
v1:
- https://lore.kernel.org/netdev/20260810102840.125473-1-fabio.porcedda@gmail.com/

 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 94cdb61dca83..8178a8758cd3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1360,6 +1360,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
 	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
 	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x0991, 0)}, /* Telit FE990D50 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
-- 
2.55.0

