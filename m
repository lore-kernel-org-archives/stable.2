Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795630849;
	b=I00Ev1qnJGDhBrMxYaPnXeQC3RNxK2YgSb75OW4jEIZu9Ec2NfVfUuEaSVByjVLUJfVI
	 YCTEsdI49zCpWg0p/4+r51h3JVhqu+e9vs9XdNkd0UySzBNmkoXUnxb8Or/NSHYVDMGaX
	 MzW4u/mMB+A5e5boZV0O+aLEXA9m0Jo+Jnv/7jy3wZzP4Tb8u5xe3+wd2xxYCKBWEmqvf
	 qVHj8wB5iTfURST2aUkdGRxQP72lGj+90Tvr2WmJRBDjDQX2F2nUAvz/0BIlhX6h6K2xO
	 oQCk0eraAgylCV63dB9nR0GwcygsWtJNDvRTrnqrSRHPAR3QZc90p3zREtJSdZreKnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630849;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Originating-IP:
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
	bh=7VscjMghDCeYXcEHLfTwJ3EFWx9w0392wl7vVUzTwmM=;
	b=b3Y7kKl+d76c91QWuATAKLm4YrBR8ixLqX2oRc6HJmSuNVXN8j4Fmjq+Qmo2s4VTG6fB
	 qqHnHetPMaO3IG8j0ym8YcIEGVmwEpe3UMq8+Z65pE7VOuSwLXG2w3u6duKAaOj9QFAsY
	 mph219yfTljJPBCy10Oxo5ilJeosF1j+8jStgQ+rxbjBXn4+OAtGxLqY5qV2WAQgQvjTS
	 4nbuglkEm62XrjAtXBtzSG3VQLkiBKaOJZvtupoahdpxzeDsWn8HdH0c6NnWLQoMx4Xl8
	 9jg6KeQSP4hoJfvLutJsJCdtGQTiJQdQWN3ZvaM5/01ykglTlawpGETjtaJATID+Rbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HGsaveO4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.53
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A4606A321;
	Wed, 25 Nov 2026 18:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 947A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HGsaveO4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJIYzQCgBx6YxdFMghPpi+/FUw7xzD++bBUPJROz3t5iiaH3k2jbUW7q+bvHEVZu+xnqamWDknXkauM0KwGUxvUFRoGkVakAYKxBJINzN98YHrDEXv4g2nb3QiiL1CnbkIG1ex6dyQFa79aqD/clKSwLdfCu1Ph09SFLI6BtjdN3yrjM5b5VmbrZ0tplgLblNzyjumF+l1grW8dDp5n3UGF1Xq1js6r+/HMcbIFf3vC3vQUeYu5emWeOQgUCc0mWwY+w2wKWrufZ0f6sx5W38bOvRlm7K9WejG6z2ZtZMXpfCxaLdKnda6rMDFYEvtU++1XT0Dky1hfCFli4jMQFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VscjMghDCeYXcEHLfTwJ3EFWx9w0392wl7vVUzTwmM=;
 b=ftkYFR2mW1omy5sCBdDk+suUxe819ZPhcTF1svT0jT6UvSCFKpk3ozYyapOpIc/+m2+sYeBzdinpytK68d6zT/SZ4MdksF5VHUmcTdPsZHetfhipMGwqgdxj0EX/aKKvA1UpWqBYSbn0Wmxgpm3FcEKmaHzZ8oTxF3RoZf2j/BF13SpTuZkybVhkhfq9moRsqDwhjsLuowUlAo+Gk+eCGmZW2XhRzqKIPGCUGqIIlYPOHCob0UZlbk7P/CPs9KMdhC6nnnqtVNO7r6z79uvDjWJ4xfVO188j4rpvKkA45e7s3gkWPdFMhwG1/PPNck4pxHe4VsbvGUWoBoruDxL61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VscjMghDCeYXcEHLfTwJ3EFWx9w0392wl7vVUzTwmM=;
 b=HGsaveO4OOda15eSSVp8FtGG0urkCa9rHI52hyA0/iHJaLaKioIGN/iOnBsC7jgDGLa3VaOl+bOBwhvzW/NLCvAexAcPS4WWqGOOPfjx2A8foOf6CrsDiVVLc2C3dGB7gftZJU5V7NoxDY9U5Le88NKlyaGw7IVaAkbozPTl4iM9pMJMBOgKNVGNliTyncoyhyM73h1d6Mkcfg9PtbnYdr2Rigc5t4DpaaQ+FSPrh2pZ1fKuSW9Iz6zSi+8TUM5kuWnmQG7tmjbHMasij8BHyIc90eFz/T94pK3XyrIAhhdilg9Wv6PnLq8kkiP6Coc1tCWGYHldst68s3eNiK/qXQ==
