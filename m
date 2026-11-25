Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795605643;
	b=esQ/R3TXcYSJEyI8e99HRWO9PkCbHMIsfilXYVQl5SaL8oQ0BeYgG9o3/2WMSQN9wunE
	 JsrPCcoeKzaSqeKjzpC6AuBlQDxzzdsBDQUX4FBUw7A1LwPM5xXjOEE7y9pQcmYGXyYSk
	 nICyRz6a5xf63lGdIJVb0jd7m4f4KpfFH9peZLFrlYb5Lv716ihoYmPK7fR2agsWdH0VB
	 h2+zlOTlDdaSyWJR1zOtiTDSKbgGjOPgKS91C1HNRpx8HKH6WiZI1Qggnp9penpL/sBIK
	 9hTUjXGHJ0h8l+HKQDtILpSq3fwWMBEVs2UpaS6vn6hAwaot25EGYVJl3KQLcBoghPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=jxKKFZBc4sziY5YWjrQIwaUtzsMDN9sraU6HkIMy31I=;
	b=sxIDRF0ioqbyJhyNngaICjoOAh5TeXkID3oUXYLlFqzvD+DeYYiz3tzvRoLvD3AqBqko
	 yCC9GHcWZ8UvJ+kr7gwxFwJjcMVxbwGTRIrW2H0EDaPXEhqW+iENPKBbyH3wklpHPzSUn
	 /XvE6Q4iTLOmv/rZHnxzwjBsaIL3LsIly4Tr4Lakwq0o+jniUd1ieeNAq9oOsiVKyBpQN
	 wb+czUZoGnGSA07cqQowfjGvQl62GCKRf4pSSOaLNrpwEqCVe39MRDVahU4ekBPnmMNuZ
	 F6VA7G+F+Z7geVh4Ogi1PY4tGi8niP4zLsZHOclKARABemHOd1GSWQgSaWmO04Zk8pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OrgNU0CJ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="ZLZ/B1xM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C815606A332;
	Wed, 25 Nov 2026 11:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C815606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OrgNU0CJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ZLZ/B1xM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795605643; x=1827141643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OhzR/p6aSDat45WW5flOI1aMjXVWxJZtlFSaOOUuABg=;
  b=OrgNU0CJ4ym6uksv0B4I/yprTRKzu5pDwq0784in2xAb9Gtw3tnkqo8A
   qcgTWdk22Q2w2+46KA4IDOsyFJRA3WfS04MfQ3rBZeqw8iaJkDhlK7cKN
   h+sQeHYCAVUSolxPDnoZzYi/9nafv3gmtZOb7EfENvD2Q1/xwtvd9PrcZ
   n5r7Ncfh/iRq3wDSq3pPMGcrjLcuUvO+LIZU4Sw4YAExg+CG+FdI7JZKj
   cQk9ph05V8qO4JgFOZohRNWGIhMkWAZxlklbuIjS4y6A2Jsio5HepvqHn
   2llYA5NPf94tE9YgFQmDltdZz/IE5SUgpFptEU26RSHTjuCAWSxntmhQ/
   g==;
