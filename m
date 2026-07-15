Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253BF42BC44;
	Wed, 15 Jul 2026 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074636; cv=fail; b=aN8AZNrd+NimEhY3gkDVtRUTyM8WCkxQeXKNrwj63HyT7HI05wh4oPl6w6q8BWP3619hAShAIpKgN3cQ+xLvRca6SPMLNtBFaSufQdDJs51Y/j5PvLF+n2LTlYftfiYjYy4caTX6f2aqjXZ0pJoMfP+YS1jFv2O0OtG9oq1ISPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074636; c=relaxed/simple;
	bh=urMTBVq2cfNyjIGKFRs6p0ur5so1ZzEenU64Pin8a98=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVaLJCd78SqzeOH54E1xfPHtxGtzvuSo18sqvcD/UR9fl6kfADxe123MELxZHB2t9UgkPaGTKoz1CbPKdM/ghseSxhyF43GHZjk5GJM712GjrmV59APBUAsp2rpICrsJ5OyPjqjkGHN+t8WEgj0nmkApNQwvDengFarDvfMGnP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEd7zU5O; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEd7zU5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784074634; x=1815610634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=urMTBVq2cfNyjIGKFRs6p0ur5so1ZzEenU64Pin8a98=;
  b=TEd7zU5OItiLTdcf/wQmlzOHoSN/ngn/RAmlbLBkMSkCwnKcJvm7Pisa
   FmiouJLl5LHNCLOWi8tdqOdJhDOL1vZ0iIHqyVbb2xXxOaezdoZRHUYie
   9L1nMEeP0L5IKC2GaPDYOVw60kMDIW18QTgNJ2o8rNVaiE/cupx3mX/lV
   b2sDnHhJR5Rog/KAvoDsU7oT0MC5sUyhEOd9SL11DPTuqrYmZOyjSjohe
   tMldWofTwTAzhbkQ2nIiX53lvOp8Qx7NMAkeVQWKXPR8jvfiNw57lBaTq
   E/FdmRfABaAHXXwa0LhjjuuGKK3P5X+T7hwyoB3Hh4yruof9t3RrtGR8o
   A==;
X-CSE-ConnectionGUID: +8r4SRusSv+22cMF1tVcOQ==
X-CSE-MsgGUID: 83YFJbw4SomV3TDZj+CKtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95851394"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95851394"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:17:12 -0700
X-CSE-ConnectionGUID: hkuX0kTvSg6MI1FsYIMLBg==
X-CSE-MsgGUID: LV8SQpSvTh+NA9UCIeVb4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="253388107"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 17:17:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:17:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 17:17:11 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 17:17:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFdCw4+K/TOTP63EP9UsSI8loR6dLACPtjTH9ihlsBTqd2YYnrGHc/7/0J/Oz5Xi2axy2+TRIRXyNDk3fjjOLFkV8jxBZv77gXq4BK2CZ8bglgaUWtdXXQoXnGgeJzX0XhquMYOXAYpEhAkWNsEFYD8x1eDyPvLyZN4Top6sIolIVOV0Z4iP6HxP/8r5FKO5++nkfGYamxSB/zKbwShGZLNCHdExK+LIiCcTAu5qZO4S/jtCAFyWBNRExW3LCb7MSxlT6NfRJDlEBXBZfDwQFRIJncBk5ChlfTKmUV0rcqD7s0V4wDtDsOp0tbImkt98lMFvy5MQXiPU/9EfdQ5b+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxUCACYXPhLdxHyMU2T6HqHySH0caaYpO/cDOpTaMlw=;
 b=DZfmB2WXRFq7hcS2W/de1qbVg+GmWsDua++Q7CxL9qptE/N+V2uZLCXl2YpmZtgpObH064z1+uRoHnzNTqpMp59WovaTZi4dpcyMdl4O4sSnFEHa/vKS74lL9nqMtZgH6Q50iYnbhsoVJw5UdPgWeqpoqysDISQojCJ59hSysP9I6QlE57yjbcvoo5heZqOJwmT+8dbrd+OvjMgPNg1tCHHWtAr1ufEe2Wx9UL1oaAcYd7wvUdCcmQrOVqkMei4TLIAvlDUuMsFvBbHlCvq2oGUwMPVL5lPuQTqIeNOW2gTgGxLF+mVjtUzXq2heL+2dnp1q4ZJLNr40bs05RsfaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SJ5PPF37792A6D2.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::820) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 00:17:09 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 00:17:09 +0000
