Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5C4AA41B;
	Wed,  2 Sep 2026 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365677; cv=fail; b=aTM0mp7sEFAe5PbAyB+pAhjkMflRMIXTf5t/oOcJv+yOg4vUxLjn1X/GxLWwg8rgw2OOkvtqvFXLVKQMtoh2huZqaNDUtxYdTOp/ZSkFmU0Cnj/kWq7XTXcRoWemJGoJkKXUU16WglEYRQXrKkhBEjqkttW7+06tHwVRMiqvdno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365677; c=relaxed/simple;
	bh=cRP9geI9j/fXxbVXwV3LkJS8pv0n1ST1zhf12x5A9uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rm6P5rzYEtvdpMVgQ/xe76HzYvsskVzXteOrscqb5jpL9nQwu7mLEH76GKsJh0q5wN+xudZrNUvsLgZPzgJPQMaQEgj41ARn/bXR6zdhD2OncUfbDyMaI24kLnbuFRPEfzMMA0yONZdHdeJ+mwdnLZc4j04MGOfWlYKBuyN+nVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6XaOwcG; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6XaOwcG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDcVr6lUBuWcvdVdGVwX9FCxNASJkC7BXtaOO84AQiSsq/UbISo5PPeIuKwl2LPWUC5fx+hNcfUqQpg/86CqlrC/TmNd2Z/HPMKzERFJtLxAclpkacgeJPfHjPSKdieyCW3qO1LGGOA5qa97uY09RzpFUHwlzeN2u7baN4pLUMBzbbi2+PqbIIFjVlJq0UvKy8S+4cItyNBOi/SOrR1+7veK3g+vT20opkaDMBTg8TXKFPPm4nwQpvYmfzDmhjTko3ND1F3AiR3V/qnDIxr+lxdZmh0Jx5Ie8iTLhoHAO5RxFEsXNjDoI629tvP35X1nuUubcW2p0sLydtMJJYNQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGj97O6suJYaJByUfzUU/cvBW3lpKu35Hw1vGXTf5aM=;
 b=rnXjBQwxxYWqCuFaIT8ajOqyiXzxHBtBSF2A2sEQqc31Tyjeljp0kxOMRYJNeG+e1yrBGHjLeX2jJOznoAPSW8EaXA062kxV7C8e/nE/Cmc8y2b4EsCtzr1QgrdejFK9+s/jOaPAKk5XSOki7817Fwx7Tjd9JSWe/yMugVGlAMQE2dmZ1wCm/4KduV9No+J/69k0/ZkdzNH2qr3xjxx+fmqrrHMC/P9HqO6p7FwkksoNJyPQIy6oImOu+aRqGGyqdQoETS8+e6iiiJBTtSDCYkTiSOPYirBo1ZuyYYhCaQEvaUs81Av+cfA9iDbukLUIX9mXkWf/5dg1vQccO49FQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGj97O6suJYaJByUfzUU/cvBW3lpKu35Hw1vGXTf5aM=;
 b=r6XaOwcGiABtaoDUpf8dreYfFKJlH4B0zYRgTD9DiCXBA265ASBXeOMYoVKJfP0Owa5HECsqdUzEmvqnn6aKUYbjMz3NdYuMU4SJ4z0jMtkyR+61cl1rNhzrTMhZ+bs/Vr7d8rELr2s7M39DxcEjYfgQXkFRF6ScafCSlMJYjslB81uMQHDRRvWxgmXv8R+jqjs4z3swxgfLJR1j3YIqyvjYIARAzrNhe/CivY/GsPRjmFVdQdWtVr5DmnGDqIcWpP3yAf/3JJEaC3xisZl57RHPcRfXkuUeyXScas6ZYhGiLpuRfOiEFyc7defjzMfKVocaYM5144IAfJqk14QFPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 16:14:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 16:14:29 +0000
Date: Wed, 2 Sep 2026 18:14:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix NULL sched deref in select_cpu_and
 sub-sched error path
