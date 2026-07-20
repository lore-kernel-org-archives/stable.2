Received: from mace.gateworks.com (mace.gateworks.com [174.136.5.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B5245012;
	Mon, 20 Jul 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.136.5.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586371; cv=none; b=if3ds2PbBxYmn+93th84fwUKqRgYRX/45esK0pN99HHP0CaPnHJSue31TEN0odW/MC3zE6MtYZ6fNk4kSbNsApSWZ5Pg5pH0U2t13tEZGDpVoFu+wlLE+rbWrrA3tj1XPuRvPPNz2raD6jw1qAkYOyCbzhGObLWrwCBDV58af74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586371; c=relaxed/simple;
	bh=71K3kCcEcqjJB0JCq2WkdhGBL2weky3aYnsgjyS9IoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CG8LKkbCotBd7sxpw9+Gc+dJTC3c2Pjbab39kLKyyNk1zw67brUvJneuBKfk4hiMW4ezLJhu3QTydZ7FdkVktjP+tcQHilmGm76LaIgN8Dk4xYocSsETbhra9GE3tIUlb6Z9hTXdukmTGx4SIRfuho6ItSjIHrTFoC+n6a2Yjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=D35ZVvvp; arc=none smtp.client-ip=174.136.5.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="D35ZVvvp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gateworks.com; s=gwtrack; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5cZZlyNNFUTt9sv0d4LtjUQV3XEP7HQRI5TnM+ylYe8=; b=D35ZVvvp99eSB5jkirm4vCX9HQ
	78WAm4MaQKWC2UA0klsiMSUY7s9spW7b7Vlyadgj5wR1A9UUC6q8JMR+w+Uxrb2NBXZ24UnsQUjRT
	2dqxvjoOpyz+s3vx7b/vO4g6HnG7w96ScyfsZzRcy3/6l9+wasQXAVoWLr1Hgw1Nvxt7UT0riT0l/
	8dd90U6fqe1MlW7vSQjgEjatXpqn2zTRNx2DWxjd0BwrrwO8njbjt6uosjGyHVgUe3kOd3MHH/qTp
	xCr5I2a5QWKUyxvWliGu/+xtT6Ea6j7pOV7m1Ac2pIQh3qD2S0RaZlVFp3ljXgQM1SYcLWM6pFXf+
	tj0i3FsA==;
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=chewbacca.pdc.gateworks.com)
	by mace.gateworks.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1wlvzE-00BXxU-Hx;
	Mon, 20 Jul 2026 21:57:22 +0000
Received: by chewbacca.pdc.gateworks.com (Postfix, from userid 1154)
	id 8F38B308352A; Mon, 20 Jul 2026 14:57:21 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: Add ACS quirk for Pericom PI7C9X2G608 switches [12d8:2608]
Date: Mon, 20 Jul 2026 14:57:18 -0700
Message-Id: <20260720215718.2139510-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Pericom PI7C9X2G608 6-port Gen2 PCIe switch is also affected by
the PI7C9X2G errata per the errata document:
E2: ACS P2P Request Redirect Is Not Functional

Apply the same quirk to this PCI ID as well to apply the workaround
required if using ACS.

Fixes: acd61ffb2f16 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b09f27f7846f..27f7d56c9ac3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6263,6 +6263,10 @@ DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0xb404,
 			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2608,
+			 pci_fixup_pericom_acs_store_forward);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2608,
+			 pci_fixup_pericom_acs_store_forward);
 
 static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 {
-- 
2.34.1

