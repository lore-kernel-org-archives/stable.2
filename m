Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795745153;
	b=5Y+RjjUFX8LNgNHfwN+kM+ModPoryE7tS8+nzG6mOKUg512kGHJrhM1iokvOYJhVVvp+
	 0xUQlUokdwcQ7cX/lZU3csd/WgbFQkKrLWcUlkkNVEdZlDDbpZ/+CRW2mRiLzBvdrBLbT
	 n9KLAY5MWni+LzCCL3iFw8dVeY+4DqVYlXq1W9Kel5983TGhRBTXbBMI4rtskmA77sLXj
	 cZ1dTT9p0ErZSe5ZlrCdFWUwVk57O+hAR5P8Bw4kB1Qm1xFqGNijkRtSV18ChBCGeYzKn
	 rIny7hVM0bJluKC20ANP64mYDbpwWRTFoMRW1JyFStp0SNEcSYvGtIaM0lOWRwx7VYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745153;
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
	bh=FDZqnuSxIUX8B5cf4k4ia1z2MwCLSpLQHnbosBFoy/Y=;
	b=adtdU8FlhsFanA5vbDJ464XKDyrsqLgE3qvb02OMufO1A+Mo0Ec4EuMARgCXl7ZL70cE
	 Qer5+3vy0ye+0JRZt1Zim5h/J8DvfCvfPIiajOZhQO/b/fsgzaP2GnFTOK+28GhXHPqkx
	 9lf+taVzxSuMvOSfPvia+slejTEikT0Afswv7WR8LZDDKtSkAgBC/eVtk1H12s8GJIJ4W
	 h162nJAKncGI/Cm56f444M1Dbr2mjiKnW7mA7qw7xTS5xPDov+DCQ8DtLJWAuwJJsvGsy
	 FlQSV0W7qpVhVpAAlPyxnQeythir4dbkHZNOWCJolpBfWSAloN2G7+lMM7bJE5+2Zjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=SVimYFr9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.76
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BE606A327;
	Fri, 27 Nov 2026 02:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F0BE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=SVimYFr9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQKbOuJYNyaAcceIeFwv0kbxvHAKr2QnmxMKZgoLfKZpFAFNuOg4t3ZeOjA11I8xFb4KTwr7L9HQOS2XlFAQaTJZ29+V0XWY+kq/5qgHJaYHfoJaXmNTZ+903Ug86wYg1IjFavI+hwNBnZVLTl9zCw680JdAXLpGOCd/kEKVD6/lkWBGJeFuHXiWzJ4ZhcBjD4aZ8gmdSvVqIm+Ze+c1SOk3IUjeM0ahUE+QogrHrW1KayS2rTZdfPlcxSpSwHTJ7TBMJd8L7jsYp7VwuESRORopwkiO8gjsk42jJoigJwU6rCGipkxEUru0qsQZSSJZqsbQXmcc135tbVY6FWw7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDZqnuSxIUX8B5cf4k4ia1z2MwCLSpLQHnbosBFoy/Y=;
 b=iZHJDN2lJ6PSnKYSinU3CiQBu3v/vYmuinxqb5dMG5/3oFsFyXXgR/Jp+SFq9b1iGgOqkqi74SfCpPmU7kCn0/ZrC9WrXw4FU+xClWLee038sywXxhxXkcBgVOPsGhJNLPRmp5JEd51tdhfS+30IhGmwzlDNxDGWJUd+ybrHHLKit3LXYgIVuUN4J5VDtWnWSvWrEmgTi9RKUYFZOMQNQ7s4B7P5YgEFxMCE0wRNck62cQcVa/0FyLipnKwY9p9CHj/A/ShluKLXdigqYxZ5muRc/U1svIEXAFWk7awkJMxqEi1pY2Zp13UZVxWxk4F+R2vkw2KMXsKCdEtY9WAkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDZqnuSxIUX8B5cf4k4ia1z2MwCLSpLQHnbosBFoy/Y=;
 b=SVimYFr9ItOMFOhWLy2k4bsu5oeOqgmHMOvDZWC8QajqGtMv7jr9ptNPK3U2tqvAUljGCZ3+o8T/zWpr/0/rcDDBNXjXOH6kI8LKbkodaHFpi+c5HqNcdRnlc+HIRmqnYbxttHgRImMuOnW0gbYvCbJ6vZ7N5Mo4BKpGWypIn34=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSBP286MB5984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 02:05:50 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 02:05:50 +0000
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
Subject: [PATCH v4 04/15] NTB: ntb_transport: Avoid deadlock when cancelling link work
Date: Fri, 27 Nov 2026 11:05:22 +0900
Message-ID: <20261127020533.2481725-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261127020533.2481725-1-den@valinux.co.jp>
References: <20261127020533.2481725-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 0a6ed3e8-2229-4f6e-f9de-08df4c2af5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026135527099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1s/H5UfGl6vF6hhStSSbpwFmbfwoZIaDgizyFebvYXjjEOoWR7i0CuX9UnlVfnIghUvaisvrXNCCrHlGI3QIkw4WLgqD4wZUYaUBWD17IT+rWIHaWIGGk7zfNnRjxiLOAC5Ge9tSiNfhNHAlpMDSnsuq9ZP7XGcdTvKnDdb/GoPXf2L4UuS9RhtJbiDWCekzZ0N57HX4SccZJRSXheZa8rmFO2wFann4b8/84ZMzqQ5hg3thEX11RZPx9o9PhjjeIgj9mKXa/VvwITnF8DHLNvYxfwTbanxLyMGBbJWwZCuKzRQCNysXROvIp+juxi9ShlIKWG85bUNtHsgZPr+Xzm5YwESCq81QOdNUuFeZn+RpDeWCW2/TZGHAhDSTaNoqtt+UpyOcf7/9QN+nH/g+OJCNL9cA6lIMhz0xVW0cf3gtN4OPpYCO8huOKjYpzygp0WqDyBxfsD9EnJ5/BAyStpfxBBZ85kTgLqVhizjPL/D38YJvkFJClW5TWLW115kV3z4B5dRWpzWW49BLVIypwjSHVq77PTXBsaHUAyfj+e5Yye5iAphf6fMDnI6Wr0hspfDIhxNdnWSrLDvD31gRYemjUw42OvMnuq0cPWcZogCInhaoFTrih2GqO2cMSG28
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026135527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zjAgElPubqf+1EmxxhDhvMr+AjvjP71ad2MJuXdkG7FUWhEGxTg1mqX0hMHX?=
 =?us-ascii?Q?aGNzosUqxJnOSqLMX0zHCn72PLLdXKtYxx6XFuVsMW/UaPhESZjWJUjQn+9M?=
 =?us-ascii?Q?3grApQrrsM7eL45QkzW2ZsOZBeHTngOWLCoMgLffHCUYom6DV3w+QORuGTj+?=
 =?us-ascii?Q?NPenb08PqF/hnjtBsIuLQoED3TUuyd703sR35M2859AK50LBq0MoQEMx0PYL?=
 =?us-ascii?Q?Sdujq+JyYeTPt0BjUS4mbKQBUNttekqhBdJoI5lxV+Yk9lZN5M/B1mU/kNBD?=
 =?us-ascii?Q?omAzoCKfY+ZhG5xa1KmYu1a5sR3hENWGl/q7E4I7V0+AAS+g1MdiZwCOlKOu?=
 =?us-ascii?Q?rtf4CDIdhZoWwwKC4pEgPCZSKWah+fEjYcrSPtZZTppQB26lX4Hu54iueMVA?=
 =?us-ascii?Q?7PBf5iHMxmXCufM+dN1KUYIlhXZZY/27AaMvz6Sl3MibDngjWg51ac0n0Sda?=
 =?us-ascii?Q?eya4JNCmYewCXg65aO6U+8p9znGujhQaJGQgyKFbd7QRQ/feT6WoXwRJnnlS?=
 =?us-ascii?Q?2eq7jYKYcpBfEriwJKaF7CBF8RBW/36TBWFfuQU0ufAB2sxxC6UuV6zejWbL?=
 =?us-ascii?Q?ijcG9Hpayb4sfWAi/Lk03Tp3QuEFkVVmSlEVjwW9/MBOmNCLLJOaLP/lCuty?=
 =?us-ascii?Q?lzzrfvTJgvnHZf6EgdgE4T1ShG/BsuEGWJYiqgL/hdHYcrnVplRvgdfuWxG5?=
 =?us-ascii?Q?qoDNmwtlkBeUYOyzAkOSGhqP0ET0P1IsXkFUjtZ4Eq5Jj5NEUXwLIk0lt79S?=
 =?us-ascii?Q?IEow5RQLB++uxUVjupk6yfTHSQPK9gYkNNa3qgRyZm6cgWoQH/klQdjlPKDk?=
 =?us-ascii?Q?C2OC8Q9zSLU0FU/siepddGX14jFvseYk3L6bOc8IfZmAgA1hkAwdxmb6i3oq?=
 =?us-ascii?Q?g2DID5fpug7I/r0dxyRlRchj7eemzKWzMSw+gBm96WmPVZtfXr0uRPnmPAE6?=
 =?us-ascii?Q?MeWotue2kt2LLbh8ovrt0YFlaCHWXqPrnn/rZZVf16S887oNK4aOJwzfvMl6?=
 =?us-ascii?Q?kaKFG8xzGnOsOe2YFMMKrSVpmglLLiqTwpHDg6WA2S02kJFstbNpmBvBoYWX?=
 =?us-ascii?Q?PiT90npH2x1T9hYLZJv1Z5bho0B6WE1M9dkcqEaD2hlkVf56eBXQRLeg/Rcc?=
 =?us-ascii?Q?vvG9GfR9vCgQQL2A2EZABmX51Y/gUOuVzFDCQ5ZE4PwYdfzEnODNC/hEz1Nj?=
 =?us-ascii?Q?51ev3sp998PhlIGb/irms5WhEdwgEBa/69k1zCT4+2qBVLQzNcWBT1F0ou4z?=
 =?us-ascii?Q?om5ZSjbiTJMZZ7nCOnZBzRviCXHjcT/Ua+N/4RdXlGVaCXCPYCb7OelRMlZY?=
 =?us-ascii?Q?36Z1XM+BlPm8YH9mFO/sUyI1D+4k0svAc6xYq/YQuvbjBrjRaZIQpyia6ZPA?=
 =?us-ascii?Q?150bXo6S6H334hTLLpYF1Km+1QJzW4VxRHvf/o4C13L0QKN+okgu/odnBC6I?=
 =?us-ascii?Q?0ynmZuuEUiu6ys1yaj3TSIxRZShlpz6aiOM1VoCQZT6pq39pGm4j4mFQIsPi?=
 =?us-ascii?Q?LBKOwB/H5VHAAGrxxQPzYeNzEQzUoV2US3eJ17YWn2Gb+MCS2oOsmqY0IhAM?=
 =?us-ascii?Q?j3ywN47fqHnvhvGXZSNdH5hbrEWBLxhLKrSBtyTL7GcFFCWYlfWljzwUsBC+?=
 =?us-ascii?Q?0s7MQ47wQh9M7rCftZ4TqPZ9yQtNRPBKv8gsGnPpYmeUm73B4S0UOlM72vs0?=
 =?us-ascii?Q?3HVQn2qwJJMv4uxhXOzrYLNrjf0bpcQuVXmdIEJYoaeu5QuWAO6w+17sCLtw?=
 =?us-ascii?Q?8QFeCpsmlhTpO9HlHDzuBsEytaxuqkrcOSheN5slKJ1Y2yTztF42?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6ed3e8-2229-4f6e-f9de-08df4c2af5b6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 02:05:50.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4FuIgHtOayiaXZKrBS8WyOELiWJwBnIcd7bd56/Sr7IhbSHRV/OhunBEq2ehOI0lnTnWA+QFg9gZrq4wMneNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5984

During initial link setup, ntb_transport_link_work() can retry with
nt->link_is_up still false. A retry can block on link_event_lock
while cleanup holds it and waits in cancel_delayed_work_sync(),
leading to deadlock.

Move the conditional cancellation outside link_event_lock, before
QP cleanup. Keep QP cleanup and MW release under the lock so link
work cannot restart QPs between them. Put the locking in
ntb_transport_link_cleanup() to cover both worker and remove paths.

Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
Cc: stable@vger.kernel.org
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - None.

v3: https://lore.kernel.org/r/20260928152550.3354675-5-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f135025cee9e..0822f92d24b2 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -962,6 +962,11 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	u64 qp_bitmap_alloc;
 	unsigned int i, count;
 
+	if (!atomic_read(&nt->link_is_up))
+		cancel_delayed_work_sync(&nt->link_work);
+
+	guard(mutex)(&nt->link_event_lock);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -973,9 +978,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 			cancel_delayed_work_sync(&qp->link_work);
 		}
 
-	if (!atomic_read(&nt->link_is_up))
-		cancel_delayed_work_sync(&nt->link_work);
-
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 
@@ -993,7 +995,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
-	guard(mutex)(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
 }
 
-- 
2.54.0