Message-ID: <a361aa28-7f55-4476-9072-aa392a34b735@intel.com>
Date: Tue, 14 Jul 2026 17:17:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
To: Fan Wu <fanwu01@zju.edu.cn>, <netdev@vger.kernel.org>
CC: <przemyslaw.kitszel@intel.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <dingtianhong@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SJ5PPF37792A6D2:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc4ab92-8a0f-4b22-fae7-08dee20668df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0DyiJMKONBtbu5ot1dQ153ACG+vEkLiw9JNDzqApoB0swfMMHreVxtgkte4N5paI2Nv5vdm75j3oimZCPzLPYYgfvhRzYja6YlvM/vaY3W97FAnXLteximG8cKw6/CePRw3VAd2i6JUxfhth4jmYVHUO2YC8WWtFkn0sPvi3cYVTcSSAUaKQlPFtjPSN+Khw3m2cXB1HO1UScwlLn071ua/CTA6VdFfzmRs1GwcJg5WCAphffNATszG2voj+4N7qb6OW2bGX8R19Vg5VrdTXCCjK7blVQ4weao0IfxxAEyXyl1TmhUZ2wdZ3iGcmqm5/oxPB93gzkwaT0vFLOkHEKNfhoefgKb/azx3G9kaRo1s89/DfLie1V+eZMGwb8iht9VYfRNr09HROypBlOBYUStTX4Vl+UdYnbzFUFgaw11c3hexdAZynX12qGbijBQWAL7sEdMS+KgwfaRAP8VD1KpK3c3jc0eOuIHbplzEsiC5ZgybYAUyNcetNHVuQcD1tl9liQbYZFUay1ojvc2D+bHjHl7bDXE1VRsQBfG5lsORLgtANuuv8GSEL3l60cVWFb6yB3e1ssETgRLcl6JuEea70J8TaItUrGOXmOnQRaLFIIc+PHaCDmz14Apm6qiHbMmA14bfH6n7yJ0/vziRsfIwBZ2Ik/PTr2HapkB7CX50=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVNGb1JFSkpWNUxCZEJqMTF1VXh2OUFlUkFVOVExeVR4MXc5VVZIQVdOMVJz?=
 =?utf-8?B?bFF1MEJ5SVVlRm8zbmFnczlwZ3RHYkFXb1Z0clh1RG10T1JDMGhMSGdXM1g4?=
 =?utf-8?B?M0cxMmJlM0FGY3VGV3hzYVVmNTBneVVhZm9VTjVFbHQxZDZiZURwMnVWdWFU?=
 =?utf-8?B?M3A2YmVOZ3UveDdYNzBBM25qZWtnNC9GeVcxa1ZqbnZnbGVtMS9hcGc1OFF0?=
 =?utf-8?B?bHFSelNIOGEwVXRGODBlSVcrejllOUFiNTl6c2NSR3lYbzF6NmQzQjZVaGE5?=
 =?utf-8?B?ZTVUUjZxQ1NvRSt5NTErNWVwYlFMZHNMakNBWStHaGJWKzZvZ3diM2xZaU5n?=
 =?utf-8?B?SGNPTkY1cGlQa1B6bnl2VWs4OW5EbG5RQTA5ekxFS21zWUZSbnBXOXMxMlRx?=
 =?utf-8?B?MjhUenNkbnByOW43dDJGSjdvRFhjb1RRRW81TzF4QWNVY3RzT0ZvNzJZZ0pn?=
 =?utf-8?B?SG55Nk1XQkFzeENmRVhZZ2NDMkpWcThSR3JpWmo0RklqeXFHd1JNZjZJSDR3?=
 =?utf-8?B?WmswRVd5SmxaVnVSSS9TNmFhaHZBOFpoeDYxbzhyc2x4TkczelAzbjR3NkVG?=
 =?utf-8?B?M2RQTHJZVjh2TVRQMklkbDYrSWxIZVVRT1lRSXYvSGJTRHpBSzBkbGlWYXll?=
 =?utf-8?B?WXU1c0VOdWUzV2VYcUNyWkVqTmRuSlI2cUEvWG5oSVplVEFBaGxSWUo3Zzc5?=
 =?utf-8?B?TGpJek1DcDNMbGF5eVZTei92REdlUFk5ZTNLWmhEckNLL1MyZTN5V3orS1NO?=
 =?utf-8?B?NmdLdFFSN0VpcmovM0RxUWhpVkJwZTBZOEhUTGozbVMvdWRPbVR6cWlOdzBp?=
 =?utf-8?B?MUFNK3p1aHFRdVRTN3kyeVlHcjk0MmhRU3kzMHRwZytYMWQ0RDJnTVhUT2d5?=
 =?utf-8?B?SUpnWHpmWEl6T1pxbU9ObTJsMEJQUmI2UWdvWndPUmZUdFBCTFlwdGdWV2g5?=
 =?utf-8?B?MkxtWUMvTGJsZ2dDYzIxUElBMnRzeG9YQzJwQ2FLNVZ1cTBLN2s5UDhIQ0h5?=
 =?utf-8?B?NmRzTWRsTjdWZjF1c1RVbTN3aHhRcjArTCtpM2R0L2dlS3lEOW1tYzFGWTl6?=
 =?utf-8?B?ZWloWnFwT2l0MFFCcm93V0V2RHJFdmU2MHh6dTZmNzQ3OFYxa3FRRkIwdDNx?=
 =?utf-8?B?SGhaU2VtQ3VzWk1YSjJrQVpNcTZVRldqeEt4ZWtOSTdaUjdIZXZ6S3YxdVBR?=
 =?utf-8?B?ek11OVVENXlBbXZHN2tScWJCV0pGVktNbUtVRHovb1hFamdUMm9mU3A1ZDhV?=
 =?utf-8?B?dU40em1FRllpWDVXM2sxMC9nMFJVcDVORGVvM0NOZUZuQlZjb3FVU0krNHBG?=
 =?utf-8?B?SXYwazZlY3p2VWlNVldiT3FMVzI3QkdkbXlCelVPQjhzQmdnNFFuUVlrYU9F?=
 =?utf-8?B?ZEwvS1Z5ZWNLRU5oVWVrWFlORngxb1hJemVQb1pCOEtuM0hFVUc1a3RaUm9Z?=
 =?utf-8?B?QXlWMlNZN3VjcVZucm00NUlWYlpOdmdGVWpQb2UzN1I3ZzYrNityclczUzJ4?=
 =?utf-8?B?YWlzNnp6elhVVFZxUmx4ZGtGcmtWbk1RVUdtMVhpaFlvUHhYMWhMRGQzN0RY?=
 =?utf-8?B?T1EvdmVXWjIwcHg5MUxwaFZMZEpncjBnL25xdWRuY1Y1d0dLb3MwbXBSL1ky?=
 =?utf-8?B?RUtoZTNhQVJHYzBGY3dYWWxvMlJ4ZXJMVGxtVjd5dDZuS0FTS2IwaC9NME1M?=
 =?utf-8?B?a2QwY3RhcXZOeDRoK3lTYTQzTlgrQXhxR1JPTFlIOU9jdXE2NDNENjJ2MGF3?=
 =?utf-8?B?M0VucmM1MWRKR0xkWFAvS2dJMm9VRHNzYm1zY1BEQThyc08vazZSM2RvNFFa?=
 =?utf-8?B?UXZMK3VBTGgvY0NlVGE1WDZJVklPaEpNdFlWOGNidk1GdVpLNm5MQ3k2MDRH?=
 =?utf-8?B?aXk4OXdNY0pFbzdXTjlnbi92ckZDdWxQeHAwRkZwOCszZzdvUmFjdGJ0RFRZ?=
 =?utf-8?B?d0dhY3dacExYSG8zTng2SjQwc0dCeGhSVk1vT0VaYTRSTmpNcXdvbUZmaUhq?=
 =?utf-8?B?QUVsNkRKU3lPaVJTeHRMdXVDV3FvaGduRUNmQ2xIN1JUQXVwRWpDYmFsYUpQ?=
 =?utf-8?B?ak5pbFFzSURIeHp5NmtNb29EeHYvU1J4bklKVHBBUzRTSW81aDkvc09OZE5X?=
 =?utf-8?B?NnJpVDcxWEFFZFJScHVEVDk0am9ha1BMNS9jb29FcFFMTVhtSXlwVFZ0TEp2?=
 =?utf-8?B?bG1IcTRsVGJvb2g5R1BPMkZWbnV1eXltQk1hTXY0ejRJZkZGbld5S0JIZ1F0?=
 =?utf-8?B?VllGVmt0VWE3aC9nOHZSakRscnVIWlpIbkVTYjFuRG5LVDJ3LzhtSElPbGEx?=
 =?utf-8?B?SnBSL1pYamZTUzFQRHBhMlUrTGxvaTZWc2o3bUJXMGhMK1RncFBldz09?=
