Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022095.outbound.protection.outlook.com [52.101.101.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3245038F3;
	Tue, 13 Oct 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898433; cv=fail; b=YuutOJdsmcm2fVdjM/rhecNgC3MXrzz+D4zHCRJ5NhWCQjcFc7rJNlKJsawT0HdapS9/PVGvV07/chBPuXi8huSfRAhE0gj+xHqzChOEWfRWpu1z7Fus5AY5V0ZLzLt6TdBjlIjriM35uMJ2JpP8+gP0tELepodZ/Z7IQ2EzlxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898433; c=relaxed/simple;
	bh=1zUB1hvE7CjvDA9o5+cDOG2QiMkBnTqKyy7/cTJNi4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TlbSUezwJQhWySgO/LJHT3uKmxJWrSHI9rmEAJt6m0fbPsu2GuyDk8MBg+kYYC4AGf/YGpAJhowyH2e1RmwoURW9ecQgAlcT1cWGpqrlsdUN08DzRz6zGS0GPtXxAohQAyoW+/uV19ha9E+A02o0dH1w/i3+32QYXmoL6GARPT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x43zUszwlroCMzHpFFsvTXa6OtP0HnJl9YWGbS1ohyXJv0MVex/yKoedfj8mkwcPPJayWnoxn2T8HUrHdoFfO+TrZ8v8pHoyR+kQv2pWTkqVpFCZVmZgz2oladDXeswdkzztLmMwg7ys6YbwaxiqydRnboZUdQKf/zjYvI21KBc+84to7ojy0P/jGTQ4qNiEOGUIiN9AzcN5HQvSREYMgDLdp3ptcVJWr0qGLFt19jczkqk6yl8knFd8ef7/XGUcEqZQN3q6EjUHeiB5xPKvD2kog7MF7HFWZQ5NZy1TQHLqeaQBtrCboyw0o63C3MB23j70Ifsf+3bGeoptwub+rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=DYBxRudDdOvxcPmQXQTxLVffxf4Wc+BkoSM5uvUm544=;
 b=Tx354RzlA6xUclxmLZ3Md1rvqyLHumCL/WaWKX1WC/0bYP5VZSxsWQa1vx3Q4OUytotSwS6tdQ9FbduD/4ciyph9CKGdgM5teKM2V3D5EdNi0f2PiC+5S4A6SaQfj5fTV8xpzjICV6m3/tMV1Bg7RhH1mYwvnn976c/QsHgg22Z4kIUJcdUeaXOHESeqOmfiyBUioe/5gUkJQb+SzszX0GlDZQWIH5Om4M5hyIbamaIZtQVdTmcsFZR8QFgJ19I9+tN5pVjTm5O+V8OjVJwEzdFguz5J713FVmS6wuswjch6l6gE3e9ycyxrr0xfPIXiOcHQ0WLszmHVSDdwFhbjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB7344.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:33:47 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 13:33:46 +0000
Date: Tue, 13 Oct 2026 09:33:42 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org, 
	neelx@suse.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <i4xh6jsm222rtn7pka57fuo3scelrlzywrvq5kor5sy2jjlrmq@tkqbbrzimfrd>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
 <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
 <as4j_Zk7zcNsBuo1@fedora-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as4j_Zk7zcNsBuo1@fedora-laptop>
X-ClientProxiedBy: MN0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f220956-61d5-4d7a-312d-08df292e9b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|10067099003|22082099003|18002099003|4143699003|261009223027099003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info:
	25PnpOwGFTIPwU9P43I261tVDZKjyySqlnEfySoNqmKQwNQqGtOimvZtc9EYI6TehnBzcdAN/VVDbB84ldeM+Yql0d9P84dlsGk3+qSn3Nd/JQkFMvVmb1K7LHeplFA1/eTDx/NvD4QefB2lnpSEpJVSDp7ZTOw9Gsiqsbm9ZGfO7W8dnlmmPDxhW3HK5VhyAAC89COFv255GplHGAtv9JAOcypCnyKO8tupvWpRwy/5XBWar9UlhRlU7e8n5FivEdyTxJbSJ+Toz3RHbGO8ZftkSHgdrevUD1N0M2tA8iByqE3ac5DCdqZq42iPwhNJylKA9/Ttq5WUZdFvYElOuOJ8/ZsECmDvXZ2cF3o6g26Az5NeOH1SmR5cFXrQVQls8jeuTsaeBtIfYtvMi5Mao1ALzPOIwvWr9kzAUeDQtshbj2Zgu/qzGvnpsw9FLcUG7xmwLWAo0wzjv7BRrQD1peCEo/VWaFMjyJR6hROhULzqK3OemYUNfAZ7dWQrdkC79vjiKzKELLxJZ4jGqn7G9+2El2ZVF46zySItHJ23jB8TeXIn36knQn536ScgtPpX8EmjBbz8S96XZxxMp0fLfgK4Z/NTSwE5g3PdBfg84/h6mX/yTOEDXYLF64JsBwWQ90yeiZIypaDl5NpHjnoeTYB+5q1uNYGOpWlDDLlHFBxRQKGJrzFpHyuQAB44G3uMq7ZO+/ibbCQSwLsLM3WWPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(56012099006)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFBjUmdkL0g0Nnh4WDRpanFPZG16N3BZZHZMekVLTFZLU3VwcEk4OEIxU1Rx?=
 =?utf-8?B?Q2NTMTU2KzYxWHhpdTNaOElrRFhWVW54a1NpU1p4WmtMaC9pdEZmaGw0SUJK?=
 =?utf-8?B?ZDNYUDh0bWRmS0VXd3VjRy9jRmdPallWNXBLK2M0dzZUaXFEc1pBbWRYRHVX?=
 =?utf-8?B?TTkrbUQzYmtYRGZ5eWxmV25Kck93T3dFTE54a1N2SHhvQks4eDZhVzlhQVpr?=
 =?utf-8?B?c0x1UjNrUWU4Zm1sS2N1dEcxS2J1cGFjNE04UlRJdUQ4YnhIWEJsWTIyOHY3?=
 =?utf-8?B?ek83NUhXRW10SU1pTTFNdlZhRTdDM2JRUjdybTc0WUtQMVFYTnJPWnZIbndN?=
 =?utf-8?B?RzVTbmFHQkhRWWZhSFl0SzcwbGhpU0dnRnpSR0hlRFEyV0xWUWx0ZDUrQUcv?=
 =?utf-8?B?RFBEanRJMmxFeTV2dTF4d2U3c3llM215SWdJVVRjdWlJbmFyZkY2bkpDaTFq?=
 =?utf-8?B?OE45d1QxcXY1a1BBS1ljR0dYbVc4LzJZSUFUUFI4WjdkMnFlbVFFcDRZc0Yy?=
 =?utf-8?B?cHhtTXZqVDVyZmFRdE5KY3Z6Z3d6MnlKbWFzREpXTDZtTTdEMEMxL2lGdkVS?=
 =?utf-8?B?SWpCcnVIS3l5a0ZBbjRqWm9XV1V1d1FFMXBVR2RqVFd5T3dBN0JET3Y1Mkx0?=
 =?utf-8?B?bGJ5QUVOU3NHaW5QYVpIMHc1aUVqMnBtczhqUXJFQkFnMlZtOXNtWkw4RWNh?=
 =?utf-8?B?Q1VIN2FVUy9NNVRKUzg3UXY5UnlWcTNwZjRDMm5IMG9QUE16Z0w1STlReTI1?=
 =?utf-8?B?QWwxYmp3bE1reUVEc1RJL1M5SlQvbnlJRmd6dFoyVCtNRSs5L3V5ZUNtV0Z0?=
 =?utf-8?B?N1ZkOHRzWnhlMHpyWEs1YWFRT2FtYUJsZ3Q2TGVVRzB6OXZJcU16Y2pYZCtX?=
 =?utf-8?B?RXlUZHBySk5YY3pZM0hRbG5VaGdWdnNlcldQZzN1Z3oxMW81RDRGajFIRGNK?=
 =?utf-8?B?R3dsU0k0bW1CY3Zvb1F0SmlvcUI4aWwrQlFGc2Z3eTVPSFJsU1lLQjhLb1FP?=
 =?utf-8?B?aEs1THM2VHpmYVVOaXk5dUI1TkROaHh1NWhERmZLcml1ckNyVGJKRHVMdVNz?=
 =?utf-8?B?bHVta2ptTFluRTc1S3NKa2lXWTBIWWdSeGFldXpwUG9nZ05QMTRjWHZTQm54?=
 =?utf-8?B?Y0x1Q3A5L1hVYVIyajR5Uk11TDF0TDJtWFhKemkrQ2JVdmg1T1EzUVFjdUUy?=
 =?utf-8?B?S3ZpM3QrWXZhSzVRSTNWNWhEaGhFUjRFdHhLcyt4VG1DeEVSOU9sS1QzVGVj?=
 =?utf-8?B?dEE5WVBWcENHWUxxM215NmptaEhYdjZNcU8wU0FKU1RFTjdRWEMxd0VpalFH?=
 =?utf-8?B?b1N0T3JSa1AyVFU5ZTZqa05OdUtWb0JPTkxES3lNMWs1ekpSMUJndlJ6SjA2?=
 =?utf-8?B?WHFZcTVyWjJkeHFuaXNpMHN5M0pkelNJb2R0U1RmNkxJMldmQ2JUYUh6Ykkv?=
 =?utf-8?B?Q3lxSVkyWDJIL3RRK0hidHdWMElRanY4Tm5IVUtlS0dnTlNGK3VENHdBemg5?=
 =?utf-8?B?UXM3YlU4VE1Ba2RYWWRNMy9Rb0JNamxnSmo4cGVwMmh0RjFaVERtWWUyYTY1?=
 =?utf-8?B?MW4wMWtjQnlNTjRSSFZzUU02QXNZdFpOZVZmT1diME9MbTBFOEhrWThNc3k4?=
 =?utf-8?B?aFFVNGVVbmNUY21OMENmRy8yanNOaWd6QzU0dGpTOWo0V2drQ1p5V3FuL0R0?=
 =?utf-8?B?ZnZMY0d2dXg2eHZ1dWUvbUd3a2duK0lUYVFuQXFIU2t3Y2YzbUh3L3lOZTJp?=
 =?utf-8?B?em5uYnk2Z2JmaUIwRlBnMGdsY05jQWNPU3RlZXNkQmhtc3BzbUp0Y1NWK0R1?=
 =?utf-8?B?M2ZrcWJjRUJGRDhjdktKRUFoSDdQditUZExVbTZqTUxFWjFsZkFIeUw4UHRI?=
 =?utf-8?B?SHo3azVWTDZHSWlqWFU4Nzd6Mm9lNHhkbGVGV3huQlFZRUYxZms0NW9aNHJO?=
 =?utf-8?B?QmtpSE04UUVIclkzK21yUHRyN2RRNWRReWY3Z2RZRlF1ZGNXZzVYVDFFYS9I?=
 =?utf-8?B?d25qTktUWnlYSDIxTm9taDNrRzhBOG1yK3lSM2h4VTlVUXN3cHdOV3ZwS2dE?=
 =?utf-8?B?emdxc1ZnbXB4N1lxZ0hxQ2FEZGFxYlNJRDdFZ1Y2WS9SamZRYjJLRjhVandu?=
 =?utf-8?B?REd5WENaVkVVSjhDWVRhcDBJMUpISWVmbEpsejNSbHF2Y3FIVEhqbDRCNXFG?=
 =?utf-8?B?NXl6bk5RRnp3U1h2NWNqR2E5c0lzUkFlRms3dU04bGJkSjd0KzdwTXZyc1F6?=
 =?utf-8?B?ekU2VzVrWUNvYzRZQlM2dE5XZWozajVyUjRydk5oMmo3S0oyVFNZOTJzVnY5?=
 =?utf-8?B?K1pSQ2EvS2tDRWdMOEFmQXUzYXdhcHJuWFpqak9HWlovQlhOeVdmUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f220956-61d5-4d7a-312d-08df292e9b97
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:33:46.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yj8hXHsHWZfnQW0LNsSZ59lG3SUauWieXB+g7c2xgus7lTGD7iVnIBicOyQF6TvoVr9Ju0PSjFrNXnDM9rInUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7344

On Tue, Oct 13, 2026 at 07:28:45AM -0500, Ming Lei wrote:
> No.
> 
> For example, schedule_work() is queue_work_on(WORK_CPU_UNBOUND, system_percpu_wq),
> a WQ_PERCPU workqueue, so every schedule_work() from an isolated CPU runs
> on that CPU. blk-mq isn't special here; this is the general tradeoff of
> submitting IO from an isolated CPU.

Fair point regarding schedule_work(). I concede that mechanically,
kblockd_workqueue is not unique in accepting WORK_CPU_UNBOUND on a per-CPU
workqueue. schedule_work() indeed directs WORK_CPU_UNBOUND to
system_percpu_wq, which resolves to raw_smp_processor_id() within
__queue_work().

However, the crucial distinction lies in the semantic contract and intent.
Callers of schedule_work() seek local (or best-effort local) execution;
there is neither an assumption nor a guarantee that schedule_work() avoids
isolated CPUs.

By contrast, blk-mq has an explicit architectural contract to avoid running
block kworkers on isolated CPUs. In commit a46c27026da1 ("blk-mq: don't
schedule block kworker on isolated CPUs"), the intent was to deliberately
excluded isolated CPUs from hctx->cpumask precisely because:

    "blk-mq kworker shouldn't be scheduled on isolated CPUs."

Furthermore, blk_mq_run_hw_queue() explicitly honours this policy:

    if (async || !cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask)) {
        blk_mq_delay_run_hw_queue(hctx, 0);
        return;
    }

When executing on an isolated core (!cpumask_test_cpu(...)), blk-mq
deliberately refrains from inline dispatch specifically to offload the work
asynchronously via blk_mq_delay_run_hw_queue().

When all CPUs mapped to that hardware queue are isolated
(blk_mq_hctx_empty_cpumask(hctx)), commit a46c27026da1 added:

    /* Switch to unbound if no allowable CPUs in this hctx */
    if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
        return WORK_CPU_UNBOUND;

The express intention of that change was to switch away from the isolated
CPUs. However, because kblockd_workqueue is WQ_PERCPU, returning
WORK_CPU_UNBOUND inadvertently resolves to raw_smp_processor_id(), queuing
the work right back onto the isolated CPU that blk-mq just went out of its
way to avoid.

That is why blk-mq is in an unusual position; it intended to avoid isolated
cores, but relied on WORK_CPU_UNBOUND to achieve that on a bound per-CPU
workqueue where that mechanism cannot take effect.

> You already disturb isolated CPUs by submitting IO via syscall in this
> case, so why does it matter here to dispatch on same isolated CPU one more
> time?

There is a fundamental difference between synchronous syscall execution and
asynchronous background kworker execution:

    1.  When an isolated user task issues a synchronous I/O request (e.g.
        via write(2)), execution occurs synchronously within the task's own
        context and CPU accounting. The application remains in control of
        when this overhead is incurred.

    2.  When dispatch must be deferred (e.g. BLK_STS_RESOURCE), blk-mq
        queues &hctx->run_work. A background kworker runs under
        SCHED_NORMAL. On isolated cores, workloads typically execute under
        real-time scheduling classes (SCHED_FIFO, SCHED_RR, SCHED_DEADLINE)
        or tight polling loops. A SCHED_FIFO task executing on that core
        will completely starve the local kworker. Consequently,
        blk_mq_run_work_fn() never runs, hardware dispatch stalls, pending
        completions cannot occur, and the I/O pipeline hangs indefinitely.

    3.  Even where starvation is avoided (e.g. via the EEVDF scheduler's
        Fair server or cooperative yielding), queuing bound work on a
        nohz_full isolated core forces the scheduler tick to re-activate,
        injecting unwanted jitter and defeating deterministic isolation
        guarantees.

Steering deferred queue dispatch to an online housekeeping CPU via
housekeeping_any_cpu(HK_TYPE_TIMER) sidesteps these pitfalls entirely.
The kworker executes promptly on a housekeeping core without priority
inversion, hardware dispatch proceeds unhindered, and the isolated CPU's
low-latency domain is preserved.


Kind regards,
-- 
Aaron Tomlin
