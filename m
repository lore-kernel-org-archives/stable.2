Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164078;
	b=R1z5XobLTWEJ8N+8X71Yugtadl9YBSRwZaRGdHphl8vX6TM4coFnIgTCOLJKqYhMqojR
	 2RfBrok2z8UktIP0ns0y/GI08DK/9CAx45/BYNd61NuCcLMaoW558wAdhWZJeZMOu12n2
	 lDma+qpfP9JxQZWVSmgbnfLPUEIyKXC1npTMJA56YhtNI1/5gK96sE1S2TX8aVSSE/2qz
	 pnarcbQg90BFQZ4K7HK0D+ascdTz2D+9t1tZ2YlNx/NFjW73heZY+4oIwDeT0NvRpBzEb
	 hGXSWusiO/2JNjUlBndf2Dx9T4MqpWxanPgKaF+UAg5OQvQ0kiMgeh/4587wUD7XaLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
	b=Pg9e1c3dGT9aO2YJhFKUFJL5x+XsHnURY71rkvDgXXr3yTfpOvct+qc4D2i//O0Z/7wC
	 G3Vfkyw/bVCqu+JuCb3dRVmGxRwGv6yRPIxG1AxfH7+DhYt1ETpPLg0xXiKRQo6FoucoV
	 JEeJG9LBz9Wb9xcWyucNpLaWsYOM6Jgb3U0DZ1Q+23NUSH5wlnNMPUeChDa1s27RK13FN
	 bFmJFPPpWyHmSn4xGM7CXYaypJMDWJtfr3AwWmPQijcstPpEiJur5GAEGjtclPLdZdm0x
	 WVnLDeTWXMlXbtmJvZEsnR4b2AvWm4VDIXwPxTJqfwPSf5q2rwYLnAAgCHZDHCmnqgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd2v0wPd;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3C606A8A3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB3C606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rd2v0wPd
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36dbde64409so979381eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164077; x=1795768877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
        b=Rd2v0wPdfwvMv2u0VK501gIGjVDdVP5U/7/e49sNppiED2l1CFH6HT+LgnKGvn3z5N
         tHup6H8TiXYsM30gt/1fJY91iD+QbHOnsBwNAg3UzKGXAaqWIN6GHqXgr/Ft99BsMcD3
         moUcv3/hSUlPTEob4twN4a9qAoyq6orC81eKYFRcGj1D6mOzE/ogsV5MH5IZC0QB11of
         drQOOrU5IXXNhqyehht9bP1z0zJxLkEvhiHHH9lisIj6Sf+4HCN9MPndaMsNILJrgewd
         QsdgDG8fhb/s9Z1IXgFXSjM1P3iCga8KbkXC/hCzygSupEFHWg/+BAibC2rm1Edt5Opc
         QYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164077; x=1795768877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vX+acAcyFO4SrtgWaI02zFsEoaqyPYu5s5s/HN5VPPM=;
        b=qIiBdzuQ7oYTm3nPinCqrf5qNLdE5R4QgbTF+3syFXZEfXtOnA6vGI3F0IjHgdBq0a
         3VubS8F/RbKM8s1aWO+s8Tv97sFBVs5aJ6BwlnnmO4jHh2XmarA/UHgf4TyP0Vep4AjA
         9I0Hq2CEVzqnUeXo2p+PyskVzqc2/bCR5gPIPB1WD/KPHuM/VBj32aUiWUCi1/6lkmfn
         wDss8PxlZZFYkDkbyDGPX6CkiQCu1tAFydNiOMdmA3Fhl5ai7/Hh+x11xnIWbCTKIEWR
         vIPFZmnP7jYNA0umjSn/PpP6thqwl6fO4CZnI+vOuLcSchXEofrEEQJ19aNfzRbx72bY
         yOGw==
X-Forwarded-Encrypted: i=1; AL+hErFsureTibXMw3Rl36AZgTc6tW7oCfbU9qEW8e36qPkm1sZSB5IZot719HlkoXEDgNjrwGp4UFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IceZSlgu+5vWOwUttswLRw78d2G9DltlQRWQ/lpT8aEmls4HP
	SPCZ3sQi92H9CBp1FVARtffHgkeG0gN/f8oKlN3tYLvzDWVTQ+MzgmU0
