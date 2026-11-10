Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321942;
	b=aVwzuPTSXCSk/N8rz3/aqg5E9r1GgHn4Lf7Y5vzu/D/q0lxs6N/nsYUyohPnUxFQneuJ
	 S1fMVH/XFiZkKDs80dsGXuCbZVID6vkW2CP799MUaB5q5LH/Z7Fu4OFzPCTljnwmA1XJq
	 588WV2XLOkMPeGAFS8kk5nG3lC80WdfBLAFDGCP+PiFGwWK949dpTjM4uF9ttJm/E1Ujn
	 OFRBnHtrBAhVaJcWbXsxL6Kq0GCEivQ7XXPBkaKM0Kqo2K9jNYksVpbw1AnMVI4LAYEIo
	 QcwHI3FQncm5QReEQRyjIVmW8BMhGK15pQutAS+mvQpV7of3h4hCY3rucPBPR+8/ujQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+0MhYwE9LkYAywqpnz73rxbOT0bhGXeBGPn2wpuNI7s=;
	b=v4d6SP8hXUZWyxsPbpgpBgGdxOp0Ps0I1JfkOPS1uMmQygwtyUe8pUyUqdVlO5/Nt4Ct
	 33e5Jc8USv1DDZwPEqnb9gP8XB+JDMvuDizndgpxOuxQoucL/VsKsTbiUclzZmKAYg6jV
	 5xxsgXc0zoYJBtG9/IwQpgH7N6oxM2EeLBuYDMHCHfEIfwQJmnuqZxaSEmxpgrj/4Bhs5
	 vAfGhp7dThgbibUktXoIp7UDUNTj+CSdLpwjCqpU/OMnVAXge84n6RJOF0WIGZzdVjedA
	 FmxmLJpkXy2uyGQcjEvbFN5rRRdhW1lTzFbVw5DGydrMYBOnUM67CNhexBjIItx4Xsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7oiiNR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58360A2627
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M7oiiNR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A651F008BC;
	Tue, 10 Nov 2026 14:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321942;
	bh=+0MhYwE9LkYAywqpnz73rxbOT0bhGXeBGPn2wpuNI7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7oiiNR5MNbrmk/tsAFBWf/Qp4EwzB2Cgv6D3sIOk5ZBzYCBxLKNpQN6tTVO7+MUu
	 8MhiqD2S8ZWwAlcCAMSD9TeFKaolcO2q7MpmDQe0lpoXgyd325X2lrMQnpEPatY2zW
	 1zJ6eJzwUS8GvBTglOF1STW/m251TxBOOpyPMGk52bM6xFQQDkAyJAOFumY+3qa8So
	 QK6QGkUVZdtb29BUCou2N6PK+JvDadULKZUmIPoI59BboYvKTB6zJmGCrCBeIETdcP
	 gHoFasam8mSxVbhjQK1RrVmLdxpVmivQKdDAHHfOs1kTKHq3GgkBzSjojjKzVkgQuC
	 lDKTKgenUr5+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
Date: Tue, 10 Nov 2026 09:45:39 -0500
Message-ID: <20261110144527.1941981-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060534-failed-5.15-2a1e6c382fb7@kernel.org>
References: <20261107060534-failed-5.15-2a1e6c382fb7@kernel.org>
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

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit 2a1e6c382fb7567679c07bd6a7060fefc7a5edc9 ]

Drop the 5.0 GT/s Link Speed retraining from Rockchip PCIe Root Complex
Mode Operation, so-called host driver.

The reason is that Shawn Lin from Rockchip has reiterated that there may be
danger of "catastrophic failure" in using their PCIe with 5.0GT/s speeds.

While Rockchip has done so informally without issuing a proper errata, and
the particulars are thus unknown, this may cause data loss or worse.

This change is corroborated by RK3399 official datasheet [1], which states
maximum link speed for this platform is 2.5 GT/s.

[1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/68f6353e3a2ea4914de36c42b6906e41282adad3.1781622998.git.geraldogabriel@gmail.com
[ sashal: Adjusted deletion context for the retraining block using PCIE_RC_CONFIG_LCS and lacking target-speed setup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d2fbf73ddd648..1e39795ecfac7 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -338,22 +338,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		goto err_power_off_phy;
 	}
 
-	if (rockchip->link_gen == 2) {
-		/*
-		 * Enable retrain for gen2. This should be configured only after
-		 * gen1 finished.
-		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
-		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
-
-		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
-					 status, PCIE_LINK_IS_GEN2(status), 20,
-					 500 * USEC_PER_MSEC);
-		if (err)
-			dev_dbg(dev, "PCIe link training gen2 timeout, fall back to gen1!\n");
-	}
-
 	/* Check the final link width from negotiated lane counter from MGMT */
 	status = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
 	status = 0x1 << ((status & PCIE_CORE_PL_CONF_LANE_MASK) >>
-- 
2.53.0

