Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793304965;
	b=gpcG/SIsmg6e4yjb7UtDaim+UCX2PJualTpNtVF9pMxTYRSNa137rBonetHevv9hF+ya
	 BkEEpAj7RZyPwqJhlNDVL1lt2GxCz/8IkL9G1C0eyQvU9CIFgrpJnCDpGWglXq+7JXvRs
	 pXDFVk2gw9ArSVQmefaf3reRowS+jd8/SeL0XJpJhaHy6rBtz3iqhx84g9gqVszUuR9Xv
	 ietBuHOHzWxmxcr+GtXMFB6fKok8BdsMIytB1wv/v028scyNmgNRuiI2uDRngiqBGT2ZH
	 WQkPGrtG5wKfzlf10yeG510SGojkJG/WaLb0YzmBstzR4/0UEIJ7uXmihrtmfFgiX3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304965;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=235KtuxyMvu9cepJxKm66BWLkW5M7M1sJXtC627SecY=;
	b=LUfwAr7MQdPRai9XuU1jemaTJVxs5AiatvtojH0XCc2N+3rBGziBOoAjkSKZjq/Tk2e9
	 QvlRYnVDvt2jJ2VI+kmG0r1TOKw/HKGzu5s0gcI633HORk2C8MT2KtWDv9FWGzAwzSE9H
	 YG7Nslr2Uu+SYdSDJZulpGP7QTZ+koupxsAE/MiC5gvNiF+TT7M2PatrvopfitM7UBlPd
	 490C2s9MDUqjIv2un3a29wKWp13eX64Lffdr/wZZEjMYKIvrxSHXa30VYCZH7vUi6j2dm
	 ddtsmMywb/yn7ix/gsAcoNwpWgpf5eXWgOOG7GL6nRfYWk0o8Z5djc2jG2DLab26RGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hG4Rgj8f;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECF606A31A;
	Thu, 29 Oct 2026 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64ECF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hG4Rgj8f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793304964; x=1824840964;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yB+E3YYHuXIPJRbTdmKoViBfXcuairrLAm4/eVi9vXo=;
  b=hG4Rgj8f+OUjGSD2lEYK9ZMYv4x4EXeYp2gbsmWPBAV6mMjbT0OCpe9J
   1RiW1XeyuC+sIZN+94sBQAKhN2C0EOeO8GJ2sw2azp+IrXOmI1OQL7GMn
   s3YDOyY+FrJzEO8esaTBMf7AnVvVrWbgJ9350W4mRi4roqcXrsdnB9+ub
   7gTaa2SQs4cwqXb00w4yS3yrsOVdyzEdjfzSTVIRuhAP8rHxN6PKIyUtY
   ndVe4+3vPcEfpgOBmwsUYiDxdZYPxZaL/QvbA7ncyEFjuJitlOCwbUaYd
   GpHLaOY6G8CdRcMPYg4r3OpxxslF8t44MT47JzGjRau99PkakzCs1wGIt
   A==;
