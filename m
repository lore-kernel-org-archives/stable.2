Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11F3B19D5;
	Wed, 15 Jul 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134329; cv=fail; b=dZL0JC2Z6UO0ejovvSCwIE5cGmEf3rmHf4/xmQAeShmP3HDF2OOA8mzDJYKtwN6/2x5aul0jiwwxgrJ56fy/HwThiW/n2ihunr5QsYv1yjo2JCsMU/xaUYOYV4mQjqAJ8/XU7isqttIeW07hqv5PmbGsEp5ZDvbkhv6btOwBncI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134329; c=relaxed/simple;
	bh=zXYL1/menh7E5Fqpp+h7WVPKrMxbhCCjh6Q0f1djqk8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XeNH12jA/Rn1t7putABOlkx2P+cbTi2qIDhUn3rQSY6vOlXMQAcMgf8UEJB6oN61NLLHdFcadJM0yaIg1N5Vm7mDJFbpFo4QbUM6dIwdFiNPmB7JlhclLT91lSOi4dnyAQ+qCitwzn6eCL/dPkoeKpDc37CBoqzlQD2CHRYe5mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gY0PYMYP; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gY0PYMYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784134327; x=1815670327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXYL1/menh7E5Fqpp+h7WVPKrMxbhCCjh6Q0f1djqk8=;
  b=gY0PYMYPJxbGQPMva0aOsJQtIRVqqbWOQSHX9N3q0EJfsj80ztJLA4tf
   Cn1zBrn86Ez3tY+zkJ0JftdMzJVIGTW52DeIy1CQqe1/nI9hO4uuql39Y
   BjOtj++BtMlEv22sbvmh/HaIeQHDJ+dIABk4uwrFwKIWfTGOodeb8+e/R
   cO8V73JTSkeipYL+1XdG9+ks7kT/Vjrl6dFbso/PBQAYURguWlvg9ajmz
   ixIV/NL5rUbQ2y6wXFvY94CjeDkb++w4+22AKMOvltVLGj6MN6S2NJt4q
   WV0gvx0HZbGFAtA7N5H+A7qFsKbCyBEtM1JQLzVCsmGNnqCNlVpywxRBD
   Q==;
