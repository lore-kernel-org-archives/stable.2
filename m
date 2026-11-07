Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047409;
	b=xqsxb+woPh5WJfyoALJFRQCqMAEHO6nWRJuPWNDSHh4UJv1TNkPsW7A0Xy6cWgyEWEts
	 Z9gbYAICzcPhKnxM0f4wRlT06GLn8/ATzS2kgU6wd4d9GHrDC9bODGwPblmnUn26wa/ZP
	 lWMmPegTOMWdyO20uTL+q4cx+ANDl84guY5wuSX9uMjpLfXvjN1yQ0Cd48LjLWAsOFebE
	 8C7DVfqLhrEclrSg4q9LKJXbgj3wGYGJqSU1pr9+JJKtqveh11+aX6510mjjXS9VcHe46
	 0q3paf9JYPmhpWlaxnLdDTTYKTxJPJ5BnTwCR3U/DlLZ9fQBC7NG7bq7zQLgTCmaMZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w9KxajrO1lYOlaeSWdYoUkDMoLeXq6nMrYoy6MRt01k=;
	b=newf5jFhoLkQGPtyPBbsgvCeVs+9FlWMJxtuF13DyQlyAW3WsbWs1+u0rQC/r6NQixPs
	 HVJ0/agHvP1xrKCA1P5XeASLyzqT59VuElCGs365F52Qam4WuQt3U55KLugH85yiOaLul
	 NRi9LXhyMkEoohpy/MwBnHhg6L7APbfjNp4jIwYn3B+A3NyYr1Hl0MTKxBZrkPZz0XEWp
	 +jJetK5sHmXgRTaGUpNGVqJ7CygDQiVuImqckp6l5qY/wHv7pfWkDUcoU2oQOR3bG0Bet
	 FjfIGGNWvVr506QQd++QYKX04OQmK+YGXHri36Dgt8/J3yTbpjjJcRZE3j5JQBkPBRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S57kPln7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S57kPln7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01FF1F008A1;
	Sat,  7 Nov 2026 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047409;
	bh=w9KxajrO1lYOlaeSWdYoUkDMoLeXq6nMrYoy6MRt01k=;
	h=From:To:Cc:Subject:Date;
	b=S57kPln7ShD30V/+R78lasMqxD/A4IT/wdJECv7YUe3n4WZjVHIndU6Qxige1VNAc
	 wRVMPZFoSvfD+4/TAgoZfKxYSIhydV/xdb90g1ABW/kIOXoo9aqVb+KB7a7AAEOZ3w
	 YOxtXRIfmOnLn1okcLtb2F0zzbQxCKRboCATNIw+/AQ+ZBLGZ4FG+G/kkE8gARsoc1
	 1mu3WW4mISXMS+Zf+Ig1fKgOPc+GTyo4JjWLlDSoAeSGui3CqH2NyEUql/EkY6E9/W
	 eazBO1e/7b4iMd8ItFQZ/FRnC5PQOxJllgA0p6GE8yok3U2iWXj+beeGIZ/huy580/
	 auOgTCn4qhxhA==
From: Sasha Levin <sashal@kernel.org>
To: francesco.dolcini@toradex.com,
	frank.li@nxp.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:07 -0500
Message-ID: <20261107053007-failed-6.6-f377ac5999a5@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f377ac5999a5d045168ddd25d204691c6653c06a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053007-failed-6.6-f377ac5999a5@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f377ac5999a5d045168ddd25d204691c6653c06a Mon Sep 17 00:00:00 2001
From: Francesco Dolcini <francesco.dolcini@toradex.com>
Date: Mon, 14 Sep 2026 20:39:31 +0200
Subject: [PATCH] arm64: dts: freescale: imx8mp-verdin-yavia: fix external
 GPIOs

pinctrl_gpios_ext_yavia (SODIMM 64/66) is defined but never applied to
gpio3, so those pins stay at their NAND reset function instead of GPIO.

Fix SODIMM 64 to the correct pad, MX8MP_IOMUXC_NAND_READY_B (GPIO3_IO16).

Fixes: b694fbe2ff40 ("arm64: dts: imx8mp-verdin: Add yavia carrier board")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi
index f3d28e23ba6c6..2a90f312fb275 100644
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
2.53.0




