Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795557833;
	b=DIW1aE0/l7aNV4o6bxL+AL1w9t4l8zGkPEGlMgFWFGB9KbpcFGM3/EAWMzClnlQvSlUh
	 tip6U5/UaftJkNEcfPCG3MP5qR/yerTvTUqLgM9XWfDx4x1kYfbFXJjLPFEX6u2D7zn00
	 FFc9E+8eGTmS3KrNkFSKj9An7jMO2CV1iVGwzPWX47D9BYmOi418ju/2lStxueeR/l/sj
	 TUCOZPLdqRa8KZEFDeftoGpb1Z7z1jgxfxHJnFSbieG73VFKgTHKbM+7KPHmiIkUR0Sc5
	 SPDSLkAWkViaTwneW9VNk+bYVg9Fx/zeqBKywa8YiHRgIpDe0qsJ9ouEzScK+brJaQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=xeb5VSrynavhPflR5N3IlZZRKSWyy9MZtjc/R0aQhys=;
	b=JmT1lObXP6v3DwEQ+szZfFKYyetOFDGSHsBUJMV4jCNLSYeMjQTJJbCDafYowUXF7/qq
	 lEc7eceqq/Hg/O68OgEKFxGvp+zUzmcqLPy+1GPolXtenfFNAbhh5QKZ42MVSioKaPn2k
	 8YE9KJeTU36atXhSCgVKWCflh2Octq+qInTCnGtqGhfkufCkFSgFjVd/LB+ami4+N/wNO
	 opl3sMP4CuOCS2jbVq88gyxYTcbsF/POvKca1+3IeImgLnRrnycmhCyUDG81lyy8uKScC
	 /fBYV6SLwiMzerX2zFBSfmcnmBHVgdxk3G5TOCHBQ741ui9+/UCL84TzJHi8w+wpSDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B9wEWtQt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.59
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB436606A31E;
	Tue, 24 Nov 2026 22:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB436606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B9wEWtQt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZlXGk9e9c4QF9ZLb7CKpXq80UaBJPo6lCQyfwpuigNycppKQtXCb6UCl8f7gAtK/0nEf0ot3BdgmGy1WfrYnSu5WuS4fsq5EmdokkX5aoO0FYHYc3RCIcnhnzSdK2fN1TjwgwXhlgSNaLokOAzpGhcpD4Htepi8UHEIuvAIfPMEJ8kUbCo/ic2Qvk5/o0GCT2saIeWviJpQZpD+mfrIccd4eTni+aZhOFqjsG8T3v+I0WbSnecTlZqG9/SLzGHuwf67vA2qtUnogX8SpZem7nqKgJVYBJpM/+KtsIWmrut8dIVcdNeUlN1UCM3verV9vCA2ptNJrqRLHOHEihHcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeb5VSrynavhPflR5N3IlZZRKSWyy9MZtjc/R0aQhys=;
 b=pQo54GAo1x5y79rOyqF7gM+BjpWTB6IyOYBMeFYkYCD/8m8tcd2MsWDJpiTOQMNzqGYATs5rZ8RMpBa8YJ4p5OD5uJ69H8rzlyHkBc+ptieRvcOtYk9QNTJw8Le1cnkYXWOSqOfoRpizkEUmu2AJN3ZwvRRzUpdyEzxfEnbZ2edzFChn3aD4oHHiMo2krKpfjyNQHPql6N85CLd/rYsDbhWKg0c8WD5Qq/F/6ZYpLQB0opwQQipz9GWqLlIYy0QabXCjcMKP7aGfpueX8zUAz8fsY1ocBCNxO1Yr2tetwwI0ZjtuLrdFDtxWzVl0TCjOO1dIveoah7XbxTWCt0suWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeb5VSrynavhPflR5N3IlZZRKSWyy9MZtjc/R0aQhys=;
 b=B9wEWtQtcenG8ruBFT6F2Q7e7Ar/wVxD99T6dIbNr5B88OT8UsAdZXNfN0rcPYCepNbBFmk/i39S7oAP1JXh3Fg99P3P2mVCvbf2SUG6627JxjbEuH/ECx1oflp9iZAsbmysHHRiU8M4K74f0+ALYySEP/8pM2hZPFC2a3VS27kzsadcg62ieGAzYrCPFS6es42IU9oUv9F9dxlbZtD7HuiYyNPS+0LIn4QkWq/T62hTdiPqZE7dzsrJYfsQdkeIajikX0yTnue9q+uKipL9a0qfN58HlphYHqvz6vJ/OC2JZ8+EEGGDZmMPmjWyp1+CtDkRkOcJJc9tjvMZc3yuAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 22:03:49 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 22:03:49 +0000
