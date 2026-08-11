Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E346412BEB;
	Tue, 11 Aug 2026 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435830; cv=none; b=BLECWkoWVbDoy3LDQBrcLROTTo4il8bq2JoY+s4pF+qfmvG53XO6MXyb8sSmLHT1xblPIKUEYZriCtT/uOnmV9r4KDchz2gyeE2p4uvFtR9pN+UkSuPDeOpNSsTbDNGl9okCplxA+KYpOBUfwhGqO3T2z8f2F6L8dzpKR8BtdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435830; c=relaxed/simple;
	bh=tSdXxSArn7IbenIVBMGRTaWfj6BMz2f9MqrXBEtHgwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dkQj1MKI0RD0E/0u0o9ymhVm+OCrb+2ybXcWpy9wZkeU3kN9epljAEmLUiXN03lZgMfcA5a5aoBG9Z7aoIisNl34B4tmELW7Vk1KEZtIUirBdBkMuqk2eJ05JR/AHotkKiXe6fnmfLSe+WOe9Hfd/y+lOY+5m3irF2aJeGw+rBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp0JwN/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp0JwN/N"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0548FC2BCC7;
	Tue, 11 Aug 2026 08:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786435830;
	bh=tSdXxSArn7IbenIVBMGRTaWfj6BMz2f9MqrXBEtHgwc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Kp0JwN/Nuv6smsdkaJCH9aXnuSIrMwT/7GG2g1/a6WKH/IvoW9qxSdgvPiHizTHkr
	 ngQgfbmdvGiuaZaRdgG3yP4347PA+L9aHafqOKSokhUgBOoeiMiCq/q5YoxoNYwTKW
	 t21NPZ6HlbQjmLJPw8P+k3rrm3mX6Y/rhBh2Q0X85azN3TiWCwbtA5miLIKDEH9pmh
	 o7i2B0MXj6j7t4EVCZKdXwgvSDsxqPcTzbHbCnLMlId59JNKpVjEkMqQ+1IJrQQEP7
	 Y8/8AT+Rttl3o/ehF/BzEbBR9w3gJYnWCmWdAxdfFifDx3djBI/R6RToAXiUO3ret8
	 WJlvuT53WZq5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C81C5CFC1;
	Tue, 11 Aug 2026 08:10:29 +0000 (UTC)
From: Jason Yang via B4 Relay <devnull+jason98166.gmail.com@kernel.org>
Date: Tue, 11 Aug 2026 16:10:22 +0800
Subject: [PATCH] phy: rockchip-samsung-dcphy: fix out-of-range max_register
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-dcphy-maxreg-v1-v1-1-aa63f6a63a64@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO3YemoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3ZTkgoxK3dzEiqLUdN0yQ11zk0RLS0sTk+Q0UyMloK6CotS0zAq
 widGxtbUAuNUpvmEAAAA=
To: Vinod Koul <vkoul@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jason Yang <jason98166@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786435829; l=2208;
 i=jason98166@gmail.com; s=20260721; h=from:subject:message-id;
 bh=qv+04pxhwLXk8iXSSS/x/7Q7kow98bcT2dkV1hHRCgE=;
 b=qPMHHnolquLwGtQkH83g6tkOLMluIQXScxSMyabXwKUys0ySRfFH3x7IazxR8A1svJxuiZgRQ
 8Yf65P8a2Y0B0W9UXGpqIzVRgnxJ04M/eQKnfOOB5KihTSXT4RDQNIp
X-Developer-Key: i=jason98166@gmail.com; a=ed25519;
 pk=xQmD001Q/ooHl39PxyQtusbUQmgbOsSfpFryRVWZ/k4=
X-Endpoint-Received: by B4 Relay for jason98166@gmail.com/20260721 with
 auth_id=887
X-Original-From: Jason Yang <jason98166@gmail.com>
Reply-To: jason98166@gmail.com

From: Jason Yang <jason98166@gmail.com>

The PHY register block is 64KB, so with a register stride of 4 the
last accessible register sits at offset 0xfffc. max_register names
0x10000, one register past the end of the mapping: dumping the
registers through the regmap debugfs interface reads beyond the
ioremapped region and oopses on the unmapped page. The oops fires
with the regmap lock held, so later PHY operations deadlock.

Fixes: b2a1a2ae7818 ("phy: rockchip: Add Samsung MIPI D-/C-PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Yang <jason98166@gmail.com>
Assisted-by: Claude:claude-opus-5
---
Observed on an RK3588 board (v7.2-rc4): reading the debugfs
registers file for this PHY faults deterministically at offset
0x10000 (translation fault in regmap_mmio_read32le), and every
later PHY operation then blocks on the leaked lock. With
max_register corrected the dump walks 0x0000-0xfffc and completes,
and the PHY keeps working afterwards.

Growing the mapping is not an option: the TRM address map lists
each MIPI CD PHY as a 64KB block and the second PHY starts at the
next 64KB boundary, so offset 0x10000 of one PHY is register zero
of the other.

The same mistake was fixed the same way in c7d436a6c1a2
("dmaengine: xilinx: xdma: Fix regmap max_register").

This is independent of the D-PHY receiver series for the same
driver and applies in either order.
---
 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
index cbd780556da8..18f5f582d1d7 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
@@ -1526,7 +1526,7 @@ static const struct regmap_config samsung_mipi_dcphy_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = 0x10000,
+	.max_register = 0xfffc,
 };
 
 static struct phy *samsung_mipi_dcphy_xlate(struct device *dev,

---
base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
change-id: 20260811-dcphy-maxreg-v1-74a99944cf52

Best regards,
-- 
Jason Yang <jason98166@gmail.com>


