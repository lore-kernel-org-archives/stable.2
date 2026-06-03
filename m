Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B99386551;
	Wed,  3 Jun 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496920; cv=fail; b=O/zL42O9f8KivP4TH19co/rl8dOnNRMwHx+POQNHasCAprSoUUQEWccIh4n/+7Sq1cZO3cQmoJclqt2RgyRjzGM66H7Eo4FBHK79QTNo7zXmjt3Al/Oie2S89Hc2TECuuJoELJoEvGq1wD/BiezcKEQZoWcg7z0gfwcOX+o0Hag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496920; c=relaxed/simple;
	bh=HRMrtUGBVUjc+O2TBoj4PDw7rahLurw/8aqLyKdJWUE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S2xRXSAoUIMEayO64UpvIAqzvynOuLHqq5jgGTuVrGYXdqObUlzZr2WfsOz20CTFxvvSCeZk1wvYcmp46vkjfy7914vGeRYBEJktirlGXw8V/gFaXaZDbwpvTuHjiTqOql4kct6NTK6XJYiQyM9EBNWvKP3U6sKP111MPR8yTGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeUWUn7w; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeUWUn7w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496919; x=1812032919;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HRMrtUGBVUjc+O2TBoj4PDw7rahLurw/8aqLyKdJWUE=;
  b=JeUWUn7wahTNVLx6m09dPrRgyiJkMqAgsoHfEfMSSAl20u7dd1VK89EN
   haWnP9aY2Icoog13AoX8p1MQ7bnzZ3QiraOHB5LyCmV/x68TSB2ANipX4
   3UkLda5YP0KfSF54ExDyL2UacJs0d1TyP1ENA/gqImqTLSArAY7WP8A/O
   pcJ2YtBVeE8FQTSRjzeV793gFM0X67tmuo5yn9dkZ9l/tYfp51Xs0tqoj
   yop8zuqRCNPTXnja8rft3p9/PhoNYhRtRI+0cj78VLEvJTaCXQnYkGcIg
   e/T0ng624GtFLFTzbFM5Ckntx5R+0+rwaxs9a4rPMJKn8QlB0TY9iSa2j
   w==;
X-CSE-ConnectionGUID: BaQlySY/SbeoGGeUZGUKDw==
X-CSE-MsgGUID: x4LQjmjgTzSKLXFpaVSa9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81490016"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81490016"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:28:38 -0700
X-CSE-ConnectionGUID: ipoT73MeT2KLYi3iFeoluw==
X-CSE-MsgGUID: 7rqrd1IRR2W98tA9eqGkkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="249167621"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:28:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:28:37 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:28:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.26) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hpw8QSzb9HP0/04qWpUlz0DeL6GbyeLdhPa9860RfwpIDdXBJxaA+/eEdyKQLeGGoneVueJVhVGLY1LKfIDbxz2sKfNbFUxcNzZcmTKxHkrck7r8A6sKRmedE3V7tn2XmGKHuMhbk7NDqeG2fMJrldxmN9GZYuPUQTpJ3TX8J5vbGUB/2UCPg6pn4G/EetIqKcyphf5oGS5QnmHtBkjFYriRuV8ugUR6Dp8ZVNGrOGLW4HSkdNnWsyP+AYK4UMA9umVBD4O5yZEPBFMiLtZN0We8BbEGMsLIvwfGM/YdIA+XEVAiF5l6/5LzMjodA1CCRsAweIWdayEgn6EgghpH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+yvo3c0xInZcnYjF/hdQ1Z0oW2xlrsDNcSiJu0U0NE=;
 b=Eng5muTv6mjmABKOSG2WZNabbMXOIie36O7SfhGF8u8EYfV0QtZALyFy88fxUgqLwRNCrSR1ArbslC1zkHHbUzM8JZ1Me4TlP0zpkXo2YQtWrG/voedO8X09VkarJzTR1h+Le3EO2Aab31cAhdJma3SdLXE0ixWUTS+IJ8ie/PmLF1OHn3GSgPYOqT0ZTY+6fMWQytpDFlCbwWm+8VIXy/lxDT5w434FuWfGfs2FQ039MmNoEAFx0ccAPkuWskPcsQuP1jBwagasQREex4grjZIB2LPyzKhaTpFgLZ00jGWZVXIa/rU7wat5lmTcARA9S6AyH1/Jtr0pgYjzycnUWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:28:32 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:28:31 +0000
