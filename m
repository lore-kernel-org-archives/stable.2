Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745158;
	b=zz3b0CA1olzTZTjVxMgaD07CbqjP2mrwwhYUq18Kmv21HQhQ2W7hLmiuie3AfAgYmG1S
	 IK7p/VowpN+zJ4PxIO8XsudoGczH+HASkUwaW0oN2OEXaOQqZTBcnHZaxRAdxQS6ZgqTo
	 9oHpJUeJ+g2EFskpv/3tT5aLIPYIglCVniBeoA9d2O3aP7pCvoxJlAzTREQfOsIUbucEe
	 L0bQtUacBrK+j06qrNA0ox2uZz1oGVVuMr73x6W5+wwDbBJSlDcq2rrx0rO+46mMbVu1d
	 NqR+jtxmjScN82YYY76PSNVtMrtiNqP4VB+OhNXJa7jhV97l/8NzwO2R4chjfCMs8Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745158;
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
	bh=QP4KpNHTz7vZhkPJVqSziVSYpgiqkbN8ZFn+qKW6jB8=;
	b=kEvLfP5SKiRK3od5szYR/LolYhG1gDE5Xtqlzpwj1P+MoA5b5sDWK8N79xrZ77kt9/wK
	 kBzMCVVKto0yDM6rfRYyhzJzv2v24jYVkp5JezGqL5mZI0RO1Ker1HyVN+AREzc0ujVTq
	 UaARACXJyENRu/cUbYntxHfkJNAZaSQLCawaAcS1xrphB+pCTfQ46jliuZoZI0MDcClVy
	 V+M/I4B9L1ErG56APaESjuuIGf9vT+C4pA/GvfDqETwU1wQmMpe4QKQXsKVIKd/A/A9ko
	 ol4uDcehwKiYVTz91f1nzgQA4Sj57HvxLnMhv8hTIaH9wmrXds1DIbzinK4fw4/20SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b="SR8D4/N0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E191606A339;
	Fri, 27 Nov 2026 02:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E191606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=SR8D4/N0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXrN3p6qrnEf6AInss7Kskkx3aT6Ei3rEAhGE62xapSfo2fBzctigahzn/Ot+4QYNadHa6rlEfw7BpFO4N3ChcBDIm0hn9pc+34hKxlrR9jXEhtl0HxPYDZ0BGfDswLCxbhLbGN+BJX2j5W9g3lOiLb8FdCBmnaSdQ/kBfR+57H3+xN30rOASr6zHWUQ59mDkKcVZrimvINuAZOzJ4lkQmwDZ+/CM4avxvBqY9+8C9LkgOhE4TWYN6Szhf5TrWH8KLa1tdVpP8FEClJKfEr/lc0dMt/hlNUSRWN9YvI3gTOqk57X3Fvp9GvC3WFvs/2Kerh25rmW1W3dif0uSoTkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP4KpNHTz7vZhkPJVqSziVSYpgiqkbN8ZFn+qKW6jB8=;
 b=JEgl03IFcXVcXxXogCVgjGVVTZKp/oOYP/Ssc5Snk0xxY9rrr6XIXykYxoA7PKFSpiUY6NcOLnzem9jkmou18sFIPChMZuiVMbEYf73OAJLOqqiz+idRwd6Qo9RFH3L3kZsrJlTRfuF9gjohnTi7Uj+QN/Ogxrr0jZ4mpdccC4YJp37IamxnO696LTh/IqyYMqWnZZy2dK3UVRI/boiyUwkKEgmKxbwuZYocuS5SQHIyvuQYWcLbXaj/Uafr2mumKWSROiJV6EWB3XGkjmj2no940Iyy2SBBFoSHWkRnxjNiCTCugA4QQDx5YobqbNeEIR4HFy5PwQ3JYKhZPm4XBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP4KpNHTz7vZhkPJVqSziVSYpgiqkbN8ZFn+qKW6jB8=;
 b=SR8D4/N0mpCMwxZInvN6Ppy53rQ58za3EMNKcIR8tOtLjBpR8vn736TAUreuLkRftbxwmMp0w8iU+qszihlIApa5H7YIv0VNI420RBnwbmE5ti1edAU0CTM+uqtqeejbj5XuDL7sCa+ajYtIP+mnCmNq7F+o8nJQ1TMb2HQCilA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6901.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:56 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:54 +0000
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
Subject: [PATCH v4 08/15] NTB: ntb_transport: Stop QP work before freeing a queue
Date: Fri, 27 Nov 2026 11:05:26 +0900
Message-ID: <20261127020533.2481725-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0224.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 3089b395-c231-4d6a-6fb2-08df4c2af840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026135527099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	veYXtW2kbvrdrmCBq5QDBdDUsxMi+pdM3a6RGGHQh4C//fN0p0z9rQqJZwmkVXrL3Yep0aAfUT3OZwGcKJyVI1Dc7jbodYY4KYDP989z6F2MFqj+Yfj+gHgfIRaHdmiMLjSXp8ke3jlQbsIlsOwejn6sy2ewrI1uR575HXz+Z0IRwZ120x2oEt7c44mXe7+bzmqqLAzQ00QKrE+6uBmHLgclhXu062/PIqfAVqXwIbRUFeyRhf1vOsIdYM/aLh5AqZEhbfNGTAmkYfjOYtN10pad8Gck2BByd9GT/lYNjosqWNhT3YohkJTsW+QGr9oe/PBcpVrgq64AgXw1kMnfL7FaMoCFjVb8oteFvpuWi5GNMnDCyW1fWVHwbZP5lCOuY3tI1eyH18aMZP+0LBxvR+vuxjnn3HcP/f1ep2EVn2DjR7zLm2LHAQaC1XrM0YJWkpSFVOpz0F1fAReaDlnDPvbKZeO2/7jghbFTh74GV/1ugNBdDOOqRjTr+msTPGpFHMkocS890C29xr0txCG75irDCZs3Ciu8zC3WufecCFYkUc7jWf9bWWc+/Q+opPg8cb+oFbKMlXt9x2pxy0wZLVEFTVXVvI0wWQ2EtLm8JY+kMM3AD5PQWIDgrR5yVPUd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026135527099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1q+GPKX8uhpvZV0PHgs+D9bClMERYu/Fcy3U3lhj+ItnsUBULuh+jYnLkQzq?=
 =?us-ascii?Q?tMmF1uOjtV532v8IG0tCYrGyzzKgpqOX66VaP/ckBSUCZZdrpzkG6gyrjC/M?=
 =?us-ascii?Q?/LZ3h2CHAF8cRGEt2tg0v6fWhT5va4mwex76YF4p5hZNUG8N800+YtE7c+Mb?=
 =?us-ascii?Q?u0imu80KO7zwS6rrl9H93UyBDnhLBXN94h33cNL+8FxA60cCkr9X5Dy6hj3i?=
 =?us-ascii?Q?XonAg7P9eQNYz9Uw6odfeYJO1bWOwkcsPpOeZe3OjqqUjSfDlNbW7IIXx10h?=
 =?us-ascii?Q?gQEjM5uvVpmGmY7Bb0nf3QDzVoSIaFvrdukcV1JAHJqg11qoqRfAjl+ae0qq?=
 =?us-ascii?Q?9lDilc2haSVdB8Z0qq58esOe5Tz0UQ+gEbnaOkVNMw6Haqu2uouLyA+Vb6LY?=
 =?us-ascii?Q?cg+pRxoiba63/eHBR+EtlUDuN3uJAE4AglYOLgJqmifvmFR7Efx/0am0S917?=
 =?us-ascii?Q?5iPkaGdz2SMvORuHcuaKZBvOhi67BmqW0idPAtbSKnoGC3HqvSvCErpEtgSI?=
 =?us-ascii?Q?u9EqVl+U9pT/FM6tFAos1qp5U4ufItFUcBkytB7S5f6FkajtktJKVpvEIw8I?=
 =?us-ascii?Q?YsGiV3G8WeO1XpnuJxKUbTcVTu4Ym9PrLmudxW65XvjBcGUDYMCTyCQN330S?=
 =?us-ascii?Q?pTBp4BAcIvRwsdCAIAxxtkAzIzmpAXAmCI+t3uJdImdkXjUt+XdAeV9NSVVA?=
 =?us-ascii?Q?dqWyduGQfdpmkXiwgZMZ5+0dGiqRlQZHxGfDUUtGKq4Dlr3guMKKoGMsDUvx?=
 =?us-ascii?Q?vmVhCPoCjIswLbfR+SK021cfDLfKGQW88jjxCE+2heajnEnezC5fdNPv+uxh?=
 =?us-ascii?Q?sAhgmkE8vV0oYIfnZ8uXWHDKQ3mxPG//JlAbl+CQBgxAqu9UGz3oS5nPx/hS?=
 =?us-ascii?Q?fBhkOc60PkKtV2JqAcqkmKwXZPHEllcsVsOWibXYOsXx+9Unq9juvn+9nEGL?=
 =?us-ascii?Q?kU2rk+frl5Qk0Pccv7mSk4PB3Blr9lvS7zMZ9d+QXXJ+FIJ6ALUSgkKv3WFn?=
 =?us-ascii?Q?JqWD66LEPFNAmKl3TUzjpmgWj79B9D0Bknwnv0/u3mUIYz72UtkYJuaAlaCA?=
 =?us-ascii?Q?NXkjobwNpqOC0mGeAKJOGKZsDu/CC7QCaMgNfGGgpovsXoVHeZkGomCitL/Y?=
 =?us-ascii?Q?AYZh/2TEmlVioohVzHIUPv3GNk8WYuNU5QHZowaBdvdzmkZi+yvcr/d5FKws?=
 =?us-ascii?Q?/BBTvPXWnKsrKebnHuqR/iRvztitS5Wz2RGjOwndPj2MRlBjJZ4+xeRkgKOC?=
 =?us-ascii?Q?HvzFFjD0OCHBRj94JCMbSlbq+qAf2lAmAtCmk9gpExUCzShxVu85dkL4pzcL?=
 =?us-ascii?Q?p9o4g6uhrkJZ/t3WwXzIYr7+1EDUoHqg23aTwzEXa8cWMk6wsITRfklsUDRH?=
 =?us-ascii?Q?KXxBF+eojKRLdAOiQxMct6H3jzHnPp8iXzqf92OMcYrzupdpk7LvEDjSt8qI?=
 =?us-ascii?Q?oiZXcJZgEDPgDDaKFK1HTDSI2Ra/e++8MeYODh+Q5zc12+S6TAKyk+YQAhoT?=
 =?us-ascii?Q?kUw/D0kchAJ7wEHC0Hf/oyGBXiRdZl7AkZ6j3EM8sPxNy4Im18rgxvu1z1bK?=
 =?us-ascii?Q?0EHlIrOe4hOoCktJCCuX6Dw7BQZ21ejcmLZDAQPpAQ9l623459U7Z79FwKXl?=
 =?us-ascii?Q?VngHCudDx7qaQ5YbRGPKafjl7SCcu19hQqykiDdc0GDfdNSqce+xUcXsYhu3?=
 =?us-ascii?Q?joa9z0UwtjOpdORYcxL3b/N1uijhjO2vHg6nlA6Pr7/xiCHBfqUna0epL7CJ?=
 =?us-ascii?Q?gQrk4z9e0rNlc3I3meTcn8yCB7l2V6ZTI8G6d2Px88lh0wiFS0sd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3089b395-c231-4d6a-6fb2-08df4c2af840
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:54.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+QSXZFvJzFjcx2n+hL3Ai+xqSIB+uUvpeJiwYPg+DFO0UclJQb9Q3icrhTYWur05XuXcac4B+kcT8vp31qfaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
A peer link-down message can queue cleanup while ntb_netdev is freeing
the QP. Cleanup can then requeue link work after the queue resources
have been freed.

Disable and wait for cleanup, then link work, before freeing resources.
Unlike cancel, disable also prevents the RX tasklet and transport link
setup from queuing more work. Enable the works only after queue creation
succeeds.

Clear client_ready first so RX completions and transport link setup see
that the client is no longer ready. Clear link_is_up and active after
the workers stop, since link work can set both back to true.

Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

v3: https://lore.kernel.org/r/20260928152550.3354675-9-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9c3521df19af..55f596d59453 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1240,6 +1240,8 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
 	INIT_WORK(&qp->link_cleanup, ntb_qp_link_cleanup_work);
+	disable_delayed_work(&qp->link_work);
+	disable_work(&qp->link_cleanup);
 
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
@@ -2156,6 +2158,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		}
 	}
 
+	enable_work(&qp->link_cleanup);
+	enable_delayed_work(&qp->link_work);
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
@@ -2201,6 +2206,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	atomic_set(&qp->client_ready, false);
+	disable_work_sync(&qp->link_cleanup);
+	disable_delayed_work_sync(&qp->link_work);
+	qp->link_is_up = false;
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2248,8 +2257,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	tasklet_kill(&qp->rxc_db_work);
 
-	cancel_delayed_work_sync(&qp->link_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
-- 
2.54.0

