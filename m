Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020125.outbound.protection.outlook.com [52.101.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D835A3B1;
	Wed,  7 Oct 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338411; cv=fail; b=Rz/RpL1zuPG8YEtqRhDZJlEPHbyz8IVMfqUnhPHAnILO33z/oINl0jtcamoSehTFD9/0ZMYvP/howvBDhknUijtgyorMWZPEnEsx8lutN5je8GzOJ4MKR7zFL55hhqueSAI+iJ1FmZZ3qD9dCqM5FRO17FjHfHhd/CVis2M03fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338411; c=relaxed/simple;
	bh=YPQzcF7seTxa0g77+s61Ewkk1GIo60nbDxKQ8jvlSlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TGkQ3bONE9E5jjYp7LWRkxFzSGVIpFpf8i35BEpC8Z5yj/s37ctURUfhDktmsPKjpcgN5clsgxOvDKmtytSlUgpbKZW8HJd5tpoe5fnFWrMY/5iKgNyolzObOgpgkLHEZCnI+TwAP/lgPXRLcZenrOwREUFcx3XMWZtscRvW6U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=og8I58Yh; arc=fail smtp.client-ip=52.101.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="og8I58Yh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=marJ7iUaGQe1LrBIcqvrG5Q/4a+G3mbQH1m2hYeumIXX7fkpY6jSciVv30Txh1ZjDv3I3lAbk4IcosWqc8fIkZ9NM9Buq1RhCvDuh7wlguHg6cHn77aKN6s8kVY8mHG2E3eZsKfZgQGaJ9purBgcuGcqBQghC7ATtzOMpx5fO9vU7idRiCL1UZKi/qkaLDiG7fW5twiJzsZ5tKtNtV0N5D08/VABlPmvW1sZyOYRl09k1JUqkzP5AIYVLt8q1p5nSRF+EndQIMifAmgoOfVskXWfPTvqLVQm08nDObjMUTS5u4L2EFS/Irw/Gm+vI3RGa3M9572S/oPDNk927+cEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AIXUcQtrCC8loN1xm1cYTRbye8R+M0GGFQkg77lkGk=;
 b=j+e5PQ1GQmbRsvTbUbwRkg+NYCd0PIuBuNsM5EL8o56Fh6c1qdfEc/LrWPNJVKGNAfRZ+YsLE6QEjQudew3KPBRvU4cf8KnmfapipJBqAzIeN3gBr9QN9/CwT8+FVj9lkfKH8UlZyKQfMv/YiYGFuJfEUqdUQ03p11cFNtQDGfVqBgINTi7KHD6uClP4KVATetb9iwPx1ycUxGN+yS9uLuUmzBgUeIr6dd2QhKK3WnZmhMDklkABIXY1GYhC+lWZDnlCnxfdxbUDUiPrnbhn5u2nT83gR09/i+xLfAN4GWPjWC7E1PY5t36Tzf7ZsbyQ1I+iETWwlqJ4E5xu/3YNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AIXUcQtrCC8loN1xm1cYTRbye8R+M0GGFQkg77lkGk=;
 b=og8I58YhXnIyWU8nQ9SjyeSLRbdgJ3ymPc5j6C6w3UpEky1Ch3IgN/GznLj3+zUVkhc4S769GnJamSkzmbmlzHTupXXqBLA0QH2U56N+GPSgrqWcBn5Nj9Zx2LTBtAFdkWzgo1otjsxRZPSvu84vmS+6Ybs5w5tEAdoTVOWMPk5/uFRZGN+SFLgg2EdrInEWQDVVe7ppUNLRjYT9ercPV6gDxU6xYT97/5RsGz8AVQ2TMD7KDURK1QY/8g7hPcMkmwZwZy6TVgs3UAsEWyvcXZqra+1HVcFMnVJp0sZXmY4n6NnPmLiI5Njg+BO2bxdOeLbP4ot7qwOKiMkH91Qrsw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:00:00 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 01:59:59 +0000
From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com,
	bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	stable@vger.kernel.org
Subject: [PATCH v1 4/9] media: chips-media: wave5: ack the interrupt after dispatching it
Date: Wed,  7 Oct 2026 10:59:41 +0900
Message-Id: <20261007015946.53-5-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
References: <20261007015946.53-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0127.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::6)
 To PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PU4P216MB1149:EE_|SE5P216MB118462:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a13691-36c8-4371-6c03-08df2416b1a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	VdyC3Y7ML6FEh990IBDoBCSg9RE87zTEf4NocV1UAEanQ+6U3n+Y21Zjnqn50EPZgoS3ttcuAse6CbT3ZWfZ4D4XEhMk8tzu2jXUmW9peiJSC9ouHIafqMxrc5q6ARiqY3daLjgnXCJh+hak7RjivCyIYYRobEGKenS/mJYRsebDT3lVT+KSRFgik2AivEblx+e1saJ1oA/GVpfXDy8JFt5/MKRXU+vv8HpKSf87KYYHBBUdA9U4W4yEa8iC6Qhn50ilbIrdPU+e2aPoyAmKqFLuzCx8j2/wanW+5bxeeS3Dc1VDaXmimcotVAdZlY+VFUx6KFy6tFGTVlInSXgC77eReNqOMGaibkuUXJy4wrBKmLGKAKiGRTeUj5DM47tKqX6JwZ7nXG7Hww+ZbMWfTcPYVELUnRQce9cOAhRsLo5HAcpB+3WoSHIiAh2Emwmd+etzbM5vpjfRY2aI8UL7OhvHPr4Fqio7QW2c2uQAKmdEGB+xfLIOImClfUhxIgrT0PiK6Js5SzXndxeT5bp0W0LQvr30Y0eVdsVTTuyt2p94WOaWkIhe6HSlj2bVFbJOZmjAKjcA6vBeg1cU5OmYMVwxHks2NAxIBPTyDvi+uaDakJwCMdybMByIiChZ1zBWuxZZkHohcvxQ5bEHVkkSbLSIkVw3IKIgdy6rU8lnVD9z0PUK73IXcEcmL7yvXi8ok3Ubg2ZOQ3IGuFtRLS2PEJmSZbcVuwB1IAuH7oBJuc8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lo5kNkz7nHP0tMPeNJ553cizDKUbuqSm62RQ02hA1WdqBAJzKaCUHq4q5T7m?=
 =?us-ascii?Q?MdGW3ryrJbbK+NcEtsCfmGoJYev257Fjo7wLRkocaNOegh5wlkVG7WweWJOg?=
 =?us-ascii?Q?2Th34rItQUuDhmtugweOOo+QePp2k+ZOBMOj0aUb4CM89ezqattA64GvkuOn?=
 =?us-ascii?Q?k+i9L0JNPQ3LiZxNvL+9mq1a7C4gQRVI/XhuDwaQ1m2Ghw6ln0n49Gr8hsVb?=
 =?us-ascii?Q?+jiTZVI8cFoOOlQf1V86dr5klaUFz+RKYz8zz58FItyNUPi/Ne7NYKlcLXI4?=
 =?us-ascii?Q?AheLC68S/EcOLxf9/+tB2u8TF2sJdQJTOmzhvWWDXWE9yzazK9/TNIo5eTJw?=
 =?us-ascii?Q?TCMTLpyjX3hE91qZwv26CIO8zB+GT6wE4rkD5KmHnmarLoLHQxHn7smpYNXa?=
 =?us-ascii?Q?WI//i3h6kEADsLCOb50WptatOhdg2bfqSs0HD1chj+fWoU+Q0bJQf6ddWndG?=
 =?us-ascii?Q?TKm5laMg+mylWIjVHerkZrs4nFc+eGy7wBFdSNGGw6stEupEMPs1WxDm7DA2?=
 =?us-ascii?Q?GRzIE/DINDQwyGp0jZ/nXb3Z1//QW688j3vXugTIjWjURvzQptCUqNHp+rT6?=
 =?us-ascii?Q?MNktSWlCBz14qVwYl/B2ACToQmzaG6ImeTyPz6oHfApc+R/HG2qODPTbVg2s?=
 =?us-ascii?Q?56tpPXujL39XDPIu5no54FLtfkQlpAiKmVcBCdElA8ffr94dUYelcWewXg9O?=
 =?us-ascii?Q?6DHAPmv7OqzkztJUE6rsD0LSPkFP6ld0h7mds46syjs5LrCdFz4aO6u+9IO9?=
 =?us-ascii?Q?aS47OPkbJGQl/fHZDuN0Mm+NNSSkdUZyGwBmbxsIoWRY188jEMdAc6+9AL1r?=
 =?us-ascii?Q?KkkJGHHIbKMBX1VKYSJ/v/ivKTtDx4O8lNsLwVRVtlWm24Mq2qXIEvofOt4t?=
 =?us-ascii?Q?bMQaUsDAoDy3edNSZ0YK3BPjj21IuyZ3BC+8jSgdkz7EDNclMA9B13mc2jKz?=
 =?us-ascii?Q?E5On2BCaZqIwmGhma+kG1O6h+UzQdIuInoxiy3SiPLpQAgdrM+tvZBXcHObi?=
 =?us-ascii?Q?SscKxGFZOtdXHCyxQcpVlzvwnCGnnwUkxYwuhfN+8dcWMjH6mgsuuaKn6KpJ?=
 =?us-ascii?Q?3lv2pm3DzRwrxkUXaYNSA9AjxyigCItWPuSGb030bF/q55474DkflWl/EPOV?=
 =?us-ascii?Q?G8hSbgRkfZVfuae+UNGocQt644fiqQ/wuVrlQK00bHLIhrxoPECq7IlUS6uQ?=
 =?us-ascii?Q?+XZTLwu5aW3UVV61W84JVr+aFNrrbzo8Th8/l29SUyV3aBUx74NZaUJkgjEA?=
 =?us-ascii?Q?POTQ+EQVR9iOx1sx+DJgYBHgSVAJMx9sP08skp4+R12LblhNcR9ZUv5mvNdi?=
 =?us-ascii?Q?M0ErvgCop2h35dVACRFqwytVaTvP+g80gejBt8cKMiwvBoPHiWTiC9154hjm?=
 =?us-ascii?Q?uiDb/XClGTLo1UvlCWElWELZ69cOVB66kWFumeqZX255fMKkwDR41JOlApL2?=
 =?us-ascii?Q?TwSefFygAX7yA9i955DaoE73/3I2e348aGlbdNn8Ag4JGDsdsil9vTFKbJlU?=
 =?us-ascii?Q?338zmrd9kNZ94MMDMxTDthrFkhDOPRuY6qFyJElUm4ZqXugwEVoBib0oROOb?=
 =?us-ascii?Q?JxzcrRKIlNsbFIUbT92RGh23cOJ7zdylhRVdzqo/tARkickcBGtRdZ/pKQw7?=
 =?us-ascii?Q?mIZOQsyaYI+AgA9idIUHwqz8/DyDrTBPHutAV8sRvhh0L6l3Vey+EsOzBe3n?=
 =?us-ascii?Q?8g3Utl2amy5eXj8kf2pttrbxx3oAifBYfOh+zsfXtL5vAunA9fRB67L3c9IN?=
 =?us-ascii?Q?iRw+ElLxOve0Z36c9lihcfL5vdymPbc=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a13691-36c8-4371-6c03-08df2416b1a6
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 01:59:59.9334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNysQFx9VkAHC2hlfqc+y0Y/oXb6SVOHmIvngOJpLTaiQq8wL8z4jOMXGpD2Srs4UZYO4puZZl5+hapE8KJI3fxlbQKo0hosF3Qii/fFWtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

