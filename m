Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745151;
	b=fmeaQKYLy0wMQtWfPlAhvQfTOanyl6UGJYU88t7ue4QO/VlSOGp6C/tsMLvqzCpjBxkV
	 bDFcGDf5LREf5/aW0MXdf4y58/bcjK+6R8AFjhKCZuQ1u8OruXmvg/7CwidR5KPxL4oFe
	 2gD1viKXPNVJMuyv/sQi+mo6Yns/hQViNr/HxOaCA+B8BWrISP+YS3TN/Ns5skI9xtxwg
	 hxlrbmDj1IfH84EmjbRxQK47I6+vEKqxA4eH0K1hsNtA4VkYdcRf6BTQejoCeNAvqKFke
	 F70SbLzhI8cDHCIrz3SZefeOH6jcxjGlImd3VdXwgsFkdGMWip8oSctLNSew84jlbug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745151;
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
	bh=cCmv351eArKLkMjue0atAdPongMrcn77j1ddmvkziWE=;
	b=HbN5/u7ZfcEnqsjtHNAF/QNHQAhvJ1MzTpDw8DFeDdqkuJzrUSSH5iey2MjYTN1BKCxw
	 Osje8p6tHyPu7/Ui9DuDcsfjR0kzMZo+D3hRZiEA9hdFzrgfRmNtMJKHdgYukQ6gjhwKM
	 dp0giTWXUJimQuU0V2dmY3f8slMWOaVSzFRqUB0A2DHCkXlq/disL7+BM4HJmh3KPCKQQ
	 SbHjmBAML68E5AjTr3I3ycTfRBE/pY1IuK5jNT7ILwHxYRJK+tuPOKAy0KZcylxkniCLh
	 c/yOfBaqKVVhVTSecDmASQTxiaDe94QMiiOwPINQViTOlXhE2lEWmnnFxQ2UaIrrDOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=il5ZW+HE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020123.outbound.protection.outlook.com [52.101.228.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E98606A323;
	Fri, 27 Nov 2026 02:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E98606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=il5ZW+HE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjPydl/fSQRiQpxG/+Wg/Ro/iIFsWvuYObsWEGCW+6Xvdv3zGKpY8ZtgX1QyOZsGflcbWNIPvU8ncLUdWQxkKGjNhZWuSKXVxXKxd1u6Koes5R8FFiEXnyuqrrwZgqWaKJ5v+J55rPDvljgPDflvez3B34fbhiPIltLjDwOe/57Tvn+u3jU/e6oYm2LzApP/miQa6p8HWOHLID0hPAhAccR4sB4mhsc3+L03VQ30l3wLe1DGHltzq3e5SvoziY0NMY64b5MFUF2ahx16j+wHixhJRI9a2jqfLYpzFtrDvyIl1tNyrCaYwn8dTDHK0PXHTgmJiUKlNTcEoeZ3ugH2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCmv351eArKLkMjue0atAdPongMrcn77j1ddmvkziWE=;
 b=qIEEiHAz7YEO8OtVQD/bD3Ou+9UfG/96DFXfH/sRv0qtaCS1xOohc8k2soYfjFTRr9rV5eL7ts8VJzJ7Kf+5aQlLl3w8i9NF/ARmMr1arCGSHf3hP/zgTEBRmQwuvQsD78OMvIhTeZD7OEqBU/nbDeWuccfAIWujhGP/G2g4+UK3I7VYMewclJWg1uBE8ecze8f7FnwbdUFMIYY0dxFdDkhCumJnIK6wUWqbcU1kut1q8nZ6PYvDj5rF9g5Cx+IrfiW1WjTp7oCKgHnzpHYfp7qSY9A7y4QvK6nzXmZoPfdGkSQGUZRFwgipGjI/gHt/zg7mzIW82227CeJmTP6blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCmv351eArKLkMjue0atAdPongMrcn77j1ddmvkziWE=;
 b=il5ZW+HECTa5FEunPcnENyPYoPTjfzRgt43dhyS8KMHJS67GdxXzQZOIh3qrZLbr12OLQiQCHksEOHuuh+fn3MqH4+bGtCurqbBeZbO8iEN7OKAsqw4bki/5gzt5fcocjynCGv91ZqpupXZBSsG+se69kzlQ1hdz3Fje6uwREgk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:47 +0000
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
Subject: [PATCH v4 01/15] NTB: ntb_transport: Remove the device debugfs directory
Date: Fri, 27 Nov 2026 11:05:19 +0900
Message-ID: <20261127020533.2481725-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0045.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 37387dc6-b1d1-47d3-7125-08df4c2af3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9xwxCadsmQ9q1M7ltS31wOVbBYD2YiXMgNIIn8CpI4UnR0xFN7qbMQKOfSYI+mFvnxHOXdLmGRP4KrMDYVE5/dKuQjdSAyI1Bt/CUUJIzn1x/GG6IRBcUL2y+ztAc3aaWmY5dXmF8u73B8ovy5ZrxB72ZwSpXBqwtgCn1AdlScH3yaCsnp3CQLW47SVoQrhuCGnpuoYNFQTRosOgy3tKn11706kkisCZbLva+aiZvf9M9IYsp4IUlDPvxD2HaQG83BLjv7YclP35xZHiAP04TPxNjckVv2BthwG8cVrf1HsxMSmVsvmCxtfwOhrZLnHolnzHWSF+4PG7lj/7WNOtniJypwIm6xzSrgNaE/wDfJR11FJeEhtc8JtverlKqsh9/fHntbHwXNosbywYH0iEB+KZS0hySfPq9smusP196bJ0d8N/IbEgq7gcPMBkBQ44AafZxPh4NLdDq+silBL5/1zg0hVMggTxrcjLJ9ORzjCp2qO/QA8v0WNf8aal0dPrQAqPf1e1Z2qnYvWPQ8v9aU8SfSKsQS0MqGXDjilsPwqXaiL/q2RmIwYgZSwZnOfYgfJo/5DOoMc0BLXTgjLlZFBVSq5Gszew8xDVXyKmqlt8Shx7nl8neOyQq9Arf46iyCZScURlRXHJcuA8bwa1fLIK5xkCQ4FlhYmbgywRY2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lzyf5bmQyFtfEcTXFlKm3kM15P7wxL3nyWvLZRLqruOQHovCyLxh3Q5gnEyy?=
 =?us-ascii?Q?/OdobS1LRB7ptYLFK1SZhtteiaq/g8TPpAY18yY8ghyqr7nI9GC1da3hrdUf?=
 =?us-ascii?Q?XVHRhBMqTipkzsTXwJANKpe34mtAtnL13wo1Wsic3b0Y5Zh3qjRP8hAYCO8V?=
 =?us-ascii?Q?gFHoL1i1J1Hxs0amtHzvWYO0EOjUU7sCZQUe0E1M/4elhRDtYwXNMqDJXB2r?=
 =?us-ascii?Q?nJdfKNMZ3sLSwQbm5Y3wKrPVXBj27wn1Gcssw48wl++boaKd+UCIOmX1nbt2?=
 =?us-ascii?Q?nF/q0o+Gh0QGJ546XOQH5r0mrR8FOozwHofOfQYEqzL0y1GIcvpn+0LK2Cx7?=
 =?us-ascii?Q?sWy30haiaR9jVxD6qXfMFBYzEtYx2YsXqlf6Rdb8Eg5TFudxVH83KYZc4kF8?=
 =?us-ascii?Q?UiWBL9OnDfA5CTvjQDsH7H3yEAYA5Y6ZOS+IJvyQVnKsRYwQCawJTkYTSssw?=
 =?us-ascii?Q?dmdv9inKeLDadtd0pqdPM7d7+dl+T1Dt7T3TQ3YIESJzwBZYqf1dnI6IbxwZ?=
 =?us-ascii?Q?hUVixFsoLbGz1KADcABmAbO2gj6pQu0ODzMmJTH1VuONhTmCWc2z7lZcrnyo?=
 =?us-ascii?Q?3pR2iNLXWo4BdXLdfKw/rxjMfRkfCjGU20BAVvlUJNeD2yrmLQ6Aa18fbmKU?=
 =?us-ascii?Q?jqH3IaDO9/a+bKMnsxvqPh6OJCXqK+PRADnik9dbmjXZdr5kOLlbIqiTbtTx?=
 =?us-ascii?Q?gVAZA6NLH/njTTv0wdvIRL/6WBzv3HnkHRuV3RGsHHohMvFg+62wErYJHfr2?=
 =?us-ascii?Q?noyWWHF9U4rqzDOYCrTFOz9FiJHwuRjyeRmkvFNIsRi8w4Ph3vgBSSoznVhj?=
 =?us-ascii?Q?w1P/T0O6fguKcfRLus6hXO6duhWsyBqc6Mb4AwRdDPd9PPn9hHgT6p2/j65f?=
 =?us-ascii?Q?e+mnevbis7FkVUL07SqdQrBXjTq6nm+YeZDSwkBZG1veaKCfgBO8G+Q0IdYz?=
 =?us-ascii?Q?VlErSq6HyyHIJBxrgi3ZLi/fPWW3b54ATM9uOcebeDIa+Uuc1G8qZRv4KBmV?=
 =?us-ascii?Q?uxRXEk29n6VekQYycZ8yK8LnNbBvWweGlqXT6YVM3DoMm/PpiQtYAfzxGmQI?=
 =?us-ascii?Q?C1rTQGbdkLs/MBroK8GM85yF2gaRhxkFheKTC1J9L2mINAKDU4Xu98w8oMOE?=
 =?us-ascii?Q?jdBkE1PATaihtSancj0ofW5mNDda1JLwclQ1o4jeYCvYWvmangUt4deyIhJ+?=
 =?us-ascii?Q?yl3V75GzYmC13zqNkwD+XN8h0J/b0MaAAZOKcvuts12VHsb0I3uql1pdlzXf?=
 =?us-ascii?Q?HLznVWD+3wd0l+E3xh7lpYiMB0YEnpqywniXxPJNJ3m8t5TBYuOH+/Lxpsfd?=
 =?us-ascii?Q?8Y7+PdIF+ByRnXxP0t+f5tVEkHqXg07sXyMsjqImb7NlGJirrlyBLYRkoOcp?=
 =?us-ascii?Q?nQR1nVTnI8B3w5RHkRHS7CTy/0BAKGVh7hVtNb9sfRMf9fANrKMy34ElnbfS?=
 =?us-ascii?Q?d7mvxuIexKd2sCOdBbW69WhH9mLUqAvkuNhDG70g/5yn8KF2Tur2a2bHvLXS?=
 =?us-ascii?Q?YBnBbmzMAqtwvf5Huv2i1igGIQDPmNpoCc8pOpl4rsmEBuR34trybcM2E3FX?=
 =?us-ascii?Q?7iV+3gU5ScdCErPI+SOf7bIgDZNDmpxfcuoF/X6ub54xuA9WxN98wU0KHzdW?=
 =?us-ascii?Q?0CsLLhmAcVempTVicg1myObnxI37snUNjGFsWw9i9iz9QDKRpNHLqFyYxpvr?=
 =?us-ascii?Q?n4U7XHRpVCyRhtnHzCUVtRdHCjlPojBQqz7qJFA4lxfvoeCz5pjBtMQpraVA?=
 =?us-ascii?Q?3rJNvV9gE+VIvKW8m2SfAMmSpxk0coZcG3cRljQfWWMq+xOD3uH0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 37387dc6-b1d1-47d3-7125-08df4c2af3f9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:47.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k46lsh924vQUB3TqgRH+WsP9J0QRbBepksvaWBE1Bcd0bCKKnv8YmCWau7X9dFkQcPz2gr6HM/eEak9P+2WA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

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
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b336dfc96c1f..1fa6e0ecac4b 100644
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
2.54.0

