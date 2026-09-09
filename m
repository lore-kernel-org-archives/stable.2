Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5A581250
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971213; cv=none; b=VeEEkF2lX9R7iilSi0zmQvbC2nut/MBrcLCzX/UvJ9f1uTFSCzRVZUM+5iPqo9yYX8oiEXXV9fg8ICSK/KhcQbIFO2yXqBIJX15DYwswvz4MV30wyeJKa1g4D8xA8A/3sudjXJbxlgk1ktw2bKOcv3BJdXTb5iWVVsN8s58OSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971213; c=relaxed/simple;
	bh=Y3plZ8ox10nzBerXh0CVi01/tqDOZz0andBJTfcr4BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXI8fcFqqXnij3ylaluG919WED6qvDcGPjdjz9yVfowzAmdA5opl5R4CRI5Sav0piINArYolHsdr3Ft2bSn3krBF2EIoqR0UCi7jLA5GKDPNpN+z+NLNhWw1qNjcCAti6l5Rl+T58N8XAWpAIOUg+t8Jr9bxS81y0FyzS4eqhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmYqSwRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmYqSwRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF51D1F00898;
	Wed,  9 Sep 2026 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971212;
	bh=wwvcfBa/w7YEKA4wtWtydR58g33Lm26BVNFTAeILs1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmYqSwRh0vqiTQbHx8I/HE57dgAOt0bGBiF9vdOySvAoXdIuRIWngCG/l1XkfuUmH
	 RzVycRL7vmatuOWHiMyvvBJFM6MVypUAgqQ9wHvtppT3o+0FLHmBMyfQx/lkHlOhNX
	 1dlKFltHRwonKfRuYtIwqRfCbg35oFiBWypZbQ+Ut/CgavZZaP2/CkpUWntQOYk7Qq
	 9qbqOXe3y2QPxj4Ck4NtEvXXlXYWIkrr4FZZ2Gy7i1/Cu1Rgkk8iPS65/UY3Lyvoxa
	 2nabjlLIVMCq+hGOiUJT8xKiHrY9/Td3Uvd1s1Dpns7iDeV3rw4JaAhyW6FHSm/svP
	 DtisxD8M3CtgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 6/6] PCI/AER: Emit TLP Log only for unmasked errors
Date: Wed,  9 Sep 2026 12:26:44 -0400
Message-ID: <20260909162644.2981443-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162644.2981443-1-sashal@kernel.org>
References: <2026090327-shy-dealmaker-b70c@gregkh>
 <20260909162644.2981443-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 81b8cdacae533..b38594aa330be 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -775,7 +775,8 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		info.level = KERN_ERR;
-		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
+		tlp_header_valid = tlp_header_logged(status & ~mask,
+						     aer->cap_control);
 	}
 
 	info.status = status;
@@ -1099,7 +1100,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
 		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
-		if (tlp_header_logged(info->status, aercc)) {
+		if (tlp_header_logged(info->status & ~info->mask, aercc)) {
 			info->tlp_header_valid = 1;
 			pci_read_config_dword(dev,
 				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
-- 
2.53.0

