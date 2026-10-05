Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA343C054
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192294; cv=fail; b=Nlqwhhm+VGt26LPU2TE7lC4FNQJy9Qn9hVm/lJl/p//abflxfU9quiKtgfnHdUa6tcBIaPyc5312dOmu79gSeganedrevTg3nrZ97ROCMnTbpIx/m5O/nnL/dEKDGJpxvEBn20/5pqjwtsvNKpPw0Dgweg+/13nheUm7HooBWrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192294; c=relaxed/simple;
	bh=rsZvayosAyoDx2qpRDyBlZ5glIxRIcEnz4KP2aEXmXs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VfrMYh9DtDZaple7ddDCAAie9N5Ba0L5O4NgwUN8H3tr81bahLsmu/obbbfI82fz8zG2Txi50AtBBQzW4NejNvGH+YgDxT9I4TKdZePnp6YSBpcBuu4q8i/zQ/I4AaNHELv59fmM3DOhK1FWZMfbDrGVzBG8g/WqfCmpw3dclzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeQjB1Oq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeQjB1Oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791192293; x=1822728293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rsZvayosAyoDx2qpRDyBlZ5glIxRIcEnz4KP2aEXmXs=;
  b=eeQjB1OqMVAgPgxxWrOolKyNIPGbpeeEHX4Mrq6EIG/smG/7h2xN0qdZ
   4Lmr1KrL8ASmrPIlctmCBFSP7ll3T4ps49FQkYpHjQLuXxoYFpDg+8Vm3
   jCdplMo6GfGcWsFJC4lASQGJXw4XI1KG7qmLDqZumICLVFCzOPnsU8Jei
   w9DXzYUWppc1X5wg0YwGMIRuA0GuMwVrEwm+XNN0FAJ8Sihru/zAhFhao
   hRsavF90bNO8EGNNp59oJQZ1dyBKfyiLSGz3u5WSlzK237HSezilPNPSV
   nHNu9ntmFycIxrbWDm5SJpkEcLpGZa0TmiSL7/Xm6Xb/fv/qi5Nghf/Hk
   w==;
X-CSE-ConnectionGUID: SUG0k0eXTfyqG+lEq05bkw==
X-CSE-MsgGUID: 2xS3iNXpS1W8TTmHLYvwVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90892777"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="90892777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 02:24:52 -0700
X-CSE-ConnectionGUID: UOj/6BJARfyNr0uND+UErQ==
X-CSE-MsgGUID: z48jH+iYTKicCvYKsKbfTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="314782774"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 02:24:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 02:24:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 02:24:51 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 02:24:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDlQonVzO3/yy60uR2IT0gHRlmp4dAU6Q1S+AcVFj9dOky2E/LF66IhyJESpSbTx0CSHcJ2fyIrN/5XrOnMY0CEX1cF6pzjO5JxHlls770dqsXRFUQnON4d5jqTbbZlZGXlLdChIKJyMMQgmQq6VpKZM2MZuWtCAU8dVTgwhgSeknTa0+KUoXVu6+2SdGaMoj4kBrHrlADw7I2gzSWZGiGCSaGnZ8kckVMMBrQH2hPQ1V/ZAK0FIAt68CEvpNPrS3LDIMEhQrLtem+t771f06ICRL1+4zzUFMPxrx1EcZx4oROoR4jKmp2+Myq5hiHvFZc+sjIh/SbUzRymVPC/WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLFgtE0dbdIB6VIc+UHDkZbLq5XrLsIej9cnBa8/Tl8=;
 b=oQAQuUbLl0hreDqCOizWa9d4geS412RgyPycEo3//dXCOgzgeEGBj7UzfhP9AmuPC9i/vbMvf6So+htmqsjWu93gA21AdBB1aI5+T9yjh/QZ1WFA8QiOCLfCbKqczPvRDzQkgBdKGTp67ZRFP/kfOqJNj2wHYaWZzEyYUwuCFdtUQzpUQayOLYMGchk0FZivgotSl8Ni9Di+dGSA2SkRJnFLqP7OJsnAALNFn/XL0ThXPTMQSKCUNxpRPnyYsHBdCBTPL7SfE+G1dRwOYUt4puuADNqzKkDlODDR1BNMpXB34TuUDn/p9NxwLZZR72jzDcoroQQQ+EXGoLaJ0qYeGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by CH3PR11MB243846.namprd11.prod.outlook.com
 (2603:10b6:610:362::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:24:49 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::3a:cd0a:2af8:5837]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::3a:cd0a:2af8:5837%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 09:24:49 +0000
