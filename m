Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD0192D8A;
	Wed,  1 Jul 2026 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865526; cv=fail; b=smOvuNpYfWohYTp44z7UcVw4ZCmNLriiuthDI8kJZ+1LW3VFgoB7Q2MEtuOtjdPejmr893yPwS/uhTweCFss+rMIs8J3CwfxKUwKA1tVGmb929S4iHhb13RgKbWdOlVfL0/55VANEpiYEVySCs/WApoAj+SG716zoeuwXQrhQ1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865526; c=relaxed/simple;
	bh=uMW1aaOH59PjbF7asuNwZmWdK0IyWfhr/T1u7v6RXi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QadL5tNRBhyP6ej7OT/NvUsBEpY9xJ9PzJKDrRDg9N+WzJ+IgDNi7cei1+yey8F+UFCplDuklvl10W577V7nKcStqENsDuTMwZW/l2Fuq6GK3UFH9L3X9VtCJkDvwqUDkUnI+Z8WbUwjc6o8295YC9adfooTxwh1+VSP2k8vEoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1plgWz3; arc=fail smtp.client-ip=40.107.208.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1plgWz3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CG/bwsCk4Fkrrfe4ygkHaL/9g1qwlpN+y/Y8GtQyxredlYQeElK0y3Dzd1TEVfEwRxip690ksINmwUHIxWRSVMFMY/kN5f6bW3KVmdzTtVwFwe6Cy4t96pSjNB0XEJJyOhfvlfyx0RR0aiVanBoikfX5W16Y0HTdwXN/IdyEfLCdaFSpa/zEXK7c3AvNBbeynVAIjDtsfxGJ5BG/UhMEg/dmP9PgJ6/POBPW9Fy8pGREoNb4xT4KnpPfk5TBQkwTiifr31pPF00Y3iyZFoDypzyfY9lcmVTPNpP6Le4LjJw+fs2+D9LckTZkKocN0yRsXpM87Qz6H/oILHWyZ4OcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcq2bRy/ugTCK6dtBaAYpbBBW1xLB+JpPbQxN5k1aMc=;
 b=PJQ/3eTFbCARuuLI5E+7+7pgrhH4QMpuwtBfWFiDFmgFHYReogt2nw7XOgRWh2zyVAvQbZYaP7HW2/vGf+GdZB9EPwNivGjOiofSftJcoFHJAnBW6B1VR6HqMHNfcMVJrcdlMDiPP+yUILl5o8Mnfh3v+ktTQ8W0pL49N7UP9jFKadH2MjNIzDFpNxpUcKZiUQhVZMVgBjMUpz+IKYVokTc91T0b8qeztoWJHU8uytGtnAjW/i3rcBukH3O5N93CB9bizAW9p0yWB6mUku+hNnzF06+BaPGskJljAaGyvL7N1aaI+GXFxyKgTikmMuLir1FD5urgu0l3RbfhYqrXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcq2bRy/ugTCK6dtBaAYpbBBW1xLB+JpPbQxN5k1aMc=;
 b=B1plgWz35R1JpghG1O+q/EXFd0LqwMtqCwi2j3rudS3GBnDQ5v4Qo8cy8XhprX1pVlZ3jidoG700xJhTE95V1ie6jrX6IKqob16+rIU1loczdQ75W/SWaVRL4/EL4N70BJSwG/CB+Kehl8emUa0e4xP2M9GSRYTU9phlrvtJQCTTaOMTjo4mS9Zr2YWhLEyewElyCt1R63k68mtVXZJNgbIzxGN48P0HGsEL5I/DLA2Ki6Iej4RNm+rcYFtLOsgKCg3KjEJ+hBLRmbPN8S1MjALS4olUOs7QUq7UJ1vaZwExLFeQeGOwBfNvulscOVFQHTJS3yYFJ6DhfFfmUF07mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 00:25:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 00:25:18 +0000
