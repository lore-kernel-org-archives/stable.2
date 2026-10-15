Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A841F12FB;
	Thu, 15 Oct 2026 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023561; cv=fail; b=Y2qeGY2QZ6CsvqTs9/3MdMhuXHCppe/7d+MyDhySx+ZkWjKh0aSDq3HfWO8wUNnhvzvE1Fn22QIjzV9z5kWGYFbwhzp0X8zdafs9PB61CWGIgVjZvHZ4YXil3zgJkPauDJw/F/64T4sMPYLG8grm0Vks55/VC6mrIT9bGqL+Lwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023561; c=relaxed/simple;
	bh=nF8Q3TwwcXKwKq8toyJ1M1omtQrp+A0qi68n2wIsSpI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzSY1g8z2I6UfYTiKPc7X7p6wieX10tuIhfcEyYWfE1EIy7ayiOQRj5OitAAWmPtXlaoz5H3OPTZLvN8f3ssgU3s2zAfUd8WGoDt5OtbonX7DXxTlPwsu/eTUB8pjV6DrFq3viL4C2BM97iDxPSRz7K3T3Sxj245DBUvbbxVGR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQH89EAX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQH89EAX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792023559; x=1823559559;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nF8Q3TwwcXKwKq8toyJ1M1omtQrp+A0qi68n2wIsSpI=;
  b=GQH89EAXlzs5beuHiY5rjDr7aD+AlkWD5/dj8Sn8deXe7LUBKLClnA+p
   V/BsJzhEzFaKkhyQrDlITqjb2Ju+y+WBGprz46gnkvIza1RHOIqeFhgs+
   1WCT7bMSPF1GN/4Ew8cNMnaXK97HtYjXnAA3H6JA61WYtNzEMV0aFTblX
   Yh9CxoOmI9YB1JXyrTvNrKxqBaO7CRxum+rj1+E2AwaI6veP3wH18csce
   7nwLhHLNi0PrBEuR5kwcyVe+2/ElKc/WnxQ2+20L3nvtwGYFxA9DFChfa
   wsRPFCpc63XRHZxyw4xyLbzmjXMcpnxV6rV9kZ8Q4tmNEX9eCuy8ZPg7t
   w==;
X-CSE-ConnectionGUID: 1J+cr5R/Qi+8C5kwOnjIRg==
X-CSE-MsgGUID: e1vP/vO5RbCXIvoIIA7yww==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="781033"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="781033"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 17:19:19 -0700
X-CSE-ConnectionGUID: ScHkUVDUSe+4y59JUyzNWA==
X-CSE-MsgGUID: NtaZKz8xRuiVxnjsnxxh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1908901"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 17:19:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 17:19:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 17:19:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 17:19:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMlkEap2VQj2kob3OjY1DX1ptGrYVTUUqmkQrORjaOf0KCYkcS/yQgvUB5PmpNucSPUlJVipuuDvX+upNLNwE8ptJO89vlqKcHO/n6ahSVad7FaS+qgbhMDpsMyRiqUer5tj3gpVzX+3T9ZZUEPXsxE+pNbwfDGxEjXswfiTa8zJSfrdcb3fRwOOASizLFAYfpgNsODqzN7BM4jOkFp2USZdoTcHKqgXWOO8sAPFWhkGOyv4UgK8gm2AtuNroIxWJyatVEqjLfbg+ysc67OdC1GBfJSAS/t0Oe3IQTqzLAH9D/XhY//9JYnkLOUk9lS7PrRPF+R8NSDYrKO80juNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3bzHouztiuHvkEC636keKlAobkSC/92oc5CJctwHW8=;
 b=pT2gZrxinhsyWSq3R3fQJ0q0zeYK2rq4AEZGXCi9FE1emTZV3ZfGMxxvWeZcDLTbV4YA4qykbKmd69Z2WG/EJiQaiQjQtvsglkktMY6aDtz6BtVGdebIQJYeEYwwx9iakOurqCaMlwE8g3x5DeSg0gOGFbN0VzZWT2nTHPGKup6+jJkzJyLmstwSZDHOukvQUgbPZV2fgfUYF1kH9QJ008qGP6mTwSe8I9bTl2wpl4XxjEiWPbYHpSqaGu0nbjglTQSaRqDbLQl5hp0fgeJX7PhqnRdZ4XipYqhYh8EKLkzC14bMajwvTnZ6zx37XCXDINTdniD2zCY7knQ2vU+00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS0PPF0A1E7F360.namprd11.prod.outlook.com (2603:10b6:f:fc02::504) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 00:19:15 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0496.015; Thu, 15 Oct 2026
 00:19:14 +0000
