Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793832612;
	b=YFeFrHIbKuifP13cXD6UkNoqaxdPP7TOkhuxDeT931oIzXH8BsrPgsr09F1S5PlHTkrk
	 DnhvT5COkgH8g1fAgsCJE1gSHnvrlK7Pay2zc1rtZJMw6XFRSQ5435P0EFJE+AWGPWif5
	 T9CU7eC51QIhjSamIAIZqa3Et5qcUKS2FtoM1O5gCro6SDY7r0P5pP2ht/JjethblWUIe
	 pwA02isA7LDi/xyAlj9AtmBYbqK6JEXPSRvpDQsIP4XqKnQGYE/VxBKZx5Fkqdz8QhTJP
	 aOfmDeBbNmEKNY4KDXEBHfgd5rdyxTGUXAVW6o9Ad2WuvSIoVCDAQIAws8QO0CtJ8vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832612;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=McDq8uaJdeuoZQmr7jyKzeBtvQ3ciddFNQBdyYBcXiE=;
	b=jLNNaHTLqa0FzxxjHfPbTy5fk1TvlA3iT3Rj80A8FJowy9aL9bYVhz9p/jJgfDZg++nW
	 fntjV2iXfPxyq9yb9DMlGfG+unpAh9urIe/pgRgCdvpSjbfVAoxHsITM0VvEC84r+JlAF
	 dlzLshYZ/YeiavTeC5L3rzdBqHzK/IyeG8RU8HritWueCe136clIGkN6GE2eor3ZXL+70
	 LzlWJEMoyFiXwjouhtzafTEBXNdSv+tHkCsUhhlzT50vuv0ddGftFHDZIitOUAI+SSUkG
	 d1bHYkFe5aOBxb+SSi/H1hTu2xaNMZf6ykuivBGVE7Li8ZpikTU+oz3AkT6QMiBPrXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="L/t9q3QL";
	arc=fail smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09756606A31B;
	Wed,  4 Nov 2026 22:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09756606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L/t9q3QL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793832610; x=1825368610;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6YdJKJARnCixqowgQpqymiBmi6zGtAtQSKkzJ72PaFA=;
  b=L/t9q3QLAOvgvuKHRedPzv49HGiQjS29SIU4UagEZgFWJT/7BfcC6lBy
   HKkSLdV+9juoeCdXHTkAFdBiDmYz2niTzb9+eWIREuRO1D9rAD55t17z1
   mBhud9BoM5FNKN6CGslqkhlHuSWX2WxyL8dQ2dS8Zzr2UogRfPOuuCz/5
   RvNwECnYoT/N3tl0PffRnwQhlHFSAPQeIYmFeqOeKGt6gFdMfOn/BMDM+
   AXQJ/a/I1/H/sLWpzYJjx2eLtYUr/6gPHuW8AJB2A1a5h2Kdxd6W6glUG
   DiaPfEHxHu1EhWUu5zfpg+gpNgaeEgHqJsvirbCKIRxki9RN5eyiGZ4RL
   g==;
