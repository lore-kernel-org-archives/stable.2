Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60646AA76;
	Fri, 16 Oct 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142629; cv=fail; b=qY8AByAsMs1a3woFtteTABjIPIJl6UPcrkvw/PgKeB3KWv6ERjjbXI8vw21RgmznFn9zOFI06vMniAQtX4vyO8/PVdKP9FlaqoIdNaOxBZb+DfuIiSdUCQkZ72goedA7LQCcXRvyx1Tv/B+1Wxs9oocgUcjjal1NrWI3LCAvPMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142629; c=relaxed/simple;
	bh=Uldj6/dWIQ6QCV/XFIwvdq6ZgqFi1Z+hFdUxcaEDPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8HiMhALUhKZeLqC3spE7yfq9aQJDZtaBWZEQb1p4L5u+A99rvoJ/FckPQAMOXlGW1Me8fpO7f9KVXItWH31uat9iAWOxCwCpEzYwM2RjXKHMY9FNJYFe/vEeMOmM+K85sWK10RFkMzIew5vBqLr8RyJq0TojTlWMazkA+FdrtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BJmwNsZn; arc=fail smtp.client-ip=40.107.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJmwNsZn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzRHW+o+T+y+kGDzi33R2l3BBfEduSYBghEVKRI8TSq7vd/TbDmV6d7PJVK6XjC0LZYoryY8HOXESWWcronwZZQlMLqIcQPmW+TZe0SSMxQ8kU65c447Az+1tcTEqJcrErMf2o2wGjuljfjDDLoqyCdapMCbrbPh4yfe7kAc5xZHBbLO1ZL3LLwWn/F2pBTfmA5GwmO7FRU5Nq6bmOnxt3Hc1bRMi/hMAsBaYyxGaf7Tea9azBHA7OZzHr5hBHu3tBGaXLyCH4x10CdvzO/0P83ESJup3u9Z3GbNFaaUiTp/km4lsxA0kwIYgIWzgSDa7jkFoyoxokPVlizM5LH2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc443vv/CN5MV0+NVWt4QjSHSusAFvYkAwZ3163U5c8=;
 b=gcGoHst7E0yPxXre9TAX5UjbT2D/rrQvZlWlqF2YVIEKdoRrh08kpi/3c2B++Qgcbwv5KtGc4V/GL7VJCoVhWo9yszzu0DiBnoqiTCTG2paztvGdBrwVnGw8YyGaZNY2Yy/entxfgtFdMrNy14YhCbKPcNEDMf8+shjs0Gnqs/0dPRq1vKdXUvjSlp+xlNl/471vjr0v0sKCwYvQ9spsv6RWJFpyngd6lH93nI04AOPUR/abGunSSgX10SDTGVr+DPils/Uem4PMTmtjBsZvIBxNZqcbqW0qW66UQ0yapFXvuZj3iHP2+UAKZCpFPJCZDb37PL+/20D2Gxs9ow2R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc443vv/CN5MV0+NVWt4QjSHSusAFvYkAwZ3163U5c8=;
 b=BJmwNsZnXMkFDMlf5H+lvnYcAQ6HnCttShB48blt+Tz749nNjIRK7mMylEa/ER9pX/t4R/9uYIxYRcxKZbmaXz9gYahd1tL73TiFMArPo/cIRSmd+N0jqf2N9WzmRZB4+WI2YfE98kJ2Stq7Of21IC+o7ngTpoKuQNWZvXx+PKxjK5gW40dDH6KDJS4/XtKDlwa8e3VtiRSb+O7Fpn0ijDCfuol4rPdOJ55KZ5OKAEfsoWtnrw41EZbvur/2jg9d+t/0tY9Lbzl8r1+mQEA+EughnEhGqVdIPZafXIAPzh7xD7MhVuDPpILIhc1/RSykWbFmebaMdD1v+8eAwzZ41g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by DSVPR12MB195923.namprd12.prod.outlook.com (2603:10b6:8:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 09:23:45 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 09:23:45 +0000
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
Subject: [PATCH v2 1/6] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Fri, 16 Oct 2026 12:23:33 +0300
Message-ID: <20261016-gpiolib-chip-removal-v2-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
References: <20261016-gpiolib-chip-removal-v2-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::7) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|DSVPR12MB195923:EE_
X-MS-Office365-Filtering-Correlation-Id: 01352943-550f-4e10-ff53-08df2b672d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|3023799007|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Rr/b+UpAtRPo8Dbspb+NOhpiWljzMhzIA7/4tQdsJyuRGP72NTxcc1SehNILe6yChEMuTXPYP3y8n2kc/zDJX1l8AY/0VeK4Yi3udQlbKCA5Jevoa9kZICFu4LkdPsSuz0lkxzPLrRkLxlGAivQMSZmY6suPdR9LbIoqMdfdGlNUajZVypgAoD3wDZyFiwo/GLCohi25wj6LjSzBrs+4CNJcK9uZa78UrHTp5bLm5q+P1pCLXl3wcyelpXki/nm9VsXhnpZcqHc3ABS1kiXNCPMmYD1aX2OKcOVpr72Vd+hN+ZinQEMej399ZrJ04uCHwgIg420qkslcXJeirSYTMQfFCxbwg7aZ6daQOhfPniBL74vKYr/4bxcTSQvh1XxdAzxO/sVMPkFlLmBmwKqsaaBW8bRBMN4M/Vh807LmYQ6nUGiruw64UDh4xl81vl4wsMY9QhGdJ9T3TSXXcwIA6jb9qarMbv5S5vjqPPtNczkLrlkpSwvgKnIHUHFVSXznW5/5UMdQ8/NHQzmeyg2jr49qZo8DIlxGEgzfADOSbxGSlGUEuYzWjJOyLx+oqAKdwd9wsH/bNEyqv2h9HRtbe9aTrgibxe07jikP5Q2pXQrfzALS7jJuMHwooKr6PdAVmEenQc8uRiuBn0qvRUfNyRjFSnGI6QVNTmNFgKsq1aE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yDxKumGQw/H2V9lqoosPXSsdsmEpXtrHX8hknSCyDBOzutX7hO8YWC8r81wj?=
 =?us-ascii?Q?BIqfQTv6rHkpm17u9PME0ocxHwc8dKayGr/weDeIxxlgTN6KDRUzGeqJ1A+a?=
 =?us-ascii?Q?q6RaUmGvyryv3m7cdg5nfqM7Uy8gcFD0+A7G18E7qlU1HVVGhJyW94fA7G8c?=
 =?us-ascii?Q?xbTt3BLgj/05kK0KQdE+yzAynv6teDm0iEjlyZnOtM1Y92x5L6dVpXkiJ2VP?=
 =?us-ascii?Q?tUin+a1aG2Snc/E/MPV8KKjTr24CjtQocT8vqYOCyyQcFhl+Wsssqjax3rry?=
 =?us-ascii?Q?PFfCM9jBh3SV0OsF6L/tiCn9FAp7V/fBzubFI60VJDIwqAKBWZYS+eknBF/1?=
 =?us-ascii?Q?TjWSpBQIThUHa1Acu5KtNy6N4GgOdOnLFJPTt7CULxSk1LoH1X0wjeCz8cF4?=
 =?us-ascii?Q?/QNCo4hNVB6fP7C5A97W1XUTMVKmLBxGIHtRM2VqdAm18fwLUqLWVQ42nQ2t?=
 =?us-ascii?Q?4z0AchTnCyvKCxbzSrZSrkuOpg/Jrwy6STIbRvAdsRITc7Fq0pQjmOfrv2DX?=
 =?us-ascii?Q?hTuiWs+HEippBVUeX/IxlyuB/vCr8w1ic3DcEY1sSch0Hbyt9BFOo+p+d6W7?=
 =?us-ascii?Q?xSDd9OOFaBrm5aS5rzf3nhwg8h0lMdKESYSDo+GeE7+XZ9PvG6P8tbG46oId?=
 =?us-ascii?Q?HzEmcQe4qrhDYUVUlYc8hJNpymMel7qX8IMIG/t1RrhhmenEJMHDMCha023u?=
 =?us-ascii?Q?UhtztcFsJdPOcLt+VB7QXcFnC9IzYCXB4hy+f+bPN/FhVgD0KtJ6JPpLPYvd?=
 =?us-ascii?Q?tVYZm3+D0K33Q2CbWguzvHrlevgNmKAkH7BdgmSP0d/jnHQE7IIOTapl1897?=
 =?us-ascii?Q?J981tRNpYqM3jZxrTR90BvIh/4oQMYhdbcI3CSmRGBkFDhZ4G50huVVYjEc3?=
 =?us-ascii?Q?//Xc/T2X4UCSjRNJuYPD0WKYvf6RiPN1u47s/1+jCf0SvxGbID9PVUSlQxu3?=
 =?us-ascii?Q?RjSlLA2+Ky9kyLZJs2JtnraZ2Owy5Hf7ZKlhj6jr98pH/SoadzAJVyfdWzV5?=
 =?us-ascii?Q?sItQdxfbOlJOgIc3ta29cK/8riTn2e/iBbi7InBo91MHadGCNjwfJuJlubnv?=
 =?us-ascii?Q?S5XLKf4giQbBGWqsYdcfm9nirMeq9vXVBjXcNBC77cJHsLuQzRaIPdjZLlSv?=
 =?us-ascii?Q?IoCov0I0AX7HPiTKGCo2Zs2JKLJgxcNgunTKC7JGipb+zC3JMeVEC3FHAiVI?=
 =?us-ascii?Q?Pz4TvTTPOKbtkbSc5Aq6Dzc63FByjEgIDr35NTEnFNTaHUagvtbhCbrgb98k?=
 =?us-ascii?Q?d+acEW+ck3wDZ94Intuf66CsnL1P4fAv8hirQl/lrAuNedl6PL1MFJ6722Cg?=
 =?us-ascii?Q?jCpAB0H53rsj61kF0bhvOm6PFmKlDyhk4Xaqo4/E2+gO9SkrgIqzaKZlg/j4?=
 =?us-ascii?Q?EB4hH/mBj+uBmEhm1L6H3JrES2X/48iuW4cBRqu9fkf62YyH5ZTrK3SHI32S?=
 =?us-ascii?Q?IwQhOFYM4O0f2uOInwQ0IMbe5dnrImYGFMgSU+CUfISQtMBzSB51o73iX5RZ?=
 =?us-ascii?Q?t0TpCJY/gLsv351+DiaGbRKigsiTQ/3/cau3E4dRV3kNjhmNOej0EB8SggsT?=
 =?us-ascii?Q?PF2b1SBsc8KO0lxBQGSPd5BS3G9b0GO68vxlVwDIL/ydof/uXIuRTX8mKmNO?=
 =?us-ascii?Q?LBA+VvyM/CTDi+WAu194bj0H2czGZl5RZWQ+R31We9aPsnUevFWWASiPRHbT?=
 =?us-ascii?Q?klAsVxdYBhcAi5dIvUI6lwoRgKWsxC43//PxaBSYNBABlXXJ8uFf+lrITu2k?=
 =?us-ascii?Q?0GTpLJItbw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01352943-550f-4e10-ff53-08df2b672d1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:23:44.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtAe3bCIW+Kxc8ycScyThOHhO5glUJ/piE2fcHKDXt3RhbellB2A1r/2oR6iLIwx7zLLIOh8SbgP5CoBgfEOzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB195923

desc_set_label() frees the old label with call_srcu() on gdev->desc_srcu.
gpiodev_release() calls synchronize_srcu() and then cleanup_srcu_struct()
on it, meaning to run the pending frees first, but synchronize_srcu()
only waits for a grace period, not for callbacks queued before it to be
invoked. Once the srcu_struct uses per-CPU callback lists, a label freed
on one CPU, for instance by gpiochip_free_hogs() at the start of
gpiochip_remove(), can still be waiting for its invocation timer there
when synchronize_srcu() returns on another, and cleanup_srcu_struct()
warns:

  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct
  Call Trace:
   gpiodev_release
   device_release
   kobject_put
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

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
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
Changes in v2:
- Backtrace cut down to the warning and the frames that matter (Andy).
- Paul's Reviewed-by.
- Assisted-by tag.

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

