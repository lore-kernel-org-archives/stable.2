Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020125.outbound.protection.outlook.com [52.101.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA5B370D79;
	Wed,  7 Oct 2026 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338416; cv=fail; b=PJBfNuuW8FWZYGWMRfgHdZtO7Vl7vDO7ZxYVz/QKh3ZNW1QVBtVwBHaNDg1xWcaNwT+XaxXKrVC7Mkbv7KmmFFaow3nhHIiH1akSku8JbECo3tplQqA0cui02e3PKcYARk++LQXn3AMMDYDEsGnvScPn5mZ8OdeIkQClvcEe954=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338416; c=relaxed/simple;
	bh=aBtH/KV6wepHfW0hHEBQsya+DJFBNuM5HmhmjrPxafE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dm5N8LAwDC0toIV6Tb5vj+5YqCmtDOa8wYomUigQGUhNzVI0pZnmSbdrKzWQy/xbKm3+5I6BK2dFjPRfcvR3/dJfwhkRoW5eSsYpqE82ypm9jHAO5EzEvPebZfwTo5cnG+2+O+N8G6VdxkY0wPmZaDF/9FegaoiLVjXlJ2Mw+t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=UHRvf95K; arc=fail smtp.client-ip=52.101.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="UHRvf95K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taAUjTDyXDVV5cdRETO9e/MXTebrMBbjGtEh1B8hIHuR5pTqDMPJVjNNJiGJh3Ud+5egOytZFEfstJ8APu1/f/D6yZNg9woTC9aYFdvUZojBAbFoFGCzfZzNqZHNr5NrXtU0ZygRNEn8DuydYnSGqMB2O+5k1PolDXdvHONPA8E63rnfblrf9CKpBNHOFs/qhd53RM/T6dMoy5Cs1043sT1NN1VLQUCgIPG2P2fAMDBZ/Qhug744hEdKZg5K9cU2m+zIoAnsL/66S3dmhhWZcLFrntRGiBtJdNbhYL+SbDXSERSWSt8fbQY8HgSbDsl0uJKi/MEhXnHRCuga8WU5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfHUVsaS74Q32GyeV8yna557mBdX3sZj1MXxTDzC/dU=;
 b=nPZKtr0Yl0Sbysme2lLWG7wvmloCBEjF6NjCmbjJ39Va7OvybOfEAiMts8rwczMJwWDpCiJUOleJbzfYXjrhw1j0Ie2uQUgioSjVdj/0sEVWkpkIXi7nHUtffiH4ROEKSyzCCV4ew13wOjjX35hg6/8/H4Oxo0ZzokU905C03a+l64zO4h5djkhj+Y8cONyiWT/SWzTL2GbE3G/cXCmzVAErkHllCmOsXEYIUAyLw6sZq4wAp8i/NjfP9MvAp2gqAhj2Toa82SLXm1bBt+9LPBqvtS1VkgVnQt/+nGFYthsl/dr4sP9Qi0HmrSEWdZhRTIt+64la1MBpKv4dr4dqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfHUVsaS74Q32GyeV8yna557mBdX3sZj1MXxTDzC/dU=;
 b=UHRvf95KcGtor5AfpyPIin5ntS2S0KB6QXRcAfEXS6mMSh3Ci9xy0pTLtq9cvKDwBPU74KLMvDC2rccVt6EvbKdU7vJtzj1OC6CNkgvu6cNV+C38NJN8uh0NrMcEqH+QNsJfHVBBG7U1PAQZtVcBtWrF1FvZbJa7a/mTA1l6PGT0l5CugLxV4tA77LiTBl9JQBSTJIusLMsn/Z0qgtz3IpeBLcrdIa+zoyfoI3efKK/NAPO8nRWeq3Ib+UCbixneSA7oBbs8QcCR5YCVRYjDB/Cl2yw7ObtpamHYLwhLSl2BQXFqMvzIdSmOPuDqd2qUTRuTglGk1/tDyWXMZA3CPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:00:03 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:00:03 +0000
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
Subject: [PATCH v1 8/9] media: chips-media: wave5: restore the display flags after a flush
Date: Wed,  7 Oct 2026 10:59:45 +0900
Message-Id: <20261007015946.53-9-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d98cf7eb-3baa-4423-f874-08df2416b37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	o7+BjtKvZHtHHBFy4w/cL4RhSzpamI888CeUsOf6LsLETmZkAN10Cl2LSnJSFm+IGswTno385QY7j7EDEx/naLTHAb3iodpSMx3pjCi7UAq5NjMSjG89xPx4tokN6p5Rr9yuHNcVtTDL2h+yz6PaaskiJsJQpJCBuwLet77Z1pzJHMWuihW+JkcwdBQc81iatKH/9hpYsvJyKUiJABSZVCALylgj5B+RJkv+ALXqqKc2fHOFv3f2Sw1o08SMP+WKjTlhGLtWpDXedLdGvxZnR4fhQsJJWSqGcGjA7Wo6QoL/O+X7pn1BQFJmdfdnFALxNEVaLtDOGAWX2hR5mSTBN4mRZWqjdaNXrx1w0lf+QpKK3l9dgKUo0//l+AD92f4jOg/tYLVVIP1KX5xdlDRNNhf1+TnzxXwqqCSmzfE/KifishYU4FJtZsaddNuOQZJhgyq0+dJrHz7/eSZYrIqHVe70aPYvs9slImTymAej06pJerCD1xyh6PoDv1+wxZfprScZyEDEQ6QgO44ENQr5Tpa0Mc4JcHYO/e9fAwccqalp/fraVy1Dc9cYrO5H+A9zGC0BkUz0/pbY0f4Q1n0GYi3ymCp6zgc0F80CcjDleRGVwPmtHCr/gh+PIZgS37j3vRnrGUNJnQLFt4r14Q6rnwmDEapFzradrYl0W7YonjXpKaKp/f4ZpaMEE1yQ41b25JKOaWe0kn/rOMmQ912Gpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5B0zs8/iIckar+iCGQnc9hENYvIftEe1NuEf5c/4pY/BmjsiduJ8Zh+iZTAP?=
 =?us-ascii?Q?mShVYsMl1N5jgNuaRGvhQTeyvk7frq1uzZv5T7dl0BRZYvrDTm6ctyLtJsa1?=
 =?us-ascii?Q?Or9SiAJ0EAJkAYqTCuWvhpUFA5uuTSk0Y1Ygm4dgQNa4jm5dyjICpnbN1vdT?=
 =?us-ascii?Q?LBtnHxfZ+vWzxyJfZgGj+hx09arsxBOIN/R2TZc/eimKTqlji68MUfa5x7LL?=
 =?us-ascii?Q?qfxdULPG+zuntdYYgB3cTi8qKnomBhLvglLtJU/gQRix9lByOs4lU24Gk/Jg?=
 =?us-ascii?Q?rE6fstdLzeCGDE7ih9ldGHjb5K36v+FL8kBeiqho8+cUDLwqOM4QTQimM/t/?=
 =?us-ascii?Q?ZGUfv2FcFZwm3G3cGcDiI1Cxv2pZWb4OJfCGEjOZ61s3ob85v1Kih32PPozX?=
 =?us-ascii?Q?7RKWQUNc5PzVbtpKJF9Q7EC2W4NTNs/r/Obo0laRzZN6aVkjNqklB4t+6D68?=
 =?us-ascii?Q?zXfpPfC46Jrpg++VEP5oZLDIZyv+qmcmcvBTL9a+Y+ATUN0zpuYsPNZWu+1a?=
 =?us-ascii?Q?gYBpUDiya2HSr/RZEBEgKmSD1k7hvdo+iNbFMqQGV5pOsf13ub8Bn8GuM05o?=
 =?us-ascii?Q?+m0GuiO1GkQTsih4vui1SurVLRWoQ2RErRNuS6+ZMCPZcHwc8M7ieei32Ed1?=
 =?us-ascii?Q?3RCK5F1gaOjgMNbSSWz94ViHS0oTOzZCDkiAR/RmDJGJM0KpHL/my6xR496j?=
 =?us-ascii?Q?64cg3pe7JdIB8dkFyJFnSQ1i3m+vkA9gUsiGO94ga5TM4hLdq6V9QOsqQc+v?=
 =?us-ascii?Q?RBoorSIH16bPBot+zgDeCpAlZDA9X4Ug7hYYpsFdz29vZbkQsxMfzPLga6J2?=
 =?us-ascii?Q?Q6e6KbPT9Q2Uq321jK2NrENfiExKztg+3RND+fYPj3n7iFxVda3+MAgRpoVN?=
 =?us-ascii?Q?VjLr6W5mTd6lPUuQUBAGNwpkg6hu6m4o0Yh/XYWr9doAWQwk4ILkBg3pz9s1?=
 =?us-ascii?Q?k515fWl1E2VLjMcCgWnij7EJZPHjd3EkIazLpuSTXpfsyvB2qy6/umgQIt5I?=
 =?us-ascii?Q?TOYrCdZzdRsDp2S3iaIJIYD22jCqYZwvJPbJRlPvafTqrny669i6Y2y+LGFz?=
 =?us-ascii?Q?g08Zt3TJpgQsAGRDEItdXMkVreL0tHcM9ubuurY0qPaSbBorKsMDr1ktxmJe?=
 =?us-ascii?Q?5BL35DMxgSFZCOtpd9rb65Bo0TX9hA8tqEpK3Bv4ux8WFpjRivtamykbuZXf?=
 =?us-ascii?Q?49QFbESHZC/zCG0Lf7nq+nmSW9USpzGtxdtcpIXi1/K9hYu7ISdgkM61ZyMz?=
 =?us-ascii?Q?PrTRfKoJAVXEypxhzOsb7JG9b/ZX+MYlx5sMOuyGvuBkve/A/GBYqASSN45i?=
 =?us-ascii?Q?gACCcYcedTHGSVffQI8aCGI/s8tkEylZUAOG59LZRTlTm4M3bCES0gyQLzx5?=
 =?us-ascii?Q?n0mapjEY4Gkj1wq6CuyCa5VnbktJtTlR/sK74madhPiH5e+MKH3kouUgXHWa?=
 =?us-ascii?Q?6ifvPF4nXoqyejUTNOMc9jtPycoqsqfeQreuDaMDa/B3aKi1LdNhSz82ZTk9?=
 =?us-ascii?Q?o80SnScMPwHKTYjWYWaUlVW2Ybc91uElAOCoiH5t0mo1yYRL+F+bYQuPiy/E?=
 =?us-ascii?Q?mib2epFR5tx//wBBqr+Us08gX5B2s/jKylWwUyUCxYzvRJcVW+LTdE/PaH7e?=
 =?us-ascii?Q?ULMyM1MNGYqijEOqKghv4nHorKtCWQTW9YhH4slDuN/kXwlcVf2zQRfjIlB1?=
 =?us-ascii?Q?YrAhxXMrsrRvLOe/ZCvEq9z8ZM8nbRE2VUs5UZLtGRn+G40tSElvK4rJMV4R?=
 =?us-ascii?Q?DGAa/rCgbjI6ykDZK/HLy3Y1NJt77fs=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98cf7eb-3baa-4423-f874-08df2416b37e
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:00:03.0311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zB3zIxR38xJyaEsrAVNYz4OAYfu1qQcWa1qtr4cI11USk/ZzuHPyoCbOvN/YrYa5VDbZqj2Ojk/Jhs5BncqVP+23hLOKTf7KAsHpzjzeAf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

Flushing an instance clears the display flags, so every frame buffer looks
free again -- including the ones userspace is still holding.
streamoff_output() marks only the buffers that happen to be queued when it
runs, and userspace clears those as it re-queues them, so the buffers it
kept end up unmarked.

The next pictures are then decoded straight into buffers the application
owns. finish_decode() cannot find them in the queue and warns:

  wave5_vpu_dec_finish_decode: invalid display frame index N

A trace of the flags across a seek shows it plainly: at streamoff the flags
are 0x73, only the two queued buffers are marked again, userspace re-queues
five of seven buffers and the flags reach 0 -- and the two it kept are
decoded into 8 and 12 ms later.

Re-establish the flags once the flush is done, from the buffers' own
states: mark everything the driver does not own, hand back only what it
does.

Derive that from the vb2 buffers rather than from the m2m ready queue. The
earlier per-buffer loops walked that list with v4l2_m2m_for_each_dst_buf(),
which takes no lock, while the interrupt thread unlinks entries from it in
v4l2_m2m_dst_buf_remove_by_idx(); walking it here oopsed on a poisoned list
pointer:

  Unable to handle kernel paging request at virtual address deacfffffffffcd8
  pc : streamoff_output+0xe4/0x294 [wave5]
  Call trace:
   streamoff_output+0xe4/0x294 [wave5]
   wave5_vpu_dec_stop_streaming+0x244/0x2b4 [wave5]
   __vb2_queue_cancel+0x30/0x278 [videobuf2_common]

Indexing the vb2 queue directly avoids the list entirely.

With a flushing seek every 2 s for 180 s through glimagesink, three runs
each: 4, 4, 4 of those warnings before and 0, 0, 0 after, with no oops.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 77 +++++++++++++++----
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index eae738df270e..e52853e89931 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1088,6 +1088,45 @@ static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int *num_buff
 	return 0;
 }
 
