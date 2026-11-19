Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081399;
	b=AOtRqZwWRi6Syu5nL+wu4vvc1uU9+hfg1L4AGgr1MJn/jEm4FBxkTVcLkvvG04AC6SFA
	 PoO4wPD9oQ7G5yqg0HT/tP8HN4BpomGIdjb9Xj7aIVUsQIaiylIT4IapTa3S3sf6hftDJ
	 SSoze6+LgJDiz4+pvtW5cIHjbxL/hbJihopaYhCDbD5QcIZHGdyVRT41VLWfqFYJz+Vcd
	 L3rid1g5esr2uGLgDHx2lLQpUAG7NPFEmgt1Ep5v6vGPwYhcW0Hp165QxjWy5YpCLt7J8
	 ada0MYfX6bhVGL5IecYJNc/06OIuJfqNaLKeUbB1NwJi1FRi4RItDtPyS1qdEngPU+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081399;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=Ma/sL+KNLAiQEQgwCNUqHWRC8lW1jF4cfh6OvIPrF7Q=;
	b=d0z42B4BY/aTQMVkScfuZz2IpYIXi4iVoHgUXcc5lBgcR8ijc8JxQ3faahRx7BkLLBq2
	 DlGp2U1IZwyF6dbMHufgLxq59EfTe5+JWpWiTGgCxqLKqYDZe+AzcKaOYZZPzOyYryIc3
	 2G3YlQSsSm56buTLBrTLmZ2jrnfgwtDM2ZfojizAcYoRj2h8KrHYd3H/kK3upioXXw2Di
	 Zip+9AXiPBQrcFEK5K3Vlh4V4HRbacW2CtS8NNsLSCZe1mKocnKr22RmMitbLbQzFPQdD
	 Kj8cC4TcQlBs1AuOoSFoPP+C6RXHa8B171b8PuPF62umNmSmuU/f4D0+qfDRjd+L++A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b="vMx/PkxH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FD3606A324;
	Thu, 19 Nov 2026 09:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7FD3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=vMx/PkxH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7Ahw2dfCCd5KmbRJd4oJ1+lHaWzZlUyfGzXTU4C3iRETokhALJfTuofF0QARZJ/IfaA5hwZBhiXKwouXtOSWihLUFPnxwGU7Kc6RQroXSoGrJgvP3NatSnJZwsQYBWjQaJbG47oX5RqnRuZyvQgCE34RlvAe/NJYdNFO9yuMymlalqAklUZJKx1omUPdxQ8JYyYhlzyvPmqnaBgDPq3E/kRyvWluHH19xEXjKcS3aTxbScn33qfkOq2FXmYAndIcTe0kN8usXFWPizTeZC/o+enj8fzjsD30zReqFD12XHgboEEm8xrZ6L7wOtcy62wA/MYPh3ia4nlYQjqIslR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma/sL+KNLAiQEQgwCNUqHWRC8lW1jF4cfh6OvIPrF7Q=;
 b=nabbV4AwD8tJ71LCG6XccOq0xgZMwYfvtQam2DO0CFw8I1GIWfOrtPhsnbsAQKE1iGlw8MT1wf9YOiO+0Q6FgQRt6XYeDE6zjGoPTvau8NMbiJbcGxco8CFBukdXwz9C9z4TBHcltLKe0fHmfB9xRJeWxbMTObPW29qF8WXoBMOzJyfih0db47mjgJIA9SkmQUTNSaLogYsCVbahz5W2TBvkb/2oPXziK66lSdZ/dHK/byCdpEo6zg6l05sKaTabDyj3IDXMJEtcnZ1AYq8Fr25FanzRYZrqMZ8BFcVHHRGhFhfJmAdDVPOl1SVjnsAVfwP6sWjz2imhheTbQ6zmPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 69.31.5.41) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma/sL+KNLAiQEQgwCNUqHWRC8lW1jF4cfh6OvIPrF7Q=;
 b=vMx/PkxH9B1KtCmigvrq0Ctc3Hmo91MW8KbbaXax0jsD9I/k1u2Yn6sChpRDjOw6OccCaQ2RfLXMTTduP9zynD4hewIkDvCSlscoXUcReZtGvBJHdB7ejvfBa8Ea2qd2NLoqFdA8/JAPvpQ9Bas8VGs8enYp8kHxgr3ZSvkAJsu65CBX9cn3Djd5oxSn1WcVHTGyzocHl7nAuPH1KgxyQwR4McUCP9GF2+MqxF1BfqW1v6IYQA28KigA1nkEeKPiAcdAe3oKmDDMJ5HEPXyfHabwCBfWecWIv6/oe12q0I6jGrCLS23R8Uo8qzSYZ8sbYhf7IQbTXDmSOnevsCNZDg==
Received: from SJ0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:33a::19)
 by CY5PR02MB8944.namprd02.prod.outlook.com (2603:10b6:930:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 09:43:13 +0000
Received: from MW1PEPF0001888F.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::78) by SJ0PR03CA0014.outlook.office365.com
 (2603:10b6:a03:33a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Thu,
 19 Nov 2026 09:43:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 69.31.5.41) smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 69.31.5.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=69.31.5.41; helo=jabil.com; pr=C
