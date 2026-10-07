Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021107.outbound.protection.outlook.com [40.107.42.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBF367B96;
	Wed,  7 Oct 2026 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338415; cv=fail; b=GQTCSwP9ysm5nFb3DTkyn8awUADd8SrLdOKYxUw+XXruU//pV5w28oDLg0WBgIFBypUUoLsA3YKnLKTtP3/YBlVAAejZspRMRUiJVX1NOwvZXRs+Uk/QcPH9J69HrycZTa5F5oFx5RaIJFECPYLFr0FIfZny664DRX1ZWh0trWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338415; c=relaxed/simple;
	bh=N05j4SRdht59Z073zoz50iBXW1zMJ5RmrPlATz/L5HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PXvJ/SqpzI90KfgKaK4KI7Sce45l4zPWV8AvmTT0jFXwMB4TZhi040ETdymd3EL3zL7izyHt16dQjEomBof9d7SaWtXzXDHDGBWDkrRpXkLx+O63cOnyN4WbjFickS0qJZT/SMO9M052UH0EHsaIIDaaLIrz94hpjdrgqpUO0To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=qdi4AlEg; arc=fail smtp.client-ip=40.107.42.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="qdi4AlEg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXk0WtPqKi3HYRYb+uZthMV6GiwW8NKEdQo8RJJRJOwTlM66SEl7jQcZKnhoYTwPI2Lzz8jQ9k8DrmDEjsJBq/TBH+uMBMsR4Gp6RkUT7X9jbEBaoJ557Qaceg43sCS+a6Uh/TT/JVBCKxvftNq290R618pazV6icaE8BEC0vJ7FjzIqHvTb5FYjQCef+DIM+NFQsMletsMQ2XHtSzfXYLVFKbGLGwmNHAh6P5yzg9aJVaGuIGbNMk1dYCDndd+RXu2YA6rqsE4bWZETBehRu4F+sbVNIcePczmpHV5jghxF2CV/kXc82qh/Zm+YMwuy5C7L4sTrBmrd7hALqyN5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhXGJV7dqzFB3VHKRFNxIENIzuBxGvuseAlM1s2Mh2c=;
 b=b6vq3MvWrbE53cAN4p9S9EJfu5+48eO5cPy0m9WSci4AgI0XAB5b9yzlkyM9J/+eYvzz2eIReX6XaT1xlqBFXHsiwFHr0DBGeB31C6B2lHCpC/KvFIh/YwXYBczMfKq58l07RaUavjmgNUeGfbx3804z29ckLIiCdoM+DpQHL6nzZrTfXbvFfVRmY7j9CZB3dS7d93rwYSx9v41IgOdU/CSHayMkjsKyfTMYMM/BDEPtWRZPPKyN0m6yk9pKUFYdbE5Fo+CSQHQ4FAHgT3V2cn73k1mLQxbGR5JTN2Jtf46qfg4QWOvE8mc3RMJKo3cl/uoNe4Hw3oVUuLHUMwZ3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhXGJV7dqzFB3VHKRFNxIENIzuBxGvuseAlM1s2Mh2c=;
 b=qdi4AlEgCrKrsIyQ7eaTJPUkoMMwevyOQp3yeXlGSgbAocsqHRm9mdRyQ2jesewsifrKPU7TKjNxJSzLoaEKhuVnxK+sQZt1eAfqhEt1NeiXyA6IGm7618gfbYX68XcU4Cntth8GFR21+LTY388OGxj0oSqk1oCB6D7RUnGppyFtiVHhIVhHMZmeFzEN23/lG0pJt4MxatnpG0QvkSbqXjc+nNq4PeayMANi+VXS0bzBlzWeYbhfARoZW+QQ4CX0nuBOdbvL5xihqxmOWhv1ovoUYt02cI6QV5K+VpuHAW+uV50CUyfzVXViCj8lgTb2tr//PP4S+INt/n8WB9fPcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:00:02 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:00:02 +0000
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
Subject: [PATCH v1 7/9] media: chips-media: wave5: stamp decoded pictures from a decode-order queue
Date: Wed,  7 Oct 2026 10:59:44 +0900
Message-Id: <20261007015946.53-8-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2775db6-ab2e-4ab1-95b2-08df2416b2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	fOqCHVEPmpFGXs5Iiajrsin/hY1fll95pCBBqDVAolSmAfGjM9fhJLvszhgYDRNn+6Vw4DwlEBWYPGXQnW/SoLdHPaLk30GBUH+pjvz+nWOOOpBECOeULJUxR9aQktqF7dT8dhTnWF1PoYQ8kp8vPlC6UTmemSVLH5DZ7L5C38ODDFdj+OjsP0eNq+g5jw4arBvdaxfl3csT13xfSegJi+oBOGKpu7WGyw/0lsVR6wCTP+ttzRQgzBTqKqCDq0sqcLsN3Gy8qk5AUbvV6kPxkGqTFMLDZH0d4FTaBZLNmyn161McxHRdvOdufZVn3oj4xKuWqaRBCHY6rBA92/asS/STux5myRbnP9pV+dV1lpqGAuJDQSDBXiaq6leA7z3h71/nStvBlOBnANFu8Q1nBmk5DSHpwO8M+eDSmBtQy8DhEaDCkGkzQ8M78RlugMI/aejuYetyccpjxlZtzpcxtJvnoqII0Oiwd1DO9tsGdNHncw33vqdr879ig9hT34dMocMeLwWU12PhMgSOQD8cLpWcS4fpUqXRxRWT3NkFzijXsN/vokouW2hD1BrRKGDzbJgSResvufE7QnKnqk0I92f+AbAhQzuAUYxsjiNk2oBrfZ5LySGgeRPYHjsV6816lZWA6Oop8wzKMkvyFpTNHyDtJ3IYBtdO1oRwyvZCdnhwI5s7cxV1Newv2aKt3krN6SNfLxbZS3KnykeSTyTxZcM8NCmWBnLybcRwh3zfn0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xwe/n86kTgBScyBihLGtw4ab+FdJOi59pj7nB4BWEHn5sihvnrABmNimkfKl?=
 =?us-ascii?Q?+RD2MDZUK2ed1yYYCEuiNH5mEmA7rUOeetMpz+xoPnNcAmml7umHIJfj3G5U?=
 =?us-ascii?Q?bC6Rv9crEb4yMjnfNj3/5Cc2UgDrT9cC3elEKkmBt6vSKmg8DVYk4liJTFNZ?=
 =?us-ascii?Q?wtlhuJF9/U7fGql9FFu4CiCEEh41Bl5x7/DfaBOhMIqQWiGq7T9y9cKfrpw+?=
 =?us-ascii?Q?0cdvS/ix0Lh+/zTzLlrQia8lDE/Pmw+cTzIh7Cv3pCfTer60Kzlt6kWfUFqP?=
 =?us-ascii?Q?KyQ2s7ik3lQKbotNqpYXOoRaID53a5i9MQRnNExB51SHhnj5LTCyII+fAWMF?=
 =?us-ascii?Q?bestmrKcqd3d/9r6h6Cayj32fZdQ3EH8g75MQ0czlma2B6OubDwYRvvYuj4v?=
 =?us-ascii?Q?10yIVThZbKx5BglURhUz0Ozgltc603VRmb0beEWHHrSPxT2faeCo1MXDeCvQ?=
 =?us-ascii?Q?o3pOf69bfu8PzFfOgOoggHumZuoNLvonYZ82f/q+LV1zXqscJX4djhf6Q678?=
 =?us-ascii?Q?X/l5Vs65oOGEq3QT+ULy1nlD37+96zu7ScwMu9r/Cy88DTGoiZZPsaDtaIMO?=
 =?us-ascii?Q?nEIXZSAjzyE+rm7Ba+yy8Jz7F+kyOle8xHjH/PUKp7HVq6y7yaoSam1LtMuh?=
 =?us-ascii?Q?Uk4/TXIP/LQ6iaO06Ib49a4rqIxsnaFSohbGxRs1/LOugUW9l4C9IpbDW7aj?=
 =?us-ascii?Q?ah/IRG2zl77bW2xI3a8TgmhR3XWRC3FXynAjGkNHgATnIRX/Xgbs628YChq8?=
 =?us-ascii?Q?6Q5hF18LNfNoKmy7QSN0Pjt5qoVRI91SJEpzc+qCumxMG37pcAgYyz8VRT+T?=
 =?us-ascii?Q?xddp5v7Z78SusWg3xRJ2MakOlEKteIcfCm8x53DNIm0KDbOrhyNniwPhfcbm?=
 =?us-ascii?Q?DYO6/HuFfwdW3G7FwVz676k7D0aDlYGXIBJG1Dufo3xvf2GrZXz9gngyyG+P?=
 =?us-ascii?Q?z2RXaCOKDLdxBIMTCVFHv1/nW7PvlFF0Lqvw6RrBEU/b80shZyFBhQlhi6ee?=
 =?us-ascii?Q?fxGyeUcKeZEfQFo+OUSGg1lYDFWeqqjV30z1i/ShygzWr91e+oBw4I9YbqaQ?=
 =?us-ascii?Q?1euKR5ALR18ZfrxBzjiyDwTPVf3/p+6mwhxU1DhtF/WxwgxOMRvCf1g4rd90?=
 =?us-ascii?Q?lkZIlV7YDNtVFnk107PfTaNM1pSt0tqFtFrZyk3FURCjEez33DmbzyRh66oU?=
 =?us-ascii?Q?l6nNL2a/omStHiNTsSnbaf7qTBwo1Mxp7T8yH++vAtFqjJYwNLsyvm3hn/k6?=
 =?us-ascii?Q?YDwXYteR3CcPNiM9TGxfx2Huof4Zhje+vbTMnrahTuTSn4GNYUx8YSqb6JUV?=
 =?us-ascii?Q?6iYx1METlev4bqUzSGttClkCWK4H79rpzAs7TjV2jJtAXdsB7CRKzBpc8IA+?=
 =?us-ascii?Q?bJw3ECLp9KEhfOcjHzefBBfSVNMyUdSFGquGXYpdYHB9iAmKScY3bO4f8u1V?=
 =?us-ascii?Q?YTAM19TDuIWfbqBqSpLDgnJtPZFqpg9N8FFpXMeyVZrotg44OKaG+pmI4A/f?=
 =?us-ascii?Q?17sUKP6DcwfKjm9WtmbSEcjATmOxp2T8p03ijUEDMSF7OKYHef3UfnlV3Qbq?=
 =?us-ascii?Q?LSi9eUko8DArgY5QJOE3lVsW8lDgPQkINgCXjBlKQRf7pHEtIMW1n9T1nIrK?=
 =?us-ascii?Q?V3O7Zggl+R9dTOJ6giUzCD6uTB7i1jqZbmdy19jSgJw09OETdwnlg07xeQYW?=
 =?us-ascii?Q?fBE6od9zXbC9BSnzwKfKQlA8erzeqpUUD2hUsIuDZjYFP6Gy6QWxBoDGMeVE?=
 =?us-ascii?Q?fWvitgFbc/Z7NFiJUXGzYVOlR3XF8BM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2775db6-ab2e-4ab1-95b2-08df2416b2d8
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:00:02.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rY8kukZOKmddozL9HGKtFy/jBAXY+P0m2Enqepi0XlMaBsQL62M5Frf3nFrseCeYYNCzdTD9Jx7dbRoEG9i/9VOr65ycrlL6WDMTQ2WNgEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

The VPU takes more than one picture command at a time, so one completion
can report a read pointer that has already passed several access units.
wave5_handle_src_buffer() then completes several source buffers in a
single call, and inst->timestamp keeps only the last of them, so every
earlier timestamp is overwritten before any picture is stamped with it.

Userspace carries its frame number in that timestamp. A number that
never comes back leaves its frame pending forever; GStreamer reports it
as "Too old frames, bug in decoder" once a hundred have accumulated.

Queue the timestamps in decode order and take one per decoded picture.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 69 ++++++++++++++++++-
 .../platform/chips-media/wave5/wave5-vpuapi.h | 10 +++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 0c92b6c9a913..eae738df270e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -199,6 +199,59 @@ static bool wave5_last_src_buffer_consumed(struct v4l2_m2m_ctx *m2m_ctx)
 	return vpu_buf->consumed;
 }
 
