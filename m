Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442386;
	b=qLfA+3XA+2+1x7ZY7X85Y4sxblE/BjrADVKItyTkkpBJEl7KyJjbguidBy6lfSVkhtVz
	 tGBvtQcEBTdxCAH8oyC6ps1l7MoLL0SCCtvfz4n9UrrnmBlZ32qSVx+qjs6qCevbjJCG7
	 rLAY0dJl3ns2k5GGSccbdmGoV1qy1PWCadm9aBwrpUKtzROo4vJECNggNdt4kpDMkDq8q
	 ZLRQFh7eLFF88DwNlyrlwvm2FjPFF3lnK9h+SP3Q8QievxwYKXXqgpYgbCTmuy8o4lAk1
	 HpD8Cq2hNMYdRlia1WD306F7keU8PZI+ddneOpY9D3r1kZv2RprLon1qBZSV5l7cBrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442386;
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
	bh=ZUq+yen2QWRDQ7wCuF9j2jDJMA4xhWSHOGV43BSjOA4=;
	b=bKDJU5F3X1k8ZJDn7F2Zm8eNAS3MK30mH2CZ7J36h7TUvsn+M0gq0x7MNHD9jfFAetQF
	 v+Z8CvrXeUFY7kNAEJz8mqlN1KK3K74tqJJJfYt5R5PoTKX0EsXGgCqO5fAJH1x9KedMk
	 NKM0Q45ExtNAUwE5fdkll7iv+R2M3lrcfBHnZkO3ifJIhEueqbPOgSOO00jOuDYvrD1Jk
	 l86lP2yQmU5QjwzZlPfIwSdFP1meK6B3UgvXYn4U/YymbCh3q0hF2GtRMX65IH0sIsD4k
	 JI07ynAVNKPxoUMbLG5b2O8eHSago5zH0AWfXyYOzFZ259gh/NIC1EGXkhtBMcmmNDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hjh1gw2p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.31
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F9606A332;
	Mon, 23 Nov 2026 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2F9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hjh1gw2p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGmdjBt52U+wEaO9zxkIpCOYv5UYMSjI4mQFOhK8nQLnc6fyOaiGChORXnWOyImaAgjHfYW6GUI5wteDHfsyBdrRpPFuO8rVS5U2GOnI9YKYFtwEbfPgKmf5wFAReU3yJtU6vs0CpooH8MKiWOkSobxpgKXhpLmeB9NId5XuVn2XtKAdUNDf0F6weNO1CWrNsznl0l8gYn3+6ticnhMbYaUBVObSgm5ExI2L4OuQRJDObIz8p8FPTToPjXR2ilq3G0+Pqdd7cK+lIxaRp7t3kbQ9cKNt3KuKVUddwkqk47gvcg4t72mq69NkM2s7OP2QKhZiZNRRkwN47pEWoRddzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUq+yen2QWRDQ7wCuF9j2jDJMA4xhWSHOGV43BSjOA4=;
 b=IxO9adxpc1Lloi3xR4W4zRrVAqCKRvfXd6TFxCFvej9jqv8RjzgYxkJIPmMyhKdM0KHLoqrmPlT3IGIjLZ8Id55jdwidnsqxX2ERNKbqCsBGPGK35n+JKbevTeVckFMu/UHF5uejgfQpETjd0Fv6xEaYfbC4RQ0iWJcWntHLPilV4Qq2sYo/jJAsHSIdhf7o6n4QdotlAw/BCLU2dM7DTSG/WbuVUSzGXxBnXod1JYRBFI0RjpJ4qkG768MSzdHSultG6dJeOn3HqwOAlO31JMFFpNenzvhqNXoXtQYxnoEOjI0Vlk4yzzqceZye/XeztP+cPhCOzyPHY7Ap+vL3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUq+yen2QWRDQ7wCuF9j2jDJMA4xhWSHOGV43BSjOA4=;
 b=hjh1gw2pUQqLBz98YS8UXYptO+Q5lgC4MqINfMhziLlK7sNwH05BQilCfaqozyX/0oeIT2ACPKWbdaoUQP1OF0sWHFD9Fab/AxWuZ80PDL4JDIJMhqazXWjRrjdJ7ONIqRwN3KNOxRSoiKhZ7Uae6+VuDuUojoj+MScPH5j1Th3mFha1/bopDoFW8tCezkLD0LDPKMmpBMDv10pRCGrXYZvA3yiHDlk7CJVua64lfM7hMD9LZ2UhTOAJ2lAQnhNkm99QbtWe4Yyo4Rf6anT34VotEbrg3FHq188CeiMSp6UkAgsw7ixLdjASG4quh/gg1O6drxsz+LaWYgdcRSJJMQ==
