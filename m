Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F356E07C;
	Wed,  9 Sep 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963242; cv=fail; b=ovOwKviGLH2RFXB1HU5v2o++5r4APs+g3Ayr/BKbutmBkMbgKfvRSUiuw2vBS3E92xCG6hPOwqiCIRCqmLOArbQ11BS0a8WiMUfqQrCwVu6TUbeBItE+L7zOw6MDV0euMYXhU9hgjdZEzfcT3hBdIxu6XxJ+4RZ1yp/buRva9fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963242; c=relaxed/simple;
	bh=5njJIrytuLTXkBTvRAAQXc4pnS/xHqftzZgSpdEoKtI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C+MoEs66Ui7SdmIeG/WpHJ3PxRCsdqW68zXVFWXiYUabysrgTgpwK5DYF4t23wzFDtMfVDPbocbO8sEBLYY3HBKrm924C9MJmNEc+LV95BVXAkkDc/d1a/0aBg/1Z0oEjzxdGXpRancqP/eoRAUBrhfAP4K2err46W+rK+OgSzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Meiwc5pp; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Meiwc5pp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upQd1T4+LNbXn58xXX16dbZbn0YrangAfUL8T59ZJFLr1zRlTNjSGpmsueWqEVNfgldPssK2UkUMGuZsWd7GO3xGoesD06PXRxytF+RyEJUg69+6aJ5Ddtn7tO6eTYEGTWCABfgjKAWtcy9kybKnG12Uy1WS2UbFUQe+nU34rTdTlwnixgUo5Ug++EgfAskwujSLowotXLTvnVza/KtAKp/cPMQjLhj+MCxmYtbf1E3xBCAYkKwTJoyZpRbOs4IlGank32JpkdJxpSFn8RQQ8se/tDCq8UgstKG54g3ydCaNHq0FqqVqXpXWyFl34LC+I9EQoQEOAP6/UmkfMCBu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG+UYAXSYDxZRwJSHe7Gufkyu1JMtCIJ0WgpwsQ0PVc=;
 b=uYSb8ne45RyRRbvdMI5yIarX8vnUa7vOVdUsEgPaDGxKK3GshHN2cnTzyM1O0g9hw0ce3QWIKR5Gv7wdG5PQBcwgSXKaHYsP6AER/wyYeAzb/5m5lOfHX6JHWBG/8h10cnl5b9xsZnVw9iNUgxrxk7+bF52ODm0sYhT9/mN8T/qs8OTEBa/I959HaYp+GDewoB06gTIRS2L7nk2mrCbO4gSgEEGBHrhwg5pGPprtFKIS9D54voH45SWQwMDESLlC60xGfbV5y11nF2wMUlZxoj2t8u+GxVFmRf+MRsNvUFXiNTR7uiO9k9anwdviTRzogg/vsqZxHXSub4yO9NzeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG+UYAXSYDxZRwJSHe7Gufkyu1JMtCIJ0WgpwsQ0PVc=;
 b=Meiwc5ppKUVS7b+MvHg1olNyLceum0zJl5CzKl+TzKhANLQ2+CJbYYVfraG2q+M6dDw72qbyglL37ZPe3CTtpoNICGYm6BX7gtQ5cjjMQ4UP+hW6HhtVg3VPFlQxkC76sxF2Gaak8j3UQY6XhYYA+klw71VgAsIuLeM+R8M2+sxK54mdXBChIxKzVS6aO8VbWDW3eQr2EJkiSmjltqnJt9Wcac/shk0MlYC6e/mvv4tPCDpDmAqWgEx3r1tFZ2zFCUWbq1t5/cUTHlnHj2SRiI/rGpZN82rarBhVe5wJzYruLo224scdKKSNpmo5hYajGbMmC7t4y87IxLnXQC/doQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:13:48 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 14:13:48 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	saeedm@nvidia.com,
	netdev@vger.kernel.org,
	phaddad@nvidia.com,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Paul Saab <ps@mu.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 6.1.y 6.6.y 6.12.y 6.18.y] net/mlx5e: xsk: Fix unlocked writing to ICOSQ