Date: Tue, 30 Jun 2026 21:25:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260701002517.GJ7481@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
 <akQLURkLA-bZ9dAk@google.com>
 <20260630190819.GG7481@nvidia.com>
 <akQYCgLWv4fs7GAg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akQYCgLWv4fs7GAg@nvidia.com>
X-ClientProxiedBy: IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 750e321e-6d4e-4df4-79ac-08ded7073ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9ohcUHQ3W0c7WzTE8h+5f6jgBpMDExEC2FZUVYEMooXEf4SwUZliZJv3vVCDSUdExkxtRgQEdpjnTrW2SmjAjusO9X5J/qfaTImi92AAAgBShAvRtuOlKQ1JRmwv8gbidZ11Bvxt6hDg1t7k/I0GqK9TnDrz93hg+cSsN/LZxy8EgI0VxXRrUzaIEtuL/Wk+TX3VTeY8lQKV2JG2JfVTPsCP0BBjKWuXdPuHKxA7lFKpetpxJqbTX44g+sCVK5ffrCiZDCwY+6pWaTlac+FCy+ZOmbKwUJ+AB5uhDEsbsKAgtrXCj2E0IuV63TAe+KRmABnJJhek3LI4164z9YW1nGIZ+Q8qyhoarFuGseVwADHDuMOZLbWsI+Aj5F+aMrHJQc3kX01n6QPrc4AycG4yMtmEdaKrH4IcNpLmRSeA5jcVMR9e+wcNh3B57Kb0nHyCnuY+fuFlLPpwg5j4Hji3zojL8aMKAGTrXxOxTvOr9hr+YnBznCNUnkOM/HhZmmTjnC3F4lDT6xPj759ST7A6wrn5jnp5R1+2PsYhV+u/6aO6eama6kop76wqMMEl4agGTI9EiKYs42Ky+BOKLp7ejbl1XQ3T16HdcO+q5l4VSUEC/v3mKSVjmjYeCXBBf/a09s8y3HYaOzW4B2lPqX5yssz7ph+JGvw4HQ2YHExXty8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DbtvWGQHwPN8upXt3fnprL6++R1k3+QW7VEKCQrITqkDJCI6omTBGG2Gflv?=
 =?us-ascii?Q?pJHbdFInlJRV0h1TMS3QiAILQR7U21h/Iru0M9Sk66ESgB7v5gZPE+QfcFTO?=
 =?us-ascii?Q?gdgMkDkG90JBm8fl9dCpKcHKJ3XRIz7proNf00z607CQojd1daCiHyHs3oSO?=
 =?us-ascii?Q?akJGyNCVTMDpCLYiZ7JfdIGYXiO1T8kiCPCdYNO0ve9tXqler6LAXHNkG2/G?=
 =?us-ascii?Q?/Ytcm04L4IhVG5CeTQM4aTO9X3BQo0xdjRWN3m80b8AzLURGJp8ebWaAHyHz?=
 =?us-ascii?Q?2bYbwxO/t5c8NSGjeBPl0uvzd49FmOun3xu4hThHbyHl2xunDZqj7bsohVT2?=
 =?us-ascii?Q?2xFJWQJ7HPSHWYgvjPIb6vqfla4goOG7Ht44710ozDAsnukbLgsquwSF2nXZ?=
 =?us-ascii?Q?nsslOLb707QiHilMlDxKDC0wr/nQp8A6YBTScCDMczFcMqcP2i+YBgs90na/?=
 =?us-ascii?Q?wHwWLIy3ou8dwD5LbqW6Dg7kLiAmP409pDsljsKx7eTAWKhSyEcbuKGnGRXr?=
 =?us-ascii?Q?YGY8tkCyZNMrys9cnf3jHXFNThE5SuxNj9qZ8cdhVvGYXMwjJcjwvzbQlbOs?=
 =?us-ascii?Q?oXHQ6aP+l1o/69LveapZz60TZHYLBhEX6GKm2I0gGqfKMSIWHIzYqoRPZXQb?=
 =?us-ascii?Q?Att3awkR3+UP4QUt6De5OLm0TrDzsaZPgA5uFg33KwAAcvUeIvJ0jH1mAWRS?=
 =?us-ascii?Q?zLBUxG0v9EpMo+CwH5lcmz+BL1IcELEsWVQxH6fqZlxMBCKFuWNACUp3r3Jo?=
 =?us-ascii?Q?INLyyVICqo6hM09tcTBlMv5/0jKMJwRZOQme2hNrxkPzG/UJwvNx1uVzJGn+?=
 =?us-ascii?Q?EW5jO2SNhcaatEd9NYScgh/+F1/w8p3SOnd8D/shV9PG5s2UwpmFEetJRdGu?=
 =?us-ascii?Q?WEhEa73YRMbNfaHn1gN8MplkAyshmRLPnMK0rsMVq7kFAmFX3tAyuZuMrdtS?=
 =?us-ascii?Q?qUXWdX3y7SF3GRWvKqS2Bq1rYI2iu2QXT+d5nZHiohF6cPYwxCUv6EDjLTtB?=
 =?us-ascii?Q?9nuYBaLATjtW6NZIPPyfLXDArDkQKfDDnYIORsvO346gzU+VZg6pdsodxaMW?=
 =?us-ascii?Q?MH2UzIQQbgGU3FgTBrq5TqJIt5+ZITnATcrr67yKkbTpATjU6fox0H6kjEO5?=
 =?us-ascii?Q?EMu1OGMVq5tWKF2LFqGht8wwcBSbm/emi39fTYbPytNWTxEiqUUMv1hGprE1?=
 =?us-ascii?Q?A8YWcOymmMZ4iePoL5cS2/VBoP9ctozl2uvsdnE4VxBW+BeRkivLCL+g7PWp?=
 =?us-ascii?Q?Re5ATE4Fv7dF8xDTBmI8AiPgvfnTMZK7PllvkCsiISLhAPsj3xjr5VmsaApl?=
 =?us-ascii?Q?Uv3rDH6A0TC97UXjLtykCrIJzzlX6juRdL9qpMjycU+N95sm5swKNZUdLhNn?=
 =?us-ascii?Q?bVBFlufiUqW81mR0PWX8bJJaHXehhgfwECFFeYmXJQ/guXGsvVpG29f0F9na?=
 =?us-ascii?Q?lsRrqXyHVCTVt6bnaSaUCgeUYeg+Np9Xzf/b25mEbpMNiigE58T3OMqCD8D2?=
 =?us-ascii?Q?kp9oFsRM0fYgwhNF8ezYDgq+ee6V3b5KsWtf8ta6QAmM11HVWpTPqUAIhqsK?=
 =?us-ascii?Q?QSJTXov0BvzVi+ItDoeTdZY1aHeeS5HlQL5AVKzrU7gjXXJ4W8Lh6vQdoEzj?=
 =?us-ascii?Q?YfvvnEBolkrj6AOSriYGlFK2tLkpZmDYwQwPrcdZ1plyo43XIKb076HFFq95?=
 =?us-ascii?Q?zhdp5evzPZj+yyU/cz1I1jYXlSuApZCkiPzz2Ur5ORMfIkq6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750e321e-6d4e-4df4-79ac-08ded7073ae8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:25:18.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdtAbt/ly9BCGno4/LXhz9HCrKz7RaGRAcxGKrDHXp2jQW/ltnANcUt0J6c2YK57
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

On Tue, Jun 30, 2026 at 12:24:58PM -0700, Nicolin Chen wrote:
> > I don't know exactly the sequence of events that lead up to the kdump
> > kernel crashing (I imagine it is hard to debug that one), but it is
> > something related to the new kernel not participating in the RAS and
> > the RAS flow escalating to something fatal.
> 
> Here is the original bug report:
>  - kernel boots into a crash kernel
>  - crash kernel hits OOM do to insufficient reserved memory and
>    panics
>  - PCIe errors are observed during this failure flow

Maybe the RAS events hits some bugs and OOMs the kdump kernel?

Regardless more general cases like CXL are still things where you
don't want to cause unexpected ATS failures..

Jason
