Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501245;
	b=gJyOfxkRUJf8tAB5s9MEyHI+eOtJNKo/1JJ/fZCcIdx5U/WkQV7lTvUqondXywcB5z3j
	 yZ3uGGIlrxuQBzzgFJVLP/GSkaAnswbE1Jy2EI8pMHuU9JOAbg7477d2M4CQe03mkoFu7
	 QlQGc6G8lW7NZSRhAaZ5eCpYJNs0BvK7IfPaBDtRqNAY7f5q+y3XuwxDKWzWvAzFGLdFo
	 INCEOXqT0GBS8M7Fa4HzW/hTUeJ/nP0nPTkK9GQpRVlyMWluiKy4hj9tD3Mbos3lE7Wfk
	 QxADcVX5+SMKbDB8QtFXC2nhxbHdPfNeOC4Ij1kcejsIadyZ9VPAeD5kIINHXohOLhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501245;
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
	bh=V3ruPjjooQKCRazVlkbw+RYz48mcKnp+V7ydeCZitI8=;
	b=XYT2BoCqB/jtSDUzWe0wcoDYlvHchCfBtNbd8M33HhQbbN/IqY3qzzNNyvIehW+OkzuH
	 Th67NI72UN/unaHZKr4b44TXeo/qp3jGL0JR9URNsejSF4INcy6yivok8eqL3tMtXPpBM
	 3k7jHc7NnVSZFTlKimkVyBxcVubzdy9j0zAl2u/qCPmuOLB3RIs+koTqFYedJXUvGzjDn
	 Y52OEhlk4MAEtPvPTQhnVOpWiLJzNMmd/jlL+N5pOas//zyIxu8HjWhmzK6IW+bu2IJMU
	 Nb+oVPqr1oVHwcmSLXuPIwjUtJfGh2H/cZz+CBjtkb3XJk0Sn8IBWOuD2DJn2HBMY7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T3fB1kPo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.19
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B95960A262E;
	Tue, 20 Oct 2026 13:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B95960A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T3fB1kPo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jent13gWzTuCuesn0BpQW+kv72KEhh6VGICzAQWrTPS6WnFcBpxBbSuHqEjRYmYXMKmarh+nGEKmLB4LlBl2Zl3Pc+7s0vovINCBW9ANLDZmUzZl6HDAQ7WF/h4jxo714RSxa0XvD5UtIkmSFP1Xq4wbUK2MQ/tIGUUknmCI34oJT3wJArsQoU1742YM8BD36lMHUNel1Lv4yWS9VHZj5NuhkzR3gGdSrA842bJaElOJHb6KMO8j7RHr66bs57Ky4R9AL26qbMPU1lyd6NNDWYHRKpsybS6KnvEkue+DGIGoBiD7M/f/x2hN7TE81nRCngeLav+va2xNi9Tn9XGZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3ruPjjooQKCRazVlkbw+RYz48mcKnp+V7ydeCZitI8=;
 b=oKJMnspF5TqK6qVoGngF3y4GIRHSVwBplomca3XheEBt6zY+LM8rGrHSWYNlDMcWka2j6WXspEjko4PrUgBJuS6RqHVwIw0tV5T8OSu199wjLcmgpVvZUaALi3z7sJFb6xRts4S7j0XDkn7NuDLXIcwjnL2TkphRPLiEBLABEL6L4Wn+QXM4s03KaDNIb30bwjkyhwSL29PSbcz82VJfHvgms7qtHRIJfOXJVt66fjWDvIE8dYxP6K89yyLAHuDdTrXG2gV6a18YWu4vobL1VZf0WWzUURFWlo+EUO8oRukCHpg5a6KTvPqJpGVrzDiPXBYMG8Np49ieDxVB31RtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3ruPjjooQKCRazVlkbw+RYz48mcKnp+V7ydeCZitI8=;
 b=T3fB1kPoWeUKuS7ROXHnLRubdzrhFNr1RpNOI/YbJNVeHuQPi7fxkf/vrfsfze7qxSZyyRD4l8LfNjl5zj34Kxl/LPMB1mFWH9tRle50YGdoDYzg2ATbtBShsMGA3crJqWD6aPJ35xlk835iK63Z4nmvMCDYa/e7letT9d2K4R9mo2qvc8eVBOXJAn/q3X1/qUH4QBP223CQ8ip6yZNGA6fbx/0vp7UZWsteeordzchgHuCJfeZK7TuKFgw4vVIcspkBElejYxd/cyZIRSsYXSYdwsRLEr2zA/z3skJSRNIU++kjzcz4/x/sJ0ns7j2hEB5SJsIwLmPepCmqGtpnHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:00:38 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:00:37 +0000
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
Subject: [PATCH v3 1/6] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Tue, 20 Oct 2026 16:00:23 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b9::11) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: f361f2a5-516b-4ab9-b021-08df2eaa2317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dB4pjsEc2SzJ5puXjatJ27cZ6NkwssNd3mWuxyshCC0NkTTLz3i2xgfi9x5tGUdBZ36Zd2fN3WNdmQpXw4SypNgmeO4T8UnXWkZI5gYMgAJSRo0VAzjZ7ABr2lTPf8du1h3q1ldlETBSGwNdd3dnX7rvThA/qmbXWSwdCD+FXk41FA3EBvEG3wdWnWqeYap1og73o4S/aa4Q8G0EWfYjzqWaXjrz5DaCiNR8MIVxUTC7M4nZys2Z6IggWIrWVFbEJcSjE3nQxaUMkWxglzXzNtW81HorGqcTPmMMrJZIkI4My84ifVGQ3+BppUuEkBqqMRnrvcuErRFbOHXry33e8hYdz3Pxfuh8pPjphTRy/eIjOeZ9dNlgurBe9wnuzP6oH8JuVZDy2TrBEakXHFjr0cQZKQbvlnhA4WoVZwLanVTU7gicJ6ZwEVI2dHOy6qrNgaj3PlKPyT7EEkzmKySC8kIwBZh9mOGKj+7VEtFtbm03n6W66W47s+xMYE40lYrHLpwJ/XN58ujSggMwTlhStF2Ig0tfPUAqA1PSYf60OQYVsTt/fQ3fidlPjyk0ebgsKtdMdw0CHtWUIDWkz6JoDAgelCbp+EOPZGZInoMOPbU3TXccUUHeCx8htNQp0kXR2NI60ls4QjLEsoWyxQPpFXHHduO6CnydToZfXVZhqVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CpnYlkO6ZTgIDrdD81YlzSuqq4OLA2zpfp+uxex13tHXaS4IKCUOqt4S2d9/?=
 =?us-ascii?Q?rijPn0GbTT+kdV56TDtIOheZy008yzz28cvBv31cjCeu7Ry4LWj0sSYR2e4e?=
 =?us-ascii?Q?7yyoobOIHe5G3a6xrR7/vjOoyH9o6+d1NBiJOThDNo83ls1VM2oyikRSmh7O?=
 =?us-ascii?Q?B89Mm8s40e8rLJUFpeOIULN9I3c1W6mx8xzVZoQ+You/ZaTeFetWULXutLnJ?=
 =?us-ascii?Q?ILX9xNHOXIcysVKsb21Vr3G7NlulkB0Wk9NF64KlLmxNOb6K59EGxWM6+kTq?=
 =?us-ascii?Q?52o0qVUMf4kFHFWYZtfOCYnV5LUnvouwVD608haORepq2sdFrSDj0i0wZCk8?=
 =?us-ascii?Q?S3sZU/dor6TL4Y6BCJCG8W+xIWoFyWa4x8zhnwqMgpGO8OUF051XFLz9XGE7?=
 =?us-ascii?Q?ayInXztzu8LJ6QodHYunZfEXWiq9xSAP99Y2CqUdSd8ZQ1xis2/hTiDpTjiU?=
 =?us-ascii?Q?tyBBJ97sV5J2myL+e34NtVZg2f8XZHXMZW5T/ArTV9GR8Ci53xxwcVWT3rxC?=
 =?us-ascii?Q?SGOsKUy60IW8kyR2hPuaUtTseyiPDuGPEjYimNSgyXNn5icWLe5gT66RX+ix?=
 =?us-ascii?Q?C3tdF7FTkvAKLqn00XoTlaDYgEk07tTw+t4m4gRF8MNFAJE5GrrUdWY0DB27?=
 =?us-ascii?Q?+n4JXMu9TjpFdE6qjBp7zKdO1Mp5XG9HPApM7ouMIlhBv0c6NTwOV087mo7l?=
 =?us-ascii?Q?A4gKk/a5InaTdSkjpbewNfc30RhdTEdKAr346UsMRyd5J+cjjSdtFIa8JvE2?=
 =?us-ascii?Q?5IBv0OH/wRZSDUh3iUDxtfFYBf4/P28FerbpEb9UJP9mCqivha++i7CalbTP?=
 =?us-ascii?Q?QK6TUUtO2SV0iFG9wDI8hnwqS45eUp2+KgUJBGxl5zg73/be9M/zFszc9Uom?=
 =?us-ascii?Q?XYRBgtPerTXS4hhmRedGBXOsBM5XAEi6z8olIg2+6jE3eBRzqF8Tperpz5Pu?=
 =?us-ascii?Q?ICntqNgIvxxvnrc7iwf1MMbddltIR70Z/pMXj1rDVGadA5IafUUKgGDHocoy?=
 =?us-ascii?Q?ns8UCg+kM8CYhKZS0lbPoWlVXgdhEYgXQPyIGi+10D17O6AlqvHS+y/376pt?=
 =?us-ascii?Q?M+56kIZ+CxqgjOQw8A+PoX9CHTdQy+KoSTddC/jEvRJqxfWWe7NQ+R4P9cAr?=
 =?us-ascii?Q?iX46zGFmMtajE9G/Nw5bPkoNfpGj7T9/7ScWuhe3gAbmAlDxTlhnx3GAgWXb?=
 =?us-ascii?Q?B/NMKBR04wZiQvvM56TpM2OAlRSoGH+SkesQ61HRoy4gM3raIf/gtThD+HP6?=
 =?us-ascii?Q?M155Am7ndXf9+uSPNsXrd6LnM+cFuT1GW8kz4nqlzNod6xJjiAkcv0bD287V?=
 =?us-ascii?Q?5L50jQGn+CuxYFAVtE3/2jIN1f8k255xnqbDQhqpVAEkZU3+yITdm34YcaOi?=
 =?us-ascii?Q?1p4Sth0CmNo1eGt5y7BTQdlPYgewLqbRINKDdY9Nw43U4Zq/D02HxbXagtB7?=
 =?us-ascii?Q?9uEtO+GlB6ZQxnhnNZRJKwFPb1JY+LeZce/T41Ak+1MNUHKktp2/wSYcuIUo?=
 =?us-ascii?Q?tjDl3ce9HBQk+7gboRKnUvtgyRixuWYF1C3qXPBJs9h3TYGtlpCTSscG8v+l?=
 =?us-ascii?Q?cW0HvwbLSFwOgD/H5Sc8QrAyRF1LCrK0GW20iysgyc204SBGKV8AqJS6wP1k?=
 =?us-ascii?Q?0p/eVSa4AvTbZuYO16tz5fs/Cft6eSCPaqNiGo9KoWA/3tX6HGIvIXCqQvJy?=
 =?us-ascii?Q?BPXdT98ZYx7YJ+iKJp5mrTZOGbv8zRx7P1yZL+2r5gIw5Q9OHL4oqRsEcR1T?=
 =?us-ascii?Q?O/vuj54MKQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f361f2a5-516b-4ab9-b021-08df2eaa2317
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:00:37.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy0H/OOzeU1uEokr8EXimB4oXmTc1E7jMX3Qp1rB2tz5YTKXiMcp/57eJuN/0qZBp7f+DApr1foJeVVLc9IyNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

desc_set_label() frees the old label with call_srcu() on
gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
a label freed by gpiochip_free_hogs() can still be pending, and
cleanup_srcu_struct() warns:

  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
  Call Trace:
   gpiodev_release
   device_release
   kobject_put
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

Use srcu_barrier(), which waits for them.

Reproduced with a hogged gpio-sim line, setting the chip live and back
on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
cycles; with this change, 1000 cycles pass.

Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
Cc: stable@vger.kernel.org
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6932278cdb9f..e5326c472a54 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -895,7 +895,7 @@ static void gpiodev_release(struct device *dev)
 	struct gpio_device *gdev = to_gpio_device(dev);
 
 	/* Call pending kfree()s for descriptor labels. */
-	synchronize_srcu(&gdev->desc_srcu);
+	srcu_barrier(&gdev->desc_srcu);
 	cleanup_srcu_struct(&gdev->desc_srcu);
 
 	ida_free(&gpio_ida, gdev->id);
-- 
2.43.0

