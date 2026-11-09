Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.132
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202155;
	b=3ojQizGcJjcCvgTfDNoePziQEtXURJMZbT2L3XVyG/xIbfxxJNTubY8NjNiNCQLnIr3k
	 PWYZCI1S/IwCd1bcuGN8hsD/cZV5H7CriJHjE6RDjVS8+ARSI2+TfXvbrUJbVRh3F+6nl
	 dqJQ1tfocLL0McZgkXcmvEFO+9GRuHnLnNyLZ6vMPMdePWiVpTawQh3KCXKhfegCLfDya
	 MHiPkCR2eLYeoaRmNlK8w8/oVhb1l/CJn+qlkpfnkeeqFsQLy/lQCMAptz5RfS1Cn/9J2
	 nz6IZTI/IBHQJ8YgfDD+8ga4r/qfIHxe3dOOlx6oNtEdunfMc/lyj9QA9STi/O2a3qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202155;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
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
	bh=FkMF/rR1+bCDX2bIiL6jfYNZzFGg+AWeVb/5zhObrhM=;
	b=wy+3V2xPLmtBmB/CqIobG3Fm9FCOososOU2ktMrF30YXOdH+Ub6mLlCqXLDQ7TIZnUWK
	 CxhW82N+ND8EOZrohr3iNf+1RRqAfGqHReTgz9/Qe2AJc34W+wnqgwTNp9iVI3keW+upO
	 Q7LxWB3kNDV9OYsBdeh6D3W5C4h3y4amya886pb0/yvBdelB6yazNOH2sRNGCHh+bGQsr
	 DiHKbZbKTtyu0Rc++imPf2kNrslZQnW0JWKPIEdUG2OQt8xD5szb5fAxIjYoe/LKi4B/o
	 ikieqKyKTdF+85lV6grenSljN20xsFB9fE2gif0JbFjRnvPin8TymFEz8YfXOIulL7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=bODU0SmH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.132
Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11021132.outbound.protection.outlook.com [40.107.42.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E6606A33C;
	Mon,  9 Nov 2026 05:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 731E6606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=bODU0SmH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHI5iZHUKjay0OPMQILtaFnxmbLJIwwdsBYffGWngrpvf+NkSLRy7xlxNO6AFbrcWestE3vsV1u7wnK3d4x1+ToYsjRZOYLW9vxUnC1bWUP0VDnnJ8wZHew4fJQckZvD0noeh2JWAVVQiW97JuEstmz6GhUDWgnfEHDiXWkS+T2K3Dvr413V1DlSvS5MW1mIlpprbjAD12OepXsqtdft26eYg/61jZWpnDHh66M9p9JsVcouDdUhMttxgZ+ua305R3sxoQ9mU95u46TlWpEukoChmTD5atAPph1EW/NJkAPod2uvXIKDizqvuBwwL4yS1QGhko+G45JDes1mF7B5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkMF/rR1+bCDX2bIiL6jfYNZzFGg+AWeVb/5zhObrhM=;
 b=ROxMr4Lc2r25n+RBjdFPZttM1cY/ssEjlT8D4WZoBIXWn6b7sElTOFYlkQH6qA8g5/sUbmsrITLJ+xnRgw+dWhz5esS9JwVp1wnG2CS3sgrw0eRBpX/QqwkFKzm3Q24md6cq8R/YleQtsHyoNxZIunYV0vwwJqa2AZSHEdVCAvBSgEvhqmWZirT1RsXncjfWJchSDUZBdknz0zlKQamhi2Jpo4leAZ4iBUfSMPze/XhU6vq7WJdCR2SFy67t3V21MVG5cpP79fEEc32/SjWU4iE94L6IUTTywt8Yg/wPtcrMXYafDp8DgobZpRmhdc1oZg+lV6LCHZmE2dwRjXPhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkMF/rR1+bCDX2bIiL6jfYNZzFGg+AWeVb/5zhObrhM=;
 b=bODU0SmHo9jlXHNfFaJd8/eyVvTfzZ9mTcIg3rUnVOeYhKBNYdQDKEApyiKwqmK81+GeJA18PVIT17SqehptVY7Ivn9m8jI/GgvOrbsIgj0CD8kf2I1INCbkuCeqTFNhKK7OFjhlg9qsjEAZfG1vPo1kRSlQeHWaoEhTXRrY0Fv9i3sGaslv1ujaUA2Kt0tUK9s9TBHzRGCY5FI7G1W8XThtYhbdOGSmdug/hVksvBUIiqYKSMQ0KthyoDw08wxH1V92tB8OZQALPNnqUPA4FGczQVIKO86TLGazaQoT6hsZCjPyZzRmXy1TIUjq2Ca9g9csHhNsEB794PNuBJ1JOg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:04 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:04 +0000
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
Subject: [PATCH v2 1/9] media: chips-media: wave5: Ensure Atomic Access to src_buf list
Date: Mon,  9 Nov 2026 14:28:45 +0900
Message-Id: <20261109052853.110-2-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::14) To SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:f::14)
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
X-MS-TrafficTypeDiagnostic: SLXP216MB1148:EE_|PUVP216MB596218:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b5fc71-1010-4f13-8767-08df3e225e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mc+jvNfohxIUL9/+Z3VdTpCG9xn9BHgSxyazK+/Dhm3B6aKnmsnKgWO/3yBEKBme2opOgDKT/AMxKL+Li+baSRujGBLR60X/OYsj/oSRAydko9tfvc/986OaDFodl/nun/SVW4gie+r6Nk0RmIeGKN0YVuZS0nzI13oHwdKGZsekxDnKT5QDnKDEUSyEJ+F+u+1Dgee6zVK0dnfues4OamVwzvXqd8iw5a9pKxJ7Y4i2f1vRBRNv6nma8CnVZQjixTM05+bNWGPSbVGnpmFadf0sWzx9sDfVqOq1AVnuAUGdIRQQXCV1LGVhHRyWlUsaqcKPYks5+0tHZwXC9AGEAABDLfHMqksTzwGCxquLohjTbA9qaV01bUzhuNh/opj7zFftwrmSCGAZ43uGUESQw9TO2DT395dwRh5DJrTk7DAGV3qB6Qs1u6Eb/jPfZ4CGTTLtP1UbfTbmvzfr95WEEzHyezVwW9HUETrwWG6LLlTUaLYf2V05qzgVBWvA5d/+Y59hbNyY9OEsPjqwjgoZIQBBVTd3CqrVJgMYqbtX0HEmEe6cmN3/qVTsv8YWKABAmRZtF1PwwkXDGYchMDA7VbYfsgdEK5ofzIa2pTNtjbRZg1zNlJ/NH0Bua5NhLTnaHKXN8ETp7Ge4igMQMj7AUsap15dzq4TjpcH6NK15HVOIklUV252VgJYAwk7RW4YSQHXU1FKsqJKjH3PdsIHRtbCFZ9ia06miTIjBDPAON/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WnFoXZdgv1XC/O5zyknfS7G7ev3yHQZfRFWFSFPCEGUkHwTTWre9pHzv8Qjr?=
 =?us-ascii?Q?468QBx8iYqblUhNBXuW+nwoDvlZfdo39WpDRBb7XUEtgUKWfR05mEcGTNE14?=
 =?us-ascii?Q?M095yUMadZMj2Uoq/xUm/q2v4BF1bbowclOHvORoNt1kifi2qqnDrrmz5AVd?=
 =?us-ascii?Q?agpSe6FQlsk6RYhRIf/8wEVwfgDxwccptiubfTZ1mopizWr6YhdQ+9Y2DeBo?=
 =?us-ascii?Q?gDuIR+AV6OHGK8dLSk86m1iTVLrwu8BE40yg+Z2M101WGNVQop0uPwkYub8r?=
 =?us-ascii?Q?L5kvmRVB8XIVLUURE7EzlqB8kRnGGnnhma9KV8rOyJlF6e7o2wHEKRuW9tSp?=
 =?us-ascii?Q?OHcedd6jjniaUQ6P2TJuBk5O0nxJTfEcIvCQNb6VK4/sGABnRtrCPHtukRBf?=
 =?us-ascii?Q?yPj86YVqzLU5KlbEuQysNlJ5lDa8azeZKuuqUnP/g1o+7cdHS9EL1TSySHII?=
 =?us-ascii?Q?ILBfLs6SaQMBJRe5CtL755xLWP7UplbUXOo38yArJ76B9eItuGR7QonL+n9l?=
 =?us-ascii?Q?1eRJx5WpQnagi3cWMsaxBjJqsaiyYWroyrpc2TDxI1R8puSpbsEHwowAqILP?=
 =?us-ascii?Q?EMYpkC0z9615c2COvRonoyBpjueu0yi4hfrZ9BT4ft0Ql+RdMGfPJSfDWObb?=
 =?us-ascii?Q?3x+gvIPWBqJjcHYKkwa/GN2ZqZ2zwLKi+mt1rcrvT8XEvru+CMYt0B/ShL7+?=
 =?us-ascii?Q?Ze+i9kQZgW04XBc4eLh/DdPzOvDuBO1x2FkO7F6BpOg924V4ofrOfURLRWwB?=
 =?us-ascii?Q?qlYcfIgG4VReZ5mx9evnVegaVHqVZzMkfBMZmPX1zii0DxrY26vWMaZ+0mxv?=
 =?us-ascii?Q?AZ0AEIOLM6mks0l5YU0DMeMc7XHU6WTFYb1SWndMTUHBRrlz1rv2X0mfjeki?=
 =?us-ascii?Q?tmfgvDpXHVIA5xzVgpDJb9AUsQqSIoevYyg6Tfx2+6KbgsyAO5mX/K9vTlvu?=
 =?us-ascii?Q?yzRRWB3hQT/kDiu9I7faDFDQI4o8YrW/XabW2Am4v11fSIQeMwnVj2/3Gv+/?=
 =?us-ascii?Q?1Za2SJQCyB3AfS848zLBEoUOFTYD17v6WBPwDfDcuZj7V8194GKPfRPrPodA?=
 =?us-ascii?Q?rtw9EyARHiuynbR+A4GCU0CluAixbm3epz76ifEJMrEmy6aEGcTmLFFjdfMP?=
 =?us-ascii?Q?/x1xToaJg9sEeWZfEt871B5eefCLccMCzKNS5unEOe7H9vqzk2oyzJJitwi0?=
 =?us-ascii?Q?UCZdrTyAyVoVl3DMMW3urmK/6ePMAMdzaFZ8G2Hy4TJ5tXqXcl+IaQ2m9Kbj?=
 =?us-ascii?Q?1XfMIYSLNjkKmTBTS80UCdpH4vLKGGnK3quQD51tXxa8iuC7xPE0ZxRzpBbS?=
 =?us-ascii?Q?HXt043mV+8zTpdboHy2DXPk5BBIbS9vXqrVk8SNyacAYdtCHwaKGauFdudAk?=
 =?us-ascii?Q?CLGcU5LtMDPqgOOpgHWM4ZebuzLH4FIRH2Hl6egdCx7RBhqtdh1EayxAc977?=
 =?us-ascii?Q?hDKMbja26Fz39viw5aVDiAu5kGftcONTXw5JPFCKRBztAQSl6Q4Y9oaHd8Bx?=
 =?us-ascii?Q?UAKl7QkoQub5NnC+Zn7S0Wy/1WE9Uu/bktHcKq1NZ35qgbac8jUGMrZLhOc+?=
 =?us-ascii?Q?nYN9KZLcMr4CVTQsgEcwOf7M/HCk68jAIGkqd5zl2JFOH+D/jF2KASf3dOFd?=
 =?us-ascii?Q?fspLiYdmtDhDgHW3bz0cQ9t4JA9WCTGwobhMv9p5L9XtGEDO1qrbrkgoTKLh?=
 =?us-ascii?Q?ysynMGU67JLGwxbATk+eQCuJGpR43/uzNv6tPGmGuXm4hlkpnhZRdAk2w+AP?=
 =?us-ascii?Q?3CV6XaV96dY/lRny4oAbqUkgQhawznM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b5fc71-1010-4f13-8767-08df3e225e1d
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:03.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yst0pdgCtht8OXSDdLW0ELj1iHbKcUty473th5o59S2kSUU98Cr7he+ILeti8n8/xhhYERjDgst++VuwALOB+DcmGsFWqhtEKUBB8lE4ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

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

