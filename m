Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0446E01C;
	Fri, 16 Oct 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142642; cv=fail; b=AW5IqITtzRoXx/M6W9LoKeqRcK6m8Q6ahlUBtc+97jgsiFtUYcYU/yckc2kqhV6NJ+GKO9LrCEWis8sMtMGlNb70NRd4EUBQOm932XTexmNFUEHEZ8YZ8jhL7QUJ12Yl4bAtS2WJgnjAZVtc67/7Jc/TSCuDKB12+YgSGE5Monw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142642; c=relaxed/simple;
	bh=z/otrua3O2yPhUwKaKtlwVC8u5LqWbFOARPYJX3Y0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRG5suKofv79LaCIxELNbmx84tKlvk91/c0kRrs6Rj7Z6pvA0WeBDPhg0umE/x1tlu0jNvPoi9LKSAQCt7YXvJ27/a1ENxImN8JnHDZCPtFRHGFSCtJd59F1TvxGKRiGJvLIFGNQ0TzF+2PH1Oa9yBmTMaMOOySb/FlRnMZESI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EFXcBF3j; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EFXcBF3j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSDCsXcXWbsN3tP+MorwWCuXjVLwRJx1RVoXS500fe9OTTRfxKmnl1Qi+IskRucubeUjpOxzd159aZgSC05A0dlHTAtetuEpgM7KZIYHYmhXo/q5rGGUQ53qXNt7KMbdjO9SJ6Mn5n0Ssjoj6wdraUVTUYzhNzQVOVNIR0QYQWOLZPARpoQcfwAQUUtMfpSE1blxvykmAOEJiacmgOmnFqw1HcMqcTWdpz6OBUuKscLzRwBfYbe/cZR34+uP2EOgEUYL61UpHCHcmIUKqIcHBAUWajYfn2CQb6b/WfgVwOOjHRhC26N5q1UzMLTVTETzlLiX9pa7So/J/67ds3yxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1NEg5wAwbeefxstOamh+3kQW1WU79ssvZ6z+dzd02A=;
 b=XAQZkkOWrvGMFvdMY6Z/PSWeTAVnY7GZ8PqM1JIX8LIxlnxOYRFri9jBw+J34Ffx9JMWSEaKmu36ZrN3gA9xjdlMSc3WLFIIZwtQpSeYjJ8lBp31yl+sgEkw7G/AC2rzMqAMGBBcwNgbq9oH0Qh3BMPoptIbQ5FHzVaOaTdc4t5tccSagMD2mPJ+iCGbqj+xVOtu1+3g7xVQhzzYEXtrQ5gB1Jlv307+zqR5mJlFmlRa5b7z2vzs4/IPSUoMw5sDV/FhaCgudVIwrOxCGIUszmhy2B8jIeBN+KZXhQzxsxXQYgQuAifWs2LIJKY/kumd0tQk4SUnP95rpPmBWCA8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1NEg5wAwbeefxstOamh+3kQW1WU79ssvZ6z+dzd02A=;
 b=EFXcBF3jgCW5ewA17lzun38iwv/4iNI1EfsetkcyZDO2vJNODDvSgwcaj4nZeszEvAI8VARQ2X0lHbcZdmhKBvm9VYhg97inlMA6GUJ+8YT0xps1rium0FOukX+GNfHRK9C7/sthVKQkWKdUAic07Q++nW/EvUHL8AJxwvu33Ns6MGNurnOD3wNGnATIGfc3SL1JwwIx9HqO9CTHNrqng7qscHDR1DHC9Qo2J3X5KcqHqQ9OQpMgMZW0NmD3hYZ+P2JTngn7fOY2dZzHLE3dCdjqQXnJb/1uV13kQdAMPFxG8yrg5J5WLk5KJIL/fLwx2J7jfKT2aKLRgqUcreprmA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:58 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:58 +0000
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
Subject: [PATCH v2 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Fri, 16 Oct 2026 12:23:37 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::6) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8209ea-8d19-43ec-d200-08df2b6734f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|56012099006|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hAxb4QFmblXoKHB7ojU3QaHkW2OA6jbTGQq6VhRm5Cuy9uaAxBwJAQrVY2z0IR7H3QNNiTqsmgo1xp61H1MKzeO+n9pVQa+fXNOUDaDsZSeXNl47O3Qi1rr9zWwz40NIFkh0Nbzroo5Ura5GlzifXYyYxZQEvOGDwVywm+cMN8oaAnOEZNGJxk8QLVMvQgiOsvok8dKGwo348Fv41Ge/Qo35elxVi6xWSjIvAbkvcSvBcfqOMiyeOw5rrskXGM7t9ouYVLqnC1oTHTwQ6hoLUeKZ9hAXVQUOJPNrQa7OuWLMr/2dOmD/kmadz98wyTBAW0kLTIojmV9gFpujxrKhbmoWr4DpkxrCj40mWzreZgxYbyWFeW1n2ZcskqD+mjovXlNylbmZTLanNpiSOCDtdW4X43skWwggCjJAtmBNivn+dayIOxaQv4XG3ni6wBE4blzvzSBhvK6BxiWMOVj/eZJ11EzFa7RFVYUN9aUn9xqP5nS0SlKfeu+gl095Hsyu5H6kdpHRU2I2OBVcyWdhnTBgPoB3i2/+YdP2Env1fXA4t3jKkj91rya04acskjpd3vpqf7OJEfTjLG5OFe3wNOnpM9wFsJ/cekjBwTJc/4dXHoGEgjIzBpGV9QA+NOeRSMjqLKEWZ4xfYtmbA+wMEfWtiPLMLnX1MN+Yk/qF3fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QPzSBFeZRjmVxX2LT5cA8GQln7uM85eKSJ64at83byGdZCd7y+l7vSdjSeap?=
 =?us-ascii?Q?w/BijDLuLtr2ocFQAlzE/pj11jSEJeccaXygRRH6V/yegDpnuh82L+/GA3Sx?=
 =?us-ascii?Q?3EdN/gLajoPdoELq05VwR1OK6UfK5Xdy2fTqnrFEV+KQ5cr+FtFmDJJohf1j?=
 =?us-ascii?Q?q7tT57dpd1zSyh8V6rWhNFdVQ8+oeMF7Pv8lAFXWXlfGYqz959y9eaGCfet7?=
 =?us-ascii?Q?jgqgnOI08KwMYkybL0r80lKGQCFBZ8oPRxWwCnhX3hfSjikSEnk0rsZCP2JS?=
 =?us-ascii?Q?MvUX4L8TKZNbVzjsgmajJQaowqral9aU8JkJIMsYmvTXJH5Q9VIIDhSBIDu4?=
 =?us-ascii?Q?xiZUuREHfLC43QcGThXkm4hPE/wnRizfhPCFRwLRHnnyhVL6uqxWnSG2hD/N?=
 =?us-ascii?Q?+51504uffALv7v3uKCFJO4IOxnnLU9xZL8FJYecaBx4TaU6Plqgh/84CDNF3?=
 =?us-ascii?Q?fyqXYW1pM8oFKg3KLOvUzKbjlaS6zZhKpzxpMK8HWn/4s+J3gw2oQz+91uQW?=
 =?us-ascii?Q?wGD5+Skm8k/fzI4yg/PhbBKwFnCn4bi9QiNIzPo5BFAsNOquWzxsJVGo7hO0?=
 =?us-ascii?Q?G0jv0NHL9v0isma7QBmU2KTxV7FAL3PoM0lLyqVzzUH7aGPntX6KR/FiWx2X?=
 =?us-ascii?Q?QEB0abunyaDktm9NS2sKWGPMBgFwmTWH4LNFvD1JmL9+/9Tlxbnp0f8aUYdq?=
 =?us-ascii?Q?wpAaUqIIhAzYC+mHjYkYwOjey7cbOQ7sDM/aZoHQVQ4K+dy+nL9WEc/pyKqA?=
 =?us-ascii?Q?66B4Yt2Xf9jPPgRbdOAJZlegT8USzI/O8iEAlBsMa7pocNEpKd/QV2Zyfb6D?=
 =?us-ascii?Q?WYVFQ1zaDjoT3w3d+J1mG/PMqSjlSgHmTr+xHrDGfZm+eS8za527sJOgLVx8?=
 =?us-ascii?Q?vp1sGnMykJVWdv5QkrBMkP+8gFMX4tsvE/LGgzcx6LCZKfbJnZR4XXxF0MCf?=
 =?us-ascii?Q?duiauqit+uIyZRHQthgWiHhn4LdR4Ez2L/vkm1YKdN3MZTeScMe24Rh0goUK?=
 =?us-ascii?Q?CATrfkfoRkxTu9V0fb2GhnDIbGNL5O+NOX939afSXvvI5ZFqJmdsukKqGyUb?=
 =?us-ascii?Q?Y2IivKyGFdmQ3TYvFcJUSJ2slkoLmbUIQBbEqj+l3TySm7ZOycwljjo5V0Rh?=
 =?us-ascii?Q?FmzoDfhoCjWWep1pY99DKQJhAIg2lsHT9jrv4HbWSGfKEirHO3zYwqE3DwAo?=
 =?us-ascii?Q?sFcxPGFv6QMmdNMTpZxgS5vsgHRtrFOKt5JLUy8LFsJXdvnEU+NinqSEJ79h?=
 =?us-ascii?Q?NrAwpj9ZuK9xBI5PNXBXTIbGMAKnsaBhAqtxuMHrU/OCCJbzQ8lsiKw7hdWo?=
 =?us-ascii?Q?XZay8ip8ZrCYr5AwCGmOMm+oxIl9DtV+IHkNSVuxV4KbGp/X3YYmBoSLq1xK?=
 =?us-ascii?Q?xYYP6il99DZFqNPGHrK1kdDEU9nPjsyYNgA9Pl2yFTEIX2oTCTZNjeWqP3BY?=
 =?us-ascii?Q?bpwu+JUSUlNovEVlmT40Kme8qhVaPVdH/3i+dVV2CnCXXhQqaIZ3LZDv40rL?=
 =?us-ascii?Q?YR+5jyPGi8TFZUuqt4mAJeqy9uXpyJI/rI20B0k28x4OboBd+jx0ICBJNXpR?=
 =?us-ascii?Q?GdNoRzM28UGHIM/Tue5dVuuiFxfxjimHKlsLONT6pnDFmDMGwkeeqf0SxUIy?=
 =?us-ascii?Q?NjIZ+RQxafXntP0OFm/C6kYq3uIgdz2eFrZaxk8ZztRvYMkqbkNakXpdyvUE?=
 =?us-ascii?Q?wEM6Q/83M7qP5hy9DN6oaYVLp86y0gE1VEdSoLpARTophBQcm45JbAOf6V4a?=
 =?us-ascii?Q?75utQ3Q3pQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8209ea-8d19-43ec-d200-08df2b6734f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:58.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzG/D/JVwK2ClfxogQ6TuL9mSAiArXMcHajv8oWovKlJ1/brVu3JAk8oBwq/fJcIG5Agw/kUgheR+2J073AO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

