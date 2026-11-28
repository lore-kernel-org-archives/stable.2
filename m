Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861555;
	b=zSm4vbCvqZXcPC4VPfRuRoOw3dUWga2y6j6yUJZflihpPX+J8JtiYEq8+gX7eflxtNvI
	 MmkaNCHtxFGjupWV+Znfkh98+kKKI253c4cNw4mKi3uJUF/uJS7ERV9/YFAtzZWBv6k73
	 AP/OoTrVnnT/Ow5JL6nnz5lc5x+P+Z5k0G09oMdegn5qMl/GbNjTs0sAKdamHJ1bfbxJG
	 hXtTW7B+w7+9ec6cWVsNlpfNqdxJJzD2qj86WpCsTVI7ZNviI7hBiwDl9NM2RA8vEBM6s
	 fcsT2RNVlj2h5X4MjshHPMwDslwfB714GY8lL/TbeQwGCJJ3Khz+5Iz9aJoky/EeNmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861555;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9mCNGqZdp86gHKHrzXIWvj/7EqnxGW3epDEMlNADVIQ=;
	b=c8jVDqldgdMPkBNx/w8fuEGpBJCb8PzAik88wc50dW+xUS2JIU3PeQa+Fb8D0+B1alq9
	 ErIbLc3YIEh86N0BEo4a1pqdszuwYwBvD4u5463Q3y6Ee2g7e/S7dwMnhhXb+HDM/lK4h
	 sODEKSSw+2Rqq3jkeQ6wlBTK0ekYvWaLuqxeHonmr3v1mWwkFSXu9a5/m+PR5YoleXC6b
	 Egw9kx/sLfPIt8L8UJMpicLHJYCghJBQDnCtcmrGGn1Ua5du+dxFpK1bUd6CQe0CfXzsn
	 BnlP8fDccvqzBL8YqHO7R8r7GMsXNiTDMHp9KSnwBZ1kty5vChcR9l7hTAVvIVIqeYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZEhyqs8i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.28
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2422E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZEhyqs8i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHLVFBRd4l34pKsE8IFZhOJinxMhHjCj4XgxhnGbey6XcLCdj+pN9LaCoZKQpdD7V0bVWI+c7Wy0gV6t74+UpGiOlSEV5Nf2chHZv650AHh+vP6SuVRfPB8K1Fjoq4bHVnqM8FTiFlhKzQEr9Z+wByFeEFAeEnhAstdjDfMzfXOEvblfmskZJNeuF8qw1EvnomnBxLPpxRms2IfOHj08yXxKarl1r88kClwEoTmYxZt6NloLW6898DDYELzkDv+53kbvj5JI+eqvgj38/a/VF2S3EZFi3WuQPNklbGwuZDS04T+2EVOHxbBL7ohy/nSOJ0WmwFylGTBRhNHcgDWVaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mCNGqZdp86gHKHrzXIWvj/7EqnxGW3epDEMlNADVIQ=;
 b=Yhk+Q6yWIn9PEK2uCVIBnMtDRtPbw8V6vFAjqQP1RYU8GzLso9d4BIaLvvDVmModKqQJn9eOajJRvvJvpI5QhDN7k9Ms+dAMV66P1PXTX4mnArAaicDRUoU49RnDbKXtznHqsCAJvBK+zyLlpJkhk8JQiup+Bd1qSwD0UzpNbLajMwfCTPw2aZOJZ7GGoYSp861CymLQL+7uTd8k3+lWmRUjjUQ1wP3SaNmHbijfEM1NKaFxA1yRaEBUU7aPutksSx0VwNjs4sCyp86FufMxx3lyg4scMC6gjv2SvajsXX5BqOBQJZOrsOztiKb0qvvaqRrzX1gFda8Q9YiT0SVQRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mCNGqZdp86gHKHrzXIWvj/7EqnxGW3epDEMlNADVIQ=;
 b=ZEhyqs8ipQPO6hRN9LmfxPl3gmlK9fRV4fHteMX1xQk88v1eTAo+OvJNl/Ac2XABEQIzacTz83fifVEeqyH28MAAdkz2ZnYWSvQSTOL/ic+D4okqJkgJQWoTs4Zf7gX9y6OZ/zPs/0jjc784LmUIQsQz7LlZ7YUlN/WoKOQ/cbd/KYwSXdAxfSCcVQ7Fi7SnSBoFjHQ43UfL8+ADLpZd1bqAdLbpVHFJNq2PEcW9g0CHNpLO/sZLNBwl7rwrMa4gEsD8EdQIzB+ZEB4vBOUjqV6Kvr+Xxwwse64oKYqd1i11nLYlu6Tu1htSFNG7OFZ7Pi5AfqABiGYZKAu7pK6OOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:25:52 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:25:52 +0000