+/*
+ * The decode-order timestamp queue.
+ *
+ * GStreamer carries its frame number in tv_sec of the OUTPUT timestamp and
+ * reads it back off the CAPTURE buffer, so every source buffer's timestamp has
+ * to reach exactly one decoded picture.
+ *
+ * A scalar cannot do that. The VPU accepts more than one picture command at a
+ * time, so a single completion can report a read pointer that has already
+ * passed several access units; wave5_handle_src_buffer() then completes
+ * several source buffers in one call, and all but the last timestamp is
+ * overwritten before any picture is stamped with it. That number never comes
+ * back, and the frame it belongs to is left pending in userspace forever --
+ * observed as GStreamer's "Too old frames, bug in decoder" warning once a
+ * hundred of them have piled up.
+ *
+ * Queue them instead. Picture completions arrive in decode order, which is the
+ * order the source buffers were consumed in.
+ */
+static void wave5_ts_reset(struct vpu_instance *inst)
+{
+	inst->time_stamp.head = 0;
+	inst->time_stamp.tail = 0;
+}
+
+static void wave5_ts_push(struct vpu_instance *inst, u64 ts)
+{
+	int next = (inst->time_stamp.head + 1) % MAX_TIMESTAMP_CIR_BUF;
+
+	/*
+	 * Full means pictures are not being reported for the data we feed, so
+	 * the oldest entry has nothing left to claim it. Drop it rather than
+	 * refuse the new one, which would shift every timestamp from here on.
+	 */
+	if (next == inst->time_stamp.tail)
+		inst->time_stamp.tail = (inst->time_stamp.tail + 1) %
+					MAX_TIMESTAMP_CIR_BUF;
+
+	inst->time_stamp.buf[inst->time_stamp.head] = ts;
+	inst->time_stamp.head = next;
+}
+
+static bool wave5_ts_pop(struct vpu_instance *inst, u64 *ts)
+{
+	if (inst->time_stamp.head == inst->time_stamp.tail)
+		return false;
+
+	*ts = inst->time_stamp.buf[inst->time_stamp.tail];
+	inst->time_stamp.tail = (inst->time_stamp.tail + 1) %
+				MAX_TIMESTAMP_CIR_BUF;
+	return true;
+}
+
 static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
