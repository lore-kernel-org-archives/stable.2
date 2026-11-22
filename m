Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353831;
	b=5RgB/XdqzBuFR3/jIDi2k5u7log4h+D47zjJ34dP8pxQAxYH0J3U/B7CJY1KBZ7OHySB
	 KYslCA9qkwSzwInkpQJ1Tcoa0qic6fwfieTG0H4nH6Uxh8PoV/C5wBIRT/XGxunF6szyu
	 hJUFi28qijFdXf9Y0ANcHpFwxPinY9b52/tc3b25dB4BfpiuYC6SbfstzKScTyQOX158Q
	 uQ7iyiF7vHcQgJfWphNQ5s9MPnl3QhRjyqn2ymVdqeyXdEAGru+EaGs6gj1B8YA8SgT9p
	 rkV/V9MnYJ1F7hv25/QsKTwB3ldoyeLwnxF+4Z+LLxh7RmukP2gGoPjBN4ZuU9UXCXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jzqGpr5s49CrPSQcG6fEVlkuwOk32UJMwbrZ+G/YviA=;
	b=z5FM0Yi3FDikNnN4uxzqAeztuqloSNMHeS0V6KUzh5yHe1rGbArY8/lzmvBA1sdynOU5
	 LUHx6QPniE4LWNL/vEp40+GTTvOzROo/yjHVwc+NThlNmfs8RsfIErLkA1LOyhzt8NPzX
	 tMAmSKpcn5BImjdEDmeBw4lqe5gzsy9E/At9/y49VpsEO2asGMaGybwPyW541U0isG8JV
	 wFOeMTkI1i9dsdUfLDbPh12KPYdvAH6zxtI0xPgSPK0rdLMKFHji8p5Ps3zQKM81XvM8X
	 CoYRXpCGFFuHEKAlJXMYPSxR2/2O+bhdVwnbRUfBAdOjHut9ySVQg407b8BNfXCjOFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Cj1J/LmI";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6495F606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6495F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cj1J/LmI
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb77a462c6so25778145e9.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 05:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795353829; x=1795958629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzqGpr5s49CrPSQcG6fEVlkuwOk32UJMwbrZ+G/YviA=;
        b=Cj1J/LmIEmV0dSxW9U6IsK29QDH979sYXuqsCC48V/vyX/SnsE19qbVYnsFzmDKp+W
         MNKpeLp0MIr4KLOtrwbjiIjnwsVLeFE5sqS9yG4w7kbNKgo4v3AMESqnUa+1nq7E9Gsc
         RMIKfGM035hyNmWzkmNtA90C0iFA6t3MsZHJEOuBQbDwzxQW9NRa7qyqsPSjWN7Cek8U
         QWa6rjKU7waQU6nnbOa3/EY9JiIWTEpQcyESwSnYyCDMvkWDFNoQjfD8Z1ltaC2nft6B
         YxwxaeEXYBYlSI0xwyvScStdm+YPJTaqJHwI2WpKnjWCKloSAqLkxaHZczAA82tTWNiw
         JYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795353829; x=1795958629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzqGpr5s49CrPSQcG6fEVlkuwOk32UJMwbrZ+G/YviA=;
        b=QyzrJaw2lRbAfJCnQ0A23dXHBjCjGJb/wO8x36ozfcL69AC6MpgZGfus7hvOlGj61c
         Pfkejyi9lBbxK2QTeKoAS1v+PYXveve5TuOXM2OJS9fi1/o+zADxLy/LkZ8SIsghIRYu
         aqObaDmtD1ubuf7hMMy/ulNZG9qPXzYuxZ9Ksyh913pRZh033i+NsBZOirwX1wh14Ibf
         MU5/xRmar1H/tpCYHH46MNIS2NvG7gy2HL46ab4odz4C4xazJ+k42wR+kH67v8lyqlk2
         QOBUx0nQVF9mKyZ5tRTl60DQzt5Vys0kv8I69Q7qdiHI5k4IKF82I4k7l8wYgs60OU01
         y+0g==
X-Gm-Message-State: APuU4Z/4ooN/o7z6LOWWRxrPl04o1wfQQvFyRgt5khlmp+I1Az5klDtq
	4+lj7zQ2MZSvOJV793oi5Qey406Bjv5TBFVdefWxcaqBuSOjx/svy3G6sDg2Kk5j
X-Gm-Gg: AZFdTZfzg+FEArHKLR3pDQhRabNYxWAfXT6dyuKEUAH0IBJ0IkOnELWXBLBPduC1Jfh
	OkO9b96/uhPY20/q+CN6BzvCok3tgZN/laKlqS8frLoz/L1GSRFNE50HuLdovazjzeNCYaPpFRh
	G9ZuloR79yb6MJfQt/po79YiU6LeRGL6jIB80xdZ3PFc4J4s6Cis0UShHU74us/2iUYzM8XVdOD
	19YLXQCOzqyUpJwRjUoXeue4+eQ9PE34XCWOi/G0mU+62OyNOkoS6mSLHQKhiM5+WFROUALiSoh
	AUE+q/Ywlt1gtwwDsir4EIThmK2mWrClWx99oCesII7fhfu7OfaBW8Gvvedvz++J1Ba79TXrsJm
	ULxLmpDbPisweFHkxcAFTGzVqTeEPI2Edm4Nq8U/bfrclltO7nyKFbFHnyhZ6VDVYwvjS+gCyDn
	Mgo9TzJ3xuv2mbQGCr1KYDGNpZVF5j27URW+OmcCFnlwtcdbDizlZ1iDyBc4scfpeaOmV5r80hd
	PwPxD0YSR9ylMFqffIyDbReKBbtX7FqCF55cWQ9/563rxysI2jOdmagmLoHdubcQYTVcCNlTCng
	ne1BuqJemI2wjRHr87E8auNzymRmA47ACHGckZYkOV3Bu0VqFL9G0TJ5DUa5YlAII5+anw0ObbP
	F1+ajA3ISqB75YVXF0WpGarbJjghKF2dGmvC6GYSvO4/PXIWoxUN26OPk4Bkt0sKJX4IcTnLt9/
	a4EmcPRYygWwqkkNPbnVyBaDBIWvBvtYh/wAs21pBZXlp2tl5qEOpDCQ==
