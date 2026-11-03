Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793701977;
	b=O6SJMkX4gBsNsiGtiwtnvK22eDFa4gvsDqdEQ7bYNseCAeq3wurW2VyujEX0CbwNzB/d
	 O470J0DalUkIkmsZH8ifdNQ7HCftg3wF7YMhS0NG+uyquhReTXWYhqCFl5DUwss62eaCA
	 NAQD2n0KK8/z7dj/NUpkE17//pOo3btDVrGhClCG/zBP0eXTbh43ln04tzqz1sW6z/WNA
	 PwuVcnjlbtsW15rW5Y2BldbCQvOct6FzwgOsXbyLLYvNNBg/4ycRFW+CrlLxmpcVNbLyo
	 jMsDtOWUkxfhnbCmtD9/8Rqo7+qO5mbeAD41z1EyCjd8hxkvsiByoXUH7bteU7/3FNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701977;
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
	bh=9YJHz15+WOnM/m2JRb8o/Arw20bnwjFEm/moTBDXQtI=;
	b=0E5L3JBLnfl5kq2HiQXkBf6XvJxcaOaZoo1qOSJHp8ZnpjlDiEOAnRfW5KSfW3I01Bqr
	 zwnuLud8UwfIduDwfJK4ftXB3HjYojSFZQGSN2oErUoc6Rbci8aRYODTKF+Sftr/k+KiN
	 cTLEMZlI+Yfw6gGUer7zfqesoi3e3Nx2d4Qb4PH21iOiiHxS5uY58dP9zjuRvMQj39rrf
	 cR7wRxzp7WuSpgRKHaZFSQlT4Gw46fTPwJ12O4Gr/lfg6i3geHR8VwqOEhOlxPqFny0nM
	 +IvEFOWxgrO8EqI5G0dxxwqYVRVBVS1ZMRo2Ce6XS91q72vyi8bKEQqobKu3QZmXIYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MYAHmJVn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E34606BA78;
	Tue,  3 Nov 2026 10:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E34606BA78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MYAHmJVn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuWWUtnFqsJnyPsZRfYTIJ8WBMho36E5dEf+nGfHLWadB5/0u1tYB/J/Y1fhdH+u3p4JFcKqOfmL8YRLRLZRBMSg83y3UYQKuVeMjXs/if+xLDqqLmhFzf6ttRQ8bXA3a/eUJoUOEpEZ/G5fJbMZUgBsZsNxNDma1pog4Qo4Yd93G3MTzhT2vmdupMZX42X8ZgklgqEW3bsHMPuoylT7Sn3tUCrs3JZsxqbieeAAc8Pjjo8OJ3mxtMY8w6Xkfy3uMmuJQkqofqG5IIhXOt9Un58NcK3j8NG4NY+JS8jE7VFkYSLdK0z3QWrUhJbYNocaNfQX5JSoqVH70wixt35X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YJHz15+WOnM/m2JRb8o/Arw20bnwjFEm/moTBDXQtI=;
 b=DJ+gUPCs1lLtfzel7z2nBR91QemHPiJnK/nRW9xEUy2QFwC0M12GImcs+Ch173zkaUJnZBSSd5vIz3oOMV2Pk2NO7dgxmDvnOjsJNxXSQB4N0IqN1tYtlfJB2693ZIZToOoYafkM9ClXt8dbeG7RlyIFKR2bOzviS6JMtKeAUtaJeyZF4w3wZEuEVeoJzW0nZ9gcwcDPdjHTS7nPgNnn1meZVadGq9dC01Fq0MlHTQsAic+ETdtf58WIslS5PPnAT6VJq2RhNOsx6MMUbJdolVaPjQx4+36ZkK7GtqStcw7+r8GbCo6B/wptn5qmYrhchy4aryDLkihbL+xS3IXsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YJHz15+WOnM/m2JRb8o/Arw20bnwjFEm/moTBDXQtI=;
 b=MYAHmJVnOIpiyrFye7R+qqegH8Tj0pvL/yik8fEKQBYqF0ocz0/e/M2ARDaZ+AwLfVg8oDFWD/y+BlGZMN99xSelHfsTA0gF6aNtWbLF3zPWoxWmd+UmdKvEom8iGVQeFZgmHkUuhZNJQ8e+CIZzU/FodGZ6TaaE9UBA0bTSnsmGRiimhWo5IYPCUn8/4Yxi866DCzCXI9N9FkcZsYQCLRGk+8wJNHtekNmG7WH55yBK/rbB1y+0CR0VoGeiu5RNmNLNPXrtCaGPhsiEGF3mRDXwfq/ki8PXqVAW7Lz+5PtAsj49DI6pqq+E1EcL6uGn1uOeqO/71AvnVDazbNnPEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 10:32:54 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 10:32:54 +0000
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
Subject: [PATCH v5 4/7] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Tue,  3 Nov 2026 12:32:37 +0200
Message-ID: <20261103-gpiolib-chip-removal-v5-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 57fb92a6-8b28-440c-9b5c-08df3995d1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|261102123227099003|56012099006|11063799006|5023799004|261009223027099003|261022075727099003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hkp5d8pgS/hQ3SJe7YyydYemu2sTSZhr2TDVHFl0jCRVEmweB0SCQ65gNtOnKg10hPvJ+Jw4RCFaJsePHlaf+qTtnAengPM2zXlLIrs/uX7PrGP6HWxYofPPZ/zKJT41Y7uQHKxSRIfzAGPWZmIHz4ZF5O9lfCjrfjL8ogbOeGTDRV62U69SN48wR6ci5oNMfcL6Nd3NVxLwLtXxRjjAyMogmnOOrwJqeRoH6f8jomcVJrdrAmlz/PTvHK2UXghnQGK5bZLsD/KQJyrFYLciQy9RwzWUdcGFzYl2mrpywYWSBlToV5FMUuu/Aw9UoIBsgsdHO3ofz3ywXhD0kSwYDqWbqzVF+of/FxxwL0SVipYT9eaIw2hNFgm2lWjYc326Tse5uOR61TBDzzSNQZcD9mZ+9ds5Ed/n80g7gPQd3FwwL8U8CIYOC0649WCHkP0KlwkkwuEVhM80KhLjxRFb1ylzqlX6uCA88ckw1yvZSGEfgx7ZFXgOODXTS+2LwQwQ6+l9IOa4nBiLFB7HZC5Zckc/nq3N/8Tw2rtoR3BzgjwcbURO6XoYhsBHihpc5QYoyGqBskk9473ZEDCKKK83JC82RuhKOxfYg9h9J2ch8+JOSU7IFezXEaKUCxq4Kt2n506tW+BZss8Yp7QBlvCofJjPYzkH4UD1kt2XX6glJpE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(261102123227099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vRhVruayI2Rriv1/E8gLVT8pFc/Pjd2pQbuEituhAU8G2ykdTM+ccRXqN360?=
 =?us-ascii?Q?kECO6iZ6z6PvkB8Pu1BsTKNykFc9EUMTd4Fr9D+/C09duFpizKbyRdv4uGt6?=
 =?us-ascii?Q?DlYKkSJ/3cmsLdQyYC84UBlzPzrxB2I7H77Fp+3Z8hSshBeMRzZjnxkkUnnm?=
 =?us-ascii?Q?egovwE7gRHgv3ldlmocRWOChl3Oz6yFdOpLzF1PSWrtujy0pI823wNjA76Za?=
 =?us-ascii?Q?uItNrLpJSrqPvmsuJmrlpGTe/zJTlYjzMZ0nVNFQQxI0qa04mMjNnxm2PVU1?=
 =?us-ascii?Q?2lS5g84cq/Q5GIrQtIM86t5K0Uvc3h6GJlzAGKBdAJyNcqC6ZT/zXEO7ISaZ?=
 =?us-ascii?Q?+l2YPIdMPR4hSLVTP5JNwOy36rT9ddzUcu9Ra+G7hpKm2E3EnpmSF3GhEckO?=
 =?us-ascii?Q?/DHU9Mli/3AU+V51d0QUgqQIiK8gS+Oe5BZv8VDmHo7qMwSMOJ/qqEv0D45S?=
 =?us-ascii?Q?sEJ0Wf4SN96TshR3jp102s9SlMPmBe5Y0JDxbtaSC6og942cG8tXjEzwAh9Q?=
 =?us-ascii?Q?fVaw2YeOJSagtbEndy9nkXHSpX6eAfSdsGvVb8vQiiXnVzn46mdVEsvt5r+J?=
 =?us-ascii?Q?XE+fbBI8ksRMZP1kDwq50v7ch2Q82/pB8+XFucaqkBlHCQCXvwUB7fNUS0T/?=
 =?us-ascii?Q?FOktwY4cyIMpzKiBx5OaOhmirQJ0TrhfdEA1xcmQabEVDq71tF0LInRgXa7W?=
 =?us-ascii?Q?kxkznI8Gq5LPWDyU9C8aNFiykx7LuZ8KdCGgY0zjwCZc38t2MsGIURkN664I?=
 =?us-ascii?Q?FxudyAjUKpgQnyzXZyXmKJV8FJC3hV2l7xg86ryu1DTqTl8NpWV/TGtt/x9G?=
 =?us-ascii?Q?mHlIk6/6MVg4g7NHQyNVU9GlbWyOaVUb6izsUivKqYsIqIzFYjlOPHVpYc2h?=
 =?us-ascii?Q?fUt0ASjYn7SCCT75rB7dgPtrHEPBykhCMIHUk6evx3uSI2/vj6MOX+KXL7W5?=
 =?us-ascii?Q?EAETiKp45hRKnxydvXuCpzPhHbfWoTrTNFxP+q0/D89RZE0X/RtSZaGgtuLc?=
 =?us-ascii?Q?RFTbfNjxwi41twYkNfoL7+/Px14d/jYMCB4bt3Ds7xwTqCLkiSMclpr09XDN?=
 =?us-ascii?Q?HIzwizX5Cdr31w2vDyXeG/mblSihb3d89lCU9ChmFYHL9GrMtz+RIGKmEUa8?=
 =?us-ascii?Q?f8msVMFvf6rsfdL3jqfCkDX5qJ8cJk3LIieiyq4Yf6PzuwQoet7vcl2hmHWz?=
 =?us-ascii?Q?jQJKiRSC96dTKD7SrCULaoHnpy91R4+ZeqLyWJ6Z5XgG1pcN+rZMWBAN9gt7?=
 =?us-ascii?Q?BrR/Qw9zSWKraVFB63CL5fpWujh1WBH5OdubGuhY0SOWsebZBfFVgJXmu30G?=
 =?us-ascii?Q?++V0comczJ21DSeJgN+cpFT9ynFd9hmzcdKZuJ7X7E7sGwD+aVdKroYu8XVw?=
 =?us-ascii?Q?HJNcMFH0ANJYTmF+wP9MLqOKsKB/C3ifrzoi7PX2sjRp9wQP8CYr1yUbO4Sk?=
 =?us-ascii?Q?eriwrEDXtNniAvqh/MUFNPtkSvYIFgkW6hl3WOuxoRIiQIhAoT6RZA3KOFCg?=
 =?us-ascii?Q?0FMadD61AzvcP3Ji+q4gQ1IgBMjTqlzWdX0whT5Uu5+Z51swpy6AoQvawHf2?=
 =?us-ascii?Q?HRs/6misFOY4o+9Ibuf5FPHFUFEKMsKMNfVpzwdrVFhQTKut4p0UIgJxdvFC?=
 =?us-ascii?Q?ljBmlv1mlzRFOzrwzyjAsSB5ZVqfQVbTOAo9QSMxAZ3KbR4HKKrkf20FR4aK?=
 =?us-ascii?Q?KePOzDu88GYyTGrDf/uP7MofH8/bGvwd4flMMUxXT05lpA2NBL0Y+GvPMv/+?=
 =?us-ascii?Q?vt28o8g+Yg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57fb92a6-8b28-440c-9b5c-08df3995d1a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:32:54.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Bvsn9Sk3uM6jJwECJeTIvNdev9etTUAiZXTMHNrQb/O2uRf5LJgl8rLFuX2LGJpfaiuKnB0BuHXjDscPJIGOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

linereq_read(), lineevent_read() and lineinfo_watch_read() stay in the
gdev->srcu read section while they sleep waiting for an event, so
gpiochip_remove() blocks in synchronize_srcu() until an event arrives
or the reader is signalled. The device lock is held meanwhile, which
also blocks device_shutdown():

  task:init state:D stack:0 pid:1 tgid:1 ppid:0
  Call Trace:
   __synchronize_srcu
   gpiochip_remove
   devres_release_all
   device_release_driver_internal
   platform_device_unregister
   gpio_sim_device_deactivate

Check the chip in a scoped SRCU section only; nothing after the check
dereferences it. End the wait once the chip is gone, and return -ENODEV
if there is no event to report.

Reproduced with gpio-sim: setting "live" to 0 hangs while a reader is
blocked in read() on a line request; with this change, the write
returns at once and read() fails with -ENODEV.

Fixes: bdbbae241a04 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 drivers/gpio/gpiolib-cdev.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 28cb63375d40..610628d0b475 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1509,6 +1509,20 @@ static __poll_t linereq_poll(struct file *file,
 	return events;
 }
 
+/*
+ * For the read() paths, which must not stay in the SRCU read section while
+ * sleeping: that would stall gpiochip_remove() until an event arrives.
+ */
+static int gpiodev_check_chip(struct gpio_device *gdev)
+{
+	guard(srcu)(&gdev->srcu);
+
+	if (!rcu_access_pointer(gdev->chip))
+		return -ENODEV;
+
+	return 0;
+}
+
 static ssize_t linereq_read(struct file *file, char __user *buf,
 			    size_t count, loff_t *f_ps)
 {
@@ -1517,10 +1531,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 	ssize_t bytes_read = 0;
 	int ret;
 
-	guard(srcu)(&lr->gdev->srcu);
-
-	if (!rcu_access_pointer(lr->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(lr->gdev);
+	if (ret)
+		return ret;
 
 	if (count < sizeof(le))
 		return -EINVAL;
@@ -1535,9 +1548,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(lr->wait,
-						!kfifo_is_empty(&lr->events));
+						!kfifo_is_empty(&lr->events) ||
+						!rcu_access_pointer(lr->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&lr->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&lr->events, &le, 1) != 1) {
@@ -1832,10 +1848,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
-	guard(srcu)(&le->gdev->srcu);
-
-	if (!rcu_access_pointer(le->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(le->gdev);
+	if (ret)
+		return ret;
 
 	/*
 	 * When compatible system call is being used the struct gpioevent_data,
@@ -1863,9 +1878,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(le->wait,
-						!kfifo_is_empty(&le->events));
+						!kfifo_is_empty(&le->events) ||
+						!rcu_access_pointer(le->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&le->events))
+					return -ENODEV;
 			}
 
 			if (kfifo_out(&le->events, &ge, 1) != 1) {
@@ -2609,10 +2627,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
-	guard(srcu)(&cdev->gdev->srcu);
-
-	if (!rcu_access_pointer(cdev->gdev->chip))
-		return -ENODEV;
+	ret = gpiodev_check_chip(cdev->gdev);
+	if (ret)
+		return ret;
 
 #ifndef CONFIG_GPIO_CDEV_V1
 	event_size = sizeof(struct gpio_v2_line_info_changed);
@@ -2630,9 +2647,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
 					return -EAGAIN;
 
 				ret = wait_event_interruptible_locked(cdev->wait,
-						!kfifo_is_empty(&cdev->events));
+						!kfifo_is_empty(&cdev->events) ||
+						!rcu_access_pointer(cdev->gdev->chip));
 				if (ret)
 					return ret;
+				if (kfifo_is_empty(&cdev->events))
+					return -ENODEV;
 			}
 #ifdef CONFIG_GPIO_CDEV_V1
 			/* must be after kfifo check so watch_abi_version is set */
-- 
2.43.0

