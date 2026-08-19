Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030953CB2F6
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118856; cv=fail; b=YW7dHfbmNn2ULun0a2Xb7po7nH/EWc77MMAXstbTo687U39H51SjdBBHnTm+S+uuwANjY9mdc0cFaX+rdzXQq0eSDDKDuOk45IYJ1vyEH3LW0sC1PSvyT/MVXLMDZVQBiKcNqygVU1ibdZKHk6AymeBgdZ0Hg5ACpsM3ZNPN23k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118856; c=relaxed/simple;
	bh=XWYm2PVwYUeLKXOq/ay6zA9BkyKZDMnm9INbkvbHAqM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDdsTSurSuzuIMR7MLhdLrJWH1y5bgsyoJU289aCFixC3mhS+f1QSeeq5VH1L8lRrHTg+g9NsLdsVhSNsrBeB2tHU4nLuyAQAWut8KJrMOcSkyDT4xn56D4PqSEiT2NtOo6k3gN7GDKlaLxmEZ0L4h5ny0/nBCHjrGlbjGLi28o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3gCd3K8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3gCd3K8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787118855; x=1818654855;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWYm2PVwYUeLKXOq/ay6zA9BkyKZDMnm9INbkvbHAqM=;
  b=S3gCd3K8Ie3w6ymLVh8rBmMyeJbn+cWPla/Fu/gfVEiH9AqZQw9X8C7K
   wy1NM+VAXL8IWyw+OLQt89ENzLMeX3eMv4e95KZxo20xRdcPIt+gbhtDb
   MUEzJ8tVgJgbfTZaO6A2xPHq/HiEfVmviUMqxnn4ed5M8J5SDxO6+SJit
   OwNGTelDbOEz0nIMBGjweafOXVWmexez2VUAXLNL0m0gFWfWHLh4nlRSf
   5lgVwR2+SgidrgNX4gHmo25RQtxw2t2/OfrOu8XDfIuvQAIcETOr5YK4O
   k48xjOQSIdbDv9OsSNxxtiVJJXksNxWnT5W/3d4K6g7OOijz5y/9omgzu
   g==;
X-CSE-ConnectionGUID: 7xDsFgc7SUWAC638WvzpHQ==
X-CSE-MsgGUID: ZCuswoM2SES2BpDiKyPx0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98779431"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98779431"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:54:15 -0700
X-CSE-ConnectionGUID: IXfC54hoTpGMs2rZeJFPTg==
X-CSE-MsgGUID: iTytKmYYTH6pzWkPMBRatQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="263708288"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:54:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:54:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 22:54:13 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 22:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP92USUfJRIZB3Qdh3TWROswPPVJ+x1Qi6cSNTs85MeFQ6TdOkVa5UYVzyD0nyVGoRwDd81rbTfidDwihF//DlXWlWcOsS0hLuogHJ1neErCsKZOjUSU6EI9J5HkvmLfiTJBrxKAkxfNEPh+2a1HaLVh0dIhZ0880DbKY5goRu+0Vcy27AeiiL5MgLzCiRXRasSj3cS+2zCM8DvTK4egjsoFQ2IzCcf+4AdIsh8LQcqNsEzytfiA6JGr201WCOlMa/1CXqZcDYBBa40fgFU+F7b4Iu5rBNhO/Y02a3Y1ShVcyt8bMqjUhlqw+gkvsOhsed8ABE6BuUFMUscyN3x2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjjR0vOoRY8H+3geKdgDds+9WltJQZsdt20k7AArQbs=;
 b=BxlpaULYWbK/BoO62PfUhQUwTuPrGkVrbfhO9UFuSRX0GiRpxd3+kE/cVUNGCTz612WNb/elCiIaI0b+lwwu/SsHY2Dqeq0dT9E3IA8JxUQ4aJysayFUQS2VZIKMtzHWIElgoeExxNOjZUXVj5Lh2sXh372FgL8s2H+CrtIsKeKamD4hrAi+5SWihuQ9GqUmsAefkAHptcXfCtZo5Jl2YkprqCCHxF7AnKEojCKAmbqwh/LJnvxDcR+3gEfRsPmtFbAlKV03zFiX0Pv5xOC6Em+GQudbA1iD5OJfu7WiMivZ9gODoGCvskov/4JBDFhLbs4xY8Td24UeRN9ljF/UdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5366.namprd11.prod.outlook.com (2603:10b6:208:31c::17)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 05:54:04 +0000
