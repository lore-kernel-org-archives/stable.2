Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=40.93.195.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792501273;
	b=M0o6rji7ef/CNMnDeVsa4a+M952UUjWT8C+aZIHY8BdeD9Hb0cgmuNCU0SAepHa1lJqc
	 f8GPcGAt3v9617encbDTA5Z8vzAMlMB2KbKqrnEeh054/cnjHD6CFwmJt93nvxn0IE3Cg
	 jqTUNYrjr95WuSXiDzvEQXNjZyTgxao0oxO9+SlPadIjsPSMNFpar7CZJwexk9nvInkPA
	 GNHbM42gSO6Vn2eUytYQlAwYSpI21iZqq6DKtprhWv8pm7YArf82/H6fqqo4IiqYGrm2S
	 NeEkJJlrmgl3PJIlxVsGXWoMgK6o/oUsJzaEcyxvi71H72mmIVKo1aoco0nACyGm4aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501273;
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
	bh=mcFKFHvYe4l8kZaaqCFkl3bGW2P59nIcVBPF5uT+mH0=;
	b=k9vrmWWDRXSPKoxUqLmki4oyz3PWCwdyh0txQyP8kq2bevabUlS9jbnJArtNS16y14jq
	 +Vp6iemTc1qBgHLa2gUHtURohl7m7hoxTrRChzYzIMxoA5KHGQoyejhik7ZZs3f3tOxUS
	 lFpGqYbULG8NazvUJOlw0JWxLL+huVY67wC1gJdXjn13a+Vo36k0gwa8mLSEngryUFFeZ
	 t/TPYeIEG+JrJFyTv5XaAgBFdBvd9f+BautEahQH5qT3k0cA7DHcjekCUjgiK09yWJ6jT
	 dR/MPqoAi0iOmYFbcm37Hga1vDdB2pWzBlWh9MRARykNE3Dh9rKy/j2OrgUkZan/Fxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZHTu4SW6;
	arc=fail smtp.remote-ip=40.93.195.28
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFD60A260B;
	Tue, 20 Oct 2026 13:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3DFD60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZHTu4SW6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yNXUACAUIcKIFMWtltLFuKk81W2/A2scQZkWyZYbDb3I2LPBPX+LGKDkvgDj3elTJQjh3iXYFChCiImCCnQzCQ9c4ZO1cS2ulPxxOgvPTwkQw4srRIhB4zJY9O2EY2HzAsjZu04DoyTXYvZTJJkeS76rCmLYxKK66IUnwdUdaEVL9zYuU2E5lKjIAgY3+NHebfwl0rG6ZtD8gHvM6RxM+gOcjLy3NFSeYdKxI3FkUt4bd5L2r5qLEnjxTnIDA4XA6gXFW+2vAhFgvYgLH397nfRTUto0zEmlK/kmyI98HhtPHklDbi28Pf8M9RNsAOJTbFIQw0fE6zecIZ336hHMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcFKFHvYe4l8kZaaqCFkl3bGW2P59nIcVBPF5uT+mH0=;
 b=KOfBZqKFewsgHKFB8clMRCJpkUC+Uo0TBvGjk0z4IxM6e6bsgQPzTLvpHXO9WTVmLIPnvYDrnOhz+3C6NJjiO7/djmpl4sbS7Wo3UoqxFGZtKkF6/VBD3tfg8LC5f+garNkBPtxhDHKvQNhioRYtzXIz6MzwUxnQJGQQusXV7BB29+diKnzl3/2rgfBs3dIwsbJB0cBlRkJ9/e2UI8JcrMT2pJ69V1mDUI09DKEDu/Y0oi4o5exTDr5RrjaToATGuitURePdf/Urjc/2q3n2T8jvBdPDdXbX6oZcAVb0cMhLNbcKPwa4WJxZqiaBjLFQ02ma7MimcYzjOCpyJ507CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcFKFHvYe4l8kZaaqCFkl3bGW2P59nIcVBPF5uT+mH0=;
 b=ZHTu4SW6uJI+Xpfkcm23jPwqO4Rcp7Swe66MNljaLeAbpYIxabk7a7EQdAJmnt8+r1j83tEGjfadMm8NCUhOo0TPV9dmvtIj4UZ7MdhMX2n7HvZxWo2So0aEgtha3bwByyVI+2VtTeAQNqB2i00G4ALyn+6R9IWhfPmquk6P3X34hGRbr/u1SRy6fLT/tkhYzszyQAIkSSiplMmxqp0d2IkzVcUJkPqolGrnJFJJPTk+OfuLeC5aYddaYywncmGKT0O6XSWvBNUdWxK1C6YdKxzeyZjYzxw6noBQAJLmvy2fd8ftj538jk0fbbFvYHzPQdFPJf5fbCTLVSeyXsJfNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:01:08 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:01:08 +0000
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
Subject: [PATCH v3 6/6] gpiolib: let the character device free its IRQs first on chip removal
Date: Tue, 20 Oct 2026 16:00:28 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e96476ec-e965-4f49-d095-08df2eaa355f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YKr4Q+v4p2d/dDw2WTj+iZSij0nkx0C6QJlwrHcJmAA4Cu0JN49CgIQArtFX00HqKkRCYcgl52hhmTEBDcToNCAnQL1SnRmZWQMn7wpZ40zOZKgwdY0/GjITUclfyi7IXm3yBILLN0EG8JgaDbMNbjCizv15XclcKTWkhtHFYMu+fb8SSvcsyNZW9Mc8q48FqecVgcFAyAuagOkEIr9Dzt3aLUTi1WMvL8KVGJnUYagdJddTlPrYrY80ewfKnmYhYdaJjxIihSJN9b6+eU/Rc2I2yx1uw/nw/IACOlEe/Y5sLmJcVhlTBIJqLlkdLmH43g0fOv7ZC5EchIHhzmKnUXJXNqz8/A+RiPr6Hel8DtJqvAtK8ypipuANSFneshs8gYJAthX4YpkBCdxU5DlEwWH+QprMEtZ+zGXiz1CEy5VupwzgzUFbGxoUd6ypZeRKvgbimZpBjNRbpw+mZ0YfB4qaovBU+Vfvdc99e8xoKD77TVK5Udeo62d14CUb2IKVCLdOLtbkCLXPFosE6dqAx6QFRKSf9fj26gbTtyra+6Ohcm5HETYl91gI0vmOUcmmq+DTTQ/oLAyty1M4aMb6+oqbekD+rgHOhz90VCqOj7vWVJY8ccR0tnfPkVhBHPUqrSnnLBtdM4L8IdZ0expcaF1FYGev0NGNih9k2sQarkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffCkC5NAGdxZ+YK1YGkl6bNLGw/DFckveo7raJieS3rBK9hkGQEYwU2mDbHW?=
 =?us-ascii?Q?syC3+Hg9TN9kLu1UOE1IfGyxX99bplQ5TdrHB0jyRE1gzejgW6Hn+mBaGlnX?=
 =?us-ascii?Q?9hkdjJdgwhNU7gti14CnuX06EVMCSMLAYxOK9uhYoiuEY3yYPvQMCaJJYQDz?=
 =?us-ascii?Q?FLLIJFvC+vDxz+wHm++suoMNWPFNiTAa38iAzzxjLPVMItar1/+yMhX9ZaJf?=
 =?us-ascii?Q?uc9J6EZHi8diWklYA+sAETLSCL/i4mgJq//0VTdcsQsTrT2F52A5LdinF9dY?=
 =?us-ascii?Q?aYnI2qwrWLUm63HUIYUBkfBm/NTbDRVlJAKHtrvbpKbHN3GowdRRTSEGRZVs?=
 =?us-ascii?Q?0S1CXG5ASzJ6mg5VmXNCxMqHAyXZzym+3gGfoh3CSaz+byujklkvhr1eEjhH?=
 =?us-ascii?Q?phNtWyHeipSnxCWVk3e4OAEy1EN3SgKQBpi0jdGcIndkIPtdxhOjzAV7aTSM?=
 =?us-ascii?Q?Yi6S6qYeHhdOd1TBi7r3ftMw5EqAyV03fs1Ha54OySNZLmBr1lTfWVICbHkL?=
 =?us-ascii?Q?L3JI3f4NaWTLlwKNSZp2wyBt85a7gzKCG5PfxlzpTb+QAQhIyZG+qEJCwXUM?=
 =?us-ascii?Q?C9D4XgnXUDTKJDIYSTB2ShOrYj4DUUAybRap6bJ08TbQaJrl//x3GRw73way?=
 =?us-ascii?Q?ibtH0PAXBYnZckOF64NP1qjpTfbHwt041RPH9cpg8Mfxj2u6XEmjKANM/cIC?=
 =?us-ascii?Q?IviGIQFeGU4znWcEOmsFKuF22UoJXEwJs1j4hW+0U29gGRpzxn4Ho7pKZlXV?=
 =?us-ascii?Q?NfBjiOgn2T8MHFc8t3yJfT4GVFFrp/rHUxFACZ5P6QiK+x9+qiTJ8JKEFXNA?=
 =?us-ascii?Q?n8RhicsfWPpVKVPPCfo1FpsiI3bOkb6E64M4Ba/7OAMNTKrPiqoSazoHyjGm?=
 =?us-ascii?Q?P4Zy685KJ7yQFywgbORmiFXO5CX6/iVTc4+fO5q4DSiMwnatw/HoC9WKs/W5?=
 =?us-ascii?Q?tZAC7hNE3rhpj+6s7DMkaLCiLaK6S/gKyD2AiRJFhMI21ZeXw7LzunqGvkoz?=
 =?us-ascii?Q?4O1VnloTQ5uUUyWPE3S8j1GeALltXiqmzjRhrP834nc23aOobfaUGb1/fL4n?=
 =?us-ascii?Q?OkKqn5VRw+9MibMBo20et6+4KRpHnd5G+nqKR6uLWpHVk3/JKlFQ68r/DZAB?=
 =?us-ascii?Q?eBC2jdo7uPnlVnrRtRvcQLTv7v9fmdR7ANt8pKFaNfrCq9TIeQlwkjTuL7So?=
 =?us-ascii?Q?3QaTymJWbre87hhlKMwOsw42rRlSPQW/sSAFI8ML3/Qu4aPJgs4q0oirCcFx?=
 =?us-ascii?Q?dfR02ZgHdwAHFtfde+lXt7IvtlvHPwOD5PlJeVByMh6Zm1FtXcxh+0BfZrww?=
 =?us-ascii?Q?90x6e3HW63ZGBy7KTd782NANfR5rjXgobdjCAPtUH8Qt6/wDfyhww28d1Y2Y?=
 =?us-ascii?Q?4klIDoHektRmlRiGYiGxq0rhmlHKvjwmQQd0T0yNppMo4MolKkaBO0koh/ea?=
 =?us-ascii?Q?v+tibU0nKCPKhz/zfq0EEWLx0m0+IDb5awjIR/SSLl6bf8VsJ/fcLdnEEf6O?=
 =?us-ascii?Q?d+EvBawfeBQFvAGMtwC54SXEr8/7Ssc9B/TPzDwehDl8lh0zgdhrjXgV2JvE?=
 =?us-ascii?Q?zNnzF0KzQiO3CGD/E9mkwq3A1FbRX990rAhYearhL2x8EO/ottO0AN+pz8qB?=
 =?us-ascii?Q?Wzdo6iiA/dTDSGT4e1QQJ6uQiJPMCxQ/cSBmVTA589CDdKRKxgiYX0jyDAUa?=
 =?us-ascii?Q?eK/0KUS0jTYiurCz5JJqBc+hh7yctEn/g3KTpqsSKHgdNBYLSkAYqGzyjEBR?=
 =?us-ascii?Q?rWM8h2KY3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96476ec-e965-4f49-d095-08df2eaa355f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:01:08.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOO/DO9QZx9VbCE/60snTGnrFbAMVflwTNZa75IR1jyi4IS+363HC944PazC5P1bXcgQ4Ico+R22B6/KjjftWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

