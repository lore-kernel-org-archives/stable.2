Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403E3EFFA7;
	Fri, 26 Jun 2026 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474305; cv=fail; b=XbWph0qCujMUR0o/VW0wzMGvTBWQ80xPUIwb7GJXtTJkpVd57S6thdcZimiq+5x8aFOeNuhhKAB5evZPqqBscoZwCsWwAnADu+3jOmyZnBN7T5wJ3mwpU/xdE9kpFujOTkcD0RwbMmEGtqN1Z1qp08LRlML0sPK7sY8aB6ksIek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474305; c=relaxed/simple;
	bh=1z/2irLWAYvKejwSdYEVEkV1kF2DmufxYXrYXyu1RUs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oH7Dz3QFldkpuPykZ4hIwcAxthlHQ1wXoCXDt+cp1W/0zf6vi3Km4o0IFuZbUXxqSSHGmqeIbOsg25aA3YEFJlYZcyn+9A/pdnXgPikyCxPGH/wUL4bIazMVcZUn4yMCgvOg200hZ265fAyRToHpO428ZNqRenx9Cs6xWIc+fKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQKRnGQA; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQKRnGQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782474303; x=1814010303;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1z/2irLWAYvKejwSdYEVEkV1kF2DmufxYXrYXyu1RUs=;
  b=hQKRnGQAe6NKcXWpQ99iFM+ixZb4MEFCc5MFLYVRtNn1t4VZSbrGusRp
   kMosuwZC43i0mn/PWFAUFPU9kRUCNNqeczPhBMZKiS1hxUvthGBDus/oE
   FcjOtrzS7gMakVvghwVO8Cu2iHDqaliP1zjFFIYmvbx9vVQTzJVnXKtNQ
   zd/bBsMAwQMJQF6dPXp7zv12x7HnKvde/5OMJLeb01ZYZVTfA30s8pnft
   86c4ii5vb79btkAmJ/DDioVTBAOcIfh2Z7WSSOZZ6nZ++T2ZHgaz13vNF
   uHUpmJ0Wm90NmhAsSqePtaDL/ufssXZy7mEXGaI5VaYpUDrk8MbZ7mTZR
   Q==;
X-CSE-ConnectionGUID: HKFCu/QPR3WBpo/gd4pFdg==
X-CSE-MsgGUID: UaEU3GXSRbCIeglfhgAtHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="108812314"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="108812314"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:45:02 -0700
X-CSE-ConnectionGUID: kivKZSd+QeCtpf9Ui9tZ2g==
X-CSE-MsgGUID: 3TkKYC9cSt2EeUAOSHUdWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="250923625"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:45:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:45:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 04:45:02 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.19)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:45:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPaIooHBoI5cgSnxqTIgeN8abOPNsItd6nljBaFnvWvpLjiBt95h8DIj5BbA/lCW0af279yzvn5f7C98Q1j+NdU3mGfaIc6fQZmHtE1lIK8qSHGvy0s1fvTdH6tiRNnhZn/AbtxFn94O6rM28MuUM9trLWjWxxuzQZxv20hos2pWeCktj/LvOyKBH5lgLh9B3bRHqcmGCTT+6OmwKgquyU2A4YJyjKsny13BV1mCcjEPfgiB0gdm9I/AvR17UlA6HDO4cgzJyZIEk8kaYbKkzJvx2C3U2zGq0/A+Jnk3HmzjwWdJqVTLVgRiUK8SnT69BBXCOMTFvKHNsiGjUnfNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMxB8c5g2Ae+AZJAb2byTOUxdJLuifa+ajxMcE8q0o8=;
 b=Ht3bPguIGrHfteuqtdrRDprk4Eo8wNcaRJ0mc5ossvaXWRXiMZcvA/o75iHIhtpOwUAGgql5rGhOh7sxxb6KjAus9DHwJcXEKqBwdCOEIOUq+iRZjLKH/1HlD4JXRvUVfIgIP6CQOHKFQwNGXK2zqdIzA7YA1ZcTHSkeHAYPA0aokXw/2dqmM3ekR7nbOV8WBhUB//kgTuWCwck0Pcn0twMlpfnoidO2LwxAu/lOjm+Q4H3NorTmLkAYDM8Y3xRaL+6+b9QxTbZ5HsOuzQagOzvjGZCavUs16rvE2JIv0aslU45fvKkGgiiiiaSnzd8owbRSkVtNXm4FaHl46L4TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 PH0PR11MB4965.namprd11.prod.outlook.com (2603:10b6:510:34::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Fri, 26 Jun 2026 11:44:54 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:44:54 +0000
