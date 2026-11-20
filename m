Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162457;
	b=EfHHWULZI2yLbiCl6G1pHdYwlwCSmFOav09obxeOK7Hydr9NVEVI0vKWVWcgHSjxsQdW
	 QXKJ9UBqc35B9QNSg63DzsfDp6RZPylXZdabvIelYt1vEJmUTPSu68HblU+UsLjGXB56L
	 QQReLa2id96T56sDoGfi1c9MRg2snUpMSQOwgaB1rjXBHFf6jJ9XQh/qCGd5uSCIl095T
	 1cIjPf2cKxVH4RT3VHMM0yJqk7/AMfz+qrnnmRVIJbLsAymLJG5M7xKIfZXwqdFRe26ev
	 31jUoeRfbFZzxPC0VE2tSQI7bMmgwOpArWXQfoOhGsgzLVP+eiM3hPwj8lTCmS9i2Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162457;
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
	bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
	b=BVvHj28O3rMnN+zRwpJrCLdZfj5dWxdROrgz0yR9RD0G2OrH9OqxxmM4Homb5VBITQkh
	 WdU3tOflMcITUk5tAt9l7dBHQBxSZmX/FNDrJfVEtykNFr+UHX0/P7pCFWoL+ouSdh0kr
	 ec8sNuUQbpS4K9pti8yjeaM1ACPkiEjZ/k5SqdYXmwxFN8X+kQGyJrCB23iU+X+JQvgqJ
	 JBYjfbvqImpIDfT9d/ta+8YTNdV2fD4ubBzgDbL+2eDKz9CKsC8DiGo1VJqNGAe1Sv9SM
	 Kl0FEq3u+5iQrjQegCC4DCt4NF6y8IsjJVmRtpdTxY2v25HpkU3U3sjLWfD0+MhV8vA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l4RIeI79;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD61606A33A;
	Fri, 20 Nov 2026 08:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DD61606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=l4RIeI79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/Y0/bk3XgEa9Hk4LT7JMGp3crc31kFuhLlPx/6E7/B9tsDmNqCjiln69qkYREsDZib0JR+5LE9LmuYBY2ViZBM6NnIiPAp/1ExD3DMN6Bfnd+yj+nzULGkBUY1Zyu0DB3JCDkzsAUAExSD8HvkMsaxnrM4DXW82GnFeu6TIJnFZgpPYcqqiTUYJEBhOoKDpq+dPFN6jkftvxxhqS8CohfGmkb2KVwF8Wr9THaLbh9fc+ZKU/u/oT7GISwrz57O7XmiXyzosaKlK1UTz20usgRu0lyE9vd9w281BDe+Q9pRerdQx/ZiCFm7IOLnYNniVAlkFtkCGMcIz+nUUxYHldQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
 b=ypx/78iGx/EzId5QkHpn6Gap5dg0o1bf6iLybisI+E8XEAK8aE37OumtosYhhDGYTXOifzwCp0O7poWczEqLK4tbXNkGU5D6rYS5+Ce2qaMtyZOl72S1+rZQqNnoSDQOA17zpd+HsxQkogylNrAEoNxzHtIeWWlj+Sp14j5xBhq9gX6a/gzwKPQnB1ymczFcM7OwcQAICNWJyMhORQGwLWAZXBKTngUoBI5erijySiDIluCuli+SyDVQEtdmZz8K+cxDhrY/+Kh+/3/Q7HkpCSQw0TBfboRXyUvnda55IUQAoJiXi2psmrlL/ScjAoD4EShsSOJBJHCch4d6fcTvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNGvv98/wgSjodfZ6qkYMnq+CeMdog++vp0bvHhosOM=;
 b=l4RIeI791u5jHyatVKKIA/Ar53Svqb80YPG+a4Nvve0RlUEwi6/Sb7iKqxHp0aBcX7Kb403D+pRZ0/hSfY/PYeWXkakvNmgg1B2OCVhJva9pMlgt0dEJw57kYMJSgUxh/3UiGbz09Fsv0rICTBLVcF/BwEYLth4biZ09qcdeox2V+kHwVCqsOKbRh1pu4oj+9NnGN4hfOM5dElR1MfUWpMgvGULL1n6Z0NZpt2aaCgR1sx5Qc73f+NlSUW4SzcRzlAqgBkrG6VyLoQHkD7mdw2znKflZxtV91rprlVH/sQCVLaws6Frqs0ux0uetCctLXN9Auj1t4zMs/zhYhHVXYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:13 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:13 +0000
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
Subject: [PATCH v7 3/8] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Fri, 20 Nov 2026 10:13:55 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH7PR12MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 575c4464-cba2-4c34-5c78-08df46de4308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|5023799004|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GofdwjCqmaJshH085dQq2c/TqOBc30BN+c2RXmbqEVH8vNnCV/OWnhbb4sJKWKNJX++OZTjCmrSfem2B3j3QpxltzX5SM3dc3/Tk+7lFUW8+eftYdogM/PWtKDpA5atD5IKt33F16izyNIe70er5+XjOpQrJr2iVlD8Ei7a0ny+Iily+bCD4gtVx+MT4Vm50KDYlNiWCRdQiaLx6XjS188z3Nr99+JV8F4CgGbVTp9Fi37NAQsSSfWZYnVV4yF384FQH1Xs/arPUHW8csk4HvjArR9OIG1XuSIC8RL9CeiC6nEmgZtjC9l7jaYySi9/0DCMFGzRFdHEYPlP9ZJETZiYASrHdQKUoUAJH2CUNmpUwjAEYVkV8Cg3f2bijZIMxYkgZo3Qj8D/wWmulBHz3BirBCMoUOuAi2ulloM+2oDj7sZOeElm+KqpOKxCV6HNZ/LzpONq8TDovusyZ2Yn3W6KO9HSNQFmxMceddAsyRSpwiw8Iy0faxk1TvoZvdgs2+n2WtSoXjc9UM8RfSB/wSHzYkyoLWctWSZoKn4pC4yZ/AQZTY0g+VDIcnT4Wu3wakisJYy3rsjDjaLerT8xxruT/nISBxDPHgd7Dsg1rOAm4V+9URz282KGGFcas5hp2AZwjjl1CLgFk/m19H99HYBWYuY1EimCbVsZmZ9BlkNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(5023799004)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77xijJwT8pqDeoepKjQYdb4Qc695KvoBtgOS1fAGHkbltCK9KSmA/FnGL7fp?=
 =?us-ascii?Q?z4hH0tk6f6WS3ChKRnjW3jLXNgd09m5eXlEVuroqYDdmjzvSevk2h4VQzF9h?=
 =?us-ascii?Q?gx3Eu/Y2l/KpXdJqdU7yJCodOw3vs2LP7rvAZf7IhmSg6FyA1MeGp2BstzEL?=
 =?us-ascii?Q?kwmKUmTY+d+DMXyTjjohcnjvZiNZ0e6KHZqKAZRU5eHuj/uExyefruCGJ85z?=
 =?us-ascii?Q?wdvSegO9uwVnAU16fOBZQsbB67Ou/4eN5mKOLNKKqpvr/fLnipWN40A6sJFb?=
 =?us-ascii?Q?ut2ia+W5k4JaR5nMyRvt6c/TBArdHtpXIgLKg4HwumSGz/lBvVlhn0L83fEc?=
 =?us-ascii?Q?EX5f/AQ9UEqtVKidjfiKkq4NuNhkb1KUxq1oNwODMFHpsszVzL0l5lOT5LIK?=
 =?us-ascii?Q?RUyjJfuTaKoLoept9CCLBZ9TYFbQNfoTdgB3ubQF6K/fqeQ7fu8T2MwdWtTI?=
 =?us-ascii?Q?ykhtaACSwPa9QCwRd6a+71vkeeEmGszZ1BXnKnVWwhfn7YR0Myr8MWnyzXYd?=
 =?us-ascii?Q?8psqrhWuLPN7Cp3d85E0j0/7PTAKC4a1hYfC3j2yDZHGfrT4fQ2UUKzV/z++?=
 =?us-ascii?Q?hbEnpNnxAwvo3pTrUwMP9wRwRN2QYi11IQ7oaWhV50sYqiVqEhdAUGvEGC7d?=
 =?us-ascii?Q?MIxWjpiZM69br969QlXqaI89YhDbI5G72aMLk9T6DLTH740NvbGPFNc0jSbr?=
 =?us-ascii?Q?dYv9JAfH7seqBJ0KZwVfUDNCMI6mjoSs6AZkNRkpNfhOutXCr6pDVk90ZB/0?=
 =?us-ascii?Q?HIfHg1bN2HdKSIhQXo6L68T5SE68x/vrqGfX5IE78kYdKooRttmN3l1WgT6Y?=
 =?us-ascii?Q?usm0pkv+t4AGaY3NOUiggnDZO4D7ZzrcbXH0C+d+zNGLdebAdyKVIsXHwNWy?=
 =?us-ascii?Q?CDhdNKkOnXQYOlhovmBmF2ZghAL6Q1izwon3psHLpx3gT0ojJ3Ht7xHBQhMj?=
 =?us-ascii?Q?XQ75pTTL2vMzlUdxBMxz/Vn2OP8pKLBrIXJrdcRulTPOLmeePu/WtBk8LtU+?=
 =?us-ascii?Q?RQdAudPer7h/sXj4uVRhpIjJZ/rmu6kBPAx/NyLUGeuKEXRiyZlQxD3L2k68?=
 =?us-ascii?Q?9jsMv7Uj7TNVwU2STB4779z3RLKGbEoE75tflXTIil68qj4bH3OLFC5383XN?=
 =?us-ascii?Q?HWtOqpA48tDfhqjAoi+gNGoypSHuHEozxpUyVn2LxWwn7YIbsv6UedxDfj4o?=
 =?us-ascii?Q?dKgwEsu/NpLpUqf9PJ9vkNnBRvporvXowwX8szbW3hUkLlQIyLde1tiioQUP?=
 =?us-ascii?Q?fEz8Rk0IVRQbdqvKenbiPwwXuTUby/AYIUg9mc2w+g8jeNquGrd90SsIO1Fm?=
 =?us-ascii?Q?pkci0DoHBg/oXCxBJKr0pcxRPL7yV9ijhytbEQWD/qj99TZzTLKJuJlt83Bu?=
 =?us-ascii?Q?GoWReqAk23WjIQlB4ajPk66HpfK4oHdo3MSOpzgAch/pI06Ug5fZb4jXsud4?=
 =?us-ascii?Q?/aGn6KH5sgtmcmNa7KDH+LLgas28mvApLMpypZwRyIrOIYy2VaISuA6w52Rv?=
 =?us-ascii?Q?FqCeI4DG2pP+JZorWLbREbL5QnIKYTXio6lwHo3uNsicpahpI8Vfclm2Gii8?=
 =?us-ascii?Q?unxjuZKUlj2cTQKOiw2nNtKIkQf2m5JfFulAmy5sx70FMlU3OxIKMmrbQUo2?=
 =?us-ascii?Q?to/hu2hJMCCEWZw9u81DRTWiuX0ATqOnLC5+BKdO4lbXaxjT9QO70zoGiotX?=
 =?us-ascii?Q?wcwk4hj7rxJ4dS2pzUgTXcMLfEh0Q1U+dOZZOlaKQ+SD/OQPkM5rijQCHb3S?=
 =?us-ascii?Q?su04EFROUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575c4464-cba2-4c34-5c78-08df46de4308
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:13.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/nIzSf/7xjRKWG5x8kLDpa3Zg+A++sJcLWB1g/JLfrU3FzXaAVSp+18rqB3EiRsNsnJ5yLOpE3NrHIhcjU+7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index bfe442db7cd3..e6d41a8aba70 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -545,17 +545,6 @@ struct linereq {
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
@@ -610,6 +599,21 @@ static inline void free_irq_label(const char *label)
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
@@ -977,10 +981,8 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
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
@@ -995,6 +997,25 @@ static void edge_detector_stop(struct line *line)
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
@@ -1788,6 +1809,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1867,8 +1891,7 @@ static void lineevent_free(struct lineevent_state *le)
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

