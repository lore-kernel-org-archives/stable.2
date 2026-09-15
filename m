Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104C36A34F;
	Tue, 15 Sep 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503269; cv=none; b=W5fC4GnfctIxwTiQp+rCDf1IG/589x35Ca1OteFt87KLEMwXQbPbea35JdXDNDvBN531ZG8KGHgS0imXxC5TXTJ4XJw2V7S7PTwe3TMqZQAP1GGlAHuP/+SOKVhNFIbBVAMDo9ytyyESi07idL7TCmFeY5PztQkPBbV9rwa3ODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503269; c=relaxed/simple;
	bh=D1OuzRqijDI1h3wNHmA32zFcsiNiM1GTztJaHf919oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3eQEuEPDYAH5W1qhM9wmTQfBgK9dvnNMfAh3xB7/Jd8YttM26BJqbKmO7J9HPoOniOtRzkToFPP/JrONj3u3aDd8c6suQvfJjf4Mm+bzFBmpVO19vq6f1gmQNiZ/aCwgJqpf5X6YkHbMAK0CBBT12oqls6Z5f7BqcG/LUR+Dio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=uktHQnVE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="uktHQnVE"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 7F8A61FABC;
	Tue, 15 Sep 2026 22:14:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789503258;
	bh=4ea/+Rwdel3pGhyUAK51+c5UpUhpQCRdU/ax/b4MwGs=; h=From:To:Subject;
	b=uktHQnVEI/P1daTNoRZzdmF16fV80IfH4+MVxOVFqprwm/iYldJEYDpvyzIfxPqS0
	 rEuxiGoZ87vRoPUqOr+ZFMhYQGvpkuJ9MQBerhwBj+6Y02/sPuK53PhPvls10ns9AJ
	 A6M9Is/fEGxC6YgaiVkuJ8DGNcMC3X9Cg7AjvQCQbu/B9lwETECTo/9728v/tC6ZDk
	 PGYoAeRADJbWoRrHIL7qY6a7Zlb2edPtF0C1hbjkqH/RUPCKha9MxtHfg0XsMKksHo
	 7xS5rgndHrOA8iFstdHow+cV7Nf8vrG9R1eFoRVkUeWKsse2Ivk+IeMQOlLsgRLbph
	 8cmGMCL6ljfEQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx8mp-toradex-smarc: fix SMARC_SLEEP# gpio-line-names typo
Date: Tue, 15 Sep 2026 22:14:10 +0200
Message-ID: <20260915201411.23118-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

gpio3's gpio-line-names has "SLEEP#" instead of "SMARC_SLEEP#" for the
SMARC SLEEP# connector signal, while the gpio-keys node driven by the
very same GPIO line already labels it "SMARC_SLEEP#", and the imx95
Toradex SMARC variant names the equivalent line "SMARC_SLEEP#" too.

GPIO line names are meant to be stable across the whole Toradex SMARC
family, using the official SMARC-connector signal names from the
SMARC specification and the SoM datasheet's pin assignment table, so
userspace GPIO tooling that looks up a line by name works the same on
any Toradex SMARC board.

Fixes: 97dc91c04558 ("arm64: dts: freescale: add Toradex SMARC iMX8MP")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
index 0348da385f23..eb8b9db7e3cd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-toradex-smarc.dtsi
@@ -323,7 +323,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lvds_dsi_sel>;
 	gpio-line-names = "ETH_0_INT#", /* 0 */
-			  "SLEEP#",
+			  "SMARC_SLEEP#",
 			  "",
 			  "",
 			  "",
-- 
2.47.3

