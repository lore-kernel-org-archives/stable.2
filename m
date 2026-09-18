Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB728488F;
	Fri, 18 Sep 2026 04:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704931; cv=fail; b=Jo7XU/tVKigy4fuY/WsLGlaha5vcdtgMpx+cjAdOV9nqg2P3vch4D19PJr3Km2xn5Fz8gtp+YnzcAqrrnMMrjyOnNFScHWqTP14upIJWy12LSYC1nBdSr+T31FnITxaw4kWkox/myUjFeQxmJXu8Ml5Zy8OcSpPYI67MQGKJ7ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704931; c=relaxed/simple;
	bh=N4n6Q3+21H3ET3bkUqbhlBZfxsv7TAzCuocYsLXACw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqp9J1EeUd6Og7SnD9+4IxUW7onNoPF3OLtH1Dm7OLM00WhOfmq+BG5/zxkFnt3iOtxRa6m585abISh7LC2KcTQmkMzgpSOb6Yf8XMocGsYcS3kiKZMeL4FH9prDcbe2N74JGjPKcQyjZVbCUB/mfv/vJDtpt5K+azcq6lixBwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0rUOpuIF; arc=fail smtp.client-ip=40.107.208.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0rUOpuIF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKGFKtgX/oNb0PNFAKuNX7CB9C0IkDv4xCBTLfdi5kfRM6Y0TvZ7Uv4sxdgsK2dDvkWH9eov/nTZp0YAYCbTZZzOuqhg7L6BoqCaAHZHy6FwreMrkyTPXSMIGi0Ct/gsR5kWfWiP5mk7UlG9a9vvYVgEkhPLux8YZKQqWC8Gp7nYwD+SmlbGdUKhN3DG0TaDI9l7Nm3kgloTBzjgOdmNPkdv/pSNHC2l7tKxzLzXzg7w071ofKV1uZNICkOvKUVqfrSDx94oFnEYmXpWc6VGAP/3NHrn71iKOm/ySll4fS0lj3uIk8pw9Am93zsNttU6qT8qwi3Dp5P31489c6/YsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGzSJvfzwe5+nkB/WrNnRuX57PjsDokXUYQ8Vj9joxY=;
 b=JfQ3QAi8qaUJGQrzH19zSEi0I2yqtuiXyrUZ5UsyMa+zBTqLy5mjdwY0dCtrMQKP1IW+glLWPa/AkH93w7L0B3yttgo/GIIvqX+3dI/Wf5sSzd3kGggNXo7AvLN+Y06QCkrRZ+2hqb3/+VGaLFLEBqCU2Udag90WM90k3sq2x6DA2A5gkE04SM0Q+UuIT6G1MaZI1V5s3t5ErKPwOcRcGKBRX4AdsUdgBHkYKut55k0Oc++M6Ov4xiPd8UpWElCnVxQWzklj1enF52wyyjzYpDL5FMBV/TpTm+bPEJCdp5bJggCwTT6fn5tbZOpsJUCzMw1ufhpPudWxaIKu2VcVRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGzSJvfzwe5+nkB/WrNnRuX57PjsDokXUYQ8Vj9joxY=;
 b=0rUOpuIFLNtvXswgYSW1J0jbHf6/YTffe5UwrDcUlzslpthLNhcGvW/WBxaX3XS50jObxr1qpb+efvTZ3iYcniTeSkGtxV60J1taJFvwjX6DWPgyTAhbWnMsdgkWpUci+07BN7nUWJNZrwMkmadkaODypgHe4xnP3Mfn+LsiFUU=