X-CSE-ConnectionGUID: DdTu99CuQLKQ26CL0bwwcA==
X-CSE-MsgGUID: DeYaAPtrSgK6sH4KI165zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2478800"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2478800"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 14:50:09 -0800
X-CSE-ConnectionGUID: KvoFjNAKSw2lvOIqCQjyEQ==
X-CSE-MsgGUID: zrNial+4RbaRUcqGKPJVSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6842408"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 14:50:09 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:50:08 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 14:50:08 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:50:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuBhWX3n68A25J9cpYjxlYNGQyXPz4Ln/tcZqktrARDbxAmUoV/VgW0SSsEqO1qgtmA6l212kORSq+ybRTnP+FWbz/UrSw2NDCGA8NZXONKhLVT4/Z2DRl5NSxVW5aFOjVJfS6mb1xcKattJEFydQ9y8Of7N14LzP4FPZd4DdnCITNvvYceIUUbxjW+nqqbfp9C/B1uA/tz45j80WDn7iOCv55luMaKrx5g1CqeIxGA0e3V0Mrn6dRFYmELOp97HX+wCL0HatuFG3OPmb6bR7A9ArJOLSGt1akbrJRFp/Q4rJygbCOoUYAhSduUdNPYpxYPkREPtygh6EvWBz9HPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McDq8uaJdeuoZQmr7jyKzeBtvQ3ciddFNQBdyYBcXiE=;
 b=sC1FhWzUxaNdjVa6g6vkoj3X3wqhnZLJ4pgn3b0AGFpxwJvShdYBG/tgU+R7PjWcdPNTeJdLjz0gy9GknjDjt2k8o9MeCC+oUXamp9LbU0LElYQK1flQXXiQmnB9vNVAAQMzhobOS+0bhnN6EXE1q+7kud6I8BLSuzEdqqqmY4g/obB6Mlr0x0eH/AvjVt0Foe4C/Uy1OabcLoo8LGj5Y/KqpmQNtKcVCcuel/8mOrR7btQJ+2i7wumeXabOa0HRV8FisFmHnnAC8OmoAuQFketC+qv/ohTDarT8pXnzDekZVv3ZvpVstQNBC7AJEfUnRwbTSPw0h0hTJmtdWOOg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 22:50:02 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 22:49:55 +0000
