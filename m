Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701972;
	b=owmO+c9eLhks8ip/FfzONtyvTipFd+SgPuUrw0WTELjkY6dbbQqz0wHjmzKJUFkzNAJ9
	 sEsHoSjLhcr/BcLCzMXxtKJvNWbmWu5SabaX/SkruwLT9BJ+yYCCXEsKzPu7eShOUmVZP
	 UwHvabFxF1pv6F664opE8DoyFmfQAOTkuQg22nLyO043B2CII86Mv7o4Vm118EEzAZvhQ
	 Wuv3yQPhw6CyJ9IjV3SXx8Q7fhdOhzzqmZJk6SbOYZNgG+eZUI65F4/8Rn33RGMySt5DI
	 YYEt/4Qkgv3ih1LF6DgrtknJVdQh6AV5hX6+b9i7rkpAcoUbf7bgNKxLxtSOlc3VJzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701972;
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
	bh=QPuO4J4PNlxz4Yh3o1BlsmjvkMd59BSoncc1Hga6QzM=;
	b=n0gg+UnO7LACq9hQpMXtgPI50/IvANoBYZtgx2wW/v6zXJq+8quiUuZ8dT2bGfd+4ZqF
	 30oUBuqqGJbOKJX4c5/txLxrgm65rHVUWqPM/IIOLxWQzAwYelFwlhEEBcME9xI9g1Z8n
	 ZVqY3S4uxdrwJ+EW/6qfErLBUXqU84gGU8Op9LN0rWGCUlah2vhnRqNXrtuW1W2XdtnfY
	 1QeyQ8+4Zm9OjDezJv+z2ch3qaZ4+q2bS9L4tt5skgLTx8fK7UGdAWPV67J40PBw5S6NG
	 md2BWhG/L6yvs0J1Xw9tSRgyfVC19AkqbSB/1mPdPH6XHXPkfeF4YxZl+gPlLVbcdQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ebdj8g0m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4753606C57A;
	Tue,  3 Nov 2026 10:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4753606C57A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ebdj8g0m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FR1hkxh8k5n1v0YSjV/ImVoD20D3226AvVFnWfPDgJ9gozCYr9JElMMKrpzw2xCPAoo5zox1mU8PV4DACnE8Ax9TRFKgFBotD67/vgR1MoWooulQkZNhAaLz7rtoMZTZhYM5NJ9IGrH+e4GBbJdQRN4PGLZmBBJqTOmVICubHWN45LI4rnvZ82w0eaZDL53dWd9NV/FhIChfBXrDFBpO0Tqb2wB4PY1MAI/Dfrlp5fjWtr/IgiaJYBzpn6p1PUrhyWzIJoIeyD1xYAtLnJJznlL6+t5s5bVqN5KO2kn2o9d/zQVDILXiSa3Km74nMJyKy3jc510jgv9Vf0NpEDivdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPuO4J4PNlxz4Yh3o1BlsmjvkMd59BSoncc1Hga6QzM=;
 b=unFTzzrVRTqYZwJdvjFbffkE8ml0reUyZ45oaaT2Y/X7zFY8Tz4Dd6JgpZw6zQsMtvvjI6fpxq31NQBoZODuHv7XeP8ZhTBo1Y6kcedFK4jsDJhwqYFEOKuzoa10JnQdhBkYr2OKbKSEgDEkD4NWFeiAyn1KBgiIDcHDPX6G5Gg4yBvEpTDmd8vSQzRxZdp7JxyU30jCzuLcWL6LIqt0bf64/nIZ4uybuqfa5RN/68DqfA0Xn4GvBLmoJuGZ75CL88Tkze6UReCnxDAckoe+bL6lbyxik33DA9LCQ5YlfXy3LRPyp3adKWQQxLMfBdDXWHs5In245E8RsKtw6Wfogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPuO4J4PNlxz4Yh3o1BlsmjvkMd59BSoncc1Hga6QzM=;
 b=Ebdj8g0mtmNUq7TcPxPyy2SwYCQH3ahigogIU1m0EN3rzSy9iLuKfjMWOmJynS+FSLPg84E7f1Tqdkc0iMqFNapgKDTrIo0ftIC0w7A86wO0+dx2wjzK6HXTZ0Tq0fN8wd4Dk28v1g6x3mlEhCCTJV8kGsjHlClwZXvtiEdnvz0sTSYTpzIPu6UVXjuqXaxFyaG39kkIvRhIJQByjZ63JN9GHLQnCssUpwxGxxTxdmdEQS0QhFZf23y9NheDmVDkjftZykiI3aQNgS6Uz3Z/hI39ML8TQi6WIXsOpjYKhQrmshiSqeWUY8QSrbDNAL1z0sDRm4o37+/3Fyd/l3QaQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:32:49 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:32:49 +0000
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
Subject: [PATCH v5 3/7] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Tue,  3 Nov 2026 12:32:36 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0091.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::28) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: da473cd7-648f-439e-2069-08df3995cedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|5023799004|261009223027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1EoCjZAqYbpAdxRuW+2mZ1xRwPZK6bXC34qf2oYV2FYnrnk4UN3a95DDQeUnCD6Olvu8nJQWJWPNlfMjsyIWikMHdBRPM1wAXGsJK6ksJGhV7sSx8E1ha+G3osFddaoLUAcsf1vcvkJgXljdqrAGjiEI29tNiyrvditjYm5wlv77olKl6auukoKtQyvc0oZ8o+DBDWJ5las+jiMA1rhjVwBEl8elY4lCq/sRm1bEF0DB5RxlxIZqtVigjsh1POl6Y3gPFHYwPcURvU3yOgTQheC+uHsQXJms4tC6S2SxX6B3LytHJXfo5RkTk8SusjQChW56UPUj86p2wxihjXJCGiwz5DNjxVEzzp2tlUl2ryJWGWld7pCIuzsoYtezFfFl6KLDBvEVi8AwHtdUKTfpEuwTGWQDbQWwAmJRV+r8wJhCGJgt5xUUUJj/it5LyLDOpNrMaR4XMKNXA7ZfFzOiyUnLnTt+pXbYCyALsZNT7A01h8XacMrzz5EpP5dFFPM8Wr1CENhvkqT9Y8E9Kb5w0yFfAB9LrXevPqmukixpopTZcVAPDVW8ecTffUjti0qv7LdLORYwxyWUkbf12GcNdbeMO9IoKcL6rdKZ7CNYsRxUD0Cq0arrneyEvDRjjDMdsRSiEMYca3j9i03hWkqmqtC8G0mNc0AIYaahXMXUqk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9uwBgpQ0X81FES40nv1G5JSdOBAwlTvGaPVUCarQ2Q5YKpjVHqqcPNZ63Aou?=
 =?us-ascii?Q?iBGGihZuAqOlaRd60OX4A1n0sFsEDuEJVivJxcbiSy5aGrCfWrlBqxK3R75F?=
 =?us-ascii?Q?dYt6hkbmh9vC4ZY0uoGNruaSCNlS5q0PmTFBNjOGO+mjPSwPSfN2NRd3bjC4?=
 =?us-ascii?Q?d5dLHVo9LtQWgQ9oV8vy9ti916xkpaeBGOatDiUzKMSSqwyQJnV+jI/9+1CH?=
 =?us-ascii?Q?iThpHR1P5d80sVxUIUcmawfDbUaB4ON6YhEWJbBiHDb8l5MCmpwMgRhlLhcy?=
 =?us-ascii?Q?A2pxmef1LpoRqznL1OAvaty7YCgYFe8KZl9+cXsHDS9/MFEdU+Zl9HABHuOz?=
 =?us-ascii?Q?z4raPbTt1I0Q1AbUYlvvsRpimtkpz9wbv6OIXH3jV1dkUeJGchQLmQrhWyT+?=
 =?us-ascii?Q?5t7ZO2PZJAqmY1qWd+f1k87jYiQYjfjnYS9TblLqgRG/FPXxVs5vKAmEK7dn?=
 =?us-ascii?Q?y2Adf8B3di06BMgetAQxkITTvNMJrIxmHynrgw2tyE5/CoDOjH4FkpIJv/Ni?=
 =?us-ascii?Q?XKboC6SrdykUwguovf726E0w1wVzx5GeEY/ci2FpxfWYmY382PHeGj1lqlIt?=
 =?us-ascii?Q?e5kKViZnSooZW7S7FN5YY21ilzej3G+TRBrMdMCN/WEyrtzTqy3W+kPOeuqM?=
 =?us-ascii?Q?J1I5xpgh64P0rYdWGauAj8t62j0SpzhA047O0wQdS6VEGNQETUGdV/YWl3fp?=
 =?us-ascii?Q?zyEGaPky6j+ybMWLMGfHJdzLyQU71w7RYls74T+3f9pmwgoLuwLGdl31aJeG?=
 =?us-ascii?Q?vC/1Wt15igTonb3wEIPff1ymU1Xh4apSPHTaAs3KUcHtybOGA01sHMeaouBs?=
 =?us-ascii?Q?8TzWEmuNKI4IXxoYVXksv9ZGmAYscJ4eeLZ61+Abpru5gWu5s9dCiMFjVeoM?=
 =?us-ascii?Q?derm3xn0baxeTsj7/4HEjPY8Onp/85AFy7Hb9ZJsdWJalmMa4d9Hbihy8eTo?=
 =?us-ascii?Q?1TvGFxaEoU3Z074GMLfBHhBtX0dyZTo8Q5BpOoDX+pdGekT22GOcevfCs7OE?=
 =?us-ascii?Q?XaeKBHVAc4U0efj5bP6+/X/jvNZI1dPRATmvGSv/sHkiU/hxbtVMsPVOaThj?=
 =?us-ascii?Q?BWXd14Y/E53krQGsXP98QaeE7ymQKxwBLxaVk9jyMZslyBH7WXhmhjvn1FmH?=
 =?us-ascii?Q?ymaJgSdoUd332hvTAMxkh7x2bSg1eQV3ZmuNM3TQNgsA777oyT54X+HFu+0V?=
 =?us-ascii?Q?blcFVPT7cHNk5kSUVEkvO2ssdNsQ1xXhmPLMY+3OrQalNnCVwG3XXzFP1zvT?=
 =?us-ascii?Q?WMGjnQv+lM+lXYDDk8aIEUSpeCb5ip2pliMmMmDkEILFIezD0uDMsrCMf3ys?=
 =?us-ascii?Q?whGIApVGSUcYcOIBymtyzD36367JLVBxYWAw83wAbITL1sKgwkj/brxTarRN?=
 =?us-ascii?Q?VnWE/CGgxmtLs1ndC5UbVkrVBD+HNEADiGuoBcZkqp/HH8xRzvChqvdNk1aT?=
 =?us-ascii?Q?V4Y6aH6YfA2JOPMROEiGOl3ickHtV1VIizPyE4uta7Rnr7IyVqELLFdkHRUA?=
 =?us-ascii?Q?0DCvipl7Tk3BuGzZCbmnS5dMfOSW8Vn4DA5vkLr0saUpk6KiQw4TFK3vZ8m2?=
 =?us-ascii?Q?MtB8SqVKSY+Sl0ot5opnpl7HwW99oMoS1fR2XAm0L2pahXYlfvkCORzMgfe0?=
 =?us-ascii?Q?6fYFi7K/WivuAG4QHi0YLJnEuBnkITsbM1Qa0NzI48e4Oa4w5I/XPKsdOY2y?=
 =?us-ascii?Q?M7mCb92AunKapkHlDG/qRUkkrAOcrkoXaGlV9p9140MUof3CgWQO66iHw8GU?=
 =?us-ascii?Q?1TSrJlwprw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da473cd7-648f-439e-2069-08df3995cedb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:32:49.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsTgXk8WFbbQEH8hXH1wphSToB7YExEVwqz7bh4minRD7+qeI/YhEVxaGF+xtUFprHIAutpo4y4B6pR1alJ8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

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
index 3f1f8c9acfc3..28cb63375d40 100644
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
@@ -976,10 +980,8 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
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
@@ -994,6 +996,25 @@ static void edge_detector_stop(struct line *line)
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
@@ -1789,6 +1810,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1868,8 +1892,7 @@ static void lineevent_free(struct lineevent_state *le)
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

