Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790269;
	b=y/nVLo1y7vI9nz7cuFirwo0jYTABoDRPX99uJftB1tCEghVIehXCWEu8K7NLp9Kp0hgL
	 mrf2dxwX3o2FRiekScb72/QX1CwfcBGrQugfVB1JnTUFZTpUYYKg8CcGbVP8BPwFte+Cd
	 7Rwo1vAMUECrrVfH5zAgOxvqdXc2IWdtOXemuPAM10Hi2f0pax1BxMtC134AzCzXFxo/E
	 z+VEWd1LVv2ngofFVSiTTE6NQTBTdW+oNS00yuyG80R6QZFbjj+Rommnw3NrUAPefpMrv
	 YM8/VuPH9rCn0u/UxoOREV4LR1K8jg8VJwq8iHY2uVtNJokCZJGWABo4JbqX7Uy691Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790269;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=VoT7AoiNs3Z3AA16NE8Pvp9B27JTYahbpw8NpK8ie0k=;
	b=W1Q3G7uJ6t7PgyjsXC6NI1T1EyJ/5ATqwLDhjIxxL0Ru7aumRDS8hi4/2aTPuG8nKYaw
	 n5KhBaxHRg7KK6UQy1XftLMQj7ufsVlabpUai5W9Q/FYLnclT1pYrgafaRoZBXZPbsKBy
	 XfY2GfFWwqQ7ByfP/9+r0O4tH0dofPLym/Zb1qHBNeUA0D8YL/0c1bv113q8LYiZ03Y8T
	 W62VTooIlBFW91kwLuRfpQWuTvj6N0sBEVRBthwbI9F5Dsw8QENYypNJSyD5kwbSF3uT/
	 5vWJwHKAEwpG009fwuFEk9JYeDIylMX7VlvSUEY01bDc7GGFBOO0n022Kk/0lPGuDmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HuTx4t5X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.29
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E9606A6D4;
	Fri, 27 Nov 2026 14:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794E9606A6D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HuTx4t5X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyZVqt6Utqmt7M54yvs5WsQbLBJuAdkwTIKkPYH2vAivy/sfs3T4fk+QPDgygHWoVM4vUTpzY7zAGZ0EsaTZUEXRQbVKIt9hcHyxdE1rDma+ADs58W0DM9uBW/CGFVza6lVZdmA6P+SoMwy5YxiRLIQuIhHV8dfjPG+pwPpc5mTb7XA+TE/N6QbfZRCJQrSkSD2gaWancKtSuVZ0N1bXtX2c4B9ffbi/plm32fG0aGFT5TkQFVEuxU31aXvWjlYwERQ826CpCl++XAKWM/aFRT4J0EuZeJDG/AOBMwpYEYNHjbEwK1RE5pbFhhPMUOWieHTxtmk2PGmVPrxdwvSUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoT7AoiNs3Z3AA16NE8Pvp9B27JTYahbpw8NpK8ie0k=;
 b=FVuNauaa27g3bu3WOXVlPDA5eAdjI/iK8AHtVh4r7O+vO8vZlPS4R8wnswnMtc6MTUN/jD9m/k+QU5BpMxU8/8/XtjxlAn4jm9jEKkXe4At/ShA5nBZn7Ro4n+axRRCxyqiDVi1zy6B6iRpnR8Cb+rBy+WrwsWxgwel3I46KQnIOxkMQ56qPwIdaH5aiv0c2ZP7dlAgBpoS1IpIvkK5e70D3Oa4dFeL+kn6riWE0k3EA25pP70q77qn+NIFOVID5sYVDqrQSpuXxrqTAVwXOZhJnih/BBWE8z4WuDSldH4tJNdP0pgbB8yckd0d/XOOJbx8GLN+i3fu/GV6r17SSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoT7AoiNs3Z3AA16NE8Pvp9B27JTYahbpw8NpK8ie0k=;
 b=HuTx4t5Xb2Yek2p/fcM7NeTMQwn9fdzkML6AwPrNlOSwlR6+rdmD+sVKInzzxe2sAmxb6YQRPv1Lw3XTipkLlDpcLyQ/J5yoGU9NI/8Thcay0QHKaYUpVNtzx2slZuIG0iVcLnbPCJxOYEDUP6v0XmpDygux0v1doV5QsEfI0xR29a9gm2vBCsMJ+4+iMw4MkpMGWeAQh+vONhWg8rtPvAMp5DoV/kd9N9fV1Wd2jjr5zgQmzqYPqO0Hiw63vpLGdFF6KiQHXzdpeNhTJ5Hodlkm74+ho29/6g74xGT7cgZ/U0FFhe/I8Vpgvh/1NbggPTMHDbcBFK37rZytyd6FBg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by MW4PR12MB7031.namprd12.prod.outlook.com
 (2603:10b6:303:1ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 14:37:41 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:37:41 +0000
Date: Fri, 27 Nov 2026 10:37:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	Alex Williamson <alex@shazbot.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Message-ID: <20261127143740.GM114472@nvidia.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
 <20261127115849.2780625-5-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127115849.2780625-5-m.szyprowski@samsung.com>
X-ClientProxiedBy: YT4P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::24) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dff0af9-8e41-4da3-afbd-08df4c93fe0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|22082099003|18002099003|56012099006|261028144727099003|4143699003|11063799006|261026140227099003|261026121527099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	usr4Ya1bz4MVaeUnUxUfaGcbgKgyuBqz0SpNoNG2yHZbwjjRS9fz0GaLRn1BmUKv+HBLCWTWJt78BX8YwRXZu2wDeEBnKqFAYe87O9MF6YXEGnNyLIIBmQ5Mun71R+x9tHdakruWPlBsC3rGgEdJk8iUSnDxezPfe7ZK20tUHZvUlE8Et8BleNHgV9cht4RTEIUliJqsgvaQd8VoBAoC6bQXx7P8osqWYdEU3poPxgb7ek6mrY+kSnVM1UwGBmBXTvSiPUg/UMNdL9PulwIVvJorIEfbROU4Q7ocgs3gp+T9Y8YY8cC6w/xvPhkuSLhrgkoga8s7V+oTpY3ISoYlJmaTVpxREsiegarBVtchzxKx6l+vO9yXAl7XtKWbG5hBATjxrsb6g6YTqPEXvJqCrruxZsjuS8juKcUqKvw+irv8fGyqEUEiPkHf0kdQ2bd8CPFQUu9x9jOqvIEzIWUYgR+zPBWXnXf7FW7Ftz8s9mS60KkAZHOrJQh1P9oG+ZJr8MV7+ojIzbpsxn0sTGo9wucgCnwpRsq3uNlPDSgf7Id5oOqdmxe27uqjvst+dr9xkz9edgpdFDX5R5JA4OFWKIREM/YiFAD0hnsOFc2fIzFNlKCg3gCAnAvQyZjVWaq7ebtp7T/I6udolenysmC9yXa8QEdw2gVpR5zycwy95SY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099006)(261028144727099003)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CSs8ABCDQvQwM/znrpMdc2WJzdq31c0DenGcDNE1L2/smwv3XEJQbxZ/8Nap?=
 =?us-ascii?Q?lhnKJKsOifqGWdouUUWyL7Wqcdm2mk5ipSGYLjdwYYXLIdgPJq/n0DBSykYp?=
 =?us-ascii?Q?zSYWVXzuoKRC+SroB/+j+FitCVeB6hirvYcqMbUnc31UO0qyDyPFZ5WFKR86?=
 =?us-ascii?Q?aVa+xWdTtCnDEHY4lg0AVpS1L1lcDqISM2pGYlYHaSsVLDEuQXkfnfDggAMQ?=
 =?us-ascii?Q?YnVdJuIdiVy4MrU2ga3J/AMlQYeZDQbwA8OQOfYffoKM1Aisu1mvDuQWsbYa?=
 =?us-ascii?Q?oHRFi1y8ab6AdnbTXyG7PzzqAYMIOHvGkyNVH63UWL7wsPA9SAZqlXBIHyy8?=
 =?us-ascii?Q?R2pBb2FnePiF1dw9Ls5iuJ4Rzvatvn/stbJRJXpA7Rd91v6vH/FTMYfTlzX0?=
 =?us-ascii?Q?1Tgs6nZvqHpihLySTnpHCGOyQPzMosfFcOlvyrNFdvzjWPYqlrEhqjLtyNug?=
 =?us-ascii?Q?Xe/UtRSF7d+GESbcq7NAul5hJ6vYRYzm6skabTf1E9atRML/O4yncC2jy7n5?=
 =?us-ascii?Q?cS+BpS9xJu7RwrZQTNMr28w10+uA5CroHdr/WUK9isQeh4B5xL6YiTwMnuSu?=
 =?us-ascii?Q?s5AnhfP6nB+WpP2sZ/4ieT4+aRI9E2RQVzEXMxE5U3uBJ9uka+otKfd8Zx2F?=
 =?us-ascii?Q?gVk+Tb1403CFvZaV8XEr36J5DOuRF4NuSsTMKn9GH33Du0cARVKeV2sGyD3x?=
 =?us-ascii?Q?t/0Yh2u5MZrsC5Miic9yihlqRuc7HSzOYThBGjS1ihGWBn2i1EHkYRnFZvsK?=
 =?us-ascii?Q?xo6ozNwGGNnrSBD9N5SoZccNken8BXokwl4v9tQUsAJiyGp9fX/2u51wexEv?=
 =?us-ascii?Q?ThVdOm6cyge7IqLZF2XQpf6JWwa1AncK4gsmhrY8DbyBJdmlSKKh3j9xXJBr?=
 =?us-ascii?Q?daTTYbAyjBbXlHLxOPRAsmNbzixZNqE6N5ROK5GOMjlUBlAqWW0BTqYDjaEe?=
 =?us-ascii?Q?pouC5iTDC/aFgfev3+UBzJKASwBZbhJyFzuL/utkjm9sG475adigBr9LIp+N?=
 =?us-ascii?Q?2/4pSRI/Lat8ucZOpDPOLBJHMYoo31Wbd0uGwa7CMMtlWI/y1Wz4jfaNzVmH?=
 =?us-ascii?Q?GQ2hXjjLFCrYiWrfJuBZai7v5+GeTMT8hj1t9sGMQeKtTi0KjWs+FyfXsybc?=
 =?us-ascii?Q?vWv+thWzdmzo2/7uDdM0DXriqKqg6JCax9/Ik2EKkA976XWOD9HPHXz8Nhbp?=
 =?us-ascii?Q?wSqp4l+8Pa89ERHORS3QHDNB+bDO0thCNcnVch8w77zQH3Gna1GjEYh0WhbK?=
 =?us-ascii?Q?dYPrCsI4wpDEqMktmaVXS78nuC63hucAxupo0IsPYi4P+L1NADoMpkr8+mbn?=
 =?us-ascii?Q?n0xheCRSYZKubW11DqTDdZmLkobTFdUOAxQlcJ0U9WsLnVVUu4L+iIZfbOXa?=
 =?us-ascii?Q?6W5y3g6r5+ITnE6bX582S71VbarbKCYQYBBtCJetGonp0tjCvFyIqpQ/gy4z?=
 =?us-ascii?Q?MHsp/j2Ckm/nd0C/KjDCnG/Gj9FONbc7haFMMYnf+YaD+3Kdse75HIScV/i/?=
 =?us-ascii?Q?CB06Sk5SdllgjOG2x00clt05Ca09oQFBeOMshenPg99tkLnA9q+T3vn9B1at?=
 =?us-ascii?Q?I0iU/FHKNRkaB2MEK3QYxU0t8XWM7Rp6lnh/HuTIZNCOJDHDGOHDr7+KLsxA?=
 =?us-ascii?Q?1YUJsP3SHiaxG2EK8aSI57H3jEws9r4+DlbZAtwL+SXt8SJ+Nft2izBgMyqI?=
 =?us-ascii?Q?QSAPTm5cSIGcGAFBdoHBktuVop6yVil7vfkA4HYWCIrtdtwT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dff0af9-8e41-4da3-afbd-08df4c93fe0a
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:37:41.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/9s1YgrelhlJ3l6kwb3/JDrfOfBhB5jGiC9toz1ooEegI1hXjor58mOV1//cZLW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031

