Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD46547040;
	Tue,  6 Oct 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324524; cv=fail; b=CvN0Xkx3diWVZwDruNUz5hwLv8ddgUGyHuPhDlL553hINUKxGDLzxDGr8zSJEcYXptKOUZI/RJJ7oChmLUkK+APKgRKfWPOi2s84T5DU2JPcrUApdPhSk9iXyNweWlkB+pzNcLamFszQPqFO7dam+29DM60w1P5CKHi+3JZJ4YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324524; c=relaxed/simple;
	bh=fvu+dBn/xR3wQaH9U/a1zYoo3dTLA6wBBCOXr99pC/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FlBsQVRyuc86GwiqQT3uTe2NC0csP31rYwlhqJ1tmHfthitaD2OM39MlUzEL0EDAlm3K9ds3fjRr960vicv8VEDpb+SorxgXzicxX/Iix6OF5TBRKA3cMmPP/ed0jBxKxDjL0usQWiQo7sa3ttesVL1AlFWjpMhTqNPqXMEv7UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/gzFcSA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/gzFcSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791324522; x=1822860522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fvu+dBn/xR3wQaH9U/a1zYoo3dTLA6wBBCOXr99pC/A=;
  b=l/gzFcSADidfdNvDlm8GK7rykkbzHqMgJXpn7pV2oHQfmF4Gde0051wL
   MtusfeMImhxy8qZHqO/HcGA4JlazAG6bj3Cfru+4IdyYtkt63xmOnjqAk
   rzLXIx71Ibx4YBkqaVMQFsnU2siLB2Lqq7ARdCIQh5oKxyM94yqIKJDfX
   rVAgNjlbH5hz+Y2iwav8rvxqP4KZRn7Udvs0o7Hs1qYHk2oJ9l0dnvsRU
   FKfj7ewdbezN2FZRaiKCp3KsE0LWhFmnyF8EfbeMkTbEpLR++pqmyZFq5
   aGuX3lXHqpEkSqWJG+m5zeiTuWwuM1kEU/xcLMf2E1X4UqyIZo8jVEbDN
   A==;
X-CSE-ConnectionGUID: 3CCylqcCRjmcMk9P6NoPQg==
X-CSE-MsgGUID: k33qG84tSXSscE+47scpsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="71400"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="71400"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:08:42 -0700
X-CSE-ConnectionGUID: 7AVbv+FaTIinVJ5VL1tnKA==
X-CSE-MsgGUID: dDDg1yTMR8qNrrMOUqO6RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280505804"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 15:08:41 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:08:34 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 15:08:34 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 15:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Lbrj65orqvmzIW02v1x9lFnqCTBW08wH1Hbx+PvV+AxCTKKqzc70JUHfk28iQbnGVhcpXPBe7ZeiESIZmFOVP5B63pehFR5+Gpckz0Ii3wUvimWwhU4lng27LqrlfK5hmsbCBFSdODmQbRdFJWdZkPBw1kh/MHZKOfHM6iv3rDvePX6ytTbM3sV6Jn2MlB/Kmy6olSKyr+pvVcimFBeTm/ijyMXi+rdCEJiD2FVsVIo4EVtg4SE8vd1CN1ynKwvNwekaXwFLdAECoYt+y+JRH87EUlwSiwwmLi/OMSVcFq8j0mryA+RTTscoT6GQTIXmT0upFV8CZtvaIvd05qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7Ps9pmZebxv3PpSRa6dxRv0LrXDNcbGTjHhPKwCSKY=;
 b=Y5MdNUlzqKk+a/nrmtmUWvclYnXRtLztGlb//PX9O7O1fU0tUFiE9+nlU1kOlUrYo7ui/VGRCIUP+YrkNutYMAvaR8fzt4u+yFONbI51xL9wmYYdrE6R44Qc2mJ11g5W2w66bKxZn6CzDUoFwT0kYSLo01kx1+ci5xD9XlZBGdzemQBeqCloNnDAK/ohTYMG58utqRS0uuuouIthV9/I7T/GsDugPeUB2ngScrkBxkzdSsP5LfONZLz2LZFQy1QfVk8AZz6E3zT5aG/wIKf1Cp138ZXna/YMk9ml9Bso31JBpBkMyl6lopP7jCMB1nBagWFtOc6Q7wRVxoB07Ah/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7572.namprd11.prod.outlook.com (2603:10b6:510:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 22:08:12 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0451.022; Tue, 6 Oct 2026
 22:08:12 +0000
