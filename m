Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793469417;
	b=5Mk9tPgVWnSF+tZTjON9ybuiN4wYD4qnHqZEIjPF7uULTD7r/jSncdH+WdG9IHyoZRga
	 VpSIX5RYeFdokzi5YnqVuvNF41l0VxaBT/oSnMdKCq7Eeak/VIudcrYznOnDv/KSAhibm
	 Q5NACs4tpXoe/ZOfTw1OIs6YBaD5MDHZUi0qhJQ1SM5GHktiQn9FyCxGcVXynERCwEjJm
	 5CDAS88/ffI+EHPuwmr1rUFE6KDuo3f4pNSr+SgUMVO2QYLyjsutWFXvegXe4as5hD0RS
	 zRiBFjBhC9TLIJ3ZHXOfMlpMfs/2lklWJJZPx8asH6X/R3hTd/SrvTPdRR9rSs/3lkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469417;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
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
	bh=xcrUgKjM8lEbGzVUGhktPg3rpV/CCVtucJlOkfz+Www=;
	b=Qqp3TFUlzSkrzFVnOoS00rERywDOSpVxY/CgYiE+wjaVzA/MuClP5wSi8NWD0h3mtw9T
	 ZewRixK1neJ4SZ7IliICAFbGSTQICRDocJxRijd+BXVbxaI0UqfnkNdkUY2aaPaYhyZ5J
	 JF5gSGBfJeeNDCrkYbEe+vmrFhHI8Cp0dzaA36mHxqS+I9H93pq20pYRSZeaDIZsAT3Fz
	 5YNJU1jnlxjWXoE+icq6S0xQPjM9PkVSswRb6Y4/orM009iw16sBBQB5LATNSowIsWFhn
	 R8/sOQnfZCcoNkMGgusG40i5Bd1e4qEI9bEe0znqmDYHZslPF8SEOeXiWB3VnRAjUVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smu.edu.sg;
	spf=pass smtp.mailfrom=smu.edu.sg;
	dkim=pass header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=ZT+NGXuE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.126
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022126.outbound.protection.outlook.com [40.107.75.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42760606A31F;
	Sat, 31 Oct 2026 17:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42760606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=ZT+NGXuE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WccJ9uyUukfBvFyMzrJgie3SOymgLyG2YdzGOG+ol7PrrTwnaktQsy6EAcOPwDIEvT7wh3hmrx/qOLcgPsyGptJuJQuEJXIQTxyYLGL129BrE7D+WHkcesDKVBBRGhr5YHPVmKdi63mAqgHpP8yTGno82vQ+dsH0x/bbpMRr2nCWk/ALGGLLjmmFGijsckrraKGHE87zGHNnkte9p2uuXAmH058amKEifp/BiGoBwQV6NScFPhju/adj5b9mjsRjH96q5mVBXasz6Ad4cbAIm7N7R0XL2EOi1+t2oRmrkDje9XDs0zwKvQzGL+ZhG+ycS6wRXOGpHXsEV4qqPHMcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcrUgKjM8lEbGzVUGhktPg3rpV/CCVtucJlOkfz+Www=;
 b=cIr+Bhc5tPY8CpkS7IZWjqQBNtXTDICKHkjvIfOpksVVTY1+j84edIq6Kqfy5f5HfhJ/LHlhNhDg5P8LhzxBNakOL869eb4RyB5p9Os6C5e8VgIIjMP+v4RK/RC2DqIeoOXkInNeeLi4BeW7Kzuk71PQxAxpdeiN8PtPfFfDeXarDNVfl328eu6+Vdk8937TfHBFLBXN3z5yz72ui23kq7SiQm5Fr1BnNAPlCnWBiDPDknNhxKydjZAO9Oc5tfXR2EcKW62R3cT5Hc5x/6pzQSSRPpGqAPZFTBh/ZO65Plgo6/zm8P5aU+5lBjsWQPJvRQYIRIVxExU6IBov3EWXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcrUgKjM8lEbGzVUGhktPg3rpV/CCVtucJlOkfz+Www=;
 b=ZT+NGXuEpLDqFu9Du58qxkMcwjsSfpcY/S3yVN71J1prx0QkCeaIxvwMRsZYSCFgF0puJcqXqI9oj5dlWxREKcIcyKsS0cGpT8XjGbVodr+7q/P9ct4e/toTyMsA7MQ1DoK20md1TQaN7JQ+ijn6q/WBtECGb9QE/fQuKBYzhkvIOdBHf+Nghg0t690po3BUZSPczf4dDyJLErGlgTlzJynthA7TXMYnC2Y0nMNETSw4762HFD8FF01X4RkG6mDImkAy6oCWKB5qFA3KqhJ077Q70/LyaqDlBiT1bPVLaA6u14EQD+MX1ggWLSglXDfEKhyW7e/Nc1kgl1UYTWV1xQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smu.edu.sg;
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11) by KL1PR01MB5904.apcprd01.prod.exchangelabs.com
 (2603:1096:820:125::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 17:56:45 +0000
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382]) by
 TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382%5]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 17:56:44 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v2 1/2] wifi: rtw88: drop C2H packets shorter than the C2H header
