Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020126.outbound.protection.outlook.com [52.101.229.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC924E9C34;
	Mon, 28 Sep 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609171; cv=fail; b=VbkWySa6VyCIhevhMusOByrEvtrxkhiDZ9qsbg1h6GxJyjmrWULsy5ZkRVYZuhgAcGgNueuHxnHWA+d8sCY2jT0qTVZmyXaakxxLFmEhaPWWl//hsEhvXetuyDbtn2X+nfYc7vV1px3XfCXckFR0L/pHzmxNuFGq7z6Owfn4mic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609171; c=relaxed/simple;
	bh=mehg0qw26H3c313fsKkZhhmGMWYwqeYctoxBA7swyEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxDiOWBfj9bwX0IuDzE7TW1kAfz1hqrvMJGpoqCck+6EkAYLcGuJAIRvqRmknhWTENMT4O+XA4p4vXQNIr0WPcp9/M7fB8r5Q1u4K5RzpBTmqE2sgYx4IzDHjpAMgsJyAEMrZyqStEOap+qkUJ3CFIKMZNQ7GeK7SW+q57S2zZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MHDVeGF2; arc=fail smtp.client-ip=52.101.229.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MHDVeGF2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAELcTDSpw0ytr5VaYJpn4btQsiCILA7iNR+safEJ/DPRCJ/AoePc9me8zU/9jtZwrYHpEsU/DRnwOqsrOpmkX1vl9CuOj7FjoTXWZJtJgy43Bmzdg9rclNUXx05kk52kRXJXolKdXeKp3HFZX36Bj1B10iKPwGB16yet1y1cWV1i6OpVpTLNrnEK73IaOUUcvNrHbcQ0eM/IvHbcSv+CXdeBNKLIlXFyPsuQoGIx6Kc7/kOS3LhAc8INvcpB/6tiuTynjwI7dEqT12oLCmlB6a1p0S5xB8GFBfjlNGmn6ZFnb1mfb4+KC4ZBkqCOBCHcYbxm5aH61shvMmUEpEbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/jlyAb57WOX4OtqO145+gEUuvkxKUTiZCgHGBS9Gvc=;
 b=keTDMKKMa6jNu/i9uJ2gljy3k21oL6LKU9LxVXz8t6Z/t1MS3u1zUnQPJss6dBJ5c9UaIiwnIVgzyh7Kq9aY+96R1odmW02v71hSc6mlc82J5kPh5cefMVdjm77LoZ5vMj3KRQ2hBO6w9FZgyWlJO3Iho9fvJ2+AUFoeXaDVhjw8YPhEyWc2QsZUC+7kqkESSimbfUaLK06AipyuhFg+AMiVEs0O+pFjUXBGQiHuBKV6473pXInXNfjECGDxqYxPYKnVoETm6nY8n7VSXy0/8nGNpWT/uDDyOlCoQhc2X50sIjEgKmmTKJH68YwxSqHBU/8XwkLZl88YzpPEJLYLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/jlyAb57WOX4OtqO145+gEUuvkxKUTiZCgHGBS9Gvc=;
 b=MHDVeGF22rZzwhYwirq9cFD1wzB6HkyEE0wtx5gHflYst7k+2l1YOhTgtdDO7b3DV06lhnRtJ52MiWnqTJqb//z5iWDLdK0lY4gr4KhbG7kSQV5y7+n8dC0e33bLBL8b3jJpcNu9Rkr0SUS7YcZq3q0y+ISTkoOymigHE8jkS5I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5412.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:266::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:25:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:25:55 +0000
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
Subject: [PATCH v3 04/15] NTB: ntb_transport: Avoid deadlock when cancelling link work
Date: Tue, 29 Sep 2026 00:25:39 +0900
Message-ID: <20260928152550.3354675-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260928152550.3354675-1-den@valinux.co.jp>
References: <20260928152550.3354675-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5412:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1683df-e712-43ed-af84-08df1d74ca18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|366016|7416014|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+H8CzKuV9AzzUj0mSgDLdFYGypiO9ndv6TlgkdFRKEhZow84C6AKb5QGMLPF1jyJgQ35Y0kVJEb5vIlcLrOvgX8Jr0wcHtQt4+MJhZajTy40uW2YFCqXfhMLN2CUFAcljVSS5sP0CM1xzTMa4E8AvvdnPUDJt4B8Z2kY0hZQPf8N90ifzLYDZlFiFCAxkE7jh4wqiaGWZntkzdvDcL0TLYylOC+SyM8Jrm37GopbDT0/tTok19ndvsrcmHIa2k8d6exrTwvff9Z4cSvVK/SZw7RGNtO9TnlRb+GHJLE2VtA4XxYlQ9rnMTqCXHYvvRLr2p2nEHvySNWlcxx33VRrO58dN080fM5CBtOBb91Pu8kY5R22V2x8ClpZs2EtBKpJXLqt/Hv7iviZkucu2EJXhspb8/7ZoOiOw2rsX4KVAeB+QIrccGTpK3m3smYEcIX0rUM9eS9OzMMceupQ7YHR5sKAwd9boAeReN7kMLweybx7ardPDF3eM7sylKO+WZpSb4ooPr+Pl1sv/EdxPXTuNhFjXjwapC9xZy7dU3c6pmapE9Xkmqkix2YX1K4nSXzFCGlQTh+OpxttyZib+TDClixJgsuuFiyKm93hexaAb2hiM+xGjRyjgbV0+b3rviP2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(7416014)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pc90L8vMcbUspoGOLKVuK0pTcjMcywZkTz/A6EU3JnC37uciOIb2f/DzO4CO?=
 =?us-ascii?Q?JMTqyb03IzTHfvMTnsX0WpO6ko91zLuTqZo/H4zUqteOi8cf47U32OcSH8vg?=
 =?us-ascii?Q?tuhpsb52EGRu/4kBAdHQDAAS5cTa9qA7sCHfJaUOqcZ8XpuCtcpY0hHom56+?=
 =?us-ascii?Q?d7gCddEpcKzxOH6bECo/W5hMkt8HhBzbcbvdt7l4h0pw16ihLXYv+8yMNXyv?=
 =?us-ascii?Q?IME+r3X/IsviU+UgNKYPBshCTFwAMHzx47XHaooRT/tnH4/pZml5IHqCz0Wq?=
 =?us-ascii?Q?3sT367zHFbgZDQJLt+GdzYzZZ/XIK5gurSkFJZjVj/lpzifo10mCF186ImTf?=
 =?us-ascii?Q?PL4G2eslWljIKw6m1ZlhXLEJ12enVDHEJKJFrrTpW4NME+8y6vmnlchW8BUs?=
 =?us-ascii?Q?E9gfDJo+2t4RydpOt4RIpJPvbW2HyjYWrxm8PhaqG3mLgkYb0IEsRWsaj2yr?=
 =?us-ascii?Q?02+3zo5Vh3f6Xlewf/Ts9UIJkWqY3feVq1RpJgfVlDMjL+U63W/KI8u5CUgH?=
 =?us-ascii?Q?O6dQ3uUwBeIH2rvLI1vYwqykj95aNQF7ql+J5FT3CnD4/Jz56Pzush5yuLbm?=
 =?us-ascii?Q?PdjjdzvL8rSPYzUqc3UMnytkKifevej2sLayF2TXiXi6LsdlhINgHFDgKXfv?=
 =?us-ascii?Q?7RNT2o8un+sA5qBYTiAMID1+HtVc5o5SqfnlavvuOlpG9xPVOBD+RBA75Utm?=
 =?us-ascii?Q?YbdB/IgpyzostNZTKb6YVEEYxkUCM1rOClKCFPDdeho1SMgurmZKH4UCKwh0?=
 =?us-ascii?Q?4/P1i1ZXsScVZj8UzpkfpNx323Pjdk7PrMkm+HvwQNkRtv4ljDZza0pTCxKT?=
 =?us-ascii?Q?IDJVvQHXmybEUjMzXX0/cb8ftbjHehlXVpT5QhWm6ihFWHGcCscGJMvxQo22?=
 =?us-ascii?Q?7nvi71z0sTA/GHmd+VmGKzmBD/hngSbOw+ODBeO1lDq0rvm580bbc0gUxC9m?=
 =?us-ascii?Q?Nt3kscMP+hTOlxnNdWpi0JSRR8khgpFZgFcjpjF7AToHgJXatpVmtyp5LeId?=
 =?us-ascii?Q?/QMR9ShXwtFjAUjlzI1J6pYR/+2cqMsSTY1tGWnNpPQXiiQErMM/NFCKMwDo?=
 =?us-ascii?Q?xztfSicn9Q+igjTYzth4rasQ86x4OqSYlLN7spVn3wHdQbDnQVpA/DNcvWld?=
 =?us-ascii?Q?bJ9Cq7DXYzY3pw+HkaDB9AhmyGCJs/5vRCxpRlbHTua1CeJ8mHRl9lusprbP?=
 =?us-ascii?Q?FYqzB0btjCbWuO3XInX+b0x2hm/A7rIoVjqOgQwvf2faxEwGWyb3GPtwfUIj?=
 =?us-ascii?Q?L3kfWtEexs7IYv3xX1NSFtiTFFoSjMFD+/mCmc1Fk/F2HZiQ7t/qzYaDDztB?=
 =?us-ascii?Q?nYF24C0fGv1YZj301HjKKFU7kn0lH2NbeROV3mxgtKJTQMVd50HC9EUlNUHI?=
 =?us-ascii?Q?a7KHiS3o4YrTr4Mc8hbt+Q7+kEyNi4gJ3Zxz5KKHERAQcYSMpNPyBb6H6ShG?=
 =?us-ascii?Q?vb6/zfUw8UzaJXgU6ah5V8xrON2cnELMuNVeHfiK0wIk6crXYlUEs77sETXn?=
 =?us-ascii?Q?srqLy2jkaJZSmBmN+ktoRcqgOtBLRguy6OJXB9CKGJWdowE9sJoJJIm1dsP+?=
 =?us-ascii?Q?vlZb0RrakQRUDSU+0sOYTSqcHRSD3f6zP5R5eILCssc2tF23SLoDMeYZFs1f?=
 =?us-ascii?Q?tK2+WI6cnfrRCm47TSymM8t6rMjSnssPtRQfxp3dzcHCNaA7yEhI4XwGE87T?=
 =?us-ascii?Q?KwBEl7QTOpNhFfZMtQahNH3Zw7hozq0vr02ht64YUoCb3loTw01ZS6vWJNCn?=
 =?us-ascii?Q?igvV71bHL6BEnEi50XKjrXxJRAxW4XFpvyA4/swDf9RM9ou3izHI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1683df-e712-43ed-af84-08df1d74ca18
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:25:55.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: he6EYdbzZsj9+csXTJMMnDjNF9+goD3GWpgmWT1i3nBvmBMGm4lg+kk26K8iMK+jERQi7gZ6xAgwk1bdP3BEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5412

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
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use atomic_read() for the cancellation check instead of taking
    link_event_lock.
  - Carry over Reviewed-by.

v2: https://lore.kernel.org/r/20260910040836.3792333-4-den@valinux.co.jp/

@Logan, with link_is_up now atomic_t, I dropped the mutex acquisition
around the cancellation check. Would appreciate another look, thanks.

 drivers/ntb/ntb_transport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 5d2ec484c3df..8941da0b3d61 100644
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
2.51.0

