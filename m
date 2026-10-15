Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB33F12F0;
	Thu, 15 Oct 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083301; cv=fail; b=Qr/4OzwgDnWHd33Hae3vRmF0oNfkLdDrGdpzsLs+EYKWkgAx+hJR4Am7NWR58CgEl7dh46V2i5Sn8CfvZQTuoPIQddqDJ4EMBBwiCbr5GUqAVsvVuWSI4G24tSY8f9L6YXatNh98pD3xA7AMww/3Ew6CWS1vjrbb2gdShMZAEJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083301; c=relaxed/simple;
	bh=DWnrNw9DERVX4KfXHus7ySReiNkC2bW9ycULIFpcDqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oyoCETWFbnR96uSgQMqI7uolVyXrj82aMBfd1+Q0Fua26VnUAuCkfwQmTU75iklUZFeJhj0CxSta3uEJobn9WejZfjzxH8oI25zCBw2fbIZ09QMyOrE3LVaWGESyWdYxVh+9Soui7sss0PkNC50dLgMyrrtT6r6N36J8TN1hMQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eymh4and; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eymh4and"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x75+4RuDWSTxFrzOSXcQsgsoqCDn+JxmC11SjSw4208f//PhLKEi9Fco5MKoTKQkKQ8FdVaPUnHlN91+IoShSUh4DTyHTyUzJkBU2pujH6/vc38g6yfLhHgDN0BUPEKodh4L12H2TKKJZZDzcVVICQ4+8Nly3VjKkt0Jerbtkli9oCnhahxRnKCqesRbe0gXTi3P1o8ctYCZkTe8sQvIWhwC0m8xmcyfEgx5PuxNG+WzCekv40QCEEam0HiAwq16e3HkO1FZae8Cfxit8jA7R1SSJbg1+pusRrYnnpeTz30Dr6x4uYjzDvjLCjRFuUFggNO/7/R+bTOIgjJhePUr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWrKAmdX3Fxuh02IlAsIXcnIG9eh64BMPeVmMNjX6m0=;
 b=HnJjufEwyFWFt+UnlN7xSKJpf5FQtAuk1D01uR2F3Cq6iMR8D3Qt1BRpJPtcIjtUs6azbTeXgN0IkvWnJCxH4amujEZ98Y7jKuBgErtVh1XHaXIKMtGN9hKxtZri1XiCCvSk+zc0A1JKg+HB5Xya6mEi2S/+173BRE29B0eycgRYKuXv/muDNiKuhqUg9gjJ2zxSsTeTeKaDYk1An9l1H67su5szQa6AoLQ+cbQko6ZgXHtIoiB/IIt3I2Ehe9aMiw/MkyRPb70hiZD4qZ7YPp8IzeBn/DKJNVUHFk18cLWRm52gtMks4GQ3ihfGYmlgjoMwqfcA0FUPDu872LfEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWrKAmdX3Fxuh02IlAsIXcnIG9eh64BMPeVmMNjX6m0=;
 b=Eymh4andvRE1N/Je/yIzzYO4keIq6WganqHT1jed14SZwYEoCTu4hWqH06Vja3N4xy9wORyDSz5JyidKfDf+b4rCWPlLQ8ouALoZ3rP2ZNDwMhMXyHTQEofcKtqwDJfkJTsilm7bMibWzx/jY79PEdj38d3czhLpkkl3zU9Ny/Ldj4/ksXnwLC5fhHvgH0YMgSgKHn+AoDD+TbxjdHLQSPXkCyIl8wOhbGgUQCp1nvhOo5FgEjWUqPuulVvfYHLmZkViXLud5YVB0Q6HAIwhv8eyMD60QC0WJzKEoQWcrPUbOqhoyOZ7cGeVtrTWKPAmg7SkyZrjkmnh07HR/RwPpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA3PR12MB706199.namprd12.prod.outlook.com (2603:10b6:806:53c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 16:54:41 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 16:54:40 +0000
Date: Thu, 15 Oct 2026 18:54:34 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Binbin Deng <18983559317@163.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] sched_ext: finish scheduler init before publishing
 ops priv
