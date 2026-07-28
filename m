Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBA42DFF5
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240674; cv=none; b=rHhb/FmlGvSTw48GmXf77LA5s2CnD50aANSHgvdFZCMekqMBUtUm1QwaLmliJ/bSIX0XP/duOD8WUg2T11w01ybbm4tYLVD01mcBuiryDHa4b7x75GCNM5WU8VyciAi6V/vVbXu7PHeZr3Ptz7TdlZrRsVX0e0bSgHKqfGK1FEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240674; c=relaxed/simple;
	bh=7c3xlUKfuDYNARH/ZzhMezpZblV7nR0Ru8qKIpA0Im0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfLd+avoEfFfeekTNgm7yalp6x4voDyyk+KTu0rp/dTOL46ToIlDAo2ZvozZpr8B3jzwWhMHMHnQwepN8ukmcXPr7aUBkP44XnxLFqLgk0vGjfHTizxwv0kOC72t4JGGCZtRy8DCoVuTW6Ct9zEh+edMtPEoDWHm7JEToX0jmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJs8iJxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJs8iJxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBC41F00A3A;
	Tue, 28 Jul 2026 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240673;
	bh=EkW3oc/v4zRCKC2/BVY1rUFFPtwjgo7PU8iDXFtQ08A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lJs8iJxt5g/NwIXsDxtXUuhsqDduXyVVMbvYWnHjXimjKbotga75h0rDPmjgMppUd
	 LjBlVivQAUNrsY0UAQSMOZ4lbTbJhCmalHf8P9uxjzJkwdCSmlsL1nv+Lb6smBOCvW
	 ISTxOcVXqlL8gccVg/VM3CAmDeBsAhqfiTSMmoMdcEiLJDBF3XaVJmJvJYThzciNKo
	 D3I+ar9G8k3HLEBWNvOsHDOy34QKpL2Kuk786pw51esg8iawyPm7No/lOtIbPFoE25
	 lsNOvNsO+0lHX8U3SDhR7eT4Clu+gr8fzHmfcKq+RmPHgq92fVufAZVjoAMiZGT2gd
	 PW7/QwTwRtaDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] net: mana: Validate the packet length reported by the NIC
Date: Tue, 28 Jul 2026 08:11:09 -0400
Message-ID: <20260728121110.3702926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072020-cathedral-preoccupy-0b9c@gregkh>
References: <2026072020-cathedral-preoccupy-0b9c@gregkh>
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
Stable-dep-of: c72a0f09c57f ("net: mana: Sync page pool RX frags for CPU")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 62418f164dbac1..cbeb04ee727275 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2160,12 +2160,25 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
 	rxbuf_oob = &rxq->rx_oobs[curr];
 	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
 
-	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+	if (unlikely(pktlen > rxq->datasize)) {
+		/* Increase it even if mana_rx_skb() isn't called. */
+		rxq->rx_cq.work_done++;
 
-	/* Unsuccessful refill will have old_buf == NULL.
-	 * In this case, mana_rx_skb() will drop the packet.
-	 */
-	mana_rx_skb(old_buf, old_fp, oob, rxq);
+		++ndev->stats.rx_dropped;
+		netdev_warn_once(ndev,
+			"Dropped oversized RX packet: len=%u, datasize=%u\n",
+			pktlen, rxq->datasize);
+
+		/* Reuse the RX buffer since rxbuf_oob is unchanged. */
+	} else {
+
+		mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
+
+		/* Unsuccessful refill will have old_buf == NULL.
+		 * In this case, mana_rx_skb() will drop the packet.
+		 */
+		mana_rx_skb(old_buf, old_fp, oob, rxq);
+	}
 
 drop:
 	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
-- 
2.53.0

