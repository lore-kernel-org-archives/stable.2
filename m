Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202150;
	b=TWdy8lJ333C2IISL4V7trYEK7QfDiu3IEgs6N2lmjq41fjWWKn4AQgvnjgX8//jIXmj7
	 /62FkcVXy4GBR1kKtLrC3tN6CmH8e10wJY75IWtcEiexhy/mbFdTlTdcu2k+UocEtsyl4
	 XaCo6VbwCftWANxIyePPSEOyJ74VicWW7lG51Vr3+txImOPbomRw+vjEAPbCAUR8RMscg
	 JoQO3PGirWbY5hxIHZQ08qxpSGkJ20ptXrB1+k88Owh5pnB8kpaN2l3woPlyS+k7DHpDg
	 ykg71ZmR/wWqqzLxu/XnJ6JDHlKbTtAV4305mRsK3j551IwdraZ99aFW9F3VuW8IxDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202150;
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
	bh=2OhpYTODcd1yODAKeeuGIffzn2LsV+6YYQQ51iUD1l0=;
	b=lVOmfTjPMFQ6P10p5SyCYqLw3B1e8V9Ke8LEgyylXO6zzcfN7CXu1aeo/mmE0NM0fwSB
	 FOjoyY4bOYQtgpWMGas4Kei5foY4Cmv9X2jFRdEJVFw3EZluO1OEEbW4bR0pC2N2YZAg4
	 F4o60+VxbS4/Qik6GJX4TeXGdxwy3F/qYVj213pEYHiluV0q7zwhl8VneQIFFvDiNAEkX
	 yvh+oYyGZda8Ffzll8OEPYyP9V9TQoJ9F9P0ikJZwjIi2E37oiDSnK4rewOEHWT3+h62c
	 2VwDnAB96T4uWpp0QTd3ubrIlj0n2+MeUGK2p2qqoCe1nybeUUYPM0qCTxPvq/oHrMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=fail header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5120606A336;
	Mon,  9 Nov 2026 05:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5120606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9vZ6VDK4Aa24RJjIHki13wuATGmQFEEKYl5NkkgEXHWjNEeLn1vzVV8hQGwqNpOpZH55ExEPaLOLnZx4jwBuNDlC1NcIPjrI+wZrT81eQw7KTUmx00ydMvngx0Rpn7iSHw3AVnOsfj+KyPrRLzLgI1lW8ydD7A5rryD9/X5mcxLFlvJjxVC+dW500AODnrZIgd/eiAVPbDNr3CdqJZ80oBgn8Gia3dHWKXRtYSHo88QoTWhX2LK6zw0E0DUxg5IhiJ0NIc88L7wAKFM1qKix16z0lhyvQI5txrZgHLGIiIgGnit7rNvyUi/MZgxVTJfEaKxhk1e3llvBXRPh5wCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OhpYTODcd1yODAKeeuGIffzn2LsV+6YYQQ51iUD1l0=;
 b=CZW0IdHdXR+TkF+sOpwcn0OiPnTZG9UHWHTNzZtPVcq+TWOPOLVwm/ww9Uag69oDDnDVknYxGUrpsznSfZ+FW0jdlSdllh08avcsvIQ1ilawI3tX5gKodH+vmzW2Z+LMDucBw7PaRoRdnaQo1R+UFRpoh6KCFMDwfITmTDCZfSzOQ86aPjRP2hdWIgOnKrH9U5A2l8hsAtpMVdtEq8+2tfLXQZPjCY26qhiH4235hEiNkB0jUR6k5Y0F+cY4v7o6Oz7utRJv83DW+rQvE18MFIq6mFAc7FwN9fk5BoXekmbketcBt9tjj3UcXmIolLNtRKMns8J0K1PsEappeo3Kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OhpYTODcd1yODAKeeuGIffzn2LsV+6YYQQ51iUD1l0=;
 b=b6Vi048uzdWfQQ4VzKN3dGkf/NZhZIO623dln2/CpCpkjMSEe/zRyghsXZJyw3UsHRfkpfCSMV2crikCDcEnElblxcvFLQ1UrUbU6gdnOvZBQbyub0VA9WaFv9/FNJA32aEJfno2loz5hEFjaOY3VCD+RAvTO2p4m9n4NOF4WUWKVEhgwwnCKg51O0ogOiBPZCOsSPGMRPXUxeUSQqkMRQijkTJ8y66EvdLVWvY7xWkHfLz/8JXI4fuaUETfwI9EBl40Wey8BJznRHOuZ8GF/nldGNGOcVeWD1wBxMjQw6EANJKxuX0Yl7WqGpdiB8poduGhyIZYxH/4Vc5V4IIVig==
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
Subject: [PATCH v2 2/9] media: chips-media: wave5: drop the consumed-byte tally on OUTPUT streamoff
Date: Mon,  9 Nov 2026 14:28:46 +0900
Message-Id: <20261109052853.110-3-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6be5cbef-8a0e-4ea7-69fd-08df3e225e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	s3IpL+Hwmkm0n+Ry1+WiaBD9PS0NEzMrUVNTirLTvVMNLwUJ50nC7Q2r8uhGNSdg0Az7NwXpwFlzl+PorcunwMy0D9DNSWhc/MN7IK01GJFKARCogoH5A+MFFyiE/0Wen+wqls18qEYngcs8jdoQ+YsbNUAT51HvLoCJLtTKD+nLGGkUXlfhoURXXIVOuOyUx7BvcyqmYpBhOouHVNXlwyZaN80ujsQhgpFMbdGEDKbrLQayZWkhl4UR02C5aL8uK0o+F/rNb8v4msSuJxJ5pIkGHgJOK6ZEgjj2i7IxBQOkqc+METQAqk99DhS+PNXzcXlUvzSC279DSQcPAGgAzw+veKMEskPHq210VqUBUZL9R1tLXessHBfCIJiz6t158kDQPUmG1o6xkgBMeXsp3JB+/n3FCnstUEojWB0VqT5B80eD5UvqPxRoi9g/f88w5OfkSfwrOzE4HgxVs2WChGl8WsZXQLqkhdg7tg5kTekykf+zSrWrEJ9Ay7JnmhBUjZ4Ene7eGMmucmdeS5FFBUUD/HtOptaVk7kP5abzDTZJfO1+E/kVGs25GlThLD48TuMb0UkxSN+O2+MZ7bodVUfFKl6pgtDDX9VDkT6US1kkUeCMwIBCf/eoHP4gFFpstRXKs1Lwzd+xeozJFT/qB6CqEX6NnSVPkjI5Nfv5repG5ZH8ASM9uVuGzt+0fmUBvxE62mRk4mam0GQ61OEJlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9mRcae000qiMlDuLdZsjPIE47f2ns+CZajZaMVeunNTojFRxQnoI+qlDvmT?=
 =?us-ascii?Q?BDWiMj8RF31skleAZ5sLUdTIZRTXMoc2FpDR6Pukh7EwApqPIz2kv7VqE9ew?=
 =?us-ascii?Q?dO9YiSqa06naFyGWy0EJqC0wns8lR66fOU0A3ag7RrLJwRAKe0DMYnJDc/Pd?=
 =?us-ascii?Q?oWsr0hvWioDT1WfWGjk1Cy01RRs7tcxc4UxL8RKCRifSRV67T++zl2MP8icE?=
 =?us-ascii?Q?8Gqee3VDf0goPjTvN6ETnfGgmwMqkKGRnkLaWmkTxLwEr0hN/+l7Dgx9tkQ5?=
 =?us-ascii?Q?IiucwRMMUUBnFRVHQ0PYDiN2MVhRETBAJNiFRC9vEF2Nz+czCVy+lfyRp4Xd?=
 =?us-ascii?Q?6HIHLxqTqi1h5x7gpqQDN0/XR48MgVrIxWBzGrETjHPVSgHxuOeMI/UbMv0F?=
 =?us-ascii?Q?5Dq65sYd0Binr8ul+/BasIKg1RhWt38gz4aVJWetZE58zg5zGF0iwLoppHpD?=
 =?us-ascii?Q?NwMlYf38xWP2CUsUQURhfjDY45t+YDdyIUoXtnYLs1x9lGbI5sIgHOAEqjuG?=
 =?us-ascii?Q?7Sk0/BV6gwA/LSqD7nikbro++2NJgmQtvXF7Mwhi4Tz2xMa+484j2XoxYMHe?=
 =?us-ascii?Q?N5EcgZc3+84i59yobmJBVRQV0uFtojh32V9FD3JEvtXfQxTTGmbBARoTlpG4?=
 =?us-ascii?Q?ba/1tyTvZD9OHa3gEXpP9Pfo1WvwJKhR3LnfEgbL9D0nbwcL7FB1P6AYleXn?=
 =?us-ascii?Q?MqCyczZ+im2OPl8fFFiGIT8OVKw/pqEK6pDaEiH8cyV9Lda3q96LpRPJEVPZ?=
 =?us-ascii?Q?ptwOCe00pAoe8RWgWBT1qsWLmf5g2jepf57stOdOpamQwjbw01AJ7eHbs6E2?=
 =?us-ascii?Q?/fEccXPaJjfVXQLtUOSEPXe2GsTbyUDDbOVGZdJiLSkdRmJvFrLZ1qZY9PK0?=
 =?us-ascii?Q?UuKIsiipCutlVIWCbG9FgQYbafNd1RaRfBLwdpwc1pgzqXJHH7SeqZLPuDua?=
 =?us-ascii?Q?RmwZhWe2gOXdyiggHvOOjfPQTGxaLjbowTm8ssOqN6KwqB5nqVHywLigqU7+?=
 =?us-ascii?Q?RC0yE5Jtgk9yorbWOwfahIEm7+QgC2n+IwRbAiQCI2YjmXJm+XxQJGptlfUC?=
 =?us-ascii?Q?VdItVMSMUaEDPFsi5buFsrIVbW7swGOgPtHaggOrmGViTnz21Ga0hONaWbCp?=
 =?us-ascii?Q?6AM7di0rOHnVAovvfz7tWpxyReiR+9mo0kN9HJy9clS03k8gNf0gOPuNLOwH?=
 =?us-ascii?Q?xwngmsJV9o5WrehAqsDwKDCa+DzZT9PKh//wrWwQ1tcEAFj3FgiIIl9Ukkwq?=
 =?us-ascii?Q?LmL6D4GGS5roSMdrkHVVjdRzvPyg62BDFrSW17VpyIWYiygFsS31OWJOE36l?=
 =?us-ascii?Q?AJgqhFXYlSonIDMuNP450W7qnD3swqjsK+kU+WxUX376brxxfrIpEuP/Vx1I?=
 =?us-ascii?Q?f/GNhezC2FCJh2RpK4xUPtRwSj7zJ6EBo6YNkzWgqylJCVUylwybuXOfdNgX?=
 =?us-ascii?Q?XUDT45o0Yb6Vso44f6ZvBPvDUIf+s3F4rOPyLa76iZHxqdwHqJDpm4A5y4jH?=
 =?us-ascii?Q?gAY5WIlP4J3J7uNgUs9t3jEqMGeqs1MfoHBWwcfVpKAL6PUZZy4uhB8Pot0d?=
 =?us-ascii?Q?NfN/JAdB4QRw3ZDOHM0gtt3wUaNURkzuY6M9WSKZfdvqhD12zqDQ+RPhb1YN?=
 =?us-ascii?Q?h1KR5qWdXD/2hV6YHiCClIU6fQcbx2woLPHxixPIqnMs9ckffxw96MWtSNpM?=
 =?us-ascii?Q?4cYuwilYUi295gz4Ff+gPh+iqB56gjS2gYlI5buJLkzdten7KzIv8cGaIZcQ?=
 =?us-ascii?Q?hm7ygXli8zXFk7OYHmJnnUG1+b5I3N4=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be5cbef-8a0e-4ea7-69fd-08df3e225e6b
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:04.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po81ZX7uMQT4SVaXOJlXMGpO37wfzfnJKF2GCIPWsNtqA1vZhf4ImINRyoZqpHqxybpNfuhoDM9T3+16EuNYdGpFfym7thPqhJPw0MEwQ1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

remaining_consumed_bytes is never cleared. On a seek the OUTPUT buffers
it accounts for are returned with VB2_BUF_STATE_ERROR, but the tally
survives and is credited to the first buffers queued afterwards, which
are then completed before the VPU has read them.

Clear it where last_rd_ptr is already being rebased.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../media/platform/chips-media/wave5/wave5-vpu-dec.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 5993102e5afe..a314813a6b4d 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1494,6 +1494,18 @@ static int streamoff_output(struct vb2_queue *q)
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