Date: Fri, 26 Jun 2026 13:44:46 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ricardo.farrington@cavium.com>,
	<felix.manlunas@cavium.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: liquidio: fix BAR resource leak on PF number
 failure
Message-ID: <aj5mLt728cs2Wswx@soc-5CG4396X81.clients.intel.com>
References: <20260624064013.2809570-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624064013.2809570-1-haoxiang_li2024@163.com>
X-ClientProxiedBy: WA2P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::24) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|PH0PR11MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dc013c-0afa-4088-36b8-08ded378570a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10070799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DWgio7CC+DO93LTLxGmAA7fIQ6M68xVaH3B7Z7ZQH76f8p6G7AYjwHNMCoiZahpfpxrmJdIdoKwV3yRNt0P11OqvxNyr5PWd6ljR039BRnRK12DRrvbAidFHQLeLmzzgRM3jUrOf8StwnpEzF4Im5mFMJhgYCUF9UawmWIozQASH6aNEhWDGkfKOLmz8r8Tbi/ViPgAA3Bn8pvvl+MxP5impyaYz9xsS8ih9qdqfgN8eh3P24SxjMYTDeRDmUs8RS62JHSIOlMzcLFmlsA39LSbMnJtFdvrdcvG6IIipr404K/1wvjDjraUvV4SSAuRS/SaDft2+31pMAut6WveENmi9DX0wYUAKAZQGDBTPBgZpJ77vPKDEuOm8uKsfyXIszQlIkxTBnEak65CbH2pD5hQU1ctJ8yYY6SsW2R8tqwNVRIx1Qs/0DVuKnAzMwt3FXbvXJvMD2DImDa1D28cFICQZ19E8Bjwt+5vCmG7I6bXOjREZJ3C/qpBbM6BuJFS6V6TxgL7ifdQ/UIwgdG0XHe+HUJKi7dyUqgH0XeD3UaYTGqkclhq35AgI97jQAFPzkOGuxxwlNjvD1ms1htwIxUg2CWsWojANnUkXeB7XGVEwERcKGaM9RxWLdtnU/nZjNXHGDBVSCL9wtn/0N44QViCasf/pRM52iK1/gimS9eA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10070799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RlqBvLOQzhUebd6Cwe/APyHm5nhZuVHjQHHhnus4jgjTkb20gFofZIlBpawS?=
 =?us-ascii?Q?WG/3aGosO811WNT6MHkA6CZnUPeahBscO3/xSqBVG1VWAYLv55zinEIWFKt2?=
 =?us-ascii?Q?JQt+JUnFB/fKfLazWJ/lj0sRoSDXzlTzCaeismG1Es8+I7uuRUU24fZ0DUgI?=
 =?us-ascii?Q?HcSknjUU/bGQ82xdB9vaUT3xLd5rHxky4TfvMfuWqyhtcQ7c6FYa6PjNZ+a8?=
 =?us-ascii?Q?D9biOy76GKHzYAZNCUR5Epq8YnYhOVtKy76h51MU5/R7rGBUUzTSzJ84zlD6?=
 =?us-ascii?Q?VVOTLz2g07KVW2/ytuYYWZMS4z6AQkgd5Qkkr8DJOVm5QAOWLpxap2sXgnDv?=
 =?us-ascii?Q?fS4fXLEa97nMkialdwWFJT+FhcK/OVNitmHM4tL+3dVDryu4/Jqj1ZxWkSQ/?=
 =?us-ascii?Q?VtDNVkURTn54eH7ssTZ5WUPSHXScdayr24bxxsn3dqwRG9TzUjy0EyeGOwsD?=
 =?us-ascii?Q?18JxMZy6x7er1DINPe7d8Zis6WT3GlVRxrna8tIfcuAP+Wr4EAQP9xhN8Zbe?=
 =?us-ascii?Q?fsvBr8uXvCTSGAAfhbHrC9fxWmUYcRNtATBqhnHSTldFbRNcvXZIJqb5so5P?=
 =?us-ascii?Q?imneTUnedd61ggERc5AprIg0rLEGcGeMYPYrh3RroZi61ocxzBEmpZlbEAbX?=
 =?us-ascii?Q?i3Cs2menDiqxEkGCd4GfZ+q/wQd79uzNgpRf/jw1hNj6NMidsFzstteAp7xZ?=
 =?us-ascii?Q?OVcY6u7efSyzH0AVEfUtTAECh5SaUwn+YohWS0ZS2c71q3lwAYzMv+CyA8G0?=
 =?us-ascii?Q?/d+W8wEm4I4A4Ur8sIRTHYYew9enRfu9I+hk5yfYKs6dI6PhNid+P29q+f58?=
 =?us-ascii?Q?m3IMl0lEMp6JI+utipyOQNkyon91oWVdAN81FYM5N+OjdGYSOhpkHkClbP06?=
 =?us-ascii?Q?itJ5mNFzpBY22Lp1XkWnrM2nazwl+1bc0NdrsmBft7vuzbKbWkdAgu1kmvyD?=
 =?us-ascii?Q?tE1/TOhZVV6VzPKAelXe3ytSZZUaNHlnhif3H8TFo0DqSG3TwWnejAB/o1r9?=
 =?us-ascii?Q?ojwcVS4uRInvEAtVC13ireX4DXYF9J2Or2+HuDSuxLQ4l3WUms4CTYKYzNko?=
 =?us-ascii?Q?DwmL36STdDrU8q/E+/LBYiCCGBtZmFER0M/hBD2c/uOFlzFhLcLejOecY32r?=
 =?us-ascii?Q?AzdXJFdMddpP5zHb3bXHVDqivjqkKEWesfuahMDBpSPHGJLFOnQpNmRihml8?=
 =?us-ascii?Q?KaW8w7izLRY8Q4Vq1nJwukIhR/PiMKh5WgXpoWlPx0f5eOS2WNvaV2O42zqg?=
 =?us-ascii?Q?Bu0QFE0iYHJv/b//+9TkYv3gKAkjQv1vj7zxEZZm0HOuFZZ1EXPykBDHCBhD?=
 =?us-ascii?Q?4iwrf7BntqQPUuJzvKhYqYfuaw3WGrt0zwKTManXFNHS5anh+TnjjKD62c2M?=
 =?us-ascii?Q?gEk3RDcO3A1m7a3ocuYqNsmv5wASMmUfeT/RsO+b/lpifzB2yk8scJm18NQ2?=
 =?us-ascii?Q?JeV68AVf873JjpUaqxGXjPK5GH47/nNxdpg+ko1HFqMVUccmXb/R81JHKcfR?=
 =?us-ascii?Q?zoDnCPax/GMp17Anosrbth9Kx6QEh20m4jXu8tRAN+ZGInRLlscmwlerGXMR?=
 =?us-ascii?Q?YB1rb2PxAcs9CM2iu5MUpRRYFi+CeZ3knnYIfOONf0TmZiEKCLjeB88Tl7oR?=
 =?us-ascii?Q?x4pNSTO/zgZV4yRpQwl5FMbUoDwpx/faLmPibIdvtfP7t2MyEKOarCXZRqLl?=
 =?us-ascii?Q?yWkUM+fOcyuKL6kmyoBOApgqfJitDvCDBmWVyeBvQFInO6FnWOhYgR0IiQ9X?=
 =?us-ascii?Q?1M4dlSyMJ1fOreKW55xBmyiisO8ZmkqHe8gt3w4xSn/wCmp//Ff8buWZMcqL?=
