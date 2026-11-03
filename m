Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701965;
	b=TnFKkg0h2iCEaqotDANBksW3Sl5WWCWtoUjnvBMAd1u3uV2VkVPUVxLG79cvXBY4OI7X
	 C5Vq16YEKr7nqoJ/HFk0gFyjicsxFk+WV70mVL4jxJiH65qhHPm8moSr/99F+G/ev5NQh
	 hfOmg29Bb5VhUuWLiomw7D5jL+AQ78kxEoA82GjXtz2Dgox1HLIdh6GpZ/wKW/cq1Ivga
	 HmBzcK7rj7SAKPvTyKYvrCuD9G1WVhQcYk56ymOTQoqVNKbi9jtVlr5D0phkURtnGLeSa
	 fbgFFQ3W4LyROCbitpmYWZ7dnSduMnn2UF0rvOgn80kSkaudWTrCoP1temfN3btYh7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701965;
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
	bh=8fLduqJrTD9tZgYkQYs2NsO6+UjYzfgW0/qGBGc5tIo=;
	b=NchIH6SBy1QVaNZaBDllKIilQcSGvEKmW/CZang9gZbtJ31XFCt01PETvT330peDzkyv
	 f6X8MOd8nBoXWvwKtdNDoLjQjp/8qRQmfh1MoSu1Z6tgkYVkqHDT236Ep/TqTIbEi2+kB
	 65fTkUtQPkf/zQ0bviw8ZR5fuaAeDX7x8ntcuQs2aLXfdrgSnQwYTzHR8r9bFQcVAHEId
	 GM2nSx4N8GGEiFr2QwdQoVz2IwhrbaAGmV7Kai1uUJlIAtR+d+KHI4STN0VOQidh/RByv
	 yCf+TsUwE9bOIdr/aC1mTRYy/jxdlH0/AIcqPicTpycBbY66Kdc4coHrdAvGc8gnaXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q9N9UkJo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.7
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353A606BA68;
	Tue,  3 Nov 2026 10:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2353A606BA68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q9N9UkJo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GALX0hXms9JPINx6qbEbsArPIclouQreE/vuGBPkmDynSIEg6dkI5UEHhk2cwTkfaXOr0ox0DdBrigImedXzsDYx5RcF17vJQFNi9i+8jSr7Ogm6RmfZcNAKzNn8921qn+va8L4hklAKnOIOqFdjdEfVbyqH2hkBe1AHgXDUunY7w2LDRrQuk4DXoHdD8Af9ai1faVN+79M91VxzHxuXSP2knaJwKNcQ/jBPI8BGXbz8vvC5Z8yXS81lJoCvOu6Y/XOzVuMciRnEGBG3HM8IGvRivYVH4sdLQwVcHTQou1fbpQFJ8XSv7ONHI6vAuVobd+Ks0sCZY94d5pelTlMr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fLduqJrTD9tZgYkQYs2NsO6+UjYzfgW0/qGBGc5tIo=;
 b=Ik77cTtT5MYyW6ZrGSwWPA7XFpHb3CvCs6B6rksUIGnhT1UpDT+Z+wf+ekC6oLs2HDoFRjPyj1FkUJZOBfs1RPOszhwT1ZFyMB7GL2Zl1zRuZIH1/hwfz3q9ikjJSDfwW26OXf4Z9/g9vFdrZO/6Dz81ga/keIoGSr9AWJWllzDSXUQeGbwDpj8s4qWw2/iGeg1s9UoywETsqUs3VZVIrNW4ZzZ6kk3f25X5rwvgaINNYK82okucHGR/Y4n9lnZy2t5IMMElIT+kWyYUPHxZSCc+Emo4Wb9rpWfMppzaayiH4QCGIuXL+71G45oNItP0vRX+qv2cNfzRcjZtEG6CGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fLduqJrTD9tZgYkQYs2NsO6+UjYzfgW0/qGBGc5tIo=;
 b=q9N9UkJo1/MK966uZ73NHauvHkyzm72NROV/qa1Jqr40Yjyp9JEb3XZPl8x5iGgKkfgA0CTrqziWXuxQGseTRlhpyCvV+XRp3cA2xohqN1ylveLLceK2RreyUljaAnhorxvUXsOyFfcQ9C8WbkNuRefxK+ZgysvbyDGK2dJcqC5DwGBFkVHS7LVNpnEi4LmG3Ol+8j/eUMTG6JkBBJEPZrFT0XofyvHFpPM/WBPs7HiZz0DU/Qc6PJzPVBMKIp0MkObb7SLlNrWF8Qnddfz6t9puLRrtlGvxf+JVmsB3FJHmzuU3jaV9DWWNztLnjLNhHiyDaH9M20mmMr8IC4x3Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:32:42 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:32:42 +0000
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
Subject: [PATCH v5 1/7] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Tue,  3 Nov 2026 12:32:34 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0035.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::22) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1ea988-2041-48ce-edd1-08df3995ca65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	xQgjV4y2ANG7g/3K6+9CcrSDBCd+Tuq5zI9wYNbBdOgUq8N4CloCz4aapG0DtNIDoJiVzGmqhkBrlBr+YNZBwdTZbjP/T/LGdhbWEv84U+ztGn7RguCyv6Ekz5q3Kx0iDbPnrGpjhJxKMAPeDR4rJLKvY4JIpPnUawUSaVXd/qeOpAtPdc207lhByP+yLgX5ymPIXpzeb4qcKw30RQTCN6Z2hcZx4aruZECVO+7XqTMzLS6wxwaI7eDd92qheFfeHI+HNKKi58qeMrQwc39RO+j6XDWuJca0ZpOZjfMIX7mB2K5Ih/aq6qBNitoNoFTMdbfU/bw7tz2nUZ3xj2lTG6qFsJz9L3IWyZv/WEE2rAnMBZIIS9tC6YJzyPCX64IzsK8EB3ANR3i/S7XO94NioGOwm/X5ffQRJh+cPDSKTB4/B51B2enNKdSOzhtB8e9FhkvuHIZzVXkj0wEGL0qtV5SAaxMVr25liIR8V6oMzmtK2J9cyY9F4KaIQGI/b4WpksXqMjCq5mXZADBf03favEfusxUHgEsEFkRZZ3rDoVhE20L6AQRPVlpfMcRx3pjx/Ybd7QW3SS83S7K8UqXmymbq3sVlaY4ONGldcVCO4PYWqDYMonFQG6WnpC0Xzs3nDvF6nsVrLUQ+4+iFZEORqTogeu3Go6MXR38QAj4PzEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HmzaWoDW7a79306mcMWGbRYMYjrbWw0KFhmkE9N2LE4WNyu/cS/+Jr3TELMY?=
 =?us-ascii?Q?oU897g2Loc+bfb8QOjxDcm3JJ+noiVzTrlojKNETO6POhVq412mf5Rz5SKJy?=
 =?us-ascii?Q?PdfQeD02UbyaY0wd41ng+d+oWKUlf5m84sQ7A5UTGQAs5Jtaq6Ezhx8LLe9s?=
 =?us-ascii?Q?lVZabpOrlDZTdJN0bEfm8e+US2qqZX+Odat5XAisreWEsmU2u3bhtITuYnMT?=
 =?us-ascii?Q?pBwUmR8LRQ0SLtjH6McIV6qc32HZ86qixEWhwhFCjUw1EFVQw6jQ82Yhux3B?=
 =?us-ascii?Q?NUqSUUlo78WAUj2MqRoMoyL/tjOCAMLydnQT4bE0IQ2SeNseUih+3SrRZxq+?=
 =?us-ascii?Q?d8hEIrfd1B9EmEb1LQ1CiWlpjph9lkXlVSkYad+FcDv3HKxKH4m6WuJBlyo2?=
 =?us-ascii?Q?tjBMH06jp2N2scFFh/mSPlzHd1eWTD3Tlo9HyI3Vu6mWrZGTwzY/Y5YnGblc?=
 =?us-ascii?Q?iu4sVUh8ZHz4/mN/dxLkta0lrQFMdHsJa65D1fvIZJ6aFjrSTthfsUES81dq?=
 =?us-ascii?Q?j7wZjK/Ekq6w35l0y0ZH9K0bgvDEZ7TQPo8ns4XvHKS062uwOQV1Qgoux38s?=
 =?us-ascii?Q?4yG9e2kXCXQe8IHTJJHIE5te+DdxOrJLTk4AVEFp61UHBZKZXZU42wlpvsna?=
 =?us-ascii?Q?itSXy0RyaMEKHSERV+AQfZ5ir4DEzzy/6aahPmrhtBcRQePqJhuQ2ZPsYSH1?=
 =?us-ascii?Q?oqon5bi6GVJ3US/PK6Ow5rMBnc2xOt8Hx9x/ZUSAus704jK8/1hLEHPImJaO?=
 =?us-ascii?Q?//1lqjXFSS3HdbC7V8uucApMiZnHTjq9u7VCjGyY7G/2a3jZg+mX6Y5GVXOn?=
 =?us-ascii?Q?AEYeJuMZqgWW81ziKq9r3/lLo9o3sreMSAUnvNKMbDNZUm1VHyQcR51Tbjxq?=
 =?us-ascii?Q?7PQBCR+5j5EAHQwgr7EaOyTLsgbyZCgSRpj2DuAkGQ8bu58+7KbY/wCONOik?=
 =?us-ascii?Q?g7qDpguOzoQKD5zpsVyXRWH/km8qhwtlKHTKKDLWrrVV5qS7YapAsqGK4O/3?=
 =?us-ascii?Q?h5adbkiRLOsPqa7Obmol8pdMDMdKIJvBINExP+lMOrHn/FwEVRS8lS1KRSDF?=
 =?us-ascii?Q?7mqqcRZJh6R+ODhwuZ7/vJESGXwYqGNSFw+LJ3+QlSWlpWaeWUhg2uKo0YI+?=
 =?us-ascii?Q?yxH1HtJe4Kbw74H7xJpdseagnFXjW42lVn5woVhMY8Ddu+6idE5/+RleSFJ0?=
 =?us-ascii?Q?hNyc/AILqWH0tH1uwQ/18ZBY2fTS5kSJyhIzOwLJgpku55LrEwiMdzT+3Z64?=
 =?us-ascii?Q?X0YD+v7KoFZ/Hxy3eAvMKsuhFFd//F4elVJO7wsUN7brjOUFexx8VyANXqdZ?=
 =?us-ascii?Q?L/GQbr3A8GqJv+EokQHJorq2DlEhWB/UNY8+we557bkof4IBVnREv+05Mhvf?=
 =?us-ascii?Q?egbmNMzcysckR8u+XthE5n455P1Z0Vo+GtHu4O+tpdoS1ulo7NKzDCjno5iS?=
 =?us-ascii?Q?ZonYbd4NCRMchwiqNFyk/6hzEJ2NpX702O4dt38GQyqDxNaJAVH0WdwOphxn?=
 =?us-ascii?Q?/Ni/bwowJ7CEI04CEAkzA0VUNK90bQ0cy4RYrDoDYAh1+61k++WPIXwqV9Cx?=
 =?us-ascii?Q?Styam0wMsDY9o7ODWgdiy1OWGpCX7WRMRhxumTSBWbklwD7mwIHB+YypY936?=
 =?us-ascii?Q?VVnu0VLk7hfmMI3Q2/fITAFhu3zrNVWCg0rYTjGbuu29AfSERzR4E3wwb9sg?=
 =?us-ascii?Q?8uRie/KsTB2KqzlR+PDKv7SW7tdMbaEUSDEzwk7BjYEGJunchvLZNswYGuB9?=
 =?us-ascii?Q?KrvokFjI1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1ea988-2041-48ce-edd1-08df3995ca65
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:32:42.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MamtWpphp00DPUa+AJPL2lrxZb2cKU67mg1s7p4Zl1+E1OZ11xT1QMr5DXtu5Es1mkNm/3Z/JEd+AUZwl41Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

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
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fbdeda2f2787..0439e016f246 100644
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

