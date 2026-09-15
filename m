Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFD3AFCF4;
	Tue, 15 Sep 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503517; cv=none; b=alxM8FZZeJct0KhInZ3fF10kc3jTV0gJYYLjElgOO33gLj5NwF96tMLUXsBa0pt8elSGqb+kUbZ9Ddxr0xvuM45/t5iR1/50T2RT3RnM0Gwaw5ncMkB0S8EzdEArMh7nOpKrnDTbDCn6is5xQCZ4zvyzvbK9w9gZpAl3F5rU8ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503517; c=relaxed/simple;
	bh=bT83IhvW7mzc/XCol+KPyV/FlnDbWyV/3zsGJkP23MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4VT/7tA3WWb5pISvM0b0xVEd8jGOH+U/TE7t2/3PT0GuoTr3ybN+fqkgwytQBfyV3I+uizK0z0clnSdVNwdcg/GxkiFMghAgkBcD02D11B65H5PQ+XBU8lqBJayM1JqP7afwVux47ee52L64qXIizpDkwytTkShV/DK4HQFfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VVrKsw35; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VVrKsw35"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id DEE2520474;
	Tue, 15 Sep 2026 22:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789503512;
	bh=FoG1DUT/vpsn9oqiqrGQqvrS+j2edBODyPxEbXKHOhk=; h=From:To:Subject;
	b=VVrKsw35Tg7HaoR68IDepSPGGq4hs2zjN9MUzNMyQAne/DAM5z302kkV50ilgDn1d
	 Kp1Hi2u12Tu2uPpJ/P2m0AR3eQgCfpSxGNI63OCeqApg+v+/GNNUfbjQy18KqjxnTU
	 eFcmTuL63jG4pPTUagKm3hltwmPpoQHBGGlBs9vWR2kxz9lJaYKBK+4t8DISlxLCXG
	 yrz6Xzkgs1bN4zbby0/ttwGZer/xZKYYqLvtqMUNuTEa5n4x7Hskt7RNjncHpGw417
	 4P85ohtN0jYRhYIsb0UcoqVD9LN42RtzP3Bophpd3R5jC1IG5CcVVPiuKlY9PnuMUQ
	 9oWTHMyzCdDJg==
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
Subject: [PATCH v1] arm64: dts: freescale: imx95-aquila: fix gpio-line-names padding
Date: Tue, 15 Sep 2026 22:18:24 +0200
Message-ID: <20260915201825.24363-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

som_gpio_expander_1's gpio-line-names use "AQUILA_C1".."AQUILA_C4"
instead of the zero-padded "AQUILA_C01".."AQUILA_C04" used by every
other Cxx entry in this file and by k3-am69-aquila.dtsi, a different
board implementing the same Aquila Family Specification. The
zero-padded form is the official pin naming per the Aquila Family
Specification and the Aquila iMX95 module datasheet.

GPIO line names are meant to be stable across the whole Aquila
family, so userspace GPIO tooling that looks up a line by name works
the same on any Aquila SoM.

Fixes: d5c082ba23db ("arm64: dts: freescale: add Aquila iMX95 support")
Cc: stable@vger.kernel.org
Link: https://docs.toradex.com/116801-aquila_family_specification.pdf
Link: https://docs.toradex.com/117671-aquila_imx95_datasheet.pdf
Assisted-by: LLM
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-aquila.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi b/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
index f930965cb341..c5f4cf0541f2 100644
--- a/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
@@ -413,10 +413,10 @@ som_gpio_expander_1: gpio@21 {
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-line-names =
-			"AQUILA_C1", /* 0 */
-			"AQUILA_C2",
-			"AQUILA_C3",
-			"AQUILA_C4",
+			"AQUILA_C01", /* 0 */
+			"AQUILA_C02",
+			"AQUILA_C03",
+			"AQUILA_C04",
 			"AQUILA_C36",
 			"AQUILA_B74",
 			"AQUILA_B75",
-- 
2.47.3

