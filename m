Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792432421;
	b=LX9eTjLz/uq4S+casEgiON7P6Vt+T7WsCxYWbRA91UEvyS0QAGktVNrz6miJ1oATaQhK
	 bhVcUVHuuwaytGRApDcolPMnSyxuxAGv50nKngVnPH3yPGfMsGy+kOp1nVfECRYkjTA+0
	 zKjAXiH0t5LnW7dAplyrwDLNvRH8Qi2oS2neLlX8k8HgUBP5E/xiiwRpI8b1Hqs9DQn+e
	 CvEjblbIzRg1iEVahTHJWvD64Pb5CJm11riIqiCh6kStZ0Aacs8lcrUFfpsKiHMq9SKgv
	 Ux7zVIy4Cg7b5r9BCPMmIDPGqIYffqxEi5HLSTn9FmbLKn/8u8jPiGFr8cF5JZsggCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432421;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:From:Subject:To:
	 CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=2JWQeQQGivI9lH8TkgT8J6x/sQxmHej8acdswZ8WcW8=;
	b=k/q6s0s6BpO1nWjGa0ZWlPtwcFkFux8G7dpNho7RYWSvCfDVPcQKPx4qLWuzeTJyYtqM
	 l62/uDbhZzR/hjt8FMUTBdfJ1Du+KFOqij/z4d8AiiZwstJKd2UjA3OyerVlsOo8Jwymv
	 PtMBulNeviSetJLyBPeGk+f2VRvvDr7dTiBBhAD9P9+kbvhOrqtMokoJv46IBvOZM3u1E
	 m9HBf2W5M5q7+khUXl+aCWTzx6YfE4ZH/68WqHoF5GoZq69Y+LdcRpFYdAHQfMW0Mc/OW
	 YqaT2ok4gCYCFYeKKfPkN6J4GaGTIjYFMIDXvMV0x9tjgDiyip3VnQNac+xkAqR8C1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	arc=fail smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2F606A31F;
	Mon, 19 Oct 2026 17:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792432414; x=1823968414;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=drAm3HEzTJUtZEZX4KuedCczgOz/5tYW7IEsn51mdY8=;
  b=a29MZB4SozUr+WKhWZZ18MY4oKNMQ5K46YJau4gTrohM0poNUZc/duet
   fYGWqAhV3pCrmjmfHR6UpYRcIIrMTHnq1hb7rKow8ZbjumlEurv8Glpj1
   YZq8Gqc2MG3RfCELmOBniMLnM7uvAm9+77bpbinJnxSAM/H0e6aBAa9p6
   ER/gaIaHbZEfSqtVm6JxdyIENtIHRrj1sUfxj31lFsZXhYv6O/lShDcsG
   nlAU2GB5SdWVlKsn5qZZPoWN4pZsE8fRz/XA4QvjNGJa/sLQcRWo7j130
   Un9e5x/Ac5VJm0pGEouMETSVraFD0hdmTMsZSOOBJhjdwmOPKfMOWvSW4
   Q==;
