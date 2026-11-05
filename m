Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793883626;
	b=DI7Qi5er2IpVn4gJd3pBx+S31m9bXUzbfQVWk3pg5W9jU9FTu4guCIun2istOzsdULKf
	 0HiMw/kZLP6UDCV8Fsi2zm0ydny9sw6fq7qcYbDz5rAfz1ry326A1PkmjUFLxCy9uAdRl
	 xD+FC6pGQfYJnormL4EdehuXdkE9NuT+SN9qgVAMcvG8TgV5hUNezjpWOjenmWcDffv5w
	 014iv1TgL6In0Lt31XZktHJNd63+h5wVj7VGFxts74z+2KIl675ILPj/AUoMWbgCq5GPe
	 HUomscKZkD6V7V2Dz27i3bZgUnmXHSZ5NWGFuS6KgeSHUPcLHxmZnjTPWZJhaT+cNIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883626;
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
	bh=KfzsZF7LZNVd2baMz4+OdV7VR215R2eNNzwUM7DtZKY=;
	b=wkxcEpgu92qKR2BDnXapkJ4FHwgyuIrUcXh3RmVO/ZbUfr2VXDJhl30IRk/v2w8cNajN
	 //GSjsEY7/aJGcbMldwFIWAs+6pTYf3XarVMaRMn05cjRzakQ+lAJivi27xo3ZoOzP+u4
	 e8HidfCUknrn8Kl8LhRxiwCZaAEn36F6/2cH85P30gXO2Yadb0ylh2r/GodBbCcOXCsSU
	 RE8Ky0/b68w+lQTkE9VogepqJe/2VG/7hfnhbKgbu4Qvbf4n4IpFtCbzriwFOgzVL11s5
	 6QI35dG3KMuaSbkrddOYxC82HIn7DNyFXou0nvQqQeRLHgU8IKybVwjrYvQvIrwV2Nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smu.edu.sg;
	spf=pass smtp.mailfrom=smu.edu.sg;
	dkim=pass header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=VDcpua6+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.94
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022094.outbound.protection.outlook.com [40.107.75.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527F1606A32E;
	Thu,  5 Nov 2026 13:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 527F1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=VDcpua6+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYJYGiFjkEYsCzL8zDLI8RKxNxhzRZ+EGsHlx8ZPkdTTcJske9IYC1TxqxndA965+QEwbULe4Fe0kEezFeBsh6Ticgdv0+BU2HzGg8pJaLNMtPOB0Xyel2tEetd9fiaLmW8b6ms5MBAx2e+JU4EorZSuTu+oIufi4aylqF2aylzYp6oCcdfTQ9GZmyRwRpaF3KZGY0fZmHF84vokwAzZsUtMGKIhfczKR2r2L12IYzQo3ZKQvQ+cDB7nZH+/fa4sUz30PR8O7UA5uF2FWSr5hc/LOdMnp68YWDLDH1S9CYhst9/sh2+OExyZc06gfOI37H9IMa41EFw06jiDwRgqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfzsZF7LZNVd2baMz4+OdV7VR215R2eNNzwUM7DtZKY=;
 b=AbmUkZrX3yQ7sxlcy0XjgSX1eWeLFGqEMLTtCddORVeapiijIcMt5GmViNViCQYZ0PipsnjBixa131ldhTVuOfCbjYVnBUToPb6oM6aXMcsNQgdH0oZm2tRq650UilWX2uSPqpC8eQEbvwKhYbK3K0+0zfEPfudWHaB7lkVleOPFfdxrLtAr4GajTrQKHifjpGE9pT1762tzlURCyVL3faQXJdZUZgbsNZ8QTjV4OLz9kkDcVmXsAmJ8sdG36N/USWpomiJj4pTq0v224smbTxyjZrkilts1nuEMGhJU8AcbcK+DwalW8cZweUbIiSHV6SfWGqxW5yPmKbt4omyDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfzsZF7LZNVd2baMz4+OdV7VR215R2eNNzwUM7DtZKY=;
 b=VDcpua6+goMblHwNclDncwNX8rzYoH07UgUfBIYgDd9yJ5WUytM4pirwKevuo32xYg1otVU3dBkeAkPVPIRBZoIqTZvjAYLkfZ8gBNaAnnsU1SKXYpV9LwbE/QI2X4z4J/9HOrUWZJFHnMheMMOGQkcXgccn8kc1qUP7JW9NgjF54LGhP0qmfDauqgpbeI29X02WDiKvrEtGrXvVcrIfqyy4nnrHajpJIPVwhv5aYERy1blmpB50dH0yALekyipoMolkdxW9AgoJnNaJI+8qqI5zkvrvkWDy+z4YyvbMLY07MLA/3KmaKJXYF5NfaxvfPQaz/PN75R/ElJ0paFkUog==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smu.edu.sg;
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11) by SEYPR01MB4127.apcprd01.prod.exchangelabs.com
 (2603:1096:101:53::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 13:00:17 +0000
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382]) by
 TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 13:00:17 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v3 1/2] wifi: rtw88: drop C2H packets shorter than the C2H header
