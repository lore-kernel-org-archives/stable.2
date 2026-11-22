Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795332335;
	b=qTQopgK7eygEHon/TkdyCBC6Q1RHij32e3wH4x1JSYty41XKC5na2yIrn6leti8M4rCV
	 SwMXCZwt09X8y1UxEKIIxAneF6dL37i2mv9T9SIM0frycC3gwQJlZt1oN74RXjEn72P7y
	 Jt4InnGyNiJycUOpimXlQtB6HEENUUG9BAKJZPCmo6ncYUqd99Xa2ToB11JoM4r+Hm8Jp
	 mXGrHyAXoETii4rXP5TtZTsQA5DBbRnb2+Wzga2K1ePdU8EewRM+F5b7422dRyd4wUXbY
	 V7VfwlNeHRyNFVgiqma6u3c9C8zfdlJ2Mwn2iYh2SzMTLUnapJFXtvSl/tRsEFeA5fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795332335;
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
	bh=EMY7DJIOerV5r7YOeatV6kOfxXbiHjnusDoSrKo5ls0=;
	b=zxAbUxCqZT5SkJacLfiYiG2DJnjGLRumUcMTivIT5A/6T87ob1hiEvKOPawKnSElVCQW
	 KV+FOQRBUcgl5Gj8FgUZ9mQDYDW2/Qoig627KD+JjR8qv6kGDqrzUAyvqoASfSnnIOj2W
	 yUZSvh18MbeDHK/VBWZWWn/kh06J0wOygXFMk4X77Ulbj08GFFPCU7RkbLkLUkndT8hb3
	 7igl5sUZjiVrUNc2emVf3NaUrCchq43sxC4oapV2AazterZrdWlKrliobKJIzVrvAxk07
	 51EEhDhQmvsftd0Sx9adKF0RDtVgDg4qL5sn0ozuKCLX6PXnB3mc6TeuPvY3sOLwOCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="tmQrm/11";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.5
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B50606A320;
	Sun, 22 Nov 2026 07:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B50606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tmQrm/11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N32h2TGmODo3vw21t1HBXCEuCYz/rLwILEQ8nJxtv/W8BgIhjNoFW5VlpzwBGrEtqvlLpFP/EzFlkl9EO50UU96VVq34HQ+C3SPA64zmhjo1gdGZwEfJ2gHVrRtrxHruvm+Ji1t2h4sWUB8usE5ZRa16DMl48918D4VHZ5MHxtTqOpEAGHJU2qhBigoI5kzyIZOT6gABCqZIgaDFx0y0DS90A4oB9MjTn84En24qnPfgIh0lRyi+Uic9JnhxEVxTl/4WDhOPlMDewQ9jhS8qKOQYEkmefgnnZsgHFM4dHX2mVd/EZERi1AoS0uGDiRF1a3uOR+uc64ywUT521Lnomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMY7DJIOerV5r7YOeatV6kOfxXbiHjnusDoSrKo5ls0=;
 b=P9Sd09211tZlzFDpTe6iTZ4NCOwc/r7WZfPWNcZzBFXT0SNShLG4T0FzEQaLLbVh7fnSGNzgDcbHp7bq/mnFo7DXQztCoKTNRf6DVjbaVYfnn+XAOibfdo+NYLW7mFKT5lTbm3QwDFvqrV4AC6YzFkFxnIEXYfAjA02bCD/0bvEk2h9QkUgP9ZohaCqNL99ncudPKn5LSj46Wo3se3KH2a3570yxSpRokmcRQth4g7tjCx+x2MiwT7inqohmYfB0aw+e1uXkzbrDotacEFFDRQQMN2+x7QOZno3CUK6wnpxMCuk9I5mZO37MzSOTYAVUvCeZn4AAhXzA/KvG3uYI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMY7DJIOerV5r7YOeatV6kOfxXbiHjnusDoSrKo5ls0=;
 b=tmQrm/11ohSM/JSCeOZtpJQT7ehkyCcLjbCbUsOi7+RCHL21EcMTAfpMGXq079uXHqIm2teNJfOe6fvOZOWNaWttdCta7IUi7dq+C5OFKhA+omkLn779UUs7swkKgKoRpOA98jCtbop4JEYLpK5IJqSvisNZFsU3ZzCBPPp1ZIoWq6YvXnM3NHehV3x8JbAEd2qUZbJqYMSuOLNn2YewdwSnZdii5o/CLOEZdrPNCxZB2A5aKhGTqJgnacpgD0z9G/xjsN5pWdBiJYB9Cn9I1XjzUh31rtSSqQcBFgitabEVzB2AYLPLHnKTriDX2o74XmTBo5MTUXjpEoVFJX9nNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 07:25:28 +0000
