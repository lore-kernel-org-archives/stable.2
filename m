Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B483644D4;
	Tue, 14 Jul 2026 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044336; cv=fail; b=o+CHzFOtTudRp8xvYMGNuzpDSa1pqocBHANzvxLUJKMUB+S9ISQmd9NbB0HRxWDATwTgHCcBkZIncrrE0gnhaJxpRqHaXJ9gZQ0rlmS2ztdpLHa2yeeMh9tagY7NuijeAhf+yIXtCBIF5uVgJ89Wrek5dFqmKQumzhWHExLO2kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044336; c=relaxed/simple;
	bh=4CqIn7YDp7yjr1XsV/bSvM5xn5hjac76rhj8O+lz0LE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqQJ+9EK5qpvIXWaA3XExnfctpm3ICj9hslzXV+I1V/dmBvTbOVwZL/+iQZhHzMk80AcOqfe7XPyl+LLhjNhdFfqLYnIalqCHBkc0cSSaIOFT4dLUrTpdtARGQCaRQnxh6GdqXmJxJjNT4ytxCjBWeWJ80ZIVTArV7jADHPJ4cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg8QBTmM; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg8QBTmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784044335; x=1815580335;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4CqIn7YDp7yjr1XsV/bSvM5xn5hjac76rhj8O+lz0LE=;
  b=Eg8QBTmMFibvpIdE92a0y28QGrZWHA+8oci/JxfgijZ86aKLWm6loS6Q
   PxeVoDhHNwpAbuyQOYhMUgeR8mFIcL95nWEaGqFCnmvbjikciSOFAS7gr
   VFihp5B2iXREEMxgQVc3Tfs6gCmpn7uLFNyTcL13qCP8s12+iVtsj/XQo
   otKD5aMwza7P0OPtUsLslKWTges4qLa/tfhs3t3L1Y2fB58l+6kIS+4WE
   iHM3lRNkOIF3laWTTs2zWPPxr2iUelEhudP2KTJ3cPF9U5L1Kn+bJWfbw
   fButKL0gzzvhnpWoBLSwF6uOAbPkjrK1oNHxYPiZD3E3JQ16R9mKCYw81
   A==;
X-CSE-ConnectionGUID: hILCjaNjTIKC5r6jEtyd5w==
X-CSE-MsgGUID: tuF8ScpdR42Fbw0l+8oMjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="88570086"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="88570086"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:52:15 -0700
X-CSE-ConnectionGUID: 5a69J/olRiW7s5X7cFFm6g==
X-CSE-MsgGUID: tNgvPp16S1WbglF6zMof9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249537089"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 08:52:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:52:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 08:52:13 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBkZ+Zl0GNdwi8TlyV/0t6f05Jp2rHAoFe/ISX8WqEEVuxTxxmWOwXn6Y9J4OWjWOWDH5Lls0sBvdy4lsAnSHARLnzDkvfXn9flwQ/DCP8iwuqTKfXfCz0QeU6+10iD98OOMuGqk6BS0nGbRnArHphIgxCThKE578YaWGFuIH+jAfaPODr/rV3S+C+bO4WLVzO/7+RwrfxG4wMtGLuQRCcOivnKeohh6nLb+ReyCjJ0je+eiKIe+0sd2MYcPwzOrNEDsn4YR3uHTXa7OxIlbjs4fhwzOrlKMblgSQi7O+DZQlReqWJJSoXlFVT0t0Ig6EPyXuzy4sPo0xy5ymKct/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUO/rnT9cXvHO9d0es0CrX4aneyomOrMs65ohmpL4Gk=;
 b=lv9pIy4A+Dphz3vcDEXnqHT2P9gxX/MpXcLRlo4EYMTbvvFfdM0P0RNI2v4U6FPsveFOFnG6kP6hzMV3pm7oIdjCrTwvCM75E2xlJFz/cwJ7vUDBgxyoyCStmX/O3yRAOlP1BwidnkA1dS3VWxNGXB+XjBGbprXXKaxH2HXKvIBQu9ZUK90v5L9i1BfYPYj6KIVZBpb7tDpk5+pl7Q9lrAuCZ/bebctDZCIp+vuJtdJ5JXt3wMU8LsSU6P6oCow7u3cE2zcuqNEW2eWqKeXR3EmvcFZI2cyWoi7v7ljAtfZmFlw/xFtXa2WGhjJI58WF5c9y2FvTKhzEzCrv1ZS99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by SJ5PPF2F2B659FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 15:52:11 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:52:10 +0000
