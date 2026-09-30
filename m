Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50851344D92;
	Wed, 30 Sep 2026 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782036; cv=fail; b=eD7O7Q+y5sEWgvF8IWFC9fcsUbsuBPCPAKPBdtCIqPoN1zKgug7W+cxQcSLY9m1jzC4klu0TzT5TsOfdzU6ctYdptZ6t/TS2sTOG0k4f5dpk0rZnQ4UWYOqBYDtv5ZRDxwrgUC0EpUFlqcTAE27il4mXA9MgFbVPq62n6c69ImQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782036; c=relaxed/simple;
	bh=HRgxQ5P/oNrI+9/fUEDCV1YY9Brw5GYw+09kQP5evsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lJAWudX+4HxuRUMtlx8luv7wFLkKUReenIThdPHE7ZlZHYKvgRC1mP0CNM+qX15MT29Thn6V5pN4TTAtweAu5RJs6JagdS6qMUSJ66RAU7ebh2+u3e3pv+hQfscNtZUT/upEt/zmwcquSLb+QRpTEwbsRntISm+TUMmz58/jnoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hCvf3Mac; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hCvf3Mac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDF8mv5RHz1fqXW2yPT0WBB7H7383oKGQ6HOBy2obiGiz8S/RiozbnU0bzA3BM41yzxUznJs/LEkan1LPjQspxdyOV8/qvM2Aj3KNvfcnEUDKF0DrHikXGAsONIv1COjPErMc2gorRY3Hl3WfQD2asSbbKrkKntdjHSRwYeRn3KxqWA4jz3oximvt3hngNeQM9aVixPjsQdtFZ9CasPXPGuSwG1Ei4tMS1gwtPkuFUBg0fC3ikuqc4z5tarlH1avG4v7IZDIzCvTb3fuu++l99pALt+vVFou6LRKCsXyfxAtbap5KThf///lZ5uKFZLZiVxOGec6RPXecBw/t5ZsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDYricqKofY5w/Ha7m8UDA3UBDep2UzIbD1BdGQfqC0=;
 b=v0BMNJM+CBSw5KMrB9IdVejAnC3zPhhEUhOmwmDixDkTFtLf3SyYnSvKKxrGv/H4NMR8b2+GpRLjFVL7b6UHq8bmJf/6TH46xnrrucOSPPt0yk/KPFSQ4RUOuUKE9CLWUiVTYkhYwIszTUY1xKf7P1MASCbRZ2U7sRq9QeEC8LdUKa2no8xmfCBKQwqYvUsTxtQZj1V68/w7u87CoOXYUHXdE5qsKG84y8JDPW2WMvIjkbsdyhG9TThP1l+S0YSdqKEOQHVRt9CsH1jToOJh3nI3j7lTGlvVZQ04rgPw/1YT3bJh9uOJWeFnPP8Kc3h6MP+nXnQP38qT53BU9LEztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDYricqKofY5w/Ha7m8UDA3UBDep2UzIbD1BdGQfqC0=;
 b=hCvf3MacMBwLTfaAdmmeEcflSPqRLgKADhFg7MtOSULt8cf09BVp5aOPhxNO+On2uLnFU1rcqDK9KbnzP+s0HyNXIO+ayxKzpaZaCOM3OmQVfN03XiXf+/BodDRkzfTvHB035+MbdqN7erGtfq+s+cjkKrbdXKZnV69lomzjpWYnFFd3OPIzzmZUK4YAl0bVjIVkEztVkzB38BJB71dGgO7QLaPRKfqYOKczGjBMUdMtZxzlAlkqRLyTMJm++Gf9nMYLO92/vRPWW19LKdmMdMK3fEn5cpW3pjD9gt3JQhhn/tZ4V4c81vO8lV0di18dumY5h11PbxjFbeikztbBcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 15:26:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 15:26:46 +0000