Message-ID: <d28dc497-a74b-4c52-bb6c-8b9010f9ee2d@intel.com>
Date: Wed, 14 Oct 2026 17:19:12 -0700
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
Content-Language: en-US
In-Reply-To: <b9277cad5e1098d3e60d5c0f025c58061df10af0.1791428412.git.weiguixiong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS0PPF0A1E7F360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb71c42-1b60-4d7f-434f-08df2a51f174
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|4143699003|5023799004|18002099003|56012099006|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: vGJ8GXbWHgtiLIh7S98+Hx+WrCG6+lk85fWYvKe2nVnREiYQin1UvGZO5QSKg1dPrsI2zr/zXDsB1Uhws9NhIJuLybWzbP3PGmZKyxOmXOZ2CiUIYPguc9nGGYqHW1v0v4bX9TWQu7+q7rbnQwJDFxhYeZPT4GmrHVNZzejILey5bbxJ8hJiHytvDVTZL3Z0VSmrXY9wEoMIxXCxRsrqwavRlamIr4HvtnIADdPokv2teVuf5qJSOsmuEtE5VsmTOVPJTR4YJiWbolWwQu2kGqu/OrWiaKWsyLtHRDAvBycCay5vzfuRfze9ob2Dw/1dc7anfnrUXTOFM1o8GNAtxc8A4WcjSIss6R1N722b+tFtQrMwZEyb3rPsUa4RAtOwcHuXoS47Nq0HnQRUvpeAcURa/kOG/dVXcP32ohjH70UQoJGDV2VBSZ4ovvxP0v5DoSQrj5tgP0+r8gnfKiTR2zPW8yvn7z2Pm9MOrCfm0koYW1df3/Hq/1K72mWlyCHMvDSesBGpp/aUP4KAFrvTzEQBWME3yQNXO+BtV71/t5YGjIUVBk0ocNGnQXFSJ9RkN9OpDTyiWJGNCKqSyh9/2NPFiHo0DngZr93VBBjFNn7hEp3ziE/+KCv+TKyciLDcInYdGFO6oXckPWRofU1ZbVsV9atSRJj2nnZZ+Yk6IxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(4143699003)(5023799004)(18002099003)(56012099006)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFpTFhjdHFIOWd2UVI0SHRvUGcvZjhJL0RkS0F5OGsxd1VCZ1QrUDVnMi9t?=
 =?utf-8?B?N3Q0ZVdzRUVLeDQ3eGpPamQ5VHYrR3QxWmozbUFadERudnlaelY3NEZyNE9W?=
 =?utf-8?B?MndEWmQvMFpnRWJ3QU5WZHZQUkZ3N0hGRWw5YXlFQlc4c09TSWs1N1haaXBi?=
 =?utf-8?B?VG91QnptR08wRnFoeVY1dEl0b3l3KzJxVUJNcE1SRmhlcEdCUkNCTEVpU3Ra?=
 =?utf-8?B?amV2aGwxbU9tQnA2dFZPeHZmdkwxdGFMUFJJUUhRSW9NejRLeEVKUGlEQnR2?=
 =?utf-8?B?RFczRnRpZmpEN2JoL1BiTkxvd1QwUTM2NDdLVmtvUjFwSERSOGRxcE5EOVNO?=
 =?utf-8?B?WE16MVVreDJPNkVLelJtVmpoTzlxbHR0QnlVemFoakQzWTZjUjdkMHNlQWtJ?=
 =?utf-8?B?RUpGL2hJQTZiZVdvUnAxOTJnMXlKMFRENjI3N0dDd3QwbVVzMmpjK2gycmND?=
 =?utf-8?B?OFRyN3ZsVkJ0SjNGOFJQWlR3US9yNEVRNFRoRERxUTE3OUE0WW9PdU9Zb2lT?=
 =?utf-8?B?YS9CQkh3Sk1yTlNpSVJiRDVkR0dMa3F5NlBJemFCNzdIOTZyUzRKYXBnb2xt?=
 =?utf-8?B?dDNJMzhQNU5lTXJ6cTNCRzZSSE1UN0R0MnRDWXpDR2JLSk1OMzJBekNsZ1Nm?=
 =?utf-8?B?aW1nNy9memRDcHoxYWpTQWJoU3EyMkFNQUN4NWZ2aGlGVy9GanpqaG4vb2hk?=
 =?utf-8?B?UXhPVTNlN0ZEWlU1Rmg0bUhhT3dMNDFiNFNmWWhBbzAwS0xtZzMxemNIbS9i?=
 =?utf-8?B?WTI3NmlYYVVWbnk2KzFZZXpXaldzU24xRDRNR2wwOXhaY2xqV092TGhDQ05t?=
 =?utf-8?B?anBPWldYN1RBQ2hrZzQrNEthczF3Ui9CbkJxUFNlSm9ZdnJrbkEyeVFuS2NB?=
 =?utf-8?B?Wks1T2lRV1RTb0g3VXFqaUpiL3NVV3M0RWxHMzZpTHg3UEpSUS9rbFRtTzRG?=
 =?utf-8?B?WTd0dHEzK1RIaHBrV2Q4TEtPZE0ySjM3N1MxMUJCckkwVUcvaTFIc2dGUTV5?=
 =?utf-8?B?ZXVPQkNPcEZKcVJLR29ZcGZOS3ZhMmFaSG10YzExeHV4VGpHRUEvZVJrUVhV?=
 =?utf-8?B?WGNlem5GbWxHMFVDRy9TMWJhc0ltRmtIaTdqTVdtWkg2VE1MWHNvZlUwMlZF?=
 =?utf-8?B?UGxDMnFyMUxXZWZSMW1kQi8wYzhDK0lndktKYnZiUlA1Sm5LV3h5OXJ0U0M4?=
 =?utf-8?B?Y0lNWkdkcER0RzhJNEc1YitZc2ErbEtwdUU3K1lzN2NQVFd6bURiSjNIeXFn?=
 =?utf-8?B?TE9QYVpFaWEyOHFEdVJpWkVSLzZaSzkwT1JZbHNvWnduRzdVZ3dBNk84ZmZF?=
 =?utf-8?B?dHhpNFhJdElzOHZWbTdkVFpzLzZlSlVGczFwODBkOU5lbThSY0FBWEFhYkFK?=
 =?utf-8?B?LzM1QzBOeC9aYWRXS3M0TDdwUkVPOTd2azRPRmRjMEFqcGRQWFNYbWYzdFl2?=
 =?utf-8?B?ZGszRGl1S3N1T0dhc1l1alZkUnczTFNVa3ZiMm5oeWd3RUhsK3B5b2RyMW8y?=
 =?utf-8?B?cHFrMUQrRkxlNjdqZXMxejJEam04ekZ2alNZZEljdFdvbCtPOHBmLzFLSUh2?=
 =?utf-8?B?cWxoVEljSFJWQU5ybUlLRFYyZnV0VFkrYUh1YmFhVW1WZDdQV3Fyci9SUllC?=
 =?utf-8?B?YjFGQ2NNWllkS3Q0M1ZVeFdTeEpucUtzNW9PUzl1SXBwemhjNlhmZkpqTVlm?=
 =?utf-8?B?MGxvUGNtZXlqZEh2aW5KR1RRZ1BhVHNHQWZCaGV1SmZMZ0VFKy8yck5YcDVL?=
 =?utf-8?B?RUpzZ2dpM29xbE5ZTkwxci9uMFpNUHJZUTNmTSt6OTF3OEJEYWJURVBXU1N2?=
 =?utf-8?B?RzFZRjA2T3l0UmI0MmdSM24vTzFZLzQ1eGowREplaFZ3eUwyTjAreitVclVF?=
 =?utf-8?B?S2hwMUNDMFpHejhOVFZhR1hlMGZEaEdUZ2dFTTU5Y2IxU1Jqdzk1aFB5cjNj?=
 =?utf-8?B?bno5ZldUMEZvb0oxWHJUVFNYQklYUEwycDkzWTR6SkxlTHlXei9Nak1CUDEz?=
 =?utf-8?B?RndYc3ozWm1maUtCcDB2WGtlNjJIRnVvT3ErdkdqMUVwNlpTTEt3eWFLb0ZX?=
 =?utf-8?B?QnFIVi9oNjZBdDVabUJGc1ZnRWFYa2NySzl5WUxIMi9YeS9wMkZTV2Z3NXBX?=
 =?utf-8?B?NGxraTBMVENaV2FiS1JKTDVyVnovV0k4NkRQTDA1QUVGRWNINXhhQ2xOSGdU?=
 =?utf-8?B?c0VCSTN0QzFyRmhvaXJGdGI3RHBaWitKTXowWHBpbXlqZ3Eyd0tUNlNvQXhF?=
 =?utf-8?B?WThTZnNXWHFaREJoU20vbS9TUmlJMHRWbnBaYkVRd1F2WHh5ZGl0WFFDeCs4?=
 =?utf-8?B?alZtS2FMV1JpWWpHcXRvSGtSdll5MGxsZndKRWxORnUvU3ByZkxGUT09?=