Date: Sun,  1 Nov 2026 01:56:20 +0800
Message-ID: <20261031175621.2228762-2-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031175621.2228762-1-hhhuang@smu.edu.sg>
References: <20261031175621.2228762-1-hhhuang@smu.edu.sg>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11)
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
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4264:EE_|KL1PR01MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a1e0a9-bd1d-41fe-1c4b-08df377851ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|786006|366016|1800799024|376014|52116014|38350700014|11063799006|56012099006|261009223027099003|261021121427099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zCfxAapSNGHSX51I0ODVcp08lG/U6mwXamj0yOAc7dcvyWEJT5F6PbojHEJEo3AHU+crTPJhviIAHugpYutYiws4DiotGPLHRWH8z4dD54BFn6OOLKnfoHyg/4ns/MzE05hBcpIwweVcz4E/8uZd+woDEzRj8QeLHaaXSeR9LIpUUW9EOflCtQ1L1c2SeBJQ5iEdIfQonB7rplaXfjmGjU8fMoJo57nkJNQaevOrYhMHWwW3zVp/+XApLByWi9lfcxT5g/XdnrUthBnhyhL/bTjnGdaDORFCW3xLmDIK4uoJKpN1+PN/mhyqqFjrmkAx3ijHkpbmW6tDKhJWj9r3KVJ7UX8uwovRC1/K7RsaxBQ8pEr61SberWuMpTC+xMkl3m2Zfm9T4H3IkP/EEKyn26/v8eSYGTb6WjUD3qx71t4HFWUBzSgrWs48t8yP96G+xOmt1zN7i1sj0kVKN75y27zKnivv8VBr2YbIrsvdWWDoaztiMlL3fdllOquvHeGdl6QsNpm3s/tcCkxqGOgUy1g/JlowOCqBp4DvplTvHGoPH7YTPrf3bJSmxsvJID8ASjw7j6/CFMrDRYo2/3HJRwgKqIw/tYxGq2p/zd1NC9hIcOyAHko/MHWpJeODqcOLWUupc+O3YZQt454n5H8ove561Ftekc8kPdaQeL3vZnv3VFWGccE8PEFeqPTKZbWCOFbBfFfnat0MnlTKFApiBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4264.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(366016)(1800799024)(376014)(52116014)(38350700014)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPH7SN3cN4rit0kUkInl1ghGam207SSF0qEZ2ZUqsIxLyioGclsFZoH+FxLw?=
 =?us-ascii?Q?ScUgJ8dEUVqJB0ycyChlaAiyKB230vvugRKg++Fq/jN4mdhsQwggSFQzotcm?=
 =?us-ascii?Q?ddXlW8fJQC2/Z6o1y7H50SEcwZAMuHO2s3PRjjlEjrIwb5M1MKP+o4L1wkxj?=
 =?us-ascii?Q?DGpNxbKizvn6/oqAsInstRjV8hke9y8PLTgL9ZQzep0oGfLq2aM341z6RzzR?=
 =?us-ascii?Q?0Qcw8xGoVWXFaYIMHutQJCVVO64TjUA1b8OeBuEHervMbjZBhEZVtgdzwO3v?=
 =?us-ascii?Q?MHY3WiACBAezxZXPwr/PE11aK7G32SWggq8A2qAUBFR+RldbsfF91hKZ+uc7?=
 =?us-ascii?Q?BgekEr7JlC80Vr1N7Sg/WgNaRQ+4tg9X4zbolouxXKgPY13Nmy2LCDkTBeTE?=
 =?us-ascii?Q?q2OMKOVcvOnx3dkUV7nLHyDwRLLXuc+ifvcskqP2L7ThatPFKvYVdTYmx5V5?=
 =?us-ascii?Q?m7nH4gMORiISGY6ozaRGVuI5uCaTITS3e/URuYrmqCJE0JFu0vqsZ2puqxDo?=
 =?us-ascii?Q?nrUrc9zyiSHjZ/T5MvijyqzF4l345qOluoCokFw084nJTpG/STNVi/OUpDjo?=
 =?us-ascii?Q?/6tulnE1wCt9wEEWwlpF+TAdLYoYqMJ+TmuqipTufV7tzHUHw6roULPLPtx3?=
 =?us-ascii?Q?zLPnmRCQfl8C/K8IOVZECJdqroUzc8GogWF++4iErdUrxCqebFqO7gile1ub?=
 =?us-ascii?Q?VNVM6MnMRfgcFt9XO7wMpqWYKKu7DC/oSQNu+KZ2Y1M/LRSONmy7JDfR0JP7?=
 =?us-ascii?Q?ZcqkB9R8EPS3rwl69k5F3cVSE6yxtHteFdezxJG6t/3DvwFL0E9Sc4eZfIB+?=
 =?us-ascii?Q?BTbxYvf12En/B32HmQUxVkivQ2dCxKbGa13/30ij7LnKTkDWXgGpkWWfj3vQ?=
 =?us-ascii?Q?StC4nXmr6jHvmgua2Guk+NpM1eGFIFZ8MyqVnll1oPumGdScDCjZ/iEHPM+p?=
 =?us-ascii?Q?I+Ydmt2yrK8V4OLwsXScY4Gd2tHebWfJCasfJ0i/Npz0yBF4y/08txhlbf/m?=
 =?us-ascii?Q?F/agKj6e9qBtTcuezVoTSI7E3Y6vjp+DF0bvT0wL4CAZUOed9PcQ1c4mRVRS?=
 =?us-ascii?Q?IWbraN+UvXaA4VJuPon/UlqTp7SfNiVX5B+H1grkJf7dPIxomIknLmz5Orlw?=
 =?us-ascii?Q?wRpaZaS5iHdPMAnTwOz+M4Fe4fGdLlhVvG7ut/EgEIn3jvPi71/iipz0E0bG?=
 =?us-ascii?Q?16FqzpM+YZjbeJHqiI3zE67vpwnwSVIm8Tn3JD4fS/ZROcC+/UeJ0MH2Z0It?=
 =?us-ascii?Q?2KlYYwY++HhD/QNnRc4/hoZ+8tw8gH0zqzjJYk65kP8gJVC/XB95Qtz8W8r4?=
 =?us-ascii?Q?tXkg1O3EG8IPXrmGNowfNNOqQ+YCYIPLnD8WAysUhUqN6cbfWlMVLcUfJr9U?=
 =?us-ascii?Q?eFJrDOelveHBElNwFjY8etZGxGxiVRjG4fUC0xe9/zw7PllqIQwUayAjNQ3k?=
 =?us-ascii?Q?NHVdLrM5ePBs/FzsFMauPZ9ImvK7fbiR6usV2LqsHVLBCMoW4xnAACFwAbqR?=
 =?us-ascii?Q?TUH+kjQqdprpkEZiF8EJzdRd9ZbCl4SQWWHOhON2Jmh0fIRsRyvkvBXGRLVk?=
 =?us-ascii?Q?Q5dXco+cPrwxsJvT1l9apK9WksjAl4RVqztGu687dqwwHKyAuvrxdatF1t/G?=
 =?us-ascii?Q?ovdO7NfW2S5ysLAmoQ+JCINOqwn7xQoezZUVYhwGu8xh1osWOMQv39cZKPWK?=
 =?us-ascii?Q?J2QNBDGKVN9gWv5q533DKDZHuYW86ERYpsEH+2jGO2TRIOJI/Z5JNPj/DYPU?=
 =?us-ascii?Q?84OwE7DIbA=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a1e0a9-bd1d-41fe-1c4b-08df377851ba
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 17:56:41.7333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZoIrjTHH4JovPz1LZtz+DIq7uIHfu+e/TSKxPP6jPJjJxLBhxvqm8etgymORgFPKDtKx9MY4Ik9+RrQsV4yLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5904