X-CSE-ConnectionGUID: ohsox4GbT8+AaXH4miZQgA==
X-CSE-MsgGUID: Uxau1L6iSOW0hBxd4S5DBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1225001"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1225001"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 10:53:32 -0700
X-CSE-ConnectionGUID: u7ew6WmNQ3KqBDRVhBM23A==
X-CSE-MsgGUID: taYjHMnTQJm/xwhTn7o/yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2701367"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 10:53:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:53:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 10:53:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 10:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjpES0rQfUvitHHMbrxlZ3EFoj3PsENwG8JQbgr2JFP7EjViuPTmSt5JAtvBTu2qEP/lpvDjdHia5WkxssgvTj9tpRww2849rQx4gWHj8JRdzJmn1lacVt1Pb1Op6YGPPX7yrz1LWAn/86WmIMRTBml32ZQb7IUQ4QEYrWikg2OYRHThVCfMwtiUnrQE83dtSAysV5aUiAFrOjARnTsWo91Kt0MMpDIxoCPHGTqiW98fZkFxme1wf8eV41cqxmvfK31gLYz+I2/LqGQj8UJgzHDdQBGWm2F6WT3GANTdrrxHIoSoRiq0dTzsjt7IaVOzVnQwXUdi7+TRC9XkWeET8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JWQeQQGivI9lH8TkgT8J6x/sQxmHej8acdswZ8WcW8=;
 b=X33WF/EpQ2qLxv5ZnQaaI2YTG4ag3Uxbuvc/mVX8YpdG5R8e6v0rtco/HxB8RqhXFNWVH5Qob/02kIA/WiA/5j0w4hCHw+ipti2Q3iQVe92CIYmqgw2wxZn0rCgeyrFg9pNu63cdIj/HRy8PsfHrZPWjvMQ0MGIZszcQa1OkBjecgWpkOufYvROFSIqSif/tFPX8Eo7id19Z36F3MV3+GJ1mrGFsRkigeDUw79Mv8PfERJZEiJ2wORNLecfqU9GyRBfUCVFNZGBXBbuFRnqNV6VQFIjnH4BuAZkrhadlVp5ZqRdFnqeixv/EJO+Wh5pE4iDUns9rs/Gpaf9s153Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SJ0PR11MB4829.namprd11.prod.outlook.com (2603:10b6:a03:2d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 17:53:29 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0496.015; Mon, 19 Oct 2026
 17:53:28 +0000
Message-ID: <89727492-b1d1-4f14-955a-0673ebaee753@intel.com>
Date: Mon, 19 Oct 2026 10:53:24 -0700
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v2 1/2] x86/fpu: Fix memory leak with dynamic fpstate and
 exec()
To: Guixiong Wei <weiguixiong@bytedance.com>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H
 . Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <cover.1791428412.git.weiguixiong@bytedance.com>
 <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
 <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
