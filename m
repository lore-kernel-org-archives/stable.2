Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.91
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795708891;
	b=S2doTwd+NuEyFtv9QIaosXLHeTrtvf1drgctpSUclu0jySvAhyGEYUMroOc8YOGzRotQ
	 VfTujUptyXE/eVB1yXTsRlAMbGiJxJYo7Bn6eiFXr5IMY4MYc3B6MA7O5NGilialYYTrJ
	 sLRQM7wEgmw81FM/DNMpkcNqrFhMx+534I417pK1yf19Ynzw4x21OD+MWlAu8OyiN7XAF
	 psILiXEUl8pXj2+z1AzFf5nfuMbrjgIO7YNmvWq0nMBmVTlFTvHB4Ow2r/c2NWpwcpyV7
	 5y7WLSFI5NlCTB2EFXUJ4LyKGonsobSKeoP7VplNmyZoN5W5AYia2d9F+gOr3lPbJiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708891;
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
	b=HT2MYR91Cm7yySnDwlY7xoHw+JlIt92Gj1wgX5kgI57MvQQJTpBRXKRKQ2siyQA+tG0w
	 amfa+gRjrQBgp1g0gOzFSoEzMUSusKDAfJy4psN2JVCKhjwty/7CPQS0ydvBNuatvT4mm
	 A2DNU10rHdBLWUM6nEZlvTdt9ev7fq0K/G0FWmFbv64gqHXg20fvsayP/J5K5oGkNYeWR
	 bapNcBXOiWT+t45BhHcimFpmEtbKp/kJttjZFKndqw5R/kQ52Zc2dhZiqynckSlAEHyFK
	 7KHt6DlfME+LyI//2PUrwCF3YV9SEEYxkHXFnf35lkksN37PlzIhQD3ysqur45vsrkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telcobridges.com;
	spf=pass smtp.mailfrom=telcobridges.com;
	dkim=pass header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=toyRrejy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.91
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020091.outbound.protection.outlook.com [52.101.191.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A0606A335;
	Thu, 26 Nov 2026 16:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 866A0606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telcobridges.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=telcobridges.com header.i=@telcobridges.com header.a=rsa-sha256 header.s=selector2 header.b=toyRrejy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gw7UatGcUbaKholSS4pOIFemN6edTcycqfG5GSkRz0xh5vNGbAOo+UeruNHHKZN1D33+LlEoLdIr3uCE3smILjNIueUPOH9H+jsYn0W9z2FZCCCSDabhzxblB/uGZUGzhqdZxR+EXNWIFz0Zl3nBjv33hrEEo8j3adqrG8P4RgpPqK+bcYoqUKY+8fOfGUOMI70bYxY5Fby8ysmjYIDfoluuAZJZRYAFQcFkhTVHYu8qoNAQHNNxcZYAKnzve3I412as/JOixYViAIMQjQGXrVK7rXy0u12bCwBd3PFDNJIZo+DzVinQReVtKsUeznHmQBibHgVfer6A9rYVu6Js6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqmgHj+KyvxEVxd2aIN7Y36hxhbA/1YsmnaLw6WzTPo=;
 b=EF/TF4iKkNb8Abtf1p1Nb5fXPswgArjxB8JNs6nG9hfqq7k8j1Cka27z+ZmOLn+LDwKNKKNrFuuiI0tNCUdcGTurJ3Rjxq9OXJpHSyDzzp7WY4gwzRz7y+ivmzhWXRLKdcDmlCuYiXSfhUw2e2LVTYYGLFpCE5nbL/NDGVlfu8170bdHeG8LQH2dICXNnj6ZPdxC2s0ak++2ONZgs+QiKz9DPKGuG/qkVNcbk8w+ZRUeTIZez7KdckO70Hz9q/IxJE9coli4W1JDQaL7Dr4eiWOJFBQJfGil0odwyR2KaE3DKntc+EAG7B5qKbSGtQM/zzJyGnkg8/dKEpJGPIFItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 142.180.224.216) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=telcobridges.com; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=telcobridges.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telcobridges.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqmgHj+KyvxEVxd2aIN7Y36hxhbA/1YsmnaLw6WzTPo=;
 b=toyRrejyuAFexQmVcfYy/+DBGRn89QsEl+wQLWI+f5+yoy84KnF3oEV9tRGgWWMfFecYB6mONOsE6vFcO+xsf1TH+b0nV6GE6qq8OQWlhPcojzpGyDEjdeoVyadYz8ITNdViFFxyupEf1z74ZJLEHszVdAvqY+DQbKSEYPzEGZ0=
Received: from YT4PR01CA0317.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:10a::10)
 by YT3PR01MB5350.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:01:23 +0000
Received: from QB1PEPF00004E0F.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a:cafe::34) by YT4PR01CA0317.outlook.office365.com
 (2603:10b6:b01:10a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 16:01:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 142.180.224.216) smtp.mailfrom=telcobridges.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=telcobridges.com;
