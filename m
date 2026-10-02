Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4A7478E5B;
	Fri,  2 Oct 2026 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937491; cv=none; b=QOJDVJYSBroRMmrQb2spUu6NWht8qUdwY50Mj7ZqL2t3ZYH6dHVG+PK7pcwUGrRPQg6vgPBVwxe8QY0MCgdHV2zuXIcAxczOgmgRlg4HMW/FTJEFA0fiw5rvWh899AJK0bMQrU4Kw7mPn9IND9RE+6178nVYXzwpCBj5ek6iCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937491; c=relaxed/simple;
	bh=c1Kz1S+yrff+WNuY/DTybY0NYW0VwM7tpITBHxgkG1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvDFaC92kxJl1N15STtU2aB3Q17sGBAnPq0ATvQSk71cRMdrDMDfq8TiE0m2VlECZ6PEdGC9E83k/w0OT42yRwHjgpan9Uxfp6HWgbPC4JYeffiboFmpzMdEOUB04fWwzu0tbTlc/UhgrV55HrOrb/cG+j5vsDQmgvtJUd+hxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=C65mH7WK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="C65mH7WK"
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AA0CF207B3;
	Fri,  2 Oct 2026 12:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790937485;
	bh=1Lmc7m9O5GYGW82qx/YwZr2eAGDKfa3VzLbHRgPFcIs=; h=From:To:Subject;
	b=C65mH7WKZs2QaWzNJby4yt5fC8ZQZNCqwdoM/+Dw8UklYXMxM8t9TnQ6UJgjztGab
	 m60H5+G5Vn9phmR+tkfKYavizshf9jQu73WHNQTd11t9SGK0ARXxZr2QnwG80X2KV4
	 Ees+zZxfA+5Ntc9MYT5IV4VxR8w98quJELSYKaV+AAqgs8b6RDOMjf8LRjjTkL0KSq
	 SnBlq/7KZb5NLmu5elxZzGMMSm8Dv3lcxVCY3G54BCMWtnT1mkcdiYXbXjThyBkCkZ
	 mgDT09017X6mN/jjvafnaGhL5SAQBW5Txe+pnx7V+4EH89LiHdl/pzjv9KQm/kx/j3
	 A/wZyMgoLZO/A==
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
Subject: [PATCH v1 1/3] arm64: dts: freescale: imx95-verdin: fix vdev buffer reserved memory node name
Date: Fri,  2 Oct 2026 12:37:54 +0200
Message-ID: <20261002103757.70065-2-francesco@dolcini.it>
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

Fixes: 676d7ce22f00 ("arm64: dts: freescale: Add Verdin iMX95 support")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-verdin.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx95-verdin.dtsi
index 72e7f1e88409..f2e41d39ca6e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-verdin.dtsi
@@ -142,7 +142,7 @@ cm7: remoteproc-cm7 {
 		mboxes = <&mu7 0 1
 			  &mu7 1 1
 			  &mu7 3 1>;
-		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+		memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>,
 				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
 	};
 
@@ -184,7 +184,7 @@ vdev1vring1: vdev1vring1@88018000 {
 			no-map;
 		};
 
-		vdevbuffer: vdevbuffer@88020000 {
+		vdev0buffer: vdev0buffer@88020000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x88020000 0 0x100000>;
 			no-map;
-- 
2.47.3