X-Exchange-RoutingPolicyChecked: nA1BnBEyG3FbTF3gPIDI5893ZtfyWtMhMWaF/GHFg811h8fTFT7bSj12azoKELXXuI6mZ/cJtMnoLgcOvJF7ONHS8Mz4J4vAHdx224LdiV+4nr9aIW02qKsVN2Q1nPiyzrGvyq1jpDrEKwc9cnR3R1Cbf/Pyte+Kn0RAYAM6SdWcuT1FHygNLW25VwBLLuaYb2zORWH0Xeg0km4X1NkfA4fkBBxTHCvODRoeS0u/NkdQfK3/uZEqfenNnOsNxp7IoPc38Yvw2m0B+S/CYBnKPXdb5a908/dH1L/rofX5nLgFVICeErQB0EDVk4jMeIiZ4a9UuRBV1B81hac7XB3iVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb71c42-1b60-4d7f-434f-08df2a51f174
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 00:19:14.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd6z1VlM1qjJKub8NopI/ADh2cWmhXGIHrw5Uk7Wjxp87DpskuKXGf73LvKUY9E4vgMRJce67BBJNQetNH6fv/J0HDTdH3OmKnEjpq+jeHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PPF0A1E7F360
X-OriginatorOrg: intel.com

On 10/7/2026 10:59 PM, Guixiong Wei wrote:
> The fpstate embedded in struct fpu only accommodates the default
> xfeatures. After a task obtains permission for an XFD-controlled
> xfeature, its first use raises #NM. The handler calls
> __xfd_enable_feature(), which uses fpstate_realloc() to install a larger
> fpstate allocated with vzalloc().
> 
> On exec(), fpu_flush_thread() calls fpstate_reset(), which overwrites
> fpu->fpstate with the embedded fpstate. This leaks the dynamic
> allocation because arch_release_task_struct() cannot free it when the
> task exits.