Message-ID: <2f3ea9d6-a483-427d-bf81-ff26627f4f1c@intel.com>
Date: Wed, 3 Jun 2026 16:28:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] nfc: digital: clamp SENSF_RES length to the
 destination buffer
To: Doruk Tan Ozturk <doruk@0sec.ai>
CC: David Heidelberg <david@ixit.cz>, <oe-linux-nfc@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260603141355.68156-1-doruk@0sec.ai>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260603141355.68156-1-doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d050e9a-8231-4d30-1523-08dec17c631b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099006|11063799006|83080400003;
X-Microsoft-Antispam-Message-Info: zcNuw60mamZO4ax+t4PzRDWnIw1s44UXTWJx6lsQikecz0v9EfcC3/54FKZlzLRCmMRxxOG0mWkmbMSqjfP4K/Bt1MxuIvhN4Jg8YxG9jVpE179s/25CGx9sdjGNhShGB0lKZdYPGDKaloGji2TrdV9UiFbGR5fADtsGRmV3gBp5MmGEScTOBZHqtcs+GG7QNV53bzC+MsMVG8dD7w/q1genq2mwLRJFFXNpfdPM6rrp5PuAUX0bBAhhPOd30ZeyhLv5rqmZm8OSVVjQGC3U5UApGlFFevQE670o8811amRlWYEP7Lzog2kAXc8ZEIwjyg5EhKKzAiIfqkh2AK6X7BQcNleinsbLNtLDP8mZCWisS+wIKK5Dc2+n694yFWxNIR9CPOFy6QojgWy6CRB+L9TW2pGXZZbxteeu4Mtvlm72cmlivc0MG+9a7Xckv1S/C3v4BkHy+Bvn9Hv5OI8b61STKrOmv8VBmeSQwX2lyOsYD+pTMmcYcucYpt6gjXpKx7ZtD3VnSP8S/JkITDcwflF5IHs0mEvECi+INK1gURWZdZVTR9YkKNEbFJWITd3Iwl1Yp6JN2Tddv5YT2ttGrUP9we9vyEZCncEH14sA0YR+AABL7ZSKJpNLh1qmUXumwKgYpTW3gIW8x+qoQzN22TTt3MvCkuYQTMa9swsH+kU0/QOl8hrz7aft3Ix6fwdX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(83080400003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlRUb1NQRjBGM1p0QjVlZUxybDZ6ang0aEQraXZ3Ym9GVXJDY3dkOTRjbnh6?=
 =?utf-8?B?cVpIZWg2M0VCdy9kUmxBOCtwdEhQN2NRbjZpemxsL3hHS2R5aFVLZjRKbFVY?=
 =?utf-8?B?aFpqcjNZT2daejhVV0hmQWhHcE9FRDgzY3dvbC9sUmZlUlJVc0E4MVR3NFVD?=
 =?utf-8?B?b3QzMDlqUHkzdXI5SUMvbloybWxqWU9OWU1VZEI2Q1Y2SmhXMzE4c1pRTlJT?=
 =?utf-8?B?VWdobFNORStYTXVlN1dDMVRyQ0M2c2dPdTRnUllTTmhxb1NOZHN3anJVVHRN?=
 =?utf-8?B?SlRpTTY3eVBYS3JpcndZd3YyV0xXdndJRkJUVWM0VnZOYXBVeHd1dmNMRlkz?=
 =?utf-8?B?TENkUnB4RlJRUjJMUkhVZUlTVXJDdzZoTVdWRjU0TUYrVWdjM3BScVdlT296?=
 =?utf-8?B?NTlQd1ExdkFnVGlHSnM2ak9SQVI5bHE4U0pDRHVFZVk4cEZBNUo3ZzB0alpP?=
 =?utf-8?B?TlFGYUN3bFozSmFtZUZYU05xdk50MWU4OC84RWQ2VnNsOEw2MEVMWXFXZUpn?=
 =?utf-8?B?U2VrRDFoWVYrRG01Vk9XOFdHZHprdUNLK012R3V4QTFScmUrV3NWUXlFSU83?=
 =?utf-8?B?MXhER2VkUXVxYkpiRzhHeXZLY2NlTEdyY2c4d1ZpREJJbFFiNHRJZWxzSUFR?=
 =?utf-8?B?OElNcHJpN2U5Tldzc2c3V2xuMm5qL2lYKy82a1A4ZnpJQmZLQml5aGVrWUli?=
 =?utf-8?B?c2xoa25SMjJwVTFuMy9vcXBMTk4rNTZaaGg1YTU1MVVuKzBKbWJkUGd2Rkpm?=
 =?utf-8?B?U2NHWHBncDFKNFFxNmErdXlyTHprNzhwU0E2MmJmYWFXRjZrbkNkOUxuUTMz?=
 =?utf-8?B?aFprRlUweUtJWWZLdUl4bk83azk2djRYODE5WjB0KzY1c3d4eEdTbkFQZVMz?=
 =?utf-8?B?UlBWMldtVG8yU21MVHdFd3B1L2NoV0EzSHV5UG56YVJqVGVYd3JBZ3VvYWVV?=
 =?utf-8?B?b0F4bGVyV3lRaW5pcGIvQXAxZnk1QzVFbU9nbFNiMnRyK3FGaktmMG5WK1Mz?=
 =?utf-8?B?Vk5pLzBVVjNKRDE1TTdNOUpwVUVOSlpGcU1KaHJYemFIWW5yb0tReXdpQlFI?=
 =?utf-8?B?RW9Hd3JsN1BKWUtIdlNBa2htc1B2ZE9QeE5Mbit0MHF4SUw0dkVTTTJiTmtr?=
 =?utf-8?B?SUlOZzZLaW9haXJ6dUlzVnhuNG1CZlZScDJnL25FWjV2MkdRcVNhSCtOMENk?=
 =?utf-8?B?bUh2NXlHcFUyK0NSd3BVOTVxYnpjRkFNTitWNGpGS3d0WjRpNWhwbFJvdTlk?=
 =?utf-8?B?YzZrQWVXeHhlY3B1WS9KcWNucWZiZENnSW4zTGU3dkFRcS8yWlorUCtRWFNG?=
 =?utf-8?B?VmYzSklleENKVExHbDBTTWMzcXkwOTdvSStRRUtGaWZCZ3FpRFJIVVpHekdr?=
 =?utf-8?B?YmpuU0djb1k1ZjBteDZCTXZqNnNSZ3ZvMVNLbXZ5dU1Kc05oK1JhbUo5YU5D?=
 =?utf-8?B?RDhBWmNkeXZzN213ZHExS2xuSjc2enFoOUtGZFhON3hCV2F5YVV3VVZ1c2hn?=
 =?utf-8?B?dTl1Z2wxYUkzRkNlcXZ6THNDY3N0TG8zRXAxYjNqeXEvNHRBT0hHNEMva0dE?=
 =?utf-8?B?QmJaakgwdFZSYUpzY2g0YmxjdUVtNkpxNWJnd0pCS2p6SFFKV2NER1o4NElw?=
 =?utf-8?B?K055Tm5rSWp2VHRjbGxlUzJyUFZDa3JHUGlJMUpXMXVybEJ0bHN4ay95SkZG?=
 =?utf-8?B?ZW40bThkYy9qeUpwaHlHblo0a1BPVjBuT0pNQ2hZbk5LS3JRVW5CK1JRMFgx?=
 =?utf-8?B?MDFHVmhDbi9kK3NaOFpwUDlJdXNXai9yaVU3Wlo4L2xrWklUVFZ6WXpDazJS?=
 =?utf-8?B?eUxJMjNJbDcwT2dFK2s3b3ZKWWljK1QwMktUeEx6MnRocTlNWTI1dDJVazV3?=
 =?utf-8?B?MFplYzh1VzFQYmh4bFBJS0hZanA5aDQ3RTBHYjRtaUpZbVJPWDJKNWdoU2t3?=
 =?utf-8?B?RHFRaGRtVm8vbXNXVncrRmlRMFpESjNCS2VYaW4xMHdrY2JvK0tOd2xubDRI?=
 =?utf-8?B?YWFKbzgyaW9VUnlHa2xDSTQyY0FFdkNacERjQkhlczE1UGlndkxQbnUvbU9E?=
 =?utf-8?B?cU5KSlk5dTI2ejdHR1JSbFd0Q2JDSjIxUjZTNzFSM2NiamVNMnN6TXZ0ajhN?=
 =?utf-8?B?YythNjVJRU1lL3Uvd0ZsY1pBbDhtWUp4RDdqRUhqR0NaWEJ5Z3BuaVNkRU1p?=
 =?utf-8?B?bXIra3dJSXZUYVhQclZPNHVnbjNTUE9VRHIzcEVjUVJWcjhIOVJtMVo3UElK?=
 =?utf-8?B?Yy9NZXlQc3YyZHVsbW1MYUh5bGxCVlhyb2FqSFkvMGhaVjNLdlppTFp0ZlhN?=
 =?utf-8?B?blJDMUNmZWdzQTR1Rkp4S1F2b3B5MEJxcDNkRXl0bGsrVTdKSlJ4NFRKQVhL?=
 =?utf-8?Q?ue6aEl8zUUflW2jk=3D?=
X-Exchange-RoutingPolicyChecked: H/g8g42wSVGFYFWjUyTUdLQC0xBDXu05amtDxFRSMy9e2VkH14GtCmglpkU00OGyB8jWtwldRmEpgVdEHDdZ4I8gv+JvuCxwsHs5722pt5EV2odU9HnmMd+ksu14UiIucXWJa/fngX/IqpyBX1qwiaPE4NwqOxaLYRvUOYqgDb+4uwNDcAM9r9Q3lo3hn55bZVakd4rlN3KnNB8C6lA4rCDI75aYYe+oltGH59vHzub1u77Idw/uluiTrtEgJttz/fkTk64J9tVNF6nPOQSCh0g+iwaE7BE2d0pxAhpetp94klnMDHdEVyAEv1btlWmRL20WR4QuhZOIDMAbW4GEaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d050e9a-8231-4d30-1523-08dec17c631b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:28:31.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: enHVnFloV0Zto0lUDi8Al/uVWsijT88VxzpXSx3ydSwMkvNuCkrO9S9k8bXY229uixRlnHtCs5v07nOQs2hvvyMKP/2NgGonX3zRZ++B+cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

From: Doruk Tan Ozturk <doruk@0sec.ai>
Date: Wed,  3 Jun 2026 16:13:55 +0200

> digital_in_recv_sensf_res() memcpy()s resp->len bytes from a remote
> NFC-F device response into the NFC_SENSF_RES_MAXSIZE-byte target.sensf_res
> field without an upper-bound check. A nearby malicious NFC-F device can
> send an oversized SENSF_RES response to overflow the stack-local struct
> nfc_target.
> 
> Clamp resp->len to NFC_SENSF_RES_MAXSIZE before the copy.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 8c0695e4998d ("NFC Digital: Add NFC-F technology support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
> v2:
>  - Clamp resp->len with min_t() before the copy (Alexander Lobakin).
>  - Add Fixes: tag and Cc: stable (Alexander Lobakin).
>  - Frame as a stack buffer overflow (saved-return overwrite not demonstrated).
>  net/nfc/digital_technology.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
> index ae63c5eb0..ae6487c10 100644
> --- a/net/nfc/digital_technology.c
> +++ b/net/nfc/digital_technology.c
> @@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
>  
>  	sensf_res = (struct digital_sensf_res *)resp->data;
>  
> +	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
> +
>  	memcpy(target.sensf_res, sensf_res, resp->len);
>  	target.sensf_res_len = resp->len;

I was wondering whether we need to record this in the kernel log.

But given that a malicious device can and would be happy to flood with
such packets, it would be pr_warn_once() or something similar at max.

But I guess it's not needed at all, we can just silently clamp such packets?

Thanks,
Olek