Message-ID: <c2191a11-4148-463e-aec4-c1ffe5c732d7@intel.com>
Date: Wed, 4 Nov 2026 14:49:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: enable the RxOverflow interrupt again
To: Jure Rebernik <jure.rebernik@luxonis.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261101102720.702600-1-jure.rebernik@luxonis.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261101102720.702600-1-jure.rebernik@luxonis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:303:6b::30) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|SA3PR11MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: a43465b6-de3a-4e30-4119-08df3ac5f208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|10067099003|22082099003|261102123227099003|18002099003|261022105027099003|56012099006|5023799004|11063799006|261021121427099003|261026121527099003|261021135927099003|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: bZC6QJzEZEceZG4uvXCC8yPy/Fds/NL5+MWHaNKjKVyHnrcQhQ18Y/uA6DOOlfuFm+ux0slWh2GAcRO0iGgHpoR6mDGPmgY/0wGRYq/2dz3XkTvAjFbu+C4zky1PJfGbwOqtX4DqwC68yftaLkc5dIjY3Vh+bFrJDbPz/osveLdOtLmot0ObEkdqtNYSWdWlFLCn9xhrmr2g22iaeXnx2vBppZ1XSZpJV8UDi5UyLPx5W3YBMpGd4xMbNtskhdi2TYSBqcnA2X4ytY2RU9BJQuvVVQzkkU0tXbKTNxB77x8yMqRNIhCJHwBMB9GXbL8OrthjuUYFViyp3ol99Jt+wHpbSV/CkiUY5rExQ/EqykBffU8DG2+mRPWvIINCXJlg02yTIrr9WDUrksLcK4NUpH1fvABQ7u1/L2oWTHfFiIP+3fTiqzKjM0zpJ96ZnNV0hMHkdDUEtOUgItbEnEO7eq51U2G8ZI7ljbc8TrAmc9/JMMsMvex2YLCiQLsdnie85o0HyuaLz/aY/R2vUOxxFwN71xYq7qT9+DjYHlNVqCCF2BbNut+ojafbhvW1a1lyXUDNH+Hs39BZOGgQRsups/TogLoWf4qH5p9S4+AXpGYLSgwY4WZ3/UjGXiKPsj8jew32w5/kPE8ZscJiDSs9Mzw2sLhV5u01dTqSW8wUiQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261022105027099003)(56012099006)(5023799004)(11063799006)(261021121427099003)(261026121527099003)(261021135927099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzhHR29TRDVzYVBXcmV1ZlB3ejk2OGZGa1NYR3lkL0hoSzVmbWRkSHNWTzFt?=
 =?utf-8?B?Y1lOSmtyVFIzRDJrK0ZZWmJJbUlsN1d4S1VzWGROSThNMXBReG1EQW9UMVRL?=
 =?utf-8?B?Q0JlVGk1M1lscTNPWTNCS2V2U1hndjZIT1YzTlZvVHdGd3ZzRDQyeHE4R2Zv?=
 =?utf-8?B?cmFRWHZjTXRvMCs0UnMxTGRzekdJOWVscFg4YmVhNGlqaEgxK3JvbHZra2Q3?=
 =?utf-8?B?YjBsSGNybUhMZ3cvdEo1Yk90WXF2WEF4Q3BteCtEWHF0aDVJOW5xOEwwMW5C?=
 =?utf-8?B?RllMT1UvQUJnVXowclNjNy9vSUNFVzJNdXJYbnJsaERJbnphT1RnZkFJd2Fr?=
 =?utf-8?B?WFg4dkZWcWRnMzJZd2FKQUdnNGpYbkxHSnVRUE85a0Z5VUtzVVVTNDArdU5R?=
 =?utf-8?B?VnFucXl2NXZXdEl2QkZCMjEvT2JkVFVvanZCSHJkdWJLQWxhQ1JzZXZhRlhi?=
 =?utf-8?B?Vkt4T0o5RHRueVN0VzFOdWNLcldXZjhzNStrZnZ3Z2ptMU5xZDV4Y2NPMVhT?=
 =?utf-8?B?NjgvWWhYaDRWcUlUY25yVVhTeDR3OU8ydUZtWGZCNTZVTWNaQUlRVThhTVVW?=
 =?utf-8?B?SEFiNytDeUhzR2I1NHJoWWI0aTNrMDlhQmJaSThGUVN6dllPN0VhYnRMSHo3?=
 =?utf-8?B?RVJaYUdoK1F4RUMvTlhLZURiMmUrTTAvNW1tT3VJVXNpTXVhVzNGYktqbTg3?=
 =?utf-8?B?dnkyTmd4VmhGR21NbzJYN2ZYRVBCalM5Rnlzb0pjM3hORzJZak5weFJta05j?=
 =?utf-8?B?RzFIRTVzaXhQc3hKZWIvbVpQR3lHN3hEaVFCdEowaHcyVFhQZTA2MTNLT3V1?=
 =?utf-8?B?VmpmVXY3TlBMSTRjMHp6WWdzZ2JvWm9Ja3JQQUdiNnRGMW5DL2syS0pJR3ls?=
 =?utf-8?B?ZEM3VUJmcDFaN3JQMnZoeHBPbWQxUXZQNEhPRjhsUkxaeFJjWll3c2NHay9p?=
 =?utf-8?B?MnkyMSsrZytTTGhtYU1PUTIyYTcyUFdyTFFaTlRvRnZoVkE0RVZtTE9yOWVS?=
 =?utf-8?B?QXMvd3BHeWVwMmNqL0hKeGM2QVQzQWVlRWJpMEsxcXFSRmdNRWd5WDQ2dTZB?=
 =?utf-8?B?Vk5JUXdtbnNJWXM3empnRXBmYk9FTlJyQStoRFA4MHpUbFJVMTRXcE41QTNU?=
 =?utf-8?B?Nzdkem5QQ3c0WEJJV1F4ZGw2NDVGWmJ0VXQ0QkF4dU5IZDhMbGlJQ3gveFpX?=
 =?utf-8?B?TnVVMzRZcUNPbFE3Tld4aGp5aGFSZHRHZHBnWE5ZVWlyQnNKa2NNTGRSbVdF?=
 =?utf-8?B?bko5SG1GL0xKZy9tZ21SdTZKblA0QkdnWDE2emtwU1hQWmszTkdSeW9iNzk2?=
 =?utf-8?B?Qm9rVUxnb1diejJTS1JDU2JqZ0J4c2NjcXFQU0krNUlYeGxreWF6QVdicGd2?=
 =?utf-8?B?U2pjV1RTbVZnSmpKaUZiMjZHRlV6ekpyUFFRREI0LzM5V0FQVC9BUVBQMEVn?=
 =?utf-8?B?dG56ZWNKRUl2ZUdYT3N0eTF3UnZJVFpsTlR6UkgxUHp2RU8yTXFtWElzQ3Q4?=
 =?utf-8?B?Vk5uMDdkVUtDM094QTE5Ny9kU0NqRGFwUC92WWdhM1JHWjlKNGFTL2FlNS9o?=
 =?utf-8?B?eFIxNEtNRGhUczQwakE1clNjVkgrdHpZWEVlL3NicjVyQzRJbHY4R2lJYTUw?=
 =?utf-8?B?UVpaSXZLdFZoU3hmNEVLaTRQYjFkRSs3b0s0NEsvSkE0NWdsSHlGSFVZcG1I?=
 =?utf-8?B?V3prUXl4ZzZKZHI3NVNwUGRRbmJpTUJ1bEowN2VyYVJ4SU91aXMrcmpaOWQ1?=
 =?utf-8?B?Si90YUxySUMxY0NjalFQWStNbkZPSHJESzFnL3M2bDllWjRBdEx1MmJVYnBv?=
 =?utf-8?B?eXZhdUxYSXNYMlV5RDhtZnZDMGd0TXQvdTJKWUxMek1zbjhPRWJIWFdTbVR2?=
 =?utf-8?B?RjBPY1BlV3pOTWdiUVpJT1hTTnAvTkxadnFBcXB1SEZlMTA3Z2JjNy9FTk9Y?=
 =?utf-8?B?cFJwUElLUUxMWFdWNkt5RU8rUERyS1lJZVVOWXNRRkxuT1BEOS93Q3Jjbm9I?=
 =?utf-8?B?SElDOHJsNkJVc0xCZWF3NE1zOGh6TXBJRUZodjVwUWRRYlhjMVRjblZoUHd5?=
 =?utf-8?B?QTdFb3dodFRuUVZDamRHZ1hwZk43VVhBdmFTUkZKVTZ1Qnh4VTRqZGZEdVpx?=
 =?utf-8?B?bWhxUXAzdlA1SDZHNjE3RWVtV2UzUmFkNSs4aEVSaXNwankvQk4xak9tWWRB?=
 =?utf-8?B?VmhsTE1OUGIrVFVTWjMrOVRPaHZLVDBOK1RXbnpXSVAzNHdySlgzSWpwS1dI?=
 =?utf-8?B?YWRkZjhhK1hiS3pkVnZydnJkaGhvNkV5MlBXamxSR0VITmNXeGxGcUliYkFR?=
 =?utf-8?B?MXNPZlBIYXNML2UxRlU1Mm1mbGU3MjRkWDlYRVRBNTVjZ05VOUFLK1lhSUky?=
 =?utf-8?Q?7ukrCKSzq7mMOJnw=3D?=
X-Exchange-RoutingPolicyChecked: gNEdIrrKXQniTPlHcqCrm1euYiR2SpkRB4IZFjfKVq6C4E1agqkqirNB4CNjnE4mMOZy2i0OBvugpQ00at6gqSkT+p3t+q0iKOVcjdiaRxuuNWVBLRUnoFnLPv0sLlPEU5r2mMQIdECcyeO9Zx+kDy1+xAK5EY12tBq56TMvjq1LmKhhf9gCSLVfR8e2leTIAOXocePs5NxK9Ym9l0KUzh8NMuv1szNHe2yVcPJ6MfRDZamBMKbB4H9kOcQQtMWKRr20Of6w//qK7g/2FeD45nqGVOAGxvb/gO4BL5ah7N5zFpZoeoQjw9ks+eMJPuQOuyWr4w/HVunxv+yBVybgWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a43465b6-de3a-4e30-4119-08df3ac5f208
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:49:55.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J51T4zFhAXje5Q+wEEVuQCVy/KoUP53tPv1pLjXj8+0m4CXBi6nAbbzs7oJFnweZzYRGFlQ1Lk3G8q2eSv55KPbrUb+34yrZ/59xDUTeHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com

On 11/1/2026 2:27 AM, Jure Rebernik wrote:
> Commit 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> removed RxOverflow (RxDescUnavail in the vendor driver) from the
> interrupt mask on the grounds that NAPI is scheduled anyway when the
> chip runs out of RX descriptors. On RTL8125B that does not hold.
> 

This commit says it was "Tested on RTL8168h."

> When the RTL8125B runs out of RX descriptors it sets RxOverflow and
> stops receiving. It does not start again when the driver returns
> descriptors to it, only when RxOverflow is cleared in IntrStatus.
> rtl8169_interrupt() clears only the bits it read on entry. If the ring
> fills while NAPI runs with the interrupt mask cleared, RxOverflow is
> set after that read and stays set: NAPI empties the ring, unmasks the
> interrupts and completes, the stopped receiver raises no RxOK, and
> RxOverflow is no longer an interrupt source. Reception stays stopped,
> and every frame is counted in rx_missed, until another event such as
> TxOK makes the handler clear all status bits.
> 
> This was observed on a machine in real use: an RTL8125B (XID 641) on
> the PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6. With UDP
> at 800 Mbit/s inbound and nothing sent by the host, reception stopped
> for seconds in 13 of 20 30 s runs, losing 5% to 31% of the datagrams,
> and a single transmitted packet restarted it. To confirm the cause,
> a debugfs dump added to a test build of the driver showed, during each
> stop, IntrMask 0x2f, IntrStatus 0x50, NAPI idle and all 256 RX
> descriptors owned by the NIC. Writing only RxOverflow to IntrStatus
> from user space, through the sysfs PCI resource mapping and with
> nothing transmitted, restarted reception in 17 of 17 stops.
> Reproducing the stall itself needs no kernel modification.
> 
> With this change backported to v7.2.6, 0 of 20 runs stopped and the
> worst run lost 0.03%, on two RTL8125B boards. It was build-tested,
> not run, on this tree, where the single-vector path RTL8125B uses
> is the same as in v7.2. The multi-vector mapping used by RTL8127 is
> not changed and was not tested.
> 
> Restore the mask of the chips that had RxOverflow before that commit.
> Only RTL8125B was tested.
> 
> The investigation was done with an AI coding assistant (Claude Code):
> it wrote the HIL test scripts, the debugfs instrumentation and the
> register tools used above, proposed this change and drafted this
> changelog. I reviewed the change and the evidence, and the test
> results above come from runs on our hardware.
> 
> Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
> ---
> 
> Notes:
>     This restores RxOverflow for every chip that had it before 6994520a3328,
>     but I could only test RTL8125B. If you prefer, I can send a v2 that sets
>     it for the RTL8125 family only (rtl_is_8125()).
> 

I was thinking that it might make sense to only remove RxOverflow from
RTL8168h, the one that the original change was tested on. However,  the
original change is not motivated as a bug fix, and I think given we
*know* it is harmful to have this bit clear on RTL8125B, I think I agree
with this implementation that sets it for all device types.

If people disagree, then I think v2 should just clear RxOverflow only
for RTL8168h rather than only keeping it on RTL8125 since thats the only
one claimed to be tested in the original commit. To me, it seems
entirely plausible that RTL8168h also has this same behavior and
requires the flag but simply wasted tested with this same use case.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index cd4ebc654dd0..62709160d354 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6086,7 +6086,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
>  		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -			tp->irq_mask |= SYSErr | RxFIFOOver;
> +			tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
> +		else
> +			tp->irq_mask |= RxOverflow;
>  	}
>  }
>  

