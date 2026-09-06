Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013081.outbound.protection.outlook.com [52.103.51.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAB3CC32D;
	Sun,  6 Sep 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788737881; cv=fail; b=I1jqeufuWnlIibloAGg+NSgnAg+JMAAzM+YSQ1/rLViIHoYfIbqxSP2XVfC7X5gHyq0F5sb8wzd3ee9iC+I1hhwfALTNQKKKhZJIrvj4Ks5mGx7yN/xa5Hev0Xfd3vagicpwt5IrdiAQjLQSg1PQV4mqOhh6johi2sR1vrQBLxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788737881; c=relaxed/simple;
	bh=g05mMN+t0Bq5u0UFdeQQ1dTeXzReIIs5pK9+LVP3MEA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gWkFEjf2PI2YVaxV94XkDowFzdS6RVaV5t5IyzzqsH/looiwBrZgBwLsQ6/H8YHGfUWYAAkLeyDSvfTW3BaIMiy0QMSdZdgS7AKhPCvJKjexf2OnPTrRYeCtgrfgkVsByPz74C1kf7AEgbLOchZ41p79LfMpX86gAIOfjNyI2f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Lisn1CV9; arc=fail smtp.client-ip=52.103.51.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Lisn1CV9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUhv9Ehrw0whh7qGBQbjFKgF4cStSLUmAwg40nkI6lacthj9VID/foXX1MMHMJdDTZOMiTcTdGWII5J3EK0decZ5Zds65JvZCMiIYMFCIfiozhDYegoJNcKoc2JXyvU3nF02uBrtBBDe3ZARadJ6rAOcljpPTXemz7JfXK1AEyhyqgRj+wyMaXcW6o9V3vB1PwIiOSP7KzxQ/CSZPsWAofukRV6+KKocI2bc/zAPTqoVavaEOwia5bxSI65UlYAqj8bdfBGEYD0MWscKPHcHysohz+cbJ8/Qf0FSVTp4TmveJgZgFi2SkDl2R/0hxhUltJXkICbcWxOyV6FSXqgTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewHmUYQpE6+SgA1K6o3F+qHNtBMqyZvLov2O1o27BoQ=;
 b=fnOpnopTkHmSm8aLM+FBs7LiFbSE7Fe8vSXn4dXXc7HfdIxKWlX1FObWyfUSmYQQvRdK/t//HbfQMSP+nh7wNh7XJqXpiPCkpz4VXdybbwpy6n1JZzPubhzZ1+0RnI10tQ4Ds0oeGVxasu5BuQRhsHiho7l282/M2R4Put/jYPAdANHwUxe8v90qhN67yFh8sy+JVNZyrj/JIRCTqlK5MIivDXhsyizacax1hTS58EwDGOBV6EIT/ox59olOtxaiyNTGNoVKvDBNtZiSg9tCJGooMnLyd9S+LRrqT7AHuGv5nQT0abGBgwydjqw68f8WfBbdtnM+YWFZ37k/TEYB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewHmUYQpE6+SgA1K6o3F+qHNtBMqyZvLov2O1o27BoQ=;
 b=Lisn1CV9KQJlKEr+Q2KXewB3fbNJuu/h7jcep0KQs1xMM5v0FIBxT8K2YhRoV1yBO6a8LKhlgZzivEXt+QdFiusbJiWm/VcpZ9KK5kyJ3gCLuGC3/gSdUGrS3lCJYg0CLdrCmuR+BurFkYIuN+r7a8d5HOHeTO2Ows8Q6LEq9RqmpgJkAVR+uSHBsX1NrFVoID2aWPqnCRhymtTiM8QCCkCYqfYsbyai2M7bs5LHDysWZEBL7Y2FqKCY0GUjB0bbBFbxc+8L6v+Pmwmh7jcIAt6cezaAwriqrlfq/x2tTXNqMNaeF2EfASMLApIEPCvAD+yz/STBaX39YxEnuS805w==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PAXP251MB0113.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 23:37:56 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 23:37:56 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] net: ncsi: validate response packet length before accessing fields
Date: Mon,  7 Sep 2026 00:37:51 +0100
Message-ID:
 <AS8P251MB0001E6ABBE0B6809D3E21B9DC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260906233752.87773-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PAXP251MB0113:EE_
