Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793226433;
	b=NbXkdfLZ+iFK/MaN6LcV86gXAcKzy6YLZNILaQcFac7JmI+MDFAnJJG3r8XuoF+1sphK
	 RKeCOses4tKg7SObFf9hwRL4TtSjegNcadQZmddUmpAuRNNQ3N/pQ7ZVEtKIrRfbVIs/0
	 f4VlL1b4qzs5ELE+agLTw6h3SYHOZM86L72IzZaLOEdpPaCIzuYB0lOJv1i/yTzdS6XIh
	 tFK0+cI436V1T6vVNYW3bRIKFCTFRMJpLS1qxOqTEM8RQWGTdayCw3a/aZQSujRgIvSbL
	 rzyGX6AvkQ3eiaEtcUSOYknplxZdN4FUGeZ8wWgdUBJ/Za95t+HmKfKbBNetby953Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226433;
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
	bh=XS79/kzu++KXlkxI+rTWcWq68QZd2XKunQ2qENZVchA=;
	b=BJlpPg6q99gHS5Wen+hfw+fP+WqBMWD+VDuGbyvawtcofzcUNKNKkYxTP/+z6vtvpa+e
	 bXYp3MPqDK/Y6fE30utkSzQFmbnus/0quHoqkofn2Lnbd62VTG/6xwRbeph4E45HwxJZi
	 ZQXHphIlycz+q8/i4Awj6lRQThr/1ENvydD+wzF3TbtbRB5G10Z82g0iSP2dh08Fj6CSF
	 8oQHHiCYNdAHv1RXOFmbC6mwXPPK+VqHqcrMqrJJxMnGFXHCdiaUjetf7G/+PoIuFUTWN
	 OqPNhfmeL1d7mrxmbnhR2PDR9RrxoT6j2DXw/Dk+4LlWFTKupzrVEYxx57ozKgYwBtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OQ5xli2w;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54987606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54987606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OQ5xli2w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793226433; x=1824762433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5jRH26oRPU3abI61uEYveRcabjO+gomafXYxpqePX9Y=;
  b=OQ5xli2wf7BDiVBPbolRE6fqsDqTU3S5eC2G2ktIgrG9UIKNXvhrmelV
   v0fHgXSlCqzhLaCp3rkT6s+Z/4M16QQ5sdUeYiH5KJAm68wmleibanEL8
   N9dGeHg1vOBsNFls5hApkJfOTCdp/BgT/ku11cw3gT2bmpXFORseb4bYI
   CkFziWrRMmo2Gp9B+6bFSxMihHtK55IJujtXm9FO7FwI2t14UGMixerXg
   WiVJwMoYDIXdfTd0/9CNLM2BSzVea7nt92IlUXLUaf9M6K6bRu7InV7M1
   MGlV73j/u0ZdJ76b+PqP8Ptwyg+Nl35/TNM08NfLdHquMowshgRmhb5UC
   Q==;
