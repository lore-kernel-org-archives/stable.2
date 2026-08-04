Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E6532C937;
	Tue,  4 Aug 2026 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832170; cv=fail; b=RxV5QovfthpdV9BiqwQtZnc2WAM7ZElSItmDkavZ874/eZ/D6F7PEe6U5rayJgLd/Kbmu/KKI8LHBR59aJ9b7DPhQOkx4NK+/5IGP5phScw9HWKW0ULRC9+NHMK3ymFqz9KSRssqu+Wn3qOn2cnBIZyKI3BU81NdYDUSenNu/EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832170; c=relaxed/simple;
	bh=ugVzBFOWPGxs+6wqzRVg58jBZUmDvJI5w7lSkTkc53Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V2LHzt3ynwrN507wnKs0eBwezwf7PM01wtAa2uCP0lwGBC99XCHqMP9pk66p9MopxHVngtkRGMUn+JQhbDkOenC2+ysRKcl3B1N22PhAS6mdKMtP/3GOUR5HG6hXGaraPxXnsqazxwnzwKfKpnWhYC0iLFlvwtWR+7LkppzwZIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVh0Z52J; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVh0Z52J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785832168; x=1817368168;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ugVzBFOWPGxs+6wqzRVg58jBZUmDvJI5w7lSkTkc53Y=;
  b=cVh0Z52JpK/3tEQecQPFcbo2YAxcDE3o+lCeRcu3jMnvZ4wNVBTuT3jX
   E8TihmpbkrKeJzo48/+nOptyCiTXa/knYmej1HN1Uk+2IIS6Gk6kFc1gP
   q7cQa91Hmjc2E450khCG2eua7e3QJ8PGeGOt/2gbPtceLl920MtdE4E1k
   8wS4sj36VWWdjyt016YljSmf9qFv2bjEHHGBNMimTcX4Pd1sf4bqAGLzU
   cSAvkx3Syo7dRC0Sc0aBSMyVspR7FQmHLa0RpYhjL9jsl/59fJvzGbas3
   6xvEn86lXmAHSwh3oHDUutbkbXd4aZYnPSOLkacCvaELxtHjE/Njr2l4/
   A==;
X-CSE-ConnectionGUID: NSB8dHyeQIaBNn9pM6FKQg==
X-CSE-MsgGUID: sP8vaekORSSsGg6NyD7j+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86497090"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86497090"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:29:28 -0700
X-CSE-ConnectionGUID: inQKLcpETvyn79DYcBCEVA==
X-CSE-MsgGUID: A91gykBQTO6Lbfqu4VS+sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="258772524"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 01:29:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:29:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 01:29:27 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 01:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDZNm5+XSQV7wlaM3+Vis7qS5HQiB1oTbSaIRVJa1kD1MBOEQdVQb90SvKrYe6eP5XDGsdzTai9WdazX984+y0ESMnOMNuW6r5Wzzj+LxjDpNafTRNudytuQ7cw4rvBAPd0SY7G5zw9n1IrMqczOwDLcDWHw6iAwDsa/kN++gTH3Uutrwz1y4xMSK8pymMSWX2NqYVs5RkddWCzOdnvm3Dvj9eKlm7N54kT/Rs6+KmWW/LuJGO5vQRtG1sywPaY2UT1/HUM2QQZ4fnSnKJ9q166/DEwtX3Irp9ksAf/ylpp6Lc4hRczLHQjlzECIb23dhjLeq3WqiU3tGUNSYMrbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqeehGH5aBBqnKugrdZgJw3++jwa/q14CRRjB95btys=;
 b=V9KydafklERYbcA1+l9QtAA5i03p1k5YeTYrF8tt1ZZEhjwHpBkpNsAzZYVTIxdSqBY/ejY0/MsKrrg57+TCG9XE82pmT6UxLWWgSJPJLKRnq0IJ/u4hZzUKvCk4bFpVtw/wknbxcjB9oldk8EtxsfCE/aZ1i6Fv5dbag8nVv3ET2+ScpR4SNS3uxwcCCIRl284OmPwS2siywprIpzTE4YuqV+HKfIJNVV1I6VXxagoZNX+b/ksXhBvMkI54eSQa2lvSJ8/3mYku5EoVtF/zykpGrAOnsmpvw/cfiGmx7jhWIrh4YXM7c/S6/oqEox9iO4ZimfDoiU+sX2mnIyqoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 08:29:24 +0000
