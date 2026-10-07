Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021107.outbound.protection.outlook.com [40.107.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF62345EA9;
	Wed,  7 Oct 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338406; cv=fail; b=SNs1QajMmmNLvHfdKut4P2dtAktlBMVareTVLiHne5DobR/H2Le7mDg07iyJTMvZfa9vs43a4GWzc0HCoOyWaNkGZriMXD8QBVDejvfTkcFNiBAMfKdlR+drhGTSZdzejQPaLJlZETVQLAuQNqCSZdBPZMQHMZqP+aLJ8qyLbLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338406; c=relaxed/simple;
	bh=WPAgXrZZ+bJNXp7cCBnC7rmM46bUPJCPq8jcXJeNnI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/q2qZqf9CoInqBZ0eXf21Y5vI9fLBNCF6O2urM9KokDv0/FXFruhN22kszVRnAYkUHSXgqP8+na7rQgGAQnyNNV1zPa3hYxCFQwFpPAu0KWSn8H0PHL3HyMn+ptQqYq7jtaDOmBwUHxvvhDRqJPNoLO/iiU55XGArLPQF63XYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=AFDAYTKk; arc=fail smtp.client-ip=40.107.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="AFDAYTKk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFZbpP6/fjB/WWP9vuRQkNOyNWb4kIXFsH87aWdxGkHRc2pLhgqFD6zo7+UM9O5Uhuc79s1dJ2vF34LahhBJpiUmhj+mbAdG8ONep3ruU3msi9TAD4dAZd22d4VnnQgcfMShEPYAkmBKYCrVYSPRtG8g97ZhXGz5P/yBpi6R2VexdowfFfBdl9XpqUxiJKdhC8M2efHLDnv9Kp6DFvehIiLFrcpaqhV5wF0ZtYwZN6IpM2FUC7fB/XnMVqCWn+zmRmXhrlme2mcv/kl1jvWAV1vmEZ2+fXYGuJUlXhSnemis66wv/UXYZUgX68bIb3nm8kYRUucdmd86MYX6i7QD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBfOnjCH9c0aVao3MugvoSBbo19XvxSIcslRH3Ky+zs=;
 b=X/DTqabUe/UO9OtlY3tQFQSVbAhpqGhnduZL3s8PhquU/y54tmUcQy8HJPLGpE3iWVAK6fS5ttfW0IEBLpEURQ2IndAtFLrdNk/HBxQH6htn5BDzK0xOQCiloNdUEcJu+KWSqd6+MvBi71mjRA8ONTj902H/RMyIbkrMdHtmBjBg+DkEMUQKa1PFt7TAsnbYt2TIoIl1Oegbf2fjOleQIo6eytTdzP5FZKpZUWZoccz6UV3aNvWy83zfdVwfrnMDnzn0d0JYgMAkQb1NLa/aDZ5bsNwu+ylZKkX8gfM+EKSwmcL5HzXUryGOm5M2HydgtHqfYvaRujuIyaqCk3gMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBfOnjCH9c0aVao3MugvoSBbo19XvxSIcslRH3Ky+zs=;
 b=AFDAYTKkhDfE4q/fk0UME6GkQFVhiJziGZ8IlSrbzZkcczFfanU1a4qUlaxn/htClxVKzsXN1sRGtgEXzyLJI3RYFBa1JAcdLJQ8X+4iL60ON6zo8nIvwnEX1G6H/GBHVgYVG61Veskws4ZkNu+AkWMKBegvBPyhPo0/RFooytH1zihf5ia26H3KdN1R2yGC6Ja2OLrdig+ZO+UYvSOBnSKnBluKqO9FwJd5Hod+SZMLt09O9EOCstOn+usZS9tpOPkz0R8iJd6TxyHEEtlhea52506WLIXg79lIVoNZEMdEo+alB7wOJqP9+s7cR4DVrjQL1lMOKB3Dx2eqWszYtg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:59:58 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 01:59:58 +0000
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
Subject: [PATCH v1 1/9] media: chips-media: wave5: Ensure Atomic Access to src_buf list
Date: Wed,  7 Oct 2026 10:59:38 +0900
Message-Id: <20261007015946.53-2-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e684aa39-4f05-4493-74b9-08df2416b08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	yjsBjdUpIr/mW2o0k1UZUpPC4juzAv7jWyS8qo9dUZ9ND468jTkrX2MnENghswavRjXeQIA+1MUJjFLM1qKDV092Bh7r0oEyGeixpC44VpzVXrW4muVYLj2353lMUfGXWdjoqDT3mYmokuc4LBMEah5Mmy/5RRMk49K3/UF917y+Pjq4+to2udmxF/gZ7V57PhOqWlFV9HhaRoOsrw9YOYorLs61UC3z7MrDvWobL900/AIH5Tj1H31REYYmS5s2WfUENwOgqsAd2nvUvGu8zKwIekNomE6ErQUK/cQ80gwlFi2GstFednFvSt5wJQgyyjgEWWV6tvlbw9WF2U+e89IhX6ivfibxfwmg0uHIW8AzDU1ooFV8k/nCCTT7dkZdYFZLkFXaY4wOUWhGrzQADXcrmLi2iXDwyr4Eg5uGmPs2yZerDS96u/SQzmzCHkIcBXQp82arBh0Bgw+462rvWhjEF86aRMOWSWz/oPKdY165CCZkAPXd5UKUZtqgthgDuWHeufrxhqtLJ3Yvrd5dqSyJKOhVbwR2n0D6zxauHdZUFqYqkvvTkHEOBA3x8E/v0VfyF6MB93aj/R0pYbiKYZiaDpH4goaf1fvqf0wUjIuzAA0TTty46PsTUL7Qm21c3sBTMGpEp1eMs9xFRa/1Q6NM4VDw+jzmQOqXdoO/0B7bbd6jzcvCmvP73x/Vq22j96Qo92/AGSGQ+mkhWbb76A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OcMqkYrymR7SxOtJPrYtf3RWnZ9yf/8jnoNwhQbkhM5NXb4aVLA0/863LYhx?=
 =?us-ascii?Q?HS6dgk39POR3+lxsSm3/BIUrJMpMgbrHOyVz69lexYLFSe07rv0fhqA1Isdl?=
 =?us-ascii?Q?vgpGIt+iacVeXyFqyHzzmCyg10F06aLP0ULoeTGs0Ua+e+YFhCLadagDLi7G?=
 =?us-ascii?Q?TxKfJAC1plsQonxp1OOKTJh9VOaXiy21a7/gB4OcMy2rC7tckOIF+kWON4wV?=
 =?us-ascii?Q?gLJNKgd0C2oEZoi/qb7wIu8pJqwSMID+IVd1i6RKC4iD944nC17TP7DYvGvn?=
 =?us-ascii?Q?dRiVnZrhbsiYoQQddPkAjUr9pN+knF1xsiwmFzPf8FxOYKWeX0iRyVSjveQW?=
 =?us-ascii?Q?MtmK6xdx3W4KCC82ngmOyKEJ3KtUUpDqFuWPWrvljOi5ERsGlTzbqxjVjFGR?=
 =?us-ascii?Q?PuqKlBNAHQIXVH0hi2c4f0V3aN6F9OiOz2gVtw5ogTfjQsABP/mQ3LN6urTn?=
 =?us-ascii?Q?cpxs4y2MFx15F5w56F4zt56FL3WIkhXkh3rUFPZI/ET39Re3ORBgHd6g7Zs1?=
 =?us-ascii?Q?D9c7uA+vM2W001OGPpCtY0SUlVZfi8EWMYpeV56CSh0iXsBYtRngLvkqCCgT?=
 =?us-ascii?Q?TLVfiPl7VJZVk6e8JpNaMQnwD5C5+1vZySFn7F3DGVWObyleOico3Cev2RfK?=
 =?us-ascii?Q?qSJZvIX/alps1UhjDKb2LeRjSFeDZZyM0mdw4E6g2h16nD6Ycw0WlogYIjS0?=
 =?us-ascii?Q?iYsWmGActFhKyjm3eAz4qib/9X2RdO0uEphsjToYzynzdAD7WRAiY+AguSAm?=
 =?us-ascii?Q?mkpgMh6e2BsOqjMCV3thNo8XoKd0x3sF5Ky5sGmSxE8fcGvx16lR2oKzZ3xy?=
 =?us-ascii?Q?5hvzt/OeVv7QPp9i7YGQ7yk2uRMf2D9uOnuaYqGwA9JtUaxhnVEA5ynYylhz?=
 =?us-ascii?Q?9V0hc6kCxYsuHHzPQk0HIr9dVzD1YMS5Zxkg5D/Kmyl08Cmc0fMlYm0VCGoU?=
 =?us-ascii?Q?V1+HB6dTtb/lm8WEx2A+bI5Sn0/blFy/1tASGhEIyBaaBt9TiD8pBr9QmMpA?=
 =?us-ascii?Q?IueNnMCd7LNu7Ji4GK96SNnabVh/ebxAVYnJTkMLqucA0FYR+ZRKq+nwWtBW?=
 =?us-ascii?Q?IDNT2lqPnPT5cx0bEid0CR5ctKtwAPuuBD6aiEyIc7LFH2lfBQ0ZBV9pJllP?=
 =?us-ascii?Q?+PWN1ERIucEI+ZY5pf5ScwJTnoKJSCpfbjvDSc67+WTeNXytNPM0MPZMTL3h?=
 =?us-ascii?Q?chUGZh7sOjYnDakYdjG0YixKHCergwvFHrff3pes5w4roxuGzWqnCXh0sQcF?=
 =?us-ascii?Q?X6Gg+DGDFC/YuZKhJpI4ViH4nTCH0tRT0YY0sIvj8dFKDNW7suPirhxjSwna?=
 =?us-ascii?Q?V59/V9HrLUlazu/fQcpEWQkOIHZ+IEi+eLp8K+4/gWsz88jcuI3wKkiKep6K?=
 =?us-ascii?Q?MaAKVUrWj+CytiVeeyr2aMwVjb77P9V3ePzEFDuiHgBoZf7IySJyzE57oq7g?=
 =?us-ascii?Q?/HYxiCOtmILtaHU2eTqoxDr0dbBLvvxiG3Py8xuFqS8t7QH6cz7MwUk1mOUJ?=
 =?us-ascii?Q?MhKnNBc/4ZoiD3Rn/lKRirQ+b11no48FGD5UdffbOLGNxbJt+gSm7NT9BZx6?=
 =?us-ascii?Q?9r6GmEQup2spDGpyeCkWVQIS2n8OgW8QMCNaW1UYgQie61R52sF6l+A52Hdc?=
 =?us-ascii?Q?Awa8eTkLpY0785MkdayiWgQdnodK0vtAOe3vgXLQPwF6bzw3PHixtdWMwetk?=
 =?us-ascii?Q?iKI7LVz5pX3u662uT7rWokjzbnjLRYHXiCp1GuZzOBgIKmm90h9kqphEYche?=
 =?us-ascii?Q?ZG0xXGdToMw8npCgRbbEIyix4vGSdQM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e684aa39-4f05-4493-74b9-08df2416b08e
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 01:59:58.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77NfBKrG/OSvdH+JHPtCWsvjdDDogVqZnLvZSsJCnMmPyKwgaT5M9sQ9/bqEwjQgfOUTrnymvKhc4NMzxhMgPS61h8g0y7RoG0T14dhI9pA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Brandon Brnich <b-brnich@ti.com>

feed_lock was introduced in decoder performance improvements. This was
used to ensure atomic access to the driver's avail_src_buf list during
fill_ringbuffer, streamoff_output, and buf_queue. While this protected
the drivers available src bufs, the v4l2_m2m_src_bufs were not being
protected at driver level. Three separate threads have access to remove
buffers: start_decode fail path, streamoff_output, and finish_decode.

In streamoff_output(), replace the inst_src_buf_remove() loop with
list_for_each_entry_safe(). inst_src_buf_remove() takes feed_lock
itself, so calling it while streamoff_output() holds feed_lock would
take the same mutex twice and deadlock. Unlink each entry with
list_del_init() directly instead.

Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 6564cf3ec739..6af7d2e9a9f3 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -198,6 +198,7 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 	dev_dbg(inst->dev->dev, "%s: %zu bytes of bitstream was consumed", __func__,
 		consumed_bytes);
 
+	mutex_lock(&inst->feed_lock);
 	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
 		struct vb2_v4l2_buffer *src_buf = &buf->vb;
 		size_t src_size = vb2_get_plane_payload(&src_buf->vb2_buf, 0);
@@ -224,6 +225,7 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 			break;
 		}
 	}
