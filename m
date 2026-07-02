Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2638C412;
	Thu,  2 Jul 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020370; cv=fail; b=ZJJ5+mKW82DSXlwzoJHHoMcrXlIKxCLVdGAEI1QDsS0e0thavL6sdARro/AyAYG95VtTKI7u2dg2xR3cnY9sDjye1Levod29nn5s258cwwczejlT1e7Qn7Cn3HvaeKkl/TY/7M14pv7Qig1CsqCIAmxmkOaFSbZ1jgS5H1ocEwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020370; c=relaxed/simple;
	bh=PxqwnpjLSxam8wqEDx9m3o34it87ucSON/URmT0BqwY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InlIIZg0FOOghQ/Bs7ED2FkWquhHCzHoRTgPTQhLUyuMki7a4NcCONk7d2ZVI4D//fYaKJT3PBg517nlGKQhXPTUKpBoLybd3Ultd1T3rTvRppw2qZPdqxmEOZWAWWXTALGfhJfaBkTBvtK0lGX6dpcmIIs7K+OvBMDEgDnmHlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OFJHZb8t; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OFJHZb8t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fV0scgiEz+As4tOsCQSUU/q5iQj6TR8VhPPWzcGxDMTkRiHBdSi2vled3FU+VgFPIBm4LmvxgfIqUad3fcB/5Ci1zpCfv85WqaKBWaBV0nJq1JOFFTLwM/gbR8TygYf8kHiKZE3VD7eIOhddIPVvGmJvPXMOtSxA3kBZqqSBPN++GODqeBhPwf7MucEv6eNuCli2srLWAtoUctGyYKtXnX7ZGpmnRVoMFulW6FaAH74iOk7N8v0g2sgE4LkSRaMnTJ2xhS8XYcpwsguj2hIafFTe1Y8Uy6sY1vUpeKqqD5kCsv742wcf7xE8woyfAssEgFod9S/0I6ebVTZ78Iynsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek/MyV0Y/c7nnxBrx8eDihkBkPio52NDDyImMElFR1Y=;
 b=P5cMOvALmLq4OmLyYpymrygEsSfObZwGFLZ+qgEH8er5awrL/kO5tVS7T8YidaNsGFejozJHTqkws3kDIdlrGrXDhvlQxBSYG3gvkod9XtNGUs03XRcmiKwJ70/mVy/nVwvl3KfVw5t4bNgtl1BYc51uq7SrefSpw5Bvj5EtR+utcf+EUZjMsomdRZb5rd60yz0s9KT3ylT8N9EjjYTAmmt65gAYV/gQTW1zs9dX8G19g969mngc5+NkmEjqaJreAufmSIApS1exdfagVMpt4WGsH26uANkVBLdO7aaeDWeH8kzSPm0Opju9rfn1OOeZu14mcKmyl0oqq2kTtPmZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek/MyV0Y/c7nnxBrx8eDihkBkPio52NDDyImMElFR1Y=;
 b=OFJHZb8ttDztQZS0mXo14VIzToirWaqt3Xdd6seTnUAeCXArKSyH97kX6PhkyKrc8BKBXKM45aJol3Q1eYU+5mgyk0VUkfDWrc1QNV3omZys/BvlHXTaEeIMdrh9Ad/h6x7U1ebnMMHpDPieux77J+2TS6RrDBQbjQURF3ngP6W0ZcRDQ/1mnG+S8LaXcw6f4pVj06BumLErAvEzXuD3lPYqncUTbRHjvf62VErZyQTaXvjkrrPw33ukyEqdFHVfdXUef7jp6icP0gfVt93bku9oO0p/ynINaLTK1yVFxAd+m/rDZgSNUFHEImGNS1QfLC/c0DrhfNsVTvqFumoX3Q==
