Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794186790;
	b=ng/ec8gRSlc3r25asjw9gFLgcasN/+uxLTYL8vDcTFCbliTCfFz5cw2yhvP9jViKX3bs
	 VDLnqKeLLnLTskyTnYW9aW7L0NWmV1QojZEI2AUNBnsJs48OTMyiy/ram2awLGpz6AtHX
	 mZuNsW9oHk/7PPAfpLzofiyjjr5RkVXB4au9jpXZZGhMgzUQa1ksN5xW9/ytEmpqLr+r5
	 8js+P+8K/hnkIRQy4ihn3qRjSbC6bmtukBtj5ewXTfxZO+shoRJoznbCTpa2ohUllKBVR
	 qdFYTB+fPIuT3uQYlM9AC8I1KPLqiG8xybz5g9FfTY+34os7tVKyLShwNuVIjwc9rLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4WCF4P9vPVA9cU7Tv+J0UseXV6GQroxb3gEfse06vk=;
	b=xIIsR00dErj6KLm2nocDVHUucb5XUMUHISkuYKfRR2PbmSWgVkRlee9/SBrRq2RCW8yq
	 KxxsipUzV+MKeXAP8ELnnmjDsPbe/WIu46rWeWJNR8953IpbAc/GsjYfiJ7XPwJdA8Gz8
	 HLIDPly699TygV7KRqiUQepA+ztzYwTwkmbSnIPKU651aC7h6ODYSDXdCUxOYul1oDLMN
	 DQEOrhhYarsSDJTGwA9WWyvSg0gJdxxGR4g2swNBeoB8jm85kDiqaVDnNAJXwPC8kAIBa
	 RqNmCQv9ZTAjQkxxpgewypL1dkRQnD3MZp7LuRxWJPeIiEVanO5v4TJbdCfUActi4mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jpvTyjk/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1388606A31C;
	Mon,  9 Nov 2026 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpvTyjk/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794186789;
	b=HqkDk+o/mRP/jzqyr8a0kQjiVo2O0bzD3K+K297/YODfcHJ5FQMKWHDOZqpdiRaihCrH
	 tRCX8JFAQKJxkujgV5UhOeCN4uDBShEHPxLrzv/5DHgiguJr1GEioElfqKSKh3fA2L2DN
	 tDJf5cTcpYajht/2GJzNS0OQsIPjTU1KqxbpiX5mFOo7sVfD+BLKAQkW4NtpoIntXojFo
	 UEtMAjHS+tcBWAZmBtC4mDo8GAowqJa99Fwp4Ld30JTzMGnQTR6x9HM+9yBN7nyXhgniN
	 4OycmrkjfBoEGxJXUDP+4ZcCuppJxgpjTl4pnMMw9p2Ewf3ARVgEd02CxFgmkbCoBhw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794186789;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=M4WCF4P9vPVA9cU7Tv+J0UseXV6GQroxb3gEfse06vk=;
	b=VQo3GHlgP35LXmM7hBUfgV70W2wEUyNH0MnGolCflW0hlwFnQypfLh9uDHaymwYlOSjF
	 86Rcr+rfRLDat7/4TZ5eWJMvrQKqWI1jJVK3adaPtH1ohwTC657hHto8hHJmk5gajCyOU
	 58wnCeAYT6KogkXeWp0o/1pvQ6vfEpf8HG56iS3SxyBJgzM9JMl/IV9qS4C1pFj0+Zp5a
	 Q+iTaHOGHF+xGo8CVT4xbglaIf3wW1tIKwpopn2zulJCzWl+DlcaEPLbOkeMn74ptPKR5
	 4qr35BH4AbBWiz7SHa44Tx5KRo8lJcCE7lNwmWcjeOCZBHonA1vPlsiTV79cDntWTKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9D2A21F0089F;
	Mon,  9 Nov 2026 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186789;
	bh=M4WCF4P9vPVA9cU7Tv+J0UseXV6GQroxb3gEfse06vk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jpvTyjk/fb0I/liZiqB24WRLZW+AxBb1dpFfOqONpXGH+X2CdbOKBf0xtWf9c0aGz
	 b2K84UT6bzyNB/ktSdNBIKpWpPNyQbz6iqYut730z+C4jLvdRhx7Qi6Kzi9HEqys8q
	 GrLfFAXOYqStJD3owU6ZPLTLy/906+fHnFffpux3Za1T8RCZwwkTQMKbvvchD+JA3p
	 IPkhPGeOWCng9JJw57TzSCUMJ5kiw5hTWRA/V9qmR1bvr/zDZTXQc82ZctC4D//WHw
	 b785I1BBopf5RLI6i+/b5OQYS0mZp5INxPRcE8s6uOUmh4xPXoViy1x0RM5HQQXV8Q
	 FvyW7af9dezPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E5336481E7;
	Mon,  9 Nov 2026 01:13:07 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Mon, 09 Nov 2026 02:12:47 +0100
