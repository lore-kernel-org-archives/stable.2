Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8063A1A54;
	Thu, 23 Jul 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835910; cv=fail; b=qCKRIpfbBaVLDaehZABLlFq5YK5nN3hhSg/ptNiGZeGA9GO8mlMaSFIGBnjbWlxC4+rwRPB2n5qIae5XQbsnjnOJgX8KY3LitGTcO3GosY5z9UGEnKq5LIgnSK1Y3YI4uIHglq9apWSs7xRnZLUEjAAJ40U3OgDOlr0V/PXTzWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835910; c=relaxed/simple;
	bh=ur87wMurov2zXDZJ7OFiz1cFhirkFaZsVh1P0IM7d+c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YlR/UjfKlenyw3/WaPRm3eVLaLLwrRVnpjxYvNPQ8LprfWEplYni/K8l9G3lP1NaKn1my73OshO3yGN2XWtBI1WnJhM1JcuTEWforYZD+/hwafVjwcvu+e/A7j3qQZODjcpjDKGTYug/YGeSM9yyyHczydj4X2vov4gvyIGlF5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQgkI48d; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQgkI48d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784835905; x=1816371905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ur87wMurov2zXDZJ7OFiz1cFhirkFaZsVh1P0IM7d+c=;
  b=PQgkI48dSCGA0GxkHLjB3PPtgQdC6qZ398Ecwy6KyLmGWSPyhiN6DiMV
   YwlKyfk9kRElO1qHNWhvAmCDD2OZUykTGmYOhkxM8ektgnW+C4w/0KPS8
   o5t1+IJwQFNxQpFC1aK0iPMtorVE07QdHbZRnWSRFppnseJpUXgHeeh43
   EwO73jtX6+QeyVf0ocTgS+qgkVFI+OBAtD8hcSA0+zngY3I/3QB8TPwaU
   iUt84ITfqDgxvuZsFhPIagTs7/SIbEmwP9FawSXcX+QP3RkRGiZC5ZM5q
   xRknT+uN9YhkLFOQFWJqWyzH9lK7SgsEbjIR55DkSZd83fxE3Kp6PIc3s
   A==;
