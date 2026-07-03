Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5930C14C;
	Fri,  3 Jul 2026 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102857; cv=fail; b=cLCf/QQX21Jybf++s0tAhntM7FXzVBC3imwMK2XhzgkcEmKPwm4r1v7yEjwaxN5d0MRMtalB8bn5AOxNdsoiVnZRNETbun0ddcOcB0RkBRqpjkTElD8YJW/XazRvi6yp8gKeCTBKi7lDmfdkGxaPwspGCdjc6qMU0DPnIY5ab64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102857; c=relaxed/simple;
	bh=Xhfx31S8oPe21vTLzjS1pdCyDhdXAmjM1z928SsV6Pk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvDZ0SW7AgNnIK1ZaHKJUe1VpimyxZS9VUa1uM/p3euo4XGnrUzR3urwjkhe468H9IHwuH+4KC9LNz0sxewL16ALjX0HmvFY8CQcjHgx5T9cEzhsK+pseZYUJlnTVt00sAcnp382mmXh3vTTwMRQu7H8FmdQpwX1N3GTxihoPLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FSjD6aN1; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FSjD6aN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnKv9K4VUcyGbiunt8mhvPJs9oa5JZreKIRucuN4bpkMI45nbF3gvjVxUZ1UlEEuII+z1JrhWoy71BHKOMKlSjjojPBL1bJ0+P8S0zd5yiZ0AGJiM6UyZNq3AtwGJzDCn66EwJYk4oA2fbMDIguWHd9F4SFlW5LxcU/wifdagqWqriCpY/2dkKalrEOl8ktbQwX7KbVlsQgDuTmocSxfqNVorodwk3jw5XHJpcAm0bNIXuUwbpJY8jZC508bpudXVAzJm50pqUt0sBfBuG3KphkAePDXCkxjjp/EVGx0ve3gTVi6ZPZUt+qJco4k4N90o5y/0uUadTJMQkcILP0APA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htvTdVqBj5sQU58rbr9YMzjmDc7fYbUXWR1FudTikW4=;
 b=nx1J4XAYOCkhunezxhQRr0DBB5mjzpBVAkBwfukjZj1nx2I03k7Rcz2pg7JERR7iYGLsAUYxWsMQOXBleIQDPKoaLVnGmDDmhKaFm3ghVzHTg8lIDUjSSWQK39UOVNPbnVqDDTGOvN3ErrllLg7LHwLYq4jXrSv2IKni8S2RoAfTHg3/6VV2LTG96TjfyO2+6skUnUWwsotL/wzc7uIjr5+r9fQ2Wb/iLUizu/Ww8kJ6AfUoszzjLXC9r2DM5lBCISkgdcIsyIj+yLPetofCDmwmH+tpInAZrLkzHgTfg6ooIm/+1UkVhRI1iApo4JSZOJ6oy2kXWFWHaUEciABzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htvTdVqBj5sQU58rbr9YMzjmDc7fYbUXWR1FudTikW4=;
 b=FSjD6aN1KBuox7ZkS+i240aTnBUlxBIGk6mNnoSTU9SMCE5ocvngkqzv3lzwIBbT492k7Iay2/9p2vSD/B+uco9mUYWxPy6MKRfKKjdRk6ZM93EBnz8hV66IMmX8YADfLL4ONWKS9uY2U/BGJVjTumbjgwxBNVw74AEVmKOMGh2EizkCdmkrwd8c3cg3HnBE4nNQqleceGVpypK6wjd0SxlZ8FSGXXMKZIytBTDXNmINd+g8pr8QICsZte0bFDXOnwW3Zf8LkFfS69N+C4FhyKwGIKIxtmBtUV7pEnrPhuHCr6iBZoqdn6ZV+vbCflryKmZCQzFGqmuBDB2vtvK6fw==