Date: Wed,  9 Sep 2026 14:13:32 +0000
Message-ID: <20260909141332.2297825-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e00e79a-aac6-4470-ec98-08df0e7c90ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Dq5V/a+qFch5EJlktQH6ldkpDKaJT4IxXfr22HY8ZYCNqbaQBcHpf6dIQdz3SzQbxGDo06cuObN68LuxOIjwODP/fvhwaffl516+xDUiZ16Xz/y/Ya6Fcu8VAVhQNSY8rNXbpb+Pc4vvbKcjuYijhX2PgWpPNeQ2pYTKQhRPKZcYd+maMtk8Zl1KckQtsR1rnFlG5RaDgCNsKrlW7mod5yUiKOdyZvXUGvSHecZ/jJEzLdodALGb/7RzYVuMTgrKvwMAT05DhCZ/YL0OpG/7AXnjD4DylIp8O05D5Otn4iNTVkoaeanA6uLqteNH6qT5WmOwQ7OYwHNR6K86mjaTLmJ8DNydE0VIQUlvWtmYxkz4pl5lngECjcTatmjPzxlghmo5IHfyU6HHOFYOjdMqEGB6YP6bg8oQI9bkjYQ/R+3DHAfBqWCdd3Hj2OYMkpn4B8OTB+85dSraO2CRyOf+Ue1fJ1wiEsmo11sd8CBCyYaFEYRQa55ydSYccQQqh/VCCYHb1hjvDKlmtUqKPlEp3JyGNuv/VHeYdLhkEBcH3Z65FWDu6OtruurBTBUvdJ0T4/IKDaVof2bPyHftO8ci/bIsf8eSyNAr0itvP8ZDiDYRIPSXYNu7WzSSQFPmxOrjM/3xKMgbQkw+046msLIL9yj+sYiVC8vP1KDQ50AqdU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wjrc4gW5JNSI5FKo1NXyxBWEjQPM6F7oE4UvKmDAtKZ/dNbrItON/AksVHWy?=
 =?us-ascii?Q?jQczNTQKX4DtZOQj4zqLiw4RYoiE0Atzyi0qhboYZH+7ttxM3hBIENm0Ej1w?=
 =?us-ascii?Q?Zm56TMi3s+wIJhMBBacaA4n9m58n+3xs5euLbFwAzRCJu2dyrAir9MnHZNgX?=
 =?us-ascii?Q?5zV+Ryqd12/me41Y/bFpv8Y+uV70OVu9INvlAkKqPviCgF4BHDY3gX8cX3nN?=
 =?us-ascii?Q?Aje7KE9DLQenithyKIJUby74S3tqjMFO8YjKF51iOy/74DJM7RnAJeWtlJgF?=
 =?us-ascii?Q?fLmlc3MB55d+hYuNDKLhLBaCh5ckwJAvO7HG8mJ32vpyMRwzQd2DVv8vI5CN?=
 =?us-ascii?Q?hHxbFGe7iZiHA+2KktY3ssDSkR8emdSk6W+gweesu3UTL9udF2ggKJ8uOHWs?=
 =?us-ascii?Q?WX3CBH5ESHt/g0cS5z/XcSQWxEye/HAF5Cpk2dCpPZrfHs4Fnevdi7w/Gsq3?=
 =?us-ascii?Q?5G/SMNB74DgHd5lK8jgRH0pqB9uDfUAr0QvU0blGj0LEIKiQmwDYqhSupIaX?=
 =?us-ascii?Q?z4uakWolbZGAIacfh8al0Dp3IopQx1HHmbmCP4ZZ5iuFTiniR4uLmhi4IWJa?=
 =?us-ascii?Q?/r4q/TWoVBoP9GcwdYE/d5ySZ+8nACv5lKjWhOI3ejYv5TD09KYu0Oe2tpJo?=
 =?us-ascii?Q?AX2d/ECZiYZkcFJoRZYWIs8D/8YJMkaLylEFaNVErXUTfxxx+3pjO+hr5uEF?=
 =?us-ascii?Q?px0F6xiMPB4a6rWjWkB4MPLEUyQrVxGoL139qH8pXl2mPyta/gT4vQaKqATx?=
 =?us-ascii?Q?1X4hGG48I0DHvdE023BYK+iKekurae2YaB6P+NfTSzVRSvkfOkN1nQDLRdH3?=
 =?us-ascii?Q?xVxRrlckVBwy/iHrswoISPME1QdvuvqH0gr0hfpWIVQrgbvh1WF57rviasrr?=
 =?us-ascii?Q?4C0+lj3QTCKoFoyZP/2Yv7C2xiijpgUsXY9hRbN9pJM/W1Z/OtMLZnslWs3B?=
 =?us-ascii?Q?TLbz12fwxzRZQFOKJpVdqGd2zWpxQHhHNomabKwkZKQCIyjk9KE66PSHvzn+?=
 =?us-ascii?Q?E3bDSo545XUp4Eru0shilOIQo1UyuF05wTXBv0o1ML7wOPdm7XlDHrLynFWQ?=
 =?us-ascii?Q?/dVZMP7xBXTygsPtwIqvdnLEIfk8sZOkXB56NBd9S6WPPzBhBBVOebCvq2fj?=
 =?us-ascii?Q?uLRxRuZ5v/8fVNE1ikOTEPsOg/mnMGlaUGvl9SbQqa/9DMe1FaMOjGGc7vXa?=
 =?us-ascii?Q?ZdsghVaksPn+dm2vQg6t/wK3pcEC0DxCE52TVTAg+vAUmAZVSvsc8qrkXoB0?=
 =?us-ascii?Q?/eWgtXpxtzxEhh2lt7y8egrZ/LVtmHltVGA8xdmVRjqiz8TMhc+T+Qnmi3Zf?=
 =?us-ascii?Q?FOzrIAi5qF27VSuYXnSID7IDiR9aEUcumf0Rl4sIsCY7hRZlT/SdBXJbtOaA?=
 =?us-ascii?Q?lcNLnUN49Q8LDGEelmkIa63PxVqZmP1frb/8/7gCcafnXOfLwAGwsPbgVNmB?=
 =?us-ascii?Q?3WXfGW5O62SYxcH8DFyrEWEirlLCX3LpBjZKn+WjnH4LJYw9Vx3lhP1439gH?=
 =?us-ascii?Q?6npoDv2oMDbvQcjRkOGEisJEzDxXw526LXTcC3Nc4wKvTqzBiMvQbMCIRtZT?=
 =?us-ascii?Q?qLF+7urOCbStu8xGkg6YTvzeBhwI7BwC0JiTOFtGmOQSCVSEMTzQc01Y4n+t?=
 =?us-ascii?Q?NDdGFhdZPZSR5azX8DO93yy+cg+JsCXxuDvchVrvSDQsVdIqIltsial16fBq?=
 =?us-ascii?Q?lCAYSutKUpnKsb8wDTumQ6KuENQ1dGObAYDDba3EmnWPz2mwv2VljqNuaCXX?=
 =?us-ascii?Q?tsQynwbYrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e00e79a-aac6-4470-ec98-08df0e7c90ec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:13:48.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYP9Qjwd68JMKj2TN0zde+xWSg3684sFdg3tI2j65JU5IlFe9JnadOjZZ8JFYKUne6k4K/2G9zRjKfYBaA9YMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

