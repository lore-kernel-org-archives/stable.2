Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011079.outbound.protection.outlook.com [52.103.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC331366546;
	Sun,  6 Sep 2026 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737815; cv=fail; b=euvsBAvYC1DzXi6eerZ4dnx+a2kPvuAI7nxsrLD2+tkxWPrkiN3YfWmdnldBS5zc7egx6F0RiR/PlWFcTaMuyJv6+zQ0fSoXJCFhqe02MmOzwWKDnxzuVjGyHZveZmDRt0RyarEyLQD8oTt6E6hlXmmoIIvgqwOGeGAQgIheR20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737815; c=relaxed/simple;
	bh=MB71OVuMGjQshHjwu+wadNSeEAgGzHmtXn0de4vBW4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mOK7AkNT3YR9qh8wZKXIqOw3ugIIcuce+4olmnt1ytYzXd5Ik1CS5VdJvYLyhEu+BA7dEtxX7/pCnvHU4insxwDeLHCOgGhBczoRF7s86Vz7wl3ISY4eN0LGkW5oaq5EW4d+PagWiedkXCx6/YGc4pJ6K3b2bmE4n9uxUTFB8uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=KYQaotyn; arc=fail smtp.client-ip=52.103.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="KYQaotyn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2J2YmanLzkD22iBZgc0Cs9XPU5YF27Kr+S5ITnPzcTTbohcRV+QDCGvq1V/fPROWJVEJzeqT+DbopH8dgYFfQuy+oLoAb4VsO27cYub7AZ/IR4gzFJfDTOiAQ4KRzvCO/s6cu6ruepOfO6FFEnfd+hTs2xjSWIeuYmD5DNyHSQCAwhR+fnXt3iocpyFii3xeoKJZ3UISCooeekJqWWufzAX79EfJSpfvZR9oX18fE0/dqNlTd5TObexS42qhthRWz4dPQurJygUp0DATTvX6F0OPQOmjgIzoKv6PC0WUgKmeU6Gmh3X5ifVBxGipUtXNiTSgimdJ0HpG6ORDu62IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUW3mE7FQss8d0YMaUSUVtvHlQD+QWvh2rUkOLR79o4=;
 b=A+sQLgijMC/rL0MLRMGtN7ugyuxgXKXRo1r49Etxl55VYNhSmnjds4Kjh09Ztp0EhjZyiHiWptdOqiu3HhyRWhrGet7ok67xC8P+WUkne+Z0E/Tq05CwfVZoibOQApsJaSVU+z1oHuOSxD51omaa88qCz1buXeekq1GdaIZmmsDnas0oGieyY32P6Efj/9KY5WX+7OlzupIgHKNSxiRKgdwYvHlE2++B83gSEieNmY7ME29jBsfJl2l/2AntK+WagSb9nN/upztJ+UdTkFaX3+nq+dGUFkZm3Yc21RNlQT3asZJ/Ecj42JCUcu6REZs0Z3VMQPvdXDRoRicjxE+CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUW3mE7FQss8d0YMaUSUVtvHlQD+QWvh2rUkOLR79o4=;
 b=KYQaotyncj8ecWp+LBXg0vLcmthmS1efIdYHGjf79CAxydQpheJ+ZFBHalXx511HozjM0eWiSutDXC29AikMiPRMkCmsfo5Vd5gvXN0DFR+CiQ1AIqcM23bx0ppMb1kOIXSe9RdijMZolGZPiIBfS2EkdgOokqDHs3SAOg4WRT/M5DjuAqdbTw59fzSq19SxiYUHeI7X1htP0dSOQrvsfdEG6uinr8tTA75dYx6Ft+zOeIufFx3WaduQAS80ZzsG9AoIMckkRKqlyAPcCPMmJmqdKbsW3rO9UPvTK3zYuSggWs+Y5iknETm6Xg8+8bgXzcXjuujSSVFAqDnfzdMQdg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:36:51 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:36:51 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: David Heidelberg <david@ixit.cz>
Cc: linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: validate PDU size in nfc_llcp_recv_dm() and nfc_llcp_recv_hdlc()
Date: Mon,  7 Sep 2026 00:36:45 +0100
Message-ID:
 <AS8P251MB0001E8602F36054CDD8979A2C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0133.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::12) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233645.87684-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fabb3a-3812-402a-309e-08df0c6fb9cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|41001999006|12121999013|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtzFOpV9qO7ZcMt6ZfUyZnxOsoebhB4MiJ0UGj1vThXXWYXt4HR6PwcZfeq9?=
 =?us-ascii?Q?GfHWAjFWrmxtmzkkbruDpWHpqgihnef8/XiLhAoo6Ix0wxHZ06N+H3lLE6Kp?=
 =?us-ascii?Q?JSrjzGF/8mfx9fdXrRmzBnV34SvoVSYkKVkqgO9+b144mL/Jcgd+K+9GbYtc?=
 =?us-ascii?Q?Y3OmBfY3Rc4AgN5p9b4VNT2CzW7ifPHY/Lwd36xLEM2veV0+4mEvLwKQ3CXq?=
 =?us-ascii?Q?52zWBQYi5ddj4/jAsX9ero4crPJgspnqy8bUDu6pSo2gcJGZPAqcIsaKBIQa?=
 =?us-ascii?Q?hL651XR+356dz18mEq0oLhhfIeDE9UZO/OmOr9FeVkmhSAT1Vnsd9d8XDh//?=
 =?us-ascii?Q?5VSUSP2RA900BlUwcmCFVb+RpeYjO4y1JeyBspqGTRE/zKu9RaGY/4mUAiuB?=
 =?us-ascii?Q?AfmwSdxbcSRi8/m6NALDPRFt9D/szZehf/MtfG4LVdzEZolFTB0rev0F3R3y?=
 =?us-ascii?Q?rbD2M4EpZ9wyvvDXwugJn1fAsOKfeOJKsuK4Dsg5uyhviKkwzcW6LCIIeRIz?=
 =?us-ascii?Q?j6akh7YPfb1CGhtVKyuMR0DOv6XmaC2khp02G0jgv94hm4/Bx4OZsSr20TgX?=
 =?us-ascii?Q?FxVaT2pSGSScetSXS9CYvNvzx+6tZvD2VSteCdRKIzxFY5lRO1TfXEM65JDI?=
 =?us-ascii?Q?2ZNhuvIH3SrNZY/4VPmR63dbV3qHcLlppszOb63ffWTNe0Gz3AdFOVG+hM//?=
 =?us-ascii?Q?/tcZAXJquxoPNS0jz8Y0yE1A4k6JX4K8Z6Ox+UfWV1Pbx97omkWdDac/697w?=
 =?us-ascii?Q?vci3rHuQvGersep0nmkISh0XPyCAkAIMiLvGj0LPghq1d/VyRlXiXxgFw7t6?=
 =?us-ascii?Q?23zw4Yvutet1JcgiIOjbcR+MghrE2ZQk5UJpzerVnQi6aTZHqNt6Zl6CRc20?=
 =?us-ascii?Q?dbEsWs5WPxozXVcuY+kr8qVp9JMpGVH4N/dETKI6QAZiszFp5T8NTujbCVcr?=
 =?us-ascii?Q?NTnJDZLe92fFplKictRhIYqUWv1wepKS9sGFdonLi/7uhC9Px3h0HlWu7Vmu?=
 =?us-ascii?Q?x4AOQuT0qv2lclcKV6qedJ/eexL10Zps0LwWmhW5IUx1X1sOQx2UtIeqeMVm?=
 =?us-ascii?Q?gj932r10eervMg2i4EQu/xOr+Sm5ZjCn8hu0EfD7DG1y/0rDhtM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V77keHK5aqTMUlq/vFRfO7hwqqURoH8vLGs9hbX4TxsCqm6V81wR3b/bFTEW?=
 =?us-ascii?Q?lZhRa9oOlCwckTLGev1KcuAx5zAOrzonhxue2+rK2H3atPWYHYAmYlEoOHxT?=
 =?us-ascii?Q?VrjSHO5im26aPFn5GRPHwJuxs5Hu6wmstdbePT2Ks7WWP7X74F+iurbP3GTF?=
 =?us-ascii?Q?EnFI8ibhnDQunSrVSIyKZLrYrfJf/8nJhuwEXBezmnu7n5JmT5SSUx3EL4Ug?=
 =?us-ascii?Q?W1zQa0ukDp/pDSBZN2/fkvP+0tukf5yANyvShSlowoOpGTtTnpV4BWjNz3rY?=
 =?us-ascii?Q?aaNjPx4Ry1o291oyVNmJHFc3i3i76VU3iY4Eg0ddSKM2t8FG2hNnBtiITDAl?=
 =?us-ascii?Q?6foyx/PhQSPa8YVjEYCSsteRXQsA3DuiQ6uqhoHzO0ONAiepcvtI8FmejqG/?=
 =?us-ascii?Q?pTTKMGCAWaBBzVQzJTlGJeJ9YEW0bIzs1ohdxjU8OvLw1Wqxsg+PisNMn5BK?=
 =?us-ascii?Q?wz20I/nbArFYQGWB3VBHdrNSAR2txcMzXHjaNi/qccyA3mTPg/OgAEoflNlT?=
 =?us-ascii?Q?cDtzILyGhaFIoQH5AbVQPw3LKELIX7MPt0CQdPpNBoeaydXGwGnFN5ZW9PyF?=
 =?us-ascii?Q?57Ft8R3IZw2b2KO4vqSylWWojoISAhR5q9CYiYzyKkE/qa3F3OKk80wq/2U8?=
 =?us-ascii?Q?DQ64ySci5qMPiaFH5ZP8i/1EwF2tMlPjIU426QgYnFjw/xJ/KgFCA2DQGkWO?=
 =?us-ascii?Q?ZkzxDs8HpDHAAEH1Aubi0pKiBdIAwDIpoHxaY5338vwP7en9/itBZlUE2vmg?=
 =?us-ascii?Q?qSNDpsZY2RJSxVJPkJvRqoY6bDkChxc4kM6MaH2Lv/2eKHUZNW0M879bH9gS?=
 =?us-ascii?Q?8LKMwdMPBWoMViSWXa7WHgCSXpt6worRGh9LrSIPYaqxRHCYrOw24n+HFV20?=
 =?us-ascii?Q?7x0sEGWHjNCzaGa+diGUA63bHRkPwE91RERYK+9rEmZ+o5Qbcr1kmKtlp/cm?=
 =?us-ascii?Q?VctXH/P7XQspJp6QiAb7UneiLMUSjq5j1UxIhHsDgkKYch/sQ1qOK7b9HRcN?=
 =?us-ascii?Q?zqnaW0LU/t/tSPSsK+QVFbYkGJMSPUoYcVjuU2f04MUlmDQU/lANIRdDf+Su?=
 =?us-ascii?Q?a7fqhdWXQmDBBuhTD1xKF8EC+SRmxUZClPRQw9a9nC/kMF3xoRiJYygH7ZoM?=
 =?us-ascii?Q?tbrLnZQHPssyIBxsqMCSLJOXp0g6JCpHs+bycxQxYdZfQJNFsip+ElOqXVl1?=
 =?us-ascii?Q?r4Geq9gh//8sLROng20nSrFDNBr8N9eUqiJv/PH5CXcb7OtQ4M7GSO/k31vG?=
 =?us-ascii?Q?TW42HUggHZOd4BP4O/yKrsSrBpcxoe2EHu4qpIxo1RgUnSGKXtIcG1CQfyTB?=
 =?us-ascii?Q?IbXI6jfTcCn+8dNkDzLVmIT4Ifu8md9M6bE1ElyewC2glaq/J8LERjiOX6dJ?=
 =?us-ascii?Q?jSkhjkSZj2N82liijbMzxhY4kCzn9ShVhuAaRE7TDNeEL1eh7v4VtueH2m14?=
 =?us-ascii?Q?wD1Iqqv4RuAoMS+TH/y3moe9DDipkL4E?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fabb3a-3812-402a-309e-08df0c6fb9cd
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:36:51.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

