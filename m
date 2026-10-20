Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792527891;
	b=QYJw9hBK2LJpCVZkNHAm/DsnO+J0vgUZzRczlq0bB25mjpsiG0Ks2sbkpHhZtJliNCKJ
	 BZqLNHcCdBbP2S90IH7XiT9SxMMIHgDCVnrMEkWW3k+d/GuTlMfxNZxDKpaxgsvMk9bYT
	 3LDAk2KAo0toZYy6R08DX62d9iNkcE8pB/oWyoy+81OaA/xIO83yfr4x5DgzDk1FrS5W4
	 xCGQX2wg0qznTGBcEfcDplAYiLel/PicjoFRPDyVLKVE9J91W8L6aqYo0lY9zFTyJK+oL
	 Sa5F1ciq2xcVLvhY0ZgKHIPzXYe0oBzxP1VCUOS2vUtS9/ghkLilkIyPexvg6fWmFrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527891;
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
	bh=i7vBvvBpv9B4s85z0F3FjJeAYHO+GGdRk7ovJyeBDvU=;
	b=V1wfaG73tjL98y6WCo9qFd/AngNP2tH/S99zrjX1wxfffGsR2rVm7RTwbZzgUMffC+Dv
	 mo/16QKuN7hDAUHfaki1ORKZW9FoP9q0fKEiOqlEGV765Eg85sOfrkjUOig/vA0obZddp
	 DsXrFpZuadqD6X3JzQtqCrNPqyg9zGD63bzGz01SVJYUW0PDP40Jph1KK71u1SNvrbfg4
	 vZe/Tg2BcAT1MlH3axgjqo7/2Ht2W49RDnFk71pckJ9sYygZPt28cPJ5kNxo2d2HgQ2fz
	 WiTnZc1ufVP0Xngzk3LzJuqD6kUulwCL7JCE2h/7vfMlA7F1Z963v3Wet9BOdSgZxKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.125
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021125.outbound.protection.outlook.com [52.101.95.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED3606A31C;
	Tue, 20 Oct 2026 20:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80ED3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osezBUMhI3CVQwa5WUYhVB+zolJ9OSQf3oLzhg3Uo0YQV3+cwF7udlweEaKzRLMrndWQcXjx50XaFyfPZR+tEzzGLRhNwjWKE2JPNhuKMG+JNTQTHfHt1fFrxDdQAQJpBhLJB+puAa99uSTdDX/emyCCr1eYLhYm5VH2zZXUlUnofBaznSeh/I4hx3QJ3v0UiZ+GVeH3oFpI6O73Yr5upZFKv4jb860HVWOd2pxCj5/Ll5WgdE4GPqI3j1Qo1tZEK2iTUroQjnT44W763+jibtMFTz3sO3/TTsuyqj9jsdOW0lf2f67EkKWUZ/+9BEVLiynSOkzQdjv4K+KqtS3WFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=i7vBvvBpv9B4s85z0F3FjJeAYHO+GGdRk7ovJyeBDvU=;
 b=yorVbLGNDS27NPIPsuz8QeHl4Y1sIu73WaKGNVknlQPGXl9xdBdXJ29XBTqbMLGA55pqoXmBgliN/IBvTYGHLd0tTGs4Xh923KV0FpniqBnHGluoUlLeukQUvOnSogWYMOOOswGwyI+d6XwzHXPXBuN6YGiF2k/Ruimh8AQ5XXN7dG8d70rNcrec3ype3awOnKOvGYYxmga3erhLGaaoym+afo6a7eysgvc9N2ysvCir1e2ewiqaM/LkdlKHJ5c6KNmvTYvle4a7j6vsuifNcvrd8UZVpI1+4fAe7lmAb193+Ge6QmgFhPz7C4msdxD1gFBB2WM9jn6r36RxAkKCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB4041.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 20:24:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 20:24:45 +0000
Date: Tue, 20 Oct 2026 16:24:40 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, 
	frederic@kernel.org, tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <zpheefzacmmkz362qm342gfxhluovh4d35numrweqn2ajnxhog@ucus4k2prn6o>
References: <20261016052203.489760-1-atomlin@atomlin.com>
 <a6b3d7c6-64fd-4b92-8428-964a863ea9e8@flourine.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6b3d7c6-64fd-4b92-8428-964a863ea9e8@flourine.local>
X-ClientProxiedBy: BN9PR03CA0856.namprd03.prod.outlook.com
 (2603:10b6:408:13d::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a2d480-75d5-4519-58b2-08df2ee82e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|56012099006|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Xi4ArUJp9a+qcA/34d3ZODIF0N9RpxhEkaS4MOYik7ecxZxs2yI81ZrIeXn1HJ3ixFBf8LlkMOtBaIs9Z2zPyb/6CzwCM5szoAIzcyIQ9yp2gabXt/JltExbD8tUVKIV1zmUGz/a62Gl5oZieCrBL8ThmjAv4xd6abb7FtaPyTkP9luvHvV6cL4+Nek8ieJFDKjr62De9BxLxO7rWYrnQE7lz7e6otLEtJKJlUo4x9HIwk5iT9HeaUXRLTh+p+bwZxsnu0ByVtr2j1euJqDhpIVLr3PYrHtobTvdY/A3HojPMxUIgBa53Wi4sPh8Pa1t3lNS6ZUcEvMvTigMaFoRTnzIVRcj2hv5YftxwVPOMgOjDlojaijGYV/uZbky0BkAUk0OvadG1+f1vZ9RtQbADbIBvFj6nq6C10rlBGgHlJmf4NS1msvKmO933wC4kTN6ztrO553tLaK7LZ2sLm1fRLJJAxs0RbyksdvS3ogY8K2me1vtwoA4QzGS1vfaKqMb0k6ZgbTyilIycII/ZI60ENBC3KgjGO+tfxqX0e+hoAhfXSsxQDei8bsYszoD0B0NC08uBhuvKra0iPsTFR9KWp07Ar3vSOzyjr0Y8VjTXQ3O39Xtijen5kv6X1djXo9N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5YeFRqdjZoRkw4b0tmMUxWWEFWRTgzVzZ4a3EzSm5LWGcyZERZZi9lbC9D?=
 =?utf-8?B?YVlvL0FjM1BxdlFUZGNuTnBCOGRYT2JEakJpank4K1o5ZGQ3RlVVWlpvLy9h?=
 =?utf-8?B?eFBWb1Bhcmc1SDdmWUxjczd4YmNuZzFQS2Y4UllyUkozWnpwM3BiaDBuTEJE?=
 =?utf-8?B?RVBjUTg0SnR1NXlEMnY4ZlBDaWNEOWxiL3Y3RVhiM00wdEtMV0MwMVJBeG5I?=
 =?utf-8?B?YUFUenVOT3g4bmh1cTJXSC9Wb2U0YTJvVXBRQ0l4bVJ3aFNpQmd5Z0d3dTlZ?=
 =?utf-8?B?RnRsWnVxdUdYSmV5NTIxTzZURW5jQ25YZm9DQWpHKzBEMlhNQ0N3enVFM2Y5?=
 =?utf-8?B?cjhLT1gvR2xzSnlhdFhYb052SXFSRTh3QUtYU1FhbkN1b0J6SnYzdEo0ZkNa?=
 =?utf-8?B?VDVTNVRXUTNTejJRY2RwLzdNVXlTT2ZoRXhSVVkrWWdVTHlDalRrWGhqMHhH?=
 =?utf-8?B?Q3dRSEo1bCsrMVNRbU1sMGJybldybDBiZ3hMVEpodzhUanlCWVpXdlJMMG9X?=
 =?utf-8?B?ZnFzbUdZcUJZWSt1VEpYM1loOXJLbHJyYTc5TFh0S3NudnNxMm1vbHdnZ2gw?=
 =?utf-8?B?VzFFdFNEa1d5d3NrYW4wVEJEUzlybUdVSzVzaFJmSkhYTlJpS1hlN1R3bkJi?=
 =?utf-8?B?MHpJQUpwdy9Jb29OWURKajJLVlBwK2pUYlplWEU2ZXdCa2NrajlLUXFaVG91?=
 =?utf-8?B?TDh5VmVRSWFxUmF4YWppUzU1OXRmZ0RnQ0N3UUk0Q05jeFc3dTdHWTZOaURN?=
 =?utf-8?B?STdoMWpIbDhqY1MzQTFLZDN1YlloSnV6QUZuZW5XTHY0cTRLVjBKSzNiVXQ5?=
 =?utf-8?B?SUtWVDBBNys4QWxCaWxSVit0aE5SSjBqMnRxaUZKVVJoWVdqRldBQXRWOFJw?=
 =?utf-8?B?RTJzYWFWMFQvYnFwODNJemNvVTlyczRpRjBMRGxLM0pHaWZUUlZyT0YrZTU1?=
 =?utf-8?B?VzFWblZOd1NhalhyUjRFWEQyMHU2aXVIaGVOdEpqNTcvY0ZCTFgzalIwekh6?=
 =?utf-8?B?VlVqejA4RWhhcVhjazkyck0vZmZkOTJBckZvSUtIK1hPdUpuYVdveVVGVmZi?=
 =?utf-8?B?TkNoeEM2bGZCQytxcWhYZ3AzMmsySU5JMjRsQVNBOHdFTkV5bnM3MDdpMkYw?=
 =?utf-8?B?bzlMR2lKQVlqOWNKQ0d0MVhlb2xkWkdtbmFJaEZKa2YrUnMxQk5LVXhnTzBK?=
 =?utf-8?B?OHk4T09lWDF5My9vSEpySTRyaVZQTkYvR3Rma1JRU2U3b2pBWjNxenlyZzE2?=
 =?utf-8?B?MmJad2NEMFdScmdGODdOM0w5bnptVWxnSEdxQS9tRGpqMkxjNFpxTElNcEU4?=
 =?utf-8?B?ejh2SVFub1NDeGlBcG5MOXVWRC9lb3ZqelVoTlhJajNtcnBMblA3WVh4SVd2?=
 =?utf-8?B?OU0reUZ0UCtkdTRYNDBxb0ZJOFRUM1ZkQk9DeVJiTG9zNk9Pa3hudlg0TXVY?=
 =?utf-8?B?cHJkQ2NNOFJTYVVmSEIybHl2bTExMktPWk95eDJkcEdnbEF1VmhPZ3I2SmtY?=
 =?utf-8?B?NnJwd0owSSt3eExuODNBaFMyZXlxRjRvRHR0SVFLeDNxWlkyS0lRVEJoenhp?=
 =?utf-8?B?ZytYbUozZks2U3VVdThUTFdHZnQwQkdFb1VoeDVPMTd6UlNkTnRHd0NjQ0Vz?=
 =?utf-8?B?MWpML202cWRxQXJEUjNyTmhZYUM3d01jOFhyMUFqdU1BWGxvdEJUSzdrWU5J?=
 =?utf-8?B?czVHTUhSY1BSUjZveXlWOFFoMVhLeVluaEphYkREa096T1VkSG9mTWp4dlp6?=
 =?utf-8?B?SHJ0QWZTWDR6K1RNbnBOd0RzN0luQmMzNU80OTArWGtYTmppSjFqaGVveGFE?=
 =?utf-8?B?UTBVQi8vUDYrbXRJS1FYOWgvU3JtTm5udWg0d3kwdks0Z2FHNitmRWZaenBh?=
 =?utf-8?B?bWpQYjlSOW9aNytkQjc5R3FnRU9RRzV0djNHajQ1dHBnclF3bzVvcUFtSExh?=
 =?utf-8?B?cE1iSXVvOHA1OFlaT2FQODdWN1Y0SUlmWkhZUFpxT2wyU0tqL2ptQnJoRXhF?=
 =?utf-8?B?WFhtSVdZb253emxmemZxTG1VMEVjRE9FRW5RM2E4SS96bmdRRWtsamRLVHRN?=
 =?utf-8?B?UEJnejlkMUJ1WmwrS0RzTmFrMnZqYWVrQ3NTMkhDK2xuZnFHTDRFdElDVW9U?=
 =?utf-8?B?aFJRK0NhYnZOYVpSaVM0d1J1SG1EN2h2M2FqRUdvS1g4SlpSUU5oNzZKNzcz?=
 =?utf-8?B?T01QbGMySHZXOG1vVUdWZVNVVWJnQityWVAxbTdodC92Rmk5YVQvcU5YTjBZ?=
 =?utf-8?B?R0NURUhHRmY0YXJwL3ovcXpmK0VUMUhJNHJ2WE8ydXE4SWQyckl0TjhNQXZr?=
 =?utf-8?B?OVpYVklQNFp3cHd0M3RrMXdscjJjV09oWUgyVjRXdERiSThYa3NwZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a2d480-75d5-4519-58b2-08df2ee82e55
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 20:24:45.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9qAFinwshUfHqilquAY3ISGnCS/jRgPRRAXHNlBZYPXAYsSgKpSQVz5BmEibHD+QGrwDtpIxrmfwZgj4f3UqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB4041

On Tue, Oct 20, 2026 at 05:09:25PM +0200, Daniel Wagner wrote:
> On Fri, Oct 16, 2026 at 01:22:03AM -0400, Aaron Tomlin wrote:
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
> > unbound fallback paths in blk_mq_hctx_next_cpu()
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
> >         bouncing.
> > 
> > Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
> > Cc: Ming Lei <ming.lei@redhat.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
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
> >  - Link to v2: https://lore.kernel.org/all/20261015020225.422107-1-atomlin@atomlin.com/
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
> 
> Looks reasonable and related to my patch as well
> 
>   https://lore.kernel.org/all/20261014-nvme-fabrics-isolcpu-v1-4-355156be27b2@kernel.org
> 
> and I was able to create a blktests for it:
> 
>   https://lore.kernel.org/all/20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org
> 
> Would it possible to extend those tests or add a new one so we get this
> also tested? And these two patches then should/could merge.

Hi Daniel,

Thank you for the feedback.

Having test coverage in blktests makes complete sense.
Between extending your NVMe test and adding a new one, I think creating a
new, generic test under tests/block/ is the cleaner path.

While your nvme/070 test targets NVMe fabrics connect and passthrough
request allocation, this fix is in core blk-mq (blk_mq_hctx_next_cpu) and
affects deferred workqueue execution across all block devices. Using a new
test based on null_blk would allow us to:

    1.  Target infrastructure for generic blk-mq workqueue placement testing

    2.  Easily configure a shallow queue depth or inject tag
        exhaustion/busy conditions to reliably trigger asynchronous queue
        dispatch (&hctx->run_work)

    3.  Trace workqueue:workqueue_execute_start to assert that no kblockd
        worker executes on the isolated core

I'll put together a test case for tests/block/.


Kind regards,
-- 
Aaron Tomlin
