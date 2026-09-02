Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F176388887;
	Wed,  2 Sep 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372699; cv=fail; b=FoIc74ZLBtGEgXx5kLnMvBZ76z3bTlCEM6uEhMTDcq1SLiSHEjHjvcNFur6cRglEbN0hIoCBafySXkAwtpYnFfcBR6nj8JXkBeXffrzwrFwWVMKDK82zVxghBseNMmeLWEZgihOzg2jJ0EcLXZN6CvNVIXecQDhEQo0Q45eDL/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372699; c=relaxed/simple;
	bh=5pN6r0Kx6+t8DsrtQuMkANKyHI5vDZzI1gzcUUGN/OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sri5oPtmuEX6kOIjkpv9j8UA/vwsL8wBKFLTKjX2SOmEDuw/CFfixeZTGp0AcKkWM/+pPw/zS94e2y2xYseihekmm5mMhY/H6md0kROJVf/4T+hKhwlBAbkGTxNtMCeitpP5NbkPc5kQXTmPUSHu4pnUijYf7Pyr95+fxg7A4Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ta+kS52U; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ta+kS52U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JA661VO8T50gugD9BtHKPMr1y0ZnaMKFVMS9mNe7ev6cTAkyytRZjp0nJZCL/aF7+0GP26PnJM//ncLaAjmqGdZjmb0krKVIIxgff87KyIah354YFeUc5bMd/4o+ZH3qEN/MHm3buWUnY2DoJAuHu+c2T9gG5LiD4EFakhS8XD3dWRU9BVLjA8evEVKFi/8Rh6WfqLucUU0guzQnzjKhBOGkFBXKZxgwkHljdsbzOo3SBrEd20YLmi90HTFy8YNDzZ5Y7p++vrw5Hmp8JGwzRTCijf/MtdYWFUrT+8hoAe6XQVNGPcjOPhtYJSlzEk7aSfInd+DRmYMNPMAlV3UESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhFnD1C+hJtOTuk9mcPIcXyjpmEdFsvRwhotbhvRC54=;
 b=s92kBjMbzqZwvFD/vcs/tBEAtnPK4a/lK0KbqE7Q7QyYCP6BwV4znhYSbnRwjyJhAt8XSPZiXaHjlQGRxB6L6j9kRpUTz5zV1ZzZh03kQ+h4j7K355OMbaT50egskoh2gNysdxAPqaWlFTx9Wqfr/u5GQkZOJ93gAC3a+dwPVrE/RcZEgrXT9ryIo3XYYtpg9Wrxv/ChC4rbZbpxjc9x2+dwWlSKHZjRd6EUXrHJUgK5J3Dvof2q8ZfeqydW9QgIKpwgDBUfeHR1HVWVwoIZlIjjmIhjAIOf9gC3fiBMc4WcTo2hlSX/egbnkNGLCa5Cwdx5Uw763WMAn5R3usBx2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhFnD1C+hJtOTuk9mcPIcXyjpmEdFsvRwhotbhvRC54=;
 b=ta+kS52UHrGtdtGl52nk3IYue79cWRE3IrMxcJxm6hRspeqY0+jb+p1eLgKh+KD9I0KMhNLUW2bXO/hwpOX9jZHh92WOhqty+Eo8tP5B34wphJ496boRwBQCr1E6OgZACf2xxQV0+Gvu0Q6lSdlycImvgCY29VZ5bluIsboRllls0C705Fiv8yTPjbbrONgoHgPnKISquT46QOjv3c5RGaOv4jcKjyMaOZ/xCRR5AW6aw5Zx4/2sbrMd5NmDwDqIutRGSXp2ueYVz+7WHROwcfgqzwdllF1vRxEp+Q9GeHG4GDXI2vNDL2+PYvAykU2Y06qlUS3wNgDj3EF/z6nVdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:11:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 18:11:27 +0000
Date: Wed, 2 Sep 2026 20:11:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Wanwu Li <liwanwu@kylinos.cn>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Fix NULL sched deref in kfunc sub-sched
 error paths
