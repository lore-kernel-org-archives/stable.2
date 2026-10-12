Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C33FB07E;
	Mon, 12 Oct 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813030; cv=fail; b=eUU78acU2u0hnrDs5j2RMnR67eM0P+UYj7bsQ7W89xKQ4XUWpqjMHFYyOqRFUIZk6Kc1hf5vogGqdQlJ/NSw0yHiynUnzrpchwB5UT4RCgWZUL4K7ZJtkabQc/jV+BDtlnpsJgcxiTMt4mKCy3pe7tbc6jf7xNDale/nOG8xBqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813030; c=relaxed/simple;
	bh=bFo9z00XDPX84X8ntytEnhXR1YaPti8abbpcgGuofv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ovz1l7Cc4cQdtB918RpGEDNGlX//Kz22W3FyAa8H41RevQHWqwrgjWhduCcyEuXJHaVrvwIaUNlfWd3ii8x1jTNJNDGLXkgEiu1cj7op/tWBa2vLfe5UhfE7VejV9cD1UNp6W5sLcL25lm6SClA9To/ZMOSyfa47QRoYPzCBBzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3Dq6tQx; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3Dq6tQx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv1D8dCgEiJ+SpS491Rm596U6YgbLx440wwdd6GnhT/NXylv95ZUyn4jOrjvsOOz9vEE+2UJOGOznW6DRBhjRDbp2BxiwC+EyYr3+VWujwxg/JYlezgrxtF+ZuB2sszudIXFcqfMyeiVa+Ji5bAGzm2cEIGm28BX5YMk13c6NXr9kaOEBfXGT2HyLtM/Oi0oF8oZ8Hwmi6HxeLi8H4qndS98PQLD12zMMLmvLGLeaGiR7jE9LagaL4RkZ5nT9ejiFOb76d9Ga+LAwZbsk45I9HU1RZOeM/LbgIxCOfylZLe2eDtAuIJaFdyGGG5toaDbj800d5V7I15efk++JtNGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H0XwFGsBTe4Fl+N0NUxpoJnbtFA8/IKvtkiIVz61lo=;
 b=gHgJMk+ijTy/Bnz8KZmcmBwFYszlBH5xtovt4v6/T/KgchK+XdLoNO/dDKnKNfKQ1OxBzI6PGaR0aoFewS1n7PDrSzUBMmFrTV8WD3+POaNtERwCChIzbq0nkMImnFx+iSi4LbQb/t+2f6gDsqAm7J0BsgEHuSFF7kr1MHg5PsiwDC3H42yuQl5hUObdOOPYFRJFsvDYEUUfL08KFhAxnOLI38/zDsEl3HbpiXVO/JxIGBJFfPYrvgxMod5SjSzrwX2XJjOWu87c3jD+Kh7rYiGMDSwYIRVklVMjvGbSPTv7dQjY/ZYREJ3FfnZtwKFik6Z7T1ZKWBO0KP2IWoIjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H0XwFGsBTe4Fl+N0NUxpoJnbtFA8/IKvtkiIVz61lo=;
 b=i3Dq6tQxdf2b2N2D81Qq8xGD3L+8f5d0S1Sqd2RaEpHX4rTWItW2+XJ/paH74DpDYJCOLDecUR4OchpldiVRLVHC7kE4zbXTNtpzTDgya8hxpADyXVhhT88SZu5hAcNBkQ8qgSVcm2xOqRIBvpAWJ+/K54F9lmetvKh7hFtpeIj8FCZmz+zMz1Oj5d7HQUu6WqwVt1Mi9/dmPGddGZwTk/GuFDNrfA+9aH/mLBcJ/vTjGNGQ38YXyy3DoKeAV8dejYgcjOyZX9I+WxwbIBkgsDh40zzv9Eqr2Q0ryRJGnezTJ8KesEIEK0nXy7Vx0k0B7534jyAqTf4Lx6Sn8MCOYQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Mon, 12 Oct
 2026 13:50:22 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 13:50:20 +0000
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
Subject: [PATCH 1/6] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Mon, 12 Oct 2026 16:49:55 +0300
Message-ID: <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c18d8a-69cc-4a62-12d8-08df2867c182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|5023799004|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	pyI7l4QiVlfEkwMrNqAE2m2VA8aWiLbrFebeWZ0M7AVZzeXoiMgJFRwhR8WwH3TNi6r7Y5X3yd6v0BFroeL4r4IqLF+r3oNie9rCtAC9DCkTwM2pkqt7Geu+6GEj67pQoxSZ6FkHEs2lmrlvh3IYeLLnHY+mj2fvudA0NPTovuC5ewg3cTDOGlhXqudjXgTyZdFaKMf2YHjqYs6kMiTRU1PtEVsH+xC9wbz96AoQBbzaIDKIGRVXIcXBMYd5o8XzX6UmtaIMQRHspspOvzJ4vJPH4nOSXRMSeJwwwH1Zeamq8jXKKByK0rUJQbCKeogRAtWzZeItFQhe9Qjw2ubNdO5uh5gVnyUw8y2UnUxe2vHI9a4a9plAcH3wLaJxYz9DtgOMb8B2LUYr3Epm0XuLN9+8XhgLIn/p1KX4h8sNa3dYhVtCkmFK716IgeA/5/JqrqMVScIn75GA0eLtYbzvssW06r1UTt3L3LO2Q7YjZshzzy/OPBe973BaXfNQpR1l7n/SYk22MlwzJWrKOKfMuQ9MyeXRJCMuWngLH8kEHDK1IxQnoZZewNgzD96LkuVJK8tE6vEEsk8YLMiOrTrqS3W3OBOe7dPsR0l5gmyQm0N2BkAZTbHOwN4t9R0IPB7hBqM0wHM4DL6x5n3veAk9Yvg/ODx+RJrmJLkH8ezhz6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(5023799004)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a1dL7tz59D6ngt/K1QPAOPMalSb847RIdYrXFS6du9LGeEqs7crUN0upBhD0?=
 =?us-ascii?Q?Ci2kkbRdbSs8Q9TsRMR95Ei+n2utDod3KIXovXzWXJHkMJ/rASuSLDGpeb9D?=
 =?us-ascii?Q?zuOX4xtchn/mU+C4Lpfr6lzn2tKRHR5WbG9P5rLEX01fg7uVIPYVs+3+f+83?=
 =?us-ascii?Q?pfx0OR7VlWe90usNFDJw1na/FXEXi3ZJbJAd9YMrVnKDNhvWgV703VlyuHOv?=
 =?us-ascii?Q?hxIXkjluvM2lzwzsKGSt3nz2AD54NkErjnqB78zjIBtRPY3g3csHDMYQktNZ?=
 =?us-ascii?Q?ZplqkGjgNvYgMEEcJjp1PNFcFCQYypzLDgD4xsyeiqU0JRN2keDYE1/RUpj8?=
 =?us-ascii?Q?X5hVONqwnUP0c9LwKXnoqu9j/hoTZZjncElACaakIQ8SNc7HwOKBiFzbu8jf?=
 =?us-ascii?Q?jWvVNq+WJSa1wOLGJ1snsnEvjplx0yCQ8w3OgPUR7GCQDMJtW8eekiCPAx4G?=
 =?us-ascii?Q?md8bWcl/8PdRjzeEzkFtamczy02eFxInJaLkF+vyoSMbU8X/dBtxlFyUYUyP?=
 =?us-ascii?Q?DG2YLuDDeH8BiCqJndIctI/syYNdKl0dzSS4PpDJQjOeA7LPTUu3dtVF9HKT?=
 =?us-ascii?Q?NdWGLIfjTpaWAVGbjXKFwd/+l0nnBalqMJTpi0Ilq3u6tI0hOD+wS8bOB4xQ?=
 =?us-ascii?Q?37XzJQr4yTOr++B48CBl6L0D0+9qW8QMHyj4ItlB+5wZFzYSHd5KcEriBmap?=
 =?us-ascii?Q?dZBtCL2MFHGXbwb2v8uQjecXVEdVhC/HJNFI5jTcC8rn6L1Ving8jMZQoyjN?=
 =?us-ascii?Q?qPLkKCIiU3Bgk9lb0qy1QaaC2tpLjnRT68w2jWYG+/56c4XxsRCMuq8szl0m?=
 =?us-ascii?Q?SUXvLkos21eL3Asf5F0rx1zToB2Ng0W15iM7/W+gxJlvQ88IYObPKxSDEhh6?=
 =?us-ascii?Q?U4921qEhuxLokYkRYcKD6DKuLHEV2wlDQ2QIiFHPKyR/SeZqHgP110FMiaDq?=
 =?us-ascii?Q?VD6YmkjYWe6bCATLWzxbaG6x/4Z13bG8WwaNrEticuL27vzPJQzUAGa3zs3Y?=
 =?us-ascii?Q?HG6ff8VSOQZtjsg/HT+jg2Z+gCVzEozNkS5s4hQ9ztrgQmxHg5SkBMRHZl3I?=
 =?us-ascii?Q?L7c5U0QMXe1YeABVDSTDe9ZsOD87xWcd3m1AtXu4yf8lY2ry1G04WAXKeEGr?=
 =?us-ascii?Q?HBh6A6iC7ocKZe7sv6vNie01lm58jI2875NgKCHeTM9zeEzcvG9jgy6qpSFJ?=
 =?us-ascii?Q?q/etsoGIkumKcsklFRYkSyZ/oEf48ZilAwm1UBzl6UaPhUA9pNuD/+MmVg+x?=
 =?us-ascii?Q?dIZPOYDLY4UAiVKIIUdstLL40vU4AkKioda3nmL4Fp/R4cNvoUugupUTZeMY?=
 =?us-ascii?Q?CWtLiEbYYmDCOCZAxEUdsKz2wnaZhh5y+KoqwhQpe1JwiqiCTV8zcYEemB66?=
 =?us-ascii?Q?DHpsNwAvM+Icol9hK52pVsdMQQgFCBGzAlXkhfpOkELGuwnpaabZzsnyy1CO?=
 =?us-ascii?Q?HO+gG9ell5LcmeyYbgKpRQhr3yXXIlwf8C7vSy1Adn3mhwkUCmRiNYz7WT+T?=
 =?us-ascii?Q?wHOU3BHzQ37s5iWO404e30BABosT1VYslmD1iqnK/3DI3Fhxo6R3UA63hsST?=
 =?us-ascii?Q?wdeVttDQou+J9fHWXX6T90CH5IJngxdjONGzauDOssSDVV5Gm9ONEx2HKnIC?=
 =?us-ascii?Q?W55MlCDMqlUBGJzrT9kAuweeOOCYk02mPEvfY7S57MXRjGxP5PzU78HX9jNB?=
 =?us-ascii?Q?jnA2RiHNjvukAVf4lCU1YwGsP813aKYtUWoNLvo2SKFIOUnTC18qSxXkHUUj?=
 =?us-ascii?Q?mv7h64j3Xg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c18d8a-69cc-4a62-12d8-08df2867c182
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 13:50:20.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrZ4QnfUmTE55fRqE9/Gjmy0RXetWWmuYbyCqjTSo58FuL7qrxFDIb00uHQo0hQwxzpbNcDwrc0UW/OsIMnkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