Date: Tue, 14 Jul 2026 11:52:07 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
CC: Matthew Brost <matthew.brost@intel.com>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] drm/xe/nvm: fix writable override for CRI
Message-ID: <alZbJ331cckqTzNQ@intel.com>
References: <20260714-cri_nvm_fdo_flip-v2-1-14580e71b58e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714-cri_nvm_fdo_flip-v2-1-14580e71b58e@intel.com>
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|SJ5PPF2F2B659FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 341485bd-c348-4dae-a9fa-08dee1bfdda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|3023799007|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: RhTs7XSskmUb+qAfft62fJzzF401pniPYrDsJXCKgvsZCEmuZIPFXXnSW5qUPtC941Ze62CFssT1fZpiT4NT83XtFqj+ApQYzRnd3H6yzn5gvIqULC9YW6A/QfiVlmSjSF1PO43Vr2zPDkcpUwrNguWKHqNQAs1R1SIBFGPQwqJgnVE2GAMDni7tTcIXyAUK42i8L2Yj1KQWDHGzkaW3u1CFBLtB5b9NQ4R9BznkTTlljtXBONJRZT99AP8tAA1+wQZ6YRDbFwjpjlcGuGoJG6/PVy5qBsEIPR/MhanxwDBL+6YD9JqsesX5SnJRYKJDaGRbPQ6XxZ+5WiGVnbaOoS5Tkh9E2IchV4vIHq5+MZHP2ELXGBM9fGBaA8x/Il3YJiVnCtdPcIqJKi75uDxOLfJ0rZoE9/7m33RdJ1sbvDqBr3ncP0KQBsCbRYPfWs0HkbKIA517eT8I+kYchDkeBVNseJ64cPTaeyfQ+HmwMLbd6PFnQR7P1nNjx8cIho4XNxpNArM4PXo38xExghBk7VDtAsMLroJNWLPOrYoUefxmVQJ6E/N9C4xMazuG7+5ApKEkp8AnhCs5wGzikF48d50wL0gKx029oz+pjlzigSlHgx8K6y0ZWTB7135MYu1hKG+JlKn9Kt6HAFO0qcalcMoEhyc2mi5s6Dvvm5MJA8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5073.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7FL3zoJTLThyU7kN/4rKgVr/sbOljzVLbp6c9ibq05wMM66Qm6sIhmZQtprn?=
 =?us-ascii?Q?W87Kq0TywDcM9MBLPxjSDnamtsTI0IwFlQWo7HHV3hvh0fYKGX3+M7R4AUIA?=
 =?us-ascii?Q?30usqhaZFEHxsjAHIPZFsw0B6C6wMFP6LIz8OUbyonPIYNOJ1Ql+OuhwHOtL?=
 =?us-ascii?Q?ZeSOWgrbSBgp1WgswbxBfGNGYUYMNR1akYX7XnQ4Eb2YGBFesi5/TlHh0j9R?=
 =?us-ascii?Q?NvkPy8xrAH3k6u5oiEVraGDl1FGeKOvDyh0Fe9z9U7SSjAvpcTUS341sDE4z?=
 =?us-ascii?Q?Pcu4xPXZGBP+19so2IJSDWrm9VHSkFU1XJ2Jl8lLzVwXwTD8wUjV/IRFanDB?=
 =?us-ascii?Q?J8qPupxiubOyGc7CJf00BgZjcd2Id4AlwkhjvWALTXk1hIsdbrMtDCtRE+7r?=
 =?us-ascii?Q?W5l94jvaE+uIOx9cY9k5pUnYAE4I180TVgeTvoaZGtMdXJmPV6YtoqLkvEEU?=
 =?us-ascii?Q?Ljke/5F9bI/qMJxKgY+GFvxDMCfKt3Se8iJYJ0f97tlCjcjx9ZEL68GIOHF0?=
 =?us-ascii?Q?5Hqtful0SEdppm3NJ4GLR0uLzRf+SbH7Bq0Fyrfo7L113Oip5CG9yJn9e82l?=
 =?us-ascii?Q?aOALHWCkFOL7M86pun3L1HYwyPCK/TlAvooCW8gmQTgnf2kVZRd5Fyh7L2Iu?=
 =?us-ascii?Q?We+XtCfy89QhNk57F6xT4U9ELW09E9bft5WZLQHcOKPIDmox6XwhwC4ecmp6?=
 =?us-ascii?Q?DAMVRaYb1AApQ4j3R7hNVP3Ro73hpIGpeFPtZaM7NwL19TyoFnvjpJTmMeR6?=
 =?us-ascii?Q?rbJoXbaNoudLRW42wP1hqsk8LWa7PihLMF4q9e1Cj/q3EP+BaRzK7qgBc9Nf?=
 =?us-ascii?Q?xzV6lbKGnvL33fDk0C7k6Y1VKUmOJBRW87sDtRx1p0EK7yc4Hi1yqUwaoshS?=
 =?us-ascii?Q?SdQuBumzSbJkqGyz29rWE0EeQHf0bj4DPiyLEXowa4xIrx5XZWLXXildiOUY?=
 =?us-ascii?Q?xBHj6257+m9uVcD2WQWKe27av7FZoK5apvacBs30kctx7P8nQNBWQ3KmdFPX?=
 =?us-ascii?Q?H9Bw1kce7uWWDhomgFjE3q8gpagahKA+p3C6OMY+KtVzsWTgAMmC7iLEpyt9?=
 =?us-ascii?Q?tIcSQ27PPZlCbOVorijeKV+GLH7YK+YcCXeokPCXCwjSYQR5zG8lDooDkd/q?=
 =?us-ascii?Q?fhCDDO0Gs1j4dc52an/Uk+1CpUzK1m0ZK+Htxj1C7FaxnSdzdanYjY5QaEzG?=
 =?us-ascii?Q?TVVFj8Ew4Z9fEH7QBvXf9H8tkOZwhObx6PeNj8Z26W2FHymn3mxW66h/4try?=
 =?us-ascii?Q?cQCbT1QnFqXBJTXDeRpzoadiausZbiahb63ieYdBlUqKnQ1X3n/olZ1nXSOe?=
 =?us-ascii?Q?e1vaIi4zipxcDiBFi0VbtGDR7OeqbG2mNJickP//pX19nQVm5adr+R09CtRV?=
 =?us-ascii?Q?bGREfJwwC2w4b4qb+ISbW1LQ+IErFiqsYZuBJsbt2DUjCSp2DWzfp9bq8g1J?=
 =?us-ascii?Q?Vig9UKT6vZHIwwLteYEkkze+7h9Zt5CuVQ+ocP4E7drEFq+qEW56NgXEdUbF?=
 =?us-ascii?Q?BFlk/E5Fkfa7wR1YjYOtZ628p5lNyYg8HeXbhjGikIu2LikhIm3J67o9U5nN?=
 =?us-ascii?Q?ePcfmEX51S9mh4DO5aVYHazjjbVC/595LhHaeUE4fyNaHRoTHgiOb/pprqOf?=
 =?us-ascii?Q?piWQ/gUzm3u3Lg95e5LE8ZDsu7m4xXdOwlh63A8HJTOX5sjf0u0uz5g9hAIE?=
 =?us-ascii?Q?6RwSSgu4WuQSnOdpzDPzyWDLZ2iQTXlCVOUti850z9Nq5anCm1rdTSXyWQeq?=
 =?us-ascii?Q?urllnLErAA=3D=3D?=
