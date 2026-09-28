Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D454EF156;
	Mon, 28 Sep 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609184; cv=fail; b=Zg+q2wkPJbTFCnenetCi1hFSt47q5eboM2EWLn/twHabfjQaC6Fu97v5tdpePofz7CQn0cecLzTmuZ7mmwN2dDkXQRvcWqFBEnMa0PpAZ+Cg2ud8W1rwfs51+QLRCWtUd65i7t/K65I691mgmViYc5PQySIIDMBJdPKNKMSLf0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609184; c=relaxed/simple;
	bh=vqDTbhhKbHdTL0Grv/v9Y7TuISG5MkxE1/v1rM/UM9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpeiNkGjNAL85o8jD+I2cGk65NBN9c4N1G94jaT6aZ/AUEPTKn3ksqKGxuXVlY5T2g0vIN4R2MKvcf0pG6iMjujsm6mibx6USmYq2xQZtAExZpaZGiGRVS+JHZWEgwWiFlntRJCDwkLIe4hEdFX2kIQOKfTwQhtKknW4siqgzps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BIfm0m09; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BIfm0m09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxEnpKgQ1m41ZmSHzkJrRtEdf4AoBqX4cHdY/Tz0hrCk5InUWkMPBA55A4DN+bRYe9Kaf3C8zbbORYxhUFGzHN8WcQMQ7w919E6y3Z6II0rVL0Egc4VbbeE1ExQysjxKn2/3+N/tjK6fMMFhvrTqeg46nT93rWIuuKTlctaCbk08OsMYeDBFU1J7Gp3GlwzikiTaNVxCnrsYCwCphw64Vh+y4aeYiTt2xSvqyMhz8tvfvCpJDlCrWlLCv1wbmUJGgpzAWjtnLGkE2kwFue6L3gfcrGNG6TWsQWZnvB4L+4QpXvDeYFQ3YTPV/1X5xqw5GRXePZRtQiFv5ZY5ri93qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqP9VjIM0+9uC2reIGZN0nboAIPr1ppnlg5yBmG5nfk=;
 b=vP0ftVaR8dMBVom3wk8GgR+Zxbi6FDZYDpFbxkuUfW3B6MJ4CHabY3BLGz98W5ZOlcdk74GQMZu9gKXrykLPQeB/wugt1+l1osixQoendVFOvLm8p/UIzoD6/2K1QxfZJOTMxrq6G9YNyVyL7JXw+tXtpXOIqH/JrrZhQ45mudr5fnxOSq2XsIkZnk+UdCMasxv4m7YA9JhszMW1mNHF6qbLLla06KpBWrtgJxsrtYZXc01MokTln3BJ9ym6qNUtMt04K3lwNp6zofdxY7kVxLhe+tHvJxDFplPnvfVs7FiEDbnP5SI7O5Z3OANbPY4bGwyoFHqJgAi7Yu3KtL618g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqP9VjIM0+9uC2reIGZN0nboAIPr1ppnlg5yBmG5nfk=;
 b=BIfm0m09eibt+AhCl1riAy+Qj/o+7zQe2+ecaZbn38K8tOUKNXmOZ//zAUcN7H97+KxrpJQhcIHYCYcH/3ZaIqb1XdBxtBaCJ+KCLsLoYlIgkzwbLD9PLwH/4nLRQH7SctqjH38fdzS2WP+lIJ7VhqIZnj67p2i0zJM3iCar2L8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:26:04 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:26:04 +0000
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
Subject: [PATCH v3 15/15] NTB: ntb_transport: Remove clients before freeing transport resources
Date: Tue, 29 Sep 2026 00:25:50 +0900
Message-ID: <20260928152550.3354675-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0168.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fc6cf7-5cef-4c41-a8ca-08df1d74cf69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SX4/zPXQEo0PvlYzEejqTz3a5dqhH2WGW4zw2XGtDe2k0BWWS5cTvyX5cIjJHKrOxl4RX+DxFcT60CRehVY0jQk4HUg7yqLkK/LMxwUC38tnxRdMBZed+vfr+qqq1MjvT+t0hKQW///flbz+x1JZXPk1r2uy69Eddyw6AYKiVGgsqiyzUBL5G0Pjye0CNkL1ci8OtK3zIj8SJ8EiHTIgcg7HcHn1orjQUg1TtW0Nd7biEgK6Cn6a86ADk3vjjbTqsfbk5ZhLRPUDRwdKmG2cBBJbGzHXHkkbIi5wRC2CRMzMzeTLwI62YEbBTPrUfbgg9qZlBWgy5OTctiZLUTIyadywDKNhuzM7DLKiBWqfN+9MGKzxz/vLlw+zQKGis0Tq2IU/zR3aaHXXrXh2vlpxH7CFgNclIK2J8a1MAIh9ORpFElVl+aLslufOKUp+oVh9Epn6+NrTix2GIMK0eWfc544WGdUTE4k44Aua2uOjo8JHdxLy71yaCKMy8h1Px19a9dgbxKTDbEnZ+imOKETSEcESl1X0AThxjng8WEQttKs9DBV1Aa6SqSPn3TEvjcqBngueBoIpzNOyNJQaPaSwmmN4BgdoJ7/a0wTTao3nZNF3L5qDUHLDttemF0OdbMnmLNfiOwx5gnM+4MgyOdYIvSykdvrs3B+5mvFnTz2yJHI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOmUNjjHhtIEy6/Yi7KMSjzixSR95EOLk2PEe6EnhxDaF8pscX7gWVSnf4KU?=
 =?us-ascii?Q?FuyBVAklLM3K2tHea62fgfd37CrWVOpefcASrduARF2PlBiVrgGgzommfS+W?=
 =?us-ascii?Q?A8PvaF+2jObrIqoKw+k9OLK9XYTpENeYB4R3P9NO+z368CgqdJR1dHrp3yr3?=
 =?us-ascii?Q?9ieoJhK++kLXj6rOu/1WTnkABd6F6FbzT+CDkGa8bAoOJJFVtjPQbP4K97NP?=
 =?us-ascii?Q?aQZ0N/GWvu1qZxfr5h7/wTdEr+fggVWIfJ49R0nMw7ZbCoxrkfOTbHjAbYLS?=
 =?us-ascii?Q?RBlFFlbFdhCpI2gOrJGzP8CyDN+r54zdL4RO6KG/kt8XaL5990yevD/9QAt5?=
 =?us-ascii?Q?aZXmu/MnLzWDTSP7AVpYQq+zFfEETemBf6TVIJ8sUG9pZZ3FfbXJ92LeBv6v?=
 =?us-ascii?Q?r67PUMwTyIrre/WTzwRhtLhJSHG4l+6dZbhNifBC3q+aM0HjcTqoNKZrmrF5?=
 =?us-ascii?Q?4AvStomK/oPfeSCDKjShx2pYs3j2YTYrIsCHwe+Yx7Y7n9D2OTzdczDPKQc3?=
 =?us-ascii?Q?/lE4A0YPG1Dw1j0WB4KCFcfHllbaXk61yVK3FFTQuoQ74AZiNG0aNAWnxa1A?=
 =?us-ascii?Q?imqQU2GlDR0zQQhoh3KRpwvLhFx8YjbOkp007aXrBntz6lrMHQl7Clw+kHgf?=
 =?us-ascii?Q?bTqxmWxLIJ45SmrHMDbI99IETpSwlJ3UPRCL9pFJ5gmXtBBk8y5/2xjUA+m+?=
 =?us-ascii?Q?K63HXM/dTHLc3M93j64WWBKdW57pQ3XXVZ59LN09D8WhJkk/+Kv+jv3fKAxy?=
 =?us-ascii?Q?JGnkJDbwL6ZspnIDt+Ixsk4tUyIK+dFvF+FJo5IdBSEuC4n/MTcz9STCba5G?=
 =?us-ascii?Q?/jdOF749fOnnCiw+d6gWb+GsAlymu/QzWp+ncPj3Q5s2RLjlAl24NRa7HTCT?=
 =?us-ascii?Q?Bhlg/E57Dhnvsyj8zFVJU89yYj8NPD4Cv+hhTlBNM8M409VkU5zlTApPK3gG?=
 =?us-ascii?Q?Ra6y1be/CP7hYmG9VF3sYt6hArxTc0/ul3I1RMiPXGWonfCnajGu6pVVQENO?=
 =?us-ascii?Q?REt6nPWdlnLWKKSDPN3XawqETGn0mxcoBpA8S/oFFqRqTtMzdxt4aKY3BoJl?=
 =?us-ascii?Q?EuepZxvxSMa782hB9aiN8U/hdosdAlrsKctblXHTVSELW8BQIDwVgbxF0P+Q?=
 =?us-ascii?Q?8LYlZIqQ90xwH8VWkZm6oFNzctqtBb9OWBJMSuN1ww4MStxxWbKelwR3qgAP?=
 =?us-ascii?Q?vqGEypyNhFnQGyWTKErPzvLuahAGoxNzfi2Pt8UBV8uPAkqRQ9u4arO5uEEO?=
 =?us-ascii?Q?ANt69Ud5w/AK/GRx2SCAkjeTF/zxDxysdcOSqAjP6H9OUlZrj1ysPqtUF9hB?=
 =?us-ascii?Q?7aEUoKRTrRUBRrbAgZQ58rKEuq3w304dri6AJxUFgtKVSB/Jfe4oIGq+yewe?=
 =?us-ascii?Q?QPKpo3CeFhLvBBT9yXlwZqZPImt1WdDOfUhOVRdBxaGnkIHOFg+UmAtleAhI?=
 =?us-ascii?Q?aqfHCzayG48ZdJbfyRWQsxUXRyUyHHocMwgcVwmDQl9fsPNrnbLkS6wHNjHG?=
 =?us-ascii?Q?GvUO0ByjxR25DHEQ+6u5xs+bJkH6niCEox0HE2ZoM9fuwbEvntBPupam483p?=
 =?us-ascii?Q?HNTgsePUYZ3J5oF9B4wG9VMaMq1gOS5iNwKdNR/ZN2Y/0l4gIybgG15EtofS?=
 =?us-ascii?Q?lfgIjzRr+1UQ1/wFP9QoTUO9JC2GiNt3unoPskUJnm9lPrYYiFdOs3xu+B0n?=
 =?us-ascii?Q?NVLqAWgW1bjl4+HC5gDgEY3jpU/WqrCDsLnAktB24lzOTF7dB0zALYID2lxr?=
 =?us-ascii?Q?m4nmxnEr5mUHQYboZg2kBaK6vL2xKJR8NpgzzgIjJm4kdpnXxib2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fc6cf7-5cef-4c41-a8ca-08df1d74cf69
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:26:04.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/blMFGZ+JcxHsDuRqI8MkEHY7JCeFMjmG99WWjfKzcr/BLd16W5rwUqPgWYpRteAzov0hOwIKaVHGSXtda3kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
is still bound. The transport frees MWs and QP resources before
unregistering the clients, so the netdev's transmit path and timer can
access freed memory. Its remove callback also calls
ntb_transport_free_queue() on a QP whose resources have already been
released. This teardown order is unsafe and somewhat unintuitive.

