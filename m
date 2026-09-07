Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E0471414;
	Mon,  7 Sep 2026 11:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781344; cv=fail; b=FRsFVWfMxIZLiUiYST5p30EkNzAOckX89uRJXi8BMQF6/64gS0y4u95bTzpp2O0QqMvPLBPdCBMF2NVdBi/iSoRogvwgOAuXtDRP9ELv4QfM1My672Ou6tcGFLEekRk/a7YL1y0g938kPdxiEi/HIJdBAVHf/TDWmD1TIux3kQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781344; c=relaxed/simple;
	bh=cVCe6Rcxvl07/Wgkdex2erXq/w2dO4aLvE1mwrA8o7M=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=OpwFBqhpy0cQI324H56nem3phnlFWHgwbROhS/JnXqT5w3lsuGsFBAYFPx4LF0n/X6MBDGkc6UnoPOUYVI25DwyniOCcdJlG8WD/1GSI3KcwMJHiB06Kd4JGREjrOMAc+8MeBo3lGhV3lSTaB2wCoxjdhhCxk+Xb6GY0cJLM+kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GzefH9Hz; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GzefH9Hz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De8G9KD/SZti7XuOjIJynSiMsVj50IPUr8mjyIBNtEeqR+588MR/UwZEWIZheOXvYmT/lyXGmL9/eAbFUF+wF2x7Jo+Qdux4WHp2cCNQ0WycAjpZcOflxtwRswSMz55K81vj9seCLB5jJ+Ett442d3+uETjOqhCUcov5uZ4VIXIrKnqD1ob+at4hZJGbVmeC1xZda2DMKCPdSH6/740r15XX3y+P8E8B3MSJdBsw7jhSijeaNGr45vIiKA69KJ9QEZ9QB6rt+8ldyEjA4pEQdBeB955HkezM4wc1Y4QyqG94ONPPbsW71w1Rddy45sL+s97roeiCad49njHPZx0Eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W9uZA65E3RQNfE+xVfGEE5HBDNsLA9Y04v//gPxaGk=;
 b=L/aFM63USDMOItnvFHRCFI2g0dmjloYy94Lrf5CMnnSPcmAu4KMsAnFgvr44gJVtFtsRSiS/xoyE8QMwUVtxM6QDWcieVuDxWkyS6z6PAhS/MCd89ymcSXUx8c/wFe5dPJo7QWpjst+4TMywFd+168rIlYqJLA8BW9Rr71dYkzOz0Zy+E4f3LVedMlR5JtKOmQmSp5SOQPZeENcR5JiW7JOSNLGlbbYivpSv/NleZaMJB765WJLcNZRKh09bj6iKUuWKnbtfjyQYVUWlrR/ScCQ8B0nspyLmHmHrIMDazpp8vEQxC//Hv2hZ8E/TGgdTewqF7enhP0JIYEy/z0eENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W9uZA65E3RQNfE+xVfGEE5HBDNsLA9Y04v//gPxaGk=;
 b=GzefH9HznHK1k1tOFMh8l5m99a5UaR67ft9WMdxC1WaH+Apx9+4qlbfhEQksHDQKfgGMiqsucAL1Hcrl1HBTUwHLYCHd0Sg7x/D43r5m4+j33MXy+R9OV4EeYSCT08Rw9I9OSGToXXa1ZMqs21vmfWphmtzUNkuYMX7vshwmtYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 7 Sep
 2026 11:42:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 11:42:12 +0000
