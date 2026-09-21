Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AE363097;
	Mon, 21 Sep 2026 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015878; cv=fail; b=GqsW9flkPF+xCx1HZIyJ5WMmNH0hSXGHjWDHJd77moqn2P7nxG21GciDgg34pRLhJCFLNWEZ/+BhDKBpqd1Xyq/HZu/9Rp9hLryCWNPF4XqPyGQPrq+3GB2JT55F+myh/eBYw8JDj1CM1y0RBuITj1vXM+xqLlSHdF67a59HAeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015878; c=relaxed/simple;
	bh=yL+axLeK+ak/IaJv/mINpbMYDpIGIqE/ettnjLxSOkA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfcNH/ZfPULeoJvKj0KFVqretscFbxp8e1YK3mxoxftrJY0JuCHuOYUI6DCKwwuwCjJkY8ok7NAj5pvwH9XwwyhCFKuSE3TWQsD8wFoNmbsc07Y+tadHEEfXKasGa0LVd+zcpGUGJaDcIRIj/EawV6B8W1QZZf9cNVWuDURRbPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XEtnQw/H; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XEtnQw/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxttydJnz5gztRzgX8CAnAR8/9CLbRcCQJjCy6NLYYbs8ZRA9sns65vaRkktMf+yez3HhrtE2EmuopUae1gHdFXPvaChsC/YxXCf5K51Ct37Q29mUa0Gy/DKiPAVcVppin0bsRaASy8zJZFvWBermdHJtD1RbT/OZUH/mqgKVm4awSYSua88QY1NM8QYp0/BUdHubtXk/ZIUhKWNL173a2kzLIAxEJ+5FJhMfRQxYTV5rL4hK2r+d+03zCOM0YnhG3S9AS4BQ9k5D5cHoFJ7+Kb0RswHx+60RhzpVoo26FNcWfCKQ9oB4R9sL5O02V+/a1EU/Aj2ScrudGubID1cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBNtvOgSHiOekCG7M9KpnxhG+lcqfmIAnCty8njQVrQ=;
 b=OvlGABg3jhT2m63nuFHZxBO7erCMpQWCfYgOrwYGxYsoB7+TE198zrECSvLJS+7JZBPIAwKC+mp8olQsZhR8M53ybNDMF3c4cfrP6eSdoG5RFRGkXgHUglgmAZoUF0GZnQn0OrQR4/feN0QMiJuCEQJd8CsoElXtNY2Gq+PMeRpIbXbtbAZdMv8atQtWGu6zOrZL6KQEqYbSKb+NUecAss60fRj4bqvE/dgD0wroG3SeamAsYcScuB3604Z1kKSDUZVyxOEm++MqUsJuLh8LHpKp16tT/KKXKrSHCL+bnB2e8xxyd7H9+Jpc3NrXPoKVEd0+5G6itWn8Qp1bIz5cww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=foxmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBNtvOgSHiOekCG7M9KpnxhG+lcqfmIAnCty8njQVrQ=;
 b=XEtnQw/H5b8EMWZQbwkYpr1dLEPxhCXzsCIkz397j65HhihygADSPkJh6Ln76OovZ9i6V3hKcKZg4Dds3Dg1oTSOceSHIlKEOWy4Ttp0ZfXyZxapdnfKgYK1NlHlNFIhUue06Wrv3lVrq01bouj/h93D1C1OzM/vEW9ljLDPLbBvnTmyCpn3ANchdrI7BIJYCkuGdWKhGOkDqdPKFy+Ist5kAG+ypbBGVniktDTwvaq6RuQzzS65axivipYZfZ8CtQ3Og2s7xVovMXvg3Ve07JhGJR3G9nB4+zHKsFUrFXQahEiTuiovIsYckiKsbGj48WqHqkL4zkyfj0tATkx15w==
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:37:49 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::9d) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Mon, 21
 Sep 2026 18:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:37:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 11:37:26 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 11:37:26 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 11:37:25 -0700
Date: Mon, 21 Sep 2026 11:37:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: zhoumin <teczm@foxmail.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<jgg@ziepe.ca>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Skip unlinked duplicate stream nodes
 on removal
