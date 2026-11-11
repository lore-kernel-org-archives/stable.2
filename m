Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794401810;
	b=sjS8RKDU93uxVtp17kjLRgHcAQvVPMt/WRuJ9m8nrk3U3MthxvdSIYF+kmyMIqSR4RmT
	 /SMUb7S5Ej0TivZ3oo2RPZcv8hOq23WmO0AHVn3HFTS2SOzSUFwzxrKULK9gB/nrYXTqG
	 f3tKUd7p93wnSmdrVjXsCvLWfCq8Cc8QmU5JhO2++XLpQBA7Sa6g0ng1bT1tsXKosebJH
	 p5QkCTPlg65X/UtqTQos6IVzaKc+P2B6sc1YxdYTcRleeRFkLyIbBfWWBZbxdNSwAhL6y
	 kkjzF2ZQbo4PvdS0fXDN0IlvrmAkEgUQ5u++3A8r3Un92gcMdLishkwK2G7OA+3EYYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401810;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=bCgwTs8ks9Bir5OuYgxx3uKLF48qG9wwpt2IpX75EDU=;
	b=m3rCyy3bx0yYVhHHL51fBAS08ptowvkhGWAk5JB4T3rpSwP++7AKRYTrFsMKM9m19ESp
	 T0b6rF8CjKnxKvI7Mo9/q2yqZfxHks87mEztZzNzoO8NaPYeuv0xastO269vT6hjK0Ib+
	 RWqqp26vBwTLgy2Jei0UjGDlRH+8jGHs7hjODCjbgfLBNibsCVvNxXdpmUV/WMFUx4tSh
	 7ghALI/Ylk7DbT7ZJ6Lsy9C0AcrBfWsTyz1xQvfMQPojAEdDp4q7D1qQBcn0iodTarAOb
	 7bM+PS3oza8+ZkF0impCF36Rc4lcAv/ve9DvmJZSa8aDcaoi2J3SbaAEmhXN6WXMgEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y0x0vjnh;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52685606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 12:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52685606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y0x0vjnh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794401809; x=1825937809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i8kcxNqNi9iTUO6lGXL+TkvmKtZdSy7yjfEYLT4vI/g=;
  b=Y0x0vjnhSw6y3jIm++kVA6r0MoJxqDSSm/vk4qnXlN+z6kPznf/rjWsB
   xsbKvuW2aAGxtR9ajVnDpW0paqbWYW/rinJUge9Gif/Ge0Z2M+6XAwlPV
   Q7WnWH5wl1ySacQmnv+PFJyqmbuiaguVJ1HplO3JJYbLyiyNBjExmC4aE
   UwRi0yPX29y4TgvlZMkn4+/LTJtBf6WfalfBrYp4WnFSBvHevNOWRPGlQ
   o0B9DNBYJW12PtwfUSYBHwnDA4HzklWU6X10Yfp6mdiPLIYnseibxBRoX
   pD9JIBRaUiRv4WCNSb1fJc0esALB5WI5ZIyEgGdlMj4M64T3rBxBkERsj
   A==;
