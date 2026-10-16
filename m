Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAE43C051;
	Fri, 16 Oct 2026 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136857; cv=fail; b=OXM//msjrMlQ/aHc7rhho5AIIgm4ZlWX/KdezMrM9tlVZyclcj+hk26sIcTQGqh7ArfHq1+NGQ25ItmBCYKrH8OJGnc4MIvjSBHW7CFADG2yjasl6/mFSmkzdfIe4Dh9wuLf8TYm9QJ0I0b6AKnSzTESkGiJGb+1fekixpJxmys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136857; c=relaxed/simple;
	bh=dNlmzgXQoOyRBVqbbNlUplOoCdyxspnymsQuu1HS9Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mz8yqjl55jIwydKEmoP9gLibJ7STGRrddbSdTfs6MCbxwHOa51F7uFDzOnOuPe2PO0d9+hKQWSWKgrJCZ99RXLq3b4uGcbfdtWwhv967vcsRFkTKi1iYBrImG/k9snfjy+I5lBZ3T71sjDVl9afbrnCpzNV0iQkP4DI97E0BQ68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iy8atrBe; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iy8atrBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4CJe5huia53cpz2UXzv0RbSsUkLc2Yf5ilJ8uV65YQjEjrmb7lYHFq4YZequ5DdkpZnWD/9nYoF6GUTxLj/mL4HsugwVXJBsTC0uPx8yQKm2MeKAVFSXcqzpnsdDFSJ8YnhDZAKrtqUk6X965nhJflxbCg8gY91v5BdHvrkF4SvfUw7ELXGQr/jiOdeSmaXdrmhxWvP+NULGXc5e4bYuXoLF6bK6RbL49pKvtNZKwxhp6TOkWBjDf/EMS3WgyBWcFG9ZSpnbTHsXqEJ1z65+ayoYeq7dSlk3WxrhxhNdDnAGpPIBJYkyIdfrZuWsG0VeU7Iquzk5lqp+Fjr9V1zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNlmzgXQoOyRBVqbbNlUplOoCdyxspnymsQuu1HS9Lo=;
 b=sZz4QIWxPLUGvHk6j9zye9NTK/eQgCyw7fYSotCJYJ/CPMZtAAJ0KNU3fGKRtoZBYsN1tUSAi4D70kv09vJCLs9bzjSE3tl67AaKWaNU36w9sHOk/UXsQGhU3frXe/aMRq3v7ML+axQ+huDa6sxahvZEq45ldHB5bG+GHsu2My8jpHrc5W1dluMtnga7oA/KagIjBHCSROlkpmMAPdjNIvqhzS8U4OWJ2miosPkVylkbzpl/ieDC03TPrfSt7Rk9nq5AFiWKABy8y+6bKn8YapN39s2WAXNkVog3qZaMu4hSCoR0ZpxGHPGt2OB0CYZA3/KwKp7VuAdfhZIFjxQ2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNlmzgXQoOyRBVqbbNlUplOoCdyxspnymsQuu1HS9Lo=;
 b=Iy8atrBeRJohUu0+GtAgKTtHbWH1FGuPXWhQaDnsW5JWSvxkNbBV9Kh8DSrBYZOZ+PxSbPQed1BuXlUW54CRTXv2zZjaPcbvJrHPTA/7BjkJKhFHQJqzp/z6/j2Wm+kutO2VxJSzQ1eG/iOLqauNHWwgKzKn1IFw2F2A12Zfnsi5+QVBdvW/QcrtBulxyYaw3saBtj7REXEXxNUzERU9Vfv0ySKsYCD4fen3717cwSpH2wEStb7FMOQDU86WcwZRmQt0fmbhqEqVQpOGG62vjqCJnTMruW5YpqDvFYZxP0u5dG+3pDF+zagp2itZXps01e+o57Ch1AVPjVIJguT+HQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:32 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:32 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/6] gpiolib: cdev: don't sleep in the SRCU read section in read()
