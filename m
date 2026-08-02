Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE09212564;
	Sun,  2 Aug 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785628844; cv=fail; b=LRfMsnnZ6+XHhxgFE/4BTNoMRdWpoKPiZWO6+sKJpNNLFtTBssi5XofAlGv0zzmK6oRusyQPE3Wep6PWHH0yY7MNhL2xSI23x9vQ0Efv/p1D5zSDMlVCKJqfCU6EsapwVjZbIzq1rcVpQaZQz1JpM0nN89skvXU50ZhV/944q9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785628844; c=relaxed/simple;
	bh=jYcJ2PF0TV2H9KfGLS30gRST8jVdZjj9IR/3dVLDs9w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtvT6HlnVXgt8Y0J5rG6fDg0N9fDlHcHDC1CRQqz+Ywao9+AGU+xnPiBl54lsagMqsZCmpgNGoFgyWMSJ4QwP4kArLOzIwZx3sz+XhZBxZupiEnIrlUblf1XLm4i1OaEpodvPD7nlIBFfik1oyZoyB5aOAEcrFQiMsbfclOrdwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boLFDpQU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boLFDpQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785628842; x=1817164842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jYcJ2PF0TV2H9KfGLS30gRST8jVdZjj9IR/3dVLDs9w=;
  b=boLFDpQUf3xmWWZYGxhbVceVNoEFibaZkbNBEY0zJny2tckOEdbbbX1W
   h4XJxFV9/mPhmOFW2qiZwxpWqjOtV96tP/mRkEuOm6y3M/7ohVFjQBvdB
   CF15qmXLKyMY5xCCUeaa8kqmqng1VeDdZMMJBJ4RmuGtiFtXKi/NBjbj+
   G/5CX5bO3PJ9QQVsFCS4ZQj+bTcwezitL2khnTkqi5U90vK9QrMCrS+N4
   AWZjUiXlBcF0NXFbaPRLqx1j4Gm8SEPiSE+pPyu3RCBy9tkExVocOlbkX
   IKlysUnP+lu8Rija/5mdKgknGEK9g5k7D6kR7MTtio7A+obt4vY93LCdJ
   A==;
