Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021107.outbound.protection.outlook.com [40.107.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE4360EF2;
	Wed,  7 Oct 2026 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338412; cv=fail; b=IuEqsixh30vPuQ4raaCo8Z71OHYKI6z0aiKi+dcTrrHxejzolu9fbijfcaRcwI5twySt75gMlouYC/0doHjnha9QCopoFqKp+oEHk7tBJFSWORBG9zVLFObc91qcFcXHZFBct84KlbPLLpqP/9kVopGdTjGm1vhaTK0E/OwuogI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338412; c=relaxed/simple;
	bh=kz0JJrsG5fZTpYtyJpb3vbSE3OavgqCPKeU9oEdWDs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSkDeBnzwKc1BXhHvmeM6HjTyAo15Sx1WK3VecyVOfriRHt1JQwDDIXLi1MtzC5VjPsBEQPjc0Q1pePneXmxPhP8E9GSYHwHw6cVJI7uex0V+EpvWxuc7Gbd9486Xj7UIwCQRgdj1YHcFzqSuAo8GLg2Ip4vC+9AarOXBtERW1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=Ny6026Es; arc=fail smtp.client-ip=40.107.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="Ny6026Es"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esiefnifMTOynTb8jYq3mEhBDsTQopt0vs1VJEwz1EBXc6Z+Pa24ziViyE3g+8M/p4yUg0P15TAOyi3NRthAUmZNq4Qw+kvCpxTcIr8Ayt5dpJSz4JRRID1DwbO++OuTVpHKb8WGNVf+bL6RDD631RIkdzNgLYOXH0AZAb1GYLpBlBU6LH0st/Zmx40lP/d6nM97o4zHWaLOIURWQd03mscP727CbSYtsE3c0LUPIRxKBFeIfzptT3ZUw5eBDV087SN47/Vg9RUudcGIuti6dyUygydjF5muc8V0GRMLv2oTqLSuOO42M39Rk9NHGg8f42/puFrPgYqvQ3kuBCjNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsGWwlBWc23PX8b9FBT2oa50/jJ/ohKSfSiA5ffL92Q=;
 b=U3/ZujDnsxI1IrsjY3UtNXEnbBL3I5ds4ts9jT34gKmdy79+RpxR06wve/vtmRrCI4OrX9anH6FOXr+W15HlnFiMBzE1eraYMLG2bJP+GeuQ9XBYsgMP+mwYF2joaa34QxOHTcuHP6fSmIJlDwTN/bNndkEnvPHTfkN0nPrwL6wHlOaFgEvi2pGJtwr5iVDK/5iXVTOMIyd/rNbF4pUH2bgGQ06JvVctkppnKmWmIoAPVBIfwWF6ePPJzJFSmfuyyp7PKB5eH8v/qtpHcWTxht9Qhq6idYiIqWgqQ0Fa8owc7lg/xXW6bU1Yne5F0RAMfDE9k/xuPV5bMBocRCSqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsGWwlBWc23PX8b9FBT2oa50/jJ/ohKSfSiA5ffL92Q=;
 b=Ny6026EsKqd/wRwNQHHnaJG1sNWmEA6mTsov+o8CKTMlSWLiU/L1QXgDUSMP8VM8+dC0Rl4gN+RaUFVMiEfCbi40JPKzqeXLPEToXaX0vyeNf2vMZeyen0pZBSR1S5VM9QM4oKCe+/0slgkGAnMN6lRFaxbtRgiWiPmQZgze71qW//wduC6ZO5HuaDQwRDj5Ae6gQhQBg4xJWApkxzXru8hcOh3Q4L5j/dezQmMQBXm3/ZUBFVgj7gmxKpGaa99qC+fVUKrPyejWp+jRbV44LpwL8ERV0Y6aeRzavjJC4w4ty6A9hFA2MC7YM4wCkUtrg5dpkmLlLa4+8P9PicWuww==
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
 02:00:00 +0000
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
Subject: [PATCH v1 5/9] media: chips-media: wave5: finish a job only once
Date: Wed,  7 Oct 2026 10:59:42 +0900
Message-Id: <20261007015946.53-6-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3316fc11-bcf9-4dc8-eaf4-08df2416b1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	6TydOG4s9xwFYsI3Eb27Xlm/y9wqZe61fm8X58+yoemgbwlJb3+WK+DbyiId3gVtVY8Xp4wW2NnF0PUauBtJ+MMxdIe+q+4t9hCH1FDWAE4OLSFv9H6IcoDMpN8Gh02ZJgeBMAGh4pA2iAwtBMUbN3HhCftVVVs3nWaMa6236dKrzU4IC+dMapXRV+pnu9zi5XBxlHSkzD90dPGcJFgii9PoMtBwsBPy1ALaKJBSIjHeD34M+wrbxm4kDPtPBQVEFJSJv7guCUI5a6Kqn75NC3KFmdYzt6xuVJk2sbxn1luzj4wP4tNUhr3dtnIs1eRnV3HlweVUWtnRHv5ZjCwcr/b9aNKAtXOdkhjxjP+0aebd7Mpv/0UVVhRbeD6L5WuHnOiFBFg5cfDkCGRv4q/RiumSDJMIPQw052KfN/SplbRCZBjlp4wXWn8IRxkZ4/rTfgWa2nqPVJns2tOInv3XaIwS45LYJ29Hw00bQWK1QnggxnovRB6uNWe2/Dodf+TdeY7n8DAeBxb1PybS44QVxHjVHVb3TyuX+pJkc41KxN7aB8TloAFIgcqomyoaCEUuf0q2EYdF76kFU04etftxCgUiamHVVRBpcdpWiiWdXbSSKqWRT04A6DHBPtkbUK++4/MS/V9W1zDdak9Hpdx/KC2ruQSUCcNgr4BeSk1h2FZaizim7jNY9QnQFe0n/fboppIY770GT9y8d3VJI2xh+A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kudtZ3W+6A1lAwy98PwmBYhcZowkcnkQLFj57rOwLfCZP/s1YuVkEerXXWRW?=
 =?us-ascii?Q?lIYSYDHJ9nmAq6xIcoi4KW6NFmL42k95A3a3pngpKCybLa4R6fX3hbywgnmu?=
 =?us-ascii?Q?LjeKu4CFs/xuZNT7KVuMfmT1oLwCUmoECwahcco+lHpOq0kpd+kOOr186BFB?=
 =?us-ascii?Q?b73DiJWlbqTENMu60vBMv34ietf1NBEvQZRDt58IMslyOyWjMsreIm/nDZfK?=
 =?us-ascii?Q?em62ZOEzdNdRR1Y+h2N8g9HlzOdtIwXZjnBpXsexu1Ks2jB0UTqH3InHu/Vk?=
 =?us-ascii?Q?bnA9OLcRkevoMYJokaL1YP4j7yJ2nKwGPbskG5AfsJoRhZm/BvIz+xRUXF7W?=
 =?us-ascii?Q?Xt2cbfdMacG0nuyQuQ8c5MxkevPiwtbaBknOXRyZZrlj3l5lFvBfoK1Vc+e0?=
 =?us-ascii?Q?J/ge/c3fPmndgb0rytrVthd3oOmYvM3huaLncx7WF1kiyTrjvpayusNG+8Sn?=
 =?us-ascii?Q?2IIY4kTQqQdPo2dmJm2GwZjaNGWAxui3aAQaqJ4ZGQ2fhLtPnrIXqkTwtGhp?=
 =?us-ascii?Q?qqIRJKWCdj5gf2LtrbaqjyngxoBUfmO8eQilcHZvZtguPLpWOAlrOW24G4M5?=
 =?us-ascii?Q?+p4x1EFlDzDpmoPXiXpxZ9hsjwUsiOMtgIqUp+6HkVh1Zn0m/Sh7mWwopGow?=
 =?us-ascii?Q?CaekmdPYN/a9RzAgtDaonm/QatKmMSJAmBPh+Ne6PSobo2My4aWZBlSHXcFf?=
 =?us-ascii?Q?ooXDHkiFIRHVl33Og/yKQiJpj2UjcIOckSo+Rv5kVb8XGkegvQ4nh/H7DBBU?=
 =?us-ascii?Q?PCAIwgwBEYZdH9itCL1DGKwInpfbkEDHtIdN6C1A9Kk17FQfgJ9a4CijSDqu?=
 =?us-ascii?Q?WOujx/3aKJRyf2xXl8e3rhwbyy/rYFF/LoCMxP6qUddg/CVzhfMuqcE1AGJe?=
 =?us-ascii?Q?X4FDiPp0gFzULxjk+ElKgS53rd4aB1iFTDfGiJnSJkNObWiJfcTUIez6MjSQ?=
 =?us-ascii?Q?ZSuWpRAhLJHec7nzvcGIly+vMToIQj5MGwSD1RGwEsqxNdhFch9qGiLMyYTk?=
 =?us-ascii?Q?X7WABJPT38HV559/TwUe33uyeq3atPZ7gw3dmgJgQNRy1kWiNhUhfOj1Qdqu?=
 =?us-ascii?Q?R7taf+78dbUZrU/jc9VvL1GYipMhEoWv+sCIM1Odjzn3DA6TRuBuGgQGRi98?=
 =?us-ascii?Q?vrGzNrpOO6tYJ7d2h890aW3q/Rqsny0s/cTs54anwvvTOAYIfs/I0kFZrgDA?=
 =?us-ascii?Q?NGbXI4nrlqJ7nFQ8lCqhbEQtwKJHZrdStZ0/tE0iDepHQGXwBLlU8rC+WW9X?=
 =?us-ascii?Q?yQLV9qPyYP22VDWqBzdbPcZzzYC0zwMFhbSiBZbA1S432O9yPbnfQUIDHY7w?=
 =?us-ascii?Q?+UsCrm2psm26Y6Mmc2urbMbPr9DO22wtfqlD8oRV/pnnKjVCQYnNjeyuBZO2?=
 =?us-ascii?Q?W5N5ux1OwVJz0orXPRMauq6audnFno5K3p8L1qqtMldVd3ZDsBk9XIhgZWdW?=
 =?us-ascii?Q?8fILk55ONXu66WVwm5kggs6OYSusS/VuzqtcQHQoL7byx6wt/dizh2xU88Td?=
 =?us-ascii?Q?oiU51JBXSOG11dfW7XWJY1evQZAiRrUqKc07fFvj4X3xMjMqfNI306ist6dR?=
 =?us-ascii?Q?poa0k/De0fghcXOc6zV6pZcWdpON+e0AY4UNy5XpvfFtJl1XC36KgF8WY0/m?=
 =?us-ascii?Q?WZIqnoxsN7i5s7gzM3Yrn9wLA5xCm5Ilm5TpXlODFG9aKdaESgfk+MmM27NZ?=
 =?us-ascii?Q?HK122+zutHaNfuDygGSSubQvxNVAp7JuCMnllDqEqNQ3YMGF+pVlreIweqBw?=
 =?us-ascii?Q?H+uvoM+hSLeO2EMox4w/Ft4PP9jdaq8=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3316fc11-bcf9-4dc8-eaf4-08df2416b1fc
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:00:00.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKT6LmNRgJBLIlaBVKncOAKFIL/uRChb+Pl6MeRFa8qAdXXBq28IA8NpI5504xY8E3y5GzKDy7HjyeL250UwsRgSr7r4Hq/wdPj5WELoEn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

v4l2_m2m_job_finish() checks that the context owns the current job, but
not which job it is, so a second finish from the same context clears
m2m_dev->curr_ctx all the same. v4l2_m2m_try_run() picks the next job
under job_spinlock, drops it, and only then reads curr_ctx again to hand
its priv to device_run(). A stray finish landing in that window makes
that read return NULL and the decoder oopses:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000358
  Workqueue: events v4l2_m2m_device_run_work [v4l2_mem2mem]
  pc : v4l2_m2m_try_run+0x78/0x140 [v4l2_mem2mem]

The decoder finishes jobs from seven places: device_run() itself, the
completion IRQ, and job_abort(). None of them tracked whether a job was
still outstanding, so the same job was finished twice whenever the IRQ
and device_run() both reached the end. Instrumenting the call sites over
150 s of a three-stream run counted 63 finishes with no job to finish,
two of them a plain double finish.

Take ownership of the slot once per device_run() and let only the winner
call in; whoever loses the race now returns without touching the shared
state. Also compare v4l2_m2m_get_curr_priv() against this instance rather
than testing it for NULL, which let one instance finish another's job.

job_abort() stays unconditional. v4l2_m2m_cancel_job() only calls it
while this context owns the running job and then sleeps until
TRANS_RUNNING clears, which nothing but a finish does, so it has to end
the job even before device_run() has claimed the slot. It no longer
returns early on a failed state switch either, for the same reason.

Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 78 +++++++++++++------
 .../platform/chips-media/wave5/wave5-vpuapi.h |  2 +
 2 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 07dcb20ffdcb..18400af036dc 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -102,6 +102,28 @@ static const struct vpu_format dec_fmt_list[FMT_TYPES][MAX_FMTS] = {
 	}
 };
 
