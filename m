Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4447327BFA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031376; cv=fail; b=oCSieyKe7ARuM3/74DMwfzkP43tR3IQhzNZ+h7FMv6ZhMIylr6P4dhaJCxF9QGTWJB1IRGyGyrZSx0ihSaeQoPQ6jkBRobEL9DdxfS4ig77Xtza+1km8C6mIAqU0+cNTYZg6K6GVheaGDaCYrFu4WUf1+huXrkbABpYN+I1olQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031376; c=relaxed/simple;
	bh=KplVO30FiiWz7yfrD5KBt0JxnXpoin2JFtWwY/gFFek=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipAPFZAW6nomp02kbmLCBJ1lIaXAl9YgsAIQX5JJ1faNxT6nJZctZvF1O++NWxauRaid6D1oFLKrPn5K6OmnI73r8bRIuSrK97pcIu67UAic7Uuxr+UQ61xUc+/97wfuP/wgynwd5jjAZNM7XxqVIiK1lt7+j361dceSUrI3wDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AFuYVKwN; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AFuYVKwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786031374; x=1817567374;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KplVO30FiiWz7yfrD5KBt0JxnXpoin2JFtWwY/gFFek=;
  b=AFuYVKwN2+l0bf5UQ5petM+M6C+4SReWRrDLfjbveuLiTXOgDpbd1sMw
   VJ1U9Xt0Soe7LzzgrxWzn4LP6HYj3ClrSW/3iwqLnbz+T85k8421X3FWG
   QL82cf6g2pTGssYiRGVsufQb9Tt/+FcILo21VdlXBv3T6q8jqmY/EBFAs
   HYMeRkRTG7LJRKANomOQ2ObtYXFtMsv7XerDNs6InmdUEz1EEF/OVPBNZ
   aSuQ6ig8pXE1RzdXUwVpyPa93DQ3MuZtFjYgh4+7SRkdc7s9gSmsKQKq/
   xvexRdrFpRHsZ7rF3/vY9ufvkmE5dBraNTv6ZbNazqEcJ6DuiAfvlFQRx
   Q==;
