Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B683C3A9631
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980496; cv=none; b=udQKriDpyDFXsc3vkh/HuPOGcM5rgfHjt+6tsDZGDYqkt/nRto4Wenk4ykpRkrOV8rcw4zdb60b1Z7UYNuuf5BZXm95WoH/bf/Eoopvdk27hDCDX/5bwzuUrK3/kAo4m92W3ikU8wLpY21b+Adg12Ye9KNmhzXW1l5tXDODlsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980496; c=relaxed/simple;
	bh=d4kHJMA7MTA879CA5/i3YLcYnlYwdfNhsjAZhrvZ8E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKEipmOZoKrKjmPViadIzKEzjs6+VBpOprDM1Z4ozSaZda8wNKhNOcuaPvrq1zRdLkpgkpAD8LmGnVKa77lc/f2jaBD9pxdFcqObMy+nt4DM5AFQwXVVH404Q3clvCzXT15qLPUJcBNtPW7FiVaOilEv/d2a7Pp8vrq9DEDwWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJrc9cDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJrc9cDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2B01F000FF;
	Wed,  9 Sep 2026 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980495;
	bh=t599Tj/QrY6+kOCRoPfGVpxAsQAtaFhIy0MH6R6LqcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fJrc9cDF2GLe1qPbLC1VUdpwqm+TBqoao9Q9NfYmeyi8zVH/CrVdTxL2YMEhuTJBK
	 om8ywK31xClq3JU2mQ9B0okMTxVR5yYKXze/3nadNoKiWkes/wVhkHIy8l3QTUyqh/
	 Yhiut+62LikDgW/XjXjNH5X1tLM0sooXuuV9o00VSFgLTbkQAOSeANRLNXgHjJALHy
	 iBC/8bCHXdwKbuYkSWMo2Gef+XRLD/WuukGD11ZUEMiscB7NbnlDJgg+aOoxjueGja
	 yE55FgNOY5lgDdomlQ2L9sVfAl+8/ruzneeADoY3glY8Gq3kPYDPDLKKB3j1m5UPfU
	 N2DCFbnFmM6mg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] PCI/AER: Emit TLP Log only for unmasked errors
Date: Wed,  9 Sep 2026 15:01:29 -0400
Message-ID: <20260909190129.3511451-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190129.3511451-1-sashal@kernel.org>
References: <2026090327-figurine-worst-aeee@gregkh>
 <20260909190129.3511451-1-sashal@kernel.org>
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
index 6865ece1e2270..785e63c0efd42 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -783,7 +783,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		tlp_header_valid = status & ~mask & AER_LOG_TLP_MASKS;
 	}
 
 	info.status = status;
@@ -1093,7 +1093,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
 		info->first_error = PCI_ERR_CAP_FEP(temp);
 
-		if (info->status & AER_LOG_TLP_MASKS) {
+		if (info->status & ~info->mask & AER_LOG_TLP_MASKS) {
 			info->tlp_header_valid = 1;
 			pci_read_config_dword(dev,
 				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
-- 
2.53.0

