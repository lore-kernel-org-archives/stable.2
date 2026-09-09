Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819E53264C8
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980846; cv=none; b=kAwQtoEpzKqj1QhpC/M8qYWIm96Jiazq7gQw0FHvy3xg07bV63tJ+JYzJhadWPP3v1khXbydEzp3rMUiR9ZicbX4AD5lPZjbVlcQSapbd7uWnxTmcMcFXzC5MwZwdM6B6WoINi8tcGYhWIahOmLpb+g24JWBnMg4qXnPp67Hl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980846; c=relaxed/simple;
	bh=jKDnQ4dr33p5/mKicqKLkcMyQ7lAvEOLw1MiQPNkGrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGjo4s5Qk3wX2AxAK6fGDq7GaXgcLRPvo2OpDyGNhSCOTCeqHyo/jSI6SrustGe5FGSleOLKpBWodcIr/q1YbYeH4VwV5tctiTb2cdetKH8ZA82rPfkdXp5+4+W4A/oR/ib9/48hONRlfuqRCKtlSFcWGCZC20vvuRlcQWnyMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkEPy4Qt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkEPy4Qt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55A1F0089A;
	Wed,  9 Sep 2026 19:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980845;
	bh=gbgmgp1FQtxPkdkUx8/i/2jDH48UViefg/EqcLGDEdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkEPy4QtOIpFb/8uiTF3Iw5yFywQVD7ZDL2e46pWen27q1ueSN9c0SYp7+GbFO6ZL
	 5ScQ6o794dFBkDF6InisAsvmuDeNYIzTA0+uya58RTnDeeGNs5wqoxVWTUo7yUz04A
	 Wd7SjurGKQlyiQMTBGg/PCAGsMCA95hnKFYpLgYdotV4dYi8/WlWLunbPr4UKsBI37
	 O73SIhIqycBRf71igZxaeA+osEYm5zHYKsHG5VkZ5Yk3rGyYsDvMoN4EXG2fM7AJ6U
	 r08Ob2bb6/J8fhMRV2145gLBJej5SRMw/rxlHKSctEeGfkysKQoat4Nlf9JDlmc2xw
	 bqv/rIXSQbC6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/5] PCI/AER: Emit TLP Log only for unmasked errors
Date: Wed,  9 Sep 2026 15:07:18 -0400
Message-ID: <20260909190718.3536304-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190718.3536304-1-sashal@kernel.org>
References: <2026090327-unfair-disagree-3067@gregkh>
 <20260909190718.3536304-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit a8bf2dd750de7d682fdaa2127f4e3217ce9c4a82 ]

Per PCIe r7.0 sec 6.2.5, the prefix and header of an offending TLP is only
recorded for unmasked Uncorrectable Errors.  Yet when the AER driver
determines whether a prefix and header has been logged, it does not take
the Uncorrectable Error Mask Register into account.  Fix it.

Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org # v2.6.19+
Link: https://patch.msgid.link/2e712b96ba5bfc729d78bfc23f7fb7d285aa3d6d.1784905909.git.lukas@wunner.de
[ Replaced unavailable tlp_header_logged() calls with direct AER_LOG_TLP_MASKS checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d76f4049e939b..1b8fbe0594d99 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -778,7 +778,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		tlp_header_valid = status & ~mask & AER_LOG_TLP_MASKS;
 	}
 
 	info.status = status;
@@ -1088,7 +1088,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
 		info->first_error = PCI_ERR_CAP_FEP(temp);
 
-		if (info->status & AER_LOG_TLP_MASKS) {
+		if (info->status & ~info->mask & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
 			pci_read_config_dword(dev,
 				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
-- 
2.53.0

