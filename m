Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D238F232;
	Wed, 12 Aug 2026 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531960; cv=none; b=IBclKVJY6AnEo74AsJVcoX5todxVSWhwlO+D6uxQvVrXwScqcq+Ownfon8Mz3WLgKZJIe+QbMvzbxIApzSeVk+oBY9HOuakbeBx1x37Ceuqc+gZjciaagdDJ0zCKyfQG3T55Ex7sEbDxHn9ZfKaookGwk+UxKIIVowCHOcfavOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531960; c=relaxed/simple;
	bh=oFM4y0E6agfFNtXUdDrc1hOOayUlzU74T2fi6oHKf8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXrTLka6cNJsjQErDbBHnGc5m4kQtkeslJP/mMYvplTm0iO5/H9dBfqwmTKvdg+NXSEKQZ2uJbcDwhR1akcN/GQ0GRoudTFPI5n0uhqjsi4gJ7kUFoaTRd1uV8Ez+lsY9h9JnVqoJrL/hD2ozLgdQejuqf541aJnVvRwTWc81ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Hx5l0HwB; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Hx5l0HwB"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id AD0EDE8375E;
	Wed, 12 Aug 2026 12:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1786531370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NrzVswISr6D5RWr8oth6bfI4MFhZ4x/cjBH/eQyrCzI=;
	b=Hx5l0HwBLt6RGutyrILqVGU0f/dcVwBaBdkngG/mydBBv/GX1uWqSu6GcZSW14x9RVflVd
	vt9MI3zdF3+aFgOBezeWshWFkGYgNEEgunU/0okoOPrZ801w1RZwWzeQfGJYq+4jIvSN7e
	5RRNQBNmBdti/89UX/KvgVyx7LRluPpHjOvwnL8E+xgW0dpGzKWUs3t3YM0YLUGkn55w3B
	th03hhqn0HRsPWQf/zcPLLvK5w8zwj1iV25Ux+Trb8oPuxqmsdpgP11rB5c/1tLHJWCnH2
	AO3mJIy96UQ7e3y4Ku3nsYrBwpAtbrsBA+CwhOX75IY4ykqBK3WRJoqHWB+EuQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id SrVPMcsW1sLV; Wed, 12 Aug 2026 12:42:50 +0200 (CEST)
Received: from p14sgen5.. (tmo-120-142.customers.d1-online.com [80.187.120.142])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 12 Aug 2026 12:42:49 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH] USB: serial: option: add Quectel EG060W
Date: Wed, 12 Aug 2026 13:42:28 +0300
Message-ID: <20260812104228.802711-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Quectel EG060W with product ID 0x6004.
The three vendor-specific interfaces are DIAG, NMEA and AT; the CDC-NCM
data interfaces are handled by the cdc_ncm driver.

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6004 Rev= 3.18
S:  Manufacturer=Quectel
S:  Product=EG060W-EAAA
S:  SerialNumber=123456789ABCD
C:* #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=  2mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0d Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0d Prot=00 Driver=cdc_ncm
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Carlo Szelinsky <github@szelinsky.de>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 580f06f5ce5e..b9808641036b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -280,6 +280,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EC200U			0x0901
 #define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
+#define QUECTEL_PRODUCT_EG060W			0x6004
 #define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_EG916Q			0x6007
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
@@ -1268,6 +1269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG060W, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916Q, 0xff, 0x00, 0x00) },
-- 
2.43.0

