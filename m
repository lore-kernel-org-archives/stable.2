Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BD493D5A;
	Mon, 12 Oct 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818219; cv=fail; b=VL2H0rnshVDVA1W1e9N4up7GdbzJ3SFZYjsJ7K3ruk6YPnpViI6zS6Pf5zFr4QK0wqm6pIy6tDsiMjxV3kfe/Ro+9jaeKUuVZceBGQnWCtuKVGmgm4avPYs5d68Hl6MIhO0YU+yGFo7HjlzLvJlWIV1lL9bhMOLe68RRfaDxoC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818219; c=relaxed/simple;
	bh=d596gQJhwCbTDElc3INSOdwzaE9A8CU+Ua2fG+0qriw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uNPcmKkgUKrT/AjT+3LyLdCJUxlRtI+L9Ji3nUINXH4i1YWfRXPQQX7NDjrEM3CdzxUGZZj67gbL3K+QqKRW4BsLE3iHj5aml+ZJr92lituoPt7FtPdFICFqBihLn8nPZP2fUe1AQgcjvO/q5iBNHI4zbd7o32GRnt3J+1DoGFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dUTKxPb2; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dUTKxPb2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueb116BzsK6Y/tL3TQ3vBTEbZGmy5TI93m1r4gun2zOuS7moRzAvjxFVbNgzGBjTyH/mNAF+y05XKJvpSCn0tOzSJ1rBQ80ZtyS1+QjIzBmzuJdJ6w0bUDiXO7C3DhPpuE8OQywzVG2YpnuKDSOfl9gD6Fave4UkdDWOuo/eluY+4kejQRe7bXXoK8ZmYxXIohqkBd2R0njjQiJ9Wx8RMGtTUIwdAFW0daOo9NFWVc9dsOqDHdeqmjEXv+1o017at/h9SE58hXSjZhZoQT53a2vdkrBvgRbV1/OWCRLLJEYWjQPlUpOPy14OOyRfK938slPjSV7vbycvmLrT9VezqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaYFB2QASazihBf6ZCJjKYsRufOtVfvKVsW3nYba2PE=;
 b=Z/iWh5OSWOZPkfM4U4qiPWYlEOMZY7mr8p12rbK5ug4YW5epGeVXGMJbtQFkE0am9KM7PSrjClEOzPjiYyWAfPGdJZdEKXZzlw3UuyfIH6mMPiiQIKYmACSrimmAxkfJ8OrS/BKy5/34+aXbC09nCzrSQPzTwhEo8iNGA/BUS+afar4PWtKFTwKdeQJ+n5GGZbGFxD5FozrKt4X87nebV6pUiCIPDZej1brcsyOCAzv/COL0sKTIycCqWM9gqaPTZTK460SQndGKCrqkMyjmdYRtd6GmIf6dmG82R3kHi6nJ9tp/zKT9VBxrKBt/0rVsFcjJuXb4ulJyssAN6sJf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaYFB2QASazihBf6ZCJjKYsRufOtVfvKVsW3nYba2PE=;
 b=dUTKxPb2zUKPUygx/5cEjj9PwE25sQn1fJ2ZYTYVqYLT6RU7HYaNPa4aWFkDytOrpF/AfBy39NfZD+9Hc6hclS0MQ0/1CtHNWoJhJI8imn45cFHnHTA/3VvSEOibWGwAyaYWiRUlEqR8oTA0V/tB9CUVQAERv7uTkav2HNcDOlA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 15:16:48 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 15:16:48 +0000
Message-ID: <9c76b6ac-114c-40ed-9f2a-e3f8fff68059@amd.com>
Date: Mon, 12 Oct 2026 10:16:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Don't fail active mode init on
 read-only auto_sel
Content-Language: en-US
To: Akram Boulahia <akram02st@gmail.com>
Cc: kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, perry.yuan@amd.com, rafael@kernel.org,
 ray.huang@amd.com, scardracs@disroot.org, stable@vger.kernel.org,
 viresh.kumar@linaro.org
