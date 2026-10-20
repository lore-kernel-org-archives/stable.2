Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501259;
	b=Fl+/fs9c1DcD0zHsJekGdy/VH7E4+h9sLrg2OaiBSB7etprxu37V4XXCifjNHOSzM88T
	 vWcCIuJeSh2+xKhcUBdpUCMTE1o/UTyJYobINedrj+83OSCbkI7wa7wGjelKIE7xrPJ2l
	 FwwFIR3cr3Ges/7k6UYioYYTeYIApyBhd7dXlqxilxWzzwH8WV9Tuo927HJVMfUYlmbtk
	 G/ydBG4+QuDEGDUXeyMGs9iIX40ZBHPxtbe8YyreOFRSBqifRwj4PKo2J8wJnCkLhMCHZ
	 /7Tk1UQURgrWKWCzfejgsqw1BueYYxbZ3yHULDDTsqtpXN0NUlpL3aR7VK/VSe+f30w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501259;
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
	bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
	b=eKaYXMa2HYjMoKtgloT41Ycg1SrvxB0qCj+chV8/g1YiwL4MCJwhCYzaAF1jZ6ihqeVp
	 UO6ykwQ/TuTR6izOER5Mm08MPNeny+7lcZos1jAV+aA1Dyxiya4G1HuYs+FE5809xT+wV
	 idQWkVZUjlfc64CFfjkT8cplWDW6RSEPM2CEKYfG7rY+4EeW3r95jcK2oEGIZyzFm44AW
	 Eaida6Qeu1shLhi92YDw+URev8V+OqCaXH7AMzETtjm/1KUTDqrVrnx7XaU36Y5jf1zUs
	 HcKz2omLdB44NEND9JByeZo9ZoBeC8KV8It0A/TlAN3cz2NSSWTnzNlh5ilU/eLcT9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Od8LTjk5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.59
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9560A263A;
	Tue, 20 Oct 2026 13:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B9560A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Od8LTjk5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBvc4TZLHV4zg9riVHJFcr/sEMKJHzXZ0/53e6FSoH4n4rjF2f1M/8wfm5Bt+S4+DAZrMcRC254lHXOrSNG3/UBqKjI3JHHKo2Y2udmsd0dEkQQHQ7MeZ8ANoU571Fp20YLD9ok+mt5IQiGq8hy7vJunNI3Y/RBSvt6JDXOjGNY59F5PJVu1HgHoCNMM/Z+bwr1FF7e3z5dL1/XQiAR0WmT/NInOQ0Bk7061aJ5PKJqc9ZiaUVF3AJVZyujSyzvg5qi7vHfJ3GaTVXPsfZOKnO6+MH84bErjTsMGvJQ4USAmFv5HO6fNx9wED3RAdu3TYJ8iFglq9BbPB9SuuLdCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
 b=PP9ylw5uAzBYJGl58+G4Srn4XkCJXlFFzhx2JI6+f62thEMOHPjZXwycxpk9/eSlraihQdVYw5JmcZ0wIB6eM9bwrj8utKO8q6M6oSgQhtYFMQgJajd0mC/0LWAUkMQSri/jILT4Oal6g/K/jaRKHk7sZe5sSiRV7uh4VAwkbD8Kx2wlpSyTJcoKIES6Qti+qeKOKaFveUg+QWGF1nHw/019cLHwGtziT6rhifVOhl7iWoEsZI0jUCBzzcb0rXm1z39QTEAkA2zu1ioiVFe0I2MPnk4N2t0dRy8By1Ex2JNubPnb0uDHvK/xtX4BvvlWw69JKR0DvA1B0J+D3DKzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yjq1QFjdCL6IA96hfcN0dYTnAUX8yaYxWDgAaqLVVP4=;
 b=Od8LTjk5laSQqKkNS7b2oSXUuAd+l5iA2/l61IlQYYfd88wXiHxQQ/6Hwy+PCCWDNxWoFf6jXn4huzkap1sMa8HDR/MUyBl76+x1Jgsr1xu/58u8K5zqpR3rNR5WKGQtJMU+cNI9WNyTqHNsn/V0fmbLEmUUoJU6aK3kKRY2zRDx8Ox9O2RjUI5YngrW2Am27CRnMjyowDL35BhoajK8qTvqZFKBx/qd1c7FKnHFcqYGvGPE4vcWKvOZ16cpblUz5nISMHTmPoTxxHiUx232tsMapMIOYDE0U657ngQnSQnsUvfbIBPAlD7wkaTpNWBtInccuNCAgzf344u2TLBJ3w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:00:54 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:00:54 +0000
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
Subject: [PATCH v3 3/6] gpiolib: cdev: do not free line IRQs again after the chip is removed
Date: Tue, 20 Oct 2026 16:00:25 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-3-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::9) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: f37908b4-a350-4d32-c5c3-08df2eaa2d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	tWS66N05zpsH3RVrrLlRkQdKzDhJXeuBDPDCsfLWzABqszsPi82SXjF1AAu11JCd/IeyuRr0v0dFa6M9CImmEzjKo7G5fDnz4Q29qzCFW1p6tCVwCkMhCGm0oGbRvBZRqWqWYPfyloRPqLFzarc7KBtVuD+tsC7kBWh7zoiqRpEbI9KNFwJl2/UemK9x2u1t1V10VhgG9YXZ4iR51hdNH64/4g9UFJ94EVJRPAeePds8XuF1ItPzh0x960kum9rTqPxvYnItjok9N1Th0SxAXfFQ/2+HICm0Rp2mhn3E9Uzr/lxIdUQSVQtaEULmsvtMZpJgyNbR2vbPwA1wNywQWCJLWtJKSMaUUM4iukdoOuGwJWgGyoEipnr5QphF4ugQGDX4SfHpDpM0Kpfh/3ny7WSeSxuw5vriPLnXWu0CbBeJiftZDMVwv1BWqaTaSRN7qRTW9RavS5+x4Wdyh7XfWfouHhuFD6Zgcma9R6CkejG3rsAGdVt6Ngy4wx8RdrJXig6FACQFb00H/VuQXgrTkFzErnKbaT0r/aiQTK94a4R6emH/2Berhcq6hLJdzInLLvYt6E6WuEscdOPvvtwVZL0zEOJjNQhysET26G9Pgpbp1+n0o+ASGI03nrBH7DrI9Xt++rVV840bTTQUerM+QHsBJLtMU6F3mwnZksKqgy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T/0gmf5GaAJifEeBt+wSYpZhlHYjkUCQi7GtPfrWbutdNwP9+edhS/X8814k?=
 =?us-ascii?Q?Zcpo1LbcoCB8GLDOdR3DmrmgMaWUkuDGUrhPcBJy7coG61FpLkaHOUHj027u?=
 =?us-ascii?Q?W8Kq2BRVaREc0WAycWugvX+0Z9Gf7QRjztQc6Dyj6+00nghPXPFvOuyKGKgA?=
 =?us-ascii?Q?yY9XP3OAyWiWW2cTPa7cbaxkHIUIZ5oSgkYvw7euoDFFvknHgXg3Me1AJ9rR?=
 =?us-ascii?Q?uK+hcWIy5S8LYYIFVrCIFK80EZNt514a3BjwiNbLBFQ+hw46rqqbrdLHcfx4?=
 =?us-ascii?Q?nZI0NOlEtAOJZDfdhtNfEVBVwfF2URWSbifdp0zRWbjjZBLrpXXMOwcUmdev?=
 =?us-ascii?Q?9Aay+y6wurMMqP1uC07FPc1SF3bHmMlDBSE7wiKVDgIf74JoPajseD8y8Fqz?=
 =?us-ascii?Q?1keH4HW2+wpAStkbl37p/3UCBxgNuk8IKDgYysX5tGJaYVs9a9CKQmGDv8vO?=
 =?us-ascii?Q?TXZB8GPCWxiJSiFSot9RhPhUXb37SwTF/xrcVH213/KxOyljAxKdoAnOe2Ol?=
 =?us-ascii?Q?FfkR6m++H/r4LbdSOzvCz+uoVFZzliUonK2Cz99d3d5EbjDvc5a2GxYTfrxj?=
 =?us-ascii?Q?1KSl37uXYJHqqq8l1zQzSVWCHfiD6sPPvF5VFl0axvDdeRtD2lJfhmYkyMvj?=
 =?us-ascii?Q?LJg8mkSjA2FOm4QUVuKly+Pg21qrixKuBQOh+BZiuHuNQOh0FfcL6aSb9V9O?=
 =?us-ascii?Q?2qbrYKqVQop1bnKZyyu95NUex5KaDZiJLRwrugqnJa90d3+EJvuD+xa8vYnJ?=
 =?us-ascii?Q?ewUsdXC2AeE58npgt98vqOGJBWy3OzVg0JhWsNnhVKWK4zH0RE38zOco5AT2?=
 =?us-ascii?Q?jGzhM2jq2whp20Ng/9r6xT0joLiHoRgu1YeLPhNxYNjynhaZqZ2vA0frbp/O?=
 =?us-ascii?Q?km7gOQsrZU96S2LxAjC7Da2rhTqOxQYBeh+PplHNZV6hxo8c1vkZjEgkk9EZ?=
 =?us-ascii?Q?FZOIsXClEhnEXYqshZDmW54raw9xxdqqfByACkHmUvOB5D0jDFhU0sOZ76Cv?=
 =?us-ascii?Q?HEwxaH2/131eF2Awji6b3mDZ5o1gA/5NmqjJuLzgYMJXQKFwRRe+zNEKfhaC?=
 =?us-ascii?Q?uJL9DYkp3parhzhLfWBNgoft2sQFKPtyiPhXnrH9KfjLq0+4Yrj2i5eoXPxH?=
 =?us-ascii?Q?tYemIQssHBx5zO3+SrOb/P4/BxBo/wBdTi8NvnwzsCxapm1cUTJppQau9TwH?=
 =?us-ascii?Q?AQEeNFozBtlbm+zzVV2zvarho+bj6RFa5PdQNW1t6tnlZN1mqDjiOjEg6ill?=
 =?us-ascii?Q?I1uhg7foA8FCewTehI1EKkedsGacE+0BXvRbdPQ5wiZWLOd+D160Dm/zKYga?=
 =?us-ascii?Q?PjGOWetYyPx91Taxl5O2Us2E1yubyr1sVSZznwPxTjenWmAvhXgjA+68y7uj?=
 =?us-ascii?Q?Xa5BRsTRjBnoTS2uI5bMTf+TOQjcac1jIy1Vec7gPUj2px4YzRXX9mwNZjIE?=
 =?us-ascii?Q?/hu2pt6nuwl/Kjp9GVu1vgwLvR4hkFTVdgecoAL8PpFXHGrPgLqP9cPturCm?=
 =?us-ascii?Q?fvzWrO+cj+fiFykqhOp6//s0nBmHMKhVivMDWO/cZDQ8UlazsGCg86I+ZKPs?=
 =?us-ascii?Q?B8vIy7+1eK42+yovmfmcZSTi0W5a9PtUaE6F/3be5LgZDQzz7H2ziE6QH6mO?=
 =?us-ascii?Q?+qS/MUfjIdu5NeclL9BJ39cFuqgShiXSyrUlyu6FZXUC5uAu/bs5Z18Fl8QL?=
 =?us-ascii?Q?W+zGV9p0QrCJUe7sNVHlkpZXd+fJ2/erJ31HEmUdVB4yFAL3HKF+IfCl/lua?=
 =?us-ascii?Q?AaORTK5mIQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f37908b4-a350-4d32-c5c3-08df2eaa2d3c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:00:54.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKMaVLFPPP0GBIDPsuvcmzbgKD2ZhfA7RW62/UHVZJHeAaBDXAfhqc56z30UjB5k4LrS2a0qTbdivmQsOBL9og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

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
index f4d78113ade2..6350b2fca8a7 100644
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
@@ -1787,6 +1808,9 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
+	free_line_irq(le->irq, le);
+	le->irq = 0;
+
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
 	return NOTIFY_OK;
@@ -1866,8 +1890,7 @@ static void lineevent_free(struct lineevent_state *le)
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

