Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162484;
	b=V0X3QHGu6LFwGr+L3q+xJoRxfedhyTZWP/lVBKRqu1REoYEEtbcVXPVw2iNffZwZ6FY2
	 ffRcBO9s7X1iB8tBUQG2UyspR7HZdJ9VnBnzWDbkNhQyNCeggIJlEmJ6wxm2oT/gcODrX
	 Z2BcGw6jXVLBGdJkrmUxE5tE/uCPhIDTr6+5UNNN30ZsBAhNtAjVCxw8MKlpANx+nA90a
	 yEBZudwVJi5m/T75aXZLFgJHS0XONO4QHkNajJ/waSEuV+FQYiQRPNfN7UPm+IaGueS0F
	 m/fJtMCEC6VbczKbme+SEqXecPaf/9yMRvPPbvHkgmuZxmWDE83IQMvducwSCMLmkkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162484;
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
	bh=MyY1RvRUH0KOHufwyVBVhZ+KbK0XyYyMDH6JYhTmiKo=;
	b=Ii8mF/4QTHetpLsP3RAjCd705vgB/axkMHk49BdAxRmEaaQ5BYcp7cnjwKDKlpHinB/c
	 QGDhiKtQFIYiW9NDQ63jvGc+eYl7dbwv1mZIsq9cCaZxC7amkUHialxVTvl8CsK9HNPmW
	 1hU9vnJA00dvbPkypKem+Rmb+/i8sOdJvkffW/1fRTSDLGG/aPMpH6U9FuSvirPYVhPO/
	 LdWpTCj7vhYuLHTHBkyyvADuCY+p9lXuC8RpB18hnqGdFiBvo8ruwf3aq01jBHT/DjBN9
	 Ybe1BUdkahydXd0+WQSVnSUzfTGq+lWsk8whrjA1tSge0vRySakveATw7MoptpibXuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="MgDM0c/p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.56
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5C60A2603;
	Fri, 20 Nov 2026 08:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE5C60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MgDM0c/p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyipAwqKrzjT8l0td6/Yq4gQoZHKnDC56c4VQmdvWbY5IexIZMssIDhoS6vxIjZ3xkLLkcc/Nyw6kXUex2xv56CchWGsxKs7hkW+l04HqM5CWMEvYrIq8vy9Nmh2z29m6XNnIULWs3pqvWiSIsCB6uvojpsX+Cz7QLihkmkgBwStHA6sYh3TLsz820zMHrCivg0WlWip11IWrZQRciMAWgdZ0HdPNZddck4SlZaEipeIPq4WVYNWmPsQeRIlm8737Yk3TIVBeHtiVqa9961NFvFyjdgtmcpvdho4SE5hKxZhRigksK2gyBb+ruYTND4Vcfdt07IDJ1H43Hn99Nb/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyY1RvRUH0KOHufwyVBVhZ+KbK0XyYyMDH6JYhTmiKo=;
 b=hIRV0MtITVi5XRARbH7106G4S5LlprgEye5O9tfTImKBZo87UBF8KLtPFdtJDR5et+4h4keNKq6cCESemsFtZjS1j4WhD4TZskgVb803nK6cmyXWpgqLCU0J4YNX0OkPPAIxAlQuHFrZ8zSpWszJVoei8v+9o4PUx5N7H8d1EqEJQJeIz+lpsQnQbmxla9UI/DmJni0xqzGcHmrOHw48efgCY8I8W9yQZHvQRnJCAXSCHPVobtXfC2ayPzZ8C4KUzD6bfkOpS84v1MHH1bvK79Ao3dueMBgc/3pSKvaPs86kY9jIGDHwuBc+SkF67Usk4nkIpIdMKHPL9v740L0BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyY1RvRUH0KOHufwyVBVhZ+KbK0XyYyMDH6JYhTmiKo=;
 b=MgDM0c/pGjUaJUHk3B3mIBa7qxjYOIACV62nvK96hMgPcBU8FHJv4ImPnJ+UCwpjYWEyFORAGwSPNyEiAlGaAmJuBq2gIhA/dn3uzw/gzzhebbVmU09Tc0HGSiMPenBpHklU0NidLS8ZkU70nO7wwaQe6PEztxGHMejnjynIJa4N8zMS9lSfAEE9Hv9mnXEmdTRwqUnuDRr8U6H5A8WyPzYI4Mm4sbcxaoUx84Y+jmvpGCo+ZQF5sEtXwuUBQyIPAyvoa6ntkJRIaMEwy6OMQjk7ODCm/0XG/lt29vbKwBmnxG8kExZB9+Luz2KNjk5+zGqD/yw7W7RFdWfb5WgGEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:36 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:36 +0000
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
Subject: [PATCH v7 8/8] gpiolib: remove the shared GPIO proxies before freeing the remaining IRQs
Date: Fri, 20 Nov 2026 10:14:00 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-8-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
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
X-MS-Office365-Filtering-Correlation-Id: 12abba11-0bf3-4309-b7bb-08df46de50ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261026121527099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qt56HKh+peFitVUmYalLPzxSmo771ih6rteQ7rX/I6ba27gmq0UTXicHDHQEPpQ4brqMmAAC75xXxcY5mjRi3VzYMp5lbqOc/9IiQh4x9YyQ78CvQc9jGsiP7BoBX8wc5Dl1zvwoK2KKuZiZfD/J43xj/vE/Gydtke3F3NXsBowbzI+WsDHoJOtktlhkQHgwBQ69Queu0a0gSb3PVwGEM3A185H9qKoBQ6sTcqlT+CIFSrkDvNjVMH7TC+zX6sFoJJtgxReE3LWoUouOrMan+f1FvGDhQxjBLs5CSlOzoKsO7lmuCVJchs5IDs5u6fbux25ByX1WnNLYhMZNrzN63QVwT7HZNEJbvfAc+8bxUYUvOCMB5oxsbUn+zi7nIiGOaREF3KWz3ooPe4Jk67btzlTsHfSvsKo+YnPpklDbLIYhjve0OroUwFZEBaW9tDAW03Yse4KcqFrT5NhTaaa6O6usS2bI+6fXmtjIfdmnc7XQSgD4iqVGSCDog1lVXQ2p7gYKs2/+VQAJrAqfiaFHtgJKSDywKYO36WFQapY0r4bqeCHdWkNOXBFfiRi6IKU77ENo8zrYlwZo8n7ayKCkAQCFo8Etfh8xzDDCJ1GltFWRzOt4i8sxGusBDCvDtY8I2si5jESz7pA6pMcC4GdrhDYzfSe4ee6Ae1ML/ZdUwi8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261026121527099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVkYgQ42jtjz/Wk4yH/pP37DZCWB9Z6+Da+Z8XPSHWFoUsS317EVxPKaQQ8Y?=
 =?us-ascii?Q?KnksgqR24qM5HJ8dUK8y41z423MSe0gWmW448ip7hfPQJFYjolxP8lK2fRRq?=
 =?us-ascii?Q?zYnkiJdhmD65H9lj+Qybup7L+vvhdUIVfuimJ8RrLgLlhvz4BBJy7yI3byxw?=
 =?us-ascii?Q?PMPzjE0kG0lhLzIqJBz91G1vUYZTxNqGnvUUd6RnS/LuEr3ZS7ubixdwbyMq?=
 =?us-ascii?Q?ga998MYepiK1UPuv2dfZ+tIp38SQE/duYCwdBPgMD2iaQmhYWUl4/1iNN3gY?=
 =?us-ascii?Q?uxH2WclMFZQMUnUI6VyhVzPywy7nP4iCe9cZi6pvhMikmQ96auCPj4e9zf18?=
 =?us-ascii?Q?eFltouvA6Zsrf+5iPlUoLfuCWzletCYuUNS1jVA6ezzdGSiJdF8z48w7pj9v?=
 =?us-ascii?Q?wKvQzqvZUZ7q3j0GfHrbrT3OSiLyMOTHsQ8G1TfLussDRiL8KeA5UXScPS8W?=
 =?us-ascii?Q?aen5zlFNV1OBKRd7bRNTc9sI3Wn0A0oNnXrv22+AdKUzqlOAoGIb6TKBxtwB?=
 =?us-ascii?Q?oi9J9afEsbFDX53L2s245+rc+gkF9Gg6szkS1reaXhkpB1eo771+Hdof98Um?=
 =?us-ascii?Q?oaQ3rylm7yPbH69RH4B9FG2vvwnXec4q0aPj1MIujkaZrUK8GSbvWjK06sLg?=
 =?us-ascii?Q?uwTSZBvlEehyk9DQt4Pn5gVeHEZsLt+qMyeJDCUBzdFPMkkx+me7i6GxKZeE?=
 =?us-ascii?Q?4nT/Jjw4O0JB+dQ6l0t/J4B4K0P/qe0UVcqDrLdoxVALmM0zBTjuxYN72OiF?=
 =?us-ascii?Q?/PBgMlb43gdZTAlxomFuTZimHB3YOpJjQ388p7MVVSTHs45YKiVMNb0pf2aF?=
 =?us-ascii?Q?63rhNhb4gdTslubGMyJNro75e3YVOE0PlVulOPir1T0Z/tJvL+N8IXLGpTXC?=
 =?us-ascii?Q?qhu+DHSyKflr4R9MY3HKK2Elpq5Sauv+MlSuQCV2HqYndeIs0SkBD9oLA+0j?=
 =?us-ascii?Q?l7B1rjSbU0EtMyj61w9QPNkXNe9B4Wh1MtgjJM5ihtRQmgcoSx3f2c5fk7TD?=
 =?us-ascii?Q?NXSDfd5gdA/Ia0eGe8yHurOvxDbhmibKMXcbjPMmY2N19/ozPzL8dKHj5+nl?=
 =?us-ascii?Q?ZPF+4IW8r+IYns4tXTY/6rOuzQaQe3VM28ZW1pNCMNUwlP6+U9mWYanEektW?=
 =?us-ascii?Q?pBNQcSz7mZ1fWlOwGTZX+KFmYFysk9HcG0rLgCABA1I/UapuIrREDNmv7XMs?=
 =?us-ascii?Q?GZIXxeWNuiMbx754gyIFkfU8CtEg6/YekFoa/eTpyCjBufVJ1OjhMBLus0w4?=
 =?us-ascii?Q?zhZk5WRol+12QKJ4cFp3Yo+u8zhOQ1HhTRmJEUwte093gdsgZwvRIxfmxgbD?=
 =?us-ascii?Q?eP7IxIuUAt27FfpBD+fP136Q315aw0znYfSKqPfqtYprmsHhZmR8nge5Hcip?=
 =?us-ascii?Q?zQdRetmR2VnmDTNvFeLvZVto2tQq7pDkVLFZx9lfUl3/tXs/SDU+yKOhLChZ?=
 =?us-ascii?Q?J54XMhzYoMMM2xDz8FQSU3TEj1ob0lSl9C63DOWrR9vS9VpmyBfeHZfmntGt?=
 =?us-ascii?Q?NVoUxmbFJ/xr5jOdkrp/y9iFFLmOTMIXjTmNfsYgSIhvbE1z59cbdwxdUMHj?=
 =?us-ascii?Q?/8QB7LQ6shtSv9vy2cfwntiyuFUTE4RN/PdH8gQVwa/K0vwF1gSLmzkfu7Jt?=
 =?us-ascii?Q?gJ+rseSNlaz51xnxO9vLnyOW7IiF3aO+bZwbpdI6fTHliJgRqP/Wv8jnv8AP?=
 =?us-ascii?Q?Ptf4AxIxiijiwxICgon7jKXeTET3suiz8XGP5KF53K/XqV6ponAIlIjG75Jd?=
 =?us-ascii?Q?tqzGV9U9Xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12abba11-0bf3-4309-b7bb-08df46de50ec
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:36.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po1Dv3s9Og5Pr79MynYbQeYuNHmsERlGx+WSAqmO/nn8JbQUDhV6Y0fv7fIZfBVawkQqal4x1ZCYib/MPoMfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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
index e0ba17a73c4b..57024a1b042b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1461,12 +1461,12 @@ void gpiochip_remove(struct gpio_chip *gc)
 
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

