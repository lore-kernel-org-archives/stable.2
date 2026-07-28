Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31043093CB
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207727; cv=none; b=kp10QCZX5DxiI1S+pczk5SxbAEz4DggeFBPPOV80QMYJwO41gETVkgHUd5/9x/AYdRVwYqhNe5s59SdhSw6d1qHKavzII4JXGVqTnsSu5gsgDFQLF/8BanjK11UT7bSq0CBXE+UEjQPrKqrEFrLZK+h6DSztCjvXqEGoZZYfqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207727; c=relaxed/simple;
	bh=Hi47E80MBFGQQIg3gY2zRaFjpzMF9JIAX8Cd3x2TFkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/tToT09/EhHmG51FRFZ3yWu2LUhYgRsnBwjDY5Ia7gHZBjxqRDpOwngv8iEZ+a8O73tTIskeOaVLeKUJuxHKX9bEo1H3tuIgWJSD9hrmAlBs6Lo6qPuQKZW22QI+ATPS7TUyZjWDSq0iP+UVLDOyvXusJwCCjhCkCbNjr9QRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdZoRX07; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdZoRX07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C0F1F00A3A;
	Tue, 28 Jul 2026 03:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785207726;
	bh=B2WDG/QV0jJnoBcixFxaA6HG5Mc5zypw4EapL0liP+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KdZoRX07lQu7b4UyPnYNbrTd/72E3raQSiKw0vI1b9Ld63AxfzQA+LpLarMQNBTcl
	 CZdwN+DAiaUB4eKgsHXMDNYEgwe+jE0ej7Z/1l/x/j5HJifqN0RQ8bbfuC+FVEl43s
	 lqJZH93+Xndjpvoav8IrW0wEZA010WNBDPQr01hM2JFRqpWfUJAR8zbz1/2X/XpWfJ
	 PuqHa+ZNkaUc2c+n++rjmAfielbtlKELE1and3yt19kZKiZtPF0KOKoxlLVxNtbUWZ
	 wH8HIUKwvEd6fLOXy/byEnAXWgHV2kkIHoBepWqoDszF7Ov9lva2rRfXA2eaie5YGT
	 lZhfQWcopQVEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: mana: Validate the packet length reported by the NIC
Date: Mon, 27 Jul 2026 23:02:04 -0400
Message-ID: <20260728030204.3123559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-turbine-stardom-c033@gregkh>
References: <2026072059-turbine-stardom-c033@gregkh>
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
index 95c4a254953a9b..476f7ff0648eaa 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1724,6 +1724,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
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
 	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
 
 	/* Unsuccessful refill will have old_buf == NULL.
-- 
2.53.0

