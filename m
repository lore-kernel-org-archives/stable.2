Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FC331209
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785209162; cv=none; b=OqqwAXzKuFT0F8IyXUQCRabHsFtfgeeFL4eP9pW8Q94S4ussQYG/Ma4m2YpJ/OqYnlitpHSbEVdYLiBOJFYLFjQPNHDlh9Nw45InMcO71tOM8Zfas56vgvIt+yquNZTft0u3favozAfIMQOqXznMhcwcSw8pD4nTtPdlVtSvyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785209162; c=relaxed/simple;
	bh=D/yF83XizwkPQijQ7Wrq14qk8SLu3yNIBmioE6c1yK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V50NSIE/PB5ZtDeyoM+OJB5djRWMzaR8rmApZDce08MIeMrdhHZXat/LGOe4zMHWjxHgwjFJH18u0XnsZxnCvkfxViZpeXyopzF8ntmawDdPGgCh3f9GHHy40fMIEFdwzpEReyPFJURpbJCqjUbS2/OL7FLyLeFWD8YbWVjrqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjFV/hSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjFV/hSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6E41F00A3A;
	Tue, 28 Jul 2026 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785209161;
	bh=QxW+VD1B7I1GLmLLMhLaF1q0XtojyFjX6oh7vo5ROco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VjFV/hSmwV+KYxPu8AtxFasvHVK7YBaWlTXGYIYtliG5xFcIT1GNSfwcDQFSmkzeH
	 NZUStv2NkP6TOAbX7lI7VeWjGyuoU4SheDuR+9M7bZp0h+eTYQpajiSUzt5gCvS1Wm
	 11MHR5rHgH7hsFxVwNgayDWd8oVjDvEqEPfDCNe2J/vAgc5uMNfTRm+lH2iKJ+gXXX
	 mle91dbCMfjvK3csKxa4CRzAuskcOd8Laspku0sAisDDwxmwGhVN030aViBhe8hl/Y
	 0CQ15XGAoj5/hM2vibCIzgHHsyC5n40E74I3gWUY1EtL7Gygyp/ha5fGFhn+qkRIVr
	 qXanMZtZNLGRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: mana: Validate the packet length reported by the NIC
Date: Mon, 27 Jul 2026 23:25:58 -0400
Message-ID: <20260728032558.3151321-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-automaker-racoon-e003@gregkh>
References: <2026072059-automaker-racoon-e003@gregkh>
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
index 0249ba7e3b92cd..ec5d38164d41b2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1739,6 +1739,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
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

