Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9D3597B;
	Thu, 11 Jun 2026 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138438; cv=fail; b=XQ5S4mCFhcFycgmumtWxSTq1zHN1aKQgmxfPC4zjMS1NGeQtD9U/CGLiMuUJZHWG4Rcp2jwWHN3V2CARtMQ7dZJE4F3hkYKBWQ/7Dlz764GLi9R9tc+ONuGixU4o16JbvTpPV4BgocGk5MrnTkGxdVfCPlvGKy2whRbbN4Rsa9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138438; c=relaxed/simple;
	bh=eJYrTvG/rcJT3Qk31r2BOBlP5DFeE3AsMvj756HqgYw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N6bhHyNkITnlVNplydyqTH2piYVtruRJt3RYuGS5n+LhPakQUXTd5x7mlp4iXFu/eqWYpIDvvvckYvbHncRy+2bmY9xjVJY1NPRg0hG/gUSzIVgNKqSwyD2tyMkO8ZHNgnnGPg7BRlOLQxeRZQAoBMjpN1+AkE8eaFl2565RuVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xy0l/eNd; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xy0l/eNd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781138437; x=1812674437;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eJYrTvG/rcJT3Qk31r2BOBlP5DFeE3AsMvj756HqgYw=;
  b=Xy0l/eNdEybZryRUlHw5obHDKzsEge+K0tgePSEhT0sIlFWuUAk5Cg8L
   +199wcChOZI5f3mQKynnbiukcTacG3OESM4rtt4PZo/gRslX+l5li6A0s
   TVfYTh+5XutQlfAbKdQrhCtqrN9TsQWf0ak09T3EcD6abGUPk6HCcDrly
   CmQtEu4cV7GPuyIMc9iU8H/BlFHPKB1KOltLPl5hihHUOv7340KXwHmAs
   zNoPlBXvfw9cJFIhUwNINdValygqlWq9E5N2Hjue8DWRmZb6Vdey3NvKt
   HYzG+adGgylvSpklb54eakiX1aaZaZwrsIV7o28TP9vDbmy9I6ed3ujRw
   w==;
X-CSE-ConnectionGUID: 2tfMjWj0SuWtPCwAQ4KsAg==
X-CSE-MsgGUID: OFy0xb8JSMiZPl6skFqC4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82055407"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82055407"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:40:36 -0700
X-CSE-ConnectionGUID: 2GqfW+TKQX+SYeCuV00PJg==
X-CSE-MsgGUID: bBH3G2MAQSWEBIPOdP1QIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="242185994"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:40:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 17:40:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 17:40:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.63) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 17:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlTfamH6SsLiwfS6MK0GUrWHR3yroxRYm9XrZJSIy3qiLGORgbfTplEcOox67O/7q+C67+8APYgXxm9dTGYbxi59Be1gRAqnzJ6O1qeJloaI8rSKeVdDZ44UHem8nuZSxcg0vFzzMJV0KWVq1x+L145G657xY33Lch3yVc9TPEUJybAB2qZ00NFin5p7ZUVbBFeMzIeelJSBBesML+IkuWJ3QuxWQLtRpYh01g5dewDeifXJn4tG/txgTuagirNIrt5uioGO4KuV1J9ZU0n9H0aLo3F9NyXkkT0hCqNKvMUU4c7CY1KHS56T0qe7SGJJsN3CRV4biHJ54AgQFFz/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/yTvSxaaxSn0Kn7PMX/YvI/TcQO2UCJOBErYwR27FE=;
 b=Sj6ON32/GWbXVDuePeYnumFvmxutBYbRKLX7zWRYwv6Kk/nHnZ3e4GLmknv4dR7la211skvkUcZmFun/qJuzyEUyiU9w6alaFCHMg42t+7MprdqyiIC6R3MTTx9TkKJUrloLaxOFzvi/ZDXcYJ97ePk5z49EGb6NllGSrDiHyfTyw3VihSx9Cqf337wX0uNpHFOluUdtv3D1CasxJAzH0lYq/N/XsU9lSwJc0ovMZklHb8FPqLaKyVG+0rhcWGLwfMkiSWJ2+pAs9+SbXapTYuEC8PDQ6CKv+87yHgK+8+IhvDaVVR2x1Zcm7Up1nA2c9eAKQu5GAnVwiPsLcs1sUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Thu, 11 Jun
 2026 00:40:34 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 00:40:33 +0000
