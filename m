Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07F47012B;
	Mon, 12 Oct 2026 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813035; cv=fail; b=OapsiJXd4RnYzZbZAFPKiIvDPisP00urE4jfU8WhZg/LwOv5b70cOkKNv6Ud417pq79s7o6iriqrVy5acov/JFd8kPR54Cx8yJJzEjuApDF9caoqDiXIUuObOopisNvrEfmh8L3a6JguNFSrjE0IEqKcyXCdCGnnrbJbualBTn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813035; c=relaxed/simple;
	bh=Ra1q/7LhP4EjGNVfMkNykzLq7DCUueRtuMycT5ilQU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R9X0Je9mnUu+/WKYetUK7S3q/EhOvl1Ufm23VTHxPw7++7NbVMYfXUefyVHvrHCh7vpEavUPR0YagyvZS0uHzrWs23f6tABDclGvZb4CnvQtlYPLOBbmZKDaLmC2Smj3jxWHLpP7li8KGUB9cMr6it/ChsDCPH4UQWQHGGzBA9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQx6Kp3U; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQx6Kp3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7FuvL5TFJnADFfw7gS2c9+8iFefSmLHGl6ZvNEID7S7iP911clZ1C5Jgxpt4UGGJk5Lpqa7OpkGS0ikUh3+EA2BE4TBdS10fQy88HCrzGkte56LDBzaAvn947ZQQitvMPkjqDjx01C4ZirZb0dMLT2NkMlbetDMapycVIHRuIDxtwFNZGEEvzh/8NUqGglM8iLenMln8vdoZC/OS0U4/fJIq2B2VKof7r7dlQ0EwWSLccTy5hKaoXZnFMX1xodgUYwLOu335katRGGQzpMoEmcmRjR6d0yS9GK0WRCLUgkV4M5rDCJjgkp3f4qryEzASGLXfMmkpHz9psLmP7fq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F68M8LrU1q311qXeGc8ixHPI1kRxtYhRbDWHLanVff4=;
 b=kiF/XFda73CGutuGHe/u2GnvfQGvvnbR+zhis+bOB63zpF5xSErR8DtLfaf+Hb+fLktR2+ElLXLeP+t8Ci/MJPb0y4+tHiD1N47Yp1af5Z1MZUmnsfU8nrIV9uOqToSvoYHKg1ZI4jkP5S2Fl9as94uwf3y4e7zDkdRTy8EWMs81ACn4Ue4FzbF5vvrb6Gtl/JHHMBB/TitmLUn1ezEmZhovm4VS9o2A7Y5IeMD9ocUBYLS7Y2rnlvtdaY3GvVuf6/n9/ej1PwYcjl2pS9qKw59GWsrYrEipadAKHrRoSdqfTHmwSqe0UzOW5/7yU9/VcTEBNfiVayGKosePOt6L2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F68M8LrU1q311qXeGc8ixHPI1kRxtYhRbDWHLanVff4=;
 b=CQx6Kp3U95o7vhIhTlKYUsT+vcjVvuoDC22DSV+50VVv1Gd6ydhHQZv7RyY440ZvDGBQGidGtBNLpwW5gNIS5SQ3aaXhg8PeN5XD6BjXHcAer+B2akyMdlBhPbOrZx7YjZ/zEV/gicsucuzih8P/43C2sFN8trTYler0bUnhO3DepDPMyqkD2EXy9caQAFTqqHAc+WOelWhRmO66FzakSegNcDy5q3paFHxG68FtsxKfqMs0c+2Mfmk2XDv6F3oz+HLqsFaOERGMErmInNBk7PU9evWkV1QA6fTXq+mcY2TtNiL8+cZt+6QPp+Tx8b2vh7kwSGLzocqDDD5a9cDq3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:31 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:31 +0000
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
Subject: [PATCH 3/6] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Mon, 12 Oct 2026 16:49:57 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b41ba0c-6fe9-42e3-2e4d-08df2867c744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	IeMGCfymsBStthDKx9z+EonHLVI5pQqMaGrOeXOzr1N1X61kgHo/hvwS82Ya4dklJl6FJ36+G6n/eTW34wel3uCVqRbZFqIpvDffYmGRlCcF4Ry54xfG/QfuB1MVtceyYBLaus5uzXD55RKjkQTHb3h9KkHcbcVXR/slveHPo+x5ucD7b/bN1rABbys50KavP1N0R1eyZwBnt81SmS8zYg7p8KHuWmAMJfG4eLfpFumDq8IZZYeMqactAuzjiyo4Bg26UbAEfbN3SPGAI2kN6SA2cwxVqbEQyRDEz3cwf1zHiewrcaKYCgTLgLOpzL0NN8D3qw/DHSQo7iM9XEOgV8NfNszsFaTZEe29vL26z2bzPzn560+bUaAYTrCLN6HA6aUsdAqaS3cq96AlTQU8vkL3b2T5vtgN1j95Q1x12jNygjU2s73YSRlOlwj1IJuddKFk9sNbUmAga9AZ6Aipzlcal2+iI4ZxEO7l6hGvlfqWpKyA9XGnx9eV8S1wl2mF0lWPvUIVCrrWKSvSHy4ze5FnwEpF+TWfWS+7MKvWRJ8yApWrKVFQz+9mO8mOspkpTFeZF1guUNMwnncFEik2CPZ8MY3LnT+Hlj/XBP+rkNNUc5Rk98PsGJZRG0HRATfNB1zCZEfSFjyYOQr38oLoiGEiRvl798u7T5vCxoEOFq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44xHjWbJTP2tiv4FSy42FZmB0prYTXild8ip0MfoUCZklhxZT3u8LLtF5QW0?=
 =?us-ascii?Q?QpcGBpVcDmalkfhrFtBgU/VK/vXCvAEd8I9piHF15x0+cegYSVoCcF+kZlsu?=
 =?us-ascii?Q?oBQf6dIWJeOrcklhxvVwJGDt4v7f2ZjfVqviz9gS969+HzE7fG8TiGKFGlgt?=
 =?us-ascii?Q?ifdte+6ts7ZP44caVIJQS8tu4jdiF676MyJf7IQ/mzYxS3xq7apX852aYS0j?=
 =?us-ascii?Q?kQQ6ysAubwcNjBz1N1lv9baXEsYCqhVJwJuov+nz7T/zQgsbK2VZ624a1DZ4?=
 =?us-ascii?Q?XGqogyEv1zpJFbJYg+fBrLhvoBoqh1tp6QB+F4FMrtl0NRXrLdhOC4A8BZp4?=
 =?us-ascii?Q?7M3QMkMuYxtm0ONfRbuKxWY7rMWdd2gGn1TeN0WgzTWNDgD6oNV/TEaz4znO?=
 =?us-ascii?Q?0gK9JrzITJQFUtSODgy0SIGZBy3Vn+M00eOzdwgpw8mWNLAD8JOWgGZ79pAp?=
 =?us-ascii?Q?+YzZl5fyLXgqUMexJXdWhj0GXO/ik2gqXxuvCQHSih4IqG6G+d1wbkZ/4VrS?=
 =?us-ascii?Q?SGOh9ha1N9gzk8boi/1d3tfWn0mxCYdJcJ1P6DMR8pB7M5+0udfRKxu9m5l+?=
 =?us-ascii?Q?KzvdMLZN07LtqPJ0UI4Q+jYxu/Loa0qY7WMq7aZa1SCBveekS298BmZMWSm3?=
 =?us-ascii?Q?+QWAyLWDeYO8q5+FNpXqDrT+SyymzIkoW7yeEIy6paxG9CVsaIyYeJvJlvkz?=
 =?us-ascii?Q?xKjA3t3dhgoH6CZ4DdFdzT3Mf5PyfTkyiEtroJbu5Qdu2hOsq3kGUS0GTbME?=
 =?us-ascii?Q?EYAchhvTLkyPIcRufnamaSEHig+BdV3sFgfEVDUmwkK7W8n+ocDg4qQt8Jcp?=
 =?us-ascii?Q?FeJUoJ5p1mZS1v9sqNQ1z3P/Jgwj46DkRhk60aANK20fvNrpG4QRoih0EolS?=
 =?us-ascii?Q?3M5qCfJp4m0uj3yxxF5jMbIbaBWKbK/fZK3Pi2Peu1XreaGmKhuW5zPy4VHr?=
 =?us-ascii?Q?X0TCLT83Dv09e4TWaw2L8bZeSZ32DDBdkV9S2bZZZekVOFnXaX6pRIWuv25o?=
 =?us-ascii?Q?orlsTcq2LJ9PiQcT9jBVUYG7ouy0jaaAo4njX06MR24hXmlAYQcUoETqL2Ni?=
 =?us-ascii?Q?gpipJkSdPX+0of4zF8i31mhj1BObKoK8BiWPbpDBFq6/Sw7cuIWY6LhUoG2E?=
 =?us-ascii?Q?GbLarIxW92z1jao7nP0cG4WsdhK+r5B6jAUcLcWu3qw2V0CkYwEpCBF02V7a?=
 =?us-ascii?Q?gzMSlAuFV9EyxqCPr2Oqth2KiiV6pxUPvht7JuzOMLSjE6aBbZurWwIaPb1q?=
 =?us-ascii?Q?JrsZ8lZgPtcCKgu0muaJs16jecawlXy79Ckm60UM7lUjein/8CmpvdZWNOVo?=
 =?us-ascii?Q?v25Dn7H1w9gKuQwFauDFHDdTZtPfrOgTjOznCMx+m6PX0QsOJj2d51wWKIXr?=
 =?us-ascii?Q?P04Tyu2h+hoAQ+xNYCydzqujgWKx3/hfGX8tcFSFHOFi5JPuEddI6X4PKcMV?=
 =?us-ascii?Q?6DZx9dRQcSRGMqYTJSMi5DJvc9Ljs/3ryM2siCbiif20DsTkPXeY0wX/EFH+?=
 =?us-ascii?Q?ilsWmGJWZ2o0ZhPb2xXHbKmq1i5zHv/bGDe0BUFwQR+gVrfRpxoGzj/zLuiZ?=
 =?us-ascii?Q?Dwii7zDppNIiSw7iIFS+x5BMMBEbt/6dd7jbf+mzQi3/PA3M6EUzrCsgd7IB?=
 =?us-ascii?Q?KOSpAwJ1z4qA8+Kj9DALaGZ4OoZhTfc+L8VuRkTHIe1/VzdyrKjqrmZ8MpE3?=
 =?us-ascii?Q?LrAeqihSAQ6SMd/JT4pG/z2QXJ5PKmD9k8fGZBfhDFxgi/4hHyMfu43j3Zxu?=
 =?us-ascii?Q?J8WB7H3Ajg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b41ba0c-6fe9-42e3-2e4d-08df2867c744
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:30.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KpSflwTopBEyxLu45BxF87ih9zpAlVCJltcT5YZvqLHRRDdxlFJOL0dayAsdjXkULGLnBcIU5raRmm9ZtEWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

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
  WARNING: kernel/irq/manage.c:1881 at free_irq+0x193/0x2d0, CPU#2: gpio-hold/111
  Call Trace:
   <TASK>
   linereq_free+0xd2/0x120
   linereq_release+0xd/0x20
   __fput+0xed/0x2a0
   __x64_sys_close+0x38/0x80
   do_syscall_64+0x109/0x5d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 52 +++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5d53bfcdf726..2c9ec524d38e 100644
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
@@ -609,6 +598,17 @@ static inline void free_irq_label(const char *label)
 	kfree(label);
 }
 