Content-Type: multipart/mixed; boundary="------------I1lhfYSJRAiO3DgVMEedbOnX"
Message-ID: <05bd9329-1982-44bb-9d8e-bc2f8b345cb6@amd.com>
Date: Mon, 7 Sep 2026 13:42:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
X-ClientProxiedBy: FR4P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 611b1907-8235-4e31-554f-08df0cd50e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|6049299003|376014|23010399003|4053099003|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l11LBfwZXg6ZgOe21r1mq4sQ3VvZ0U+4uUpNJSi6BGQ0oDcrXuw0MeuZARzewWz16zWxml9+QoKZHmNSLMnPduwD0coXKeL5M9wAk8bZdbOT8wJ6BQQcInKalJdi9pjxp/Ne138wwd14GsfFscT+ZOzm4+HSFcF51LWpdZ+3x+4floVhzdw7dSvkHTfjEb2sLkxcbSnik4liXYohIobTc0DDRDr2a2ARk9a7WggBzx7yylMTCdhr+TVT0KW47imsiRfOmbDX2DZqL8qEYqSF1m7e5ck+Mttf581xvLye8+r/mY2zq4EmdE+72c6tCblnozk8oODBrtY1l0Lr9U6T2gwdmTsrA9eC52LLyiXnn9qnqv+lOgF4XX6ozfb26jIjXSpiMMy2hkCdm0/XonAO10pIjAIYE5Zpv9jZCsMqa0Cagrn9yLJyF7s2wYgl9ynk2k5tHQ8V3KsyNQ8jMWPQAVSHixXFFkpFegJicN3imqd15hQpNGqhY7QFGv6AXQSInMsPyi5vc8swHA4vcNxji4vSzN2jArD5VHuW4PTplkRdfiwxNW27kvS3d8bP+JyQaBMXXp0CsthOnzV/ZUNSOPUQJhaox54D8JePlZJZHiBC2eiNZXz2Jldou3qNG710SzHxlr6JuKAx3e9KnNFtd1YE2nfIYAUsVS4z3UayoiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(6049299003)(376014)(23010399003)(4053099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVhzQ00yWE4wZDdBeXYybkZBZm00N1BZbUM5TGFhOTFCM1NQVythSmVUQUll?=
 =?utf-8?B?ejlYRWJWaERHblg0cVV0Vk03dVZKUGhYem5SR3NEellPai9ibTJUQkFCMkxU?=
 =?utf-8?B?ZCtwUllDLzVnVjRuNmc1eitqaWxBc2FDemZXRXdCVFplZVJocy84MWhvbFln?=
 =?utf-8?B?NDBJUzNOY0VBWG1aVWhrSE9Jc2Vhd0FsUmF0eTVHaUk1Tkg4Z3dHc0o1RUhj?=
 =?utf-8?B?RkE1REZDYVNnT3VJR2pvdy9QbUN5OHk0djdNazNQSmJGTXFlVlUzdjBMTytF?=
 =?utf-8?B?WEljQm5wbW5UcVo1THRWUlFWTFJwZTRWRzkwVVlyM2RFeldWU3hBN3NiNEVP?=
 =?utf-8?B?d0VsNVBOVmdxL1NvY21xRk1hZU94bW45WDhzT3BPWXlPZDhaNHdIM0ZhUUtN?=
 =?utf-8?B?WFZPdGtZMTZzSGZCUzM5UnY3OUtIZWJUdE5tQisrbzdZdTNkNjJDOW9CTzdZ?=
 =?utf-8?B?RGhnODZLMHdzdkNMTTZZWW91dGNmS0JyUjR0bG5rQmE2dkdLTUhaZWVRZmEx?=
 =?utf-8?B?ZU95eitUYTlZdE4zOHZWOHJiT0VrRkNjSVVpL3pZaVNlV25KTHJnb3E2N0ZM?=
 =?utf-8?B?ako4WUEyOXVXMjRid3ZzcnZVbldDWVJwWm8rVjh4OFJRZy94d2t0V0JmT3Jj?=
 =?utf-8?B?L3JZdTE3c1hoRSszYi9vOTJSbjAvVCtkK1NZVERQeU5yUE5PWEVJOEIrcEwy?=
 =?utf-8?B?Unh3dlBDTCtGQmI4Z1h4UDErdXV4QnBEeTk5a1JBOHVyUjdqZ0ZnVEpsNDBS?=
 =?utf-8?B?SmFRU2RFUG9nb0JEZktuVExlV2NzRUhpMHJrSno4Ujc2T2E0ejJpckxUeWE1?=
 =?utf-8?B?cENuaVUydy9hVitPN0JaVjQycUU5LzJFbWFxWVl5S3BNMmxmS29UQ0k1QndI?=
 =?utf-8?B?bDI1a0NwU0VrTm5MQzR1b1hnZlh6Y2IvQkFiMXVzODZYV0NUQ0xIL0Y5NVo0?=
 =?utf-8?B?NFU2UjRTbWoxdGQ3clJrVFdtazdsc1ZicktHSXNKY3B3MjhNb2xadWtKS1Rz?=
 =?utf-8?B?R2FHWEhsakY5WVdpcUdldGpzRVhsM2lRQ3pnYVJrdkRCNDZETkxCOVZldmxT?=
 =?utf-8?B?a3c4bDhUUUI4MmV4a0RiRGxPdEVVQ3NZV1RBR0QvN1JPZDB1MFAvQkRKVzZO?=
 =?utf-8?B?ZExIWUphaElSdEhtQWpDYy9md0M5MjdOZFhhSzZjOE8zcjhWc1RCZmRlZ1dY?=
 =?utf-8?B?WG1uZE9QamNDZUowaXAvZnMrMlgwOXJYaXJzQUNGcTVvRWhxVVh1R3BZL24z?=
 =?utf-8?B?cEpoVW1aMXQxYlVEQnUrQWYra3JEYi9SWVg3cHJQVUxmdHhZeGNxNzhHRUo2?=
 =?utf-8?B?QXJad0pud2RYbWhBQVNPNXZRSWhqbHJNaEVmOGdsMnhQNXlYdUFXalFsbG9u?=
 =?utf-8?B?TnpmcjA5aXlHS3JqWGZRNWxyYURieTZhUzFXZmhNcGs4UlllaUxzcmY4YUta?=
 =?utf-8?B?MVpQL240ZlFSZ2FBV0tDaldFa2lCVklmbGRtcGRHZlkyNHhLT01FRGMrV1hQ?=
 =?utf-8?B?VFE5b1Y1SWdscmN3Y1lhUE5zMjhnM3cybndoWndxSlpIa0tJT1NoRDVjUzBF?=
 =?utf-8?B?RDJCM3hLWDRZTm1WMDhJVzYrTmJuTEFPV1VNd0Y2NEVia0I1OGczeGV1K1NW?=
 =?utf-8?B?bHc1VW9VQVJGRUZybnZuRlpsMlo0NFlldGV5YzBqQnY3VkU1YlNnV1lieFY3?=
 =?utf-8?B?dUNrK2djaVVuUkd0aTFGUTdZeWxRSTN6OHhOYXdZak1UeTVoaHpMZm1rUGE1?=
 =?utf-8?B?MzdHalNubFQwdHRoVHNCRnNVTEsxejZQVWtPS2ZkWWNJdlZEWmRacDZCY3Mr?=
 =?utf-8?B?K2xjZFBiamJlYm51dWU1V3Ewb0NGOTdYQ2RoNktSWkpBRldsVWw3dTV1S1lj?=
 =?utf-8?B?Qk9FdGtBR1hZT2lhUzEwYlgweWRVdkJJYmtkeVJZa3ZnNldUcWl3WFB2V2hZ?=
 =?utf-8?B?M2JZUHBPRHIvdk5QSnVEVE1VditwZ21WM3p2UEExdmFWelpzalgvV0Nuckt4?=
 =?utf-8?B?SW9CdXFwYWF3MXptM25QT05mS0NxNjR4enlqam9PWXV5Z2wyc1dncThtUkd6?=
 =?utf-8?B?SFBSaUJJUHkwU09La0tsK1VIYXE3RGlKSEpJVlVubnJqY29PQ1RTMW9Fc2JF?=
 =?utf-8?B?T1Bja3BiUmhkU3FlSzVteGgxQjNxNEdnWjNBYUVaakpHRWVRaVFRR0YyTVJL?=
 =?utf-8?B?YytxOHJGRkdXNWdCMEtKNU1xMzBsMnU0OTlna0lwTUVjczdxdGdidnJ3WW1s?=
 =?utf-8?B?RTdNTkdvWWgwYWxrbGZEa2Vqc0kzZ3FoK1NDYi9NR1dmMlpLMytTN2hnQ3N3?=
 =?utf-8?Q?I+SBaqFG6ul2UGeofL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611b1907-8235-4e31-554f-08df0cd50e93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 11:42:12.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSj/IeOI0Mka/S0LB/Lvo3aa3hJrQeoziaBLVIqtpxoPTBqsQo3pIeDyIBrtRWhj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

--------------I1lhfYSJRAiO3DgVMEedbOnX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/26 21:06, Philipp Stanner wrote:
> On Fri, 2026-09-04 at 14:49 +0200, Christian König wrote:
>> On 9/4/26 10:31, Philipp Stanner wrote:
>>> On Fri, 2026-09-04 at 10:20 +0200, Christian König wrote:
>>>>
> 
> […]
> 
>>>>
>>>> That sounds like a bad idea as well.
>>>>
>>>> Dropping the fence->ops is to detach the fence from the module
>>>> which originally issued it and not solve lifetime problems
>>>> between the scheduler and the driver.
>>>
>>> It can be used to solve that problem though, can it not?
>>
>> Yes, but I think forcing dma_fence implementations to drop their
>> release callback to fix lifetime problems with the driver and
>> timeline name functions is a bad idea.
> 
> The issue we're facing is not so much related with life times, is it?
> 
> Even if the driver correctly tears down the scheduler (i.e., signal all
> hardware fences), this problem still exists.

Well no, before patch "035219a760ed dma-buf: dma-fence: Fix potential NULL pointer dereference" everything worked correctly as long as the driver waited for an RCU grace period before tearing down the scheduler.

After this patch we now messed up the lifetime for the scheduler fence get_timeline_name and get_driver_name callbacks.
>>
>> We should keep this fix simple and focused so that we can easily backport it.
> 
> My hope would be that the dma_fence backend solution can be used that
> *already exists*. That could then both be simple and maintainable.
> 
> 
> Correct me if I'm wrong, but it seems we have not found an alternative
> solution that can work yet?

I think we did. The problem was introduced with patch 035219a760ed and I think we should fix it there as well.

We just need to start checking for both the ops and signaled status in the dma_fence framework.
>>
>>>>
>>>> I think we should rather re-consider patch
>>>> 035219a760edb35ae9a9e96beba7f122e26a997b ("dma-buf: dma-fence:
>>>> Fix potential NULL pointer dereference"):
>>>>
>>>> Here we changed the check in dma_fence_driver_name() and
>>>> dma_fence_timeline_name():
>>>>
>>>> @@ -1167,7 +1167,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>>>>  
>>>>         /* RCU protection is required for safe access to returned string */
>>>>         ops = rcu_dereference(fence->ops);
>>>> -       if (!dma_fence_test_signaled_flag(fence))
>>>> +       if (ops)
>>>>                 return (const char __rcu *)ops->get_driver_name(fence);
>>>>         else
>>>>                 return (const char __rcu *)"detached-driver";
>>>>
>>>> The problem is that we didn't considered that there a fence
>>>> implementations which still have a release or wait callbacks but
>>>> rely on not needing to return a string for a signaled fence.
>>>>
>>>
>>> Could we move the signaled check to amdgpu and pvr?
>>
>> Yes we could. I also considered that. But I would rather like to see
>> it handled in the common dma_fence code.
>>
>> If I remember correctly either Tvrko, you or somebody else was in
>> favor of doing "if (!dma_fence_test_signaled_flag(fence) && ops)"
>> here but I though that this was unnecessary and we would rather
>> remove the release callbacks. Maybe I was wrong with that.
> 
> I hope that wasn't me because that again looks very racy.

Why? Tvrtko added the RCU protection for that.
> I think that there is no way around using the spinlock. As I have
> pointed out many times, the fact that the signaled-bit is set with lock
> protection and read without it is fundamentally broken :(

As far as I can see the RCU approach works just fine, the problem is only that we dropped the check for the signaled bit from the common framework and didn't considered that scheduler fence and a few other weren't changed to not have a release callback yet.

>>> IOW, we keep the solution presented here (removing ops->release for
>>> finished-fence) and the few drivers that check whether a fence is
>>> their
>>> own first do a locked dma_fence_is_signaled() check?
>>
>> Works for me as well, but as I said I would rather like to keep it
>> simple and stupid for backporting.
> 
> If you can think of a stupid and simple solution, shoot. The only thing
> I can think of is moving the string into the dma_fence, as a hard copy
> :)

See attached. It doesn't fully solve the problem, but it gives us the status again we had after Tvrtko's RCU protection work.
> In the mean time, my proposal is to keep aiming for removing
> sched_fence->ops->release and fixing pvr and amdgpu.

Hui? For amdgpu that is completely irrelevant since that driver only destroys the scheduler on driver unload.

And there we always had the problem that when the module is unloaded we pretty much crash the kernel because the ops pointer is still around.

Regards,
Christian.
> I think that will have to entail a signaled-check. Question would then
> be whether we place it in the driver or the backend.
> 
> 
> P.

--------------I1lhfYSJRAiO3DgVMEedbOnX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-dma-buf-dma-fence-fix-checking-signaling-bit-for-tim.patch"
Content-Disposition: attachment;
 filename*0="0001-dma-buf-dma-fence-fix-checking-signaling-bit-for-tim.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlNzBhZWJkOTEwNmY2OTUxNzk0MzkyNzNiZTk4NWU1ODllNjNmM2RkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Q2hyaXN0aWFuPTIwSz1DMz1CNm5pZz89IDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkRhdGU6IEZyaSwgNCBTZXAgMjAyNiAxMDoyNjoxMyAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBkbWEtYnVmL2RtYS1mZW5jZTogZml4IGNoZWNraW5n
IHNpZ25hbGluZyBiaXQgZm9yCiB0aW1lbGluZSBhbmQgZHJpdmVyIG5hbWUKTUlNRS1WZXJzaW9u
OiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJh
bnNmZXItRW5jb2Rpbmc6IDhiaXQKClRoZSBwYXRjaCAiZG1hLWJ1ZjogZG1hLWZlbmNlOiBGaXgg
cG90ZW50aWFsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSIKY2hhbmdlZCB0aGUgY2hlY2sgdG8g
dGVzdCBmb3IgdGhlIG9wcyBwb2ludGVyIGluc3RlYWQgb2YgdGhlIHNpZ25hbGVkCmJpdCB0byBh
dm9pZCBhIHBvdGVudGlhbCBOVUxMIGRlcmVmZXJlbmNlIHdoZW4gdGhlIG9wcyBwb2ludGVyIGhh
cyBiZWVuCmNsZWFyZWQuCgpUaGUgcHJvYmxlbSBpcyBub3cgdGhhdCB0aGUgb3BzIHBvaW50ZXIg
aXMgY2xlYXJlZCBvbmx5IHdoZW4gbmVpdGhlciB0aGUKcmVsZWFzZSBub3IgdGhlIHdhaXQgY2Fs
bGJhY2sgaXMgaW1wbGVtZW50ZWQgYW5kIHRoaXMgaXNuJ3QgdHJ1ZSBmb3IgYSBsb3QKb2YgZG1h
X2ZlbmNlIGltcGxlbWVudGF0aW9ucyB5ZXQuIFNvIHRob3NlIGltcGxlbWVudGF0aW9ucyBsb3N0
IHRoZSBSQ1UKcHJvdGVjdGlvbiBhZnRlciBzaWduYWxpbmcgb2YgdGhlIHJldHVybmVkIHN0cmlu
ZyByZXN1bHRpbmcgaW4gcG90ZW50aWFsCnVzZSBhZnRlciBmcmVlLgoKQWRkIHRoZSBzaWduYWxp
bmcgY2hlY2sgYWRkaXRpb25hbCB0byB0aGUgb3BzIHBvaW50ZXIgY2hlY2sgc28gdGhhdCB3ZQpo
YXZlIGJvdGggdGhlIHByb3RlY3Rpb24gYWdhaW5zdCBOVUxMIGRlcmVmZXJlbmNlIGFzIHdlbGwg
YXMgdGhlIFJDVQpwcm90ZWN0aW9uIGFmdGVyIHNpZ25hbGluZyBmb3IgdGhlIHJldHVybmVkIHN0
cmluZy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KRml4ZXM6IDAzNTIxOWE3NjBlZCAoImRtYS1idWY6IGRtYS1mZW5jZTogRml4IHBv
dGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UiKQpDQzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZyAjIDcuMisKLS0tCiBkcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMgfCA0ICsrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5j
ZS5jCmluZGV4IDA1MDkwZmIwZmQ1YS4uZTkyZjlkZjhkNjNjIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2RtYS1idWYvZG1hLWZlbmNlLmMKKysrIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCkBA
IC0xMTcwLDcgKzExNzAsNyBAQCBjb25zdCBjaGFyIF9fcmN1ICpkbWFfZmVuY2VfZHJpdmVyX25h
bWUoc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UpCiAKIAkvKiBSQ1UgcHJvdGVjdGlvbiBpcyByZXF1
aXJlZCBmb3Igc2FmZSBhY2Nlc3MgdG8gcmV0dXJuZWQgc3RyaW5nICovCiAJb3BzID0gcmN1X2Rl
cmVmZXJlbmNlKGZlbmNlLT5vcHMpOwotCWlmIChvcHMpCisJaWYgKCFkbWFfZmVuY2VfdGVzdF9z
aWduYWxlZF9mbGFnKGZlbmNlKSAmJiBvcHMpCiAJCXJldHVybiAoY29uc3QgY2hhciBfX3JjdSAq
KW9wcy0+Z2V0X2RyaXZlcl9uYW1lKGZlbmNlKTsKIAllbHNlCiAJCXJldHVybiAoY29uc3QgY2hh
ciBfX3JjdSAqKSJkZXRhY2hlZC1kcml2ZXIiOwpAQCAtMTIwMyw3ICsxMjAzLDcgQEAgY29uc3Qg
Y2hhciBfX3JjdSAqZG1hX2ZlbmNlX3RpbWVsaW5lX25hbWUoc3RydWN0IGRtYV9mZW5jZSAqZmVu
Y2UpCiAKIAkvKiBSQ1UgcHJvdGVjdGlvbiBpcyByZXF1aXJlZCBmb3Igc2FmZSBhY2Nlc3MgdG8g
cmV0dXJuZWQgc3RyaW5nICovCiAJb3BzID0gcmN1X2RlcmVmZXJlbmNlKGZlbmNlLT5vcHMpOwot
CWlmIChvcHMpCisJaWYgKCFkbWFfZmVuY2VfdGVzdF9zaWduYWxlZF9mbGFnKGZlbmNlKSAmJiBv
cHMpCiAJCXJldHVybiAoY29uc3QgY2hhciBfX3JjdSAqKW9wcy0+Z2V0X3RpbWVsaW5lX25hbWUo
ZmVuY2UpOwogCWVsc2UKIAkJcmV0dXJuIChjb25zdCBjaGFyIF9fcmN1ICopInNpZ25hbGVkLXRp
bWVsaW5lIjsKLS0gCjIuNDMuMAoK

--------------I1lhfYSJRAiO3DgVMEedbOnX
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-drm-sched-document-the-RCU-dependency.patch"
Content-Disposition: attachment;
 filename="0002-drm-sched-document-the-RCU-dependency.patch"
Content-Transfer-Encoding: base64

RnJvbSBiOTNlNTI1MDFlODkyMGE4ODEyMjcwMTEyMTI5MjBmYTg0MjQ3NjM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Q2hyaXN0aWFuPTIwSz1DMz1CNm5pZz89IDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkRhdGU6IE1vbiwgNyBTZXAgMjAyNiAxMDo1OTo0MiAr
MDIwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBkcm0vc2NoZWQ6IGRvY3VtZW50IHRoZSBSQ1UgZGVw
ZW5kZW5jeQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJz
ZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVHZya29zIHBhdGNoZXMg
YWRkZWQgUkNVIHByb3RlY3Rpb24gdG8gdGhlIHJldHVybmVkIHN0cmluZ3MgZnJvbQpnZXRfdGlt
ZWxpbmVfbmFtZSgpL2dldF9kcml2ZXJfbmFtZSgpIGNhbGxiYWNrcyBvZiB0aGUgZG1hX2ZlbmNl
CmJhY2tlbmRzLgoKVGhpcyBmaXhlZCB1c2UgYWZ0ZXIgZnJlZSBwcm9ibGVtcyBmb3IgYSBjb3Vw
bGUgb2YgZHJpdmVycywgYnV0IHdlIG5ldmVyCmRvY3VtZW50ZWQgdGhlIGNvbnNlcXVlbmNlcyBm
b3IgdGhlIGRybV9zY2hlZF9mZW5jZS4KCkFkZCBhIGZldyB3b3JkcyBvbiB0aGUgZnVuY3Rpb24g
ZG9jdW1lbnRhdGlvbiB0byBub3RlIHRoYXQgd2UgbmVlZCBhbgpSQ1UgZ3JhY2UgcGVyaW9kIGJl
dHdlZW4gc2lnbmFsaW5nIHRoZSBsYXN0IHNjaGVkdWxlciBmZW5jZSBhbmQKc2NoZWR1bGVyIHRl
YXJkb3duLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwg
NCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX21haW4uYwppbmRleCA2Y2I2Zjk1NDY0OTMuLjIyMTAzY2IwNzc4MiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKQEAgLTEyMDMsNiArMTIwMywxMCBA
QCBzdGF0aWMgdm9pZCBkcm1fc2NoZWRfY2FuY2VsX3JlbWFpbmluZ19qb2JzKHN0cnVjdCBkcm1f
Z3B1X3NjaGVkdWxlciAqc2NoZWQpCiAgKiBpcyBpbXBsZW1lbnRlZCwgYWxsIGpvYnMgd2lsbCBi
ZSBjYW5jZWxlZCB0aHJvdWdoIGl0IGFuZCBhZnRlcndhcmRzIGNsZWFuZWQKICAqIHVwIHRocm91
Z2ggJnN0cnVjdCBkcm1fc2NoZWRfYmFja2VuZF9vcHMuZnJlZV9qb2IuIElmIGNhbmNlbF9qb2Ig
aXMgbm90CiAgKiBpbXBsZW1lbnRlZCwgbWVtb3J5IGNvdWxkIGxlYWsuCisgKgorICogVGhlIHNj
aGVkdWxlciBmZW5jZXMgdGltZWxpbmUgbmFtZSBpcyByZXR1cm5lZCBwcm90ZWN0ZWQgYnkgdGhl
IHNpZ25hbGVkCisgKiBzdGF0dXMgYW5kIFJDVSwgc28gYW4gUkNVIGdyYWNlIHBlcmlvZCBpcyBu
ZWNlc3NhcnkgYmV0d2VlbiBzaWduYWxpbmcgdGhlCisgKiBsYXN0IHNjaGVkdWxlciBmZW5jZSBh
bmQgdGVhcmluZyBkb3duIHRoZSBzY2hlZHVsZXIgd2hvIG9yaWdpbmF0ZWQgaXQuCiAgKi8KIHZv
aWQgZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKIHsKLS0g
CjIuNDMuMAoK

--------------I1lhfYSJRAiO3DgVMEedbOnX--
