Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BEE3BBFB2
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992862; cv=fail; b=ARuyYJhzvdq6c83ayX5PuKYSZSkZ7eX40HWD0dq8rLE8TxBOczN4boah5XGuA1LJbB45zDKQkKet5FjtvT9Gt/Uy/F4qWIMkB6vzZJ3oh+0QFZ1KTqrmVOJnQV30QZkzQjlm2k0lEAXSqKffBYV/3A86wQi35XOa7DdZ3Z6KriY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992862; c=relaxed/simple;
	bh=mmg5UVfVCLPITafVUVzhywwT9RNtjt/VwPE+5QBClDM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPbfB8AGyKecr/xjrc8BRmB4BVfUhDgZV+XNlIqAeQ585eIqgCotm3F1Ia6AiguaKLziaSpT3VUOaLmyz4CYMcrwP/yYcFeMTVpG2XARrXhz2Cz6ybADSJ3PPlT34XT+zP5LzqsoMZYB3pSoeKI7hluaN/NMpIvrv61R4K16HT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5Ec/C20; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5Ec/C20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789992861; x=1821528861;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mmg5UVfVCLPITafVUVzhywwT9RNtjt/VwPE+5QBClDM=;
  b=P5Ec/C20UIKOx2xLVWfzfsm9k6I+RZWoQaJstAQHIPf4HIP64SswyAfq
   Zc6PGYK9GbMdMcGzwFEGtFhCfTBaUsDcCijs3Z+hXzB7DsR5zv7EWDmUO
   oi046APVTlCJ8X2fKrKKDaXAV8SmESY5UnpgmUE4UtXbrWTwt0mQu6iGE
   zrvr/9/bGAp6lBjnomUIFQELFwfwdcJJye/a5SFk8d1r/6nmE1XoS6Q/3
   ol7sXvaBxNy7DGBae9UOtHr2R8hpcp9RCBX+o/1/q/6UAbvuigA66tSpt
   7U+rFjwuL6c7G0YOA5GwVpGSrSMOud+eVh1qrPJyyQoUqpE8hbCvaqFhs
   Q==;