X-CSE-ConnectionGUID: ncggejWTRbOgL0AbfmkS/g==
X-CSE-MsgGUID: kswkBL6GQCSrM/YlxErc4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4456530"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4456530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:20:42 -0800
X-CSE-ConnectionGUID: eb3MrEc0Q5KlC4ZoRnb3aw==
X-CSE-MsgGUID: YeDYsVlpRN6tiRRMtI5efw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12162947"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:20:42 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:20:41 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:20:41 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:20:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAxDwk3wJyRuUeC1LNy6ED4SktXd4G6G8ZeYNoxdwrBmj+x5OT18GYNaxS0+T8OM4JHBNUGQQfUsfx5tYq9XY6LasdIzEt8Auu9ebkvCFx022MEsGgO3f3gGqm5fjBg6Ufvgxm0HMJyzMPB4u3405S636aW5gROsl7oTuVFdSpgyf2paGz+B2N5oOZVqcCAWRp2Ox5ivoa+9WGvNl4WmCjhRKanAOTQOekDEVpbhf8tG6C06u+kXXMgPlAeqc9/ZfDzMALCkZD2X8VUIAI/RjJwMM8MQC2m0WM9+8pCqzOlbstCKuC4LYfcLY7TW7ffgk2cMnY4xNYvWwesHCu+B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxKKFZBc4sziY5YWjrQIwaUtzsMDN9sraU6HkIMy31I=;
 b=S4ZAbHWkFW76TA+TVz7emVRi44sFQ4YsTxEbhkXVMmtuyu2ZaiO/5v/JTpsgjJO3PROgFDdTomGb0ldxjc3JMjhaWvkygjuLSymPKSlRUQqkW76VCmPgr+dL7s7O8d+4wSqwgWCUk9HxcxOPdhPCKfaoh/NwFkNs97zsnNnfL+e9KMuJEpxWWGm7gYwottqgtyn/+zqe+9WrsHLFV65kbydAKk7V9+m2JWH8L75TB7YJ45l3PMQbBawe2k96dgBwp2OipNYtH21CgAhGDfGWcOEtJTfQsoSpOiXOY4/clfegPmA1hRBguQqo8Hk5/cKkJXxqXWU5Inpq17LQEUTsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxKKFZBc4sziY5YWjrQIwaUtzsMDN9sraU6HkIMy31I=;
 b=ZLZ/B1xMK8hoUs8DA5y0f6jQfhs0vPkVG21Ce8kHE4sz1etc5mVuk/lxdzWI7Un/cFrDVfNFgrIfALDGjKSpLRbdKJjgA9XwtPnrVNytI2Kx1m8vlCDlnPZQg67f0rfCSNNBKWO4aD+sSUyCSJ3ICrqrbMeYifwaNA+9YpwiAYc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by PH3PPFC0CDE789E.namprd11.prod.outlook.com (2603:10b6:518:1::d49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 11:20:34 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 11:20:33 +0000
Message-ID: <3178394c-6649-496d-9064-3fa8f5133760@intel.com>
Date: Wed, 25 Nov 2026 12:20:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2] ice: bound the CEE DCBX priority-group id
 before using it as a traffic-class index
To: Minseok Kim <kor8821@gmail.com>, <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <aleksander.lobakin@intel.com>,
	<stable@vger.kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>