gpiochip_remove() force-frees the remaining IRQs, removes the irqchip,
and only then calls the device notifier on which the character device
frees its own IRQs. The character device can then free an IRQ it no
longer owns: after its mapping was disposed of and the number reused, or
from a release that races gpiod_free_irqs() and
gpiochip_irqchip_remove(). free_irq() then warns "Trying to free
already-free IRQ" or uses a disposed descriptor.

Call the notifier once the chip pointer is cleared and the SRCU grace
period has elapsed, when no ioctl can request IRQs any more, and free
the remaining IRQs after it. Have the release paths free their IRQs
before unregistering from the notifier, under the lock its callback
takes (config_mutex, or a new mutex for v1 line events). Herve Codina
first proposed calling the notifier earlier.

IRQs that in-kernel users leave requested are now freed after the chip
pointer is cleared, when gpiod_*() calls on the chip fail.

Reproduced with a test-only chip on the hierarchical irqchip: both races
warn in all 30 cycles; with this change, none does.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 35 +++++++++++++++++++++++++++--------
 drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index cf23b5296fd1..cd59af0c56dd 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1583,19 +1583,29 @@ static void linereq_free(struct linereq *lr)
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
 
@@ -1666,6 +1676,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1683,7 +1694,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1783,6 +1793,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1797,6 +1808,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1832,8 +1845,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1913,14 +1928,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
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
 
@@ -2092,6 +2111,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2827,5 +2847,4 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	destroy_workqueue(gdev->line_state_wq);
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e923512febf1..5eb53f8c5d34 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -851,11 +851,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
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
+	irq = gc->to_irq(gc, gpiod_hwgpio(desc));
+	if (irq <= 0)
+		return;
+
+	irqd = irq_to_desc(irq);
+	if (!irqd)
+		return;
 
 	for (;;) {
 		/*
@@ -887,7 +898,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1422,7 +1433,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1431,6 +1441,14 @@ void gpiochip_remove(struct gpio_chip *gc)
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

