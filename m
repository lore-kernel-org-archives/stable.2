Received: from mail-m1024.netease.com (mail-m1024.netease.com [154.81.10.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423942868B5;
	Tue, 16 Jun 2026 14:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619874; cv=none; b=gFQ9F/ERUvDod0PRpbDkn0BH03W8j737iZhxEgN5irMd8ZcJmqgLZFqjLTTI2rtcZNn3ARniColg/2f4bdYgK5uIks459CbHD4mOZeP/7KqsZA6ZMTkyGguBipb0VMP8kOKWDcYtOwRoPQYZ5VYU0Y6skTDr4CLikLe03HIuFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619874; c=relaxed/simple;
	bh=SVJYD7cXhxJ03FCB0/aNXIXtObxXr/c/c0buXeK2qaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDp9mWx8OS24kyIRsDt55d3spsDlSvUO3Yg5lI3WbESVQO0LsuFiLAdQaHODjfanY1gQZqCcMTzImcGunUFOew5L4linwAWMO8iK6pqccIbrsbjDuQJ7E75OlGgoZeW3kJ+NeiRhnXu2Ep5jqE8BqbV0gF58KY10o8vTHS/25VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Y1IZTbeY; arc=none smtp.client-ip=154.81.10.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Y1IZTbeY"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 429c4f9f3;
	Tue, 16 Jun 2026 22:24:27 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: akiyano@amazon.com
Cc: darinzon@amazon.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	sameehj@amazon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] net: ena: clean up XDP TX queues when regular TX setup fails
Date: Tue, 16 Jun 2026 22:24:24 +0800
Message-Id: <20260616142424.4005130-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed0d1bf7903a2kunm774c128946f2d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDShpKVkNOGUxLT0hMHkwdTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Y1IZTbeYxBzyAh6DkFJL0o9f9Pz6FGQrtNcjPmnbU1NOy9C70vVUM12N9JyprMUbkL7UNOnHthqlK7DAOZNpMqRI/B0Cz42oT2p1ZwCqpNDExwiTZGwg3rW4KXqfm/XYzK9V8fV6hdNnZqf8oYTP2dPYCMacicErfyCoJUIRcGM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=QLL7PjdV8PJ+1f56KcngZn3slyFDPp7fenaeMRexXvI=;
	h=date:mime-version:subject:message-id:from;

create_queues_with_size_backoff() creates XDP TX queues before setting
up the regular TX path. If the subsequent allocation or creation of
regular TX queues fails, the error handling paths omit the teardown of the
XDP TX queues, leading to a resource leak.

Fix this by explicitly destroying the XDP TX queue subset at the two
missing failure points.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc7.

An x86_64 allyesconfig build showed no new warnings. As we do not have
an ENA device to test with, no runtime testing was able to be performed.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Cc: stable@vger.kernel.org
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 92d149d4f091..5d05020a6d05 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -752,6 +752,18 @@ static void ena_destroy_all_tx_queues(struct ena_adapter *adapter)
 	}
 }
 
+static void ena_destroy_xdp_tx_queues(struct ena_adapter *adapter)
+{
+	u16 ena_qid;
+	int i;
+
+	for (i = adapter->xdp_first_ring;
+	     i < adapter->xdp_first_ring + adapter->xdp_num_queues; i++) {
+		ena_qid = ENA_IO_TXQ_IDX(i);
+		ena_com_destroy_io_queue(adapter->ena_dev, ena_qid);
+	}
+}
+
 static void ena_destroy_all_rx_queues(struct ena_adapter *adapter)
 {
 	u16 ena_qid;
@@ -2078,14 +2090,21 @@ static int create_queues_with_size_backoff(struct ena_adapter *adapter)
 		rc = ena_setup_tx_resources_in_range(adapter,
 						     0,
 						     adapter->num_io_queues);
-		if (rc)
+		if (rc) {
+			ena_destroy_xdp_tx_queues(adapter);
+			ena_free_all_io_tx_resources_in_range(adapter,
+							      adapter->xdp_first_ring,
+							      adapter->xdp_num_queues);
 			goto err_setup_tx;
+		}
 
 		rc = ena_create_io_tx_queues_in_range(adapter,
 						      0,
 						      adapter->num_io_queues);
-		if (rc)
+		if (rc) {
+			ena_destroy_xdp_tx_queues(adapter);
 			goto err_create_tx_queues;
+		}
 
 		rc = ena_setup_all_rx_resources(adapter);
 		if (rc)
-- 
2.34.1

