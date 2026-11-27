Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745157;
	b=zmHYo31CRldu6C5RRKocWxKcxnNZo/Y3SeuDXTjY1wAiu5KDG+MWr19xYOWtVyfYBPZD
	 Gq5mCOxUJbzRN9Bbtw5QsthLU9pu2Llrjibp88zzConzLDegD3C4D7mB37WYr/A6z33qx
	 ARRvNsNRuNUW36m3jhIDFdXTIDpe61pVKMyYyoQmhXpTKO5hWYCiKH3eNi3thh0zZS9zk
	 1J+xepSHtp0BKVXH3Q9IMftzY8Ge5bIjdwNMT2+rslZmsqkRLZ+xsfs8qB/S88hAcBnti
	 /HRq6RCV2hAg6tjLg4GrAOSDpPYQkE4qipkjNpZERtLsFNcav2Rcc1rX9pmwpXlLnfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745157;
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
	bh=EihGuRJmwRVa69XGm+J7eD+yGhX4RPvmgn0oGlC1zXo=;
	b=TWhSkRy0b8vPN+4Lyxg4r44FqzPDmmtvCfGyLeCTDFVbIvbYYWDzEb0Q2DXoLaGZQoVZ
	 h1i22w+vbsuPFtnbiaB/cxh+F2ESqdBqRfW5UdzL1MRFfJxrGFrALVIGIqfQ57JORMvmt
	 fJiGcWHGZCCJczUZ/RGuPK0GJLj8arc42S6fpwhjqPCtzQyq6QdyjONhYNujb8jVEnP3D
	 p8/0BjUYodV7T/75xZ0mOuCbB9akTZpI+/ASgHxR9l3wC1036FDabeBXWlnfk5PI7I0dT
	 udTa3Tj4KfL0KrtbTJysZS8lE1yeTt+r+T239uagjkiYLrE3N82al24HDKpw+4dGZcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=JvWsdwnu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1C606A33D;
	Fri, 27 Nov 2026 02:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A1C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=JvWsdwnu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smKoSyIa27fEYsyx9OFVg70Px4hoeK0DBSzmog8oT862PjW6e9FLHZ/M+w9Cfi/dGx1iHgRa4iBpfOj+RSdYJKCE4/pI5zZ1it2jeFikcTeZClRqFqjAv/gBoLvNI8cbHJwK1blyTGi3XXgkZ2RSQMYG7Jq3+tttYVURhLoprDLjCt1rL4vn9HqWkleUDpschtR/UOTuYANQAZTOSDv61v373DiWkBPyU1tm5wvHJGKWNOKb48t3hIeMzWBuIN5v8qk1K0xHKZVDLU5jvD5UFnyZag1r3qdvMfDb7v2sg7rwNuB+y4iBbkD+jrHo2SKqwHSFpJKfb9+U4cgCMlpeFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EihGuRJmwRVa69XGm+J7eD+yGhX4RPvmgn0oGlC1zXo=;
 b=yiaYwjV3aWRMrf7RfkrMuzkJssHMMoD3napNTRz7wGqg/F3ZjYYs17Lh/cnF5KXR+DMZQqqs7yI4h8G7WtQxPBR8PHsJ/PCpMZmjq9tDNha0gJCUvRzHcCfVdBKJJu51wxe284dBYh6LpzzIvw5qBXjrjtdOpUC1RuvWD1OMaIGSwwWECfDB71DIWROEXyQe1P9FjqIMjRoGQS5ppFJL+vb7XKUSgEYn/qXmHe3l7zFvGNdphLArXa2a0CHoKlJDNnE2SFICYN5q9mL2tedkPPZtRGlaJeiWILMWZo3kHVR57BdnOUWYi0uqqgnMQUT9ne6QYM2gopDgNIpC2O+MfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EihGuRJmwRVa69XGm+J7eD+yGhX4RPvmgn0oGlC1zXo=;
 b=JvWsdwnuCinLI6Q2ldYVrrqepDyMFFFki9cu/5fM4hAPRsofUqFw9O4oT6yPjxaZRFLv4T+4jspt2l6YZizjZ6NsYmjkNoe4k0wTiiB4/pZJBuBfPDHJVuydR2vRsm8DYaTso901jsguxOTOxerECHteL8mpCTLrAk95hXAwo9w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 07/15] NTB: ntb_transport: Clear link state before QP cleanup
