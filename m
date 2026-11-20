Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795162447;
	b=WvXpsdGXS5xrpnFrW3iwSk35eMe/t0+g9APq8szkZURUI89+ka3MkhDu91f7Ywn2oelz
	 NkNufxJvye/RpMNyeu6kAwl9Tyj+KRoo+tQw5hN3rS2NAlT8k9GTfuboxmXddq9WpoRd/
	 hlOZgX/A+t36qMcenmlUNn9cAI5Trs0ZqYWNk1yVuqtja0csohqUAbCBrVcN953Figaql
	 uKu4zZLCBxvUCCBNtBeiuakbBfKWbnp2q/rBnSg5gLWwdvsD6AmIVnDeNBRShPN3L0Bpi
	 asicLqYwpSz37FdjBurt1u+CjqG2STWFB+0sX3xXhCgwWZMJM5juexCxHkJbTS17f+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162447;
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
	b=QL/qhCR8vNHqVAoOn2APaNo38hjSojI79IWAKAD23xnUvdAwOJaQ0IqpnAdAnCsV2oHl
	 TPuj5bnFhU6RDMsAzyCYUDixvtYleTsrtmshoN0jzLtSMDhWW6+TdKt7j4JlLGdZIKWz+
	 3fmhzUyDB+yAVDcZoLiVtw97IyEusWrq4Oww9FDQGrK6uwxFlOnjgTRQegfAzddjbD56M
	 pNz5+Nsc156DeN7v7WKSybh/F+hvIJWGrJcwO+eDA+rBIjoVq5dtQ/y8hO86atIcsJtK6
	 yPWiULQBqZz0+oEfb9LMyMoO6LmyACXwYynUBGbtuH1nPKtRK43SrI1+voWIdQ2dQPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oDGkFhHj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.23
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E360A2615;
	Fri, 20 Nov 2026 08:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 387E360A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oDGkFhHj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGYFzHnbKSFuc8DB10mMSpSrs+86ZA5pSeCrSo+b/ePHF1oi5wZs/ilmsftzMk9F9YF8d0hlgBLCf+tuUTSHuN6Rt/xUizPfZulegLtRoL++nUvHicPCXGYug3JfczxoYAEoQFMf4w7sjgLCVqRnSZL/iIS0R9jNTWD+e0AmviowBF5j+iEO6Cld0BEOFkmY5XRmulIXZCiQjDJFXkV6Il0pNJU1Dg9VOiuwrvE8lfPOx4o9b3GW1hv0N5aBDOYzHAVDTTyI5TN9bkBn1iAXptBByNlEufN9+CBFSejppwcTYjoZGEUSd+hsmp1MNHPqf9CRsO2A1PjPGdpV9fByrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ly9t7HEJbLrZLqXFWnIcLmEQbmdCtxY8ZwqFTFcfmU=;
 b=BTiP9Z4/d0ex2OGZMTsTbGrLE9XxOVhw7i6ocpOoO3gI0IkmUzGGyKj7z6U14LQmr0KvLD8gGbmz1AaisduwflPNURznYsfQCmn6Q1PPTdwy7tWa+CHiPrMM6g+Zixo7OretGjCzN2et6J51S8twUftT5r7+zE0PICOUvDOdZ7009cT2BxaCiETxVZ37oM3DnuLv8upD1wlm5d36Y9woBNf0jKf701sW4jdvYuCNWItCWDbrBoyvgQ3T4FjnqY66vdAn0Fw6SjrrC6mb79kV39HdKKWtixveUdQa9L1EYUjz1prYS7Bxt9GhF9cQeMuft7c1XS3sQDPHK1NwR+ksRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ly9t7HEJbLrZLqXFWnIcLmEQbmdCtxY8ZwqFTFcfmU=;
 b=oDGkFhHjoCDxkJO5bFVdG64LL4HyRSqxXpIgRfg30+kOJ6Dqx52wzL8yVQyoc+d6URfBrVLPkJPByoANln8Mr3gOdGiyMNYWLcqDVsYo7ReYl6EM82d2ga3A7jeT+hsRvliPanvxy+wgKRKpCIk8YoGSg6iLKmvGXHjuKVj4/EW5hMR3kR+dPzZYRphf04G8p04zNP8fvCg4qzdwPicKAm34YNodMX1ifErT8ApZ60U99BlASEKbBYawhxjtBmb7ashzkiAzEXTFYvx+wtAC+1tg6IHOjLRu/7SI0lYtyYGHqBFBYG069mQ6JJBGQYxw4g5I4ue9VYk1zZrEPtl/LQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH7PR12MB7818.namprd12.prod.outlook.com (2603:10b6:510:269::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 08:14:03 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 08:14:03 +0000
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
Subject: [PATCH v7 1/8] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Fri, 20 Nov 2026 10:13:53 +0200
Message-ID: <20261120-gpiolib-chip-removal-v7-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
References: <20261120-gpiolib-chip-removal-v7-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d61ae9ff-424f-45ff-b6b0-08df46de3d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261022075727099003|11063799006|261026140227099003|261021123027099003|261009223027099003|261021121427099003|261102123227099003|10067099003|261022105027099003|56012099006|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k0E6z7CRzF3TSOH6NshZOwvvucYmG0XLV6QOfN51BdakmcR8WP/UDRfjqHWsPThtD09qTj2/ckjdr6cNJu2cNMMczJq6wfflIeTVFWewxzbvIH4b8lXYZzdYOfIYDzFT/lrBTSr14F7Onu67FtlYIP+PEkr7tUoFkB8pu2CXJYW8AXz5hZb4AzNlrCHy9Vr4cYVRZk/6qC8R6PVDAyUMon2N7fQB6m5GyXZsCJh+fML88PuIx8Vs+lIC9kccMENF6lTjK56kynV27z2AiFAzk3stVP0+XrL7PqkcIuuokRbRi5oC83n/cL4Z4r2MYngB1tL4B+RKRRCvtOhtVxIIadV1RD0v0HEt4IYSjqaQ66E/52+J+RAkZt/3eUelpidk8+OghnvrWU9w3Ls1Dmne2KqBrpf5tW4wEpSzNMKBL8LuyNUrKc9h/odz8GCE3ldtoZuz74q7kSFKnRc5OZjGvhcnsV6v5LaPSlMARQ30clxzxmpr/gIS2vEm6SaDugAdrhO0LB3ECS4Be3rgHKvQ3cCsQ2yi00grD4SZpC48jtHB7r4m8ZPe/wsTEZlwgBN73mewpZZTmVSOBOG2cKAFc0wlYze0+/lQRrsYvp0eo9mAXk0DqHsPMlXs43fPMkTH6bGv1m/W3Q9GjcR1yj3H/5+e6zHTObB2bqmDNaMFMXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261022075727099003)(11063799006)(261026140227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(10067099003)(261022105027099003)(56012099006)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1TK0Xy6BGgDgVD2AsNK/8w1Cw+3sdTs5o/Ndcdr1HP8WEhUadGipjRpcAdg?=
 =?us-ascii?Q?uxTG3wxME4P6LHxurfBakqjUZFtK6ZqysH6YDlIPX4dPzHn4k7PQ/q7SUpcI?=
 =?us-ascii?Q?qZvP+XKw09KZDivNKvVhHn6eN4I0kMdQuq8eo47ACyVRrj6SKr7ycIlyqpmN?=
 =?us-ascii?Q?Be8/XZShEfIYI4Nz/CW/Ru1sJcS0Gw4xU19yj6lfrxt8RPvbMLQWxG0Cq+ro?=
 =?us-ascii?Q?18j0H2u03h3ajv8oafq2vQucbZibUV84XJE+fc57jlIjDEgxPs6N3vHRDXHT?=
 =?us-ascii?Q?bm7nmK/5v0/mTHJKEOXZSL+e7UxDtldWoDQrsTgzq0RCsJD52b2O0IStz+Dm?=
 =?us-ascii?Q?gJp+OoWjSGNdqLBTXDWleaWXFlQxFUtEf0wjwgS48bXOKI9IVaQQlLUWkHmu?=
 =?us-ascii?Q?CpS8xCzB50xqQ90GnFOMDODJgXoahO4HFxU7Uhel4i4Gh0m6TLojwb3xKoYa?=
 =?us-ascii?Q?pOePBPKT/nhaQWB2EVHwAP0b0e9RNfMF02h9MHn4iR5RjAMxKV5MlF97ps4K?=
 =?us-ascii?Q?LsVSGjQAulv4fo/RqErQOb2WCetJL8LJghsv8T1qZuULV6xwxqp31+7+9grI?=
 =?us-ascii?Q?G4VU52NPUNgnEa62KNYp5RD4ia3wIkKytFNju9qEcK68wJ2IUKWqMqsRzyGd?=
 =?us-ascii?Q?MyqoJi6dABz07IyChQe0LZnJR0mRegbir1DT+dUJBdCC0wrNSuqmt6oAOXLP?=
 =?us-ascii?Q?iEtX64/qAqgvBAvBi5FijSnLMyfZl+JLwd5DdcWOng0sV94fzANhqJmwraHt?=
 =?us-ascii?Q?lDxiNsvSZuDm5UYbT9crcDWslovMcQJVaxlr/WNPqkp0rt3Vfc03eZn8WHZD?=
 =?us-ascii?Q?h2tmiwsIf6tBqFFLtsilQSrpsbO9WV+xhqiJRjC7DiFFrhoWFxSq7SuxwwUG?=
 =?us-ascii?Q?hAqcyaNGkPF/CflqL7f/ltchca8nfBkEv37pCzSobPkd8XGzsjGBGBQgPD5L?=
 =?us-ascii?Q?yE5a7BW2ygWSyqqzdZ+XcVGqmGaSSEh1qNbUbsX4e24RHQEV1odmgBwldir/?=
 =?us-ascii?Q?d8rqANtMBfuGJRoTtP0LwbTojp5gItPRYfiK5TAB5biirdmQ82+6GYvyk8ih?=
 =?us-ascii?Q?MxIsg2JHTyWiQZY1KHVQNxOKar2zbNmQ7ZM7HNcyiLoN6LMJ4X/vC8Whwevv?=
 =?us-ascii?Q?IinhFvJt2owBn0RF0CT6BWgPwTjL11lMfE76V3PegPuYz6c1TpspxFXuRX12?=
 =?us-ascii?Q?F3jWCxPmwigg91Hc1aOZeNvXGS2+BQsjcvQoz1589bQNQAplElmZ4uSEO0dx?=
 =?us-ascii?Q?3SFY0A3LntLkmj6+vRV0tS/kvGZKj3AvMWZyo4RI0/VsYLskvbXY4cHkKZNd?=
 =?us-ascii?Q?JUblcOvX2dWJTRhpqUNlGmwU1zOTMJBQecSL7eCJ56w+iDJvP4kbMRcLHPfv?=
 =?us-ascii?Q?QrCZWcUsj4zXQAWUOHg8pzNa0jN/092hBRba9LakuVG/SRbaTZAQS801gXmn?=
 =?us-ascii?Q?pSu/wsfhesgqD0i1Yi1VtWvNJcJP/4df1OVbwHQoO9SiDH2pO5KI77sOF2oI?=
 =?us-ascii?Q?bvG6xhkcGvykYtU5FZ5DkXPQaDhnC7X0GkQlu1HiPDFtX5Ywt2KmILf/QbC8?=
 =?us-ascii?Q?oe/JVeAOaJ6mD9jY6QDcl2gkR2kmJzs1eTaw/mVkeGdEnfEXOOnG2/t/3mQr?=
 =?us-ascii?Q?r9wDeB3ZoEvfQ0Ya6ZdxnsiAEAecR6/NeqL7868y5iHEJhlOOznA83kEa0Nb?=
 =?us-ascii?Q?Gkd0W+3jPp/c8YDZJ76r9WbHrSooF8cUZB4OjNz7I8RdR9BwaxN5HAdRhEg0?=
 =?us-ascii?Q?cr3TLjFduA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ae9ff-424f-45ff-b6b0-08df46de3d3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:14:03.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fWgk+Ina8rwPnGJWSCgsxlMx4nsiDd47ZjayUWdJ7uauqbuByBRGLEUJkmTs+c/iLXNs0NB7VNKVPZltYbZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7818

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

