Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856F4432FE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229497; cv=none; b=btkNiYdWbbImZtzsUJi4Eg3oQEgFvATIAC/gedyKd3pOQVMkagKptvUtW3xQljCadujlSwtk8jxBW1Qz1MJx9qaWsN9/I65v8MAIeCn56xQKml6A65geXJJu7jA/qCRIs7p5jOZgcrk57GVqlfzaWhC38UuyM1GTayCI01yMe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229497; c=relaxed/simple;
	bh=e4ElHbaLdWCHY0Yzq1f1wjkiMROdDUFIWWTTCAENtN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGVlCDzdb4gCEflP9L5hmzlhBiA1HKyQa46+A0wpgajdL5rwtkgUIH3Rcliyvb7lz1mwtp8kVeqeqK+nIi0/ZgfGrCnNvxI/pyAWt9hZKqJkmxs0L0hTDVkPNYxoR+QjlmCFojMALjKVfImMzwvUi7qsHW9F/w6X+ZpH+s6z2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be4kWR7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be4kWR7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B434F1F000E9;
	Thu, 20 Aug 2026 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229495;
	bh=jUJ7jPd4VggYRUb7YYU+hOq86knHtxcJDYo8shJd8Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=be4kWR7OMEU6buex9L+FfQn5xpIlU/sahyUmVoSfw9U8yQAafRs7gwNvmh2AsZuQM
	 laz8XrFV6/JRt4jAGbfXT6WZsMZ/i93iSIcl2db1xjVL9/6Klk7M/JAvcSUk57x8GY
	 9s6G7/6Ac9FtTt/CpRymGF+cHeOOAEfBbynFjlj3Es50xSboYr5p0JMCn/FENV5Q+M
	 qI12TBfRTPkhKjB16sr5IFfpQcXkcivuYW6c+cCO6CMFCZZKfdXYUg/O3UgoV+UmZK
	 fmBklFS0+zxb1GbymzGI5GC6UnveLO3TG9as/aCKHW9RuieLfISuXSVR8QrSBIet4z
	 BwAGeBI+5p6Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Thu, 20 Aug 2026 08:38:12 -0400
Message-ID: <20260820123812.1613639-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820123812.1613639-1-sashal@kernel.org>
References: <2026081709-sulfate-hardwired-cf00@gregkh>
 <20260820123812.1613639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit d2121faf133ac3bf9531b53a7e21273649a08517 ]

ntb_netdev_rx_handler() hands the received skb to the network stack
before allocating its replacement. If the allocation fails, nothing is
reposted. Every failure therefore takes one buffer out of the RX queue
while the interface remains up, and enough failures eventually stall
reception.

A retry path could refill the queue later, but ntb_netdev has none.
Allocate the replacement first instead. If that fails, drop the packet
and repost the same skb. This keeps the queue full and lets packet
delivery resume as soon as memory is available again.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260806032537.3526498-1-den@valinux.co.jp
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ntb_netdev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 4b65e938d549f..b72d0bfd7c2a5 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -118,8 +118,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
-	struct sk_buff *skb;
 	int rc;
 
 	ndev = dev->ndev;
@@ -135,6 +135,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -148,12 +154,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
-- 
2.53.0

