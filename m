Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011029.outbound.protection.outlook.com [52.103.33.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB814119E0;
	Mon,  7 Sep 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766327; cv=fail; b=Pt5ZbJX/D29NHDr6JGQ16EBmkFP+Y2YV7+9E9EmDlak9itZF1U82Y9PnT1NgS9HuWKBsOAgX0LpHv1vcAuI2Kop9QxuUlqZoafRishd+n0XwTrzz/weZHttaCFBAcX/KsGD+bjOp9kp6NfpiHUqrd/XiKJMTHSQzrHFDO7H0Nw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766327; c=relaxed/simple;
	bh=A4nl/Z1I+z0iQPVyv0OqQdJfaoq05auVt+gJA08b8XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F6vDY416XYarw9Y5o6zLpaEeYw6OOlRwgj4FleqDvl+TabcYdnDibEcP95NBRG19J4qlE+j/QPK7N9UTOM90ud1hIzETuCBdhBjuB70j2CmDc3VX8LxdA832UW/TokqZeHi7EbVSlIKII67kLlS2cFe3jkRxmZO7mpMj45v5oF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=oSr/ppC5; arc=fail smtp.client-ip=52.103.33.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="oSr/ppC5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0M8aFnIr/6ximKPyJwe5kB5MIHSCVXlq0a7QDK0ZZXKgQiuMkGd0pgwntNqAhd7nWmldgjCidFEr+Wj1we2vH14JH8FJbECkeu7A5Jo3PbSgLDHnzrcKZHgF43govabYKCwdNCTlCzFBN4547kUvO58/NwZZK7UFIBrLF6vN2ekhbG6ifTsNE+IVlZmdwT02AHrMZRSW5KynYGYHqJ1ZIV9924ooFWNYGp6PVCSYxxL6u+NmHzujSUlSfuCnZBWVyjNZOxbedUsGqFVhVf0gBIefiEIkNJzFSVPeqZjqBR3Chyo/5qcpN2uI0dSTOe+oga3G8J/8wVTzFYSKikNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT3cWyQlPwtegoE1wY7GcaoDzle3aMBnFzXJY1/Fw2Y=;
 b=D/0dcDGR4APU5S8lXYw6eDBvx4clUoxXNqnYEQn6DdIe8jLn+yHshSyxdozAJpIdIKFhUkcwL2n+whLAm1zBc9IjesrSroHOQxUup/SEFuC6C91+OkUYjcZOEVqlCWncIy3v/n47Ctg+q0+hdT/k47MUPPt5v5foknp1QjPd6pfWDb/AUrdqLwVGMIagXoyBmsNPwoombbaK7gKvl9m+GBsCTWgrARwkS0uMpZeYYtW6W+zfkH+6FMNk/ZP/TgsZ7OowF8FhJyKLUgxV5bSQ4BoezHS6ZUzk6BIVGsMIghe6DZJJVjc3FBCYl38l7Mc4kNadcrgrzW6aaY9M2OAeow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT3cWyQlPwtegoE1wY7GcaoDzle3aMBnFzXJY1/Fw2Y=;
 b=oSr/ppC5NX2zBKbsIWfXytjhrge+b/+neQY+KWIDaJ0/01LWf0UD7E3cHxKdsvDi4s3faBeFy0NhaBzfQDJuLtOsU/Cnd1nHIPEFbkZQevTnCMZjQE5+dUMM7dbfauC5gq1CQSDvFsGL3XkS4fBJZdq9WCI00lc4PB6/Al1dyQF7QkY18sS0NS4nsvS6ZO/W56hq3LDXYZpHOUWDOQG1NLwS1MQ5XAa1K1Vfe2keODn+YGzYQbrTvhSIenn/h1FzeKpUBRyGW4SpgYEtJftV4gP/WFu+7rN9xVRvd0a/p5V7C7T5PD0LWYLLGQzQijKgBuQxx6QinTvVjslKDPhciQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by AS8P251MB0136.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 7 Sep
 2026 07:31:59 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 07:31:59 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Xiang Mei <xmei5@asu.edu>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: net1080: fix out-of-bounds access in rx_fixup()
Date: Mon,  7 Sep 2026 07:31:55 +0000
Message-ID:
 <AS8P251MB0001E8B611B22B19AA882542C8B22@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0629.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::10) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260907073155.590713-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|AS8P251MB0136:EE_