Date: Wed, 30 Sep 2026 17:26:37 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Hui Su <sh_def@163.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Hold DSQ refs for deferred reenqueues
Message-ID: <ar0qLeKls0oBUEKO@gpd4>
References: <20260930143443.2862150-1-sh_def@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930143443.2862150-1-sh_def@163.com>
X-ClientProxiedBy: ZR2P278CA0025.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::15) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d89418-a027-47ae-9fca-08df1f073d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UpbS0+t3tvkyMaHjli1JeEseybyZS5unzIpBkhkFr2F6wFahkXnLVu9HGQoC4AMwv8x7VUb14VvHr7q/i5IlJdvHMvuNgM6BXg6bieJPmNC6l+EP3kxc0DQ1plnrKfz4h29UNDRebpWU0ZAx+oiASbIGZGLlvkOKxw0NJfVonmjnf3OwTLlqcEePzXYHAoSRAukn45/t0Qdzzbi5tEpN5/kTxGMVPPHFXvbUDxoPK9yjiVV7PlGqznREp5bUr1OHfSnfKGl6dU4oyU/qP8E+HlGygog5sfVInSxHC7ryXHWldYQsYXM796V2r7MIlD1FHKufJdmbVFTm9HRWF5ImxL3hEEJn2im2RkBTeu5bzRJmsn5H22ax72c+GjLThci9ZpMoBuRAoXn1QPavjEb1yFUS18mG2fYz9P4Ox22Z0YmcgGoYM+9uIeYH6zIwsgStKqm6Gj99RixADmpozQc3QwaL7IaUr1ORDl0Xe4qj1jlRoJ4k3B7Ty9GLjld0lmy4Gfa6AdA5ANclSKybCjlL6pgNM2xba2yKrk97kLiPz8kUj8tlF+c3EXNgxY5tRR+EgDaQJ9Hb6LlqvWHAgJlV1eoaXH01CmwstN2jWUOHQ534c8DzNjhlNlfGpFpRvkT0+XuGaKsotGcHlwqHbjwkXzC/bqiJXSLTOhWCw4uirek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVoZr2tuwEkRcIPWx+JgbcIfjm10F3FhOpxs6Q/5NX7Ek8NZuvtEFrZK6T/O?=
 =?us-ascii?Q?MDL/CV2tK5aNDDZgbb0GkD1VmToMdVCs5EHI19bzzPCRV8qbGt4wWrjcHvBA?=
 =?us-ascii?Q?UDnP25OAACn7tqx+odTiwqRdYUDBg4InHu0717Qml8E+hzgiKTGOoXDIe4IT?=
 =?us-ascii?Q?70n9/JsFVnLwCiChX+kcmUTKVNBf7QxIuYv34jv1JSPc18TWtAVrN0Q2m+Jo?=
 =?us-ascii?Q?k/01xK7SYoSms7mNRI7LyAgM2uTuvCT6J0tytEdN5MWqmWVaumqBPHIbvdZ3?=
 =?us-ascii?Q?GppJodiNtsGzoXtJ1m7TkhAZUF/srXDVAM4aSJY3MSW2xnOGr97xw8nMWxsI?=
 =?us-ascii?Q?tS6ELl+N01Fc4aFUjkjQPLdrN+gdF7GissVv4WIx6qIjo91byN5JSj8OO6wf?=
 =?us-ascii?Q?lc9j9eVrZbYAQ0uZ9SSm97hD8Qfip0tJppA591IiyzLDPyRn7xO/U+YGA8pf?=
 =?us-ascii?Q?ryPeXFVLv2ytGjYZuMw3NAuHZZRa6kvOxj57xkh45NfCjr5muz48qMFjqAY3?=
 =?us-ascii?Q?FxiZq3uer8+wGQj+rtIgEZJIQM0N6HUyVajCIc7bLyI6fzXx8FFVe5VInRZ6?=
 =?us-ascii?Q?u0KLQ6DXAxDm4/t1+zuG0qAXuJyd2L6uoO5FuzV7flmHWhzs8BrtgJFBgBa8?=
 =?us-ascii?Q?lNghBq5KfNWDWNjw6WVueMLG1VYd2amr3e/KDJSdX45X/D/9l3ZdA8A4GQ8a?=
 =?us-ascii?Q?PuWtTvHN53hkBsdR5y87LXl+fkGY/TwL+TJwKcdMWSkzVBTJebFKv5GXqCxY?=
 =?us-ascii?Q?HEAps2omYiGhARbrBM2K9YSZRkCMbtP3wn0SLwAdvptb5RzRMKhNWN6ehI4N?=
 =?us-ascii?Q?dJgeoZw9WOo9hMdg3YUkMPYaBKpSbZK5o3gBAPTSbjpGcvCZ7GZggPm7+aFI?=
 =?us-ascii?Q?wV6AnxjpmDzl+GPHmjQdiw3U1fExIdD3O7BZlLCgCagLcqxz/6LFpvJBa34M?=
 =?us-ascii?Q?mXgq3dl2W0M5kst5iAMrqUHPvhjlHqKL7xj6sNYJuIsPTLLG2FEDV2OFeb32?=
 =?us-ascii?Q?pIqQ5ik7RfV284T23BxEWOz8UOZRxx84/N1UlwjXMUd+rIeMaojy6jMruGa3?=
 =?us-ascii?Q?Q0eL1tT3RQ+vQxxPXE2tGaXcsJ6+CJbAkA0wxvFjgqZfyZ4NgTu/SGF6Vuk/?=
 =?us-ascii?Q?UE8wVDVnKaQq2xGhTGKOD7vsqjohbRynnyIaKlaxkbedPLJF8NTlxe4phkPz?=
 =?us-ascii?Q?NclQpKIUaCZS03xOE4NJjXoNrUbdz0omQSWQu/ucvePFimEw9HN50eWjCb+1?=
 =?us-ascii?Q?61jl9+Vn7Rk0DHY52ICberCLuTnIsOdMa/+3eeA1l3L+grs5cpO9Gcwp7W0k?=
 =?us-ascii?Q?3b9PIMiUpnk4Sw0yDNbguB1zF/LZj3uPAjq8oTErAgw+j1nh+SSzQUs/W8sa?=
 =?us-ascii?Q?MECdv1129jFtVyuoaPOdAqCQpYKwmBZ7SJX9Id9VVuzYLbjBibE/gf7Kfgn4?=
 =?us-ascii?Q?C++3i0clUxCCT7axUFR00TqYQXzKrm3y2eO47n1sGfsD1aO9p+XeQz4Lw6/9?=
 =?us-ascii?Q?ONtmIYeQ9eguak6Iv14EeG4mgqBhoAimiD0Wq9J7A6JKtEOWXdzt8hFWQJGP?=
 =?us-ascii?Q?t2gc576yvILP57468NSnJiSAylcKgTBDG0zyPuhb4LDxM8F1yMX0Osf3gels?=
 =?us-ascii?Q?bzU9HJohicGsXUrm0JKOwTO68zoCuhSIjM/QeTbuhwWj+tbUt+FERdKgmYHI?=
 =?us-ascii?Q?2hKC0ZT4l4wdDImBbrS06cmobcVTVEWSNNqb07crLNopg7qVPEbLlzyLuCCn?=
 =?us-ascii?Q?5n42B6rtoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d89418-a027-47ae-9fca-08df1f073d74
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:26:46.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yNEQafpmPxpSOtZ4mXqRp/raqWyfA0k7dhqvXbm+YKmzh2WWSfnBt2fidk1MVqEzveR/Eb3O3mC2XXvVtUVyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908

