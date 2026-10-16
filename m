Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001346E01C;
	Fri, 16 Oct 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142635; cv=fail; b=CBBpO/stu8lZ3L/PendWHQrQcNhOLptJYNq7roY99SrI/8Liq93gFhU2hnwTtNTRXMSXBxAc+6qorcodyKm2SNwI0b2+Zr+7BP/KTodKlH7eaHoG0fDS5tk8kj85DwRt6ZK+Z3uO4BIJyQwrOGp42ESoxHn4Yo7ysvwtjICxk0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142635; c=relaxed/simple;
	bh=DdDP7GVmR5zuz6sp201HgiwiksWiRK8qnybUEg2piVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJHnsvvrBlJCkF2+ETh0lpKinsB4GYsLmI5/zqXyG8WYGERwl7R5ENcxshkPVkUL75fteu7wnmdnLx9qqRuZnr07QIJKkp7rXwfQ8wqEBJ6T1mwLvkNLV1vt/LgylHTeFiZXecDoi+Sj8ZEVrETPgqj/RSnZvheEmi8ip6puHyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c94pkhbl; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c94pkhbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSzbTrAGPlb2/q6D/c7b5OPDgxxqspPAyYtQghfT6zRaklyuewGTC+QFRwmamddJNtXr4Bu6o+K+oLYIPnBVoDbB2wGyDELXRjgHy8HJG/FtHpUJmOr/i5tEY/pTGXDFii5JjtM9C1rO35TA8OmcQnc+YG3RjWPjlcpb0bkCa+eQoFeuvr07cKB/O21yCWo71/GkwyEljZHcbHZAxtCKepVgj2oTrEO1NLHrrySY6KFSBzfCl4Y4Yih1RsDXmnxHahkpipUc+EV1aE9zhWN5i+j66uvuck+j4L4rhH9BpSJvtCMEVtx1clG7SbpOAFihUd7RDQTAvUn1+7cwj75dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXiDvxmLfNPskMmzZQSS5qeblkAxbAFmzbGxN9mDd7o=;
 b=ytCc126QLLvfCI4PtiY9/sNM98ZTTIL8D3jp3SyXO43k0PmtdrlwdclWETDmixEOJff9lShzE+rZZ0CnB9PKWVgF4Kuydgw2cnHTptQNy2u8VvYqZtxrWe4hIl+w5Tevr/zpTIryDpDSpEn/I+KZZ6lzRp+gz5t+pM/xCT73XClwb/GzZXDl8h2cp01W7nGV6u/z1jl/IeZwTY7Yoe1gg4S8zfUkQqVrhuRwqFDxJufLrUfESjUscW8lrVL+Buoa5d9kYmexzFsipuNfqBi4HQII1h18i0i5mqtYd14a8j9QuJ947GqMdCKbORzcF0cdia/gzY3cLp6zzC7WUOvgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXiDvxmLfNPskMmzZQSS5qeblkAxbAFmzbGxN9mDd7o=;
 b=c94pkhblPnW9X6enn3ID2ojwVaO1HdB8XhxI4AL8ePHy/zqoA7I1AWUuQ3SFzbs4mpFD9WzjbAf9WTxTBUGj5+H37ujyTIKeCOy6GOKYVDqBbDyYd/CPoMzDUY45kC8uucVRXoIlf1NqYPoxuigjdZbNUeg//o//mX72hLlzeHe27hOLDkUzTElgi4zv5mPH1iIZyxh1yNmXqneHfUkiUnxKK5zSj4XKdiAZoz7PNhb5u8xUCQpV57gwDSxO0gn03Fz/MZFVkKD9+oj0kS3VlCOfkerZqiREA4gBLPxzNa/6lgqWq0vYLHFZ+uHtpNOccVreLCtAJsLGY+kT+vLUOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DSVPR12MB195923.namprd12.prod.outlook.com (2603:10b6:8:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:51 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:51 +0000
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
Subject: [PATCH v2 3/6] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Fri, 16 Oct 2026 12:23:35 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0197.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::12) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DSVPR12MB195923:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d42abc8-52ba-479e-7103-08df2b6730fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z0OXdMEGrfoXCE2xVq2aNkia4xPJHPoc2NHzZf6MwdWdu1dccV8pQPW4Y45xdOWJ3Rsxws+Erznikv+qENqP6LubgZfjGZxr/Ln663+2bQX2CZZuGjfU58D7C/y/uq7xq5LKF37ESzqBjIBChufyItba9y9qIygG9YAJFY24/UzUD0YnwO0jJd0OFiA6ZNPduaGJBPxvpjsW2meGBTEYF24RK0vDguDiIuBXJ+bz4PnpjXsMixI4VP5pfn8MPr1uXtKgDNQQaDbneegQfcAcpVEmrQ8hKyWUSFtGnyr4qJCwEYn+uNj3G5YSHPm+1barST9+Lrg13qNH+9X6HbekMRcvA4RuQDjjqOQNCh/zjroTpjS9qwU+PVA7OcCbnJ4xPUnQCXmO8Atz+YATnnbBG39DyvOA1i8aS+hZIULpCmxpYjTwALBVe0uBoaEk1ot7RzfXgIo3H7gPIEdRmzfHmwXNZ87o/T8wkqN9Au+p/lQdHgyGgZBBRxNHx7ZB9kN6U4Yh82Bxuxa2PxCvgQaAuJhVL0zuGQMjQmcXUg5xfkWgPbYlxsyNg8Bi8sOtTtuh8jYgNVI8hEBVrFtHJG3PH5OP2a3W1iDQakAwmJYWNlIoUxzACY1HeDd1+RjBg3NHPmW+eA5ZgA6lqj4PHxIxYTUPscCUG6GACdwMye3nuzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+XQ0Sf4P9iY/6q1uH8FH2Zw06njsrtCDA9lcoxT7UB+ocXfXpcg7oyzboRI?=
 =?us-ascii?Q?equbnL5cKvBJXQQhEnHIS6TEGm2kXl70xdy+41tZx6S02BIilHfz39age0Sa?=
 =?us-ascii?Q?dAsI+quBpHMMplcZedI+QJAKuMXsS0mq2wa7pvVZJvxPF/0tY2frUV+FPVzH?=
 =?us-ascii?Q?2xltxrusIVDKhVy++gbiT7v5jEwAFP4889a2PXeu5FOxPRmAlSTh8nqOrcbr?=
 =?us-ascii?Q?vsv8UBoiyaAjdQ3ryKOEw+zR1KswZVr8MSonOjVwbeMEmGEDTfFA6XW8C6Gb?=
 =?us-ascii?Q?d+CNhuuVmucwn/1zMIW4F1gsTccaWtoy6zUoU7vuD1HBOeApA8M0FUSpUuRx?=
 =?us-ascii?Q?ORs7a3j/s1LW4gxrMeQMaUwMJkT+jvZKtvGVXt46aH2ruETHTrw9FfOvej5Y?=
 =?us-ascii?Q?jgnyxSDpDrkE/kLnJ7MN7pWtraWYOh8bg1+MBazPe9zMbyWiTXJhxK/Zil1v?=
 =?us-ascii?Q?otmIBNN4I+OlRpxsaPDIwms3pVoM/GlXS/bVW9laeHPgUJSXh7y6JUa5MEwN?=
 =?us-ascii?Q?taeXf70/Rxwsw/bcVi0gGJbmnqXDJHCl9OMvsDNzeYz3bY4dfpCBYYEHA8hX?=
 =?us-ascii?Q?TTYtRYXAfepbF9kTJCvz46jkK6KA+EqUMClTdDJ4n7SnlJiKqxUNlIrG/HS4?=
 =?us-ascii?Q?R3KEoiIPP2lOtLPFZ0QVuBKSTeQ0YgZGCQPLuumC7BdB3Ce1Z7Q7TpD8ekAY?=
 =?us-ascii?Q?m1aKuApsqdeHebFl5tYebpf98YbvqoGXd14sZHFRzz3r2cyauuyyFwKKXYK4?=
 =?us-ascii?Q?w4IGWKeQe9i+s21e9zi2wr9g3VNqcOeG4gxsiZ+Ra4BPss3m//NMfcyN8wUF?=
 =?us-ascii?Q?OUjPQmGzAq0nshaEIYr+zBSfpEJTfbSDolikDvFFL6tUfrfr77NA9kHTPwR/?=
 =?us-ascii?Q?YyzOZSJcPDzr/bNZD311IzBGWXYlbah6NUYGMaCvaZJanRYPaByHmjXwlWm6?=
 =?us-ascii?Q?Xv+48JBMi1cK/glYutYQhb678s7uLbB+ppY03LiXEJQqBeBlbokA9aaFo5Sr?=
 =?us-ascii?Q?ssyQhjR1K7lwsuveyFKtkskNJhuawlWYUhoo4FHmLbeo9do/slZ8/vgweu1P?=
 =?us-ascii?Q?xYcph2OGPj6Myt8Oa7esO2iOvd5y2Ec0uTsgO1MKoeB3LNObPqnVcSbMBHA3?=
 =?us-ascii?Q?SYW/cOS2fopYUgx6glI2/WI4psFBezSzXpUEtEk1X0olJoGUTgKVygAyMYU1?=
 =?us-ascii?Q?osyKUsJDc0Dw5af13yLq1jie7gyRVhr1VGUqcjcxJM8sjp0Jw9pEeSLSlZM7?=
 =?us-ascii?Q?0/SJBlodwO7tarXmYg3+PtqxNZXRadbr0xAh3y6K6BXQJc4dBhOAEHKKKU1r?=
 =?us-ascii?Q?6gWR8fq716vB8sKQvgFRpZnpU8BicNYLMAwOymwEW2ZTNt4E+qtm3uq2r5qP?=
 =?us-ascii?Q?K4IRJ/0U+Uq9tve2GfVlrxWGerou9y1GmG4sSlVWOUkxiX7zOAnmtbZf0GL1?=
 =?us-ascii?Q?YI8jG6I9Ph3MApP88x0YKeXZtOOhuEOKrXlSxvfbkPhzMpHMY04CXQ05lq0n?=
 =?us-ascii?Q?c9cWpowfSuq/pzHzvlDWIrt3gBVF0ng+l+GgU53R+rvfoyN7qJaIKwmAIg06?=
 =?us-ascii?Q?TfCs8HFdaD6JA+HKfn0kb9x4r0lcKFKLP85mEMwVoLjjf39iXrJ+o/3u89ga?=
 =?us-ascii?Q?Ts1S4jkKXz26F6EQazWvdM7kbN6JTWlY758JGhHbVmMBBTQuIY366koRoP6S?=
 =?us-ascii?Q?0j245GsWIk2yVI93X/qvTCF09A/MN4ehD1ih6Clv1qa0mSA5ulangpxtswtl?=
 =?us-ascii?Q?nVlZCTmTTw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d42abc8-52ba-479e-7103-08df2b6730fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:51.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoU/gB+UBznDn88EeWVoWYveEpuQhmacsKZ2gFnYTv4Ne/OCMj5xhecj+W5MBQOK8VGSVq2eUL72vgQy5UiBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB195923

Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() calls free_irq() for
every action still installed on the lines of the chip. The character
device does not know about this: a line request or v1 line event that
user space keeps open across the removal still holds the IRQ number and
calls free_irq() on it again when it is released.

