Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DE331A65;
	Sun, 11 Oct 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742950; cv=fail; b=pg5rnSwDq59EFgfcoYB8E4oTR3WKLl03X3vwD/buvm/V5UKf6uMI5X4bgFB8+hRQtL2qDz9m9O6Cjg+gMu4R2twsqN3UKze5/E4E3oV2p8wBbbFGU+MJDsPMKfAD+BWiYSNdhrwdj48VBN1CrA4DHl3xtVIIVrC/SfBgYH2YpjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742950; c=relaxed/simple;
	bh=BH4VtehASHj8VF6Ta4K1YRJZYT06uaZktC1dPzN0o3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uKzrANu1A7IYybUBHDr8UI9jfYGjWD00fpGjWJmcXRNblVcEcM2shk1eoDzXmz3Ef+CXCr9O5bGy3mFGN1XNy8p7JQH0OfyIXjkYuPqIsZAKk8+YMRA1d+/MmO9NmXmXvBG3U9Ht8Q6p8eU1aNwbIvjMkEePX0H7c250uKT15wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=is/pYKB4; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="is/pYKB4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK0u4Ny6dfaclTgQS+3S3eRWjWZY1V8Xlsz9yc8+brnC4g0ZmsDKrYEyKZxA99CtPuDemkVF+l3ELaPQl0jxwpIacbO3ayNgRI/B9KepmfRS6G2rV2k+wm7JT/TUXESyEFxAm2yelA4LwqqyskTuvEDMUkmu4II+7F5xqdVrVVgPN4FeoHqPBQxB5QNf8Ikw9pU+hnU4G7KlwIBTj1Hw+hBBuL8/PK7TfWAxogakH8sA84ZWmx25sqJSijGt/qoXk8wbM0oTzf49IEpwxzMuphMSIqd2LezxXocPvCzw4U/SRsh0+7NlcoDlIv0w36Tz/1UN0pEUZbaZyLM5S6KDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tR5t+hAmK0Rr5dJK5AM2K+nlVdr2ZjSaMWtfWEzmPU=;
 b=NqsXzGPMH7ulvkpMBVbGXO6ljE22iHYt52J1ZFda/wMjWA+ydtHQx4FXYvKEBbcSdYtoFD3yPokQ8zPVA20AQBCurvqdV0Vj9WMXROos5zg3EJTGyI2jALJGPKuj9Omkm8zs+BwEe+x9m7PFGvM10AYqGcuLeEBbM3RBSUzM2vZT3eJd25O8qx1fq4TzIN2etpx90DnouDbZXWw8pLqO3G9n0xCFInSMz0asjwaIixUAkV8THGDowGxNWvrCMOFdQNvf2fjqugByLbxldVDe2RUq0lNS9SzaOOAzDe9/T//bcdKR3E/1czU+d7t7BCx2mirypMUJZKKsMh5gaSWTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tR5t+hAmK0Rr5dJK5AM2K+nlVdr2ZjSaMWtfWEzmPU=;
 b=is/pYKB4XLVipNgs6u370pFoGFFGJVJA5rpVVJ4R37DgpthczlbQMev0alo/c0d4E4PaOjjEB3bNbmPg+Bbkzw0zzL62NSa6Nxg6eLHaogyyN0saSz5GvA0eLqjqcfgazScgQxZ8UtQPSGnpGrx3/cdJLfqV6k8nbD9YyyzLxob8lJLXDpfbNV8z0ccGvmm/CV+UrBy6cbU6lK8zJdNhrQBctf3TKEQAwIgPS8YeDXALQD7UcVTWr20nD0wEi0g7Zbu56XKKSwr+RYrWnaW6jPGjn3iBUh3/XHm8tTC8Uhy4uQOUpz1qQxBGcWF5+wkS5+w/UZ4uSi5D5cAxg1s7Qg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 18:22:25 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.020; Sun, 11 Oct 2026
 18:22:25 +0000