X-CSE-ConnectionGUID: sXy6Vnw2Q8GTdCz2BCiLAQ==
X-CSE-MsgGUID: k7SdPKV9SE+qSN8vUvkzjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96092537"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="96092537"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 12:44:47 -0700
X-CSE-ConnectionGUID: Orc6zESjQl2tK7keZXt6ng==
X-CSE-MsgGUID: Uyy1//2IRxmiRmWd1LLX7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="262039217"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 12:44:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 12:44:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 12:44:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 12:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGMAo48BWCgYOYKzWbf1i38rjq2lCGRocCP2SZkvSBKFRkd4qAUySKfxy7DXn9Ur4BF3rDEXMn0GxqAnV2kYk/V3hcDdieY4ts7wYCOEGK6At6Xoaq2VI/MZmFHqPmm0cEfiyRXhK1uCHcWgRv0VDv0QeugyQ/99uLGTiBT3i0p9W8OCmB9YLHtTL4e+ZKCs/c+AE/zUrlw0iTdOf4pLbCsn0AVdDvVLStgs2KsuJzifyhFdz500mZ60YHft8MTOr8JbooR+hlCnvw1E8fRxHWDkQd5gYP8i0+G5FTgDb73pRpfEkhrKK92HGsB1YfwqRMOdyncPkUNrxxNDOpJ7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjecUWWfrg/pL6fhL+/dAqoaxFkVzdOHGdxrw1pnBdQ=;
 b=sgpu6jFr1mge4aNvi7mGxD2Yj0GnyO8kGzyAVtrMmgvKlYXh942q02rOsJom6pYu7J6Zf7odAB80I3QyIrze5Xbp2pAJOlktcr/5279dPHkKHb60vesVCxTd83yVaaC1PEXBXUcIqprrKEFHiXnC587dLhWDTUU9fG9DntUf3dTbLis59DiUv6lmY8tTeYyAYbpWJ9CdUbdLdibaHLPHUNHXnTt3gg+heg0Kflv5irCqBwlMHHZJkHRogsj2QrIWt1jnp9Qu66mEZB3p4A3FXJXIXnb/YqH8ix2pDy+R9w6Eq5rpG1fsGk/khArhmKtgoW9UXIKq6SgmyCUZ6sK4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 PH7PR11MB6332.namprd11.prod.outlook.com (2603:10b6:510:1fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 19:44:39 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 19:44:39 +0000
Message-ID: <52cd5021-0290-401e-85d8-bdff0d07a9f7@intel.com>
Date: Thu, 23 Jul 2026 12:44:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: x86: Remove AMX-TF32 enumeration
To: Sean Christopherson <seanjc@google.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<pbonzini@redhat.com>, <stable@vger.kernel.org>, Zhao Liu
	<zhao1.liu@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>
References: <20260720205208.519622-1-chang.seok.bae@intel.com>
 <amJXsVGv3xe7GKu1@google.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <amJXsVGv3xe7GKu1@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::6) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|PH7PR11MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: b667d247-48cd-4640-9639-08dee8f2d52f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: uLPJppjqtIHAE+uzsdSeEGpgJF7gmyUk8BKUMz0d6JflBy4q3JL9ZyDTGYPVmT2lq1t5RWCsT0MrjzIsemU90t3OL0ieL2IzSEeGAnxZJz30nbXeEOcucCLEpmSDnM5T5492PfpiD2pBgZIgUteZtYtBtnpIBgYHuG3YsTsEXmnMmTKLRbeaAKYEhnApKyj34g5jnNs7nUqLwBFOLwUk3luN4q8h9r8wDbqsTvemCn+T+PPkcKIDcFHnJKl/sQagi/Ut1n5p3iolYr2Tinozpq7RGJE45LVM6ODQIHJl+jr/Vktivl8WZ69jbrRSB5Ey+9DMcC7LyBitbXDmdKyZCLdvSqJJvBqBxuynNy3ip+fpzAiHQBQ9PzIZAyZEUqES7JCCme3WrubfwZpoU5+5voI9VFrw10xxF+tzIHbBMMe8U4rM5GETcZgYjk8GEf/ECVgzUN8TIX2Qu24jkTcbMwXWQ/bt0Yj5Iw26LF+9YbRAZAKbKE4OckTNsETwIGrrk3G+L5b6xb7tcclDJOCZInwcsKLAfptJVbp+oTuuC9xSZYUshHZIyXS6v702flYfg4GpZrxf6YF1OrAd9kkFLdAbRqnk6esyK0vB0qgM4VGaSdfGqm5wMzUtEvnP14b4BeyRvUkBp2lbQGyp9XIXwU0GUmNaNF/g3rWvEjKhU7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWpKekR2NTFGYzFnU21sL2JrM3NWMkJKTzJUOWVWdzlqblYxanRMOGhHdGJX?=
 =?utf-8?B?d0tsUi9qR1RoeWFLamNnaVVqRnU3NFZiVzd2L3piK2VyRVhhbm4rdXg5UGdt?=
 =?utf-8?B?VHY5UitOU1d6c3R6STVuZytUQlJ3YXhmNzF2NEFUY2tnQS9yYjRWT3A3djJU?=
 =?utf-8?B?QzNVUWFFUFpDRllua3pETnFvdEhkVkZ3bzBtL3VlR1ByZHI0cmpjOGY1U2Vv?=
 =?utf-8?B?cmlLSUN1M1daclRObFREQ2hrM2l6TkRCUkc2NkpDWm9velRQWTUya3ZJbzRi?=
 =?utf-8?B?STRQVThtZ2RsWS9xaUVqZURWTzNGc3lUNDc4QzFNWDFHNzd3KzA5blJxRVM0?=
 =?utf-8?B?ZkxpTEJkcVc1ZE9QYVB5SU15Q2VHNVNVY1FjK0FMbTZnU1JETDAzREFqeWlU?=
 =?utf-8?B?Q2QzMTNFMGt4OHBmUzVkQncxYTR3cVY1cUN0ZVdwcGNJcjR3UllnY2VxV2Fo?=
 =?utf-8?B?cTFvbXdZczNiaE5hZ0pVenBmeWwwZ0x4bUJvYTltZlZiZ1p4RFhQRU9vTWl4?=
 =?utf-8?B?K2xwVmxiajRKeDdkY2RzRTVhTVd6VllJcmJyNjRtemVjdnpUVGV2cXp1Q0g0?=
 =?utf-8?B?NlMwK1NHcHF3bE1nOTEvZjNZZkFnZm12K1RCTmx0VURydmNWVTd4R212NzJW?=
 =?utf-8?B?M3dDZ1QzY2UvYkhwSlhOY0c3TzIxQmFrWElQeDJxZ3Y3L05ISENMYjdmdE5k?=
 =?utf-8?B?S0RuQTh6Z2VGc25HZzNINm42YUdwcW5KOEsvS01DVkJJaUVFVWJLbHloRXFh?=
 =?utf-8?B?MGZFL3ZXaXpQdVEwbSs5b3VCTkxXQ3J2ejRkRUtqU1h5Z1Q1RW5VUlVhRDAv?=
 =?utf-8?B?Y1pHbkNjQTdvSmxyVk16dmliMFJWZmJoc0ZwdzFnTjRRZDJNamNDajFjKzQ2?=
 =?utf-8?B?d3N4aWh2Skk3RlluaUxRcnViMGlwOVBUa3N2QTJMd2Y1Qkg1UjhvNURlMlFq?=
 =?utf-8?B?ZnVUdmRiVTFCVXZxRVl2WHoydWhJdEp1RGlvUFdMWDRNckpoSkdvdUN1dUc4?=
 =?utf-8?B?ZFVNS2pPV3BnTWxRaXoybWtlVTloTWs3eFZuVW9LSlZQbDFFcVE0VkJXd0M5?=
 =?utf-8?B?ZjRPM0JLbTBwbUtHMkxzZnA1WUQzTitsbW8rTEFaYmZDYnRYMldTclRtMXlF?=
 =?utf-8?B?TEtYUzk1MGZmVnBmQlpWVXhHVHpmVzEwYS9oN0R4NWp3d2E1SURGWno0ZUhT?=
 =?utf-8?B?dnpoOCsvMUx6bXVCY1prZ28xbTB4M0E5RDN3VW9FZmRWVVB5OE0zRkt1dlFt?=
 =?utf-8?B?eFVGSFBoZG94QVFrQkwzeFJXTnROM1YvTm91T1NyZVNjQnZ5RUlJTkdOMWZW?=
 =?utf-8?B?VTR1UVVTbklzenJ4SjJMbVQ1cERFWUNNb2NJbW9JNndyVzVLQnBDZ0lQZVNN?=
 =?utf-8?B?akhLMVRsSmI1TUNQcWhlMnlhcElTWjVLRmxxeDhxMDloejlJQUl5Sk5ocStr?=
 =?utf-8?B?bkZ3RThmQlVydzdsbEx6UlJ0S3NXTTcwSVZZQ2xPM3lUcEMvMjJOeUNxL1pK?=
 =?utf-8?B?Qk5Tc1hMVGFJTjNqVm1rVFdkQitWcVVET2xyQ3BRRmM4ZXZNTGxtUDFTWks5?=
 =?utf-8?B?bkZkdmsxU2pvb1JRZzU3VUNmL0djN3huWnR5RUhicGFlRjY0UFZ1SGt4UmZx?=
 =?utf-8?B?bDU5OWdHYTgyRzEwZThXbDdsak10RGVSM1VoV3BmOXo4Yk1Gam1GUVd6RkJm?=
 =?utf-8?B?ZTBuSmhKVjRCRlUrckwwcXJ1MUc4Y0h0YWpKb2NLY0dEaVdMTjRuZG5tVk96?=
 =?utf-8?B?bXdwK1BIeWM1SlJlc2xPUU1YVWRjVVYwOGR2bkpiMnMzYUJaKzltR0l2MUgr?=
 =?utf-8?B?RnZWbnpzcG8waTY1ekVVZFl5U3pxOC8zZ2pHWURNQkd4RGZpQlluWGR1WlF3?=
 =?utf-8?B?aDdWdHBFbE1SbGJJM1k2Zm5JYmlndGNHVlJkbms3T3AyOWdMSzRScnBuYk0y?=
 =?utf-8?B?RWNoM1VvTFQ2UWFWbmdaMU90VG9qNlVPNE1zc3VEM2dkdHp2MWNlZ1c0Z1ZN?=
 =?utf-8?B?SmpWeUYrcEdnZmxoLzNnTGtDTXRkaUNUTFdBaG4xNmtPbEdQbDlreVZoU2Q5?=
 =?utf-8?B?ZTE1dUtqN1RPMTh0K1o4VTFmT1FiNEpVWTd1d09aVTNzWU55U2E4U094Vmw5?=
 =?utf-8?B?VHdYNDJzQlRuTi8yS3hZYjBZTWJjRHUwaHgxNEZ0Vit0MDRCdXlQa2NkVzNn?=
 =?utf-8?B?SjkyUEwzUThkTFZnWGJpYm91eCtXRmcwd0J6OVRBcGNydWM0ZGZ0M1lHbldj?=
 =?utf-8?B?R1A5bndyR20wTm53SnlqeExBWTQxWC9rS2J2dVVGYVBsZGs0MDhOWUlSY3N2?=
 =?utf-8?B?TmhSME1HQWVqam0xelVtYXRRTEdoYUdzb0MxU3A2MmU3NFVuY3NYeHJiVFVJ?=
 =?utf-8?Q?hUiJZv51VY2Zt1XY=3D?=
