Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745153;
	b=vICRSuCUfd8JP/R5EWqA61H0N9HPB413dw0ydzEBrNaNGxerZT4RcLhi++tLAmGnX2gZ
	 WdXCTQlsM4aioxlTcHcV7MJyvQyF0AFzOPHN3/TaLAIXdVo28VVB7LmGN73NskrC/bL0y
	 RXvgTt56q5cX7SkQ4m11SaYztNUulH2kcWor99PrW5K2ZnKhaLDnvOkFvLtu6hNNZI5zD
	 SnjWaUwCAGS0tFNp7cIxoZj6sDl8ey0rz+zvGwxV5WVumBzFBE2G6lNch5RAhAG17W7hO
	 hh2Bf1eLD3/TqXsTZi7RcxOq9v/xAtimmwpUwkT2o0EmFJbGcFWGSlRemuiK232aWOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745153;
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
	bh=vVgKfj0Cn0CFXry+NlF3ZavpSBAgwDRBtNuWPnHXu38=;
	b=yqBic5uRG5c39qk1rlSW6xAzTEFpRuprNTjQjH6x4T2weI7HWoKobyIRay9yIB/o2yY2
	 mjSRPSNVeJ36hYCa8HJKesT+Snda+R5XiXu+T5/WJ016t3+b2EAZ2KFBib0F7DgYCjA9p
	 vZm6nRF/NVptzTyZMoHK+wY+Vkph0Y3OsVMRzIg4hkRP11vNJbsKqxqzcia2nRw9x3qH5
	 KOPynU0225xhLLMmELA1hKz0dC8pXoKiGY52m1iNmMikOAd3fZiTIPQp9ZFCS0DV8au5c
	 XMzacRM8O5Djh3+xW5lGRfK9779CDsr7NaxSnKvcG5B9eoeACMYimgxejfi+nrC141g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=hzu8gWtb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F7606A31E;
	Fri, 27 Nov 2026 02:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0F7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=hzu8gWtb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7i9Y0sr5gS2WqBC7/p7zYONjOqERswlLXRmmnUdm4dB5X4VKVa31tV1LfYVYW2zmyOaehfPIl9vIZQ8MIiQKlBvF33jaMub+NRoPfQKcQ0XgRdE6LlTuTwte1O2tuD84NMxGddXlpxlLmZkYwCPleGPP6Vxp0PyxZmgLNCVXdNrv2MF8WSFN/0kuGf+l4InjRhBQJgwMWkhcPwW+xwLgJIjrykwyGdkA2xpL8TSfXjlxs/RyRKOOf2P7sMbJyyL4ReOx9suQ0O/sOQC4x8Oc1Xj4Kysi6ILjesl87PTXDQnZNQ2Bemih8ck2uffbn/0qIGf1tdhtIbSOHG1SFNGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVgKfj0Cn0CFXry+NlF3ZavpSBAgwDRBtNuWPnHXu38=;
 b=E05FGjLmWk076UjQaDq0T1wQu121+cwBEAqWvP3yTXZK8RYWluO6MSIE0ny9MIwysPbT3E82GdLdHpI7fxsGvg3xHZCCDhyASo5OAUa2IHF8A8RN+GhDwj8qvkE6Uwzs36TP9ShZZFGUr25qJbIjgUnNUYJN14Xy5JeOa0LLfHfPBPVKlyMgZ8iM0Hbi5KLL4QezeJ0Hgbr9YouFtAs7iCTXZ5toYQeKq1tTWYJQlkIVLeaws5RPTtEW52c9HUpurckU1G6B1hbmtzt4vZIqyQONIl1gFozI5MG+Jbz4V1Ldw6F1QEcRs9OQNZQHi+WyV/d0zIShXXNVrXIBVRfrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVgKfj0Cn0CFXry+NlF3ZavpSBAgwDRBtNuWPnHXu38=;
 b=hzu8gWtbftRh7ZDkF98yPndCtazUaU/jCBGDcT7BCOK+jbWHhI/53kfo1ufmI7r4nwv3aBo9mSue8k5USaMTKjhPJNRtbgGYfTSqEKPYqM57/EPtFfsutwDe99eUNfZuDPtD/tY1LDxIo3XOdnXHEbliWnoAAo4Xygz1Mt6NNgA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:49 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:49 +0000
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
Subject: [PATCH v4 03/15] NTB: ntb_transport: Make link setup flags atomic
Date: Fri, 27 Nov 2026 11:05:21 +0900
Message-ID: <20261127020533.2481725-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 6089c6b9-af21-44be-38c5-08df4c2af527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261102130727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h7YELyUWTEQuvnWZqrwMp3xSccm16ufXe0bgpDGULvKBAdKRrwT+LdQGmsJ++IpK0LW6mQI3yVMtvhKtCQ4QfSKGouQhc9sqMKdUDHr1wqrNUJanVC1EY2sU7mPblHIexuA13xgbGptZZ0gA6hJkB6QORUkUYlBMFQ2FVLHbhkyu2fsv1tqJ8+I9yFyw+3L1wyP7iUi4Ufz7FKlDE0esQJc0qMgMceLSTucpy1VUl8uLcLWsdNz/KMd9usP3Uvj47WaWBwrLhH4Bp2HadP8K+I5Dvgw7PtVIaHg8LuLOhN1kLGNQo98nsAyZjVKyeslvQm6Czofg3ecb3a2MnFXrqofxH6xArug84FIjV6v8QNlr0C8R6DLhTkYUdLTaltxgpwbmIoZmOd9SnS0gb7FIpKdXfyglJp6XNq26CcY0Yay3YZlLlNJrMcPt9afV7dG7BfA9h9YAD1W04gAtaw0cFx9pT4iKc78n4ZDofxsZkmdBz6PhtnFRLRVu2RCpqTMSxDOGTZd/gEzpP1bHJBb8O/5NmxAAsTWTvNMC6Z26TG2/poyEbu4NxrM4vRIl6nuzuXkdaB05euTTFx+4T0eAgqj7NXXeIxS9mqiggStNyU+tzXRhj7Wn3vRzj5ykA4FX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102130727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EoDIlw0UnV43Pju5EqD6stFmuoEcxzMKJuNBzGf8BDQwXMmdv8zOxsui/FP1?=
 =?us-ascii?Q?/Sge4rCi31CDDjskoHm2s1rBg+Pg1ub17xQF0oLu7cTspU0jEctps/MNjTKx?=
 =?us-ascii?Q?GWt80IMlWZzlOeISv9JcdwDMNsSjjsyYtAx+Kol2yJ8rX3bcqTIxnUP4IP+l?=
 =?us-ascii?Q?H7oVy/QudA0v0RU/TeSGNS6OZXhDhjqQ5TgZ2qAqhLrI1jUiAXWH84RsnGQC?=
 =?us-ascii?Q?ehiVkI1JS7fhYhwoiyfo7ZPi+IBTXjuFfAo9gKqhZdXybcWn77R/jdzRi5TP?=
 =?us-ascii?Q?tF5K4iP5FKsw2hJRt//yzFKy8wGqdGPGmXeD8UusR6uSptf15xbmtuqGEemZ?=
 =?us-ascii?Q?RPRWMQRRMqxQfaJtAxSn7AVrgdKJh/FEKzL9qGhbr3qTiuCrRZO/bJRU6ml8?=
 =?us-ascii?Q?0bQHs/P+7L4auKPT+tHxGtNx6SwhkFh4uiQ8CSrcS0k7dZaNBgkp93zcbgSv?=
 =?us-ascii?Q?+RZmeJZpZY6UQNQTps/0cZ5Fici0EzXfcNXyCd3+wtQehx2w5+SfnHrzbM2J?=
 =?us-ascii?Q?0o5Oym5CDdwTflwuVTHjBZMkff/hDUFYeFAwpQvij6BYsgrzYbn/ArP0ZHoI?=
 =?us-ascii?Q?gp/84NtFmzUSf4u3xBjc7EuhQ6ZzSd+ju/dvVGCUBMJ9Hoj+349oBGv18JYX?=
 =?us-ascii?Q?TM4BlQuIhZ2pkrbzba4ncphczunbQuWROqKOoRziLZE5kaUlcte0/RjHb6x5?=
 =?us-ascii?Q?1sBnquNsezVd7T4vALDPwal2ffM/91WSzAbFTW/Qlcj3pDm7eJI68e9KiqkY?=
 =?us-ascii?Q?NqQOzjqwpmUv0kdIWW85b41IICeckrhyfNCfCcdoVudd7QOktt0CMMKQApD9?=
 =?us-ascii?Q?zRMTR0w9PRs827ot2CF16xFwlMQRMrKmw7oVD8ZCpNA9v6ex/MkiGf11P+GM?=
 =?us-ascii?Q?LqVi4qcSrWaxdCdK8Xcy3IYyr8iJ/V9ePSYXaOSayN0t6oHDE1R0TPuqv+X6?=
 =?us-ascii?Q?ECvFtMhDl6l2B/z+dhoyVPaMN2rNZWEaNRQLOc3g6CDgmZSid310QFvKwkfv?=
 =?us-ascii?Q?iAedkbeS+V2B+hDGAF9+MatI6JY5hv2TwL5O+K4Oiq+csjegG4Cv6jY1HMsC?=
 =?us-ascii?Q?c9AGFEq6mSCCVIvrlpV48pYDg6Fq3JTtvz4i25AXRSrOCs1lEcYtX0YoABIa?=
 =?us-ascii?Q?8v/CkU+IFa33c+4RPzJrioB4+QWdfZ0IO4YrA1yFYgGY6jNOwETX9DD32Opd?=
 =?us-ascii?Q?N7arMuw6N3Vlo+cKSRR+QO8FDla38GbpYGrL/37HaG9k5qnuRyKcgkKTPNG5?=
 =?us-ascii?Q?irkG6RjkNdPaz/SvKsBJjISWH93goKQnaoOL6Gdpi4BffjH1xg5hNeJTujuu?=
 =?us-ascii?Q?sXfI0gr4X3kOcswdsRpFe/5czbYz9W94Qb9al+G0eLZ6JKDAbcYPfquhI/qf?=
 =?us-ascii?Q?SM+grJK6oYGtFOKOAGYjV2Gwmpunvxa9wR3bYnKxZZYYWEh/QJF6JzxCikO7?=
 =?us-ascii?Q?GOQdLbeR29EYyrcfpu7/tdgZvqzG0niaNuw46l9CwF1GwsYGpSgurLEZJeOz?=
 =?us-ascii?Q?4NFftgsHBmegyZ/y1XzByxMPSAhqqzBv1mPQWsGojaWIgvhBzNPco8+Uif3N?=
 =?us-ascii?Q?FPvEK6jE1jr8Db9Aji5MbJkpkZPUfoply2xd93xhG4spphb69iYe+Owv+044?=
 =?us-ascii?Q?TYgoMsxC7eLvtNZdTPvdvPVgCMEV+LC1u1ok+BXkL+6BDvv4hEafPpPHzS76?=
 =?us-ascii?Q?WqO7S4p7kVrod03HcRSGMpNGqR5kJ8S5Va5crBvn9nKOuXTbxdtE6RDdpsfc?=
 =?us-ascii?Q?3X/PanKkGbfSH52KmaEIJYRYFJ5LpoatS7GFETKJftOg3pcAG4tx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6089c6b9-af21-44be-38c5-08df4c2af527
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:49.6145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMA0n5nrA/8q0QHdhWpEkioHUfKdDSoObhLfWRE5hCqnvnXTS7Em9tp9P0Re9cw+be144kAL7JL04WnHwXWchw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

