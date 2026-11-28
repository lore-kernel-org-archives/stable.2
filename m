Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795861598;
	b=grHIyx107e+X3iplvyk3Wuo9S2eaO/lzR84FO+t26LwsE51xVr8D47COx5+diryDYbMB
	 2FkNZx2MjXKXlocQ9+T1e3d2LuivPZj4lbApNZFvAHoHQK/3G0nxfSjTKeQobSZACiJRl
	 WA5AtcisB1JaiGdUOTzq8xCuTd1qM90Ad/nGeNIEkBM6w4A3xTykRIA8fgqH1DQmCCIuq
	 Op1p6CisQguxNtRg69K3DG4SzKT8e6Tqw53w/N7htFow6fV1nlbt96iAmM9crSwTctTi8
	 rlSjXCmtQpEcQs60kiPTt1pLdaGc6A4+Vz/lsAnW4ke3nDr86i4BzkzjP0lqll43W3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861598;
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
	bh=s5XPCW/Mh4CUSluI/t+qX99JFhZuAox+me2UHy1901k=;
	b=jvRT9hVzPTfZhztrierZpjtLqBGj36kN8E5ZUVj3exyZhze/+YHoOJAlaw1dxyxWOklr
	 hkgNw+HbWpLV3Bj5ZstpAZwk43tgMYCMQyTGj+UWxfDQ051QHopz+t6OtFgM4G90aPZFt
	 isYCLwuCIAyenQ/1GI1vC9nXlsOIs+uUtQg0jcZPZSGafwH8BZ/EbLhmfLBlp1iR45zOJ
	 0to8rKd6Pov2yA9mlq4dMCjoMN4CbKEQekOX2tpY8HW2jqC0E6tdgEDuF0bxqSiz6C+dT
	 ddaV/6qqZPgW3R44IpnbCmCyFHS308ctnfjP/43hKh4nvsPy11/+yyoP6AB7BbToGVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="ZhXNU2/i";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.23
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947B606A32F
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 10:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8947B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZhXNU2/i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgWsDtgrOkHuqGeSPFoMdUNRNy5F7aQdZG+xrNkldSwZm3xKH8lY0mbWD+W9XzXhSrR5XHJq8eCVpVIDPM+PyXPhj99gAK7Mb2Doeu3D+lkSG6jCOyaoRaxR0MD+x9weWH+EtDz1/xZutYypS7QomgsRIfbOWU6IatxKMNn5VMfUpyqH6J+aRAjVlTWKjJYV6zQHoHSIO2bRhBaXSilgADld4riyfxDAEeCrbB0+4PfJpyHEjIZhMysatXITHqNIob5lPnqWi0WPP2rVRuiQbiQacq6MXi/DJxV5EDQGrC0e+YscvqKIZ8RGZ1JG4MfWk2Kpu0WCaNIqsHc1pwTf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5XPCW/Mh4CUSluI/t+qX99JFhZuAox+me2UHy1901k=;
 b=nbOdIbnnFbXNgxvf8HPtLcR9+qe6N1KxZX9L38BaSaRtkvuUcYdYsN2MHLOdz26oRkXf4urRYnb2FCBqgDrK0yTsSx6l1InUiiHGTYravAL09k208KbeLKKRFEgDIDfsZknYkic4i20lPXaQtlQ2hVXmK0DiyqNRdV5cDJIDq8yALtdTC9lrCEuIQjXIvNgFdW6NpsqUcuEGjn401buWBe2JEkP0+prGee0KxBZ+eIGn1dsRjZ9jb8a1fmgsXmJVEK5/PLZ6sFi2FpBXqNi23HNiKsTO1ANyOkF/x3lTBPmcMcxaSVYa65vfrt+XOAkacgpyG9URXgODov3OvxJeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5XPCW/Mh4CUSluI/t+qX99JFhZuAox+me2UHy1901k=;
 b=ZhXNU2/iYQeHDhc69lhVbuT820tHaDXDar5cubHCGwXBZLf0lgk9p5fEGrTM4My2B3ieIOmAvUGV8D/jcvN1SD+zG8OI0EWT+gxA8ztfuZkxFGIjteWO7G6Ocezq8NOYnc3s68D0cBd3kUM+Pk78tKZfvt87Fd+QbwIP7OgHqgRgfgPKJUOBcLSc5CHCZnonKXdDfraG7OMtBvZpvajyU2xnBTZUzACjnQ9F6DU6cgBVx894G+gVppQAMiwyVo9gApmKqdxjapmmsChTboKyTxAyuu+zPLJkuQRlgHQeDlZjiSQiqsHQz5ZC/2eSgthnyMMTEncGUsKFHjNhy2Ombg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 10:26:34 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 10:26:34 +0000
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
Subject: [PATCH 7.1.y 8/8] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Sat, 28 Nov 2026 11:23:51 +0100
Message-ID: <20261128102535.655465-9-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102535.655465-1-arighi@nvidia.com>
References: <20261128102535.655465-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004EA5.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::45b) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e4de6a23-ab97-4401-2585-08df4d3a1396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|11063799006|261009223027099003|18002099003|22082099003|3023799007|56012099006|10067099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	WB5hpIesiX15A/CL+VpjFJXlbjfih4V9KJYwcvC+VeI33/K7VepXuhsuFXzJG5jXKIIwOLineGl3Yzp6JHVNAX711XIXfHdKcb05PvPURHSEtEU1EsQ6BFVn1Pmjun2a1iFzeHrrUK21x/GmkKE3l/V4RZkIUqXClcBa2YqbeC3VH7xDc8hxFyV/CC0zGaJI9RQ21D0M4g5j3+TpLyQhUUrhFvOoqKLnv+WiwC/QFucq/+5pRtk3RNbtoGsUtonX4hZNr+oKTel0+Uy4ByNCAMWsYZHeUV8r0gFb2902jv2NR1CrCPEEJ4cq1sVxJEvXLmmr7bjWNoJPj2YDn0wF5k/rNOY3VGxSFT48xfd3DcSDQNrePhbPHocNZmHqoYMNgffLwDkttbEBsB3KVJ1AhqkcG50FThkr89H5dv0EhuaPRuHn66ceGd+Okb0HfcWK4h3vBY07vYSvmAH8Ucp979X3EYZHnAIJR2Fx59f56n9ihvTHE2k0lXnSCljKbcihyRUVQbPcNy3auaP39qW868Al+nBxNdj9aT5lZhY39gHRsEWtDqU7qe0MivByrUd4Qc9pfku6ryYPUPKD8PStklMVf+pwj5AFNVjlIVvBlqXUx833PSPlvmVMmtjLvj2KAvRMESetKiUr5Qu792Z08PgnO5HNdmtkOqjj2DrRhOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(11063799006)(261009223027099003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cmHv7h2nss0FEHbq7u6WzMuhDAoTwTjD9yBzI7HL6keVCNfHqQvmWdXcQWKU?=
 =?us-ascii?Q?INUMRSbboLqRUgCwcU7/NvqdHCLtddnTtjxcIWnh9fH7+s2NT+yHXjLq8aP1?=
 =?us-ascii?Q?bSGQPaK7O4Nev5WyRQXKcOlr5v9sIfMWW/Ullpa6u9Wtga1tKFm8S9E6hRLG?=
 =?us-ascii?Q?xzqIQgWbyAj2vIop9szv6ZsvLaRmwGHgaFJSJy749Q1z3hcnaghM66aSBhm5?=
 =?us-ascii?Q?vylROGlFbBjUPIuxPqonTzdebPz+jDPWL0y6YQxU5E5zjcptwo2WAfVVij3N?=
 =?us-ascii?Q?u8VFmTLfWJda1rQyZ1QEJ5lH7AWIUlMO4iSmrf+pOVWlWZfMzNrq9HUPzXb2?=
 =?us-ascii?Q?PwNO8q1Xr9OMIbSAld+XCQj5X8jLGcFmwzo7AEZTSMrvDM0SvYrFc17HmgI3?=
 =?us-ascii?Q?SzaFmrsp4MGM4mq2T7eE3AzXlClxw2GojfAhdfk4hZ8dIBBkFPjlDw8gpinJ?=
 =?us-ascii?Q?S8UEHI6XKBCSZsrykxOqKSrfxLbyNdc58ligORBa7PnLFmk7wckbaIIrFKXQ?=
 =?us-ascii?Q?9TjLw7VQAFP/T/0xWZjmqw2krt5nEzgBKxa1KKrRkZYUWmjkN+4bfPH7EqNX?=
 =?us-ascii?Q?IMPsuasWj0S6syMb5vc6Nu7KwPvu7adnjiA04JDkxfg6291Yo2mqDO/SlR95?=
 =?us-ascii?Q?7KoSuq9leYSgD0KG3MXeQp4GHOF2TlNzyfTEUcYJYWHS8KNlVnul9mTYcIi2?=
 =?us-ascii?Q?bwlPTvZ6HdQSGHzY4eHHMzEYcrr0CmzMFUFQozRdiKpTo0r6m5U0K/oeWBDM?=
 =?us-ascii?Q?ageCVH+uG4W1uq4HSbcoVPH7khG6ynvuzIFYriuPJ1VZVxA9qnLKyXO9kafn?=
 =?us-ascii?Q?XZWz7WisKpC/A/8Zo/2mrCNW7W2zr1VPCvDbmfHGqzTUdOe3wCm/mvpsyzpp?=
 =?us-ascii?Q?zvEPkKrkGD014OETHCVw8XJLik184i9YiNRlgyRWexlX2DH3DTcYAlbUYiIf?=
 =?us-ascii?Q?/bZ3G0TiE7FpW9k9lvAcA6SrDLtYy84F4qjHo4q656kdUyx/YEKyKVCKu5iS?=
 =?us-ascii?Q?BdGwpILMGxLDI7RsQO5cVjgL4PYej7Wit9qxKIKkE/m/x7HAfsxLA/AgbBWa?=
 =?us-ascii?Q?0/ynUNisZ3kNvEoWnknEx0JBDTkXZBDrMPz7k+K2dZW01e7oCH7gHS4Ilpxg?=
 =?us-ascii?Q?9wcrw5yBUWVKRdI3Z7jDlOypjZS4WDWnSaFbQbjbjE3eBr5AaEjCEWoz0Bjy?=
 =?us-ascii?Q?wgqtLJvdNOYUeX6iOzekyYrHDg7GXwChdvuZhJgrDuf4JNtk1k432KjuAou/?=
 =?us-ascii?Q?2y/Gwk+euTQ8Q3BoWBDuM/OOHYnMvMFEJObju0ml0siYcOsoTCaemJhm6eg4?=
 =?us-ascii?Q?odAb9MZjb05zCO7G+9FceOoHWrJA1XiamgvdTREijwavxAtIADiEthL4kX6x?=
 =?us-ascii?Q?8tAUZ6ARjR3NKQE48SQpYfGeRDDXhKvNU0sZp7NohCzk4V22yzfQvBfaIM33?=
 =?us-ascii?Q?srCl5siQIXZd3myLzjv86Pysj244zvxm7La9gJZZjKn4UuziOdBEZ6NW6eJN?=
 =?us-ascii?Q?vBPvM2cIagtGI6TSR2xjDGibRbaDVZ491JUSUgrfD7HiwfdEiSE+UNpOYsHD?=
 =?us-ascii?Q?kDZMWUszfxsxC76A3DGg2fBECxRE9WZlusCRv01H1KcTZi3W5bSP1uLbp9jB?=
 =?us-ascii?Q?iijmVJCJYP/Ec7laqFCsyqWEmbmhGDlPqgJhiz5PjtGvRa5w1sTT9oKYYxd5?=
 =?us-ascii?Q?GKaHlVG4UzQhBpocroeMtzySzkvjIwPAzkBxQIwIUnx6Od8Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4de6a23-ab97-4401-2585-08df4d3a1396
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 10:26:34.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmEw2uTCUbfvNDLDpZF52qZH/4DeX9zaD0w4oh1qjZDOsi4plrx8NGjs59uWVUre5neJXD6O9P/hpN4gulehyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

commit 564405c424f49d70b13debe7fe5b550234ad6b84 upstream.

Tasks in SCX_TASK_READY are attached to a scheduler but outside the ext
class, such as RT/DL tasks, or non-SCHED_EXT tasks under a partial
switch. The scheduler's BPF code can still update their dsq_vtime and
slice (for instance, via ops.cgroup_move() as done by scx_flatcg).

Because __scx_disable_and_exit_task() currently breaks out of the state
switch for SCX_TASK_READY without calling scx_reset_task_fields(), these
fields are not cleared when the task leaves the scheduler. If the task
is subsequently moved to another cgroup/sub-scheduler and later switches
to SCHED_NORMAL, the new scheduler's ops.enable() sees stale dsq_vtime
from the previous scheduler's clock.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure SCX-managed fields are properly
reset when leaving the scheduler.

Fixes: 5771e79e461e ("sched_ext: Reset dsq_vtime and slice when a task leaves SCX")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[arighi: Reset the fields directly in the older ext.c exit path.
There is no scx_reset_task_fields() helper in this tree.]
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b2bb60ff78d39..c5124279ebb38 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3724,6 +3724,8 @@ static void __scx_disable_and_exit_task(struct scx_sched *sch,
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		p->scx.dsq_vtime = 0;
+		p->scx.slice = 0;
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.56.1

