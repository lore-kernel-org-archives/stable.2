Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422092;
	b=LKmbO6j98MHEhqWqtYZVQicsOSTY+r0og77EItn+1DNrEC1VLGtoKgcp19GJdoZnF+1l
	 gLbwwSX5CPVZj5SoTpMTFYziI/MC5PEny3fx+wrwOhuCk3IWqpFZYFov7XuKR5WgpD0T3
	 lsuLJTY6IGzrizDq//1N3xZ5/AINMCU4BK3aRC50JXflutAOObMnP2S5ewDyW16YRrnIh
	 pLtZWx9v5ApHpCB+ErSTYCAfLyfD0jI/HB+X5iI3vVZuuLhU1R+1u6nsg+7dqFoH5aBx3
	 j0ymlJuRQM4N/eEt1sUYM1To/ORUU6tTbODf2C67sRUCAsNE2yy8Cc2KmUsuNbUwRjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422092;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RVEaWec/CELlREVcKm6+TLjloJWzY4vRZhwiRhgfEt8=;
	b=oktQKdcDoM1ZHtNNtQ5YoUO+BlBnuWnx7y5PoW3anZFJ3NSemWXrMg7B9LGiBA7Jp5hw
	 1Y7VwtWZV5NGGd01nlPUMhAb/iIOD7EH/ZHc7YEizPQdkDUSBo8O7GaFM0ZM9cY6OGiFF
	 owO2CSlGN46hq2uoiW24t6s7lK0BLaxKHkjfywJKhP/yRDjE18f6f7mI9gz2593usRNhD
	 CcuyyLcoAPyZGqpYKS470w4RPEz38VfsrnQmjUku5MhpgGTsZpGd0vFpOmAyTe04ZlNgz
	 T0S1PhrVmrKL7PBu8VlisYb46Id6EIgBAqePNh3M774bdVNu7mIRptopxAgRh8u6Qcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuGUxzb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuGUxzb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3506D1F00A06;
	Wed, 11 Nov 2026 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794422091;
	bh=RVEaWec/CELlREVcKm6+TLjloJWzY4vRZhwiRhgfEt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KuGUxzb5ajmb9Zvn1DTMZ2gwAgg3Ktrv6gxJ39+9cOFnkup1WQzSB/Z1NtQfaUkIf
	 LNWUwjRujykfqoyCb2/o40YrQys/ryeUe08A2zM8bJoEQWuW0N0Z54IcDczXHDafQh
	 TtzQCJOuIZsKRiZgCrphO5Z2DG87bwdbODBsvDbLVLeSbYlIZ7v/LV2drRKhoXPODv
	 g3aSAN9xsj+eIS4EI6TMiNEab2LrpdtNk0LPFjEwsI9J0teZYGFk3A3pJHEYxu3rP0
	 vgqEZh9fDm7Xj7H+/KFkh2jwPepbonJc7sfvUjFGv6SGVraImhDT3NSHZD3h1/xhTW
	 6d2qD7sKa0ZCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Priyank Rathod <rathodpriyank@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is missing
Date: Wed, 11 Nov 2026 13:34:50 -0500
Message-ID: <20261111183440.3859163-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051917-failed-6.12-d4c842c3af5b@kernel.org>
References: <20261107051917-failed-6.12-d4c842c3af5b@kernel.org>
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

From: Priyank Rathod <rathodpriyank@google.com>

[ Upstream commit d4c842c3af5bc52b3ca0b8a7f116114e43b6ba44 ]

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues the
entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is no
longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com
[ sashal: Adjusted patch context to preserve existing pr_err() logging instead of upstream pr_err_ratelimited(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 229853e9d565e..44fac6c2f437e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1150,13 +1150,12 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
 			       entry.domain, entry.bus,
 			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being allocated from the
 		 * ghes_estatus_pool to protect it from overwriting when multiple sections
@@ -1166,13 +1165,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					      sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 
-- 
2.53.0