Received: from jabil.com (69.31.5.41) by
 MW1PEPF0001888F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 09:43:11 +0000
Received: from USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) by
 USASHC0HUB02.corp.JABIL.ORG (10.11.24.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 19 Nov 2026 04:43:10 -0500
Received: from 0BMCAMI.corp.JABIL.ORG (10.11.27.252) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 19 Nov 2026 04:43:08 -0500
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v4] mctp i2c: fix double free of midev on netdev register failure
Date: Thu, 19 Nov 2026 17:43:07 +0800
Message-ID: <20261119094307.3864679-1-kenny_hsieh@jabil.com>
X-Mailer: git-send-email 2.50.1
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
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001888F:EE_|CY5PR02MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ff50a2-bf9d-4c41-917a-08df462186bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261009223027099003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	a2dBhpH97tmNFIf2Y4hCb0eqInUrFjQqxZHILuqDMoUbAAGMuxEN7lnhkxvCOa01eLFhmWfcmqjESs6LjR7turSCyizQ6KZ/VR5+6Qn1l+lvTpyo8dJxagD0v/GNl/dvImrQJIYL0DRIBq092q/5TZX+/4DHmPzxAEPpjKUrtPbG1Ymr0Uq+Yuiqlu7HeVuXEz0+d8VeXn/4o4PuYlS56yNXGI16jVCxlbYlrELIsNzQYqcwxzYFk2mxoDdONpaneOVk9AkjHf7wtPoRUc6xbdl6BciQdEmQL181BBXarjykpxvEd3hYtbIAoxZL+4NN7gvLzQ+HZmBmR5N1xoW/I50rqFvi+rFGshsD7iH5HjHKAQpcQI55wyPoVycD8i7wPxyqDMv1daPtgszQllZRaVTkDJNEwRd4TItbC1nrioIZ9u70b67xkfGXlo87mi4/wM5+JbIm1d5erbhfIbW6haH/QfjRo6XvsCpyuaKnB1UPzO05PSSf2e4dcLSQsM0IUC6ppXpyx8PDezUVH9423DF6I2y9EOf/GbJTbYIAa/e4OJWUIIDYkmCNBiTqSaFVDKpCB3kRhsj0HzKszT3Az8c7CApfOOUJBUG7X4IsreCL3q7rDDx5Jn/PjtjyEWGUholc7LIGFgj1Do2Rqdmrqg==
X-Forefront-Antispam-Report:
	CIP:69.31.5.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bfv2jEB8CXDkDx+MSY2HWFt9RBiC6oQ2rgNJc3yvQQlvJ8pTD1iTG+0q7LIx0zOXZrbZnKcrIT+EmrTvSC9jc0Bh7O3nRDiA49Ivyyfbks78xYKD22GDr8jHJZaKe3iM1UGUvwZtlnYVZ6Z+1oHzRZHWw+gu8WV5bxUbliF9B9u2Pu9nBp6TYUqOxBfNb/57TXOv3uAoEo21MxKpL86lBHjzaZRFGitx1luBouHC8jtXXfFE+3PL1uz4/RIKa56jv3aRiPfhoZN0Qh3gCy3kARL5RWXC1I+kusjWi9hXkJBamGw/CBTpElKyHmTGqzFYJfeNY5q5g6zX8k6gjsdvqf1SEhZT2+54WD7LI3945DQWHYfTMuJrNWXng2uYrAQTcABYrpglW6iWYieAe79MZfFapTs1ZvKvj4ymtxzIUzePVhF/nywJspqrK3n7JAy+
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:43:11.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff50a2-bf9d-4c41-917a-08df462186bb
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[69.31.5.41];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001888F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8944

mctp_i2c_add_netdev() frees midev if mctp_register_netdev() fails, but
register_netdevice() may already have freed it through ndo_uninit,
mctp_i2c_ndo_uninit(). midev is then freed twice: list_del() runs on a
poisoned entry, and the adapter and client lose a second reference.

Free midev only where it was set up: in the add_netdev() error path,
and in mctp_i2c_unregister() before free_netdev().

ndo_uninit now only drops mcli->sel's reference and purges tx_queue.
Both have to happen where the core calls it: after dev_close() and
before it waits for the last netdev reference, also when a
NETDEV_REGISTER notifier fails. sel's reference would otherwise block
that wait, and a queued skb can hold a flow key that pins the netdev.
Both steps are safe to repeat.

Freeing after unregister exposes two more things the old order hid.
Flows released while the netdev unregisters queue the unlock marker,
which is embedded in midev and must not reach kfree_skb() through the
purge. And the bus lock, an rt_mutex taken by the tx thread, was
released by whoever called kthread_stop(); the tx thread now drops it
itself before exiting.

The double free was pointed out by the Sashiko AI review of a pending
mctp-i2c change, as a problem that predates it. None of this was hit
on hardware: it takes a late register_netdevice() failure, or a flow
key race during unregister.