The character device requests line IRQs with a copy of the consumer
label as the name and frees that copy with the name free_irq() returns.
Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() may free the IRQ
first and drops the name it gets back. The character device then does
not get it from its own free_irq() call, which since the previous patch
it does not even make, so the copy leaks:

  unreferenced object (size 8):
    comm "gpio-hold"
    backtrace:
      kstrdup
      kstrdup_and_replace
      edge_detector_setup
      linereq_create
      gpio_ioctl

Keep the name with the line, or with the v1 line event, and free it
there whoever freed the IRQ.

Reproduced with gpio-sim and a line requested with edge detection and
a consumer label, the chip being removed while the request is open:
kmemleak reports between 17 and 23 such objects after 30 cycles; with
this change, none after 100.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- Rebased on the free_line_irq() shape from patch 3, so this only
  changes where the name comes from (Andy).
- kmemleak report cut down (Andy).
- Assisted-by tag.

 drivers/gpio/gpiolib-cdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 6f84aaa95033..788a36475e5d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -399,6 +399,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
  * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
  * @timestamp_ns: cache for the timestamp storing it between hardirq and
@@ -422,6 +423,7 @@ struct line {
 	 */
 	struct linereq *req;
 	unsigned int irq;
+	char *irq_label;
 	/*
 	 * The flags for the active edge detector configuration.
 	 *
@@ -601,16 +603,18 @@ static inline void free_irq_label(const char *label)
 /*
  * gpiochip_remove() frees the interrupts still requested on the lines of the
  * chip being removed, so once the chip is going away the IRQ may no longer be
- * ours to free.
+ * ours to free. The label is kept by the caller as free_irq() is then not the
+ * one returning it.
  */
-static void free_line_irq(unsigned int irq, void *dev_id)
+static void free_line_irq(unsigned int irq, void *dev_id, char **label)
 {
-	const char *name = NULL;
+	const char *name = *label;
 
 	if (irq && irq_has_action(irq))
-		name = free_irq(irq, dev_id);
+		free_irq(irq, dev_id);
 
 	free_irq_label(name);
+	*label = NULL;
 }
 
 #ifdef CONFIG_HTE
@@ -936,6 +940,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -978,7 +983,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 
 static void edge_detector_stop(struct line *line)
 {
-	free_line_irq(line->irq, line);
+	free_line_irq(line->irq, line, &line->irq_label);
 	line->irq = 0;
 
 #ifdef CONFIG_HTE
@@ -1078,6 +1083,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1781,6 +1787,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1794,6 +1801,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1829,7 +1837,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	le->irq = 0;
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
@@ -1913,7 +1921,7 @@ static void lineevent_free(struct lineevent_state *le)
 	if (le->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
-	free_line_irq(le->irq, le);
+	free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2152,6 +2160,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

