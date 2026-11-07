Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048076;
	b=GeRzSAL4IS5QiCIEsJH9kKxNz0ujilWIbMAAPDWqKXJmlkyXBZ1Vc3D2H9vQypsGWl46
	 0vFRrrvQqx1JQ1Z6FXLZ2Ecixf+pvpSchFwaASVGX3w+P6UdmPkRyyyznrg8acxviRVZl
	 DAIeIRcVEHyawaZBheuRvXKAhfLk8k5H68Tg0fVFvf8c2+AjPVex8mxu96YMmDwADCVRf
	 3A416PIWiuwcplCg+fnGYsZFrurN7nvI/N6Z9vjjT0Pcw22xOCInekoX4V2azNZi0WSCV
	 LTG3Vsw1gOpy3YcyH2BrPmQeUjg4P6llVup0g6d0bZkGGNdZifb8eipyybFGeDJSYaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=p5zJ/QJmq7IT/9+coYSrZibPoBe+eBk78co+vin0yPw=;
	b=VaoyRuK+KiSJ+klsUpdbFpC++hmTaqsm0vdZo4VuRo7tz+f868Yhbweba5b9xZi+lWVO
	 4Y7WqoA/w2nPe05mnXWFCpi0NRf/VvsUfb1thwlW/EcxCK1vqxfhP4Dy2VOHzuDvcsfpS
	 RxHBQmazilyd00Jv+NF7Kn3xZtbM3dN64Jf5SqWzDppIP/A3KtV1xm7CpAs2ViIb7C+4F
	 799WKVgAQoVFObu3XUcOl5JExU5HSZBBHTOI4BV+JX3I7KcXebwQwJyntbtc6SimB5I4T
	 zoXjD6T6UtuM/BbOkLn76N27y8Az2XVngXBHaWS7BPMPbbittEgZc4+/sFhSvyGZxLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbD+dWRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YbD+dWRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA11F0089F;
	Sat,  7 Nov 2026 10:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048075;
	bh=p5zJ/QJmq7IT/9+coYSrZibPoBe+eBk78co+vin0yPw=;
	h=From:To:Cc:Subject:Date;
	b=YbD+dWRmfXoVagymA3ttAoULu+BK/QM0WjDZ4sn5/oS+dZGSAXjy2YyZ24Wl5B0H9
	 ElUeffdMVUJQcRiN+1ZaN83E6MBznRi6Yf8iShgDpoZA33UGXW6fyEmT82lSjrycq+
	 Ps4EIi23h5saunv6HNUHjRpWG1zNA1FkzNvh0M3TqJWnw+9cvM3qKAQsFOWN6cBxf9
	 w0NcwS+2NvBeGYhu/yPt8TcBAQvqLbD3vg95yv+QU5F6kW4bE8X6KVOZJnHroVbdOi
	 LSYx5/eddVVC4I4IYOc9wPz0sOr9Jco7/03XT1G4K8T7cKEiGHn/UTK3EKDqkMwVHv
	 zJ7V50Mg2SRAg==
From: Sasha Levin <sashal@kernel.org>
To: andreapesaresi82@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] arm64: dts: mediatek: mt7986: correct timer frequency" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:14 -0500
Message-ID: <20261107054114-failed-6.1-1cf18e4b9815@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1cf18e4b9815beaf0439c5b57b65b45151c82ad7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054114-failed-6.1-1cf18e4b9815@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1cf18e4b9815beaf0439c5b57b65b45151c82ad7 Mon Sep 17 00:00:00 2001
From: Andrea Pesaresi <andreapesaresi82@gmail.com>
Date: Sat, 29 Aug 2026 17:19:55 +0200
Subject: [PATCH] arm64: dts: mediatek: mt7986: correct timer frequency

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
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 9ebc196107e5a..318639a7c64e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -657,6 +657,7 @@ cpu_trip_active_low: active-low {
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
+		clock-frequency = <12986200>;
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-- 
2.53.0