Convert nt->link_is_up and qp->client_ready to atomic_t and use atomic
accessors throughout. This prepares for the unlocked cleanup check and
the link-up ordering fixes that follow.

Leave control flow and locking unchanged.

Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@kernel.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

Ref. https://lore.kernel.org/r/i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5/

 drivers/ntb/ntb_transport.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index cbdcc7b933e1..f135025cee9e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -47,6 +47,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+#include <linux/atomic.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -142,7 +143,7 @@ struct ntb_transport_qp {
 	struct dma_chan *tx_dma_chan;
 	struct dma_chan *rx_dma_chan;
 
-	bool client_ready;
+	atomic_t client_ready;
 	bool link_is_up;
 	bool active;
 
@@ -249,7 +250,7 @@ struct ntb_transport_ctx {
 	unsigned int msi_spad_offset;
 	u64 msi_db_mask;
 
-	bool link_is_up;
+	atomic_t link_is_up;
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
 
@@ -945,7 +946,7 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 
 	ntb_qp_link_cleanup(qp);
 
-	if (nt->link_is_up)
+	if (atomic_read(&nt->link_is_up))
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -972,7 +973,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 			cancel_delayed_work_sync(&qp->link_work);
 		}
 
-	if (!nt->link_is_up)
+	if (!atomic_read(&nt->link_is_up))
 		cancel_delayed_work_sync(&nt->link_work);
 
 	for (i = 0; i < nt->mw_count; i++)