X-CSE-ConnectionGUID: LqlRJAz6R1iNZqMCCAUygg==
X-CSE-MsgGUID: zkwoXLdYSBG5F2ZJUKZFdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11862"; a="88746007"
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="88746007"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 17:00:41 -0700
X-CSE-ConnectionGUID: AFSog1paS+qyzxVViBYc4A==
X-CSE-MsgGUID: f44WkSjVR8WS752ozzuX/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,199,1779174000"; 
   d="scan'208";a="290817745"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2026 17:00:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 17:00:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sat, 1 Aug 2026 17:00:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 1 Aug 2026 17:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6RUl+6M6r+zEk3fzqyhOFYwunFfGYZ9Ua9cQxkms91yiajt3fGgXSZsx0XcnmeXYygLRAJ37D8jo486Il7wec9GCrEIWQy3JxnohKW8tkRR3tlqTXx/K4NdZBYVedTbnVxsE+z+9kJkPMQkkSE8N6CNLsmBo0p52GwCTkuGWa/r6kIk+hcolvcptDl0uT/+n2IgtMmF8JhI4JVLnRXRWIQngpE3kZM76DV5P2UvXmmcOlu3ZY2tcoqWKzBvHn0Zt12NMTJRhyUmEHilqlBshH3zK2HET/x5y2AQXT5bSIqaMsEht6V/777cMc2SEAYtlrPAaPdV9sjZEJ5Xv8rOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TszfFeI3BRIytrkiGYwxqfVSLcyn4myflCJhKx7oGAc=;
 b=avvY4CSzPlId9IdndINOKFcnS4mV8pAJ6FHaiaBasfmpQ2sMpL+AilexRt7n+RSxHCpJ9o7osaNh/Qz7zkNH6R4vqKthDtDmEvPaSZj0Bv3fVB/U5mHF5WOPjoWmIzxr16VvtxCgtLFO6BWlv8sYNTgQhBq2LvIZ6+ON/A3QXk69eK1Im59TiNjlHlvksl+vGyNcM2HbWwC9+EEAyRkk7bGMvfLpZL4pUZH7KJCmZ+5msFEo3FHev9bgJECkOdXNtbmTsnM6FrADUHIP83XAuPH227OwPHTZUPFXSc+45A3/MvD/c49eqDYGnjlElgYUTVQyWbUQLA1JkO2yVTqPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 CYYPR11MB8408.namprd11.prod.outlook.com (2603:10b6:930:b9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Sun, 2 Aug 2026 00:00:38 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 00:00:38 +0000
Message-ID: <2ea83400-a49e-4015-a0bd-926e5a0ef073@intel.com>
Date: Sat, 1 Aug 2026 17:00:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
To: David Laight <david.laight.linux@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, Omar Avelar <omar.avelar@intel.com>,
	<stable@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
 <20260801124429.45d03af7@pumpkin>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260801124429.45d03af7@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|CYYPR11MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 964e4e51-eb68-4fe0-50c2-08def02915a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|56012099006|11063799006|4143699003|6133799003|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8xfcr9xW6gDRKvpiQZJaiMWVon1bHPyq2N4q66M8xRIQxjyI/LwL9lo7atTR8YPcJtaZSl0UB2duk/CupOf+fh/SAH942dcu4eT+MYoVp51bqsubA8zC9elABC8uaDQFePgrnmGBZ4a/xsZESFrZz24rw+uX9VXkVUEV/nui++Wm+9YOzK9dQe3b6zFaofFcK8SqXSJLl/EIpvCkwJ86mRrGcr15M3iPz4DvAILLbc9fyELZVc8V1zQUlc0cyJd4nFNK0VJv5w6ORpOJT4hzvd8AQORap2kVOoDMiNIk1nIfrwUxmU+8P5k5Y2Wgsbg2Thux/XEPbfjzQTfu5LSomABQgFXncrX6qm3tJtfpjNqYKgU/vW4iqHBFpwHYYppBoMKx8DzpCX5GJMnzXrlDpQ/hBXo4aMT+Nu6m5/7Ht3uowgrwhqqsu9wNQJsEXza143sJPPjVgsUNt3VXTgrxMBz7c3ZOx9ozOHyozXo6lIbd70uDY+/UwewSoQnjBfbP/UH+TVWHSiNMx9sECktbg66Xj+M2v4D2xDzVgaSY1kp8gixc/85Iqt5/NOTNBIaZ2RJctrcFC5ldhUl0m1ZCrlb2XKbCys3sa4zz0hqn/gefkEQh1HmRWlDUlnopiu/KitknS7El2g48ZA15cC+HocTG08lCoalclP0Ktr9WAxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJXUkp2VEtWSWszVHU1N1hBaFpLc3pwSWRlMFRSTTFaeUlYNlFYelFQbkx6?=
 =?utf-8?B?aVZjdEFkdjdiUDBxdENNZmovRnNNK29BZjNqdDlVQ0tBZjdCSjQzWmtnazZO?=
 =?utf-8?B?Y2NGa0FzUERjSnZwMHFWUjVMQ05ERytnOGUrTXBWNVRMUzIyMjVFRDd2RTU4?=
 =?utf-8?B?NzN0ejlXcGRFZ1BmMTFjTzNOemllUzVHYU5QWjdMVTkwMkhSVnZBQjVVTmFK?=
 =?utf-8?B?cUp5aE80Rk4rSmdkVXFETDdQenFJY2hkdXdWN0QvNFExUlNNZmphTzVoMUJY?=
 =?utf-8?B?TVBPZ2Y1Zjl0TWFKbmM1V0w1eUYxQjFnaDFxVUZiblFMNU13UlhKaDkzcnp6?=
 =?utf-8?B?RVV0RGR6MWhCdHphU09GeHRhamw1RGNRYnlyRkdHd1Z2SnlhbkZtakZ4Q3F1?=
 =?utf-8?B?NXJpUmtLK3J6VW8vTTBWRE9DQUNzYUNiNWxTaWxyWXBXVGZKbXFoNzdxTVll?=
 =?utf-8?B?dkR6bU5xMEZRZFhOUnVwM2lXVWRLTTRISWRqTDhYcWlxNUVjSGZ5dmFBOFd5?=
 =?utf-8?B?bmYxeFZVR3BIaFNHemUzQi9aZDNIN3VsNDR5Ym1vWldqejE3c2hERkQ3cjhI?=
 =?utf-8?B?bWp6ZWFqRk9FaUlSaTdaU2ZCRDZrVjMzZ0JVRUk5cGxibFhld2lLZ3ozRUpq?=
 =?utf-8?B?TytaeXNpVXNQcitrVnAvQWJ0Wmd6NlZhZURpUUdmaEVEZmNXNVp1Ri9wQnRP?=
 =?utf-8?B?aU93MnkzWEVRZjd3VXNGQlZBQTJkMUd4U09USHNMaTh1L3oxKy9tNjU2Q3N5?=
 =?utf-8?B?bnZIVCs4NVhGbWMwU3VWL1NnT3dkRW9xeWpFVVdPSkJuOUVQU0o1WW5nRjd1?=
 =?utf-8?B?aEhoUHFmU2dIZ0grOE0xcmtpQkZMcnNhZisrWGJla2dhRHFkU2ZsYXI0YkVX?=
 =?utf-8?B?R0F0ZkFIUmtUMnl2RXpVQ3AzWVVtMjZ3Y0VwMzJ6NndXSUU3eWdNYkVoRUpW?=
 =?utf-8?B?OFo5UytYUnd6cllHdzJBNUhKRmRDMkNMSmpFN2RZRWdzNCtRZW14S01YdFhk?=
 =?utf-8?B?NWo4MmNRRlc5MC9YdzdFYzZWYVBKci8xaUNYbU83NW5qT0x4T1I4MG51RXRs?=
 =?utf-8?B?M0lydk02elVzUU5iS3V5RnI5bXdWK0VGek5odUhHK1pVbEozMnpwZk5YNVJO?=
 =?utf-8?B?eGNMRnYzb0NqUjVFdGVPTlJaL0Y0bE1xRnZpYWN3OHc5RjZhbkg5Z2M0bVJC?=
 =?utf-8?B?WkxsSEc0UnZKLzlQblNOUkxpVlY3RFhtMHc5OFppSGNiQ2xBdFNVZVdObnBL?=
 =?utf-8?B?aXJHR2N0Skl4aElLNVhEV2ZrZll2VmM2UWJKSGtTMkY4Wkc3YVdMTG5hb0Z4?=
 =?utf-8?B?OVliMGQvMVRoL01CblRnTGk3SGZZaVRYcEYwQmgvckY5WUtFYkRrM1Z2ei9j?=
 =?utf-8?B?Q29rVldLMHJ3ZHZHa2ZXc3ZTRHN3TDV1cm03Y3RmUXBnSTJ4L1p1Y1piaDRq?=
 =?utf-8?B?U2JVNDZzZUlzWlFqOThnQktVU1h4YkdOdjBkU2xRSW1WbFBERExEZGVpcnBq?=
 =?utf-8?B?bC9QYVFYYWlNa3RBd1cwT2pSeVJSd0gybGxlaWhWU1owSjhnSFY5ZlhSZnVu?=
 =?utf-8?B?aDRVRWYxaG1XKzZDRGlNa0VyZjJET3FaZE9jSkl3eG5nc0pZRFNDenptdER1?=
 =?utf-8?B?eEdxb0ViODhCUlFrS0E1MmFFT2lOQjh1dmwvVHU2OGt0N1VWcWQ5Q3BtSFk1?=
 =?utf-8?B?N1NGTno3VStFTkNiYVJWc2h0SDB1cGhXNFFIUzl3QytSQWcxV1hkUWx6TUo1?=
 =?utf-8?B?V0wxRmJMTklxcExXa2xPdVVCVDZXdXl5SzYrRWhESUwzVit1YmdhK3dPMEFH?=
 =?utf-8?B?dWgwbUJ0ckZsUXNSNjlGRzdCMEM1SFpCcnZZTC93QmtCME1MSkw4TkdXVjgz?=
 =?utf-8?B?ekF2WHFhRHM0SUJzZG53KzQwM2dlWENLY05hZUJ3bFREenVGaUNObU5YTy9x?=
 =?utf-8?B?UjEvcXNrYXN5bGpkbGNXOWFxT3RkMlpqcDZlSjhZQ0V1ZzhxOU16OXBaWC9N?=
 =?utf-8?B?d2s1TVVRU2JyTi8vaFlMdW0ySnZTQlRzVWtJYVF5MjgzRTh2dDZSa2FGT1lx?=
 =?utf-8?B?aHRoK1hGTlRKMldzeDBXaTU2c2xWMHNVRWhqOTZ3UU5kWVhvbFlaSUNWdExI?=
 =?utf-8?B?ZTl2T3FvK3NjZXVFQW55dUd6T2F0YnBPd0JCSksvR1RPT1JmWVV3VVlWa3BG?=
 =?utf-8?B?dlVPUnFWQ2JCelhYL0FpNmlId2JPS3RRQlVFN3ZJTkhjcC9pUEFXbEtqZDc1?=
 =?utf-8?B?RWo4WGdYUXlSWXUyZE5OZ2J2M1JlT0FTL2Eyb0tSQlpNYTZrOXdOYW00T2th?=
 =?utf-8?B?dDJsNEFoaHE5QTVwT3lCMjNLRGN6SHd5MGRwREk5eE10cnZvVUJNQT09?=
X-Exchange-RoutingPolicyChecked: VuYVJyfDpCE5pj5ib9YT3sFjP7RGI6cAQuoRtYtDVbGMnCwLnBqFBxX+M+5KvoJhTUgEyPRptuupxOjqFqWhAf1MX6LviAUq57Z0tWHPfmIj6vAzHlu3CPKL5wpUu6LbuFgwtncIcrRQHd2bpFO86p+gq434Nq1Rf3jnWS6VDWqysXoAjY1L1tl3z6Yu7cNrG+ck+g7aLa6A1x3I7RnQfgTHUNtpiCoiBEyVOSXUqiL5YSzkRrpw9B3AyBkvsFmc+UOTRcjFypJcV536ivDgl0qfS39bvEPIvpViVGi9oAi2gdTWjpQiKyH1/PRnZEQMhfUbS7zYiefU8ZkxKtuXqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e4e51-eb68-4fe0-50c2-08def02915a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 00:00:38.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frKl4R+FH5j2q20rDVuI6mIOS5XmT1RoMXfW8ISpmpSqUbUcDEGivkqzXJEuKJ25g3nBFRBAfsUSjPnhx4mIr8aIQ6M6OE/UbJM9BI5XYt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8408
X-OriginatorOrg: intel.com

On 8/1/2026 4:44 AM, David Laight wrote:
> 
> Much like when AVX support was added, -march-native needs to check that the
> operating system is saving the registers not that the cpu supports them.

This GCC bug looks relevant:

   "__builtin_cpu_supports avx does not verify OS supports it"
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85100

The resulting commit 059cc8aca774 ("i386: Enable AVX/AVX512 features 
only if supported by OSXSAVE") switched the compiler to read XCR0 before 
set_feature().

Similarly, the APX enablement commit e686416b6217 ("[APX_EGPR] Initial 
support for APX_F") extends the XCR0 check to determine whether APX is 
usable. So, the compiler seemingly won't emit APX instructions without 
OS setting XCR0.APX.

Thanks,
Chang