X-MS-Office365-Filtering-Correlation-Id: a31f6aa1-3c2b-4167-9518-08df0cb2197c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|51005399006|2604032031799003|23021999003|5062599005|5072599009|15080799012|37011999003|25031999004|41001999006|12121999013|8060799015|19110799012|25010399006|4140399003|40105399003|2607281247196008|3412199025|440099028|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XT/O8JcV19omB/xUpp2sU+YIC7QKSr9tcGFw9a/6j9vrQU0QILxEqHXe0TLb?=
 =?us-ascii?Q?2ia2GQqnFSSBb3lPAi676xTvmTJiwzWtKo4qaLfDeQzXFX/dOTVPY+EaT6kv?=
 =?us-ascii?Q?hwATkV5mue6aVevaJDRyBMjVsucKDwogCzKYOFlRRSEUVxI7RuRDiqKHoMh3?=
 =?us-ascii?Q?I9cIzE2PW0cGBg5tWsorZGMWzgsG1yMMoprJnVeYVytQ86XiaQSsxx6Zg2Ct?=
 =?us-ascii?Q?F87zQvYXb59+yRWQbP9F5RW7okPf6UkX2b86k8xbtLmIALoM9UBD4LQwOXQV?=
 =?us-ascii?Q?UiBiXzUnUSDJgLNW+zekmFQBZ6BnOzsg8UpKokbz4Ka/rNOyg+OBVFeW4xhY?=
 =?us-ascii?Q?2RJr55Ub+HHziq/UV2r3rNLNyeXnYAP52HGdAPAvOplUPl5XmSDzLBfRijG0?=
 =?us-ascii?Q?vG4cp+cAIhzidBqKYdzKmbpW6JdBYj6wthv2ABqUPcw/dKzCYmHY8QD6ZcPK?=
 =?us-ascii?Q?V5uZmaJhXCriPsl2hmSdrl9YyAyN33Y6BwZ3c+62FfGlyLP/3jVLsSyHTR25?=
 =?us-ascii?Q?iQP0+Cu4rnFbxcNlxvUaWWpMhkljmMIwCXSG2el/ch4acxLl3p0cn8mjwn1l?=
 =?us-ascii?Q?zd6hBy5HH2WMkhfGQZLZ5O8Ttd5S+kAaF87/WlT4DOdSQxbsdpZGTfFjrQJN?=
 =?us-ascii?Q?UofP49QUu/Hqrc6Hvs3Uo0wuA3TdgccuCR9TkZHhZ/w3F41YubZFO78Ac2PR?=
 =?us-ascii?Q?Z/3YLUclwuUJ2sJE+/U+hCm9iijXCG+6QmgCx80wkyevfC2ARuRzJcEwl5vR?=
 =?us-ascii?Q?8B20IiU39qKCrPfUQtWbF76CvY08LfjcYud6m0hUgYuukdxY9JMITmCz3tC2?=
 =?us-ascii?Q?AkGpKhO/t4ePe0+UiOMOZyUKSrduptYw78GpZk6JKCWXg8Vo0oetPd8zFpfO?=
 =?us-ascii?Q?MscFBs8KyqIa0UHi3PKdBbiplIsJDNicPKQawh15fUpFudx5oLc3TCk5XqZF?=
 =?us-ascii?Q?NmdJK8fIyy3JoHh7wdUO/pyihuGSWBo8XyDP/3vPf7YufY3/GOM9cH5f8Aoh?=
 =?us-ascii?Q?wqlgkRQNYCHWnZEd99jcmiuk5Zc6DHvzo1AgoaBF2KlWSJe6TDuRDL54fMGd?=
 =?us-ascii?Q?ks2XoR+2g3+QH+7tO+PWLSUPr24a1wMhCPm1nzCut8bc0UKjquRXt5337WqA?=
 =?us-ascii?Q?JZhF/kgENKwUEMcBz2B2mWoQH5TJPWhGjCH5H4bUCSUVqTAAeP0jb0XKnZ40?=
 =?us-ascii?Q?8rf0eK97/TZJE16P?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j/sHex4d16Umvkbjg7A3FZQfPH//c8fcuuz6NDJycQj2Ru5IoBl/ZxtILAIi?=
 =?us-ascii?Q?QI5eUYkWX2gyLE2Aiwu1emNQHQ2hsmDXuBDgnRvdwKsLeR/RvvwpsyOPlpjC?=
 =?us-ascii?Q?TMqGonhh3WKGuETEzWZCxuKwiETvD27SQUevSwWAP1qoKkLKMdT5aXDat0hx?=
 =?us-ascii?Q?q9TjWTc8GqvY1GvN6uMplOAJc7Vsm0E8tm5wZ3rwy/pvNJF2t7GzmZw0nI7j?=
 =?us-ascii?Q?vx5ZVqbhlmciQdOfeebQE1XhsSE49G3U44VrhkHstLN7WVgIq5A8oHIN8PKw?=
 =?us-ascii?Q?qW5SBKbByWQgHoq1ZZlyCb5XozreG8M6/8wU7nL/A7tOJ7f1IWNuNQ4S5R7h?=
 =?us-ascii?Q?ivtjbN0qkhREoL+o85qLTzwhWxNeHpkgCbNFUjkuqWa+7hr3/c4FkYzdNmNK?=
 =?us-ascii?Q?Vn5bgUup0FwFi+VbtsCKFqkZmJbsHZoAeu/wPNecq0drXFipdvOfJ5I0oj0P?=
 =?us-ascii?Q?OXvIfn3c8U/xsx5FnMmc3QoUF3+QyasrCJygTJqP5WcwUZCBX8+RsJhBTkyl?=
 =?us-ascii?Q?Wr/t2E0qHv2Rsiiy9SZ6E2Nj3fu4g71Y5l4ZTCk1yMO3gLVgHTOlDh7yzhfG?=
 =?us-ascii?Q?ZLRjL0XmcNNEoVEWimPoy0ipqnH4k3X/kr5vyw+Q3iIvKHXfMalp/HSEics5?=
 =?us-ascii?Q?S1feyWtQsV0c5mtw8P0VLkI6Qur5z0NQh+HBiB3LodsRRg8EWqph3UheWCKm?=
 =?us-ascii?Q?TXSFIPgSeFjFHTG3BWGKwGfdwGq+ds23ta6J/P8z2rRWW7VT5yx/5yCFMw11?=
 =?us-ascii?Q?k78omzeyondAy/QDMhR/o7yqCSwtjeBCRV7bTgJO3AyVi/KXVtMjKbjKhwwO?=
 =?us-ascii?Q?V18rfKgmKQ5ouMannn2iM5oRCvVnvKPjERR8pRuB5pK8OrZ7lxxwJL9obMVw?=
 =?us-ascii?Q?TzdSnO1i1fKVkDHJ5gTbpT+VXrThoZ8GhA3IMe3Pis+kW6GjFFl/jlgKZfBJ?=
 =?us-ascii?Q?ea28TIx7o9ouH1/z+E3vhgv0IGPLJYaGhxyW8rSX3FROJNYioeG8W47AIXb7?=
 =?us-ascii?Q?4k624JXcHsTHLBlTs8D86DEE//7iGh7iq6btSlG8t7gSjmDSJ5R4zD24UMBe?=
 =?us-ascii?Q?Q5Mamw8qDtxglGQ+KvsrctJKlPoPl79AP1kCDVjxcAFl3XkphvxUNHPdffYN?=
 =?us-ascii?Q?tvr7/JDKLUT+r4F6bjzyNnrKQNCMyITpb7hApoXbC/aGevtmVZBQWNEvPoaR?=
 =?us-ascii?Q?6tQpVbf043T9ZOkS7xCZXdglM6Oj3+dpVp+pv0OCLeZNLaCFo5OgQvSiVYPj?=
 =?us-ascii?Q?iyb8TSTxFYKBNN1nEcZNc6JsJd+OVd6gMKqugfTRlS1r0II/fAvo6vqnBUHT?=
 =?us-ascii?Q?kEYN0w6M9PNbw5DVOGmUyOb+qBhB2v8V2GzzCAFcqtQqCC/cMC3EbkRBdv+B?=
 =?us-ascii?Q?dSwXf/3G7aOvZM+6tj1r/xEizMghQshuYGpE/TTbjM51bIaXa1B90laQm830?=
 =?us-ascii?Q?RpKnOBaphL5pmvyJ4PpB9EFBUNtFwuVM?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f6aa1-3c2b-4167-9518-08df0cb2197c
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 07:31:59.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P251MB0136

