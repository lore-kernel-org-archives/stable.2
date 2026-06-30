Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012001.outbound.protection.outlook.com [40.93.195.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD353E0081;
	Tue, 30 Jun 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845993; cv=fail; b=EcCGniMv64HKKEKww97tBIEzNZBFTkzpXcNHXyfBNFKIXWtDNGWz7Oo4Ac5HelNrLhtB6n52D+cbEkaOghRuulX1KjrKblunwoJrqEIXYxktY+/qNakMoakFFAKQIe3+HqiW2KarWKQcTdYTGFDD4SRm2nhIt54Ia2qx8z+gAgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845993; c=relaxed/simple;
	bh=oPNT1cn/Ia92zXcP0ap/OJhh8ztB7DkJF4MjP1oISsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FNsyj88vzpwsSCjrKX0UqAxMf1nquars8+X1XoBTpkU72OS9yGL9xxuC5zLb+qNHLE+4mCPdmESVk/XTtCKje3MstHVGjG0/1MU7HtDVHADMJwaDRIDIdvFsHiuPHjhHLClf+kyB4cQgbfnU8QL1lmP7jfZTWe+ZNJBXZBOHa08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LhKjP8Z8; arc=fail smtp.client-ip=40.93.195.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LhKjP8Z8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUYR9pF88s2fad2Opwm7JahtTSwb4vmE/rIuT3OxrA/Iv7obs+1oNdD5mllqsJ6fYP85Whm5pvsyblTbA3bYGwpKvMgLhf5GT3tY8z7aTmFTem+5I0lLILruEQlmI6bGUdwLLmUjmfqi9c3J8MHLCASOs+4vgKXDVnjZrFWP+u5eecSZwTaIEVuUckLj3/u6RCHZSy0ZiFeAiUBuJ5RHYgN/5JFqoG5VsKVVgY//BPKDV1LhMEMZIRPfNMNT8zXa+nbEQUch2ouQMWxaEToyXSs8XymdkHQPLWEyuRFExx5wcuHq59RME5a69lq3++FZeghJ5yKI4bLqOpTbgiR9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A37fpP8a/Esig877/T+Ij9rwOTSjdyQcNgc5uchzyo=;
 b=YYs1S/PyIXeUfUifCzSwjvZq3bPIE/ccSTwlxTgCNkqpLe6Ry2V1/5X1Usn6Wln8jOurFgT6kvZNAoGqENo7bJ4JgbxcawEGbMviUPggKbcem8T0CByESoKEM9+WB0blh2Ic1URxZIBdZEHNGkW1dLKKlfMC6QdTAvmmgdEJNzmoQhQq0Q3KIBzgNFXdJBFp9MUsE9cAG1mXorFCvMlJlksfg1ghxJ7Y2eUiHCOQX1GRlKDLsZalXtPgAvKB0vTCe1/bKsRMsGsaOUybpFs6HA4RDuItAzVK3D2BkvdL4zLO6c8oOZb6jbJUKrYYLTXYKTaSdAJNA2WPiKuXgjWVIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A37fpP8a/Esig877/T+Ij9rwOTSjdyQcNgc5uchzyo=;
 b=LhKjP8Z8yb3/+zG5JoJxNJ6b3g/a4ePuyajU7h1ZR3lE7lrEzU0H9xLRe9e/IMddrzTZtIfrsh2IfQiSlArfCsSkrLKjC1cY4kJval5Ysqu3cgqQYYEtsLejJzlIsO0nCUFf2tGNqEg+DaWxcoJi5rSe323OOu97yY5s9JbrdoQ8rMz/mjV4IkGMUvZPX0JskV10zzi27d41pJph946yBpSS8+VZy8zFxvHpNYO7NXU9ElvkW0d6LgVyNt2uDfPDMB2j+MThdF0vzkXiQY6TJgVXffKih8UAjhi7V0NrtprNj9ipdsGurvvCBsy9bQeFAbSorqSkhjyaUxyDr8syzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 18:59:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 18:59:43 +0000
Date: Tue, 30 Jun 2026 15:59:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260630185942.GF7481@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
 <akPB6l-fuJUcg4a2@google.com>
 <akPX_N0P2EcI_jbV@google.com>
 <akPhuF9pAWaBXzpi@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPhuF9pAWaBXzpi@google.com>
X-ClientProxiedBy: LV3P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9a424c-90a8-454d-7091-08ded6d9bed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	geCQsOewvmoGuE73zKGGYv9d/RSRekl9lW+2pA7QDzl/pFqu4tjT3i/FD/ncmuyx288CKyFHLxe/Iny8GKE7GFjwTqKjc8ebbEgQ+sRwKC9M/mOFXIRQwSuJtffL3ghRf52KJ4A3Oyy/kvTLoGq5aleZA2wf8xFT7DgzgQkteXztI/oCEpQQjC8XAh0Wb5CkLO5i9o0EukiaCjumO5RtUOKGXb9f5OeadIsdwoE1lMZolGOS2Ln/fnGeV68vRobkFl5YeLpmDJY7B7vDihXkS4seoPZwYFtNuWAv7oVpYY4xe98pCVuovr052Czg2xI6QQJBKmx/WxwGYZiremCcHY9dwckC/UA5kwKoKm9zTj4f5vB7whMcXaqe/eyqVrmMMMiDVNERDzZ89xKY8Cb+DJ0dDKhwIZMhuO+TujlEa5GeHlt9FH9WSl6b+bnoapCp03WCX/9jAFtdqe1/o9LB0w+jVN2xj1aWpxuPJNUwbjqWyLhx9FSRQ4nVLayfl58LZwO3UQua7pXvk+UTsdpdYXxGAVcGowCaBpheDKy5c8nH5a40Y/HL/eboKz6RRD8zica6rgQ50AUgq15EL/4ylMSRxlsum4bsMoEdVhNMDLjuKjTk2k2UlUFmqHGC2cW+QOYRB9rioxJhXARHItoY33075+64Mnbmp1FjdPKnpHc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vYmOey6r09Bf2br3tAWBQKBSzwDiNOZ7m8rBx2Nk+44vLBBsM6CtR+E1OGRC?=
 =?us-ascii?Q?GGurouvWRgWug7Se5yM2b/aLQQqRWqs2wbiMkyMIapoq+yQL8Wy6zc0BNMqS?=
 =?us-ascii?Q?4wp2XPJ37bk4z6b9zMjg1dlqtX/9/FbByUbIHNo97GUFLH3KihubPWZwOQD2?=
 =?us-ascii?Q?ljLD1XOkhmbfwKYYlpj2SoDNDbB/bYX5rEa+rKjALDhrdMpEISFZEuuhL6HE?=
 =?us-ascii?Q?KH+BsMJpMy/Ax9y5E6yLlIhaSG1rLLGFA37CYfdxt9JV1H3SOYITh5qCxB1p?=
 =?us-ascii?Q?DsUt8nN1DGEK/ceEozvwkdIA5Y7GXLjy8hff7zlzQK77Voz8+P++hoecfHao?=
 =?us-ascii?Q?CBjgVNY5AZjZ1JY6meFOVyNv8AoLUQbUfhEKvhbM6oRa1ICWasp5ICrWN0LK?=
 =?us-ascii?Q?kbrEk5GwQgVmo8Weav9y9Bc51kk91WTGlYiSmwcnR91Q5swtKxHU5rRuY9iS?=
 =?us-ascii?Q?GH6AoN+Xjv32buuV6gbmMvFVslSqL4GEXV9J21MPT4OisddpumUa2WZ8W7MU?=
 =?us-ascii?Q?UsPtFfA6ZzteOgERD3dHh32QYzCgB4z0BNeNXRsRxrryd4yRwEeufVheKJNU?=
 =?us-ascii?Q?JxUMo0TJdXthTZ9ZRX/mRPJRekkt9VDNRPwnyM04aoNwBwIeSX4Vdb1Zg3v5?=
 =?us-ascii?Q?qx95g1FBHSbLqEZBkjlaTXUlM2CKCM3QGRHGc1AqMRS6aB/wu4DUw32fsXxA?=
 =?us-ascii?Q?eRHLklnYucug70IIb/vs8408maJ+sfI49PsRK1jayjtz2vXCpaxYxmZx98jI?=
 =?us-ascii?Q?cHSENk9N6u21/wYfI3T91yRek0Vyh0Epj6p7Wil8uS6VSJeV9+QYWuk5Ah85?=
 =?us-ascii?Q?6agSiP507KCvuDoRF0wJWkuwJg/aSnTdedcow6Oesk1bjVTWGws2PPv0CCtH?=
 =?us-ascii?Q?V4FjmEQ5g/kNlFfqPRN7Uq+hzRhtiZtPMk778snGHoExls10RTBa1eQEwvJI?=
 =?us-ascii?Q?M7E9Pml7svJcYmUIMrkvOYVFloE5n3eSG6uDEwv7ekacswMKmgFaBsqw6UYB?=
 =?us-ascii?Q?kKmeTD4hY9EaLqaRzcFmSqA1EX2lT3k7PFckXtSN8Dd9c+7kWf11QVmDLzp9?=
 =?us-ascii?Q?1iFJpeI9MTVii81Ni3QLozFTkklkXKCM44A+gWKWcl8RdQvWWU6aCmdgrsIT?=
 =?us-ascii?Q?WTosc6vvieZ9w8EDl7IQhxsIx/pBx/FzBKcplTlOG1DSFcwRaZQM6E9uV5pw?=
 =?us-ascii?Q?Jgk0uHp33VtujthwZBGYw7DGAFj6T1prwNLgjrquZSVsKRVp6Uak85qnwDkU?=
 =?us-ascii?Q?u5+PxyJgnhrN8F4oBWEYiX/0O9mNyawy6sP+pfP5rv+/cNqL6zryPMisRJDP?=
 =?us-ascii?Q?PYMUDPzvKnfed4CxcoZ66Bo9bLFYSwvVydz4YEPZmvwTeqCX6vitTZEs7Ghc?=
 =?us-ascii?Q?l6mY+mXkioTQEhCPcgOWJVY9XCXDaHZQQ28C68wH6ZAoiPvpwy42t2A0ICFK?=
 =?us-ascii?Q?poY/02f/ScWRsOQaEmHWYhuItGAhTor7bHQBMqft1jkAogCr9ilOlCVVWFkj?=
 =?us-ascii?Q?L7TBmqyIvYUjGvZ053flmyfd8/iZaLb12vHNG16BCMAkMb8cpDSkyVSZOomq?=
 =?us-ascii?Q?xEk/Aoyj4fwsuZ4fCcG85xB9YvwDTT4ewASkKxKrOFqtFx+EG8P/dsyrvwQc?=
 =?us-ascii?Q?ZU/CTu39r7/F1ShGNDLug0wLfZI4ATyI7R81MXZEkkzCFnOye04FEM7dKhGv?=
 =?us-ascii?Q?z+RHu4f/q7FtabEBUxZnLedrYiVvpO0pUJh5P/XzVNDRGJ83?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9a424c-90a8-454d-7091-08ded6d9bed2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:59:43.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9FiyiDFVq5KgD/vE62fA7gfTBcTGac8Gvubk87rMonpnRqQv0BbxfFd/eROPjeg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

On Tue, Jun 30, 2026 at 03:33:12PM +0000, Mostafa Saleh wrote:

> For example patch#1 verifies log2size and split and both are read
> from HW registers. Same for the base address or other addresses as
> the page tables, they  might be corrupted due to a buggy driver.
> My point is that, it is really hard to assume that the previous state
> of registers/STE/page-tables were valid or even consistent, when the
> kernel crashed and did not transition the state gracefully.

Sure, and this mechanism is probably not very useful for debugging
these kinds of errors in the SMMU driver. Oh well, that isn't a common
source of kernel crashes :)
 
> Similarly for TLBs, the kernel might have panicked in the middle of an
> unmap or free domain. (not to mention what that means for RPM where
> a device reset with unknown TLBs)

TLB is fine. kdump works by carving out a chunk of memory for the
future crash kernel. When the kernel boots it ignores all the memory
used by the prior kernel. So DMA can keep running into the old kernels
memory with no issue. It doesn't matter if the TLBs are inconsistent or
not.

Jason