Message-ID: <61ca7331-e7ae-4629-9ac2-8b4e451cda61@intel.com>
Date: Tue, 6 Oct 2026 15:08:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fm10k: shut down the service timer during
 removal
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Matthew Vick <matthew.vick@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:303:16d::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e633ff5-1ca6-4bc9-eba4-08df23f64fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: x6Auvca27fzrvnOsEr4cjZNEmOAXl9nhGfnbGLspZ8SEMXUTrjrk72JoPlPmqR/U/8dCpxKsMfOINPC3psZbMMSQ0iFNv9bITabCQtu04D0UC4mQV5d062AM6KK1s7CXl3SMsk6D0tuLwm2fLTP0VjDMJWqVNJF60njioh6VYuBZ9R0Lqgf01WJOLFdas6zgKWJqqQUlLm2IQtsc16cQQOo+pGsXHcDQpIS/x7bd5gOpxtAZOtnxZvmNM5KrJ0Ns1w3mLYl7VJmjL7psbxMT/lcz9OMCg72VWffJACKNy4vJ0LE6WitQ473S1pSQt3xB4kmGKBQ8HY+so3AIoSdl1IQXXBkUJ9frfVBQMG7scHUK3pkg2b8oxMz/mwgYEQ0HtP8iSynCNY5h9NZ2KUtjf8dDd5YN445bHvRCVyg2YUi72OBLbzZpdK7i1AWhZfmVJXmYG8dOIXyMviz4XL+ssaSkaE6D59GLUJkMFkaylH/yf8PvOhUDSuAgMZAONNuqCF4aYm78Ul4ZZ/ARFkbgNcRtmyjl6sbKSGcWvv1THnGkAndin9obFj/qe3evVkoWaZVO+HENtVyh7jq374sr3yd+TuiG7Mu5GU8B5QVX4EH9hv6vxQ2vL4N7c8/1gDe7mbYI5Bqf0nDvlLMW5gbVsjGL1tDJ8Wj37SOFQAy9S3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2tBKzk0cnFudEQrZWNGTHBRakxoVE5hc3FsQ3lDb3NONnJaWWx6MVhkODNH?=
 =?utf-8?B?QzFicEFPRFNLVGE4MWw0dVRCYkhOUlh5Y0hWb04vNGNKUUYrTFVROXp2TU9B?=
 =?utf-8?B?YnhIT0cvMUh5WkM3U201M3BNOFk4aDYwM2YxUHJUeUdaNWFnWmFZR1BKRTh6?=
 =?utf-8?B?WkpXbWs0VFB1OFFCVWdkODVwY1N4d0VvVGJFUE9qQ0RtVjhxdzNEY3lWMHdB?=
 =?utf-8?B?ZW51bC9NZzlqWXBnZSt2b1kySWthRTRGV0ZYYzZtUDlWcktCUHBJZVRMdGlk?=
 =?utf-8?B?TnY2Rkh0VVNmb3YvMlRDb3lLQmRQdXVyWTZ3a0dIclk3QzlYVkxhMEtpNGFL?=
 =?utf-8?B?V2kzSm5QRDY0OWJpbForeXBqNExvbUxrSlIxRldnZUxibVMzL3hwcnQ2b0Fn?=
 =?utf-8?B?cG10R2ZqTnA4clNmUkUzU3lhQU1UZ2lzcmlYWE9ZQzc3QzBFL3RaeUgvNlRr?=
 =?utf-8?B?NHBOaEZhMHJEVzhIU24yNDhoWVMvTjhWWFJleEJaSFRyV0s5M0locnVRV2ZL?=
 =?utf-8?B?aXpaQXJxQnIzbE1yNE82NHVLbmlXQjFxelp3UXM1M1c5bzliZURmRTNiZ2lk?=
 =?utf-8?B?TG5qZk1pZVl2dS9VSG9PKzZIL3FPdmc2K2FxeWZoR3ZieDQ4cUxPOCt3K05I?=
 =?utf-8?B?T2tzV1FjREk4VGp0SXo2QVdWZUUwd1NzRjAvRlJDcGNCTGFMVVBBb1Z3c2Nu?=
 =?utf-8?B?SG45eVFrNkpSN0lWTmNKeDhJRyt0aWZxSnUrM0hoY0IrSkdSV0dEQkNjb2RB?=
 =?utf-8?B?Tm41cGdseU8xbUlJN0g1ZHI3S2Y2c29uYnJuNWVVM254WC9aa3VzZTBCbk1w?=
 =?utf-8?B?eXByNU5CT0hwVnpKSjU1R2ZGYzJtK1oyQ0IxazV4TDBKK1U2V09yYmFqSEhT?=
 =?utf-8?B?amRqejNsd1VsNFZHamJZTVYvV1lsWk4yVXJXSjdkQmRZQWl3ZHdBbUh1NDRh?=
 =?utf-8?B?bGF3bFVXWmxaZkJvNDEwRWZCS01xR1kxbStWOVZCTDIyUldWNURlQ2R0ZDdr?=
 =?utf-8?B?bThSMHUvU0IxRHNZdWoyaXhIempNSnVsZzY1Z0lWU2MrOHZUMkRDaDk3bWtq?=
 =?utf-8?B?U2RlWGZqK2N2YXU5YzFIdHlnSGZER0JqQ1owMlcvdlpMVERQdDJUaVZOMCtk?=
 =?utf-8?B?UUNlS2kxNUhMcktMNDNDVjNpaUxvYUxoUkZnVUpyNHBEVjhzWVdTOE9yNFRp?=
 =?utf-8?B?SjBzYXJ3TzlZK2JnWUZudlNNdXUxdFFHNHpBMmc5WmwxbGlpTlVIeGFEQTFx?=
 =?utf-8?B?S2c3dEtLTFlIOG8zTFNoZ2dwdTBueWRyTjlHKzlCb1ZqaWYrTDdDa2g3c052?=
 =?utf-8?B?Wk9RWllFVE9WdElDTElFanpVNWR6SzFjQUZBM01WczZEeWhiUk9HTWhRN0Na?=
 =?utf-8?B?TjIyNC9CYVRhY3JlMGpYUGxpOEpjOFFENExmYkhXMkt4NEg5ajR0TjBEYlNv?=
 =?utf-8?B?U3ByRGl0OVBVWklUYThWRk9TazJhbXR0Sld4dDJScHh2b2V4QW43QUVSWVhN?=
 =?utf-8?B?Qk43Um5HeEt5ZjdDSnFneHVPeHljeloreG0yWHY5TmwvQS9sbWViWjBVV0xZ?=
 =?utf-8?B?WkpZblZHU2xTMzA3L3QyTnNFdy9sVGhSTkFhRlNaYm9JR05pYTlNb0pDYko2?=
 =?utf-8?B?QktSRjYzSHUyb3J1Qml1U0tpQjlnNmlGckR4Sk4wWEVxU3dManRWa3FFTjA0?=
 =?utf-8?B?N0EwR013M3Fld25Ud3B3MWo4QUsxZ2JGT1BNYUhWVHhwS2phZ3hBLzVrNWxy?=
 =?utf-8?B?ZWF3M1Y4UnA5aVpjcXNNenB6c2lkdTIrMjVON3Qya1hYSFBjRGFmQytaOGxv?=
 =?utf-8?B?UGVoVDI5L014RWZCRlJQNFIwaURaaFFNb0pQRk5uZ0t6YjBpaWZRRGRZeHVF?=
 =?utf-8?B?aUJBc2s0OFdteWk4NHNTSjNrM3NjdCtPbTEybW1iMkJ0aXhzMVBNd1ZZaERR?=
 =?utf-8?B?OUFNMEJrYVllRnhRMXA1dW9qcVNVSGFQeHpnbktzU3Q2cjZBemRhNE4yK2hy?=
 =?utf-8?B?VFA4cUIxakV1VDR0TExlclhPWkJwTjBENzFRdHp3Tll1YXkzdnhXckNwUUxC?=
 =?utf-8?B?ZjJZVUdNditQTzlPMFVDNGdRMU1zUjBOT081VHJBU3RkR1haNGRTVnEwa3B0?=
 =?utf-8?B?N0ZQZENjSzd4cnFDK2xYTm9VajdjMGp3MldkbnBwZTdFWVpIeUpiNlJWTDFI?=
 =?utf-8?B?bngxTU5IdVo5RVFjc01nREVJZ1JhNmhpc2w4aitkd1FrZHo5YjhPc1JlMjFH?=
 =?utf-8?B?OXhoTUdSZWxKSWtab0ZRMm1mWlFybERwSVVmSlh3bGFkcWQ5MUhzL3UyVEtY?=
 =?utf-8?B?Vmp2dDdETHdzQnFrd0hsTXdWWU5wUjdnNnBXUzg2RzdwTnFPNXArSjRPVlhj?=
 =?utf-8?Q?6aN2zWjS8zeZR/BE=3D?=
