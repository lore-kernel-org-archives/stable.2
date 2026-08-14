Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B43EB0E6;
	Fri, 14 Aug 2026 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745470; cv=fail; b=YHO49IC1PgjblDDs6mfpx7aqW9I5fX7AufVUtcGPhpxlFHBp5tHgY4ls9oc527e1mhHnoh2B8yZX8b3AmgKtEgaqzBrRrGX+0v9PmWRELU8c/nCt0VaxcZg+6+kCwK7Wi2s0YmvKBVbFQVQwQRUrLjMEAJxeE9N0s3N/Wg/OQic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745470; c=relaxed/simple;
	bh=RMwFtw7hgheOCXrcoaIxu3thJQdkmoYR1BrsWbHHdYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pX+OxdyO0RrUi1jfIlwbv+LDkYM5uMMEWLDNuH5TJuWjNDrFy8UTA5Lor6G3POz2JrkEj7OzrcW6o5Hqaxniop+MXrdblAAjddE5so/POPa8z1lzIQJsubjkfYxDOMtrS8DQ2Lvk1BZ9N0SQf/KeS7ARF2EVtR0WKbGbCVz/kV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olUxSrIR; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olUxSrIR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEscXBKHErOtgRB5wE+mWhgi9oKBUuYPDgTg28JiwUUjRp+ZO6879P8OuRQft4F7FnPmb0T0xh8ZA6UQds+QTZNOtvZbdKRce01gN8ZnhI+GLaYoRtzDpIWcBKWQGTc8pzYFRs1cEelU620uzUqixuzeTwS0/etYkNHGVg9t8nHZp3DweaktVv58K/hYeHr+hCU5xnMY7No9JqObG5A+DQFdpQsmE4LfW4xNW02waZkVcRf769Hf5eoBygZq3COdkgEN3sUcGxtxANAT9f9OsOSOq0KSnC8MqJs4v+hZDaIZ4r6LzLEZF5GWEWPUx5PXWle93SsaIXoPXpAT8DHjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwHX4Ts3uLdf6T56DrjZjdj7obPT5nCrX1tAZNkzLiQ=;
 b=G44BfXzpRqm0rfH3nRDLaoFKQfXbFLSifk59rgfS53iSLsA8jnDZgrDyeolCiIBT4HUtpOVkC2nZujELTnr62pJn6EAyLEu2TDG7cOjxSpJYDn3rRQAtOl/eBU9VBMQ57mzeEx8cucryQU8J8FsqDn1zx++AlNlCi90qcJFSNkWpRohye/V94ya2QGP2JVmTUthXiTfd5lUIHM93rYeFI0cjc+ehU2q0BTPMJnPWSevsiZFOC61LszsSsA2I0TO20SKWjLpphTcFz6IcLrbqE6mr8PnRFsO7tFS4GyPBqDyCAMCqrae4923yqXPe4wpcoWuJO7zBy3xu/MUbkJ3TsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwHX4Ts3uLdf6T56DrjZjdj7obPT5nCrX1tAZNkzLiQ=;
 b=olUxSrIR3FKSw/u60ZwflcGP/sx0wwHWdS66XTBUR6YD7eDL7uT5Clm37ugzcdveudLWyKI+7eRUmKnVJ52N0mQlqIXPlwViCAOmjxadI0zXuxLP1uB4XBnQbngLdnqxh4kRLjLkPgX4YnbxLbQnOwgrqIE7wK8hoMgI7w0CFVdMqomTCzfagp4FdBiMlJSLfrWZWyaVrar8DJZgq6TWLxtjkGmNQSQWh+m22OOmrCZeXQZX81t28ytdMjLcBkyyQCh7W9uKuJnLuwObGE/+CUeh2PuHdyvwj4Na64ibKv8tKS6cbZM+uxpGU2V8zdFPviOrT9nXhnHcKLa4AuTrUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4232.namprd12.prod.outlook.com (2603:10b6:610:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 22:11:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 22:11:04 +0000
Date: Fri, 14 Aug 2026 19:11:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <20260814221103.GE510472@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:208:23c::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4232:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afdd56f-a1f8-44aa-4d33-08defa50eec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	VEVD+7XsUTuPiKkSw+8E3Q/4kxz+t38uWy1+XjeaaYTJiYnfoAFdW/FGwg/o+awwXQo0fndtoi0P1FDH6v+C2XW4WyK1cocnevAQTYtQHC6nnysFMWSax5XQtafyfS0O8XgZ48YE1npQJ9XgDfkjG75HN9BpxlolL5D0uO4pktskUAXyOClfCcWkoFt63RlZmiljAVV8rB7/eNKE3Q1f+grSMLYEXEbKVREmRD/itiqQkD463ayNwpDCKYpaChNPGUH0jHeUp9qXabMbB4Ietl/WdQ2jRDNyI5uLMo5yJ8kmjBHyxG9bHU5lFyHiF2IcFK4jm/rkw5mbwO0m0sipyrNlJCXB5xLwt7TnM423XxBtIHgugfDYlJfZWVr0mLcDlFoEIa7/alLAcpoLh3D1xqq7e6xSsd8ls/jW4j55+po7dFmOuiWWoOeqMR9G9ue8WeSt4zDwSwcRbfgDdugUY10UM0OrEmKvGfLXa4n9A/iFWsX+s/B8uf5uCq2KjJokF0BdLMj7OjjNJZoD/uNwIg4w65OAnIgOXA9CxvgPM94OTuwFkFXZfKdFMbDKZE9rW6q2mzC10izfm9BKsob0EE/vaw1rKwWfx51ot+dLO/KwVQZy6pWNOxnStLuBFsRmTCKVeJBfpbgJBmcTayia5nYO0R22Nk2BdwOXdaXxN3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M89JRlzUgKQul31cjSqKyNSvna+li1xICjLZ6cg7DetDpZM6HHDmPM3Ku5QU?=
 =?us-ascii?Q?vMdZtiILW42kx0c2aQwxtbE5wmCcoGoalxRWPvcrE0DWhbmqpSKNvcfPtwx9?=
 =?us-ascii?Q?WNtHShA+8ymHpFOJ5M9urK3HSeYobSzZrii/k7+LcReUizyeKYzoDPqOr6vQ?=
 =?us-ascii?Q?6Us9sDGSgko9wire6JwEByxSKJK3Gif19LMohpEfIr7WpAJVKGUWgLga/hez?=
 =?us-ascii?Q?p99lBldO5lWBv+s50dz7cotY7wIMrlymi2RtvYoWIu5CZFBxmeEIt3NBzVhp?=
 =?us-ascii?Q?yD3eAVaAuW35M4goq4Lbsbo8zrdVUqRGZVgeOBJjVw8hakUharQ+3dIaGXRP?=
 =?us-ascii?Q?IQvpSvQo9KXNPTwcnPPiLoMhPtVbc6EryYPur8M8/+EJj3CRYmDAdhnRAH80?=
 =?us-ascii?Q?L5Wy45whywFyCQ/K6wmpIlyYWK5euZjuvN69lnVJBUa89HeOJi/WmmBq0L/6?=
 =?us-ascii?Q?X8+R3xtT2/H0Q76XQ8JwmrlblgbEB5h6T8BArk5QNFi3DSDOI010IFhjGq8M?=
 =?us-ascii?Q?KUhUEoAjpQZyt73hrMt8X6/8CCD4B3HpgYC2MujnMoNhVGmzJkm7YTQQD/t3?=
 =?us-ascii?Q?KKP8GcU2LYEU6Dm+8Z1+59Vv8aPefAnOXs/bBXS9yb3/HWtXrXJ0FICCplzb?=
 =?us-ascii?Q?fubhANsNprmt5RPDaZrlItFmlp6MAAtabh/W6Adnf3bXQ9ABFJaL8fgxqc3J?=
 =?us-ascii?Q?+5sbnUVXF/7VkWRFUxKTvpT1P62pwCVB6NgRebUFtbWhA/EqeBJgVHB3Y+CE?=
 =?us-ascii?Q?rOnh9wMMz6mNmRj//IYB85h29Qh7qDI/pulsV0agHG6PqxYCIygYJuVnSSpk?=
 =?us-ascii?Q?b2p72ZW9lbFQd/6u4HgBozo0Ho6efPfyFDTYa49AhNSGfQ1Uhr/oPgV/vJXy?=
 =?us-ascii?Q?0zVqTNwYJctHtne5ftdlK1ejGsYp16ufm5QS/5nYx4kcEngbuAfTf9nkLhVA?=
 =?us-ascii?Q?roNrzaGagrHvchiOoZkg1E99zroYKpZ0vQEObj/Uwx0tj6T0i+nvGssCmFmw?=
 =?us-ascii?Q?Wx65ZZkfZMsgLUeIn0LT+GImiWJk4kQoPFLxCh1gX9idPG5Qlpd+15sJIrfC?=
 =?us-ascii?Q?H1Ok/m/hky7gjTFEawdkTb7PERXyooeVSkOSMk51nkP8UVlympd2QSsHaTe9?=
 =?us-ascii?Q?7JSh+NLsPiLz1fa6NEjuyKi9BTw8+lSdZ0u6TrfhZF1/mRrD7CGSWfQTSBVY?=
 =?us-ascii?Q?ziO7b+igok7Zuk+YTRkvQTaNum9Dfj65c6LXmwKwKHupUU1hH6eSQz5Fp1ag?=
 =?us-ascii?Q?FN5kLkBnDkcNdmkC0k5cIyo4dt8Uw06IhA6c1bhwIP2yX3mbdcLbBwG14rWb?=
 =?us-ascii?Q?uESkyk2MOHEmVGB0SD7z90qQmowTqGDnIf1GrKNiqZrA6t57FF48qVmCL2JA?=
 =?us-ascii?Q?j1rN8sHm5a/OwHZI7axBpLS1RsAQ+9H87hhqQD8+uknd1bFwyID/L4kWaY4B?=
 =?us-ascii?Q?gZUYVUi1VZL+bEKLZggBi2oAJLXrvXfwpdjpyQ8i9rFTyJTib5Z7oN6nDZlW?=
 =?us-ascii?Q?gXOa2romdS2MlZTCXs5Z4Z7DOZ5UwrM80oWtwBpNsSnPXX3GSPVJDHZJkGpD?=
 =?us-ascii?Q?C/KYiXBl3yQ3OY6VO1JXt+PKBt8ruQt/tITqLNtxjfCCL4isfXjZKg0NsGVy?=
 =?us-ascii?Q?qPwH2PRrwFl5eYvdsCDXU2hvX7KXCrsjhj0SHkqj1/ws2u5YiKmYDH1xQSE0?=
 =?us-ascii?Q?mr7lmAHUYXm/pBOXwmkW60Ut5g3lKhiqhprCFHlyC7w7wa1lYh8hnQQPK2KT?=
 =?us-ascii?Q?MG2s7UtVhA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afdd56f-a1f8-44aa-4d33-08defa50eec8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 22:11:04.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaBw8o2/goyb1kwIouhbrp14yafF9nUJVB14Q6f2PB6y2l68WL8Sd45bMQs31sll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4232

On Fri, Aug 14, 2026 at 06:56:05PM +0000, Dmitry Malkin wrote:
> Hi Jason,
> 
> > If viommu should support multi-device groups, I'm not sure. I want to
> > know why you even have multi-device groups in the first place because
> > that is not normal at all.
> 
> That is because of the 'pci=config_acs' kernel command-line
> parameter. This causes the kernel to create a single IOMMU group
> containing multiple PCIe devices, including the bridge (PCIe Root
> Port).

Don't use it that way?

If this is an nvidia system you should talk to your support team.

Jason
