Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512050;
	b=GDK/Nt13J1UgTs8Umkg8MTWRfEJajoCFH0AyCZrSqjXRQNLpafdHTBUuW1N7rl7FUTh2
	 QOshH/ncSm6WDSuk3Fyv35BWZFSbDgwraF2LkQnXFdFJD5kV7Vx4FexEL+xlYhft7C0Dx
	 nuNlPU7RWb+lAg6uo/ERfPjM0N5f65v5tm5IADAlHZGoRw5l/fYpjlTpcVQUlIQ20Fj7l
	 +a5B+UQSsD3uFiYdYUpGfL1hrzXyB2YO+jSAdauE41tz25vIXMvrPNwDeE8j4M5a8PIAd
	 h3PxnwLskpLVjDXjywb0QnWO6a46/1XioigDI+f/xo9darxKHRHNVjl2RbbJdjws0xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512050;
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
	bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
	b=u4vOEyAxAUVQZvj9kfMRx2Rs+nwrmAg+ASzE8s8fZS0aN8OHEZ09oHegvFIgHdj0FVli
	 P39kyXP+njWvilhLxsXhDsrRa2h2h6g3vlfbk/9xnzhtlv9akSvl1zAQ/nqoxGGG3htUU
	 4jdGckJW1y6zUN1S4RT5eV4KI/7pHFYSlrcK5vrOCxqmi+aHGfiXMlBy2+sMFcZYgtbmF
	 ClXUaxmCHDSEsCV9Pzw2aEFsuyulKqLfPntjqM+PoK15lK0eomWsUg1V35/oCLlUxrmG8
	 v0H7pLZ8F85teEOfHqSO9ubR2w3/RQaqp0rq/IQHeaik6I/zEVJKDi24w8Rr7BgfoqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VfNk5Mts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF9606A68B;
	Tue, 24 Nov 2026 09:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CDF9606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VfNk5Mts
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auxfzl/eq9+mID2Lnm9MMgjX3QmklmT7B7uinksGHbl6HAlx0h4mHNsWtZySBnJ0S3JmizdVepvdGg8uKqpr29VJBZoYWosuUrGjQfedb+nlbSePy1MTQzGC8KbuqAb/6IqXsEvh3ZQZi9yNVD5tscmj/jl6OdR4OYShtOs7qwPqu8LQuqSDmrqpiJQ/BVyKJD5Sr8szcelF+hNbbL6zRv/BZig24qvIJR5NLvMBkApAMkfNkjqOYSwf2Dj+8zduaj6A/rvMHqJpU/HRJqNcYOx+TUP9t9nkyRlRTc2Xq+oG91TGBusTajppkaVBDdxWVONgvyqY1niS83qCmFngdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
 b=YB37lh5WrwezBq22dXL+QuZilv7DfVtDy1FCH1V9Z+o9aKW7EevyjsxAjNOwcsa79ibl0BbGRDo7umzOZYjhrV1HqDdXJWK4YFxDHbEnNb8Oqd7Rop8iJwK+q59zEAEcAmuLllYNbAi71WrbyxOGgxPz+E1HZKvJZO+aHWk5sjRAjaoYoKTqwPj/7NS6hkXyoQpD9XeCpPmWT4Qu5uRhQojSsFkYy2UxNt1Qj0ETWoyjZvYOfHc6hXq34Fv+updc5NLXqL4sCiUdtI/Nl8NEyqboxCxY1LjcxrflptgkqtM+JestdQ/CeYw+vCFbsdbXy+bRQQYtDHhGkP4U/9q+Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vRzZFkpKkpiasAiHZYtMm4gaOcUq7NQRnMtwKNDFK0=;
 b=VfNk5Mtslu1+hzFMglw/RWd0HAw24ffOo2QEgKjXWQfO9YsZwYQH15cv2P3tP1h0kOsXRYKk4vjA6Zrs39ucMHhAzO4+mVd5Vb/2Fkcn/UNuVgTE75HjHYgOlstov9Cp/X6t+rxonDKCqXE00d51F2hEnn7l8kj4iQBYqNDGDNszN7bYjuKoEqojvPSQeQOg1/Pnk3GapczfSuMwOV5ZYJMVZ7WZDwAgvC1J70R+kKntZZPK92C8mcQ8myig7e1/KSftIEhf/zGKqlvWp2qfo+eCONmsmiHBoqyo7q2btI2PK7kMJtMUiL6Ipo7idzatezMHuV8uzfj3Ofocb6E/yA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 09:20:46 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:20:46 +0000
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
Subject: [PATCH v8 2/8] gpiolib: free the label of lines released after their chip was removed
Date: Tue, 24 Nov 2026 11:20:33 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a38b13-4bdd-48c5-2aac-08df4a0c387d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|261022075727099003|261021123027099003|261102123227099003|11063799006|261021121427099003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cHDuF2Up3M53EPhCKOEn11VScSDB5DuWfl9nhuSSdZSvsEAu3Zvcjd2s0djq/qeg1fJOBcZTcl7p1aaChZ0iSsf6a0xbUfEh5OP5QEbvqqiyXIWh9nMRemLYcT6xGrkdnv9jzzce6sNISnfifYVh1xImH5oRjc8Sqs5e2zEPdjsxmJTrqoKEHdmIEoxs/xaTmBcFL0sO+8DaAgtyMYmSK4geQxNl7KN6PBK6pKS++BMVMqByinFUDlpcTZe/IZ4Ae7AdzJHny4u/T+fSZ0PktMAJ6aPguX3lkHbAHavsGrVXiMeIsJXA7TI9xLbB5qlhC3M3TTfcJGMzJhbfhfZNyBXu38R7EA5R5Qkgbkt/XUeBFQ9miuR6HPbyl3Q4fUNmGTlrwel/mIpIqQ7aOrOGPu9Jv/JGg77zFGlvRuXDcFptRc1HKzIw2Fnbn0OOVm11vNzyGTU+/ZRTzq8GTaG1D10iLPCAeOMk56kFg8eHARFNH46Jo9zSLCQUOdYMUwPsEvG+sr70PhjafThSdeXagPgr2f2Xl7homdWwVqqL3VZ48sDo5BWpybrTPVvYSO9LUUHaidS4dodqFMOVPdkmac7jW99R6WxKrz90T6CfJeslhWdZKppt/yJoc3t1BDVYoM+1dyjCZDjuRJIm2034syuqkuHnqMacPE0t38wDynY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(261022075727099003)(261021123027099003)(261102123227099003)(11063799006)(261021121427099003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5zW6MMWUoFNvFKs9/k3YU/cRkialGx7WdLFnKQYJqTy7n+ck6F3W2dWkPyjf?=
 =?us-ascii?Q?EtMmUEg+1iTayRpxiDK/vjLKQ5V+9gYZeoNRQ1gCu4iwsMN+ZRnuoFerkRyY?=
 =?us-ascii?Q?+imbk/TLL0gWudYYYPmCUvu3MfGVUA7Yr0lDPL6QBOsXPKc3mzaiRDyCGdQe?=
 =?us-ascii?Q?uqb5bN1pFti0Y1fJO4v8i1DLNlYkFRqG+3QslZfyhDv3Q34oLP6jxJPcguiA?=
 =?us-ascii?Q?r1lrUkmqhZ4GKATQ+RPqBSDkooebX59Q6JKVaAoD1VIEF1HjzU7HXIg8vcof?=
 =?us-ascii?Q?BAO4ncrm7j2NN18KyG1SNnTCKNFxXpCzVM4n/U5rgjVX9nwE7ev3zHWVvBvh?=
 =?us-ascii?Q?FSQaIjHSFhzCE0mI/xlLuRVqO4+yTjhFCO5uAn+Ppt22/1lnkB3V6f4tlzuX?=
 =?us-ascii?Q?BG+v7IfTF3M/mqQUc32imMeWOJeLnX3QYiYBzFNNQoh4PMRoS1kI4TvRwRNh?=
 =?us-ascii?Q?W+I3POudTewjjirFpP4e9RGLb6WWje9hKbrcsDbYp4iJtrSCu3Sdq9fvPrTF?=
 =?us-ascii?Q?JNz0mvH+ojtOKJZ8yTz6BBO909TBGk1YVTTyNQBHUINqjDbC/HSo/16eKK9e?=
 =?us-ascii?Q?zA0WMEL/WGpJ90AG390hjQWSzLr+Aa3o7uPiuCXNarkds+LqwG1b/j44Bn+p?=
 =?us-ascii?Q?TimyV3yYy4Su3B6o4fVDRxFcUWzvPo5j04oq9/To1ZFyQVzils7rspVMc2e3?=
 =?us-ascii?Q?fDF6kZ0s9e8L8Q5FWsRPWX1UabEFwCM1BacWu/eeizNq6WR2Epk2m+jlJ5st?=
 =?us-ascii?Q?BWdqz5FJfmjc/19QHSpBFCH16B0PQKz1FvzRyeVDqYhxK3FwtiLfExBXDADt?=
 =?us-ascii?Q?umX7emJBz3l6nQpP06rjo73XXfHONRMGWMLCAedP7SY7AVOzNv9wXgf1tQYv?=
 =?us-ascii?Q?wEn2fiUDZ+0yxSb866V2sJeSeEj3bRcvrvteg0YA0QrN0tX0t3C0SzeAgiA4?=
 =?us-ascii?Q?djmlnIIibKQMo+CyIXoypGN6jb9MAZgyidtg/jNnBzaUmkeSgU2QKg+KR/Uf?=
 =?us-ascii?Q?HafgDmfmoWtFwzXq9jD17EcuX+DruQSxjaI7Oym/KSQf32I6Fx9F0LSAK4gc?=
 =?us-ascii?Q?w9UEEj4+UVD+vTpWG17yAZ+xCHXnVcGqjDz+m1xOx5W8HflNXER7fAgncxIg?=
 =?us-ascii?Q?S796f1O8OJqRurdhSF4KaUXms4JNy+DrO3Qfi9+NALklxWFfc2rfrkqJjS4y?=
 =?us-ascii?Q?zumiXGSzRsIr9u1yfGlL2J6Ib1EIoJ52RlK/56eHHJxDwpTlzaFVXNFtccGg?=
 =?us-ascii?Q?f9jK9GvLk6jnX2cCn5LXLuF+N3HRNEtvdRKhuD2Ezrc4ZzCfAud1rGZE0xKS?=
 =?us-ascii?Q?RHLdsWW6xHD1QjMV+6ecGgWMl2GuVyn3eu5sOAHbuv/Glu7tjVZQC+lHHu64?=
 =?us-ascii?Q?fA9wMsJ3Vn1L3kpcvwke5rMsi+UEYeh2I4Eh8Aq76eSuzGd/ahKiM9t4mT6n?=
 =?us-ascii?Q?1QQBKXS/e88vI1MtH+plyoDODdW8/OHIf8G4ntmT19+Co4HdyjQVj1Iir+xt?=
 =?us-ascii?Q?zuXoAwci92Pr1jIZwWmA2ne/q3s+lxzvPGE+4WmuLHXMdYs7uVbQ4np5nT8W?=
 =?us-ascii?Q?BpMbjNAipDiP/HyFJ3i105zU43PzlXz/3H6cChl1PiRt0SjyCVl+QIlqwlEz?=
 =?us-ascii?Q?g6pdeQMxkHbAlmU7SDFDs6pGGGbKe83Ca5/yjdjqnSEu7yRU7Nkr3H/PzySc?=
 =?us-ascii?Q?qnzjZz7Q5MGd9eZO/KwnFG47m7P5qESSvLoQ9kSyGxLqCb0PiOhgvYP/XbUH?=
 =?us-ascii?Q?8/6SUhd4KA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a38b13-4bdd-48c5-2aac-08df4a0c387d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:20:46.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUXu0GU44xCZ3n+zIuk1S2DcDn1eNY1Zll6h2iM/zrUvf57JOJLJpqU/SUcFqVhvkE21r9JfjKXgj2Hjk/eegA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

gpiod_free_commit() drops the consumer label only while the chip is
still there. A line that user space keeps requested across
gpiochip_remove() is released when gdev->chip is already NULL, and its
label leaks:

  unreferenced object (size 32):
    comm "gpio-hold"
    backtrace (crc 7ff222d9):
      desc_set_label
      gpiod_request_commit
      gpiod_request
      linereq_create
      gpio_ioctl

Clear the label before the chip check. The ->free() callback, the flags
update and the line state notification need the chip and stay under it.

Reproduced with gpio-sim: request a line, set the chip's "live"
attribute to 0, then close the request. kmemleak reports up to 30 such
objects after 30 cycles; with this change, none after 100.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 82e0be8864f4..9832f755312f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2707,7 +2707,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
 	flags = READ_ONCE(desc->flags);
 
-	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
+	if (guard.gc && !test_bit(GPIOD_FLAG_REQUESTED, &flags))
+		return;
+
+	desc_set_label(desc, NULL);
+
+	if (guard.gc) {
 		if (guard.gc->free)
 			guard.gc->free(guard.gc, gpiod_hwgpio(desc));
 
@@ -2717,7 +2722,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		set_mask_bits(&desc->flags,
 			      BIT(GPIOD_FLAG_ACTIVE_LOW) |
 			      BIT(GPIOD_FLAG_REQUESTED) |
-- 
2.43.0