Message-ID: <atEFSsTO9eT_O9ql@gpd4>
References: <20261015081431.46628-1-18983559317@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015081431.46628-1-18983559317@163.com>
X-ClientProxiedBy: MI1PEPF000008CE.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42a) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA3PR12MB706199:EE_
X-MS-Office365-Filtering-Correlation-Id: cae58b51-2dd1-4d76-ba7d-08df2add0131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|260925021311599003|10067099003|22082099003|18002099003|6133799003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info:
	GN8wZo31Tvc8xpLVZUiyBz86bm5kWQcn95BQMkrWHx2p4UNaySDvszlobyd41xcc/ZkljwetYIPYUqNxyKaKz2W0Ubx12eHC/lilryVZiVk1oFSOGq/qGz2EKd5xKgsPFGAxE+uGy2QCn8db16Lyj3CSJHqYC/pW23Ea575NgQ87VP6WHkOzgdX5UHZL70MzC/jVPUdrMjDwcqRN+uV0xCPa7PPO/ioF8E3Uu5NqiOu2FY4yWc57V62xtRTuR+WEgQT8GrvqQuxohVwKLirSp+ZEI275ZpaELGR3sDFf/RsyQBhAC+w6jEICGDW8rHahwCiMf76qerg/+iCP5UYykHzP7QJTGUiRpacA3x2KCgFYrrQN/+jCkS0lrUb6ixm3nAJBL9PCweMFU7kQ3zJcUne6V8YB/ZPkM9DJiALy4eQduRoV9umYm11yl8RMR7+MWzKbB9xlig6ZYLq/Ivs1ZEt3kP40ESF/G6MTW658obrqa3k5pV0YPBIU5MmHk8JbBnklRty80UdPUZtI0rw6a1jdfaqCrAhchbvOHS0F9DiIUYcCmY6Se3vMS8h0l/fS58LUs6tzXK4EkTjzdf4mP4Q1PAqGZ1LR2dnGcF+zpJjMZyUpsB7nG2uE0fpNaQov6Wk4/0c5PP19HhCRbEreNlIYOWIi8aparqCgO/jBMRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(260925021311599003)(10067099003)(22082099003)(18002099003)(6133799003)(260925021911599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rl/DcXOMsZhkOA+vPDYn/gYuwC7ueeBsCDz+BhBpYvGBHiGW/wNC32ujCE6i?=
 =?us-ascii?Q?MKeT6+wdqSHOG5F+6h80gd4rjFIOYCYfIIft/oSbsmiMfrgIpk6V0nm+nI+W?=
 =?us-ascii?Q?1qSC/qLQqSXOFisom+5kJg7bPB+FiBymo6eYL7105EZfvHlRFURFiumQw/Tz?=
 =?us-ascii?Q?6mVezw4clPnEayZ7hHB2K8oGicUtAEBz5mssXtoMSlZ3paSoB58EdY+RvfAi?=
 =?us-ascii?Q?T/le0AEQywGJbzHum3ejc5K/vFLJSRTGbvWPXMD+SEZOG2jyZRjtQQTPxQjB?=
 =?us-ascii?Q?A9nhWP7HNp+geB3U35wWy3dwoqFSXE1pWk1OreCcTRT7VdbNDORPs2Ix8VTt?=
 =?us-ascii?Q?dMxf2D7dJPtsLb7bDHpEv1z7KJHzLrjOhjiTTvRquk5Lpx9viZdzJlsSIQF9?=
 =?us-ascii?Q?X0WfTfF13ZQf4Q1qkw4iPxZUfm6GIWIQaxv3B1NdljlD0GhBdbqXup79gsxB?=
 =?us-ascii?Q?9GDyZwnWhrVzdkZnIFGR8lzaOnF8wpu02NYOJIT19CXmFdrwElAAkrtkoPUH?=
 =?us-ascii?Q?61KswcPSPz06kxrbAj1kbWGGzNdfKePOdc4F7h5r572vKD1URXAce/dhrgdk?=
 =?us-ascii?Q?UlIYuuIKKDIENnONn5ws3hHCt/7bLLEQJyrNGCJ+Dg09YfG6nDuYZETiWAHG?=
 =?us-ascii?Q?XNiJ/Mxnm5j1RSdh3wM2EzgxuV/O00v39ee4KqbeRhLkhChWbIudIXK4X+k+?=
 =?us-ascii?Q?zgT4Csh3Ddc6uEyonMH7R5FvWBS3yZMt0SaqsNi3yodkEmIFm4sOfWFs2H5V?=
 =?us-ascii?Q?UNsmSzc1aT5dWYaS3Sz7EIYiHvyuktc+fWDCYus08F1YITTXIwO8WvvllkED?=
 =?us-ascii?Q?xDZd1nLn1kT4oGj0r4U2LgyL629MPUfJ/C+Edqx5302yLdADZ4Inv2PghbLU?=
 =?us-ascii?Q?AzUC3fgX3Z1ZznxQ1CbbgHiV8ZQ8aOuMK8D/CgV8VLJTYxdYD8ST5JrOvtUR?=
 =?us-ascii?Q?CZrhddlcwA799paNbGPozOow7MFtSChlYcd2zVkj0BHYHAB5+1iErX3R7Kc6?=
 =?us-ascii?Q?mtMW/mfQJXRS19m7Qw5XEqfgao5H/Ogd/FPc8LSBZhSEwycKipusAfL+PmQi?=
 =?us-ascii?Q?FLetmOPw4dQqU7EVCWgnpj1j4ecVdv3JZtKY8DZ3F65QyGRBIzWv0qnbMDWE?=
 =?us-ascii?Q?OtFGScIneayyH/iX1yIqPY1izLqzu2JwKkAUbFPC0LhVEI7bNFKJ3qn3RT3H?=
 =?us-ascii?Q?47d4otcVu/Bugft+jlnisXnQNXwq6SSiofH9N9QTsq1fENQklkzjpuhN5c1O?=
 =?us-ascii?Q?TpCwOZmHEtJ7ZltUCLjWaFZ2wokl+4rwTYUPi4T9co60xhf+N3XpSKfb5M61?=
 =?us-ascii?Q?5UE2fYIMT0HeNuZXXy4Ph6GgRWzjtfzAIr94EFSsLuA1h8mMvDGQJ+qvhRO5?=
 =?us-ascii?Q?H7L8X2p/4BZiyQPbzyl8rPTpfQi2jxyFeCPmBuB8ZiS/GYftb2pzHlf23dGq?=
 =?us-ascii?Q?UhHhln6hSQBqO0xFDLX2USJnV1qzBaCgiJmt1N3QAXStt6AGDzcme7LpTy4/?=
 =?us-ascii?Q?aJ/Bkwqtx7XdVJHwsnDvWgJkKR/u7anvT5w+Fsfeul46g59NUlsadopuh2P5?=
 =?us-ascii?Q?pYWO97yf3QHXcGvN1JMtjrMx/TwmhPrNhAAqMR+QYEFm3PXGG+ah8nu/sdjy?=
 =?us-ascii?Q?JHNpTVYeJDNKINpeGNDH6GzgGVgrtOzlA4pprJxSmoT0JXp4VdA5bN8uqIr5?=
 =?us-ascii?Q?wo7x7QdnaGo9L+l81OtWZ90FIU8S7hMD0AADOWa7QZaWFWi4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae58b51-2dd1-4d76-ba7d-08df2add0131
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 16:54:40.7899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RamNeN6sQyggdYIkbehhsGS98N57kzB4xTNq4APHRGw9NdvTHtxucc0OLoHsLUM7wBequqywxkvblwpDYM02AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB706199

Hi Binbin,

On Thu, Oct 15, 2026 at 04:14:31PM +0800, Binbin Deng wrote:
> scx_alloc_and_add_sched() assigns ops->priv before initializing the
> scheduler's kobject, list linkage, and sub-scheduler kset, and before
> consuming the BPF arena reference.  BPF kfuncs resolve the scheduler with
> scx_prog_sched(), whose readers dereference ops->priv under RCU.  Once the
> pointer is published, a program can therefore use fields that the creation
> path has not initialized yet.
> 
> Attach a sched_ext struct_ops program that reaches one of those kfuncs
> while registration is still completing.  Delay publication until after all
> failure-prone initialization and arena setup have succeeded and
> cmd->arena_map has been transferred to the scheduler.
> 
> Found during a static-analysis-assisted audit: candidate sites were
> surfaced by a Coccinelle rule, and the reader/writer paths were
> confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
> not observed at runtime; it is identified by code inspection only.

I don't see any kfunc that can run in this window and access a field that is
still uninitialized. In particular, the sub-scheduler kset is created later,
after either publication point. I also don't see a fallible operation between
the old and new publication points. What failure does this change prevent?

Please always provide a reproducer or a clear, concrete code path to the
reported failure before sending a fix.

Thanks,
-Andrea

> 
> Fixes: 105dcd005be2 ("sched_ext: Introduce scx_prog_sched()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Binbin Deng <18983559317@163.com>
> ---
>  kernel/sched/ext/ext.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 3219f0da0fe4..bd79bb692cb9 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -7305,13 +7305,6 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  	INIT_LIST_HEAD(&sch->sibling);
>  #endif	/* CONFIG_EXT_SUB_SCHED */
>  
> -	/*
> -	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
> -	 * paths after this point must free @sch through kobject_put() whose
> -	 * release path defers the actual freeing by an RCU grace period.
> -	 */
> -	rcu_assign_pointer(ops->priv, sch);
> -
>  	sch->kobj.kset = scx_kset;
>  	INIT_LIST_HEAD(&sch->all);
>  
> @@ -7345,6 +7338,14 @@ struct scx_sched *scx_alloc_and_add_sched(struct scx_enable_cmd *cmd,
>  		sch->arena_kern_base = bpf_arena_map_kern_vm_start(sch->arena_map);
>  #endif
>  	cmd->arena_map = NULL;
> +
> +	/*
> +	 * Publishing makes @sch visible to scx_prog_sched() readers. Failure
> +	 * paths after this point must free @sch through kobject_put() whose
> +	 * release path defers the actual freeing by an RCU grace period.
> +	 */
> +	rcu_assign_pointer(ops->priv, sch);
> +
>  	return sch;
>  
>  #ifdef CONFIG_EXT_SUB_SCHED
> -- 
> 2.43.0
> 
