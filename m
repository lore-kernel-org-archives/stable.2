Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB793845BD
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274804; cv=fail; b=WjXmeDmmOAbIL8TvFHsGWMThb8wKrXmk6Fn6BbkhhTh07v7lF0+nLMH3eUddjkPAT3HkhvSmZ6Z9MwndPuKxWE6m3qq226UywqplUxU4KyvgFutiWgnXkyHh0HjMe/0D/x0VNBcdhdhMh88Kbs8HPom9Ys//2JoxcgpLWNucVbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274804; c=relaxed/simple;
	bh=oQ06BjbUcO7YwEfXu77Uo6jD0lyo7qRdHkzC+12uEzE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHX1iPT/er+juAstVLfUiBBaB4GA9IAvB5J8uV5aFM1omcTuoYngI5yVHIUrM0gcxtWU4auibT7SZAmI3pDExomxLjplef4hW4A6xS3rZp4ShLVOQnTBkGNYdOYeSEDPI46AGrKKbG6tgcWIoZrbgcJMBfk7sTroDGZZ+DL1fvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZWySIH0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZWySIH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781274801; x=1812810801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oQ06BjbUcO7YwEfXu77Uo6jD0lyo7qRdHkzC+12uEzE=;
  b=fZWySIH0juNgpvts+hMJt1xvB4SBF5wtAgSZP+NngPgfya+w2D8i2+h7
   r40v1Kj7EBZs1jWdKMSEwoGesDHHDgnZanh/RLQoVrwyNLh/kTs5GVhfu
   zIy+Lc7J3SPoAQ6QSp/2T4tlJb8UwqXhwWrABAxDvk/DZPY726QmiUsjK
   6mKHAkJYBMzSQFzER/LJN50ONKGRCb6TesfoKKGxX+CIF8xpZWo4ww6pP
   +g0zk1yVxb68z6oqDt7sTjPyqb50IB99RihtnFsHswq9psnig41zf4kTP
   XY1/SeOxKHfobJOC9AaD5m0CNTdryVJeUOe1U70Ok6NXL67X3bsFjk57n
   g==;
