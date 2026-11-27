Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795790255;
	b=tN5H/E8H+YQGDNQ4tuupASy0tVElR5Og6LVtvoWufWVQnFuNrhTUJ+ZkEr9PsK84ldKQ
	 2MPa/guMJg0SB+gLvjS036dmjbQwEL4aFcMjpH0Ry0Vb6Vlrhv+A8HZpZhLoFhvGFBC5R
	 jUmOvF6WfFPdJuzYNlWeRqPHn3oTB/v7XZkkOWhmTtBMFI987nGAl1UAzME2FRz/5iinF
	 kzCpvKc8OLViekDM6y1xqIDuuOAm+9j2a8SgpNcwUWIh/ykSXdxUxNizjbVeQHPwS8soj
	 CTRcIH36X0Dg/5aO7MOWbHlkZudMa1143fPhFNRRshGQ+qrxHSVBdxSyYS7gdA2zDEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790255;
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
	bh=dQu2K0xglruwihgXoUYzc27ZexR2Bji7dKkAP8K0SVo=;
	b=x3zzEjCaxAAslHwNzMqSHulBgjXkrvMMd7rh7pPKspaeB2QQvM5Nr7YyBaongjVRSREi
	 nxLn1B6JRJxC9g8GTUWOUwmKH84K+rqOT25cl1CJOdq5gEa7HQT0oLWvIRfZmyTFaaL+F
	 ksB8j35e8uGLV5MfhNAY+EQm0hfrY6/8l0t4aUd1h/G6qaXlvvTj3XlSlxeIGXShHkNc+
	 7kDijt1o73tQweb9wjYCGW/u+dIIUEJ2Q5nbZl40AyQZYOfl0YrpL0Kn69LHjhy8NRG/U
	 p3Hw+TVGnOaxRLA7AIznCzh3B9bUBEVAZDsnrfFRViJHQu79NIcO0GUIz0PpaQPlnFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WygLqr10;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D437606A32C;
	Fri, 27 Nov 2026 14:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D437606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WygLqr10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gja2gq7yifKRvaQ7xMhLE57dqmHBotqVkzqHU09oNFdcj53QsFThWsAztgo9HavuJCDj1g0xpDZscuPYlcFTIl9fwjqUz6OBSxk0xrPI25Cjg/SxySEZHwOyf6aF6dsTPxxVpCmodLAf8sygd7aY/seqyY1txPPPcxyoY8o0DVV6GByLyuodYrMPAxjlSxeGV7Sel+I7c6/OOj5vdfAMMuNtRtOlcU7qufyecdOkt0OBaX/zlX81xLZYC34iB+br4oOLoC6w3DxqjZmMIJfYIkAT646mUMGYOcojKGnjg0HdhhQx/ViiPl3V+RIa3yw5yj2wysj6czT4iYoJjlKk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQu2K0xglruwihgXoUYzc27ZexR2Bji7dKkAP8K0SVo=;
 b=atJjTUQBx5QEHBeZvIu+Dsd4CcYGn96rW9j+vTWb6Vs51lj8rwX6Cb7FvD+evYKrfmrFp9jANyNDR+21UqBsL33yxvB+nxeN0apmFgcYKUTLKNtdC8A4r2s0bYBJiN3LJMVERy91e39w40ijLFNIhO0txWtNGQ1UqgPaEQI8bZ3FiSbsnK2zRQ0FxRzspgt3ykKn+mAXiyxjC825HjzbESmO3d8tDT20N4R7/ajoSbhzZN9AbgiWjQ9Vl5Xt/a8lmvheS6LaKPH21L2oi7enhamufrKoyAP71bLlI+gvTGQoM1NRX81KO/xUtw4ibGB6qcJ5Hav1C2V2AHF9ZuZwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQu2K0xglruwihgXoUYzc27ZexR2Bji7dKkAP8K0SVo=;
 b=WygLqr106REtoppAXJT/vWR5pVQWXdfEpfeKQoKW4zjBk9azDPbZEEn4f7aInatvRW0dT55wHJGoCQ/d9RG2Wh2hb3BXOczKEg2kf5Dw8Lsdg5V0q7UsRgNgMWhRy/Mz4Uw9sk6v37GZWoP92SrKs2TRDYKlBuCWQshDjl0T5+sDIJF4YTJ+nnePQ8w/BBS2i3TCKI3sZog5Gf2OsYBeDMstDN45upt63DWx36QHamtFGqYxR4XJv/7H2U0PqdRhkVQ151gaYItwyW3YszttCQzmPcVgQagn5CRA2wJkFokNN5iSpkLcBGO9lPItEIzG9ubDsHagLLxNz9PcGc8vaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS5PPF23392922D.namprd12.prod.outlook.com
 (2603:10b6:f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 14:37:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:37:30 +0000
Date: Fri, 27 Nov 2026 10:37:29 -0400
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
Subject: Re: [PATCH 3/4] dma-mapping: add DMA_IOVA_FLAGS mask for the
 dma_iova_state size flags
Message-ID: <20261127143729.GL114472@nvidia.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115901eucas1p22ee3dbe744707c23f8ac2442f755e041@eucas1p2.samsung.com>
 <20261127115849.2780625-4-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127115849.2780625-4-m.szyprowski@samsung.com>
X-ClientProxiedBy: YT4P288CA0088.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::21) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS5PPF23392922D:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b19960-a3e7-4857-1e54-08df4c93f779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1shAXauPd+YJCn+Jxo4lhYgzQs6zyXEeYuD+tEqO9M3LPSlJMJEtH2kAor4CxqiapYHDnhanRf6xJhydAFNsOoXcIy2/LviXSFkTnbjRoLpQGdFNEIavuURAs5/0CNAmobm8bNF+6w16EKhfb4ENF3ZGyxpPIlbBu6S3itY+UcKLAhAoGoXPum1kYnwMWEQtzzhlaVgVwgb/IjBSBYqgdzz1IAA7qG5lLn/WP55aEOFkL1ShlJcItV1HEk+D2d6EP9thLlSRCM0IGA92j86jdSHyn3nJ9zdQYn5VNru8bmErKHAqfZ0ZyMX4z8qbL/RVn+05Vjqp2utgXI4LFtvZajts+iUkNLDcz1rNZ0CA8+6/lH8pZQ+RVTx9CfFa6i0hQlx+e7W6YivN4UW07TNS8/1Dog3VV1+yEbHF/gwCk1LevnAoqF2NyWOCsngkFxpzr09G9yDHsDzEvDTo+N8Cr2HlYFCjPrhrGa3wmFpxa8e8O4zQ7iBFdpT7/mVzFlbVyZ3g7205XaHMDM0RcyN/EuMfxT0AP6d1tOAik376srsDWFVm5GF/5xT+gpQQ2VEiy9Z3vY0ifW50r33cVCz9xyao14w9wjsHLmRMg3lI5qld4d1KoPtsRuhwbemdBzt81MLGyTjSL0e0uZz8Kndksw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzfvuvccBt2VMkWkT4pQZMZ6po0Cba/50iAvBGQMeANNsFtv/uoWbCSHYs02?=
 =?us-ascii?Q?rL2pnbtlZHc2K+fi48Pyfb1tSKaZW1gxoVdOaKwCSI54Ebp1AFgZ+wXTrW0f?=
 =?us-ascii?Q?Y4nx+65zTUUXmdvibYrui1fz7SqYoNOdEDDZOqf7CgnGTZUlFDBeb7Yr9QtR?=
 =?us-ascii?Q?vPN3EL7ByWi0XZhDvVFlj0rTdCmFw4fdeXg8QniiuvC3X8HLu/xYa5Gu2cve?=
 =?us-ascii?Q?0vzl5zNIpxt6oh/Xa5GbrOgJPBp/BN5TxcqBRjG9qqEGjLtEZHgpriqwF8ET?=
 =?us-ascii?Q?zVuAXpF+todx2UOPgOzNLS2AkapNI0XerY+cpr9hVyYmnDSl7CCEiVKneLS+?=
 =?us-ascii?Q?vbfcBZEtMkAQbY80SE8fUjRvBW3gaBFkt39XqZshvGt/tAugYcOmXh+qNu2q?=
 =?us-ascii?Q?nPyF0awvvWMQR8OaISaW4twNYQnoetmNcKb+0+Wz+D2L+ZMhu0UMl35EPv1c?=
 =?us-ascii?Q?iPkRYII3yUpcI+unLZVFIktzMmY+Dfj/FWbiFB/XTJ4zqr9OzYed3ZIq0pEA?=
 =?us-ascii?Q?SdGBWFXTfGVRLckIGcvJZ8XLzMJqV0b9yUGDtaQrI1X4FndfEtp+A5GAjztD?=
 =?us-ascii?Q?MQDZJp/MH49ylzMpoQNbI3tApIynX0uReYQaUZGqLcIBQfMVYKsGfYuhkzTb?=
 =?us-ascii?Q?aq/9N4oJoDaSoKwCO32orINAOHnyP0EP+CUyf1H1SBf/JH5HdWpbGo5sVjOE?=
 =?us-ascii?Q?eWuL82yvUKq/K+gRcioCnIxwbGh1IWfx14uvrZf8QHkuX+M2GfoLieSae/bC?=
 =?us-ascii?Q?9Uuwg82kNvsqiugMW/pjgf6Rv9E3J14XeIHT9LnxMz5Cvjd6WS3IKlqYY2wy?=
 =?us-ascii?Q?2YJZ+dNAmjPUswU70zpcTtAMoPrqQHuLbmTGZpise+yavxJYnZ/3MidZBSro?=
 =?us-ascii?Q?EyKFJQepCinUa3xuKSdgybVbeTpGIoUz6C7SQLT9i9cr9wNtkQ0jq5Nhd1Ze?=
 =?us-ascii?Q?umuSKwElCCrcryo2GwaeS/jAep79YaxG0Fqxny2j/mCsLfhxnIQvp7hqLhsY?=
 =?us-ascii?Q?hG/gzzuyuSNGlz/7m+cpOaukYPZ12tHPF6KrvcPI7eGsey3JP3soJUlErlLn?=
 =?us-ascii?Q?03sTV4wuVw5NAtG/gUt+WQzKjYEPFKjbetIqn63rsI3j0OrLjM9swoGvvj3z?=
 =?us-ascii?Q?Zp82AC4Ipx7R2wid/UB6FlWzcpYmnjNw30DYSufW0Vgy9nMrdJgFBTvJ98Ft?=
 =?us-ascii?Q?C3pSBJQgE0CCdgTIfYRXJHgohkGdp8bL2F+nEa9YUd6mJE9QKwtdMTKsHgTy?=
 =?us-ascii?Q?d4loZlYDXVc7uyXTqoYFgWFjHp2W1UMsSihBBWVbGFUvoza9UFWNG9u3zB+Y?=
 =?us-ascii?Q?SuvKwXXhf0KJHZHL8bEZiTEuzbCDpwN8JTM/RSSM+z3iSO7BxKzS4tq5hhk5?=
 =?us-ascii?Q?Gmo4nlidcgryWewuB0DCulJCDr4QOtaxkocr7ssEgJnYbP7pRln7pMozmNNa?=
 =?us-ascii?Q?htsI+K0kC2EgG+lXrAzuQLCq1gn1rYE382Rhd+EHiaK7gZMtbB3N17HebyYc?=
 =?us-ascii?Q?dtzLaOCUZizZK/DjaAn0cMUNVsNLRiOqRsQONvlKTrZlrVjC+bzIA4gY5LC+?=
 =?us-ascii?Q?L7bJ5fgMLXCIvOvqCq6bcb5uE9yx4Q6AsYWwr63VTQ9d3aoPjPs6XxEnlCCI?=
 =?us-ascii?Q?UcDuzFkZ1ueT3zbQjsw2RCowpCobL3UdCET+mGj/SfZOrgTa0KkL0LQoNg4q?=
 =?us-ascii?Q?D1OmzN84yspIJXv1VQWOVbxebzyrEeXg9C0DwfDYH2LXpB4P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b19960-a3e7-4857-1e54-08df4c93f779
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:37:30.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oV/N2slOGegT8E/fYHvMb07LIBhAD7JbFBnv/l79MgnT5B0GK6b4hgHS37ZG3iP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF23392922D

On Fri, Nov 27, 2026 at 12:58:47PM +0100, Marek Szyprowski wrote:
> dma_iova_state::__size uses its top bit to record that SWIOTLB was used
> for one of the linked ranges. Users that mask or validate sizes refer to
> DMA_IOVA_USE_SWIOTLB directly, so adding another flag would require
> updating all of them.
> 
> Add DMA_IOVA_FLAGS covering all flags kept in __size and use it in
> dma_iova_size(), in the size check of dma_iova_try_alloc() and in the
> vfio-pci dma-buf length validation. No functional change.
> 
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/dma-iommu.c          | 8 ++++----
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 2 +-
>  include/linux/dma-mapping.h        | 8 +++++++-
>  3 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
