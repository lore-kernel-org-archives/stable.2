Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861586;
	b=E86ojrC2cEs51WxyxP2Mje6R5pysNLaQGXKYzNW3p8Mj4GWCieFkLrBmzbPAtXOBV7ys
	 LFL/NeBsYHdaHkwrc8pDhlfQVHFWi9Ha2cV6q5AhUcCA5M1rjA+Ow8ueixI0N95cbtu/M
	 UPIs9DUzp3Eoo9YWgYFqUi2DNn2itUab4a7U6g036w6Hr2dxHt3a2UJWfhlbqn1E2qZtb
	 OkFOO6Cdu/Ly6wSg94z0Z2StZ+F36RAROQE6nsYz47/bP9kasQ997NW+GXR0MxDGXdV9I
	 EHbPpCMCcLhsEQ7tfzbwQ0c+RrPKa449I0Y06Qcz84WSwrBeCIM4yBkiZT++w/XmdDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861586;
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
	bh=JNrE9vdVcwolwcs2DwUETatpKta5R7Gp+nKeUhKmMcQ=;
	b=3pUVqPlILOvfRvQXgGdbJ6IQBSegWT93jB78oGfEXjoEnAywXahX9mcCKYbyvJ/5rYQW
	 vpQSOBB04dvAUe+Y6Z5aXpF/U1Ly0yzHeHy/yfxVDkiyK2RLCeNKvikjBIEq7Le8+uEqp
	 ZWK8TWIMSsE2Uaozk4Xvy41reP0KyhOMqJTVTM6IAQXsjt++bN8ze5omwiE9L2yugZKbk
	 44E6Iy85Br1EBIBB/IkPh5O4qkYMhd38m3suAReSc29vmkQb6WH695HwPxl4WI4x3ZoUA
	 KwHp6KBOF4cmWfLy3vQSsG9qU0sV7zIdy97lQfUVmJGDbCZcXpGkrX4GdX+yD7NHo4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hTNbiD2f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.37
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A0B606A31F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A0B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hTNbiD2f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEdRHjRl4zxIAvqwRpKtGVR2qE+Puzw+eqVJ9geqIAIiDZ+U25x/0SjrS4a8LgPeVNgxugCpl50C5JV+C6PT7xVhjSgfWOJBiRu8TXAh1g37nUJ7B5HILlSZzR5+TXkij5RezL2Eo2G+cH41mK5Lylee6NoHzpaiWZTdnkqbzSkXCFjeMPzMEWin0Iydd63bbNTPZDshNK8mIr4ZGRzgW69BFypQixuOB2RaP8kx/tJN/nIFzRKqJxiNhZgTb/ELvb52aaXg7exXgYSlbGMMjdltXkSoogaUT2X3kYeNIacfmrprtY8HzQUyFmgNxba9ZMWmopSiJJWPNAGqma4v3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNrE9vdVcwolwcs2DwUETatpKta5R7Gp+nKeUhKmMcQ=;
 b=Nn5ZpGc1PAs1+qifWfzAfb/c8FmxVCxHe1NTFlNabkEDGeBpsbism9b8B3CMJKaekq3mb1uVOVWXnlGprlfa5ZTP5xlWv6SdaVBZi72yRtkkW/Kf+3ByUJblDD79YYfc0Q/lJxxFim5ENECTi8o+ojQK1y/ibfBZ+cqI2p48onSrXcgUzA8xRkrxVk0ZcID6mTepzD72nEtNy0fAarMPmVz7VRvWjuNHr/tTM2HwqisETUnphsZ7ito6onGjVT7HByslLB0ouDIt0pyxp/KAj15FNRScxCeSTaQpbzcb04r0qiFUP+Gby1J/0IS9uft+QgfHT39ixBxCnmI0utszKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNrE9vdVcwolwcs2DwUETatpKta5R7Gp+nKeUhKmMcQ=;
 b=hTNbiD2fIa/xaRGpRzZaxRq+d3+HeEQM8xwIS7p9i9khXDDycLFJIh7b/knG25NxEhDXihjQVNgwKQTxW2w2WC6ndV/CcOmjDTgDrV/eUCT0eoA0ndb06RXOcPvKkjp0+XDMW7XpfwukBW9LCZq6OiYBPu4PXroDIUAezhVWKC1xeNeFbxGos2jiuE9CcGbNOPhAZOx6y6+6NJMa/SrrjVJ5pn6uh/4oLPY60kg4Be3QEIgEgTwPrW2eP1rsQWWzIpkacRga8hrzjTqNkJ5E0mZ8vMVjnJAS2+eELysZXh6xW6Y59bLulI2Kk/50VCs6P9L/WtIyh6uFFpzLNT3HrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:22 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:22 +0000
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
Subject: [PATCH 7.1.y 6/8] sched_ext: Generate qseq from a per-task counter
Date: Sat, 28 Nov 2026 11:23:49 +0100
Message-ID: <20261128102535.655465-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6P244CA0011.NAMP244.PROD.OUTLOOK.COM
 (2603:10b6:805:106::31) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 6617d3fe-a9c5-4d3b-9990-08df4d3a0c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|6133799003|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	C5wxxdll/Cc48XoV3vqqycyRZzQjQu46UutkLGLIEO54QAgHSbc/ghDxyUCEOEiefWRPVDaZwrtUQwTlUpPKNA/+RRiY6yYpI97FtACo6FIVkoFB9coJjVjet0Pf2Wu4VM5IP+/NN6UzS7WxT09SYZcDFXqV0uU3MW4fLAO0H9qE+OPxFtCtOUWz0OfI9nRVTw+zZiPUTvTgn1EFk0Pxwp9I6M8utWWTpQSfTy/mVSmY1ytx1nTu3AFUKOAQSK/xgOXnwb2k3Nthk+kA8AEVAI61TkjEqSPqVyVUJM/QuY16Bf46pG/arVtWH3pOcFCuDWFACfQQlyH1qkn2fHRMaaVFgviUv1807FtOiEm0zdw7KB14A+R6KG0zV2LUMFza+R/bgM5pkPYdy1KgzxuPvZtmS9U7e56mivN+hobUNG8FIOMxgJ5LteLJDSLGXWIH4WXiMoK3SJ+xut90O5KTgs0sE9VityQvjRb6L2P+baoIrZqmemMrPKe+eMU+s14ZxgZiTcLgBrvtv2XklwTD389rP0rvpEPyvS2y3esycSd6c0oK29Aiw4hTh2J6hU2MwNykMgrdP6m7B50rQxUMbLNXEXfjeVCp5j63Z0WvDrnaq86aOPBnA6K5XHRSUsIjMF7Q41zMMlAT8kkQyz4IYFP70m1pDS+WBdlPGuJe0x8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74RewoekFO7ZfNvEP9tY0aOrMwT1Ilm/CX4TM9ThyjOAWvcHV6YrSCFqbRv7?=
 =?us-ascii?Q?++2sHyWgRmmODfvDovWLVUbR6lQS7fhsUAdBTuN2ORij1cmRYJRne5wWb2dv?=
 =?us-ascii?Q?fTRA4pNLP7qoTtKQlDPhtK3BDfBXTC4l2YGyJ6QR+jNYyocp9EK7AKDQM18f?=
 =?us-ascii?Q?uAoe2ePPyLBj7k5HTRVPrR4kqHWbt2zV7FK2bV714efBSb5xlcEMG7jhoVQ7?=
 =?us-ascii?Q?XHhYdD9TuHvmElJbPIQh/en/s0GNfTMWRXDQwzq04VG3M7ARDUb6wrHPkhip?=
 =?us-ascii?Q?Gp797j3dc+0opEF0GZM/yYu6ckD9KZJ3KHGZDHHRAe3eVbJ9wSvij930R0Fu?=
 =?us-ascii?Q?Gy2yWdjyHgwWAsnRvnMoFlcarFYKioV6duMd4uwi0GOxHKaGVTltZhtX2jOs?=
 =?us-ascii?Q?OQPMpb1UDzMouko2fPeDlElEWk/VWNJsN6x7erlp2KmJRvKGTyE8htd/rN4S?=
 =?us-ascii?Q?AtD1VkrKwyFPcnKOVO46fR8CoQWg3/IY++wSVbXVCwzNXdGBTI+GUE0/2R9T?=
 =?us-ascii?Q?d2EIqjHSaBG2jIaJ9kWjTa3s1eiXpMcmD8oMaqvEsORjJnowkNS35v07s1gN?=
 =?us-ascii?Q?K+FxxtSVByf3b/VMNUWF3gT4lybLalYa0pM+ao32rxp/VQ0NSPhfZ6kdysQe?=
 =?us-ascii?Q?vVVm8BYbCby8SQL/t2LEIKyos/B9lzKLNyYqW3nfCJMLdOycf2LBgMAqgwQz?=
 =?us-ascii?Q?i7cuqwH9p2VZz2XL7EEaFxkJHy1HTWM4Pve80VlZBa6Z34Zl8zIu+sH3ii8Y?=
 =?us-ascii?Q?QU8VotioYdYbY4CGd14OX27Z6QcK1BrkzdtGZmxtCO16zF+CBNFFXszV8B0t?=
 =?us-ascii?Q?VDexB1R3X0h6ZDYtKIXw7XtWMXKdTRah06eopqu6geBmxfpF6MGKpHlrACAE?=
 =?us-ascii?Q?GpLbiJknrUMEM12a8LzFf7cFUBur9FY2Vq8uXeTnngR1/wQSqGA+KTFDK4uv?=
 =?us-ascii?Q?fSDV87qJzx+Re4nN9xtgu6LT+nJ02A4AMMxwbuLtUn1U3vHNF8tZVBlR+J5m?=
 =?us-ascii?Q?PtxlY0PS3EvbgSGWwnADCqcyVLs77NFdKsVoVT8fJTKvV+7WgoTFyXg/Juoa?=
 =?us-ascii?Q?9IJaUZI/Vl2ePLgEgzR1twqs/glFbpaLNvRVVcLl5GDYM+Kl4WOQDeNEHefC?=
 =?us-ascii?Q?ghINAsx6apjkuy4Ttd0Nm8B5xk5oHBuLGc0M66ofnheqvuc9yd8xBMT+8b2O?=
 =?us-ascii?Q?yApV/7w70nKbAOsXWS56gXabks8Jb64WdZu72vOOE81QvWzerCvRSNipzIaW?=
 =?us-ascii?Q?Cild/gZ56JSKaGP7qZN6iM0ynaBjQtDp9ZnYvQQyHWhFejAY3w0wH38CbT5A?=
 =?us-ascii?Q?0eREsCHBsWYbk4YtD9wljCYTgqKoGzcWCR38xR4CqqVkvg/ft5KqgIvbBeoa?=
 =?us-ascii?Q?VQtrIlg+4+Ew7D7wPaafE8osX5N1LWRHzclusbKc/OSr5+9QWEn2TZ21mFzs?=
 =?us-ascii?Q?gYLHFNkLLFh6Scgv7igrCDzs1TpTc8xiYydMf9jLad9Tf52WvSyLzZ0MqDvH?=
 =?us-ascii?Q?2ZcgLA9qk3EB6VituOuTApvbPWJVtbqHIifvYFpvoLmrtRjGU3l068kDcL66?=
 =?us-ascii?Q?IOKqrnJVsmido7LRdovN5bRShvxk4qhD2iU+LXZbDzkQ+a9oOQ/MNo12k2k2?=
 =?us-ascii?Q?0qxZO+YSIkSN9oS882tBmIJjJCFIlY/iN4mG8QHAyqJFs1rHDZmiNSyNLwt9?=
 =?us-ascii?Q?igoXn0KLC+dlnWjBKMao3YGmtEASu4uxw+ZC8Z+wmUYRrhAZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6617d3fe-a9c5-4d3b-9990-08df4d3a0c43
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:21.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYUgsSDDPQMdzk0iVYfZZu7bR6JoakatW+p6BeKsfSzOVTvVrKilJiyhPfDPoqjV2/0thsqX02MyaU/UF7CVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Kuba Piecuch <jpiecuch@google.com>

