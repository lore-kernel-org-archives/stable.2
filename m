Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336355;
	b=340SZelnQcR0b8sfOfsN9A/KxMzfuhgB9+gdUhJNJPsURIptZVAOq6nYzXNX8TOyqLhq
	 63maboWg5liB6TVFJOuih3M2k0btE9hiA8ancNoQjvl1D6aBGJeqx53rcFegP4NZ/hYeo
	 j2nDpIn0G2IqRZQWjGkFNzSOA0fhxcjkI4XRAMN0SJYbRmqj695PP0AVuvgxWihqeBbvd
	 oAt/2PkKrIMB2eCIa2xNTCF3IifiIlNHo/Jo0gBb58G72VNLKduwk7abWQNJP46KAzkdl
	 yiFMGKNHmXVO2wp6Fj4Scnw5XgpMdqEzDhkQF6RkiPeWvNKIoYSLwQolsjnBYky+NWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336355;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Amz0+KmvXXIW5w/J2pOp3WAQoFNYGjxXmnCdl2A8t94=;
	b=Q0Lo1pI4go8fl1IkBwRqL7iaKE4nzAY5om7oWKJJ/hznW1TAZ9OToZjWJ3u6ODGgJRDo
	 UfrmpYi6yT2ip4ZRsgOGH96r401da4wstit8LsGFv6Qz6wdqLDtIRCP6m5pjwnMPrmukf
	 IOR4/8cpCPwo4zEA94ZL00tVmOD0105WNNaGV+PhUlArHn2jhRMpbTzX7N+wDyzAP/1f6
	 3sWGMlCyeQ9hmMfDsaIVN0aGK1psyw16TcUrhH5Ww99hkw576475ZjCO2rK/M/cQNKSjc
	 N9OinbfW0YkhRDfAa5DfbRrd6KUP66Vxyb+ELRiPUdZLps4DPgRVJkzu5kFtNGsvsUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maXs1vcD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75737606B590
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maXs1vcD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFF11F0089F;
	Tue, 10 Nov 2026 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336355;
	bh=Amz0+KmvXXIW5w/J2pOp3WAQoFNYGjxXmnCdl2A8t94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=maXs1vcDsFE5Cxd6TOltORNQTKl93JhJKnt4jRnWLCUCKfNOjCjWFXPqA32f2CTJR
	 BJ2/hYOmssxo/8wU7FbSpnCjwynM8/EkYkg2RXQbZ/O5tDlDxjsWAhpt2gVvBD8eDd
	 +trZCNK4nzyIBonmwVhrTwFx/kqQ5T01cV4pzK4BVEihfVeR7bzhhl0PyxhyG92duN
	 rD9jc8u5/G8j9d9VJ6XyCce76tn0X5Zi7PJiVh9QZ3lWyKqurJ4M4DEA9lTLdaLVES
	 h/L4L8iXX+yRM5Hj9ZKgeNsAe2RLhVxUS0gHG4G+PTILXgeNE4J2cELVb72y8Rko1j
	 haRCmRR7b8uSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv
Date: Tue, 10 Nov 2026 13:45:52 -0500
Message-ID: <20261110184209.3328253-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060339-failed-5.15-3b4854b69ee7@kernel.org>
References: <20261107060339-failed-5.15-3b4854b69ee7@kernel.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 34ab316d7287692bad41ce4a431b43d60a8bd20f ]

pcifront_common_process() exits early if pcidev or pcidev->driver are NULL,
so simplify it by not checking them again.

[bhelgaas: split flag change to separate patch]
Link: https://lore.kernel.org/r/20211004125935.2300113-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 3b4854b69ee7 ("xen/pcifront: check that an AER callback exists before calling it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/xen-pcifront.c | 52 +++++++++++++-------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 2156c632524d7..aa3b84823e686 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -588,61 +588,43 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 						struct pcifront_device *pdev,
 						pci_channel_state_t state)
 {
-	pci_ers_result_t result;
 	struct pci_driver *pdrv;
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
 	int domain = pdev->sh_info->aer_op.domain;
 	struct pci_dev *pcidev;
-	int flag = 0;
 
 	dev_dbg(&pdev->xdev->dev,
 		"pcifront AER process: cmd %x (bus:%x, devfn%x)",
 		cmd, bus, devfn);
-	result = PCI_ERS_RESULT_NONE;
 
 	pcidev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	if (!pcidev || !pcidev->driver) {
 		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
 		pci_dev_put(pcidev);
-		return result;
+		return PCI_ERS_RESULT_NONE;
 	}
 	pdrv = pcidev->driver;
 
-	if (pdrv) {
-		if (pdrv->err_handler && pdrv->err_handler->error_detected) {
-			pci_dbg(pcidev, "trying to call AER service\n");
-			if (pcidev) {
-				flag = 1;
-				switch (cmd) {
-				case XEN_PCI_OP_aer_detected:
-					result = pdrv->err_handler->
-						 error_detected(pcidev, state);
-					break;
-				case XEN_PCI_OP_aer_mmio:
-					result = pdrv->err_handler->
-						 mmio_enabled(pcidev);
-					break;
-				case XEN_PCI_OP_aer_slotreset:
-					result = pdrv->err_handler->
-						 slot_reset(pcidev);
-					break;
-				case XEN_PCI_OP_aer_resume:
-					pdrv->err_handler->resume(pcidev);
-					break;
-				default:
-					dev_err(&pdev->xdev->dev,
-						"bad request in aer recovery "
-						"operation!\n");
-
-				}
-			}
+	if (pdrv->err_handler && pdrv->err_handler->error_detected) {
+		pci_dbg(pcidev, "trying to call AER service\n");
+		switch (cmd) {
+		case XEN_PCI_OP_aer_detected:
+			return pdrv->err_handler->error_detected(pcidev, state);
+		case XEN_PCI_OP_aer_mmio:
+			return pdrv->err_handler->mmio_enabled(pcidev);
+		case XEN_PCI_OP_aer_slotreset:
+			return pdrv->err_handler->slot_reset(pcidev);
+		case XEN_PCI_OP_aer_resume:
+			pdrv->err_handler->resume(pcidev);
+			return PCI_ERS_RESULT_NONE;
+		default:
+			dev_err(&pdev->xdev->dev,
+				"bad request in aer recovery operation!\n");
 		}
 	}
-	if (!flag)
-		result = PCI_ERS_RESULT_NONE;
 
-	return result;
+	return PCI_ERS_RESULT_NONE;
 }
 
 
-- 
2.53.0

