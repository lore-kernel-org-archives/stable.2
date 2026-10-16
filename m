Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC71472556;
	Fri, 16 Oct 2026 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142647; cv=fail; b=jAZ0pDhOY+OWV8xCM+9bvfYbqfTGRF7dxFwf5F7wzozSDjI4cRhrYnjulzPDRhw6HtwMqbUgure0Vey7DiZdb422VY7pLak4RC395296SYRfd60b84XTw1qCXKMO3Pew4GTVDn1PkqMVBb3H7Hf1ydJKkIJuNTfKLz+WdH6EmbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142647; c=relaxed/simple;
	bh=JU4Z12h8ZfBRuLDwa6nR50lhiV5m2N3ejI99PXgjM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tl+ho25ryiwWgZ0IsszIye1leDSQUSOgtEVDQa7QvEWId4JkLzYx8RFa/9jFEflhxPsrSlCrCikiPpX+/0KGYXjjwEp1C/SoV26ZAnMT43Myp22w1EbIk4bV7StH3diM5uN7Nd/cc4enDgbL5SXKgBXrkO/OoZy0VC8oIsFgdWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBcU7SXp; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBcU7SXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIeRf2ANXIS9JJPp4in/0MIi4MVyQ8PikJWp/COn07c5InE4YdG3SCD/Yx3RSNc8pDklbbCN8zYfG86ZUZQf1Pj+V5KTh7q24HgdED8LetREFUrXAdj16h0rfWQsQjHcrJCrNlAICZ9iOQYiT7/oQpDIsSkO5edBxOtt1k0eMWek6oRFsvf6+MAlNSj3kpTuA/3I2BaD7NwDOuQPbrLWGddAmZrYYb11rbpCY3lyF3QGZP43lJIlZIskwkUs2kU3PzaLXSZIwheyqXORO91HDrx7WzEgXKUBMF0/fcavR+VKTC+ucfvzTPslKAOuLmttRZNlITDvu3TDp0FLIy+ctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du5n7IyG9NrHH71DldfhHLgJ5APMg54llpty4/uOGu4=;
 b=SyyKYk1Um8vPe4Bn3godouLz8xgdIowhpmgL3otno8xGS0uyNXxFOKVDa4T/NdkdFwHCxvOPINomSDr53GGRYnakI3/BWXpcxJhPiJRBvzu+H8byJKNScUrq45rLjkGHEd6e0ErUeTBF82iJDV1kyjnjvpOHJs42tX7T9XrkryI0aLMU1ReFYD4Lod8Nj32D1LSAMQEfb37+hE270bbAQy9t/C4xZGmPtTsSicI5/2LFqjJB2ML8tFQG+fwOsqrLyHccEqxMjKbNQ1Ejq+p0DFv5lY8oO7AKCeIKXnuPciRr4vU1klw2763Q/A1iKvlnkowSZITJ+cWwQB5krfLctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du5n7IyG9NrHH71DldfhHLgJ5APMg54llpty4/uOGu4=;
 b=hBcU7SXp+PoUDF02SP7pwJHDhokwPPr/4xdSt2UPIxEp1SBwXe5qMSVZGa1B4G1VIJo2Sp7W98yAzJ/jwjyp+sOEMG7RlRBR2++PaUaTgevjc1p0yzcsco8YaUMHsEAvCVHqxG1/4z1k3+ykbWmVv5GU5qP2pE/R5tS1fWBEYbiVfxhYnhHOUowrrmmddzyoiyARDAYaIo4ixbsf8MUZRxlm258DrvWWTXYe2qUqOqLigIaghwUX35lEw/4Q173AVynrpG0tnUBG/Vjl/9rH6UCj6Po4tc5KZbrtvdeLBg3riwOTwsZqb17PAhjznmxHn/JGYXiArirPJMn7bUNDlA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:24:01 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:24:01 +0000
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
Subject: [PATCH v2 6/6] gpiolib: let the character device free its IRQs first on chip removal
Date: Fri, 16 Oct 2026 12:23:38 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::14) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 877b1984-f117-464d-9879-08df2b673725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|56012099006|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	yqTAS0rApZsRr24FqPzy7cXqGbBesO/BLJCtbqQTNBxMh4QcsML2sbQ0dFptuIABoDXnU18bHKpPwUqOOyCfMP7kvoCg06NZfIIr7Tb02frvMKT+hr7JD6X2NJ4fIH4zc3W4vn7MRuE8xeLndXLZXPT8I2Gmeczu4dxPLAsV746E7X5mT9A6iF/bNF1jh5fc8CtIDg7AJrTqkCaIU4arPTokjN7ZTo/2o8angmGaHVNT+dnXdbzHAiW0cG3fjemDRUfFvghBgFeAxCrRO47la8c3YpcRnQMe0zbEW8+jPZiAupvWKRIekA6g2D/rZKj34ummYMiLzhze9bo5Z9MugTV949eJMkFCLpGgqVGd46ah2EmGf1MGY49udQukkk9W1ubXnFkSe3+nnTzKk3vbXscJjHIpkDGY84HT2EjraWVEEk1o3ZcQVWkRjRhdJQt07SIwglgiLf92VaoWdFR8enqKCmkfUjblWwKGSu3nBc7f6s08dGxPPD/tLBKFBJslCCyf+slejJ3sNcFP+QysBRVP0fWUja4KfN/dBfnr5nIQvuOGy3rSM5J4eUhesg2NXal20hxNiL/1dcuZE9D8Uracw9ufnjnqHhyA2PKmFm8XyYroCw8BefPwbJiMvnG39L5WYe6C8qbQSeItuQbBdOlqayOw593TZjUmvmyTZWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHAvLeiTcx/LV3uj8KDi2DFTqes48VM3EwFNZJHeHeHO/YBYlw9tN2J+2WiU?=
 =?us-ascii?Q?6GRqXs6Ltat5AM8MHqLr2yebygZwoAWoRiU+E6Rq8YNvR2OP91HrgYXMySF2?=
 =?us-ascii?Q?xKUZHAbXaRa+WwBsJvWKZb9AnmjhIDATzcDEE6sXhXYHbVKOpCrnN7ZfIQlf?=
 =?us-ascii?Q?gQoMQ5xzh0v37zeBIXZPJtGxBjjucxWlph8YFze93Tk8jJ9P5yP/8dmr8yP9?=
 =?us-ascii?Q?bSGgLqwxHh7Mm91Q67h3aM5U1gMHMjVqoS6BFoD6ic5Jk/8SmZjOj53AaJsy?=
 =?us-ascii?Q?iSmMb+THu+qHwrWo+hvJk2/9TkGh9+QSRmnEeUTaVCSH/cL4NTymD3gOTRQj?=
 =?us-ascii?Q?QzlnbzZ68eftm0sNQPh2fptRT4CyNex9CrN2937N3veRtN1oer0xMn8F8ykh?=
 =?us-ascii?Q?nG6i/q4cauuI57pWZ5239twEP7mdeTXwQr3MuvDXagHpK4lTRlq0RgmLnw7m?=
 =?us-ascii?Q?nY1ewjY5/d+szZnb5FWW2ajp6yOBXUFmOXXAuXk3Eg1DqoOzFDI6TUoe49/b?=
 =?us-ascii?Q?uBTodIPFu4zkej/q6G0J18oTPVmV0KXxXcF0C1jgdXklG03577WoUj3Q+cCj?=
 =?us-ascii?Q?ai/KerOt3wyMmIHLY5oWMFEhCbbXAOGwFkCHD0SSrbj3HoaSiz/+L4ZV3poK?=
 =?us-ascii?Q?Z/3U5i4SQyimnXqKXceYPU4lyrOVzcUWHoazfzjAVR1FaktvpEUovb/vclWs?=
 =?us-ascii?Q?GR9tZ0JCuCmAXQpKmOFWHvAZDj0J0b6DRs/RpLh7q1yL/NR59dJ0URWvh/KF?=
 =?us-ascii?Q?9BR5/tgXYHrX72JmopGUZb2NEGXi8bKs6slC/a5WbCDR7iCOK0Ogom9naAB8?=
 =?us-ascii?Q?eglPOCu7E++AKd2BG0SzEQvHDKnpR/m5orWW95cFtHnIlypr8cWT45cS5Pah?=
 =?us-ascii?Q?ujnzXKyvSnYWytvY9nUjr1ywrVe/Gr2nAoV6gBA73Cjv9qqbxLnlhNlGDRIa?=
 =?us-ascii?Q?gxPZAKOtP/jt3/xRlIgZj8BqOIs4s24cmFvUuIjlYvG1yg6ntuUXQyAni7ms?=
 =?us-ascii?Q?bktfw1KNZe4P1q08u6Eft5ufog9En9Jf0CfT87ytY3gQCyjMJ5Y/KpVE53rg?=
 =?us-ascii?Q?qbvgFvdZGEGBscxZuqqcRHQ4t3imeDwE+W78fyikzaYHZWBlkB2tfClLey7u?=
 =?us-ascii?Q?XmWweTyWgeGxXMNtBc1wclz08QIHnG/A5TfDX2saaFkg0PSkGF7W0A5Dy3rT?=
 =?us-ascii?Q?Ye53rMpys6lQ9uH+j9Svhq5n5i018N391UM628dn3pCvfwht/S3xZoUzOJYb?=
 =?us-ascii?Q?lJTYZ0qM72eYnKlKb6TDbLHCX5qMo15xUZZRKnC+kQKbGU8B3HlmqpsekdSQ?=
 =?us-ascii?Q?/eBhVC6/yEx3MgUYbD4NWlScGx/sOZgxU+U8VqeAUBh/TWKKACL31UxzWf2p?=
 =?us-ascii?Q?Rz10PRX9UlxzfKGMGLCS63CEnHKy/hp4dXAMn/eqXLi0SmxnrbO36W4abpBj?=
 =?us-ascii?Q?6qGl48H34kPEOsBbd2M+GlnKt3ka3N9dULhHlMxJYaSYDZeYuExyLrYVy3+k?=
 =?us-ascii?Q?q3NaHIhmTQ05ViPEj4zB/nPpMyipSp7RitndEM1sUJg63hUDbRuHZHMQbrkM?=
 =?us-ascii?Q?mxgsL1JjaLpm534468z/61VlIqYqxhRPe1ItYVr4rixwdlWaKhqve17cSYbH?=
 =?us-ascii?Q?0xB3m888BL3Rd6pS5kxnK8+Sp0d/67YaSJ8r2F69NaxBevUEAbHpomS6dZdn?=
 =?us-ascii?Q?fReYRQuKFSHhypBH3Z+fzPGM9Aw73vReU5O6ih2/LuNn/8UpGktozhOJIp+1?=
 =?us-ascii?Q?rX6UbVV4bw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b1984-f117-464d-9879-08df2b673725
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:24:01.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3FbT4Uz/VkbwMnjfhpyd/aVt+4OsRARRxgVvEimN5osLRzccShQ53CkubJbuTkh7NMiUWBcFRsWFpz6FgBiPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