@@ -232,6 +285,7 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 			__func__, src_buf->vb2_buf.index);
 		src_buf = v4l2_m2m_src_buf_remove(m2m_ctx);
 		inst->timestamp = src_buf->vb2_buf.timestamp;
+		wave5_ts_push(inst, src_buf->vb2_buf.timestamp);
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
 		consumed_bytes -= src_size;
 
@@ -422,8 +476,18 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
 		struct vb2_buffer *vb = vb2_get_buffer(dst_vq,
 						       dec_info.index_frame_decoded);
 		if (vb) {
+			u64 ts;
+
 			dec_buf = to_vb2_v4l2_buffer(vb);
-			dec_buf->vb2_buf.timestamp = inst->timestamp;
+			/*
+			 * Empty means this picture came out of data that was
+			 * already accounted for. Fall back to the last timestamp
+			 * seen rather than leave the buffer unstamped.
+			 */
+			if (!wave5_ts_pop(inst, &ts))
+				ts = inst->timestamp;
+
+			dec_buf->vb2_buf.timestamp = ts;
 		} else {
 			dev_warn(inst->dev->dev, "%s: invalid decoded frame index %i",
 				 __func__, dec_info.index_frame_decoded);
@@ -1529,6 +1593,9 @@ static int streamoff_output(struct vb2_queue *q)
 	 */
 	inst->remaining_consumed_bytes = 0;
 
+	/* The queued timestamps belong to those buffers as well. */
+	wave5_ts_reset(inst);
+
 	if (v4l2_m2m_has_stopped(m2m_ctx)) {
 		unsigned long flags;
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index abfe94fa18e7..f2c6efae4aa0 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -781,6 +781,15 @@ struct vpu_instance_ops {
 	void (*finish_process)(struct vpu_instance *inst);
 };
 
+#define MAX_TIMESTAMP_CIR_BUF	30
+
+/* OUTPUT timestamps in decode order, one per consumed source buffer */
+struct timestamp_circ_buf {
+	u64 buf[MAX_TIMESTAMP_CIR_BUF];
+	int head;
+	int tail;
+};
+
 struct vpu_instance {
 	struct list_head list;
 	struct v4l2_fh v4l2_fh;
@@ -817,6 +826,7 @@ struct vpu_instance {
 	struct list_head avail_dst_bufs;
 	struct v4l2_rect conf_win;
 	u64 timestamp;
+	struct timestamp_circ_buf time_stamp;
 	enum frame_buffer_format output_format;
 	bool cbcr_interleave;
 	bool nv21;
-- 
2.43.0

