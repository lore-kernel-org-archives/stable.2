Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAB4E325E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607659; cv=none; b=Yh3hhEnjtY4AWz43t0Mf8Dwv/XOdueBisvQrwt/Fx9zkB1kJBzTIFzmC4zBrWwEIIb2ZtwV6n6HqcYtTixYT/TzZou+QTFY/YarrOcLMfBNgQynvn5hAGfTI+Y7+NL6fj0/DAiAN23fl4bwW69hR7xxzUwm1dvs5TkigfNCFebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607659; c=relaxed/simple;
	bh=GXO6lAFxoFQEwQkkMLCI0y+cMQX6YMSHGHt+/E1eEYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uPh8DTFXA93bRAW22842GTW4QoAr6+e0rYhI+xUtA+mpVhVbVBlcMFauPa16a/QnJQENq411prjo2ecb44+dIfVVygyr5Ur3itHR+11tH9eaVVCxAEXSn+iv/+h+r5ta/0Yezai0czEFYOKtLUg4Jv19jCwtjii5YQVgBjvROzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rBpHsL39; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBpHsL39"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso9662715e9.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790607656; x=1791212456; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PNRLh31Iy3KvKfoOWiJ4SBBap26RwlK370O1RZcEP7U=;
        b=rBpHsL39O+k1l9AUYeSXFOO3t+89j+XWHx09xnFuyUjXdsG9Z5q6AJQVwnwRB88Mo3
         1C+K6IxYtpiGJ24Xpec/jbR48xYBnw9uiql4QOinM7ccOLoqpv+oO4EkqKcvOEKcNzpP
         bJdcNVDAcVtzdNbMbr3gnuAIpH5GunfomdsNp93WNzpliSmpY+kAFTXcj+N8C8t7togX
         XbGwS52OqhH7ApSlregjT7eo9VQKZNRwBAivFTuYBNU42f0VKmi0kAcI8bjMfKZnX9/D
         1BPe7rWmoEZfpxZ4oDgewgtIg7PUhAeE3TyJC+ruhP+9+qcp3fVn/VhyAp5MoKyOybXt
         z0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607656; x=1791212456;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PNRLh31Iy3KvKfoOWiJ4SBBap26RwlK370O1RZcEP7U=;
        b=fAkLQ79MV2PC0ulUmUCCYpCezchq2VhqGafgEXOC5NfnLcnQPq/ap/UDqUNWO6/IyC
         C2jbmHLXu7LT93RXcujYSXL+QzkdIFalUGeMpHAGxR7Xa6m1tbsnrSRuXQmXkSH158S6
         Tsrk/LeCjgNXUTSIxMcdjs4RrrgGR6Cd/wcyernhyujnMI65d1lL1sTsrQ9XyXvswhO7
         MghU9Ck1+620ukj6RoF+ThoM2HqUzTqUq5e1sKpXEotUYCHt2bXK9c7VSrtNcQrklwUo
         af6Jn7IGyTzAe22sssOapnaTgQLvEOWv4xhLBE8oJOSGf7Bq0Qku/QAjPfUq0uYx6ll8
         GFDw==
X-Forwarded-Encrypted: i=1; AKwUvBzM9++pykzaTtTtVAeI/R99hZSQhgdWAbiUvzwjpqih62jQCCL0GJkmxrN0IVvbZcH4x4U5bg8=@vger.kernel.org
X-Gm-Message-State: AFuF++kmmSqX1sUOssYxczmRg/og/ZyIalsvs6eUnR2zbTZVdTc7I43E
	irm/kSR7TwlzmUy5kunf2sAHdjjg/NfepoRS3kYyz4D0/zfLH5cgufDj