X-CSE-ConnectionGUID: Sirga03tT1Oo1shCkzu6tA==
X-CSE-MsgGUID: t66kv8XtSue81VLyBmg1Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="1003860"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="1003860"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:14:20 -0700
X-CSE-ConnectionGUID: /6pX7F0URF2a3ib6hW3Cyw==
X-CSE-MsgGUID: E7C643DpQrqLLyvl8v/dpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3623010"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 05:14:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 05:14:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 05:14:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 05:14:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtcAUxhNTa9hY7JvOYCo9qrGRgcbCGxIDXYHsmPe2bB4GGHeBJORIqqV28Ytni6XSINIITkpBNCxiHoyL5PgHIhpMLtHBpsoYx75FDuVRXwTxqPEne6tn6/grm5a54h5BLgRevIMY7ATD8gYQHUAZjcS6Mqk1z+sqbVlov7X4GcWTGqN1mPX0W/DCKai2p/cw6N/SIRbgw/K21b86SG0RtFG9cRqyJ3hMB/i9o5iF37tUot4lml+brWxJSUPqVV3d6qDL7j+4EBrmWQJNqZcq3xcyX8tcUs0bjrb7Z3P+Cvf/DtA3qSaQeZ5gloya7yLqaaeOBX7W7EvQUDeskInOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjgP7ULD97yqBxqBo7VPnULQ9wK49NCdEK/J/zIsMjY=;
 b=lL0yaBtt5GswcbeZ2G+C6JixvAVy+2xzZh1sE4RbeQa4wU46Q5BrjvTSi+9VjnHmM1MjsH3Hk489yhRhjTCun36UhWzJ53wp/t5WAPMSJ8y5bzhvYSLz49D9/+BK9bV/nF2c+lDR2jS1pD1gOpR4eQQoK8gjokXIVXhr0XNfzbpjxYhiN+1Mlvudiawk9JlXRn8X/yN0GbCGKe8q3mQvYS+HnFQStoxkmTvzWbWsIZCshrnjNFkKz6+805sAFABl8KwEOBBcTisHLomvT2ZBn/RSWq9XBEql32RSqgOeqRJO8JQ2axDa7O6b0wnYZTOQ0TrItoqmnFuhCcxio8g3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by DM6PR11MB4562.namprd11.prod.outlook.com
 (2603:10b6:5:2a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 12:14:17 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 12:14:17 +0000
Message-ID: <edba2605-9d84-4750-9ddd-fdc4ce72fe63@intel.com>
Date: Mon, 21 Sep 2026 17:44:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/i915/vrr: Disable DC balance by default
To: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, <jani.nikula@linux.intel.com>,
	<chaitanya.kumar.borah@intel.com>, <stable@vger.kernel.org>
References: <20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::13) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e73b3f-1397-40e1-3eb0-08df17d9dbe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G2Du0Ibj6ioagIIpurKRvNQH2sQA6UCBA3SZcV9B4waXlYB6XuGjGN5FwyOva4zvH0OiExyQ2fBJmfTjd7SXDcpSpNw14KtulI7lyyZPyc9bQXc8nVpJHTdu3h2eD3uXZWtrA+9TNoV7H4NxUL2u79UpKmy+ohAs7SfiWLjQ4T+nM5Y4tzz4leEGcgHEhlf1wOPOJQErgPFKRsTZGEbpf36s0SAto1j7sfA9DUxm+lRdHc+cUczs62zKMPZjGuzXCcV61ll/ugt6g4RXd3I3e1o2+N/eUTAOA5IIko2UkEjzzq2GQPNsCH1cC3Wjre+nz75RYwA5xFmPrNMG2KCuv2kmvDwV3pi4kkukTWIcqhVcTbwaPhulSKS5woF4bE8k6FP+95dxjExuXNFdO3kidCM5dgChOco8hHefFvHk9bVoFtyOa6Fis6IolNm5sONvYVhPFcnF2xcFVKDH824wG6zjsgToeBJL7m4X/eug/CYz6gT5gO9W4k475/WSb/x7AkZNzbFjsYJ0v0eGbYCs1CuZseGdPHYl/A3nT2sQLZD2SYaMiXUpEkR//gN2JfXHayg/NNd2pnCZbEeMpmSLIfwJ0e1yGNiV2GLaA93Zc0LmeXGYHnlL4/ZwmuFDsFEIrStztSPUkPOu8iO3J5hhL3fb9R8YJ4E7sl7pqReFllU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXlKWjBYY01VOVJKQVRlRmZzMkhMVnBBOHBCQjI0VnYrWHJJSXEveHNHUEI2?=
 =?utf-8?B?cFNMbndxeTNVYjFZTkVBRVM5alNuZDhxVWxCTExocEVIYzhmMm4vZHBNUDd2?=
 =?utf-8?B?K25YN3R5KzVkSUwzNFVEbkM5WmxPVFh1bUdVUXVLUmRWRE1XdWNMT2hObUdN?=
 =?utf-8?B?anhyVStKL3BOSEU3M0NHSHhrNjk5Zy9WbkpjRjB0MUJhK3ppSSsvY3E0VTBn?=
 =?utf-8?B?TndSaDBBdFlVdnpLWGtDVjdTS21sZ1R6bkY2ekg2bUJoVG50cmxIN3NTZ0E3?=
 =?utf-8?B?cEc2ZGwyaE1KbWFmT2J3b2R4VFMzMDVwaGMwdS9iN09YMEtKSlNoVVE5R3kz?=
 =?utf-8?B?OFp6ZTQxNFZxWVZVbjU4RE1na0d0L09lSldhc1VWa3FWTXJWMkdYYitqYnpv?=
 =?utf-8?B?dGhBSzhMWnN4azd1dEJHVUVGdmVmKzhOakxxQU4zV0ZTV3UyeGg5QkdPeTJN?=
 =?utf-8?B?anE4UHlQS2hPNnRsTE5DalJ4dnpBUE5GUnhZcnR2VkovNG9BRGlldlRibk9a?=
 =?utf-8?B?SkdsUTJiMDZOb1JlT3UxdGFLV0xBczBWMC9FNzNYbGNtZlJITEZkOFF6VzJL?=
 =?utf-8?B?cW83SmN4dlhYU1hJOHA2V1U5VGlXQTFPbHM1RzMzcmRWNWdNOFRKZk5GcXBE?=
 =?utf-8?B?TWJjbWNmZTYvWTZ4TzBhaStmTVpaRzZFZ3pJMkkrQkw2K0l3TVdyVDI5N2ZC?=
 =?utf-8?B?MEZYTDcyWGdNYlp5RWV4d2l4bVhXaXB5b3V6OGVSNC9UYWNvZVdINUM2bktl?=
 =?utf-8?B?V3hJbkI4a2Y5ZUUwNGRHc2hPcjRkMkxOK2l3UVZPRmxZekV2enQ5K0x0WXgv?=
 =?utf-8?B?Zkpla2hRUU02cHY1dk9ZZExtVFd5SUVtbGVDVmlUSmFtQ01LOTFkRC9ScTVz?=
 =?utf-8?B?dDBsV0RGN1JuY1VSQk9rMmJKL0dKeEthcVFGOFNhNWFtUm05R3EzUHdOa1Bl?=
 =?utf-8?B?UDhDUEtkT2JkL1dyNE1CMG11RmQ5TEh4YWJZaFU0Z3hna25ZTFBLT21tbDNj?=
 =?utf-8?B?NHRCaC9ZcExpLzZBYXdjTzhzeUU4L2UwRFV3d3dTUXJsYW5uT2tsay9zVEVK?=
 =?utf-8?B?WWNHdlZlTG9GQnlYeW0vZmozNERrNjQ3L05yYUoxSHNJWXhhK1Y3L3p1a3po?=
 =?utf-8?B?S3E1UXpYRUllckp3UVZnR3grTk9OUWd4MkFPKytyS0lSTUplUUlCcjRsYnZn?=
 =?utf-8?B?Y0VKK2s0d3VEMmlPZGQ3MTZrejlFck9QcFgvRUhLYVRDWFFBa3RnU01MQlo0?=
 =?utf-8?B?emJaQ1IyeTZPQWIxNWtKOWZWb0xranhpTTdOemdRY2tiMXVrYjRVOFlhSFFU?=
 =?utf-8?B?QmxqQnhKWFM3cFl2YW80N0F6TVZpOExhOGFZcFI5c3MzTTByRHh1ZFdzODVs?=
 =?utf-8?B?T3dPSTczK3BRVzVjV0djbGxKQzIwOXJuSW01WWcyTjZsYVkyNWlyS2FiMzRN?=
 =?utf-8?B?MWtmMzk4ZVd6MkROKzlRQ3dKSTRKNmdEY1g3a2FGMWcrOUUwTGhISkYyS2pM?=
 =?utf-8?B?YWtnN3J1WWZGUEp3SGV1aDJiYm1QNHNZazBhT29hUzQ2MUYvZU1YNTdTWFV3?=
 =?utf-8?B?djJxa0J0V3ZYU3FlNFlUaStHQ013eGd3eXF4WkdEMEd4eVZVTXkzTktiUEZH?=
 =?utf-8?B?YVB6NXJVdlorYzBLd0h6cHF6RS9HQmVMVWU2dWRXUHNPR2l4eWp1S3hFK3VL?=
 =?utf-8?B?TjcxUW1zSmpnazZOejhZaFNRbnZFc29uMmRmSU91SFEyYW5YbEZhdDBHdENE?=
 =?utf-8?B?SjZWL2ZGZHZhOHZ6QXNKY3NtYVovTHk3TThiOXRKays5WjRDelI1MXhNaVRa?=
 =?utf-8?B?RXc0T2o2V2syazlvaUxSTzA1SWhMdW1KNTA4Tit2Z2xHUmE2c1NVa1hReGow?=
 =?utf-8?B?N2xIV1FrMEdOUktseXdUNXMyeWhxZUZmK05KMmUwSUV1WkQ5R1VINElIalcw?=
 =?utf-8?B?bjhxWVVJSW05MVFUR3BuMEtEeno1dmsvSkc4STVwM1R2dTlDakhZVUNIMnJY?=
 =?utf-8?B?Wnh5bVIrWUVKN3pNSCtUSVNaZTR3R1NQL2U1R3lzMDgwaHJncnVTaUhTbisy?=
 =?utf-8?B?cnMrdmJ1REkwamNqMVlqcFFOcEFMWFN1UnZSQjIrejZKdWl3bDFldXhlbHNv?=
 =?utf-8?B?cFA5SlIzZklNY3J1UkVIb01DR0tyWHlad3JvNVJHVlB0NUQreVZrREE5dENE?=
 =?utf-8?B?OUNwTXUxQm1wOS9RclJtb0xrU2xIRGd1TGp1Sk5kZDYvU0d1QzlUa0FUT3d2?=
 =?utf-8?B?VG5peEtmZ1FUdTFYQ0tPM0VERldCNXV4Q0ViazJDTERidGVwWWF3N29uMnpO?=
 =?utf-8?B?U2FHUG9maytnNzh3M1ZxeXlkalJTYXFUN21oN0xCdXdaYjBBdVBuYXVkTVFw?=
 =?utf-8?Q?AsneWOJueAoZcL/o=3D?=
