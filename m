Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204671;
	b=wbsQvzm9e9nokQVltbvl3Pf6j5Vwpcpf5uQFhTHiSiQVMHWV14YxwOZi5OZP2AkYkGIk
	 NDgpfG4sgkfjesYWKiQCoPrEHtM9nLKAWLNUSA8hMYNf385qa2z5fxEjPegwVjsCuZGfF
	 I1eE1FyEunHehL7TSv3+48cCK1WWByFC4cKn58slLI8drtgAjsw8iQVDZ8Akc6QgMTuEr
	 +sL04eA36PTAbO6TVIyMNF5iO2UmpWrYaa+3h6gx4V5/PdzKIDwZapsWLeuE1eSwWhQye
	 aQxd46GgSpUP04jIdrE93sVHEHHQ/La+L9PlokABV41pbBak1hYNDB7CVYs6L45v5Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
	b=I8Hmn1vYZCaEWYXeAmd1/yektBKwakugCmMtaKsB8oJDe7AuczHBiFbm9+oZXASWMufg
	 6yiekTC5b8XtuWOlSUz1y+DOzH4739AO9nvwAGqEiIp1Ee9sl93QRpiNjTQezBzR73+5m
	 3Lv/sY+HG3VNOX43aqVNaFqLLKnMBGwbYFpsc6ScvNb6ZutIfe6Aqd8C6EoP1Xi36MgPN
	 1PEpDmLtvJSxZuKIsqhsMS5asx+VIwWM2sheZyo94kF8mzrzf3gY8JCYMhW8nVJFQp8tZ
	 RQigHJxbGJu3iFukj2ZKoIEoJnPqhIDlbFlLBfM8W9mgzUR1FqHNzF0rMV9hQZJL/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDQuNPNu;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF08606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF08606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NDQuNPNu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1023285eec.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204670; x=1794809470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
        b=NDQuNPNu+wO1kS1Dx2SDzKWSRL67InMOdPsMwvGfI+nDQYbctvO10qNrQCKgyl4Qvc
         jWB4bUwuibbuW3fmHUix1a+ixJSRxVQBigcQBvcwwhy5GunugTwUXTgcWu0FSao4WzTA
         iCGPBJnvc6AwcYH52h8QjZxp0GLZKE0ji0dRjrUTLo6Xrcek5ziqHyX/IESkGmqW2Sb6
         NMlYwTArmhUvvLKNEZt+UEih08xp/TDB59pib1PfodnMrgZD3QyH1BVxyRzDNY/FoHZR
         MCpBQCxdH4WcIgmA6xrFafLWP+TI+ESAUHiERV7lqVCr7cH+nhfUBMBg0nH+9kAWiRWD
         dT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204670; x=1794809470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Id2km5CxlYm1pWn+dcidbAfMpqvkr28vGXkLmQcZjI=;
        b=r4oGOLaZTyC/IX7ZhZBRwBpYg45pCkYFgB5Gtutpifmaew580htgL2vgAtWlwW/YpL
         0zEpy4P0sv5u7cLxRHJsgHSqLhy+KaYLcwdA6UNKiA4Qg8lUE1LVsmfdlAwaOLW0C+Hb
         aCt3aWx+i7Mj5X9Nhvril93AnWxHPNH2kfWz1DKVrRfG3e14jiAXo6h+8RwTxmkL5Cvc
         D2wZz6zHBzUkgfysHi5sgu0tJBWMtH9z6Pv56ihML+AmHYJ7JfMXPvT0GtBqBIDJ9pqi
         0ew4Bz7gf8kAScIm082QfYP07PzYF5w89XccDXLth8tOx9DK6G/vJYMAhY6tsLGGmj9k
         8YAg==
X-Forwarded-Encrypted: i=1; AL+hErEmqTa5FVkgOA13G1pyU/24Jp4jQ5LXB5DuDDR9IFuv6HVTyxxQHrYmYWHfIIdJZFDJPykkb5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z82bCt1aaCX+nEtq8nVz+e4M3kRTDE/dAkSzloNDX4MrChrHo63
	Y5f1itgzj3UWNz1/CRgq9C7HmgijKGHFXMoXEXNX1bpISPWMCt52lExA
X-Gm-Gg: AYBFou3e6J6Qb26xiB5ghI3poQl2if+yIR3nxZ7QUvCS6EsYm9uY3gNg+IKdBLhz0TZ
	VzMusy9eiSriAubfXJuV1oOl7yRfjR6WqGZK5exh5WLUYEwbP5xhI2Ot4InwZHo73JOqex01yf5
	75yqLYnV6dthtGff8ix8nihgbnQOFmMYQlSGriuG/q5Fm/6aBNwnFbp0NGPie25Te7zYZRLyZS8
	nqwoZPV7e1Mgy+2qHqk/v4I8MMxoHXWloCUHtgX6indD3jJqmlQP1rFbaFNQEU1C0ORxs0U4Ig1
	u68TGbSq9CITxJpmOkOmuSItcX49xt5uaugPXlDYTGHVIKbDU4ODZJom6rNFh0pbq0jiQkLxR/h
	xK3RqClhePkWbjeoVf00XS52ExsxdL1hBBoFzbZgxg4UPDAyDFmhBQ3Lb3BcbI8E0DlyXcZxC18
	bM1dvEMuVbFgsqSU1OPja8yu8MLRK414f4G7CDihWnGG2aZocFFkDn4jE6IBpLCbKpKKo4USWL0
	x++i2xkXsGPIOlRhrc+Ksz31XKDXr3frT9PEY/txWSxxy/pb4/9XRxTbjyJDzKD22thmmlgehaR
	QVdMKtvEueRwJDySXHS46gr+/uKYByWcJ0mTx1fe8YmansRXLDgt72A8jy3fKTBcFkQvKjEgrqu
	3sy9YPtYDhAn2CMCF
X-Received: by 2002:a05:7301:1908:b0:36a:180f:3154 with SMTP id 5a478bee46e88-37256615db7mr5282253eec.18.1794204670493;
        Sun, 08 Nov 2026 22:11:10 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:09 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/18] HID: logitech-hidpp: use GFP_ATOMIC in hidpp_ff_queue_work()
Date: Sun,  8 Nov 2026 22:10:46 -0800
Message-ID: <20261109061103.2887636-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Force-feedback playback, gain, and autocenter updates are invoked by the
input force-feedback core while holding the input device event spinlock
with interrupts disabled. Allocating work items with GFP_KERNEL in
hidpp_ff_queue_work() can therefore sleep in atomic context.

Allocate work items with GFP_ATOMIC instead so force-feedback commands
can be queued safely while event locks are held.

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6b1f55483385..40ebab5241b7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2542,9 +2542,10 @@ static void hidpp_ff_work_handler(struct work_struct *w)
 
 static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
 {
-	struct hidpp_ff_work_data *wd = kzalloc_obj(*wd);
+	struct hidpp_ff_work_data *wd;
 	int s;
 
+	wd = kzalloc_obj(*wd, GFP_ATOMIC);
 	if (!wd)
 		return -ENOMEM;
 
-- 
2.56.0.506.g506a7eabc5-goog

