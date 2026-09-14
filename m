Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD738C421;
	Mon, 14 Sep 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411183; cv=none; b=e5l52WbWdSPqywPcWqV9cC6L37Y1U7T42aW6nPLX+j3HnrZh3fe/H06hMYmuFuspFl7KRLG6k5PxlYvjfn9BbMyWJRLwID7pZYI1jGxL5EqVUBc2uMDindBl3HM8P7N+Ipf5P/BY1DhSizypZT+1nvwgsVjW18Aq4Q+7h5sEzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411183; c=relaxed/simple;
	bh=+EvIFyiaw2QT4DIUq7XxLl31BnnCkBd+XUSVmEJJYmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryM+TA6sdQRXBvMfx4gTMVyUTVIfOrkJ60o3pJaorfF66XJisOm0IKHSbbIXwCOY+Os3m8YvFIU5G+jjoyaM1gWDZvWwuss62vYOVtgtRzDx1PW5AKHfA5x8Qq3zN/a7tbigR6drY5gWohUYU5q+sq2HAPCsSGzMRcjHT+V1xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0yeBtz7G; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0yeBtz7G"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 2FA601FEC8;
	Mon, 14 Sep 2026 20:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789411178;
	bh=2lpOwqwwWWqvtF5ZG2J22MmAgTdqVo1i0uZSJYQvyg4=; h=From:To:Subject;
	b=0yeBtz7G3SjFamZwOgEoGQKJVcj29lojNIqR4oTjLqrv9ACPkNuwHNg9MisohyvKh
	 b4iB9m76RuXQ1NgjF5OW3Hf+3hIyrE0xM2Y8tSbedA+4zfQvcfeH98LkiWDSRDa9pb
	 7d7RpIjXuJCQXcQ4fp10Qk6gEJnJnzjGdeNgHvSZ4F288ZDGReVFx3hYS3lrArsRlM
	 Oyjiy4Vdod6WUcwCEKmYUz1NqICcgLZ2Qt+gbh7SYpDS3ll2JKnEuV17F8ICcpe6IE
	 j36RFuGc4qIqbykx8w1mDuFAkbHZ91F7rGnrAl90QaKRdI1kYTTwZh9Lgp/QpTq9vg
	 QrsTdTiWQFaFQ==
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
Subject: [PATCH v1] arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs
Date: Mon, 14 Sep 2026 20:39:31 +0200
Message-ID: <20260914183932.30325-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

pinctrl_gpios_ext_yavia (SODIMM 64/66) is defined but never applied to
gpio3, so those pins stay at their NAND reset function instead of GPIO.

Fix SODIMM 64 to the correct pad, MX8MP_IOMUXC_NAND_READY_B (GPIO3_IO16).

Fixes: b694fbe2ff40 ("arm64: dts: imx8mp-verdin: Add yavia carrier board")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index f3d28e23ba6c..2a90f312fb27 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -117,6 +117,11 @@ &flexcan1 {
 	status = "okay";
 };
 
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpios_ext_yavia>;
+};
+
 &gpio4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
@@ -266,7 +271,7 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x106	/* SODIMM 62 */
 
 	pinctrl_gpios_ext_yavia: gpiosextyaviagrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_CE1_B__GPIO3_IO02	0x106	/* SODIMM 64 */
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x106	/* SODIMM 64 */
 			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x106	/* SODIMM 66 */
 		>;
 	};
-- 
2.47.3

