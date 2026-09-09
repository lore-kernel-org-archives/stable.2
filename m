Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66083FB7E7;
	Wed,  9 Sep 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948219; cv=fail; b=llc8N+57kBEHGzpbPLEFSbnjBVtRsCBr81SK1tO09LTrpkKlhGj0ItGyREqsbZ+OeARLNxeD+hgwMDLYgeX+dnwjQcmCES98i4TtMCTmbo9B7hNv+vqGAdHcXlThpzrJfBbL/OvuWUw029PtkrSG/wAXhufW1/5dt0tE9/zdJTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948219; c=relaxed/simple;
	bh=ZocE+f+U0FYkI8kLqXLBE0e27dV9j6AkPG4VSu3zYSA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m6+7O8TN97LoE9XaNEx0yE9xhqF3G7/4wEHm42PyEzTg+hGl4Ct4CY5BDpCMq3eJo4WGtYRxItOTUdRNc2sCcTDMo/RG1NnWRe5V7naLABlHgjfzR11J9p8XIaiHqMaoxDkmeQj+SiNx8G6wpu1xPawJ3zTLkXm5jg85stdqbQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ETMEaRGp; arc=fail smtp.client-ip=52.101.61.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ETMEaRGp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbTbtDjMRfQ3IosC+kmZbGW47Yb5Rk11SJW3uEz9oxXPt8LhCczYSdKwB87WDc0obdNFwEEF0X7CisJALDcyPACDvM8Ly39hbrxxcwWsuwnaG7/gOkeQ0Tyitx3JElOUv98iTKzR2lNFshOGhUw3/lNg7Ob+JH/u13FczYkaENwSM5ST4kKtujajLlrDdciGlos8NCl6F7a5Sc46s715w0ApsWgYMGk2WvrelDvRkQriXupl2yFXr0bxE7RbQl+TspwYAtYfIy+6kw4uPBagGq8yEGmS+71IsaBCHfFA54XxmcB19QRc3D6EptkZWCm9NYrGaQRlH9ltMt630/8rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmtd+0OJoztfVMWhTfFYOWu7oPNFOEDnMoQWOUwfNGE=;
 b=XEX6pF+l22Vb/quYN1ciXx6yYPORQuZzixBd6XPoeKr9RzplW7kxQOFb7S+GkzUnV4wRirAtPaGZLHCKHyHG4pEGsKuLytWl1IqzbFOza+UcuWvmzdmOcWNaFC6DHlBw8jcxaElMMZcuZ7D7lx7jKMBrmzwH9z/ZHakY+wing7Fdebbdk1ESV5EFAIgl+Nt4oseHPmNUdR9tuzHoeTx3Q6P10nnODoJPDWcDfEo1UmtdniYdVJJyAkQpqqn8vjxrC7P2h4eHReKGwA29LBI6bRmyaKbPY+zsAJ3+50yYmcNyyV005EkX2qeOnKK7FYrEiIX33ObYS3KXuCl2vHoKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmtd+0OJoztfVMWhTfFYOWu7oPNFOEDnMoQWOUwfNGE=;
 b=ETMEaRGpYVUCc3T2gjbIktXPywx0VZ7nUcXp+THy6qE4yj/wmyIhwEea3OkndA5rk+Or6cBXlUrjwBbfwTZ31QaHl12KujBCwSXukXfp5WbxfH1YGa5UwIK7tkSRF2R628X8FJB+sHyzMpVz6BR2xwOjuCuuUE5z5M0tqIrjDpUavxwLhJxHazcOY3e8m8dK+IPTJFDn+KAKZ3+jfy2VUOsM4k6kftcGOpOf8sFFeMbyPUi357krqcTmN/5Po1eTczco1mDZ1EEgxJbPDNXELTGVmO8+67Qxy14fovl/stTk49QZtmnljIWqYqgfRnjFpv7rUCpFI8uOsAzgBlTX0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 10:03:30 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 10:03:30 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: stable@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	netdev@vger.kernel.org,
	phaddad@nvidia.com,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Paul Saab <ps@mu.org>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 6.6.y 6.12.y 6.18.y] net/mlx5e: xsk: Fix unlocked writing to ICOSQ