Received: from BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848]) by BL1PR11MB5366.namprd11.prod.outlook.com
 ([fe80::942f:90a0:fade:3848%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 05:54:04 +0000
Message-ID: <6fc4b515-77bc-4bae-bb6c-0294884eb991@intel.com>
Date: Wed, 19 Aug 2026 11:23:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe/guc: Skip CLEANUP message when GuC is stopped
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
References: <20260818040733.135964-1-varun.gupta@intel.com>
 <aoUCPYIDeBVhLg5l@gsse-cloud1.jf.intel.com>
 <aoUEP2RP/4kLySh+@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Gupta, Varun" <varun.gupta@intel.com>
In-Reply-To: <aoUEP2RP/4kLySh+@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0120.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::9) To BL1PR11MB5366.namprd11.prod.outlook.com
 (2603:10b6:208:31c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5366:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 968b3b46-f48c-4b80-9f4c-08defdb6462b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: nmjkWRmASm/mYKYhqLsxx4pfSYGoWWhK2dY/FNPaZwzCavdyfeW9vTWv/eN5Fu3n4hLBniSSammQgaYzuqaY1DVTjdJYIKmZB/Lm1HpXuw/85Sn5WLP8nhCBZOU3jlSxuOKCA6vpaR5Pkum1P78wLIumA5BqTMCN1p6/MHCqAhidm/JqvupZP9AyJBgJgj4CyDydb6ubbiNoyU7tC+tM41N2wqHs6qc31nVq6lTrR34d3of6gxsru1RWhZioHaXuRqJBN2UHZ1Bcrx3c7D4SOI9i3rOnEEHqtvUZVE+ZHAZbe72G/rjYVCELCdYikSdRi1rrNZZFQt9mHP3ILVXRoA50dm3eyq2PonqBXuMPEBLBy8sRCnQKaZrDtjAuHjlYP7sYxdJQGy+ECvlWWy96p2YZx2yTDKzCCjFUjN2Vkhj1qKd62q4qiXovXcUXsKIxNG+s3beteAXYmDKRityVpWfb+gSuFu6EN3khVEMIz00tPumXTgZWy8psU19xX+lR2rXeSNdCWNtUoBhVVTTqLHa6awQ72HMJoj9MsDvloyMZbOD3uOj43jpkBCzp8VjtV9rQDqw7hRIIptCowaf5TeQdwM3KLx2+P9omy3h4Rb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHI0SnNrRjY3RGY1WTVkRGxsWjZCaU1HYmNPbG5LSnhJL2tQMldVOVBkVHJp?=
 =?utf-8?B?M2huanNVeE9sWTNoMDFDeWlra0IyYTJ0N2JOWXhGWmdqWlZJRHR6bGR1ZDRC?=
 =?utf-8?B?Y3ZleEVZU1JBTlNLZUlDWTdRdzRKMTJjSmZrclZMNnVPbFkxbzVnYUJTMEtW?=
 =?utf-8?B?V21abE5RRVNzajZWUWM1b2NnNTdGOHkvY2VmVjlvM0xLbUJjbGFLNVFPNDlN?=
 =?utf-8?B?OU1VV2IvUjZRMUVkRUJ1Sk1ibTAvNXZpZGxoOU5sY3E4eUw2NnNNSkZQVFoy?=
 =?utf-8?B?a3pidHZFNE1lVHNuR092WlZVMStmbGlMTkR4RzBQVUJmOEFUQjFSc2NPVDZU?=
 =?utf-8?B?bEVmbWZjdGNoOWJIQ2F5dTZ2MGJTUFIvTVNDQnMzSEppV2pqT2h1My9xblFQ?=
 =?utf-8?B?cUNIMGl0WlVERmU3UWorYm5DUlh1LzZuWHBYWGlwQzllZnZKalpoTmNDL2pl?=
 =?utf-8?B?OTY4MjIxRHI2ZU81MHhaajI3UVV3d1pSd2NDTkZrTmN6SEtkdGdnYkJOeHp5?=
 =?utf-8?B?SnFVbHZSNjJOeW1uZHY0RmllalVYTTdqQW13b2RwdHpFMnBxOS94anVyU2lo?=
 =?utf-8?B?U0lWR0hoNnZoZGxOVTFCY09IYUxOek5GeDFxd1ZkeE5sWW1POHhKVFZzUW9O?=
 =?utf-8?B?UXY2akVFSStTWUF2dFZ3SE5hYWs4RkJYc1VWcFIwdi9PaEhyMmxVOUUxR0hu?=
 =?utf-8?B?alBkYVNmbkFyU25qNDAwMkRxZ3dXRXlVcGdnU2tMUThJb3pHZ2wxK1Z6NlE0?=
 =?utf-8?B?eGJ0SndJcmh5Zzdtano3aXNWdHNhcWQwb0M2Zm1Jc1gvNDN4NDB6ZWlubjY4?=
 =?utf-8?B?VmRjTDVQUTRDNGMzaUcvS3FxTjJIWWNTYXBaWDNEQXc1aXN4VWNMM29vLzJC?=
 =?utf-8?B?OWpkOFhORXdsMFFpclhDcVZZeUlRQnRoQklkVUNQUTYxaGV2c1hQdEhPcDJ1?=
 =?utf-8?B?VzRmTGc3RTlqRmF0MGhQWStkd1lZTTJ4UWx4UXhZSHJhMkUycmNXNSt4cVkx?=
 =?utf-8?B?cWhVOW9oNHZ0NUhVSlpsakhpMmpVVzVORlBydWNmK3M1WUJpSEc2SjROY2Za?=
 =?utf-8?B?bno0Uy9wNDh5emJDT2pVL0lQbDk1bWJZVTQ2QWllV2ViWlJZWEpFN3dCT3lW?=
 =?utf-8?B?YThEcEFoRWhlKzIxUXlLd1pBUE01UXUxUXdJQWs4QkFaR1l5TjRBS3ZQSk55?=
 =?utf-8?B?cUZkR0tmTVpvbUlndG16dDVRZ2p0Vll4YllNV1h2WW9KOGpTSk9FU25KTS96?=
 =?utf-8?B?QWhzRzBZbXh6clRrYURmNFBjRTMzR2p6NlY1UmhWeDRrbHRlVG1XQTcrL3Vv?=
 =?utf-8?B?amVGOElNb21PcjNZOUcrWDAvM0FSSjJOWVV1cTRjL3ZpU3JTYmtMeW9velJp?=
 =?utf-8?B?SURTdGVXclNlMjNid1dJd2lJRG1PT1ZpNDdwUEpSamJITlNGcUpxM1d6YXov?=
 =?utf-8?B?Zk5wMTZ6VktWSmN2L0s1NkJkK1JiS2ZtcExBbjJQMUFLcjArSE1JL25WNXhy?=
 =?utf-8?B?S0EzTzlNNllmYVppM2ZyYnM2NGs3WWlSN2FQVnhZTXZCSTdlaUhZdGo2S3Ru?=
 =?utf-8?B?b1pwV0VGSmwxT1BPTWpCaUc2c0tYRExjZjZUSGZPSHY1YTNKdWJ0dmhkSnBu?=
 =?utf-8?B?bUhXNEx6T0ozUzVrVlBZaUtsL05lN2ovWWsybkRuemJVaVZSNjFtdVF5YVho?=
 =?utf-8?B?OVJzbTZ4cFJ0MVdQazIzcXdhSUdUMmVNMWFRcmRsU3I1US9PL2dIWk94LzZw?=
 =?utf-8?B?STZ1TWxZdkZJVTdCWGg5U0MyN3RXbnRpUGE1SFlBckI3VlBPd1NMV2ZKNk0z?=
 =?utf-8?B?cVk0RGNJNXBra2w2eG83eVIyeTZmM2Z3bHMyUmlUSVNCNkhydlBnYUJqc1FP?=
 =?utf-8?B?S0xlK2o1bXZML2NxU2hZa3loWGppaW1QdFJNcnkxOC9XdmVBRWNxRms2dkNM?=
 =?utf-8?B?QXg2eVVHdXo3WHhKdGE3bUl2ZUxzU29qMVEyRFZPV0s0TURjUy9KQ2RHUjNI?=
 =?utf-8?B?YWFlOHlPbHdkdEZLZmZzaitheGVHcjdSeHZ0c25IUlNkSWJOamRaclZGbGdh?=
 =?utf-8?B?QmMvcEdBZmhvSFJSa3c2MVF4UUd2c0tkSk8zMEpmRE1IMk1mRG5IVG4xcTdu?=
 =?utf-8?B?Vk5UL2UzbzYrYVZyREVzcEsvY3k0TGJEVVNRZDFDaHU2blJXVzVMSEpVNkVQ?=
 =?utf-8?B?SmpQbjdRaXNvam5KbGJxeDJDWGJzWktnNysyZUtuK1dFTHNsKzNoUkdSYmRW?=
 =?utf-8?B?OW5BSVI3U1R2UXk1L2k5VXBEbTRDbnhENmJaekRkMkVqZCtkdGNGWk1pSEdV?=
 =?utf-8?B?cVRlcytjNlIremRkL25uUDZ2bWNNZlREQmtkcG43SzVrMXdxR2lndz09?=
X-Exchange-RoutingPolicyChecked: ZfXcwUC5wMpaBZ2UpFCHPIRRHk7vg1y2ifLFOXSvwhC+q+fV4el1gLADjXfZ6u07HgkXiIthRawy3XuK18biNmqEu/Z5Z04QP55zdqDrDnQ3gA8DnMXEXWeODRNZC+YFgpLK8D0ix5d9unMq4/uMHSQNm/za6ALEwg3RSYZmJC9smWaVf3yq1Nw0aqJR3XCGxhW/8FZ+jxevxwNuIVeHqAiPar3cUoJ82nKYRYFHBDerJjnsUM45ii/jpTxJFmZCqXdc0d76KbwuFr4c07CCJ+aSZb7PiyEhI9y9Z/gN9Cbl/a4HEi8nwVGnZaSH1hx21Kn4n+7NbiXmxohjKpm5ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: 968b3b46-f48c-4b80-9f4c-08defdb6462b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 05:54:03.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSnPFBnpIcxzfvbzhT5IGlbXcn7Kgwcu9BMbbD5cisrrMxcE3GD3kBoArl0AgJ/XPAaiakPF37q7+R9C6U0AZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
X-OriginatorOrg: intel.com


On 19-Aug-26 6:47 AM, Matthew Brost wrote:
> On Tue, Aug 18, 2026 at 06:09:17PM -0700, Matthew Brost wrote:
>> On Tue, Aug 18, 2026 at 09:37:33AM +0530, Varun Gupta wrote:
>>> Attempting to enqueue a CLEANUP message while the GuC is stopped
>> I think we going in the opposit direction - always send a cleanup
>> message:
>>
>> https://patchwork.freedesktop.org/series/171989/

Thanks for the review, Matt. Yes, after sending this patch, got to know 
about
Nitin's series and it makes sense to go in that direction.

I have tested his series and it also resolves the issue I was debugging.
So this patch is no longer needed.

>>> (during a device reset or suspend) triggers a missing outer runtime
>>> PM protection warning in xe_pm_runtime_get_noresume().
>>>
>> Hmm, do you have stack trace? You shouldn't be possible to get to
>> CLEANUP code without a PM reference.
>>
>> Matt
Here's the trace:

[492170.003812] -----{}{}{}{}{}{}[ cut here ]{}{}{}{}{}{}-----
[492170.003815] pci 0000:63:00.0: [drm] Missing outer runtime PM protection
[492170.003840] WARNING: CPU: 85 PID: 2788391 at 
drivers/gpu/drm/xe/xe_pm.c:773
xe_pm_runtime_get_noresume+0x93/0xc0 [xe]
[492170.003985] RIP: 0010:xe_pm_runtime_get_noresume+0x93/0xc0 [xe]
[492170.004064] Call Trace:
[492170.004064] guc_exec_queue_add_msg+0x26/0xf0 [xe]
[492170.004133] guc_exec_queue_destroy+0x45/0x60 [xe]
[492170.004197] xe_exec_queue_destroy+0x159/0x200 [xe]
[492170.004255] xe_file_close+0xd0/0x1f0 [xe]
[492170.004318] drm_file_free+0x23d/0x2d0
[492170.004321] drm_release_noglobal+0x63/0xd0
[492170.004322] __fput+0xea/0x2d0
[492170.004325] ____fput+0x15/0x20
[492170.004326] task_work_run+0x5f/0xa0
[492170.004329] do_exit+0x1f4/0x460
[492170.004331] do_group_exit+0x2d/0xb0
[492170.004332] __x64_sys_exit_group+0x18/0x20
>>> Since the GuC cannot service Command Transport (CT) requests while
>>> stopped, skip the message and route directly to local teardown.
>>>
>>> Fixes: d930c19fdff3 ("drm/xe: Build PM into GuC CT layer")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
>>> ---
>>>   drivers/gpu/drm/xe/xe_guc_submit.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> index 9036f89dff7d..24f35b0179e1 100644
>>> --- a/drivers/gpu/drm/xe/xe_guc_submit.c
>>> +++ b/drivers/gpu/drm/xe/xe_guc_submit.c
>>> @@ -2180,12 +2180,14 @@ static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
>>>   #define STATIC_MSG_CGP_SYNC	3
>>>   static void guc_exec_queue_destroy(struct xe_exec_queue *q)
>>>   {
>>> +	struct xe_guc *guc = exec_queue_to_guc(q);
>>>   	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_CLEANUP;
>>>   
>>> -	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q))
>>> +	if (!(q->flags & EXEC_QUEUE_FLAG_PERMANENT) && !exec_queue_wedged(q) &&
>>> +	    !xe_guc_read_stopped(guc))
> This would break VF migration too as we do global stop / starts while
> the GuC is still holding a ref to the exec queue and do not both away
> the GuC state.
>
> Matt
Oh, thanks for this, good to know for future references
>>>   		guc_exec_queue_add_msg(q, msg, CLEANUP);
>>>   	else
>>> -		__guc_exec_queue_destroy(exec_queue_to_guc(q), q);
>>> +		__guc_exec_queue_destroy(guc, q);
>>>   }
>>>   
>>>   static int guc_exec_queue_set_priority(struct xe_exec_queue *q,
>>> -- 
>>> 2.43.0
>>>
