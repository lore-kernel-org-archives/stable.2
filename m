Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515177;
	b=APumEvXoZY5XY4i/BIW8DtTm/KJ6jvg3ksX/yWPnekzYB4STq9bmN9pv/AaL7rou8Zcc
	 bH0w7V5lkprBzUWQ8qj+Ok2yAO8gfIEIiF0jr5OWtNGskPLeGNoV6GQy0uyN8vUTFQs9+
	 nEkg/VvJRtNsJmyp5W+de7jlmpWgL12B1HnJSxglXUffkLpUHGe3qkhBKnjRiuhGgksJK
	 kL+52fCg8OGQ9gXCDAl6e+ddnDTVBluCsEPgsckjr8laJChwM3dEitGHGFDPayp7FQTMc
	 aBOUed8ej/t+ryZL/GlfgqkmamVq/gL1J5XjhHWwmG6ozruO3gBYPT5+FC6oY63NrTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515177;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VKC+C8ybzGYMaCz02wqAguW/gdEv3GswSoOixLdvuEU=;
	b=TJMaS3+x+hknfOzkW8AMX0mreu9HgVwqImehM8KaN0h25bhQY7brq+2zybjXreSKcYR5
	 +uqL9oP64HcPCUsMv7AP1ceLId+YKW+jTgdPNjOWKJykxuWHFg6Hkp7UNz8iARVvHqsiB
	 jxa4OgUz1dsHB5KySd9k/k0YpwAmSYSbGaTNt1904hQ7rfawQlTR6RgF4MDAzjnf929Uw
	 Ni0ARbcOJQeNOgEcT2lsHkTEzPP3sUS9Y5SP1t2M46OVmFUCr2FuhVpIJwaWlIb1RF9AI
	 xuCs4j8El/0CSu7qRTq9Jpn0fFBUdg0FPJmQ46LqocVcKUNAtcSYO7rhk1BO82mVNJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jabil.com;
	spf=pass smtp.mailfrom=jabil.com;
	dkim=pass header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=XpzPLph6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.25
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C26606A690;
	Tue, 24 Nov 2026 10:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72C26606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jabil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jabil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jabil.com header.i=@jabil.com header.a=rsa-sha256 header.s=selector1 header.b=XpzPLph6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzLf7IA+NwtlmnuMqCIBCL7m99pef9i1RrWpYsX/5ezyky4X836gwQ6nW3Qmgmhkxq8OyJB9GxUP6DR1VrehUwgpBWS5hv22FH0ool/IeXsTCv3Xt41wufW6tPXzcZkDLBqn2DiipvmDGaIN0aMNtzBJjYZ5ye/q91nHSGy03+C/2Picet452LVqaqlfnpAbwunyl/RGqPsw9L0eYa4C4QfWXZ2BWJd6X+hH0SVh3DKRiUWGVlf26SSH7j5QzMw5H5QFnhrVla0V9KX8DYGcSQnFA5uEUeSVn7X8P57arPYMZO7r+mSuQ0RqQ34meq8Gr4HbDxhEC1KxMC/AZkRwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKC+C8ybzGYMaCz02wqAguW/gdEv3GswSoOixLdvuEU=;
 b=Ie0MEOe7nEP9cbCDgRR778UilL7JXVzXQFRAbC3EOOl/NuGZ5hxHxEnH9tkqXk3TS3tmPHuW8+78BGCYYVbOkasiIHBJAZPvkzpZKqm+5D+dPQh1fPiaICg3XIS5PZUeHnX5LCpjvbWRgpf3moMDbO8lvw1xZFqRUVGJHgpYBX/or7ociwduR4kskM35Nxob5qd58Efa5XiR0tVrITsbpnaqWDoo8jABM5kO+GOHLS6PAFcReQD7P48s2w4FPZaAP87Ov5rBN9e21P5BN6x6iSDB7wFMCaWqLvx1rn0KgVnJtliqV0rbxjpiyYvcL32IARh/qBeucD9i9OED/QfBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 69.31.5.41) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=jabil.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=jabil.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jabil.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKC+C8ybzGYMaCz02wqAguW/gdEv3GswSoOixLdvuEU=;
 b=XpzPLph6ZKN46vOXXiDqTh9+6D5PEsgD1poosT9B9RsfKzwOnY+d/fULN5BpoT9s2sDJZlpxLQJz8wDp5EdYnuZ95bvNxzrBJ2ucY8RgqvhaRZTri6cdtkhQfLPP2eHcb2nNNxxg9ip3WquYszr3SPZx3bMvUVAtKQQ7lM46pNQglzxraHiOJ6khzeYF4HKCmmxEbV/vmzab9nOOyL7JtMRWCS2YdoRVcpai85ZrT053S3Q/a8qO3yB1IHbvsyYkvqG25+1M+MsVSSktNEMHveSLdyFUYA65vM6+TcxR9aHKYWL54Hhfrxc24M6trjhHp04lxYZ7a7qr0f4PzwCEFw==
