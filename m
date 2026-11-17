Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943164;
	b=mlgzjGy4nP62DcLFfzj8q2FJu2E9WVjPHCYxz6CY3eEolbfsBMNfXmSHy+Fc1APFEdyl
	 HgkDREi4mIB9UQBQXnzKy0Y0NHG+EHOcyKo2fh5VSLh0Pe/qg/irwsFCAE8/Fs2HcIC4P
	 WAndsTHJT4GxFSBemuJxED5S4tSd2CEqS8V6CSKIOuwiplUWlH9hfxh2wjk/1P7/3pD/M
	 2ZbI6Kuol9s1glKbZuwikybdjCHHNHVmucU0Syhaeu+wg8tzgFuE9mL3w6XjL7SXCr/5I
	 ZRMFeBoEjoKMS5g6U9KQK74grsj+wB+qkoxDw9k28pxJeJhCvmQRtAcLK0epky9I6iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943164;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=B9Qe5tQD6qPSBbF9lnQIj4q0RhQHUryoAFWavqVMrzk=;
	b=pD6bvInqPYT/oLjql8TR7/URzjWxDXfZ8N0kDbihBdo6M8VLONVWUIY/pb2TN5VtWIWC
	 Xe6IaHuMliYkpkObpDQTqxJU388KHoY1x2sWUrAgxCby99zHRHuP2H31kxBlRdHasmMMC
	 br/iuHXaG9bfsU9ULb3ODyjR3XyaE+8rSIFGhwVOvl3HGJXycNu1UVc6XJfnv77S524Y2
	 axbbnY4U8v7Mx8K2Jm3jaOfeacaqPOeGVPvDZi0KEGTHBODXc8Sf3T8P6cWsJJ58VHch9
	 nJDygjcZjddWOe8vTQ+XbmxmZfiDhcdUKy/0UXYZ7j6B08feXJjZZAKOdPomBhN0MnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WDwOC4fa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.65
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11B606A31C;
	Tue, 17 Nov 2026 19:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF11B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WDwOC4fa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzjVULsKPq2/o8zYJs9Akn6F6/HhXdPNs5VdLQ8wF2K3qnH7wLqBLCMLxhxcQGgFKFoyO5VG6+TuEVpyiHuzpPQmIZLMMcNpxaap/U1uh6A2+a7Vur64y8DehFlMFMTlDVk/mnZu6OEraRPmeGZZhez9ISoIt2UWCZGVH6N61P7CKiUmHXCrnOtklD/U6JMor08QPv1p2WruBwhbkRl2qSlPWuq/u0+65kyP8jWJD7V41GEyfPBWlJy8JZlFO9r8XfHlLSajBR4U96S/Tmrt+j234bvbtdiwe4diB7P/YBEBVjh/sllZfuTDLl/IrCBfO2RxPeynQBCUUvlFh+SMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9Qe5tQD6qPSBbF9lnQIj4q0RhQHUryoAFWavqVMrzk=;
 b=WaeFRxiuPKY1pWky7xAgV7HFQl3Jeg4ZDYliASoSFrCCe1yAMbzfQgE1NRhkrjDhRAhk/3+Z1wMSs31b9PaUeWx8MORdOI2MxbcJZS3gBfS1VZOGttTQ1jzYPbgWXyYotWApPKFAt5tE+KYk8tw0mIj27Dwft2S2GnAEDXjMC+di7PN5egF6Zwk5J7WDKPMbN5J85R6XXf4aRT9J8GvKek+gVFAKbM3ymZWnUobnjJ19bdJGQ54WC/Wk/XZnrxuCR51/d7fEDvZlmvxeaSi9oFVQ1S8zHdNyezV25UMbWSkPzGJPobGQXoUYCDDxA+YDhUPropgEgl+ikCXydbe19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9Qe5tQD6qPSBbF9lnQIj4q0RhQHUryoAFWavqVMrzk=;
 b=WDwOC4faWaDoa98pR4s1qTXH76mjmUILeVA1xPBjCUeJmIcEWevGBZYzeQCVGwkO1mrLr5Pr7GG7YIu5xyFKWjZZhs1J2wpzLzW6BTOGZLHM+6KVQSyZb/hVAkd+m5xrBd/pvZnQI+h1Z1l8OCkMg63tzwsxZz7mdJ4c83DSDQA=
