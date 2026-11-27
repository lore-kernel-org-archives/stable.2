Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776710;
	b=JpaHh8CP4R+2qr1S2/xWtCvjQM4QLHHoyW0VYSaOuRDrfPIoYpJiYDQQI3tUU++iz49C
	 Ysw6I28pTP9SY9YB2hYdZ9430LdlrwCEWenXfVk5mVnbJK0SeUiQUSHjeIJk/DoF/hRpe
	 GtK/0m5XHupQXUYPDupFIHvCQb5RMO4ZwN08PLb+lPhzjpT9P7VyQpZ34m97hgG7bBUFj
	 /FaZ3i3Zz6WvN4yrt0XIFE6bOYteIxXKo1US6Jqi1213QpcOd+Atlc3lYswvygDhwg0yM
	 BF9zfRkzsNTa+Yvzh7rqUK7bt+C2HjpWybLC44BPADT7iv/eosKVInjJreDss9wgQkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776710;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=l7FztdzFHxqU1nbusRsPYGsX/uBT6CT4nw2wRBYgCtw=;
	b=5DvN0EIDFGrMZH7o/mUibneGCysRuXgoQvCo8qftVfYIw2ZkoCmdRp1N+U/Z+vqCcqkt
	 lXwu27MkFl1N4TJp6TJzkjXM72YqfB74vFWISMDwBnvLlwd6bHl7VLZGyrP68X5sme9Ke
	 SYQ0Hpmj5f0uPQ/7uXcpGSqNw6Xaa2bISHww1ESdb5+jHAdoWcuA/OnKVRMZu/fpaRwWm
	 M9zY0T6xUNaeMczX7HzzVWuFPx+BF9GdvfIu117qRjwloRWPWGu+I6jYFjbvtpjq2OWNf
	 aKe0tUw1F84sgUX3WDOAZxUWAxtme3dW7jrMVzquX0OQuotY5SjUaj8fTcPj/7sEuUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=J8xHpXZ0;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F465606A323;
	Fri, 27 Nov 2026 10:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F465606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=J8xHpXZ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795776708;
	bh=9E2x1LUH3yCRqvxf0O4/U2wLcXTXtQpAgPUIDrh2sUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J8xHpXZ07C0EH81jSHkxTEOWU39MvqudlKMRNzJtw5RQX7ZfNbuS/5JFLTAQAG3Is
	 WWyJN7h9iSN1ZrfXbHenJS9HQhYpGCA9hPn5f40UfIQnGO4KnaOw9eHWgIi2aMyzmF
	 eEMQoOfQN4forrrm/r0xdboFG/fwCDogeFSRhPl7DW7XKfhktCaupZEMKMHflsq2Mz
	 lYUepct5erRZva2q5+yXTzNgpDFfR+fbTc7SMuHXmYcviLfjuPjmddk0UDM6V04cGq
	 0Cn7B70YOYzmM3ll55vAr4wVA3TYBC8PVM7orj+jV0InvWmIsXZFA0N68Z7CnRI2ID
	 0BptI52wUVgog==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 48AB817E07B5;
	Fri, 27 Nov 2026 11:51:48 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 0A284480031; Fri, 27 Nov 2026 11:51:48 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 27 Nov 2026 11:51:40 +0100
Subject: [PATCH v2 03/11] arm64: dts: rockchip: Fix USBDP ports for
 Indiedroid Nova
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
Message-Id: <20261127-rockchip-usb-c-dp-altmode-v2-3-77ee78869307@collabora.com>
References: <20261127-rockchip-usb-c-dp-altmode-v2-0-77ee78869307@collabora.com>
In-Reply-To: <20261127-rockchip-usb-c-dp-altmode-v2-0-77ee78869307@collabora.com>
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
 b=kA0DAAoB2O7X88g7+poByyZiAGsJYMOhJfaTz3Pp47KI4dijSWdtJ8llGgPXsoX2I3sZeK/xJ
 4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrCWDDAAoJENju1/PIO/qa5bQQAJ5f
 5H5HK9xA7sR3Q0u3ZLebGMxNQ8d9gMVBsCX+UyHg3cluJpLFJs0GJ3Cqr57lwAXl9mfzq+WGSh3
 ke5MzfAIwl3lTFHVOqZPss5QURm2zCnFtoOzftaqv8tCfCHdxL92tW9GsODFegDpjOL8pTS5YwJ
 IJoA8+jwGAkXftJfVc2qDcKBoweV9AUEExkQGGLlcwIUfwp9O5is1Iw057iPFrv4Fa0qmV9D7QF
 1NRyRZ6l7t1JzWJR0ryLzGsGE3CswFAyqakgPC4bsIsiak/Wm/L4KnDzsRVCzVm0E/EPrwp2nJl
 HF8qkcOUT8wy7fjzY3+nJ2y53Wa249/EU+yBhZ/UlOoImDmGub0RjH9eWQ/nlp0QiNU77HD2Z20
 ZoAuv/h8L7B8bNFuZfKOgaSqt/ysGqttaRbKRDBgmtHCN5JdtzFh9edZcGv1gb2Wl7OnFaDssDp
 IdxlDq6gGC9sPVSODlZ+xn571sz1kJ6rpi12JeiCkQ3ykNJmdHM+6tzjBPNIbS4Qv7GdIX15ls3
 V6ge8lNCxwRx1ZpGBrxQgEEQoWU7NeeE6cnD7a0MldDsSMxVPlKAlcL+4n22BbJYuiE7sTcm+K9
 jEV32ciSjpbXJL2MKdRZyHvc9oY/dpjm0bgoJ/Xsq/SK47cBciN3IIAJfKU9oIbMwAojxYd9XOs
 BaoOA
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

