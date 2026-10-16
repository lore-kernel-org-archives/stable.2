Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CBB3BC69E;
	Fri, 16 Oct 2026 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142632; cv=fail; b=NoQKy8O17wKTrUknSBz2pWCbfQnieGQSm4krNhtdVRFQyjr9l//yc3HeOPKgeh8ElWdclpPTORhYXkvazdm2U4PjYpLxQVJNjK7jDPQKjQQUzew2t+J6BYH7BqbmSe6aS2xejdrJL2BEFxNjP7rIIi33SP1mj8zPvgB1CEspIHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142632; c=relaxed/simple;
	bh=9Tia7HzZeJSlI1ta87Q0le4ifE0DJFan1MHX+0n0NIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVSB5nR9JFZW0sxqY/c9JcpMr5H7bUZ5sL/dNVqB6mB7KZvQerZJmqCvZb58kumNz2JWjOaGoRPlyVNwJwkDhL6w54D+a8ORIJnXTO3mH3+RD0Aowc1v4qEt9xhGiqXL9Pa6XSWD6Buar3nqgSpLJb5HHjupmrUci1JnbX93o2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VI7nCwsb; arc=fail smtp.client-ip=52.101.52.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VI7nCwsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQexpQwoOJFjW7owmj/5mPEnTL5IwjglluqnJmZadlVlv4BnVqUuxJ+1oA1PoPvKmfQfF2XArrLgKNovKzeBJoftIGz2KBKkIWg46v1vlKM9/Z/Yu2vAQo2XgNFc53OVIBj04/+UwqNrqqkgG56wT1mQiExqyfXATr9ru/QSoPlb2z3dDeHTwVKe88qRogNytXn4oOJHwgZ7OtbZJAVJEHbrg/zLxYOErBYKmi0t+uJGTcK5fl8IaUqAspcTqHQLXbBjc25VOe1uRzqvPtLo3JVyTNI9ELdTWxeI6AvKzIOeIweotOMKRcHaP1LD7rCt1ZhpPwFZGCbJmrh/qPXxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9tNTwYXBWJ26/Y38RZ88gBPeSHJrlJl7vC9lIHxOug=;
 b=PC7Ume1ptPr4h6clzmTQH2tcIuSgp065Sdmkn1KDN+VIUgkCZvf3lAw6/CzT1XpWzHKbjqa1WtKTq9O+erQRLUoaMRQhZgcEyxX87MYYPZH87MPKXPxLbxmmYBVVmsdP3MIercosC+Opcufiq7kzCMHajaU3UPTWY/lAuuFjwHyYHrh+/rz+flgkooGfw5ec8IJDWPcb/XikxMTlTiFoMgLItY1xB5srxRbCwBXqQ4TYyYXSpfYqmSgikUxLlHAySM2KCcSBUMJ0THfdxeuOM15dB4Hx97WZPNRYl3bgKDn6KZp0k/3ehHJFUCYgQAOubNAczc8dRPvsr0zgv3/a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9tNTwYXBWJ26/Y38RZ88gBPeSHJrlJl7vC9lIHxOug=;
 b=VI7nCwsbfYB6vom7HGRR/gVRWGjigsnHmGJcTrIhknuRohc5ej36t0VqO01wDj6wIJ9N5X9raa6DN3rqMj0pH7bJtUe9sPxeI8lfAWHl6PN0r0p0/pYyBRBPazPNmdb5neMMNNT6ixATX5y/Wv0yB2711lA56N1RQIYeK+YPEsJmC/ZpMrZrZuzwgEqEA9ZFxn/914rsgEauo9LbpqPIu9kZkMQ/jw7mkVy3hHZa7c3C8ExwM1r2rq1krEzCWcICHT2eAPRhxk6YCm8bMdC+PlyRLN9fOjwdLmmnR7WHjSS/GNOVfa9kbWoC5HvKugMWIfZsaWglN3mGpaS80b9ztg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DSVPR12MB195923.namprd12.prod.outlook.com (2603:10b6:8:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:48 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:48 +0000
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
Subject: [PATCH v2 2/6] gpiolib: free the label of lines released after their chip was removed
Date: Fri, 16 Oct 2026 12:23:34 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::20) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DSVPR12MB195923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e633621-c124-4b25-e60c-08df2b672f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lrrGBTVLsb5WOmrSIWA8gr6sksSIhnjYHWnRFeuCuzDoVP7eXJPl5USStGAYio8trdpAjdICw4m3Rq9TjFpP0JrZ1f6QHHfIHGII7F6tcywctGUvJQdhhjMeE/eJHmW2Fm7HcEAJNcrbunuvUzKZ6Ioyu0T7BwxKNz2s6KaK1fQlleplFlR3AgGX9o8YAFx601n5usZc89qHKWZiwFLhV20cj51R+8V4cf+oqOG1zXbT2LRGp4EQG4i0nhAKKiLVxwSkkNCyil8SqkfVQga1Acg/NKGRQJozc7NF8/lzUwjaAXQ2GOUdrF8FVX87rDa4MR56/ikoNkJlEd23XMqI3ov/0e4U12NSdNL2Cots2mBqEbytponH5La48kh1obE0K52O19EY5r1s/WQ2xlysb3oW4nhqzmuvJ+wIzgED05rrbYO2GlW1vdYOaoYZ1hmvglWrBbTyQQM3GxGs8AmtV7OD5Vd28qW3I6mrSM8P7wybAaR+fyW8+rh/XFRnUPW+d6mZaXoRh0rb9mX//50yoPz3W/lsqqYaNLJoaTjfs/L7YcHFgGyGkgYx1//wpZsT8VbdDuADe3Ff39LkAwAS3lHAtWMoQ85sbQwIyMrFi7v+Ri5MGw6lG2XaeyOvCb+7C+++WqOiJTiwVHMHs7aBls23LcreBCm5BmKMgSuqIAo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ca/CPug089litCWkJf61i72XvcrsyiCskP3BoGX37dyqZpTmeGak58gbZHc4?=
 =?us-ascii?Q?8Yr2q7hV+804eH3icx2aMjkHhxJeYb4nRx5qhykOhhWsw5a/XA+1uBfUIwOQ?=
 =?us-ascii?Q?/kB+KTbc/NZTCyuEm9qAwvd9IcMeZ7Cbg5yuOYYr9uSAU0veyETFwCXAbEyn?=
 =?us-ascii?Q?TBKwK9Ij4JLFWyegG1iqQFHwqOifJjPFYCBUoMSynZFsIXsqUpGybDlxGPkg?=
 =?us-ascii?Q?Ohs4lp/pwA8D6pn48Vn5KqgWvt9xDRgy1P5wejxzv6sZjYd1RFNjXXQSU1yS?=
 =?us-ascii?Q?x+XfZb0pQch7wLivWfNDVm2L7yGTjAMW1MY2U/+6SBgvmvjLI4PyaSLvpKcL?=
 =?us-ascii?Q?Wmji9e3Nz75eqRQXYtXSpwfX0Mw2YrlRGKnqcrKKfVokB/f/A3QWOLpEvVik?=
 =?us-ascii?Q?1YEyslXV/2Ql5UoLUFgyKkgpY/CETFuSLizTCXLk3V/Wz4BQsutBymFXzsWc?=
 =?us-ascii?Q?D6ncDpZ9YbKCI2O9dILpkPWqT00VKK7+hJpPVuo26CzzMFJtgMKxoq4H1U9J?=
 =?us-ascii?Q?dzDFLNtuRwfxW/XU2krn1242Li5zapHEX9WwxoXTvOPQi76AzBioX5hFcXxL?=
 =?us-ascii?Q?8YMiGJVpEHbQsWMU0+If37YULpSAeec4MTsyyZhYQDeN/Mto1Oy3teLMohgZ?=
 =?us-ascii?Q?EaHEAWEyc/scSBGZankAjIsX3HHOnFOVzBoBicEX87BaZv3s9M3bShgbXgmM?=
 =?us-ascii?Q?tsG+q45rH3eTfdLUCOAtraSjKGojTqOPtSkjjRUUdGDxd+mWfoj+tJQp9uZV?=
 =?us-ascii?Q?1JFbkFirQUqThdPAysxLgo0YGLh8uOyzc9cV5ZZ8OoVkSggJACSiDPHN4fVl?=
 =?us-ascii?Q?ympepYORdEzlCT6MRgfpywpIqx+sPa+SN/8GEXO/dKleQWL4OMTHlWOb+uvH?=
 =?us-ascii?Q?k5jpXodaQQHNv3N99W9Fn0PpWuUp4aSI+uICrLXQ0ZQdpq2j4whC5Bx5YtC1?=
 =?us-ascii?Q?xbB94HhYLe1LPZiGEeCL8AB/ngGmeyHh2TjAScfdvLgU/q5XaOKBXPnXJTYm?=
 =?us-ascii?Q?Ii4n7o6RDIxQsTFVFfTlwBHN1nTTAU8aNHwt84h2EtA/cSrlOm/CfEB4Dmfw?=
 =?us-ascii?Q?4F6IaZCAbwWYgN48swDriEbFbjw28UFciTcVr0SX3wfhk0mL8/7gx+WABhg7?=
 =?us-ascii?Q?af68kjZLSmG6wdGtYxg2tz5dQvExC8fNNMFEVX0nwuExHl45n2nk6cMPXVwk?=
 =?us-ascii?Q?NV879yb7W4nFsuaweNxAYssdFFKGmnfxXBIxi6TyJdUbu1aUcCdc1/pKVUq2?=
 =?us-ascii?Q?U7CsGN9G+6OdHv6mAJ7uMlnltUOJSQmFCXY1oo5o+kID/8+cfPBfXXwtceBi?=
 =?us-ascii?Q?5NdNMh/q49e/Y+ucsnHwVO9wUvAfPRXOLNUfQ4HNuRETSJLdSHLjGSYHHWAk?=
 =?us-ascii?Q?HSCwPNbODQfKPLyL3MPE/UuZV39JmpSJFovbzpTVYjPj7DNxPXZRIMRxsA7B?=
 =?us-ascii?Q?VAbD40EcxIjThnQIkhVZY/d4ugzhbxx4aTq0+c74mJovARMV/3Krbl96qgDi?=
 =?us-ascii?Q?YcR72rPogDBo0x95vrPZc/VyxOihA0Hpq2MPgRvG577EHVHQKcNL0QZDwlmj?=
 =?us-ascii?Q?6YWEpwFM7x7FRwQxrA6v14/N4A7be1JdxCSsTc0/C06ACFzsKYK5H0HXLLYD?=
 =?us-ascii?Q?0jClXWZukTkRXUQ0l42vsCBqqVHhW/FgXwNyML6jNTHtgkkmT4b77BAWrdcQ?=
 =?us-ascii?Q?v5jNAFh/CwAkjeFtRlEWuCHROGeLYKFyuAT4irbk8ccCV7piSz96ViiB5XhX?=
 =?us-ascii?Q?ho14ThGBAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e633621-c124-4b25-e60c-08df2b672f12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:48.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvYxtqsIRw31WqGnTEBZmIJPqMwDHTSQsb/+49iUlqybvqCq62pZgHU1phS9ZdBhXJXCs6v4Lw0tPx2Kg+8Gwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB195923

