Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794576479;
	b=MvMW7gqYinONh1O9TfqPmmgwlEAEKGXnYgw04VmYwwqY46WJ5YalO/BoWqQIsUTwdpjO
	 /5/A59rh1VSmTCFmCNF6lGgKgWF4mKW9FaF/qjeSIZmhaVJSd72YTPsms3mNXGYFn5hmC
	 XTVvHPGq9X2Zk9BD2mlv06UzBeQoNI8BrBpvJGhrfrsyLuyzwzR7XM686ZTTs8fvkMZnn
	 00QTtUwLCc685gsO4zjSI+TJc/KrHORVDeGUWoaP5qHVkXhwj8CrU86WD+mHAS9nlwoZq
	 PigmtDGOuuMHND9q7p/XKiyJMPdxpereJM6cuFZN09DJ5Gayd9xeVfCymjFxsg4UcWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0JAs3zexQJXgYml1Tv1WIITwZ1DxO06IEUVETmWFRm4=;
	b=ZuEmYdufPpZ7Vtavywa7I8W2ER3H9OYNcGEs5h3dJNwuJLAz8y3QVqcEB90E7SMT6Aee
	 oI+toCiVyF4lPWYxPS3ji9vv5dMmidAd0MguDo7OzeFzNS6MmWghlvnBaH6HdT4BANJdY
	 zPvb/T3e7GbZ0okDbGyGP4C76yFeFRmjdcfNX9wPl8+lcnn+F0YmK/bP9wFK5UXObDyCd
	 0qiTmjZ7ubunn6nsnultrpPfrC2xjV5iP2MnvrHxfyIAaL4KoT3xt1cxD8SmxguY5APR/
	 3xLrxJHrFkCmPn0OEN3t0JmfNvnWH4QQyHB6dlUv3vsd+2UoDyJvMVi9xD+qRgpGzCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I3Yz74fV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B160A2630;
	Fri, 13 Nov 2026 13:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC2B160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I3Yz74fV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGQYepR3492u9RTEoIh1xv9fZYIkvBnofOaaxj5aMjnSXUEzBucgWim5iKjvGntpkHG4e97nK84/WMWKtuxJGovW6wMJ3rxH8A7bsjMXqGch6JVLhZ9AS4d9p6zqKVWehR7Xz7CpoVWPAjxx7I8vQsOwxdzgzzgw+u+ubk12Jf2318t0cnXSPzAnXhHTEdHLw5a4b7/24Xrc74pqK/V4S+Cv2JmomKbQY9mpBH9ijKwc88IACG5RB1B/cptVWPZHZm9RZ5f6TJJr7d9PXLpltEkmejPm8c1lLduJDANTUlaIRvKa5YavfFc+fQYqaZtzEB+qvaau9Yw3/Em8Tou74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JAs3zexQJXgYml1Tv1WIITwZ1DxO06IEUVETmWFRm4=;
 b=qcTrowQFTFewuLYFv0DSKBqk9URYfWqVMy1N4XwUWVQ0NPt9fCb75+xJwUuK5GlxcpvNsuXczqCPCYtMJOA/DXfSYiwfHfnstaMa8mjiBtr8TY7cGFFk1XDbY7z2ccUnYJJY9uusQpsjNSVwPNgdMZ0Bm1+4D2Q/TlHZ4kS4UJVpvtuFLfe2tIqhsZAuRySQDTZ5oAkk6/ELl9vCsQJv1hhzosNmSwecViIcY88+zl1K8QWntLLSb8V4Ygeqm5CYdJsYvDA6fRvwWZUunI45ldG75Uozes9XqzSm0o9qlTpI+9Z5sB2VvYOeFrxc5xGCcSAzmmmaJ6PMxgIgz+ScZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JAs3zexQJXgYml1Tv1WIITwZ1DxO06IEUVETmWFRm4=;
 b=I3Yz74fVHTc4itA3mrzFxh6ipx0Wb10zvPhN3eK0zxapMf0yJ6qlSTBxXtW8Rw22vRm3XHAK5bwv/N7TVmzRZemBbn0zYf5wMwjFJTUKtWWg5Qo+tl5x4Df+lqMM5N5VcZKf25aAPfJRZ8PHLMcgz/QmPFlv+v9n5QHq02Ae73E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 13:27:56 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:27:56 +0000