commit e6ac89b8b1c12e9104df45a14a26e2dfa96ded06 upstream.

finish_dispatch() uses the qseq embedded in p->scx.ops_state to tell
whether the QUEUED instance of a task it's about to claim is the one
scx_bpf_dsq_insert() saw. qseq is generated from rq->scx.ops_qseq, but
the counters of different rqs are independent, so if a task is dequeued
and re-enqueued on a different rq between scx_bpf_dsq_insert() and
finish_dispatch(), the new QUEUED instance can end up with the same
qseq as the old one:

  CPU X                          CPU Z
  -----                          -----
                                 enqueue p on rq A, qseq = N
  ops.dispatch()
    scx_bpf_dsq_insert(p)
      records qseq N
                                 sched_setaffinity(p)
                                   dequeue p from rq A
                                   enqueue p on rq B, qseq = N
  finish_dispatch(p, N)
    qseq matches, p is claimed

The claim itself is still atomic so the core stays consistent, but an
insert issued for a previous QUEUED instance gets applied to a new one
which the BPF scheduler has just received through ops.enqueue(). This
breaks the guarantee that dispatches targeting a stale instance are
ignored.

Generate qseq from a per-task counter, p->scx.ops_qseq, instead so that
consecutive QUEUED instances of a task never share a qseq regardless of
which rq they're on. The counter is only updated in
scx_do_enqueue_task() with the task's rq locked, so no additional
synchronization is needed, and it fits in an existing hole in struct
sched_ext_entity on 64bit. Remove the now unused rq->scx.ops_qseq.

