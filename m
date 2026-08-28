Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FA379EE4;
	Fri, 28 Aug 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942625; cv=none; b=AQN52/kZ58wcxYkq+xh1RRli9VBBS9SgrJH8H/X1GpUm2SepLy47K9ksDyzrKyY7gaIo2S8QKNOW9tNpl1WSeCWW78ScjmJkCsWxCTbWeuuLK44KFb6B+7CyQQOpmyGca0rPHAawse2sbb0d8x+L67yl3fWDnRpIYu31b/TKbd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942625; c=relaxed/simple;
	bh=2h3DDa//eNay2ZbolqGNQSd9EYRIEmORHIbYAWxoYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KILzXI/0vc0Fayam98wauIVT8xOlEp71U0ucP/h/7pExgvdm5w9Lb/dMGrxGoyb9SZm0LweNyuRdDgxUsxyxHaAMmrHqzOEO7EE/4tvwCUpt5RmePU83Ltpghrfo4XPUWn9dZIGap0F4AESa9AgILgNv4Tpwz2jXnC72hE+pt8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=N2g3K6DL; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="N2g3K6DL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1787942620;
	bh=2h3DDa//eNay2ZbolqGNQSd9EYRIEmORHIbYAWxoYz4=;
	h=From:To:Cc:Subject:Date:From;
	b=N2g3K6DLjRfl1umNwjS4XsbBBeIolmVcBVC8MBzOWa0oNP6q26SFaFkFMcy2ulMEq
	 sELwj+byihFT+UPzGBT+8cQ+EBK/fgnWOIUbfI1yZhZlleQkjCk+Tng+PwOjt8gSQ1
	 sSxKbJQarYlq1/KP7LMReURl/BJAZqS/Ln/C2ABU=
From: Paul Cercueil <paul@crapouillou.net>
To: Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: dts: samsung: exynos4210-i9100: Fix Bluetooth node
Date: Fri, 28 Aug 2026 20:43:31 +0200
Message-ID: <20260828184331.655804-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM4330 is connected using CTS/RTS too, so add the 'uart-has-rtscts'
property.

Also add the missing 'max-speed' property and set it to 4 Mbps, which is
the maximum baud rate supported by this Bluetooth chip.

This fixes extremely choppy audio when connected to a Bluetooth speaker.

Fixes: 8620cc2f99b7 ("ARM: dts: exynos: Add devicetree file for the Galaxy S2")
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
index 8a635bee59fa..96db40102adb 100644
--- a/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/samsung/exynos4210-i9100.dts
@@ -875,11 +875,14 @@ &serial_0 {
 	status = "okay";
 
 	pinctrl-names = "default";
+	uart-has-rtscts;
 	pinctrl-0 = <&bt_en>, <&bt_res>, <&uart0_data>, <&uart0_fctl>;
 
 	bluetooth {
 		compatible = "brcm,bcm4330-bt";
 
+		max-speed = <4000000>;
+
 		shutdown-gpios = <&gpl0 4 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpl1 0 GPIO_ACTIVE_LOW>;
 		device-wakeup-gpios = <&gpx3 1 GPIO_ACTIVE_HIGH>;
-- 
2.53.0