Suggested-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v4:
 - Left ndo_uninit where it was and only changed its body, so the diff
   shows what it does now. Shortened the comments. No functional change.

v3:
 - Kept ndo_uninit, but it now only drops sel and purges tx_queue.
   Removing it in v2 made register hang if a NETDEV_REGISTER notifier
   fails, and moved the purge after the refcount wait, where a queued
   skb can pin the netdev. Both found by Sashiko on v2. midev is still
   freed only once, in mctp_i2c_midev_free().
 - Rebased on current net.

v3: https://lore.kernel.org/netdev/20261118090515.3390034-1-kenny_hsieh@jabil.com/
v2: https://lore.kernel.org/netdev/20261027053715.1623087-1-kenny_hsieh@jabil.com/
v1: https://lore.kernel.org/netdev/20261022031704.2295541-1-kenny_hsieh@jabil.com/

 drivers/net/mctp/mctp-i2c.c | 69 ++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bbf..29a186f714d1a 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -628,8 +628,11 @@ static int mctp_i2c_tx_thread(void *data)
 	unsigned long flags;
 
 	for (;;) {
-		if (kthread_should_stop())
+		if (kthread_should_stop()) {
+			/* Only the rt_mutex owner may release the bus lock */
+			mctp_i2c_unlock_reset(midev);
 			break;
+		}
 
 		spin_lock_irqsave(&midev->tx_queue.lock, flags);
 		skb = __skb_dequeue(&midev->tx_queue);
@@ -782,11 +785,46 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,
 	return midev;
 }
 
+/* Removes midev from the parent i2c client and moves sel off it.
+ * Safe to call more than once.
+ */
+static void mctp_i2c_midev_detach(struct mctp_i2c_dev *midev)
+{
+	struct mctp_i2c_client *mcli = midev->client;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcli->sel_lock, flags);
+	if (list_empty(&midev->list)) {
+		spin_unlock_irqrestore(&mcli->sel_lock, flags);
+		return;
+	}
+	list_del_init(&midev->list);
+	if (mcli->sel == midev) {
+		struct mctp_i2c_dev *first;
+
+		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
+		__mctp_i2c_device_select(mcli, first);
+	}
+	spin_unlock_irqrestore(&mcli->sel_lock, flags);
+}
+
+/* The unlock marker is embedded in midev, so keep it from kfree_skb() */
+static void mctp_i2c_tx_purge(struct mctp_i2c_dev *midev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&midev->tx_queue.lock, flags);
+	if (midev->unlock_marker.next)
+		__skb_unlink(&midev->unlock_marker, &midev->tx_queue);
+	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
+
+	skb_queue_purge(&midev->tx_queue);
+}
+
 /* Counterpart of mctp_i2c_midev_init */
 static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 {
 	struct mctp_i2c_client *mcli = midev->client;
-	unsigned long flags;
 
 	if (midev->tx_thread) {
 		kthread_stop(midev->tx_thread);
@@ -797,17 +835,9 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 	mctp_i2c_unlock_reset(midev);
 
 	/* Remove the netdev from the parent i2c client. */
-	spin_lock_irqsave(&mcli->sel_lock, flags);
-	list_del(&midev->list);
-	if (mcli->sel == midev) {
-		struct mctp_i2c_dev *first;
+	mctp_i2c_midev_detach(midev);
 
-		first = list_first_entry_or_null(&mcli->devs, struct mctp_i2c_dev, list);
-		__mctp_i2c_device_select(mcli, first);
-	}
-	spin_unlock_irqrestore(&mcli->sel_lock, flags);
-
-	skb_queue_purge(&midev->tx_queue);
+	mctp_i2c_tx_purge(midev);
 	put_device(&midev->adapter->dev);
 	put_device(&mcli->client->dev);
 }
@@ -827,8 +857,13 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
 	spin_unlock_irqrestore(&midev->lock, flags);
 	wait_for_completion(&midev->rx_done);
 
+	/* Release sel's reference on the netdev, otherwise
+	 * mctp_unregister_netdev() blocks waiting for it.
+	 */
+	mctp_i2c_midev_detach(midev);
+
 	mctp_unregister_netdev(midev->ndev);
-	/* midev has been freed now by mctp_i2c_ndo_uninit callback */
+	mctp_i2c_midev_free(midev);
 
 	free_netdev(midev->ndev);
 }
@@ -837,11 +872,11 @@ static void mctp_i2c_ndo_uninit(struct net_device *dev)
 {
 	struct mctp_i2c_dev *midev = netdev_priv(dev);
 
-	/* Perform cleanup here to ensure that mcli->sel isn't holding
-	 * a reference that would prevent unregister_netdevice()
-	 * from completing.
+	/* Drop sel's reference and queued skbs before unregister waits
+	 * for the last netdev reference. midev is freed elsewhere.
 	 */
-	mctp_i2c_midev_free(midev);
+	mctp_i2c_midev_detach(midev);
+	mctp_i2c_tx_purge(midev);
 }
 
 static int mctp_i2c_ndo_open(struct net_device *dev)
-- 
2.50.1