desc_set_label() frees the old label with call_srcu() on gdev->desc_srcu.
gpiodev_release() calls synchronize_srcu() and then cleanup_srcu_struct()
on it, meaning to run the pending frees first, but synchronize_srcu()
only waits for a grace period, not for callbacks queued before it to be
invoked. Once the srcu_struct uses per-CPU callback lists, a label freed
on one CPU, for instance by gpiochip_free_hogs() at the start of
gpiochip_remove(), can still be waiting for its invocation timer there
when synchronize_srcu() returns on another, and cleanup_srcu_struct()
warns:

  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
  Call Trace:
   <TASK>
   gpiodev_release+0x20/0x60
   device_release+0x3e/0x90
   kobject_put+0x67/0xf0
   release_nodes+0x3a/0x60
   devres_release_all+0x8a/0xf0
   device_unbind_cleanup+0x21/0xa0
   device_release_driver_internal+0x1c6/0x210
   bus_remove_device+0xea/0x180
   device_del+0x152/0x460
   platform_device_del+0x20/0x80
   platform_device_unregister+0xd/0x30
   gpio_sim_device_deactivate+0x26/0x80
   gpio_sim_device_config_live_store+0x254/0x3e0
   configfs_write_iter+0xc2/0x130
   vfs_write+0x252/0x530
   ksys_write+0x6c/0xe0
   do_syscall_64+0x109/0x5d0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

