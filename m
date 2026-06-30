Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576037C92C;
	Tue, 30 Jun 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793212; cv=fail; b=tAwisEB3XS435EBT77HDXabtz+4IrLwiUPNCzv175wOTt2HZjN0+T6SIygBALun1hLbMps2mg7f3w2kFiFHC9LuWPiW7hujKOt2hdpJSVuZkwDVLBqa6+UZ6WnpzfsKy2BsfcF6/unq/613VNp6Cy44hQ2/ENGn7eM7y0Gdqv6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793212; c=relaxed/simple;
	bh=8611otBRIljU2bJjBmwZmRHsisP+1W7Y+Q+4jqWJHXE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIkK6Nn2Qhu5VgSRy/DWpm2Oz2Bk9rAMXWfL80u3+2r4E47PP5g/KLFhafBaglTEOkHiXFIJiqvNLu/I4N2EhN+2+c4gGn+FsRmdUSfXMNwvNjj78xpUvkBWDbZif9WNkxf9avdBPTs0KqXOOvjhSflpdX89uYDGCeNabHsUYSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brk+iPYT; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brk+iPYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IaogcSGhN5X22ejUBbxMrmVzGM1vypGtr469dFWzk3BvYBB+0OK2xjdw72thwwp0GeGZaP9D5radUqitzKephhiUwUx3eDgqlzK55IPPoqMJrPI8RkYTuWgF4z1E7Mlnzz8Jpge/KF5zNqRaxNvpU3pZMghVsbsayp0WgXveWSExl49UyiM4Utmzpr3Uvha6c2jAnosRcQO0KIZbRWxzzH3dq54dycwpPDMuZsr4F93RTzVAXhrWotKd6Xu88xNstBxp07F4csWAQ7qoiWMINalZOeYxhEHOnofnF9TxxXUIdECSv+cHt/dr7Hu0wIpU63LB8E1hTpTjGabs44OMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riMhrxbt0ittIBxBxekTOapOb0GL7vTrF7xKYpOd3+M=;
 b=fam2bMIRBh/SZ8rg7/nZCUdIGmBI85269tceSgHg8tbfdyxAJELs6dPpCnQBZ8BWnYRjPyiaizZi3ax0fzv533+oWqxNLtZQ66OvosyqFy8Xva0iRQC+IlgUO0MxN0oapEwGWRintzBuE6K78ly6y7XNJhnrnj1CJeT4TLy/EZMiuvn5ySxDtiGFvGQ5V+pnVVVM/b+CsV7Dcp9fo1t9Beo3V0Is+zdhNV9aY1afLtntXbmruLw/mpesX4QxNpQKAyAj5CGIGekvvwhcs+lvyDICTBEWeAMWuNxiab+WdGuGiuyAP4A11WGVJ8DduZov0CoZ+Ck3vg/oM/ugIS68eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riMhrxbt0ittIBxBxekTOapOb0GL7vTrF7xKYpOd3+M=;
 b=brk+iPYTMVRESYKOyAvhgH5+mGVVqfuaPzNdpMCguM81l7HvvBcD3BNnVZN/SEMORvT0dNkjSrsgmoP7A4//LWI0shiM6RkfG8QggjXl5PI/1JrSApPR5rr7met4Bw+IdhQ7YkygFhI81USyDnHB9wPcBa1jCMaCWK8UgagubyrpIEat04RvXGJq8ZXqAESP1R7SxqSLUE6nPplIYxAQPfN8HS0seiRheHbisI2BNkmTlkCWbocldtaarMRTKx0RTmVEeizzdiTK/9YCvNuexIeSLyorn2N6O2iQ4Py26paxe4P5zE+LIjQteuza6TuvLQjDTDHleWOO3VugESDurA==
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:20:07 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::48) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 04:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:20:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 21:19:50 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 21:19:49 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 21:19:48 -0700
Date: Mon, 29 Jun 2026 21:19:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<joro@8bytes.org>, <kees@kernel.org>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: Re: [PATCH rc v6 7/7] iommu/arm-smmu-v3: Detect
 ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Message-ID: <akND4nZbAzDLT9HM@nvidia.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <8f43bbe920466359465f2083cfd09a15ee8e5ff1.1779265413.git.nicolinc@nvidia.com>
 <akKf9S1TURJJq6em@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akKf9S1TURJJq6em@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2f0b87-689e-47b1-ac53-08ded65eddf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EqC5vdxN80Tv5B1QHO6wHZvgd3vswRlMbha9mMuASJvoE1lhthq+e6vOXg4bFgFoJQ10qkidxeuQ4glufCa8Vq182+aCDeoVg9XEISAC5o769ihtiiOMMzs8dIX5uZXpIiX0Urtg3OLgp+nQA203hM8n4H3CN7TCINRxoG33SlmOCWpMz5D+gvxxWwKhbsWKF+eQKsXs6PD2u1sGAWjBtoGSr/jmEbx3v4xWa+wVmRwz0R1ifJ3lHIl49Y50fsBWGfT7BPuivd+rKrkBPFZoaULO/Sliy3KlXnPnyk9P7cukwd1gMvkGQsvMwszONgzb3JCOaWfwom4DB4NXYY1uAIuAdHuZtpFTDGj+GPrE+xiwS1aOoBjfY/MCaw2oJH/QTXzGG+f/cue45KLQRPUkjglPC6MuaQtOOIIWHHLmZN3j97vUnWqTRhK5XJLhIvBTfHfpC8FRNlRBMHAyvMk298kc29E3s8obELlDvp0cMFcuXSvizUYQarAIoDZCHzXW+Z0F9MR0uzKAqe6JsYOAknfnMTFgsX9+3PvwEvN/2g6XZxEoLSHxAb2yix3sMfNGOSFtbRE0YKM5UabnfaIzxog9SHKsI06SVmW1ytPIdZYl9DmzZct/rLnYl5TlkPTKxy5JnELQRI675xyOcRGL472ghsYoAaVkthNZpBwUqCNsxTdvEor9wjqnJPVpaxA4pbf3EqmIgrV2lp1Rayp0/g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qtHGnqMA8dl0TaTUXYb2L8qKJ0Cma5rRKLeCQlGxrLgtK507PYAIhQma/CMiLQ7DNgEQPVmVbkBCoc7bjefjRq5fMHaEB+WkFhlA5iePjzyolKpWRh9zsYed56Yb5BBK7DoEJ0ysBfgCe84EAcPa+PnP9vM+e5UW9EFks+nmxGEFahD6DHgbzvW12oG2BuNUbgUpfW+iaZVE2iPdJa4PJgK7KPuZGgxhmyh73t/eqszsxl+d6/cJkPlqjD8GHi8gQd+n/Ns+7n0ynVi4PI4AMXJ6n0Ryf+V1PVGAItzn19oKAlitFc7kyuDXlKHorDGp0GjDWyqM5Dra1HMwzlDFw1PTdcSjmtm9H65R84w3pbQ9VY0SRsm0PBlghWdIWydUpAU4a9tmJwBRDsNmDnHXBbiWjtefTlXHmu0jxyoQGi0NCYDQ5L7oTs869tgw1+ub
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:20:07.0172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2f0b87-689e-47b1-ac53-08ded65eddf7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812

On Mon, Jun 29, 2026 at 04:40:21PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 10:03:24AM -0700, Nicolin Chen wrote:
> > +static void arm_smmu_device_hw_probe_kdump(struct arm_smmu_device *smmu)
> > +{
> > +	u32 gerror, gerrorn, active;
> > +
> > +	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
> > +	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
> > +		return;
> > +
> > +	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
> > +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
> > +		dev_warn(smmu->dev,
> > +			 "kdump: non-coherent SMMU unsupported; reset to block all DMAs\n");
> > +		return;
> > +	}
> 
> We seem to be checking it here right at the beginning, let's remove the
> redundant checks downstream?

Seems there is one redundancy. I can drop them.

Thanks
Nicolin
