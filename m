Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655739;
	b=4BGN0+nG0KNDwc6YW90jxsBlsQ4jcLxEaHmUgpuQGD3e/VYM3i9sldnefx9yDW7d6ebn
	 uLpFAUoWBNMXljCY+RZHNUdokKbHmI3lPsS/fb+Q98OXjHY8BvTbB58KRcFqUo/npwrip
	 EXUsTmBc7e/GDJhgipQ3fxATRS9Dc2cffirQZwpsQi23DPUGc7LIH+XDvbdaN1YyOlsTB
	 qNfhyq7y86rXnF+VaGItgwlvBIS/ZdOOhs7J7ADLyD5fYGBd2owz5QqwkQK/u56lRRxA6
	 X5B+yP1Os3+bOhBcafaqv8bklLTTXJYX6rHSI0Y51Ua2Ep9DBUNnPkfN1WRp9WbyfoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655739;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=l7FztdzFHxqU1nbusRsPYGsX/uBT6CT4nw2wRBYgCtw=;
	b=k2QLZuFNIxBeQsr/WyozpzgteR0F8Oy9LxJDcr2SKz2fllJFqhMisIYkigh7Y6qtjDvm
	 QYMBgW9tSPPJGZCW4GuCdkczDvFlluNtIsS9DCrq4iSfGJ3QmvXSf/tnv+qoO358Ni7B/
	 btn23pcvyFT59VCKATabU9PIiRKY4u3wjsyB4v93UicvO1UV/bWMyXHjGarVJMneUV99R
	 /C0rTqUg8TiofnnLuWDUjFtDHL2hMaTUiO1x65MynTVqsKbgdBtiOu4PTSvhOEKLELA6+
	 apxYThpk0Gy0eJKoYcOq9Px8jvI69L4SN0jhdDrnGMUUiuDdZ3J9mWZ1E4aJvnafZeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NGO+yVcm;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F1606A337;
	Thu, 26 Nov 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D3F1606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NGO+yVcm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795655734;
	bh=9E2x1LUH3yCRqvxf0O4/U2wLcXTXtQpAgPUIDrh2sUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGO+yVcmsrm3CWAKc6nlbUq21hYa/4570M7tOTYJRS8IPuBpBPLDb5PZzxwbZWeO+
	 S/BfLWztt6QqZr5j4qwq7iFqzUcls/AtDiomlQO/yGN456WJHJLEfjxmTGtCTcom5O
	 HtSQy11ijt9w9ttRBf8eFuYjxn2u1ZeuvfXLgP3NUtcvbiaO0w5Xx6MSWZfGPM1GwV
	 9T2DEKykyf1kBldVl63cL6j8nSSefvAw3KFJ6qoXDPdiHt9wsi5jbaDmW6ZjZXZqOW
	 Nqkb+XL06v0Xbk5ozMS+sqjC9bDrsyn0Mhz0EFu2i5lKjPjVaWBPb7TqzC2fwWCt/A
	 vYo4WiHjWAjZQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 146E117E11E0;
	Thu, 26 Nov 2026 02:15:34 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id C20DE480031; Thu, 26 Nov 2026 02:15:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Nov 2026 02:14:31 +0100
