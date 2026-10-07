Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020125.outbound.protection.outlook.com [52.101.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D8351C22;
	Wed,  7 Oct 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338414; cv=fail; b=Gb7Z74GbVZQ4ZnHs944FTfJ7cYg4ExdPqIfmFO8WKizclZqIkJBPWjUwlhQAtLz6Z3HT/7tmWDVwWWjinpkjC6aRQr7XV8peq4ZkkfmSnBC+sVJjKOZ5l/TjX3eIZT+6HMfEiIxMTQ+NOIaGE9AJUGDtcop9I3FfnlZMjbIsQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338414; c=relaxed/simple;
	bh=1tRPLHo9foLey5xslVYoDtheI5WkUX7YWmcXxnljtxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QEUvRO5iKf/EErnOZOhoHLEC+PpR8o9RL3z3VpIKAg7vPk2smgyZ5h9TjpVZgT1nau2wvdXejCGozC1JudP1QNqE88g9KEYVv6CJgOF/mGoLoiWALAIzmUIYuy/hwnkhpsesRSqf9NkrWXMX6fkqf6i6ac3UImDKTmIWmHdclhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=fiC3xJgt; arc=fail smtp.client-ip=52.101.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="fiC3xJgt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J744T1nPqQyqwxo3VDqDacCwZF03I/GkSoy+UH+P03kXP43BZXARSWq7PLrXa5K2MGTt0jtfVHOEPq0tPbILQ3ZXIflkcywHKW/OiMCpPcLS3i0L5weB/RR+d4haXut1HL53IYBn5Uojr90vu9Lsz/9mcK42RLOoUSO8xEGfe6Xxk9GIr0iv4vof8JtPYYgtkKG+O5cTJBciYy2PsDxY6hzkKz4I3NmeAQ8jIhwhEGeOixzG/J/JvRtW2CJHeJDcvmQI78CCk7K0fJ+Z/B5Vv46a4EEuvB+BMp+73Zt7tbzEw+SpKIyGnVnM0+90PETYUQILC/xud1Thq+7Wkg1HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrBVRPGD+699VOH0oPMnq1lXTMwfJkzYgPbURKIyqPQ=;
 b=bTrwAZuLJeYi3z2Yrz6dnkKg2ltlHSEJHbfgrbLppsVSzCGnFCLCvBx07Vx3DpevBsUIWXNMJ6vgUOwQlMQfGo5mA1V4JODdTJaeEcV6j+OnYgzyf1m8+b2C1pxniH/tVBhJ82r/4vtZhvfsFsnYjlS2GtL8tXNKrux2YkhOjUNV6pxMvgUqiB+4fAzz9D8EneZiHjp9VwShaZxRdnkFFol95x7u5FFPTTnVFSlgoLG+9OBb0Whl93puMFdmZ6/tfQFCP0iOMuqxN4qy0iOLH+l8xEIJocRjkeJnakOxUEERsmoT7PIY2LLuSyE7NejwVbnXX0cHShlomPo1d/hB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrBVRPGD+699VOH0oPMnq1lXTMwfJkzYgPbURKIyqPQ=;
 b=fiC3xJgtdjobmRPadJwlg0BTPKh2hNHTBtxeNZPeXe7q8cE2eWhUI564KEnGQkqMCwTulueCiEzuTuvCpYafpD7/fh+zuoptATO8XYr/36vxa/H/rMKoMsAu+ltqCWGC3y+uLsT5WEXeaxd3b5p7MRJkClTIYTJXrILh5PTzuAmEILX6TjBSzm3WuJXcqB6vbkxMj+8GvJ5dO8smIoRBsnDhz4sAf15KuQ1wUB9CtMUQuO5KJ3p/SQ1d05JG9Hl1Um4g7ZYwN7r+takbU8IaNvenrrpHrkSY4iHNz/Qhw45Uffo5dye4T5E3Wui075b4ElL+eIoQOgmhObhsy1TWSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 02:00:01 +0000
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f]) by PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
 ([fe80::31e3:e5:b0a4:2f2f%6]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 02:00:01 +0000
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
Subject: [PATCH v1 6/9] media: chips-media: wave5: decode only when the ring holds unclaimed bitstream
Date: Wed,  7 Oct 2026 10:59:43 +0900
Message-Id: <20261007015946.53-7-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96d9ab33-8de6-45e1-6922-08df2416b262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|5023799004|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	zVFiqghvk3QRil4WCd46cmTC3P3bjpD2djsQR0C44J56h4xptbOxuszU0WNgrI/mWQYa/Ltx1RqrpFwt5nQ6esX01SKlvAu6uvcOMeX7zxktRsh3X5SpvYk/X+55Mi5M3+Lnp63oycN8YsuEbTrrxysyEQMoLWJCb09I5XUrFfpEFpwVz9hcKktrhdF+qlF8xIEMbBUUbWH9rz+uH3LNPS0Bs1GBj6GmPVnXfLYvKIzJ2y0E+yoim7xEcp/3hlDLtrB9dmM9qVthfLdmfSjn4tOy9F4reJXRcE2z+V1oDzscXg6MSAyZGXbmSqLj3dVpJYEvM6iaUmj06vVj8MrC7fMUBHTmK3Sa7HHsSRUrBD9kc7/hO0CUCVkq0VEpY27byhvXv6UZiUBcutvW9BLJaUPuSZFVYFjxr3CLXFDua3JGHNf4Par6TKvRgL2ZtxUmEqE+Y7dzyutKu4VYJQCgahmR/NEukDjwwPcpcvi2LZQO2ujT6bNzuogE9BsUryJHmx5B0geDU8qrwf0hZxfE8pbW+ItqkciddcvItTiJq1gkLxJLUiQ20Unr/YOsl4Ttnl2yqRPjpzW5bOhEA7+5zWX0rzmiU8VjdqR/k8su9+anxj8b+dlwbshodBbdKBceD73zG865mmuNbEmf1wHTF0jGWaO29a50nD46i5WMHd3sd6aQzW6NDe573TJ4N5vzo7DXs3DDOW2I2SfqEQBxbLZ3Mq0twveVsKBap1z+V4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/p3DANhODTy9u/U2k4XtdavlYJB7uGqEXGYEIb9kvDNPGpJc+QukoPBF939?=
 =?us-ascii?Q?X83uWWAFYltygfIs3jaDVblc8LMweBGibGAZMGLbGq6PidddGQzibqanF+aw?=
 =?us-ascii?Q?8tnuADlZ4HfvtMQeOdRtkJ9ShqvfKrveVPSOV556Wk4j2MRzC16AKjq4vAFg?=
 =?us-ascii?Q?xTAqNZV5918/strwiaVH+m/Ty8WQ2v+offDlmuDnNMTjoE+vkT7DYv4aiQOT?=
 =?us-ascii?Q?8/lbkGa10aMeCTEH4SWoroMLDZOSH5YQzw/mNwJDBVT6fOpT03m3Eb9n61Ik?=
 =?us-ascii?Q?+YhoG8ArGFyYqtvNwQuSXyt7tFu7YUsPBKKMEP36i62U8jpxAlXN5miSrFrG?=
 =?us-ascii?Q?tawlM3GiW0xwK3T99zG/4Wx/cQMWsog9N0yYCuaFBT6mDOyIlhBjH2wIX2r6?=
 =?us-ascii?Q?KGch4zoUhW9sSOypi9jvBjaGHiayyWmaimksrlXhRWn46JXpO6ToPWb7B+KR?=
 =?us-ascii?Q?qxE2Ec6VqVhl//eK+C8IkP6+Y6GVxd/dns/PJo+dOUH5Ery5cdqrOv+jajRx?=
 =?us-ascii?Q?5+eWYk5GAKQfjaE284pVEhJBqziFbAMnLJKfX2pHY/jQu5Q2VPL3RoQWTSPb?=
 =?us-ascii?Q?7qCSr6pWclQnkd4FMpAM56DFZ6x6mGTMN2OP/0IF2XC+6E4gmsT3xzfz86Qv?=
 =?us-ascii?Q?PquJSCw1BpqX9Nrv3/paGK1GC8dGj1daXnj502e0FsxmAOlPZJf4tH2LLxHf?=
 =?us-ascii?Q?+0Ej78+kA5mski4Q05/w94JGk0e72/H0YBodKZQ5TBXKjCGd5A1AloJhdVto?=
 =?us-ascii?Q?WJ+mzJ8h0YKDkze2bHFOhFvRtwQ2JNlhkqtBQ07b2lsPcDDkUKkmeNbgvBsL?=
 =?us-ascii?Q?p4E4bAk0crMZW1P+HopOjJF26Ky8CETwETxtEmDLkqz5Hp9FggQSvN729eEW?=
 =?us-ascii?Q?QYZvDecetug8eto+PKrO9UApKV8JFuKp9Sm1BGV0cYr0nOe1OA/6rzHDzKBf?=
 =?us-ascii?Q?XIkUhxdHjcsZcubXwl1NrvgfcnMAaKqAB6LuJDA5Y5831O75ml2Lh23AbgGk?=
 =?us-ascii?Q?mMp43MQ+/GXATQ1xnUE/Ykcy3NerIobq7K/50z1R4lqw8I4ajeA3Vyst3d/G?=
 =?us-ascii?Q?UrpVzdB+9bpsf/5afYamR/zzTHJqQbGx/k/W3lXhrJx1x2/VW5Q39xF21PNd?=
 =?us-ascii?Q?n+8QUGXb/0zl7j9fbC13BlW3DhmasD6Eirsy5rU8L7d0tjN6dtc/f8ipKfNw?=
 =?us-ascii?Q?EwuPw0+KxxFJDI9Qid9oEtPTxop61XIGvxY/ZEq3xFmYAp13TEqj0rSHaceO?=
 =?us-ascii?Q?51dvzVRKtyYoshXXb6wilMhJrI0IIAe4DQK23x+yF82uHkPi4buQXBQfO3w+?=
 =?us-ascii?Q?qzgkP8otdArePaRXE2OWAuUSyXSHX+fgP1AcmwGavydxre3cxtQWxcOYK7iZ?=
 =?us-ascii?Q?xROtwSDQrST4hERwgr4jwt04uO6zsrr+B8SdPAavu67JbgHaKt7O3lea4O9U?=
 =?us-ascii?Q?4L7ELXGRCIKu1QX6Lw9PvykRRUYVMNQU089qC7dSCzYCMssQXChHO9GVeAkK?=
 =?us-ascii?Q?b0SV8JaQAoaR/hohfwtkPmIJajs0tUTx+nyKwonbRDPZ3kKACV+tL95KbazU?=
 =?us-ascii?Q?/XsE6HLKUWlRNpFb3dqLleSbMC7OzK82M9bdMmbAyTCFPD/QfY5eSCcR9yxO?=
 =?us-ascii?Q?v5ULF/uNAAN6OAe6ZKiVND9VOGrbsF26hj5pE8kLGFo279VyXKmE4DktplwX?=
 =?us-ascii?Q?r/i0I0qG1ccmiW5DjrJmzgD6UAcvVE/uIQgYZeUfZAEGRyzbhcMpw484QI5g?=
 =?us-ascii?Q?R+0GGAbRZm8zYmh/MytpeqmIDb2aoPs=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d9ab33-8de6-45e1-6922-08df2416b262
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 02:00:01.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDQgUxrJD4CwW+Ht1s1Q4XwYP4ikwnQJIxc4i9UiDq+sPulw66d4OpErGBwgAqycrv7cMuhAdtybnVcYIHMv5qIv7+1L+j1hLoPp0iUcG5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

device_run() decides whether to issue a DEC_PIC by comparing the instance
queue count against the number of OUTPUT buffers held. Those two count
unrelated things and diverge routinely with interrupt timing, so commands
go out against an empty ring buffer, or duplicate one already in flight,
corrupting the decoded output and producing display results the driver is
not expecting.

Decide on the real state instead: decode only when the ring still holds
bitstream and no queued command will consume it.

That can leave an instance idle with data still buffered. If the in-flight
command completes without freeing an OUTPUT buffer, nothing re-runs
device_run() and a client that has queued every buffer it owns cannot
restart it. Re-check on a 100 ms timer, which a normal wait outruns.

Fixes: 8c5a74a24cbb ("media: chips-media: wave5: avoid skipping device_run while VPU has work")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 62 +++++++++++++++++--
 .../platform/chips-media/wave5/wave5-vpuapi.h |  1 +
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 18400af036dc..0c92b6c9a913 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1619,6 +1619,7 @@ static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
 	else
 		streamoff_capture(q);
 
+	cancel_delayed_work_sync(&inst->unstall_work);
 	inst->empty_queue = false;
 	inst->sent_eos = false;
 	pm_runtime_put_autosuspend(inst->dev->dev);
@@ -1699,6 +1700,31 @@ static bool wave5_is_draining_or_eos(struct vpu_instance *inst)
 	return m2m_ctx->is_draining || inst->eos;
 }
 