X-Exchange-RoutingPolicyChecked: TYRwnJZa9eBWv0ZANRjR1mC3kOFiYk4trdKXG6hFybIyaKbH2HbybcqftWpFhALGBlo8tZpiw+pIuiW3otlxTvJCkcY25fIgB5SF0ukO6WzFwRRBoGhVpDHzNxgeF2WubmifCoSe6ck/rsz8uXW3AqRCQHrAUi1u9FK3NJstsb3U2vPvXsylpTzQhiNxTczslh1QL8XNyKh8iqFFoIXZ0ZykrnAWSUKeiKHqvwXttl0wx6DIN76g77AdqCweAfnKpnDV7VhnKEtWYqmP/loT7gxCZza/IHhv4fy3xW5kCV8/AGPE+rCgNgqoobC9rx1xgyAmuELH3Ui92VJ3JneN0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e73b3f-1397-40e1-3eb0-08df17d9dbe8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 12:14:17.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P5/HS5aiOMZuY2wzO790oOp8EwWvnqdzBuk2lgEV5VyVOQ17CJryRbl8aQFN+tz+HG3iARF6l0pAFgry3j12oCKzVkHuWvvMNsGh5NFcq70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com


On 9/17/2026 1:13 PM, Mitul Golani wrote:
> Disable VRR DC balance by default due to timing issues observed on some
> panel/TCON combinations.
>
> Keep the module parameter to enable DC balance during debugging and to
> isolate DC balance effects from underlying VRR/display timing issues.

