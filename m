Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794992744;
	b=RPCvXfU3igy7HD/L0mnoMiXY19fopEFrfadr3x4DBCATse5RVMssQmoiJ/Ruv3BlkbR1
	 sh5Pt/BM0Rs0GNEUuV05h8YhxcGXfJjgNg6ZN4mNahaS+njIkK+VrQm1MSIkNC7b40efr
	 WQuS6aaIeW9S4peQzju7Dl9PwWQe5YEUXwLfrGzcdjZpl3RlPN0XUbFjMdeeu6bDZU6gm
	 o3buqcjEta18ryKUS36ig1MD4z7rjXf5/QjnFLmVHgJqtPOOeiEtwxfCqr0n80IudzEuK
	 WHHbHCz/AQS3lpxn88X2QSbPk25pj33cstfMfQPQnNHmeJn8GRirD3u3EdxzcNLPerw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992744;
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
	bh=w6HRPy5hKMGwL5q8NZ5h/UDb9LY4ViE+YiJQZIqfz9A=;
	b=Y2RruWPKPt5ey5lgQCuLTnPDHxRDcMGoIkdyroFVGqC+o9WWiIjO5CiIjHFpkEtyfY/A
	 pTJy9XS4pw10DHLpS1KMyWFteSneyrRUW7wXL39Bw+OqQyDy70PD8r7jnYJIiE5l5uVsR
	 sXFwqgEMBwA2ygP2tmW+/CkOrbGMrWNAOeC5fuQWAc6wQ1IBLCchrFnMiQC8UARNMXM9I
	 JmXVnqX27Smd7Kg/YB2Xe7A43JlNPUEfE4kRv002322PuKRTRtTLYA/2a1C5D0TJedkfd
	 hl/tE/HXDpGYavVvUJPqgfDSiOdfaauGExl2Covh9FD15YkJMCsouHPKU1k11EzURZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=fQ4VlJgt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D25606A31C;
	Wed, 18 Nov 2026 09:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D25606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=fQ4VlJgt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9bPnbQ6ZdJFK14irohxMwpajWhz0A/nPH0dcyf1/Eq8mv3M8Pqj9dZoVNj4ra1YR4Zboay8LEhm3tBbb9a6uec7eZk+rnvjxUsiZIFcA4naTxYdxmkGE9u6tKGmz1fqXS5G5rEV7Lhr/fzjQ0W+uB0xMTAJghjeWdgFF3OG2lQQzkKiSNuOJtjH3XaWXDkagPfFobuO+dKvVWHWO1d+shA9uh9D7lzwaa74eXxOL+jhIIUSqbTYyUeMJnqXfZzeyhEnobduOXII4492NCf4e9064WJkFpw6QvUkOl3NHPl6ZpR/LKU/zPQ0cHadjZIfUQK9t5jFMS3Gy5DkU94iDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6HRPy5hKMGwL5q8NZ5h/UDb9LY4ViE+YiJQZIqfz9A=;
 b=Uv/SgWMUh+98TAEKliSGYpOuFpYygWEG5w6v832bPnZ2oL7NMi1C8JQt+dvKgnAf0lY3xd/sOpBa41XFzz9Zmy2SBWHXAOQUOZmdxyAyUBnkkTFx+97f/A6oqtA6MiMVNMU8KjxbDIUHpFczl0UybOuiIGsG78PW5BJ67ffBJv1DvZfBrOfLpPsEXrqFbZFR0pocj8EtlavggSdfTXL65qdIuhbwkpxMz2UNjgXXvIO2Nw4oiWl5TCNAMndTdZRQFHoE0nRo5dhmJ79i4/reHmNzjdgNjcK7xtQAO0hTfxb1iC3LETQQmY9YSt+TR6vKsSjHHZGZSmA191bBfSSTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 69.31.5.41) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6HRPy5hKMGwL5q8NZ5h/UDb9LY4ViE+YiJQZIqfz9A=;
 b=fQ4VlJgtXX819Kbe4PTwj95moWCgjR9vpJx7Y1DdcitJ4/QgqNUTftnNBWjvR6o70T+TujY4f6Z/ykhT1n8i08wW91PesA3RbMDRRsjYNchi0VoBA6+dg0MhmKhSPhqVTi5JU/ibjFtiC39fE9r4FuGHV/gEvcmmWjDKcoMlUzo6rngRb3ai9pD82E6/xWLwk7IFrE+gk8Cm1QfUuMEnhpGA9gYxt9Ogkxa7MGAy5n+kSTTZbkyBNehBGK1R7ZSopzvvnLHLHq2OkSFwlUNRwA9NyR9Z0fPXoC1gQkQHEpKUO+v9joKWKYwTmZhTfXqqGE88HxTzII6Gzzkgm0tiFw==