Received: from PH8P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::27)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 19:26:01 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::2e) by PH8P223CA0022.outlook.office365.com
 (2603:10b6:510:2db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 19:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 19:26:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 2 Jul
 2026 12:25:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Jul 2026 12:25:45 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 12:25:43 -0700
Date: Thu, 2 Jul 2026 12:25:43 -0700
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
Message-ID: <aka7N6oLVq3CoBqn@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
 <akUX3T3fIoN42sdM@google.com>
 <20260702144157.GM7481@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702144157.GM7481@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DM4PR12MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc2ab69-5590-40d4-5611-08ded86fc03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YUb3HFeQ8iRLhaMGXHhSXZp8QPMVdHa/bguLPhIY0ZfIkfvfFKF7RB5ufEu8zVAfAEXRxfIgfq3sTwA7doTUJIYU6kuaL9IGSHsegG90bKB00BGPAA3oiWFqih2Mqgw30Uu3t29EfTCcK/RSwAmiTBwk58iDLfOR9LYB1cOQIzgye8cIdG5GPZT7N3nibWNYSU/1fpMA/JYuhwVQ3ZtObAvapZJ4Y85PrAhwroN4+tpwL7jckf567XTP+dLjtv8EUKxsedm1pJuazaKYg59akxcYtOesLQPfWoo29k/A5VYvLoAR8H7n5KFmClRqoeL40b6OisAHuB4X9S7pwogOzNnfL3CI22gCtGjkaNz+ry1Pi5lhIvi+Eel1+Cb8gslQI5QfYKCwEL/fAFBznj113yvkX3Z/B25IyUUrcdZuBvFAMSbPuHz/U8646ougyuoa6gfhvqroiDrb9HpHg1OG6t8aBE+JcgdziWjUudYlqfYSyxubihM8tFeqZu/sMFTRqkncycGneLRWGsK0lUkzb4WL6Z1u/KKxfNtx9/ScH1+jOHCdQjexgMXfqCoqlthmpIatkjzXATwVRsJaro7Fd6BUhBpmoXaHhMvGMeGF8b144Xh9HqNzYg05CLUtLvfszePU6f6J1ROJbdUifctlfF+YGa8BurlFRl1kRqHRhoZmSPpJCbWyyO8czXOImra0fB6hchkLIHWKEHrqafzsiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BnyKAx0t/uULl8G9WbBrI2EzIOlmv8rBmuEcuwXif4EMgzX24BAh0ij32akQZaGopgi8N7FA6dCb3livg4ULQrCbtnlmrU8yZ6ZGMLzUGXJLvtc4rqR3mwrYSPtlS/TW3jkPR6idv61UbCPuV6buQAONG56f+L1PzeI6UQvdyqKi7PM9ntNtMuJBG5soatRBHk+ndsrTY3kKdHzZwGkAwOtlPqb9Ix0CcSHfA+91/3DeClzwmN+s2Qt+UtpGHThVzRqgPqsi1khUdrmHKhEWgVXAjc2RSZOssdO/y3fq8P56gARRDWueaL1qhGq1tXU0VcfcVm50AmosVhMxvZA+0YwVGSILwb19tE+zEqL1aWHQIhAXSqkE6TKW2IIGCTNoDyZXY+IXffLqdsKiXdLvVOQJ7lNlL4sUlWpSH9rI+SslG6zUn9A/xjr5WpmvhblA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:26:00.9997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc2ab69-5590-40d4-5611-08ded86fc03c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868

On Thu, Jul 02, 2026 at 11:41:57AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 01, 2026 at 01:36:29PM +0000, Pranjal Shrivastava wrote:
> 
> > However, I agree with the overall problem, i.e. IF an active device
> > unmaps the DMA addr after the transaction in the previous kernel, 
> > (with the SMMU powered ON) but the TLBI was missed due to a crash/panic,
> > Any new DMA in the new kernel may alias onto a memory in the previous 
> > (crashed) kernel, not the kdump kernel.
> 
> It looks like there is an issue in this series, it isn't doing
> anything with the VMIDs.
> 
> The VMIDs that are in-used by the adopted stream table have to be
> removed from the idr as well (and similarly for ASID if we don't have
> VMID HW support).
> 
> Then the VMIDs that may be dirtied by the prior kernel remain isolated
> and are never re-used by the new kernel. When the new kernel wants to
> do DMA it will replace the STE with a new, clean VMID, and there is no
> problem.

I see. I assume the reserved VMID for the kdump kernel will be a
clean VMID (!=0). That should guarantee different cache tags.

But, do we have to scan CDs for ASID? I wonder if we could limit
to ARM_SMMU_FEAT_TRANS_S2 only, as this series does not memremap
CDs at all..

Nicolin
