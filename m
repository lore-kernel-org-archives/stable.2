Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322196;
	b=eYCJdiCdPusq/WLKgT+X+g/djhYjmUTMvRQmchjXrdO/FU4qj12/YIihAaIRmq3TWnmj
	 6ChdGyUsGA12rL3tmjOtCpWC7HUZoC43MN8DX7jTYbjJh0G8iWOvIdFCZzXbakkSWH+dx
	 +6qe/gaI8qIGfpLPzCLAu2Zig6VEJiJWD9gK4Z8/a1O+rJT5JdoVup4v53Pcqg4O/g64K
	 5VKDHhTk32bLDsOWOtTvhQtBOUcIj+8nGIJTTUVU4YezNAR8eHSvssjsTdP1hPuRkejed
	 esVPTVOBnL4s6i8M0jBZg4Q1c5ILaCjDImny4ws2igLRqc7EkJprnP5fn9V5UyQ/m/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2IVwf9wYTvgD7T9TIBXpMqoJ1BasJeYj5VzvbTSTedY=;
	b=4B75HmhWN+wPUkjseYU7fyTRsjIdJUOHsTyVxYNoNZcmcyCAhkcOPtcV5avK9Y8g3mBf
	 nFOQHa5NYNpmc9c44KerVgVlcS3+3M6C2e5Bljkrlz7R/sJxwFtcnq2jGukONVTkp/Gt5
	 np3oy+bo9G9q7uqddkJiWFbwBQie3/wrqoCJTtWnAzrqYlacCw+ak8aZd/oa+zE52yCtZ
	 FrNPwkSd/qQV7ohbxwcfN0Ttl0sOkpH+Fen+ei2SKzRrD3Mj0j0B2laVcIt2tE0sMUjUD
	 OMWAf3HYtc0VlOCSsCBMhwiNw1kCsGb4j0hWIdknqPWbA6AYXtiOhkGa55tdar6KBBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaA09AoV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42279606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaA09AoV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D481F0089F;
	Tue, 10 Nov 2026 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322196;
	bh=2IVwf9wYTvgD7T9TIBXpMqoJ1BasJeYj5VzvbTSTedY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaA09AoVUm/Vqyl6OWRncpZL565faTtXUfO1ZSLM8lmEytqInCqvCm49gZpW5YA3L
	 yAAXtBbga+od7nd7rIh0PgHCU/8UPIG1R/KiYMMu0OB/CzHutZq/rgWnRMeB2kMEDU
	 6gmRrTo2dIhmuiRfw7xGbydeqHhAwnLQIP4LigychxBkAyUrShq4V+FNzQxuFvoSc5
	 FCcDzcd/iRqXisNxbNBFclEeUgsXPPgks9GCM4EnN8HTk3ukX7Eb0AvvSdNEPgt4ks
	 lDr8biCxD24BAaeR/lBDy+BEQsLHfODVvPpG1QIOOEhFNd3jrQy9j6gzIKXGAcJ6L4
	 YeKvOF0RgDgyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining
Date: Tue, 10 Nov 2026 09:49:53 -0500
Message-ID: <20261110144941.1996848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062221-failed-5.10-2a1e6c382fb7@kernel.org>
References: <20261107062221-failed-5.10-2a1e6c382fb7@kernel.org>
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
[ sashal: adapted retraining removal to the older sequence using PCIE_RC_CONFIG_LCS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 90f3e69b5d940..aa8e9f73478bc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -339,22 +339,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
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