Received: from LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa]) by LV4PR11MB9514.namprd11.prod.outlook.com
 ([fe80::79a5:106b:2126:a7fa%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:29:24 +0000
Message-ID: <dec971cd-d26c-401a-953e-6ef3523ab245@intel.com>
Date: Tue, 4 Aug 2026 11:29:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached after
 resume if interface is down
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, Philipp David
	<pd-lkml@3b.pm>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260717092159.35496-2-pd-lkml@3b.pm>
 <IA3PR11MB8986D164F76EFE059EF2EA23E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <IA3PR11MB8986D164F76EFE059EF2EA23E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV4PR11MB9514:EE_|CO1PR11MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: b760dacf-73dd-4c28-2758-08def2027d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: OUL0Vzow6ck2Yq/NRXktWTzIKTd7gWu8qSWJBoXiaypYRdYVUZzcQCjEKoJ6NoVhozraQeVPyCAncMAG3rVaOM3AnK1uTBdYkZg3prwtGTS3aIHQNhKhDSBIchXOZfBKEQntM0sGRGPcPni2uDuFHx3tZW9UpzwyxpQ8J3pJsufTKe/O/PBT5kq0K6BpPrJoUQJhuDJ3ZTvXtEoxW2L4ja9C41cgHLNRIcCuh7zz0OwHQEO3kf9hUzWRS3psGl6MLpybIlcoYDm3wei41i1CAZYnSLcnrmwk5AXuxBIOjTtXh/ZAMOCtoiRWOKX5IN11kxUiDehRUphjADEGN3HDO4R9zZdCfmNsXEz9LxY2vk/FAv5Ec2aFSIfQInbVwlxEdniJW52dsFuDxKuEzu+2/IJXbvRYgMzf/EAqZUie0JQtlFk9e0mRL28syygKXYTyb3RSru2QV7WZXSto47pgSY1u+QioONxpZ/JsHYj8uNeOUNe80RjGeSC78HiDkJurVUa8nCsg+yRaY9M8t1tC5gHcQCC6BKyDeHDbeKZftaok0jqD8pEHkPbk6CgZyb7rTLfALOK6YGJya2u+tEAqLY5WAOp9IS7A2ES3oQFY6iTwzwj84WxUp6JyAQLwhhkd2clp9lEcQ1L5UoASdaUcr+h68UvGX2EnC9XC1hqKMqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV4PR11MB9514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNEeEREUUM4THBNREVvMmEvcDYwOW53ay90VGpQTk5ueUhoZFU5NzA3b08x?=
 =?utf-8?B?dTZCemxGSlU1ZjhCUHZnTTFObFZRRG1BRGVZaURjbnBIZWsxYUY1ZTZiVGlj?=
 =?utf-8?B?a3JqMm9BSXpQYXdrcUVXREt5NGNvcmRjQVdlTVl3QVdkTmJzOXhSTkViaWs5?=
 =?utf-8?B?ZGFNanNYOGZBNU1FKys1TWQ4NWtPcStaWXpzK1BvU3h3N0hQL0h1bGR5SWR2?=
 =?utf-8?B?bjlNZFlBMjlWeHBNWmcySjlId2FnN0pOcHdMTVkwVXh0SWlGSWhUSkZUa2ND?=
 =?utf-8?B?Q1dCbUVhWmxZVlQ3Z1J1MzIxSXhsd2lFOTQ2ak9MV016NXQ3b1ZDT1UxTk5l?=
 =?utf-8?B?L1pkMTNpSmgwR01SVWNFNk0xdWt1QjdsaUtZcm5WWnpZOGpFKzF5VVBvYWxM?=
 =?utf-8?B?cW1uWTNVTC9WYkRlK2tYSlFQTFp1bTZ6Q2dFZlBpbkpFWm1mOEIvaXA5NG5x?=
 =?utf-8?B?YVFUWGFUSUowcllsemxrNGQraWhMSjNlVnBMTE4xNmJwRUFpTUxRcGNSL05y?=
 =?utf-8?B?NmM5R3RyRXpZaThuSEoxVko0T0FhdHlOTWExa3NpUnA0TXRMMGh6ZlFUc2t2?=
 =?utf-8?B?WlNXODZsY3Zqb2puTloxc3pBclRzSFZtR2pXT0ltWW1lbE04MWRLbFQyalZv?=
 =?utf-8?B?cU0vSkR1VzFpNGlJY3YxVUhKVXlvT0tnZjR6dldqbVkzOUNkajVyb1ltTUxE?=
 =?utf-8?B?OTY2Qk1UVUpybTNLOFBzL3dFM2l6NjFKL1JpRkxROEx5V0ljbU5UNDBJVXJW?=
 =?utf-8?B?SGdvNXVuM01wZHNWRFN0dG04Ums4S0R4dWd4em1QUnVOOWY5U2NPQ0R2NHU4?=
 =?utf-8?B?UVVOQlJFRjdUNVVlTzY4c1NpMXBuZFV4YmdxUWM4cUFSR1RmV3ZFaVY5dnZn?=
 =?utf-8?B?aWxmU3IzaksvcUxGNkpmcFVqVmFpS3ZyZjlxOEZHUlpENndIQ2toVDA0UTFo?=
 =?utf-8?B?QjRRSXFQMjRzakJnRkJMdVMrRlhIZEdITG9RamNnREVYNVJmdm9Pa0R3emMx?=
 =?utf-8?B?Q1BnQXZIS2FVQWFwMW5yQ0lpdm1iRkJJVFVVTjhzTFl0aUw5VVpUTU1XOVRq?=
 =?utf-8?B?dlpjOW5PaFg3Ni9WVVhXclVwcUlUQmp2Ry9ycStQT3pwMzkyeTdMSkNGR0tE?=
 =?utf-8?B?ZjVIM0ZURnc5UzF3azVrZW1lQllYTWwvaGxzK1N2TGgxcnFXMGIyU243OTI1?=
 =?utf-8?B?VWUzWGtIMmdFSGhTdjNqZkRrUzJVS1VaUlRzdXZ4ZDM5YXVlUUluZTVKS3FE?=
 =?utf-8?B?NXAxZlYrdUNkVEdRSSs1RUJlWWlhS2dlUk5lc3U4SWt5UFMyYVZOZHlmMzhN?=
 =?utf-8?B?WTJ4NkJ3VE8xSGMxV3JIMHgxaDJhTVU4ejMxK3FKT1pxU2JqNHRleDBVZlhE?=
 =?utf-8?B?Yk1ENmlJNVBLbVJJR0ZsRVowR3Y5RmRoWWZPaHFXV0NpNSt5TGxZbFpsNVVN?=
 =?utf-8?B?Nnc3MTRVa0xvTXBQb2FBbE9xbTJiYkZoODZCSUNJWjFHZlVQZkVVRGpueWZK?=
 =?utf-8?B?aGd6cFJRVFduSHRxNmVUVEZkTEZyTEZRQ3kwT2c2bFJkRGFEMVdMazJoWDVz?=
 =?utf-8?B?bVlvQzh2UkduRGtsVzNsVFFaNnBtMnBVYXV4eTFJNEpNcW0vRm0xNy9hZGpt?=
 =?utf-8?B?SkdJem42Uy9FdXpkZmdQOFlRV1FoZThPZHp1Nnc0Y1AxdlF1aThxbElodlRm?=
 =?utf-8?B?VWdac3hkOGloYUwwWW4rd2NONkVrRjA1L3N0cWgwMlM4QUZRSitvUGRzR2Jk?=
 =?utf-8?B?TzhYeXZtbitFVExlZlp1bDNJZ3pyY0pYak1xOU1pR0U2c25ici8vdHMwRGsr?=
 =?utf-8?B?eitZb3VnenB6K1JLeFErb2Y5WFBJZUs2d3gybnRwdGJzRTRJRnZtOFNrSjNG?=
 =?utf-8?B?N2Y4K0E0RTYvSitzUlhIS0xyOFdtbnh4K1MxNXFHQWsrYzZYZDduS1VtTDd1?=
 =?utf-8?B?RWhDcy9GUTFuNVVuOUJCSjRtL0Z3Y1c2TkJlamVmbDZsTFQyMExPS2JFSzRl?=
 =?utf-8?B?V1lUM04wSEdnV2RSR1FjV1hXdTdmL0V6eDJWazNKYW41YjZIeHA3NFg4ZlN3?=
 =?utf-8?B?bmRLQlVzMmh0c2VyanFMcUlYS3ZCSjlQQ01PT25ZN25ZOW1GSjRUKzRZV2Rr?=
 =?utf-8?B?ZGxNQmVVTlhnSVB6V2pxRnRJWkpWRVRZRFhSTndvMzVQVHlXSG9yZnVyVU95?=
 =?utf-8?B?eHBRQTczMm9aL3hhWHFYcUlGeGN2TzNCbC9zRklQZG90RVYra01XeGREU3lI?=
 =?utf-8?B?NUpIUm0zV1lGaS80V2pnSnhHR1lFTGxkVUZOZ1ZsTDRYeC80UVp0bEUwYnpR?=
 =?utf-8?B?MUdmcU9td29wUzdpTWcwbjJMNHJTQ0hzbGkrTFV4MTV5a1VodFZLUT09?=
X-Exchange-RoutingPolicyChecked: GadM6S4BfekIdtuMwyKdEAH3VqIu1nxRW/2J5AiBQ4LyHeRKngfVzsgDvsU5Bg0cFenlP53iDZGOQ1NfjtF0gryKwYtFrqBiayWmTUJwsA1yHRYIf2ALdf+N4Y+4B4IoUfYqrCyifNxOm0m4S9xfb+6W0JWCH1yB7fSFF31j+LoITkfVW4CPDwAaKe1TnKk0X2U1/C9/6gxrLxTqgS6WPoEloaMWx2E7Enu2dW+Ob5awzl+6OyYrAocXi+TAbwh3c+tcqjWZNi+04Ad8rJexZP/Rjy1BQ7gcz6u1IMI8k5TJsCcYJlevCVk9mdXgT0KihIaaFyYJCutPv961mK2AZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b760dacf-73dd-4c28-2758-08def2027d87
X-MS-Exchange-CrossTenant-AuthSource: LV4PR11MB9514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:29:24.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1AC25rk+Z63vNnY4VEfpT5h71Tr6h9MDcNgoO+PyRvjwKDkMlkMfNfnsWT4PiM0JoG9vHQUEyctK0Tpjk8vFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-OriginatorOrg: intel.com

On 23/07/2026 12:18, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Philipp David via Intel-wired-lan
>> Sent: Friday, July 17, 2026 11:22 AM
>> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
>> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
>> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
>> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; Philipp David <pd-lkml@3b.pm>;
>> stable@vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH] igc: fix netdev not re-attached
>> after resume if interface is down
>>
>> __igc_resume() calls netif_device_attach() only inside the
>> netif_running() branch, so an interface that was down during suspend
>> is never re-attached on resume. It then stays in the not-present state
>> that __igc_shutdown() set via netif_device_detach(): ethtool reports
>> ENODEV and every attempt to bring the interface up fails the
>> netif_device_present() check in __dev_open() with -ENODEV, silently,
>> since __igc_resume() returns 0. Only reloading the driver recovers the
>> device.
>>
>> This is easy to hit in practice because NetworkManager brings managed
>> interfaces down before sleep unless Wake-on-LAN is configured, making
>> the adapter unusable after every suspend/resume cycle with WoL
>> disabled.
>>
>> Re-attach the netdev on every successful resume, as igb and e1000e do.
>>
>> Fixes: 6f31d6b643a3 ("igc: Refactor runtime power management flow")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Philipp David <pd-lkml@3b.pm>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 2c9e2dfd8499..e777c2df0b73 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -7586,11 +7586,13 @@ static int __igc_resume(struct device *dev,
>> bool rpm)
>>   		err = __igc_open(netdev, true);
>>   		if (!rpm)
>>   			rtnl_unlock();
>> -		if (!err)
>> -			netif_device_attach(netdev);
>> +		if (err)
>> +			return err;
>>   	}
>>
>> -	return err;
>> +	netif_device_attach(netdev);
>> +
>> +	return 0;
>>   }
>>
>>   static int igc_resume(struct device *dev)
>> --
>> 2.54.0
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