Date: Sun, 11 Oct 2026 20:22:22 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: idle: Respect task affinity in restricted
 CPU selection
Message-ID: <asvT3st3qtn05dur@gpd4>
References: <20261011173100.2090211-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011173100.2090211-1-sh_def@163.com>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: a4135cdf-c5b4-47bc-649d-08df27c4998f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	1+ikkVsRicj/ETsM1RopgnbJ+fWDJK0zqqSvUeEkhC5Lwn0OO3IpC6+fE5Ujkxiv+uP38uH6t1MepZT7WBfP7Bgliy+taWfQzyWBl/BvjYl4/DHBTTmoxIuV7U21RLsCeRbj1dnxPFHQSwNIPjGB1vzBrfyPaETWuXLzf3tBYYIE6g+NwuvFmB60rlfhffnxRUucuuiZJwV9tWchgsOQfiNRORzkwkOEuUPqiGLRqd38gooELNTCikrijY4F0lVEj39sAWVlTrvnqgDTEiZQRYf2iHS3U1phXmJ/lNPnvHJ+TvY1YcEWy9XZt2VyeQrk3Pj9tEURvjlNkv504MBRlOjDYv/wwR0N2PkXzByK0gF5pJxbdcTm8usmMJrWhBfP+i82kXTn/NvKuZLbTAjG4Utwt7iz8Cvgc54bBpnqKyF5/IZqLasgmZfdfk27e2RDTfvdr11ta3ob44HENd8AbxD+NaI4/i7PD4rKU9dEsqTT1jtJG7zXLrboBNcv+uvm9CIgXLHAEBXsgk7769ZnyoM1KlnsUN5yJUc3HhOuhcr3hoNpu/KC7qFQJR4XIGRK9IHr5CRu14phDmgv92O8Ljdd2VBpRA6gPPHj6ytZ/foJZf+eVxCdeU9Q9VP7u+X4bdmciqF0NovFpf4QmxtNt3fCiURifNFn1WodV/xj1Mo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LNCRqRUS3EXm6GDoBcdQuRKBkhTOxsVxjvvMAHhGeepvukEh/kpuOYW+3riJ?=
 =?us-ascii?Q?KppZjNLC3UixYvsr6HwwMAkIcTclF4cvB3Q4EydYJzdVnQZ2JZYU3/WvwM6/?=
 =?us-ascii?Q?A3/6L5NWgUUvxyJDK3pEuj1TqVWoGXw5iAwXiGq0BTTGeQeB2vkUMDBp9GTj?=
 =?us-ascii?Q?fmOBeUCVV0Om2fFkag89tEXuq/cdCo4WBfbBtASqnh/AwqGruPe0q5xtFlaL?=
 =?us-ascii?Q?Rh4z0QkoY427M+rilz+jMToRUw6UT8OWbmzJ/DlvP89E7tofDrkip5ea81/f?=
 =?us-ascii?Q?fCX/bgyEIY54H5x2iMX4aMeVIrSkF0pYsJdLTEqd8Iv7bSV5WupIkIuhVQjr?=
 =?us-ascii?Q?wf/kBYQAP0x0REGGbEzWzoUAEe6sxr1pn2SaCQ6j9N9ugSwa1K/THrJAOGDy?=
 =?us-ascii?Q?Rc1gB0lYMSxcuwOEvbxugWvW9HSDJ4PHf7O5PKJ13pBYBr4pPiK1nfjgJekq?=
 =?us-ascii?Q?d/ot4uxMYDeIG7/HIuY9vZJBKQ7TKFPCYjJeIuh3i3hcVnntfs/WpdwVf3FG?=
 =?us-ascii?Q?sc5Zdf7r4B7LORR2b6gDn0/HKkgcNnpzcizuPVs366kcVu+DBFKNBHMG1tMP?=
 =?us-ascii?Q?SH/s0Op/9uCpwM12SsjKGYU/V4tWK5DWAhQdBjS8LUsrq/zUO7je9MMyyZAv?=
 =?us-ascii?Q?dYK1J5sdAMu2QtCCpOPWJtle2XLWDfGmP5y0rcMTMIxAZCiTpShpmm2rFMW9?=
 =?us-ascii?Q?CUTGOe0EdSJcr131ULufFzuMntREIXtDYky44rtGBwq4V9IaiC/qfesyawz5?=
 =?us-ascii?Q?BQyRmH7LranJIXLu1uYxisoXmUkOdq79uLZoKj76lmfl5AnkTxA812ey899K?=
 =?us-ascii?Q?mEf8E/rCTP23+/CYnyzTY2XV/13gzxPwg1uqe59Acoi0XpoHFFSZ+zDmti/J?=
 =?us-ascii?Q?U8NXX2k3J+saijjO6i9GxYkx2JG+MyuI8ks3cl6OTeP/PiRICon1U+wMIxw1?=
 =?us-ascii?Q?eMiLzWoPbZ4lCPcXXYeVjo4KwuIs6oSCNhXaUCAYENdHEsYuC3T8MAR/Hdb5?=
 =?us-ascii?Q?XB1p1m83wwM17mnVf2Nu1go3D5740oi2eJmk1faHKCOoT2yk/GZS83ZoLlaG?=
 =?us-ascii?Q?Pf9obXymigkkS+79cm+9lIjlut1P5AKQxp8XYej0ndffiSZkG5qxToYOM3YP?=
 =?us-ascii?Q?QFU/Krouc0qvIQVbPe2XvlBdXhfOUUy3SQ2O+9zIrQeEaP1p6mRGtFEa2Jmq?=
 =?us-ascii?Q?dQpgWzs6d2DnTNReN9DlbyZOm/IemrT+ZM6fC+4D1SnCEmcDZb80rfpdKMtC?=
 =?us-ascii?Q?Z1ikiPXGyOEObSAcE0R03255CE3Wx1Wfr3p7elUO/yWdHprCe+Lgk+WZrLoe?=
 =?us-ascii?Q?xllau5EtqT9t39kl81MVFsPL7pQ7znwY1uAVhgwEwJz8FO8C4Ep80AEuNlyI?=
 =?us-ascii?Q?8oXBHJbNWKFbsppIxmOVvUIbLmUidzqLmJk6hXG765luT1mVPBKwhMgp+hNV?=
 =?us-ascii?Q?Ka0JlvDabXM6Dth3Cl9e74PD9DuHISvCKgNqHgXYmZal1N2PO2PFYJahl3DW?=
 =?us-ascii?Q?ThiiVITK6JIIm7Jbsva371XiOeVWRr/hdcoAbl6QzN1XruYU3T86gfNznn6g?=
 =?us-ascii?Q?wmzjOrDmLsgGNnjp+4PGVf/IEun8s3vDKbnHNgrgDixCDRWAfGmZje+Mbzvg?=
 =?us-ascii?Q?zqlsvU4p4C+C/L1eHblJTHVQL07w69NojqHAtSpwV8d4hcI+/4Z578ByeLkO?=
 =?us-ascii?Q?VmCtTBOYNYWoI2MV7Is/ukggW4DMf9YIiQfTN13inK3JrVLh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4135cdf-c5b4-47bc-649d-08df27c4998f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 18:22:25.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1zyQpPnYcTinroh9wh1V5LjreuKxQAdFwCIhqGm5cKQq6bCVs6coMV/wu4teXvsZPWuB1r5M7EjiU3Hm+l65A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770

