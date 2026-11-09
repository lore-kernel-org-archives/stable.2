Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202156;
	b=s/Zt2I9OqshvLOVrU1yeF58dHfJpOHob4nJ+5Ic/bCaHEJN96VVfqRwaO/cmIE4ZKEC+
	 N8l539bWx+HfTQDrmz1d319igflPna8/eZNq0+jQifdontCtQVK+YDeryXlpNDnyjBA86
	 bIZcpKMPH1tspUaVqNeGCCtEQMsYarKpxZDZwn8mBH/t6l8sqP/Vt72m6jo/20gtcQM9W
	 tTYlzgfz1OqRfm3sMgnfohX4dE1WhZ/WOAvWL4E2ABaTem4znL3/PCVBJw/kdyv/1XPJ3
	 D1NWaBXq8n6un2yy8mvQqMS6gTN4hxyoEQvcLTCDy6bxslBX5E+NmtzSXGigtF48blQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202156;
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
	bh=tH1Vjn6mKbRmPyVnmM33nL8P1zH3kRwCJeN7Gi5l3nA=;
	b=RYOX/X2LuBShUw2BGIAao7XPwzAAZt+/Cbt9YAxDaffdMt2VkLqNPZQ67+znMhgF5K8t
	 qRF7plMjUQMiyHhlu0ScifgM+kGGYCYPAeahVJqqh6UebygzaFTO0Ol+CSRLyayiND4qv
	 xZ3iof9ShUvPvHQAGk1g6md/+O/Rwg9i2kTCUZYpX1e/xKGoJj9tQt9KDFGBSP/VvF/pi
	 wxmYegsrG6FIOkLJJKpYWd5GIXWppAtO8Me9sgVs9L2X+BEdnYp3FJdT352tKZH1naKu8
	 8iOBm+oCNALEH8fV4PXbpc7PtWWWdYz3VlZGm3hhPdco2UCyvPtfsN7WQcj2N8qzxUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=MDfw3EYy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCAC606EE90;
	Mon,  9 Nov 2026 05:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBCAC606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=MDfw3EYy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYyx6q9xAmtVjwHuZKTmU6YQUx7LoFiS2cDrzLFmopu3w1/sPzMquhUXjcsTYngYwrz7CRKOEIyAEgvveDdx+8PK+T/F+3FHxH77xJ4RdCCbH0olHpEuiilDWLXITxzf8VVIYj87KIx8nAUM0Uf1wn/VbQAQ9G+7n9ehGdb9TItYvG8YF4S3mgyMtYOgcfm/7uV4CM38BqZDE0KvYy1IKtrYa/qfY18//Z11R9p8daOwVJM73BHdu0v3EQRriIGJYy6QY83Z3eA0NXGoiA3q4HjX59l8/kuTSWT3qXOJM5uI8SODT7F8PxQ9/4gJZcrUOu9D+pQDcQskfuEN3eUTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH1Vjn6mKbRmPyVnmM33nL8P1zH3kRwCJeN7Gi5l3nA=;
 b=pHo1XbQjfhE6rj9abAbz3EXubHX+wP1RBaOu8ZNTaD1cKQ9mm662Fm802mwBtasICYbfSGC+4+1BgQbzc1Y02gYWiQDNNvHEVuQr4bN1YTkrItbmopahTyhxtTZ1fJKOMuenafYaLCextSJUW3HON649ENZlj/OBtKOfFePZ+0rF0taakKxhYoWAUixP+u0FXlURN7eSETEJc4CuHXJ6oBKVcajpUE27Oth5KFLQ3hLFT20w8KGD8Qf48LiDLBqeLie8Tl482OOMmr7eoC783xiDYu3gJOIMipyyofLZ++B1FGcaDtXoIKPlN34Ja+kYjDCQXRphBqlBfaAp6aN4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH1Vjn6mKbRmPyVnmM33nL8P1zH3kRwCJeN7Gi5l3nA=;
 b=MDfw3EYyNXzf0mbr1SwsuT07stUZGNxkUo7bP2v7RmfvIQ0SvJ+luD1p9nkkX2+UmwwejY28/3A/iGRcHOg6TX8EJalDi34b6DdmvQ3dazh4Q4rtp0nJnt3eQHazTP4qJLhMArftUmYH8eI7jmaBZuDD/xNKcucxbJQnp/rvmSoqN4PVjqrTe+ufFoN3jz58bcpz6QcBjBPdxMrslTRHrz7+Gc14naf2ePNUdr0hKxXVsYW2g1OrOQWwQ1PxkuxrWhwduDKaxcmmt0lBI1efpRoI77ntXR4NWo8c9cnn7o1jBDeipPRRdNrJ+L5Z7CIK6QNj7DCAdh7vAnFBzBb+dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:06 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:06 +0000
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
Subject: [PATCH v2 7/9] media: chips-media: wave5: stamp decoded pictures from a decode-order queue
Date: Mon,  9 Nov 2026 14:28:51 +0900
Message-Id: <20261109052853.110-8-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 062f3041-deb9-4bd9-4b6c-08df3e225f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|5023799004|56012099006|261021123027099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261102124527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PEPu9Ehq1nXB3O4itrU27lBL446QKWs0B9a7tzRR9kUDxtCkCW6vwbOeqvR3wX8kiFvAlS0KupTIgQF23DQrn+U4hrCFK1g7cXw6u5IY8pIo4H4Hhs8yzx2KqZKohC8Zi/e5pHOIASAg9r5gH+iSLWxWR3kGZAUJ+aDf+LmYCg1pZFaqJDBRcR8RXYAhlW/nwRMnyQFaJQXLkitsl5G9/xlyJ/oKkssq6EpKaKj+vHW7K4wcT3k6ueFXhkJu/UF65I2NwMUbpZ4tX/YCGXwZlb5Pjk3DKlrqqW3XOHWDoolqcAtbOOTj9cL9KqM9P9U6/YC4fE5XK2Kdalw36BR6TAg9YRhAWmAC6WVc7GPFNZEQTuoOi6HtfYQH+ppxJfApDw64xWGe9IaO+AdPX7fybU+NOeutU6CJMENGbsh9Lu4S8lxw44aaqaMx2odPwC8r0DU01Jix2wl2q+eam4GEFPUEKhl/voDkL53lselIGQivEg3yKjKFv2cNWmix9O0oaiMPZoCPhW+SGCjOA64vzyKpNTZz47Vv2ZlC2SfegYmx4A89YzY0m5EX/eS1L5GhzfzCfmvAHex1feiZF9CnFog+rodmLew7WoqnyeFsULBFEi0EdSLtdHwLzwJUN5mFtvNRl66VBLINg44jslVquSNaWeppAmYmv5Mz17C7LkhoNFh/R0eVWs09sL3vEshP9D2zcuVA60Sk0Er+Y54vow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(5023799004)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261102124527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2OWM09T62BqlM/7R5Pjz3oucaNvOh1S5HrX/lvMIHt9P69bNiklHcQqr5iM?=
 =?us-ascii?Q?7K7o2rZ/4etLiujrYDV0vdA9jOaqngVdna4YfTZcsl7ecB6E1MPwoFUUAHcE?=
 =?us-ascii?Q?a0QatuAc1sAbwCjWZnji7+UwNElxqCPZNoJ76Kr2Q0XTxKxLkpYIiqOU02K3?=
 =?us-ascii?Q?3mcsDNxet0YoNpw63E68HrjXm8UK1y/f9L3hSZ5OULAXdsXmwRoJL8sJoqkT?=
 =?us-ascii?Q?Cecq9H4wSzeEql2s5qP3DArQwH3t8FX3T1+wGFhrZGY6JHcjf0PyK0M1lW9w?=
 =?us-ascii?Q?7yo2lroxkfgOUauwv6cKfu8TbrKCY5BajYG22HcPOGWmJFEVorDDX7tjIyQH?=
 =?us-ascii?Q?cgkq8g+Q4yTLKl7ncZsMVm0pgMJwrD9PdKi4Xal4v9UNAhV8tjp50g9xbnQB?=
 =?us-ascii?Q?45V2audq23W1JcPJAr2ckV0WpktucfFAfI+pqln0LLda4izYtK533kVwsxpR?=
 =?us-ascii?Q?3adw3wzdPdckCzy3Bhn0WsA5Sj4ufI7M48SjSyEheR1mr+9bOnTefDnCduQZ?=
 =?us-ascii?Q?Xz8hlytNWS6gM7KT2Ub/ek/YNjIQZocsH8bfS0TagRHZyoNaWSCQTgbeUdVb?=
 =?us-ascii?Q?J/WKc40nwAqWPdQBw81H2GqLdmvC+IQQZsL8vnAfw2dGGaj1RldszF5kx+Li?=
 =?us-ascii?Q?Gsn0VYt7sVI3y8XW4rykKyuu3eOXLfsAh0G48SJ0EUQeAEJlG7yOM6GFnmYQ?=
 =?us-ascii?Q?AYxvUlOJdI0M9rAa9P99NC/SXcErXBAwGyNiO7ISsz7OozrpTzOxs+ULHQTt?=
 =?us-ascii?Q?xO22zQNojS6pGl59uPQb1l290Dkp0hvpcMWXeCrSRLEz1nA4Fwcdt75GeWOQ?=
 =?us-ascii?Q?Rk1O7Wf7mLUBH2tDU52U1jWw9MXRsAsK0u0oOjvj8yP1yGj57SCwUCbIcrz0?=
 =?us-ascii?Q?URDHjVXET6UJY9h9DEok2az0VPzNRCwuMgLpH34wYSv1FPU5zDY/WEnIILy0?=
 =?us-ascii?Q?e4GC93qTTtGKbxuSE9VFtgvauxUhtoPTjTr3kK1WQERkL/O8M8yCMbdUWl8q?=
 =?us-ascii?Q?8wwekQ6hyfrci2Nk7dHMsl6uXzhAuq+vyiAwI8YfXXyBS7ryHsSpB78yP/jq?=
 =?us-ascii?Q?ScyKSObpgEqzt3HNEcUYOpW27M+Jq8RelHmmjB8/LEfO1R2GrZ8JAZfVsiT/?=
 =?us-ascii?Q?oNTgtocM6yqPXmzV3BeHPZTmq9fUrQX1D8l8LlSKc7nyWUeYzzR3RWYU6ZRF?=
 =?us-ascii?Q?F3DtTrMB4QEKNQrhDWuAe3UOISl9/1wIMmH8m24skwCckDou4J5NdxLs+zBv?=
 =?us-ascii?Q?qnkrCCyYGhRFic75cs1lxM8fZEgyKkZV3oKwYMo4qK3HCio1xB28f6NRENwR?=
 =?us-ascii?Q?3r5x5eBGsuM5unig1sv1LVYELCsTergTTh6Ag2CgteeVrOiMm5CAvC4tZrKZ?=
 =?us-ascii?Q?Nvpyy7HHYjr35pcyVzkCdydQ/udtXVegy5aZwuU4vL202t2vDel0ieEjSmS9?=
 =?us-ascii?Q?IgaLU3LJs7IbWlbChr9PHLsRAgxgnaxVr7eRsQppkBMS1eAitbiyL68NInAN?=
 =?us-ascii?Q?DwlFcv3r9vuaboCflk1K0afJcqNSU0feaT5HwFEEEjVgBhO7y1sXrsU0uyQF?=
 =?us-ascii?Q?5ibrxHkXtvoQgHFSy5ADPLFGLgRFQ6wKPOI7Q7y1fvvcXup9TT+IWzq4SLi6?=
 =?us-ascii?Q?OfjFj4pQhdCzpMpMYKkVtP6un1zd4qDnQ6IYIA8Nio1OJLLOt7332HhN26EU?=
 =?us-ascii?Q?zHSJGZlLCn6Mawk0pDYVaD81hV16YT5rehXQALQFmmY09VOYB5sgFkRuX/g/?=
 =?us-ascii?Q?HKJt85Ycm2Rf1nadAvTpU2BShU5eSBI=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062f3041-deb9-4bd9-4b6c-08df3e225f8e
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:06.4504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDETZvcUfh3gS9Yoksp05q4KcR6qimVe6oAAqkw3kFjDJLZ8muahSLnbI1t+hIl9Y4XV5mZgfQ9XCUW2XOhSMqA+flTngbH6m920FMKu5yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

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
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../chips-media/wave5/wave5-vpu-dec.c         | 69 ++++++++++++++++++-
 .../platform/chips-media/wave5/wave5-vpuapi.h | 10 +++
 2 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 668c923dfa36..e351a86528bd 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -200,6 +200,59 @@ static bool wave5_last_src_buffer_consumed(struct v4l2_m2m_ctx *m2m_ctx)
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
 
@@ -421,8 +475,18 @@ static void wave5_vpu_dec_finish_decode(struct vpu_instance *inst)
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
@@ -1528,6 +1592,9 @@ static int streamoff_output(struct vb2_queue *q)
 	 */
 	inst->remaining_consumed_bytes = 0;
 
+	/* The queued timestamps belong to those buffers as well. */
+	wave5_ts_reset(inst);
+
 	if (v4l2_m2m_has_stopped(m2m_ctx)) {
 		unsigned long flags;
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 28df7f19c459..d916acce462d 100644
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

