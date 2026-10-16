Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113B438493;
	Fri, 16 Oct 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136839; cv=fail; b=tHfZfktpb/mp5QIj4yK1w5/ltdv/Nv3e9LSnXPdBuhsJKdg5OVhfiyt5nCX54FVPKyTcq9C9p0C5vY15EGuNnoMU7WR45jOJnXz210kOyvXFOUX16Di5HoM5Lfcv0JgAgzYF7pvk2IxrWKpfggA9mhTTFaoio5kUNz4ywJ/Kb5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136839; c=relaxed/simple;
	bh=gl0lTwM/ihJ7DdTHKH2BJ7YwMwmwxtmx8sZ1KhJTPXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJZz9OU2AzHx1ZmwJSpEZ5X7QalZTvu/mxQq7FalOrKwmUmQgDOk2HWU2PDJ/cUsTLinH44p+t2mZdZ2VeJCiS1b5MWro+nJHjGCUANiYd28LTERQaBHUan2kqw2Ghpp/5kSPDKsZDqvSNadbk6cm+yKGnvKNiuL62d81zbEoCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+nXXyHU; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+nXXyHU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjfXOlqIEkKNnzfodxoJgiBgKDmn56jUxMV8qBeq4c/WR7oCgUDkhAgzYJ/nWF4u4TEKMmq3adfBKieNVxevKswd8382TKSvSfskUUrS8/9ZDjzoVfjhM+kDbYm7yx7XGSPOHrfC+5RylC7K3E9dwZZ1noxPIPS7hpsG3Hu/PuZFLc3lTfnFyMMMD9aqDoPTwJO0Mo0x7k6fyvs+UM0irWpX1+p26aSG+OkOo8tNIhOcSHgRrGWHhQ7swWSLXdDs9zAaTGxMqHihgPcA/KbY49i9fy/Pxd6jVGwwnkxLEoA65+eS8MNpDkjpl4Vedro3+SfIinVuvqVAY1Wm8xmsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gl0lTwM/ihJ7DdTHKH2BJ7YwMwmwxtmx8sZ1KhJTPXI=;
 b=UL+HYTV/XNl9xM0q5ALaF/wnMKu1immg045ZErWU4jcbqYAQwPRNdXVyc/BYPAXge2aLYsp2qfrd0PPvAfmzse4weCVWmhB31GjHUBxRgPXcJvxxHcKv8yi0PoJAR0J/mKi7tW2+C2olra0U/EuzcG5/Ou43B6OjEOP1tnjGiKUXXiTNhXZFDheTtGPPrSfybFT48kzDGvC5M3GWWQpoSB4vejutFiV4OBvE/09NsL+iYjkEx3xzgm7oGC0fBhOLoJ5t4qtKmi/5/FKd8cwkdZrXE5ZY2zlYz2mgFomMZaJydBS1/frI67b1W/PMZzKOTkIiOod1W3icudYqslhaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gl0lTwM/ihJ7DdTHKH2BJ7YwMwmwxtmx8sZ1KhJTPXI=;
 b=g+nXXyHUclUWv9XxJKJRyo0kJ47sGxctNhbuV4JEOInfAnOuN2bnoPfIbJ6F8F48fCifmbC3tT7e5CJHYbVSzVcDe687U2qGgy6r+6yjzKlJo70VBOcsLRkkMf/nqT6A++XuIToNkxStXIhACzzWsGiU04A7wqeS1GqzyH/ojnkgZOLu42vPVRPia+9PbrkbY4XtQi6WmxueA0X7e6TSFkgiII2IkUhlUkndqJhftzgEEhLA1TPzVn/ECGzJTra78kkUPCaO99jOFdesmZtriJmFXhasBHDL5KjQW5nNOo6ApsJD4lp1TZh+b2le2fOM3fnt5cJmww0ea7H6Kxnqqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 07:47:12 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:12 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/6] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Fri, 16 Oct 2026 10:46:48 +0300