X-CSE-ConnectionGUID: nOtqcAGKSdSugNXWSrQpTg==
X-CSE-MsgGUID: bGWYVC5mS4eT5TkI+yaTRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1987483"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1987483"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 15:27:12 -0700
X-CSE-ConnectionGUID: 7L+i84XYQTOvkBikz1d/eQ==
X-CSE-MsgGUID: 0GYrttsMQ6SPM3sTPDQrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5304500"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 15:27:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 15:27:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 15:27:10 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 15:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDYpb7cOJKQR65qeMnmdHgC6sMRHdnfT7yIt8dzhaS46DC16OA1O0rebUT8HniYFwSnbPQytxG2t1YnJYDHHcbR28D8S6qcaJk+NKhr85DZCw+ZRf/ScR2fEzbN/RxbPmPQp6Dpq5Eld/ohVXSRkVsKORoyOATcgNjdeu9kbPfwC5hN9izRBRlqIQFxi8rS+XFPkJzedgtjSkDHF7bES9vaQrzizGNYp/l6KWRlaEwy/FBrLXkpaPN2BefaUxnR0Tb3Vx4gl7sxhJGd5Uqm6dST2TCnT98JlR2dGtd2+yivdEU4k2bqZn/WUIxZk8wlVgN9KfB7OxUzJYodbS+XvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS79/kzu++KXlkxI+rTWcWq68QZd2XKunQ2qENZVchA=;
 b=Z84cOibY9bN8UI/paNygEmf524rwge+LHgyOwbBc0MeYg58Ms3sX125Sci/iWwNjmmEpdwX+8X/T7dls3DR1iGt4KvhcQRc6iwCciGXbARtNQXJmL8a16v+9YO5BKztwaRcLGio0ga4rzMTysCFx4kJEf1wgUK+l5eoxyi0PwHTuuIAnQ5UyjmjKY8ajyUWWT2pmT9bGvsKqv1q+wjG/UR0TxMpcUUJt5KAVKpyyijX7Son799z0p8zMr5h3iWapAq6uVXkZdQ3VNe0UL0kRzYnr+q+82L7Z/tJ2e63CZMn++j2BCumOI1tapLUithfc7zlZ2el2JtN6rV+KYkjxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8)
 by SAWPR11MB9899.namprd11.prod.outlook.com (2603:10b6:806:54e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 22:27:03 +0000
Received: from SA2PR11MB4985.namprd11.prod.outlook.com
 ([fe80::4fb4:c6d2:2c42:1e4f]) by SA2PR11MB4985.namprd11.prod.outlook.com
 ([fe80::4fb4:c6d2:2c42:1e4f%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 22:27:02 +0000
Message-ID: <9ac015b1-703c-4e35-9520-82a81d02f433@intel.com>
Date: Wed, 28 Oct 2026 15:27:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/i915: Fix OOB access of reset_engine_count for
 compute class
To: Alan Previn <alan.previn.teres.alexis@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>
References: <20261028210828.433225-2-alan.previn.teres.alexis@intel.com>
Content-Language: en-US
From: "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20261028210828.433225-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::31) To SA2PR11MB4985.namprd11.prod.outlook.com
 (2603:10b6:806:111::8)
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
X-MS-TrafficTypeDiagnostic: SA2PR11MB4985:EE_|SAWPR11MB9899:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9e46be-6e26-4e21-3585-08df35429703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|261021123027099003|10067099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 0XvbfifqGPWrC/GSjrDVNZvAW/giWKxvI4LfgTi9eoA8dLBj2JpmjauM4KNJfChzhFki2CUiFSVyekRlZ08v7DP77MnF1inp7T+m+YghBqmo3dkzwKp/ZD8MCY5pB3WeEVqF+l3l5kcc25FvJL9u8xEJao9K/d7ewDLz2Q0yEI+GU0yIucxVj3Sea8N0+C8cF4LvpTsm2gbCxeVkmsWIlIiz2wxy011W4iB373TrYKjqepb4TjB1S+G5zIqLZVuVVyZfzDG56rQZKSnZkzbxIih/v9gg2BP3JcN1AKh7hUwudrnX4BavrtRQgHSBUfnPcZ7RukVe80Fd2p5CkLiq//KRXd2ZvNckj/G7jO6kYJRQHwmXsRLgGgTmqUKVUC2CJeofWa1e5GYjsYf5DabS7/NB+S5gAMff0w1ywkSqDuu//rc8I/CDJqTxIx2xgISHIYKN2kzKLiUFb6C895F+sJYuZQrDaMEFr2A4Ppa98RtZPihMPNFjb6mfjIS1GjrRCMAy5dnAOcpD3mryO1AusiYEDOM3YVitTFbhNi+PZ9QfR+i7gp2UvAsb3spj6g2v4s1y4fdzd6Q3YVEGPKuW79Z3rmS1ZZGUYaasR9M6FEcQM+2mixkRwmtiSIPtxAo5Z6FHxVnfndAIx8URDMiH+ZmDzeCVB8L1jNKhgYQpL7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxIUkFUQjRPc2UrUy9SNjFMcE1ydmFrcGVwdVA4ZExGelNGMVhpd0toa2Z3?=
 =?utf-8?B?UmZZTStkYkdDa3JzalhqM1J6dFVjTlIxVVlaS1A3Q1pObk5yUmhIYlMwWjRB?=
 =?utf-8?B?VkxGM2MzOVd2bFg1RWJROEtrczloYkdzdWpKeWVHZ3BTTFZRSWJsV2ZFQ3lP?=
 =?utf-8?B?bEIvVyt3bVU5RDJKRG1tVnRiK2xTVG5JWkVET2Q3WDNHenhNdFFBbWdYaTRJ?=
 =?utf-8?B?UkZMdnI4cGJ3dWpvMDVFMnJ4QnFhcm43eEIvbjFFTnhFSEZsaVJlSFRtWlMx?=
 =?utf-8?B?WG5FdCtpYzhuTkVpMlF5aFlCeFhmQU5xV1pkOUNyczcycTlSdGxadXdXT0R3?=
 =?utf-8?B?V3Q1VWZZcVNGUE8zemJ4R2tlMWd6NmcwOFNXblI2YlFFdlRCcWZub1RRM0Mx?=
 =?utf-8?B?dDBZUTB0OWdnWjhmMUsrTngwRTFQaUpWMVVWaXZieXc0VGVTc1dSZzZpU0Fw?=
 =?utf-8?B?VVNpbmFHdlB5eTc0aDRzSkdkczE4Q2YrZnloVzBpL3h1Z3grOFQyenQvVGps?=
 =?utf-8?B?ZzJ4S0NrOWI1anhkVm9Yd05LamdMM21BQTYyM1ZNb0d3eHhVd2JwMWN0Yy9P?=
 =?utf-8?B?cWxMcGJ2SXgvY1JUMEFMWi9TeEUxYWNTYjVwMkdXaUlOb3NyTHBFY3o4U3Va?=
 =?utf-8?B?TitWRU9DcW9wZitnQVE0cTlVTExUd0huL2VYYzYrU3JxVnBmTnJ4REt3ZDZK?=
 =?utf-8?B?Tm9aWXpod3VIVllVcm02cDJucDQ3NVNSbVY2dmxSNUROZ2IxZXF2K3dJMzF0?=
 =?utf-8?B?RDFSSXlEcHNQOEhuRnA0bVFFVTQ3eTlkYTlpU0YwREo0QTlDQ2lIQ3dzVVVn?=
 =?utf-8?B?MUVCNGhvc0N6U1hJbVdSNnNES0V4Tjg5MDUrTFFhZDAwUTJMVTJTZ3BPdW9O?=
 =?utf-8?B?NUI0cjZMckIzazR4YkJ5OWZHYTBDaS9IV3dJSXhNQ1lKczVZNW1XN08wcmp0?=
 =?utf-8?B?UFFIZE9VaFhwSDBKdXdkWVBEMXYwSlRtYmV1R3JVZy9GZkppSi9qUUZhc2RB?=
 =?utf-8?B?OWFvbVpuL0g5N1pkUXhYOU53ZndwRmNNYmx5ZDZpZVN1MmVsZHB4WkxJa0t0?=
 =?utf-8?B?Tm4rZWhaM3l6UzlEK3hwcnpWS0thaVVSZis0SUJ4SEdvajljdTdmN21BTFdM?=
 =?utf-8?B?RUdDOEllbzJ3bnc0T1dmTkNqSW5CQnBjQ01KNmlBYjhXU0RRL3hIc1ZBS3Qy?=
 =?utf-8?B?QlJaU0JoUWorTWhyQmZmdDRuNnVLNjhUcWh3QnZKVGcvdDBSZEhWaTJkTE5N?=
 =?utf-8?B?d0I1Y0dEOS9VN1JsUFdoUUZMbEhzMzRuM0hSY1NURnZqOWc4cG41YTI5VlQz?=
 =?utf-8?B?WnNjK0t3bFBNNFhyMDhiSWxuamhTVmlsejBUWWlGMlhpam5UMWIwY2ZRT2dl?=
 =?utf-8?B?L095ZkpYT2V3dHc3VDZRdjVDdVluU0VwTnc0RC9JTDAwRDJFeG5MTVhGaHVJ?=
 =?utf-8?B?Zit0Zm5vK0RDSzQ5LzAwNzlkOGwwWjUyQnJZZ21vOCs5Yml5QVN2UTJqcjBk?=
 =?utf-8?B?U1JNd2hRR0pmUWxERzBiZE1BRFFObE8xK2cxSGd0WjVmK09ZdG8wOUdZZUN4?=
 =?utf-8?B?TVBQZmxSTm5vR296OU9WelFPN1RYNGVKM1hqZytqTEN2dm9XcjRsYUJpY3No?=
 =?utf-8?B?K2txTW8yNXl4bi9xSFZyV3hrQlNvTVhhTkQ5elo1dTc4TFVZMGd2a3RrREg2?=
 =?utf-8?B?ZUdFMC9yUEwydk16UHNwTzJzRW5nMFJSdFJjSlpjbHNJWDJjb1QrQ2xZTWNi?=
 =?utf-8?B?alBRcWhuWE9pdDUxbnU5NVQ2VFBDWDNWK2svK2xHbHVZaVlsNVA0MGZvTVRs?=
 =?utf-8?B?SktvZk5zMG5uWSsxYitleHZ3b3VKU2N1TUZLb2t0T3MzSm1MSExsdjAvMUxx?=
 =?utf-8?B?QlpKanZjVUtWam5FV1ppL215NzE2bG5PTnJTbzlaTW9tWkJRV2dOWm9NUDRp?=
 =?utf-8?B?c2JoQ0xYK3RObHo5bUttejVhaEtJYnFMWFhsK3gwY0VUMDJXZWNRMFNNWTZW?=
 =?utf-8?B?Sk4rM1JaekpQWFE3Y1ltcGxTK0dvOXVKajdBT3AxNFl0QnpYR0lGbjYzenVV?=
 =?utf-8?B?clpDNnZiM2JvVDhZSGNlOXZMUTliaVl2K2ozRDlOVGM0OXAwOHNjK1luS2Zl?=
 =?utf-8?B?STVqNzN0VkhodXFjQkZOazZoNmdYWkVZSlZ2ajBVUkg1cExtUmpKdWVFNGdV?=
 =?utf-8?B?VmxzR1dkT3J5R05najNwaWZmZzFHUHZ5akhITHNNaXMyRXY1ck9TcXBRRXJ5?=
 =?utf-8?B?SURZV09PM2srRmpBL2hBRnQwenZQV05pUDBBYmUxVWVpN1lFZkYyR2Q0Z3pw?=
 =?utf-8?B?RHd4MFloaEtvRkFUdFFEeDFDNmhlaWtiaElQZFFrV2Z0QllYSWJFTzNpTHBz?=
 =?utf-8?Q?lrmkKnQCpwAb/87c=3D?=
X-Exchange-RoutingPolicyChecked: F1FSPV/zueVw44c4w6J7l7SdImx9hTYzyOIFfyA15HLQ8M9FQ1RpmdHb7K5RfbilbgeZioc8Om7QMYgwYp3gV36AxbIA3by9CqyAMwC3Ip2kEbGcaXnhZ2Jhplj4SIIozLQcZ5C4wloM/O2j6Cdlqn1UXIMNORjUlVfE9uwREXjTVlcjYjvYytRCygkhdPWn7cu8B0FLTByI3IHruEteEQVQYQyfH+oiCw9D4Pszq/a5D758T1QU5KErLkcfybhAM0DzH5OMeCXva5k+SfOcUMhcYsjSTmSIWMi4l7flad6ua/p3uq3Q5V4yZDSOwybCIraT84qcFFmoulxm0t8bvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9e46be-6e26-4e21-3585-08df35429703
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 22:27:02.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVQzDY+Hty587GDDyZ1kRkD2W/FgA6w8ipbOuskOzrrMFWP80HbUEqRvitRWKf4CUVDURlr13qTr81jPRfRchksx2sTcMfPyO4tsV/bVh+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9899
X-OriginatorOrg: intel.com



On 10/28/2026 2:08 PM, Alan Previn wrote:
> MAX_ENGINE_CLASS is the highest valid engine class value (COMPUTE_CLASS
> == 5), not the number of classes. reset_engine_count[] was sized with
> MAX_ENGINE_CLASS entries, so resetting a CCS engine incremented (and
> i915_reset_engine_count() read) one element past the end of the array,
> aliasing the adjacent field in drm_i915_private (suspend_count).
>
> Size the array as MAX_ENGINE_CLASS + 1, consistent with other per-class
> arrays such as intel_gt.engine_class[].
>
> Fixes: cf9cb028ac56 ("drm/i915: Use internal class when counting engine resets")
> Cc: <stable@vger.kernel.org>
>
> Assisted-by: LLM
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   drivers/gpu/drm/i915/i915_gpu_error.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.h b/drivers/gpu/drm/i915/i915_gpu_error.h
> index 26970c5e291e..e53139cb77ea 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.h
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.h
> @@ -225,7 +225,7 @@ struct i915_gpu_error {
>   	atomic_t reset_count;
>   
>   	/** Number of times an engine has been reset */
> -	atomic_t reset_engine_count[MAX_ENGINE_CLASS];
> +	atomic_t reset_engine_count[MAX_ENGINE_CLASS + 1];
>   };
>   
>   struct drm_i915_error_state_buf {
>
> base-commit: fbed42265ffde9b162e21ed7ff0cfce070e19aaa

