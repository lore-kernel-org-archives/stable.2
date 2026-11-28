Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861551;
	b=pVoD3NhGpDM0qGj9zwINhMkJmYc+8CuBPI4vFPllylfk/LKaHk8QkKc4uPRGefVDVOrS
	 nzBiZJ48i0FMMywFJfek4E+KXE6CSNK98KNjuYZRtt3J93Xx/gibGWh31429mbg56cTqP
	 R2jn72DPhbDabDr3DCpUFXR1w1K6HyqWCBx9X8HYh1g/zKCrMk0kcuIh7XL+B/If5Uewp
	 3qNZbDi0eofovOVG0CB5SINkznvC/8g5UxONRcJOkkU2AFq0mcIf7Z5KRbFbFw9dp68Yn
	 gJkBistNBys2ASgdMJk9Ox+bwDJIZjqp6Q7kDl57DqJBqYOESW2ry5QuJid7SDwAMFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861551;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ND0biGTsv91CJR2hQmkrhPlefVCiIBTU2lURM7TxABw=;
	b=ZJJyYxT2Z+SqT13RL8JHwt1XC28v6OLbSsC5GZ1xHN6mU1e7MChmXnzvMHovOURe82CO
	 8X/ifsFfSHnfzWLmnUYf8rcrYiFBpYMT9a0anlHSbGr0YnTRL0JrzLPWi27kf1Ryhwbz7
	 ohgA6igHEzRGkPS8aJskbRkpKDReSu8Dxz+QTlzg9BBFhmEZtCNFVlp+A4+RYmLFTyIk/
	 qaCE9a9dgjuVzmo81/jNm2aLlV1YsiRlelMC7vNwMUdMZ7MIE07ybPPMfG8E/Q4oGRyns
	 MbpWZXeIUHTtPdQ2A3PuvAbXbB7Aw8dPHZggspH6DS2VRM2NdN5dlobdkrqFOUvAb7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qbMjLbqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.50
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E62606A31C
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qbMjLbqa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDzr1vGvSXXg0exOxFDHUjL++XTNszCm8g8AiI2n6vYjosfTrYH5FCPoDPNDBA+XXgx6dcmqtPkOIq62tFdHB+kwOHsE0saAMZuCFDwroWMgrMp8RaRQIcxWDCSazDzB0sxzypzv19lJgaiZcw3JYjKKm7QZnNLzjvO/f6DWhCqvn29Y+DkZBQBnfdIFEAG+u2bDaNC9QB+cbM7K/e7ELSlMI6bhBC9MUvO7CdnCKTbuU9zr/R48j2OxCUDowFfdYfwwx+Tm0B7YMsg2E0gL9NfFEc2phlctfYXCS4mfXAKyigjMcvLlYKPdrMFvTleJmslVjaV/naxrbXsfXodKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ND0biGTsv91CJR2hQmkrhPlefVCiIBTU2lURM7TxABw=;
 b=DnSei8E8ZP3a/M3AxvY4Lnfnmj8+b14eYNfNHOTeGuFBQ2zZqOpfb8ME7FRUaNtVhQbofC961QGIwGebtbARk1MyO8VcuMNONDERdWeykx/A0WMgMYtKXILDw9lrMEy1Dq3hWV9cRC44KsLmtpmTea+JNY3c5bZ+euGJGu5KiexWHdH3M3B0uQ1sFEUDuoeft4vdoSjKmeal8JHBaotEeYuPxDNL5u0iBmBuWlJmg+MzDfNFR5G/PVKbRazTfmSXAMmiqn1u5Ci+W/ZvjTXLlS4pSMm5ZaDTZ8Mi4M93tDjpDJ2pauthVMYQWCFcZilZfi1pyjGAXDMk8OiNngs74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ND0biGTsv91CJR2hQmkrhPlefVCiIBTU2lURM7TxABw=;
 b=qbMjLbqan961vb2CZL99Qw+Tvy69NPFxHwEDsqT+zCy2Yxo/BRogacFyyhrkuv193c3ukqgL6Mbs5Gp/Wiv5MO4W5PcHzeUvHJJdo1AOf8kn6YhPxtPm24UQDlcwlYZbQ+gTWvRb1bCLFKRytWdM2EFpLRneoF7p2MWgsTAwxZOPTelxNuX3f/HGsibRZvYIGxds6WGDQJIGEWHekGB+cF2rAUwxoW95iFIAsoYlMVjXdx9MJqT7LhTt3lWXL7rJw0sJNziiUpdtvHASZydllIi5jcPzRY9588cgsLB4VG7gPV3rSVfzUqagE/S9i5d0uD2zBJt/nSY5sC69JLICwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:25:47 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:25:47 +0000
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
Subject: [PATCH 7.1.y 0/8] sched_ext: Backport dispatch and task-state fixes
Date: Sat, 28 Nov 2026 11:23:43 +0100
Message-ID: <20261128102535.655465-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00008C08.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::46e) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: cd775a98-cc8b-42b3-f013-08df4d39f7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|6133799003|261009223027099003|18002099003|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	3KuVrilxbML1J0R2Qc/lmYL6GNq5IH9wnyRDJ7Urf/vJIW2RMuBnhn1suTeNI/jN9xl1QvKcEWaR2QsJ0pOh6NBIUw1qEG57JYC3Vuusy8zhjN6A2Lrx421NALdosLYgHY3Sca4pYZLI51IMNzh5mjX+KtSvndtQrk9RhpoxEJd6KJnoPhVC+0g7R1EWyhQdYjm135rc/GaNaSW/5lCcCeISxCkuBL8SI4JFXcEoFkFuBOABTeNEt9yeYNofXGuK7Be07OUhZRiLvvJ0GtdoLvI25XeL5FN4kjCGmoE0A5J7HCQ//cTZ3uwy2VHMe1FsTSczfKLxu3q5NVrEQZfbwAOAkPN8JmdFoQz8s2uhevRm638fi02wy/ijbcGs0jFaJkFCJFLzRMLDtbDdEcHraSyWKFrrMJyThMuQy0gbF9HcXJKdfdRzRwgxWBB4Da5OIOYWjhm5a/tKpxE8Qw9/b9xMY4EVNvPNuQtshhCtn/BpLlFNY7xCe2F64MQ+4igGYO1ifqDjEc4tIp3rtxJf4GXICdNRlEJiQblzHkar1VpCVOeSUWNdkGEOwK70SUdCgb0oqPalGklEnTRdjskecvm0HJZX7qxf5EFomsQD3QxtF0h9Iz2glwVGURge8eZ+iYPWPOKoXxX3zzuGVl0FRM9jjtu2+x58S2KhuOuVl5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(6133799003)(261009223027099003)(18002099003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXXGky2yIuZqnEP6EpE2BICCDGeaTZbLwZ9vSMi4xFoXlm845A71P2uHVw90?=
 =?us-ascii?Q?zUEtPTjlTxG21inA9iBw1OIE5O0ZDzEwK1XoB8rLA+zh99E8FyPKESb0pGWy?=
 =?us-ascii?Q?PdBy/hOxrWMFy/UMwk9LSaqFbqHkv2JoRl/NiILtu2lY7pbSMJZb5x4hJO0K?=
 =?us-ascii?Q?bEQmWS9pqFuAmpnj0zrEPo3pQKDEAge/2lJg554vacm3EYOrF+rBgyboQaKt?=
 =?us-ascii?Q?uyFIs+3jkbvOzJpkpQt5knLQ54R1u7HaYwA2EIgM48SUUM7sZcHGUu2f/bqV?=
 =?us-ascii?Q?GuXdasEbRnw2eWHiJZnTTGwt3b03rzSPRwKzchxlLxhTBax1ibc7t7PPDw7S?=
 =?us-ascii?Q?5f+IZPEt5maMUbOJqFCeU/1OQTtV7r8nuADuVJpOpecFijIdDL1eXn6dxpzx?=
 =?us-ascii?Q?UP88cVfjp6nJ7MtEqgjBM0ta09/Q7/NYuqqCd1RhaSOFsBsFDq85eImrwmTw?=
 =?us-ascii?Q?ZadJBlthaOz/m6gjyxEMskLj32yhQ4axWJdouPd4ywoqUJCyFuQHOXr5FNnx?=
 =?us-ascii?Q?5PK0KuGUVM2+oQDbjPaz+Qs5Tsmxu2mgcbzzP0Wk43RMNVnsCpA8uFFVEhu2?=
 =?us-ascii?Q?HMAX+0x6I1+UPnp9dY9Pnm435KXtXGxMs85cYZcPAvJy3cdA8dAnDqWEfq5n?=
 =?us-ascii?Q?9TUM0TFrmmd6iH3wB6pq2tGy3Xo+oGUcp2KTx5hjdOZN4WzihP/eOAnv3hGh?=
 =?us-ascii?Q?Qh9+Hldd66UO51h93MxS+zTwTy/I7sOoOrcyOa8B3yLNYL+MHVJr8+FegSiR?=
 =?us-ascii?Q?8fGnhb+yZml4SBqwQBB/rdWV26f5f50jJQ2OHoaAqHbHrr+D6jAoYORowxQm?=
 =?us-ascii?Q?LzsGnn/KUp5EprPuh1AX98sLz8K0Cjup9RFQv9ppAQZaFG4JoRo4n20uNyuD?=
 =?us-ascii?Q?ElHE3+tIyd0AouCpPou6qqmV3HoJ8mLDOqs3fdpQx1M8L09UsL1Sw4wNquox?=
 =?us-ascii?Q?AUYHa2gWrLV6Rlg4860OSC4MZNbcHnImq7Uc2KuCXY3+o55mv8G6M8ingNzC?=
 =?us-ascii?Q?jSJLw2aBG4gLAiFNkbIqd2N1IiComKoZ0yNwQWztCZyg2AOG3+0z21wi0wwG?=
 =?us-ascii?Q?iy5I7upkCNbwkJkWtyA9hljSTaNm29gEDZdfcCmqBuQnST/Zbrnb7MaQMbI/?=
 =?us-ascii?Q?pkZRWHhMnbQwgTPJU0S1wXoPPNMitDjWrXwpljgx7nrGF8ftmIV8ix3Y9HyK?=
 =?us-ascii?Q?ds0jx1jRbBZINEmj7bWi7XSrsD3pKjcgatNY6RUipXWKFrhk5pRiwpFqmrpt?=
 =?us-ascii?Q?JGdwAOtVYYa/wT1YBMsIQjxre+FwjCZ5/KLpfr0npLdB5YDaC8QLenkIbcmz?=
 =?us-ascii?Q?Jtzsqxm+7lOuSyBT6RRPC142UXv3CwKn1XD1icYvpn/KL5G04kZ4uf2CEfQ0?=
 =?us-ascii?Q?AIEOJa6aX2kB8UR9tTDefXd2ZSLqwbw/gK5o9BaYVciMkEv7qCRbRvf8e4a+?=
 =?us-ascii?Q?/EyViKrj40ttymjDdebUKNXmB22gUzpeUe6RMyLsqJ1riERDW4xZ8IvHdEn4?=
 =?us-ascii?Q?TPPWWza/C6mitUwMhYt1yIUO8XM1ogQaxO+++XqF03CMId0aXsHyvYlUimX/?=
 =?us-ascii?Q?IJE78Na4KudMmtw78VR0OKBG8tQxxgH2xpUc/pwjpoqNacJAkA9D42Rr0Slb?=
 =?us-ascii?Q?0+hgu5hHo6NrqdmOWjDGlfrZDCZ7IAmHmkGwMUS4gwdxNR9++6Zc46TQev4K?=
 =?us-ascii?Q?m9lgW+wPVWgVK0H7ywJh3oVVW0EptJGEWu+gbfMdaukaOafo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd775a98-cc8b-42b3-f013-08df4d39f7a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:25:47.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl1pvQIHdYOPKVVaQNZpqNdmBrxT5Ta7UEhN6kSd6sFfPO7t8ZOjh4HYWWFyfOiSnZTkfKAzBNJfT3lUMSjQcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