From: Andrea Righi <arighi@nvidia.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kuba Piecuch <jpiecuch@google.com>,
	fangqiurong <fangqiurong@kylinos.cn>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	sched-ext@lists.linux.dev
Subject: [PATCH 7.1.y 1/8] sched_ext: Check remote rq eligibility under task's rq lock
Date: Sat, 28 Nov 2026 11:23:44 +0100
Message-ID: <20261128102535.655465-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::32) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: ab03c657-6c9d-45dd-ee45-08df4d39fa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|6133799003|261009223027099003|18002099003|22082099003|7136999003|3023799007|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	u1ArPIM6dejdpfxcK2TtIf7zI+7AO5C1GYuKr36NVOOoDAUpBFcXQrEPWyyLfoYG7Q607klpPCf+exy+lKlZy2Ze4fo0EU75L22L9Bjq3k0COANN5hAwdzM2lrCv5y4FjKJl9ODhXRkDeX4N6/FPLtAIcGLkpeGhmNeka6VRKHmlMYpwYzVzCI3u2CpNh1ZkXqcpbp9s8evfipgM0+7CcXrYX0RqwfLmefvGfMO+hqdAQaHJTfzowWySugVUkWwx+0pvx3Sa03XnwByskgeGBPw054STiwPMW+VZZka6xQuiMeBAn7rK5VvyejJB4ePW/wUgnrXQUvu5NEw/1EmpQsJ0lyOfDmrlrPeNQQ0UbmpvhtWbDuD4qjSIcTL6lf9icVIxsI6QAryFj5DScMFErfTcc72etZZ/2XVHIy/xQpDN7APlj1CzQXj+19vhcrJlJXBdqN4ZHBV5EpsB9xxipBmGwOrnDTnpSrVKMFCoe5B1NoM2BHfdlfRrJcvD0BFikLag0Wi6bHlMPwwAL531Bi9vihuYiH5kfXIui8YgOscM3cqXIqxQ/bTSKupZRB++vLg7qxU6CZ2XfNXZjDsF9nU6vrT9ARk0cY12Vj0aefb1qVVRUsHq5zEVutsSA9fo8f8qketP7gkm2CdZaUULIJNAlztiAn1xhZvNyDIi+vs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(7136999003)(3023799007)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pg9Gx4bcwFtX+RNbKZR86a2O2fbdMBLcBwhG1UsH0meaOHtlqKz/JQd9y4a9?=
 =?us-ascii?Q?osLMhwH9e3fSf0ISgMy2lmZcvc7x+tJWQZpDXJ/sWxasiehVufM4lXyfG4P+?=
 =?us-ascii?Q?h08ZhvSEZGTzS2jVCB7cusJILSN76HG11QKgQcVKFEKj8l1lxYfsopnoa/mJ?=
 =?us-ascii?Q?pdNcaP0UcqfUPPbs9pF8iAnwZa94d8stxklC35kp7nWhIWFnmxOdroIsTUIX?=
 =?us-ascii?Q?+c9UYa9Wktzt+pMl7B0Ig8aIDwUfbKuIqqJYn+8kcU3LcTqTG4USaxyweFTm?=
 =?us-ascii?Q?+qt0l4hW5B+5Sns7txr/UvAGU22N188Ptl+OGGgmRCJbqrWXbRaDfaPG9vZ/?=
 =?us-ascii?Q?+kcY2H2BeWJMhuYkzLDNQ4BuI162W/PfMuI6XwH7JfgyPWnQvqsWID9oAM/t?=
 =?us-ascii?Q?bRszgS3oXfTFTV1p7TUfAhPl64rXei6VvUY4cGctVwp4YRQl5+gdMRYSprUD?=
 =?us-ascii?Q?kVinZ5gqg0R5BHyuQGPHBwLQbYuUhZ8/zPH+IQbOszMZ8X69WXoUt6sAkEal?=
 =?us-ascii?Q?g2fP3Tir4z5VfhMrQDpgRK47Q4H0QgUos0CckWWMcO0lryQGTkUOCtnALSPl?=
 =?us-ascii?Q?s1+gnSxA7DoBIUtbmXXyBIcDX8dLq8Z0+9lGIBYqT+snOKBIXE2EKLVLs3O9?=
 =?us-ascii?Q?fqL9yYMqD5iFsZ9FDTK+PG/qlnrUg7dFuMwnkODcurkeMOwELVmEvdOvKUv3?=
 =?us-ascii?Q?OPQKRHju1KlM/IxCEqlP0idQKWbFclQPfalnVOcmKpcRMKleWcmJLYk0zAyp?=
 =?us-ascii?Q?35TiCKnUWZpTu65+85gLX2b/2snYeCLQchACkriDyyUU6ydbDD2grCRMdsbS?=
 =?us-ascii?Q?JlfSweqrCzVTi1jtWOGRdbSurUJ7QlExT2PCNaBwh+7PiyeR0pSIb9HD4BTr?=
 =?us-ascii?Q?hHVZ9L1tj3PM+52BNncWxIbL12Cj1tqcqLkUc81aDuH+Tv3z207Dg13WphHM?=
 =?us-ascii?Q?w2GK/9j2iY+yBadY1TCu/uHKAVMYQKs7oYtyV3J9uPzRyoy1p6zA5u04/OJ1?=
 =?us-ascii?Q?u69T8C/bGyhABwybBiDAnl9bp6g7crZKvcfzbMoWReB7b7xIMw3CS1rh/mUE?=
 =?us-ascii?Q?scvx/ojlcxeoxrLnHvVPQgPcFoNRca5tVCj7/u9qN4fRFNL/P2DBvkctR8Is?=
 =?us-ascii?Q?KI2eMpgNmnm+e4QNSIQa9HRUX4y50zYvPvGUx1KhUORHxKS8hi873k/wVghz?=
 =?us-ascii?Q?qFq/ZUI2bWnEEt+IOWWXhG59063A7ec66XNQ13TQ2fqao21DrHiGDVPWW8TZ?=
 =?us-ascii?Q?4DLzkNus7GvOlonxHoY/xzhgiHh8MnukuIp1EsvKTHDjTniX82V3DWv7i/IZ?=
 =?us-ascii?Q?OWA386M3VfAX3i1MEgojK1TZAEqvKLP0JM+MmGhtNIY91zxXKuPYCPIdJJbG?=
 =?us-ascii?Q?Ufty/gZZ3n0bI/h3e5r9lkVT9jxbfWGeoN24UXdi8Bn5JD4jUpHf5zJHTy9n?=
 =?us-ascii?Q?FRqglYLA1mLcF44N7mvdQPdATrgkDU8AuuWgxMff9hJvooQ7S/LTKXA9BwR8?=
 =?us-ascii?Q?YNRb5+RNvE4sGJVVMAJE0KyMYfz1j7reBxZXDE2s/qUZeGQbJbbPsSqxt/Yb?=
 =?us-ascii?Q?YyaRtPXGTJ2JUyZQmro61FDrjsXArWF4GU3ASrZRoJKTq+ThGpHb1cBvxTCY?=
 =?us-ascii?Q?/mFlbDOLm94x7AW932qqQEb9sqpPtcUCD3ir2Paq1QMGTCQXQzhzklPEHI2K?=
 =?us-ascii?Q?lLRDZJ7n7nesXEPrqI1qW5MJEn6svAypHJttji2Qi3csdpbQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab03c657-6c9d-45dd-ee45-08df4d39fa82
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:25:52.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkoG1Jh+GALbs8kV57XoqXD+Hc/DHBMH7RWAxMnzwC1OEF8bNY9NB2TRT7/OBY5pI1/WnKSQvYHuTTrJNMIcng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Kuba Piecuch <jpiecuch@google.com>