Subject: [PATCH] phy: rockchip: naneng-combphy: fix RK3588 SATA pipe_con1
 register offset
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net>
X-B4-Tracking: v=1; b=H4sIAA4e8WoC/yXMQQ6CMBBA0auQWTtJO7WEeBXjoq0jDEYgHTQQw
 t2tsnyL/zdQzsIKl2qDzB9RGYcCe6ogdWFoGeVeDGSotobOmJ/ONw2m8RWnbkUNcyCsWzQuRme
 st94TlHrK/JDlf77eDus79pzm3w72/QseLD3mewAAAA==
X-Change-ID: 20261024-rk3588-combphy-sata2-6g-03bb30151552
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Powers-Holmes <aholmes@omnom.net>, 
 Lucas Tanure <lucas.tanure@collabora.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3342;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=jlST7yEBtCPASzfQnAPw8q1ZkwqNOjqfjEA41xMvY/o=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBq8R4jm7OV4UEZAdR8JkXG5eZsGJPwj1sBnGC/K
 PdtxEN5/k2JATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCavEeIwAKCRA7Xj/jnsft
 6WQWCACpnX6vXbIOFFGIjGte8vXc9/ErH0o2XWlf2nqbLvgp3rSw6bTjqbhrhX2OuywVjojnqh/
 6khuk8OfiBwqUFDKqwYmRTGWr4BoABoM87ivNn5mXU8R6p1EugVNX5uNqfvYHzXGp1kRDtZWEcG
 DHJ2gacTWr5D86YdFw3279g8y+yn1/hXblWc/9e8TR36+3deh/cODH5k8diskaURtUdcMgCseDP
 j4W0w21u2FWlsKGALXGoTfaHR/H0NgGohEW+dYv59PxHSvnCqUOXy/Fso9MjgvVaF/tfwXWeO2k
 dPzwqX2nK64jpCTrxJDlRrSJJ+FOFvHLR3KobzP7R+bVxTuv
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net
Content-Transfer-Encoding: 7bit

From: Ricardo Pardini <ricardo@pardini.net>

On RK3588, the sata2 PHY speed is selected by sata2_phy_spdmode in
PHP_GRF_PHP_CON1[1:0] (offset 0x0004), with sata2_phy_rx_err in bit 2.
rk3588_combphy_grfcfgs has pipe_con1_for_sata at offset 0x0000 though,
so the value 0x2 (6.0 Gb/s, rx_err cleared) ends up in PHP_GRF_PHP_CON0
and CON1 is never written.

This leaves sata2 at its 1.5 Gb/s reset value, so the link only trains
at 1.5 Gb/s, even with a 6 Gb/s capable disk and no SControl speed
limit. sata0 and sata1 are not affected: their speed fields are in
PHP_GRF_PHP_CON0 and are set by pipe_con0_for_sata.

The register layout is described in the RK3588 TRM V1.0 Part1, section
6.17 "PHP_GRF Register Description". Rockchip fixed this in their BSP
kernel in 2022 by moving pipe_con1_for_sata to offset 0x0004.

Tested with an mSATA SSD on sata2 (combphy2_psu). Before:

  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  Timing O_DIRECT disk reads: 374 MB in 3.01 seconds = 124.45 MB/sec

After:

  ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  Timing O_DIRECT disk reads: 1266 MB in 3.00 seconds = 421.78 MB/sec

Fixes: a03c44277253 ("phy: rockchip: Add naneng combo phy support for RK3588")
Cc: stable@vger.kernel.org
Link: https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102aadd60da1100989103aa0
Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
This fixes the pipe_con1 GRF offset for SATA in the RK3588 combphy
table, so sata2 links train at 6 Gb/s instead of being stuck at
1.5 Gb/s.

I found it when an mSATA SSD on sata2 would only link at 1.5 Gb/s,
and traced it to Rockchip's BSP kernel, which fixed the same offset in
2022 in a commit titled "config sata2 rate to 6G for rk3588" (linked
in the patch). The RK3588 TRM V1.0 Part1 (section 6.17) agrees:
sata2_phy_spdmode is in PHP_GRF_PHP_CON1, while the sata0/sata1 speed
fields are in PHP_GRF_PHP_CON0 and already set correctly.

The misplaced write lands in PHP_GRF_PHP_CON0[2:0], which are the PCIe
link reset grant bits, and turns on the one for pcie3x2 whenever a
combphy is put in SATA mode. I don't know of any effect from that, but
this patch stops it too.

Only sata2 was tested. U-Boot has the same table and the same problem;
a fix is being sent there separately.
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 3102a99128f6..c469222dba8b 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -1395,7 +1395,7 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
 	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 11, 5, 0x00, 0x22 },
-	.pipe_con1_for_sata	= { 0x0000, 2, 0, 0x00, 0x2 },
+	.pipe_con1_for_sata	= { 0x0004, 2, 0, 0x00, 0x2 },
 	.pipe_pcie1l0_sel	= { 0x0100, 0, 0, 0x01, 0x0 },
 	.pipe_pcie1l1_sel	= { 0x0100, 1, 1, 0x01, 0x0 },
 };

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261024-rk3588-combphy-sata2-6g-03bb30151552

Best regards,
--  
Ricardo Pardini <ricardo@pardini.net>