Message-ID: <bff95109-a82c-4138-b457-787ac3f7ae1d@intel.com>
Date: Mon, 5 Oct 2026 14:54:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/xe: Fix shrinker accounting double-subtraction
 on nested external pins
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, <stable@vger.kernel.org>, Matthew Auld
	<matthew.auld@intel.com>
References: <20261002100830.12297-1-thomas.hellstrom@linux.intel.com>
 <20261002100830.12297-2-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20261002100830.12297-2-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|CH3PR11MB243846:EE_
X-MS-Office365-Filtering-Correlation-Id: d4504bf5-f0e8-471c-c530-08df22c2808a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|5023799004|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 49/B5UsIHuO8aJyPpd2XY18caruciR6C7uWcTCjfWnBJCyMZP4g3U7wgG3ToL5ULboKe4IUK36fGuG94rMoKhLg7A+FQze1FXPprYXsRTYGbWZ5leswD609++ZI33vPg0s+OzukXSD/+nS59A2HbIfFSLipSfu49ieufAZxlQmIgW8SHJvMxvWWKipYr9Z3wjEg7zG0G1B09+93vVkgedX7EvUAlxTNKxifKYgJGxRyP2J+y60WtmWkRKF/Y/NFV/pxtPABYC0WiRrhAXIBOK8t0VZDhzmNUSHwfdmr6XRIwZljbSclY+cZ63lR/J59QLL6KS6rabeyHHXXlWbI+9ihVSBO3j6whq2iNmVc5+lAGcusX3hBiwwZrMVlD9dtbsCjSPUAWV8RBIbk/rOVNk3E01BzC7O9x7qDthnYU+rw+0JeLb8FeNH+DE1LmXjtbhvpaAleUysWshm2UoXQLh5Dzmk08Oy/4OOAr2EPyLTAldIy8zSkzowR/ayB0xEkcdx8sdkKoZ4FgObM/sEKDRk5UxG4T9WcqzXcFOFmx9MB8oCLacZjzVAKbWfBa7Ch/g6KjMZfiH32z1TjezkzrIW05G7/NNlxt6c6BC0dq7BDooJXsd5NYCcpQXl/ZHQ4ydD55OtAwOBNsPHjrG2/PIG7SOJJzEG0xKLL5IBRnuV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdNUmtHczdyUFRodWFnR3NOV3F0em9iUWQ1NHdPVEswZWpZTTlQdmV2L1hY?=
 =?utf-8?B?ODl5UFdiMW5ET1NjOExTOHlZSEZvZEVLbTFkcVkxYUlkS3kwUXZ3N1V0VGxq?=
 =?utf-8?B?QnNpWUhIWE41NytCNGVMZjFGZjIrMXZIem5aNUtPYTB2Qk5oVkRqQ0hrbGVq?=
 =?utf-8?B?NjBxUVZnZS9hMVltbmZrTEtWbzNGWFpONVVQbDBLbXU3QTMvdUE0QUl5alI3?=
 =?utf-8?B?RnVVSVhSUmJLcjZ1a2EzbHF2dGxrLytYdU1aUVYyOHhBdHBwdUZ0by9MRFlR?=
 =?utf-8?B?V0FYSGd0Ylk2NmpEM3NoVHFzM1czelA5SlhrT0JBV3l6Uk1ZUjlKZDVkMWJP?=
 =?utf-8?B?MDFBTldBOVBUS3l5U2FxTU1EcjY2c1lFa01Sa3FSYldDcXh4Unk2UkxWVm5I?=
 =?utf-8?B?bCttdnZsL2FCbkhmbGRCV3A1MEtONUxyNUlUZlV3d1Bac2NDK2Q5LzBNc21v?=
 =?utf-8?B?RjZYV2MvZDZRSHpqbTdLNGpzb0h4MHVaTHZzYmxVbjEzdnhyRHo4WlA4aE9y?=
 =?utf-8?B?ZEFmekFMQTZsTjc0dlpyaHRQL1lTcHlsTmQweksyejJDemJXR1RjWkVXVVpT?=
 =?utf-8?B?NnhvQXlmK3lQUFJyZTZtcUJMRUdtcWE3YXYwUGVYNm9YSDhKYithT28wcEgw?=
 =?utf-8?B?bXRZcEg1MU4yUlNubHpXWVVEbk9YUzFDTUZLa2NLYThsejRBVStXWVpkd0kx?=
 =?utf-8?B?dHRZWjRSTU91VWNRdExJL0hsd0ZVNDFOdGVWcStRRzhDV1BPcXZCdkR6T0p0?=
 =?utf-8?B?eUNDT1BGSHAvK2lRUnowSnV2WUtTNzVVUEova3prTUtpbkZ4TmsrT1BwMEdX?=
 =?utf-8?B?NHJlRUcyd3ZyWUFmSkQvMjBVNDJjem1CRTNxRDU0MmhKM2paUElOVy8zT2xj?=
 =?utf-8?B?anhXakFFeVBZRks0Tmkvc3BCdThodTRrRTNvQlM3aWxaUUZKZ0RhQnl0Z25C?=
 =?utf-8?B?eHB4VHlQV2pQUExXYzdXQUhOSlQ0c1l0RDgwYXBRYXZsaVp1OWt2MXduQzRY?=
 =?utf-8?B?N2xQYWxsL01OU1QvY3JrMnRpMFVVOUkrTVJhRGs0ZEp5dlYrd3NQVUsvMmhK?=
 =?utf-8?B?eVVROXQ4aGFISVNSUW1jV2JlM1l1UUJCRmtQSWVYNWgwQ3R6R04zSUJEQ1hO?=
 =?utf-8?B?KzNMMW9tSVQ3dCs3eEQ4Wmp3M2RhNFlxMEFLMjhvbTJma0QyZEg1a2E5UDBu?=
 =?utf-8?B?MW04ckNTbC9reFJoSWhhRWNuc3RGOUx5M2RUb0hIQnpzdEVxSTV5ZHRVSGFN?=
 =?utf-8?B?Zkg4bGlKclRGT3duWkxVbnR5dWROVHg4SmNIV1B4bWZSczk5YVIzazlERGkx?=
 =?utf-8?B?MElIL1NwSUhCbkVlSWFRTWt5dlpiUUlNcGJMTGpVR25zYW9CMndxREtXRVN5?=
 =?utf-8?B?QkY1YVpNMmNVOUtRNlRNVC9qdFI5a1B0R2NsWnIvcWx4TU85S3RXczBBb1Mw?=
 =?utf-8?B?d2dPTzJXR2cyR0FVaHBtVm1yMWxjSUU2ZnFuR3JGQWl0MVZZUGdwWHBWZGtT?=
 =?utf-8?B?Vk1MWExnWThYV21wMkRUdEdmakQyWGJKY1oxWW91ME95UTlvRnFyVU51Qndi?=
 =?utf-8?B?akRvVlBhWTEyeGJJWHF6cVRaQWJsNzVqdUtHVmtROE03UTRXYS9GbWJIcjFW?=
 =?utf-8?B?MXM0UnBOWVpXTHA3SWJGUWEyQkJmT3dpYTlML1N1cjV2MVp0ellaL3dJYWVU?=
 =?utf-8?B?ZW8yQ3pvNVVCUFFkaTZOcW9kTmY3MTNIRjNCZ2pMKzdFckQyOXBTR2Qrek5C?=
 =?utf-8?B?eG5LTEw3aldTOWQ2VC8waThMTk5yeFVXNjBSL2xNamdVRUpNWkh5MjgwMWU2?=
 =?utf-8?B?STdCUDlpeE9aeHFKKzQvRWs3V3FDM0l6NjZ1dndKOVgyVzhXNHRGYXhiWXpT?=
 =?utf-8?B?WmpBM21KcDgzcjIxWVpjQklVeEVlbXR6bGxYcGNOTXBqOWl6RlJXaU1KZS9C?=
 =?utf-8?B?OVpnYnNqKzI5clpwNGVoMm1ibWJncGlQdEZ1MU0rZ21kNG9mUFVlNGtLbjBj?=
 =?utf-8?B?dnZubTlIOGtTRldkMC9SbTVkQ1hhTTZFYUJETldjcE8wdGgybzhtcG5QRnFo?=
 =?utf-8?B?dnBhUlN5T1IwUFV4NFRnbGwvZzl6QWh4bHJPbE9zSmtOT29YdkNQTG9GQmlV?=
 =?utf-8?B?SHFuWnI5RG5mWU1JS1lpTm01ZjRjem8xazYxVUFiTXRURGhUVS85MFpjOXJ3?=
 =?utf-8?B?a0xtazlxY3JVRWhNNlgvVGtPUFBXYWVvbUNtanhSMXYrUnVxQ3YvK1NYVTR2?=
 =?utf-8?B?elEyL014aEtlREcwaWJGWjZZWUhDQkFEZG9VNVo5QldZVFdScEhwK0J5SlBt?=
 =?utf-8?B?MjJTdGJWY2NPMDZIMHFEcDh2Y0p6bXFRTTJERTA1T01mZUdxS2JHVEs2ZExa?=
 =?utf-8?Q?RdcwKhWXZo3AD4Kc=3D?=
