Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE233A3816;
	Wed, 30 Sep 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754034; cv=none; b=FHVa+OvYV4y0MiueQ+BJWRaqEgbea95A8pFrKsdXscgH3n71g1I1M2i89eYm9xY/Yi9s14vaZqiZc5CEq9TJmeKndPrbTfo/ya59FPI23UNGTepLcwBujCo2pvpEDvD60MyaOBAQ6zssFiV6+dy8ujHhtUQdHA0Vq2Z8VJoKSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754034; c=relaxed/simple;
	bh=oyOiJYkJ/EWDLviWCX2is2ruTUp3N3AD7lWOUAhaWxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eGSB4SPAJrFDmz7Ghcb5WlGTfoURbmQHqu0YQPs4EqrqjmaoTXh17uf3j/EXocENHn1Pf5Ug8Y1XUIV1iAU9BhTehmtCpZDEH0LKMPisq2DztXFmvWl+PdtUqQYD/9p3KDLO7iEI9SlleIhowIfFePJqbemmBVu7gnMovf7w1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iMdulFhA; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iMdulFhA"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f9ce8847;
	Wed, 30 Sep 2026 15:40:28 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Sukhdeep Singh <sukhdeeps@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH] net: atlantic: only free the PTP IRQ after a successful request
Date: Wed, 30 Sep 2026 15:40:23 +0800
Message-Id: <20260930074023.2943213-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0f141fa7203a1kunm04033f5326fc01
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSENMVkIdGRhCGR5LQ0oaSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iMdulFhAPcFv61U4S39ZIKHC5ARAgnEswSnxxbN79anvfTgznj+yaZeVSdeXjIrNubOZtfKiKhWbtQNFfE9qTLqTbE0zlUtQtitKc4/YjKjpIRe18PYhnKBMgTOhKcKIVhG7zZb0bYzxfuMYl/70ZXq9W6228iiijR6QCtdo0DQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=R5W59/fVYd+hNmXhpZXRzCWCoXxUcslCvKKG1I34EC8=;
	h=date:mime-version:subject:message-id:from;

aq_nic_start() requests the PTP IRQ before it finishes the rest of the NIC
startup sequence. A later startup failure reaches aq_nic_stop(), which
calls aq_ptp_irq_free() even when aq_ptp_irq_alloc() skipped request_irq()
or when request_irq() failed.

Track whether the PTP IRQ request succeeded. Only call free_irq() after a
matching request_irq().

Fixes: 04a1839950d9 ("net: aquantia: implement data PTP datapath")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index 558ac9237..a5b69f1c7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -84,6 +84,7 @@ struct aq_ptp_s {
 	struct ptp_tx_timeout ptp_tx_timeout;
 
 	unsigned int idx_ptp_vector;
+	bool irq_allocated;
 	struct napi_struct napi;
 
 	struct aq_ring_s ptp_tx;
@@ -1033,6 +1034,8 @@ int aq_ptp_irq_alloc(struct aq_nic_s *aq_nic)
 	if (pdev->msix_enabled || pdev->msi_enabled) {
 		err = request_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector),
 				  aq_ptp_isr, 0, aq_nic->ndev->name, aq_ptp);
+		if (!err)
+			aq_ptp->irq_allocated = true;
 	} else {
 		err = -EINVAL;
 		goto err_exit;
@@ -1050,7 +1053,11 @@ void aq_ptp_irq_free(struct aq_nic_s *aq_nic)
 	if (!aq_ptp)
 		return;
 
+	if (!aq_ptp->irq_allocated)
+		return;
+
 	free_irq(pci_irq_vector(pdev, aq_ptp->idx_ptp_vector), aq_ptp);
+	aq_ptp->irq_allocated = false;
 }
 
 int aq_ptp_ring_init(struct aq_nic_s *aq_nic)
-- 
2.34.1
