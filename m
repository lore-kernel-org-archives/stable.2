Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745151;
	b=yWDLf4vkP4eKxk0Whda3ajUo7FCTzrmY4p2rqhAHsbkVC4pa7uhGrodLYm/GURCzMLIr
	 RXsSaeGZG0j0qPSsO8FWs/9J1p1uJHl7ggeiQlK8Fox9O3RGKIIYXjRvxJUZUtT9SojV8
	 b0bEkD4IZRrDZzMgnI35KMZ99ujKWVusAy9GeYccj9/vfhrej93zm0C8lu/Sq00B4Osb/
	 16E5MU/R32VV4U/BAz5RDmIEbHULWPGklZlkSOW0Gp8tr3PSunCUPAkqCm32ZDR0H/3fl
	 9pPijZIrDX3piyicVfq06gddl6Xr/24I4OZSgAfH0WO3GgkkCR2wT/OTSTcpABSGsBw==
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
	bh=KK3dRoyikyNPlsZlFjIle56JxF5PD7tkP5/eWxWUrvM=;
	b=V69UnJ3cTcrdnikUgJO3XaQXX1UeTBjgVNAvsEfOb5MtzPYsO9Z6kRRrRJKGc7IfaBB6
	 MOQ6ndsfOub7sCsCMUkg3ytWU2NqcM0/okhOw1rejKB4bZ9mj81+Irn7YAVyG1Kje6Qvu
	 +sdtWla6c3bkp0I84PaJWPGt0i/W+3NOx73RwREqhmkfPCMkGx2tbekNhXaZLnvemkMR+
	 6hZBwaKGG/jmEE1mtxLBrQw+JEWLJp1yfXRtXifsBcr8jJOTljBmKfLCAOKdr0ab+F8LO
	 aRlmW+9ve04y6MH6PgyTOUGWeg+BVoMAshoLVB7hT5JSd/iJxOt6P82dkhyIJ92VOBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=irTEjZBz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.123
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020123.outbound.protection.outlook.com [52.101.228.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDE606A331;
	Fri, 27 Nov 2026 02:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74BDE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=irTEjZBz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ye3bTqYZ0FpjrDzZhtNaWCqi8GXkZx0FcupKdqNXCaPtUH0E7A24cKBuocrICT9umq9teQv9sO5iXSfZ5JbG+K8+tGOIxAqSl1g6git57ThQkrjmmRkxHJszAhy64yHBQixYEYKd337AsToqZbzA3DbmH4xTVsroh1YHwRJHkOuZJYMrYo/OnmjK6dcV9P+q7Y27KpIvvingFLWDoWHnO3LGOitI+L/nxELr7E+UmbJOB07/MK18rWAP+OGpXFLGkaQOYXyC4p/vBnz5olBQqO3aMvzjUUAbKM/8B+JrdIWPkeceGjwVO+6tyE1fRrM2DXT3iL8BY1f9iLPYbZLu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KK3dRoyikyNPlsZlFjIle56JxF5PD7tkP5/eWxWUrvM=;
 b=ZdjfcVqhN7lkzItOXj/LfBUHw0LXv4DbOTbI+x7TSX3DejBeFcMTTINdMzA59ZLwlYhdx4YuRrJ2peV0XG2EvCzZ9bKYYKsfDMk+TX5gvowWvY3KyU3Yz0Z7Mnf4vUUChmL+8sy0bHRgE3tx7+NGZ8aw0DSkYLIglmNMDxR75r42v1ecjJL3R1Yb3eZYkb2Wc/Z2FfUijQrHFiyeyVKu8I9scQjr/VmSFESq6RmZ/WA6s2vNzYtgvOeuu52vhZCvsL5469TDrh7w4NY08t+mDUhWXmU+4Zr6SuBAPG2YZ65h6IwuDqauBKZsDqKt8+/EgBCys8tKnO8qsWBPDAStRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KK3dRoyikyNPlsZlFjIle56JxF5PD7tkP5/eWxWUrvM=;
 b=irTEjZBzarhYdIJ3PLQwUSaWdjKkpHBkYNqcfnCYtE5KelXDPpujRRHXP2ajGfzLW8M0wTk9g5C9w6c7hCFk7i9m54BucWFCczFNjEnB8CmzDfkScdkzK32EqYhD7Y8W5ZAPQHmniAt7xAGBXz8CYDNbMMcNPZmsTYGyi37EvRU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:48 +0000
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
Subject: [PATCH v4 02/15] NTB: ntb_transport: Start TX offload thread after queue setup
Date: Fri, 27 Nov 2026 11:05:20 +0900
Message-ID: <20261127020533.2481725-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: c4d30eb5-2166-4925-4eb6-08df4c2af48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026130827099003|261026135527099003|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261022113327099003|261022105027099003|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sv9iQ+xaIZXts+/IvTkaganjWjm9OYKD+sBcbOiP8IXAqvZ9tPhoRY2bBerKQXUqWG/WwgQUYOJXt7WCmLIkoP5t+HylZ1u3FhjWE1hm02U0UJh1VzqXv+ykh7vv8BbQ/Drnbkcf5eFwiqhZcezbayFuTdzRYr529kW4xqMkKCRrP4VgSFmthCLL52R7Vx/4ORm0gb28Xz2+GijfdMntHSMQ98dXq53RIwJZd56YOnVYCYLZbl5SIf9sgjEVRiHrzAqjxgHYHi6WEpYDTKJQ0oS3m81QvdoR1GuqwYIe/AewDw/VBTZ/mkDPQJ1DEiMoL7JDBd5OblvY653RXVG0LLAa5e5wtH6C7o5aiH96TT6M9BW132QmfwatyCaiVqiTf5NDwMUVKVWRdPX4EGee9FD4DRMuNF3KtRWgyvt5JaZ/bvpw974Ah8snRbH9ZRWShRz3cCosmY6exzli7mBGFb8qDzumXMhN5wax8IwglxH/UHSsoYh/RFodRhf+AUw2iNAuhFfAl65cWIZOKOrd24i8wOhHNEDV8mitxoaSbw+1dbZI3oRSyGnQmX/Kc/vE5Nd5k7v6tSWsiJ3eI2UqM+C5WSPQHEP/9dY1IV5GEaTdHA2c6Ruf4ftDhIOdFExFlrk3uhhjRcznuoOSyQxxAFMaG3x5fpFiMya84xqqH4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026130827099003)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261022113327099003)(261022105027099003)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VMEXsyJDqOwsr5CQicHvLeEcMgV16FzpeT+bPkbBsWZz6jEQZxpsVdhkj35w?=
 =?us-ascii?Q?wH4jfauffSHUkk1gs/ceNAR21+h07wrGESLKyMp2DkrzLMMp5f9/5woKCRop?=
 =?us-ascii?Q?Gk+kNRFiqXd1QKo43zuTeaoqmoMezCJITRenPA4ZHbGnJaqXXR4LGcd9fjbY?=
 =?us-ascii?Q?BKLe8uGhziSMp0FmB2ckKoGuxOjQg0ZLaeqPl+dkn4102XQ7gSnVaTM8VGnv?=
 =?us-ascii?Q?PpPDWCDOGgBSbpZ3uCrjLIGeAhClQucYkNCnmAdzKBHwxaW9qlCK+tqF8DC/?=
 =?us-ascii?Q?/Lyap9mLVWP+MtW2yuI7q4+TKwL5gMz+CHFQLqikoHKjhjhZP4cCR3LpbApz?=
 =?us-ascii?Q?PjMn0CtX5CN7Rm5KAzCFe8MV3AKeHpZhdpkAT5E6R6GIprvS8ecXfIBO4OPz?=
 =?us-ascii?Q?IlJkCGCjlACAjRkz4nEpym3MF4B9odKpk1lCkwajgV9RoG5gDVlfn931rcgF?=
 =?us-ascii?Q?kw4vgvfg0oJTV33TOZREEOT+yRW+Qb5JSb4TrNSRbmnQ+lMppbf6cKJTy8tB?=
 =?us-ascii?Q?uLf90Q5iYgsthCQimnya27NVNC7usxHru4Nw7ycO/ZYmAXHMCvtE1cfAh/Xa?=
 =?us-ascii?Q?ciS/gRqfhDzi5qP9gzUIu+Q5BEd2Q6HPnBL9Uh9Npe03CKWtVFSh48Ci/wUV?=
 =?us-ascii?Q?YpUTfZTsIaPKyM/yEPiPQeqqOUCkyTiL6YQhP6clW6UbdjGgGHwbIYg5P32g?=
 =?us-ascii?Q?bHgk7SanntDB/rWFgBVuLBm64QCbpDK/9aomje1hZAQw6ppou0av1fondmSa?=
 =?us-ascii?Q?X/EqgZfVlMKoayEc671B1Yv1QFcawBwRije8T1RTvI53TZkxnWWo+xVuPQEA?=
 =?us-ascii?Q?0pBrMP3uPBoZZH9JvlXTq9ZlLRHixvHveczcuUAXedgyEF0IOshP7eZ8tznD?=
 =?us-ascii?Q?gyckQa1h3BIYt5OYkg717NGWHhv4mRd4LeEcorb8/I/DPCRDjJS5r37f8NYH?=
 =?us-ascii?Q?qEa7hPscLhpP2Jo+nCRvybusxEFgqjYXE7lQ2iXdrs6i6SmjsvKEjRl16VPe?=
 =?us-ascii?Q?1MIxsKep/I73iAPo4W13UaI3yiZNWQXVr88LTl+HXDqJ4c59n+I2novheScN?=
 =?us-ascii?Q?HKENbYPJz59P5rL8c6rCQqKD+aY3mndtS/1Hwo5hyC9KPvqVEpasJQYdGbs8?=
 =?us-ascii?Q?/7qiI6CTqndSiMmar7ws+xFFzhGAh/fATU5+D1d/9QVuCv+DpdaD1yPn4Ssq?=
 =?us-ascii?Q?3p1G7sYQGiWmW9axIjSx+Ha6NFuuJMqxNJp9VIO92AhcuMcArnuaWsSoPQuM?=
 =?us-ascii?Q?Ca0mjuIOET8KHpszA85/Eh/qVcKz+7J8WD5pd57vgLuIuUgYJQ3d540VXUhB?=
 =?us-ascii?Q?JFwdR+uErqI5Foq3ozneONWIVO7sDT6OK9cFaZvgoN2kzhpqTj/6g2U/PY9V?=
 =?us-ascii?Q?VGFx+ghGIhuH9DK0IdZmZtvRtn0Rzzai/uAF42CVk9LDV7Yo/FKbCAekNzJ+?=
 =?us-ascii?Q?FjbsN07Ay9nA4Un7HBEV5Kmv7kVo89nyU76/TlZEGG2qoYBQ1GpxkK8UxDhY?=
 =?us-ascii?Q?PNnsDvw0Z1vaVjZo8BCP8uSKiyW75312qjfgSbx77bgskJsbw5K/j0PtwPWY?=
 =?us-ascii?Q?cxf0JDrgbhu6oNoRWMhu0iR4oropNxkDqO1f5pJtdcUDnOF+MRPVV4fos/9N?=
 =?us-ascii?Q?1VanJMbqr0v4dEdY7s131AImib+3LPFmdbkN7lEF+KKJG2I5jFywK/XDTPeS?=
 =?us-ascii?Q?hvF+nMEQXE271ykoQ1s/dtfCL9NLta+Ovws4xZQzhSObXfdUXKhX67ZnKaB0?=
 =?us-ascii?Q?r7/eMODV/9ZrDTV5rBu2tX3Vq9kh5SoP0M8eo2lDGuWan9faUC/8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d30eb5-2166-4925-4eb6-08df4c2af48d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:48.6117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yts9LVjk/OrXFdnBhmUDJ8ax60+o/WmqT456fLsdE/rFh/G/aYPfUN1ytJ4Mz79cXudwIFzXeUS6OBy7cSbSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

