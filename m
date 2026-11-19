Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795097807;
	b=vnO2UA03HDDTrQdBisK2YS0PuyqIkY1P21DJ9ahgj3WCRjCkJvtBL3TtNK/6YCMOO0Aq
	 wmtKf6ut4TfO7VdP2Ij/Inhb/B065Y17qhcI4zCVogHvBMclSa1LW1KK0eNnvlFgX33jP
	 CC0MVolLtNxDPtAV0RoCnPiLdyLxSEIp1YqzuGj5ZeSr0gy3TmKPx2PQiY5ftlZpmsyfg
	 YvvMfHAteHRN1K6/CzdR1HKhRDn/3qCrgQAq3PZV3clUC5VlsO1YTLc1NRbD8XHrhtQJO
	 HrM5ht5KZYpALozr1U6CZrs26NqgW68nsaBOcinnwx9pt/13QV5ssNGTv2pr1xQYzPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eqmgHj+KyvxEVxd2aIN7Y36hxhbA/1YsmnaLw6WzTPo=;
	b=hN6+QZs/MAjw5FCq9UfE6CPuTGDERrvjjuKvHSDL9jV0NXGe0qgIdLUCLABgHMktrvUH
	 FNtqUbk2p4vRaiAZKQskNt5ly3uKRlfl0VkWd/qjmhnAp5CTv4IvxZL8F0JuWbhWFppiU
	 XnpiFJ4uRDZYgrvPbXI3lIlMywTOhlO5Vj7TbRk1hkHLClObscfA5sVxXSKfstOOK/R2V
	 97rbQbw7g+l/GoRwzZLV81oCvXedUTo+ctxIZOkr10yji1b7UztTuMby/h+Y9e3fCRl9n
	 Hbj/FWBhvcXJM51AsuNQvyebbaWx0rluxvA7zaPK4DEcwZJoul5dZSxTZZzdGsE6zTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telcobridges.com;
	spf=pass smtp.mailfrom=telcobridges.com;
	dkim=pass header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=HXa0fpkl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.97
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020097.outbound.protection.outlook.com [52.101.189.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98CC606A32A;
	Thu, 19 Nov 2026 14:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98CC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=HXa0fpkl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBrWpVfA9sSbneNq1jnELlGZbK7E84IFiHfLnscVRE75+L1cuo9K/zlglUBPS7MACKyp42hn/kzFHtuX2HcL8ttM0gN9Pfn0TlJ0iyEemSnQ3+KtyRX2HG2RJmcfcPy5IkoNrJ+K2VF5rRFFzelTOeDMdPNHz/urKxQp9xC20mJBVDD7v9+VaZKrUXxBTz1paPYrF8KVbN08v74YMj3vrK4nT+vel2zkQxHWr6s/+wtQQVUp//JBbRvETiH6AsRQjTS+0g3y8GJyuNEgGCj4D5sYWEkloJIxq0z3Nom85KPcsdl0tDXZAWgNU2qMWdtVdzRmQLsFoPW9ecs4lRCa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqmgHj+KyvxEVxd2aIN7Y36hxhbA/1YsmnaLw6WzTPo=;
 b=OUgV2B7Z7gAu6EpCTJNKHjRqzt9sHTS0CFrsA8UMupDm9I5urkYK4ZWdA/wK64xGwImjfAZsU8hLhvlfQCu4jOPF3XmGL2uBWDpehcMMfrktcUazlD3CjOyLp9SV2iKiPsqd29E0m4bvxfqyF2RRDz3P+BqeA9UeTGGuNoo/suKOBfT4N9KRY222c4lmXMRXsxGnpdV9szz3M3XfVbA5t1nLOnr5yy8TxsUhKMtJ3Wk08E02t18bVHNbnGgsveTie8SQFrZzcMKw1xie+Cm2JyWXLP5GoHDCBCrY0r2ZrMF7jOcSGJJt78gJdNW4zZBV0jNV2re2XIN2Tr4KVy1ITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 142.180.224.216) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=telcobridges.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=telcobridges.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telcobridges.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqmgHj+KyvxEVxd2aIN7Y36hxhbA/1YsmnaLw6WzTPo=;
 b=HXa0fpkl8fXLz74oD4dSNKhYs7zDu++iDIPplhdFMF/sKo/HjPmvXyc7w+dTMlS5u946wxJvYMr0vqM6NRS+ZcXBFhlz/GcHIGzg7bZ4J1D65V7Vv/Y5Fdb6gyPEziPCBHOPuA0nuUUlZVYwYDPva/34hdt58mjmPiVbbz5p52I=
Received: from YT4PR01CA0052.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:111::21)
 by YT3PR01MB8947.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:16:42 +0000
Received: from YT2PEPF000001C9.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111:cafe::a7) by YT4PR01CA0052.outlook.office365.com
 (2603:10b6:b01:111::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 14:16:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 142.180.224.216) smtp.mailfrom=telcobridges.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=telcobridges.com;