On Fri, Nov 27, 2026 at 12:58:48PM +0100, Marek Szyprowski wrote:
> Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
> the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
> followed by dma_iova_free(). Before it, the destroy path marked its
> IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
> and handed the IOVA over to the flush queue, exactly like
> __iommu_dma_unmap(). After it:
> 
>   - dma_iova_unlink() never queues its gather and always calls
>     iommu_iotlb_sync() after iommu_unmap_fast(),
>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>     the IOVA goes straight back to the allocator via free_iova_fast().
> 
> DMA-FQ domains therefore get strict invalidation on this path. This
> includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
> iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
> (SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
> fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
> mode level of ~2.7 GiB/s.
> 
> Instead of reverting, decide once in dma_iova_try_alloc() whether the
> IOVA space is going to be released through the flush queue and record
> it in a new DMA_IOVA_USE_FQ flag in dma_iova_state::__size, next to
> DMA_IOVA_USE_SWIOTLB, so struct dma_iova_state does not grow.
> dma_iova_destroy() then unmaps with a gather queued according to that
> flag, skipping the sync for flush queue domains, and passes the same
> gather to the IOVA free, so the IOVA space (and any page table pages
> released by the unmap) goes through queue_iova() again. dma_iova_free()
> honours the flag as well. The whole reservation is still freed, keeping
> the size fix of the reverted commit.
> 
> A gather must always be retired, either by iommu_iotlb_sync() or by
> handing it to the flush queue together with the IOVA, and the IOVA must
> never be returned to the allocator while a queued invalidation for it is
> still pending. To keep that obvious, the internal unlink helper only
> unmaps into a gather supplied by its caller, and each caller retires it
> right away: dma_iova_destroy() syncs or queues it together with the IOVA
> free, exactly like __iommu_dma_unmap(), while dma_iova_unlink() always
> uses a never queued gather and syncs it, as the unlinked range remains
> owned by the caller and may be linked again immediately.
> 
> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> Reported-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/dma-iommu.c   | 103 ++++++++++++++++++++++++++----------
>  include/linux/dma-mapping.h |   8 ++-
>  2 files changed, 83 insertions(+), 28 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
