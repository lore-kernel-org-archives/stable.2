Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013081.outbound.protection.outlook.com [52.103.35.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B142A96;
	Mon,  7 Sep 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745798; cv=fail; b=ng0tTMsTyEOqnk0Zix/1Ysx8i0+m8pClq85ZFjoSB/s7mW9I/X5YR2G6RdTRlYzEwLVEEj89JQm1DLYH4xvmR5wSfnJCcS6+uQ/yMbKwPaxriSgHP8rx/nXW21znF0kMXPEuS6PIhBb8qL7UnoXek/V4PAV3Cn57wEUn+G1zdSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745798; c=relaxed/simple;
	bh=aKMC+m4QJP1wcqPiHYuZ2SwYjQNgzkAbNXkpA+BQqJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hukvEKsNSs+RPmA/7rh06KRT/3eps09LwaGQK292bIFJMf+S0nFeEZ4JD2PVM2Vxss/86XTpyus7NQ4GNVhfJhyBlVSNeyo75jX6tucj4Ve8FZduC5N5IDiwpxnGuo3YKPagDW1piU5rLhWdFVWpmj9zF7uZ1PwdkjUhvSDq3AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=TF5k1xzO; arc=fail smtp.client-ip=52.103.35.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="TF5k1xzO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDxdREPegIHH5rjY7N5cpuF791e1fKRKE4yMdbjivSGTwt6EKJalLjlOBeRnlihG99m1is84HDz1OsDGUE8Bau1J86eyDaiLtk9TYp3jBKvaJzi9st8azmIxNjN1YukkFHWv0nAWPfFhv83y+Ea2bqklTeZiGTj0kmukVgyzdj8auc55OyowHZJjg63w6IIpBtE7AW2+LORx16kKP1BTLznliNV1oh79OcTiStc0Bu9fsfM2l7M2DKT5OWdkk+imazhFzZMPJ1aqDTVFuDhBasXWA2G/u59+UQ05LmeeFCUkXn/hNYaCUAgcrovLnoSTQ3HNSknpOwTghnTySYnzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kVMv6zka964XdvgAp/S7MUHopbEjE3bPrb16Y6ZHs0=;
 b=DyGWvVCRbArNNgEcamEUlxpVuPdOF8z6IoEDEGkqm1X+8M9vKTxHi/svhZYaznJer55ftouI4+enpK4bXjQSNqvJrvQ5bn/oSkT8riC6KkydOjgVHPXUMNN837CyMMJ9XFGrYHLTHZu1cz9w4xjzEx+fCYK9i1eccEWHkWD1HqPoc7pJsZ+8AaK2AbHpx7jIciUvMIeLO06oCBeH5EUOOLDTOQLpQcdhu2Ccc0ARCw6adgqV/dfIxZC+/c933+3ZyvIO7c+sxo12mas+/AsRPsyWVuqBWP+HE95EXJinr3hJJ2k2uq9vmPFgZHBR6Y3+DXHkBwVZ3d4RobtPsFkTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kVMv6zka964XdvgAp/S7MUHopbEjE3bPrb16Y6ZHs0=;
 b=TF5k1xzOUikuXsJDqTQEs/XNruiBiuoNnoh3t/snKJedkeADnBYnILZJ0gpBInJsFoPQlPBMXRq0RO/M1owkzTzGx+GDPktrrKHigQYmm1Q+jJNos+uZiO43Sv4iPE1TkFMYeY0KpnSPIq5Cy7m0mDNKFWpb11EX4Rt5bYfl+z06g8irmTmkmfamIJMd7GnW2fKc00f8PLr9nL6mfoV22mE/Vkp/zC/xPgindyOzMzplJP3EN400nSfLAR2XgNlQb9dfU3kLle/ZGC4M7+onjuvNyPEIIBYfe/FgBWaKdUmQdoSHsatjSVAbaC9ucPwwin9vt7DoavguY/q5yyUYBA==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by GV1P251MB0978.EURP251.PROD.OUTLOOK.COM (2603:10a6:150:9a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:49:54 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:49:54 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>
Subject: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
Date: Mon,  7 Sep 2026 01:49:50 +0000
Message-ID:
 <AS8P251MB0001E25A247262552A62241BC8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::17) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907014950.490030-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|GV1P251MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a74c1f-6b44-4a2c-7d1b-08df0c825000
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|5062599005|55001999006|24021099003|15080799012|4140399003|25010399006|51005399006|37011999003|12121999013|2604032031799003|25031999004|19110799012|8060799015|23021999003|440099028|3412199025|26104999009|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvemKZ+5acEs2ja0BHs829KizpOf6DXRt3ZpTMlkNJbOziBvsx+C2HPMTl/6?=
 =?us-ascii?Q?fTVaUfvTCIxL/Bw7XjZtUx0Y3Wfo4ayVDZX0Ku95ittnyPg4t/paLR4BtCcs?=
 =?us-ascii?Q?UhxrjC9F2QyonR3vwkC68jMRHLO6cyXKAgjhkDewMoiQ12Ejdf61gxGad713?=
 =?us-ascii?Q?oHJZMyIpgmUWVyyBxWdgodCisnQV4Cqhh0N/ptWD//H3Q8Sf5zQHKQQ/wH+M?=
 =?us-ascii?Q?ESQRF/H43Hh7GdbzIm/gf3TsRH8zcj6Ear8LIcqHfjfFkkhd/cZRgOklE8d0?=
 =?us-ascii?Q?29EIF3ILUKB5sfJBixNf4KRHzW7NPaJ2zf0hkYk8ZbZav87WIknW33HrETj1?=
 =?us-ascii?Q?j+PMPPuXUY1fZJ7PH6wIeaREOTWt1YTVhl1sxXPuroD+6aFXtAs0Am3GNqwn?=
 =?us-ascii?Q?LjHf3/R+BLkMBkesISMemjHs1rgmoOVth9DxSbb+PxEDmC+x134/Yw4u1pHB?=
 =?us-ascii?Q?AfUuwnl/jHZZ2M4DnoEeFYi2ONU4QvWSBoJpDPxXxTwXL1DDGGCa394fEbpA?=
 =?us-ascii?Q?DLo/g7lT300x7EOWcfE1v10BFCkGaB8jQ6TZQmRcE2fsReILZhfeYEkjTRCx?=
 =?us-ascii?Q?2mVNoj/pYKqjiQji3ClWjQBRJlNHq3NjySIrGkWEwNAT0dDQHR6gQpIiUfXK?=
 =?us-ascii?Q?4Mo9wvNSCbGFmhkXisxoKTMFQzKtEfSkLmAorGfjQaAOfKyFBOeyBhD68rkp?=
 =?us-ascii?Q?ERj5swifvAZrfSHq56HhnVoow5xwEWIhSfMg1szW9HTh5rdSYKMS3dOCmHmm?=
 =?us-ascii?Q?tZM4dFoWIRBU1uX73kcl/yg82lIflqcejjOYdB6ocJctPp2c2HAsTGhMknTk?=
 =?us-ascii?Q?mnYv4zvLzvhWTlELKsV98QDJoaMTCv0vQVuRKRLERdnsP9uDRJkxWYvdBZhj?=
 =?us-ascii?Q?42PfDaUC6cXqyMDjp0QK0aHJjd/GJ9CeGHXMZuUwLVBO5BiJXzS+aFVppcgG?=
 =?us-ascii?Q?XqvJ9mgIbNQRlWaT4rxe+0vRe0tnKSxlQdcajRvzw6hTirIxq0MQ12i+054U?=
 =?us-ascii?Q?teDOYaxPG5FtxDTYrq7IKnub8904Ugm5H8Z5O2t3jx+Er58TlB30VlnsBsqL?=
 =?us-ascii?Q?ksLC21MgMUcP9J+KTJw+7cMT1q/730RPPXez38O3LhX/6XxLwXbVvrPY+1h3?=
 =?us-ascii?Q?saQd9aS5+VykJyX5bGxMijxq2ZQ6Sf5Lq/NoXZRfNqP7+G7xUyNTJNs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdKhglJyzxFDzHXcBvgNgEXU9fIZv8ZDfcGyaf8rqZKea3bZ7/iTo3zPD+/7?=
 =?us-ascii?Q?tr7Bv9E55LBr7n8xK67JbWF8NBNs3Mv7YrfdGbOscC0CnnlJLreuaD7oNq3M?=
 =?us-ascii?Q?86LvS0CNd9rm392MvCjR8fUqQpr9XAe7uanDB6cmO46Zspm3IHBpVYoWT2J9?=
 =?us-ascii?Q?rYKEqBwOF8eOGAFoVQHXJSh63DWzz8FAOB+A4OLLdDeIQD5BO8eZojTcnxJr?=
 =?us-ascii?Q?8ao4zDK1V5UtmbwYQnVLtdSU+xWjXjWpj9A1pr1T6xrR04wEzV+Hxcsb9TZ4?=
 =?us-ascii?Q?S4A0+lz4e5ZqWAMh6TM9VwiwP22RcI//Y33AdH55J2OndZ6cHgXChL2wVKbr?=
 =?us-ascii?Q?gBlj5vAAx90SLFhNl41Uie6RZi5RSL77zPqjL8YHc3pngWP5H4ft6e6v25ZD?=
 =?us-ascii?Q?dTBVOrWxXcdHaeOvnbr8rRTEunLkCWGU9rvO9rsyEYnuvlA3eom8reSMBlsc?=
 =?us-ascii?Q?SMc4HC719wreK+qzis/1Fu47AWuZUOCR1CtVg58Xq3TyFU5mVpKZVu1Y0jNc?=
 =?us-ascii?Q?zo8CoFWzFHIbtsFmR/rGQmlujpYH2WD/ZfFLpFVBmvgueK856jmNWSK07WrQ?=
 =?us-ascii?Q?Z+f9f05YxnFXztkps/9fSMWNe5mUj1nVPnJtPVRuLH7dMxwMon8qHP2AoRE1?=
 =?us-ascii?Q?rspkGfNcNMaPqhbbT66J6ryZ+GyypFpMgoARi8q0LMJnLdKOGHpnsmC9ZLZl?=
 =?us-ascii?Q?JmHsI29PpStA+Kmp4rzJjkRWzBRUFx8qTWYmKP/t93leJzTLHWFEcbBpMjMs?=
 =?us-ascii?Q?V+IGfb+CHhRvcilkqpkni+uXf2RkjnQQEZS2lJeL2HFz5mc/ZGWih08acxRw?=
 =?us-ascii?Q?xtIgiLXvSObsalJYs9g6xiH2n9dl8GGY0s3ysy2Ff9X87x6660+j2hOtUM9B?=
 =?us-ascii?Q?wy8GNlZnYKDBk8RTiYQwSMyVQOAlz4vaGr00Lz7UeKmsH1rrQZr8r3p5UHCb?=
 =?us-ascii?Q?2eZZoS9aSrzKh6AVI/9TdDvnQ0xvpapkmKvx1mL7l43trT4a/XjcFkxm1HMV?=
 =?us-ascii?Q?5TTX1eNimpiSLrevswuT8Wu5GxIqBkX6q18ASeSA8+bw4XaQmeZDPz+mU03i?=
 =?us-ascii?Q?AowqlP9nNSdVkQI28pDhAYSSfy1tf/GMtF1CGbZYlN5cdt97ofE9EcWDr0gv?=
 =?us-ascii?Q?nC8iHJ+o7sAP9ZKAll/7D3oZGs3VU8GUNhT/0WHEZI47b5GydDmrgyaQ/pZO?=
 =?us-ascii?Q?u0Epb2eUabNGAthUddLnovgkmwG5Ql/+3uKyFoV+faOxULBMnGLnyrjmK6bO?=
 =?us-ascii?Q?gvtDns/HyJXsH42uvuyLEnoQLV+rS4ZcApJIltdJwZmLU2JhUoilLVqNH2k9?=
 =?us-ascii?Q?Nx8B7Uzc1S7aQpvLchGr02gLCa6T948ZNOb+/wo03nIf/9KfzQRFNzXO1Bhd?=
 =?us-ascii?Q?ipBcIsr8DWCu88xUZ5tNPQwpIh0dtcAKTfcFVFxOJyVsbxZ4pcZF7LTWiJ4L?=
 =?us-ascii?Q?rPErk1jrp5KJEj3PCtlvgwJ9ECC6ZsPx?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a74c1f-6b44-4a2c-7d1b-08df0c825000
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:49:54.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P251MB0978

mhi_mbim_rx() copies datagrams from the NTB using skb_copy_bits() but
never validates that the datagram offset and length from the NDP entry
actually lie within the source skb. If a malicious or buggy modem sends
an NDP entry with dgram_offset + dgram_len > skb->len, skb_copy_bits()
returns -EFAULT and the destination skb is delivered with partially
uninitialized data.

Add a bounds check matching the one in cdc_mbim.c to skip datagrams
that would read past the end of the transfer block.

Fixes: aab8d56c11be ("net: Add Qualcomm MHI MBIM network driver")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index a94998712597..acdcaceebc48 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -315,6 +315,9 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
 			if (!dgram_offset || !dgram_len)
 				break; /* null terminator */
 
+			if (dgram_offset + dgram_len > skb->len)
+				continue;
+
 			skbn = netdev_alloc_skb(link->ndev, dgram_len);
 			if (!skbn)
 				continue;
-- 
2.43.0