Date: Fri, 27 Nov 2026 11:05:25 +0900
Message-ID: <20261127020533.2481725-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: ee52fbe5-f889-4d94-dd02-08df4c2af7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026135527099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MN0bx6YXCB28vzyP5OM6ANcgxxGR1jmtZSVQXMaYh0cbyQ0oMcF3Cvm7Xd4rvfmKqlY4wE9peQvIk4aYs8BkHbXeVqpntLX0/VszTGFVsPqtbwFV19ML8VVV2HJtR/5zPUXN+6siI0DNGA5KvLPhIV3Hq3DEANJ5hXjWVVipJBEL9cFXqEdwF0n4zrDaUOB8+W2FSs6U/3BTle20Hd9k4CscHDUEXi189DtkdMZVVTurQO7i5/YKBtwg2/VLjxiOut50sTYS4OnyFSVbSjgtHNjj4qPmiym23QrXjk7XdS/4mOTnXu17XuqwwgqX0pxu266VQmXLPr2x5g9ZSfH//E0HRPnLEo+eYdpp0Tb3n+ckftZr/mMmoKj4JtGTQ8OtwaDlPFyaZpel0j60TrvWs61GTLJxgfU/r/PSyAghYApDBQw8utfXo+9OrM119tPKmYBpcKz+FZtGTdBsP8jYQ++htpqXrmxbcnUMVDhVxwMyJrC71vFOce8s2M+gW0u9OPZREyYjfdnUI772X+wn4Naa1JH9TVhp+dotRGagJi/R0P8L1UlwAEb1bGNPpaUX/X61BDabbcgDptEvQchAAtj3Q55Iivwdae9nbUxiGXfaprf6y276KKEIKZOsfNC2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1X55bTK427LMq+RyWLZwX13VGvt+lgSARGZCyjcqDuoDsC5EHFPBe0b5IEGK?=
 =?us-ascii?Q?hp/EVgZupzSk725fuHNhLTtGq306hJ5TR/kbxxSTMg+0j7HSmYpHuPDu3KpU?=
 =?us-ascii?Q?ApIiZACw6I132aVseXAMgeRvD77uDUsZQhMvck7AYb7Ik7feK07sbitViT6M?=
 =?us-ascii?Q?2QHePDrpKZzNOrvWquXnoynsUFMaKxSKZBsjvNR5f8HGhhAQzTW1Nya5YkNN?=
 =?us-ascii?Q?fAralG7BBJduzSqDh/oKeFNtpxuImVmBuHem5HcjKKRm1nh8Xt2PisydRDtO?=
 =?us-ascii?Q?bh10R0MQnqyjfv7vxncI1ZuUeoovw6ROpaAOYtcoN/eP0qp07MEih1zoeOon?=
 =?us-ascii?Q?bkHxtYGCRRgOwMI/tlSm0ONi0UhxY7b9MjXu8RBy933uPE2FWz70pf81+488?=
 =?us-ascii?Q?vN23+57dH8hoaAkWPAYX8jgjrCol100U0S8YhQvNGbtqBgLTePxggjDgnpFE?=
 =?us-ascii?Q?unpCSVItZ3jQr/s+i3TaTmpzGAhM3ynXOm+DX08uaIpFZD+KXrjOoQLJ9TNa?=
 =?us-ascii?Q?RA4iDJgccUwlbh6Po8BuRHEddgodW3Iuf+/nbUpQodciseTA+WcBVXKz15f3?=
 =?us-ascii?Q?7/8GjpTN66b1rrM39qKHOhFWd4zAjFHEV9sc/+dxWMHNXJAaLBbaXhR/DksO?=
 =?us-ascii?Q?Mnu7W0kJHZra/aq6rlwfkQbS6G/8U30Of8xcYZznRmQxE5A8/LZqAn2tyPeQ?=
 =?us-ascii?Q?45rYkA393FQj+Nu1oxNnD82qYgPYGRFeUmNi/On56Y3Mvsi4IOxddbbLUIXh?=
 =?us-ascii?Q?GvRuA2bNbRDv27Rvt504l9fOlip2tA120yelTS/B1OShF/VLqsKBRmMz+Z0j?=
 =?us-ascii?Q?C/Ss0oN952zXG1gk26/3yGmBeHhxHSk/Evn9zgBbgxfiVYeY94DmTFZ5wNrN?=
 =?us-ascii?Q?dju9H/ryNGM7fRgvrMZO6G0xibHgcs+tATg4+ZHATcDl/Cka9+vowxIi9LIZ?=
 =?us-ascii?Q?z23DzSXslYxTFvP/eVDdFIMC4FtxVZe4m8b5nnRc5M85M0hgLBlVApQhmnFk?=
 =?us-ascii?Q?0nrz3l8VpRES0Om2wFxhART9ywXlzhJVHmEElrng2/nrGC87bxwLjWkqDOZk?=
 =?us-ascii?Q?/27G7QzSHXyv1hhlUNxTtS1DW8IoWSzvbeEgB0UOUMum9QxZR/falogToDGQ?=
 =?us-ascii?Q?evYLb84Y5jmCoCQhIlT9LGqwulzwzy4XAhB+yrjnDOH4iHlTc7RdjPevjCYb?=
 =?us-ascii?Q?fG4wQeaPyyJRJPnUHTy5MWHHcxLPINDwEYFpmqpa70w2c4XEI2TUL67wDVfD?=
 =?us-ascii?Q?esBMj8V/zIrONRGWwx7RMfRrNGCOkJk7ClLb0NPNDt1qJThfuYOEdgnE2CUd?=
 =?us-ascii?Q?nMr9R8wdIwWJlO9b9fYfbA8AZ+Uqe9AflgBLYew2OTcobY1RKXLyXq0kJ8YF?=
 =?us-ascii?Q?5z0AJuCxx53PacioKVwPhkiDwYo7WxFrmx6GoHQoRdVUm4PBtB3n3jZmP+jM?=
 =?us-ascii?Q?A1J2y4VIzt1d+neH76NioHVDyU9Lgl6dUK4o33Sl2B98RM/1YOC35LqcYCqL?=
 =?us-ascii?Q?sv9b+Ov6wDZ8RwlDzff4KvXe4eEHIVKopwWFSca7UDuFq4pQlNScHWAkDlbR?=
 =?us-ascii?Q?aJv5Fzss4d+z0D2cCClnI0t8pDJXfSsLS1a4MNXKVGOAkdl0NZV98F2WVi8F?=
 =?us-ascii?Q?Ha+mz317JmClacZ+l3HtIBKGXgLJiwUeW6nw10jOOyr0b87eSJKKoJL8MjS/?=
 =?us-ascii?Q?x5Rpp1sgEoSE9ZxpIQLMkWmAlrk8Tt+huaoWFZOimVu9meWJXcVDIxzZVikE?=
 =?us-ascii?Q?TfvtnJ1xJ+6TeCZW7qjv0jDvzMJHAvEPBP4hIXEVOBy39HnY4vVj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ee52fbe5-f889-4d94-dd02-08df4c2af7a4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:53.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BKSKw+jOjGXV46581ENZ8fC0PeY+r8jp2ZUNK9L9CRudXnVMDAzF4LSb5gKqi44rBEssuo40HE4ZJTbBd/DoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

Cleanup leaves the transport link marked up after releasing its MWs.
A subsequent client link-up request can therefore start QP link work
before the transport has been set up again.

Clear link_is_up before cancelling QP work and releasing the MWs.
Have QP link work return if the transport went down after it was
queued.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

v3: https://lore.kernel.org/r/20260928152550.3354675-8-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 5e9418422b3f..9c3521df19af 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -974,6 +974,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 
 	guard(mutex)(&nt->link_event_lock);
 
+	atomic_set(&nt->link_is_up, false);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -1140,7 +1142,9 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!atomic_read(&nt->link_is_up));
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (!atomic_read_acquire(&nt->link_is_up))
+		return;
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-- 
2.54.0