Message-ID: <20261016074704.1860749-1-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <40aa9190-df23-449e-b547-165b8826db8d@paulmck-laptop>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com> <40aa9190-df23-449e-b547-165b8826db8d@paulmck-laptop>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: aae1ba98-e5ec-4ce2-eb19-08df2b59b03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3e2t37PDzWkW21FhRs99sgoq9M5OjOFGNEiPfuAvQ4i6bxueqURsMXfe9T1vGRK05nevqBT3yU2B7cwJ24igBeO0pKEll8xNwD4QCyEnGRy+Wn5Pr67OPpy/tXFXtkG0zNUIwNAlMp/jkflKH0nNT1LPNfrBOGVq5vpXmZOAkFR87T8q2evDaqMOx9TOjgrrkYWV4HtpK29o1wOZtqY4OTa0SupKZo0fMXhPRGmk7AC3ZefkoUOE/flF5puYnSlIMHSzMfGwiyKWFn1hyDep+VTeUZiCd68VwesrLAw6pii6jYSbrAky/RLZ9aEB+Bd9VoXmC+crXZdOOxyRWi/tzkydCWcDNpMgmIO5SYyxGbGnRVf7QFSImcIvuqN3mv/U2Xl7/CzliU6jYD18ke0QgtNr/uMZzF/XiAlVgVZh1SryIMclNWED9azq1u74Baz5yVBub5tx1EYpW0J31VNnTeqWCi297ihOj0JNfaH06+cKY8xRGK6Fz4HPE399jbhRAN4FM94s3v7brOUtBoj27CeCgaMAv3FdIJQUOObNrNFgvhByPJ0gxUcqBCZzOCFHgK6Uv5emXGG8jd2Hx4GJp+sGLjmMeRCCEqqFl5wCiYXv2FsDT+uQfWQHadVCuF3Vn/UWOtdCe0H5DkvXef65p3yplNfPbykQvxlIFTszVDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?omhGvmJIo7dxM5cJOP3ZDZUo9zdPkBwdKgqmGNLeTUUA8CANhhFzPm4R1h97?=
 =?us-ascii?Q?9Lcn1G5xoapLMhhDTLKNegR1rQRGRVZr45X2kI1tXV+UklLojgSC8fvhyOLM?=
 =?us-ascii?Q?gMjV6AzpBY/vUUxnd6DIk4wUd2fzhAXLoUx9xDvdkN5H1aUVtm1lkUSc/eKd?=
 =?us-ascii?Q?NWO1Le82t8sheIz9MzcHy8P2AFskH19k1jCAEgRVty9adyYab4IX+uy/Sq1/?=
 =?us-ascii?Q?UsRqWEo10kU1QZtaUTEtOsdnPQ8n6NLIQi96H8lRhxfMx0TuWU0OxbWYf3HF?=
 =?us-ascii?Q?E6e7iEszFB3sFI1IFy5gLFDn5C2IuJqOQ3dF9mOKCtMHtFPcvc6BGX0Od6VS?=
 =?us-ascii?Q?JYhQEcMl8rcD8imuhgsXvVl8ItNt43hZ7E21AHe0VPPmp5zW65pXT+HOcUNe?=
 =?us-ascii?Q?a7HFAxNCg/2uLcPk8mWN7h2lq4bl5Rne/pzGsDctHnFioXVF1lAVQH9QT0JT?=
 =?us-ascii?Q?6Q8+EZVKJaRhIC9071IyiE0JyMn7B6++AdpPw42qyWf8SwegepcOugSOLvC2?=
 =?us-ascii?Q?qUtH2Wxub6TufBKOo46u7cP+EYfs+kSRPtj4mCFyozFBSr2Q1Ju+7bM7dEXg?=
 =?us-ascii?Q?C/sxfLkzdos6vSZjQ4nFrW0j87yRvZVoElTl4nIc4pJM/LxZ0u97V8uBrJBL?=
 =?us-ascii?Q?oLlmVzUuAUNC6D28UXrwYRcCjr/1oKstmivTs5SjEPvBXTrPW7DuVcyTcF0Q?=
 =?us-ascii?Q?4stNv//7Oz4AW17rmkpemgLCMh1HdCRrEWUigO3Fyu3r1HifGyJkNy2DTzFG?=
 =?us-ascii?Q?QfixIL0dOkCXGKXwEW3yo0Xq3Fu0Az0vQjRdL65DKNtz6QyK8KfaVHoz0Soj?=
 =?us-ascii?Q?obzHothFkoZMD+PifigGYrK8cnyP0+QUPdW0X7iTMZFqPLPONHE2iFIgfSsJ?=
 =?us-ascii?Q?h1vgLR8I+kB7dREUCq4VceU+YL4Kv3uvcZ8qJ+NCxnY+ncANuoxBdi7df3ds?=
 =?us-ascii?Q?9tao9hQ3gHRkrd7jrf1vu8dRkvsdjW/g8E9NfpVjVG8YaJaTds1i7QFwnmXq?=
 =?us-ascii?Q?WWkqeyRnkzCn3fCer6/h+1MPKl4vkVinRHN0jHK1azePazzL0xHp04Sikxnz?=
 =?us-ascii?Q?M2PjzGSEK+QsP7/saniwOIbXJhaE+fhs2XbME8dKPWeSho4lxK39YWv4hQTf?=
 =?us-ascii?Q?zmi/i2Pw7J5g34pRW6EX4HfoIFXBBc7OyITBYbnvcRGFbl+K8UzCK9v/Tikl?=
 =?us-ascii?Q?JFygr4CgVzQ3FRt/K9Sl4gaEzFCtRPBSbhpg462dkAo+iPcMA1iRRlKv+RhC?=
 =?us-ascii?Q?vL3ZYsTD0yRJw5Rck9X+BYGpIw8Lx66i6ESCzVzhCSv4l9/yXlpZ2T0FqBaw?=
 =?us-ascii?Q?Vy4Lfg3zugjS6tR1N7HQAdWqOOEkxgi2feZCnsEw/NJCEtrYM0/nsZfo95qL?=
 =?us-ascii?Q?jeA0IPfuyOTRX9dP/BGZR9Kci+Su8Mjzp6zSpB4woCdovljkCZkwqBfXqEil?=
 =?us-ascii?Q?MnSvXv65YM+XBeRWXIVqg1AwAnvnFKi7FYRWS9kEmNcMFaqMTQkDnrc0+a8S?=
 =?us-ascii?Q?zI0bABlAAtP36+31fdUWiyRWeJT0K0kuUw+aDLKE2tYYbuy/Zzi3bT8V0n9I?=
 =?us-ascii?Q?Xiiap3wy2SLfukboJfyKshxrsGMT8TuxwrM8wOPAhQqOWY01NJexbunOd4Ew?=
 =?us-ascii?Q?gwpDcLs7JHM6QSs/lLBFbrYg6m6xnHuNPjPabYKi3ETcZ0Oj8cLLkTj1+lGc?=
 =?us-ascii?Q?xUs92VHQZrPjfGn2NC9wU7ZAD/tN9pCDHEurqcbflPGhx7PQVDRxii9kf31w?=
 =?us-ascii?Q?L9aGRNzh1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae1ba98-e5ec-4ce2-eb19-08df2b59b03f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:12.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixi1FNK7k5kll5mmpp+iWeN7q62r5KxRS1AIZOUlvt2yiPTA6e8zzbGJPlmSav1f1xdqJyc7+YLTboed0KYdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

On Mon, Oct 12, 2026 at 08:46:03AM -0700, Paul E. McKenney wrote:
> From an SRCU viewpoint:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
> In this, I am assuming that the comment is correct, and that we only
> need to wait for pending frees, not readers.

Thanks, Paul. The comment holds: desc_srcu is embedded in struct
gpio_device, and every reader reaches it through desc->gdev of a
descriptor in that device's array, which is freed along with it. The
readers (the line info of the character device,
gpiochip_dup_line_label(), debugfs and the gpiod_*() print helpers)
all work on a descriptor or chip they hold a reference to, so none of
them can still be inside a read section when the last reference is
dropped and gpiodev_release() runs. Only the queued label frees can be
left at that point.

Adrian
