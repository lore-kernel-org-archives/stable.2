Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8ED51AEEE;
	Wed, 30 Sep 2026 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789177; cv=none; b=HTGOodGDb3GYQrBUasA/ZDImDpeaQV/5Y1I4ozVLTfsoz0uMUJ3ElB0Tp336G7mu//LuET/hZItxhP9l5zKVhZkVroeEBVqaFKTQpefv0PUBiDUdPihYPdYGN9CO3kUDtfdTzAk5Z7POX3V3SWc+jePVNjEYqG48xgcx6MC4dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789177; c=relaxed/simple;
	bh=wUIP60ReUng2toh7xrANlc05gxl0Ni0XDP3WkJdt+dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZszPs7hQztctsSReiDAhK2lM9U6zsXRi9yxCZu0jV6+tD6ao5IS+YnGxwEw3WlcDD7dqcbDuLGvx9Ib4WrM4oO6+yYbZUkf2+JZ1W6zBSDoPSY+sBJQpnG7mNBVMnAvVNPC4pfR7zUEWpv3SrMHQRLQfo557GDTDUyA3fufuZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LR0GqmnO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LR0GqmnO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 411924E410D4;
	Wed, 30 Sep 2026 17:26:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 14F1260749;
	Wed, 30 Sep 2026 17:26:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A84421032942E;
	Wed, 30 Sep 2026 19:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790789172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AbpkMZVsBdBOWRwxjTkLihKxr/UR5S6eo3rRMVyn4ks=;
	b=LR0GqmnOoJW1aSmhm3RXiefQ0ebjd+3xeaa8sqblORzg3ux6qGAgppd82PiaucDAdycHZM
	mzqPNkWOtb7XcCN3QCd5Nvg7IbsjRQF2j9jUp/Im3nS5CuatJoMCCpaaRnjrVEDoSEveF8
	X2tAoZeRtkSWZQ3IIrq5p2yweRaZbHKC8FTfmVtWvyrYklFrajG/YvdMu5sDuPHoZx0Xue
	AYLuTL4IAL8CNYuAyGP1564+mg6QIWh1WioeakkdZvNU4zeMUWQX1VCbpS4oW160yEZTy7
	Fqc6Zy6anUN97iLuxEmaOkgbnxy4VK5T7ei6NxOdYBsBemERW3STP+i1ArqwXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 30 Sep 2026 19:24:58 +0200
Subject: [PATCH v6 12/12] arm64: dts: nuvoton: ma35d1: Add LXT crystal and
 clock-names
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perso-ma35d1-upstream-clk-v6-12-48937ee6c9bb@bootlin.com>
References: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
In-Reply-To: <20260930-perso-ma35d1-upstream-clk-v6-0-48937ee6c9bb@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The clock controller takes its two crystal oscillator inputs from the
board: HXT and LXT. The LXT crystal is not described at all: add the
fixed clock node for it and reference both inputs from the clock
controller node, with their respective clock-names.

Fixes: 691521a367cf ("clk: nuvoton: Add clock driver for ma35d1 clock controller")
Fixes: b69af0984732 ("arm64: dts: nuvoton: Add initial ma35d1 device tree")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
---
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts | 6 ++++++
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts | 6 ++++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi         | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index d7670afb0a63..7752e85734ac 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -36,6 +36,12 @@ clk_hxt: clock-hxt {
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
+
+	clk_lxt: clock-lxt {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
 };
 
 &clk {
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index 8f3cb18d39b6..5c65f1fe5da9 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -36,6 +36,12 @@ clk_hxt: clock-hxt {
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
+
+	clk_lxt: clock-lxt {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
 };
 
 &clk {
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 7228ad4735b5..9a341c2b1397 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -92,7 +92,8 @@ clk: clock-controller@40460200 {
 			compatible = "nuvoton,ma35d1-clk";
 			reg = <0x00000000 0x40460200 0x0 0x100>;
 			#clock-cells = <1>;
-			clocks = <&clk_hxt>;
+			clocks = <&clk_hxt>, <&clk_lxt>;
+			clock-names = "hxt", "lxt";
 		};
 
 		pinctrl: pinctrl@40040000 {

-- 
2.55.0

