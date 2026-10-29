Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273391;
	b=34s3gMxWSL7vY84pb/itO/1BOGjQ+BLwNqFbWEwflynT1ekdtkYNiH4RSJlxWBbsCBpG
	 jpvJ+tjq4u/AKPlhHWjO7F+VWjl5TC119h43lKQJEobvH73lxsHa5qiGdXg+SorBR/Qb9
	 pjd+eRdQoiwIUS7V1SdTKuOKfgeTUnODhpW/m+EobLuh+2rk/HHkCKCMbMNKSNWmbwogh
	 gDHxYAHuCJpSZ8uzp3I6IAXLQPgexQUNGwdeuBLEYpFcxfGibMmrgMp/wNRp/kLX8mGvx
	 p3ft+1hgEFC6JeZbMvd9jgXz5NhGqpiECvhf3X9/LaqrDwYtdiS03vhiGENfshRDXxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273391;
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
	bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
	b=Q6618YmGXW4r4SUDUiYvH6FVJB8I7qnBHruAD7W/sLFxSh/d1ubL1Y5/z31DywFmLdiV
	 UC33W1CQAkxYnJvfKsyKAG6nnd+azMkqZgW7zLtv/VXZ1AU9DCIUaxXFBeEdh8FcgNGwc
	 AqNN2Y/gnHcPTx6gqNSisJSjE73LwC1BgAv0T1vcweXiqgunMqduurqZqDqXARaURP05H
	 WLpH0dK6cRaiFi1g/rsXWSbeJ7ZC0vwm5rprVbA8TTT4IMauLJf8YvEQdpOu9wk/BH+nH
	 7ioFq/uuKs5buBLPX1BXZfVK7TkceZDCHnpWBrNXuk3OPLO10cJ5gNM/wkWQAdXRfeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ihki9o6T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.10
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BAB606A31F;
	Thu, 29 Oct 2026 11:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8BAB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ihki9o6T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfYAAm8f10OrYuFuQBZfd9hlgPx+8cQfflUsfibLscmtoh0ZvZ8avckbFw+dHUZr2T904oexaBcFzh6l75elNjjO0l/694kayPAoIo2VjqvfuV2lzo0AEDkYZO9L5UN5+FUKibGDg04y7PuneNGzoH5yEt3GbUK3t9GYMlltb8PLOtsxmGat8Y2h3M8xU/B26+FkiZAM3MtTjdhQSP+BidgWgui4c9bBRCaJWLjHe2SCyqn5xPu+Ph+9jbCK6ZXohh3kKSZEMN1HQch57qrEkWd8guJh12PjubWCQikmrK0o/P0ywZtDJdz8RWyIsdvw2toNFoKKy5uEbibIcbY0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
 b=CxCZ6iz2WCi2fAJYN/R9udo1yMnIVN7M9fzkLl+4tkkC1exn4yJQTRYYpEnel6pyWTPtUHkRtVBZKVGbI/MetMoCZN3bvRkTbfU5dPPHeQGJWayIhoIPzN0Pn9psppV7rW/FfE1liD+fyomm0xoKiPLMukzptXIIf5XBHQ6+wKVX8JhXg2rFZPi3Zj6xWj770nhoK0+QmYB7HokvcdbiffDfCMQ4yk6Fh/ZMSjEomVRMojausNtg0wa4cFs6XIN0+cLYPIbuRqMciNfmag/3qBd/twu5UjLiF1n20l+v8SKo/XCy5J1NUUltoVcWszH/hAWDZWSy6E1TrrP8Nqo+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
 b=Ihki9o6THZhoV+DFxt9HjfshpnXst8wnCxdJoxK1WfILnMMgSWM7MfmrYtUPzcUtyxgS7Td3GyF0CiNsjOtfKloPRtE3j4oRpzoV/3ohUGUcjgnEir41k3pEV2hMQZLBoBWB5SzLfLtJU/sHcCigPQ/KXO+f/vf4AEgrm8CPOuRmozJkEUl7GywM1lEtZiT0QIdY3yeFFFqzj5+4vdQrC7V5F4CAiV0LvqzkAuV2yqzPCv+v5Rgc0E8EscgcMcwUHzIDVx7xfaIp7kq5MJ/XcZdKA1xKCOM8UbUNQGY9/dKzU8ZyFOyUZNqGGxHzcoKi+M0jrWFdAFCbEIY/cFcNtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 11:29:35 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:29:35 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 3/7] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Thu, 29 Oct 2026 13:29:18 +0200
