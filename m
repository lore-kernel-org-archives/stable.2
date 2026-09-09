Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D510357CEA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954339; cv=none; b=pfaqzWQR1FfraOTi/+cbGuc+yKBjZHc8MPahVqSH52RpsNyXnP8SysZ8usqjKMXJ+tjeBJlzVDLHS1tFOihMnLn64iR/BWgtJrva3QteYSrF9Gn6oHY81N2rRmYe+3XYuvZHCwLqJP/Ou/qfdyAvF/K6VkZGtfrvUlKsR+nzoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954339; c=relaxed/simple;
	bh=aXAKhmqugpOEvFPFlxSc7SkZn0OuELpAb98m9VJBORk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rkbm5caBM3GSjwNNa7wWDVHkhegUqZsP820edKN1kSD9W9LsoiKraSBf86POs41Oc8pSTnUtLELc6XzbUoSua5R3PoFvfLpGbkodOxjKJfvBRcbU6FtYcYMTPWwmbZwjExVqt3KOWbLtwyhkQmlRyqRvYM8AVq3wfgBkPNrTzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvR6V8Bt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvR6V8Bt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757331F00ACA;
	Wed,  9 Sep 2026 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954338;
	bh=Amc8IcEUAx3shZSY9HTWNfoQNv+PlU0N0ppqrsXJijk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZvR6V8BtJHmtjgM3w4xaFnma8iTvG+9F93KYbpFknZaq+702TQ2HCSv6hCTSCpixD
	 h+EBOFWgJ9aEBW+/89B6jq9YtqSAN/HViPzw7axZs6cgYDdwg0pROtrbDu9vRdLNP3
	 qWHtQ4qWL21xvB4RWzPpBcRDmP5WW6ukINNmpe1FjfTt4mY2vXSPkynn7LHWJwI7RJ
	 GucxY3Y3xhPGtFEVNbcF/NNhwAE1aev+igPLMWbIkTQzwRtFOcsSUY9OyOaA8eptIz
	 f8okm61MxZm5OeBvqfkr82+3g9jiEZ83m1XYaZAaAjp5Bps3DPXNxbPjUUirtxRhyp
	 X5VaoU+Wyh/Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ali Tariq <alitariq45892@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] PCI: starfive: Fix resource leaks on error paths in host_init()
Date: Wed,  9 Sep 2026 07:45:35 -0400
Message-ID: <20260909114535.1984399-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909114535.1984399-1-sashal@kernel.org>
References: <2026090319-aground-reaffirm-2ce7@gregkh>
 <20260909114535.1984399-1-sashal@kernel.org>
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
index 3234151a29702..70db6168ce603 100644
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