Never generate qseq 0. NONE and DISPATCHING don't carry a qseq, so
scx_bpf_dsq_insert() on a task in either state records 0. With a
per-task counter, every task's first QUEUED instance would otherwise get
qseq 0 and could be claimed by such an insert. Wrap the counter where
the QSEQ field wraps so that it can't reach a value that shifts to 0 on
32bit either.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Reuse the 7.2.y backport db83b53b580a, applying the dump
 adjustment inside scx_dump_state() rather than pulling in the later
 scx_dump_cpu() refactoring. Use the unsplit source paths.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h   |  1 +
 kernel/sched/ext.c          | 15 ++++++++++-----
 kernel/sched/ext_internal.h |  5 +++++
 kernel/sched/sched.h        |  1 -
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 31c810a3b808b..c67c9363d18df 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -198,6 +198,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	s32			selected_cpu;
+	u32			ops_qseq;	/* protected by rq lock */
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 
 	struct list_head	runnable_node;	/* rq->scx.runnable_list */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f47f0349935c6..ca9ed9c1da66a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1925,8 +1925,14 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (unlikely(!SCX_HAS_OP(sch, enqueue)))
 		goto global;
 
-	/* DSQ bypass didn't trigger, enqueue on the BPF scheduler */
-	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
+	/*
+	 * DSQ bypass didn't trigger, enqueue on the BPF scheduler. Wrap the
+	 * per-task qseq counter where the QSEQ field wraps and skip 0, which is
+	 * what scx_bpf_dsq_insert() records for a task in NONE or DISPATCHING.
+	 */
+	p->scx.ops_qseq = ((p->scx.ops_qseq + 1) &
+			   (SCX_OPSS_QSEQ_MASK >> SCX_OPSS_QSEQ_SHIFT)) ?: 1;
+	qseq = (unsigned long)p->scx.ops_qseq << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
 	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
