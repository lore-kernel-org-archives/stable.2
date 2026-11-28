Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861589;
	b=cLfGsqs8D9WTk6/qMZ14CsXOg1RPVmTqS4qH6dfy0SkcZQP2exQz/gA8h77HoxlKt2V6
	 ETJmgoBRtgvguwnD6eYpxqgKQhLqxkDsww0ENQLGwNX4TtJOb1ta5KE9IMiwFJegd1rzr
	 Gm5O7dMfaI9Icv50yJAhLVJdigpcIK+nYW6qoV6BvP9CjkvI7/vTUnqY6C6ljLKwRwIka
	 ovvjneQwzJxm3425e9Tt+ttUoh3MCvdzxoftt6UUw0DuFqzI980kiXwvYEgISuli/4Ph+
	 Ei3oPe9M4L090xCKXIYJ3g7HggIkhyN+4BKwxbCFd8lIqe7GrwQsi+5bkZh6bD0xamA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861589;
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
	bh=CaRcAgk9tLS7/0i9XduHaC+KK2vSIYKtmzc78K5Z0Ps=;
	b=avma8ckOfEJKV4InrKNU6bJ62HwtBTBiVrenPVjvSf1JUZdJiH6uQ4J4GG7gPQYyJgFz
	 RIEckRQRggzDuIof09ABh9ChTn066jyOloNYyDw8P9PFmxe5H9wQw7AAAiQZU1Nqnx2Mo
	 0xtPdn8WpAyNoaQ5wfq5m3Hg5Ust+nQCDwXlRo+VtPVM1rXV0HwrOefg1lNE5WjIGqOph
	 ZMgYSbHhvfDIIXa/pKb+Zq49008TILu7sKUKBHhcatxtx/HIJrPTufz6nponELIaeiElk
	 wRMVQx+3fdCEHg3ik54eXTvp0OtlV1I+tWeexXuynARVsh1/wy2PAex1Nbq4PEFVTwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a0HbXn3K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.59
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ECB606A323
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5ECB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a0HbXn3K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR5XhtUgVedk2yU64smiQ6Zqu6YWIiGuNAVbD5aufUdvNbuYSdWScxljgb/N9OgQTp3K5rK8cy/JjcjWxbi7umvxG5GG/qUbRIC8tNFN/ovT02l6QV9tvyV8VR3M+eoQyVm5na8FfL7/d9IizXAq1t1SPuiYlcovcY5at+DCfv48/DLLeG1vej1fx1hB/+7fME7o7wFMZbR73iBlv6oXdOsdIYuN6Au5Mv7SeO2OHV1EAcpWU+nPeisMk15ZOFHPtbQoLwDKEcGRWQ8jy3Ctis/uJd7Z+pznAe7MzeiONKu35Ua3x/JEL8oRw5P75ZpJQFYVaHwb08g0KxIK7vmhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaRcAgk9tLS7/0i9XduHaC+KK2vSIYKtmzc78K5Z0Ps=;
 b=XfHtImEdRQKtR1xbyXD+QAARUdz0bElN/8DNS2taAPNxfvMCbnxi7JGR41T7/AHdkaQ71ccqWBg/3caRP+RgswQxKtLphzRxKzAWjVU4bU0gX3R33ukpB+MlbfZ0d0Q3EXvYwzTW7AzWcDNbyAK4K2euTvwq1ntr+pLCeYiBeyEAE2eDiPq0cAyaD7gATxDIjpicvxHfGRRF74l6jKz8VZd22b7bGQMixxoer3YHJV4xdXQ0+g1wGG0T1NnFvWJXa/tNXA8Ra3o60BDsGUhAYrD+QW7ECBjFp4pEefDcfXUvuY+WSWbBZCh5blFqu7aYNblrBqFD+scOHvBk6/9nwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaRcAgk9tLS7/0i9XduHaC+KK2vSIYKtmzc78K5Z0Ps=;
 b=a0HbXn3Kg+PL5Q8WJiveZ9270NrWNgLPaIuQiKwtlm6oo9DgthAgRv+Rm5b39Cnp5Fp98JcBvr/llQGfrpuxmd89MC0YaT+BAspwX0t7KKMoSTqeXiOaY3h79jXMEnYVHMKE3EslmfwxlAfoQICsvlMLMtHB1OjfGqhYJbeukEbgknhhP6ioZD4JhqRcOyMDSXUOPddSexMnO1rJkd/YEUEou8zFFfDRAb/Glm7hvCL2mHqWumLSJryru1HbeDBAsb9CDGJneDawfUduVmQ0owSewuh48q3q+ey1CRXvRtwRANFLtf0UaCDw1CigNXDLmshW68Kis02U7OVAsW5wCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:26 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:26 +0000
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
Subject: [PATCH 7.1.y 7/8] sched_ext: Reset dsq_vtime and slice when a task leaves SCX
Date: Sat, 28 Nov 2026 11:23:50 +0100
Message-ID: <20261128102535.655465-8-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9b26d80d-c27f-47a1-22fe-08df4d3a0ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|261009223027099003|18002099003|22082099003|56012099006|10067099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	MQuSYJPHA3+HJPa/nZOPWCg4II72/SCIfluNJIXDPYOkcLJlGtyu4NaYcjYpcdnHm4m+kPKo6tBTOKcAVF4JV2odM0dYGfNDPBbLZFbdkpqLfRs+Be2lyxZ7WQ0DrTYlGaBnkE0vbwpO0cD2plTc71xpBCTik9IfmL/+T/AW5JzCtR8V363awsI2fpiKjtvIpuH4eHcuYl/4Bi1oUggNIFIPP1xzdgw+JSGGgyjGtBSwci9BDHUjGLs7csntuX+y19PMNuhznBCdb/Q7XPmlJzpXA8zGoomn3zKwIpRH2BrWvanIzh5k7+uGASKals8Z1We0HrKyH2mvk4ZmmVkaHMEqh+EbS9x+yOFnynsnZKddhuFg+9zQwhQ9assi1kkdN8F1ek7tV/xMzcgymEc3PuUFZVRsxjvaZtoclQ1BW0apfZ23L8rwhc1OieG0oM3KUemZ9ks//WIpt7Wvly2tYyVRLefLClBqrgN2bNN/iFwvqLlqiqX5kM51L/rQAP2hzhSKL8ad9kO11nPE662wtLQZE9HN025PnAJYPdca0JJbskzuMtoq9zs9Gm+ym5rtkuyMN7OnSuTTpBUiI8ItFBlsUi9qf7V0iOE1pfa/MJ6eDUzDJDViPQCVq4o5spF5Du/Ee3hSI0aK4cRKjQREnbzEk4y541cM9+CQTLx0E2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y3sYSbwrnk+KtVBsb8avBF63jN2+tTEZlKmYatNHeEA7Z5c7k/5oqa9XMb3I?=
 =?us-ascii?Q?ZbQxNMz704idsWvnxJEbSDIGHvR0vx209cJMer/eCpPrQkg00Qja9DKvvoCL?=
 =?us-ascii?Q?A62koMId8s11Dfd/WsiWRyEhll6hiMmX2fa/LyIJggxq+8KQPXAFmBV5dFAn?=
 =?us-ascii?Q?3+4sMqXeyFAu3snuMerEfmT30dOHAXREe/ufmSfoJlNgMhM4/Kka1zRr1zF6?=
 =?us-ascii?Q?76RzmgIdS0UE6dBj0Yu0LO6O+X0tW+/7zMOJ4CZEJSm4Qp2X3JeQdWso+zv4?=
 =?us-ascii?Q?CqM953xaPsliq32hRNbVF2xjtDjCSlBQPICkUCErIHmnm/yafjVJTkg6XujC?=
 =?us-ascii?Q?XTPSK2dKaNqsudbw0B7mVgtaGJ4oCj+e4FiTB0TKHt7fDZXGMBBkrTweuL9M?=
 =?us-ascii?Q?YEEa4DxLaNFW4a/GocglUR8RFKXHR74DQhyKQ7CycFUOl8Wa+lLdy0GNzJ31?=
 =?us-ascii?Q?8JEDjlrP9JHqwYmDaCzUBYZh0GdMyidQChl7C2Ur4c/D6lhSmfRofqhlRezb?=
 =?us-ascii?Q?eeEKurqDGXCaog0bXp/EeAQ2NfBJ6r9sIXwXRpIUhBrOGzYU39zzcnKh2kDs?=
 =?us-ascii?Q?AELKrnnHOvuNVAwkcka2/kgxKoIXNEAnUrbjLSNcTZ5j+dPskCRaGogWwSeL?=
 =?us-ascii?Q?MdYUxe4je/qwO4xFqXUaqwBefE6Pa6hL1ga406LYLFwbrGiFwA2V2+HkARvz?=
 =?us-ascii?Q?0ghHvF2wkvj6YKkToEaokvYBnH0BfsvkuYV7KXqhVsk/7d+RXJ/baJKRJks5?=
 =?us-ascii?Q?ZeMVqw1qNnoK+TTpQgXrIWUn5ougGCbeFRkPXBdlOGTr5z1++IjOPi3xIK6a?=
 =?us-ascii?Q?kSf1MTJicb3AblNlIZL6+dtuVKfF1lXuZ/RXnAd95vxvw1X6OzyzDFKMMiDH?=
 =?us-ascii?Q?fWcaaqH2rpNh6xUaoKJDfMs7uz1MkIJMtLiaVwkSkkhwOR1Q3Cu/2nNSXd1Q?=
 =?us-ascii?Q?FQbZ94M7dA09rRU9Kmh8FG218p9WltF2b0erutoyTbkamXP2/Ta0ciZoYR/7?=
 =?us-ascii?Q?RCiOW+8p5O1iVuMN7db+fLK8T38Ff4mePtPTHkJfIU64nsH6curUxMiwEiEi?=
 =?us-ascii?Q?BJqTXPcnMQ7d+fsCjYglM/2vNipOZxZHwxOjVsj1BfZis9Iy8bYHkBMhwdpE?=
 =?us-ascii?Q?d8ldEAT5hdRqOjIYVraPcT5K6VxOi3IEE4iMwZqy5hFvKSqgiLSVtcCLq5ky?=
 =?us-ascii?Q?ZRlJf8YPciDlphzZSrW9AGU9icF3Zx489NlUfAopVVQpOfoe6jL6w++ugCju?=
 =?us-ascii?Q?NxTSyR1UnItF13sAeF9JRtUfgfJJiGfX5uy+G/OMVhiFSzg7QIF3IU5nroHM?=
 =?us-ascii?Q?N39xTa+YhggOz+WbhNb+pniump+TN6ug48HgwYtb2/Vmpu8z23nNxnMm0gCB?=
 =?us-ascii?Q?4fsNI2PYsDtA0gvpOT9UyUSQxF7cTg1DoopTsPQzhvvViwU3uhcaKfCx1WxQ?=
 =?us-ascii?Q?RpkeQIIdCGvxtGH9TBnzH+rI7wQMJ5b90pDo+tMQNxGh675JRqrBJl9pshbV?=
 =?us-ascii?Q?3FEZCH1yOhryibgn9Jt0JZN0SO4tapN5KvzQniI/A7P34YOZdo0nJIfo3DFQ?=
 =?us-ascii?Q?MgnJHrcacuxcIUQbrLao68AHTCokZooP4BvdEYQT7q9TDlJb3JQHdK0mK+Nh?=
 =?us-ascii?Q?cqkAJXHO17+6newbN0k5KFil7ayxbHhzEjVHKUZhqkhfKey7NxywXKTfMIsh?=
 =?us-ascii?Q?Q87wufcQgW8xbibzPKX+6YEJxfqCR1WYA1mgirDq1nsWXG+s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b26d80d-c27f-47a1-22fe-08df4d3a0ec4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:26.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJV7v0Bho9W2PJfRDKPlilWauPDeTXw90PWfCap4sLEtBBj1PejDAT6W6ino/LihDJ9mMOTZfE/i+5hhB8qehA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

commit 5771e79e461e72140b752496b69275b9e6bd1a75 upstream.

When a task leaves the BPF scheduler's control, p->scx.dsq_vtime and
p->scx.slice keep whatever values they last held. The slice value is
core-managed and is refilled on the next enqueue, but dsq_vtime is owned
by the BPF scheduler and is never cleared by the core, so a task that
leaves SCX and later returns carries a stale dsq_vtime across the
round-trip.

The stale values are also visible to other SCX schedulers that inspect
the scx fields of non-SCX tasks.

Fix this by resetting both dsq_vtime and slice in scx_disable_task(),
after ops.disable(), so the BPF scheduler can still observe the task's
final values and non-SCX tasks do not retain stale SCX state.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Apply to kernel/sched/ext.c before the source split.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ca9ed9c1da66a..b2bb60ff78d39 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3692,6 +3692,13 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 		SCX_CALL_OP_TASK(sch, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 
+	/*
+	 * Reset the SCX-managed fields when @p leaves the BPF scheduler's
+	 * control, after ops.disable() has observed their final values.
+	 */
+	p->scx.dsq_vtime = 0;
+	p->scx.slice = 0;
+
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
 	 * transitions are consistent, the flag should always be clear
-- 
2.56.1