X-CSE-ConnectionGUID: CIbCz524RCW4LjuHyAOtTA==
X-CSE-MsgGUID: 6KD65nobQUeRu62AZ2lxMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95134729"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="95134729"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:52:06 -0700
X-CSE-ConnectionGUID: 6lK1GPJdRvSEPkj0dD/vpQ==
X-CSE-MsgGUID: MBHgXCQFSOKhH26eMaIzPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256876911"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:52:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:52:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 09:52:04 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 09:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGzZUqAwlsokpOx7abYJGYiyiYfNMbsaqoky85iXOEgS5FqJlRrdURs5ArdVFmnbb0jZWpTVmVi8KcLyiBChjawGPq3nqG73mJ9HWY2sOnmLvrApJ2mSij5Yxgb67wTV+p4drc0CVLP7YN+5/0j7DbK/CQhi0E+hl65Qg8RI9YOCQhZUgd+pYTvgfDRIWYvSup0obs2FOT7oWGmMBq9baZicFgYVDfYLA93zp//VVpZJPcntrnfBgNC1AizQq9oRVe6mAXGNU1ivq3I73FACAKRyTR2a8gwUx3sgbm0HI25Pi+AQSvKhmfLQWs9kO8mEG9NFG0+jgDZLZmTdFHXzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZrgw4YtdIHxsHl6Mi8dMzZRbkQCDSGkc7sFBGNCx8I=;
 b=upW5jHA5cu5QHZ/L5EnNsDNKUj1ue7AU2qtEFD0XnE1Swh5yNnzT7OdspTo/w2PfjPeFbaWzDfwBdrboP23ppfLe0LZz3Q9dw2uIqjkkFKvB/lOINfbA1JgrzOYHww64S/gjmh/g1nqOlWvcgdlspt38mqyQux6oWedRUASZnEaVmhM/AB7IWgCWaB06Ok4ggYbPpTTIm1qMAMa6zipxWr+fWFdJ7HWfZe4OKYUkg7QMCX74uTs0SkxvJj8KYFiXS/Z0VOArnXAQon+YbDmBeF8mZpiduQCTJ+pf+6AkdVE+6s8yVoC9MtFkIv32LpFgQDLQZu0nG9gj/6EhBloXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA3PR11MB9351.namprd11.prod.outlook.com (2603:10b6:208:57c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 16:52:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 16:52:02 +0000
Message-ID: <e7276482-2e42-436b-a611-0defb49e7194@intel.com>
Date: Wed, 15 Jul 2026 09:51:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
To: Fan Wu <12321260@zju.edu.cn>
CC: Fan Wu <fanwu01@zju.edu.cn>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, Simon Horman <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <dingtianhong@huawei.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
 <a361aa28-7f55-4476-9072-aa392a34b735@intel.com>
 <190A7669-E0EC-4257-B65E-817FFA1ACCDC@zju.edu.cn>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <190A7669-E0EC-4257-B65E-817FFA1ACCDC@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA3PR11MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef6f968-785d-4f7a-7b3a-08dee29164cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: A1mfumcHcG68m0ivXaNnVJ5yooM1nOuR669vuFNRTxgr+jzS9VhQcQ5NkscZatVvGFDYnJf5t58EwXmXJ2VZqtQKoqIikLPEmBG3X1aGStRTkJcjtKSf89Cmg3JirTbOSQdXDqAouwQCcfYZrAWi39vho0W1sXqV7OlzbFPmFaPyCXZLjZn01Z7C1Uk1Lgxo54g6sGX6wVVE2WN+VismdNdC4wKFInusgKmcjmQzDeyBd9sfk/lfhRkLKIXKZsmjPAZd+Ewp9rsLcQ9xVRiNT/9NYbLBRPs2Vso+TA5vGtbT4lrHE5JPLgKLo2YNFs25beuZXCkUyf1pxXVm31xXSYjt3+gUZD7vHJzSB6WLXav3lYmfk4IFI0VXYlZII21Nfg9tKrcxyiXO8RjpjHjvi22s2fcEf36faBmaLGhYIInZaUBTTLvegLc+v1yxn5VlsLBPwRSiLM5jR9itiSIpb0/R3k424/3ZHZDeNonxcf9hDTmkO6Lqzu4OM+8P3xE4MSZsuqFK/A2tFaguireMc9rK2xZ0ZY2mrS9Uoszr7cS5l3HrUb1v00e+FItQpe5G/DwjTY5ubaZtNWP505xcubX5mNy2Ah6b4vRx+onVQuA2VGVtkcXGcDGy7m7qjBICyiyZVkCKX9DfqtQE1AYfp7AieIHi/OnhSsQNMrwpAq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THdNTkZ4aHdocGtDaU52VmpZdWJSZjJFSUk3MXRxOFhqd3doNCtPakxxdWZy?=
 =?utf-8?B?bjl3OXNHSC9iSGtBL2VHMFdOS01aSHhqRzBvdUx4bCtZd0xGVkx2MVU3T0lw?=
 =?utf-8?B?RkFhbThZWDBjdXdzSkdkZG96MVVOcjEwRmxjT1d2UWlJdTR0UHlOaHc1WUIy?=
 =?utf-8?B?SXpkZHdkMVZ0SG1NbmJzbVlHZjZncG5XNnZQT1hOTHl0N0I5M2k2OG5RVW5J?=
 =?utf-8?B?ZFMxemdKY3ExOWFzNDdmaU5vZjY0RGF3MWhBMUFtWnI0bnQrNU5hVFJKcmZH?=
 =?utf-8?B?YUV5c29uUkZUaWRIcEJNOFhrSU1ETXhPMDVla1hsalVpSVIxL29YbVkxWFA1?=
 =?utf-8?B?RVhWc0ZBM0NXV0ZBOVFHMEprQ3FOWmttMFJDYTI0aXNtR1JvRVhVZmZLYXpX?=
 =?utf-8?B?amgvZ25PUk15aWVwRVNBcnZVMnM1MmV6Ym5ueFYyb3JOWTZlSFJJdUFGUmxn?=
 =?utf-8?B?UkIyNUVSNkxiVnE3UUYxaWtNWVpDbkpRRVYvZzZMNTBFQnAraE03ekJHNFFT?=
 =?utf-8?B?bGJ6Mk01QTJIRG1iSndxOXRhTHAzdzJpVWNWb0NCYTlQaE1mSWpUSWFUMTNi?=
 =?utf-8?B?VGRvZWJpc004dFJCUHdhN3ltT3BHdUZsNFZ5VWFTVFNMaE9COGl2RnRWWmpX?=
 =?utf-8?B?OStBR2pWZS9PRnhiVndLSzhIVCtYYTZMV0xBZXQySmNzRjg2TjRVL3ZoZ2Q0?=
 =?utf-8?B?MlBOdjczQmNCSmZoTHpnRUgwQ2hDbXNHVjExK04zVEthbFBLTHk4VHFJYWZX?=
 =?utf-8?B?bXVrRjRjeFRIM1UyRStTVi9vMnMwc2puOGpIaUx6YUc4c0lJOEt2bFlUOUdI?=
 =?utf-8?B?dXV1TmR0UzhXUHJJSUpXWmlzWkJCN1hUbVZsMVR5YWJJUG1wSGhEVU1rZUJO?=
 =?utf-8?B?dnhNMjN0Z3dxR3dVSm9WSnhuUGxxMXJRSmZmWVQyaVlQaUt0a0pJUEhmSys3?=
 =?utf-8?B?V25uMEZ5Ujl2d1d5RWtVZmVmdFZiWWwrdVhtQzlQaXpEaFpLKytiZnQ0djlM?=
 =?utf-8?B?UWgrMWZXYWtxRVlYb3JiWGpINHQzankyb1dwMTF1MktjMDZHNm5HeUxmSU1H?=
 =?utf-8?B?YWVJQzNWY1haWTlPcWVOdEtneEZUYmRET0lZNDlaQmIyMWU2RWpsSmlrcERR?=
 =?utf-8?B?TW91dkRrdU12akxpUk9rdnBpeFhKakFBZllwLzZzL1ZZUnZlVVBwc2NaTmNI?=
 =?utf-8?B?RjR2UHpBcmRqVHBvVVQ5ZEp1Y1BUcTMrWjlvK2ZicmsvTWlRejd1MERTK29V?=
 =?utf-8?B?Y05IK2JlUlpUZXZ0ZTByY2VPYk0rUmJvVm5SQzRNQTBKR0VZekJURWtQLzU2?=
 =?utf-8?B?S2JNZ3l4bHhIdTFNU3hVL1MwT2VWeXZZMXVTYUExQzRvV3VVaFhuV2VYUmYr?=
 =?utf-8?B?bzF3VGQ5NnhPdEE1U1BRcFI3WVpFM0tXdS93azJBeVlZcG5Dd0tJaHFuMlND?=
 =?utf-8?B?R2FKTnBYWmhlcE03RWxOeGhwalYzQlBsQ1QzR3pDQnRJLy9oSlVSVHMvQTBy?=
 =?utf-8?B?QWNRT0FkMDNtaGxWVWxXMy9mT0l0bDZncHBqQ2MzWFBvU3ZJVnFMQ3B2dzRY?=
 =?utf-8?B?V1VkNHZ1eHdZUzNIRTZTNDVvTFUvaVhjZHQvOXFWcFdHeTdPK0tkc3d3YjYz?=
 =?utf-8?B?dVNxUm1wdVNvWHc4QVlQTGFibWI3WU85bnd5ZENtTVh3akJUMC91MUhsZ0pJ?=
 =?utf-8?B?Tmw2QU44d29SRUFDb1Q3TlVadnhXck9Ebk41b1h0ZTk0VE9hcWs3WG1VakNj?=
 =?utf-8?B?aXZQUlIrRTFoRlNUaUY0S0ZQTlRnR2QyY3RSTHRyRlhJeVZjUnpKbFpIUlVx?=
 =?utf-8?B?Q2NKRmVVSkwzWkMrZTh0RWdEZUJRRmF4ZnZYZnVtQ2tIbFRTaWVudVNXazA2?=
 =?utf-8?B?Z3FLZjJmdEdPMjhKeURBTUsyRGU4NGFucmhKTGdzTUdVOThoSkIrSDNzbEpS?=
 =?utf-8?B?c01UUW9LLzJiVzlEYStLQW1sbVFyU0hiTlM1dmlBL3hJUk8wQUNDcXlYT2Np?=
 =?utf-8?B?dnR5cnB3Q2pZcGdzRDdGdm5rZHRScTR4QlZOaktoMWNEU0Z4aW5TMEJ0dTF2?=
 =?utf-8?B?WDdCeXFNZW5XNVNFVDBZWUtjdzJDbitrT3lzdTZ6clFVVlRUejNpSlVXVjBp?=
 =?utf-8?B?YTJLdHhMelNYdFlJOUtvVkkxN3J6NmpPdUVyQjdsc3BPd2piU3liY2toK1ha?=
 =?utf-8?B?SjBpL1hkUDJKaUhWTWM2RnRLUWZ5WUlIc3FWam1mRmVNVk1UdDl5ZEhXdkRj?=
 =?utf-8?B?dGJWTzd3OTUvK1JVSmg5bTNSb1FTMmx0cWZvVUlYdmJUa2l2cUxFd3ZuWElt?=
 =?utf-8?B?aFY1RTcwR1doSStKQkwrZU4xNlFsTHdaUzRzZXV6cDRmblpzOXFWVEx5UWJj?=
 =?utf-8?Q?pw5RKBakbukYf+eA=3D?=
X-Exchange-RoutingPolicyChecked: fEKn7ouDiFAoywGs3NobgiB+/B7r/333vhAeVieqAaPxGBVTzaLKpUQm+F/RyFQVwsBPGbtea7t4A8nph1KAEed3f5SwqW4Z+h12TiQXW+tWMHsmQ2ETgzsHfnDqwIEpMY1aLkbvbJ7yQrWqItCTDbm3hrmH9mawdzobQbIVTObr2C7N8M9dihFVs0AJo4o5QA/WprMk2NJsk5I2zIK0tMMF/0bhPYnEQYXQmXloaJUzDtLX/bygHAsQtley1bpU2sat0CB7luxZoEkEinoemcrHiFDDDsmUYesPKgsWv1VjaboBC33iqVZQk48E0kJDRwae15R+xWDF4nkARD0tuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef6f968-785d-4f7a-7b3a-08dee29164cb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:52:02.4197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORVXMQRRRkf1S2KubwnjnmLcZFC9ZeSPunqt6O/q4H4vkdI1S3CcLKF7B7YVlrr3yTpeLvjcqErmw0WjhKGMu7iYvp7RwysDmOTXU8xYb0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9351
X-OriginatorOrg: intel.com

On 7/15/2026 12:30 AM, Fan Wu wrote:
> Hi Jacob,
> 
> Thanks for the review. I agree this is a rare allocation-failure path.
> 
> The leak is nevertheless deterministic from the ownership contract and
> the driver's control flow. __build_skb() documents that, on failure, it
> returns NULL without freeing the caller-provided data.
> 
> hip04_rx_poll() currently jumps to refill before dma_unmap_single().
> Refill then replaces rx_buf[rx_head] and rx_phys[rx_head], so the old
> fragment and its streaming DMA mapping are no longer reachable. The
> stop and free-ring paths only operate on entries still referenced by
> those arrays.
> 
> The fix leaves the slot, descriptor, rx_head, and rx_cnt_remaining
> unchanged, and returns budget. This tells NAPI that RX work remains
> outstanding and retries build_skb() using the same buffer. The additional
> skb_free_frag() handles the separate case where a replacement fragment
> was allocated but dma_map_single() failed before it was installed.
> 
> I hope this clarifies why the failure path is a deterministic leak even
> though I do not have a dynamic reproduction on HIP04 hardware.
> 

Thanks,
Jake

> Thanks,
> Fan
> 