Message-ID: <arF5ZGuNoa+yTCNj@nvidia.com>
References: <tencent_4392079B5C29406B923C037A7E66DD338005@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_4392079B5C29406B923C037A7E66DD338005@qq.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5d47f6-f69a-4dd4-e1ef-08df180f6f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|13003099007|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	DvDUfIdpiFvsAqtUQBnnNCrkwAfBFBSDal2qtiy6aIvzLTQdtujVrBbe7lZ9X8AcAFjh/4ZQYjptGq0YPRWNZ2/NhB3BUk+G60j6vuDfb2gY+vE8P0gvHmMYXwZUiYhmiSXe4IQTf6KvQLPlzCwNNJ0UDWmej6CxNhCBvma36wzwlT2gfEFUx4MqYOSVlc4iSQz7Rgl3Uehar7Jlgp4YhzV1YHwHYCGtlgDxg8YTcMDU07MoWYeX7DF5mJRmg3udJMQbVDztdC6HrMaAYuFF2hVDs0XpaeyFfUM0eB6dMrjCsx4jRRHTvOcZuFZoVq68XoxrSTHp5XyuGI16RkD93uPAwHr2U5f5uTjAOLCZg+MG9hdMMxYggJFL1MpRCFRtPathx6JiSnFoaTq29dE6kXTNuo8nnGA/hhgQw25ecknkIeeGhMHKvG66XYy0/i1qjXfc9pkC0i64zrRSoXTP95Kcl3R6XoTH6w3vehQ6KiXDvd/ZF1JiqzR3MCRAC7JjTIBS8kgGElH+bZShOU3oRLH4sU5w1NgeNlKmPvEjX7ROLvy33cnMCGwmt4GSl0Ic/A1iaNdnY+UMn0aXyedTf9RcykScoFlriyjAsLI1Ypsi3g8iOw1KBXx0TtqI5hFAQouV9cD37ENo8EcmKgwjM44MzlkMxD+2E3eolNln0cjpeYWD/yqok3xGqrBiVfEzru4EEzSIVA/9SGLHs6IUCw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(13003099007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DHkGo3g+bK8KF5YIzVrsU5MG+Jjrv5Mjcv8xQHtnNSy4efBO8jV8fs7CYkTRQcbtr0RVQwJ7gz3jn5+HL2Z2B0Qbxfjr4Y+bdYHkttSvT3LS5DGhE+xrmKvLkHkbIeRkApi7ix7uYjQLEEs1W5OPXWPVDw9Df+M2Qg0KyDwYlnJCFI4ebieZNBFnF4ocuVCwnqS805a0ohGhzyaUdiTlZ5HgZHvtvECULjd55JwAYceSOiwcAYG3fEGkm1m8YI8xyQbuUTRdEtDFt7Iq1a/G5/rVHfbcGVOCLHM/bnmePf5LpECh5uaWrFFp4lpYD2MtyUzXx7PIT/5aDQxZ02jqFjEpn1oOo8XGyMELJTZSNQHhE1/d1U+Ok3i2HC6bD3h1etVobQk0QEdqWKQOj3tJH2bSua2OWT8aNrX2ot/P8c844+nh8vxQx0+EV0fwpbYb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:37:48.4806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5d47f6-f69a-4dd4-e1ef-08df180f6f92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

On Mon, Sep 21, 2026 at 08:17:27PM +0800, zhoumin wrote:
> A master's firmware stream ID list can contain duplicates, for example
> for PCI devices behind an aliasing bridge. arm_smmu_insert_master()
> accepts these IDs when the existing stream belongs to the same master,
> but does not link the duplicate stream's rb_node into the SID tree.
> 
> Both arm_smmu_remove_master() and the insertion error path nevertheless
> call rb_erase() for every stream in their respective ranges. Erasing a
> zero-initialized, unlinked node can clear the tree root, losing SID to
> master mappings for other devices sharing the SMMU and leaving the tree
> inconsistent for subsequent operations.
> 
> Mark skipped duplicate nodes with RB_CLEAR_NODE() and skip them in both
> removal paths. Set the marker after sorting the stream array, since it
> contains the node's own address. Keep the stream array and num_streams
> unchanged to preserve existing STE, invalidation and single-stream
> feature checks.
> 
> Fixes: b00d24997a11 ("iommu/arm-smmu-v3: Fix iommu_device_probe bug due to duplicated stream ids") 

I submitted a similar fix a while ago:
https://lore.kernel.org/linux-iommu/9136477b9c737a50cecc38f2ee6704a01510169a.1783044582.git.nicolinc@nvidia.com/

I wonder if you really hit the issue or it's just a Sashiko finding?

Nicolin