X-CSE-ConnectionGUID: QhB2yqlwQX6yJMocc5wxyQ==
X-CSE-MsgGUID: Bdy+iuqASSOwPoIRPg0EHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2086169"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2086169"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 13:16:02 -0700
X-CSE-ConnectionGUID: plaQ74J7TR6hpu1XcXhpew==
X-CSE-MsgGUID: YlDSAB5dREqimS3WVFmcxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5636486"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 13:16:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 13:16:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 13:16:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 13:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uonuInIsj/HqC7YgN1DlstFBFIHYYbssFnHUCRPpKj9QtmutzTN1kWdtPtD93KL0FAcloLB3d+RyHzjgFhmx1UZ7X/TaUpM48ljoOlzv/RRaCsYQIaZA3gJOdlkLOJqGsUBSHF7ujBwBHggN9YRopm62rvMgtJXAHr0GBs3D8woNs9ztXWFs3C4ssWSAM5mz+odv3ORAm0pAY3ORFlmiFYK1DC8EFcYh1/EJCNZdQSQcZQhUEePo0820Ya7oURa84ktjKYYFuXxh933M72rvttimknefZLLW32XRLxa3PcHvuwCu80+dUpe9KINFqaMvXCmjiBUsuCvF4wxSG0qOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=235KtuxyMvu9cepJxKm66BWLkW5M7M1sJXtC627SecY=;
 b=VHUeZoDvt5iJv5AUfUMopKpKHBsC0kPnkWhK1iHy8LeBu/tzzRINRjVXR0zqK3f1tNUsl8WlgScEoNkul5EhKCMi9VSOwmT+jCvE1wlPpu8wh6QQkDIgEkVOaGmjMsNxtwXDew2FF8fDJuf/CAV9Y8zKmwM8sRJwqyngVxI33ri1qplB+LaYffJ21sLCzwe8vI+25LaAguHBTss7RJHfHi8Rdinn502WWSpUznd7iAw0algE+M1UdfJYsxPGZuuomoZ1sZ20a51hA6PqAshfQ3R2vsUZlqZ0bzUp193Pzuoy2vOnxIyj46MkY2xjJn2xba5IAebBgl8iSz0Fin1KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH0PR11MB7616.namprd11.prod.outlook.com (2603:10b6:510:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 20:15:58 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 20:15:58 +0000
Message-ID: <9657346b-95be-4360-80ff-328bcf29d2b3@intel.com>
Date: Thu, 29 Oct 2026 13:15:55 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v3 0/2] x86/fpu: Fix dynamic fpstate leak on exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1793072271.git.weiguixiong@bytedance.com>
Content-Language: en-US
In-Reply-To: <cover.1793072271.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::19) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH0PR11MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: aebe3e4e-5177-454f-26d8-08df35f97187
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261021123027099003|261026140227099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1/tCIOo2Pjq0QrnjpOKjC54ECRLHTt5Ir0CZtN9O02NL+Lv20fTr7YxmfCyW0ofykyo/XPU2cclqkFukTKg/Xab35OBDB5pJ0lSIYbps77P/2r6Zc9MON0z0sXcIrJbX4XX2IyLWtKUSw7twxTOCc7fUEqBjYS5uR9n27j12vPNZVV0c2m2HWjMUbtQQMjdXZSLTMiYM97WOmW8N/Z/vgWEYIKjG5xnaZmjcsUqI5Tai1RTEjB4JAzStfb+mVO4S51AdL1NPOspMYFKQ3O3VAKBoKtQpz0vhqBZmVRvCPmOYMXLODN0ozphWAW4NTijR3I5AHmk8cKZNZfczwQsihS11XmImsBGusM3aIGvbz2dxUW1J2TJHp6wfODliWJh2BjA021x0lFKv8viUfjIGiQK5dur9z3F10MJw9z5ThdhmIZRtmPjNhAnAHperG9CWve/pEgAcUpt4UbeDpFz6Kh85oOlW0BacIzyLT9vvK3db93s9sN4+m45DHHTybESqkwqIfMcHo/Omq5rkvscf1mIpI7aZOsOUuPeo/zq1dUSBWpZ+N94B+iqztBunt5WAcbwNGY2/EoIeIYwS4uVZpLuhRQJcRE9FUwHCvq5mV9fEHvHdGcs7Y3fsvjXicCJ/wq/XWXhtYz5athadtvJ4Ansvgnom9CSkaE3IynS5p7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261026140227099003)(10067099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXYyQldoOXJ4N0QvaFJWYmlITHNZbkRON3NXTUtRZzRXS01NWE5WcWdKemdS?=
 =?utf-8?B?VXF1RytDeXN1Z0wyb0pWeXFES2pnUnZoRjl5VnRBN1RJOXhEZ2N4Sklycms4?=
 =?utf-8?B?Q05WWnJkWld1S0dZdHQ5dSs0V2h2NFlHa3JTTTU0cEtsR2FDb1A2OWxVMndV?=
 =?utf-8?B?K1pueWdteUNNK1I2TStOaTVqTHh1ZkxoQ2hGY3FuRE5wRlhSeFUraUo4c2Uy?=
 =?utf-8?B?NHRvaVh0VHRhU0RZdGJSaGdCYVhPTERyNzhZRnE5aXF0V3JJN2U4MCtLQWRt?=
 =?utf-8?B?S21Qa2gzT05YakFkdk50NXB0QkM4VVQzWGdLUjNoZDRUdXpVRHdZMVZiTUxV?=
 =?utf-8?B?TC9sY3JhR3A5L2hianFibFZDZytLejlxV243RXlmRlU3UkFQMXNZeGV3WkN3?=
 =?utf-8?B?N0s2ZkMvMlNsMkgydk5GcEpybGg4WTcvWE44RFJHUTNTNnlVbjQ3ZldqUXdo?=
 =?utf-8?B?ZmxBTzU5VGMyVU11UVkrdjVzUm8xS0FtTzhRS09JMkFIeUJWRmxDS3hRV3V5?=
 =?utf-8?B?alpBY05jLzhLeEd1aytjR0lyVExtcHB2Q1V6Tm03bFJkUGNBQ1VxN00yMzdD?=
 =?utf-8?B?Rlo3eFF0U1p2QXVWREI4dlVZVmNwVVJmdWo0MTFodzIyVVFVMFVIZ3JFUjlI?=
 =?utf-8?B?M201YTdhQVZ5VER0MHliNnBKNTVFMTlrN1lUWUY4UDRNSnByaVdvWkltZWND?=
 =?utf-8?B?SmFnamFMK21aZ0dGcUo3eFZHblpiQWk4ekNRcEVjWDRNaDM2R3FhL2dEcmkr?=
 =?utf-8?B?Q2VxTHBVTmdxQzFQUWVhUU9IK0lQTHpEeE1naUFtRXU0VjVhMStOM1lWTExx?=
 =?utf-8?B?dWw2ZTJKN25xZDFVMHZDMU1oazR3Rm51eGp0bnZMMkVZanZ3RStVb1lGOFMy?=
 =?utf-8?B?RGlaNVc3TVMxKzFpQlNYYkF5QUJ0Ym50R3NWeXprNHJqdFloNmo0WlBvc1dB?=
 =?utf-8?B?a29seS9KRHk4Wnppb3JDQ2tDcytmRWtnZC9kbmFadDBlSmdndThXR3BuVTUy?=
 =?utf-8?B?SGVSeDJYaWlYUzYwMnVncm1qZ2todkcvcE02SGFFNlZvSzRwVkZwQmhtRHdD?=
 =?utf-8?B?eGYrSHd2dGlITktCUDRocU9KbDVMV1dZWTdhd0t3RDYvSVBRUU1mWjZFb1cy?=
 =?utf-8?B?L3BGR0FOODE2ODRXczFtMldDa01WVzZCSFF5L0ticy9QYVQvUm96YXhYUU44?=
 =?utf-8?B?ai9kU2x3VHAzdHEwclM2VVRIeTZqbmhWeU52ekI1KzdvWU9MbXl2cHptc2Vj?=
 =?utf-8?B?VFZUbXJNdlRhMzRLVFR1R1lGN1h0THpQZHM4ejArQnJ4dlNldHNqSVA1MllT?=
 =?utf-8?B?WmF5K1FNN3NXZDd4WW5pTU11dzRlZFg2Z0xVQmw2V3ZUS0d4Qnowc0xicEpY?=
 =?utf-8?B?Um5qc1NLa1ZacFZqcUUybEpma1NuQk9QcnRkTmtQWmRwWXRMN1FwUEMyckRV?=
 =?utf-8?B?K090WEpXZWRYNXE0djBWRkdRRm51T2lxWk5heTh0cHFaL2M5eHphQjFBZTMz?=
 =?utf-8?B?Wlh4TzBPTHB3ZHM5b1RkMEVQMzhLc1lneU1KSEQ0L0IvdUJLSFRSN0ZWVk5m?=
 =?utf-8?B?ekxCSEVGNlljK1U2eWY5cXVFQ0prWHREZnl3SmIxaWMwR3Fjck52eVJCYU5Y?=
 =?utf-8?B?QUdDQjRUK2VDMzI4SFR6aTl4a3oyL3dsckxLZGNHRTdJNkwyN3NKS2MrUm85?=
 =?utf-8?B?L3dES0FtN0MvT0pFQ1FHRFlqOW5kbWlvUHBJRmU1aTFZTFpLQ1NGOS9hdkM5?=
 =?utf-8?B?OUhuTkh4WldwaFBvcSt4cUJPT3RrNythSENnUkNPc1BvZHZldUJqSDBOTVB6?=
 =?utf-8?B?c09CNVdxTUZ2VGFtd3YyZlMxK25xNDBZQlRIb1U3cFp4czV1QkVFc1ZuVXU3?=
 =?utf-8?B?elc3b3NHZTJDelJRT1Vnb0RtQ0F5VkF4cE43WXl2K0EzR2QzUnV5M2NvdFNO?=
 =?utf-8?B?dmxWSmVqakRDeDdGbnFoeGtXbGJRRFo3NHNIMGY4ZENaZ3ZwSGxOakVGNmVK?=
 =?utf-8?B?WFg0ZFhKWjEyN3FwemdvTEE4NGxEd3B2eGhMdzhmbzljNFZYVXhMczdOV2p5?=
 =?utf-8?B?S0xSRjlXdUxTQ0Fhc0VxWHc5RkZTb2ZFYXhFWUNUck5tdVJia0ZzeXJkaUFi?=
 =?utf-8?B?MWpGZ3pTNnpsWXViRFdXOEl3TE0ya0pDRWNDVFdEVUVjdnV0OXpFWXV6S3Nv?=
 =?utf-8?B?RzhHVGtRajI3YnNCUEwvamlTd3hiNlpJWktCQVpxY2dORDgvUGRpUU1oMlRn?=
 =?utf-8?B?eUMxVmdDdWVydGJDU1ptdjcrbXVHbjRVWkpzTGE2OG41VHQrd3BqSTdTQm9W?=
 =?utf-8?B?aTRFM1lndXEwUm1KL3RBT3cyanRTemNuYjVCTHFUd2tiVU0wazZOZz09?=
X-Exchange-RoutingPolicyChecked: mfDoZtSMfeFCluFx2ZjVsWaLNyUSIhb4GSeuY3LUOt2dyfYOzrRHz83zk0QAJBnkfoG7N4Ifkz8Ltq6e5aUeL8607gs3kz4k85UQ3dgyzRVo4kUOTCM8Atmt+p9lUEen+CBOOyHMZPNBLIl4kFl5xfkEIcephQ3ZLx2jN+5GRR4ZKYF3m9hhsQD828rGMFI4lesCkuuvyCubHlIIv2TbI4mdIPJUCGSvKINuSIfYPQvuGhkjkVhS9jsqwTHhsMu4jlU8GScZngu5NUP5Duu4jyozUIe1X76j5T4DU2yGN1jRt8He9b65WcKH3l8QfWF5t+70uNOISvLaC+Ej2hFz6w==
X-MS-Exchange-CrossTenant-Network-Message-Id: aebe3e4e-5177-454f-26d8-08df35f97187
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 20:15:57.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq1/QBs3UMT4EVVzO/j7QyHl/Sz5q5GGqTh2YJCiVTsbw0DbqVkcjT9R03yQf/NNRPDPJN02oVuE/PE9MiGjmFUMJjB8yJc3cIlrWN1tiqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7616
X-OriginatorOrg: intel.com

On 10/26/2026 8:44 PM, Guixiong Wei wrote:
> 
> - Add a pipe-synchronised pre-flight check that confirms the dynamic
>    allocation is observable via /proc/vmallocinfo before measuring the
>    post-exec() delta. Without that gate "no new entries" is ambiguous
>    between "freed" and "never observed" and would silently PASS on
>    kernels where the allocation is not reachable. /proc/vmallocinfo is
>    the only user-visible signal for a leaked post-exec() fpstate (it
>    has no task scope once the task is gone).

I can see the reason for the update, but the change looks a bit 
complicated. Not saying that change is unnecessary, but I wonder whether 
it can be simplified or not.

That said, let's close the Sashiko comment on patch1 first.

BTW, it looks like this series was posted twice. Please check your 
posting shows up on lore before sending it again.

Thanks,
Chang