X-Exchange-RoutingPolicyChecked: ZBcrwj/3qyNLZ+FYtefUdQT2wrDTaOs2cyxF4fecmDuV8DAaJRTYD/82easFjYV9iarmxWV1AnAo8aS6GWCeAXu5+9eAdqSXYYB2V6TQAQqvEeWAFGp9ndufl/XzeZcJbIZg1BYSZC1kOH2jc4RxfYgFyYe3d8g5aWPZ2g4hwTj78ri7fTjxKX9L09W+8Hy88pRZDnpfszx3S+A+7OOCpdD66eOCUU8nVysQ06QTOZCek3ZXqUtEzibby21k/EJQFcFvlKx4Q/nOxPQ/jma7hy6Qr5V0P+XPd7kJRk+giyEGrUlQQrlIYgtMKAMjX+VB+l/uRkJZkE0wr1cH11Ai1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b667d247-48cd-4640-9639-08dee8f2d52f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:44:39.2936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LZR5/SuPBrbp2+xF0djNiy7qyO4TL2tOb8r4mUXEt/T9xsbI8KtQoWurijRZjIJBMYDG1q9F7NCa6USRJsENLyB8224R/+EDOR3L9xe/tI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6332
X-OriginatorOrg: intel.com

On 7/23/2026 11:04 AM, Sean Christopherson wrote:
> 
> I'm not convinced that yanking out support is the right move.  By publishing the
> feature, for several years, Intel pretty much burned that CPUID bit.  E.g. it's
> not impossible that someone other than Intel has implemented TF32 instructions.
> 
> The opcodes are fair game in the future, because their use can be qualified and
> guarded, but the same doesn't hold true for enumeration.  E.g. similar to how
> MPX got ripped out and its XSTATE assets got reused for APX, but the CPUID feature
> enumeration is forever reserved for MPX (I hope).
> 
> If the argument is that "Intel Architecture Instruction Set Extensions and Future
> Features" isn't binding documentation, i.e. that Intel can do take backs until a
> feature is documented in the SDM, then I honestly don't see any option but to
> refuse to accept new features until they land in the SDM.  Which I don't think
> any of us want.
One distinction I could think of is whether a feature ever ships in 
implementations. If a feature is actually implemented and is later 
deprecated or removed, then I agree the bit should remain reserved. That 
appears quite clear.

My understanding is that the revert was considered because TF32 never 
reached any implementation. If that's incorrect, I'd certainly welcome a 
correction. But if it holds true, then I also want to clarify the case 
is different from retiring a feature that was already in products.

That said though, I think you made a point. If new features are 
published there, we add support based on that, and are later asked to 
remove the support, it becomes harder to convince what level of 
stability the ISE doc can provide.

I don't think these decisions are made lightly. We humans may sometimes 
reconsider features before they ever ship. But cases like this 
inevitably damage the credibility. If this happens repeatedly, it 
becomes increasingly reasonable to take a more conservative approach -- 
perhaps even until there is hardware implementation at hand.

I'd relay this feedback to the relevant folks, as I do think this is an 
important point to consider. I'll cc you.

Thanks,
Chang