commit 5c94a3ab6ed94ff1257631a49893a535098be0b6 upstream.

task_can_run_on_remote_rq() operates under the assumption that
p->migration_disabled is stable, i.e. if the kernel observed
is_migration_disabled(p) == true, then the BPF scheduler must have also
been able to see this when dispatching the task, and it's the BPF
scheduler's fault that it tried to dispatch a task with migration
disabled to a CPU other than the task's current CPU.

This assumption does not always hold. It's possible that the BPF
scheduler saw is_migration_disabled(p) == false, while the kernel
observes is_migration_disabled(p) == true in dispatch_to_local_dsq()
-> task_can_run_on_remote_rq().

The crucial thing here is that with CONFIG_PREEMPT_RCU, migration is
disabled while a task is executing a BPF program. So, if there's a
situation where the BPF scheduler checks a task while it's not executing
a BPF program, while the kernel checks it while it is executing one,
the BPF scheduler will be killed through no fault of its own.

Consider the following scenario:

1. SCX task @p is executing on CPU A and CPU A gets preempted by a
   higher-priority scheduling class. On entry to __schedule(),
   p->migration_disabled == 0.

2. In put_prev_task_scx() @p is enqueued on the BPF scheduler's internal
   data structures, making it available for other CPUs to dispatch.

