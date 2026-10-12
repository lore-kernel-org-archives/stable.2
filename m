Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022139.outbound.protection.outlook.com [52.101.96.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963D7331EB7;
	Mon, 12 Oct 2026 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771672; cv=fail; b=GAh+J/IMBY8zV71Y9pFVXrPQ1ohOdHthkxJwb08jhEjlBfHQcorzXVRGmaRoQZekc1QoJn7iysyZq00t1Pec0Pay3cwe6DHzXPHfC7VhivLlhT8yjhUBofWS2AUUp87ejYdiKhtrgQlWNU8nSkx+1aCxGnRrsxTAJnOfTv0w58s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771672; c=relaxed/simple;
	bh=GEIKj4m1fhwdj2XFgP/RRjQnbnTXDxKewbG92H4OE0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=brlVpFNB6Dxztob+PlTWRwGhmwuuIIgiF05pKx1dUqR+Jyozez5hL4vxk28iszk3m5Bx37EaYyYAXttH0Jiv1T7sh3120WpwxLUw7cCCdamPDnB0Roht1Ya7QDxFLGBABENg5cNXnLv+ZUjf/fjndnWRZTgwGWqUjgwMvuERFGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmDoiIJeozDUqWjwcPJZ47wHP/5P4Ta4q/+w+rTeiYcS/zZiZuuZMAgHX2PXwWvw9g0T6WmTO7DqdkTyexjr7flNwp/HLMtOYOmaw2vGXXyZqkT56Bxelj4japoW9d7zTsvYv5cuq6zRmFC5ysBCoJTpj8dz3mz+eGPn5qIV/sWi3fA/VZawMYDkjzs794pAzOabuBbRBqMtNcQwFisly4E59RP0uLeKN6/mT8/Yig4KMt0snjIR74dR2b/hzX2gk3p8sw9g8dRrrO2ohuoEvk77hibuFck60UOpnXoXp9RM7DJIoCfZ5C2B2mN/QUYfIsRQVDG7mgsDFCgybQ7fRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tnRrXxMozwxCDOR/xoFAfuq/2jmNqNvLH9vgASxzDIY=;
 b=JMMHBksQiCWl6jLaaF0x31QKvhuBTLAkEer8Kyga7w8i0z+Ri/RsRmCRGF6zGwOkKBn9gtUAKfmVbxaKfaMMzWTM3pxY+dhKuyQwjO2H1WYE3YH+Z9ZOplpnZytGATcN9APOBiVH9vCwZ8XAjoi8yVHcLkdGi8qQBhtPk5rnMXmy5saCyb6Nh0TFsh/j/WSEICokwA/u3TwmH5oF4vwVrwPsYGfl8eEMhKTEaiTr+OG6eQ8ZAlN4jzVO04SGkDt/oFuVe5kl7CdbRr6lmbQ/9dnFWLSTRrcLZj2CwXyYOCbomnSHikmpBTkxsCavVIje7mpqELFAXMxw/nebfACsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8152.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 02:21:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 02:21:05 +0000
Date: Sun, 11 Oct 2026 22:21:01 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: axboe@kernel.dk, hare@suse.de, sean@ashe.io, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] blk-mq: dispatch kworker to housekeeping CPU when hctx
 cpumask is empty
Message-ID: <o2hxbjxbkg3wv25lyj3nluwv4e6cb6q5qaukrhjzwg2hodwk5c@wgpc25peito7>
References: <20261012012905.267920-1-atomlin@atomlin.com>
 <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACVXFVMTr8mORGSVM4JWHrLYgk+9O0J20bjaL_08uYmRCbzC3A@mail.gmail.com>