Message-ID: <20261029-gpiolib-chip-removal-v4-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
References: <20261029-gpiolib-chip-removal-v4-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd5e12d-c348-47df-4bb1-08df35afe922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|11063799006|56012099006|5023799004|261009223027099003|261021123027099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3UXYSkdyRJiDlzoZQFFSLOYsvzNFIgo5QxMpv/84kb50ihgPRdrW6hyHZ+1Uv2KN2o+uLe7P+XssmdrgPS8on+7OEJK7NF/ZFgHrWeBVpVaXreebxsvpjo14VcWVV+QHiCoApvr5YEma0wPl4TlWc0oP/eU66LAhesTc025xni/d3lFiKQEbQSPHof4I02ZCA/MizHFPqI+a7gIpt3hDYJ2P9AATzTKg5tvmUVhN1TymihhBVlB8wTUr0fBnuXWqrrwxvoqYzSLfRSv9IoK1Qp9C7SsFgOjGCcnfty3GZkAxOelKrsovXz4y0jde7GMSXX712GbFbqSW6JmQmy5i3Oo3ia+i2QpKuBTk0mxM2MxFkkCIkwboyPUpd3YH+TupoIPd025QBjM+s2LwL7WrKlefk0DQfZ6t8l6bWyGFs2rnOJFFMVVk9siyJmFSVoi8dzMzy5vDCNZ8eZhr33HGHvasAX8K693SWrG1UfYjQnwYgeGmi6p1jDdcPZvOK+wbJfrs2o44WKUNzuiqanrNVS54Yh7d6wqOnvuB5s4TsBEXPCw0zaUvguA1YVUg+owu6hChl/+jfWxdPulps+rFncAly03SEbSmS/Vn+KZBe2/ffVayatCXb+hA2jnsfRzbJs72PP25m9inddHBxNZqNgyLJlzKn3HVH0zNsORfAXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(11063799006)(56012099006)(5023799004)(261009223027099003)(261021123027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SumUbqEsFV5t6IeBawUKYF+GPoZqAVvE53w3XIYiKgq3Jpd2kxJRVAPS6fz8?=
 =?us-ascii?Q?VH2k3e61FqsREIfoo/0GarUxJ+Zuv+YmQKDlsDcSSg/QQ5E7aePSuuQv7YPf?=
 =?us-ascii?Q?is5u2kSuRFmUjy9kPbBQMRpNB0YOztkXbSv1eMlo3sfJsyy01sjdl+p+9qaT?=
 =?us-ascii?Q?BPaS3hXJaXD6Tt6dK2nRch8JNKA8xyfsgqQUv8df1cXrseNwVQq+JFXyd1Ls?=
 =?us-ascii?Q?mkbJ9QJN4TxoMCPIyaybdORZdVXb52Z9tE93Ka7O40OddRg7QnV0A4ndpGVm?=
 =?us-ascii?Q?aVuogFot8mZKwh/0X2J48Vgh7mBA6dIVAPJaiI5QW49gHwSClzgPF72bnYwU?=
 =?us-ascii?Q?sbBmTOiBOfXI5i3y5nEzDMDsQw4OOusdENwh8fUJM8hJf8f+DE1duSBzywBf?=
 =?us-ascii?Q?azvsc6ct5MQJZfD3VteuiMZGVyKXc/U4uZJJW3TTUA6zCLwk1jZXN+fF9/Nl?=
 =?us-ascii?Q?T74ApA/F6JNEowY4PVQ+5urBZB8HeiciztssknsIg2fBVw6mMM+IOqeIoSkg?=
 =?us-ascii?Q?ZAK61m3N0/9mWkAWI1SGE9ef3eSN7wj0Nvn6HJpD5/dpzV+OguVRXGVgt+iX?=
 =?us-ascii?Q?gcm/SAUTu7vMByVpGPdj6Nxy/+LhIbMxi+eL4ExyKf5ByymJHYsqGfDSo5Uj?=
 =?us-ascii?Q?oZZAlCUVlTxwW/4iHENJD2lqN1mM0YFdkUvmwUaVi+0d3wa5UvtmqM7MPfs+?=
 =?us-ascii?Q?tWUy+IK3VJnarNo7X9KKw3ufRAkc9p0Gij/lhqy1sioKdE9Tm7wV7ltmxbRN?=
 =?us-ascii?Q?gtJf90+vsUdObrNoXKyslSJet5ZhLt2Al87Pj8kZGQrDlHX0Ofngf1cNJykZ?=
 =?us-ascii?Q?porWpQsfVcZKaMKaT+CgMixLj+E+YLjs0a9LGBM67pMEVw44QQ/u7l1P8KyQ?=
 =?us-ascii?Q?0d6HokeOBF3rlwkWnF7u1EYPmA3F9VFS+9bXI8wmg8ZVYFrGCuflFGQIPdsh?=
 =?us-ascii?Q?X/CwrSZjez9JKzUJFgiFOlVUJJXymNYitnJJTL52pvp1F3HKGqkjGgKQiWVZ?=
 =?us-ascii?Q?93+QgXc87AWBZi2/oWP5DY/Dv6+bFuJS9oQuieouZS2ty+AWEeO3EA1A40W5?=
 =?us-ascii?Q?NQiP2KvDXakBk1A/gGCJNwpkngT6jeTYpXs1iQzrJruwn/xoR/BCYSV+H6qk?=
 =?us-ascii?Q?98+xQaA0zp/hP3Jff7Ae9Plse1sKIgrV4ntfjcVPrZrKpiSh/4BISKYheMh0?=
 =?us-ascii?Q?I8g5Hr/oduWcVW/7oG1OiHoxHTmBNwVkY5VAtDNd/9Mq8gpJrVUYPSsMwmV+?=
 =?us-ascii?Q?/SwQLFJNPmm6qinBobwzSxCDKjf63DJdO7HXRwyM0dvfGxkMLbYeRb8DXK5f?=
 =?us-ascii?Q?pAeeKVDYvcqZYFo+SEApLMDPYZ5H5Yuv2EEN/fkINKFjdwg5s954YR6sy+Ca?=
 =?us-ascii?Q?cyVV4Y2meF9OdOckkO/WKWNmF4pd/XnDlaZXAxgbdAhzglMll0n6VRouGTw+?=
 =?us-ascii?Q?AshwUqusN8BYW9uRSdgtPZn1MpGz+erbsnzI+BQWgJXWXY49h1BI/jy347tP?=
 =?us-ascii?Q?RqXCStmfbRb9+SORyoZu24w5lqykFIV40xOuA9aTR0YQPzQ3Qt8bmzNTeuyu?=
 =?us-ascii?Q?dGa24okhqVXpVf6b77ze9kQOlRtGZ0XFLdnffEw/eCgsXglzMkAk07mawsxm?=
 =?us-ascii?Q?uMAkrIsYuZUJ/qG9rOAJNwG1FrFkHUBEBzT3IxejFxb28ynLu2JyO6jdrj5G?=
 =?us-ascii?Q?BrLMC/mbzJeHsE7tlGls8IeTBoRuwGvMSyHJBSP/r2Ua+MU5EwDMDrCDknpN?=
 =?us-ascii?Q?DkKY79UGwg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd5e12d-c348-47df-4bb1-08df35afe922
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:29:35.7532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW71Fddzs2Nkq0tzUEIi3+aWyspjTGXs8EhyViBgM38+zXn4OqnaKMjQU23Y7KPnmfo+sV/BjviBOUe4tyU/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() frees the IRQs
still installed on the chip's lines. A line request or v1 line event
kept open across the removal frees its IRQ again on release. If the
mapping is gone, that can touch freed memory, as reported with
virtio-gpio; if the number was reused, free_irq() warns:

  Trying to free already-free IRQ 28
  WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
  Call Trace:
   linereq_free
   linereq_release
   __fput

Stop edge detection from the device notifier that gpiochip_remove()
calls, under config_mutex so that it does not race a reconfiguration.
Free the IRQ there only if it still has an action, as gpiochip_remove()
frees only those on lines flagged as used for IRQs. The release path
then finds nothing left to free.

Reproduced with gpio-sim: remove the chip under an open request with
edge detection, set it up again and request the same line, then close
the first request. Every cycle warns; with this change, 100 cycles pass.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Reported-by: Jia Jia <physicalmtea@gmail.com>
Closes: https://lore.kernel.org/all/20260817070429.157993-1-physicalmtea@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index f4d78113ade2..6350b2fca8a7 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -544,17 +544,6 @@ struct linereq {
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_EDGE_FLAGS)
 
