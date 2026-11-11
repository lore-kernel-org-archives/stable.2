Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365051;
	b=jQP3rC1YLxPPZPzl6Gwn+/RtKgxlbStdr85uX3Xs1yfrpkGwAnKkRql5RJqnDGlkzMkx
	 c3rV6y76bfELK4Gnf+VcjchdL2t/KKH42UVg9hzph9jQygA0U/Vb8Cpy/JGbWVvG1HVyk
	 CEoaI3HLg+hqLFZrBR7lPLCRl6mO3zvRA6tuVeMKHbvQfAmKLroqaV0J7MDsVTDrjzv6h
	 EummElDEc82EOA3yqzIjHc95LxutDAtUQy74qfwlwoFAmHOO56BJaCm0RoKxoX+YKYnWF
	 bwWowULfQd8oWVMvlFUQMzyMwKFAy2/3eQ08b2weWvtZUh8jeEle+eeVsvYGN/DpV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/R5g7uGNU7UhN1clYRZMsWj9V3wivLCpdcDgve6pLrU=;
	b=gNSkKRCuxpaX1cshg/U1UTOn2GHKj3eXDdOi8vxkK52wOt4LhZaVYc1IO7hm/jr146BU
	 zEVFHIv4G/2tNi7vmgaoESBkQh/1iFAZQN1vvP4dFZ5JMLhzg1Va8ccsvD2dyx15udzMZ
	 d60kFDXNEiRm6/HPWR6Cup1tl6FqJL/YCHodi1xPGnte4FZwDL/yoAJKUveNijA0Da2BQ
	 SrvDHqaIcIh3fnJa5bAoI4uU/lAyDjAf18ccQcZJHGNBD8Un4yWZVKU+qUAVY0cRmsPYR
	 WDBQ19/uH7FdTUEiDWj1OeBhSJcFTrzn6H1jKV5uXyJrP81zflyq5JU1fibrfDtz7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xs5bPlWp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C91606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xs5bPlWp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC211F0089F;
	Wed, 11 Nov 2026 02:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365050;
	bh=/R5g7uGNU7UhN1clYRZMsWj9V3wivLCpdcDgve6pLrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xs5bPlWpsbcPBc7FfuyeySQVelnBw5tRHoVa6LBeqTim0pB73pTzPsVPQE5u/fN3G
	 dF4w36ELQhQ52NXQXRdGMMED10lT9yzXR0M2y90m2AEa5I2PJdYULBWU7sulUGbCUU
	 ayt578RJ7Bn/UDfYgGNxMDcBXS8R2NQmNb0549uzWIqUUBpEiTXeiLw8+DILJa9Y7T
	 xTjeh/lU9mBTd6+Xwh7YsQwq7KWoANYmSMLY9PhIpRQw4BA62kCUYdnoTSjck3kQsL
	 VuNTv1/XKc0TLIqyCmtF9HVuEMO8GPOmkEHSAE+0/w8XfAFWpLBDiElEZOuGDogZOj
	 lkX0g7cOmdxfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs
Date: Tue, 10 Nov 2026 21:44:08 -0500
Message-ID: <20261111024357.737751-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053007-failed-6.6-f377ac5999a5@kernel.org>
References: <20261107053007-failed-6.6-f377ac5999a5@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit f377ac5999a5d045168ddd25d204691c6653c06a ]

pinctrl_gpios_ext_yavia (SODIMM 64/66) is defined but never applied to
gpio3, so those pins stay at their NAND reset function instead of GPIO.

Fix SODIMM 64 to the correct pad, MX8MP_IOMUXC_NAND_READY_B (GPIO3_IO16).

Fixes: b694fbe2ff40 ("arm64: dts: imx8mp-verdin: Add yavia carrier board")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[ sashal: Adjusted surrounding context to account for missing GPIO4 and HDMI blocks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index db1722f0d80ef..fa24ac10f4ddf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
@@ -100,6 +100,11 @@ &flexcan1 {
 	status = "okay";
 };
 
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpios_ext_yavia>;
+};
+
 &hwmon_temp {
 	status = "okay";
 };
@@ -205,7 +210,7 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x106	/* SODIMM 62 */
 
 	pinctrl_gpios_ext_yavia: gpiosextyaviagrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_CE1_B__GPIO3_IO02	0x106	/* SODIMM 64 */
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x106	/* SODIMM 64 */
 			MX8MP_IOMUXC_NAND_DQS__GPIO3_IO14	0x106	/* SODIMM 66 */
 		>;
 	};
-- 
2.53.0

