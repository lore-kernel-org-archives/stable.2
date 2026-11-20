Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795206253;
	b=zVBQ3zbY66e3gBidTlfRh4vlp11JmBwOgn/sE1D0Dj5fh9xmD0NnEaKpKMhvrh0TByZd
	 kQJKyNOTSWOVf9QmOU4vF1n0oIt1syLYDgnxcZ6hEKTP9gQvjFxGgMbllMew5wneqyJ35
	 Xfz5cwUxwHFzxWVgiasQ0YQIxwIYQ0avd3BinauPYS74E7rF2zyG3wxZQPbG2v8HY7qca
	 H5leq6NmZNmKL+GLwnbxVn72qKwGpreEoE6cTTD6nYFscVPzQKcjrMatmJhDyP0q8pZmE
	 qvXVkHgDMipsKTZaqXYFCLC9MI0PGNzhzITgH87XyawIpHedaQA+f4kioKJh4CYFasw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795206253;
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
	bh=+awqhnrukpMtYHx44F1/eADeZTLSRCkwVgE00F1Z1Uk=;
	b=Qc/7Fwhsec4M4PU5zTstwkXGn2iFo27gdd7TpxQQ4KQlhkII3jUFsd0zLbGkjomnBGkG
	 m5IdDe7rf2UNeQw58WdwXSxsHYrEC5UP9MApHoKDUdmyb7bTEaQcCtTZ6yq2gDWfMuSYZ
	 ddDuF5b6RE7C4J1NuPdqHiY4CufJaR5nZt4PFPVzFqQmAJM+DgauiX3jmm2+OHYO+VUue
	 7I+bPeMKRSCBh6sBBDKSYpWobOE1xCFd5dQLPE15erx8EirJ/NwiyivOWZ8vyjmFEfQNb
	 hahSCJUWqvOFAKZXyIirhY2EQAl4+6WO41V1N7fVhH+hx+LIvnlUaHhFiyMO/t3S3hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="eON/AF43";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.40
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F8606A335;
	Fri, 20 Nov 2026 20:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18F8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eON/AF43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGpHZguGUfYRtUPUlkZGIiSIqcWbQCA/rmgLXTC+fBD+33abz2RArdZu9Cnl2pFyjzof/lAcoqgxT0dJsO46YpKHWbP0CiLxmNpmEJsvwoUH11nqXIykYKzXjXib5I9ykNfuSV1G39lNuUakyynEvXrtU5Ix8eti/Km0vM5AGbIrOkSyWxfT+KN/8ly9MiyrQqKDWViqTtpRafqZ7WLKi9ZFl2NYAXhVIz7kL8x4zyt9qbcNjdzacRGANDW96kAk3sPYTj6uANpUWExRIlc5jm3/ewZMUQI87q7UMpZwivVxgrRiZOVevdW7Lk6Nd4nW24cz3hu57ZPw+hdHvE9A5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+awqhnrukpMtYHx44F1/eADeZTLSRCkwVgE00F1Z1Uk=;
 b=XvYwY1hQTjNXKEkOYEp3K8+hjRwXNE12eSdRk9U52OX+eFBe6wu8UaNy7848HAs+haJH/AfT8rYIwIYjORd1KxysO8MfHzSPma589ec94olnJ++esm4ElCykLIw4fxaFDNX7tKQxsGp0N9PnjzvjsMqivE+SEozeJFhpyJoEGtGGb2EF91cNFMBxMhQv3lUk2/59BYQt46SNdNZHH0/y7pckXbfEsAFfepDsOEKUEsYL2TUcO+t92oiFjG2UJbK0dmy4BND6UarLYdhuoFA5HoIquOkcV3G0r5q8Mq/EZUC+3jlHdAKIP1jiG/izdNErSy9LlDtRNEYsrfgRSMTonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+awqhnrukpMtYHx44F1/eADeZTLSRCkwVgE00F1Z1Uk=;
 b=eON/AF436WWrkC7NIvZAnL3CP5GSlYRAzPIai5kAZqenIHkISAG3tILvjM5vfGgZjoqAIdhupiWNTgLO9/DcNhmnL5Kmz1yaUqZSHooZkIZ1mZTzkuTx6aRPMlnTJtgpQYZ1zor5YqPmwWy3ft++jQbsKS5j2BE4esudHqBBb4ZHjenyLE6BCzPp+j62onAfkhYUnEptUkJw93epp3ESxVEHiTdXtZmjsdDrgS+qA99KAld/TqEk3/HSDQgY1APYh+lStlnUHmd0kidXToJZCSuWhhzj9UsCsi7PiodbqbpcN/H7v460tD4+A0wIrMN6isH5NSmk8w8ONxNk7qnx7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS4PR12MB033229.namprd12.prod.outlook.com (2603:10b6:8:50c::24)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 20:23:55 +0000