Hi Hui,

On Wed, Sep 30, 2026 at 11:34:43PM +0900, Hui Su wrote:
> A deferred user-DSQ node can be detached by
> process_deferred_reenq_users() before the DSQ RCU callback reaches
> exit_dsq(). Once detached, exit_dsq() can no longer find the node,
> while the deferred path still uses the raw DSQ pointer after dropping
> deferred_reenq_lock. The callback can therefore free the DSQ before
> the deferred path checks its ID or calls reenq_user().
> 
> An RCU grace period only delays reclamation past pre-existing RCU
> read-side critical sections. It doesn't protect a deferred reenqueue
> which has detached its node and keeps using the raw DSQ pointer
> afterwards.
> 
> Take a reference under deferred_reenq_lock before detaching the node.
> The RCU callback drops the base reference after exit_dsq(), and the
> deferred path drops its reference after its final DSQ access. This
> keeps the object alive until all detached reenqueues finish while
> preserving invalidated-DSQ behavior.
> 
> A KASAN regression test of the pre-fix kernel reported the
> use-after-free while processing the deferred reenqueue:
> 
>     BUG: KASAN: slab-use-after-free in run_deferred+0x1312/0x1710
>     Read of size 8 at addr ffff8880087009b0 by task swapper/3/0
>     Call Trace:
>      <IRQ>
>      run_deferred+0x1312/0x1710
>      ttwu_do_activate+0x29a/0x600
>      try_to_wake_up+0x815/0x1700
> 
> The patched kernel completed the same regression test without a KASAN
> report.

The race looks real, can you also share the test or the steps used to reproduce
this? That would help validate the fix and assess the stable backport.