net1080_rx_fixup() reads hdr_len from the USB device and uses it to
strip the header with skb_pull(). It then calculates the trailer
pointer as:

  trailer = (struct nc_trailer *)(skb->data + skb->len - sizeof *trailer);

If hdr_len is close to skb->len (e.g. skb->len - 1), the pull leaves
fewer bytes than sizeof(nc_trailer) = 2, and the pointer arithmetic
underflows, pointing before skb->data. The subsequent read of
trailer->packet_id accesses memory outside the skb buffer.

A malicious USB device can craft a frame with hdr_len >= MIN_HEADER (6)
but large enough to leave insufficient room for the trailer after the
header is stripped.

Add a check that the frame is long enough to contain both the header
and trailer before pulling.

Fixes: 904813cd8a0b3 ("[PATCH] USB: usbnet (4/9) module for net1080 cables")
Cc: stable@vger.kernel.org
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
Assisted-by: Claude (Anthropic)
---
 drivers/net/usb/net1080.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/net1080.c b/drivers/net/usb/net1080.c
index 19f6e1222d931..64477a4caa07b 100644
--- a/drivers/net/usb/net1080.c
+++ b/drivers/net/usb/net1080.c
@@ -374,6 +374,13 @@ static int net1080_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		nc_ensure_sync(dev);
 		// switch (vendor/product ids) { ... }
 	}
+	if (hdr_len + sizeof(*trailer) > skb->len) {
+		dev->net->stats.rx_frame_errors++;
+		netdev_dbg(dev->net, "header too long for frame, %d\n",
+			   hdr_len);
+		nc_ensure_sync(dev);
+		return 0;
+	}
 	skb_pull(skb, hdr_len);
 
 	trailer = (struct nc_trailer *)
-- 
2.43.0

