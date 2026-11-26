Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655738;
	b=0ebdpvrVyqtf4SkjWMi4MRPAaSJpyz/J7TDd7/EU6lPV+Dsw9fozA9nR8qdNzAOeb/ta
	 VD03fC2cfkQoCiEUVqsz3mCqoWn9DcjrAO8xlWq25Xy6GNr9Y9uxJmPg6vnQ+cgP3dTBD
	 CCK5H1DT5tO82E/JgfV7V0cQyt2+kNsv42UfJNb+4wdd+9iv/NT/TAiLBiJCgYq9zbU1E
	 cyEzbF5heIzX5woSs1b927MQjGgnkOWMmPONVSKJeJUvJ26IIPGUX3vX9Kj1KWEx7skbI
	 QOamsd7Uc7gTK9iG/bP+hqto200A4PDUaiQhfEt+30ZM5bsSlZyz+rTDCiVi1r0aIdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655738;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=mtUBC6/m0Zu7OYn16xzfDA11NZA/v4uRUN4jFDRXbkE=;
	b=ZfA7OY6K6kY85onQ10UiQGk+UeIf9N7fLFfZ7Q0msmZJaIqq6igrQ2aU1fM8sA6cn+e7
	 wwjqP2tf15T8DDjKSFhkNGdaoCu4V0oCanih72T7z/sq0Mqpwqbvk/c/5Zq05xBt4cpwI
	 t8u32uz9DECUwqn32c9cjzknQRvE2yaApsGUW0WnEweoBGTa0a5wocYdaDqq6kW43V3Y2
	 Rla5ft4CEHmG5onfYjITQaQ2pqExbDeMyOXcZ270xmgmIUxw+2uuSRsEgOvY9/39dPwEr
	 Sor0wkjayFRBgYKV3P9CcPBbyF/iH17FPSMHgLUQrqNgBb+5MCzXiq24OAUWpWyCMoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=JfmMqe1r;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F7606A33A;
	Thu, 26 Nov 2026 01:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2F7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=JfmMqe1r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795655734;
	bh=/OBXVRm4Itt0j+vC8V7NOOp9RQyMJyPKLRmuxzwIJEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JfmMqe1rtVSAtDKkBpzZ1k9AN0mTE8NxoQaQL9a+rnm4s+03ZuBxMrCQzC4PDmLli
	 wcRgJHb6ADnybe157eB/lSm4j1/lkzmD9Y2eKO6Sigxxr39JO9qdOAi8LY/YZkJqtx
	 NfPuy5DXByJboro86mZ5m5VgcDzgDtUMABu7Fwn9fhZVDtBRKsYHGo6egh9ju59msG
	 YmPCPM0bX9uWxqy+cp6rD224xHb9e1UvJm1UL1OBhHT/3J2hMN+GD8ONBzQXY3gTsn
	 p9H5xHRau0oOE2immmf2+uA84x3EQ12sAbnKmvLbGP35+Bv10RHFpDY/Wds4Iu9qJB
	 pAs1NkRteVvvA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1329017E1090;
	Thu, 26 Nov 2026 02:15:34 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id C053E480030; Thu, 26 Nov 2026 02:15:33 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 26 Nov 2026 02:14:30 +0100
Subject: [PATCH 02/11] arm64: dts: rockchip: Fix USBDP ports for LubanCat
 5IO board
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
Message-Id: <20261126-rockchip-usb-c-dp-altmode-v1-2-7991eb5bb426@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=/OBXVRm4Itt0j+vC8V7NOOp9RQyMJyPKLRmuxzwIJEQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGsHiDVzDULS+/CrK3i+WJj9iG1Oz5GA83fsN
 qFHbntwa+8wnIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJrB4g1AAoJENju1/PI
 O/qagLQP/3pxrqjsBVFTF6HfNsJPblpX7ftZMyq7UZHJ1hGyhGBR+HLdQFTbg/TaM3GZXo3xTgf
 626hmBqjzY4Ia8fNv5jMUyE4vZlLVKVS6yr1xXXDk4prPzYxf4V+x0JSQLVunvxEVkYk6NR5bVr
 qKYG+UDVcbEJhWgyadPQDjD04P7VEP7q+1qfLkAiJazXWKWF78isz0yshy4gQuKj/pDhPVsjgCR
 4NgjPgpVJJxb0wd+xMuyLVJA1B/6KkLR/YKs0CH2uNV0wRzRf7tX0WZztMMQV3ZgpRCUoRTZOFV
 K5CoYpFsgw07BXBfBAAg6Cp0m9EkYXFaHWTJMc/+GhBgPcl7j7o+Kvj7yG89YnTsThRsQx2fYmO
 JX8bezGYz/KCGpi0adNtnyPku6BjvfT8WEhWthIRruO5ooDmPEMt4AvpW3muHmPg1CPbDtbiD2/
 kueMpmeO831NEEMiMYZyeQpIX8J338W8y+pIGceyWqg2OQ1TLDuk7irefAJICgkPx6N6bXHFvC1
 DTAHjrs/X9boavfvIb1Ej+ZfEFOxMxwbB3IOzlVezxuClMdx6MkJf7RdGmAiKOwe5lPe8hpww+l
 ifXKkqojX477Ik9weB90Ra8bgUgFq/GvmvsJXArSUtY3mZKX17h1MXwIZx9rkBDDy/stHiT7TSZ
 iwJvDJpo+Mo9TxbdXom0rmg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Fix the USBDP PHY ports description for the LubanCat 5IO, so that it
follows the documented ABI. The current binding confuses endpoints with
ports and makes no sense at all.

Cc: stable@vger.kernel.org
Fixes: f7b576f35356 ("arm64: dts: rockchip: Add LubanCat 5IO board")
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