Received: from BL1PR13CA0177.namprd13.prod.outlook.com (2603:10b6:208:2bd::32)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 04:15:20 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::6e) by BL1PR13CA0177.outlook.office365.com
 (2603:10b6:208:2bd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 04:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 04:15:19 +0000
Received: from BLR-L-BHARARAO.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 23:15:09 -0500
From: Bharata B Rao <bharata@amd.com>
To: <peterz@infradead.org>
CC: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <baohua@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <bsegall@google.com>, <byungchul@sk.com>,
	<david@kernel.org>, <dev.jain@arm.com>, <dietmar.eggemann@arm.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <jannh@google.com>,
	<joshua.hahnjy@gmail.com>, <juri.lelli@redhat.com>, <kas@kernel.org>,
	<kernel-team@meta.com>, <kprateek.nayak@amd.com>, <lance.yang@linux.dev>,
	<liam@infradead.org>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<ljs@kernel.org>, <matthew.brost@intel.com>, <mgorman@suse.de>,
	<mhocko@suse.com>, <mingo@redhat.com>, <nico.pache@linux.dev>,
	<osalvador@suse.de>, <pfalcato@suse.de>, <raghavendra.kt@amd.com>,
	<rakie.kim@sk.com>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<ryan.roberts@arm.com>, <stable@vger.kernel.org>, <surenb@google.com>,
	<usama.arif@linux.dev>, <vbabka@kernel.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>
Subject: Re: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast tier
Date: Fri, 18 Sep 2026 09:44:52 +0530
Message-ID: <20260918041452.270875-1-bharata@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917162324.GP4121339@noisy.programming.kicks-ass.net>
References: <20260917162324.GP4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb6e5d5-db54-4b8b-dda8-08df153b7391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|22082099003|18002099003|13003099007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HeZbWRI0GI31+ZcLR+ekhEifAhVPHw5Qjfpr+nk/adra3Y+Nbha7tczFDkBxQJXVd6L1eFf24RvYwHonTGT/NQnEHX27/opEHZlFpMwxvfLlgzOC0IWaSrA5vzycDqXOuKVVuB2tP22h6BP+YTxZJ9GZ02IT3mGx7/BPfUc908OGUw/FOheSsha/0EcWZWk3W8IVgBEsEHMNXyyapcCdMjt3FxWeaB0DXmpRJLFbZPnaQ12+0rPy1/SnRfgaWZM8xy8WUjYed9MNEMuQOjrk3h0QGikEQ5eCGU6PmfxyR4dOx5N2ven/5l2jmKAQcPPDPmnPV2MYtVoswaLbw7W5RJAtjX8jGHftE7egu2baFt34wXFy0YbJ/mqhUZz+A5lxkYEYWZqSEP5YQldsKLWUmISpG6ZmJIqaicF22Hw4sDKwwiRwNX3aYfSseWA1AxRl8dlKImelYEBXTylsa6wdIwmuLFwml+belwL/A7fbkI21AouH5mPLKTe/0HqdK4tdzRXGnTEAxhuKqvHTN4bKP6bQTEAnVRfQgEDfW31g1SCD6tjel4nriJWrhfKREp6d4AKd20wloTxfQE7AkhziFWPoTCaNH8QWdadPGght9MnUNFNZs7Ww7pbGPNYDwWnt+44gi9glo2wHklnqKb82FtVRODXWJvvQ7SB904Tzcu+G54FQYYGS7DKLJCsFB8EO7Wxcd1y19rGUEEDIiSdPqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(13003099007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	spi5ID4qRKeyi6Jd+ztRUBL3zSXwvifp+mZH5gf7ipwBUP22AQln5gQpzc+cjtsgjjls6yyY4LctMEhb4iRV2nxeTr3SvP3sqcaHXh24ZPtQTz+g3y5kWeOYliooMXvmzA2QD5PDfOdPaXlj81BvDo7/Or/W4vxu6u6VYSOfeYhTDogEXwYCAhuVVPRKpZRT7XSsLt+9wkL7O455MScSM4Fxy/efNZD6CpIHV+vhcb6tz6tuCYqefgJDTyVlbxH4BdXVbHQoqVA4v2ZAQ+BKhi09HfbZPYZLoLse6qwtLVPAtelAANsdZszXYlxspmBdd8gGuzPycrurXjd34bpMK7ozXDIhENhSh/gCInO2qhIoRG2jMfxU5KgsM3+R4IQ+ntYOKyRbqsv9tqezosOqrGHI0yzWgz5UCUfpbEwPWzG4wSl1iRG9gRnchkTvOWrr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:15:19.5636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6e5d5-db54-4b8b-dda8-08df153b7391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925

> On Thu, Sep 17, 2026 at 12:18:24PM -0400, Gregory Price wrote:
> > On Thu, Sep 17, 2026 at 06:08:27PM +0200, Peter Zijlstra wrote:
> > 
> > Honestly I'm starting to think hint faults are a big hammer making up
> > for the lack of hardware support for getting this data.
> > 
> > Would be nice to just have the hardware report what's hot (and how hot)
> > rather than depending on a software-heuristic like deriving hotness
> > from a page fault.
> 
> Yeah, there is/was this patch-set from AMD that uses their IBS counters
> for this, but 'ab'-using the performance counters for this also has ick.
> PMU data isn't ideal either. Mostly they generate a ton of data that
> needs to be analyzed as well. Its not clear cut and easy.

Here are my experiments with using IBS for memory access profiling:

1. My very early attempt was to replace NUMA hint faults with IBS
provided memory access information to drive NUMA Balancing. This
worked for all the modes of NUMA Balancing (kernel.numa_balancing=1
or 2) [1]

2. The next attempt was to use IBS data to drive only hot page promotion.
In this approach, IBS was used as one of the sources of page hotness
information to pghot (existing NUMA hintfaults being the other) [2]

Both the above approaches used the primary IBS instance that was being
used by perf sub-system also and I had made the use mutually exclusive.

> 
> I'm not sure there's been proposals for better hardware support.

Then AMD Zen6 processors introduced a 2nd light-weight IBS instance
called IBS Memory Profiler which is separate, works independently
of the primary IBS instance (which continues to be used by perf)
and which is primarily targeted for memory access profiling.

I have used this as source of page hotness with pghot (pghot-hwhints)
and the benchmark results are encouraging. [3]

Also it is worth reiterating here that neither primary IBS nor this
new IBS Memory Profiler have got anything to do with PMU sub-system.

In this context, I would also like to point out that pghot patchset [4]
is trying to move hot page promotion from scheduler to its own dedicated
sub-system. I have done the following till now:

- Extracted out hot page promotion engine and moved it to pghot
  so that the same gets used for other sources of page hotness.
- Moved fault-time migration to async and batched kernel-thread driven
  migration (kmigrated)
- Used NUMA hint faults as page hotness source to pghot (pghot-hintfaults)

I have often wondered if it makes sense to move out complete hint faulting
mechanism out of scheduler but then I see that task-follows-memory part,
the scanning logic, fault stats heuristics are tightly tied to the scheduler.

Also apt is to remember the PTE-A bit scanning approach [5] that was started
as a potential replacement to NUMA hint faults based scanning. We are
planning to revive that effort and make it as another source for pghot
if we get good results with different benchmarks.

Regards,
Bharata.

[1] Primary IBS instance driving NUMA Balancing
    https://lore.kernel.org/lkml/20230208073533.715-1-bharata@amd.com/
[2] The last pghot version (v5)  which used primary IBS instance as page hotness source
    https://lore.kernel.org/linux-mm/20260129144043.231636-1-bharata@amd.com/
[3] IBS Memory Profiler as page hotness source for pghot
    https://lore.kernel.org/linux-mm/92c26cce-0608-4c0d-bb13-fe87afc225ba@amd.com/T/#m6d17d0d58a5026c16d63c34e1abfd67a57a66256
[4] The last posted pghot (v8) patchset
    https://lore.kernel.org/linux-mm/20260728054356.291998-1-bharata@amd.com/
[5] Kscand - PTE A bit based scanning
    https://lore.kernel.org/linux-mm/20250814153307.1553061-1-raghavendra.kt@amd.com/