+	mutex_unlock(&inst->feed_lock);
 
 	inst->remaining_consumed_bytes = consumed_bytes;
 }
@@ -237,9 +239,11 @@ static int start_decode(struct vpu_instance *inst, u32 *fail_res)
 	if (ret) {
 		struct vb2_v4l2_buffer *src_buf;
 
+		mutex_lock(&inst->feed_lock);
 		src_buf = v4l2_m2m_src_buf_remove(m2m_ctx);
 		if (src_buf)
 			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+		mutex_unlock(&inst->feed_lock);
 		set_instance_state(inst, VPU_INST_STATE_STOP);
 
 		dev_dbg(inst->dev->dev, "%s: pic run failed / finish job", __func__);
@@ -1453,12 +1457,13 @@ static int streamoff_output(struct vb2_queue *q)
 	dma_addr_t new_rd_ptr;
 	struct dec_output_info dec_info;
 	unsigned int i;
-	struct vpu_src_buffer *vpu_buf;
+	struct vpu_src_buffer *vpu_buf, *tmp;
 
 	inst->retry = false;
 	inst->queuing_num = 0;
-	while ((vpu_buf = inst_src_buf_remove(inst)) != NULL)
-		;
+	mutex_lock(&inst->feed_lock);
+	list_for_each_entry_safe(vpu_buf, tmp, &inst->avail_src_bufs, list)
+		list_del_init(&vpu_buf->list);
 
 	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
 		ret = wave5_vpu_dec_set_disp_flag(inst, i);
@@ -1473,6 +1478,7 @@ static int streamoff_output(struct vb2_queue *q)
 			__func__, buf->vb2_buf.type, buf->vb2_buf.index);
 		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
 	}
+	mutex_unlock(&inst->feed_lock);
 
 	while (wave5_vpu_dec_get_output_info(inst, &dec_info) == 0) {
 		if (dec_info.index_frame_display >= 0)
-- 
2.43.0

