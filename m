Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280183;
	b=vAroqCb4XFOwI8Pmyac1cIpfj307zkimsgS7lWQnc7KMRz1tgFHXWqZllFvvyHh1zobs
	 u+LhC3QRt6DHm4fxfBgflQX7ots/RtYCuSDM8wJ55ThDYD2HeZHut8qj78I4oETQ1rrLt
	 Zqt1a4MN3Z6HlYOjzZoc3DN+Aze/+PfJmgrdgeruecnVAPbhs+s+xehXdC9Ti1sWx07/q
	 aFyzw+2BGPNqOI0CjBwlx+8zfVF8op1mqca/nbrDthnjga+g0OBmH7NUgJoIRxN3/SLnf
	 Ps97oNb7wcs9BD92UB/pKWANwz0XANkxOC953vp4rwyfX5ugxN8aA8adS37Ac8ZLQvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280183;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OHX0dBe2nts+YUp1fW5jbUx1P7/qBwELD3RGh0H/zh8=;
	b=mmtGTrmNGp8Fguzx3kfRBt+dQ7RyijMzi1lvOf8XJgXhBo8uNutgZw/58wxcZDY0NMnT
	 AvxgfGRiLMzcD+GVPwUbUVobmdXGlQ0LbDqXak+MYFR/rng8vSkDW5TJfuSDIvU7cG44F
	 3lMigc+tr1DTw65nKigfWwful40aOXDCOPvZ+bmOfxiXEA2rSMbybi/HNQz3+nEOZA8pb
	 eUJr4oPCh6zfCi/z3KA+19RAaa3B23V5Jqo1d/ls4/Tz9usUqT8E35l04AdZJ8+J6hh8G
	 lKdFdtFBXgQ9EGEANVMz2E5X8h/OCIgM/eeY9jLffFD2jPDcETcEctUtqTjAbNkmX2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFxWhxZx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFxWhxZx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10A41F0089F;
	Tue, 10 Nov 2026 03:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794280182;
	bh=OHX0dBe2nts+YUp1fW5jbUx1P7/qBwELD3RGh0H/zh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFxWhxZxeZ3nmzRvFnugHTx2p4QwF1VfDJGO37KnXlrcS7Hg2HHbWLIgjR7DLz5CH
	 k3qaq8P37HUPtU+dJxzGaif4x2ynC3xB2Hv9PRT4AGIXfslIIvsif9W4T01uRONdkn
	 qTDsUzf35/HE7FTI2iue24Azt6NJo9KhmNlnDZO14V8+ySLxfVCdt7hoKQDYIGQ09M
	 ccXt62zZ9WI28bjUb/xBjafdU0eWrdG4hIBwa1TbrLFwFqqivQeSfh4NM1dNrbyCP5
	 X3XSY8ZeNwh54e/lvMdm8UoZGnK4FiRoiPEvRRQBgWg3ra9M7basLQjSZ4NIWgoD2+
	 pOTz57gXOnPyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Pesaresi <andreapesaresi82@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: mediatek: mt7986: correct timer frequency
Date: Mon,  9 Nov 2026 22:09:40 -0500
Message-ID: <20261110030927.41914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054114-failed-6.1-1cf18e4b9815@kernel.org>
References: <20261107054114-failed-6.1-1cf18e4b9815@kernel.org>
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

From: Andrea Pesaresi <andreapesaresi82@gmail.com>

[ Upstream commit 1cf18e4b9815beaf0439c5b57b65b45151c82ad7 ]

The MT7986 architected timer runs at 12,986,200 Hz rather than 13 MHz.
Firmware reports 13 MHz through CNTFRQ_EL0, causing the system clock to
run slow by about 1062 ppm. This exceeds the kernel's 500 ppm NTP
correction limit and leaves clock discipline saturated.

The corrected rate comes from MediaTek's downstream OpenWrt feed, where
it is applied to both MT7986A and MT7986B. Since upstream mt7986b.dtsi
includes mt7986a.dtsi, add it once to the common timer node so the
architected timer driver uses the actual counter rate.

Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")
Cc: stable@vger.kernel.org
Link: https://github.com/mediatek/mtk-openwrt-feeds/commit/6a4c41c41410cd5042ad10c39da6593ba036283c
Link: https://github.com/openwrt/openwrt/issues/24789
Signed-off-by: Andrea Pesaresi <andreapesaresi82@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
[ sashal: Adjusted context for the timer node’s earlier location because the upstream node reordering is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index c647d99c9554a..b595c08701658 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -81,6 +81,7 @@ wmcpu_emi: wmcpu-reserved@4fc00000 {
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
+		clock-frequency = <12986200>;
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-- 
2.53.0

