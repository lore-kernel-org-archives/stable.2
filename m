Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442385;
	b=qju3JHlFvrCJumIYYAUtFbB3F9cyh2thzHnT06WzpVL4apSnMWooQNrRraGEvXiHCQck
	 tdB28f0u8F/BN6ncIf1cle4g5j/g+rryfKlGbb+iU5zw+FMkFoja0A5uIsFBzfnnz64z6
	 xqfVDsV0/fv209Ynvh13HtvQSFh9CCa7E9KToxxmOalP/c85GJku715RzwynKemIdcw0B
	 nTlAhE04u9Bh8K5/OFzYsXLIWPOBeexx2VNRTDESwdgyNCW/SuwLJDqLwA28P83YQeiJd
	 gYG6alKPKhgnjuT6L0McvnV8dGUqxoSii+7KOAsny/1jJH6/88E+03C8vNwIAgP2x5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442385;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
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
	bh=BvZzfU/GIpktrPjeTcjwDUmLGy4zaYEeohdnHyo9qRg=;
	b=n1dG1xZb6QiXb+tThYC0SnIpARlw/Efb9HgEaF7ABcTjrdN8+Sny2vrJNX7nUFZbjm/0
	 1NMdBfX6FHIXIHEpbKkzXlPZ2pXsRXFQY/GMoMB7ELzV1UZQOVgwMdC/dwzA4jBSmHsD+
	 5/3MAWUVa0wpSFA05xaQemA3GnCsQGmWKJX8GYGCGXdEb2RWOSu2mv/i3hsjQxzPSt8cD
	 d+tb9aSwDw/5XZfD2Cff3Jrg8Cxv9ab1XZ68iMCvN9ql6TDKzCdfEn0pfMGU5SefZyf2a
	 uuOzGhGDPN7KYom+n/ciWTGtVq9kiuXRozdA6XtJ2oLvDf4+JXh7Quc2Wy1+8z/Qmlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CplA196z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.23
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A778F606A31A;
	Mon, 23 Nov 2026 13:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A778F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CplA196z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmZVT8FsbvigKpdqTQhG4IppQGoN2Y7WSZyXocmf4TnRvOX58Bo2GWXV8vZXToY2izM3tYvmtICMEN+m8MIrDh9KAl0ki4FE6QRIFLjA5qCJImrrtyIx+kRjZ+kOujzcinygabeHnLm3EiGqOB3Op/0PF3Ou+efXnpCenOqVzeY3iea2ZPA/qkCHQPypzZ6tVwqUfTZzEvBtFPbJ2LutJ1CnE+QvmN28VnrmvzAvUFMaZcivtfuLeJd5mKT8sMuArK4nqtWg9DdZHjOIwdTWyvxp25FVeTBGOqB1g9YAscPE6iD8czJ9L+IVjY2+isYZEUqbaU8SYZMaVCpfE6igUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvZzfU/GIpktrPjeTcjwDUmLGy4zaYEeohdnHyo9qRg=;
 b=Zzy+jukIw4n2oiG01zEj99X2bMD0qcdHt6zoyCo9nWDGw8PZ5TPPb5/3OxXtlsCZl6BTfZ6J/U/zVUCPI+GMcq6hdO9h2ONJw2oLWoxIZkiwwh1bS3bzrZ3QcY1X4lo7s+3+6hWMWd6knqZmdImQzKdlSvgtbDfVqMSz7DJJkBsGFNwuKRyMQjaNBb0BjjvUqO00fohG/OKKzn+diZIXXxJWWs0rJVNFRG7JUDINVVK3FDwZz3bL1PCDkvYZEQVUzegLC/lm59D3MFOtQ8Fnyxzh3/Ta/gjO6PNESibzhSYgVXZLbrLHgPyrqQpZYkt+zwGHeO8X3og575/E+ezr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvZzfU/GIpktrPjeTcjwDUmLGy4zaYEeohdnHyo9qRg=;
 b=CplA196zYh14m6kgNSCvxQ3HTWgfmgu5bRCA+1j6wLtH048akSJ8TLv6eqYCaltxliErOPCL7Db6JqzBPrkBiQuvYKRgRBTGZ+loegTJ8MAJol+uL80BsDp4lkyeHKOBpOEN4WFPMoGH+cN8JhEM9Po8CSU1tSvywLC+wOBVFA5mxCk4vX21phRQ6nh21td84zPOKndeSt6h5qks6+C3eoM1AWafeGokiKPtlTBclotg6P9/aki0Z8rc1j/tSfKczFXGdkdVQQ05z7sHK6p6bHNz3Gze9iwEP248tLF337TF6+eAJ1IRY/olNqXPFeOK9/XB3GK7ly4gvAe99ETssg==
Received: from SJ2P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::13)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:35 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:5db:cafe::9e) by SJ2P221CA0009.outlook.office365.com
 (2603:10b6:a03:5db::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:59:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 13:59:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 05:59:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:59:21 -0800
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.57 via Frontend Transport; Mon, 23 Nov
 2026 05:59:19 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/3] vdpa/mlx5: Increase the maximum virtqueue size
