Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970071;
	b=Ah3W+rH8VdQDlgIN9VYuVXaJaebKLAroKNRh3OBiELi/vV5Vt2wj8mdQccg+Z2sA2vdm
	 zWiCsa/8NN1Y8mcnqjzwSVq7Ry1srTFURWQh6x8EIX5qI4icMZ861UOAVdbnP5OMRsGPF
	 VklUdq03oxZDCy5D5GMcev3caKjpNqBgZkKlFKZlVlOOxIbiL76ehTGOTTRMQTcosa6Nk
	 TjE5HtmFo3tnwiImpLy25qkJO3569pLHeecjBwwVhoNszk5QDZnxgEDMPrCyoyykmStg+
	 VfOk9U80EpZIvaxa0L1N9bOc3gR8XiUUgJy/xFJa8R145UMW4xmz1MPo//yKJqlgJSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970071;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=DvXJcTGrWQH7Z0QlV+55M/z9iw2Exbd9dATeTnNEbhw=;
	b=fnkXXZvINwmbQhSnK/1kRkKHu6rWG7ZQHj8lkrtMTzfkDywTRucN+Fy8vEolE4vqSdO+
	 vfuqvijVvEqpKKUTqQQ56JIG8UW3RZsiShzCnFrhEIFobjjXOWFobn84Oapd8vZ78qEdg
	 2LtK6YPZ9LiRpEjkh6zrJ0nsxKLnVTZm1FWELqheaTfpFR+UgUUryJefuIi32le8yR7YT
	 GSYhcihdSSAs7cD52yhns6OBf7Qqu23BVjR2NVbh+irQdcVLaMdpU3YcJNLXTCw3CTCTq
	 PIv9f1sIrcBWVspXAsP+RK+5xUexgTse74thbjLTja9vYqDRGYn5u+x7qjTInl+V9gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=timsurber.de;
	spf=pass smtp.mailfrom=timsurber.de;
	dkim=pass header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=IOhvuMLg;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6D606A31C;
	Wed, 18 Nov 2026 02:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timsurber.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timsurber.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=timsurber.de header.i=@timsurber.de header.a=rsa-sha256 header.s=MBO0001 header.b=IOhvuMLg
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jTmGz1CZzzKvhH;
	Wed, 18 Nov 2026 03:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
	s=MBO0001; t=1794970059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DvXJcTGrWQH7Z0QlV+55M/z9iw2Exbd9dATeTnNEbhw=;
	b=IOhvuMLgXkz1Hkzo2ppxZp1CUzkWNUvWS51fzC5gnyf9RmPVh/Ufb76QeYOErae4M1uJAH
	2MBJ1dFPYWCpl50x2QQmSWoB+tDQ2DlOBg9SSEcQgnLTt73+06aLrbYmGwWk77jmOmvMMS
	bc6NlmLNDXceTfh/6IzFDNROcuxezetUNXHOTNMNuFGJe69y6Kh1duY8x8nxu/0ai5Dao8
	XuGC/ruJgLd2yqgUouDHAa5UN8IaB5Lrb7jabKYueHnBm2/kUZzCh2htHWK2r9/Ja9jH+f
	9+W5PO28zEuMWdY6+FiJ0jWgDgi/ktIcFl4J8Cbx07XB9FNFQCJaU+Udrusg8g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of me@timsurber.de designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=me@timsurber.de
From: Tim Surber <me@timsurber.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Tim Surber <me@timsurber.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Valentin=20H=C4=83loiu?= <valentin.haloiu@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Fix HDMI RX 5V detection pin on CM3588 NAS
Date: Wed, 18 Nov 2026 03:47:15 +0100
Message-ID: <20261118024718.1540336-1-me@timsurber.de>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Queue-Id: 4jTmGz1CZzzKvhH

The HDMI receiver node uses GPIO3_D4 both as the receiver's HPD output
(hdmim1_rx_hpdin) and as its 5V detection input (hpd-gpios and the
hdmirx_hpd pin group). The GPIO setting wins, so the receiver can never
drive HPD. Sources then see HPD asserted all the time, may read the EDID
while the driver is writing it, and never notice EDID updates.

FriendlyElec's vendor device tree for the CM3588 uses GPIO1_D5, active
low, for the 5V detection [1]. Use that pin and leave GPIO3_D4 to the
HPD function. Tested on a CM3588 NAS with HDMI0 looped back into HDMI RX.

Link: https://github.com/friendlyarm/kernel-rockchip/blob/30d3e1c2470a7282f37b96fdd4354314dda69aa3/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev09.dts#L299-L309 [1]
Fixes: f9f45293f0d8 ("arm64: dts: rockchip: Enable HDMI receiver on CM3588")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Surber <me@timsurber.de>
---
Changes in v2:
- Shorten the commit message, keep only the problem and the fix
- Drop the cover letter
- Capitalize "Fix" in the subject
- Add Cc: stable
- Link to v1: https://lore.kernel.org/linux-rockchip/20261111210059.3489502-1-me@timsurber.de/

 .../boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
index f4c34da61c4d..b2df36113d22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
@@ -376,7 +376,7 @@ &hdmi_receiver_cma {
 };
 
 &hdmi_receiver {
-	hpd-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
+	hpd-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
 	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
 	pinctrl-names = "default";
 	status = "okay";
@@ -571,7 +571,7 @@ hdmi1_tx_on_h: hdmi1-tx-on-h {
 
 	hdmirx {
 		hdmirx_hpd: hdmirx-5v-detection {
-			rockchip,pins = <3 RK_PD4 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <1 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 

base-commit: a9d78db32fe78bdbe7c66ba77cb7dbb729b885de
-- 
2.55.0

