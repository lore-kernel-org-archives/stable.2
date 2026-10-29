Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293244;
	b=ZaYS8Sx+Z55Bn6ww55Co3KtfWnPk8y8Qqb7QksRNXmotiytZxO4KK0+RrBh7m/dx9pH7
	 l62I2z7BissMjwGoUYlNsXQmhFe+mplooiEZUwGYHA8ZqX+EV2GBSfK/BAQLpakxb+DsD
	 8FDDWEbQRhx6S/C7bPmVoP8WwAkMQ1YkFZTcZu/p4oo7ZPgVzibkWVDrgFK4bdjjB24Rd
	 xDHaInJ19V68ks3BJBx5cjdZL5OHDEGUsemplLgnK5QRuB7uhdKrB38ICvJqJ3znXyJVS
	 6DmFALqNgIGDy4S1lSDzV3LM6FBIOB/lzkT8UDeCg27xrQO6wxhFQC5OdDOXBd+EYZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293244;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sABFBOw1+sgzvxOAwrbaIekZJ+wjNbWPOUKsqEq346s=;
	b=N+l2yDKVEDD2vUKi1sTOrgroY6ziyOD7p4phis9i0D5kOuCnkWNkvHFOSTCOcc3+QczS
	 pznyXwWBJuc+2UQTit64TkP7av+/v8AcvykE+VCBKwAWoFfXceNgIgUPUejD6ozLJB/Oe
	 dznzojMMr3vX3+/5qtjeyKskrVVuOeDr6Cy9eTDMG4885BsXBNM2gfaYp7ughTqvHGz2y
	 BDHe9JP7anPNfTF8oq3Zf9HD77FrDbMMxb627iR0omFP27dgxf2IvDkevtQNRZqecG5rQ
	 33U9lngJaWKKHI4u3vaCFZT6CjZm8VGHItBTgLVwcX/Q9Et+xvFM7X6oWfjtI+uGlWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smu.edu.sg;
	spf=pass smtp.mailfrom=smu.edu.sg;
	dkim=pass header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=lrYjIp9u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.110
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023110.outbound.protection.outlook.com [52.101.127.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F0606A31A;
	Thu, 29 Oct 2026 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC9F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smu.edu.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smu.edu.sg header.i=@smu.edu.sg header.a=rsa-sha256 header.s=selector1 header.b=lrYjIp9u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW3NYKoKiZv/IMOEDQnBPDtVyAyLXjOtYCZe5uG4h5dLCxLewhdgqn3In/U4q+LCkovtqRw27rJUnP5MmnzxRqqYiBEewqwZMjeMz+2o6xy6MKJBZxKEGcLi7/QcVRQ3qyI1FrUpQPkYkyJ7HmjTpJ5gJyCDAGhf+d4VRJbGvyygd8qzk8/R5t1fb9Ajq9tcFVei2cGb2BjW7p2Sx9JImer3L4uZ8ln9sm3nzMrJxDa0FOuz25nKZF/0ovDmJsEdAQaEEs7/2dScdenwDNdV6C2/PVOyaSS3h0sU4ERW/PJSQBfMKXdAj+mho30K2T8QKiOC4E+WnWvslIwzsK/kLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sABFBOw1+sgzvxOAwrbaIekZJ+wjNbWPOUKsqEq346s=;
 b=TO546/I2dvN9fOXpEcrY51eZtKF3uUwEEO9lgDzbYmJGyuqQys2bqmm3a3a0P2sxFeR1EVMNI1T5eRMaAQyuMvcygiRJ+t9ec/Q49NrProhH5/ksFOGIDFR4lCrQF+7X0nfXorVe31yuafApx6pmazblohKzQ/cvJUTJ0n6qbJ6k1B0yIiJvwXUL7IMXRbn1GKK9NjUcykRoZHgUxQ0DaBdXhUd93JOWOhoN3iDjAULYl3NrQLaxfv2KsLVAJa/3yUWG7cIgy/LEiijIMhxCFO+gElgw9yjTi/e0JQH0t7nLNX4p1SnPqHi94ECLYrMXwQIf46SPBGm1w1pk+indoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=smu.edu.sg; dmarc=pass action=none header.from=smu.edu.sg;
 dkim=pass header.d=smu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sABFBOw1+sgzvxOAwrbaIekZJ+wjNbWPOUKsqEq346s=;
 b=lrYjIp9uqC+td/6niwi0uIpFg1YtKZwxluW4Ue13wjM92VEejq62OCyP9xVg8HyYsSjW73O0UUqZhdFdVHCO3ehbqDca2rfLx5SyjCNwQZc6/IG1s6iqhDegdfvLDvqwyZzqPS7Qp7TlqCjKiVOtQJ1KGhcEIh7yfgupl3tIhA7xZD6xPK0wnggVS8EbsIm+ULafvq8ela75sUStesEHP40s0f94+fGC65J8esCfiabmH1dQHtPbYn4nVK8gh0nSPtVB94sSbZZW8HMHbh+jBFl0EzFBiR2Fxd9435Mei5yefik7Z2uw+azr/n6NOkcrG3JJv35HatgdTLISckUL8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=smu.edu.sg;
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b3::11) by TYNPR01MB8294.apcprd01.prod.exchangelabs.com
 (2603:1096:405:3c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 17:00:37 +0000
Received: from TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382]) by
 TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
 ([fe80::9272:a3a2:eb34:7382%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 17:00:35 +0000
From: Huihui Huang <hhhuang@smu.edu.sg>
To: linux-wireless@vger.kernel.org
Cc: Huihui Huang <hhhuang@smu.edu.sg>,
	Ping-Ke Shih <pkshih@realtek.com>,
	stable@vger.kernel.org
Subject: [PATCH rtw-next] wifi: rtw88: drop C2H packets shorter than the C2H header
Date: Fri, 30 Oct 2026 01:00:17 +0800
Message-ID: <20261029170017.832708-1-hhhuang@smu.edu.sg>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
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
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4264:EE_|TYNPR01MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be678b9-3816-42dd-0732-08df35de2619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|23010399003|52116014|376014|366016|1800799024|18002099003|3023799007|261028144727099003|56012099006|11063799006|10067099003|261022075727099003|261022105027099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	RY/F7MbYjvxZgT8r7z8Dstj/M1MVoAlltTGg2KzbBYvmnDhX5FdElne171jK6wz4ZaxEcgQHnu+50eaR1jGxr4B20ZWYrHMJ7if8CA0QrDMCVCoVlo2+KvxRm4Q0FSJ1RCMrpkcHwDUdt1hPNrFe//cPua/Rs/JxU/k7pRf113pqFik7cf4sVNnDh++cM40yam/v55IxaYPp7nN1rJmBnDEHJq3mmGAKs2/Aj24gkBnx+GmwToKesusLCLj7elr2WZNFV0x4Ch76bskFZEsryVDyoksG4Er60yGBCLmzmnOUwJQocpcCOwvHZcab9AjkFfiCo1xxCjELq0FuGPagaWFDjNE6UyyDpUGWTWGpuColrG5+8Wb8bdZUHtyZZxOsmszewy9xepDvqqj7jmTZvgoMlg6yNCvSQX5bTtTt/7fCwk5+cSYQYfEmf4FsIaQDfFvHuwABsRtgVVbX5/DdFZnn9+VmKTNC0Rjb88gKV+aOhDM1k9DHhBKtXUKbTS6CYNsZcfBNzm9vNFzljYgVtmMUoAmY3TvlFrvv7YkiSbxTdESuJl9SNElxOQKOmqFwqxom6vBMpEcP+N5XsFbXS6srfZvoEkYrfF4BZV3T9oKCHc8NG6YHLybdlAXofNV0gy2otkc94v824cZ2zm47dsIwvnC23V4tY26WPzmGFXRTc+4TVKaC3D03yVJAQPYW8VJOShUg0bNo8Z1dUYZWUa5CDzgW2aqshextWnnKzcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR0101MB4264.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(23010399003)(52116014)(376014)(366016)(1800799024)(18002099003)(3023799007)(261028144727099003)(56012099006)(11063799006)(10067099003)(261022075727099003)(261022105027099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9g5fTOr3ilL6WWqMDl3HZI1/h1Aag63bHN2kn758B8WrzCI0n8mP+hCsKQC?=
 =?us-ascii?Q?mZpef5RH6nypPVSnf+/MiH1Twq62ABvLFxZcoeRIAD5nNilKOsEdYl5nwH5M?=
 =?us-ascii?Q?v6aAEnFDNTc8milGo1If5U3BBh7Hz5E18gZmWb/XzNRWuXaPVAzeOgYMghSw?=
 =?us-ascii?Q?qCrFVjJGUzuh3R/jGxubOOfj24p8HGu/pBn0RBRZ0X6BOn6023XdogtEBAEB?=
 =?us-ascii?Q?S5yP9kYySinuxIzVVguYq4Qk0yUBrDq+3OxhsmbeASrRUkGhpnrGHWi4aLvs?=
 =?us-ascii?Q?okSk83PTNd2qsiUlaOBp4YJgmFs7ROSJ6WH+23iw6mDsA1vYP0oVfi86QpVN?=
 =?us-ascii?Q?2kGeR1qef9hXbNCZOyd4B9BwI6+Jc0sYtctPMVdiggiZZgNTEE67l4d9k/0S?=
 =?us-ascii?Q?3VdAULMeqBlaZ4ilBzwa5nOtMAkxDD2xoFDQOjPHTq3w6mf62vEBd/UF7dOl?=
 =?us-ascii?Q?88hCN29ucSWWRHTQR8YoT1L3LkKv/9Rn6Qgbly8B47zWuAgMX4MZd5N/U0Nt?=
 =?us-ascii?Q?6sJzluQ+a36ZHWUoUqWVAuDXk6bv0hd1OIUz26hT5y6zn9Q/WoD0/cX2OUju?=
 =?us-ascii?Q?ZgP2c3zH044+MUf9huqVwVlX4wpBZIsZKTdf1c+sL3tSai3iQgZ0m5QO5qfy?=
 =?us-ascii?Q?JetcEa1gD+Ct8ujYS/1QQ2M8WFfuSPo/Ru0HSwV34cjrn17K8IwNRsvmc8mQ?=
 =?us-ascii?Q?f1E2F3PN4NxtO3Q8MaZ3Tec3c0+Xa7kE01MNW5EcD/LD8+RG/NzZlUvGzw/W?=
 =?us-ascii?Q?PdYhRzW1cV3UsShWJgxH6rHdiT8GXhSB/t+4H4VzXU/mGaxwNlrZxr9e4R8Z?=
 =?us-ascii?Q?q25AJ9fGqn2GatqTKWPfaSCh2rJ3aiNMNkwthqS8Y3hMBWWH5GXEWv6R+TX8?=
 =?us-ascii?Q?ITUX6MY6o8YoKyDlfZBtXhyHBSFS2Ie93QY6188DEf8i2mpfAdBFbfLxeLK/?=
 =?us-ascii?Q?oLFc+Hi4tPXMOR9bAfc/gHJIpMXeNUODPMdqZ8z7ABU8juPngmynmGCgmzpB?=
 =?us-ascii?Q?0HW3yHPksDKWPZru6iKYSDQEmn70irSSGYiNMVQy3j5KDTAnMhXrfYC4PeAv?=
 =?us-ascii?Q?O96rJFz3vGF1wUe+Pk6L5F3sKv4VVrD3RhPUilNXaZf8pA95Kds5/sJAIVfU?=
 =?us-ascii?Q?n1rR2gCgY71ZkounRhqALMWxsXIN39oWvhe4Sj0PnFGMlbkJLjfZGYmcZW9f?=
 =?us-ascii?Q?OTL1Kie6O/tWeWKAHwx6Qk7ZaB99f5yqkbe6NqOSM7lS/kP9y6uDXJ8hzuUT?=
 =?us-ascii?Q?zBrO2w/+fFayuwIrhQnq0k2x0y23hEewgcHb83GeTtkQOD7RKTiHttgpd8J1?=
 =?us-ascii?Q?LijmrZUm24D8orzbjJJmqlD4DnwQuSIMNTrKjLirjrJwIrgbYOhSMFc1pO58?=
 =?us-ascii?Q?OwIBa84q7/nI6rZOjFLFacNA74q4bpsfyLnHp7RNIQj/OSLroVYYExivhaVp?=
 =?us-ascii?Q?fwfVt1Vf3PjtjqBrDE1mDdYux5/wQyNokhsL5yqEwaHCxiyUwYO4nNw4imI/?=
 =?us-ascii?Q?v1OWWcpuw9zazNdXQlK1j8czuQKB8VpHnaybtAfiWNnPb9HDZc+ed+RVfnte?=
 =?us-ascii?Q?J1jtovDUHTua4zVvgUdPU/ObL22THQ+q2hTWnnlC6PcQHcKwWIKSP3B+MfTo?=
 =?us-ascii?Q?xgqMm/VM6kF3Bn77WmeZfxP2j6bxhfFFVr0JGp/BC0lr6EP1At5kBOhv0jVI?=
 =?us-ascii?Q?4MJhCRuzM2dY+yqh64LuIfkFofKuEQm15kkSTS/YHiivIzVGf2RNVL8BzOi1?=
 =?us-ascii?Q?V3sJsYnBZg=3D=3D?=
X-OriginatorOrg: smu.edu.sg
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be678b9-3816-42dd-0732-08df35de2619
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4264.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 17:00:34.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c98a79ca-5a9a-4791-a243-f06afd67464d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjqPCmOC+Uyb0k5JmxKfV8hUcNcPm4bWCcVllE2mdwVokbNhRnnaOYwjP7UMvqvVcj5gSLV7StgWGWLxPZPFeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR01MB8294

rtw_fw_c2h_cmd_rx_irqsafe() and rtw_fw_c2h_cmd_handle() compute the C2H
payload length as

	len = skb->len - pkt_offset - 2;

where len is a u8, without checking that the skb holds the 2-byte C2H
header (id and seq).

If the header is incomplete, the C2H payload length underflows. With no
byte left after pkt_offset, c2h->id is read beyond skb->len and len
becomes 254; with one byte left, c2h->seq is beyond skb->len and len
becomes 255. The wrapped len defeats the minimum-length checks in
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
 drivers/net/wireless/realtek/rtw88/fw.c | 6 ++++++
 1 file changed, 6 insertions(+)

Tested on rtw-next (9b0be45d4d52) with a temporary handler-level KUnit
regression test (UML). Each case allocates a 64-byte skb, writes a C2H
at offset 24 (pkt_offset), and skb_put()s only part of it:

  1. skb->len == pkt_offset (no C2H byte), C2H_SCAN_RESULT, payload 0xab
  2. skb->len == pkt_offset + 1 (id only), same C2H
  3. skb->len == pkt_offset + 3 (valid C2H, one payload byte)
  4. C2H_WLAN_INFO passed directly to rtw_fw_c2h_cmd_handle(), as the
     c2h work does for queued skbs: first with skb->len == pkt_offset + 5
     (len 3), then with skb->len == pkt_offset + 1 (id only)

Cases 1-3 go through rtw_fw_c2h_cmd_rx_irqsafe(). Verbatim KUnit output:

  before this change:
    # rtw_c2h_short_packet_test: skb->len=pkt_offset scan_density=0xab (want 0x00)
    not ok 1 rtw_c2h_short_packet_test
    # rtw_c2h_one_byte_packet_test: skb->len=pkt_offset+1 scan_density=0xab (want 0x00)
    not ok 2 rtw_c2h_one_byte_packet_test
    # rtw_c2h_min_valid_packet_test: skb->len=pkt_offset+3 scan_density=0xab (want 0xab)
    ok 3 rtw_c2h_min_valid_packet_test
    # rtw_c2h_wl_info_len_check_test: skb->len=pkt_offset+5 fw_notify_cnt=0 (handler accepted no)
    # rtw_c2h_wl_info_len_check_test: skb->len=pkt_offset+1 fw_notify_cnt=1 wl_fw_dbg_info[7]=0x17 (handler accepted yes)
  after this change:
    # rtw_c2h_short_packet_test: skb->len=pkt_offset scan_density=0x00 (want 0x00)
    ok 1 rtw_c2h_short_packet_test
    # rtw_c2h_one_byte_packet_test: skb->len=pkt_offset+1 scan_density=0x00 (want 0x00)
    ok 2 rtw_c2h_one_byte_packet_test
    # rtw_c2h_min_valid_packet_test: skb->len=pkt_offset+3 scan_density=0xab (want 0xab)
    ok 3 rtw_c2h_min_valid_packet_test

Cases 1 and 2 show that incomplete C2H packets are processed and update
scan_density using bytes beyond skb->len before this change, and are
dropped after it; case 3 shows a valid C2H is still handled.

Case 4 bypasses the RX entry point to demonstrate the downstream
length-check bypass; it is not a before/after regression test. With
len 3 the "invalid wl info c2h length" WARN rejects the report, while
with the header cut after the id the wrapped len (255) passes the check
and wl_fw_dbg_info[] is filled from bytes beyond skb->len (0x17 is the
byte placed there). After this change such a packet is dropped in
rtw_fw_c2h_cmd_rx_irqsafe() and is not queued for
rtw_fw_c2h_cmd_handle(). The RA report path was not exercised.

Not tested on real hardware, and I have not observed such a short C2H
from a device; this hardens the driver against a malformed RX
descriptor.


base-commit: 9b0be45d4d52fd223994e151f169743a97abd290

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 945fedcd375b..2e37c304cde0 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -353,6 +353,12 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 	struct rtw_c2h_cmd *c2h;
 	u8 len;
 
+	if (unlikely(skb->len < pkt_offset + sizeof(*c2h))) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "C2H too short: %u\n", skb->len);
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
 	c2h = (struct rtw_c2h_cmd *)(skb->data + pkt_offset);
 	len = skb->len - pkt_offset - 2;
 	*((u32 *)skb->cb) = pkt_offset;

-- 
2.43.0