Received: from LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96]) by LV8PR12MB9407.namprd12.prod.outlook.com
 ([fe80::208b:424e:47e9:8a96%4]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 07:25:28 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	willemb@google.com,
	horms@kernel.org,
	razor@blackwall.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	bridge@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kyuwoncho18@gmail.com,
	Ido Schimmel <idosch@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] bridge: mcast: Fix source list rollback on failure
Date: Sun, 22 Nov 2026 09:25:03 +0200
Message-ID: <20261122072504.2623702-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9407:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be2a8c4-09cf-4616-2131-08df4869c832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/XABfpr/Ye//dlEz6zLWkF4K0vEmbstnVKZyWHkufQKziJ7kQgO/n3cM1ORSYiZffCVJuM3S9RLAxmINjIt0M/BYv49sIHC9K+0q2QAemUIz+L1zlPJ0K8yYvig45SC4M37hfP+jaIuYgSuNtl9MkzcJqNwhSIDYXSszIL+Ksm+kPbiPh12Hugfjznp2olapTPY30cLiCL/ttYDSjEMBdU4O1OhcrhehdrSUvZ67Epvx0qH5AWkoG+sZNaDGyJo4rPRp1Bqa+UlL+cYHJ8yBX06A6eIqFtTi3k3k9bW2mJNhIcq77Gh37DG3QkIxB8Qr/geQcwHQsT2WifIhbSoDB5fC+l/FqyVhjooqz+TAFLQ2v74bNofpKhHV5sALpwZHgGuA7l/kKFoCScGpl9u+eVl4Eg4yCNv1wkvX0+guveeaCzNh4GRNRXke7tCRkv6X4AZHVh6XHDG04ieIiIgmIV5cBRvY1VkL39uSBjpT0Mise5LR3egfXAwQyCoTGaxZxPKVpHp4+k5y7ymP0WCnOS8ED5P5kmtZj6Xx/rwIsCIan6FbGI+CsW8phiQ41cXPTPUOW+etzHqLDqvrOJ8z0Iy06OTpLONu/4F7Yzg1NldwiRd8UeOdwGrYwvFZJXEIcTygwg6FJWwqjnhFQtFALXwe5AqhtMZzMDVwKj6P1cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S1jGE0q1MxaA5tQjY1Eeto6mfjg9v40vzfztnzTLFrzOcx6UqQShMWiWcgjY?=
 =?us-ascii?Q?T8472M2z+okBcIlnBZWrBnznUTAw0BhQiLxaRuzN3QwZ/Lkbn+pDOfv4X2w+?=
 =?us-ascii?Q?936rW3OEHI23HgR8k4Xg/LipCg7unmUSXal7RpCvmvVlReDsRaLvrTJpRgcA?=
 =?us-ascii?Q?gdFnpGD9akPy/hDfTMeJSDGe23Ky/rOP/Qzp1ocssk3LkCEkNTZws0Xb2Fpq?=
 =?us-ascii?Q?sNLLb+jXdFNT9t7oPlPm1ePPBtm3SneuqeaZLUiqVQQmZuNNjvvnnQuwujRQ?=
 =?us-ascii?Q?w80AOAb6xOX5o3dgmiT09CBFZG8Knd+UflE/4cNRWqtjVYkKYkhST+1zrHuW?=
 =?us-ascii?Q?c0uUeoXHw6kc5aGAH8idL9+fdWjhkTAjUn/Wnhs4wOaGqk4BKO4Wf5gBhTgR?=
 =?us-ascii?Q?Dk6BmgBI4oaTdUwh/GQmdLLhCdqzGljvxB0V0KnvZnf8ti3tYVhmv5g8RvQR?=
 =?us-ascii?Q?8dP6rEjBZSuxEsT7g1RAaGJJ2RltxB4wztWFf/KOt/cMWSuhAUNZdNN6QOUC?=
 =?us-ascii?Q?TItZPa8Ffhth3QV+DS/ylHWdtJXgteIMaifclNP8OnsUl1uDBlM5wB03zNjm?=
 =?us-ascii?Q?/fN0HmyqKgYn/9baAF1Oyo3f4wS9EiOSAB39N0dwfyxOOLlI8ItigTK+gJBx?=
 =?us-ascii?Q?mnhbDwS8IjhRWRhy/BLKago7lp51vUgp0pJase6fYxPHJnWNL71DE6g3q9HD?=
 =?us-ascii?Q?7eq8d1dskaMAgSM/9Cm4xnKAf4NdKY0Ze0wuKJTnjNFzJQw8YcfQLWOUCa4F?=
 =?us-ascii?Q?5CrBMStzRDhZ56BxKa2Zy66jQx0CZbT3PTeVAi9+U3FEgvraDjyZae2gbZWT?=
 =?us-ascii?Q?aXd1cUfGtx667++3YxdYAEbfX7xQrgodcxjIGtdWRKpxZZdcK3C/jvskJNdS?=
 =?us-ascii?Q?9GwMSIDmTqD/BJtUrua5v7YCPghUeZYTmhU0MHIpx1X4lmjO1O1X9BwLDfAP?=
 =?us-ascii?Q?M9/IuRru1Dykzy4hkQr73t6MBBHUekLMChP+aM2QUzM0C7GFTqFeoNzfkA/q?=
 =?us-ascii?Q?1Yu5sUU0g9U12iEOJoBmsbZBz+Fk+lWZ8Xg0Y/1DWSr+YG6RxNPSqkieDR6a?=
 =?us-ascii?Q?uXrCmS/xHcBOUKR1rqnyJrp94mKw2IIukfPQB2BV+UgddhUscyEmCRJcPSa4?=
 =?us-ascii?Q?EA4srYFLMfVbJ4bISGH40eK9715Uug9VU5bZgL8B6CZIBpXtg3Q5Ax3Z52Pz?=
 =?us-ascii?Q?CAuL6itQLqJ8y024EAJIE3pPExtvySILZoVMD6/XrvBZNA/2wZOgVcNFwcLA?=
 =?us-ascii?Q?FXLARHvlGbAXxF2YD2YCCiO+TO1ckYizAB9TXBi/X9b+WtZi18Y8FdF1+N86?=
 =?us-ascii?Q?fKyp4lMhcNdeIwPSCTKl1vm9bo6EYEc7t4uWahyGNVktvrxcdw/pYEZBr4v/?=
 =?us-ascii?Q?IZt/IiQK69RbHt0SpJftW8ga8vuFTWvvKG+cQZ6ZYnvR0kdWd1eaozOJRiJ3?=
 =?us-ascii?Q?srcj8rij8ApQVsuA5BgqaKphYkoTb3GZwPDhUhANTzG0RrLtJh3G6JtmX980?=
 =?us-ascii?Q?OJHiwhTxhCxDtQPmtIweeLi87f7veD5AN8T2Xy0ty78upupB8UVPxm9m4vdu?=
 =?us-ascii?Q?R73cTBZB8UHXy6zVVkfulKTLKdUVJowG3xOg5hGCznny6U0iYUiM0P7lj+3T?=
 =?us-ascii?Q?k6Ki1ASsLaQwEPlqUJZxAwvNtrfI4ZuE2TTRRJ9vM4+RS6U6xfoX+uacM37h?=
 =?us-ascii?Q?dBMdEKXUu0MPbtUrGHFU11qP34lbhBzcY75rhxNqL2s0Mano?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be2a8c4-09cf-4616-2131-08df4869c832
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 07:25:27.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIm74rqKKK+6vCY/eyR+BzX4wqKSq6Z7dqWJ4YLzIjqPzWX12wJKYwYHzsGYeruagD9njTZeA7zQUwXxtu6gcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

