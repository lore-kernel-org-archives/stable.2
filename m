Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0913BADB1;
	Wed, 16 Sep 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548045; cv=none; b=RhIlN/aG2hzV4rl04Ly+CYvp3U/Z1hMoJSkvImhhs/jqcSX7dlA0HNZ42fmhtGuJDg16F3V6F/oR/j/toPmBFFWo9CppMPIYrcug0I014OSsN7+W9gQyta6BUx8e7y1vu8pybEhyDNz6HSKUaKbfetHQjw0t2VsKKdQHXUJSOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548045; c=relaxed/simple;
	bh=RkS+BMB7WMX/M2CU/F+cSDmbLRAcKhvl57dIasegSwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McxjSdnVrqR0lwntBz9UjunHceeAdHt95JV2dAc2s1p6TtLVmtbIyhbKX9QhmsfhneNKUEmKJJvAxhfIJ6HF/+iTL65r2UWRHB11R5NPB+nl+RO49QdovyagQhlEmTUjvcxkGcjZWTlYDwwqs8McCdyq0efyylR5cFNVdUIoVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Mfqy4pYc; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Mfqy4pYc"
Received: from francesco-nb.. (xcpe-178-82-167-143.dyn.res.sunrise.net [178.82.167.143])
	by mail11.truemail.it (Postfix) with ESMTPA id 8901A1FF37;
	Wed, 16 Sep 2026 10:40:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789548034;
	bh=5eYBxqvQy8hvAWZmQDYiSaixg+yBCBKhpGm8smCMPHE=; h=From:To:Subject;
	b=Mfqy4pYcGUn2b1aYTfmUL5VUBkULfLfUbc+70XN6kHqas+6AN2M5Bu7XnafcNssyR
	 Piv02UBwN4/gHLgbXWNBjMLKaaho+eirrjOE+2b9K5g4hdJWVmFWbVlZ2BBfNTcVT4
	 vAO8qY/C/NtXpswF6DafhO+a5LSGFe1NdQ53ynRJygAvGRmme3UWlsAevdjV8NGNbY
	 VhQkqgQjE61vEArQ6LJVl1ZyNyXfSdx71fNjxgT5/hZCY3TqaeelGa9L3vtG1UHmmc
	 WpaccGUUyvKpOT7pmkqQcfcL2BnfHErkTkb4T2pqelxM/23H1ogX0hxI26zKv5wQZ5
	 OArYEWT2GHHag==
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
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8mp-verdin-ivy: fix DIGI_1/DIGI_2 gpio-line-names
Date: Wed, 16 Sep 2026 10:40:23 +0200
Message-ID: <20260916084025.274229-3-francesco@dolcini.it>
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

Fixes: b98948b04295 ("arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier board")
Cc: stable@vger.kernel.org
Link: https://docs.toradex.com/116799-ivy_carrier_board_datasheet.pdf
Assisted-by: LLM
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
index db1b4ee7728c..bf021e85cfc9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
@@ -333,8 +333,8 @@ &gpio3 {
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