X-ClientProxiedBy: BN9P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc09047-2195-4ded-a47e-08df2807781c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|18002099003|22082099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	yjn4vP34LUF/DPnue62O1CEbW1jT4AZCRoMVaQV1bM1umn9EtiQKUSS6mhAJwml8kMMvX6355a2TM46dEEt6HwWDN7GlT0bwFU5UBtF7X6XnpSfTNm9y9vPPsN3+GwCiEnKxNlC1jfeJFEi/VKNSvYpt0EjPzjf91iLPUQLIikT03aBRBkIqgLE3z0fSYM4S9Zd27HVQnF867LOnxo7WJfvSlIPKS2JRwpcPVCUMTybnl+nX5Z9iZ+4SNOfhoCiMpPH/ysWjI52tLUVsWUKjhafovpDt+jxN2gqq6sUrw2bMxy6T3HudS8t0WSYmLF0luPEbObp61MMdJVB8Jp9sCD1v0yKtTFyt/FAb6MfPRsK+mv/mmEGlqu0cQkC52Z1+rYFzQ2qw6IUVcydNq7om4blQz4FKeMXpilYM1hk4dJBPrKICQCgw3fgX0pTK2RgdewAtQOFB4Gh7kdT3s55LCxOWMAPuQE5a7BLLtrppPZlfMulxHJw9C/6M6pFRQUxW07Xzylz6ePq3uN63IyYL4zsfHCiBcfYQAgX3vR+fxaAj+zMLkbokBxK5taaVfkZwUrcrTSF7u53nwIk31j7qipZGhP1Yz6AoDt5NPsurfWY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHAxbVJCUFVBTnFnQXJ6Zmp0WEp4WU5aREFoWXdicG9yNFdiOVRLZGUxbHVM?=
 =?utf-8?B?ckMycElmTzk0MUNsV0VnLzFrMXNXcHdsZGhIcGt2Q0tTSzZQMWJ2NDBORUQ2?=
 =?utf-8?B?ODdhRDVqYTllVXF4RTRpc2ZRZjh4VjdxTXJEdzR5b3dZa2VNMTFGejB3WFo3?=
 =?utf-8?B?UGlxU0xJY0JyU2ZXNU9ibkI2Y3RqaVk1S0VQd0JiWnNOazVFWWlQWnI1VSt4?=
 =?utf-8?B?MU9TSVhsMGdSRGZ3VE91QzBqdUdLVHAxRytTcWwrbkFOcE5SR2pVMkN5Z2xX?=
 =?utf-8?B?M2phWXFpK05jbjVvdGE3aXp6ejNaTHBzSEcwbUpxeFpjdnduSStpRU5FQm5Q?=
 =?utf-8?B?NVpvaFFmdmNEcmhRdGluRDJYZnQzVkJvQmNoRTVQQzhpc29OZXFRcjYyVVU2?=
 =?utf-8?B?TTl3Ly8rUTc4Rzc2K0VaUHdoUWdZZWFiSTNTWUluaXA5RGdxZFVKSUVUVW9R?=
 =?utf-8?B?bXZacDlhS3QvVzhkaWlIR0YxYytNbW9YN3FFeTJvdGJQQStucThNWnNYZ0Ey?=
 =?utf-8?B?OWlMNytFb0dvYTdtTDVRdDUrMmxKNVZJQzJJdEhPNm1Ua0JoWE5HbW01NFM0?=
 =?utf-8?B?Z2wrSUg5QXl3c3BLZDFFUUtCS2o1MGIrNDIvV1RPZjY5ZUpRNHVScG1VL3Ji?=
 =?utf-8?B?MXRjWXpPZ1kvSXNsTzdZV3hzcXZ2VHdrWFhlVnk5OUg4eWtEakFRM0hJT0Ey?=
 =?utf-8?B?N28vOHMwUFA0OWxRb2daTytuQ1Rrd0gzODlHdGpMdnNRMDBCY0hDRHZvcHRp?=
 =?utf-8?B?NlBmU1pBNW1qbFhmZUJwOTJmUnRMalJEUjB3UGhFZVRFaTVtY3FxUU9NWHVh?=
 =?utf-8?B?ek5qdDZ6ZjJCQWlsdDNycjRlakVFaVJvYTJCRWxjMHhaWmFuUklkcDZiWTM1?=
 =?utf-8?B?TGg1c0FnaGN1TmxncEEzenNycExZTEVsVmtJK3cxSW4rZ1NvUGN2Tys0ZVNk?=
 =?utf-8?B?bU9vbVFLM0JTTnY3SDlNbFExMFhzbFVNL0VLY3YzbENSRXd4QVlIT1R2RFdq?=
 =?utf-8?B?OWRkTWxYYUZuazY4MGplSEVvUGNCTkR0eHJWeXE1a2NFRGRFWWR1RFMzUzJX?=
 =?utf-8?B?T1R5YnVNSTNJaW5vWHUxdUkrSkZOd3JCdXUrL3BpMnpMZTZFVk91SnZ4SWJh?=
 =?utf-8?B?QjE5c25FUjd1Nk43VWlhVnp0M2ExRkJSRmNKY2lQd2NGYWg3YnZTbDB5Qmli?=
 =?utf-8?B?NUZBZy9CUUdqcU1KUFh4WGRwTFY1V09KRVVnRjRnZURKdkY4Yko3ejlNaWdD?=
 =?utf-8?B?YlVrYldLK0pTZlplOTI5M0o0Q3hYSytsT1dFNzJqMU12bDlma3pZQWhGK0FF?=
 =?utf-8?B?K3BQb0ZyTFRHdWFqbXovUm9yVkRTd3pNZFFCU2pPV0p2MVNwQitScDU4ajk5?=
 =?utf-8?B?RFdrUWIxNlJCOFdnVVErUWFjNGpmdHJJRXRKN0EwL2pKbmNHeTlUaWIwWjYy?=
 =?utf-8?B?MXZtWWlNWVJWbnVnVEVPT2Q0L0pEeHBSSWZJREhXVlRkc0E1aFZ5UXR3cXZq?=
 =?utf-8?B?d3AyTWNUdlJyNGhVWkw5K3dLYWloNTJPeUJTektKTjFHYzJhRnBPc2h2TVRp?=
 =?utf-8?B?czF5K1hBTnNmdWNuTHlueEVVSDlrRitSRnlRZVlrdGtXNmtPa2JjengrMkx5?=
 =?utf-8?B?NytydENuY3g3WEV4dnRvTTRVOStEQ1FGaE1HTEt1MnovTVlINjJjSXlNcVc4?=
 =?utf-8?B?b1JUamJEVU9zaXEwYk83dm5mdlhvNnhCTU5OdWJQVTBTOFE4emJKN2VIbml5?=
 =?utf-8?B?QmhVVSt4NHR3cDJjZWVwaEdmckQ0R0tWSzJzSEVZTmZLUU9PTUlkNC9WU1Q0?=
 =?utf-8?B?eTRKRkw2ZXhHZG4rbE9ubldsZmRoYStwKytVL3FVMTYwMCsvNlppNzErK2Z4?=
 =?utf-8?B?YjljN040T2l3TU1GQ3QvcEc0ZERVRS95Yk9QblBkSEJkT1h3RWgxa042Rm1R?=
 =?utf-8?B?d3lsL0ttY2lIQzFwUVJKOGJkZlZ6RURvR0NJTnFZTVlIbXJvc251SlZEc0g4?=
 =?utf-8?B?RCtKS3FGNXk3SmwvS0NEVzB4WUJ6UXNnajRoZUJacDdjcXVoN3VoOExtTkxB?=
 =?utf-8?B?VmppaWNaRk9RVGM3dDkwK0VITEYrVG1RMmIvMFRKQ0lJNXJ3VFlRc2IvOEQ0?=
 =?utf-8?B?UlhTRkhjVWFLV2x6bzZpYkt6aERsOGk4ZDVMbmI1ckcyM0I0RFNrT05mSXZu?=
 =?utf-8?B?bTdzVjEraGRZaHBtVkRDNTdlbVJ3WFJPRkQzMEFjdTNwci9HZUV0WSs1VFVB?=
 =?utf-8?B?ZmFOVk9IZy9WdFp4b1pKTEpkQmRqNjJQTHI5NkZCcHlJcXpuVE1KaGxxemhi?=
 =?utf-8?B?Z3VxQndtUDZtUFdrUlBJcGc3UjZxR3JLRnpxYklsOGNEeHFidjlmUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc09047-2195-4ded-a47e-08df2807781c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 02:21:05.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3P+6AQ+uexmFtefQ94PPc+XtA2sqDDIAhueR1IKaOKZ5OzYn5BdoPzX6H/vCmZac29IWCqL1PZz2d3nHIiqlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8152

