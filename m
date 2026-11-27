Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745154;
	b=POiuUXCN7Jbus+zRWuZ+dlVoZlT4b/nC6iQwR2BS7jr+rGr7q9eXZwdHLMvQ9UBHpDzf
	 naVs3/DzlRQ7jMcuoZUpTzZBtWN1x5XCxfa/7cn6lbuPBOsgF3sdePSlqSysOZpnlp11V
	 y79EW6ZuVKPiJ3n15w32zvAmur4GvQlCRUyGZFit/UnX9nUxWAtLh/XoXSF63IS8gUNXP
	 73LtaFiuMoHef2HB0WmsYPcOEpSHfyDH/8KpwVCDd2uy4y28LKBWKAt02Ll8mUosZkq00
	 JSHcbUZUwu93unYyL5iQ4Gk+Rj7FMCzAYJ05X7oJ3tigYNP96Bu3xIgV6yzk9GohYsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745154;
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
	bh=hFnuR4cwFoy+sqkHyHHAttRq+ADEvpSyhL16ShZEGyI=;
	b=ocuhkCQ+CB95lUs6mRXP91TtUoVBnDxAv1qWLxNbT7DeBM9hqqzZ8+gKi8kG8ssyBMdY
	 LarIc1hRnWfT+FXnqM+DAOTbhmR+Dnclm7E2GFINQUlErMPXHym8+gjDtEGw8efjF/0UL
	 SxvDpD1x0acKBF8/QeQFLSyop/nQlsOxdeYGQjOXCVcIRQJzno9spKvinQ5sDYHfbaC+2
	 Gpz/8K8/1BXAw0MYXYNq+EKnVtqqjw5+eyW5460TQtMAV3gBj8qryPwiOzzk6HfLUJ/m/
	 BaQwvbyg8Dk9zbhRphaySex2UFqvk1CHiUdX7+SxTKw8qIJYUA5OVmZhfMPWMnMQtjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VrF1m2mo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91A606A33D;
	Fri, 27 Nov 2026 02:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C91A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=VrF1m2mo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Do4hM+8ek6bBV0GvaMlRASXttzl4hzyXtJq3zx4qn1k+XcgpU3rtbdxMdZuL/TA7XVVb2mSUqHpH6wYXBKzWWkFZmZyTFYk3TZLUXYnptKizqCgd/+cdbEoUjr6VpEM4ITylrnxOQeHVt8+/nQ2lsqOq0TbZTvmzgorsf2kzyK6ipjvPdfu+k8FkKXeixJpECF/zbMo+0JF+3ZVQY8qPnQEewfX9ecrJtok+Mcsw4YOMLOe7Qi50VvgoSruvTc2qJ1fZohA0wEcapsNeuej/NahyWMxBVE26gA0EsZz5kbgBxFM/1sOj1fv7UkDx6cFB5sGMi8Yf0hw1LQiWgQydCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFnuR4cwFoy+sqkHyHHAttRq+ADEvpSyhL16ShZEGyI=;
 b=DIrZFB/ntQ/ojOEc4lyj/x91s5pTugGZosWsGfHWwvEyKmA3vCZoaYl7g2d5Ki2uLso9p9GXV5HCoD8Yq7Ce1N1+yIulMylHe+U7ViYDBsJGK8J6MAAz07wuw5NfFCg0tOo7yEMA23Gc3GA2pU02ZjbEB95PEJdOVLTzgkgSGDfK9jSxHYb+4zbEkA3863k5/Ahvw9UoEW2lorXgHF3yeYtLx96XH+DTNqe1ZEJUEwskEvg5aK2/zqIO+fhBHQpPDkSDDIJDrqGuyPyD8FnGZcAcRQVorLrS1LQStJZc1oAeKABbUfXL0UdIbxqCI0Nmr/bUm5TklNSkUmXxFG+O4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFnuR4cwFoy+sqkHyHHAttRq+ADEvpSyhL16ShZEGyI=;
 b=VrF1m2moFEkXjKJdYSTiSlYC6UxUyQEeAVU6KRO8IfVSb5O5sCC6rnt+8/ZcuR91x1BDRxwingFgGr54fJqXM/new347ui+BBWSL9OMVoUZXgpPdnyJ/01PKo5m89ajWcmnYclxj3WWzBeEBiowLVXrklQKGwFo2aeucVN0KVFo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:51 +0000
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
Subject: [PATCH v4 05/15] NTB: ntb_transport: Publish link state after QP setup
Date: Fri, 27 Nov 2026 11:05:23 +0900
Message-ID: <20261127020533.2481725-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0083.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSBP286MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baad18a-eec1-4be5-79c2-08df4c2af650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261026135527099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261102130727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fMl7uIoGQ4nzorm+LsxuEp7xmdk9ngomWvo9PtJhFQ8fsQJNyziN6GFrJJSSHQVI/bMG1WusxCGFzNOrg4JkGrpGp40c3CDqZn3nCNnGal11VWLgu5EvLzTnbTBz0tLMi6KEfYq4pPIDDvuLQbNsFE1EAbyS+Z72IEQE9M9ZeyFOfcvaCJXo3nUTjyk3xQ+qLVSv9ANfWK2EB6wDamIrSvU37uy/dVsT4dcOd40uyqmmv0lxpYCNWBzJVpNHZs9TMHEb6F06XWYl2zVB9eDNIXRG+rfHTF3tn6GEUHcbiZeVq99qrvpqZpUOXaOmY0LXJ4PmHbBUYi5FOASgk78bsr1MrZCTkE+Cyza9lSX1vFTRC8Hh5wYWBlz4bVj6V52qTWuaLabRicrtfOE8TbhMnboAU4qNctTYgtG3QRXFCPa4wjLQ+mLzXQ6gIoodngVTLjs9gJYzWjfBp4c48yS8+DWhQDbFN0+4aYX86nea6LxqCAp0FFl0BOfVY28wr4hN65/JT53dhbZ0VpkOm0KJSFcKZHE8Bs6QK7J302psBqRyHGMa4IXv2vubTCcwoUhRzXpuVOEn/Q23bPAoBJKUFfq5CZWJJZ1Zhs2eUZtZiUGPCX7XPsASLH13GySHem2B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261026135527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?buK2nl28fhTgfreCGW2qFYpwyoCS9H1B/HnnvwePAPnDVnA1fh38IWANZ6II?=
 =?us-ascii?Q?KK1f2Yo+mh4tCODlJUIr5T4z8UN+racF/wLCFMdJnnwMcZTKd45HTSzvB5js?=
 =?us-ascii?Q?ZRo/IXFuGk7Rr4tVvuJhBJi2yky0W9lLLK22Q0jT3rlG1Y99J4hP/gtH2Msk?=
 =?us-ascii?Q?4bmgXpK5N2BmjdSnH5EduYmWUZ04QvGzJCbBEQp7vbk4rYvOpmTEtPYhzPi2?=
 =?us-ascii?Q?Pm1EgH+fiPT+A0mSuCoALxBB4DdkVltMNWAFDtF5gSMd1lHdZmtWg2OKjcu+?=
 =?us-ascii?Q?jmltcG3YFrzyl4YIzjlotgQV8GVQ3XyZv71KAINl/s229lveDwGEEn9icbcE?=
 =?us-ascii?Q?Xjr4kOjxD3pGJqhimf5J4xsGPdTylY/HTYascDlc9O7Nnv+35WsoPRxhAa7g?=
 =?us-ascii?Q?v89D6zkRX8uVibh3/0yXEeaOuQTYaFuSbB0OpYY6XQUOX/vf/RlSbfFdeszG?=
 =?us-ascii?Q?o0kt8l3y/fS1Sit+WLu2Oy4XITwLosH9Fy94t1vu3WK/4fbH0w9rLpldCpod?=
 =?us-ascii?Q?tfdBEIOLWcpK7Cu5qLvUGveeADzhn9vuen9Ot6nikcVjN8+bf0X1J74dHjfN?=
 =?us-ascii?Q?kNypOHlFdNDLxgHN1KmZhwTzBBmOT2+a4GP+BHm7d0QTsow1R6jxKSWL6++v?=
 =?us-ascii?Q?NC2HGduxbRpLF8HNB8dBCG7o3yNeOJgO1vi+TwpZW3UJSBFhYNP6TTvq2r77?=
 =?us-ascii?Q?tgrIo1REivmzpGdxDkWOtQDqzqrZNOmtkdaT+pmb7Dn9qVR2gTQ1LS5yaVFu?=
 =?us-ascii?Q?vnedy9rBfrvQXtaFem9kED7nzETVV70r6xpDeUDWSAbFNhg6tMCcFeWsudwh?=
 =?us-ascii?Q?gSGbo1LmZ3UDd/bs6lzpCleKNkNDgUKaecJovX+QUhE7U3a1R3fJCzjGZC+l?=
 =?us-ascii?Q?7hKWqpPiEUGbJe3q8dl1LABQAyr+8+DTABjxeSUuKfpJr57LU5EcdFkBi7/M?=
 =?us-ascii?Q?/acHjKpZrXzkZWj29W7aEOPA97EnWSeuEprT8eIDRFvK1U3a7sDL1F4pS77Y?=
 =?us-ascii?Q?waO25Z0k0CMsZu9cSjaaaA8iWwBpsYIdzLamCfNzubDq0eC0tS0yHk6b+r36?=
 =?us-ascii?Q?9j8Ugf+wSY33Ur46N4PPR9OthOfPRFn/rIbpcV/rJeHdyuItU66v04C9ULwE?=
 =?us-ascii?Q?gp77S2Hjt3+XMx8qVI2VeGoAO8d995uwzctpOrEdWKBIUCPk2luNmz7m2LJP?=
 =?us-ascii?Q?tLM+xf/sJlUhlPcbMdDsxVnGWhr0tkoHY8zbpv/ShMASMg3Rtls0RAsoVZpm?=
 =?us-ascii?Q?lHITOBK7CUjVPGOw6bncx4VTpvwsdn+QSpuG83ekui7kUIDf6Psy7Klr8JOa?=
 =?us-ascii?Q?Swg3FKlGcYEtRiHDIf3UpUVsuVJlUDFwlEcgOcJCLlYfvCfEcoU3SVOZrOoZ?=
 =?us-ascii?Q?A0b1zqOmPHx/7CsgKmWeIM+fGVpegd7JUgmibV4RDp9PkwbIDwfKMZwSAZVH?=
 =?us-ascii?Q?E4HtHYBEMHH13K3Qv2FeIjXocEVoEse3jLprDFTlRI23ACAFHWidAo6WpBfK?=
 =?us-ascii?Q?7ISk/k1aAsE1R58Wgq3+9iNB92oTbcCHIhy+f7fjsInHBv2GHGH5XCxtkfTW?=
 =?us-ascii?Q?W/Y7PfqiUWjA54/icGAb2/GMjYBW9yKvANWMbhvw8phvUkmYQClNiKBZug+v?=
 =?us-ascii?Q?2k8KjFIqVqwjd2yoDib9jWU2ZpKnFGqefd7F00MwruMKAIP2E805uQFz0nPo?=
 =?us-ascii?Q?Quy5qHljHdzSWHu2hJUNnbqMu/C6EVgp30ZoknUY4/kmeIaydCSBn1WOLhz4?=
 =?us-ascii?Q?ySCM/u6H/BCpBUK4rjQA0J9jVJDABSpDvrHu5ulHJxlkA/iQ1H/j?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baad18a-eec1-4be5-79c2-08df4c2af650
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:51.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16hwwXkQiy3zQnG+ZXxISDCXH1DRbtsTVsKbKJb0zRLEWCRY24hDwFwK48+GjZ9Pk2SVi5oq+cgzU2ROTREekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

