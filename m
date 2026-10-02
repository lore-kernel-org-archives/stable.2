Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6B47F766;
	Fri,  2 Oct 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937491; cv=none; b=fLTvI6dD28M/3U009+nP6w9z655Q58a8qyNqQPnhSVETgaoE1rBamtiY0zdXzQj9eTwtbHyn113IeLHOrDQLX6L1zVoRHpWqf9pL0PZzOchb9VIQdzvk1APGbBGrz1rZ5qZJETdZ4kVbPA+klB/iPzGEgez0O0xnyU1+V6fisaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937491; c=relaxed/simple;
	bh=FTRCNuMzFuZZEK832Cs4MyChRZ/KDtNTj2S8f3KBqro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgPvpJ6L5YzMCmDzVMZs2GnIGp07YSLI0Bj1fwBvePx9LQxtSo9t5NVsRThgPu+vuWUxXkxHKFgK+QSeNzUOkX+N3JleqCNggOoeFoHJVMJP12X6Nb7HCBt21/whFwNC6/BuLx7TtNqA1KSM2cJOS2JQj0+ulxoczPkwL4vEnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wNg+3oUh; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wNg+3oUh"
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 440E120A7A;
	Fri,  2 Oct 2026 12:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790937485;
	bh=JlF7NdCuUD9SxFNZdnddHC5tZASDCnsuSOKBzZbijdU=; h=From:To:Subject;
	b=wNg+3oUh3giqzedDM+CozBEHa/cPAu5qroakhTOBZvRZLq2CY3P8ouYAnfF6jZUlr
	 C82zS5g3tPrF5Gy2f2vMbD9iYBg+3Dnp7Y8bZj63CrbNXI9ywxjKOor4mNodGLloQk
	 mxDnqYIbkTzglBYStyEZOT8+LH19D7EdyZ06TPgQ6QXsTdw7p+siWn/NxAMRZKp26Y
	 54j2VmWnZl7WzB8zMts9UF3sKvsseiZSaffNjuyI/B/gSZqjn8mchOJ9uwO7/Lxv/6
	 8o86avC44Mtki+jHfrPqiJYlLiX36aZq6ia1eMhp4M4EYmGHp1zPvt/E/55vZGiQpU
	 hTqohgG1d63pA==
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
Subject: [PATCH v1 2/3] arm64: dts: freescale: imx95-toradex-smarc: fix vdev buffer reserved memory node name
Date: Fri,  2 Oct 2026 12:37:55 +0200
Message-ID: <20261002103757.70065-3-francesco@dolcini.it>
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

Fixes: 6b7a9871e171 ("arm64: dts: freescale: imx95-toradex-smarc: Support Cortex M7")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
index 641573c9943e..bc54a1ad7680 100644
--- a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
@@ -151,7 +151,7 @@ remoteproc-cm7 {
 		compatible = "fsl,imx95-cm7";
 		mboxes = <&mu7 0 1 &mu7 1 1 &mu7 3 1>;
 		mbox-names = "tx", "rx", "rxdb";
-		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+		memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>,
 				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
 	};
 
@@ -198,7 +198,7 @@ vdev1vring1: vdev1vring1@88018000 {
 			no-map;
 		};
 
-		vdevbuffer: vdevbuffer@88020000 {
+		vdev0buffer: vdev0buffer@88020000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x88020000 0 0x100000>;
 			no-map;
-- 
2.47.3

