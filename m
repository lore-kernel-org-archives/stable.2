Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4F313E15;
	Fri,  3 Jul 2026 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049597; cv=fail; b=p/jQvk5v7Cg8dDRvc1cn6AwCVhWpYAXOPRyqcGJhB01UuZyR3kamUE5c7Dn8E4KhBVjAmG8LLxIicSfY1JJymJJUi6enHQmQPgmx4T4uHHltbxLxDV+/XjYBG2pDXQde0UFxbC/mUPi4+SclMyzklg81tdL8AsDDlqFIqN4Wyag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049597; c=relaxed/simple;
	bh=hXb6a8656YLV5C8z4HWm4Nsofs5x1TF4dNvaf5PhVWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWIiaAuxGfHQJc56QZx2Rb/rQY0O5YqAhmkwvibGmyxuMF+sIgDFl6BGC9ZaL9C/eyoRDwD/6GPivTRHJK+xCN8/FKISj4LjmVgD6osDaqLezKSr3mbUwmTlAe5HnvsXHMa2SmQTmAKbu5DoCbvW91ShpObsAE2OaCHYCnGjCk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K4rKs8on; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K4rKs8on"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8pQRTA7ds0SWBwtnXCOVdRrcSf1LgZJDcd3z8yVu8Wsys+OseDvwtcVdQmOaGjWYfdM9A9TZU1aWvy+rs53iyhVj0M9SzNBBxO4Yx1RE8FJmo926D+xicX9bksVVpl3IH6h+WZWFTwzTTgXUzKuKNDyDN2LZzfZX7BTN+uePeOZSUsElkhjotPqC8W+TbHgNcKys3P3DkUxqDQ+Yti3J3lIJDLafCezBn9Um8+bcS3a6oYtH9ZoU37C29B6Zu6ErDWxi+ZA/vpQAw3sOgmcznUED3Nhnhg7byxQ5ApKdUmeE4DkOCwnmYEI36I8WdhX+eV96/VtJuokmQNke6Mzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dxuMY3gALzEYzVl3tBJO1zLY+wjgwwjyuz8lE/l4Q4=;
 b=HbA3au5aDQ8scmMd/YNyzW9ihKAGs7Q4GRcyPxAFWrsHaFrc18V/LNpObDc7yIq4XsL/yfP0pxH74twddGySHN7jDqnbAnAGHE9yL2AnSxc+ex/XgMhn1V4QjwIUWhtDnWiZMLxbus54gXRwtt2nmrpQ+8MVJrekq4Lmg5FY9xgB6a6H2Xiiccl7vUfSd/RC3fhUrA+ZYQMq5+ULSd7RCch3SkgxWUvzVlePFbnOTcr1solnm3dhwNhbbyh/jJjh6NlRFeML6Nq/GvjuSmGuVsCYv3661KhwTGNQW+NacGD13RySicrT2r8P7LHr7OAZCN6BmYolwLkKDumKUoFx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dxuMY3gALzEYzVl3tBJO1zLY+wjgwwjyuz8lE/l4Q4=;
 b=K4rKs8onQZ0QzoMD1wZexFtdaRnBDVb05JmFq9/LPmyonTv+IX7MdledTqXUVul+AyLP3F6ZXUzFHaCA3QvsI+1B00wu9jkoX9gXhwsYNK1B/4Uy1oIQDMC2O19+afIu9pmwtePkg/O68W0+EyvZUp7UTehq82dOVHEYEg/QWI4fpgXOgrajZ9rCI7k/DpRRTQ41I1tL26NSFOv0sBi58nawNMcCRdiQXWaVPLDiw0SWJxGvXXL1XI35dApFq3juLD2IYTLDDhMYTquVHLLeLa5UCX47PV6twRUe3YMYoqmT24pj5JLjnayBr0gCn6tLA/UV99LdkQDjnsIK2Nz4UQ==