X-Exchange-RoutingPolicyChecked: Sa4D9hgGPbdyGedNwdM6JFBLAG2+rOsr/oJGPjo1BrNKGHkZBx1xiPBA97TTsWb+/2TbkTSZdUY7GYSHUJ2MkysSiEQhXY0gGcXQpsV/xvjtN2bdidmByI2svM3A5gzMuzHBjfz4kqN9blDUOoSYqQhSDU03zrKIJJLJV7lrzv1PSvzSXT2J3HI47g2kOeNTyyxwZhXPpDX/q6o08PpQ9AU5tZmCFmf4LyBOB3Qr6xyvCuOuXZkWDhmZI3RE42IOcGF1+bg6srRJS5lwPaOfCjT5AZCrTc3aHsq/KEeZwTlLurE+3wpoppZR67JmeTTgG7gNvtnjbK3r8dZTlZOPlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4504bf5-f0e8-471c-c530-08df22c2808a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:24:48.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTxBmJ0qSf8Ci54PbagRTnKIFL0122uQzqk6f6IG0RJMRzbN/gqM+JJu36mFnpeLyCUii99gqCKDCTJ8fjc4K8YMDM8TZN5xME4o/sRxSZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB243846
X-OriginatorOrg: intel.com



On 02-10-2026 15:38, Thomas Hellström wrote:
> xe_bo_pin_external() and xe_bo_unpin_external() support nested pins,
> since the underlying ttm_bo_pin()/ttm_bo_unpin() maintain a pin_count
> refcount rather than a boolean. However, the shrinker accounting calls
> xe_ttm_tt_account_subtract() and xe_ttm_tt_account_add() are invoked
> unconditionally on every pin_external()/unpin_external() call, instead
> of only on the transition into and out of the pinned state.
> 
> An external BO (dma-buf) can be pinned more than once while already
> pinned, for example when it has multiple attachments/importers, each
> independently calling xe_bo_pin_external(). Each such nested pin
> subtracts the BO's pages from the shrinker's accounting again, even
> though the BO's pages were already removed from consideration by the
> first pin. Symmetrically, each nested unpin adds them back again
> before the BO is actually unpinned. This desynchronizes the
> shrinker's page and object counts from reality, and since they are
> declared as signed long but interpreted as unsigned long in
> xe_shrinker_count(), the underflow can turn into an enormous
> shrinkable/purgeable page count, causing the shrinker to be invoked
> excessively under memory pressure.
> 
> Guard the accounting calls with the same pin-count transition checks
> already used to guard the pinned_link list maintenance, so accounting
> is only updated on the outermost pin and the final unpin.
> 
> While centralizing this logic into xe_bo_account_pin()/
> xe_bo_account_unpin(), also close a second, related accounting gap
> affecting imported dma-bufs. For an imported bo's ttm_tt, xe's
> ttm_tt_populate hook (xe_ttm_tt_populate()) early-returns without
> calling xe_ttm_tt_account_add(), since TTM_TT_FLAG_EXTERNAL is set
> without TTM_TT_FLAG_EXTERNAL_MAPPABLE. However, TTM core's
> ttm_tt_populate() wrapper unconditionally marks the tt as populated
> on driver-hook success, so ttm_tt_is_populated() still reports true
> for it. xe_bo_account_pin()/xe_bo_account_unpin() trusted
> ttm_tt_is_populated() as a proxy for "these pages are accounted for
> by the shrinker", and would subtract/add pages for such a tt that
> were never added in the first place, again underflowing the
> shrinker's counts. This is reachable today via xe_bo_pin_external(),
> and would have become newly reachable via the fb-pin path once this
> patch routes __xe_pin_fb_vma() through xe_bo_pin_account() below, so
> fix it here rather than in a later patch, to avoid a commit in this
> series that introduces the regression before fixing it. Skip the
> accounting for imported bos, using the same EXTERNAL &&
> !EXTERNAL_MAPPABLE test xe_ttm_tt_populate()/xe_ttm_tt_unpopulate()
> use to decide whether to act, via a new xe_ttm_bo_is_imported()
> helper (hoisted up from its only prior use site).
> 
> Fixes: 00c8efc3180f ("drm/xe: Add a shrinker for xe bos")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: intel-xe@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.15+
> Reviewed-by: Matthew Auld <matthew.auld@intel.com> # v2
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> 
> v2:
> - Fix the critical issue caught by Sashiko AI review: the pin-count
>    transition check introduced here was still bypassed by the fb-pin
>    path (__xe_pin_fb_vma()/__xe_unpin_fb_vma()), which could leave a
>    stale pinned_link entry and a permanent shrinker accounting leak
>    when the fb-unpin performed the true last unpin. Addressed in a
>    separate follow-up patch in this series rather than folded in here,
>    since it is a distinct bug with its own Fixes: tag.
> - Drop the unneeded local "last_unpin" variable in
>    xe_bo_unpin_external(), restoring the original inline
>    bo->ttm.pin_count == 1 check; it was a no-op rename not used by any
>    of the new accounting helpers, and was going to be deleted again by
>    the follow-up patch anyway.
> 
> v3:
> - Exclude imported dma-bufs from the pin/unpin shrinker accounting,
>    fixing another underflow caught by Sashiko AI review.
> - Add a short comment on the backup-object pin site noting it's
>    already populated/accounted at pin time, addressing (as a
>    false-positive clarification, no code fix needed) a separate
>    Medium-severity accounting-leak concern also caught by Sashiko AI
>    review.
> ---
>   drivers/gpu/drm/xe/display/xe_fb_pin.c |   6 +-
>   drivers/gpu/drm/xe/xe_bo.c             | 116 +++++++++++++++++++------
>   drivers/gpu/drm/xe/xe_bo.h             |   2 +
>   3 files changed, 95 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> index b46a2c32ac07..4f5cee474c64 100644
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -356,7 +356,7 @@ static struct i915_vma *__xe_pin_fb_vma(struct drm_gem_object *obj, bool is_dpt,
>   		drm_exec_retry_on_contention(&exec);
>   		xe_validation_retry_on_oom(&ctx, &ret);
>   		if (!ret)
> -			ttm_bo_pin(&bo->ttm);
> +			xe_bo_pin_account(bo);
>   	}
>   	if (ret)
>   		goto err;
> @@ -373,7 +373,7 @@ static struct i915_vma *__xe_pin_fb_vma(struct drm_gem_object *obj, bool is_dpt,
>   
>   err_unpin:
>   	ttm_bo_reserve(&bo->ttm, false, false, NULL);
> -	ttm_bo_unpin(&bo->ttm);
> +	xe_bo_unpin_account(bo);
>   	ttm_bo_unreserve(&bo->ttm);
>   err:
>   	kfree(vma);
> @@ -393,7 +393,7 @@ static void __xe_unpin_fb_vma(struct i915_vma *vma)
>   		xe_ggtt_node_remove(vma->node, false);
>   
>   	ttm_bo_reserve(&vma->bo->ttm, false, false, NULL);
> -	ttm_bo_unpin(&vma->bo->ttm);
> +	xe_bo_unpin_account(vma->bo);
>   	ttm_bo_unreserve(&vma->bo->ttm);
>   	kfree(vma);
>   }
> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index f2ab9bf43a86..6cc3f0bc0be4 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -465,6 +465,85 @@ static void xe_ttm_tt_account_subtract(struct xe_device *xe, struct ttm_tt *tt)
>   		xe_shrinker_mod_pages(xe->mem.shrinker, -(long)tt->num_pages, 0);
>   }
>   
> +static bool xe_ttm_bo_is_imported(struct ttm_buffer_object *tbo)
> +{
> +	dma_resv_assert_held(tbo->base.resv);
> +
> +	return tbo->ttm &&
> +		(tbo->ttm->page_flags & (TTM_TT_FLAG_EXTERNAL | TTM_TT_FLAG_EXTERNAL_MAPPABLE)) ==
> +		TTM_TT_FLAG_EXTERNAL;
> +}
> +
> +/*
> + * Account @bo's pages as pinned for the shrinker. Removes @bo's pages
> + * from the shrinker's shrinkable / purgeable counts on the transition
> + * from unpinned to pinned. Must be called with @bo's dma-resv held,
> + * after &ttm_buffer_object.pin_count has been incremented by
> + * ttm_bo_pin(). Safe to call unconditionally regardless of which pin
> + * path (kernel, external, framebuffer, backup object, ...) is pinning
> + * @bo, since it only acts on the true 0->1 pin_count transition.
> + *
> + * Imported bos (xe_ttm_bo_is_imported()) are excluded: for those,
> + * xe_ttm_tt_populate() never actually populates the tt or calls
> + * xe_ttm_tt_account_add(), but TTM core's ttm_tt_populate() still
> + * unconditionally marks the tt as populated on driver-hook success.
> + * Relying on ttm_tt_is_populated() for these would subtract pages that
> + * were never added, underflowing the shrinker's counts.
> + */
> +static void xe_bo_account_pin(struct xe_bo *bo)
> +{
> +	struct xe_device *xe = xe_bo_device(bo);
> +
> +	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
> +	    !xe_ttm_bo_is_imported(&bo->ttm))
> +		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> +}
> +
> +/*
> + * Counterpart to xe_bo_account_pin(). Must be called with @bo's dma-resv
> + * held, before &ttm_buffer_object.pin_count is decremented by
> + * ttm_bo_unpin(), so that the check against the true 1->0 transition sees
> + * the pin count that is about to be released. See xe_bo_account_pin() for
> + * why imported bos are excluded.
> + */
> +static void xe_bo_account_unpin(struct xe_bo *bo)
> +{
> +	struct xe_device *xe = xe_bo_device(bo);
> +
> +	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
> +	    !xe_ttm_bo_is_imported(&bo->ttm))
> +		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> +}