nfc_llcp_recv_dm() reads the reason byte at skb->data[2], and
nfc_llcp_recv_hdlc() reads the sequence byte at the same offset
through nfc_llcp_ns() and nfc_llcp_nr().  Both run after
__nfc_llcp_recv(), which only guarantees LLCP_HEADER_SIZE (2) bytes
via pskb_may_pull().

A malformed PDU that is exactly two bytes long -- delivered directly by
the NFC controller, or as an aggregated PDU inside an AGF frame whose
inner length field is 2 -- causes both handlers to read one byte past
the guaranteed data.  In the direct case the byte is whatever follows
the valid payload in the skb buffer.  In the AGF case the inner skb is
allocated by nfc_alloc_recv_skb() with exactly two bytes of payload, so
the read is past the meaningful data and into whatever the slab
allocator left there.

For DM, the stale reason byte selects between NOBOUND/REJ and the
default socket-lookup path, potentially closing the wrong socket.  For
HDLC, the stale sequence byte corrupts N(S)/N(R) tracking: a bogus
N(R) drains the tx_pending_queue unconditionally, dropping in-flight I
frames and breaking the connection.

Add a minimum-length check to each handler: DM requires
LLCP_HEADER_SIZE + 1 (the reason byte) and HDLC requires
LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/nfc/llcp_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index cac1b5487064..89d6f4599e11 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1077,6 +1077,12 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
+
+	if (skb->len < LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE) {
+		nfc_llcp_send_dm(local, dsap, ssap, LLCP_DM_NOCONN);
+		return;
+	}
+
 	ns = nfc_llcp_ns(skb);
 	nr = nfc_llcp_nr(skb);
 
@@ -1254,6 +1260,10 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
+
+	if (skb->len < LLCP_HEADER_SIZE + 1)
+		return;
+
 	reason = skb->data[2];
 
 	pr_debug("%d %d reason %d\n", ssap, dsap, reason);
-- 
2.43.0