References: <851316da-2cfa-4a22-947c-1838532d05cf@amd.com>
 <20261009001022.6660-1-akram02st@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261009001022.6660-1-akram02st@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:610:b0::21) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: bd52c69a-14dd-44eb-e8f7-08df2873d594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	JHFYfkIe9SxV9GOqIeDsG3TzydZo7z02XLVlW+NtscoyyUMyOpwV2qCj15A+bRoU8czRy9gx2PVwEOZHGF6kFei2Bs34DK8Q1ykGwyCRn1/DNtlpwHN/K1wFyMRISGjWetVGZfbuoMQcEDjxfi3oq609AKbNQhEyiDWol9cnydtrd2D1M9w6A66PepdldhV4uvtxtLElsVOEavw6P5sZae7KczRcl5ND8qmbo0HYcZed66TYx7DWeNXfn+iPZO3OFHVJEPuzxny2uyPEQII320mDOxB9DWhRxI9WM7Wz8cRJBEcnCtUiZ62SAjfrCQW0erG2DUvXvZ9yBNejN8SxGj0SGi/YW4f8a8KpWDCvxPsu0H9htSOEVXYIj6Bia2FnNZOpWufeOG2E2RDWNLr2keRM1dhHllJ4fYdiQWbOZTiC3P2DJnHZf3Sr4/1kBLl1Iar+n1APbKmxvr0KT+ogb6u67XsuZor8xGkPcp+40BnmjpVbRfGOwaDySutRziv8SifnopzWTMTFvBOVp90hOUSs+1rsjM3CFkh+lwb8AJmCTnzIF+M5r+9nQd/unEpBu5QbIRTpbzk0kMQRwJTEXac8ZF8K3/p8SLLQkS2OMfJM0i3BojPC+H9Pd+B7Ygv5hoFpfKZ0ujWXqrdcxQuGY5LHKqwmlO6Xw7OHWzHZ+jU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c05HVmg1QlZoRVljVzViZWNqSkFHTjZCWGlJMHFTakNXdTlPbmZ2cGE1dElw?=
 =?utf-8?B?VUJXVWIzS2YzeEU3bFRXdjc5OUJnYk05a29YWXc1cStyQnZrSmdKNWRCcE9q?=
 =?utf-8?B?eVE1aDFFYU9hSEpnaDRKWlpldVlUM1l5WlEwUWQvSlk2QlY5MnlaYVVERmtJ?=
 =?utf-8?B?YnZZOFExdnNhSlNhamFBQU9KdDBrZDBuMVpmb3pVaWFSN3E0YVRhNnRDNjZD?=
 =?utf-8?B?V2p5M0dudDYyV3dVU2c3T3lmQ3VuVnErbnZSK3JwU0JqSVhuN3hYMTBjOFkv?=
 =?utf-8?B?YVlwL016WDdJZmxyajhXU0hSdGNLM01PRTZNd3FYQXZpY2R0QmdaYWFBYUZx?=
 =?utf-8?B?WTFUSVpjTHNsbXRmb0ZVNmxzNVBzZHI5TFZqd0tvenlacHhOSEtpK3RRdi9j?=
 =?utf-8?B?NEZqQ2c1Z0hlRGRYdFZaSEFvcGFBSXRCcjlRSGRnT3RjR09qeGY3SjR0Zk5N?=
 =?utf-8?B?Z2ZjcVMyeTRtSGxDMlpwZGhXTkRKc2JrcVhLSnJYQTlnZGZiRXF4eVEzYlZh?=
 =?utf-8?B?emlISG9TN09UcGp3M0lTeWxsV1dKTHBqZW8rV1NRQ2Jrb2VUaHpYZWw3QVpV?=
 =?utf-8?B?Z3RSUDh1OWVPQ2JIRE83QmtqMHd5MDVXeUVUdm9qb1M3dm9wT3QrVVZZdVBy?=
 =?utf-8?B?ZWZ5a2xlaHFtVW5yclZ3ZjJKWWpwM1ZrMU94dm8yYXFYVjNVRnhTWlBSZGdT?=
 =?utf-8?B?WlRnNHA5VkNKR2hwQlJKSXRkdGhaZDVMRnhGVHM0RWZoZ29QaU9IZ0ZvQ1dX?=
 =?utf-8?B?emFCeXA1R3pHTEdXdTY5ODh6WHlqb3d6aEVTU0JGMHBaVXkzQ2F3VCtnRkFB?=
 =?utf-8?B?TUEyNm9hcWFWSXNJNENIcE1RN2hIMXgxKzZpblI5N1E0ckRFSkxodU1iT05q?=
 =?utf-8?B?cnM2a1oxNWZybTVJQXRjeHZoQzMrOHRyQURCUFd4ZlZ0R2VKQ1Jqb2RJVDg1?=
 =?utf-8?B?UUpZUXFWUE1nQzhUZC9WYnB1WEUvZHpLZHNRaWt5Z2N4QWw5OVhqeUNkR1h1?=
 =?utf-8?B?R0pYUGdzeUU5UVJscDdGWFdvaEFEZWdZM3o1MWdPQm9iM0R2OFRrM3FmZlNF?=
 =?utf-8?B?dFQyRG82bzQ4VEx0RFR3ZS92SVJMQVQ4ZW9qb1VRMnhObUQ5VnZIdE1pQ1gz?=
 =?utf-8?B?UnM5Qkh5VHQ5ZVArdXJhd0VoN0xpK3BHQ0xMVkR2KzRPWjhoaUM0UEVpVkxt?=
 =?utf-8?B?ZDJ0SWtIMzZZWHUrdCs3dXI1Q1BKM2VZeGYrbUZGNHBsVkJGNDRQQmdGaitp?=
 =?utf-8?B?eURZZXgrSGpjRWNlM3k3T2h5b2s5QnNiRm9sOTV5MU1hYkhlVVhKWld3Vlhu?=
 =?utf-8?B?enZGbnZxZlJLSkFBYnQ5RzVVNFFVU1o4NWR4M01OcVZ1RVBJQzFCODNrV3JN?=
 =?utf-8?B?M1JGOUVBRXF3dXovZ1VFSjhhQ2lsa0N1Qm9FWEtiSXdIb3NaMnpvUzgvZ0Ru?=
 =?utf-8?B?aTZSL1RjTXh2OTliM0NZNjcwY3JCeVFZMnZUZFdoRytiVk9oeDdaOHNPaXQy?=
 =?utf-8?B?ZWJnT2llazZnZ2VnQUt1M1kzeFkrMnpJMVlzZnNWMUZjL2VPVjZvWE9Wdk5o?=
 =?utf-8?B?SExVc1hoODF0WkNsd1hZTHNFcXRsblBlQ0s3TndnSW5qOEp1ak1OSGpRRXNw?=
 =?utf-8?B?YzBpa1k1SUZlKzdnRHVnY0swRlZwUGVDN3RYUHd0Ni82bzRQNlFWR2dTYm5r?=
 =?utf-8?B?RGVSeVhuL3hjSmNlNkpmQ0RPWTFQQ3l6Wm1HMnFmRndYMVg5dGJMQ05aOENi?=
 =?utf-8?B?Lzlncy93U2dINldGUjNyVEJsbTNFMUtSQlluTkZpakoxVmRLOC9pdUNRQ0s3?=
 =?utf-8?B?RWl0Q0p4V2tFQmNoTFpiSk1kaHJvdkdNWURQRTlPNjJOV3JXU0o0ZnVZMkJE?=
 =?utf-8?B?c2xqSlJVTTRadVhsYzFSZ2ltR3kySkJuR2lTR0RlVU4wSnVLWVdTd2oyczJj?=
 =?utf-8?B?ZW1ZaFVJUnR1eDFUZXNycDV1bGxKakJib0pXeEtYUWtxdVVvUnpkMFR5UXVO?=
 =?utf-8?B?RlJNbkJhYXBJcGd2NEpxUTNMcVhhUEphYVRyV0lkZnlCZEJuOFFnUG9uQzA5?=
 =?utf-8?B?djlMbUlxeFAyVXZvRUo4Z2ZybnhObUNEalg0dENLRm9KbXNuR1Rvc0NBL2Vn?=
 =?utf-8?B?ZUs3MzRpUjdBTjdNQzF3bENFU09zOGZ6eVVoZTA2d0xmU21lUmhONlNqZ01G?=
 =?utf-8?B?REkreU9BS1dDY3lYVy9zUVc1dkRDRHFOb3Y5SmhVaDhVbkd1dy9rdWtzSUUw?=
 =?utf-8?B?OTAyUkdSbjJoc1RwQzlUS01GeW5xeW5mK1YydEhkdFBJL2FraFl5VXBaU1Vv?=
 =?utf-8?Q?nyjCYdSg5Op3fxZDPf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52c69a-14dd-44eb-e8f7-08df2873d594
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:16:48.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NeKZBGxkXJBfsa25vBR3RvIsmOCSqKdrM1PZnvelrdPmFiONLF6q0g27AaoEz2Gz+OvMeEfe6hjwWYcrLUk47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486



On 10/8/26 19:10, Akram Boulahia wrote:
> On Thu, Oct 8, 2026 at 10:12 PM Mario Limonciello wrote:
>> You're in a really weird path if you have an 8945HS that is using
>> shared memory.  That system has MSR access.
>>
>> IE this sounds like a severe BIOS bug.  Let's see what happens after
>> you update BIOS.  If it's still failing please share an acpidump
>> somewhere (like a kernel bugzilla).
>>
>> Need to make sure we understand why your system is behaving this way
>> before making code changes.
> 
> Thanks, you were right. After updating the BIOS from 308 to 311,
> amd-pstate works on this GA403UV with an unpatched 7.2.8 kernel. Active
> mode loads as amd-pstate-epp, amd_pstate=passive loads as amd-pstate,
> and the "CPPC feature is supported but currently disabled by the BIOS"
> line is gone.
> 
> So the BIOS update was the real fix, and this patch only worked around
> the old BIOS state. It also doesn't handle passive mode properly. Please
> drop it.

Thanks, less quirks or unintended codepaths is the best outcome.
