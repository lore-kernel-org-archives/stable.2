Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D69D42BE9E
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240694; cv=none; b=XQbFr54F7QQrC+p8yydh32sSGPZs8pM4MCzIBlvnamLBIY01HBbXSQH2O3HOtQ+BOWywBGVaXEIcL60XoQ7IKVGCEztEW72nWT9GUFTlfa3v1HWCdMemtmnGdVWSFVWs6dfkg1dirGKW7vEOsIBncyw1MG+gDfg1IGUVqCmjPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240694; c=relaxed/simple;
	bh=kNvmRbXPmXJoIxjob9xKXiAbnqNNoJEqfP7WraU1YeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V41/BuhNWnP/jZtnyIGh3hSxP6acYWeFk2v5+otharCfz8XCeST4vABMp8VBz6ZGajf6a/GLu3v3LDyMaKK+PSqyT2OUxKjp4p4uMoqqVxgpaZs/XhHNCIDmjolrjBpRlGmtlT9L6j0rU9f/hE354XWeyGD1fNwiTTnlRrPPmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlP+L79l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlP+L79l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C81F000E9;
	Tue, 28 Jul 2026 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240693;
	bh=RRbNqj467tmK+aOp7qv1gDpxOL9AhbOBbnNL6zSAz3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MlP+L79lo0iTDcfx7njkduIIaDrljbLLk2T0ro0vsQsVndkYRAUY/3+gQkbArne7W
	 F4oeLqn0UDSwT2uxFiPeniv9kSasO2zy1PcL+dcNVcIraNIwVTppfbBLYfSFHYkA7c
	 QN6RvHgPzzyLlACz03SGfskwG9GWI48R7k4zM08Lq6dw06bmSk4hgT/KLqzAkaRH2t
	 /StuUMmv+esPVDqGDTUaV5ggClMacHZEKg21JcTU2S0lBKUdyCQ8K8vQSayi9hELpy
	 8B0JApVzjbyUOsJSb+vktk/v54b0xLybS/OqlX1hrGxhCV+l9R2Z/mHPc9qh5J9Ug8
	 oLSQeBHOgu6bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: mana: Validate the packet length reported by the NIC
Date: Tue, 28 Jul 2026 08:11:30 -0400
Message-ID: <20260728121130.3704108-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072000-concave-rut-73ca@gregkh>
References: <2026072000-concave-rut-73ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 2e2a83b4998af4384e677d3b2ac08565274279bf ]

Validate the packet length reported in the RX CQE before passing it
to skb processing. The CQE is supplied by the NIC device and should
not be blindly trusted.

Cc: stable@vger.kernel.org
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Link: https://patch.msgid.link/20260702041237.617719-2-decui@microsoft.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index db1b8f965eeca4..4afcb202e35093 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1249,6 +1249,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	rxbuf_oob = &rxq->rx_oobs[curr];
 	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
+	if (unlikely(pktlen > rxq->datasize)) {
+		/* Increase it even if mana_rx_skb() isn't called. */
+		rxq->rx_cq.work_done++;
+
+		++ndev->stats.rx_dropped;
+		netdev_warn_once(ndev,
+				 "Dropped oversized RX packet: len=%u, datasize=%u\n",
+				 pktlen, rxq->datasize);
+
+		/* Reuse the RX buffer since rxbuf_oob is unchanged. */
+		goto drop;
+	}
+
 	/* Reuse XDP dropped page if available */
 	if (rxq->xdp_save_page) {
 		new_page = rxq->xdp_save_page;
-- 
2.53.0