Date: Wed, 10 Jun 2026 17:40:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: fix refcount leak in xe_range_fence_insert()
Message-ID: <aioD/pNpMOvYnNLl@gsse-cloud1.jf.intel.com>
References: <20260608061540.121355-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608061540.121355-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS7PR11MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a40a37c-9407-463c-70c6-08dec7520c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uRLwJo4KeRgH83gOKU25DXAFCEkZPHpP+aShYguyaXYqIL6uXSDvrpEGMPFcJYeXFmYZQJEb1jUJFnBHS25lMblZKIju4KtEgkd+Nfq8YcV3jm2F56LJpZfeW5veVYZeOJBqGFvA+Qxzu+/7X1z2mLRxcJ/vrd00I1yiZunisWGCuX5xtFck5pu1eEQtMS9MzQ1ZBmpBEjJTpmh6sE8dSpJqlQLbqKZZ7lkfEYNJtRyZsYC7vEz0OLCPIpEYdp1BozYl0FxG1ykmdenayUzf1ddRUjuD1eEer8HspWLqCf0i+9hcGUkiCEjQKFrgYq2OHYXWtHuTqCqKDQ0DWvXwXjYNmDbzeX9/mKLCA1Bzk0JFdoLm52ylI/H75Vu8RelwoJeQcLCc1m/P1uIkr299XC8qJfzLLO+y0Wmisgb4NMFNwddRe7WoszXilFpwHo4lldpYChhnq+zt7NfNEaDTrCJKU42mzmWlh0WQAcXu/vXJeSNZam2rTQTCm6mRVVHdh0p5zzyMy3WOV/fZsWx5UTQPADctInkPQOpy0bjec1Y5i6/L4ApDRN0BeNSZWYpkcq5SOBWBhrLn4Hsn1CYhSmlMISVQ+DuR7uZD0+Y1SHPizZxKZTWCznq9vs/3bbwNPrkhpiiZ5scc16m7hnyNtGM7dXCjNJkijK/MgKt95XH1H4fWfxGw02t9Mo6KUeeB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avLUcJ3g7flS7PJ0wdR2TFuHhznZaVxpe42KjAJdlOmCddooBddVdWe/wZua?=
 =?us-ascii?Q?IR+3/G+T/cxJLnY1wc2u8C+x9H1SHpyTZATq7gby/eqVsQ6rAZtPi7PloNqa?=
 =?us-ascii?Q?PZry28rgJtB06ESvxzsaeNgqbazmvRtoIQqshJJhI1rfMmu2OyJYBeo7BW4M?=
 =?us-ascii?Q?+vWGs7mFGerYY4x8HgPEbmYucVGHayi7b8rniShrahpBTSSG0c1iKCUBbmxz?=
 =?us-ascii?Q?FQ3WyBaolUFwBn1IUAeAWHnYitdv7F3u8BM11zRFHVotzohwDdlYOp2iDEYW?=
 =?us-ascii?Q?5OIASLLwFHGmYQ1Vut9uZD3W2FOCHrrPWwpfJLqqdTkq1eUV/Q+RcTJKhqLP?=
 =?us-ascii?Q?fn+7X7A2zZXV5r6XGKzYPw5ukfR6iMHFrquTsv0iLwxVN4KfNmierfYakowM?=
 =?us-ascii?Q?teRWO4AYgelm5Q6FtsCXbcaDx3NkzhKKjIJdhdbB+nOTPfHDNgqUszOL/8iJ?=
 =?us-ascii?Q?VLOqxH/oDUIMyf8BgSkvV1cRdY6wyWBp2X20NWyQQMpW0sCVQTKWXGavs1ql?=
 =?us-ascii?Q?US4aigv0V0sLrWLMFaGE0K9O0oFjmcEvWeyjx8ljdmtGU+YgvFaB8+Eem5+I?=
 =?us-ascii?Q?vP1H9KP1ukxhXqD6qNu9lJeCDLTL5Je54bgX47LKsyJDz1WIB+ZIi4ML6W+7?=
 =?us-ascii?Q?ze5tNIw/XwIhyoS/H4/85eU5M1Pdac5vxX6WHQF6QG+eXS9TO7aqzUvRB5yH?=
 =?us-ascii?Q?7O0TuOEG1RFb4NmSbrJKYDGZTq+B1vdL/VBK73kQLSZ27u5Qx1y8LxYZALo9?=
 =?us-ascii?Q?ILuuzO8pW4dE5r3aYzhu2Y3f9goqAT0E0nr69+b44zaqm+WMdu9Y0WwLqXBw?=
 =?us-ascii?Q?HJq3REVMihDSXk/FqQ0VccmFE4tWh96yzxsmkRl/H6EtKIpH4H0FWRV5mpn7?=
 =?us-ascii?Q?5QsFpUAOtqJ53RI1CF5AEljQ6dTbyWnA20XaYdIc447FtcUM16Al21oE7mfT?=
 =?us-ascii?Q?BNl6FKuZ4+7QerewXfoyuHpptoJPcR+EGsm6pmslzwPGNwBzKCQF5O3ZuzQ3?=
 =?us-ascii?Q?tz9mJ0sVS4dlhzguOG9bB1KPpSBAoyHJRN8MPCoGH6ejWmL2SzmPrTzhorB0?=
 =?us-ascii?Q?vIJBAKvj0LGT0cHi0fKEtXu62OzlDMbwN7Cyt9aMVWVKnklSjJO89y8KzCoD?=
 =?us-ascii?Q?Eu534cQ5JJOEjqHd+kdSWcUijRmC3HFrrdTvd7nR0OVqcze0OXDJYaC1C9bD?=
 =?us-ascii?Q?VMUUkeDmVzGTJSeaBXXhTocohishFj2lbUvx5TF+WJ0S3g0HPd43/JJsZXGj?=
 =?us-ascii?Q?YsP36qb+phX/uq/RIvxa3/dymzM9SIimKvZdcum7ItvAt2xgrxDzO/2xHii0?=
 =?us-ascii?Q?LFVFiMV/Cglgw37rC6+lndnx5/7ACDrkVA5kuNYTe4bJCmHNxZ0yMftMCCVj?=
 =?us-ascii?Q?LF/zocBP/qUT586GQpNFX6MZaPJHBk+NRw1DhU1vzas+VXFZpGEf6KAzKMRc?=
 =?us-ascii?Q?DjtjaPEM7oSdAqoWBxATVdkZ2kD9ShqPX/I7gdRvb2P2rjP3pr5b3mAPnzz2?=
 =?us-ascii?Q?irlLNwZEDm8+v9bTRVvI/SzkTHME+ZBjpYl4xyBLlDiJb+qx2hxyNzZj6zpN?=
 =?us-ascii?Q?zB6za3udq99JvLaiW7hZUvHmrnteGr9CSIEfRo+Ctj1YWhK9br10Zn6aD0z5?=
 =?us-ascii?Q?U1dAtUg+vtTEaN2kSf1v5G6OagqOk+DRM2DgHPM7kPOSFFO4T9i/vUAUMRuW?=
 =?us-ascii?Q?sX/yZIRRhSHqGKHCJm45UVoacOrVjShspx1gBlEoukkLwTdxVvLTeC8R0oIi?=
 =?us-ascii?Q?0x1K5M+MShnVGSi8JvZ6WY4XyBnN5ng=3D?=