Subject: [PATCH 03/11] arm64: dts: rockchip: Fix USBDP ports for Indiedroid
 Nova
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
Message-Id: <20261126-rockchip-usb-c-dp-altmode-v1-3-7991eb5bb426@collabora.com>
References: <20261126-rockchip-usb-c-dp-altmode-v1-0-7991eb5bb426@collabora.com>
In-Reply-To: <20261126-rockchip-usb-c-dp-altmode-v1-0-7991eb5bb426@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Cunhao Lu <1579567540@qq.com>, Chris Morgan <macromorgan@hotmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=9E2x1LUH3yCRqvxf0O4/U2wLcXTXtQpAgPUIDrh2sUg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGsHiDWHdXcZ6OOtB5D1p8yd0mIX7ogvEWiED
 SSsko4hzEi6Q4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrB4g1AAoJENju1/PI
 O/qagNMP/0Dd26iJL5aiS6tDdcEbzz/TgBepKSZtd2+YmieZak0tg8V6vanGC8uCC5Tp3yIPfJI
 qv0LjXH3WHj7r9pLSfxdtHOIunpkMasYdbRqhduOVvgKuvUdlDjDBZyWo4x8NJogoLxivTD4F6f
 IIQlcYXzLaee2zLIi2WJyxOdvpZUUHLLT48F/9EBjhi9t7Ipueukmqy297D+ppXmtY+HqyF9ocD
 33Vwx9B/JQEpym+1HMsbgbi5r/kaUXNVhy7WPf43wMJYVAqiCpnJfDFphFe6lyF0Ich15E/Vg4w
 HLEnj01RTlB4f8bfgWRxcIlZE09tNpe9EMQerkdl+LIKMauPT8rcErpsvBbHdFLEzeVn3fE5nyH
 Ah9pQgX/M/GMcezdQ8mxUOHyPDvtwinHPJqsuMbSAbKNoEDG8hY1LHh8hw78w/LA/L+hVKvaLdR
 XUm6W60K+gd3T+hb1sAj0Yk7kfZGnftMvkN15JDER3r6Lljl8V1W+zIi7j2MTGCDw3yaUTlIg78
 AhGarAvrm4xlF1gyXU/aTwdQMMUW5aJHU7ygcIq38TwQW2WZb7bDi9H/wrO8gVLxzypt4g0vUM2
 XWxNoIyWZwAwc/yiJm2YfMsaW0vo5hv85dN0Znt0QYgiyw+aMEIwJXC4YcirRNXc0UbyI7iR/UH
 +4YkBBz7CgojUQ7hs+RolOA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Fix the USBDP PHY ports description for the Indiedroid Nova, so that it
follows the documented ABI. The current binding confuses endpoints with
ports and makes no sense at all.

While at it drop the rockchip,dp-lane-mux property, which makes no sense
for USB-C as the DP lanes are routed dynamically based on negotiation
via the USB-PD protocol.

Cc: stable@vger.kernel.org
Fixes: 7230cdc1fc3c ("arm64: dts: rockchip: Enable USB-C DP Alt for Indiedroid Nova")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts  | 31 +++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index c775f82c0624..59b95461df57 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -1059,31 +1059,42 @@ &usbdp_phy0 {
 	mode-switch;
 	sbu1-dc-gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_HIGH>;
 	sbu2-dc-gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_HIGH>;
-	rockchip,dp-lane-mux = <2 3>;
 	status = "okay";
 
-	port {
+	ports {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		usbdp_phy0_ss_out: endpoint@0 {
+		port@0 {
 			reg = <0>;
-			remote-endpoint = <&usbc0_ss>;
+
+			usbdp_phy0_ss_out: endpoint {
+				remote-endpoint = <&usbc0_ss>;
+			};
 		};
 
-		usbdp_phy0_ss_in: endpoint@1 {
+		port@1 {
 			reg = <1>;
-			remote-endpoint = <&usb_host0_xhci_ss>;
+
+			usbdp_phy0_ss_in: endpoint {
+				remote-endpoint = <&usb_host0_xhci_ss>;
+			};
 		};
 
-		usbdp_phy0_dp_in: endpoint@2 {
+		port@2 {
 			reg = <2>;
-			remote-endpoint = <&dp0_out_con>;
+
+			usbdp_phy0_dp_in: endpoint {
+				remote-endpoint = <&dp0_out_con>;
+			};
 		};
 
-		usbdp_phy0_dp_out: endpoint@3 {
+		port@3 {
 			reg = <3>;
-			remote-endpoint = <&usbc0_sbu>;
+
+			usbdp_phy0_dp_out: endpoint {
+				remote-endpoint = <&usbc0_sbu>;
+			};
 		};
 	};
 };

-- 
2.53.0

