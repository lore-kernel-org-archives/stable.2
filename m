Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886343304D;
	Fri, 16 Oct 2026 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136845; cv=fail; b=i/bjE8Hx5MY8zKj0e7o6/hRGf2PKvwmsPYZgGCuW3vhHjHk00717lI4NlYGwT4/7GJH6Wcs9UtgwGAgNpdx5F35GtoIhNqKkofpBeVCnPduef8xQXpcOi21MAQBMPQ9WgrWZJWjdFYZsuTIu03N4fu5P4l1s1WGXMytJdG6ZRrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136845; c=relaxed/simple;
	bh=wyIs4vH70mbO3fmWnKp55gaIeRAAEw5pOoj906FX2Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cje2NafruA1764d+AbS0LISKjzaGs+TBf7Nghm9zJSdWXS8YUoTdhJBcETDe0pR95iHTxj4wQc6RdO1LW7sM1rgH6FPUA+RTQGQiAyu2xNe9VwLjUg88p+85k8/x8cfwH9zYWNLoYtrmngQA1yoCnxQlDvh2DTsvb9HXigph070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o1Qrxb0i; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o1Qrxb0i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNYU3QCwUcPXGcsfUESNBi7gGVAZk7tpvc/H8WuWPXgohxKT+xNSDs3MsqSNAZwD38+4y/F89ocDWgeTMKf3e0Yq/CPy0c/nfCZ3ljE4WeUxJq2eF/FoTlEuYNUglXCEDzGA/aZ9YJ5XX3T8ZIojCIda9cPRdM7l+mDt2wWYjoWdtO4MrI9jY81Nrb7lAn4JOVs13m/I9cl+Ky0w+szIVov6QvaYEtfDS5BVGzAGQ72xGGUIeJ70pn4mlQIqOmShlfbOHHaRL3asskkvd34yPzyO+nt3kDVF6KQUtP8p6l7w+tuNRCsfQklCy8a1U7Ii9ZMaWqaJneGbaVVMV8yBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyIs4vH70mbO3fmWnKp55gaIeRAAEw5pOoj906FX2Js=;
 b=kKrfid2v6MlfHpj6EiOP10BxfRM5xNkySbjJwOrg+Z6bPPYnFvkrSgZXXqwjO/9xFqXlzkN+lm44ROWnQLzYqR8lv7GwM/0doK17Kes5Z/qVtiYwi1evT0Jyw3ViLPC1LC+6e/0TbpLnoQufCaF2FDV8FLi/9bP+ll5STw5g5JKp9WNVVFGiAMkpZm2ro7bClyNboP/tQUnNXUSNNDS0EAGq9ycjTZoP2fNSsswS0Km2EpCMPOnKRoZ1Uce//+uqlP8T2O57FMqSjhzGLJ90kDq2IoJnw8GecbK/v5VL0H/lQVywayS9J/QVx1Y1DZxhviU2XBXvRyei9lx7dPFu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyIs4vH70mbO3fmWnKp55gaIeRAAEw5pOoj906FX2Js=;
 b=o1Qrxb0iZ8qNHu79LJTCBH5a5SKezPc5zmxL8OQ+f2UoerBJW6oesr6IZJMEG0MjEhQKSnpA10qw+YWER1+WMVaJONLylFL96/BxBNQL/tXIQQSkrxiFTucm5UbGmGQ08qHbScDJDQI2fGJvVXuWFiW+qAXuFT/4Xz2hJm+yvapBA+iiJRz7U7swyUYsjcj8qtxi2mdf+hv30eIzAgr3uSh+E6RYn2m+XV5/c3GtIGNWuYeJGka5YFrhp0yebphexxqXj+CkLASt2DDhYc2Qef6OI5vmqEJjUIjcRX7g8ZcNn7Vlbcj+DQYYcXNKpeLNsWxokTQq5ErQfZ1hoV/I+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 07:47:17 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 07:47:17 +0000
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
Subject: Re: [PATCH 1/6] gpiolib: wait for pending label frees before cleaning up desc_srcu
Date: Fri, 16 Oct 2026 10:46:49 +0300
Message-ID: <20261016074704.1860749-2-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <as1GOweKHBq2HhpP@ashevche-desk.local>
References: <20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com> <20261012-gpiolib-chip-removal-v1-1-aambrozewicz@nvidia.com> <as1GOweKHBq2HhpP@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: de49b858-bc9d-4757-f392-08df2b59b300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|6133799003|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zG73XrY088fO0spTy+VLMjdMmNimfGd5087UE0WLun0cqILkg+yEHly4jvm4v4wGdt/aOv7T97RvkNv1V+NFei8vUp8Mhg8H77RwIucM/kiVSA1Q7M4cAqFVSt41RUYy5kM1W6nAJz+8iS+Bzy73uqfgNwYuryZrT0upusvBeLwJjkSvP8ObB20dc/jG9CHjqEDy52fHeCaYQOvQ0EOs+uWbZYUdSKqR2y6eiICIU9dd7YR6pDw2/xaai9lUuuUQBubobcitb0zMKbYfdI24nmbYTDmETY++ojAqVUYpOXM+Fc6+zdcv+rjnhZtx3qEZ1KHi+w8IkB2JBYvIP+QnshQ5P7kTuo2f1FM9tMs37+nl9FoMetlbFvHKnYMZJDspicQkxgZty0SOPjZ8dz3mwvE6QaEKIcFxImCBkied3Y5cnMXV3sMQqGcDx1eEiLASiuyAnoU/SKPp7OwkxpYGi1fDvqcqgTvwXag6oXQhtgreP74JlQpgt16TpwX87gTW8Vqte1owuI8TDZKV1lZXmbqFGSIKlrp9O0R7uygBnn3wxjli9ySSMQ0DoQyFv08O31y70F7xcUNhXhGu04OCsVc6iwf1i2ZSxaE7UJn6hz/p65gE6xSd0XgXmfUTHHLE64wEK8wbLvzzneJeYFQmXMrcGZfiFhtyq3FAzjHtS+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wB7qv9wR1fhWxtmoRlN8R21/0fiTDK8lW5ymTqxLnc1A5dNSJVu5qwx3koAd?=
 =?us-ascii?Q?S4gAEUGHHYyz5Obixtv452T67/Wl23sI3YhDdnxLnITEZ7EiRHWLW2mSCMUR?=
 =?us-ascii?Q?s7kumKiQJUE3Fdyv0XCiAvzAN2gXoYoxFWOITY89TlnKuwqqM5O/N8X3rd/Q?=
 =?us-ascii?Q?zjwjkR3mhq4Z9XGh8bJLunI9g6o3W21oEZC9+hkmZHIzPXcUjUVJGvdQzSbE?=
 =?us-ascii?Q?HgUKZIhjxrBHnjD1GZqUHs0dZXgTEk2yREUKheVfZnfRkA4XEdzCEBvZBB0V?=
 =?us-ascii?Q?Q1ttAZZUQNdiZwOyGlO/zBR3ZGDmaLV/RP9O2YyPqQifIv2hHf/FrJvDOIKi?=
 =?us-ascii?Q?3UyHE9lCxHqZyROk4rYQ6Mzkg9rasYFZo9BxUqiKZbh/b+l7moWKs1196tYH?=
 =?us-ascii?Q?MnAolQsBaeMOsCNi7OHZGbpAITnS/0ZcuK9TyN3zeNCKfOlXpDXoueeG3cs4?=
 =?us-ascii?Q?c6VQ/R8UF+UERy3y/Y31yCF3l2jd4RcGOQfvfyEouH5XUQZIliSwmCnWqiVr?=
 =?us-ascii?Q?ZOqczzc3oGAoLq6OPTswxThHF4ssE0+Jy1D5cmx6060sYhgzagp32f/pJZhL?=
 =?us-ascii?Q?kP6UfiW6HYmD7by5n1jLjEE81+PW4aI43w3ZwWuNBscKxwvI/sGRtiYDmeZL?=
 =?us-ascii?Q?vFQLCOLhQ7bvKf3QJZLo5QcJVAudurFwULVIV+e9S9cQBv5YozdmFt9/NCyA?=
 =?us-ascii?Q?vQ97Crvb4+uX8d0pzKR8t4/GsLA89+8IACAmHW0uuL8qgfNTs5vFYWNhOnpf?=
 =?us-ascii?Q?8728eQWMnuhEeo4r26s0WSjpemGlfZxUTsHdnGhGXhZdE6KM41L7VO3EiS1Y?=
 =?us-ascii?Q?v2P5JRWgsWD3vz6zO4IwfuJhLS9bAdtrqBjRhFj20wNgzhLNgJGUnDvd9eav?=
 =?us-ascii?Q?+auOvljXTL4J4wct4YTdCJ6d1Y43ElTjIdHsBunFOnW+P0Fg69JK5g0V7753?=
 =?us-ascii?Q?X6VNYqvbuZvoJKB2a686l/Xt2KS7RPkOIDRIuR0N8eK62Jlolqz8TEF/5sHQ?=
 =?us-ascii?Q?G+mPHUt66hxBoO9YWPPhMzDtkqCm9/bi7+PHBX+0LqIr0k/CQkzI0gqOVhuX?=
 =?us-ascii?Q?ovLvtivFwMsmWhK3PGn4ctle8nS36yKQd+qe22lIWD7dWH3qz1Y/S+LlEIdL?=
 =?us-ascii?Q?OOXbqK4XdSRVCRJGUzDx3hIhWGC6qmejTBD4KVcJwqs6KM4RScKDBsFDEKjq?=
 =?us-ascii?Q?WRcu0n9nz5KOAe/qcGxl0CF7QQoOX+yRw4+a612OfSYhQRdI6xlja0JQeTpu?=
 =?us-ascii?Q?jxvwp8pGZC/QJNYywzqtBbof37Y5U0OdkGUELMdVER7jSVhy6UsvwlSbl1AC?=
 =?us-ascii?Q?ZjOEnULbtFGcslJmdNleMQuwahXkCWN3XoXH8hXT+KtAu86Iu1iUa6D1MB6B?=
 =?us-ascii?Q?nmlyngC3eo7M7aZirr/XLwMT1qOCbt0gBnR5/R3URw5slO+bu09vkusu+d/a?=
 =?us-ascii?Q?XyiptaKJCEXF+8QuqYbalG7xpsABinxQ12Guhruck3bpPl5gXqJP0ytjYO0J?=
 =?us-ascii?Q?b+Td+syZo0dQ0qvLqywEnNdeVaaFTYgnwiKzCnkv2ecGF29VZ/gWrg1sGu1z?=
 =?us-ascii?Q?L8jfmmDIBBE75YADgBScvI/9NQrficO0nAMgSsJhyXpdIueqWvmkSkRPOdQ1?=
 =?us-ascii?Q?cgcXcuMeHKYob2kndtWrZ9N7YMkZxz0tgpahRk9wXUFlMHxpabIEkG65gHzL?=
 =?us-ascii?Q?i/MNUIvRGq+7D2iQWQDyvJ+JGYnBFNV9AwMoIj7Nu/qvYx+MmsbvquWgdxNl?=
 =?us-ascii?Q?GHB08SiR8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de49b858-bc9d-4757-f392-08df2b59b300
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:47:16.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udbYeMNERJVtTmiOJX7JSxfK1OQLArr0sgdM5zW9boiTC8zTEyuJFpRqE3vNtf/SKLKx4mxLwuh3YiC/HCNAYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

On Mon, Oct 12, 2026 at 11:42:35PM +0300, Andy Shevchenko wrote:
> Please, read Submitting Patches on the backtraces in the commit messages
> and act accordingly.

Will do. In v2 the traces in patches 1, 2, 3 and 5 are cut down to the
warning and the frames that matter, without offsets, hex dumps and the
syscall entry.

Thanks for the review of the whole series.

Adrian
