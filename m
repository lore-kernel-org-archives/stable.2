Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202151;
	b=sU4J6NpT/aCGBhkdo4vJXVMd6/6AZunUr173wrJWZHv4+wcZZKbICTEtD+nFCwVMrTcx
	 PF++B7nVlKb5shLb9i1PO0+NT52PJfHA7dscp2krSo5pmcyWqpUBurTp9ZjopVo+jkUSF
	 PnRVOiO5Ge8TBi6Ef2udBAyGrOMq4OmqnKxwPsr29RVMKU+ok4tOF9lXNSNHkTePO+Xnx
	 MEWM40u2kG2ngds6FAvHDSlPnls0RAf/4UZW8UgiwhjtZeE8xCOPwtHDLyrYIVLn3ndMB
	 6fA1tsofqCJU2/+Q28YlL70AU6HETHleyBWUwQ8VuLlkdKhoXLhLPDSzReV3dhWoigA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202151;
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
	bh=2QuDJ1AJ4WCH3h75PaGKEKTg1UqzbPxHh6JCsc2YOBU=;
	b=vKuAIS9kM+/BenUmX/4U0UB9JoxPbmUfQQWWkwD98r6p6R3q43xzekxRx2j4dsQ5ow42
	 +nZpkw+jZQX9OkGUOn87ZsP+MwlK+IFnYHKLioiG059Inov9/WgW1Jx/3XRSATBR8pmyM
	 EOcGsVWmcrBBmFGu3+TsATEVwpXlycawylNIVw/1eTxts+Lv4lHcX5GhKy05VTK5vbRXi
	 Y4g8NENak1+sLe3MT88KV+fDgLOxlbZzIFAj6QehhPc5FBxrb7fzY6pETPc450cvDdeI+
	 XjKPpyNynxdIMFl+3HfaCE6yTuemMAu16nD/5sjP1ZDw5NmhIeMfoB4Tk3HNXqQ/2pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=W+NmvEDV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE29606D812;
	Mon,  9 Nov 2026 05:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE29606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=W+NmvEDV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vd3rDZEH/EPfcdsgZBiZuCQYEtTbYe/UXDvEV8UjVN/GyofrWfpF68qCvwqiSESPBuvPkBXN25Vvtnxl5WvndpivEZqm+wqZ+eMMBBDDCuPDEyR87MsARDPjUHxTrKQkIjcvp9UlHpGNbqV7oIHaw+1viflfuE1y+Dwvd6kFNAYVSu1SkidE0zM0CW6gvAToVBkt7XpKhZJEG/ONo3KYCNY3Joc5D4hcA6m04IMN/XrdM3AVpuilWwRSVuybAWXshhTXOiNbJbyX5J1UpIVA+8P3isjDNA/nIRGMbp0WLiMJcvAEE/u5jljNIZtBc7CzqYp9U7+y7keMvusBu1B2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QuDJ1AJ4WCH3h75PaGKEKTg1UqzbPxHh6JCsc2YOBU=;
 b=KYsekiTcn7a38X1YvfUne5mO0JiGy0bIRjf/i0X7EKeszlrJfG5+SIZoI127uuVpp/Irfgq+rSXZMNlG/eegKnwgYaBZEguMKWfqQdESh602YYISuBFrDoYuwd1aGj5s4HGqCmk51jRU6bi27brS9sBPGjiGRrZNs4IM3mUBGekgmQAIjaxPgKfHENrTdlSXCtZ6oisig6gpxZB3a3zHEdIQImxL/+2XxvBet15sN0xdXPYCNGbM66h/xnFhc2ZbP+Gtzj3cUdVbjDSlyUCUy5p2NW8tWLYl2m2EGpUioEvPqpKd9+doYzFhJFhrqpwjNoNIzvYj1n1aYbJzq9RBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QuDJ1AJ4WCH3h75PaGKEKTg1UqzbPxHh6JCsc2YOBU=;
 b=W+NmvEDVp1r+e3I3ZW4lMS+qf/vLWhdFrv8QCfYZKo4/pG5GZLe64K8GfzAuqAmy71VNIAMLjy7eWc3y7Afrb4qDpbsu2ici07QUiPEaRA8ty5DCr1fyJLppVih+KATbOjU7IUarVPwZ8FvkHOFqbpEyE8X1/8UFBZbdE2rfgCp0vmOk3+4QzfXRB1vmfxxAS6kyITrSUWqg+0oIqQUE5y+SK12i/NQlDztaQl0VFogO9/xOXH1wyllu4kY7zppi6Ual6koIdaAJ7zM2KZN8vfnz6d97ba2H1EFmaGPTD8I4BVWMgXOLVmGhhhvPjaMFlBCnpTAeoqlaMFhRDYUBEA==
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
Subject: [PATCH v2 3/9] media: chips-media: wave5: wait before retrying a refused flush
Date: Mon,  9 Nov 2026 14:28:47 +0900
Message-Id: <20261109052853.110-4-jackson.lee@chipsnmedia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ffa6ba71-cfe2-4573-44a1-08df3e225ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9CitnasAKx+yhrPu8q5rRvzevohaqVNJQBQJ2kzb0UNQfRDGLMdqlwFRg6PRBvWjGY9LLRjhCGYFPTw85zlTZEjOzqWaM4pa1F6r7xMyltyWm4TGlzxU9jM1EWkAXd9koLhHCkc9JqTgwWks5+x1sMPXR7g2DptPx/+w14bjnXwThP3QVu4nGxlY/xpN0FHf+bEml/QGEACN+ORtollHIwLLNKnOentQFCQgq0aS24H3fTJJz/k6QE0jDACaWQVQN1IC1lyeLO60ER1mvkX46BWuoPI/AMqCrXRCDzSi00vMCtCR5W8mui/scUoly9bvAU4gMaJDYFnnWDkCMVLY33PKrazN49WIqowX6gSwQYV4IdbsSaZxtZDoeKAOumGfuYeelCQ1mTbX9wLAUYTLGGVKBf7Ben2lUQ+ocgK7A6EGRBm4ro+nP2KIRQm7Qt1aivlIVdG9ObtKWeDrCLvC4kK4hG+/B5NvNY4Xl1Bm83bdzsmYKM/n9HvnZXe1MmATHbPqq+a1xecjP9XkrTFT0GchGAC8TgtXmACJytbNrmT0gW5o0WwItN1naRSkoe1eNskseiBNds713rk7VOzbc9aCkupDiYfHs5qqMfxvxiftcObBo0GWYVu0R64FJCp9UxYeoVkPKC7LhsAr6sxZ8Q08wJMeo5iZHYY6kIIbWP1k+R9uY33QoWjrlscs/cwNJC51332QeXQ4p9Ig8zO/IupDBX6M8fO9Un+DN58ITQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?haD9ZG3IxYfBZnsc1zzy9ctjcyt8Cl1i619FLQcSH6eZOilGtlCTmRieVGi8?=
 =?us-ascii?Q?LQdBesvOQEmPA3Fw+v6jp1W4oRX3R2goZ3TvJquc4sVR2lp7CzYS3AE4LDuQ?=
 =?us-ascii?Q?FP7njpk5Ga/53rriqh3vNATSuOfEqND4q9sEtN2HuMdpph9zUODGSwvqIk6v?=
 =?us-ascii?Q?7We8Yl0sR4y+O/uVLVzhS0aCPHNmepjXTGKimPE5rrprUK8h9R3Wr8Li/dDM?=
 =?us-ascii?Q?gMEJT7TmeOfZpkyfXdbmKmyb7del6KwtyCRqlH7f6uV5UovsV7CU5d5Kchu/?=
 =?us-ascii?Q?Cad2XcmqE9s8EmmQFDbpQJ4cj2HiYOj7nwegmmM21Hvf9hLxVZilumvJvAY4?=
 =?us-ascii?Q?Oq/ew3jSITOVV07cAp3T1Pq/U/b8ZtxMa9giJO7dw6I5ozs654xA6S3IpV8K?=
 =?us-ascii?Q?gHl/jcsyI7ce4k43imrMr0+wialJkNd43ORaBBvULXLII0PMVw+RDapObvLi?=
 =?us-ascii?Q?DOC8JJfuofjTz6CW4YKXBJs+lWDwh3VPn/Zsan0Vjn22aiFVEw8JRmA0rOti?=
 =?us-ascii?Q?rP65EdPoLHthRTzzyGEtRwiDFoS+6ZRP1OJ2wh7/OdrTuY230TEVdwXBz/Ja?=
 =?us-ascii?Q?P6xMkmhy2o+FyAVOgJHKKhe5z4J29z0AxOBuuKBhy9SV9yPJn7ZRhs3fUrsI?=
 =?us-ascii?Q?h0F9ZQqLF88PeJkT2fPts3hmiN9qRZ1XG4QrNUW/qu1gSY79+M+rgiwt91zH?=
 =?us-ascii?Q?yGRwR+/JPxql0UVwkKJqviM40mq4cYo2p1Hmp1B+2HoDJWm2IxU1ss/PKXe1?=
 =?us-ascii?Q?KJudqLtOryR9L3lZwwPWB+S+95ooD281VlH5byli9J6MVOU4zzsXXyDv+jIv?=
 =?us-ascii?Q?gA4qEogKM7W6C+GA1gR/3NGge7DdkTkstoVUnXdotre0DjIuwbEPrl7KmHKy?=
 =?us-ascii?Q?FdFhJUdeoZ1NoMsdWrSzO8yx+AP2Db/VbG/FCb9r2TEp4+rXXvdN4z1qSJPo?=
 =?us-ascii?Q?vQnX9GRuA5d8x9O8JHLwUlbhqNs3EA8IwEqDz82Igxzr79riuOsyeQf9YUCN?=
 =?us-ascii?Q?8InNY23WjdBOrr+Kif4moXxyePBvVlc/Gyra0U7UYbNWBBwYehO0DV2bG7Cw?=
 =?us-ascii?Q?nstGcVtv5pl80EmJUXmIPoqCmHUB1KNieFIYPHBT93cMz+jgLRXvUeoHbX9E?=
 =?us-ascii?Q?k0KGUhbGCJO9KZp+Uw5gJp09ilzYUs5SIO98DTu3f56Q8bpJBx/+Te8W+aMo?=
 =?us-ascii?Q?lgl60YZG2f+aMKvkCFpQHxFOalW5Tk5BZSFhEoHI9foT2K6Z5zUeVARd/mH7?=
 =?us-ascii?Q?kUQzppX05A+xbTTdhkYNl6xO6+1AJX6DpnzZmR6219NYTt7ggmhh2weroL4m?=
 =?us-ascii?Q?8QruL4KOmcUsu5OTQFU/30SUY9+dMuC8bAiJsNcehA6vhXfR0ZrGkh676S+Y?=
 =?us-ascii?Q?M1/wrP8eCo3qTgd5wcKrgr4TBqc9GXKJd2maqIwvRQmh3s+81Tgzust5jJiv?=
 =?us-ascii?Q?Uor5EuPbSrsZdrvtpnrAzLiSiC1PzEGQd1GTOnQsEWx3m3hPJmW1Wp4cwH6j?=
 =?us-ascii?Q?hDIgmXFVua+wdRc1JjgoXlG0r78R8oR8z85e0K5FeelsZNUSyl7mLKmO+5Oz?=
 =?us-ascii?Q?Bng5/hZ6RBpKGC3PTYS3BsSm/I8Bwmd3zAKalNo574ZF3k8+n81rxbnXneD3?=
 =?us-ascii?Q?n1WvxnEwQzVy9CTpplOGfkCydtt1/bCWKkbyPfkCkySqJlZAfrXvJldas5ff?=
 =?us-ascii?Q?oUzyVAx70nv73sStxppOK77gCiR9aO89thfczPswHLM+qfECAz/2tUhLHXQc?=
 =?us-ascii?Q?MOEnVwyVZ876SHOStl5ENdhb+AjbevM=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa6ba71-cfe2-4573-44a1-08df3e225ea8
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:04.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/7EtpDuAWLszIquckiofyxvGyk404xw7/VD89pcfIjCBbF/Xw0yEHiu0e7YJd7SpSrfT0EwtJg4CSkewEcjlJ2+ltlcCOov4CbVmfjOrNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

