Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198244A0137;
	Fri,  4 Sep 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529458; cv=none; b=KjVLj9yehj8jgjcyj/G9ve/sXiQlz7byMcmFgjaJ1lKhB25xNSZcU49gCkl+jvLnYYCWcqIbgJw1JhsWrwshvU8UquwEeqNOvDcQmnJaiBee6KXKtda2jyFLlCFfncKPddB++lZK2k9ZEwUXV/qqi0n7kfNEKWEvyxJO0we8xF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529458; c=relaxed/simple;
	bh=ng5NsEzH9NOTxybLuCYDE9DXSGoLI6vywFw7jYvuMXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XqVR8BaM9NEPW0dmEoX8uUdCl/p1hfVDRRaIYqtO5XDK2CDd0mLDGXu6woyKMLgWkrRFqcAFl6BUhrqNPvV1iRsg1MdmLsT9Dm+rPLm+fuUTaA+lB40hLEfW+IZy05JM8iY5FA7RBRtzPBYPmZIFfha8OgA+mz43V68kWTzbN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU1fo3D1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU1fo3D1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682391F00A3D;
	Fri,  4 Sep 2026 13:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529456;
	bh=W5JaCBTwYrzsMQlvz+4eSqfJtRuMLTxfGJMQM5EZ4m8=;
	h=From:To:Cc:Subject:Date;
	b=UU1fo3D1ng9VES5wEUpFGXodNlG6uNfutxjDw+Pfd504vFYjGpGqtGSSFvC8ln2Uh
	 aPlgyzcj5TUl7C1mTPT8ragrDe+9bL4Z4QDcawbRlK0dq9BvCa71rwrhQQeA2rlGFR
	 ewFrOhG1EJbZcDKSSy7TkHfpCXxJZ/OLGQjobuYLtwVvQiszVs19kxei4xLV7rvVgz
	 1nkpmRKa829skMvGHSuEyooDc5h7ahWNEoNMhzWLAXXN5AwfR9AAJJueScRHxwUwn3
	 naXhFGKaQENT/VDbpGVFXNk09EBFyz9tFBDyqkF8GLjyuU/3IGFM+deu269yPQtNA+
	 rvVeF1O5qh6Fw==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Roland Waltersson <roland.waltersson@netinsight.net>,
	linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] ata: libahci: clear PxCLBU and PxFBU for AHCI_HFLAG_32BIT_ONLY
Date: Fri,  4 Sep 2026 15:43:11 +0200
Message-ID: <20260904134310.1465051-2-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710; i=cassel@kernel.org; h=from:subject; bh=ng5NsEzH9NOTxybLuCYDE9DXSGoLI6vywFw7jYvuMXQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJmnXq39lh1t57f6lXTJklZiu2pCjzm6LdszylujR/x8 cauO8J/dpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAiLxczMrzsWF0yee5btshm dfnnn4X7HGou6tba5Cqu3HM/doeaznOG/4GPHhad1bCdXr++5+7bh1+23bpSo72R+RVjDtOeS+v U3FgB
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A user reported that commit 105c42566a55 ("ata: ahci: force 32-bit DMA for
JMicron JMB582/JMB585") made the JMicron JMB585 unusable on his board.

The failure is seen as soon as the ahci driver is probed, and booting with
iommu=off does not solve the problem.

Looking at the AHCI specification, PxCLBU and PxFBU are both read only '0'
for HBAs that do not support 64-bit addressing.

For HBAs that do support 64-bit addressing, the registers are read write,
with a reset value that is Implementation Specific.

When using the AHCI_HFLAG_32BIT_ONLY flag, the HBA does support 64-bit
addressing, and a 32-bit DMA mask is set by simply clearing HOST_CAP_64.
Thus, in this case, we need to explicitly clear the registers to 0.

Fixes: 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585")
Fixes: c7a42156d99b ("ahci: disable 64bit dma on sb600")
Cc: stable@vger.kernel.org
Reported-by: Roland Waltersson <roland.waltersson@netinsight.net>
Closes: https://lore.kernel.org/linux-ide/IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com/
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Clarify code comment.
-Add CC stable.

 drivers/ata/libahci.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 6d72eb017b49..08ab56e95566 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -744,15 +744,28 @@ void ahci_start_fis_rx(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 tmp;
 
-	/* set FIS registers */
+	/*
+	 * On HBAs that only support 32-bit addressing PxCLBU is read only '0'.
+	 * When applying the AHCI_HFLAG_32BIT_ONLY quirk, PxCLBU is RW, and the
+	 * reset value is Implementation Specific, so we need to clear it to 0.
+	 */
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->cmd_slot_dma >> 16) >> 16,
 		       port_mmio + PORT_LST_ADDR_HI);
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_LST_ADDR_HI);
 	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
 
+	/*
+	 * On HBAs that only support 32-bit addressing PxFBU is read only '0'.
+	 * When applying the AHCI_HFLAG_32BIT_ONLY quirk, PxFBU is RW, and the
+	 * reset value is Implementation Specific, so we need to clear it to 0.
+	 */
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->rx_fis_dma >> 16) >> 16,
 		       port_mmio + PORT_FIS_ADDR_HI);
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_FIS_ADDR_HI);
 	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
 
 	/* enable FIS reception */
-- 
2.55.0