W5_RET_QUEUE_CMD_DONE_INST is written by both the driver and the VPU:
the VPU sets the bit of every instance whose command completed, and the
driver clears the bits it has consumed. The driver does that as a
read-modify-write over a snapshot taken at the top of the handler, so
any bit the VPU adds in between is erased.

The VPU will not raise the same reason again while W5_VPU_VINT_REASON
still holds it, so keeping the reason set for the whole dispatch is what
keeps that register still. Acknowledging first opened the race instead:
the VPU could rewrite the register, and the write-back then dropped the
instance it had just added. That instance is never reported again -- its
queue count stays non-zero and no further completion arrives, so it
stops decoding for good while the others keep running.

Move both acknowledge writes past the dispatch loop. The re-read of
W5_VPU_VINT_REASON that tried to narrow the window is no longer needed.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-vpu.c    | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 76d57c6b636a..3ab75f3d23d3 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -51,7 +51,6 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	u32 seq_done;
 	u32 cmd_done;
 	u32 irq_reason;
-	u32 irq_subreason;
 	struct vpu_instance *inst, *tmp;
 	struct vpu_device *dev = dev_id;
 	int val;
@@ -60,8 +59,6 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
 	seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
 	cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
-	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
-	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
 
 	spin_lock_irqsave(&dev->irq_spinlock, flags);
 	list_for_each_entry_safe(inst, tmp, &dev->instances, list) {
@@ -86,14 +83,10 @@ static void wave5_vpu_handle_irq(void *dev_id)
 		    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
 			if (cmd_done & BIT(inst->id)) {
 				cmd_done &= ~BIT(inst->id);
-				if (dev->irq >= 0) {
-					irq_subreason =
-						wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
-					if (!(irq_subreason & BIT(INT_WAVE5_DEC_PIC)))
-						wave5_vdi_write_register(dev,
-									 W5_RET_QUEUE_CMD_DONE_INST,
-									 cmd_done);
-				}
+				if (dev->irq >= 0)
+					wave5_vdi_write_register(dev,
+								 W5_RET_QUEUE_CMD_DONE_INST,
+								 cmd_done);
 				val = BIT(INT_WAVE5_DEC_PIC);
 				kfifo_in(&inst->irq_status, &val, sizeof(int));
 			}
@@ -101,6 +94,19 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	}
 	spin_unlock_irqrestore(&dev->irq_spinlock, flags);
 
+	/*
+	 * Acknowledge only now that every instance bit this interrupt carried
+	 * has been consumed. W5_RET_QUEUE_CMD_DONE_INST is written by both
+	 * sides, and the VPU refuses to raise the same reason again while
+	 * W5_VPU_VINT_REASON still holds it. Clearing the reason first would
+	 * therefore let the VPU rewrite that register underneath the snapshot
+	 * taken above, and the read-modify-write in the loop would then drop
+	 * the instance bit the VPU had just added -- an instance whose
+	 * completion is never reported again.
+	 */
+	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
+	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
+
 	if (dev->irq < 0)
 		up(&dev->irq_sem);
 }
-- 
2.43.0