Received-SPF: Pass (protection.outlook.com: domain of telcobridges.com
 designates 142.180.224.216 as permitted sender)
 receiver=protection.outlook.com; client-ip=142.180.224.216;
 helo=srv-code1.telcobridges.lan; pr=C
Received: from srv-code1.telcobridges.lan (142.180.224.216) by
 YT2PEPF000001C9.mail.protection.outlook.com (10.167.241.21) with Microsoft
 SMTP Server id 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:16:40
 +0000
Received: from srv-vmware-cmcburney-tbos10.telcobridges.lan (unknown [10.0.0.68])
	by srv-code1.telcobridges.lan (Postfix) with ESMTP id 014109628;
	Thu, 19 Nov 2026 09:16:39 -0500 (EST)
From: Curtis McBurney <cmcburney@telcobridges.com>
To: netdev@vger.kernel.org
Cc: Curtis McBurney <cmcburney@telcobridges.com>,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	willemb@google.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	almasrymina@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: keep txq->trans_start on repeated netif_tx_stop_queue()
Date: Thu, 19 Nov 2026 09:16:30 -0500
Message-ID: <20261119141633.3118789-2-cmcburney@telcobridges.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119141633.3118789-1-cmcburney@telcobridges.com>
References: <20261119141633.3118789-1-cmcburney@telcobridges.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PEPF000001C9:EE_|YT3PR01MB8947:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 99bd3a63-230c-4cda-46a0-08df4647baf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|30052699003|18002099003|22082099003|10067099003|56012099006|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021135927099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	F5FLmrT7IdOi6FHOSz24a5ydvDPEJLbZrYNjvIiBUdyPXfKITEDfKXmluXigUQoQSy8nn/g56I6Ulxqe/YDxXsmggpROo59qsuFTIOuoEizaowzvjTVomuditA8wyQb6MYwvvRb3qdQuZf865B22h5zuB0jorPsboBpntQ0rq2X2Cdxzli75T/J/DbGY/8B/Y9dfL5sUc50+pEJ5vlPED+QhF9aWzUWGV5vyo3aN4nBe6Vuc5JZmvJf5+OGv497phkzrMWgAMwQ54t2B73I2l6meL0qBa4yz/jmfdieou13Frhag+W44WlKeQy7eVLrnwjTVgEEZKwr/wAdGs3rWJ3EPmb1MA974Kp1EP6E8q2idXcm+O+Eott657x+XQq+rpuz5TvPY5Gvpd5Fd4ouAYvq+rkzkTiC/Fm9LLIEHtyKqr+JD00SOeR+2iHAFYFhUupH5LyxlkMrNtpwFj7a2usP65qVvMkL8cVTA6gP65LDyklERUs+Rd0aCcizB9lAdrUszsUUkHg9b4vFNCfVcfjWtQFz69EVlzEvzwi5AprT++VhyfcekQZR3r9qA+yJw98BOZfnoYrUVHI+aWi3avNoTqb/84zCfxMgF2pj4sJ2aIXDCvX5wHI39687LxFikBehdmYF4QT7CtXhbDa4n/ARH9ro+zw9R9gewaBjb+3b3T0glEqpDT1tX1e5+lnXHJg/bxb7rgNR+YvVCreBnwQ==
X-Forefront-Antispam-Report:
	CIP:142.180.224.216;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:srv-code1.telcobridges.lan;PTR:ipagstaticip-a30715f8-af06-ab92-2e59-6516aeac2c90.sdsl.bell.ca;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(30052699003)(18002099003)(22082099003)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0p5/FGg5gmbzsmZkfZRtsmCk7sZjL1inidQMg05H9e8BGp2fAI8oUBbTUxOtuJbZB1yDfNaY9hKKWA/FkiplSN4+Kq9mAojSuesdoRojUg4Ub+uK+1wpBe3uheFhFUdmF1E+F7xl7y+hH5RL+rz53Pnn07lj3I20Uh95UtOE2gYWQLeY/CEJ5VyKCg/y2zxSIfZxGRT/hatOP3E265f/3ZjvDIZl/VbutbDWTe/d24eLkXRfTXO4Ryn8Xj+agycbZ5+vP+Bpgm73HTHXeKFh1GzbdMo1PkmY3nQY6YoJlqeVs13Y9dWmOWSWvdv1acRylDw4H74U6suL08nOjiDW78S8ansHU6ViYUAWunmVWNPAqzpDybmmTeRz/SP3SpZIN9UmRPCM6NnW288Jq6pTJ7FZmN8ueckkOhl/KIKz1DxeIPfS/fNQMweVlk8/Mlez
