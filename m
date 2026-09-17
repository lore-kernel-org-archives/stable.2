Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDBA3B27E1;
	Thu, 17 Sep 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670272; cv=fail; b=pqN+o+6qPY/j0050w5yLsyx8vgRdspbrHHKqlSklqxaaIKIU7fgY6kuKso3pS8kmIV7DVSTsHGT1Y13Rrl0UplY3rhd/ws88Bs8uPXhzv/N5scCx6Wdn32Q07P56n5eXWrlfpPbguHmCJhFs58X0wKmo/Uih44EY4KrH95U93ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670272; c=relaxed/simple;
	bh=nqpU5UC8Ipl+duhixLRlqw1KWVWPYqv8hMkj3XXI71o=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFFMV40lGSGbiVSmazGC0Gurp/IRouhI/T2Xw6hBhSkK737Wpp46PfUSU+YRKP8PtDE6yMGLreoFKS0MeSQrNOxoSVwW19fhuq5qbc020RpNHIpcVdYnG2zl4W7IPG2zmbdeuiE/Lq9CPubZQ8TgYwURgGA1uBN2Yy0XMrM9zE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esnnKe//; arc=fail smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esnnKe//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789670271; x=1821206271;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nqpU5UC8Ipl+duhixLRlqw1KWVWPYqv8hMkj3XXI71o=;
  b=esnnKe//so2Qv1iTt/c4rhYOZBuUJ3gvNG0Xdsg4ARB2Bdck1O0gsPGC
   aspYaLcGLwaEZrUVeXVsvYUiy9whDwAAV1ERJokRO1upSgo6bmhtKt4M8
   lFL0YesUY2+Rt8629Pbm+pU9q56wwpmQ0Sn5WDu4VvnMdhj5U5YcSMMuX
   Qs4AsgFS5sSJHfTVL/aL0ckSnu/xVk8FgfP02jg4yW8ACweyZPqG7WA3Q
   BO4mH//thp20Sw5pBmc4CH1IlENJukfdAv4YZSA+qw1m/NPS7PVkeNehV
   ZXH2ZuB532LYNd8WRZehZjdFOiqG5FZ33BVZoDiPiQChXYW/qc0ObTu+Z
   A==;