+/*
+ * How long an instance may sit idle with bitstream still buffered before it is
+ * assumed stuck. A normal wait -- including one instance queued behind others on
+ * a shared VPU -- clears in a few milliseconds, so this never fires for it.
+ */
+#define WAVE5_UNSTALL_DELAY_MS 100
+
+static void wave5_vpu_dec_unstall_work(struct work_struct *work)
+{
+	struct vpu_instance *inst = container_of(to_delayed_work(work),
+						 struct vpu_instance, unstall_work);
+
+	/*
+	 * Someone already made progress, or the instance is no longer running a
+	 * picture. Poking the scheduler for an instance that is tearing down
+	 * would queue a job against a context that is about to be freed.
+	 */
+	if (!inst->empty_queue || inst->state != VPU_INST_STATE_PIC_RUN)
+		return;
+
+	dev_dbg(inst->dev->dev, "%s: restarting a stalled instance\n", __func__);
+	inst->empty_queue = false;
+	v4l2_m2m_try_schedule(inst->v4l2_fh.m2m_ctx);
+}
+
 static void wave5_vpu_dec_device_run(void *priv)
 {
 	struct vpu_instance *inst = priv;
@@ -1717,14 +1743,32 @@ static void wave5_vpu_dec_device_run(void *priv)
 		if (ret < 0) {
 			dev_warn(inst->dev->dev, "Filling ring buffer failed\n");
 			goto finish_job_and_return;
-		} else if (!inst->eos &&
-				inst->queuing_num == 0 &&
-				inst->state == VPU_INST_STATE_PIC_RUN) {
+		} else if (!inst->eos && inst->state == VPU_INST_STATE_PIC_RUN) {
+			struct dec_info *dec_info = &inst->codec_info->dec_info;
+			bool ring_has_data;
+
 			wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
-			if (q_status.instance_queue_count == v4l2_m2m_num_src_bufs_ready(m2m_ctx)) {
+			ring_has_data = dec_info->stream_rd_ptr != dec_info->stream_wr_ptr;
+
+			/*
+			 * Nothing new to feed, so stop here and wait -- unless the
+			 * ring still holds bitstream that no queued command will
+			 * consume. Decoding an empty ring, or redoing what an
+			 * in-flight command will take, corrupts the output.
+			 */
+			if (q_status.instance_queue_count || !ring_has_data) {
 				dev_dbg(inst->dev->dev, "%s: no bitstream, skip\n",
 					__func__);
 				inst->empty_queue = true;
+				/*
+				 * Stopping with data left over relies on the
+				 * in-flight command to bring us back. If it ends
+				 * without freeing an OUTPUT buffer, a client that
+				 * holds them all cannot queue one to restart us.
+				 */
+				if (ring_has_data)
+					mod_delayed_work(system_percpu_wq, &inst->unstall_work,
+							 msecs_to_jiffies(WAVE5_UNSTALL_DELAY_MS));
 				goto finish_job_and_return;
 			}
 		}
@@ -1954,6 +1998,7 @@ static int wave5_vpu_open_dec(struct file *filp)
 	spin_lock_init(&inst->state_spinlock);
 	mutex_init(&inst->feed_lock);
 	INIT_LIST_HEAD(&inst->avail_src_bufs);
+	INIT_DELAYED_WORK(&inst->unstall_work, wave5_vpu_dec_unstall_work);
 
 	inst->codec_info = kzalloc_obj(*inst->codec_info);
 	if (!inst->codec_info) {
@@ -2048,6 +2093,15 @@ static int wave5_vpu_open_dec(struct file *filp)
 
 static int wave5_vpu_dec_release(struct file *filp)
 {
+	struct vpu_instance *inst = file_to_vpu_inst(filp);
+
+	/*
+	 * The unstall timer dereferences both m2m_ctx and inst, which
+	 * wave5_vpu_release_device() frees. stop_streaming() disarms it for a
+	 * streaming instance; make sure nothing is left pending on any other path.
+	 */
+	cancel_delayed_work_sync(&inst->unstall_work);
+
 	return wave5_vpu_release_device(filp, wave5_vpu_dec_close, "decoder");
 }
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index a338e39be1c9..abfe94fa18e7 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -9,6 +9,7 @@
 #define VPUAPI_H_INCLUDED
 
 #include <linux/kfifo.h>
+#include <linux/workqueue.h>
 #include <linux/idr.h>
 #include <linux/genalloc.h>
 #include <media/v4l2-device.h>
-- 
2.43.0

