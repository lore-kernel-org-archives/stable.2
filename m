Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776711;
	b=F7bO6LvrMeqXtB7ctvn5wn2E3SqaG0gbMdFOYdPErOfVTI1Ys2TASAMRks99kj93Sf3E
	 OwgxytYO61NHUqUFty9g59OlFSoyEXMhhEeOeoU+kFCehj2WELmKo42l4wr0Qm0Nd8zEM
	 9qW2Qi6biwtKkvGT8SjXpgUTBApqTvOzmb+QXh0KTNa5DntHDvOP/jMI5PTLh6GmHNn2T
	 RolwSUCrTkjoA1eTjtWwVniZNCQskkoyGSnWnAlEvvIkssCaunQdez7cKB+oAJoXVhDoA
	 dYkoD2YNyF/oZ7IDrQKt5CRIGhq1HqjbY49rlklJsWCSWk69dER+qK8j3amPeXbXk3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776711;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1DlHF+TG+diBHxqaKfK6dO3gBALdslzaCeDZ1j4rHbQ=;
	b=qLl1vQv23Hmw1AgN4QOSs+J94ViwD1vv/i507m2PyfAkvTDYafCgfUSA/yk6QjjxpKaA
	 XT2emFPc2dulkCbQLK+REtoh0gx2fJv+pTycKLKqeoI2K/LAiS91R/1PIsIvMIlrp7M0r
	 I2tcw682248nM1TOsHogxcJdWHseAoOh8Zr4joj6dwukuqnrwRQChVmkJ4osRJOhaPLpe
	 a3N3Mkox/sLULBVoOHXPdkK3KSK8BB1VNKOgXK9rnO+0qzhduGYZC63eDPb4GE/U9MHoK
	 bY4iWKLl0C+71I2z0sOsv69nkGUIkAX1l+HGF4eLVfcOBJFwMDoIN7ATKAt8tAv0uAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="lz6n/JXN";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F33D606A321;
	Fri, 27 Nov 2026 10:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F33D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=lz6n/JXN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795776708;
	bh=rvAzhRQQIy5kioDrJ9LSE0UkREav53+yjYJAByOmgb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lz6n/JXNkpKFWEGlDqo0bOMfK0R00OheiLKCR1zKh1MoUMPKwXaQNAjurmjyj58BX
	 yUPEQAeFD3f0A1+TOuc2ujVBq4cXPSRzo7cReGqsoCfQUgt5eUH65TGi16rEW5C1nz
	 Sst4AyI+l1/7cvpq8STZHBeVkzT5nyrGUmVONmjsBHOD4l/LIql/ZSQzBfLVCfR3if
	 rDvc81oJzZmUkyHvUjQR3i+IaZDepG3PHHENLDm+TL2SCYRDHBt6bqmgffuqtgIQav
	 1H6ef0Za/SK+9yedQkdn9hIfX1EYTuQSR50RkgkN8mVIG6ZcSTX6JzKB+yDNZXEz9T
	 mrQ9DlN9zv1Xg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 477F617E079B;
	Fri, 27 Nov 2026 11:51:48 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 082AC480030; Fri, 27 Nov 2026 11:51:48 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 27 Nov 2026 11:51:39 +0100
Subject: [PATCH v2 02/11] arm64: dts: rockchip: Fix USBDP ports for
 LubanCat 5IO board
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
Message-Id: <20261127-rockchip-usb-c-dp-altmode-v2-2-77ee78869307@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=rvAzhRQQIy5kioDrJ9LSE0UkREav53+yjYJAByOmgb8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGsJYMPY+N5iE7Wy7BRePrRobZRlTv2UYSg0l
 Yvk/pO9Z9cCfYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrCWDDAAoJENju1/PI
 O/qaxQEP/Rf1Z7z8t1a0pUY3pWN7dh2jOZjTcLfI6RVTjTFbRbblDrQq0V8l4kCfqS0lCCSYmhL
 sk6yb513yOLtSImSq+sKxso78662375IczXbhjgGHIwdXbz7vnWe3E7eALccO4pUx0Ezz3R7zAn
 REsAqOQJlCu+y8bQiSHGf+VsVKrQwCrnIuFh1k9tkcOcnAyvT7VkNcpctsiFpXiPGjqPdFzzmtn
 S3rjgrg4PrsOULU/p647vXkDYKgcSQ+nIpqrUPuxwXlzYYJ9JVucAhHrzZpFxlhBkx5Lr0LM2Yz
 l+GBhE7YdGcTH7ibCRIGcE16W/wToR5nCJBriwmwj9NwW7uHdzA29GwCR7Pb13suSEUVzlge5Vi
 v69mhS4cyg8EUWmJTUujjlICG8PAg9OFth/DQt+Tv6gbjv5j9ZbpUVUPuSq16gO39AXQas6Qp70
 Dr67+9OJOatvpIbkgQ/dIrrq6zpYkXWHByX5mo9wkcRLn4sjE3f10/oZorMW/p1I+KP+lRg7tps
 XnbfOj3t+7X+lzAnqla5hCJI0Eom85U9Ss1Yu6FFkV7LyuO3wGR2tQvV50czEMLKs7GHIYrgcEt
 nPr3mUONbxFF9uIYHRc8RJTW4mpvqtThZUb5WFB8qPeibF7/xaDNx+1IoWdYOtSP2SMeqwWzKrF
 FCNlB27kolk6K/JK+Zb43Jg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Fix the USBDP PHY ports description for the LubanCat 5IO, so that it
follows the documented ABI. The current binding confuses endpoints with
ports and makes no sense at all.

Cc: stable@vger.kernel.org
Fixes: f7b576f35356 ("arm64: dts: rockchip: Add LubanCat 5IO board")
Tested-by: Cunhao Lu <1579567540@qq.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../boot/dts/rockchip/rk3588-lubancat-5io.dts      | 30 +++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-lubancat-5io.dts b/arch/arm64/boot/dts/rockchip/rk3588-lubancat-5io.dts
index b0f262599cc8..71d640c939c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-lubancat-5io.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-lubancat-5io.dts
@@ -915,28 +915,40 @@ &usbdp_phy0 {
 	sbu2-dc-gpios = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
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