ntb_transport_create_queue() starts the per-QP TX offload thread before
DMA mappings and queue entries are allocated. If later setup fails, the
error path returns the QP to the free bitmap without stopping the
thread. A retry can then reinitialize its waitqueue while the old thread
is still waiting on it.

Start the thread after queue setup.

Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 1fa6e0ecac4b..cbdcc7b933e1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2057,20 +2057,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	init_waitqueue_head(&qp->tx_offload_wq);
-	if (tx_memcpy_offload) {
-		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
-						    "ntb-txcpy/%s/%u",
-						    pci_name(ndev->pdev), qp->qp_num);
-		if (IS_ERR(qp->tx_offload_thread)) {
-			dev_warn(&nt->ndev->dev,
-				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
-				 PTR_ERR(qp->tx_offload_thread));
-			qp->tx_offload_thread = NULL;
-		}
-	} else
-		qp->tx_offload_thread = NULL;
-
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2132,6 +2118,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->tx_free_q);
 	}
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	qp->tx_offload_thread = NULL;
+	if (tx_memcpy_offload) {
+		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
+						    "ntb-txcpy/%s/%u",
+						    pci_name(ndev->pdev), qp->qp_num);
+		if (IS_ERR(qp->tx_offload_thread)) {
+			dev_warn(&nt->ndev->dev,
+				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
+				 PTR_ERR(qp->tx_offload_thread));
+			qp->tx_offload_thread = NULL;
+		}
+	}
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
-- 
2.54.0