What that second free_irq() does depends on what happened to the IRQ
number in the meantime. If the chip disposed of its mapping, the
descriptor is gone and the call returns early, or, when it races with
the RCU-deferred free of the descriptor, it touches freed memory, as
reported with virtio-gpio. If the number was handed out again, for
instance because the same chip was set up again, the call finds a live
descriptor without our action and warns:

  Trying to free already-free IRQ 28
  WARNING: kernel/irq/manage.c:1881 at free_irq
  Call Trace:
   linereq_free
   linereq_release
   __fput

Stop edge detection from the device notifier that gpiochip_remove()
already calls into, rather than when the request is released, and only
free the IRQ there if it still has an action: chips that never mark
their lines as used for IRQs, which gpiochip_lock_as_irq() leaves to
the driver, keep theirs past gpiod_free_irqs(). The release path then
finds no IRQ left to free. The notifier takes the request's
config_mutex, which is otherwise only taken by the ioctls, so that it
does not race with a concurrent reconfiguration of the lines.

Reproduced with gpio-sim: request a line with edge detection, set the
chip's configfs "live" attribute to 0 while the request is open, set it
up again and request the same line, then close the first request. Each
of 30 cycles warns as above, for v2 requests with and without software
debouncing and for v1 line events; with this change, 100 cycles of each
pass without a warning.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Reported-by: Jia Jia <physicalmtea@gmail.com>
Closes: https://lore.kernel.org/all/20260817070429.157993-1-physicalmtea@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- The IRQ check moved into free_line_irq(), which gets a local for the
  IRQ name, and dropped from the callers (Andy).
- container_of() on one line, loop variable declared in the for (Andy).
- Backtrace cut down (Andy).
- Assisted-by tag.

 drivers/gpio/gpiolib-cdev.c | 57 ++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf726..3792ccee4da0 100644
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
@@ -1792,6 +1813,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1871,8 +1895,7 @@ static void lineevent_free(struct lineevent_state *le)
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