Received: from PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::15)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 18:20:43 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:510:345:cafe::91) by PH8P220CA0009.outlook.office365.com
 (2603:10b6:510:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 18:20:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 18:20:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 10:20:21 -0800
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 10:20:20 -0800
Date: Wed, 25 Nov 2026 20:20:12 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Marek Szyprowski <m.szyprowski@samsung.com>, Sibi Sankar
	<sibi.sankar@oss.qualcomm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<honghuan@amd.com>, <joro@8bytes.org>, <prakash.gupta@oss.qualcomm.com>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "iommu/dma: simplify dma_iova_destroy() and drop
 the free_iova helper"
Message-ID: <20261125182012.GA774860@unreal>
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
 <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
 <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
 <20261125175547.GM246011@ziepe.ca>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261125175547.GM246011@ziepe.ca>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: a0483a18-dea7-4e42-e7a7-08df4b20d0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|4143699003|261022105027099003|261026140227099003|11063799006|56012099006|261021121427099003|261102123227099003|10067099003|261009223027099003|261026121527099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I5M053D/bKxVqpXSAIGe0+TvJ1koYz/YgXXtfVvNaJlz+sOVF+zpj3Xc4gpZP5yad7B20P3Hi8HE5Zs8ihIPseMTPSX0cCagfEvB6DfGrE6p4dhfYnTgBUvF09BBuFTqU09O/0ZIIg++lZICa/FgBOVjulPhWu4f8UAl3mmISd32mdvXlJUPSopXSkfn+unDKh1Nws+7y7y4rsFIa8Jlop4giIVsvxevdJqZlMELZpO1EB/RcC0NlSw/QioYRxB2JEwzVp2hHdfSHaL9/oXD2nKmSJrveMvYtxndsh6Gr3B0WI/0KBM/d732m6lWHHstwNQr+b3SFCwadDsFbBIB1HSFaszzwB7/CIO/+Vg4/GSX1eTu65Ym5MxoOyfiHKdyxaOiW9tOOaUlL8a68TgcCqLLFM5kBkNZYPiG/F2M1Swm7H8TxpJh2eX//A77y/yG4gQvi7maJmXUzSDC/3x81SBXIcJ8fR1CRGXM/5vaEakjNjN40RxV1eNaf1Ub95zH8uUV6UqvgFhHSHz3Y99aytjxCJGx1SNzUyclLqTkC1gQX/UB+eQIIZ9EM0QFLImOM6qzHIKFJhsjFzOckjl9kiGXXdh5deUUyGXAuGyzqe5YEM/mZSVb8W1Lw/2nllKZhiMDeCpV/W1OoaIXarusCPlKnkyEbpn3Xm/kKsR1bEp/u2x/FF3+A8R0Ro7nFbeQETrYZM2GxBuJAjPafNsJug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(4143699003)(261022105027099003)(261026140227099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(10067099003)(261009223027099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	F01kC6OwuE7P9jZL36B58UAz+kOGIgRBj6Fkipwgc35pSPWqUlHz3cRXn9egRan1Cm6QtOgUA81xbeVcFlunyfiDjVt6IEYkRUrZP48GKuPftcBk8A9IuDGicPCLziJMjDds8UuKI46puv10EixhWlw2s1w4enSNUxewrSEejJAFVYWnGdrWzBTwTRFgn4DBO+W3TRcQdz6L79XRhzIpA7ECMgYLfe0F+t++cd/bVVexs5kHxV3iiwkqWBO8LIwrGGuNVApJXysUiSBD9hqrqC4KLhBjQHuQqC3NAtMA3hZky3o2pKHpU4QXWjbynEMzTEGLOLulZiJ5Pk9Mt9s7ae3Sso+g8woJiGgEzFTGN2vacs60s+PLjAWEcr/9/arYTEdtfx2s31QiV90EHrggy4L9yQqmUh0SmuPqfOqAdHLFVUOJyV+1cwik4vyCh+ex
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:20:42.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0483a18-dea7-4e42-e7a7-08df4b20d0dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

On Wed, Nov 25, 2026 at 01:55:47PM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 25, 2026 at 06:21:06PM +0100, Marek Szyprowski wrote:
> > On 25.11.2026 14:51, Sibi Sankar wrote:
> > > This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
> > >
> > > Before this commit, dma_iova_destroy() unmapped through
> > > __iommu_dma_iova_unlink(..., free_iova=true), which set
> > > iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
> > > and freed the IOVA with the queued gather, exactly like
> > > __iommu_dma_unmap(). After it, dma_iova_destroy() calls
> > > dma_iova_unlink() and then dma_iova_free():
> > >
> > >   - dma_iova_unlink() never marks its gather as queued and always calls
> > >     iommu_iotlb_sync() after iommu_unmap_fast().
> > >   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
> > >     the IOVA goes straight back to the allocator through
> > >     free_iova_fast() and never through queue_iova().
> > >
> > > DMA-FQ domains therefore get strict invalidation on this path. That
> > > includes the block layer's blk_rq_dma_map() path, which NVMe uses for
> > > all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
> > >
> > > hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
> > > 	       4K pages; NVMe SSD on PCIe Gen5 x4
> > >
> > > Fio sequential read/write numbers:
> > >   Domain                          seq write    seq read
> > >   DMA (strict)                    2694 MiB/s   2693 MiB/s
> > >   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
> > >     bypassed (this regression)
> > >   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
> > >     used by dma_iova_destroy()
> > >
> > > Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> > > Cc: stable@vger.kernel.org # v7.3+
> > > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> > 
> > 
> > The performance data clearly shows that the flush queue was there for
> > the reason. Together with this revert it would probably make sense to
> > apply the v1 of the reverted patch:
> > 
> > https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/
> > 
> > Leon, do You see any other option?
> 
> Oh, there are a couple of issues here too, and reverting isn't fixing
> the main problem with this..
> 
> The issue is the assumption we can separate the sync from the free:
> 
>        if (!iotlb_gather.queued)
>                iommu_iotlb_sync(domain, &iotlb_gather);
>        if (free_iova)
>                 iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
> 
> We cannot. The gather must always be retired, either be calling
> iommu_iotlb_sync() or by calling iommu_dma_free_iova(). It can never
> just be left dangling.
> 
> Further you can't call iommu_dma_free_iova() with a NULL gather once
> unlink has been called. That risks things out of order where the
> rbtree can show the freed iova before the associated queued flush has
> happened. That is a correctness issue.
> 
> I suppose the resolution here is to feed the gather up the call chain
> and allow it to be retired correctly instead of trying to short
> circuit it inside the API.

I recall trying to cache the gather operation in an earlier revisions
of link/unlink series, but that approach was not well received.

Thanks

> 
> Jason
> 
