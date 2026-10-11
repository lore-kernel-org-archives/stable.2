Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F12D47E9;
	Sun, 11 Oct 2026 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702148; cv=fail; b=F+cM5e7eSmLTx6LC6+PfVLeeX+DKxKcwL4/Vg2pF7c9sUe1lfaPd3yzPFn4vmRmFt1hGnTpXDwQ3RIbuSmiu6ovydz0pQ09J0whlg4NikPM9IZPqA1T6qZ+PERIhhuafw+/pumaciLu3RLmiiztmYi46Nccoc2Fw/o61oJf8cgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702148; c=relaxed/simple;
	bh=vEEQxyETH29bodhYcdqdTKT1PLylsFhVvqcgHfqLAGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u6pM3tT/y6p7Hh2SLIFD3luQg1j2rxfQOA2DR9onfohx9y3gG8pyTra3Ur6DOYuOZ+QZDm5GF4g1ZZQGLvnfiXJoG3WRhVJb3FfPRLjdYHoFcjgJzkhc+7wHUkjKljdAgYYeykawLqavOlX1fm1HPFKBlOnSKVwcXuo8ZV0eQck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iL8Vpi64; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iL8Vpi64"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6G+JocvIZnts2TaVnoiqVf8FU8iXX5/ZStGnQBg+VWk40FxolNHcOVIwqE7O2Geq17nyy7EOJ42TsX5TzD4ikXwtRFd6LKMUajf/in+pYsuEHP92PyMxw27KWQitANUcChwh2X/jMYBqgcIqBVKqTqOTfVoS1vb0EHP0buBLEoMErxgBKhERaQMmxpwdmvecUfcQjnRUSYCLeIWoe196QWgNK9sBi6fYGhk8tFKCcxnnj/SsvcbdvccoXrtIt1S5pmH7uQoaRvUp2eKqhJBfeOIrvao98daYReFZcjzCRmcGdxcBjn8wtK4OkmV6dtxW2DQH4hGYxR+SHismnd+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtpXSIXBUSUT2ZRvweTyICmF42ml6PkqRZz04dn1MXA=;
 b=YdEXsyUM5MwkQByV2XLBsac/DC73rBIeBgRL0YCD9ZOqFmxePfGAlqYGNYXgB9ieDbPsedF8GSRZCeGuYkzu5r7Flb5kp7Iu/ViAQdfM7b6P1Wx33vrz7xYzYs+jxL1yPNkUIcMvvOlDQTNFYnZHa8ap/dhzBlXAeWxNHsxgtVlyxv5Qti4/CH7up1CSIYsN+r68qzruxJnx81CP6lL8SU9y/B/Nu9eNTwlPow5KWv3YZX02X3XWZ+Ji3DCLlXPd6oJgMD7lr4qpkEEMIu47lXQjEP3mzkTFp5tqg3pceaMePHdVaotTQsKp/6o5j8uTVvd2ELkknVcAoFo/nLjS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtpXSIXBUSUT2ZRvweTyICmF42ml6PkqRZz04dn1MXA=;
 b=iL8Vpi64J0mlrw43vgrSASBV+foSNpUFl3CAoN8kxJlK73gVXWeYFQc9SltOTcjnbrOKLdxlhYaEjKkhyu/4n59We4t6wDOUQ0qpMD9JLKGXnw5H8tZeuIN7AY/HcS48yYYIQ6vMjyQ4JuK8RzPUmehGOyBmJWn/nSaMi4RPuJksx8qlSxYO2OcA6V7w5B9GTzhobHX6zF+1uhQeJ0phRUeZTvXa8feoyLyUjkouO8ZCcaEeTWT+cwycmLHdAK7e66cOlbh7hdkhQvhilQ352nL73VUlcU7oVni6mk5/TU6DqG4bkTIkVUR5mMgbASfWB/39TIBLI83n7uUTo8mrow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sun, 11 Oct
 2026 07:02:18 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 07:02:17 +0000
Date: Sun, 11 Oct 2026 09:02:13 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: idle: Respect task affinity in restricted CPU
 selection