+/*
+ * Re-establish the display flags from the buffers' own states: the VPU may only
+ * write into a frame buffer the driver owns. Everything else -- above all the
+ * buffers userspace is holding -- has to stay marked.
+ *
+ * Walk the vb2 buffers rather than the m2m ready queue. That list is modified
+ * from the interrupt thread (v4l2_m2m_dst_buf_remove_by_idx() in
+ * finish_decode()) and v4l2_m2m_for_each_dst_buf() takes no lock, so iterating
+ * it here can land on an entry that was just unlinked.
+ */
+static void wave5_dec_sync_disp_flags(struct vpu_instance *inst, bool mark_all)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
+	struct vb2_queue *dst_vq = v4l2_m2m_get_dst_vq(m2m_ctx);
+	unsigned int i;
+
+	for (i = 0; i < vb2_get_num_buffers(dst_vq); i++) {
+		struct vb2_buffer *vb = vb2_get_buffer(dst_vq, i);
+		bool driver_owns;
+		int ret;
+
+		if (!vb)
+			continue;
+
+		driver_owns = !mark_all &&
+			      (vb->state == VB2_BUF_STATE_QUEUED ||
+			       vb->state == VB2_BUF_STATE_ACTIVE);
+
+		if (driver_owns)
+			ret = wave5_vpu_dec_clr_disp_flag(inst, vb->index);
+		else
+			ret = wave5_vpu_dec_set_disp_flag(inst, vb->index);
+		if (ret)
+			dev_dbg(inst->dev->dev,
+				"%s: %s display flag of buf index: %u, fail: %d\n",
+				__func__, driver_owns ? "Clearing" : "Setting", i, ret);
+	}
+}
+
 static int wave5_prepare_fb(struct vpu_instance *inst)
 {
 	int linear_num;
@@ -1542,7 +1581,6 @@ static int streamoff_output(struct vb2_queue *q)
 	int ret;
 	dma_addr_t new_rd_ptr;
 	struct dec_output_info dec_info;
-	unsigned int i;
 	struct vpu_src_buffer *vpu_buf, *tmp;
 
 	inst->retry = false;
@@ -1551,14 +1589,6 @@ static int streamoff_output(struct vb2_queue *q)
 	list_for_each_entry_safe(vpu_buf, tmp, &inst->avail_src_bufs, list)
 		list_del_init(&vpu_buf->list);
 
-	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
-		ret = wave5_vpu_dec_set_disp_flag(inst, i);
-		if (ret)
-			dev_dbg(inst->dev->dev,
-				"%s: Setting display flag of buf index: %u, fail: %d\n",
-				__func__, i, ret);
-	}
-
 	while ((buf = v4l2_m2m_src_buf_remove(m2m_ctx))) {
 		dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4u | index %4u\n",
 			__func__, buf->vb2_buf.type, buf->vb2_buf.index);
