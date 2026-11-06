Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987022;
	b=Tf4oJAYzanF10XljQsPs/571gEeziVSL0YxixbDTbLUf6Kes41A3Z6fKO/KhyE4m/qcl
	 PNtPeebjiGTGeOrbUrfsASnsIKKh+rX/IRWh0j1d5TpZqw8eRWH7CuA0X/RLfTnIOQAWM
	 fov2CBCeGG17X6j4iHbByEjLu2qKNspIuTU+92MwwCCPCDf+SVb0vxDIWiL05Q7oF/y+o
	 43ogskCtEk4c/IqQGfYp3u7iwBMYBDD6FFYntj/2e1m2bkb2yvA77U20cjwIhJrWprXTa
	 gIePSKMVQ5jO911FmeaHu4z411dDckzYMTfpO+YMBpaNMBUX1/ZB7X/qpf4WGZ0zFTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987022;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hhPLlf43hSxbGXoeqLOSauBXNEGYnNvjjcgPdU3ZUmI=;
	b=30GZPNPzvhqfNdd15A0+KoZ7P78I6AcMgMO6H+DvDVfOUesoKyVvyOMrWwpLC8XwWi3I
	 aq9YjfYllbiDDYwR8eFqRVmfOun9956MODsCHPCWM53AS6A7swOwYgrXOw9GbucLa3RVZ
	 FVe4tPYz/l9wNw6gzBerEsGjITym4LAvuv0sPJ7udZ1P+5aEycPeY3cx/30RD4Z3V8OLc
	 JEb5Skh3g+JpF2ECp+CPHH6h/VW7Gev3pP9dg0T71jXj6JyQ5guCAlvHEtNJWGY1xlMC7
	 vS8Ad8kCsgfCDpJUxoT+Zcyo1EPg91ZFhUMDbPELQFnsQrzxxW3tMj6WY5sSfrtF3Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TZBpG3tj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.21
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57126606A32E;
	Fri,  6 Nov 2026 17:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57126606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TZBpG3tj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPj04mqAnNy8TliGG2uawANfnOcq87uE7qgjvHHItyFSelz19AdItvnNEosrZtRAkqyODAc6DC007wp1HV9wbWaiDh8hsuFcpIO86xQkO506oC3nEGbkf7aaXLQsZCcduZF6/U2rjLT2zHVyPUy0XQnmKnPiDc3pcrGxN2aq/DPGgps1dJmwefbTyr3FUiKEXF3iXryIKU5To09D0dHvRsppYQ1e/92IQEXf8s/WbA1bdw99A5qMymit1rwTd6wowo3DChnBROESkFaz48NI5vEXPGMJgPHMJxwXpBvdGYBXdruKwsxsm7m8FM/3pvAuPU5tF5J/ukeMNgx/xIPstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhPLlf43hSxbGXoeqLOSauBXNEGYnNvjjcgPdU3ZUmI=;
 b=Rbum5aBEkML6VihWhd64hv8oYLbjgdlovIYKIpDVsZ9QAHemt1ifPzskIdZeU2YwYGvfzrmJEtjCkHcUhO9FE1lKrSvyMYCoquoEnOsaMMWuzxK3CQN3ZrzjCWxuJj2jyANhz07UV6VxBQqLH4BJeM1pnYYv3zaAcXZqqqDZMqHZt4F8BVkZhpmeH5EQpFdxOoicM7yjj9FjP9A3pJlIVXUDQMNSIPyQVTuF/pmNUEQbCpmyRNbPy8d3bvcAEXLYf7yUFU0HfD2zyvoGRinrcK2e7Lhq38gTyTkVThxgeFVHzBDpkwIsQtYNOLmZb1TnuVyU9yGhHaP03SOXdi6peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhPLlf43hSxbGXoeqLOSauBXNEGYnNvjjcgPdU3ZUmI=;
 b=TZBpG3tjCb2gmO+MKxU/plmgNF2EAMZJHAL/yevNYNJbJjcLo8Wg943kvY/O+tjwu78WR1g2tV+4MvPpZsCd8SWGHD2XfdzAATZ3lejDHnwpIR9rUAlPDkkrt/c8ob3n4qU6JI3rLga4z18M5YB7xR63X2wbDRZznUdPHEjB+9t9Zk/7TKlF0SCzfFDWKcuZv3ds94V4jsJZuCf19LIlWUNFRTRw1Hz7dp8TsHW1dfknGiFqGFJZBP3YNV9vmpSbRSlJtin7bv0ExZPjYNeLInDhecJPA3G1hLpKSxdGobDhV/LnEugKc574sqgoo5irJ6Jx2HX4/9Nsyup+v6fXJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB8777.namprd12.prod.outlook.com
 (2603:10b6:510:26b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 17:43:32 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 17:43:32 +0000
Date: Fri, 6 Nov 2026 13:43:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jennifer Chan <jenniferchan@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
Message-ID: <20261106174331.GH770409@nvidia.com>
References: <20261105201010.2297078-1-jenniferchan@meta.com>
 <20261105215148.GA1566818@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105215148.GA1566818@bhelgaas>
X-ClientProxiedBy: YT4PR01CA0502.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 70400cab-21b6-4d20-6754-08df3c2d79cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m9la8xJChdXzuLbgpsMNwT6VXKVI2Ik5ykqDMclbNjBkqDM7gjNOGSDo51M5tmagN+B6ZEkFqu2GnGla9U5AyIBvGfAy+Nmvronl8tRmoa82c5jkcKGfJbag/DC1mYBKQ4FauZgvCh/jraZ313pSkZpW83t6740isi6dZA+L9x+xyy1DlgIM9nXYJEJ4S6penRJpwPjykeWMYnOzMeQOwKP4JX3Ec6serZGWaIJh4RD6ZlM9Dj1/+n1IjyzgAOvRv5+/GFlwz7sb9zcyITlbOncdJiYwV4PZ3MPiy3Rdq3/6DMFUVfo/EB9uajQ1yDPvOu45mC/t9WcxycVHqy/DUiI1mmqs2mFqMRAj/O1UcolR/6TGcQPkLK42cJ0BR5k5+whc60NBz25PbwHMVR7al0xPfCtDfoSNBFWA1bYwOte8EIkQE39EgkDnZaR18221r0Mta5z4mrhmcLe8MWG6pG1+0yUY7pW5UuaYTfcPhFSZNyq+Vnq9DiM19snsNK2PpxhK2dF4krjZHzI3Q5ySbhHo5LK8LM2B4QUqhOeB5ECo1CH0wpRaC57e5Iht6lW+1k65iV0CiW6gG6M1+Et0TgT0JsBgvI0xp0bn0xFneT6S9cs5MuwQonA7YnlCvBx+2RFzo3FYNsul4NXbsdtr8XHV4GWkQXbBggbKrQroXqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tE+fnkY9WXLgDkuYx+tMoscb4IGsoyMPlCzZI8uMa8BPrhylhSJhhjqM5PZQ?=
 =?us-ascii?Q?C7qlc8kBRM2foC5YoUvwCHRUPrZiE8F5oZVChV3aMI6KT3rTG9hjUX8GzC4m?=
 =?us-ascii?Q?Ed5NUHs4s//5krHJ2wfp2sokzuWSMB+TqUDJntIfQ0o6G39/zlYVKHWtbZa+?=
 =?us-ascii?Q?yA63qEU/s3UaMkW6EId4e2fZk7i/9DiYbwswkhoxAgZKSIbJAaEhAJM45+Nk?=
 =?us-ascii?Q?eDj7S+CGTl2WLVrZSL30tvmfLwPcV2WXIqQqzPNRi0GzO+/sgGOm2/yg+JKa?=
 =?us-ascii?Q?tM5QOK+FVSl4kveQBI/DSgtHe3+t79DDsoQxyjpzsQYYY16VSjBp2AcAchDN?=
 =?us-ascii?Q?u99Qe/XWhT2qc3U6ksIG0GciFh82L2PK1V0s8Ui+ezFRJfg2CdzDGLYxbZ/G?=
 =?us-ascii?Q?X81ZqXGL065Ok7EEjCTeMIyMFMVkeXvYhzxBfDbaibaO4t1fP3a715MK5LCP?=
 =?us-ascii?Q?szn6hmx37sg+zDbDXArQ6W6rikQ+n8sFnCEyVEO+JW7u5d2xTG1siTWnNG4/?=
 =?us-ascii?Q?Tf8ALG/nsM13v57bDsPWfCf1sxhnGTW0IMOQogLQEuKrChTLlbyX2WwNiwt2?=
 =?us-ascii?Q?l7lBDNqVj7PlwR8cCWZxxGwzgBuxjvR4xEuU1vqoCOJ+HB6CRhGjejMtn9aN?=
 =?us-ascii?Q?g3hFOEv60HRn4HUbhFMjyhlTL9Mz2QultdsIZc37crVF5ZR48jjbIks43MWh?=
 =?us-ascii?Q?Aw9sbO/6vEW2vTLPn8qkzs5nL6W8g+kanRYcNfpfB4hecvzWYxpl5iLbIPxP?=
 =?us-ascii?Q?P8UTqbWQt6A4NFw9EUTG1o/ileh2nlsXlgtFo7dzG23PzU1vcPgvmmYQ68Ya?=
 =?us-ascii?Q?tnQ9hCu5yqxIx/2ON+W/v70+v7H/6YZ0EidW60+NV3v1QNkNJlx2Rgyx5SgN?=
 =?us-ascii?Q?fnVxGU6nQnpsQxkmKGbEMMI74UrB3D0bfKBdgP9K7UrMK/0XXssyhRlLfwfB?=
 =?us-ascii?Q?McDEnUTjTmacbDhqeWDLQ/h3aGPuKfFjxXXjGh+4ohDb+mcY4L3eEKW3hPxA?=
 =?us-ascii?Q?+IoPmoOmQss+pn9EDB2SVhii9+ZDIgLPfshHGmdRH9+yOiCZB+AWpMJnw+Mw?=
 =?us-ascii?Q?2WOIVSmfUfXPKVv1tMk5ZyQFP442bsMB2yMzspG+YmxriPuDXD1B1h3AMkkg?=
 =?us-ascii?Q?Nl6BkKHdmLuk3R3QSyGMm5g2Dh7iu9o5vt64svStuClzFASrzOzECTBl7Vgs?=
 =?us-ascii?Q?nJsU1yBOS+VAJleo9H6tJs6N19ZfT/LYObuDiDe+ZKu0esOvnR2SFeTbbav2?=
 =?us-ascii?Q?rcZx02tJQijPHJgP1zHdKMoKNA3u+6G9/1l91AjGupnF7+Pli8uyyaPb9MRv?=
 =?us-ascii?Q?D3U24fiCnx81s1Uqih/uBT13sHLMEmM1v89JmpypkashTipTA0oG85Br4XJP?=
 =?us-ascii?Q?6xOHszwSaMf6aeZnmof5NA06iJKAUwMWOSL+3pqR1ttfcFPnSMXI6BIdm4q6?=
 =?us-ascii?Q?CB6lwDq8F8aTbA689WuMx03pTPF/o6W5G4HxBTfPs0tUMRr5G9db+Hs9Et3g?=
 =?us-ascii?Q?idLVwU/KLaBrxskay02VlzJLeSyWHABn5SZIUW1QmybbVv7XASzcplBMZ+2Q?=
 =?us-ascii?Q?3KEBtqNa6QNcF4EwDXTHjQToEXl2Oxm5SH/haSLVDC+wCcghPQawYcZySBWs?=
 =?us-ascii?Q?+0+Nzp4Yo5Z6BnvgOs2q1obuzQQyDhkNLcMvpvTdEn1sx2IwfnM3Bw91lwcl?=
 =?us-ascii?Q?6nLbkrKp7PbHzhI6q72XkBMJFhjue9eYJaqndLeRyBkmEkZq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70400cab-21b6-4d20-6754-08df3c2d79cd
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:43:32.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: korBmPjeyxD7KzhBhqCpYIhgCqQE/Knj+mxDNaUnpj1UxELWXasrUlAQi2SdiD5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

On Thu, Nov 05, 2026 at 03:51:48PM -0600, Bjorn Helgaas wrote:
> [+cc Lukas, author of ac91e6980563, Jason in case NVIDIA knows
> anything]

Yeah, please don't take quirks for our server silicon unless we send
them. I've seen this a few times and rarely do users understand enough
to get this right.

Lukas is correct that many bugs trace back go Broadcom's exciting
interpretation of PCIe :\

The user should open a case with their NVIDIA support and if a kernel
quirk is in fact the correct fix the someone from NVIDIA will send
it..

Jason