Message-ID: <ass0dexwariQCOtC@gpd4>
References: <20261011025256.4180374-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011025256.4180374-1-sh_def@163.com>
X-ClientProxiedBy: MI1PEPF00000ADA.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4ab) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: f7799a06-e3aa-4059-0463-08df27659640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|10067099003|11063799006|56012099006|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jY1gh6GuO14X+/DBeiuHc5Bn1nhy05lwiy2+WRG5t2Ww81Cm9UYMBI74YYzh+1A0QC1A+cHefHgh8SHEgUEFj64inquyoZ9Wphc+SFngpzNDums/saN0jKzEY/Ra9fTKCthcBfNsOtsiIDGWa+c5oRM82b8tnwVKmCTk8At4wXW5lOX+zlVQyqwwxu/3DPVyELfYW6Nnwukd7W2tC/slkCb0GC58uIxGA+r7cGv60f54EufMHp6sEPmYNOGWoKv9ciTe78lvsenlSGqLdkwzg9L228XCAAykCtlvbvMvzZ3YQaNk8gHxtLPhpLhFH3pLXwkt00HH0qFEF7wScqBE44qAbSQDIJhlJYOIUCvWegdSLRT5YR+SbrdBM7ScPjzg9R7IHv9CdL3NRFFOcso4qda8Z1ipO8FYLO/T2SZ3iT2gp0v1+test0WTLybnA4DF5T3wDEWdGCsYRka9tm1TA3KIfeLuY+xNWhAmXQt2rugmc2/HUWcF+Wj+SctpLZ7QWpQxQz3KlSNNJVngwe2hdQrPIznecLqeixyHPCnYhnvOAehvp/jVcDVTiXfq5GRYyo4q7RQoypB22Ysxffxo0S7N/tsPR/sZbGUTdbe4r1KK9dMwdoNM8emNwBs361pv5cpFTES60NCvSc4YNJQEjSbFoohkQfEf30TP28CfLSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5MOwxOFAkC+Fa+TGOc+ujpSXePzsfHHO0qqTDd2h5atbVB4DpKLPp1poqT3Z?=
 =?us-ascii?Q?A10t9duMjH2krx5B2rn7tQf+iz8sgNDQSa93EcL6aQcUQHca/jYj/tuxJUHn?=
 =?us-ascii?Q?fRkbcoJbjb7dvy/BL3RN1OptopuqHc2sx6oVvS85mq1rIk0KSXylVBBX+XH2?=
 =?us-ascii?Q?H3LFpXHyPfMoKvGB0JH7U5AIetA8F1309jiDEHuT5ro53yOG7xAxiWGkodxG?=
 =?us-ascii?Q?R/2iHCOvXnpM7YWA5bjbXXJ7omjSEsFapSF1+TswZJOJUzjSMZtjUaXM4rEE?=
 =?us-ascii?Q?QEuDxTuqK5tyjfLNPGBqQnelF9DMU10w5NRvUCNYGWhA9W6MJnE+szeIjDuv?=
 =?us-ascii?Q?UyhBCyTxbeXvShvMnzRH8PEOrP2GsF1vJKJDKNJnp15nKml/Ai7N5MFE2LhB?=
 =?us-ascii?Q?+65rQIea0kdRKHDWLPNeqc76uF8k/ZYjOy75CNQIUsS0P0LuPFHlOGC2zSj5?=
 =?us-ascii?Q?itejMW+0gVzMcGT1loiHXPetTC+Ni6qadnHr8QXnNq7O3EvJqLhEWWqtnmTU?=
 =?us-ascii?Q?Vt+jsydsAyjc4Hwh7aO95qJOdcxy+mD536nrL8gaexTtfLQrpNoRpvrURonO?=
 =?us-ascii?Q?40ozrbuWzd3obHLLIDPynYYbRVM3Iy3VwqGqplNpkpzUyYJ3UDEAdRCVcgxD?=
 =?us-ascii?Q?lRUysKAiFeS8vhhkM4nqfolxSXN1bcj4w5PorvYquADUixqa5h3rrWgMY0/Z?=
 =?us-ascii?Q?mPcSAxBMXVmLKQBWnAVFwg8ouAbqy3TPDaXJvJMeUwU5QRPgCZjdyCyqgS9d?=
 =?us-ascii?Q?OBsMD2knIL6RHa4ZdmEhTakekaqiI6JuxcobNLZ0szphIekzvBFD80QDE0Eh?=
 =?us-ascii?Q?wEX3Q/wf5MFBWkIhIRt84OOJn71GgmLelUM4M46TF4qP2ue1mfnim/5dm3XK?=
 =?us-ascii?Q?FUcpEOXrwqrJZPDHnkTOp3aEmDoeiOhuWtzIR6AeNxrYf4NKFyGBNCvewj9V?=
 =?us-ascii?Q?eLzdLr3f2x0C+LogsfKrvWWHb+Da55qo5w3tcqaIKRpSgFi6XRoA+WuI+vl/?=
 =?us-ascii?Q?JbsfAeWSRvocANbwtC6+qKkR/9ZTdNuTGC/wBfoskhHvrMn5BJ9h407sznCp?=
 =?us-ascii?Q?F6cyDK0ss3hlu/ZkjpH4PXKPTPO3l43BYNSWh6oBIfBUKwbqZlrhMV7MhcJ9?=
 =?us-ascii?Q?hqdgsxbDKTKjasaSKhpo9Bwx8lLLTl8NyVSD6++f4jww6rJUjWeIGM5+Rvo4?=
 =?us-ascii?Q?0BVHrfhrwoHKapb9N2MOmBvaehrspEFPyItlBDWOyKg4UViTUhJs7JR9eduM?=
 =?us-ascii?Q?4YxILlJveX/Ai7fiuzkfAnwaelUnGDQ3Xkpm/NOfkALRtFUbc+06yLCMCvt7?=
 =?us-ascii?Q?KzZiaVW3LIWOzxfXCGj3wR4Ctv6seWoyZTgdpkqvL9zbv2GikSw1NCzgDUpi?=
 =?us-ascii?Q?twxioU9jnv8KvaMzZe0cfPgOko1BCm37hlEeeVyqiik75cEtySv5oiP1wQAw?=
 =?us-ascii?Q?UftlRx4dqkd550pB1TUioqOWTxNCOZgTRj8zbVgS28pAt3V7fcwpvlyl0xiG?=
 =?us-ascii?Q?CGuyJUy/DrVX8bke8yk1nkMIddJ8X4lvHE7VoTy2RSpr42DSGqModRuy6Or6?=
 =?us-ascii?Q?GrB+5Id7fu8SIm/kckudt5qgLFx25qs1SPrmQXKTuwLAQpLtEMGdaR/LjQmu?=
 =?us-ascii?Q?acxaZRS3uZU41s4dweBdHWUhhGfgbOuolQOvxXn+ao79+1TqElTUB8f0mOtd?=
 =?us-ascii?Q?N5ts0GH+DEFWsQzkJS7SnLONkdYSfUY2BKabSbZtsIWEt932?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7799a06-e3aa-4059-0463-08df27659640
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 07:02:17.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgNTGpPSJX+LKEFe7Q5gP8rFCNdOmQeyoj25zR8JtDBxnO2VPaSJFQa5OBQaG5kP/Hlv+UM/Ku1Yhs8bhOkU9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195