Date: Wed,  9 Sep 2026 10:03:10 +0000
Message-ID: <20260909100310.1941561-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: d9da2aa9-ae6c-4089-e3a5-08df0e59998b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|6133799003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	t5fn++7q1ULd/6bdSGRxT6rYcMuE1eTJnU4RkYV1UpV+pqZu5WFdzrzMqFgcognVZszZ0bx9PMki690YOH4360r0n3EZXNxscEX0n7JR3piqDZo9es6U6P+OCCz4+V7Gu29R7nI3fBgtCXI6H9yVit2+7g6lDuEQN854fvjofRH8BFfl6YQkMagmghIt9LkoCvU86iNreZSR9cM66T9WyAQw7VmHRxhsbZ7CnlPLB7XaWoXPASZmImdXfG9n/nJWz053O3POIt/HscExnto+mcNraIU46bQZ2tBV9BrQPkuLtRRLrjZ+qhIf/yXcWt8taeYSoHrjoaMRf1AP/XEwGMmJ6mR4Wm5cOTvp5u7INcC4VKIaPwrIKysmHMX1ICtv9gUH2S/XIJgC1fqH2MyoAiMe4A+85BbkLwcXd+LHoWuQhrcOHSByyi8JyMG3oNMTfB0vP9i+weeuiCCAtoW4aiXovNihP1anTyS+LXWEtFxN4GmQEUx1qa748SxDxx2jjyECgvQVpmpczcTl9jgzRRbi7OSAyVGI1NUtGKYJuPyHZlYdpuoLPG0Hbnf1ZQaAJbd3kF3euW48FIY51jF0kSv4QXYRJ+1uN2KF6h1sNBwnluE76iAbwBvPs2neO9WzHvfxrPDoqtpUevDp0HWJz51/whk39qaltLCrnsW6t58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mhh1Zi8T7lAkTzVJn5humlkfbVD5CD3bmFelpnEtvu8DTnxF7s40u+KJ0+UT?=
 =?us-ascii?Q?nQK7F1k6EB/NWj5yGu0Je4VL+Ds+kFzqTdFfj/93wjod+3Vgpw0Q3TYemWnq?=
 =?us-ascii?Q?FKNUrWI8CgvsXimnQyegDF1znATGoAbyuh1vjwuwKCE4cvKScANp7tdX/36A?=
 =?us-ascii?Q?Aod3T3KGPWBT86TDY6PrExvZvtUnbB0n3ZIdI8bVcImFg46D0TT05IBkfd4y?=
 =?us-ascii?Q?eVPmUVYGaXYISx2PcI9gOB80hxvs2F5s6FtnYCLOXRK0PT3WNS6qFDUqWuVs?=
 =?us-ascii?Q?KsJw+fyan4JeW3qK2jDutPLbhdb1IOg/27vsQ4MTefAxKHe/02pUcPTokO/R?=
 =?us-ascii?Q?2HTlR7JolSyxUoqf2xpy9bo4+BnjbIQX6YjtOhFKyNLgKEaJaefLb2kGRNAw?=
 =?us-ascii?Q?hzmZJeTtSk/hMYe3bXK/vy0gJziPTP3pYnV6MElJw2hrQa1R8rBfaIhq+RCn?=
 =?us-ascii?Q?uDz+ng+qAou861WF4Pabj79MVVna5hyoidvOTIVcFyEYFrZLwA5Jggz+GDnv?=
 =?us-ascii?Q?6BuCnXRpYMa7rWKUUxIOz740j5p9sqHBGq5lqX/QxLdEQRMA0+rRgzbKFcoA?=
 =?us-ascii?Q?CEaqY9d4GYUyzQ77we1oEBp50hlaWQh07TmMjgub6cWSS5xGI3k1GWqBQWK6?=
 =?us-ascii?Q?SW6Chh1RExi4z1JbBLWIQfJliE5yabRD4B56led3RvZCVh4rqKCYAOv19AW5?=
 =?us-ascii?Q?mtS9YV1zubaY84jYs6zSr15PRdFJMf79OLsC4V95mjJZr4bqT39DBPgUfMXJ?=
 =?us-ascii?Q?KULZxEcSIFo9aZ0h8YFMcmZFHrtj642kaLAccM4BVDv620EkNG4gs/DbEgfv?=
 =?us-ascii?Q?D2MGgfBg7QsNhR2loE1QD+55k4Rot8c0v8KAz8tlzcuh/2Q02kts5cojwWpQ?=
 =?us-ascii?Q?XhHuKwgL+crYq7dE4HHSdzV55tTw5stoSgvT8VveTxeQk7kiJcgC7ZG5mOMR?=
 =?us-ascii?Q?NiO/asE1vZeUSoscuzSixAcRHdTmPr8SGOm7epTeoahxMw6PaukDt5/2todk?=
 =?us-ascii?Q?VPE0NhS3DwfDZB5y8jDlYZ6UcrWCu3wSw3cKWDdywoTpzk15KjY08A4wLt1H?=
 =?us-ascii?Q?hqfN0KPubvmy1ciPkirrfgCg62wp+K6kpzGbf5uo5Hb8W6cLE0kCss7dZ4C7?=
 =?us-ascii?Q?8hJE1AWypN8XfBnPl+f8vZPzPHQdybWsSOPLu83zwFTV4tKZgQrLatNeGmEz?=
 =?us-ascii?Q?tjIRAjoSAbukTU3mGfCyrQPuaUqhMFh3TXDQ0fj8u35DIt46KA7e3VrjhKEk?=
 =?us-ascii?Q?B5cDuQajRhZ/S2mq9cTFd4JNq8Ey9j02PCMLyvjHwP4ssU4yt2z4GBuKPTGy?=
 =?us-ascii?Q?/cp//iRHcByATuDfblwr0pdTETOBcjvvRRwkcsOA+S3XQDIe6Yxb5QAy7rM3?=
 =?us-ascii?Q?wjkm7sp7vhxApLQm3w+3zz22hfX/ZyezqREHHYx99WZImG63TDVJC1Nrc+fO?=
 =?us-ascii?Q?DjlPdX3Xvldr1kKll63mbuBR/eF9fAsPr7X5As4rUgfWDMQLDkrnhI7c8OOm?=
 =?us-ascii?Q?9XYUov/ND1r4PBV389OmvXdGZMmqOvG9f/7uCmKonGUyUHplukPTm85bIUJW?=
 =?us-ascii?Q?fZUfqoQ7VGxkFyq6d1kpNnIdKVWszVTQ53MinOMhLc/Av1Iny2b2jQtAYIFH?=
 =?us-ascii?Q?nivTWsRT+oXj0YCQCDImK4TuJbgPK+2XGBpuNJOH5Ul2V9XL2EtbhaZRm8Hm?=
 =?us-ascii?Q?g8NteBgt8uzE4wcJMXNITVtN8wQSy6HMfTVbNBLkawBEuM+onpIeBYFznU7O?=
 =?us-ascii?Q?bRqoghr3yg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da2aa9-ae6c-4089-e3a5-08df0e59998b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:03:30.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBF7fgUs/iS7SUbCl9i9nrcOCDzjZhtLf2OCeZtGL/rzq/9ebuBfhQZPzH1t/XNUyL+N747gndD7vg6LqjNiRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742