References: <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>
 <20261124112631.43172-1-kor8821@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261124112631.43172-1-kor8821@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0037.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::15) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
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
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|PH3PPFC0CDE789E:EE_
X-MS-Office365-Filtering-Correlation-Id: 248dbd91-48ba-407f-7433-08df4ae61ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|6133799003|261009223027099003|18002099003|22082099003|4133799003|10067099003|4143699003|11063799006|56012099006|261102123227099003|261021130227099003|261028144727099003|261026135527099003|261026130827099003|261026121527099003|261026140227099003|261021123027099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|261021133027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: I/BonTDuaKBLcGQSFmewkF6x6iEDOIuOdfCcHrQV51wqBuBe/FWmud9CF9G9Xtce6VXT01MdxA2P+1T64EFBoQ5lqf9uFD7H4xDGT2HsAknsYpuP5DjBwEE7J/7xy/wjUXPWf06RefIk5aFNIyu6iMaKiRIewiMoGYTSyypIpGm2UYWaKoePQjOhO/ZGJpCADbZ4R8Z2ScZkXZbNnbOXajDY557EIu0gT4DnjRx/D2G6gJnFpax68rSOxUuczfPQZucGUA6f5nqyNvQv9ZACaCg/fLRCTZnbH1klNMNWxDiMbT8Oc1OAM7vRbl1R0s4Xh1B7wDJYqgik2gfO21z+Ey1R97vv9m47myjNYM0fs/omBIIix2883G4D7VmDaO8eu9V51qY8RQSarqWOxZh61K0cAYTPKiL91U1gUgW3cUaraaR/JXC3Gj9oVaGZ2OLVaEAUEffsHheMq4/gL2pHGUu5v2gQwO7DRHXfJrEW+YTNHQovYZghbxP8hdm+hjBHHHRsKHjLrWintCney5vHmAT8PyQ6t31Nay92gwwCjKyjeV1344YHOlIFfiQjJJG4SLJSJNPilX0WZ8A7ZgzvNY+xqvlaAxWYDG4lbPeiZUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(261009223027099003)(18002099003)(22082099003)(4133799003)(10067099003)(4143699003)(11063799006)(56012099006)(261102123227099003)(261021130227099003)(261028144727099003)(261026135527099003)(261026130827099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021133027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjlZcVdvcnhkS00wQ1RsTlFNOWt1THgyWVlUSUI5bG1NaktkdjkxU3d3K2hD?=
 =?utf-8?B?aVBUekhOL2pNZlE5dGd2ek1CUGwrbjNHTW9ybmF1WCswSEZnUk50aVRLYWdE?=
 =?utf-8?B?eWowWFRieGlTODZDb1hWNTRsLzV0MmNheW5BcTBIejh0ajJPV1d3S01YK1Z2?=
 =?utf-8?B?WmVYSTVKVlphQW5FQzBTVHNWZU0rOVRyb3VZbExhSkUvTEFOZGZJODllZ2hE?=
 =?utf-8?B?cXR0anI0VEMzOUhBeVo4VU1Ma1ZuajVtOW1FdFJKcWlFWGZld3VuNDI2Q3do?=
 =?utf-8?B?TGNsYWEvV0s3eU1BeG01eDlpdVEzY2NtdlVPRTdtZmxyNDRlV1ZtMGJxRE0v?=
 =?utf-8?B?MEsybGxCaWJjazNvMVNGTER0TnVQWWIzZW5sNnRnMm94MzF4Yk1yOVp3OEVv?=
 =?utf-8?B?RUJQMnU3SEFoOFZIc2NkdmQ4YWdKeGEwOGM3clorUUN2bUV6WnpxRGRVbFRy?=
 =?utf-8?B?SU80a1BTK2svcWlLbmp4d2Z6TkFtdGt3c3FzM093b3hIdjc2M1V4YldVZWtB?=
 =?utf-8?B?WjZnVHBFOWkwY0h2Q29LTkhqYWV2c1o3Wk91cS9QaHZnUGpjODhLdER2cTQw?=
 =?utf-8?B?ZFRsTGVGRDJuNmRUMjlrMGsxV2ZZc3ltNER5SkVTcGNIaGR1dTVlT2hRTzBj?=
 =?utf-8?B?cEkwYTVjUnRyM25yVnVjZmI5Y1l0S000bXBVUGYvYVJzUTVkQWpWMUYrZ1ZL?=
 =?utf-8?B?VGh2eUNSdUlYTnpFWWlzYjlUMjF3MEVBLzUvOWx0cTBySE9uZ1lRa2JiRjAr?=
 =?utf-8?B?bW43L2dxK1IyaFY4Y3UvdU5meks4cjJZc0F6WWF3bEN1djZ4WjRMQmYxN3Nh?=
 =?utf-8?B?WmVocVlHZHRZekRsUFNoMFpPK0J3akdqTmIzUFluVFVSeEZ1SC9pcG1KUkw5?=
 =?utf-8?B?R3huM0NkWGN2TlEza2hoRWFta3lSZ0dYRnJzOGQyQk9BSWx3Q0ZibUtxei93?=
 =?utf-8?B?cW9zNmRIUEwwZUMzMlhIUGU2aWp4bTF0eklFS0Q2dEQvczVtY0lTRDhNK3cv?=
 =?utf-8?B?bnJRSE0vcFhlZlVFZGl6RE5GUy9EbGVYTzdWRER0VzBiUGlzYWliY2ZvcmNX?=
 =?utf-8?B?RGlzY3hSMVRPblJRRnRkV2F0ejR4c1cvMW8xQ3BLY3E1U3JxN1QvYndlV2FJ?=
 =?utf-8?B?VkhlT2dqaXI0WWxXOHY5YWJjYWZBSTloV0pKZ1F6aVRaQVlBZ0VzWk81dHhx?=
 =?utf-8?B?YldYdHAycE5DdklpZnhEVUFEd1BISXVJRDdLVk9hbVVkSDU3Y2dXRmNvNmha?=
 =?utf-8?B?ZkdLSW9DakxqVHc3emNtVmNUeC9sZWNqR0crRUZDd1JmMHNxUmo5aFZSQzlZ?=
 =?utf-8?B?bjY3bm8yZVErQWwxMnlqdnNWa1VsbVNOL2RaUkxDZmJzOTAzdTVkSHdzWnFI?=
 =?utf-8?B?TkhGU3FFbUVnZFBjTU1Gam91UElZUkc1dFUvditQaGZXMEo0VEZscGh2OWpy?=
 =?utf-8?B?ZUpKVFpyYjBBVkNoRGxXVmMxLzZ2VWVERDBEcUU3TkJNYUVPSjRXZ1pUM2ow?=
 =?utf-8?B?TWEyOW8reHVGWG1ZckI2MnFLYnNuOUhlYTZzcW9jak9VWUpZY0xaMUhsY1BM?=
 =?utf-8?B?Yk8vT2RaTzl6dDlPaDVDdWFQR0hhSzlOVmdCV1lWU0s2cE5zTG1teVNDcDl3?=
 =?utf-8?B?NlNramVSUFhlQndSc1UvQWZhUis2eTM5YnAwOFRNckM3aGo2bXBRSDIxN3NQ?=
 =?utf-8?B?VTR0Vy9ISGp4b0FTWWx6S2pIYzlUWUYybUNJWHkwb1hhT28xMXZiV2Fwd2JS?=
 =?utf-8?B?TC9YY3huRDI0UE8zdjB0MlRLQVFQVnc4SzlLYlU3OE9JQ1Q2YVc3Ly85Ny9t?=
 =?utf-8?B?dGI5TytiU09pblN3MTEvM0F3Rmd6R2p1aTJxMytKNTlmR1JQUUlUbWF3R3pu?=
 =?utf-8?B?eWMyelptb216Yk5FNVoyZzA4NEwxKzA5T1NRcnhNNUVkNlhwaEtSdGpxSEMz?=
 =?utf-8?B?VVNHRmNwMWFDYmVYOVFmY3FPa3k2bjM1NUZzZ1hzeW5EaUVJL1ZrQjhER3A4?=
 =?utf-8?B?RE5LOVFOcGpqaFlhWGhxSkVPRVBYTGUyYVZKdmVLQXM4aHV2ZDdDdXh2SDcy?=
 =?utf-8?B?a3hscTRLaGZ1QkVDQkNYZXJ0K1k4QVZKNXV1aUxmV0hsNGtYUUMrdmwyQjFx?=
 =?utf-8?B?Q2dJWmFrZkV2UytORmNCdVpjdE8veDVYaW1JMDZIZ0ZyS09WYmQ4NStTS2Vq?=
 =?utf-8?B?VGU3SldDeTk2ZFVvRnExN0tTWGVReEZtSEwvZzBIOGpCODVBakdFa25DRWdE?=
 =?utf-8?B?VVFwcWtTdVJqTjV2Y2hmUlFlVyt0MUk4UEVEMklPOUpicUxTRkl2T1VPM3Zu?=
 =?utf-8?B?a093ZzNEWEkxUjk0dFlqWDY1NEorUW5XckRwUGxjMXpXalNvVHlJc1Q3dldn?=
 =?utf-8?Q?yU716/M0WBcY7mWo=3D?=
X-Exchange-RoutingPolicyChecked: gq1PE06VLFetRG735CVoHlWt0nBYk9YHfVz/YKIVgW7qNykf2fskvpXyXz6zgIkiktc0zzuw+qPDK5I2CoFSGvLWRzXTRy73yKbCvf7F4Ge/jrs2xZImfAF8vCzDXLwSChhGBtHbqZtqUQsiTY+bz4OzBapsh73vT/qsy7YLDgDnA+Gizn+N8DjJo/Cfn0KRIC4qHuWWWxcxLvHdITXjYaWNFHNKeQm8eK9WLyvqTDgzUisX7riuIfhsRKdfxzoAZ4TKJBZkIPzg5JJCGV3yYVsgVGH2SLVqjsg7XzNYQFocO4us6bzhF2TwbbavdsqySZnLZe2+oyQmqJ/R1FSJqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 248dbd91-48ba-407f-7433-08df4ae61ee5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:20:33.2627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d+JiZAKACKkLsRM2AGseoGmXl88zUdZr1MgEsJ/7Pfis2qC1ogpfpt+bPAEjXQRAPfVW4BuANocY2nbVQhV98brszJqY4bVRqUq5/QgbtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFC0CDE789E
X-OriginatorOrg: intel.com

On 11/24/26 12:26 PM, Minseok Kim wrote:
> The CEE DCBX priority-group ID (PGID) is a four-bit wire field spanning
> 0..15, whereas prio_table[] is sized to ICE_MAX_TRAFFIC_CLASS (8):
> 
>    #define ICE_CEE_PGID_PRIO_0_M  (0xF << ICE_CEE_PGID_PRIO_0_S)
>    #define ICE_CEE_PGID_PRIO_1_M  (0xF << ICE_CEE_PGID_PRIO_1_S)
> 
> The IEEE ETS parser in ice_dcb.c masks the equivalent nibble field with
> 0x7 (ICE_IEEE_ETS_PRIO_{0,1}_M) so it cannot exceed 7, whereas neither
> CEE path bounds the value.
> 
> In the wire LLDP TLV path, ice_parse_cee_pgcfg_tlv() extracts each
> nibble into prio_table[i] and inspects it to select tsatable[i], but
> never rewrites prio_table[i], leaving values 8..15 intact -- including
> the defined sentinel ICE_CEE_PGID_STRICT (15).  In the firmware AQ path,
> ice_cee_to_dcb_cfg() remaps only ICE_CEE_PGID_STRICT to oper_num_tc - 1
> and lets values 8..14 fall through untouched.
> 
> Downstream consumers then use prio_table[i] directly as a traffic-class
> index:
> 
> - ice_vc_get_qos_caps() (virt/virtchnl.c) indexes local array
>    u8 tc_prio[ICE_MAX_TRAFFIC_CLASS] via tc_prio[tc] |= BIT(i), writing
>    past the end of the stack array when tc >= 8.
> - ice_dcb_tc_contig() (ice_dcb_lib.c) accumulates used_tc |=
>    BIT(prio_table[i]) into a u8; for values >= 8, BIT() is >= 0x100 and
>    truncates to zero, causing the contiguity check to pass silently.
> - ice_vsi_cfg_netdev_tc() (ice_lib.c) indexes
>    vsi->tc_cfg.tc_info[ets_tc].netdev_tc with ets_tc = prio_table[i],
>    reading past the end of tc_info[].
> 
> The driver already enforces this invariant when writing prio_table[] in
> ice_dcbnl_set_pg_tc_cfg_tx() and at the VF trust boundary in
> ice_vc_cfg_q_bw().  Bounding the PGID at CEE ingest enforces the
> invariant at a single boundary and prevents the u8 BIT() truncation in
> ice_dcb_tc_contig() that per-array bounds checks would miss.
> 
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minseok Kim <kor8821@gmail.com>
> ---
> v2: resend in plain text only.  v1 (Message-ID
>      <CABBEkySNmAHTuoiC3jZqvAS31AdzMb2bHe3x0EAKQGibf0xi9g@mail.gmail.com>)
>      was sent with a web mail client that word-wrapped the diff and added an
>      HTML part, so it does not apply and netdev@ rejected it outright.  No
>      code or commit-message changes.
> 
>      Resent from kor8821@gmail.com; v1 came from for8821@g.skku.edu.
>      Same author, switching to an address that will not expire.
>      Signed-off-by updated to match the From line.

thank you for plain-texting
next time please send each revision/series as a new/stand-alone, instead
of in-reply-to the previous one (adding an URL to the prev one is much
welcomed though)

please also take a look at sashiko.dev report:
https://sashiko.dev/#/patchset/20261124112631.43172-1-kor8821%40gmail.com


> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
> index abea84f14658..a36458b01fc2 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
> @@ -407,6 +407,15 @@ ice_parse_cee_pgcfg_tlv(struct ice_cee_feat_tlv *tlv,
>   			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
>   		else
>   			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
> +
> +		/* The CEE PGID is a four-bit wire field, so a peer can name a
> +		 * priority group this driver has no traffic class for.  Several
> +		 * consumers use the value to index ICE_MAX_TRAFFIC_CLASS-sized
> +		 * objects, so clamp it here, after the strict-priority sentinel
> +		 * above has been consumed.
> +		 */
> +		if (etscfg->prio_table[i] >= ICE_MAX_TRAFFIC_CLASS)
> +			etscfg->prio_table[i] = 0;

instead of clamping bad requests we should reject

doing it at the TLV parsing level is good level of abstraction for the
logic, such fixes are much appreciated

>   	}
>   
>   	/* Number of TCs supported (1 octet) */
> @@ -805,6 +814,10 @@ ice_cee_to_dcb_cfg(struct ice_aqc_get_cee_dcb_cfg_resp *cee_cfg,

I believe here we should have no changes, please move it to tlv parsing
(would be fine to add limits in multiple places of the parsing).

>   			/* Map it to next empty TC */
>   			dcbcfg->etscfg.prio_table[i] = cee_cfg->oper_num_tc - 1;
>   			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_STRICT;
> +		} else if (dcbcfg->etscfg.prio_table[i] >=
> +			   ICE_MAX_TRAFFIC_CLASS) {
> +			dcbcfg->etscfg.prio_table[i] = 0;
> +			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
>   		} else {
>   			dcbcfg->etscfg.tsatable[i] = ICE_IEEE_TSA_ETS;
>   		}
> 