X-Received: by 2002:a05:600c:4313:b0:4bb:643e:3b8a with SMTP id 5b1f17b1804b1-4bb86162fc5mr148179735e9.17.1795353828613;
        Sun, 22 Nov 2026 05:23:48 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a00-1028-8388-a84e-20fd-ec9f-e3f8-60d4.ipv6.o2.cz. [2a00:1028:8388:a84e:20fd:ec9f:e3f8:60d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm16729671f8f.58.2026.11.22.05.23.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 05:23:48 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org
Subject: [PATCH 6.18.y] wifi: rtw89: usb: Avoid crash with dynamically added device ID
Date: Sun, 22 Nov 2026 14:23:46 +0100
Message-ID: <20261122132346.53002-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261122132329.52933-1-pepe.schlehofer@gmail.com>
References: <20261122132329.52933-1-pepe.schlehofer@gmail.com>
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

From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[ Upstream commit b1827227176821af9bba0cb643728d23328f3660 ]

Adding a device ID via sysfs causes a crash when the device is plugged
in, because the driver_info pointer is null.

Check for null driver_info in rtw89_usb_probe() and add a wrapper in
each driver to pass it a reasonable default value.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/7a537b2e-67d2-40fb-8ef2-fcbc7bbc93af@gmail.com
[ Dropped the hunks for rtw8852au.c, rtw8852cu.c and rtw8922au.c,
  these drivers are not in 6.18. ]
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Compile tested on 6.18.64 (arm64 defconfig with the rtw89 USB drivers,
W=1, no warnings). The probe through an ID added with new_id was
exercised with the upstream version of this fix in backports 7.2 on an
RTL8922AU. The commit is requested for 7.3.y as well.

 drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c | 8 +++++++-
 drivers/net/wireless/realtek/rtw89/usb.c       | 5 ++++-
 drivers/net/wireless/realtek/rtw89/usb.h       | 3 ++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 10fcfade615..f9078923bba 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -32,10 +32,16 @@ static const struct usb_device_id rtw_8851bu_id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, rtw_8851bu_id_table);
 
+static int rtw8851bu_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	return rtw89_usb_probe(intf, id, &rtw89_8851bu_info);
+}
+
 static struct usb_driver rtw_8851bu_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtw_8851bu_id_table,
-	.probe = rtw89_usb_probe,
+	.probe = rtw8851bu_probe,
 	.disconnect = rtw89_usb_disconnect,
 };
 module_usb_driver(rtw_8851bu_driver);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index add5987110b..fbeb3f5b737 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -46,10 +46,16 @@ static const struct usb_device_id rtw_8852bu_id_table[] = {
 };
 MODULE_DEVICE_TABLE(usb, rtw_8852bu_id_table);
 
+static int rtw8852bu_probe(struct usb_interface *intf,
+			   const struct usb_device_id *id)
+{
+	return rtw89_usb_probe(intf, id, &rtw89_8852bu_info);
+}
+
 static struct usb_driver rtw_8852bu_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = rtw_8852bu_id_table,
-	.probe = rtw89_usb_probe,
+	.probe = rtw8852bu_probe,
 	.disconnect = rtw89_usb_disconnect,
 };
 module_usb_driver(rtw_8852bu_driver);
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 512a46dd9d0..faf1e471e30 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -931,7 +931,8 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev *rtwdev,
 }
 
 int rtw89_usb_probe(struct usb_interface *intf,
-		    const struct usb_device_id *id)
+		    const struct usb_device_id *id,
+		    const struct rtw89_driver_info *default_info)
 {
 	const struct rtw89_driver_info *info;
 	struct rtw89_dev *rtwdev;
@@ -939,6 +940,8 @@ int rtw89_usb_probe(struct usb_interface *intf,
 	int ret;
 
 	info = (const struct rtw89_driver_info *)id->driver_info;
+	if (!info)
+		info = default_info;
 
 	rtwdev = rtw89_alloc_ieee80211_hw(&intf->dev,
 					  sizeof(struct rtw89_usb),
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index c1b4bfa2097..fe0f86dc779 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -59,7 +59,8 @@ static inline struct rtw89_usb *rtw89_usb_priv(struct rtw89_dev *rtwdev)
 }
 
 int rtw89_usb_probe(struct usb_interface *intf,
-		    const struct usb_device_id *id);
+		    const struct usb_device_id *id,
+		    const struct rtw89_driver_info *default_info);
 void rtw89_usb_disconnect(struct usb_interface *intf);
 
 #endif
-- 
2.54.0 (Apple Git-157)