Received: from MN0PR02CA0012.namprd02.prod.outlook.com (2603:10b6:208:530::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 10:12:43 +0000
Received: from IA0PEPF00000039.namprd03.prod.outlook.com
 (2603:10b6:208:530:cafe::6f) by MN0PR02CA0012.outlook.office365.com
 (2603:10b6:208:530::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 10:12:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 69.31.5.41) smtp.mailfrom=jabil.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=jabil.com;
Received-SPF: Pass (protection.outlook.com: domain of jabil.com designates
 69.31.5.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=69.31.5.41; helo=jabil.com; pr=C
Received: from jabil.com (69.31.5.41) by
 IA0PEPF00000039.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 10:12:42 +0000
Received: from USPLND0HUB81.staging.JABIL.ORG (10.11.24.250) by
 USASHC0HUB02.corp.JABIL.ORG (10.11.24.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 24 Nov 2026 05:12:41 -0500
Received: from USASHC0HUB02.corp.JABIL.ORG (10.11.24.125) by
 USPLND0HUB81.staging.JABIL.ORG (10.11.24.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Nov 2026 04:12:41 -0600
Received: from 0BMCAMI.corp.JABIL.ORG (10.11.27.252) by
 USASHC0HUB02.corp.JABIL.ORG (10.11.24.125) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Tue, 24 Nov 2026 05:12:38 -0500
From: Kenny Hsieh <kenny_hsieh@jabil.com>
To: <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, "Matt
 Johnston" <matt@codeconstruct.com.au>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net v5] mctp i2c: fix double free of midev on netdev register failure
Date: Tue, 24 Nov 2026 18:12:37 +0800
Message-ID: <20261124101237.3884438-1-kenny_hsieh@jabil.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000039:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d450710-eadb-42e6-9b64-08df4a1379fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|10067099003|11063799006|5023799004|56012099006|261021121427099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Ge91guC5V7IRtds0871ez9gH2m3lgrjoQBQmjscSeB/K65q5rWG1oOwDwV9bvNVr5izvvM6y6Sa3/FCO5UFa16Af4lnu6xZQdzP/pL2VmTn4sS3pw+9eT2cxmcNcetz7GZ8Bjkd7Z9It0aPr0sS9CIBf/nnlovvj0kp8P2hYWcZxmEL48EW3Xj6c/iica0D4tAUHpNEFCS1L7cQTblE3fqBhMTByOu1l/BuFMfazhGxsFvaclpsHVslOmg9w2SaZE17ttz+NrYuKJTVFhwPOPEyLIw3RXVFoGhZF3gjjlYzlZYyhfCOEzV3RJctv/lIaydzlwBjb6sxaS4ZM6nMhCwVEHLkTA5TT+NdO4s/eUpFsfZaerylMb55nhOIwpypGvP04HpBu9CfY4DvhEn/kYhFTu18iWmWjfGHkbSdUCh3dVQxL3JMrhJAWP0PoOaJ1KI10Fpk+8/UgJQD4H+tK3Y6UZkrQY/d50TNtbgmMtwvyCVxKN0latfwELww18gPrhm/9GTKRT9qIPEY8NRVA/stuHqy58uiSgbqY0KoI/hnIvmW/Cs62wc0j1oa4cCsXeCXNd0G1P6bDPcloFC2JgAEVjec4UgVsSkfErM1baZlaqEOiPJaltfHyZRuV9Dhpb6K6k/oEZiIM129I4/WQaQ==
X-Forefront-Antispam-Report:
	CIP:69.31.5.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:jabil.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5tkS5sXWcN06Qg5orNCDzZTseyaA9O+UFO+eMGtFrjVSK8MqX7mZnM/tKje4EZVA9jerirKfxOfKAtU9hspe92zORN3lgYbLau7Kfl+VTxdutBq3rMezFe88mwyV1O+oUAIP3/gfQpKQ2pnzc/Zdl8CxA/MnZrVgKu+gOL/LS2V6Lw3dcXDA7dYGw7OpV73pQXMagRWPkJz7FrVVwr+l4byRoal/LV2h/Qo6vsDhuaOr6TjyF8XtkO36/PdqSViePVFZjQIsruMlub6DxXMNWm0qCxWfwdNnCa93xLaSYoAQi1c2UtmQvvF8Ad84zxhkCMllowVlrxzVKMrnnLUcRpFrv2UAS/Q6kLUO5e2YFm+4aQYbetJJi55bb8QMBTtBJG1XKjmir19aeueNOUqNU/orvcwxB9b/p+AkDcxKQXInlM2w496XMsnkxq6q3Jgf
X-OriginatorOrg: jabil.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 10:12:42.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d450710-eadb-42e6-9b64-08df4a1379fc
X-MS-Exchange-CrossTenant-Id: bc876b21-f134-4c12-a265-8ed26b7f0f3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bc876b21-f134-4c12-a265-8ed26b7f0f3b;Ip=[69.31.5.41];Helo=[jabil.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470

mctp_i2c_add_netdev() frees midev if mctp_register_netdev() fails, but
register_netdevice() may already have freed it through ndo_uninit,
mctp_i2c_ndo_uninit(). midev is then freed twice: list_del() runs on a
poisoned entry, and the adapter and client lose a second reference.

Free midev only where it was set up: in the add_netdev() error path,
and in mctp_i2c_unregister() before free_netdev().

ndo_uninit no longer frees midev. It still stops the tx thread, drops
mcli->sel's reference and purges tx_queue before the core waits for
the last netdev reference, also when a NETDEV_REGISTER notifier
fails, and each step is safe to repeat.

Freeing after unregister exposes two more things the old order hid.
Flows released while the netdev unregisters queue the unlock marker,
which is embedded in midev and must not reach kfree_skb() through the
purge, so the purge takes the marker off and splices the queue out
under one hold of the queue lock. And the bus lock, an rt_mutex taken
by the tx thread, was released by whoever called kthread_stop(); the
tx thread now drops it itself before exiting.

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
v5:
 - Take the unlock marker off and splice tx_queue out under one hold of
   the queue lock. With two holds, release_flow() could queue the marker
   again in between, and the purge would kfree_skb() it. Found by
   Sashiko on v3.
 - Dropped the unlock_reset() in mctp_i2c_midev_free(). The tx thread
   already drops the bus lock when it stops, so it did nothing.
 - Dropped the early detach in mctp_i2c_unregister(), added in v2.
   ndo_uninit does it before the refcount wait, so sel is now moved at
   the same point as upstream.
 - Stop the tx thread at the start of ndo_uninit. On a failed
   register it was still running, and could select midev again after
   the detach, keeping a netdev reference that blocks the unwind.
   Found by Sashiko on v4.

v4: https://lore.kernel.org/netdev/20261119094307.3864679-1-kenny_hsieh@jabil.com/
v3: https://lore.kernel.org/netdev/20261118090515.3390034-1-kenny_hsieh@jabil.com/
v2: https://lore.kernel.org/netdev/20261027053715.1623087-1-kenny_hsieh@jabil.com/
v1: https://lore.kernel.org/netdev/20261022031704.2295541-1-kenny_hsieh@jabil.com/

 drivers/net/mctp/mctp-i2c.c | 76 +++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b02476d338bbf..ef095028143a8 100644
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
@@ -782,32 +785,59 @@ static struct mctp_i2c_dev *mctp_i2c_midev_init(struct net_device *dev,
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
+	struct sk_buff_head tmp;
+	unsigned long flags;
+
+	__skb_queue_head_init(&tmp);
+	spin_lock_irqsave(&midev->tx_queue.lock, flags);
+	if (midev->unlock_marker.next)
+		__skb_unlink(&midev->unlock_marker, &midev->tx_queue);
+	skb_queue_splice_init(&midev->tx_queue, &tmp);
+	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
+
+	__skb_queue_purge(&tmp);
+}
+
 /* Counterpart of mctp_i2c_midev_init */
 static void mctp_i2c_midev_free(struct mctp_i2c_dev *midev)
 {
 	struct mctp_i2c_client *mcli = midev->client;
-	unsigned long flags;
 
 	if (midev->tx_thread) {
 		kthread_stop(midev->tx_thread);
 		midev->tx_thread = NULL;
 	}
 
-	/* Unconditionally unlock on close */
-	mctp_i2c_unlock_reset(midev);
-
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
@@ -828,7 +858,7 @@ static void mctp_i2c_unregister(struct mctp_i2c_dev *midev)
 	wait_for_completion(&midev->rx_done);
 
 	mctp_unregister_netdev(midev->ndev);
-	/* midev has been freed now by mctp_i2c_ndo_uninit callback */
+	mctp_i2c_midev_free(midev);
 
 	free_netdev(midev->ndev);
 }
@@ -837,11 +867,17 @@ static void mctp_i2c_ndo_uninit(struct net_device *dev)
 {
 	struct mctp_i2c_dev *midev = netdev_priv(dev);
 
-	/* Perform cleanup here to ensure that mcli->sel isn't holding
-	 * a reference that would prevent unregister_netdevice()
-	 * from completing.
+	/* Stop tx first, or it can select midev again after the detach */
+	if (midev->tx_thread) {
+		kthread_stop(midev->tx_thread);
+		midev->tx_thread = NULL;
+	}
+
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