@@ -1084,7 +1085,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	nt->link_is_up = true;
+	atomic_set(&nt->link_is_up, true);
 
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
@@ -1092,7 +1093,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
 
-		if (qp->client_ready)
+		if (atomic_read(&qp->client_ready))
 			schedule_delayed_work(&qp->link_work, 0);
 	}
 
@@ -1121,7 +1122,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!nt->link_is_up);
+	WARN_ON(!atomic_read(&nt->link_is_up));
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
@@ -1141,7 +1142,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (nt->link_is_up)
+	} else if (atomic_read(&nt->link_is_up))
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
@@ -1165,7 +1166,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->qp_num = qp_num;
 	qp->transport = nt;
 	qp->ndev = nt->ndev;
-	qp->client_ready = false;
+	atomic_set(&qp->client_ready, false);
 	qp->event_handler = NULL;
 	ntb_qp_link_context_reset(qp);
 
@@ -1373,7 +1374,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	if (rc)
 		goto err3;
 
-	nt->link_is_up = false;
+	atomic_set(&nt->link_is_up, false);
 	ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 	ntb_link_event(ndev);
 
@@ -1457,7 +1458,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 
 		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
 
-		if (qp->rx_handler && qp->client_ready)
+		if (qp->rx_handler && atomic_read(&qp->client_ready))
 			qp->rx_handler(qp, qp->cb_data, cb_data, len);
 
 		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
@@ -2271,7 +2272,7 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len)
 	struct ntb_queue_entry *entry;
 	void *buf;
 
-	if (!qp || qp->client_ready)
+	if (!qp || atomic_read(&qp->client_ready))
 		return NULL;
 
 	entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q);
@@ -2388,9 +2389,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = true;
+	atomic_set(&qp->client_ready, true);
 
-	if (qp->transport->link_is_up)
+	if (atomic_read(&qp->transport->link_is_up))
 		schedule_delayed_work(&qp->link_work, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
@@ -2410,7 +2411,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = false;
+	atomic_set(&qp->client_ready, false);
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
-- 
2.54.0