X-Exchange-RoutingPolicyChecked: R7tCYHxeRS3piylCAPsS4rbrqCdbLjbe1OfSZI8nsn5BGDJNfLlGFZ2q+jty9Ro9KBd6dyHD1cqNj4rySluN6/uFmeiE4vPJBImLUjIHrx4S0HISikg6oqrg8U8T5wKCIQbAtAWGqqvzIpc0hCtDjP6RYP9BWa3QVVx0hEwxIrjKpL4p4AuP9vriBuTH9wzfctdOrG2iUZEQ9MobfXl4//6NkaY9wcwPHXt8R1keRIFfJ2nMY9GFgnDQhwAibc7LikaRQ5Fc8uKICp9a7ed/jGmj9JaBnvtG8NlSFxyx6y1riZ00bCkg/aD//PqnRNlP9iWdzcCfLljNUs6zpm8hlw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc4ab92-8a0f-4b22-fae7-08dee20668df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 00:17:09.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aY0q3htg01ZwMFcFaiRTdKw/FF2qldsBcw9MKhlx5xiADoDiW4V2l4MFzdSvDUKxYfjYWXQaw4ca0fmmNr70QBMuIDeURgUMtx9T/rDIlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF37792A6D2
X-OriginatorOrg: intel.com

On 7/12/2026 7:27 AM, Fan Wu wrote:
> When build_skb() fails in hip04_rx_poll(), the driver jumps to the
> refill path without releasing the current RX buffer and its DMA mapping.
> Installing a replacement buffer then overwrites the slot references and
> leaks both resources.
> 
> Keep the current slot intact and return budget so NAPI retries the same
> buffer.  Also free a newly allocated RX fragment when dma_map_single()
> fails.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 701a0fd52318 ("hip04_eth: fix missing error handle for build_skb failed")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 

