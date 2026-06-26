Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF60379EDA;
	Fri, 26 Jun 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782474769; cv=fail; b=WSgrbOj5IneoLf0IuY0dLQZtEIzP8Lm4IcsrE6eys4W6CvMAUE2JL5WMqzQiMYZMGtaqfoMyPI/b5xCLFmEKPVH9osZv6mQKa+/iYB4AY2fq3Hr8DFGBZl2ceIDnBggodsUYlnD2iUuXnyNxtn4khrCc+nb8d1+cTaa2nkeqWtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782474769; c=relaxed/simple;
	bh=KWm+7jh5UZOdIw4qMDZOZpCVrHbATf7Ackl739Dz5fk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T15MsgkOL2g/0s5A3Nl4eMczLibFnQMxPcCZ5ITFgxfCGThH6jTlZtuafIjUUoUTsXP6j5q8/rois5aIlMmW53tZ37Ci7L6LBatH4mmcYPcoWnUndnOIy+adc+28Vo5e2RAepGncBE1WT3dboVJAV/lIWfPCyzPqa30D4bDc/U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3zn9PO9; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3zn9PO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782474768; x=1814010768;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KWm+7jh5UZOdIw4qMDZOZpCVrHbATf7Ackl739Dz5fk=;
  b=e3zn9PO9F2tJ2e+fZ9neChvTbwRmkvlqNZr0H6VaYhghBQWydefbjOzm
   F/dMeedQpB9+3n7+JQeL702Lt/zE/3rKVr6lanI+ZMilbHY0m9Y1KRQvJ
   IWQ8+11sz3XDOSrcaaxo6gzJVYMD/B7XOw8NizvNugybs2tBXkOjY+iv4
   7H5HXmxzuswZc3A3wuvW7Ea8/JhHGTUjx7b4jtRCD8ckWkGUpJKROM0Rt
   rcQ50tRr/6KdYiLsLUMy2fRQ6Z+Md8SUrw2Sz8fFhrGxtTdMzop90KIUb
   wiJV7Avw0O1rTEbCmIRfmMk7KXmBsb2wApiJOYa6s+Vvz/tuezZ+ZSuEY
   A==;
X-CSE-ConnectionGUID: 3i+VumPAQK+5nRM6c6IKuw==
X-CSE-MsgGUID: 9XcMVuF8R26SdAatUg939w==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="87168460"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="87168460"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:52:48 -0700
X-CSE-ConnectionGUID: sjCGpbT5RIW0+1eUmZ9A3w==
X-CSE-MsgGUID: NdIcdGI7T6SSdqW+59K7ig==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 04:52:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:52:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 26 Jun 2026 04:52:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 26 Jun 2026 04:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkH/Mcv13vLoR/ChH80c+Z/mZc7q5BR/oS8XgkXiLZVewo29BDIn3AlcDPpJirNsaFNxR5a3Ef9hmcQeCjeItjrE01U2sN069820QFcqk7nwXOj72qlJyigCsMzVk931hYucOjxulejlgCZnk3Vmz9L+uISbWXgkzkfhu3bGdh0zpJ6e7gbhSFc6NQzyWkHbJK6ufZvj4J8M7FL5RW8jDKcNm3isfwwep0J9Gq7T0kqYGhYLvApz0ZIvu2n3yNOtO8Y648jd654RJiHLtTIA/RWMbnr6sICiz6WX3UVNfxCzLaPGDJLaFs8rexm+yydS2boMEnTlasmW4IDJDsgCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJF6aJ/G4ugAeQKzcRfkBjUw5w9dj+2KJ0qfHvNGgXg=;
 b=pOfPT/ergVtJtP1wQZ0je/gVsEBgLIuPQalRfYfylmWom4qYI9hu+sgSo6JZFg0es0enIoKsxkauHVmhGD9ZCiT2Xwg6RZBv/uQwg/IJHimxIwg7Y+3M9IFdo0BC0VHiGsrzo2QGYi9jggfdwljjs8OINdaEjzM2Nx9rHdiJeT6gBiOoJ/TOOTX9KK7hIpLeVUPPYHLMGQOP5EZwRKncESXNYsMgGenqYaIbKQ+ZSbJeJJUD0cy1nzdQ3csMl8rrqu6Ub/9jxJMleyxZ7RI7Wpmw0fquYDqOidBgm/88MMB8ww9++ebmxbbiDhY8q+Km2zORlxUj8Xkd9jFSb6x4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Fri, 26 Jun 2026 11:52:43 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:52:43 +0000
