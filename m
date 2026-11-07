Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049536;
	b=rsy/poLlqEWkEMg2nM5TIXM4qdsCMIX5XOEWxN7PmOlMZ7nsqLIU61wnY1vZoJDyNawb
	 OFJoVn00zknQIKIVodggbO5ne+Ctm72YQP9r8hWRlbkVBFY4Ed6NtUh2c6ACQ7WO1FPxS
	 C7+R2papswcnrJaGaDgnhGfVx1reqqtPy1fUHqWVm5HWYbo2wphnLwEkgxiq7uSM0RKGz
	 QVDb6iKU0t9axvgWmshS31J7tTVo5bzxWzIWYqYvp7cRc7OQpo4p/XqgcFs29VarX+NUx
	 eaXP2MSIIDayzs5Na99MHDAGfrPfNdIKcIomFXRj++MUsCDpDD7aM9xc0Ebwcw3OmvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TTAZQzRs3dlaFCmQso/PFWc3l9JkdasPDRCZZlFlwNk=;
	b=A/r7CT/Sfh+o0c8pc5wbqWjiGARb2cKwHD1qh5QprKCH5EFynltAdUX37jMr3k9KmaxE
	 Dkf3udOavk8hlsCxxjnyQ2hdZ7n/5pnprIRhGTW+RAZQ1aQ2r+KXz2iZMLtDvTWrDVJ5+
	 C88mfyvHZClfr5ZFmmEATY3dNPLcXp6UzCj+n7xJxQWB5fd9IqWRtjUJjfgKD646SrHqS
	 SaGHCCRRWEye3vKrb1EWQ2YPm5EkOpe5EOo0kiM8wjgo4Ncy/oH87K1+lQRP4C083iNNa
	 /3boTU78LN7ewbXNP3hBdsZXwVHn34p4n7w6viwEYNPE4GLe+aFr1MEe5TzMEqyZr1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9oTUWxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DD7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f9oTUWxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD581F0089F;
	Sat,  7 Nov 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049536;
	bh=TTAZQzRs3dlaFCmQso/PFWc3l9JkdasPDRCZZlFlwNk=;
	h=From:To:Cc:Subject:Date;
	b=f9oTUWxzNxQ+N3GEgBrMbzBDyMnqITUmS1S6tRHzMoTPIWedPcbbZijgLyFq2r8SE
	 GbQGr+2tT3bxQkS/3rpPmIxVjsBnbe7g2rjHUMcmmN6jDZv3aR3goj1/W9AlkbltCO
	 xxFGsrk/NHDToj1X0E2yUIooBeOCvRl1swRX0fNBuQ4j0dALjINKlNqCila2Qak9PM
	 CGzgu29IIpXpiO5STf35l38zaF8nOF1hBGHUJOMeXolfgY0ghw8/8MsBx5COMEv+sX
	 v5r8pVBfXueYMgj1Queu7mNxMv48ObWRv6Z4Ih+0xwKikjnll775sa3woB006SnrJA
	 GnGlvZ41Dlilw==
From: Sasha Levin <sashal@kernel.org>
To: geraldogabriel@gmail.com,
	dsimic@manjaro.org,
	shawn.lin@rock-chips.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	bhelgaas@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:34 -0500
Message-ID: <20261107060534-failed-5.15-2a1e6c382fb7@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 2a1e6c382fb7567679c07bd6a7060fefc7a5edc9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060534-failed-5.15-2a1e6c382fb7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 2a1e6c382fb7567679c07bd6a7060fefc7a5edc9 Mon Sep 17 00:00:00 2001
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Tue, 16 Jun 2026 12:25:45 -0300
Subject: [PATCH] PCI: rockchip-host: Do not attempt 5.0 GT/s retraining

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
---
 drivers/pci/controller/pcie-rockchip-host.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d203c4876d304..0b52f2e370f41 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -328,26 +328,6 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		goto err_power_off_phy;
 	}
 
-	if (rockchip->link_gen == 2) {
-		/*
-		 * Enable retrain for gen2. This should be configured only after
-		 * gen1 finished.
-		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status &= ~PCI_EXP_LNKCTL2_TLS;
-		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
-		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
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




