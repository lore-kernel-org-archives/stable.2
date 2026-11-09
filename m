Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241102;
	b=lczkM3yaIFGas91B7Lfbr+UntdHHhZtEhFYqqF6kazYuDu52Bc/UKBWj/qTCzXxOUQE8
	 a/f3QHglh139X/bnwn70fiI7f5SUIuEV5TcwwNXR9JuxqFRYCdyikDlPwnZAl1JQ8S9bd
	 yWZzGDpN1JEToQjphDHhVoLqQReGZ2M9qq84wTSGOHn3i0TYit1Yu3ZBn1mUVfJpqaXdZ
	 MGRmLANPdQkO5lMlgnymwMQiRM6miZNCefZiY07hB/2x8V/ImopTwinL3mwg5GPLGWXvC
	 bcLDlDRIjGVldFWH1/Dp/A0SgfNXofKe/VVtyDAEeEm3uT5turgjLbuDoFm6GvW5dzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k47tfCEJkcbLr56UWWN1mV8xEAHsP5jrj/tsgJbgRzY=;
	b=VfpNTCCFE21J7oL2VW8c3d3y1BF0QSUZgv9pY1Snz/nCTNQpIa481TvpYjL/LloSWogq
	 9NkeQl3xcwRkycqW5MBhgayu8kGyPJEwzMBlLshP8Va64awic1MuAFUimw0AF/35Wg7zf
	 Sv7YinYAmSg1Fi6UDMvhKtiRQsR+Fhlubp/lVquwHLcenFRErzdAzYQf5yFoCB692kw3S
	 j7G/ErP5oWNAiQQgsYaAei434M2GgNie7Hv+iOvpbA4I9YUeZIoIbkEXRIdhnX+IseXG4
	 RXtesouLLxf79HHoMtv3Sb6ygMiHquB09tmohSZtlg/gt7F5NL9alWW7CxZpJTKsYgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb4YDHnB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D768B606A332;
	Mon,  9 Nov 2026 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yb4YDHnB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABB01F008A1;
	Mon,  9 Nov 2026 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241101;
	bh=k47tfCEJkcbLr56UWWN1mV8xEAHsP5jrj/tsgJbgRzY=;
	h=From:To:Cc:Subject:Date;
	b=Yb4YDHnB6Exb1cY689qfkUxTSs0Q7/s5VcUWYeEkZb4yE/wLfvx6tGanvomg/z3qP
	 N3OTyYEn/sEwcb3hyG5fLlcC+N/8xex1np/vAi+p87Dle/Lk0Ump+HJKF+jVihxd61
	 ahIYnX9T42wZAGKaoco8OOJQ2farJD7VCzWe5xgHIPphIPxso2D/3JlbRqHQMrZFO/
	 P8WQrH4SuHsNYg/66xhThGu2fp8KBcAEmmkJH2dJszxLItK2mhbhhnHBMBEmPNHcPM
	 AOHlwepOogENYNfPiekZtRlS45yh5Ae7ZZmzY+TnwssULifj+7VkPqkvEUBm2Xoc7x
	 rLvQ09AjZsG3w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: sashiko-bot@kernel.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nxp/imx6: Fix imx6qdl pico dwarf and nymph includes
Date: Mon,  9 Nov 2026 10:18:09 -0600
Message-ID: <20261109161812.3629546-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The imx6q/dl pico dwarf and nymph boards appear to have a copy-n-paste
error including the imx6qdl-pico-pi.dtsi by mistake. The
imx6qdl-pico-dwarf.dtsi and imx6qdl-pico-nymph.dtsi were otherwise unused.

Fixing the typos introduces some DT schema warnings, so fix them. The
supplies for MPL3115 are a guess based on other dwarf variants.

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-199279@kernel.org
Fixes: 98670a0bb0ef ("ARM: dts: imx6qdl: Add imx6qdl-pico support")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts   | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts    | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi | 3 +++
 arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi | 1 +
 6 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts
index d85b15a8c127..dd8ce2df876c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-dwarf.dts
@@ -9,7 +9,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-pico-pi.dtsi"
+#include "imx6qdl-pico-dwarf.dtsi"
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Dwarf baseboard";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts
index 32ccfc5d41ce..4ce0d0d0756c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-pico-nymph.dts
@@ -9,7 +9,7 @@
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-pico-pi.dtsi"
+#include "imx6qdl-pico-nymph.dtsi"
 
 / {
 	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Nymph baseboard";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts
index 479a63ed42af..5e1f8b79593d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pico-dwarf.dts
@@ -9,7 +9,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
-#include "imx6qdl-pico-pi.dtsi"
+#include "imx6qdl-pico-dwarf.dtsi"
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and Dwarf baseboard";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts b/arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts
index e8ad4c12b263..d688b5bb6c6a 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-pico-nymph.dts
@@ -9,7 +9,7 @@
 /dts-v1/;
 
 #include "imx6q.dtsi"
-#include "imx6qdl-pico-pi.dtsi"
+#include "imx6qdl-pico-nymph.dtsi"
 
 / {
 	model = "TechNexion PICO-IMX6 Quad Board and Nymph baseboard";
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi
index 3a968782e854..feaadacfe7ff 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-dwarf.dtsi
@@ -22,6 +22,8 @@ &i2c1 {
 	mpl3115@60 {
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
+		vdd-supply = <&reg_3p3v>;
+		vddio-supply = <&reg_3p3v>;
 	};
 };
 
@@ -31,6 +33,7 @@ io-expander@25 {
 		reg = <0x25>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi
index 3d56a4216448..a13f4d49c05d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-pico-nymph.dtsi
@@ -30,6 +30,7 @@ io-expander@25 {
 		reg = <0x25>;
 		gpio-controller;
 		#gpio-cells = <2>;
+		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
 };
-- 
2.53.0

