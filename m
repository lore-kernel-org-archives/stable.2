Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794836840;
	b=qtgGPSgK4ZrAcGh6bKJXLilpoHNU3wkB03HzigXsWp4C4tsD8YOvaqnJZ8OTEjdew6T6
	 C0Nk4ZOTOw04m165mqKEZgg+1OIUvXRhBvTEcyLEHsKfhof315XHCZvK32yeTAJNex+N3
	 u+/9Gmt7JA8Xgpv3PRNpSYbsrUfVysT8TBvWzr65otmNYQIiW2aTJBTWkoKtXnYzsafT9
	 gnfRJSKZZylwxE1V1+3gSWAIZqcG7eWyEl4v5GfTRYA2bnFODUJNytDpUoWTzuJrAALy0
	 Ubs1UcvaX+VpKvxO9HuEerQ8BTDmCdZVf0LpeG6s7N3r2me1VHyJgwmKqxt924pcyJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836840;
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
	bh=v9pzhHY5Wz1BeZvPTYJGqBoY8YRLtkBJfTir0DoX2jc=;
	b=2A4MvFeXew1yy8iAp+9HGhKfGwOqmlH8GIUcaCnOTSJWS2QRXC0zQ/deZAyCxkC4Y2L3
	 A/eGIk8RfkZd8tgKA8P2GfDqy3nY6OJsIryEIyR7QmJofudFaJqyTJoPygB2TIvVU/Jgq
	 9C0Eoj7qeYmjwrz4DK7afBcpzr5nVNILCHvYfktKJvoCzTVcn/VscP9FTVtH4+O04sJkM
	 NDvzc5kGI7rznFjfMeJrAZqJJ0g3guE79t0NOaNsNZ/NXrVkizFcoeeC+G2hJBe9OtF1I
	 nLJgpTwOD7y0EZZ5UuduiCL7YhzEYAINUgeExReWLHmjiPFvmttzYwsKP6QsdKRofCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o+41Te2o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.61
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788B606A897;
	Mon, 16 Nov 2026 13:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D788B606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o+41Te2o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sostL1obGmpv0E4rLe90ZqAgEDnBuY+d+s/IBo5daCAn5fZcZLzeqNFgFIOP3JaxysnjwkP/zXUbZuIEBSdPfDk6S+sFsWAKdKQaoT8jnQcHT+j4TTqyiteKW4zsisVaHonsohY+K/yFAz0YUgBoULZrVw60wxsZEJG/OWu0ZaIqs6GQFBLBXEuxrR7jI++m6BueSDZWbQeMb4OcbBnhASMFsZYUsjqbjfpSoqZuLEvy3RFG+oM57XeZG6TdqpziZJNK9eqeJ472iDwHc4Q87UWizccX9XPPMWVJ1aIG73j7M7cqHphGhZl3j35VbF29rwyu0TfqEpGjyXwxSyLyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9pzhHY5Wz1BeZvPTYJGqBoY8YRLtkBJfTir0DoX2jc=;
 b=JUWvkCDp4RxWQATb0CB9tFqvkF1xqMIGzda+wIoyraQCnA04YFfQdE4IzXw+iW68PZVB1KYoLXhhUwZwlctzlLDsMGB+kSaugHaA5pcqTqKWEsT+dN7/mDbMUupbprP6R3iJBG56Rft99PJak9wKCvXrOTvyPY7+Q/hvAL5AjRseX/0vIIYZu4v47vnDbJcHNPsy/+KENkPQKdRy7vnpG3Xk2GxzjCsbdWGOqx+Ny9Ob2S6BTEamOYVbxAygqXAWEHY44MlfgisouCnRU4jj1p6LjdnC28FjOhz6mglfnsQEy5hiv+B0gWdA+wCfqnYxZGnTaCd3M4CfltFW4J+twQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9pzhHY5Wz1BeZvPTYJGqBoY8YRLtkBJfTir0DoX2jc=;
 b=o+41Te2oYObaSToImkdBZyae81aNeCB/rn4utQ6e8nsBG6mnPpL477ShvZuB8Iql9Ky6xOfB+0GpsBlwlyw6XPfm+LkKb741YurA+jRZDX+r0doq3dK2ZSSG31/l6y7SFAWrfdbHH5tEj/aBQqvk7/QsqxrqkgplEoWrFsmmAng6tEAgaj8+lSQ3FeVvnsOyurV1wgjUf12tFrdcnPA66TtvCcqn//je6rjOPzzMou1kaitVx0xHkQramOf49KySmoEcP+Mt97V9KL6Lep6PQixHjCgKDTJ/XGeKUFOKx9C5MlXjZHPbmSvGr8vRbTPX3UBauY7mokdSH0AZQzknEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:47:14 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 13:47:14 +0000
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
Subject: [PATCH v6 1/8] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Mon, 16 Nov 2026 15:47:04 +0200
Message-ID: <20261116-gpiolib-chip-removal-v6-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d21b6d2-969c-4e51-2345-08df43e81eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LP6JZ6sMR7OixHlYX3BnT46ASgvON8EJxAjArFWKJHWW3f+6ISaMxCA9XeQBslmih1NAWbTHwtcAWZt6q4FtNnSB1JngYV4fnA1RdjPmHqD+aR3YVkvmBsZJuUXx278QzFF2ml4ymJklHr7Dp+dYnpjHtTq6fyx2I7IZu5YQ6VoplPIjcV5yLSl+Bgm6KN/JIKqW2lILBL+dpSCkEnoVQBfZt0pcIjk0OseI3Rk4eoe6HPfo54tofOwPPspabOSqdoQn3FD1eiVUXEUWfI8q813Fhmkh5+kL8paODVFmT2yemJimdIOmToWBUesaWDLq8pxyBUkYAjUkhRpcAo4wS992mRl9pcgQB8MTs4cxie7l7rK4XsaNuUCqThM5KJ9dMl3kUeydtqPHXm6W71YP2ouhF56s2lgOydiVjJuxaLvwYgPZLIcefG0xC6vjRVyC+LaHx+4xjenBir/2FSh4fEkMogl9Dx/UgRvhqEf8ir6RqYKBEI7tMfwtJ2f47PAGL/29zxxX7EluwI5P84YucBAkLJaytwjEO73ZhbRm1R+HqtDtbZ2X/giC3JNhzOFYn8NVAs6itA56rQFRSUA1Vnu1rODceNrKsCEDw2mtUczlpKu2MGRprLBSnlWWPnj2DbKOppQO1H6DGq8ukJbmRPg30pq7P6Uss1yKl8ZWpxY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qsxA+l7LzBDBl170tziCOHzprWl6IUFUXqpFkpe5igjSWnKptIxdd2+GJ/gh?=
 =?us-ascii?Q?2NqKOk1u99uaaHf5hsuGJgA1Fq1sBn2HTV9ADAyq7eJVN2aJN4DkwFnLFOOh?=
 =?us-ascii?Q?onJPaD69+2lRMtn22bfxLcNH9I5+2gWUSvt4edlHlbD3w6Ubu9NpucOtYRkK?=
 =?us-ascii?Q?ofk1Ah04KtfKqAXDOL74HEVtKZ9M9JJef83SLhBhweTFd1Q0np5wCr12JT5T?=
 =?us-ascii?Q?PaiECrJdv/mMsqk3LBfGK3d+3+NeJbOrEyWrwfX8pYIUwAT5HB1KA53WQUxg?=
 =?us-ascii?Q?BxDtmcD+VRDqmaC1YKKIjMCJrE8fBONeTf1Jod4YNRWVCfyG/J57NPCSFU6X?=
 =?us-ascii?Q?ccBa/mUMZkkG9u7x8J9SOO6RwalPjbbr3cZbLcw0TYTSul5tihp3YuAct/wN?=
 =?us-ascii?Q?7HGeSmu0dcRQGgIx3LlqhM+G31GDZDcOaTKhiPHg7LZ3VcYCANRtIbHLMYmz?=
 =?us-ascii?Q?BhwGfWt2WTNDu8IL0YUw6m8Db/p6bUUF8hSVoEfSVt6y1HquR6SfKLexddTc?=
 =?us-ascii?Q?14bZtlJ8wBqQcCubXggO2B35inMtvYY7S8BcFW6pbZBBYG84iekunEtn/+q5?=
 =?us-ascii?Q?j9AShlZopovq9RFuYl2ZEeSz2pLRBtMs+4etTbSqnF5FrPtZkhO1OnXCCZCI?=
 =?us-ascii?Q?hpDPHJ6sD4g60arLx32FnnqLrU2Jy04PtleE47RYwCxegKEdCWyYg58zuBGd?=
 =?us-ascii?Q?p2wO8MTkwBoL4YnnmvSPW30/TV9tL1c5yKq8ytNuc2nUD8ahZtQu+bCrYbas?=
 =?us-ascii?Q?tjsDaa5rHgKK7aZ/y2mNPcc2Yxc+k6U7EI9AhFS7O6S04TrC8nx7P3US96I7?=
 =?us-ascii?Q?WsOGWNImovStyEs2xKHmyXK1efeT4PyAJqgFg+F59F/ycQiPsZeG72mEV5ve?=
 =?us-ascii?Q?0JLWENkd6hqkXHU6lm0jIUIshtc95qwqhM2WZNQw2Ks9QDXuE5kqAwvNHUSV?=
 =?us-ascii?Q?HrLRAO4JjmkpGUAniBF385aAvlUKOzBzWHisQhH0SHnrfAMINumYkGtL/xeb?=
 =?us-ascii?Q?sTzte0lkSafxdPgjJCo3wIbaMqmXNhHoZ/hWOUAAJMirVckLXww+CysZmlpE?=
 =?us-ascii?Q?pXGrCcJVq/JMoFSiYxv597jechbeb+VjC9S9bse1eR2DUszZnrJBROEJdE2p?=
 =?us-ascii?Q?pwBCNYe64cRb1QeWL0hU6M4blbSkahl94ZCq8N0d+bzVSwnHKrwLK4/HVfwT?=
 =?us-ascii?Q?daip67+sPRbzcXPrrjSbGralMUKlpQ57Sf/SWtyRvJKkEqv5Eh1aa4hlfynN?=
 =?us-ascii?Q?ZyDtshMF8w7/xUsG2OaVLT1IuEunTfKfd3yOfQBZz27U17ry2eWDzPv9E27Y?=
 =?us-ascii?Q?X8pEF/bWm7wdRxa9Z2TPGPftSK5nA+Z2zY6dyZYGEEHqUdKWf/oQuLTvWrMf?=
 =?us-ascii?Q?WFOLLaSjjojOCV28cvRWQUXMvCJMe9WSUM41GJeTkZoolEOJ2FUPli7pfXoP?=
 =?us-ascii?Q?mXFtV/vJVtAHb9I8fHwOkzggb/an4Dhqkk/jhJa0pg9Dn6uweR+/gITWZ1ny?=
 =?us-ascii?Q?zuvUhF66W0AquNcX3a9t6Xzm8qVD0IU2XntUukPFe7MIFKnbIddzV57ftRrf?=
 =?us-ascii?Q?5VbNYhGtodmykXGq5rUua1UXgdrMaqIOhftgILH5HEMV1Kb4qvpeNz5mdzx0?=
 =?us-ascii?Q?QIH1/vZS3VEU7U28gUEeTMTkOEEbXOLX2CK4LVaG7/FapRFdWt0ujOHL4ywB?=
 =?us-ascii?Q?zOeENtS75ZphZLtNIi0VSiCnvR2ImqG9YqqxwhnwxdiInK9Hheu+/9nRyUA3?=
 =?us-ascii?Q?jZDThEGaxA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d21b6d2-969c-4e51-2345-08df43e81eda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:47:14.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lm87Wj60HjTE7RkhsF+KNioA1AcvM8tqEDXpJb0+pTa5NsVuh1+JQvFO4pgoOc6DHcNUC+bgWozXkdr49Qclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033

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
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6f8f30b767ef..ce04277a8900 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -897,7 +897,7 @@ static void gpiodev_release(struct device *dev)
 	struct gpio_device *gdev = to_gpio_device(dev);
 
 	/* Call pending kfree()s for descriptor labels. */
-	synchronize_srcu(&gdev->desc_srcu);
+	srcu_barrier(&gdev->desc_srcu);
 	cleanup_srcu_struct(&gdev->desc_srcu);
 
 	ida_free(&gpio_ida, gdev->id);
-- 
2.43.0