Date: Tue, 24 Nov 2026 15:03:46 -0700
From: Alex Williamson <alex.williamson@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Anthony Pighin
 <anthony.pighin@nokia.com>, Dave Jiang <dave.jiang@intel.com>, Dan Williams
 <djbw@kernel.org>, Ionut Nechita <ionut.nechita@windriver.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261124150346.6bd3e909@nvidia.com>
In-Reply-To: <20261124212842.1934651-1-skhawaja@google.com>
References: <20261124212842.1934651-1-skhawaja@google.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fb8360-9896-4a22-1f8d-08df4a76d18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|11063799006|261026121527099003|56012099006|261021123027099003|261026140227099003|261102130727099003|261028144727099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HKqolz50Eq5Vtona0Ts9usW5othwdibJP3+g4v5vqQJNMX9baKTnWN8saiEG53wjrFOkQWmAeo8IyqqCHh/L8Um04MYTjZ/zqhJo3xGe6raMMrL3hgX1/4dEw/nj0GkXZcl9d7wAAle1+Uw24xbEVggFwAiMpEcyKEr7QU8joE94AKW/eQcBmKy/ezbrQnJnFxiCS2GL25Qk80kK69nCjxARCoyaZC87m0iWhnLkTVn0KdyRA3/MbN6Z31Ps+Jp/xrBr1xOPeeWlskF70f/DMAssOPmtSvX/bVxNJukE379pLopbvbWxi6W9UaYpFsEyknaYJL6Q4RMFsun2j/1av5CYi/SqTs2CJIdVUJ9g9tHD3J5BM5XFVrAKk1TNCKF9YU74lGc7U22l61qhX3worrlO+wx9yur9kMkUjzZvN6xHCB2JXtJgmHKQ1G5kuVosZ0OAX+M1ZvCyttx7EsoP+/oyjeYdVpiSXC68dUlsf2q9BhUbNRowAOXIm7XuOuz12o8NacEoJdoMLmFsfld8+aTD7AE3p8bH0x/OYPXJe4FtXYYgKtKD9Uoi5gwqZGjVAzQkQ+RDKmaxEmQjvkVzw642aEPqZdMp7rdhJp+hfIsjeN78efZcalf5Dz2N7llTRS8svymfvKTYTIOtxd/r8aJltjnVTH9gsbUuznE11+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261026140227099003)(261102130727099003)(261028144727099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7vdDv0synvoyic7fr+ijswHkzB1Hf8HAidL47oiaQXLj1Jull3ZY4wptP7F?=
 =?us-ascii?Q?Vzac3jRomNExhmm7xmBRrE/bm31R60fvRmwplX5u4XF1RPCizUJ0zstaTCjm?=
 =?us-ascii?Q?JefJL1bXyuD7sj1n8sXsNYNkQin2g2Zcvay2YjIc8UzLDo9qnggt4t0pIZUb?=
 =?us-ascii?Q?h2of+NcBZqVct4P45TUZyxssK3MxFE2CB7FjCaO56NMT/KRvxjD+5lqTdQUz?=
 =?us-ascii?Q?y4s3+7OCDeG6Bit8P1g1xAHKCCES8Xe21TLQRJ72amukNZbeIkXZ+XYm6z6h?=
 =?us-ascii?Q?+kwDlWsI5woOOWQMl0bFLjWfRo74Qs3TwlFIUImZcmdzws5xS/j2psz2UXN1?=
 =?us-ascii?Q?eFjPCkX5M8qRXraiZlbsCUPEqnd9wzz6iGQemX/Q9UaNh88n384mVc12iC9G?=
 =?us-ascii?Q?mtE/Bs0cIXpUM5gtNx/1WZuCrCFtkEltF7ibFwi9cjngVVkhXYseuTMaFbO7?=
 =?us-ascii?Q?yTHWGSZNrVqr2B0EBuXRXhLuGDRj5hBA40M8Uxn436p4Rf89B7ZbYFZOSKin?=
 =?us-ascii?Q?+pCcT6Pc4Ul4RB5kxnavTaBqPVOnNhwQWfm9dpjGtEgB0wUUAPpwaMN1pFcF?=
 =?us-ascii?Q?8PyZ7dHvM5vXukZPujmV3HbG7gVPsyyLrBcIPiusn7aNgDD7Zf2rv33ZiYVp?=
 =?us-ascii?Q?YiLAo9uDzD39CGVH+0nK4ZRvInHEwoKddQNYw/OJth9sNCsxMDK3keywQD1P?=
 =?us-ascii?Q?xgIzlBPTMNat0m4uPl0XVw4ZyqQlfE9ontFJiN7ZXYHjKOOlNelo/5i5yrVj?=
 =?us-ascii?Q?Di6Q2BvvJOxTJguSeFvEmZoX+L11ZGNqlue+GQwzcRTRT45vPeKY72C/vaVC?=
 =?us-ascii?Q?pgpCgfnjfKQPDzmzZoNFB1D0rqGb3QKKSFxJ++QTAbQV4N8Vp53vbx56KUMT?=
 =?us-ascii?Q?TkdpRHh8hPFDgmGw4m7l+hRtP0JmI3bRSYdPv7hpzqAyFmG8Xb+FhHIl1Pe/?=
 =?us-ascii?Q?6J5OI17LuY1dV4oOsJmIhLnB0VX8jEC4Rrnw6WzNZuZbLE68bf7JHmD/9pSY?=
 =?us-ascii?Q?lXj1FfwGxmJu6VE9pR8NO+hkL/BBkcjJbc20mWbVHbCdCYwLkJVZJ1X9mtjq?=
 =?us-ascii?Q?f0uQY4ksuocRr/9aRF9quC7ZxSi9+nJrqW5iryeGa6CvgJUrBM74FUgv9alJ?=
 =?us-ascii?Q?SiyRx+pChd9ysqs0EE4TolD99Ro56828lOIiodIK8F1EYBKYvfRzRT7xRw9F?=
 =?us-ascii?Q?62Q7e3sr1hsWV/ESq69rjqtBkM52jDMVe+YLg2Uest0rSGLfbx3CjTtkbBoZ?=
 =?us-ascii?Q?VP7o8J91+j7WIHoulLqrOK+Ekf/8lIpM4WfyvuVWS2ESyhdRVk6QX+qy6ir9?=
 =?us-ascii?Q?FAuxQNWsDILhHtdsDU9foymHJNhoDQORympXyAKXXNeJozWdIVQc+mS4aYTD?=
 =?us-ascii?Q?/m8gVbdIf6tpyVM0BokCt2UXprqhSfw7psTwl1g0Nx0jqSJRAODCtKsmrEGj?=
 =?us-ascii?Q?jynI6WhV+opzfCyL5GEQmsvEkOI6PzTp87ltuSTHvn+ljZxIJGuuZXzXcKhr?=
 =?us-ascii?Q?lKtA8QB1s7q8UnqqLq0oGy0DDMj1lWSqXiHeNtlJrILbqMk8mxt4bzToWKqx?=
 =?us-ascii?Q?MPe+8Sd61WQvuppV7ikIiIIKpK8F2/w+3gn7UvpIw0vPYrMtUd5yvW/Ez7lv?=
 =?us-ascii?Q?kh8XSl3OJMiHg/2+p1mCSodHqe/Zez4eKaBF8JFbBtvE8JiBemmCkkk8yUxB?=
 =?us-ascii?Q?FydgFT2JzYZqpZoPBVIVUSzyXLE+RSKUXmjyS0C/QvnyHzFqkW/duT54KpKI?=
 =?us-ascii?Q?8w6ikLBflg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fb8360-9896-4a22-1f8d-08df4a76d18a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 22:03:49.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYOpRoEWRT6ElT+WwUd9HTPxYBSYPRl+HmfgdCNFNd39nuDdHCBCuLIxPZrahAoR+D+BlZ7+Uhslj/hlV0Gm7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768

On Tue, 24 Nov 2026 21:28:42 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> upstream bridge before resetting the device, and skips the reset if the
> trylock fails.
> 
> All VFs of a PF have the same upstream bridge. Take a device with two
> VFs, both used by one process. When the process is killed, both VFs can
> be released at the same time. The first one takes the bridge lock and
> does its FLR, the second one fails the trylock and is never reset.
> 
> The bridge lock is only needed for a bus reset, which is done through
> the bridge. Add pci_reset_function_needs_bridge_lock(), which returns
> false if there is no upstream bridge, if bus resets are disabled for the
> device, or if the device is a VF. Use it in vfio_pci_core_disable() and
> pci_reset_function() to only lock the bridge when it is needed.
> 
> Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
> v2:
> - Replace pci_reset_needs_bridge_lock() with
>   pci_reset_function_needs_bridge_lock() as suggested by Alex, and use it
>   in pci_reset_function() too.
> ---
>  drivers/pci/pci.c                | 25 ++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>  include/linux/pci.h              |  1 +
>  3 files changed, 25 insertions(+), 4 deletions(-)


Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>


> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba8144..cc6647d091f7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5256,6 +5256,24 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
>  
> +/**
> + * pci_reset_function_needs_bridge_lock - check whether a function reset of
> + * @dev may need the upstream bridge to be locked
> + * @dev: PCI device to check
> + *
> + * A bus reset of @dev is done through its upstream bridge, so the caller must
> + * hold the bridge lock. The bridge doesn't need to be locked if there is no
> + * upstream bridge, if bus resets are disabled for @dev, or if @dev is a VF.
> + *
> + * Return: true if a function reset of @dev may be a bus reset.
> + */
> +bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
> +{
> +	return pci_upstream_bridge(dev) &&
> +	       !(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
> +}
> +EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
> +
>  /**
>   * pci_init_reset_methods - check whether device can be safely reset
>   * and store supported reset mechanisms.
> @@ -5313,10 +5331,11 @@ int pci_reset_function(struct pci_dev *dev)
>  		return -ENOTTY;
>  
>  	/*
> -	 * If there's no upstream bridge, no locking is needed since there is
> -	 * no upstream bridge configuration to hold consistent.
> +	 * The upstream bridge only needs to be locked if the reset may be a
> +	 * bus reset, which is done through the bridge.
>  	 */
> -	bridge = pci_upstream_bridge(dev);
> +	bridge = pci_reset_function_needs_bridge_lock(dev) ?
> +		 pci_upstream_bridge(dev) : NULL;
>  	if (bridge)
>  		pci_dev_lock(bridge);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index fcbb2da860e2..5dcbefd2eba4 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> +		bridge = pci_reset_function_needs_bridge_lock(pdev) ?
> +			 pci_upstream_bridge(pdev) : NULL;
>  		if (bridge && !pci_dev_trylock(bridge))
>  			goto out_restore_state;
>  		if (pci_dev_trylock(pdev)) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96..aee6a178a535 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_reset_flr(struct pci_dev *dev, bool probe);
>  int pcie_flr(struct pci_dev *dev);
>  int __pci_reset_function_locked(struct pci_dev *dev);
> +bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev);
>  int pci_reset_function(struct pci_dev *dev);
>  int pci_reset_function_locked(struct pci_dev *dev);
>  int pci_try_reset_function(struct pci_dev *dev);
> 
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
