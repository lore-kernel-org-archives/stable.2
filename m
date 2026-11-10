Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337195;
	b=Rj4DVRWh+5fOGFxRRxfNa33MPT+YrZfcRQA8ErTtlCf2Tw9g8a7XJ4GjV/dTSHnWC3i7
	 z8JAZl0/V29Jp5kZQfpyC78xIqYQj63f3egs410ycfl060zY1p2OCxG525E3Ur0AiBY3G
	 RBbstk37cGXgX+Jj4MhVzm66QkP6bFUvy1V7ge9wOFpr5FxC/oZEMsAlsDE6HfC3nYFDp
	 lpNsDe0iYqVO/jHUFpIX3TqTuLLOHW4og8QKzhx2Rk2kwhQdYcWTJYT3GwQ5wBm5C13NJ
	 tnNOT0EBH+aH4erY5ySIq30cOtmmEBqgKkKPA8IOEaSU507nmSLM2hMJof6P9TPeF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h8AmvoAPxWFhK2VhXZRgN/TFdiJR8OACC7fgRt1GuUc=;
	b=MJHiQ+Q9ojprFFpKF2dQ10AeNA7mhufUoISqLSxM/6DwjXxWj3BWZrSgJsfqsNkK9k8p
	 saKt3dju7RCSoQ/CMoFVXRF2GRC45l00IK6IQSHOaG8edJCswEpIndmX4mh355TYOvI61
	 W8v0NjyTUBc6wiIdr/1wnxgle1VLlbYmYqg7CfsPgc+mZ2O6kRwYUkQUK617Nvhs2b4oX
	 /BKuINnSdFLdyGs/rkVlKx2A9yESlg2jYNdpzbupqhr2lvo9yTAPFyPY8Nq9CC3mr4Poa
	 0eI4O/jOkut3opexi8KKbcs1sHH64Vjkg++ePJWQ6g6ZKuE2WYg6VfUUN5zOtL50cbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMqsJvPi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB46606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMqsJvPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ED31F0089F;
	Tue, 10 Nov 2026 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337195;
	bh=h8AmvoAPxWFhK2VhXZRgN/TFdiJR8OACC7fgRt1GuUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMqsJvPiO3g8fuqzUeb0r6c2umwDaiaRwuAxbNiNJIBP69uBNRmR38Flb4QoKvNej
	 tHKrf9BtEOZqJY/YAkPnkZ1lUJYB5ONY38PhjoJwvHwCZhDErX88VF2zWlskw8TUNy
	 WZqXbo/YC95ETmId0illplHF7uL6IQK+BjK0SlvbqXzmMk2i61pfSkFuW3YmZ+prnR
	 PZCMuoHuE+J8eyS3dWw061MJXgqjUVF8ZvXrHA6xddhpigqsm+bGTwQD9D95nVBYKq
	 vUUjBVIbG/Rii3qdN6SYMt/mxw7aqgThO6IZI1ehXe0z1tKdvGoBqw7/WbpF7pwup6
	 LA34NqXj+pTAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] xen/pcifront: Drop pcifront_common_process() tests of pcidev, pdrv
Date: Tue, 10 Nov 2026 13:59:52 -0500
Message-ID: <20261110185945.3425744-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062019-failed-5.10-3b4854b69ee7@kernel.org>
References: <20261107062019-failed-5.10-3b4854b69ee7@kernel.org>
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
index c6fe0cfec0f68..2ad209ba659bf 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -585,61 +585,43 @@ static pci_ers_result_t pcifront_common_process(int cmd,
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