X-CSE-ConnectionGUID: aLqLELaYTk28I036jQwqNQ==
X-CSE-MsgGUID: cb4szeG3RbKPCSAZbrzXXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="636704"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="636704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:37:50 -0700
X-CSE-ConnectionGUID: NndQYUm8RMmsW0ACitG71Q==
X-CSE-MsgGUID: P35F5uymQv6ipyqGzUQg2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269676631"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:37:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:37:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:37:49 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeVyDeDABZp5nXkX8FXPTAwp2mCGwp0xoNVVPUpZpzzPO+mAk103KmuWDEI/HZZ27PpjRVuH3GjpLAozB6wfWHZ/EybhAUPTMtihbHp8oswttnq4zUic4XWVGxUQYv4nDHc4pXomnkt7p65MQr6gir9LCyrzkhd7Ra9c6vM8GrArtZX6ESrEzwoPfAf0syJFgNdad9w6hrlt3zqn6yjVhRlyh6MC2djtlzONpfBEF9xMi6vWBEqJrrOumQXhiEOigpmEtl+UD+9PmwYZKJAKvtDbw1ALe5alc+Nx60UcjMLwuuhvylbZt2pI4F+2uQ15etgpFuqrjF1uz7B9u11fcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaATL2YHTibnRtVyhzQNfC9NFvP61jiy8qJwz1HpzuA=;
 b=R3nQIYS/XPZxO22JHPBHIKgdUaUYOvQo5DR8LzAoeCMShmrjn0BExXwnv5Hih1BRIjZhCseo2VNDhs5PvXnCWYmsz4OEymnuBAcNCMG2mgMIBU2hlayQOg6XEQ2dBdURcvnnN9WIuRHPjyPbxdxxP4EjF9xhD4eMEwDgR8EJ5fsm3Lg9nelv4yYM4gPPrmuB+TB1HWUG8n0kC5kIn0bqYQj+FzZ/BhVs/muPi3j9mke85AwLeHcEbkCf9BfTvE52JC+3yh92sQ9RbOY8Vo9dHAxBYp6LbxvQWX8md5BL7gkI8RA4tlJH+liwAMsKV9/qM7MK8uDaR+GTmPXVf2pvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 LV2PR11MB968400.namprd11.prod.outlook.com (2603:10b6:408:423::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Thu, 17 Sep
 2026 18:37:47 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 18:37:47 +0000
Message-ID: <66a43c1b-656d-4dec-95b1-3f56c9f9057e@intel.com>
Date: Thu, 17 Sep 2026 18:11:02 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: Sohil Mehta <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <andrew.cooper3@citrix.com>,
	<arjan.van.de.ven@intel.com>, <stable@vger.kernel.org>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
 <51f6a0e2-25bb-4ac3-9b3e-2883ef7e57e3@intel.com>
Content-Language: en-US
In-Reply-To: <51f6a0e2-25bb-4ac3-9b3e-2883ef7e57e3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0157.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::12) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|LV2PR11MB968400:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb9fdbb-2c4f-4ab2-23d0-08df14eac4c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xWysnzpq0b/w/OH4M/b4OTHgHDw8KnIyhUpcMrh6J7uih5GXWt9Fn6Y3RDWNh1wedpq4TwuemuwPiBGyZ2eOXT8fuI1gAHct4xxmhWB+H2aaTBYdFtBh8MRDwRQCYNhXf+8gA45h+tp4Qi9nJ8s8/kgy0k5RvMVtk5OAavwmf2UMYzP7KgRIRSb6xa+YClfL+81UJYCWVNGkudTkWv9ANgHxFEe4NcZDrvy5dUivJxQ0ihewVJlCi5NLz7sTUKvJ6b386HDbSG2cWzuMWNCMrfJCSnfgc8n2KQTZCYjp2LqzVXrg1UltND3RxDRNETCiF7JQeY+znwe+KNhrEsH655CQS7y6KeH5GxVGeZkuEbzB+LXO7K3Tj9Q5rHty+RBiQ7I4vsEQdgyiX9ouDsnP1i+R6w2c+56tSP8uwoury4rjTNbOW5ePRY45IxFfHlQH3yVgvYn4le7ooTcPngGdBnT0tzDQkJhUPdttFP6DWFJSS0YcEJtRlIBzGRWLQ6IniXGN9OyRsEuWzo+10AnSdGC/19LxUp+ZfTstYabGSvZSD6Nmk4cl8UMhvyoqPJ3vIBXu1G5MM56mEtRKpz88KaOB/PLsmZOnuCUxiaz1thI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVk4a2xTNGk0RGliOUs5Y0cwTElvRnBiaUhQWGJsVnpsRzNjTUgrNkxmTFMx?=
 =?utf-8?B?SWhIUUd4SUN2dG1DWWhXckVNb0RxYTJYSnNMd1JDUlhCWUJETEVQWUgvUDNQ?=
 =?utf-8?B?L2VPV2RCV20wVHhjTGpOVTNydjBCWW9LSThzMzNqMjQ1TUJYbk5iSjg4ZitV?=
 =?utf-8?B?NmpLME0vd2tUcHJRRGlvZHRTcVVPL2dTa01JaENKL3RxNURyem5xdEZzeTBY?=
 =?utf-8?B?VEkrZjFKRzVoZ0tXb2xsS0lPbXlWK0N2U2VKUmNMRXNWbHVBcisyTUswaGhD?=
 =?utf-8?B?Rjc0SUF3MXlqOGNEY0dLaVgzb1lZbm9wcTEyKzlxZTJmeUFTUUZzR1JjdWxa?=
 =?utf-8?B?bWRuNFdLMHppdU9BQTdwQ21hNUlONUc2Y3J2YjgyVWdTRjJabkRiOGFZMGRr?=
 =?utf-8?B?VCtmTGtEZkZDemp0M0J0emhYaGo4WHdQVXpsOUR0UEllTUZMNlV2cmVld2dN?=
 =?utf-8?B?eERjN2Mvbkk4NzJYQVVtbTZKVFNyNUFxSmxJWDdKQ0J2OWZKVkh1SkxYcGNo?=
 =?utf-8?B?VXhaa3lsN1lzWFNYWklQUUZubW5TbHpWb0RlTE1KR0orLzJFSTh0ZHpiVThn?=
 =?utf-8?B?R3gxSGZ5YTlRRGRnQUlvOXZOWVd1aEdFQUJ3MDFsS0NTMml3dDFQNG1QRTVV?=
 =?utf-8?B?WlN1eVo1eGUxMDFuZFBmTWN5UzRVbW1IZS84dTIyY1pVck9tenhqM0pRSWV3?=
 =?utf-8?B?VVlYdE5qeUZsRkU0ZzY5cGVzN2xYRFlFU2lBNTlQSjduRGZIWEhoa1AyMHU0?=
 =?utf-8?B?YTIwa0tmUXZWbCtPWkprL2NCK3Q1aCtVaTd4eEsyNFV3ekNPRGNkYnd3SGhZ?=
 =?utf-8?B?M3k5SzE1SnVocnVyQUc5L0JIVCtWRTc5Y01WU1duR0w0dmVZNUJDUFUyZVVO?=
 =?utf-8?B?UFFIQXJ4aVRwUG13QzBUYlBVb0pTN3dwd1ZzMFdqbmo0Tld3Q2lFTTlIc0lO?=
 =?utf-8?B?RjlrZklOS0VBbUlRdXBrbHQwWFdPMC9uYTJuSHdIcUlWbzNmSWg3WEFQRVhF?=
 =?utf-8?B?YTFkck9FWmVpbW05U3hsQ1JaRVVtQmM2NENzRnB4MkF3YnE2eloyTnVySXln?=
 =?utf-8?B?NGNsTkJpN1M3NlNqQWtiOXNxbGJ4RTYvSFJ6YWtTQ2dSOHFhTnUwaitsR3BD?=
 =?utf-8?B?L25YMk4yUTczNE9CZHB0YlF4c0wzQXc2dGhxUW9sT2dTWnpKeDhZNzBHdlN6?=
 =?utf-8?B?Rnlhd203aWN4TDlERWRGeVlqMHIwNnN5QzRIMzNnQUR3WVZ6RTFScC9KUUwz?=
 =?utf-8?B?SkhhSHBVa3F4MEpRQVZFOTBmOXBVWHVTSGdJbGkyWi9DbHo5VDlCZm1TRTRU?=
 =?utf-8?B?ZUlDVjkzS3lzZkRWeWVocDZ0L3RnbHZ6dnhuaFpkU0JTZnlLZTZrNUJDVG16?=
 =?utf-8?B?VW9qeFRydmYwU2V0Sjc4T1cvR2VzMkJ0cW1QTFkxdCtDM28yVWdOOWE1aHpO?=
 =?utf-8?B?bys3aVgvZ0Z4OVovRUtqcmN5eVVlL1ZXRHphWHdVMFJlNVVFRlI4NUVLT2ln?=
 =?utf-8?B?VFVmSTR4REhYT2s4elBtVU1pSmU3QnlQd3NiNUhSdllDSkVUU3lQdUlkL2Uv?=
 =?utf-8?B?dGtnTVV4RTQ3akJRbWFuVEhBaTdhZkNNb2dXbnRpVFpJVWREbS9KUmwzelNp?=
 =?utf-8?B?WVlyclRyM0d4VCtscXBhdjAyd2hDdmxvNDBSVDArdC9UczR2MGlTZ2x0NWdT?=
 =?utf-8?B?R3NJZTBOc3pUQnV5bjB6VFpQbTBaMHI0QnlUUWdHRWFycm1Ba0Y5S0tMMytF?=
 =?utf-8?B?MEVhZ2NaWkVNdTVFNXF4OG1NcFZWeTRKQnNnaDlCTU1vSmhFTEthWTJJaGFU?=
 =?utf-8?B?eGNTcExmeFM3L0d2YnhZd3FqWlYyaitIMEl5Z0tjcXYwQXRudnVYMU5lUVdD?=
 =?utf-8?B?TDBQZTNFM3cwYUdPMWd5OFBwaGI5bVhPSktsYTRBaVN6QzhqamFOM0xVQ3pU?=
 =?utf-8?B?NVJiSWZQeUhHSEw5UERmMW01RlZCcTVVSEppTzRNRzNFOC8xak11aXozRFpR?=
 =?utf-8?B?dm5lOFJCQlhWUXJGVGR2SjU2TnFNUXFOL3RjVW9pNlMzM0loS1VjVE92MnRL?=
 =?utf-8?B?ZzZHejMwWENMUk9ZNHY3bjFlRkFvQ2RSTS9ZZmc5UWFzUGo5YU1vK3UvS0R6?=
 =?utf-8?B?eXZJdXZNZ243ZWRBYVBJdDc0ejRZY0ZXcHphYjV6WjdsekVHNlNKZlNWelJF?=
 =?utf-8?B?Y2w5R1VTVEc3bER3OHppYzFnUGF5V0plY0tORCtiZGo2YytIQkFldWVkcFNm?=
 =?utf-8?B?WnA5QktqZHJuSFMwTytOaFlKWi9RUXYwOGdyQVU4Rnk0Nk5JbjBrUkpVOGtF?=
 =?utf-8?B?WDNQekpsUWZkTUt6Q3FJdWZjZkJaMGMrOE0xTkJMeTFOME1qTEVnUT09?=
