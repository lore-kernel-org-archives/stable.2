Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B279440A2D;
	Fri, 16 Oct 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136861; cv=fail; b=OaLgnKRXdgkmbeS2WfmT5vRYEZVDd3Zvmm9pnFvR8EFZJRdyZquNyfgG4EUT2X2aDlFGGLsMFMtRoff6FJrR7/biqIeF/yIdastB6IsSqB08jSJojxeaxeRvLUAHJ9SyjiWWKz5dYf8vsyuOdqL5lL9dXgMzhUbU5mFs0LB41rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136861; c=relaxed/simple;
	bh=sRUSkHdJGmbdyow1BsUC1AfxhaNej2BjMgG9YgVNwBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxIh8/E5mUgeiTRRibFMZTBJoCOUFexWUORGOlYaC4wHHCwz458foZTYd2y2tZAkyZYxe5ciPx0BgtGeenwp1mxHUsTO/y0OhI1gPq2FO71KoOgz9XutKf/xMQ8ptOCR9qVCMyiCqQg1OqRSaJ8S2/Nmm/w7KxtTrfmbQOtXMQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OcDNTPRZ; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OcDNTPRZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4OfCXb7EbA1gtKKiG6AapzP6QVu9VB1SDeHmzEbeoBHvtHi6cleYtaTb7CxKOE9GOyn8r6MtHn8KuRf2h1xsuggevrpZzYtU/oe+NwvvLFFMgrSc2F0AbnRP1QJKRTG/UNlsscwkGLLWH8bbP+1JQXnf9AM8GK9TN8QGqyAEt+Xa9tSc8Qr1MEP36yTy/NYStSN+J6Fp0mOWT1P7/OG3u7LVejpyS4/reu0kRCOKea/A2lp0mQXQvmKA7iWeTUdaHy7TZGEodqPSnrpxfAVUDsR63IcWK+SFA9G1KU6vZGafotWrUajVOlwgGYyEroQH3zy2/WUnk+OcR0H4Zx8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdHSmzg+Yf+nG0Qa677fJCP/fyhiMDogCLD2+5mEIqQ=;
 b=c6VaHRNOyt/Xbjnx+UaLtgDBqB0CfEaw2AJL2gfYMJkgnAPnjEKnm1taFMf8xY2RPuhy1i11QNS8BlZZGEdXb74C8PP2XFXGzV8RGmTag06yxoVAMX2UQGWFToInM/pjl6N8A47sDYLjJkyYoyXqwXiiVusA7jodIW1oEr/CfPzlh324hvK36sh3ZX8zxvvrOlHQO3NG9wyZ+lYVvG1F4Jj70IFmvEX0Oy9sBkVmSAPnKAytzNuagklMLkyhccBPgYCYXjZfofN5U5sP0JrfRnXrpNTVA0V8re23VwLTq3zJHEJ6RyS1FZxiFM8qRcHcSdIfVDwOKYVafFzFx5Mj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdHSmzg+Yf+nG0Qa677fJCP/fyhiMDogCLD2+5mEIqQ=;
 b=OcDNTPRZYV6zBw3NuOGw0YMas/UdnkGDIj/NwYgtUBzOowQ3Di4GxVjHmkXJBV3lGl12hQnhCOo5oftXkIoNIqfL5fQkGIT4nZh6y7y6SvL7CNiVcQXbhofcc6qmCBSyQO9DhY/vCgkRrNBzW1KW/WkUVg2WCrjCMdCwRKcPSao3ZKZ2bvV26a8zKj3MkmJKi8/+k6WnbxSVf83K6x4e4aMXGUhthjx4uh4mmCvTUIMZnwzx8FTVitUrNQ7foWQqBV+WlzMSAclUwOiwFsoyxmDBYw8nwVe6uLENLGw0Rl8t6pJA2xJVTWDSZ9lQdqI2IxEY8kvKjIJnI6ZyyctruQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:47:36 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:36 +0000
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
Subject: Re: [PATCH 5/6] gpiolib: cdev: don't leak the IRQ name when the chip is removed
Date: Fri, 16 Oct 2026 10:46:53 +0300
Message-ID: <20261016074704.1860749-6-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as5VeTfADRr9nwRN@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-5-aambrozewicz@nvidia.com> <as5VeTfADRr9nwRN@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ae39f7-bd09-4940-9041-08df2b59beda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5HnrBD/zurrhPOYGdG1wJe/MbzCWnB1jNl5ZOUeThsDEf2lXYlaPYC2PWMJ3fIVg+xlsaDwb/vw8yEB/Ofnj0r/YdYJWArsb1e/vKdhSRDdvRda463I9ycv8w9PcbE1UwSd8+t1FKsXfPCD2I72yaDDfIRWzm9FGEuRgiQptFityBYIdowiQwl821VgRrhuxNI+byqLjcQ5yW2ayOFVCL0/NZ3XuMTPTZoD2v1KuoR7fFJ76u1tHzXh0/s4KqS20B+4clCVD7VOderufnaQ+p1F04pYfBkD/kymiZogqqBkLk0ukNBHC5IDusab+YG3HpPd4Fg7BlplJYjiO8xz8IBhxYEeCgupjBnVWboUJwidkN7qd2YriEXtJWsifiuOa420iEYH2EGhXyHOLe+VVnDU0GExpBJd7bBu82fitAcHv/hw/PyqSznkHmhlPPxiP7nuvBMdi4xioyQ23/hapQAmOQM2HWQ5dPQFij9qKEBuREc9X1LiRLvXOn8gOnD0YJbLRJ05TtT+TRSWYJkGgbgd6S91jH599z624KYTE/Ig8fOosR7zWj0jYq1J3fOKfA5WAGSMD1sIXm2SfQJY/bJgg4kvpqKVzt3C5+u8FLySwNk+QgNCrCH488FWHyaijlSc2mdUq20wb6WWDuqyIKTphvh1WPC0/mKTLGvAjHmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybyELln4pArC3Yo+Swq65INUKkCinmmq358koFdEJOrzQE5djyDN/6N9NRDL?=
 =?us-ascii?Q?z25ZIG/Y14K7wI4NgG4aNYxfO2+qITdmha33jse/QAlvbqbDp+3kwlLK754C?=
 =?us-ascii?Q?VZack88uvAxoKHCPFNOF+7FH14rPdmYGm2E5djFAWkcoOfJcEmaqKduXjFf2?=
 =?us-ascii?Q?0z/AnzlsVNMx7aa/WEJDKjIMeQGzzmj5RZ5UL0ie5Cfm9ftbTnXpqfhdRo/R?=
 =?us-ascii?Q?cWiLKTXZvU/u1Zkg+uHIIklOIZWnDVJmIKNoZDDTgg7deCKWccoXC2s7xNPa?=
 =?us-ascii?Q?7vQO3PBZe+Y0RiWTD0D9uCjGm1KPqz+D5IEYE8zd7yv/akRNvhLOqlTwWSdo?=
 =?us-ascii?Q?IwQRkypxBFlwnIuOZiQRfePdDSqSbTTROTAWfD1Sggs1J2Y7ZxC8k2/b4YPO?=
 =?us-ascii?Q?Z/3vAmkh8tSxVpCWeC03RrIKJfFT2iP8IW3oNXORBOZ0cw5Hc7epM9D83vsk?=
 =?us-ascii?Q?RwNuyMafAXqwXRpoBTt9IS4Fk6e73ZO6YnuCMh7BKQukQj2wMdHjXM0Nj5In?=
 =?us-ascii?Q?wE0PI4Mnk02C52oRS9wYn34ekfTU43QHUWc5Xi2D7xTaqXMIHRgi1aYD/N3I?=
 =?us-ascii?Q?1vYyq6C0iL3J/ZMALDwrHvVb5Ng0RMOyeCuSgG5L5t2+McKIl+MS/16EM2jR?=
 =?us-ascii?Q?1Bdt4NW2S0m71B99hoRKRtzRX06oIg8G2CCHdF7xwPvhiovw8D9eQwcOLZZ5?=
 =?us-ascii?Q?tWvKldVGgFoUjkwPFCwJ8Yx5lT0ViMrtc4j2BQh3Bm794c5AgqsgDoyrw2CG?=
 =?us-ascii?Q?Y/+/k+iwl+Wc5UvFVkBDwSDWJ8+YbpO/LPGTzzcgYuLa/YMFc34bV+zzqfpz?=
 =?us-ascii?Q?mJjC8LEPfAE8fPe/QFmD4IZl8R+kRf/i0edD9rr/0qoaczqEP4Gogjbkh8Rc?=
 =?us-ascii?Q?1jZGz9V04wpNA0442cdEZUPtgm1THFeD06iqTRDEoX3HD+iUJYZvxMlRxMW9?=
 =?us-ascii?Q?uIEoZQzuWLpmmjvloYrrtbofRPOPM5IAG7kGv5dxilUhX6ZZAKPrym0ho7y8?=
 =?us-ascii?Q?rQtgLTCPQeauSquvDBib9CITTORYUpiVC7T+JE2tnxaQVDIOuKVdrKFfIYYH?=
 =?us-ascii?Q?aO4wPRxhMMV7Wuz6ff2I27FUSfz1wnGCjs9gQL0zu/JCjU2IMWA3JAEnZGAP?=
 =?us-ascii?Q?WWGqI1MUpCbYUigTeUwECeeEKne4K/eOR9hbXADe78D8ndhiZ2eeYymEc/g0?=
 =?us-ascii?Q?oM2m5EF+rG10RaWb72xTBXActauUIyliond5I2KpWnJo/hMxLehTJjRWE5YH?=
 =?us-ascii?Q?OZgtGq0dPQTPPKLRetAvzUlzK28vD7DL219l/3emu6JNG3AGsWN/rWsPz5nF?=
 =?us-ascii?Q?gmIBoAL04/hLqCoNDuP0LdXk09UxksR6gIzEyJz0HVyj+jT/BlZiipbrYBue?=
 =?us-ascii?Q?SmFt7Ss8HzVrQHvgSER3LG2NFCTdT4U8SMUnNC1ozsZ9Jev0XoeYrj/tbgNl?=
 =?us-ascii?Q?8Laf8HRO//127dsrFBJm14KgAicOcZ+EVEx3tB2zQbBQINQ3KVsmaXYgmaiI?=
 =?us-ascii?Q?PgQoP9kfsUVZRuacN7IB9E+/GnX1NE2IeLNQa6jaBqxDmYpVXIz0G5SqPlRz?=
 =?us-ascii?Q?+vCjM1d86MG1MD1lKSOrcQAzTdINpFzNhBdd5YnqUdpWCnFpQNrqHcRsz+rI?=
 =?us-ascii?Q?GMRXmL9JYyw1QE91NFrDUHswzJH8TmU6/knts5WEM22IlII/67MpQiKJszXt?=
 =?us-ascii?Q?HZU6ccpSHjblytWDk6DidDofXxsdzlHWk9Wy1oaMAi9T7TrzIPbl+C/QPW5T?=
 =?us-ascii?Q?BGv9HAwqDw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ae39f7-bd09-4940-9041-08df2b59beda
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:36.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAjpzMGrP0fzyq6Mllbx9HuyNGg0BeoQzu/RJ4daJDbsUULCMB8fs5UfgDjLwxq+R1CgLLJWrkh9/Eh1argLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On Tue, Oct 13, 2026 at 06:59:53PM +0300, Andy Shevchenko wrote:
> This can be modified a bit to prepare for this with the suggestion to check
> an irq here. So, in the previous patch you may have it as
>
> 	char *name = NULL;
>
> 	if (irq && irq_has_action(irq))
> 		name = free_irq(irq, dev_id);
>
> 	free_irq_label(name);

Agreed. Patch 3 will have it in that shape, so this one only changes
where the name comes from.

Adrian
