Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B13783AE;
	Mon, 14 Sep 2026 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789408239; cv=none; b=rvaSwx0BJ4BSqb7DqG0diWqdvaP7cBJdLCV1yGLjfLhskGCtYQinLa58VL6D8pD8p9NdxNUhlWFcV1cHWtGcs5vWzS8BiGxFhb/hr+dLeHC33keJUhGeowuxAKV1qry1r+zOMh1s82PCaRHTwKZuHd5SU8EGbfeFCe8djAJypv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789408239; c=relaxed/simple;
	bh=TgeGrIiPIHJm53FJZt2pjOAk9G4q19vRduQ8eKL8nl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlmQKFhIr0NzcwxFIFmHyGO+6oOT4J2XxaCEQRvvCKagzVRRHf8ocT1HZ6NuNI5EZFkN0njh1QlIBxp0qqOswjHPyePL2j1Kb/HWAXBbFrhWmwFGjJLu2jD0zQ1rVP99ySXgz6RYJAtvBDaJLEHPcPqFGoA1IKQGBjJyU8LhU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aphJpyXF; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aphJpyXF"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 7DD6E1F8BD;
	Mon, 14 Sep 2026 19:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789408234;
	bh=3u/ykhDq7r4ShX9I3fmkI3JbzbVWqdHF9eVM1GGm0Qg=; h=From:To:Subject;
	b=aphJpyXFY95Q860grTyLZRiMtTsyeLB5QUr/dbj2o0jQ1pp9WiT/TYcqq278/GzPf
	 QHFqvnRR8DBRYKFBAGXsQfkzlu+m94GZ2AOMXKmzITFNm770fMBC0OOT8YTK/Zl6k+
	 NvS1j1/lZfqmmjlI/JqtA87xwDkUWL+wG6sZiQLzVJPKhFz6XD8L4FGfQg/JPtT8n5
	 0sUocTsHgK8nc7E1GqOWDbVA12IxF/7Gz+SGrKKLQYBinmyCFLOJMkcVloGOXfsD8T
	 HKZGPRAYqDff0vtfIie98PFm3DsVQv4u8+Cqq9PIFfNjAI9uASz69QcKQWGWujKESA
	 AwfCImET6O/+w==
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
Subject: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: enable Wi-Fi SD interface
Date: Mon, 14 Sep 2026 19:50:26 +0200
Message-ID: <20260914175027.9097-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Enable usdhc3, used for the on-module u-blox MAYA-W260 Wi-Fi/BT module,
it was left disabled by mistake in the initial commit.

Fixes: 90bbe88e0ea6 ("arm64: dts: freescale: add Toradex SMARC iMX95")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
index a6c5398a81e3..4c102f213214 100644
--- a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
@@ -839,6 +839,7 @@ &usdhc3 {
 	keep-power-in-suspend;
 	non-removable;
 	vmmc-supply = <&reg_wifi_en>;
+	status = "okay";
 };
 
 &scmi_bbm {
-- 
2.47.3