Received-SPF: Pass (protection.outlook.com: domain of telcobridges.com
 designates 142.180.224.216 as permitted sender)
 receiver=protection.outlook.com; client-ip=142.180.224.216;
 helo=srv-code1.telcobridges.lan; pr=C
Received: from srv-code1.telcobridges.lan (142.180.224.216) by
 QB1PEPF00004E0F.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 16:01:22
 +0000
Received: from srv-vmware-cmcburney-tbos10.telcobridges.lan (unknown [10.0.0.68])
	by srv-code1.telcobridges.lan (Postfix) with ESMTP id 431BB9655;
	Thu, 26 Nov 2026 11:01:22 -0500 (EST)
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
Subject: [PATCH net v3 1/2] net: keep txq->trans_start on repeated netif_tx_stop_queue()
Date: Thu, 26 Nov 2026 11:01:13 -0500
Message-ID: <20261126160117.652865-2-cmcburney@telcobridges.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261126160117.652865-1-cmcburney@telcobridges.com>
References: <20261126160117.652865-1-cmcburney@telcobridges.com>
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
X-MS-TrafficTypeDiagnostic: QB1PEPF00004E0F:EE_|YT3PR01MB5350:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 152d9e02-9426-43ab-490e-08df4bd6845e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|18002099003|261009223027099003|22082099003|10067099003|56012099006|261022075727099003|261026121527099003|261102123227099003|261022105027099003|261028144727099003|261026140227099003|261021121427099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	DNZatKmCZJWrKaDfaq+t4//BQIcPfFL9hJ2EZKRf0YlTy02i+yPnA0ujNzJ3WsYOGjb9a0VDGTPMQzaXQ7GDZY7NfOyFJ5zUckvd52i1tp8yPoulgxcXyhW+0/TebqNJRC0b+4wOzxwuh00DyakcRFGCKoNukGuxOMNt4k4eOciUHazdv5JhXeTG35tKVLJlze0RYQVcBkzpd7h85wAHiak3DxkEXhXCo20JKHT9thX5eG/x9ngy1z0vRBxaGO+b6QZKeghv81pxnAg4/k3TdWtGLWW/mvwfmWpm6bU+v31sOfl/rrHofkZd7E+oKmpHdcR3JxLHdCcvOAB63X/HJv1NGwfpzJE35m9NKruP4EkZX9dIuNniu1oPGCNL0PfoT7LAruTEorTCNuy0Q5qJO3jdWVbSkTkqGMstkmPiNWQ8LVdFvAIP8B2EHbGA8/LICHNQd5lkdlF/CT4bgbe2xlw9imeZG0tqy8QXNoSVfqUyJk19pblHfibomIahHENykMa8EF8VyycO5SMlwp1WrNeDU/qz1sZCCtOvaM5/BnjWn0eRTA+O3pa7B/W8vavMopKpCQaFZjRDTDISseNXDqn69iTSCZH/p9semfOhW8YV4LM8OjKw2UppDN7c6YUsgS2CoNmohWoHsNNaxyseFkVHrcKDdtBKHxM8ZU7OWXubHB0bWSKRZ7sjJ1QhH3wxSAv7QJGwQHgAEhEJrE3szw==
X-Forefront-Antispam-Report:
	CIP:142.180.224.216;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:srv-code1.telcobridges.lan;PTR:ipagstaticip-a30715f8-af06-ab92-2e59-6516aeac2c90.sdsl.bell.ca;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(18002099003)(261009223027099003)(22082099003)(10067099003)(56012099006)(261022075727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021135927099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lnnNr2sAcZVetkzpQerqQe/OynKriPHM+VFr3MPbugWxPDuz796sFV9U8npgCCeJ5kAjwteM+5J5YRSajFieziuDXq581MGrtpVWa/NsjqQ16DYnEFAZgi9sUu5qdyYbwGLofzAIKvlEg2UJetd3WRhan/9/WsNkc+Gtp2tGBO4Bf1YWlXiEMVJtao2Z1wL5HMo4MyvqOyyuwxZOsOHLLfNGh+hlG96Ej9lbPvoZexGCgNciVfeIKdEMyOfO83zNm+g+jhxvavUG1MelkdW9RS6+sTKeF5LMY6OIsfxhUQKvVClSF3D3UtwdMCfvEvDfimF0k8Zfr3FIstsrthsWbQRPAJfVf1i4K1aBJR9BydRhd5gvSIwpTq+/Tk7BLBnBwLK7vx9ulIhhOyeaNl910/4OETP/iZuVVQxmkDwYkv43LNOrss30FyntbAG5ql3O
X-OriginatorOrg: telcobridges.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:22.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 152d9e02-9426-43ab-490e-08df4bd6845e
X-MS-Exchange-CrossTenant-Id: 5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5dc833ed-bd96-4d5b-aaa0-0d8be83ae4e5;Ip=[142.180.224.216];Helo=[srv-code1.telcobridges.lan]
X-MS-Exchange-CrossTenant-AuthSource:
	QB1PEPF00004E0F.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5350

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