Message-ID: <56bbcaaa-32ec-447b-a0c4-42305b80ed07@amd.com>
Date: Fri, 13 Nov 2026 18:57:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: "Guo, Wangyang" <wangyang.guo@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "Liang, Dan" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20261110174513.461743-1-Vishal.Badole@amd.com>
 <MW4PR11MB6982C90C849A81DBFEB95A7B92702@MW4PR11MB6982.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <MW4PR11MB6982C90C849A81DBFEB95A7B92702@MW4PR11MB6982.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0225.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::14) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 103ff7db-21d9-460e-7e35-08df4189ed5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IUI6TbHqSbSUaink90Q67hxQ08NJUgbLip2dn+F06UTE9OfY60Xltfd0MOz6sXK7e6AJAZFlnTHoGBCMuHIr6W4yNPQB3r/KOrwW15xJ+Ln7OqsJAQT9s7Rti0wBfxoi2Ug+RHGMeVotbO+hpFle6iNjNrb/5zf4bzwj9FxYUatGoqYgO9BNoKGD15QsS5D2m6QjtG81rczEVShvlzEvfBg+oY+iH0DbZRQm0we6x9NAYcOkmn04ovIukGxtn6d6aoenljLPgZ/qqmHXWpdtJOeegGGXT9Mu7hEbxx9RNjTULb5Ynd9cFEFLqkdKAHNju/E+I2S+9/wH4SVLE11XW1I/Klxu6woFc2qcyqXUKugzZwYpa30i45nw9fpL7SfocDAGLFFoJmmYxgGMqyduTil2IG9MOHOGYblHuvO+875GuztNMgClC9LzrGkyyum00ZOP81Yfehrj2BxXDg99W+2hXbdb5JXhPcymDw3qN1Wp5VwhzjrFUHoUoKPu85B13oQ3E3NcY5SIjejeU/Ym/Df/OylcP8GNuBKOLO/8Z4C+Dj8GY9YbuQNfi4Q7Q0cfRWe25R2/ib9TevOzxv9xn2QIYERc8SSPDSkz60g4LFm1UIhMC/qwlOYPt41Mv3XvkRF+bPzlm6LycZaiQm592v9LsZZo5iNEyvWEC3r0OqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VlTHVEOEFwTnBmUk9xS0VUazlhY0lPUE1hWFdaNXZRTllBeGFXM0t5Q2lK?=
 =?utf-8?B?T1pyWTVGTjUyVU5IWUJFRjQxd0pTdDJmajN3bS9IUjJmM1F3dWFuOHJQenZp?=
 =?utf-8?B?aXdpakN0dVhVam5ZMnBLMXBYOVBiTGYzbXZMRjRROXF1dU9NL1BxNEdKUU1H?=
 =?utf-8?B?dWwxdEh0V0J0THh2MG00VFh4U095L01kdHQ5WDlFQm02WDJzZllSajd0YjNr?=
 =?utf-8?B?UHFiOC9RdzVsZ2xSdGdXeERWT2p2WExBcGM4Ynd5K1BENVg2bnRYd2pVY1l4?=
 =?utf-8?B?VUNGTTB6V2laMElpRnNTeHJseDNxSHJ0ZSt4eS96OTVQWXFOdE5ML2pocFZz?=
 =?utf-8?B?WkJqVkRlZE5GZTlPcDVEdHhpWE44REtBcG1PR3BoaktVRGNRYkZMaG5lcGs0?=
 =?utf-8?B?NDBLOGJpeEVUZHZZei8vd3ZTdjZIU2tIOGhkL0svTmdNS3Rweml0VHR1MzBQ?=
 =?utf-8?B?a0pESE0xWkxiL0NWblJWVWVZaGlFNHAxUWdLdjNsZExRcHVaYVZZWjBTeUl5?=
 =?utf-8?B?ZkdGT1NSSlhnSGVoK21mOWhjakZCYUFxNHU0SENJTk1iM08rMnk1UVFsOTBP?=
 =?utf-8?B?a1BXdWZ3TDZ2TE1hYWl2bnRUeHFpa0VGM09RYlBBTHhzcmxNZ1ZLeFY2NFpL?=
 =?utf-8?B?dWg3cjdvZEhrckVWYU83MjRMa2twaEh5NzY5ZXNHVXIwRnYyVDNBZk5pVEF6?=
 =?utf-8?B?eUlSZ1IyZ2NxSjJIdEtFdnlFVmdoOFVialBmZktzbUM3Z2EwSmYvdGdVN3p3?=
 =?utf-8?B?TTJsUEhURDI3eDgzamhFUXl0RElzTmZQdXNIaUIyd0JpTFJkQUdCSE53b2JL?=
 =?utf-8?B?MlpHZnhUdVlGTE1xdkRnREgxdEtDOW9scEZFS1FmVmhlbGgycFdBNERiT0ts?=
 =?utf-8?B?M1pkUHJIQmF3S3M3bmY3ckcycXdKdnVjV1BrcjZ1T1M3NVRSRzJZNHhBS3ph?=
 =?utf-8?B?QmwvZmQxSWduMmtkTVFkUXRONXRxSFpjczAwaitIRjRrbFhzaWJrMEtFY1B5?=
 =?utf-8?B?S2k3bUE2S2VacDVBUkFhUTdIdVlHbHhyekZNZ2pLRmNOZSs2TGpIbTlUaGFu?=
 =?utf-8?B?NHlETXBSMzNHdExtektMdlNydUY0Rnk1aXJZd1ZFbFhjWXozZ3pXU3UvU2hZ?=
 =?utf-8?B?TWRYUnBQamVnWG5kNWhxUy9VdWJuY1UrWE9sQWFiWFRXdlI2Nm0yNm80c3hU?=
 =?utf-8?B?c0dMbUZCQkd6dHNwV1FzQnZ4c1lIV2VXREd1MFM0N3JReEdSdVFPWWthWlV4?=
 =?utf-8?B?SklMWS8vL3orT3cyUFNERjNuRGk5aWIvR3RMVDJ2Skl2ekNxV2lqemErUzFM?=
 =?utf-8?B?Q3FhWFRyenBiN2xqNlZPbDUxUEg3Z2V2VXczQk5XTGs2djdRSkwzQ2dmTFZQ?=
 =?utf-8?B?cCt5NkRjdFRaTGYwMWpwQjlUbkNDT1E5MmdoUkVKbUVVVnJBNG9RUFBQeFpm?=
 =?utf-8?B?djdHSUZWQ1FveDlaWDFoNHVQZ3Qva0M5dmJ2SnNrSFhCUWV1eGtBeWRQY0dY?=
 =?utf-8?B?dG10bmh3UHVBdDZvM05TUm9GVzJwY21naWhmclV2TzNGZXFoWHVHejRIVmtm?=
 =?utf-8?B?NGl0NHhETGExS0EwdWFFdXZtczJnTWpDSjBaS0F2WEM5UVg2MDIxM0Jyamk3?=
 =?utf-8?B?M1NlY1Q2eFE0Mmk5U2NKQ2s5Qk5JYlhWUXFxWitNZHhLK3R0eE92ZjIzTkUx?=
 =?utf-8?B?bXMrdzNaNzRhS1k0dEpqSkkzVklQQ0NMYmFGczh0MUpUQUlMTWdQSERPbHZN?=
 =?utf-8?B?N0RRZ09zb2lZUWxoZnE3U2Y2SHJ0S3JPTHNRWUl3M1lBaHMyU1Y2NWk3MFhp?=
 =?utf-8?B?RGhPd05RMzBEUStWek52aThEaGdCcE53MUxrZGxxME9HWWJDbmo1cEQwQTFB?=
 =?utf-8?B?U3RUR3FCVWpnSTN3VDBwMnZtNXVDUk5NWXVSL0FvamMxdXhFQUZwREUwT3Js?=
 =?utf-8?B?Z1dTUTJDMUhuZUJPZjU3YytXZ2NCS1d6emd0WnhwUS9QMis3dHJPeFBOS2Nv?=
 =?utf-8?B?akxTVlhqRzlrcjRJMUdoNnpaLzhTT3RCTk9zOWh3Ynpqa2Exa3NlS2JGTzNK?=
 =?utf-8?B?K3lCRGNvaEgya21KNGhreGs0RENHdTMzV1E5OUVCcG5lMzZpM3Z2L2JISlFa?=
 =?utf-8?B?QklhMXJMUGF5NE51dkRHK1hsTENFbzNpc1NvTm1kK093emhPUHRoMDdGMVJ3?=
 =?utf-8?B?QnZ1ZjAzQjQwVmdNQ1NpZ090M2lsdEk3a0lPOGZTclplemdxV2lzZ3loV1Yx?=
 =?utf-8?B?Ui9nMndDemhvK3JobVE3MmwzTnVxYlBvdlZkQ2p4TEg2M0t2cGI4RnNuK1Zu?=
 =?utf-8?B?Q1JWbGJlSGxkOTlOWDJOU2l1NFhvanZGbm5BbnVaUXFqVVBBVXdPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103ff7db-21d9-460e-7e35-08df4189ed5e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:27:56.1780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2/g2qB7+M3oKT1G3e9/aoof+0wgv5ns35DfqOSSriWTunfjBidk8bT2ef3Eq1P1khVidg81f5ZegjhaTrCQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003