Content-Language: en-US
In-Reply-To: <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SJ0PR11MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: 143af086-833b-4cd1-d960-08df2e09e18f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ttYD68IU46hUFyrcTu0fsUYCXVKKNjxVyw7xbdyge+TIE5+Gi92PvEwOvuJS+DMTtnVLKvBY1jNYGKBYoC8eKuIkDGI3f8/+sGlxYQyvhjEvLPSqA1UZuxgednGTRsJcQcRzTBL7xlI94omoY0NCAZNSrJ7h3WAjUyAgcLTRY2WBnx5oyJBreMjq632ziDP5Mn9DteJnDVEWCDqh4/WAKEYdIxtTTBi4WPmCsho+zHpGJsSiPibqMHRSDKZp7G59tKyeNuz9GPSnmhF5ANEIXrEQfWVCUiJofWggazjdCfq/thp3LA96A1pJmX3qcIBsOY2MMD9YB900jjeLl5RqAw1AmD5bbFKKYWtLZgluyCPeRo3goLpAEI057qWYlYWuaTi29PB3hCSf+vi3sGFTdRVrePymslT4wUFY7qqclhICjlskqJg18IykdKI26AUhW+yz9fZjqttoulso69j0AxzwjAca+au4cqTcq6FFyl4aWEp+JhESyT1I0wCMt0f+y9nnQvvDz+30X7YgMTdAGZMrztSDXYJK/Mrfor279dN8JWFLSUNA9lJ81k/hawf2ygPG/cP+MOICLOymRHDz0iehhqx7Vigc9TDdVZsi7gPwdeXvZ4VjoJbNu2BKJJuI/k4+02tzCsNbGlQYV6H3becUuTgrErbgEvl+3zPTXoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpxVUoxa2x1U2NacVBkdzFQL09GK0xpY1FndHNjVXhPWGpIa05yUFNKcW5Y?=
 =?utf-8?B?YlN0Q2NVWlJiMTNWZ0NyaGFDSE1iaHNXemQwemhwbkE4c1pqKzJMQzM1NGZr?=
 =?utf-8?B?R3NpczVSc2wzcUdWQ3lkV2ZuVC92ZWFsazBFWDlSZ1cxdlZXYWdZUFhFMjlD?=
 =?utf-8?B?MUxjc2N6aWprOExJd2tuNFZWQmNrbWFVZWV6cU9CRjBRTE5zYmtXSkpNcit4?=
 =?utf-8?B?dzRFWXBKTWVxOVk4OVByUEpWSTRPdS9UaSt4VGFrSlZpdEIxM3FnTmFkNEox?=
 =?utf-8?B?Z3NHMEZpTWZKY2lKYmdvUUlNZytBbmtobUIrTXY4aENjSi81V2owVUxITVNI?=
 =?utf-8?B?Q2pvd3RldGUrSmJ2US84RlBMbnA1Vys4NHVyamxXTUV5dkJwMWRyWnBJV2h3?=
 =?utf-8?B?SktiRWN5OTh3b0FFdExVRVVkUHNvTmNpZ01EelZrQmNOYlRSN01iaUZ6ZklJ?=
 =?utf-8?B?VjVUeWVzTzVSUGJLbEhWTEZYUGVlTzhSL1hxRmtoc0JKeEVvRGcwOHVTZTV4?=
 =?utf-8?B?OFdLUXZaZlBVUnFSTzRkUG5LNkh2NVptZGxoK2RZVWI0bUZpT3VTUmJUaGNq?=
 =?utf-8?B?ZkVacGtEdTJpVUllYnVtUnFQdXRpQ0VQdHcvUHNVWlE1dk9GckhOWWdzaUM2?=
 =?utf-8?B?QkczbDRjVytLL0NIZnRBQ0hxUzFsNEJkS3ZCWXVCSms1KzVnYk9QZTl6WUNo?=
 =?utf-8?B?OVNRVGxSb0lpRXlTSHU4L1kyMU5DaXVaNFJhVDBzNGxUaHhXUnpTaXVraXdH?=
 =?utf-8?B?VEgxM1RQSUt0dmg3QzNlOCtFWHBTekp5SXVVVFYzMi9RbzQ0bjdyYW1SSXZE?=
 =?utf-8?B?ait6dG44RmlzeE9aZWpTK0JVd2w3UjJXSHFTWXBMZ0xnNGxQUmRxOTFLb1FD?=
 =?utf-8?B?b2dNV3lJWUhjajBvOGg1SkdNa1UyZ1ArYzErZnJGejBKc1kzd2hIN2NTS01a?=
 =?utf-8?B?bE5TUThmUEE1dlJNKzBSRVVRKzNTOUJBL0kxN0FMemtlRW51cVJkYlVXRC9n?=
 =?utf-8?B?T3V6Ti9rV2Vpbll3V0dlTlVmbHdWbUpldnowZS9OMENjRU9LV1JmUXZPQ1lw?=
 =?utf-8?B?dE5yV2t5aWlsYmo5aEJGb2Y3Q08zdU1GUjBkTHlReGNVcXFvVUV0d0FuTWNQ?=
 =?utf-8?B?eGFsVHlEUkJmZmFPUFhmb3VCUGc0ZDZua3MreVQvdjU1cmx6RWo3aExFc2h4?=
 =?utf-8?B?eXl3a2tlMlBMNTF3UWZjeVJqRlB4blh1dGpVQjF1czl6bElZK1VxVmF2Mmt4?=
 =?utf-8?B?eGdQT3A3cVpZcEo4R083bzJEN2laMk9RSC9uMFI0OXBhdEJPdmRsc1VjVldq?=
 =?utf-8?B?T3BJWTZUalJSeEE1SHhaV2NWL0taK3NuVmdxVCs5SWJ0MlNyc1NGb280YkM4?=
 =?utf-8?B?Q2VFaFl1eldDL2ZYMDFEb3hkV0NXaGFCNFp0TStWUmdYWVphcXZVekhPT3NJ?=
 =?utf-8?B?WWdhSWk0aTVGNVlXR3MxclZ0MUFKN2dWZTA0NzBqdWNlNWVVZWx4bitmVE9D?=
 =?utf-8?B?bTBlL0ZlaHk2Y3p6bDRGV3p6RzQrQk5wL1V2K1ZUUFF2RG90NGlSZjdCVDho?=
 =?utf-8?B?d0wwM0lQaUUrMUxoTS9VMTZVcGhTOGp3OWpUTE01anBrUWVScTlidnRMY2d6?=
 =?utf-8?B?aU51QVJDcHF3QlladUxIQUs4NkdMWGJMYkJabTVvZTJ2SE5FMTNWbmtJcnJF?=
 =?utf-8?B?TCsrbkZZUlNtRHVNT1hxVGhQYXV0aU8yZkJEMks4bDRjYndBdWtlUlJtbEEr?=
 =?utf-8?B?TTRnWXh3WTNVcDZLdFN5NE1hSXF3akcwZWF5Y3lvQTliczE5UmZnZ0xua1NV?=
 =?utf-8?B?WlV1WTMyNUZoVWl1RmdCV2tPUUJtK3RYa1A0c2pISFlkbkhCVmpsZ3RXREM2?=
 =?utf-8?B?ZnJsQ2g3TWJMcGdad0p3bC9NMkluWks0czc1N3o5UU9iVktiZXBaOERtcVdy?=
 =?utf-8?B?anhFNmg2cm52Z29NU2RoZHN0bUI4Ym95RHdFWFFHbUFVTFp0RzJlVTRrMGh3?=
 =?utf-8?B?Ri9pR2JsajNMTWt4K1hoNmRvblllN2FuREhqVzdEbmthbWo3QnN6MkN1cEVK?=
 =?utf-8?B?MFhpSGVpS0llOURmTWowNVhjbWlUTnpSZDJSNy94TGFnNmVZbFcxbW1HZXJw?=
 =?utf-8?B?RWlwL25Wa1dMeUFZVGZ2NUhWR0ljREtkVG1LemRsZUJHQm5GWjUyazgvVHk0?=
 =?utf-8?B?TU1ta1lxYkNPWjBzS0pkZ0pBTU40KzlQbzJpdm5ZMWt3d0EyRDlNbEkvZ1h3?=
 =?utf-8?B?ZDU0WGNtd0QzSC90S3pSdmE2U0VTZnl5OG1MVE5lMUpzWm9uTlZMcUhzRVBm?=
 =?utf-8?B?UE5hWnk0MUhZVmwvTTVhcVh2MDdydGZYcjN6ckx4RUkxM1ZjeGxtUT09?=