Received: from SJ0PR05CA0124.namprd05.prod.outlook.com (2603:10b6:a03:33d::9)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 18:20:48 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::37) by SJ0PR05CA0124.outlook.office365.com
 (2603:10b6:a03:33d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 18:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 18:20:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 11:20:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Jul
 2026 11:20:36 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 3 Jul 2026 11:20:34 -0700
Date: Fri, 3 Jul 2026 11:20:34 -0700
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
Message-ID: <akf9cjLaBLn82lKP@nvidia.com>
References: <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
 <akUX3T3fIoN42sdM@google.com>
 <20260702144157.GM7481@nvidia.com>
 <aka7N6oLVq3CoBqn@nvidia.com>
 <20260702235004.GN7481@nvidia.com>
 <akctXFSALBNfYWww@nvidia.com>
 <20260703115716.GO7481@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260703115716.GO7481@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 160d175f-3266-4d04-1c7f-08ded92fce51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|376014|7416014|36860700016|3023799007|56012099006|4143699003|18002099003|6133799003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	EICIZ9+QrRsgb+htE3aFsE4+jbxIl9bMfbso4cN20sGQQoJMwUWs/K5LUBHGKcTzX0oUSTyKRmmLfTLqZmJ+FD4/JQw3CI7HjgBbuBNepfzkx29B+/i1Yo96DZRzw4aTuDvyUgJTtZgaGgXTEvJuXPM20aS8GH74QhiYFSydcTxEviAtaEpUCMMnpNicauhhIuYVuXp8Osi6/NQtKHmr7+BXzKJ6PwjYtcpz5wZxDkWKERdW+9DhpgyzFXVclHl2lP4OiPY0hLlMLr4oybYrwy8hviQfqQ3npJye8bmvd9O65//w0+PJhu4f+XuTM5k+OFMwUqwizZYRpNhEUWTiHo/QR3X1VyQmph3nM9mSFVlHx+iQ9TXlJZtKSTOr0GeFoICzKiCbw0XWpnh/ocEFKS/aeeOIYUyN4LJiOf28VmLa8EnbM8rBjjI0shTp10/wyNy0xGK/uG+4zUcLdQXpr50+AalbdE1Dul0+VZZng/WTLycylZbgj4ueTLzqByrjf5w+VsTjH5nowYeVgej/kvfawyZErPTdbXsYulzhrhla61+UjVLG4409rqau2HieeQ97bzkMf31a42L3wkybMIkEJ/X8hkWj4yDWCpjNo8ygYoGnSEm3sx1YQuiLgDLA8YuWiXy/5C4hS/PMVGJ8SLR+Ajx5fz6Wh47eUhCgduVuHlmWNArC+v6oiuag7cVgk24/VvRRxMr3poBj2kbm+A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(7416014)(36860700016)(3023799007)(56012099006)(4143699003)(18002099003)(6133799003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xBu/ML5n9FPijZYfFZgwX24b1VzeO4zQbq4Oe5Rp5/a8ptwkAUeu29XstXnGJiU3d9KF6/yTi63RDB9UfD3ig1AmYRlZsQiXKE0kZi0O90+o/RWJQzK6tMYutiJWf94YtezoF/NlmrMQJBocnqRsqlTYQkqnu3laVtrpztC3dKvy+EVpuaqiSNbDP0ZbRArSHM3ogO1dCn0Ml9Dg0Q+idA5dKmwT/JF64N5fGmf5+a/LCdBZI92wIh3sHMNOW/8Guq+QG8mf4Fwwon8t22A5m7FwWLHi6uLThCVn1ObITj8aXM4+6XpISNYd7j02oS/JSRw8Z9i4Upc2gvX3QQsb4+9Az3S/wRsX6DtjSzeWCCuBex3DpGRu9n5Da92beP4NEoQlMz1O8eCD/qYFc4TaZHBwoH1neEIHduCdTjrZkzCe1aOvN9x+NEgJiLHYpdpt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 18:20:48.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 160d175f-3266-4d04-1c7f-08ded92fce51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

On Fri, Jul 03, 2026 at 08:57:16AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2026 at 08:32:44PM -0700, Nicolin Chen wrote:
> > On Thu, Jul 02, 2026 at 08:50:04PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 02, 2026 at 12:25:43PM -0700, Nicolin Chen wrote:
> > > > On Thu, Jul 02, 2026 at 11:41:57AM -0300, Jason Gunthorpe wrote:
> > > > > The VMIDs that are in-used by the adopted stream table have to be
> > > > > removed from the idr as well (and similarly for ASID if we don't have
> > > > > VMID HW support).
> > > > > 
> > > > > Then the VMIDs that may be dirtied by the prior kernel remain isolated
> > > > > and are never re-used by the new kernel. When the new kernel wants to
> > > > > do DMA it will replace the STE with a new, clean VMID, and there is no
> > > > > problem.
> > > > 
> > > > I see. I assume the reserved VMID for the kdump kernel will be a
> > > > clean VMID (!=0). That should guarantee different cache tags.
> > > 
> > > You will also have to change things to allocate the kernel global vmid
> > > from the IDR, it will usually be 0 but not for kdump. Then you have to
> > > find all the places where the 0 is implicitly placed and put in the
> > > actual value.
> > 
> > Hmm, I just realized that all the EL2 commands do not take VMID.
> 
> If the EL2 commands are being used then there is no S2 support and no
> VMID support.
> 
> So if you disable kdump when S2 is not supported it also disables it
> when EL2 would be used, which effectively means it is not supported in
> a VM.

Hmm, they are actually not exclusive: e.g. Grace has both.

EL2 is from FEAT_E2H, which is set when
 1. IDR0.HYP=1
 2. cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN)

VMID is from FEAT_TRANS_S2, which is set When
 1. IDR0_S2P=1

So, host-level stage-1 TLBIs use EL2 commands (no VMID); guest-level
TLBIs use NH_ commands (with VMID).

Scanning through CDs seems inevitable...

Thanks
Nicolin
