Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE88144F55B;
	Sun, 11 Oct 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791729566; cv=fail; b=tFrXpBkQFFLD60VVrRQxQRO8ofsAq/wk0/Q3YRThpgb8V3YvzoTozFx0/aPql7nGmTFLXeHVLPKTIYLQHMwTiDi4wrhOXDyrF9kEodyqDBJX4Pg5SozMwBBIUgX+sLJdV4bGx1OROOf03cG8TUE/QKg8G4av4gvCo1fM/nW/Ye4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791729566; c=relaxed/simple;
	bh=8qvJ5mCNCbaeAL9RKu2PFamKtclTWAmOIgyrUs3X0fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FyinO2s5E+14EBQB6fxjqcLZ92gI4eYPtFQnuop1kgIc7ie2+0k0hX+kVXsV1gMVN5jhkRitR93HPO2uqlb8m/Wk9rKRh/2JmGZZTrP6I5Db68og0+gRoNPqb/nSABxHpXDuOxRYtSAWbxsIJaCBeg60wa8PWDT4AutqC7MheMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e7uCNv0x; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e7uCNv0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOvRg2R7bZeo4g9TBjwJR3F8soiB61s/AMvg5e7DFScQ+K2gKirGaAMH+Vck4M2ISN5yqFALr/k+HhykcwDIr0NY58fq6VIM67X7K6Fj8TEIM+fRQcYs0bMn0SCfqUGIWYUSLxt4TWjHNdMzQI1fAPxS9bHVDJ4FYYht3Shrtmw6xufedcGTjU6CG2Mr9bQC9dVN+jsKAuoQWLvoVsVhvIN7bM7pTyJ5qLNgZJiNVXOM8GimDpqwnYFqgeSSiy60O5lUlMLDwS525h2bvLJE9m07UR5a11NCfbjU52DftcJJs/16IUGgaqMneda9u9OH91ClnPSDA5Umwmc5JMSsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51vZ+DBHqRKPRwALwp0y8M5pjHTS6+g31NsiU3GPQbQ=;
 b=jZSyfBvVdt5DSqMS6FxuANN6H+5lpxlLmwUHnN5RUrD+S77A4xHMQLtyt/fPot/hApRD1JFvnPWygY00ySxjZEysF1kYxAkayiN7HODm41TQpM0tFTg7VDRyFH/mouVQfiqamZyho/QUQhmwVeWEwkI6JFAARwswNI3jtUqpkfhJ1pNDq7Yn5paTDrnp9XjpJ/z0TtbTtfO60aCa79XKdXmZ/nqAW23hReb7XQ2Gkf9DVJEOTpFKE0nMRaMFYFfVNp3UUAomhyHzKPTDJhvMK0cIzdOXi3NSiXLlb0uEfyfH9xyUpexWz3DHUUURnruJhzUi3b7TtUmfcPlprGOA9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51vZ+DBHqRKPRwALwp0y8M5pjHTS6+g31NsiU3GPQbQ=;
 b=e7uCNv0xpyx5A0WzPEmEHHhKAcPWgkhq+GVaAb7U96QsdwavBRGdPtTe78bGt5pvfGLKWxbLWS4sA41mWk4S11hmpBMbtj1qsi9irG2L6amMq3PxaQI0/6rWMCb5HtLschUCac3gOdJYr0ZnsWLPScfQBKeMjoIyMqLb/Gv1ZLcvhDumuej1amHFC67xDzr9dmYuuXc0c7uKjTx9n1G7v/qrAikTahx7JtQP6HeRdc1bYoBGmpghE+a1S9AMzlJ6YhB+9RZPfot7E6luVhOoYB0tCQsbUuvJczPuOu6EOquAu4zycXI7BNsQPNotQ3z4UjWUaq7emuEIM6DawNkfkg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 14:39:21 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 14:39:20 +0000
Date: Sun, 11 Oct 2026 16:39:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: idle: Respect task affinity in restricted
 CPU selection
