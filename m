Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545D752F280;
	Wed, 14 Oct 2026 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985039; cv=fail; b=eZJ8wDJsSXDDdiUzhaVvEhqBD/cEvdf/udwLDzCNa/xzli12JZlVOkmSVk7IBZi7Iyv/jBbPqQ87MZ9rOSSZbziwO9oqny1d9GhD9gfz7iVsivkxstk4TvNyhLT1/r69USlTv007b5iaGFMshvNhro5PFx8AvmvD6JtDypCin98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985039; c=relaxed/simple;
	bh=mMpsqs2PIUGtwLsfA16U30yHp/A1p6CTRSrTJTpYVPo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/FFnoh1apIKk3zZEV5u+8SGmOyo383pPhNoPxbi1Q7hNG45vmrVizK69CocMGTTpaespZMuivzUtdAgIl2hFaknPmFnMCDqZgJ8Ku5h55oinydKBAb8oulDFikRYxc5Wj1FVu+EwHdbqaiIH1U9mf+IsrtMOJLkB7rMu5aCA8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OtGjSHtN; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OtGjSHtN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdL7vw0O1N0v/gUokF2poSvtv/DcpAVNELkLm206GUx1Z4mVaRnOw3g7uALF552CG8AQSmoFr6nyAmkvPYyfHnAPbBZof1riofiNMLZ/nNVEQj6CrQAz3qFQ0iT6MdWujo4UeN9J75P9wBVOu78uAI0ymO/cN9d1/3TgSKERzjzZO2ZtAfUNfyWsd4HXQACvMzcBSGpcMBk86ITSnaFCfdgufyC0MDkOyaR4sdpN8J3GTSxdnOSz32dZveqbq5Jcv7oZ3x9pfqaA9BK+eUEk/dCt77OiXFt1ICLgctUyBYfLbskR5vnoQTjVXetR+P9UhAjpcOHAapkbIGT6tF1fow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+a+PWTtd+qjVGAsXzykplSSB+2R1pmIY9KBdlvbFcLo=;
 b=QjBTf3cp8an2lk76+95Gx77qCOhJLqylE6kzK1ATnsxlynFjugB53go19VDeJhMMiHx0tKqoEdyjO4wO8jBWH4ZW1rccM7xeEC5VZRqlykKpwdaA/sqttFajDCvDn695PieTGuLhXn+OEpcwiu7kSfrN6o7YQ+WU4LuVgDoPtnYnLQyFBMBlPLcS16nJ+fbCZCaLs0lsm9ZU4Hh/KJCP3INx49F/3oh8DTuJQdJxnAaFYX9B2j66nzD373FvS4YEtbte0eIdUC4PWiP3I3Xbi3Jbi8f/AQeJX+1dfd5T6LWR+dRJK1UNIyCHroEyUs5kWLeJK+3dC+esWoDeN6nChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a+PWTtd+qjVGAsXzykplSSB+2R1pmIY9KBdlvbFcLo=;
 b=OtGjSHtN63hxvcX9RxLMcustH3diXGxKAdVv/jzbOBsNI7B5118o7SReraHeTsgDP+/IFN1UrbTxWRrltB4Je+y78BAaZRIu8OURijPxBuWqcN1ja1jSROoVP38ccxOqV5kxJB85JzP4PEsDMS2I8nabcbBxjffx/qqPr/dHn2XetP+cpOpBEaUrL9mae0TGasmUfdj8Rtky0hcf2VVeSepFdzzq7dAtIo6DUm0SAkeY7A9ZAHM71imurj9eK1qAOQOAa9gJiqb8XOryIqfQC3ZC6z0pfbxNnnJIXDidOm6uKsY0YMXxXXTvpWl6AF18NfvG9mWAwjyVpr/GL4z1eQ==
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by DS2PR12MB320397.namprd12.prod.outlook.com (2603:10b6:8:70d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 13:37:12 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::10) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 13:37:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 13:37:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 06:36:49 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 06:36:49 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] iommufd: Fix event queue release use-after-free
Date: Wed, 14 Oct 2026 06:36:32 -0700
Message-ID: <20261014133632.3440297-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|DS2PR12MB320397:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d28060-371e-4b8f-692a-08df29f840ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	vdoJVsU2LHlrpidzzqd8CZtc03O77CbhZIi8VWmEw+kLUVJIHxFuLcCiPpOa7Iy3Q9j+ip9e0gMAwgJMQKEzqXzLsy9Wdjtci/qTqTsDtfcUXOw8bNWchJdtmZvX2RWLvQU1ZSTOHuFTJV7CWEULFJyRcoGeUq++Uzuh6ulziSGBAwZU5Yi5tXbt2Df+338RM4bzyLEFP2ZxaP+o8zSqTvtzCvde6NWe+enH7bAGw0yZZxXQqiqIDMFdtrpX5HpYzajnfAS/xtWNFLogrnuBJ+pPsmzrxDnzO8oVUcytQbQXkictwVtHAyz8htGVEXeKdbmvZLsRBVMU84x1BbaJI70zywzJKGE8U6PzeNN4pdb7enf17RIQBL6s9GSS0SEh71UWDwq4eMRRLRk0MaA/eheJKqluresQhNbOCrVKCafbK7VG7JHgGI7qAzrM1YzoYRD3I+l1qOYUXDYRbLgK2j8kztfkJm2RQWmUg/rLiKPzirsSe7WH7i6/NLKGcww9BqEtMtFNf6u/7q1ydHDsyn4041Wis+4bt/MITfpzvmOI4JaRSDD4b30kAWWbDJfegoRHyhRyPEf/jDysfP0Jbob24XEep2NaMpBbz7YpZT593TuC0PTzrWOfwCs7G6SrrUFFNXFjFhDschSIK2qib1p9LrlGVju/WMXiQtrf9Bdrgh7HMIPDOqVi3h1uTSKiYxq8PH43fMcOTgbqNvhFUQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c7W9vvr/OomHedB+RuUdK0GX+sDkw8ScEJgZ1+5Gx21Ifs29iGwsgUd9BS37en456ku+2prbN14VJIfJety06DiMbRkjHzL1cj9Bh1JdUIfPVJXIi9yr0WYOiYcfO4G9eE9W+DQdsLEIzUXtMSgU0K3kxxiXYPLwVb+dDt3Y5t9V057qx67AOBKjXcrx8nK8UNfIGWD0mvrhp/DvjcY9m5UAtTXbXkzP0kq8+14/W7jlu624h6eYrb+RZt7DQ0EVTkZzvgSik0oBOZ9szyJCHRahE4Lo32udfy+pSp2oe9DneU/ICXnXapiPIue0VYcyttuCJvvKpGeYAcd3vvHWvoP6rgRE7DoCOTyco2gHB02sPhQUiskJpDq613p8asnsDz2Giz7/XHjIl35NR421+Iyp3cFQPKcRCocc33Uv3na4VEYrT9JF8elSSnsltHEY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:37:12.1852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d28060-371e-4b8f-692a-08df29f840ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB320397

iommufd_eventq_fops_release() drops the file's users reference before
reading eventq->ictx. Once that reference is dropped, IOMMU_DESTROY in
another thread can remove and free the event queue, so the later load
accesses freed memory.

Read ictx while the users reference still pins the event queue, then
drop the reference and put the saved context. The context reference
taken by iommufd_eventq_init() keeps ictx valid until the put. Fault and
vEVENTQ file descriptors share this release path.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Cc: stable@vger.kernel.org
Assisted-by: LLM, Specula
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/iommu/iommufd/eventq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 747dd5155121cbe..b8a54454dd17c76 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -396,9 +396,11 @@ static __poll_t iommufd_eventq_fops_poll(struct file *filep,
 static int iommufd_eventq_fops_release(struct inode *inode, struct file *filep)
 {
 	struct iommufd_eventq *eventq = filep->private_data;
+	/* eventq may be freed once the users reference is dropped. */
+	struct iommufd_ctx *ictx = eventq->ictx;
 
 	refcount_dec(&eventq->obj.users);
-	iommufd_ctx_put(eventq->ictx);
+	iommufd_ctx_put(ictx);
 	return 0;
 }
 

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0

