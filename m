Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336AD49C4C9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954047; cv=none; b=iuDjkgRnqHiizNG0RmjOr3/NfZMO3ccCa9oj1LutRVWN8qiMwojgnQYEx5rx2Jms3aqgNkb/CUbVI9pTVVIGtdNjWsadLpuirqXh6afRaTXq+YqOXzVFCdeBUM4FjiejVPwa5SbUXqtorxuoQTMybcFTADiMv6v3Wbvj0pYIlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954047; c=relaxed/simple;
	bh=AVM1bbJQ/k03tZwkf1XSoLeeyLolyE5fJScOzpIjOmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWeBBSX0XVycgXL6O/0i0FAbiWzaDGbdR+7akuxEUf/TRbuoCYX+p7JszTFY62yFhSW+3yb2yMLrN7dYnT38JtNjTSGPEPt9KuNo/jKXD159j3cg1bSX2SaQtCTIrtTRjAOh6eff3TueiuuEJLHqr+s76I2VgbQ88GRNxlIphgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEn2jlL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEn2jlL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966E11F00A3F;
	Wed,  9 Sep 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954046;
	bh=0D23dkHdLbW8i88xVC0+HsaMVG5KsPFtWZAIrYo28Fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEn2jlL/hBUyyxzvr7pL67OmYAfH0vTqjv3KwOiFGlGn/+G5r54U/M+/Nu+p8PQ5F
	 TwUhBC2Ow9wH4iXAq1UTmdlAbadX6jzGAt9+q9FxA1w0oV15EqCEDsQm4R6wIdWrBT
	 XQlWjwmivPVXfYJUgVEMeWtzUmxWYGBV0nm+xl3UM4tSISQfppjTs/3p9MzRZXkR0Z
	 HE/VC7KLgkG1hukFEEzMYASVrK6yfxkpi+hEg6S8DYMe1sKNh2HzfN6xciBd4ztDxI
	 HetzJOcyjrWHlG4ynbsC+H7OdPwVwVGlsH/S/n2T24rlnY1dgtXtNcq7Wpjnp+Yr+1
	 Qcay9d4TgdC5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] PCI: starfive: Fix resource leaks on error paths in host_init()
Date: Wed,  9 Sep 2026 07:40:43 -0400
Message-ID: <20260909114043.1916582-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114043.1916582-1-sashal@kernel.org>
References: <2026090319-enviably-stuck-b18b@gregkh>
 <20260909114043.1916582-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ali Tariq <alitariq45892@gmail.com>

[ Upstream commit 22877a061f81c5d58041e384b3131684bec636b9 ]

starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
optional regulator in sequence, but does not correctly unwind these
resources when a later step fails.

If starfive_pcie_clk_rst_init() fails after the PHY has already been
successfully enabled, the function returns directly without disabling
the PHY, leaking it and leaving it powered.

If regulator_enable() fails for the optional vpcie3v3 regulator, the
failure is only logged; the function falls through and returns
success, leaving the driver believing the regulator is enabled while
continuing to configure PCIe hardware that may be unpowered. This
also leaves the clocks and PHY enabled with nothing to clean them up.

Disable the PHY on the clk/reset failure path, and disable the
clocks/resets and PHY, then return the error, if the regulator fails
to enable.

Build-tested and boot-tested on StarFive VisionFive 2 v1.2A

Fixes: 05a75df4182e ("PCI: starfive: Use regulator APIs to control the 3v3 power supply of PCIe slots")
Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260716102053.185276-1-alitariq45892@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/plda/pcie-starfive.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 298036c3e7f94..628f8c8d67471 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -304,12 +304,14 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 
 	ret = starfive_pcie_clk_rst_init(pcie);
 	if (ret)
-		return ret;
+		goto err_disable_phy;
 
 	if (pcie->vpcie3v3) {
 		ret = regulator_enable(pcie->vpcie3v3);
-		if (ret)
+		if (ret) {
 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+			goto err_clk_rst;
+		}
 	}
 
 	if (pcie->reset_gpio)
@@ -379,6 +381,13 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 		dev_info(dev, "port link down\n");
 
 	return 0;
+
+err_clk_rst:
+	starfive_pcie_clk_rst_deinit(pcie);
+err_disable_phy:
+	starfive_pcie_disable_phy(pcie);
+
+	return ret;
 }
 
 static const struct plda_pcie_host_ops sf_host_ops = {
-- 
2.53.0