gpiochip_remove() force-frees every IRQ still requested on the chip's
lines with gpiochip_free_remaining_irqs() before anything else, then
clears the chip pointer, removes the irqchip, disposing of the IRQ
mappings, and only at the very end, from gpiolib_cdev_unregister(),
calls the device notifier on which line requests and v1 line events
stop edge detection and free their own IRQs. That leaves two windows in
which the character device frees an IRQ it no longer owns:

- The notifier runs after the mappings are gone. If an IRQ number freed
  by gpiochip_irqchip_remove() is allocated to another device in the
  meantime, irq_has_action() finds that device's action and free_irq()
  warns "Trying to free already-free IRQ". IRQs requested through the
  character device after gpiochip_free_remaining_irqs() but before the
  chip pointer is cleared are still installed when their mappings are
  disposed of.

- Releasing a request concurrently with gpiochip_remove() races
  gpiod_free_irqs(), which can free the action between the release
  path's irq_has_action() check and its free_irq(), and then
  gpiochip_irqchip_remove(), which can dispose of the descriptor that
  free_irq() is still using.

Call the device notifier from gpiochip_remove() right after the chip
pointer is cleared and the SRCU grace period has elapsed, when no ioctl
can request new IRQs any more, and only free the remaining IRQs after
it. Have the release paths free their IRQs before unregistering from the
notifier, under the lock that the notifier callback also takes, so that
the notifier does not return while a release is still freeing an IRQ.
For v1 line events that needs a new mutex; line requests use their
config_mutex, which now has to be initialized before the first error
path. As the chip pointer is NULL by the time gpiod_free_irqs() runs,
have it call gc->to_irq() directly rather than gpiod_to_irq().

