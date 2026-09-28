Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54E4EB867;
	Mon, 28 Sep 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609173; cv=fail; b=Mp10PMepNRaHM8xLjdeZJtaixtwBlvvgE4nQ0FT3iwsx+AmdEP4ITslu5mcNGJ3ay12TSxxLCNoEdp/fmz2pwDp1tPcrVFEn1svPTkJWxbtTcFVBHaARdyr0DYFuP96KIO4urtQV0Pp5NWRFOb7XWpmSl1Y9ipfH6i6nlfI3tLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609173; c=relaxed/simple;
	bh=UskQ21O0jkX7uhk1Qm39V6Uiqr1L3ToRiswzVmEIDI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o1/s4xkl1zKDRDs5Rq9+rp65rSC7KAPmx8RRU+qXsx0GZJKXIFM7fcdH3VqgGDT4CcIDJpqaV7MmAnD49fTYeKgx6cVx/a4cWC50zu7RVLCnhMIiH0ON2cLPrXbu3tFXwww+WrpHW/esLQXWz0L0bNxtdtweDm87JJA9kWkadm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QkSsKrup; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QkSsKrup"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ra59ymFH8v/lII6S5oj3xQEmQS5hAd/8/9SQoK/U3s4vnx4Cvn7XKvIx6/7dzx5cksmEKf2mRg8WZYtqHME90CSAYhQIokaKtOV32W24WqRW+8Vd59+On5ifOwEabA+4qEy+i4TXKQj15Pp8EwywbtOyBYFqpaG1QqvvJbXgnvomGlK7iOMP/4rnRXy3lvpL8UsqztLfCd+plZ9cs+AyLaHwi/n8z3H4yl2cFbYng0IwMa0NHCO6o4GIcU0aN+DCiCy/LsZitmX8kgE492r9TIjireIAGP0ho/cqxXok/0gIXX1QhyaYV6ecS4pzxDV4q66UjlTbUD51G5TvfJ8zFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxP4+TAYRwsbeOpnqPtxnfxAvkTTjR/T4iurokBnpnU=;
 b=UHtW5r9SJqe2Ul0L5nZS5Vzqay5vPJZ1MdnoUBatMl1eCR7GEF9tYxhzhiX1MbiI58jG0FeUXHeikNZRDDgRYNk4ZE39j4B5smjdyR56nNvZjj/bbq26JiiumYWFGi+p6WKzJNW6BN6xad4z2zcqBlCyC8AUn2D5QmDVqBhM4tBynXpdWq+s/VFrjNSvr2oww7k3F1HFbSUy3G26URERT2GCk+zzr9M643TwETU4BusbQ1yFzFeDTax+tJ1guSbDn9N+Rc/mpQO4Fddz98jAc5To/cuNwilQu28AngmWyq5IDOBniNYbM/bHbViYv9Vpy3ok5/T5E8GDwb+q8JvuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxP4+TAYRwsbeOpnqPtxnfxAvkTTjR/T4iurokBnpnU=;
 b=QkSsKrupTR4zfy3E8YNlgMb5Q8zm5t4ZPK2rWnfmJlx3reg/M6FVBbafV7loJqv0lCkZlzY/B3zeLCuTmfy1zSMlblk5p6BvlEGlxe9AZrJb4V/4/1YEazZA+eV702lt25aeofOuHXF90v9F0DRsa7qlvcMKXR6wBFJw4ILmJFc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:57 +0000
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
Subject: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up requests
Date: Tue, 29 Sep 2026 00:25:41 +0900
Message-ID: <20260928152550.3354675-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cd1d73-949b-4b5c-eef9-08df1d74cb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dNQHija1Ot+w45yjvYCNUUpVFSw2QN4u9UJWcxb2qFbpPBCDbUviM3W8P6i+z6LwU2JCIm5K2fA23JoqJ7FVxr2YA9n8V6jSyDqNZZ8DM3r8Y96xrnBahXNe4BIsB/FfhKXDD/uyLXqzY07YqC5hlbhbyna8/75WNeGAuNG57gbG84NoPdYH6paTIHQvOUrtISF2aNuTS8wewUkEtEDwy89BqrsxbVfWJFamFMyHDVrBihTYRX8YICkfEomOjF1+qxN6f6EC3JenjxaFr2nWtyHyC1LUutnEZ1jih8x/HbPzqJP0YUw9oNv9a/Ohi4DAg7NFV4WqOLQVlsqaTcxzd2ifuShhPkvpDc4Vkd4TTj43P4BRhwXmuraCIwBMMzZtjYJtkdQKKTLCEfdO/HhfCpFsiROvvEPw7xwDa9ZbGIRbvbh7bRNrKVfE8+mWKjcapwvj2WVhttQlYK5Suo08EM67mi+zR0F5ZBF3Vh47zzQ8tGfKbKKTB/SgvNRFQO069Ctg+eEOt76aL2OZ5vA5Ut5ij6yCH7trnXxkytqQrmXJQb+ZxBNBSqkgUaKI0JyRr/5iq0JU3KHSC9FQNXKG9GaXQdQquFmEt4osamAXg6xKhtf0KUsIUnyYsgNiHhP/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVexW6nh8i6BCYhkrQ3LMLDI6DN0wVRQW4h2KGloEniI6p+Q0tGOai1Q0Rcu?=
 =?us-ascii?Q?etQ8oigdKmRea7pB5znqmd2eYgclUhYRYNlSx+Lc8qjUQBTS2lWj5MfmJ+Yt?=
 =?us-ascii?Q?kj3cQO/C3ApK7F2RonHLFuKK+X+Vbsq+K7Jns3Zi27AL6bQWrlyRA/wya7Cj?=
 =?us-ascii?Q?jaBppnfqXKYLJC6cV22O3T8Nkyjlj3Je0K4QlvHxvZEOn2szbpxYkY6UGNbV?=
 =?us-ascii?Q?Wtkvr1dlzoW2EQvcYZATs0CwaaCpMs4T8yk8IlrVsEMPzTLoCItWBsvHUWDg?=
 =?us-ascii?Q?k9sUcAB9RyYDG7OcnxXApuJjLN9Jfa9WtA5Wh9I0wKR8D1lAfWFJ5sDYw147?=
 =?us-ascii?Q?Ez5eOIQp9Um6oNZzqddze0Ff4KqlsG2pgD9dwcvQEcwCAEOiUFyvINn3R98E?=
 =?us-ascii?Q?7aGXrXHckoUvL7z6vFgZI3oAx1qxiWq9dQvEEhcfQ0+jTL5grBntK7eWrO/+?=
 =?us-ascii?Q?gLJES+EOah+dPIgFositpzUUluYvrj7T5u/T2BsHacLOWWCPTvI7K36MRwl/?=
 =?us-ascii?Q?+08nMxMJH9MRyNB1saX1ZZExDKml2RwkMghjBZVJf7nvc45EGHt0NnPxD2A/?=
 =?us-ascii?Q?//DvxPv7jbqxC4VTe6xMfLQLLDRNvclfbYSh3pOKR0rWENZuF9Q2gvQIeduK?=
 =?us-ascii?Q?izgt6jBALCojb8+j/5sMihWZr9NLCku/vj8twmJ64bbbTNFgK59SGEHzxTBx?=
 =?us-ascii?Q?KKjVE9jTCJDQGEwPa/se6WA7rvZ4m/hjiag44+8ka7Su9IHR9hMIQSbVN9Si?=
 =?us-ascii?Q?FSZJfM22yPXcZvdJNZrX3bxmDZSNy7aGGVx47ocmyMZNlLyaDumPXiLCr/Lq?=
 =?us-ascii?Q?AEugDSZ9a0J44ANzjEiHsPzhnZBEhR1hbBRNDlflXhem37O9MlhnS9LeGDzp?=
 =?us-ascii?Q?+O2+ex/naafBJ2eyRAmvQ0QIErwAP1tfi1RNTVe91kPm1Q1582TYKP0ie4ta?=
 =?us-ascii?Q?PHFWdNjNMVv1Uxy5WLmrBHMhgnISvBTzvMLuY8th5EAkzQ+YrPNApRJLQeBZ?=
 =?us-ascii?Q?1lHFbRY8h8RuZtfYGVxf+/em4gIxz68/8HRG7jMFBZaidLCb55WS26jNwQPd?=
 =?us-ascii?Q?tqhvcTn1zqyJK7B+Ypjwl0M5ra+CCXg2ilXAwYghAO9MWhVh0qbsuHhwxzXj?=
 =?us-ascii?Q?/7VqO2XVQeTd7T4rDlqtat1q037IpwYsAgmsmE6GfySvBophATHxvRMKOjJM?=
 =?us-ascii?Q?hZx1ZekjcHHw/bFvrgrlhUG6qynqEOlOqfzBzMMcDL9+rVJX5kJS3nA2AvEq?=
 =?us-ascii?Q?upCzqmA6UounOh20vp1KVr9R8finU9PpyUPEko5X7Hmae5tCAx1oIRIE9qB9?=
 =?us-ascii?Q?0XmBNbJ7/eV4Szb2ZMDv2CK65LWIs4HZ36mqf291TeKNaiaHjnf7Y5g9m0iv?=
 =?us-ascii?Q?ssMdqisXBywyPrE8mR1K+FzXODETwF38grKhUda5vhcya9y3S484u791mGkX?=
 =?us-ascii?Q?GvxOuMbUG4ntz/mvxLE3lo/CCTAO5lhFwOdnEdo74mo68rFf5z6NjssxJJos?=
 =?us-ascii?Q?84l+8h6uGKLrTHpPAySa3PxhGXUVmj66HdgQpkNjnse1a8rt7bymkuqPjbBV?=
 =?us-ascii?Q?pqUurtj6Yb0q7GEsbsJvYY1tfjEjhytHkUcyQdfJoJJb5T7yqB7oMau1CDcy?=
 =?us-ascii?Q?SCrAlkT8HvX5acedgv0j/+1YKOgw0JcgiRJ3qmgc6aIt7NqMz/1DqKL6G0R6?=
 =?us-ascii?Q?6AybDHUP6TvN3cIToqZg/c2JucsobtCiQFFQeFc1LuZvRcr+KqXU28U034UI?=
 =?us-ascii?Q?v2ttAkitR5+BtBiROYUVxnuqf9A6n6Gr6wVawkXNYlbMj4YVg9/b?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cd1d73-949b-4b5c-eef9-08df1d74cb05
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:57.0093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8dz9OVRFEIMziF7TSCAootkIk/zDglBhnevwzazsat+9yWj200P4gIAEyExV8tNjKCuC2QSLC77UxB944/vqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

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
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Drop the *_ONCE changes. client_ready is now atomic_t.

v2: https://lore.kernel.org/r/20260910040836.3792333-6-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 51d9e9969065..d290e5869c21 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1101,6 +1101,12 @@ static void ntb_transport_link_work(struct work_struct *work)
 	/* Publish the link only after every QP has been set up. */
 	atomic_set_release(&nt->link_is_up, true);
 
+	/*
+	 * Prevent both sides from missing each other's flag. Pairs with
+	 * the barrier in ntb_transport_link_up().
+	 */
+	smp_mb();
+
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
@@ -2400,6 +2406,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	atomic_set(&qp->client_ready, true);
 
+	/* Pairs with the barrier in ntb_transport_link_work(). */
+	smp_mb();
+
 	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
-- 
2.51.0

