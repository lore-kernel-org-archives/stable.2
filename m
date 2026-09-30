Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94543D1A81;
	Wed, 30 Sep 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767979; cv=fail; b=Gmk/0HTMKO9vX/yO75QU11d1rVNRMTUCkk8/StXaLBUle/TZwvhpBcfRZ4C1Ty3ThN5A65TAzJWMOmPq6OI3yqb0xEFwlmLQYYrFAY0xahMfw5tfUWqClACc8LTCcWkyIdQXcI7uymkgBsNScvx0wqTYGAfLHlQw8m5CCr1qovk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767979; c=relaxed/simple;
	bh=apzbtAnj4yw/UvNkF8CXa5oNSOIMxCrhiglJTIJ/RNk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CRE/2JVlyvkIZA11a9xn2zQOZIZy+4BIwfFQ1ONnh/+sKQ9ZxWrTE149OajuFBr9dG+gbYhhy+g3HfQWW5nlDCWk6GuBFOn09cu+E6rpYqYIYEIMCwdZ6pqbeoikOaeWAaXFHSWnkHgjbiE1q3EnaDVKY1xTghAu7sVfugHIDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBlROCp6; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBlROCp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790767977; x=1822303977;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=apzbtAnj4yw/UvNkF8CXa5oNSOIMxCrhiglJTIJ/RNk=;
  b=WBlROCp6FRUxsbRRbY1NO5SauH+X295lVg3/3cEbHKIilnoV+byhGATD
   5q0CniilqHyaDBGbBGTfaIKvmLXSrPc4BqkMpd9B3Zq6IF6iSOwNKPp7q
   feNyRqttCOlsW2sCWoq/WMeC5tnveCyVR4ZwhHjB2ytM6Hq7km1cGAHJl
   FYViuoMpmo8TS+Jt3zlPi7yUhxE+JYpgPZ60kh00RvB9k1ZoXd2Q6tycb
   HmyrGO+ND9A7aQJSvXDmI/HKOqhsgr2YNDwM2E/7aEbRuHxnPLXltMseU
   KLOGQ3CxbHABJ5msHycFVsNP1b1ECxgYdYGwcq2SOaNbj99/RJhnkTgyx
   w==;
