Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D8488219;
	Mon, 12 Oct 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813047; cv=fail; b=RhL+dfZzAtyjqQX+wx40O3+i1O5NuEnPlvnLleAYLOMFq9vTLPyztxdZrxXjzMAumjMEwyFcAYijx4ETgIrQUYwaxWvDGyzItuntC4c0FAYliqDK8QDO0Z6w1YspLt69JHtwlfF9GE9RmUEDsScgiSy2AyXukgHPAW72Xwj5r1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813047; c=relaxed/simple;
	bh=YNEZgOMuQLOWeq7ihYb69UkOnImF/QbHwblWOl6rcno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKLRI03Lk2feh4nFm2/C+2KPc5UoyNIozSrkW3Pl7CRIZMUQQDrcMyfj1+cZ3W21u6mBcjivHtnNytCEm3w764YQdeUB4mIOeC66hlu01Roy7AdplxSkkoSM3qZJMvBJo0h2s9Fe8lFzfLbDj60HR7Enq1tnqOxIOtUisXMybFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SM8ujP0n; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SM8ujP0n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFY3OSHr4xUfQoHSpIR9zU4mJOE14Xapc4uWezhbHsWfhzd7sOqGCjAJiSZpZteAGR2rpRnDDI/uwovMiZbLkcBnxi7ppcStUMJskqvClRhDELz8zajJiWLw9c2KLE9l6AevwOj+TFGc4OjDWSeTf/gPdnPMqpK/vAWA2soWe13pbxBQ+wBF8qX/Qrk8vRPWjrfoJC69J3J8DSd7xb0k6sjM4sTvtQWC1hvrsvLo+maBlvmu0uv6JQDiv5wpfRNoWXdc8tXqaKEcrAUg9NALSgLZo6zuj3bUusaAmHQNbVVIZj6uiCXW546jxol2Cilo5NsHlDAA66Z+41ZvzQ7DMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBtCROXs/aNCtkdGsMRlfDkbQ5np2ZeiIQs8O/m6yZ8=;
 b=Xqaf5hDwMSyfRi5LI0dV3tBQUEC26Q5iVJlVlOFnThJ98CDjwW7xYY/6zX/8sY7THjSkIesHzwjrQNJj876JBmGS4eCXRP2BLQVTzEUvHCGpVBLOzVvqxUMJzLKLEOXxezzb/xNIyawJo1lz4/gtswI9pN6+1z/l3BfM+3SWfk6VReWsBBOg5ClhOAuCTTtW15mUTGTwif1SfIroWj6EgWFoMbX1XQnQD+NwxluJdvPevSWPvxTxHWJANAP3mA2PmidKOBdjCEOa0/Kq1mYpSCb5cz4zowj1PyRD959A7WfxV9cl2x3AytfqDRub0Z6F74l9LUQIxrSPkaDbYq7iGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBtCROXs/aNCtkdGsMRlfDkbQ5np2ZeiIQs8O/m6yZ8=;
 b=SM8ujP0nE53FaOj7V2wY3LDw/UWz5GjHp8Rv4NCHUYB2NQykxhv6oB4CXaII5Emg4bRenp+jbHPeV/neOZoQyAsG+yxT43iY6yVyLcqDfTXyqV0mmXg+/5J8LaEVSxBv4EaYCZjUdpL6b28nj6bHZSFYZJoPazbgoaYldn8NNe8GV1GQlkPP5elQ3KTa7O4ZlGuTwYQotAn7EucCPSUa6D4oeRd/+Qi3KiiHtDC629dmQt/4QAMUv5GVBbWWS04cp291Jcd0quxTd+I9/50ciWq16dubSn827u+YlVhdkPfbvo17MXrCA1FuHFhxwqGFGEH3AaeDQ+X9+XrUBrGZXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:42 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:42 +0000
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
Subject: [PATCH 6/6] gpiolib: let the character device free its IRQs first on chip removal
Date: Mon, 12 Oct 2026 16:50:00 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a17c89-aca4-4118-5f25-08df2867ce8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	+mf2l9KZhI6mctd21f2IQ3NSfIhye4PHnKxdZWaYmPhQLpt74/mfFw+FHsNbc68pIDrmKVTiZ8pHqb2/xIQZmPMwcApYwZBXRntCzUB9vfJVym/Xk8SKNBORnzh9jfdvvm/I3cWy+FhpcxliQvnQs9+zS6DAOJhmJA/SRlYzFG8jsTeqkOg73o5yEnuu2KLfOF9nCQNF/RWTzSnGjsb86xXBYwt22Nvf2HDii/pu2fBLF+OVut60qTeO4QnsQalQi33kpbffuWeImcFKt2P2inH2lXc1O/Ft0xp2ErI4RjCs5Rs4HjrpG9IGmwBiw6oL0T2Of8h6clABAFiYGvtw6ZUf2OeZujsSTRXvTkTFAVI5VDBHJFqKJOTmzErmykfPSy2JNVdlTeOs7NdOfFUtRO1i+tsOuMcEEpHrvwBZHyybDy7tpfs7WWjncoNwlEA3+X0jRkYijY7QMs6k2VPAzZQHEyqMZkljn/fhHSDwmI6N36/Jhl4argM3c4kqIVFGo6prBxvIaQueGl8K6GlkGGhM8NDcyyicFRp35XeV3yPHfS+j73b8ybA5FUnfTo0nijuCarz/szE6/6jDiBLLlAaiwzZyb+vU7/Ro/De/jwZQR6UHov/DTjrmzCz06zY21sV0q19iFfP1MY7tpv4euI0UwmGA7Hm2l4a+ensZQF0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9JPY9AACo2nPe/HpjJZfG2zu7gu6Ne+aOg7TguVnceHfB3MGcsnE5SesuU05?=
 =?us-ascii?Q?OwbVTJR/1Bx1T1uURush+qsFGPfcu1YDJGHFBVPv9jAUaYaOGU+BGUk+HJTf?=
 =?us-ascii?Q?osfaWz/QWsC8Y2rFILBipdggo6/MmQrhL/8e7Vb6SJszLeXLDzTZJLJOciiX?=
 =?us-ascii?Q?fmgElItkM8cqdLOyphJsSnKqV8WlWLLaQx7N88JPEXOzAoSAvoEReefCKbgi?=
 =?us-ascii?Q?6swsKf+54E/EKzaEV3WtzzAiq7uCfLf1TPPZ0jm83LzuZXmK3d2c0yqWli3J?=
 =?us-ascii?Q?fHLXhBQ6390cGIEUo/LCVKxWe13desUFB39pLD3SI5wRLJAtu1K/JfjCcDtY?=
 =?us-ascii?Q?p38fK0WwTWmVD6IFF8Lwf2h45Tz+UshUfOc8N1BM7pQUlnU9iUq5+dgGh5iG?=
 =?us-ascii?Q?MpmH9sXHG4nYMMs2AEp0MlBTyDHoYxRJW1ylFG//8ijDc0H0/Km5V/3sCVEI?=
 =?us-ascii?Q?EhzVi0Lqah6sDYGEVEphLv/oC3Sbaybpt2zaX0ASOKW/pzaRD9t5DnauohlH?=
 =?us-ascii?Q?g4uU72knYLCYe0usC/60EUDsrC+kG8wLIn+6qsLnU0/XmEd0w2aLeYUIZKft?=
 =?us-ascii?Q?QZOD2pCGKa/nIupNDlvgJnunOLAY95Mfp+AeYVpExm/JZ3n0VazQJySVrp4W?=
 =?us-ascii?Q?CeBPGJABf/pgcZ6l3eSbvFinRvgqJ4XNqWD0xYFynXtjBXbd34dNXM5hRWbV?=
 =?us-ascii?Q?vW0QqPKSBx8rW1JlFv1ALOFeAF9BwdwzPZrvu0sGMxDrFHkyV5MLKP7sEl1C?=
 =?us-ascii?Q?R3vrY1prA89ccryDSWKFBUv2OLWRkCCZuaxgZhM+JKhHwY9GXL1KI1nIUYMw?=
 =?us-ascii?Q?7gc0eS2PbM1+M/ednuYcOwM2wNdvTLrBiDpRqtfFvoKaIFXR9r49ykbzY3ki?=
 =?us-ascii?Q?3by5zlDjKN670yJLBP6Mr54+/zs+LVqA8s6SlqZZo41BzzcikAqDF1sB5yw7?=
 =?us-ascii?Q?LkbJEzj5iRFr11GXmOZW170codMt5c8uKKzImP7pTNeddvoa0H+XFZf/v+pV?=
 =?us-ascii?Q?KB/KXE8KVX4iXIAcmYBciJeMo8vtMmJ32Bo+K/G20Jh30400IR93KzeesOj5?=
 =?us-ascii?Q?rGTL0M34uZVqiv1mssdy7DbUp+XxDnKcU3UoL/eQgDHuueBlzVPMxOopYL6w?=
 =?us-ascii?Q?7IxD8V43/D3A7mqaGOOuSlmWkpfC9FGLRv1UOu8eXfqOTFc46LIhCbKaloHf?=
 =?us-ascii?Q?1u5UTNMdn03IN4usRiXYiDF0pimwysDRLHevwW5bQnqjkdED1p1AviPGXW3F?=
 =?us-ascii?Q?GkaJsVFp7v9DJr5EK/u5qsLSGhMqN+MtZLmSJ6aS+/beHT4cJqamPXGXFFaB?=
 =?us-ascii?Q?TLc+8S4CZ9nNEd7x65HwlSf7CHJGkvWEUrwZAYfmI9xDg1gWrPfYxoT1vijk?=
 =?us-ascii?Q?kFEq40y6zYGDfRUb7HPmVDhn8nisamRt7kiusAeCCmM+Ksi0UdNpO5yF0nsh?=
 =?us-ascii?Q?Y8jB5uursLtM5gXxvl8lnVfQeu7el6dhiNoLDoKWMyMg4fhOFnNTo0ofxaCq?=
 =?us-ascii?Q?iPihyj7lj5J1jMDGsq+uOi0/SHLkrEsz1OYR06N5v+aCLjnPC+dOT1HN7j5D?=
 =?us-ascii?Q?gNMUjAicaUC5dKudpmFVLLYl8WA18LOOGAKE1PtB2nUBQNwleoLgbSSe0rYZ?=
 =?us-ascii?Q?6vNGXF20jDmkRnE3eMtUVbafiSa28jnOteMAQBLEltUEQN97v79edE6WDR85?=
 =?us-ascii?Q?tUQCtsHCUq+GDNxIjPm27fXpxMUpawZDFozmdFpsrOGMJCKTyYJJSEoPf4BL?=
 =?us-ascii?Q?PCoQwuwr+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a17c89-aca4-4118-5f25-08df2867ce8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:42.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdulqX5S/4HvlpwfZhBaYbqJF8aaqkV6wrYC7wVpHhYdKohxMcltjohKH3aFxdlY9VxdZkXYEzaiEK/inPr0YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 39 +++++++++++++++++++++++++++----------
 drivers/gpio/gpiolib.c      | 29 ++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ae19b4c3e9d8..7565c9f68060 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1580,15 +1580,24 @@ static void linereq_free(struct linereq *lr)
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
@@ -1663,6 +1672,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1680,7 +1690,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1780,6 +1789,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1794,6 +1804,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1829,9 +1841,11 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	if (le->irq) {
-		free_line_irq(le->irq, le, &le->irq_label);
-		le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		if (le->irq) {
+			free_line_irq(le->irq, le, &le->irq_label);
+			le->irq = 0;
+		}
 	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1913,11 +1927,16 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
+	/* As in linereq_free(), free the IRQ before unregistering. */
+	scoped_guard(mutex, &le->irq_lock) {
+		if (le->irq) {
+			free_line_irq(le->irq, le, &le->irq_label);
+			le->irq = 0;
+		}
+	}
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	if (le->irq)
-		free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2093,6 +2112,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2829,5 +2849,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 750378f3907a..f12f6eeb578d 100644
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
+	if (!gc->to_irq)
+		return;
+
+	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
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

