Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745159;
	b=JIfgaCnJ962Qpvquj1hTK5m1HlX1+o1rxPjRHLKVdKLYwU3ELVc2JuGUBRF6ZTD4nDHt
	 BcWurFA1IIWn9Z5FF9xaA2vXH1B/VhYKPeGIaOE+lNFKE7zs3ouFsDWtpSy6RwGAhURzv
	 T7NjAQ054BJaj66JzAOl67+tlfEjZ+Wn0+r34IqeuhWATiFx3NXB8Q2B3D3NDmoIwlTGZ
	 xyC5COdptJiK0cIhiXQuf6bZPbdA8BeXOR8lsV8dha+IJ0hXuGMU87rFVCTqf9HHP0AKA
	 mYAuKfL7wtg+oOFyAIvgGNeqkP1FMtKFfWJABrHF8i8/CNZHMWv/A8qW258NXfXzvjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745159;
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
	bh=XIt/sTGx2i/bPc4rQI/mWYrhcKjfk/tS3Xl2CHYU/JE=;
	b=1meUGgR5FeOWZsvUOCDbjuxVYiZ9S4bNT6VERidF8w5GaHZq1bdjUyVMlHB8Po2HZbDE
	 HY48jG3YvQBcPYc2knjGqmt3/EraTZiTqJ3HA+amIJWyymeexob4dZXJnKDHoYZoA/2un
	 6DlPyyR/vqpXDXXx+OzzF1VQOYN/sLd3PKiuBvVM/xOrY/9Ft3zQRSIV3FcjaSEuZHvav
	 DqPSdb3SW3uy43IsNiV3l2Odf4vTrdWhsQqtVs9Hbpef2gUgYNqrYIXULXL/kmjecwREc
	 Vz9E7r4LhPbiUrReV1WxlMvgmi977bcAIzY/mu2GDYvI/9YLo3veuSkrjnB2sG8CpSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=CmUvabOm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.102
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6FA606A68C;
	Fri, 27 Nov 2026 02:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6FA606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=CmUvabOm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdxFO9YlZzXa1C7z74OEFM+csu813Ivk/aZBax225XBXxYNk+IONgYuv6Q5uuBWpKiRB4XPmlZr+tjwRQP/V0S6KKOzmFrqSAA9OWCST0WsLEI42iZfKNN+20NTlbJnxwmxPQ5PdguFmpVOH6GgJrXOm25syOsik2EHLmkARfvfPwmqfmp/Tjmyyym1CfOMXWR6EUduCUsUXYNMNTEfrYrdOoOT4LddEuIBletcgYHjo+W9rVoG3Zxjkhq2ndU2EzC53CIvogYjqhfkSAcM94MZR8NbEeBcUcnWxcdrWdysuQ2tkfBjw7yrqL7+iqJ1B90p8UuFqBoJ2VD0xk8fQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIt/sTGx2i/bPc4rQI/mWYrhcKjfk/tS3Xl2CHYU/JE=;
 b=ibcMaMGtzQ/3Aut8Q1HdQQJ5V//QYYH3EO2XeHvtVL4kPBACIT+qDAt4zogXPhdinuZ2ZrFrGytUKVjHWJ+b7rNaiT+juJnjqU6roW1YgBo2cihMjDNh++nRLGHkw/BGJ7p8cMs6oqTb4OrezWojdQr49AZ/zRUWQCHtBHEFol9xltLu1pQLQlGwhtEStha3tyjcxxu9lox7ODHmanO87BQxTiI2wFVV/NefbKrweut2y+3uAL5HILdm4hN2yLi03gB5cjZyk4SzV/v6KcAKK8oKLS7HKG9Mr9YAzXJEbiDu0C5lH8CXscai+IfyQX/3dGOTI+CWzj9pfUIVaSylYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIt/sTGx2i/bPc4rQI/mWYrhcKjfk/tS3Xl2CHYU/JE=;
 b=CmUvabOmfqIPwYVHVUa8GUgiTRSawspa8+/slO65xyaMbfVgsayNuaOSZbrGbLDJBBJkqMrVLwE2QB0/I6B2VQbCYWNC4+HCALLHtS+HGs8PoA2QL2t6WajdYQWuNObR8o/txgsm5KARNPmFDyoWpC1CFTfyn9mYBNOLdFLNW6Q=
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
 02:05:56 +0000
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
Subject: [PATCH v4 10/15] NTB: ntb_transport: Drain RX tasklets during link cleanup
Date: Fri, 27 Nov 2026 11:05:28 +0900
Message-ID: <20261127020533.2481725-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: ae21b85c-61a0-4453-2db9-08df4c2af968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261009221727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2+um3d0MpdG2kGg9oicVI0QKa17jC7KGcUJgejuwZASdafAY87VNBZmxhtgk4Yz5IEH8fk4VYWe98CLftCcJ7+Vm9rHz2PhYScocgxyRWxtgW+Nti4rHIrK70m67MQkDeYtoEo6D7yewHYZ6kSfuL7Fb6DyXl7XjBdRT7OWLFa+qa3nH+zqciSrFJrd4QuM0wcAasuuJe4cZPRd75NlTLStg8dytlmGKX8UAlmSCKihwR7t/AGke2J732WxCSHNvs9tqao7Wx5mavroQHr6H+XDGAClCByx2ajFeJwldMVq+sbPNcgbq6pFgjddIpwxcW21zJVtXi9wtmRvoMZgCUtX9AaL6OzVqxjXBolLPcbK+I8Snd6BDsDDtHRJv0BOV7bNfTyy7naqU0Mov+7nxejM36VpFDpHc0+G8danuv8c/+5sswLuF1sMPjR24FkYvzNXMWdtB2a6hR1BwWBklvdj3uXdRUcfLthyowrhdskQ7zPL86x0etA+zXWmXQ/sDFF+onOQgY1J/j3Z+JksGXxnO1cgK+LYFyoNBnMgt7JuYXEemMh/nqRAkA/VKT4DdUUfwx26ncXvfZQH9VyLPjTI7nqP6VojCiF2k4x+pSTZZymxPxhKwdOlPA8MbUNsoSCJ8g8GcqWkoSBl7oyC95wNLDiEQtJ3rUABIK8S4MUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0ty15dlIHRvqn5hpCcVgR5/jmKy6F9TDmMIeHIxI7S0zkFvMIR5lqphW1R7?=
 =?us-ascii?Q?SQDoMtHxiR7nGH1pB06rwZuHcFd2wrYShRXi0A17zNX2MXpJnJo4DVQdd+6l?=
 =?us-ascii?Q?/81SHQGZUpLcnBNpmCumtnWAFJ3v3dPdFpKEVgfZg9Rmuwi8A6uCPGhb2n/o?=
 =?us-ascii?Q?K/+t3GnIzxB3/yWy+viHRaqdI/1SXbt6b9z/aEFxnsD6940SG9ENbbpF9wGW?=
 =?us-ascii?Q?hvAlvZvQwoW7IlICJ1ydEQ5T7OMGmKxkv15cW7zKKQGBkeh76loh6UUY/bxH?=
 =?us-ascii?Q?AWmav13w+V0SRioxYNu6S9j6i78Mb6AWwTLontJDwTcTu4Af8gI13MXMOakD?=
 =?us-ascii?Q?UUKFlwJB9JZncds1XfoA5zpYx8Gn+4k4TWEnL1+E9R5fSqgQzHuXm113fpzd?=
 =?us-ascii?Q?uqBBOUsABEzYEIPlKEnZ7UGKnymMVTYqG4PmyQEw6e12vx9NXulI2A2ZRtcj?=
 =?us-ascii?Q?/TvneBT1UytVO1Dnil8c1BjguUYM9BtaL++yFaBsZ0MCWYWKmSqWdX6pUefr?=
 =?us-ascii?Q?c8C0EVJLDbjdXIx2sqmQBSE4PPd045ZFK3Sb4/iKeAMnekjZnvNA4Rz/gW+L?=
 =?us-ascii?Q?i9tQocK7q7SBxkzRmSSgbTHHZRgr7go6Dj6nCT8EgAU4ZLdOQ/Pian7s3xEF?=
 =?us-ascii?Q?RKRRW6CxofEM0pVljL/bv+USCusAswC0OgmbD+R0YVTanbrYU68YYzMi1fde?=
 =?us-ascii?Q?HMKXvxtNj1Fyd42BWmVTISLA+AFVKhAqiAfiWvnjkCL+pJ5tadXRVKJgUCui?=
 =?us-ascii?Q?VVFDGNIswqOwiPE0UEVuJ/mTPcn4/tCxDq6AEUMAJ1gquaRvBWutFFTmt/VT?=
 =?us-ascii?Q?Xm4SOVhPH0p8VcUoGY8PSWIbPb544XKDij1IF7YFOYcdNT4G1mEqtwcL5VUP?=
 =?us-ascii?Q?V6QS6KjlVsiqtFrTAm/TIQoCILBUaPL5Y8/Khx+TCqtb0CpOta7it4ijOxjX?=
 =?us-ascii?Q?JIPlZeIPYoSf1hZJ+Wa1FFAbFjMIpTshrc2lifGyJJ4C6tJgEiWrzvFTHMLa?=
 =?us-ascii?Q?7UsFEuc3YpJdmliwKO6f7Ca32IE21/Ky5NGoIqiaENIDugTQ3rq8H7uUmSsq?=
 =?us-ascii?Q?/UZ0/gmXkK/RTusncY7p+SKGw05uUMn4+1WJ2gG4NrKlU48qajgGZWdp3l1a?=
 =?us-ascii?Q?WtcPaNwfeqSjxP83oFGFkVr79B0fgAQ5Z0/X0l8PBYCuupx4xzYt0SDbEvDn?=
 =?us-ascii?Q?v3M8PXXYrmdVZ96OZWTKqXtbYSZS32p0yB3v6vyMwFn2iwiWKbVRybmgSP77?=
 =?us-ascii?Q?s0JEjpQgCanzFhVNkKFem+ANCta3gVsZSxNzH3Q95/jCzylWrJoIuCMtraaZ?=
 =?us-ascii?Q?qtxvL4TePyL2YHj0P+sBysxifOpiLkh1Gj5XPT6DVQ5QC+KayV4svAFKmhoG?=
 =?us-ascii?Q?+TTYI7uxQWU+MjPT7l40RRz+G6YE2RswqPJeOUBh1fIwMtX/kGtTdp3I833T?=
 =?us-ascii?Q?ALdbTYa5IK0VhISD3P6vfaGVnxgtpbafiMSpoPx/LAJVXROVcBVgNI1cBjAf?=
 =?us-ascii?Q?JEBWX7W8cokGM9eD+tBp1EbTHV48ir/1l0qN6EoRnB7/SF8Y9iktjn4y+DiD?=
 =?us-ascii?Q?8nW45+gGOvCW/H6qeMXtWNfWoBuBgQSSMVNrZoaWSPkPeCgCP56MmtOWPPRU?=
 =?us-ascii?Q?gewa42edmh2QKkS3Ge2E0LrMldv8iO6rnPnloPKVRGvOT6ibANbAd2efR2+9?=
 =?us-ascii?Q?SsNgz/wAko8l3dSMlO6m/JjLRj7b8ZmYmVLABlKxY7wem+eJpjBuoMAE3rrd?=
 =?us-ascii?Q?A+yDn0CmTOwEu/2r83ajKrlOSzmj/cfgiUNWOzBib9/D3kcmU4Sc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ae21b85c-61a0-4453-2db9-08df4c2af968
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:56.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HF2JlatsOy8Anhl/OuOC01YgMOOO7EV1OuSG5vZhdTxPgVZrk+EmFyh1EDHeQB9n+T5GjPhMfo4CfjRlN8RmFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6901

ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
tasklet. The tasklet can still be processing the ring while cleanup
resets the QP, and transport link cleanup can free the MW before the
tasklet finishes.

Clear active under rx_sched_lock and drain the tasklet before resetting
the QP. Temporarily disable QP link work so a concurrent client link-up
request cannot reactivate RX during cleanup, then re-enable it for the
existing link setup paths.

This does not drain RX DMA transfers or their completion callbacks.
The next patch waits for RX DMA and its completion path to finish
accessing the MW.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f4161ff95862..19a1975ff1b2 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -957,11 +957,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 
-	cancel_delayed_work_sync(&qp->link_work);
+	disable_delayed_work_sync(&qp->link_work);
+	ntb_transport_set_qp_active(qp, false);
+	tasklet_kill(&qp->rxc_db_work);
+
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
 		qp->event_handler(qp->cb_data, qp->link_is_up);
+
+	enable_delayed_work(&qp->link_work);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
-- 
2.54.0