-static int linereq_unregistered_notify(struct notifier_block *nb,
-				       unsigned long action, void *data)
-{
-	struct linereq *lr = container_of(nb, struct linereq,
-					  device_unregistered_nb);
-
-	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
-
-	return NOTIFY_OK;
-}
-
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -609,6 +598,21 @@ static inline void free_irq_label(const char *label)
 	kfree(label);
 }
 
+/*
+ * gpiochip_remove() frees the interrupts still requested on the lines of the
+ * chip being removed, so once the chip is going away the IRQ may no longer be
+ * ours to free.
+ */
+static void free_line_irq(unsigned int irq, void *dev_id)
+{
+	const char *name = NULL;
+
+	if (irq && irq_has_action(irq))
+		name = free_irq(irq, dev_id);
+
+	free_irq_label(name);
+}
+
 #ifdef CONFIG_HTE
 
 static enum hte_return process_hw_ts_thread(void *p)
@@ -974,10 +978,8 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	if (line->irq) {
-		free_irq_label(free_irq(line->irq, line));
-		line->irq = 0;
-	}
+	free_line_irq(line->irq, line);
+	line->irq = 0;
 
 #ifdef CONFIG_HTE
 	if (READ_ONCE(line->edflags) & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE)
@@ -992,6 +994,25 @@ static void edge_detector_stop(struct line *line)
 	/* do not change line->level - see comment in debounced_value() */
 }
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq, device_unregistered_nb);
+
+	/*
+	 * Stop edge detection now rather than when the request is released:
+	 * by then the IRQ numbers of the removed chip may be in use again.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (unsigned int i = 0; i < lr->num_lines; i++)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
+	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static int edge_detector_fifo_init(struct linereq *req)
 {
 	if (kfifo_initialized(&req->events))
@@ -1787,6 +1808,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1866,8 +1890,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	if (le->irq)
-		free_irq_label(free_irq(le->irq, le));
+	free_line_irq(le->irq, le);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-- 
2.43.0