Date: Mon, 23 Nov 2026 15:56:45 +0200
Message-ID: <20261123135646.3962652-4-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123135646.3962652-2-dtatulea@nvidia.com>
References: <20261123135646.3962652-2-dtatulea@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a6cfcb-3963-400a-39b4-08df496a01e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|261009223027099003|22082099003|18002099003|261021121427099003|261022105027099003|261021123027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UAdkb09B7fGtfCbShUZFX8qZoiiMgwR0lNHxRLHVLQ6AD23PVu9vin9EddJ/My3KCDl9MfjdhLPkuZdXcx/eBjDE1JsqYxFnH10WNjpwKFMKohGLU1oRMBb7yRDQDKf5c6e0/CeuTV+dxCn76eyZUgGxUQDFdKDM8X/Nr1zfJBLSM80E7nL47IF4hPRKoMgmn0lq6qefuo4hCJopqqtAfpuLrBaskgz/JSBVPhmE8tT0ZlNn7E4jwZBmQ6MPqTule7DrYTW0t5Jv0IOibvj0SltYlrklpKPWXxUNo/WO9lW388zM6EXbtDLDUDFE2UfHWIWImfxyLaHFKr+hYP/XYj4P4v3RMVZ0zBqd4QTc4V4RWBIK79VLx36fOIoo8+M7XCUmUHEACtN1wj/RWk/Pk2zme3if/lhqmv6qeDciYfr17AoGXnREP3RYgxH8UdNI7t9N58yKF0xSg7oCBRaHxbFIKFuujD16rWflGjzaq4xVCWEuMdKqkSigU21zxhWRafH1SlTlk+ro2oXko3j908E/YKTrcz+SwZmNmNFljiucp6j+Dj2kTUkJl776vo24WyquyLo76XGtq/70stP3HnIeM5SsO02KFNnssExmInAdMnJC/OxbYI42DDpgfYvKRVh2+JfdSZHgB1GF8w7ce8mkoZCqof2RMn1o+Qg6q4ThFKMzXxT9E5KzM1Bbgb0k5Duns/ZCYhJRtrJuvolpQg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(261009223027099003)(22082099003)(18002099003)(261021121427099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ezh0H/6rhCPbOUnxfO6MyX0ZfJrkB1YhgFCPVlzdfWFyfWzvW71foZMIBKVLKReSviqyYvnnCAUmj4DjtuwQ64nYL1Yo5NqS7SEMbWvXs8IgdqlYcOKLrqSrFeetBRqkGt3vEMquKV12Tv+X3i0pldZy2EG5wbQE4+3w837JdLiYNmgNSemmFqmZn4zhO0b5tPRnVCSO8ZrvugGZEv13Z0NpGEdL7Klw0VCLoxmupwHXRFcsbzCRCY73KQO/HlaS6Qom6qt/4rFOcn/6VUeVPi5BsGYVz6ktuim/NzSsKxOKiiwhQaPofdWjeh/tH4gjDoP/vd0RD41O0/JXyWVjr9guBjdqTt78pbxYccQvMwbcZn3pHZSvsHsqFpd6wzXzmh4l2VR9DN/Rgwm1WttnWBJr/WZ2jZwudmvfdOThgo/wuZmfZe9th1luoin1CGv9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:35.6537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a6cfcb-3963-400a-39b4-08df496a01e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521

mlx5_vdpa has always advertised a maximum virtqueue size of 256 through
.get_vq_num_max(), while accepting any queue size in .set_vq_num(). The
hardware handles larger rings just fine and users have been running with
1024-entry queues (e.g. QEMU's virtio-net rx_queue_size/tx_queue_size)
since the driver was introduced.

The commit in the fixes tag vhost-vdpa enforces the advertised maximum
on VHOST_SET_VRING_NUM, so configuring a 1024-entry queue fails with
-EINVAL.

Advertise 1024 which is the max that qemu uses today. The device itself
supports more but doesn't advertise it in any way.

The Fixes tag points at the vhost-vdpa commit rather than at the driver
because that is where the mismatch became user visible. It also keeps
this change out of trees without the vhost enforcement, where virtio-vdpa
would otherwise start creating 1024-entry rings instead of 256.

Fixes: ccb1dc7c527f ("vhost/vdpa: reject VRING_NUM larger than device max")
Cc: stable@vger.kernel.org
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 7a39b0bbbee3..f1c5f72032a3 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2965,7 +2965,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callba
 	ndev->config_cb = *cb;
 }
 
-#define MLX5_VDPA_MAX_VQ_ENTRIES 256
+#define MLX5_VDPA_MAX_VQ_ENTRIES 1024
 static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
 {
 	return MLX5_VDPA_MAX_VQ_ENTRIES;
-- 
2.54.0

