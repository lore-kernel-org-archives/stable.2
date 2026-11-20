Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162475;
	b=qYcI+34Z67CqeMyWXnEcDm5fqqpMxmJlylwYgVrzIJrP98ArHeQwm0Ebp1CEnXSkvx0/
	 mhxC55vWROLJjtxBF8+VqLePFaf3mRbESsG9oDSt1dVwoGYx8cawRIkog+tyqdilfxRqJ
	 8nHSN2Fs+BfRrBAxynf5RakTnibyHkNumbMFsKJI7TugU8aDyKNSPm8ns1+aS3L6NSK8k
	 Pm75cEsSUDB9eUAkCAz9tGbWLtlxW5OskUq8/QmtC/2SvhedHoU4s/AgfYPAsol7jdowu
	 UhXST1Pk9Jn1ZNxT22p5/VKHKEp7wth1rGYN97CFE4NhvdHZ6E3RbQJhj9VotXfm3Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162475;
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
	bh=i+jEFAXLiEM2rGDfDPBfjUuW4MRKVyBk3c8TczROL/0=;
	b=DO8WI+am6UsUl8h6cGX9nQaAZx4l7j5Wy8ZmvY7T9eRL/5dxtAzg9vKek9aP56YvjT+b
	 qN8bWi+FPibl89V/GjKC7CaCtSoq6OgolDyalYb6LP6TY3zdp93o3ytOEaIU4jzs92+zR
	 qiXNDswsuUhcAtGi3YAEixikfUk101HIsv+yASBTsdLPwz1WnIOXWrp1MEll4wKFEUusx
	 eJp3HIGJx5kBfetd8pvxBm9fyz3OGJ5pyvB46HIVxT5zyAwnO5PemOT2xpccts3g2u3O2
	 mB0Pk2MhquMR1xeXiTOMF1llKzk39/uuwTUb9Rk6/J9mX0/MN++jiaPRIMYU2ZLWkSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZvJjGqgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.26
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE8606A33E;
	Fri, 20 Nov 2026 08:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DE8606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZvJjGqgl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKqXaAQ9wu7DPYqRFnfZ0PBiDqvzmGl29DHHJp1ShLVhmQIInroT1BX3J0w0S8sx/yQMxZ/feqEqm8fjBkO+GK8nBQISMGQpsnp76Ai9EC9XwxUZd+84OCqYoc9dvoOPBd3NKQnG5xZd/ii6E6lPpdzAiylYvPto+mAKrzac+iMYxT1cH6FjO5scJL9UtPZqQh+KjIid1Bl0tGKsC4oJxifVefXSTFpBgbHbYkFSqhdfD/VWWyLIZaIfutIwdKtRWf/d5wJoGhS1WzjnMNxpsFCR+XOVMO9izxBOZTpUpwNNrdFJEJXZKoSeY5bkal49EQKjIeYBnuQYe/cVuSHYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+jEFAXLiEM2rGDfDPBfjUuW4MRKVyBk3c8TczROL/0=;
 b=e1/P09ueKkLR4Mecebxa14AHfgDyCiC3/+WLf+kaRw4dhheqZ+lKr3cLFQMLMfADMHly8u5/IwS7J/uhp1A1hSPHNGkYV0tHw7Jfrc2vpHDSAO2rmq88zP5UztlnJSoH4Bysrs9+dN7Zy6r2GQ95M6SZAZWrqj3ilEmJbrMPsQCq3wTJN4Vb3G1HmLQ685yFg7kgG8KqIRMJD5uefh0gz0YRpFMkDo0OKsroUQuqu0zZYlgO5F4K5Ct5xNiygCXfkv4eHXhYMf+emtfOFmgp1CNoJpYJ3JsnfHz/oKFMvr6yH1SuO4gHfbDqM7ISecWi8DT3y5AOqgEnuY1O68pQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+jEFAXLiEM2rGDfDPBfjUuW4MRKVyBk3c8TczROL/0=;
 b=ZvJjGqglR2z1tKbw09fSRab/0OynxAbD5q5XDUlYMNE9M44agadbtrZ5KsmzWTioydzJCUjM7DoYIv7ExoDElweGQIaxLWxdz+ByoGMFtfUh8bsjJ4RtGbbX6Y8fCbenJjqGLK5MVCCTKvJWMxovaJVsBwtcpBFc4XGAJWBUgDskTz1IZtOa/F+k0JFGK+7bLgWZfJJtOExLPvLL8haqnW+tcOcrczT/CUpifdJLF+f0r3khZdLDmynUNpHhfHZkrEyGwsH3hbLS0YmgyfcJFt0hH3hxyRL+hXLqdBCbCvTTDnoOkXELCbkXgjVciFqaUl3WjYQgQUi0Ybf4sR7wtQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:32 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:31 +0000
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
Subject: [PATCH v7 7/8] gpiolib: let the character device free its IRQs first on chip removal
Date: Fri, 20 Nov 2026 10:13:59 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-7-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f9b82f11-e559-4fc3-7e13-08df46de4e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|261102130727099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	UvfQ/V+zv+jlS7teEmwy0Og9+8SmkOd0AIpGZfTYBvwLsNDdL0vlDbrUbvb6D8I873D3TgEH6eoaDG7bVNucFros9A1tK33WHeJf2/SpmnhD88Q3pKG8K7fOwpV0uL+O+RXWVi0IyTFV2hw/pyBukmtWdlMHUYgCp/ceWhlEr9B6DAGN3sZfEjrbZlj4oV+2IHzWodDPqJe6tcJWsSO6ng97lya9t9uZQnFbrW/hkjGFOCeIwEw57vNTtDePRQYmcYHKWE+FPpwgcJw4+eAfRInCdrlYpTjqagWlo0gV69XqQzOUuWOWq9a+3FmUbclSEhO2McS85ro+KWaVZO9e8Sh22fdYyk2Qz8bSQbqCjTr3GnC2oggX3to1IxtyEK0Pqb07K6wfbbpfAKS9qNoVC+Q8JekhxL5fZnqcHEQ5ADRParVhRdAWH/izwneHxwdK1ht2E/10bFOY8JG2Qt9LXTPAGTzXINt1d/c08CL1SbvCphqitjaedm7z7zejj+jJ0g/Svjlcpy9SdkjwZ6fputidsVrHbQkfRYBJj4OrVtCOShXvvht2xR8nLKUeIATbe0s5id4S7r4kQeFUJ3FExBIFamqPE4dAV64iaqGo0uveKALqnwIc5iHlqHldJlBTXLCwRczSNrDUR9QUaItVF/AJtTyWtinXO6+AIZAf4lY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(261102130727099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2cd3yjE9PHI+tBr+mB22enUXSUPkpU7ZuBh6tfePJI4l8R/EGr3zgSF1eBSX?=
 =?us-ascii?Q?eT8lJHsNiYfUoFrzpONULJKESCma3kT0zEbNZPGgkPA2OahY+iQWC/GMFN69?=
 =?us-ascii?Q?tS5/epvh7ZDa9pBWjYRuDMh7OapXXdxcK84h9BF61O7PipprnDyQFrUARRs8?=
 =?us-ascii?Q?QMz/S+2KBnn3ZFJZK7rIt1k7A5+CyZQ4BL6jRSKrHQRAKojNDV3BeqKFOpuC?=
 =?us-ascii?Q?DcClbamdkgjlHpw2SO1myyIjrafUAjBSmlL1S7UT/h1K01kEQ6NSRk/7AjsM?=
 =?us-ascii?Q?osHxJHv5bPh7ys78SyfEGmJQEoHDUs3WBoa9zoMOZ8Wz4dkWBFody+EaLuIy?=
 =?us-ascii?Q?wQzVUJVNYcvInuXR3/xXFC6i5QottD7QCF4/i91acsl3jWk9k6H+Cll2ORlE?=
 =?us-ascii?Q?+cfivqjthJGm1QO+o7cIsoruMGlIgAolgKGDa6kLjMLZMW4AhSl2XrkNg1+Q?=
 =?us-ascii?Q?2E5wF8D371jXeO4KXMYr+gg80+b3Xl8Mji4NcabGctbQi4+k+XDGJQifcBec?=
 =?us-ascii?Q?A0FdBpohuJnOWnqkrvNUAUjTJCikxWPWTfb6s85NSSVM4TmXDiukd0HjrcFh?=
 =?us-ascii?Q?nsDk+8ShLbZfUVaV9RqkLlK6/iZg6Dx9ML8RpYzJa+4zb3SUCAatxCfdr8Yq?=
 =?us-ascii?Q?D/bbSSBDP6fI8gnxhmre+C1raXIXX4fplpu8spEXnZqCYocKKedoMmYI0z7X?=
 =?us-ascii?Q?UcJCLlbJZFKXXacC0Nf6qngnztKTQkN+Vb8SjQRYWRaZqjsE3Hq7BThI82OM?=
 =?us-ascii?Q?jLOYEFqDSyrX7W3exlvLC5QCbdeRkc8iuOO03qfaf/WhVDB+EPIE2BF5rfOa?=
 =?us-ascii?Q?As/cRCXDBJaEsRWBQITjdgM6pgQVom4t46kAwo1UqGkyQpOJDTavalfV1BQK?=
 =?us-ascii?Q?OaoYsZLHPEbdSP4Ya3g9e4IhUW451JRXUUOeKLqaaeeshxUlK6obV88ywBTv?=
 =?us-ascii?Q?A1xlS30Smyq5D7zUsOLn3pmk/3OYnxplJRsgpab5pOq/IidAHrtyhId3p0sK?=
 =?us-ascii?Q?+M0EpAdiJ+8sH4/80CCNlFegwUoP7smzSyHsFYZSa3NofekGqhFo1cOReqpq?=
 =?us-ascii?Q?vkgQYsgtHRVlq8sUDRByV8Sy8C/FrbiLDPi2UKQL8CtoTmqcFvZb9nOi/bvT?=
 =?us-ascii?Q?aXdkAbvDUNCYnZ3hYJJzu0QIpLAcHjuoLHnLstJfxv1Mzd06JS5kmV0SIxQl?=
 =?us-ascii?Q?pMKQ5LKBOIt2uPiv7LEwMSpsZ/KyiIapHKt6QzrZK+XpB0kcl6n2yXnNOt5O?=
 =?us-ascii?Q?JlaDMqVHYKzKIIX2khfNgM1kW5F0NsLckxsQbLDSxVHw6EG0++KBNXaTsw0k?=
 =?us-ascii?Q?6RIq8KTeFVjG2GCZWzEplTnQgJ8K6a9pJbhP6e1fNsyQMOueoT9NCvw+TT62?=
 =?us-ascii?Q?WIpVc/vZJxou37DogkIrW5z9JbvEXYAUjlUwFMF0LLaRuEHPUAO11v0yg51B?=
 =?us-ascii?Q?vVME3C2x/WkpcFrwirl7gwfFKD3uwLOe23imx1KJcy+HbXIajnM98ma9kNQA?=
 =?us-ascii?Q?PJeEgtKvI633iA288AdGxnntZ/y0KUCjWSMgjPtnCo+g08Ti09qGPOKyJOue?=
 =?us-ascii?Q?AoCNYISSSJ+mK/bagjIePLLxTnLe7/VJ2b7jnYOVGq2P73JaSJ2gfh2pP9Gf?=
 =?us-ascii?Q?6sigc3vjFfejvnBxDDC+8wBR4vRf4tv9ulkRqcGGcait2NSvT5qqkhXumbyP?=
 =?us-ascii?Q?lOI6RUcWAMYHYP31UjgHD9MEVguSnmHvOuSC2qS0culPDiHI0lebzzHYETX9?=
 =?us-ascii?Q?FnphPnqEiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b82f11-e559-4fc3-7e13-08df46de4e0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:31.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho0drw0WwwKk98cgYMRxa8rcJ7anuNE5rB2AG1M3h+s0xnbIczCb65fg0wLayE8uMENS2BFVqAR0cGPUzh7+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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
first proposed calling the notifier earlier [1].

IRQs that in-kernel users leave requested are now freed after the chip
pointer is cleared, when gpiod_*() calls on the chip fail.

Reproduced with a test-only chip on the hierarchical irqchip: both races
warn in all 30 cycles; with this change, none does.

Link: https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.com/ [1]
Fixes: ec8b6f55b981 ("gpio: free irqs that are still requested when the chip is being removed")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 37 ++++++++++++++++++++++++++-----------
 drivers/gpio/gpiolib.c      | 28 +++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d829f7d00b5e..ceecce572a52 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1590,19 +1590,25 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	/*
+	 * Stop edge detection while still registered for the notification, so
+	 * that gpiochip_remove() does not get past it until the IRQs are freed.
+	 */
+	scoped_guard(mutex, &lr->config_mutex) {
+		for (i = 0; i < lr->num_lines; i++)
+			edge_detector_stop(&lr->lines[i]);
+	}
+
 	if (lr->device_unregistered_nb.notifier_call)
 		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
 						   &lr->device_unregistered_nb);
 