X-CSE-ConnectionGUID: HzkT9CT1RFS8JNzKyCQ4WQ==
X-CSE-MsgGUID: 6j7HJ8ARR+W7MZv2vdTRug==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86836748"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="86836748"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 08:49:34 -0700
X-CSE-ConnectionGUID: yNDiG+hUQW2z5pwSj4qzjg==
X-CSE-MsgGUID: bw7Kt4+YQ0quC7RjNXq9ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="260370208"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 08:49:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 08:49:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 08:49:33 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 08:49:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQC0U3DKs9SRRoKwD2pIjXCRAtlZ7izbOqzmG2cAgrcnyEjqnUHCjg9rVYF9BJmDlpB8YroZkkQFU5CTraEN9rcSM3l3Qlbke0hpfc8jdiNV43vxbnICDMhC9dgfgxSRLWcwGKn5ad3zkZEcOzYqif4lfplkFjAQeROwcxCod/1D1KW+bwSY+1q4tCOzSrOBGPAMDFlazxhv9Afrk5Wv/pi2mlloqlWJ4vlJQ1AtLvX1oZ0e5UYsjUminuUbu1ZskXIUPs8FIIfAboFhYP8TZFqez5t62CU51MKC2grNwyF5d8unHRZ1HWefM5hohhLBZcfQ3T8BhFTpkEgIs1b9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wayQnClB1Rg605bUCJNYwrY6RglWRoXreKrFFPU6Jw8=;
 b=XdVIegvUBMLn7Ht8yEdw+TCAPd28l5IdxvvtiXeLSElEmPFGxl7Fq7gD1hDD0sOLWGcDvP6kh9WGNtF4OwVApM5TpzGwoZg+WJOzvpPombTLRU6uM2QN9n34XF8KM6cRnI2OZJ0V47o8feiQ417/Qb/hUy3DPIqAxbnsgXmFq7bPgmq0x5IMXcSWyPIkxPoAOLzbcAqnSxRnj9CQKsZHnJ0i8TOV16ePYvz5waRbL5HfdWJzVfoy4FcK3JW3RHCbOMk04Hq1+O/+8+ExI4lQ/CrIlgIL6mjm2DsxxToHZ7BGn5K8SsPfLf4wecvnOFJKTlbhlsTeoA1VSA8I0BbAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by SA1PR11MB5780.namprd11.prod.outlook.com (2603:10b6:806:233::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 15:49:30 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:49:30 +0000
Message-ID: <788a51d6-4eca-4365-bad1-037d25f388d0@intel.com>
Date: Thu, 6 Aug 2026 21:19:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/display: Limit max joined dotclock on pipes
 available
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
To: Jani Nikula <jani.nikula@intel.com>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260806143738.2710312-1-jani.nikula@intel.com>
 <ca6f4f3b-9c94-4b24-a8e4-7c351e730429@intel.com>
Content-Language: en-US
In-Reply-To: <ca6f4f3b-9c94-4b24-a8e4-7c351e730429@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0215.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::19) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|SA1PR11MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 9686ed8a-5a93-4f43-82dd-08def3d24d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: /Et+JWa0G48fdx3hVLkEaD00sTTdPFPmu3A6P3vhlk/ZtB1lXLTiCQ2Id+BlRMS5RWaUEqQzdYm2a84Nib5Y5m4CgX1KC4pWRdAeDPbb37FLTSNnzsZ2sfeXWPfuS9VilWvW74gFZYs4VjqEqRReHJE95/sEdbaw6/+8Rov3Pf67bINnqza2wgMIppEr2N/AIb1cnA5DFl9qLY7WpLLJRUwAeVw3CeaLNokX2rjkWo9P/d60ijUvqkvV9N4mVckvZ0vZOYawrIsK4PwM9CMNkfJfH9CgGRNbOn7LnbMswOuJ1R4YiOVafq7LdW7VNzqcZcI/LwZtf7fx/Eq+iC0Ti8TmVsxZt52IqEaQ7kKyr4KL0nNxVp3hmwSo7TVBjUfRXBSmuhhDi1brw4/Zhobym1aPZHY5LgxnCw6Dht54x4aOIjuMwrKmMF3zXryLCc2fsykg3rlZceGaWPLltp6m02yA7Va0hpdlqVh9HlhRLsXJLFjCQvrHVcNV8mQtH5pZOGlzk1zaDrP+akY0DTxTismKsG61Iej88M11sXumX7/hnACYQtXEOFp6Ifdzn4m/G0Stqvn4jkdWM7AFPxGxxNHFmV3eikmE3kYyMbU8WYr9c2+1vd+qjpTOJ1bQBgQEPlvbmr6ur8vy5UMrjTy+jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7554.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZMNHloa3ZBOUtWYm9pMVliUVI2a3dCUHRyVlg4KzhvUUpCTno2NWFyNVlS?=
 =?utf-8?B?bUY4MTlyc1ltdDN2R1BQQjU1dC8xa09SUVRrZEtUQjRXTUlCT1lFZnNrTUhp?=
 =?utf-8?B?M2YxUDd3WDVLU053ZTVlS3g4QnNmekJiYUF0bm5ZOGtFVldKSWU3YVgwenE1?=
 =?utf-8?B?QkJnOXFIWmFBRFU5MHJISG1PNW80VEV0K0VDRFFHU1J3RkdQLzBtWTBycVJC?=
 =?utf-8?B?bjVQQXdGczBHbVBGbGQvRlZWKzN1R1NzSWtZY1lqczR6MzBFWHJaTGFsWUhK?=
 =?utf-8?B?UTZDZm82UEF5YlRkcXZFVytKdXVtaUE2TlkrbmNUZ2g3NHdnOTNvM2RLTGEv?=
 =?utf-8?B?QTByTkFPUkJxS0hRWXpuY0s5MC9NREc1STZWenFEcFU2ZzhkaXF2UWcxMFdy?=
 =?utf-8?B?L1VONmw1dEJRZ2pSbEdNK3JXRDhpV2VIeWkyRCtDckFHeVpoVFVJUC9pcDZa?=
 =?utf-8?B?akFtT2dUUDM5dlhqd0FKV0tMQWxSZnVLK2lXMDhheUNQTitpSEE4dUVMa0dY?=
 =?utf-8?B?eHo2U09lTEVmMUNHNk1FcVo5RU9uckhIMk1QOW9adXByeGhIdGNZVitoTHRH?=
 =?utf-8?B?dFpTZ2EwNmw1T0hxeThwUFF0WHdPdkl1MjNEU3ZJVXNaTmFGeGNWeDNIa3J0?=
 =?utf-8?B?Z0dFVEtrYzZtS3BxaENhd2MxZzdna2NIUnh1QkVoNHF4VWFjTFV6REZJVHAv?=
 =?utf-8?B?eFdIMlJHWi8zQ2FmY1FkYUZpVmIzSGQ4dHY3b1h1N0dJNmYvblpCSCtNWXFj?=
 =?utf-8?B?ZGZUTUtiOS9sb05oU00wL2R4bnE0RFd4a0hiMFY3MG1IdWRDRnBVR3FGeUVl?=
 =?utf-8?B?S01MZmNXZWxpeG82Slg5ejVKVlJhb3FMcTROeXo1U3VUZ3ZNeURWeVBGR3BH?=
 =?utf-8?B?dk04eGErZE9YM0djb1pkQVIvakwrQWFuN0ZGTkZLSFZEaFhqY1lzcmh3c2d1?=
 =?utf-8?B?SkNVdkF6SC9MMjJtRnpSUVlSNDRhUjVyTldZZTJsbHovdlRIbmJRcURWY051?=
 =?utf-8?B?L2JJR3lvYkdxMVJtZC84TkdLblVObXNCSnpERW4yRnpmMkhxOGZEYTNSQXh4?=
 =?utf-8?B?dkxEdHR6Yjk5Qm1KbEpPREJOV3NNOEZXa3N1c2NUekwxcFFpUzdicnBTbHVz?=
 =?utf-8?B?RWRxbkdZaFlXN3VVb1hoUU5pOGpwbzNwMkM1SEJMVDQ4ajZVM0hHQ0hBNHFI?=
 =?utf-8?B?TGF2dGxjdGtTVm1taVBSRjJNSEluTk5jTFVGTkRKaU0xYlBXbFFrWEZFNmtU?=
 =?utf-8?B?V1dpZ1RkRWZYTjJxY2E4OExvRWp3SjJPNDNGbzR2QlJQQW9JNUlpUGdwRDZo?=
 =?utf-8?B?T1pLbU5nZUJFb2tMQ3VZZFVsMERIUWpHbjRQY1NXNklwNXFqN1ZsZ08wbXY1?=
 =?utf-8?B?OE9WdmpuOFBRbWR4aVJOaUpZaW1Uelh5bFhJcW1TZElKb09jNUoxOXBueVVP?=
 =?utf-8?B?bGo4UGdsckp3aFJBcXRDNDBlN3lESFdzbFdjbjR2MWVOMVpJTXRpVFZLUTVo?=
 =?utf-8?B?VlI2K2EycUUrRmN0SzZKZXZGZGNvYVpPN041OE1VOHhSdlMwaW1aYmE4WGlz?=
 =?utf-8?B?clpZcXlMaS8vcGFPaWN4NzlEZ0M1ck5PR1BUakpBbDNJOUdMTVFka0RMZnJS?=
 =?utf-8?B?Y3Q0QThvTWdJK2pnT0o1TGJZY1MzWGhYUzRyOTZ2bDg2VGk4cXpPckFBL1Q4?=
 =?utf-8?B?TjY4Z3pacFhOK2tVY2lobG9rN1IrMnBkWndTMjdSMmZPdVVhbTZMQVE3SjA3?=
 =?utf-8?B?ZEVHRTI1TEVHQWxRZ0tBc0tDOGliSjBnbUt5ajA2YnZ4cDhWY0l3MkN5YllY?=
 =?utf-8?B?VGIvRklld3BRakxXQTNiV3lrWW54eUFiRFZDVkloZW0zckhoQWNPSHd1bWdN?=
 =?utf-8?B?Vjhzc1FpKzc0WXF1N3pFcjFSRmg2N2tlRU4zUVBxemRCN3E4a0RNOVQrZzNU?=
 =?utf-8?B?ais3S1lyZFMyN1dkNlUyZ2lCVm1lKzFrUzU0TUpNN0w4NFdMNWdkWVMwblhU?=
 =?utf-8?B?eWNHeE9KQXllbzEzWG83TmI3RkZuSUtYWUMyUkZUTFJzdmhqcGlVMkhRL2ht?=
 =?utf-8?B?STdxdDBFTEpKKzE2ajV1dHo5US91cGFhcUpwVTV2emhZdHNiRmVTdzZDMHRL?=
 =?utf-8?B?dFM5TmgxY0pKajdnaUgzOGMzdUVqWGhZVVA0ZURVbXBKVzRrYkQvSEdHdUV2?=
 =?utf-8?B?T25oaFRRR3JBSTlzcWtKZFJ3aU5Ua1M2ZXRDTGFENW5oSS9WaHp6blorc1lE?=
 =?utf-8?B?Vm9pb0xyQWtpeXQ3bE0rWFZiQk1ScFpFdzEzdHJjaTFXaTc3U3RjQ09PV0g4?=
 =?utf-8?B?cGttUGN3VUhUL2xZdXpXZlNzdU5yYjZha3F5eFZVOVNtWStFM3ZQYmdsSmxq?=
 =?utf-8?Q?zRTy/7lk+EQAQxDY=3D?=
