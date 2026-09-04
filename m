Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9E218EBA;
	Fri,  4 Sep 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512430; cv=fail; b=cvGjCOQwLUELlPViH4+bTjzuYwGrM8JHGQTOSqLuOROloDnJKSWEx6ByNxSZELBp2GmlKnyXaJup672Zx+9B+duRTm0hwjl3UFCpM7xDE9WZyoP5G75FbE0VrUa2sahiOWJhhBY1lnISe+iuvp2t3YKT7dkT3v8VcyLccZpI+3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512430; c=relaxed/simple;
	bh=G5osn+HBWeWWfnTYnOBjxLJHm15MClC8ELV4A5T6BWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IjqjY9PwS8Qcb6c+bH5CQeT52c2K0W76DcQNE4iwo+CeG8+Yn6nBPX7sSQKQrhRT0TgzB9hXn6eQcn3Uo9TVeDb+o8EQXD67SCoqaIoUfKkLJPrlAJwErrtyA1kcKY2XW3wTzSrIYNadvJCLHdgVqLRLDYrKM2PjgPZUzle31d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OfwBFceu; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OfwBFceu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgojM0X80tRYBReIDZqGgIOBQqDiG/0KmTquNjNKBQPodWRkNTwhyM5AVuD52wEbJKnTT7z1IjWvZquPR8BwnC7+bgNWViHp0L633i8n5mq3vpvLj7EHVgKuCVlI+m6Cr5pNKAnwJ2GNmqHg0ym1Jz6KamZJuVpFW0VjNaCa/NRCbPkOvNp1B+lnT4DbiZkZnZBBgCHwsf1OzfBFklSrcsT2OxEn5a/rdJr66GZDuJjrey5eAvYPr3brlcflBu8CYH1JOT6NVg5kk3OJjV0CtmywlomUsZ0NQIPYaMOHK+64giDFzqoXGwMJBSEwbiQSUSQMMWhSLmVY8Uc8QjHQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2ufG7FI0vsA2W1kWJB9nFVnMF1wr1ctXXic80cFCPk=;
 b=uZ+2eC7vMW9OCH1uKNdj/QrksvZn5gexbE+NX+Ha+8awjaKX6/XST2mmM+quwQsYmmd0U8bq4D/TPdcs4NZxOHLKmTl+ezIyHTfKtfprlH7MkDEjqoT2r5VPuzUKNgglweEN9nrb/6LLZ5ktikJTXgkwE/WQUMfJYnM9Q7wEogqjjMHitEQ6YGeJEaSuzLzGTh2SLT0XV7rUUHpNVIIlLi1GFE4GJEWEZ2dwqyN3V/XtXdUSltHCqk4WxqaYs8lop+pPpzdTFGSgnnEHsRAP3sue3kNnXopxn0ukh6yGwej5bE+1hv2pTnehGMfsMtkz1WQDmLM+G3WazgIPICGB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2ufG7FI0vsA2W1kWJB9nFVnMF1wr1ctXXic80cFCPk=;
 b=OfwBFceueR8hb51c07K4WwbuucavUn9vegPzTHiYlrSwdW+gLRpSxFT/hiCI/5lpQa9ENDK2E2FvZ7Z05/9Be2GRpcV6V10AxK2CEuKK2/kJVIOdn/1Ue65Z8R4lykEW7MwyFJ2PpP+VwKnfbyTfoWZe9a5Wgqgz/9bIrJmNN1A=
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Fri, 4 Sep
 2026 09:00:22 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::a1) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.5 via Frontend Transport; Fri, 4
 Sep 2026 09:00:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 09:00:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 4 Sep
 2026 04:00:16 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Fri, 4 Sep 2026 04:00:08 -0500
