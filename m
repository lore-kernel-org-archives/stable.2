Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DD4E80B3;
	Mon, 28 Sep 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609165; cv=fail; b=nd5eq6jvm0/TlUqEATYGUT8gGRVmXKmNn8bP7Ac7jlZn4yV3/YnfbDiFvhsrXx0FTaZoYokdIgW7PgaAWHkEMvFNRjIxsakln0L5TdscCiJPY8k0mBzvNnP1uDVyZSJxq4GsUHWy6zs5aSm4loNPDXH19AzLXybqEVfUpP1c9i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609165; c=relaxed/simple;
	bh=i2+Gl4IyidIgfvN6eZNJKu7TxkLWiuTNegZsnKP/F4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CE49gymbKDLW3XcAuksb4HquNDcoin2JzK0xfLHj4bkc4j9gvqNWtl/5yNouIGxDktMnh/M4ahQGjTnTzkDf+u/D93vmYZFAtgh5vKoVrge2Cp5bw2nc0KJS8HTBALcgTTMzq3MBF9VPQTtr3P6be0m1Hnf/oYUQNVV6kuI4NDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=n5Fvyu50; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="n5Fvyu50"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7GAD0khkxh6Dbmo6n0KCnvFAGmQSlURWLgGDnGWz2zIwSaZ0zMjt8TVpMyHO1ISHsdbLdfqMtpdmQEGk8mUut59y6l54SB4UA1jtx8hqa0glL/EmUpqXSQjp1pFRBvMYTc/Y6AjGE3dCVWZg1d69GCTv7Cc8lF/2j1L+eiCtOCplSeDdboDddC1c84DGmErXgScE4ecm4ZmvDhDfHqWbN/5buH7HCRo2Lz8obVW/UTkVzImjMSTrp8aGfcbuyHbObZPGfhpj2WoTpjq4GvTxaDKsINbT54d+ApWJ1Pmnw79l2VRZ7sxSPD0assSp/UFkCwMOevctROFfleIXv+KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FGSmBcEqYb4GEO0zKm4R0PUu7aByV/aS2oSpMunw9g=;
 b=hpBi/7fG4SiZsoHe/vlrslX4zzJM6N8+IsHwpW5J8RjsoCKqmWpP+QKjYwRyCrc/3DMSC2p1tvXutwLVbXYJIUP7DUWphNF5UbkjtTfv63WwtN4e39Qoei862WAIaOXwZvZK7wWxXt/xmAKtD4kDw8eETJvEauHv4WsozvzWvBH6xNPzwdgPWssbMdnwA+Q0Ai31h9jrZa4N1EkREDASI83J32FLn5Py2SX7PU8VfepLDKxmbdHl1ifdjSuDVTTuj9O0oCvDHp6O1y23TX3+ut1gyMlDTozuVo4xogTY0tOU8g1b7HRiBRn06DrRBsB9kDHeKGCoPYYjpYsIsXLxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FGSmBcEqYb4GEO0zKm4R0PUu7aByV/aS2oSpMunw9g=;
 b=n5Fvyu50uh2sPADU1iWqx7ZVkU1ozAMkkxHyCPOxez0uUsVscgDeYvOtwWKL6GKWoG02eDlOY0s9daT7CLvgCxTd4QrircYsdfKSgz6u2QXdERNevhilQMgGRbcrotlkSvmSx7oDy1R5bDBfSSIcoBKW5ur+heBjDUQshVvbkqQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:53 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:53 +0000
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
Subject: [PATCH v3 01/15] NTB: ntb_transport: Remove the device debugfs directory
Date: Tue, 29 Sep 2026 00:25:36 +0900
Message-ID: <20260928152550.3354675-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c964155-016e-47c0-0fcc-08df1d74c8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8Y/RzseaDvGkA7NGj4vZbp0JoyvOs3dSyEoXHcDZQtVlzL23+YAl5l7HNaQG351opNHmgBUb8EX9TpitHG9Q6giVf2rYOq0Kw6HL3aMjXn+WGo1i6a4hglTqfOzc0OfNouD4s4xqsiAC1TusHVy1QwbSKtz1EpvcPecqSvjynR06bbFGaiuLlgXiO2omW3a6RhO8s+d3exllN9RizmSKT/T9zKVqliqxMFmLOEsJTKmI+k24oWAoKuD1hvnQ+nI40VNgrpwy2dJwYVI4TSvQgVvJg8Qo27Z8qBO8tGZREWRcmZPSrg62mycv85TFPOYUhY6bX7th0uoppvSi0joTAIk8B6153wzAgLBIdZ4bRkhOrs5FUU0ZkP0y/HZvNSvOOF4IYGY6XOPF0j/qLwDUFZ7rfTCiDIAPu+nA5Q4lsqUNtJz5soijouYtnY6aVxdxpdeNlI4HIehwyK2OCvnYu7L7aZajGX9CKONqDnGTZb+axNFXccn3R/+Wf53X77LqewWXurGre3217YuL2cVosrJizBf2p6nn7UBrbwtotfeLsw+gGbK0ysvHxJIZ2Sb1NQbivOBEarUR3VbDNB1mIpRv8QWknWNsiSH3scdC890dp55cP57Lc90t51Q1tZzZWdkrm1j8JKWOMkdhlDbo4Lv8Td9U03Muppv0tq1iL0o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JAv0BxAI3mH84AzgAsXN1Pdbq4yZ5qqaAZsEBsbzaeV9QJmujpjA4WpANsiz?=
 =?us-ascii?Q?dwJVwk4NklMKYYGEEMMihs3QIIJq/VoCDi/auy9qaqpHEa7u5YxDc33v6SuB?=
 =?us-ascii?Q?s+9imLPE5ZrXE1zZOibfGCzYGszPxiN9ivWAsgKnkl8aYu0qLwmBbUYB5c0i?=
 =?us-ascii?Q?6PTlQSEzN3CHODvkOWfLYtUw9R8wUNOBHEHmdMDI33LYmJFYvJB/U0UsFocT?=
 =?us-ascii?Q?snoHeZY4OxUCSeuf9FnC4Z2YN6AFs5e0vOv6Wc9jz2YN+EZFCineSf351kuy?=
 =?us-ascii?Q?9OOhvpYfjL30UfLFuM5GCYmM+z/YnzPRtX9pNKZmzBLgoeDbLw+KqVVdofzM?=
 =?us-ascii?Q?w/Y50kDYS0vAxFKd6zgfwH5366VBz+61NLuyAlX6zPR0INEGcLrpjz+L47rL?=
 =?us-ascii?Q?W64gSjK2GKBgIYABNBsWC07WGd5nSOisaNbFkQsFJSjh7ZqdCWYj1ciUgzIJ?=
 =?us-ascii?Q?tgM/1ZUbM4jdtooxopLIYTTd5XXsBl5FEBSi4fHAy4A9X330X0Um81E4Hdrq?=
 =?us-ascii?Q?Vjm900WqIddUHprraU/ipUHDTba+hJ2X6d/mSCzxcjH2ngzEJ9R2Y1FeY4RP?=
 =?us-ascii?Q?8m2fS4Z1J86+mBFSLHlBB63Hfa7Hx/+QpL6eBn5Tk9q9wq/ZN6DkBnaMiv9n?=
 =?us-ascii?Q?QiRWZZ5zmmuPDWj0qYsaFwj5g98f4V7BeFrV6qQHvf6uDFl4pZTr5WPAKSoc?=
 =?us-ascii?Q?8O1Q4CgaaC18ORHMzaCeJVrKd8CJ04PtUdUnIZxoHUs3P5gLpWjDM2n0ZT1g?=
 =?us-ascii?Q?CGTflnY9gsTTCTcke4GOHG2ZqpBv6OEodJHtUK2/r0CYsYtl6nVzKhKxyLxx?=
 =?us-ascii?Q?z+ij7dX6XT18kzMf5zUz21MSrZSBc9NXexWbdccvsjSTmFaCPrxu20ZiC3Ul?=
 =?us-ascii?Q?/zl+EFhNYacsR1avKcivEzE0Fo2iURJGIIAM+3njC2gqnabepxKKx80LoHCj?=
 =?us-ascii?Q?jJOIdi3ZMa0OjE9f2pCqpV1TxudolfUPf5vQjMTLxtQ+M6Z1BEkQ/0xAB4Ci?=
 =?us-ascii?Q?og6gMNRB/ZxUWzU/wJK9Yv5JgujnrEhPaE8mXIjP4bF+N1MjAnGQuPwdwVa7?=
 =?us-ascii?Q?WZIs+HhBFaOrrXJCnRLr2eEaAkEYMbcsPlLh98gvsp76tY4EdQldAc7FUkcS?=
 =?us-ascii?Q?6q870eyqv0gBi6t5Lhd0oOGwS7I+ZbdI2dyDmpOuEuz5oaKLx20GUUbceP5S?=
 =?us-ascii?Q?/iTNifwye/tPkNR3YuonTJ9BjxQplYUsmoaqKZqfrv4L7RlnhZyHVrTf54oh?=
 =?us-ascii?Q?2EelsO4IxQkdlF/JkMkFEUbJEezxSz2/gFw47oMJver5oMxwj+jDqip4o2F6?=
 =?us-ascii?Q?FYlTufh49L1ZcxGnVBvTwLiOopHvLH2mV1gekBbU1SYSKEvq9D3c/4NeyQMn?=
 =?us-ascii?Q?rrqIs7WKwCUNgPpkkEmWxC6gSEQJ1dVk4ACFr9e586aEp/tqGFMn+jqm+dUo?=
 =?us-ascii?Q?DZd0VFWaMx0wuegCeVy8i2gCv348jVjj/HylPMcZ3W01Mak6cZmciCHAJvY7?=
 =?us-ascii?Q?nyW/lXkq2Le/+c8K2bpwUNcj+XWVRgrkyLri3jjDLH72JO2X0/3j6Kr3DvT7?=
 =?us-ascii?Q?Z90R9hSeSIhZsRE0y7w1FUfKE+EOuGzlb5gDaQj4CYTq3CTquxac6BlcdrgL?=
 =?us-ascii?Q?ecn66mo/wd/plPr0aYfsu7wjOuvIY2984vszqq0iE5g47d25W5HtcrWGNQmQ?=
 =?us-ascii?Q?Xhm83AkOH2QC7KvQJfqaOMLJuDyMpF/EbSxJu3ubqYfadXzdIr1SSoVikkI/?=
 =?us-ascii?Q?D/MZLl8VVVG/fyrGeI9qqTY9FLjKTIYfTeqw3rU60y5yv4JdjC7F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c964155-016e-47c0-0fcc-08df1d74c8af
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:53.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNJJGB3UQJRX9DOkUSBYsTD28ZCeKXsbh9KffX7V1T8vmXdTAxMyhAMG4JHwjwvUIQOBo24xsvPoODna0fTPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