X-MS-Exchange-AntiSpam-MessageData-1: lZ3irkvAHzwH664zZ7LNzdkLRUC74GcjdZ8=
X-Exchange-RoutingPolicyChecked: XmGNlKf9RZ4Kx+wyOB+El+/4dfoJIcuGGLngVQaMgaHlDdRJ9GqGbk6OEW5gLK4N5GZ+77FXg8m7RYV8VmacLqeUEJF2q1leIX82soRYIgtaS/wPR3/c+luCtkmLoul5kepP5CzPeyOrgaiXnMuJkc/29ZhY0Wy/NmTXSFawcFWCKTm02kGk3uk3+RUKa0hCDUTRVrNr4M73f4itTxvE2Biu9Bfpt6WLBaR3QxPwwHNBTrl2QAJY1PIPj4TEhRqO8JsNlpKBPSoQx9trxYuypckRRtE8PkjXxoG4EycZ6ZAlUHQtKYOxGV8omegUP/kXLXhey3IWPE5Sq2Po7M6bmA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dc013c-0afa-4088-36b8-08ded378570a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:44:54.7776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SG0yOyJBEm23v+kJ58rJmQnFuOPd3PniB57R7rPPsOhC9rsrnQJULBlVp5mmR4LHmNmvzrJzDo6ClIm9bFWVgvqLzWXSK+LN/FAhTuvn/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4965
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 02:40:13PM +0800, Haoxiang Li wrote:
> If cn23xx_get_pf_num() fails, the function returns without
> unmapping either BAR. Unmap both BARs before returning from
> the error path.
> 
> Found by manual code review.
> 
> Fixes: 0c45d7fe12c7 ("liquidio: fix use of pf in pass-through mode in a virtual machine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> Changes in v2:
>  - Modify the commit message.
>  - Introduce goto unwind path to do the cleanup. Thanks, Simon!
> ---
>  .../cavium/liquidio/cn23xx_pf_device.c         | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> index 75f22f74774c..06b4424e778e 100644
> --- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> +++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
> @@ -1163,18 +1163,14 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
>  	if (octeon_map_pci_barx(oct, 1, MAX_BAR1_IOREMAP_SIZE)) {
>  		dev_err(&oct->pci_dev->dev, "%s CN23XX BAR1 map failed\n",
>  			__func__);
> -		octeon_unmap_pci_barx(oct, 0);
> -		return 1;
> +		goto err_unmap_bar0;
>  	}
>  
>  	if (cn23xx_get_pf_num(oct) != 0)
> -		return 1;
> +		goto err_unmap_bar1;
>  
> -	if (cn23xx_sriov_config(oct)) {
> -		octeon_unmap_pci_barx(oct, 0);
> -		octeon_unmap_pci_barx(oct, 1);
> -		return 1;
> -	}
> +	if (cn23xx_sriov_config(oct))
> +		goto err_unmap_bar1;
>  
>  	octeon_write_csr64(oct, CN23XX_SLI_MAC_CREDIT_CNT, 0x3F802080802080ULL);
>  
> @@ -1205,6 +1201,12 @@ int setup_cn23xx_octeon_pf_device(struct octeon_device *oct)
>  	oct->coproc_clock_rate = 1000000ULL * cn23xx_coprocessor_clock(oct);
>  
>  	return 0;
> +
> +err_unmap_bar1:
> +	octeon_unmap_pci_barx(oct, 1);
> +err_unmap_bar0:
> +	octeon_unmap_pci_barx(oct, 0);
> +	return 1;
>  }
>  EXPORT_SYMBOL_GPL(setup_cn23xx_octeon_pf_device);
>  
> -- 
> 2.25.1
> 
> 