-	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
-			gpiod_free(lr->lines[i].desc);
-		}
-	}
+	for (i = 0; i < lr->num_lines; i++)
+		gpiod_free(lr->lines[i].desc);
 	kfifo_free(&lr->events);
 	kfree(lr->label);
 	gpio_device_put(lr->gdev);
+	mutex_destroy(&lr->config_mutex);
 	kvfree(lr);
 }
 
@@ -1673,6 +1679,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 	if (!lr)
 		return -ENOMEM;
 	lr->num_lines = ulr.num_lines;
+	mutex_init(&lr->config_mutex);
 
 	lr->gdev = gpio_device_get(gdev);
 
@@ -1690,7 +1697,6 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			return -ENOMEM;
 	}
 
-	mutex_init(&lr->config_mutex);
 	init_waitqueue_head(&lr->wait);
 	INIT_KFIFO(lr->events);
 	lr->event_buffer_size = ulr.event_buffer_size;
@@ -1790,6 +1796,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
  * @eflags: the event flags this line was requested with
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @irq_label: the name @irq was requested with
+ * @irq_lock: serializes freeing @irq on release and on chip removal
  * @wait: wait queue that handles blocking reads of events
  * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @events: KFIFO for the GPIO events
@@ -1804,6 +1811,8 @@ struct lineevent_state {
 	u32 eflags;
 	int irq;
 	char *irq_label;
+	/* release vs. chip removal notifier */
+	struct mutex irq_lock;
 	wait_queue_head_t wait;
 	struct notifier_block device_unregistered_nb;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
@@ -1839,8 +1848,10 @@ static int lineevent_unregistered_notify(struct notifier_block *nb,
 	struct lineevent_state *le = container_of(nb, struct lineevent_state,
 						  device_unregistered_nb);
 
-	free_line_irq(le->irq, le, &le->irq_label);
-	le->irq = 0;
+	scoped_guard(mutex, &le->irq_lock) {
+		free_line_irq(le->irq, le, &le->irq_label);
+		le->irq = 0;
+	}
 
 	wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
 
@@ -1920,14 +1931,18 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
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
 
@@ -2101,6 +2116,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	le = kzalloc_obj(*le);
 	if (!le)
 		return -ENOMEM;
+	mutex_init(&le->irq_lock);
 	le->gdev = gpio_device_get(gdev);
 
 	if (eventreq.consumer_label[0] != '\0') {
@@ -2836,5 +2852,4 @@ int gpiolib_cdev_register(struct gpio_chip *gc, dev_t devt)
 void gpiolib_cdev_unregister(struct gpio_device *gdev)
 {
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
-	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9832f755312f..e0ba17a73c4b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -854,11 +854,22 @@ bool gpiochip_line_is_valid(const struct gpio_chip *gc,
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
@@ -890,7 +901,7 @@ static void gpiochip_free_remaining_irqs(struct gpio_chip *gc)
 	struct gpio_desc *desc;
 
 	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_USED_AS_IRQ)
-		gpiod_free_irqs(desc);
+		gpiod_free_irqs(gc, desc);
 }
 
 static void gpiodev_release(struct device *dev)
@@ -1439,7 +1450,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
-	gpiochip_free_remaining_irqs(gc);
 
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1448,6 +1458,14 @@ void gpiochip_remove(struct gpio_chip *gc)
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