LGTM.

Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>


>
> --v2:
> - Make enable_dc_balance a bool and keep it disabled by default; fix the
>    parameter type/value mismatch and correct the description (Chaitanya
>    Kumar Borah, Jani Nikula)
> - Explain in the commit message why the feature is gated and why a
>    module parameter is used (Jani Nikula)
>
> --v3:
> - Commit message update (Jani Nikula)
>
> Fixes: 555819270707 ("drm/i915/vrr: Enable DC Balance")
> Cc: <stable@vger.kernel.org> # v7.0+
> Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
> Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>   drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++++
>   drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
>   drivers/gpu/drm/i915/display/intel_vrr.c            | 4 +++-
>   3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
> index 2aed110c5b090..ca0ef466bb103 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_params.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_params.c
> @@ -120,6 +120,10 @@ intel_display_param_named_unsafe(enable_psr, int, 0400,
>   	"(0=disabled, 1=enable up to PSR1, 2=enable up to PSR2) "
>   	"Default: -1 (use per-chip default)");
>   
> +intel_display_param_named_unsafe(enable_dc_balance, bool, 0400,
> +	"Enable VRR DC balance (0=disabled, 1=enabled). "
> +	"Default: 0 (disabled)");
> +
>   intel_display_param_named_unsafe(enable_panel_replay, int, 0400,
>   	"Enable Panel Replay (0=disabled, 1=enabled). Default: -1 (use per-chip default)");
>   
> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
> index ba01aeaf89440..5c5a1a1358c32 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_params.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
> @@ -46,6 +46,7 @@ struct drm_printer;
>   	param(bool, enable_dp_mst, true, 0600) \
>   	param(int, enable_fbc, -1, 0600) \
>   	param(int, enable_psr, -1, 0600) \
> +	param(bool, enable_dc_balance, false, 0600) \
>   	param(int, enable_panel_replay, -1, 0600) \
>   	param(bool, psr_safest_params, false, 0400) \
>   	param(bool, enable_psr2_sel_fetch, true, 0400) \
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> index e36db11744405..1698c54e258b4 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> @@ -439,10 +439,12 @@ static bool intel_vrr_dc_balance_possible(const struct intel_crtc_state *crtc_st
>   static void
>   intel_vrr_dc_balance_compute_config(struct intel_crtc_state *crtc_state)
>   {
> +	struct intel_display *display = to_intel_display(crtc_state);
>   	int guardband_usec, adjustment_usec;
>   	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
>   
> -	if (!intel_vrr_dc_balance_possible(crtc_state) || !crtc_state->vrr.enable)
> +	if (!intel_vrr_dc_balance_possible(crtc_state) ||
> +	    !crtc_state->vrr.enable || !display->params.enable_dc_balance)
>   		return;
>   
>   	crtc_state->vrr.dc_balance.vmax = crtc_state->vrr.vmax;