X-Exchange-RoutingPolicyChecked: cj2u2d+G0h4UvpAtaVXYZiUS+1RgkanL1Fq6/S8Joa8VK9crwk3gZswFXAgnvZe+RTb4Jqg3Cv3aKNa5PY1JN3nWkerMoxSSP8z+c6Ywwym8tvyAkrEny9m1954ObNXb9M9KSAhCMc2OYVmso9Djso9Wv+Ny7w6miKtkNwT81gMteiZXEMJV/Unn1aZMMzfkERSRaAIrjELQt6lWukEPKIbqVcbCkSNTWKvkPTuQapxpe1auunWmiz1riUv0IBer6OHjyp5r+Wo9WcAlxva1SPPw6vowXUNfp8gpPmDDJ3dlj7m+I42/ogymX2sIMgIiVkPhk5E+AuPng50CPBclmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a40a37c-9407-463c-70c6-08dec7520c1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 00:40:33.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvATckcG+to+nnR4MYjDjaDB5m3xttXybIiyXsM3IiZwTLZc76m0kBbnPagP60jU6l8U8nEqwfSNMYQqjAGgXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9498
X-OriginatorOrg: intel.com

On Mon, Jun 08, 2026 at 06:15:40AM +0000, Wentao Liang wrote:
> xe_range_fence_insert() acquires a reference on fence via
> dma_fence_get() and stores it in rfence->fence.  It then calls
> dma_fence_add_callback() and handles two cases: when the callback
> is successfully registered (err == 0) the fence is transferred to
> the tree for later cleanup; when the fence is already signaled
> (err == -ENOENT) it manually drops the extra reference with
> dma_fence_put(fence).
> 
> However, dma_fence_add_callback() can fail with other errors
> (e.g. -EINVAL) and in that case the code falls through to the free:
> label without releasing the acquired reference, leaking it.
> 
> Fix the leak by adding an else branch that calls dma_fence_put()
> before jumping to free: for any error other than -ENOENT.
> 
> Cc: stable@vger.kernel.org
> Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Merged to drm-xe-next.

Matt

> ---
>  drivers/gpu/drm/xe/xe_range_fence.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_range_fence.c b/drivers/gpu/drm/xe/xe_range_fence.c
> index 372378e89e98..3d8fa194a7b0 100644
> --- a/drivers/gpu/drm/xe/xe_range_fence.c
> +++ b/drivers/gpu/drm/xe/xe_range_fence.c
> @@ -77,6 +77,8 @@ int xe_range_fence_insert(struct xe_range_fence_tree *tree,
>  	} else if (err == 0) {
>  		xe_range_fence_tree_insert(rfence, &tree->root);
>  		return 0;
> +	} else {
> +		dma_fence_put(fence);
>  	}
>  
>  free:
> -- 
> 2.34.1
> 