+/* bit in vpu_instance.job_flags */
+#define WAVE5_JOB_RUNNING	0
+
+/*
+ * Hand the shared job slot back, exactly once per device_run().
+ *
+ * v4l2_m2m_job_finish() only checks that the *context* owns the current job,
+ * not which job it is, so a second finish from the same context clears
+ * m2m_dev->curr_ctx -- and it may do so for the job v4l2_m2m_try_run() has just
+ * put there and is about to hand to device_run(), which then dereferences NULL.
+ *
+ * device_run() and the completion IRQ both reach for this and either may get
+ * there first, so ownership is taken atomically and only the winner calls in.
+ */
+static void wave5_dec_finish_job(struct vpu_instance *inst)
+{
+	if (!test_and_clear_bit(WAVE5_JOB_RUNNING, &inst->job_flags))
+		return;
+
+	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
+}
+
 /*
  * Make sure that the state switch is allowed and add logging for debugging
  * purposes
@@ -247,7 +269,7 @@ static int start_decode(struct vpu_instance *inst, u32 *fail_res)
 		set_instance_state(inst, VPU_INST_STATE_STOP);
 
 		dev_dbg(inst->dev->dev, "%s: pic run failed / finish job", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 	}
 
 	return ret;
@@ -376,7 +398,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	ret = wave5_vpu_dec_get_output_info(inst, &dec_info);
 	if (ret) {
 		dev_dbg(inst->dev->dev, "%s: could not get output info.", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 		return;
 	}
 
@@ -389,7 +411,7 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 
 	if (!vb2_is_streaming(dst_vq)) {
 		dev_dbg(inst->dev->dev, "%s: capture is not streaming..", __func__);
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 		return;
 	}
 
@@ -470,13 +492,13 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 	}
 
 	if (inst->sent_eos &&
-	    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev)) {
+	    v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev) == inst) {
 		struct queue_status_info q_status;
 
 		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
 		if (q_status.report_queue_count == 0 &&
 		    q_status.instance_queue_count == 0)
-			v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+			wave5_dec_finish_job(inst);
 	}
 
 	if (inst->queuing_fail) {
@@ -1686,6 +1708,8 @@ static void wave5_vpu_dec_device_run(void *priv)
 	int ret = 0;
 	bool cmd_issued = false;
 
+	set_bit(WAVE5_JOB_RUNNING, &inst->job_flags);
+
 	dev_dbg(inst->dev->dev, "%s: Fill the ring buffer with new bitstream data", __func__);
 	pm_runtime_resume_and_get(inst->dev->dev);
 	if (!inst->retry) {
@@ -1810,36 +1834,44 @@ static void wave5_vpu_dec_device_run(void *priv)
 	 * stalling every instance sharing the VPU.
 	 */
 	if (!inst->sent_eos || !cmd_issued)