When the bridge fails to add or replace an MDB entry with a source list,
br_mdb_add_group_srcs() rolls back the operation by looking up and
deleting the source entries of all the sources that were already
processed. This is wrong for two reasons.

First, with NLM_F_REPLACE, a source can appear more than once in the
source list. Its source entry is deleted when rolling back one
occurrence and the lookup fails for the other, triggering a
WARN_ON_ONCE() [1].

Second, when replacing an existing entry fails, sources from the new
source list that already existed before the replace are deleted together
with their (S, G) entries instead of being kept.

Fix by marking source entries that were created by the current operation
and only deleting them on failure.

[1]
WARNING: net/bridge/br_mdb.c:901 at br_mdb_add_group_srcs+0x310/0x440, CPU#10: repro/304
[...]
RIP: 0010:br_mdb_add_group_srcs (net/bridge/br_mdb.c:901 (discriminator 2) net/bridge/br_mdb.c:924 (discriminator 2))
[...]
Call Trace:
 <TASK>
 br_mdb_add_group_star_g (net/bridge/br_mdb.c:1021)
 br_mdb_add_group (net/bridge/br_mdb.c:1082)
 br_mdb_add (net/bridge/br_mdb.c:1097 net/bridge/br_mdb.c:1360)
 rtnl_mdb_add (net/core/rtnetlink.c:6925)
 rtnetlink_rcv_msg (net/core/rtnetlink.c:7178)
 [...]

