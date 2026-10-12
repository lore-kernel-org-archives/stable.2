Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72965477998;
	Mon, 12 Oct 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813045; cv=fail; b=pHSfdPlMcoSgCslvJCcUjBSbAm+UYA9CDN2E9tZiZ7XScXOMhvbWQ2cNQr8vH1hJD4zZ/E+52wMmT4jVH99Z9T+QOm9EBN4NXKK476qF6cJRHCZ7aBwNNHJn4ArAJJxas8SzhkzAEEbahl/8Tdvvjm+j9DMscUasScHsuXhBXmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813045; c=relaxed/simple;
	bh=xjgrxyTGTvseu/1Vswc2RL8N6begcl/LwbwZiRhuicQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQnfNDd1JptBMEDiBb2r7HllhdMXzWSfUdEF2NxHZTmGQf2KlncWnWO2/2vvRrpjNrJa7RuNLtSs/BdgtPzB9KtWkLPj/eHbEFfapzkA690AMgSwqxUovkFw1wRUiZXZaHgL+bdDNSf4wmwm6U0A0ZtCHElZMYq81T4NCaAU2Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mBDzbzGs; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mBDzbzGs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nny1fYi3ib9xGe8hIisgRvXXF/5fIGMLvfcynjA2qlRixten4orno27Xk8KqRQ4HjUJfRw4Pc7haSZcvcWaXfjeamPLLDx01gFoAJbGeiPwHwDJTtHRsHdeptOCqr0nnQQssTsHhasPvu6EbQcXINFeBN8daLZ97/2md3sWYu4CMugNcN0C+5OBBVw97HXiUVOvmbbIFQ/RgAVFm/hm8iCjV5BJFkp8SLfVHXEKFNAw9PbaD4GR46XqZ+vVfTLwX5JJfL6GdKoA+yJEVYYCvMBg+qFO4dOQVg1ETritbmPfoz1UJo+Ta7ofx44ZiIYFx89Q04icVi8dYgAJe4XKv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU9DlL5vLChAfAFzagbAhbO5iN4eayS4v6//BNItbAs=;
 b=hFcjRAGt6yKqq0cHdaV2WLFjFzwMXYse0F34gmdxhJNt1zbVVHrfeNdWXlwk7vzG+T7uyaVQ1OrhAM5Ip2HZNy6zpKAhDFYywKH5MFFFBwByDgMK/FeU7zMp5MIwSkqnsH+PFCi698OMrhXhQ+A7a+tieuEwxEGbB0/Fqba4vmd5AJwTk9g3CX77pW4nbIJOJxr0B0Y658wRfjrD07VKC8oe2XOaAecxB0glRMatROu4a3zQZYUu6igYiFQCS+8vzu+UA9av/w9nXwQfdsf6rSRh+Ext8fxbFnUSIwIunGMivjrfg8aXpk3I0co2pNuumSwRKEtJuBVG1LAoCwb//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU9DlL5vLChAfAFzagbAhbO5iN4eayS4v6//BNItbAs=;
 b=mBDzbzGsqshpc2tLMroZz+rNgBjjHaaleEjxgdDqJeZbfmGm8Nw2im2fzQkiL9CHbgK1G5UYT+uyaz97uXRuK+LJq1HiXV7AHUgiBDAlO2pA6KfpSvf3V1ddDkA+qxAJjhghdOGiWEBRqcRIgLAq3Jl8DeSYHzXTI11ka3YWHO2YdwVGau4E+rkGvzPoOhp37JOGQRG7iH+pmiQWsFfoYTuJLivSUvXNpLiPfKDlec+EdEuKZrH+W4iEX180lk0NVQLSKAXbMH/MbkWVoNx2QgzJgG389LzOTu5dpVbHRD7rm8SlBjsY3VWzitj+xB+mD+hKiXqv6FeSx9fuIgXDIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:40 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:38 +0000
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
Subject: [PATCH 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Mon, 12 Oct 2026 16:49:59 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::20) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 725ea23d-4e3f-4699-02df-08df2867cc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|260925021911599003|260925022911599003|11063799006|260925021311599003|6133799003|10067099003|22082099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	EfsW4v+mpRHD/li5mPpq3TdnaSXAWx3EZLbvTCnKZN/qkBCRWcm94Fv7g6Ylyvyg+NjwAbzQrXpmJM0Btet8ZKClwX9fingl1+rK9P9jOmgDWxt9i13m7SJXNqZCWxvM3B6mALMwCSPMSOdJOiE8CjiSfNuh7Zs/37B5DC7vpcQcNKyJO26RutoyOzY2NOHzIaHPiwb3ncQDptcjy+fWaAgAgzI9kXRobZn73kEwTm7E3XBBylGOFUnX1o+Py2b1FFM+R1VXhwobReBNVoivuI3voO7bsmpGXOeoG+fb66w3e7se6eL04wG1o+sltwLdr35C+XlwJJ0HfMXysYfLTNVdT6kBQF42QzKCYDXP3rcDLpEjJ58qFwsLXheYiEKZ0dUsifysqDEBmpxGAgMO132y/YpcNWStXWovxeCkmXGhF9vYvgJ3C9bVFst1ehx7XrAn3E8TPdWJ2FLUamlreNPP+a3iQTfbavLG26VSzxUWzjyuPt3nJEre/lPKMWYUIOJMvEmRBbLNDH11Uf19qUF15wTzdUWPr2quvRRUh3brmkHF9DEPFaLPK7PMEZyuQZMrunWgYsM+AwooZhB80kYF0cpa06vjQZXKKPiBCOVRf3Olalv0o+bl1QyjsJKnmOpuXRbyydZie0nASZNfPtBM4gq7rkP5+fUT+WOb6Ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(260925021911599003)(260925022911599003)(11063799006)(260925021311599003)(6133799003)(10067099003)(22082099003)(18002099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oDU4J1U6YMzeV5txd13Czpo6ASUTuEBGaAI1dcPzeuLclEQr88SW2mks65+s?=
 =?us-ascii?Q?J43ZvKE1MbK7qi6jf1sW+cNYhAFcBOdLCZawvQ1ExOO0fCVwkFN4TBEr+Hyd?=
 =?us-ascii?Q?4czl0Y9YWIrNwIDuMuCm6aPdJzQI+dY0FJ5mt1mIRRQzgRSbzNPu8gOs7wRs?=
 =?us-ascii?Q?X7XIDeBVxMELuv6wqlgI6tuJmdBrLDk5YCLMiNlbBNZdu+DiStK2gCZ+9R1r?=
 =?us-ascii?Q?E5QhR8GI+PSK8vF+V+01Lh2aipfZRpOOg4y4PtXG/TPb+tuVHPlrJ/FtENvo?=
 =?us-ascii?Q?UZXMWirmYObJexFlpBuWWWukBVKV3d2yjLOGoZ8uP+nvWvv0w2Vt2lHnsece?=
 =?us-ascii?Q?Kuoxppa0+2nGs9WMsHGYqctHyiy8IlKuAct18l8e0eOzwTKd613HHSP6G92F?=
 =?us-ascii?Q?UiXxHh8DO4WhsGuHd10fHiGFdKXURrhFmQ6a+tCmWcEWS2gkexb/bRJlfE3J?=
 =?us-ascii?Q?AnuVrLT8nBzpMAMuqQD0kumDpBDC/yl2yYQ13A9PvvlGkJDQDfsRdiOhtb62?=
 =?us-ascii?Q?yHpZVjA0lWzxKLmmgq0lVhUguVRg+pbGAnpJZ6KgXn0jA25EsKiaoPtgSesx?=
 =?us-ascii?Q?f2PXFFqTZ5/5HE/MYVZsrGNjS65jq5+hK0jWDRTpx0buIMjS6nRlYJJyvRJx?=
 =?us-ascii?Q?LsgwoVtlPHfT+HIeHXnS+NKM6RdQ24UbSlhZj9gkvYPnLG+iPtM/4ISEyXs4?=
 =?us-ascii?Q?csaAcjUMxNxp93i7O1/kzh2TrVyBp7sPlQRYcH+QOI6b19RWHOztd1ZP9sDD?=
 =?us-ascii?Q?KbxafYP/7lIcx+8H85kXmYG9/QQe9YbKw5yLGvlXQt8vq0VKXOiVqfuwiBsg?=
 =?us-ascii?Q?m5V2kcrylBmNtSqrk6RYId+cPXaTnlWuq7LgBAdsH1UjHykwr4Lv+qS32gtK?=
 =?us-ascii?Q?SzD6ml9AmPsxKoJyZd+LkuUVzK7SX0l9bdDSndUwBAcIn1Qh0PBgORFRnAFi?=
 =?us-ascii?Q?R6wBkIG8jnTDipG0tBFE/y9PgsVuIRmKVfcIvgj4WpAkzRXGhMsnaGlnJdt0?=
 =?us-ascii?Q?GVfhsR1SoFN82r1NmpagXvkArBxTGX5U69SJJgv3Xaq4p0jReA2t3AnLXPZd?=
 =?us-ascii?Q?XAYEc6lvRZybk+nOwrd4oDMGU37f3kqVUrd82XQ2Rm5FclA290gRbxZXcIJe?=
 =?us-ascii?Q?XfHolaZS0rC897F6BBgD/254nG3lj2RlzavmUbO/67BCFIjoH3Z+91detTGj?=
 =?us-ascii?Q?qJ5nhsNmtbuUvQdyvx745P5kgQ579Si3Oerwd7tDRhsRuo0YUNIHW2qvV5/v?=
 =?us-ascii?Q?sJ85iC9Y1U3GQVuPCAb+QS23u4Qg/HemUieBC8i0NK1frY2VQ64BW879sGSp?=
 =?us-ascii?Q?lEIpW/oqRUiTGrKm1cSJFOX5LOpl7Vc5wdxzW8C7ALo31kBJqjJADeWxwqzK?=
 =?us-ascii?Q?XWd0h3kxIODCmZBmlIrHKWRM/O7S3isgWBMlvmWXRSMW3L9na3X5bxfjjd5s?=
 =?us-ascii?Q?JHZlel9Blzr/KcapG7dJStblH8spQUHyYkVKCZgnxz165pfLPDNaNoUisaLw?=
 =?us-ascii?Q?Dt+8014XLGgxefvsSIY56x40xv6Zh4NY6alxSN8iE2OV3VJZfFqVrwcEb4qA?=
 =?us-ascii?Q?Rv3qjDKinU3ubVUcQTNPcS8RQeYh94R77sVc+DhV3z44pTYsxZWO/WKQGWYt?=
 =?us-ascii?Q?gg1fEDLao17/ml7owwGJx8/imp75mKEKa9YlJa7tCjeoBgbJ0ijGdFWb2aQY?=
 =?us-ascii?Q?PVocHZEEt3qH8nqZWK9AEKHn66s5lUFa1vgqUKQpjuR8UwbXjA0FANqAUV4r?=
 =?us-ascii?Q?iteKFYnLow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725ea23d-4e3f-4699-02df-08df2867cc24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:38.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRMwD4F1N3Fg+/t5uNAIYJxmVbwtnHHeegOK9ogtbS34UgvTazNZsWf101OrwB2spL6Q1nDPQuGxMoEpOZLzjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442

The character device requests line IRQs with a copy of the consumer
label as the name and frees that copy with the name free_irq() returns.
Since commit ec8b6f55b981 ("gpio: free irqs that are still requested
when the chip is being removed"), gpiochip_remove() may free the IRQ
first and drops the name it gets back. The character device then does
not get it from its own free_irq() call, which since the previous patch
it does not even make, so the copy leaks:

  unreferenced object 0xff1100000435b080 (size 8):
    comm "gpio-hold", pid 108, jiffies 4294695819
    hex dump (first 8 bytes):
      72 65 70 72 6f 00 00 00                          repro...
    backtrace (crc dc8eac94):
      __kmalloc_node_track_caller_noprof+0x50f/0x6a0
      kstrdup+0x35/0x90
      kstrdup_and_replace+0x19/0xe0
      edge_detector_setup+0x5d8/0x940
      linereq_create+0x9ec/0xce0
      gpio_ioctl+0x49c/0xc80
      __x64_sys_ioctl+0x134/0x1c0
      do_syscall_64+0x109/0x5d0
      entry_SYSCALL_64_after_hwframe+0x77/0x7f

Keep the name with the line, or with the v1 line event, and free it
there whoever freed the IRQ.

Reproduced with gpio-sim and a line requested with edge detection and
a consumer label, the chip being removed while the request is open:
kmemleak reports between 17 and 23 such objects after 30 cycles; with
this change, none after 100.

Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 11d5b112886c..ae19b4c3e9d8 100644
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
@@ -601,12 +603,15 @@ static inline void free_irq_label(const char *label)
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
 	if (irq_has_action(irq))
-		free_irq_label(free_irq(irq, dev_id));
+		free_irq(irq, dev_id);
+	free_irq_label(*label);
+	*label = NULL;
 }
 
 #ifdef CONFIG_HTE
@@ -932,6 +937,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 				return ret;
 			}
 			line->irq = irq;
