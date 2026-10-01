Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB02D12EE;
	Thu,  1 Oct 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898053; cv=fail; b=o8ycbijXU1P9IJMgIoT6Sn1Hq51glnh2ixP5yOqi9/ifwrZlxlV81N62saAz5B3Z8EL1dumUYPJtuEmV+M++yTc0V4er85HT9RzTFVyXA1jy8H94laHsFHQF4A3WvIoRSzMU63chVuKIQfBdwCMOuu9foOfWIZz/s0sFz8hcfLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898053; c=relaxed/simple;
	bh=Eq6+iMl2nR0glsJRajaEazdWJKXON9dFJhVBmM6NW2g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsHlRM1VeR2BlL2OZksczl4Ow2ZJUyCSACJJ6AT67I1WQBxnUmnJiR+h3EWGMIXoaS4i8BycNDCrXbnr23RLPoitM7UWDXp37DKmQAnEsV2KTkFY5RKdiGNoPhdxo6bfOWDAhCi2ZZxfIcBawQzi5HiqdmlEGyw7SV479NE+tQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csJ1U3Uk; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csJ1U3Uk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790898052; x=1822434052;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Eq6+iMl2nR0glsJRajaEazdWJKXON9dFJhVBmM6NW2g=;
  b=csJ1U3UkUxBhMjJHWC9iA7nmHFX9KHoAOrz9l8wmDxN9h/o3tjfJlfw3
   fxDOSPsGjF9QcLZD25a5DrR5qaZfadNyL97dAcshUZH2g6KQQBAF3RnII
   iNvmRmgIkizmhFHclYgFYYMw00flbNKm/m/mkZTUkTxl5PPjW3+XQqL/1
   utQNh8SmkN/dD+iJJE8aCff3ViZZ2DEGHJ1ZJm0vdEsdgm+Xzz7smZBZR
   aaqQ1zygE1Lbv3Ml63jy6hHtpkfDO+Yz721d7PNe6dPrQ2I9LGBvyNqoY
   dZaxq0TtCdF4VnUV8hmhpe8/XyEpM0UtfD3I0DO0jRJipjpbqWJMW5gmO
   g==;
X-CSE-ConnectionGUID: z+Kjk9yDSVOIMJq3WC/Mgw==
X-CSE-MsgGUID: zZaeghSCQ0CoOaSolQ7v9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91532990"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91532990"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:40:52 -0700
X-CSE-ConnectionGUID: mmHeFxRaR1C2UBGKDyexJA==
X-CSE-MsgGUID: bhme8oV1REGEt2Z9IkTibg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="151240"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 16:40:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:40:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 16:40:51 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 16:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vFX9rCzmMn59W1zR1EcEiO0zzLMx6GSbuxUcoMtHx2Y5Szu8DyJDXAJb7L/nb9rG8woN7tQF4LmJ1WqsN7L1dKyFfFPCZxBKIABMY1egXnxmqV4nC4WuQJVTqWOsRFiHJsL64CXhITCd2jl+gUXPecCIQMbGxVMBc2ow2tpMKjM2RiDdp4zV8U8kiNhHoyFbl3PAEYVpxIU+2QnmdLiEq1eNuE1skp7TVRfz1KPL2gL6751KkNp7Q/tr6cv+Jdav2rS/TW6DCzmh0+F2JpmHmdNcWAXCPoSwAFsxRowiEvhpl1P2CT41tA17PZy0gClVSSGnt8JDaKlyHUPIrofuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxEhOy9nocb7Xw2VMs6AdHATFra2eSM9OvIlH7Xdk/c=;
 b=iDDLePxBRNvztFsafm23Tb+uM8fZEFvkKLU5WPMayiH7ZZbx1ZHNLHS2ovSvZddhA1+Hn6oNTpuoz19p5Ssriy4lyhnP3tZSIizvoYO9o7/mA5KSqvos1fC++lICuz9RUpl4fngHUsTbVWiF9S5bj2DtVEkHrsHhv5px6uFeOvZWbStcYvW8fHTMcuia6IE1FsZFvqGN2ex/jUYGDPcEvdVC+6KPOdRDmwJ4VaNrZDQv515b46006NP7RTZZUCW2Wz5q5ApFGIj6N5L7VUoPDJVNXHj4bAl1M4nNKcn3DH2RHJa7KAolrUCe8O1n8Gr0dg46/PKYy4Mccndl82vvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5) by SA3PR11MB938431.namprd11.prod.outlook.com
 (2603:10b6:806:531::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 23:40:49 +0000
Received: from SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b]) by SA3PR11MB186312.namprd11.prod.outlook.com
 ([fe80::fbe8:9ba6:fcd0:f0b%6]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 23:40:49 +0000
Message-ID: <e4f1eadf-2bcd-4a1c-b321-b4004ba0645d@intel.com>
Date: Thu, 1 Oct 2026 16:40:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] idpf: fix possible race on remove during a reset
To: <netdev-bot+sashiko@kernel.org>, <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<david.butler@appgate.com>, <luoxuanqiang@kylinos.cn>,
	<bryan.fraschetti@canonical.com>, <tristan@talencesecurity.com>,
	<tomasz.lichwala@linux.intel.com>, <horms@kernel.org>,
	<aleksander.lobakin@intel.com>, <stable@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <aleksandr.loktionov@intel.com>