Message-ID: <80432e77-2a51-43d8-82c6-5eff909f779b@amd.com>
Date: Fri, 4 Sep 2026 14:30:07 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Are these issues PREEMPT_RT-specific?
To: Ran Hongyun <ranhongyun1@huawei.com>, <namcao@linutronix.de>
CC: <axboe@kernel.dk>, <bigeasy@linutronix.de>, <brauner@kernel.org>,
	<clrkwllms@kernel.org>, <frederic@kernel.org>, <jack@suse.cz>,
	<jdamato@fastly.com>, <john.ogness@linutronix.de>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-rt-users@vger.kernel.org>,
	<mkarsten@uwaterloo.ca>, <rostedt@goodmis.org>, <stable@vger.kernel.org>,
	<torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<vschneid@redhat.com>, <xry111@xry111.site>, <chengzhihao1@huawei.com>,
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>, <wozizhi@huawei.com>
References: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
 <20260904081149.3000727-1-ranhongyun1@huawei.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260904081149.3000727-1-ranhongyun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e510a-b1da-4944-2801-08df0a62f3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|1800799024|36860700016|376014|10067099003|4143699003|13003099007|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wra/YsabfQo8cS+m/GrKhP9rj8UNsz3Npo100lPkrLvr/z/0Tu1cSUyC558iJDAzP1oaO/4s8po8H/rtWNWYNORmvSfkofgRMlApALjhIn545Qu7m+jlfdvtWYV4fhP4v7m0fIBUcloVK1uwmk4LvTYoG7On26t3bgmx6gmWSydiIvo74Bjos5gmGWQNpzD4CrDa+/AwskFD6AT24ZpyoqZehPMDlWHXgrFa6w+n/UIKS8LjXQGyAsNW/P/8PYJRXAxW4x2alAzI/fVslO+CxUClhssezOu5CNEBgl5Q0+7u67Tgk5uwLjOwIBamGnS4/c9/DahQRaeGtlbPpupkVsyW38G2+ygArUQzYq2o+sAZF72xja9ozNnZ+wyl8/E6pcMCTGokSPXR8YGlv5Dl4jKqJumkq/e/6Fx4n2idubB7VoeqmAK/p/TENvN+xQn+BjBDooDc0hyyv5/iCVEjPLfTfDGviFEiFJqJPJHY7gQ64ofUlxTwTRc1F/hBPj5XcAJWSdYoUkpOtzoURxm1HMI3LKR6ldlRH9bIyYeq70kA9kYy2ah8ZXWkgDJxB8YGeUbhscCgansI+EUeTGO+H1QL5bwGlxW7yPoqd08rn3m20DE9ed7S7jAldljPTslr5L+iD3PwHrlnEvAx1MJxXrjwS2eBOyyWf3X8hREpm+s3ns3QfpJpvqDyXOwEcqBVj3bq0L3v++2zB1Tc0ibLdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(1800799024)(36860700016)(376014)(10067099003)(4143699003)(13003099007)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Nm959zz2lkt2wUpIzKB7outJQvNvSiKiOmKJjU0X8NS2+2rJcSaoUAWlwYkQPNgB0/RM5lPuQf0oFgjh/TZU1MsQaVde/SFk//OtSSUh3L/c0S/iuhPSMkQkPSr3afzRwN06ajYayC2SSdaKP3FAm3/TarQa1vRPgJrgNcx8BRp66BrQ2l8zBXWTzn10qi/3zGARQyqXTbGFa+CVdJFI+EDsT+u7MuH8xhmnnBLpyoA+o5MKDqs56d+WRJwFVEnYQBthVRm1s1MId4vjgjkGQC07PiajPeEItxXoy6Bs3dBTbahEEz/w5Ib44c5xsYxKYHZiURX8nCfxdp8KVlf74dZyRa9cGXimk2l1X0nvVum/J08dOr1Qf7bBqSVohXETAmZhMHL55Sorm9XPL4Ys9YKS/JtraOb72xsTWh+dgI1lQWOyzAE69BRuLvACqoY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:00:22.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e510a-b1da-4944-2801-08df0a62f3c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

Hello Ran,

On 9/4/2026 1:41 PM, Ran Hongyun wrote:
> The commit eb0d280c2751 ("eventpoll: Replace rwlock with spinlock") aims to fix:
> 
> 1.Priority inversion – On PREEMPT_RT, rwlock_t readers lack priority
> inheritance (PI), so a low-priority reader holding the lock can be
> preempted by a medium-priority task, blocking a high-priority writer
> indefinitely.
> 
> 2.Stall – A reader (p_read) holding the lock can be throttled by CFS
> bandwidth control and scheduled out. A writer (p_write) blocks waiting
> for the lock, and a timer thread (ktimers/n) needed to replenish p_read's
> runtime is blocked due to writer-fairness (286deb7ec03d). This forms a
> circular dependency and stalls the system.

This has been solved by putting off CFS bandwidth throttling until the
task exits to the userspace in
https://lore.kernel.org/lkml/20250829081120.806-1-ziqianlu@bytedance.com/
which landed in v6.18.

> Are these issues PREEMPT_RT-specific?

If you are running older version, stalls may be specific to PREEMPT_RT
since {read,write}_lock_irq* variants don't disable IRQs on PREEMPT_RT
and can tasks can get preempted (and throttled) in a rw_lock critical
section.

In addition to this, on PREEMPT_RT, a pending writer will make the future
readers wait until the writer is finished but there are optimizations on
!PREEMPT_RT that allows readers to jump ahead of a writer if concurrent
readers are present.

If a task takes a rw_lock and is trotthed in critical section and the
other end of that lock is later required by ktimers/n, the bandwidth
timer, which is also queued on ktimers/n will never run and allow for
unthrottling. Without untrottle, the first task never releases the lock.

Couple of reports from past are:

1. https://lore.kernel.org/linux-rt-users/xhsmhttqvnall.mognet@vschneid.remote.csb/
2. https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

There is a small breakdown of how 2. can lead to a stall here:

https://lore.kernel.org/all/e65a32af-271b-4de6-937a-1a1049bbf511@amd.com/

> Any clarification would be appreciated.

If you are running kernel version v6.18 or newer, the stalls from
bandwidth throttling shouldn't be an issue.

Priority inversion with rw_lock is still possible until we get
SCHED_PROXY_EXEC support and integrate it with PREEMPT_RT bits.

-- 
Thanks and Regards,
Prateek

