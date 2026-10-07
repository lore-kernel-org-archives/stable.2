Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazon11020125.outbound.protection.outlook.com [52.101.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A734AB03;
	Wed,  7 Oct 2026 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791338407; cv=fail; b=C3rgQ6SBYT6L7huZ2tqJIw9qqCnM77YV4wtRAM9JWbwg0vGcJuuO7zxZwrs4/f08iB7fcdwjtWQ9nX5g3hEpzR3iA6yHOoWXCjBZc//E8j9oKU9yE+N2VIyrCWdcCRcTMZIJ31dIv7OYwizZj5ZlRq6wgPPIcRmW+98xHB9Y4DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791338407; c=relaxed/simple;
	bh=2DXCfNeX1znRQ3N+vtVEF11VOIMJpP4DYogylIlgBMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HeRlOaiKXX1Mic7+u5sk64ig8k1Lphw3L3zi0hfrTYyK6A7PU4UnGObWHtzdXPXJkxudG48QoLUyDn/RsfEUx1wEvzOe90T8keIm6NMsA4uN3y4vN/QtQuJlPnkRooyzWNKDCrCyNoK8GMZgSwtCViturnp8pINeOpke0p+uVek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com; spf=fail smtp.mailfrom=chipsnmedia.com; dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b=Jfl0u76D; arc=fail smtp.client-ip=52.101.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.b="Jfl0u76D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hML3I9K3qLa74G2wZF9otULT6tiBhNbrkl8Q7QuEVIu4+clawTZiIk/ELrQiHgqPyhTI8PdV5BcM1Pmo72IKb6ME+s2uBaID8EhoqcAqYqBf3B1VYou/Sm+cbv9565KP5YT8FmFVHYgxTqgXfhiuxH2MK4C3zjjaOULhg54w525oHXbcO1iU995odZmy9sA3ke37ZrGS5gPGUErQqLk6lvdXvlX5A+IvHvaV0xip5LzZW6gb3PKbGM/eyE+BFb/cCo4z4PCc4gEr+jF0rhQp6bXxFgvinsfNIIbZhRApzBJAGZt+QdTt1dP1EdjzxIxAA+CO6pw/UgznqP8HGj4kMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etk1LIwWqx9jOvWr51WifrTOc6nxCOQ88dhImdfpba4=;
 b=qTQ+kMHfsi4OL1jphCgCRl8wL9LM7aNMR/DB5PakUe0WmUrHjSl0QpiHEvIe4ol06kct/S6Y9h2NA1r9PUKiw01tERQUBl1M5p/j2ArDxD/Au+QcQLV1EZctWjIuz946zemus5PfGGRiP3slEO8lrN/15lpyQE9EyieigQSDQgFHA1KGpGqHFs/UPjKdwt54VdzTJEC+KdRnaYbFHYkRwIS/BLzC0fPtHCXHrPbf6ZtuLD/0kQwpqPB5RaHJRHez/t0WELsSobnCO6D1WQV+9OT3pU6JKVQe9JWwfKn87SfjXE7G7OO2udOMoeO4WCiu9mnrZ+Hd/sTsfkaFSCeJ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etk1LIwWqx9jOvWr51WifrTOc6nxCOQ88dhImdfpba4=;
 b=Jfl0u76DGKB2Eyke6x3se1zmRgL4eqzFZGdThmmHnjIplNSkr87AGPdDPtL1Q73J0GHPVmQuTxu0wK/5yl5OyUmkk7rnFJOoMIICJlbt5ynH+Zd2URBGVK7iKJftTISlDy8XQ8xaYH9KvKMXPgR3Lnxset4nTp8H+EnsrsAYyytFd/+pD/4R9rW4tr4VEAlxcoYnsvdmp+jeziD+JZxCYhJQ/Oz7P3zbmOCJab5bCDGYOmx5W3AslGgenHN16Tqm6i/86hsOa1VjOO9djseBvZ+jys+ihL64/udbmQubMkkiCVgpyl7WilllSMtjwt8PBjxnXPBSgPLGDgECQCrs2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from PU4P216MB1149.KORP216.PROD.OUTLOOK.COM (2603:1096:301:72::14)
 by SE5P216MB118462.KORP216.PROD.OUTLOOK.COM (2603:1096:101:310::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:59:59 +0000
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
Subject: [PATCH v1 2/9] media: chips-media: wave5: drop the consumed-byte tally on OUTPUT streamoff
Date: Wed,  7 Oct 2026 10:59:39 +0900
Message-Id: <20261007015946.53-3-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: e33b3247-2edc-42ad-d886-08df2416b11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	bMbaJSHq8ZuVQpuhGBWhBuxICAx1ihlqh8Q1iTuZqcvg+xOZQWGpyBSmEmk0EA9otfAyEO516F2j+y3FNfNmDD55p3xXhJKsdORxjjxII/64eRPsg6lq2Lg8HN5H49zXEGODhnV1gxjNsMtrJxZhQn8LtbaKC/6sX5XL8Or+IpLFd7edICXq5FnT5TbjfeawGSCiRBxgr+ani6uKT0lVgyLK7Q0AipWUF5iNJox1ooRTnXCVa7fX08Z7se9oK2FK6sxe/OZk/xoBGkDTF4S0F5/0WhcqsCXJ1f4IPf8qwPGHQchQIb8rZAFIyV9L9NFEkGmSW4FMbBTo8lzTDF8yaDTyr77jjDk7FdmXoiHMxX2T9O8jDZeOd+vgO6im24OqutRngej/7emuVY0iMPTWCh4nXqlRx9NCmWsCrWOVvfkO1/iBMf3C5xwAGnJmSL6VjK0STKoz+h6aXLACsk6baWYCuWJL/2wCKeMs9nltm8f3Qu+yTfmI4CNmo+gvdcFLk8wba4dyMfU3q2W1rmEtmlDcvWWdxqPz9M/bEIsfU/Vedz8TzNgC0HCDAdwV4GeR53IVRWTNs1aIqMZC48UNLJTaIHBZ9kcie4RK+Q0Nedx7CcWVKaFUI4bCfmwAdDyJluUotf9a50O+ARBK62DWHtsseKi3WXywJAmjIPbuWPw1W+G82Y/5WaHpY50P6AhNLfBcRuligKm3aUy4WmryYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1149.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhKdOQYKNnyBfMs+Lt2z7ZAMoP/sCec85EBsF1RhcHFaVcxRc4d0/zXSilJP?=
 =?us-ascii?Q?S+7Wt/SHh3Mrs+Zh1bR8GhM7atmqyKtkBQOxv320BjajJBALUZTYeKN2jaC7?=
 =?us-ascii?Q?+hE5AThHOG/jOhE82HxqtsHEqCNaFjiWG0tgle8sDLGJvXV7ceXf0MO0uPDZ?=
 =?us-ascii?Q?t9h/iDBzMK6wwIzDr6ILy43rO/Ebk713pTAu3CebA7zenFHUfbRzqFPm8cbi?=
 =?us-ascii?Q?BOzUjN+YUavSutVdu0yZh6J+FyVcUgvYAJGFdyfwuoXTQ0XNYYSbLFdgex2k?=
 =?us-ascii?Q?R5TmANMKE/HKvEt0SydvcQK1l4y/dMVidzdP9++oDbChMo49XJ2zClCDDtyk?=
 =?us-ascii?Q?RqwS0TlPMIflNdNfTHffmlSmHh2MukONvEWCjgTzA6aCjfvxcDlDlunj4xoY?=
 =?us-ascii?Q?NYG8KP20GE0MfSe4rXYy3tkxrcA+OTaj3SJ2YbsjSuIk5iFGXQYaY+LjlCXe?=
 =?us-ascii?Q?t0Y99j3ABHjW3jVQkmT6GVbgc15KoqgMvT5I87TkJr9F3Tnx5cYaOHkH6q3n?=
 =?us-ascii?Q?ciWmHyBm+fadLgbLw5n85VB/H5V7uJuSP6kzKq/dbLHeBHjXLI8+4YY6an0Y?=
 =?us-ascii?Q?GHgSKPEI8XdNSwqtnMWrqLVYaMMbIcANfl7NQ1bF/rw38a2nEiiEejknu0Cf?=
 =?us-ascii?Q?kcO57QasVBhskrDvkM4tjgDWQ59ma4gM9jb8uNnDQ7YEYmW2IZVJbQO/Emyj?=
 =?us-ascii?Q?xFqnPhoPfFSbLLX0TDmjn4AGCki08BK9ccrfwjwpfV7bi1xz8Ur5TKt+PbNC?=
 =?us-ascii?Q?0zTb8wPQSz4p7pKtLHHjQLeTSTvn4EsCeHI2HnUmAe/NYxRhdlZlTLn2gPkJ?=
 =?us-ascii?Q?4kXicjb0iDV0BBNx9q0bnuG1M8qK9zr/VlHQsiCUjWl6EXhG2sdU2YNg506x?=
 =?us-ascii?Q?MQqnpQ0N84cRYZr9zAscDNMwKNhWUi5pB5+YigoaV4RssrjCeV5NLiks97gL?=
 =?us-ascii?Q?8yocn0TuV5qFL02mSRqIS/GYSe3tD2jlusLk9t5jbUklugSmaWORPtLOjDaq?=
 =?us-ascii?Q?JXi+VzGHqTDk0fN1vL3B3MxWAldI/l3fLU4uRd/s0CW642TUZn33AVFANg5J?=
 =?us-ascii?Q?yhwVqUzIU3ObiUXBdSpQWJDkoj7hm6YEDdJs7CW6aaUsTQffK6l6OiN6IQtz?=
 =?us-ascii?Q?GJxapyHTMMqLwk3S7Wq+dLXUc8uq/sIkYxnEwLJZLhRagPQ2UCUMkxKNsEPa?=
 =?us-ascii?Q?S/jLmEJQdgH59xhGIobjkHXppHk21QqL4iSyZ9O4LfYUC3oNENDr1DAxxcSc?=
 =?us-ascii?Q?HlKMHJhwmZwfUe32Cfid/KyZoZwxrtUa9snGo46+84x2X2hyUwQOsDS5nBKj?=
 =?us-ascii?Q?++pJCKumORUqWGzP4akqn9fUe+LhfE32Z2Bx8HJOWu/AfJfEaefT3Nm5yK6I?=
 =?us-ascii?Q?/M1ezsgZnOXXpWKylV/o5m+Acw/p/hobhYvU+g+b6Y3OmZOrbRS8vuDnRp5e?=
 =?us-ascii?Q?GCW7ChXJ0eOQZKIqrQfusjwvhNcKkpQPwoJu74c/DrPAdfLsHBXM97vxRfJ2?=
 =?us-ascii?Q?a3rzJ8FNoygnrLDaJY+mgqL+9R13781PU2JRLv94YOX/3Gl9CvpsmHMr3DLU?=
 =?us-ascii?Q?jAA+goVzMNuGDhXUELxxa902zhRkE96kM+hX2THRz1Pe236Oq5jDFHjxsKdO?=
 =?us-ascii?Q?rp3U7sHY8Mzyc63jbyJ0qmGI/SZSNCRYyMFXCzuVonRx9LUKbI7brFLcjcL/?=
 =?us-ascii?Q?NGke44FOjdciH8UkjwpddBpP/7Hamx3fBJ3ImdOFF0Ri5FPsrHgsw+SadeqK?=
 =?us-ascii?Q?9w9w0wU7YDeh3RapsacGrmQWqyQMl88=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33b3247-2edc-42ad-d886-08df2416b11a
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1149.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 01:59:58.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyQCK7EUY7tgQesKRnrSAaqH4hOQt+QEH18TYxN9cAWrWyCvCIbGZGMwNImV/dkn4gY7j9DTAZMRwqJLOFrxZlgC36L1pzynHtA5sMmI9T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE5P216MB118462

From: Jackson Lee <jackson.lee@chipsnmedia.com>

remaining_consumed_bytes is never cleared. On a seek the OUTPUT buffers
it accounts for are returned with VB2_BUF_STATE_ERROR, but the tally
survives and is credited to the first buffers queued afterwards, which
are then completed before the VPU has read them.

Clear it where last_rd_ptr is already being rebased.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 6af7d2e9a9f3..07dcb20ffdcb 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1495,6 +1495,18 @@ static int streamoff_output(struct vb2_queue *q)
 	inst->codec_info->dec_info.stream_rd_ptr = new_rd_ptr;
 	inst->codec_info->dec_info.stream_wr_ptr = new_rd_ptr;
 
+	/*
+	 * remaining_consumed_bytes holds the consumed bytes that no source
+	 * buffer has claimed yet. The buffers it belongs to are returned with
+	 * VB2_BUF_STATE_ERROR just above, so the tally has to go with them --
+	 * last_rd_ptr is being rebased for the same reason.
+	 *
+	 * Left behind it is credit against buffers that no longer exist, and
+	 * wave5_handle_src_buffer() spends it on the first buffers queued after
+	 * the seek, completing them before the VPU has read their payload.
+	 */
+	inst->remaining_consumed_bytes = 0;
+
 	if (v4l2_m2m_has_stopped(m2m_ctx)) {
 		unsigned long flags;
 
-- 
2.43.0