Message-ID: <aphLWtCVY1XVME9C@gpd4>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902153640.144791-1-liwanwu@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B80.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::417) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: efcfb8a6-362c-4a37-a261-08df090d4427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l0qCROgE9CWpLc1US0jRHe5gYPmds5ZEmQyI89SHY9zv3iTOmyxV+/67zCQVZBQyHXtsiMUc4V2TUqrwu5qcdhoMNJORC/PtaTxJlBoctUVvZL9nhSBLf5TjvTG4AAde6wtJr5exVxXytZ4WSqKlXguS4W6ROBZVpfz75MepQ3pgaghGEAfDamwa9Xj1M9le6BRMvYPJtj8kwv5splVWiGLTDJplJTFBSiA6vCfOqX5qt/VPy38440K0xlQ9ILy/bkZVndMoRqvC+kHEP40oA1mOk+W8S7XYoRwZ0qeKFC8dn5QrxiLfgDke5S7VTOhf9zX/RNcsubjTSEB7dofjcB3wkyyojcjdRlWT0AIPdYYuOVofBsZCj//Six9UPPCYMUUyIXZ/04qUbWsfxrybR2gxwaM5KcKGHt188TPQRss9dXGO8rDrr6rsZXq98R3ct9VWnUjpIskJRAx/JzToH41veOxYn25cp7oBpiVu2g3xaKnYz5Y5sZlnxf/Hb+vyqSqobx/cBR5euhhTaOamLTRLRQpvFNtJyeuPGAft4IrJp+C3UJhhp4aVA1KwlvzImB4cWoFeCQ+t5Lh74dn8wQwZ2r7pn5quxqxp15hVESNpa4YqzQ8YR3UkxX5ltZV/x7JqGThdD2CvunBF0KSjlAPnnmtAaCBXvnL3cBGIHAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAGL5VPjsZNu+bFi5rCAKNK7AwdLIGCivjNClu0vIRys3vTj5wLflVp61a2e?=
 =?us-ascii?Q?O4qr6ypz6ZLKunmDwrtcSBMXgQKPhEIXHDNJmzADFYE8y7MJglEUq20nF7xK?=
 =?us-ascii?Q?dH5diQp+0WXQLzGtocdsJS9cazGv06Ijl8SpLt4oCkck1+D1TYKEuGB+uY7K?=
 =?us-ascii?Q?KaP5mdi1csDTTcVVtR7/NmVjWgbdTdidNBbTYNbkC0DVxQQm3E4s7Ag+xwx7?=
 =?us-ascii?Q?pYggQyzfhTLNKyMkK0s1pDjRuD2mTdnTy0GL2DkEsYEJv9ko4AIbT99LZRS8?=
 =?us-ascii?Q?dbLGEeyCDXNSb5aMRs0YJi8Kk706hbZH4ba/M01YzKi5blXrfxWqQI85WkBt?=
 =?us-ascii?Q?C6tgFsoVs8xhNmitk9M76Sc43SZHraolU0y1DU2xid2WjkD9OVrYJ3SkLhgn?=
 =?us-ascii?Q?i+AlZy5U8t7vBEKXgmo3e9chAusmZeTwjO1EXWq9Ob2KLw9KiGP/MwsSw7Ii?=
 =?us-ascii?Q?1W2INOtrOo2CeQL91LU/V2vfddf0lfsvkvEYohJsa3+0jvKeqqMUE1VDSL9G?=
 =?us-ascii?Q?RaujpgoXgEwMdbcAxWaWK7QGC3eRQXCM33rp5PTsMf2atmlmmqU7+1rwbk9w?=
 =?us-ascii?Q?s/XcQfKdzH7EbuS14/qucxzr3Jwo8c933tPT5XnDJHcwj0VeWH/VvWV/VnOD?=
 =?us-ascii?Q?knGEIxHj9ASnRZNM6GMboSruvyU/rUUvHs+s2ElXIBQ4v/oBwBSuORvfIxVH?=
 =?us-ascii?Q?iY4gGSJkhIqdAUd5a+Ch82o3s3omkF6RA++EpcWSzh4fm1CAyTUS0y77yAa6?=
 =?us-ascii?Q?kw9dFiLUYTQ7MupJI5JB9vpqDHp6LYp4N5AFaoRpZmu+25SUnyaLwteOQGpL?=
 =?us-ascii?Q?hP7uXn8SFxj4/FgwgLL5fyyhStGeH1wtF1Ze68rGbBw8CNIUBP/87E+yNwpZ?=
 =?us-ascii?Q?HV90qEitjwUS7CUf/MIydjNXWpr9RF3RIricRcZ5cRrrocuvEA+PPU+AjZgn?=
 =?us-ascii?Q?7pfEiIA5WyzXWZqnBLg+/whRZcNYKCEG3jxbmpwThAjSGBbDQnfy+bmzPWKe?=
 =?us-ascii?Q?sslJk+LkwQWR6KThHup+N7bNDLGB56JbmS4YfowQ9gBku9n6KbDG563NIZz+?=
 =?us-ascii?Q?D4o7ZskCVlSAXa9RwxTL9rlldqh4sj9A+4M9qR+fy2FMz6+K2eMnYwPXQGEb?=
 =?us-ascii?Q?sx26MldhlK9LCs4e/h4MmWwGAKbbMHzAus/6uVL/txGhLldUAl6anwtcPm1a?=
 =?us-ascii?Q?076825oscczkgRl5DUifQILxqM25cQOUeFE49gVa0jE+sikWkMKzeD1FyZW0?=
 =?us-ascii?Q?5D6qrUUlK7u4vzkdMqAJFEwvvwaJY+vvxul6GNyPVHy3Yj9iDRqynBChOIly?=
 =?us-ascii?Q?zkDyKkyB3pqEuUAjWn3yw/l6K1Vz843/cyxcQNIg2+3G05X66KfO7UgHKnH5?=
 =?us-ascii?Q?k1fJ1dqIo+kUU5zcqLB0U7ITkXERNSmqsBrkAsnbvcwWrLhCUYrsR9GgJPG7?=
 =?us-ascii?Q?ydgySLVOz8OI1N1y5mjcjT5yFxWby07oCovtZN+AbS3wYY9Bh/yIYIVmQtrZ?=
 =?us-ascii?Q?T6++6vpYT1dFe7R1a4nXIp50AGS2jYghBgEAp0ohuYtjzTYWPgDAZNuvfIie?=
 =?us-ascii?Q?jWu+U4Ux14sURLYm6Er1Fr3wP2ia1YEkM/o+77IwNh7cRUStu6AYdUvVO9R2?=
 =?us-ascii?Q?HJ9Zpu0PejGbQRqpjfrW5+69BB6te0y1wM4hn2wYNTcLBrzkm7zGIQiqG5Vi?=
 =?us-ascii?Q?zohkC9B7I0huvxBKahYxrwXzWyk3Q1aRzNjX8n6Ev8KlOrdEa1IP+0ZbtSTX?=
 =?us-ascii?Q?ZWV8IXHmKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcfb8a6-362c-4a37-a261-08df090d4427
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 16:14:29.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwRMGdc7LHltoKzeznH+MpJofdXNW9eekdSc+w8JPHMJirFcuNIAyAQM8HCHYwqbCj6mXMsqEkwT+EyIq76FAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251

