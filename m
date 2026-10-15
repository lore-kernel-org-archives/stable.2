Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26CD282F34;
	Thu, 15 Oct 2026 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024015; cv=fail; b=TDlUyX1QCAPl7ZT6q5idJOV0ENvF4Ix+8cWpscB5VC2cHeartVyJkK7XBnrH/s1lCIaWf4jXA55nnhv3x6vOMV6Fa4Lt3P1FvooAcKaY/rTnIyQBtkkde/NvaTVaisQm6gjXFu57eon/gbGBjirVZYDDloS4VdGkrrahN7KHGWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024015; c=relaxed/simple;
	bh=H0WPja/2rgaW7oaDJIr5ZCklQyMqscq6hTCktTYOmTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ejKM6xiReKDxv1YLVcxT7YZrfq9PSxulXH6rUgSxw/EZBzzANr94gjIwhGZSbaipHzjlb2N3VeGPffV3OJCWikNO2OyjedZEpS2P73RGhRCd3VeGiaYW0mAXZ0rYtlfhI35e3+xJedOpHmfpljZCmMtpQvLpd7F6rTPayQUWiSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L7WxGzlZ; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L7WxGzlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otUM77ZB/UNEhbHJyuvnULm9QOtmjn+CECuK05Dfyj1CkQDtMpZNKdLYeBIXBNkphcsC7W/ztIwq5Zila3MRGbNO7z/OWfNNbQEbjp0zSk2/t2bB4r4k0ce2Q94AD2OFKHgClIZNxhSnQqeeS9vIUkQMTYLv0lhMaWAyjD4m1Gj3NDUJUu4JdyUtR01n1i2S77cV9M3nh1kRgrBLrIM85lRmlz4fEnkQSIEzyjLmE/ELZlIlJfMFMgefE0x/Y5c9sXqKkXZOIQOm8unJhj6a4a0J9NSgHLvBw83o9Xh4mXaSKqj5a7waXEjd4yYzhD/u+dg1AqHv727pZ6xygLSlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2J/TjmsoBh1rg2XJlhwq/8kDA6PVWOx+Xx9uQA7s/g=;
 b=xe7piSyM0DuPRwU7x0/j2uCKxPOgiTPDnlnRmOrakNdyvB3Jl53o5bzIvFBqmQjT/m8XwIGXm8b1x3H7dTzUHXqcgRcwx0vAiMYPf3WHu07IS9dV3bMNHqiiNDxYQsIX+nyFhxGQf0BMGlcjYoq1DDWwJg0zk+RURqNcV4woLGgi0EJ53E3HRjd+sEgqeEItqr+6EWIkSOqt9G3L/U41wHwXvQmC6+ubrJ2B5qEXYo9xtWpwKBlCfvbob84SF6VUje+wjBl5fZNojK7CbPr61KcIyhXIj2H/YcoOmXe1PXGuz8Pz4nWYDj79TzKs3ErtcU/qD/2srM6pzr5PZgPWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2J/TjmsoBh1rg2XJlhwq/8kDA6PVWOx+Xx9uQA7s/g=;
 b=L7WxGzlZWmZPjayXiyYdocH4VVti861za0zaYM1g9/PjbXzLaBbePgE21KuHwh5xsL7d1eUH6UVdMWEBlKQqH+LPs8UHnCUcCgsCUcdbF1l+irGRay8Z9c8Kg7atmAbMvG6RYnoQpT2gXcx0iijDGl3mrRkfThSb4TrabATauMH1PeX+nCs9L3fVMROszDqMkP2ReXBZ4nXN3/qthYCebLgriYS0gZn49usQxY13zipTJ+c/zjSq1FpncxuWdAhLf+YpbqLMVGkFILHpr2dYrPLqlx6J6oINTn8V4NQc0QZxPQVlGv0+e+p/hgSiLkow+1D/m/rIWvJ9KkczHwYbxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB9044.namprd12.prod.outlook.com
 (2603:10b6:8:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 00:26:48 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 00:26:48 +0000
Date: Wed, 14 Oct 2026 21:26:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] iommufd/iova_bitmap: Clip recorded ranges to the
 bitmap