Backport sched_ext ops.dequeue() and stale task state fixes.

These fixes correct ops.dequeue() callback behavior, synchronize
dispatch state and reset task fields when leaving SCX. These core fixes
allow schedulers that rely on the kernel's task lifecycle guarantees
(e.g., scx_bpfland) to operate correctly.

- Patches 1-6 use the older, unsplit sources and static DSQ helpers.
  Reuse the 7.2 backports where applicable, keeping the existing wakeup
  flag handling and dump helpers instead of pulling in later refactors.
- Patch 7 targets the older kernel/sched/ext.c disable path.
- Patch 8 resets the fields directly in the READY exit path because
  7.1 lacks scx_reset_task_fields().

Tested with CONFIG_SCHED_CLASS_EXT=y and CONFIG_PROVE_LOCKING=y.
All 30 sched_ext tests passed, including a task-field reset regression
test. scx_bpfland also passed load/unload testing under CPU load.

Andrea Righi (1):
  sched_ext: Reset dsq_vtime and slice when a task leaves SCX

Kuba Piecuch (4):
  sched_ext: Check remote rq eligibility under task's rq lock
  sched_ext: Call ops.dequeue() when a task arrives on a remote local
    DSQ
  sched_ext: Wait for SCX_OPSS_DISPATCHING before moving tasks off DSQs
  sched_ext: Generate qseq from a per-task counter

Rahad Bhuiya (1):
  sched_ext: Reset task fields on exit of an SCX_TASK_READY task

Tejun Heo (1):
  sched_ext: Wait for SCX_OPSS_DISPATCHING before reenqueueing a task

fangqiurong (1):
  sched_ext: Don't run ops.dequeue() with a DSQ lock held

 include/linux/sched/ext.h   |   1 +
 kernel/sched/ext.c          | 130 +++++++++++++++++++++++++-----------
 kernel/sched/ext_internal.h |  28 +++++---
 kernel/sched/sched.h        |   1 -
 4 files changed, 109 insertions(+), 51 deletions(-)


base-commit: 81d3924095fd017e473332a9b6dd6dd0e3d9a59b
-- 
2.56.1