Message-ID: <asufkdwCQvilJEqr@gpd4>
References: <20261011131700.1351541-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011131700.1351541-1-sh_def@163.com>
X-ClientProxiedBy: ZR0P278CA0151.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::12) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: ce08dd17-757f-44cd-9fa8-08df27a56f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|261009223027099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yAqLYiGAqZwFySZL5f4jhKaEcRHoylTTyBvk41oOh4y99weflIA5cn2c5cX9jPLViIL5Xa/a/uJAE6WJI2XEFZ5WeQdHK3PL95NWqDZ/dSefOCHQ904DHNc3fJdJmpoB7kQdvBRC/VeHimOKWHIgfiVF7h0UUeHIYbINxLwrjTCKNMCKfb/dWtDOascZocHu47xXY5O2O0pwiiCl8CUlgPODUbYpAHq2WAn+SJYzV8DRbzKYsmZQSuv4opgP5LoubMHWLzfyIMvidJAyo3KY/J63RS7Yp/eepP58hRqtHknUd+tcxVnVNvlvhxhS0ymSKxWFW4XgIXfcDNd2fZeXsP4YslQOEoE2HY53j0iwNg7hwGhIpaCHofO9JAir9a9ZG2eIJwBfI+smjAzeG2278dtXvL3vkAC17pcBnl0OdESIASUaOKIQlYzGUQSx3TOkbsbVfGMnGsTQmw8zo6MvOb/xxC/hgtQJ4qIzqq38hVCBV5x8nrGdWDK+iHbAUisK4WrL7yLlQrBwXLU1wTypi4Z0svMAFEzTY9sZsdlA0AoOauMPe7pq4KQYzXgOp67OmClIYOC4Jtek+h7S/MYfgk4KfQXDGdg6slALmPpTYTUO2ffQFGEghladhThdIly5bHhZ+IuzIndSzpfERXFgEPNEe8FV2XIsYH9OCXwctZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(261009223027099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNDMbu8cYTz1EOxEpTKw4QYIW5NgJ+vlR3BB3jaYorY60zsFkAOGra4l8d31?=
 =?us-ascii?Q?n+PI6LsBPfyrdx9V/GMxEFBlXwXRf6gR5lP2eV666QEqhMEWk1UoLSNY8OPV?=
 =?us-ascii?Q?GlmXruk6cGjdgmlNV4vueqan0MB7SrFF2rHQLFYrfIfX9e7wYFwCAiMOeT6/?=
 =?us-ascii?Q?e2QvJhaBnviBDaN2hPIM8UX0U1pNWDI1HSC5yyU8b5QYXdxoo5zh0WmOuSDf?=
 =?us-ascii?Q?T6/mvHssmoFJFtwmO8jaNG/BgvPOZtjaG+Bo0/W2kWWLtxl3WHEfyXAk2NKh?=
 =?us-ascii?Q?nzhrpwY0H7icPkxOpDRXRBgEmlnUxs0csNaQPNtf3DJ9qZKVy4Z75I3vVZcb?=
 =?us-ascii?Q?of9aVvL/RgFtnUS6yiiRoV+Cob0TQ9r6GaSU8ztZjuXClb0beo2B+0fpSIMf?=
 =?us-ascii?Q?qXaMM6jANil2EKwjvnoWwtsbe3kuX7rLzc0C3QNTE0PiWqZpReocZp0uyx7w?=
 =?us-ascii?Q?BZLXmb8xBB3boG0xkQrNvHNE4NcziE7yTxy0QkzGZphuAWfMaaYsP8eLIt6z?=
 =?us-ascii?Q?AWPGpoTzhY5/58sVzGeP2jicirUrhdXsro6Ibuzn1kQp/A3Hd7tQylEUWjRk?=
 =?us-ascii?Q?z76pF8PxnxBCsWOea2+TjL7ZP904VkRKLlMI9/dh3dScb5ZaXCB7ttDOAKqy?=
 =?us-ascii?Q?9C3Fj6Q/xs/xOMsqBZKlCMvaa1lt2zT1FA44opBYZkZF2LHNwSaIXTiNdQJP?=
 =?us-ascii?Q?yf2AS/bAoPFHf2N9Vg0W4Ct34Uj1NGUO7Mj4U1sGuqbKbC4ct9h/zVt5+kh/?=
 =?us-ascii?Q?4IDFwAcyDzeqWPX4zhdFIUjkxcg//cAhSPc2Fgg7dcnBQQ/HqfOxaEvtR6Ua?=
 =?us-ascii?Q?ZeyKh0/+29QTzImnWlNgJDR1gPayE+LChf6OX/Bhk38pQdhVfgCrkkcBifVV?=
 =?us-ascii?Q?h6/p8xmogeXZY6YxsXLfB5JCjYLT0LeT15pFX5w9puGG8ay8rXrBqPgOXM8y?=
 =?us-ascii?Q?0KFciRZH196SbsF5skp/nh1Wo5dqmzeH46MPuzgA2t53SYM75I/76Ot/ECgP?=
 =?us-ascii?Q?gIOe8w2kCM8kG+k9R3o/HqQEutpfpDYRH+7lt+SQNDZM4/N35ObPg21nTjZN?=
 =?us-ascii?Q?FdoFHeStpO7dumjtNrzUL1x9xLzmRWacNgvXqWAEs4G8hVQWSfCJ0/4Eob+G?=
 =?us-ascii?Q?sbp55jlEa6S5UgJZshA2LjhqAxem5lDJiWqws8pRqQxFXj75btlDEZTv64xE?=
 =?us-ascii?Q?bxGkP1EUNwAFPM6R9Dtvg8IFElRoEH/kF4t1NgYbs6JV26Hdf9XEei7ewdXb?=
 =?us-ascii?Q?SrzMR7bRFHsOx780zJzkK6Xdb0TQEhVM3EwSwFusiUNPaF46SWdC0LtCJ4QO?=
 =?us-ascii?Q?QSF0QRdnQ+G6omd0vfDyVEo+qsLW/jZx6Xn6OCeIUEzvq0mrkicSWuodMinc?=
 =?us-ascii?Q?Gr+6W/uhyglRaCrAi8TTgxV+P7BRDQWEt7z9FBgt1TaSmFxeLDiGMIpUQecc?=
 =?us-ascii?Q?BOv+GYsv6OntbPq3JCihaAe6MO1nEibEKF6cAhkkfzdvY5LaAzQhpPvpHye1?=
 =?us-ascii?Q?nP9kz5T5Wq5KzMCAd7TgOWzb2qd9Uzo/25JJw9EEM2Dnu4Cq4gpBRhcHIs34?=
 =?us-ascii?Q?Z+9kQsxa7KqiDVR7VKK0TTgJvAE+B8lZqWPXNh//eDSjBy9/CyGn8bSzjcDn?=
 =?us-ascii?Q?zlEMsMNDc096Z4TnrMLW9RxRpYeBs0JODiXRHugJhMSyCUoLb2bMaBFg/O+Q?=
 =?us-ascii?Q?nMYtXwNFg4m71xQmgfDs3yyZZPBKP/CwfcNu7sg3aEyHTASq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce08dd17-757f-44cd-9fa8-08df27a56f83
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 14:39:20.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU7b0+OuHA75r6dxMRw+JKrRmqzIkxpFN349ta0lSw8Cygn2GM5jte3/ejVOXUIpOlUdAjEiuTz8dWSpV00PlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191

Hi Hui,

On Sun, Oct 11, 2026 at 10:17:00PM +0900, Hui Su wrote:
> The restricted select_cpu kfunc path handles single-CPU and
> migration-disabled tasks without going through scx_select_cpu_dfl().
> 
> It currently uses prev_cpu as the candidate. However, prev_cpu is only a
> hint and may no longer be usable after an affinity change. When the caller
> supplies @allowed, the restricted path can also claim and return an idle
> CPU which isn't in p->cpus_ptr.
> 
> Derive the candidate from task state instead. Use the sole CPU in
> p->cpus_ptr for single-CPU tasks and task_cpu(p) for migration-disabled
> tasks. Validate the candidate against the task's effective affinity and
> the caller-provided mask before claiming its idle state.
> 
> The validation must happen before scx_idle_test_and_clear_cpu(), as a
> successful call consumes the CPU's idle bit. A later placement validation
> therefore cannot undo the idle-state side effect.
> 
> Single-CPU and migration-disabled tasks skip ops.select_cpu(), so this
> path can instead be reached when the CPU-selection kfunc is called from
> other contexts such as ops.enqueue(). The normal ops.select_cpu() path is
> unchanged.
> 
> Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
> Testing:
> - x86_64 KVM/QEMU private BPF test-run harness:
>   - The baseline returned CPU1 outside the task affinity; v2 returned
>     -EBUSY.
>   - With a stale prev_cpu, the baseline returned -EBUSY; v2 selected the
>     task's idle CPU0.
>   - A caller mask excluding the task's candidate CPU returned -EBUSY with v2.
> - The stock sched_ext allowed_cpus selftest passed.
> - Built vmlinux and bzImage with CONFIG_PREEMPT_RCU=y.
> - Built kernel/sched/build_policy.o with CONFIG_PREEMPT_RCU=n and CONFIG_SMP=n.
> 
> Changes in v2:
> - Derive the restricted-path candidate from task state instead of prev_cpu.
> - Document the idle-bit side effect and the ops.enqueue() reachability.
> 
> v1: https://lore.kernel.org/lkml/20261011025256.4180374-1-sh_def@163.com/
> ---
>  kernel/sched/ext/idle.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index aa9fb6de0ad6..1ccea60e9012 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -958,6 +958,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  {
>  	unsigned long irq_flags;
>  	bool we_locked = false;
> +	bool migration_disabled;
>  	s32 cpu;
>  
>  	if (!scx_cpu_valid(sch, prev_cpu, NULL))
> @@ -995,14 +996,21 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  	/*
>  	 * This may also be called from ops.enqueue(), so we need to handle
>  	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
> -	 * selection optimizations and simply check whether the previously
> -	 * used CPU is idle and within the allowed cpumask.
> +	 * selection optimizations and simply check whether the task's only
> +	 * usable CPU is idle and within the allowed cpumask.
>  	 */
> -	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
> -		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
> -		    scx_idle_test_and_clear_cpu(prev_cpu))
> -			cpu = prev_cpu;
> +	migration_disabled = is_bpf_migration_disabled(p);
> +
> +	if (p->nr_cpus_allowed == 1 || migration_disabled) {
> +		if (migration_disabled)
> +			cpu = task_cpu(p);
>  		else
> +			cpu = cpumask_first(p->cpus_ptr);
> +
> +		if ((migration_disabled &&
> +		     !cpumask_test_cpu(cpu, p->cpus_ptr)) ||
> +		    (allowed && !cpumask_test_cpu(cpu, allowed)) ||
> +		    !scx_idle_test_and_clear_cpu(cpu))
>  			cpu = -EBUSY;

Sorry, I suggested this, but I just realized that we break SCX_PICK_IDLE_IN_NODE
if we do this. What if we factor the check with an helper? Something like this:

static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
				 const struct cpumask *allowed, u64 flags,
				 bool migration_disabled)
{
	s32 cpu;

	if (migration_disabled)
		cpu = task_cpu(p);
	else
		cpu = cpumask_first(p->cpus_ptr);

	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
		return -EBUSY;

	if (allowed && !cpumask_test_cpu(cpu, allowed))
		return -EBUSY;

	if (flags & SCX_PICK_IDLE_IN_NODE) {
		int node = scx_cpu_node_if_enabled(prev_cpu);

		if (scx_cpu_node_if_enabled(cpu) != node)
			return -EBUSY;
	}

	if (!scx_idle_test_and_clear_cpu(cpu))
		return -EBUSY;

	return cpu;
}

Then the caller becomes:

	migration_disabled = is_bpf_migration_disabled(p);

	if (p->nr_cpus_allowed == 1 || migration_disabled)
		cpu = select_cpu_restricted(p, prev_cpu, allowed, flags, migration_disabled);
	else
		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, allowed ?: p->cpus_ptr, flags);

Thanks,
-Andrea