3. CPU B enters ops.dispatch(), pops @p from the BPF scheduler's data
   structures, checks is_migration_disabled(p) which returns false,
   and dispatches @p to CPU B's local DSQ.

4. On CPU A, @p hasn't been switched out yet. Execution reaches
   trace_sched_switch() which enters a BPF program, as the BPF scheduler
   hooks into the sched_switch tracepoint to detect idle->fair
   transitions. On entry into the BPF program, @p disables migration.

5. CPU B enters finish_dispatch() -> dispatch_to_local_dsq() ->
   task_can_run_on_remote_rq() which observes
   is_migration_disabled(p) == true, triggering scx_error().
   This all happens while holding CPU B's rq lock, so it's not
   synchronized with @p switching out.

This patch fixes this by moving the call to task_can_run_on_remote_rq()
after @p's rq lock is acquired in dispatch_to_local_dsq(). This way, we
synchronize with @p switching out, since @p holds its rq lock all
the way until it's switched out. Thus, any BPF programs that are called
between put_prev_task_scx() and the end of the context switch are
guaranteed to have finished and cannot influence p->migration_disabled.

Also add a lockdep assertion in task_can_run_on_remote_rq() which
ensures the task rq lock is held if enforce == true.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Apply to the unsplit ext.c and ext_internal.h paths.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c          | 24 ++++++++++++++++--------
 kernel/sched/ext_internal.h | 23 +++++++++++++----------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d46662365a69e..46b15bfa92548 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2306,6 +2306,7 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
  *   no to the BPF scheduler initiated migrations while offline.
  *
  * The caller must ensure that @p and @rq are on different CPUs.
+ * If enforce == true, caller must hold @p's rq lock.
  */
 static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 				      struct task_struct *p, struct rq *rq,