Received: from DS4PR12MB033229.namprd12.prod.outlook.com
 ([fe80::d666:2f16:7d21:b7f0]) by DS4PR12MB033229.namprd12.prod.outlook.com
 ([fe80::d666:2f16:7d21:b7f0%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 20:23:55 +0000
Message-ID: <66ab6c3e-de92-4a22-8c72-c4f8df118cb7@nvidia.com>
Date: Fri, 20 Nov 2026 12:23:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resctrl: mpam: Fix potential per-CPU data leak on probe
 failure
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261120173519.3923924-1-liguangshuo@mail.sdu.edu.cn>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20261120173519.3923924-1-liguangshuo@mail.sdu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To DS4PR12MB033229.namprd12.prod.outlook.com
 (2603:10b6:8:50c::24)
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
X-MS-TrafficTypeDiagnostic: DS4PR12MB033229:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ef7bdb-ce0c-4e6c-2a20-08df47443338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261022105027099003|10067099003|261026140227099003|56012099006|261021123027099003|11063799006|261102123227099003|261022075727099003|261028144727099003|261021121427099003|18002099003|6133799003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	MmEYnENTMPJ5Zgwag7XLsAELZ9cbtneV9ciLfuTYtLrvqAkQ+dKKiYzSq8IEoN5Kd0EPbqChZBkyfl+mGnKdnl/BsjVaHG3XARy9i6Uy0tzRQnYChZ9hetcr6poOnmJI7fhuFuGHbag2mHhuSE590oMzjhp1nfNa+L3rGyavbDyHw/DILbCMqGQ8SVoktAWjt9YEuO9KHKBSE4lowQabJDHKlmV5B+p0cA5u23CdG73pU2G09Dk+tqehF5SRmDMDLNyfoMOgvyRhXhTZPpjUZK1TlGnd4I40sJh1dP5Vr3hyzWtQ6M4WO6Sz9+MUMm+hi0ZQrKcCp0dUtiTb+Hws4RqWS2vsPoiPwAfUFSvhLkGMeGtJs5E+mlwqHQmsCFj13B5QU+WDnYJ9P0sXa4ldOGAjnoPEGscA+uNmJ/34tcLDmbfkcAsDbmFzZcPTc+kZqvB34qy20faPG8QqCdBQ5Oit2/005ZjZDv6j4MIRBEm5U5/szJLLoql6vHfwpUWHR2LIYYobXp2WEHzOpNjorYjLZsSToRFLzVWbOipJZnIbuqhnDYA+FZ/yRyaTwRaUwm6CizhRr6nKBlLvsBqchE4XmiXzLmUto9l+p7kXeV7YILwQsrHNyYyxjnJWgp0Z65NiuoGQOTssRHhsu3WeGzOJsEQCdISUrk7jIxoeKr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB033229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261022105027099003)(10067099003)(261026140227099003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(261022075727099003)(261028144727099003)(261021121427099003)(18002099003)(6133799003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9xc2FBOEtUNkVMZC9LbVVqKzZHTFZiMklJQXlKdFhBelNZSEZnemlyOXh3?=
 =?utf-8?B?am1Zemo1d3dBM3NwUXYvVFc4MVd1Wk1BQnh2VTZvUVZneTVvREdBdGd4a1Rl?=
 =?utf-8?B?bzV1am9MTy8rbWtPREVHNTNJTU1vSklPall4elJHNzlZZysrQlRpeUN3UGNk?=
 =?utf-8?B?RVlJc1hBUmxUZWdObmkyRmorS09hRWgxNVNNMDczYnVmMnBQK1gzcVFEWTZP?=
 =?utf-8?B?SVFmZWRZdWhaRlJmZEZZWFBHWVluSWZUTkVSRWU4NndhdFV5TW5Za0xYN1hX?=
 =?utf-8?B?RGlmK2dsUTBCSGt3aFJoNitWU0lJZzZQZHlsS1Q2K3FQYWRWYzY3R1RlSitt?=
 =?utf-8?B?WmIxY3NMUUdkUjdqS0x6eDAxMFhvUXhrT3VLb2s0OGREUktyWXFWendxRFk1?=
 =?utf-8?B?RVkzWE1QWlFEZG8xVTlCNlJ2U1gzOFRXZGhQcnkxcEQ0czJtcUs2c1RENXZL?=
 =?utf-8?B?WHR1anNNVnZzT0kxM0hFYUZoTlBNdWlMN0hzTG9QZXJGNnJiV2V5WTVLYVhz?=
 =?utf-8?B?eW5uZzlrdWo1Z0Noc0llODJqZ1orMFBUZDQrVFQ0TG5pakFiUEZzeDRrbTA4?=
 =?utf-8?B?cjVFSGttR05uYnZUTW1hakJ6QkxISnF1aitJMjBmaWtVQ0pkK3ZYczk5dkhP?=
 =?utf-8?B?YVFlZWZEQjF1Q1lyTzZpOTBQTG1FU0VGa0hSK2dNY1hHTEtpNG1HQ1NTajdr?=
 =?utf-8?B?QWxtYzJCZjVhWlJhSFl2Q01SYjVwbFFjaHl6c05kNWlZVjQzeGxKQUorWXlE?=
 =?utf-8?B?V09DNFVoVS9UREQ2aml0bjlwQU4yWE5vNGZHRElma3lZbXZuUXFUUndxT0F5?=
 =?utf-8?B?enhYZ2VmMWZzZjVuaHUrRTlpNW4yVUlLa1kwSjZyN2RjOWZzNC9Fd2ZteVh3?=
 =?utf-8?B?NFFuT2l0NU0weTJTNk1WQ041b1ZueDN0RkdZYmExQU1yYjVqQ1FQTllPYzNZ?=
 =?utf-8?B?U0FoQ3FiM0ZkMk95NlNyT2QvMHVnM1NuZ3ZFQmc4L3hXRVZFRzlyam44UDhy?=
 =?utf-8?B?QUNZRlRxT0d0UG54NkVXOEFrVlFCRmlVN3JjZmU1QzZ6MXJGRnpFSkRDcjNq?=
 =?utf-8?B?MlY4cktISTRtdlltaUJyODhjVksweVNqaTFsTk9JVTVXcGlYeUloK0tTS1NX?=
 =?utf-8?B?WUNnbnduclJTY1pyZHM2Vkw2OHBpeWdKMEs0STNybjZXeGVjWjMvL3c3SlZZ?=
 =?utf-8?B?TnNEWmFqN2d2aU44WHNRS2pKTmFaaU1uNmFZa25wcFA5Z1plc2gzU0VxZlNi?=
 =?utf-8?B?WU1aNTRnY2g0YU1NVmxtT3Qxc0tuY2xIRmFrMFhXOVBndW5NVTV1MlVFQlc1?=
 =?utf-8?B?YkU3ZTlnVjc2YnljdzdsM1Q0S2R4QlZyekVaYkdRelBmQnN2MHlmUjVCaElI?=
 =?utf-8?B?UlhuWDZDaFFDQndXakFVS1M2UlVyZHBrcTYxc2I1K0VZTXI0aEFXdDRZMjV4?=
 =?utf-8?B?b0lmNDFhMXl4U3RlMVY5bVdHVWo4Q1owM1Vxak1oL3ZQaEpQYlI2V2JpM2FJ?=
 =?utf-8?B?OVBnUE9IVGNubGFTS25OSVp6M01ZTjRYTEJ0RWJhQXAzWmV6Z21EYXEyOWNp?=
 =?utf-8?B?bHJmM2VvSEUzZHIzcG5QdldDMmx0N0cyZlN4YndDajBoOU9CYU5UeFJuNXJQ?=
 =?utf-8?B?S0hUM1doR2pnYjVST1hRNzQveXRnbDVZcXBNc1BBNTR1RDVZT1VmVUR6cHB4?=
 =?utf-8?B?QTVZRGNYZy9lMGs1N21ZbTR3d1d6OThmWTIwRUI1eTRDUjVFd2hWbklLZVVr?=
 =?utf-8?B?cEI0NDVMc0o0V2hJUUwvNlVtc1NYUDlMcHBGNUcwWDBDUGFJKzZJcVljeTRa?=
 =?utf-8?B?V01uNURtUlhpMWdaUEYwWWhpSDNIejlxRVZKNGRKeXNTQ2ZTTTEyUVJnWlFH?=
 =?utf-8?B?MDRJR3hyaC9xS296Y1NtTlVaNGtTRjlwQVd2K0s0TXI0V1RXVndjTkZWRkdM?=
 =?utf-8?B?bzlrUkI4b3FmR0JBK0FkZzh6YUZZc0dmTFhQZnlPZWt6aVU1Vm5jSWtmRzdM?=
 =?utf-8?B?MWgrOS8ydmNRaDVDaDJZbWpXcmdwN0IyUHRJS0pFOWxySWM5eFcrcDcxWFAv?=
 =?utf-8?B?cVlPWm5OdEVIeE1NN1hGcHBSblhEOTMrQ1YwbThNUzRSOTFzcXVhejE2QjJp?=
 =?utf-8?B?TW5TVlNTaTlhNmsvcnlST3pBSlpYMW4zamovU3ZuVnFLZVduRVR5amh6Y0VU?=
 =?utf-8?B?VmwzVld5bHd2R1BJSVpqaURaV2YzcTc4WlliZUEvLzNWemNTeXI4b3A1cTY2?=
 =?utf-8?B?U00vdXNRYlZNRzd4YmNJS3dPNngrRkdKK28vYVVJU241dTVkZnVDMXd6bE16?=
 =?utf-8?B?V0xub2VnR0J4bGNDUTdaRXgvN1JRR08wYlRVWEQ3KzM1L0tUOUtXQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ef7bdb-ce0c-4e6c-2a20-08df47443338
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB033229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:23:55.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CePhsEnjyOX6XqPR9HJo4XO/MdjOP4vrcNL485ptdvVcbLxw28R3PRPDKNQFPdvfpFmvFZwwPD/Ib2tSufHHOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

Hi, Guangshuo,

nits:
Subject: [PATCH] resctrl: mpam: Fix potential per-CPU data leak on probe 
failure

1. s/resctrl: mpam/arm_mpam/
2. s/data leak/memory leak/. Without this fix, there is no "data" leak, 
which means information is disclosed, right? Not freed memory is memory 
leak, I think.

On 11/20/26 09:35, Guangshuo Li wrote:
> The PPI device IDs are allocated separately from the MSC. If subsequent
> resource discovery fails, probe destroys the MSC without freeing its
> per-CPU allocation.
> 
> Use devm_alloc_percpu() so the device releases the allocation when probe
> fails. Its cleanup remains valid even if the MSC is freed beforehand.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 49aa621c4dca ("arm_mpam: Register and enable IRQs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

> ---
>   drivers/resctrl/mpam_devices.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index c067b6d57d71..3e89f9183041 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -2351,7 +2351,7 @@ static int __setup_ppi(struct mpam_msc *msc)
>   {
>   	int cpu;
>   
> -	msc->error_dev_id = alloc_percpu(struct mpam_msc *);
> +	msc->error_dev_id = devm_alloc_percpu(&msc->pdev->dev, struct mpam_msc *);
>   	if (!msc->error_dev_id)
>   		return -ENOMEM;
>   
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