Received: from CH0PR03CA0311.namprd03.prod.outlook.com (2603:10b6:610:118::13)
 by PH7PR12MB8594.namprd12.prod.outlook.com (2603:10b6:510:1b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:38 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::47) by CH0PR03CA0311.outlook.office365.com
 (2603:10b6:610:118::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 13:59:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 13:59:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 05:59:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 05:59:16 -0800
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.2562.57 via Frontend Transport; Mon, 23 Nov
 2026 05:59:14 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Eugenio Perez Martin
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/3] vdpa/mlx5: Fix error cleanup when VQ setup fails in .dev_add
Date: Mon, 23 Nov 2026 15:56:44 +0200
Message-ID: <20261123135646.3962652-3-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH7PR12MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: 4396de07-00ab-4638-b61a-08df496a0099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|261009223027099003|10067099003|18002099003|22082099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	G3u1+nCH4+0jhdRtxFTZQsd28j7GwFhvN6WjdMlQr1SWV7UozAcTryjFvbkod0YY9S4leeRHqZhFSNK3Zck5g2ur1pX9MjQ//6j0HEdU03Cj3zQolh+u/sgt/j3vNzzNx0lXrfr+zTljBMpTQeROQwuL5tHEu6XKe8rgj5Df6XDZ224UjuG1bk9EY1UZwOkMoBJLq0Tdx1ppYIWI4xBAzHjpauIGMuShIhkBRFNeoqq2ZMeQUTjwEfBVYh6T4WGLbnd7C6Rp1uqh6Xq1LZo+XBL5FsixumTmLvnaAnKBW0Apd0cFCb5MbLxbaDJFbgLKoYDogWFJQik3HxWNE4xudNxRMYQjwK4GpfehOUJxBJAJal4C3maS8OM0j0q7m7x79WAxHJ/81rZEitYlPbDniW1c2SnYar//0nABqDUoh/jhgTMdbwLj5DxozZb3MKjFevGP/uuJl5yIheImA+uYpe/t7n/zaNrFJFyDbsCkb9LnX5hEtTYnNDlfSiuSkTrz5vWLsMhQcQgGZeipvNGiYL7xkffcJUCv0FH1tgM5Kp/8JjDOqH/sUS7EX6AtcRAK535GRiG+MdvK7a3JRw1kucTJ+8ugRAw9/sTdc3Ec1frblQ0uB5cWbwV1gv1KT8XKOKmwiU6HOs3TCUr13ZMqIROG7x4yAdzxNhFbk10Y5YaScTj/GluG8tFYADShahFpVI6AKIC+dYwhl2IoluIXzA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(261009223027099003)(10067099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sHYvaJdMRRQhUPFYXTsh15TdEHulNv6MrOodFpErv/IENpfCxKuoJo267uttXb0YaUCTBhLS6i1SGE9zVDVxPgND/QIW+K7a+k1aB+0KdnKlGSXRuaqcW3O3nOU0AMQBhhxNnN9swtBM632EIt7zWkjrXJM0jX5YNh+051J8WGk2TAINc+ZPYulzGZm8BLUhNErA9sECG5hLJLgTdu/65pzeIt6KOoSaa6KIAjXQ+U7UwC7p9OopjNMdXotn0Zr37ac9UbfA8YAufVd1bErbqWPPReY9aqhvRGMzJyVelVFjshqvr67h4vnHP/11W4qznlqxDRArTfn2jmqHXiooQBCBgQT2nUVJgKkxxN9SlBrHx0k4Yvj2zdCrc4QgSNAGqlCSm/1jBp0MitTmyMOnCmpeNc40bnxnR673pWyAizcT4S9CPHV7IXgOTbfbz78H
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:33.4164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4396de07-00ab-4638-b61a-08df496a0099
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8594

When setup_vq_resources() fails in mlx5_vdpa_dev_add(), e.g. because the
firmware rejects the provisioned features (HOST_TSO4/6 without CSUM),
the error path unregisters the vdpa device first and then keeps using
it:

- _vdpa_unregister_device() drops the last reference to the device, so
  mlx5_vdpa_free() runs and ndev is freed.
- destroy_workqueue(mvdev->wq) then reads the freed ndev.
- put_device() on the freed device underflows the refcount:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
  Call Trace:
   mlx5_vdpa_dev_add+0x3e0/0x760 [mlx5_vdpa]
   vdpa_nl_cmd_dev_add_set_doit+0x362/0x440 [vdpa]
   ...

- mgtdev->ndev is left pointing to the freed ndev, so every following
  "vdpa dev add" on this management device fails with -ENOSPC.

mlx5_vdpa_dev_del() already does the cleanup properly so use that. Just
make sure that an extra reference is taken during the call to avoid
_vdpa_unregister_device() from freeing the device under us.

Fixes: ffb1aae43ed5 ("vdpa/mlx5: Pre-create hardware VQs at vdpa .dev_add time")
Cc: stable@vger.kernel.org
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 6830a80e8543..7a39b0bbbee3 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -161,6 +161,8 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
 static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq);
+static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev,
+			      struct vdpa_device *dev);
 
 static bool mlx5_vdpa_debug;
 
@@ -4043,7 +4045,10 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	return 0;
 
 err_setup_vq_res:
-	_vdpa_unregister_device(&mvdev->vdev);
+	get_device(&mvdev->vdev.dev);
+	mlx5_vdpa_dev_del(&mgtdev->mgtdev, &mvdev->vdev);
+	put_device(&mvdev->vdev.dev);
+	return err;
 err_reg:
 	destroy_workqueue(mvdev->wq);
 err_alloc:
-- 
2.54.0