X-Exchange-RoutingPolicyChecked: eQ8MzikOfl326tHdFxyFuKMAd8eSnsY4025N0bCT8JeEtHc8DDEV335WZLLbWWXJh1MYB0GPioOi+dlWH/+DIkCPTRfbHRK+hwGxd3ekNKBZyvOvo3BcWsM8KeiGl/0d7ePXpC6WpI8wi1hrP2DcHeL2m+a9JR2/7ni3v7ydU2DX6mQLp0KFMyQiaEZVUvKr41pGe8EkOiAhSq+K1mwLv9Cd2ntgq9tZNnROoBKONM4AHrtXvdLfaNknQhbhbWHmzypW+/EwyGHCNMshAkxKA6uqBk5auKupch4ZslLKSKdOafQNmMAXFTQUug2S9Sbzq7qI5MlZsBlDSuSkgvhxTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 341485bd-c348-4dae-a9fa-08dee1bfdda6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:52:10.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ciHFFLCCUycM6j4wbswxEwJdjq+qmmGHGgNSgLqqXbzszLm0MaEx7DsB836Gn3RvazR1U6GISvkX1bQeTkD6QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F2B659FE
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 08:54:17AM +0300, Alexander Usyskin wrote:
> The witable override should be set when FDO_MODE bit is enabled.
> Fix the comparison to distingush this case from legacy systems
> where bit should be disabled to have override.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9dde74fd9e65 ("drm/xe/nvm: enable cri platform")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
> Changes in v2:
> - avoid multiple assignments
> - Link to v1: https://lore.kernel.org/r/20260708-cri_nvm_fdo_flip-v1-1-792373667334@intel.com


Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
and pushed to drm-xe-next. Thank you for the patch

