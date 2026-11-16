Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836934;
	b=iM0estsQWHxDSRdCBoXKpuZQ/pCrYym20vjdKT3dzK+E4sJPPNK4Xxd3zR1LRcwcaPy+
	 PIscDdV7xY/cRXk7kuML4XsYlL0Szxxmv4/oSnVRghN4yT51Yi1MXmwh0XF1zT3Bf4UxS
	 SQITMtiRv4FMO/IqN5cE/mPfqjqBKuEhqEbuhaB3bVSHgrHUUo9jOyiKGUNDvxFbwVL6I
	 6YAn+TjDPB/XJb+8OSjmxj8VKMTox5N3QMriLogqBnDYJEO+uRikpxZEnjpkam/5igVBK
	 DCEpH7GoRDzwV1f+o86YtgGmHA/jADHVyd+TxkY0Djg6+4cFjoF4uk8bIueK4fvo0lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836934;
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
	bh=mnLqGtaRlK0SvsvjGsb5ztBgUsJvUBZqse9kC+ysfMM=;
	b=z/jtlE3Q0n/pnquDvJMuTMQRu4qK1wXKb8FNtwLkX0QiQmP3wMgWqm/rcPm4FAVG0AmG
	 ory7rc+OpiVEPb7TaphLTVab79qG9yQR7ZesIaU0dtsvRzqjWmkocL9Z5Mp9rB5PJvRJq
	 lAa90e6efmauoqo+5op2r22gj6GEf3vgxE/Sf9KHZAjvBDtTn5EphJ+g2wCbWVGSKs6gb
	 IpOk8n3BEklipow/pCcFk/Q2Wpw6iRaSVu2SV71jigkgTuphy76QkZh3yfF7GksWSq+Y+
	 zwYxo2J6Tfmv+6LNVoLpHPN5u/Pg2hIeV3qJsPkjhMh6vds5nduYCzszoUknPCZ90Ww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FlHlOKi2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.23
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B6606A32F;
	Mon, 16 Nov 2026 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25B6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FlHlOKi2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOI6spNsPQsQKPMDZ4MdxpAjR/NLCNbkksUc+qCs3unVf1oKIagS7CfSmPse8oPrkj/ONm/dwIiaJayqqx7ygiP8n+yvFUNVqOgtdW9dhm562ofsqoeOKe3WBgw1B1nzVUOAOedQQOhZpoGJgHkIyLZ1fdlXpQrPqMp6lksdoD3GoY5V3WhOhuZDU6BSmIONhCPynB4E0noLMxWRJDMQ6W8t5AnU7lfRQYRLA459mjmmIyh92jmsIiiRjJAnADuFVL0oinq8ljDDZ23WORG9famHVYBlLT3igog9VGVOGPuIOvE4JjqD/zRJHjvWH4UjyyZ5JAYFmlzfCBdpdbKR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnLqGtaRlK0SvsvjGsb5ztBgUsJvUBZqse9kC+ysfMM=;
 b=DXVyOHiENhXVkTifBQ/STEf7+m4lDGAUj6FO++NgmaWmFxEAVfC+41xa3ly+22A4LFYbGGnZrXIN5oZahWfCsBplHGynxSrCRwtPlY80yhR93t9s892BAQhUGNFgKdNEqqEBgkV7KAp3jbYrjNhJdQpuanrVS9hDIzWLb7DIFcU32il3btlSafTT0IQmAGq90eiMmWUg/EWT4AosVChz/paLp6WGKUYo5chwWgMwQnyBtpQUGYF7d34KfK0RJrXQGeMOw2gsmMuDM3bXklio5HCD0SxuF8EeXhYpYcEtPt2/68WMF9vr7oVE7t1bO6i1t8jS5EpKvK3PoWQL6b8dKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnLqGtaRlK0SvsvjGsb5ztBgUsJvUBZqse9kC+ysfMM=;
 b=FlHlOKi2LDtYyYba2dutSCEpgjgcJUUqoHf8mYCf3AKNWGKesI7aYpV0jXYgmigs40lTOWAtCKvU0j2/di2Wj03JMDbegXXbZe2i+hsOI6DkGLXYDAW6uXXFZUW0Qqvm9jSnFifjhlzbFzuiP+ZHW+cxpKuX4zWlAPTvyAxn2L9xk0LAPwH770++ozNIvLXurKS1UoQ/NnfAYFFUhcRJXLoMF1CluVab6i6+7eoSk5nKccb6RwKuy9mnmU11f8VECRRRgo0X+0lymAOExlQuzRSUzRGS8GedhibgGYtYt0y6LUvJiRc6p0gEmMAMUV96HrfONVcamVbyK5h41RmzfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 16 Nov
 2026 13:47:45 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:44 +0000
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
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6 8/8] gpiolib: remove the shared GPIO proxies before freeing the remaining IRQs
Date: Mon, 16 Nov 2026 15:47:11 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 41249286-1ed2-471a-4d4f-08df43e83130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|56012099006|261021123027099003|11063799006|261026121527099003|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261102123227099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XP39FUFd0MDZpXQGNqjYX1eYstqCb5O1ZNtOPXoeWbj+YDkiSPtAVd4UooIlRMfBf5iWhSZhl3IJ3D15Wo3owozpFthaiTnx5baf27CRoLW4BtBvGWTTdovcZG69amcOjEK0ZmLOC+mBanIoArMyqu/cOiHJbnR37cVFy6tIEMh+Ha28pmyhemCdbJr9FqMLN+mjWdbNWJYlx0z/egFS+kaiLz3bSWC01T2GlrP38IO0Li5dylaOl6R7sFv/qFvPAndzwsHTELgJxGjkjS64Y7nHAMWKtArdc+zOkDB18v1wFHmIY9bIEXi/Ywy/gJ1O9IrLUrjqldAQas13oDZ6acLUHcp+do4Tf4RWve0synJW2Pae+Dz8UVh4rA8oOWPRLipY6HLmCj1g/poUVsPAkCO4yHrzpR1KkIjbQs3xyYSv5EKwV+VAmB3Z/0KpnNvSUlOEr8VVl6jlMd65CmpI5upgNbiwH1O147x5ASifW4cJzysFVaSINWac4P1k0FESAdju/nmtfI+ErXlL+UEDikcIwCu36l3CAlKteWJZPEiA2QA7ty0axmNdJq5yxGI/xgSkap8FzsW0jHkzFezqQ3oj/4Y8w2c2Tb3uKKkMnjlYuruBC3NJKNKU1Hn0CB2RbkiL5t049ZGTHkpIR7hcwS8+AzS9gU4MhSfFpVlS7iM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(56012099006)(261021123027099003)(11063799006)(261026121527099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261102123227099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JF3OJgzs1W44WjuUtNUdzyNKJK1fQlmd4x7+m5qS+xv1JyRRTuqW1tHUYlge?=
 =?us-ascii?Q?v69cd7WgnFw/irYR0bhL+VB91tFuNlyjPDFroVLn4sxqC29cDoRGNHz3vZZn?=
 =?us-ascii?Q?DjWCBse+qSIgrNeWkC7JtFDH6tSF+kz5SNVp8VjdcWn/67i90Xk+F8nnsaR4?=
 =?us-ascii?Q?dL7zo8WWFETUvVujmFDAUJRjnwFz+tfKWu9a6o6OSvaIn0ACm8Enh/gs7rGk?=
 =?us-ascii?Q?AJZC3BOveNMuVwprLuZQ8ckhrJbyBLzsfM7Zr75j0CAb04q249ztfSr7m32f?=
 =?us-ascii?Q?/dZTVq3rTA8fA0R9E4Bs3uZuhJ4pq/zh23L8yGw/89lkk11hJW/H+9rug2b5?=
 =?us-ascii?Q?GzayQ+NvPia1MYRHmXQs1KyHUXVVksJPfZRKeh7xhdVByjvqRnNSzdIHvynW?=
 =?us-ascii?Q?CLRHJdz1lJ8ORjsIVXYU/8PdEcz/DUom4SPdmkOQDSO/rdKxbc8XcEVwQFno?=
 =?us-ascii?Q?JTkOdF8tyNrwLIT9f50YwL0HqCjpIkYCNWiiUC55bF8cDeJq+cXPMZEEaLKv?=
 =?us-ascii?Q?p5B6W+UN+Tq7pAe5qg+qfhaa7n+Xt9yYHhkF+WosFXcdgAYLISK/FjNs5Dtz?=
 =?us-ascii?Q?GXJMJbMMUXq2TzN1M4K3euVN6z9+OXUPqgLe+0mDetZq6I34B9/FF+oFzgP5?=
 =?us-ascii?Q?6FyEe1CXjmA6zF35vqEOm9/Q17SS17wZYgLXFI4RUhVfZ6AkCHdFiB13ruAB?=
 =?us-ascii?Q?5B5H157gvCqo8sah51yTC+ysVzHVw/qXEeYP75o18XMUzmiSR09FnGjBeY7+?=
 =?us-ascii?Q?Twg4pNFyEIre6yPlQcEs8XpKdalQDyxBMk8pZ2oSeepbV70qbs/1XzH8byic?=
 =?us-ascii?Q?Xc0tOzC/J1dXKX07WLvF8dmpMM2SsN7MlQ17HUd4ghTFqN1WO6oXoBjqsw2b?=
 =?us-ascii?Q?syZx5d4z59o7U9M/Ol+/KfpWyzGKctUf6xVsHKA6DUysfJbMWcUCfd9dR93d?=
 =?us-ascii?Q?tba1nQtWEypMGXpT1F46tK5DwN6JAGdSrUQfOTCVHBpBDkn5rlsMYrbg+L1Q?=
 =?us-ascii?Q?cmNZc3iUT6J1FKXjAT3walsP7Twg2IiGR7rl5zCKyjiujtLm1aBz1tjJp5Xg?=
 =?us-ascii?Q?KSe2sAq5Uiw/4Cya78CfPTz4InTWuLSpdovkUBmCuXW7bTZ0Rftb1Z8d7Bqo?=
 =?us-ascii?Q?X532ZIJIti7XJerLERT+TDcs9c4sl7RbOsQh+QFu+8jrxchkndecMcfiU+lY?=
 =?us-ascii?Q?Kcs3DbikYg3Fu6tcMAD/ltKSR9mwWm762sbMW7rLKmk9tXCaV3WfDIDv3YGf?=
 =?us-ascii?Q?i3k0ctTSCSUxb+3y4TEIMvbybj0cELi0Z/RbR2oIB1xRDb2viBgSbI0xX70C?=
 =?us-ascii?Q?OdrpPK9FxOysCYlyXKnt1pKUfc7ODeAFvrTE0iEjRMMsPxUucNhuLUDOW6Mf?=
 =?us-ascii?Q?WcK1RaYUl3f3tjgbyyJFDBtkceGQP+ueFeQpMAlNC7gZf6XBpDXwUcGnCuSA?=
 =?us-ascii?Q?oBceV+Fmi0vYjI/WwNkd9QseV36rRuzKwIHO0lIbyW5g7h+kCybBEVAtBO2U?=
 =?us-ascii?Q?p8R47Ss2JyA7uOekPa7PzIzkAz7ZjygSme8bX9dzz8l4QuMAnZ2r7zoBKAth?=
 =?us-ascii?Q?qRHg9HqqfKzib+SCb6MNiMbZ5lFKpAmC2ksBhoEoiBvQBBw0+XDvWYyQwhX6?=
 =?us-ascii?Q?zY1QueARnBpsI4t2Sw+ztSJ6MMqTot/KEi0RFXAkquAOZxuqFLQyp20C+Hfh?=
 =?us-ascii?Q?s57p5PbhoSYAHBVocT/ZttKT1NV5JCqa3CEAwZHT+d/nVdPm8vvXf8/7A/Ou?=
 =?us-ascii?Q?I47NQlN1eg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41249286-1ed2-471a-4d4f-08df43e83130
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:44.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2DNdl7OH7NDWWw1e3znqh1J8/V/bz0vUhIj1yHWlQUD9JSdCXZotuOVgCnEh9lz1+AroqFUXzz8hM9+1USSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117

gpio_shared_proxy_to_irq() returns the parent chip's IRQ, so an edge
request on a proxy line holds an IRQ of the parent.

When the parent is removed, gpiochip_remove() frees the IRQs still
requested on its lines before it removes the proxies in
gpio_device_teardown_shared(). The release of a proxy line request is
serialized only with the proxy's own removal notifier, so if
gpiod_free_irqs() frees the IRQ between the release's irq_has_action()
check and its free_irq(), free_irq() warns:

  Trying to free already-free IRQ 22

Remove the proxies first, so the character device on each proxy frees
its IRQs before the rest are forcibly freed.

Reproduced on arm64 QEMU with a shared gpio-sim line and a test delay
before the release's free_irq(): 3 of 3 runs warned; with this change,
none.

Fixes: 1e4f6db614a3 ("gpiolib: support shared GPIOs in core subsystem code")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com?part=7
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d5c62e5f1340..1b18a0dacaab 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1457,12 +1457,12 @@ void gpiochip_remove(struct gpio_chip *gc)
 
 	/*
 	 * No new interrupts can be requested through the character device now.
-	 * Have it free the ones it holds before forcibly freeing the rest, and
-	 * both before the irqchip and its mappings go away.
+	 * Have it free the ones it holds, also on the shared proxies, before
+	 * forcibly freeing the rest and removing the irqchip.
 	 */
 	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
-	gpiochip_free_remaining_irqs(gc);
 	gpio_device_teardown_shared(gdev);
+	gpiochip_free_remaining_irqs(gc);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
 	of_gpiochip_remove(gc);
-- 
2.43.0