X-Gm-Gg: AYBFou242LT54rMLLu30EHvafpotQE/OWhjBU0BeEoKduHvwL6PGY7BhYMh7NF1s3C7
	9uzoMoKCXEDMoRCOW84Vq3LVVlAX9SES34RIUKhn0E2DOmNFqobYxI4FbZM5R7d8nOuIhIsB2jb
	fZzkRUTJp1YrrEvQcUh5Ulg4r05D6ms6yaGViPavlaXQ3LFZ9oMLaWZJh8eLQ/49Ewa6xBt7a+Q
	tdelMY/9HjIauqAd+O5+kPOg9ag0aw0fcTRsxI+tenzzAuZS4RFYjbZuEAbFEkV5AK07snEAq0o
	kAe1Cj0XYkM6VXF3/K65gTTlfXpYM21Hj9GyEmDSvnRXSm1v21CEPtYYHv5YPH/TQZzb0BEwS3g
	0wubJyS35d7BxSiChZ3cUB907pNxvjSNoShTKsWc+wy9SqHeU7IDsv+w1/MGDsYKkkwHiyLwC5p
	O8eR7BKxhPoYAVPLi+a4qdjkMoJkkRCFmeseak1ZPbdZo43BqSHlZHadF0PUA1Wh+ls4Yo8nsLn
	zDj4pD6VE+VsIcLTDW4Z5bD2bY34gi+4fIHI8D3DbyhwT7gT7Sc3JqUUB5iJW8hUdWsvkXhZJ9L
	W1qq5T5HSJAVh3Bu//kRiQuwbLanfxjesUl67MBFUYRUJQLU
X-Received: by 2002:a05:600c:3b05:b0:4a0:321:6ddd with SMTP id 5b1f17b1804b1-4a003217170mr61722025e9.34.1790607655941;
        Mon, 28 Sep 2026 08:00:55 -0700 (PDT)
Received: from [127.0.1.1] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001922102sm151777245e9.15.2026.09.28.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:00:55 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Mon, 28 Sep 2026 17:00:46 +0200
Subject: [PATCH] arm64: dts: freescale: imx95-aquila: Enable I2C_3_DSI1 on
 Clover board
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-imx95-aquila-clover-enable-lpi2c8-v1-1-9a9755acb8cf@toradex.com>
X-B4-Tracking: v=1; b=H4sIAB2BumoC/yXNQQ6CMBBG4auQWTsJHYNQr2JclPqrY2rBVggJ4
 e5WXX6b91bKSIpMx2qlhFmzDrHA7CrydxdvYL0Uk9RyqK10rM/FNuxekwbHPgwzEiO6PoDDqOI
 7RmvMvoE10gqVzphw1eX3OJ3/zlP/gH9/w7RtH2AAF+uFAAAA
X-Change-ID: 20260928-imx95-aquila-clover-enable-lpi2c8-e71135e91272
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Antoine Gouby <antoine.gouby@toradex.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Franz Schnyder <franz.schnyder@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

From: Franz Schnyder <franz.schnyder@toradex.com>

Enable lpi2c8, which is used for the I2C_3_DSI1 signals on the Clover
carrier board. It was left disabled by mistake in the initial commit.

Fixes: 3f519121e120 ("arm64: dts: freescale: imx95-aquila: Add Clover carrier board")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-aquila-clover.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-aquila-clover.dts b/arch/arm64/boot/dts/freescale/imx95-aquila-clover.dts
index 365bce73eddd3..07bf53240958b 100644
--- a/arch/arm64/boot/dts/freescale/imx95-aquila-clover.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-aquila-clover.dts
@@ -197,6 +197,11 @@ &lpi2c5 {
 	status = "okay";
 };
 
+/* Aquila I2C_3_DSI1 */
+&lpi2c8 {
+	status = "okay";
+};
+
 /* Aquila SPI_1 */
 &lpspi6 {
 	pinctrl-names = "default";

---
base-commit: bf184a29ad1b33bd8922029eb0ca3f2866007258
change-id: 20260928-imx95-aquila-clover-enable-lpi2c8-e71135e91272

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

