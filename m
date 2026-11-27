Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795789760;
	b=1INnUCALjvEam1Bxxbd/y2xHz0OCrYN6Z8QsXz+krmshZ0DrMZh2dIA5/bYlYJ9W9nL8
	 O152WMqnHT+jlRqmUG0ZWj+n7qFUObil/sJ8cjgJYrp81cIFu2nRPsZ6L45KqXcaWQ8Gp
	 WSC1FiLaGI6kMiL/RD39cL9E7YWK5H1eeyF+hqyjja64UxCnKoRYdVoW5XZ25pO8uz7jG
	 A5oVkr8nFee96PhayvRkbNkiyPxpR3iV8TWfhkevWvAZ2Nt+sXU4RAUcw1DXZ4lamRPgS
	 ZY8LBTN/roRaz0b5qJyRuXZf1F4qIdU62emfc3fVNfBTsmVoma6Sb9BLpaZnWtGhZDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789760;
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
	bh=MYPfv/yc7G+AO30gWq2ZkBCvSkxgX15UJShoAfnJHjk=;
	b=U76sMnpCjpEvfhh5YDu+Z9RQPtXrkUEemrKINyuRRFjCZeTKQJaCSlr89bwtiosSBFqO
	 bKuBY2BUjn1QNMUYzMzaQwMF3zkdPdJTwORmqJdptf73MHv6o3PN0a600WEJHIjXPZeM9
	 uSgMi9qt7gjq8B7nCnNA89sbLHTf1nNRfThenRtG4mNzKCql0HvG6bY5TIdPsf5z0y7is
	 Zyl3aRuCRJAXjj2/XRsOWlv0+lGXBWGMFIqAKhZE52sszUMF1AgooGyoWTu7Jc6OkHA7e
	 2nSq6YbHj4QHyZOI7sQf9ZMB4A5Snk6EXWTzouLDasQyqMDj56wDfG2CmZmWRHIV3Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="mO/Yyfjz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.2
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA57606A69B;
	Fri, 27 Nov 2026 14:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAA57606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mO/Yyfjz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7ZPXAsQrY6/rTBIVPUVmDbARx9TlrqOynJS8fQ0+JeDhaq60vPqtVZiBdFAvCXR1WEeLIZqpnP2wnoGSCQdAUFSZg+G2zcEFpPrBP9Bi4BmS8WmdsvTH7P4oy2tiPJj5p5i4C+q8JpiDolV2ZCRYtNTLldXRzIzq6dwP5K+7kN3aqWEFcljDzWlNfSAQqis7NaTUPxh2UsRLzYYQg9/KZBZmY9FfRarL/LxVIYL2L9ojTu5A2rQvNro9UAq9iGCdvYeQdT0GzdchtIBIzth59981u2T3qsMSHHpeB9bHcTZOet6Mf5IZGi757W40y0ngLkXn6qwc4QCfXrqbCV0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYPfv/yc7G+AO30gWq2ZkBCvSkxgX15UJShoAfnJHjk=;
 b=nHKw1rks5Krg+LE8vbPZQJd9/B362fqRIk9xwrMJkkkOBn7bbaXcUuWoGv8Aot1pvab87JxM4OipY8luKqKkVM5vCZZTl5RuaYORFlWlLY5GLHZ0rKplhNKmKifU/VrqAHMl1vL3AZmTsk6+nXQ7mrvt/UIc+uHzvRAFIbNEPc1mWcEHDLxtWD3elBe8re4W6sbOyXq/HsCFCiN3u7oWLM+Rydi6UlW759j6AXoRCjNG5JbFsJ9uTl/lAi/yW9tQEeIGlSadg9kqsG4RcdrAa3CAB3lEECKsI1L7AzLOuiHWjWxlF8Me9qIAqdqVzI2+IZsfnJkOUSTN+q40gQt+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYPfv/yc7G+AO30gWq2ZkBCvSkxgX15UJShoAfnJHjk=;
 b=mO/YyfjzGmQQZEJ5YodeBRUxypeQsX20NYG8R/ynyNY+kuJa2eqrOVuXViWUx5vNOQdYJ9J7svVD/kLYOprARVt5XMAXrLj5FM6/3sIwMazWtzOqj8wuNI6vVf6SmWIlOhzjQHJGk7mcGo3rX14rbQ+QXKfyG37CklvKwGFPL0habXYF1SyGuA+j2DY3d39+DuEe7tjb2ZB12eHdT0upGNsgHkCtXjxJYLWRi8bPrcnNS9BHoJZx0m7EZFIw+KlpmLBIPUNclhOn53xUKEr2gTKbZZQIPXhQ5aVHXP5oZVzx9Z0nCPXE0VRo+XIDgKYS854u6q8zKHBoeL0Yv1ytCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ2PR12MB9085.namprd12.prod.outlook.com
 (2603:10b6:a03:564::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 14:29:13 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 14:29:13 +0000
Date: Fri, 27 Nov 2026 10:29:12 -0400
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
Subject: Re: [PATCH 1/4] media: venus: use dma_iova_size() to check the
 reserved IOVA size
Message-ID: <20261127142912.GK114472@nvidia.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115859eucas1p1ae20b01eec39080daf19dbd71aba10e9@eucas1p1.samsung.com>
 <20261127115849.2780625-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127115849.2780625-2-m.szyprowski@samsung.com>
X-ClientProxiedBy: YT4PR01CA0366.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::11) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 073f8176-ace8-4cc1-b2a2-08df4c92cf0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|18002099003|22082099003|11063799006|56012099006|261028144727099003|261021135927099003|261022115727099003|261022113327099003|261022075727099003|261022105027099003|4143699003|261026121527099003|261026140227099003|261026130827099003|261021123027099003|261021130227099003|261102123227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	KOKjbrRBqJeqD3UQDuy7ZH8ndohUgmm9RmvWkAHDidH8ZBQssTIuI4WZewidQ0R5LszdT9jY1UDREwZU+7ZV6x2uhv8cIoEkXJH+cp7eAbuUkQnT7UCZcXh4qDG1MAKMywkxKPVJIskXtVSQh8gJJqKaekdsNBRBs8Y77LA5JV4ICguu9botj+5Crdct5Fjdysbz2+UDlLiMFaC8d+C1tHll/cZO35/YoMJbfJCycJjwfEpfkQUDiULRSAaU5K61Kxa6VrXm+bcGx0WkK5ltui8SXi2rnbegSpsDzunCgz5mu+xP8K+T/pM4sEi/R+AWHoRxZuUXST0Qfu0a9v/pyw9mFcx20K6btLnbextvlGyflWyuXMURPbsYTyVOgJslZhhFjKB7XrmbqCknMu9V3VoIIOlcSjmnU2XEK371xeMYJ7KlqcfR9uaOmIYqHQy6EWks3xciAzExz/CJ89egMbMr+xofTzKHj5k7+srOTWTCe+9olJ56qb3ErqHmVBz9PdtiptMnSn53YbEA+1fdpFP9p3AeK+6GbFgpxz3UQzjaexQ0XGSvuqREa8rz1gH1elt5q37Wjcp4fxUWmv5DBEnaKTHHy3vza5p0rjYal8uJJuDdclZ4RfFzohzIKGuSySL5Z3eaaAGMLwwHZfZJDsG+DTv1CdgG0llPPsRa4Qo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261028144727099003)(261021135927099003)(261022115727099003)(261022113327099003)(261022075727099003)(261022105027099003)(4143699003)(261026121527099003)(261026140227099003)(261026130827099003)(261021123027099003)(261021130227099003)(261102123227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?he5mU9KEWAD3b/nMb//ASzglQDdxQN5k9Ttxa4w56BQsd1+03bp2PME1mQqp?=
 =?us-ascii?Q?wzVS1CorMpcVJgBgPgdFQPDJNHVzCidnmRCUx3KTK2Tiwy4NiP1Ic6x4lM1q?=
 =?us-ascii?Q?Pwr71ybmEEKszIQhmjd0ZJ0aLmgdgOrS20X52HF8CIE30eiZ+LNdOLG3m7D9?=
 =?us-ascii?Q?7nTdWFkEot+Ow1e6Mx9uhp8/ylYlCcqEANTGnwNCF1I3N7O318LwKoIe0Yf/?=
 =?us-ascii?Q?K+2O2cOf/j0Vg4cK+7CYDCkgd8+KFxZNlLrOQ7lK9dQuNk8fezP6B9Pl9GND?=
 =?us-ascii?Q?JD4NJKbTLM4Ek1tZSQWjf75ePtaHRJI9asqutOsipc7W5ZOcv10e8+SLNDew?=
 =?us-ascii?Q?rCNIx2aohgwVZPjhm2PtcqX2gPSCScdq5yJ3ziP0Hqgqs98GsfASHILL4kQQ?=
 =?us-ascii?Q?b+JhI2UPGdVharmBzD6eSVEq9ntaZq0fd3mL4xbmY5hSHHFbLfDB6NchP5D8?=
 =?us-ascii?Q?7qwspdbT2Y8jwRGdaXNqMF5rD8NidGy1frilZwYGm/ejtTuWyQ8zsflSepao?=
 =?us-ascii?Q?UBZ9PBYHs8WClqpryLmGvZ0dKC78qmAGwFFuLMuoy300HqMpp4VzTxqzMTET?=
 =?us-ascii?Q?UuUbAOxQIxbTiiklts85+s0qzQSqx4ZnI6Xjhy5uM+qooeqvSKr15tL7jTBM?=
 =?us-ascii?Q?iuFXnWqGMMA9Tm1GaLVAwezF1bAGbjdQgLEObhNl9mGxTRwdcoiqyuVf8M/5?=
 =?us-ascii?Q?JbODMitVebkgCI2IV7ReoI0dXnxm0MUq9R/FYMwO2l7yBxdVbjYW+ekbUINz?=
 =?us-ascii?Q?DapvVXbsBTQA/QxP6MxKAXHqp1H6YRJwsEteuZ+F2kNb5gsP5vXo5REgC2UU?=
 =?us-ascii?Q?KcKbjx2NvS4YacNB7Fy3ydCyRp7oi2WvYnMuOR+bnqVJmMZYcH1KYl8Tud6H?=
 =?us-ascii?Q?rFl4/doGle/uNh5DjT3YCZCuCmzBni7sjoutVxMiaCWpDR0GFmWohdeoODoY?=
 =?us-ascii?Q?PddCcY32VMSQUWmB9koWG2TSugwLqvEgTlUwRJLDn1bmfRM1oGROGpJrN7pb?=
 =?us-ascii?Q?tC9zITG1WtlMLfzkM1ZoM9hyCQBAJeQcvbb4H4Pvpw9YVovAVOfc6t9wDwj/?=
 =?us-ascii?Q?a9imPGhw6NL7fP5EtwOeiiD051YtqrPrS1NxQ2ow2wJaS8kq6ql7utFgphio?=
 =?us-ascii?Q?VlJ0EL405n5pzTITNpdJCgMSHaZRNvQ5WXouynFfIwjC2ir8pubqgMfFI2Lq?=
 =?us-ascii?Q?uAlPYZChvlTFH1p7Actmx25rhlksv8kp3RhaLTxjXGcjfli/xZsWAaHB5Byq?=
 =?us-ascii?Q?oWcxgSWMac8T+RuSOufhCqIcZP+4b8Uxoshhzki9akj+cQUpHumWpinfvUS2?=
 =?us-ascii?Q?/Tq9hAod89ojJlah/m1nJJB11ymHy9tXhJToMzUrhrzUWym206eayfsEi6Oo?=
 =?us-ascii?Q?tAyQ8OKLGXt5QnUkCN7XL223cQMHYnluHSwpzaTl0xT5FBhsCtuOqhG8s7E3?=
 =?us-ascii?Q?noNuYa6h42bOMBywL/vcotWEjQ4xFkEAnZjPC/7xNUJ166C0AXLVYv0mjAN9?=
 =?us-ascii?Q?6Hau9AO0J+WLgWA8aAsF+9dZ2Xbtx27bn+QM+dq/ye3F7e9/VI+xBud84CgB?=
 =?us-ascii?Q?wYQHVaXtrdcX6xsX2Ot9Q95gHlOB/OBb6zCJJC71HZO+FwHpAHeA+mKwxKQA?=
 =?us-ascii?Q?yhQzjUlLJ8400+eaK6sPLjAAX5I57ewYtfhdyrInhxn/ch1vzccCE63eRNfO?=
 =?us-ascii?Q?fQn956+ZmJ/HLRsGqrtNZfGsr4DdzlqFsp6I/24Cm3PaW4AE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073f8176-ace8-4cc1-b2a2-08df4c92cf0f
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:29:13.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIWMwjWh/YdrC+ZeUyqF1qkNNElXq6oTbirNN5cUaukM4UaCEaU7b8+jtdIXgsh0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

On Fri, Nov 27, 2026 at 12:58:45PM +0100, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.

WTF is this even doing?

    Fix this by reserving the 0-600MB range, below the boundary the
    non-pixel stream cannot address, using dma_iova_try_alloc() so the
    IOMMU-DMA core never hands that range out to a real DMA mapping. This
    reserves only IOVA space, it does not allocate any physical memory.

That isn't what this API is for, and it isn't how it even works! It is
pure luck that the first call to it happens to take out the lower
address space.

We even had a long discussion about this driver and this need in
another thread and this is the hack job you guys merged?

And it couldn't even use the right APIs??!

Jason