X-Exchange-RoutingPolicyChecked: eLLj0J5G3QaRpBpbucS2xfmZMz16xNSsTSEl2OakND6rBHkH98c5CAbdM9RqgMMGVQBQ7rVyRDKfJbIO7OEnGKGGDNFlv5hq7T/u0bQLhVvSGhSWEpI94hZqKpNuq/rmwi6Ip4lw/8URzGe1zSNGUGVAmi02dP4aGesi0kl4WbaqTCyimv32kSiaotIUhMLGkJ6fqxhKgvcXbBxOR9IrIt+g2O4a7U9rwSfCj+InJBOQ5UsU7Nn0TbEHnxCmVfZ/qM95vauH0kmk5kbYfflc65x+cmjVmNdlEdtCba7+kjmSgDu3A9IEe35IYa/Pssya7Y5bhwWbsd5tZLqvEb3ySQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb9fdbb-2c4f-4ab2-23d0-08df14eac4c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:37:47.1147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8K4ZusHw7OeFtEkmHgUSKo95VG/7DKaFtjqv4TyjVH7aMgzO2irhd5FXWNtAitDq53oi+X9NthikwpHkioXIyJi0kg5ltZbAkc9p1u1tPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB968400
X-OriginatorOrg: intel.com

On 9/17/2026 10:52 AM, Sohil Mehta wrote:
> 
> TL;dr: Should there be a revision_is_safe() check during
> __apply_microcode()?
> 
> The patch only adds the revision check during blob selection. Have we
> evaluated the corner cases hinted by sashiko when this check might be
> bypassed? It talks about suspend/resume and the CPU hotplug cases.
> 
> v1:
> https://sashiko.dev/#/patchset/20260901231634.714144-1-chang.seok.bae%40intel.com?part=1
> 
> v3:
> https://sashiko.dev/#/patchset/20260916225939.1144524-1-chang.seok.bae%40intel.com?part=1
> 
> The suspend/resume path probably doesn't matter for GNR servers and most
> of the CPU hotplug flows also seem to be covered. But, what about ucode
> update on cores that are not enabled at boot? If there are brought
> online later, would the ucode update skip the above check?
> 
> For example, maxcpus=N prevents certain CPUs from showing up in
> cpus_booted_once_mask. So the checks in setup_cpus() during late-loading
> would not catch them. IIUC, the BIOS version can be < 0x1000405, early
> load can bump the booted cpus to 0x1000405, and then late-loading can
> load newer versions and only cache the latest ucode revision.

Currently, what setup_cpus() does as its comment says is first ensure 
all CPUs that are present and has been booted up have their primary 
threads online. It just allows its secondary thread offline with nosmt. 
I don't think the current logic is broken there.

Then, those sibling threads assuming late-loading while soft-offlined 
will see an updated revision on its bringup because the loading scope is 
per-core by default, meaning the update performed by the primary thread 
also applies to its sibling.

Also, the NMI stop-machine rendezvous includes those soft-offlined CPUs. 
They are brought into the rendezvous and wait there while the update is 
being performed.

Now, I think it could be misleading if we put the revision check toward 
the end right before the application.

For example, suppose a multi-blob image that is bundled with revision 
0x1000405 and later ones and currently running < 0x1000405. With the 
check during blob selection, the parser can identify 0x1000405 as the 
loadable revision and reject later revisions.

If we move the check to just before application, the parser may instead 
select a revision newer than 0x1000405. The application would then be 
rejected, and the same blob would be selected again on the next attempt, 
resulting in the loading process repeatedly aborting without ever making 
progress.

So the revision check needs to remain part of blob selection, where it 
can affect which revision is considered loadable, rather than being only 
an application-time check.

Thanks,
Chang