Message-ID: <aphmwjLkdS4tKpbv@gpd4>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
 <20260902170751.256434-1-liwanwu@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902170751.256434-1-liwanwu@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B84.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::41b) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: 50da1a64-f7f7-42d6-58d9-08df091d9b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|3023799007|10067099003|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qe68B8kCq92UA4d5YNdSWNbedqbPahzcLUsq+RWj+tT6cVsCuz8+WeiCLUd73D57AYX8QmJUnSpSWW9q0iZAtz78H7KsAsy+MTo/l9Pce81oxrV8UC0gSRCkumtDtlDtjuz5e+G0WdpA28M+K8OsHthOisXU9Juphnkl+s2BHE7lx5lgUctqTkipEz/lXiESVIG8nBWDKvaKxLsDFT4tpdlVn/HzN6kuH1w96maMg2Co9Q/G5xsnFshEQgnxmwO4xeCNQ+eGWfxSuY9rHqohOqlj65tZqx4MioKBcKGccSOgMR1o9BXbnG92W+UDo5GEjvYwPmZ29VEXCJfTCQtqNxcRe0ujQtGX67t5isAakc3wsHP1tIqIjdQFcTrdvhgQ/smLc0mWYk065mmvdEiJz3dRBEHosEP2Emfvak9R8baPx36i31Ynm2z9eGEhj3uJzTLhhlwtTzzCGoDlUnPvsZUUynuSYIZBALW3Ub3uIH+KxEvdjj4FlNhNgxmOL6KmHYHkW/+v2fVtqyOb0EYVBQ+L3kw+3nFQ8gKfpumwahlgjb5DKiEuTC9fAmeeiO+UE/41u4UeJIiZNIzaVS3jV9uPUGVDIcL3Imks/OamGpWzddjPic7MKzd47emNvgNaKVh3FRodALLDoTo07dzKBuwnJmoqAQDg1NJfbFECmcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0I35xRMHA2mgH8GrW1FApv88G4aSUyLOVqNN1pL2bN1/spCVy19w+sUPqk/W?=
 =?us-ascii?Q?8b1Nq8CCgnqSYskpRg/FcgaH3vz28pKzlYDuKeBcfw1l5Mue7wBqvvSPxn8U?=
 =?us-ascii?Q?jq6uhsshAxyNWvbk4LBZ5lhsoVf8rKZSdAYnfgBGdzlN+ue3EB5b9MQeCFPZ?=
 =?us-ascii?Q?HgHeC3gnm73nCTBbHO7+BVV1teOIAd7sMKiP7oQmRvjo1A1oq8Z7uf6bLewt?=
 =?us-ascii?Q?dYbuRXuMOh9i46QbpaxiTQAUoRHBCqKFDNawI/QXoCyIFhWAZuMybdzsYVR9?=
 =?us-ascii?Q?4WCHD1OiAOmYiihVCGEN1aT+bMN314B+xepu4zCpjvvm5PNTZL1oA/t4W9N9?=
 =?us-ascii?Q?m8YizFYWdDJyOoqcJZNeI+UvUkv9UwBsfxBb94AYA0Fs+nFPqr4tAmscB48E?=
 =?us-ascii?Q?O3lrHzLlDAyKELAREkQ+qwiwoek/sRhXeK09spBzAof+yMeu5j9HFuq4SB5C?=
 =?us-ascii?Q?3oOf3zORXKBqUgRwnOdMUIQ9IMgIjU3a6l2mD+GS9ibgYj7e+YGB4E3GXc3N?=
 =?us-ascii?Q?o4uV9oyrdCf3o57NWEYar7cNp3+UFlQ9bowd4tEC6yy+UyX1RLKcGmz8jR9h?=
 =?us-ascii?Q?QB+g5UoCRfksBOyPKesxlVWZJKhQiPLNBBhx12ThfUjzM0Z7Rh5jOBvOdoH6?=
 =?us-ascii?Q?fo1GcM6ST0spooDFAg1z3GMojDlwXjA+E4ssRgSa4S8IJJFxjxllIud5SizN?=
 =?us-ascii?Q?D0OygAeCuUX6AGYT0cB6gJH2wlRlG7RRap/n3ECTccrDbWROtrvQcc/6k1UN?=
 =?us-ascii?Q?w1O8e7QFQtdrdW9VRU8fXWlR58yY2atlV85/sCVpNtPQaP7e5jLmghUUb8cw?=
 =?us-ascii?Q?bc0lZKl0N1uLVN0ci5GPaReMtKHMeQwQTNpbuCic0WfaLY3wCRk1+oC+AzY6?=
 =?us-ascii?Q?vHfsriWmT9lsivSqKpU3a+5zQMFB5qWakqSZ87qXpUWHVFp0CxI+0t89MIxl?=
 =?us-ascii?Q?WaMKbINiPziRn/Y/Psqtu8vOSLxMQcO+Y5eey+6X1hr9OkojT3DvJAmNIymC?=
 =?us-ascii?Q?8nRQ2EL+wUf2pGG0uExngMXjCxKZPM3tFzVBTVHkS1t1CMgBXeNUyucmRMEx?=
 =?us-ascii?Q?6XUSzFbptAoH2yoAfiKHU+Gw4arAMgJbDtZobbCRjHXwQODvbjF2gWkRZZMl?=
 =?us-ascii?Q?fk13ECSxs8lqKFwXZAm/gfUeG5ZdfbZUSB2ay1gw9XfSCgm0eSdk3IjyzVmU?=
 =?us-ascii?Q?Fa3eb+0ByCA0kFdR974raXZ8flXFS7P6WxU7LMgYl3iaPBfBTh3ZLb+59oL6?=
 =?us-ascii?Q?jE4mhwXvXLl24g1nrxLG4jOkTj0vOAelwQMV0euCBP/KXGmxf6VsOb29BNlF?=
 =?us-ascii?Q?PSWAtZhhwOOm/I5ZEJsSnVeMFGSKr5oiSR4i6706r3aPOq4YhR7uteJvNPFh?=
 =?us-ascii?Q?2GCYMCvFtehnTbxXVhOl2a8ltMNE70bs7EdufdPZRLZ3GDXr2lPuRfM08gny?=
 =?us-ascii?Q?jXTRCfJlT13glmUUhr2OzqdUOS5JUgMqbnSM9mqUv1caKmCPk+XdyAkeiyWD?=
 =?us-ascii?Q?yO+S+HdzWpncag8lxdbkc6O/o9nSauh9HFsvED/wHiI18B72MY07s24iPm/Q?=
 =?us-ascii?Q?zh5RXsW+A9L39mvJni1Tfv3fKi+HVWRMIps6G5mmkYp8XFLZNhzZYKhxDwRy?=
 =?us-ascii?Q?SXvEPkAqHbzb9sZs4mzR6V1zI5f88q3StqBCFivd1MQBMLUOijgbsmTUkHef?=
 =?us-ascii?Q?RghroxZphSGfkXtPy1QN+IHFG/nWZgWO/h856n9CghAu0ymoVVlqi14obD6U?=
 =?us-ascii?Q?vRWlGrivVw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50da1a64-f7f7-42d6-58d9-08df091d9b4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 18:11:27.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is1Sw9fCl0n9PI/oQ0sMxPqbbuFbl31ZhV0vbzOen7PhF4HFTyLpWWDS46KtatUafFWgVwoTs0Rrr5B4xjJS3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