commit c326f9c68921e2f14dfcecb2f6b4216313d50248 upstream.

During napi poll, when the affinity changes and there's still XSK work
to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
triggering on the ICOSQ is done unprotected.

mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
running from a different CPU due to affinity change. This can happen
because IRQ triggering is done after napi_complete_done(). At this point
the NAPI can be scheduled on a different CPU. Like this:

  CPU A (old affinity, NAPI tail)    CPU B (new affinity, fresh NAPI)
  -------------------------------    --------------------------------
  napi_complete_done()  clears SCHED
  mlx5e_cq_arm(...)
                                     napi_schedule_prep() sets SCHED
                                     mlx5e_napi_poll()
                                       mlx5e_xsk_alloc_rx_mpwqe()
                                         memcpy 640 B UMR body
                                         advance sq->pc by 10
  mlx5e_trigger_irq(&c->icosq)
    wqe_info[pi] = {NOP, 1}
    mlx5e_post_nop() advances sq->pc

The obvious fix would be to lock the ICOSQ. But the ICOSQ is expected to
be accessed only from the channel's NAPI and has no locking. Kick the
async ICOSQ instead which is always locked.

This issue was noticed in the wild with the following splat:

  netdevice: ge-0-0-1: Bad OP in ICOSQ CQE: 0xd
  WARNING: drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:826 [...]
  [...]
  Call Trace:
   <IRQ>
   mlx5e_napi_poll+0x11d/0x7f0 [mlx5_core]
   __napi_poll+0x30/0x200
   ? skb_defer_free_flush+0x9c/0xc0
   net_rx_action+0x2fe/0x3f0
   handle_softirqs+0xd8/0x340
   __irq_exit_rcu+0xbc/0xe0
   common_interrupt+0x85/0xa0
   </IRQ>
   <TASK>
   asm_common_interrupt+0x26/0x40
  [...]
  ---[ end trace 0000000000000000 ]---
  mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2022, qn 0x8f4,
  opcode 0xd, syndrome 0x2, vendor syndrome 0x68

[ Backport to 6.18.y and older: upstream commit calls
  mlx5e_trigger_napi_async_icosq(), which was introduced by commit
  0da1dba72616 ("net/mlx5e: XSK, Fix unintended ICOSQ change") and is not
  present here. In these trees mlx5e_trigger_napi_icosq() is the
  equivalent helper: it takes c->async_icosq_lock and triggers
  c->async_icosq, which is unconditionally opened, activated, polled and
  armed for every channel. Race B of the upstream commit message does not
  apply, as it concerns the sync-ICOSQ variant of
  mlx5e_trigger_napi_icosq() that only exists upstream. ]

Fixes: db05815b36cb ("net/mlx5e: Add XSK zero-copy support")
Reported-by: Paul Saab <ps@mu.org>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260513064613.334602-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 44547b22a536..799414c2cdc8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -245,7 +245,7 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (unlikely(aff_change && busy_xsk)) {
-		mlx5e_trigger_irq(&c->icosq);
+		mlx5e_trigger_napi_icosq(c);
 		ch_stats->force_irq++;
 	}
 
-- 
2.43.0