X-Exchange-RoutingPolicyChecked: GIC/SYrrrnpeE5p7DYqTsUKoPKTWvMBXsa7nxqs9mieC1iUmOc/a6tnW8BHPtvKzaQlftl0a7BZaEhWQsO8PZdaYatuKwTr7qD+KEalObTdNncwYbA+uNZVId0mUZYUZF/aopiK/KYTa89B25Q3oNOGO6BMpFdz+4QtnjmlQzlLIu2yxKE6YECJtSvFUGLNoBoAVjJP/K5zpFPtl6PVAYgKPn4P5tDsOj2g8txCJDII69RnteMJchik4Za02m1sH0s0219MuM12O637cInz2wwlbvv+90ZgJn2t4Yec0fqnRxUIGYV/bpwEtZbufkdpR0x8vG/rrB0tmOBrQeQDARg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9686ed8a-5a93-4f43-82dd-08def3d24d26
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:49:30.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Sfk8mx/vuX4OBDPo6vilshginsKhdgl1ueX1GZw5Ah1xE55FsNvIDhwF0Q7LNv1SNXWyYevvsQX1GC38sXYUHh3h/JC7VrvTck4jqTHB68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5780
X-OriginatorOrg: intel.com


On 8/6/2026 9:15 PM, Nautiyal, Ankit K wrote:
>
> On 8/6/2026 8:07 PM, Jani Nikula wrote:
>> Multiplying the max dotclock based on joiner availability on the
>> platform alone does not take into account the actual number of pipes
>> (possibly with some fused) available.
>>
>> Limit the max joined dotclock based on the actual number of pipes
>> available.
>>
>> This is still too optimistic due to other constraints on actual pipes,
>> but it reduces some of the false hopes at mode enumeration.
>>
>> Fixes: f4f8f0eaaafc ("drm/i915/display: Consider ultrajoiner for 
>> computing maxdotclock")
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.13+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_display.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c 
>> b/drivers/gpu/drm/i915/display/intel_display.c
>> index 829d7a411dcc..44c5d1dde255 100644
>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>> @@ -8113,9 +8113,10 @@ static int max_dotclock(struct intel_display 
>> *display)
>>   {
>>       int max_dotclock = display->cdclk.max_dotclk_freq;
>>   -    if (HAS_ULTRAJOINER(display))
>> +    if (HAS_ULTRAJOINER(display) && INTEL_NUM_PIPES(display) >= 4)
>>           max_dotclock *= 4;
>> -    else if (HAS_UNCOMPRESSED_JOINER(display) || 
>> HAS_BIGJOINER(display))
>> +    else if ((HAS_UNCOMPRESSED_JOINER(display) || 
>> HAS_BIGJOINER(display)) &&
>> +         INTEL_NUM_PIPES(display) >= 2)
>
> If fused pipes are AC or BD this will still give us 2. Perhaps should 
> have a check for atleast 2 consecutive pipes from 
> DISPLAY_RUNTIME_INFO(display)->pipe_mask


^I meant :  if fused pipes are B or D, resulting in A,C and B,D 
respectively, as available pipes...


>
> On the other hand we can have the consecutive pipe check in 
> mode_valid() path after for_each_joiner_candidate() is called, which 
> will check whether there exists any consecutive pair that can support 
> joiner.
>
> As discussed offline, in any case, we need to fix the compute_config() 
> path for SST and MST where we are using the 
> for_each_joiner_candidate() to check for a given primary, there exist 
> sufficient consecutive pipes to support the joiner candidate.
>
> Regards,
>
> Ankit
>
>
>
> Regards,
>
> Ankit
>
>>           max_dotclock *= 2;
>>         return max_dotclock;