Message-ID: <20261015002647.GA3575173@nvidia.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
 <20260925161142.189813-2-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925161142.189813-2-parri.andrea@gmail.com>
X-ClientProxiedBy: BN9PR03CA0426.namprd03.prod.outlook.com
 (2603:10b6:408:113::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 587fd53f-d062-4d05-555a-08df2a530041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|4143699003|261009223027099003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vj8FChuLSC463jCx1upvx6UXpL4unU3Hm0SWksG//D+A8t39H6WxyFGnYLQvo3b/gekwNSr09s2Catiw8bCEn2u5qLbUTId/3AfULK5ZxBZybLOdctnP3mwsRFT7eqKwCcgX9cJcKXmziLlxUjb+fMxB6nkUN8Km7y8FuwgsW6lz7yZ6v6eklS1wRpz5u51977UW76W1gURHFs7BLmzpI2bSaGKTiboWqStyOPfKVjxFQieDa8b4eZvNi12joT6UgI7gP+yyKgOZXmiNi3vjIGP9orkaa/McmFgg3NcdCxlHL679MgsPVfECmPsCkd+VYuln6l8fG3cRxkeMsjkvBpsAy2eg4tl/caeaS3s0Q4gdF6ff4q4FaDtmFVG09JLLDEK7y8ajSkmmD5H8lbMhERR0Je5UCwLSBsNy8uxIW0yTYDbRDwU5OG/lyUa67y3yx2GybpgPtScgtckYR9BRg4QZxYfruhXOxo8e3/6JFY8waD+EtxssagEcMZIYPOYCkJqIs0E7jp6hr9PXMRRp1zwkVe630Q/EGuD6oD7yPW3hYro0iEppF5O1TWgl0lG+vJ/xAZxaHQesroUvfUUrl67W8LG1SBkJDMsZ90SnDeRRpObeuhx1Eg88uAQEagsLqFtxah4fV147jtY3RYhQBeywKfFDxTlQW8Tpxu4VUdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(4143699003)(261009223027099003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlA+roZzetJtdPowSxT+TOEHtgkby6ISIAPV1KP4jLbCiFV/aTTi1n2ScbMs?=
 =?us-ascii?Q?QSBaollNyB9Iul/Emi4OrwVwkKPBXHj2KeK1K+NCaXFYwY9ighRblWuh2Kg8?=
 =?us-ascii?Q?P1WjdV546vW2De5FnCQjkg/gk+0O6qO/++DRdcgQnsGU78L8Gpl4lU8VV5lw?=
 =?us-ascii?Q?YeZlTDHLdDyDSNCOFISiV71UVfEyFDiYV9ryiUq1b7Nf5Xg2NPxcDzS0ImE4?=
 =?us-ascii?Q?j1JZ+EKwpaQkNWgcSwf0Rrpy3qEL1tK9bPNdAzfgVH6qjIZ+4OKACaQKRmQi?=
 =?us-ascii?Q?DRrfYv4rdgTbXcwUWjnUDEAOTn8mHF4UA5LIpEB2q4La+Q5uBD14foULgjTE?=
 =?us-ascii?Q?E1UDeDNnSyoC0vNxxzcpWtNCDmm15H5+4+uqxR3mgwUqZJQQNhxQAV4wAAO4?=
 =?us-ascii?Q?4qa1iu9D/rZThJMpwJSuRddwB+zdAGAUMaz0sTCXjr7DLVfu5EGOejfHgKmE?=
 =?us-ascii?Q?RNLXzN+d4HfjzTUiAUpq2OTQMDD6Y+yloA3s2JUBLOVrTh6Tn4UU2eqE+jkk?=
 =?us-ascii?Q?xqEwzgL1xIXCdvwXJBUSDL9z7fDFjhF6iAtVpIHCWxgn6i4PxivOzb0h9+GS?=
 =?us-ascii?Q?fjFEteN7RwlleDfsxytzZpu/+VgFm0jVpxnlUhHslasptH0JXpvOxMhSpl5i?=
 =?us-ascii?Q?OzrnIXxfa+cBxbvCXDTyztUdx4XWXTqOFlZ8+KxOyNVajCfRBn+3Yy+ewJbL?=
 =?us-ascii?Q?0SC5Ej9K67XboAGxizeOovs9yUPIkjBy6QyCbnOIGUTu4Hcp7N8foaC0rgxx?=
 =?us-ascii?Q?Cm9mBLmafpFOGwKvr26A/k/ih5bAom4TY+IbMfl+kJTBhe1jU7KZWOctuKyl?=
 =?us-ascii?Q?npSfG85RA9imZqJOiubKihnIdnKzQvtL2P9eORYpGBK1PFzni/8wVrM23tk+?=
 =?us-ascii?Q?mOrhx75NGyyUhnXU7kucyC6YgOCIz917LBblP4kKgJ8r7IAKhpqhHKqYEwhU?=
 =?us-ascii?Q?jdHy8uiw4czjk2aMfC0/E4ytyfBUeWtYMeko4APSnAw6VlssQz0wiMEd4gDL?=
 =?us-ascii?Q?ejAEYDj9kZdwA71lXQ5szHVyp+lMedY2RkHFelgjvT2hkf1U+3TizoG8yfsk?=
 =?us-ascii?Q?gsS/Jq+DjNdGPGqTF0tklxyOtETXpK6hcXNupv5m3Z/Beucv6m0ewsqF/CqN?=
 =?us-ascii?Q?DbMOANlE17F7VevIevH34ZOihXnfberniCKHV01o1EqPqXE9mlLeHvZN4Rbl?=
 =?us-ascii?Q?zdXRmm+u03Ub43G0XOByHvV9ZnP69SVTKzmRVZ4Ms//803XqZksXEZdObvgg?=
 =?us-ascii?Q?NvoxBVN1VHNawdoYKE0Kf+P5QUTpB5lLpV8YKPiNOU0/cazYjh2U7rFd5WBd?=
 =?us-ascii?Q?mwFjDQ7bGHXQgLqZ3JsIGjPSRxM0NNopQJFmpxh8mX0yifn9UJaj3LMeRiA2?=
 =?us-ascii?Q?WvijNAEeIOhkYrvN3+PPy8OduCsmQaqMzEksfK3BLQ+Dycv2P5sdC+3qKNub?=
 =?us-ascii?Q?TdRlOcEfiNlvepWe5e90QknevDL+Curbko6HDOPUYeCt6WpqzPMCIf94LCqi?=
 =?us-ascii?Q?IqokoGMLR0oGugnRtb83krLa3rfPZxIiayxvxhsVpGTeRc85aoK1CIeTlfPB?=
 =?us-ascii?Q?7rYXK/O1yn4f2I7R+9U0VGTBOpP9V1KGzKkzsVlMJsYUNP2lexKqIFf7qask?=
 =?us-ascii?Q?yzwPLhfhKaxZqIFyKjnwEhJ83JSyBAMNT+jDe1YK4LxowpcU+weQ3xIhEHPw?=
 =?us-ascii?Q?aCHnutqpR1OhLaaA96ccsP9uqlfYMVV2O8fO2yeCc8ZsJvsM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 587fd53f-d062-4d05-555a-08df2a530041
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 00:26:48.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cytGrli+PXa3P06ZCa+C+yKKqF6vvolsXJpVDesAAf032lQgVVeGGF0FSFZv6tY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9044

On Fri, Sep 25, 2026 at 06:11:37PM +0200, Andrea Parri wrote:
> IOMMU_HWPT_GET_DIRTY_BITMAP can set bits in the caller's memory past the
> end of the bitmap.  When the queried range ends inside a dirty huge
> IOPTE, the generic page-table dirty code records the whole entry, and
> iova_bitmap_set() then sets every bit up to the end of the pinned page.
> 
> iova_bitmap_mapped_range() checks a range only against the pages
> currently pinned, and iova_bitmap_mapped_length() caps only the pinning
> window, so neither limits the write.  A range that starts inside the
> bitmap but ends past it passes iova_bitmap_advance_to() on its start,
> and the write loop runs to the end of the last pinned page.
> 
> Clip the range to [bitmap->iova, bitmap->iova + bitmap->length - 1]
> before computing cur_bit and last_bit.  A range that starts before the
> bitmap now has its in-range part recorded; the unsigned underflow in
> iova_bitmap_advance_to() previously rejected it whole.
> 
> The clip runs before any pinning or indexing, so for a validated query
> range cur_bit and last_bit can no longer address outside the bitmap.  It
> only narrows the requested range; the bitmap bounds are fixed at
> allocation.
> 
> Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  drivers/iommu/iommufd/iova_bitmap.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
> index dac3e657d498d..44826ae330c4b 100644
> --- a/drivers/iommu/iommufd/iova_bitmap.c
> +++ b/drivers/iommu/iommufd/iova_bitmap.c
> @@ -388,6 +388,30 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
>  }
>  EXPORT_SYMBOL_NS_GPL(iova_bitmap_for_each, "IOMMUFD");
>  
> +/*
> + * Trim [@iova..@iova+@length-1] to the IOVA range covered by @bitmap.
> + * Dirty trackers may report more than was asked for, for instance a whole
> + * huge IOPTE of which only a part was queried.
> + */
> +static bool iova_bitmap_clip(struct iova_bitmap *bitmap, unsigned long *iova,
> +			     size_t *length)
> +{
> +	unsigned long first = max(*iova, bitmap->iova);
> +	unsigned long last = bitmap->iova + bitmap->length - 1;
> +	unsigned long end;
> +
> +	if (!*length)
> +		return false;
> +	if (!check_add_overflow(*iova, *length - 1, &end))
> +		last = min(last, end);
> +	if (first > last)
> +		return false;
> +
> +	*iova = first;
> +	*length = last - first + 1;
> +	return true;
> +}
> +
>  /**
>   * iova_bitmap_set() - Records an IOVA range in bitmap
>   * @bitmap: IOVA bitmap
> @@ -404,6 +428,9 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
>  	struct iova_bitmap_map *mapped = &bitmap->mapped;
>  	unsigned long cur_bit, last_bit, last_page_idx;
>  
> +	if (!iova_bitmap_clip(bitmap, &iova, &length))
> +		return;

There have been several patches about the dirty stuff all together and
comprehensively this is not quite the right solution.

If the caller is providing a dirty range that exceeds the bitmap then
this is coming from something like a large PTE being dirty.

If we silently truncate that to the range of the bitmap, like this
does, then we also are silently lossing dirty marks. The userspace
will call again with an iova range stepped ahead and instead of seeing
the early blocks being dirty they will be marked as clean.

There are several bugs along these lines here as generic_pt is also
incorrectly clamping the ranges of the PTE.

So.. The right answer is for this to propogate an error when it
fails. There is another patch that provides the mechanism for this
already.

I will change this to just be:

@@ -409,6 +409,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
        struct iova_bitmap_map *mapped = &bitmap->mapped;
        unsigned long cur_bit, last_bit, last_page_idx;
 
+       /*
+        * If the range cannot be recorded then the system call returns failure.
+        * This is to prevent loosing dirties if userspace is expecting to step
+        * the bitmap through the IOVA space.
+        */
+       if (!length || length > bitmap->length || iova < bitmap->iova ||
+           iova - bitmap->iova > bitmap->length - length) {
+               if (!bitmap->err)
+                       bitmap->err = -EPROTO;
+               return;
+       }
+

Jason