-		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+		wave5_dec_finish_job(inst);
 }
 
 static void wave5_vpu_dec_job_abort(void *priv)
 {
 	struct vpu_instance *inst = priv;
-	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	int ret;
 
 	ret = set_instance_state(inst, VPU_INST_STATE_STOP);
-	if (ret)
-		return;
 
-	/*
-	 * job_abort() runs from the STREAMOFF path and may be called while the
-	 * device is runtime suspended. Setting the EOS flag talks to the
-	 * firmware (send_firmware_command() accesses VPU registers), so the
-	 * device must be resumed first; otherwise the register access faults
-	 * with an asynchronous SError.
-	 */
-	pm_runtime_resume_and_get(inst->dev->dev);
+	if (!ret) {
+		/*
+		 * job_abort() runs from the STREAMOFF path and may be called while the
+		 * device is runtime suspended. Setting the EOS flag talks to the
+		 * firmware (send_firmware_command() accesses VPU registers), so the
+		 * device must be resumed first; otherwise the register access faults
+		 * with an asynchronous SError.
+		 */
+		pm_runtime_resume_and_get(inst->dev->dev);
 
-	ret = wave5_vpu_dec_set_eos_on_firmware(inst);
-	if (ret)
-		dev_warn(inst->dev->dev,
-			 "Setting EOS for the bitstream, fail: %d\n", ret);
+		ret = wave5_vpu_dec_set_eos_on_firmware(inst);
+		if (ret)
+			dev_warn(inst->dev->dev,
+				 "Setting EOS for the bitstream, fail: %d\n", ret);
 
-	pm_runtime_put_autosuspend(inst->dev->dev);
+		pm_runtime_put_autosuspend(inst->dev->dev);
+	}
 
-	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
+	/*
+	 * The one caller that must always end the job. v4l2_m2m_cancel_job()
+	 * only gets here while this context owns the running job, and then
+	 * sleeps until TRANS_RUNNING clears -- which only a finish does. Go
+	 * straight past the ownership check: device_run() may not have claimed
+	 * the slot yet, and skipping the finish would leave streamoff waiting
+	 * for a job nobody is going to end.
+	 */
+	clear_bit(WAVE5_JOB_RUNNING, &inst->job_flags);
+	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
 }
 
 static int wave5_vpu_dec_job_ready(void *priv)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 7b08fef58217..a338e39be1c9 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -826,6 +826,8 @@ struct vpu_instance {
 	struct mutex feed_lock; /* lock for feeding bitstream buffers */
 	bool queuing_fail; /* if there is the queuing failure */
 	bool empty_queue;
+	unsigned long job_flags; /* bit 0: a device_run() job is ours to finish */
+	struct delayed_work unstall_work; /* releases a stale empty_queue park */
 	struct vpu_buf bitstream_vbuf;
 	dma_addr_t last_rd_ptr;
 	size_t remaining_consumed_bytes;
-- 
2.43.0

