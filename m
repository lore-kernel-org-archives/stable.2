Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B539792B;
	Mon, 24 Aug 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557447; cv=fail; b=GxSa7jA3dkye1tSsvL8NUHZ3UzdqTYw0+QLqvvFz5ym9NHq1BsAqLVgrDM20ZR4P8g6ZgvZROp1erUbpN+EEzGoXCezLy/5xBHpUiAcZ1A3oZQTq6+ThQ9bT7sYDbA2w3NhGbrXlI735rjZxIu95rC/oo3JPo0xXNCaqNTakTmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557447; c=relaxed/simple;
	bh=VkhZ+K24Fmx8FVjboiBVmeBhzzruZolSYvk8W++/VHE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DctIdshvsv5bTR77o7lUrCLYMTsh6jdJUPZwr5m+MIAfmmvfQ7zgLRZvUqyPbKv4+DpHFCwskwQJOMYC4NppcXxosTmT7Kqx5XdgC6z6366hHtvuYAg0l8j/1QaCdw5uPDE7kr5zpMhFVRMVBz5M2pNo7UqEmoCvBFxQNdwahuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTU4ecSj; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTU4ecSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787557446; x=1819093446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VkhZ+K24Fmx8FVjboiBVmeBhzzruZolSYvk8W++/VHE=;
  b=FTU4ecSj5I80vaDd7uJA4qMPPGIMw2Nk34i9SDDVmvTrxHGTsROzMwh1
   eI5xJuPiDt2yfMO0qqHioj8FWa1hdn2205p0dsFQb4wR0K6nbDEGkxpXr
   MSnIRbaeFKul14BCfXMyvwbyYvBkRHaci0laDnlAdqu3U59lhNd6Ph+AO
   Uhxe9tlM2vRuOXo6les2oGZVi9kl/V5ySNAEZBDgu+7Y48C1N5JFR31oM
   C8NuBjIllDS/W4qLuc0TrrhzBK110raSlvjJdK30ejcT+sTuMIR3RzOD6
   Swvlrje/1sHLZUl2/dwNDVTJb3RQzzpbhMA65k2KfWNE+2Ix6SGzRSmQw
   g==;
X-CSE-ConnectionGUID: 1jvk7jKwTSaD0+JF7yr31g==
X-CSE-MsgGUID: xNgZX+aUT/aLrTlmjMhzPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91813158"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91813158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:41:21 -0700
X-CSE-ConnectionGUID: 96lyu/6LSRm8FSqVtfV1vg==
X-CSE-MsgGUID: nB7N1AvySK+/Hfsg8XgLqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="296833316"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:41:09 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:41:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 00:41:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1D34n/Y8oeK5CW5CBhtGq1s0ZTod0b20OQPBzXaaXyN36VssWP76IiSXPPHoq9+vgAvzH4HVuCwFFiS262hwPjRt0q50cZ0CCQbeY+6iGbgty6eiHyrJzvSBU6foaDhOG+RY3bdgYRDkEBDrDmn4lpnIa9BEZc7HjkQe5gPxS/ZeoxOFjnPDV7Wl0luLuDwPctLWV+u0dVvaTW+gvk/dTYXCUe0b3KBavthHdg73xC5iqQpGoETHm3iDaSEqLf5Ub9J2RrtXxf4YAt/ogA75p7P4sCkBRWCnHgVAgkOKlTeHvKolHrDlb8PkFZFHMLnLhWCIen4QUcxkNxrfUgyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ekH8jiQgvHH2u/uu2C0IoOijgKRTeWEVGwBBKI/8so=;
 b=sq1bOjio2DRKgbNTkUVmmz2VDEDA/sGhOzLrHrxADDtz35QpYf2jfMzluM1oKEHHL59um+WbZr1947a1gT17zxbfaa6P8X8ojWQO8faoIeWA1sghEbAbJhzqNea29w/6bbhIdUX6GrgVWbnx9sRw8imwInaIZCsOhwPTJ6v9avU0x5o1YN+U2d/CzUTWu67cFtvzfJGoRW0FCWQjk/UDbU/oSEoNEJW36Alje/ypPvIRGmPwvKKgE1buq/ZGe7adBR32miHBYu/PTr47YoA8waBUP9c7CEaYbKbmzwg1UR1TpajrQ07rBn6elCxoAAmOW5jvx3qNN+hbJWD1XjfVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 24 Aug
 2026 05:55:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 05:55:58 +0000