X-MS-Office365-Filtering-Correlation-Id: 460d5770-6438-410e-d312-08df0c6fe0a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|5062599005|5072599009|4140399003|15080799012|25010399006|23021999003|25031999004|37011999003|19110799012|8060799015|41001999006|12121999013|440099028|3412199025|26104999009|52005399003|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DfMBznCdzMm++IKv/8zbs0acqzP1oFfrNe7AeJevR3x5lqRdZoJHNs7CyQ0A?=
 =?us-ascii?Q?FqohuZ18IP2vbtpsYRjf/Bg83vVF2ymbMnGffr13G/JdL/W/qDSkkSo4PUUc?=
 =?us-ascii?Q?TtdrPrrBc9nNcV3+SY9gdSt9lUJ1pRnG5ahkaSZbE3KgI7J+avkfa6PPduKF?=
 =?us-ascii?Q?pr9aYwlOym57DMu85G8DUxmhh67kptnnBbvvcRfHQFAjlkF4Z3XD9M/jGI5u?=
 =?us-ascii?Q?RU5vFIynI54e2z34Nc+9amINh7PbWvs2htffiX6cIZ7ktEuBphXlenSoeK8j?=
 =?us-ascii?Q?kPSw6izCjpVSKg7tYnmNmHbODT8nqu5IIoAc1LdYBEWl9xMSGH9zdMMFuBgj?=
 =?us-ascii?Q?f1l2cnRHPCVWaWutTkOqmyJ2yP6o7i0toWAEa8n1UNftBNO9uUYTUE1QdgLm?=
 =?us-ascii?Q?fhM6PbWXVbMEh+LeC/eOcyXBGDho8wGYuPFKamDC5GSx3MFRzFxu2OYtuEcG?=
 =?us-ascii?Q?OasuTB0FH8pSyJ831ofzWtQw3eiG7DjjxedUluhHqxH/nm+u3KkPwTLV2VpK?=
 =?us-ascii?Q?CLdHpGUIY9xZio9jWyLVbl83IG/MqBUHK/yJO4b0FB+36szVGMRg0vqmWS/9?=
 =?us-ascii?Q?GWgCxnmH5qPa1GSOTZIMw3HD6f7ObhUxcaXYNffINy1ql1ElrsvbRY110xDg?=
 =?us-ascii?Q?xIpfOU5BUMd24XOsobr9W8oZ09NozZHGqter+qoqSe+j+3/VQ5pM+89o/DsR?=
 =?us-ascii?Q?+Ylg1g+BpScPHIiaLoXFTPahoL3W1s28Ly9QtC766/EF7ZV4es5BJ264UpA1?=
 =?us-ascii?Q?29daEsEDI6PIYg+PyZhKfUlD6XgKGNeu7koW25IyMZ2MqsFqR5pG7K5on+Bx?=
 =?us-ascii?Q?S8icfrfoQkxbi74wKmShzxe8VcwtNy0PIG6RkTymJpyWaiUy0/B62t//1o1A?=
 =?us-ascii?Q?EaW1NTs9iK91cPIHMSFYWo5cAbCAi7ifv0dlerzx7fzADu//0mMW7KZISmQP?=
 =?us-ascii?Q?E/Ts076DwI/pZQZRgT3+jr4HmCRrV+Y7NtfeUDFk2XE9VNSHKGzZRlciuj9/?=
 =?us-ascii?Q?3O0xeGtjdcEUqvwIV5fCcisVUQhPStGyfiZ4IrrPcMDrzTBQB6mz8w6jnVq2?=
 =?us-ascii?Q?DbBM5E8cFSOpzj/V21jUnpXZm25/vrtyikhGyGWH9ivXRbRgDY3aADH2chrS?=
 =?us-ascii?Q?8QLMeDgyfM85?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qO15ZNpg/vYHbr22VkFwTkutU3twU8r5BvyHIlbsatnOrDIKa3wVeBHzGShJ?=
 =?us-ascii?Q?ytYUE3ot8UjjFlOCS7+5caGl49FzJNCx84gAb1aAcJ5ND113iG0BK4uBYoXy?=
 =?us-ascii?Q?xOv7VNcAkPhXfZAQgSpTcUQwyiev9PALEwBNWmQXbM8Ch9l0dqcf6cI3XCA+?=
 =?us-ascii?Q?HQ42NkrYmO3Nj6aUJm/ZJwJ4zWNQC95EikdS6p1ilChFjE0S2PFXa9yI69bD?=
 =?us-ascii?Q?0SjDec1Nt3bvd5NGsMTyddHWIkLpAGUydkYJrGHjaWixvPOWM5h4ay9xHCVR?=
 =?us-ascii?Q?a2LrUWk3pjwwVMOE2DlbaNJ8Dtiu1OvfZHd/Y9iugCDjbDRCZJZUyYqLXs31?=
 =?us-ascii?Q?obBnFH7+ZcvcPR1P2tLQ2rxHtxveHKRDLbO0NBUuvkl1VNAggbykT5ntOk8I?=
 =?us-ascii?Q?yyg6IDogGBoJjFDm0tIqYABLHmy2CMmp+qqRbGP6KHVCKfvwFTNppPaouLmY?=
 =?us-ascii?Q?oZiTUPUrWasrIGrj/PB3AjzMWrxPC+AE/uFd//1qphVk5FtnTOVuYRw13DdG?=
 =?us-ascii?Q?gvM+4MqYqocGift3twpRGZdQ9Tn907AQHmMzv/Q8wOGT8+txAX4OmFLWlZTO?=
 =?us-ascii?Q?+iXZlpARx7ffiLcZINbaaDmtvMQSkhcaqB50na/7kagOCaMg9CRhbjUh0Sfn?=
 =?us-ascii?Q?y/l7uO/A4Z5J6VBYXyvgO1XsRm5oiIZClAEmqofl3eWOYmSxioaP1oO6VJqE?=
 =?us-ascii?Q?5OvVmmqF3aB4bALdFn+TYrsHWoyVVwAOcCetKHLT4wxzxBLLzTb0/B1nsoDn?=
 =?us-ascii?Q?Eag+NE36syo4IR8HLboKSk8qyrA7k1/DosziIzV4n16CbfRY4IymjLNasEPs?=
 =?us-ascii?Q?Db+IY++gouMYagiGguLStB0mlu1mZCoLGAFal/ykuMjWSYsTieL8bSXY9czk?=
 =?us-ascii?Q?f0l05vKxHl+rB423Yn5Z3rPGyRtsZRSgGjE0HA8PX6wlHYoTcal6L2vGTC1Z?=
 =?us-ascii?Q?v7ojDoAM+C8jc0kKTXIDyLP8/mFGuVH/0egAeyDGq2EUe89ToZtIMA9Oo7sB?=
 =?us-ascii?Q?dclELPIhTdukomsNhZrdQtQRJWp9FKqTfBmog9Qa2RtkMV/fPWRDEX8k1qL0?=
 =?us-ascii?Q?31bTUQPXTPFa3IOJH3vM3EJfe5OhXIAi6Eu3ex1dz/q1V6TVKiuq2rbRdQJn?=
 =?us-ascii?Q?8Cvqazrq34ymK0grlyrTUvabpOCvLoECFzv9xI36XviBf7ecVddrZ4MVW9xv?=
 =?us-ascii?Q?aY0AuzXlbUlyJhR0sGLjbnxcK8bTyrLBLpyU5AXepCJOrtBTmTWX41iOff3j?=
 =?us-ascii?Q?ET6Jdgw00EbqBw3DWOaEp7brko60j+4iX/RA6WNS6nc5Dy1HjscKOSPXAuJM?=
 =?us-ascii?Q?MaSq4x2/74DSBIGBUwjE5NEVZod1YGt154v7O6iRECbVxs/UMmht1eOFaIK2?=
 =?us-ascii?Q?UciaKx3FMUoC8LwLFH7cmXqoYbXfuLvjg8lKGWg/l04/2dV3CVMOgjqKKD25?=
 =?us-ascii?Q?F+NhxOsh/A3diBWpPh+ECwaTCEiZ8Ivi?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 460d5770-6438-410e-d312-08df0c6fe0a8
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 23:37:56.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP251MB0113

