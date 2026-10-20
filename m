Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501263;
	b=iRmAW1hWcYys4jZ22U3mZrG8RwJmpJPsVe8LDpsskEilmejX7e4/8AeaOjpbpwJKGvtw
	 U8qKPTMxAsY61jZqrgwr7il0Cwn3rWc6ybi6eNsudFOFv25doSdneCjBXzRq7/ZVIJC+g
	 X1HalbC4Ird6jRutVkoPQlFxlBMbwFJE5hdnbqslTGeqGgkCa1j7f5UkuZC4khW1VKCZa
	 Z0QtM3vFyStc6LQcuI20NfQ03o6yDoE/wwNPhAreLZG7WqgjVJhjLEYfoFf4OgXrSqZS9
	 eXH2IDihT+nKxspREOJWLktXzPUWkvEmKEsOx3FEO7qibW8T7C4TqoT1wwACGyvAItg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501263;
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
	bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
	b=gzkc3zpnUth/yavR3GeA/WYi3CbhSeN6txR1pHeJrMzRmntfIqNAFtVX08oVcpLHdZHJ
	 eHvKQ2Sv/qeW0ffyGrvZCiGVlVfZDAqdwENx3l9Qay57HVht+yQwR3t49OxALLqt7pn+f
	 GXB3a3sXMmJCJgVl2yFpKfeC7AwQiZVGgmAibUcQMYKgoqa9jouYuBE9S/siUzg0WQxut
	 7qnPMxbQOJnKMPC5k6cdn+B1Ea22hMAkvQMlAXyY6DRf7BvJDze5dBQbKyF0PWeSRaCcu
	 tqKnJN6quzv9p8s8oqZ0zA0qJTwmF5u7vFtZ/pREoQnfdxbpiAF7x+NIGbVUyA66Lbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ihpVqqXW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.17
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3660A380B;
	Tue, 20 Oct 2026 13:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C3660A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ihpVqqXW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSAArJDwYDA6XWYSjUplDAwI1WMToX4ixvfk96+p5y6mHCI0Rh+YmujPmzodVZjrOx9LVlTXw9B7R8QvHcD0s45s9a7ldyKz/BMKsEMtFKbc527piB5jJxpCi8EK9H82KAdyovWikp1ne1t8RJYQniBqZotWxlc6ga0wEabvG1MYu1nVj4GJypafZ2MnG9D/wI+p2psGxrxiSj1PTg3gBUeJR6drbZv1890UYD3S6DTl8fQeDJjIF3n55uOZXQ15TuIQkQGKH2GGVtAdur2sTcYoWU8XNGSZuFA7FSeG3wq/NnDJCx60V+hcjdOeslJTMYN0aQ5vedODRcKFcVOWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
 b=XhipiDlHBtscc7C66IUDYv3+KYhqYhUk5JDnH0Aix+JSVAK74k12Fci2yNTJmZRe75BSYr6oKqe+57+GDXyr2LKOcmV8j3Spkk5GDCwUe9zSU3fMq63UI4tcReKt3IdWLxd3PLP/wJPRjk/33MpI5BFffjgz/1Htu8F6mdfKKvZbLa83Fjf3RmZLHGFOt3eXmt30Unvkfu6bnYD9Sq49NNeX+wGyfbrdCGeYAFc5UiZ1L2WdZ7nqEISEd6uXCcqFNIlQ6glqk9uhW5LMt15qOX6TWSiHlI5SGZT4FnUWfOeTZTYv8VDa8ZVViL4vxqMMbYEivQGxrHQyZJpaQZWkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BneBbXpWsXnLUtxejHbUoH5uGlNDwCyP/I3lldVzha0=;
 b=ihpVqqXWk+EueVkdJhoBO7zZ6mNV7ajf4G47qHvqH7AvDRaPKHbHiv77qA3eaD3EXkq4TB6fZl/T+c4bqqRSOGG95+l03b8226TlT9vTrJmwDjaz97k/cJpeq8XWuPu2TyUs+JpAddEdP3q/I03FW2s7S/0Azd/+x4GlAgNOCtdq2D9VUDF87Ukce8zCNYhLEj374iXQh+qETrbQxX3fV9R6Uj1al6lVz73uMmYM5IvHpCzWEWU3CJxz3cyk/IGS5UFDsqjP57qzWjErGRDnh+5j5c9sJ5Ppl7UE4NXr35PGb375JNTQd2HVbxOh0gWI0/u6jUen613fsz5vnz3Uzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:00:59 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 13:00:59 +0000
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
Subject: [PATCH v3 4/6] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Tue, 20 Oct 2026 16:00:26 +0300
Message-ID: <20261020-gpiolib-chip-removal-v3-4-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
References: <20261020-gpiolib-chip-removal-v3-0-aambrozewicz@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::13) To PH7PR12MB5974.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6ccb9c-9755-4957-17ac-08df2eaa3034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|10067099003|3023799007|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	/k/EIOzAHONSfw5YX3yLCR+/mXltX0EZnwUeZ0Hjk1f7WHc1B0uaO0Q5it8mmvsz66Gn6ANVZjHE/QwFc0EpY2GDPptamLt/upcGJV2zZdIT3y0UrhDrqAAU6RH+8S0a3coSB71HMgSGImC6iAGvJd5T+rPXm+yZw5FX5xFNGT8ErsARM0a0Kl/9MetMX4MNqP7O20iw/UaJC0hvI47wS3/hb7tnZnbckcG5deILa5qegPep+XWDWPxT+Apuk8mbmHHjpzKe8a7QoN3JeG+dAJFYvaE7XfzjaQ3y+bKdJ3iQuLZWfQDQPqCtWcgCeKWlr+LepbB5KqxrFCNrVq/YlE6SxV2D6zEUr9HfcsK3l3j9xKyA7xqorvzzwEJoAQJUqzukBrBy6FXy0pcudf+XV5IihTkaBM5TGcN0R6vgKKTqwvp7U16g6FHl7/wWvt5L3QrA8O7AwWgN03HxfsVUdUDaD/b06Cp4/4RBBRH9FGh8WchzJKa9+itxHXq5QBEGlvqgTjKiD1v8gLxmJXQYIisxEyEBCAK4VUU/BkA9+6EU7bEkZXvywEGTkqK0+6djks87E3a0fut/VMhUEbX61ZPIw3O/rf250d3bep3kqs5TAtMP6YeaZILuqZq8hRB33fkX5lhXi72qpppFyD4Pe58fv1uQA2uV5+J8osYNOns=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WS4enuVVAX3Zssw/0OfsOFFT/F5vAt4VhI49pQ9WDd1Th8UlJQ6CfhVn0xwa?=
 =?us-ascii?Q?7+Si1wEzfPMKYAg3pm0g3gd21CN+vcoui77TrUTqKDh0y3p7FggsbsKsVq/J?=
 =?us-ascii?Q?7oCa11taQ3auKeD9dCVWWHFZKWqkTOgSJsrJPfEo+hF1p+IjVM9JzfQCpimg?=
 =?us-ascii?Q?qizWioPR/GIxfdpF7DcEU5yv+zKctiGf5PrKAIpCGm+5oc/tKM6uHRTTwca0?=
 =?us-ascii?Q?L0ejIEoQeBvrfEHbFpgFlOM0fzi86c5cUO41B4sDJAEc8YVHiRTYTPgbk6uE?=
 =?us-ascii?Q?wQ7GosItvSpGGUhVRBHwmTFatycqNxc9Qx4R3zegjyAMuLt8ozpxccYzif+Q?=
 =?us-ascii?Q?6RF/6OBQ4g9kc1/oiw3HZOjkeor2FyH7WkSXm6mxo8Zog8ebiL7gScXSUskk?=
 =?us-ascii?Q?/WMNCMMJ1gE+U+kdxEMogkdHMugab9VHGj21L2LIgKVZF2vax447FFniDJLA?=
 =?us-ascii?Q?gz62n0n7nGOjpIblROuU0L9Pt+yY861HQ/BIELRur0ZVH2X6vt5VkCFN4oIy?=
 =?us-ascii?Q?cgupXfrULj/S7l4B2h2cNqgY+dIkREu4d0UWbgu/m/bZ7ssngyKafzRPNly4?=
 =?us-ascii?Q?+gpTgU9CUmWS5+msg4OZqWaFbSsjmitbu3ypVU6bxzHYHQNpp91T14L1dKY/?=
 =?us-ascii?Q?AjtM3SosBzBHaH9g7a2rSyvdEe3XgWAX/DbacOIBxXFIx5REY6wLMFoUvfTJ?=
 =?us-ascii?Q?ceUkkADpVm+JYubYMfADQyBv4itYIgPPK0DVDj5vllbCGs8PN26pwBrO35Ue?=
 =?us-ascii?Q?MAlb35w3NFHgQ3tRvWoGkuN9NzECqrzCg7Zt0QCiN5Hz8qH1WQ5JC6UnoyS+?=
 =?us-ascii?Q?3iqoQ8t7OSHKLI/1Y/GL9q6yw7qTx7XaeaZ32yQ5ND7Aos/OMHyXIx/2ZvMi?=
 =?us-ascii?Q?8MCtJefwjErj5W5Hw7XE0/gejWPCA/FgT5LkBa8iL/bp4d83nFYk2jn0VPjv?=
 =?us-ascii?Q?kiAGhLj/6z2GZ+w9Ugzq5jBemt4OmoBdylypAaQ7jP5Gdd7oCOqqOAt7r8Ol?=
 =?us-ascii?Q?sfD5EI6FUDqW/V2yqffUmpOlhCQ/Rrtixo3d6Fc2bjJT1eTVIRCGEWsuRFfD?=
 =?us-ascii?Q?VHKi1czCI0PZxKXXr69uAcn2Iz4sHOqHZLzKC58qq3G/2zjvZVxZIG6lXaUj?=
 =?us-ascii?Q?XaB91vKaCk6CG2tziZTLkl0iuMEaYCPCBIpHlNcUknBWomPMOR0lkyfGrwjY?=
 =?us-ascii?Q?adS121Xm6sBi7hj1huWyXQQlLrYRsliRZMl+TS89+flZlZvvYMVFWemzQWUo?=
 =?us-ascii?Q?yNmTUzfG8mOYgZd1UDKKLRL6E0UsU0yHhhPxGO40xErML1dIKtpX6OyBXEiF?=
 =?us-ascii?Q?z+X/g/9pXEShN/6vhiU/4qh0H3By5AcHviaXHnFCugWPxD3/hZiriVg31fZ7?=
 =?us-ascii?Q?G4ND34P/uvIEKShMjbTa3Xctr5o4V4ufel/awnKwYwKu9ZWcGfAdWYZXcR1D?=
 =?us-ascii?Q?HQZ15SXjVwYN6gpYaKUfHDpN4zjpBrgnYAKpYwZ5VcAB08XkiKAymSEEUQQE?=
 =?us-ascii?Q?Hxyqbd5OXnGEk3lmPvB3e1MgdlGU++V59pw3ogh08G5uay9G2ArM0HATftiC?=
 =?us-ascii?Q?cNnXwqiBYheInzHkcVMFpbq18j6lnjET8Hi62lI5VqXQZXPUvcl6ZlKKEu9S?=
 =?us-ascii?Q?pg19meH6SkwLjfV1sVsaj9xDFhQvvd+2ppFBfPGyVywRd7MkEDYz0bwoHMv7?=
 =?us-ascii?Q?CIEpcfVo6abWqW/ihFRpn7DkhqzTdxa+jr0+DH2jjxUas1fmrMQZp8i9KRMx?=
 =?us-ascii?Q?xgytuWnRww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6ccb9c-9755-4957-17ac-08df2eaa3034
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:00:59.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjpxQlwI5AlVX6T/VR81JyCytSrMuJGY0mL/E4EBMmfxafUM9irnn8vTaqiNt6OtUmDsHyJxFe7lluCEDvXUxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

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
index 6350b2fca8a7..c5869e3f7767 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1507,6 +1507,20 @@ static __poll_t linereq_poll(struct file *file,
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
@@ -1515,10 +1529,9 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1533,9 +1546,12 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
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
@@ -1830,10 +1846,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -1861,9 +1876,12 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
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
@@ -2607,10 +2625,9 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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
@@ -2628,9 +2645,12 @@ static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
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