Message-ID: <61dff746-7b62-404b-89b2-3c9d73419d71@intel.com>
Date: Mon, 24 Aug 2026 08:55:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf powerpc-vpadtl: Fix off-by-one in auxtrace_info
 minimum size check
To: Wang Yan <wangyan01@kylinos.cn>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>,
	<atrajeev@linux.ibm.com>, <tanze@kylinos.cn>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260824025553.363863-1-wangyan01@kylinos.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260824025553.363863-1-wangyan01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0024.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd5d2e3-d8c7-4c03-6e18-08df01a45e50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GugH8IvhO7yX7JlMalDtf9pdlQO56skttClYxbTfnFVDCY59QoAXGTelM7vJR4p5iz4SSmoIdtvTi1L2x29jqIYqrhqnd6hfvdEShGRxFHUCn7rPncGUM8Jo0Xw8LkAkYY1RfGLNxdjb2dZFHctC9vF+Pm8iIJEdXtUUydsKBVZzYq2AFe8N+zyHV6RiOnMJ52kiuUlmWEqITm3n83Q4u7UoaDUPhXxd5P8FTeyylaCgtYSk/PsOnbA6oZ05fLQriy3dUEAEfaTwgbwV/Y1hqz+/Fq1Or/8uiX37dw/wEMplH6TH4mD8rPQ9KQRdqTCceQ6tmUfgwXNCvNL1s3wurB5vC5Cgp7nVvkijPrhuDGXXhJKxxC2APP8deADPt3xJF9yvI6ZY22TQjWdEYR0/ZZmNCojcC4vSlPBf/G4PNpvAkuaiHvGJ0rpUBEU4HVORO+ET1PKEC2VPiz1KRCi1jn/ituklkQM+VWz/Mg1cxdGtgt+LQcaCaNI8RwVvKhhMXvIjPTB30JX2eiAidkDU1S90xs/5egTFWnYnT5Kn+tdZJpcOddpXZ4/RLygCUmkuVLT+lLxhiw+gQoZNCVRdylCCfhcNTHuI71lZxlR1eVo/ye9kWbOXOR9LrnkNejB1XvQKZlGuofNw48y5FPbWMa4+61006NKMPYfzgL2Lgvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlXcHJ0NFd6TE8waGxuYlFHdzZwdmxHTHlNMzhabythNVc1U1ErM05mYWlC?=
 =?utf-8?B?eHZ1OGlEWlJmK1VZYXJ3ODFmblRTRDVvcm4vbzgwR1dXcVlNcVRZT2d3eE40?=
 =?utf-8?B?YXExT1l0Wkx3WUtlWVlwalFGN3RabUJPVUlabUY4SGpyMHRwaklqOG8yT0Ns?=
 =?utf-8?B?QkRYdkZkVGpvMjdvZm9Ca3N6akgzbW1Jci9uKzhvakRjb0cxMDlUTlFWR1d0?=
 =?utf-8?B?WENYOWJ4S3RGTlozQ3hKdHFXYjRYTDdjMWxkMzQ3SjlKaVNlUEMzNHV3bEdn?=
 =?utf-8?B?UEU0b0ZiVktKaTZ0ekNGQjI3ekloRS8vY3ViU1h4cmR5L0dkbE9IdEhmZU5l?=
 =?utf-8?B?MlZuSy9qQXh4SnBkRnpXR3NUNG0zb0lUUEFsUk9aTTVWdnhYckdSRGpLeHFo?=
 =?utf-8?B?b0lER2pZRWZnUGRhcExLR0hCYVp4WDZMaFl1QTRwS3ZZT3pZbnhYV0NPMDc0?=
 =?utf-8?B?RjIvdWdTbHFSUkdRRTE2TFdlVml6dzhBZlNvNGxIRUttYkVZMTZ2TzNqdkZH?=
 =?utf-8?B?WmdTdHhxNkEybklIMVV5WkR0bUExemxmcmRYQlpMRG52a2JqRU5VZkFlRXRl?=
 =?utf-8?B?cmN0UlhDZEJFU291TVZoTmVWMDdsbW81bGlXRE9ZV0JtVXJ6bGpBVlVMM1ds?=
 =?utf-8?B?MnhydU5HREE1aldnMkQ2VHlsTjVwUG52MlhBSzMrcjZMaXJHWUlNc3RtRGhX?=
 =?utf-8?B?dFRpN0s4QkJjTXNMODRtN2VrcUwwdW9Ld0ZVS3IyQjVVUHNOUDVDdGJKRzk3?=
 =?utf-8?B?aS92emxpbFRSUlNNRzRseTFKQWRCUldXaG1zVTkxNkFmaEJJeVlDbzRMWWxy?=
 =?utf-8?B?QXVsZVRKQnZHZElDR3ZHWWNFdzFZNU9qOWV4QUcrTkN4eWpld0hqQ012RWhE?=
 =?utf-8?B?M3N6M0I0Q3ZrR0J5dGRqVkpGdUhNaTlIcWlvV1llMkQweG5lbHFKd0V3RUs3?=
 =?utf-8?B?QStYVEgwWFdwWlFQRGdDV1FvcXBNNlJ1eEdUSXc1TjNTbkszZkpiU2lQNHFh?=
 =?utf-8?B?WmxrUXZBUGtCTkpYN2lKMnFvSWxzbzJRVDU0aEZFYkZ5Q2s0Y3RNMzFiR2x2?=
 =?utf-8?B?VWRIT0NPWmkxdzhiYm9ISUZVZ0FDSXhLZTV4NGpvVWlRMnZvTXUwejkwdHMx?=
 =?utf-8?B?d3UvTGZmL25ocFlrcFdqNEtpWk04R2p3QllzZGxTNFlSbjBReUlBMSs3b1lB?=
 =?utf-8?B?TU9DeEZZNlVCdUNJd0doMjAraU1HTE51VmFnQXBwUU1aVGYxeUM2UEJrTDJD?=
 =?utf-8?B?RE1HczlyckIzVW11NWNpbWhEL2w2VnFRSVpjZnlZNCs4Rndlck40UEdoQUIv?=
 =?utf-8?B?MWw0b2pWUXBNanRxRXhKSHhKL0I2Vlhmbm8zU2ZHeTFqS0NEQThWY0N3Z1Z1?=
 =?utf-8?B?Z2FDWVZZWlNtN2FQeXliSmVDakprT0NMR1BqVFcvalhCK09KS0RqVHlqWEVW?=
 =?utf-8?B?UzR5QkM2QVpRVjBlODZVb2dpcXdjdFlmSjAwcWlMRkJlNnY0UHFzQmhObDdP?=
 =?utf-8?B?SmJ1SVdSVWhSL1h1eUNhdXVvcXlaaGFaWUc3Zms5M1Jqa0lpZm5pZFhQcVpQ?=
 =?utf-8?B?d1QyK1dqeEpwWG84aXU0a1dQZEdWaTdmSTF0a2RmZlVTSGttV1BmNnd0a2lV?=
 =?utf-8?B?VkthcWptamdBWFU3bTlzcWFjbVpPQXBoeC9aYVF2MWZlbGd4QXd6S0V1Qzhk?=
 =?utf-8?B?TFV1RnBhNVZOM0xnamttd1RJZ2hqRzhyUzZTdVAyL3pldXNRMmhpUitwdzFu?=
 =?utf-8?B?WHRMSzRNNWs2TjdadW5xamZ6ODBwbGh2SHkyQ2JZMG01VS9mYVJqQW1vWGJT?=
 =?utf-8?B?VHFVcUUxUHRMRjFZOURMMHU4bjk4RXFDZ09HNHNYSC9uYmxIb2JaU2xYQjFs?=
 =?utf-8?B?UHVaVkRITlJTU0dIdjk3UEtwTU9CaEcvdlBaUEE2WGtnV29EVXFrNHVST1RE?=
 =?utf-8?B?SnZBalcwV1hiU2ZXc0ErMDY3bWFBV3hhZlBXb0pNRGxKZUg2UDdoS3lEREk1?=
 =?utf-8?B?TjQ3MlJHQmIza28raW91MEJMQnNEeHRqSFlrNTFsZ0VOV1RLS1gwbFhKdTMx?=
 =?utf-8?B?c3hDLzNRdE5JUWU4a21NVlR0elE4VWFFaWJNUG1RaUo2MDMzN09aWmRWSE9B?=
 =?utf-8?B?NzlYSFI2NzFraGJUTzRHTlJ6U1VoYisxZHQzQkR3dDRtV2hIdEdDWWpYQmV1?=
 =?utf-8?B?aVByM3F3UDd5eW1MZ0IwNkVVR3NZSDVPTmJRZWFoYkNiTlJnb3RDNitSbm9E?=
 =?utf-8?B?WHJxODB2WFFadHBiM0orWXphTkNVaXJPVjJOSkxCWk1nY0h6MU96K0MrR0hO?=
 =?utf-8?B?VFp5cUNRbFlTZFkwMUVUYUJUZGZTanJrWEk0aWEvSVphdlUrOGEzVk40RjQr?=
 =?utf-8?Q?hjZr8iQLE7p83VVo=3D?=
