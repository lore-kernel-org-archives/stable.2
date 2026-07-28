Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F12F25F3
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206809; cv=none; b=t+caIvrel6hQIkqJUQug2xE9xBAIaaIaNTHSEbZH/nZhoHciNMT6MF1MKJbJmknpJL9HgxRPq+DQAkY2QeP0n6ZzdOj8oQxpQ2rGFp1MAWbzTCY6F3dc2+869kzsYecLQmBdGzKS1tnqm0fR3SA0bn5LFw6a3MiARtN+nRti81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206809; c=relaxed/simple;
	bh=444A992g0OoDLLP6n8DtJwZWFA01KIBrgcj/mIUNVLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/UtzzjjqCYQDRER28KWpGd/O26cUWvuwhTtKQJpwXXK5dNIeZH2yJhwMnoQEjoeyo+B4muf04jSX6XPo5vc4GzEIXdAWx+JDVqnWG96IYSGxn3/sccpzbZ15UKrM/BPM/9IWxGbLbc+kN1rmB9vpWi6f5vuFBfc25JjBQuO2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaKwyiTE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaKwyiTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5431F00A3A;
	Tue, 28 Jul 2026 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785206807;
	bh=kJDjDyPAzf69hRiS7JDzXy41GhAYd+katqzdTs6kvag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eaKwyiTERXBQwSOaJ1jBiarafOBhxNE9aZ5VpTb65hN1W/qgNmT2dMkVotbHommhX
	 K8wyT2fN/tiPDyFx6i6k5DwaHnJPz+tW2bgMWe3xCbwM2FH6qr3gMb1OigdlAO2Z4V
	 cewzjPkaxqHM8QB4MtSyp8hIslLqkZiztyI3KA+bLphKbBkhjYYF9d2rzsZUCeNn2M
	 2+mk5lQu2aP5L34O2hZK+/A7gdBsbLwm8F7DiP6UjCQkj/A9b6tPUE58+tY3Dvpx2q
	 tXLiX7CDZqUGraMikAzyO5AihyPVsEzJlJ1a6uxagwHHZVCj8Css7+Tm5yiFeKq1pr
	 XBg9YKOmkZZHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: mana: Validate the packet length reported by the NIC
Date: Mon, 27 Jul 2026 22:46:45 -0400
Message-ID: <20260728024645.3059155-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072059-proving-blatantly-467c@gregkh>
References: <2026072059-proving-blatantly-467c@gregkh>
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
index 62418f164dbac1..adf25acb0d46f1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2160,6 +2160,19 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
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