Fixes: 61f2183512a7 ("bridge: mcast: Support replacement of MDB port group entries")
Cc: stable@vger.kernel.org
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/netdev/179489219555.3099318.10297266282803881244@gmail.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_mdb.c     | 29 ++++++++++++++---------------
 net/bridge/br_private.h |  1 +
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 0adcd1524ab2..be65976c2f32 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -867,6 +867,7 @@ static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
 			NL_SET_ERR_MSG_MOD(extack, "Failed to add new source entry");
 			return -ENOSPC;
 		}
+		ent->flags |= BR_SGRP_F_NEW;
 	} else if (!(cfg->nlflags & NLM_F_REPLACE)) {
 		NL_SET_ERR_MSG_MOD(extack, "Source entry already exists");
 		return -EEXIST;
@@ -883,31 +884,24 @@ static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
 	if (err)
 		goto err_del_sg;
 
-	ent->flags = BR_SGRP_F_INSTALLED | BR_SGRP_F_USER_ADDED;
+	ent->flags = BR_SGRP_F_INSTALLED | BR_SGRP_F_USER_ADDED |
+		     (ent->flags & BR_SGRP_F_NEW);
 
 	return 0;
 
 err_del_sg:
-	__br_multicast_del_group_src(ent);
+	if (ent->flags & BR_SGRP_F_NEW)
+		__br_multicast_del_group_src(ent);
 	return err;
 }
 
-static void br_mdb_del_group_src(struct net_bridge_port_group *pg,
-				 struct br_mdb_src_entry *src)
-{
-	struct net_bridge_group_src *ent;
-
-	ent = br_multicast_find_group_src(pg, &src->addr);
-	if (WARN_ON_ONCE(!ent))
-		return;
-	br_multicast_del_group_src(ent, false);
-}
-
 static int br_mdb_add_group_srcs(const struct br_mdb_config *cfg,
 				 struct net_bridge_port_group *pg,
 				 struct net_bridge_mcast *brmctx,
 				 struct netlink_ext_ack *extack)
 {
+	struct net_bridge_group_src *ent;
+	struct hlist_node *tmp;
 	int i, err;
 
 	for (i = 0; i < cfg->num_src_entries; i++) {
@@ -917,11 +911,16 @@ static int br_mdb_add_group_srcs(const struct br_mdb_config *cfg,
 			goto err_del_group_srcs;
 	}
 
+	hlist_for_each_entry(ent, &pg->src_list, node)
+		ent->flags &= ~BR_SGRP_F_NEW;
+
 	return 0;
 
 err_del_group_srcs:
-	for (i--; i >= 0; i--)
-		br_mdb_del_group_src(pg, &cfg->src_entries[i]);
+	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node) {
+		if (ent->flags & BR_SGRP_F_NEW)
+			br_multicast_del_group_src(ent, false);
+	}
 	return err;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 014d0b8db8c7..97ad9d7bab27 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -347,6 +347,7 @@ struct net_bridge_fdb_flush_desc {
 #define BR_SGRP_F_SEND		BIT(1)
 #define BR_SGRP_F_INSTALLED	BIT(2)
 #define BR_SGRP_F_USER_ADDED	BIT(3)
+#define BR_SGRP_F_NEW		BIT(4)
 
 struct net_bridge_mcast_gc {
 	struct hlist_node		gc_node;
-- 
2.56.0

