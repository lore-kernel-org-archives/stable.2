Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF702DECA3
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023859; cv=fail; b=pmYx0FEbpyR3vxVcVmNqDG0gs0sgLIKACGZup03iDTECHrDSK1jM20QoYxVNvUXfT6SLVkBUw0EGa/bApTqxUm+y5saU8QCbV2+x9HYKiG2fGmQcWpuvp8Lepi91weknYt9ESgy2VKLFK0FDjbFqH4ybSyKR31eUmVemUYyFWTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023859; c=relaxed/simple;
	bh=okPDTiJLsiKDqwqm2WiC+R9o4Oa5FtfereScFiManM4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C5jy22LUW3GfiTIQoHEqvLHxPfYU0TUiTHYn2kQr/+XudDB+moqfOM4EIzKFVgGS/a0ifQA5B26l2dUpZHp81voSSxuY0xxOBeUX6h+TpVelPPJuzQgDbJChympxPF380OqkXr5zTg/w3wbFeu3vBPhvW3UO8skHHmgGSHlP0iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTP7Mot9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTP7Mot9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781023857; x=1812559857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=okPDTiJLsiKDqwqm2WiC+R9o4Oa5FtfereScFiManM4=;
  b=UTP7Mot9P6KVOOx+I6mnUF1RBODFGrVn0fn38VPn18AGU6u+i0f6HnYA
   MVyNrpdIcRRJ0TMMcg7poAeA1EMDmMjxTbeJ5A7bAV6nPiHlJM8beb+xg
   32LQxtFZz+95qQSHESlDodTafowHU61YPlcMoIb9otHcGU7brQerzsz+Z
   WiKj4+zUX5WAM4+wDhu/NYrAyUG+3C1swB8gAU7LqocXCGn8aVl0VFaoh
   kB4q/tqm4wDYBS+Ye9JkQmQEGjg4xw20wPZX8iugaoC5XdmQCdSIz5Zs4
   KyHlZExLGAvuNR8ZfADQ9Lw/eoBuL9Wgff6v+/cMG5xKod0lNMX9alG+0
   g==;