X-Exchange-RoutingPolicyChecked: uBeDQrcsiSPY8nAE3QSkgh2XIWtmu/V+o3tb+MJV2i1KBwc1XXKDhZY69GFmlibB4qSdl5Up01g4xWBK9snICVKMCZZ1BYqbi73aXhoSctpVFXTM87c/iMSkQWAMK0FyJchrpOWvwwvbhZbPYgWoACmSeJaxILBcJ7Mm/9UoOJKvgY+ofJq6Xr2XE9ne0atokd2zV9/fJK6MT5T1ZujtaZI70ls//XBkHjxkM3Qh5uOHVejD5EZhOwqMD92Y0OCPx1PITvDBrIjRuHFcgtKOLrApNwwphWItDfEAkbGmUxDtepVTZdClqAov2r1cfJJcls2p7NFDtvThe7My8onb5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e633ff5-1ca6-4bc9-eba4-08df23f64fe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 22:08:12.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvTKL8SvQsvakvQ6GghPqMkZIO2p/LMMH0ipRwnNO456lFap2nOTNwrjPWk4ULaiLMPryVbH3+axV1zdzEbF3wqaHBmOiaMLGIw3Nhjx6tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7572
X-OriginatorOrg: intel.com

On 10/4/2026 4:43 AM, Runyu Xiao wrote:
> The fm10k service timer rearms itself from its callback. During PCI
> removal, timer_delete_sync() waits for a running callback but does not
> prevent a callback or another service path from rearming the timer. This
> can leave the timer referencing the fm10k_intfc after free_netdev().
> 
> Use timer_shutdown_sync() to permanently prevent rearming before teardown
> continues.
> 
> The issue was identified by code inspection. No runtime reproduction or
> trace demonstrating the failure is available.
> 
> The patch was not tested on real hardware. No hardware- or
> firmware-specific runtime result is available. Validation used source
> review and available build or emulation checks.
> 
> Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index f5b4d0627..836664cfd 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
>  	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
>  	struct net_device *netdev = interface->netdev;
>  
> -	timer_delete_sync(&interface->service_timer);
> +	timer_shutdown_sync(&interface->service_timer);
>  

I don't think I have access to hardware to test this anymore :\, but...

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

>  	fm10k_stop_service_event(interface);
>  	fm10k_stop_macvlan_task(interface);