References: <20260928230429.495442-2-anthony.l.nguyen@intel.com>
 <179072991189.434549.5989394906343796155@kernel.org>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <179072991189.434549.5989394906343796155@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To SA3PR11MB186312.namprd11.prod.outlook.com
 (2603:10b6:806:595::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB186312:EE_|SA3PR11MB938431:EE_
X-MS-Office365-Filtering-Correlation-Id: fe9becab-6dc0-4418-5cad-08df20156c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5zqTsGl2CNsxSspHkcleB2mlw7qWzMNFUMuRCRsIQvMN4oxpDa2xo3G5T8pINUgx8xkLcNvUV8BGUckrr4hGf577y5/QuvaRKZsoT29HyCeNiaqlvd5F34WBgf3SioDvI+bZ8m/sgIY9rYHsIT3pXIEXUFtuggTRRQYw7Vub3Kg608jRMYq6Z+/0NmnDZDb3gNcQqG4aoNtxoElkdY8itj2jXrCSpDv8gYXa4dgznOfImXRRa0Ab3/+nfDeRG1GTbx7koexiKnzK72isCN37p5L+PQCmxNj6Ldg0e7iTjgP4bjaI7FbBBKKGsk14a9XAQGweLnaj5fdMmtdj6r9ylmtYxfY4veZ9ZtbDuuFzZ36wdCDVvpccGsLbHdTS+ALRM0bpf9IWQyWJkn9rTvCZs/mGWibDA0EBoiffhsOoshpsgld5rDDAvgXHOSiFkVI0rZzijmKCOVFyUa2vx03RSHxqRkEE+bJjziAhk9e5MaooTOIaLUJaC+8uTX9X7QW34XHtSOjuPZlG5etIEIWJVmh948azfZV0RY4YMgrZa/BHkHPxzXjhZar5Qbufk7pCroxolDZEBL4ZvBuE0hglYJiznTSNTXYH6sRX6npXtLZ7yHeM9lIJHi0bYwoe77GwLhXqqKpVqtOYqc3wURLiB8kMuGA0/7VxTFDnKggPKQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB186312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDZqM2V4QkNWZVlheE1aZzZIY1UvSFAwTWxpdkRoNGpmcDJheHQ2TSsyZHNW?=
 =?utf-8?B?Mk5KeElwbVRVUUNPeXBLTm94WlhUV1U0M0MreWZGcEx1NVNsWnk3OHJaYno5?=
 =?utf-8?B?OXg5VlZidHc3d2NtT1EzL0lNZ1ZHUE1lZXJ3bjBjWTBRRjF5YUt6RzFVaFpJ?=
 =?utf-8?B?dUtWV0FaalF4WUFFOUNTTmlqbHIwY2hwNHY4Wi9IZUFxV3VlYWlYM05RTFZv?=
 =?utf-8?B?eUdhcUFXL29jM215cmk0N2ZBNkMzQWwxS3RqUTIwY3NZUzlZVGE0SXFXLzF5?=
 =?utf-8?B?WmcxU2pKbTh6K3FhRGhaem5FbkdqQUlsYUkyblJVQ3NPVjVDYVlaWG05ZGNU?=
 =?utf-8?B?MGtWaEJwbXNCdWRXUTg2d2d0dy9lUGlPNVJiUjRxQ3d4OHZwOHNhOEJBVjBr?=
 =?utf-8?B?aUplbDBmKzlHQWNtMEpGeU9WdGhVdmdWUkh0UStNaStzV0xIdW5qSytSWThN?=
 =?utf-8?B?eTlENUU2SFJ2TU1LOXFCMnBCdno5RXdxNGxRcnNOL3NKVFpOSFJ4SFgvMk84?=
 =?utf-8?B?VDlVZmRoalJhQlFZc1drN20zWWQ0R1JQdGpRdXZESVRrRDZIY3VqVExJUXp4?=
 =?utf-8?B?RDZ3WXdUMHdQRUs0RUNoWXF2NklBS044REQ0RG5GM1ppV0JPekpCdXh0WVJu?=
 =?utf-8?B?QXFQWlU3NnpvakZmNzNXalQ1OWRvTlhhb1UzTm1VTStXNU5qOVYwRHJGa2tv?=
 =?utf-8?B?T2ZmZEVQNldvRTN4SW1sV21odXhOc0xNR0JUWGlFNlZvV0xEWDhiWVhwanUz?=
 =?utf-8?B?dmlaYTh0ZmRKMkFjODNhVitjMDg5cnFBUW12SGZKeHhrWXkvSkJibzAxdXkr?=
 =?utf-8?B?TVFNOVlwY1d1ZHpCbkpvS0FucjA2NjNLNWdDUzBXQkpqdEV2WnN2bjZrY3FF?=
 =?utf-8?B?THI1N0J6WHVFN2hUUGhub1BEY2Y0YldQbW1JQk10ZlFxYzFrdmEwR0F5aUM4?=
 =?utf-8?B?TDh1NTVYNHdGOGF0Y2JpeFpadGp5SHpabE9ONzV3SHczVUY4c3ZlVGFIZHR1?=
 =?utf-8?B?SHpTWURQNWsyOEVrV1BtNEhoSW5UbnNsQTFVclVTeHk1ckpYcE8xeXdhRWN5?=
 =?utf-8?B?bThDc2RZYWpWY0dqY0VBTVkvTGZQRi9QUTdPWEY2cGdScEQwQ0lOK2VsajNT?=
 =?utf-8?B?Z1pzU0luZEh1a05nc0JkcHZKODNOZ0o5V2lxWXNEVWxKeDNnazVGejVCZXdh?=
 =?utf-8?B?R05Tb05ZUW9QSkFYYU0zK3h2dzRrd3k1eVk0b2JQcmN1U2s2TnNqTks3S2k5?=
 =?utf-8?B?cXV3RkIwamlRbXhZNmZWZHAyL1JLaG5NWkhkdG55NlkxWllNY21DSXRxVy9E?=
 =?utf-8?B?V1BsSW4rRFZvN1RQQ2JCbklWM09RM1ZYcUg4UXNRQ1ZLL0Q0SEVsODZ3VVFD?=
 =?utf-8?B?UlNSRlg1M244QzQ0U3pCTkI5V29CZXpJYlJETjlRNVU1VkVmMjMxVmJlbjFq?=
 =?utf-8?B?VVZIeXFqZ2FXcVE4N2U2UlV5NlkzRVZ3YXJvZWtwZnVEVUh4ZlB2SGcwcE1Y?=
 =?utf-8?B?cTk3RVFJa0d5NEk5TGZGMHA0Qy8zVm9kLzhkL05OV2VWMkdpSUdJWThYSzkx?=
 =?utf-8?B?NkJQSXNzSW0rV0E1ZndSaFRXK1NtU0t2WUI5SzBaQkN5VVlPL1hzYmJJRlhn?=
 =?utf-8?B?ekY3amR0WnFVNW9KTmZVdDFzUlA1L2lTRDVZVmNCWnptSllQUHlRR0dlMXls?=
 =?utf-8?B?R3dEdnNBOXVTaXZvRzNOWEVkTUZsS1RmRDF4bS95Mkd2a0tmamx3MkMxV2hw?=
 =?utf-8?B?ajc3OVQ0UWVTeHlFTTdZaEVzMXI5ZkFjTWlGN0IxY0pFN0p4NG9RTEkyWEtv?=
 =?utf-8?B?Qm81d3pjREZWOGFiYVFlaEVFbVVVWm1ZL3ZOUC83ZktIb1hkeWNFdjZJUHI1?=
 =?utf-8?B?ZDBqZVlaZGEzOTIya0ZnMURla1RXZXcrdE1KS1lYdWpmS3Y0SURMOVo5dnBG?=
 =?utf-8?B?bVBaTHdSMkRlK2dTeVFuNEUyREdEQzZWLzBIRXdjQVRYZVZhZFlNM29GUS9z?=
 =?utf-8?B?NDdEN0QxeG1ROUdYRmh2VVpHaFg2eXA4dElGOFhxeHF2Wm9CL283UkJDS2Rx?=
 =?utf-8?B?bkplNVR5Smd1dDY4UHNKeDFIMWZ4VHhiblhtVWppbGVDOU0vN2tIaVhaTW5T?=
 =?utf-8?B?V3BYVzhCb05wWVZwRm4xWk1JQ1NLRlJLbVlBbmJ3V0M3cTV3Z1FVTks0NnRG?=
 =?utf-8?B?RjEzRnJQWjVMcVdvYnNLbGQ4VlEwNDZLanUwMy9nbEZNWFp6Ylo4WVpqUHVk?=
 =?utf-8?B?dG9rSTlMUUZZcStHWDk1OGMrVmx3dnh6RU05Z1R3ZVU3RUliNkliZDNlTGRu?=
 =?utf-8?B?MS90dm1uSTJIS3g2d1dxYnl3MkUrVVAvY2Z6VktlMjVQWjlLaWg2cGc3RjFs?=
 =?utf-8?Q?u87iUpAL6m9CNokk=3D?=
X-Exchange-RoutingPolicyChecked: ceeE2BKWQZmFQTObBBPgP8gXlVtPaOq/nGrArO4r8LWRcq7CgE0arOPRWhR7c/ui9JbuTthfMYd2FjbMDl4Gt2sSWVvq9UsKZh7X9Qu3nO89J3Ma9SSuypZrk1+AoLYfCpUJ9NMRHJD81NLoPUCe+1z1nBXDChLXHLUMKR0bHcQpyQhUksjNQiW+RlhXu2DxwhAjGjwpn4w/RfW7g1a4Ov9DL53TvaikQXBvlLvTEuoBGmBBUBD5+KRWbwUzUXiiQPJcx0vDuQv32bIXM4lgjigtyNDaXhgjuNjmKKzwUfCQrZUWBxpHIwr6Q2zPOuemZbWAABNo5xSvVoxANH6Alw==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9becab-6dc0-4418-5cad-08df20156c5f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB186312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:40:49.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Sa51bJOJnANQAg+zXyu8SJ1j7CV94et06g/wC6vJQ+4BC0HoDQJxFpYHnpU9RA3ElstYKEAqx1TZW6PmO+l4Ax9n3I1G59IomPHFKFZrgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB938431
X-OriginatorOrg: intel.com



On 9/29/2026 5:58 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch removes the IDPF_REMOVE_IN_PROG early return from
>    idpf_stop(), which opens a double-teardown race between a userspace…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the patch
>    relies on the loop that contains it.
> - [High] This problem wasn't introduced by this patch, but the patch now
>    sends the remove-racing-reset case through it.
> 
> --
> 
> idpf: fix possible race on remove during a reset
> 
> This patch drops the IDPF_REMOVE_IN_PROG early return from idpf_stop(),
> so idpf_vport_stop() always runs on close. The goal is to let a reset
> that races with remove tear down NAPI in idpf_detach_and_close(), which
> runs under RTNL.
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> index 827c795afcb62..2c148377540cd 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
>> @@ -1033,12 +1033,8 @@ static void idpf_vport_stop(struct idpf_vport *vport, bool rtnl)
>>    */
>>   static int idpf_stop(struct net_device *netdev)
>>   {
>> -	struct idpf_netdev_priv *np = netdev_priv(netdev);
>>   	struct idpf_vport *vport;
>>   
>> -	if (test_bit(IDPF_REMOVE_IN_PROG, np->adapter->flags))
>> -		return 0;
>> -
> 
> [Severity: High]
> Without this check, can a userspace close that runs during idpf_remove()
> tear down the vport a second time?
> 
> The remove path is idpf_remove() -> idpf_vc_core_deinit() ->
> idpf_deinit_task() -> idpf_vport_dealloc() -> idpf_vport_stop(vport, true).
> It holds neither vport_ctrl_lock nor RTNL on entry. idpf_vport_stop() tests
> the UP bit before it takes RTNL and does not test it again afterwards:
> 
> idpf_vport_stop() {
> 	if (!test_bit(IDPF_VPORT_UP, np->state))
> 		return;
> 
> 	if (rtnl)
> 		rtnl_lock();
>      ...
> }
> 
> This is the interleaving in question:
> 
> CPU1 (rmmod)                         CPU2 (ip link set dev down)
>                                       __dev_close_many() holds RTNL
> idpf_vport_stop(vport, true)
>    IDPF_VPORT_UP is set
>    rtnl_lock() blocks
>                                       idpf_stop()
>                                         idpf_vport_stop(vport, false)
>                                           queues/vectors released
>                                           IDPF_VPORT_UP cleared
>                                       rtnl_unlock()
>    teardown continues on released state
> 
> idpf_vport_intr_rel() sets q_vectors to NULL but does not change
> num_q_vectors:
> 
> 	kfree(rsrc->q_vectors);
> 	rsrc->q_vectors = NULL;
> 
> On the second pass, idpf_vport_intr_dis_irq_all() does:
> 
> 	struct idpf_q_vector *q_vector = rsrc->q_vectors;
> 	...
> 	for (u16 q_idx = 0; q_idx < rsrc->num_q_vectors; q_idx++)
> 		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);
> 
> Won't that dereference a NULL q_vector? The virtchnl message builders
> that walk the NULLed rsrc->txq_grps/rxq_grps may also crash before that
> point.
> 
> Before this patch, a close that reached idpf_stop() after remove had set
> IDPF_REMOVE_IN_PROG returned 0, so only one teardown ran.
> 
> Would it help to re-check IDPF_VPORT_UP in idpf_vport_stop() after
> rtnl_lock() is taken, or to hold vport_ctrl_lock around the stop in the
> remove path?
> 
>>   	idpf_vport_ctrl_lock(netdev);
>>   	vport = idpf_netdev_to_vport(netdev);
>>

This is a valid hit. I will post v2 to address it. For the pre-existing 
below, I will review and post fixes as needed.

Thanks,
Emil

> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. It
> matters here because this fix now depends on the loop in
> idpf_detach_and_close():
> 
> 	for (int i = 0; i < max_vports; i++) {
> 		struct net_device *netdev = adapter->netdevs[i];
> 		...
> 		if (!netif_device_present(netdev))
> 			continue;
> 
> idpf_vc_core_init() sizes adapter->netdevs by caps.max_vports. However,
> idpf_init_task() only creates netdevs up to default_num_vports. If the
> device reports max_vports > default_num_vports, can the first hard reset
> pass a NULL netdev to netif_device_present()?
> 
> idpf_vc_event_task() -> idpf_init_hard_reset() -> idpf_detach_and_close()
>    -> netif_device_present(NULL)
> 
> The other max_vports-bounded loops in the driver check for empty slots.
> idpf_remove() does "if (!adapter->netdevs[i]) continue;", idpf_init_task()
> checks !netdev, and idpf_decfg_netdev() stores NULL into the slot on
> purpose.
> 
> It is not clear which shipping firmware reports max_vports larger than
> default_num_vports. virtchnl2 defines them as separate fields, though.
> This has been present since 2e281e1155fc, the commit named in Fixes:.
> 
> [Severity: High]
> This is also a pre-existing issue and was not introduced by this patch.
> However, the remove-racing-reset case now goes through it as well.
> 
> On a software-initiated function reset, the transaction manager is shut
> down before the close path runs:
> 
> idpf_vc_event_task() {
>      ...
> func_reset:
> 	if (adapter->xnm)
> 		libie_ctlq_xn_shutdown(adapter->xnm);
> drv_load:
> 	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
> 	idpf_init_hard_reset(adapter);
>      ...
> }
> 
> After that, libie_ctlq_xn_pop_free() refuses new transactions:
> 
> 	if (unlikely(xnm->shutdown))
> 		return NULL;
> 
> The call chain is idpf_init_hard_reset() -> idpf_detach_and_close() ->
> dev_close() -> idpf_stop() -> idpf_vport_stop(). The DISABLE_VPORT and
> DISABLE_QUEUES messages fail silently because their return values are
> ignored. Then the rings and buffers are freed:
> 
> 	idpf_vport_intr_deinit(vport, rsrc);
> 	idpf_xdp_rxq_info_deinit_all(rsrc);
> 	idpf_vport_queues_rel(vport, rsrc);
> 	idpf_vport_intr_rel(rsrc);
> 
> reg_ops->trigger_reset() is only called later, after
> idpf_vc_core_deinit(). Can the still-enabled Rx queues DMA into the freed
> descriptor rings or buffers during that window?
> 
> On a VF, idpf_vf_trigger_reset() skips the reset entirely during remove:
> 
> 	if (trig_cause == IDPF_HR_FUNC_RESET &&
> 	    !test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> 		idpf_send_vf_reset_msg(adapter);
> 
> In that case, no device reset follows the free at all.
> 
> Before this patch, the remove-racing-reset case skipped idpf_vport_stop()
> in idpf_stop(). The rings leaked, but they were not freed while still in
> use.
> 
> Would it help to shut down the transaction manager only after
> idpf_detach_and_close() has disabled the queues? Another option is to
> keep the DMA memory until the device has been reset.
> 