On Sun, Oct 11, 2026 at 08:56:07PM -0500, Ming Lei wrote:
> On Sun, Oct 11, 2026 at 8:29 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
> >
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
> 
> Then it looks like you need to fix WORK_CPU_UNBOUND, which has more wide uses,
> if you think it is one problem.

Hi Ming,

Since kblockd_workqueue is WQ_PERCPU, the responsibility rests with blk-mq
to provide a non-isolated CPU when dispatching &hctx->run_work, no?

> > Consequently, if a task executing on an isolated CPU submits I/O and
> > triggers an asynchronous queue dispatch with zero delay, &hctx->run_work
> > is queued directly onto the local isolated CPU's worker pool. This
> 
> If your theory is correct, why do botter to change to
> housekeeping_any_cpu(HK_TYPE_TIMER)
> if the user is submitting IO from an isolated CPU?

I suspect, steering the asynchronous dispatch to a housekeeping CPU is both
architecturally necessary and fully aligned with the rest of the kernel,
no? When a queue is plugged, throttled, or returns BLK_STS_RESOURCE, blk-mq
defers execution to a background workqueue. That work runs asynchronously
at some indeterminate time in the future, long after the thread has
returned to its time-critical user loop. Having a kworker suddenly preempt
the thread later is likely not desired.


> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 025a799f35b9..9480c3aac898 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2252,8 +2252,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >         bool tried = false;
> >         int next_cpu = hctx->next_cpu;
> >
> > -       /* Switch to unbound if no allowable CPUs in this hctx */
> > -       if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
> > +       /* Switch to housekeeping CPU if no allowable CPUs in this hctx */
> > +       if (blk_mq_hctx_empty_cpumask(hctx))
> > +               return housekeeping_any_cpu(HK_TYPE_TIMER);
> > +
> > +       if (hctx->queue->nr_hw_queues == 1)
> >                 return WORK_CPU_UNBOUND;
> 
> Why is SQ so special here to keep WORK_CPU_UNBOUND?

Indeed, it is not special here, and neither is the offline CPU fallback
path (!cpu_online(next_cpu)). Both currently return WORK_CPU_UNBOUND and
suffer from the exact same issue if triggered from an isolated CPU.

To address this consistently without penalising non-isolated CPUs with
unnecessary cross-CPU bounces, we can define a small helper. Furthermore,
the following will address the valid issue raised by Sashiko [1]
comprehensively, using the new helper:
    1.  When executing on an isolated CPU
        cpu_is_isolated(raw_smp_processor_id()) evaluates to true.
        It redirects to an online housekeeping CPU
        (housekeeping_any_cpu(HK_TYPE_TIMER)), preventing kworkers from
        running on isolated cores across all three cases:
            - Single-queue devices (nr_hw_queues == 1)
            - Hardware queues with empty cpumasks
              (blk_mq_hctx_empty_cpumask(hctx))
            - Offline CPU fallback paths (!cpu_online(next_cpu))

    2.  When executing on a housekeeping CPU cpu_is_isolated() is false.
        It returns WORK_CPU_UNBOUND, which kblockd_workqueue executes on
        the local CPU (raw_smp_processor_id()), preserving optimal cache
        locality with zero CPU bouncing.

    3.  When CPU isolation is not configured cpu_is_isolated() uses a
        static branch (static_branch_unlikely(&housekeeping_overridden)),
        compiling to a NOP that returns WORK_CPU_UNBOUND with zero
        overhead.

[1]: https://sashiko.dev/#/patchset/20261012012905.267920-1-atomlin%40atomlin.com

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e28c467a18bb..9fb1a93b2bb1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2244,6 +2244,13 @@ static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
         return hctx->next_cpu >= nr_cpu_ids;
 }

+static inline int blk_mq_hctx_unbound_cpu(void)
+{
+    if (cpu_is_isolated(raw_smp_processor_id()))
+        return housekeeping_any_cpu(HK_TYPE_TIMER);
+    return WORK_CPU_UNBOUND;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2256,7 +2263,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)

     /* Switch to unbound if no allowable CPUs in this hctx */
     if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
-        return WORK_CPU_UNBOUND;
+        return blk_mq_hctx_unbound_cpu();

     if (--hctx->next_cpu_batch <= 0) {
 select_cpu:
@@ -2281,7 +2288,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
          */
         hctx->next_cpu = next_cpu;
         hctx->next_cpu_batch = 1;
-        return WORK_CPU_UNBOUND;
+        return blk_mq_hctx_unbound_cpu();
     }

         hctx->next_cpu = next_cpu;



Kind regards,
-- 
Aaron Tomlin