Received: from IA4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::11)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 03:33:02 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::98) by IA4P220CA0011.outlook.office365.com
 (2603:10b6:208:558::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 03:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 03:33:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 20:32:49 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 20:32:48 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 20:32:46 -0700
Date: Thu, 2 Jul 2026 20:32:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, Mostafa Saleh
	<smostafa@google.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <akctXFSALBNfYWww@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
 <akUX3T3fIoN42sdM@google.com>
 <20260702144157.GM7481@nvidia.com>
 <aka7N6oLVq3CoBqn@nvidia.com>
 <20260702235004.GN7481@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702235004.GN7481@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: b108d771-4945-4269-d5e8-08ded8b3c92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|3023799007|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ICWik/Laiy4uMDgvG73YgyoIt1n4+dbqarwrpq7Zro0eynisEwVXui3OiEBze3mqLVZ6Bi/KaLC9eaEMT3vK9zy60HcPasCtriiDTWnpCkciMmeXqh9fLOzeh0RgJsKydnsyOlvYGJJFv414T1sfXyK/yS2f1m6biJm6eG7nCjyKRPqsWXtvVQEobmjNRVtbwZQ8UfLLM5gBnQmfITLZcgRfNNBiL8xAculrbRwiH5E5IDSYSfDTqROfC2c0k1u2lDm6nvxxzx2px7tnQ5LJycYxs9dDGuZcNyClIcmuH0RggiRuRlwV15y0SjzZFTkaL2aVppbznzfIPxwfhrDfkgQnQaPZbJDM5lj940UaRmuCwXMWKXtYkHlllHUL4+2rUIyD4clNlkIq6RqjZYJzPc+iIbIjJuB/3UeNkahPYd9NPRwR71j1pLRfeFdG7KB138qcX7lX91/aBj1yPjhGvj/moL5/TcMPWdPw8HdSEALkKUuUmHcpofYSRpoB3pkHe+Gn47I4OX1jEH/BufcY8s90DUg3+0iXf9toGv0Mdue/HLo1qbBERvniVHPvAyW+Ei+BRHF8ed25F6Bo79Yngaxg7hESwTT4WGh/ic2c/pJiRy8mvYQ45IWZ07uxwJ33/v5lV8hhYF2kGS7L0JBAD+8E4mekSsBCuW/ngrN05GUO7kSUd1gCtX/4W3PBSrNjDaEX44vrrj8wXKs5tT3+rw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(3023799007)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4RsEbRuAliww7B6JkmeEWD85YJ+Cw1Gg4odp7UUNd1kafcALfrw/xt4N7l0R1h99lEeRgkMl9iudZCuwsGiZWLWXFHZLEVrK3r8MNemAaa/fS9PzZolaQGFLnEov4nPf/WzXQYoLPeArq0o4YpSWg03F8o5HAUGzXRozLblBnX7tPmZNNu7Ii83ly5//yU/GRoOEZAVU5AuKhMMQWrBIVP/OFmKdpLcXPrWJmHQ6Mioqj+ICish+yiSyKTsXQ3eBdzpHXxWxO7+UVGcGMBeaT5twBjWOyUMvgkDHfMzKlxPjb4E3L5k4qnqFxwS5YiInPPJ1eA2yrvZ8TA0MzH7MWoy+xs6IBGWoGx1gK++F7/Ev9YTcDQA4v9l/VDyFUJo4jGGtKWYWDNnUozijX/ZrULEST2Autwn1uu5dlCez95w93qM+uyB/EOPPWuR+KwGx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:33:01.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b108d771-4945-4269-d5e8-08ded8b3c92b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017

On Thu, Jul 02, 2026 at 08:50:04PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2026 at 12:25:43PM -0700, Nicolin Chen wrote:
> > On Thu, Jul 02, 2026 at 11:41:57AM -0300, Jason Gunthorpe wrote:
> > > The VMIDs that are in-used by the adopted stream table have to be
> > > removed from the idr as well (and similarly for ASID if we don't have
> > > VMID HW support).
> > > 
> > > Then the VMIDs that may be dirtied by the prior kernel remain isolated
> > > and are never re-used by the new kernel. When the new kernel wants to
> > > do DMA it will replace the STE with a new, clean VMID, and there is no
> > > problem.
> > 
> > I see. I assume the reserved VMID for the kdump kernel will be a
> > clean VMID (!=0). That should guarantee different cache tags.
> 
> You will also have to change things to allocate the kernel global vmid
> from the IDR, it will usually be 0 but not for kdump. Then you have to
> find all the places where the 0 is implicitly placed and put in the
> actual value.

Hmm, I just realized that all the EL2 commands do not take VMID.

Looks like we have no choice but to scan through all the CDs for
the ASID too..

Nicolin