ncsi_validate_rsp_pkt() computes a pointer to the checksum field based
on the payload length without first verifying that the skb actually
contains enough data.  For response types whose expected payload is
fixed (e.g., GCPS with 204 bytes), a short frame whose header falsely
claims the expected length passes the "ntohs(h->common.length) !=
payload" check, but the skb may be much smaller, leading to an
out-of-bounds read when dereferencing the checksum pointer.

For response types with variable-length payloads (GP, OEM, PLDM,
GMCMA), the payload value comes directly from ntohs(h->common.length),
so the header check is tautological and provides no protection at all.

Add an skb length check in ncsi_validate_rsp_pkt() to ensure the
packet has at least sizeof(ncsi_rsp_pkt_hdr) + payload bytes before
any field access.

Additionally, validate address_count bounds in the GMCMA response
handler.  The handler iterates over rsp->address_count entries from
the flexible array member without verifying that the packet is large
enough to contain them, leading to a heap out-of-bounds read if
address_count exceeds what the packet actually carries.

Fixes: 0b49507fc090 ("net/ncsi: Resource management")
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
 net/ncsi/ncsi-rsp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index fbd84bc8026a..1401528dbd6c 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -45,6 +45,13 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 	 */
 	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
 
+	/* Ensure the packet is large enough for header + payload */
+	if (nr->rsp->len < sizeof(*h) + payload) {
+		netdev_dbg(nr->ndp->ndev.dev,
+			   "NCSI: packet too short\n");
+		return -EINVAL;
+	}
+
 	if (h->common.revision != NCSI_PKT_REVISION) {
 		netdev_dbg(nr->ndp->ndev.dev,
 			   "NCSI: unsupported header revision\n");
@@ -1097,6 +1104,12 @@ static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
 	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
+	if (nr->rsp->len < sizeof(*rsp) +
+			    rsp->address_count * ETH_ALEN) {
+		netdev_warn(ndev, "NCSI: GMCMA response too short\n");
+		return -EINVAL;
+	}
+
 	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
 		    rsp->address_count);
 	for (i = 0; i < rsp->address_count; i++) {
-- 
2.43.0

