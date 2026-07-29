Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F448CD54
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342277; cv=none; b=bIqRbjRvoMk2RdioE9TefiWyaW87ZfR4RWmvRXzKoFKQkEUcjOc9+rzE6iFQVLosqibKwoKzdntfVjO7IF1bj+2zsVnYURjvtC056nniazC/PD61JRaqnzEulSwRuMn4wazOmc1vJI813giYVlcxrTJiqKfjkxAvbv95+n8YKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342277; c=relaxed/simple;
	bh=LTfA1PGZ/yyTHlC73YBnHM1CCMXipOzsWPUuOR7XUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hU6exeFwb0Jr+SzaiGePV1KtKYpO9B0HT87vb0WeNejmtQi0ndi91QZ5tYB5gG/eDPWysX0vsJDbdlaf9KJsfdgxF9HAX65BeOPkMj3YQnxTVu+meB1zQp4DJVYHIjrj6GcBa89Sl042a8UWF6+GJ9W++us7oY/aeAD+/G7/EvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df+/OYeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df+/OYeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2C61F00ACA;
	Wed, 29 Jul 2026 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342274;
	bh=p7KvOvyT+ywz5v32SzUQxaUat9KINOTo0881cMXPOfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=df+/OYeYF8VAIT5pC6VS98YnsuAVjA9z9D/FTwOy0L7VZp0uiUi2l2zDz/ZqvHTNG
	 1w5AKdo1rTxY/jHQMK7wLczy5kzPzAoPtGhNfhLNlEoR9wrsmMGdGS0loXpK6KBxCz
	 KxA/uYDR8vGz6wWzqJ3JxnGCPpK8ijns0CJ52p700gke3PMo7hxZificp0+yCX8FXh
	 zoXT4yNnFOqZ3pUj7c6zZV4Tjszj+yMj5wiL7NudO1L2qDOrjWE+K0E3rqcIjwsk98
	 t1x3+x5UBgiWLdn3hRlnAqsXuiNJoLiS+4VSt2L7flgZWhjs/Lb9LUo29hbXZFlTGZ
	 Kut5CXoSCvtSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] net: macb: drop in-flight Tx SKBs on close
Date: Wed, 29 Jul 2026 12:24:27 -0400
Message-ID: <20260729162427.3522161-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729162427.3522161-1-sashal@kernel.org>
References: <2026072141-overrate-gratified-54e6@gregkh>
 <20260729162427.3522161-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 27f575836cfebbf872dec020428742b10650a955 ]

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only close will
trigger the added expressions. In macb_open() and macb_alloc_consistent()
failure cases, queues' tx_skb just got allocated and are empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://patch.msgid.link/20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index aae3f3e98b3966..3ac22aa25d9c32 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2382,8 +2382,25 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}
-- 
2.53.0