The crash can be reproduced with an intensive TX load, during which you
unbind the NTB device. The following is a KASAN report from my
VHOST/HOST setup using vNTB.

  VHOST# sudo iperf3 -ub0 -c $HOST -l 100 -P 100 &
  VHOST# echo $VHOST_NTB_DEV > /sys/bus/ntb/drivers/ntb_transport/unbind

  ==================================================================
  BUG: KASAN: vmalloc-out-of-bounds in ntb_transport_tx_free_entry+0xf0
  ...
  Call trace:
   ...
   __asan_report_load4_noabort+0x1c/0x30
   ntb_transport_tx_free_entry+0xf0/0x130 [ntb_transport]
   ntb_netdev_tx_timer+0x78/0x260 [ntb_netdev]
   ...

Disable and drain transport link work first, then unregister the clients
so they stop using and release their QPs. After that, free any QPs left
over before running transport link cleanup. Disabling the work keeps
link events from restarting setup or cleanup during client removal.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Reviewed-by tag. No code changes.

 drivers/ntb/ntb_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index af7f240479f4..eef3a214d91a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1484,9 +1484,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 
 	debugfs_remove_recursive(nt->debugfs_node_dir);
 
-	ntb_transport_link_cleanup(nt);
-	cancel_work_sync(&nt->link_cleanup);
-	cancel_delayed_work_sync(&nt->link_work);
+	/* Stop transport work before clients release their QPs. */
+	disable_delayed_work_sync(&nt->link_work);
+	disable_work_sync(&nt->link_cleanup);
+
+	ntb_bus_remove(nt);
 
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
@@ -1497,11 +1499,10 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 			ntb_transport_free_queue(qp);
 	}
 
+	ntb_transport_link_cleanup(nt);
 	ntb_link_disable(ndev);
 	ntb_clear_ctx(ndev);
 
-	ntb_bus_remove(nt);
-
 	for (i = nt->mw_count; i--; ) {
 		ntb_free_mw(nt, i);
 		iounmap(nt->mw_vec[i].vbase);
-- 
2.51.0

