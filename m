Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022077.outbound.protection.outlook.com [52.101.101.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672E4A499F;
	Mon, 12 Oct 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821196; cv=fail; b=jSVRWDn/6ZNTCsEGdmpaQNehpkC42nsC6rGV6YhYiuUYriIqXeWTUHMdJEr8V30fvo+/iFB3qPi/VDZo/xf4+zArxlBFkU5/xRtmAw7tSOqjLYUbp8IUI7G9e7Qnnf6JNQY8OIRy+5bWxdmA65RIuDaKKIFdsyUCEF36jDyt2vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821196; c=relaxed/simple;
	bh=XkgEY4BJh1GMthR1Pm0aJw9KLOpcpcvWjtgUwpRkNVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JZJjKSW7Pphdk5GeIZ7ZsxXTzbOcl3GwlIZWaWfCAf7WJlXjBYMHAMW6VywfBUGENG+ZbXzjJBafyLgyTrBxhQL6uM67H/kQeurRLQ24iZN5VYxRDfzqJwumUHgMW+pUoZ9fHLyuvOb5veep78ia7+sL2Vqditztk1DxPasynmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwZkCCz/IqZRlV7LIQ5UIeTqhjxrjnKP52+El3N7pMbyRgh1Cx7jfnK3Q8dPKDmV0W38L73pgP8EK6OraUEPTqKReFN4GZZnPmJADWZX7XJclSPR0YQioqrp305JyQOdEcHBH1pt3l2lvlyMXie6vZFEgZzemD6Wa0i2f72DdJ9HtDbjFgE1UehlQKZzfuxwnWIlUtccCzCsyNSuxqXYW+yHXYJPVf4c0TABOGVhRj5xT9pcCVz7g/VEA36/qNuoqRZiubOI57thTIxpdPMhzBC7x7268fW/JQi1L5t4mbAstgZTdRh4mYEABDs0M4ygf84mypJkrdhxfT4JYydlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6UlGVb8yqOyKxBL28u3gWHa732jfYEvAfw3EiaQSFOY=;
 b=fO/OwB1zqb+BxQdI91M1I6vwLkw8uWHSbw0Oi1Ml7l0ac9qH3UGhjyf793jzHt0zKNHZh7Nknrdqd0UaemxVDdGoHJ4bP+TPfQDtZnDDYj4yvbtx+UXkhwIbi6fIRiBen2tzmqirV9jY3FY/W5bIR2ZdKeDej/wpEyMbGUD02Y3DX5JRO3Sl5F+heDbPQZwIlej1hLvzKdsLm0uQisEPzNH4AbFxz7q9k2MNPDn9P0OtDJ/H5skm8HaVUleNgw96YTuh3djdrz2q/9Jg1U171253HsvR8bDN8B+oP7ffdGaOGDPBwNNxXVX3bNWKRyIgcJHq7tABKhhOa4XAQK+kEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3119.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 16:06:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:06:30 +0000
Date: Mon, 12 Oct 2026 12:06:25 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, tj@kernel.org, 
	neelx@suse.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <pvnvyzf3cbebpxmobjntvovrruxgnygm7pwgx3tl2jczc7ji5z@ygmd6z4cfxh4>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
 <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
 <asxLLWOQQzolER0a@fedora-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asxLLWOQQzolER0a@fedora-laptop>
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3119:EE_
X-MS-Office365-Filtering-Correlation-Id: 671725e3-5c78-4871-c5a6-08df287ac6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|261009223027099003|10067099003|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Na8dD7iov+YqIcUDQBXJCNZqH2X9fzp9cXwQ8VTQTd2lSFsJqtQ1qkubEcaNj4GkYXJPhLf4/tMH8z5VtD5Ya4sg7herWFbEt8eAXfBhHYcQV+dBomVsFrBL+Tyq5DKJZ8szfyoJR8ycwVtkeF4CnKxKjXjuml6Ji4nTvNDLMZ+mrXWhIoZIMz1PZ5/EHaSs/KFnLCxp5Tx9RbKZQ0IAcfPsC14SNoxOskdEMpH8IHb73iPMw5fRnNRNMha7JMVTd9DIy0Cs2ngzhXKVJY4pEmMY8WvoSQEqG6JQz2DbMV3biFJcRe8OYUOPoSfPQ09azzYe+Hd4l26gVyGBXcXgS1FW5jNLmt+ZDcycX+1dOd8/l/EGKoUuqlCZuaF3o0B2TBOOiH6xtDd14299wyUJU/hSIuovMkjj6EBZYDZwfajbI7p+SPHJ2pJ3btvgmPQRBdH19fKQyPUFfJN9ZibWtNuLQFe5ev0SAjotAitkuJhabtewZ7k+edmfls/o1nfAt7bBlgWH6Ccd5dFOFsQQBWSG6pxY61vvcmktcGtk9M9slw03f0X2AcDR/NOkNdWp221yBgaX1bKyi6kNkRN0roD3wOO+kygNP5vztMBN4AdVoRkqxoXQAWO4dBiK4/bJiy7fj0320YL57zkgBp8+RDGZ9IbmwmIKu3pKb8GqlQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(261009223027099003)(10067099003)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2pOaFlRYjRQLzZ0UytZVXNPbmV4RnZ0YllJdVpJcVpDaDRLRXVxT3YxM2lB?=
 =?utf-8?B?SkY4MDNuSEJrQUtiNUFaV0U3MnpKempuazkvajBkK3JsNGU2Uklvc0hONHBU?=
 =?utf-8?B?amU4Tmg4eGlpVHBuSVpyVGI1dHB4VDNHWDNVY0trZjAyakRSdWNVSSthRnZa?=
 =?utf-8?B?RGhtWE14MEFwdjdzVE5veXRGOGJSck1PSGJKaWRhZ1M0NGc2ckd3NmVRaWxk?=
 =?utf-8?B?VkJJMGF4WXRwb0hTYmFRVlBpL01iaHQ5QUFkVTlLNUZSSlpzbHpYRmpyQmFN?=
 =?utf-8?B?d0RPdnRKbzVyYTdMWHdGd2dTczEvTi9RSGNXU2NOeWhKc0laZ3I2ZlV3bmFD?=
 =?utf-8?B?aVBLZlp4b3ZQRlVSSmZrekZ0T2JQRFczcFRFNWw0QkczTWxXV2NULy9lU294?=
 =?utf-8?B?MnozdmV6NGVsMnJFSGl2TlYzRlB6ZytOcXNwSnowbGdqaGZYcHdGaWJPU3N1?=
 =?utf-8?B?eXJlVGFKY0locmdwVWhCQ2hSbzFHVE9FOFFVRUsxcjNJV2NmU01ZM2R0cFNV?=
 =?utf-8?B?dkRlbE1kSnBtL0dRcVlhNlk1Nzl1QWd5Rk1jSnptaE5YRzBOSW1DUm5NTFI4?=
 =?utf-8?B?ZXZLY3lxbTJQZUFaNGF0MkdrSldCdFZDR003QjhwMDV4UmsxVXlaQUxKTzFq?=
 =?utf-8?B?QmhtTUVEdDI4dTN3WEpRMzYzVlZwUG5BTndkM0V0djBuaTBBZTJGU3ZHb2V4?=
 =?utf-8?B?d2REei9IVlVyajVaQXJlUHV4R1g1OURLU1NMSzVCbGhwT2tBZGRQTm5NSmdO?=
 =?utf-8?B?TlZHR0Evc0F6ZFhFWXJJR2tSdi96VndESWtQb2VsdStmMlg4RG14Vzkxalh1?=
 =?utf-8?B?MHpmN3lodTgybGZLZys0WVdKaXdZUlQ3M21pT2lwNEF5QzdVMzdJSVpUM2hR?=
 =?utf-8?B?UzRzVisycGdIUkxyWmwzeEdvc1F0cWlGUXJjdnlKMkRyRndXc3JLZG1vcmQz?=
 =?utf-8?B?UG96ZXhOeGhjY0lRTUVaWUQvcnN4cHh0em0yNS81cGNTaVZOQ1R3b29jV3gw?=
 =?utf-8?B?MitCUGFvcTBMWVBnbnpYU01uYkFNM21ROXZ6TjFIbnplNFFPd0x1VWpSaDVz?=
 =?utf-8?B?R3lWU09EcURpNTdrWXhxWHRLUVJYNGIwcGZtKzJhMzdrWkZ3dnR6bFZHK1I0?=
 =?utf-8?B?SzB4KzQ5Z1NKY1d1SUxXQnpnNEZraDlnbG1GWUZyZWdUTkl0cDF0ZXFPei9K?=
 =?utf-8?B?MFZYdFd3Y3FNY2tVa3Q0SGh0TURVNEJrUWtaWHBQZ2dnQTA3ZklDaGtuZzhC?=
 =?utf-8?B?aXpYMjc0WGZ5NVc4bWhpU1owQ1JqMmp4MEphT0ZnVWZrcmFDaXV3d2JtUmxO?=
 =?utf-8?B?QW8xS3VxazRvSElqWndkQTloQUU0ZkF1RmdWMTFoYmlJTys4Q0tXeFoxcExu?=
 =?utf-8?B?RVVHMmZPRk5Gczg2RDVoUjA5ZFhMVUVPaWQ0cWRwVis4ZkVVM0lUdEFEaHp0?=
 =?utf-8?B?MFhzdFdsWk5sc2hBS2FqQ3lSM3pnemk2Q01sTzNGOEhONTdjVldYUWhOMVJ2?=
 =?utf-8?B?ZjkrOVZrNGQ3NjZJeHNoeHU1S1RSRko0c3JEMjlxUi9JeEQ4WGxlYTVCWlA2?=
 =?utf-8?B?NVVHYVVpT291ZGlxbWVTcUY3NlkycXN5aWV1TjBBL0lXOTNWOXpES2JMZ041?=
 =?utf-8?B?TnM0Z3VrazZTa0cxUTJGTEJjVDh1dXowVGxXdGg0SWtWZ0RPOERpeXc4cHJn?=
 =?utf-8?B?RStmYVFQRTliS1FvaHdDSGdqTDVOT2pzeEFTNU9NU0J4cWNhcWp1VGxxVkxz?=
 =?utf-8?B?UXp4WlYycldpR0NDTXkybi82Z0VYUjduajFjQjFCZXJZazV4RTF2Q09PVURa?=
 =?utf-8?B?anVwRFEwNUNORzBsQVhLeVBOSkJqckRFMUtpZ1MvQVI5UFhDNnc5NTlIbE5v?=
 =?utf-8?B?VXZYSVoxbm1JZ2djSFN4YlZSbWZzOFg0V0o1ejJ0a0g4YVBsWUtYb1pTWEZh?=
 =?utf-8?B?TjFRbmxtdTBVT2VWSnFPelZINTJvVEZMVEFKVnhTaS9kUElJKzU5Y01vYW1r?=
 =?utf-8?B?ZFJvSzVxcjBNajd0VnEwb2ZydE1UUkx4bGxQSDVKbUw5Sy9rYzBmZkhZNjF5?=
 =?utf-8?B?VHBuWXFPS0tNU1dVZVhhMHVITGRqdWd5L0lEKzNPa2N0RXpaLzEzcXNLai9i?=
 =?utf-8?B?SDN5NkRFclQ3SGxJcHU3bE9UTkNUYmJUTVBkdXpGK21XUWtZQ2J0cnpUM1Fz?=
 =?utf-8?B?M05IK1NIK25SQXBWdDlZc0Z3VTdnWENmelZIQWlEcEp1L2hXSkxCVEphOWlQ?=
 =?utf-8?B?S3NnRmgvOWpHbEs2NFJRdlE1S3RzSGxveG1xZDZZWHJ2d09tQmthM3luY3h2?=
 =?utf-8?B?MFV1QWVJNDRRMG11bjJPNGRiYUtScXF5RlFZbUVFWUx0YlBSdG1NZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671725e3-5c78-4871-c5a6-08df287ac6a9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:06:29.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpDa6dYblYvn4KYZ/KUCU7NhY5m/GBkjqBMyPvYBuGrfOPCE3z1oOHVdHI9MB3l/qlc2GuTTYrJ1c6NCxerDRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3119

On Sun, Oct 11, 2026 at 09:51:25PM -0500, Ming Lei wrote:
> > Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
> > to provide a non-isolated CPU when dispatching &hctx->run_work, no?
> 
> Does every WORK_CPU_UNBOUND user have to handle it?

[Adding Tejun Heo]

No, because almost all other subsystems passing WORK_CPU_UNBOUND do so on
unbound workqueues (e.g. system_unbound_wq).

In kernel/workqueue.c, when WORK_CPU_UNBOUND is queued on a WQ_UNBOUND
workqueue, workqueue core already handles CPU isolation automatically via
wq_select_unbound_cpu(), which respects wq_unbound_cpumask and steers the
work item to a housekeeping CPU.

kblockd_workqueue is unique in that it is allocated as WQ_PERCPU to
preserve per-CPU locality for multi-queue devices. For WQ_PERCPU
workqueues, workqueue core cannot silently migrate WORK_CPU_UNBOUND to a
remote CPU because callers of bound per-CPU workqueues expect local per-CPU
execution. Thus, blk-mq is in the unusual position of passing
WORK_CPU_UNBOUND to a bound per-CPU workqueue with the expectation that it
avoids isolated cores.

> > I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
> > architecturally necessary and fully aligned with the rest of the kernel,
> > no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
> > defers execution to a background workqueue. That work runs asynchronously
> > at some indeterminate time in the future, long after the thread has
> > returned to its time-critical user loop. Having a kworker suddenly preempt
> > the thread later is likely not desired.
> 
> We are talking about `if a task executing on an isolated CPU submits I/O `.
> 
> If the task has been submitting IO on isolated CPU, why can't we keep
> scheduling WQ on isolated CPU for running blk-mq queue? I am not sure your change
> makes any difference from user viewpoint.

When a task submits I/O, synchronous submission occurs directly in syscall
context. Note, in the following example, IOCB_DIRECT is applied since the
file was opened with file->f_flags & O_DIRECT:

  __x64_sys_write
    ksys_write
      vfs_write
        else if (file->f_op->write_iter)
          new_sync_write(file, buf, count, pos)
            // filp->f_op->write_iter(&kiocb, &iter)
            ext4_file_write_iter
              if (iocb->ki_flags & IOCB_DIRECT)
               ext4_dio_write_iter(iocb, from) 
                 iomap_dio_rw(iocb, from, &ext4_iomap_ops,
                              &ext4_dio_write_ops, dio_flags, NULL, 0)
                   __iomap_dio_rw
                     ...
                     iomap_dio_submit_bio
                       blk_crypto_submit_bio(bio)
                         if (!bio_has_crypt_ctx(bio) ...)
                           submit_bio(bio)
                            ...
                             __submit_bio
                               blk_mq_submit_bio(bio)
                                 // blk_mq_run_dispatch_ops(q, blk_mq_try_issue_directly(hctx, rq))
                                 __blk_mq_run_dispatch_ops(q, true blk_mq_try_issue_directly(hctx, rq))
                                   blk_mq_try_issue_directly(hctx, rq)
                                     __blk_mq_issue_directly(hctx, rq, true)
                                       // q->mq_ops->queue_rq(hctx, &bd)


However, if dispatch must be deferred (e.g. BLK_STS_RESOURCE),
blk-mq queues &hctx->run_work. Now, if &hctx->run_work is queued on the
isolated CPU, it must be executed by the local kworker. Because that
kworker runs under SCHED_NORMAL, the user's SCHED_FIFO task completely
starves the kworker. As a result, blk_mq_run_work_fn() never executes,
hardware dispatch stalls, and the I/O pipeline hangs indefinitely.
Albeit, I believe an enabled Fair server, under the EEVDF scheduler, will
prevent this stall.

Anyhow, offloading deferred dispatch to an online housekeeping CPU allows
the kworker to run immediately and complete dispatch without priority
inversion. As noted in commit a46c27026da1:
    "it isn't expected to let block IO disturb these CPUs. blk-mq kworker
     shouldn't be scheduled on isolated CPUs."


Kind regards,
-- 
Aaron Tomlin