Hi Wanwu,

On Wed, Sep 02, 2026 at 11:36:40PM +0800, Wanwu Li wrote:
> scx_bpf_select_cpu_and() errors out @p's scheduler when the root scheduler
> has sub-scheds attached:
> 
> 	scx_error(scx_task_sched(p), "... must be used");
> 
> scx_task_sched(p) is p->scx.sched, which is NULL for any task that is not
> on an scx scheduler: it is memset() by init_scx_entity() and cleared by
> scx_disable_and_exit_task() -- which sched_ext_dead() runs when a task
> exits. It is also an rcu_dereference_protected() that must be called with
> @p's pi_lock or rq lock held -- neither of which a BPF_PROG_TYPE_SYSCALL
> program holds.
> 
> The wrapper is reachable from such a program -- scx_kfunc_context_filter()
> allows the select_cpu kfunc group for BPF_PROG_TYPE_SYSCALL -- and the
> program can pass any task, e.g. one obtained with bpf_task_from_pid() that
> exited in between. scx_error() then calls scx_vexit(), which dereferences
> sch->exit_info unconditionally, so passing NULL oopses the kernel.
> 
> This was triggered live on a v7.2 based kernel with a
> BPF_PROG_TYPE_SYSCALL program calling the wrapper on an exited-but-not
> reaped task while a sub-scheduler was attached (faulting instruction is
> the scx_vexit() prologue "mov r15,[rdi+0x398]" with RDI=NULL and 0x398
> the offset of sch->exit_info):
> 
>   sched_ext: BPF scheduler "kfunc_subsched_null" enabled
>   sched_ext: BPF sub-scheduler "kfunc_subsched_null" enabled
>   sched_ext: Unassociated program run_select_cpu_ (id 76)
>   BUG: kernel NULL pointer dereference, address: 0000000000000398
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   CPU: 7 UID: 0 PID: 8201 Comm: kfunc_test_runn Tainted: G W
>   RIP: 0010:scx_vexit+0x25/0xa0
>   Code: ... <4c> 8b bf 98 03 00 00 ...
>   CR2: 0000000000000398
>   Call Trace:
>    <TASK>
>    __scx_exit+0x4f/0x70
>    scx_bpf_select_cpu_and+0xab/0xb0
>    bpf_prog_430ed61a7b66e03a_run_select_cpu_and+0x9c/0xe7
>    ? __x64_sys_bpf+0x2c/0x40
>    bpf_prog_test_run_syscall+0x130/0x2f0
>    __sys_bpf+0x930/0x10d0
>    ? __x64_sys_bpf+0x2c/0x40
>    __x64_sys_bpf+0x2c/0x40
>    do_syscall_64+0xbc/0x460
>    ? rseq_set_ids_get_csaddr+0x81/0x140
>    ? __rseq_handle_slowpath+0xd0/0x130
>    ? switch_fpu_return+0x51/0xd0
>    ? arch_exit_to_user_mode_prepare.constprop.0+0x87/0xb0
>    ? do_syscall_64+0xf3/0x460
>    ? irqentry_exit+0x48/0x740
>    ? clear_bhb_loop+0x40/0x90
>    ? do_syscall_64+0x35/0x460
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> Keep the "error out @p's scheduler" attribution -- it is what every other
> kfunc error path does (select_cpu_from_kfunc()'s cross_task,
> scx_kf_arg_task_ok()) and it is correct for the callers that actually take
> this path: the only other callers are the struct_ops select_cpu/enqueue
> ops, where @p is the caller's own task and p->scx.sched is its scheduler.
> Just read it safely: use scx_task_sched_rcu() (valid under the guard(rcu)()
> the wrapper already holds, no @p lock required) and fall back to @sch -- the
> root scheduler, guaranteed non-NULL here -- when @p is not on an scx
> scheduler, which is precisely the case that used to be NULL.
> 
> scx_bpf_dsq_insert_vtime() has the same error path but it is not reachable
> with a NULL @p: SYSCALL programs are rejected for its kfunc set and @p is
> always the calling scheduler's own task in the contexts where it runs, so
> it is left unchanged.