Hi Wanwu,

On Thu, Sep 03, 2026 at 01:07:51AM +0800, Wanwu Li wrote:
> The COMPAT kfunc wrappers scx_bpf_select_cpu_and() and
> scx_bpf_dsq_insert_vtime() error out @p's scheduler when the root
> scheduler has sub-scheds attached:
> 
> 	scx_error(scx_task_sched(p), "... must be used");
> 
> scx_task_sched(p) is p->scx.sched, which is NULL for any task that is not
> on an scx scheduler: it is memset() by init_scx_entity() and cleared by
> scx_disable_and_exit_task() -- which sched_ext_dead() runs when a task
> exits. It is also an rcu_dereference_protected() that must be called with
> @p's pi_lock or rq lock held, which neither wrapper does. Passing NULL to
> scx_error() reaches scx_vexit(), which dereferences sch->exit_info
> unconditionally, oopsing the kernel.
> 
> Both wrappers are reachable with such a @p. scx_bpf_select_cpu_and() is in
> the select_cpu kfunc group, which scx_kfunc_context_filter() opens to
> BPF_PROG_TYPE_SYSCALL programs. scx_bpf_dsq_insert_vtime() is in the
> enqueue_dispatch group, which ops.enqueue() and ops.dispatch() may call
> with any KF_RCU task: the group has no kf_tasks validation, and
> scx_dsq_insert_preamble() checks task ownership with scx_task_on_sched()
> precisely because @p may be an arbitrary task.
> 
> Neither wrapper requires a contrived @p. Tasks that are never enabled --
> kthreads and tasks of other classes under SCX_SWITCH_ALL=n -- keep
> p->scx.sched NULL indefinitely; and a task handed over from
> bpf_task_from_pid() can exit before the call lands, as its zombie stays
> visible to pid lookups until it is reaped.
> 
> One concrete trigger exercised for this changelog: a SYSCALL program
> calling the select_cpu_and wrapper on an exited-but-not-reaped task while
> a sub-scheduler is attached (faulting instruction is the scx_vexit()
> prologue "mov r15,[rdi+0x398]" with RDI=NULL and 0x398 the offset of
> sch->exit_info):
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
> scx_kf_arg_task_ok()) and it is correct for the callers that take this
> path with a live task: p->scx.sched is their scheduler. Just read it
> safely: use scx_task_sched_rcu() (valid under the guard(rcu)() both
> wrappers already hold, no @p lock required) and fall back to @sch -- the
> root scheduler, guaranteed non-NULL here -- when @p is not on an scx
> scheduler, which is precisely the case that used to be NULL.
> 
> These COMPAT wrappers are scheduled for eventual removal once the
> deprecation grace period elapses, but until then -- and regardless of
> their removal timeline -- they must not oops the kernel on a task they
> are handed; this fix makes the error path safe.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: a5fa0708cbfd ("sched_ext: Enforce scheduling authority in dispatch and select_cpu operations")
> Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>

This looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> 
> Changes v1 -> v2:
>  - Extend the same fallback to scx_bpf_dsq_insert_vtime() as suggested
>    by Andrea (and flagged by sashiko-bot); rewrite the reachability
>    argument in the commit message accordingly.
> 
>  kernel/sched/ext/ext.c  | 9 +++++++--
>  kernel/sched/ext/idle.c | 9 +++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 10af28a9f2c0..fdfaa7e9c8f5 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8943,10 +8943,15 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
>  #ifdef CONFIG_EXT_SUB_SCHED
>  	/*
>  	 * Disallow if any sub-scheds are attached. There is no way to tell
> -	 * which scheduler called us, just error out @p's scheduler.
> +	 * which scheduler called us, so error out @p's scheduler -- but read
> +	 * it under RCU (@p's locks aren't necessarily held here) and fall
> +	 * back to @sch if @p isn't on an scx scheduler: enqueue/dispatch
> +	 * contexts may pass any KF_RCU task, and p->scx.sched is NULL for
> +	 * one that has exited or is managed by another scheduler.
>  	 */
>  	if (unlikely(!list_empty(&sch->children))) {
> -		scx_error(scx_task_sched(p), "__scx_bpf_dsq_insert_vtime() must be used");
> +		scx_error(scx_task_sched_rcu(p) ?: sch,
> +			  "__scx_bpf_dsq_insert_vtime() must be used");
>  		return;
>  	}
>  #endif
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