Date: Thu,  5 Nov 2026 20:59:54 +0800
Message-ID: <20261105125958.3891196-2-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125958.3891196-1-hhhuang@smu.edu.sg>
References: <20261105125958.3891196-1-hhhuang@smu.edu.sg>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
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
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4264:EE_|SEYPR01MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ae5e7f-acf3-44c0-4b85-08df3b3cbd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|786006|1800799024|52116014|10067099003|18002099003|22082099003|38350700014|11063799006|261022075727099003|261021121427099003|261009223027099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	TMCCX9qEXl92uNJVVXP1w9r0fh7cAtc3h3v9JrkQLNecH6jWb/wacAFU+obgn6S8LRSo7CaNe2TC5kUsqrjRNQ/e+CCTqbj9ROvuc+Z3cYwLt0lEhZVp4P776R0m1IjiA3BP+yMZvJwFlbH0AgxfpvMK04WPNNyqk4bvwqw6OfrtY92LIPi+8VJGP9r4YFx1uDzAj+mewEpLXnLT00b09rTktrZZFZRaKhbvuoNhcGvCgwcBCld8AJYJlbXm2mKTClQ2sP39bsIM4Res/Iy+Z93Gu1QiivVyGoVN27Bvd72O4dKfZxU1v1jUbl9Jg5/cGIeyXlX19xkorOYI6dlvYnkYVxPTxemPs2M6XFiE9hV/ovR6J4A5AUyDFxJA8NHgvA2j9zRQFIidZNZZEavfUd4EfAaQuH9iKxOa+6hPKg/c6kHR03x8G7bA4T3eJo2dJidfvdsuRflILaYIlVMC5bLpsPJp2fhkomObzc2WvrQxb6APZM/gqF/0RKRd9QM3BP74Ck2Lo4DQ6TsSE5TeK/INAK6VJOZhLKZFlICcj6e1UQuhdFXzwKVpvBvMHxwglR0IrmT49MyxLhVK60t7IRhv6hH5rpbv9tIc4MFUra4WaICNymYZQnPHgmgOijyvJIBGMlDHt5pgiXrQVyMZMznpydUCJ5F6tXVmKrqjEN73HLalJBxnWjw9JrA6NB++QTmvOsAmRjjxxzhZ1cAWvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4264.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(786006)(1800799024)(52116014)(10067099003)(18002099003)(22082099003)(38350700014)(11063799006)(261022075727099003)(261021121427099003)(261009223027099003)(56012099006)(261102123227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?13PwbMYEvBCiYUYhWmHk6Bh2RB3yIcG9jIB/kaPhWoNvO2d3Nq8rgIzfG3bE?=
 =?us-ascii?Q?0sIKzGaKFpUakyGtIj8ODt8Hy+ZigPytH1kBFEcOGsL7glJ8Xs7+4fq3roIv?=
 =?us-ascii?Q?kpaYxGyC3Wdyim+7IdL9YKeG5o3lyysksXwpyNpkPQHOGdR7ygAcv8xeOqj7?=
 =?us-ascii?Q?SYcK8ZjJ7m3sVyuWUvQS1PNIBoP34lwJZll0nlZjpcIBJtRRgXan5UNF9cQp?=
 =?us-ascii?Q?cNKi+VekXoW//aaAtRT0dyXfD+7mIHdz7KAeSfAvZB+uoYXoRa8kMXFV7PRQ?=
 =?us-ascii?Q?Iosp9lFddhSTF0nLZXAZhXJT/X10rym98i67QsKcXQvHTIckC6gBpen/XA7P?=
 =?us-ascii?Q?p1WnnI5nTQvYqUpqKFVBrnVPA1zVxqguYE7HOjQobUOLaCCu1p1z4JYLC2ig?=
 =?us-ascii?Q?JULFc6wzwlZpgj0utcdO0hgs2eft832crm9f8yM/+YcOVp1vAP8EDbPUitLY?=
 =?us-ascii?Q?Qiy9cBJXCi0TDy+ZLvwRcQhGGlB+/aq7lcCepORM9JUru1nxgfayY2yKmGYi?=
 =?us-ascii?Q?r3t80kufoWsmsOoShGM5cIKpw4qevGfA7p0mtnPSD2AOTrnfJ9fggahrBU1G?=
 =?us-ascii?Q?/9ZJnIFWdpauUy0HJV1vTVlxUfDcJw34Qy9jtCzQa111K/RSTnYhZzjEy7NC?=
 =?us-ascii?Q?jTwwkoDuFn7cbFaqyaR7WWS4qvYnDqRBrPi1kXofu91nUn1nx8KncvcOr1mb?=
 =?us-ascii?Q?+KhJSrLHEvdmsY2PcRlbHiDSM5ai4CO62NDAaNiMwV3u887+EIQsn3jjLY98?=
 =?us-ascii?Q?ONfzHzxdXnq9dKfE4YbKj0GX9fB0rbDC4KY0PYcT11x4h2O+I1kI7qnUnIe9?=
 =?us-ascii?Q?y4I5QMevprmAwVCwwutY2e8j+xvV4NW7TAUp860xa4AzS3/mMK11fKf32Ef4?=
 =?us-ascii?Q?Oqvc4WdyAANd9ciDKMSRZ1Qd5TV2W5QVgFnZjl6MWzlTUiDvQ1fdSVnaEIFG?=
 =?us-ascii?Q?wKM0tQ7AZlez1s6TOOUslQWC4kNDaHWjATuRUwmdl8KbO4obiyuhHl78Ppf3?=
 =?us-ascii?Q?atweDKqBZT0/2FOt+8v5FqJNAFwFAzBFPYWosSWwxd+IBawyevN6vAXPbUce?=
 =?us-ascii?Q?1S0Xd7uWrGqw804/SFN+YYw+2qVmQHbg5qg7c+8nb6Og4Po9T3Bd9R+/0DO8?=
 =?us-ascii?Q?gsIuN+So5NVFeYv8KyNIBLBmC6lisjGRGzthFRdr/56GL5LhY8CakhFGWj37?=
 =?us-ascii?Q?JcOUUaMPV/7aLwwrKdeNranZWaKEBMkbe+LoJjGF/en2DLVl6wkNxE7oAr06?=
 =?us-ascii?Q?Swhnfz7TNNIlfhPCURjFA0dFBqIA4ZFBjJ9orNhe8OUEQ4QtBJ/y8h9HqRPy?=
 =?us-ascii?Q?ZBMdw1yUQ3+vDWA+xQie9pxPnkYf8iNxzS0Is70CTm0PDgAxx1PWBV7hzv19?=
 =?us-ascii?Q?FmdS3KxbqfwXi6oFPzm+yN608SPFt2/WZvOFmEFqqpcbJS7gyPKmdAPUFQcj?=
 =?us-ascii?Q?d2y2B7AZ7eRczRKBnubGjWxVoElCtBnoD3/FCHvUjLmBwlxX3s2rqQ8xedYA?=
 =?us-ascii?Q?VUc6MHTXOPwPb7MRCPHCn4XReyMHXFeZ++Zc8MGcq601Ul0IUfP6oCks18Sf?=
 =?us-ascii?Q?dYzzrI9J3e9fPKJMtQa/fMxmEVNBft2OcbaWjFgmnEgBm5CnPg+ORltYRLpj?=
 =?us-ascii?Q?21WPyNuZ0bZBVX1inU+nTZ2fGBN9YGgh9RRXE0yuOk1uLUSd9KZLopjrzyLU?=
 =?us-ascii?Q?tHHHH2Om22UfMtsyq7W8n8ISvyHnaSXn40NiU5WQQFvh1AOq89WqcjnZ356W?=
 =?us-ascii?Q?dc6Y+vcD7Q=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ae5e7f-acf3-44c0-4b85-08df3b3cbd6e
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 13:00:17.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x8o6+TDqA2OTEQpSO68fd+tZjuJDTHsHElxJvbuZRM5ZonU0KJ0jSPJVoD4+1/GPpffcpbLZHUcc/ZAxO7/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4127

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
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 7 +++++++
 1 file changed, 7 insertions(+)

v3: add Luka's Reviewed-by; no code change.
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