The reported crash looks valid to me, and using scx_task_sched_rcu() with the
root scheduler as fallback also looks correct.

However, as also pointed out by sashiko, the assumption above doesn't hold for
scx_bpf_dsq_insert_vtime(), although SYSCALL programs can't call it, STRUCT_OPS
programs can call it from ops.enqueue() and ops.dispatch().

Can you update scx_bpf_dsq_insert_vtime() as well with the same fallback?

Thanks,
-Andrea

> 
> The proper endgame for these COMPAT wrappers is removal once the
> deprecation grace period is announced and elapsed; this fix only keeps
> the window from oopsing the kernel until that happens.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a5fa0708cbfd ("sched_ext: Enforce scheduling authority in dispatch and select_cpu operations")
> Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
> ---
>  kernel/sched/ext/idle.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index d2973fb3af6d..014599d82bb0 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -1142,10 +1142,15 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	/*
>  	 * Disallow if any sub-scheds are attached. There is no way to tell
> -	 * which scheduler called us, just error out @p's scheduler.
> +	 * which scheduler called us, so error out @p's scheduler -- but read
> +	 * it under RCU (@p's locks aren't held here) and fall back to @sch if
> +	 * @p isn't on an scx scheduler: a BPF_PROG_TYPE_SYSCALL prog can pass
> +	 * any task and p->scx.sched is NULL for one that has exited or is
> +	 * managed by another scheduler.
>  	 */
>  	if (unlikely(!list_empty(&sch->children))) {
> -		scx_error(scx_task_sched(p), "__scx_bpf_select_cpu_and() must be used");
> +		scx_error(scx_task_sched_rcu(p) ?: sch,
> +			  "__scx_bpf_select_cpu_and() must be used");
>  		return -EINVAL;
>  	}
>  #endif
> -- 
> 2.25.1
> 
