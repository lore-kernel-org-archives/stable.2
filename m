Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78971ACEDE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244818; cv=none; b=M6DwdnJtCBImG/bS0rOfh6SXSzmT7FzPHrp3tFYyGo3XJ0ijbTbkPg9LyOEMpg0qNKuNw0jtBgB0K7FDOrOKU5h3SeMFjK55/XXLjYWyIa457r4ssq/he6WDun3GfGJbenrkKEdPT0umXD2yUauL6BKHSi7mgXqFblxi/wJEKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244818; c=relaxed/simple;
	bh=OemrfLu2ykz7vmaVzVxfqJ4JCzyFVzR/Zek/xuGhEio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj/Obdourh1baDyMzTdKPAwmhI/D/pX6PvYV8ulQi3F5fjPc8jdHrn/VWTjhUzlndhARgRe1tp8EnFXWZhlyvGIRTWmze4Hdh5bqO67mvjHJh9WOv/0kniirJM5powAYc19EZ+ktSrS3GbdHhwaffFFTezW/v+zPLnp9rH22Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWL7nY7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWL7nY7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B052C1F000E9;
	Tue, 28 Jul 2026 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244817;
	bh=zSJwkmOjaBNfx8M4+pVdht2jDOmihG8zWGwoBscxrY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MWL7nY7AjqCbpJpLH2TVVjA2Yt0PAUBNkT5YCHfn3jMHOV4IGWJCUv9d8amIRA38b
	 dsmmfgGtG2E7gugnBOaIOZaG+QRHctaiULL7XLnZp+3TWOVtaNQTG36oEgcQmhwiz3
	 6whYN/7YY0cC7NqsqcQ7To1UDNpIYY2z18EZeOqJ9qSoUihzdQHI1nj45kCcqnLXhi
	 BxGWSn8wDgOUYqb5N/eY73RdXbmovfp1Vxrd1h7Wfg/ZNtVdWlWAAU5S08H0gBzRJd
	 TlOidFJcgZYsAtIv5gPEXHZrjlRtso1BaUDsOfW/zpt945ft/yB5kqj5SG6saQRyTM
	 Z6h6l5kxQNzew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: mana: Validate the packet length reported by the NIC
Date: Tue, 28 Jul 2026 09:20:14 -0400
Message-ID: <20260728132014.3954969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072000-hatbox-undertake-c719@gregkh>
References: <2026072000-hatbox-undertake-c719@gregkh>
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
index 6a8ed54f6040ab..27c93d6b9de464 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1021,6 +1021,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
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
 	new_page = alloc_page(GFP_ATOMIC);
 
 	if (new_page) {
-- 
2.53.0

