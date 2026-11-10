Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289927;
	b=YkGjcg8KPIC5sEblAcAKZEaPwFI5A+eBdiAwQNPvgeBB54viiOo19Isg/1ylCreQ3P4S
	 64On3MHD4cdrUU1U1zzUzdPCJ/9XXK9Wzpzm3FuhTef5/3QTkxjMWVCXoP6cI7kkHg2H2
	 LtlYT7x+4UgphZBLv+vyOvijJdUZNOxWnadZX5S1ENjfW/K3b9plyNcDwiQEPOwdUQsdw
	 hJs/beWHF+owXZ2ZlWJpE4uBADACMGOR1NzThRtb0Koc6Zj2ODqKhMuQOgWJTsnPZ8BUe
	 imWpTgLZJyp10a8JdCqe2zjrs52QZJGumhmkpKeYVeFAPRn8ANF6JICBa0lpvbZlWow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8V7I5kEXQgM5T60Xv4Tu/syE9fA4049xfM2+mKNSkQg=;
	b=EYBDXndQDdA1v23qnGQ5BY74LQXhlQJ8A0Z43zR/SXhRxJ3UW3WtXKiRWIVBnBIWcn+s
	 uBobvOiJ1oxbA7qAzKMplIHvRuOB51xU7sGYuvGPqCHD7WHT4JyeGj52mUBM5tXIbDoiR
	 ApOnl2si6Cbfl+14/bBhcERIrUVQZBCt8sTgS7M7AIbXBUkdh8WLXT0ShWz4irYqzmRqV
	 NdlzG37dl8m6R4zIpOCXuxDXUjSZBlsZqHK+B05SVrb+5zFADWdTlcTu6s6LREsLSAzIf
	 adBapYRrwkFqgPy65eSNBqEyeIlyudDLM90yClRWYYCPlrf003o12hF18kE7/FPFORw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcZbV+rC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E540606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XcZbV+rC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD481F0089F;
	Tue, 10 Nov 2026 05:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289927;
	bh=8V7I5kEXQgM5T60Xv4Tu/syE9fA4049xfM2+mKNSkQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XcZbV+rC8k9yNlBvACQSzHuPrBcBrkX4f37ZzUaZ2oboZ0cluwkxz45FpewxtKQaF
	 tzezKZQcRHldlsAujJySYs0v6IGbx20w4KVFxwEP19z+d9BWb7Naj3bX5K2SoStERs
	 zjGVNND8/H8jn8Vhz1soKusTUNILiNU+b+InmRcSQu5J9jdj4HjeoW85vtuAUBS046
	 ZDvToX6JV7Snd4IgPBVpx5sUAw2o7c3eJnQHRLaVFFrW/AT8g9b/kxJX/Rgfw+qp15
	 izHbkGjiZKx4nts638qhrgR44XPHl0mDcBnChfmM/Csx1FbUGrpuuUQ65VHSl1EXdv
	 bkovzoo3wHHlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT
Date: Tue, 10 Nov 2026 00:52:05 -0500
Message-ID: <20261110055155.475907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053000-failed-6.6-8ef8a0e38d13@kernel.org>
References: <20261107053000-failed-6.6-8ef8a0e38d13@kernel.org>
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

From: Judith Mendez <jm@ti.com>

[ Upstream commit 8ef8a0e38d1377c6d51c06f95c64d87641b2c717 ]

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-11-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
[ sashal: adapted to the older shared device-tree layout, where AM625 SK and AM62 LP SK share the pinmux block ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 8d608c7ee2b12..1483c361807eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -169,7 +169,7 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
 	main_mmc0_pins_default: main-mmc0-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (AB1/Y1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2/V2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1/V1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3/W2) MMC0_DAT2 */
-- 
2.53.0