X-CSE-ConnectionGUID: yZydKhdcTJOWmJG7hn9GEg==
X-CSE-MsgGUID: uZyF7s8jSU+eSbyRowqLQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3092631"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3092631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:49 -0800
X-CSE-ConnectionGUID: CxB0rO4US9iUgFf5gVfMAQ==
X-CSE-MsgGUID: BHviZAVyQvOA84Rozj970A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8238120"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 04:56:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:48 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 11 Nov 2026 04:56:48 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 04:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3xY60ZzkoQX6oTB2DW1jQL4J+FEmkJ31RgktrgMsHGMU5cik4z07kGxy8xMCbIi1K/hoV2YF+60siN2hBVXYYsLAdFukqr1wzElcQrA1Fk66uAUHyO25S2i1xHhIRU5nyyp53jeS/iIYuK9Kfyp6016Lp3xoFHPz8bp/xIjed/i8hXQsDC2+14dSH1X5Xw+FCXoG7JitSNHaa3sMcSNC/TDZBBlko1bVHKp4MZRWWe48PJaGFV/sKpTi55imuEqJapYRinzZ2rKl9zQ6LkAmJOtXjz0scvRq1f7NY/lxH+/21Rf/FWTWGXsTicfRT4fAqhmEueOf3CCHdnDPy41Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCgwTs8ks9Bir5OuYgxx3uKLF48qG9wwpt2IpX75EDU=;
 b=DZppywFfoxGh4YeHy5BV8PCZqWopfreg1+GFwN9Hu9fCDYkP8XeIbzIuBuBLGuGCOuXg1IEaTMFabxQSBtc6bfU1yTe888sBsLvKkHS0PcTIvxvx/731fkdpxVoVP8n8f32+s8bXHNy8LAud3aGnM4731B0IzHPbgpjUaOazgDUigobj31lSSDBdo1fYXSuwh7tk2buTpthaYqp2A3sw6NHxJVAEC3Xy0skEX8ntCYq4sld8XCs2wHz9m6m0hUK0m+s0rAqekO5W3VfV5tayELNF948/XMsDsNWfw3XGfxrXJHhfqLcOlZJjkR9rkIbZS/3qYksS5KQhkJAdgDODDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by PH0PR11MB5781.namprd11.prod.outlook.com
 (2603:10b6:510:14a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:56:39 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:56:39 +0000
Message-ID: <3b255202-bf65-4048-8d53-6bbc3ab98993@intel.com>
Date: Wed, 11 Nov 2026 18:26:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/dip: Write the DIP header last with SDP
 transmission lines
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<stable@vger.kernel.org>, Ankit Nautiyal <ankit.k.nautiyal@intel.com>, "Suraj
 Kandpal" <suraj.kandpal@intel.com>
References: <20261111103542.4093652-1-chaitanya.kumar.borah@intel.com>
 <avRTIDPwI3uOHQyo@intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <avRTIDPwI3uOHQyo@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::7) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
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
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|PH0PR11MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: c6488f59-fbda-4342-7585-08df3ff339c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|260925021311599003|260925022911599003|260925021911599003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261021135927099003|261009223027099003|261102123227099003|261026140227099003|261022115727099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: QyzYAUnkSzAWQAvfKt0HkoFkQ6LK18AjFjZG+fieIzT2tzpDdsBH97b1+bPtVr/0sMloFTDHBPgk+iZNuxrZT91d2YpTNZnx7oX0u0M93+9cFrZrjxS6EWZhjgkEPEIupmybhfXvvokJFlJREB1BZzZbjvCIq7cRDv2kYvKlO8iQehQIW9FvIxhcFEnsWNA6N3yW78g/7El9rKwQwTviI8NoLClBdyQWL54IVG5bE0pxC8lfQ1MM2GtpJMKp/9X4WbLITaEy648FvWFtevBx/UetYEZteioFjGvwT77IQ/kXx/uJwAdRiQ+6p/4+qxHj3E2m0V5lkevK3YmjTboYAXPm/JKcjKnNYWiZN3E9cWUtmXydNhcjh0s3I6RygarKIu3IAI+f0HfvMXq1cjEXO5eSPaVR+DtBJZl4tfBe1ckgM8yNkzz/c9HcifNspNTwLQEBevkCWCxCd2blscU+xw2y+rxrZbJPZRLC/Nm/+Cw56dlNZ60MNIP91EOc4U0fPqb8Jht64CExkoO89sadpn1imZC21L4lewoH7qjJt9yTH2iy+zi4C3y28anB8HzXjkIVvN5JrP9OZMfYbEdAdh1Paw/QjqcJN/UwPFt2VO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR11MB357627.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(260925021311599003)(260925022911599003)(260925021911599003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026140227099003)(261022115727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amtGZEZBUndGVk0xRGpBeUNCUkJlT3Zld3BFUmRTaHQwWld5L2lPUUcyL2F3?=
 =?utf-8?B?d2lyM0lqczh3SzhwazJCWGg3ZkxaRUpQYitnb01VTGF5WGd4MStZa2Rlc3Vk?=
 =?utf-8?B?U3UwcmtjWmQ1TmNhMGRvNVBlY1FaSlBzdk5SdjFUVkNZU1ZlRlhwdFVDbzdE?=
 =?utf-8?B?a1pjRUh0UUJyaHRxQjBCYzFpK2lVNkhKR0tlYWpWbTN6VkhTVk5pU2IvbE5O?=
 =?utf-8?B?ZXkzSS9pT01IZDBndnA4MG1WY0tTMVRHbWhSbGc1dkRjeFVmeXU0V05BRjMy?=
 =?utf-8?B?WFJmVllJZzJlMDdjNGVNSUF0L2Rkdzh4QWZwTk9HS1N1SUtMOW1vNmxsWWpn?=
 =?utf-8?B?MnZGbjFMc3RyZy9lc2QrdStoRW1YWERjZVRHVWR2WWpoS3o1Zm1CQVdHcXRO?=
 =?utf-8?B?RGdnOVN3L0lUUlBMVHQwZklYWU1GZ0RPRVJSQ1lJUU5Dd2dqZ0dQblY0SCtj?=
 =?utf-8?B?UmdFWENOa21VaURFU2xIU2JHTFhhTkpxNFlxL2dCRGtBbGFwdXVHVVJ1THl2?=
 =?utf-8?B?UHcrY0s2a2RadWs2WEkwdDZ6cVF0YkRoOER3NENlMFlrUEQzcjNmMVVjWnls?=
 =?utf-8?B?ZXN3YnBCRmtybEF3S2N4T3UwNmdPM3czL3FCelNxa0c2bXlnSlpFVGRmYks1?=
 =?utf-8?B?YnRBS1VZdTdYQWkrRitzNXZIMWFSQ1hLb3JKdGxUOTJVQVBtYW51TFJYU1RS?=
 =?utf-8?B?Z1RXVWprZDJNM1JkQkF6bHViVkJPQlhvbzJBL3M3VHcrVTNYMjVLdjR4MExp?=
 =?utf-8?B?R1lGUGwwSE9QcjZVTmt0c0J5MWVmbHZDZk8rdm1QWjFxRFJnamZTditVajgr?=
 =?utf-8?B?WDBwbXplTTZET3R4TUdNeTJ4M1VIbTJZc001Tms3ZHhSbThBS1didTljTll3?=
 =?utf-8?B?YnlMOEdLR3BGQng1QWlnRVBlRkFocnZva2h3NU9QYjVsUUxiakRQV205YkVM?=
 =?utf-8?B?MnVYdjNqTEtNT0RlU2E0cWdyZ0wvOWJJVllDbkV3bWdtVE1Ud3NYanJZVVcv?=
 =?utf-8?B?RU83N2U1cUNHclNlemc2UzhTNVU5U2F1NHlRUkdNSzRqY0Y4am9pY28rWkxx?=
 =?utf-8?B?cERVRnkzMEttRU5pWm5PaEorMzFJLzVFRUl4RThxdnpQdFk4V2ZteVZIamg5?=
 =?utf-8?B?V2lNOGhBM055dTY4ZUxYU2VzYjdCMGlkMElkSWRibzlIV1hnZWNJbkNSUVNC?=
 =?utf-8?B?cExudzJ4S1cwNEgwaXJwWmxSZ3hwWUFvODZ5ZU1PM21Ma3k3NEsxcE1nRVpv?=
 =?utf-8?B?aGNpVlpKOHJwQ1h4NHphYW1kbTRLS1pNMXJWZE1tRUV5WGsybzljNHkydk1S?=
 =?utf-8?B?T0ZLRnFhanppcSt0ZWtzcW9LK2hncEU1MWJERkxIa0w5Z1NjSUFINy9XTWhF?=
 =?utf-8?B?SzJBSGdGMjF0eUhITStERHIwc0I1TzVhS21GcVo0OVN1UVhza3pBWFpKRkU2?=
 =?utf-8?B?endoL2NtV01xaWRxL3ordTFDK21rSXVQSHFxNTdCYkpnd0ZiazE0bWg2Tkg3?=
 =?utf-8?B?TXJzOTlnMWpxQjVOMWlsVU8wNWhPVjhldWdxMktZWGxYdXN2Q1UvVzhIVFlP?=
 =?utf-8?B?L3RySGRyd3NRTkcwOVZWLzBqT3JkTG5QRlFqWEJRTlpGME40VEZPZUM2ZGNr?=
 =?utf-8?B?d1NhYnBhYzNMSHpxcERwdUxNREkrUFprQUFhYjVLa1lFYkRPTnVWWDczUHRE?=
 =?utf-8?B?MnFWcUQ3YWU5Y0s2azZIa1J4cHRYN2pFUFc0U3czaW9tS3NjbytyQUxqcGtp?=
 =?utf-8?B?ZCtWQjlrNWJ6UU5wcDVCRFBuUm05MFRMTXd4c1M3T0JueFRDb0YrMHowbG9y?=
 =?utf-8?B?NVl2RXA3S3UwbmpteXRtMVFhQ0xVQ0NVaUhlSUE4NmlNRGFqeVJLbVhQQWw3?=
 =?utf-8?B?dmVMRFBnZnlLZy9NY2Z4eHVVSUxBQzRZakhHaTBGbnErL05PSU5rMWZXVjl3?=
 =?utf-8?B?M1ZFQ0tjTUUxRmYyZnZvU2dEaW10UDQ5cWhDWlduK0hXZHFHalh5eFVTenFR?=
 =?utf-8?B?YkRJb3hKYnFLd2JTWkdwQ2xCVllxSWZGd1lNWGJjQ1lnQjhwR21neXlSK2dR?=
 =?utf-8?B?U3c0dlpvOGN4ZzVhdjYzNzBxVU9LVzJUWGVMYWovMHgzNkk0Vlp2UnVRREY5?=
 =?utf-8?B?SWZkd05SUlNNMG5ld3pPY25OTzI5NWI0NzRlNFpyVDdZQUhJUEZ1Ylk5bU4v?=
 =?utf-8?B?SGk2SmFpNnB1K0pOWVlUNFlNSzBreS80ZXI4RitHWEZuaVNOemlWZ0xGZ3dD?=
 =?utf-8?B?YlRHbzdUMjN0QXpXUGNFbG1SZ2ZRVVVhczVMazAzRmxhZDF4Wm9mNzdxVitZ?=
 =?utf-8?B?TzFQTk44SndPbnpHUjZMdVRzY2Nuc1V3dlNrcE9rYXZ5aXdSODF1YXFQaFky?=
 =?utf-8?Q?tTCE9HTjexEsMKXM=3D?=
X-Exchange-RoutingPolicyChecked: he764md0i7T8RLEGFUQrK13mYa5HIzJWzo7tNQ3+eruHhKEb2TcBtmG0Zv57f7l8VnlJvd84ZOTZsmVA7amSZW2rhG4122P/7aenH0WWjm6Bx2NlIacLKcZULj6ThMCDKOAOsypzo0NZb72Lkop/IfTql2K9Nls4u1dP+hApc6zrLLYCcZAxLPKuUr8muNEbrzx1k7O3vUKzhrjrtxit0bc072j63zz7BR9QfZbLSFox8i2BFd/ihsAntJ2abO/5LIMNfsHtWpGHJIWT8xyPurhpM5i51iUNfA+ImDVmIPF7C6d/Qd24i5rd2JOz26Lp7Ziip6IHhcf2kWamUXhZUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6488f59-fbda-4342-7585-08df3ff339c4
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:56:39.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yTJRNynpdR0CtwBCNpj5EbhQLg1+ZFMqT+q7lH9lg5Pz8l5EyIzC2A0kpEKHvAdpBOKmuzw91yoDii5wgp6STp6lGnL10zZFXfOr85s86g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5781
X-OriginatorOrg: intel.com



On 11/11/2026 5:06 PM, Ville Syrjälä wrote:
> On Wed, Nov 11, 2026 at 04:05:42PM +0530, Chaitanya Kumar Borah wrote:
>> On platforms with SDP transmission line registers, the packets anchored
>> to them are double buffered in the transcoder (TC) clock domain. The packet
>> registers are in the core display (CD) clock domain and the whole packet is
>> clock crossed on the write of the header (dword 0), so Bspec requires the
>> data to be programmed first and the header last.
>>
>> hsw_write_infoframe() writes the header first, so the packet is crossed
>> before its payload is in place and the previous payload keeps being sent.
>> This hits the AS SDP, and the VSC SDP whenever an AS SDP is enabled, which
>> is whenever VRR is possible since commit 6a1712052859 ("drm/i915/dp: Enable
>> AS SDP whenever VRR is possible or PR !async"). With CMN_SDP_TL, enabled by
>> commit bfa597238073 ("drm/i915/dip: Enable Common SDP Transmission line"),
>> it also hits the GMP and VSC SDPs: on NVL, entering HDR on an eDP panel
>> leaves the image discoloured and scaled until the headers are rewritten.
>>
>> Write the payload, including the ECC zero fill, first and the header last
>> on platforms with EMP_AS_SDP_TL. CD domain packets have no ordering
>> requirement and Bspec recommends the same order for all packets, so use it
>> for all of them. Older platforms keep the current order.
>>
>> Bspec: 75640, 71197, 74384
>> Fixes: e1123e617e51 ("drm/i915/vrr: Program EMP_AS_SDP_TL for DP AS SDP")
>> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17732
>> Cc: <stable@vger.kernel.org> # v6.17+
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> ---
>>
>> Notes:
>>      Fixes tag rationale
>>      
>>      The Fixes tag points at commit e1123e617e51 ("drm/i915/vrr: Program
>>      EMP_AS_SDP_TL for DP AS SDP"). The AS SDP has been written header first
>>      since it was added by commit 8845021b7331 ("drm/i915/display: Read/Write
>>      Adaptive Sync SDP"), but EMP_AS_SDP_TL, which holds the double buffer
>>      point and the transmission line of the AS SDP on BMG and LNL+, was only
>>      programmed from that commit on. From then on the driver relies on that
>>      register to anchor the AS SDP, and the VSC SDP whenever an AS SDP is
>>      enabled, and the programming note of the register asks for the packet
>>      data first and the header last. The two later commits cited in the commit
>>      message only widened the exposure: the first enabled the AS SDP whenever
>>      VRR is possible and the second added CMN_SDP_TL for the GMP and VSC SDPs.
>>      
>>      Alternatives considered:
>>       - 6a1712052859 (v7.2): AS SDP on whenever VRR is possible. The PTL
>>         report is fixed by reverting it. Narrower than the spec argument, as
>>         it only covers v7.2 and later.
>>       - bfa597238073 (7.4): CMN_SDP_TL. The NVL regression, verified on
>>         hardware, but covered by the older tag as every kernel with it also
>>         has e1123e617e51.
>>       - 8845021b7331 (v6.10): first header first AS SDP write, but
>>         EMP_AS_SDP_TL was not programmed until e1123e617e51, so exposure
>>         before it could not be shown.
>>      
>>      Not verified:
>>       - The failure was observed on NVL with CMN_SDP_TL (rewriting the GMP and
>>         VSC headers makes the panel recover). The AS SDP and the VSC SDP with
>>         an AS SDP on BMG, LNL and PTL follow from the Bspec requirement and
>>         were not reproduced here.
>>       - No reproduction on kernels older than v7.2.
>>       - Stable backports need the HAS_EMP_AS_SDP_TL gate adapted, as it is
>>         defined in intel_dip.h, which is new in 7.4.
>>
>>   drivers/gpu/drm/i915/display/intel_hdmi.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> index 4ec0db8d93fb..3ecf017b3176 100644
>> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
>> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
>> @@ -51,6 +51,7 @@
>>   #include "intel_cx0_phy.h"
>>   #include "intel_ddi.h"
>>   #include "intel_de.h"
>> +#include "intel_dip.h"
>>   #include "intel_display_driver.h"
>>   #include "intel_display_regs.h"
>>   #include "intel_display_types.h"
>> @@ -524,6 +525,15 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
>>   	const u32 *data = frame;
>>   	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
>>   	intel_reg_t ctl_reg = HSW_TVIDEO_DIP_CTL(display, cpu_transcoder);
>> +	/*
>> +	 * On platforms with the SDP transmission line registers some of the
>> +	 * packets are double buffered in the transcoder clock domain, and the
>> +	 * packet is clock crossed on the write of the header (dword 0). Program
>> +	 * the payload first and the header last, so that the whole packet gets
>> +	 * crossed. Packets double buffered in the core display clock domain
>> +	 * have no ordering requirement, so use the same order for all of them.
>> +	 */
>> +	bool header_last = HAS_EMP_AS_SDP_TL(display);
>>   	int data_size;
>>   	int i;
>>   	u32 val = intel_de_read(display, ctl_reg);
>> @@ -535,18 +545,21 @@ void hsw_write_infoframe(struct intel_encoder *encoder,
>>   	val &= ~hsw_infoframe_enable(type);
>>   	intel_de_write(display, ctl_reg, val);
>>   
>> -	for (i = 0; i < len; i += 4) {
>> +	for (i = header_last ? 4 : 0; i < len; i += 4)
> 
> IMO just always use the "write header last" approach.
> 

Agreed. I was trying to keep the exposure minimal but this should be 
harmless given the registers are either not double-buffered or double 
buffered without an arming register in the older platforms.

>>   		intel_de_write(display,
>>   			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
>> -			       *data);
>> -		data++;
>> -	}
>> +			       data[i >> 2]);
> 
> Making 'i' the dword index rather than the byte index might make this
> code a bit nicer. The only slight concern is whether len%4!=0 might
> be true. Maybe just have the caller always align it for good measure.
> But let's stick to the byte based thing for now to avoid adding more
> noise to this patch, and clean it up later.
> 

Noted for later.

>>   	/* Write every possible data byte to force correct ECC calculation. */
>>   	for (; i < data_size; i += 4)
>>   		intel_de_write(display,
>>   			       hsw_dip_data_reg(display, cpu_transcoder, type, i >> 2),
>>   			       0);
>>   
>> +	if (header_last)
>> +		intel_de_write(display,
>> +			       hsw_dip_data_reg(display, cpu_transcoder, type, 0),
>> +			       data[0]);
>> +
>>   	/* Wa_14013475917 */
>>   	if (!(IS_DISPLAY_VER(display, 13, 14) && crtc_state->has_psr &&
>>   	      !crtc_state->has_panel_replay && type == DP_SDP_VSC))
>> -- 
>> 2.50.1
> 