Received: from BN0PR10CA0023.namprd10.prod.outlook.com (2603:10b6:408:143::20)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:19:15 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::45) by BN0PR10CA0023.outlook.office365.com
 (2603:10b6:408:143::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:19:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:19:14 +0000
Received: from [10.11.96.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 13:19:11 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Tue, 17 Nov 2026 19:18:55 +0000
Subject: [PATCH net v2 2/2] ionic: limit TSO segments to the minimum Tx
 ring size
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261117-b4-ionic-tso-max-segs-v2-2-f9792566c5d5@amd.com>
References: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
In-Reply-To: <20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5@amd.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, <stable@vger.kernel.org>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cdddd2-a551-433c-179f-08df44dfab04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|22082099003|18002099003|261009223027099003|13003099007|261021135927099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|11063799006|10067099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	7lspOPN0He5310LnaQKO0C79wjgP5Ot+bndkY0cfQxd1KfW6RnLoNE0cFYt+PfV/JqV+iI2rzIcZn0H1Peu1Afj0a44nTKDtTkQL7jJQwmWdaVnqL8dj+rU3AO9pZCdCMT3gV2/X2iV5NOfIPYZ3ZZZjCTf59ly7YfOOTK3oksY8oINTRoCpJRDVVKZEUsr+zOWaBbScTNtdWTvwMQaqVmfYdAU+OMhltjCU+2xwvtGVg+uY5IY+eEsL2ANMmgR8C/NwojVMH/B16CKWzKUIy/m7TriZt9gQziIvPB/0iApTmg2gXL/d+n+CjCeLKeneqjoueDSMxRwWuDoT6+KDmVAy6kvIyAGQTLaiszGpN6dcq7dFwBcA3orxgwnbxfDtyjPJyI26BYZaM+pDcTVTakO/NTQx01hXBsDy0UK1sQiwDomsG+gjJeWf6lHk97zjWoFz+1+EA2kK84o6RAIzAQAhZEt2HlfpxPyK1LCkP8YVr8hy6c2hNg5ERpbiyY46RmdRYUfYP7kMaPmYRj1Vjj6LX5QXGA3ZQHPFgsEVfqRl3afKNSO+OecPvlV6CfeM2tAYYRyJ+HuwZmXyTCD53iWckoaZmJBhL9XLGmx3G9tQxoK7vVyNwhEEAfze/s6YjyrnsBXBGCudyJG215MdSBmkSCXKo6Y550meVqhU07E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009223027099003)(13003099007)(261021135927099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(11063799006)(10067099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wqi6zDhhxfAVPyYyGCgX9oUZ9XbH0gjeZmoN2y+8Zse401m8ff80vrUUDrbnGcJnxnBt0fVVPo3s0uZ/0QylLqeWPABXYuP86DRW0cb/aG7KlyugTjKxeIbil2TeDy9UZT9Jb1b7XzESNEr7ARfZQA05MxR776taGkIGhYV6GywC/X46Ah3OC1vxS0AoVkiS1gp8fllJ7/H466cSGhXBs3lB19G0FUk/GX0tdjlwtOT04B0gxaC1W21w0bsMoSAIdSWsr0L338KPcx+fqFwBHAn5CzBSySdGZ6tlops4JsljD7VM6FNgtTS7GtIVbAuyuTPSi970ITnozIxvIjwMJSzmIQo3S5j0NQskNXXE8LCusX0C8rPufeyz9kEYXOJqBMoKxr5rAF2x8HUsNZPZ9UhDA/vQBpBpaVSQNJGoOWI4Z+LlY2at6LOcK/ovmTV7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:19:14.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cdddd2-a551-433c-179f-08df44dfab04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147

ionic uses one Tx descriptor per TSO segment, and a Tx ring holds at
most num_descs - 1 of them. The driver does not set tso_max_segs, so
the stack can hand it GSO skbs with more segments than the Tx ring
can hold. ionic_tx() then stops the queue waiting for descriptors
that can never become free, and the netdev watchdog fires repeatedly.

This was hit in production: guest TCP traffic with an MSS below 64
produced 64 KB GSO skbs on the default 1024-entry ring.

Raise the minimum Tx ring size to IONIC_MIN_TX_DESC (128), for the
hwstamp and kdump Tx rings as well, and set tso_max_segs to
IONIC_MIN_TX_DESC - 1 so that every Tx ring can hold the largest TSO
skb. Larger GSO skbs are segmented in software. 127 segments still
covers a 64 KB skb at the 536 byte default MSS.

IONIC_MIN_TXRX_DESC now only applies to Rx, so rename it to
IONIC_MIN_RX_DESC.

Tested on an AMD Pensando NIC with GSO frames of about 1500 segments,
injected through a tap with a virtio-net header and redirected to the
ionic netdev with tc mirred: without this patch the Tx queue stalls and
the watchdog fires, and with it they are sent.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/all/20261112082753.6ee90fc8@kernel.org/
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h     |  3 ++-
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c |  4 ++--
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 10 ++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index db90e39a1442..4b3e244e6bbb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -16,7 +16,8 @@
 
 #define IONIC_MAX_TX_DESC		8192
 #define IONIC_MAX_RX_DESC		16384
-#define IONIC_MIN_TXRX_DESC		64
+#define IONIC_MIN_RX_DESC		64
+#define IONIC_MIN_TX_DESC		128
 #define IONIC_DEF_TXRX_DESC		1024
 #define IONIC_RX_FILL_THRESHOLD		16
 #define IONIC_RX_FILL_DIV		8
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 3518fbf5882d..24fd34b4cfcc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -708,10 +708,10 @@ static int ionic_set_ringparam(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	if (ring->tx_pending < IONIC_MIN_TXRX_DESC) {
+	if (ring->tx_pending < IONIC_MIN_TX_DESC) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
 				       "Tx descriptor count must be at least %d",
-				       IONIC_MIN_TXRX_DESC);
+				       IONIC_MIN_TX_DESC);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7f0da2b0defd..1f24c00334bd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -997,7 +997,7 @@ int ionic_lif_create_hwstamp_txq(struct ionic_lif *lif)
 
 	features = IONIC_Q_F_2X_CQ_DESC | IONIC_TXQ_F_HWSTAMP;
 
-	num_desc = IONIC_MIN_TXRX_DESC;
+	num_desc = IONIC_MIN_TX_DESC;
 	desc_sz = sizeof(struct ionic_txq_desc);
 	comp_sz = 2 * sizeof(struct ionic_txq_comp);
 
@@ -1062,7 +1062,7 @@ int ionic_lif_create_hwstamp_rxq(struct ionic_lif *lif)
 
 	features = IONIC_Q_F_2X_CQ_DESC | IONIC_RXQ_F_HWSTAMP;
 
-	num_desc = IONIC_MIN_TXRX_DESC;
+	num_desc = IONIC_MIN_RX_DESC;
 	desc_sz = sizeof(struct ionic_rxq_desc);
 	comp_sz = 2 * sizeof(struct ionic_rxq_comp);
 	sg_desc_sz = sizeof(struct ionic_rxq_sg_desc);
@@ -1642,6 +1642,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 	netdev->features |= netdev->hw_features;
 	netdev->vlan_features |= netdev->features & ~NETIF_F_VLAN_FEATURES;
 
+	netif_set_tso_max_segs(netdev, IONIC_MIN_TX_DESC - 1);
+
 	netdev->priv_flags |= IFF_UNICAST_FLT |
 			      IFF_LIVE_ADDR_CHANGE;
 
@@ -3284,8 +3286,8 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->index = 0;
 
 	if (is_kdump_kernel()) {
-		lif->ntxq_descs = IONIC_MIN_TXRX_DESC;
-		lif->nrxq_descs = IONIC_MIN_TXRX_DESC;
+		lif->ntxq_descs = IONIC_MIN_TX_DESC;
+		lif->nrxq_descs = IONIC_MIN_RX_DESC;
 	} else {
 		lif->ntxq_descs = IONIC_DEF_TXRX_DESC;
 		lif->nrxq_descs = IONIC_DEF_TXRX_DESC;

-- 
2.43.0