gpiod_free_commit() only drops the consumer label while the chip is
still there:

	if (guard.gc && test_bit(GPIOD_FLAG_REQUESTED, &flags)) {
		...
		desc_set_label(desc, NULL);

A line that is still requested when gpiochip_remove() runs, for instance
by a character device line request that user space keeps open, is
released only afterwards, when gdev->chip is already NULL. Its label is
then never freed, as gpiodev_release() frees the descriptor array but
not the labels, and kmemleak reports one object per such line:

  unreferenced object (size 32):
    comm "gpio-hold"
    backtrace:
      desc_set_label
      gpiod_request_commit
      gpiod_request
      linereq_create
      gpio_ioctl

Commit 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
cleared the label unconditionally; it moved under the chip check with
the removal of gpio_lock. Return early only for a line that is not
requested on a live chip, and clear the label before the chip check, so
that it is also freed when the chip is gone. The ->free() callback, the
flags update and the line state notification still need the chip and
stay under the check; with the chip gone, no character device file can
receive the notification any more.

The label is now often freed just before the last reference to the GPIO
device goes away, which depends on gpiodev_release() waiting for pending
label frees (previous patch).

Reproduced with gpio-sim: request a line through the character device,
set the chip's configfs "live" attribute to 0 while the request is open,
then close it. Without this change kmemleak reports between 15 and 30
such objects after 30 cycles; with it, none after 100.

Fixes: 35b545332b80 ("gpio: remove gpio_lock")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- Return early for a line that is not requested on a live chip and clear
  the label once, before the chip check, so now before ->free() (Andy).
- kmemleak report cut down (Andy).
- Assisted-by tag.

 drivers/gpio/gpiolib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1984f3416437..31ccdd373765 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2666,7 +2666,12 @@ void gpiod_free_commit(struct gpio_desc *desc)
 
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
 
@@ -2683,7 +2688,6 @@ void gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		desc_set_label(desc, NULL);
 		WRITE_ONCE(desc->flags, flags);
 #ifdef CONFIG_GPIO_CDEV
 		WRITE_ONCE(desc->debounce_period_us, 0);
-- 
2.43.0