Hi Hui,

On Mon, Oct 12, 2026 at 02:31:00AM +0900, Hui Su wrote:
> The restricted select_cpu kfunc path handles single-CPU and
> migration-disabled tasks without going through scx_select_cpu_dfl().
> 
> It currently uses prev_cpu as the candidate, even though prev_cpu is only a
> hint and may no longer be usable after an affinity change. With a
> caller-provided @allowed mask, this can also return an idle CPU outside
> p->cpus_ptr.
> 
> Derive the candidate from task state instead: use the sole CPU in
> p->cpus_ptr for single-CPU tasks and task_cpu(p) for migration-disabled
> tasks. Validate it against p->cpus_ptr and @allowed before claiming its
> idle state.
> 
> Since the derived candidate may be on a different NUMA node from
> prev_cpu, also preserve SCX_PICK_IDLE_IN_NODE by rejecting cross-node
> candidates.
> 
> Perform all checks before scx_idle_test_and_clear_cpu(), as a successful
> call consumes the CPU's idle bit.
 
> Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> Tested on x86_64 KVM/QEMU:
> - Private BPF harness passed affinity, stale-prev_cpu, caller-mask, and
>   cross-NUMA SCX_PICK_IDLE_IN_NODE cases; v2 returned CPU2 across nodes,
>   while v3 returned -EBUSY.
> - Build coverage passed with CONFIG_PREEMPT_RCU=y/n and CONFIG_SMP=n.
> 
> Changes in v3:
> - Factor restricted selection into select_cpu_restricted().
> - Preserve SCX_PICK_IDLE_IN_NODE and add cross-NUMA validation.
> 
> v2: https://lore.kernel.org/lkml/20261011131700.1351541-1-sh_def@163.com/
> 
>  kernel/sched/ext/idle.c | 50 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index aa9fb6de0ad6..28ed9e327085 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -952,12 +952,43 @@ static bool is_bpf_migration_disabled(const struct task_struct *p)
>  	return p->migration_disabled;
>  }
>  
> +static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
> +				 const struct cpumask *allowed, u64 flags,
> +				 bool migration_disabled)
> +{
> +	s32 cpu;
> +
> +	if (migration_disabled)
> +		cpu = task_cpu(p);
> +	else
> +		cpu = cpumask_first(p->cpus_ptr);
> +
> +	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> +		return -EBUSY;
> +
> +	if (allowed && !cpumask_test_cpu(cpu, allowed))
> +		return -EBUSY;
> +
> +	if (flags & SCX_PICK_IDLE_IN_NODE) {
> +		int node = scx_cpu_node_if_enabled(prev_cpu);
> +
> +		if (scx_cpu_node_if_enabled(cpu) != node)
> +			return -EBUSY;
> +	}
> +
> +	if (!scx_idle_test_and_clear_cpu(cpu))
> +		return -EBUSY;
> +
> +	return cpu;
> +}
> +
>  static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  				 s32 prev_cpu, u64 wake_flags,
>  				 const struct cpumask *allowed, u64 flags)
>  {
>  	unsigned long irq_flags;
>  	bool we_locked = false;
> +	bool migration_disabled;
>  	s32 cpu;
>  
>  	if (!scx_cpu_valid(sch, prev_cpu, NULL))
> @@ -994,20 +1025,17 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  
>  	/*
>  	 * This may also be called from ops.enqueue(), so we need to handle
> -	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
> -	 * selection optimizations and simply check whether the previously
> -	 * used CPU is idle and within the allowed cpumask.
> +	 * per-CPU tasks as well. For these tasks, skip general idle CPU
> +	 * selection and validate the task's only usable CPU directly.
>  	 */
> -	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
> -		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
> -		    scx_idle_test_and_clear_cpu(prev_cpu))
> -			cpu = prev_cpu;
> -		else
> -			cpu = -EBUSY;
> -	} else {
> +	migration_disabled = is_bpf_migration_disabled(p);
> +
> +	if (p->nr_cpus_allowed == 1 || migration_disabled)
> +		cpu = select_cpu_restricted(p, prev_cpu, allowed, flags,
> +					    migration_disabled);
> +	else
>  		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,
>  					 allowed ?: p->cpus_ptr, flags);
> -	}
>  
>  	if (we_locked)
>  		raw_spin_unlock_irqrestore(&p->pi_lock, irq_flags);
> 
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> 
> 