ntb_transport_free() removes QP debugfs directories but leaves the
device directory. On rebind, debugfs_create_dir() fails with -EEXIST
and QP statistics files are not recreated. Module unload masks this
by removing the entire debugfs tree.

To reproduce:

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  qp0
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
  # ls /sys/kernel/debug/ntb_transport/
  0001:10:00.0   <-- should not remain
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind

  .. and then dmesg shows:
  debugfs: '0001:10:00.0' already exists in 'ntb_transport'

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  (nothing)      <-- should be 'qp0'

Remove the device debugfs tree on teardown and probe failure.

Verified that unbind removes the directory and rebind recreates qp0.

Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tags. No code changes.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..3389d6ca9ebd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 err3:
 	ntb_clear_ctx(ndev);
 err2:
+	debugfs_remove_recursive(nt->debugfs_node_dir);
 	kfree(nt->qp_vec);
 err1:
 	while (i--) {
@@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	u64 qp_bitmap_alloc;
 	int i;
 
+	debugfs_remove_recursive(nt->debugfs_node_dir);
+
 	ntb_transport_link_cleanup(nt);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
@@ -1412,7 +1415,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 		qp = &nt->qp_vec[i];
 		if (qp_bitmap_alloc & BIT_ULL(i))
 			ntb_transport_free_queue(qp);
-		debugfs_remove_recursive(qp->debugfs_dir);
 	}
 
 	ntb_link_disable(ndev);
-- 
2.51.0