X-CSE-ConnectionGUID: qgClm71SSUG6d/YiKiS6Og==
X-CSE-MsgGUID: fyTM8Jp/S/+mPDN/hXxGQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101667380"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="101667380"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:32:56 -0700
X-CSE-ConnectionGUID: 0yIT4h8oRlOfN2QSdLLquQ==
X-CSE-MsgGUID: FWzncsiPS6W/S+elFmvhWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274789547"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 04:32:56 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 04:32:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 04:32:56 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 04:32:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9kGTfJz68TDduyoH+DdLe6l1amPGeyI2Qkn8fN0hKAaEI9rPJTZ8F4yBOT2DUCihPLcSkyhR5/YdyHEHirZW0IVvUQbqUEftTNHKuDCqOejnMPSATK7I77sUhI9rDymlRxGqA2eJuE3Uptqek6yTt/gPZxWSMa3TaF9SgGPumN0yEA2gwoaASaOb1EIQmECvKPCidGHHw/DeRCngMDAHlhwWL7XQVhdor2USretqRCN3t7vWJJR7qeDmeUBUaqaQoph757HwmNuOoZ+ugTcpQyiJUfT42+qWjASmoiCT2SXIBwxwm4xPartHeica7DAfD8uDAeuEEdUYVEkPt0Sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jMMYjXJAke72Ay0OC8qdqv+YI4jtmsxykB0AhQ5LuU=;
 b=pUk4uBl8w5WZ5p5JTi/LeMv1+Z5wv4WAkIeUD9wNpOSFt7zOG38iKAoqh6AnOJ3xXcA02If0YoqCmLw6V0GKmllQpzsnDnVvuFozVJ4pWM224wzu5NxTHERrjyPfs6hn3q8VJOngO3c2JN0/g2JBUrADY0ZnWX1VTjUerYjoWRTOkK48ThxvEkcN6zI42hD4x+KOq4t3Y9WLyTVGQD/BhWZ8bDFd38v9VOqn1Qx7pkqzUIbVFxemvDi76oPQbhqj0pBRgVWHnK2yUqF0HaDDAKY8sEWHwLIMiqAb3y3sJ+X4a9CP+JCiSoWZH6DTdswHeRWdtIjnR/k15iauYJVpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SJ2PR11MB8513.namprd11.prod.outlook.com (2603:10b6:a03:56e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 11:32:53 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0451.014; Wed, 30 Sep 2026
 11:32:51 +0000
Message-ID: <1e749682-a51d-4e07-9db8-c8f7cb4f439a@intel.com>
Date: Wed, 30 Sep 2026 13:32:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
To: Dave Butler <david.butler@appgate.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"emil.s.tantilov@intel.com" <emil.s.tantilov@intel.com>,
	"luoxuanqiang@kylinos.cn" <luoxuanqiang@kylinos.cn>,
	"bryan.fraschetti@canonical.com" <bryan.fraschetti@canonical.com>,
	"tristan@talencesecurity.com" <tristan@talencesecurity.com>,
	"tomasz.lichwala@linux.intel.com" <tomasz.lichwala@linux.intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <20260928230429.495442-7-anthony.l.nguyen@intel.com>
 <ab87c498-b1c3-4d0d-b4ba-57e1826592a8@intel.com>
 <DS7PR05MB73201A15AD9E0795156F88B18B8C2@DS7PR05MB7320.namprd05.prod.outlook.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <DS7PR05MB73201A15AD9E0795156F88B18B8C2@DS7PR05MB7320.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0129.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SJ2PR11MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f3d5f2-47da-4641-4d6d-08df1ee68f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6mRsrTe3NRdC1UacqrYt9GWfqLfj7MSj5o0jHb0UrFVQss5axgn3Asw1AGvjIYDTnawng5K2sKXZRECm/EjwgIg799rDYShjbx6vRmiPwFwuimtOnm/Lk+OYJA1C/7NFCrHifAgkJL2WFfyUAocnXA8TXhzy1OsqgeVDrJZPEU09HyoqYXCfxLxshq8+FRd1dCS9AwZPXouk2kEX+g1aa8oqVKQmoBjUzep/chRG3w8sx5VGCV48cCS6KGyjBYDbdSIxIVJqWBz31imM3Yrh3/9uvGGNape/GI2EphWv9PRtmJ5bWnMw9lzoGzmhuDLuEl2h+E20gBvPXiSHdsIL+DZpb4inJyirvXxRXQNl0TWzakCiNbvnL8qRBdXER8tVMeQCbjviflR4Vt8y+GYHioYjH9Olv7Cnpar6Fxedle/ckb/zlCkysYQfa7mTkEx3+NOngCVjDfdv8PR9p3CEiUr2EI8gG7TDV+IXvn1YrrXduBYdz1rGMb1AVWu1zf/gbUDCQyDUk1TceJFjzEcguGgMh43TKOqTjfUvJmzwxqYAbJ+uxX1qmKLjfWSPROPWgxveo26SiO3e5IKJ+wD8l0hbBlS0ArQN9LO5t0XeEyEgg70zUyUsap/E5Zgqfv4ZVAC9Sg6bZH3zy9mM8SozY1IxEyPl9Q5+ZLEw+YcKJsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZmSFNQVVJBallWYmhWQS9qdTFYSU9pL2Q2VVdnR2syYVk2SERQWU1qWUFJ?=
 =?utf-8?B?VDBKdnhYTnRpV0lXMzFteDZ6SDRvblRneXhaWTZITVBxS0dDMXJzMUZKcEFr?=
 =?utf-8?B?ZEN3V2E2azZtQnVmV015cjlLN0N4bVdEZmZ0RDMrNDlRVHZqK2hXQlJVMU83?=
 =?utf-8?B?bnQ4amY5TVNuQURTdk5yMGo0SFFQWGNlMWZ6VjVlVHhHMmY3M2llcFM2LzBz?=
 =?utf-8?B?WHJqdkFEWk5BaFA5bGJtYyt2NVpTc29wM1VMTlBBM3pJd0w1SXVoV1BSMmFB?=
 =?utf-8?B?b2ZWS3YxclVrOU84S3B6NXVkbVlaTm9RbkNrSnV4WU5JZ3plUmVaeldXdzl2?=
 =?utf-8?B?WmhXZmRTcFhDbktFQi9qa1VQaW1JMWdIdUZ6TTVlYVhLcFppUlZTdXZYOXJX?=
 =?utf-8?B?bDV5MkIxeFhNNkwxTHZiV2xOQ0ZZWFVhRER0RitFMlhGelF4a2xjSmlLTDYv?=
 =?utf-8?B?SWlVV0YrSTlwdk81T1pYQk9mKzNIeDB0MzhObGd5Znp3QXhqdUhKSHcxSzhm?=
 =?utf-8?B?eDNWSmtwUjRXRWYzdWxCeis0bUtBb1BjVWkreENWZkxOWXRsR21LYW5Odklz?=
 =?utf-8?B?a2d2RTZJb3NtaDdHd0NYQTdXM0lBemxQcSt2K2VmYmhiQk9vNjFXY1hNUmxX?=
 =?utf-8?B?U0F0eVFnZlpneW43TGlPcVQ2NS9oTmU4eTd4WXQzenpKVUVYcE9pZGxaWm1U?=
 =?utf-8?B?Z0VlM3Q2ZnJ3akpsMG1lLzg3VGdDbndtZ29MVEwvbE92WC9mOG5rY1NZZ1JF?=
 =?utf-8?B?bDlUWWFPTDJHNElsRlZnZTlEM3hMSkVMYTQ5R01ZY3hxQUVwOW40c1Njczhy?=
 =?utf-8?B?aDNQR2tBdDRJc3UrcjVWZitJNm1YZmlSKy9sd2FNcmwwVkVNekZyVzU2ZFBJ?=
 =?utf-8?B?bWthOGNvN1dCYW5NbEtSaXdDK3FCS1hIU1lDRUtkSEJCc3hFL2ZnQjlzbm8w?=
 =?utf-8?B?TGhxN290OVhMaFBIV0J4Vks5OEZ5TEh3RWtDVHNVUkZPcERVRlY0WXJBNUZh?=
 =?utf-8?B?Y1F3Z05wc1BCS1hNUnpBU0ZFbWRQZlUreEJvRUsrVnZNL3l6SmUreGdmWXo3?=
 =?utf-8?B?N2JrMDZxMnp5eHcxWUlvZy9yK1JjVFZJdjFNUSt5aDlXcGZyOGZpdkFmbjZi?=
 =?utf-8?B?YW92WWZFY3ZnV3FzRjBaTzBNMGk5TjNDb1JQTU5UNC9nM1RFamxYTGdUdTAy?=
 =?utf-8?B?NkNiVjIvNzQ0T21WSHNHdVY0S2lIa1hrb3BGMDJGdDFjZ0ZzS1FSalNUcW9M?=
 =?utf-8?B?S01IMytyRFhOYTNtclA5c0x4aWsrSk9mSG9mRGJSZW1IOTQwN2M0OTFscHFI?=
 =?utf-8?B?UzduRlVVS25LMi9pRGdscU9hTmpwZitSMUx3Y1VpOHhESGZ4ZlBNSTdlcW1I?=
 =?utf-8?B?NHIwYXh2QUMxdy82WWtpV3ExQjBBWmFvT1h0VmJxTG1LOUpBOGRqNXRWckpq?=
 =?utf-8?B?eFh4cFlCamovS2ZxUFJYNlBLWGVlV2V4QitJN0ZsQllEN3pHVHI2bmJiTHc5?=
 =?utf-8?B?NXFsa2JqamJIby9hQzdMTjlSQTZZYWxwZzhpOHNtaVpZNnN5OGJaangrcjVo?=
 =?utf-8?B?bW9Kd2c1U3lhbW1aeHBGenZWTnBja0ZTeDl0d3ZOVUVlNXI0enJCZDBVY3My?=
 =?utf-8?B?WXhVTElMcFc2WVZGRXpJSERxN3NmNG9zQWZJczZ4aGNKU05RMHFhMTV6ZmZi?=
 =?utf-8?B?cXA4elZlaS9CdGhBV1lLRWhkL01qdlAvK1FERFN6cnBGTUh4OUdmcEdiQ1hn?=
 =?utf-8?B?VXhIM2lkL1U1ZTcwaVpnWjVLdm5ETkYxY09GZWZOMHlJU1BMWnpqNk5vN0Vr?=
 =?utf-8?B?UzVPWTQyZFpmRXR6NktobUtycVVGSy9aY0FYZE1Kb0M0SjduWlpWd0U2SkJS?=
 =?utf-8?B?cjA1Rkg3UU1UaFc3blJwSDRLVWFsTGhzQVlYOTFJcG1yTHRHRGtrWm84YXJK?=
 =?utf-8?B?T1hjclJIenBnZ2V2SFhKZVRkOEgvekVhaklVTUFyd1F4bERSQ1lBUHMwYjdv?=
 =?utf-8?B?VUQ4ZDI0eVVOR2o2R29mZmladFRHclJYYUdxK2lNZ0NoU0FNOTJxK2NtOS9a?=
 =?utf-8?B?WDh4dzlUZXFyQnEvV1JzU1djTC92bThYSGxNZDJTYnRaNnZUYW5XTEh6N09F?=
 =?utf-8?B?ZUJLT0lXTWs3UEV0ekN4YUtLaU5pTjlVUmxJT2EybHd6elpyRzgrbXZ5Vk1V?=
 =?utf-8?B?MUVRSXhzMVVQZXlPMFlSSmFqTkJPOVlWN2hQSHdGaS9lU2s3VnI3ZGpLVC9H?=
 =?utf-8?B?NUFRMzAyT3FwTE5iT2xFckJtVmhQSUt1dHUwcDExRitvZlYxbWdQZkxtNXdU?=
 =?utf-8?B?dk1BYmlDSVNKQVA0bEtpNzBsNW5xbE5veVkvT2FseFdzZHhKTnFvS1BNaXJY?=
 =?utf-8?Q?sUgNEgdKl8y5fw+E=3D?=
X-Exchange-RoutingPolicyChecked: FNBxnTf0/th2abrOL0+F8GCXsH2HaEX5SP8pfmcigQqp43VLkvAS7hQtC+Uy7CwN58osYIqbBKN+mKkHbQnR3ozmJTsCbMHH/RD5jr0GeavFyim1isHmm6ZAIi/wFVdZVkUMLwhWs0IVo6uqBBDKZG80cujuXhcgOL853sOHKxrWaalDSVaUcZNNHECIhIFolJMYFfyq8uhhGeJjdTeehrzuFGHPXY0wZnsDjYPV4WxGpI/CKdqlusj4AHAtrcMpBsJxNmdvp5/Y9w74jxN1GnkJtU6rZEM8xXPbJpzZj1fuPbkDI5XgOhnzD0DWD/EQclwnywCYoK65x6siTOanGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f3d5f2-47da-4641-4d6d-08df1ee68f57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 11:32:50.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CycBOvfhbQXomdteJAENWLDilScbvuYTYU0zPe7vWHFUus5kHqs7l/RaR8mvUzQAnWsA6NzUPOG8i13cstJDV96utaw2e+/Jdk/iN9y5oDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8513
X-OriginatorOrg: intel.com

From: Dave Butler <david.butler@appgate.com>
Date: Tue, 29 Sep 2026 20:32:53 +0000

>>> +     max_frame = min(max_frame, LIBIE_MAX_RX_BUF_LEN);
>> Shouldn't we cap it to 9728 instead?
> 
> No objection.  To be clear, LIBIE_MAX_RX_BUF_LEN is 9728, so it's
> the same value.

Oops sorry, I did misread. I thought for some reason that you now limit
it to (4096 - hr/tr overhead) >_<

Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> 
> Before 5fa4caff59f2 the cap was IAVF_MAX_RXBUFFER (9728, "largest size for
> single descriptor"), and that same commit replaced it with LIBIE_MAX_RX_BUF_LEN
> (9728U, "The largest size for a single descriptor as per HW").
> 
> That said, I'm happy to do whatever.  Just let me know your preference.
> 
> Intended recipient is public
> The information contained in this electronic mail is confidential information intended only for the use of the individual(s) or entity(s) named. If the reader of the message is not the addressee (or authorized to receive for the addressee), you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender by reply e-mail and/or by telephone and destroy the original message.

Thanks,
Olek