X-Exchange-RoutingPolicyChecked: yRq4qv7NYVdTa/wwbB9z/rcr8CUrDZg3maWqG+5QhWrU0YLU8Nt6o4ZXLSNVR19e+zXI2/+2FSSoNOXAnv2iWqStlWVSBIBp7wIknBodw+0jcijRF0uwV8TQWt7MqlSdm/xOAJ20WQMLK9GKJaf6bzhCyk+1u5GttQQ3K3IyTnqoJF8MxZ+ad7a0UVN1OsX4NQd9gv1KjfewMrEvhuNbv07FYoqhkof2WNNfI2jECaOsjqUjfjGep+rK89AtHTkdkVnMnuRjDZT7+xF/VfPWuxPS1rH/WC3pixkxYRBPcfuzZfCdrXVWc/EYTbCy0LIQnt5AIXuActOK12KAWc3NtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 143af086-833b-4cd1-d960-08df2e09e18f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 17:53:28.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khpfU6p2oCpM+WMSAJ1Lr6n19ZHPl0TnVtepgPigTwDN/qFLAIVhGHp7a0HTOmYptc+8wHLbVDb12v+HsJEtiNdgeErt9RJuTspuHCdVZ6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4829
X-OriginatorOrg: intel.com

On 10/14/2026 5:19 PM, Chang S. Bae wrote:
> On 10/7/2026 10:59 PM, Guixiong Wei wrote:
>>
>> -void fpstate_free(struct fpu *fpu)
>> +void fpstate_free(struct fpstate *fpstate)
>>   {
>> -    if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
>> -        vfree(fpu->fpstate);
>> +    if (fpstate && fpstate->is_valloc)
>> +        vfree(fpstate);
>>   }
> 
> Shouldn't is_valloc be cleared here, or when fpstate_reset() replaces 
> fpu->fpstate with the embedded fpstate?

No, is_valloc is pat of the vmalloc'ed memory itself.

That said, removing the original check does not seem reassuring either. 
Maybe, another option would be adding an internal helper:

   void __fpstate_reset(struct fpstate *fpstate)
   {
       if (fpstate && fpstate->is_valloc)
           vfree(fpstate);
   }

Then, refactor fpstate_realloc() and replace the vfree() in 
fpstate_free() with it, keeping the fpstate_free() prototype unchanged.

Thanks,
Chang