commit c326f9c68921e2f14dfcecb2f6b4216313d50248 upstream.

During napi poll, when the affinity changes and there's still XSK work
to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
triggering on the ICOSQ is done unprotected.

There are 2 such races:

A) mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
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
                                         mlx5e_icosq_sync_lock() // noop
                                         memcpy 640 B UMR body
                                         advance sq->pc by 10
  mlx5e_trigger_irq(&c->icosq)
    wqe_info[pi] = {NOP, 1}
    mlx5e_post_nop() advances sq->pc

B) mlx5e_trigger_irq() is called on the ICOSQ when
mlx5e_trigger_napi_icosq() is running.

The obvious fix would be to lock the ICOSQ. But ICOSQ has an optimized
locking scheme that doesn't work for this scenario. Kick the async ICOSQ
instead which is always locked.

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
  00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000030: 00 00 00 00 01 00 68 02 01 00 08 f4 de 14 59 d2
  WQE DUMP: WQ size 16384 WQ cur size 0, WQE index 0x1e14, len: 64
  00000000: 00 00 00 01 d9 ed 80 02 00 00 00 01 d9 ed 90 02
  00000010: 00 00 00 01 d9 ed a0 02 00 00 00 01 d9 ed b0 02
  00000020: 00 00 00 01 d9 ed c0 02 00 00 00 01 d9 ed d0 02
  00000030: 00 00 00 01 d9 ed e0 02 00 00 00 01 d9 ed f0 02
  mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2023, qn 0x8f4,
  opcode 0xd, syndrome 0x5, vendor syndrome 0xf9
  00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00000030: 00 00 00 00 01 00 f9 05 01 00 08 f4 de 15 cf d2

[ Backport to 6.18.y and older: upstream commit calls
  mlx5e_trigger_napi_async_icosq(), which was introduced by commit
  0da1dba72616 ("net/mlx5e: XSK, Fix unintended ICOSQ change") and is not
  present here. In these trees mlx5e_trigger_napi_icosq() is the
  equivalent helper: it takes c->async_icosq_lock and triggers
  c->async_icosq, which is unconditionally opened, activated, polled and
  armed for every channel. Race B does not apply, as it concerns the
  sync-ICOSQ variant of mlx5e_trigger_napi_icosq() that only exists
  upstream, and mlx5e_icosq_sync_lock() in the race A diagram has no
  equivalent here. ]

Fixes: db05815b36cb ("net/mlx5e: Add XSK zero-copy support")
Reported-by: Paul Saab <ps@mu.org>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260513064613.334602-1-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Changes in v2:
- Restored missing part from upstream commit message.

v1: https://lore.kernel.org/all/20260909100310.1941561-2-dtatulea@nvidia.com/
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