+			line->irq_label = label;
 		} else {
 			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
@@ -975,7 +981,7 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
 static void edge_detector_stop(struct line *line)
 {
 	if (line->irq) {
-		free_line_irq(line->irq, line);
+		free_line_irq(line->irq, line, &line->irq_label);
 		line->irq = 0;
 	}
 
@@ -1078,6 +1084,7 @@ static int edge_detector_setup(struct line *line,
 	}
 
 	line->irq = irq;
+	line->irq_label = label;
 	return 0;
 }
 
@@ -1772,6 +1779,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor held by this event
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
+ * @irq_label: the name @irq was requested with
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1785,6 +1793,7 @@ struct lineevent_state {
 	struct gpio_desc *desc;
 	u32 eflags;
 	int irq;
+	char *irq_label;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1821,7 +1830,7 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 						  device_unregistered_nb);
 
 	if (le->irq) {
-		free_line_irq(le->irq, le);
+		free_line_irq(le->irq, le, &le->irq_label);
 		le->irq = 0;
 	}
 
@@ -1908,7 +1917,7 @@ static void lineevent_free(struct lineevent_state *le)
 		blocking_notifier_chain_unregister(&le->gdev->device_notifier,
 						   &le->device_unregistered_nb);
 	if (le->irq)
-		free_line_irq(le->irq, le);
+		free_line_irq(le->irq, le, &le->irq_label);
 	if (le->desc)
 		gpiod_free(le->desc);
 	kfree(le->label);
@@ -2147,6 +2156,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	}
 
 	le->irq = irq;
+	le->irq_label = label;
 
 	FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
 		   anon_inode_getfile("gpio-event", &lineevent_fileops, le,
-- 
2.43.0