Date: Fri, 26 Jun 2026 13:52:33 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Haoxiang Li <haoxiang_li2024@163.com>
CC: <elder@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P
 init
Message-ID: <aj5oAYiwxilMby_4@soc-5CG4396X81.clients.intel.com>
References: <20260624065955.2822765-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260624065955.2822765-1-haoxiang_li2024@163.com>
X-ClientProxiedBy: WA3PEPF0000051F.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::675) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|DS0PR11MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6ee31c-38f6-4ff2-ae76-08ded3796e81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|23010399003|1800799024|7416014|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i9kfWIkNIlMG7d3Ztaklo3dujXttS+HL7tM9OrNSPWuYwVVllmz8RbB+5Zep40lthG2sU5dBaVAwRg9sGvZL16qQJV3fWSK0uIzoSs9jagewUi8vrlOtwqqCvJP1kTDK1kgGpxfz+TTSdFhUes6CT44N0CxNwVI25I1/VYnoNUOikPc1CFmrRwKPeq3aUHfRJH+SOgbUWDTTMfBUVOfBHRwKpiwKx+XJuwXpLPbh8PSAsRH8Y8hT7n/0qYHlqIcOE0gEGWjrI2YbNuwIrcnpB20sctIBKuEn/n/YPGDblERVUD1konOLR0ZbuFU8yy72jpgU01HlJj1E7CyHlUriCHwvssvY+mdqpo6ofw4FaD828ZvIDE1ENOAMiilgX/r0GBCVHAS2o0Vdj/r/tWtToCCK1mbYY2CufYP+yq74Thc8rGBCHfC7FVY7GbhT6YdyxgrOhdLULmvSQNESg3c14S2VeRbERwKUx8h+ySSjS8wgtEec9i4hjLbStcAcg1p+t/2Fbbc4Epz9X1P6CTF8OCJLbH4cbJPXv/lzLhd0m6utckpiZUjI/9FIvo06l9KB7vkSc7krUbs7oSiGF9mba7zFfjaix7QSZ58Zu+vK4HnDlB7yeflM4hKkfTN5BjXPogQIkPMZ315miD1gPJPV+OxxEBul3NuGA87xTme4ryA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(7416014)(376014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YrpTbVNrw8/baTs/PhR6jEYFhvM5r/eAU9V0xKMlPddOgVj59DClBCtFT44z?=
 =?us-ascii?Q?qR8Q3OhLxiqT0PgY/bNhdKCILnLREAJXv0bBQvneXpE7IR/YyPho6Efz0lHW?=
 =?us-ascii?Q?1XwZxuS1/Pctd1PYmv5DBjGJiDnAwidYwXhidTI9sfBzvfZmnegbyXzSe2jQ?=
 =?us-ascii?Q?LjOBC2RjewiEHfapmukeAL2Use6d9tOOYlBJLny6JdpJJkdE0QWEVp+6KKdA?=
 =?us-ascii?Q?MA0B0sgJtzRIUx97wUZh+VLTpbkH2KLusZEsIAsC6DG+VWjA2f9UbuCGIfez?=
 =?us-ascii?Q?USDslGQnzQWMvcuNaVzAYNEKWWukBE6+2ptpXsLbajKiJtLUe4TGEfdmt+m4?=
 =?us-ascii?Q?muaysA94JY2u2euCPUTDxDP6rJGaW9krLBGKCbwdGe85n6FX+ril36r314X/?=
 =?us-ascii?Q?x++aff26hzlCI1SPe3SijOntbLDtarPmEAtGfaBLXN9ltEs9g69dUybQ+BmD?=
 =?us-ascii?Q?T5r1OUiPYf1hkQF6QjBBHg5G6kHvCXyRNcZ+ixiGCr5PHc8fR43M9gd9Y2Wf?=
 =?us-ascii?Q?oGlSO8Pmj8IavsOSZBfKxPmqxHQcPSLVpGol0ZW1eBEU8+AieFJ0zNMeyE4z?=
 =?us-ascii?Q?9i1sFoygSY1tiswLdLoG2JZmNu1ayErFfYHIpgCbbizIqI7qkUAHQynUZW9n?=
 =?us-ascii?Q?q66VvtbkxJQ4S2sJDC4agN0gdOgm08AQYWnKWG59I5YBMCOJI1LfaZSGkCdd?=
 =?us-ascii?Q?SFw/iBBw3L9a1be2t3Ej27Qz4+Hc3EvQ4LJiAIqkXOmvdugquF5khflcJ9ZY?=
 =?us-ascii?Q?dhBgigtgQ1yx+pJ/AvjjvadlR8CnVIaHDIVzSnGnhQ42/SMLKniBuQWJAyJ7?=
 =?us-ascii?Q?pXQjqL40mmvcrKZviYG9nf2VowMwQtWoyDHEQURzz+MZuEg6BjD5R7dg4fPV?=
 =?us-ascii?Q?R/g5qT4glOuQ+b2L/sHRUc+WewMqppEdY+5sOb+ZC0qoIOqzRLd5YF2QIOIz?=
 =?us-ascii?Q?wnouyj//7qXTSdO4EPV1uSZr+DqSAWGPLymYAgpbuHQH+luqIuxH4UyVTWO/?=
 =?us-ascii?Q?NJAb9TJoi4F1QVgasZ4+rehDfZxINS3Zydml7fGe1i4c1UI0YH4HEHtxO331?=
 =?us-ascii?Q?R8ppAkUyE52/IuyZTjFf6oHVnVtyPk+gN86W8oDfM1ypJy+7JjphVdKkfpuR?=
 =?us-ascii?Q?aQjRFkmBwd7A+KMXvOQa0XJPX5Ma1Pg1Oj117Y3IOBUoxxGm+hCdb+xHkvCU?=
 =?us-ascii?Q?VdI9Vm+M9PtG/sUM/+0vk5ek4BT8NOWgQapBuf4QEKU5uFUTPRFFRO24DVJr?=
 =?us-ascii?Q?70KIUVmUQI8fkwHdlDvVlC03PoGbMvl+P+j9YbHeA1iNgRXlphfMvkCq+e3W?=
 =?us-ascii?Q?pq8FPYsan1TGiRaTLIgTq08R6RdO8xFEDnD7zL9T2CuC78JgnV8QZraQuOx7?=
 =?us-ascii?Q?Eu/4/2CwSD+EETx4IOPscQXI++EfJIbmoxNpvXC6U9/ZafL4lijisxCbePDk?=
 =?us-ascii?Q?N5W5rx/T8FTjvXN1mQAq7AeSfBJnlcXVYhI0xyIaUejkXfpTuvniipi+B56i?=
 =?us-ascii?Q?5hZxSiXBIpq/z552D3RVxFDaHk6AaOU7Cs0+YebcG4dytiu+kiaNRlARIksZ?=
 =?us-ascii?Q?QGO5IunT8+G1A9ij6xWH8lWvE1nstdlqzd5VG81uxUf/HFIxbwdVQg91hCyk?=
 =?us-ascii?Q?fZRL30Ab2iKnD/Rwr4J/399CE2tr2YYN+5g4s0f0wr29Mch4QVIsQokG88YP?=
 =?us-ascii?Q?QDrO5T3D9nm0GGCG9ufX/mhAeM6s0NsGo2sQ1g479wmmUboa+IJtS7BvxsTW?=
 =?us-ascii?Q?qR37j4BoG4mSyriSrng1dtu8vCzPJCAz63u28HcrBNoeTLE9KU7FnvC2di5a?=
X-MS-Exchange-AntiSpam-MessageData-1: iGzwl0mSVnXumr3/sseTDnLWd6Oz+jrzp1M=
X-Exchange-RoutingPolicyChecked: CfRiz6EWax7xuE3CoYMCLmABowWrznsLYUcVVJOfKAmZ0aSKUIPYLSVCH7IDJffLTaYAuKe6Q+fc2UcMTlrYFRoXTRWxuok6UttDYsCNo2vAVHzIaAf2yq9Z5UHk+cwenz7g6MOhnJKNWOWSpf05OhR0b1bVW7PRVuz+aCaWu9deDRs6joS/Rng40smobCRN77xNVPpTRvSL2xgEi0fdbJQdlV8Fy9Lz67gNAOygTbZnligrRGPWVopavSKbEBysjb221z7Tkn2hJ+TYwujcNA3GJiGeTRAi5TxHheeH5rlA8MnwjHT+GJCtB/VcdZ56T3SH6nAHbMSPzLk3AGN5xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6ee31c-38f6-4ff2-ae76-08ded3796e81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:52:43.3335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6fKUUTnGU7pbgR+ugcL21IeQTZha1OP4HRiFBa7h6xXhb9iydOhKDL08ERHLfIqs4LfN5okO69KYis0WM1nVI2J7du5F+uOzxcLNnBeo4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 02:59:55PM +0800, Haoxiang Li wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Release both handles with qcom_smem_state_put() in the init
> error paths and in ipa_smp2p_exit().
> 
> Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
> Changes in v2:
>  - Use explicit qcom_smem_state_put() calls instead of devm helpers.
>    Thanks, Alex! Thanks, Jakub!
> ---
>  drivers/net/ipa/ipa_smp2p.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index 2f0ccdd937cc..331c00ad02c0 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -232,19 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>  					  &valid_bit);
>  	if (IS_ERR(valid_state))
>  		return PTR_ERR(valid_state);
> -	if (valid_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (valid_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_valid_state_put;
> +	}
>  
>  	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
>  					    &enabled_bit);
> -	if (IS_ERR(enabled_state))
> -		return PTR_ERR(enabled_state);
> -	if (enabled_bit >= 32)		/* BITS_PER_U32 */
> -		return -EINVAL;
> +	if (IS_ERR(enabled_state)) {
> +		ret = PTR_ERR(enabled_state);
> +		goto err_valid_state_put;
> +	}
> +	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
> +		ret = -EINVAL;
> +		goto err_enabled_state_put;
> +	}
>  
>  	smp2p = kzalloc_obj(*smp2p);
> -	if (!smp2p)
> -		return -ENOMEM;
> +	if (!smp2p) {
> +		ret = -ENOMEM;
> +		goto err_enabled_state_put;
> +	}
>  
>  	smp2p->ipa = ipa;
>  
> @@ -289,6 +297,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
>  	ipa->smp2p = NULL;
>  	mutex_destroy(&smp2p->mutex);
>  	kfree(smp2p);
> +err_enabled_state_put:
> +	qcom_smem_state_put(enabled_state);
> +err_valid_state_put:
> +	qcom_smem_state_put(valid_state);
>  
>  	return ret;
>  }
> @@ -305,6 +317,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
>  	ipa_smp2p_power_release(ipa);
>  	ipa->smp2p = NULL;
>  	mutex_destroy(&smp2p->mutex);
> +	qcom_smem_state_put(smp2p->enabled_state);
> +	qcom_smem_state_put(smp2p->valid_state);
>  	kfree(smp2p);
>  }
>  
> -- 
> 2.25.1
> 
> 