In wave5_handle_src_buffer(), feed_lock does not serialize against
v4l2_m2m_buf_queue(), which buf_queue calls after dropping feed_lock and
which adds to the ready queue under rdy_spinlock only. Walking the ready
queue with v4l2_m2m_for_each_src_buf_safe() therefore races with
VIDIOC_QBUF. The loop only ever looks at the head of the queue, so peek
it with v4l2_m2m_next_src_buf(), which takes rdy_spinlock, instead.

Fixes: a176ac5e701f ("media: chips-media: wave5: Improve performance of decoder")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-vpu-dec.c  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 6564cf3ec739..5993102e5afe 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -180,7 +180,7 @@ static bool wave5_last_src_buffer_consumed(struct v4l2_m2m_ctx *m2m_ctx)
 static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = inst->v4l2_fh.m2m_ctx;
-	struct v4l2_m2m_buffer *buf, *n;
+	struct vb2_v4l2_buffer *src_buf;
 	size_t consumed_bytes = 0;
 
 	if (rd_ptr >= inst->last_rd_ptr) {
@@ -198,8 +198,8 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 	dev_dbg(inst->dev->dev, "%s: %zu bytes of bitstream was consumed", __func__,
 		consumed_bytes);
 
-	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
-		struct vb2_v4l2_buffer *src_buf = &buf->vb;
+	mutex_lock(&inst->feed_lock);
+	while ((src_buf = v4l2_m2m_next_src_buf(m2m_ctx))) {
 		size_t src_size = vb2_get_plane_payload(&src_buf->vb2_buf, 0);
 
 		if (src_size > consumed_bytes)
@@ -224,6 +224,7 @@ static void wave5_handle_src_buffer(struct vpu_instance *inst, dma_addr_t rd_ptr
 			break;
 		}
 	}
+	mutex_unlock(&inst->feed_lock);
 
 	inst->remaining_consumed_bytes = consumed_bytes;
 }
@@ -237,9 +238,11 @@ static int start_decode(struct vpu_instance *inst, u32 *fail_res)
 	if (ret) {
 		struct vb2_v4l2_buffer *src_buf;
 
+		mutex_lock(&inst->feed_lock);
 		src_buf = v4l2_m2m_src_buf_remove(m2m_ctx);
 		if (src_buf)
 			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
+		mutex_unlock(&inst->feed_lock);
 		set_instance_state(inst, VPU_INST_STATE_STOP);
 
 		dev_dbg(inst->dev->dev, "%s: pic run failed / finish job", __func__);
@@ -1453,12 +1456,13 @@ static int streamoff_output(struct vb2_queue *q)
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
@@ -1473,6 +1477,7 @@ static int streamoff_output(struct vb2_queue *q)
 			__func__, buf->vb2_buf.type, buf->vb2_buf.index);
 		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
 	}
+	mutex_unlock(&inst->feed_lock);
 
 	while (wave5_vpu_dec_get_output_info(inst, &dec_info) == 0) {
 		if (dec_info.index_frame_display >= 0)

base-commit: 58348f64125e9a3e44d3abb275ca7f4e6c9641e5
-- 
2.43.0