Hmm, I'd start with Dave's wording here, or tweak it slightly.

> Make fpstate_reset() own the complete lifetime transition. Preserve the
> old pointer, install and initialize the embedded fpstate, and then free
> the old allocation. This detaches the allocation from fpu->fpstate
> before freeing it and makes future reset callers release dynamic state
> automatically.

I'm not sure what the intended argument is here. Does this mean the old 
allocation cannot or should not be freed at the beginning of 
fpstate_reset()? If so, please explain functional issues. Otherwise, I'd 
simply follow Dave earlier suggestion.

> On an AMX-capable KVM guest, 1000 iterations left 1000 dynamic fpstate
> allocations on an unfixed kernel and none with this change.

Since the selftest can reproduce the issue without KVM, I'm not sure why
the KVM guest is relevant here. In any case, the entire sentence could 
be dropped if the problem description is clear enough.

>   
>   void fpstate_reset(struct fpu *fpu)
>   {
> +	struct fpstate *oldfpstate = fpu->fpstate;
> +

Hmm, again, why not just call fpstate_free(fpu->fpstate) here?

I see Dave also noted this comment along the lines:
	/* Free dynamic fpstate (if any) before resetting pointer: */

>   	/* Set the fpstate pointer to the default fpstate */
>   	fpu->fpstate = &fpu->__fpstate;
>   	__fpstate_reset(fpu->fpstate);
> @@ -610,6 +612,8 @@ void fpstate_reset(struct fpu *fpu)
>   	 * guest FPUs, which allows for common guest and userspace ABI.
>   	 */
>   	fpu->guest_perm.__user_state_size = fpu_user_cfg.default_size;
> +
> +	fpstate_free(oldfpstate);
>   }


> @@ -670,6 +674,7 @@ int fpu_clone(struct task_struct *dst, u64 clone_flags, bool minimal,
>   	/* The new task's FPU state cannot be valid in the hardware. */
>   	dst_fpu->last_cpu = -1;
>   
> +	dst_fpu->fpstate = NULL;
>   	fpstate_reset(dst_fpu);

Dave also suggested adding a comment here:

         /* Break the link to the other FPU's fpstate:  */
         dst_fpu->fpstate = NULL;

>   
>   	if (!cpu_feature_enabled(X86_FEATURE_FPU))
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea2..ea3736a74fd43 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1556,10 +1556,10 @@ static int __init xfd_update_static_branch(void)
>   }
>   arch_initcall(xfd_update_static_branch)
>   
> -void fpstate_free(struct fpu *fpu)
> +void fpstate_free(struct fpstate *fpstate)
>   {
> -	if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
> -		vfree(fpu->fpstate);
> +	if (fpstate && fpstate->is_valloc)
> +		vfree(fpstate);
>   }

Shouldn't is_valloc be cleared here, or when fpstate_reset() replaces 
fpu->fpstate with the embedded fpstate?

Thanks,
Chang