> ---
>  drivers/gpu/drm/xe/xe_nvm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
> index 33487e91f366..1ea67eaeae24 100644
> --- a/drivers/gpu/drm/xe/xe_nvm.c
> +++ b/drivers/gpu/drm/xe/xe_nvm.c
> @@ -60,35 +60,40 @@ static bool xe_nvm_writable_override(struct xe_device *xe)
>  	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
>  	bool writable_override;
>  	struct xe_reg reg;
> -	u32 test_bit;
> +	u32 test_bit, test_val;
>  
>  	switch (xe->info.platform) {
>  	case XE_CRESCENTISLAND:
>  		reg = PCODE_SCRATCH(0);
>  		test_bit = FDO_MODE;
> +		test_val = FDO_MODE;
>  		break;
>  	case XE_BATTLEMAGE:
>  		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_PVC:
>  		reg = HECI_FWSTS2(PVC_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_DG2:
>  		reg = HECI_FWSTS2(DG2_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	case XE_DG1:
>  		reg = HECI_FWSTS2(DG1_GSC_HECI2_BASE);
>  		test_bit = HECI_FW_STATUS_2_NVM_ACCESS_MODE;
> +		test_val = 0;
>  		break;
>  	default:
>  		drm_err(&xe->drm, "Unknown platform\n");
>  		return true;
>  	}
>  
> -	writable_override = !(xe_mmio_read32(mmio, reg) & test_bit);
> +	writable_override = (xe_mmio_read32(mmio, reg) & test_bit) == test_val;
>  	if (writable_override)
>  		drm_info(&xe->drm, "NVM access overridden by jumper\n");
>  	return writable_override;
> 
> ---
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> change-id: 20260708-cri_nvm_fdo_flip-333b545e1dd8
> 
> Best regards,
> -- 
> Alexander Usyskin <alexander.usyskin@intel.com>
> 