+/*
+ * gpiochip_remove() frees the interrupts still requested on the lines of the
+ * chip being removed, so once the chip is going away the IRQ may no longer be
+ * ours to free.
+ */
+static void free_line_irq(unsigned int irq, void *dev_id)
+{
+	if (irq_has_action(irq))
+		free_irq_label(free_irq(irq, dev_id));
+}
+
 #ifdef CONFIG_HTE
 
 static enum hte_return process_hw_ts_thread(void *p)
@@ -975,7 +975,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 static void edge_detector_stop(struct line *line)
 {
 	if (line->irq) {
-		free_irq_label(free_irq(line->irq, line));
+		free_line_irq(line->irq, line);
 		line->irq = 0;
 	}
 
@@ -992,6 +992,27 @@ static void edge_detector_stop(struct line *line)
 	/* do not change line->level - see comment in debounced_value() */
 }
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq,
+					  device_unregistered_nb);
+	unsigned int i;
+
+	/*
+	 * Stop edge detection now rather than when the request is released:
+	 * by then the IRQ numbers of the removed chip may be in use again.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (i = 0; i < lr->num_lines; i++)
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
@@ -1792,6 +1813,11 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	if (le->irq) {
+		free_line_irq(le->irq, le);
+		le->irq = 0;
+	}
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1872,7 +1898,7 @@ static void lineevent_free(struct lineevent_state *le)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
 	if (le->irq)
-		free_irq_label(free_irq(le->irq, le));
+		free_line_irq(le->irq, le);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
-- 
2.43.0

