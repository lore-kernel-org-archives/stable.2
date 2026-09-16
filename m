Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9104749E2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545657; cv=none; b=Ym9xVJA0GxFjVjiA1hQXqSrNlWHKExAmpuVjCh1zUSS8FMV+ad53nb8w1EgRucG5J7IR5jMNQu+PY82f24SxehY06kme+tib7mi7CDNlejEE2kl+9bW0sqUOO2rvc681T/zgC9gwYBIEWbv9GQoudYYGbzFLxtmyCsdahAOdb/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545657; c=relaxed/simple;
	bh=7WdeUDfNtz3w/kOVanMS/2G8C33ZGTEc6MZvYgIdotc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvteGL5XyMIOHk5c9owOLoHHeoS42ZqHcBqdEGqbglLgRRNd3/ozSjkRwVGWRh0iIU/l+Fn8UjLsgSsv1pOgbQmYzglFWz4Z7SSzoSx+U8eOWnMIzyX3HRT+awPZdfPrKNETuXEZ36PfHN8Ufsu70QxsZ2kmnRuZxXzqxxGrBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc2IrysV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc2IrysV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb65437so440057a91.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545644; x=1790150444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1EPm1x0mUz5Pn3Ms5F/txa8My4xRSy/NJkkZxCzQIKM=;
        b=Rc2IrysVTWRJemrkQFAJ+8O3jN9JCMqD1N9yqqquQyj6TlRv9kewSW8gyY2qHtfAsi
         3MoemnLsawnXPlNQiZdT9WQ/j2fgFuQs6GGjXr67ea7pup3AfnO+slXc0gL9CVTkAjjC
         7JkrglkkWb5GahF7TW2iJWoJBXli/RlDOVCn62og3FwBMqa9G84h7RuY5WaODWrmvvcm
         7zkPKeD98W1JnTy7ahY3MeNIHKiqQPi5bAdt0pgcqq+3PRGLR8PyRA4ZkOTHllPZ6bh7
         U8G2vE0RJXj7fg10MWPUPX2tKsGrOaMhvNIGgiIjVUn2W9hSIXRlPehPRwmKoQnTWaaj
         LztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545644; x=1790150444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EPm1x0mUz5Pn3Ms5F/txa8My4xRSy/NJkkZxCzQIKM=;
        b=KdYv8fjdrsrDjFWo+/oEeWG/O6zTm0fxVH15xq4ZOvgHhFTXdhu8PXArzmRLBJdcPm
         amy15BFN7UP+gYD5xoLJS4/31erhn6X04Hm/zEyc2M5xAp/84oT37n1C/2Cb/Vc9979y
         E6zMUhvGvJVYaXjZEWwPCIQkCKe+SsGMaL76IzAysDW5Xd2wMGkGDOgg7M5MCgkqdiEJ
         9sTTGhSpL6D7cgiEDp45lLUUcEAM5b5t8xBoPznPIGix/V12Xug0l9oouFqlqUfvS0Mx
         SRL6XcRiwSPuuuiyREchvH4GlQZKYCsjyuwhbzuk0GHHn4gBidsPpzK0SLTEMeZCdBiD
         CxyQ==
X-Gm-Message-State: AFuF++l804Ka+rEuCSjgcMg9sQaZ4gUnmsn+YiRIIFkH/T4yRUFfIdCD
	bt1zTfKACDrLvBZJyXpsXJWe0SvrEuAdSPhMU+oq4VLATK3ZIbJVFNaV
X-Gm-Gg: AYBFou1uQ8F+iumrI6FgVaW/bZUSf8HcXk/mafSOdlg9sdABQVRX+lDWWwzErq/CuDV
	3pNJWfgqi/zq0yOGSlpYRNN/BqTOxyluxgN9kysqyIC6Rn4TWwt2CXZcnkpMHHbK8PBDsL5kJX3
	5Y67iS1yDWI5N8+T0nbifBfQeLScJHRhtoFm4AP/48lQJR9T1qsjsxKZrFVeopWj73kDwU2xPdv
	JDD2xFUW4Xkp5DJiWCu/p7QMKSQw8ZasQQGcDi3JzpsLQFG6xDqofGDfVagB+JMtRyE/BhtUWVi
	WAUNRZK/A76aJ1DoeFYmvqvs9X/eSmvuEEVM+mxkl7A7jm9Z4EYeddHRP5068yTUSKmNvKX+Pmv
	jlP/qxt1bkjP3qcH0JRZARRUE3SU/Scu0+ZhTutUZubr0X0ZlK24h1N+NUY2ML9kMLT/VPP2nIP
	z6tU/Y9zt1tRypDwdRhWxTSXrEdoNPwwCA+aEKQ8tWIFNH8jUcWfQGHQ==
X-Received: by 2002:a17:90b:2681:b0:39e:1a00:bec4 with SMTP id 98e67ed59e1d1-39e1e2e1d8amr4275979a91.6.1789545644489;
        Wed, 16 Sep 2026 01:00:44 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e19fd8ecasm995716a91.1.2026.09.16.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:00:43 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Yuho Choi <dbgh9129@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] PCI: keystone: deinitialize endpoint on remove
Date: Wed, 16 Sep 2026 16:00:30 +0800
Message-ID: <20260916080030.2960608-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ks_pcie_probe() initializes the DesignWare PCIe endpoint with
dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
when endpoint register initialization fails, but the remove path does
not perform the corresponding endpoint teardown after a successful
probe.

The successful endpoint initialization also calls pci_epc_init_notify().
Without the matching teardown on removal, the EPC initialization state
and resources allocated by the DesignWare endpoint core are left
active after the driver is removed.

Notify the endpoint framework about deinitialization and call
dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.

This issue was found by manual code inspection.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 602516239a57..35787e727c5c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
+	struct dw_pcie *pci = ks_pcie->pci;
+	const struct ks_pcie_of_data *data;
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	data = of_device_get_match_data(dev);
+	if (data->mode == DW_PCIE_EP_TYPE) {
+		pci_epc_deinit_notify(pci->ep.epc);
+		dw_pcie_ep_deinit(&pci->ep);
+	}
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-- 
2.43.0