Hello Wangyang,
Thanks for reviewing this patch.

On 11/12/2026 7:50 AM, Guo, Wangyang wrote:
> On Wed, 11 Nov 2026 01:46:11, Vishal Badole <Vishal.Badole@amd.com> wrote:
>>   static int alloc_cluster_groups(unsigned int ncpus,
>>   				unsigned int ngroups,
>>   				struct cpumask *node_cpumask,
>> @@ -299,6 +380,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>   	const struct cpumask **clusters;
>>   	struct node_groups *cluster_groups;
>>
>> +	if (!cluster_snapshot)
>> +		goto no_cluster;
>> +
>>   	cpumask_copy(msk, node_cpumask);
>>
>>   	/* Probe how many clusters in this node. */
>> @@ -307,7 +391,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>   		if (cpu >= nr_cpu_ids)
>>   			break;
>>
>> -		cluster_mask = topology_cluster_cpumask(cpu);
>> +		cluster_mask = cluster_snapshot[cpu];
>>   		if (!cpumask_weight(cluster_mask))
>>   			goto no_cluster;
>>   		/* Clean out CPUs on the same cluster. */
>> @@ -322,7 +406,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>   	/* Allocate memory based on cluster number. */
>>   	clusters = kzalloc_objs(*clusters, ncluster);
>>   	if (!clusters)
>> -		goto no_cluster;
>> +		return -ENOMEM;
>>   	cluster_groups = kzalloc_objs(struct node_groups, ncluster);
>>   	if (!cluster_groups)
>>   		goto fail_cluster_groups;
>> @@ -331,7 +415,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>   	cpumask_copy(msk, node_cpumask);
>>   	for (n = 0; n < ncluster; n++) {
>>   		cpu = cpumask_first(msk);
>> -		cluster_mask = topology_cluster_cpumask(cpu);
>> +		cluster_mask = cluster_snapshot[cpu];
>>   		nc = cpumask_weight_and(cluster_mask, node_cpumask);
>>   		clusters[n] = cluster_mask;
>>   		cluster_groups[n].id = n;
>> @@ -347,6 +431,7 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>
>>    fail_cluster_groups:
>>   	kfree(clusters);
>> +	return -ENOMEM;
>>    no_cluster:
>>   	return 0;
>>   }
>> @@ -354,9 +439,9 @@ static int alloc_cluster_groups(unsigned int ncpus,
>>   /*
>>    * Try group CPUs evenly for cluster locality within a NUMA node.
>>    *
>> - * Return: true if success, false otherwise.
>> + * Return: cluster count on success, 0 if inapplicable, or -ENOMEM on failure.
>>    */
>> -static bool __try_group_cluster_cpus(unsigned int ncpus,
>> +static int __try_group_cluster_cpus(unsigned int ncpus,
>>   				     unsigned int ngroups,
>>   				     struct cpumask *node_cpumask,
>>   				     struct cpumask *masks,
>> @@ -365,18 +450,17 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
>>   {
>>   	struct node_groups *cluster_groups;
>>   	const struct cpumask **clusters;
>> -	unsigned int ncluster;
>> -	bool ret = false;
>> +	int ncluster;
>>   	cpumask_var_t nmsk;
>>   	unsigned int i, nc;
> 
> If we could move "if (!cluster_snapshot)" from alloc_cluster_groups() to
> here, the unnecessary cpumask alloc/free could be avoid if snapshot if
> unavailable.
> 
Noted; I’ll address this in the next patch revision.

>>   	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>> -		goto fail_nmsk_alloc;
>> +		return -ENOMEM;
>>
>>   	ncluster = alloc_cluster_groups(ncpus, ngroups, node_cpumask, nmsk,
>>   					&clusters, &cluster_groups);
>>
>> -	if (ncluster == 0)
>> +	if (ncluster <= 0)
>>   		goto fail_no_clusters;
>>
>>   	for (i = 0; i < ncluster; i++) {
>> @@ -392,13 +476,11 @@ static bool __try_group_cluster_cpus(unsigned int ncpus,
>>   		assign_cpus_to_groups(nc, nmsk, nv, masks, curgrp, last_grp);
>>   	}
>>
>> -	ret = true;
>>   	kfree(cluster_groups);
>>   	kfree(clusters);
>>    fail_no_clusters:
>>   	free_cpumask_var(nmsk);
>> - fail_nmsk_alloc:
>> -	return ret;
>> +	return ncluster;
>>   }
>>