@@ -1575,6 +1605,20 @@ static int streamoff_output(struct vb2_queue *q)
 	if (ret)
 		return ret;
 
+	/*
+	 * The flush clears the display flags, so every frame buffer now looks
+	 * free -- including the ones userspace is still holding. Only the
+	 * buffers that happened to be queued when the flush ran were marked
+	 * again, and userspace clears those as it re-queues them, which leaves
+	 * the ones it kept unmarked: the next pictures are decoded straight
+	 * into buffers the application owns and finish_decode() cannot find
+	 * them in the queue any more.
+	 *
+	 * Mark everything, then hand back just what is queued, the same way
+	 * wave5_prepare_fb() establishes the flags in the first place.
+	 */
+	wave5_dec_sync_disp_flags(inst, false);
+
 	/* Reset the ring buffer information */
 	new_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
 	inst->last_rd_ptr = new_rd_ptr;
@@ -1615,16 +1659,15 @@ static int streamoff_capture(struct vb2_queue *q)
 	struct vpu_instance *inst = vb2_get_drv_priv(q);
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
 	struct vb2_v4l2_buffer *buf;
-	unsigned int i;
 	int ret = 0;
 
-	for (i = 0; i < v4l2_m2m_num_dst_bufs_ready(m2m_ctx); i++) {
-		ret = wave5_vpu_dec_set_disp_flag(inst, i);
-		if (ret)
-			dev_dbg(inst->dev->dev,
-				"%s: Setting display flag of buf index: %u, fail: %d\n",
-				__func__, i, ret);
-	}
+	/*
+	 * Every CAPTURE buffer is about to go back to userspace, so none of them
+	 * may be decoded into until it is queued again. wave5_prepare_fb() only
+	 * re-establishes the flags on the INIT_SEQ -> PIC_RUN transition, which a
+	 * plain streamoff/streamon of this queue does not go through.
+	 */
+	wave5_dec_sync_disp_flags(inst, true);
 
 	while ((buf = v4l2_m2m_dst_buf_remove(m2m_ctx))) {
 		u32 plane;
-- 
2.43.0