You say this was found by static analysis. I imagine that build_skb
rarely fails (without some sort of fault injection). That means this is
likely difficult to reproduce in practice. I know we've been trying to
err on the side of increasing the burden of proof on AI-assisted fixes
like this.

Based on a quick search, it does seem that this drivers response of only
logging a debug message is not correct...

>  drivers/net/ethernet/hisilicon/hip04_eth.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index 18376bcc7..1d03039b4 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -594,7 +594,10 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
>  		skb = build_skb(buf, priv->rx_buf_size);
>  		if (unlikely(!skb)) {
>  			net_dbg_ratelimited("build_skb failed\n");
> -			goto refill;
> +			/* Retain the slot; return budget so NAPI retries this buffer.
> +			 * Refill would overwrite rx_buf[]/rx_phys[] and leak them.
> +			 */
> +			return budget;
>  		}
>  
>  		dma_unmap_single(priv->dev, priv->rx_phys[priv->rx_head],
> @@ -622,14 +625,15 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
>  			rx++;
>  		}
>  
> -refill:
>  		buf = netdev_alloc_frag(priv->rx_buf_size);
>  		if (!buf)
>  			goto done;
>  		phys = dma_map_single(priv->dev, buf,
>  				      RX_BUF_SIZE, DMA_FROM_DEVICE);
> -		if (dma_mapping_error(priv->dev, phys))
> +		if (dma_mapping_error(priv->dev, phys)) {
> +			skb_free_frag(buf);
>  			goto done;
> +		}
>  		priv->rx_buf[priv->rx_head] = buf;
>  		priv->rx_phys[priv->rx_head] = phys;
>  		hip04_set_recv_desc(priv, phys);
> 
> 