wave5_vpu_flush_instance() repeats FLUSH until it is accepted but never
waits between attempts, so the whole retry budget is spent in a few hundred
microseconds - far less than a large frame takes to decode. A flush issued
while a picture is in flight is refused every time and gives up:

  Flush of DECODER instance with id: 0 timed out!

streamoff_output() then returns -ETIMEDOUT without resetting the ring
buffer and the instance never decodes again.

Sleep 1-2 ms between attempts, and only use dec_info when the call that
filled it succeeded: otherwise index_frame_display would set a display flag
on an arbitrary frame buffer. With a flushing seek every 500 ms the decoder
stopped after 519 frames before this change and ran past 2072 with it.

Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
Fixes: a2c75e964e51 ("media: chips-media: wave5: Fix a hang after seeking")
Cc: stable@vger.kernel.org
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-vpuapi.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
index f77abd5e122a..397da200a9ed 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -78,13 +78,27 @@ int wave5_vpu_flush_instance(struct vpu_instance *inst)
 			return -ETIMEDOUT;
 		} else if (ret == -EBUSY) {
 			struct dec_output_info dec_info;
+			int info_ret;
 
 			mutex_unlock(&inst->dev->hw_lock);
-			wave5_vpu_dec_get_output_info(inst, &dec_info);
+			info_ret = wave5_vpu_dec_get_output_info(inst, &dec_info);
+			if (info_ret) {
+				/*
+				 * A flush is refused while a picture is still
+				 * being decoded, and there is no result to
+				 * collect yet either. Retrying straight away
+				 * spends the whole retry budget in microseconds,
+				 * far less than a large frame takes to decode, so
+				 * the flush times out and streamoff_output() bails
+				 * out before resetting the ring buffer. Give the
+				 * decode time to land instead.
+				 */
+				usleep_range(1000, 2000);
+			}
 			mutex_ret = mutex_lock_interruptible(&inst->dev->hw_lock);
 			if (mutex_ret)
 				return mutex_ret;
-			if (dec_info.index_frame_display >= 0) {
+			if (!info_ret && dec_info.index_frame_display >= 0) {
 				mutex_unlock(&inst->dev->hw_lock);
 				wave5_vpu_dec_set_disp_flag(inst, dec_info.index_frame_display);
 				mutex_ret = mutex_lock_interruptible(&inst->dev->hw_lock);
-- 
2.43.0