rtw_fw_c2h_cmd_rx_irqsafe() and rtw_fw_c2h_cmd_handle() compute the C2H
payload length as

	len = skb->len - pkt_offset - 2;

where len is a u8, without checking that the skb holds the 2-byte C2H
header (id and seq).

If the header is incomplete, the C2H payload length underflows: zero
bytes after pkt_offset produce len = 254, and one byte produces
len = 255. With zero bytes, reading c2h->id also accesses data beyond
skb->len. The wrapped len defeats the minimum-length checks in
rtw_fw_ra_report_handle() and rtw_coex_wl_fwdbginfo_notify(), which then
read their fixed-size reports beyond the valid packet data.

skb->len is pkt_offset plus pkt_len from the RX descriptor, and
rtw_rx_query_rx_desc() returns for C2H packets before its
"pkt_len <= FCS_LEN" check, so a short C2H packet is not rejected there.

Drop C2H packets that are too short to hold the C2H header. Since
rtw_fw_c2h_cmd_handle() only sees skbs queued by
rtw_fw_c2h_cmd_rx_irqsafe(), this covers both computations.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Huihui Huang <hhhuang@smu.edu.sg>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 7 +++++++
 1 file changed, 7 insertions(+)

v2: print skb->len - pkt_offset in the debug message (Luka).

Tested on rtw-next with the temporary KUnit test from v1, with the same
results: before this change, C2H packets cut before or inside the
header update scan_density from bytes beyond skb->len; after it they
are dropped, and a valid C2H is still handled. Not tested on real
hardware.

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 945fedcd375b..0a909bf79cf5 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -353,6 +353,13 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 	struct rtw_c2h_cmd *c2h;
 	u8 len;
 
+	if (unlikely(skb->len < pkt_offset + sizeof(*c2h))) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "C2H too short: %u\n",
+			skb->len - pkt_offset);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
 	c2h = (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
 	len = skb->len - pkt_offset - 2;
 	*((u32 *)skb->cb) = pkt_offset;
-- 
2.43.0