Every IRQ requested through the character device is thus freed exactly
once, by the notifier or by the release path, and before
gpiod_free_irqs() and the removal of the irqchip.

Moving the character device's part of the removal earlier was proposed
by Herve Codina before gpiochip_free_remaining_irqs() existed; with that
in place, only the order of the two is left to fix.

Reproduced with a test-only GPIO chip that uses the gpiolib hierarchical
irqchip, unbound from its driver with lines requested through the
character device. For the first window, the chip hands the IRQ number of
line 0 to a dummy handler while gpiochip_irqchip_remove() disposes of
the mappings, and the requests are closed after the unbind. For the
second, it sleeps in its irq_bus_lock() callback once removal has
started, and the request is closed while gpiochip_remove() is in
free_irq(). Each of 30 cycles warns "Trying to free already-free IRQ" in
both cases, for v2 line requests and v1 line events alike; with this
change none does.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- mutex_destroy() for config_mutex and irq_lock (Andy).
- The missing ->to_irq() case folded into the irq <= 0 check (Andy).
- Assisted-by tag.

 drivers/gpio/gpiolib-cdev.c | 36 ++++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.c      | 29 ++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 788a36475e5d..b4b3c9ac54c2 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1588,19 +1588,29 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	/*
+	 * Stop edge detection while still registered for the notification, so
+	 * that gpiochip_remove() does not get past it until the IRQs are freed.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (i = 0; i < lr->num_lines; i++) {
+			if (lr->lines[i].desc)
+				edge_detector_stop(&lr->lines[i]);
+		}
+	}
+
 	if (lr->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
 						   &lr->device_unregistered_nb);
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
+		if (lr->lines[i].desc)
 			gpiod_free(lr->lines[i].desc);
-		}
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
+	mutex_destroy(&lr->config_mutex);
 	kvfree(lr);
 }
 
@@ -1671,6 +1681,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1688,7 +1699,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1788,6 +1798,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1802,6 +1813,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1837,8 +1850,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1918,14 +1933,19 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
+	/* As in linereq_free(), free the IRQ before unregistering. */
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
 	gpio_device_put(le->gdev);
