Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E04A0F01;
	Tue,  6 Oct 2026 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791304475; cv=fail; b=V2uwFv4KToVK44s/TKcdWJaatQNs47vivWNt7XaHHXQRDyxKeXUZMLxKP0v7hQyGTx5S5LyX9o9MNqeiIQdLlLc98wmBO+4FaZlNI8ZbPFszguvnTy6DKgfNqje17j9h0Clhj7fvhC8EVbtSaMQ3F01Zq2qYPOzJa5gHy677IA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791304475; c=relaxed/simple;
	bh=S6gys1W6l98XfGNfHKzkNX5uPNYXgCcTbmjBhMRwIA8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h28VQwUGvwCGVmjYI6TMGi3xxvX4XSFls0GuSy4SA8++ogkmg27q+FVWmkOPNJkEdvwo7/5xo/9n2SqAKoqtSRNbBpSyPpN3P4qFHr/I6jjBks9gbTw6rNfC5qFv/kQ+ncoIWSTfuyynqiCwO9B0/ZWxD2L7tMQjqW6kHXMfpiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=eyzWJUI2; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="eyzWJUI2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwmMaH2wEDHsEMdt8YR2lgSM5/MYhTj+dyc6ZPY0ypfbfcS/intpwqM/teETiicQwYzdAJ9b3OLoM9Dn5MgZ8KHc6br+Y/PkWFchLSfb3xZKLyi1bmljhQljJJzqUm1rugRyswV0R223shPNP6NR14hpwabGfQSIEScMHXII9YCFIl0CD/+H9m6FV9XUQkSvrJwvr9pSbOjHCuZuQ/yrOW9gJDgeeSnF8mqfnieaBioY4ILVQVCnYa/6o+1jhIu22NkMkomOHZwd65J65UFg8LHocxlWOWVICA6ferYvOp0G9PUj3srXltwldTCpGcqttq0/zWWL02NrJas5GXjrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OxaphSh9OHqUGgjs4IJ7W2uOKFI7yP7g6SNyO+K1N8=;
 b=IlLhTRhFx6IIdcWsGr1K6l6PRMvyZ2ZGTmMBHMp5XXQEESH2PEaTPHBF/P0xBleooSOyyPbsYefYuqPJU7FEMhtH6PyPBB1yuGFubS84rY3g9WY02Lp7uLbSU2zxoz6p0Mv//+oCUTa3IcbT2ECD/mXryefD3CHqO8IJGDDRiKsUhfvKJpr50L2spWJTK+XxpNbk8WSfcdc9zx+WsQnWF26VAGCkfxplpN+RcZ4X2HVPH9Szf17JwcPS0/loCZG+WbLq0r7QqAx5/Kb3UgC6qTVSyxdtqJZ65/JI0tFQzCxum+sRUj1Z3XUD8BflXP7hYAoAFyOyRsvAHuQns4ttmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OxaphSh9OHqUGgjs4IJ7W2uOKFI7yP7g6SNyO+K1N8=;
 b=eyzWJUI2avQEM3L3HVwKCSxDWQNE/1KFj3z5YxAwUBhK3h7kzEs5TudOpGnPwB2zA7kTFFO6M0D40I12ZI4hTRf2zKs5G6a8Pb+BQ7yYhPqZN9mkLDpwaZ3lxVkThmBYYINnjOGg6XPM2Ixx1AMTQOz9QkyXCgvBHsnaV2+/+0M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by PH0PR03MB6461.namprd03.prod.outlook.com (2603:10b6:510:b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 16:34:30 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 16:34:30 +0000
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH v2] xen-blkfront: Fix IO race during unplug
Date: Tue,  6 Oct 2026 17:34:07 +0100
Message-ID: <20261006163411.2583538-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::6) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|PH0PR03MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d022da-a89a-4495-4086-08df23c7b212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CYBLiXY2ZTp37FuWMqKMQH8K/bYjwZ/8Xzxw1a/L8zdg3jBSTUaPD89wEfW99bUl/5nlFfhZrf4zN8FJ/Ka5BlIAC6kGD4/AQqDQcZGFfbSwYhPW1infCJbvX1q9kJiHM005dLM+PJBPg+6yq2tdsTO6f5gEz4RXOSl2JsDagF88cOG9aWP1Kc0pdv1dNb5o9E8+8LzJtbk47pP5jU2wRSO6Rw5zYXsvQuHD9uQjY5uU7P5c/LENCEBVSBpgTMUwfMlhESv7K3wsxjUCQeBcJpXOjzFEQhievn3db3VOx8gridMjSHU2q7AkP8B5PQCZlL0cdAxM9qgtb7UsWO5DkGScp6WMioinZYXrJkGqs7kb5+rNiWnf6P0STmJvl2GHabvKQH9M0dZrlExll3reJuHjF15pfZnDqE19yFUJg1L4SoLDWq9ePEeURickTsi5vOTXWrS5tyemmFn1VayjH0l28NCkHi6j2cBAhqQhEYzKZjanPfRrbLpwGBBeGwufHtOA6M3U9RtNPnb/0gYE41zQdiZrhbQQCit7AquLaAsFlZyTODN6UEp2FV4mnbOlL5nLzLKlRvAzBi5DfgF15u2VrJvctr50DZ+tsE6ra0DRFZONVZXr8kVe3aZxihfsCERaaSV7ZOQVragcVxPFDdywf/Cmki5Ct7cq+LRr0QM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8274.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixtIcJTG883rvOudMTOFFdnNFQlXMw1kevo3evFoKhS2BsBzClIKKI/2zKwr?=
 =?us-ascii?Q?rb5Q9rxe69leSHtlpAeeGgeCxeqx2IdgIntuq4Oo9x9tPU/yeoUhggcxG8/w?=
 =?us-ascii?Q?t0DyOG0co5yUWXPIcvTaEZLo28n4CHvWKtONms8Qw7yawytk4uTgG+ZIMgfa?=
 =?us-ascii?Q?PkJYqVddpYVYNTqSBQqESS0GnlsKeUKTojWaldyEYZL2MJFRnHIafIYoer0p?=
 =?us-ascii?Q?T7Na7f+33LOwfjyrXvRdpDWftUGaFRShbIfrogtNza5Y38VvX5kY0yLplwpt?=
 =?us-ascii?Q?rAGMI4JM2+hmmqOBCO97Y/QztaBWMkj1/ShUUVGnRZ5wnavvxsYepkzwtkjG?=
 =?us-ascii?Q?XoO630PGu5HQGLDMsQzVQe7mf63FaI6rA8IYxZfkAxfsNMPHSlqyjRsO9UZj?=
 =?us-ascii?Q?ClNYnFULMTcxvV3XtP2iv6RRm1gAYywjivVuOiEBj5l5djmzmBX+Cv6Syhk4?=
 =?us-ascii?Q?3MfZvqDDIhnXRLmJ+l+xub6cQX5tiHs5eh3WtlhcT/7N7vmsvBUx1F6+E6gs?=
 =?us-ascii?Q?D6/3qHGQ2A/19hVzTHF0jZd8OKhw0b7Q7Lfb6uHtX0WEjSItagf3l1hjVEqO?=
 =?us-ascii?Q?GH1UXGfvz7cJW6BC8vpgS8TWvsgZ80klzQECzSgCtXUMC9jeuNz6+hyatGLw?=
 =?us-ascii?Q?28nqIzYdrkYOQF2LyJZg+dcLfxU2POsHOm0mFG2RXoRhAvhfDtGy2jS4g3Lq?=
 =?us-ascii?Q?wEZKdivObVwUp+c4A+K4t+NPTDfUJbj4UgQqBZ6MvvgikaPm27ICOv3BobAj?=
 =?us-ascii?Q?bFBhV7jn7wiF/TaakrphaCDYVzUTp58awJDozfZiCxKnosejDBwsqlidBJXx?=
 =?us-ascii?Q?xHWITp+bwjIwJZiODEhFbssZlH4FGY25uX/wilRF9TD8vNmuun+B0O1sQQJJ?=
 =?us-ascii?Q?d2tYgb9n2gpHWHRxn20kFXdZ+JYFYb9paLCPfXUrFH/X4Zt4XJCD/DK2NfH9?=
 =?us-ascii?Q?aYjXp96774q/ye7TOjxUVy71yDIqHngiNVBDfv3gXXa9+l5DnlQEQaM+hQyu?=
 =?us-ascii?Q?HR7gAxB7zTNjzYWrsT2CzUR/H3XaXA/T1Ux1/4ZWsrgPb0h5YQI73UnYIZuo?=
 =?us-ascii?Q?VHcMUGN3J2xzoRE+qyxmm9EOsL5FlT1er/mjxT/xdqguZy+AgsnZnc2vR38/?=
 =?us-ascii?Q?6g+EKamjIl6QN1ZRSQvNB5RTXjraK/gx7qPmcrPoDKoxG9aSGS9Z3NNVjtb1?=
 =?us-ascii?Q?vyhdWcuUxZoZ1Ec7yFAslAwOEZPP0kF3D5NqitvtuoDLAfVoYUeg5Urmwij6?=
 =?us-ascii?Q?QM5BcDHcaM7ApTcsDsOGPkVcSAMfuQ1RpThrnqW10ZgtbMlXNIReTEYSmB+G?=
 =?us-ascii?Q?nnigMbodfpZAHrw4QZox2Y8sOxk8rUgZ4TQL/6wqeYfPf8mGMbfF40GgjYqh?=
 =?us-ascii?Q?RNAKGlXcJaXwXJ3sRXLK7esbBDXY1Faetf1LUnDs4hPQ6KXL1GAS9EbDwVmb?=
 =?us-ascii?Q?aLLdNBV7W1nY/RI/UEB8BzXp1+wfvTul8p9l0vDE1eisC+52rk42xS2NsBam?=
 =?us-ascii?Q?jx2tXJRJELp1CS7DVkcdEzPH1kAPh2W/lljFRvNXzo1iNhUi2SAD/ApSRo0h?=
 =?us-ascii?Q?zsyOs0WOo/sPMzQnwSzrvT3Bq95vctJ96/rcC9wBUVlhV+87V0wPJl4gP1TX?=
 =?us-ascii?Q?7G8Kqo/ZaWIg2NqyA+t5tbPrsbzaE47WzDCfpPyRbCNnKS9AKrMI1n+NuHMM?=
 =?us-ascii?Q?GTYBuIFQrnorkC5z5ow1TrutBN01p6YyE2SxjZUQod/sW3HMWmMZTtxJ1/CC?=
 =?us-ascii?Q?jIWnBpPrOd9jBEzE4F9mch+jxyy2CsI=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d022da-a89a-4495-4086-08df23c7b212
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:34:30.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdCKtycDjb7tvKwOElaymsNzWH3PBs5zzNgU/SZ/lRUQRg+Vrpm1jz9SsA3Tst+GIq+UrWb0aWjgh2NQpI4IfTQrphqtqKXFZwuW5yjHJtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6461

During unplug, blkfront stops the hw queues and marks the disk as dead,
then later during removal calls del_gendisk(). However, IO issued after
the hw queues are stopped but before the call to del_gendisk() will be
queued but never handled. This causes del_gendisk() to hang forever
waiting for the queue refcount to drop to zero.

This can be reproduced by issuing IO during an artificial delay after
stopping the hw queues.

Fix this by simply not stopping the hw queues directly. Marking the disk
as dead already freezes the queue which prevents new requests being
added and it synchronously runs the hw queues to clear anything pending.
If the hw queues are stopped when calling blk_mark_disk_dead(), running
the hw queues is a no-op and can leave queued requests unprocessed.

Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

In v2: Drop fixes tag, expand commit message.

 drivers/block/xen-blkfront.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 8dad7bf5f664..69a2315a1b20 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2138,10 +2138,8 @@ static void blkfront_closing(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	if (info->rq && info->gd) {
-		blk_mq_stop_hw_queues(info->rq);
+	if (info->gd)
 		blk_mark_disk_dead(info->gd);
-	}
 
 	for_each_rinfo(info, rinfo, i) {
 		/* No more gnttab callback work. */
-- 
2.55.0