@@ -2313,6 +2314,14 @@ static bool task_can_run_on_remote_rq(struct scx_sched *sch,
 {
 	s32 cpu = cpu_of(rq);
 
+	/*
+	 * To prevent races with @p still running on its old CPU while switching
+	 * out, make sure we're holding @p's rq lock so as not to risk
+	 * erroneously killing the BPF scheduler.
+	 */
+	if (enforce)
+		lockdep_assert_rq_held(task_rq(p));
+
 	WARN_ON_ONCE(task_cpu(p) == cpu);
 
 	/*
@@ -2580,13 +2589,6 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		return;
 	}
 
-	if (src_rq != dst_rq &&
-	    unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
-		dispatch_enqueue(sch, rq, find_global_dsq(sch, task_cpu(p)), p,
-				 enq_flags | SCX_ENQ_CLEAR_OPSS | SCX_ENQ_GDSQ_FALLBACK);
-		return;
-	}
-
 	/*
 	 * @p is on a possibly remote @src_rq which we need to lock to move the
 	 * task. If dequeue is in progress, it'd be locking @src_rq and waiting
@@ -2612,6 +2614,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 	/* task_rq couldn't have changed if we're still the holding cpu */
 	if (likely(p->scx.holding_cpu == raw_smp_processor_id()) &&
 	    !WARN_ON_ONCE(src_rq != task_rq(p))) {
+		bool fallback = false;
 		/*
 		 * If @p is staying on the same rq, there's no need to go
 		 * through the full deactivate/activate cycle. Optimize by
@@ -2621,6 +2624,11 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 			p->scx.holding_cpu = -1;
 			dispatch_enqueue(sch, dst_rq, &dst_rq->scx.local_dsq, p,
 					 enq_flags);
+		} else if (unlikely(!task_can_run_on_remote_rq(sch, p, dst_rq, true))) {
+			p->scx.holding_cpu = -1;
+			fallback = true;
+			dispatch_enqueue(sch, src_rq, find_global_dsq(sch, task_cpu(p)),
+					 p, enq_flags | SCX_ENQ_GDSQ_FALLBACK);
 		} else {
 			move_remote_task_to_local_dsq(p, enq_flags,
 						      src_rq, dst_rq);
@@ -2629,7 +2637,7 @@ static void dispatch_to_local_dsq(struct scx_sched *sch, struct rq *rq,
 		}
 
 		/* if the destination CPU is idle, wake it up */
-		if (sched_class_above(p->sched_class, dst_rq->curr->sched_class))
+		if (!fallback && sched_class_above(p->sched_class, dst_rq->curr->sched_class))
 			resched_curr(dst_rq);
 	}
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 6d57f1d0b86f9..dad9a084945f0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1315,21 +1315,24 @@ static const char *scx_enable_state_str[] = {
  * The sched_ext core uses a "lock dancing" protocol coordinated by
  * p->scx.holding_cpu. When moving a task to a different rq:
  *
- *   1. Verify task can be moved (CPU affinity, migration_disabled, etc.)
- *   2. Set p->scx.holding_cpu to the current CPU
- *   3. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
+ *   1. Set p->scx.holding_cpu to the current CPU
+ *   2. Set task state to %SCX_OPSS_NONE; dequeue waits while DISPATCHING
  *      is set, so clearing DISPATCHING first prevents the circular wait
  *      (safe to lock the rq we need)
- *   4. Unlock the current CPU's rq
- *   5. Lock src_rq (where the task currently lives)
- *   6. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
+ *   3. Unlock the current CPU's rq
+ *   4. Lock src_rq (where the task currently lives)
+ *   5. Verify p->scx.holding_cpu == current CPU, if not, dequeue won the
  *      race (dequeue clears holding_cpu to -1 when it takes the task), in
  *      this case migration is aborted
- *   7. If src_rq == dst_rq: clear holding_cpu and enqueue directly
+ *   6. If src_rq == dst_rq: clear holding_cpu and enqueue directly
  *      into dst_rq's local DSQ (no lock swap needed)
- *   8. Otherwise: call move_remote_task_to_local_dsq(), which releases
- *      src_rq, locks dst_rq, and performs the deactivate/activate
- *      migration cycle (dst_rq is held on return)
+ *   7. Otherwise, verify under src_rq lock that the task can be moved to dst_rq
+ *      (CPU affinity, migration_disabled, etc.). If not, clear holding_cpu,
+ *      leave the task on src_rq, and enqueue it on the fallback DSQ.
+ *   8. Otherwise (i.e. if the task can be moved to dst_rq), call
+ *      move_remote_task_to_local_dsq(), which releases src_rq, locks dst_rq,
+ *      and performs the deactivate/activate migration cycle
+ *      (dst_rq is held on return)
  *   9. Unlock dst_rq and re-lock the current CPU's rq to restore
  *      the lock state expected by the caller
  *
-- 
2.56.1

