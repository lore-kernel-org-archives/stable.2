Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745155;
	b=dfrhuUwJIb3Rzo+gosTtipyonvlObFGPR4nwU3ZF1K5b+sbDYx93zQm1KmwEYGP4aUmZ
	 m49wQXLN5hfXxUjfUmFFhGbcOVFMNfYpDJfRTM7t3xQ9oPoGqYcL20A+3WpjvDmX9wjsp
	 GKNnHQeVf+M+Rhj60myvbRKbF3eJinFyiiYJ/LdxwtUlxxCiMFggs+CvqcnFzJhe4YURW
	 lU29PuONa0P0ldvAZ6zRUw6dF9BRO8AUV1kYopLXQnWMjktOQFxFuUpR0NfsVaHvZPL/M
	 QoelU/4BozKXyCiTYsVMly0cDCT+AqDeyHR7WDjRk7LFXqqBEiD+FVOXkjmYHjF5VxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745155;
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
	bh=j6CCUGlCyzK4gHVoT8L0O6LtOjmTJVzY5X+P6QymeWE=;
	b=hahuJ1QFULHG0vjhIxGLMsjtMUAbT49QZmevjQXPCnG4bWgeI9vHm0RsNLdKZ+5MDJCQ
	 Nis/8Q49c4gbcMNGPSteeUbcp+DjIuTTE/z/yFyxggHpZghpD2vsSmW6FYzbQTDpNChpQ
	 cQGeXZv5yh58APJdOOhfr0gybhcSG9ATGihO41qPz7ZukrDAGXoY4jcVQwkfakV3+CbbX
	 LDAd1lKvO5t4Jff2xLWkLTv+RXpJrYcXUlTX3NjXHG2ZanLlUS+Tu+iobovrl4/zifWc4
	 bdyPYm5dcUHa+1e5lhrMozK2NpKwFgQh81u3W/OggCTqhZ5QWp5SttwPQUsXZeTRCrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=meNnvaqF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDD606A332;
	Fri, 27 Nov 2026 02:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AECDD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=meNnvaqF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW3Iffn5hdaz54TRVLWQ17GxuNZmx0JmsUsfYFBH1ubCP0GiTBUwztc8RNtpsd3OqIP7UcgKU76srng32Ac+2/6W1FaCPuMmIvxJ0avHM+vQ0KdMSlviNiHai4bYvUzQeUjFo0KJsEklHGL+ZoDankdrF/jmuuOh6+YHQzVCMFn06rDwQhJnLwiZcNrEAtb0r7vRZyEZ5eRh6WcMGGtObUjJO3asgGmz6QAsBK9Qgu1s5QubiaeniBHSaqyHflY16A2zbyNT27L9tAae+ditLsHyJrvs9JidibGp5z40RSjHooGXQH80/iYxp1r08NuEOclntPEZm3ks/+HotOlC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6CCUGlCyzK4gHVoT8L0O6LtOjmTJVzY5X+P6QymeWE=;
 b=BzniT1nRUWvRBr5FuJvnq577AUnx1XpdZwDkcuwY/FK0OTsG1j+L3K1yjrTDnpWZhM/S+Ad2O35ekg+V6TmriAzqbTkgb7RMEUHzi2cClqKJAL79wiKpyW1klzsZofNR2+RXAmtWBchMlW/0boVobSEbHxwoIdLvjZUQwLOtTyOsUSfmlLAP60tdBhigqcwB80LmlwzPzqww37oCaM5TWI2eZWhA4akLrB40guCfXBrPFjaBExjArxkfNDPwFfHC94wiN/ONbeBYnsaQzFbU8Wh6EQlTIltxXDvIYx+R765d/deIAo4/zqKisMmUCq8Eb2Vl9rB8Dtmw2RpZhIDdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6CCUGlCyzK4gHVoT8L0O6LtOjmTJVzY5X+P6QymeWE=;
 b=meNnvaqFRdxf8ew6DejDi+ZN4XjCkXrLCD4kZUl27uKyTU1uw5qf8RBdwk2Mn8RlcuY4torpX5Kr2Xy1OrLsaltgTmypzUhoyeT8vW75MpJ2OlaDl5S5acSwl0xVEiG8jhCBZORhRwj3IJstYpvQzTBcph2Hqv1KHCMp5+lxpec=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:52 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:52 +0000
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
Subject: [PATCH v4 06/15] NTB: ntb_transport: Avoid losing QP link-up requests
Date: Fri, 27 Nov 2026 11:05:24 +0900
Message-ID: <20261127020533.2481725-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0146.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 42ce18b6-c65f-4df1-165a-08df4c2af6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261026135527099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261102130727099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/9pcPlNJN/B+Q97ceY5SSGBHYVAYE2aYvTcZ6FVw8Fx8WLg3Jm+S/hYndCBe2Gm12jK2BCVhknZX4Nv5W5eOwdPXh3p2SPz/pFk/lHo3c8GiLgk/uGoBhZyeBwEy6/f1yztjJs4Xu/pGsaVdWCMI0GEU36WoxRONooOt5wHBKjEVr5GP9QVYtZD9LzkuK0AcKJKEFOUvrE5A70LbAEko9wfzDx8OF2hZr220ZQ/KFUFxb8siOAdefEvnbGlwpZKhNOsHIPeUpdXWzYwWfiaA7lte77zIq4YIBd01RdgQipuEkLEnk9MWpGVX/pLqarfWheDzevXpTPGzbNelm1RQtQ60XEqsuExNXpulrojN+HCp39WKv6hB4zWAPIIyOCq6wfomw+boomb0HH0qIo90Gzhed7SzcTYWhLXIplui8AmCojPcUtLrCtRa3WYBn/YPC3mv5MgEm4fE2Vleuw/yYCU5kan6JsI68BU9I8Hfs+v7t0JgmNiws80p0g26Yf1fUZq+18DW40xFRdKfki4SZ09GlW39EmNBnItHJ6g+fe6tj1mSDQ4DmxuCLWKeiMo/pd35sYK/J3No2D2Ak4toU0e4GkIsNnQfuhCQZIAUjCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261026135527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102130727099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NMunbPl0lLMO6JgwA+2lm0ibiYBox2Pd3HSA+QZgqrOHJr+vOrCun+CaREcV?=
 =?us-ascii?Q?Fq/oglvq7nDXqejdaZLbTLCLOXplf4epT/n2GecsK4BVw1SAxT4ivXAfLiTA?=
 =?us-ascii?Q?eByg2SU8E+MAHt4RwEK+S2clVcDwxpp1AgjmCGZlCOV+1WT0dNskmOuNy63/?=
 =?us-ascii?Q?UArthlxpXxxlVwGVdBRzAK/bpdRLQGoRYYL3b0jylp8CHWL6c+mtEhgPmb4t?=
 =?us-ascii?Q?SpuuYyFRdMTPx6Y9YXcGZqv3RtOVWNG7aPUKXsYkPkWX6TgHQVHkINyO87T7?=
 =?us-ascii?Q?l6Ju7Bujy8UpcF1MMFlTYVGYi8Ie/CVgQAhLiRmiM8UMM+x2EUZ3CGWLUexf?=
 =?us-ascii?Q?XmJ8jEkdX61VDwqObNhyplHaeFeUxuGji5buS8c2S85BWdpxjg6OqpXn/J24?=
 =?us-ascii?Q?ZUXFLjLIzdZqCfkBWCOIGzuaaBDpWDRv/sl+AmDrA8h8y48wK+iWMZ71nQJV?=
 =?us-ascii?Q?3S+uWwVgPEy2NhHyUU8aD0EpV+YSxj/axow/67n9Nu+T0meM++Jj7mpiFRgN?=
 =?us-ascii?Q?JBkHOE0Q+n3CSylVrUc4Oq9fqVgPshZpU9AB71m9EoUAW5qmUIJ0WbIYj81C?=
 =?us-ascii?Q?2ci4qzecmyd+jIBZaYGTqBxqyO5CU2Z3UcaWGQBE+S7VzLd4hwbh05CeYG5t?=
 =?us-ascii?Q?zXaeQfUAOGpfxRW/8Ru/NlhMrmTDLYDYB2H06CqMTOE9ZpNTxnB1bs+qcdiR?=
 =?us-ascii?Q?ZQA+khbfqZNeC2kH3+cf0dYgpBV7Dr6CIl8OSHqcf/izbKPpy0mhB3XE/QVJ?=
 =?us-ascii?Q?vbtpgadirwSfAtgM6f4i0zGVzCYLYPNkt9YKbQ0mNdI+upAAQmvs/LTWw4RZ?=
 =?us-ascii?Q?YautNSYtW3vjvLKMuK0AYtl1t03eQAHLGYdtBoUv1Z/fkpUdfb7aOmC/2Xj8?=
 =?us-ascii?Q?Jb7FMPcq84luVkgj5M6vvhAvtYvnWvG29pWASNd16Tt4QhdmvWPJ6WYl4FY8?=
 =?us-ascii?Q?4xD+97cRPkI8GPq1hX92c+GBMhzkidFMzvv4KZTLN+pi2n3wJaFZUHhKcECI?=
 =?us-ascii?Q?Axq7gyX+7EdZ60nfXR6jW3/l8aFheFnbsIEOnc4auxpcXFwgT8eGBO3WxIOo?=
 =?us-ascii?Q?/wRwVheT6ooWYlwH/BcTCN67huvRvef8zU2NkQRQ2+LXfwnOMpoiOw/FNVr0?=
 =?us-ascii?Q?snGVCh4XcrWXeeCzWM5CVsNOndOaPoTMjxN5//WtQ3jomB0jpOyNXolrW8UC?=
 =?us-ascii?Q?9V8BhQkyCtSYeGp/urMfsFfl4Hd9eSg97veD5PZKkUHLbbXhrrken7gGgEKE?=
 =?us-ascii?Q?ALzxTKK1NaEfZoFZ9B28KKz3jXa2k+xKumgV6LFsGKTFzZf2U8YtljvUONha?=
 =?us-ascii?Q?4AqK8Fkjy8nZ2T2aO9AyNspWjLxcHFkkwr+rzemARR51PBjQfzI1EwNhef8k?=
 =?us-ascii?Q?ojyiIPdJ9AO+2+MwtxQGFSL7TcQSmD1Ms16B095zLwSiFuMa0Pcf6JaVscSd?=
 =?us-ascii?Q?mpUuDvni/qhGxK1g3vXAYbpxTS1XCYkG+L1znfRFXPjQv3mQ72StRqkOAfvF?=
 =?us-ascii?Q?H3oegik8/BWBMWmQnKa2EV3fguMz6acLqzON5IC0cjUAqAa9y85O7ykPBWMy?=
 =?us-ascii?Q?f1/DqfpnU0LlZ+pvxR6nGz8ZuFE8eMs4eIncp/19Qpj4r25ESg9PticaUke3?=
 =?us-ascii?Q?b1Cjc5Hryg3dyoSR1z1vRFW6hP+4kdJgX7H0aXsV+IEfAGZuITYQafNv2tYu?=
 =?us-ascii?Q?zXuUaMrxyP6zYOCmaQ+rO5XXzoxQb5qU7jqHWgSOq5ajKn23LiuvAxw0PQE5?=
 =?us-ascii?Q?phgMYky94GCBimMXXVGDfj8HnD1vxuqcD3o75taJ6/MMT5ustnwO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ce18b6-c65f-4df1-165a-08df4c2af6ff
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:52.7183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+USf6GSLIR6pAm4opNamkzta6Qq5Q4hJaxFMIaOhhut3aJTHSQun33szEqFRwVXOaFFXw7nRRVNbaW1qh2nSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

ntb_netdev_open() can call ntb_transport_link_up() while the transport
worker is completing setup on another CPU. Concurrent transport setup
and a client link-up request can both read the other's flag as false and
leave QP link work unqueued. The QP then stays down until another link
event or client link-up request.

This is the store-buffering pattern described in
tools/memory-model/Documentation/recipes.txt ("Store buffering").

Add a full barrier between the store and load on each side.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Clarify the memory-barrier comment. (Logan)

v3: https://lore.kernel.org/r/20260928152550.3354675-7-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a8d0c6465c12..5e9418422b3f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1101,6 +1101,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 	/* Publish the link only after every QP has been set up. */
 	atomic_set_release(&nt->link_is_up, true);
 
+	/*
+	 * Order the link_is_up store before the client_ready loads below, so
+	 * that this path or ntb_transport_link_up() is guaranteed to see the
+	 * other's flag. Pairs with smp_mb() in ntb_transport_link_up().
+	 */
+	smp_mb();
+
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
@@ -2403,6 +2410,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	atomic_set(&qp->client_ready, true);
 
+	/* Pairs with the barrier in ntb_transport_link_work(). */
+	smp_mb();
+
 	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
-- 
2.54.0