X-CSE-ConnectionGUID: Nld2urMvSM6Gkv0nvuXTsA==
X-CSE-MsgGUID: QLvxdYf/RySZR2iWaO5JCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81983150"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81983150"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 09:50:57 -0700
X-CSE-ConnectionGUID: cKe/El6uQHec7JCjrFg5gw==
X-CSE-MsgGUID: S2z21iRVTOylLH4N9ksAbg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 09:50:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:50:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 09:50:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 09:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQRRawQ47WTvQUx9uE0JGZZmgt3JzlDUh99SCBzEJJlnFJPyBCzeYj0NGROtW0FgLCZqWDHEg8O/FM4OXexKgpBqov2BIxYHnBhbRtGa707nmMntCmGo640SaakFV0PgCNqsMf/lwRvADuoH9DbOfDcb8MlOJvZJ919ABz+bxG1bAUU6uS3XzXhZh/ZPuspfQq/IX3SzWuxC/0tRNo8KTMjByYWs/SzdyuDOmDcSEN3IeVzRB+h/VphX982TJp2blJcAXLkOrDZX0SmEWd8hPs2rrybzpaa8bNRzXV+9EeheYnSGhm3fWji/EPngmjTA5in9ZJFC/Xl4FzyKxKrDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6N6tgoIlDXfyzyaJEF35GKzIoX/g2lbCl+eKy1R5Ag=;
 b=ZLRiVdeT4dzK9HucINb0SlVigPN4oShe6EmuudgdCD9yBTL4dd2um1H2X+HWywX2dWiDa43vd80sTS3r4SxNuzNIDX2drTFRUMB2U8eXaNMy1ELqoh6xUg4hbR5HPTGHeJXbcofdYMNwhMJMkP7TZD0utWuVmj4wQS2CWQWeBUntm0n743hWbyC2XTo7nTc8oozFHzPxCcUwiEjriA0S78osj1kdy+xYPlpR5QrdzQtzl0uSQAfHI5aYh8AwdwwZVycHATcgNkhBx/ZLqXnm/TUMzWSKxkaeeAajE+zRAog8O9bVg6iKheH6mV0s4v6rStbaVGxEDp00lFMCEQgoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22)
 by DS0PR11MB6541.namprd11.prod.outlook.com (2603:10b6:8:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:50:53 +0000
Received: from DM4PR11MB8177.namprd11.prod.outlook.com
 ([fe80::5c75:19e7:62d9:80fb]) by DM4PR11MB8177.namprd11.prod.outlook.com
 ([fe80::5c75:19e7:62d9:80fb%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 16:50:53 +0000
Message-ID: <320f511f-7067-4498-93d5-1e9a9dd0393e@intel.com>
Date: Tue, 9 Jun 2026 12:50:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list
 allocation
To: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260609055657.440911-2-tejas.upadhyay@intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <20260609055657.440911-2-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0377.namprd04.prod.outlook.com
 (2603:10b6:303:81::22) To DM4PR11MB8177.namprd11.prod.outlook.com
 (2603:10b6:8:17e::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8177:EE_|DS0PR11MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 95964a7e-61c6-4b59-4f95-08dec64744a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: VjC38nEgxBM0Rtvz0EfoVrVcEKIur5+9dr3U9yUpM/NKlLvIImZcULeCJRKoFbADnBEMxEkHTAoUUrPSjLuedsOo1/YBic0l/gCw87GjjR4yg2qcQ663lloj+a3NvjgvDhcIRyzzPDm5YrqLmpzH1j3PAJnlxI3F+c++CAhxPrV5NvXCrNZiNDujEtj+4G6iYR5X4QaLyKDYCrXkfo9BA3qByE0mIPwXEa0pBj6aCrANLUQi/2Hv+/p70tFBJLj5fUTe5FywL6GX5Hj8yYSfvKo2YphSuqKhSwyk6DKjHHZmElhyDoBC/kKqv7K7rDzZhxEiFBw2DcGviF8GWmM2aJl+hWnBRGVAfdAqNKDioOM1uqH6l5iQkqaUbV6a4YuB0v0I1TlySVn7QWqi3+CoeKKrhTzfbG6M3CN3frGy/AxVN6Vc9fxn+hwp4fqkp2FMEnDzJixO/KguurjPmlfJWcHlLNAy46gCEiy7WyzBsKRuMTidRvwbwsEtJ4syF0pTHhONarsxtznJjAVFIkHj2ZS2zvCmd7qvNxQOB0x7/2kckmSrQ+aYKWZXT1BqKMkJtDulqvvVVUr3k5M1ZNN/8tNClIAies8JboLqEr2/cJJMzuU9U6Pwvrl8rDBYBBX2Tz0weATrKFjKX8xDJ0gFiIzwihtHxvn0M1vkmCQ55pBCavnMVfoBWUqPywSnQtIw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8177.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHcxdWtWOGtLZ2gwUGw4SktnT1VOUVFqQk1md0lXNmR6dUw4UkNna0w0aTU3?=
 =?utf-8?B?SGRTYTZKZkZWODlNV3h6Q1JYeHBONXpsTXZrVm1laDdOV0gvNFpVOUE3WURV?=
 =?utf-8?B?c09panVyS09yTnNpUXVtTGZhcmhFb3hMWE5saEVMMkYrMmZHRWlCUW9Cb1h4?=
 =?utf-8?B?aWdSV2FFVUEydmdaZ3FwdVhMTHJQWENCY0dxblFhTkcvMHQ5ZkVXeGxCWVBC?=
 =?utf-8?B?Qld1aVFxQ1krWXIwTVBQRTY1T1BwaGlpYm1oUllyUTM1OGJrSTgwV0x1Kzhh?=
 =?utf-8?B?cjRJTU1yYW42cFZaNlExR1R6Nm9zVHAzTkVQM3lHaVRIUnZjaG1VeUdSZUdm?=
 =?utf-8?B?aEp0ZHFNMlhzV2FvWE12RTdDRFhtM0pmZmhGdlpwN0l5c0ZnMjV2b3UzNksv?=
 =?utf-8?B?ZVJuaU03MXVDVE1PQzhhamExbEVDWWZCZGovK3RFZFRPRUc3RHlYSG5jL1gw?=
 =?utf-8?B?WmZRMmJ3QzcyMTA0NEl0NjJoei94YzFnVWpvZTkra2ZYQmdHZHJRTGtmN3B4?=
 =?utf-8?B?UWllOXZzcDcxRWo4S1dJWkIyYmI2amVRSlZtcUgrZE1FbmJCMDlqajJLMkMx?=
 =?utf-8?B?VGdkM2hnRm9JM1YvQmdnL2psN2dENzhsVm8yTE1LcXd3aVhiMU41b2F0eStk?=
 =?utf-8?B?aWpubE1pcnFmUWFaYnExZUxJelJ5di9WcG1vVkJZeXV2OXl3TXJkWVBhZURE?=
 =?utf-8?B?N0wwaERWSnZ1Ny8xYnZ2cU9JY2JXckd6UTM0R3kzNjZZZythL3RGcDRwZGxU?=
 =?utf-8?B?bTlDUTJRTFM3a3lZMEw2NStmQ0Q1QVprTURPOTlzWjFZd0hZVmU5QmpBU3Qr?=
 =?utf-8?B?VzFnbHJDMWErNVBqSlY5aW5VemZYNDh1bVhkYjE4Q283elRVNC9vZXMyWXdn?=
 =?utf-8?B?YkFwcytTTjBnNTI3NmgxK3RrYmhtV09tNW5pZGR6SjFpWkVTc3UyTjFPR2Vn?=
 =?utf-8?B?M2F5ZGJjdzg0eCtORHlmOUVzTXlZSDZrbERzZ2xnOE13ZnR2TkIwZkRmZUxX?=
 =?utf-8?B?U0twMDBML3RrYldEbW9SUXZQQzJZRVk2TjQrcC80b0dPSXZOL2lja3ZiN0pV?=
 =?utf-8?B?Zklrclo5N0svWng5dWNEMzBwM2VlTzl1SnF6WjBhdzduU3pZdk95NFJXdlBa?=
 =?utf-8?B?R0Njd1BJLzBqNEFsdkJySklkSjh5djk3UzBjRHJLekNxSGtzalo4VlNNNTU3?=
 =?utf-8?B?MS9wNjdiMXpxVlgrb3YvemdQL2w5NDFrczVpZ2JoZVdGTlBvQ0wrZFhVTXk2?=
 =?utf-8?B?NjIyaVhBUnV5djgydzhpRHJ5SnBlZ2l2emtkQkNyVFlUWER2T0Vod1R5ZDRZ?=
 =?utf-8?B?Y1lBNXhBMk9pYVBLTWVHd1p1bW1yVXYrWWxkUUovU1l5RnljV1l3NDRGc0pK?=
 =?utf-8?B?OGcwM2FjMHhmTmpGeE95cm1CVnRNSndmcEVQd3pBN3VlQ0JIWXRwTHk0MXRt?=
 =?utf-8?B?RDFXbVMycnJEcitQbTNUOW5rcVZQekpSV2dzS0Y1WUlKTkdlWExNTVgyOTNu?=
 =?utf-8?B?aUNPU1h6TVZqZnBLZS90TEk1RzF5NzVWNWVDVnEzTE10V1R6SERQbmtoeEc0?=
 =?utf-8?B?a0EyZFFoU0NhYmpOYzh0N2lHZnpNT2FZSEprQXhJdDVkOG5vUnhyV0NQVEVX?=
 =?utf-8?B?QVpPVW83R092MXNJa0NuSEdmeFpaeVJQbzZtRHFSSnppajZqMy80VllRRUgx?=
 =?utf-8?B?NGdxL2VybTR5U01QMEpOajdES2lZd05JVHNra0M1WlhRQWxnd2NqVzc3eU5q?=
 =?utf-8?B?eHVMOGVrZ3d3S0Rld1VtZXNuMkZIdzVSZXlqSTJzb0c0Y2JtelVzdGFlbHpY?=
 =?utf-8?B?QlJWbk9MZ0loNDd3ZDVGSEdiRTl6N002dmZnZTJQSDVOTmdYcG0zMEltZW1u?=
 =?utf-8?B?MkFUNEd6ME1CWWw1TC9XclFTODlvbms3eFQvbWhMZlNKeFBERE53RkxUUHI1?=
 =?utf-8?B?ZFM5M1VOSnhDOXZUdXdzbkorc1pibXRMY0hSL3Jtei8zakx4eUxNRTRrbUYy?=
 =?utf-8?B?SmRpZlRWbUR0M21JZ1ZVZG0vdmhOZG9uMlJHRXV0elBOTkpsRlFLR0R5MUFJ?=
 =?utf-8?B?UlpSbTBsaHJ3S24xZ1pXbW9WU0s3VTZzZkw2VDV5WEROa3plQUY0K3dSalpO?=
 =?utf-8?B?dnlSQ2VnZDFucnQvWHZUaDdCSWpKVDhpR2M5U1ZqWXNMaFlpWDFVazFhWGZX?=
 =?utf-8?B?TndEV1BNMHpaM3pLTUFGMEx2Y3VlNVJHY2pUcGd0UGxRL3Y3N3VtVW5yR201?=
 =?utf-8?B?RUpOUHdtRU9JaGtoQlBDaE5OSStSeUgyQnJReUlzZU9pN2ZWSzRCTVFjRjBG?=
 =?utf-8?B?OXVjUjFHR2s2a3I3UjhWR0daclZUV0ZFa0RxY24rMk12bWZ3Wlg3dz09?=
X-Exchange-RoutingPolicyChecked: j8p7DC1OgGzmUL8Gv/csz6G4cYzFD+twDr9iLIRyiTsgeOQ9lIYk972gAUyYzdoglJ3moVxH7pDAoJrKKRpmbMcGWqXhx81VUtva7zDKXXNgc27HCmrjV+m1Oj0ZXeRP/Vpr2+i1jQe3qvdzXN1ahEbePf5PCLuEe56mMyeE9quxMNW/dBscB3x5xncj/536KjosqoYl6t53lNjK5nmnhrtq9iyxxTysy9RTV9A8ojZlyiZRs/2NNxIsp8tCwDm5+9TTQ9GiQcIqCvyPlxzh8DmPWF35FE6P3JIzMoQorIJUXcRvHC6D4IVlZAr7LXTcj6K8coQ7LsOrRL9LRj9h4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95964a7e-61c6-4b59-4f95-08dec64744a7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:50:53.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGjagVqa0bySmpV0qxYnPk2JUnluEbk2Su8EhCX6jpTnSSQVu1EUo5+y0rhqyeYnO1jwCHyH341svsJ3vKhbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6541
X-OriginatorOrg: intel.com

Thanks for fix this buffer issue.

Suggestion: This could use bitmap_weighted_or() here, since we need both 
the ORed DSS mask and its weight. That would avoid the separate 
bitmap_or() + bitmap_weight() sequence and align with the style already 
used in xe_pagefault_queue_init.

Like:
{
     xe_dss_mask_t all_dss;

     total = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
                 gt->fuse_topo.c_dss_mask, XE_MAX_DSS_FUSE_BITS) *
		guc_capture_get_steer_reg_num(guc_to_xe(guc));
}

// Ignore the format, got trouble to make text alignment in email

Regards,
Zhanjun Dong


On 2026-06-09 1:56 a.m., Tejas Upadhyay wrote:
> The size calculation for the steered register extarray uses only the
> geometry DSS mask (g_dss_mask) to determine the number of entries to
> allocate:
> 
>    total = bitmap_weight(gt->fuse_topo.g_dss_mask, ...) * steer_reg_num;
> 
> However, the filling loop uses for_each_dss_steering(), which iterates
> over for_each_dss(), defined as the union of g_dss_mask and c_dss_mask
> (geometry + compute DSS). On platforms with compute-only DSS bits, the
> loop writes past the allocated buffer, corrupting adjacent slab objects.
> 
> This manifests as list_del corruption and SLUB redzone overwrites during
> drm_managed_release on device unbind, since the overflow corrupts the
> drmres list_head of neighboring allocations.
> 
> Fix by computing the allocation size using the union of both DSS masks,
> matching the iteration pattern of for_each_dss_steering().
> 
> Fixes: b170d696c1e2 ("drm/xe/guc: Add XE_LP steered register lists")
> References: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
> Cc: Zhanjun Dong <zhanjun.dong@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Assisted-by: GitHub Copilot (Claude Opus 4.6)
> ---
>   drivers/gpu/drm/xe/xe_guc_capture.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
> index 21f7caf9ea08..181e8b60357d 100644
> --- a/drivers/gpu/drm/xe/xe_guc_capture.c
> +++ b/drivers/gpu/drm/xe/xe_guc_capture.c
> @@ -461,8 +461,14 @@ static void guc_capture_alloc_steered_lists(struct xe_guc *guc)
>   	if (!list || guc->capture->extlists)
>   		return;
>   
> -	total = bitmap_weight(gt->fuse_topo.g_dss_mask, sizeof(gt->fuse_topo.g_dss_mask) * 8) *
> -		guc_capture_get_steer_reg_num(guc_to_xe(guc));
> +	{
> +		xe_dss_mask_t all_dss;
> +
> +		bitmap_or(all_dss, gt->fuse_topo.g_dss_mask,
> +			  gt->fuse_topo.c_dss_mask, XE_MAX_DSS_FUSE_BITS);
> +		total = bitmap_weight(all_dss, XE_MAX_DSS_FUSE_BITS) *
> +			guc_capture_get_steer_reg_num(guc_to_xe(guc));
> +	}
>   
>   	if (!total)
>   		return;