Nit: pin_count == 1 && ... && !xe_ttm_bo_is_imported() check is 
duplicated in xe_bo_account_pin() and xe_bo_account_unpin() — maybe a 
tiny helper (e.g. xe_bo_pinned_once_non_imported()) to keep the two in sync.

> +
> +/**
> + * xe_bo_pin_account() - Pin a bo and account its pages for the shrinker
> + * @bo: The buffer object to pin.
> + *
> + * Pins @bo via ttm_bo_pin() and updates the shrinker's shrinkable /
> + * purgeable page accounting to match. Must be called with @bo's dma-resv
> + * held. Safe to call regardless of which pin path (kernel, external,
> + * framebuffer, backup object, ...) is pinning @bo.
> + */
> +void xe_bo_pin_account(struct xe_bo *bo)
> +{
> +	ttm_bo_pin(&bo->ttm);
> +	xe_bo_account_pin(bo);
> +}
> +
> +/**
> + * xe_bo_unpin_account() - Unpin a bo and account its pages for the shrinker
> + * @bo: The buffer object to unpin.
> + *
> + * Counterpart to xe_bo_pin_account(). Updates the shrinker's shrinkable /
> + * purgeable page accounting to match, then unpins @bo via ttm_bo_unpin().
> + * Must be called with @bo's dma-resv held.
> + */
> +void xe_bo_unpin_account(struct xe_bo *bo)
> +{
> +	xe_bo_account_unpin(bo);
> +	ttm_bo_unpin(&bo->ttm);
> +}