> 
> Fixes: 84b1a0ea0b7c ("sched_ext: Implement scx_bpf_dsq_reenq() for user DSQs")
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Hui Su <sh_def@163.com>
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 23f9e178bc5a..3344cf33d324 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -13,6 +13,7 @@
>  
>  #include <linux/llist.h>
>  #include <linux/rhashtable-types.h>
> +#include <linux/refcount.h>
>  
>  enum scx_public_consts {
>  	SCX_OPS_NAME_LEN	= 128,
> @@ -92,6 +93,8 @@ struct scx_dispatch_q {
>  	struct llist_node	free_node;
>  	struct scx_sched	*sched;
>  	struct scx_dsq_pcpu __percpu *pcpu_user;
> +	/* one base ref held until deferred reclamation, plus detached consumers */
> +	refcount_t		deferred_reenq_refs;
>  	struct rcu_head		rcu;
>  };
>  
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 405d0d1038f8..1df0ff7e3b72 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -5057,6 +5057,7 @@ static void process_deferred_reenq_users(struct rq *rq)
>  			dsq_pcpu = container_of(dru, struct scx_dsq_pcpu,
>  						deferred_reenq_user);
>  			dsq = dsq_pcpu->dsq;
> +			refcount_inc(&dsq->deferred_reenq_refs);
>  			reenq_flags = dru->flags;
>  			WRITE_ONCE(dru->flags, 0);
>  			list_del_init(&dru->node);

Sashiko's ordering concern looks like a false positive to me, at least on
sched_ext/for-7.4, both this sequence and exit_dsq() list check are protected by
deferred_reenq_lock.

> @@ -5068,10 +5069,13 @@ static void process_deferred_reenq_users(struct rq *rq)
>  		/* destroy_dsq() may have raced and invalidated @dsq, nothing to reenq */
>  		dsq_id = READ_ONCE(dsq->id);
>  		if (unlikely(dsq_id == SCX_DSQ_INVALID))
> -			continue;
> +			goto put_dsq;
>  
>  		BUG_ON(dsq_id & SCX_DSQ_FLAG_BUILTIN);
>  		reenq_user(rq, dsq, reenq_flags);
> +
> +put_dsq:
> +		refcount_dec(&dsq->deferred_reenq_refs);
>  	}
>  }
>  
> @@ -5565,6 +5569,7 @@ s32 scx_init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id, struct scx_sched *sch)
>  	if (dsq_id & SCX_DSQ_FLAG_BUILTIN)
>  		return 0;
>  
> +	refcount_set(&dsq->deferred_reenq_refs, 1);
>  	dsq->pcpu_user = alloc_percpu(struct scx_dsq_pcpu);
>  	if (!dsq->pcpu_user)
>  		return -ENOMEM;
> @@ -5591,25 +5596,33 @@ static void exit_dsq(struct scx_dispatch_q *dsq)
>  		struct scx_deferred_reenq_user *dru = &pcpu->deferred_reenq_user;
>  		struct rq *rq = cpu_rq(cpu);
>  
> -		/*
> -		 * There must have been a RCU grace period since the last
> -		 * insertion and @dsq should be off the deferred list by now.
> -		 */
> -		if (WARN_ON_ONCE(!list_empty(&dru->node))) {
> -			guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
> +		guard(raw_spinlock_irqsave)(&rq->scx.deferred_reenq_lock);
> +
> +		if (WARN_ON_ONCE(!list_empty(&dru->node)))
>  			list_del_init(&dru->node);
> -		}
>  	}
>  
>  	free_percpu(dsq->pcpu_user);
>  }
>  
> +static void free_dsq_finish_rcufn(struct rcu_head *rcu)
> +{
> +	struct scx_dispatch_q *dsq = container_of(rcu, struct scx_dispatch_q, rcu);
> +
> +	if (!refcount_dec_if_one(&dsq->deferred_reenq_refs)) {
> +		call_rcu(&dsq->rcu, free_dsq_finish_rcufn);
> +		return;
> +	}

Can we avoid repeatedly queueing RCU callbacks while a detached reenqueue holds
a reference?

The callback leaves the base reference in place whenever a detached reenqueue is
active, then starts another grace period just to check the count again. A long
reenq_user() could make this repeat several times.

Could the first callback instead drop the base reference, and have whichever
side drops the final reference arrange the free? This would avoid polling
through repeated RCU callbacks.

Thanks,
-Andrea