X-Exchange-RoutingPolicyChecked: LhrIl/xNDKnIdUOLm0XyrKPnhHiJ3EvW62DgPOpy9Jn2l7GgowFHH1MF1b6uzxb1Y/hMBpofom76Z5mmLc2leNTjs5vgJeORFZpOAOJ8wlJcHjz76mgv/zLKHlo9o2czTf9f9o/QNP/WJYbH87b12Fs2dYQ95DFnFsaJqxPYaqxJfoZNcNJU/gJlzrjcLWm/i42VNj5JJY8/kvghoKDc0CyrY1EWqQT3HLNEcWTwxthuJ+EKZvhODt4GuZyyij7LsZGomX3JRKDUIRffE9yyy5cMKVppyjS5sixdHhDyzQa6k/Soj7/VKoWw2ZDvRRktSjkzVZus/VvwmDT7FClp5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd5d2e3-d8c7-4c03-6e18-08df01a45e50
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 05:55:58.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eY/FIspoZlh6SuiT58Qy8cC4o+PzbcwG/NvTrRmU+vC2kiOsmCgJo1LWpVw+bozePlTzwQXJDwk2YCTg+NG0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-OriginatorOrg: intel.com

On 24/08/2026 05:55, Wang Yan wrote:
> min_sz is set to sizeof(u64) * POWERPC_VPADTL_TYPE, but the code reads
> auxtrace_info->priv[POWERPC_VPADTL_TYPE], which needs at least
> POWERPC_VPADTL_TYPE + 1 elements.  POWERPC_VPADTL_TYPE is the first
> enumerator of the priv index enum (0), so min_sz evaluates to 0 and the
> check validates only the perf_record_auxtrace_info header itself.  A
> PERF_RECORD_AUXTRACE_INFO event carrying a zero-length priv array then
> passes the size check, and the subsequent priv[POWERPC_VPADTL_TYPE]
> read runs one u64 past the validated region.
> 
> This is the same off-by-one fixed for Intel PT by commit c4362d5e1a5e
> ("perf intel-pt: Fix off-by-one in auxtrace_info minimum size check")
> and for Intel BTS by commit b9fb8225951c ("perf intel-bts: Fix off-by-one
> in auxtrace_info minimum size check").
> 
> Use sizeof(u64) * (POWERPC_VPADTL_TYPE + 1) so the highest accessed
> priv index is covered by the minimum-size validation.
> 
> Fixes: c4bbd4ec2e50 ("perf powerpc: Process auxtrace events and display in 'perf report -D'")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Yan <wangyan01@kylinos.cn>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/powerpc-vpadtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
> index 710f3093f3f9..c15636eef34b 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -683,7 +683,7 @@ int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session)
>  {
>  	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
> -	size_t min_sz = sizeof(u64) * POWERPC_VPADTL_TYPE;
> +	size_t min_sz = sizeof(u64) * (POWERPC_VPADTL_TYPE + 1);
>  	struct powerpc_vpadtl *vpa;
>  	int err;
>  

