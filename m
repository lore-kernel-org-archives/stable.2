Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792675268;
	b=fN+MSStX8q7gex3O6l0AHFpQMfFVtrsnZAxxb/ifpbPrMGWCunxZA2HQjghEfFOCE0L8
	 SVobmmt/7KgG8M+S1GJ9sGaqRpXRzOejvZIo9HN3UzfGfR6HCya4OyAA6XdvM75L2KSwS
	 UgeOIRy2tm+AZpkgGESXYuHishQmiUMajSbsVthRN1HkSEdmvP0qghZzzfC0fEDwRw77q
	 NZK3/GAc+1MHGIduWknZ+XQn+Gdu+9IeB2SMCk7EQagVbTl81WHaUpmtnCFLBP0W5lXhT
	 VlHCQfTQyKZ5KY9UeIHqrsWVTivDl3cYYSwsLU98fkZSwUC4GWL8nYpqbo3E0SnK3Ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792675268;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=rEz3KRw2GeeMjs5MI8rdriKl3hr4eyfxAkpQEKOpwBc=;
	b=x+xR1XxkUphctCudUrk0UdwHefcbL1x2FmbpwtBKc22MAXq8+A4kpJK+reWGtIMdOVql
	 n0qVqFBsc2GSCrspskYbgLvJnta+H7HTDaYrZy2tMNgJmex1iCmLnsSYuWLv36jfjv6IB
	 o4kWU3krW36Unj9OU+UmI2ZYBDbN2w4ixLlTagWr0dFI/mVKnN+kqWCBii6Zt/iDYe9Ug
	 IFJC9YqUGNT1+r1tSq04QQThS/7SHlB5k+GUXQ/Iob4jG4FjJqpeWUBoqL0zuSPapF17q
	 YBM0Fp9VuFCAv7fbRnWQ5Jq+W8Q7A68M9G3ALa4f+ZeQvKej+ltTqwOHatnhTCWu+Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.108
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022108.outbound.protection.outlook.com [52.101.101.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845D606A31A;
	Thu, 22 Oct 2026 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2845D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drWsPAiUmh2YPy5yQACKfuzoStb0jxdpppEjgDfdTmOosXJkl1nViiwq8kStiKktQ7AuHL2MsRkkUVppxSLVDwtSbrneYwYq1RaDRLDHfV6hYuDcgvNJQ/8VuaVN+YXrtdBFD4NRpMCcvGGQLab1HR6p8qTMRkBi63sczfjDhc6htrtaqbQntBBAKEZMnhOXbaEVz5+bs/6a4eMxsFmKgD5oqY/oigDzOttwGoTpG5ipU3Hr1s3+sWTjRqJ+QYQL53ORkTPyrH3hpRbUTl1L/eUch4isEeuMlWKIlff02x64y0yl5gYlJeXLixKwlQ7awqstjeqHa85EKeyas/J7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rEz3KRw2GeeMjs5MI8rdriKl3hr4eyfxAkpQEKOpwBc=;
 b=DMHgFzY5nOk6qdamDr7ddlcPPVritSWG+5us58oTRvDzym8YVWwrQTWM4gcF+D06SZ41iiWzt4XdGRppXQs1pZnnSQi26eQp0If0rdTTVR9vfsy2d7pWGBj9Vyoc68ae+48rXlfZev09KVhoVm4d7ENr98+jjmU+z5M5wJZivF72qQajCGKEXGJuTN97Oya+fpOE/XlxIYy23KCN7OfMizc2W7zatur9aNXoivNIeMqZluE9KKpSFgAtpmtoCNOnWR3h+ywpF4uPC5RjOxRVzBu4rIEw5rPbErfJcrSneuPoYFgPtXj5y3Hh3cjMJX6wfzc4hV4bPia2VGv6s5KwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LODP123MB161652.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 13:21:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 13:21:03 +0000
Date: Thu, 22 Oct 2026 09:20:59 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, marco.crivellari@suse.com
Subject: Re: [PATCH v4] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <w2wpzfonupkljzzcngpie7lkn23kjrr7om7okqtvyhrttxj7ra@dzvrunt3ovp4>
References: <20261022034737.47820-1-atomlin@atomlin.com>
 <atoDZ85GTNGyaNPL@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atoDZ85GTNGyaNPL@localhost.localdomain>
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LODP123MB161652:EE_
X-MS-Office365-Filtering-Correlation-Id: 725f0a43-d39b-4d25-4b76-08df303f521b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|261009223027099003|10067099003|56012099006|261021121427099003|3023799007|6133799003|18002099003|22082099003|261021123027099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	dNTFY36aGuMuWLI/B9G5Fwst4JPom1h30/ygobCjCUDD5adrvaBxkcPLOlmvYgyzRLnj1aX17b0KU4WgqWZ5gzpq+T9P9grQgf+eTrKBzyzorag1YoBZEGz4baPSJAaRZX71JHKrc/2TJhjQwjTuhEk3ItgbUL8+jnJmHtu1c4Z2ub6llleEOOhUq3TSr6PjI/m1jrlWSl2Ut7hbV0gVNYq0SWFbi9Ns0yWSW/1hI/oNlSEl3TiFtRSyMSo+jXDQNyPQaRnaX3WJnZLmXDyCThYyshUlDyrhb1DpygXTpkUhXoAmVu/Fdx8Ey4MfxHk3XZIoPGvX2rYFLR8LTPNB0EDUTwk+O3o146YuodjK+C58FqPt/ZomY2RXEhvEoTzHW0WYOiFrF3oHVYSvzZ/TGNr4nuI8igSG7YbqXmEigewX8lUzJXQwhvcQ46r/8TzL6J2x92virsA7ago6KCdxv8VKXimHnuWaon7RjUTT8QWOqNCfEnhHDyryMU8n4p/cG5YZWUyLtLzjj9m9Nxm8tTRsDDeXZPBJE40RF7h0gY2yxzezC2gwGLV3WDUq2WDsX1mtenRxfBq4Hi6M6oSGb6tUlUcjGLNEJikL1JP4G514E7mu+8Ob+gmAV8jCZw35
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(261009223027099003)(10067099003)(56012099006)(261021121427099003)(3023799007)(6133799003)(18002099003)(22082099003)(261021123027099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkI1T2IvZ2JpTnN1OGFwRU42SGRTaHBrQTNRSW82VldwVVF6ZjN4TjRqS2RH?=
 =?utf-8?B?cVQwblhKck83eEZmalJkT29iZlNSTHJ5ZGYwY3FaMHQzemYwZGl4SXRWRU9z?=
 =?utf-8?B?d1BSaUN5S1U1VVBFcEM4bWV0TVNvSUh3a0dwOFNybFQyODNwTVhEcHpTNk43?=
 =?utf-8?B?SEpVSDVOR0ttU0tCYmxQblljTm94MFR2bjc4VlFtNFZOQUkyYTF4Rm9XZ1VO?=
 =?utf-8?B?Q0lpSjBnd1B1YTVqbkplTmlZdjVqV0d4Uk1KSk1jSXNxc2YzMW11ZURUM1FV?=
 =?utf-8?B?Mjl4T0JXa3pNcHhJUW8vZHJLVEFZVjNLRE5ja1Y1YXViVDdrOStCbHgzVWUw?=
 =?utf-8?B?R3lpcWovanR5YnhUSHgyOGE3Y05sREM1QW1ERjRGY2R4RmxVNWxOdWNCZTNQ?=
 =?utf-8?B?OVFRbVY0NlZUVDBpVWYxZ25ERkprNENpSktmZzh5K2NMMTkvQ3VZWWV0c0h2?=
 =?utf-8?B?K0UvbXZ0VU5KdXpqSlpPRzVXTVg3WUM3NUZaN05Bc09vOGRhNXBTdnczeC80?=
 =?utf-8?B?dUVXZUhCVUJrN1FoVTBETElhZ0RnUXVHaDJ0ZnJiY3lsNEd5V0tjcVVjU1dX?=
 =?utf-8?B?ZHVULzVqUkZTaDZkaUhRTTlzUWdZYTFpcDZSNEUzVnZNV1dqRTBKdFB3c091?=
 =?utf-8?B?ckVjQ3dRc1pJVGVtYTJQN1RsVE45QXY4UUtySklzUFp3MUpZOUxuRE8xS1hp?=
 =?utf-8?B?QWhwdWlaUS9SeEJzbXlFSkx2SDhJeDhReGNCc203dFN6ZVl4RHRRZTcxdDNH?=
 =?utf-8?B?UCs2NjdSNXlwUlFMWVE5aEtuVHFEZ3ZoOXJscjZkUS9XVVpPRVc2Wk13WHJN?=
 =?utf-8?B?ZEZ4OFhYTnVNMUxBOE9jMHU4cXYyWUtqbzMzVVRjOXZiMWhnck9DUU9QWnNt?=
 =?utf-8?B?a1dTZmk5aUtrbEN2emtjbzZKM0VGWEZtcjNHYjVpYkxDcFhlbllEQUViSXgw?=
 =?utf-8?B?dVExRWEyd1NUbzhQMHpXaHFHTGNwQnh5SGpnRHd4OStGSkJxamwyVm00WXp1?=
 =?utf-8?B?UmYzZFFyK2tmSTEzd0VhaHNJWUh5andXVVZUUTBBRVo1VGFUdlpZNjVIc3N1?=
 =?utf-8?B?V1FaVVpMdzlneldRWUxNN3BrS1BkWms0WVNyWlB2UldyclRaWjUxdEpxblov?=
 =?utf-8?B?eUkzQnNQYTBnQzc4SnFyUy9nbGE5RlkxM0h4UGxnYTFFVHNTMnp1QjBCRWxX?=
 =?utf-8?B?VzdlRmZ6a0orRjZzcGE3M1kycE50RnBINXMyY2kyYlh5dGpTdnZldGFoYTB1?=
 =?utf-8?B?Zm5kbFNJb3dhaGdKRFZ3L1czWHN2ODRodjlwNUhTY1huemk2SzRIbThsMHBi?=
 =?utf-8?B?Mkk2Z1JNTzJETlh4ZmZIT3NYREJNS0NPalB1dXRhMEdzdzM3NlFwQ29vZW1S?=
 =?utf-8?B?VzB6SWg0bmVtRTlQblF0dkxlVVNjK2JMWlZ4d0tWV25adjZEbWlpdmg2dUVP?=
 =?utf-8?B?MWRKMlFrYVFJL1A1dzVNaUhKNTVlTzVxNkkwWHdzQjhtb2psdkVDU2RvcDl2?=
 =?utf-8?B?c2JuV0VycTNpYmNwQmpoRlNWZ3lDT0h1OFVXSjVyWUZKNU9JdHVRTmg4NDQy?=
 =?utf-8?B?RVRQbG4vcHFONVJCcVdVN2N5Qy9FeFB4bWtxdVFvMlhielZ1Sk5CbjlwcUNO?=
 =?utf-8?B?MHVxREVNYm9BUHo2REJDQjBWaFIreG54UE9LYlRVdFJoSVM0d2xZVnNSajRw?=
 =?utf-8?B?TXpRK0hmM2tRTVVMa3g1VVhwNkp6ZkdJMTl6K1ZqTmxBd0l4NDdkTzZLS3p2?=
 =?utf-8?B?cHMwaEU5cjliRnYxQmIrS0JLTjRMOUZhRHhpbitRM0pCM09nNDFhUXJOa3Bx?=
 =?utf-8?B?MDR3REJOTlNrN001cDcvZ3o5Y21CcFlnc2dQd2luRWdZU3o5MnpJYi9RWHVE?=
 =?utf-8?B?UFY2ZVVHL3pBdkFnZkpjTW9VTGxEc21yNGpnZXQvbjlIU0VHZFZIM0k2QU8y?=
 =?utf-8?B?NkpQTnBvZFRTVE9JTkN0NExQRzdHY2p0bWl4bXdlMTcwTmovMm1BNXlUT0dj?=
 =?utf-8?B?cUZoRDhRR3JGcS93ZVJGK3hUSjNnMkhOUVA0akc5SzR6V045dXd5WkptbUVj?=
 =?utf-8?B?aUszenN6anR6ZXMvdmV0WlA1V2hSdXlVejYyNDFBOE8xRXVkSEF5RGpxRXdO?=
 =?utf-8?B?WkVQa2tMdEk0NjVSa3licVJqdTk3ZmxMV3ZBMElUU0ZzYWxHNGMyMWdSUVE2?=
 =?utf-8?B?YnZQKzI2SkxDbFZ3TjdhcWRJZlNHUCtvZWlYWDN5WEVzVmQ4M1VDVUM5NmxC?=
 =?utf-8?B?RWpZVUJOVWFJRjZFbFBvd1g1cVUvMlViQzJob0hMV3I0d3prc2U0TklVK0hN?=
 =?utf-8?B?MEFPVTI1U2M5Z0pUWFJHYlBxd2pWVjM4ZDh1RFZPbEF3T3lsVmE4Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725f0a43-d39b-4d25-4b76-08df303f521b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:21:03.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEN7dIolYfGIcVKsvZ+kbrewpP5hxZi8kmgIK95srtWxqCf/E0gG/bkJDmo3Ll/9RzLfD9+IRUNTY5KPe+FJEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP123MB161652

On Thu, Oct 22, 2026 at 02:36:55PM +0200, Frederic Weisbecker wrote:
> (Adding Marco)
> 
> Le Wed, Oct 21, 2026 at 11:47:37PM -0400, Aaron Tomlin a écrit :
> > Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated
> > CPUs") excluded isolated CPUs from hctx->cpumask to prevent worker
> > threads from executing block work on isolated CPUs. When all CPUs mapped
> > to a hardware queue are isolated (i.e. blk_mq_hctx_empty_cpumask(hctx)
> > evaluates to true), blk_mq_hctx_next_cpu() returns WORK_CPU_UNBOUND with
> > the intention of offloading execution.
> > 
> > However, kblockd_workqueue is allocated as a per-CPU workqueue
> > (WQ_PERCPU). When WORK_CPU_UNBOUND is queued on a per-CPU workqueue, the
> > workqueue core resolves the target CPU via raw_smp_processor_id().
> > Consequently, if a task executing on an isolated CPU submits I/O and
> > triggers an asynchronous queue dispatch with zero delay (e.g. upon
> > hardware queue congestion, tag/resource exhaustion returning
> > BLK_STS_RESOURCE, or plugging), &hctx->run_work is queued directly onto
> > the local isolated CPU's worker pool. This causes the local per-CPU
> > high-priority kworker (e.g. "kworker/6:1H-kblockd") to be scheduled on
> > the isolated CPU. In real-time environments, an active SCHED_FIFO workload
> > will starve this SCHED_NORMAL worker, causing hardware dispatch to stall,
> > in addition to introducing unwanted latency jitter on nohz_full cores,
> > thereby defeating the original objective of commit a46c27026da1.
> > 
> > Introduce blk_mq_hctx_unbound_cpu() to select an online housekeeping CPU
> > from housekeeping_cpumask(HK_TYPE_DOMAIN) via
> > cpumask_any_and_distribute() when executing on an isolated CPU, and
> > otherwise fall back to WORK_CPU_UNBOUND. Use this helper across the
> > unbound fallback paths in blk_mq_hctx_next_cpu().
> > 
> > Additionally, for single-queue devices, gate the check behind the static
> > key housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure that
> > common configurations without CPU isolation incur zero overhead on the
> > fast path.
> > 
> > This ensures that:
> >     1.  When executing on an isolated CPU, deferred queue work is
> >         cleanly offloaded to an online housekeeping CPU across single-queue
> >         devices, hardware queues with empty cpumasks, and offline CPU
> >         fallback paths.
> > 
> >     2.  The per-CPU high-priority kworker on the isolated CPU is not
> >         scheduled, avoiding priority inversion and latency jitter.
> > 
> >     3.  When executing on a non-isolated CPU, WORK_CPU_UNBOUND is
> >         preserved, maintaining optimal local execution with zero CPU
> >         bouncing while avoiding timer pinning hazards.
> > 
> >     4.  On systems without CPU isolation, single-queue devices maintain
> >         the zero-overhead fast path via a static key.
> > 
> > Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> > Changes since v3:
> > 
> >  - Create companion blktests test case (block/050) to reproduce this issue
> >    and verify the fix (Daniel Wagner)
> > 
> >  - Gate the single-queue (nr_hw_queues == 1) check behind the static key
> >    housekeeping_overridden under CONFIG_CPU_ISOLATION to ensure the
> >    common case without CPU isolation incurs zero overhead on the fast
> >    path (Jens Axboe)
> > 
> >  - Wrap the evaluation of cpu_is_isolated() inside guard(rcu)() in
> >    blk_mq_hctx_unbound_cpu() to prevent an RCU lockdep warning and ensure
> >    safe dereferencing of the housekeeping cpumask while concurrent cpuset
> >    updates occur
> > 
> >  - Disable preemption via guard(preempt)() around cpumask_any_and_distribute()
> >    to prevent a preemption warning under CONFIG_PREEMPT_RCU and avoid
> >    data races when accessing per-CPU distribution state
> > 
> >  - Link to v3: https://lore.kernel.org/all/20261016052203.489760-1-atomlin@atomlin.com/
> > 
> > Changes since v2:
> > 
> >  - Query housekeeping_cpumask(HK_TYPE_DOMAIN) instead of HK_TYPE_TIMER
> >    to align with cpu_is_isolated(), workqueue affinity rules, and cpuset
> >    isolated partitions
> > 
> >  - Query the housekeeping cpumask under guard(rcu)() to safely handle
> >    dynamic cpuset updates without lockdep warnings
> > 
> >  - Validate that cpumask_any_and_distribute() returns a valid cpu ID
> >    before returning, falling back cleanly to WORK_CPU_UNBOUND
> > 
> >  - Link to v2: https://lore.kernel.org/lkml/20261015020225.422107-1-atomlin@atomlin.com/
> > 
> > Changes since v1:
> > 
> >  - Introduce the blk_mq_hctx_unbound_cpu() helper to steer deferred work
> >    to an online housekeeping CPU only when executing on an isolated
> >    core, preserving WORK_CPU_UNBOUND and local cache locality for
> >    housekeeping cores
> > 
> >  - Apply blk_mq_hctx_unbound_cpu() across all unbound fallback paths in
> >    blk_mq_hctx_next_cpu(), comprehensively covering single-queue devices
> >    (nr_hw_queues == 1), empty hardware queue cpumasks, and the offline
> >    CPU fallback path.
> > 
> >  - Elaborate in the commit log on the triggers for asynchronous queue
> >    dispatch (e.g. tag exhaustion, BLK_STS_RESOURCE backpressure, and
> >    plugging) and the SCHED_FIFO worker starvation hazard on isolated
> >    cores
> > 
> >  - Link to v1: https://lore.kernel.org/lkml/20261012012905.267920-1-atomlin@atomlin.com/
> > ---
> >  block/blk-mq.c | 31 ++++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 025a799f35b9..f8f862a0e525 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2241,6 +2241,23 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
> >          return hctx->next_cpu >= nr_cpu_ids;
> >  }
> >  
> > +static inline int blk_mq_hctx_unbound_cpu(void)
> > +{
> > +	guard(rcu)();
> > +
> > +	if (cpu_is_isolated(raw_smp_processor_id())) {
> > +		int cpu;
> > +
> > +		guard(preempt)();
> > +		cpu = cpumask_any_and_distribute(housekeeping_cpumask(HK_TYPE_DOMAIN),
> > +						 cpu_online_mask);
> > +		if (cpu < nr_cpu_ids)
> > +			return cpu;
> > +	}
> > +
> > +	return WORK_CPU_UNBOUND;
> > +}
> 
> Just for future record, we are working on a WQ_PREFER_PERCPU workqueue flag that
> should automatically handle this sort of things. It's not ready for now so these
> hacks are still necessary but keep in mind this is a good candidare for future
> simplication.
> 
> Thanks.
> 
> -- 
> Frederic Weisbecker
> SUSE Labs

Hi Frederic,

Noted and thank you for sharing.

Sean and I observed this behaviour on a kernel with commit a46c27026da1
("blk-mq: don't schedule block kworker on isolated CPUs") applied.

We will certainly keep WQ_PREFER_PERCPU in mind as a cleaner long-term
path.

Kind regards,
-- 
Aaron Tomlin