Nit: near-reverse names and easy to mix up; each internal helper has a 
single caller, so inlining or a less similar name might read easier.

> +
>   static void update_global_total_pages(struct ttm_device *ttm_dev,
>   				      long num_pages)
>   {
> @@ -1396,7 +1475,8 @@ int xe_bo_notifier_prepare_pinned(struct xe_bo *bo)
>   		}
>   
>   		backup->parent_obj = xe_bo_get(bo); /* Released by bo_destroy */
> -		ttm_bo_pin(&backup->ttm);
> +		/* Note: XE_BO_FLAG_SYSTEM resolves to XE_PL_TT so already populated. */
> +		xe_bo_pin_account(backup);
>   		bo->backup_obj = backup;
>   	}
>   
> @@ -1416,7 +1496,7 @@ int xe_bo_notifier_unprepare_pinned(struct xe_bo *bo)
>   {
>   	xe_bo_lock(bo, false);
>   	if (bo->backup_obj) {
> -		ttm_bo_unpin(&bo->backup_obj->ttm);
> +		xe_bo_unpin_account(bo->backup_obj);
>   		xe_bo_put(bo->backup_obj);
>   		bo->backup_obj = NULL;
>   	}
> @@ -1627,7 +1707,7 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
>   	xe_bo_vunmap(backup);
>   	if (!bo->backup_obj) {
>   		if (xe_bo_is_pinned(backup))
> -			ttm_bo_unpin(&backup->ttm);
> +			xe_bo_unpin_account(backup);
>   		xe_bo_put(backup);
>   	}
>   out_unlock_bo:
> @@ -2019,15 +2099,6 @@ static vm_fault_t xe_err_to_fault_t(int err)
>   	return VM_FAULT_SIGBUS;
>   }
>   
> -static bool xe_ttm_bo_is_imported(struct ttm_buffer_object *tbo)
> -{
> -	dma_resv_assert_held(tbo->base.resv);
> -
> -	return tbo->ttm &&
> -		(tbo->ttm->page_flags & (TTM_TT_FLAG_EXTERNAL | TTM_TT_FLAG_EXTERNAL_MAPPABLE)) ==
> -		TTM_TT_FLAG_EXTERNAL;
> -}
> -
>   static vm_fault_t xe_bo_cpu_fault_fastpath(struct vm_fault *vmf, struct xe_device *xe,
>   					   struct xe_bo *bo, bool needs_rpm)
>   {
> @@ -3148,12 +3219,13 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
>   int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
>   {
>   	struct xe_device *xe = xe_bo_device(bo);
> +	bool first_pin = !xe_bo_is_pinned(bo);

Nit: unrelated change

>   	int err;
>   
>   	xe_assert(xe, !bo->vm);
>   	xe_assert(xe, xe_bo_is_user(bo));
>   
> -	if (!xe_bo_is_pinned(bo)) {
> +	if (first_pin) {
>   		if (!in_place) {
>   			err = xe_bo_validate(bo, NULL, false, exec);
>   			if (err)
> @@ -3165,9 +3237,7 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec)
>   		spin_unlock(&xe->pinned.lock);
>   	}
>   
> -	ttm_bo_pin(&bo->ttm);
> -	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> -		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> +	xe_bo_pin_account(bo);
>   
>   	/*
>   	 * FIXME: If we always use the reserve / unreserve functions for locking
> @@ -3223,9 +3293,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec)
>   		spin_unlock(&xe->pinned.lock);
>   	}
>   
> -	ttm_bo_pin(&bo->ttm);
> -	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> -		xe_ttm_tt_account_subtract(xe, bo->ttm.ttm);
> +	xe_bo_pin_account(bo);
>   
>   	/*
>   	 * FIXME: If we always use the reserve / unreserve functions for locking
> @@ -3259,9 +3327,7 @@ void xe_bo_unpin_external(struct xe_bo *bo)
>   		list_del_init(&bo->pinned_link);
>   	spin_unlock(&xe->pinned.lock);
>   
> -	ttm_bo_unpin(&bo->ttm);
> -	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> -		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> +	xe_bo_unpin_account(bo);
>   
>   	/*
>   	 * FIXME: If we always use the reserve / unreserve functions for locking
> @@ -3289,14 +3355,12 @@ void xe_bo_unpin(struct xe_bo *bo)
>   
>   		if (bo->backup_obj) {
>   			if (xe_bo_is_pinned(bo->backup_obj))
> -				ttm_bo_unpin(&bo->backup_obj->ttm);
> +				xe_bo_unpin_account(bo->backup_obj);
>   			xe_bo_put(bo->backup_obj);
>   			bo->backup_obj = NULL;
>   		}
>   	}
> -	ttm_bo_unpin(&bo->ttm);
> -	if (bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm))
> -		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
> +	xe_bo_unpin_account(bo);
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
> index 341fa93a71e4..4a3b79b73789 100644
> --- a/drivers/gpu/drm/xe/xe_bo.h
> +++ b/drivers/gpu/drm/xe/xe_bo.h
> @@ -228,6 +228,8 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_place, struct drm_exec *exec);
>   int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
>   void xe_bo_unpin_external(struct xe_bo *bo);
>   void xe_bo_unpin(struct xe_bo *bo);
> +void xe_bo_pin_account(struct xe_bo *bo);
> +void xe_bo_unpin_account(struct xe_bo *bo);

Logic looks correct.

All are minor Nits, so with or without them addressed.
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
>   int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
>   		   struct drm_exec *exec);
>   