Date: Fri, 16 Oct 2026 10:46:52 +0300
Message-ID: <20261016074704.1860749-5-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as5SyJjLd24B8jde@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-4-aambrozewicz@nvidia.com> <as5SyJjLd24B8jde@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::15) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 2809b608-27fb-4280-e620-08df2b59bc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4pElw8PwK1CCPphMGkKPtWFCfg96HJEVT8M4yF/Z6bUX3vvNDrodRwzdta22E5+Kp1xCZLWyzw8um80SVNao/EfIHg+BUovfCS1EKF5Jj8eMJPhEe8sXlFi4qrC4mgBdR4rK3cgMs2rLEXpyin/ijHefAT4a6r69RvzmCwtVbQZH0miyYRkSX28/WJgoBwfYXGstCDmYAmsgqT7WHTj2M4KRRX7pCBqtXcHDBcstsbTdVhUPkqArswbkXPb5kDVlgurTpa6JnAynEFHK5e1E/qpXs0VSrbMYrDX5WGtK0Y1tDAOdBcZdqOGOYXVVHiixDeyl/XSgtvBZMsF+Goq/3sShob0ru+o826Q7Jnk0Ybc2NooyOVI7c1n/s7625h3++Bq5u0iPqdFL0x6MxjdrBmGl1laYDtwWez95aeD4OIDTK1EE/2FQhPcQaWA/oCt63bjBCaMQ0AhIrClJE/Icmifxm5X4iqCbULokSm/lYOG96iRX4Q/r2kWeSyxHmWg0DuN76xe0ElcUMpjUKnbq/kZInVEjqJuHiIqRWXGba/XSMwyNxImomOJ7grr4LTUcqCp3/gVyVA7QuOP/zI6QK3fP7yZUpmN60XW6C8pg6TSo7niHCGtDdbhQ7nZRXvcoAiLQmbKc6B7ef/XQJQherlmiQo+LRgsvcJLVrdlFeao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k/UQkD4aBAgRvBlgSnHNg89CfQlzqZ8wKSRhcwf5O8zlDFIHqzzVbuBpcwf1?=
 =?us-ascii?Q?L1svV13kGTRzYsv5CIYcNg+Z5LyIt1W+Ngc71whV1TEtvKx04JBcG+Twh6t2?=
 =?us-ascii?Q?BWxYOA2Lil7cu6Ysk0qRza+Hd6UhJUg9fjxvTg4rgOHWVgSP8XK/cmRGSJ1E?=
 =?us-ascii?Q?gedWSj/5aUc5sWH+iXGDjcwFDt2uif9E45mK4vj2i/q2YCZ9TGEVeRlKH0wg?=
 =?us-ascii?Q?KP7KmXdCzEdoqLLsbiJ0FZ8/bPFJx+g5ibrFZD5THj4DQDgqQlcF8FFJWuEk?=
 =?us-ascii?Q?l7kyumYBdyelfiK2UK4AnGGDJgRbCkLVRfthYaly2p68jsEF5j6LUPjEbgK3?=
 =?us-ascii?Q?fw/wqquqTZi+HcEZbtAE17zOOcpiW3yNgdbbHkcOG+tmZD0PctdNwFGBTm4Y?=
 =?us-ascii?Q?N8jblXZtqby3o9qG06QyplUaVjSsOlsfZdenncBeK5E/yZaB+qUweW1LTqhe?=
 =?us-ascii?Q?5qbtb48OjEHSd9G0eYLqTGStfNjNBpHV4s3lzee16hFrNX9vH1bolpf4qEjk?=
 =?us-ascii?Q?TjRkxwR53kjclqJ1uUyixoPzA993iBWQCggSOFKJuJRwislxEpgowdPt2/7g?=
 =?us-ascii?Q?6c+b1Phb1p5LAzddvM2ILMU0sK/Fka75Mv5Wy+PplwVOHLJMA1lSHpP7T1Iu?=
 =?us-ascii?Q?rQSdb+uoWeXMgQ25+n/85ag08q1HUnBgEgzBfrXDVR8f/Aoaz1JTYEY+gk4k?=
 =?us-ascii?Q?5zuG5HJ0+jFepQXVJeWr5+ihHtpyjiXHCjfR7FvASwxzfUgwLbqdx3qrxvF6?=
 =?us-ascii?Q?KS0eAiKXvyCLF0OWWu+iOBdwrPN0SeFUNHDHMfhAFKpUsIGOXvz/Bkk+j2iY?=
 =?us-ascii?Q?lTqcPLZQR3LrNIuTgB1M/dIrL4jS7a1LUTQyYabUOrOUn261CkwNGyrinJW4?=
 =?us-ascii?Q?mLKhM5YiwQ+nPAylWGQV0s7m/OS44uPZz9dVS4f2qjXIpKqMjUjTpmIB8NFD?=
 =?us-ascii?Q?bT9w4Rn9D+0rjNs4J/RzahuvMj1bPAlaOENl7PjLd6iZJVwLjWQgPECtyGDj?=
 =?us-ascii?Q?lFaDi7IP2hSGgSMoqlFUW031BCjlckPdJyyyL4Xlk7TtP8HXiyuj/8DdSx6/?=
 =?us-ascii?Q?8kLswtOYRmi+jxBkrxRA4r/7nepWmiVnugsYOp5pyrLZNGaId/pn3nc4Gs2/?=
 =?us-ascii?Q?cvwU+/u0DYPV3MAa9iFBIgKuQbZkZmBnrFRn79lQ/rYQZqX0gOd7qSqfwc9O?=
 =?us-ascii?Q?21ThaJcnfUaJsbw4f/kuyHN0TcFO6UFXJPjXe+w6eH3NqN73F1wCyPYNn91H?=
 =?us-ascii?Q?2pZdMFElBNehRwtl3am+bbiotoDiV1/W6d3F92kJuv1WLRJNrNsmm3Z14mwQ?=
 =?us-ascii?Q?ProNU1/62tFmarlV9Dk6QERk0Trt9I0IKWX998hynonMaSua92txtP95Iy3D?=
 =?us-ascii?Q?plZLIIaZ4WKKsO2Vwykz8ughoTNoQQDV9dEJo8IFHwFdI9gRqcBwhhy2XZx/?=
 =?us-ascii?Q?o4G+9mPk4RvAZ/srSLbreRleikDLQ3Jes494LhHh5M9lQ/yq6qt6mKtMS5Ur?=
 =?us-ascii?Q?NTHQZmJT9g9L5Jvnu1vqvjn7hesU/xiFeghhmjBxLudzxqDjd/WQWYzslHPk?=
 =?us-ascii?Q?53izALLajG4TdIRE7eUk1OVQW4bd2k+IDQNDaIkWaLLtxGky2avSHkyzwVA0?=
 =?us-ascii?Q?xECKKD/tOucNrACvUOFgeTiBr7IsdTO60IkiynEozzDeGygPP6up+QmGUekH?=
 =?us-ascii?Q?xEcmBigJHMwy1mg6X0Mhy4aivzf8fVKqkRC1PXlzTeXhaGuQZcbsqomovr0p?=
 =?us-ascii?Q?mYZ1/49tEA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2809b608-27fb-4280-e620-08df2b59bc8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:32.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNfa/KLDpYtoyU4To54qBn8S+lefmYiUp+jsEiBoxpK2ZOTpIWlsVaYhnP/viszKWS1ed8ctjmNB0sisjLJZAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Tue, Oct 13, 2026 at 06:48:24PM +0300, Andy Shevchenko wrote:
> It's duplicated a few times, perhaps you can make a static helper?

Yes, v2 adds one for the three read() paths.

> Caveat: not an SRCU expert, so it might be actually wrong from run-time
> behaviour perspective.

It is fine: the read section of the guard() in the helper ends when the
helper returns, and that is what the patch needs, as read() must not
stay in it while it sleeps. The callers do not use the chip after the
check.

Adrian