X-OriginatorOrg: telcobridges.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:16:40.2568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bd3a63-230c-4cda-46a0-08df4647baf6
X-MS-Exchange-CrossTenant-Id: 5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5;Ip=[142.180.224.216];Helo=[srv-code1.telcobridges.lan]
X-MS-Exchange-CrossTenant-AuthSource:
	YT2PEPF000001C9.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8947

Since commit 95ecba62e2fd ("net: fix races in
netdev_tx_sent_queue()/dev_watchdog()"), netif_tx_stop_queue() writes
txq->trans_start on every call, also when the queue is already stopped.

Several drivers stop the queue from their periodic Tx hang check and
leave the recovery to dev_watchdog(). e1000, e1000e, igb and igc call
netif_stop_queue() or netif_stop_subqueue() each time the hang check,
requested every 2 seconds by the driver watchdog, finds the hang again,
and do not wake the queue. Each call now moves trans_start forward, so
dev_watchdog() never sees the queue stopped for longer than
watchdog_timeo (5 seconds for these drivers). ndo_tx_timeout() is never
called and the adapter is never reset: the driver logs "Detected Tx Unit
Hang" every 2 seconds while the NIC stays hung.

Return early from netif_tx_stop_queue() when __QUEUE_STATE_DRV_XOFF is
already set, so a stop on a queue that the driver already stopped
writes neither trans_start nor the bit. A queue stopped only by BQL
(__QUEUE_STATE_STACK_XOFF) still gets a new trans_start when the driver
stops it. On the path that sets the bit, trans_start is still written
before set_bit(), which keeps the ordering against dev_watchdog() added
by 95ecba62e2fd. The early return issues smp_mb(), so callers that
follow the stop with smp_mb__after_atomic(), such as
netif_txq_try_stop(), still get a full barrier.

netif_tx_wake_queue() can clear the bit between test_bit() and the
return. The queue is then running, as if the wake had come after the
stop, and the next stop writes a new trans_start. Setting the bit
without writing trans_start would instead leave a newly stopped queue
with the trans_start of an earlier stop, from any time before if the
caller is preempted, and dev_watchdog() could report a spurious
timeout. netif_tx_stop_queue() is the only function that sets
DRV_XOFF, so every transition of the bit from 0 to 1 follows a
trans_start write by the same caller. The time between that write and
set_bit() is unchanged from 95ecba62e2fd.

The issue was observed on a system in real use: a hung NIC kept
reporting a Tx unit hang and was never reset. Code inspection then
pointed to 95ecba62e2fd.

I reproduced the issue and tested the fix on an AlmaLinux 10 kernel
(6.12.0-211.74.2.el10_2, which contains 95ecba62e2fd) with the e1000
driver on a VMware-emulated Intel 82545EM. Reproducing required
modifying the driver: a test-only module parameter makes
e1000_clean_tx_irq() report a Tx unit hang on every hang check of one
interface. netif_tx_stop_queue() is inlined into the driver, so the
patched variant was e1000 built out of tree against the 6.12 headers
with this change applied. With the fake hang held for 30 seconds:

  unpatched: 15 "Detected Tx Unit Hang", no NETDEV WATCHDOG,
             tx_timeout 0 -> 0
  patched:   first "NETDEV WATCHDOG ... timed out 5052 ms" 5 seconds
             after the first stop, followed by an adapter reset; the
             cycle repeated 5 times (5052 to 5584 ms), each time
             followed by a reset; tx_timeout 0 -> 5

This patch was not booted on the net tree. The KUnit tests added in the
next patch pass with this change and fail without it.

I wrote the first version of the fix. Claude Code (Anthropic) reviewed
it, wrote the current change, built the e1000
reproducer and wrote this changelog.

Fixes: 95ecba62e2fd ("net: fix races in netdev_tx_sent_queue()/dev_watchdog()")
Cc: stable@vger.kernel.org
Signed-off-by: Curtis McBurney <cmcburney@telcobridges.com>
---
 include/linux/netdevice.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 435be7880d7e..6c0c38d8884a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3805,6 +3805,20 @@ static inline void netif_tx_wake_all_queues(struct net_device *dev)
 
 static __always_inline void netif_tx_stop_queue(struct netdev_queue *dev_queue)
 {
+	/* A queue already stopped by the driver keeps the trans_start of
+	 * the stop that set DRV_XOFF, so repeated stops from a driver hang
+	 * check do not postpone dev_watchdog(). Neither the stamp nor the
+	 * bit is written: a wake racing with this call leaves the queue
+	 * running, as if it came after the stop.
+	 */
+	if (test_bit(__QUEUE_STATE_DRV_XOFF, &dev_queue->state)) {
+		/* Full barrier, as given by set_bit() followed by
+		 * smp_mb__after_atomic(), see netif_txq_try_stop()
+		 */
+		smp_mb();
+		return;
+	}
+
 	/* Paired with READ_ONCE() from dev_watchdog() */
 	WRITE_ONCE(dev_queue->trans_start, jiffies);
 
-- 
2.52.0

