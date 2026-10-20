Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792529805;
	b=LotI7TsIoqaxlg6OUlMxhMCqo0fLjrOBPiGErcBXZNU52mZ5kKpKmKIsZzkGEqdT495o
	 DfJRYcPNqR4MyTVhbiMGYXX2q9elRW/XntNKyCxzj+qgq80M3LKC38vRI6kFRAsEsjkeM
	 C14m4RRMLGsOrqqb7801vEhGsbV57JxixHg9pc61ZnAUnlZuPqQ3O6+svbaEAFmR/R3us
	 wVgUxi/dr8FrXHoNEyxHYNZYiIpXAChe/XtEHWHq8gJytQXtPxWKIT+TVobtmESE4FmHS
	 wabzEuL0B+8iB4EDimQIqH3tRljZ//1MD8OJebw4WE7lhFFFWbTJHAq9y0Wqs+cannQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529805;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AMUfAPzgGAp7Fu3sI4UGBnmzd20C4otVTH9XKEtgVwM=;
	b=TELtggduMdQeHC6mDValPmERV0lgs3tnKe0tuFoKEhdodi2rt4/z+crowep8HwQ3ogKU
	 AhB17KnxsOrP1h2PEsu1SOE3aR1W2a83lNT3MkxAuZiKZozcw4x7OEqbBZrJ0ebpVVOAQ
	 A9YGcCpCzu3D1RsHxhnCe7+nEw6WtxvKvPhaUVLQyx1N689AdXOARthjkyUfyI+A25t/b
	 vV+qVDsz1j4ose/I1/f4vWH+P3zDjEj0ftMF+6gj50KKo/H/4ynSTHkT8eGAQNqx1M36Y
	 0910vZyQ0jMSPuTLwMGy5rx3DijbAaVFAdr+dlQ2SGWQ1GNiG5ZoBHBIq+5ho1dQFcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.75
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020075.outbound.protection.outlook.com [52.101.196.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F397606A31A;
	Tue, 20 Oct 2026 20:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F397606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS1fMzolahZz3bGdQKK5b8ixAoEGYV0kCZBoOskxF9lxMZNb15VMHzd/Z/VP2JpTLmwkWI3p2/g2X2ONtAO0zZEeqW+dUZc/GVtnAaWS6LJDGUwv9vqbsCucs+8kJy0bOcnMav9xT9yWeHJ9L76fMLscx/zjnA59CxC+Z9k3n9cH8zYBeWrhWzE+fLwA8qq8dgACy4bbw8VHxyW5zuXk+Bcly90mz/JGdIMniT49JNsglFcdWFBb4eYuUZzTa8c6zwadepksLC56cyk60iVHnn8aXpxZ1b+ucah4Zi2EQPKYUo7R4G/Zu8xJPJicRf57TZYL1LDo+Jk7hv04JstFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AMUfAPzgGAp7Fu3sI4UGBnmzd20C4otVTH9XKEtgVwM=;
 b=s/G8eTYbRxi5Blr/syA9otNhLADPAHgpDkm2kHbn6bJmm/C41kOttoI+jOauV3SV64KrhN4Cz1O6x8bT/ZsQvKmXLP//YD1kCmTF75WWql1OCMDB/6ErqCpNxjuDE/BumqR/zMVI2Jyan9KuQAyR3VrDA1qeoQ159O36rWt49VOBu56aTSxcgWPzgwzFxLyP2dgxsj6wj9tHgaj7QmmZNgp5A+ucp5xk1qwtMEnrPCTbm5pBrP/rui1XK79Wmvj9LHkHD06YDkJ89dKFIjGlpVSS/fmA59Dt/LI3E4kAm318aJizK2OsTQjMZtGvPoKb9kHnCQVtqtsZaYwPAp56IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3279.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 20:56:41 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 20:56:41 +0000
Date: Tue, 20 Oct 2026 16:56:37 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	frederic@kernel.org, tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <u5pjpjnywmbvjyzmlc65ezf4gwsfvmlobevzd5j7ynwflwac43@qrtyxz2ihsdd>
References: <20261016052203.489760-1-atomlin@atomlin.com>
 <694b548c-5f34-48f2-8ccc-5aa020c76939@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <694b548c-5f34-48f2-8ccc-5aa020c76939@kernel.dk>
X-ClientProxiedBy: BN9PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:408:fb::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3279:EE_
X-MS-Office365-Filtering-Correlation-Id: bb590873-5165-4749-8756-08df2eeca441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	lCh+1/y93xoUcUw5leKON74nbhgg7DhSbkNGpVpJChLrebQAGKQRJYHe3/++mqvyFz12YR38uvlCcfbd2SaCKcuHDVxMF0h9Aw5qXz6C/HtabNV3GdkLtVZIflhcDDGUZm6nwe5l5X22d5RK9h49Vqz/UKk6shHHdSdmELKYAreYHTTF8o23UxH7VX87XtPwkUPie+IPoQ2QIRZyM1rWx/iKWNhsndAlbtspVVtozaoRdJ6vAMjBHDzWMEgT4SKIG36i7PlKLDDbZPQW0mJvMiz9pzO1IQpX7Mcei1MZTcFcGAMP5PZGNyFnL8IWz8DFU/bxjdJEHiNKFa5vt94Fg3UfHqZUl9hawDudfSLoQLefcmsytM7IJjr+WgBhrN9F/IqsQ+h88VB/qZN403Ufuwb4P0aKqQ0FZX3zf93NevaQeeou9m6XebCoP/OrWik0GnJLLhWFWg0jFkgKEmjmqaAlLwlWpf+4/QaLXtyRbIT0goNxMKLV9OOVq2czcc13wqSClLQF4sqC5BBHdp0xZdUWN14nCYub2cRHCWHXeUpoahipFZrtcd5n3YC82nQo8iJnTqkIYb/5Ily8iy1AQhh/GGVGHRtn9dw1zF+kqSAuQTtAuxsUxMYs055Cdu5ezdoJVYgFKK13pY8ZBPmUPF2X9it2lyc1wtAWwKHP+ME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJaeWV2RjhIbjYwRU11V3lpS1ZnWFR3RU5vYkxRdGxiNms1c2pJS05vLytQ?=
 =?utf-8?B?dlM2djE5Umg1akV2UTdFZDZsR2JHcjU3cERvNkw0blg0UDZCVk1ndEVVWVRr?=
 =?utf-8?B?ZHAwOXVIQTJPT0NwRFBhK0xmL0Ewd3d2b3dqNWFvQkRTTWp3TFVoQVI3Q3k2?=
 =?utf-8?B?TEZFWDVkeHgvRWtoVU93K2ZRaDlTdXJod3pTM0ZtTDR2ZE9CWG4xSUNWWGRC?=
 =?utf-8?B?a2tZc1l2bTNlRWZHRWUrQlgzQ1RsNHpvYldWQTkrMnhlL3AyZEVSc2xtc05B?=
 =?utf-8?B?YlpMNHR1VHpwZStHMnhGZkNxekh5Qk9wSmRvd1lkY3FDQ1RzbFdnNm0yQ1VD?=
 =?utf-8?B?RUFIMGZtaU5ueWlkWVVKeElJL1RiYUZTSjltU3BJVmdTbGU1VXp1RW5kaGQ3?=
 =?utf-8?B?amhPcTROSkZrSzRPaEtlVjdZTlpFS09hYTYydFNOQndnQVlPOVkyQW5DMGVT?=
 =?utf-8?B?SzU3TTFkK1lIMnVObFFEMlcvQkhZdUJQRnVGK0N3VzVydWpxc2RIbHhKSDd3?=
 =?utf-8?B?aFFEM3EvS2NMM0NlNWhOeGpRSXlCZXllVFRiWm1Fem1sb0tab2o1ZDIvSVNY?=
 =?utf-8?B?cFdXc2I1NjNXM3ZMZHFJRTgvSEliOEpPYkZCQ1NSZDRNM0Zsck91UEg2OFpt?=
 =?utf-8?B?UXJYV1NCaFlLVmhtRTFXZWxsdlU0RHJxNmFXU2ZUZnZ0TmUxS1h5bTdHTTY5?=
 =?utf-8?B?MEtzM2lUR2pQaUlQbk9SS1BuLzJ4NzFmUGVlYWd4eWdMUXY4aFJTanN1cUwx?=
 =?utf-8?B?bGNZbFN5L1pRR2VENVJYRGFhQkcwSU9hNElzRU8wYm54S3pYOUp3N20rK0lQ?=
 =?utf-8?B?VWl2eWpndDhYTkk4KzVvb2VKWVEwd0ZWWm9QeWVjNjhEeXFZY3N4aUM5RjVu?=
 =?utf-8?B?dWI3NWdyUkgveDVHSHNvZlhhWG1VVUIrM0x2dDVkRDRCUFdCMEU3K1NVNE9z?=
 =?utf-8?B?SzNMVjc3UW1mL3FVS1NqczJBdkx3bWtOMUtqczlaakNwd2Q4NWJieitwWnZI?=
 =?utf-8?B?T2liZHVpVFFTWFB0WkJYSlBYeWMwZmthV3pDNHBTQzMzYzgyc1FxcVpHbFRz?=
 =?utf-8?B?SC8yRDdMT0lMK292aXhZRDhnclE4L2ZiYU1yb2E0QmpvcXQvaFdwcnpLWVFt?=
 =?utf-8?B?bW9pUmtCY1JhUEdzQmtVZ3dybU5YKzhGZUJDb2g4ZWZabzM2SHg1VHlESUZx?=
 =?utf-8?B?YlE0TERvOEVHRGhpR3RHTGhuY3lvNE9vb0VaQklaSVFDcEZXQ1RCczdMbkIx?=
 =?utf-8?B?TlV4eWdwZHVza0MrVUxlb1pRNUVBNDY1c01WRHhwMytmbmlobzB0c2llNzFU?=
 =?utf-8?B?bmJ2dWdsUjVnU1hLT1hZd3pXM3pyblBxTE5OdEdSc2drb25JazRrajlxKzZj?=
 =?utf-8?B?cVpzRDNmbDB6aVY4WFNwRFhIUmRyTWJKS25PaU1ER214bmllNk9IZ1lWY1Q1?=
 =?utf-8?B?Mnk4S3dCWGRCTmRyY2RJazlodlZJNDF0RHZJT1QxOXp2TW9LWWYwRTNyQitq?=
 =?utf-8?B?NkFIZDgwOGppeDlnOWJBVlhDcjdhN3M5bVphMGNUbHIrbUhBTk1tNHhZQi9M?=
 =?utf-8?B?anQ3TTRyYllldittcWdFekZtY3ZPMVI5NGVrUkhUend3OFlBd2JaeXJXd3VF?=
 =?utf-8?B?NHVUQXVBL1hESFlsc3E0TDdHWm1mUEVHTXQ5NWFIMzVhTGZmdjJ1M3FFVkNX?=
 =?utf-8?B?blV3clZWOUlwcjhZNUlyUGNUVjZHSStZc21zWkMveloxVThGbjZYNTlwS0tr?=
 =?utf-8?B?L2c0NE9RNG1xNmE4Z1NNa0RyWEduMlRyN3dyUEVBbTM2bWdHaWFqUG5nM2dU?=
 =?utf-8?B?d2tYMHJWUGIrZ1BPbHB4a1BBVWpibXl4aWR1WFRnbUN4MGpGS2t4OGdzdHIx?=
 =?utf-8?B?T29DT3dhR3NFVXptTmdyeWFKVVFZUTQwcnp1TXh0TE5yd0ZFQk1zOWwwQjAr?=
 =?utf-8?B?M3ZsSzMwdHJCVkFxK0hLZHBmVVA1NUFlMmswNnRBVWhYc2x0MVM2OW5JNUlQ?=
 =?utf-8?B?LzdjWm90TmhRL2t0ZWFTTXFsQTBHMFE4UGJJSEJVQld5cmcwdm0ybGJvSWIv?=
 =?utf-8?B?VGFlQ0lsUktWWGozMTlmRWFUSytHRFFOMGNVRnBTcHNTOEhld0tDMlJ2T2Jm?=
 =?utf-8?B?bWdxdS9UNDN0MURTcm1pT25Hb1EzalNuMjh5anpNdXUzVEFLTWs2ZkVVWG9s?=
 =?utf-8?B?aWFGUFBWOWF2VlozcmlXcmpoaHExSlBGRUIzV1dmaEk5Z0hDWm8xaWx6VDVO?=
 =?utf-8?B?djlFSm52dDBLYUQvbmwxTDUwWmp2djg0Yk5LWkJVZk1YSVo1bW9JTlBqU1Zk?=
 =?utf-8?B?blU1ckRVTjR0SnhsVk5aSlhzUUYxWkNHU0xiSWkvWXJTYXIyeGhsZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb590873-5165-4749-8756-08df2eeca441
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:56:41.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2qjSPC7pRysqPDVTvJyUyh3aTmnQMU0l83haFQ2obC+tMD70w6u9sQpOjUjWysa0A67ScFoYOIKmmljAF69dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3279

On Tue, Oct 20, 2026 at 09:23:10AM -0600, Jens Axboe wrote:
> On 10/15/26 11:22 PM, Aaron Tomlin wrote:
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 025a799f35b9..1a113679f15b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2241,6 +2241,21 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
> >          return hctx->next_cpu >= nr_cpu_ids;
> >  }
> >  
> > +static inline int blk_mq_hctx_unbound_cpu(void)
> > +{
> > +	if (cpu_is_isolated(raw_smp_processor_id())) {
> > +		int cpu;
> > +
> > +		guard(rcu)();
> > +
> > +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> > +						 cpu_online_mask);
> > +		if (cpu < nr_cpu_ids)
> > +			return cpu;
> > +	}
> > +	return WORK_CPU_UNBOUND;
> > +}
> 
> Not opposed to this, but let's please think about making the
> common case the fast path. CPU isolation is not the common
> path. That might mean annotating the hctx itself.
> 

Hi Jens,

Agreed on keeping the fast path penalty-free.

For multi-queue devices, blk_mq_hctx_empty_cpumask(hctx) already serves as
that annotation (via hctx->next_cpu >= nr_cpu_ids) since isolated CPUs are
stripped during mapping, so normal multi-queue devices never hit that path.

The main concern is single-queue devices (nr_hw_queues == 1), where the
hctx is shared between housekeeping and isolated cores. To avoid calling
cpu_is_isolated() on every deferred dispatch in the common case, we can
split the check and gate it behind a static key:
static_branch_unlikely(&housekeeping_overridden)

I will prepare a v4.

Kind regards,
-- 
Aaron Tomlin