Received: from BY3PR10CA0006.namprd10.prod.outlook.com (2603:10b6:a03:255::11)
 by DS0PR02MB9324.namprd02.prod.outlook.com (2603:10b6:8:144::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 09:05:40 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::7d) by BY3PR10CA0006.outlook.office365.com
 (2603:10b6:a03:255::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Wed,
 18 Nov 2026 09:05:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 69.31.5.41) smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 69.31.5.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=69.31.5.41; helo=jabil.com; pr=C
Received: from jabil.com (69.31.5.41) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 09:05:38 +0000
Received: from USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 18 Nov 2026 04:05:23 -0500
Received: from 0BMCAMI.corp.JABIL.ORG (10.11.27.252) by
 USASHC0HUB01.corp.JABIL.ORG (10.11.24.130) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 18 Nov 2026 04:05:21 -0500
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, Matt
 Johnston <matt@codeconstruct.com.au>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v3] mctp i2c: fix double free of midev on netdev register failure
Date: Wed, 18 Nov 2026 17:05:15 +0800
Message-ID: <20261118090515.3390034-1-kenny_hsieh@jabil.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|DS0PR02MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 547b8d3b-6ae0-4be5-b057-08df45531d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|7416014|10067099003|56012099006|5023799004|11063799006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	u/8hs6Y8fCkG7DSSnhNLwEgNfwC0siOr0vwmxijzZzfLXc2RwEMyQ2XtE+l6Ym+6AUemmp+XE3U6Sr7/nktUddZHP2GZC5Pwgkw6WO5lmWoW/RIMcTp9z35C8e5aoUYuzNW/wNpKyH4rpZHKLQHAkOGgbwEyzYiLi1zocgC3RFWepC4nZCXrsHwgk1SOdVXXCePzPq+3ZF4FIL6m3gkZflXL8OoqR4/X9gEpJ267kg2I26MBWP4ufw59GpW4UPY89xjMtzNgB0CBMgL1X1rIB9Ih2l/PmcbqkCmKB/3E7bh5BOyZ6ezKFvPkh52kPNw6ydXyUeJ+Q//eQw0/ShQ4Mu/ZtnS+O+eBw2vUz4M5ycoL0Wkgneah2KCLhcZutGO+/1m8B01RG2B0lU1T7yZdPKrzcXW/n4GIASFRVyVaau6n6fTaDKmzYlYoX9ZlRb7/EIfdas1vFqqVArjhJCntDkiQGMLGvJ1WW/T2gzT7Uypbj42mAYL8eFFVrJIUzT5P6qouNwOGaWOJBDUgVNwA3e/Rdqsr9/JP8wIpqTFDxnMvWD/V5lXp1wxbpw50SBda2s9k8rBYLavhWyF9srfBM4z2s/vOXGdjJeChBbquYgPV7kUWcBGOwp9HWyOYfkX/BNTuIQL/qEeR7pJYLRPN3g==
X-Forefront-Antispam-Report:
	CIP:69.31.5.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(7416014)(10067099003)(56012099006)(5023799004)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TFRIQu1dZOQiyjixFBPAFI8KOqweHTawzhJfjDXER8/ZT1G2tkq11p8lB7h808w/S6FM6Ew5s4XzoSbdtL+o/e701Y+jtKKYuAhU22h10zANFuvnnbUygTwZaCqvfRL9II/eMEc/GIp/nhDr2NSskJOxu3YGIV1ZHP0g17M3HCc13XcRlwTGtCBVT9AA79jY4sCOXC90qigI7UTPN6yDRTUHQhASi262Z5n5z0k8q1p3LIWh0ib25zolwHIQ55MhqvaVnMFp6zeE3YBwC8cLq8LHQKQzwYYKQUAjK1k8YkbNDLtf1PZC1LJ4V7zRnNmGg4aVv4nxe4RkyLkTATkCSM+dSQoy8i2ooA5smQEAq4CggK0oL6qKE7AQuOHSIB6suItrcz9sXQEWF05IhZ4PQfOHS4MUqmwYy0FIUAUGiTRywbFPH25JDNNn3McHdAvu
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 09:05:38.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547b8d3b-6ae0-4be5-b057-08df45531d8c
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[69.31.5.41];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9324

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
mctp-i2c change, as a problem that predates it.