+	mutex_destroy(&le->irq_lock);
 	kfree(le);
 }
 
@@ -2097,6 +2117,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2832,5 +2853,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 31ccdd373765..7dd730228b05 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -851,11 +851,23 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
 }
 EXPORT_SYMBOL_GPL(gpiochip_line_is_valid);
 
-static void gpiod_free_irqs(struct gpio_desc *desc)
+static void gpiod_free_irqs(struct gpio_chip *gc, struct gpio_desc *desc)
 {
-	int irq = gpiod_to_irq(desc);
-	struct irq_desc *irqd = irq_to_desc(irq);
+	struct irq_desc *irqd;
 	void *cookie;
+	int irq;
+
+	/* Called with gdev->chip already NULL, so gpiod_to_irq() can't be used. */
+	if (gc->to_irq)
+		irq = gc->to_irq(gc, gpiod_hwgpio(desc));
+	else
+		irq = 0;
+	if (irq <= 0)
+		return;
+
+	irqd = irq_to_desc(irq);
+	if (!irqd)
+		return;
 
 	for (;;) {
 		/*
@@ -887,7 +899,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1422,7 +1434,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1431,6 +1442,14 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* Numb the device, cancelling all outstanding operations */
 	rcu_assign_pointer(gdev->chip, NULL);
 	synchronize_srcu(&gdev->srcu);
+
+	/*
+	 * No new interrupts can be requested through the character device now.
+	 * Have it free the ones it holds before forcibly freeing the rest, and
+	 * both before the irqchip and its mappings go away.
+	 */
+	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
+	gpiochip_free_remaining_irqs(gc);
 	gpio_device_teardown_shared(gdev);
 	gpiochip_irqchip_remove(gc);
 	acpi_gpiochip_remove(gc);
-- 
2.43.0

