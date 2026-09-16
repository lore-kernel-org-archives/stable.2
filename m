Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871394779B2;
	Wed, 16 Sep 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548041; cv=none; b=f2sftoaICupMlt6WF8oq8YaQIcwdKCDK+Z62zlKTzXR0W+C2aWZEMEGBaK2XD41Hy8NxzJvZEMUD9MDakYFPgcf49Mkq8AWnWgz10LWjJfyoKrczadO15DdkkgZZriR43B1LFhYPFGQ1tPxz1i+nVkEnzrYfHG6ZPi4gF33PW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548041; c=relaxed/simple;
	bh=HQXtXr7G2xp9AelGAz3ogDvSW56fzglONu6r/udOBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Io0Ay46BtS6AY3OZ46NaqQ7SkT3gPUYI5XgAn7/6Sea2EeASwqPOM7fvG5YvY9BNM5drcN9YatqEXygp847dgW4g88n4uPGYmHG6M4gG6fAPxA7xnvJkDYN2kTXm4Mz68Qqd/CTdk3XJ3v7rLtm3HVbxV9il1oqSjGlHY6yxkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nOziChr3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nOziChr3"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id CE6F61FF2F;
	Wed, 16 Sep 2026 10:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789548033;
	bh=zWqSKq8lxW1S1zlDmMfS7DXWWilNffxfMKmzzQZ/n4s=; h=From:To:Subject;
	b=nOziChr3YwBuPZgHA9Hl/gMVdcT1NQx80zjZ/SlYkK/H+d68GEp7E9vPY34m4hBoE
	 uQnqWJqd8pV5xxF1cn3tNYPZ0S1mBNuOAUxj0Gpchjf0YZtZmze5guh1RFQWzMwmJ4
	 syxDdXOqPx1e/Yc6kM0kVNYVEAScIVUpSH5I4gaMHtwdp1/oGsBc3oEtdn0Sxh53Sh
	 evc/ETE6e3hmBVxo280r8kdAOEWa27KxXbUCfTfkg6IOggXZ3yBO/c4cLvimyv1ZRw
	 gZe74GUs+2aFYOraxrPgt/Fs+k7XMCr+JIOoc7ovhh+ZLBvcgdfaItEJa1vA6z0x+/
	 5JDkisHQ8EPRw==
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
Subject: [PATCH v1 1/2] arm64: dts: freescale: imx8mm-verdin-ivy: fix DIGI_1/DIGI_2 gpio-line-names
Date: Wed, 16 Sep 2026 10:40:22 +0200
Message-ID: <20260916084025.274229-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916084025.274229-1-francesco@dolcini.it>
References: <20260916084025.274229-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

gpio3's gpio-line-names names the two Ivy digital inputs "DIG_1" and
"DIG_2", while the official Ivy Carrier Board datasheet (Section 2.10,
Table 12) names them DIGI_1 and DIGI_2, matching the
k3-am62-verdin-ivy.dtsi variant for the same carrier board pins.

GPIO line names are meant to be stable across the whole Verdin family
and its carrier boards, so userspace GPIO tooling that looks up a line
by name works the same regardless of which Verdin SoM is fitted on
Ivy.

Fixes: adca46171ff7 ("arm64: dts: freescale: imx8mm-verdin: Add Ivy carrier board")
Cc: stable@vger.kernel.org
Link: https://docs.toradex.com/116799-ivy_carrier_board_datasheet.pdf
Assisted-by: LLM
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi
index 29075ff5eda6..b64751aa31d5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-ivy.dtsi
@@ -270,8 +270,8 @@ &gpio3 {
 		"",
 		"",
 		"",
-		"DIG_1", /* SODIMM 56 */
-		"DIG_2", /* SODIMM 58 */
+		"DIGI_1", /* SODIMM 56 */
+		"DIGI_2", /* SODIMM 58 */
 		"REL1",  /* SODIMM 60 */
 		"REL2",  /* SODIMM 62 */
 		"", /* 10 */
-- 
2.47.3

