Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD447F3CA;
	Fri,  2 Oct 2026 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937491; cv=none; b=N0fbXv9agU6oyj5y4/avboQhhKR0/cfLCkZTdEdYSg59R6nNHmvsHr7rD7vMKnElLSR2UXHNeNmP6HR7zLiceiCL5k+aaK0WJoN5TY2pOsC3QANGkhd7hO0DbVWrZH5Tf8rEjRPX0YS1vLQ707H4nYPhDLrnUnjkJIG+dRJzWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937491; c=relaxed/simple;
	bh=XBgCxTfybc8ADOgP3CNTX3dOMWiVG3KLP+wVt7M5Pug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJSemNvHmU9WEZlemnim8nPTF9vhF4j1ZKI7i6SCKDUzOxNI9UW2kczZ5U1HFGhZGcf5jI6+Y9ZKXIfD4uVLP8X446yKEGD6mGXSk5Q7QV3EmsDR32WpaNoNEtohFUc/L1D+J+keXMZa8K3d1UwnWZG7L0X6ws+f3VpwYWANVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Y2qgZtwY; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Y2qgZtwY"
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E2E392097E;
	Fri,  2 Oct 2026 12:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790937486;
	bh=HwM7SLVvVIJhCu21U0scjFbWYh+AjkgwTRjyEORwvOY=; h=From:To:Subject;
	b=Y2qgZtwYc+KMHwa5tgi70vZkYQAeOBNuC5sOM9noxSmRz8X0v4P39jOk9EkeWmBtJ
	 /aVIVCjIZ7zRjxu0Xehj39V32HvQqeOCJLD/48846t0LcOTBwSY0XoWngfZwLWPZjo
	 24xP1QcMCjri1CL5nGm1fgDMYXfvRvouvs+w0dzpEOexVOMFV55VEf9XW0limei6HQ
	 6Cmk7VBCKLeZ/tGZ/TUHlW9+f3WuJdB1TCKIpzj3rFNe7r7iL4IQdPk4LpOKtbqbzb
	 zyYT8t5YkmgoBDXAz1ZGkhRn+vY0g/DQcVY4upCzTYCyUU/G3MVcZPG3oMXCqQAr4Y
	 DKBKxWG+Z2r8A==
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
Subject: [PATCH v1 3/3] arm64: dts: freescale: imx95-aquila: fix vdev buffer reserved memory node name
Date: Fri,  2 Oct 2026 12:37:56 +0200
Message-ID: <20261002103757.70065-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002103757.70065-1-francesco@dolcini.it>
References: <20261002103757.70065-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The imx_rproc driver uses node names to identify reserved memory regions.
It checks for "vdev0buffer" to skip mapping and "vdev" prefix to filter
vdev regions.

Rename the reserved memory nodes to use the expected names so the driver
can correctly identify and handle each region.

Same as commit 5cae743b988d ("arm64: dts: imx95-15x15-frdm: fix reserved
memory node names for remoteproc").

Fixes: d5c082ba23db ("arm64: dts: freescale: add Aquila iMX95 support")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-aquila.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi b/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
index c5f4cf0541f2..eb2958d41643 100644
--- a/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-aquila.dtsi
@@ -142,7 +142,7 @@ remoteproc-cm7 {
 		compatible = "fsl,imx95-cm7";
 		mboxes = <&mu7 0 1 &mu7 1 1 &mu7 3 1>;
 		mbox-names = "tx", "rx", "rxdb";
-		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+		memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>,
 				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
 	};
 
@@ -189,7 +189,7 @@ vdev1vring1: vdev1vring1@88018000 {
 			no-map;
 		};
 
-		vdevbuffer: vdevbuffer@88020000 {
+		vdev0buffer: vdev0buffer@88020000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x88020000 0 0x100000>;
 			no-map;
-- 
2.47.3