ntb_transport_link_work() marks the transport link up before setting
up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
can then queue QP link work, which may enable RX and notify the client
before setup finishes.

Publish link_is_up with a release store after setting up all QPs,
and use acquire loads before queuing QP link work.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

v3: https://lore.kernel.org/r/20260928152550.3354675-6-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0822f92d24b2..a8d0c6465c12 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -923,6 +923,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
+static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
+					   unsigned long delay)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (atomic_read_acquire(&nt->link_is_up))
+		schedule_delayed_work(&qp->link_work, delay);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -942,13 +952,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_cleanup);
-	struct ntb_transport_ctx *nt = qp->transport;
 
 	ntb_qp_link_cleanup(qp);
-
-	if (atomic_read(&nt->link_is_up))
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	ntb_transport_schedule_qp_link(qp,
+				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
 static void ntb_qp_link_down(struct ntb_transport_qp *qp)
@@ -1086,16 +1093,19 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	atomic_set(&nt->link_is_up, true);
-
 	for (i = 0; i < nt->qp_count; i++) {
-		struct ntb_transport_qp *qp = &nt->qp_vec[i];
-
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
+	}
+
+	/* Publish the link only after every QP has been set up. */
+	atomic_set_release(&nt->link_is_up, true);
+
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		if (atomic_read(&qp->client_ready))
-			schedule_delayed_work(&qp->link_work, 0);
+			ntb_transport_schedule_qp_link(qp, 0);
 	}
 
 	return;
@@ -1143,9 +1153,10 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (atomic_read(&nt->link_is_up))
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	} else {
+		ntb_transport_schedule_qp_link(qp,
+					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	}
 }
 
 static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
@@ -2392,8 +2403,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	atomic_set(&qp->client_ready, true);
 
-	if (atomic_read(&qp->transport->link_is_up))
-		schedule_delayed_work(&qp->link_work, 0);
+	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
 
-- 
2.54.0