Hi Hui,

On Sun, Oct 11, 2026 at 11:52:56AM +0900, Hui Su wrote:
> The restricted select_cpu kfunc path handles single-CPU and
> migration-disabled tasks without going through scx_select_cpu_dfl().
> 
> When a caller supplies @allowed, the path currently checks prev_cpu only
> against that mask. It can therefore return an idle prev_cpu which isn't
> in p->cpus_ptr.
> 
> Require prev_cpu to belong to both p->cpus_ptr and the caller-provided
> mask before consuming its idle state.
> 
> Fixes: 683d2d0faba1 ("sched_ext: idle: Introduce scx_bpf_select_cpu_and()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>

The fix makes sense, but I'm wondering if we should derive the candidate CPU
from the task's state instead of relying on prev_cpu. In practice prev_cpu
should be always considered a hint rather than a guarantee that the task can
still run there.

Per-CPU tasks could use cpumask_first(p->cpus_ptr) and migration-disabled tasks
could use task_cpu(p) directly.

Something like this maybe:

	migration_disabled = is_bpf_migration_disabled(p);

	if (p->nr_cpus_allowed == 1 || migration_disabled) {
		if (migration_disabled)
			cpu = task_cpu(p);
		else
			cpu = cpumask_first(p->cpus_ptr);

		if ((migration_disabled &&
		    !cpumask_test_cpu(cpu, p->cpus_ptr)) ||
		    (allowed && !cpumask_test_cpu(cpu, allowed)) ||
		    !scx_idle_test_and_clear_cpu(cpu))
			cpu = -EBUSY;
	} else {
		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,
					allowed ?: p->cpus_ptr, flags);
	}

This would let us try the task's only allowed CPU after an affinity change,
instead of rejecting a stale/invalid prev_cpu.

And could you also clarify in the patch description that selecting the CPU
consumes its idle bit? Without the affinity check, we can claim an idle CPU that
the task cannot use and later dispatch validation doesn't undo that side effect.

It would also help to mention that per-CPU and migration-disabled tasks skip
ops.select_cpu(), so this affects calls from other contexts, such as
ops.enqueue(), leaving the normal ops.select_cpu() path unaffected.

What do you think?

Thanks,
-Andrea

> ---
> Testing:
> - x86_64 KVM/QEMU.
> - A private regression harness pinned the task to CPU 0 and called
>   scx_bpf_select_cpu_and() with an idle CPU 1 outside the task affinity
>   but inside the caller-provided mask.
> - On the baseline kernel, the helper returned CPU 1.
> - With this fix, the helper rejected the out-of-affinity CPU.
> - The existing allowed_cpus selftest passed with the fix.
> 
>  kernel/sched/ext/idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
> index aa9fb6de0ad6..20efa463cafa 100644
> --- a/kernel/sched/ext/idle.c
> +++ b/kernel/sched/ext/idle.c
> @@ -999,7 +999,8 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
>  	 * used CPU is idle and within the allowed cpumask.
>  	 */
>  	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
> -		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
> +		if (cpumask_test_cpu(prev_cpu, p->cpus_ptr) &&
> +		    (!allowed || cpumask_test_cpu(prev_cpu, allowed)) &&
>  		    scx_idle_test_and_clear_cpu(prev_cpu))
>  			cpu = prev_cpu;
>  		else
> 
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
> 
