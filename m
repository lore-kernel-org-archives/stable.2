Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020075.outbound.protection.outlook.com [52.101.195.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A9221DAE;
	Thu, 15 Oct 2026 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027578; cv=fail; b=WnuN6T9fXvf2oDh1ZvaUqj5O83dTIRdjpTmXRRMfLj1uaQK5aFwDn32pOSM5qkBP9Aw2ADCJJ0ImQEClk1bX6HflPBmeCn+zmSKzgi0rhMkcCXsfC/3UcO4ib0rDTAV2cRLbygTF+yX+9PLfDss6BLFAWKyioXIjyjCLHn0L8U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027578; c=relaxed/simple;
	bh=XxB3/jMuKFfA8d6XdaOek7hZRyOyBiVhBmRdDLqYx0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VrJ/nkezFWlLdXgeKQOHG+0H1P4vOqPyh3m4pPR7TymEVcDd6GK45tY9UwgH9iOXBZqndEzrF9gFYJ7tF64eiIFQcLH9B9qswu9OpG1Pi/JuRyrWgpTlDjeoXyybgelJw+CPjHSgkwiFx0x/bzxaHlvPv9LWB9PZyyr+uSEmh9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdWeTqDzZaQ9EpMlQvx/TNjqy7qVUHvxraOekrhaASiuQAkDxZFwAyZ2SmqwKLkWewTNhIDN91yC/4ONMLCJ/QU4fj/p9cM4B+irAe7IKlEblJtDW2PWjeV4XZ7zZBeh1Eg/KpZIsJimkPUoz0m9lddOnV30oASWH7vLbvVo6lo6VNm0yQ9ERpwYqSisC1qKk41xXn3DYZ5w8k0cYyDx2Qg456QeooxsAKEFEp/pMsXtTXldTYLGkmLxT4lb8btO2y+8GNkawRupA/Ff8eipMKeNdM+VC0qTPy68bsba7RnCrv5EaNb/RTDu3VBvLBqFOqljSbw6aOY1+CLgukzh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ryfidRekTnhdPEcJqiZLf4z/B3LspQMgh8kXHDy21HI=;
 b=ZLCbpO3/YLEyQuTyvYvNnESBTTWvmo5RKauF3bPaqnBUshzJpvKTyEXQdvAbGgTXI7sSCtefJQsjqmXePC4IJqM/rhEIi/FbqX/m6sDSNV7w0ewlm27gj5TL4Yle9b79cd/KnYIEvzNcLA4brsas6wORwFlY7iobN0hgp0ZzgAssS6j/NBKKUSoO7me+o7mQKCF3svxPi/wTPjiCU+Io9iT/W7PYOFWw0EXaPwP4K6/xpBvAn14oqh0bUY+cb5nTg8sULP/C1HmpUg9QngdVACa9hav9Qy5TCb0VKeBcvY9y6yK229LrS+GUR8tz0+Cr3uX12K/mwsb9EyFnDEc0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB2862.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 01:26:13 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:26:13 +0000
Date: Wed, 14 Oct 2026 21:26:09 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <tom.leiming@gmail.com>, axboe@kernel.dk, hare@suse.de, 
	sean@ashe.io, neelx@suse.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <nid24ukygf5d76hbz7zt336fftcuiqixgnr5k4m4ubbmnnkepv@e32ydy6h7ker>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
 <adebd7c36fe4c6e349aca65bd7820079@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adebd7c36fe4c6e349aca65bd7820079@kernel.org>
X-ClientProxiedBy: BN9PR03CA0734.namprd03.prod.outlook.com
 (2603:10b6:408:110::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB2862:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efde74f-14c4-4181-4d0b-08df2a5b4ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pLqXC4fJOkvNGTcylWRJTMpsr/4KUlRirxxApBGT3fndBN2/vkrWp6Xe3ITWJa4XO3kB94b3IOuM0y70C2mDaLdkhRwjabckSIMSZsWoaPavtr09azwlAIi5UgT3UuoyDbX6B6OggsyKZFIcaV2DY61RupnDgp56kDPN7sIn0WdNTrAGJ6Jvh70vGWnp5DL5amCT2P1HP4iojqjK4CkINRhO8KsjWijHTAu6wkCZNrObNHyDmUDVPfl5NE7Q6Nm0xwIdv9cHbMiK5ub29rQji39F7dOocg0t9WpwW2f9KUHeP1AK8zgBY9wKODq0kH0u8rP6p5v8LLOBeXtazQ3A1JHfW+3tDVtmTdfuq7LgWgPng1CbSuMEgnbbiIuCijePpbJKcMxXuyUQFOrHb9FF3EVfftR9eE5TNW8dMd+8ULdXGhS/VlSraXIqMLeKRtKG8sMoVsi8AKw8zIbmENJ28BStpJ6ETVqHaT+Wjh5Tvuaym/707efrYJOzIQqxT7vV3fS8xw0KHl4eu01T3zvaKCmu4yh9tIka3OERJi+RmMFpVRuidqjf/jQLIvl3ckravo0Fb7AjHlRpJA1xBtLcVIlgwq0n5uvwtSbrNZgJgbyRYeHDVau1m+axRlKymUAADZALmdD0dpnQCSpKXDHOLTsA506lWF3KJTxPEDpQo6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWN4aFd6NkQxRFRFaEdhUXErRTMyZTVUZDBLT3RZR0o3MDFDTHhRVk9hYlYr?=
 =?utf-8?B?SWFrREdnRXRXMzhkcEt2a0RlUWUxd2hBK05GWVE0TzJQNi9QM2N6ajY3TWdw?=
 =?utf-8?B?MkJiNmJERjIxbTBQaTRDVmhSWFhkWmYxWGJmRjBtRXpvRDdKVG5Sa1NuNDJj?=
 =?utf-8?B?d0lhcHp1SllYNFhYdldVaTVya3NHZUlWbVZ0QlA0ZFNoSGNZakswd1d2bDIr?=
 =?utf-8?B?V09lYVpVdlpXZDZWRENwdFRBYjd4MFNBQmJJcVVWUVlsb1MxYU5NYk5BQXlL?=
 =?utf-8?B?VmJ6WGE2SW5LSlZyam1FbkFaS0pFbVZLT2Q3RVJWYXpFdnhrMllpVDV5UDY2?=
 =?utf-8?B?cWVNWW1CTWdJY2hqM0VtT1NGRTVFY1UxVm11ekVJN3pLeG1xWGdpWEczOWZH?=
 =?utf-8?B?ZUVpVUk0Zjgvb3oveXAzOWliQUhLTytjU0dPYXYrVzdPYUlHcW5haUJqQlZL?=
 =?utf-8?B?anV5WGhKRC9rSzFPbTBEdkpFQ2FkUGFJOGZ4MmR1Vkd3WWlkcnU2aUoxdFlF?=
 =?utf-8?B?UnhJYTlsZXJOdndidXlKVmxxckpFK00zK1lSTFBiZlVKOUE1Rm1VcHFvVEdQ?=
 =?utf-8?B?bFV5UWtvZDA1ZVdxSXRyVlhlRkFkOG93ZFcrQ1BnKzdrWHRCdkZTQnJVN2ZE?=
 =?utf-8?B?NlA0YUJPWS9MZitJOC9wV1g2MEl3VHNyekRneURFbDFBTXdNZGwyaC82TndQ?=
 =?utf-8?B?czhJT2sxRUVscVBocDZyOGFrdmY5ZUxHelhyZ1lrdFBweGJlaTVtKzd2eCtj?=
 =?utf-8?B?QTlsTTVQb3E5ZW1nWm1oS2pEUWtPNnFoK1J0VjRjT2VIVFN0SThIS1dWMkVu?=
 =?utf-8?B?ck15WU5TOTBYNXRDNHpWMWZoMVFqaWxIMm1CLzI1Yzc4U29zUDY4R0xhN3hr?=
 =?utf-8?B?L1VFZU9BM2ZEZ1c4YUk3OC9uWXc2VU5IZjBaM0pTMUE0UDl6SXV2cERLV2pQ?=
 =?utf-8?B?cSttTWpTOXhhd3pNbE50M2IzczhNaVhUemRJZXBvbXlyMHcrbGNxTS9XaWNx?=
 =?utf-8?B?VDlFSU8yV3NDZG5McGczSXE5UjdGV0JsU1BLaGNzcHJHcmhydGllbU1iaW12?=
 =?utf-8?B?MTJ2MXRsQ2VuZU9IbEhzV1EwRHl2akJKanRqZkxaS3VvM2FxL2UvRDRMa3FJ?=
 =?utf-8?B?MnpxSzdxTTVta0F2NG9DcXFCZHhNcHB1UGhiS3dodmFLMFlhTVFLU3RBSDBk?=
 =?utf-8?B?dC8rdW1SbHVJOVhyWmlBK1pvKzZtbzdUWnFXYWNydEU2V1ZzbmxiakpaUHBn?=
 =?utf-8?B?VUczdWc4MFZFazBYS3F3N3N1MmFsb0QzSFZKOXpMSVFBbkMrMWYzeUl3NUVL?=
 =?utf-8?B?RDVwUnIvdXpPeUk0WHBsbHhoSk1xdDduekRTaURyZ0p1SnJueDRRSFNKeTZh?=
 =?utf-8?B?Y0ppV1A0dzNmaW9Jc0xzQmFrZER4ZG54cXhCSUw0TXUrUUNzeU83K2pqUVZk?=
 =?utf-8?B?bWFLRkZxNTBOZE5xb2pHNUZ2bC9oRW9uWmorZlMvN2s3ZHI4aHJIK2c0aUhR?=
 =?utf-8?B?WERFb2V3c3N0WWxKeHM1ZFFOdzRHUVlzeFNCZkZNQTM5NGxHUGZReXI5RWpw?=
 =?utf-8?B?RHZvc1A1Qm1HTVRTQXVLajZXZzFRMEZmRllhbXNZTWk4ZVhDeWt6ZGxJbmNi?=
 =?utf-8?B?YlJXNEd3bFJTSUZzWGgzLzBVZnNPUVgwQ3QvbXAvTk9ZMnZsd2orM2dKby9L?=
 =?utf-8?B?bXAyQmtZTFc3a1ZFVmR4bXJMWjBYRXFxUkcwb2tyZ0NHVmFNTkdsdzJEWXBp?=
 =?utf-8?B?TktCbHlUdHg3REk5aDhjS0FEeS9pUEJ3WTY4M3VRWVV5OXl6ZytweUZKYldm?=
 =?utf-8?B?SzZrZmo0ZWkweHFWeG9qQjM1VHAyTkRCbnV3Z3picmpiL3pLUm1PN2kwZzNP?=
 =?utf-8?B?cFE5RU15MmlGR1V5Y2hzMmNuT0FOeWNKWm40b3hEVzJoQThlZEh1ZVVlekVz?=
 =?utf-8?B?Zk55ZVBCSElaajZpbHUralB5SjI0S3FIVkhFRnZibmJSUHpBUUVRYTZoYmZl?=
 =?utf-8?B?b1JyZTVMaW9qRThQV3NDNkRzNWlmSlZTWXVWT3o4V3pyMW5kQzhNS3RTOU1E?=
 =?utf-8?B?Ymd1VVh3WVRudWdZTmUrOHc3ZGRZYTE2bEViaEhvNFI4SmV5aHdLWE5vSVhJ?=
 =?utf-8?B?RTRkSnVGZFd6bVdxVjB2ZVViYmFjblV2cDZXMm5ZNlgxZi8xbDk5Y1lKYmYz?=
 =?utf-8?B?bVJpaFFNdVgyVlkzQzgxNk1jOGV4WGFBM1ZYcDV5UEhJRVFneXlHV2N4K1ZJ?=
 =?utf-8?B?Y2ZxQzRXcG9BOEtQcUQvaHBzdDBMOExWQkMwWFFwaTVVU0V2RTNHbnJGVDBi?=
 =?utf-8?B?ZllTN05yT0xTMHdTeW1uN3dBWGlNL3FXUFpsL3ZXeDNzTCs4aEJhQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efde74f-14c4-4181-4d0b-08df2a5b4ce8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:26:13.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrV7aF5P+aHmyU1gKXydIrWXKmZm7KkskFm8BvB/7KX5FxlA8B1Buv7in0hsexrXUPC49h0cDGCRp4l0aIIEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2862

On Wed, Oct 14, 2026 at 09:34:04AM -1000, Tejun Heo wrote:
> Hello, Aaron.
> 
> On Mon, Oct 12, 2026 at 12:06:25PM -0400, Aaron Tomlin wrote:
> > kblockd_workqueue is unique in that it is allocated as WQ_PERCPU to
> > preserve per-CPU locality for multi-queue devices.
> 
> I haven't followed the earlier discussion, but if CPU locality is important
> without requiring hard per-CPU affinity, an unbound workqueue with
> non-strict "cpu" (or "smt" for core) affinity scope can provide both:
> locality by default with flexibility to migrate when needed.

Hi Tejun,

Thank you for your response.

That is an elegant solution. Moving kblockd_workqueue to an unbound
workqueue with a non-strict "cpu" affinity scope (WQ_AFFN_CPU) would
preserve the per-CPU/per-queue locality essential for multi-queue devices
by default, while delegating CPU isolation natively to workqueue core via
wq_unbound_cpumask. It would ultimately eliminate the need for blk-mq to
maintain ad-hoc cpumask filtering or manual housekeeping redirection.

The rationale behind the current patch is strictly as a targeted, low-risk
bugfix. Commit a46c27026da1 ("blk-mq: don't schedule block kworker on
isolated CPUs") attempted to offload queue dispatch when all mapped CPUs
are isolated by falling back to WORK_CPU_UNBOUND:

        /* Switch to unbound if no allowable CPUs in this hctx */
        if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
            return WORK_CPU_UNBOUND;

However, because kblockd_workqueue is presently WQ_PERCPU, WORK_CPU_UNBOUND
resolves straight to raw_smp_processor_id(). When deferred dispatch is
triggered from an isolated core, the kworker is scheduled locally, where it
faces severe priority inversion and starvation against SCHED_FIFO
workloads.

Given that commit a46c27026da1 was backported to stable kernels, this
minimal change serves as an immediate fix suitable for stable trees without
altering the concurrency and execution semantics of kblockd across the rest
of the block layer.

That said, I would be very keen to explore transitioning kblockd_workqueue
to an unbound workqueue with non-strict CPU affinity as a follow-up series.


Kind regards,
-- 
Aaron Tomlin