cleanup_srcu_struct() then flushes the callbacks itself, so the label is
still freed, but the warning is what the comment above that check says
srcu_barrier() is for. Use it.

A gpio-sim chip with one hogged line, set live and back in a loop, warns
within 4 to 60 cycles in three runs on a 4-CPU guest booted with
srcutree.convert_to_big=1; with this change, three runs of 1000 cycles
pass. With the default srcutree parameters the srcu_struct only goes
per-CPU under contention and the loop did not hit it in 3000 cycles; the
warning was first seen that way, once, on a KCSAN arm64 guest unbinding
a USB-attached GPIO controller whose firmware node hogs a line, and
since then on real hardware with v7.3-rc5 arm64 KCSAN kernels, when
unbinding a USB GPIO expander whose driver is not yet upstream, built
both as an out-of-tree module and into the kernel.

Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 772c6f04f489..1984f3416437 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -895,7 +895,7 @@ static void gpiodev_release(struct device *dev)
 	struct gpio_device *gdev = to_gpio_device(dev);
 
 	/* Call pending kfree()s for descriptor labels. */
-	synchronize_srcu(&gdev->desc_srcu);
+	srcu_barrier(&gdev->desc_srcu);
 	cleanup_srcu_struct(&gdev->desc_srcu);
 
 	ida_free(&gpio_ida, gdev->id);
-- 
2.43.0