@@ -6475,10 +6481,9 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		seq_buf_init(&ns, buf, avail);
 
 		dump_newline(&ns);
-		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ops_qseq=%lu ksync=%lu",
+		dump_line(&ns, "CPU %-4d: nr_run=%u flags=0x%x cpu_rel=%d ksync=%lu",
 			  cpu, rq->scx.nr_running, rq->scx.flags,
-			  rq->scx.cpu_released, rq->scx.ops_qseq,
-			  rq->scx.kick_sync);
+			  rq->scx.cpu_released, rq->scx.kick_sync);
 		dump_line(&ns, "          curr=%s[%d] class=%ps",
 			  rq->curr->comm, rq->curr->pid,
 			  rq->curr->sched_class);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index dad9a084945f0..faf9e2b5d99b5 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1354,6 +1354,11 @@ enum scx_ops_state {
 	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
 	 * on the task being dispatched.
 	 *
+	 * QSEQ is generated from the per-task p->scx.ops_qseq counter so that
+	 * it doesn't repeat across QUEUED instances of the same task even if
+	 * the task moves between rqs. 0 is never used as a valid QSEQ since
+	 * NONE and DISPATCHING map to this value.
+	 *
 	 * As some 32bit archs can't do 64bit store_release/load_acquire,
 	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
 	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f63b15d309d1..81fe6805029e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -794,7 +794,6 @@ struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	runnable_list;		/* runnable tasks on this rq */
 	struct list_head	ddsp_deferred_locals;	/* deferred ddsps from enq */
-	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
-- 
2.56.1

