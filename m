Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA23DCD8A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674444; cv=none; b=bGc7Hqo4BMbLt1bcw/BNn+MBN3MfBMNr7um2Bgh6iaIIziHjGfBT91iohXxZ+PPp0DiruJKrTrSHV9x15EnxAkeYRBoxe9I6pn+P7McB7obk1N7F2TsILxypqyi7eTan8A+QxnCnZfrtBCrl4+0t4ITDit/4vVw+vPJ8VFTmtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674444; c=relaxed/simple;
	bh=fmTL2s8F/eTQj2Mtdl4MWB8rAQdRaiVlgmFFyz9i54U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohJfE8krCKSN2vOu+GS3dwAkUg967u638yskpjXsDih8YXor9Ak8CXTq/BlyfvcZD7squwhHF5XP4wZzoIE1hth/mOqbZk2cqjfofmqcDlpPqWsCFMQwl0LP12kXinHhQYD14sfGsOxaWzjK+LPi/StRMB9eTfV35I4q9YxcaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YckP22k1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YckP22k1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783674439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o5M72C3L1ZgsFmb5gY5mJ3SoLciOzkeobaXpGracEas=;
	b=YckP22k162bNqNEwPV8+gIbiLDri+6utRarOwGdBGHydCMHlfPgo8vyxD7+Hanf3loiA/X
	v2TNFkuFvqopkH2ss2issDBHGonfMFoxOx37z8uno9EpwagzBuAjnKTz9eJ8clOFlH12Gq
	irMwCq3cl7R2gi2OAAs7wTcRxT3jLyE=
From: xuanqiang.luo@linux.dev
To: netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Fan Gong <gongfan1@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v1 2/3] hinic3: fix use-after-free on DMA mapping failure
Date: Fri, 10 Jul 2026 17:05:23 +0800
Message-ID: <20260710090527.58354-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
References: <20260710090527.58354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

If hinic3_tx_map_skb() fails in hinic3_send_one_skb(), the skb is freed,
but tx_info->skb was set before the mapping attempt and is not cleared. The
SQ producer index is rolled back, so later transmissions normally overwrite
the entry.

If the interface is brought down first, hinic3_free_txqs_res() calls
free_all_tx_skbs(). It scans the entire tx_info array and finds the stale
pointer. hinic3_tx_unmap_skb() then dereferences the freed skb in
skb_shinfo(), before it is freed again.

Set tx_info->skb and its WQEBB count only after DMA mapping succeeds,
preventing the stale pointer from reaching free_all_tx_skbs().

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Cc: stable@vger.kernel.org
Assisted-by: Opencode:deepseek-v4-pro[1m]
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 9306bf0020caf..5739ecb08d0d3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -578,8 +578,6 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		*wqe_combo.task = task;
 
 	tx_info = &txq->tx_info[pi];
-	tx_info->skb = skb;
-	tx_info->wqebb_cnt = wqebb_cnt;
 
 	err = hinic3_tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);
 	if (err) {
@@ -589,6 +587,9 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		goto err_drop_pkt;
 	}
 
+	tx_info->skb = skb;
+	tx_info->wqebb_cnt = wqebb_cnt;
+
 	netif_subqueue_sent(netdev, txq->sq->q_id, skb->len);
 	netif_subqueue_maybe_stop(netdev, txq->sq->q_id,
 				  hinic3_wq_free_wqebbs(&txq->sq->wq),
-- 
2.43.0