X-Gm-Gg: AZFdTZc3zPXn/GJEuICilqKplc7xDqHH8csCYlWR5Z0Gh78tRxLJMXMk0/o0b5a3dCo
	5g5lcYCcXhInlbeSc0kdYIZJl+mOG3fEXfccnEYOEXu+LMiH/+8spKvR68gga1+v1nMtUGdZVXF
	NKJi14M0ZjQZhgYN0eyZMgXfPAB5+lkQWq3HD30nGJBGUvFIKMG9VQUXg+pNk+g5uWU2Nu/WljV
	cJoCSNPXDjkAdIn4xNzC1pywHnD1J4NnziPW+c5IcQ5wXY5W/JHFcutoGPjKEuYb4qCIh/fzhKP
	Hy6b4Klow8xzfWwtHnllE3NNFiX6+b++Pyw7dk10Y0bn7Ksw3caIFEu6xPjKK3JFRhwVLsnLqOe
	CfBKGbqCXKaiPt8FRJ7yXKxKPbxbrhBunJxBddUbtgAW+gdP1qz7QRH6RapjxIsRCr1Y/qIFsGw
	RV8kxG2aeWYVU+7OzW2D8L7/NPBSTohDVSba273Id9Y7jT+9zoRMm47bn7qaocGATXFBK7AXlhz
	8/2dO4drgsB0Xsd1nsGO4cu/sZSNyg/xhk01k/bLZUMrOktJqMBmf81WzSGxYPVk0R6VXV+C+1j
	68Oa7zwlcEJp85Kk6SIxlwBs2+R7qTKFfARIsMwD/l+oOgOGnBt/rTvOYFy2LhOlg3opYyDLpBE
	1QK05kperPhs7M6pSOg==
X-Received: by 2002:a05:7301:db86:b0:384:d59d:199c with SMTP id 5a478bee46e88-3856c2c3fd0mr1889234eec.1.1795164077449;
        Fri, 20 Nov 2026 00:41:17 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:16 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:41:01 -0800
Subject: [PATCH v3 13/14] HID: logitech-hidpp: fix K750 solar battery
 feature lookup and reconnect
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
Message-Id: <20261120-hid-logitech-hidpp-v3-13-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

In hidpp_solar_request_battery_event(), the driver checked whether
hidpp->battery.feature_index == 0xff instead of checking
solar_feature_index, causing it to re-query the root feature table
unnecessarily or misidentify whether the solar feature was resolved.

Furthermore, in hidpp_connect_event(), the HIDPP20_BATTERY block lacked
a branch for HIDPP_QUIRK_CLASS_K750, causing wireless reconnects of a
K750 keyboard to fall through to hidpp20_query_battery_info_1000() which
fails because the K750 does not implement feature 0x1000.

Check solar_feature_index in hidpp_solar_request_battery_event() and
re-enable solar battery reporting via the solar request helper on K750
reconnects.

Fixes: 696ecef9b587 ("HID: logitech-hidpp: add support for battery status for the K750")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c960d26a41dd..dbf8f15f5a5b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2122,7 +2122,7 @@ static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
 	u8 params[2] = { 1, 1 };
 	int ret;
 
-	if (hidpp->battery.feature_index == 0xff) {
+	if (hidpp->battery.solar_feature_index == 0xff) {
 		ret = hidpp_root_get_feature(hidpp,
 					     HIDPP_PAGE_SOLAR_KEYBOARD,
 					     &hidpp->battery.solar_feature_index);
@@ -4582,7 +4582,9 @@ static void hidpp_connect_event(struct work_struct *work)
 		else
 			hidpp10_query_battery_status(hidpp);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
+			hidpp_solar_request_battery_event(hidpp);
+		else if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
 			hidpp20_query_battery_voltage_info(hidpp);
 		else if (hidpp->capabilities & HIDPP_CAPABILITY_UNIFIED_BATTERY)
 			hidpp20_query_battery_info_1004(hidpp);

-- 
2.56.1.750.gf70dc682cf-goog