X-CSE-ConnectionGUID: UWVTvr34Rw26z7RrmnEnFA==
X-CSE-MsgGUID: UFJZzCjWTSShgclXDM5tRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69652205"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="69652205"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:33:17 -0700
X-CSE-ConnectionGUID: IDMtVLb2R0ugNRic/qV4OQ==
X-CSE-MsgGUID: i3JhO+a8SGW65Nlek/djAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246861633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 07:33:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 07:33:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 12 Jun 2026 07:33:16 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 12 Jun 2026 07:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntGeMnH9LOEQ/teoVfvSZFSzD+YVcevbGlYYNmGsvPi2aFtwmJ/NflUS7J+R/OUorzZnXIVKf81rlSew3qgFrGd8lS7VaXbD9pNzZfvS0+fAhzy58CS6WxajZZrt0r7xFVJj88nQlN+E4cmQOBHzYPyUStcueIG91AV1Tf9ccpwoAOvW7Y9ilfpkAFPeO9sMrCdfkKOPlzIbPKi8YIJofNj8rSCkm84SrasvoLDVJeKkQFN1FWZM3/KGoGuFWZAR3rr1apU9hKiWpctbtwsowGJmA7kT6+CB0a3KtoodW4nho1PikUS/RWjkjLMM98x9BsbZn3sSS1o9TBKeItraPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNGFssLZ0f8JCAnfUL6s3lh9ikAqqMjxIKDNC2K1qFk=;
 b=m1PoL0tNK5WWvaVDrjOs48+mIIhw5ukujBAwHjyRLN2KrsP3pLTSU8meNOMHuWiQC7IQUo3MrOEnA5QE0iodzEr069a4PUP8ncYARzBJJqjYHWg5O+d3CcPlF+reQlRYddwibOaTOAuAROMwrlBpYmpD3DvvI9ppb8VaRQ9VlZAggYKsCzPkfn09kI3Kg7H/1PM7v9pEJ5y2sItYf5/p/my/Y9SQCdbHP/tHm/kpK5aR4oYYzM4nL6wUgLtqp514BsXELpwVmxP8/NCb9mHa4pkTEE783c2uVrGugiCTiVNux5VOecvS46+m6AWXmWRI/rtYmmtKWIlDYI6ZitaTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB8200.namprd11.prod.outlook.com (2603:10b6:208:454::6)
 by CH2PR11MB8835.namprd11.prod.outlook.com (2603:10b6:610:285::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:33:14 +0000
Received: from IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414]) by IA1PR11MB8200.namprd11.prod.outlook.com
 ([fe80::e0e6:a2f:a53b:4414%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 14:33:14 +0000
Message-ID: <d46890f1-f881-40cd-bea5-0b4980fdfdcd@intel.com>
Date: Fri, 12 Jun 2026 10:33:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Fix buffer overflow in steered register list
 allocation
To: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260612070401.543305-2-tejas.upadhyay@intel.com>
Content-Language: en-US
From: "Dong, Zhanjun" <zhanjun.dong@intel.com>
In-Reply-To: <20260612070401.543305-2-tejas.upadhyay@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To IA1PR11MB8200.namprd11.prod.outlook.com
 (2603:10b6:208:454::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB8200:EE_|CH2PR11MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1585cc00-93ea-4198-5ec6-08dec88f8907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /y4G6i1l9pzNdwofUBs7rOHM1HT2DnHyGgQ3XQbwWzqbbUCS2E+Uiqyx8WRxRfuHHb3592CrTrBec+lnHaA1+4ppbtG6S/MguxpqGspgl3mpggpaZE04OARoQ6h+Qn8OutueSdqyZFM/5t47qTa3/XTFVj8LA8xCwdkZ9BmSkPhTNOjhhWj5cql7BOOFz93uSHikiO+f66zoeN87WCpEz6nqkylDzsugMkmEhgloa2LVLyXdxcgehV0P9l5WhkWUdca35lhD7CODlVikqalkRidcW7pq6v7hfRr6tM8BzfZPyskOsTtTu6201ahxAl2YulOIfff21ZgklwZkH1lkgwshOHP4/5rE0Kqgf/zfkw7fK7nlBOVH+hQU0auckcmE1cC2EhlV5grges2eeafhfXhaVw8QzsEKLOwDsvMzj090yEguPuH2yANSnNrqY+qcs28x+G5aDyIhyb5tUpmsrhFhaBHaYMOrZNtq5/CdipwWeNmT9Ep0AQNYg2HKiIM5WaR1Ap3pr0xIq3+R8g6wLooOi5yWciYo1lX4523yFicqnOhXd9C/zStpsx8KY/4Q7c4u1UjvWivw67bpcUZf9KSoCUZy86R4MTGVv8Z04JKMcqsHJay0QVsjZfXRpDxR3nAudVSs7GXwZF3NJUoItZGkhiilqCLB5jSUxHTDSoWpGrRBIhD7H7AJ1M5Hk8L5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB8200.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJSdEpiQnZBVjVEcE1rVTVHeVE1SEpKUS9pREMvd3EwVWpXUC9BWUxIUDVm?=
 =?utf-8?B?dnlaWHQ0Q2c0eUNUS0s5elBkUXNpUEdOYWdnUnNIMytWeE1Nd2RTM2RMOVF5?=
 =?utf-8?B?N0c0b3VwSmVqMHhkUFBsU0xCTkt0Z2hwTU9tWUplK3lsUW9sdkhjUEMzaWY4?=
 =?utf-8?B?b3BrWVJjeDZCNXNCN0xYY1IrT2Yyc0s0eGdMamp0VVJwdUtFOTJ6WDFwaDZj?=
 =?utf-8?B?eS9oNzZWd2E4MVhVd3p0WW4rb2puQ004ZFczbW00M1BScWhWak5TOVNSRFZC?=
 =?utf-8?B?elFKOVRHRjZoQ1g3eGFGZDBobWRaMldUclRqWlpIUS9mM3psdkhBWS8vb2tI?=
 =?utf-8?B?YVpQckFETVd5MGFDY3dVLzgzS0IzZnNWajEvT1huTnhQaU9ZanhEVkxHK0xF?=
 =?utf-8?B?RldRNHJCWnNBcGltd3JGMWpDaFRFcThJWEtCNENOM0p1R2crblBLRk5WbGE0?=
 =?utf-8?B?TG96WEJIYi9lNnR1S1pyUFo3UHJOV2c3aDFlTndYNEpDa2ZMa0t5Rk9rVlBa?=
 =?utf-8?B?Mi9rWEh5Mjd6WDZlanl0c01xdFppYlVEYUJKVkRPdTREZG44dWFxNmwrSTRL?=
 =?utf-8?B?elJ5eU5aaGRKeTlnNm1kM2JzVFdIa2pHdHVmSDIzeExuT3Fmd0JSekszZE5X?=
 =?utf-8?B?a0tWK0V4elNWMVMxY1doMUFKcUgzc3R4bEZ1d2dsdEplQlRpM3ZoQVozbWcx?=
 =?utf-8?B?ZWQrVm8xM3JUNXp2Y0c1THQvN1A5OGIvbDVMMmEzZ3E2KzlibENwdHRHS0ZX?=
 =?utf-8?B?WU9kRytiZkxIRzBJN0oyZWdnd0xwWTBRZERlY1NZcHY5c1FXS2wvWXIwaHg4?=
 =?utf-8?B?RXdXdXdOWjZzc2VpVHplL0tLMm1iYzhwamlHR09TV09VSStMWUtVZ0xZMVc3?=
 =?utf-8?B?TlFlV0t3ajBFMllJdlNIbDlWZG9EMGVpS2UvU1c5R1FYR29rWU8xeFQ2cjE1?=
 =?utf-8?B?TTAyZ3VuZkpQN2swMmppNVJhUUl1V1J0Q3JqS3RleGVZNy9yK1RTSHJrRWRC?=
 =?utf-8?B?TkVYa3YvdVJvRUZzNXR5anNqMU1XRXhFaW9aVVBJaGx3SnVPcEpRQnROZUNO?=
 =?utf-8?B?TVVLR2lBTjNraVlEUHdBbDFZTTREdUcwWnMrV1ZOaVdxTm1RbG9LU3d4Uklz?=
 =?utf-8?B?UElxcFg0bmhFdXhWTUFtRUlOWm9PZ1g0K2l0ZTYxSStXQW1HcnlkWUpyTXd2?=
 =?utf-8?B?ZTE4Y0xXRi9CTFg0N3MwckxjVHZBalZPYzdMVVJrZENvNXRSaEIzOHFHU3dz?=
 =?utf-8?B?emJBYTJCdlAyeXpjN3dqV0RWUlJGbmRROWlSVit6Y3Jrdml5OXY1T3lnOTJU?=
 =?utf-8?B?U0xabytEM0hySy9uTUw0eXVqK3AydjJyc3ArMVNHTzNkVmFVV0d5d2NHKzVN?=
 =?utf-8?B?blFvUkdaTzNsZ2FRellUV1loVWJESTg5ZFNlcXhza2ZLK3d0bUFMWVJkcFFk?=
 =?utf-8?B?Z0ZTNjdXQngwRTJxd0orVGVwaXVsQXJMdVp5N3NoRHRGQWdhVFVBQjhMakpW?=
 =?utf-8?B?VXRsUWpQcElmb3ZwYnF3T3I1aXJRdFNDZlU0QnZLQ0dSRC9PMlpqUGZlUWZx?=
 =?utf-8?B?UllnVVV1dW42YjY0MGUxRVpLVkNGTHIxa0Jlb1RUTWVuMzdUNjVmK2doV3l5?=
 =?utf-8?B?ZXJETFBCdlRqR2JUVTlMa0Y4U29BZ1lDLytNRFFncFFxR0xWNFVzT1NxOWZ4?=
 =?utf-8?B?MG5uNWRXSk9qN0FSLzFkODNJa1VYS3U5MnQxeXNMVGhNdVVQNm1uTnh5M2ZR?=
 =?utf-8?B?STRoc2YwVnpsU2xPdUhxcTZkemR2SjRxOEJNZ0RVRGhTOXNPVXBrTDVtT1h1?=
 =?utf-8?B?WVBncHJKU2YyNEx3OXBPSU9WWExld3NPQUlJb3l6YmpWbmZtZko3cXJUWHFU?=
 =?utf-8?B?ZEFoSXBPWWpSY3pBN3JwVVhWWnZweDByWUhOaDhVcWRtV2o1bW94S2huZ01a?=
 =?utf-8?B?c0orYlA1VlVSbFljQkNra2hSQVE3VzRtelFFODcvbVNsa1EwME9XRWt5Y2hX?=
 =?utf-8?B?Vm5PVURuQ1JqOGltaW5oTjIrbWNWL0gxeHZsTDVoSzFnb1lEZ0lXQk5MWmVu?=
 =?utf-8?B?TFBRZzdDTWZwdWttUTNuWnVZS096STVPNlFRamlHVy9sTzNWbUo2UythbHZL?=
 =?utf-8?B?YjlLZFU0SDF6NDZnZWZvak5qS3Q5YksvZTFEZTJYQzVCenM0aTVnSXNuN1ds?=
 =?utf-8?B?RXlJMDlyRVdYTG4wbVZWZGlvVk13M2tTQ3k2ZEpVTTRJS3B4ZWNCTVRybVRv?=
 =?utf-8?B?dlZSVGFxOUJ1TmFFRzd5SlJxclpDWVk4QytSZTR2UlJ3NTNYd0d1QTVzM2ZI?=
 =?utf-8?B?WitUak4wMGNENXNyK2VoTmRJQ2hxVnZHUnRpN0pHbVZrc0JCc2dVZz09?=
X-Exchange-RoutingPolicyChecked: MEo1HybSm9ph2wOp22S7AnbdC9G2AVE1iXFU9iy4f8uMyJMGOzPoEGiWQvMsiFvIdRl2gPAnlD9Kpr8diMeLXpvVzvmJ5COnUtg0sMVt73cfJn4OWjWXryIvFbUw/iUenfzsl7BBNfS88eIfU/B77UWW1GowW6jlJDMFybNThximWZceP3mgfsbW6g4V2c+yj+8tB4CUkBqwBc6/NCixT+z1Bob5szMUioHgsSvqLO180WhkrVWu8phrbnnGJmvJwkXAXTk+gsVwHdChPPehuFXgkj+ODrf5OxDEftr6g7xDkWG1LU4EbAA2FlBNRaBgDgR7nM/DfZT9C9EUeZ10Hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1585cc00-93ea-4198-5ec6-08dec88f8907
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB8200.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:33:14.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN5Mp8vt5r41QgHF8yDOPEKvhDi7p4GqjgI1Vf0+QYDof3t/EYehm9Z4ep3/QOgtXvX4u/wj6XTWHM/7oJMHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8835
X-OriginatorOrg: intel.com

LGTM

Reviewed-by: Zhanjun Dong <zhanjun.dong@intel.com>


On 2026-06-12 3:04 a.m., Tejas Upadhyay wrote:
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
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8049
> Cc: Zhanjun Dong <zhanjun.dong@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
> Assisted-by: GitHub Copilot:Claude Opus 4.6
> --
> v2:
> - use bitmap_weighted_or() (Zhanjun)
> ---
>   drivers/gpu/drm/xe/xe_guc_capture.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/xe_guc_capture.c
> index 21f7caf9ea08..1a019137ddf4 100644
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
> +		total = bitmap_weighted_or(all_dss, gt->fuse_topo.g_dss_mask,
> +					   gt->fuse_topo.c_dss_mask,
> +					   XE_MAX_DSS_FUSE_BITS) *
> +			guc_capture_get_steer_reg_num(guc_to_xe(guc));
> +	}
>   
>   	if (!total)
>   		return;

