Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795512045;
	b=LTysCxfHu9PqTK1pG1f6YR6LpbXB/j6JCb9V6oE6afjeqqsoNcyEQBlLGNOfOq3lf6w5
	 gLoZxl8JYsdyRnJGZnV49qojSKGcJFtIic/cQwUlHlaMb1b7k7l620S2wGb+nbvt/2IYY
	 n1rpMoDgc1kDqm7nqauq+SE4oXncT2vi+s09V06QaBjFvNWIJGX9by4D/6sJXjDqwhvsJ
	 dngyG5QpDw6jTEbGuIwZ/luP6rqlwThiH7Re/W80ffWTVyxd9Lhy/aAJkqSOSlZ2YIX9B
	 1kz2NmZBydNty+nb3l3T+cekcvXOU28YI7hYxNiEHcljD3Yq9ZZdNIGr8Gz1v3Bgf1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512045;
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
	bh=0ly9t7HEJbLrZLqXFWnIcLmEQbmdCtxY8ZwqFTFcfmU=;
	b=mOeftdGbdQuqf2GzazLn/Htm7d3Ig1EdKTwZwIRWcHT00O5KFmKXsD3m0pRunc5lPbe2
	 PogtelVlxbP+n7o1vXrj/soYg2QrcUmrbY8s1v/fXZcjZJN/WNU2fqb77tbtxPAxqI3d6
	 iEDHPBnchJ/gAFBGhHuaDHAbJV/vDLdiPbfV9Gd9v5spJx1xfxKYcidFgAzWKrG13784x
	 2iOje5qH7ftyTCeEDpaReq41Axq0t5fxDb5PCyccXglRr4VCIqJcMmZJ4lVRccNxc85QF
	 Mrp4Z7jlX3d/gK+YrNAUXbZNA73Z3dyvTFB38hrwGgSY6EoBbCzAxSfeQtNg3ItvoeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lE2lnS+F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.5
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD3606A69D;
	Tue, 24 Nov 2026 09:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BD3606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lE2lnS+F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCuD4C97BwePZbRHO4QO4kcRRxmqabn0pEZvRYP4onjweRAaqmoqq1NKsmkcthssDED58hHVrx4pxMEwPzwFXcq/ReH8LkReM2EteU6lUUpbZDYn6zmc19onVNDrSYDU+9z7xA88CZqv2m2kmqE4Mh61jngRYY9CiUwnaNLrx4pXAsF62gtWRF4ZkR7wLMincb39RpIRJAkDchtzAL5WqQ0Bs40uNsq9pi9aRqjkfO/qiBHjmWfyoybPNynZ18T1JcjUpJQ2sbe41oO8fjEI8+d5dLOJlEAfIs4Ra7KGEbB64J8R0/yuC8uwpZPG3eN1zAH+rgkt+V8FxVWihAE98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ly9t7HEJbLrZLqXFWnIcLmEQbmdCtxY8ZwqFTFcfmU=;
 b=sZkDYEb3q0PXFbbaTVv4oNBXVVc4RmHPdn3PJwFwIV0vqFz7gTLPkbifoyFlD0uJCBFwX6OqHZga52qQYDODbwp8TSBPZCf3NIBKZt59gh4/ZYwWOQp9DunlOvj6q9/MItfgZ6SR0V+hNbHSwVv6NpYXgdZWsJ92pqVWIi1mLecYviLj5AnXf2I38dLkjsb3gxZOBqJBAx2E2HaaUl49WghH2qckT8iE+yvjQhlOpkEpTvZqGZ3zTx1mACYNd5tvv+1BbKmLdxk2emxlXrz2lQmJV5YI5I7O7V2qZhPXTLARp0UrG86nzux6aXD/5AHr+J+w6ZJ68zyZmcaCYnk8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ly9t7HEJbLrZLqXFWnIcLmEQbmdCtxY8ZwqFTFcfmU=;
 b=lE2lnS+FCm/agDENOqFXlpznxdJP3/s7CxOzgDX3mPc1lx2JGUAU3IrK7aN5BIQ2XYCePv44TAQe7KNY34+X6WKpfW9s/u9O91vKwDJgIV1la8vT4oHLTliMO3JDLKQGJ2uomOU2UtVVukcuodOxYJofImaQ2dCN0q4BHh1afMb7Ci9XztAKrdSotfoSAr9i+EZiPKXc9MIDSH/WeRLtJAKTH+pU/odmWUZhis/NspPE7S5A9XSbY9YdFtrcUDvX2K9IqgwtnU0Wjzf+iDepbCueZGIZHp/wrLoYZ0oonbSwka1dVdDarS0DQ6XnDjJxy5s0MkruXvELEquANM5R2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 24 Nov
 2026 09:20:41 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:20:41 +0000
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
	Yi Lai <yi1.lai@intel.com>