Suggested-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
Closes: https://lore.kernel.org/netdev/179239912623.3135.11352652156626817288@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Kenny Hsieh <kenny_hsieh@jabil.com>
---
v3:
 - Kept ndo_uninit, but it now only drops sel and purges tx_queue.
   Removing it in v2 made register hang if a NETDEV_REGISTER notifier
   fails, and moved the purge after the refcount wait, where a queued
   skb can pin the netdev. Both found by Sashiko on v2. midev is still
   freed only once, in mctp_i2c_midev_free().
 - Rebased on current net.

v2: https://lore.kernel.org/netdev/20261027053715.1623087-1-kenny_hsieh@jabil.com/
v1: https://lore.kernel.org/netdev/20261022031704.2295541-1-kenny_hsieh@jabil.com/

 drivers/net/mctp/mctp-i2c.c | 86 ++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bb..a3d0cae41e13 100644
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
@@ -782,11 +785,60 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,
 	return midev;
 }
 
+/* Removes midev from the parent i2c client, moving sel off midev.
+ * ndo_uninit and mctp_i2c_unregister() need this before the refcount wait,
+ * as sel's netdev reference would block it. A second call on the same
+ * midev does nothing.
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
+/* Drops queued skbs, keeping the embedded unlock marker from kfree_skb() */
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
+/* Runs inside unregister, after dev_close() and before the refcount wait,
+ * including when register_netdevice() fails at NETDEV_REGISTER. Both steps
+ * can repeat, so mctp_i2c_midev_free() still frees midev exactly once.
+ */
+static void mctp_i2c_ndo_uninit(struct net_device *dev)
+{
+	struct mctp_i2c_dev *midev = netdev_priv(dev);
+
+	mctp_i2c_midev_detach(midev);
+	mctp_i2c_tx_purge(midev);
+}
+
 /* Counterpart of mctp_i2c_midev_init */
 static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 {
 	struct mctp_i2c_client *mcli = midev->client;
-	unsigned long flags;
 
 	if (midev->tx_thread) {
 		kthread_stop(midev->tx_thread);
@@ -797,17 +849,9 @@ static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
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
@@ -827,23 +871,17 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
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
 
-static void mctp_i2c_ndo_uninit(struct net_device *dev)
-{
-	struct mctp_i2c_dev *midev = netdev_priv(dev);
-
-	/* Perform cleanup here to ensure that mcli->sel isn't holding
-	 * a reference that would prevent unregister_netdevice()
-	 * from completing.
-	 */
-	mctp_i2c_midev_free(midev);
-}
-
 static int mctp_i2c_ndo_open(struct net_device *dev)
 {
 	struct mctp_i2c_dev *midev = netdev_priv(dev);
-- 
2.50.1