Subject: [PATCH v8 1/8] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Tue, 24 Nov 2026 11:20:32 +0200
Message-ID: <20261124-gpiolib-chip-removal-v8-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
References: <20261124-gpiolib-chip-removal-v8-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 2939b1b3-a453-445f-a38e-08df4a0c35c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|261022075727099003|261021123027099003|261102123227099003|11063799006|261026140227099003|261021121427099003|261028144727099003|56012099006|261022105027099003|10067099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8L+0/xLDaY4PHFyOraUSV8o8EjBSo9AoTmC7kdaXvcUc3lay7NmVe91OsfMXajhDIWLPD3J4hZMCUAy8wxc7KMnnogbKvRGzVUWNz9D23ZNEYDifInMHab3d+f5lQufEu0ERw1gXc/jgV7tFYksdPOjE3mGSEnLlclg/fBWUMRjJciSPiCPXT7v1iz3COUgkslJWnfN7ONVEnYBGg7ZbLcCQD8ihQyosBwfZixwAmDZV8ROP77f8LOL3orVY/Xczrd8Sr2qdewykDwZ39SotxgLHNNWCDFv/rnoppn8p+4Wvz3WyMZj8DzCAHFJWYxcb43xqtmG8nvNoFgF+yLlqSkVMeGb3/9SZYC7QVTCh45GtnSGvNl48+InSRxOje2xrt1tQy8ejAI8Tlm4Tl3mNmFfS0kWJXMT9LjjPbmRW+V3N0ahWVtcNbpqsby7ujmx81cVA6mCXoZSwSiqdGrokhp75BcxFDdUV6Ix5AWVTjOyi0D0owmQc28onV25X4LS4IvYtNHbWLzexvNaPnEXMb2M1Hv7H+6U6FwOtlE0OOEHWOFfdbxoImtD4H5scGZ6IJP0dkdhiyhMiLShiIMdip1gigetcE3yS682l00mdBWjodEI47kgk35O16qX+3mFP9+ZYiGKfJiWsrcJ8PQJ9A0JbT984C/uue5mi3ZkBrHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(261022075727099003)(261021123027099003)(261102123227099003)(11063799006)(261026140227099003)(261021121427099003)(261028144727099003)(56012099006)(261022105027099003)(10067099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oi57dueICyUDIqHXKmxoFG8+KVp+Z8QGqQeJG/hNJzVxeiA+qDSpK+RfHs8S?=
 =?us-ascii?Q?qBlgFdD7XZ4T1RL9BSGWz8Ill8P25Sr3WvyNLncXZUMcGcnsXhf4w9b6C2sV?=
 =?us-ascii?Q?KdtUe14ponPWGWE5DR7eY07KHvh98Z7B69TdCJFiTiPLz/8ywSq6SQmxmQux?=
 =?us-ascii?Q?uBuFqdMMfnemAfOdJPYrZRLtgYgjbwfZoiYzPAcONF1tBAZRZhK1v7Gzrl08?=
 =?us-ascii?Q?lRHprkGuT+VNQK8YQfZTmHfjljSH9UFdkuwtm4LEIoKbnHnVlnF5ZntCZzNg?=
 =?us-ascii?Q?VzN/3S/WJqGK1rPh4U1PQEJTanQG2n0D+emqniwkAAo85zBlUwXFuhb1HjwN?=
 =?us-ascii?Q?9jiqx2CpywV/wVWZfvF1VHkAMxQ08VpXL6doWhjIbWKxbfA1adQSTbk23vfl?=
 =?us-ascii?Q?JFryKr18WxFeUg6Lb38JYdFN5gX0BmsqSZy4AySbjY9rTTvVZPKjgFe5+Gt4?=
 =?us-ascii?Q?1sfMAAWc0SkReuEWs3C03U3nLrj6jtHoFU70Axe6T6l/TAWcE0Czgwhjtw62?=
 =?us-ascii?Q?vQ5abr0ScUmQRlznU1RkA9TNZWV1+hVvIhSztvLhJj5tzcqgiGouJCjrPnRI?=
 =?us-ascii?Q?YC+bEqbyhySNm35j02zzwLXGwuZEtjNvoLpPIhAKnJK4/8cDPtVRbvxbQcC2?=
 =?us-ascii?Q?pgmMyozyAnRKbVY2SXY+93C3goIlasjX3oSila3r7Nax2CO7WYxMFz86mLgj?=
 =?us-ascii?Q?PdZKBW6ozeJ2UYXVzrcZikS/CUPTadPf67kedt8CxmXDyFKTdzkyvL4bo1EW?=
 =?us-ascii?Q?CkGox+smjnCv16UhtY/KYYw4m936/vIXIIljzo/AOgfL9oes4NyfcKp33xRZ?=
 =?us-ascii?Q?irV6eK5uIWzk9KDVb8mRW/Wd3BzOXV30cVEaTi5M56jWYaQlhZ0xOD+/ancG?=
 =?us-ascii?Q?U4VoMOqG57U4S5ChGN2kw3/IbYM0OrY3dOtZTa9nhpxgeEOa6rfICKn/MOp9?=
 =?us-ascii?Q?HpY9364F0RNwg9ONlLhkzYUS/YKx4WtQQL6h1YnRztAmH6OyEQulqgv2gS96?=
 =?us-ascii?Q?+w0N3QU2gIRtf/qK0u4biOqRyT3c0pP44pcCP1MHZ5dO0H+JXUGWMsoVe6HX?=
 =?us-ascii?Q?hUA/vQGjH7xY5AdWEsSxCEioMpinuy7UhAjvwaB4VgiSbqCcY3uO0xjtyx91?=
 =?us-ascii?Q?uOe6UMgdxe5AnANeaBTuh9blir4yssbAw7b6VkOFqTbFeIiCf6M+y4ujjCz9?=
 =?us-ascii?Q?dqt72/UKtpTQvP5/zyv01IBAYbEQpiDWDYlu/pFp8gDqxqCfgEwYlErXSKLC?=
 =?us-ascii?Q?BFOpp3WRdaZy6dAz9cGzC7tG4eP+jO0R1KT8DZezkRB8g21TZlyXf2UU364i?=
 =?us-ascii?Q?WPBGVP6mz3M0DgXXwJeq4C0YNeDb9Sbnm5FG5qXueE+gXC07KFudvxyD4cNN?=
 =?us-ascii?Q?tWj/uidf99BJuH+J7fCp6KsMhiipvbgCBZsy+dCk/UI8EFN5LXA15OjcM1Cm?=
 =?us-ascii?Q?hN0ER6l9i3awiTqJ4+kKs0CWQaAOBV6CDM5GT0bPzSyY5OEsbsGg2sKXCpLK?=
 =?us-ascii?Q?FQWUqKGcTFPJUsV+7KDmSe0mzGPpK/GeDcDV8SDu8HdqokrkLbXRAA5SvL4Z?=
 =?us-ascii?Q?Vu4U1qXp+ijCLAYQT+hcMxjtfuVRMIzqu/vNNdKpHoSdWbtIvmgLIPtIhDVY?=
 =?us-ascii?Q?U6ufWSJ8L47203OctpC4oVhVTq3U53fsN4R5TuPtgGsUtgCPGQwNvLJGNRc4?=
 =?us-ascii?Q?gQ3tM/bShQW58jcEcrvsv2c+dW2lqBBrxb9767CNOqtJgTG7L9sbguM1e6WB?=
 =?us-ascii?Q?Oe2Zj3Zg9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2939b1b3-a453-445f-a38e-08df4a0c35c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:20:41.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVyQ23e5P3pO0ASmucF+MRdSvtsSvylvYrfI3CpU1dWd6IXfFifhx2oTQO8GTmfEQasRb8+mqc3/KEGwSHsz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

desc_set_label() frees the old label with call_srcu() on
gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
a label freed by gpiochip_free_hogs() can still be pending, and
cleanup_srcu_struct() warns:

  WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
  Call Trace:
   gpiodev_release
   device_release
   kobject_put
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

Use srcu_barrier(), which waits for them.

Reproduced with a hogged gpio-sim line, setting the chip live and back
on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
cycles; with this change, 1000 cycles pass.

Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
Cc: stable@vger.kernel.org
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 63cc4064bfa4..82e0be8864f4 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -898,7 +898,7 @@ static void gpiodev_release(struct device *dev)
 	struct gpio_device *gdev = to_gpio_device(dev);
 
 	/* Call pending kfree()s for descriptor labels. */
-	synchronize_srcu(&gdev->desc_srcu);
+	srcu_barrier(&gdev->desc_srcu);
 	cleanup_srcu_struct(&gdev->desc_srcu);
 
 	if (gdev->line_state_wq)
-- 
2.43.0

